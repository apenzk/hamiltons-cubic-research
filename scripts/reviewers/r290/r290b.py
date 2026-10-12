import numpy as np
from r290 import *
from scipy.optimize import minimize
from scipy.linalg import expm
np.set_printoptions(precision=6,suppress=True)

print("=== convention screen: which index order makes BOTH halves of C1 true and the -1/2 sign right ===")
rng=np.random.default_rng(290)
for n in [6,7]:
    W=weyl_part(sym_curv(rng.standard_normal((n,)*4),n),n)
    M,idx=Mmat(W,n); W=W/np.linalg.norm(M); M,idx=Mmat(W,n)
    mu=np.linalg.eigvalsh(M); th,al,be=theta_direct(W)
    sec=np.array([W[i,j,i,j] for (i,j) in idx])
    print(f" n={n} |Ric|={np.abs(np.einsum('ikjk->ij',W)).max():.1e} Bianchi={np.abs(W+W.transpose(0,2,3,1)+W.transpose(0,3,1,2)).max():.1e}")
    for order in ['iklj','ikjl']:
        Rg,B,lab=ring_op(W,n,order)
        asym=np.abs(Rg-Rg.T).max()
        om=np.linalg.eigvalsh(Rg); N2=len(idx)
        print(f"   order {order}: sym-residual={asym:.1e} tr(Rg^2)={np.trace(Rg@Rg):.6f} "
              f"phi-diag - W_ijij = {np.abs(np.diag(Rg)[:N2]-sec).max():.1e}  phi-diag + W_ijij = {np.abs(np.diag(Rg)[:N2]+sec).max():.1e}")
        print(f"      tr(Rg^3)={np.sum(om**3):+.9f}  alpha/8-beta={al/8-be:+.9f}  beta-alpha/8={be-al/8:+.9f}")
        print(f"      1.5p3(mu)-0.5p3(om)={1.5*np.sum(mu**3)-0.5*np.sum(om**3):+.9f}  1.5p3+0.5p3={1.5*np.sum(mu**3)+0.5*np.sum(om**3):+.9f}  theta={th:+.9f}")
