import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
from collections import Counter
rng=np.random.default_rng(505)

def sphere_product_R(m1,m2):
    n=m1+m2; R=np.zeros((n,)*4)
    for (off,mm) in ((0,m1),(m1,m2)):
        I=range(off,off+mm)
        for i in I:
            for j in I:
                for k in I:
                    for l in I:
                        R[i,j,k,l]=(i==k)*(j==l)-(i==l)*(j==k)
    return R

def diag_parts(W):
    n=W.shape[0]; B=s20_basis(n); rw=ringW(W)
    d=np.diag(rw); npair=n*(n-1)//2
    return d[:npair], d[npair:]

print("A) phi-diagonal of ringW  vs  K_ab = W_abab")
for n in [5,6,8]:
    W=rand_weyl(n,rng); W/=np.linalg.norm(M_of(W))
    dphi,dpsi=diag_parts(W)
    K=np.array([W[a,b,a,b] for (a,b) in pairs(n)])
    print(f"   n={n}: max|dphi - K| = {np.abs(dphi-K).max():.2e}   (npairs={len(K)}, npsi={len(dpsi)})")

print("\nB) ratio sum(d^3)/p3(omega) at S^m x S^m")
for m in [2,3,4,5,6]:
    n=2*m; R=sphere_product_R(m,m); W=pr(R); W/=np.linalg.norm(M_of(W))
    dphi,dpsi=diag_parts(W); rw=ringW(W); p3o=float(np.sum(np.linalg.eigvalsh(rw)**3))
    full=np.concatenate([dphi,dpsi])
    print(f"   m={m} n={n}: sum dphi^3={np.sum(dphi**3):+.6f}  sum dfull^3={np.sum(full**3):+.6f}  "
          f"p3(om)={p3o:+.6f}   ratio_phi={np.sum(dphi**3)/p3o:+.5f}  ratio_full={np.sum(full**3)/p3o:+.5f}")

print("\nC) same ratio for random Weyl tensors (is blindness generic or family-specific?)")
for n in [6,8,10,12]:
    rs=[]
    for t in range(12):
        W=rand_weyl(n,rng); W/=np.linalg.norm(M_of(W))
        dphi,dpsi=diag_parts(W); rw=ringW(W); p3o=float(np.sum(np.linalg.eigvalsh(rw)**3))
        full=np.concatenate([dphi,dpsi])
        rs.append((np.sum(dphi**3)/p3o, np.sum(full**3)/p3o, p3o))
    rs=np.array(rs)
    print(f"   n={n}: ratio_phi med {np.median(rs[:,0]):+.4f} [{rs[:,0].min():+.3f},{rs[:,0].max():+.3f}]  "
          f"ratio_full med {np.median(rs[:,1]):+.4f} [{rs[:,1].min():+.3f},{rs[:,1].max():+.3f}]  |p3om| med {np.median(np.abs(rs[:,2])):.4f}")

print("\nD) CP^2 champion: theta of the extended Weyl tensor of CP^2")
def cp2_R():
    J=np.zeros((4,4)); J[0,1]=1;J[1,0]=-1;J[2,3]=1;J[3,2]=-1
    I=np.eye(4)
    R=(np.einsum('ik,jl->ijkl',I,I)-np.einsum('il,jk->ijkl',I,I)
       +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
       +2*np.einsum('ij,kl->ijkl',J,J))
    return R
R4=cp2_R(); W4=pr(R4)
print("   W4 nonzero:",np.linalg.norm(W4)>1e-9)
for n in [4,5,6,8,10,12]:
    W=np.zeros((n,)*4); W[:4,:4,:4,:4]=W4
    W=pr(W)
    nn=np.linalg.norm(M_of(W)); W/=nn
    M=M_of(W); rw=ringW(W)
    th=1.5*p3(M)-0.5*p3(rw)
    th2=float(np.trace(M@M@M)+np.sum(sharp(M,n)*M))
    print(f"   n={n}: theta={th:.10f} (direct sharp {th2:.10f})  sqrt(3/2)={np.sqrt(1.5):.10f}  theta0={theta0(n):.6f}"
          f"  p3(mu)={p3(M):+.6f} p3(om)={p3(rw):+.6f}")
