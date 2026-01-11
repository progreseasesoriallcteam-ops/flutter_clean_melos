# Design System & UI Guidelines

Este archivo es la **fuente de verdad** para el diseño visual. El agente consultará este documento antes de crear cualquier interfaz para asegurar consistencia.

## 📍 Ubicación del Código
Todos los componentes de diseño deben residir en el paquete: `packages/core_ui`.

## 🎨 Paleta de Colores (Theme)
Define aquí los colores semánticos que el agente debe usar (evita hardcodear Hex codes en los widgets, usa `Theme.of(context)`).

- **Primary:** `BrandColor.primary` (Definir color aquí, ej: Azul #0052CC)
- **Secondary:** ...
- **Background:** ...
- **Error:** ...

## 🔤 Tipografía (TextStyles)
Usa los estilos predefinidos en el `TextTheme`. 
Instrucciones para el agente: "Nunca uses `TextStyle(fontSize: 20)`, usa `AppTextStyles.h1` o `Theme.of(context).textTheme.headlineLarge`".

- **H1 / Headline Large:** ...
- **Body / Body Medium:** ...
- **Caption / Label Small:** ...

## 🧩 Componentes Globales
Lista aquí los widgets que el agente **DEBE PREFERIR** sobre los widgets nativos de Flutter.

### Botones
- **PrimaryAction:** Usar `AppPrimaryButton` (en `packages/core_ui/lib/src/widgets/buttons.dart`).
- **SecondaryAction:** Usar `AppOutlinedButton`.

### Inputs
- **TextFields:** Usar `AppTextField` con validación integrada.

### Layouts
- **PageContainer:** Wrapper estándar para todas las pantallas con Padding y SafeArea seguros.
- **Loading:** Usar `AppLoadingIndicator` (no `CircularProgressIndicator` crudos).

---
*Nota para el Desarrollador: Mantén este archivo actualizado. Si creas un nuevo componente "Standard", agrégalo aquí para que el agente sepa que existe y lo utilice.*
