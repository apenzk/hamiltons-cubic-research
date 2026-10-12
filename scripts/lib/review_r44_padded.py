"""Reviewer 44 -- P1, P2, P3, P4 on the padded S^3 x S^3 point."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r44_core import *
from review_r44_core import _M

def log(m):
    print(m, flush=True)
    with open('agent_logs/review_r44_padded.log', 'a') as f:
        f.write(m + '\n')

def Le_matrix(e, n, B, tag=''):
    """Matrix of X -> e o X restricted to Weyl_n, in the orthonormal basis B."""
    D = B.shape[1]
    Te = to_tensor(e, n)
    Me = _M(Te, n)
    L = liftL(n); Nn = n * n
    cols = np.empty((D, D))
    t0 = time.time()
    for j in range(D):
        X = p_to_X(B[:, j], n)
        TX = (L @ X) @ L.T
        MX = _M(TX, n)
        G = MX @ Me.T
        G = G + G.T
        G4 = G.reshape(n, n, n, n)
        S4 = 0.5 * (G4.transpose(0, 2, 1, 3) - G4.transpose(0, 2, 3, 1))
        sh = 0.25 * (L.T @ S4.reshape(Nn, Nn)) @ L
        Z = 0.5 * (e @ X + X @ e) + sh
        cols[:, j] = B.T @ X_to_p(Z, n)
        if D > 400 and j % 200 == 0:
            log(f'    {tag} L_e column {j}/{D}  ({time.time()-t0:.0f}s)')
    return 0.5 * (cols + cols.T)

def analyse(Wsmall, n0, n, name, want_hess=True):
    W = embed(Wsmall, n0, n) if n > n0 else Wsmall.copy()
    N = n * (n - 1) // 2
    B = weyl_basis(n)
    # --- is it already in Weyl_n?  (projection must be a no-op)
    pv = X_to_p(W, n)
    dproj = np.linalg.norm(pv - B @ (B.T @ pv))
    Wn = W / np.linalg.norm(W)
    QW = Qop(Wn, n)
    th = float(np.tensordot(Wn, QW))
    res = float(np.linalg.norm(QW - th * Wn))
    resw = float(np.linalg.norm(p_to_X(weyl_proj_p(X_to_p(QW, n), n), n) - QW))
    S, dimm = slack_S(Wn, n)
    orb, sv = orbit_tangent_dim(Wn, n)
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    out = dict(name=name, n=n, theta=th, theta0=th0, res=res, S=S, dimm=dimm,
               orbit=orb, dproj=dproj, Qleaves=resw, dim=B.shape[1])
    if want_hess:
        e = Wn / th
        M = Le_matrix(e, n, B, tag=f'{name} n={n}')
        ev = np.linalg.eigvalsh(M)
        half = int(np.sum(np.abs(ev - 0.5) < 1e-8))
        one = int(np.sum(np.abs(ev - 1.0) < 1e-8))
        out.update(E_half=half, E_one=one, evs=ev, Lmat=M)
        # sanity: tr(L_e) should be 0
        out['trL'] = float(np.trace(M))
    return out, W, B

if __name__ == '__main__':
    ns = [int(x) for x in sys.argv[1:]] or [6, 8, 10, 12]
    W6 = sphere_product_W((3, 3))
    log(f'n=6 base S^3xS^3 built from the product metric; ||W||={np.linalg.norm(W6):.12f}')
    for n in ns:
        t0 = time.time()
        r, W, B = analyse(W6, 6, n, 'padS3S3')
        log(f'[padS3S3 n={n}] dimWeyl={r["dim"]} theta={r["theta"]:.12f} theta_0={r["theta0"]:.12f} '
            f'crit_res={r["res"]:.3e} dist_to_Weyl(before proj)={r["dproj"]:.3e} '
            f'Q(W) off Weyl={r["Qleaves"]:.3e} S={r["S"]:.3e} dim(m)={r["dimm"]} '
            f'orbit={r["orbit"]} dimE(1/2)={r["E_half"]} dimE(1)={r["E_one"]} '
            f'excess={r["E_half"]-r["orbit"]} trL={r["trL"]:.2e}  [{time.time()-t0:.0f}s]')
        np.save(f'agent_logs/review_r44_Lspec_padS3S3_n{n}.npy', r['evs'])
