"""r195: a negative control for the multiplicity Gram, since 192's per-copy word
list turns out NOT to corrupt anything on this construction (the BFS is
deterministic and returns copy 1's list for every copy tested).

The known-wrong object used instead is a NON-EQUIVARIANT identification that
every piece of bookkeeping in run_n5_assemble.py accepts: permute copy 2's word
positions by a transposition of two positions of the SAME weight, fixing
position 0.  Then

  * every adapted vector is still a weight vector of the same weight, so the
    weight index BYW, the squareness check and the widths are untouched;
  * R_i[0] is untouched, so the shipped (0,0) probe returns the SAME h,
    Hermitian and not the identity -- both shipped checks pass;
  * and <R_i[t], R_j[s]> = h_ij Q_ts is destroyed.

Positive control alongside it: rescaling copy 2 by a nonzero scalar IS an
equivariant change; h must move and Schur must still hold.
"""
import sys, os, random, time
from fractions import Fraction as Fr
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import common195 as K

def shipped_h(cps):
    m = len(cps)
    q00 = K.ip3(cps[0][0], cps[0][0])
    row = [[K.cdiv(K.ip3(cps[i][0], cps[j][0]), q00) for j in range(m)] for i in range(m)]
    herm = all(row[i][j] == K.cconj(row[j][i]) for i in range(m) for j in range(m))
    ident = all(row[i][j] == (Fr(1 if i == j else 0), Fr(0))
                for i in range(m) for j in range(m))
    return row, herm, ident

def schur(cps, nprobe):
    m = len(cps); c0 = cps[0]
    h0, _, _ = shipped_h(cps)
    bad = tot = 0
    for t in range(min(nprobe, len(c0))):
        for s in range(min(nprobe, len(c0))):
            if K.mwt(max(c0[t])) != K.mwt(max(c0[s])): continue
            q = K.ip3(c0[t], c0[s])
            if q == K.ZC: continue
            for i in range(m):
                for j in range(m):
                    tot += 1
                    if K.cdiv(K.ip3(cps[i][t], cps[j][s]), q) != h0[i][j]: bad += 1
    return bad, tot, h0

t0 = time.time()
for LAM, NP in [((2, 0), 14), ((3, 0), 20)]:
    copies, words = K.build(LAM, shared=True)
    m = len(copies)
    if m < 2:
        print(f"lambda={LAM}: multiplicity {m}, no h to break"); continue
    c0 = copies[0]
    byw = {}
    for t, v in enumerate(c0): byw.setdefault(K.mwt(max(v)), []).append(t)
    pair = next((v[:2] for w, v in byw.items() if len(v) >= 2 and 0 not in v[:2]), None)
    print(f"\n===== lambda={LAM}  dim {len(c0)}  copies {m}   [{time.time()-t0:.0f}s]")
    b, tot, h0 = schur(copies, NP)
    r, hm, idt = shipped_h(copies)
    print(f"  as shipped        : Schur {b} of {tot} disagree; "
          f"h Hermitian {hm}, not identity {not idt}")
    if pair is None:
        print("  no same-weight position pair away from 0 -- control unavailable"); continue
    a, bb = pair
    bro = [c[:] for c in copies]
    bro[1][a], bro[1][bb] = bro[1][bb], bro[1][a]
    b2, tot2, h2 = schur(bro, NP)
    r2, hm2, idt2 = shipped_h(bro)
    print(f"  NEGATIVE CONTROL: copy 2's positions {a} and {bb} swapped "
          f"(same weight {K.mwt(max(c0[a]))}, position 0 untouched)")
    print(f"     shipped (0,0) probe unchanged: {r2 == r};  Hermitian {hm2}; "
          f"not identity {not idt2}   -> both shipped checks still PASS")
    print(f"     Schur over t,s < {NP}: {b2} of {tot2} DISAGREE   -> the multi-probe "
          f"check FIRES: {b2 > 0}")
    sc = (Fr(3), Fr(2))
    res = [c[:] for c in copies]
    res[1] = [{k: K.cmul(sc, v) for k, v in vec.items()} for vec in copies[1]]
    b3, tot3, h3 = schur(res, NP)
    print(f"  POSITIVE CONTROL: copy 2 rescaled by 3+2i -- h moves ({h3[0][1] != h0[0][1]}), "
          f"Schur still holds: {b3 == 0} ({b3} of {tot3})")
print(f"\ndone [{time.time()-t0:.0f}s]")
