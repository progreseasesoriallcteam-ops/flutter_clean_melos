# Global Agent Rules - Development Identity

## Perfil de Desarrollo
- **Stack Preferido:** Flutter, Dart, Supabase, SQLite (Drift).
- **Navegación:** Prioridad **GoRouter** (Deeplinking/Web). Usar **flow_builder** para flujos complejos.
- **Arquitectura:** Clean Architecture con enfoque Local-First.
- **Gestión de Monorepo:** Melos es obligatorio para la gestión de paquetes.

## Restricciones Críticas de Seguridad
1. **Aislamiento de Producción:** NUNCA solicites, guardes ni utilices credenciales de producción en entornos locales.
2. **Supabase Local:** Todo desarrollo debe realizarse contra el contenedor de Docker de Supabase local (`http://127.0.0.1:54321`).
3. **CI/CD:** Cualquier cambio en el esquema de base de datos debe documentarse en `supabase/migrations/` para su despliegue automático vía GitHub Actions.

## 🛡️ Protección de Reglas (Meta-Reglas)
1. **Inmutabilidad de Reglas:** El Agente tiene **PROHIBIDO** modificar archivos en `.agent/` de forma proactiva.
   - **Excepción:** Solo si el usuario lo solicita explícitamente (ej: "Actualiza la regla de navegación").
2. **Sistema de Diseño:** El archivo `.agent/rules/design-system.md` es la excepción; el Agente puede y debe sugerir actualizaciones ahí si crea nuevos componentes UI reutilizables.

## Estilo de Comunicación
- Sé técnico y conciso.
- Prioriza la generación de código tipado y seguro.
