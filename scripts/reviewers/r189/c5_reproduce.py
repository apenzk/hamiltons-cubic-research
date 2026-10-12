"""C5: reproduce the 89/90 verdict from an independent pipeline (vectorised
omegas, different seeds, several point counts), and check the structural
one-liner that makes the rank measurement unnecessary."""
import sys, os, numpy as np
d=os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0,d); sys.path.insert(0,os.path.join(d,"..","r179"))
import core, weyl_invariants as WI
p=core.P
UNK=[]
for lam in core.BL:
    m=len(core.HW2[lam])
    for i in range(m):
        UNK.append((lam,i,i,'re'))
        for j in range(i+1,m): UNK.append((lam,i,j,'re')); UNK.append((lam,i,j,'im'))
print("block-diagonal Hermitian unknowns:",len(UNK))

def rank(M,ncols):
    M=np.array(M,dtype=np.int64)[:,:ncols]%p
    nr=M.shape[0]; r=0
    for c in range(ncols):
        nz=np.nonzero(M[r:,c])[0]
        if len(nz)==0: continue
        piv=r+nz[0]
        if piv!=r: M[[r,piv]]=M[[piv,r]]
        M[r]=M[r]*pow(int(M[r,c]),p-2,p)%p
        col=M[:,c].copy(); col[r]=0
        nzr=np.nonzero(col)[0]
        if len(nzr): M[nzr]=(M[nzr]-np.outer(col[nzr],M[r]))%p
        r+=1
        if r==nr: break
    return r

def build(npts,seed0):
    rows=[]
    for s in range(npts):
        W=WI.random_weyl(5,p,np.random.default_rng(seed0+s))
        om=core.omegas(W)
        pv={lam:[core.Pval(u,om) for u in core.HW2[lam]] for lam in core.BL}
        row=[]
        for (lam,i,j,part) in UNK:
            z=core.gmul(pv[lam][i],core.gconj(pv[lam][j]))
            if i==j: row.append(z[0]%p)
            elif part=='re': row.append(2*z[0]%p)
            else: row.append((-2*z[1])%p)
        row.append(core.F5(W)); rows.append(row)
    return rows

for npts,seed0 in ((100,100),(140,100),(140,777000),(200,31337)):
    R=build(npts,seed0)
    a=rank(R,len(UNK)); b=rank(R,len(UNK)+1)
    print(f"  {npts:>4} pts (seed {seed0:>6}): coefficient rank {a}, augmented {b}, consistent {a==b}")

# --- structural one-liner: the only invariant in reach is tr(W^3)^2 ---
print("\nstructural check: is F_5 a multiple of tr(W^3)^2?")
rows=[]
for s in range(8):
    W=WI.random_weyl(5,p,np.random.default_rng(4242+s))
    rows.append([pow(core.tr3(W),2,p), core.F5(W)])
r1=rank(rows,1); r2=rank(rows,2)
print(f"  rank[tr3^2] = {r1}, rank[tr3^2 | F_5] = {r2}  ->  F_5 in span: {r1==r2}")
q3=[[pow(core.qnorm(WI.random_weyl(5,p,np.random.default_rng(4242+s))),3,p)] for s in range(8)]
both=[[q3[s][0],rows[s][0],rows[s][1]] for s in range(8)]
print(f"  rank[q^3, tr3^2] = {rank(both,2)}, rank[q^3, tr3^2 | F_5] = {rank(both,3)}"
      f"  -> F_5 in span{{q^3,tr3^2}}: {rank(both,2)==rank(both,3)}")
