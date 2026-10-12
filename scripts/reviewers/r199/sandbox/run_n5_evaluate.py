"""Stage 2: B_ij(W) by evaluation, and the 14 equations.

This is the route that survives.  The pointwise one is refuted by a single
point; 182's apolarity one needs a diagram Gram nobody has built.  Here every
quantity is evaluated at a sample W, so no pairing appears anywhere.

Per sample point:
  1. w_a = coordinates of W in the weight basis.  The Hermitian Gram H is
     block-diagonal by weight -- 45 nonzero entries of 1225, zero of them
     pairing different weights -- so this is one small solve per weight.
  2. W^3 in the Sym^3 monomial basis.
  3. Expand per weight in the adapted basis; read the multiplicity coordinates
     c^{lambda,i}.  One square solve per weight, largest 234 x 234.
  4. B_ij = conj(c^i)^T Q c^j, with Q the ABSTRACT Gram of the word basis in
     V(lambda).  NO multiplicity-Gram factor.

     WHICH OBJECT c IS decides this, and reviewer 192 requires it be said
     outright, because the two readings are not interchangeable: swapping
     B_ij -> h_ij B_ij is a Hadamard reparametrisation whose inverse does not
     preserve PSD, so the SDP's feasible set MOVES.

     THE ARGUMENT FIRST GIVEN HERE ASKED THE WRONG QUESTION -- reviewer 193.
     That the c are abstract coordinates is true and does not decide it, since
     the ambient Gram is expressible in those coordinates too.  What decides it
     is what G is DUAL TO.  Writing the isotypic block as V(lambda) (x) M, any
     equivariant self-adjoint A is 1 (x) a, and <A W^3, W^3> = sum G_ij B_ij
     with B the ABSTRACT Gram and G_ij = <a e_i, e_j>_M the Gram OF A FORM.
     "G PSD" is basis-free, so no metric enters, and A >= 0 iff G >= 0 exactly.
     Copy 1's AMBIENT Gram is h_11 Q -- a uniform positive scalar per block,
     absorbed into G -- so reading M_lambda off copy 1 is harmless.

     An earlier edit here inserted h_ij on a partial reading of 192's finding.
     That was the over-correction, not the correction -- and the direction is
     now pinned: the h version is SOUND but strictly CONSERVATIVE, since Schur's
     product theorem runs one way only.  It can never certify a false F >= 0,
     only report a spurious infeasibility.  The cones genuinely differ: the
     measured h on block (2,2) is complex, non-diagonal and positive definite,
     and its entrywise reciprocal has eigenvalues (-0.889, -0.276, +0.406, +1),
     so G = J is legal abstractly and rejected by the h-inserted SDP.

     WHERE h_ij DOES BELONG: Parseval, sum_lambda sum_ij h^lambda_ij B^lambda_ij
     = 6 |W|^6 (193).  That is a real identity and a usable replacement for the
     kappa tautology below.
  5. One equation: sum_{lambda,ij} G_ij B_ij(W) = F_5(W).

And the spanning check written into run_n5_adapted.py CANNOT FAIL: phi_i is
injective, so it carries copy 1's basis to a basis automatically.  The negative
control -- a per-copy word list, the very thing that script exists to prevent --
PASSES the spanning check while breaking the G-map identification at 19 of 196
and 25 of 196 entries (192).  What actually establishes comparability is
equivariance: X_w u_i = phi_i(X_w v_lambda), so the replay IS phi_j phi_i^{-1},
measured by a Kronecker test at 0 failures of 784 and 0 of 3136.

The check that can fail: B must come out HERMITIAN, and the kappa identity
below must hold with a CONSTANT -- reviewer 191 measures kappa = 6, and reports
that dropping the multinomial gives 4 values, dropping the permutation sum 3,
and breaking the transpose 17.

The trivial-block falsifier first written here -- B_11 must reproduce
144^2 tr(W^3)^2 -- is ILL-POSED: the cached highest-weight vectors carry no
normalisation, so the ratio is 3!/||u||^2 and the target moves with a choice
nobody has made.  191 measures it at 1/120960 for the cache as it stands.
"""
import json, itertools, os
from fractions import Fraction as F

d = os.path.dirname(os.path.abspath(__file__))
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]
MONO = list(itertools.combinations_with_replacement(range(35), 3))

def gq(pr):
    (rn, rd), (inn, idd) = pr
    return (F(rn, rd), F(inn, idd))

def cmul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])
def cadd(x, y): return (x[0] + y[0], x[1] + y[1])
def cconj(x):   return (x[0], -x[1])

T = C["wbasis_tensors"]
print("building the Hermitian Gram of the weight basis ...", flush=True)
H = {}
for a in range(35):
    for b in range(35):
        if WT[a] != WT[b]: continue          # zero across distinct weights
        re = im = F(0)
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        x = gq(T[a][i][j][k][l]); y = gq(T[b][i][j][k][l])
                        re += x[0]*y[0] + x[1]*y[1]
                        im += x[1]*y[0] - x[0]*y[1]
        if (re, im) != (F(0), F(0)): H[(a, b)] = (re, im)
# The obvious line here -- "none across distinct weights" -- is VACUOUS, since
# the `continue` above discards exactly the pairs that could falsify it
# (reviewer 191).  The falsifiable version computes the discarded pairs and
# checks they really do vanish.
cross = 0
for a in range(35):
    for b in range(35):
        if WT[a] == WT[b]: continue
        re = im = F(0)
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        x = gq(T[a][i][j][k][l]); y = gq(T[b][i][j][k][l])
                        re += x[0]*y[0] + x[1]*y[1]; im += x[1]*y[0] - x[0]*y[1]
        if (re, im) != (F(0), F(0)): cross += 1
print(f"  {len(H)} nonzero within-weight entries")
print(f"  cross-weight entries actually COMPUTED and nonzero: {cross}  (must be 0)")
byw = {}
for a in range(35): byw.setdefault(WT[a], []).append(a)
print(f"  {len(byw)} weights, multiplicities {sorted({len(v) for v in byw.values()})}")
print(f"\n  stage 2 consumes the adapted basis; run_n5_adapted.py must confirm")
print(f"  all 24 blocks with a shared word list before this is meaningful.")

# ---------- Sym^3 Hermitian metric from H ----------
from math import factorial
def multinom(t):
    m = {}
    for x in t: m[x] = m.get(x, 0) + 1
    r = factorial(3)
    for v in m.values(): r //= factorial(v)
    return r

# CONVENTION IS UNDER REVIEW.  Reviewer 191's adjointness test discriminates the
# candidates and reports FISCHER and BOMBIERI passing while IDBIJ, MULT_UP and
# MULT_DN fail with witnesses.  The plain bijection sum below IS 191's FISCHER.  The
# alternatives are kept as named controls rather than deleted, because the
# discriminating test is only meaningful against the rules it rejects.
#
# Note why this is subtle and why a weight check cannot see it: with H DIAGONAL
# the bijection sum and the Fischer normalisation agree on every monomial.  They
# part company only on the 10 off-diagonal within-weight entries of H, which is
# exactly where nothing else in the pipeline looks.
# NAMING follows reviewer 191's, after a mid-review edit here collided with it:
# the labels first used inverted 191's, calling the plain bijection sum "IDBIJ"
# when 191 calls it FISCHER and finds it PASSES, and calling /aut(t)aut(s)
# "FISCHER" when 191 calls it MULT_UP and finds it FAILS.  Acting on a one-word
# verdict under the wrong names would have replaced correct code with wrong.
# The plain bijection sum -- what this file shipped originally -- is the right
# one.  The others stay as named FAILING controls.
IP_CONVENTION = "FISCHER"    # 191: passes the adjointness test

def sym3_ip(t, s, convention=None):
    """<x_t, x_s> on Sym^3 from H.  Sum over bijections t -> s.

    The normalisation is FISCHER, <x^alpha, x^alpha>_{H=I} = alpha!, which is 3!
    times the metric INDUCED from H -- reviewer 191.  The docstring here said
    "induced", which names the other convention.
    """
    convention = convention or IP_CONVENTION
    tot = (F(0), F(0))
    for perm in itertools.permutations(range(3)):
        term = (F(1), F(0))
        ok = True
        for i in range(3):
            e = H.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    if convention == "FISCHER":                 # the plain bijection sum -- PASSES
        return tot
    if convention == "MULT_UP":                 # divide by |Aut(t)| |Aut(s)| -- FAILS
        def aut(u):
            m = {}
            for x in u: m[x] = m.get(x, 0) + 1
            r = 1
            for v in m.values(): r *= factorial(v)
            return r
        f = F(1, aut(t)*aut(s))
        return (tot[0]*f, tot[1]*f)
    if convention == "BOMBIERI":                # divide by 3! -- 191 reports PASS
        f = F(1, factorial(3))
        return (tot[0]*f, tot[1]*f)
    raise ValueError(convention)

# ---------- coordinates of W in the weight basis ----------
def coords(Wt):
    """solve W = sum_a w_a f_a, one small system per weight (mult <= 3)."""
    rhs = {}
    for b in range(35):
        re = im = F(0)
        Tb = T[b]
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        y = gq(Tb[i][j][k][l]); x = Wt[i][j][k][l]
                        if x:
                            re += x*y[0]; im += -x*y[1]     # <W, f_b>, W real
        rhs[b] = (re, im)
    w = {}
    for mu, idxs in byw.items():
        n = len(idxs)
        A = [[H[(a, b)] if (a, b) in H else (F(0), F(0)) for a in idxs] for b in idxs]
        v = [rhs[b] for b in idxs]
        # Gaussian elimination over C on an n x n system, n <= 3
        M = [A[r][:] + [v[r]] for r in range(n)]
        for c in range(n):
            p = next(r for r in range(c, n) if M[r][c] != (F(0), F(0)))
            M[c], M[p] = M[p], M[c]
            dr, di = M[c][c]; den = dr*dr + di*di
            inv = (dr/den, -di/den)
            M[c] = [cmul(inv, z) for z in M[c]]
            for r in range(n):
                if r != c and M[r][c] != (F(0), F(0)):
                    f = M[r][c]
                    M[r] = [(z[0]-f[0]*y[0]+f[1]*y[1], z[1]-f[0]*y[1]-f[1]*y[0])
                            for z, y in zip(M[r], M[c])]
        for r, a in enumerate(idxs): w[a] = M[r][n]
    return w

def cube(w):
    """W^3 in the Sym^3 monomial basis, polynomial convention."""
    out = {}
    for t in MONO:
        z = (F(multinom(t)), F(0))
        for a in t: z = cmul(z, w[a])
        if z != (F(0), F(0)): out[t] = z
    return out

# GUARDED.  Everything below is a self-test, and without this guard importing
# this module for its functions re-ran the whole Hermitian Gram build AND the
# three kappa trials -- each of which re-imports the module again inside
# rand_weyl_q.  run_n5_assemble.py imports it for H, sym3_ip, coords and cube,
# and hung for ten minutes doing so.
if __name__ == "__main__":
    # EXERCISE THE CODE.  Reviewer 191: this file defined these functions and ran
    # none of them.
    #
    # THE KAPPA IDENTITY BELOW IS A TAUTOLOGY and proves nothing about the
    # conventions -- reviewers 193 and 194, independently.  kappa = 3! holds for ANY
    # Hermitian H and ANY w: summing against multinom(t) sums over ordered triples,
    # K(t,s) is a permanent, and the three factors decouple once the permutation is
    # fixed.  Measured consequences on the real H: garbage w gives 6, deleting the
    # ten within-weight off-diagonals gives 6, perturbing one by 7+3i gives 6, and
    # the compensating pair (no multinomial together with 36*MULT_UP) gives 6.  The
    # printed test only asserts CONSTANCY, which BOMBIERI also passes, at 1.
    #
    # It is kept as an execution smoke test -- it does catch a crash or a shape
    # error -- and NOT as evidence for any convention.  What established those is
    # 191's adjointness test and 192's invariance test, each of which fails on the
    # wrong variants.
    import random
    random.seed(4)
    def rand_weyl_q():
        """a rational Weyl tensor, built so Bianchi and Ric = 0 hold exactly."""
        import importlib.util
        sp = importlib.util.spec_from_file_location("wm", os.path.join(d, "run_n5_weyl_module.py"))
        wm = importlib.util.module_from_spec(sp)
        o = __import__("sys").stdout; __import__("sys").stdout = open(os.devnull, "w")
        sp.loader.exec_module(wm); __import__("sys").stdout = o
        v = [F(random.randint(-3, 3)) for _ in range(35)]
        full = [sum(v[j]*wm.BASIS[j][c] for j in range(35) if v[j])
                for c in range(len(wm.SPAIRS))]
        R = wm.sym2_to_R({wm.SPAIRS[c]: full[c] for c in range(len(full)) if full[c]})
        return R

    print("\n=== the kappa identity: metric, cube map and coordinates jointly ===")
    kappas = []; imag_ok = []
    for trial in range(3):
        Wt = rand_weyl_q()
        w = coords(Wt)
        c3 = cube(w)
        # <W^3, W^3> via the Sym^3 metric against |W|^6 from the coordinates
        tot = (F(0), F(0))
        for t, ct in c3.items():
            for s, cs in c3.items():
                ip = sym3_ip(t, s)
                if ip != (F(0), F(0)):
                    tot = cadd(tot, cmul(cmul(ct, cconj(cs)), ip))
        n2 = (F(0), F(0))
        for a in range(35):
            for b in range(35):
                if (a, b) in H: n2 = cadd(n2, cmul(cmul(w[a], cconj(w[b])), H[(a, b)]))
        if not n2[0]:
            print(f"  trial {trial}: degenerate sample, skipped", flush=True); continue
        kappas.append(tot[0] / n2[0]**3)
        imag_ok.append(tot[1] == 0 and n2[1] == 0)
        print(f"  trial {trial}: |W|^2 = {n2[0]}, <W^3,W^3>/|W|^6 = {kappas[-1]}", flush=True)
    print(f"  constant across trials: {len(set(kappas)) == 1}   <- 191 reports kappa = 6")
    print(f"  all imaginary parts vanish, EVERY trial: {all(imag_ok)}")
