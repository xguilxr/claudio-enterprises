"""Template de conftest.py de referencia — claudio-agents-kit.

Copiar a `tests/conftest.py` del proyecto y adaptar los imports a los paths
reales (`app.db`, `app.main`, etc.). Este template implementa las reglas de
performance del skill `pytest-style`:

1. Engine session-scoped — `create_all` una sola vez por worker de xdist.
2. `db_session` function-scoped con SAVEPOINT (nested transaction) + rollback.
   Nunca `drop_all` per-test.
3. Mocks `autouse=True` para renderers pesados (PDF, LLM, S3, email). Tests
   que quieran ejercer el servicio real se marcan `@pytest.mark.heavy`.
4. Config rápida: BCRYPT_ROUNDS=4, JWT hardcodeado, Celery eager.
5. Compatible con `pytest -n auto --dist loadfile`.

Stack asumido: FastAPI + SQLAlchemy 2.0 async + pytest-asyncio. Si el proyecto
es sync, cambiar `AsyncSession`/`AsyncEngine` por las versiones sync.
"""

from __future__ import annotations

import os
from collections.abc import AsyncIterator, Iterator
from unittest.mock import AsyncMock, MagicMock

import pytest

# ---------------------------------------------------------------------------
# 1. Env vars de test — ANTES de importar el app, para que settings las vea.
# ---------------------------------------------------------------------------
os.environ.setdefault("ENV", "test")
os.environ.setdefault("BCRYPT_ROUNDS", "4")
os.environ.setdefault("JWT_SECRET", "test-secret-not-for-prod")
os.environ.setdefault("CELERY_TASK_ALWAYS_EAGER", "true")
os.environ.setdefault("DATABASE_URL", "sqlite+aiosqlite:///:memory:")

# Imports del app DESPUÉS de setear env vars.
import pytest_asyncio  # noqa: E402
from httpx import ASGITransport, AsyncClient  # noqa: E402
from sqlalchemy.ext.asyncio import (  # noqa: E402
    AsyncSession,
    async_sessionmaker,
    create_async_engine,
)

# Adaptar estos imports al proyecto real:
from app.db import Base, get_db  # noqa: E402
from app.main import app  # noqa: E402


# ---------------------------------------------------------------------------
# 2. Engine session-scoped + schema una sola vez por worker.
# ---------------------------------------------------------------------------
@pytest_asyncio.fixture(scope="session")
async def engine() -> AsyncIterator:
    """Un engine por worker de xdist. SQLite in-memory + StaticPool para
    compartir la DB entre connections del mismo proceso."""
    from sqlalchemy.pool import StaticPool

    eng = create_async_engine(
        "sqlite+aiosqlite:///:memory:",
        connect_args={"check_same_thread": False},
        poolclass=StaticPool,
    )
    async with eng.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield eng
    await eng.dispose()


# ---------------------------------------------------------------------------
# 3. db_session function-scoped con SAVEPOINT + rollback.
#    Cada test ve una DB "limpia" sin regenerar el schema.
# ---------------------------------------------------------------------------
@pytest_asyncio.fixture()
async def db_session(engine) -> AsyncIterator[AsyncSession]:
    connection = await engine.connect()
    trans = await connection.begin()
    session = AsyncSession(bind=connection, join_transaction_mode="create_savepoint")
    try:
        yield session
    finally:
        await session.close()
        await trans.rollback()
        await connection.close()


# ---------------------------------------------------------------------------
# 4. Client HTTP con dependency override.
# ---------------------------------------------------------------------------
@pytest_asyncio.fixture()
async def client(db_session: AsyncSession) -> AsyncIterator[AsyncClient]:
    async def _override_get_db() -> AsyncIterator[AsyncSession]:
        yield db_session

    app.dependency_overrides[get_db] = _override_get_db
    async with AsyncClient(
        transport=ASGITransport(app=app), base_url="http://test"
    ) as ac:
        yield ac
    app.dependency_overrides.clear()


# ---------------------------------------------------------------------------
# 5. Fixtures de setup compartido.
#    Devolver IDs, no objetos ORM (se detachan entre sessions).
# ---------------------------------------------------------------------------
@pytest_asyncio.fixture()
async def sample_tenant(db_session: AsyncSession) -> int:
    """Tenant base usado por la mayoría de tests."""
    from app.models.tenant import Tenant

    tenant = Tenant(name="Acme")
    db_session.add(tenant)
    await db_session.flush()
    return tenant.id


@pytest_asyncio.fixture()
async def admin_user(db_session: AsyncSession, sample_tenant: int) -> int:
    from app.models.user import User

    user = User(email="admin@acme.test", tenant_id=sample_tenant, role="admin")
    db_session.add(user)
    await db_session.flush()
    return user.id


@pytest_asyncio.fixture()
async def authed_client(client: AsyncClient, admin_user: int) -> AsyncClient:
    """Client con header Authorization ya seteado.
    Reemplazar `issue_test_token` por la función real del proyecto."""
    from app.auth import issue_test_token

    token = issue_test_token(user_id=admin_user)
    client.headers.update({"Authorization": f"Bearer {token}"})
    return client


# ---------------------------------------------------------------------------
# 6. Mocks autouse de operaciones pesadas.
#    Tests con @pytest.mark.heavy ejercen el real (corren en job aparte).
# ---------------------------------------------------------------------------
@pytest.fixture(autouse=True)
def _mock_heavy_operations(monkeypatch: pytest.MonkeyPatch, request: pytest.FixtureRequest) -> None:
    """Stubs rápidos para renderers / SDKs externos. Se saltean si el test
    tiene marker `heavy`."""
    if "heavy" in request.keywords:
        return

    # PDF rendering — devolver bytes mínimos válidos.
    monkeypatch.setattr(
        "app.pdf.render_pdf",
        lambda *a, **kw: b"%PDF-1.4 stub\n%%EOF",
        raising=False,
    )

    # LLM clients — stub de chat completion.
    fake_openai = AsyncMock()
    fake_openai.chat.completions.create = AsyncMock(
        return_value=MagicMock(
            choices=[MagicMock(message=MagicMock(content="stub response"))]
        )
    )
    monkeypatch.setattr("app.llm.openai_client", fake_openai, raising=False)

    fake_anthropic = AsyncMock()
    fake_anthropic.messages.create = AsyncMock(
        return_value=MagicMock(content=[MagicMock(text="stub response")])
    )
    monkeypatch.setattr("app.llm.anthropic_client", fake_anthropic, raising=False)

    # S3 / cloud storage.
    fake_s3 = MagicMock()
    fake_s3.upload_fileobj = MagicMock(return_value=None)
    fake_s3.generate_presigned_url = MagicMock(return_value="https://s3.test/stub")
    monkeypatch.setattr("app.storage.s3_client", fake_s3, raising=False)

    # Email — capturar, no enviar.
    sent_emails: list[dict] = []
    monkeypatch.setattr(
        "app.email.send_email",
        lambda **kw: sent_emails.append(kw),
        raising=False,
    )
    monkeypatch.setattr("app.email.sent_emails", sent_emails, raising=False)


@pytest.fixture(autouse=True)
def _fast_asyncio_sleep(monkeypatch: pytest.MonkeyPatch, request: pytest.FixtureRequest) -> None:
    """No real sleeps en tests. Tests que prueban timeouts deben usar
    freezegun o marcarse `heavy`."""
    if "heavy" in request.keywords:
        return

    async def _noop(_seconds: float) -> None:
        return None

    monkeypatch.setattr("asyncio.sleep", _noop)


# ---------------------------------------------------------------------------
# 7. Config de pytest-asyncio (mode=auto para no anotar cada test).
#    Descomentar si no está en pyproject.toml.
# ---------------------------------------------------------------------------
# def pytest_collection_modifyitems(config, items):
#     for item in items:
#         if "asyncio" not in item.keywords and item.get_closest_marker("asyncio") is None:
#             item.add_marker(pytest.mark.asyncio)
