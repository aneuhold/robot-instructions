# robot-instructions

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
@node_modules/@aneuhold/robot-instructions/src/instructions/typescript.md

@node_modules/@aneuhold/robot-instructions/src/instructions/node.md
```

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

## Framework

@~/.claude/node_modules/@aneuhold/robot-instructions/src/instructions/framework/react.md

@~/.claude/node_modules/@aneuhold/robot-instructions/src/instructions/framework/nextjs.md
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
