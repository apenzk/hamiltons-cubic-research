"""Push K2/K3 to large splits by building {V in Weyl_n : supp V in (pp,mix)} directly,
without the full Weyl basis and without L_e."""
import numpy as np, sys, time
from itertools import combinations
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *

def supp_block_basis(p,q):
    """Orthonormal basis of {V in Weyl_n symmetric, first Bianchi, Ric=0,
       supported on (pp,mix)} -- solved directly in the support coordinates."""
    n=p+q; prs,idx=pairs_of(n); N=len(prs)
    ppp=[a for a,(i,j) in enumerate(prs) if j<p]
    mix=[a for a,(i,j) in enumerate(prs) if i<p<=j]
    coord={}; 
    for a in ppp:
        for b in mix:
            coord[(a,b)]=len(coord)
    D0=len(coord)
    def add(row,i,j,k,l,c):
        if i==j or k==l: return
        s=1.0
        if i>j: i,j,s=j,i,-s
        if k>l: k,l,s=l,k,-s
        a,b=idx[(i,j)],idx[(k,l)]
        key=(a,b) if (a,b) in coord else ((b,a) if (b,a) in coord else None)
        if key is None: return           # entry outside the support: identically 0
        row[coord[key]]+=c*s
    rows=[]
    # Bianchi: only the {3 from p, 1 from q} four-subsets carry anything
    for tri in combinations(range(p),3):
        for m in range(p,n):
            i,j,k=tri
            for (a,b,c,d) in [(i,j,k,m)]:
                row=np.zeros(D0)
                add(row,a,b,c,d,1.0); add(row,a,c,d,b,1.0); add(row,a,d,b,c,1.0)
                rows.append(row)
    # general Bianchi safety net over ALL 4-subsets
    for quad in combinations(range(n),4):
        i,j,k,l=quad
        row=np.zeros(D0)
        add(row,i,j,k,l,1.0); add(row,i,k,l,j,1.0); add(row,i,l,j,k,1.0)
        if np.abs(row).max()>0: rows.append(row)
    # Ricci
    for i in range(n):
        for k in range(i,n):
            row=np.zeros(D0)
            for j in range(n): add(row,i,j,k,j,1.0)
            if np.abs(row).max()>0: rows.append(row)
    C=np.array(rows) if rows else np.zeros((1,D0))
    u,s,vt=np.linalg.svd(C,full_matrices=True)
    rank=int((s>1e-9*s[0]).sum()) if s.size else 0
    ns=vt[rank:]
    B=[]
    inv={v:k for k,v in coord.items()}
    for v in ns:
        M=np.zeros((N,N))
        for t in range(D0):
            a,b=inv[t]; M[a,b]+=v[t]; M[b,a]+=v[t]
        B.append(M/np.linalg.norm(M))
    return np.array(B), n, N

def check_weyl(M,n):
    """independent re-verification that M is symmetric, Bianchi, Ricci-flat."""
    prs,idx=pairs_of(n)
    f=Rval_map(n)
    bmax=0.0
    for quad in combinations(range(n),4):
        i,j,k,l=quad
        bmax=max(bmax,abs(f(M,i,j,k,l)+f(M,i,k,l,j)+f(M,i,l,j,k)))
    rmax=0.0
    for i in range(n):
        for k in range(n):
            rmax=max(rmax,abs(sum(f(M,i,j,k,j) for j in range(n))))
    return np.abs(M-M.T).max(), bmax, rmax

if __name__=="__main__":
    print(f"{'(p,q)':>8} {'dim supp cap Weyl':>18} {'X(p)*q':>8} {'sym/Bianchi/Ric err':>24} {'max||sb(Ip,V)+V/2||/||V||':>26} {'c':>10} {'sec':>6}")
    rng=np.random.default_rng(19)
    for (p,q) in [(3,3),(3,4),(4,4),(5,5),(3,9),(6,6),(5,7),(4,9),(7,7),(6,8),(3,12),(8,6)]:
        t0=time.time()
        B,n,N=supp_block_basis(p,q)
        d=len(B); pred=p*(p*p-4)//3*q
        A=struct(n); Ip=I_block(n,0,p)
        errs=max(max(check_weyl(B[k],n)) for k in range(min(d,3))) if d else 0.0
        worst=0.0; cs=[]
        for t in range(6 if d>6 else max(d,1)):
            if d==0: break
            c=rng.normal(size=d); V=np.tensordot(c,B,axes=1); V/=np.linalg.norm(V)
            Y=sharp_bilin(A,Ip,V)
            worst=max(worst,np.linalg.norm(Y+0.5*V))
            cs.append(np.tensordot(Y,V))
        cr=f"{min(cs):.6f}" if cs else "n/a"
        print(f"{str((p,q)):>8} {d:18d} {pred:8d} {errs:24.1e} {worst:26.2e} {cr:>10} {time.time()-t0:6.1f}",flush=True)
