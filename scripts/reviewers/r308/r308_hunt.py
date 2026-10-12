"""r308: hand-rolled damped Gauss-Newton on the criticality system in graded
coordinates, plus the sign-eigenspace (grading) diagnostics the brief's definition
actually asks for."""
import sys, os, time, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import r308_lib as L
import r308_fast as F
import r308_grade as G


def newton(T, x0, iters=200, tol=1e-13):
    d = T.shape[0]
    x = x0 / np.linalg.norm(x0)
    I = np.eye(d)
    for it in range(iters):
        Tx = np.tensordot(T, x, axes=([2], [0]))       # (a,b)
        g = Tx @ x
        th = float(g @ x)
        Fv = np.append(g - th * x, x @ x - 1.0)
        r = np.abs(Fv).max()
        if r < tol:
            return x, th, r, it
        J = np.vstack([2.0 * Tx - 3.0 * np.outer(x, g) - th * I, 2.0 * x])
        try:
            dx = np.linalg.lstsq(J, -Fv, rcond=None)[0]
        except np.linalg.LinAlgError:
            return x, th, r, it
        # simple backtracking
        step = 1.0
        for _ in range(20):
            xn = x + step * dx
            xn = xn / np.linalg.norm(xn)
            Txn = np.tensordot(T, xn, axes=([2], [0]))
            gn = Txn @ xn
            thn = float(gn @ xn)
            rn = np.abs(np.append(gn - thn * xn, 0.0)).max()
            if rn < r or step < 1e-6:
                break
            step *= 0.5
        x = xn
    Tx = np.tensordot(T, x, axes=([2], [0]))
    g = Tx @ x
    th = float(g @ x)
    return x, th, float(np.abs(np.append(g - th * x, x @ x - 1.0)).max()), iters


def hunt(n, p, nstarts=300, seed=0, log_every=25, tol=1e-12, kicks=(0.3, 0.6, 1.0, 1.6, None)):
    idx, pos, N, c, kidx, midx, B = F.graded_basis(n, p)
    A = L.ad(c)
    T = F.cubic_tensor(c, B)
    W0 = L.sphere_product_W(n, p, idx)
    x0 = np.einsum('aij,ij->a', B, W0)
    _, th0, r0, _ = newton(T, x0)
    print(f"n={n} pair so({p})+so({n-p})  dim graded Weyl {len(B)}  "
          f"control theta {th0:.6f} resid {r0:.1e}", flush=True)
    rng = np.random.default_rng(seed)
    found = {}
    t0 = time.time()
    for t in range(nstarts):
        if t == 0:
            x = x0.copy()
        else:
            kk = kicks[t % len(kicks)]
            x = rng.normal(size=len(x0)) if kk is None else x0 + kk * rng.normal(size=len(x0))
        x, th, r, it = newton(T, x)
        if r > tol:
            continue
        W = np.einsum('a,aij->ij', x, B)
        W = W / np.linalg.norm(W)
        if th < 0:
            W, th = -W, -th
        full = float(np.abs(L.Qop(A, W) - th * W).max())
        if full > 1e-9 or th < 1e-6:
            continue
        gr = G.grading_report(n, W)
        gd = max(gr['pp_in_p'][0], gr['pm_in_m'][0], gr['mm_in_p'][0])
        lam = np.linalg.eigvalsh(W)
        ndist = len(np.unique(np.round(lam, 6)))
        key = (round(th, 7), round(gr['massP'], 7), gr['dims'], ndist)
        if key not in found:
            found[key] = dict(theta=th, massP=gr['massP'], dims=gr['dims'],
                              kmass=float(np.sum(W[np.ix_(kidx, kidx)] ** 2)),
                              graded=gd, ndist=ndist, full=full, W=W, hits=0)
        found[key]['hits'] += 1
        if (t + 1) % log_every == 0:
            print(f"    start {t+1}/{nstarts}  distinct {len(found)}  "
                  f"{time.time()-t0:.0f}s", flush=True)
    return found, dict(idx=idx, kidx=kidx, midx=midx, B=B, A=A, T=T)


def show(n, p, found):
    eq = (p * p + (n - p) ** 2 - n) / ((n - 1.0) * (n - 2.0))
    print(f"  equivariant closed form ||A||^2 = {eq:.6f}  (p^2+q^2-n)/((n-1)(n-2))")
    print(f"  {'theta':>10s}{'massP':>10s}{'kmass':>10s}{'dim p':>7s}{'grad.def':>10s}"
          f"{'#eig':>6s}{'hits':>6s}{'res':>9s}")
    rows = sorted(found.values(), key=lambda d: -d['theta'])
    for d in rows:
        print(f"  {d['theta']:>10.6f}{d['massP']:>10.6f}{d['kmass']:>10.6f}"
              f"{d['dims'][0]:>7d}{d['graded']:>10.1e}{d['ndist']:>6d}{d['hits']:>6d}"
              f"{d['full']:>9.1e}")
    gr = [d for d in rows if d['graded'] < 1e-8]
    print(f"  total distinct {len(rows)}, graded {len(gr)}")
    if gr:
        m = np.array([d['massP'] for d in gr]); th = np.array([d['theta'] for d in gr])
        print(f"  GRADED: massP in [{m.min():.6f}, {m.max():.6f}] spread {m.max()-m.min():.6f}"
              f"  ({100*(m.max()-m.min())/max(m.mean(),1e-12):.2f}% of mean)")
        print(f"  GRADED: theta max {th.max():.6f}   sqrt(3/2)=1.224745")
    return rows


if __name__ == '__main__':
    n = int(sys.argv[1]); p = int(sys.argv[2])
    ns = int(sys.argv[3]) if len(sys.argv) > 3 else 300
    sd = int(sys.argv[4]) if len(sys.argv) > 4 else 0
    found, meta = hunt(n, p, nstarts=ns, seed=sd)
    rows = show(n, p, found)
    np.save(f"/tmp/r308_W_{n}_{p}_{sd}.npy", np.array([d['W'] for d in rows]))
