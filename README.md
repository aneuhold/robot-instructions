# robot-instructions

[![NPM](https://img.shields.io/npm/v/%40aneuhold%2Frobot-instructions)](https://www.npmjs.com/package/@aneuhold/robot-instructions)

A collection of organized markdown instructions and skills for AI coding agents, published to npm as `@aneuhold/robot-instructions`.

## 📥 Consuming

These files are meant to be referenced directly from a markdown instruction file rather than read through code.

See docs for different tools:

- [Claude Code file imports](https://code.claude.com/docs/en/memory#import-additional-files) (`@path/to/import` syntax)

### Updating

Update every global location the package is installed in:

```sh
for dir in ~/.claude; do
  [ -d "$dir/node_modules/@aneuhold/robot-instructions" ] &&
    (cd "$dir" && pnpm update --latest @aneuhold/robot-instructions)
done
```

Locations without the package installed are skipped. Add further paths to the `for` list as other global locations come into use.

### Project scope

Install the package as a dev dependency:

```sh
pnpm add -D @aneuhold/robot-instructions
```

Reference it from the project's robot file by its path under `node_modules` using it's particular syntax.

<details>
<summary>For Claude Code</summary>

```md
# Some overall title

Your normal instructions or caveats to the project instructions

<!-- Always put these at the bottom. Order matters, but the placement does not, so it's better to put
it where it will end up being output in the context window anyway -->

@node_modules/@aneuhold/robot-instructions/src/instructions/lang/typescript.md
@node_modules/@aneuhold/robot-instructions/src/instructions/runtime/node.md
```

Each referenced file is appended as its own labeled block after the referencing file. It is not spliced in at the `@` line, which stays literal where it sits. Files linked into `.claude/rules/` are delivered the same way.

---

</details>

### User scope

Install the package into a global location, such as `~/.claude` and import it from the global instruction file.

<details>
<summary>For Claude Code</summary>

```sh
cd ~/.claude
pnpm init
pnpm add -D @aneuhold/robot-instructions
```

Run `pnpm init` first if `~/.claude/package.json` does not exist.

The import then reads:

```md
# Some overall title

Your general instructions

<!-- Leave the references at the bottom -->

@~/.claude/node_modules/@aneuhold/robot-instructions/src/instructions/framework/svelte.md
@~/.claude/node_modules/@aneuhold/robot-instructions/src/instructions/framework/sveltekit.md
```

`~/.claude` is not an ancestor of a project directory, so its `node_modules` stays invisible to project builds.

---

</details>

## 🚀 Publishing

Just bump the version and push it up to main. To do both at once run:

```sh
pnpm pushpub
```

## 📁 Structure

All published content lives under `src/`, grouped by kind:

```
src/
├── instructions/   # Instruction documents
└── skills/         # Skill documents
```

Only `src/**/*` is included in the published package.
