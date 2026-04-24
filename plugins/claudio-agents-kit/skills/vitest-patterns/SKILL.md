---
name: vitest-patterns
description: Convenciones y reglas de performance para tests en JS/TS con Vitest (preferido) o Jest, React Testing Library, MSW y Playwright. Invocar cuando se escriban o scaffoldeen tests de frontend/Node, se configure un runner nuevo, o se audite una suite lenta. Cubre mocks de SDKs externos, renderHook/RTL en vez de servidor real, separación de Playwright y detección de stack.
---

# Vitest / Jest — Convenciones + Performance

Esta skill cubre tests en JS/TS: unit + component + integration. Playwright (E2E) se menciona solo para dejar claro que **nunca va en el gate de PR**.

> **Detectar antes de imponer**: leé `package.json` para ver qué runner ya está configurado (`vitest`, `jest`, `@testing-library/*`, `msw`). No migrar de jest a vitest sin pedir permiso — la skill aplica a ambos, pero cada uno tiene su sintaxis de mock (`vi.mock` vs `jest.mock`).

## Regla 0 — Preferir Vitest en proyectos nuevos

Para proyectos nuevos (sin runner configurado), scaffoldear **Vitest**:

- Arranque más rápido (esbuild/vite en vez de babel+ts-jest).
- API compatible con jest (`describe/it/expect`, mayor parte de los matchers).
- Integra nativo con Vite / Next.js SWC.

Si el proyecto ya usa Jest, **no migrar**. Aplicar los mismos principios con `jest.mock` + `@swc/jest` para speed.

## Regla 1 — Mockear SDKs externos por default

Mismo espíritu que en pytest: **nada de red real en unit tests**.

| Área | Herramienta | Cómo |
|---|---|---|
| HTTP (fetch / axios) | **MSW** (Mock Service Worker) | handlers globales en `tests/setup.ts` |
| SDKs específicos (openai, stripe, supabase) | `vi.mock('<sdk>')` | stub del cliente con respuestas canónicas |
| Clock | `vi.useFakeTimers()` | `vi.setSystemTime(new Date('2026-04-24'))` |
| Módulos ESM pesados | `vi.mock('<path>', () => ({ default: stub }))` | reemplazar import top-level |
| `next/navigation`, `next/headers` | mocks centralizados | `tests/mocks/next.ts` + `vi.mock` en setup |

Ejemplo de `tests/setup.ts` con MSW + mocks globales:

```ts
import { beforeAll, afterEach, afterAll, vi } from "vitest";
import { setupServer } from "msw/node";
import { http, HttpResponse } from "msw";

export const server = setupServer(
  http.post("https://api.openai.com/v1/chat/completions", () =>
    HttpResponse.json({ choices: [{ message: { content: "stub" } }] })
  ),
);

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

vi.mock("@/lib/analytics", () => ({ track: vi.fn() }));
```

`onUnhandledRequest: "error"` falla el test si hay fetch no mockeado — forzás que todos los externos estén cubiertos.

## Regla 2 — No levantar servidor Next real en unit tests

**Anti-pattern**: spawneá `next dev` / `next start` en un `beforeAll` y tests golpean `localhost:3000`. Tardísimo.

**Patrón correcto**:

- **Componentes**: `render` de `@testing-library/react`.
- **Hooks**: `renderHook` de `@testing-library/react`.
- **Server actions / route handlers**: importá la función directo y llamala con un `Request` sintético.
- **API routes de Next**: `POST(req)` exportado → importar + llamar.

```ts
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { UserCard } from "@/components/UserCard";

test("click edit opens modal", async () => {
  render(<UserCard user={{ id: 1, name: "Ana" }} />);
  await userEvent.click(screen.getByRole("button", { name: /edit/i }));
  expect(await screen.findByRole("dialog")).toBeInTheDocument();
});
```

```ts
import { POST } from "@/app/api/users/route";

test("POST /api/users returns 201", async () => {
  const req = new Request("http://test/api/users", {
    method: "POST",
    body: JSON.stringify({ email: "a@b.com", name: "Ana" }),
  });
  const res = await POST(req);
  expect(res.status).toBe(201);
});
```

## Regla 3 — Playwright solo en job `e2e` separado

**Playwright nunca corre en el gate de PR** junto con unit tests. Razones:

- Levanta navegadores, toma 1-5s por test incluso con caché.
- Flaky por naturaleza si se mezcla con concurrencia de unit tests.
- Su propio workflow trigger: `workflow_dispatch`, `nightly`, o tag `deploy`.

Estructura recomendada:

```
tests/
├── unit/           # Vitest: funciones puras, hooks
├── component/      # Vitest + RTL: componentes aislados
├── integration/    # Vitest: server actions, route handlers
└── e2e/            # Playwright: flujos end-to-end, solo en job e2e
```

`vitest.config.ts` excluye `tests/e2e`:

```ts
export default defineConfig({
  test: {
    include: ["tests/**/*.test.ts?(x)"],
    exclude: ["tests/e2e/**", "node_modules/**"],
    setupFiles: ["./tests/setup.ts"],
    environment: "jsdom",
  },
});
```

## Regla 4 — Paralelismo default, pero cuidado con estado compartido

Vitest paraleliza por default (`poolOptions.threads` o `forks`). Reglas:

- **Nunca compartir mutable state** entre tests (variables top-level). Si hace falta, envolver en `beforeEach` que resetee.
- **MSW handlers** se resetean en `afterEach(() => server.resetHandlers())`.
- **`vi.clearAllMocks()` en `afterEach`** si los mocks acumulan llamadas entre tests.

```ts
afterEach(() => {
  vi.clearAllMocks();
  server.resetHandlers();
});
```

## Regla 5 — No rendereo pesado innecesario

**Anti-patterns**:

- Renderear toda la app (`<App />`) para testear un botón. Rendereá el componente mínimo.
- `waitFor` con timeout de 5000ms y `setTimeout` adentro. Usá `findBy*` que ya espera.
- Snapshots gigantes (`toMatchSnapshot` de un árbol de 500 nodos). Assertá propiedades específicas.

## Naming

Mismo criterio que pytest:

```ts
test("createUser returns 201 with valid payload", ...)
test("createUser returns 422 when email is invalid", ...)
```

`describe` agrupa por unidad bajo test:

```ts
describe("POST /api/users", () => {
  test("returns 201 with valid payload", ...);
  test("returns 422 when email is invalid", ...);
});
```

## Config de `package.json` (scripts canónicos)

```json
{
  "scripts": {
    "test": "vitest run",
    "test:watch": "vitest",
    "test:smoke": "vitest run --exclude 'tests/e2e/**'",
    "test:e2e": "playwright test",
    "test:ci": "vitest run --reporter=dot --coverage"
  }
}
```

## Checklist de validación (obligatorio antes de cerrar)

1. `vitest run --reporter=verbose` — reportar número total de tests.
2. Duración total y top-5 lentos (vitest lo muestra con `--reporter=verbose`).
3. **Bloqueos**:
   - Algún test unit > 1s → investigar (render pesado, fetch no mockeado, timer real).
   - Duración total > 30s para <300 tests → revisar MSW, `vi.mock`, render scope.
   - `onUnhandledRequest: "error"` debe estar activo — si no, hay fetches reales escondidos.
4. Si hay Playwright, correr `playwright test` en su propio job y reportar separado.

## Anti-patterns

- **Levantar `next dev` en `beforeAll`** — usar imports directos o RTL.
- **Fetch real a APIs externas** — MSW con `onUnhandledRequest: "error"`.
- **Playwright en el mismo job que unit tests** — job aparte siempre.
- **Snapshots de árboles gigantes** — assertar propiedades específicas.
- **`act()` wrapping innecesario** — RTL moderno lo hace solo.
- **Mocks globales no reseteados entre tests** — `afterEach(() => vi.clearAllMocks())`.
- **`setTimeout` real para esperar async** — `await findBy*` o `vi.useFakeTimers()`.

## Ver también

- `pytest-style` — contraparte Python, mismas filosofías de performance.
- `github-actions-ci` — cómo separar `test-smoke` (Vitest) vs `e2e` (Playwright) en jobs.
- `react-query-patterns` — cómo testear componentes que usan React Query (MSW + `QueryClient` fresh por test).
