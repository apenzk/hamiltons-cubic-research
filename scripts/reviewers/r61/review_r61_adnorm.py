"""Reviewer 61: a consequence of C1 the record does not have.
Contracting  2W = sum_a lam_a ad(v_a)^2  with a unit u gives
   sum_a lam_a |[v_a,u]|^2 = -2<u,Wu>.
At u = v_N (the most negative eigenvector, eigenvalue lam_N < 0) the negative
terms drop out, so 2|lam_N| <= |ad_{v_N}|_op^2 * sum_{lam>0} lam, i.e.

   |ad_{v_N}|_op^2  >=  2|lam_N| / T_+ ,   T_+ = sum of positive eigenvalues.

With exactly two negative eigenvalues T_+ = b + c <= 2|lam_N|, so |ad_{v_N}|_op >= 1.
And |ad_X|_op = s_1 + s_2 for unit skew X (singular values s_i, each twice,
sum s_i^2 = 1), <= sqrt 2 with equality only at rank 4 with s_1 = s_2.
So the most negative eigenvector of any two-negative Weyl tensor has
s_1 + s_2 >= 1: at least half its norm sits in a single 4-plane."""
import numpy as np
from review_r61_core import weyl_basis, ad_matrix, vec_to_skew, theta
from review_r61_c5 import W4, dimU


def adnorm(v, m):
    return np.linalg.norm(ad_matrix(v, m), 2)


def svals(v, m):
    X = vec_to_skew(v, m)
    s = np.linalg.svd(X, compute_uv=False)
    return np.sort(s[::2])[::-1] if False else np.sort(s)[::-1][::2]


def check(W, m, name):
    W = W/np.linalg.norm(W)
    lam, V = np.linalg.eigh(W)
    y = V[:, 0]
    k = adnorm(y, m)
    Tp = lam[lam > 0].sum()
    s = svals(y, m)
    print(f"  {name}: lam_min={lam[0]:+.5f} T+={Tp:.5f} |ad_y|_op={k:.5f}"
          f"  bound sqrt(2|lam_min|/T+)={np.sqrt(2*abs(lam[0])/Tp):.5f}"
          f"  s1+s2={s[0]+s[1]:.5f}  #neg={(lam<-1e-9).sum()}")


if __name__ == '__main__':
    print("=== |ad_X|_op = s_1 + s_2 for unit skew X ===")
    rng = np.random.default_rng(4)
    for m in (6, 8, 10):
        D = m*(m-1)//2
        for _ in range(2):
            v = rng.normal(size=D); v /= np.linalg.norm(v)
            s = svals(v, m)
            print(f"  m={m}: |ad|_op={adnorm(v,m):.8f}  s1+s2={s[0]+s[1]:.8f}"
                  f"  sum s^2={np.sum(s**2):.8f}")
    print("\n=== the bound at the C5 witnesses and at random Weyl tensors ===")
    E6 = np.eye(6)
    W6 = W4([E6[0], E6[1], E6[2], E6[3]], 6, (-2, 1, 1)) + \
         W4([E6[2], E6[3], E6[4], E6[5]], 6, (-2, 1, 1))
    check(W6, 6, "m=6 C5 witness  ")
    E8 = np.eye(8)
    W8 = W4([E8[0], E8[1], E8[2], E8[3]], 8, (-2, 1, 1)) + \
         W4([E8[4], E8[5], E8[6], E8[7]], 8, (-2, 1, 1))
    check(W8, 8, "m=8 C5 witness  ")
    for m in (6, 8, 10):
        B = weyl_basis(m)
        for k in range(3):
            W = np.einsum('k,kij->ij', rng.normal(size=B.shape[0]), B)
            check(W, m, f"m={m} random Weyl #{k}")
