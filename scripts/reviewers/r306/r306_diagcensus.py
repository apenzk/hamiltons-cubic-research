"""Independent diagonal census: solve the n x n criticality equation from random
seeds, then test  Delta > 0  =>  lambda_max(L_e | M-perp) > 1/2   (V3, diagonal half)."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r306_defs as R
from scipy.optimize import least_squares

n = int(sys.argv[1]); NST = int(sys.argv[2]); SEED = int(sys.argv[3])
rng = np.random.default_rng(SEED)
bas = R.adm_basis(n); k = len(bas)
Bstack = np.array([b.ravel() for b in bas])


def build(y):
    return (y @ Bstack).reshape(n, n)


def resid(y):
    M = build(y); th = R.theta_diag(M)
    G = R.hollow(R.Phi(M)) - th * M
    return np.append(Bstack @ G.ravel(), np.sum(M * M) - 2.0)


def delta(M, tol=1e-9):
    tot = 0.0
    for a in range(n):
        for b in range(a + 1, n):
            if M[a, b] > tol:
                tot += 2 * np.sum((M[a] - M[b]) ** 2) - 4 * M[a, b] ** 2
    return tot


best = []
worst = (1e9, None)
viol = 0
for t in range(NST):
    y0 = rng.normal(size=k); y0 = y0 / np.linalg.norm(y0) * np.sqrt(2)
    s = least_squares(resid, y0, xtol=1e-15, ftol=1e-15, gtol=1e-15)
    if np.max(np.abs(resid(s.x))) > 1e-11:
        continue
    M = build(s.x); th = R.theta_diag(M)
    if th <= 1e-8:
        continue
    Dl = delta(M)
    lam, _ = R.diag_lam_max(M, th)
    if Dl > 1e-7:
        viol += 1
        if lam < worst[0]:
            worst = (lam, (th, Dl))
        if lam <= 0.5 + 1e-9:
            print(f'*** V3 REFUTED ON THE DIAGONAL LOCUS: theta={th:.9f} Delta={Dl:.6f} lam_max={lam:.9f}', flush=True)
            np.save(f'/tmp/r306_v3_refuter_n{n}_{t}.npy', M)
    best.append((th, Dl, lam))
print(f'n={n}: {len(best)} critical points with theta>0, {viol} with Delta>0')
if viol:
    print(f'   minimum lambda_max(L_e) over the Delta>0 points: {worst[0]:.9f}  (theta={worst[1][0]:.6f}, Delta={worst[1][1]:.6f})')
z = [b for b in best if b[1] <= 1e-7]
if z:
    print(f'   Delta=0 points: {len(z)}, lambda_max range [{min(b[2] for b in z):.6f}, {max(b[2] for b in z):.6f}]')
