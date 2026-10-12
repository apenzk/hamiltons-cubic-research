"""r265 claim 5 -- the search gate, AS COMMITTED in 26833c0 and AS IT NOW STANDS.

The tree moved while this review was being written: bc593d4 rewrote the gate.
Both versions are exercised here on the same cases, so the verdict on the commit
under review is separable from the verdict on the repair.
"""
import importlib.util, os, subprocess, sys, tempfile, textwrap
sys.path.insert(0, "/tmp/r265hook")

def load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    m = importlib.util.module_from_spec(spec); sys.modules[name] = m
    spec.loader.exec_module(m); return m

OLD = load("hook_old", "/tmp/r265hook/hook_as_committed.py")
NEW = load("hook_new", "/tmp/r265hook/hook_current.py")

tmp = tempfile.mkdtemp()
subprocess.run(["git", "init", "-q", tmp], check=True)
for f in ("plan.md", "other.md"):
    open(os.path.join(tmp, f), "w").write("x\n")
os.makedirs(os.path.join(tmp, "old"), exist_ok=True)
open(os.path.join(tmp, "old", "oldplan.md"), "w").write("z\n")

def stage(files):
    subprocess.run(["git", "reset", "-q"], cwd=tmp, check=True)
    if files:
        subprocess.run(["git", "add"] + list(files), cwd=tmp, check=True)

C = "git" + " " + "commit"
def hdr(t): print("\n" + t + "\n" + "-" * len(t))

hdr("(1) SUBJECTS: does the gate see an item being opened?  [plan.md staged]")
stage(["plan.md"])
subjects = [
    'fix(plan): independence is REOPENED -- both reviewers refute the closure',
    'fix(plan): the covariant item is OPENED again by r260',
    'fix(plan): item 1 is open again -- the closure was refuted',
    'fix(plan): restore the deliverable the rewrite deleted',
    'fix(plan): obligation (ii) is not closed',
    'fix(plan): the closure claimed in fcaf711 does not hold',
]
print(f"  {'as committed':>13} {'current':>9}   subject")
for s in subjects:
    c = f'{C} -m "{s}"'
    print(f"  {str(OLD._opens_an_item(c, tmp)):>13} {str(NEW._opens_an_item(c, tmp)):>9}   {s}")

hdr("(2) WHAT 'THE SUBJECT' IS: line 1 of the BASH COMMAND, in both versions")
here = (f'{C} -m "$(cat <<\'EOF\'\n' + subjects[0] + "\n\nbody\nDeliverable: refutation\nEOF\n)\"")
inline = f'{C} -m "{subjects[0]}\n\nbody\nDeliverable: refutation"'
for name, c in (("heredoc", here), ("-m inline", inline)):
    print(f"  {name:>10}: as committed {OLD._opens_an_item(c, tmp)!s:>5},"
          f" current {NEW._opens_an_item(c, tmp)!s:>5}"
          f"   line 1 = {c.splitlines()[0]!r}")
import re
found = re.findall(r"(?:feat|fix|docs)\([^)]*\):", here)
print("  meanwhile both versions' Deliverable scan finds " + str(found) + " in the heredoc")

hdr("(3) BYPASSES")
stage([])
c = f'{C} -m "{subjects[0]}"'
print(f"  nothing staged yet (-a stages at commit time): as committed "
      f"{OLD._opens_an_item(c, tmp)!s:>5}, current {NEW._opens_an_item(c, tmp)!s:>5}")
stage(["other.md"])
print(f"  plan.md edited in a separate commit:            as committed "
      f"{OLD._opens_an_item(c, tmp)!s:>5}, current {NEW._opens_an_item(c, tmp)!s:>5}")
stage([os.path.join("old", "oldplan.md")])
print(f"  only old/oldplan.md staged (substring test):    as committed "
      f"{OLD._opens_an_item(c, tmp)!s:>5}, current {NEW._opens_an_item(c, tmp)!s:>5}")
stage(["plan.md"])
d = f'{C} -m "docs(plan): independence is REOPENED by r260"'
subs = re.findall(r"(?:feat|fix|docs|chore|refactor|test)\([^)]*\):", d)
print(f"  typed as docs(plan): -- as committed, main() returns at the GATED check "
      f"before the search gate (gated={any(s.startswith(OLD.GATED) for s in subs)}); "
      f"current runs the search gate on any commit type")

hdr("(4) WHAT THE Searched TRAILER ACCEPTS")
tests = [
    'Searched: none',
    'Searched: none -- the item is a wording fix',
    'We never Searched: anything, and derived anyway.',
    'Searched: .',
    'Searched: yes',
    'Searched: restitution -> references/weyl-polarization-primer/',
    'echo "Searched: x" ; ' + C + ' -m "feat(x): reopen y"',
]
print(f"  {'as committed':>13} {'current':>9}   text")
for t in tests:
    body = t if t.startswith("echo") else f'{C} -m "feat(x): reopen y\n\n{t}"'
    print(f"  {str(OLD._searched(body) is not None):>13} "
          f"{str(NEW._searched(body) is not None):>9}   {t}")
