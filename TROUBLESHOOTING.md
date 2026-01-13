# Guía de Solución de Problemas (Troubleshooting)

Este documento detalla los problemas más comunes durante la instalación y cómo resolverlos sin alterar la configuración base del proyecto.

## 🛑 Problemas Críticos de Infraestructura

### 1. Error: `Docker is not running` o `Connection refused` al iniciar Supabase
- **Causa**: Docker Desktop no está iniciado o WSL2 no responde.
- **Solución Manual**:
  1. Abre Docker Desktop.
  2. Espera a ver el indicador verde en la esquina inferior izquierda.
  3. Ejecuta `supabase start` nuevamente.
- **Comportamiento del Agente**: El agente debe abortar y pedirte que inicies Docker. **Nunca** debe intentar reconfigurar la red de Docker.

### 2. Error: `Port 54321 is already in use`
- **Causa**: Tienes otra instancia de Supabase o Postgres corriendo.
- **Solución Manual**:
  1. Ejecuta `supabase stop --no-backup`.
  2. O mata el proceso que usa el puerto: `netstat -ano | findstr :54321` y `taskkill /PID <PID> /F`.
- **Qué NO hacer**: No cambies el puerto en `config.toml` solo para que funcione temporalmente. Esto rompe la consistencia del equipo.

## 📦 Problemas de Dependencias (Melos/Flutter)

### 3. Error: `Melos bootstrap failed` o `Pub get failed`
- **Causa**: Conflictos en `pubspec.lock` o versiones de Dart incompatibles.
- **Solución**:
  ```powershell
  # Limpieza profunda segura
  melos clean
  flutter clean
  rm pubspec.lock # En la raíz y paquetes si es necesario
  melos bootstrap
  ```

### 4. Error: `BuildRunner` Conflicting outputs
- **Causa**: Archivos generados `.g.dart` o `.freezed.dart` antiguos no coinciden con el nuevo código.
- **Solución**:
  El comando de setup ya incluye `--delete-conflicting-outputs`, pero si persiste:
  1. Borra manualmente los archivos problemáticos.
  2. Corre `melos run build:runner`.

## 🤖 Prevención de "Agent Chaos" (Reglas anti-rotura)

Para evitar que el Agente AI intente "arreglar" el código cuando el problema es el entorno:

1. **Regla de Oro**: Si falla un comando de infraestructura (`docker`, `supabase`, `melos bootstrap`), el error es el **ENTORNO**, no el CÓDIGO.
   - **Acción**: El Agente debe detenerse y reportar el error de entorno.
   - **Prohibido**: Modificar `pubspec.yaml` o código Dart para "evadir" el error.

2. **Validación de Puertos**: Antes de culpar a la configuración de Supabase, verificar si el puerto está libre.

3. **Symlinks en Windows**:
   - Melos usa enlaces simbólicos. Si fallan, asegúrate de tener `Developer Mode` activado en Windows o correr la terminal como Administrador.

---
_Si el problema persiste tras intentar estos pasos, contacta al Tech Lead y NO permitas que el Agente reescriba archivos de configuración._
