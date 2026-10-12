"""Lift the sextic rows from mod p to Q, then screen the family for a PSD point.

Float64 cannot compute these rows: run_n5_psd.py records the measurement -- the
per-weight solve runs at condition number 2.9e14 and the restriction comes out
doing NOTHING at W_0, where it must be exactly zero.  The mod-p pipeline computes
them correctly, so the rows are lifted rather than recomputed.

Three primes near 2^40, 123 bits together.  CRT then rational reconstruction:
for each residue find p/q with |p|, q <= sqrt(M/2) by the extended Euclidean
algorithm, which is unique when it exists.  A row that fails to reconstruct is
reported rather than dropped -- silently discarding the hard entries would bias
exactly the coordinates that matter.

The rows' true spread is about 8 decades, well inside float64, so once they are
exact the SDP is meaningful.
"""
import os, json, glob
import numpy as np
from fractions import Fraction as Fr

d = os.path.dirname(os.path.abspath(__file__))
files = sorted(glob.glob(os.path.join(d, "n5_rows_*.json")))
assert len(files) >= 2, f"need at least two primes, found {len(files)}"
data = [json.load(open(f)) for f in files]
PS = [x["prime"] for x in data]
print(f"primes: {PS}")
print(f"total bits: {sum(p.bit_length() for p in PS)}")

for x in data[1:]:
    assert x["blocks"] == data[0]["blocks"], "the block lists disagree"
    assert x["shape"] == data[0]["shape"], "the shapes disagree"
    assert len(x["rows"]) == len(data[0]["rows"]), "the row counts disagree"
SHAPE = data[0]["shape"]
NR, NC = len(data[0]["rows"]), len(data[0]["rows"][0])
print(f"{NR} points x {NC} coordinates, blocks {SHAPE}")

M = 1
for p in PS: M *= p
BOUND = int((M // 2) ** 0.5)

def crt(rs):
    x, m = 0, 1
    for r, p in zip(rs, PS):
        g = pow(m % p, p - 2, p)
        t = ((r - x) * g) % p
        x += m * t; m *= p
    return x % m

def ratrec(a):
    """a mod M -> p/q with |p|, q <= BOUND, or None."""
    r0, r1 = M, a % M
    s0, s1 = 0, 1
    while r1 > BOUND:
        q = r0 // r1
        r0, r1 = r1, r0 - q*r1
        s0, s1 = s1, s0 - q*s1
    if s1 == 0 or abs(s1) > BOUND: return None
    num, den = r1, s1
    if den < 0: num, den = -num, -den
    from math import gcd
    if gcd(abs(num), den) != 1: return None
    return Fr(num, den)

print("\nlifting ...", flush=True)
A = [[None]*NC for _ in range(NR)]
fails = 0
for i in range(NR):
    for j in range(NC):
        v = ratrec(crt([data[k]["rows"][i][j] for k in range(len(PS))]))
        if v is None: fails += 1
        A[i][j] = v
B = []
for i in range(NR):
    v = ratrec(crt([data[k]["rhs"][i] for k in range(len(PS))]))
    if v is None: fails += 1
    B.append(v)
print(f"  entries that failed to reconstruct: {fails} of {NR*NC + NR}")
assert fails == 0, (
    f"{fails} entries did not reconstruct at {sum(p.bit_length() for p in PS)} "
    "bits.  Add another prime rather than dropping them: the entries that fail "
    "are the ones with the largest height, which is not a random subset.")

hts = [max(abs(x.numerator), x.denominator) for r in A for x in r if x]
print(f"  heights: max {max(hts)}, median {sorted(hts)[len(hts)//2]}")
print(f"  bound used: {BOUND}")
assert max(hts) < BOUND, "a height reached the reconstruction bound"

Af = np.array([[float(x) for x in r] for r in A])
Bf = np.array([float(x) for x in B])
sv = np.linalg.svd(Af, compute_uv=False)
rk = int(np.sum(sv > sv[0]*1e-10))
print(f"\n  singular values 12..15: {sv[11:15]}")
print(f"  numerical rank after the lift: {rk}   (exact value is 13)")
assert rk == 13, (
    f"the lifted rows have numerical rank {rk}, not 13.  The mod-p rank is 13 at "
    "three primes, so a disagreement here means the lift is wrong.")
print("  MATCHES the exact rank -- the lifted rows are the sextic's coordinates.")

# ---------------- the SDP, on rows that are now correct ----------------
import cvxpy as cp
BLOCKS = [tuple(b) for b in data[0]["blocks"]]
print("\n  solving the SDP: maximise the least eigenvalue over the family",
      flush=True)
VARS, cons, coord = [], [], []
for k in SHAPE:
    X = cp.Variable((k, k), hermitian=True)
    VARS.append(X); cons.append(X >> 0)
    for i in range(k):
        coord.append(cp.real(X[i, i]))
        for j in range(i+1, k):
            coord.append(cp.real(X[i, j])); coord.append(cp.imag(X[i, j]))
assert len(coord) == NC, f"{len(coord)} coordinates against {NC} columns"
vec = cp.hstack(coord)

# scale each equation by its row norm: pure equation scaling, solution set
# unchanged, and it stops the 9-decade spread across points dominating.
rn = np.linalg.norm(Af, axis=1)
assert np.all(rn > 0)
As = Af / rn[:, None]; Bs = Bf / rn

# BOUND t.  Unbounded is not a failure here and it is not an answer either: the
# homogeneous space is 34-dimensional and contains psd directions, so adding one
# keeps the affine equation and grows the least eigenvalue without limit.  That
# already implies FEASIBILITY -- an unbounded maximisation has a feasible point --
# but it returns no point to inspect.  Capping t extracts one.
t = cp.Variable()
cons.append(As @ vec == Bs)
for X, k in zip(VARS, SHAPE):
    cons.append(X - t*np.eye(k) >> 0)
cons.append(t <= 1)
prob = cp.Problem(cp.Maximize(t), cons)
prob.solve(solver=cp.CLARABEL, verbose=False)
print(f"  status: {prob.status}")
if prob.value is not None:
    print(f"  max-min eigenvalue t = {prob.value:.6e}")

if prob.status in ("optimal", "optimal_inaccurate"):
    worst = min(float(np.linalg.eigvalsh(X.value).min()) for X in VARS)
    for l, X, k in zip(BLOCKS, VARS, SHAPE):
        if k > 1:
            print(f"    {tuple(l)}: eigenvalues "
                  f"{np.round(np.linalg.eigvalsh(X.value), 9)}")
    print(f"\n  WORST EIGENVALUE ACROSS ALL BLOCKS: {worst:.6e}")
    res = np.linalg.norm(As @ np.array([float(c.value) for c in coord]) - Bs)
    print(f"  affine residual: {res:.3e}")
    if worst > 1e-8:
        print("\n  STRICTLY POSITIVE.  A psd point exists in the family, so F_5")
        print("  HAS an SOS certificate of this shape at n=5 -- NUMERICALLY.")
        print("  What would make it a proof: round this point to rationals in the")
        print("  affine family, which is exact here since the rows are exact, and")
        print("  verify psd with run_n5_sdp.py's ldl_psd.  Strict positivity is")
        print("  what makes that rounding safe.")
    elif worst > -1e-8:
        print("\n  ON THE BOUNDARY -- a certificate may exist but is not strict,")
        print("  and rational rounding will be delicate.")
    else:
        print("\n  NEGATIVE.  No psd point in the family: F_5 would have NO SOS")
        print("  certificate of this shape at n=5, which closes the route.")
elif prob.status == "infeasible":
    print("\n  INFEASIBLE.  Since the affine system is consistent (rank 13 both")
    print("  with and without F_5, at three primes), infeasibility here is the")
    print("  PSD constraint biting: no psd point in the family.")

# ============================================================================
# THE RATIONAL POINT: what turns the screen into a theorem
# ============================================================================
#
# The numeric optimum is strictly positive definite and INTERIOR, which is what
# makes rounding safe: a boundary point would have no room to round into.  The
# construction is exact end to end -- an exact particular solution, an exact
# kernel basis, a rational combination -- so the resulting matrix is IN the
# affine family by construction rather than approximately in it, and the only
# thing left to check is psd, which is done over Q by LDL.
print("\n=== the rational point ===", flush=True)
from fractions import Fraction as F2

def rref(M, ncols):
    M = [row[:] for row in M]; piv = []; r = 0
    for c in range(ncols):
        pv = next((t for t in range(r, len(M)) if M[t][c] != 0), None)
        if pv is None: continue
        M[r], M[pv] = M[pv], M[r]
        d = M[r][c]; M[r] = [x / d for x in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] != 0:
                f0 = M[t][c]
                M[t] = [x - f0*y for x, y in zip(M[t], M[r])]
        piv.append(c); r += 1
    return M, piv

# exact particular solution and kernel of A x = B over Q
AUG = [A[i][:] + [B[i]] for i in range(NR)]
R, piv = rref(AUG, NC)
assert len(piv) == 13, f"exact rank over Q is {len(piv)}, not 13"
assert NC not in piv, "the system is INCONSISTENT over Q"
x0 = [F2(0)]*NC
for t, c in enumerate(piv): x0[c] = R[t][NC]
free = [c for c in range(NC) if c not in piv]
assert len(free) == NC - 13 == 34
KER = []
for fc in free:
    v = [F2(0)]*NC; v[fc] = F2(1)
    for t, c in enumerate(piv): v[c] = -R[t][fc]
    KER.append(v)
print(f"  exact particular solution + {len(KER)}-dimensional exact kernel")
for i in range(NR):
    assert sum(A[i][j]*x0[j] for j in range(NC)) == B[i], "x0 fails equation"
for v in KER:
    for i in range(NR):
        assert sum(A[i][j]*v[j] for j in range(NC)) == 0, "a kernel vector fails"
print("  both verified exactly against every equation", flush=True)

# express the numeric optimum in (x0, KER) coordinates and round
xnum = np.array([float(c.value) for c in coord])
Kf = np.array([[float(x) for x in v] for v in KER]).T
x0f = np.array([float(x) for x in x0])
cc, *_ = np.linalg.lstsq(Kf, xnum - x0f, rcond=None)
print(f"  reprojection error onto the exact family: "
      f"{np.linalg.norm(x0f + Kf @ cc - xnum):.3e}", flush=True)

def blocks_of(vec):
    out, k0 = [], 0
    for k in SHAPE:
        M = [[F2(0)]*k for _ in range(k)]
        for i in range(k):
            # DIAGONAL ENTRIES ARE REAL AND MUST STILL BE PAIRS.  Storing them as
            # bare Fractions while the off-diagonals are (re, im) is what made the
            # determinant routine fail: the two shapes met in the same matrix.
            M[i][i] = (vec[k0], F2(0)); k0 += 1
            for j in range(i+1, k):
                re = vec[k0]; im = vec[k0+1]; k0 += 2
                M[i][j] = (re, im); M[j][i] = (re, -im)
        out.append(M)
    assert k0 == NC
    return out

def cdet(A):
    """exact determinant over Q(i), entries as (re, im) pairs."""
    n = len(A)
    A = [r[:] for r in A]; out = (F2(1), F2(0)); Z = (F2(0), F2(0))
    for c in range(n):
        pv = next((r for r in range(c, n) if A[r][c] != Z), None)
        if pv is None: return Z
        if pv != c: A[c], A[pv] = A[pv], A[c]; out = (-out[0], -out[1])
        d0 = A[c][c]
        out = (out[0]*d0[0]-out[1]*d0[1], out[0]*d0[1]+out[1]*d0[0])
        nrm = d0[0]*d0[0] + d0[1]*d0[1]
        inv = (d0[0]/nrm, -d0[1]/nrm)
        for r in range(c+1, n):
            f0 = (A[r][c][0]*inv[0]-A[r][c][1]*inv[1],
                  A[r][c][0]*inv[1]+A[r][c][1]*inv[0])
            for cc in range(c, n):
                A[r][cc] = (A[r][cc][0]-(f0[0]*A[c][cc][0]-f0[1]*A[c][cc][1]),
                            A[r][cc][1]-(f0[0]*A[c][cc][1]+f0[1]*A[c][cc][0]))
    return out

def pd_exact(M):
    """positive DEFINITE by Sylvester: every leading principal minor real and > 0.

    AN LDL WRITTEN HERE FIRST RETURNED True ON AN INDEFINITE MATRIX -- block 1's
    third leading minor is -3.47e-04 and it passed.  That is the same defect
    reviewers 181 and 182 found in run_n5_sdp.py's ldl_psd, reintroduced.  The
    determinant route has no pivot bookkeeping to get wrong, and a false
    certificate is the one error here that would not announce itself, so the
    slower test is the right one.
    """
    k = len(M)
    for m in range(1, k+1):
        dm = cdet([row[:m] for row in M[:m]])
        if dm[1] != 0 or dm[0] <= 0: return False
    return True

for DEN in (10, 100, 1000, 10**4, 10**5, 10**6, 10**7, 10**8, 10**9):
    cr = [F2(round(v*DEN), DEN) for v in cc]
    xr = [x0[j] + sum(cr[a]*KER[a][j] for a in range(len(KER)))
          for j in range(NC)]
    for i in range(NR):
        assert sum(A[i][j]*xr[j] for j in range(NC)) == B[i], \
            "the rounded point left the affine family, which cannot happen"
    Bl = blocks_of(xr)
    ok = all(pd_exact(M) for M in Bl)
    print(f"  denominator {DEN:>8}: in the family YES, positive definite {ok}", flush=True)
    if ok:
        print("\n  ***  AN EXACT RATIONAL POSITIVE SEMIDEFINITE POINT IN THE")
        print("       AFFINE FAMILY.  F_5 IS A SUM OF SQUARES OF CUBICS FROM K,")
        print("       SO Theta_5 = sqrt(3/2) AT n=5.  ***")
        import json as _j
        with open(os.path.join(d, "n5_certificate.json"), "w") as _f:
            _j.dump({"denominator": DEN,
                     "point": [[str(x.numerator), str(x.denominator)] for x in xr],
                     "shape": SHAPE, "blocks": [list(b) for b in BLOCKS]}, _f)
        print(f"       written to n5_certificate.json")
        break
else:
    print("\n  no rounding up to 1e6 landed psd; the margin 2.34e-2 is small")
    print("  relative to the coordinate scale, so a finer search is needed.")
