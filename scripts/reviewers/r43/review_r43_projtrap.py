"""Reviewer 43, R5: is the 'remove Lambda^4 then remove Ricci' projector orthogonal?

Two variants are reimplemented from scratch (nothing imported from the repo):
  variant A -- KN(h,g) with h solved from (n-2)h + tr(h)g = ric   [my core module]
  variant B -- the shape used in scripts/b_cpm_summand_rows.py:
               h = (ric - tr/n * I)/(n-2), subtract KN/2 and a multiple of Id.
"""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r43_core import Ambient, frob

rng = np.random.default_rng(4343)


def variantB(amb, X):
    n, N = amb.n, amb.N
    T = amb.to_tensor(X)
    Y = T - amb.bianchi_part(T)
    R = np.einsum('ikjk->ij', Y)
    R = 0.5 * (R + R.T)
    tr = np.trace(R)
    h = (R - tr / n * np.eye(n)) / (n - 2)
    d = np.eye(n)
    KN = 0.5 * (np.einsum('ik,jl->ijkl', h, d) - np.einsum('il,jk->ijkl', h, d)
                - np.einsum('jk,il->ijkl', h, d) + np.einsum('jl,ik->ijkl', h, d))
    Sq = 0.5 * (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d))
    return amb.to_op(Y - KN - (tr / (n * (n - 1))) * Sq)


def report(n):
    amb = Ambient(n); N = amb.N
    B = amb.weyl_basis()
    def sym():
        M = rng.standard_normal((N, N)); return M + M.T
    X, Y = sym(), sym()
    for name, f in [('A (mine / r41_bigm)', amb.weyl_project), ('B (b_cpm_summand_rows shape)', lambda Z: variantB(amb, Z))]:
        PX, PY = f(X), f(Y)
        idem = np.abs(f(PX) - PX).max()
        selfadj = abs(frob(PX, Y) - frob(X, PY))
        # distance to the true orthogonal projection
        co = np.einsum('aij,ij->a', B, X)
        PXtrue = np.einsum('a,aij->ij', co, B)
        dev = np.abs(PX - PXtrue).max() / np.abs(PXtrue).max()
        d = amb.defect(PX)
        # does it fix Weyl?
        Wt = np.einsum('a,aij->ij', rng.standard_normal(B.shape[0]), B)
        fix = np.abs(f(Wt) - Wt).max() / np.abs(Wt).max()
        print(f"  n={n} {name}: idem {idem:.2e} selfadj {selfadj:.2e} "
              f"rel dev from true P {dev:.2e} defect {d[0]:.1e}/{d[1]:.1e} fixes Weyl {fix:.2e}")


if __name__ == '__main__':
    for n in [6, 8, 10]:
        report(n)
    print()
    print("=== R5 second half: does L_e preserve Weyl_2m? ===")
    from review_r43_cpm import build_e
    for m in [3, 4, 5, 6]:
        amb, U, e, _ = build_e(m)
        B = amb.weyl_basis()
        Pw = None
        worst = 0.0
        for _ in range(4):
            v = rng.standard_normal(B.shape[0]); v /= np.linalg.norm(v)
            X = np.einsum('a,aij->ij', v, B)
            Yy = amb.circ(e, X)
            co = np.einsum('aij,ij->a', B, Yy)
            leak = np.linalg.norm(Yy - np.einsum('a,aij->ij', co, B)) / np.linalg.norm(Yy)
            worst = max(worst, leak)
        print(f"  m={m}: max relative leak of e o X out of Weyl over 4 random unit X: {worst:.3e}")
