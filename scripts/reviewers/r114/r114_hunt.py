import numpy as np, sys, os, time, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r114_core import *
from scipy.optimize import least_squares

n = 6
S = Setup(n)
prs, idx = pair_index(n)
B, _, _ = weyl_basis(n)
D = np.diag([1.0 if ((i < 3 and j < 3) or (i >= 3 and j >= 3)) else -1.0 for (i, j) in prs])
G = np.array([[np.sum(B[k] * (D @ B[l] @ D)) for l in range(84)] for k in range(84)])
w, U = np.linalg.eigh(G)
Cv = U[:, w > 0].T                      # 45 x 84
C = np.einsum('kj,jab->kab', Cv, B)     # 45 orthonormal Weyl^sigma basis matrices
d = C.shape[0]
print("dim Weyl^sigma =", d, flush=True)

def M_of(x):
    return np.einsum('k,kab->ab', x, C)

def resid(x):
    M = M_of(x)
    th = S.theta(M)
    R = S.Q(M) - th * M
    r = np.einsum('kab,ab->k', C, R)
    return np.concatenate([r, [np.sum(x * x) - 1.0]])

rng = np.random.default_rng(114)
sols = []
t0 = time.time()
NST = 400
for t in range(NST):
    x0 = rng.standard_normal(d); x0 /= np.linalg.norm(x0)
    out = least_squares(resid, x0, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=20000)
    M = M_of(out.x); M = M / np.linalg.norm(M)
    th = S.theta(M)
    fullres = np.linalg.norm(S.Q(M) - th * M)          # residual in the FULL space
    if fullres > 1e-12:
        continue
    ev = np.linalg.eigvalsh(M)
    rep = grading_report(S, M)
    sols.append(dict(theta=float(th), res=float(fullres),
                     Smmm=float(rep['S']), Thhm=float(rep['T']['hhm']),
                     dh=int(rep['dim_h']), dm=int(rep['dim_m']), dz=int(rep['dim_ker']),
                     mingap=float(min(abs(e) for e in ev if abs(e) > 1e-9)),
                     minabs=float(np.abs(ev).min()),
                     x=out.x.tolist()))
    if (t + 1) % 50 == 0:
        print(f"start {t+1}/{NST} converged={len(sols)} t={time.time()-t0:.0f}s", flush=True)
print("converged", len(sols), "of", NST, flush=True)
json.dump(sols, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'sols.json'), 'w'))
