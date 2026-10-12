"""Vectorized, fast replacement for hessian_pipeline_b.py.

hessian_pipeline_b.py builds the tangent-space Hessian matrix M by looping over all
O(Dt^2) pairs of tangent-basis elements and, for each pair, calling
Q_full(Etan[a]+Etan[b], c) -- which is itself an O(N^4) computation (N =
C(n,2)). For n=12 (N=66, Dt=1637) that is ~1.34e6 pairs x ~4e7 flops each
= ~5e13 flops total, which is why the n=12 run in the previous session did
not finish in over an hour.

The key observation: Phi(H) := <Wunit, Q_full(H)> = <Wunit, H@H + H^#> is an
*exactly quadratic* function of H (both the H@H term and the R^# term,
Rsharp_full(H,c)_{ab} = -1/2 tr(A_a H A_b H), are quadratic in H). Any
quadratic form on a finite-dimensional vector space can be written once and
for all as vec(H)^T Qform_sym vec(H) for a fixed symmetric matrix Qform_sym
acting on H's N^2 flattened entries. Building Qform_sym costs a handful of
BLAS-friendly O(N^5)-flop tensor contractions done ONCE (not once per pair),
and after that every pairing <Wunit, B(Etan[a],Etan[b])> needed for the
Hessian is obtained from the single matrix product

    M = Etanflat @ Qform_sym @ Etanflat.T

(Etanflat: Dt x N^2, the tangent-space orthonormal basis flattened), which
is a couple of BLAS matmuls instead of 1.3 million individual O(N^4) Python
calls. This turns the wall-clock cost from "did not finish in an hour" into
a few seconds to a couple of minutes even at n=12.

Cross-checked against hessian_pipeline_b.py (bug-fixed, permutation-symmetry-verified
pipeline) at n=6 and n=8, both balanced and unbalanced splits: identical
lambda, identical eigenvalue counts (positive/zero/negative), matching to
>=10 significant digits. See findings/INDEX.md, "n=12 Hessian completion".
"""
import numpy as np
import time
import sys
from weyl import build_structure_constants, vec_to_mat, bianchi_constraint_matrix, R_val


def build_qform_sym(w, c):
    """Build the N^2 x N^2 symmetric matrix Qform_sym such that for any
    symmetric H (NxN matrix, flattened row-major to a length-N^2 vector),

        vec(H) @ Qform_sym @ vec(H) == <Wunit, Q_full(H, c)>

    where Wunit = diag(w) and Q_full(H,c) = H@H + H^# (Hamilton's map).

    Derivation (see module docstring / findings/INDEX.md for the write-up):
      <Wunit, H@H>       = sum_{n,p} w[n] H[n,p]^2       -> D1 = kron(diag(w), I_N)
      <Wunit, Rsharp(H)> = sum_{n,p,n',m} K[n,p,n',m] H[n,p] H[n',m]
        with K[n,p,n',m] = -1/2 * sum_a w[a] c[a,m,n] c[a,p,n']
    """
    N = len(w)
    D1 = np.kron(np.diag(w), np.eye(N))
    wc = w[:, None, None] * c  # (a,m,n), scaled along axis a
    raw = np.einsum('amn,apr->mnpr', wc, c, optimize=True)  # (m,n,p,r)
    K = -0.5 * np.transpose(raw, (1, 2, 3, 0))  # -> (n,p,r,m) = K[n,p,n',m]
    Qform2 = K.reshape(N * N, N * N)
    Qform = D1 + Qform2
    return 0.5 * (Qform + Qform.T)


def run(n, p, q, verbose=True):
    t_start = time.time()
    idx, pos, N, c = build_structure_constants(n)
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx, pos, n, N)
    U, S, Vt = np.linalg.svd(Bmat)
    tol = 1e-9 * S[0]
    rank = np.sum(S > tol)
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
    tolr = 1e-9 * Sr[0] if len(Sr) > 0 else 1e-9
    rankr = np.sum(Sr > tolr)
    weyl_coeffs = Vtr[rankr:, :].T
    weyl_basis = null_basis @ weyl_coeffs
    D = weyl_basis.shape[1]
    if verbose:
        print(f"n={n} N={N} dim(AlgCurv)={D0} dim(Weyl)={D}  [setup: {time.time()-t_start:.1f}s]")

    # Vectorized Gram-Schmidt: flatten each basis Weyl tensor to an N^2 vector,
    # build the DxD Gram matrix as a single BLAS matmul (no O(D^2) Python loop).
    t0 = time.time()
    mats = [vec_to_mat(weyl_basis[:, i], triu_idx, N) for i in range(D)]
    Mflat = np.array([m.reshape(-1) for m in mats])  # (D, N^2)
    G = Mflat @ Mflat.T
    wG, VG = np.linalg.eigh(G)
    wG = np.maximum(wG, 1e-14)
    Ginvhalf = VG @ np.diag(1 / np.sqrt(wG)) @ VG.T
    Eflat = Ginvhalf.T @ Mflat  # (D, N^2): orthonormal Weyl-space basis, flattened
    if verbose:
        print("orthonormalize Weyl basis:", time.time() - t0, "s")

    x = 1.0 / (p * (p - 1)); y = 1.0 / (q * (q - 1)); z = -1.0 / (p * q)
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
    Wunit = Wmat / Wnorm
    wunit = lam / Wnorm
    if verbose:
        print("|W*| (Frobenius, raw) =", Wnorm)

    t0 = time.time()
    Qform_sym = build_qform_sym(wunit, c)
    if verbose:
        print("build Qform_sym (N^2 x N^2):", time.time() - t0, "s")

    wunit_flat = Wunit.reshape(-1)
    lam_P = float(wunit_flat @ Qform_sym @ wunit_flat)
    if verbose:
        print("lambda = P(W*) [unit] =", lam_P)

    coeffs_on_W = Eflat @ wunit_flat  # (D,)
    Tflat = Eflat - np.outer(coeffs_on_W, wunit_flat)  # (D, N^2): project out W* direction
    Gt = Tflat @ Tflat.T
    wt, Vt2 = np.linalg.eigh(Gt)
    order = np.argsort(-wt)
    wt = wt[order]; Vt2 = Vt2[:, order]
    keep = wt > 1e-8 * wt[0]
    Dt = int(np.sum(keep))
    if verbose:
        print("tangent space dim (should be D-1 =", D - 1, "):", Dt)
    Vt2k = Vt2[:, :Dt]; wtk = wt[:Dt]
    Ginvhalf_t = Vt2k @ np.diag(1 / np.sqrt(wtk))
    Etanflat = Ginvhalf_t.T @ Tflat  # (Dt, N^2)

    t0 = time.time()
    M = Etanflat @ Qform_sym @ Etanflat.T
    M = 0.5 * (M + M.T)
    t1 = time.time()
    if verbose:
        print("Hessian pairing matrix build time (vectorized, single matmul):", t1 - t0, "s")

    Hess = 6 * M - 3 * lam_P * np.eye(Dt)
    evals = np.linalg.eigvalsh(Hess)
    return evals, lam_P, Dt


if __name__ == "__main__":
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 8
    p = int(sys.argv[2]) if len(sys.argv) > 2 else n // 2
    q = int(sys.argv[3]) if len(sys.argv) > 3 else n - p
    t0 = time.time()
    evals, lam_P, Dt = run(n, p, q)
    print("lambda=", lam_P)
    print("Hessian eigenvalues: min=", evals[0], " max=", evals[-1])
    print("num positive:", np.sum(evals > 1e-6), " num ~zero:", np.sum(np.abs(evals) < 1e-6),
          " num negative:", np.sum(evals < -1e-6))
    print("top 10 eigenvalues:", evals[-10:])
    print("total time:", time.time() - t0, "s")
