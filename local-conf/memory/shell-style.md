---
name: shell-style
description: How the user wants shell scripts written in this dotfiles repo
metadata: 
  node_type: memory
  type: feedback
  originSessionId: baa1a649-c152-448e-bf59-3fc2429111d3
---

For shell scripts in this repo, the user prefers: hardcoded straight-line code over abstractions, as few functions and variables as possible (inline logic instead), copy-pasting duplicated code is fine, long descriptive variable names are welcome, and explicit `panic to stderr + exit 1` on bad states. They want scripts that take no args/flags and are safe to re-run (idempotent).

**Why:** They value simplicity and being able to read the whole flow top-to-bottom over DRY-ness.

**How to apply:** Don't factor things into helpers unless genuinely needed. Ask before making design decisions. POSIX `sh` (not bash-only) for portability across their machines: termux, wsl, void, debian, ubuntu.
