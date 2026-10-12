"""Reviewer 65 / C2 step 2: the spectrum of  T(A) = -sum_k ad(f_k) A ad(f_k)  on Sym(so(n)).

Bracket mass of a subspace m with orthoprojector P is exactly the quadratic form
    mu(m) = <T(P), P>.
T is SO(n)-equivariant on Sym(so(n)) = R + Sym^2_0(V) + Weyl + Lambda^4 V, so it acts
by a scalar on each piece; the scalar is  2(n-2) - c_lambda/2  with c_lambda the Casimir.
Predicted:  trivial 2n-4,  Sym^2_0(V) n-4,  Weyl -2,  Lambda^4 V 4.
The MINIMUM eigenvalue is what the bound rests on: it must be -2.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from review_r65_lib import structure_tensor, ad_matrices


def sym_basis(N):
    idx = []
    for i in range(N):
        for j in range(i, N):
            idx.append((i, j))
    return idx


def T_matrix(n):
    """Matrix of T on Sym(so(n)) in an orthonormal basis of symmetric matrices."""
    ads = ad_matrices(n)
    N = ads.shape[0]
    idx = sym_basis(N)
    M = len(idx)
    Bs = np.zeros((M, N, N))
    for t, (i, j) in enumerate(idx):
        if i == j:
            Bs[t, i, i] = 1.0
        else:
            Bs[t, i, j] = Bs[t, j, i] = 1.0 / np.sqrt(2.0)
    # T(A) = -sum_k ad_k A ad_k
    TB = np.zeros_like(Bs)
    for k in range(N):
        TB -= np.einsum('ab,tbc,cd->tad', ads[k], Bs, ads[k])
    return np.einsum('tab,sab->ts', TB, Bs)


def report(nmax=8):
    print(f"{'n':>3} {'dimSym':>7}  eigenvalues of T (value x multiplicity)")
    for n in range(3, nmax + 1):
        Tm = T_matrix(n)
        assert np.abs(Tm - Tm.T).max() < 1e-9
        ev = np.linalg.eigvalsh(Tm)
        vals, cnts = np.unique(np.round(ev, 8), return_counts=True)
        pred = {2 * n - 4: 1, n - 4: n * (n + 1) // 2 - 1, -2: None,
                4: (n * (n - 1) * (n - 2) * (n - 3)) // 24}
        s = "  ".join(f"{v:+.4f}x{c}" for v, c in zip(vals, cnts))
        print(f"{n:>3} {len(ev):>7}  {s}")
        print(f"      predicted: triv {2*n-4}x1, Sym^2_0 {n-4}x{n*(n+1)//2-1}, "
              f"Weyl -2x{n*(n+1)*(n+2)*(n-3)//12}, Lam^4 4x{(n*(n-1)*(n-2)*(n-3))//24}"
              f"   min eig = {ev.min():+.10f}")
    return


if __name__ == "__main__":
    report(int(sys.argv[1]) if len(sys.argv) > 1 else 8)
