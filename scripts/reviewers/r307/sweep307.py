"""Sweep for critical points on a block-diagonal Weyl subspace, then classify each by its
OWN spectral splitting: p = strictly positive eigenspace, m = strictly negative."""
import sys, time, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *
from solve307 import block_basis, sharp_trace
from cubic307 import cached_TQ
from scipy.optimize import least_squares


def make_fast(TQ):
    d = TQ.shape[0]
    I = np.eye(d)
    def resid(c):
        g = np.einsum('aij,i,j->a', TQ, c, c, optimize=True)
        th = float(g @ c)
        return np.append(g - th*c, c @ c - 1.0)
    def jac(c):
        g = np.einsum('aij,i,j->a', TQ, c, c, optimize=True)
        th = float(g @ c)
        H = 2.0*np.einsum('aib,i->ab', TQ, c, optimize=True)
        J = H - 3.0*np.outer(c, g) - th*I
        return np.vstack([J, 2.0*c])
    return resid, jac


def classify(n, W, tol=1e-8):
    W = W/np.linalg.norm(W)
    QW = W @ W + sharp_trace(n, W, W)
    th = float(np.tensordot(QW, W))
    if th < 0:
        W, th = -W, -th
        QW = W @ W + sharp_trace(n, W, W)
    crit = float(np.abs(QW - th*W).max())
    lam, V = np.linalg.eigh(W)
    mp = lam > tol; mm = lam < -tol; nz = int((~mp & ~mm).sum())
    A2 = float((lam[mp]**2).sum())
    c = cstruct(n)
    Up, Um = V[:, mp], V[:, mm]
    Pp, Pm = Up @ Up.T, Um @ Um.T
    def leak(U1, U2, Pt):
        Br = np.einsum('abg,ai,bj->ijg', c, U1, U2, optimize=True)
        return float(np.abs(Br - np.einsum('ijg,gh->ijh', Br, Pt)).max())
    lk = max(leak(Up, Up, Pp), leak(Up, Um, Pm), leak(Um, Um, Pp))
    return dict(theta=th, crit=crit, dimp=int(mp.sum()), dimm=int(mm.sum()), ker=nz,
                A2=A2, leak=lk, graded=(lk < 1e-7 and nz == 0),
                npos=len(set(np.round(lam[mp], 6))), W=W, lam=lam)


def sweep(n, p, nstarts, seed=1, tag=''):
    B = block_basis(n, p)
    TQ = cached_TQ(n, p, B)
    resid, jac = make_fast(TQ)
    d = B.shape[0]
    # control: the sphere product must be a solution
    c0 = np.einsum('aij,ij->a', B, sphere_product_W(n, p))
    ctl = np.abs(resid(c0)).max()
    print(f'[{tag}] n={n} pair so({p})+so({n-p}) dim={d}  control |resid(S^pxS^q)|={ctl:.2e}', flush=True)
    rng = np.random.default_rng(seed)
    rows = []
    t0 = time.time()
    for t in range(nstarts):
        c = rng.normal(size=d); c /= np.linalg.norm(c)
        s = least_squares(resid, c, jac=jac, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=600)
        if np.abs(s.fun).max() > 1e-11:
            continue
        W = np.einsum('a,aij->ij', s.x, B)
        r = classify(n, W)
        if r['crit'] > 1e-10:
            continue
        rows.append(r)
        if (t+1) % 50 == 0:
            g = [r for r in rows if r['graded']]
            print(f'  [{tag}] {t+1}/{nstarts} solved={len(rows)} graded={len(g)} '
                  f'({time.time()-t0:.0f}s)', flush=True)
    return rows, B


if __name__ == '__main__':
    n = int(sys.argv[1]); p = int(sys.argv[2]); ns = int(sys.argv[3])
    seed = int(sys.argv[4]) if len(sys.argv) > 4 else 1
    rows, B = sweep(n, p, ns, seed, tag=f'{n}/{p}')
    g = [r for r in rows if r['graded']]
    print(f'\nsolved {len(rows)}, graded {len(g)}')
    print(f"{'theta':>10}{'dimp':>6}{'ker':>5}{'#pos':>6}{'|A|^2':>12}{'leak':>10}")
    seen = {}
    for r in sorted(g, key=lambda r: -r['theta']):
        k = (round(r['theta'], 8), r['dimp'], round(r['A2'], 8))
        if k in seen:
            seen[k] += 1; continue
        seen[k] = 1
        print(f"{r['theta']:>10.6f}{r['dimp']:>6}{r['ker']:>5}{r['npos']:>6}"
              f"{r['A2']:>12.6f}{r['leak']:>10.1e}")
    np.save(f'scripts/reviewers/r307/sweep_n{n}_p{p}_s{seed}.npy',
            np.array([r['W'] for r in rows]))
