"""K2 continued: the Sym_0 spectrum at the C_5 blow-up, and the same test at other blow-ups."""
import numpy as np, sys, itertools
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from blowlib import blowup

def D_A(A, idx):
    N=len(idx); D=np.zeros((N,N)); pos={p:k for k,p in enumerate(idx)}
    for b,(i,j) in enumerate(idx):
        for p in range(A.shape[0]):
            if p!=j and abs(A[p,i])>0:
                a,s=(pos[(p,j)],1.0) if p<j else (pos[(j,p)],-1.0); D[a,b]+=s*A[p,i]
            if p!=i and abs(A[p,j])>0:
                a,s=(pos[(i,p)],1.0) if i<p else (pos[(p,i)],-1.0); D[a,b]+=s*A[p,j]
    return D

def analyse(name, edges, sizes):
    got=blowup(edges,sizes)
    if got is None:
        print(f"{name}: NO critical block-constant point"); return
    M,th=got; n=M.shape[0]
    idx,pos,N,c,B=weyl_basis(n)
    W=diag_to_operator(M,pos); thF=P(c,W)
    coefW=np.array([inner(b,W) for b in B]); coefW/=np.linalg.norm(coefW)
    Lm=L_operator(c,B,W)/thF; Ls=0.5*(Lm+Lm.T)
    lmax,_=lam_max_perp(Lm,coefW)
    Bmat=np.array([b.reshape(-1) for b in B])
    off=np.cumsum([0]+list(sizes)); blocks=[list(range(off[i],off[i+1])) for i in range(len(sizes))]
    def fam(pairs):
        G=[]
        for (a,bb) in pairs:
            A=np.zeros((n,n)); A[a,bb]=1; A[bb,a]=1
            HA=D_A(A,idx)@W+W@D_A(A,idx)
            G.append(Bmat@HA.reshape(-1))
        return np.array(G)
    ep=[(a,bb) for (b1,b2) in sorted(edges) for a in blocks[b1] for bb in blocks[b2]]
    G=fam(ep)
    if np.linalg.norm(G)<1e-12:
        print(f"{name}: n={n} theta={th:.6f} edge family is ZERO"); return
    u,s,vt=np.linalg.svd(G); r=int((s>1e-9*s[0]).sum()); V=vt[:r]
    Cmp=V@Ls@V.T; evc=np.linalg.eigvalsh(Cmp)
    Rop=Ls@V.T-V.T@Cmp
    evg=np.linalg.eigvalsh(Rop.T@Rop)
    # full Sym_0 family
    S0=[]
    for i in range(n):
        for j in range(i,n):
            A=np.zeros((n,n))
            if i==j: A[i,i]=1
            else: A[i,j]=A[j,i]=1
            S0.append(A)
    A0=np.eye(n)
    GS=[]
    for A in S0:
        A=A-np.trace(A)/n*A0
        if np.abs(A).max()<1e-12: continue
        HA=D_A(A,idx)@W+W@D_A(A,idx); GS.append(Bmat@HA.reshape(-1))
    GS=np.array(GS); u2,s2,vt2=np.linalg.svd(GS); r2=int((s2>1e-9*s2[0]).sum()); V2=vt2[:r2]
    ev2=np.linalg.eigvalsh(V2@Ls@V2.T)
    print(f"{name}: n={n} theta={th:.9f} Delta={Delta(c,W):.4f} lam_max={lmax:.9f}")
    print(f"   edge family dim={r}  compression eigs (uniq) {sorted(set(np.round(evc,9)))}  "
          f"const? {np.allclose(evc,evc[0],atol=1e-9)}")
    print(f"   residual^2 eigs (uniq) {sorted(set(np.round(evg,9)))} const? {np.allclose(evg,evg[0],atol=1e-9)} "
          f"||r||={np.sqrt(evg[0]):.9f}")
    print(f"   Sym_0 family dim={r2} compression spectrum (uniq, with mult) "
          f"{[(v,int(np.sum(np.abs(ev2-v)<1e-8))) for v in sorted(set(np.round(ev2,6)))]}")

C5=set([(0,1),(1,2),(2,3),(3,4),(0,4)])
analyse("C_5 blow-up k=2 (n=10)", C5, [2]*5)
analyse("C_5 itself k=1 (n=5)", C5, [1]*5)
C7=set([(i,(i+1)%7) for i in range(7)]); C7={(min(a,b),max(a,b)) for a,b in C7}
analyse("C_7 k=1 (n=7)", C7, [1]*7)
C9=set([(min(i,(i+1)%9),max(i,(i+1)%9)) for i in range(9)])
analyse("C_9 k=1 (n=9)", C9, [1]*9)
K4=set(itertools.combinations(range(4),2))
analyse("K_4 blow-up k=2 (n=8)", K4, [2]*4)
K5=set(itertools.combinations(range(5),2))
analyse("K_5 blow-up k=2 (n=10)", K5, [2]*5)
analyse("C_5 blow-up k=1,1,1,1,2 (n=6)", C5, [1,1,1,1,2])
