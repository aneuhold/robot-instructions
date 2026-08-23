### NestJS

- Any file that primarily exports a single class should have a name that reflects that class. For example a class `HouseSalesService` should be in a file named `HouseSales.service.ts`. Its corresponding module would be `HouseSales.module.ts`, and if it has a controller, it would be `HouseSales.controller.ts`.
- Use `kebab-case` for folder names.
- End-to-end test files are `.e2e.spec.ts`, with the root describe reflecting the endpoint being tested, like `/dashboard (GET)`.
