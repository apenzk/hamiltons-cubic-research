import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import r311_core as K

def diag_op(n, M):
    P = K.pair_list(n)
    return np.diag([M[i,j] for (i,j) in P])

for n in [4,5,6,8]:
    N = n*(n-1)//2
    I = np.eye(N)
    sh = K.sharp(n, I)
    print(f"n={n}: Id# = {sh[0,0]:.6f} * Id, offdiag max {np.abs(sh-np.diag(np.diag(sh))).max():.2e}, want {n-2}")
    # diagonal sharp test
    rng = np.random.default_rng(0)
    M = rng.normal(size=(n,n)); M = M+M.T; np.fill_diagonal(M,0)
    Wd = diag_op(n,M)
    shd = K.sharp(n,Wd)
    M2 = M@M
    want = diag_op(n, M2 - np.diag(np.diag(M2))*0)
    want = np.diag([M2[i,j] for (i,j) in K.pair_list(n)])
    print(f"   diagonal sharp err {np.abs(shd-want).max():.2e}, offdiag {np.abs(shd-np.diag(np.diag(shd))).max():.2e}")
    # Weyl projection: idempotent, self-adjoint, dims
    A = rng.normal(size=(N,N)); A = A+A.T
    W1 = K.weyl_project(n,A); W2 = K.weyl_project(n,W1)
    B = rng.normal(size=(N,N)); B=B+B.T
    sa = np.sum(K.weyl_project(n,A)*B) - np.sum(A*K.weyl_project(n,B))
    print(f"   proj idempotent {np.abs(W1-W2).max():.2e}, self-adjoint {sa:.2e}")
    bas = K.weyl_basis(n)
    dimw = n*(n+1)*(n+2)*(n-3)//12
    print(f"   dim Weyl_{n} = {len(bas)}, formula {dimw}")
    # Q maps Weyl to Weyl
    qq = K.Q(n, W1)
    print(f"   Q(W) in Weyl: {np.abs(qq-K.weyl_project(n,qq)).max():.2e}")
