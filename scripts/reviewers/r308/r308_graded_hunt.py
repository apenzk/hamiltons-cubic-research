"""r308: targeted hunt for GRADED critical points.

A critical point W that is block-diagonal for a symmetric pair k (+) m of so(n) and
has W|k positive definite, W|m negative definite has p = k and m = m as its sign
eigenspaces, hence is graded by the brief's definition -- automatically, with no
bracket test needed.  Every graded critical point of type (p,q) is conjugate to one
of these, so the search is exhaustive up to conjugacy.
"""
import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import r308_lib as L
import r308_fast as F
import r308_hunt as H
import r308_grade as G


def run(n, p, nstarts=1500, seed=0, kicks=(0.05, 0.1, 0.2, 0.35, 0.5, 0.8, 1.2),
        tol=1e-12, log_every=100):
    idx, pos, N, c, kidx, midx, B = F.graded_basis(n, p)
    Ad = L.ad(c)
    T = F.cubic_tensor(c, B)
    W0 = L.sphere_product_W(n, p, idx)
    x0 = np.einsum('aij,ij->a', B, W0)
    eq = (p * p + (n - p) ** 2 - n) / ((n - 1.0) * (n - 2.0))
    print(f"n={n} pair so({p})+so({n-p})  dim {len(B)}  equivariant ||A||^2 = {eq:.6f}",
          flush=True)
    rng = np.random.default_rng(seed)
    found = {}
    t0 = time.time()
    for t in range(nstarts):
        if t == 0:
            x = x0.copy()
        else:
            kk = kicks[t % len(kicks)]
            x = x0 + kk * rng.normal(size=len(x0))
        x, th, r, it = H.newton(T, x)
        if r > tol:
            continue
        W = np.einsum('a,aij->ij', x, B); W /= np.linalg.norm(W)
        if th < 0:
            W, th = -W, -th
        if th < 1e-6:
            continue
        if float(np.abs(L.Qop(Ad, W) - th * W).max()) > 1e-9:
            continue
        la = np.linalg.eigvalsh(W[np.ix_(kidx, kidx)])
        lb = np.linalg.eigvalsh(W[np.ix_(midx, midx)])
        if la.min() <= 1e-10 or lb.max() >= -1e-10:
            continue                                  # not sign-definite -> not graded here
        nA2 = float(np.sum(W[np.ix_(kidx, kidx)] ** 2))
        gr = G.grading_report(n, W)
        gd = max(gr['pp_in_p'][0], gr['pm_in_m'][0], gr['mm_in_p'][0])
        # equivariance: number of distinct eigenvalues of A
        na = len(np.unique(np.round(la, 7))); nb = len(np.unique(np.round(lb, 7)))
        key = (round(th, 7), round(nA2, 7), na, nb)
        if key not in found:
            found[key] = dict(theta=th, nA2=nA2, massP=gr['massP'], gd=gd,
                              na=na, nb=nb, W=W, hits=0,
                              Aspec=np.round(la, 6), Bspec=np.round(lb, 6))
        found[key]['hits'] += 1
        if (t + 1) % log_every == 0:
            print(f"    start {t+1}/{nstarts}  graded found {len(found)}  "
                  f"{time.time()-t0:.0f}s", flush=True)
    return found, eq


if __name__ == '__main__':
    n = int(sys.argv[1]); p = int(sys.argv[2])
    ns = int(sys.argv[3]) if len(sys.argv) > 3 else 1500
    sd = int(sys.argv[4]) if len(sys.argv) > 4 else 0
    found, eq = run(n, p, nstarts=ns, seed=sd)
    print(f"\n  GRADED critical points of the pair, distinct: {len(found)}")
    print(f"  {'theta':>11s}{'||A||^2':>11s}{'massP':>11s}{'#A eig':>8s}{'#B eig':>8s}"
          f"{'grad.def':>10s}{'hits':>6s}")
    for k in sorted(found, reverse=True):
        d = found[k]
        print(f"  {d['theta']:>11.7f}{d['nA2']:>11.7f}{d['massP']:>11.7f}"
              f"{d['na']:>8d}{d['nb']:>8d}{d['gd']:>10.1e}{d['hits']:>6d}")
    if found:
        a = np.array([d['nA2'] for d in found.values()])
        th = np.array([d['theta'] for d in found.values()])
        print(f"  equivariant closed form {eq:.7f}")
        print(f"  ||A||^2 in [{a.min():.7f}, {a.max():.7f}]  spread {a.max()-a.min():.2e}")
        print(f"  theta max {th.max():.7f}  sqrt(3/2)=1.2247449")
        nonEq = [d for d in found.values() if d['na'] > 2 or d['nb'] > 1]
        print(f"  NON-EQUIVARIANT graded (A not scalar on <=2 summands / B not scalar): {len(nonEq)}")
        for d in sorted(nonEq, key=lambda z: -z['theta'])[:10]:
            print(f"     theta {d['theta']:.7f}  ||A||^2 {d['nA2']:.7f}  "
                  f"A spec {sorted(set(d['Aspec']))}  B spec {sorted(set(d['Bspec']))}")
    np.save(f"/tmp/r308_graded_{n}_{p}_{sd}.npy",
            np.array([d['W'] for d in found.values()]) if found else np.zeros((0,1,1)))
