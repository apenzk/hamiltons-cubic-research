"""E2 attack, fast: (i) instrument control table, (ii) hard descent to diagonalise W."""
import sys, time
import numpy as np
from scipy.linalg import expm
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c
from e2_plucker import wedge_norm, eigenspace, PRS

n = 8
IDX = {p: a for a, p in enumerate(PRS)}
I = np.array([p[0] for p in PRS]); J = np.array([p[1] for p in PRS])
AD = c.ad(n)                       # AD[k] = ad(phi_k) on Lambda^2


def lam2(R):
    return R[np.ix_(I, I)] * R[np.ix_(J, J)] - R[np.ix_(I, J)] * R[np.ix_(J, I)]


def offmass2(Y):
    d = np.diag(np.diag(Y))
    return float(np.sum((Y - d) ** 2))


def descend(W, starts=200, iters=1500, seed=0, spread=2.0, label=''):
    rng = np.random.default_rng(seed)
    best = np.inf; t0 = time.time()
    for s in range(starts):
        A0 = rng.normal(size=(n, n)) * (0.0 if s == 0 else spread)
        R = expm(A0 - A0.T)
        L = lam2(R); Y = L.T @ W @ L
        f = offmass2(Y); step = 0.3
        for _ in range(iters):
            Yo = Y - np.diag(np.diag(Y))
            C = Yo @ Y - Y @ Yo
            g = 2.0 * np.einsum('kmn,nm->k', AD, C)
            if np.linalg.norm(g) < 1e-14:
                break
            Ask = np.zeros((n, n))
            for k, (i, j) in enumerate(PRS):
                Ask[i, j] += g[k]; Ask[j, i] -= g[k]
            # ad(phi_k) = -AD[k] with these structure constants, so try BOTH signs
            moved = False
            for sgn in (+1.0, -1.0):
                Rn = R @ expm(-sgn * step * Ask)
                Ln = lam2(Rn); Yn = Ln.T @ W @ Ln; fn = offmass2(Yn)
                if fn < f:
                    R, Y, f = Rn, Yn, fn; step *= 1.3; moved = True
                    break
            if not moved:
                step *= 0.5
            if step < 1e-16:
                break
        best = min(best, f)
    print(f"   {label:36s} best off-diagonal mass^2 {best:.3e}  (mass {np.sqrt(best):.3e})"
          f"  [{starts} starts, {time.time()-t0:.0f}s]", flush=True)
    return best


def circ(E, m=4001, half=True):
    Qm, _ = np.linalg.qr(np.array(E).T)
    E = Qm.T[:2]
    v = [wedge_norm(np.cos(t) * E[0] + np.sin(t) * E[1], half=half)
         for t in np.linspace(0, np.pi, m)]
    return min(v), max(v)


def vec(d):
    v = np.zeros(28)
    for k, x in d.items():
        v[IDX[k]] = x
    return v


if __name__ == '__main__':
    r2 = 1 / np.sqrt(2)
    print("A. instrument control table (repo half-convention == plucker_min)")
    dec1 = vec({(0, 1): 1.0}); dec2 = vec({(2, 3): 1.0})
    r4a = vec({(0, 1): r2, (2, 3): r2}); r4b = vec({(0, 2): r2, (1, 3): -r2})
    r4c = vec({(0, 1): r2, (2, 3): -r2})     # anti-self-dual
    for lab, E in [("two decomposables", [dec1, dec2]),
                   ("decomposable + rank 4", [dec1, r4b]),
                   ("two orthogonal rank-4 (self-dual pair)", [r4a, r4b]),
                   ("self-dual + anti-self-dual rank 4", [r4a, r4c])]:
        lo, hi = circ(E); print(f"   {lab:40s} min {lo:.6f}  max {hi:.6f}")
    for s in range(4):
        rg = np.random.default_rng(s); E = np.zeros((2, 28))
        for k in range(2):
            for pr in [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]:
                E[k, IDX[pr]] = rg.normal()
        lo, hi = circ(E)
        print(f"   generic plane in a coordinate R^4, seed {s}      min {lo:.6f}  max {hi:.6f}")

    W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
    L0 = np.linalg.eigvalsh(W)[0]
    E, _ = eigenspace(W, L0)
    print("\nB. the witness's plane")
    lo, hi = circ(E, half=True); print(f"   repo/half min {lo:.10f} max {hi:.10f}")
    lo, hi = circ(E, half=False); print(f"   standard  min {lo:.10f} max {hi:.10f}")

    print("\nC. descent: can any frame diagonalise it?")
    D = np.zeros(28)
    lab = [0]*3 + [1]*5
    for a, (i, j) in enumerate(PRS):
        if lab[i] == lab[j]:
            p = 3 if lab[i] == 0 else 5; D[a] = 1.0/(p*(p-1))
        else:
            D[a] = -1.0/15.0
    Wd = np.diag(D); Wd /= np.linalg.norm(Wd)
    rng = np.random.default_rng(11)
    A = rng.normal(size=(8, 8)); Rr = expm(0.9*(A - A.T))
    Lr = lam2(Rr); Wrot = Lr.T @ Wd @ Lr
    print(f"   [control] rotated S^3xS^5 starts at mass"
          f" {np.sqrt(offmass2(Wrot)):.4f}", flush=True)
    descend(Wrot, starts=20, iters=3000, seed=1, label='control: rotated S^3 x S^5')
    descend(W, starts=200, iters=3000, seed=2, label='THE WITNESS')
