"""r308: graded hunt with multiple base points and an explicit equivariance defect."""
import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import r308_lib as L, r308_fast as F, r308_hunt as H, r308_grade as G


def run(n, p, nstarts, seed, extra=None,
        kicks=(0.05, 0.15, 0.3, 0.5, 0.8, 1.2, 1.8)):
    idx, pos, N, c, kidx, midx, B = F.graded_basis(n, p)
    Ad = L.ad(c)
    T = F.cubic_tensor(c, B)
    bases = [L.sphere_product_W(n, p, idx)]
    if extra is not None:
        for W in extra:
            bases.append(W)
    xs = [np.einsum('aij,ij->a', B, W) for W in bases]
    eq = (p * p + (n - p) ** 2 - n) / ((n - 1.0) * (n - 2.0))
    print(f"n={n} pair ({p},{n-p}) dim {len(B)} bases {len(xs)} "
          f"equivariant ||A||^2={eq:.7f}", flush=True)
    rng = np.random.default_rng(seed)
    found = {}
    t0 = time.time()
    for t in range(nstarts):
        x0 = xs[t % len(xs)]
        x = x0.copy() if t < len(xs) else x0 + kicks[t % len(kicks)] * rng.normal(size=len(x0))
        if (t + 1) % 50 == 0:
            print(f"    {t+1}/{nstarts} graded {len(found)} {time.time()-t0:.0f}s", flush=True)
        x, th, r, it = H.newton(T, x)
        if r > 1e-12:
            continue
        W = np.einsum('a,aij->ij', x, B); W /= np.linalg.norm(W)
        if th < 0:
            W, th = -W, -th
        if th < 1e-6 or float(np.abs(L.Qop(Ad, W) - th * W).max()) > 1e-9:
            continue
        la = np.linalg.eigvalsh(W[np.ix_(kidx, kidx)])
        lb = np.linalg.eigvalsh(W[np.ix_(midx, midx)])
        if la.min() <= 1e-10 or lb.max() >= -1e-10:
            continue
        nA2 = float(np.sum(W[np.ix_(kidx, kidx)] ** 2))
        D = G.equivariance_defect(n, W)
        key = (round(th, 6), round(nA2, 6))
        if key not in found:
            found[key] = dict(theta=th, nA2=nA2, Delta=D, hits=0, W=W,
                              na=len(np.unique(np.round(la, 5))))
        found[key]['hits'] += 1
    print(f"\n  GRADED points of pair ({p},{n-p}), distinct {len(found)}")
    print(f"  {'theta':>11s}{'||A||^2':>11s}{'Delta':>10s}{'#Aeig':>7s}{'hits':>6s}")
    for k in sorted(found, reverse=True):
        d = found[k]
        print(f"  {d['theta']:>11.7f}{d['nA2']:>11.7f}{d['Delta']:>10.2e}"
              f"{d['na']:>7d}{d['hits']:>6d}")
    if found:
        a = np.array([d['nA2'] for d in found.values()])
        th = np.array([d['theta'] for d in found.values()])
        ne = [d for d in found.values() if d['Delta'] > 1e-6]
        print(f"  equivariant closed form {eq:.7f}")
        print(f"  ||A||^2 range [{a.min():.7f},{a.max():.7f}] spread {a.max()-a.min():.3e}"
              f" = {100*(a.max()-a.min())/eq:.3f}% of the closed form")
        print(f"  theta max {th.max():.7f}   sqrt(3/2)=1.2247449")
        print(f"  NON-EQUIVARIANT (Delta>1e-6): {len(ne)}")
        for d in sorted(ne, key=lambda z: -z['theta']):
            print(f"     theta {d['theta']:.7f} ||A||^2 {d['nA2']:.7f} Delta {d['Delta']:.4f}"
                  f" dev {100*(d['nA2']-eq)/eq:+.3f}%")
    np.save(f"/tmp/r308_g2_{n}_{p}_{seed}.npy",
            np.array([d['W'] for d in found.values()]) if found else np.zeros((0,1,1)))
    return found


if __name__ == '__main__':
    n = int(sys.argv[1]); p = int(sys.argv[2]); ns = int(sys.argv[3]); sd = int(sys.argv[4])
    extra = []
    for f in sys.argv[5:]:
        W = np.load(f)
        if W.ndim == 2:
            extra.append(W / np.linalg.norm(W))
        else:
            extra += [w / np.linalg.norm(w) for w in W]
    run(n, p, ns, sd, extra=extra or None)
