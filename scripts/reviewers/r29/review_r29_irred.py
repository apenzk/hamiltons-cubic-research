"""R29 attack 1: is Weyl_n irreducible over SO(n) / O(n)?  Commutant dimension via ker(Omega)."""
import sys, time
sys.path.insert(0, 'scripts/lib')
import numpy as np
from scipy.sparse.linalg import LinearOperator, eigsh
from review_r29_core import Alg, weyl_basis


def rho_on_weyl(alg, B):
    """r[a] = D x D matrix of the so(n) action X -> [rho_a, X] restricted to Weyl_n."""
    D, N, _ = B.shape
    Bf = B.reshape(D, N * N)
    out = np.zeros((alg.N, D, D))
    for a in range(alg.N):
        ra = alg.rho[a]
        for k in range(D):
            Mk = ra @ B[k] - B[k] @ ra
            out[a, :, k] = Bf @ Mk.reshape(N * N)
    return out


def reflection_on_weyl(alg, B, which=0):
    N = alg.N
    S = np.ones(N)
    for a, (i, j) in enumerate(alg.P):
        if i == which or j == which:
            S[a] = -1.0
    D = B.shape[0]
    Bf = B.reshape(D, N * N)
    T = np.zeros((D, D))
    for k in range(D):
        Mk = (S[:, None] * B[k]) * S[None, :]
        T[:, k] = Bf @ Mk.reshape(N * N)
    return T


def commutant_dim(r, D, k=10):
    def mv(v):
        M = v.reshape(D, D)
        out = np.zeros((D, D))
        for a in range(r.shape[0]):
            C = r[a] @ M - M @ r[a]
            out += r[a] @ C - C @ r[a]
        return (-out).reshape(-1)
    op = LinearOperator((D * D, D * D), matvec=mv, dtype=float)
    vals = eigsh(op, k=k, which='SA', return_eigenvectors=False, tol=1e-9, maxiter=20000)
    return np.sort(vals)


def commutant_basis(r, D, k=10):
    def mv(v):
        M = v.reshape(D, D)
        out = np.zeros((D, D))
        for a in range(r.shape[0]):
            C = r[a] @ M - M @ r[a]
            out += r[a] @ C - C @ r[a]
        return (-out).reshape(-1)
    op = LinearOperator((D * D, D * D), matvec=mv, dtype=float)
    vals, vecs = eigsh(op, k=k, which='SA', tol=1e-10, maxiter=40000)
    o = np.argsort(vals)
    return vals[o], vecs[:, o]


if __name__ == '__main__':
    for n in [int(x) for x in sys.argv[1:]] or [5, 6, 7, 8]:
        t = time.time()
        a = Alg(n)
        B, _, _ = weyl_basis(a)
        D = B.shape[0]
        r = rho_on_weyl(a, B)
        # sanity: r[a] antisymmetric, and the action is a Lie algebra rep
        asym = max(abs(r[i] + r[i].T).max() for i in range(a.N))
        vals, vecs = commutant_basis(r, D, k=min(8, D * D - 2))
        nz = np.sort(vals)
        ker = [i for i in range(len(nz)) if abs(nz[i]) < 1e-7 * max(1.0, abs(nz[-1]))]
        dso = len(ker)
        # O(n): impose the reflection too
        T = reflection_on_weyl(a, B, 0)
        do = 0
        if dso:
            KB = [vecs[:, i].reshape(D, D) for i in ker]
            # basis of ker; count subspace commuting with T
            G = np.array([[np.sum(x * y) for y in KB] for x in KB])
            # map M -> T M T^{-1} - M on ker
            Ti = np.linalg.inv(T)
            rows = []
            for x in KB:
                y = T @ x @ Ti - x
                rows.append([np.sum(y * z) for z in KB])
            Amat = np.array(rows).T
            s = np.linalg.svd(Amat, compute_uv=False)
            do = int((s < 1e-8 * max(1.0, s[0])).sum())
        print(f"n={n} D={D} rho-antisym-err={asym:.1e} smallest Omega eigs={np.array2string(nz[:6], precision=4)} "
              f"dim End_SO(n)={dso} dim End_O(n)={do}  [{time.time()-t:.1f}s]", flush=True)
