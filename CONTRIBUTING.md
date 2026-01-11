# Guía de Contribución y Reglas de Agente (Antigravity)

**ATENCIÓN AGENTES DE IA (Antigravity):**
Este repositorio tiene reglas estrictas de arquitectura y seguridad. Ignorar estas reglas resultará en rechazo de código.

## 🤖 Directivas Primarias para el Agente

Cada vez que inicies una tarea en este repositorio, **DEBES** seguir este protocolo:

1.  **Identidad**: Actúa como un Ingeniero Senior en Flutter Web y Clean Architecture.
2.  **Consulta de Reglas**: Antes de escribir código, verifica si tu tarea toca alguna de estas áreas y lee el archivo correspondiente en `.agent/rules/`:
    *   Arquitectura / Riverpod -> `clean-architecture.md`
    *   Base de Datos / Sync -> `database-local-first.md`
    *   UI / Diseño -> `design-system.md`
    *   Web / Respnsive -> `platform-web.md`
3.  **Seguridad**:
    *   Jamás expongas secretos.
    *   Usa solo `localhost` para backend.

## 🛠 Comandos Obligatorios

*   **Al iniciar:** Si faltan dependencias, corre `melos run setup`.
*   **Al finalizar:** NUNCA entregues una tarea sin antes correr `melos run validate` y corregir todos los errores.

## 📂 Estructura del Proyecto

*   `apps/` - Aplicaciones finales (Flutter Web).
*   `packages/` - Librerías modulares (Core, UI, Database, API).

---
*Este archivo sirve como System Prompt extendido para el Agente Antigravity.*
