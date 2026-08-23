# Instruction Grouping Plan

Plan for splitting the instruction content spread across eight files into shared layers published from this package.

The structure is the stack ladder: files sit at the narrowest technology rung where the rule holds. Authoring rules for the files themselves are in `CLAUDE.md` at the repo root.

## Sources surveyed

| Source                 | Location                                                                                                       |
| ---------------------- | -------------------------------------------------------------------------------------------------------------- |
| Personal global        | `~/.claude/CLAUDE.md`                                                                                          |
| Work global            | `CLAUDE Global from work comptuer.md`                                                                          |
| Work scripts repo      | `CLAUDE in scripts folder on work computer.md`                                                                 |
| Work investigate skill | `SKILL for investigation on work computer.md`                                                                  |
| `ts-libs`              | `.claude/CLAUDE.md`, `.claude/skills/changelog/SKILL.md`                                                       |
| `gcloud-backend`       | `.github/copilot-instructions.md`, `.github/agents/staff-software-engineer.md`                                 |
| `web-mini-apps`        | `.claude/CLAUDE.md`, `.claude/skills/mealplan/`                                                                |
| `main-scripts`         | `.claude/CLAUDE.md`, `.claude/skills/homelab/SKILL.md`                                                         |
| `workout`              | `.github/copilot-instructions.md`, `.claude/skills/*`, `.claude/commands/review-reuse.md`, `.github/prompts/*` |
| `dashboard`            | `.github/copilot-instructions.md`                                                                              |
| `eslint-config`        | No instruction file exists                                                                                     |

## What is actually duplicated

Copy counts across the six personal repos, not counting the two work files.

| Rule                                                               | Copies | Where                                                                                  |
| ------------------------------------------------------------------ | ------ | -------------------------------------------------------------------------------------- |
| Never use `any`                                                    | 6      | all repos                                                                              |
| Arrow functions, `const`/`let`, never `var`                        | 6      | all repos                                                                              |
| `async`/`await` over `.then()`                                     | 6      | all repos                                                                              |
| Never `['propertyName']` access unless dynamic                     | 6      | all repos                                                                              |
| Object destructuring for multiple property reads                   | 6      | all repos                                                                              |
| Template literals over concatenation                               | 6      | all repos                                                                              |
| Named imports only, never `import * as`                            | 6      | all repos                                                                              |
| Imports at file top                                                | 6      | all repos                                                                              |
| PascalCase type names, file name matches primary exported type     | 6      | all repos                                                                              |
| TypeScript `enum`, PascalCase names and values                     | 6      | all repos                                                                              |
| Class method order public, protected, private                      | 6      | all repos                                                                              |
| Never prefix functions or methods with underscores                 | 6      | all repos                                                                              |
| JSDoc on public class properties only if complex                   | 5      | all but `main-scripts`                                                                 |
| Avoid duplication, reuse existing code                             | 5      | `ts-libs`, `gcloud-backend`, `web-mini-apps`, `main-scripts`, `workout`                |
| Verification gate before reporting complete                        | 6      | all repos, with different command lists                                                |
| Never test private methods, never widen visibility for a test      | 3      | `ts-libs`, `gcloud-backend`, `main-scripts`                                            |
| Barrel file policy (single public export)                          | 3      | `web-mini-apps`, `workout`, `dashboard`, word for word                                 |
| Prefer string enums over string unions                             | 3      | `web-mini-apps`, `workout`, `dashboard`                                                |
| Svelte 5 runes, `Singleton*` components, `@component` JSDoc        | 2      | `workout`, `dashboard`                                                                 |
| Storybook `Story` is an instance, `SB<Name>Example.svelte` wrapper | 2      | `workout`, `dashboard`, word for word                                                  |
| `<Name>.service.ts` / `<Name>.service.svelte.ts` naming            | 2      | `workout`, `dashboard`, plus variants in `gcloud-backend` and the work scripts repo    |
| `@aneuhold/core-ts-db-lib` shared library block                    | 2      | `workout`, `dashboard`, near identical                                                 |
| Sentry org slug `anton-neuhold`                                    | 2      | `workout`, `dashboard`                                                                 |
| No em-dash                                                         | 4      | personal global, work global, `main-scripts`, work investigate skill                   |
| No past tense in comments and documentation                        | 3      | personal global, `main-scripts`, work scripts repo (as "never reference old versions") |
| Never tie a doc comment to a specific implementation               | 2      | personal global, `main-scripts`                                                        |
| Refactor rather than preserve backwards compatibility              | 3      | personal global, `ts-libs`, `main-scripts`                                             |

`main-scripts` carries a verbatim copy of three paragraphs from the personal global file. `workout` and `dashboard` are close to identical outside their component library sections.

## Structure

```
src/instructions/
  core/
    communication.md          Tone, terminology, output shape
    documentation.md          Comments, JSDoc policy, tense, coupling
    engineering.md            Reuse, refactoring, export surface, integration over bolting on
    version-control.md        Branch and commit policy shared by every machine
    agent-process.md          Evidence discipline, confirmation, memory, scope authority
  lang/
    typescript.md
    css.md
    markdown.md
  runtime/
    node.md                   Package manager scripts, ESM import extensions
    browser.md
  framework/
    react.md
    nextjs.md
    svelte.md
    sveltekit.md
    nestjs.md
  tooling/
    vitest.md
    storybook.md
    npm-package.md            Published package surface, changelogs, versioning
  ui/
    tailwind.md
    shadcn-svelte.md
    smui.md
  skills/
```

`src/skills/` stays empty for now. The work `investigate` skill, the `ts-libs` `changelog` skill, and the `workout` `review-reuse` command are generic in structure but repo-shaped as written, and they wait until there is a reason to move them.

`core/` is the only rung split by subject, because it has no stack to split by. Every higher rung is already narrow enough that one file per technology is the right size.

## Composition

A consuming file references the rungs it stands on, widest first, then adds its own content below. Ordering widest to narrowest means a narrower rule reads as a refinement of the one before it, and local content reads as a refinement of everything above.

The consumer owns `#` and `##`, so references group under headings it chooses. Every published file starts at `###`.

```md
# workout

## Core

@node_modules/@aneuhold/robot-instructions/src/instructions/core/communication.md

@node_modules/@aneuhold/robot-instructions/src/instructions/core/documentation.md

@node_modules/@aneuhold/robot-instructions/src/instructions/core/engineering.md

@node_modules/@aneuhold/robot-instructions/src/instructions/core/version-control.md

@node_modules/@aneuhold/robot-instructions/src/instructions/core/agent-process.md

## Language

@node_modules/@aneuhold/robot-instructions/src/instructions/lang/typescript.md

@node_modules/@aneuhold/robot-instructions/src/instructions/lang/css.md

## Framework

@node_modules/@aneuhold/robot-instructions/src/instructions/runtime/browser.md

@node_modules/@aneuhold/robot-instructions/src/instructions/framework/svelte.md

@node_modules/@aneuhold/robot-instructions/src/instructions/framework/sveltekit.md

## Tooling

@node_modules/@aneuhold/robot-instructions/src/instructions/tooling/vitest.md

@node_modules/@aneuhold/robot-instructions/src/instructions/tooling/storybook.md

@node_modules/@aneuhold/robot-instructions/src/instructions/ui/tailwind.md

@node_modules/@aneuhold/robot-instructions/src/instructions/ui/shadcn-svelte.md

## This repo

### Commands

### Path aliases

### Shared library
```

No file in this package references another, at any rung. A file that pulls in a second file stops being independently composable, since a consumer then cannot take the first without the second. That rules out bundle files of every kind, machine-level and stack-level alike. The reference list in each global or repo file is the composition, and it doubles as a plain statement of what that repo is.

Machine differences are local text in that machine's global file. `core/version-control.md` holds only what both machines agree on (never run `git commit`). The personal global adds the co-author prohibition. The work global adds the automatic attribution requirement, plus the force push and rebase rules.

## Rule decisions

Ten rules disagreed between sources. All are settled. Each entry gives the rule as it will read in the shared file, its rung, and what changes.

### `lang/typescript.md`

- **JSDoc `@param`.** Add JSDoc for functions, methods, and classes. Include `@param` only when a parameter is non-intuitive. Never `@returns`. Public class properties get JSDoc only when complex.
  All or none for `@param` is lint-enforced, so it stays out of the text. Changes `web-mini-apps`, `workout`, and `dashboard`, which currently say always include.

- **`unknown`.** Never use `any`. Where a value arrives untyped at a system boundary (`JSON.parse`, file reads, wire responses, incorrect library types), `unknown` is the staging type. Narrow it with a type guard or runtime schema before use. It never reaches the rest of the code unnarrowed.

- **Type assertions (`as`).** Never use `as`. Refactor, reach for generics, or narrow with a type guard instead. `as unknown as X` falls under the same rule. If nothing else works, ask, and do not assume permission is granted.
  Roughly 77 casts exist across the six repos today, concentrated in `ts-libs` (44) and `web-mini-apps` (17). The rule governs new code, so no sweep is required, but the `ts-libs` text that currently permits a boundary cast goes away.

- **Return type annotations.** Let TypeScript infer a return type when the body returns a fully typed value. Give variables explicit types. Where a repo's lint config requires explicit return types, the lint config wins.

- **Non-null assertion `!`.** Never use it. Check for null or undefined properly. Adds the rule to `web-mini-apps`, `workout`, and `dashboard`.

- **String enums over string unions.** Prefer a string enum. Adds the rule to `ts-libs`, `gcloud-backend`, and `main-scripts`.

- **Barrel files.** A barrel file only for a folder with a single public export, where every other file in the folder is an implementation detail of it.

### `tooling/vitest.md`

- **Test file suffix.** Test files are named `filename.spec.ts`, matching the source file name. `workout` and `dashboard` rename their `.test.ts` files during migration rather than carrying a local override.

### `tooling/npm-package.md`

- **Package root barrel.** `index.ts` at package root exporting the public API, and nowhere else in the package. This is a separate rule from the folder-level barrel rule, at a separate rung, and both hold at once.

### `runtime/node.md`

- **Package manager.** Use the repo's package manager scripts, never `npx`. Both machine globals reference this file, so it applies everywhere. Which manager a repo uses stays local to that repo.

### Out of the package

- **Verification gate.** Repo-specific. Each repo states its own commands. Nothing shared.
- **Commit attribution.** Machine-specific. Local text in each global file. `core/version-control.md` still holds what both machines agree on.

## Migration order

Ordered by duplication removed per unit of work.

1. **`lang/typescript.md`.** Six near-identical copies collapse into one, with the rules above settled.
2. **`core/communication.md` and `core/documentation.md`.** Two machines, already close in intent. The banned word list from the work global and the exact-terminology rule from the personal global merge without conflict.
3. **`core/version-control.md`, `core/engineering.md`, `core/agent-process.md`.** Small files, and they unblock everything that currently mixes policy with machine specifics.
4. **`tooling/vitest.md`.** Includes renaming the `.test.ts` files in `workout` and `dashboard`.
5. **`framework/svelte.md` and `framework/sveltekit.md`.** Extracted from `workout` and `dashboard`, which are word for word identical across the Storybook, Singleton, routes, and state management sections.
6. **`lang/css.md`.** The shared parts of the two styling sections (no inline styles, minimum class count, theme variables rather than hardcoded colors) lift out first, leaving small library-specific remainders for `ui/tailwind.md` and `ui/smui.md`.
7. **`framework/react.md` and `framework/nextjs.md`.** Only `web-mini-apps` today, so this is deduplication ahead of need.
8. **`runtime/node.md` and `tooling/npm-package.md`.** From `main-scripts` and `ts-libs`.
9. **Replace repo content with references**, one repo at a time, starting with `main-scripts` since it holds the verbatim copy of the personal global file.
10. **`eslint-config`** gets its first instruction file.

## Alternatives considered

- **Subject chapters.** Directories by subject (`communication.md`, `testing.md`, `file-organization.md`), matching the headings the current files already use. Rejected because every chapter mixes stack levels, so `testing.md` would carry Vitest, Svelte, and NestJS rules at once and repos would read rules for frameworks they do not use. Survives as the subject headings within each file.
- **Bindingness tiers.** Directories by authority (`constitution/`, `conventions/`, `playbooks/`). Rejected because a rule can change tier and moving a file breaks every reference to it. Survives in that a rule which genuinely varies by repo is split rather than tiered: the shared file states the policy and the consuming file states the parameter, as with return type annotations deferring to a repo's lint config.
- **Presets.** Reference-only files named after situations. Rejected because the reference list in a global or repo file already is the composition, and a preset layer would hide it behind a second hop.
