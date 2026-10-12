"""Reviewer 21 (f): direct maximisation of the TRUE gamma on the exact constraint set.

W = c W1 + s W2, W1 unit in V_{1/3}, W2 unit in V_{<=0}, and the alpha constraint
alpha = (1-s^2)/3 + s^2 mu (mu = <F_u W2,W2>/theta*) is solved for s exactly:
s^2 = eps/(1/3 - mu).  Then gamma = sqrt(2/3) P(W).  Riemannian ascent on the two
spheres with random restarts; ascent gives a LOWER bound on the true sup, which is
the right direction for hunting a counterexample to the requirement.
Usage: review_r21_gammamax.py n restarts iters alpha ..."""
import sys, time
import numpy as np
from review_r21_core import Setup, unit

n = int(sys.argv[1]); NR = int(sys.argv[2]); IT = int(sys.argv[3])
alphas = [float(x) for x in sys.argv[4:]]
R23 = np.sqrt(2.0/3.0); SQ32 = np.sqrt(1.5)
t0 = time.time()
S = Setup(n).precompute()
Vle = np.ascontiguousarray(np.hstack([S.Vker, S.Vneg]))
Ele = np.ascontiguousarray(S.Eflat.T @ Vle)
Fle = np.diag(S.ratios[np.abs(S.ratios) < 1e-7].tolist() + S.ratios[S.ratios < -1e-7].tolist())
fle = np.concatenate([S.ratios[np.abs(S.ratios) < 1e-7], S.ratios[S.ratios < -1e-7]])
print(f"[{time.time()-t0:5.1f}s] dim V<=0 = {Vle.shape[1]}", flush=True)

def matle(y):
    X = (Ele @ y).reshape(S.Nl, S.Nl); return 0.5*(X+X.T)
def ple(X):
    return Ele.T @ X.reshape(-1)

def gamma_of(y1, y2, eps):
    mu = float(fle @ (y2**2))
    s2 = eps / (1.0/3.0 - mu)
    s2 = min(max(s2, 0.0), 1.0)
    s = np.sqrt(s2); c = np.sqrt(1-s2)
    W = c*S.mat13(y1) + s*matle(y2)
    return R23*float(np.sum(W*S.Q(W))), s, mu, W, c

def ascend(y1, y2, eps, iters):
    val = -9e9
    for it in range(iters):
        v, s, mu, W, c = gamma_of(y1, y2, eps)
        QW = S.Q(W)
        # gradient of P(W)=<W,Q(W)> is 3 Q(W); chain through W = c W1 + s W2
        g1 = S._p13(QW)
        g2 = ple(QW)
        # s depends on y2 through mu; include that derivative
        # dP/dy2 = 3 s P_le Q(W) + (dP/ds - (c/s)*... ) handled by a line search below
        step = 0.35
        y1n = unit(y1 + step*unit(g1 - (g1@y1)*y1)) if np.linalg.norm(g1-(g1@y1)*y1) > 1e-14 else y1
        y2n = unit(y2 + step*unit(g2 - (g2@y2)*y2)) if np.linalg.norm(g2-(g2@y2)*y2) > 1e-14 else y2
        best = (v, y1, y2)
        for st in (1.0, 0.5, 0.25, 0.1, 0.03):
            c1 = unit(y1 + st*unit(g1 - (g1@y1)*y1))
            c2 = unit(y2 + st*unit(g2 - (g2@y2)*y2))
            for (a1, a2) in ((c1, c2), (c1, y2), (y1, c2)):
                vv = gamma_of(a1, a2, eps)[0]
                if vv > best[0]: best = (vv, a1, a2)
        if best[0] <= val + 1e-14:
            val = best[0]; y1, y2 = best[1], best[2]
            break
        val, y1, y2 = best
    return val, y1, y2

rng = np.random.default_rng(4242)
print(f"  {'alpha':>8} {'gamma_max':>12} {'requirement':>12} {'ratio':>8} {'s':>7} {'mu':>8} {'c0^2':>7}", flush=True)
for a in alphas:
    eps = 1.0/3.0 - a
    best = (-9e9, None, None)
    for r in range(NR):
        y1 = unit(rng.normal(size=S.d13)); y2 = unit(rng.normal(size=Vle.shape[1]))
        v, yy1, yy2 = ascend(y1, y2, eps, IT)
        if v > best[0]: best = (v, yy1, yy2)
    v, yy1, yy2 = best
    _, s, mu, W, c = gamma_of(yy1, yy2, eps)
    c0sq = float(np.sum(yy2[:S.dker]**2))
    req = (3-5*a)/np.sqrt(3)
    print(f"  {a:>8.5f} {v:>12.9f} {req:>12.9f} {v/req:>8.4f} {s:>7.4f} {mu:>8.4f} {c0sq:>7.4f}", flush=True)
print(f"[{time.time()-t0:5.1f}s] done", flush=True)
