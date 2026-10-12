"""r308: mass-produce graded critical points and measure ||A||^2 and theta."""
import sys, os, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from scipy.optimize import least_squares
import r308_lib as L


def graded_weyl_basis(n, p):
    idx, pos, N, c = L.struct(n)
    kidx, midx = L.split_indices(n, p, idx)
    sb = L.sym_basis_blocks(N, kidx, midx)
    rows = L.weyl_constraints(n, sb, idx, pos)
    B = L.nullspace_basis(sb, rows)
    return idx, pos, N, c, kidx, midx, B


def make(A, B):
    def unpack(x):
        return np.einsum('a,aij->ij', x, B)

    def resid(x):
        W = unpack(x)
        Q = L.Qop(A, W)
        th = float(np.tensordot(Q, W))
        F = np.einsum('aij,ij->a', B, Q - th * W)
        return np.append(F, float(x @ x) - 1.0)

    def jac(x):
        W = unpack(x)
        Q = L.Qop(A, W)
        th = float(np.tensordot(Q, W))
        DQ = np.array([W @ b + b @ W + 2.0 * L.sharp_bilin(A, W, b) for b in B])
        M = np.einsum('aij,bij->ab', B, DQ)
        gq = np.einsum('ij,bij->b', Q, B)
        Bw = np.einsum('aij,ij->a', B, W)
        J = M - 3.0 * np.outer(Bw, gq) - th * np.eye(len(x))
        return np.vstack([J, 2.0 * x])
    return unpack, resid, jac


def analyse(n, p, W, A, kidx, midx, weylB=None):
    Q = L.Qop(A, W)
    th = float(np.tensordot(Q, W))
    full = float(np.abs(Q - th * W).max())
    Wk = W[np.ix_(kidx, kidx)]
    Wm = W[np.ix_(midx, midx)]
    nA2 = float(np.sum(Wk ** 2))
    nB2 = float(np.sum(Wm ** 2))
    # gradedness defect: S_mmm and S_mpp -- the k/m off-block of W is zero by
    # construction, so gradedness here is automatic; recorded for the record.
    off = float(np.abs(W[np.ix_(kidx, midx)]).max())
    # equivariance defect Delta: distance of W from being scalar on isotypic pieces
    lam = np.linalg.eigvalsh(W)
    npos = len(np.unique(np.round(lam[lam > 1e-9], 6)))
    ndist = len(np.unique(np.round(lam, 6)))
    return dict(theta=th, full=full, nA2=nA2, nB2=nB2, off=off,
                npos=npos, ndist=ndist)


def run(n, p, nstarts=200, kick=0.8, seed=0):
    idx, pos, N, c, kidx, midx, B = graded_weyl_basis(n, p)
    A = L.ad(c)
    unpack, resid, jac = make(A, B)
    W0 = L.sphere_product_W(n, p, idx)
    x0 = np.einsum('aij,ij->a', B, W0)
    ctrl = np.abs(resid(x0)).max()
    print(f"n={n} p={p} q={n-p}  dim graded Weyl = {len(B)}  control resid {ctrl:.2e}",
          flush=True)
    rng = np.random.default_rng(seed)
    pts = []
    for t in range(nstarts):
        x = x0.copy() if t == 0 else rng.normal(size=len(x0))
        x = x / np.linalg.norm(x)
        if t > 0:
            x = x0 + kick * rng.normal(size=len(x0))
        s = least_squares(resid, x, jac=jac, xtol=1e-15, ftol=1e-15, gtol=1e-15,
                          max_nfev=400)
        if np.abs(s.fun).max() > 1e-11:
            continue
        W = unpack(s.x); W = W / np.linalg.norm(W)
        d = analyse(n, p, W, A, kidx, midx)
        if d['theta'] < 0:
            W = -W; d = analyse(n, p, W, A, kidx, midx)
        if d['full'] > 1e-10:
            continue
        d['W'] = W
        pts.append(d)
    return pts, dict(idx=idx, kidx=kidx, midx=midx, A=A, B=B, W0=W0)


def dedup(pts, tol=1e-6):
    out = []
    for d in pts:
        key = (round(d['theta'], 7), round(d['nA2'], 7), d['ndist'])
        if any(k == key for k, _ in out):
            continue
        out.append((key, d))
    return [d for _, d in out]


if __name__ == '__main__':
    n = int(sys.argv[1]); p = int(sys.argv[2])
    ns = int(sys.argv[3]) if len(sys.argv) > 3 else 200
    pts, meta = run(n, p, nstarts=ns)
    u = dedup(pts)
    eq = (p * p + (n - p) ** 2 - n) / ((n - 1.0) * (n - 2.0))
    print(f"  solutions {len(pts)}, distinct {len(u)};  equivariant ||A||^2 = {eq:.6f}")
    print(f"  {'theta':>10s}{'||A||^2':>11s}{'||B||^2':>11s}{'#dist':>6s}{'#pos':>6s}{'res':>10s}")
    for d in sorted(u, key=lambda z: -z['theta']):
        print(f"  {d['theta']:>10.6f}{d['nA2']:>11.6f}{d['nB2']:>11.6f}"
              f"{d['ndist']:>6d}{d['npos']:>6d}{d['full']:>10.1e}")
    if u:
        a = np.array([d['nA2'] for d in u]); t = np.array([d['theta'] for d in u])
        print(f"  ||A||^2 range [{a.min():.6f}, {a.max():.6f}]  spread {a.max()-a.min():.6f}")
        print(f"  theta max {t.max():.6f}   sqrt(3/2) = 1.224745")
    np.save(f"/tmp/r308_pts_{n}_{p}.npy",
            np.array([d['W'] for d in u]) if u else np.zeros((0, 1, 1)))
