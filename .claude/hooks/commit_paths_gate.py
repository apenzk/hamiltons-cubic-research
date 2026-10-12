#!/usr/bin/env python3
"""PreToolUse gate: a commit names the files it commits.

Several sessions share one working tree and one git index. A bare `git commit`
takes everything staged, including another session's half-finished work, and
commits it under a message that describes something else. So:

- `git commit` must list its paths after `--` (git then commits only those,
  leaving every other staged file staged for its owner);
- `git commit --amend` is refused: an amend rewrites whatever HEAD is at that
  moment, which may be another session's commit, so a fix is a new commit;
- `git commit -a/--all` and `git add -A/--all/-u/--update/.` are refused, since
  each sweeps in files the session never touched.
"""
import json
import re
import shlex
import sys

MSG = """Commit blocked: {why}

Sessions share one git index, so a commit takes only the files this session changed.
List them after `--`:   git commit -F - -- path/one path/two <<'EOF' ... EOF
Fix a message or file:  a new commit naming its paths, never --amend
Stage by name:         git add path/one path/two"""


def segments(command):
    """Shell-ish split into simple commands on && || ; | and newlines, heredoc bodies dropped."""
    body = re.sub(r"<<-?\s*'?(\w+)'?\n.*?\n\1\s*$", "", command, flags=re.S | re.M)
    return [s.strip() for s in re.split(r"&&|\|\||[;|\n]", body) if s.strip()]


def tokens(seg):
    try:
        return shlex.split(seg)
    except ValueError:
        return seg.split()


def check(seg):
    t = tokens(seg)
    if len(t) < 2 or t[0] != "git":
        return None
    sub, args = t[1], t[2:]
    if sub == "add":
        if any(a in ("-A", "--all", "-u", "--update", ".", "--no-ignore-removal") for a in args):
            return "`git add` with -A, --all, -u or `.` stages files other sessions touched."
        return None
    if sub != "commit":
        return None
    if "--amend" in args:
        return "`git commit --amend` rewrites whatever HEAD is, which may be another session's commit."
    if any(a in ("-a", "--all") or (re.fullmatch(r"-[a-zA-Z]*a[a-zA-Z]*", a) and not a.startswith("--")) for a in args):
        return "`git commit -a` commits every modified file, including other sessions'."
    paths = args[args.index("--") + 1:] if "--" in args else []
    if paths:
        return None
    return "this `git commit` names no paths, so it would take the whole shared index."


def main():
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0
    command = (payload.get("tool_input") or {}).get("command", "")
    if "git" not in command:
        return 0
    for seg in segments(command):
        why = check(seg)
        if why:
            print(MSG.format(why=why), file=sys.stderr)
            return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
