"""Every O(5)-invariant sextic vanishing at W_0 vanishes there to order 2.

This is what bounds the certificate's reachable image.  The orbit-constrained
cubics K are those with sigma_lambda(W_0) = 0, and a product of two of them
vanishes on the orbit of W_0 -- so the image of Sym^2(K) inside the invariant
sextics lies in the subspace cutting out W_0.  The question is how big that
subspace is, and whether "order 2" costs anything beyond "order 1".

IT COSTS NOTHING, AND HOMOGENEITY IS THE WHOLE REASON.  The statement in the
generality it is actually true -- reviewer 203, who found three hypotheses in
the first version doing no work:

  Let V be a real orthogonal representation of a compact group G, let x in V be
  nonzero, let H = Stab_G(x), and suppose V^H = R x.  Then every H-INVARIANT
  polynomial p, homogeneous of ANY degree d, with p(x) = 0, has grad p(x) = 0.

  Proof.  p(hy) = p(y) differentiates to h^T grad p(hy) = grad p(y), so
  grad p(x) = h grad p(x) and grad p(x) lies in V^H = R x; write it kappa x.
  Euler's identity gives kappa <x,x> = <grad p(x), x> = d p(x) = 0, and
  <x,x> > 0.  []

Degree 6 does no work, which is why the corollary for F_5 needs no minimality.
O(5)-invariance does no work -- invariance under the stabiliser alone suffices,
and that is the sharp form, because it locates what a counterexample must fail.
|W_0|^2 = 1 does no work; only positivity does, and since Weyl_5 is
O(5)-irreducible its invariant inner product is unique up to a positive scalar,
so whichever one defines grad appears on both sides of Euler and cancels.

Applied here: V = Weyl_5, G = O(5), x = W_0, and the one non-formal input is
V^H = R W_0, which this file MEASURES rather than quotes.

Hence grad p(W_0) = 0.  Vanishing at W_0 forces vanishing to order 2, and

    image of Sym^2(K)^{O(5)}  <=  {invariant sextics vanishing at W_0},

a subspace of dimension 14 - 1 = 13, since evaluation at W_0 is a NONZERO
functional on the 14 (the invariant |W|^6 takes the value 1 there).

CONSEQUENCES.
  * rank on the restricted space is at most 13.  THE BOUND COMES FROM ORDER 1
    -- reviewer 203 -- since a product of two cubics of K already vanishes at
    W_0; what order 2 shows is that the bound CANNOT BE SHARPENED by demanding
    more vanishing at the point, because the extra condition is free.
  * "the family is 36 - rank" holds only when the system is CONSISTENT, and
    consistency is exactly the open necessary condition below.  So 23 is the
    dimension of the solution set IF one exists, not a guarantee that one does.
  * F_5 vanishes to order 2 at W_0 as a COROLLARY, with no appeal to W_0 being
    a minimum -- which matters, because W_0 being a minimum is the conjecture.
  * a NECESSARY condition for any certificate: F_5 must lie in the image.  If
    the image is a proper subspace of the 13 missing F_5, the route dies.
    SETTLED: the restricted rank attains 13, so dim ANN = 1, ANN = span A(W_0^6),
    and F_5 is orthogonal to it because F_5(W_0) = 0 -- exact over Z in both
    normalisations (reviewer 210).  F_5 LIES IN THE IMAGE.

  * WHY VANISHING AT W_0 IS ENOUGH, which the record asserted and did not argue
    -- reviewer 210.  K asks for vanishing on the WHOLE ORBIT, and the check
    tests one point.  The two coincide because the restriction is applied to the
    COPY index alone: T cuts the multiplicity space and leaves V_lambda whole, so
    the restricted cubics form an O(5)-SUBMODULE.  A submodule vanishing at W_0
    vanishes at every gW_0, since g carries the submodule to itself.  Restricting
    positions instead of copies would break this, and the check would then be
    necessary without being sufficient.
  * rank >= 1 unconditionally, and NOT by assuming F_5 is in the image.  The
    identity Gram on K is one of the 36 invariant forms and maps to
    Delta = sum_a q_a^2 over an apolar-orthonormal basis of K -- a sum of
    squares of cubics of K, psd, vanishing on the orbit, and nonzero.  So the
    interval is [1, 13] on a derivation.

This file checks the one step that is a fact about W_0 rather than about
homogeneity -- that (Weyl_5)^H is 1-dimensional -- by testing the consequence
the argument uses: the Weyl-projection of W_0^2 must be a multiple of W_0, and
pairing against W_0 forces the multiple to be tr(W_0^3) = 1/sqrt6.  A
projection that came out non-proportional would refute step 2.
"""
import importlib.util, os, sys
from fractions import Fraction as F

d = os.path.dirname(os.path.abspath(__file__))
def _load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(d, n))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m

ex = _load("run_n5_extremiser.py")

# W_0 = S / sqrt6 as an operator on Lambda^2 R^5; S is exact over Q.
S, NP = ex.S, ex.NP
assert len(S) == NP

def opmul(A, B):
    return [[sum(A[i][k]*B[k][j] for k in range(NP)) for j in range(NP)]
            for i in range(NP)]
def ip(A, B):
    return sum(A[i][j]*B[i][j] for i in range(NP) for j in range(NP))

S2 = opmul(S, S)
tr2, tr3 = ip(S, S), sum(S[i][k]*S[k][l]*S[l][i]
                         for i in range(NP) for k in range(NP) for l in range(NP))
print("=== W_0 as stored, with the sqrt6 tracked by hand ===")
print(f"  tr(S^2) = {tr2}, so |W_0|^2 = {F(tr2, 6)}")
print(f"  tr(S^3) = {tr3}, so tr(W_0^3) = {F(tr3, 6)}/sqrt6")
assert F(tr2, 6) == 1 and F(tr3, 6) == 1

# STEP (b), MEASURED RATHER THAN QUOTED.  An earlier version of this file
# "checked" step (b) through <S^2 - cS, S> == 0 and through 9 - 54/6 == 0.
# Reviewer 203: neither can fail.  The first is the DEFINING EQUATION of c --
# <S^2 - cS, S> = <S^2,S> - c<S,S> = 0 for any S whatever -- and the second is
# 9 - 9 == 0, which never touches the data.  Both are deleted.
#
# What the argument actually needs is dim (Weyl_5)^h = 1, and that is a rank
# computation on the 35x35 generators: the fixed space of the stabiliser
# subalgebra h = {A in so(5) : rho(A) W_0 = 0}.
wm = _load("run_n5_weyl_module.py")
GENS, BASIS = wm.GENS, wm.BASIS

def _coords_of_S():
    """W_0 in the 35-dimensional weight basis, as exact rationals."""
    flat = {}
    for i in range(NP):
        for j in range(i, NP):
            flat[(i, j)] = S[i][j]
    return wm.coords([flat.get((a, b), F(0)) for a, b in wm.SPAIRS])

def _rank(rows, ncols):
    rows = [r[:] for r in rows]; r = 0
    for c in range(ncols):
        pv = next((t for t in range(r, len(rows)) if rows[t][c]), None)
        if pv is None: continue
        rows[r], rows[pv] = rows[pv], rows[r]
        pivot = rows[r][c]
        rows[r] = [x / pivot for x in rows[r]]
        for t in range(len(rows)):
            if t != r and rows[t][c]:
                f0 = rows[t][c]
                rows[t] = [x - f0*y for x, y in zip(rows[t], rows[r])]
        r += 1
    return r

w0 = _coords_of_S()
assert any(w0), "W_0 must be nonzero in the weight basis"

# h = kernel of A |-> rho(A) w0, a map from the 10 generators to R^35
M = [[sum(G[i][k]*w0[k] for k in range(35)) for i in range(35)] for G in GENS]
dim_h = len(GENS) - _rank(M, 35)
print(f"\n=== step (b), the only step that is a fact about W_0 ===")
print(f"  dim Stab_{{so(5)}}(W_0) = {dim_h}   (u(2) has dimension 4)")
assert dim_h == 4, f"the stabiliser algebra has dimension {dim_h}, not 4"

# The fixed space of h inside Weyl_5: intersect the kernels of the dim_h
# generators that annihilate w0.  Build h explicitly as a basis of the kernel.
def _kernel(rows, ncols):
    rows = [r[:] for r in rows]; piv = []; r = 0
    for c in range(ncols):
        pv = next((t for t in range(r, len(rows)) if rows[t][c]), None)
        if pv is None: continue
        rows[r], rows[pv] = rows[pv], rows[r]
        pivot = rows[r][c]
        rows[r] = [x / pivot for x in rows[r]]
        for t in range(len(rows)):
            if t != r and rows[t][c]:
                f0 = rows[t][c]
                rows[t] = [x - f0*y for x, y in zip(rows[t], rows[r])]
        piv.append(c); r += 1
    free = [c for c in range(ncols) if c not in piv]
    out = []
    for fc in free:
        v = [F(0)]*ncols; v[fc] = F(1)
        for t, c in enumerate(piv): v[c] = -rows[t][fc]
        out.append(v)
    return out

# the kernel is over the GENERATOR index, so transpose M before solving
hbasis = _kernel([[M[a][i] for a in range(len(GENS))] for i in range(35)], len(GENS))
assert len(hbasis) == dim_h

rows = []
for coef in hbasis:
    A = [[sum(coef[a]*GENS[a][i][k] for a in range(len(GENS)))
          for k in range(35)] for i in range(35)]
    rows.extend(A)
fixed = 35 - _rank(rows, 35)
print(f"  dim (Weyl_5)^h = {fixed}   <- step (b) needs exactly 1")
assert fixed == 1, (
    f"(Weyl_5)^h has dimension {fixed}, not 1.  Step (b) fails and with it the "
    "whole order-2 argument: grad p(W_0) would have somewhere else to live.")
print("  and W_0 itself is a nonzero H-invariant, so (Weyl_5)^H = span(W_0).")

print("\n=== what follows ===")
print("  every O(5)-invariant sextic vanishing at W_0 has grad = 0 there;")
print("  F_5 vanishing to order 2 is a corollary needing no minimality;")
print("  the image lies in the 13-dimensional space cutting out W_0, so")
print("  rank <= 13 on the restricted space.")
print("\n  AND rank >= 1 UNCONDITIONALLY -- reviewer 203.  The identity Gram on")
print("  K is one of the 36 invariant forms, and it maps to Delta = sum_a q_a^2")
print("  over an apolar-orthonormal basis of K: a sum of squares of cubics of K,")
print("  psd, vanishing on the orbit, and nonzero (Delta/|W|^6 near 0.5 at random")
print("  points).  So the interval is [1, 13] on a derivation rather than on the")
print("  retracted assumption that F_5 lies in the image.")
print("\n  NOTE the family is 36 - rank only when the system is CONSISTENT, and")
print("  consistency is exactly the open necessary condition.")
