"""Witnesses: the cap above theta_0, the C6 approach family, the tolerance jump."""
import sys, numpy as np
from scipy.optimize import minimize
sys.path.insert(0,'scripts/lib'); sys.path.insert(0,'scripts/reviewers/r291')
from r291_core import *

def th_of(M): return float(0.5*(np.sum(M**3)+np.trace(M@M@M)))
def resM(M):
    th=th_of(M); R=M*M+M@M-th*M-np.diag(np.sum(M*M,axis=1)); return float(np.abs(R).max())
def caps(M):
    n=M.shape[0]; s=np.sum(M*M,axis=1); out=[]
    for (a,b) in pairs_of(n):
        if M[a,b]>1e-12:
            c1=(s[a]+s[b])/(2*M[a,b])
            c2=(s[a]+s[b]-max((M[a,c]-M[b,c])**2 for c in range(n) if c not in (a,b)))/(2*M[a,b])
            out.append((c1,c2))
    return min(o[0] for o in out), min(o[1] for o in out)

def unpack(n,x,B):
    v=x@B; v/=np.linalg.norm(v); return vec_to_M(n,v)
def res(n,x,B):
    M=unpack(n,x,B); return resM(M)**2

rng=np.random.default_rng(555)
print("=== how high can C8's cap go at a genuine diagonal CRITICAL point? ===")
print(f"  {'n':>2s} {'#pts':>5s} {'theta_0':>9s} | {'max cap (theta>0)':>18s} {'S=0 only':>10s} | "
      f"{'max cap2':>9s} {'S=0 only':>10s}")
store={}
for n in (5,6,7,8):
    B=locus_basis(n); k=B.shape[0]; pts=[]; vals=[]
    for r in range(200):
        out=minimize(lambda x: res(n,x,B), rng.normal(size=k), method='BFGS',
                     options={'maxiter':3000,'gtol':1e-14})
        out=minimize(lambda x: res(n,x,B), out.x, method='Nelder-Mead',
                     options={'maxiter':20000,'xatol':1e-14,'fatol':1e-24})
        M=unpack(n,out.x,B)
        if resM(M)>1e-8: continue
        if np.abs(M).max()<1e-9: continue
        if min(np.sum(np.abs(M),axis=1))<1e-9: continue    # drop padded points
        th=th_of(M)
        if any(abs(th-t)<1e-6 for t in vals): continue
        vals.append(th); pts.append(M)
    th0=np.sqrt(2*(n-1)*(n-2))/n
    def mx(f,sel):
        c=[f(M) for M in pts if th_of(M)>1e-9 and sel(M)]
        return max(c) if c else float('nan')
    S0=lambda M: defect_diag(n,M)[2]<1e-9
    print(f"  {n:>2d} {len(pts):>5d} {th0:>9.6f} | {mx(lambda M:caps(M)[0],lambda M:True):>18.6f} "
          f"{mx(lambda M:caps(M)[0],S0):>10.6f} | {mx(lambda M:caps(M)[1],lambda M:True):>9.6f} "
          f"{mx(lambda M:caps(M)[1],S0):>10.6f}")
    store[n]=pts

print("\n=== the explicit witnesses: cap > theta_0(n) at a critical point ===")
for n in (5,6,7,8):
    th0=np.sqrt(2*(n-1)*(n-2))/n
    for M in store[n]:
        th=th_of(M); c1,c2=caps(M)
        D,tot,S,g,lam=defect_diag(n,M)
        if th>1e-9 and c1>th0:
            print(f"  n={n} theta={th:.6f} cap={c1:.6f} > theta_0={th0:.6f}  cap2={c2:.6f}  "
                  f"S={S:.0f} Delta={D:.4f} crit={resM(M):.1e}")
            print("   M =", np.round(M,6).tolist())
            break

import sys; sys.exit(0)
print("\n=== C6: the approach family at even n -- Delta>0, S_mmm=0, theta -> theta_0 ===")
for n in (4,6,8,10):
    p=n//2; th0=np.sqrt(2*(n-1)*(n-2))/n
    lab=np.array([0]*p+[1]*p)
    M0=np.zeros((n,n))
    for i in range(n):
        for j in range(i+1,n):
            M0[i,j]=M0[j,i]= 1.0/(p*(p-1)) if lab[i]==lab[j] else -1.0/(p*p)
    print(f"  n={n}  theta_0={th0:.9f}")
    for eps in (1e-1,1e-2,1e-3,1e-4):
        M=M0.copy()
        a,b,d,e=0,1,p,p+1                       # a,b in block A; d,e in block B
        for (u,v,sg) in ((a,d,+1),(b,e,+1),(a,e,-1),(b,d,-1)):
            M[u,v]+=sg*eps; M[v,u]+=sg*eps
        Mn=M/np.sqrt(0.5*np.sum(M*M))
        D,tot,S,g,lam=defect_diag(n,Mn)
        print(f"    eps={eps:.0e}: rowsum={np.abs(M@np.ones(n)).max():.1e} theta={th_of(Mn):.9f} "
              f"(theta_0-theta={th0-th_of(Mn):+.3e})  Delta={D:.6e}  S_mmm={S:.1f}  crit={resM(Mn):.2e}")

print("\n=== the tolerance jump in Delta (a property of defect(), not of C2) ===")
from b_symmetry_defect import defect as record_defect
n=7
for epsv in (5e-10, 1e-8, 1e-6):
    M=np.zeros((7,7))
    for i in range(3):
        for j in range(i+1,3): M[i,j]=M[j,i]=1/6.
    for i in range(3,6):
        for j in range(i+1,6): M[i,j]=M[j,i]=1/6.
    for i in range(3):
        for j in range(3,6): M[i,j]=M[j,i]=-1/9.
    M[0,6]=M[6,0]=epsv; M[1,6]=M[6,1]=-epsv
    M[0,2]=M[2,0]=1/6.-epsv; M[1,2]=M[2,1]=1/6.+epsv
    rs=np.abs(M@np.ones(7)).max()
    Mn=M/np.sqrt(0.5*np.sum(M*M))
    D,tot,S,g,lam=defect_diag(7,M)
    Dexact=2*sum(sum((Mn[a,dd]-Mn[b,dd])**2 for dd in range(7) if dd not in (a,b))
                 for (a,b) in pairs_of(7) if Mn[a,b]>0)
    th,isw,d,Dr,tr,Sm,Sp,z=record_defect(7,M_to_W(M))
    print(f"  eps={epsv:.0e} rowsum={rs:.1e} smallest positive entry={Mn[Mn>0].min():.3e}  "
          f"Delta(tol=1e-9)={D:.6f} record={Dr:.6f}  Delta(exact, >0)={Dexact:.6f}")
