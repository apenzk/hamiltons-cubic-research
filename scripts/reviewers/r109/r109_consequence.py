"""Does exploiting g's internal structure sharpen the recorded bound?

Three bounds on theta, all from -4 theta = sum_gamma lam_gamma g_gamma:
  B1 recorded   : |lam_min| * (4(n-1) - Delta - G0) / 4          [uses g>=0, sum g]
  B2 sharpened  : (|lam_min| M - lam_p_min Delta) / 4            [uses g's sign-stratum split]
  B3 capped     : water-fill with the per-direction cap g_gamma <= 2(n-2)(lam_max-lam_min)^2,
                  which comes from SUBSTITUTING Prop 1.7 -- the step fence post 25 calls circular.
"""
import numpy as np

rng = np.random.default_rng(1090)

def kn(A,B):
    o = np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
    o -= np.einsum('il,jk->ijkl',A,B)+np.einsum('jk,il->ijkl',A,B)
    return o

def weyl_from_riemann(R,n):
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); S=np.trace(Ric); Ric0=Ric-(S/n)*g
    return R - kn(Ric0,g)/(n-2) - S/(2*n*(n-1))*kn(g,g)

def random_weyl(n):
    R=rng.standard_normal((n,n,n,n))
    R=R-R.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(0,2,3,1)+R.transpose(0,3,1,2))/3.0
    return weyl_from_riemann(R,n)

def sphere_product(p,q):
    n=p+q
    gp=np.zeros((n,n)); gp[:p,:p]=np.eye(p)
    gq=np.zeros((n,n)); gq[p:,p:]=np.eye(q)
    return weyl_from_riemann(0.5*kn(gp,gp)+0.5*kn(gq,gq),n),n

def pairs(n): return [(i,j) for i in range(n) for j in range(i+1,n)]

def data(W,n):
    P=pairs(n); N=len(P)
    M=np.array([[W[i,j,k,l] for (k,l) in P] for (i,j) in P]); M/=np.linalg.norm(M)
    lam,V=np.linalg.eigh(M)
    B=np.zeros((N,n,n))
    for a,(i,j) in enumerate(P): B[a,i,j]=1.0; B[a,j,i]=-1.0
    Vso=np.einsum('ba,bij->aij',V,B)
    comm=np.einsum('aik,bkj->abij',Vso,Vso)-np.einsum('bik,akj->abij',Vso,Vso)
    T=(0.5*np.einsum('abij,gij->gab',comm,Vso))**2
    adm=0.5*(np.einsum('gik,bkj->gbij',Vso,B)-np.einsum('bik,gkj->gbij',B,Vso))
    ad=np.einsum('gbij,aij->gab',adm,B)
    g=np.array([np.linalg.norm(ad[k]@M-M@ad[k])**2 for k in range(N)])
    p3=float((lam**3).sum()); sharp=0.5*np.einsum('gab,g,a,b->',T,lam,lam,lam)
    return lam,g,T,p3+sharp

def bounds(lam,g,n,tol=1e-9):
    pos=lam>tol; neg=lam<-tol; ker=~(pos|neg)
    Delta=g[pos].sum(); G0=g[ker].sum(); m=4*(n-1)-Delta-G0
    lmin=lam.min(); B1=abs(lmin)*m/4
    lpmin=lam[pos].min() if pos.any() else 0.0
    B2=(abs(lmin)*m-lpmin*Delta)/4
    # B3: water-fill the mass m over the negative directions, cap per direction
    cap=2*(n-2)*(lam.max()-lam.min())**2
    idx=np.argsort(lam)                        # ascending, most negative first
    idx=[i for i in idx if neg[i]]
    rem=m; acc=0.0
    for i in idx:
        take=min(cap,rem); acc+=lam[i]*take; rem-=take
        if rem<=1e-12: break
    feasible = rem<=1e-9
    B3=(-(acc)-lpmin*Delta)/4 if feasible else np.nan
    return dict(Delta=Delta,G0=G0,m=m,lmin=lmin,lpmin=lpmin,cap=cap,
                B1=B1,B2=B2,B3=B3,feasible=feasible,ndim_min=int((lam<lmin+1e-9).sum()),
                gmin_actual=g[np.argmin(lam)])

print(f"{'point':>14} {'n':>2} {'theta':>10} {'B1 rec':>10} {'B2 sharp':>10} {'B3 capped':>10} {'Delta':>8} {'cap':>7}")
rows=[]
for (p,q) in [(3,3),(4,4),(3,5),(2,4)]:
    W,n=sphere_product(p,q); lam,g,T,th=data(W,n); b=bounds(lam,g,n)
    rows.append((f"S^{p}xS^{q}",n,th,b))
for n in (5,6,7,8):
    for k in range(3):
        W=random_weyl(n); lam,g,T,th=data(W,n); b=bounds(lam,g,n)
        rows.append((f"rand{k}",n,th,b))
for name,n,th,b in rows:
    print(f"{name:>14} {n:2d} {th:10.6f} {b['B1']:10.6f} {b['B2']:10.6f} "
          f"{b['B3']:10.6f} {b['Delta']:8.4f} {b['cap']:7.3f}")
