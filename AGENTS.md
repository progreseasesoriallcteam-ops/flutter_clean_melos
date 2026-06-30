# Progrese

Flutter Web monorepo for Progrese - team management application.

## Quick Start

```bash
# Install dependencies
dart run melos bootstrap

# Start Supabase (requires Docker)
npx supabase start

# Regenerate code
melos run build:runner

# Run app
cd apps/flutter_app && flutter run -d chrome

# Run analysis
dart run melos run analyze

# Run tests
dart run melos run test
```

## Development

See `.opencode/skills/progrese-app/SKILL.md` for full project rules and conventions.

## Credentials (Local Dev)

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@progrese.dev | Admin123! |
| User | usuario1@progrese.dev | User1234! |
| User | usuario2@progrese.dev | User1234! |

## Archivos de Reglas

- `.agent/rules/clean-architecture.md` — Clean Architecture y Monorepo.
- `.agent/rules/design-system.md` — Sistema de diseno (colores, tipografia, componentes).
- `.agent/rules/platform-web.md` — Reglas Flutter Web.
- `.agent/rules/navigation.md` — GoRouter y Flow Builder.
- `.agent/rules/database-local-first.md` — Drift + Supabase sync.
- `.agent/rules/list-screens.md` — AppListPage, filters, infinite scroll, tap-to-edit.
