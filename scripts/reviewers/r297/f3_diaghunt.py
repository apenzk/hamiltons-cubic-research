"""F3, the decisive test: enumerate critical points with Delta > 0 and ask whether ANY of
them satisfies Lemma 24's bound.  Q preserves the diagonal locus (verified), and there
Weyl_n = {w symmetric, zero diagonal, zero row sums}, so criticality is a small system."""
import sys; sys.path.insert(0, 'scripts/reviewers/r297')
import numpy as np, core297 as C
from scipy.optimize import least_squares

def basis_diag(n):
    """Orthonormal basis of {w sym n x n, zero diag, zero row sums}, as pair-vectors."""
    ps = C.pairs_of(n); N = len(ps)
    rows = []
    for i in range(n):
        r = np.zeros(N)
        for a, (u, v) in enumerate(ps):
            if u == i or v == i: r[a] = 1.0
        rows.append(r)
    A = np.array(rows)
    u, s, vt = np.linalg.svd(A, full_matrices=True)
    r = int((s > 1e-10 * s[0]).sum())
    return vt[r:]                              # (n(n-3)/2, N)

def build(n, B, co):
    w = co @ B
    W = np.diag(w)
    return W / np.linalg.norm(W)

def hunt(n, ntries, seed):
    B = basis_diag(n); d = B.shape[0]
    ps = C.pairs_of(n)
    def resid(co):
        w = co @ B; nr = np.linalg.norm(w)
        W = np.diag(w / nr)
        th = C.Pval(n, W)
        R = np.diag(C.Qmap(n, W)) - th * np.diag(W)
        return np.append(R, 10.0 * (nr - 1.0))
    rng = np.random.default_rng(seed); out = []
    for t in range(ntries):
        co0 = rng.normal(size=d); co0 /= np.linalg.norm(co0)
        s = least_squares(resid, co0, xtol=1e-15, ftol=1e-15, gtol=1e-15)
        W = build(n, B, s.x)
        th = C.Pval(n, W); r = np.linalg.norm(C.Qmap(n, W) - th * W)
        if r < 1e-11 and th > 1e-6:
            out.append((th, W))
    return out

for n, ntries, seed in ((8, 60, 297), (10, 30, 298)):
    pts = hunt(n, ntries, seed)
    print(f"\n=== n={n}: {len(pts)} converged critical points on the diagonal locus ===")
    print(f"  {'theta':>10s}{'Delta':>10s}{'lam_max':>11s}{'orbit':>7s}{'m(1/2)':>8s}{'dim m':>7s}{'#0':>4s}"
          f"{'S_mmm':>10s}  Lemma24   count")
    seen = {}
    for th, W in pts:
        D, tot, lam = C.Delta(n, W)
        sp, _, _, _ = C.le_spectrum_perp(n, W, th)
        orb = C.rowspace(C.orbit_tangent(n, W)).shape[0]
        # S_mmm
        lamv, v = C.eigdata(n, W)
        br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
        cc = (0.5 * np.einsum('abij,cij->abc', br, v)) ** 2
        m = lamv < -1e-9
        S = float(cc[np.ix_(m, m, m)].sum())
        key = (round(th, 6), round(D, 4), round(sp.max(), 6), orb,
               int(np.sum(np.abs(sp - 0.5) < 1e-8)), int(m.sum()),
               int((np.abs(lamv) <= 1e-9).sum()), round(S, 6))
        seen[key] = seen.get(key, 0) + 1
    for k, c in sorted(seen.items()):
        ok = "holds" if k[2] <= 0.5 + 1e-8 else "FAILS"
        print(f"  {k[0]:>10.6f}{k[1]:>10.4f}{k[2]:>11.6f}{k[3]:>7d}{k[4]:>8d}{k[5]:>7d}{k[6]:>4d}"
              f"{k[7]:>10.4f}  {ok:5s}{c:>7d}")
    good = [k for k in seen if k[1] > 1e-7 and k[2] <= 0.5 + 1e-8]
    print(f"  Delta>0 AND Lemma-24 bound satisfied: {len(good)} classes -> {good}")
