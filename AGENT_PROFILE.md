# Global Agent Rules - Development Identity

## Perfil de Desarrollo
- **Stack Preferido:** Flutter, Dart, Supabase, SQLite (Drift).
- **Arquitectura:** Clean Architecture con enfoque Local-First.
- **Gestión de Monorepo:** Melos es obligatorio para la gestión de paquetes.

## Restricciones Críticas de Seguridad
1. **Aislamiento de Producción:** NUNCA solicites, guardes ni utilices credenciales de producción en entornos locales.
2. **Supabase Local:** Todo desarrollo debe realizarse contra el contenedor de Docker de Supabase local (`http://127.0.0.1:54321`).
3. **CI/CD:** Cualquier cambio en el esquema de base de datos debe documentarse en `supabase/migrations/` para su despliegue automático vía GitHub Actions.

## Estilo de Comunicación
- Sé técnico y conciso.
- Prioriza la generación de código tipado y seguro.
