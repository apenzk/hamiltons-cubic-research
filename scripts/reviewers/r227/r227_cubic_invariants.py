"""r227, claim 3.  dim Sym^3(Weyl_n)^{O(n)} across n, as a Proposition-2.3 test.

Levin-Chandrasekaran Proposition 2.3 is one of the few results in the paper that
survives for G_n = O_n: its proof uses only finite sums of group elements, never
the induction of Definition 2.6.  It says that if a consistent sequence U is
generated in degree d, then dim U_n^{G_n} is NON-INCREASING for n >= d.

Contrapositive: if dim Sym^3(Weyl_n)^{O(n)} strictly increases from n to n+1,
then the generation degree of {Sym^3(Weyl_n)} exceeds n.  That is the only
lower bound on a degree that is available for O(n) at all.

Method: build Weyl_n as the kernel of the Ricci contraction inside the algebraic
curvature tensors (Bianchi-closed part of Sym^2(Lambda^2 R^n)), sample it, and
measure the rank of the two classical cubic contractions
    I1 = W_abcd W_cdef W_efab ,    I2 = W_abcd W_aecf W_bedf
as functions on Weyl_n.  Rank 1 means they are proportional (one invariant),
rank 2 means independent (two).  Weyl integration would give the same number;
this route needs no character theory and no Sage.
"""

import numpy as np

rng = np.random.default_rng(20250830)


def sym2_lambda2_basis(n):
    """Basis of Sym^2(Lambda^2 R^n) realised as 4-tensors T_abcd."""
    pairs = [(a, b) for a in range(n) for b in range(a + 1, n)]
    basis = []
    for i, (a, b) in enumerate(pairs):
        for (c, d) in pairs[i:]:
            T = np.zeros((n, n, n, n))
            for (p, q, r, s), sg in (
                ((a, b, c, d), 1), ((b, a, c, d), -1),
                ((a, b, d, c), -1), ((b, a, d, c), 1),
                ((c, d, a, b), 1), ((d, c, a, b), -1),
                ((c, d, b, a), -1), ((d, c, b, a), 1),
            ):
                T[p, q, r, s] += sg
            basis.append(T)
    return basis


def kill_lambda4(T):
    """Project Sym^2(Lambda^2) onto the first-Bianchi kernel (algebraic curvature)."""
    b = T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))
    return T - b / 3.0


def weyl_basis(n):
    """Orthonormal basis of Weyl_n = {R : Bianchi, Ricci-flat} inside (R^n)^{x4}."""
    acts = [kill_lambda4(T) for T in sym2_lambda2_basis(n)]
    M = np.array([T.ravel() for T in acts])
    # orthonormal basis of the algebraic-curvature space (row space of M)
    u, s, vh = np.linalg.svd(M, full_matrices=False)
    tol = max(M.shape) * np.finfo(float).eps * s[0]
    r = int(np.sum(s > tol))
    acts = [vh[j].reshape(n, n, n, n) for j in range(r)]
    # Ricci map on that space, then its kernel
    ric = np.array([np.einsum("abad->bd", T).ravel() for T in acts])   # r x n^2
    u2, s2, vh2 = np.linalg.svd(ric, full_matrices=True)
    tol2 = max(ric.shape) * np.finfo(float).eps * (s2[0] if s2.size else 1.0)
    r2 = int(np.sum(s2 > tol2))
    null = u2[:, r2:]                                                  # r x (r - r2)
    return [np.tensordot(null[:, j], np.array(acts), axes=(0, 0))
            for j in range(null.shape[1])]


def I1(W):
    return np.einsum("abcd,cdef,efab->", W, W, W)


def I2(W):
    return np.einsum("abcd,aecf,bedf->", W, W, W)


def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


if __name__ == "__main__":
    print(f"{'n':>3} {'dim Weyl_n':>11} {'built':>6} | {'rank[I1,I2]':>12}  "
          f"{'I2/I1 spread':>14}")
    prev = None
    for n in (4, 5, 6, 7, 8):
        B = weyl_basis(n)
        vals = []
        for _ in range(60):
            c = rng.normal(size=len(B))
            W = sum(ci * Bi for ci, Bi in zip(c, B))
            vals.append((I1(W), I2(W)))
        A = np.array(vals)
        scale = np.abs(A).max()
        rank = np.linalg.matrix_rank(A / scale, tol=1e-9)
        ratios = A[:, 1] / A[:, 0]
        print(f"{n:>3} {dim_weyl(n):>11} {len(B):>6} | {rank:>12}  "
              f"{ratios.max() - ratios.min():>14.3e}")
        if prev is not None:
            arrow = "increases" if rank > prev[1] else ("constant" if rank == prev[1] else "decreases")
            print(f"      dim Sym^3(Weyl)^O: n={prev[0]} -> n={n}: {prev[1]} -> {rank}  ({arrow})")
        prev = (n, rank)

    print()
    print("Proposition 2.3 requires dim U_n^{G_n} NON-INCREASING for n >= d.")
    print("An increase at n -> n+1 therefore forces the generation degree d > n.")
