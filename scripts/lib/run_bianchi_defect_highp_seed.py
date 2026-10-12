"""
Follow-up to plan.md sub-step C4, acting on findings/INDEX.md's "The Bianchi-defect
set A_n" section (Results 4-6). The last standing form of the proposed
dichotomy between zero Bianchi defect and coordinate-diagonalizability is:

    sup{ P(W) : Q(W) = lambda*W, Alt(W_-) = 0, W NOT coordinate-diagonalizable }

Is this bounded strictly below theta_0(n) = sqrt(2(n-1)(n-2))/n (and below
sqrt(3/2))? Every zero-defect non-diagonal critical point found so far sits
well below both: the symmetric Lie-group/isotropy-irreducible family tops
out at P<=0.8367, and an unrelated symmetry-free numerical search found a
thicket of points at P~0.68-0.76. But EVERY prior search seeded from random
starts, so it only ever sampled the low-P thicket by construction --
unconstrained minimization of an idempotency-residual + defect-penalty
objective from a random point has no reason to land anywhere near the top
of the P-landscape. This script seeds instead from the top: perturbations
of the two named high-P competitors (balanced sphere product, Fox's
S^4(alpha)), perturbations of the best known zero-defect symmetric points
(bi-invariant metrics on SU(3) and SO(5)), and -- the technique nobody has
tried -- constrained ascent that directly maximizes P against a Bianchi-
defect penalty, so the search is biased toward high P throughout rather
than only checked after the fact.

Engineering enabler (why n=12 is tractable here at all)
---------------------------------------------------------
run_bianchi_defect.py's existing joint solver (refine()/joint_obj()) uses
scipy's default finite-difference gradient: D+1 function evaluations per
gradient step. Fine at n=6 (D=84), already documented there as ~90s/restart
at n=8 (D=300, see hunt_counterexample_n8's docstring) -- and firmly
infeasible at n=12 (D=1638, and each single evaluation already costs a
1638x4356 dense matmul per run_unconstrained_search_n12.py's own benchmark
notes). This script instead derives an ANALYTIC gradient of
delta(W)^2 = ||Alt(W_-)||^2 via the Loewner/divided-difference formula for
the matrix function g(w)=max(-w,0) applied to W's own spectrum: cost O(N^3)
(N=66 at n=12), independent of D. Combined with the existing analytic
gradient of P (already used by run_unconstrained_search.py/_n12.py), this
makes one gradient step of the combined "ascend P, penalize defect"
objective as cheap as one step of the existing pure-P ascent -- turning an
otherwise ~50-150-minutes-per-seed problem into a sub-minute one. This is
validated against finite differences below (validate_analytic_grad) BEFORE
being trusted; nothing here revisits or second-guesses run_bianchi_defect.py's
existing finite-difference machinery, which remains the trusted item-4 hunt
at n=6/n=8 and is reused directly (not reimplemented) for the anchor checks.

Reuses directly (does not reimplement): weyl.py (structure constants,
Bianchi-nullspace machinery), rsharp_basis_free.Q_full and
run_unconstrained_search_n12.Q_fast/build_Cflat (Hamilton's Q),
run_bianchi_defect.py's build_alt_indices/alt_mop/spectral_split/
bianchi_defect/validate_alt (the validated Alt operator -- re-run here
against both anchor facts before trusting anything further, per the task),
run_unconstrained_search.py's build_weyl_basis/search_diagonalization/
lambda2_action_matrix, run_sphere.sphere_product_mop,
run_cp2_ricci_flat.cp2_block_st_tensor (Fox's S^4(alpha), parameterized by n
already -- no padding helper needed for it), and
curvature_operator.so_n_basis_matrices/Lambda2. The only genuinely new
pieces: the analytic delta^2 gradient, a bi-invariant-metric Weyl-tensor
builder (same recipe as every other constructed-tensor script here -- build
Mop, call weyl_from_mop) instantiated for SU(3) (n=8, standard Gell-Mann
structure constants) and SO(5) (n=10, reusing weyl.py's OWN so(5) structure
constants -- so(5) has dimension C(5,2)=10, exactly what's needed, no new
constants required), a zero-padding helper (validated to preserve P,
criticality and zero defect exactly, matching FINDINGS Result 3's claim), a
combined penalty-ascent search, and a cheap dim(Stab(W)) estimator
(finite-difference so(n)-action + nullspace rank, validated against the
sphere product's known dim=6 stabilizer at n=6).

Usage
-----
    python3 run_bianchi_defect_highp_seed.py validate     # ~10s: analytic-grad + anchor checks
    python3 run_bianchi_defect_highp_seed.py bench12       # ~1min: single n=12 restart, timed
    python3 run_bianchi_defect_highp_seed.py sweep6         # n=6 seeded sweep
    python3 run_bianchi_defect_highp_seed.py sweep8         # n=8 seeded sweep
    python3 run_bianchi_defect_highp_seed.py sweep12        # n=12 seeded sweep (budget-checked)
    python3 run_bianchi_defect_highp_seed.py all             # everything above, in order
"""
import sys
import time
import numpy as np
from scipy.linalg import expm

from curvature_operator import Lambda2, so_n_basis_matrices
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, norm, frob, P_value
from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from run_sphere import sphere_product_mop
from run_cp2_ricci_flat import cp2_block_st_tensor
from run_bianchi_defect import build_alt_indices, alt_mop, spectral_split, bianchi_defect, validate_alt
from run_unconstrained_search import build_weyl_basis, search_diagonalization, lambda2_action_matrix
from run_unconstrained_search_n12 import Q_fast, build_Cflat, validate_fast_vs_full

SQRT_3_2 = np.sqrt(1.5)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


# =====================================================================
# NEW PIECE 1: analytic gradient of delta(W)^2 w.r.t. the ambient N x N
# operator, via the Loewner divided-difference formula for the matrix
# function g(w) = max(-w, 0) (whose spectral calculus IS spectral_split).
# Validated against central finite differences before use anywhere else.
# =====================================================================
def delta2_and_grad(Wmat, alt_idx):
    """Returns (delta(Wmat)^2, d(delta^2)/dWmat) with Wmat symmetric N x N.
    Standard Frechet-derivative-of-a-matrix-function formula: for
    g(W)=sum g(w_i) v_i v_i^T, (Dg(W)[H])_{eigenbasis} = D[i,j]*H[i,j] with
    D[i,j]=(g(w_i)-g(w_j))/(w_i-w_j) (or g'(w_i) at ties) -- this
    divided-difference superoperator is self-adjoint, which lets the
    gradient of ||Alt(g(W))||^2 be written in closed form without ever
    forming the full D x D Jacobian."""
    w, V = np.linalg.eigh(Wmat)
    gvals = np.where(w < 0, -w, 0.0)
    Wminus = (V * gvals) @ V.T
    AltWminus = alt_mop(Wminus, alt_idx)
    delta2 = frob(AltWminus, AltWminus)

    Wi = w[:, None]; Wj = w[None, :]
    Gi = gvals[:, None]; Gj = gvals[None, :]
    diff = Wi - Wj
    safe = np.where(diff == 0, 1.0, diff)
    Dmat = np.where(np.abs(diff) > 1e-9, (Gi - Gj) / safe, 0.0)
    tie = np.abs(diff) <= 1e-9
    gprime = np.where(w < 0, -1.0, 0.0)  # g'(w)=-1 for w<0, 0 for w>0 (kink at 0)
    Dmat = np.where(tie, gprime[:, None] * np.ones_like(Dmat), Dmat)

    M = V.T @ AltWminus @ V
    Grad_Wmat = 2.0 * (V @ (Dmat * M) @ V.T)
    return delta2, Grad_Wmat


def validate_analytic_grad(n=6, ntrials=6, seed=123):
    print("  validating analytic delta^2 gradient against central finite differences:")
    from run_vertex_bound import random_weyl_basis
    from weyl import vec_to_mat
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    weyl_basis, triu_idx, N = random_weyl_basis(n)
    D = weyl_basis.shape[1]
    rng = np.random.default_rng(seed)
    worst = 0.0
    for _ in range(ntrials):
        x = rng.normal(size=D); x /= np.linalg.norm(x)
        Wmat = vec_to_mat(weyl_basis @ x, triu_idx, N)
        Wmat = 0.5 * (Wmat + Wmat.T); Wmat = Wmat / norm(Wmat)
        d2, Grad = delta2_and_grad(Wmat, alt_idx)
        dx = rng.normal(size=D)
        H = vec_to_mat(weyl_basis @ dx, triu_idx, N)
        H = 0.5 * (H + H.T); H = H / norm(H)
        h = 1e-6
        dp2, _ = delta2_and_grad(Wmat + h * H, alt_idx)
        dm2, _ = delta2_and_grad(Wmat - h * H, alt_idx)
        fd = (dp2 - dm2) / (2 * h)
        analytic = frob(Grad, H)
        rel = abs(fd - analytic) / (abs(fd) + abs(analytic) + 1e-300)
        worst = max(worst, rel)
    print(f"    n={n}: worst relative error over {ntrials} trials = {worst:.2e}  "
          f"{'PASS' if worst < 1e-4 else 'FAIL -- do not trust n=12 results'}")
    return worst < 1e-4


# =====================================================================
# NEW PIECE 2: bi-invariant-metric Weyl tensor builder, for any compact
# Lie algebra given as totally-antisymmetric structure constants in an
# orthonormal basis: R(X,Y,Z,W) = (1/4)<[X,Y],[Z,W]>. Same recipe as
# every other constructed-tensor script here (build Mop, call
# weyl_from_mop). SU(3) uses the standard Gell-Mann constants; SO(5)
# reuses weyl.py's OWN so(5) structure constants (dim so(5) = C(5,2) = 10).
# =====================================================================
def biinvariant_mop(fabc):
    m = fabc.shape[0]
    L2 = Lambda2(m)
    N = L2.N
    brackets = np.array([fabc[i, j, :] for (i, j) in L2.pairs])  # N x m
    Mop = 0.25 * (brackets @ brackets.T)
    return L2, Mop


def su3_fabc():
    """Standard Gell-Mann structure constants for su(3), 0-indexed 0..7,
    orthonormal basis (the well-known textbook values, e.g. Georgi's 'Lie
    Algebras in Particle Physics')."""
    f = np.zeros((8, 8, 8))

    def set_f(a, b, c, val):
        a, b, c = a - 1, b - 1, c - 1
        for (i, j, k), sign in [((a, b, c), 1), ((b, c, a), 1), ((c, a, b), 1),
                                 ((b, a, c), -1), ((a, c, b), -1), ((c, b, a), -1)]:
            f[i, j, k] = sign * val
    set_f(1, 2, 3, 1.0); set_f(1, 4, 7, 0.5); set_f(1, 5, 6, -0.5)
    set_f(2, 4, 6, 0.5); set_f(2, 5, 7, 0.5); set_f(3, 4, 5, 0.5)
    set_f(3, 6, 7, -0.5); set_f(4, 5, 8, np.sqrt(3) / 2); set_f(6, 7, 8, np.sqrt(3) / 2)
    return f


def jacobi_residual(f):
    m = f.shape[0]
    rng = np.random.default_rng(0)
    worst = 0.0
    for _ in range(30):
        i, j, k = rng.integers(0, m, size=3)
        lhs = (np.einsum('l,l...->...', f[j, k, :], f[i, :, :])
               + np.einsum('l,l...->...', f[k, i, :], f[j, :, :])
               + np.einsum('l,l...->...', f[i, j, :], f[k, :, :]))
        worst = max(worst, np.max(np.abs(lhs)))
    return worst


def weyl_tensor4_callable(L2_small, Wmat_small):
    """Wrap an already-computed Weyl Mop on n0 dims as a T(i,j,k,l)
    callable that is zero whenever any index is >= n0 -- for zero-padding
    into a larger ambient n via mop_from_4tensor/weyl_from_mop."""
    idx = L2_small.idx
    n0 = L2_small.n

    def T(i, j, k, l):
        if i >= n0 or j >= n0 or k >= n0 or l >= n0:
            return 0.0
        if i == j or k == l:
            return 0.0
        s1, (a, b) = (1.0, (i, j)) if i < j else (-1.0, (j, i))
        s2, (c, d) = (1.0, (k, l)) if k < l else (-1.0, (l, k))
        return s1 * s2 * Wmat_small[idx[(a, b)], idx[(c, d)]]
    return T


def pad_weyl_to_n(L2_small, Wn_small, n_target):
    L2_big = Lambda2(n_target)
    T = weyl_tensor4_callable(L2_small, Wn_small)
    Mop_pad = mop_from_4tensor(L2_big, T)
    Weyl_pad, Ric_pad, S_pad = weyl_from_mop(L2_big, Mop_pad)
    return L2_big, Weyl_pad / norm(Weyl_pad)


def build_su3_n8():
    f = su3_fabc()
    assert jacobi_residual(f) < 1e-12, "su(3) structure constants fail Jacobi -- do not trust"
    L2, Mop = biinvariant_mop(f)
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    return L2, Weyl / norm(Weyl)


def build_so5_n10():
    idx5, pos5, N5, c5 = build_structure_constants(5)  # so(5) structure consts, dim 10
    L2, Mop = biinvariant_mop(c5)
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    return L2, Weyl / norm(Weyl)


def validate_symmetric_family():
    print("\n  validating SU(3)/SO(5) bi-invariant constructions against findings/INDEX.md Result 3:")
    L2_8, Wn8 = build_su3_n8()
    idx8, pos8, N8, c8 = build_structure_constants(8)
    alt_idx8 = build_alt_indices(L2_8)
    Q8 = Q_full(Wn8, c8); lam8 = frob(Wn8, Q8)
    resid8 = norm(Q8 - lam8 * Wn8) / norm(Q8)
    d8 = bianchi_defect(Wn8, alt_idx8)
    print(f"    SU(3) n=8: P={lam8:.6f} (FINDINGS: 0.8367)  idemp_resid={resid8:.1e}  delta={d8:.1e}")

    L2_10, Wn10 = build_so5_n10()
    idx10, pos10, N10, c10 = build_structure_constants(10)
    alt_idx10 = build_alt_indices(L2_10)
    Q10 = Q_full(Wn10, c10); lam10 = frob(Wn10, Q10)
    resid10 = norm(Q10 - lam10 * Wn10) / norm(Q10)
    d10 = bianchi_defect(Wn10, alt_idx10)
    print(f"    SO(5) n=10: P={lam10:.6f} (FINDINGS: 0.7171)  idemp_resid={resid10:.1e}  delta={d10:.1e}")

    L2_12, Wpad = pad_weyl_to_n(L2_8, Wn8, 12)
    idx12, pos12, N12, c12 = build_structure_constants(12)
    Cflat12 = build_Cflat(c12)
    Qp = Q_fast(Wpad, Cflat12, N12); lamp = frob(Wpad, Qp)
    residp = norm(Qp - lamp * Wpad) / norm(Qp)
    alt_idx12 = build_alt_indices(L2_12)
    dp = bianchi_defect(Wpad, alt_idx12)
    print(f"    SU(3) padded n=8->12: P={lamp:.6f} (expect same 0.836660)  "
          f"idemp_resid={residp:.1e}  delta={dp:.1e}")
    ok = (abs(lam8 - 0.8367) < 2e-4 and abs(lam10 - 0.7171) < 2e-4
          and resid8 < 1e-8 and resid10 < 1e-8 and d8 < 1e-8 and d10 < 1e-8
          and abs(lamp - lam8) < 1e-8 and residp < 1e-8 and dp < 1e-8)
    print(f"    {'PASS' if ok else 'FAIL -- symmetric-family seeds untrustworthy'}")
    return ok


# =====================================================================
# NEW PIECE 3: cheap dim(Stab(W)) estimator -- finite-difference so(n)
# infinitesimal action + nullspace rank of X -> [A_X, W]. Validated
# against the sphere product's known dim=6 (so(3)+so(3)) stabilizer.
# =====================================================================
def dim_stab(Wmat, n, idx, N, h=1e-5, tol_rel=1e-6):
    Es, _, _ = so_n_basis_matrices(n)
    cols = []
    for X in Es:
        Lp = lambda2_action_matrix(expm(h * X), idx, N)
        Lm = lambda2_action_matrix(expm(-h * X), idx, N)
        AX = (Lp - Lm) / (2 * h)
        comm = AX @ Wmat - Wmat @ AX
        cols.append(comm.reshape(-1))
    s = np.linalg.svd(np.array(cols), compute_uv=False)
    tol = tol_rel * (s[0] if len(s) and s[0] > 0 else 1.0)
    return int(len(Es) - np.sum(s > tol))


# =====================================================================
# NEW PIECE 4: combined penalty ascent -- maximize P(x) - kappa*delta2(x)
# on the Weyl-space unit sphere via Riemannian gradient ascent, BOTH
# gradients analytic (P via the existing 3*Q(W) formula, delta2 via piece
# 1 above), kappa ramped across a schedule so the search is P-dominated
# early (reaching/staying near a high-P region) and defect-dominated late
# (snapping onto Alt(W_-)=0 exactly). Mirrors run_unconstrained_search[_n12]
# .py's gradient_ascent structure, generalized to two analytic gradients.
# =====================================================================
def combined_step(x, Eflat, N, alt_idx, kappa, Qfun):
    amb = x @ Eflat
    Wmat = amb.reshape(N, N); Wmat = 0.5 * (Wmat + Wmat.T)
    Qmat = Qfun(Wmat)
    P = float(np.sum(Wmat * Qmat))
    delta2, Grad_d2 = delta2_and_grad(Wmat, alt_idx)
    Phi = P - kappa * delta2
    Grad_W = 3.0 * Qmat - kappa * Grad_d2
    grad_x = Eflat @ Grad_W.reshape(-1)
    return Phi, grad_x, Wmat, Qmat, P, delta2


def combined_ascent(x0, Eflat, N, alt_idx, Qfun, schedule, tol=1e-12):
    x = x0 / np.linalg.norm(x0)
    for kappa, iters in schedule:
        step = 0.2
        Phi, grad_x, Wmat, Qmat, P, delta2 = combined_step(x, Eflat, N, alt_idx, kappa, Qfun)
        for it in range(iters):
            g_tan = grad_x - np.dot(grad_x, x) * x
            if np.linalg.norm(g_tan) < tol:
                break
            accepted = False
            for _ in range(50):
                x_new = x + step * g_tan
                x_new = x_new / np.linalg.norm(x_new)
                Phi_new, grad_new, Wnew, Qnew, Pnew, d2new = combined_step(
                    x_new, Eflat, N, alt_idx, kappa, Qfun)
                if Phi_new > Phi - 1e-13:
                    accepted = True
                    break
                step *= 0.5
            if not accepted:
                break
            x, Phi, grad_x, Wmat, Qmat, P, delta2 = x_new, Phi_new, grad_new, Wnew, Qnew, Pnew, d2new
            step = min(step * 1.3, 1.0)
    resid = norm(Qmat - P * Wmat) / (norm(Qmat) + 1e-300)
    delta = np.sqrt(max(delta2, 0.0))
    return x, Wmat, P, resid, delta


DEFAULT_SCHEDULE = ((0.0, 150), (2.0, 150), (20.0, 200), (200.0, 250), (2000.0, 300), (20000.0, 350))

# Experimentally selected (see script's exploration log / final report): a
# kappa=0 first stage lets pure-P ascent fully converge onto a diagonal
# critical point BEFORE the defect penalty ever activates -- and since
# coordinate-diagonal tensors already have delta=0 exactly (FINDINGS Result
# 1a), the penalty then has nothing left to push against, so every seed
# (even large perturbations, even unbiased random starts) collapses back
# onto the same 1-2 diagonal points every time. Starting kappa large from
# iteration 1 instead (defect-dominant throughout, but still SEEDED from
# perturbations of high-P points rather than random ones, unlike the
# existing item-4 hunt) is what actually surfaces non-diagonal zero-defect
# points -- reproducibly rediscovers the Wu-manifold cross-match
# (P=0.828079, dim Stab=3) from unbiased random starts at n=6.
HIGH_P_SEEDED_SCHEDULE = ((50.0, 250), (500.0, 250), (5000.0, 300), (50000.0, 350))


# =====================================================================
# Seed construction
# =====================================================================
def project_to_x(Wn, Eflat, N):
    x = Eflat @ Wn.reshape(-1)
    x = x / np.linalg.norm(x)
    recon_err = np.linalg.norm((x @ Eflat).reshape(N, N) - Wn) / np.linalg.norm(Wn)
    return x, recon_err


def make_seeds(n, Eflat, N, rng, include_su3=False, include_so5_pad=False,
                scales=(0.05, 0.15, 0.35, 0.7), ndir=2):
    """Returns list of (label, x0)."""
    seeds = []
    L2 = Lambda2(n)

    p = n // 2
    Mop = sphere_product_mop(L2, p)
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    Wsphere = Weyl / norm(Weyl)
    x_sphere, e1 = project_to_x(Wsphere, Eflat, N)
    assert e1 < 1e-6, f"sphere product does not lie in Weyl basis at n={n} (recon err {e1:.2e})"

    T = cp2_block_st_tensor(n, 1.0, -1.0)
    Wfox, _, _ = weyl_from_mop(L2, mop_from_4tensor(L2, T))
    Wfox = Wfox / norm(Wfox)
    x_fox, e2 = project_to_x(Wfox, Eflat, N)
    assert e2 < 1e-6, f"S^4(alpha) does not lie in Weyl basis at n={n} (recon err {e2:.2e})"

    for s in scales:
        for k in range(ndir):
            d = rng.normal(size=len(x_sphere))
            seeds.append((f"sphere(perturbed,s={s})", x_sphere + s * d))
            d2 = rng.normal(size=len(x_fox))
            seeds.append((f"S4alpha(perturbed,s={s})", x_fox + s * d2))

    if include_su3:
        if n == 8:
            _, Wsu3 = build_su3_n8()
        else:
            L2_8, Wsu3_8 = build_su3_n8()
            _, Wsu3 = pad_weyl_to_n(L2_8, Wsu3_8, n)
        x_su3, e3 = project_to_x(Wsu3, Eflat, N)
        assert e3 < 1e-6, f"SU(3) seed does not lie in Weyl basis at n={n} (recon err {e3:.2e})"
        for s in scales:
            d = rng.normal(size=len(x_su3))
            seeds.append((f"SU3(perturbed,s={s})", x_su3 + s * d))

    if include_so5_pad:
        L2_10, Wso5_10 = build_so5_n10()
        _, Wso5 = pad_weyl_to_n(L2_10, Wso5_10, n)
        x_so5, e4 = project_to_x(Wso5, Eflat, N)
        assert e4 < 1e-6, f"SO(5) seed does not lie in Weyl basis at n={n} (recon err {e4:.2e})"
        for s in scales:
            d = rng.normal(size=len(x_so5))
            seeds.append((f"SO5pad(perturbed,s={s})", x_so5 + s * d))

    return seeds


def run_sweep(n, n_random=30, seed=0, schedule=DEFAULT_SCHEDULE,
              include_su3=None, include_so5_pad=None, diag_restarts=15,
              scales=(0.05, 0.15, 0.35, 0.7), ndir=2):
    if include_su3 is None:
        include_su3 = (n == 8)
    if include_so5_pad is None:
        include_so5_pad = (n == 12)

    print("\n" + "=" * 78)
    print(f"SEEDED SWEEP at n={n}  (theta_0({n})={theta0(n):.6f}, sqrt(3/2)={SQRT_3_2:.6f})")
    print("=" * 78)

    idx, pos, N, c = build_structure_constants(n)
    alt_idx = build_alt_indices(Lambda2(n))
    t0 = time.time()
    Eflat, D = build_weyl_basis(n, idx, pos, N, c)
    print(f"  basis build: {time.time()-t0:.1f}s, D={D}")

    if n >= 12:
        Cflat = build_Cflat(c)
        Qfun = lambda W: Q_fast(W, Cflat, N)
    else:
        Qfun = lambda W: Q_full(W, c)

    rng = np.random.default_rng(seed)
    seeds = make_seeds(n, Eflat, N, rng, include_su3=include_su3, include_so5_pad=include_so5_pad,
                        scales=scales, ndir=ndir)
    rrng = np.random.default_rng(seed + 1)
    for i in range(n_random):
        x0 = rrng.normal(size=D)
        seeds.append((f"random#{i}", x0))

    print(f"  {len(seeds)} seeds ({len(seeds)-n_random} directed high-P perturbations + "
          f"{n_random} unbiased random starts), schedule={schedule}")

    results = []
    t0 = time.time()
    for i, (label, x0) in enumerate(seeds):
        x, Wmat, P, resid, delta = combined_ascent(x0, Eflat, N, alt_idx, Qfun, schedule)
        results.append(dict(label=label, x=x, Wmat=Wmat, P=P, resid=resid, delta=delta))
    dt = time.time() - t0
    print(f"  {len(seeds)} combined ascents in {dt:.1f}s ({dt/len(seeds):.2f}s/seed)")

    # keep only genuine zero-defect critical points
    good = [r for r in results if r["resid"] < 1e-4 and r["delta"] < 1e-4]
    print(f"  {len(good)}/{len(results)} runs converged to a joint (critical, delta=0) point")

    # cluster by (lambda) to dedupe, tolerance 1e-3
    good_sorted = sorted(good, key=lambda r: -r["P"])
    clusters = []
    for r in good_sorted:
        placed = False
        for cl in clusters:
            if abs(cl["P"] - r["P"]) < 1e-3:
                cl["members"].append(r); placed = True; break
        if not placed:
            clusters.append({"P": r["P"], "members": [r]})

    table = []
    print(f"\n  {'label':28s} {'P':>10s} {'idemp_resid':>12s} {'delta':>10s} "
          f"{'diag_resid':>11s} {'dimStab':>8s} {'>sqrt(3/2)':>11s} {'>theta0':>9s}")
    for cl in clusters:
        rep = cl["members"][0]
        diag_resid, _ = search_diagonalization(rep["Wmat"], idx, N, n, n_restarts=diag_restarts,
                                                 seed=len(table) + 1000)
        ds = dim_stab(rep["Wmat"], n, idx, N)
        row = dict(n=n, label=rep["label"], count=len(cl["members"]), P=rep["P"],
                   resid=rep["resid"], delta=rep["delta"], diag_resid=diag_resid, dim_stab=ds,
                   above_sqrt32=rep["P"] > SQRT_3_2, above_theta0=rep["P"] > theta0(n))
        table.append(row)
        # Exceeding the thresholds is unremarkable for a DIAGONAL point (the
        # balanced sphere product is exactly theta_0(n) by construction, and
        # unbalanced splits legitimately exceed sqrt(3/2) at n=12) -- it is
        # only evidence against the dichotomy when the point is NON-diagonal.
        is_counterexample = (row["above_sqrt32"] or row["above_theta0"]) and diag_resid > 1e-3
        tag = "  <<< ABOVE THRESHOLD, NON-DIAGONAL -- DICHOTOMY COUNTEREXAMPLE >>>" if is_counterexample else ""
        diagstr = "DIAG" if diag_resid < 1e-3 else "non-diag"
        print(f"  {rep['label']:28s} {rep['P']:10.6f} {rep['resid']:12.2e} {rep['delta']:10.2e} "
              f"{diag_resid:11.4f} {ds:8d} {'YES' if row['above_sqrt32'] else 'no':>11s} "
              f"{'YES' if row['above_theta0'] else 'no':>9s}  [{diagstr}, n_seeds={len(cl['members'])}]"
              f"{tag}")

    non_diag = [r for r in table if r["diag_resid"] > 1e-3]
    best_nondiag = max(non_diag, key=lambda r: r["P"]) if non_diag else None
    if best_nondiag:
        print(f"\n  BEST zero-defect NON-diagonal critical point at n={n}: "
              f"P={best_nondiag['P']:.6f}  (theta_0({n})={theta0(n):.6f}, sqrt(3/2)={SQRT_3_2:.6f})")
    print(f"  Coverage statement: {len(seeds)} seeded starts ({len(seeds)-n_random} directed "
          f"high-P + {n_random} random) at n={n} found nothing non-diagonal above "
          f"{best_nondiag['P'] if best_nondiag else 0.0:.4f} -- a bounded empirical claim, not a proof.")
    return table


def main():
    args = sys.argv[1:]
    mode = args[0] if args else "all"

    if mode in ("validate", "all"):
        print("=" * 78)
        print("STEP 0: validate every imported/new piece before trusting anything")
        print("=" * 78)
        validate_alt(ns=(6, 8))  # reuse existing anchor-fact validation directly
        ok1 = validate_analytic_grad(n=6)
        ok2 = validate_symmetric_family()
        assert ok1 and ok2, "validation failed -- stop"
        if mode == "validate":
            return

    if mode in ("bench12", "all"):
        print("\n" + "=" * 78)
        print("BENCHMARK: single n=12 combined-ascent restart, timed, before scaling")
        print("=" * 78)
        idx, pos, N, c = build_structure_constants(12)
        alt_idx = build_alt_indices(Lambda2(12))
        t0 = time.time()
        Eflat, D = build_weyl_basis(12, idx, pos, N, c)
        print(f"  basis build: {time.time()-t0:.1f}s, D={D}, N={N}")
        Cflat = build_Cflat(c)
        Qfun = lambda W: Q_fast(W, Cflat, N)
        rng = np.random.default_rng(0)
        x0 = rng.normal(size=D)
        t0 = time.time()
        x, Wmat, P, resid, delta = combined_ascent(x0, Eflat, N, alt_idx, Qfun, DEFAULT_SCHEDULE)
        dt = time.time() - t0
        print(f"  single restart: {dt:.1f}s  P={P:.6f}  resid={resid:.2e}  delta={delta:.2e}")
        print(f"  ESTIMATE for k restarts: {dt:.1f}s * k  "
              f"(e.g. 20 restarts ~ {20*dt:.0f}s = {20*dt/60:.1f} min, "
              f"40 restarts ~ {40*dt/60:.1f} min)")
        if mode == "bench12":
            return

    if mode in ("sweep6", "all"):
        run_sweep(6, n_random=60, seed=11, schedule=HIGH_P_SEEDED_SCHEDULE,
                   scales=(0.3, 0.6, 1.0, 1.5, 2.0), ndir=3)
    if mode in ("sweep8", "all"):
        run_sweep(8, n_random=40, seed=12, schedule=HIGH_P_SEEDED_SCHEDULE,
                   scales=(0.3, 0.6, 1.0, 1.5, 2.0), ndir=2)
    if mode in ("sweep12", "all"):
        # Trimmed vs. n=6/8 defaults: bench12 measured ~11.3s/restart at n=12, so
        # keep total seed count in the ~20-25 range to stay safely under 5 minutes
        # (16 directed high-P perturbations [3 scales x 1 dir x (sphere,S4alpha)
        # + 3 SO(5)-padded x ~3 dir] + 8 random =~ 24 seeds * ~11.3s =~ 4.5 min).
        run_sweep(12, n_random=8, seed=13, schedule=HIGH_P_SEEDED_SCHEDULE,
                   scales=(0.3, 0.7, 1.2), ndir=1)


if __name__ == "__main__":
    main()
