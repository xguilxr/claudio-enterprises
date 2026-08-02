---
id: MCS-P02
titulo: Proceso consultivo — REEMPLAZADO
marco: MCS
capa: prompt
version: 1.1.0
estado: reemplazado
reemplazado_por: MCC-P01
idioma: es
responsable: propietario
revisado: 2026-08-02
revisar_cada: 365d
uso: recurrente
depende_de: [MCC-P01]
---

# MCS-P02 — Reemplazado por MCC-P01

Este prompt conducía encargos de consultoría desde el marco de software. La
consultoría es ahora un marco propio: **MCC**, con 92 requisitos en 9 dominios.

**Usa `mcc/prompts/MCC-P01-conduccion-encargo.md`.**

## Por qué se movió

MFB-G01 §3 puntúa el encaje de consultoría en 9: audiencia distinta (el cliente,
no quien desarrolla), ciclo de vida propio, y encargos que no construyen software.
Umbral de familia nueva: 7.

Mantenerlo aquí incumplía TRZ-02 —un hecho vive en un solo documento— y hacía que
un encargo puramente consultivo tuviera que cargar el marco de software para
conducirse.

## Qué no cambió

MCS-CORE conserva su versión: no se añadió, eliminó ni endureció ningún requisito
suyo. Solo se retiró un prompt, y VER-03 no aplica a eso.

El identificador MCS-P02 **no se reutiliza** (NOM-04).
