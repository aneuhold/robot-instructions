### Tailwind

- Use utility classes for styling. No `@apply` in components.
- Always use `cn()` when conditionally applying classes: `class={cn('base-class', condition && 'conditional-class')}`.
- Do not use `w-[100px]` or similar px values. Use Tailwind's spacing scale (e.g. `w-25`) or custom CSS variables if needed. Some things need to still contain the brackets because they actually mean something that needs to be a variable, such as `supports-[backdrop-filter]`.
