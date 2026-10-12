"""
Unconstrained gradient-ascent search for critical points of P(W) = <W, Q(W)>
on the unit sphere of the (Bianchi + Ricci-flat) Weyl-tensor space at
n=6,7,8, with NO assumption of coordinate-diagonal structure -- a direct
numerical test of the "lifting lemma": does the O(n)-orbit of every global
maximizer of P meet the coordinate-diagonal locus (W diagonal on coordinate
2-planes e_i^e_j of SOME orthonormal frame)?

All previously-known critical points in this repo (sphere products, Fox's
S^4(alpha)/CP^2-type, quaternionic-Kaehler HP^m, Fox's r>=8 subalgebra
family) were CONSTRUCTED to already be coordinate-diagonal (or built by
zero-padding block-diagonal structures). This script instead starts from
random points in the FULL Weyl-tensor space and runs genuine Riemannian
gradient ascent, never touching coordinate-diagonal structure, then tests
whether the local maxima found are diagonalizable after the fact.

Method
------
1. Weyl-space parametrization: same Bianchi-nullspace / Ricci-flat-nullspace
   construction as weyl.py / hessian_fast.py, giving an orthonormal
   (Frobenius inner product) basis Eflat: D x N^2 (N=C(n,2), D=dim Weyl_n)
   of flattened NxN operator-on-Lambda^2 matrices.
2. Ambient gradient: P(x) = T(x,x,x) for the symmetric trilinear form T with
   T(x,x,.) = Q(x) (Hamilton's map Q=W^2+W^#, via rsharp_basis_free.py's
   validated basis-free Q_full -- NOT weyl.py's unsafe per-operator-
   diagonalized Q_general, which is documented there as unsafe for anything
   involving polarization). So dP(x)[h] = 3<Q(x),h>, and because the Weyl
   subspace is linear, the gradient of P restricted to it is exactly the
   orthogonal projection (via Eflat) of the ambient gradient 3*Q_full(W).
3. Riemannian gradient ascent on the unit sphere in Weyl-coordinate space
   R^D: project the ambient gradient onto the sphere tangent space, take a
   backtracking-line-search step, renormalize. x ranges over the FULL
   D-dimensional space throughout -- never restricted to any diagonal
   subspace.
4. Many random restarts, uniformly random unit vectors in R^D (no diagonal
   bias whatsoever).
5. At convergence, verify the idempotency residual ||Q(W)-lambda W||/|W|
   against the trusted Q_full machinery.
6. Cluster distinct critical P-values found (tolerance-based) -- itself
   informative about the basin-of-attraction structure even without full
   O(n)-orbit deduplication.
7. Diagonalizability test for a representative of each cluster: search over
   g in O(n) (SO(n) via matrix-exponential of a skew-symmetric generator in
   the same coordinate basis, times a fixed reflection for the O(n)\SO(n)
   component) for a rotation making Lambda^2(g) W Lambda^2(g)^T diagonal in
   the FIXED coordinate-pair basis, minimizing the relative off-diagonal
   Frobenius residual via many random-restart local optimizations (SciPy
   L-BFGS-B, finite-difference gradient). The method is validated on a
   known diagonal tensor (randomly O(n)-rotated) before being trusted on
   the search results: it must drive the residual to ~0 there.
"""
import sys
import time
import numpy as np
from scipy.linalg import expm
from scipy.optimize import minimize

from weyl import build_structure_constants, bianchi_constraint_matrix, vec_to_mat, R_val
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2, Q_op, so_n_basis_matrices


# ---------------------------------------------------------------------
# 0. Sanity check: rsharp_basis_free.Q_full agrees with curvature_operator's
#    independently-implemented Q_op on random symmetric operators.
# ---------------------------------------------------------------------
def cross_validate_Q(n, seed=0, ntrials=3):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    assert L2.pairs == idx, "pair ordering mismatch between curvature_operator and weyl"
    rng = np.random.default_rng(seed)
    worst = 0.0
    for _ in range(ntrials):
        A = rng.normal(size=(N, N))
        S = 0.5 * (A + A.T)
        Q1 = Q_full(S, c)
        Q2 = Q_op(L2, S)
        err = np.max(np.abs(Q1 - Q2)) / (np.max(np.abs(Q2)) + 1e-300)
        worst = max(worst, err)
    print(f"  n={n}: Q_full vs Q_op cross-check, worst relative err = {worst:.2e}")
    assert worst < 1e-8, "Q_full and Q_op DISAGREE -- do not trust results"
    return idx, pos, N, c


# ---------------------------------------------------------------------
# 1. Build orthonormal Weyl-space basis (Bianchi nullspace ^ Ricci-flat).
# ---------------------------------------------------------------------
def build_weyl_basis(n, idx, pos, N, c, verbose=True):
    t0 = time.time()
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx, pos, n, N)
    U, S, Vt = np.linalg.svd(Bmat)
    tol = 1e-9 * S[0] if len(S) else 1e-9
    rank = int(np.sum(S > tol))
    null_basis = Vt[rank:, :].T
    D0 = null_basis.shape[1]
    Rmat_ds = [vec_to_mat(null_basis[:, d], triu_idx, N) for d in range(D0)]
    ric_rows = []
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(D0)
            for j in range(n):
                if j == i or j == k:
                    continue
                for d in range(D0):
                    row[d] += R_val(Rmat_ds[d], pos, n, i, j, k, j)
            ric_rows.append(row)
    RicMat = np.array(ric_rows)
    Ur, Sr, Vtr = np.linalg.svd(RicMat)
    tolr = 1e-9 * Sr[0] if len(Sr) else 1e-9
    rankr = int(np.sum(Sr > tolr))
    weyl_coeffs = Vtr[rankr:, :].T
    weyl_basis = null_basis @ weyl_coeffs
    D = weyl_basis.shape[1]
    mats = [vec_to_mat(weyl_basis[:, i], triu_idx, N) for i in range(D)]
    Mflat = np.array([m.reshape(-1) for m in mats])
    G = Mflat @ Mflat.T
    wG, VG = np.linalg.eigh(G)
    wG = np.maximum(wG, 1e-14)
    Ginvhalf = VG @ np.diag(1 / np.sqrt(wG)) @ VG.T
    Eflat = Ginvhalf.T @ Mflat  # (D, N^2), orthonormal Weyl basis, flattened
    formula = (n + 2) * (n + 1) * n * (n - 3) / 12
    if verbose:
        print(f"  n={n}: dim(Weyl)={D} (formula {formula:.0f})  [build {time.time()-t0:.2f}s]")
    assert D == int(round(formula))
    return Eflat, D


# ---------------------------------------------------------------------
# 2/3/4. Riemannian gradient ascent on the Weyl-space unit sphere.
# ---------------------------------------------------------------------
def P_and_grad(x, Eflat, c, N):
    amb = x @ Eflat
    Wmat = amb.reshape(N, N)
    Wmat = 0.5 * (Wmat + Wmat.T)
    Qmat = Q_full(Wmat, c)
    P = float(np.sum(Wmat * Qmat))
    grad_x = Eflat @ (3.0 * Qmat.reshape(-1))
    return P, grad_x, Wmat, Qmat


def gradient_ascent(x0, Eflat, c, N, D, max_iter=400, tol=1e-11):
    x = x0 / np.linalg.norm(x0)
    step = 0.2
    P, grad_x, Wmat, Qmat = P_and_grad(x, Eflat, c, N)
    for it in range(max_iter):
        g_tan = grad_x - np.dot(grad_x, x) * x
        gnorm = np.linalg.norm(g_tan)
        if gnorm < tol:
            break
        accepted = False
        for _ in range(50):
            x_new = x + step * g_tan
            x_new = x_new / np.linalg.norm(x_new)
            P_new, grad_new, Wnew, Qnew = P_and_grad(x_new, Eflat, c, N)
            if P_new > P - 1e-13:
                accepted = True
                break
            step *= 0.5
        if not accepted:
            break
        x, P, grad_x, Wmat, Qmat = x_new, P_new, grad_new, Wnew, Qnew
        step = min(step * 1.3, 1.0)
    # idempotency residual: ||Q(W) - P*W|| / |W|  (|W|=1)
    residual = np.linalg.norm(Qmat - P * Wmat)
    return x, P, residual, it


def run_search(n, idx, pos, N, c, Eflat, D, n_restarts, seed, max_iter=400):
    rng = np.random.default_rng(seed)
    results = []
    t0 = time.time()
    for r in range(n_restarts):
        x0 = rng.normal(size=D)
        x_fin, P_fin, resid, iters = gradient_ascent(x0, Eflat, c, N, D, max_iter=max_iter)
        results.append(dict(P=P_fin, x=x_fin, residual=resid, iters=iters))
    dt = time.time() - t0
    print(f"  n={n}: {n_restarts} restarts in {dt:.1f}s ({dt/n_restarts*1000:.1f} ms/restart)")
    return results


def cluster_by_value(results, tol=2e-4, resid_tol=1e-5):
    good = [r for r in results if r["residual"] < resid_tol]
    bad = [r for r in results if r["residual"] >= resid_tol]
    good_sorted = sorted(good, key=lambda r: r["P"])
    clusters = []
    for r in good_sorted:
        placed = False
        for cl in clusters:
            if abs(cl["P"] - r["P"]) < tol:
                cl["members"].append(r)
                cl["P"] = np.mean([m["P"] for m in cl["members"]])
                placed = True
                break
        if not placed:
            clusters.append({"P": r["P"], "members": [r]})
    clusters.sort(key=lambda cl: -cl["P"])
    return clusters, bad


# ---------------------------------------------------------------------
# 5. Diagonalizability test: search over O(n) for a frame making W diagonal
#    on coordinate 2-planes.
# ---------------------------------------------------------------------
def lambda2_action_matrix(g, idx, N):
    ii = np.array([p[0] for p in idx])
    jj = np.array([p[1] for p in idx])
    Gi = g[:, ii]  # (n, N)
    Gj = g[:, jj]  # (n, N)
    Out = Gi[ii, :] * Gj[jj, :] - Gi[jj, :] * Gj[ii, :]  # (N, N): Out[b,a]
    return Out


def diag_residual(theta, Wmat, idx, N, Es, reflect):
    n = Es[0].shape[0]
    A = np.zeros((n, n))
    for a, val in enumerate(theta):
        A += val * Es[a]
    g = expm(A)
    if reflect is not None:
        g = g @ reflect
    L = lambda2_action_matrix(g, idx, N)
    Wp = L @ Wmat @ L.T
    off = Wp - np.diag(np.diag(Wp))
    return np.linalg.norm(off) / np.linalg.norm(Wmat)


def search_diagonalization(Wmat, idx, N, n, n_restarts=30, seed=0, maxiter=150):
    Es, _, _ = so_n_basis_matrices(n)
    rng = np.random.default_rng(seed)
    Nparam = len(Es)
    reflect = np.eye(n)
    reflect[0, 0] = -1.0
    best = np.inf
    best_theta = None
    for r in range(n_restarts):
        refl = reflect if (r % 2 == 1) else None
        theta0 = rng.uniform(-1.5, 1.5, size=Nparam)
        res = minimize(
            diag_residual, theta0, args=(Wmat, idx, N, Es, refl),
            method="L-BFGS-B", options=dict(maxiter=maxiter, ftol=1e-14, gtol=1e-12),
        )
        if res.fun < best:
            best = res.fun
            best_theta = res.x
    return best, best_theta


def validate_diagonalization_method(n, idx, pos, N, c, seed=0):
    """Sanity check: feed the search a KNOWN diagonal tensor, randomly
    O(n)-rotated, and confirm the search drives the residual to ~0."""
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
    Wdiag = np.diag(lam)
    rng = np.random.default_rng(seed + 999)
    A = rng.normal(size=(n, n))
    A = A - A.T
    g_rand = expm(A)
    L = lambda2_action_matrix(g_rand, idx, N)
    Wrot = L @ Wdiag @ L.T
    off0 = Wrot - np.diag(np.diag(Wrot))
    print(f"  validation: randomly-rotated sphere-product tensor, "
          f"off-diag/|W| before search = {np.linalg.norm(off0)/np.linalg.norm(Wrot):.4f}")
    best, _ = search_diagonalization(Wrot, idx, N, n, n_restarts=20, seed=seed)
    print(f"  validation: best off-diag/|W| found by search = {best:.2e}  "
          f"({'PASS' if best < 1e-5 else 'FAIL -- method untrustworthy'})")
    return best < 1e-5


# ---------------------------------------------------------------------
# Reference values (already established elsewhere in this repo -- see
# findings/INDEX.md "Second-variation Hessian attempt" table for sphere products,
# "Nonassociative algebra" section for CP^2-type, adversarial_check4_qk.py
# for quaternionic-Kaehler at n=8).
# ---------------------------------------------------------------------
KNOWN = {
    6: [("sphere (3,3) balanced", 1.05409), ("sphere (2,4)", 0.96825)],
    7: [("sphere (3,4) balanced", 1.09545), ("sphere (2,5)", 0.97980)],
    8: [("sphere (4,4) balanced", 1.14564), ("sphere (2,6)", 0.98601),
        ("quaternionic-Kaehler HP^2", 1.115547)],
}
CP2_VALUE = np.sqrt(1.5)  # sqrt(3/2) approx 1.224745, this repo's normalization, valid all n>=4


def main():
    ns = [6, 7, 8]
    restarts = {6: 200, 7: 150, 8: 120}
    diag_restarts = {6: 30, 7: 25, 8: 20}

    print("=" * 70)
    print("STEP 0: cross-validating Q_full (rsharp_basis_free) vs Q_op (curvature_operator)")
    for n in ns:
        cross_validate_Q(n)

    all_summaries = {}

    for n in ns:
        print("=" * 70)
        print(f"n = {n}")
        idx, pos, N, c = build_structure_constants(n)
        Eflat, D = build_weyl_basis(n, idx, pos, N, c)

        print(f"  validating diagonalizability-search method on a known diagonal tensor:")
        ok = validate_diagonalization_method(n, idx, pos, N, c)
        if not ok:
            print("  WARNING: diagonalizability-search method failed its own sanity check; "
                  "results for this n should be treated with reduced confidence.")

        print(f"  running {restarts[n]} unconstrained gradient-ascent restarts:")
        results = run_search(n, idx, pos, N, c, Eflat, D, restarts[n], seed=12345 + n)
        clusters, bad = cluster_by_value(results)

        print(f"  {len(clusters)} distinct critical P-values found "
              f"(residual<1e-5 clustering, tol=2e-4); "
              f"{len(bad)}/{len(results)} restarts did not converge to residual<1e-5")
        print(f"  reference values: CP^2-type = {CP2_VALUE:.6f}, " +
              ", ".join(f"{lbl}={val}" for lbl, val in KNOWN[n]))

        summary_rows = []
        for ci, cl in enumerate(clusters):
            frac = len(cl["members"]) / len(results)
            Pval = cl["P"]
            # nearest known reference
            refs = [("CP^2-type", CP2_VALUE)] + KNOWN[n]
            nearest = min(refs, key=lambda r: abs(r[1] - Pval))
            match = abs(nearest[1] - Pval) < 3e-3
            rep = cl["members"][0]
            amb = rep["x"] @ Eflat
            Wmat = amb.reshape(N, N)
            Wmat = 0.5 * (Wmat + Wmat.T)
            best_resid, _ = search_diagonalization(
                Wmat, idx, N, n, n_restarts=diag_restarts[n], seed=999 + ci
            )
            print(f"  cluster {ci}: P={Pval:.6f}  frac_of_restarts={frac:.3f}  "
                  f"n_members={len(cl['members'])}  nearest_known={nearest[0]}"
                  f"({'match' if match else 'NO MATCH -- possibly new'})  "
                  f"best_diag_residual={best_resid:.2e}  "
                  f"diagonalizable={'YES' if best_resid < 1e-4 else 'NO (evidence against)'}")
            summary_rows.append(dict(P=Pval, frac=frac, nearest=nearest[0], match=match,
                                      diag_residual=best_resid,
                                      diagonalizable=best_resid < 1e-4))
        all_summaries[n] = summary_rows

    print("=" * 70)
    print("FINAL SUMMARY")
    for n in ns:
        print(f"n={n}:")
        for row in all_summaries[n]:
            print(f"   P={row['P']:.6f}  frac={row['frac']:.3f}  ~{row['nearest']}"
                  f"({'match' if row['match'] else 'NEW'})  "
                  f"diag_resid={row['diag_residual']:.2e}  "
                  f"{'diagonalizable' if row['diagonalizable'] else 'NOT diagonalizable'}")


if __name__ == "__main__":
    main()
