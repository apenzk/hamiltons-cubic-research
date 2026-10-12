import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, core, geom

LOG = 'agent_logs/r315-c3-reduction.log'
def log(s):
    with open(LOG, 'a') as f:
        f.write(time.strftime('%H:%M:%S') + ' [n12] ' + s + '\n')


def sphere_product_W(alg, a, order=None):
    """Weyl operator of S^a x S^{n-a} with the coordinate split {0..a-1}|{a..n-1};
    diagonal in the e_i^e_j basis. order: optional permutation of coordinates."""
    n = alg.n
    b = n - a
    setA = set(range(a)) if order is None else set(order[:a])
    al = b / (a - 1.0)
    be = a / (b - 1.0)
    ga = -1.0
    d = np.zeros(alg.N)
    for k, (i, j) in enumerate(alg.P):
        ia, ja = (i in setA), (j in setA)
        d[k] = al if (ia and ja) else (be if ((not ia) and (not ja)) else ga)
    W = np.diag(d)
    return W / np.linalg.norm(W)


def main():
    n = 12
    t0 = time.time()
    alg = core.Alg(n)
    B = core.weyl_basis(n, verbose=False)
    Bf = B.reshape(B.shape[0], alg.N * alg.N)
    log(f'n=12 Weyl dim {B.shape[0]} built {time.time()-t0:.1f}s')

    # slice for the (6,6) grading
    j = geom.grading_J(alg, 6)
    JJ = np.outer(j, j).ravel()
    M = Bf @ (Bf * JJ[None, :]).T
    M = 0.5 * (M + M.T)
    ev, Vv = np.linalg.eigh(M)
    Vc = Vv[:, ev > 0.5]
    Vb = np.einsum('da,dij->aij', Vc, B)
    Vf = Vb.reshape(Vb.shape[0], alg.N * alg.N)
    log(f'n=12 (6,6) slice dim = {Vb.shape[0]}  (conj evs {np.unique(np.round(ev,8))})')

    kslice = [c for c, (i, jj) in enumerate(alg.P) if (i < 6 and jj < 6) or (i >= 6 and jj >= 6)]

    for a in [6, 5, 4, 3]:
        W = sphere_product_W(alg, a)
        inWeyl = np.linalg.norm(W - np.einsum('a,aij->ij', Bf @ W.ravel(), B))
        inSlice = np.linalg.norm(W - np.einsum('a,aij->ij', Vf @ W.ravel(), Vb))
        th = core.frob(W, alg.Q(W))
        res = np.linalg.norm(alg.Q(W) - th * W)
        log(f'n=12 S^{a}xS^{n-a}: theta={th:.9f}  dist to Weyl={inWeyl:.2e}  dist to (6,6)-slice={inSlice:.2e}  ||Q-thW||={res:.2e}')

        # L restricted to the slice
        d = Vb.shape[0]
        Lv = np.zeros((d, d))
        for k in range(d):
            Lv[:, k] = Vf @ alg.L(W, Vb[k]).ravel()
        Lv = 0.5 * (Lv + Lv.T)
        wv = Vf @ W.ravel(); wv /= np.linalg.norm(wv)
        Pp = np.eye(d) - np.outer(wv, wv)
        evs = np.linalg.eigvalsh(Pp @ Lv @ Pp) / th
        evs = np.sort(evs)
        nhalf = int(np.sum(np.abs(evs - 0.5) < 1e-8))
        nabove = int(np.sum(evs > 0.5 + 1e-8))
        # orbit tangent inside the slice: [ad X, W] for X in so(6)+so(6)
        cols = []
        for c in kslice:
            ad = alg.C[c].T
            X = ad @ W - W @ ad
            cols.append(Vf @ X.ravel())
        Mo = np.array(cols).T
        so = np.linalg.svd(Mo, compute_uv=False)
        korb = int(np.sum(so > 1e-9 * max(1.0, so[0])))
        log(f'   SLICE: lam_max(L_e)={evs[-1]:.9f}  #(=1/2)={nhalf}  #(>1/2)={nabove}  '
            f'next below 1/2 = {evs[-nhalf-1] if nhalf else evs[-1]:.9f}  '
            f'so(6)+so(6)-orbit tangent dim in slice = {korb}')
    log('n12 DONE')


if __name__ == '__main__':
    main()
