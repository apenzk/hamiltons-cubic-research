import sys; sys.path.insert(0,'scripts/reviewers/r320')
import numpy as np, itertools, lib320 as L, cat320 as C, gcheck as G
from p1 import S_triple, eigframes

def stab(W,n):
    """symmetry algebra k(W)={x: [ad(x),W]=0}: dimension and a basis."""
    c=L.struct(n); N=c.shape[0]
    rows=[]
    for gidx in range(N):
        v=np.zeros(N); v[gidx]=1.0
        A=G.adm(v,n); rows.append((A@W-W@A).ravel())
    M=np.array(rows).T      # (N^2, N)
    u,s,vt=np.linalg.svd(M)
    k=int((s<1e-9*max(1.0,s[0])).sum())+ (N-len(s))
    return k, vt[len(s)-int((s<1e-9*max(1.0,s[0])).sum()):]

print("=== P3(a): the gradedness screen over E_+/E_- only, when ker W != 0 ===")
print(f"{'point':16}{'n':>3}{'dim so(n)':>10}{'r+':>4}{'r-':>4}{'ker':>5}{'S_mmm':>10}{'S_mpp':>10}{'S_ppm':>10}{'S_ppp':>10}| {'S_hhm(iso)':>12}")
for n in [4,8,10,12]:
    W=C.cp2(n); N=L.struct(n).shape[0]
    pf,mf,kf=eigframes(W)
    Smmm=S_triple(mf,mf,mf,n); Smpp=S_triple(mf,pf,pf,n); Sppm=S_triple(pf,pf,mf,n); Sppp=S_triple(pf,pf,pf,n)
    # isotropy splitting: h = stabiliser algebra, m = its perp
    kd,kb=stab(W,n)
    hb=kb; 
    # orthonormal complement of h
    Pi=np.array(hb).T@np.array(hb); mm=np.eye(N)-Pi
    w,V=np.linalg.eigh(mm); mb=V[:,w>0.5].T
    Shhm=S_triple(hb,hb,mb,n)
    print(f"{'CP^2 pad':16}{n:>3}{N:>10}{pf.shape[0]:>4}{mf.shape[0]:>4}{kf.shape[0]:>5}{Smmm:>10.3e}{Smpp:>10.3e}{Sppm:>10.3e}{Sppp:>10.3e}| dim k={kd:<3} {Shhm:>10.4f}")
print()
print("=== P3(b): pair-graded (C) vs sign-graded (A) at W_CP^2, n=4 ===")
n=4; W=C.cp2(4); N=6
pf,mf,kf=eigframes(W)
print("  dim E_+ =",pf.shape[0]," dim E_- =",mf.shape[0]," ker =",kf.shape[0]," dim so(4) =",N)
print("  sign splitting spans so(4)?", pf.shape[0]+mf.shape[0]==N, " -> sense (A) fails by dimension count")
# u(2) involution: sigma = Ad(J), J the complex structure
J=np.zeros((4,4)); J[0,1]=1;J[1,0]=-1;J[2,3]=1;J[3,2]=-1
P,idx,phi=L.basis(4)
Sig=np.zeros((N,N))
for a in range(N):
    X=J@phi[a]@J.T
    for b,(i,j) in enumerate(P): Sig[b,a]=X[i,j]
ev=np.linalg.eigvalsh(Sig)
print("  Ad(J) involution on so(4): eigenvalues",np.round(ev,6)," (+1 mult=%d -> u(2), -1 mult=%d)"%(int((ev>0).sum()),int((ev<0).sum())))
print("  [W, Ad(J)] = %.3e  -> W IS pair-graded for (so(4),u(2))"%np.linalg.norm(W@Sig-Sig@W))
# check W is +-block-diagonal for the involution
Pp=(np.eye(N)+Sig)/2; Pm=(np.eye(N)-Sig)/2
print("  off-diagonal mass of W across the u(2)-splitting: %.3e"%np.linalg.norm(Pp@W@Pm))
print()
print("=== P3(c): Delta=0 => ad(p)-equivariant, off ker W=0 ===")
for n in [4,8,12]:
    W=C.cp2(n); ev,V,g=G.gvec(W,n)
    pos=ev>1e-9
    kd,_=stab(W,n)
    N=L.struct(n).shape[0]
    syms=[("so(%d)+so(%d)"%(p,n-p), p*(p-1)//2+(n-p)*(n-p-1)//2) for p in range(1,n//2+1)]
    if n%2==0: syms.append(("u(%d)"%(n//2),(n//2)**2))
    print(f"  n={n:<3} dim E_+={int(pos.sum())}  Delta=sum_p g = {g[pos].sum():.3e}  dim k(W)={kd}  dim so(n)={N}")
    print(f"        symmetric subalgebras of so({n}) and their dims: "+", ".join(f"{a}:{b}" for a,b in syms))
    print(f"        every symmetric subalgebra has dim > dim k(W)? {all(b>kd for a,b in syms)}  -> W is ad(k)-equivariant for NO symmetric subalgebra")
