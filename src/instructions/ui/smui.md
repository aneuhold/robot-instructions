### SMUI

- Always use SMUI components (e.g. `Icon` from `@smui/icon-button`) instead of raw HTML equivalents (e.g. `<span class="material-icons">`) for consistency with the design system.
- For SMUI components that don't accept a `class` prop directly, use `:global()` selectors scoped under a parent class.
- Override colors on MDC components using SASS mixins in the theme file, not CSS overrides. Import the component's mixins (e.g. `@use '@material/circular-progress/mixins' as circular-progress`), then create a class scoped under the MDC base class (e.g. `.mdc-circular-progress.on-primary { @include circular-progress.color(theme.$on-primary); }`). Apply the class via the SMUI component's `class` prop. The dev server must be restarted after theme changes.
