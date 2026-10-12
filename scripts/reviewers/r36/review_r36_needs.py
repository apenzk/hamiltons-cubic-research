"""Which of the defining conditions does the identity actually need?"""
import numpy as np, sys
from itertools import combinations
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *

def supp_basis(p,q,use_bianchi,use_ricci):
    n=p+q; prs,idx=pairs_of(n); N=len(prs)
    ppp=[a for a,(i,j) in enumerate(prs) if j<p]
    mix=[a for a,(i,j) in enumerate(prs) if i<p<=j]
    coord={}
    for a in ppp:
        for b in mix: coord[(a,b)]=len(coord)
    D0=len(coord)
    def add(row,i,j,k,l,c):
        if i==j or k==l: return
        s=1.0
        if i>j: i,j,s=j,i,-s
        if k>l: k,l,s=l,k,-s
        a,b=idx[(i,j)],idx[(k,l)]
        key=(a,b) if (a,b) in coord else ((b,a) if (b,a) in coord else None)
        if key is None: return
        row[coord[key]]+=c*s
    rows=[]
    if use_bianchi:
        for quad in combinations(range(n),4):
            i,j,k,l=quad; row=np.zeros(D0)
            add(row,i,j,k,l,1.); add(row,i,k,l,j,1.); add(row,i,l,j,k,1.)
            if np.abs(row).max()>0: rows.append(row)
    if use_ricci:
        for i in range(n):
            for k in range(i,n):
                row=np.zeros(D0)
                for j in range(n): add(row,i,j,k,j,1.)
                if np.abs(row).max()>0: rows.append(row)
    if rows:
        C=np.array(rows); u,s,vt=np.linalg.svd(C)
        rank=int((s>1e-9*s[0]).sum()); ns=vt[rank:]
    else:
        ns=np.eye(D0)
    inv={v:k for k,v in coord.items()}
    B=[]
    for v in ns:
        M=np.zeros((N,N))
        for t in range(D0):
            a,b=inv[t]; M[a,b]+=v[t]; M[b,a]+=v[t]
        B.append(M/np.linalg.norm(M))
    return np.array(B)

rng=np.random.default_rng(41)
print(f"{'(p,q)':>7} {'conditions':>22} {'dim':>6} {'max ||sb(Ip,V)+V/2||/||V||':>28} {'best c':>9}")
for (p,q) in [(3,4),(4,4),(4,5),(5,5)]:
    n=p+q; A=struct(n); Ip=I_block(n,0,p)
    for tag,bb,rr in [("support only",0,0),("support+Bianchi",1,0),
                      ("support+Ricci",0,1),("support+Bianchi+Ricci",1,1)]:
        B=supp_basis(p,q,bb,rr); d=len(B)
        w=0.0; cs=[]
        for t in range(6):
            if d==0: break
            c=rng.normal(size=d); V=np.tensordot(c,B,axes=1); V/=np.linalg.norm(V)
            Y=sharp_bilin(A,Ip,V); w=max(w,np.linalg.norm(Y+0.5*V)); cs.append(np.tensordot(Y,V))
        print(f"{str((p,q)):>7} {tag:>22} {d:6d} {w:28.3e} {np.mean(cs) if cs else 0:9.5f}")
