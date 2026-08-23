# robot-instructions

Source of the shared instruction files published as `@aneuhold/robot-instructions`. Everything under `src/` is consumed by reference from another instruction file.

## The paste model

A reference like `@node_modules/@aneuhold/robot-instructions/src/instructions/lang/typescript.md` behaves as if that file's full text sits at that spot in the consuming file.

This package is one layer, not the only location for instructions. A consuming file references the layers it stands on, then adds whatever is specific to that machine or repo below them. Paths, aliases, script names, org slugs, and machine policy belong in that local text, not here.

Two things follow.

**Formatting has to be identical across every file here**, since several land in the same document:

- Exactly one `###` per file, on the first line, naming the layer. Never `#` or `##`, which belong to the consumer.
- `####` for sections. Sections chosen are up to the file.
- No scope line in the body. The file path states the scope.

**Every file has to stand alone.** No references to another file in this package, to a repo, to a path, or to "above" and "below". Position and neighbors vary per consumer.
