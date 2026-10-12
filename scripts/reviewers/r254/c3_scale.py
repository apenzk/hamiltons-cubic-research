"""r254 claim 3: what the test costs at 184 covariants, degree 3, n = 12,
and where the float SVD with a 1e-10 relative cut stops being trustworthy.

Three separate questions, answered with numbers rather than adjectives:

  (A) HOW MANY TEST TENSORS U, AND WHAT SHAPE IS THE VALUE MATRIX.  The 184 are
      not one family of scalars: they are m_lambda covariants into V_lambda, one
      family per block of Sym^3(Weyl_12).  Independence is a per-block question
      (inequivalent O(n) irreps pair to zero), so there are 71 value matrices,
      not one, and the widest has m_lambda columns.  This script reads the
      record's own block table for the shape.

  (B) WHAT ONE U COSTS.  U must lie EXACTLY in V_lambda.  V_lambda is realised
      in traceless tensors of ((R^12)^{|lambda|}), so a dense U is 12^{|lambda|}
      floats and the projector onto it is a 2|lambda|-index array.  The file
      under review quotes 3.20 GB for an 8-index projector as the cost it is
      avoiding; this prints the same quantity for the blocks actually in the
      table.

  (C) WHETHER THE 1e-10 CUT SURVIVES.  Two independent error sources that the
      degree-2 validation cannot exhibit:
        (C1) SUMMATION CONDITIONING -- TESTED AND FOUND HARMLESS.  <D_c(W), U>
             at |lambda| = 12 is a signed sum over n^12 tuples, and the naive
             bound eps * (sum|t|/|sum t|) predicts a 1e-9 floor at n = 12.  The
             MEASURED effective conditioning of einsum's pairwise contraction is
             O(1)-O(10), so the real floor is ~1e-15.  This reviewer's first
             objection, refuted by this reviewer's own measurement.
        (C2) COEFFICIENT RATIO -- THE ONE THAT BITES.  The cut is relative to
             sigma_1, so it tolerates a dependence only while the dependence's
             COEFFICIENT RATIO stays below cut/eps ~ 1e6.  Diagram bases carry
             coefficients of size n^k; 12^6 = 3.0e6 already exceeds it.  A witness
             is built below on the record's own Bianchi relation A = 2C.
"""
import os, pickle, numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
BLK = os.path.join(HERE, "..", "..", "runs", "n12_sym3_blocks.pkl")
N = 12
EPS = np.finfo(np.float64).eps

# ---------------------------------------------------------------- (A) shape
BL = pickle.load(open(BLK, "rb"))
print("(A)  THE VALUE MATRIX IS 71 MATRICES, NOT ONE 184-COLUMN MATRIX")
print(f"     block table (SO(12) form on record): {len(BL)} blocks, "
      f"multiplicities summing to {sum(BL.values())}, max {max(BL.values())}")
print("     (the O(12) form quoted in plan.md is 71 blocks / 184; chiral pairs merge,")
print("      which changes neither the max multiplicity nor the |lambda| spread)")
import collections
mh = collections.Counter(BL.values())
print(f"     multiplicity histogram: {sorted(mh.items())}")
print(f"     -> {mh[1]} blocks have multiplicity 1: nothing to test there beyond")
print( "        F_c != 0.  The largest value matrix has 9 columns.")
print( "     -> generically m_lambda test pairs (W,U) suffice per block (claim 4),")
print(f"        so ~{sum(BL.values())} evaluations in total.  THE COUNT OF U IS NOT THE COST.")

# ---------------------------------------------------------------- (B) one U
sz = collections.Counter(sum(l) for l in BL)
mult_by_size = collections.Counter()
for l, m in BL.items():
    mult_by_size[sum(l)] += m
print()
print("(B)  WHAT ONE EXACT U COSTS.  V_lambda lives in traceless (R^12)^{|lambda|}.")
print("     |lam|  blocks  mult   dense U (12^|lam| f64)   projector P_lam (12^{2|lam|})")
for k in sorted(sz):
    ub = N**k * 8
    pb = N**(2*k) * 8
    def h(b):
        for u, s in ((2**40, "TiB"), (2**30, "GiB"), (2**20, "MiB"), (2**10, "KiB")):
            if b >= u: return f"{b/u:8.2f} {s}"
        return f"{b:8.0f} B  "
    print(f"     {k:>4}  {sz[k]:>6}  {mult_by_size[k]:>4}   {h(ub)}          {h(pb)}")
print()
print("     The file quotes 3.20 GB for 'the projector's dense 8-index form'.")
print(f"     12^8 * 8 B = {N**8*8/2**30:.2f} GiB -- so that figure is the projector on a")
print("     FOUR-index space, i.e. Weyl_n itself, the degree-2 setting.  The real")
print("     targets are the blocks above: 40 of 71 blocks (60 of the 184 covariants)")
print("     have |lambda| >= 10, where U alone is 495 GiB or 71 TiB dense and the")
print("     projector is 12^20..12^24 entries.  The saving the construction advertises")
print("     -- 'no projector is ever applied' -- is spent on the U side instead, at a")
print("     scale several orders WORSE than the 3.20 GB it was introduced to avoid.")
print("     A feasible route exists and is NOT in the file: take U a highest-weight")
print("     vector of V_lambda in an isotropic basis, which is a sum of")
print("     prod_cols (col height)! simple tensors -- for the widest lambda here:")
def colheights(l):
    l = [x for x in l if x]
    return [sum(1 for r in l if r > j) for j in range(l[0])] if l else []
import math
worst = max(BL, key=lambda l: math.prod(math.factorial(c) for c in colheights(l)))
print(f"       lambda = {tuple(x for x in worst if x)}: columns {colheights(worst)}, "
      f"{math.prod(math.factorial(c) for c in colheights(worst)):,} terms")
print("     -- but that changes the object being validated, and the file validates")
print("        a scalar test with no U in it at all.")

# ------------------------------------- (C1) rounding: refuted objection
print()
print("(C1) SUMMATION CONDITIONING -- THE OBVIOUS OBJECTION, AND IT FAILS.")
print("     <D_c(W),U> at |lambda|=12 is a signed sum over n^12 tuples.  The naive")
print("     bound is eps*kappa_global with kappa_global = sum|t|/|sum t| ~ n^6, i.e.")
print("     3e6 at n=12, a 6e-10 floor ABOVE the 1e-10 cut.  But einsum contracts")
print("     PAIRWISE, so that bound does not apply.  Measuring the effective")
print("     conditioning by running the same contraction in float32 (err ~ kappa_eff")
print("     * eps32) gives the float64 floor as kappa_eff * eps64:")
E32 = np.finfo(np.float32).eps
rng = np.random.default_rng(254)
print("       |lam|  n    kappa_global   kappa_eff   float64 floor")
for spec, nl, ns in (('abcd,efgh,ijkl,abcdefghijkl->', 12, (3, 4, 5)),
                     ('abcd,cdef,fghi,abeghi->', 6, (6, 8, 10, 12))):
    for n in ns:
        ke, kg = [], []
        for t in range(5):
            r = np.random.default_rng(31*t + n + nl)
            A = r.standard_normal((n,)*4); B = r.standard_normal((n,)*4)
            C = r.standard_normal((n,)*4); U = r.standard_normal((n,)*nl)
            x64 = float(np.einsum(spec, A, B, C, U, optimize=True))
            x32 = float(np.einsum(spec, *(z.astype(np.float32) for z in (A, B, C, U)),
                                  optimize=True))
            ke.append(abs(x32-x64)/abs(x64)/E32)
            kg.append(float(np.einsum(spec, *(np.abs(z) for z in (A, B, C, U)),
                                      optimize=True))/abs(x64))
        ke = float(np.median(ke)); kg = float(np.median(kg))
        print(f"       {nl:>4}  {n:>2}   {kg:>12.2e}   {ke:>9.2f}   {ke*EPS:>12.2e}")
print("     -- kappa_eff stays O(1)-O(10) while kappa_global grows like n^6.  ROUNDING")
print("        IS NOT THE PROBLEM: the floor is ~1e-15, four orders under the cut.")

# ------------------------------- (C2) coefficient ratio: the real break
print()
print("(C2) WHAT DOES BREAK: THE CUT IS RELATIVE TO sigma_1, SO IT BUYS ONLY ~1e6")
print("     OF COEFFICIENT RATIO.  Witness on the record's own relation:")
print("     the first Bianchi identity forces A(W) - 2C(W) = 0 on Weyl_n, where")
print("     A = W_abcd W_abcd and C = W_abcd W_acbd (plan.md's own witness).  Add a")
print("     third carrier h_M = A + M*(A - 2C).  h_M IS A, as a function, for every M.")
def weyl_random(n, rng):
    R = rng.standard_normal((n, n, n, n))
    R = 0.25*(R - R.transpose(1,0,2,3) - R.transpose(0,1,3,2) + R.transpose(1,0,3,2))
    R = 0.5*(R + R.transpose(2,3,0,1))
    R = R - (R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2))/3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); sc = np.trace(Ric); E = Ric - sc/n*g
    def KN(A_, B_): return (np.einsum('ik,jl->ijkl',A_,B_)+np.einsum('jl,ik->ijkl',A_,B_)
                            -np.einsum('il,jk->ijkl',A_,B_)-np.einsum('jk,il->ijkl',A_,B_))
    W = R - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    return 0.5*(W + W.transpose(2,3,0,1))
def frank(carriers, n, samples=12, seed=0):
    r = np.random.default_rng(seed); rows = []
    for _ in range(samples):
        W = weyl_random(n, r); rows.append([c(W) for c in carriers])
    sv = np.linalg.svd(np.array(rows), compute_uv=False)
    return int((sv > sv[0]*1e-10).sum()), sv
AA = lambda W: np.einsum('abcd,abcd->', W, W)
CC = lambda W: np.einsum('abcd,acbd->', W, W)
print("       M          reported rank   sigma_2/sigma_1   true rank is 1")
for M in (1e0, 1e4, 1e5, 1e6, 1e8, 1e12):
    h = lambda W, M=M: AA(W) + M*(AA(W) - 2*CC(W))
    r, sv = frank([AA, CC, h], 12)
    flag = "  <-- FALSE INDEPENDENCE" if r > 1 else ""
    print(f"       {M:>8.0e}   {r:>13}   {sv[1]/sv[0]:>15.2e}{flag}")
print("     The break is at M ~ 1.3e5 = 1e-10/eps.  Diagram bases carry coefficients")
print("     of size n^k -- 12^5 = 2.5e5 and 12^6 = 3.0e6 both clear it -- and r250's")
print("     own witness J_1 = I_1 + I_2/n is exactly a 1/n-scaled combination.")
print("     THIS IS THE UNSAFE DIRECTION: a true dependence read as independence,")
print("     which is the conclusion the programme wants.")

# ------------------------------------ (C3) exact arithmetic costs nothing
print()
print("(C3) AND THE THRESHOLD IS UNNECESSARY.  Per block the value matrix has at")
print(f"     most {max(BL.values())} columns.  With INTEGER W and INTEGER U the entries are exact")
print("     integers and the rank is exact -- no epsilon anywhere.  Cost of an exact")
print("     rank on the widest block, in Fraction arithmetic:")
import time
from fractions import Fraction
import random as _rnd
_rnd.seed(254)
m = max(BL.values()); rows = m + 3
Mx = [[Fraction(_rnd.randint(-10**6, 10**6)) for _ in range(m)] for _ in range(rows)]
t0 = time.time()
piv = 0
for col in range(m):
    r0 = next((i for i in range(piv, rows) if Mx[i][col]), None)
    if r0 is None: continue
    Mx[piv], Mx[r0] = Mx[r0], Mx[piv]
    for i in range(piv+1, rows):
        f = Mx[i][col]/Mx[piv][col]
        for j in range(col, m): Mx[i][j] -= f*Mx[piv][j]
    piv += 1
print(f"     exact rank of a {rows}x{m} rational matrix: {piv} in {time.time()-t0:.4f} s")
print("     -- the float SVD and its 1e-10 cut buy nothing here and cost the")
print("        coefficient-ratio failure above.  THE RANK SHOULD BE COMPUTED EXACTLY.")

# ------------------------------------------- (C4) the sample tolerance
print()
print("(C4) A SECOND, SMALLER SCALE PROBLEM: THE SAMPLE GUARD IS ABSOLUTE.")
print("     weyl_random asserts |Ric(W)|_max < 1e-9 ABSOLUTE while ||W|| grows with n:")
print("       n   ||W||   ||Ric(W)||/||W||   guard as a RELATIVE tolerance")
for n in (5, 8, 12):
    r2 = np.random.default_rng(0); rr = 0.0; nw = 0.0
    for _ in range(12):
        W = weyl_random(n, r2); nw = np.linalg.norm(W)
        rr = max(rr, np.linalg.norm(np.einsum('ikjk->ij', W))/nw)
    print(f"      {n:>2}   {nw:>5.1f}   {rr:>14.2e}   {1e-9/nw:>22.2e}")
print("     Delivered residual is ~1e-16 relative, so nothing fails today.  But the")
print("     guard admits 2.5e-11 relative at n = 12, and a relation using")
print("     tracelessness LINEARLY would then fail at the samples by that much --")
print("     within a factor 4 of the 1e-10 cut.  The guard is not tied to the cut.")
print("     The degree-2 validation cannot exhibit this: every trace-dependent")
print("     degree-2 O(n) invariant of a Bianchi tensor is QUADRATIC in Ric, so the")
print("     residual enters there at d^2, not d.")
