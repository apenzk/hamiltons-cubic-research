"""N3: ad(k)-commutant dimension, and the local maxima of P on the graded slice S(V)."""
import sys, time, json
sys.path.insert(0, 'scripts/reviewers/r316')
import numpy as np, core


class Slice:
    def __init__(self, n, a):
        self.alg = core.Alg(n); self.n, self.a = n, a
        self.pr = core.ProjFast(self.alg)
        self.sg = core.grading_involution(self.alg, a)
        self.Weq = core.sphere_product_weyl(self.alg, a)

    def PW(self, M):
        return self.pr.apply(M)

    def PV(self, M):
        M = self.pr.apply(M)
        return 0.5 * (M + self.sg * M)

    def Q(self, W):
        return self.alg.Q(W)

    def P(self, W):
        return float(np.sum(W * self.alg.Q(W)))

    def basisV(self):
        alg = self.alg
        WB, _ = core.weyl_basis(alg)
        F = WB.reshape(WB.shape[0], -1)
        img = (WB * self.sg[None]).reshape(WB.shape[0], -1)
        T = img @ F.T
        w, U = np.linalg.eigh(T)
        keep = U[:, w > 0]
        return np.einsum('td,tij->dij', keep, WB)


def ascend(sl, W, iters=4000, tol=1e-13):
    P = sl.P(W); s = 0.5
    for it in range(iters):
        G = sl.PV(sl.Q(W)); th = float(np.sum(G * W))
        g = 3.0 * (G - th * W)
        gn = np.linalg.norm(g)
        if gn < tol:
            break
        ok = False
        for _ in range(60):
            Wn = W + s * g; Wn = Wn / np.linalg.norm(Wn)
            Pn = sl.P(Wn)
            if Pn > P + 1e-16:
                W, P, ok = Wn, Pn, True; s *= 1.6; break
            s *= 0.4
        if not ok:
            break
    return W, P, gn


def certify(sl, W, VB):
    """theta, full-space criticality residual, lam_max of L_e on V-perp and on full W-perp."""
    alg = sl.alg
    QW = alg.Q(W); PQ = sl.PW(QW); th = float(np.sum(PQ * W))
    res_full = float(np.linalg.norm(PQ - th * W))
    sh = core.Sharp(alg, W)
    d = VB.shape[0]
    LB = np.array([sh.L(VB[i]) for i in range(d)]).reshape(d, -1)
    Mm = VB.reshape(d, -1) @ LB.T
    Mm = 0.5 * (Mm + Mm.T)
    c = VB.reshape(d, -1) @ W.reshape(-1)
    # restrict to W-perp inside V
    Qb, _ = np.linalg.qr(np.eye(d) - np.outer(c, c) / (c @ c))
    B = Qb[:, :d - 1]
    Msub = B.T @ Mm @ B
    lam = np.linalg.eigvalsh(Msub)
    return th, res_full, lam[-1] / th, np.sort(np.linalg.eigvalsh(W))


def commutant_dim(n, a):
    alg = core.Alg(n)
    WB, _ = core.weyl_basis(alg)
    d = WB.shape[0]; F = WB.reshape(d, -1)
    ka, kb, _ = core.pair_projectors(alg, a)
    kidx = [k for k in range(alg.N) if ka[k, k] or kb[k, k]]
    # stack the map W -> ([A_X,W])_X as a big matrix on Weyl coordinates
    blocks = []
    for X in kidx:
        AX = alg.A[X]
        blocks.append((AX @ WB - WB @ AX).reshape(d, -1))
    Mbig = np.concatenate(blocks, axis=1)
    s = np.linalg.svd(Mbig, compute_uv=False)
    tol = 1e-8 * max(1.0, s.max())
    return d, int(np.sum(s < tol)) + max(0, d - len(s))


if __name__ == '__main__':
    for n, a in [(8, 3), (8, 4), (10, 5)]:
        d, c = commutant_dim(n, a)
        print(f"commutant: n={n} pair ({a},{n-a}) dimWeyl={d} dim ad(k)-commutant={c}", flush=True)
