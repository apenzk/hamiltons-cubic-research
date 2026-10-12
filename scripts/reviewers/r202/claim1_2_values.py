"""Reviewer 202: the h VALUES against reviewer 192's exact measurement, the
Hermitian assert under sabotage, the complex-off-diagonal counts, and the cache
digest under a planted corruption."""
import sys, os, copy, random, time
from fractions import Fraction as Fr
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import harness as H

P = H.PRIME
def rat(n, d): return n * pow(d % P, P-2, P) % P
def show(u): return f"({u[0]},{u[1]})"

BASE = H.ADAPTED
print(f"PRIME {P}  IMOD {H.IMOD}  IMOD^2 mod p = {pow(H.IMOD,2,P)} (p-1 = {P-1})")

# ---- claim 1: h on (2,0) against 192's [[1, 55i/37], [-55i/37, 5075/1628]] ----
HM = H.measure_h(BASE, (2, 0))
print("\nh on lambda=(2,0), pair form mod p:")
for r in HM: print("   ", [show(x) for x in r])
exp = [[(1, 0), (0, rat(55, 37))],
       [(0, (-rat(55, 37)) % P), (rat(5075, 1628), 0)]]
print("192's exact h reduced mod p:")
for r in exp: print("   ", [show(x) for x in r])
print(f"  MATCH: {HM == exp}")
# and the same at every probe, exactly over Q(i) is r199's job; here: probe 7
c = BASE[(2, 0)]
q = H.ip3_g(c[0][7], c[0][7]); den = (q[0]*q[0]+q[1]*q[1]) % P
dinv = pow(den, P-2, P); inv = (q[0]*dinv % P, (-q[1]*dinv) % P)
HM7 = [[H.gpmul(H.ip3_g(c[i][7], c[j][7]), inv) for j in range(2)] for i in range(2)]
print(f"  same h at probe 7: {HM7 == exp}")

# ---- complex off-diagonal counts, all 12 blocks with m>1 ----
print("\ncomplex off-diagonal counts (the figure the run prints):")
counts = {}
for lam in sorted(BASE, key=lambda l: len(BASE[l][0])):
    m = len(BASE[lam])
    if m == 1: continue
    R = H.measure_h(BASE, lam)
    offc = sum(1 for i in range(m) for j in range(m) if i != j and R[i][j][1])
    counts[lam] = (m, offc, H.hermitian(R), H.det_gp(R) != (0, 0))
    print(f"  lambda={lam} m={m}: Hermitian {counts[lam][2]}, complex off-diag "
          f"{offc}, det h nonzero {counts[lam][3]}", flush=True)

# ---- claim 1: does the Hermitian assert fire under sabotage of the pair mul? ----
print("\nsabotage of the pair arithmetic:")
good_mul, good_conj = H.gpmul, H.gpconj
def bad_mul(u, v):   # sign error in the imaginary cross term
    return ((u[0]*v[0] - u[1]*v[1]) % P, (u[0]*v[1] - u[1]*v[0]) % P)
def bad_conj(u): return u                      # conjugation dropped
for tag, mul, conj in [("gpmul cross-term sign", bad_mul, good_conj),
                       ("gpconj = identity", good_mul, bad_conj)]:
    H.gpmul, H.gpconj = mul, conj
    fired = []
    for lam in [(2, 0), (2, 2), (3, 2)]:
        R = H.measure_h(BASE, lam)
        fired.append((lam, H.hermitian(R)))
    print(f"  {tag}: Hermitian per block {fired}  -> assert fires: "
          f"{any(not f for _, f in fired)}")
    H.gpmul, H.gpconj = good_mul, good_conj

# ---- claim 2: the cache digest under a planted corruption ----
print("\ndigest under planted corruptions:")
d0 = H.digest(BASE)
print(f"  clean                                   {d0}")
lam0 = (2, 0)
# (i) one coefficient of copy 0 scaled
A = {k: [list(c) for c in cs] for k, cs in BASE.items()}
v = dict(BASE[lam0][0][3]); k0 = min(v); old = v[k0]
v[k0] = H.G(old.r * 2, old.i * 2); A[lam0] = [list(BASE[lam0][0])] + [list(BASE[lam0][1])]
A[lam0][0] = list(BASE[lam0][0]); A[lam0][0][3] = v
print(f"  copy 0 coefficient doubled              {H.digest(A)}  changed "
      f"{H.digest(A) != d0}")
# (ii) one coefficient of the LAST copy of a block -- what the old digest missed
lam1 = (2, 2)
B = {k: [list(c) for c in cs] for k, cs in BASE.items()}
v = dict(BASE[lam1][3][2]); k0 = min(v); old = v[k0]
v[k0] = H.G(old.r * 3, old.i * 3)
B[lam1] = [list(c) for c in BASE[lam1]]; B[lam1][3] = list(BASE[lam1][3]); B[lam1][3][2] = v
print(f"  copy 3 of (2,2) coefficient tripled     {H.digest(B)}  changed "
      f"{H.digest(B) != d0}")
# (iii) a coefficient set to zero-with-key-retained: support size unchanged
C = {k: [list(c) for c in cs] for k, cs in BASE.items()}
v = dict(BASE[lam0][0][3]); k0 = min(v)
v[k0] = H.G(Fr(0), Fr(0))
C[lam0] = [list(BASE[lam0][0])] + [list(BASE[lam0][1])]; C[lam0][0][3] = v
print(f"  coefficient zeroed, key kept            {H.digest(C)}  changed "
      f"{H.digest(C) != d0}")
