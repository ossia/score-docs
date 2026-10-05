#!/usr/bin/env bash
# Summarize ossia score examples for documentation work.
#
# For every .score given (files or folders, searched recursively), launches
# ossia score headlessly on it, runs summarize.js on the loaded document and
# writes <name>.summary.md next to the .score. Process and protocol keys are
# resolved to the source files declaring them in the score repository.
#
# Usage: summarize.sh [options] <file.score|folder>...
#   -t SECONDS   per-file timeout (default 90)
#   -f           regenerate summaries that are newer than their .score
#   -d DISPLAY   X display number to use (default 79); an Xvfb is started on it
#                if none is running, and stopped at the end
#   -k           keep each run's temporary directory and log
#   -h           help
#
# Environment:
#   SCORE_BIN    ossia score binary (default ~/ossia/score-workshop/build-developer/ossia-score)
#   SCORE_ROOT   score source tree for key lookups (default ~/ossia/score-workshop)
#
# Exit status: 0 if every file succeeded, 1 otherwise. Failures are listed at
# the end; the log of a failed run is kept and its path printed.

set -u

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JS="$HERE/summarize.js"
SCORE_BIN="${SCORE_BIN:-$HOME/ossia/score-workshop/build-developer/ossia-score}"
SCORE_ROOT="${SCORE_ROOT:-$HOME/ossia/score-workshop}"
TIMEOUT=90
FORCE=0
DISP=79
KEEP=0

usage() { sed -n '2,24p' "$0" | sed 's/^# \{0,1\}//'; }

while getopts "t:fd:kh" opt; do
  case "$opt" in
    t) TIMEOUT="$OPTARG" ;;
    f) FORCE=1 ;;
    d) DISP="$OPTARG" ;;
    k) KEEP=1 ;;
    h) usage; exit 0 ;;
    *) usage; exit 2 ;;
  esac
done
shift $((OPTIND - 1))
[ $# -gt 0 ] || { usage; exit 2; }

[ -x "$SCORE_BIN" ] || { echo "error: score binary not found: $SCORE_BIN" >&2; exit 2; }
[ -f "$JS" ] || { echo "error: $JS missing" >&2; exit 2; }
ls "$(dirname "$SCORE_BIN")/plugins" 2>/dev/null | grep -q 'score_plugin_js' \
  || echo "warning: no JS plugin next to $SCORE_BIN, --script will be ignored" >&2

# ------------------------------------------------------------------ inputs
FILES=()
for arg in "$@"; do
  if [ -d "$arg" ]; then
    while IFS= read -r -d '' f; do FILES+=("$f"); done \
      < <(find "$arg" -type f -name '*.score' -print0 | sort -z)
  elif [ -f "$arg" ]; then
    FILES+=("$arg")
  else
    echo "warning: skipping $arg (not found)" >&2
  fi
done
[ ${#FILES[@]} -gt 0 ] || { echo "no .score files" >&2; exit 2; }

WORK="$(mktemp -d -t score-summary.XXXXXX)"
LOGDIR="${TMPDIR:-/tmp}/score-summary-logs"   # logs of failed runs are kept here
CACHE="$WORK/keys.tsv"          # key <TAB> path, or key <TAB> (empty) if unresolved
: > "$CACHE"

# ------------------------------------------------------------------ display
XVFB_PID=""
cleanup() {
  [ -n "$XVFB_PID" ] && kill "$XVFB_PID" 2>/dev/null
  [ "$KEEP" = 1 ] || rm -rf "$WORK"
}
trap cleanup EXIT
trap 'exit 130' INT TERM

if [ ! -e "/tmp/.X11-unix/X$DISP" ]; then
  Xvfb ":$DISP" -screen 0 1920x1080x24 +extension GLX +render -noreset \
    > "$WORK/xvfb.log" 2>&1 &
  XVFB_PID=$!
  for _ in $(seq 50); do [ -e "/tmp/.X11-unix/X$DISP" ] && break; sleep 0.1; done
  [ -e "/tmp/.X11-unix/X$DISP" ] || { echo "error: Xvfb :$DISP did not start" >&2; cat "$WORK/xvfb.log" >&2; exit 2; }
fi

# ------------------------------------------------------------------ key lookup
# Resolve every key in $1 (one per line) that is not cached yet, in one pass
# over the source tree, keeping the most plausible declaring file per key.
resolve_keys() {
  local keys="$1" todo="$WORK/todo.txt"
  sort -u "$keys" | while read -r k; do
    [ -n "$k" ] && ! grep -q "^$k	" "$CACHE" && echo "$k"
  done > "$todo"
  [ -s "$todo" ] || return 0
  local dirs=()
  for d in src 3rdparty/avendish; do [ -d "$SCORE_ROOT/$d" ] && dirs+=("$d"); done
  (
    cd "$SCORE_ROOT" || exit
    if command -v rg >/dev/null; then
      rg --no-ignore --no-heading -n -i -F -f "$todo" "${dirs[@]}" \
        -g '!**/[Tt]ests/**' -g '!**/[Tt]est/**' -g '!*.score' -g '!*.json' \
        -g '!*.md' -g '!*.txt' -g '!*.svg' 2>/dev/null
    else
      grep -rni -F -f "$todo" "${dirs[@]}" --exclude-dir=tests --exclude-dir=Tests \
        --exclude='*.score' --exclude='*.json' --exclude='*.md' 2>/dev/null
    fi
  ) | awk -v todo="$todo" '
      BEGIN { while ((getline k < todo) > 0) keys[k] = 1 }
      {
        file = $0; sub(/:.*/, "", file)
        text = $0; sub(/^[^:]*:[^:]*:/, "", text)
        ltext = tolower(text)
        for (k in keys) if (index(ltext, k)) {
          s = 0
          if (text ~ /uuid|UUID|Uuid|halp_meta|Metadata|concreteKey|static_key/) s += 4
          if (file ~ /\.(hpp|h|cpp)$/) s += 2
          if (file ~ /[Tt]est|[Ee]xample.*[Tt]est/) s -= 6
          if (!(k in best) || s > bs[k] || (s == bs[k] && length(file) < length(best[k]))) { best[k] = file; bs[k] = s }
          n[k]++
        }
      }
      END {
        for (k in keys) printf "%s\t%s\n", k, ((k in best) ? best[k] : "")
      }' >> "$CACHE"
}

# Replace @@SRC:key@@ markers using the cache.
apply_keys() {
  local in="$1" out="$2"
  awk -F'\t' -v cache="$CACHE" '
    BEGIN { FS = "\t"; while ((getline line < cache) > 0) { split(line, a, "\t"); m[a[1]] = a[2] } FS = " " }
    {
      while (match($0, /@@SRC:[^@]*@@/)) {
        k = substr($0, RSTART + 6, RLENGTH - 8)
        r = (k in m && m[k] != "") ? "`" m[k] "`" : "(not found)"
        $0 = substr($0, 1, RSTART - 1) r substr($0, RSTART + RLENGTH)
      }
      print
    }' "$in" > "$out"
}

# ------------------------------------------------------------------ one file
SCRIPT_TEXT="$(cat "$JS")"
XDOTOOL="$(command -v xdotool || true)"
OK=(); FAILED=(); SKIPPED=()

run_one() {
  local score="$1"
  local abs; abs="$(cd "$(dirname "$score")" && pwd)/$(basename "$score")"
  local out="${abs%.score}.summary.md"
  if [ "$FORCE" = 0 ] && [ -f "$out" ] && [ "$out" -nt "$abs" ] && [ "$out" -nt "$JS" ]; then
    SKIPPED+=("$score"); echo "skip  $score (up to date)"; return 0
  fi

  local run; run="$(mktemp -d "$WORK/run.XXXXXX")"
  mkdir -p "$run/tmp" "$run/config/ossia" "$run/cache" "$run/data"
  local raw="$run/summary.raw.md" err="$run/error.txt" log="$run/score.log"
  local t0=$SECONDS

  # Shown in the header: the path relative to the nearest "assets/scores" or as given.
  local shown="$abs"
  case "$abs" in */assets/scores/*) shown="assets/scores/${abs#*/assets/scores/}" ;; esac

  (
    export TMPDIR="$run/tmp" XDG_CONFIG_HOME="$run/config" XDG_CACHE_HOME="$run/cache" \
           DISPLAY=":$DISP" LIBGL_ALWAYS_SOFTWARE=1 \
           SCORE_AUDIO_BACKEND=dummy SCORE_LOCAL_OSC_PORT=0 SCORE_LOCAL_WS_PORT=0 \
           QT_FORCE_STDERR_LOGGING=1 \
           SCORE_SUMMARY_OUT="$raw" SCORE_SUMMARY_ERR="$err" SCORE_SUMMARY_SRC="$shown"
    cd "$run" || exit 1
    exec setsid "$SCORE_BIN" --no-restore --script "$SCRIPT_TEXT" "$abs"
  ) > "$log" 2>&1 &
  local pid=$! rc="" timed_out=0 last_esc="" escapes=0
  while kill -0 "$pid" 2>/dev/null; do
    if [ $((SECONDS - t0)) -ge "$TIMEOUT" ]; then
      timed_out=1
      kill -TERM -- "-$pid" 2>/dev/null
      for _ in $(seq 20); do kill -0 "$pid" 2>/dev/null || break; sleep 0.25; done
      kill -KILL -- "-$pid" 2>/dev/null
      break
    fi
    # A modal dialog (load error, "reload your work?"...) blocks startup:
    # dismiss it on our private display once in a while.
    if [ -n "$XDOTOOL" ] && [ $((SECONDS - t0)) -ge 20 ] && [ $(( (SECONDS - t0) % 10 )) = 0 ] && [ "$last_esc" != "$SECONDS" ]; then
      last_esc=$SECONDS; escapes=$((escapes + 1))
      DISPLAY=":$DISP" "$XDOTOOL" key Escape 2>/dev/null
    fi
    sleep 0.25
  done
  wait "$pid" 2>/dev/null; rc=$?
  # Children score left behind (plug-in scanners...) share its process group.
  kill -KILL -- "-$pid" 2>/dev/null

  local dt=$((SECONDS - t0)) reason=""
  [ "$escapes" -gt 0 ] && echo "      ($escapes Escape key presses sent to dismiss dialogs)"
  if [ -s "$raw" ]; then
    grep -o '@@SRC:[^@]*@@' "$raw" | sed 's/@@SRC:\(.*\)@@/\1/' > "$run/keys.txt"
    resolve_keys "$run/keys.txt"
    apply_keys "$raw" "$out.tmp" && mv "$out.tmp" "$out"
    OK+=("$score")
    printf 'ok    %s (%ss%s)\n' "$score" "$dt" "$([ "$rc" != 0 ] && echo ", exit $rc after writing")"
    [ "$KEEP" = 1 ] || rm -rf "$run"
    return 0
  fi

  if [ -s "$err" ]; then reason="script error: $(head -1 "$err")"
  elif [ "$timed_out" = 1 ]; then reason="timeout after ${TIMEOUT}s"
  else
    reason="exit $rc, no output"
    local crit; crit="$(grep -m1 -E 'Critical:|Fatal:|--script:|Assertion|SIGSEGV|dumped core' "$log")"
    [ -n "$crit" ] && reason="$reason; $crit"
  fi
  mkdir -p "$LOGDIR"
  local keep="$LOGDIR/$(basename "${score%.score}").log"
  cp "$log" "$keep" 2>/dev/null
  [ -s "$err" ] && cat "$err" >> "$keep"
  FAILED+=("$score: $reason (log: $keep)")
  printf 'FAIL  %s (%ss): %s\n' "$score" "$dt" "$reason"
  [ "$KEEP" = 1 ] || rm -rf "$run"
  return 1
}

for f in "${FILES[@]}"; do run_one "$f"; done

echo
echo "${#OK[@]} ok, ${#FAILED[@]} failed, ${#SKIPPED[@]} skipped"
if [ ${#FAILED[@]} -gt 0 ]; then
  echo "failures:"
  printf '  %s\n' "${FAILED[@]}"
  exit 1
fi
exit 0
