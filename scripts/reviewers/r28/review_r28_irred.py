"""Attack 1 (Reviewer 28): O(n)-irreducibility of Weyl_n, done three ways.

(a) dim (Weyl_n)^{so(n)}  -- the invariant-vector count that T1's argument actually needs.
(b) dim of so(n)-invariant SYMMETRIC bilinear forms on Weyl_n  (matrix-free Casimir nullspace).
(c) dim of so(n)-invariant ANTISYMMETRIC forms; (b)+(c) = dim of the real commutant.
    Commutant dim 1  <=>  absolutely irreducible over R (real type).
Then the O(n) refinement: intersect with commuting with one reflection.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r28_core as R
from scipy.sparse.linalg import LinearOperator, eigsh


def so_gens_on_weyl(n):
    P = R.phi_matrices(n)
    basis, ns, Es = R.weyl_basis(n)
    out = []
    for i in range(n):
        for j in range(i + 1, n):
            X = np.zeros((n, n)); X[i, j] = 1; X[j, i] = -1
            adX = np.einsum('ij,bjk->bik', X, P) - np.einsum('bij,jk->bik', P, X)
            A = 0.5 * np.einsum('bik,aik->ab', adX, P)
            imgs = np.einsum('ab,kbc->kac', A, basis) + np.einsum('kab,cb->kac', basis, A)
            M = np.einsum('kac,mac->mk', imgs, basis)
            out.append(M)
    return np.array(out)          # (n(n-1)/2, D, D), each antisymmetric


def refl_on_weyl(n, k=0):
    g = np.eye(n); g[k, k] = -1.0
    P = R.phi_matrices(n)
    img = np.einsum('ij,bjk,lk->bil', g, P, g)
    M = 0.5 * np.einsum('bil,ail->ab', img, P)
    basis, ns, Es = R.weyl_basis(n)
    imgs = np.einsum('ab,kbc,dc->kad', M, basis, M)
    return np.einsum('kad,mad->mk', imgs, basis)


def invariant_vectors(n):
    G = so_gens_on_weyl(n)
    D = G.shape[1]
    A = G.reshape(-1, D)
    s = np.linalg.svd(A, compute_uv=False)
    tol = 1e-9 * max(1.0, s[0])
    return int((s < tol).sum()), D


def commutant_dims(n, extra=None, nsmall=6):
    """Smallest eigenvalues of H(T) = sum_a [X_a,[X_a,T]]^- on Sym and Alt blocks."""
    G = so_gens_on_weyl(n)
    D = G.shape[1]
    mats = list(G)
    if extra is not None:
        mats = mats + []            # reflection handled separately (it's a group elt)
    Gs = np.array(mats)

    def build(part):
        iu = np.triu_indices(D, 1) if part == 'alt' else np.triu_indices(D, 0)
        dim = len(iu[0])

        def to_mat(v):
            T = np.zeros((D, D))
            T[iu] = v
            if part == 'alt':
                T = T - T.T
            else:
                T = T + T.T - np.diag(np.diag(T))
            return T

        def to_vec(T):
            return T[iu] * (1.0)

        def mv(v):
            T = to_mat(v)
            Cm = np.einsum('aij,jk->aik', Gs, T) - np.einsum('ij,ajk->aik', T, Gs)
            H = np.einsum('aij,ajk->ik', Gs, Cm) - np.einsum('aij,ajk->ik', Cm, Gs)
            H = -H
            if extra is not None:
                Rr = extra @ T @ extra.T - T
                H = H + 5.0 * (Rr @ Rr.T if part == 'zzz' else (extra.T @ Rr @ extra - Rr) * -1.0)
            return to_vec(H)
        return LinearOperator((dim, dim), matvec=mv, dtype=float), dim, to_mat

    res = {}
    for part in ('sym', 'alt'):
        op, dim, to_mat = build(part)
        k = min(nsmall, dim - 2)
        vals, vecs = eigsh(op, k=k, which='SA', tol=1e-9, maxiter=20000)
        order = np.argsort(vals)
        vals = vals[order]; vecs = vecs[:, order]
        nz = int((vals < 1e-7 * max(1.0, abs(vals[-1]))).sum())
        res[part] = (vals, vecs, to_mat, nz)
    return res, D


if __name__ == '__main__':
    ns = [int(x) for x in sys.argv[1:]] or [5, 6, 7, 8]
    for n in ns:
        t0 = time.time()
        ninv, D = invariant_vectors(n)
        res, D = commutant_dims(n)
        vs, vecsS, to_matS, nzS = res['sym']
        va, vecsA, to_matA, nzA = res['alt']
        # O(n) refinement: which of the so(n)-invariant operators also commute with a reflection
        refl = refl_on_weyl(n)
        def On_count(vals, vecs, to_mat):
            cnt = 0
            for i in range(len(vals)):
                if vals[i] < 1e-7 * max(1.0, abs(vals[-1])):
                    T = to_mat(vecs[:, i])
                    if np.abs(T @ refl - refl @ T).max() < 1e-7 * max(1e-12, np.abs(T).max()):
                        cnt += 1
            return cnt
        oS = On_count(vs, vecsS, to_matS); oA = On_count(va, vecsA, to_matA)
        print(f'n={n} D={D} dim(Weyl^so(n))={ninv} | so(n)-commutant: sym={nzS} alt={nzA} total={nzS+nzA}'
              f' | of those commuting with a reflection: sym={oS} alt={oA}'
              f' | evals sym {np.array2string(vs[:4], precision=3)} alt {np.array2string(va[:4], precision=3)}'
              f' [{time.time()-t0:.1f}s]')
