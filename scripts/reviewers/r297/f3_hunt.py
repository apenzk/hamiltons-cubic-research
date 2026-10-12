"""F3 attack: is there a critical point with Delta > 0 that SATISFIES lambda_max <= 1/2?
If none exists, the inference F3 declares impossible is exactly what the data supports."""
import sys; sys.path.insert(0, 'scripts/reviewers/r297')
import numpy as np, core297 as C
from scipy.optimize import least_squares

def stats(n, W):
    W = W / np.linalg.norm(W)
    th = C.Pval(n, W); res = np.linalg.norm(C.Qmap(n, W) - th * W)
    D, tot, lam = C.Delta(n, W)
    sp, _, _, _ = C.le_spectrum_perp(n, W, th)
    k = C.rowspace(C.orbit_tangent(n, W)).shape[0]
    nz = int((np.abs(lam) <= 1e-9).sum())
    return th, res, D, sp.max(), k, nz, int((lam < -1e-9).sum())

print("=== structured points: multi-block products and padded CP^2 ===")
rows = []
for blocks in ([2,4],[2,6],[3,3,3],[2,2,4],[2,2,2,2]):
    W, n = C.sphere_product(blocks)
    rows.append((f"S^" + "xS^".join(map(str, blocks)), n, W))
def pad(W0, n0, n):
    p0 = C.pairs_of(n0); p1 = C.pairs_of(n); i1 = {p: a for a, p in enumerate(p1)}
    W = np.zeros((len(p1), len(p1)))
    for a, (i, j) in enumerate(p0):
        for b, (k, l) in enumerate(p0):
            W[i1[(i, j)], i1[(k, l)]] = W0[a, b]
    return W
W0, _ = C.cpm(2)
for n in (6, 8):
    rows.append((f"CP^2 padded n={n}", n, pad(W0, 4, n)))
W0, _ = C.sphere_product([3,3])
rows.append(("S^3xS^3 padded n=8", 8, pad(W0, 6, 8)))
rows.append(("C_5 blow-up", 10, C.c5_blowup()[0]))

hdr = f"  {'point':22s}{'n':>3s}{'theta':>10s}{'res':>9s}{'Delta':>9s}{'lam_max':>11s}{'orbit':>6s}{'#0':>4s}{'dim m':>6s}  Lemma24"
print(hdr)
for lbl, n, W in rows:
    th, res, D, lm, k, nz, dm = stats(n, W)
    ok = "holds" if lm <= 0.5 + 1e-8 else "FAILS"
    print(f"  {lbl:22s}{n:>3d}{th:>10.6f}{res:>9.1e}{D:>9.4f}{lm:>11.6f}{k:>6d}{nz:>4d}{dm:>6d}  {ok}")

print("\n=== hunt: converged critical points at n=6 from random starts ===")
n = 6; B = C.weyl(n); d = B.shape[0]
def resid(co):
    W = np.tensordot(co, B, axes=([0],[0])); nr = np.linalg.norm(W)
    W = W / nr
    th = C.Pval(n, W)
    R = C.Qmap(n, W) - th * W
    return np.append(R.reshape(-1), 10.0 * (nr - 1.0))
rng = np.random.default_rng(1297)
found = []
for t in range(40):
    co0 = rng.normal(size=d); co0 /= np.linalg.norm(co0)
    s = least_squares(resid, co0, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=400)
    W = np.tensordot(s.x, B, axes=([0],[0])); W /= np.linalg.norm(W)
    th = C.Pval(n, W); r = np.linalg.norm(C.Qmap(n, W) - th * W)
    if r < 1e-10 and abs(th) > 1e-6:
        found.append((th, r, W))
print(f"  converged: {len(found)} of 40")
tab = []
for th, r, W in found:
    t2, res, D, lm, k, nz, dm = stats(n, W)
    tab.append((round(t2, 6), round(D, 5), round(lm, 6), k, nz, dm))
seen = {}
for row in tab:
    seen[row] = seen.get(row, 0) + 1
print(f"  {'theta':>10s}{'Delta':>10s}{'lam_max':>11s}{'orbit':>6s}{'#0':>4s}{'dim m':>6s}{'count':>7s}  Lemma24")
for row, c in sorted(seen.items()):
    ok = "holds" if row[2] <= 0.5 + 1e-8 else "FAILS"
    print(f"  {row[0]:>10.6f}{row[1]:>10.5f}{row[2]:>11.6f}{row[3]:>6d}{row[4]:>4d}{row[5]:>6d}{c:>7d}  {ok}")
viol = [r for r in seen if r[1] > 1e-7 and r[2] <= 0.5 + 1e-8]
print(f"\n  Delta > 0 AND Lemma-24 bound satisfied: {len(viol)} classes  -> {viol}")
