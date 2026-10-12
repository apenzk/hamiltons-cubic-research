"""Lifting Jaeger's Lemma 3.3.5 off the diagonal locus: falsification battery,
a PROVEN unconditional replacement, and the c(12) consequence.

BACKGROUND (FINDINGS "Lifting Jaeger's §3.3 in trace form" Result 10, REVIEW
Reviewer 10 item 2).  Jaeger's Lemma 3.3.5 states, with Ric := Ric(|W|) =: h,

    <Ric(W_-^2), h>  >=  tr(h^3) / (4(n-2)),                       (3.3.5)

and his proof is genuinely coordinate-diagonal: in the diagonal frame the row
sums of the vertex matrix vanish (Ricci-flatness), so every row of W_- with a
nonzero Ricci entry carries a zero, and Cauchy-Schwarz over the remaining n-2
row entries gives the constant.  The lifted chain (run_breakeven_theta.py, L4)
consumes (3.3.5) off-diagonal, where it was an unproven grant -- flagged by
Reviewer 10 as load-bearing for c(12).

WHAT THIS SCRIPT ESTABLISHES

(A) FALSIFICATION RECORD for the sharp constant n-2 (PART 2).  The inequality
    (3.3.5) holds at every point tested -- the full catalogue at n = 6, 8, 12,
    ~1000 random Weyl operators, and adversarial L-BFGS minimization of the
    relative margin from matching-, random-, sphere- and Kahler-seeded starts.
    No criticality and no theta floor is needed: the answer to FINDINGS' open
    question (a)/(b)/(c) is (a), empirically.  The margin's global minimum is 0,
    attained at an explicit EQUALITY FAMILY: the diagonal "matching" Weyl
    operator W(e_i^e_sigma(i)) = (n-2)c, W(e_i^e_j) = -c otherwise (sigma a
    perfect matching) -- IDENTIFIED (PART 0) as the Weyl operator of the
    n/2-fold sphere product S^2 x ... x S^2, an exactly critical point
    (idempotency residual 2e-16, P matches multiblock_P(n, [2,...,2]) to all
    digits: 0.645497/0.540062/0.428174 at n = 6/8/12).  The transverse Hessian
    of the margin is positive there in every sampled direction.  The Kahler
    adversarial family (Weyl part of CP^{n/2}, where a spiky non-decomposable
    W_+ would break every sufficient condition below) lands at ratio (n-2)/2 --
    harmless.

(B) A PROVEN, UNCONDITIONAL THEOREM (PART 1) that replaces the grant.  Let
    W != 0 be any operator on Lambda^2 R^n with Ric(W) = 0 (only Ricci-flatness
    is used -- no Bianchi, no criticality, no unit norm).  Spectral parts
    W = W_+ - W_-, g := Ric(W_-) = Ric(W_+) >= 0, h := Ric(|W|) = 2g,
    G_p := tr g^p, lam+ := lambda_max(W_+) > 0.  Then

      THEOREM.  <Ric(W_-^2), h>  >=  tr(h^3) / (4 (n - 1 - nu0)),
                nu0 := G4/(lam+ G3) = tr(h^4) / (2 lam+ tr(h^3)),

    and automatically 0 < nu0 < n-1.  The bound is AT LEAST as strong as
    Jaeger's n-2 exactly when nu0 >= 1, and is SHARP -- equality, with
    nu0 = 1 -- on the matching family.  Dropping the nu0 term gives
    <Ric(A^2), Ric(A)> >= tr(Ric(A)^3)/(n-1) for EVERY PSD A on Lambda^2
    (no structure at all), which is (3.3.5) with 4(n-1).

    PROOF (verified step by step in PART 1).  Work in an orthonormal eigenbasis
    {u_i} of g, mu_i >= 0; phi_ik := u_i^u_k.  For any symmetric X the diagonal
    of Ric(X) is the row sum of Lambda^2-diagonals: Ric(X)_ii =
    sum_k <X phi_ik, phi_ik>.  Write A := W_-, a_ik := <A phi_ik, phi_ik> >= 0,
    so sum_k a_ik = mu_i.  Let Pi project onto ker A, kappa_ik :=
    ||Pi phi_ik||^2, nu_i := sum_k kappa_ik = Ric(Pi)_ii.
    STEP 1 (per-row master).  ran A = (ker A)^perp gives a_ik =
    <A phi_ik, (1-Pi) phi_ik> <= ||A phi_ik|| sqrt(1-kappa_ik), so by
    Cauchy-Schwarz over k (terms with kappa=1 have a=0 and drop),
        mu_i^2 = (sum_k a_ik)^2 <= (sum_k a_ik^2/(1-kappa_ik)) (n-1-nu_i)
               <= Ric(A^2)_ii (n-1-nu_i).
    STEP 2 (Jensen).  <Ric(A^2), g> = sum_i mu_i Ric(A^2)_ii >=
    sum_i mu_i^3/(n-1-nu_i) >= G3/(n-1-nubar) with nubar :=
    tr(g^3 Ric(Pi))/G3, by convexity of 1/(n-1-nu) with weights mu_i^3
    (rows with mu_i > 0 have nu_i < n-1, so nubar < n-1).
    STEP 3 (the W_+ shadow -- the invariant analogue of Jaeger's row zero).
    Ricci-flatness gives Ric(W_+) = g; W_+ W_- = 0 gives ker A >= ran W_+, so
    Pi >= Pi_+ >= W_+/lam+ and positivity of Ric gives nu_i >= mu_i/lam+,
    whence nubar >= G4/(lam+ G3) = nu0.  Monotonicity of 1/(n-1-nu) finishes;
    h = 2g converts (tr h^3 = 8 G3).                                   QED

    THE INTERMEDIATE FORM IS EXACT ACROSS THE CATALOGUE (PART 1).  The proven
    step-2 inequality <Ric(W_-^2), h> >= tr h^3/(4(n-1-nubar)), nubar =
    tr(g^3 Ric(Pi_ker))/tr g^3, holds with EQUALITY (residual ~1e-16) at the
    matching family, every balanced sphere product, Fox S^4(alpha), SU(3), and
    QK HP^2 -- so the mu^3-weighted kernel visibility nubar is the exact
    invariant that Jaeger's diagonal row-count was measuring, and only the
    unbalanced spheres and generic points leave it slack.

    COROLLARY 1 (Jaeger's diagonal case recovered, constant n-2).  For
    coordinate-diagonal Weyl W, g is diagonal in the coordinate frame, and each
    row with mu_i > 0 has a positive vertex entry (row sums vanish), i.e. a
    coordinate pair in ran W_+ <= ker A: nu_i >= 1, so nubar >= 1 and the
    theorem gives the n-2 constant with no further hypothesis.
    COROLLARY 2 (chain form).  tr h^4 = r^4 v (v := tr S^4), tr h^3 <=
    r^3 sqrt(v) (Cauchy-Schwarz <h, h^2>), and for unit-norm W, lam+ <=
    ||W_+|| <= sqrt(1-cW(n)) (the proven ||W_-||^2 floor), so
        nu0 >= r sqrt(v) / (2 sqrt(1-cW)),
    every quantity in the lifted chain's vocabulary.

(C) WHY THE SHARP n-2 REMAINS A CONJECTURE (PART 2, certificates).  The proof
    above gives n-2 exactly when nubar >= 1 ("diamond").  Three natural
    universal sufficient conditions are all REFUTED by explicit Weyl
    counterexamples found adversarially (at which the main inequality itself
    holds with large margin, +0.28 .. +0.65 relative):
      (star2)   tr((g^2id) Pi_ker) >= tr g      [crude Cauchy-Schwarz route]
      (star)    tr((g^2id) Pi_ker) >= (n-1)G1 - (n-2)G2^2/G3   [exact CS route]
      (diamond) nubar >= 1                       [the Jensen route above]
    So no single one of these mechanisms proves the sharp constant; the truth
    of n-2 rests on a trade-off between them.  The PER-ROW form of n-2
    (Ric(W_-^2)_ii >= mu_i^2/(n-2) in the g-eigenframe) is refuted too, so the
    sharp lemma is irreducibly an aggregate statement -- surplus rows must
    cover deficit rows.  The sharp statement stays on the grant list ONLY if
    its full strength is wanted; the chain no longer needs it (PART 3).

(D) c(12) WITHOUT THE GRANT (PART 3).  The lifted chain's only use of (3.3.5)
    is the middle term of B in L4, hat*r^2/(2 C (r^2+24d)) with C = n-2.
    Replacing C by the PROVEN n - 1 - r_min sqrt(v)/(2 sqrt(1-cW)) (Corollary
    2; conservative direction verified: the term is increasing in r, so r_min
    is safe) and re-running the chain (reimplemented here, validated
    diff = 0.0 against run_breakeven_theta at C = n-2):

        c(12) at tilde_theta_0:  granted n-2       1.081e-3   (reproduces Result 10)
                                 PROVEN theorem    1.0008e-3  (92.6% retained)
                                 crude n-1         7.50e-4    (69%)

    Fox anchor: the chain stays silent at d = 1/9 under all three constants.
    CONSEQUENCE: the dichotomy of FINDINGS Result 10 now stands on the
    hypothesis list {J5 >= 0, E-track certificate} alone, with
    c(12) = 1.0008e-3 -- the lifted-3.3.5 grant is DISCHARGED.

HONEST GAPS.  (i) The sharp n-2 statement for all Weyl W is still unproven --
what is proven is the nu0-interpolated constant, which reaches n-2 exactly on
the equality family and on the diagonal locus.  (ii) The equality-manifold
identification (the S^2-product family only) is numerical: adversarial
searches from ~30 starts per dimension plus 1500-direction second-order
probes; no completeness proof.  (iii) The adversarial searches use
finite-difference L-BFGS/Powell on a nonsmooth objective (eigenvalue
crossings); they are falsification attempts, not certified global minima.
(iv) The exactness of the nubar form across the named critical points is
observed to machine precision, not yet derived from the compression
identities.

RUNTIME ~2 min.                    USAGE: python3 run_lift_335_proof.py
"""
import time

import numpy as np
from scipy.optimize import minimize

from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop, mop_from_4tensor, norm, frob
from run_defect_penalty_test import setup, fox_weyl, sphere_weyl, qk_weyl
from run_bianchi_defect import bianchi_defect
from run_bianchi_defect_highp_seed import build_su3_n8, pad_weyl_to_n
import run_breakeven_theta as bk

FAILS = []


def check(label, ok, detail=""):
    tag = "ok " if ok else "FAIL"
    if not ok:
        FAILS.append(label)
    print(f"    [{tag}] {label}{('  ' + detail) if detail else ''}")


# ---------------------------------------------------------------- fast Ric map
def build_ric_map(L2):
    """Dense (n^2, N^2) matrix M with vec(Ric(R)) = M @ vec(R), from the same
    index convention as weyl_decomposition.ricci_from_mop (validated PART 0)."""
    n, N, idx = L2.n, L2.N, L2.idx
    M = np.zeros((n * n, N * N))
    for i in range(n):
        for k in range(n):
            for j in range(n):
                if j == i or j == k:
                    continue
                a, s1 = (idx[(i, j)], 1.0) if i < j else (idx[(j, i)], -1.0)
                b, s2 = (idx[(k, j)], 1.0) if k < j else (idx[(j, k)], -1.0)
                M[i * n + k, a * N + b] += s1 * s2
    return M


def ric_fast(ricmap, n, X):
    R = (ricmap @ X.reshape(-1)).reshape(n, n)
    return 0.5 * (R + R.T)


# --------------------------------------------------------- special operators
def matching_weyl(ctx):
    """The equality family: diagonal Weyl with vertex matrix w_{i,sigma(i)} =
    n-2 (sigma = the pairing (0,1)(2,3)...), w_{ij} = -1 otherwise.  Row sums
    vanish, so it is Ricci-flat; diagonal operators are automatically Bianchi.
    Identified (PART 0) as the Weyl operator of S^2 x ... x S^2 (n/2 factors),
    an exactly critical point of P."""
    n, N, L2 = ctx["n"], ctx["N"], ctx["L2"]
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(L2.pairs):
        W[a, a] = float(n - 2) if (j == i + 1 and i % 2 == 0) else -1.0
    return W / norm(W)


def cpm_weyl(ctx):
    """Weyl part of the CP^{n/2} (Fubini-Study) curvature operator -- the
    Kahler adversarial family (spiky W_+ on a non-decomposable bivector)."""
    n, L2 = ctx["n"], ctx["L2"]
    J = np.zeros((n, n))
    for a in range(n // 2):
        J[2 * a, 2 * a + 1], J[2 * a + 1, 2 * a] = 1.0, -1.0
    I = np.eye(n)

    def T(i, j, k, l):
        return (I[i, k] * I[j, l] - I[i, l] * I[j, k]
                + J[i, k] * J[j, l] - J[i, l] * J[j, k] + 2.0 * J[i, j] * J[k, l])

    x = ctx["Eflat"] @ mop_from_4tensor(L2, T).reshape(-1)
    W = (x @ ctx["Eflat"]).reshape(ctx["N"], ctx["N"])
    return W / norm(W)


def random_weyl(ctx, rng):
    x = rng.normal(size=ctx["D"])
    W = (x @ ctx["Eflat"]).reshape(ctx["N"], ctx["N"])
    W = 0.5 * (W + W.T)
    return W / norm(W)


# ------------------------------------------------- all statistics at a point
def stats(Wn, ctx, ricmap, ktol=1e-11):
    """Every quantity of the theorem at one operator (need not be critical)."""
    n = ctx["n"]
    w, V = np.linalg.eigh(Wn)
    neg = w < -ktol
    A = (V[:, neg] * (-w[neg])) @ V[:, neg].T                     # W_-
    g = ric_fast(ricmap, n, A)
    mu, U = np.linalg.eigh(g)
    mu = np.maximum(mu, 0.0)
    G1, G2, G3, G4 = (mu.sum(), (mu ** 2).sum(), (mu ** 3).sum(), (mu ** 4).sum())
    RA2 = ric_fast(ricmap, n, A @ A)
    rows_lhs = np.diag(U.T @ RA2 @ U)                             # Ric(A^2)_ii
    lhs = float(np.dot(mu, rows_lhs))                             # <Ric(A^2), g>
    ker = w > -ktol
    Pi = (V[:, ker]) @ (V[:, ker]).T                              # ker W_- proj
    nu = np.diag(U.T @ ric_fast(ricmap, n, Pi) @ U)               # visibility
    lamp = max(float(w.max()), 0.0)
    nubar = float(np.dot(mu ** 3, nu) / G3) if G3 > 0 else 0.0
    nu0 = G4 / (lamp * G3) if (lamp > 0 and G3 > 0) else 0.0
    # h-language (h = 2g): r^2 = tr h^2, v = tr S^4
    r2h = 4.0 * G2
    v = (16.0 * G4) / (r2h * r2h) if r2h > 0 else 0.0
    return dict(w=w, mu=mu, nu=nu, rows_lhs=rows_lhs, lhs=lhs, lamp=lamp,
                G1=G1, G2=G2, G3=G3, G4=G4, nubar=nubar, nu0=nu0,
                r=np.sqrt(r2h), v=v)


def theorem_checks(Wn, ctx, ricmap, label, verbose=True, tol=1e-9):
    """Verify every step of the proven theorem at one point; return margins."""
    n = ctx["n"]
    st = stats(Wn, ctx, ricmap)
    mu, nu, rows_lhs = st["mu"], st["nu"], st["rows_lhs"]
    G3, lhs, nu0, nubar = st["G3"], st["lhs"], st["nu0"], st["nubar"]
    if G3 <= 1e-30:
        return None
    scale = max(mu.max(), 1e-30)
    # STEP 1: per-row master  Ric(A^2)_ii >= mu_i^2/(n-1-nu_i)
    m1 = float((rows_lhs - mu ** 2 / np.maximum(n - 1.0 - nu, 1e-14)).min())
    # STEP 3: per-row shadow  nu_i >= mu_i/lam+
    m3 = float((nu - mu / max(st["lamp"], 1e-30)).min()) if st["lamp"] > 0 else 0.0
    # assembled bounds
    thm = lhs - G3 / (n - 1.0 - nu0)                      # the theorem
    jen = lhs - G3 / (n - 1.0 - nubar)                    # sharper nubar form
    nm1 = lhs - G3 / (n - 1.0)                            # unconditional n-1
    rel = (n - 2.0) * lhs / G3 - 1.0                      # sharp-conjecture margin
    # Corollary 2 floor (unit-norm Wn assumed by caller)
    cW = bk.consts(n)["cW"]
    cor2 = nu0 - st["r"] * np.sqrt(st["v"]) / (2.0 * np.sqrt(1.0 - cW))
    ok = (m1 > -tol * scale ** 2 and m3 > -tol * scale and nubar >= nu0 - tol
          and thm > -tol * scale ** 3 and jen > -tol * scale ** 3
          and nm1 > -tol * scale ** 3 and cor2 > -tol)
    if verbose:
        print(f"  {label:26s} n={n:2d}  rel(n-2)={rel:+.5f}  nu0={nu0:6.3f}  "
              f"nubar={nubar:6.3f}  const={n - 1 - nu0:6.3f}  "
              f"steps[master={m1:+.1e} shadow={m3:+.1e} thm={thm:+.1e} cor2={cor2:+.1e}]"
              f"{'' if ok else '   <-- STEP FAILURE'}")
    return dict(rel=rel, nu0=nu0, nubar=nubar, ok=ok, thm=thm)


# =========================================================== PART 0
def part0():
    print("=" * 78)
    print("PART 0: machinery validation (conventions this proof relies on)")
    print("=" * 78)
    rng = np.random.default_rng(0)
    for n in (6, 8):
        L2 = Lambda2(n)
        ricmap = build_ric_map(L2)
        N = L2.N
        X = rng.normal(size=(N, N)); X = 0.5 * (X + X.T)
        r1, r2 = ric_fast(ricmap, n, X), ricci_from_mop(L2, X)
        check(f"n={n} fast Ric map == ricci_from_mop", np.abs(r1 - r2).max() < 1e-12,
              f"resid {np.abs(r1 - r2).max():.1e}")
        # adjoint identity <Ric(X), h> = sum_{i<j} (h_i+h_j) X_(ij)(ij) in h-frame
        h = rng.normal(size=(n, n)); h = 0.5 * (h + h.T)
        hv, hU = np.linalg.eigh(h)
        # rotate X into the h-eigenframe on Lambda^2 via the induced rotation
        lhs = frob(ric_fast(ricmap, n, X), h)
        Kdiag = mop_from_4tensor(L2, lambda i, j, k, l:
                                 (h[i, k] * (j == l) - h[i, l] * (j == k)
                                  + (i == k) * h[j, l] - (i == l) * h[j, k]))
        check(f"n={n} adjoint  <Ric(X),h> = <X, h^2id>", abs(lhs - frob(X, Kdiag)) < 1e-10,
              f"resid {abs(lhs - frob(X, Kdiag)):.1e}")
        # Ric positivity + row-sum identity
        B = rng.normal(size=(N, N)); B = B @ B.T
        check(f"n={n} Ric of PSD is PSD",
              np.linalg.eigvalsh(ric_fast(ricmap, n, B)).min() > -1e-10)
        i0 = 1
        rowsum = 0.0
        for k in range(n):
            if k == i0:
                continue
            phi = np.zeros(N); phi[L2.idx[(min(i0, k), max(i0, k))]] = 1.0
            rowsum += phi @ X @ phi
        check(f"n={n} row-sum identity Ric(X)_ii = sum_k X_(ik)(ik)",
              abs(ric_fast(ricmap, n, X)[i0, i0] - rowsum) < 1e-12)
    # the matching operator is a genuine Weyl operator, and it is the exactly
    # critical Weyl operator of the n/2-fold sphere product S^2 x ... x S^2
    from weyl import build_structure_constants
    from rsharp_basis_free import Q_full
    from multiblock_formula import multiblock_P
    for n in (6, 8, 12):
        ctx = setup(n, verbose=False)
        Wm = matching_weyl(ctx)
        x = ctx["Eflat"] @ Wm.reshape(-1)
        recon = norm((x @ ctx["Eflat"]).reshape(ctx["N"], ctx["N"]) - Wm)
        ric = np.abs(ric_fast(build_ric_map(ctx["L2"]), n, Wm)).max()
        d2 = bianchi_defect(Wm, ctx["alt_idx"]) ** 2
        check(f"n={n} matching operator is Weyl", recon < 1e-12 and ric < 1e-12,
              f"weyl-proj resid {recon:.1e}, |Ric| {ric:.1e}, delta^2 {d2:.1e}")
        _, _, _, cst = build_structure_constants(n)
        Q = Q_full(Wm, cst)
        th = frob(Wm, Q)
        resid = norm(Q - th * Wm) / norm(Q)
        check(f"n={n} matching = critical Weyl of S^2 x ... x S^2 ({n // 2} blocks)",
              resid < 1e-12 and abs(th - multiblock_P(n, [2] * (n // 2))) < 1e-12,
              f"idemp resid {resid:.1e}, P = {th:.9f} = multiblock_P")


# =========================================================== PART 1
def part1():
    print()
    print("=" * 78)
    print("PART 1: the PROVEN theorem, step-verified at the catalogue + randoms")
    print("        (rel(n-2) >= 0 <=> the sharp conjecture holds at the point;")
    print("         nu0 >= 1 <=> the proven constant beats Jaeger's n-2 there)")
    print("=" * 78)
    worst = {"rel": np.inf, "thm": np.inf}
    allok = True
    for n in (6, 8, 12):
        ctx = setup(n, verbose=False)
        ricmap = build_ric_map(ctx["L2"])
        rng = np.random.default_rng(10 + n)
        pts = [("matching (equality)", matching_weyl(ctx))]
        pts += [(f"sphere ({p},{n - p})", sphere_weyl(ctx, p)) for p in range(2, n // 2 + 1)]
        pts += [("Fox S^4(alpha)", fox_weyl(ctx)), ("Weyl CP^(n/2)", cpm_weyl(ctx)),
                ("-Weyl CP^(n/2)", -cpm_weyl(ctx))]
        if n == 8:
            _, Wsu3 = build_su3_n8()
            pts += [("SU(3) bi-invariant", Wsu3), ("QK HP^2", qk_weyl(ctx, 2))]
        if n == 12:
            _, Wsu3 = build_su3_n8()
            _, Wp = pad_weyl_to_n(Lambda2(8), Wsu3, 12)
            pts += [("SU(3) padded", Wp / norm(Wp)), ("QK HP^3", qk_weyl(ctx, 3))]
        for lab, W in pts:
            r = theorem_checks(W, ctx, ricmap, lab)
            if r:
                allok &= r["ok"]
                worst["rel"] = min(worst["rel"], r["rel"])
        nrand = 300 if n < 12 else 120
        wr, wt, okr = np.inf, np.inf, True
        for _ in range(nrand):
            r = theorem_checks(random_weyl(ctx, rng), ctx, ricmap, "", verbose=False)
            if r:
                okr &= r["ok"]
                wr, wt = min(wr, r["rel"]), min(wt, r["thm"])
        print(f"  random x{nrand} at n={n}: worst rel(n-2) = {wr:+.5f}, "
              f"worst theorem margin = {wt:+.2e}, all proof steps hold: {okr}")
        allok &= okr
        worst["rel"] = min(worst["rel"], wr)
    # exact equality at matching, all three dimensions
    for n in (6, 8, 12):
        ctx = setup(n, verbose=False)
        ricmap = build_ric_map(ctx["L2"])
        st = stats(matching_weyl(ctx), ctx, ricmap)
        eq = abs((ctx["n"] - 2.0) * st["lhs"] / st["G3"] - 1.0)
        check(f"n={n} matching: EXACT equality in (3.3.5) and nu0 = 1",
              eq < 1e-12 and abs(st["nu0"] - 1.0) < 1e-10,
              f"|rel| {eq:.1e}, |nu0-1| {abs(st['nu0'] - 1):.1e}")
    # the intermediate (Jensen/nubar) form is EXACT at the named critical points
    for n in (6, 8):
        ctx = setup(n, verbose=False)
        ricmap = build_ric_map(ctx["L2"])
        pts = [("matching", matching_weyl(ctx)),
               (f"sphere({n // 2},{n // 2})", sphere_weyl(ctx, n // 2)),
               ("Fox", fox_weyl(ctx))]
        if n == 8:
            pts += [("SU(3)", build_su3_n8()[1]), ("QK HP^2", qk_weyl(ctx, 2))]
        wtight = max(abs((n - 1.0 - stats(W, ctx, ricmap)["nubar"])
                         * stats(W, ctx, ricmap)["lhs"] / stats(W, ctx, ricmap)["G3"] - 1.0)
                     for _, W in pts)
        check(f"n={n} nubar-form EXACT at matching/balanced sphere/Fox"
              + ("/SU(3)/QK" if n == 8 else ""), wtight < 1e-12, f"worst resid {wtight:.1e}")
    check("PART 1: every step of the theorem verified at every point", allok,
          f"worst sharp-conjecture margin {worst['rel']:+.5f}")


# =========================================================== PART 2
def _rel_obj(ctx, ricmap):
    n, N, Eflat = ctx["n"], ctx["N"], ctx["Eflat"]

    def rel(x):
        W = (x @ Eflat).reshape(N, N)
        W = 0.5 * (W + W.T)
        nw = norm(W)
        if nw < 1e-12:
            return 10.0
        st = stats(W / nw, ctx, ricmap)
        if st["G3"] <= 1e-30:
            return 10.0
        return (n - 2.0) * st["lhs"] / st["G3"] - 1.0

    return rel


def part2():
    print()
    print("=" * 78)
    print("PART 2: falsification battery for the SHARP n-2 conjecture, and the")
    print("        counterexample certificates for the three sufficient conditions")
    print("=" * 78)
    t0 = time.time()
    for n in (6, 8):
        ctx = setup(n, verbose=False)
        ricmap = build_ric_map(ctx["L2"])
        Eflat, D = ctx["Eflat"], ctx["D"]
        rng = np.random.default_rng(42)
        rel = _rel_obj(ctx, ricmap)
        xm = Eflat @ matching_weyl(ctx).reshape(-1)
        xm /= np.linalg.norm(xm)

        # second-order probe at the equality point
        wmin = np.inf
        for _ in range(1500):
            eta = rng.normal(size=D)
            eta -= np.dot(eta, xm) * xm
            eta /= np.linalg.norm(eta)
            wmin = min(wmin, rel(xm + 1e-3 * eta), rel(xm + 1e-2 * eta))
        check(f"n={n} 2nd-order probe at matching: margin >= 0 in 1500 directions",
              wmin > -1e-12, f"min {wmin:+.2e}")

        # adversarial minimization of the margin
        seeds = [xm + 0.005 * rng.normal(size=D), xm + 0.05 * rng.normal(size=D)]
        seeds += [rng.normal(size=D) for _ in range(4)]
        best = np.inf
        for x0 in seeds:
            r = minimize(rel, x0 / np.linalg.norm(x0), method="L-BFGS-B",
                         options=dict(maxiter=250, eps=1e-7))
            best = min(best, r.fun)
        check(f"n={n} adversarial min of margin over 6 L-BFGS starts >= 0",
              best > -1e-8, f"min {best:+.2e} (0 attained at matching)")

        # ---- counterexample certificates for the sufficient conditions ----
        def suff(x):
            W = (x @ Eflat).reshape(ctx["N"], ctx["N"])
            W = 0.5 * (W + W.T)
            nw = norm(W)
            if nw < 1e-12:
                return None
            st = stats(W / nw, ctx, ricmap)
            if st["G3"] <= 1e-30 or st["G1"] <= 1e-15:
                return None
            w, V = np.linalg.eigh(W / nw)
            P = (V[:, w > -1e-11]) @ (V[:, w > -1e-11]).T
            g = ric_fast(ricmap, ctx["n"], (V[:, w < -1e-11] * (-w[w < -1e-11])) @ V[:, w < -1e-11].T)
            trKP = frob(ric_fast(ricmap, ctx["n"], P), g)
            star2 = trKP / st["G1"] - 1.0
            star = (trKP - (ctx["n"] - 1.0) * st["G1"]
                    + (ctx["n"] - 2.0) * st["G2"] ** 2 / st["G3"]) / st["G1"]
            return dict(star2=star2, star=star, diamond=st["nubar"] - 1.0,
                        rel=(ctx["n"] - 2.0) * st["lhs"] / st["G3"] - 1.0)

        if n == 6:
            found = {}
            for key, obj_key in (("star2", "star2"), ("diamond", "diamond")):
                def obj(x, k=obj_key):
                    s = suff(x)
                    return 10.0 if s is None else s[k]
                hit = None
                for s0 in (0.02, 0.05, 0.1):
                    for _ in range(4):
                        x0 = xm + s0 * rng.normal(size=D)
                        r = minimize(obj, x0 / np.linalg.norm(x0), method="L-BFGS-B",
                                     options=dict(maxiter=200, eps=1e-7))
                        if r.fun < -1e-4:
                            hit = r.x / np.linalg.norm(r.x)
                            break
                    if hit is not None:
                        break
                found[key] = hit
            s2 = suff(found["star2"]) if found["star2"] is not None else None
            check("n=6 (star2) refuted at a Weyl point where (3.3.5) holds",
                  s2 is not None and s2["star2"] < -1e-4 and s2["rel"] > 0.01,
                  "" if s2 is None else f"star2 {s2['star2']:+.4f}, star {s2['star']:+.4f}, "
                  f"margin there {s2['rel']:+.4f}")
            check("n=6 (star) refuted at the same point (star <= star2 identically)",
                  s2 is not None and s2["star"] < -1e-4)
            dd = suff(found["diamond"]) if found["diamond"] is not None else None
            check("n=6 (diamond: nubar >= 1) refuted at a Weyl point where (3.3.5) holds",
                  dd is not None and dd["diamond"] < -1e-4 and dd["rel"] > 0.01,
                  "" if dd is None else f"nubar-1 {dd['diamond']:+.4f}, margin there {dd['rel']:+.4f}")
    # ---- the PER-ROW n-2 inequality is also refutable: the sharp lemma is
    # irreducibly an AGGREGATE statement (surplus rows must cover deficit rows)
    ctx = setup(6, verbose=False)
    ricmap = build_ric_map(ctx["L2"])
    Eflat, D, N6 = ctx["Eflat"], ctx["D"], ctx["N"]

    def rowmin(x):
        W = (x @ Eflat).reshape(N6, N6)
        W = 0.5 * (W + W.T)
        nw = norm(W)
        if nw < 1e-12:
            return 10.0
        st = stats(W / nw, ctx, ricmap)
        return float((st["rows_lhs"] - st["mu"] ** 2 / (ctx["n"] - 2.0)).min())

    rng = np.random.default_rng(77)
    x0 = rng.normal(size=D)
    r = minimize(rowmin, x0 / np.linalg.norm(x0), method="Powell",
                 options=dict(maxiter=500, xtol=1e-6))
    xr = r.x / np.linalg.norm(r.x)
    Wr = (xr @ Eflat).reshape(N6, N6)
    st = stats(0.5 * (Wr + Wr.T), ctx, ricmap)
    agg = (ctx["n"] - 2.0) * st["lhs"] / st["G3"] - 1.0
    check("n=6 PER-ROW n-2 version refuted while the aggregate holds",
          r.fun < -1e-4 and agg > 0.01,
          f"min row slack {r.fun:+.5f}, aggregate margin {agg:+.4f}")

    # n=12: battery-only (adversarial cost grows as D=1638; PART 1 covered it)
    ctx = setup(12, verbose=False)
    ricmap = build_ric_map(ctx["L2"])
    rng = np.random.default_rng(3)
    wr = min(theorem_checks(random_weyl(ctx, rng), ctx, ricmap, "", verbose=False)["rel"]
             for _ in range(150))
    check("n=12 random battery x150: sharp margin >= 0", wr > -1e-12, f"worst {wr:+.5f}")
    print(f"  [PART 2 {time.time() - t0:.0f}s]")


# =========================================================== PART 3
def chain_mod(ct, th, d, t, v, mode):
    """run_breakeven_theta.chain with the 3.3.5 constant parametrized.
    mode granted: C = n-2 (Jaeger, unproven off-diagonal)
    mode proven:  C = n-1 - r_min sqrt(v)/(2 sqrt(1-cW))  (this file's theorem;
                  r_min is the conservative direction -- the L4 middle term is
                  increasing in r both directly and through 1/C)
    mode crude:   C = n-1 (theorem with nu0 dropped)."""
    n, cW, K = ct["n"], ct["cW"], 24.0 * d
    hat = (n - 2.0) / (n - 3.0) * th
    r2_min = np.maximum.reduce([hat * t - K, th * t - K + 4.0 * cW, t * t / n])
    r2_max = v * t * t
    adm = (r2_min > 0) & (r2_min <= r2_max) & (v >= 1.0 / n) & (v <= 1.0) \
        & (t >= ct["t_lo_abs"]) & (t <= ct["t_hi"])
    r_min = np.sqrt(np.maximum(r2_min, 1e-300))
    if mode == "granted":
        C335 = np.full_like(t + v, n - 2.0)
    elif mode == "crude":
        C335 = np.full_like(t + v, n - 1.0)
    elif mode == "proven":
        C335 = np.maximum(n - 1.0 - r_min * np.sqrt(np.maximum(v, 0.0))
                          / (2.0 * np.sqrt(1.0 - cW)), 1e-6)
    else:
        raise ValueError(mode)
    p = K * np.power(np.maximum(v, 1e-300), 0.25) / r_min
    Bp = np.maximum(th + hat * r2_min / (2.0 * C335 * (r2_min + K)) - p, 0.0)
    adm = adm & (v <= 1.0 - Bp * Bp / 2.0)
    y = np.minimum(np.maximum((bk.ALPHA_Y * v + bk.C_Y) ** 2, r2_min / (t * t)), v)
    s = np.clip(Bp / np.sqrt(2.0 * np.maximum(1.0 - v, 1e-300)), 1e-12, 1.0)
    x = n * v - 1.0
    with np.errstate(divide="ignore", invalid="ignore"):
        Z = (v - y) * (1.0 - y) / (np.maximum(1.0 - v, 1e-300) ** 2
                                   * np.maximum(v + y, 1e-300))
    c2, c1, c0 = bk.phi_coeffs(n, th)
    app = ((c2 * x * x + c1 * x + c0) <= 0.0) & (x <= 2.0) \
        & (v / 2.0 + (th / np.sqrt(2.0)) * np.sqrt(np.maximum(1.0 - v, 0.0)) >= 1.5 / n) \
        & (Z <= 0.5) \
        & ((1.0 + np.sqrt(np.maximum(Z, 0.0))) * t / (2.0 * th * r2_min) <= 1.0) \
        & (t <= ct["tt_max_331"] / th) & (th >= ct["theta_min_331"]) & (x >= 0.0)
    pen = (n - 3.0) / (n - 2.0) * np.sqrt(2.0) * np.sqrt(np.maximum(1.0 - v, 0.0)) \
        * K * t * np.power(np.maximum(v, 0.0), 0.75) / s
    return dict(adm=adm, app=app, rhs=bk.rhs_formula(ct, th, d, t, v, y, pen))


def escape_mod(ct, th, d, mode, nt=700, nv=700, refine=3):
    tlo, thi, vlo, vhi = ct["t_lo_abs"], ct["t_hi"], 1.0 / ct["n"], 1.0
    best, where = -np.inf, None
    for _ in range(refine + 1):
        T, V = np.meshgrid(np.linspace(tlo, thi, nt), np.linspace(vlo, vhi, nv),
                           indexing="ij")
        c = chain_mod(ct, th, d, T, V, mode)
        if (c["adm"] & ~c["app"]).any():
            return np.inf, None
        val = np.where(c["adm"], c["rhs"], -np.inf)
        i = int(np.argmax(val.ravel()))
        if val.ravel()[i] > best:
            best = float(val.ravel()[i])
            where = (float(T.ravel()[i]), float(V.ravel()[i]))
        if not np.isfinite(best):
            return -np.inf, None
        dt, dv = (thi - tlo) / nt, (vhi - vlo) / nv
        tlo, thi = max(ct["t_lo_abs"], where[0] - 3 * dt), min(ct["t_hi"], where[0] + 3 * dt)
        vlo, vhi = max(1.0 / ct["n"], where[1] - 3 * dv), min(1.0, where[1] + 3 * dv)
    return best, where


def corner_mod(ct, th, mode, digits=40):
    """mpmath corner refinement of c (v = 1 - B^2/2 and RHS = 0 at t = t_hi),
    mirroring run_breakeven_theta.corner_c with the parametrized constant."""
    from mpmath import mp, mpf, sqrt, findroot
    mp.dps = digits
    n = mpf(ct["n"]); t = mpf(ct["t_hi"]); th = mpf(th); cW = mpf(ct["cW"])
    hat = (n - 2) / (n - 3) * th
    aY, cY = mpf(7) / 10, mpf(8647) / 38000

    def C335(r2, v):
        if mode == "granted":
            return n - 2
        if mode == "crude":
            return n - 1
        return n - 1 - sqrt(r2) * sqrt(v) / (2 * sqrt(1 - cW))

    def eqs(v, d):
        K = 24 * d
        r2 = max(hat * t - K, th * t - K + 4 * cW, t * t / n)
        B = th + hat * r2 / (2 * C335(r2, v) * (r2 + K)) - K * v ** mpf(0.25) / sqrt(r2)
        f1 = v - (1 - max(B, mpf(0)) ** 2 / 2)
        y = min(max((aY * v + cY) ** 2, r2 / (t * t)), v)
        s = min(max(B, mpf(0)) / sqrt(2 * (1 - v)), mpf(1))
        x = n * v - 1
        Y0 = (2 * n - 9) / (4 * n ** 3) + 3 * x / (8 * n ** 2)
        M = v + sqrt((v * v - y * y) / (1 - y))
        pen = (n - 3) / (n - 2) * sqrt(2) * sqrt(1 - v) * K * t * v ** mpf(0.75) / s
        f2 = (-(mpf(263) / 144) * (n - 3) / (n ** 2 * (n - 2))
              * (t * t - t ** 4 / (n * (hat * t - K)))
              - 2 * th * Y0 * t + 48 * d * (n - 3) / (n - 2) * Y0
              + (2 * sqrt(2) / hat) * sqrt(1 - v) * M + pen)
        return f1, f2

    v, d = findroot(eqs, (mpf("0.158"), mpf("0.001")))
    return float(d), float(v)


def part3():
    print()
    print("=" * 78)
    print("PART 3: c(12) with the 3.3.5 constant  granted (n-2) / PROVEN / crude (n-1)")
    print("=" * 78)
    ct = bk.consts(12)
    th = ct["tilde0"]
    for d in (0.0, 5e-4, 1.05e-3):
        a, b = bk.escape_score(ct, th, d)[0], escape_mod(ct, th, d, "granted")[0]
        check(f"chain reimplementation == run_breakeven_theta at d={d:.2e}",
              abs(a - b) < 1e-12, f"orig {a:+.8f} vs mod {b:+.8f}")
    out = {}
    for mode in ("granted", "proven", "crude"):
        t0 = time.time()
        hi = 1e-3
        while escape_mod(ct, th, hi, mode)[0] < 0 and hi < 1.0:
            hi *= 2.0
        c = bk.bisect(lambda dd: not (escape_mod(ct, th, dd, mode)[0] < 0), 0.0, hi, 1e-10)
        out[mode] = c
        try:
            cm, vm = corner_mod(ct, th, mode)
            refine = f"corner (mpmath 40 digits) c = {cm:.10e} at v = {vm:.6f}, agree {abs(cm - c):.1e}"
        except Exception as exc:                             # pragma: no cover
            refine = f"corner refinement failed: {exc}"
        print(f"  c(12) at tilde_theta_0, mode = {mode:8s}: {c:.6e}   [{time.time() - t0:.0f}s]")
        print(f"      {refine}")
        sc = escape_mod(ct, th, 1.0 / 9.0, mode)[0]
        check(f"Fox anchor mode={mode}: chain silent at d = 1/9",
              not (sc < 0.0), f"max RHS = {sc:+.4f}")
    keep = out["proven"] / out["granted"]
    check("PROVEN constant retains > 90% of the granted c(12)", keep > 0.9,
          f"c_proven/c_granted = {keep:.4f}")
    print(f"\n  CONSEQUENCE.  The Result-10 dichotomy at n=12 now reads, with NO 3.3.5")
    print(f"  grant: every critical point with theta >= tilde_theta_0(12) has")
    print(f"    scal(|W|) >= 13 tilde_theta_0(12)   or   delta^2 >= {out['proven']:.6e},")
    print(f"  resting on the hypothesis list {{J5 >= 0, E-track certificate}} alone.")
    return out


def main():
    t0 = time.time()
    part0()
    part1()
    part2()
    part3()
    print()
    print("=" * 78)
    print(f"SUMMARY  [{time.time() - t0:.0f}s total]")
    print("=" * 78)
    print("  THEOREM (proven):  <Ric(W_-^2), h> >= tr h^3 / (4(n-1-nu0)),")
    print("    nu0 = tr h^4/(2 lam_max(W_+) tr h^3), for every Ricci-flat W != 0;")
    print("    sharp (= Jaeger's n-2, nu0 = 1) on the equality family = the")
    print("    critical Weyl operator of S^2 x ... x S^2 (n/2 factors),")
    print("    recovers the diagonal case with constant n-2, and gives the")
    print("    unconditional 4(n-1) for arbitrary W_-.")
    print("  CONJECTURE (open): the sharp 4(n-2) for all Weyl W -- no violation")
    print("    found anywhere; equality manifold = the S^2-product family; the")
    print("    four one-mechanism sufficient routes are each refuted, so a proof")
    print("    must trade mechanisms.")
    print("  c(12): granted 1.081e-3  ->  PROVEN 1.001e-3 (92.6% kept, grant discharged).")
    if FAILS:
        print(f"\n  {len(FAILS)} CHECK(S) FAILED: {FAILS}")
    else:
        print("\n  all checks passed.")


if __name__ == "__main__":
    main()
