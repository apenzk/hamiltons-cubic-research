"""Reviewer 19: structure of Q on the F_u eigenspaces, and honest suprema for
the four couplings.

Key reduction used here (and NOT used by the scripts under audit):
  T(W1,W1,X) = <Q(W1), X>            -> sup over unit X in a subspace S is ||P_S Q(W1)||
  T(W1,X,X)  = <Q(X), W1>            -> sup over unit W1 in V13 is ||P_13 Q(X)||
  T(W1,K,N)  = <F_K(N), W1>          -> sup over unit W1 in V13 is ||P_13 F_K(N)||
So every coupling is a maximisation over ONE unit vector of a norm, not an
alternating three-way game.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, time
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)
SCR = 'scratchpad'


def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)
    with open(_os.path.join(_ROOT, 'agent_logs/review_r19.log'), 'a') as f:
        f.write(f"{time.strftime('%H:%M:%SZ')} {msg}\n")


class Ctx:
    def __init__(self, n):
        idx, pos, N, c = build_structure_constants(n)
        L2 = Lambda2(n)
        Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
        u, th, res = fox_point(n, L2, Eflat, c)
        self.n, self.c, self.Eflat, self.D, self.u, self.th = n, c, Eflat, D, u, th
        self.Nl = u.shape[0]
        M = F_matrix(u, c, Eflat)
        ev, V = np.linalg.eigh(M)
        self.r = ev / SQ32
        self.V = V
        self.sub = {}
        for name, sel in (('u', np.abs(self.r-1) < 1e-8),
                          ('half', np.abs(self.r-0.5) < 1e-8),
                          ('13', np.abs(self.r-1/3.) < 1e-8),
                          ('ker', np.abs(self.r) < 1e-8),
                          ('m16', np.abs(self.r+1/6.) < 1e-8),
                          ('m12', np.abs(self.r+0.5) < 1e-8),
                          ('m1', np.abs(self.r+1) < 1e-8)):
            self.sub[name] = V[:, sel]
        self.sub['neg'] = V[:, self.r < -1e-8]
        self.sub['le0'] = V[:, self.r < 1e-8]

    def mat(self, y, basis):
        W = (self.Eflat.T @ (basis @ y)).reshape(self.Nl, self.Nl)
        return 0.5*(W+W.T)

    def unit(self, y, basis):
        W = self.mat(y, basis)
        return W/np.linalg.norm(W)

    def coords(self, W):
        return self.Eflat @ W.reshape(-1)

    def Q(self, W):
        return Q_full(W, self.c)

    def F(self, A, B):
        return (Q_full(A+B, self.c) - Q_full(A-B, self.c))/4.0

    def rand(self, name, rng):
        b = self.sub[name]
        y = rng.normal(size=b.shape[1])
        return self.unit(y/np.linalg.norm(y), b)


def decompose(ctx, W):
    y = ctx.coords(W)
    out = {}
    for k in ('u', 'half', '13', 'ker', 'm16', 'm12', 'm1'):
        b = ctx.sub[k]
        out[k] = float(np.linalg.norm(b.T @ y)) if b.shape[1] else 0.0
    return out


def ascend_norm(ctx, src, tgt, rng, restarts=30, iters=300):
    """maximise f(X) = ||P_tgt Q(X)|| over unit X in subspace src.
    grad ||PQ(X)||^2 = 4 F_X(P Q(X)); ascent = renormalised gradient step."""
    Bs, Bt = ctx.sub[src], ctx.sub[tgt]
    k = Bs.shape[1]
    best, bestX = 0.0, None
    for _ in range(restarts):
        y = rng.normal(size=k); y /= np.linalg.norm(y)
        X = ctx.unit(y, Bs)
        val = np.linalg.norm(Bt.T @ ctx.coords(ctx.Q(X)))
        step = 1.0
        for _ in range(iters):
            QX = ctx.Q(X)
            g_t = Bt @ (Bt.T @ ctx.coords(QX))          # coords of P_tgt Q(X)
            Pt = (ctx.Eflat.T @ g_t).reshape(ctx.Nl, ctx.Nl); Pt = 0.5*(Pt+Pt.T)
            G = 4.0*ctx.F(X, Pt)
            gy = Bs.T @ ctx.coords(G)                    # project gradient into src
            gy -= (gy @ (Bs.T @ ctx.coords(X))) * (Bs.T @ ctx.coords(X))  # tangent
            ng = np.linalg.norm(gy)
            if ng < 1e-14:
                break
            improved = False
            for _ls in range(20):
                y2 = Bs.T @ ctx.coords(X) + step*gy/ng
                y2 /= np.linalg.norm(y2)
                X2 = ctx.unit(y2, Bs)
                v2 = np.linalg.norm(Bt.T @ ctx.coords(ctx.Q(X2)))
                if v2 > val + 1e-15:
                    X, val, improved = X2, v2, True
                    step *= 1.6
                    break
                step *= 0.5
            if not improved:
                break
        if val > best:
            best, bestX = val, X
    return best, bestX


def ascend_cross(ctx, rng, restarts=20, iters=300):
    """maximise |T(W1,K,N)| = ||P_13 F_K(N)|| over unit K in ker, N in neg."""
    Bk, Bn, B13 = ctx.sub['ker'], ctx.sub['neg'], ctx.sub['13']
    best = 0.0
    for _ in range(restarts):
        K = ctx.rand('ker', rng); N = ctx.rand('neg', rng)
        for _ in range(iters):
            # W1 = normalised P13 F_K(N)
            v = ctx.coords(ctx.F(K, N))
            y1 = B13.T @ v
            if np.linalg.norm(y1) < 1e-15:
                break
            W1 = ctx.unit(y1/np.linalg.norm(y1), B13)
            # K <- normalised P_ker F_{W1}(N)
            yk = Bk.T @ ctx.coords(ctx.F(W1, N))
            if np.linalg.norm(yk) < 1e-15:
                break
            K = ctx.unit(yk/np.linalg.norm(yk), Bk)
            yn = Bn.T @ ctx.coords(ctx.F(W1, K))
            if np.linalg.norm(yn) < 1e-15:
                break
            N = ctx.unit(yn/np.linalg.norm(yn), Bn)
        v = ctx.coords(ctx.F(K, N))
        best = max(best, float(np.linalg.norm(B13.T @ v)))
    return best


if __name__ == "__main__":
    for n in [int(x) for x in sys.argv[1:]] or [10]:
        t = time.time()
        ctx = Ctx(n)
        rng = np.random.default_rng(2024)
        log(f"=== n={n} dims: " + " ".join(f"{k}={ctx.sub[k].shape[1]}" for k in
            ('u','half','13','ker','m16','m12','m1')) + f"  ({time.time()-t:.1f}s)")
        # (A) structure of Q on V13
        for i in range(4):
            W1 = ctx.rand('13', rng)
            QW = ctx.Q(W1)
            d = decompose(ctx, QW)
            log(f"n={n} random W1 in V13: |Q(W1)|={np.linalg.norm(QW):.12f} "
                f"<Q,u>={float(np.sum(QW*ctx.u)):.12f} (th*/3={ctx.th/3:.12f}) "
                + " ".join(f"{k}:{v:.3e}" for k, v in d.items()))
        # basis-level: is P_neg Q = 0 on all of Sym^2 V13?  test on random pairs
        worst = 0.0
        for _ in range(8):
            a, b = ctx.rand('13', rng), ctx.rand('13', rng)
            Fab = ctx.F(a, b)
            nb = np.linalg.norm(Fab)
            for k in ('half','13','m16','m12','m1'):
                B = ctx.sub[k]
                if B.shape[1]:
                    worst = max(worst, float(np.linalg.norm(B.T @ ctx.coords(Fab)))/nb)
        log(f"n={n} max relative component of F(W1,W1') outside <u>+ker over 8 random pairs: {worst:.3e}")
        # (B) honest suprema
        a_sup, _ = ascend_norm(ctx, '13', 'ker', rng)
        a_neg, _ = ascend_norm(ctx, '13', 'neg', rng, restarts=10, iters=120)
        log(f"n={n} sup_||W1||=1 ||P_ker Q(W1)|| = {a_sup:.9f}  (sqrt(5/6)={np.sqrt(5/6):.9f});"
            f"  sup ||P_neg Q(W1)|| = {a_neg:.3e}")
        bker, Kb = ascend_norm(ctx, 'ker', '13', rng)
        bneg, Nb = ascend_norm(ctx, 'neg', '13', rng)
        log(f"n={n} B_KER=sup ||P_13 Q(K)|| = {bker:.9f}   B_NEG=sup ||P_13 Q(N)|| = {bneg:.9f}")
        cross = ascend_cross(ctx, rng)
        log(f"n={n} sup |T(W1,K,N)| = {cross:.3e}")
        # random-triple sanity for the cross term
        w = 0.0
        for _ in range(8):
            K, N = ctx.rand('ker', rng), ctx.rand('neg', rng)
            FK = ctx.F(K, N)
            w = max(w, float(np.linalg.norm(ctx.sub['13'].T @ ctx.coords(FK)))/max(np.linalg.norm(FK),1e-300))
        log(f"n={n} max relative P_13 component of F(K,N) over 8 random pairs: {w:.3e}")
        # sup P on ker / neg / le0
        for s in ('ker','neg','le0'):
            v, X = ascend_norm(ctx, s, s, rng, restarts=8, iters=150)
            log(f"n={n} sup ||P_{s} Q(X)|| over unit X in {s}: {v:.6f}")
