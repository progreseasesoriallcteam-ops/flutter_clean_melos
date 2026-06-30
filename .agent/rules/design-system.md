# Design System & UI Guidelines

Este archivo es la **fuente de verdad** para el diseno visual del proyecto (Progrese). El agente debe consultar este documento antes de crear o modificar cualquier interfaz para asegurar consistencia a nivel de toda la aplicacion.

## Ubicacion del Codigo
Todos los componentes de diseno, paleta de colores y widgets base residen en el paquete de UI centralizado: `packages/core_ui`.

## Paleta de Colores (Theme - `AppColors`)
Los colores semanticos se encuentran definidos en `packages/core_ui/lib/src/theme/app_colors.dart` en la clase `AppColors`. Evita usar colores crudos o *hardcodear* `Colors.red` o `Hex codes`.

- **Primary (Deep Red / Red):** `AppColors.primary` (0xFFD32F2F) / `AppColors.primaryLight` (0xFFEF5350)
- **Secondary (Steel Blue):** `AppColors.secondary` (0xFF4A6B8C)
- **Backgrounds:** `AppColors.background` (0xFFF8F9FA) para el fondo general, `AppColors.surface` (Colors.white) para tarjetas y fondos de contenedor.
- **Sidebar / Dark Navy:** `AppColors.darkNavy` (0xFF0A192F) o `AppColors.darkBlue` (0xFF1A365D).
- **Gradients:** `AppColors.spaceGradient` es el degradado oficial oscuro (usado en LoginScreen y en la Sidebar principal para fusionar estetica). Combina `darkNavy`, `deepSlate`, y `secondary`.
- **Text:** `AppColors.textPrimary` (Oscuro), `AppColors.textSecondary` (Gris medio), `AppColors.textMuted` (Gris claro).

## Tipografia (TextStyles)
La aplicacion utiliza `GoogleFonts.inter` por defecto (`AppTypography.textTheme`). Al construir interfaces, prefiere usar las fuentes de `AppTypography` y siempre presta atencion al color del texto para garantizar el contraste con el fondo.

## Componentes Globales Obligatorios

El agente **DEBE PREFERIR** los siguientes widgets personalizados. **Bajo ninguna circunstancia** debes construir `TextFormField` sueltos para datos de la app sin usar los custom widgets.

### Entradas de Texto y Formularios (`AppTextField` y `AppDropdownField`)
Todo formulario debe usar `AppTextField` y `AppDropdownField` (ubicados en `packages/core_ui/lib/src/widgets/`). Estos componentes estan construidos con las siguientes reglas:
- **Label Externo:** La etiqueta (*label*) debe ir por fuera del campo de texto principal.
- **Indicador de Requerido:** Si es obligatorio (`isRequired: true`), se dibuja un asterisco rojo (*) junto al label.
- **Aspecto del Campo:** El campo de texto siempre tiene un fondo blanco solido, bordes suaves grises, y un borde ligeramente mas grueso de color `AppColors.secondary` cuando tiene el foco (focused). En estado de error, se bordea de color rojo (`AppColors.primary`).
- **Hint Text Obligatorio:** Todo campo debe tener `hintText`. El texto de ayuda interior se pinta en color suave (mutado), igual que los iconos internos (`prefixIcon` y `suffixIcon`).
- **Password Toggle:** Usar `isPassword: true` en lugar de `obscureText: true` para obtener el toggle de visibilidad integrado (icono de ojo).
- **Campos Especiales:** `AppTextField` maneja por ti casos de uso especial mediante variables: Usa `keyboardType: TextInputType.phone` para auto-formatear numeros en mascara `(XXX) XXX-XXXX`. Usa `isAmount: true` para permitir valores numericos con decimales.

### Navegacion y Estructura
- **Sidebar y Topbar:** La navegacion principal esta centralizada en `apps/flutter_app/lib/router.dart` (`ShellRoute`). El Sidebar esta reservado principalmente para navegacion en la aplicacion. La informacion del usuario conectado, opciones de cambiar contrasena, y cerrar sesion, se ubican siempre en la zona de la cabecera / TopBar, como un `PopupMenuButton` sobre el nombre y avatar del usuario de turno.

### Pantallas de Listado de Datos (List Screens / Data Tables)
- **Componente Obligatorio:** Todas las pantallas de listado deben usar `AppListPage<T>` de `core_ui`. Ver reglas completas en `.agent/rules/list-screens.md`.
- **Ancho Maximo (Max Width):** Toda pantalla principal orientada a listar datos y tablas debe estar contenida o centrada con un ancho maximo de `1200px` — lo maneja `AppListPage` automaticamente.
- **Encabezado y Boton de Accion (Header & Add Action):** `AppListPage` incluye title + subtitle + search (con modo icono mobile) + filters + add button (FilledButton desktop, FAB mobile).
- **Tap-to-Edit:** Las filas deben abrir edicion al tocar. No usar boton Edit inline.
- **Infinite Scroll:** Siempre usar paginacion, nunca fetch-all.
- **Filtros:** Usar `AppFilterChips` con `AppFilter(value, label)`. Filtros combinan con AND.
- **Colores:** Cero colores hardcodeados. Todo via `AppColors`.

### Internacionalizacion y Localization (`AppStrings`)
- **Regla Estricta:** Las traducciones son obligatorias. Ningun texto o Label orientado al usuario debe codificarse en duro en las pantallas de Flutter. Todo el texto de los modulos debe ser centralizado y extraido a traves de `AppStrings` en `packages/core/lib/src/l10n/app_strings.dart` abarcando tanto el idioma Ingles (`en`) como el Espanol (`es`).
- **Verificacion de Modulos (Bilingual Check):** Antes de dar por concluido el desarrollo de un modulo o pantalla, el Agente y el Desarrollador **DEBEN obligatoriamente** revisar si el componente soporta y visualiza correctamente sus textos en ambos idiomas (Espanol e Ingles) usando la clase principal.

---
*Nota para el Desarrollador e Inteligencia Artificial: Toda modificacion al UI base, campos o componentes recurrentes debe agregarse a este archivo y referenciar a `core_ui`.*
