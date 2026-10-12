# r258 claim 4: is multiplicity 4 "the widest available below n = 12"?
# Sym^3 of the Weyl module (2,2) of so(n), block multiplicities, n = 5..11.
# B2 reproduces the record's cached n=5 table (24 blocks / 41 copies / max 4),
# which is the control on the method.
import sys
CASES = [("B2", 5), ("D4", 8), ("B4", 9), ("D5", 10), ("B5", 11)]
for typ, n in CASES:
    rk = int(typ[1:])
    R = WeylCharacterRing(typ)
    hw = [2, 2] + [0]*(rk-2)
    w = R(*hw)
    print(f"{typ}  so({n})  dim Weyl_{n} = {w.degree()}", flush=True)
    s3 = w.symmetric_power(3)
    d = s3.monomial_coefficients()
    mults = list(d.values())
    print(f"    blocks {len(mults)}   sum of multiplicities {sum(mults)}   "
          f"MAX MULTIPLICITY {max(mults)}", flush=True)
    top = sorted(d.items(), key=lambda kv: -kv[1])[:4]
    for k, v in top:
        print(f"      {k}: {v}", flush=True)
    sys.stdout.flush()
