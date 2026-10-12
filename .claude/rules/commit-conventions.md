# Commit conventions

**The commit message format for this repository is in [CONTRIBUTING.md](../../CONTRIBUTING.md). Read it before writing a commit message.**

The points most often got wrong here:

- **Bullets, not prose paragraphs.** Commits before 2026-08-31 use prose. That style is superseded, so `git log` is not the thing to imitate.
- **The `Deliverable:` and `Searched:` trailers are enforced by a hook** ([cycle_deliverable.py](../hooks/cycle_deliverable.py)) and refuse the commit when missing or malformed. `Searched:` must be a single unwrapped line.
- **A commit names its own files, and stages them in the same command.** Sessions share one git index, so a bare `git commit` takes whatever any session has staged. Write `git add a b && git commit -F - -- a b`, listing after `--` exactly the files this session changed. [commit_paths_gate.py](../hooks/commit_paths_gate.py) refuses a commit with no paths, `git commit -a`, `git commit --amend`, and `git add -A`, `-u` or `.`.
- **Never amend.** Sessions and agents share one branch, and an amend rewrites whatever HEAD is at that moment, which may be another session's commit. Fix a message or a file with a new commit naming its paths.
- **A shared file commits whole, and that is accepted.** A path named after `--` takes the file's whole working-tree state, so another session's lines in [lean/INDEX.md](../../lean/INDEX.md), [plan.md](../../plan.md) or [STATUS.md](../../STATUS.md) can ride along under your message. Commit anyway, with no diff reading and no coordination (the user's decision of 2026-09-28, trading exact attribution for commits that go through).
- **Nothing checks Lean or STATUS.md at commit time.** The pre-commit hook launches the tree build in the background (`/tmp/lean_tree_build.log`). After a commit staging `lean/`, read that log's errors before your next Lean commit and fix any in it. STATUS.md is regenerated when a status is asked for.
