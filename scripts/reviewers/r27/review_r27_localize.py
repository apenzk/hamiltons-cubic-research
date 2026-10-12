"""Reviewer 27, claim (C): does Sym^2(m) already carry the maximum?"""
import numpy as np
import review_r27_core as C, review_r27_points as PT, review_r27_measure as M


def localize(n, W, name):
    o = M.analyse(n, W, name)
    B = o['B']; L = o['L']; coW = o['coW']
    ev, U = np.linalg.eigh(W)
    sel = ev < -1e-11
    mB = U[:, sel]
    Pm = mB @ mB.T
    D = B.shape[0]
    # operator on Weyl coords: X -> Pi_Weyl( Pm X Pm )
    T = np.einsum('kab,lab->kl', B, np.einsum('ap,lpq,qb->lab', Pm, B, Pm))
    T = 0.5 * (T + T.T)
    w, V = np.linalg.eigh(T)
    keep = V[:, w > 1 - 1e-9]                       # Weyl  intersect  Sym^2(m)
    # remove the W direction (W is not in Sym^2(m) unless the h-part vanishes, but be safe)
    if keep.shape[1]:
        pr = keep.T @ coW
        Kr = keep - np.outer(coW, pr).T.T if False else keep
        # orthogonal complement of coW inside `keep`
        q, _ = np.linalg.qr(np.hstack([keep @ (keep.T @ coW).reshape(-1, 1) * 0 + keep]))
        proj = keep @ keep.T
        v = proj @ coW
        if np.linalg.norm(v) > 1e-9:
            v = v / np.linalg.norm(v)
            Kr = keep - np.outer(v, v @ keep)
            u_, s_, vt_ = np.linalg.svd(Kr)
            keep = u_[:, :np.sum(s_ > 1e-9)]
    lam_int = np.linalg.eigvalsh(keep.T @ L @ keep)[-1] if keep.shape[1] else float('nan')
    # raw compression of L_e to Sym^2(m) with no Weyl condition
    N = W.shape[0]
    k = mB.shape[1]
    basis = []
    for a in range(k):
        for b in range(a, k):
            X = np.outer(mB[:, a], mB[:, b])
            X = 0.5 * (X + X.T)
            X = X / np.sqrt(np.trace(X @ X))
            basis.append(X)
    basis = np.array(basis)
    Lr = np.array([C.circ(n, o['e'], X) for X in basis])
    G = np.einsum('kab,lab->kl', basis, basis)
    Mm = np.einsum('kab,lab->kl', basis, Lr)
    Mm = 0.5 * (Mm + Mm.T)
    from scipy.linalg import eigh
    lam_raw = eigh(Mm, G, eigvals_only=True)[-1]
    print('%-24s n=%2d  lam_max(full W-perp)=%.12f   dim(Weyl cap Sym^2 m)=%4d  '
          'lam_max there=%.12f   lam_max(raw Sym^2 m, no Weyl)=%.12f'
          % (name, n, o['lam_max'], keep.shape[1], lam_int, lam_raw))
    return lam_int


def localize2(n, W, name):
    """Compressions of L_e onto the grading-graded pieces of Sym^2(Lambda^2), inside Weyl cap W-perp."""
    o = M.analyse(n, W, name)
    B = o['B']; L = o['L']; coW = o['coW']
    ev, U = np.linalg.eigh(W)
    sel = ev < -1e-11
    mB = U[:, sel]; hB = U[:, ~sel]
    Pm = mB @ mB.T; Ph = hB @ hB.T

    def sub(proj_fn, tag):
        T = np.einsum('kab,lab->kl', B, np.array([proj_fn(X) for X in B]))
        T = 0.5 * (T + T.T)
        w, V = np.linalg.eigh(T)
        keep = V[:, w > 1 - 1e-9]
        if keep.shape[1] == 0:
            print('   %-22s dim 0' % tag); return
        v = keep @ (keep.T @ coW)
        if np.linalg.norm(v) > 1e-9:
            v /= np.linalg.norm(v)
            Kr = keep - np.outer(v, v @ keep)
            u_, s_, _ = np.linalg.svd(Kr)
            keep = u_[:, :int((s_ > 1e-9).sum())]
        lam = np.linalg.eigvalsh(keep.T @ L @ keep)
        print('   %-22s dim %4d   lam_max = %.12f   lam_min = %.12f' % (tag, keep.shape[1], lam[-1], lam[0]))

    print('%s (n=%d): full lam_max on W-perp = %.12f' % (name, n, o['lam_max']))
    sub(lambda X: Pm @ X @ Pm, 'Sym^2(m)')
    sub(lambda X: Ph @ X @ Ph, 'Sym^2(h)')
    sub(lambda X: Ph @ X @ Pm + Pm @ X @ Ph, 'h (x) m  (odd part)')
    sub(lambda X: Ph @ X @ Ph + Pm @ X @ Pm, 'even part (hh + mm)')

if __name__ == '__main__':
    import review_r27_points as PT
    g, f, d = PT.gens_su3_adjoint()
    W, r, Pi = PT.W_subalgebra(8, g); localize2(8, W, 'su(3) adjoint')
    W, r, Pi = PT.W_subalgebra(5, PT.gens_so3_in_so5()); localize2(5, W, 'so(3) in so(5)')
    W, r, Pi = PT.W_subalgebra(8, PT.gens_so_direct_sum(8, [4, 4])); localize2(8, W, 'so(4)+so(4)')
    W, lab, res = PT.solve_multiblock(8, [2, 6]); localize2(8, W, 'S^2 x S^6')
    W, lab, res = PT.solve_multiblock(8, [3, 5]); localize2(8, W, 'S^3 x S^5')
    W, lab, res = PT.solve_multiblock(9, [3, 3, 3]); localize2(9, W, '(S^3)^3')
