### Svelte

#### Components

- Use Svelte 5 runes (`$state()`, `$derived()`, `$effect()`, `$props()`).
- Use the JSDoc `@component` tag at the top of `.svelte` files.
- Files named `Singleton*` are single-instance widgets (snackbar, confetti, dialogs) that export imperative functions.

#### State

- Simple state: use runes.
- Stores: only for modules that export a real Svelte store using `writable`, `readable`, or `derived` from `svelte/store`.
- Services: singleton classes exported as default instances. Use services for rune-based reactive state and for non-reactive utilities. Name files as `<Name>.service.ts`, or `<Name>.service.svelte.ts` if the file uses Svelte runes, where `<Name>` is PascalCase.

#### Animation

- Prefer CSS. Use a Svelte transition only when CSS alone can't do it, the primary case being `transition:slide` for expand/collapse of content with `height: auto`.
