# Flutter Clean Melos Workspace

Este proyecto es un monorepo Flutter gestionado con Melos.

## 🚀 Configuración Inicial

**IMPORTANTE**: Antes de comenzar, por favor lee el archivo [setup-project-spec.md](./setup-project-spec.md) para entender la arquitectura y reglas del proyecto.

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
