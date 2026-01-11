---
description: Inicializa y valida el entorno de desarrollo completando todos los pasos necesarios.
---

1. Validar prerrequisitos del sistema
   - Verificar instalación de Flutter
   - Verificar instalación de Docker
   - Verificar instalación de Supabase CLI

2. Bootstrapping del Proyecto
   // turbo
   - Ejecutar `dart pub global activate melos`
   // turbo
   - Ejecutar `melos bootstrap`

3. Configuración de Backend (Local)
   // turbo
   - Ejecutar `supabase start` para asegurar que el backend local esté corriendo.

4. Generación de Código
   // turbo
   - Ejecutar `melos run build:runner` para generar archivos *.g.dart y *.freezed.dart base.

5. Validación Final
   // turbo
   - Ejecutar `melos run analyze` para confirmar que no hay errores estáticos.
   // turbo
   - Ejecutar `melos run test` para validar el estado base del proyecto.

6. Confirmación
   - Mostrar mensaje: "Entorno listo. Puedes comenzar a editar en apps/flutter_app o packages/."
