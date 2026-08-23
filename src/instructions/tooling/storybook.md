### Storybook

- Each `Story` is an instance of the component being tested, not a wrapper. Build variations accordingly.
- If a wrapper is needed in order to properly demonstrate the functionality of the component, or provide easier access / test data to the various properties of the component, build a separate component next to the original called `SB<ComponentName>Example` and use that as your target component for the story variations.
