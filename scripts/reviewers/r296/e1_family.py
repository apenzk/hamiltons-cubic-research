"""E1/E3: rebuild the high-theta family on V and characterise each member."""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c
from e2_plucker import as_matrix, wedge_norm, eigenspace

n, p = 8, 3
basis, Pi, Mi = c.block_basis(n, p); d = basis.shape[0]
cst = c.cst(n)


def W_of(x): return np.einsum('a,aij->ij', x, basis)


def resid(x):
    W = W_of(x); QW = c.Q(n, W); th = float(np.tensordot(QW, W))
    return np.append(np.einsum('aij,ij->a', basis, QW - th * W), float(x @ x) - 1.0)


def jac(x):
    W = W_of(x); QW = c.Q(n, W); th = float(np.tensordot(QW, W))
    DQ = np.array([W @ B + B @ W + 2.0 * c.sharp_bil(n, W, B) for B in basis])
    M = np.einsum('aij,bij->ab', basis, DQ)
    gq = np.einsum('ij,bij->b', QW, basis); Bw = np.einsum('aij,ij->a', basis, W)
    return np.vstack([M - 3.0 * np.outer(Bw, gq) - th * np.eye(d), 2.0 * x])


def lm(x, iters=400):
    F = resid(x); f = F @ F; mu = 1e-3
    for _ in range(iters):
        J = jac(x); A = J.T @ J; g = J.T @ F
        for _ in range(40):
            dx = np.linalg.solve(A + mu * np.eye(d), -g)
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
    q = 3 if lab[i] == 0 else 5
    D[a] = 1.0/(q*(q-1)) if lab[i] == lab[j] else -1.0/15.0
W0 = np.diag(D); W0 /= np.linalg.norm(W0)
c0 = np.einsum('aij,ij->a', basis, W0)

rng = np.random.default_rng(31415)
found = {}
t0 = time.time()
for t in range(120):
    kick = [0.03, 0.05, 0.07, 0.09][t % 4]
    x = c0 + kick*rng.normal(size=d); x /= np.linalg.norm(x)
    x, r = lm(x)
    if r < 1e-11:
        W = W_of(x); W /= np.linalg.norm(W)
        th = float(np.tensordot(c.Q(n, W), W))
        if th < 0:
            W, th = -W, -th
        if th > 0.5:
            found.setdefault(round(th, 6), W)
print(f"{len(found)} distinct theta above 0.5 from 120 starts, {time.time()-t0:.0f}s",
      flush=True)

hdr = (f"{'theta':>11}{'fullres':>9}{'bian':>8}{'ricci':>8}{'dimm':>5}{'#0':>3}"
       f"{'S_mmm':>9}{'S_mpp':>9}{'Delta':>9}{'#pos':>5}{'graded':>7}{'simple':>7}"
       f"{'rank':>5}{'nondiag':>8}")
print(hdr, flush=True)
for k in sorted(found, reverse=True):
    W = found[k]
    lam, V = np.linalg.eigh(W)
    cE = np.einsum('ia,jb,kg,ijk->abg', V, V, V, cst, optimize=True); T = cE**2
    g = np.einsum('dab,ab->d', T, (lam[:, None]-lam[None, :])**2)
    pos, neg = lam > 1e-9, lam < -1e-9
    bi, ri, tr = c.weyl_residuals(n, W)
    smmm = T[np.ix_(neg, neg, neg)].sum(); smpp = T[np.ix_(neg, pos, pos)].sum()
    # simple eigenvalues and the rank of their eigenvectors (Lemma 37's own test)
    seen = []
    for xx in lam:
        if not seen or abs(xx - seen[-1][0]) > 1e-8:
            seen.append([xx, 1])
        else:
            seen[-1][1] += 1
    nsimple = sum(1 for _, m in seen if m == 1)
    maxrank = 0
    for xx, m in seen:
        if m == 1:
            E, _ = eigenspace(W, xx)
            maxrank = max(maxrank, int((np.linalg.svd(as_matrix(E[0]),
                                                      compute_uv=False) > 1e-8).sum()))
    print(f"{k:11.6f}{np.abs(c.Q(n,W)-k*W).max():9.1e}{bi:8.1e}{ri:8.1e}"
          f"{int(neg.sum()):5d}{int((np.abs(lam)<=1e-9).sum()):3d}{smmm:9.1e}{smpp:9.1e}"
          f"{g[pos].sum():9.4f}{len(set(np.round(lam[pos],7))):5d}"
          f"{'YES' if max(smmm,smpp)<1e-16 else 'no':>7}{nsimple:7d}{maxrank:5d}"
          f"{'YES' if maxrank>2 else '?':>8}", flush=True)
    np.save(f"scripts/reviewers/r296/W_{k:.6f}.npy", W)
