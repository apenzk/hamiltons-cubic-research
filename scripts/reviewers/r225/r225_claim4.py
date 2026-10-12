"""Claim 4: run_n12_stability.py reads a SUBSET of the block table.  What is missing,
and could a missing label carry a larger lambda'_1 + lambda'_2 than 12?"""
import re, json, subprocess, sys

LOGS = ["agent_logs/n12_cov_big.log", "agent_logs/n12_cov_t.log", "agent_logs/n12_tail.log"]
lam = set()
for f in LOGS:
    try: t = open(f).read()
    except OSError: continue
    for m in re.finditer(r'\(([\-0-9, ]+)\)\s+dim', t):
        lam.add(tuple(int(x) for x in m.group(1).split(',')))

# normalise a log label (an SO(12) highest weight) to its O(12) partition
def norm(l):
    p = tuple(sorted((abs(x) for x in l), reverse=True))
    while p and p[-1] == 0: p = p[:-1]
    return p
read = {norm(l) for l in lam}

T = {tuple(eval(k)): v for k, v in json.load(open('scripts/reviewers/r225/r225_stable_table.json')).items()}
def c12(p):
    return sum(1 for x in p if x >= 1) + sum(1 for x in p if x >= 2)

print("raw labels parsed from logs : %d" % len(lam))
print("distinct O(12) partitions   : %d" % len(read))
print("independent full table      : %d blocks, %d multiplicities" % (len(T), sum(T.values())))
missing = sorted(set(T) - read)
extra   = sorted(read - set(T))
print("\nMISSING from the file's view : %d" % len(missing))
for p in missing:
    print("   %-22s mult=%d   lambda'_1+lambda'_2=%d" % (str(p), T[p], c12(p)))
print("\nlabels the file saw that are NOT in the full table: %s" % (extra or "none"))
print("\nmax lambda'_1+lambda'_2 over the SUBSET the file reads : %d" % max(c12(p) for p in read))
print("max lambda'_1+lambda'_2 over the FULL table            : %d" % max(c12(p) for p in T))
print("max over the 11 MISSING blocks                        : %d" % max(c12(p) for p in missing))
print("multiplicity carried by the missing blocks            : %d of %d" % (sum(T[p] for p in missing), sum(T.values())))
