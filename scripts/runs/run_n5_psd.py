"""Is there a PSD point in the 23-dimensional affine family?  Plan item 3c-ii.

FLOAT64 CANNOT RUN THIS SCREEN, AND THE MEASUREMENT SAYING SO IS BELOW.  The
result is recorded here rather than in a comment because it decides the method,
not a detail of it.

  * The adapted basis comes from lowering words, and Q's diagonal at
    lambda=(6,4) runs from 1.9e6 to 3.6e42 -- 36 decades, against float64's 16.
  * Rescaling the position basis by powers of two collapses that to 0.5 .. 2.0
    exactly, and changes the outcome by NOTHING: numerical rank 1 both times,
    residual 0.5522 both times.  So the fault was never Q's scaling.
  * The decisive check is at W_0, where the restricted G is exactly zero -- the
    mod-p pipeline reports 0/47 and two reviewers confirmed it.  In float64 the
    restricted magnitude comes out 9.1e17 against an unrestricted 3.5e17, a
    ratio of 2.6.  The restriction does not merely lose accuracy; it does
    nothing at all.
  * The cause is the per-weight solve, whose condition number is 2.9e14 after
    every rescaling tried.  W_0^3 has components in the lambda_2-EVEN blocks only
    -- reviewer 209 measured exact rank 1 there and exact rank 0 on all eight odd
    blocks -- and the solve spreads noise into the odd blocks, which the
    restriction leaves untouched by construction.  That noise is what survives.

So the numbers this file would feed an SDP are not the sextic's coordinates, and
a feasible point found from them would mean nothing.  WHAT IS NEEDED is the rows
computed exactly and only then converted to float: their true spread is about 8
decades, which float64 holds comfortably.  The route is rational reconstruction
from the mod-p pipeline, which already computes these rows correctly -- several
primes, CRT, lift.  Sampling in floating point is the part that fails, not the
plan.

Kept as the record of what was measured, and as the harness for the rows once
they arrive exactly.


This is a SCREEN, and it is labelled one.  Positive semidefiniteness is a
statement about real arithmetic, so the mod-p pipeline in run_n5_assemble.py
cannot answer it -- there is no order on F_p.  What this file does is find a
candidate numerically; what would make it a certificate is exact rational
verification afterwards, which run_n5_sdp.py's ldl_psd exists for.  A feasible
point here is EVIDENCE, and saying otherwise would be the error this programme
keeps auditing out.

The coordinates are settled: run_n5_assemble.py derives that the ansatz matrix
meets G through a CONGRUENCE by the multiplicity Gram h, which is positive
definite, so psd in the G coordinates is exactly psd of the certificate's Gram.

Structure, all of it established elsewhere and re-checked here:
  * 24 blocks, 41 copies, 7770 adapted vectors -- the cache
  * the orbit constraint kills one multiplicity in each lambda_2-even block,
    leaving 25 multiplicities across 16 blocks, shaped two 3x3, five 2x2,
    nine scalars
  * the sextic map has rank 13, F_5 is in its image, and the solution set is
    34-dimensional in Hermitian coordinates
"""
import os, sys, pickle, importlib.util, itertools, random
import numpy as np
from fractions import Fraction as Fr

d = os.path.dirname(os.path.abspath(__file__))
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(d, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    try: sp.loader.exec_module(m)
    finally: sys.stdout = o
    return m

print("loading the pipeline's own objects ...", flush=True)
ev = load("run_n5_evaluate.py")
wm = load("run_n5_weyl_module.py")
ex = load("run_n5_extremiser.py")

with open(os.path.join(d, "n5_adapted.pkl"), "rb") as f:
    ADAPTED = pickle.load(f)
print(f"  {len(ADAPTED)} blocks, {sum(len(c) for c in ADAPTED.values())} copies")
assert len(ADAPTED) == 24 and sum(len(c) for c in ADAPTED.values()) == 41

MONO = ev.MONO
IDXOF = {t: k for k, t in enumerate(MONO)}
def cf(g):
    """a Gaussian rational -> complex.

    THREE REPRESENTATIONS REACH THIS FUNCTION and mixing them silently is what
    this project keeps paying for, so all three are handled explicitly: the
    cache's G objects (.r/.i), the (re, im) pairs sym3_ip returns, and bare
    rationals or ints, which ev.coords emits for a real coordinate.
    """
    if hasattr(g, "r"): return complex(g.r) + 1j*complex(g.i)
    if isinstance(g, (tuple, list)): return complex(g[0]) + 1j*complex(g[1])
    return complex(g)

WWT = ev.WT
def mwt(idx):
    a, b, c = MONO[idx]
    return (WWT[a][0]+WWT[b][0]+WWT[c][0], WWT[a][1]+WWT[b][1]+WWT[c][1])

# ---- index the adapted vectors by Sym^3 weight, as dense complex columns ----
IDX = {}
for lam, copies in ADAPTED.items():
    for i, c in enumerate(copies):
        for t, v in enumerate(c):
            if v: IDX.setdefault(mwt(max(v)), []).append((lam, i, t, v))
MONS = {}
for k in range(len(MONO)):
    MONS.setdefault(mwt(k), []).append(k)

# ---- Q, the position Gram, from copy 0 of each block ----
H3 = ev.H
def ip3(u, v):
    tot = 0j
    for a, ca in u.items():
        ta = MONO[a] if isinstance(a, int) else a
        x = cf(ca)
        if x == 0: continue
        for b, cb in v.items():
            tb = MONO[b] if isinstance(b, int) else b
            k = ev.sym3_ip(ta, tb)
            kk = complex(k[0]) + 1j*complex(k[1]) if isinstance(k, tuple) else complex(k)
            if kk != 0: tot += x * np.conj(cf(cb)) * kk
    return tot

# CACHED.  Building Q takes about fifty minutes -- ip3 in Python against the full
# Sym^3 metric, over 24 blocks whose largest weight space is 234 -- and nothing in
# it depends on the sample points.  Without a cache every iteration of the SDP
# costs an hour, which is how a screen turns into a day.
QCACHE = os.path.join(d, "n5_psd_cache.pkl")
if os.path.exists(QCACHE):
    with open(QCACHE, "rb") as f: QB, HM = pickle.load(f)
    assert set(QB) == set(ADAPTED), "the cache does not match the adapted basis"
    print(f"loaded Q and h from cache: {len(QB)} blocks", flush=True)
else:
  print("building Q and h ...", flush=True)
  QB, HM = {}, {}
  for lam, copies in ADAPTED.items():
      c0 = copies[0]
      byw = {}
      for t, v in enumerate(c0):
          if v: byw.setdefault(mwt(max(v)), []).append(t)
      QB[lam] = (byw, {w: np.array([[ip3(c0[a], c0[b]) for b in ts] for a in ts])
                       for w, ts in byw.items()})
      m = len(copies)
      q00 = ip3(c0[0], c0[0])
      HM[lam] = np.array([[ip3(copies[i][0], copies[j][0]) / q00 if copies[i][0] and copies[j][0]
                           else (1.0 if i == j else 0.0)
                           for j in range(m)] for i in range(m)])
      print(f"  lambda={lam} m={m}", flush=True)

  _tmp = QCACHE + f".{os.getpid()}.tmp"
  with open(_tmp, "wb") as f: pickle.dump((QB, HM), f)
  os.replace(_tmp, QCACHE)
  print(f"cached Q and h to {os.path.basename(QCACHE)}", flush=True)

# RESCALE THE POSITION BASIS BY POWERS OF TWO, EXACTLY.  The adapted vectors come
# from lowering words and their norms span 36 decades -- Q's diagonal at
# lambda=(6,4) runs 1.9e6 to 3.6e42 -- while float64 carries about 16.  A first
# run reported numerical rank 1 where the exact answer is 13, with singular values
# at 1e-149; equilibrating columns lifted them to 1e-27 and left the rank at 1,
# because undoing the equilibration multiplies a tiny x by a huge Q.
#
# What fixes it is rescaling the POSITION basis itself: R'_{lambda,t} =
# R_{lambda,t} / 2^{e_t} with e_t from Q's diagonal.  Uniform across copies, so it
# is a change of basis in V_lambda and leaves h, the block structure and the
# Hermitian ansatz untouched; a power of two, so it is exact in binary and
# introduces no rounding of its own.  Q' and x' are then both O(1) and G is
# unchanged, since G = x Q x^H is basis-independent.
print("rescaling the position basis by powers of two ...", flush=True)
SCALE = {}
for lam, (byw, Qs) in QB.items():
    for w, ts in byw.items():
        Q = Qs[w]
        for k, t in enumerate(ts):
            q = abs(Q[k, k])
            SCALE[(lam, t)] = 2.0 ** (round(np.log2(q) / 2) if q > 0 else 0)
_spread = np.array(list(SCALE.values()))
print(f"  position scales span {_spread.min():.2e} to {_spread.max():.2e}",
      flush=True)
for lam, (byw, Qs) in QB.items():
    for w, ts in byw.items():
        d = np.array([SCALE[(lam, t)] for t in ts])
        Qs[w] = Qs[w] / np.outer(d, d)
_dg = np.concatenate([np.abs(np.diag(Q)) for _, Qs in QB.values() for Q in Qs.values()])
_dg = _dg[_dg > 0]
print(f"  Q diagonal now spans {_dg.min():.3e} to {_dg.max():.3e}", flush=True)

print("factoring every weight block once, in complex float ...", flush=True)
INV = {}
_worst = 0.0
for w, ent in IDX.items():
    rows = MONS[w]
    assert len(rows) == len(ent), f"weight {w} is not square"
    ri = {m: k for k, m in enumerate(rows)}
    A = np.zeros((len(rows), len(ent)), dtype=complex)
    for j, (lam, i, t, v) in enumerate(ent):
        sc = SCALE.get((lam, t), 1.0)
        for k, cv in v.items(): A[ri[k], j] = cf(cv) / sc
    INV[w] = (ri, np.linalg.inv(A))
    _worst = max(_worst, np.linalg.cond(A))
print(f"  worst condition number after rescaling: {_worst:.3e}", flush=True)
print(f"  {len(INV)} weight blocks, largest {max(len(v) for v in IDX.values())}",
      flush=True)

# ---- W_0, the restriction, and the sextic coordinates ----
S = ex.S; NP = len(S)
W0T = wm.sym2_to_R({(a, b): S[a][b] for a in range(NP) for b in range(a, NP)
                    if S[a][b]})

def coords_c(Wt):
    return np.array([cf(c) for c in ev.coords(Wt)])

def cube_c(wv):
    out = {}
    for t in MONO:
        z = complex(ev.multinom(t))
        for a in t: z *= wv[a]
        if z != 0: out[IDXOF[t]] = z
    return out

def decompose(Wt):
    """W^3 in the adapted basis: X[lam][i][t] as complex."""
    cub = cube_c(coords_c(Wt))
    byw = {}
    for k, cv in cub.items(): byw.setdefault(mwt(k), {})[k] = cv
    X = {lam: [dict() for _ in ADAPTED[lam]] for lam in ADAPTED}
    for w, tgt in byw.items():
        if w not in INV: continue
        ri, Ainv = INV[w]
        b = np.zeros(len(ri), dtype=complex)
        for k, cv in tgt.items():
            if k in ri: b[ri[k]] = cv
        x = Ainv @ b                 # already in the rescaled basis
        for (lam, i, t, _), val in zip(IDX[w], x):
            if abs(val) > 1e-12: X[lam][i][t] = val
    return X

def gram(X):
    """G_ij per block."""
    out = {}
    for lam in ADAPTED:
        byw, Qb = QB[lam]; m = len(ADAPTED[lam])
        G = np.zeros((m, m), dtype=complex)
        for w, ts in byw.items():
            Qw = Qb[w]
            xs = np.array([[X[lam][i].get(t, 0j) for t in ts] for i in range(m)])
            G += xs @ Qw @ xs.conj().T
        out[lam] = G
    return out

print("\nbuilding the restriction from W_0 ...", flush=True)
X0 = decompose(W0T)
TR, NSURV = {}, 0
for lam in sorted(ADAPTED):
    m = len(ADAPTED[lam])
    if lam[1] % 2:
        TR[lam] = np.eye(m, dtype=complex); NSURV += m; continue
    a = None
    for t in sorted({t for i in range(m) for t in X0[lam][i]}):
        cand = np.array([X0[lam][i].get(t, 0j) for i in range(m)])
        if np.max(np.abs(cand)) > 1e-9: a = cand; break
    assert a is not None, f"W_0^3 has no component in the even block {lam}"
    if m == 1: TR[lam] = np.zeros((0, 1), dtype=complex); continue
    k = int(np.argmax(np.abs(a)))
    rows = []
    for i in range(m):
        if i == k: continue
        v = np.zeros(m, dtype=complex); v[i] = 1.0; v[k] = -a[i]/a[k]
        assert abs(v @ a) < 1e-9 * np.max(np.abs(a)), "T does not annihilate a"
        rows.append(v)
    TR[lam] = np.array(rows); NSURV += len(rows)
print(f"  surviving multiplicities: {NSURV}", flush=True)
assert NSURV == 25, f"{NSURV} surviving multiplicities, not 25"
SHAPE = sorted(TR[l].shape[0] for l in TR if TR[l].shape[0])
assert SHAPE.count(3) == 2 and SHAPE.count(2) == 5 and SHAPE.count(1) == 9, SHAPE
BLOCKS = [l for l in sorted(TR) if TR[l].shape[0]]
print(f"  {len(BLOCKS)} live blocks, shape {SHAPE}", flush=True)

# PER-BLOCK NORMALISATION.  G's magnitude varies enormously BETWEEN blocks,
# because Q's does.  Dividing block lambda's G by a positive constant k_lambda
# rescales the unknown as B_lambda -> k_lambda B_lambda, a positive diagonal
# congruence block by block, so psd is untouched in both directions.  It is
# fixed once from a reference point and never re-fitted.
KAPPA = {}
def restricted(X):
    G = gram(X)
    out = {}
    for l in BLOCKS:
        M = TR[l] @ G[l] @ TR[l].conj().T
        out[l] = M / KAPPA[l] if l in KAPPA else M
    return out

def F5_of(Wt):
    W = np.array([[[[float(Wt[a][b][c][e]) for e in range(5)] for c in range(5)]
                   for b in range(5)] for a in range(5)])
    q = float(np.einsum('abcd,abcd->', W, W))
    M = W.reshape(25, 25)
    return 1.5*q**3 - 9.0*float(np.trace(M @ M @ M))**2

assert abs(F5_of(W0T)) < 1e-6 * max(1.0, abs(F5_of(W0T)) + 1), "F_5(W_0) != 0"
print(f"  F_5(W_0) = {F5_of(W0T):.3e}  (must be 0)", flush=True)

# ---- the affine system, then the SDP ----
def herm_coords(R):
    """the real coordinates of a Hermitian block-diagonal matrix set."""
    out = []
    for l in BLOCKS:
        M = R[l]; k = M.shape[0]
        for i in range(k):
            out.append(M[i, i].real)
            for j in range(i+1, k):
                out.append(M[i, j].real); out.append(M[i, j].imag)
    return np.array(out)

NUNK = sum(k*k for k in SHAPE)
print(f"\n  Hermitian unknowns: {NUNK}", flush=True)
assert NUNK == 47

rng = np.random.default_rng(20260829)
def rand_weyl():
    v = [Fr(int(rng.integers(-4, 5))) for _ in range(35)]
    full = [sum(v[j]*wm.BASIS[j][c] for j in range(35) if v[j])
            for c in range(len(wm.SPAIRS))]
    return wm.sym2_to_R({wm.SPAIRS[c]: full[c]
                         for c in range(len(full)) if full[c]})

# DIAGNOSTICS BEFORE ANY FITTING.  Two rescalings changed the residual by
# nothing (0.5522 both times) and left the numerical rank at 1, so the fault is
# not conditioning.  These three checks say whether the computed G is the right
# object at all, and each has a known answer.
print("\n  --- is the numeric G the right object? ---", flush=True)

X0d = decompose(W0T)
G0 = gram(X0d)
_r0 = {l: TR[l] @ G0[l] @ TR[l].conj().T for l in BLOCKS}
_m0 = max(np.abs(_r0[l]).max() for l in BLOCKS)
_mf = max(np.abs(G0[l]).max() for l in BLOCKS)
print(f"  (1) at W_0: restricted |G| max {_m0:.3e} against unrestricted "
      f"{_mf:.3e}, ratio {_m0/_mf:.3e}", flush=True)
print("      the mod-p pipeline gets exactly 0 here, so this ratio is the",
      flush=True)
print("      numeric error floor of the whole construction.", flush=True)

_wt = rand_weyl()
_g1 = gram(decompose(_wt))
_wt2 = wm.sym2_to_R({k: 2*v for k, v in
                     {(a, b): S[a][b] for a in range(NP) for b in range(a, NP)
                      if S[a][b]}.items()}) if False else None
_v = np.concatenate([np.abs(_g1[l]).ravel() for l in _g1])
_v = _v[_v > 0]
print(f"  (2) one sample: |G| spans {_v.min():.3e} to {_v.max():.3e}, "
      f"{np.log10(_v.max()/_v.min()):.0f} decades", flush=True)

_rk1 = np.linalg.matrix_rank(np.array([[complex(x) for x in row]
                                       for row in _g1[(2, 2)]]), tol=1e-10)
print(f"  (3) block (2,2) G has numerical rank {_rk1} of 4", flush=True)

# fix KAPPA from a handful of reference points, then hold it
_ref = [restricted(decompose(rand_weyl())) for _ in range(4)]
for l in BLOCKS:
    mx = max(np.abs(R[l]).max() for R in _ref)
    KAPPA[l] = mx if mx > 0 else 1.0
print(f"  block scales span {min(KAPPA.values()):.2e} to "
      f"{max(KAPPA.values()):.2e}", flush=True)

NPTS = 120
print(f"  sampling {NPTS} points ...", flush=True)
A, b = [], []
for s in range(NPTS):
    Wt = rand_weyl()
    # SCALE EACH EQUATION BY |W|^6.  Both sides are homogeneous of degree 6, so
    # dividing an equation through changes nothing about its solution set, and it
    # stops the sample-to-sample magnitude spread from dominating the SVD.
    Wn = np.array([[[[float(Wt[a][bb][c][e]) for e in range(5)] for c in range(5)]
                    for bb in range(5)] for a in range(5)])
    nrm = float(np.einsum('abcd,abcd->', Wn, Wn))**3
    assert nrm > 0, "a sample point is zero"
    A.append(herm_coords(restricted(decompose(Wt))) / nrm)
    b.append(F5_of(Wt) / nrm)
    if (s+1) % 40 == 0: print(f"    {s+1}/{NPTS}", flush=True)
A = np.array(A); b = np.array(b)
sv = np.linalg.svd(A, compute_uv=False)
print(f"  singular values 12..15: {sv[11:15]}", flush=True)
rk = int(np.sum(sv > sv[0]*1e-9))
print(f"  numerical rank of A: {rk}   (exact value is 13)", flush=True)

sol, *_ = np.linalg.lstsq(A, b, rcond=None)
res = np.linalg.norm(A @ sol - b) / max(np.linalg.norm(b), 1.0)
print(f"  least-squares residual: {res:.3e}   (small => F_5 is in the image)",
      flush=True)

import cvxpy as cp
print("\n  solving the SDP: maximise the least eigenvalue over the family",
      flush=True)
VARS, cons, coord = [], [], []
for l, k in zip(BLOCKS, [TR[l].shape[0] for l in BLOCKS]):
    Xv = cp.Variable((k, k), hermitian=True)
    VARS.append(Xv); cons.append(Xv >> 0)
    for i in range(k):
        coord.append(cp.real(Xv[i, i]))
        for j in range(i+1, k):
            coord.append(cp.real(Xv[i, j])); coord.append(cp.imag(Xv[i, j]))
vec = cp.hstack(coord)
cons.append(A @ vec == b)
prob = cp.Problem(cp.Maximize(cp.sum([cp.lambda_min(V) for V in VARS])), cons)
prob.solve(solver=cp.SCS, verbose=False, eps=1e-9, max_iters=200000)
print(f"  status: {prob.status}", flush=True)
if prob.value is not None:
    print(f"  sum of least eigenvalues: {prob.value:.6e}", flush=True)
if prob.status in ("optimal", "optimal_inaccurate"):
    worst = 1e18
    for l, V in zip(BLOCKS, VARS):
        w = np.linalg.eigvalsh(V.value)
        worst = min(worst, w.min())
        print(f"    {l}: eigenvalues {np.round(w, 8)}", flush=True)
    print(f"\n  WORST EIGENVALUE ACROSS ALL BLOCKS: {worst:.6e}", flush=True)
    if worst > 1e-7:
        print("  STRICTLY POSITIVE -- a psd point exists in the family, so an")
        print("  SOS certificate for F_5 exists.  NUMERICAL: what makes it a")
        print("  proof is rational rounding plus exact ldl_psd verification.")
    elif worst > -1e-7:
        print("  ON THE BOUNDARY.  A certificate may exist but is not strict, so")
        print("  rounding to rationals will be delicate.")
    else:
        print("  NEGATIVE -- no psd point in the family at this tolerance, which")
        print("  would mean F_5 has NO SOS certificate of this shape at n=5.")
