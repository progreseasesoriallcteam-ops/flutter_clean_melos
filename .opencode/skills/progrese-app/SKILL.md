---
name: progrese-app
description: Use when working on Progrese project. Flutter Web, Melos monorepo, Clean Architecture, Riverpod v3, Supabase, Drift local-first. Dart pub for packages (NEVER npm).
---

# Progrese Project Rules

## Stack
- Flutter Web, Dart, Riverpod v3, Supabase, Drift (SQLite Local-First).
- Monorepo via Melos. Structure: `apps/flutter_app` and `packages/`.

## Package Manager
- **Use `dart pub get`** for Dart/Flutter packages. Melos handles bootstrap.
- **Node (npm)** only for Supabase CLI (`npx supabase`). Do NOT use pnpm or yarn.

## Key Commands
- `dart run melos bootstrap` — Bootstrap workspace packages.
- `dart run melos run analyze` — Run linter on all packages.
- `dart run melos run test` — Run all tests.
- `melos run build:runner` — Regenerate code with build_runner (Riverpod + Drift).
- `npx supabase start` — Start local Supabase (Docker required).
- `npx supabase stop` — Stop local Supabase.
- `npx supabase db reset` — Reset local DB with migrations + seed.

## Architecture
- **Clean Architecture:** Domain (`core`), Data (`api_client`, `database`), UI (`core_ui`), App (`flutter_app`).
- **core:** Models (`UserProfile`), Enums (`UserRole`, `AppEnvironment`), Config (`AppConfig`), i18n (`AppStrings`).
- **core_ui:** Theme (`AppTheme`, `AppColors`), Typography (`AppTypography`), Widgets (`AppTextField`, `AppSidebar`, `AppTopbar`, `AppSidesheet`, `AppDataTable`), Layouts (`ResponsiveLayout`).
- **api_client:** Auth (`AuthService`, auth provider), Repositories (`UserRepository`), Riverpod providers.
- **database:** Drift schema (`user_profile_table`) with local-first sync flags.
- **flutter_app:** Features (`auth/`, `dashboard/`, `users/`), GoRouter (`router.dart`).

## Supabase Local (MANDATORY)
- URL: `http://127.0.0.1:54321`
- Anon Key: Default local dev key (JWT).
- Studio: `http://127.0.0.1:54323`
- Mailpit: `http://127.0.0.1:54324`
- DB: `postgresql://postgres:postgres@127.0.0.1:54322/postgres`

## Auth & DB Schema
- Tables: `auth.users` (native) + `public.user_profiles` (custom, with RLS).
- Roles: `admin`, `user` via enum `public.user_role`.
- RLS: Users see own + active profiles. Admins see/update all.
- Seed data: `admin@progrese.dev` / `Admin123!`, `usuario1@progrese.dev` / `User1234!`, `usuario2@progrese.dev` / `User1234!`

## UI Rules (NEVER FORGET)
- **Theme:** Use `AppTheme.light` as Material theme. Colors through `AppColors.*` tokens.
- **Typography:** `AppTypography.textTheme` based on `GoogleFonts.inter`.
- **Forms:** Always use `AppTextField` and `AppDropdownField` from `core_ui`. Labels external, required fields show red asterisk.
- **Password fields:** Use `isPassword: true` (built-in visibility toggle). Never use bare `obscureText: true`.
- **All fields must have hints:** Always pass `hintText` parameter.
- **Sidesheets:** Use `PopScope` with discard dialog when `isDirty`.
- **Max width / List screens:** Use `AppListPage<T>` from `core_ui` for ALL CRUD lists. See `.agent/rules/list-screens.md` for mandatory patterns (tap-to-edit, infinite scroll, filters, mobile-first).
- **i18n:** All user-facing strings via `AppStrings.of(context)`. Bilingual ES/EN.
- **Naming:** Avoid `Kfg` prefix. Use `App` prefix (`AppColors`, `AppTheme`, `AppStrings`).

## Current Features
1. **Auth:** Login (split panel), Register, Reset Password.
2. **Dashboard Shell:** Collapsible sidebar + topbar with user menu.
3. **User Management:** List (search, sort, activate/deactivate), Create/Edit sidesheet.

## Project Context Files
- `AGENT_PROFILE.md` — Agent identity and meta-rules.
- `.agent/rules/` — Architecture, design system, navigation, web, database rules.
- `.cursorrules` — Rules injected into AI context.
- `.env` — Environment variables + test credentials.
- `supabase/` — Config, migrations, seed data.
- `melos.yaml` — Workspace package definitions and scripts.
