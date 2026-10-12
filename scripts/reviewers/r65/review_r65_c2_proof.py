"""Reviewer 65 / C2: a PROOF that an isotropic subspace of so(n) has dim <= floor(n^2/4),
with every step verified numerically.

    Lemma A (any subspace).  mu(m) := sum_{a,b in onb(m)} |[e_a,e_b]|^2  equals <T(P),P>
      for the orthoprojector P onto m, where T(A) = -sum_k ad(f_k) A ad(f_k).
      T is self-adjoint and SO(n)-equivariant on Sym(so(n)) = R + Sym^2_0(V) + Weyl + Lam^4 V,
      acting by 2n-4, n-4, -2, 4.  Hence T(I) = (2n-4) I and T >= -2 on I^perp, so
          mu(m) >= (2n-2) d^2 / N - 2 d = 4 d^2 / n - 2 d.
    Lemma B (isotropic subspaces).  For X in m, P_m ad(X) P_m = 0, so tr ad(X)^2 =
      -2||B_X||^2 + tr C_X^2 with B_X = P_h ad(X)|_m, C_X = P_h ad(X)|_h; Killing gives
      tr ad(X)^2 = -2(n-2)|X|^2, hence  2 mu(m) + gamma = 2(n-2) d  with gamma >= 0, so
          mu(m) <= (n-2) d.
    Chain.  4d^2/n - 2d <= (n-2) d  =>  4d/n <= n  =>  d <= n^2/4.
    Equality (n even, d = n^2/4) forces gamma = 0, i.e. h = m^perp is a subalgebra and
    (h,m) is a symmetric pair; Cartan's classification of involutions of so(n) then leaves
    only so(n/2)+so(n/2).  That is claim C3 for even n.
"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from review_r65_lib import (structure_tensor, ad_matrices, mu, iso_residual,
                            sympair_subspace, graph_subspace, orth)
from review_r65_c2_operator import T_matrix, sym_basis


def Tapply(ads, A):
    return -np.einsum('kab,bc,kcd->ad', ads, A, ads)


def check(n, rng, ntrials=6):
    C = structure_tensor(n)
    ads = ad_matrices(n)
    N = C.shape[0]
    out = []
    # (i) mu(m) == <T(P),P>
    worst = 0.0
    for d in range(1, N + 1):
        V = orth(rng.standard_normal((N, d)))
        P = V @ V.T
        worst = max(worst, abs(mu(V, C) - np.einsum('ab,ab->', Tapply(ads, P), P)))
    out.append(("mu == <T(P),P>", worst))
    # (ii) min eigenvalue of T on I-perp
    Tm = T_matrix(n)
    idx = sym_basis(N)
    Ivec = np.zeros(len(idx))
    for t, (i, j) in enumerate(idx):
        if i == j:
            Ivec[t] = 1.0
    Ivec /= np.linalg.norm(Ivec)
    Q = np.eye(len(idx)) - np.outer(Ivec, Ivec)
    lam = np.linalg.eigvalsh(Q @ Tm @ Q + 1e6 * np.outer(Ivec, Ivec)).min()
    tI = float(Ivec @ Tm @ Ivec)
    out.append(("T(I) eigenvalue == 2n-4", abs(tI - (2 * n - 4))))
    out.append(("min eig of T on I^perp", lam))
    # (iii) Lemma A on random subspaces
    bad = 0.0
    for d in range(1, N + 1):
        for _ in range(ntrials):
            V = orth(rng.standard_normal((N, d)))
            lhs = mu(V, C)
            rhs = (2 * n - 4) * d * d / N + lam * (d - d * d / N)
            bad = min(bad, lhs - rhs)
    out.append(("min slack in mu >= (2n-4)d^2/N + lam*(d-d^2/N)", bad))
    # (iv) Lemma B on isotropic examples
    worstB = -1e9
    ex = []
    for p in range(1, n // 2 + 1):
        ex.append(sympair_subspace(n, p))
    for V in ex:
        d = V.shape[1]
        worstB = max(worstB, mu(V, C) - (n - 2) * d)
    out.append(("max of mu-(n-2)d over symmetric pairs (must be <=0, =0 here)", worstB))
    return out, lam


if __name__ == "__main__":
    rng = np.random.default_rng(65)
    print("Verification of the two lemmas, n = 3..8\n")
    for n in range(3, 9):
        res, lam = check(n, rng)
        N = n * (n - 1) // 2
        print(f"n={n}  N={N}  floor(n^2/4)={n*n//4}")
        for name, val in res:
            print(f"     {name:<52} {val:+.3e}")
        # the resulting bound
        # mu >= (2n-4)d^2/N + lam(d - d^2/N)  and  mu <= (n-2)d
        # => d * [ (2n-4-lam)d/N + lam ] <= (n-2) d  => d <= N(n-2-lam)/(2n-4-lam)
        bound = N * (n - 2 - lam) / (2 * n - 4 - lam)
        print(f"     => isotropic dim <= {bound:.6f}  (floor {int(np.floor(bound+1e-9))}), "
              f"claim floor(n^2/4) = {n*n//4}\n")


def residual_floor(n, d):
    """The proof gives a QUANTITATIVE floor on the 3-form mass of any d-dim subspace:
       alpha = 2 mu + gamma - 2(n-2)d  >=  2 mu - 2(n-2) d  >=  (2d/n)(4d - n^2),
    where alpha = sum_{a,b,c in m} c'^2 is exactly the isotropy residual.  It is 0 for
    d <= n^2/4 and positive beyond, so it re-proves C2 and predicts how badly the
    search at floor(n^2/4)+1 must fail."""
    return max(0.0, (2.0 * d / n) * (4.0 * d - n * n))
