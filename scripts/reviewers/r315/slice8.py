import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, core, geom


def build_trilinear(alg, Vb):
    """Vb: (d,N,N) orthonormal symmetric basis of a subspace.
    Gt[a,b,c] = <(Va Vb + Vb Va)/2 + Va#Vb , Vc>, so P(w)=Gt(w,w,w), Q(w)_c=Gt[.,.,c] w w."""
    d = Vb.shape[0]
    N = Vb.shape[1]
    Vf = Vb.reshape(d, N * N)
    Gt = np.zeros((d, d, d))
    for a in range(d):
        A = Vb[a]
        for b in range(a, d):
            B = Vb[b]
            X = 0.5 * (A @ B + B @ A) + alg.sharp(A, B)
            co = Vf @ X.ravel()
            Gt[a, b, :] = co
            Gt[b, a, :] = co
    return Gt


class Cubic:
    def __init__(self, Gt):
        self.G = Gt
        self.d = Gt.shape[0]

    def Q(self, w):
        return np.einsum('abc,a,b->c', self.G, w, w, optimize=True)

    def P(self, w):
        return float(np.dot(w, self.Q(w)))

    def Lmat(self, w):
        return np.einsum('abc,a->cb', self.G, w, optimize=True)


def ascend(cub, w, iters=3000, tol=1e-12):
    w = w / np.linalg.norm(w)
    t = 0.1
    val = cub.P(w)
    for it in range(iters):
        g = cub.Q(w)
        gt = g - np.dot(g, w) * w
        gn = np.linalg.norm(gt)
        if gn < tol:
            break
        ok = False
        for _ in range(60):
            w2 = w + t * gt
            w2 /= np.linalg.norm(w2)
            v2 = cub.P(w2)
            if v2 > val:
                w, val, ok = w2, v2, True
                t *= 1.6
                break
            t *= 0.4
        if not ok:
            break
    return w, val, gn


def polish(cub, w, iters=60):
    """Newton on the criticality equation  Q(w) - theta w = 0 on the sphere (tangential)."""
    d = cub.d
    for _ in range(iters):
        w = w / np.linalg.norm(w)
        q = cub.Q(w)
        th = np.dot(q, w)
        r = q - th * w
        r = r - np.dot(r, w) * w
        if np.linalg.norm(r) < 1e-14:
            break
        L = cub.Lmat(w)
        Pp = np.eye(d) - np.outer(w, w)
        J = Pp @ (2 * L - th * np.eye(d)) @ Pp - np.outer(w, w)
        try:
            step = np.linalg.lstsq(J, -r, rcond=None)[0]
        except np.linalg.LinAlgError:
            break
        step = step - np.dot(step, w) * w
        w = w + step
    return w / np.linalg.norm(w)


def hess_report(cub, w):
    d = cub.d
    th = cub.P(w)
    L = cub.Lmat(w)
    L = 0.5 * (L + L.T)
    Pp = np.eye(d) - np.outer(w, w)
    ev = np.linalg.eigvalsh(Pp @ L @ Pp)
    Le = np.sort(ev / th)
    return th, Le
