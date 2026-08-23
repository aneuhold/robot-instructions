### CSS

- Use modern CSS syntax and features whenever possible.
- Never use inline styles. Always use CSS classes.
- Keep the number of CSS classes to the absolute minimum. Using a small amount of CSS classes is a good indication that you are leveraging CSS correctly. If you find yourself needing to add a large number of CSS classes to a component, it's often a sign you need to take a step back and rethink your approach.
- Use the theme's CSS custom properties. Never hardcode color values.
- Prefer smooth, eased transitions (0.5s+) over abrupt snaps. Elements appearing or disappearing should fade or slide rather than pop in and out.
- Animations respect `prefers-reduced-motion`.
