"""Newton/least-squares for Q(W)=theta W, in the full Weyl_n or a block-diagonal subspace."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *
from scipy.optimize import least_squares


def adj_mats(n):
    """A[a]_{bg} = c[a,b,g];  (W^#)_{ab} = -1/2 tr(A_a W A_b W) is the trace form."""
    return cstruct(n)


def sharp_trace(n, X, Y):
    A = adj_mats(n); N = A.shape[0]
    AX = (A.reshape(N*N, N) @ X).reshape(N, N, N)
    AY = (A.reshape(N*N, N) @ Y).reshape(N, N, N)
    T = AX.reshape(N, N*N) @ AY.transpose(0,2,1).reshape(N, N*N).T
    return -0.25*(T + T.T)


def block_basis(n, p=None):
    """Orthonormal basis of Weyl_n, or of its coordinate (p,q)-block-diagonal subspace."""
    B = weyl_basis(n)
    if p is None:
        return B
    ip, im = pm_index(n, p)
    N = B.shape[1]
    mask = np.zeros((N, N), bool)
    mask[np.ix_(ip, im)] = True; mask[np.ix_(im, ip)] = True
    # project out the off-block part, then re-orthonormalise the image
    Bp = B.copy(); Bp[:, mask] = 0.0
    # keep the part of the span that is exactly block diagonal: solve for coefficients
    # c with (sum c_a B_a) off-block = 0
    C = np.array([b[mask] for b in B])           # (dim, #offblock)
    if C.shape[1] == 0:
        return B
    U, sv, _ = np.linalg.svd(C, full_matrices=True)
    r = int((sv > 1e-9).sum())
    K = U[:, r:].T
    Bb = np.einsum('ka,aij->kij', K, B)
    G = np.einsum('aij,bij->ab', Bb, Bb)
    w, U = np.linalg.eigh(G); keep = w > 1e-10
    T = U[:, keep]/np.sqrt(w[keep])
    return np.einsum('ab,aij->bij', T, Bb)


def make(n, basis):
    d = basis.shape[0]
    def unpack(c):
        return np.einsum('a,aij->ij', c, basis)
    def resid(c):
        W = unpack(c)
        QW = W @ W + sharp_trace(n, W, W)
        th = float(np.tensordot(QW, W))
        F = np.einsum('aij,ij->a', basis, QW - th*W)
        return np.append(F, float(c @ c) - 1.0)
    def jac(c):
        W = unpack(c)
        QW = W @ W + sharp_trace(n, W, W)
        th = float(np.tensordot(QW, W))
        DQ = np.array([W@B + B@W + 2.0*sharp_trace(n, W, B) for B in basis])
        M = np.einsum('aij,bij->ab', basis, DQ)
        gq = np.einsum('ij,bij->b', QW, basis)
        Bw = np.einsum('aij,ij->a', basis, W)
        J = M - 3.0*np.outer(Bw, gq) - th*np.eye(d)
        return np.vstack([J, 2.0*c])
    return unpack, resid, jac


def spectral_data(n, W, tol=1e-8):
    W = W/np.linalg.norm(W)
    QW = W @ W + sharp_trace(n, W, W)
    th = float(np.tensordot(QW, W))
    if th < 0:
        W, th = -W, -th
        QW = W @ W + sharp_trace(n, W, W)
    crit = float(np.abs(QW - th*W).max())
    lam, V = np.linalg.eigh(W)
    mp = lam > tol; mm = lam < -tol; nz = int((~mp & ~mm).sum())
    A2 = float((lam[mp]**2).sum()); B2 = float((lam[mm]**2).sum())
    # grading test
    c = cstruct(n)
    Up, Um = V[:, mp], V[:, mm]
    Pp = Up @ Up.T; Pm = Um @ Um.T
    def leak(U1, U2, Pt):
        Br = np.einsum('abg,ai,bj->ijg', c, U1, U2, optimize=True)
        return float(np.abs(Br - np.einsum('ijg,gh->ijh', Br, Pt)).max())
    lpp = leak(Up, Up, Pp); lpm = leak(Up, Um, Pm); lmm = leak(Um, Um, Pp)
    graded = max(lpp, lpm, lmm) < 1e-7 and nz == 0
    npos = len(set(np.round(lam[mp], 6)))
    return dict(theta=th, crit=crit, dimp=int(mp.sum()), dimm=int(mm.sum()), ker=nz,
                A2=A2, B2=B2, graded=graded, leak=max(lpp, lpm, lmm), npos=npos,
                lam=lam, W=W)


def sweep(n, p, nstarts=40, kick=0.7, seed=1, verbose=True, basis=None):
    if basis is None:
        basis = block_basis(n, p)
    unpack, resid, jac = make(n, basis)
    rng = np.random.default_rng(seed)
    d = basis.shape[0]
    out = []
    if p is not None:
        W0 = sphere_product_W(n, p)
        c0 = np.einsum('aij,ij->a', basis, W0)
        assert np.abs(unpack(c0) - W0).max() < 1e-10, 'sphere product not in the space'
    for t in range(nstarts):
        c = rng.normal(size=d); c /= np.linalg.norm(c)
        s = least_squares(resid, c, jac=jac, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=400)
        if np.abs(s.fun).max() > 1e-10:
            continue
        out.append(spectral_data(n, unpack(s.x)))
    return out, basis
