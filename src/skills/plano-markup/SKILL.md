---
name: plano-markup
description: Open Plannotator's annotation UI for a markdown file, HTML file, URL, or folder and then respond to the returned annotations.
---

# Plano Markup

## Markdown annotations

!`if [ -z "$ARGUMENTS" ]; then echo "No arguments provided."; else plannotator annotate $ARGUMENTS; fi`

## Your task

The output above will be one of:

1. The exact text `The user approved.`, OR a JSON object with `"decision": "approved"`. The user approved the markdown file(s). If that object also carries a `"feedback"` field, the user approved _with notes_: read them and carry them into subsequent work — they are non-blocking guidance, not a request to revise the file. Otherwise acknowledge with a single sentence ("Approved.") and stop. Either way, do not begin any work.
2. Empty, OR a JSON object with `"decision": "dismissed"`. The user closed the session without requesting changes. Acknowledge with a single sentence ("Annotation session closed.") and stop. Do not begin any work.
3. Plaintext annotation feedback, OR a JSON object with `"decision": "annotated"` and a `"feedback"` field. Address the feedback. The user has reviewed the markdown file(s) and provided specific annotations and comments.
4. A message that the arguments could not be resolved to a file, URL, or folder. The user described what to annotate in natural language: work out which file, URL, or folder they mean, run `plannotator annotate <path-or-url>` yourself with that concrete target (keeping any flags the message echoes), then handle its output per cases 1-3.
5. The exact text `No arguments provided.`. Run `plannotator annotate <path> --gate` in the background on the markdown file you most recently created or updated in this conversation (if there is none, ask which file). Output only the exact command you ran, nothing else. When it completes, handle its output per cases 1-3 without confirming that it completed.
