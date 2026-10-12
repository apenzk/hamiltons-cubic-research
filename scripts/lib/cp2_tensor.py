import numpy as np
import itertools, time
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, P_value, norm, frob, mop_from_4tensor

def make_J(n):
    J = np.zeros((n, n))
    # complex structure on span(e0,e1,e2,e3): J e0=e1, J e1=-e0, J e2=e3, J e3=-e2
    J[0, 1] = -1.0; J[1, 0] = 1.0   # <Je0,e1> = 1 means J[1,0]... define via <Ja,b>=J[a,b]? let's just build directly
    return J

def build_J(n):
    # J as an n x n matrix representing the linear map (J e_i = sum_k J[k,i] e_k)
    J = np.zeros((n, n))
    J[1, 0] = 1.0   # J e0 = e1
    J[0, 1] = -1.0  # J e1 = -e0
    J[3, 2] = 1.0   # J e2 = e3
    J[2, 3] = -1.0  # J e3 = -e2
    return J

def cp2_tensor(n, alpha=1.0, block=(0, 1, 2, 3)):
    J = build_J(n)
    Jmat = J.T.copy()  # Jmat[i,k] = J[k,i] = <J e_i,e_k>
    d = np.eye(n)
    blockset = set(block)
    def T(i, j, k, l):
        if not (i in blockset and j in blockset and k in blockset and l in blockset):
            return 0.0
        val = alpha * (d[i,k]*d[j,l] - d[i,l]*d[j,k])
        val += alpha * (Jmat[i,k]*Jmat[j,l] - Jmat[i,l]*Jmat[j,k])
        val += 2*alpha * Jmat[i,j]*Jmat[k,l]
        return val
    return T, Jmat

def bianchi_test(n):
    T, J = cp2_tensor(n)
    maxerr = 0.0
    idxs = list(range(min(n,5)))
    for i,j,k,l in itertools.product(idxs, repeat=4):
        val = T(i,j,k,l) + T(i,k,l,j) + T(i,l,j,k)
        maxerr = max(maxerr, abs(val))
    print(f"n={n}: max Bianchi violation over sample indices = {maxerr:.2e}")

if __name__ == "__main__":
    bianchi_test(6)
    bianchi_test(8)
