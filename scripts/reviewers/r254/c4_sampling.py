"""r254 claim 4: how many random W are needed, and what a finite sample proves.

THE STATEMENT TO CHECK: "N+1 generic samples suffice for N carriers."

VERDICT IN ONE LINE: the "+1" is superstition and N is not the right count either
-- r = dim span{f_1..f_N} samples suffice ALMOST SURELY, and no number of samples
suffices with probability 1 for the direction the file's validation asserts.

THE THEOREM, and it is elementary.  Let X be a finite-dimensional real vector
space and f_1..f_N : X -> R polynomial, r = dim span{f_c}.  Draw W_1..W_m i.i.d.
from any distribution absolutely continuous w.r.t. Lebesgue measure on X, and set
M_{ic} = f_c(W_i).

  (<=)  Every linear relation sum_c x_c f_c = 0 holds AT EVERY POINT, so Mx = 0.
        Hence rank M <= r for EVERY sample set, generic or not.  No randomness.

  (>=)  Pick a basis g_1..g_r of the span.  The evaluation functionals ev_x
        span the dual of that span (if they did not, some 0 != y in the span
        would satisfy ev_x(y) = 0 for all x, i.e. y = 0 as a function), so
        points x_1..x_r exist with det[g_j(x_i)] != 0.  Therefore
        D(x_1,..,x_r) := det[g_j(x_i)] is a POLYNOMIAL on X^r that is not
        identically zero, so {D = 0} is a proper Zariski-closed set, hence
        Lebesgue-null, hence null for the sampling measure.  So with m = r
        samples, rank M = r with probability 1.

CONSEQUENCES, all of which matter here.

  1. r <= N samples suffice a.s.  N+1 is sufficient but slack; the "+1" does no
     work.  What does the work is ABSOLUTE CONTINUITY of the sampling law, not
     the count.

  2. THE TEST IS ONE-SIDED, and in EXACT arithmetic the sided-ness is total.
     rank M = N is a PROOF of independence -- rank M <= r always, so exhibiting
     rank N forces r = N, from ONE sample set, lucky or not, with no genericity
     hypothesis.  rank M < N is only EVIDENCE of dependence: it is what a
     measure-zero bad draw also looks like.

  3. SO THE FILE'S VALIDATION ASSERTS THE ONE DIRECTION SAMPLING CANNOT CERTIFY.
     It asserts rank == 1 on the degree-2 carriers (a DEPENDENCE), while the
     n = 12 item asserts rank == 184 (an INDEPENDENCE).  The validated direction
     is the uncertifiable one and the used direction is the certifiable one.

  4. AND "PROBABILITY 1" IS NOT A PROOF FOR THE ONE DRAW ACTUALLY TAKEN.  The
     file fixes seed = 0.  For the independence direction that is harmless by
     (2) -- provided the entries are EXACT.  With float entries the witnessing
     minor is not exactly nonzero and (2) evaporates; see r254 claim 3d.
"""
import numpy as np
from fractions import Fraction
import random

EPS = np.finfo(np.float64).eps

def weyl_random(n, rng):
    R = rng.standard_normal((n, n, n, n))
    R = 0.25*(R - R.transpose(1,0,2,3) - R.transpose(0,1,3,2) + R.transpose(1,0,3,2))
    R = 0.5*(R + R.transpose(2,3,0,1))
    R = R - (R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2))/3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); sc = np.trace(Ric); E = Ric - sc/n*g
    def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                         -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W = R - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    return 0.5*(W + W.transpose(2,3,0,1))

# ---- 1. the hypothesis the theorem needs: the sampler must have FULL SUPPORT
print("1.  DOES weyl_random HAVE FULL SUPPORT ON Weyl_n?  The theorem needs the")
print("    sampling law absolutely continuous ON Weyl_n, not on the ambient space.")
print("    weyl_random is a LINEAR projection of a nondegenerate Gaussian, and it")
print("    fixes Weyl_n pointwise, so it is the orthogonal projection and its image")
print("    law is a nondegenerate Gaussian on Weyl_n.  Checked by spanning:")
print("      n   dim Weyl_n = n(n+1)(n+2)(n-3)/12   rank of 200 stacked samples")
for n in (5, 6, 7):
    d = n*(n+1)*(n+2)*(n-3)//12
    rng = np.random.default_rng(0)
    S = np.array([weyl_random(n, rng).ravel() for _ in range(max(200, 2*d))])
    print(f"     {n:>2}   {d:>32}   {np.linalg.matrix_rank(S):>25}")
print("    -- full support confirmed.  This hypothesis is satisfied and unstated.")

# ---- 2. the count: r samples suffice, and the file's 12 is not tied to anything
print()
print("2.  THE COUNT.  r = dim span suffices a.s.; the file hardcodes samples = 12")
print("    with NO relation to len(carriers).  That is a live trap: a block with")
print("    more carriers than samples is silently capped.")
def independence_rank(carriers, n, samples=12, seed=0):
    rng = np.random.default_rng(seed); rows = []
    for _ in range(samples):
        W = weyl_random(n, rng); rows.append([c(W) for c in carriers])
    sv = np.linalg.svd(np.array(rows), compute_uv=False)
    return int((sv > sv[0]*1e-10).sum()), sv
A = lambda W: np.einsum('abcd,abcd->', W, W)
# k genuinely independent, WELL-SCALED carriers: W -> <W, T_j> for fixed random T_j.
# dim Weyl_6 = 84, so any k <= 84 of these are independent as functions.
_t = np.random.default_rng(77)
def lin_carriers(n, k):
    Ts = [_t.standard_normal((n,)*4) for _ in range(k)]
    return [(lambda W, T=T: float(np.einsum('abcd,abcd->', W, T))) for T in Ts]
for k in (6, 9, 11, 12, 15, 20):
    r, _ = independence_rank(lin_carriers(6, k), 6)
    flag = "  <-- CAPPED AT samples=12, true rank is %d" % k if r < k else ""
    print(f"      {k:>2} independent carriers, default samples=12: reported rank {r:>2}{flag}")
print("    The largest block has multiplicity 9, so 12 happens to be enough TODAY.")
print("    Nothing in the file says so, and nothing asserts samples > len(carriers).")
print()
print("2b. AND A SECOND, WORSE FAILURE AT k = 5, WITH ONLY 12 SAMPLES NEEDED.")
print("    Carriers A, A^2, ..., A^k are independent as functions for every k, but")
print("    their value matrix is a Vandermonde in A(W) whose columns span k decades:")
for k in (3, 4, 5, 6, 8):
    cs = [(lambda W, j=j: A(W)**j) for j in range(1, k+1)]
    r, sv = independence_rank(cs, 6)
    flag = "  <-- FALSE DEPENDENCE" if r < k else ""
    print(f"      k={k}: true rank {k}, reported {r}   sv_k/sv_1 = {sv[-1]/sv[0]:.2e}{flag}")
print("    -- the conservative direction (it under-reports), but it shows the 1e-10")
print("       cut is doing modelling, not measuring.  Column normalisation or exact")
print("       arithmetic removes it; the file does neither.")

# ---- 3. what "generic" has to mean: a finite sample set is not enough
print()
print("3.  'GENERIC' IS A HYPOTHESIS ON THE LAW, NOT ON THE COUNT.  Witness that")
print("    N+1 samples from a merely-plausible finite set fail for N = 2 carriers:")
print("      f_1(x) = 1,  f_2(x) = x(x-1)(x-2)  on the integers, sampled from {0,1,2}")
xs = [0, 1, 2]
M = [[Fraction(1), Fraction(x*(x-1)*(x-2))] for x in xs]
print(f"      value matrix at the N+1 = 3 samples: {[[str(a) for a in row] for row in M]}")
print("      reported rank 1; true rank 2 (f_2 is not the zero function).")
print("    Schwartz-Zippel gives the quantitative form: sampling coordinates from a")
print("    finite set S, P(bad draw) <= deg(D)/|S| with deg(D) = 3r (each entry is")
print("    cubic in W).  Per block r <= 9, so deg <= 27:")
for S in (10**3, 10**6, 10**9):
    print(f"      |S| = {S:>10}:  failure probability <= {27/S:.1e} per block, "
          f"<= {71*27/S:.1e} over all 71")
print("    -- and by (2) above, a draw that REPORTS rank r is a proof regardless of")
print("       this bound.  The bound only matters for reading a low rank.")

# ---- 4. the one-sidedness, exhibited
print()
print("4.  ONE-SIDEDNESS, EXHIBITED IN EXACT ARITHMETIC.  Take three carriers with")
print("    a true dependence (A - 2C = 0 by first Bianchi) and one without.")
print("    Exact integer samples make the value matrix exact, so the rank is a")
print("    theorem about the functions, not about the draw:")
random.seed(254)
def int_weyl(n, rnd, scale=6):
    """an exactly-rational element of Weyl_n: project an integer tensor."""
    R = np.array([[[[Fraction(rnd.randint(-scale, scale)) for _ in range(n)]
                    for _ in range(n)] for _ in range(n)] for _ in range(n)], dtype=object)
    def T(X, p): return np.transpose(X, p)
    R = Fraction(1,4)*(R - T(R,(1,0,2,3)) - T(R,(0,1,3,2)) + T(R,(1,0,3,2)))
    R = Fraction(1,2)*(R + T(R,(2,3,0,1)))
    R = R - Fraction(1,3)*(R + T(R,(0,2,3,1)) + T(R,(0,3,1,2)))
    g = np.array([[Fraction(int(i == j)) for j in range(n)] for i in range(n)], dtype=object)
    Ric = np.einsum('ikjk->ij', R); sc = sum(Ric[i][i] for i in range(n))
    E = Ric - sc/Fraction(n)*g
    def KN(X, Y): return (np.einsum('ik,jl->ijkl',X,Y)+np.einsum('jl,ik->ijkl',X,Y)
                          -np.einsum('il,jk->ijkl',X,Y)-np.einsum('jk,il->ijkl',X,Y))
    W = R - KN(E,g)/Fraction(n-2) - sc/Fraction(2*n*(n-1))*KN(g,g)
    W = Fraction(1,2)*(W + T(W,(2,3,0,1)))
    return W
def exact_rank(rows):
    Mx = [list(r) for r in rows]; nr, nc = len(Mx), len(Mx[0]); piv = 0
    for col in range(nc):
        r0 = next((i for i in range(piv, nr) if Mx[i][col] != 0), None)
        if r0 is None: continue
        Mx[piv], Mx[r0] = Mx[r0], Mx[piv]
        for i in range(piv+1, nr):
            f = Mx[i][col]/Mx[piv][col]
            for j in range(col, nc): Mx[i][j] -= f*Mx[piv][j]
        piv += 1
    return piv
n = 5
Ws = [int_weyl(n, random) for _ in range(5)]
res = max(abs(x) for W in Ws for x in np.einsum('ikjk->ij', W).ravel())
print(f"      exact integer samples at n={n}: max |Ric(W)| = {res}  (EXACTLY zero)")
cA = lambda W: np.einsum('abcd,abcd->', W, W)
cC = lambda W: np.einsum('abcd,acbd->', W, W)
cQ = lambda W: np.einsum('abcd,abcd->', W, W)**2
for name, cs, expect in (("(A, C)          true rank 1", [cA, cC], 1),
                         ("(A, C, A^2)     true rank 2", [cA, cC, cQ], 2)):
    rows = [[c(W) for c in cs] for W in Ws]
    print(f"      {name}:  exact rank {exact_rank(rows)}  (expected {expect})")
print("      and the Bianchi relation itself, exactly:  A - 2C =",
      set(str(cA(W) - 2*cC(W)) for W in Ws))
print("    -- with exact entries the reported rank IS the function rank, and the")
print("       independence direction needs no genericity argument at all.")
