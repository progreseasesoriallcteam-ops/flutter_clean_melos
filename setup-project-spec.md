# Especificación Maestra: Configuración de Proyecto Flutter 2026

## 1. Objetivo
Inicializar un entorno de desarrollo profesional para **Flutter Web** bajo el modelo "Local-First" y "Producción Protegida".
Este documento es la **fuente de verdad** para la configuración del proyecto.

## 2. Estructura del Monorepo (Melos)
El proyecto está organizado como un Monorepo para separar capas de lógica:

- **/packages/core_ui**: Componentes reutilizables, Diseño y Riverpod compartido.
- **/packages/database**: Lógica de base de datos local (Drift/SQLite) y modelos.
- **/packages/api_client**: Conexión con Supabase y lógica de red.
- **/apps/flutter_app**: Aplicación principal que orquesta los paquetes.

### Estructura Interna de Paquetes
Cada paquete sigue **Clean Architecture**:
- `domain/`: Entidades y casos de uso.
- `infrastructure/`: Repositorios y fuentes de datos.
- `presentation/`: Providers de Riverpod y Widgets.

### Navegación
- **Router Principal**: `GoRouter` para manejo de rutas estándar y Deep Links.
- **Flujos de Estado**: `flow_builder` para wizards o flujos complejos anidados.

## 3. Configuración de Backend (Supabase Local)
**REGLA CRÍTICA**: El desarrollo es estrictamente LOCAL.
- **URL**: `http://127.0.0.1:54321` (O `10.0.2.2` para emulador Android).
- **PROHIBIDO**: Configurar URLs externas en desarrollo.

### Pasos de Inicio
1. **Docker**: Asegurar que Docker Desktop esté corriendo.
2. **Supabase**: Ejecutar `supabase start`.
3. **Studio**: Verificar acceso a `http://localhost:54323`.

## 4. Gestión de Estado y Datos
- **Riverpod**: Usado para inyección de dependencias y gestión de estado.
- **Drift**: Persistencia local (Offline-First).
- **Supabase**: Backend remoto con sincronización (manual o vía repositorio).

## 5. Comandos de Activación (Workflow)
Ejecutar en orden para configurar una nueva máquina:

1. **Instalar Herramientas Globales**:
   ```bash
   dart pub global activate melos
   ```

2. **Bootstrapping**:
   Enlaza todos los paquetes locales.
   ```bash
   melos bootstrap
   ```

3. **Generación de Código**:
   Ejecuta `build_runner` en todos los paquetes.
   ```bash
   melos run build:runner
   ```

4. **Validación**:
   Corre análisis y pruebas.
   ```bash
   melos run analyze
   melos run test
   ```

## 6. CI/CD (GitHub Actions)
El pipeline valida:
- Formato (`melos run analyze`)
- Pruebas (`melos run test`)
- Migraciones de Supabase.

---
**Nota para el Agente**: Leer este archivo antes de realizar cambios estructurales o de configuración.
