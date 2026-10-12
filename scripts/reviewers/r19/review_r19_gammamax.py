"""Reviewer 19: DIRECT maximisation of gamma = sqrt(2/3) P(W) on the exact
admissible set of Theorem 4.17 at prescribed alpha.

Admissible set: W unit, W in S := V_{1/3} + V_{<=0}  (= (R u + T_u orbit)^perp,
verified exactly), with sqrt(2/3)<F_u W, W> = alpha.

Exact retraction: split y = (y13, y0) in the F_u eigenbasis of S.  With
m = sum_{i in <=0} r_i y_i^2 / ||y0||^2 in [-1,0], the two constraints
||y||=1 and (1/3)||y13||^2 + m||y0||^2 = alpha are solved exactly by rescaling
the two blocks:  ||y13||^2 = X = (alpha-m)/(1/3-m),  ||y0||^2 = 1-X.
So every (direction in V13, direction in V<=0) pair retracts onto the set.
"""
import sys, time
import numpy as np

from review_r19_struct import Ctx, log
SQ32 = np.sqrt(1.5)
R23 = np.sqrt(2.0/3.0)


class Prob:
    def __init__(self, n):
        self.ctx = Ctx(n)
        c = self.ctx
        sel13 = np.abs(c.r - 1/3.) < 1e-8
        sel0 = c.r < 1e-8
        self.B13 = c.V[:, sel13]
        self.B0 = c.V[:, sel0]
        self.r0 = c.r[sel0]
        self.d13 = self.B13.shape[1]
        self.d0 = self.B0.shape[1]
        self.Bs = np.hstack([self.B13, self.B0])
        self.rs = np.concatenate([c.r[sel13], self.r0])
        self.n = n

    def retract(self, y, alpha):
        y13, y0 = y[:self.d13].copy(), y[self.d13:].copy()
        n13, n0 = np.linalg.norm(y13), np.linalg.norm(y0)
        if n13 < 1e-13 or n0 < 1e-13:
            return None
        y13 /= n13; y0 /= n0
        m = float(np.sum(self.r0 * y0**2))
        X = (alpha - m)/(1/3. - m)
        if X < 0 or X > 1:
            return None
        return np.concatenate([np.sqrt(X)*y13, np.sqrt(1-X)*y0])

    def W(self, y):
        c = self.ctx
        M = (c.Eflat.T @ (self.Bs @ y)).reshape(c.Nl, c.Nl)
        return 0.5*(M+M.T)

    def P(self, y):
        W = self.W(y)
        return float(np.sum(W * self.ctx.Q(W)))

    def grad(self, y):
        W = self.W(y)
        return self.Bs.T @ self.ctx.coords(3.0*self.ctx.Q(W)), float(np.sum(W*self.ctx.Q(W)))

    def maximise(self, alpha, rng, restarts=24, iters=250):
        best, besty = -9e9, None
        for _ in range(restarts):
            y = rng.normal(size=self.d13 + self.d0)
            y = self.retract(y, alpha)
            if y is None:
                continue
            val = self.P(y)
            step = 0.3
            for _ in range(iters):
                g, val = self.grad(y)
                g = g - (g @ y)*y
                ng = np.linalg.norm(g)
                if ng < 1e-13:
                    break
                ok = False
                for _ls in range(25):
                    y2 = self.retract(y + step*g/ng, alpha)
                    if y2 is not None:
                        v2 = self.P(y2)
                        if v2 > val + 1e-14:
                            y, val, ok = y2, v2, True
                            step *= 1.5
                            break
                    step *= 0.5
                if not ok:
                    break
            if val > best:
                best, besty = val, y
        return best, besty

    def report(self, y, alpha):
        """decompose the maximiser into the Remark 4.18 data."""
        y13, y0 = y[:self.d13], y[self.d13:]
        cb, sb = np.linalg.norm(y13), np.linalg.norm(y0)
        m = float(np.sum(self.r0 * (y0/max(sb,1e-300))**2))
        ker = np.abs(self.r0) < 1e-8
        c0 = np.linalg.norm(y0[ker])/max(sb, 1e-300)
        return dict(cosb=cb, sinb=sb, m=m, c0=c0,
                    alpha_check=(1/3.)*cb**2 + m*sb**2)


R23_ = R23
A_SUP = np.sqrt(5/6.)


def theta0(n):
    return np.sqrt(2.0*(n-1)*(n-2))/n


def requirement(a):
    return (3.0 - 5.0*a)/np.sqrt(3.0)


def coupled_bound(a, n, BK=2/3., BN=np.sqrt(2/3.), nc=1201, ns=401):
    eps = 1/3. - a
    if eps <= 0:
        return 0.0
    c0 = np.linspace(0, 1, nc)[:, None]
    t = 1 - c0*c0
    hi = np.minimum(6*eps/(2+t), 1.0)
    lo = np.minimum(3*eps/(1+3*t), hi)
    lam = np.linspace(0, 1, ns)[None, :]
    s2 = lo + (hi-lo)*lam
    s = np.sqrt(s2)
    B = BK*c0**2 + BN*(1-c0**2)
    g = R23*(3*(1-s2)*s*c0*A_SUP + 3*np.sqrt(np.maximum(1-s2, 0))*s2*B + s2*s*theta0(n))
    return float(np.nanmax(g))


def nienhaus_bound(a, c):
    disc = c*c - 4*a*(1-a)
    if disc < 0:
        return np.inf
    x = (c - np.sqrt(disc))/(2*(1-a))
    x = min(max(x, -0.999999), 0.999999)
    return (c + (3*a-1)*x**3 - 3*a*x)/(1-x*x)**1.5


if __name__ == "__main__":
    n = int(sys.argv[1])
    alphas = [float(x) for x in sys.argv[2:]] or [0.28, 0.29, 0.295, 0.30, 0.31, 0.32, 0.33, 0.3333]
    rs = int(__import__('os').environ.get('RESTARTS', '24'))
    it = int(__import__('os').environ.get('ITERS', '250'))
    t = time.time()
    pr = Prob(n)
    log(f"gammamax n={n} dim V13={pr.d13} dim V<=0={pr.d0} setup {time.time()-t:.1f}s "
        f"restarts={rs} iters={it}")
    for a in alphas:
        t = time.time()
        rng = np.random.default_rng(7 + int(a*1e6))
        Pv, y = pr.maximise(a, rng, restarts=rs, iters=it)
        g = R23*Pv
        cb = coupled_bound(a, n)
        nb = nienhaus_bound(a, R23*theta0(n))
        d = pr.report(y, a)
        log(f"n={n} alpha={a:.4f}  TRUE sup gamma={g:.6f}   coupled={cb:.6f}  "
            f"nienhaus={nb:.6f}  min={min(cb,nb):.6f}  requirement={requirement(a):.6f}  "
            f"[{'BOUND OK' if g <= min(cb,nb)+1e-9 else '*** BOUND VIOLATED ***'}] "
            f"[{'stmt ok' if g < requirement(a) else '*** STATEMENT FAILS ***'}]  "
            f"argmax: cosb={d['cosb']:.4f} sinb={d['sinb']:.4f} mu={d['m']:.4f} c0={d['c0']:.4f} "
            f"a_chk={d['alpha_check']:.6f}  ({time.time()-t:.0f}s)")
