"""Can any orthonormal frame diagonalise the witness?  Descent over O(8), with control."""
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


def descend(W, starts, iters, seed, label):
    rng = np.random.default_rng(seed); best = np.inf; t0 = time.time(); hist = []
    for s in range(starts):
        A0 = rng.normal(size=(n, n))*(0.0 if s == 0 else 2.0)
        R = expm(A0 - A0.T); L = lam2(R); Y = L.T @ W @ L
        f = off2(Y); step = 0.3
        for _ in range(iters):
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
    hist = np.sort(hist)
    print(f"{label}: best mass {np.sqrt(best):.6e}   deciles "
          f"{np.round(hist[::max(1,len(hist)//10)],4)}   [{starts} starts,"
          f" {time.time()-t0:.0f}s]", flush=True)
    return np.sqrt(best)


W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
D = np.zeros(28); lab = [0]*3 + [1]*5
for a, (i, j) in enumerate(PRS):
    q = 3 if lab[i] == 0 else 5
    D[a] = 1.0/(q*(q-1)) if lab[i] == lab[j] else -1.0/15.0
Wd = np.diag(D); Wd /= np.linalg.norm(Wd)
rng = np.random.default_rng(11); A = rng.normal(size=(8, 8)); Rr = expm(0.9*(A - A.T))
Lr = lam2(Rr); Wrot = Lr.T @ Wd @ Lr
print(f"control starts at mass {np.sqrt(off2(Wrot)):.4f}", flush=True)
descend(Wrot, 25, 3000, 1, "control: rotated S^3 x S^5")
descend(W, 250, 3000, 2, "THE WITNESS")
