# Flutter Clean Melos Workspace

Este proyecto es un monorepo Flutter gestionado con Melos.

## 🚀 Configuración Inicial

**IMPORTANTE**: Antes de comenzar, por favor lee:
1. [setup-project-spec.md](./setup-project-spec.md) - Arquitectura y Reglas del Proyecto.
2. [AGENT_PROFILE.md](./AGENT_PROFILE.md) - Reglas de Identidad y Comportamiento del Agente.

### Pasos Rápidos
1. `dart pub global activate melos`
2. `melos bootstrap`
3. `melos run build:runner`
4. `supabase start`

## Estructura
- **apps/**: Aplicaciones finales.
- **packages/**: Librerías compartidas (`core_ui`, `database`, `api_client`).

## Comandos Útiles
- `melos run analyze`: Analizar código.
- `melos run test`: Correr pruebas.
- `melos run build:runner`: Generar código (Riverpod/Drift).
