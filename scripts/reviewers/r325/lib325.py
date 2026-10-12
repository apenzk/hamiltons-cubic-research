"""Reviewer 325's independent implementation. Built from the definitions alone.

Convention (fixed by requiring sum_{a,b} c_{vab}^2 = 2(n-2) for unit v, and checked
against theta_0(n) at the balanced sphere product):
  Lambda^2 R^n = so(n), basis phi_{ij} = E_ij - E_ji  (i<j),
  inner product <X,Y> = -1/2 tr(XY) = 1/2 tr(X^T Y)  -> {phi_ij} orthonormal,
  bracket = matrix commutator,
  c_{abc} = <[phi_a,phi_b],phi_c>  (totally antisymmetric),
  W#_{kl} = 1/2 sum c_{k al be} c_{l ga de} W_{al ga} W_{be de},
  Q(W) = W^2 + W#,  P(W) = <W,Q(W)> = tr(W Q(W)).
"""
import numpy as np
from itertools import combinations


def basis_index(n):
    pairs = list(combinations(range(n), 2))
    return pairs, {p: i for i, p in enumerate(pairs)}


def struct(n):
    """c[a,b,c] totally antisymmetric structure constants, and the matrices C^k."""
    pairs, idx = basis_index(n)
    N = len(pairs)
    c = np.zeros((N, N, N))
    # [phi_ij, phi_kl] = d_jk phi_il - d_ik phi_jl - d_jl phi_ik + d_il phi_jk
    def add(res, i, j, s):
        if i == j:
            return
        if i < j:
            res[idx[(i, j)]] += s
        else:
            res[idx[(j, i)]] -= s
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            res = np.zeros(N)
            if j == k: add(res, i, l, 1.0)
            if i == k: add(res, j, l, -1.0)
            if j == l: add(res, i, k, -1.0)
            if i == l: add(res, j, k, 1.0)
            c[a, b, :] = res
    return c


def mats(n):
    """so(n) basis as matrices phi_ij = E_ij - E_ji."""
    pairs, _ = basis_index(n)
    M = np.zeros((len(pairs), n, n))
    for a, (i, j) in enumerate(pairs):
        M[a, i, j] = 1.0
        M[a, j, i] = -1.0
    return M


class Frame:
    def __init__(self, n):
        self.n = n
        self.pairs, self.idx = basis_index(n)
        self.N = len(self.pairs)
        self.c = struct(n)          # c[a,b,cc]
        self.Ck = self.c            # C^k_{al be} = c[k,al,be]
        self.M = mats(n)

    def sharp(self, W):
        """W#_{kl} = 1/2 tr((C^k)^T W C^l W)."""
        N = self.N
        WC = np.einsum('ab,lbd,dc->lac', W, self.Ck, W)   # (W C^l W)_{ac}
        return 0.5 * np.einsum('kac,lac->kl', self.Ck, WC)

    def Q(self, W):
        return W @ W + self.sharp(W)

    def P(self, W):
        return float(np.tensordot(W, self.Q(W)))

    def crit_residual(self, W):
        """||Q(W) - theta W|| with theta = <W,Q(W)>/<W,W>."""
        QW = self.Q(W)
        th = float(np.tensordot(W, QW)) / float(np.tensordot(W, W))
        return th, float(np.linalg.norm(QW - th * W))

    # ---- Weyl_n membership -------------------------------------------------
    def R_components(self, W):
        n = self.n
        R = np.zeros((n, n, n, n))
        for a, (i, j) in enumerate(self.pairs):
            for b, (k, l) in enumerate(self.pairs):
                v = W[a, b]
                for (si, ii, jj) in ((1, i, j), (-1, j, i)):
                    for (sk, kk, ll) in ((1, k, l), (-1, l, k)):
                        R[ii, jj, kk, ll] = si * sk * v
        return R

    def weyl_residuals(self, W):
        R = self.R_components(W)
        sym = np.linalg.norm(W - W.T)
        bian = np.linalg.norm(R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2)))
        ric = np.linalg.norm(np.einsum('ijkj->ik', R))
        return dict(sym=sym, bianchi=bian, ricci=ric)


# ---- constructions ---------------------------------------------------------

def proj_from_span(vecs):
    A = np.array(vecs, dtype=float).T
    Qm, _ = np.linalg.qr(A)
    return Qm @ Qm.T


def subalgebra_W(fr, span_idx=None, Pi=None):
    """W = (Pi_h - (r/N) I) / norm."""
    N = fr.N
    if Pi is None:
        Pi = np.zeros((N, N))
        for a in span_idx:
            Pi[a, a] = 1.0
    r = np.trace(Pi)
    W = Pi - (r / N) * np.eye(N)
    return W / np.linalg.norm(W)


def W_balanced(fr):
    """so(m)+so(m) inside so(2m)."""
    n = fr.n
    assert n % 2 == 0
    m = n // 2
    sel = [a for a, (i, j) in enumerate(fr.pairs) if (j < m) or (i >= m)]
    return subalgebra_W(fr, sel)


def W_two_block(fr, p):
    """so(p)+so(n-p)."""
    sel = [a for a, (i, j) in enumerate(fr.pairs) if (j < p) or (i >= p)]
    return subalgebra_W(fr, sel)


def W_torus(fr):
    n = fr.n
    sel = [fr.idx[(2 * t, 2 * t + 1)] for t in range(n // 2)]
    return subalgebra_W(fr, sel)


def W_ad_su3(fr):
    """ad(su(3)) < so(8).  Killing-orthonormal basis of su(3); ad matrices span h."""
    assert fr.n == 8
    lam = []
    def E(i, j):
        A = np.zeros((3, 3), dtype=complex); A[i, j] = 1; return A
    lam.append(E(0,1)+E(1,0)); lam.append(-1j*(E(0,1)-E(1,0)))
    lam.append(E(0,0)-E(1,1))
    lam.append(E(0,2)+E(2,0)); lam.append(-1j*(E(0,2)-E(2,0)))
    lam.append(E(1,2)+E(2,1)); lam.append(-1j*(E(1,2)-E(2,1)))
    lam.append((E(0,0)+E(1,1)-2*E(2,2))/np.sqrt(3))
    X = [1j * L / np.sqrt(2) for L in lam]   # anti-hermitian, <X,Y> = -tr(XY) orthonormal
    # ad matrices in this basis
    ad = []
    for A in X:
        Mx = np.zeros((8, 8))
        for b, B in enumerate(X):
            Cm = A @ B - B @ A
            for a, Aa in enumerate(X):
                Mx[a, b] = np.real(-np.trace(Aa @ Cm))
        ad.append(Mx)
    # map each ad matrix (in so(8)) into the phi-basis coordinates
    vecs = []
    for Mx in ad:
        Mx = 0.5 * (Mx - Mx.T)
        v = np.zeros(fr.N)
        for a, (i, j) in enumerate(fr.pairs):
            v[a] = Mx[i, j]
        vecs.append(v)
    Pi = proj_from_span(vecs)
    return subalgebra_W(fr, Pi=Pi)


def W_cp2_padded(fr):
    """Weyl tensor of CP^2 on Lambda^2 R^4, zero-padded into Lambda^2 R^n."""
    n = fr.n
    assert n >= 4
    def e(i, j):
        v = np.zeros(fr.N)
        if i < j:
            v[fr.idx[(i, j)]] = 1.0
        else:
            v[fr.idx[(j, i)]] = -1.0
        return v
    sd = [(e(0,1)+e(2,3))/np.sqrt(2), (e(0,2)+e(3,1))/np.sqrt(2), (e(0,3)+e(1,2))/np.sqrt(2)]
    W = np.zeros((fr.N, fr.N))
    coeffs = [2.0, -1.0, -1.0]
    for cco, v in zip(coeffs, sd):
        W += cco * np.outer(v, v)
    return W / np.linalg.norm(W)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def W_sphere_product(fr, p):
    """Weyl tensor of the EINSTEIN product S^p(a) x S^q(b), q=n-p, kappa2=(p-1)/(q-1)."""
    n = fr.n; q = n - p
    assert 2 <= p <= n - 2 and p != 1 and q != 1
    P1 = np.zeros((fr.N, fr.N)); P2 = np.zeros((fr.N, fr.N))
    for a, (i, j) in enumerate(fr.pairs):
        if j < p: P1[a, a] = 1.0
        elif i >= p: P2[a, a] = 1.0
    k2 = (p - 1) / (q - 1) if q > 1 else 0.0
    R = P1 + k2 * P2
    c = (p - 1) / (n - 1)
    W = R - c * np.eye(fr.N)
    return W / np.linalg.norm(W)


def W_cpm(fr):
    """Weyl tensor of CP^m (Fubini-Study), n=2m, built from the Kahler curvature tensor."""
    n = fr.n; assert n % 2 == 0
    m = n // 2
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1.0; J[2 * k + 1, 2 * k] = -1.0
    d = np.eye(n)
    R = (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
         + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
         + 2 * np.einsum('ij,kl->ijkl', J, J))
    W = np.zeros((fr.N, fr.N))
    for a, (i, j) in enumerate(fr.pairs):
        for b, (k, l) in enumerate(fr.pairs):
            W[a, b] = R[i, j, k, l]
    ric = np.einsum('ijkj->ik', R)
    c = ric[0, 0] / (n - 1)
    W = W - c * np.eye(fr.N)
    return W / np.linalg.norm(W)


def weyl_basis(n):
    """Orthonormal basis of Weyl_n inside symmetric operators on Lambda^2."""
    fr = Frame(n)
    N = fr.N
    sym = [(a, b) for a in range(N) for b in range(a, N)]
    D = len(sym)
    def unvec(x):
        M = np.zeros((N, N))
        for t, (a, b) in enumerate(sym):
            if a == b: M[a, a] = x[t]
            else:
                M[a, b] = x[t] / np.sqrt(2); M[b, a] = M[a, b]
        return M
    rows = []
    quads = list(combinations(range(n), 4))
    pairs_sym = [(i, k) for i in range(n) for k in range(i, n)]
    A = np.zeros((len(quads) * 3 + len(pairs_sym), D))
    basis_mats = []
    for t in range(D):
        e = np.zeros(D); e[t] = 1.0
        basis_mats.append(unvec(e))
    for t, M in enumerate(basis_mats):
        R = fr.R_components(M)
        col = []
        for (i, j, k, l) in quads:
            col.append(R[i, j, k, l] + R[i, k, l, j] + R[i, l, j, k])
            col.append(R[j, i, k, l] + R[j, k, l, i] + R[j, l, i, k])
            col.append(R[k, i, j, l] + R[k, j, l, i] + R[k, l, i, j])
        ric = np.einsum('ijkj->ik', R)
        for (i, k) in pairs_sym:
            col.append(ric[i, k])
        A[:, t] = col
    u, s, vt = np.linalg.svd(A)
    tol = max(A.shape) * np.finfo(float).eps * (s[0] if s.size else 1.0)
    rank = int((s > tol).sum())
    ns = vt[rank:].T                      # D x (D-rank), orthonormal columns
    return fr, sym, unvec, ns


def random_weyl(fr, sym, unvec, ns, rng):
    x = ns @ rng.standard_normal(ns.shape[1])
    W = unvec(x)
    return W / np.linalg.norm(W)
