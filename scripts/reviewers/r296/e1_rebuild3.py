"""E1 rebuild with my own Levenberg-Marquardt (scipy's dense SVD is pathological here)."""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c

n, p = 8, 3
basis, Pi, Mi = c.block_basis(n, p)
d = basis.shape[0]
cst = c.cst(n)
print(f"dim V = {d}, dim p = {len(Pi)}, dim m = {len(Mi)}", flush=True)


def W_of(x):
    return np.einsum('a,aij->ij', x, basis)


def resid(x):
    W = W_of(x); QW = c.Q(n, W); th = float(np.tensordot(QW, W))
    return np.append(np.einsum('aij,ij->a', basis, QW - th * W), float(x @ x) - 1.0)


def jac(x):
    W = W_of(x); QW = c.Q(n, W); th = float(np.tensordot(QW, W))
    DQ = np.array([W @ B + B @ W + 2.0 * c.sharp_bil(n, W, B) for B in basis])
    M = np.einsum('aij,bij->ab', basis, DQ)
    gq = np.einsum('ij,bij->b', QW, basis); Bw = np.einsum('aij,ij->a', basis, W)
    return np.vstack([M - 3.0 * np.outer(Bw, gq) - th * np.eye(d), 2.0 * x])


def lm(x, iters=300, mu0=1e-3):
    F = resid(x); f = F @ F; mu = mu0
    for _ in range(iters):
        J = jac(x)
        A = J.T @ J; g = J.T @ F
        for _ in range(40):
            try:
                dx = np.linalg.solve(A + mu * np.eye(d), -g)
            except np.linalg.LinAlgError:
                mu *= 10; continue
            xn = x + dx; Fn = resid(xn); fn = Fn @ Fn
            if fn < f:
                x, F, f = xn, Fn, fn; mu = max(mu * 0.3, 1e-14); break
            mu *= 10
        else:
            break
        if np.sqrt(f) < 1e-13:
            break
    return x, np.sqrt(f)


D = np.zeros(28); lab = [0]*3 + [1]*5
for a, (i, j) in enumerate(c.pairs_of(n)):
    D[a] = 1.0/((3 if lab[i] == 0 else 5)*((3 if lab[i] == 0 else 5)-1)) \
        if lab[i] == lab[j] else -1.0/15.0
W0 = np.diag(D); W0 /= np.linalg.norm(W0)
c0 = np.einsum('aij,ij->a', basis, W0)
print(f"control: |resid(c0)| = {np.abs(resid(c0)).max():.2e}", flush=True)

rng = np.random.default_rng(20260901)
found = {}
t0 = time.time()
NS = int(sys.argv[1]) if len(sys.argv) > 1 else 60
for t in range(NS):
    x = (c0 + 0.5*rng.normal(size=d)) if t < NS//2 else rng.normal(size=d)
    x /= np.linalg.norm(x)
    x, r = lm(x)
    if r < 1e-11:
        W = W_of(x); W /= np.linalg.norm(W)
        th = float(np.tensordot(c.Q(n, W), W))
        if th < 0:
            W, th = -W, -th
        found.setdefault(round(th, 7), W)
    if t % 5 == 0 or r < 1e-11:
        print(f"  start {t:3d} resid {r:.1e} distinct {len(found)} {time.time()-t0:.0f}s",
              flush=True)

print(f"\n{'theta':>12}{'fullres':>10}{'bianchi':>10}{'ricci':>10}{'dimm':>6}"
      f"{'#0':>4}{'S_mmm':>10}{'S_mpp':>10}{'Delta':>9}{'#pos':>5}{'graded':>8}", flush=True)
for k in sorted(found, reverse=True):
    W = found[k]
    lam, V = np.linalg.eigh(W)
    cE = np.einsum('ia,jb,kg,ijk->abg', V, V, V, cst); T = cE**2
    g = np.einsum('dab,ab->d', T, (lam[:, None]-lam[None, :])**2)
    pos, neg = lam > 1e-9, lam < -1e-9
    bi, ri, tr = c.weyl_residuals(n, W)
    smmm = T[np.ix_(neg, neg, neg)].sum(); smpp = T[np.ix_(neg, pos, pos)].sum()
    print(f"{k:12.7f}{np.abs(c.Q(n,W)-k*W).max():10.1e}{bi:10.1e}{ri:10.1e}"
          f"{int(neg.sum()):6d}{int((np.abs(lam)<=1e-9).sum()):4d}{smmm:10.1e}{smpp:10.1e}"
          f"{g[pos].sum():9.4f}{len(set(np.round(lam[pos],7))):5d}"
          f"{'YES' if max(smmm,smpp) < 1e-16 else 'no':>8}", flush=True)
np.save('scripts/reviewers/r296/rebuilt.npy',
        np.array([found[k] for k in sorted(found, reverse=True)]))
