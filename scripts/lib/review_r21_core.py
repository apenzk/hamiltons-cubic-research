"""Reviewer 21: independent machinery for the joint (A,B) frontier audit.

A(W1,K) = T(W1,W1,K) = <K, Q(W1)>,  B(W1,K) = T(W1,K,K) = <W1, Q(K)>,
W1 unit in V_{1/3}(F_u), K unit in ker F_u.

Everything here is built from the primitives (weyl structure constants, Q_full,
the Weyl basis, fox_point) and re-derives the projections itself.  The inner
maximisation over one factor with the other held fixed is a TRUST-REGION
subproblem (linear + quadratic on a sphere) and is solved GLOBALLY, which is the
point: alternating *global* solves cannot be stuck the way alternating gradient
ascent can.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)


class Setup:
    def __init__(self, n, verbose=True):
        self.n = n
        self.idx, self.pos, self.N, self.c = build_structure_constants(n)
        L2 = Lambda2(n)
        self.Eflat, self.D = build_weyl_basis(n, self.idx, self.pos, self.N, self.c, verbose=False)
        self.u, self.th, res = fox_point(n, L2, self.Eflat, self.c)
        self.Nl = self.u.shape[0]
        M = F_matrix(self.u, self.c, self.Eflat)
        w, V = np.linalg.eigh(M)
        self.ratios = w / SQ32
        self.V13 = np.ascontiguousarray(V[:, np.abs(self.ratios - 1.0 / 3.0) < 1e-7])
        self.Vker = np.ascontiguousarray(V[:, np.abs(self.ratios) < 1e-7])
        self.Vneg = np.ascontiguousarray(V[:, self.ratios < -1e-7])
        self.d13 = self.V13.shape[1]
        self.dker = self.Vker.shape[1]
        if verbose:
            print(f"[setup] n={n} dim Weyl={self.D} P(u)={self.th:.12f} crit-res={res:.2e} "
                  f"dim V13={self.d13} dim ker={self.dker} dim neg={self.Vneg.shape[1]}", flush=True)

    def precompute(self):
        """Cache E13 = Eflat^T V13 and Eker = Eflat^T Vker so that the subspace
        maps and their adjoints cost one matmul instead of two."""
        self.E13 = np.ascontiguousarray(self.Eflat.T @ self.V13)
        self.Eker = np.ascontiguousarray(self.Eflat.T @ self.Vker)
        return self

    def slim(self):
        """Drop the (large) ambient Weyl basis once E13/Eker are cached.
        block_fast is unavailable afterwards; the matrix-free path still works."""
        for a in ('Eflat', 'V13', 'Vker', 'Vneg'):
            if hasattr(self, a):
                delattr(self, a)
        import gc; gc.collect()
        return self

    # --- coordinates <-> matrices -------------------------------------------
    def mat13(self, y):
        v = self.E13 @ y if hasattr(self, 'E13') else self.Eflat.T @ (self.V13 @ y)
        X = v.reshape(self.Nl, self.Nl)
        return 0.5 * (X + X.T)

    def matker(self, y):
        v = self.Eker @ y if hasattr(self, 'Eker') else self.Eflat.T @ (self.Vker @ y)
        X = v.reshape(self.Nl, self.Nl)
        return 0.5 * (X + X.T)

    def matfull(self, y):
        X = (self.Eflat.T @ y).reshape(self.Nl, self.Nl)
        return 0.5 * (X + X.T)

    def coeff(self, X):
        return self.Eflat @ X.reshape(-1)

    # --- algebra -------------------------------------------------------------
    def Q(self, X):
        return Q_full(X, self.c)

    def Fbil(self, X, Y):
        """The symmetric bilinear map with Fbil(X,X)=Q(X); T(X,Y,Z)=<Z,Fbil(X,Y)>."""
        return (Q_full(X + Y, self.c) - Q_full(X - Y, self.c)) / 4.0

    def tri(self, X, Y, Z):
        return float(np.sum(Z * self.Fbil(X, Y)))

    # --- the three coefficient-space objects used by the optimiser ----------
    def _pk(self, X):
        return self.Eker.T @ X.reshape(-1) if hasattr(self, 'Eker') else self.Vker.T @ self.coeff(X)

    def _p13(self, X):
        return self.E13.T @ X.reshape(-1) if hasattr(self, 'E13') else self.V13.T @ self.coeff(X)

    def q_ker(self, W1):
        """P_ker Q(W1) in ker coordinates; A = <this, y_K>."""
        return self._pk(self.Q(W1))

    def q_13(self, K):
        """P_13 Q(K) in V13 coordinates; B = <this, y_1>."""
        return self._p13(self.Q(K))

    def f_ker(self, W1, K):
        return self._pk(self.Fbil(W1, K))

    def f_13(self, W1, K):
        return self._p13(self.Fbil(W1, K))

    # --- full matrices of F_X restricted to a subspace ------------------------
    def block(self, X, Vrow, Vcol):
        """matrix  M[i,j] = <row_i, Fbil(X, col_j)>  = T(X, col_j, row_i)."""
        out = np.empty((Vrow.shape[1], Vcol.shape[1]))
        for j in range(Vcol.shape[1]):
            Y = self.matfull(Vcol[:, j])
            out[:, j] = Vrow.T @ self.coeff(self.Fbil(X, Y))
        return out


# --------------------------------------------------------------------------
# global maximisation of  <k, q> + <k, A k>  over the unit sphere
# --------------------------------------------------------------------------
def sphere_quad_max(A, q, tol=1e-12):
    """Global maximiser of f(k) = k^T A k + q^T k on ||k|| = 1.  A symmetric.

    KKT: (lam I - A) k = q/2 with lam >= lam_max(A); |k(lam)| = 1.
    Returns (k, fval)."""
    a, V = np.linalg.eigh(A)
    g = V.T @ q
    amax = a[-1]
    top = np.abs(a - amax) < 1e-10 * max(1.0, abs(amax))
    gtop = g[top]
    if np.linalg.norm(gtop) < 1e-11:
        # hard case candidate: k = pinv(lam_max I - A) q/2 + beta v_top
        with np.errstate(divide='ignore', invalid='ignore'):
            kk = np.where(top, 0.0, g / (2.0 * (amax - a)))
        nk = np.linalg.norm(kk)
        if nk <= 1.0:
            beta = np.sqrt(max(0.0, 1.0 - nk ** 2))
            k = kk.copy()
            i0 = int(np.argmax(top))
            k[i0] += beta
            k = V @ k
            return k, float(k @ A @ k + q @ k)
    # regular case: bisect/newton on lam > amax
    def norm2(lam):
        return float(np.sum((g / (2.0 * (lam - a))) ** 2))
    lo = amax + 1e-14 * max(1.0, abs(amax))
    while norm2(lo) < 1.0:
        lo = amax + (lo - amax) * 0.1
        if lo - amax < 1e-300:
            break
    hi = amax + max(1.0, np.linalg.norm(q))
    while norm2(hi) > 1.0:
        hi = amax + (hi - amax) * 2.0
    for _ in range(200):
        mid = 0.5 * (lo + hi)
        if norm2(mid) > 1.0:
            lo = mid
        else:
            hi = mid
        if hi - lo < tol * max(1.0, abs(amax)):
            break
    lam = 0.5 * (lo + hi)
    k = V @ (g / (2.0 * (lam - a)))
    nk = np.linalg.norm(k)
    if nk > 0:
        k = k / nk
    return k, float(k @ A @ k + q @ k)


def unit(v):
    nv = np.linalg.norm(v)
    return v / nv if nv > 0 else v


# --------------------------------------------------------------------------
# batched build of the matrix of  Y -> P_row Fbil(X, Y)  over a subspace
# --------------------------------------------------------------------------
def _E_pair(SX, SY):
    """E[a,b] = sum_{m,p} SX[a,m,p] SY[b,p,m], batched over SY's leading axis."""
    N = SX.shape[0]
    SXf = SX.reshape(N, N * N)                    # (a, (m,p))
    SYt = np.ascontiguousarray(SY.transpose(0, 1, 3, 2)).reshape(SY.shape[0], N, N * N)
    Z = SYt @ SXf.T                               # (b, c, a) = E[a,c]
    return Z.transpose(0, 2, 1)                   # (b, a, c) = E[a,c]


def _make_block(S, X, Vrow, Vcol, chunk=32, Prow=None):
    N = S.Nl
    c2 = S.c.reshape(N * N, N)
    SX = (c2 @ X).reshape(N, N, N)
    if Prow is None:
        Prow = Vrow.T @ S.Eflat
    out = np.empty((Prow.shape[0], Vcol.shape[1]))
    for st in range(0, Vcol.shape[1], chunk):
        cols = Vcol[:, st:st + chunk]
        Y = (S.Eflat.T @ cols).T.reshape(-1, N, N)
        Y = 0.5 * (Y + Y.transpose(0, 2, 1))
        SY = np.einsum('qn,bnp->bqp', c2, Y, optimize=True).reshape(-1, N, N, N)
        E = _E_pair(SX, SY)
        F = 0.5 * (X @ Y + Y @ X) - 0.25 * (E + E.transpose(0, 2, 1))
        out[:, st:st + cols.shape[1]] = Prow @ F.reshape(F.shape[0], -1).T
    return out


Setup.block_fast = lambda self, X, Vrow, Vcol, chunk=32, Prow=None: _make_block(
    self, X, Vrow, Vcol, chunk=chunk, Prow=Prow)
