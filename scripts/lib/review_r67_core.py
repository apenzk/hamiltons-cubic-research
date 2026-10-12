"""Reviewer 67 -- independent re-implementation of the so(n) Cartan-3-form /
Weyl-operator machinery.  Nothing here is imported from any other project script.

Conventions (re-derived, see reviews/REVIEW_r67.md):
  basis      phi_{ij} = E_ij - E_ji   (i<j),  N = n(n-1)/2
  metric     <X,Y> = (1/2) tr(X^T Y)   ->  {phi_ij} orthonormal
  3-form     omega(x,y,z) = <[x,y],z>
  for a symmetric operator W on Lambda^2 R^n with spectrum lam and orthonormal
  eigenframe v:   c'_{abg} = omega(v_a,v_b,v_g),  T = c'^2,
  theta = sum lam^3 + 3 sum_{a<b<g} T_{abg} lam_a lam_b lam_g.
"""
import numpy as np
from itertools import combinations


def pairs(n):
    return list(combinations(range(n), 2))


def so_basis(n):
    P = pairs(n)
    N = len(P)
    B = np.zeros((N, n, n))
    for k, (i, j) in enumerate(P):
        B[k, i, j] = 1.0
        B[k, j, i] = -1.0
    return P, B


def omega_tensor(n):
    """omega[e,f,g] = <[phi_e,phi_f],phi_g> with <X,Y>=1/2 tr(X^T Y)."""
    P, B = so_basis(n)
    N = len(P)
    # brackets
    M = np.einsum('eij,fjk->efik', B, B)          # B_e B_f
    Br = M - np.transpose(M, (1, 0, 2, 3))        # [B_e,B_f]
    om = 0.5 * np.einsum('efij,gij->efg', Br, B)  # 1/2 tr(Br^T B_g) = 1/2 sum Br_ij Bg_ij
    return om


def c_tensor(om, V):
    """V: N x N, columns are the orthonormal eigenvectors in the phi basis."""
    t = np.einsum('efg,ea->afg', om, V, optimize=True)
    t = np.einsum('afg,fb->abg', t, V, optimize=True)
    t = np.einsum('abg,gc->abc', t, V, optimize=True)
    return t


def spectrum_data(W, om, tol=1e-9):
    """Diagonalise W (symmetric N x N in the phi basis) and return everything."""
    lam, V = np.linalg.eigh(W)
    cp = c_tensor(om, V)
    T = cp ** 2
    return lam, V, T


def theta_from(lam, T):
    return float(np.sum(lam ** 3) + 0.5 * np.einsum('abg,a,b,g->', T, lam, lam, lam, optimize=True))


def block_sums(lam, T, tol=1e-9):
    """S_mmm,S_mmh,S_mhh,S_hhh over *unordered* triples; m = {lam<0}."""
    neg = lam < -tol
    pos = ~neg                      # h = m^perp  (zeros AND positives)
    m = neg.astype(float)
    h = pos.astype(float)
    def blk(x, y, z):
        return float(np.einsum('abg,a,b,g->', T, x, y, z, optimize=True))
    S_mmm = blk(m, m, m) / 6.0
    S_mmh = blk(m, m, h) / 2.0      # ordered (m,m,h) then /2 for the mm swap
    S_mhh = blk(m, h, h) / 2.0
    S_hhh = blk(h, h, h) / 6.0
    return S_mmm, S_mmh, S_mhh, S_hhh


def sign_blocks(lam, T, tol=1e-9):
    """the four theta blocks, each already multiplied by 3 (i.e. contributions to theta)."""
    p = (lam > tol).astype(float)
    q = (lam < -tol).astype(float)
    def blk(x, y, z, mult):
        return mult * float(np.einsum('abg,a,b,g->', T, x * lam, y * lam, z * lam, optimize=True)) / 6.0 * 3.0
    ppp = 3.0 * np.einsum('abg,a,b,g->', T, p * lam, p * lam, p * lam, optimize=True) / 6.0
    ppm = 3.0 * 3.0 * np.einsum('abg,a,b,g->', T, p * lam, p * lam, q * lam, optimize=True) / 6.0
    pmm = 3.0 * 3.0 * np.einsum('abg,a,b,g->', T, p * lam, q * lam, q * lam, optimize=True) / 6.0
    mmm = 3.0 * np.einsum('abg,a,b,g->', T, q * lam, q * lam, q * lam, optimize=True) / 6.0
    return float(ppp), float(ppm), float(pmm), float(mmm)


# ---------------------------------------------------------------- test points

def padded_cp2(n):
    """Nienhaus W_{CP^2}: 0 on Lambda^-(R^4), (2,-1,-1)/sqrt6 on Lambda^+(R^4),
    zero-padded into Lambda^2(R^n)."""
    P, _ = so_basis(n)
    idx = {p: k for k, p in enumerate(P)}
    N = len(P)
    r2 = np.sqrt(2.0)
    def vec(terms):
        v = np.zeros(N)
        for (i, j, c) in terms:
            v[idx[(i, j)]] = c
        return v
    A1 = vec([(0, 1, 1 / r2), (2, 3, 1 / r2)])
    A2 = vec([(0, 2, 1 / r2), (1, 3, -1 / r2)])
    A3 = vec([(0, 3, 1 / r2), (1, 2, 1 / r2)])
    W = (2 * np.outer(A1, A1) - np.outer(A2, A2) - np.outer(A3, A3)) / np.sqrt(6.0)
    return W


def balanced_sphere_product(n):
    """W = c (Pi_h - (r/N) Id), h = so(n/2) + so(n/2); the balanced sphere product."""
    assert n % 2 == 0
    P, _ = so_basis(n)
    N = len(P)
    half = n // 2
    hmask = np.array([1.0 if ((i < half and j < half) or (i >= half and j >= half)) else 0.0
                      for (i, j) in P])
    r = int(hmask.sum())
    c = np.sqrt(N / (r * (N - r)))
    return c * (np.diag(hmask) - (r / N) * np.eye(N))


def theta0(n):
    return (n - 1) / n * np.sqrt(2 * (n - 2) / (n - 1))


# ---------------------------------------------------------------- the bounds

def clean_spectrum(lam, tol=1e-11):
    """Snap numerical zeros to exact zero and restore tr = 0 exactly.

    Classifying eigenvalues with a two-sided tolerance is a trap here: entries in
    (0,tol] would fall out of BOTH pos and neg, and bound (b)'s (+--) term rests
    on the identity s = sum_m |lam|, which is tracelessness.  Snapping and then
    putting the lost mass back on the top eigenvalue keeps that identity exact
    (the zeroed positives cancel out of it, the zeroed negatives shift both sides
    by the same amount)."""
    lam = np.where(np.abs(lam) < tol, 0.0, np.asarray(lam, dtype=float)).copy()
    if len(lam):
        lam[int(np.argmax(lam))] -= lam.sum()
    return lam


def spectral_stats(lam, tol=1e-11):
    lam = clean_spectrum(lam, tol)
    pos = lam[lam > 0]
    neg = lam[lam < 0]
    d = len(neg)
    s = float(pos.sum())
    u = float((pos ** 2).sum())
    v = float((neg ** 2).sum())
    lam1 = float(pos.max()) if len(pos) else 0.0
    b = float(np.abs(neg).max()) if d else 0.0
    top = np.sort(pos)[::-1][:3]
    top = np.concatenate([top, np.zeros(3 - len(top))])
    h3 = 0.0 if np.any(top <= 0) else float(3.0 / np.sum(1.0 / top))
    return dict(pos=pos, neg=neg, d=d, s=s, u=u, v=v, lam1=lam1, b=b, h3=h3,
                cube=float((lam ** 3).sum()))


def bound_a(lam, n, N=None, tol=1e-11):
    st = spectral_stats(lam, tol)
    N = len(lam) if N is None else N
    d = st['d']
    return st['cube'] + 1.5 * st['lam1'] * st['b'] ** 2 * (n - 2) * d \
                      + 0.5 * st['lam1'] ** 3 * (n - 2) * (2 * N - 3 * d)


def bound_b(lam, n=None, N=None, tol=1e-11):
    st = spectral_stats(lam, tol)
    return st['cube'] + st['h3'] * (st['s'] ** 2 - st['u']) + 3 * st['lam1'] * (st['s'] ** 2 - st['v'])


def bound_c(lam, n, N=None, tol=1e-11):
    st = spectral_stats(lam, tol)
    N = len(lam) if N is None else N
    d = st['d']
    ppp = min(st['h3'] * (st['s'] ** 2 - st['u']), 0.5 * st['lam1'] ** 3 * (n - 2) * (2 * N - 3 * d))
    pmm = min(3 * st['lam1'] * (st['s'] ** 2 - st['v']), 1.5 * st['lam1'] * st['b'] ** 2 * (n - 2) * d)
    return st['cube'] + ppp + pmm


def bound_swap(lam, n, N=None, tol=1e-11):
    """C6's swap: (b)'s (+++) term with (a)'s (+--) term."""
    st = spectral_stats(lam, tol)
    N = len(lam) if N is None else N
    d = st['d']
    return st['cube'] + st['h3'] * (st['s'] ** 2 - st['u']) \
                      + 1.5 * st['lam1'] * st['b'] ** 2 * (n - 2) * d
