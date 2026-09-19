# robot-instructions

[![NPM](https://img.shields.io/npm/v/%40aneuhold%2Frobot-instructions)](https://www.npmjs.com/package/@aneuhold/robot-instructions)

A collection of organized markdown instructions, skills, and status line scripts for AI coding agents, published to npm as `@aneuhold/robot-instructions`.

## 📥 Consuming

Instructions are meant to be referenced directly from a markdown instruction file, skills are meant to be symlinked into a skills directory, and status line scripts are meant to be run by path. None of it is read through code.

See docs for different tools:

- [Claude Code file imports](https://code.claude.com/docs/en/memory#import-additional-files) (`@path/to/import` syntax)
- [Claude Code skills](https://code.claude.com/docs/en/skills) (symlinked skill folders)
- [Claude Code status lines](https://code.claude.com/docs/en/statusline)

### Updating

Update every global location the package is installed in, and link its skills:

```sh
for dir in ~/.claude; do
  package="$dir/node_modules/@aneuhold/robot-instructions"
  [ -d "$package" ] || continue
  (cd "$dir" && pnpm update --latest @aneuhold/robot-instructions)
  mkdir -p "$dir/skills"
  for skill in "$package"/src/skills/*/; do
    ln -sfn "${skill%/}" "$dir/skills/$(basename "$skill")"
  done
done
```

Locations without the package installed are skipped. Add further paths to the `for` list as other global locations come into use. Re-running is safe, since `ln -sfn` replaces a skill's existing link instead of nesting a new one inside it.

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

### Status lines

`src/statuslines/` holds shell scripts that run the "status line" concept in various robot systems.

- `context-usage.sh` shows context-window usage and prompt cache warmth: `ctx 27% (54k/1M) · cache warm (42m)`.
  - The percentage is green below 50, yellow from 50, and red from 80.
  - The cache reads green `warm` with the whole minutes left before it expires (`<1m` in the last minute), or red `stale` once it has expired.

<details>
<summary>For Claude Code</summary>

Add the script to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.claude/node_modules/@aneuhold/robot-instructions/src/statuslines/context-usage.sh",
    "refreshInterval": 300
  }
}
```

`refreshInterval` re-runs the script every 300 seconds on top of the event-driven updates, so the minutes left keep counting down while the session is idle. Claude Code also re-runs the script when the cache expires, so the switch to `stale` is on time regardless of the interval. See [how status lines update](https://code.claude.com/docs/en/statusline#how-status-lines-work).

The cache segment reads the `prompt_cache` field, which requires Claude Code v2.1.251 or later. It shows `cache --` until the session's first API response.

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
├── skills/         # Skill documents
└── statuslines/    # Status line scripts
```

Only `src/**/*` is included in the published package.
