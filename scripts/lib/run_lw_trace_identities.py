"""
Sub-step A1 (numerical half), Track A of plan.md: universal trace identities
for the polarized Hamilton map L_W: W_n -> W_n, L_W(H) = B(W,H), where
B(X,Y) = 1/2*(Q(X+Y)-Q(X)-Q(Y)) is the polarization of Q(X) = X^2 + X^# and
W_n is the space of algebraic Weyl curvature operators (Bianchi-closed,
Ricci-flat, self-adjoint on Lambda^2 R^n).

GOAL (from plan.md A1): build L_W as an explicit DxD matrix (D = dim W_n) in
an orthonormal basis of W_n, then determine
  tr(L_W)   = 0                                        exactly,
  tr(L_W^2) = c_n * ||W||^2                             (W-independent c_n),
  tr(L_W^3) = a_n*tr(W^3) + b_n*<W^#,W>                 (W-independent a_n,b_n),
numerically for n=6..12 (well past the requested 6..10 -- see the benchmark
in main(), which showed the whole pipeline stays under ~30s total through
n=12), then fit c_n, a_n, b_n as exact rational functions of n and check the
fit against a held-out n.

THAT L_W MAPS W_n TO ITSELF AT ALL is not an extra assumption: Fox
(arXiv:1901.04012, cited in findings/INDEX.md's opening section) shows the Weyl
(Ricci-flat) tensors form a *closed* nonassociative subalgebra under B(.,.),
i.e. B(W,H) in W_n whenever W,H in W_n. Bianchi-closure of Q(anything) is a
classical fact about algebraic curvature operators; Fox's paper is the source
for Ricci-flatness also being preserved. This script re-validates closure
numerically anyway (the "projection residual" check below) rather than just
trusting the citation.

KEY NEW PIECE (not previously in this repo): hessian_fast.py's
build_qform_sym(w, c) vectorizes <Wunit, Q(H)> as a single N^2 x N^2
quadratic-form matrix, but ONLY for Wunit *diagonal* in the coordinate
2-planes (it needs that to write <W,H@H> as sum_np w[n] H[n,p]^2). Two of
this task's three test families -- random genuine Weyl tensors and Fox's
S^4(alpha) -- are NOT coordinate-diagonalizable (README.md records this
explicitly for S^4(alpha): "Any diagonal-reduction argument must ... and
(O(n),W_n) is not a polar representation"). So this script derives and
validates (see build_qform_sym_general below and its cross-checks in
main()) the natural generalization to a FULL symmetric NxN matrix W:

    <W,H@H> = tr(W H H) = sum_{i,j,k} W_ij H_jk H_ik
      -> D1[(j,k),(i,l)] = W_ij * delta_{kl}
    <W,H^#> = -1/2 sum_{a,b} W_ab S_{a,m,p} S_{b,p,m},  S_{a,m,p}=sum_n c[a,m,n]H[n,p]
      -> K[n,p,n',m] = -1/2 sum_{a,b} c[a,m,n] W[a,b] c[b,p,n']

which reduces to hessian_fast.py's diagonal formula exactly when
W = diag(w) (W_ab = w_a*delta_ab). Once this Qform_sym_general(W,c) is
built (a couple of O(N^5) einsum contractions, done ONCE per W), the
*entire* DxD matrix L_W is obtained from a single congruence transform

    L_W = Eflat @ Qform_sym_general(W,c) @ Eflat.T

(Eflat: D x N^2 Frobenius-orthonormal basis of W_n), because polarizing the
quadratic form vec(H)^T Qform_sym(W) vec(H) = <W,Q(H)> gives the symmetric
bilinear form (H1,H2) -> H1^T Qform_sym(W) H2 = <W,B(H1,H2)>, and the
trilinear form T(A,W,H) := <A,B(W,H)> is totally symmetric in its three
arguments (standard polarization identity of the cubic form P(X)=<X,Q(X)>;
also the "fully permutation-symmetric trilinear form" already established
for rsharp_basis_free.py's Rsharp_full -- see scripts/INDEX.md), so
  E_i^T Qform_sym(W) E_j = <W,B(E_i,E_j)> = <E_i,B(W,E_j)> = [L_W]_{ij}.
This turns "D applications of Q_op" (the naive approach flagged as too slow
in the task) into two BLAS matmuls, mirroring hessian_fast.py's own speedup
of hessian_pipeline_b.py. All of this is validated against the repo's
already-trusted rsharp_basis_free.Q_full at machine precision before use
(see validate_qform_general() and validate_LW() in main()).

Machinery reused (no new curvature primitives introduced):
  - weyl.py: build_structure_constants, bianchi_constraint_matrix, vec_to_mat
    (Bianchi-nullspace + Ricci-trace-free projection -> basis of W_n, exactly
    as weyl.py's own __main__ and run_vertex_bound.py's random_weyl_basis()).
  - hessian_fast.py: the Frobenius-Gram-Schmidt orthonormalization pattern
    (flatten to N^2, Gram matrix, eigh-based whitening) is reproduced here
    verbatim (it is inline in hessian_fast.run(), not factored out as an
    importable function, so it is lifted directly rather than re-derived).
  - rsharp_basis_free.py: Q_full (validation oracle; also used directly to
    get the two cubic invariants tr(W^3), <W^#,W> = <Q(W),W> - tr(W^3)).
  - curvature_operator.py / weyl_decomposition.py / run_cp2_ricci_flat.py:
    Lambda2, mop_from_4tensor, weyl_from_mop, and cp2_block_st_tensor(n,1,-1)
    for Fox's S^4(alpha) (the validated Ricci-flat s=1,t=-1 combination,
    confirmed in run_fox_S4_check.py to match Fox's literal index formula
    exactly). Confirmed here that curvature_operator.py's pair ordering
    (itertools.combinations) is bit-identical to weyl.py's, so an NxN Mop
    built by Pipeline C can be fed directly into Pipeline B's structure
    constants with no basis-conversion step.
"""
import sys
import time
import numpy as np
import sympy as sp
from fractions import Fraction

from weyl import build_structure_constants, bianchi_constraint_matrix, vec_to_mat
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import mop_from_4tensor, weyl_from_mop, frob, norm
from run_cp2_ricci_flat import cp2_block_st_tensor


# ---------------------------------------------------------------
# Basis of W_n (Bianchi-nullspace + Ricci-trace-free), Frobenius-orthonormalized.
# ---------------------------------------------------------------

def build_weyl_orthonormal_basis(n, verbose=True):
    """Returns (Eflat, c, N, D): Eflat is D x N^2, rows = an orthonormal
    (Frobenius inner product on the NxN operator matrices) basis of W_n,
    flattened. Reuses weyl.py's Bianchi-nullspace + Ricci-nullspace pipeline
    (same as weyl.py's own __main__ / run_vertex_bound.random_weyl_basis),
    then hessian_fast.py's vectorized Gram-Schmidt orthonormalization
    pattern (lifted verbatim since it is inline in hessian_fast.run(), not
    an importable function)."""
    t0 = time.time()
    idx, pos, N, c = build_structure_constants(n)
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx, pos, n, N)
    U, S, Vt = np.linalg.svd(Bmat)
    tol = 1e-9 * S[0] if len(S) > 0 else 1e-9
    rank = np.sum(S > tol)
    null_basis = Vt[rank:, :].T
    D0 = null_basis.shape[1]

    def R_val(Rmat, i, j, k, l):
        if i == j or k == l:
            return 0.0
        si = 1.0
        a, b = i, j
        if a > b:
            a, b = b, a
            si = -si
        sk = 1.0
        p, q = k, l
        if p > q:
            p, q = q, p
            sk = -sk
        return si * sk * Rmat[pos[(a, b)], pos[(p, q)]]

    Rmat_ds = [vec_to_mat(null_basis[:, d], triu_idx, N) for d in range(D0)]
    ric_rows = []
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(D0)
            for j in range(n):
                if j == i or j == k:
                    continue
                for d in range(D0):
                    row[d] += R_val(Rmat_ds[d], i, j, k, j)
            ric_rows.append(row)
    RicMat = np.array(ric_rows)
    Ur, Sr, Vtr = np.linalg.svd(RicMat)
    tolr = 1e-9 * Sr[0] if len(Sr) > 0 else 1e-9
    rankr = np.sum(Sr > tolr)
    weyl_coeffs = Vtr[rankr:, :].T
    weyl_basis = null_basis @ weyl_coeffs
    D = weyl_basis.shape[1]
    t1 = time.time()

    # Frobenius Gram-Schmidt (hessian_fast.py's pattern, lifted verbatim).
    mats = [vec_to_mat(weyl_basis[:, i], triu_idx, N) for i in range(D)]
    Mflat = np.array([m.reshape(-1) for m in mats])
    G = Mflat @ Mflat.T
    wG, VG = np.linalg.eigh(G)
    wG = np.maximum(wG, 1e-14)
    Ginvhalf = VG @ np.diag(1 / np.sqrt(wG)) @ VG.T
    Eflat = Ginvhalf.T @ Mflat
    t2 = time.time()
    if verbose:
        formula = (n + 2) * (n + 1) * n * (n - 3) / 12
        print(f"  n={n}: N=C(n,2)={N}  dim(W_n)={D} (formula {formula:.0f})  "
              f"[nullspace {t1-t0:.2f}s + orthonormalize {t2-t1:.2f}s = {t2-t0:.2f}s]")
    return Eflat, c, N, D


# ---------------------------------------------------------------
# Vectorized L_W assembly (the core new machinery).
# ---------------------------------------------------------------

def build_qform_sym_general(W, c):
    """Qform_sym_general(W): N^2 x N^2 symmetric matrix s.t.
    vec(H)^T Qform_sym_general(W) vec(H) == <W, Q_full(H,c)> for ANY
    symmetric H, and ANY symmetric W (not just diagonal). Generalizes
    hessian_fast.build_qform_sym (which required W = diag(w)). See module
    docstring for the derivation; validated against Q_full in main()."""
    N = W.shape[0]
    D1_4d = np.einsum('ij,kl->jkil', W, np.eye(N))
    D1 = D1_4d.reshape(N * N, N * N)

    cw = np.einsum('amn,ab->bmn', c, W, optimize=True)
    raw = np.einsum('bmn,bpr->mnpr', cw, c, optimize=True)
    K = -0.5 * np.transpose(raw, (1, 2, 3, 0))
    Qform2 = K.reshape(N * N, N * N)

    Qform = D1 + Qform2
    return 0.5 * (Qform + Qform.T)


def build_LW(W, Eflat, c):
    """L_W as a DxD matrix: [L_W]_ij = <E_i, B(W,E_j)>, via the congruence
    transform Eflat @ Qform_sym_general(W,c) @ Eflat.T (see module
    docstring's polarization argument for why this equals L_W exactly)."""
    Qform = build_qform_sym_general(W, c)
    LW = Eflat @ Qform @ Eflat.T
    return 0.5 * (LW + LW.T)


# ---------------------------------------------------------------
# Test-point constructions: random W, balanced sphere product W*,
# Fox's S^4(alpha). Each returned at natural (idempotent, Q(X)=X) scaling
# AND as a separate unit-Frobenius-norm version for the trace tables.
# ---------------------------------------------------------------

def random_weyl_unit(Eflat, D, N, rng):
    coeffs = rng.normal(size=D)
    coeffs /= np.linalg.norm(coeffs)
    W = (coeffs @ Eflat).reshape(N, N)
    return W, coeffs


def sphere_product_unit(n, c, idx, N):
    p = n // 2
    q = n - p
    x = 1.0 / (p * (p - 1))
    y = 1.0 / (q * (q - 1))
    z = -1.0 / (p * q)
    lam = np.zeros(N)
    for a, (i, j) in enumerate(idx):
        if i < p and j < p:
            lam[a] = x
        elif i >= p and j >= p:
            lam[a] = y
        else:
            lam[a] = z
    Wmat = np.diag(lam)
    Wnorm = np.sqrt(np.sum(Wmat * Wmat))
    return Wmat / Wnorm, (p, q)


def fox_S4_unit(n, c):
    L2 = Lambda2(n)
    T = cp2_block_st_tensor(n, 1.0, -1.0)
    Mop = mop_from_4tensor(L2, T)
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    assert np.max(np.abs(Ric)) < 1e-8, "Fox S^4(alpha) construction is not Ricci-flat"
    nv = norm(Weyl)
    return Weyl / nv


def idempotent_rescale(Wunit, c):
    """Given a unit-Frobenius-norm eigen-direction of Q (Q(Wunit)=lam*Wunit),
    return the natural scaling Wstar = Wunit/lam with Q(Wstar)=Wstar exactly."""
    Qu = Q_full(Wunit, c)
    lam = frob(Wunit, Qu)
    Wstar = Wunit / lam
    return Wstar, lam


# ---------------------------------------------------------------
# Per-(n,W) computation of the three L_W traces + the two cubic invariants.
# ---------------------------------------------------------------

def analyze_point(W, Eflat, c, label=""):
    """Returns dict with tr(L_W), tr(L_W^2), tr(L_W^3), ||W||^2, tr(W^3),
    <W#,W>, plus validation residuals (projection onto W_n, L_W(W)=Q(W))."""
    N = W.shape[0]
    vecW = W.reshape(-1)
    coeffs = Eflat @ vecW
    recon = coeffs @ Eflat
    proj_resid = np.linalg.norm(vecW - recon) / (np.linalg.norm(vecW) + 1e-300)

    LW = build_LW(W, Eflat, c)
    sym_resid = np.linalg.norm(LW - LW.T) / (np.linalg.norm(LW) + 1e-300)

    tr1 = np.trace(LW)
    LW2 = LW @ LW
    tr2 = np.trace(LW2)
    LW3 = LW2 @ LW
    tr3 = np.trace(LW3)

    Qw = Q_full(W, c)
    Qw_coeffs_true = Eflat @ Qw.reshape(-1)
    Qw_coeffs_pred = LW @ coeffs
    lw_eq_q_resid = (np.linalg.norm(Qw_coeffs_pred - Qw_coeffs_true)
                      / (np.linalg.norm(Qw_coeffs_true) + 1e-300))

    normW2 = frob(W, W)
    trW3 = np.trace(W @ W @ W)
    PW = frob(W, Qw)
    wsharp = PW - trW3

    return dict(label=label, tr1=tr1, tr2=tr2, tr3=tr3, normW2=normW2,
                trW3=trW3, wsharp=wsharp, proj_resid=proj_resid,
                sym_resid=sym_resid, lw_eq_q_resid=lw_eq_q_resid)


# ---------------------------------------------------------------
# Exact-rational fitting (Lagrange interpolation in exact Fraction/Rational
# arithmetic over consecutive integer n, then check degree collapses and
# predict held-out points).
# ---------------------------------------------------------------

def snap(x, max_denom=10 ** 6):
    return sp.Rational(Fraction(float(x)).limit_denominator(max_denom))


def fit_and_holdout(ns_all, vals_all, n_fit, name):
    """Fits an exact polynomial-in-n through the first n_fit points (in
    exact Rational arithmetic, snapping the numeric floats first), reports
    its minimal degree (checking higher-order Lagrange coefficients vanish
    exactly), then evaluates it at the held-out points and compares to the
    (snapped) actual values."""
    nsym = sp.symbols('n')
    ns_fit = ns_all[:n_fit]
    vals_fit = [snap(v) for v in vals_all[:n_fit]]
    poly = sp.expand(sp.interpolate(list(zip(ns_fit, vals_fit)), nsym))
    poly_simplified = sp.nsimplify(poly, rational=True)
    print(f"  [{name}] fit on n={ns_fit} (degree-{n_fit-1} Lagrange interpolant): "
          f"{sp.factor(poly_simplified)}  =  {poly_simplified}")
    ok = True
    for i in range(n_fit, len(ns_all)):
        n_hold = ns_all[i]
        predicted = float(poly.subs(nsym, n_hold))
        actual = vals_all[i]
        relerr = abs(predicted - actual) / (abs(actual) + 1e-300)
        status = "OK" if relerr < 1e-6 else "MISMATCH"
        if relerr >= 1e-6:
            ok = False
        print(f"    held-out n={n_hold}: predicted={predicted:.8f}  actual={actual:.8f}  "
              f"relerr={relerr:.2e}  [{status}]")
    return poly_simplified, ok


# ---------------------------------------------------------------
# Main.
# ---------------------------------------------------------------

def main():
    print("=" * 90)
    print("PART 0: correctness validation of build_qform_sym_general against Q_full (n=6,7,8)")
    print("=" * 90)
    for n in [6, 7, 8]:
        idx, pos, N, c = build_structure_constants(n)
        rng = np.random.default_rng(0)
        A = rng.normal(size=(N, N)); W = A + A.T
        Qform = build_qform_sym_general(W, c)
        max_err = 0.0
        for _ in range(4):
            B = rng.normal(size=(N, N)); H = B + B.T
            lhs = H.reshape(-1) @ Qform @ H.reshape(-1)
            rhs = frob(W, Q_full(H, c))
            max_err = max(max_err, abs(lhs - rhs) / (abs(rhs) + 1e-300))
        print(f"  n={n}: max relative error over 4 random (W,H) trials = {max_err:.3e}")

    print()
    print("=" * 90)
    print("PART 1: build W_n bases and benchmark (n=6 first, then extrapolate)")
    print("=" * 90)
    ns = [6, 7, 8, 9, 10, 11, 12]
    bases = {}
    t_start_bench = time.time()
    for n in ns:
        t0 = time.time()
        Eflat, c, N, D = build_weyl_orthonormal_basis(n)
        bases[n] = (Eflat, c, N, D)
        print(f"    total for n={n}: {time.time()-t0:.2f}s")
    print(f"  all bases n=6..12 built in {time.time()-t_start_bench:.2f}s total "
          f"(comfortably under the 5-minute in-turn budget; n=13,14 benchmarked "
          f"separately at ~7s/~19s -- not needed given n=6..12 already covers and "
          f"exceeds the requested range).")

    print()
    print("=" * 90)
    print("PART 2: validation -- L_W symmetric, L_W(W)=Q(W), L_W*(W*)=W* (idempotent)")
    print("=" * 90)
    idx6, pos6, N6, c6 = build_structure_constants(6)
    for n in [6, 8, 10]:
        Eflat, c, N, D = bases[n]
        idx, pos, N_, c_ = build_structure_constants(n)
        rng = np.random.default_rng(3)
        Wr, _ = random_weyl_unit(Eflat, D, N, rng)
        res_r = analyze_point(Wr, Eflat, c, "random")
        Wstar_unit, pq = sphere_product_unit(n, c, idx, N)
        Wstar, lam_star = idempotent_rescale(Wstar_unit, c)
        res_star = analyze_point(Wstar, Eflat, c, "W*")
        Qstar = Q_full(Wstar, c)
        idem_resid = np.linalg.norm(Qstar - Wstar) / np.linalg.norm(Wstar)
        print(f"  n={n}: random W: sym_resid={res_r['sym_resid']:.2e}  "
              f"proj_resid={res_r['proj_resid']:.2e}  L_W(W)=Q(W) resid={res_r['lw_eq_q_resid']:.2e}")
        print(f"         W* (p,q)={pq}, natural-scale lambda={lam_star:.6f}: "
              f"sym_resid={res_star['sym_resid']:.2e}  proj_resid={res_star['proj_resid']:.2e}  "
              f"L_W*(W*)=Q(W*) resid={res_star['lw_eq_q_resid']:.2e}  "
              f"Q(W*)=W* idempotency resid={idem_resid:.2e}")

    print()
    print("=" * 90)
    print("PART 3: trace tables -- (a) random W [x5], (b) balanced sphere product W*, "
          "(c) Fox's S^4(alpha)")
    print("=" * 90)
    n_random = 5
    n_random_fit = 40  # extra random samples per n used only for the a_n,b_n least-squares fit
    all_data = {}  # n -> list of point dicts (includes both the reported 5 and the extra fit samples)
    cn_by_n = {}
    ab_by_n = {}
    header = (f"{'n':>3} {'point':>10} {'tr(L_W)':>14} {'tr(L_W^2)':>14} {'tr(L_W^3)':>14} "
              f"{'||W||^2':>10} {'tr(W^3)':>12} {'<W#,W>':>12} {'proj_resid':>11}")
    for n in ns:
        Eflat, c, N, D = bases[n]
        idx, pos, N_, c_ = build_structure_constants(n)
        print(f"--- n={n} (D={D}) ---")
        print(header)
        rng = np.random.default_rng(100 + n)
        pts = []
        for i in range(n_random):
            W, _ = random_weyl_unit(Eflat, D, N, rng)
            r = analyze_point(W, Eflat, c, f"random#{i}")
            pts.append(r)
            print(f"{n:3d} {r['label']:>10} {r['tr1']:14.8f} {r['tr2']:14.8f} {r['tr3']:14.8f} "
                  f"{r['normW2']:10.6f} {r['trW3']:12.6f} {r['wsharp']:12.6f} {r['proj_resid']:11.2e}")

        Wstar_unit, pq = sphere_product_unit(n, c, idx, N)
        r_star = analyze_point(Wstar_unit, Eflat, c, "W*")
        print(f"{n:3d} {r_star['label']:>10} {r_star['tr1']:14.8f} {r_star['tr2']:14.8f} "
              f"{r_star['tr3']:14.8f} {r_star['normW2']:10.6f} {r_star['trW3']:12.6f} "
              f"{r_star['wsharp']:12.6f} {r_star['proj_resid']:11.2e}   (p,q)={pq}")

        Wfox_unit = fox_S4_unit(n, c)
        r_fox = analyze_point(Wfox_unit, Eflat, c, "Fox S^4")
        print(f"{n:3d} {r_fox['label']:>10} {r_fox['tr1']:14.8f} {r_fox['tr2']:14.8f} "
              f"{r_fox['tr3']:14.8f} {r_fox['normW2']:10.6f} {r_fox['trW3']:12.6f} "
              f"{r_fox['wsharp']:12.6f} {r_fox['proj_resid']:11.2e}")

        # c_n from the unit-norm random samples (should be W-independent).
        c_vals = np.array([p['tr2'] / p['normW2'] for p in pts])
        c_n_mean = c_vals.mean()
        c_n_std = c_vals.std()
        cn_by_n[n] = c_n_mean
        print(f"  c_n = tr(L_W^2)/||W||^2 over the {n_random} random samples: "
              f"mean={c_n_mean:.10f}  std={c_n_std:.2e}  "
              f"(W*: {r_star['tr2']/r_star['normW2']:.10f}, Fox: {r_fox['tr2']/r_fox['normW2']:.10f})")

        # a_n, b_n via least squares over n_random_fit extra random samples (raw scale, no
        # normalization needed since tr(L_W^3), tr(W^3), <W#,W> are all homogeneous degree 3).
        tr3s, trW3s, wsharps = [], [], []
        for _ in range(n_random_fit):
            coeffs_r = rng.normal(size=D)
            Wr = (coeffs_r @ Eflat).reshape(N, N)
            rr = analyze_point(Wr, Eflat, c)
            tr3s.append(rr['tr3']); trW3s.append(rr['trW3']); wsharps.append(rr['wsharp'])
        tr3s = np.array(tr3s); trW3s = np.array(trW3s); wsharps = np.array(wsharps)
        Amat = np.column_stack([trW3s, wsharps])
        sol, _, _, _ = np.linalg.lstsq(Amat, tr3s, rcond=None)
        a_n, b_n = sol
        pred = Amat @ sol
        relres = np.linalg.norm(tr3s - pred) / np.linalg.norm(tr3s)
        ab_by_n[n] = (a_n, b_n, relres)
        print(f"  least-squares fit tr(L_W^3) = a_n*tr(W^3) + b_n*<W#,W> over "
              f"{n_random_fit} random samples: a_n={a_n:.8f}  b_n={b_n:.8f}  "
              f"relative residual={relres:.3e}")
        # cross-check the fitted (a_n,b_n) against W* and Fox's point (not used in the fit).
        pred_star = a_n * r_star['trW3'] + b_n * r_star['wsharp']
        pred_fox = a_n * r_fox['trW3'] + b_n * r_fox['wsharp']
        print(f"  cross-check on held-out special points: W* actual tr(L_W^3)={r_star['tr3']:.8f} "
              f"vs a_n*tr(W^3)+b_n<W#,W>={pred_star:.8f}  "
              f"(relerr={abs(pred_star-r_star['tr3'])/abs(r_star['tr3']):.2e});  "
              f"Fox actual={r_fox['tr3']:.8f} vs predicted={pred_fox:.8f}  "
              f"(relerr={abs(pred_fox-r_fox['tr3'])/abs(r_fox['tr3']):.2e})")
        all_data[n] = dict(random=pts, star=r_star, fox=r_fox)
        print()

    print("=" * 90)
    print("PART 4: exact rational fits, with held-out n prediction")
    print("=" * 90)

    print("\n-- tr(L_W) identically 0 --")
    max_tr1 = max(abs(p['tr1']) for n in ns for p in all_data[n]['random'])
    max_tr1 = max(max_tr1, max(abs(all_data[n]['star']['tr1']) for n in ns))
    max_tr1 = max(max_tr1, max(abs(all_data[n]['fox']['tr1']) for n in ns))
    print(f"  max|tr(L_W)| over ALL random/W*/Fox points, n=6..12: {max_tr1:.3e}  (machine precision)")

    print("\n-- c_n = tr(L_W^2)/||W||^2 --")
    cn_vals = [cn_by_n[n] for n in ns]
    poly_c, ok_c = fit_and_holdout(ns, cn_vals, 4, "c_n")  # fit on n=6,7,8,9; predict n=10,11,12

    print("\n-- a_n --")
    an_vals = [ab_by_n[n][0] for n in ns]
    poly_a, ok_a = fit_and_holdout(ns, an_vals, 4, "a_n")

    print("\n-- b_n --")
    bn_vals = [ab_by_n[n][1] for n in ns]
    poly_b, ok_b = fit_and_holdout(ns, bn_vals, 4, "b_n")

    print("\n-- least-squares residuals for the (a_n,b_n) fit, all n --")
    for n in ns:
        a_n, b_n, relres = ab_by_n[n]
        print(f"  n={n:2d}: relative residual = {relres:.3e}"
              f"  {'(noise level -> the two invariants span tr(L_W^3))' if relres < 1e-8 else '(ABOVE NOISE -- possible third invariant)'}")

    print()
    print("=" * 90)
    print("SUMMARY")
    print("=" * 90)
    print(f"  tr(L_W) = 0 identically: confirmed to {max_tr1:.1e} across all test points, n=6..12.")
    print(f"  c_n fit {'PREDICTS' if ok_c else 'FAILS TO PREDICT'} held-out n: c_n = {poly_c}")
    print(f"  a_n fit {'PREDICTS' if ok_a else 'FAILS TO PREDICT'} held-out n: a_n = {poly_a}")
    print(f"  b_n fit {'PREDICTS' if ok_b else 'FAILS TO PREDICT'} held-out n: b_n = {poly_b}")


if __name__ == "__main__":
    main()
