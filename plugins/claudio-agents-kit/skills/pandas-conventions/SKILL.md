---
name: pandas-conventions
description: Convenciones para código Pandas mantenible y performante. Invocar cuando se escriba transformación de DataFrames, ETL, o análisis con Pandas.
---

# Pandas — Convenciones de Claudio-Enterprises

## Regla de oro
**Vectorizar antes que iterar. Siempre.**

## Patrones preferidos

### En vez de `iterrows`:
```python
# MAL
for idx, row in df.iterrows():
    df.at[idx, 'total'] = row['price'] * row['qty']

# BIEN
df['total'] = df['price'] * df['qty']
```

### En vez de `apply` con lambda:
```python
# MAL
df['category'] = df['price'].apply(lambda x: 'high' if x > 100 else 'low')

# BIEN
df['category'] = np.where(df['price'] > 100, 'high', 'low')
```

### Para múltiples condiciones usa `np.select`:
```python
conditions = [
    df['price'] < 50,
    df['price'] < 200,
    df['price'] >= 200
]
choices = ['low', 'mid', 'high']
df['tier'] = np.select(conditions, choices, default='unknown')
```

### Para `append` en loops: NO. Usar concat al final:
```python
# MAL
result = pd.DataFrame()
for f in files:
    result = result.append(pd.read_csv(f))

# BIEN
dfs = [pd.read_csv(f) for f in files]
result = pd.concat(dfs, ignore_index=True)
```

## Tipos explícitos al cargar

Siempre que el dataset tenga >10k filas o vaya a producción:

```python
dtypes = {
    'user_id': 'int64',
    'email': 'string',
    'price': 'float64',
    'created_at': 'string',  # parseás después
}
df = pd.read_csv('file.csv', dtype=dtypes)
df['created_at'] = pd.to_datetime(df['created_at'])
```

## Copias explícitas

Cuando filtrás y vas a modificar:
```python
# Evita SettingWithCopyWarning
subset = df[df['active']].copy()
subset['flag'] = True
```

## Merge: siempre especificá `how` y `on`

```python
# BIEN
merged = pd.merge(orders, users, how='left', on='user_id')

# Validá que el merge no duplicó filas
assert len(merged) == len(orders), "Merge duplicó filas"
```

## Nulls

- Revisar siempre con `df.isna().sum()` antes de procesar
- Documentar decisión: ¿se dropean? ¿se imputan? ¿se dejan?
- `fillna(0)` sin pensarlo es bug garantizado

## Performance checklist

1. ¿Se puede hacer vectorizado? (primera pregunta siempre)
2. ¿Estoy cargando el CSV más de una vez?
3. ¿Uso `dtype` explícito?
4. ¿El merge infla las filas?
5. Para agregaciones: ¿groupby + transform es mejor que apply?

## Output / logging

Logueá row count en cada paso:
```python
logger.info(f"Loaded: {len(df)} rows")
df = df[df['active']]
logger.info(f"After filter active: {len(df)} rows")
```
