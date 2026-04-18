---
name: react-query-patterns
description: Patrones de TanStack Query (React Query) para consumo de APIs. Invocar al trabajar en frontend que consume datos del backend.
---

# TanStack Query — Patrones

## Setup inicial

```tsx
// src/lib/queryClient.ts
import { QueryClient } from "@tanstack/react-query";

export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 60 * 1000,           // 1 min fresh
      gcTime: 5 * 60 * 1000,          // 5 min en cache
      retry: 1,
      refetchOnWindowFocus: false,
    },
  },
});
```

```tsx
// src/main.tsx
import { QueryClientProvider } from "@tanstack/react-query";
import { queryClient } from "./lib/queryClient";

<QueryClientProvider client={queryClient}>
  <App />
</QueryClientProvider>
```

## Hook por recurso

```tsx
// src/hooks/useOrders.ts
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api } from "../lib/api";
import type { Order, OrderCreate } from "../types/order";

const ORDERS_KEY = ["orders"] as const;

export function useOrders() {
  return useQuery({
    queryKey: ORDERS_KEY,
    queryFn: () => api.get<Order[]>("/orders").then(r => r.data),
  });
}

export function useOrder(id: number) {
  return useQuery({
    queryKey: [...ORDERS_KEY, id],
    queryFn: () => api.get<Order>(`/orders/${id}`).then(r => r.data),
    enabled: !!id,
  });
}

export function useCreateOrder() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (data: OrderCreate) =>
      api.post<Order>("/orders", data).then(r => r.data),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ORDERS_KEY });
    },
  });
}
```

## Uso en componente

```tsx
function OrderList() {
  const { data, isLoading, error } = useOrders();

  if (isLoading) return <OrderListSkeleton />;
  if (error) return <ErrorState error={error} />;
  if (!data || data.length === 0) return <EmptyState />;

  return (
    <ul>
      {data.map(o => <OrderRow key={o.id} order={o} />)}
    </ul>
  );
}
```

## Mutations con feedback

```tsx
function CreateOrderForm() {
  const { mutate, isPending, error } = useCreateOrder();

  const onSubmit = (data: OrderCreate) => {
    mutate(data, {
      onSuccess: () => toast.success("Orden creada"),
      onError: (e) => toast.error(`Error: ${e.message}`),
    });
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      {/* ... */}
      <button disabled={isPending}>
        {isPending ? "Creando..." : "Crear orden"}
      </button>
    </form>
  );
}
```

## Keys: convención

Siempre como tuplas ordenadas de más general a más específico:

```tsx
["orders"]                              // lista de todas las órdenes
["orders", { status: "pending" }]       // lista filtrada
["orders", orderId]                     // una orden
["orders", orderId, "items"]            // items de una orden
```

Esto permite invalidaciones quirúrgicas:
```tsx
qc.invalidateQueries({ queryKey: ["orders"] });     // invalida todo "orders"
qc.invalidateQueries({ queryKey: ["orders", 5] }); // solo la orden 5
```

## Paginación

```tsx
export function useOrders(page: number) {
  return useQuery({
    queryKey: ["orders", { page }],
    queryFn: () => api.get(`/orders?skip=${page * 20}&limit=20`).then(r => r.data),
    placeholderData: (prev) => prev,   // mantiene data anterior durante fetch
  });
}
```

## Prefetching al hover

```tsx
const qc = useQueryClient();

<Link
  to={`/orders/${order.id}`}
  onMouseEnter={() =>
    qc.prefetchQuery({
      queryKey: ["orders", order.id],
      queryFn: () => api.get(`/orders/${order.id}`).then(r => r.data),
    })
  }
>
  {order.id}
</Link>
```

## Anti-patterns

- `useState + useEffect + fetch`: no. Usá useQuery.
- Compartir estado de servidor en Zustand/Redux: no. TanStack Query ya lo cachea.
- `data` sin verificar `isLoading` o `error`.
- Invalidar todo (`invalidateQueries()` sin key): invalida TODO el cache, caro.
- Fetchear dentro de un render sin `enabled: false` cuando falta una dependencia: spam de requests.
