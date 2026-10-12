import sys, os, time, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, core, geom, slice8

LOG = 'agent_logs/r315-c3-reduction.log'
def log(s):
    with open(LOG, 'a') as f:
        f.write(time.strftime('%H:%M:%S') + ' [n3] ' + s + '\n')

n = 8
alg = core.Alg(n)
B = core.weyl_basis(n, verbose=False)
NST = int(sys.argv[1]) if len(sys.argv) > 1 else 400

for p in [3, 4]:
    t0 = time.time()
    Vc, _ = geom.slice_basis(alg, B, p)          # (300, dV) coeff columns
    Vb = np.einsum('da,dij->aij', Vc, B)          # (dV, N, N) orthonormal slice basis
    dV = Vb.shape[0]
    log(f'({p},{n-p}) slice dim {dV}; building trilinear tensor')
    Gt = slice8.build_trilinear(alg, Vb)
    cub = slice8.Cubic(Gt)
    log(f'({p},{n-p}) tensor built in {time.time()-t0:.1f}s, {Gt.nbytes/1e6:.0f} MB')
    # equivariant point in slice coordinates
    ker, _ = geom.commutant_dim(alg, B, p)
    We = geom.from_coeffs(B, ker[:, 0]); We /= np.linalg.norm(We)
    we = np.einsum('aij,ij->a', Vb, We)
    if cub.P(we) < 0: we = -we
    the, Lee = slice8.hess_report(cub, we)
    log(f'({p},{n-p}) EQUIVARIANT on slice: theta={the:.9f} lam_max(L_e|V,Wperp)={Lee[-1]:.9f} '
        f'(top5 {np.round(Lee[-5:],6).tolist()})')

    rng = np.random.default_rng(1000 + p)
    found = []
    for s in range(NST):
        w0 = rng.standard_normal(dV)
        w, val, gn = slice8.ascend(cub, w0)
        w = slice8.polish(cub, w)
        th, Le = slice8.hess_report(cub, w)
        if th < 0:
            continue
        q = cub.Q(w); res = np.linalg.norm(q - th * w)
        ismax = Le[-1] <= 0.5 + 1e-7
        W = np.einsum('a,aij->ij', w, Vb)
        eig = np.round(np.sort(np.linalg.eigvalsh(W)), 6)
        found.append(dict(theta=float(th), lam=float(Le[-1]), res=float(res), ismax=bool(ismax),
                          eig=eig.tolist(), gap=float(0.5 - Le[-1])))
        if (s + 1) % 50 == 0:
            ths = sorted(set(round(f['theta'], 6) for f in found if f['ismax']))
            log(f'({p},{n-p}) start {s+1}/{NST}: distinct LOCAL-MAX thetas so far = {ths}')
    # summarise
    maxima = [f for f in found if f['ismax']]
    keys = {}
    for f in maxima:
        k = round(f['theta'], 7)
        keys.setdefault(k, []).append(f)
    log(f'({p},{n-p}) SUMMARY: {len(found)} converged, {len(maxima)} are local maxima on S(V); '
        f'distinct theta values of local maxima: {sorted(keys.keys())}')
    for k in sorted(keys):
        f = keys[k][0]
        log(f'   ({p},{n-p}) local max theta={k} count={len(keys[k])} lam_max(L_e)={f["lam"]:.9f} '
            f'residual={f["res"]:.1e} W-eigs={sorted(set(f["eig"]))}')
    with open(f'/tmp/r315_n3_{p}.json', 'w') as fh:
        json.dump(found, fh)
log('n3 DONE')
