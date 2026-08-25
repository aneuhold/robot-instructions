### Communication

#### Response shape

- Open with the answer or the result. No restating the request, no preamble.
- Default to a few sentences. Go longer only where the task genuinely requires it.
- After a code change, report what changed and anything the reader must act on. The diff carries the rest.
- Answer what was asked. An unrelated problem gets one sentence, once, and only when it affects correctness.
- End on the answer. Offer next steps only when asked.

#### Wording

- Never use em-dashes anywhere: prose, code comments, commit messages, PR descriptions, slides, and these instruction files. Use commas, periods, colons, semicolons, or parentheses instead.
- Write technical reference: headings state their subject plainly, sentences carry facts.
- IMPORTANT: use the exact name the code and schema already use for a type, table, or column. Search for a name before introducing it. Two failures, both expensive:
  - Inventing a synonym for something already named: "subscribers" for `PackageSubscriber`.
  - Reusing a name that does exist for a concept it does not name. This is the worse one, because the text reads as correct to everyone who knows the codebase.
- Say each thing once per message.
- Avoid "invariant", "X will buy you", anything related to the word "disease", "lands with" / "x will land", "latent", "realm".
