"""C1c: are the P_i annihilated by the raising operators -- genuine HIGHEST-weight
covariants?  Tested by differentiating the EVALUATED polynomial along a complex
root vector of so(5), which never touches the cache's own raising matrices.
F_p[i] is split into its two idempotent components (i -> +256 and i -> -256), so
all linear algebra happens over the field F_p.  The multiplicity-factor variant
is run through the same test as a control."""
import sys, os, numpy as np
d=os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0,d); sys.path.insert(0,os.path.join(d,"..","r179"))
import core, weyl_invariants as WI
p=core.P

PAIRS=[(a,b) for a in range(5) for b in range(a+1,5)]
def Apq(a,b):
    M=np.zeros((5,5),dtype=np.int64); M[a,b]=1; M[b,a]=p-1; return M
BAS=[Apq(*pr) for pr in PAIRS]

def root_vector(a1,a2,ii):
    """X in so(5) (x) F_p with [i A_01, X]=a1 X, [i A_23, X]=a2 X, i -> ii."""
    H=[(ii*Apq(0,1))%p,(ii*Apq(2,3))%p]
    rows=[]
    for H_,w in zip(H,(a1,a2)):
        M=np.zeros((10,10),dtype=np.int64)
        for j,B in enumerate(BAS):
            R=(H_@B-B@H_)%p
            for k,(a,b) in enumerate(PAIRS): M[k,j]=R[a,b]%p
        rows.append((M-w*np.eye(10,dtype=np.int64))%p)
    A=np.concatenate(rows,axis=0)%p
    M=A.copy(); r=0; piv=[]
    for c in range(10):
        s=next((t for t in range(r,20) if M[t,c]),None)
        if s is None: continue
        M[[r,s]]=M[[s,r]]; M[r]=M[r]*pow(int(M[r,c]),p-2,p)%p
        for t in range(20):
            if t!=r and M[t,c]: M[t]=(M[t]-M[t,c]*M[r])%p
        piv.append(c); r+=1
    free=[c for c in range(10) if c not in piv]
    assert len(free)==1,(a1,a2,ii,free)
    f=free[0]; v=[0]*10; v[f]=1
    for i2,c in enumerate(piv): v[c]=(-M[i2,f])%p
    X=np.zeros((5,5),dtype=np.int64)
    for k,B in enumerate(BAS): X=(X+v[k]*B)%p
    return X

def act_inf(X,W):
    W=np.asarray(W,dtype=np.int64)%p; tot=np.zeros((5,5,5,5),dtype=np.int64)
    for sub in ('ia,ajkl->ijkl','jb,ibkl->ijkl','kc,ijcl->ijkl','ld,ijkd->ijkl'):
        tot=(tot+np.einsum(sub,X,W))%p
    return tot

MULT=[]
for t in core.MONO:
    a,b,c=t
    MULT.append(1 if a==b==c else (3 if (a==b or b==c or a==c) else 6))

for ii in (core.I_, (-core.I_)%p):
    WBc=(core.WBR + ii*core.WBI)%p          # weight basis in this split component
    om_of=lambda T: (np.einsum('aijkl,ijkl->a',WBc,np.asarray(T,dtype=np.int64)%p)%p)
    E=[root_vector(1,-1,ii),root_vector(0,1,ii)]
    for tag,factor in (("cache vectors as used",False),("multinomial factors 1/3/6",True)):
        bad=tot=0
        for seed in (7,11,13):
            W=WI.random_weyl(5,p,np.random.default_rng(seed))
            om=om_of(W)
            for X in E:
                dom=om_of(act_inf(X,W))
                for (lam,k) in core.COV:
                    u=core.HW2[lam][k]
                    tot+=1; s=0
                    for idx,c in u.items():
                        a,b,cc=core.MONO[idx]
                        cc_=(c[0]+ii*c[1])%p
                        if factor: cc_=cc_*MULT[idx]%p
                        s=(s+cc_*(dom[a]*om[b]%p*om[cc]+om[a]*dom[b]%p*om[cc]
                                  +om[a]*om[b]%p*dom[cc]))%p
                    if s%p: bad+=1
        print(f"  i={ii:>5}  {tag}: E_alpha . P_i = 0 in {tot-bad}/{tot} cases")
