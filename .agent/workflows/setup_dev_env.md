---
description: Inicializa y valida el entorno de desarrollo. SI ESTE PROCESO FALLA, EL AGENTE DEBE CONSULTAR 'TROUBLESHOOTING.md' Y NO INTENTAR MODIFICAR CÓDIGO.
---

1. Validar prerrequisitos del sistema (CRÍTICO)
   - Verificar instalación de Flutter (`flutter --version`). Si falla, ABORTAR y pedir al usuario instalar Flutter.
   - Verificar instalación de Docker (`docker --version`). Si falla, ABORTAR y pedir instalar Docker Desktop.
   - Verificar instalación de Supabase CLI (`supabase --version` o `npx supabase --version`).
     - Si ambos fallan, ABORTAR y pedir instalación manual (ver README.md).

2. Bootstrapping del Proyecto
   // turbo
   - Ejecutar `dart pub global activate melos`
   // turbo
   - Ejecutar `melos bootstrap`

3. Configuración de Backend (Local)
   // turbo
   - Ejecutar `supabase start` (o `npx supabase start` si es local via NPM) para asegurar que el backend local esté corriendo.

4. Generación de Código
   // turbo
   - Ejecutar `melos run build:runner` para generar archivos *.g.dart y *.freezed.dart base.

5. Validación Final
   // turbo
   - Ejecutar `melos run analyze` para confirmar que no hay errores estáticos.
   // turbo
   - Ejecutar `melos run test` para validar el estado base del proyecto.

6. Confirmación y Ejecución
   - Ejecutar `cd apps/flutter_app && flutter run -d chrome`
   - Verificar que aparezca en pantalla: "Entorno Totalmente Instalado"
