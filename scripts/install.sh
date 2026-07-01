#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Install hong-skills into a local AI agent skills directory.

Usage:
  scripts/install.sh [options]

Options:
  --target agents|codex|claude   Install target. Default: agents
  --dest PATH                    Custom destination skills directory
  --skill NAME                   Install one skill only. Can be repeated
  --all                          Install all skills. Default when --skill is omitted
  --force                        Replace existing destination skill directories
  --dry-run                      Print actions without copying files
  -h, --help                     Show this help

Default destinations:
  agents: ~/.agents/skills
  codex:  ~/.codex/skills
  claude: ~/.claude/skills

Examples:
  scripts/install.sh
  scripts/install.sh --target codex
  scripts/install.sh --target claude --skill beautiful-question
  scripts/install.sh --dest /path/to/skills --all --force
EOF
}

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skills_dir="$repo_root/skills"
target="agents"
dest=""
force=0
dry_run=0
install_all=1
selected_skills=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      [[ $# -ge 2 ]] || { echo "Missing value for --target" >&2; exit 2; }
      target="$2"
      shift 2
      ;;
    --dest)
      [[ $# -ge 2 ]] || { echo "Missing value for --dest" >&2; exit 2; }
      dest="$2"
      shift 2
      ;;
    --skill)
      [[ $# -ge 2 ]] || { echo "Missing value for --skill" >&2; exit 2; }
      selected_skills+=("$2")
      install_all=0
      shift 2
      ;;
    --all)
      install_all=1
      selected_skills=()
      shift
      ;;
    --force)
      force=1
      shift
      ;;
    --dry-run)
      dry_run=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ ! -d "$skills_dir" ]]; then
  echo "Skills directory not found: $skills_dir" >&2
  exit 1
fi

if [[ -z "$dest" ]]; then
  case "$target" in
    agents)
      dest="$HOME/.agents/skills"
      ;;
    codex)
      dest="$HOME/.codex/skills"
      ;;
    claude|claude-code)
      dest="$HOME/.claude/skills"
      ;;
    *)
      echo "Unknown target: $target" >&2
      echo "Use --dest PATH for a custom agent skills directory." >&2
      exit 2
      ;;
  esac
fi

skills_to_install=()
if [[ "$install_all" -eq 1 ]]; then
  while IFS= read -r skill_path; do
    skills_to_install+=("$(basename "$skill_path")")
  done < <(find "$skills_dir" -mindepth 1 -maxdepth 1 -type d | sort)
else
  skills_to_install=("${selected_skills[@]}")
fi

if [[ "${#skills_to_install[@]}" -eq 0 ]]; then
  echo "No skills selected for installation." >&2
  exit 1
fi

if [[ "$dry_run" -eq 0 ]]; then
  mkdir -p "$dest"
fi

installed=0
skipped=0

for skill in "${skills_to_install[@]}"; do
  src="$skills_dir/$skill"
  dst="$dest/$skill"

  if [[ ! -f "$src/SKILL.md" ]]; then
    echo "Missing skill or SKILL.md: $skill" >&2
    exit 1
  fi

  if [[ -e "$dst" && "$force" -ne 1 ]]; then
    echo "Skip existing skill: $dst (use --force to replace)"
    skipped=$((skipped + 1))
    continue
  fi

  if [[ "$dry_run" -eq 1 ]]; then
    if [[ -e "$dst" && "$force" -eq 1 ]]; then
      echo "Would replace: $dst"
    fi
    echo "Would install: $src -> $dst"
  else
    if [[ -e "$dst" ]]; then
      rm -rf "$dst"
    fi
    cp -R "$src" "$dst"
    find "$dst" -name '.DS_Store' -exec rm -f {} +
    echo "Installed: $skill -> $dst"
  fi
  installed=$((installed + 1))
done

echo "Done. Installed: $installed. Skipped: $skipped. Destination: $dest"
