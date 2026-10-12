"""Diagonalisation descent on the witness alone (control validated in e2_diaghunt.py)."""
import sys, time
import numpy as np
from scipy.linalg import expm
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c
from e2_plucker import PRS

n = 8
AD = c.ad(n)
I = np.array([p[0] for p in PRS]); J = np.array([p[1] for p in PRS])


def lam2(R):
    return R[np.ix_(I, I)]*R[np.ix_(J, J)] - R[np.ix_(I, J)]*R[np.ix_(J, I)]


def off2(Y):
    return float(np.sum((Y - np.diag(np.diag(Y)))**2))


W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
starts = int(sys.argv[1]) if len(sys.argv) > 1 else 40
rng = np.random.default_rng(7)
best, hist, t0 = np.inf, [], time.time()
for s in range(starts):
    A0 = rng.normal(size=(n, n))*(0.0 if s == 0 else 2.0)
    R = expm(A0 - A0.T); L = lam2(R); Y = L.T @ W @ L
    f = off2(Y); step = 0.3
    for _ in range(2500):
        Yo = Y - np.diag(np.diag(Y)); C = Yo @ Y - Y @ Yo
        g = 2.0*np.einsum('kmn,nm->k', AD, C)
        if np.linalg.norm(g) < 1e-15:
            break
        Ask = np.zeros((n, n))
        for k, (i, j) in enumerate(PRS):
            Ask[i, j] += g[k]; Ask[j, i] -= g[k]
        moved = False
        for sgn in (1.0, -1.0):
            Rn = R @ expm(-sgn*step*Ask); Ln = lam2(Rn)
            Yn = Ln.T @ W @ Ln; fn = off2(Yn)
            if fn < f:
                R, Y, f = Rn, Yn, fn; step *= 1.3; moved = True; break
        if not moved:
            step *= 0.5
        if step < 1e-16:
            break
    hist.append(np.sqrt(f)); best = min(best, f)
h = np.sort(hist)
print(f"WITNESS: best off-diagonal mass {np.sqrt(best):.6f} over {starts} starts;"
      f" deciles {np.round(h[::max(1,len(h)//10)], 4)}  [{time.time()-t0:.0f}s]")
