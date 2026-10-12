"""R29 attacks 2,3,4: tau, tr(L_x), tr(L_x L_y)."""
import sys, time
sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r29_core import Alg, weyl_basis, ip, L_matrix, project

def tau(alg, B):
    N = alg.N
    T = np.zeros((N, N))
    for k in range(B.shape[0]):
        T += alg.Q(B[k])
    return T

def run(n, do_LL=True, seed=0):
    rng = np.random.default_rng(seed + n)
    a = Alg(n); B, _, _ = weyl_basis(a); D = B.shape[0]
    res = {'n': n, 'D': D}
    t0 = time.time()
    T1 = tau(a, B)
    # second orthonormal basis: random rotation of the first
    M = rng.standard_normal((D, D)); Qm, _ = np.linalg.qr(M)
    B2 = np.tensordot(Qm, B, axes=([1], [0]))
    T2 = tau(a, B2)
    res['tau1'] = np.abs(T1).max(); res['tau2'] = np.abs(T2).max()
    res['tau_diff'] = np.abs(T1 - T2).max()
    res['tau_scale'] = max(np.abs(a.Q(B[0])).max(), 1e-30)
    # tr(L_x) at random NON-critical x, and via <x,tau>
    xs = []
    for s in range(3):
        v = rng.standard_normal(D); v /= np.linalg.norm(v)
        xs.append(np.tensordot(v, B, axes=([0], [0])))
    res['trL'] = []
    for x in xs:
        Lx = L_matrix(a, B, x)
        Qx = a.Q(x)
        crit = np.linalg.norm(Qx - ip(x, Qx) * x)
        res['trL'].append((np.trace(Lx), ip(x, T1), crit, np.abs(Lx - Lx.T).max()))
    if do_LL:
        x, y = xs[0], xs[1]
        Lx = L_matrix(a, B, x); Ly = L_matrix(a, B, y)
        res['kappa_diag'] = np.trace(Lx @ Lx) / ip(x, x)
        res['kappa_off'] = (np.trace(Lx @ Ly), ip(x, y))
        res['kappa_off_ratio'] = np.trace(Lx @ Ly) / ip(x, y)
    res['t'] = time.time() - t0
    return res

if __name__ == '__main__':
    ns = [int(v) for v in sys.argv[1:]] or [5, 6, 7]
    for n in ns:
        r = run(n)
        kap = (2 * n - 1) * (n - 1) / 4.0
        print(f"n={n} D={r['D']}  |tau|max basis1={r['tau1']:.2e} basis2={r['tau2']:.2e} "
              f"(scale {r['tau_scale']:.2e})", flush=True)
        for (tr, xt, crit, sym) in r['trL']:
            print(f"   random x: tr(L_x)={tr:+.3e}  <x,tau>={xt:+.3e}  crit-resid={crit:.3f}  |L-L^T|={sym:.1e}")
        if 'kappa_diag' in r:
            print(f"   kappa from tr(Lx^2)/<x,x> = {r['kappa_diag']:.10f}   predicted (2n-1)(n-1)/4 = {kap}")
            t, s = r['kappa_off']
            print(f"   tr(LxLy)={t:.10f}  <x,y>={s:.10f}  ratio={r['kappa_off_ratio']:.10f}  [{r['t']:.1f}s]")
