### Engineering

- Avoid code duplication; reuse existing code when possible.
- Refactor to integrate new functionality. DO NOT bolt things on like an afterthought. If you are purely adding a massive block of code into an existing service, you are probably doing something wrong. Rethink your approach.
- Always prefer to refactor rather than try to "preserve backwards compatibility".
- Never alias code because you are too lazy to actually update existing code. If you are being asked to refactor code, then refactor it. Don't make it so old callers still call the same function / method that points at a new one.
- If something isn't being used outside of the file it is defined in, then don't export it.
- If you need to create something new, try to organize it among the existing items that are similar.
- Keep responses and code concise, focused, and clean.
- Never run `git commit`. Do not commit at phase boundaries, at end of session, or after verification passes. Commits are always manual.
