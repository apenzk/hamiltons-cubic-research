"""Reviewer 57: is a critical point coordinate-diagonalisable in SOME frame?

Two independent tests.

(1) NUMERIC.  The off-diagonal mass in a given frame is
        odm(W) = || W - diag(W) ||_F / ||W||_F      (phi = coordinate 2-planes)
    which is frame-DEPENDENT.  The invariant quantity is
        odm*(W) = min over R in O(n) of odm(Lambda^2(R) W Lambda^2(R)^T),
    computed here by Riemannian gradient ascent on sum_a M_aa^2 with many
    random starts.  Positive control: a known coordinate-diagonal point is
    conjugated by a random rotation and the optimiser must drive odm back to 0.

(2) STRUCTURAL certificate.  If W is diagonal in the phi basis of some frame,
    then Lambda^2 has an orthonormal eigenbasis of W consisting of DECOMPOSABLE
    bivectors; in particular every eigenspace of W contains a decomposable
    bivector (rank-2 antisymmetric matrix, equivalently omega ^ omega = 0).
    Exhibiting one eigenspace with no decomposable vector PROVES odm* > 0.
"""
import itertools
import numpy as np
from scipy.linalg import expm

from review_r57_core import Alg


def odm(W):
    W = W / np.linalg.norm(W)
    return float(np.sqrt(max(0.0, 1.0 - np.sum(np.diag(W) ** 2))))


def so_basis(n):
    out = []
    for i, j in itertools.combinations(range(n), 2):
        A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
        out.append(A)
    return out


class Diagonaliser:
    _cache = {}

    def __init__(self, n):
        self.n = n
        self.alg = Alg.get(n)
        self.gens = so_basis(n)
        self.ads = np.array([self.alg.ad(A) for A in self.gens])

    @classmethod
    def get(cls, n):
        if n not in cls._cache:
            cls._cache[n] = cls(n)
        return cls._cache[n]

    def obj(self, M):
        return float(np.sum(np.diag(M) ** 2))

    def grad(self, M):
        d = np.diag(M)
        G = d[:, None] * M
        K = G - G.T
        return 2.0 * np.einsum('kab,ab->k', self.ads, K, optimize=True)

    def maximise(self, W, iters=800, seed=0, verbose=False):
        """Riemannian ascent of sum_a M_aa^2 over O(n)."""
        rng = np.random.default_rng(seed)
        alg = self.alg
        W = W / np.linalg.norm(W)
        A0 = rng.normal(size=(self.n, self.n)) * 0.7
        A0 = A0 - A0.T
        R = expm(A0)
        M = alg.lam2(R) @ W @ alg.lam2(R).T
        t = 0.3
        f = self.obj(M)
        for it in range(iters):
            g = self.grad(M)
            gn = np.linalg.norm(g)
            if gn < 1e-13:
                break
            A = sum(g[k] * self.gens[k] for k in range(len(self.gens))) / gn
            ok = False
            for _ in range(30):
                Rn = expm(t * A) @ R
                L = alg.lam2(Rn)
                Mn = L @ W @ L.T
                fn = self.obj(Mn)
                if fn > f + 1e-16:
                    R, M, f = Rn, Mn, fn
                    t *= 1.6
                    ok = True
                    break
                t *= 0.4
            if not ok or t < 1e-14:
                break
        return f, R, M

    def best(self, W, starts=12, seed=0, iters=800):
        best_f, best_R = -1.0, None
        for s in range(starts):
            f, R, M = self.maximise(W, iters=iters, seed=seed + 1000 * s)
            if f > best_f:
                best_f, best_R = f, R
        return float(np.sqrt(max(0.0, 1.0 - best_f))), best_R


# ------------------------------------------------------------------ decomposability

def wedge_norm(alg, v):
    """||omega ^ omega|| for the bivector with coordinates v (zero iff decomposable)."""
    n = alg.n
    X = np.zeros((n, n))
    for a, (i, j) in enumerate(alg.pairs):
        X[i, j] = v[a]; X[j, i] = -v[a]
    tot = 0.0
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        tot += (X[i, j] * X[k, l] - X[i, k] * X[j, l] + X[i, l] * X[j, k]) ** 2
    return np.sqrt(tot)


def min_wedge_on_eigenspace(alg, cols, tries=60, seed=0):
    """min over unit v in span(cols) of ||omega ^ omega||, by multi-start descent."""
    from scipy.optimize import minimize
    d = cols.shape[1]
    if d == 1:
        return wedge_norm(alg, cols[:, 0]), cols[:, 0]
    rng = np.random.default_rng(seed)
    best, bv = np.inf, None
    for t in range(tries):
        x0 = rng.normal(size=d)
        f = lambda x: wedge_norm(alg, cols @ (x / np.linalg.norm(x))) ** 2
        r = minimize(f, x0, method='Nelder-Mead',
                     options=dict(maxiter=4000, xatol=1e-10, fatol=1e-14))
        if r.fun < best:
            best, bv = r.fun, cols @ (r.x / np.linalg.norm(r.x))
    return np.sqrt(best), bv


def decomposability_certificate(alg, W, tol=1e-7):
    """For each eigenspace, the smallest ||omega^omega|| over its unit sphere.
    A strictly positive value on ANY eigenspace proves W is not coordinate-
    diagonalisable in any orthonormal frame."""
    ev, V = np.linalg.eigh(W)
    out = []
    i = 0
    while i < len(ev):
        j = i
        while j + 1 < len(ev) and abs(ev[j + 1] - ev[i]) < 1e-9:
            j += 1
        cols = V[:, i:j + 1]
        # normalise scale: the wedge is quadratic, so use unit vectors
        m, v = min_wedge_on_eigenspace(alg, cols)
        out.append((ev[i], j - i + 1, m))
        i = j + 1
    return out
