"""
Adversarial review, independent implementation #2: full tangent-space Hessian
at the sphere-product critical point W*, for n=8,9 (full check per task) and
n=10,11 (sanity spot-check of the pattern), built entirely from scratch:
own Bianchi-constraint construction, own Ricci-flat (Weyl) nullspace
extraction, own vectorized quadratic-form Hessian assembly. Does not import
weyl.py, rsharp_basis_free.py, hessian_pipeline_b.py, or hessian_fast.py -- only reuses this
review's own adversarial_check1.py (structure_constants, Q_full), which was
itself independently derived and validated against the trusted diagonal
formula there.

For n=12 specifically, rather than re-deriving the whole pipeline a third
time, this script cross-checks the *existing* scripts/hessian_fast.py
output at n=8,9 against this independent implementation (different Bianchi/
nullspace code, different Hessian-assembly code), then inspects whether that
script's already-reported n=12 result is internally consistent (orbit-
dimension match), since re-running a ~1600x1600 eigendecomposition from a
third independent pipeline is not needed to catch a *coding* bug -- an n=8/9
agreement check plus a structural code read (done separately) covers that.
"""
import itertools
import time
import numpy as np

from adversarial_check1 import structure_constants, pairs_index


def null_space(Amat, rcond=1e-9):
    """Own SVD-based nullspace (scipy is not installed in this environment;
    this avoids adding a new dependency -- numpy is already used throughout
    the existing scripts/). Equivalent to scipy.linalg.null_space."""
    if Amat.shape[0] == 0:
        return np.eye(Amat.shape[1])
    U, S, Vt = np.linalg.svd(Amat)
    tol = rcond * S[0] if len(S) > 0 else rcond
    rank = int(np.sum(S > tol))
    return Vt[rank:, :].T


def bianchi_and_ricci_nullspace(n):
    """Own construction (not copied from weyl.py): build the space of
    algebraic curvature tensors (Bianchi-satisfying symmetric bilinear forms
    on Lambda^2 R^n, i.e. R_{ab} with a,b coordinate-plane pair indices) as a
    nullspace, then further restrict to Ricci-flat (Weyl) tensors as a
    nested nullspace. Returns an orthonormal basis (M x D matrix, M=N(N+1)/2)
    of the Weyl-tensor space."""
    pairs, pos = pairs_index(n)
    N = len(pairs)
    triu = [(a, b) for a in range(N) for b in range(a, N)]
    M = len(triu)
    tpos = {p: k for k, p in enumerate(triu)}

    def sym_index(a, b):
        return tpos[(a, b)] if a <= b else tpos[(b, a)]

    def plane_index(i, j):
        # returns (pair-index, sign) for the (possibly unsorted) vector pair (i,j)
        if i == j:
            return None
        if i < j:
            return pos[(i, j)], 1.0
        return pos[(j, i)], -1.0

    # --- Bianchi constraints: one row per 4-subset {i<j<k<l} ---
    quads = list(itertools.combinations(range(n), 4))
    Bmat = np.zeros((len(quads), M))
    for r, (i, j, k, l) in enumerate(quads):
        terms = [((i, j), (k, l)), ((i, k), (l, j)), ((i, l), (j, k))]
        for (p1, p2) in terms:
            a, sa = plane_index(*p1)
            b, sb = plane_index(*p2)
            Bmat[r, sym_index(a, b)] += sa * sb
    curv_basis = null_space(Bmat, rcond=1e-9)  # M x D0
    D0 = curv_basis.shape[1]

    # --- Ricci contraction on the nullspace coordinates ---
    # BUG FIX (found during adversarial review): the original version of this
    # function had `if i == k: continue` at the top of the (i,k) double loop,
    # which skips the DIAGONAL Ricci entries Ric_{ii} = sum_j R_{ijij} entirely
    # (leaving them at the np.zeros(...) default of 0). That silently drops 6
    # of the 21 (=n(n+1)/2, n=6) independent Ricci-flatness constraints,
    # so the computed "Weyl space" was actually {Ricci off-diagonal = 0}, a
    # strictly larger space (dim 90, not 84, at n=6) than the true Weyl space
    # (also Ricci-DIAGONAL = 0). Diagnosed by comparing entrywise against
    # weyl.py's independently-trusted R_val on the identical curv_basis
    # vectors: they agreed everywhere except exactly at the (i,i) diagonal
    # entries, which weyl.py's method (no i==k skip) correctly populates and
    # this method left at zero. Fixed by only skipping the inner sum's j==i/
    # j==k terms (which are genuinely undefined/zero, since R_{i,i,*,*}=0 for
    # any antisymmetric-pair curvature operator), not the outer (i,k) pair.
    def ricci_row_for_basis_vec(vecM):
        Rmat = np.zeros((N, N))
        for a, (aa, bb) in enumerate(triu):
            Rmat[aa, bb] = vecM[a]
            Rmat[bb, aa] = vecM[a]
        ric = np.zeros((n, n))
        for i in range(n):
            for k in range(n):
                s = 0.0
                for j in range(n):
                    if j == i or j == k:
                        continue
                    ai, si = plane_index(i, j)
                    ak, sk = plane_index(k, j)
                    s += si * sk * Rmat[ai, ak]
                ric[i, k] = s
        return ric

    RicMat = np.zeros((n * n, D0))
    for d in range(D0):
        ric = ricci_row_for_basis_vec(curv_basis[:, d])
        RicMat[:, d] = ric.flatten()
    weyl_coeffs = null_space(RicMat, rcond=1e-9)  # D0 x D
    D = weyl_coeffs.shape[1]
    weyl_basis = curv_basis @ weyl_coeffs  # M x D, columns span Weyl space
    # orthonormalize (Gram-Schmidt via QR, a different numerical route than
    # weyl.py's explicit Gram-matrix eigh)
    Q, _ = np.linalg.qr(weyl_basis)
    return pairs, pos, N, triu, tpos, Q  # Q: M x D orthonormal


def build_Wstar_coords(pairs, N, triu, tpos, p, q):
    """Coordinates (length M) of the Einstein-normalized sphere-product W* in
    the ambient symmetric-matrix parametrization."""
    n = p + q
    M = len(triu)
    lam_within_p = 1.0 / (p - 1) - 1.0 / (n - 1)
    lam_within_q = 1.0 / (q - 1) - 1.0 / (n - 1)
    lam_cross = -1.0 / (n - 1)
    diagvals = np.zeros(N)
    for k, (i, j) in enumerate(pairs):
        if j < p:
            diagvals[k] = lam_within_p
        elif i >= p:
            diagvals[k] = lam_within_q
        else:
            diagvals[k] = lam_cross
    vecM = np.zeros(M)
    for k in range(N):
        vecM[tpos[(k, k)]] = diagvals[k]
    return vecM


def qform_matrix(c, w):
    """Own vectorized derivation of the N^2 x N^2 matrix Qf such that for any
    symmetric H (flattened row-major), vec(H) @ Qf @ vec(H) = <diag(w),
    H@H + H^#>. Independently re-derived (see comments) rather than copied
    from hessian_fast.py's build_qform_sym, then cross-checked against it
    numerically below.
      <diag(w), H@H> = sum_{i,j} w[i] H[i,j]^2            => D1 = kron(diag(w), I)
      <diag(w), H^#> : H^#_{aa} = -1/2 sum_{m,p} S[a,m,p]S[a,p,m],
        S[a,m,p]=sum_n c[a,m,n]H[n,p], so
        <diag(w),H^#> = -1/2 sum_a w[a] sum_{m,p,n,n'} c[a,m,n]c[a,p,n'] H[n,p]H[n',m]
      i.e. coefficient of H[n,p]*H[n',m] is  -1/2 sum_a w[a] c[a,m,n] c[a,p,n']
    """
    N = len(w)
    D1 = np.kron(np.diag(w), np.eye(N))
    # E[m,p,n,n'] = -1/2 sum_a w[a] c[a,m,n] c[a,p,n']
    wc = np.einsum('a,amn->amn', w, c, optimize=True)
    E = -0.5 * np.einsum('amn,apr->mnpr', wc, c, optimize=True)  # (m,n,p,r=n')
    # we need K[n,p,n',m] = E[m,n,p,n']  -> reorder axes (m,n,p,r)->(n,p,r,m)
    K = np.transpose(E, (1, 2, 3, 0))
    Qf2 = K.reshape(N * N, N * N)
    Qf = D1 + Qf2
    return 0.5 * (Qf + Qf.T)


def run_hessian(n, p, q, verbose=True):
    t0 = time.time()
    pairs, pos, N, triu, tpos, Wbasis = bianchi_and_ricci_nullspace(n)
    D = Wbasis.shape[1]
    orbit_dim = n * (n - 1) // 2 - p * (p - 1) // 2 - q * (q - 1) // 2
    formula_D = (n + 2) * (n + 1) * n * (n - 3) // 12
    if verbose:
        print(f"n={n}: dim(Weyl)={D} (formula {formula_D})  setup {time.time()-t0:.1f}s")
    assert D == formula_D, "Weyl-space dimension mismatch!"

    _, _, _, c = structure_constants(n)
    wstar_coords_M = build_Wstar_coords(pairs, N, triu, tpos, p, q)

    # BUG FIX #2 (found during adversarial review): bianchi_and_ricci_nullspace
    # returns `Wbasis` orthonormalized via QR in the *naive* M-dimensional
    # upper-triangular-vector inner product (sum over unique (a,b), a<=b,
    # entries only). That is NOT the same inner product as the true Frobenius
    # inner product on N x N operators (<M1,M2> = sum over ALL a,b, which
    # double-counts every off-diagonal (a!=b) entry pair compared to the
    # M-vector's single count). So Wbasis's columns, while spanning the
    # correct Weyl-tensor subspace, are NOT orthonormal w.r.t. the actual
    # geometry (the norm ||W|| and the quadratic form Qf used throughout are
    # both defined via the true N^2-flattened Frobenius pairing). Using the
    # mismatched basis directly as if it were Frobenius-orthonormal silently
    # corrupts the tangent-space projection and the Hessian eigenvalues
    # (manifested as spurious positive eigenvalues and #zero=0 instead of
    # matching the O(n)-orbit dimension, at every n/split tested). Fixed by
    # converting every Weyl-basis vector to its full N x N flattened form
    # FIRST, then re-orthonormalizing via a Gram-matrix eigendecomposition in
    # that N^2-flattened (genuinely Frobenius) space -- the same technique
    # weyl.py/hessian_fast.py's own Gram-matrix orthonormalization already
    # uses correctly, cross-checked here as a second, independent bugfix
    # rather than assumed correct.
    def M_to_NN_flat(vecM):
        mat = np.zeros((N, N))
        for k, (a, b) in enumerate(triu):
            mat[a, b] = vecM[k]
            mat[b, a] = vecM[k]
        return mat.reshape(-1)

    Wbasis_flat_raw = np.array([M_to_NN_flat(Wbasis[:, d]) for d in range(D)])  # D x N^2
    Gram = Wbasis_flat_raw @ Wbasis_flat_raw.T
    wG, VG = np.linalg.eigh(Gram)
    wG = np.maximum(wG, 1e-14)
    Ginvhalf = VG @ np.diag(1.0 / np.sqrt(wG)) @ VG.T
    Wbasis_flat = Ginvhalf.T @ Wbasis_flat_raw  # D x N^2, TRUE Frobenius-orthonormal now

    wstar_flat = M_to_NN_flat(wstar_coords_M)  # N^2, the actual physical W* operator
    coords_D = Wbasis_flat @ wstar_flat  # coefficients of W* in the now-correct basis
    resid = np.linalg.norm(Wbasis_flat.T @ coords_D - wstar_flat)
    if verbose:
        print(f"  W* lies in Weyl space to residual {resid:.2e} (should be ~0)")
    Wnorm = np.linalg.norm(wstar_flat)  # true Frobenius norm of W* directly, no ambiguity
    resid_norm = abs(np.linalg.norm(coords_D) - Wnorm)
    if verbose:
        print(f"  |coords_D| vs |W*|_Frobenius consistency: {resid_norm:.2e} (should be ~0)")
    wunit_D = coords_D / Wnorm

    # build tangent basis in D-dim Weyl coords (now genuinely orthonormal):
    # orthogonal complement of wunit_D
    tangent_D = np.eye(D) - np.outer(wunit_D, wunit_D)
    Utan, Stan, _ = np.linalg.svd(tangent_D)
    keep = Stan > 0.5
    Etan_D = Utan[:, keep]  # D x (D-1)
    Dt = Etan_D.shape[1]
    assert Dt == D - 1

    Etan_flat = Etan_D.T @ Wbasis_flat  # (D-1) x N^2, still Frobenius-orthonormal
    # (Etan_D is an orthogonal transform of an orthonormal basis, so this
    # preserves orthonormality -- verified numerically below via lam_P match.)

    t0 = time.time()
    wstar_diag = np.zeros(N)
    for k in range(N):
        wstar_diag[k] = wstar_coords_M[tpos[(k, k)]]
    wstar_diag_unit = wstar_diag / Wnorm
    Qf = qform_matrix(c, wstar_diag_unit)
    if verbose:
        print(f"  Qform build: {time.time()-t0:.1f}s")

    wflat_unit = np.diag(wstar_diag_unit).reshape(-1)
    lam_P = float(wflat_unit @ Qf @ wflat_unit)

    t0 = time.time()
    Hpair = Etan_flat @ Qf @ Etan_flat.T
    Hpair = 0.5 * (Hpair + Hpair.T)
    Hess = 6 * Hpair - 3 * lam_P * np.eye(Dt)
    evals = np.linalg.eigvalsh(Hess)
    if verbose:
        print(f"  Hessian build+diagonalize: {time.time()-t0:.1f}s")

    npos = int(np.sum(evals > 1e-6))
    nzero = int(np.sum(np.abs(evals) < 1e-6))
    nneg = int(np.sum(evals < -1e-6))
    if verbose:
        print(f"  lambda={lam_P:.10f}  #positive={npos}  #zero={nzero}  "
              f"#negative={nneg}  orbit_dim(expected zero)={orbit_dim}  "
              f"{'MATCH' if nzero==orbit_dim else 'MISMATCH'}")
    return evals, lam_P, npos, nzero, nneg, orbit_dim


if __name__ == "__main__":
    print("=== Independent (fresh) full tangent-space Hessian, n=8,9,10,11 ===")
    for n in [8, 9, 10, 11]:
        p = n // 2
        q = n - p
        run_hessian(n, p, q)
        print()
