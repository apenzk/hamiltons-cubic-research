#!/bin/sh
# Synthetic check that both_loops_balance both FIRES on a Lean-only run and RESETS
# when a non-Lean-scoped commit lands. Throwaway repo, removed at the end.
BASE=/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad
SRC=.claude/hooks
T="$BASE/gatetest"
rm -rf "$T"; mkdir -p "$T/.claude/hooks"
cd "$T"
git init -q .
cp "$SRC/both_loops_balance.py" "$SRC/loop_flag.py" .claude/hooks/
printf 'session: testsid\n' > .claude/lean-loop-active
printf 'session: testsid\n' > .claude/research-loop-active
printf '## SECTION 1, ADVANCE THE PROOFS\n\n- [ ] **IX, a test item.**\n' > plan.md
git add -A
git -c user.email=aaa@aaa.com -c user.name=t commit -qm "chore: seed"
printf 'testsid %s\n' "$(python3 -c 'import time;print(time.time()-3600)')" > .claude/.both-loops-since

run() {
  printf '{"cwd":"%s","session_id":"testsid"}' "$T" \
    | CLAUDE_PROJECT_DIR="$T" CLAUDE_CODE_SESSION_ID=testsid \
      python3 .claude/hooks/both_loops_balance.py > /tmp/gt.out 2>&1
  rc=$?
  printf 'exit=%s\n' "$rc"
}

for i in 1 2 3; do
  echo "$i" > "f$i"; git add "f$i"
  git -c user.email=aaa@aaa.com -c user.name=t commit -qm "feat(lean): round $i"
done

echo "=== three feat(lean) at HEAD, expect exit=2 ==="
run
head -1 /tmp/gt.out

echo "=== docs(findings) on top, expect exit=0 ==="
echo x > g; git add g
git -c user.email=aaa@aaa.com -c user.name=t commit -qm "docs(findings): a research deliverable"
run

cd "$BASE"; rm -rf "$T"
