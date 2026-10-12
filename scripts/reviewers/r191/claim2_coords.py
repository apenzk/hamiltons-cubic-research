"""Claim 2 -- the conjugation and the transpose in `coords`.

`coords(Wt)` builds  rhs[b] = sum_{ijkl} W * conj(f_b)  and then solves the
system whose matrix is  A[row=b][col=a] = H[a][b], i.e.  H^T w = rhs.

The derivation.  H is built with the conjugate on the SECOND slot,
H[a][b] = <f_a, f_b> = sum f_a conj(f_b).  Writing W = sum_a w_a f_a,

        <W, f_b> = sum_a w_a <f_a, f_b> = sum_a H[a][b] w_a = (H^T w)[b],

and rhs[b] is exactly <W, f_b> in that same convention.  So the conjugate is on
the basis tensor and the matrix is H^T, and the two choices are locked to each
other: conjugating the other slot forces H rather than H^T.  Both are right in
the code, and right TOGETHER.

The test that can fail: build a real W inside the span with KNOWN coefficients,
run `coords`, and reconstruct.  Then re-run with each convention swapped one at
a time; each swap must produce a tensor different from W.
"""
import sys, os, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import *

H = build_H()
Tq = [[[[[gq(T[a][i][j][k][l]) for l in range(5)] for k in range(5)]
        for j in range(5)] for i in range(5)] for a in range(35)]

def rhs_code(Wt):                      # exactly run_n5_evaluate.py's loop
    out = {}
    for b in range(35):
        re = im = F(0)
        Tb = Tq[b]
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        y = Tb[i][j][k][l]; x = Wt[i][j][k][l]
                        if x:
                            re += x*y[0]; im += -x*y[1]
        out[b] = (re, im)
    return out

def rhs_swapconj(Wt):                  # the competitor: <f_b, W> instead
    r = rhs_code(Wt); return {b: cconj(v) for b, v in r.items()}

def solve(rhs, transpose=True):
    w = {}
    for mu, idxs in BYW.items():
        n = len(idxs)
        if transpose:                  # A[row b][col a] = H[a][b]   -> H^T w = rhs
            A = [[H.get((a, b), Z) for a in idxs] for b in idxs]
        else:                          # A[row b][col a] = H[b][a]   -> H w = rhs
            A = [[H.get((b, a), Z) for a in idxs] for b in idxs]
        v = [rhs[b] for b in idxs]
        M = [A[r][:] + [v[r]] for r in range(n)]
        for c in range(n):
            p = next(r for r in range(c, n) if M[r][c] != Z)
            M[c], M[p] = M[p], M[c]
            iv = cinv(M[c][c]); M[c] = [cmul(iv, z) for z in M[c]]
            for r in range(n):
                if r != c and M[r][c] != Z:
                    f = M[r][c]
                    M[r] = [csub(z, cmul(f, y)) for z, y in zip(M[r], M[c])]
        for r, a in enumerate(idxs): w[a] = M[r][n]
    return w

def combine(coef):
    """sum_a coef[a] * f_a as a 5^4 array of exact complex numbers."""
    out = [[[[Z]*5 for _ in range(5)] for _ in range(5)] for _ in range(5)]
    for a in range(35):
        c = coef[a]
        if c == Z: continue
        Ta = Tq[a]
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        y = Ta[i][j][k][l]
                        if y != Z: out[i][j][k][l] = cadd(out[i][j][k][l], cmul(c, y))
    return out

random.seed(2191)
# a REAL tensor inside the span: r_a (f_a + conj f_a), r_a rational.
r = [F(random.randint(-5, 5), random.randint(1, 4)) for _ in range(35)]
Cx = combine([( r[a], F(0)) for a in range(35)])
Cy = combine([(-r[a], F(0)) for a in range(35)])   # placeholder, replaced below
# conj(f_a) has coefficients conj -> build directly
Wc = [[[[Z]*5 for _ in range(5)] for _ in range(5)] for _ in range(5)]
for i in range(5):
    for j in range(5):
        for k in range(5):
            for l in range(5):
                z = Cx[i][j][k][l]
                Wc[i][j][k][l] = (2*z[0], F(0))     # z + conj z
Wreal = [[[[Wc[i][j][k][l][0] for l in range(5)] for k in range(5)]
          for j in range(5)] for i in range(5)]
nz = sum(1 for i in range(5) for j in range(5) for k in range(5) for l in range(5)
         if Wreal[i][j][k][l])
print(f"real test tensor built inside the span: {nz} nonzero of 625, all rational")
imag_free = all(Cx[i][j][k][l][1] + (-Cx[i][j][k][l][1]) == 0
                for i in range(5) for j in range(5) for k in range(5) for l in range(5))

def recon_err(w):
    R = combine([w[a] for a in range(35)])
    e = F(0)
    for i in range(5):
        for j in range(5):
            for k in range(5):
                for l in range(5):
                    d = csub(R[i][j][k][l], (F(Wreal[i][j][k][l]), F(0)))
                    e += abs(d[0]) + abs(d[1])
    return e

r_code = rhs_code(Wreal)
variants = {
    "conj on f_b  +  H^T   [the code]": (r_code,          True),
    "conj on f_b  +  H":                (r_code,          False),
    "conj on W    +  H^T":              (rhs_swapconj(Wreal), True),
    "conj on W    +  H     [the other consistent pair]": (rhs_swapconj(Wreal), False),
}
print("\n=== reconstruct  W  from  sum_a w_a f_a  (exact; 0 means the solve is right) ===")
res = {}
for name, (rh, tr) in variants.items():
    w = solve(rh, tr)
    e = recon_err(w)
    res[name] = (w, e)
    print(f"  {name:52s} L1 error = {e}")

wc = res["conj on f_b  +  H^T   [the code]"][0]
wo = res["conj on W    +  H     [the other consistent pair]"][0]
print("\n=== is the difference invisible on real-weight entries? ===")
diff = [a for a in range(35) if wc[a] != wo[a]]
same = [a for a in range(35) if wc[a] == wo[a]]
print(f"  the two CONSISTENT pairings differ on {len(diff)} of 35 coordinates "
      f"(they are complex conjugates of one another, as they must be)")
wm = res["conj on f_b  +  H"][0]
bad = [a for a in range(35) if wm[a] != wc[a]]
realH = [a for a in range(35) if all(H.get((a, b), Z)[1] == 0 for b in range(35))]
print(f"  the MIXED pairing (conj on f_b, no transpose) differs on {len(bad)} of 35")
print(f"  weight indices whose whole H row is real: {len(realH)} -- the mixed pairing")
print(f"    agrees with the code on {len([a for a in realH if a not in bad])} of those "
      f"{len(realH)}, which is why a real-entry spot check misses it")
if bad:
    a = bad[0]
    print(f"  witness: coordinate a={a} (weight {WT[a]}): code gives "
          f"({wc[a][0]})+({wc[a][1]})i, mixed gives ({wm[a][0]})+({wm[a][1]})i")
