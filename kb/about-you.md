# About You — durable facts about the user (read FIRST, like the code KB).

Tag each item [confirmed] (user said/approved) or [inferred] (a guess; promote on confirmation). Lasting habits only — no one-off chatter, no secrets.

## Working style
- Prefers SIMPLE Telugu, everyday words, no technical jargon. [confirmed]
- Says "take over" → wants you to decide and drive; ask few questions, then act. [confirmed]

## Tech & preferences
- (none recorded yet — add as learned)

## Project goals
- Extend claude-kb so the KB also understands the USER and self-evolves, not just maps code. [confirmed]
- The KB should self-evolve by auto-creating its OWN Claude Code subagents (`.claude/agents/`) for KB upkeep. [confirmed]

## Decisions & rules
- README only LINKS to the prompt files — no embedded copies (removed 2026-06-29 to kill the embed+sync drift). [confirmed]
- Prefers AUTOMATION/verification over relying on discipline or memory — wants checks (scripts/hooks) that catch mistakes, not just written rules. [confirmed]
- claude-kb must stay FULLY language/framework-agnostic — prompts & rules work for ALL languages and frameworks, never specialized to one (not Flutter-only). [confirmed]
- End any code/config change with a visible "KB: updated <note>" / "no change needed" status line — never make the user ask. [confirmed]

See [[conventions]] for note rules, [[overview]] for what this repo is.
