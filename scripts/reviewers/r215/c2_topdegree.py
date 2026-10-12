"""r215: compare the |lambda| = 12 part of my Racah decomposition with the GL
plethysm h_3[s_{2,2}].  In top degree the trace removal is invisible, and every
plethysm constituent has at most 6 rows, so the two lists must agree exactly --
with a chiral pair counted once, since its O(12) block is one 6-row label."""
import json, os, pickle
SC = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad"
BL = pickle.load(open(os.path.join(SC, "r215_blocks.pkl"), "rb"))
PL = {tuple(int(x) for x in k.split(",")): v for k, v in json.load(open(SC+"/plethysm12.json")).items()}

top = {}
for l, m in BL.items():
    if sum(abs(x) for x in l) != 12: continue
    key = tuple(x for x in (l[:5] + (abs(l[5]),)) if x)   # as a partition
    if l[5] < 0: continue          # count each chiral pair once
    top[key] = m
print("degree-12 O(12) blocks from the weight-system decomposition:")
for k in sorted(top): print("   ", k, top[k])
print("\nGL plethysm h_3[s_{2,2}]:")
for k in sorted(PL): print("   ", k, PL[k])
print("\nidentical:", top == PL)
if top != PL:
    for k in sorted(set(top) | set(PL)):
        if top.get(k,0) != PL.get(k,0): print("   DIFFER", k, top.get(k,0), PL.get(k,0))
print("blocks", len(top), len(PL), " multiplicity", sum(top.values()), sum(PL.values()))
