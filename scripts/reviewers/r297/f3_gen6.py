"""F3, non-diagonal front: general (non-diagonal) critical points at n=6, Delta and lambda_max."""
import sys; sys.path.insert(0, 'scripts/reviewers/r297')
import numpy as np, core297 as C
from scipy.optimize import least_squares

n = 6; B = C.weyl(n); d = B.shape[0]
Bf = B.reshape(d, -1)
def resid(co):
    W = (co @ Bf).reshape(15, 15); nr = np.linalg.norm(W); W = W / nr
    th = C.Pval(n, W)
    return np.append((C.Qmap(n, W) - th * W).reshape(-1), 10.0 * (nr - 1.0))

rng = np.random.default_rng(4297); seen = {}; conv = 0
for t in range(18):
    co0 = rng.normal(size=d); co0 /= np.linalg.norm(co0)
    s = least_squares(resid, co0, xtol=1e-13, ftol=1e-13, gtol=1e-13, max_nfev=3000)
    W = (s.x @ Bf).reshape(15, 15); W /= np.linalg.norm(W)
    th = C.Pval(n, W); r = np.linalg.norm(C.Qmap(n, W) - th * W)
    if r > 1e-10 or abs(th) < 1e-6:
        continue
    conv += 1
    D, tot, lam = C.Delta(n, W)
    sp, _, _, _ = C.le_spectrum_perp(n, W, th)
    orb = C.rowspace(C.orbit_tangent(n, W)).shape[0]
    offdiag = np.abs(W - np.diag(np.diag(W))).max()
    key = (round(th, 6), round(D, 4), round(sp.max(), 6), orb,
           int((lam < -1e-9).sum()), int((np.abs(lam) <= 1e-9).sum()), offdiag > 1e-9)
    seen[key] = seen.get(key, 0) + 1
    print(f"  t={t:2d} theta={th:.6f} res={r:.1e} Delta={D:8.4f} lam_max={sp.max():9.6f} "
          f"orbit={orb:2d} dim m={key[4]:2d} #0={key[5]:2d} nondiag={key[6]}", flush=True)
print(f"\nconverged {conv} of 18")
good = [k for k in seen if k[1] > 1e-7 and k[2] <= 0.5 + 1e-8]
nd = [k for k in seen if k[6] and k[1] > 1e-7]
print(f"non-diagonal with Delta>0: {len(nd)} classes; of those satisfying Lemma 24: "
      f"{len([k for k in nd if k[2] <= 0.5+1e-8])}")
print(f"ANY Delta>0 satisfying Lemma 24: {len(good)} -> {good}")
