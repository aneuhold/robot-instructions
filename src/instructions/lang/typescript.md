### TypeScript

#### Types

- NEVER use `any`.
- Where a value arrives untyped at a system boundary (`JSON.parse`, file reads, wire responses, incorrect library types), `unknown` is the staging type. Narrow it with a type guard or runtime schema before use. It never reaches the rest of the code unnarrowed.
- Never use `as`. Refactor, reach for generics, or narrow with a type guard instead. `as unknown as X` falls under the same rule. If nothing else works, ask, and do not assume permission is granted.
- Never use the `!` non-null assertion operator. Check for null / undefined properly if it can be null.
- Add explicit types when unclear; extract complex object types to separate `type` declarations. Inline types only for single properties.
- Let TypeScript infer a return type when the body returns a fully typed value. Variables get explicit types. Where the project's lint config requires explicit return types, follow it.
- Use PascalCase for type names.
- Prefix generic type parameters with `T` (e.g. `TSubscription`, `TResult`), so they read differently from concrete types.
- Always order types from the highest-level type first, down to the lowest-level type. A type that references another comes before the type it references.
- Use TypeScript `enum` (not `const enum` or `type`) with PascalCase for names and values. Prefer a string enum over a string union.

#### Functions and classes

- Use arrow functions and `const`/`let` (never `var`).
- Use `async`/`await` instead of `.then()`.
- Order methods by visibility: public, protected, private. Put static methods before instance methods.
- Never prefix functions/methods with underscores.
- If a method isn't used outside its own class, it should be private.
- Don't export a bunch of random functions from a file. Prefer services / classes.

#### Files and imports

- File names match the primary exported type. A file that primarily exports a single class is named after that class.
- Use relative imports within package, package references for external packages.
- Use named imports only (never `import * as`).
- Import at file top (inline only when absolutely necessary).
- Only use a barrel file when a folder has a single public export and all other files in the folder are internal implementation details consumed exclusively by that export. Do not create barrel files that aggregate exports from multiple unrelated modules.

#### Documentation

- Add JSDoc for all methods, functions, and classes. Include `@param` only when a parameter is non-intuitive. Omit `@returns` always.
- Add JSDoc for public class properties only if complex.

#### Syntax

- Never use `['propertyName']` syntax to access properties, always use `.propertyName` unless the property name is dynamic. Even then though, a variable / constant should be used instead of a string literal.
- Use object destructuring when accessing multiple properties from an object.
- Prefer template literals over string concatenation.
