import sys; sys.path.insert(0,'scripts/reviewers/r335')
import numpy as np, w335 as w

def op_from_tensor(R,n):
    P=w.pairs(n); N=len(P)
    S=np.zeros((N,N))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            S[a,b]=R[i,j,k,l]
    return S

def fs_curv(n):
    """Fubini-Study (0,4) curvature tensor on R^n=C^m, holomorphic sect curv 4."""
    m=n//2
    g=np.eye(n); J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1.0; J[2*k+1,2*k]=-1.0
    # J_{ij} = g(J e_i, e_j) = J[i,j]
    R=(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
       +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
       +2*np.einsum('ij,kl->ijkl',J,J))
    return R

def report(name,S,n,c,B):
    S=(S+S.T)/2
    PW=w.proj_weyl(S,B)
    dist=np.sqrt(((S-PW)**2).sum())/max(np.sqrt((S*S).sum()),1e-300)
    W=PW/np.sqrt((PW*PW).sum())
    lam=np.linalg.eigvalsh(W); Q=w.Qmap(W,c); th=float((W*Q).sum())
    res=np.linalg.norm(Q-th*W)
    lmax,lmin=lam[-1],lam[0]
    r=lmax/abs(lmin)
    # mirror
    r2=abs(lmin)/lmax
    # sharpened form at argmax: -lmax/(n-2) >= (lam[0]+lam[1])/2
    sh=-lmax/(n-2)-(lam[0]+lam[1])/2
    print("%-22s n=%d  rel-dist(S,W_n)=%.2e  theta=%.6f  critres=%.2e"%(name,n,dist,th,res))
    print("     lmax=%.6f lmin=%.6f  ratio=%.6f (n-2=%d)  mirror=%.6f  sharpened-slack=%.6f"%(lmax,lmin,r,n-2,r2,sh))
    print("     mult(lmin)=%d mult(lmax)=%d  spectrum=%s"%( (np.abs(lam-lmin)<1e-9).sum(),(np.abs(lam-lmax)<1e-9).sum(), np.round(np.unique(np.round(lam,8)),6)))
    return r

for n in [4,6,8,10]:
    c=w.struct(n); B=w.weyl_basis(n)
    R=fs_curv(n); S=op_from_tensor(R,n)
    # check Bianchi of R
    bi=np.abs(R+np.transpose(R,(0,2,3,1))+np.transpose(R,(0,3,1,2))).max()
    print("CP^%d Bianchi residual %.1e"%(n//2,bi))
    report("CP^%d"%(n//2),S,n,c,B)

print()
for n in [5,6,7,8,9,10]:
    c=w.struct(n); B=w.weyl_basis(n); P=w.pairs(n); N=len(P)
    rows=[t for t,(i,j) in enumerate(P) if j==i+1 and i%2==0]
    Pi=np.zeros((N,N))
    for t in rows: Pi[t,t]=1.0
    r=len(rows)
    S=Pi-(r/N)*np.eye(N)
    report("torus so(2)^%d"%r,S,n,c,B)
