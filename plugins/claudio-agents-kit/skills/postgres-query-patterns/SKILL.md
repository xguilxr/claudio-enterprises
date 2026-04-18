---
name: postgres-query-patterns
description: Patrones de queries eficientes en PostgreSQL. Invocar cuando se escriba SQL, se diseñe un query para endpoint, o se investigue performance de DB.
---

# PostgreSQL — Patrones de Queries

## Reglas base

1. **Nunca `SELECT *`** en código de producción.
2. **Siempre `EXPLAIN ANALYZE`** queries críticas antes de mergear.
3. **Índices en FKs siempre.** Postgres no los crea solo.
4. **Parametrizado siempre.** Nunca concatenar strings.

## Patrones útiles

### Window functions en vez de subqueries

```sql
-- MAL (subquery por fila)
SELECT o.*,
  (SELECT COUNT(*) FROM orders o2 WHERE o2.user_id = o.user_id) AS user_total
FROM orders o;

-- BIEN
SELECT o.*,
  COUNT(*) OVER (PARTITION BY user_id) AS user_total
FROM orders o;
```

### CTE para legibilidad (pero cuidado con performance)

```sql
WITH active_users AS (
  SELECT id FROM users WHERE active = true
),
recent_orders AS (
  SELECT * FROM orders
  WHERE created_at > NOW() - INTERVAL '30 days'
)
SELECT au.id, COUNT(ro.id) AS order_count
FROM active_users au
LEFT JOIN recent_orders ro ON ro.user_id = au.id
GROUP BY au.id;
```

Nota: en Postgres < 12, los CTEs eran "fence" (impedían optimización). Desde 12, son inlineables. Seguí midiendo.

### Paginación con keyset (cursor) en vez de OFFSET

```sql
-- MAL (OFFSET 100000 es lento)
SELECT * FROM orders
ORDER BY id DESC
LIMIT 20 OFFSET 100000;

-- BIEN (keyset pagination)
SELECT * FROM orders
WHERE id < :last_seen_id
ORDER BY id DESC
LIMIT 20;
```

### UPSERT con ON CONFLICT

```sql
INSERT INTO users (email, name)
VALUES ('a@b.com', 'Ana')
ON CONFLICT (email)
DO UPDATE SET name = EXCLUDED.name, updated_at = NOW();
```

### Búsqueda por texto: usar GIN + trigram

```sql
CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE INDEX idx_users_name_trgm
ON users USING GIN (name gin_trgm_ops);

-- Ahora ILIKE es rápido
SELECT * FROM users WHERE name ILIKE '%anna%';
```

## Índices

### Composite: orden importa

```sql
-- Si las queries siempre filtran por user_id primero, después por fecha:
CREATE INDEX idx_orders_user_date ON orders(user_id, created_at DESC);
```

### Parciales

```sql
-- Solo índice sobre filas activas (si el 90% está soft-deleted):
CREATE INDEX idx_users_active ON users(email) WHERE active = true;
```

### Expresión

```sql
-- Para búsquedas case-insensitive:
CREATE INDEX idx_users_email_lower ON users(LOWER(email));
-- Query: WHERE LOWER(email) = 'a@b.com'
```

## Anti-patterns a evitar

- `LIKE '%algo%'` sin índice trigram → scan completo
- `NOT IN (subquery)` → usar `NOT EXISTS`
- `ORDER BY RANDOM()` en tablas grandes → muerte
- `DISTINCT` para "arreglar" un JOIN mal hecho → arreglar el JOIN
- Funciones en la cláusula WHERE sobre columna indexada (mata el índice):
  ```sql
  -- MAL: no usa índice en created_at
  WHERE DATE(created_at) = '2026-04-18'

  -- BIEN
  WHERE created_at >= '2026-04-18' AND created_at < '2026-04-19'
  ```

## EXPLAIN ANALYZE — cómo leerlo

```sql
EXPLAIN (ANALYZE, BUFFERS) SELECT ...;
```

Qué mirar:
- `Seq Scan` en tabla grande → probablemente falta índice
- `actual time` de cada nodo → dónde se va el tiempo real
- `Rows Removed by Filter` alto → filtro se aplica después del scan
- `Buffers: shared hit` vs `shared read` → cache vs disco

## Transacciones

- Usar `BEGIN / COMMIT` explícito en writes múltiples
- `SERIALIZABLE` solo si hace falta — `READ COMMITTED` es default y suficiente 95% del tiempo
- Nunca transacciones largas con I/O externo adentro
