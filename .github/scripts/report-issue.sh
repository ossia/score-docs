#!/usr/bin/env bash
# Open an issue for a failed scheduled check, or comment on the one already open.
# Usage: report-issue.sh "<issue title>" <log file>     (needs GH_TOKEN)
set -euo pipefail
title="$1"
log="$2"
label="automated-check"
run_url="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"

body="$(printf 'The scheduled check failed: %s\n\n<details><summary>Last lines of the log</summary>\n\n```\n%s\n```\n\n</details>\n' \
  "$run_url" "$(tail -n 80 "$log" 2>/dev/null || echo 'no log')")"

gh label create "$label" --color BFD4F2 --description "Opened by a scheduled check" 2>/dev/null || true
existing="$(gh issue list --state open --label "$label" --search "\"$title\" in:title" --json number,title \
  --jq ".[] | select(.title == \"$title\") | .number" | head -n 1)"
if [ -n "$existing" ]; then
  gh issue comment "$existing" --body "$body"
else
  gh issue create --title "$title" --label "$label" --body "$body"
fi
