"""r212: what block layout do the 47 columns actually carry?

herm_row (run_n5_assemble.py:848) emits the coordinates block by block in the
order `sorted(ADAPTED, key=lambda l: (-len(ADAPTED[l]), l))`.  The JSON dump
records `blocks`/`shape` in the order `sorted(TR)`.  This file prints both.
"""
import os, pickle, json, glob

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(HERE, "..", "..", "runs")

ADAPTED = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
M = {l: len(c) for l, c in ADAPTED.items()}
d = json.load(open(sorted(glob.glob(os.path.join(RUNS, "n5_rows_*.json")))[0]))
live = {tuple(b): k for b, k in zip(d["blocks"], d["shape"])}

# the parity rule herm_row's TR implements: k = m for lambda_2 odd,
# k = m-1 for lambda_2 even (and the block is dropped when that leaves 0).
for l, m in M.items():
    k = m if l[1] % 2 else m - 1
    if k: assert live.get(l) == k, (l, m, k, live.get(l))
    else: assert l not in live, l
print("the parity rule reproduces the dumped shape exactly, block by block")

TRUE = [l for l in sorted(ADAPTED, key=lambda l: (-M[l], l)) if l in live]
USED = [tuple(b) for b in d["blocks"]]

def layout(order):
    out, c = [], 0
    for l in order:
        k = live[l]
        out.append((l, k, c, c + k*k))
        c += k*k
    return out, c

T, ct = layout(TRUE); U, cu = layout(USED)
print(f"\ntotal coordinates: true {ct}, used {cu}")
print(f"true  shape {[k for _, k, _, _ in T]}")
print(f"used  shape {[k for _, k, _, _ in U]}")
print(f"identical: {[k for _,k,_,_ in T] == [k for _,k,_,_ in U]}")
print(f"\ntrue  order {[l for l,_,_,_ in T]}")
print(f"used  order {[l for l,_,_,_ in U]}")

# how many of the 47 coordinates land in a block of the right SIZE at all?
print("\ncolumn-by-column: which block does each coordinate belong to?")
def colmap(L):
    mp = {}
    for l, k, a, b in L:
        idx = a
        for i in range(k):
            mp[idx] = (l, k, i, i, "diag"); idx += 1
            for j in range(i+1, k):
                mp[idx] = (l, k, i, j, "re"); idx += 1
                mp[idx] = (l, k, i, j, "im"); idx += 1
    return mp
mt, mu = colmap(T), colmap(U)
agree = sum(1 for c in range(47) if mt[c][4] == mu[c][4] and mt[c][1] == mu[c][1])
print(f"  columns where the USED layout gives the same block size AND the same"
      f" role (diag/re/im): {agree} of 47")
mis = [c for c in range(47) if mt[c][4] != mu[c][4]]
print(f"  columns where a DIAGONAL entry is read as an off-diagonal one, or"
      f" vice versa: {len(mis)}  -> {mis}")
print(f"  columns read as an IMAGINARY part that are truly a diagonal: "
      f"{[c for c in range(47) if mt[c][4]=='diag' and mu[c][4]=='im']}")
