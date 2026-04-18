---
name: docstring-google-style
description: Formato Google style para docstrings en Python. Invocar cuando se documenten funciones, clases o módulos en Python.
---

# Docstrings — Google Style

## Función simple

```python
def calculate_total(prices: list[float], tax_rate: float = 0.21) -> float:
    """Calcula el total con impuesto aplicado.

    Args:
        prices: Lista de precios unitarios sin impuesto.
        tax_rate: Tasa de impuesto como decimal (0.21 = 21%). Default: 0.21.

    Returns:
        Total con impuesto aplicado, redondeado a 2 decimales.

    Raises:
        ValueError: Si algún precio es negativo.
    """
    if any(p < 0 for p in prices):
        raise ValueError("Prices cannot be negative")
    return round(sum(prices) * (1 + tax_rate), 2)
```

## Función async

```python
async def fetch_user(user_id: int, db: AsyncSession) -> User | None:
    """Recupera un usuario por ID.

    Args:
        user_id: ID del usuario.
        db: Sesión async de SQLAlchemy.

    Returns:
        Instancia de User si existe, None si no.
    """
```

## Clase

```python
class OrderService:
    """Servicio para gestión de órdenes.

    Encapsula la lógica de negocio de órdenes: creación, actualización,
    cancelación y queries. No toca HTTP, solo DB y reglas de negocio.

    Attributes:
        db: Sesión async de SQLAlchemy usada para todas las operaciones.
        cache: Cliente Redis opcional para caching de órdenes recientes.
    """

    def __init__(self, db: AsyncSession, cache: Redis | None = None):
        self.db = db
        self.cache = cache
```

## Módulo (al inicio del archivo)

```python
"""Módulo de procesamiento de ETL para inventario FarmaX.

Este módulo implementa el pipeline que:
1. Extrae inventario desde CSVs del ERP del cliente.
2. Normaliza SKUs y aplica el catálogo maestro.
3. Carga en la tabla `inventory_snapshots` de PostgreSQL.

Uso:
    python -m app.etl.farmax_inventory --date 2026-04-18

Variables de entorno requeridas:
    - DATABASE_URL
    - FARMAX_SFTP_HOST
"""
```

## Qué SÍ incluir

- Descripción en 1 línea (imperativo: "Calcula", no "Calculates")
- `Args`: cada parámetro no obvio, con tipo si ayuda
- `Returns`: qué devuelve y bajo qué condiciones
- `Raises`: excepciones que el llamador debe conocer
- Ejemplo si el uso no es obvio

## Qué NO incluir

- Tipos cuando ya están en el type hint ("Args: user_id (int)..." cuando el firm ya dice `user_id: int`)
- Descripciones que solo repiten el nombre ("Get user: gets a user")
- Historia de cambios (eso va en CHANGELOG, no en docstring)

## Ejemplos opcional

Para funciones que se van a usar mucho:

```python
def merge_dataframes_safe(left: pd.DataFrame, right: pd.DataFrame, on: str) -> pd.DataFrame:
    """Hace un merge y valida que no haya inflado filas.

    Args:
        left: DataFrame izquierdo.
        right: DataFrame derecho.
        on: Columna por la que se hace el merge.

    Returns:
        DataFrame mergeado.

    Raises:
        ValueError: Si el merge aumentó el row count (indica duplicados en right).

    Example:
        >>> orders = pd.DataFrame({"user_id": [1, 2], "amount": [100, 200]})
        >>> users = pd.DataFrame({"user_id": [1, 2], "name": ["Ana", "Bob"]})
        >>> merge_dataframes_safe(orders, users, on="user_id")
           user_id  amount  name
        0        1     100   Ana
        1        2     200   Bob
    """
```
