# robot-instructions

Source of the shared instructions, skills, and status line scripts published as `@aneuhold/robot-instructions`. Instructions under `src/instructions/` are consumed by reference from another instruction file. Skills under `src/skills/` are consumed by symlinking each skill folder into a skills directory, so a folder's name is the name the skill is invoked by. Status line scripts under `src/statuslines/` are consumed by pointing a tool's status line command at the file's path inside `node_modules`.

## How instructions reach context

A reference like `@node_modules/@aneuhold/robot-instructions/src/instructions/lang/typescript.md` does not splice that file's text into the consuming file. The reference line stays literal where it sits, and the referenced file arrives as its own labeled block after the consuming file. Files linked into a rules directory arrive the same way.

This package is one layer, not the only location for instructions. A consuming file references the layers it stands on, then adds whatever is specific to that machine or repo below them. Paths, aliases, script names, org slugs, and machine policy belong in that local text, not here.

**Formatting has to be identical across every instruction file**, since they arrive as sibling blocks in one context:

- Exactly one `###` per file, on the first line, naming the layer. Consistent depth across siblings, and `#` and `##` stay free for the consumer.
- `####` for sections. Sections chosen are up to the file.
- No scope line in the body. The file path states the scope.

**Every instruction file has to stand alone.** Each one arrives as its own block, and which neighbors it has, if any, varies per consumer. No references to another file in this package, to a repo, to a path, or to "above" and "below".

**Every word costs context**, since these files load into every session that references them:

- Cut anything that restates a neighboring line, explains itself, or hedges. State a rule once, in as few words as carry it.
- Fold a new rule into the line or section already covering its subject. A fresh bullet or section is the last resort, for a subject nothing here names yet.
