import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, core, geom, lop

LOG = 'agent_logs/r315-c3-reduction.log'
def log(s):
    with open(LOG, 'a') as f:
        f.write(time.strftime('%H:%M:%S') + ' [n2] ' + s + '\n')

def run(n, p):
    t0 = time.time()
    alg = core.Alg(n)
    B = core.weyl_basis(n, verbose=False)
    log(f'n={n} dim Weyl={B.shape[0]} (expect {core.expected_weyl_dim(n)}) built {time.time()-t0:.1f}s')
    ker, _ = geom.commutant_dim(alg, B, p)
    log(f'n={n} split ({p},{n-p}) ad(k)-commutant dim = {ker.shape[1]}')
    W = geom.from_coeffs(B, ker[:, 0]); W /= np.linalg.norm(W)
    th = geom.theta_of(alg, W)
    if th < 0: W = -W; th = -th
    res = np.linalg.norm(alg.Q(W) - th*W)
    Vsl, _ = geom.slice_basis(alg, B, p)
    log(f'n={n} ({p},{n-p}) theta={th:.9f} ||Q-thW||={res:.2e} dim slice V={Vsl.shape[1]}')
    Lm = lop.L_matrix(alg, B, W)
    wc = np.einsum('aij,ij->a', B, W); wc /= np.linalg.norm(wc)
    Pp = np.eye(B.shape[0]) - np.outer(wc, wc)
    ev, V = np.linalg.eigh(Pp @ Lm @ Pp)
    Le = ev / th
    ot, s = lop.orbit_tangent(alg, B, W)
    idx = np.where(np.abs(Le - 0.5) < 1e-7)[0]
    frac = 0.0
    if len(idx):
        Es = V[:, idx]; frac = np.linalg.norm(ot @ (ot.T @ Es)) / np.linalg.norm(Es)
    srt = np.sort(Le)
    log(f'n={n} ({p},{n-p}) FULL SPACE lam_max(L_e|Wperp)={srt[-1]:.9f} '
        f'dim(=1/2 eigsp)={len(idx)} orbit tangent dim={ot.shape[1]} frac in orbit={frac:.12f} '
        f'2nd largest={srt[-len(idx)-1] if len(idx) else srt[-2]:.9f} gap={0.5-(srt[-len(idx)-1] if len(idx) else srt[-2]):.9f} 1/(2(M-1))={1/(2*(max(p,n-p)-1)):.9f}')
    # restricted to the slice V
    Ls = Vsl.T @ Lm @ Vsl
    wcs = Vsl.T @ wc
    Pps = np.eye(Vsl.shape[1]) - np.outer(wcs, wcs)/np.dot(wcs,wcs)
    evs, Vs = np.linalg.eigh(Pps @ Ls @ Pps)
    Les = evs / th
    # orbit tangent inside the slice
    ots = Vsl.T @ ot
    us, ss, _ = np.linalg.svd(ots, full_matrices=False)
    kk = int(np.sum(ss > 1e-9))
    idxs = np.where(np.abs(Les - 0.5) < 1e-7)[0]
    srts = np.sort(Les)
    log(f'n={n} ({p},{n-p}) SLICE lam_max={srts[-1]:.9f} dim(=1/2)={len(idxs)} '
        f'orbit-tangent-in-slice dim={kk} 2nd={srts[-len(idxs)-1] if len(idxs) else srts[-2]:.9f}')
    np.save(f'/tmp/r315_W_{n}_{p}.npy', W)
    return

if __name__ == '__main__':
    for (n, p) in [(10, 5), (12, 5), (12, 6)]:
        try:
            run(n, p)
        except Exception as e:
            log(f'FAILED n={n} p={p}: {e!r}')
    log('n2 sweep DONE')
