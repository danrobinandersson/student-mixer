#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-}"   # optional: owner/repo
FILE="${2:-issues.csv}"

# If you want to target a repo without being in the git folder, pass it:
# ./create_issues.sh yourname/yourrepo issues.csv

tail -n +2 "$FILE" | while IFS=',' read -r title difficulty labels body; do
  # remove surrounding quotes (basic CSV handling)
  title="${title%\"}"; title="${title#\"}"
  labels="${labels%\"}"; labels="${labels#\"}"
  body="${body%\"}"; body="${body#\"}"

  if [[ -n "$REPO" ]]; then
    gh issue create --repo "$REPO" --title "$title" --body "$body" --label "$labels"
  else
    gh issue create --title "$title" --body "$body" --label "$labels"
  fi
done