"""Reviewer 39, phase 7: (i) how big is the -1/2 eigenspace in ALL of Sym^2(Lambda^2)?
(ii) is S(p,q) really the O(p)xO(q) summand X_p (x) R^q -- invariant and irreducible?
(iii) does the general E1 rank formula rank = [C(p,3)+p]*q hold?
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, math
import numpy as np
from itertools import combinations
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r39_core import (struct, nullspace, weyl_rows, all_vars, support_vars,
                             block_of)
from review_r39_e12 import log, setup, Iproj, Tmat, intify, run, Xdim
from review_r39_attack import rank_modp

def full_eig(p,q):
    n=p+q; pr,idx,c=setup(n); N=len(pr)
    cols=all_vars(N)
    B=np.tensordot(c.astype(float),Iproj(pr,p,N),axes=([2],[0]))
    rows={}
    for (a,b) in cols:
        V=np.zeros((N,N)); V[a,b]=1.0; V[b,a]=1.0
        T=Tmat(B,c,V); D=T+T.T-2*V
        assert np.all(D==np.round(D))
        for (x,y) in zip(*np.nonzero(D)):
            rows.setdefault((int(x),int(y)),{})[(a,b)]=int(D[x,y])
    rl=list(rows.values())
    return len(cols)-rank_modp(rl,cols), len(cols)

def lam2(g,pr):
    N=len(pr); idx={x:a for a,x in enumerate(pr)}
    M=np.zeros((N,N))
    for b,(k,l) in enumerate(pr):
        for i in range(g.shape[0]):
            for j in range(g.shape[0]):
                if i==j: continue
                v=g[i,k]*g[j,l]
                if v==0: continue
                a=idx[(min(i,j),max(i,j))]; s=1 if i<j else -1
                M[a,b]+=0.5*s*v*2/2*2   # placeholder, fixed below
    return M

def lam2_exact(g,pr):
    """matrix of Lambda^2 g in the phi_ij basis: (Lg)_{(ab),(kl)} = g_ak g_bl - g_al g_bk."""
    N=len(pr)
    return np.array([[g[a,k]*g[b,l]-g[a,l]*g[b,k] for (k,l) in pr] for (a,b) in pr])

def orth_basis(vecs,N):
    cols=[]
    for vec in vecs:
        M=np.zeros((N,N))
        for (a,b),v in vec.items():
            M[a,b]+=float(v)
            if a!=b: M[b,a]+=float(v)
        cols.append(M.reshape(-1))
    Q,_=np.linalg.qr(np.array(cols).T)
    return Q   # (N*N, d)

def commutant_dim(p,q,gens):
    n=p+q; pr,idx,c=setup(n); N=len(pr)
    r=run(p,q); Q=orth_basis(r['ns'],N); d=Q.shape[1]
    reps=[]
    for g in gens:
        L=lam2_exact(g,pr)
        img=(L@ (Q.T.reshape(d,N,N)) @L.T).reshape(d,N*N)
        reps.append(img@Q)                    # d x d  (rows = images of basis vecs)
    # solve  sum over gens of  || rho X - X rho ||  = 0
    rows=[]
    for R in reps:
        R=R.T                                  # acting on coordinate column vectors
        rows.append(np.kron(np.eye(d),R)-np.kron(R.T,np.eye(d)))
    Mbig=np.vstack(rows)
    s=np.linalg.svd(Mbig,compute_uv=False)
    tol=max(Mbig.shape)*s[0]*1e-12
    return d*d-int((s>tol).sum()), d

def gens_of(p,q,seed=0):
    n=p+q; rng=np.random.default_rng(seed); out=[]
    for (lo,hi) in ((0,p),(p,n)):
        m=hi-lo
        if m>=2:
            A=rng.normal(size=(m,m)); A=A-A.T
            from scipy.linalg import expm
            g=np.eye(n); g[lo:hi,lo:hi]=expm(A); out.append(g)
        g=np.eye(n); g[lo,lo]=-1.0; out.append(g)          # reflection in each block
    return out

if __name__=='__main__':
    log('PHASE 7 START.')
    log('--- (i) -1/2 eigenspace of V -> sharp_bilin(I_p,V) in the FULL Sym^2(Lambda^2) ---')
    log(f"  {'(p,q)':>7} {'dim Sym^2':>10} {'dim eig(-1/2)':>14} {'dim S(p,q)':>11} {'extra':>6}")
    for (p,q) in [(3,3),(3,4),(4,3),(4,4),(3,5),(5,3)]:
        de,tot=full_eig(p,q)
        log(f"  {str((p,q)):>7} {tot:10d} {de:14d} {Xdim(p)*q:11d} {de-Xdim(p)*q:6d}")
    log('--- (ii) is S(p,q) the O(p)xO(q) summand?  invariance + commutant ---')
    for (p,q) in [(3,3),(3,4),(4,3),(4,4),(4,5),(5,3)]:
        try:
            cd,d=commutant_dim(p,q,gens_of(p,q))
            log(f"  {str((p,q)):>7} dim={d:4d}  dim Comm_(O(p)xO(q)) = {cd}  "
                f"-> {'irreducible, real type' if cd==1 else 'REDUCIBLE / not real type'}")
        except Exception as e:
            log(f"  {str((p,q)):>7} commutant failed: {e}")
    log('--- (iii) rank of the Weyl constraints on the block vs [C(p,3)+p]*q ---')
    for (p,q) in [(3,3),(3,4),(4,3),(4,4),(3,5),(5,3),(4,5),(5,5),(6,3),(6,4),(7,3),(3,7),(6,6)]:
        n=p+q; pr,idx,c=setup(n); N=len(pr)
        cols=support_vars(pr,N,p); bi,ric=weyl_rows(n,idx,set(cols))
        rk=rank_modp(bi+ric,cols)
        pred=(math.comb(p,3)+p)*q
        log(f"  {str((p,q)):>7} blockdim={len(cols):4d} rank={rk:4d} pred={pred:4d} "
            f"{'OK' if rk==pred else 'FAIL'}  nullity={len(cols)-rk} X(p)q={Xdim(p)*q}")
    log('PHASE 7 COMPLETE')
