"""r274, Claim 2: the concentration claim, on GENUINE Weyl tensors, by optimisation.

  F(M) = (tr(M^3) + ||M#||_F) / theta_0(n)      the record's proposed bound, as a ratio
  G(M) = theta(M) / theta_0(n)                   the record's "exact statement to prove"
maximised over the unit sphere of Weyl_n by Riemannian gradient ascent with restarts.
Brief: F > 1.005 anywhere refutes "the difficulty sits entirely where the conjecture is tight".
"""
import numpy as np, sys, time
sys.path.insert(0, __file__.rsplit('/', 1)[0])
from r274_weyl import Geo

def theta0(n): return np.sqrt(2.0*(n-1)*(n-2))/n

def rand_weyl(g, rng):
    A = rng.standard_normal((g.N, g.N)); M = g.proj_weyl(0.5*(A+A.T))
    return M/np.linalg.norm(M)

def ascend(g, M, which, iters=1500, eta0=0.05):
    n = g.n
    for it in range(iters):
        S = g.sharp(M); nS = np.linalg.norm(S)
        if which == 'F':
            val = float(np.trace(M@M@M)) + nS
            grad = 3.0*(M@M) + g.grad_sharpnorm2(M)/(2.0*nS)
        else:
            val = float(np.trace(M@M@M)) + float(np.sum(S*M))
            grad = g.grad_theta(M)
        gr = g.proj_weyl(grad); gr = gr - np.sum(gr*M)*M
        ng = np.linalg.norm(gr)
        if ng < 1e-12: break
        eta = eta0
        for _ in range(40):
            X = M + eta*gr; X = g.proj_weyl(X); X = X/np.linalg.norm(X)
            S2 = g.sharp(X)
            v2 = float(np.trace(X@X@X)) + (np.linalg.norm(S2) if which=='F' else float(np.sum(S2*X)))
            if v2 > val: break
            eta *= 0.5
        else:
            break
        M = X
    return M, val

for n in (6, 8, 10, 12):
    g = Geo(n); t0 = theta0(n); rng = np.random.default_rng(20260831 + n)
    print(f"\n===== n={n},  N={g.N},  theta_0={t0:.6f} =====")
    # (i) the record's screen, redone on genuine Weyl tensors
    vals = []
    for s in range(40):
        M = rand_weyl(g, rng)
        S = g.sharp(M)
        vals.append(((float(np.trace(M@M@M))+np.linalg.norm(S))/t0,
                     (float(np.trace(M@M@M))+float(np.sum(S*M)))/t0))
    vals = np.array(vals)
    print(f" 40 random unit WEYL tensors: (tr+|M#|)/theta_0  mean {vals[:,0].mean():.4f}"
          f"  max {vals[:,0].max():.4f} | theta/theta_0 mean {vals[:,1].mean():+.4f} max {vals[:,1].max():+.4f}")
    # (ii) optimisation
    for which, lab in (('F', '(tr(M^3)+|M#|_F)/theta_0'), ('T', 'theta/theta_0')):
        best = -9; bM = None
        t = time.time()
        for s in range(12):
            M0 = rand_weyl(g, rng)
            M, v = ascend(g, M0, which)
            r = v/t0
            if r > best: best, bM = r, M
        S = g.sharp(bM)
        print(f"  max {lab:26s} = {best:.6f}   [theta there = {float(np.trace(bM@bM@bM))+float(np.sum(S*bM)):.6f},"
              f" |M#|={np.linalg.norm(S):.6f}, cos phi={float(np.sum(S*bM))/np.linalg.norm(S):.6f}]  ({time.time()-t:.0f}s)")
        np.save(f"scripts/reviewers/r274/best_{which}_n{n}.npy", bM)
