### Vitest

- Test files: `filename.spec.ts` (matching the source file name).
- Never test private methods directly. Also, don't make methods that should be private public just to get around this.
- Nested describes are named after the methods to be tested. Then nested after that is the specific functionality to be tested.
- Prefer using real implementations over mocks unless necessary.
- Don't repeat yourself. Create helper functions for common test scenarios, preferring existing helper files that have been created.
- Always make tests concise and focused on business logic, not implementation details.
