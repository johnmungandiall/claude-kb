# Gotchas — traps specific to this repo. Read before editing prompts or notes.

- **README mirrors all 3 prompts.** `README.md` embeds the full text of
  `prompt.md`, `update.md`, `verify.md` in ````markdown blocks. Edit a prompt →
  mirror into its block, or they drift. Verify with the diff gate (see [[cheatsheet]]).
- **CLAUDE.md is a POINTER only.** Never duplicate KB content into it; edit the
  `kb/` files instead. Change the KB map line only when a `kb/` file is added/removed.
- **Line-number refs go stale.** Notes/CLAUDE.md that cite `README.md:NN` or
  `update.md:NN` break when a prompt shifts. Prefer section names; refresh refs in
  the SAME edit. This is why `verify.md` exists.
- **Unicode matters.** Files use `—` (em dash), `→`, `≤`. Preserve them as UTF-8;
  don't let an editor mangle them.
- **Embedded prompt copies in README.** The lean `## Knowledge Base` block and the
  `kb/about-kb.md` template each live in `prompt.md` AND `update.md`, mirrored again
  in README — the about-kb template is byte-identical across all four. A shared-line
  edit needs `replace_all` (or matching edits) or the copies diverge.

See [[conventions]] for the rules, [[overview]] for the big picture.
