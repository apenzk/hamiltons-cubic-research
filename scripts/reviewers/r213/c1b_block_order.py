"""r213 claim 1b: is the block partition of the 47 columns the right one?

This is what reviewers 211 and 212 caught wrong: the dump walked the blocks in
one order while herm_row walked them in another, so the 47 columns were cut into
the wrong Hermitian blocks and an indefinite matrix passed as psd.

The order is recovered here from the ADAPTED-basis cache directly, with no
reference to what the dump says, and then compared against the dump.
"""
import pickle, json, glob, os
RUNS = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
raw = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
A = raw[0] if isinstance(raw, tuple) else raw
if not isinstance(A, dict):
    A = raw[1]
mult = {l: len(cs) for l, cs in A.items()}
print(f"adapted basis cache: {len(mult)} blocks, {sum(mult.values())} copies")

# herm_row's traversal order, read off run_n5_assemble.py line 851:
#     for lam in sorted(ADAPTED, key=lambda l: (-len(ADAPTED[l]), l))
order = sorted(mult, key=lambda l: (-mult[l], l))
keys = [(-mult[l], l) for l in order]
assert len(set(keys)) == len(keys), "the sort key is not a total order -- ties!"
print("the sort key (-multiplicity, weight) is a strict total order: no ties")

d = json.load(open(sorted(glob.glob(os.path.join(RUNS, "n5_rows_*.json")))[0]))
dumped = [tuple(b) for b in d["blocks"]]
shape = d["shape"]
print(f"\ndump: {len(dumped)} blocks, shape {shape}, sum k^2 = {sum(k*k for k in shape)}")
print(f"columns in the rows: {len(d['rows'][0])}")

# the dump drops blocks whose restriction is empty; check the survivors keep the order
sub = [l for l in order if l in dumped]
print(f"\ndumped block labels, in ADAPTED order : {sub[:6]} ...")
print(f"dumped block labels, as written       : {dumped[:6]} ...")
print(f"ORDER AGREES: {sub == dumped}")
assert sub == dumped, "the dumped block order is NOT herm_row's traversal order"

# the restriction drops one copy exactly when lambda_2 is even (run_n5_assemble
# line 660: SURV = m - 1 if lam[1] % 2 == 0 else m)
pred = [mult[l] - (1 if l[1] % 2 == 0 else 0) for l in dumped]
print(f"\npredicted shape from multiplicities and the parity rule:")
print(f"  {pred}")
print(f"dumped shape:")
print(f"  {shape}")
print(f"SHAPE AGREES: {pred == shape}")
print(f"\nblocks present in ADAPTED but dropped from the dump: "
      f"{[l for l in order if l not in dumped]}")
print(f"  their predicted restricted size: "
      f"{[mult[l] - (1 if l[1] % 2 == 0 else 0) for l in order if l not in dumped]}"
      f"   (dropped exactly when 0)")
