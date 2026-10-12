"""Independent adversarial review of findings/INDEX.md's two newest sections.

Targets
  A. "The defect-penalty candidate inequality"      (Results 1-6, incl. the Fox lemma)
  B. "Lifting Jaeger's 3.3 in trace form"           (Results 1-9)

Repo convention (plan.md, "Execution" point 3): a reviewer works from
findings/INDEX.md's mathematical definitions and writes its own implementation.  So
nothing here is imported from the pipeline under review --
run_defect_penalty_test.py, run_fox_firstorder_lemma.py, run_jaeger_lift_33.py,
run_j5_structure.py, run_jaeger_lift_34.py, run_jaeger_346_lift.py,
run_jaeger_lift_36.py.  The single repo import is curvature_operator.Q_op, an
older primitive validated by reviews/INDEX.md Reviewers 2-8, and it is used only once,
to cross-check this file's own from-scratch # operator (section 0).

Conventions rebuilt here from the FINDINGS definitions:
  * Lambda^2 R^n carries the orthonormal basis {e_i ^ e_j}_{i<j}; an operator is
    an N x N matrix, N = C(n,2), and its 4-tensor is T[i,j,k,l] with
    T = -T(ji..) = -T(..lk) = T(kl,ij).  ||R||^2 = sum_{a,b} M[a,b]^2 = 1/4 sum_{ijkl} T^2.
  * (R^#)_{ijkl} = sum_{pq} (R_{ipkq} R_{jplq} - R_{iplq} R_{jpkq}),  Q(R) = R^2 + R^#.
  * Ric(R)_{ik} = sum_j R_{ijkj};  scal = tr Ric = 2 tr(M).
  * Alt(R)_{ijkl} = (R_{ijkl} + R_{iklj} + R_{iljk})/3, the orthogonal projection
    onto Lambda^4 inside S^2(Lambda^2).
  * delta(W)^2 = ||Alt(W_-)||^2 with W_- = -P_- W P_- the (PSD) negative part.
  * (R.h)_{ij} = sum_{kl} h_{kl} T_R(k,i,l,j),  T_R the 4-tensor of R.
  * (A x B)_{ijkl} = A_ik B_jl - A_il B_jk + A_jl B_ik - A_jk B_il  (full
    Kulkarni-Nomizu).  FINDINGS' "^" is half of this, so Ric ^ 2 id = Ric x id
    and Ric ^ Ric = (1/2) Ric x Ric.

Run:  python3 scripts/review_c8_independent.py [section ...]
"""

import itertools
import sys
from fractions import Fraction

import numpy as np

# --------------------------------------------------------------------------
# 0.  own primitives
# --------------------------------------------------------------------------


def pairs_of(n):
    return list(itertools.combinations(range(n), 2))


_IDX_CACHE = {}


def _idx(n):
    """Cached (pairIndex[i,j], sign[i,j]) for the e_i^e_j <-> pair-basis dictionary."""
    if n not in _IDX_CACHE:
        prs = pairs_of(n)
        pi = np.zeros((n, n), dtype=np.int64)
        sg = np.zeros((n, n))
        for a, (i, j) in enumerate(prs):
            pi[i, j] = pi[j, i] = a
            sg[i, j], sg[j, i] = 1.0, -1.0
        ii = np.array([p[0] for p in prs])
        jj = np.array([p[1] for p in prs])
        _IDX_CACHE[n] = (pi, sg, ii, jj)
    return _IDX_CACHE[n]


def mat_to_tensor(M, n):
    """N x N operator matrix -> 4-tensor T[i,j,k,l]."""
    pi, sg, _, _ = _idx(n)
    T = M[np.ix_(pi.ravel(), pi.ravel())].reshape(n, n, n, n)
    return T * sg[:, :, None, None] * sg[None, None, :, :]


def tensor_to_mat(T, n):
    _, _, ii, jj = _idx(n)
    return T[ii[:, None], jj[:, None], ii[None, :], jj[None, :]]


def ric_t(T):
    """Ric(R)_{ik} = sum_j R_{ijkj}."""
    return np.einsum("ijkj->ik", T)


def ric_m(M, n):
    return ric_t(mat_to_tensor(M, n))


def alt_t(T):
    """Orthogonal projection onto Lambda^4: (T_ijkl + T_iklj + T_iljk)/3."""
    return (T + np.transpose(T, (0, 3, 1, 2)) + np.transpose(T, (0, 2, 3, 1))) / 3.0


def sharp_t(T):
    """(R^#)_{ijkl} = sum_{pq}(R_ipkq R_jplq - R_iplq R_jpkq)."""
    S = np.einsum("ipkq,jplq->ijkl", T, T, optimize=True)
    return S - np.transpose(S, (0, 1, 3, 2))


def sharp_m(M, n):
    return tensor_to_mat(sharp_t(mat_to_tensor(M, n)), n)


def Qm(M, n):
    return M @ M + sharp_m(M, n)


def fro(A, B):
    return float(np.sum(A * B))


def nrm(A):
    return float(np.sqrt(np.sum(A * A)))


def kn(A, B):
    """(A x B)_{ijkl} = A_ik B_jl - A_il B_jk + A_jl B_ik - A_jk B_il."""
    return (
        np.einsum("ik,jl->ijkl", A, B)
        - np.einsum("il,jk->ijkl", A, B)
        + np.einsum("jl,ik->ijkl", A, B)
        - np.einsum("jk,il->ijkl", A, B)
    )


def rdot(T, h):
    """(R.h)_{ij} = sum_{kl} h_{kl} T[k,i,l,j]."""
    return np.einsum("kl,kilj->ij", h, T, optimize=True)


def alt_m(M, n):
    return tensor_to_mat(alt_t(mat_to_tensor(M, n)), n)


def weyl_project(M, n):
    """Orthogonal projection of a symmetric operator onto W_n (Bianchi + Ricci-free)."""
    T = mat_to_tensor(M, n)
    T = T - alt_t(T)                       # kill Lambda^4
    B = tensor_to_mat(T, n)
    rc = ric_t(T)
    s = float(np.trace(rc))
    corr = tensor_to_mat(kn(rc, np.eye(n)), n)   # = Ric ^ 2 id, diag entry rc_i+rc_j
    N = B.shape[0]
    return B - corr / (n - 2) + (s / ((n - 1) * (n - 2))) * np.eye(N)


def rand_weyl(n, rng):
    N = n * (n - 1) // 2
    A = rng.normal(size=(N, N))
    W = weyl_project((A + A.T) / 2.0, n)
    return W / nrm(W)


def spectral_parts(M, tol=1e-9):
    w, V = np.linalg.eigh(M)
    scale = max(1.0, np.max(np.abs(w)))
    pos = w > tol * scale
    neg = w < -tol * scale
    zer = ~(pos | neg)
    Pp = V[:, pos] @ V[:, pos].T
    Pm = V[:, neg] @ V[:, neg].T
    P0 = V[:, zer] @ V[:, zer].T
    absM = V @ np.diag(np.abs(w)) @ V.T
    Wp = V[:, pos] @ np.diag(w[pos]) @ V[:, pos].T
    Wm = -(V[:, neg] @ np.diag(w[neg]) @ V[:, neg].T)   # PSD
    return dict(w=w, V=V, Pp=Pp, Pm=Pm, P0=P0, absM=absM, Wp=Wp, Wm=Wm)


def delta2(M, n, tol=1e-9):
    """delta(W)^2 = ||Alt(W_-)||^2, W_- the PSD negative part."""
    return nrm(alt_m(spectral_parts(M, tol)["Wm"], n)) ** 2


def section0():
    print("=" * 78)
    print("0.  own machinery, validated before use")
    print("=" * 78)
    rng = np.random.default_rng(0)
    sys.path.insert(0, 'scripts/lib')[0])
    from curvature_operator import Lambda2, Q_op   # validated primitive, cross-check only

    for n in (5, 6, 7):
        N = n * (n - 1) // 2
        A = rng.normal(size=(N, N))
        M = (A + A.T) / 2
        mine = Qm(M, n)
        theirs = Q_op(Lambda2(n), M)
        print(f"  n={n}:  ||Q_mine - Q_op(curvature_operator)|| = {nrm(mine - theirs):.3e}"
              f"   (rel {nrm(mine - theirs)/nrm(theirs):.2e})")

    # Id^# = (n-2) Id
    for n in (5, 8):
        N = n * (n - 1) // 2
        print(f"  n={n}:  ||Id^# - (n-2)Id|| = {nrm(sharp_m(np.eye(N), n) - (n-2)*np.eye(N)):.2e}")

    # trilinear symmetry of T(A,B,C) = <A, B(B,C)> polarised
    n = 6
    N = n * (n - 1) // 2

    def Bil(X, Y):
        return 0.5 * (Qm(X + Y, n) - Qm(X, n) - Qm(Y, n))

    Xs = []
    for _ in range(3):
        A = rng.normal(size=(N, N))
        Xs.append((A + A.T) / 2)
    vals = [fro(Xs[p[0]], Bil(Xs[p[1]], Xs[p[2]]))
            for p in itertools.permutations(range(3))]
    print(f"  n=6:  trilinear-symmetry spread of T(A,B,C) = {max(vals)-min(vals):.2e}")

    # Alt is an idempotent self-adjoint projection; Weyl projection really lands in W_n
    A = rng.normal(size=(N, N))
    M = (A + A.T) / 2
    P1 = alt_m(M, n)
    print(f"  n=6:  ||Alt^2 - Alt|| = {nrm(alt_m(P1, n) - P1):.2e},  "
          f"self-adjointness |<Alt X,Y>-<X,Alt Y>| = "
          f"{abs(fro(P1, Xs[0]) - fro(M, alt_m(Xs[0], n))):.2e}")
    for n2 in (6, 8, 12):
        W = rand_weyl(n2, rng)
        print(f"  n={n2}: random Weyl tensor  ||Ric(W)||={nrm(ric_m(W, n2)):.2e}  "
              f"||Alt(W)||={nrm(alt_m(W, n2)):.2e}  dim check |W|=1: {nrm(W):.6f}")

    # scal(R^2+R^#) = ||Ric||^2 + 6||Alt||^2  (Reviewer 6's identity, pins normalisation)
    for n2 in (5, 6, 7):
        N2 = n2 * (n2 - 1) // 2
        A = rng.normal(size=(N2, N2))
        M = (A + A.T) / 2
        lhs = 2 * np.trace(Qm(M, n2))
        rhs = nrm(ric_m(M, n2)) ** 2 + 6 * nrm(alt_m(M, n2)) ** 2
        print(f"  n={n2}:  scal(Q(R)) - (||Ric||^2 + 6||Alt||^2) = {lhs-rhs:.3e}")
    print()


# --------------------------------------------------------------------------
# named critical points, all built here from scratch
# --------------------------------------------------------------------------


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def sphere_product(n, p):
    """Coordinate-diagonal Weyl tensor of S^p x S^q, unit norm."""
    q = n - p
    prs = pairs_of(n)
    N = len(prs)
    x, y, z = 1.0 / (p * (p - 1)), 1.0 / (q * (q - 1)), -1.0 / (p * q)
    lam = np.empty(N)
    for a, (i, j) in enumerate(prs):
        lam[a] = x if (i < p and j < p) else (y if (i >= p and j >= p) else z)
    W = np.diag(lam)
    return W / nrm(W)


def sd_forms(n):
    """Orthonormal self-dual 2-forms of the distinguished R^4 = span(e_0..e_3)."""
    prs = pairs_of(n)
    pos = {p: k for k, p in enumerate(prs)}
    N = len(prs)
    out = []
    for (a, b), (c, d) in [(((0, 1), (2, 3))), (((0, 2), (3, 1))), (((0, 3), (1, 2)))]:
        v = np.zeros(N)
        v[pos[(a, b)]] += 1.0 / np.sqrt(2)
        s = 1.0
        cc, dd = c, d
        if cc > dd:
            cc, dd, s = dd, cc, -1.0
        v[pos[(cc, dd)]] += s / np.sqrt(2)
        out.append(v)
    return out


def asd_forms(n):
    prs = pairs_of(n)
    pos = {p: k for k, p in enumerate(prs)}
    N = len(prs)
    out = []
    for (a, b), (c, d) in [(((0, 1), (3, 2))), (((0, 2), (1, 3))), (((0, 3), (2, 1)))]:
        v = np.zeros(N)
        v[pos[(a, b)]] += 1.0 / np.sqrt(2)
        s = 1.0
        cc, dd = c, d
        if cc > dd:
            cc, dd, s = dd, cc, -1.0
        v[pos[(cc, dd)]] += s / np.sqrt(2)
        out.append(v)
    return out


def fox_S4(n):
    """S^4(alpha): (2,-1,-1,0,...)/sqrt6 on the self-dual 3-space of R^4."""
    om = sd_forms(n)
    W = (2 * np.outer(om[0], om[0]) - np.outer(om[1], om[1]) - np.outer(om[2], om[2]))
    return W / np.sqrt(6.0)


def su3_biinvariant(n=8):
    """W ~ Pi_h - (r/N) Id for h = su(3) acting on R^8 by the adjoint rep."""
    f = np.zeros((8, 8, 8))

    def setf(a, b, c, v):
        for perm, sgn in [((a, b, c), 1), ((b, c, a), 1), ((c, a, b), 1),
                          ((b, a, c), -1), ((a, c, b), -1), ((c, b, a), -1)]:
            f[perm[0] - 1, perm[1] - 1, perm[2] - 1] = sgn * v

    setf(1, 2, 3, 1.0)
    setf(1, 4, 7, 0.5)
    setf(1, 5, 6, -0.5)
    setf(2, 4, 6, 0.5)
    setf(2, 5, 7, 0.5)
    setf(3, 4, 5, 0.5)
    setf(3, 6, 7, -0.5)
    setf(4, 5, 8, np.sqrt(3) / 2)
    setf(6, 7, 8, np.sqrt(3) / 2)
    prs = pairs_of(n)
    pos = {p: k for k, p in enumerate(prs)}
    N = len(prs)
    cols = []
    for a in range(8):
        A = f[a]                      # A[b,c] = f_abc, antisymmetric in b,c
        v = np.array([A[j, i] for (i, j) in prs])
        cols.append(v)
    Bm = np.array(cols).T
    Uo, s, _ = np.linalg.svd(Bm, full_matrices=False)
    r = int(np.sum(s > 1e-9 * s[0]))
    Pi = Uo[:, :r] @ Uo[:, :r].T
    W = Pi - (r / N) * np.eye(N)
    return W / nrm(W), r


def rotate(W, n, g):
    T = mat_to_tensor(W, n)
    T2 = np.einsum("ia,jb,kc,ld,abcd->ijkl", g, g, g, g, T, optimize=True)
    return tensor_to_mat(T2, n)


def random_rotation(n, rng):
    A = rng.normal(size=(n, n))
    g, _ = np.linalg.qr(A)
    return g


def crit_residual(W, n):
    Q = Qm(W, n)
    th = fro(W, Q)
    return th, nrm(Q - th * W)


def generic_critical(n, rng, tries=14, tol=1e-9):
    """Find generic (symmetry-free) critical points by minimising the idempotency residual."""
    from scipy.optimize import minimize
    N = n * (n - 1) // 2
    basisless = []                      # work in coordinates of W_n via projection
    out = []
    for _ in range(tries):
        W0 = rand_weyl(n, rng)

        def f(x):
            M = weyl_project(_sym(x, N), n)
            nn = nrm(M)
            if nn < 1e-12:
                return 1e6
            M = M / nn
            Q = Qm(M, n)
            th = fro(M, Q)
            return nrm(Q - th * M) ** 2

        x0 = _unsym(W0, N)
        res = minimize(f, x0, method="L-BFGS-B",
                       options=dict(maxiter=1500, maxfun=20000, ftol=1e-18, gtol=1e-12))
        M = weyl_project(_sym(res.x, N), n)
        if nrm(M) < 1e-9:
            continue
        M = M / nrm(M)
        th, rr = crit_residual(M, n)
        if rr < 1e-7 and abs(th) > 1e-3:
            out.append((M, th, rr))
    del basisless
    return out


def _sym(x, N):
    M = np.zeros((N, N))
    iu = np.triu_indices(N)
    M[iu] = x
    return M + M.T - np.diag(np.diag(M))


def _unsym(M, N):
    iu = np.triu_indices(N)
    return M[iu].copy()


def catalogue(rng, want12=True):
    """A structurally diverse list of (label, n, W) critical points."""
    out = []
    for (n, p) in [(6, 3), (8, 4), (8, 3), (12, 6), (12, 5), (14, 7)]:
        out.append((f"S^{p}xS^{n-p}", n, sphere_product(n, p)))
    for (n, p) in [(8, 4), (12, 6)]:
        g = random_rotation(n, rng)
        out.append((f"S^{p}xS^{n-p} rotated", n, rotate(sphere_product(n, p), n, g)))
    for n in (6, 8, 12):
        out.append((f"S^4(alpha) Fox", n, fox_S4(n)))
    W, r = su3_biinvariant(8)
    out.append(("SU(3) bi-invariant", 8, W))
    g = random_rotation(8, rng)
    out.append(("SU(3) rotated", 8, rotate(W, 8, g)))
    if want12:
        # zero-pad SU(3) into n=12
        N12 = 66
        prs8, prs12 = pairs_of(8), pairs_of(12)
        pos12 = {p: k for k, p in enumerate(prs12)}
        Wp = np.zeros((N12, N12))
        for a, pa in enumerate(prs8):
            for b, pb in enumerate(prs8):
                Wp[pos12[pa], pos12[pb]] = W[a, b]
        out.append(("SU(3) padded to n=12", 12, Wp))
    return out


# --------------------------------------------------------------------------
# 1.  Claim 2 -- the Gram identification  D(R) = (3/2) Gram(Alt R)
# --------------------------------------------------------------------------


def D_of(M, n):
    T = mat_to_tensor(M, n)
    Q = M @ M + tensor_to_mat(sharp_t(T), n)
    rc = ric_t(T)
    return ric_m(Q, n) - rdot(T, rc)


def gram_alt(M, n):
    al = alt_t(mat_to_tensor(M, n))
    return np.einsum("iklm,jklm->ij", al, al, optimize=True)


def section1():
    """FINDINGS Result 2 flags "a symbolic index-computation proof ... a page of work
    not yet written".  Here it is; the numbers below check every step of it.

    Write A_ab = sum_{jpq} R_ajpq R_bjpq  and  B_ab = sum_{xyz} R_axyz R_yxbz.
    Only the S^2(Lambda^2) symmetries R_ijkl = -R_jikl = -R_ijlk = R_klij are used,
    so nothing below depends on n or on the first Bianchi identity.

    Step 1 (the Ricci terms cancel).
      Ric(R^2)_ik = sum_j (R^2)_ijkj = (1/2) sum_{jpq} R_ijpq R_pqkj = (1/2) A_ik,
      using (R^2)_ijkl = (1/2) sum_{pq} R_ijpq R_pqkl and R_pqkj = R_kjpq.
      Ric(R^#)_ik = sum_{pq} R_ipkq Ric_pq  -  sum_{jpq} R_ipjq R_jpkq
                  = (R.Ric)_ik - B_ik,
      because sum_j R_jpjq = Ric_pq and R_ipkq = R_piqk = T_R(p,i,q,k).
      Hence  D(R) = Ric(R^2+R^#) - R.Ric  =  A/2 - B,  the (R.Ric) terms cancelling.

    Step 2 (the Gram side).  With alpha = Alt(R), alpha_ajpq is the average over the
      cyclic group C_3 acting on the last three slots.  Since every index is summed,
      relabelling by sigma^{-1} shows the 9 terms of the product collapse to 3 copies
      of each rho in C_3:
        3 Gram(alpha)_ab = A_ab + G1_ab + G2_ab,   G_rho,ab = sum R_ajpq R_b rho(jpq).
      So (3/2) Gram = (1/2)(A + G1 + G2).

    Step 3 (identify G1 and G2).
      G1_ab = sum_{jpq} R_ajpq R_bpqj.  Rename (j,p,q) -> (x,z,y):
        G1_ab = sum R_axzy R_bzyx = -sum R_axyz R_bzyx = -B_ab,
      using R_bzyx = R_yxbz (pair swap), so B_ab = sum R_axyz R_bzyx.
      G2_ab = sum R_ajpq R_bqjp = G1_ba by the substitution (j,p,q) -> (p,q,j).
      And B is symmetric: renaming x <-> z in B_ba returns B_ab.
      Therefore G1 = G2 = -B, and (3/2) Gram = (1/2)(A - 2B) = A/2 - B = D(R).  QED

    Corollary (Reviewer 6's identity, now with a proof): tr(R.Ric) = ||Ric||^2, so
      scal(R^2+R^#) = ||Ric||^2 + tr D = ||Ric||^2 + (3/2) sum_{ijkl} alpha_ijkl^2
                    = ||Ric||^2 + 6||Alt R||^2,
    the 6 coming from ||X||^2 = (1/4) sum_{ijkl} X_ijkl^2 for operator norms.
    """
    print("=" * 78)
    print("1.  CLAIM 2   D(R) = (3/2) * Gram(Alt R)")
    print("=" * 78)
    rng = np.random.default_rng(7)
    print("  (a) fitted constant on random symmetric / PSD / Weyl operators")
    for n in (5, 6, 7, 8):
        N = n * (n - 1) // 2
        cs = []
        for kind in ("sym", "psd", "weyl+alt"):
            for _ in range(6):
                A = rng.normal(size=(N, N))
                if kind == "sym":
                    M = (A + A.T) / 2
                elif kind == "psd":
                    M = A @ A.T
                else:
                    M = rand_weyl(n, rng) + 0.7 * (A + A.T) / 2
                D = D_of(M, n)
                G = gram_alt(M, n)
                if nrm(G) < 1e-12:
                    continue
                cs.append(fro(D, G) / fro(G, G))
                rel = nrm(D - 1.5 * G) / max(nrm(D), 1e-30)
        cs = np.array(cs)
        print(f"    n={n}: fitted c = {cs.mean():.12f}  spread {cs.max()-cs.min():.2e}"
              f"   worst rel. residual of D-1.5G = {rel:.2e}")

    print("  (b) exact rational verification (Fraction arithmetic, integer operators)")
    for n in (5, 6):
        ok = _exact_gram_check(n, seed=3 + n)
        print(f"    n={n}: 6*D == exact integer Gram form, all entries equal: {ok}")

    print("  (c) the two structural lemmas the symbolic proof rests on")
    for n in (5, 6, 7):
        N = n * (n - 1) // 2
        A = rng.normal(size=(N, N))
        M = (A + A.T) / 2
        T = mat_to_tensor(M, n)
        Amat = np.einsum("ajpq,bjpq->ab", T, T, optimize=True)
        Bmat = np.einsum("axyz,yxbz->ab", T, T, optimize=True)
        G1 = np.einsum("ajpq,bpqj->ab", T, T, optimize=True)
        D = D_of(M, n)
        print(f"    n={n}: ||D - (A/2 - B)||={nrm(D - (Amat/2 - Bmat)):.2e}   "
              f"||G1 + B||={nrm(G1 + Bmat):.2e}   ||B - B^T||={nrm(Bmat - Bmat.T):.2e}")

    print("  (d) trace corollary  tr D = 6||Alt R||^2  (Reviewer 6's scal identity)")
    for n in (5, 6, 8):
        N = n * (n - 1) // 2
        A = rng.normal(size=(N, N))
        M = (A + A.T) / 2
        print(f"    n={n}: tr D - 6||Alt||^2 = {np.trace(D_of(M, n)) - 6*nrm(alt_m(M, n))**2:.3e}")

    print("  (e) D(R) >= 0 (Gram) on 200 random symmetric + 200 random PSD operators")
    worst = 0.0
    for n in (5, 6, 7):
        N = n * (n - 1) // 2
        for _ in range(70):
            A = rng.normal(size=(N, N))
            for M in ((A + A.T) / 2, A @ A.T):
                worst = min(worst, float(np.linalg.eigvalsh(D_of(M, n)).min()) / max(nrm(D_of(M, n)), 1e-30))
    print(f"    worst normalised min-eigenvalue of D over 420 operators: {worst:.2e}")
    print()


def _exact_gram_check(n, seed):
    """6*D(R) computed exactly in Fraction arithmetic vs the Gram form, integer R."""
    rng = np.random.default_rng(seed)
    prs = pairs_of(n)
    N = len(prs)
    Mi = rng.integers(-3, 4, size=(N, N))
    Mi = Mi + Mi.T
    T = {}
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            v = int(Mi[a, b])
            T[(i, j, k, l)] = v
            T[(j, i, k, l)] = -v
            T[(i, j, l, k)] = -v
            T[(j, i, l, k)] = v

    def t(i, j, k, l):
        return T.get((i, j, k, l), 0)

    R = range(n)
    # A_ab = sum t(a,j,p,q) t(b,j,p,q) ; B_ab = sum t(a,x,y,z) t(y,x,b,z)
    Amat = [[0] * n for _ in R]
    Bmat = [[0] * n for _ in R]
    for a in R:
        for b in R:
            sa = sb = 0
            for x in R:
                for y in R:
                    for z in R:
                        sa += t(a, x, y, z) * t(b, x, y, z)
                        sb += t(a, x, y, z) * t(y, x, b, z)
            Amat[a][b] = sa
            Bmat[a][b] = sb
    # D from its definition, exactly
    Dexact = [[Fraction(Amat[a][b], 2) - Bmat[a][b] for b in R] for a in R]
    # Gram of Alt
    def al(i, j, k, l):
        return Fraction(t(i, j, k, l) + t(i, k, l, j) + t(i, l, j, k), 3)
    Gexact = [[sum(al(a, x, y, z) * al(b, x, y, z) for x in R for y in R for z in R)
               for b in R] for a in R]
    ok = all(Dexact[a][b] == Fraction(3, 2) * Gexact[a][b] for a in R for b in R)
    # and cross-check D's *definitional* form (Ric(R^2+R^#) - R.Ric) numerically
    Mf = Mi.astype(float)
    Dnum = D_of(Mf, n)
    ok2 = np.max(np.abs(Dnum - np.array([[float(Dexact[a][b]) for b in R] for a in R]))) < 1e-6 * max(
        1.0, np.max(np.abs(Dnum)))
    return bool(ok and ok2)


# --------------------------------------------------------------------------
# 2.  Claim 1 -- the exact lifted master identity of section 3.3
# --------------------------------------------------------------------------


def identity_terms(W, n, tol=1e-9):
    sp = spectral_parts(W, tol)
    absW, Wm, Pp, Pm = sp["absM"], sp["Wm"], sp["Pp"], sp["Pm"]
    Q = Qm(W, n)
    theta = fro(W, Q)
    resid = nrm(Q - theta * W)
    Ric = ric_m(absW, n)
    r = nrm(Ric)
    S = Ric / r if r > 0 else Ric
    G = tensor_to_mat(kn(Ric, Ric), n)               # full KN, ||G|| = sqrt2 r^2 sqrt(1-trS^4)
    Ghat = G / nrm(G)
    c = fro(absW, Ghat)
    e2 = 1.0 - c * c
    trS4 = float(np.trace(np.linalg.matrix_power(S, 4)))
    term1_text = np.sqrt(2.0) * r ** 2 * np.sqrt(max(0.0, 1 - trS4)) * np.sqrt(max(0.0, 1 - e2))
    term1_deriv = fro(absW, G)
    term2 = -2.0 * fro(ric_m(Wm @ Wm, n), Ric)
    J4 = fro(D_of(absW, n), Ric)
    Xinv = sharp_m(absW, n) - Pp @ sharp_m(W, n) @ Pp + Pm @ sharp_m(W, n) @ Pm
    J5 = fro(ric_m(Xinv, n), Ric)
    return dict(theta=theta, resid=resid, r=r, e2=e2, c=c, trS4=trS4,
                t1=term1_text, t1d=term1_deriv, t2=term2, J4=J4, J5=J5,
                lhs=theta * r * r, Xinv=Xinv, absW=absW, Wm=Wm, Ric=Ric,
                delta2=nrm(alt_m(Wm, n)) ** 2, normG=nrm(G))


def section2(rng=None):
    print("=" * 78)
    print("2.  CLAIM 1   theta r^2 = sqrt2 r^2 sqrt(1-trS^4) sqrt(1-e^2)"
          " - 2<Ric(W_-^2),Ric> + J4 - J5")
    print("=" * 78)
    rng = rng or np.random.default_rng(11)
    cat = catalogue(rng)
    print(f"  {'point':26s} {'n':>3s} {'theta':>10s} {'critres':>9s} "
          f"{'residual':>10s} {'relres':>9s} {'J4':>9s} {'J5':>9s} {'delta^2':>9s}")
    worst_abs = worst_rel = 0.0
    rows = []
    for (lab, n, W) in cat:
        d = identity_terms(W, n)
        rhs = d["t1"] + d["t2"] + d["J4"] - d["J5"]
        res = d["lhs"] - rhs
        scale = max(abs(d["lhs"]), abs(d["t1"]), abs(d["t2"]), 1e-30)
        rows.append((lab, n, d, res, res / scale))
        worst_abs = max(worst_abs, abs(res))
        worst_rel = max(worst_rel, abs(res / scale))
        print(f"  {lab:26s} {n:3d} {d['theta']:10.6f} {d['resid']:9.2e} "
              f"{res:10.2e} {res/scale:9.2e} {d['J4']:9.4f} {d['J5']:9.4f} {d['delta2']:9.5f}")
    print(f"  --> worst absolute residual {worst_abs:.2e}, worst relative {worst_rel:.2e}")

    print("  the 'sqrt2 r^2 sqrt(1-trS^4)' factor really is ||Ric x Ric||:")
    for (lab, n, d, _, _) in rows[:4]:
        pred = np.sqrt(2.0) * d["r"] ** 2 * np.sqrt(max(0.0, 1 - d["trS4"]))
        print(f"    {lab:26s} ||Ric x Ric||={d['normG']:.8f}  sqrt2 r^2 sqrt(1-trS^4)={pred:.8f}"
              f"   <|W|,Ric x Ric> - term1_text = {d['t1d']-d['t1']:.2e}   c={d['c']:+.6f}")

    print("  generic (symmetry-free) critical points found by residual minimisation, n=6:")
    try:
        gens = generic_critical(6, np.random.default_rng(5), tries=10)
    except Exception as exc:                                   # scipy missing etc.
        gens = []
        print("    (skipped:", exc, ")")
    seen = []
    for (M, th, rr) in gens:
        if any(abs(th - t) < 1e-6 for t in seen):
            continue
        seen.append(th)
        d = identity_terms(M, 6)
        rhs = d["t1"] + d["t2"] + d["J4"] - d["J5"]
        print(f"    theta={th:9.6f} critres={rr:.1e}  identity residual={d['lhs']-rhs:+.2e}"
              f"  J5={d['J5']:+.5f}  delta^2={d['delta2']:.5f}")

    print("  same identity at NON-critical points (does criticality matter?):")
    for n in (6, 8):
        W = rand_weyl(n, np.random.default_rng(2 + n))
        d = identity_terms(W, n)
        rhs = d["t1"] + d["t2"] + d["J4"] - d["J5"]
        print(f"    n={n} random Weyl (critres={d['resid']:.2e}): residual = {d['lhs']-rhs:+.4e}")
    print()


# --------------------------------------------------------------------------
# 3.  Claim 3 -- the Fox first-order protection lemma
# --------------------------------------------------------------------------


def section3():
    print("=" * 78)
    print("3.  CLAIM 3   Fox first-order protection lemma")
    print("=" * 78)
    for n in (8, 12):
        print(f"  --- n={n} ---")
        W = fox_S4(n)
        N = n * (n - 1) // 2
        om, eta = sd_forms(n), asd_forms(n)
        w = np.linalg.eigvalsh(W)
        nz = np.sort(w[np.abs(w) > 1e-10])
        print(f"    ||W||={nrm(W):.10f}  nonzero spectrum {np.round(nz*np.sqrt(6),10)}/sqrt6"
              f"  (zeros: {N-len(nz)})")
        th, rr = crit_residual(W, n)
        print(f"    P(W) = {th:.10f}   sqrt(3/2) = {np.sqrt(1.5):.10f}   crit residual {rr:.2e}")
        print(f"    ||Ric(W)|| = {nrm(ric_m(W, n)):.2e}   ||Alt(W)|| = {nrm(alt_m(W, n)):.2e}")

        sp = spectral_parts(W)
        Wm = sp["Wm"]
        star = tensor_to_mat(_star_tensor(n), n)
        AW = alt_m(Wm, n)
        a_fit = fro(AW, star) / fro(star, star)
        print(f"    Alt(W_-) = a * star with a = {a_fit:.12f}, 1/(3 sqrt6) = "
              f"{1/(3*np.sqrt(6)):.12f};  ||Alt(W_-) - a*star|| = {nrm(AW - a_fit*star):.2e}")
        print(f"    delta^2 = ||Alt(W_-)||^2 = {nrm(AW)**2:.12f}   (1/9 = {1/9:.12f})")
        a = a_fit

        # tangent directions: Weyl, unit, orthogonal to W
        rng = np.random.default_rng(100 + n)
        Pi_asd = sum(np.outer(v, v) for v in eta)
        P0 = sp["P0"]
        dirs = []
        for _ in range(6):
            H = rand_weyl(n, rng)
            H = H - fro(H, W) * W
            dirs.append(("random", H / nrm(H)))
        # engineered directions pushing B negative / positive definite
        for sgn, name in ((-1.0, "B<<0 engineered"), (+1.0, "B>>0 engineered")):
            H = weyl_project(sgn * Pi_asd, n)
            H = H - fro(H, W) * W
            if nrm(H) > 1e-9:
                dirs.append((name, H / nrm(H)))
        for _ in range(3):
            H0 = rand_weyl(rng=rng, n=n)
            H = weyl_project(H0 - 3.0 * Pi_asd @ H0 @ Pi_asd - 2.0 * Pi_asd, n)
            H = H - fro(H, W) * W
            dirs.append(("mixed engineered", H / nrm(H)))
        # O(n)-orbit tangents  H = [ad(phi), W]
        for _ in range(3):
            A = rng.normal(size=(n, n))
            A = A - A.T
            ad = _ad_on_lambda2(A, n)
            H = ad @ W - W @ ad
            if nrm(H) > 1e-9:
                H = H - fro(H, W) * W
                dirs.append(("O(n)-orbit tangent", H / nrm(H)))

        print(f"    {'direction':22s} {'F(H)':>11s} {'-2aF':>11s} {'fd d+delta2':>13s} "
              f"{'err':>9s} {'chain lo':>10s} {'ok':>4s}")
        worst_fd = 0.0
        for (name, H) in dirs:
            H22 = float(om[1] @ H @ om[1])
            H33 = float(om[2] @ H @ om[2])
            H11 = float(om[0] @ H @ om[0])
            M0 = P0 @ H @ P0
            M0m = _neg_part(M0)
            sliver = float(np.trace(Pi_asd @ M0m))
            F = H22 + H33 + sliver
            B = Pi_asd @ H @ Pi_asd
            Bp, Bm = _pos_part(B), _neg_part(B)
            lo = (2.0 / 3.0) * np.trace(Bp) + (1.0 / 3.0) * np.trace(Bm)
            # one-sided finite difference of delta^2
            t = 1e-6
            d2p = nrm(alt_m(spectral_parts(W + t * H)["Wm"], n)) ** 2
            d20 = nrm(AW) ** 2
            fd = (d2p - d20) / t
            err = abs(fd - (-2 * a * F))
            worst_fd = max(worst_fd, err)
            print(f"    {name:22s} {F:11.6f} {-2*a*F:11.6f} {fd:13.6f} {err:9.1e} "
                  f"{lo:10.6f} {'OK' if F >= lo - 1e-9 and lo >= -1e-9 else 'FAIL':>4s}")
        print(f"    worst one-sided finite-difference error: {worst_fd:.2e} (truncation level)")

        # ingredient (d): Bianchi + tangency
        print("    ingredient (d): Bianchi <H,star>=0 and tangency 2H11=H22+H33")
        wb = wt = 0.0
        for (name, H) in dirs:
            H11 = float(om[0] @ H @ om[0]); H22 = float(om[1] @ H @ om[1]); H33 = float(om[2] @ H @ om[2])
            B = Pi_asd @ H @ Pi_asd
            wb = max(wb, abs(H11 + H22 + H33 - np.trace(B)), abs(fro(H, star)))
            wt = max(wt, abs(2 * H11 - H22 - H33))
            wb = max(wb, abs(H22 + H33 - (2.0 / 3.0) * np.trace(B)))
        print(f"      worst |H11+H22+H33 - tr B| and |<H,star>| = {wb:.2e};  "
              f"worst |2H11-(H22+H33)| = {wt:.2e}")

        # ingredient (c): Jensen  tr(Pi_ASD M_-) >= tr(B_-)
        worstj = 1e9
        for _ in range(400):
            H = rand_weyl(n, rng)
            H = H - fro(H, W) * W
            M0m = _neg_part(P0 @ H @ P0)
            B = Pi_asd @ H @ Pi_asd
            worstj = min(worstj, float(np.trace(Pi_asd @ M0m) - np.trace(_neg_part(B))))
        print(f"      Jensen margin tr(Pi_ASD (P0 H P0)_-) - tr(B_-): min over 400 = {worstj:.2e}")

        # adversarial minimisation of F over the tangent space
        rnd = 1e18
        for _ in range(2000):
            Hr = rand_weyl(n, rng)
            Hr = Hr - fro(Hr, W) * W
            if nrm(Hr) > 1e-12:
                rnd = min(rnd, _F_of(Hr / nrm(Hr), W, om, Pi_asd, P0))
        best = _minimise_F(W, n, om, Pi_asd, P0, rng, restarts=25, iters=1500)
        print(f"    min F over 2000 RANDOM unit tangent directions : {rnd:.6f}")
        print(f"    min F by directed convex descent (25 restarts) : {best:.3e}"
              f"   <-- FINDINGS reports a floor of +0.15")

        # a large equality family FINDINGS does not name: W_{n-4} padded into the
        # complementary block is entirely inside ker W, has B = 0 and no ASD sliver
        m = n - 4
        if m >= 4:
            prs_n = pairs_of(n)
            posn = {p: k for k, p in enumerate(prs_n)}
            prs_m = pairs_of(m)
            wf = 0.0
            for _ in range(20):
                Wm_ = rand_weyl(m, rng)
                Hpad = np.zeros((N, N))
                for a2, (i2, j2) in enumerate(prs_m):
                    for b2, (k2, l2) in enumerate(prs_m):
                        Hpad[posn[(i2 + 4, j2 + 4)], posn[(k2 + 4, l2 + 4)]] = Wm_[a2, b2]
                assert nrm(ric_m(Hpad, n)) < 1e-11 and nrm(alt_m(Hpad, n)) < 1e-11
                Hpad = Hpad - fro(Hpad, W) * W
                wf = max(wf, abs(_F_of(Hpad / nrm(Hpad), W, om, Pi_asd, P0)))
            dimW = (m + 2) * (m + 1) * m * (m - 3) // 12
            print(f"    padded W_{m} (dim {dimW}) lies in the equality set: max|F| = {wf:.2e}")
    print()


def _star_tensor(n):
    T = np.zeros((n, n, n, n))
    for perm in itertools.permutations(range(4)):
        sgn = _sign(perm)
        T[perm[0], perm[1], perm[2], perm[3]] = sgn
    return T


def _sign(p):
    s = 1
    p = list(p)
    for i in range(len(p)):
        for j in range(i + 1, len(p)):
            if p[i] > p[j]:
                s = -s
    return s


def _ad_on_lambda2(A, n):
    """Infinitesimal O(n) action on Lambda^2 in the pair basis."""
    prs = pairs_of(n)
    N = len(prs)
    M = np.zeros((N, N))
    pos = {p: k for k, p in enumerate(prs)}
    for a, (i, j) in enumerate(prs):
        for k in range(n):
            if k != j:
                p, s = (min(k, j), max(k, j)), (1.0 if k < j else -1.0)
                if p[0] != p[1]:
                    M[pos[p], a] += s * A[k, i]
            if k != i:
                p, s = (min(i, k), max(i, k)), (1.0 if i < k else -1.0)
                if p[0] != p[1]:
                    M[pos[p], a] += s * A[k, j]
    return M


def _pos_part(X):
    w, V = np.linalg.eigh(X)
    return V @ np.diag(np.maximum(w, 0)) @ V.T


def _neg_part(X):
    w, V = np.linalg.eigh(X)
    return V @ np.diag(np.maximum(-w, 0)) @ V.T


def _F_of(H, W, om, Pi_asd, P0):
    H22 = float(om[1] @ H @ om[1])
    H33 = float(om[2] @ H @ om[2])
    return H22 + H33 + float(np.trace(Pi_asd @ _neg_part(P0 @ H @ P0)))


def _F_subgrad(H, W, n, om, Pi_asd, P0):
    """Subgradient of F.  F is CONVEX and 1-homogeneous on the tangent space:
    H -> H22+H33 is linear and H -> tr(Pi_ASD (P0 H P0)_-) is convex (x_- is a
    convex matrix function, traced against a PSD projection).  So minimising F
    over the unit ball is a convex problem and projected subgradient descent
    certifies the sign of min F globally, unlike a local Powell search."""
    G = np.outer(om[1], om[1]) + np.outer(om[2], om[2])
    M = P0 @ H @ P0
    w, V = np.linalg.eigh(M)
    f = np.maximum(-w, 0.0)
    fp = np.where(w < 0, -1.0, 0.0)
    dw = w[:, None] - w[None, :]
    df = f[:, None] - f[None, :]
    tol = 1e-12 * max(1.0, np.max(np.abs(w)))
    L = np.where(np.abs(dw) > tol, df / np.where(np.abs(dw) > tol, dw, 1.0),
                 0.5 * (fp[:, None] + fp[None, :]))
    Pt = V.T @ Pi_asd @ V
    G = G + P0 @ (V @ (L * Pt) @ V.T) @ P0
    G = weyl_project((G + G.T) / 2.0, n)
    return G - fro(G, W) * W


def _minimise_F(W, n, om, Pi_asd, P0, rng, restarts=8, iters=400):
    """Projected subgradient descent on the convex problem  min F,  ||H|| <= 1."""
    best, bestH = 1e18, None
    for t in range(restarts):
        H = rand_weyl(n, rng)
        if t % 3 == 1:
            H = weyl_project(-Pi_asd, n)
        elif t % 3 == 2:
            H = weyl_project(-Pi_asd @ H @ Pi_asd - 2.0 * Pi_asd, n)
        H = H - fro(H, W) * W
        if nrm(H) < 1e-12:
            continue
        H = H / nrm(H)
        for k in range(iters):
            g = _F_subgrad(H, W, n, om, Pi_asd, P0)
            gn = nrm(g)
            if gn < 1e-14:
                break
            H = H - (2.0 / (k + 3.0)) * g / gn
            H = H / nrm(H)                       # stay on the unit sphere (F is 1-homogeneous)
            val = _F_of(H, W, om, Pi_asd, P0)
            if val < best:
                best, bestH = val, H.copy()
    return best


# --------------------------------------------------------------------------
# 4.  Claim 4 -- the falsification battery's headline numbers
# --------------------------------------------------------------------------


def kappa(n):
    return 9.0 * (np.sqrt(1.5) - theta0(n))


def section4():
    print("=" * 78)
    print("4.  CLAIM 4   kappa_n, equality at both champions, and the n=8 violation")
    print("=" * 78)
    print(f"  {'n':>3s} {'theta0(n)':>12s} {'kappa_n':>12s}")
    for n in (6, 8, 10, 11, 12, 14, 16, 20):
        print(f"  {n:3d} {theta0(n):12.8f} {kappa(n):12.8f}")
    print(f"  crossover: kappa_n = 0 at n = 6+2sqrt7 = {6+2*np.sqrt(7):.6f};  "
          f"kappa_12/kappa_14 ratio = {kappa(14)/kappa(12):.4f}")

    print("  equality at both champions (n=12 and n=14):")
    for n in (12, 14):
        Wst = sphere_product(n, n // 2)
        th, rr = crit_residual(Wst, n)
        d2 = delta2(Wst, n)
        print(f"    n={n}  balanced sphere: P={th:.10f}  theta0={theta0(n):.10f}  "
              f"delta^2={d2:.2e}  bound-P={theta0(n)+kappa(n)*d2-th:+.2e}")
        Wf = fox_S4(n)
        th2, rr2 = crit_residual(Wf, n)
        d22 = delta2(Wf, n)
        print(f"    n={n}  S^4(alpha)    : P={th2:.10f}  sqrt(3/2)={np.sqrt(1.5):.10f}  "
              f"delta^2={d22:.10f}  bound-P={theta0(n)+kappa(n)*d22-th2:+.2e}")

    print("  catalogue margins at n=12 (bound - P, must be >= 0):")
    rng = np.random.default_rng(21)
    for (lab, n, W) in catalogue(rng):
        if n != 12:
            continue
        th, _ = crit_residual(W, n)
        d2 = delta2(W, n)
        print(f"    {lab:26s} P={th:9.6f}  delta^2={d2:9.6f}  margin={theta0(12)+kappa(12)*d2-th:+9.6f}")

    print("  300 random unit Weyl tensors at n=12:")
    mins = []
    for _ in range(300):
        W = rand_weyl(12, rng)
        th = fro(W, Qm(W, 12))
        d2 = delta2(W, 12)
        mins.append(theta0(12) + kappa(12) * d2 - th)
    print(f"    min margin = {min(mins):+.6f}")

    print("  independent ascent on Phi = P - kappa_n delta^2 (own gradient), n=8 then n=12:")
    for n in (8, 12):
        best, bestpt = _ascend_phi(n, seeds=10, iters=220, rng=np.random.default_rng(400 + n))
        margin = best - theta0(n)
        tag = "VIOLATION" if margin > 1e-6 else "no violation"
        print(f"    n={n}: best Phi = {best:.6f}  theta0={theta0(n):.6f}  "
              f"excess={margin:+.6f}  [{tag}]")
        if bestpt is not None and margin > 1e-6:
            W = bestpt
            th = fro(W, Qm(W, n))
            d2 = delta2(W, n)
            _, rr = crit_residual(W, n)
            print(f"        at P={th:.6f}, delta^2={d2:.6f}, criticality residual={rr:.3e} "
                  f"(FINDINGS reports Phi=1.149188, P=1.221305, delta^2=0.101301)")
    print()


def _delta2_grad(W, n):
    """Gradient of delta^2 = ||Alt(W_-)||^2 via Daleckii-Krein; subgradient value -1/2 at 0."""
    w, V = np.linalg.eigh(W)
    N = len(w)
    Wm = V @ np.diag(np.maximum(-w, 0)) @ V.T
    G = alt_m(Wm, n)
    Gt = V.T @ G @ V
    scale = max(1.0, np.max(np.abs(w)))
    tol = 1e-9 * scale
    f = np.maximum(-w, 0.0)
    fp = np.where(w < -tol, -1.0, np.where(w > tol, 0.0, -0.5))
    dw = w[:, None] - w[None, :]
    df = f[:, None] - f[None, :]
    with np.errstate(divide="ignore", invalid="ignore"):
        L = np.where(np.abs(dw) > tol, df / np.where(np.abs(dw) > tol, dw, 1.0),
                     0.5 * (fp[:, None] + fp[None, :]))
    grad = 2.0 * (V @ (L * Gt) @ V.T)
    return grad, nrm(G) ** 2


def _ascend_phi(n, seeds, iters, rng):
    k = kappa(n)
    best, bestpt = -1e18, None
    Wf = fox_S4(n)
    starts = [Wf]
    for _ in range(seeds - 1):
        H = rand_weyl(n, rng)
        s = Wf + 0.15 * (H - fro(H, Wf) * Wf)
        starts.append(s / nrm(s))
    for W in starts:
        W = W / nrm(W)
        step = 0.05
        for _ in range(iters):
            Q = Qm(W, n)
            g2, d2 = _delta2_grad(W, n)
            g = 3.0 * Q - k * g2
            g = weyl_project(g, n)
            g = g - fro(g, W) * W
            gn = nrm(g)
            if gn < 1e-12:
                break
            g = g / gn
            cur = fro(W, Qm(W, n)) - k * d2
            improved = False
            for _ in range(30):
                Wn_ = W + step * g
                Wn_ = weyl_project(Wn_, n)
                Wn_ = Wn_ / nrm(Wn_)
                val = fro(Wn_, Qm(Wn_, n)) - k * delta2(Wn_, n)
                if val > cur + 1e-14:
                    W = Wn_
                    step *= 1.3
                    improved = True
                    break
                step *= 0.5
            if not improved:
                break
        val = fro(W, Qm(W, n)) - k * delta2(W, n)
        if val > best:
            best, bestpt = val, W
    return best, bestpt


# --------------------------------------------------------------------------
# 5.  Claim 5 -- the lifted Lemma 3.4.6 for all PSD R
# --------------------------------------------------------------------------


def lemma346_terms(R, n, eps):
    Ric = ric_m(R, n)
    lam = float(np.trace(Ric)) / n
    Ric0 = Ric - lam * np.eye(n)
    RR = tensor_to_mat(kn(Ric, Ric), n) / 2.0      # Ric ^ Ric,   diag entry lam_i lam_j
    Rid = tensor_to_mat(kn(Ric, np.eye(n)), n)     # Ric ^ 2 id,  diag entry lam_i + lam_j
    lhs = float(np.trace(R @ RR @ Rid))
    rhs = (n * lam ** 4 + lam ** 2 * (2 - eps) * nrm(Ric0) ** 2
           - lam * (1 + eps) * float(np.trace(np.linalg.matrix_power(Ric0, 3))))
    return lhs, rhs, lam, Ric


def section5():
    print("=" * 78)
    print("5.  CLAIM 5   lifted Lemma 3.4.6 for every PSD R")
    print("=" * 78)
    eps0 = (np.sqrt(10) - 3) / 2
    print(f"  eps_0 = (sqrt10-3)/2 = {eps0:.10f}")

    print("  (a) sanity: R = Id gives exact equality (any eps, since Ric_0 = 0)")
    for n in (5, 6, 8):
        N = n * (n - 1) // 2
        lhs, rhs, lam, _ = lemma346_terms(np.eye(N), n, eps0)
        print(f"    n={n}: lhs={lhs:.6f} rhs={rhs:.6f} diff={lhs-rhs:.2e}  "
              f"(n(n-1)^4 = {n*(n-1)**4})")

    print("  (b) the LHS really only sees the diagonal of R in the Ric eigenbasis")
    rng = np.random.default_rng(31)
    for n in (5, 6, 7):
        N = n * (n - 1) // 2
        A = rng.normal(size=(N, N))
        R = A @ A.T
        Ric = ric_m(R, n)
        _, U = np.linalg.eigh(Ric)
        Rrot = rotate(R, n, U.T)                      # Ric becomes diagonal
        RRr = ric_m(Rrot, n)
        lam = np.diag(RRr)
        lhs, _, _, _ = lemma346_terms(R, n, eps0)
        prs = pairs_of(n)
        by_diag = sum(Rrot[a, a] * lam[i] * lam[j] * (lam[i] + lam[j]) for a, (i, j) in enumerate(prs))
        offd = nrm(Rrot - np.diag(np.diag(Rrot)))
        print(f"    n={n}: |lhs - sum_{{i<j}} R_ii,jj lam_i lam_j (lam_i+lam_j)| = "
              f"{abs(lhs-by_diag):.2e}   (||offdiag R|| = {offd:.3f}, so this is not vacuous)")

    print("  (c) random PSD operators with large Bianchi defect")
    for n in (5, 6, 7, 8):
        N = n * (n - 1) // 2
        worst, worstdef = 1e18, 0.0
        for _ in range(150):
            A = rng.normal(size=(N, N))
            R = A @ A.T
            R = R / nrm(R)
            lhs, rhs, lam, _ = lemma346_terms(R, n, eps0)
            defrac = nrm(alt_m(R, n)) / nrm(R)
            sc = max(abs(lhs), abs(rhs), 1e-30)
            worst = min(worst, (lhs - rhs) / sc)
            worstdef = max(worstdef, defrac)
        print(f"    n={n}: min normalised margin over 150 PSD R = {worst:+.4f}, "
              f"max Bianchi-defect fraction {worstdef:.3f}")

    print("  (d) the exact scalar reduction: R -> hollow nonneg d (diag in Ric eigenbasis),")
    print("      lam_i = row sums.  Adversarial minimisation of the margin over d >= 0:")
    from scipy.optimize import minimize
    for n in (4, 5, 6, 8, 12):
        prs = pairs_of(n)

        def margin(y, eps):
            d = y ** 2
            lam = np.zeros(n)
            for a, (i, j) in enumerate(prs):
                lam[i] += d[a]
                lam[j] += d[a]
            s = lam.sum()
            if s <= 1e-12:
                return 0.0
            lam = lam / s * n          # normalise mean lam to 1
            d = d / s * n
            lb = 1.0
            l0 = lam - lb
            L = sum(d[a] * lam[i] * lam[j] * (lam[i] + lam[j]) for a, (i, j) in enumerate(prs))
            Rh = n * lb ** 4 + lb ** 2 * (2 - eps) * float(l0 @ l0) - lb * (1 + eps) * float((l0 ** 3).sum())
            return L - Rh

        best = 1e18
        rng2 = np.random.default_rng(77 + n)
        for _ in range(30):
            y0 = rng2.random(len(prs)) * (1.0 if rng2.random() < 0.5 else 3.0)
            if rng2.random() < 0.4:
                y0 = y0 * (rng2.random(len(prs)) < 0.4)
                if y0.sum() < 1e-6:
                    continue
            r = minimize(margin, y0, args=(eps0,), method="Nelder-Mead" if n <= 5 else "Powell",
                         options=dict(maxiter=30000, maxfev=60000, xatol=1e-10, fatol=1e-12)
                         if n <= 5 else dict(maxiter=20000, maxfev=60000, xtol=1e-9, ftol=1e-11))
            best = min(best, float(r.fun))
        # show the min of 0 is the genuine equality point d = 1 (R = Id), not a collapse
        rng3 = np.random.default_rng(500 + n)
        vals = []
        for _ in range(1500):
            d = rng3.random(len(prs)) ** int(rng3.integers(1, 6))
            if d.sum() < 1e-9:
                continue
            vals.append(margin(np.sqrt(d), eps0))
        print(f"    n={n:2d}: min margin over d>=0 (mean Ricci eigenvalue normalised to 1) "
              f"= {best:+.8f};  over 1500 random d the margin ranges "
              f"[{min(vals):+.3f}, {max(vals):+.1f}] (median {np.median(vals):+.3f})")

    print("  (e) is eps_0 = (sqrt10-3)/2 tight?  same minimisation at smaller eps:")
    n = 6
    prs = pairs_of(n)

    def margin_eps(y, eps):
        d = y ** 2
        lam = np.zeros(n)
        for a, (i, j) in enumerate(prs):
            lam[i] += d[a]
            lam[j] += d[a]
        s = lam.sum()
        if s <= 1e-12:
            return 0.0
        lam = lam / s * n
        d = d / s * n
        l0 = lam - 1.0
        L = sum(d[a] * lam[i] * lam[j] * (lam[i] + lam[j]) for a, (i, j) in enumerate(prs))
        Rh = n + (2 - eps) * float(l0 @ l0) - (1 + eps) * float((l0 ** 3).sum())
        return L - Rh

    for eps in (eps0, eps0 * 0.9, eps0 * 0.5, 0.0):
        best = 1e18
        rng2 = np.random.default_rng(99)
        for _ in range(30):
            y0 = rng2.random(len(prs)) * 2
            r = minimize(margin_eps, y0, args=(eps,), method="Powell",
                         options=dict(maxiter=20000, maxfev=60000, xtol=1e-9, ftol=1e-11))
            best = min(best, float(r.fun))
        print(f"    eps={eps:.6f}: min margin = {best:+.8f}")

    print("  (f) the two proof steps flagged in the task")
    print("      * (Ric ^ Ric) and (Ric ^ 2 id) diagonal in the induced basis, so tr(RD) sees")
    print("        only diag(R): verified numerically in (b) above.")
    for n in (5, 6):
        N = n * (n - 1) // 2
        A = rng.normal(size=(N, N))
        R = A @ A.T
        Ric = ric_m(R, n)
        _, U = np.linalg.eigh(Ric)
        RRr = rotate(tensor_to_mat(kn(Ric, Ric), n) / 2.0, n, U.T)
        Ridr = rotate(tensor_to_mat(kn(Ric, np.eye(n)), n), n, U.T)
        print(f"        n={n}: offdiag of Ric^Ric in Ric-eigenbasis = "
              f"{nrm(RRr-np.diag(np.diag(RRr))):.2e}, of Ric^2id = "
              f"{nrm(Ridr-np.diag(np.diag(Ridr))):.2e}")
    print("      * 'Ric annihilates Lambda^4 and W': Ric(Alt X) = 0 and Ric(Weyl) = 0, and any")
    print("        coordinate-diagonal comparison operator Rtilde is automatically Bianchi:")
    for n in (5, 6, 8):
        N = n * (n - 1) // 2
        A = rng.normal(size=(N, N))
        X = (A + A.T) / 2
        d = np.diag(rng.normal(size=N))
        print(f"        n={n}: ||Ric(Alt X)||={nrm(ric_m(alt_m(X, n), n)):.2e}  "
              f"||Alt(diagonal op)||={nrm(alt_m(d, n)):.2e}  "
              f"||Ric(Weyl)||={nrm(ric_m(rand_weyl(n, rng), n)):.2e}")
    print("      * <R, h ^ 2 id> = <Ric(R), h> for EVERY symmetric R (Result 6a):")
    for n in (5, 6, 7):
        N = n * (n - 1) // 2
        A = rng.normal(size=(N, N))
        R = (A + A.T) / 2
        h = rng.normal(size=(n, n)); h = h + h.T
        K = tensor_to_mat(kn(h, np.eye(n)), n)
        print(f"        n={n}: <R, h ^ 2 id> - <Ric(R), h> = {fro(R, K) - fro(ric_m(R, n), h):.2e}")
    print()


# --------------------------------------------------------------------------
# 6.  remaining Results of the "Lifting Jaeger's 3.3" section (3, 4, 5, 9)
# --------------------------------------------------------------------------


def bsharp(A, B, n):
    """Polarised #:  A#B = ((A+B)^# - A^# - B^#)/2."""
    return 0.5 * (sharp_m(A + B, n) - sharp_m(A, n) - sharp_m(B, n))


def section6():
    print("=" * 78)
    print("6.  Results 3, 4, 5, 9 of 'Lifting Jaeger's 3.3'")
    print("=" * 78)
    rng = np.random.default_rng(41)
    cat = catalogue(rng)

    print("  Result 3 -- J4 <= 24 delta^2 lam_max(Ric(|W|)), and tr D(|W|) = 24 delta^2")
    print(f"  {'point':26s} {'n':>3s} {'J4':>9s} {'24 d^2 lmax':>12s} {'trD-24d^2':>11s} "
          f"{'(J4-J5)/(d^2 scal)':>19s}")
    for (lab, n, W) in cat:
        d = identity_terms(W, n)
        absW, Ric = d["absW"], d["Ric"]
        D = D_of(absW, n)
        d2 = d["delta2"]
        lmax = float(np.linalg.eigvalsh(Ric).max())
        scal = 2 * float(np.trace(absW))
        ratio = (d["J4"] - d["J5"]) / (d2 * scal) if d2 * scal > 1e-12 else float("nan")
        print(f"  {lab:26s} {n:3d} {d['J4']:9.4f} {24*d2*lmax:12.4f} "
              f"{np.trace(D)-24*d2:11.2e} {ratio:19.6f}")

    print("  Result 5a -- X_inv closed form and its spectral-diagonal blocks")
    worst = dict(cf=0.0, bp=0.0, bm=0.0, b0=0.0, psd=0.0)
    for (lab, n, W) in cat:
        sp = spectral_parts(W)
        Pp, Pm, P0, absW, Wm, Wp = sp["Pp"], sp["Pm"], sp["P0"], sp["absM"], sp["Wm"], sp["Wp"]
        th = fro(W, Qm(W, n))
        Xinv = sharp_m(absW, n) - Pp @ sharp_m(W, n) @ Pp + Pm @ sharp_m(W, n) @ Pm
        worst["cf"] = max(worst["cf"], nrm(Xinv - (sharp_m(absW, n) + (W - th * np.eye(len(W))) @ absW)))
        WpWm = bsharp(Wp, Wm, n)
        worst["bp"] = max(worst["bp"], nrm(Pp @ Xinv @ Pp - 4 * Pp @ WpWm @ Pp))
        worst["bm"] = max(worst["bm"], nrm(Pm @ Xinv @ Pm
                                           - 2 * Pm @ (sharp_m(Wp, n) + sharp_m(Wm, n)) @ Pm))
        worst["b0"] = max(worst["b0"], nrm(P0 @ Xinv @ P0 - P0 @ sharp_m(absW, n) @ P0))
        for Blk in (Pp @ Xinv @ Pp, Pm @ Xinv @ Pm, P0 @ Xinv @ P0):
            worst["psd"] = min(worst["psd"], float(np.linalg.eigvalsh(Blk).min()))
    print(f"    worst ||X_inv - (|W|^# + (W-theta)|W|)||        = {worst['cf']:.2e}")
    print(f"    worst ||P+ X P+ - 4 P+(W_+ # W_-)P+||           = {worst['bp']:.2e}")
    print(f"    worst ||P- X P- - 2 P-(W_+^# + W_-^#)P-||       = {worst['bm']:.2e}")
    print(f"    worst ||P0 X P0 - P0 |W|^# P0||                 = {worst['b0']:.2e}")
    print(f"    worst min-eigenvalue over all three blocks      = {worst['psd']:.2e}")
    print("    (also  |W|^# = W^# + 4 W_+ # W_-  exactly:)")
    for (lab, n, W) in cat[:4]:
        sp = spectral_parts(W)
        print(f"      {lab:26s} residual = "
              f"{nrm(sharp_m(sp['absM'], n) - sharp_m(W, n) - 4*bsharp(sp['Wp'], sp['Wm'], n)):.2e}")

    print("  Result 4 -- the compressions P+ W^# P- = P0 W^# P0 = 0 and the X_inv reduction")
    wc = wr = 0.0
    for (lab, n, W) in cat:
        sp = spectral_parts(W)
        Pp, Pm, P0, absW = sp["Pp"], sp["Pm"], sp["P0"], sp["absM"]
        Wm, Wp = sp["Wm"], sp["Wp"]
        th = fro(W, Qm(W, n))
        Ws = sharp_m(W, n)
        wc = max(wc, nrm(Pp @ Ws @ Pm), nrm(P0 @ Ws @ P0))
        Xinv = sharp_m(absW, n) - Pp @ Ws @ Pp + Pm @ Ws @ Pm
        red = (4 * bsharp(Wp, Wm, n) - 2 * th * Wm - 2 * Wm @ Wm
               + Pp @ Ws @ P0 + P0 @ Ws @ Pp + Pm @ Ws @ P0 + P0 @ Ws @ Pm)
        wr = max(wr, nrm(Xinv - red))
    print(f"    worst ||P+ W^# P-|| and ||P0 W^# P0|| over the catalogue = {wc:.2e}")
    print(f"    worst ||X_inv - (4 W_+#W_- - 2 theta W_- - 2 W_-^2 + cross)|| = {wr:.2e}")

    print("  Result 5b -- J5 = <X_inv, H> with H = Ric*(Ric(|W|)) >= 0, and J5_diag >= 0")
    print(f"  {'point':26s} {'n':>3s} {'J5':>10s} {'<Xinv,H>':>10s} {'J5_diag':>10s} "
          f"{'cross':>11s} {'min eig H':>10s}")
    for (lab, n, W) in cat:
        sp = spectral_parts(W)
        Pp, Pm, P0, absW = sp["Pp"], sp["Pm"], sp["P0"], sp["absM"]
        th = fro(W, Qm(W, n))
        Xinv = sharp_m(absW, n) - Pp @ sharp_m(W, n) @ Pp + Pm @ sharp_m(W, n) @ Pm
        Ric = ric_m(absW, n)
        H = tensor_to_mat(kn(Ric, np.eye(n)), n)      # Ric*(h) = h ^ 2 id
        J5 = fro(ric_m(Xinv, n), Ric)
        J5d = sum(fro(Pb @ Xinv @ Pb, Pb @ H @ Pb) for Pb in (Pp, Pm, P0))
        print(f"  {lab:26s} {n:3d} {J5:10.5f} {fro(Xinv, H):10.5f} {J5d:10.5f} "
              f"{J5-J5d:11.2e} {float(np.linalg.eigvalsh(H).min()):10.5f}")

    print("  Result 9 -- who satisfies Jaeger's Assumption 1 (theta >= theta0(n))?")
    for (lab, n, W) in cat:
        th = fro(W, Qm(W, n))
        print(f"    {lab:26s} n={n:3d} theta={th:9.6f}  theta0={theta0(n):9.6f}  "
              f"{'SATISFIES' if th >= theta0(n)-1e-12 else 'no'}")
    print()


SECTIONS = {"0": section0, "1": section1, "2": section2, "3": section3,
            "4": section4, "5": section5, "6": section6}

if __name__ == "__main__":
    want = sys.argv[1:] or list(SECTIONS)
    for key in want:
        SECTIONS[key]()
