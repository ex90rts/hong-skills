# hong-skills

[中文](README.CN.md)

`hong-skills` is a personal collection of AI agent skills distilled from everyday work and life. The name `hong` is inspired by macro commands: a powerful yet easy-to-use shortcut pattern for reusable capability, while also carrying a sense of breadth and ambition.

The README is the repository index. Detailed notes for each skill live in [`docs/`](docs/).

## Current Skills

### Thinking Skills

- [`think-router`](docs/think-router.md): Skill router. Use when you are unsure which thinking skill in this repository fits the current problem.
- [`critical-thinking`](docs/critical-thinking.md): Thinking / argument evaluation. Use when you need to examine a view, claim, argument, decision, or phenomenon by checking reasons, evidence, assumptions, bias, and alternatives.
- [`beautiful-question`](docs/beautiful-question.md): Thinking / problem solving. Use when a problem is vague, shallow, or stuck at the symptom level, and you need to find the real question before solving it.
- [`first-principle`](docs/first-principle.md): Thinking / innovation. Use when you need to strip away inherited assumptions, find the system's base premise, and rebuild from first principles.
- [`deepthink-5so`](docs/deepthink-5so.md): Thinking / consequence inference. Use when you need to repeatedly ask "so what?" to infer what a phenomenon may eventually lead to.
- [`system-thinking`](docs/system-thinking.md): Thinking / systems analysis. Use when you need to map variables, causal chains, feedback loops, delays, and stakeholders in a complex system.

### Coding Skills

- [`coding-art`](docs/coding-art.md): Software engineering. Use when you are writing, reviewing, refactoring, designing, debugging, or optimizing code and want principled engineering judgment.

## Installation

Install all skills into the default Agent skills directory:

```bash
scripts/install.sh
```

Install all skills into Codex:

```bash
scripts/install.sh --target codex
```

Install all skills into Claude Code:

```bash
scripts/install.sh --target claude
```

Install one skill only:

```bash
scripts/install.sh --target codex --skill coding-art
```

Install several selected skills:

```bash
scripts/install.sh --target codex --skill beautiful-question --skill coding-art
```

Install into a custom skills directory:

```bash
scripts/install.sh --dest /path/to/skills --all
```

If a destination skill already exists, the installer skips it by default. Add `--force` to replace existing directories:

```bash
scripts/install.sh --target codex --force
```

Preview install actions without copying files:

```bash
scripts/install.sh --target codex --dry-run
```

Default destinations:

| Target   | Directory          |
| -------- | ------------------ |
| `agents` | `~/.agents/skills` |
| `codex`  | `~/.codex/skills`  |
| `claude` | `~/.claude/skills` |

## Usage

After installation, invoke a skill by its frontmatter name:

```text
Use $coding-art to review this module's design and point out code-quality risks.
```

```text
Use $critical-thinking to examine this view or phenomenon: ...
```

```text
Use $beautiful-question to help me clarify and solve this problem: ...
```

```text
Use $first-principle to rebuild this strategy from first principles: ...
```

```text
Use $deepthink-5so to explore what this phenomenon could ultimately lead to: ...
```

```text
Use $system-thinking to analyze this problem as a system: ...
```

If you are not sure which repository skill to use, start with:

```text
Use $think-router to help me choose the right skill for my problem: ...
```

Chinese prompts work as well:

```text
使用 $think-router 帮我判断这个问题适合用哪个 skill：...
```

## Repository Layout

```text
skills/
  <skill-name>/
    SKILL.md
    references/
    agents/

docs/
  <skill-name>.md

scripts/
  install.sh
```

`skills/` contains installable skill packages. `docs/` contains human-facing documentation for each skill. `scripts/install.sh` copies selected skills into the target agent skills directory.

## Adding A Skill

Recommended structure:

```text
skills/
  your-skill-name/
    SKILL.md
    references/
    agents/
      openai.yaml
```

When adding or changing a skill, update:

- `README.md`
- `README.CN.md`
- `docs/<skill-name>.md`
- `skills/think-router/references/skill-catalog.md`, if the skill should be discoverable through `think-router`

Keep README entries short. Put usage details, scope, and resources in `docs/`.
