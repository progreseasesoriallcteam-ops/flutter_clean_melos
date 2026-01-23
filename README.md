# Progrese - Flutter Web Clean Melos Workspace

Bienvenido al repositorio oficial del proyecto **Progrese**.
Este proyecto utiliza una arquitectura **Clean Architecture + Monorepo (Melos)** enfocada en **Flutter Web** y estrategia **Local-First**.

## 🚀 Inicio Rápido

Sigue estos pasos para configurar tu entorno de desarrollo en minutos.

### Prerrequisitos (Instalación Manual Requerida)

Debido a la naturaleza de estas herramientas, debes instalarlas manualmente antes de que el Agente pueda trabajar:

1.  **[Git](https://git-scm.com/downloads)**
    *   Requerido para el control de versiones.
    *   *Windows*: Instalar "Git for Windows".

2.  **[Flutter SDK](https://docs.flutter.dev/get-started/install)** (Stable Channel)
    *   Descargar y extraer el zip.
    *   Agregar la carpeta `flutter/bin` a tus variables de entorno (PATH).
    *   Verificar con: `flutter doctor`.

3.  **[Docker Desktop](https://www.docker.com/products/docker-desktop)**
    *   **Crítico**: Supabase Local corre sobre Docker.
    *   Instalar y asegurarse de que el engine esté corriendo (Icono de ballena en la barra de tareas).

4.  **[Supabase CLI](https://supabase.com/docs/guides/cli)**
    *   Herramienta de línea de comandos para gestionar el backend local.
    *   *Windows (vía Scoop)*:
        ```powershell
        scoop bucket add supabase https://github.com/supabase/scoop-bucket.git
        scoop install supabase
        ```
    *   *Alternativa (NPM)*: `npm install -g supabase`
    *   *Alternativa (Manual)*: Descargar el ejecutable de [GitHub Releases](https://github.com/supabase/cli/releases), renombrar a `supabase.exe` y agregar al PATH.

5.  **[Melos](https://melos.invertase.io/)**
    *   Gestor del Monorepo.
    *   Instalable vía Dart (paso automatizable si Dart/Flutter ya están):
        ```bash
        dart pub global activate melos
        ```

### Instalación

1. **Clonar el repositorio y entrar en el directorio:**
   ```bash
   git clone <URL_DEL_REPO>
   cd flutter_clean_melos
   ```

2. **Configurar el Agente (Opcional):**
   Si usas Antigravity o un agente similar, ejecuta el workflow de setup:
   ```bash
   # El agente leerá las reglas en .agent/rules/ automáticamente.
   ```

3. **Ejecutar Setup Completo:**
   Este comando instala dependencias, configura Melos, genera código y valida el entorno en un solo paso.
   ```bash
   melos run setup
   ```
   > 🆘 ¿Falló el setup? Consulta la **[Guía de Solución de Problemas (TROUBLESHOOTING.md)](./TROUBLESHOOTING.md)** antes de continuar.

4. **Levantar Backend Local:**
   ```bash
   supabase start
   ```

---

## 🏗 Arquitectura y Reglas

El proyecto sigue reglas estrictas para garantizar escalabilidad y calidad.

### 📚 Documentación Clave
Todo desarrollador **debe leer** estos documentos antes de contribuir:

- **[Reglas Generales (AGENT_PROFILE.md)](./AGENT_PROFILE.md)**: Identidad, stack y seguridad.
- **[Especificación del Proyecto (setup-project-spec.md)](./setup-project-spec.md)**: Detalles técnicos profundos.

### 📏 Reglas Específicas (.agent/rules)
Estas reglas guían al agente AI y a los desarrolladores:

| Regla | Descripción |
|-------|-------------|
| [Clean Architecture](./.agent/rules/clean-architecture.md) | Estructura de capas, Riverpod y separación de responsabilidades. |
| [Database Strategy](./.agent/rules/database-local-first.md) | Enfoque Local-First con Drift y sincronización Supabase. |
| [Design System](./.agent/rules/design-system.md) | **Guía de Estilo**: Colores, Tipografía y Componentes Globales que el Agente debe usar. |
| [CI/CD & Git](./.agent/rules/ci-cd-guidelines.md) | Flujo de Github Actions, Conventional Commits y despliegues. |
| [Firebase Setup](./.agent/workflows/setup_firebase_deploy.md) | Guía de configuración para despliegue automático. |

---

## 🛠 Comandos Melos (Cheat Sheet)

El proyecto usa scripts de Melos centralizados en `melos.yaml`.

- `melos run analyze`: Ejecuta el linter en todos los paquetes.
- `melos run test`: Corre todos los tests unitarios y de widgets.
- `melos run build:runner`: Regenera todo el código autogenerado.
- `melos exec -- "flutter clean"`: Limpia todos los paquetes.

---

## 🤝 Contribución y Flujo de Trabajo

### Roles del Equipo
- **Líder de Proyecto (@project-lead):** Dueño del repositorio. Revisa y aprueba todos los Pull Requests. Encargado de mantener la configuración crítica (Reglas, CI/CD).
- **Desarrollador:** Implementa funcionalidades en ramas independientes.

### Proceso de Aprobación (CODEOWNERS)
Este repositorio tiene activada la protección de ramas mediante `CODEOWNERS`.
1. **Pull Requests:** Todo cambio debe llegar vía PR a la rama `main`.
2. **Revisión Obligatoria:** GitHub bloqueará el "Merge" hasta que el **Líder de Proyecto** apruebe los cambios.
3. **Áreas Críticas:** Archivos como `melos.yaml`, `.agent/` y pipelines requieren atención especial durante la revisión.

### Pasos para Contribuir
1. Crea un branch (`feat/usuario-login`, `fix/error-database`).
2. Sigue [Conventional Commits](https://www.conventionalcommits.org/).
3. Asegúrate de que `melos run validate` pase en verde (Analisis + Tests).
4. Abre un Pull Request y asigna al Líder como revisor.

---
_Generado por Carlos con Antigravity - 2026_
