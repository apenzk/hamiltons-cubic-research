#!/usr/bin/env python3
"""PreToolUse gate: a commit does not leave the record unciteable.

THE FAILURE THIS ADDRESSES.  A result is created at the research loop's steps 3
and 4 -- recorded into findings/, written into results.md -- and nothing checks
that it can be cited.  Four such defects were found months later by a separate
audit: result 73 cited four times with no heading anywhere; a lemma declaring
"proved, two lines; Gate 2 owed" in its own heading while carrying no number, so
it was invisible to the debt ledger; and two ids each carried by two headings,
which makes a citation mean either statement.

Each was seconds of work for the cycle that made it and hours for the audit that
found it.  So the check runs where the cycle closes, which is the commit.

WHAT IT DOES.  Runs .claude/skills/structure-check/check.py -- four set
comparisons over findings/, references/ and reviews/, about eighty tokens of
output -- and blocks the commit when it fails, handing back the failing rows.
The fix is the structure-check skill's phase B.

SCOPE.  Only commits that touch findings/, results.md, references/ or reviews/.
A commit to scripts/ or a skill file is not gated: it cannot break an id.

IT APPLIES TO EVERY SESSION, deliberately, unlike cycle_deliverable.py.  A
broken id damages the record whoever made it, and the check costs nothing.

BYPASS.  Nothing here overrides a user who says to commit anyway; the block is
advisory in the sense that the user can repeat the instruction.  It exists to
stop the omission passing unnoticed, not to make it impossible.
"""
import json
import os
import subprocess
import sys

WATCHED = ('findings/', 'results.md', 'references/', 'reviews/')


def _touches_staged(report, paths):
    """True when a failing row names something this commit stages.

    Crude on purpose: the report prints paths and folder slugs, so a substring
    match against the staged list is enough to tell "your problem" from
    "someone else's in-progress work", and a false positive only costs a block
    the committer can read and act on.
    """
    if not paths:
        return True  # cannot attribute; fail closed
    for p in paths:
        stem = os.path.basename(p.rstrip('/'))
        if p in report or (stem and stem in report):
            return True
    return False


def unstaged_review_rows_only(cwd, paths):
    """True when the ONLY thing failing is reviewer reports this commit does not stage.

    A reviewer may not write the shared index -- independence is the whole
    reason two run -- so the row for a report clears only when the round folds.
    Until then the gate would freeze every commit touching the record, which is
    a block nobody in the round is permitted to lift.  A report file carries no
    id, so an unindexed one cannot break a citation, and letting it through
    costs the record nothing.
    """
    checker = os.path.join(cwd, '.claude', 'skills', 'structure-check', 'check.py')
    try:
        run = subprocess.run([sys.executable, checker, '--json'], cwd=cwd,
                             capture_output=True, text=True, timeout=120)
        f = json.loads(run.stdout)
    except Exception:
        return False
    if f['A'] or f['C'].get('references_unindexed'):
        return False
    if any(f['B'][k] for k in ('duplicated', 'duplicated_posts', 'ghosts', 'orphans',
                               'posts_tabled_without_heading', 'posts_headed_without_table')):
        return False
    if any(v for k, v in f['D'].items() if k != 'no_pdf_excused'):
        return False
    if f['E']['index_contradicts_ledger']:
        return False
    pending = f['C'].get('reviews_unindexed') or []
    if not pending:
        return False
    staged = set(paths)
    return all('reviews/REVIEW_r%s.md' % n not in staged for n in pending)


def staged_paths(cwd):
    try:
        out = subprocess.run(['git', 'diff', '--cached', '--name-only'],
                             cwd=cwd, capture_output=True, text=True, timeout=10)
        return [p for p in out.stdout.split('\n') if p]
    except Exception:
        return []


def main():
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0
    command = (payload.get('tool_input') or {}).get('command', '')
    if 'git commit' not in command:
        return 0

    cwd = payload.get('cwd') or os.getcwd()
    paths = staged_paths(cwd)

    # A reviewer filing its own report is exempt.  Both loops now forbid a
    # reviewer to write into reviews/INDEX.md -- independence is the whole
    # reason two run, and the index is the one file both are certain to open,
    # so a gate demanding indexing publishes each reviewer's verdicts where
    # its counterpart will read them.  Without this exemption the two rules
    # contradict: the report cannot be indexed and so cannot be committed,
    # and two rounds of reports arrived uncommitted for the fold to rescue.
    # A report file carries no id of its own, so it cannot break a citation.
    if paths and all(
            p.startswith('reviews/REVIEW_r') and p.endswith('.md') for p in paths):
        return 0
    if paths and not any(p.startswith(WATCHED) or p in WATCHED for p in paths):
        return 0  # nothing this commit touches can break an id

    checker = os.path.join(cwd, '.claude', 'skills', 'structure-check', 'check.py')
    if not os.path.exists(checker):
        return 0
    try:
        run = subprocess.run([sys.executable, checker], cwd=cwd,
                             capture_output=True, text=True, timeout=120)
    except Exception:
        return 0  # a broken checker must not block work
    if run.returncode == 0:
        return 0

    # Block only on failures this commit could have caused.  The check is global
    # and several sessions write this tree, so a failure often names a file the
    # committer never touched -- one agent was blocked three times by folders
    # another session was mid-way through creating.  Blocking a session for work
    # it cannot fix teaches it to bypass the gate, which is worse than no gate.
    if unstaged_review_rows_only(cwd, paths):
        print("The structure check fails only on reviewer reports this commit does not"
              " stage, and a reviewer may not index itself -- the row clears when the"
              " round folds. Not blocking.\n\n" + run.stdout.strip(), file=sys.stderr)
        return 0

    mine = _touches_staged(run.stdout, paths)
    if not mine:
        print("The structure check fails, but on files this commit does not touch"
              " -- another session is probably mid-write. Not blocking.\n\n"
              + run.stdout.strip(), file=sys.stderr)
        return 0

    # WARN, NEVER BLOCK (the user's decision of 2026-09-28): commits go through, and the
    # rows this commit touched are fixed in the next one.
    print("WARNING, not blocking: the structure check fails on files this commit touches.\n\n"
          + run.stdout.strip()
          + "\n\nFix the rows this commit is responsible for in your next commit. The spec"
            " and the fix order are in .claude/skills/structure-check/SKILL.md.",
          file=sys.stderr)
    return 0


if __name__ == '__main__':
    sys.exit(main())
