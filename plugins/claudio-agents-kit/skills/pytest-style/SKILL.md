---
name: pytest-style
description: Convenciones de tests con pytest. Invocar cuando se escriban tests unitarios o de integración en Python, o cuando se configure pytest en un proyecto nuevo.
---

# pytest — Convenciones

## Estructura

```
tests/
├── conftest.py          # fixtures compartidos
├── unit/
│   └── test_services.py
└── integration/
    └── test_endpoints.py
```

## `conftest.py` base (FastAPI + async)

```python
import pytest
import pytest_asyncio
from httpx import AsyncClient, ASGITransport
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from app.main import app
from app.db import Base, get_db

@pytest_asyncio.fixture
async def test_db():
    engine = create_async_engine("sqlite+aiosqlite:///:memory:")
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    async with AsyncSession(engine) as session:
        yield session

@pytest_asyncio.fixture
async def client(test_db):
    async def override_get_db():
        yield test_db
    app.dependency_overrides[get_db] = override_get_db
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as c:
        yield c
    app.dependency_overrides.clear()
```

## Naming

```python
def test_create_user_returns_201_with_valid_payload():
    ...

def test_create_user_returns_409_when_email_exists():
    ...

def test_create_user_returns_422_when_email_is_invalid():
    ...
```

Patrón: `test_<acción>_<resultado_esperado>_<cuándo>`.

## AAA pattern

```python
async def test_create_user_returns_201(client):
    # Arrange
    payload = {"email": "a@b.com", "name": "Ana", "password": "secret123"}

    # Act
    response = await client.post("/users/", json=payload)

    # Assert
    assert response.status_code == 201
    data = response.json()
    assert data["email"] == "a@b.com"
    assert "id" in data
```

## Parametrize para casos similares

```python
@pytest.mark.parametrize("email,expected_status", [
    ("valid@email.com", 201),
    ("invalid-email",    422),
    ("",                 422),
    (None,               422),
])
async def test_create_user_email_validation(client, email, expected_status):
    response = await client.post("/users/", json={"email": email, "name": "x", "password": "x"})
    assert response.status_code == expected_status
```

## Factories con factory-boy

```python
# tests/factories.py
import factory
from app.models.user import User

class UserFactory(factory.Factory):
    class Meta:
        model = User

    email = factory.Sequence(lambda n: f"user{n}@test.com")
    name = factory.Faker("name")
```

Uso:
```python
user = UserFactory(email="custom@test.com")
```

## Markers útiles

```python
@pytest.mark.slow
def test_heavy_etl():
    ...

# Correr solo rápidos:
# pytest -m "not slow"
```

Declarar en `pyproject.toml`:
```toml
[tool.pytest.ini_options]
markers = [
    "slow: tests que tardan más de 1s",
    "integration: tests que tocan DB real",
]
```

## Anti-patterns

- **Un test con N asserts sobre N cosas distintas.** Dividí.
- **Tests que dependen del orden.** Cada test debe poder correr aislado.
- **Mockear lo que estás testeando.** Si mockeaste la función bajo test, no estás testeando nada.
- **Datos hardcodeados mágicos** (`"test@test.com"` en 20 tests). Usá factories.
- **Sin assert.** Un `try / except` sin assert no valida nada.
