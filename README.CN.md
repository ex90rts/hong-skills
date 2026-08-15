# hong-skills

[English](README.md)

`hong-skills` 是一个用于沉淀和分析个人在工作、生活中总结出的 AI Agent Skills 的仓库。`hong` 的灵感来自“宏命令”：它代表一种强大而易用的快捷范式，也保留了“宏大”的含义，指向可持续扩展的能力集合。

README 只作为仓库索引使用。每个 skill 的详细说明放在 [`docs/`](docs/) 目录。

## 当前 Skills

### 思维训练 Skills

- [`think-router`](docs/think-router.md): 不确定当前问题应该使用仓库里的哪个思维 skill。
- [`critical-thinking`](docs/critical-thinking.md): 需要分析一个看法、断言、论证、决策或现象，检查理由、证据、假设、偏见和替代解释。
- [`beautiful-question`](docs/beautiful-question.md): 问题复杂、模糊、停留在表层症状，需要先找到真正要解决的问题。
- [`first-principle`](docs/first-principle.md): 需要剥离继承来的假设，找到系统的基石前提，并用第一性原理重新推导。
- [`deepthink-5so`](docs/deepthink-5so.md): 需要连续追问“所以呢”，推演某个现象最终可能导致什么结果。
- [`system-thinking`](docs/system-thinking.md): 需要将问题看作一个系统，分析变量、因果链、反馈循环、延迟和相关方。

### 学习 Skills

- [`deep-study-coach`](docs/deep-study-coach.md): 需要设计并执行深度学习闭环、检验是否真正理解、把知识迁移到实践，或诊断无效学习应该返回哪个阶段修正。

### 编程 Skills

- [`coding-art`](docs/coding-art.md): 写代码、代码评审、重构、模块设计、调试或优化时，需要有原则的工程判断。

## 安装

安装全部 skills 到默认 Agent skills 目录：

```bash
scripts/install.sh
```

安装全部 skills 到 Codex：

```bash
scripts/install.sh --target codex
```

安装全部 skills 到 Claude Code：

```bash
scripts/install.sh --target claude
```

只安装某一个 skill：

```bash
scripts/install.sh --target codex --skill coding-art
```

安装多个指定 skills：

```bash
scripts/install.sh --target codex --skill beautiful-question --skill coding-art
```

安装到自定义 skills 目录：

```bash
scripts/install.sh --dest /path/to/skills --all
```

如果目标目录已经存在同名 skill，脚本默认跳过。需要覆盖时添加 `--force`：

```bash
scripts/install.sh --target codex --force
```

可先使用 `--dry-run` 预览安装动作：

```bash
scripts/install.sh --target codex --dry-run
```

默认目标目录：

| Target   | 目录               |
| -------- | ------------------ |
| `agents` | `~/.agents/skills` |
| `codex`  | `~/.codex/skills`  |
| `claude` | `~/.claude/skills` |

## 使用

安装后，用 skill frontmatter 中的名称调用：

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

```text
Use $deep-study-coach to help me learn this topic deeply and verify that I can apply it: ...
```

如果不确定该用哪个仓库 skill，先使用路由：

```text
Use $think-router to help me choose the right skill for my problem: ...
```

也可以直接用中文表达：

```text
使用 $think-router 帮我判断这个问题适合用哪个 skill：...
```

## 仓库结构

```text
skills/
  <skill-name>/
    SKILL.md
    references/
    assets/
    agents/

docs/
  <skill-name>.md

scripts/
  install.sh
```

`skills/` 存放可安装的 skill 包。`docs/` 存放每个 skill 的面向人的详细说明。`scripts/install.sh` 负责把选中的 skills 复制到目标 Agent skills 目录。

## 添加新的 Skill

建议结构：

```text
skills/
  your-skill-name/
    SKILL.md
    references/
    assets/
    agents/
      openai.yaml
```

新增或修改 skill 时，请同步更新：

- `README.md`
- `README.CN.md`
- `docs/<skill-name>.md`
- `skills/think-router/references/skill-catalog.md`，如果希望它能被 `think-router` 推荐

README 中只保留简短索引。使用细节、适用边界和资源说明放到 `docs/`。
