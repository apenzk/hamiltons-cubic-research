"""Attacks 2,3,4 (Reviewer 28): the metrised property, tau, tr(L_x), tr(L_x L_y)."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r28_core as R


def rand_weyl(n, rng, k=1):
    basis, ns, Es = R.weyl_basis(n)
    D = basis.shape[0]
    co = rng.normal(size=(k, D))
    return np.einsum('kd,dij->kij', co, basis)


def report(n, rng, do_pairs=True):
    t0 = time.time()
    basis, ns, Es = R.weyl_basis(n)
    D = basis.shape[0]
    out = {'n': n, 'D': D}

    # --- closure: circ maps Weyl x Weyl -> Weyl ?
    X, Y, Z = rand_weyl(n, rng, 3)
    XY = R.circ(n, X, Y)
    out['closure'] = np.linalg.norm(XY - R.weyl_proj(n, XY)) / np.linalg.norm(XY)

    # --- metrised / fully symmetric cubic form ?
    a = np.sum(R.circ(n, X, Y) * Z)
    b = np.sum(R.circ(n, Y, Z) * X)
    c = np.sum(R.circ(n, X, Z) * Y)
    out['metrised'] = max(abs(a - b), abs(a - c)) / abs(a)

    # --- tau in basis 1 and in a random rotated orthonormal basis
    def tau_of(B):
        s = np.zeros_like(B[0])
        for k in range(B.shape[0]):
            s += R.circ(n, B[k], B[k])
        return s
    tau1 = tau_of(basis)
    Qr, _ = np.linalg.qr(rng.normal(size=(D, D)))
    basis2 = np.einsum('dk,kij->dij', Qr, basis)
    tau2 = tau_of(basis2)
    scale = np.mean([np.linalg.norm(R.circ(n, basis[k], basis[k])) for k in range(min(D, 20))])
    out['tau1'] = np.linalg.norm(tau1)
    out['tau2'] = np.linalg.norm(tau2)
    out['tau_scale'] = scale

    # --- tr(L_x) at random NON-critical x  (and its criticality residual)
    Lm, _ = R.L_matrix(n, X)
    out['trL_rand'] = np.trace(Lm)
    Qx = R.Q(n, X); th = np.sum(X * Qx) / np.sum(X * X)
    out['crit_resid_rand'] = np.linalg.norm(Qx - th * X) / np.linalg.norm(Qx)
    out['normX'] = np.sqrt(np.sum(X * X))

    if do_pairs:
        Lmy, _ = R.L_matrix(n, Y)
        Lmz, _ = R.L_matrix(n, Z)
        ip = lambda A, B: np.sum(A * B)
        out['kappa_xx'] = np.trace(Lm @ Lm) / ip(X, X)
        out['kappa_xy'] = np.trace(Lm @ Lmy) / ip(X, Y)
        out['kappa_yz'] = np.trace(Lmy @ Lmz) / ip(Y, Z)
        # cubic trace identity candidate  tr(L_x L_y L_z) = mu <x o y, z>
        out['mu_xxx'] = np.trace(Lm @ Lm @ Lm) / ip(R.circ(n, X, X), X)
        out['mu_xyz'] = np.trace(Lm @ Lmy @ Lmz) / ip(R.circ(n, X, Y), Z)
        out['mu_xxy'] = np.trace(Lm @ Lm @ Lmy) / ip(R.circ(n, X, X), Y)
        out['tr4_xxxx'] = np.trace(Lm @ Lm @ Lm @ Lm)
    out['t'] = time.time() - t0
    return out


if __name__ == '__main__':
    rng = np.random.default_rng(12345)
    ns = [int(x) for x in sys.argv[1:]] or [5, 6, 7, 8]
    for n in ns:
        o = report(n, rng)
        kf = (2 * n - 1) * (n - 1) / 4.0
        print(f"n={o['n']} D={o['D']} closure={o['closure']:.2e} metrised={o['metrised']:.2e} "
              f"||tau1||={o['tau1']:.3e} ||tau2||={o['tau2']:.3e} (typ term {o['tau_scale']:.3f}) "
              f"trL(rand,||x||={o['normX']:.2f},crit.resid={o['crit_resid_rand']:.2f})={o['trL_rand']:.3e}")
        if 'kappa_xy' in o:
            print(f"    kappa: xx={o['kappa_xx']:.9f} xy={o['kappa_xy']:.9f} yz={o['kappa_yz']:.9f}  "
                  f"(2n-1)(n-1)/4={kf:.6f}  dev={max(abs(o['kappa_xx']-kf),abs(o['kappa_xy']-kf),abs(o['kappa_yz']-kf)):.2e}")
            print(f"    mu:    xxx={o['mu_xxx']:.9f} xyz={o['mu_xyz']:.9f} xxy={o['mu_xxy']:.9f}   [{o['t']:.1f}s]")
