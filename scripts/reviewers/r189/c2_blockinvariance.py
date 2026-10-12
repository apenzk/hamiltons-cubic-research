"""C2: the corrected structural story.  For each block lambda, compute the
DIMENSION of the space of Hermitian G on that block for which
sum_ij G_ij P_i conj(P_j) is SO(5)-invariant.  The record claims: only the
trivial block carries any."""
import sys, os, numpy as np
d=os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0,d); sys.path.insert(0,os.path.join(d,"..","r179"))
import core, weyl_invariants as WI
p=core.P

def rank_modp(M):
    M=np.array(M,dtype=np.int64)%p
    if M.size==0: return 0
    rows,cols=M.shape; r=0
    for c in range(cols):
        piv=next((t for t in range(r,rows) if M[t,c]),None)
        if piv is None: continue
        M[[r,piv]]=M[[piv,r]]
        M[r]=M[r]*pow(int(M[r,c]),p-2,p)%p
        nz=np.nonzero(M[:,c])[0]; nz=nz[nz!=r]
        if len(nz): M[nz]=(M[nz]-np.outer(M[nz,c],M[r]))%p
        r+=1
        if r==rows: break
    return r

gs=[core.cayley_so5(np.random.default_rng(900+t)) for t in range(6)]
Ws=[WI.random_weyl(5,p,np.random.default_rng(500+t)) for t in range(8)]
pairs=[(W,core.act(g,W)) for W in Ws for g in gs]
print(f"{len(pairs)} (W, gW) pairs")

def block_row(lam,W):
    om=core.omegas(W); pv=[core.Pval(u,om) for u in core.HW2[lam]]
    m=len(pv); row=[]
    for i in range(m):
        row.append(core.gmul(pv[i],core.gconj(pv[i]))[0]%p)
        for j in range(i+1,m):
            z=core.gmul(pv[i],core.gconj(pv[j]))
            row.append(2*z[0]%p); row.append((-2*z[1])%p)
    return row

print(f"{'block':>8} {'m':>2} {'unknowns':>8} {'invariant dim':>13}")
tot=0
for lam in core.BL:
    m=len(core.HW2[lam]); nu=m*m
    M=[[(a-b)%p for a,b in zip(block_row(lam,W),block_row(lam,Wg))] for W,Wg in pairs]
    dim=nu-rank_modp(M)
    tot+=dim
    print(f"{str(lam):>8} {m:>2} {nu:>8} {dim:>13}")
print(f"total invariant Hermitian dimension over all blocks: {tot} (of 89)")
