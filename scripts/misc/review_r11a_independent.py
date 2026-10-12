"""Reviewer 11a, independent adversarial audit.

Scope: (1) the graded enumeration, (2) the ungraded measurement, (3) the slack identity.
Everything here is built from findings/INDEX.md's *definitions*, importing nothing from the
pipeline under review. The one permitted cross-check is Q against
scripts/curvature_operator.py's Q_op, used once in section 0 to pin normalisation.

Conventions (own, validated in section 0):
  - Pair basis of Lambda^2 R^n: pairs (i<j); B_(ij) is the antisymmetric matrix with
    entry (i,j) = +1, (j,i) = -1.  A pair-vector v corresponds to the antisym matrix
    V = sum_A v_A B_A, i.e. v_A = V[i,j].  <v,w> = v.w = (1/2) tr(V^T W).
  - Operator = symmetric N x N pair matrix M; 4-tensor dictionary R_{ijkl} = M_{(ij),(kl)}.
  - sharp: (R^#)_{ijkl} = sum_{pq} R_{ipkq} R_{jplq} - R_{iplq} R_{jpkq};  Q = M^2 + M^#.
  - Ric(R)_{ij} = sum_p R_{ipjp};  scal = 2 tr.
  - Alt = Bianchi symmetrisation (1/3)(R_{ijkl}+R_{jkil}+R_{kijl}), the orthogonal
    projection of S^2(Lambda^2) onto Lambda^4; delta^2 = ||Alt(W_-)||_F^2 (pair Frobenius).
  - Spectral parts W = W_+ - W_-, both PSD; E_- spanned by v_i with W v_i = -mu_i v_i.

Sections (run as: python3 review_r11a_independent.py <section> [...]):
  0  validate     core validations + one permitted Q_op cross-check
  1  constructs   own constructions: Fox, spheres, su(m), HP^m, SU(3), SO(2m)/U(m), Grassmannians
  2  slack        slack identity: A, B, F1, F2, S = G1/2 at all constructions
  3  hunt6        generic critical-point hunt at n=6, F1/F2 violation hunt
  4  trap         classification trap: gap_band_point_n8.npy re-analysis + mechanism
  5  ceiling8     n=8 ungraded-ceiling re-derivation under own screen
  6  graded       graded sweep spot-checks: theta formula, Casimir identities, rejections,
                  isospectral pair, triality count
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..'))
import itertools
import sys
import time

import numpy as np

LOG = _os.path.join(_ROOT, "agent_logs/review_r11a.log")


def heartbeat(msg):
    with open(LOG, "a") as f:
        f.write(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()) + " [r11a] " + msg + "\n")


# ----------------------------------------------------------------------------
# 0. Core machinery
# ----------------------------------------------------------------------------
class Alg:
    def __init__(self, n):
        self.n = n
        self.pairs = list(itertools.combinations(range(n), 2))
        self.N = len(self.pairs)
        P = np.zeros((self.N, n * n))
        for A, (i, j) in enumerate(self.pairs):
            P[A, i * n + j] = 1.0
            P[A, j * n + i] = -1.0
        self.P = P

    # ---- dictionary ----
    def M_to_T4(self, M):
        n = self.n
        return (self.P.T @ M @ self.P).reshape(n, n, n, n)

    def T4_to_M(self, T):
        n = self.n
        return self.P @ T.reshape(n * n, n * n) @ self.P.T / 4.0

    # ---- curvature machinery ----
    def sharp_T4(self, T, S=None):
        if S is None:
            S = T
        a = np.einsum('ipkq,jplq->ijkl', T, S, optimize=True)
        b = np.einsum('iplq,jpkq->ijkl', T, S, optimize=True)
        return a - b

    def sharp(self, M):
        return self.T4_to_M(self.sharp_T4(self.M_to_T4(M)))

    def sharp_bilinear(self, A, B):
        # A#B, symmetric bilinear polarisation of ^#
        return (self.sharp(A + B) - self.sharp(A - B)) / 4.0

    def Q(self, M):
        return M @ M + self.sharp(M)

    def Ric(self, M):
        return np.einsum('ipjp->ij', self.M_to_T4(M))

    def Alt(self, M):
        T = self.M_to_T4(M)
        Ta = (T + np.transpose(T, (1, 2, 0, 3)) + np.transpose(T, (2, 0, 1, 3))) / 3.0
        return self.T4_to_M(Ta)

    # ---- Lambda^2 <-> matrices, bracket ----
    def vec_of_mat(self, A):
        return np.array([A[i, j] for (i, j) in self.pairs])

    def mat_of_vec(self, v):
        n = self.n
        A = np.zeros((n, n))
        for a, (i, j) in enumerate(self.pairs):
            A[i, j] = v[a]
            A[j, i] = -v[a]
        return A

    def bracket(self, v, w):
        V, W = self.mat_of_vec(v), self.mat_of_vec(w)
        return self.vec_of_mat(V @ W - W @ V)

    def bracket_mats(self, V, W):
        return V @ W - W @ V


def orthonormalize(vecs, tol=1e-10):
    """Gram-Schmidt an array (k, N) of pair-vectors; returns orthonormal rows."""
    out = []
    for v in vecs:
        w = v.copy().astype(float)
        for u in out:
            w -= (u @ w) * u
        nw = np.linalg.norm(w)
        if nw > tol:
            out.append(w / nw)
    return np.array(out)


def proj_of(vecs):
    """Projection matrix sum v v^T for orthonormal rows."""
    return vecs.T @ vecs


def spectral_parts(alg, M, kernel_tol=1e-8):
    lam, U = np.linalg.eigh(M)
    pos = lam > kernel_tol
    neg = lam < -kernel_tol
    Wp = (U[:, pos] * lam[pos]) @ U[:, pos].T
    Wm = -(U[:, neg] * lam[neg]) @ U[:, neg].T
    Pp = U[:, pos] @ U[:, pos].T
    Pm = U[:, neg] @ U[:, neg].T
    return lam, U, Wp, Wm, Pp, Pm, pos, neg


def slack_S(alg, M, theta, kernel_tol=1e-8):
    lam, U, Wp, Wm, Pp, Pm, pos, neg = spectral_parts(alg, M, kernel_tol)
    ric = alg.Ric(Wm)
    d2 = np.linalg.norm(alg.Alt(Wm), 'fro') ** 2
    return (np.sum(ric * ric) + 6 * d2 - theta * np.trace(Wm) - np.trace(Wm @ Wm))


def G1_of(alg, M, kernel_tol=1e-8):
    lam, U = np.linalg.eigh(M)
    neg = lam < -kernel_tol
    mus = -lam[neg]
    vs = U[:, neg].T
    Pm = vs.T @ vs
    G1 = 0.0
    for i in range(len(mus)):
        for j in range(len(mus)):
            br = alg.bracket(vs[i], vs[j])
            G1 += mus[i] * mus[j] * np.dot(Pm @ br, br)
    return G1


def bracket_masses(alg, M, kernel_tol=1e-8):
    """Fractions of bracket mass violating the three grading conditions.
    Returns ([E+,E+] mass into E-, [E+,E-] mass outside E-, [E-,E-] mass into E-),
    each normalised by the total mass of the respective bracket set (0 if empty)."""
    lam, U = np.linalg.eigh(M)
    pos = lam > kernel_tol
    neg = lam < -kernel_tol
    up = U[:, pos].T
    vm = U[:, neg].T
    Pm = vm.T @ vm
    Iout = np.eye(alg.N) - Pm
    def frac(basA, basB, proj):
        tot, bad = 0.0, 0.0
        for a in basA:
            for b in basB:
                br = alg.bracket(a, b)
                tot += br @ br
                bad += br @ (proj @ br)
        return bad / tot if tot > 1e-14 else 0.0
    f_pp = frac(up, up, Pm)         # [E+,E+] mass landing in E-   (should be 0: F1)
    f_pm = frac(up, vm, Iout)         # [E+,E-] mass landing outside E- (should be 0: F2)
    f_mm = frac(vm, vm, Pm)         # [E-,E-] mass landing in E-   (0 iff graded)
    return f_pp, f_pm, f_mm


def crit_data(alg, M, label="", kernel_tol=1e-8, verbose=True):
    """Full diagnostic at a candidate critical point (unit-norm expected)."""
    nrm = np.linalg.norm(M, 'fro')
    Q = alg.Q(M)
    theta = np.sum(Q * M) / nrm ** 2
    res = np.linalg.norm(Q - theta * M, 'fro')
    ric = np.linalg.norm(alg.Ric(M))
    alt = np.linalg.norm(alg.Alt(M), 'fro')
    lam, U, Wp, Wm, Pp, Pm, pos, neg = spectral_parts(alg, M, kernel_tol)
    d2 = np.linalg.norm(alg.Alt(Wm), 'fro') ** 2
    S = slack_S(alg, M, theta, kernel_tol)
    G1 = G1_of(alg, M, kernel_tol)
    # F1, F2
    Wp_sharp = alg.sharp(Wp)
    F1 = np.trace(Pm @ Wp_sharp @ Pm)
    WpWm = alg.sharp_bilinear(Wp, Wm)
    Ic = np.eye(alg.N) - Pm
    F2res = np.trace(Ic @ WpWm @ Ic)
    if verbose:
        print(f"[{label}] n={alg.n} |W|={nrm:.12f} theta={theta:.9f} res={res:.2e} "
              f"|Ric|={ric:.2e} |Alt|={alt:.2e}")
        print(f"    delta2={d2:.9f} S={S:.9f} G1/2={G1/2:.9f} S-G1/2={S-G1/2:.2e} "
              f"F1={F1:.2e} F2res={F2res:.2e}")
    return dict(theta=theta, res=res, ric=ric, alt=alt, d2=d2, S=S, G1=G1,
                F1=F1, F2res=F2res, lam=lam, nrm=nrm)


# ----------------------------------------------------------------------------
# Subalgebra builders (as orthonormal pair-vector rows)
# ----------------------------------------------------------------------------
def so_block(alg, idxs):
    """so(k) block on the coordinates idxs, as orthonormal pair-vectors."""
    vs = []
    for a, (i, j) in enumerate(alg.pairs):
        if i in idxs and j in idxs:
            v = np.zeros(alg.N)
            v[a] = 1.0
            vs.append(v)
    return np.array(vs)


def mixed_block(alg, idxs1, idxs2):
    vs = []
    for a, (i, j) in enumerate(alg.pairs):
        if (i in idxs1 and j in idxs2) or (i in idxs2 and j in idxs1):
            v = np.zeros(alg.N)
            v[a] = 1.0
            vs.append(v)
    return np.array(vs)


def commutant_in_so(alg, Js, within=None):
    """{X in so(n): [X, J] = 0 for J in Js}, as orthonormal pair-vectors.
    If `within` (rows of pair-vectors) is given, restrict to that subspace."""
    n, N = alg.n, alg.N
    if within is None:
        basis = np.eye(N)
    else:
        basis = within
    rows = []
    for v in basis:
        V = alg.mat_of_vec(v)
        row = []
        for J in Js:
            row.append((V @ J - J @ V).flatten())
        rows.append(np.concatenate(row))
    Kmat = np.array(rows)  # (dim basis, n^2 * len(Js))
    u, sv, vt = np.linalg.svd(Kmat, full_matrices=True)
    rank = int(np.sum(sv > 1e-9 * max(1.0, sv[0]))) if len(sv) else 0
    # constraint on X = sum_i c_i basis_i is sum_i c_i Kmat[i] = 0: c is a LEFT null vector
    coeffs = u[:, rank:].T
    return orthonormalize(coeffs @ basis)


def complex_structure(n):
    """J on R^n = C^{n/2}, block layout: J e_i = e_{m+i}, J e_{m+i} = -e_i."""
    m = n // 2
    J = np.zeros((n, n))
    for i in range(m):
        J[m + i, i] = 1.0
        J[i, m + i] = -1.0
    return J


def quaternion_right_mults(k):
    """Right-multiplication matrices R_i, R_j, R_k on H^k = R^{4k},
    coordinates ordered (a,b,c,d) per quaternion q = a+bi+cj+dk."""
    def blk(B4):
        M = np.zeros((4 * k, 4 * k))
        for t in range(k):
            M[4 * t:4 * t + 4, 4 * t:4 * t + 4] = B4
        return M
    # Build directly from multiplication to avoid sign errors:
    def rmul(unit):
        # unit in {'i','j','k'}; matrix M with (q*unit) = M q, q as (a,b,c,d)
        tbl = {}
        # products e_x * unit where e_x in {1,i,j,k}
        # 1*i=i, i*i=-1, j*i=-k, k*i=j
        # 1*j=j, i*j=k, j*j=-1, k*j=-i
        # 1*k=k, i*k=-j, j*k=i, k*k=-1
        prod = {
            ('1', 'i'): (1, 'i'), ('i', 'i'): (-1, '1'), ('j', 'i'): (-1, 'k'), ('k', 'i'): (1, 'j'),
            ('1', 'j'): (1, 'j'), ('i', 'j'): (1, 'k'), ('j', 'j'): (-1, '1'), ('k', 'j'): (-1, 'i'),
            ('1', 'k'): (1, 'k'), ('i', 'k'): (-1, 'j'), ('j', 'k'): (1, 'i'), ('k', 'k'): (-1, '1'),
        }
        names = ['1', 'i', 'j', 'k']
        M4 = np.zeros((4, 4))
        for col, base in enumerate(names):
            sgn, res = prod[(base, unit)]
            M4[names.index(res), col] = sgn
        return blk(M4)
    return rmul('i'), rmul('j'), rmul('k')


def sp_k_basis(alg, k):
    """sp(k) in so(4k): skew matrices commuting with right mults R_i, R_j."""
    Ri, Rj, Rk = quaternion_right_mults(k)
    return commutant_in_so(alg, [Ri, Rj]), (Ri, Rj, Rk)


def su3_adjoint_frame():
    """Orthonormal basis of su(3) (anti-Hermitian, <X,Y> = -tr(XY) normalised)
    and the 8x8 real matrices ad(e_a) in that basis."""
    lam = []
    def m(rows):
        return np.array(rows, dtype=complex)
    l1 = m([[0, 1, 0], [1, 0, 0], [0, 0, 0]])
    l2 = m([[0, -1j, 0], [1j, 0, 0], [0, 0, 0]])
    l3 = m([[1, 0, 0], [0, -1, 0], [0, 0, 0]])
    l4 = m([[0, 0, 1], [0, 0, 0], [1, 0, 0]])
    l5 = m([[0, 0, -1j], [0, 0, 0], [1j, 0, 0]])
    l6 = m([[0, 0, 0], [0, 0, 1], [0, 1, 0]])
    l7 = m([[0, 0, 0], [0, 0, -1j], [0, 1j, 0]])
    l8 = m([[1, 0, 0], [0, 1, 0], [0, 0, -2]]) / np.sqrt(3)
    gm = [l1, l2, l3, l4, l5, l6, l7, l8]
    es = [1j * g / np.sqrt(2) for g in gm]   # anti-Hermitian, tr(e_a e_b^H)= ... orthonormal in Re tr(X Y^H)
    # ad matrices: ad(e_a) e_b = [e_a, e_b] = sum_c A[c,b] e_c ; inner product Re tr(X Y^H)
    def ip(X, Y):
        return np.real(np.trace(X @ Y.conj().T))
    G = np.array([[ip(x, y) for y in es] for x in es])
    assert np.allclose(G, np.eye(8), atol=1e-12)
    ads = []
    for a in range(8):
        A = np.zeros((8, 8))
        for b in range(8):
            com = es[a] @ es[b] - es[b] @ es[a]
            for c in range(8):
                A[c, b] = ip(com, es[c])
        ads.append(A)
    return ads


# ----------------------------------------------------------------------------
# Weyl basis + generic critical search
# ----------------------------------------------------------------------------
def sym_basis(N):
    """Orthonormal (Frobenius) basis of symmetric N x N matrices, as (d, N, N)."""
    mats = []
    for a in range(N):
        E = np.zeros((N, N))
        E[a, a] = 1.0
        mats.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N))
            E[a, b] = E[b, a] = 1 / np.sqrt(2)
            mats.append(E)
    return np.array(mats)


def weyl_basis(alg, cache={}):
    if alg.n in cache:
        return cache[alg.n]
    SB = sym_basis(alg.N)
    rows = []
    for E in SB:
        r = alg.Ric(E)
        a = alg.Alt(E)
        rows.append(np.concatenate([r.flatten(), a.flatten()]))
    K = np.array(rows)
    # constraint: sum_i x_i K[i] = 0 -> x in nullspace of K^T
    u2, s2, vt2 = np.linalg.svd(K.T, full_matrices=True)
    rank2 = int(np.sum(s2 > 1e-9 * s2[0]))
    X = vt2[rank2:]  # rows: coefficient vectors
    Wb = np.einsum('ki,imn->kmn', X, SB)
    cache[alg.n] = Wb
    return Wb


class Searcher:
    def __init__(self, alg):
        self.alg = alg
        self.Wb = weyl_basis(alg)
        self.d = self.Wb.shape[0]

    def W_of(self, x):
        return np.einsum('k,kmn->mn', x, self.Wb)

    def coords(self, G):
        return np.einsum('kmn,mn->k', self.Wb, G)

    def fg(self, x, theta_t=None, lam=5.0):
        alg = self.alg
        W = self.W_of(x)
        nrm = np.linalg.norm(W, 'fro')
        Wh = W / nrm
        Q = alg.Q(Wh)
        theta = np.sum(Q * Wh)
        f = np.sum(Q * Q) - theta ** 2
        # ambient gradients (wrt Wh)
        gQ2 = 2 * (Wh @ Q + Q @ Wh) + 4 * alg.sharp_bilinear(Wh, Q)
        gth = 3 * Q
        G = gQ2 - 2 * theta * gth
        if theta_t is not None:
            f += lam * (theta - theta_t) ** 2
            G = G + 2 * lam * (theta - theta_t) * gth
        # project to sphere tangent, chain rule through normalisation
        G = (G - np.sum(G * Wh) * Wh) / nrm
        return f, self.coords(G)

    def run(self, seed_x, theta_t=None, lam=5.0, maxiter=800):
        from scipy.optimize import minimize
        r = minimize(lambda x: self.fg(x, theta_t, lam), seed_x, jac=True,
                     method='L-BFGS-B', options=dict(maxiter=maxiter, maxcor=20,
                                                     ftol=1e-18, gtol=1e-14))
        # polish without pin
        r2 = minimize(lambda x: self.fg(x, None), r.x, jac=True,
                      method='L-BFGS-B', options=dict(maxiter=maxiter, maxcor=20,
                                                      ftol=1e-18, gtol=1e-14))
        x = r2.x / np.linalg.norm(r2.x)
        W = self.W_of(x)
        W = W / np.linalg.norm(W, 'fro')
        Q = self.alg.Q(W)
        theta = np.sum(Q * W)
        res = np.linalg.norm(Q - theta * W, 'fro')
        return W, theta, res


# ----------------------------------------------------------------------------
# Construction helpers for structured critical points
# ----------------------------------------------------------------------------
def graded_two_eig(alg, kbas, mbas):
    """W = (q Pi_k - p Pi_m)/sqrt(pq(p+q)) supported on h = k + m."""
    p, q = len(kbas), len(mbas)
    W = (q * proj_of(kbas) - p * proj_of(mbas)) / np.sqrt(p * q * (p + q))
    return W


def solve_family(alg, projs, dims, seed_ts=None, verbose=False, theta_pref=None):
    """Find a trace-free unit-norm critical point of the form sum_i t_i Proj_i.
    projs: list of projection matrices (orthogonal, disjoint); dims their ranks.
    Minimises the criticality residual over the (len-2)-dim family; returns (W, res).
    """
    from scipy.optimize import minimize
    k = len(projs)
    dims = np.array(dims, float)

    def W_of(t):
        W = sum(ti * Pi for ti, Pi in zip(t, projs))
        return W

    def obj(u):
        # u parametrises trace-free directions; build t: components with sum dims*t = 0, |W|=1
        t = u_to_t(u)
        W = W_of(t)
        Q = alg.Q(W)
        th = np.sum(Q * W)
        return np.sum((Q - th * W) ** 2)

    # trace-free subspace of R^k under weights dims, then normalise
    D = np.diag(np.sqrt(dims))
    ones = np.sqrt(dims) / np.linalg.norm(np.sqrt(dims))
    B = np.linalg.svd(np.eye(k) - np.outer(ones, ones))[0][:, :k - 1]

    def u_to_t(u):
        y = B @ u          # in sqrt-weighted coords, orthogonal to sqrt(dims)
        y = y / np.linalg.norm(y)
        t = y / np.sqrt(dims)
        return t

    rng = np.random.default_rng(7)
    nseed = 12 if k <= 3 else 40
    seeds = seed_ts if seed_ts is not None else [rng.normal(size=k - 1) for _ in range(nseed)]
    roots = []
    for s in seeds:
        r = minimize(obj, s, method='Nelder-Mead',
                     options=dict(maxiter=4000, xatol=1e-14, fatol=1e-26))
        if r.fun > 1e-20:
            continue
        t = u_to_t(r.x)
        W = W_of(t)
        Q = alg.Q(W)
        th = np.sum(Q * W)
        if th < 0:
            W, t, th = -W, -t, -th   # sign convention theta > 0 (Q even => -W critical too)
            Q = alg.Q(W)
        res = np.linalg.norm(Q - th * W)
        if not any(abs(th - r0[3]) < 1e-7 and np.allclose(t, r0[2], atol=1e-6) for r0 in roots):
            roots.append((W, res, t, th))
    if not roots:
        return None, np.inf, None
    if verbose:
        for W, res, t, th in sorted(roots, key=lambda r: r[3]):
            print(f"    root theta={th:.9f} res={res:.2e} t={np.round(t,6)}")
    if theta_pref is not None:
        W, res, t, th = min(roots, key=lambda r: abs(r[3] - theta_pref))
    else:
        W, res, t, th = min(roots, key=lambda r: r[1])
    return W, res, t


# Casimir measurement helpers
def casimir_on(alg, kbas, target):
    """Matrix of -sum_a ad(e_a)^2 on span(target rows), e_a orthonormal basis of k."""
    r = len(target)
    C = np.zeros((r, r))
    for e in kbas:
        br = np.array([alg.bracket(e, t) for t in target])       # ad(e) target_b
        br2 = np.array([alg.bracket(e, b) for b in br])          # ad(e)^2
        C -= br2 @ target.T
    return C


def structure_sum_Amm(alg, kbas, mbas):
    """A_mm averaged over k basis: (1/p) sum_alpha sum_{gamma,delta in m} c_{alpha gamma delta}^2."""
    tot = 0.0
    for e in kbas:
        for g in mbas:
            br = alg.bracket(e, g)
            tot += np.sum((mbas @ br) ** 2)
    return tot / len(kbas)


# ----------------------------------------------------------------------------
# Section 0: validation
# ----------------------------------------------------------------------------
def sec_validate():
    heartbeat("sec 0 validate: start")
    print("=" * 70)
    print("SECTION 0: core validation")
    rng = np.random.default_rng(0)

    # Id^# = (n-2) Id
    for n in (5, 6):
        alg = Alg(n)
        S = alg.sharp(np.eye(alg.N))
        err = np.linalg.norm(S - (n - 2) * np.eye(alg.N))
        print(f"Id^# = (n-2)Id at n={n}: err = {err:.2e}")
        assert err < 1e-12

    # trilinear symmetry
    alg = Alg(6)
    A, B, C = [rng.normal(size=(15, 15)) for _ in range(3)]
    A, B, C = [(X + X.T) / 2 for X in (A, B, C)]
    vals = []
    for X, Y, Z in itertools.permutations([A, B, C]):
        vals.append(np.sum(alg.sharp_bilinear(X, Y) * Z))
    print(f"trilinear symmetry spread: {max(vals)-min(vals):.2e} (scale {abs(vals[0]):.1f})")
    assert max(vals) - min(vals) < 1e-9 * max(1, abs(vals[0]))

    # Alt idempotent + self-adjoint + kills Bianchi part of random Weyl
    M = (lambda X: (X + X.T) / 2)(rng.normal(size=(15, 15)))
    A1 = alg.Alt(M)
    A2 = alg.Alt(A1)
    print(f"Alt idempotent: {np.linalg.norm(A1-A2):.2e};  self-adjoint: "
          f"{abs(np.sum(A1*M) - np.sum(alg.Alt(M)*M)):.2e}")
    M2 = (lambda X: (X + X.T) / 2)(rng.normal(size=(15, 15)))
    sa = abs(np.sum(alg.Alt(M) * M2) - np.sum(M * alg.Alt(M2)))
    print(f"Alt self-adjoint (two-sided): {sa:.2e}")
    assert np.linalg.norm(A1 - A2) < 1e-11 and sa < 1e-11

    # scal identity: 2 tr(M^2 + M^#) = |Ric|^2 + 6 |Alt|^2
    for n in (5, 6, 7):
        alg_n = Alg(n)
        M = (lambda X: (X + X.T) / 2)(rng.normal(size=(alg_n.N, alg_n.N)))
        lhs = 2 * np.trace(M @ M + alg_n.sharp(M))
        ric = alg_n.Ric(M)
        rhs = np.sum(ric * ric) + 6 * np.linalg.norm(alg_n.Alt(M), 'fro') ** 2
        print(f"scal identity n={n}: lhs-rhs = {lhs-rhs:.2e} (scale {lhs:.1f})")
        assert abs(lhs - rhs) < 1e-9 * max(1, abs(lhs))

    # rank-one sharp formula
    v, w = rng.normal(size=15), rng.normal(size=15)
    L = alg.sharp_bilinear(np.outer(v, v), np.outer(w, w))
    br = alg.bracket(v, w)
    R = 0.5 * np.outer(br, br)
    print(f"rank-one #: ||(vv^T)#(ww^T) - 0.5[v,w][v,w]^T|| = {np.linalg.norm(L-R):.2e}")
    assert np.linalg.norm(L - R) < 1e-10

    # one permitted cross-check vs Q_op
    sys.path.insert(0, _os.path.join(_ROOT, "scripts"))
    from curvature_operator import Lambda2, Q_op
    n = 5
    alg5 = Alg(n)
    M = (lambda X: (X + X.T) / 2)(rng.normal(size=(alg5.N, alg5.N)))
    L2 = Lambda2(n)
    Qa = Q_op(L2, M)
    Qb = alg5.Q(M)
    rel = np.linalg.norm(Qa - Qb) / np.linalg.norm(Qa)
    print(f"Q vs curvature_operator.Q_op at n=5: rel err = {rel:.2e}  [the one permitted cross-check]")
    assert rel < 1e-12

    # Fox anchor at n=4 and padded n=6
    for n in (4, 6):
        alg_n = Alg(n)
        s2 = np.sqrt(2)
        om1 = alg_n.vec_of_mat(_fox_form(n, 0)) / s2
        om2 = alg_n.vec_of_mat(_fox_form(n, 1)) / s2
        om3 = alg_n.vec_of_mat(_fox_form(n, 2)) / s2
        W = (2 * np.outer(om1, om1) - np.outer(om2, om2) - np.outer(om3, om3)) / np.sqrt(6)
        d = crit_data(alg_n, W, label=f"Fox n={n}", verbose=False)
        print(f"Fox n={n}: theta={d['theta']:.10f} (target {np.sqrt(1.5):.10f}), "
              f"res={d['res']:.2e}, delta2={d['d2']:.10f} (target {1/9:.10f})")
        assert abs(d['theta'] - np.sqrt(1.5)) < 1e-10
        assert abs(d['d2'] - 1 / 9) < 1e-10
        assert d['res'] < 1e-12

    # balanced S^3 x S^3 anchor at n=6 (graded two-eigenvalue construction)
    alg6 = Alg(6)
    kb = np.vstack([so_block(alg6, {0, 1, 2}), so_block(alg6, {3, 4, 5})])
    mb = mixed_block(alg6, {0, 1, 2}, {3, 4, 5})
    W = graded_two_eig(alg6, kb, mb)
    d = crit_data(alg6, W, label="S3xS3", verbose=False)
    print(f"S3xS3 n=6: theta={d['theta']:.10f} (target {np.sqrt(10)/3:.10f}), "
          f"res={d['res']:.2e}, delta2={d['d2']:.2e}")
    assert abs(d['theta'] - np.sqrt(10) / 3) < 1e-10 and d['res'] < 1e-12

    # Weyl basis dims + random Weyl clean
    for n, expdim in ((6, 84), (8, 300)):
        alg_n = Alg(n)
        Wb = weyl_basis(alg_n)
        x = rng.normal(size=Wb.shape[0])
        W = np.einsum('k,kmn->mn', x, Wb)
        print(f"Weyl basis n={n}: dim={Wb.shape[0]} (expect {expdim}); random member "
              f"|Ric|={np.linalg.norm(alg_n.Ric(W)):.2e} |Alt|={np.linalg.norm(alg_n.Alt(W)):.2e}")
        assert Wb.shape[0] == expdim
    print("SECTION 0: ALL VALIDATIONS PASSED")
    heartbeat("sec 0 validate: PASSED")


def _fox_form(n, which):
    """Self-dual 2-forms on the first 4 coordinates, as antisym n x n matrices (norm^2=2)."""
    A = np.zeros((n, n))
    if which == 0:
        pairs = [(0, 1, 1.0), (2, 3, 1.0)]
    elif which == 1:
        pairs = [(0, 2, 1.0), (3, 1, 1.0)]
    else:
        pairs = [(0, 3, 1.0), (1, 2, 1.0)]
    for i, j, s in pairs:
        A[i, j] += s
        A[j, i] -= s
    return A


# ----------------------------------------------------------------------------
# Section 1: constructions
# ----------------------------------------------------------------------------
def build_catalogue():
    """Build every structured point used downstream. Returns list of (label, alg, W)."""
    out = []

    # --- sphere products: diagonal ansatz solved from own criticality ---
    def sphere_product(blocks, label, theta_pref=None, verbose=False):
        n = sum(blocks)
        alg = Alg(n)
        idxs = []
        s = 0
        for b in blocks:
            idxs.append(set(range(s, s + b)))
            s += b
        projs, dims = [], []
        for i in range(len(blocks)):
            bas = so_block(alg, idxs[i])
            if len(bas):
                projs.append(proj_of(bas))
                dims.append(len(bas))
        for i in range(len(blocks)):
            for j in range(i + 1, len(blocks)):
                bas = mixed_block(alg, idxs[i], idxs[j])
                projs.append(proj_of(bas))
                dims.append(len(bas))
        W, res, t = solve_family(alg, projs, dims, theta_pref=theta_pref, verbose=verbose)
        return (label, alg, W, res)

    # theta_pref = FINDINGS' claimed value, used ONLY to select among own roots
    targets = {(3, 3): None, (3, 5): None, (2, 2, 2): 0.645497, (2, 2, 4): 0.690849,
               (3, 3, 2): 0.720082, (2, 2, 2, 2): 0.540062, (2, 2, 8): 0.702559,
               (3, 3, 6): 0.802044, (2, 2, 2, 6): 0.572172, (4, 4): None, (6, 6): None}
    for blocks, pref in targets.items():
        lab = "S" + "x".join(map(str, blocks))
        t0 = time.time()
        out.append(sphere_product(blocks, lab, theta_pref=pref, verbose=(pref is not None)))
        print(f"  built {lab} (res={out[-1][3]:.2e}, {time.time()-t0:.1f}s)")
        heartbeat(f"sec1: built {lab} res={out[-1][3]:.1e}")

    # --- SU(3) bi-invariant at n=8 ---
    alg8 = Alg(8)
    ads = su3_adjoint_frame()
    hvecs = orthonormalize(np.array([alg8.vec_of_mat(A) for A in ads]))
    assert len(hvecs) == 8
    Ph = proj_of(hvecs)
    projs = [Ph, np.eye(alg8.N) - Ph]
    W, res, t = solve_family(alg8, projs, [8, 20])
    out.append(("SU3bi", alg8, W, res))
    print(f"  built SU3bi (res={res:.2e})")

    # --- su(m) Kaehler family: (su(m), so(m)) at n=2m, m=3,4 ---
    for m in (3, 4):
        n = 2 * m
        alg = Alg(n)
        J = complex_structure(n)
        um = commutant_in_so(alg, [J])
        Jv = alg.vec_of_mat(J)
        Jv = Jv / np.linalg.norm(Jv)
        su = orthonormalize(np.array([v - (v @ Jv) * Jv for v in um]))
        # k = so(m): real matrices inside su(m): block-diagonal [X 0; 0 X], X in so(m)
        kb = []
        for v in su:
            V = alg.mat_of_vec(v)
            # so(m) elements commute with the conjugation sigma = diag(I, -I)
            pass
        sig = np.diag([1.0] * m + [-1.0] * m)
        kb = commutant_in_so(alg, [sig], within=su)
        p = len(kb)
        Pk = proj_of(kb)
        Psu = proj_of(su)
        Pm = Psu - Pk
        q = int(round(np.trace(Pm)))
        W = (q * Pk - p * Pm) / np.sqrt(p * q * (p + q))
        Qw = alg.Q(W)
        th = np.sum(Qw * W)
        res = np.linalg.norm(Qw - th * W)
        out.append((f"su{m}_so{m}", alg, W, res))
        print(f"  built su({m})/so({m}) at n={n}: p={p} q={q} res={res:.2e}")

    # --- HP^2 at n=8 and HP^3 at n=12 ---
    for mq, n in ((2, 8), (3, 12)):
        alg = Alg(n)
        spk, (Ri, Rj, Rk) = sp_k_basis(alg, mq)
        sp1 = orthonormalize(np.array([alg.vec_of_mat(X) for X in (Ri, Rj, Rk)]))
        assert len(spk) == mq * (2 * mq + 1), (len(spk), mq * (2 * mq + 1))
        Pk1 = proj_of(sp1)
        Pk2 = proj_of(spk)
        Pm = np.eye(alg.N) - Pk1 - Pk2
        W, res, t = solve_family(alg, [Pk1, Pk2, Pm],
                                 [3, mq * (2 * mq + 1), alg.N - 3 - mq * (2 * mq + 1)])
        out.append((f"HP{mq}", alg, W, res))
        print(f"  built HP^{mq} at n={n} (res={res:.2e})")

    # --- SO(2m)/U(m) at n=8 (m=4) ---
    alg8b = Alg(8)
    J = complex_structure(8)
    um = commutant_in_so(alg8b, [J])
    Jv = alg8b.vec_of_mat(J)
    Jv = Jv / np.linalg.norm(Jv)
    su = orthonormalize(np.array([v - (v @ Jv) * Jv for v in um]))
    PJ = np.outer(Jv, Jv)
    Psu = proj_of(su)
    Pm = np.eye(alg8b.N) - PJ - Psu
    W, res, t = solve_family(alg8b, [Psu, PJ, Pm], [15, 1, 12])
    out.append(("SO8_U4", alg8b, W, res))
    print(f"  built SO(8)/U(4) (res={res:.2e})")

    # --- complex Grassmannian (su(4), s(u(1)+u(3))) at n=8 ---
    # k inside su(4): commutant of sig = diag(block structure on C^4 = C^1 + C^3)
    sigC = np.diag([1.0, -1.0, -1.0, -1.0])
    SIG = np.zeros((8, 8))
    SIG[:4, :4] = sigC
    SIG[4:, 4:] = sigC
    kfull = commutant_in_so(alg8b, [SIG], within=su)  # s(u(1)+u(3)) inside su(4)
    # split: su(3) ideal, centre direction
    # centre: diag((3)i on C^1, (-1)i on C^3) as real matrix = (3 P1 - P3) J-ish
    zC = np.diag([3.0, -1.0, -1.0, -1.0])
    Zc = J @ np.block([[zC, np.zeros((4, 4))], [np.zeros((4, 4)), zC]])
    Zc = (Zc - Zc.T) / 2
    zv = alg8b.vec_of_mat(Zc)
    zv /= np.linalg.norm(zv)
    su3ideal = orthonormalize(np.array([v - (v @ zv) * zv for v in kfull]))
    Pz = np.outer(zv, zv)
    P3 = proj_of(su3ideal)
    Pmg = Psu - P3 - Pz
    W, res, t = solve_family(alg8b, [P3, Pz, Pmg],
                             [len(su3ideal), 1, int(round(np.trace(Pmg)))])
    out.append(("Gr_su4_u1u3", alg8b, W, res))
    print(f"  built Grassmannian (su(4),s(u1+u3)) at n=8 (res={res:.2e})")

    return out


def sec_constructs():
    heartbeat("sec 1 constructs: start")
    print("=" * 70)
    print("SECTION 1: own constructions + comparison with FINDINGS' claimed values")
    cat = build_catalogue()
    print("-" * 70)
    for label, alg, W, res in cat:
        crit_data(alg, W, label=label)
    heartbeat("sec 1 constructs: done")
    return cat


# ----------------------------------------------------------------------------
# Section 2: slack identity at constructions
# ----------------------------------------------------------------------------
def sec_slack():
    heartbeat("sec 2 slack: start")
    print("=" * 70)
    print("SECTION 2: slack identity, A, B, F1, F2, S=G1/2, compressions")
    cat = build_catalogue()
    print("-" * 70)
    rows = []
    for label, alg, W, res in cat:
        Q = alg.Q(W)
        theta = np.sum(Q * W) / np.linalg.norm(W, 'fro') ** 2
        lam, U, Wp, Wm, Pp, Pm, pos, neg = spectral_parts(alg, W)
        P0 = np.eye(alg.N) - Pp - Pm
        # step A
        shp, shm = alg.sharp(Wp), alg.sharp(Wm)
        A_l = np.trace(Wp @ Wp) + np.trace(shp)
        A_r = np.trace(Wm @ Wm) + np.trace(shm)
        # step B
        WpWm = alg.sharp_bilinear(Wp, Wm)
        B_l = A_r
        B_r = np.trace(WpWm)
        # F1, F2
        F1 = np.trace(Pm @ shp @ Pm)
        F2res = np.trace((np.eye(alg.N) - Pm) @ WpWm @ (np.eye(alg.N) - Pm))
        # S vs G1/2 and S vs tr(P- W-^# P-)
        S = slack_S(alg, W, theta)
        G1 = G1_of(alg, W)
        trm = np.trace(Pm @ shm @ Pm)
        # criticality compressions
        Wsh = alg.sharp(W)
        c1 = np.linalg.norm(Pp @ Wsh @ Pm)
        c2 = np.linalg.norm(P0 @ Wsh @ P0)
        c3 = np.linalg.norm(P0 @ Wsh @ Pp) + np.linalg.norm(P0 @ Wsh @ Pm)
        f_pp, f_pm, f_mm = bracket_masses(alg, W)
        print(f"[{label}] theta={theta:.6f} res={res:.1e}")
        print(f"   (A) lhs-rhs = {A_l-A_r:+.2e}   (B) lhs-rhs = {B_l-B_r:+.2e}")
        print(f"   F1 = {F1:+.2e}   F2res = {F2res:+.2e}")
        print(f"   S = {S:.9f}  G1/2 = {G1/2:.9f}  S-G1/2 = {S-G1/2:+.2e}  "
              f"tr(P-W-#P-) = {trm:.9f}")
        print(f"   crit compressions: |P+W#P-|={c1:.1e} |P0W#P0|={c2:.1e} |P0W#P±|={c3:.1e}")
        print(f"   bracket masses: [E+,E+]->E- {f_pp:.4f}  [E+,E-]->out {f_pm:.4f}  "
              f"[E-,E-]->E- {f_mm:.4f}")
        rows.append((label, theta, S, G1, F1, F2res))
    heartbeat("sec 2 slack: done")


def polish_LM(S, W0, max_nfev=400):
    """Levenberg-Marquardt on the residual vector r(x) = vec(Q(Wh) - theta Wh).
    Returns (W, theta, res). Distinguishes genuine critical points (res -> 1e-13)
    from positive local minima of ||r||^2 (res stalls)."""
    from scipy.optimize import least_squares
    alg = S.alg
    iu = np.triu_indices(alg.N)

    def rvec(x):
        W = S.W_of(x)
        W = W / np.linalg.norm(W, 'fro')
        Q = alg.Q(W)
        th = np.sum(Q * W)
        R = Q - th * W
        return R[iu]

    x0 = S.coords(W0)
    r = least_squares(rvec, x0, method='lm', max_nfev=max_nfev, xtol=3e-16, ftol=3e-16, gtol=3e-16)
    W = S.W_of(r.x)
    W = W / np.linalg.norm(W, 'fro')
    Q = alg.Q(W)
    th = np.sum(Q * W)
    res = np.linalg.norm(Q - th * W)
    return W, th, res


# ----------------------------------------------------------------------------
# Section 3: generic hunt at n=6, try to break F1/F2
# ----------------------------------------------------------------------------
def sec_hunt6(nseeds=60):
    heartbeat("sec 3 hunt6: start")
    print("=" * 70)
    print(f"SECTION 3: generic critical hunt at n=6 ({nseeds} seeds), F1/F2 hunt")
    alg = Alg(6)
    S = Searcher(alg)
    rng = np.random.default_rng(11)
    found = []
    tlast = time.time()
    for s in range(nseeds):
        x0 = rng.normal(size=S.d)
        x0 /= np.linalg.norm(x0)
        W, theta, res = S.run(x0)
        if res < 1e-7 and theta > 0.01:
            found.append((W, theta, res))
        if time.time() - tlast > 150:
            heartbeat(f"sec3 hunt6: seed {s+1}/{nseeds}, {len(found)} converged, "
                      f"best theta={max((f[1] for f in found), default=0):.4f}")
            tlast = time.time()
    print(f"converged (res<1e-7, theta>0): {len(found)}")
    # dedup by spectrum
    uniq = []
    for W, theta, res in found:
        lam = np.sort(np.linalg.eigvalsh(W))
        if not any(np.allclose(lam, u[3], atol=2e-4) and abs(theta - u[1]) < 2e-4 for u in uniq):
            uniq.append((W, theta, res, lam))
    print(f"unique: {len(uniq)}")
    print("LM-polishing each candidate to separate genuine critical points from stalls...")
    polished = []
    tlast = time.time()
    for idx, (W, theta, res, lam) in enumerate(uniq):
        W2, th2, res2 = polish_LM(S, W)
        verdict = "GENUINE" if res2 < 1e-11 else "STALL"
        polished.append((W2, th2, res2, np.sort(np.linalg.eigvalsh(W2)), verdict, res))
        if time.time() - tlast > 150:
            heartbeat(f"sec3 LM polish: {idx+1}/{len(uniq)} done")
            tlast = time.time()
    ngen = sum(1 for p_ in polished if p_[4] == 'GENUINE')
    print(f"LM verdicts: {ngen} GENUINE, {len(polished)-ngen} STALL")
    uniq2 = []
    for W, theta, res, lam, verdict, res_old in polished:
        if not any(np.allclose(lam, u[3], atol=2e-4) and abs(theta - u[1]) < 2e-4 for u in uniq2):
            uniq2.append((W, theta, res, lam, verdict, res_old))
    for W, theta, res, lam, verdict, res_old in sorted(uniq2, key=lambda u: -u[1]):
        d = crit_data(alg, W, label=f"n6 theta={theta:.6f}", verbose=False)
        absl = np.abs(lam)
        nz = absl[absl > 1e-6]
        gap = (nz.min() / max(absl[absl <= 1e-6].max(), 1e-16)) if (absl <= 1e-6).any() else np.inf
        f_pp, f_pm, f_mm = bracket_masses(alg, W)
        clean = "CLEAN" if (gap > 1e3 or not np.isfinite(gap)) else f"DIRTY(gap={gap:.1e})"
        print(f"theta={theta:.9f} res={res:.1e}(was {res_old:.1e}) {verdict} {clean} "
              f"minmu={nz.min():.2e} | S={d['S']:.6f} G1/2={d['G1']/2:.6f} F1={d['F1']:.2e} "
              f"F2res={d['F2res']:.2e} | masses pp={f_pp:.4f} pm={f_pm:.4f} mm={f_mm:.4f}")
    heartbeat(f"sec 3 hunt6: done, {len(uniq2)} unique after LM")
    return uniq2


# ----------------------------------------------------------------------------
# Section 4: the classification trap + the contested n=8 witness
# ----------------------------------------------------------------------------
def sec_trap():
    heartbeat("sec 4 trap: start")
    print("=" * 70)
    print("SECTION 4: classification trap + re-analysis of gap_band_point_n8.npy")
    alg = Alg(8)
    dat = np.load(_os.path.join(_ROOT, "scripts/data/gap_band_point_n8.npy"))
    print(f"loaded shape {dat.shape}")
    if dat.shape == (28, 28):
        W = dat
    else:
        Wb = weyl_basis(alg)
        W = np.einsum('k,kmn->mn', dat, Wb)
    W = W / np.linalg.norm(W, 'fro')
    Q = alg.Q(W)
    theta = np.sum(Q * W)
    res = np.linalg.norm(Q - theta * W)
    lam = np.sort(np.linalg.eigvalsh(W))
    print(f"as-saved: theta={theta:.9f} res={res:.2e} |Ric|={np.linalg.norm(alg.Ric(W)):.1e} "
          f"|Alt|={np.linalg.norm(alg.Alt(W),'fro'):.1e}")
    print("spectrum:", " ".join(f"{v:.6f}" for v in lam))
    small = lam[np.abs(lam) < 1e-2]
    print(f"eigenvalues with |.|<1e-2: {small}")
    for tol in (1e-8, 1e-3, 5e-3):
        Ssl = slack_S(alg, W, theta, kernel_tol=tol)
        G1 = G1_of(alg, W, kernel_tol=tol)
        f_pp, f_pm, f_mm = bracket_masses(alg, W, kernel_tol=tol)
        print(f"  kernel_tol={tol:.0e}: S={Ssl:.6f} G1/2={G1/2:.6f} ratio S/(G1/2)={Ssl/(G1/2) if G1>0 else np.nan:.4f} "
              f"masses pp={f_pp:.4f} pm={f_pm:.4f} mm={f_mm:.4f}")

    # POLISH: refine with own optimizer and see where it lands
    S = Searcher(alg)
    print("polishing with own Levenberg-Marquardt on the criticality residual...")
    Wp_, th_, res_ = polish_LM(S, W, max_nfev=2000)
    lam2 = np.sort(np.linalg.eigvalsh(Wp_))
    print(f"polished: theta={th_:.9f} res={res_:.2e} |W-W0|={np.linalg.norm(Wp_-W):.4e}")
    print("polished spectrum:", " ".join(f"{v:.6f}" for v in lam2))
    d = crit_data(alg, Wp_, label="polished witness", verbose=False)
    f_pp, f_pm, f_mm = bracket_masses(alg, Wp_, kernel_tol=1e-4)
    print(f"polished: S={d['S']:.6f} G1/2={d['G1']/2:.6f} F1={d['F1']:.2e} F2res={d['F2res']:.2e} "
          f"masses(tol=1e-4) pp={f_pp:.4f} pm={f_pm:.4f} mm={f_mm:.4f}")

    # also: the delta^2=3/25 violator's S (FINDINGS ungraded table row: S=0.92, theta=0.387298)
    try:
        dv = np.load(_os.path.join(_ROOT, "scripts/data/defect_violation_n8_0.120000.npy"))
        Wv = dv if dv.shape == (28, 28) else None
        if Wv is not None:
            Wv = Wv / np.linalg.norm(Wv, 'fro')
            Qv = alg.Q(Wv)
            thv = np.sum(Qv * Wv)
            resv = np.linalg.norm(Qv - thv * Wv)
            Sv = slack_S(alg, Wv, thv)
            G1v = G1_of(alg, Wv)
            print(f"delta2=3/25 violator: theta={thv:.9f} res={resv:.1e} S={Sv:.6f} "
                  f"G1/2={G1v/2:.6f} (FINDINGS row: S=0.92, theta=0.387298)")
            Wv2, thv2, resv2 = polish_LM(Searcher(alg), Wv)
            lamv = np.sort(np.linalg.eigvalsh(Wv2))
            dv2 = crit_data(alg, Wv2, verbose=False)
            print(f"violator LM-polished: theta={thv2:.9f} res={resv2:.1e} min|nonzero eig|="
                  f"{np.min(np.abs(lamv[np.abs(lamv)>1e-6])):.4f} S={dv2['S']:.6f} "
                  f"G1/2={dv2['G1']/2:.6f} F1={dv2['F1']:.3e} F2res={dv2['F2res']:.3e}")
    except Exception as e:
        print("violator load failed:", e)

    # MECHANISM check: take clean graded point (Grassmannian CP^3-type at n=8 from own build),
    # kernel-perturb it and watch bracket masses degrade while S stays put.
    print("-" * 70)
    print("mechanism check: kernel contamination of a clean graded point")
    algX = Alg(8)
    J = complex_structure(8)
    um = commutant_in_so(algX, [J])
    Jv = algX.vec_of_mat(J); Jv /= np.linalg.norm(Jv)
    su = orthonormalize(np.array([v - (v @ Jv) * Jv for v in um]))
    sigC = np.diag([1.0, -1.0, -1.0, -1.0])
    SIG = np.zeros((8, 8)); SIG[:4, :4] = sigC; SIG[4:, 4:] = sigC
    kfull = commutant_in_so(algX, [SIG], within=su)
    zC = np.diag([3.0, -1.0, -1.0, -1.0])
    Zc = J @ np.block([[zC, np.zeros((4, 4))], [np.zeros((4, 4)), zC]])
    Zc = (Zc - Zc.T) / 2
    zv = algX.vec_of_mat(Zc); zv /= np.linalg.norm(zv)
    su3ideal = orthonormalize(np.array([v - (v @ zv) * zv for v in kfull]))
    Pz = np.outer(zv, zv); P3 = proj_of(su3ideal)
    Pmg = proj_of(su) - P3 - Pz
    Wg, resg, tg = solve_family(algX, [P3, Pz, Pmg], [8, 1, 6])
    dg = crit_data(algX, Wg, label="clean graded CP3-type", verbose=False)
    print(f"clean: theta={dg['theta']:.6f} res={resg:.1e} S={dg['S']:.2e}")
    rng = np.random.default_rng(3)
    Wbas = weyl_basis(algX)
    H = np.einsum('k,kmn->mn', rng.normal(size=Wbas.shape[0]), Wbas)
    H /= np.linalg.norm(H, 'fro')
    for eps in (1e-3, 1e-4):
        Wc = Wg + eps * H
        Wc /= np.linalg.norm(Wc, 'fro')
        Qc = algX.Q(Wc)
        thc = np.sum(Qc * Wc)
        resc = np.linalg.norm(Qc - thc * Wc)
        f_pp, f_pm, f_mm = bracket_masses(algX, Wc, kernel_tol=1e-8)
        Ssl = slack_S(algX, Wc, thc, kernel_tol=1e-8)
        print(f"  eps={eps:.0e}: res={resc:.1e} sign-split masses pp={f_pp:.4f} pm={f_pm:.4f} "
              f"mm={f_mm:.4f} | S={Ssl:.2e}")
    heartbeat("sec 4 trap: done")


# ----------------------------------------------------------------------------
# Section 5: n=8 ceiling re-derivation
# ----------------------------------------------------------------------------
def sec_ceiling8(nseeds=25):
    heartbeat("sec 5 ceiling8: start")
    print("=" * 70)
    print(f"SECTION 5: n=8 ungraded ceiling under own screen ({nseeds} seeds/target)")
    alg = Alg(8)
    S = Searcher(alg)
    rng = np.random.default_rng(21)
    targets = [None, 0.86, 0.90, 0.94, 0.98, 1.02, 1.06, 1.10, 1.15, 1.20]
    all_pts = []
    for tt in targets:
        t0 = time.time()
        got = 0
        tlast = time.time()
        for s in range(nseeds):
            x0 = rng.normal(size=S.d)
            x0 /= np.linalg.norm(x0)
            W, theta, res = S.run(x0, theta_t=tt, lam=8.0)
            if res < 1e-6 and theta > 0.01:
                W, theta, res = polish_LM(S, W)
                if res < 1e-11 and theta > 0.01:
                    all_pts.append((W, theta, res, tt))
                    got += 1
            if time.time() - tlast > 150:
                heartbeat(f"sec5 ceiling8: target={tt} seed {s+1}/{nseeds}, {got} converged here, "
                          f"{len(all_pts)} total")
                tlast = time.time()
        heartbeat(f"sec5 target={tt}: {got}/{nseeds} converged ({time.time()-t0:.0f}s)")
        print(f"target={tt}: {got}/{nseeds} converged ({time.time()-t0:.0f}s)")
    # dedup
    uniq = []
    for W, theta, res, tt in all_pts:
        lam = np.sort(np.linalg.eigvalsh(W))
        if not any(np.allclose(lam, u[3], atol=2e-4) and abs(theta - u[1]) < 2e-4 for u in uniq):
            uniq.append((W, theta, res, lam))
    print(f"total converged {len(all_pts)}, unique {len(uniq)}")
    rows = []
    for W, theta, res, lam in sorted(uniq, key=lambda u: -u[1]):
        absl = np.abs(lam)
        nzmask = absl > 1e-6
        nz = absl[nzmask]
        kern = absl[~nzmask]
        gap = nz.min() / max(kern.max(), 1e-16) if len(kern) else np.inf
        minmu = nz.min()
        # own screen: residual small (already), spectral cleanliness
        clean = (minmu > 5e-3) or (gap > 1e3)
        d = crit_data(alg, W, verbose=False, kernel_tol=max(1e-6, 0.1 * minmu) if clean else 1e-6)
        f_pp, f_pm, f_mm = bracket_masses(alg, W, kernel_tol=max(1e-6, 0.1 * minmu))
        graded = f_mm < 1e-3 and d['S'] < 1e-4
        tag = ("GRADED" if graded else "UNGRADED") + ("" if clean else "?DIRTY")
        rows.append((theta, tag, d['S'], d['G1'] / 2, f_mm, res, minmu, d['F1'], d['F2res']))
        print(f"theta={theta:.9f} {tag:12s} res={res:.1e} minmu={minmu:.1e} S={d['S']:.6f} "
              f"G1/2={d['G1']/2:.6f} mm={f_mm:.4f} F1={d['F1']:.1e} F2r={d['F2res']:.1e}")
    ung = [r for r in rows if r[1] == "UNGRADED"]
    if ung:
        print(f"\nOWN-SCREEN UNGRADED CEILING at n=8: theta = {max(u[0] for u in ung):.9f}")
    heartbeat("sec 5 ceiling8: done")
    return rows


# ----------------------------------------------------------------------------
# Section 6: graded sweep spot-checks
# ----------------------------------------------------------------------------
def sec_graded():
    heartbeat("sec 6 graded: start")
    print("=" * 70)
    print("SECTION 6: graded enumeration spot-checks")

    # ---- 6.1 theta formula with measured Casimirs at own operators ----
    print("-" * 70)
    print("6.1 theta = (c_k q^2 + 2q^2 + p^2)/((2q-p) sqrt(pq(p+q))) with c_k measured from brackets")

    def check_pair(alg, kbas, mbas, label, build_W=True):
        p, q = len(kbas), len(mbas)
        Ck = casimir_on(alg, kbas, mbas)
        C = np.trace(Ck) / q
        Cspread = np.max(np.abs(Ck - C * np.eye(q)))
        ck_mat = casimir_on(alg, kbas, kbas)
        ck = np.trace(ck_mat) / p
        ck_spread = np.max(np.abs(ck_mat - ck * np.eye(p)))
        Amm = structure_sum_Amm(alg, kbas, mbas)
        th_pred = (ck * q ** 2 + 2 * q ** 2 + p ** 2) / ((2 * q - p) * np.sqrt(p * q * (p + q)))
        th_pred2 = (q * C - p) / np.sqrt(p * q * (p + q))
        R1 = (C * (2 * q - p) - 2 * (p + q)) / q
        msg = (f"[{label}] p={p} q={q} C={C:.6f}(spread {Cspread:.1e}) "
               f"c_k={ck:.6f}(spread {ck_spread:.1e}) A_mm={Amm:.6f} qC/p={q*C/p:.6f}")
        print(msg)
        print(f"   R1 says c_k should be {R1:.6f} -> {'CONSISTENT' if abs(R1-ck)<1e-6 else 'INCONSISTENT'}")
        print(f"   theta(pred, c_k-form)={th_pred:.9f}  theta(pred, C-form)={th_pred2:.9f}")
        if build_W:
            W = graded_two_eig(alg, kbas, mbas)
            d = crit_data(alg, W, verbose=False)
            print(f"   own W: theta={d['theta']:.9f} res={d['res']:.2e} delta2={d['d2']:.9f}")
        return locals()

    # Fox: k=u(1), m = 2 self-duals, inside su(2)_+ of so(4), at n=6
    alg6 = Alg(6)
    s2 = np.sqrt(2)
    om = [alg6.vec_of_mat(_fox_form(6, w)) / s2 for w in range(3)]
    check_pair(alg6, np.array(om[:1]), np.array(om[1:]), "Fox (su2,u1) n=6")

    # su(3)/so(3) at n=6
    J = complex_structure(6)
    um = commutant_in_so(alg6, [J])
    Jv = alg6.vec_of_mat(J); Jv /= np.linalg.norm(Jv)
    su = orthonormalize(np.array([v - (v @ Jv) * Jv for v in um]))
    sig = np.diag([1.0] * 3 + [-1.0] * 3)
    kb = commutant_in_so(alg6, [sig], within=su)
    Pk = proj_of(kb)
    mb = orthonormalize(np.array([v - Pk @ v for v in su]))
    check_pair(alg6, kb, mb, "su(3)/so(3) n=6")

    # balanced S3xS3
    kb2 = np.vstack([so_block(alg6, {0, 1, 2}), so_block(alg6, {3, 4, 5})])
    mb2 = mixed_block(alg6, {0, 1, 2}, {3, 4, 5})
    check_pair(alg6, kb2, mb2, "S3xS3 (so(6),so3+so3)")

    # su(4)/so(4)-type... (su(4), so(4)) at n=8
    alg8 = Alg(8)
    J8 = complex_structure(8)
    um8 = commutant_in_so(alg8, [J8])
    Jv8 = alg8.vec_of_mat(J8); Jv8 /= np.linalg.norm(Jv8)
    su8 = orthonormalize(np.array([v - (v @ Jv8) * Jv8 for v in um8]))
    sig8 = np.diag([1.0] * 4 + [-1.0] * 4)
    kb8 = commutant_in_so(alg8, [sig8], within=su8)
    Pk8 = proj_of(kb8)
    mb8 = orthonormalize(np.array([v - Pk8 @ v for v in su8]))
    check_pair(alg8, kb8, mb8, "su(4)/so(4) n=8")

    # ---- 6.2 the structure-sum identity + c_h^ad dictionary ----
    print("-" * 70)
    print("6.2 sum_i c_i p_i + 3 q sum_i C_i = c_h^ad (p+q), measured")

    def check_sum(alg, ideals, mbas, hbas, label):
        p_tot = sum(len(kb) for kb in ideals)
        q = len(mbas)
        lhs = 0.0
        for kb in ideals:
            ci = np.trace(casimir_on(alg, kb, kb)) / len(kb)
            Ci = np.trace(casimir_on(alg, kb, mbas)) / q
            lhs += ci * len(kb) + 3 * q * Ci
        chad = np.trace(casimir_on(alg, hbas, hbas)) / len(hbas)
        rhs = chad * (p_tot + q)
        print(f"[{label}] lhs={lhs:.6f} rhs={rhs:.6f} diff={lhs-rhs:.2e} (c_h^ad={chad:.6f})")

    hb6 = np.eye(alg6.N)  # so(6) = all of Lambda^2
    check_sum(alg6, [so_block(alg6, {0, 1, 2}), so_block(alg6, {3, 4, 5})], mb2, hb6,
              "(so(6), so3+so3)")
    check_sum(alg6, [kb], mb, su, "(su(3), so(3))")
    # HP^2 pair (so(8), sp(2)+sp(1)): h = so(8), k non-simple
    spk, (Ri, Rj, Rk) = sp_k_basis(alg8, 2)
    sp1 = orthonormalize(np.array([alg8.vec_of_mat(X) for X in (Ri, Rj, Rk)]))
    Pks = proj_of(spk) + proj_of(sp1)
    mHP = orthonormalize(np.array([v - Pks @ v for v in np.eye(alg8.N)]))
    check_sum(alg8, [sp1, spk], mHP, np.eye(alg8.N), "(so(8), sp(2)+sp(1)) [HP2]")
    # c_h^ad dictionary: so(N) -> 2(N-2); su(m) on C^m -> 2m
    print("dictionary: c^ad(so(6)) expect 8, c^ad(su(3)) expect 6, c^ad(su(4)) expect 8:")
    print(f"   so(6): {np.trace(casimir_on(alg6, hb6, hb6))/15:.6f}")
    print(f"   su(3): {np.trace(casimir_on(alg6, su, su))/8:.6f}")
    print(f"   su(4): {np.trace(casimir_on(alg8, su8, su8))/15:.6f}")

    # ---- 6.3 the two rejections ----
    print("-" * 70)
    print("6.3 rejections: (sp(2), sp(1)+sp(1)) at n=8 and (su(4), sp(2)) at n=8; "
          "stale-claim test (su(6), sp(3)) at n=12")
    # (sp(2), sp(1)+sp(1)): h = sp(2) in so(8); k = block sp(1)+sp(1)
    Ri, Rj, Rk = quaternion_right_mults(2)
    spk2, _ = sp_k_basis(alg8, 2)
    # block sp(1) x sp(1) inside sp(2): left quaternion mults on each coordinate,
    # built directly (left mult by i,j,k on H, embedded per block)
    def lmul4(unit):
        prod = {
            ('i', '1'): (1, 'i'), ('i', 'i'): (-1, '1'), ('i', 'j'): (1, 'k'), ('i', 'k'): (-1, 'j'),
            ('j', '1'): (1, 'j'), ('j', 'i'): (-1, 'k'), ('j', 'j'): (-1, '1'), ('j', 'k'): (1, 'i'),
            ('k', '1'): (1, 'k'), ('k', 'i'): (1, 'j'), ('k', 'j'): (-1, 'i'), ('k', 'k'): (-1, '1'),
        }
        names = ['1', 'i', 'j', 'k']
        M4 = np.zeros((4, 4))
        for col, base in enumerate(names):
            sgn, res_ = prod[(unit, base)]
            M4[names.index(res_), col] = sgn
        return M4
    def embed(M4, blk_idx):
        M = np.zeros((8, 8))
        M[4 * blk_idx:4 * blk_idx + 4, 4 * blk_idx:4 * blk_idx + 4] = M4
        return M
    k1 = orthonormalize(np.array([alg8.vec_of_mat(embed(lmul4(u), 0)) for u in 'ijk']))
    k2 = orthonormalize(np.array([alg8.vec_of_mat(embed(lmul4(u), 1)) for u in 'ijk']))
    Pkk = proj_of(k1) + proj_of(k2)
    mm = orthonormalize(np.array([v - Pkk @ v for v in spk2]))
    print(f"(sp(2), sp(1)+sp(1)): dims k1={len(k1)} k2={len(k2)} m={len(mm)}")
    d1 = check_pair(alg8, np.vstack([k1, k2]), mm, "(sp(2), sp1+sp1) n=8", build_W=True)
    # general ideal-wise ansatz: minimize residual over (a1, a2, b)
    Pm_ = proj_of(mm)
    W, res, t = solve_family(alg8, [proj_of(k1), proj_of(k2), Pm_], [3, 3, 4])
    print(f"   ideal-wise ansatz best residual: {res:.3e}  (>{0.01}? -> "
          f"{'NO critical point' if res > 1e-2 else 'critical point EXISTS'})")

    # (su(4), sp(2)) at n=8
    sp2_in_su4 = spk2  # sp(2) already inside su(4) for J=R_i? verify orthogonality to J of R_i
    Jq = Ri
    # su(4) w.r.t. complex structure R_i
    u4 = commutant_in_so(alg8, [Jq])
    Jqv = alg8.vec_of_mat(Jq); Jqv /= np.linalg.norm(Jqv)
    su4q = orthonormalize(np.array([v - (v @ Jqv) * Jqv for v in u4]))
    Psp = proj_of(spk2)
    m_su4 = orthonormalize(np.array([v - Psp @ v for v in su4q]))
    print(f"(su(4), sp(2)): dims k={len(spk2)} m={len(m_su4)}")
    check_pair(alg8, spk2, m_su4, "(su(4), sp(2)) n=8", build_W=True)

    # stale-claim: (su(6), sp(3)) at n=12
    alg12 = Alg(12)
    Ri3, Rj3, Rk3 = quaternion_right_mults(3)
    sp3 = commutant_in_so(alg12, [Ri3, Rj3])
    u6 = commutant_in_so(alg12, [Ri3])
    Jv12 = alg12.vec_of_mat(Ri3); Jv12 /= np.linalg.norm(Jv12)
    su6 = orthonormalize(np.array([v - (v @ Jv12) * Jv12 for v in u6]))
    Psp3 = proj_of(sp3)
    m_su6 = orthonormalize(np.array([v - Psp3 @ v for v in su6]))
    print(f"(su(6), sp(3)): dims k={len(sp3)} m={len(m_su6)}")
    dd = check_pair(alg12, sp3, m_su6, "(su(6), sp(3)) n=12 [stale-claim test]", build_W=True)

    # ---- 6.4 isospectral pair S3xS5 vs HP2 ----
    print("-" * 70)
    print("6.4 S3xS5 vs HP2 at n=8")
    idx1, idx2 = set(range(3)), set(range(3, 8))
    projs = [proj_of(so_block(alg8, idx1)), proj_of(so_block(alg8, idx2)),
             proj_of(mixed_block(alg8, idx1, idx2))]
    W35, res35, _ = solve_family(alg8, projs, [3, 10, 15])
    d35 = crit_data(alg8, W35, label="S3xS5", verbose=False)
    spk_, (Ri_, Rj_, Rk_) = sp_k_basis(alg8, 2)
    sp1_ = orthonormalize(np.array([alg8.vec_of_mat(X) for X in (Ri_, Rj_, Rk_)]))
    PHP = proj_of(sp1_) + proj_of(spk_)
    WHP, resHP, _ = solve_family(alg8, [proj_of(sp1_), proj_of(spk_), np.eye(alg8.N) - PHP],
                                 [3, 10, 15])
    dHP = crit_data(alg8, WHP, label="HP2", verbose=False)
    l35 = np.sort(np.linalg.eigvalsh(W35))
    lHP = np.sort(np.linalg.eigvalsh(WHP))
    print(f"S3xS5: theta={d35['theta']:.12f} res={res35:.1e} delta2={d35['d2']:.9f}")
    print(f"HP2:   theta={dHP['theta']:.12f} res={resHP:.1e} delta2={dHP['d2']:.9f} "
          f"(2/63={2/63:.9f})")
    print(f"spectra match: max|diff| = {np.max(np.abs(l35-lHP)):.2e}; "
          f"||W1-W2||={np.linalg.norm(W35-WHP):.4f}, <W1,W2>={np.sum(W35*WHP):.4f}")
    # gradedness of both + HP3
    f1 = bracket_masses(alg8, W35); f2 = bracket_masses(alg8, WHP)
    print(f"bracket masses S3xS5: {f1}; HP2: {f2}")

    # HP3 not graded
    alg12b = Alg(12)
    sp3b = sp3
    sp1b = orthonormalize(np.array([alg12b.vec_of_mat(X) for X in (Ri3, Rj3, Rk3)]))
    PH3 = proj_of(sp1b) + proj_of(sp3b)
    WH3, resH3, _ = solve_family(alg12b, [proj_of(sp1b), proj_of(sp3b),
                                          np.eye(alg12b.N) - PH3], [3, 21, 42])
    dH3 = crit_data(alg12b, WH3, label="HP3", verbose=False)
    fH3 = bracket_masses(alg12b, WH3)
    print(f"HP3: theta={dH3['theta']:.9f} res={resH3:.1e} S={dH3['S']:.6f} "
          f"masses={tuple(round(x,4) for x in fH3)}")

    # ---- 6.5 triality dimension count ----
    print("-" * 70)
    print("6.5 spin x spin dimension count, N < 200")
    hits = []
    for N in range(2, 200):
        for j in range(1, N):
            dj = 2 ** (j // 2)
            dN = 2 ** ((N - j) // 2)
            if dj * dN == N:
                hits.append((N, j))
    print(f"solutions of dim(spin_j) * dim(spin_(N-j)) = N: {hits}")

    # ---- 6.6 closed-form family sweep re-implementation ----
    print("-" * 70)
    print("6.6 closed-form R1 consistency sweep (own implementation)")

    def r1(p, q, C):
        return (C * (2 * q - p) - 2 * (p + q)) / q

    def theta_pq(p, q, C):
        return (q * C - p) / np.sqrt(p * q * (p + q))

    excs = []
    # balanced spheres (so(2m), so(m)+so(m)): c_true = 2(m-2), C = 2(m-1)... per-ideal
    print("balanced spheres: R1-consistency and theta")
    for m in range(3, 21):
        p = m * (m - 1)
        q = m * m
        C = 2 * (m - 1)
        c_true = 2 * (m - 2)
        ok = abs(r1(p, q, C) - c_true) < 1e-12
        th = theta_pq(p, q, C)
        if th > np.sqrt(1.5) and ok:
            excs.append(("sphere", m, th))
        print(f"  m={m}: R1={r1(p,q,C):.4f} c_true={c_true} {'OK' if ok else 'FAIL'} "
              f"theta={th:.6f} {'>sqrt(3/2)' if th>np.sqrt(1.5) else ''}")
    # su(m)/so(m): C=m, c=m-2
    print("su(m)/so(m): R1-consistency and theta")
    for m in range(2, 12):
        p = m * (m - 1) // 2
        q = (m - 1) * (m + 2) // 2
        ok = abs(r1(p, q, m) - (m - 2)) < 1e-12
        th = theta_pq(p, q, m)
        print(f"  m={m}: R1={r1(p,q,m):.4f} c_true={m-2} {'OK' if ok else 'FAIL'} theta={th:.6f}")
    # quaternionic balanced (sp(2j), sp(j)+sp(j)): C=(2j+1)/2, c_true=2(j+1)
    print("(sp(2j), sp(j)+sp(j)): R1 vs c_true")
    for j in range(1, 6):
        p = 2 * j * (2 * j + 1)
        q = 4 * j * j
        C = (2 * j + 1) / 2
        print(f"  j={j}: R1={r1(p,q,C):.4f} c_true={2*(j+1)} INCONSISTENT (diff "
              f"{r1(p,q,C)-2*(j+1):.4f}); naive theta would be {theta_pq(p,q,C):.4f}")
    # (su(2k), sp(k)): C=2k, c_true=2(k+1)
    print("(su(2k), sp(k)): R1 vs c_true")
    for k in range(2, 8):
        p = k * (2 * k + 1)
        q = (2 * k + 1) * (k - 1)
        C = 2 * k
        print(f"  k={k}: R1={r1(p,q,C):.4f} c_true={2*(k+1)} diff={r1(p,q,C)-2*(k+1):.4f}; "
              f"naive theta {theta_pq(p,q,C):.4f}")
    heartbeat("sec 6 graded: done")


# ----------------------------------------------------------------------------
if __name__ == "__main__":
    secs = sys.argv[1:] or ["0"]
    t0 = time.time()
    for s in secs:
        if s in ("0", "validate"):
            sec_validate()
        elif s in ("1", "constructs"):
            sec_constructs()
        elif s in ("2", "slack"):
            sec_slack()
        elif s in ("3", "hunt6"):
            sec_hunt6(int(sys.argv[2]) if len(sys.argv) > 2 and sys.argv[2].isdigit() else 60)
        elif s in ("4", "trap"):
            sec_trap()
        elif s in ("5", "ceiling8"):
            sec_ceiling8(int(sys.argv[2]) if len(sys.argv) > 2 and sys.argv[2].isdigit() else 25)
        elif s in ("6", "graded"):
            sec_graded()
    print(f"\n[total {time.time()-t0:.1f}s]")
