"""CLAIM 5 -- the `Searched:` gate in .claude/hooks/cycle_deliverable.py (26833c0).

Tests _opens_an_item and _searched AS WRITTEN, by importing the hook module.
Nothing in .claude/ is modified; `git diff --cached` is stubbed so the trigger's
second half can be driven from the test rather than from the real index.

NOTE ON THE TEST STRINGS.  The two words "git" and "commit" are concatenated at
run time throughout this file.  Writing them adjacently in the source makes the
hook fire on the very Bash call that WRITES this file: main() gates on
`"git commit" in command` and on `re.findall(r"(?:feat|fix|...)\\([^)]*\\):")`
over the whole command string, so a heredoc that merely QUOTES a commit subject
is treated as a commit.  That is a false positive of the surrounding hook,
observed here rather than argued.
"""
import importlib.util, os, re, types

GC = "git" + " " + "commit"          # see the docstring

ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", ".."))
HOOK = os.path.join(ROOT, ".claude", "hooks", "cycle_deliverable.py")
spec = importlib.util.spec_from_file_location("cyc", HOOK)
cyc = importlib.util.module_from_spec(spec); spec.loader.exec_module(cyc)

STAGED = ["plan.md\n"]                # what the stubbed git returns
class _R:
    def __init__(s, o): s.stdout = o
cyc.subprocess = types.SimpleNamespace(run=lambda *a, **k: _R(STAGED[0]))

def fires(cmd, staged="plan.md\n"):
    STAGED[0] = staged
    return cyc._opens_an_item(cmd, ROOT)

BAR = "=" * 78

print(BAR)
print("A.  DOES _opens_an_item DO WHAT ITS DOCSTRING SAYS?")
print('    docstring: "True when this commit changes plan.md AND its subject says')
print('                an item opened."')
print("    regex:      \\b(reopen|reopens|reopened|reopening)\\b\n")
cases = [
    ("fix(plan): independence is REOPENED -- both reviewers refute the closure",
     True,  "ae44228, the commit the gate was written for"),
    ("fix(plan): the n=12 sextic count is open, and the failed attempt is recorded",
     False, "*** 475c32e IS IN THE RECORD: a fix( flipping an item to OPEN, plan.md staged ***"),
    ("feat(conjecture-a): B0's rank-3 question answered, its reduction refuted",
     False, "*** 62ccb44 IS IN THE RECORD: its plan.md diff reopens B0, no trigger word ***"),
    ("fix(plan): item 1 is re-opened by the witness",
     False, "a hyphen defeats the alternation"),
    ("fix(plan): item 1 is OPENED again",
     False, "'opened' alone is not in the alternation"),
    ("fix(plan): the closure was a non sequitur; the item is back on the table",
     False, "plain English"),
    ("fix(plan): r260 REFUTES the closure of item 1",
     False, "the record's own idiom for reopening"),
    ("feat(restitution): the 10,393 kernel is the non-symmetric complement",
     False, "*** d46cda0, THE PRIMARY COMMIT, rewriting the reopened item ***"),
]
bad = 0
for subj, want, why in cases:
    cmd = f"{GC} -m '{subj}'"
    got = fires(cmd)
    if got != want:
        bad += 1
    print(f"  {'ok ' if got == want else '!! '}fires={str(got):5} expected={str(want):5}  {why}")
    print(f"      subject: {subj}")
print(f"\n  mismatches against my reading of the regex: {bad}")

print("\n" + BAR)
print("B.  THE HEREDOC BLIND SPOT -- 'subject' is line 1 of the BASH COMMAND")
hd = (GC + " -m \"$(cat <<'EOF'\n"
      "fix(plan): independence is REOPENED -- both reviewers refute the closure\n"
      "\nbody\nEOF\n)\"")
print("  a heredoc commit whose REAL subject does say REOPENED:")
print("    line 1 of the command is:  " + hd.split("\n")[0])
print(f"    _opens_an_item -> {fires(hd)}")
ff = GC + " -F /tmp/msg.txt"
print(f"  the same message passed with -F:  _opens_an_item -> {fires(ff)}, "
      f"_searched -> {cyc._searched(ff)}")
print("  -> with -F the message is not in the command at all, so neither this gate")
print("     nor the Deliverable gate can read it.")

print("\n" + BAR)
print("C.  IS THE `Searched:` REGEX SATISFIABLE BY PROSE?    Searched:[ \\t]*(\\S.*)")
probes = [
    ("Searched: none -- the literature is silent",            "documented form 2"),
    ("Searched: Weyl polarization -> references/weyl/",       "documented form 1"),
    ("nothing was Searched: the item was reopened blind",     "*** PROSE IN THE BODY, no search done ***"),
    ("Searched: yes",                                          "*** three characters, no slug, no reason ***"),
    ("Searched: .",                                            "*** one character ***"),
    ("I Searched: nothing, and I am not defending it",         "*** an admission of no search PASSES ***"),
    ("searched: lowercase",                                    "case-sensitive -> does NOT pass"),
    ("Searched:none",                                          "no space -> passes, [ \\t]* is optional"),
]
for t, why in probes:
    v = cyc._searched(t)
    print(f"  passes={str(v is not None):5}  value={str(v)[:34]:36} {why}")

print("\n" + BAR)
print("D.  CIRCUMVENTION -- three routes, none of which needs a false trailer")
PREF = r"(?:feat|fix|docs|chore|refactor|test)\([^)]*\):"
r1 = GC + " -m 'docs(plan): item 1 is reopened on r260'"
subs = re.findall(PREF, r1)
print("  1. use a docs( subject.  main() exits at the GATED check before the gate runs.")
print(f"     prefixes found: {subs}")
print(f"     any startswith {cyc.GATED}: "
      f"{any(s.startswith(cyc.GATED) for s in subs)}   -> the gate is never reached")
r2 = GC + " -m 'fix(plan): item 1 reopens'"
print(f"  2. stage plan.md in a separate commit: with plan.md unstaged, "
      f"_opens_an_item -> {fires(r2, 'findings/brauer-pairing.md')}")
r3 = "echo 'Searched: none' ; " + GC + " -m 'fix(plan): item 1 reopens'"
print(f"  3. put the trailer text anywhere in the COMMAND: opens={fires(r3)} "
      f"searched={cyc._searched(r3)!r}")
print("     -> passes, and the trailer never reaches the commit message.")

print("\n" + BAR)
print("E.  'plan.md' IS A SUBSTRING TEST OVER --name-only, NOT A PATH TEST")
probe = GC + " -m " + chr(34) + "fix(x): reopen y" + chr(34)
for st in ("outside material (unpublished, held in the private record)", "report/plan.md.bak", "notes/myplan.mdx"):
    f = fires(probe, st)
    print("  staged " + st.ljust(26) + " -> fires=" + str(f))
