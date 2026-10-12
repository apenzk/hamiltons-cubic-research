"""r224: does run_n12_stability.py's check actually fire?

The file reads its labels from the covariant run's logs and asserts
max rows <= 6 and max(lambda'_1+lambda'_2) == 12.  Three plants, run against a
COPY of its own logic (the file under review is untouched):

  A  drop (2,2,2,2,2,2) from the label set -- the sole witness for the maximum;
  B  inject a 7-row label, which the LR bound forbids;
  C  inject a label with col1+col2 = 13, which would move the threshold to 13.
"""
import re, sys

LOGS = ["agent_logs/n12_cov_big.log", "agent_logs/n12_cov_t.log", "agent_logs/n12_tail.log"]

def read():
    lam = set()
    for f in LOGS:
        try: t = open(f).read()
        except OSError: continue
        for m in re.finditer(r'\(([\-0-9, ]+)\)\s+dim', t):
            lam.add(tuple(int(x) for x in m.group(1).split(',')))
    return lam

def cols(l):
    p = sorted((abs(x) for x in l), reverse=True)
    return sum(1 for x in p if x >= 1), sum(1 for x in p if x >= 2)

def checks(lam, name):
    try:
        assert lam, "no labels"
        rows_max = max(cols(l)[0] for l in lam)
        assert rows_max <= 6, "rows"
        worst = max(sum(cols(l)) for l in lam)
        assert worst == 12, "threshold %d" % worst
        print("  %-40s checks PASS   (max rows %d, threshold %d)" % (name, rows_max, worst))
    except AssertionError as e:
        print("  %-40s ASSERT FIRES: %s" % (name, e))

base = read()
print("baseline: %d labels from the covariant logs" % len(base))
checks(base, "unmodified")
A = {l for l in base if tuple(sorted((abs(x) for x in l), reverse=True))[:6] != (2,2,2,2,2,2)}
checks(A, "A: (2,2,2,2,2,2) removed")
checks(base | {(1,1,1,1,1,1,1)},         "B: 7-row label injected")
checks(base | {(2,2,2,2,2,2,1)},         "C: col1+col2 = 13 label injected")

# ---------------------------------------------------------------------------
# The failure mode the brief names: label set stable, multiplicities moving.
# run_n12_stability.py stores its labels in a SET, so multiplicity is discarded
# before any check runs.  Plant a table whose labels are exactly the real ones
# but whose multiplicities are wrong, and see what the file can say about it.
import json
E = {tuple(json.loads(k)): v for k, v in
     json.load(open('scripts/reviewers/r224/universal_table.json')).items()}
drifted = dict(E); drifted[(2, 2, 2, 2, 2, 2)] = 7; drifted[(4,)] = 99
print()
print("D: multiplicities moved (2^6): 1 -> 7 and (4): %d -> 99, labels untouched" % E[(4,)])
checks({l for l in drifted}, "D: multiplicity drift")
print("   the file's label set is IDENTICAL under D, so no assert in it can see this.")
print("   what does see it: sum mult*dim_O(n) no longer equals binom(dim Weyl_n + 2, 3)")
print("   (real total %d vs drifted %d)" % (sum(E.values()), sum(drifted.values())))
