"""Reviewer 39, phase 4: attack E2.

(a) NEGATIVE CONTROLS  - the check must be able to fail.
(b) INDEPENDENT rank certificate for the nullspace (mod a large prime, numpy),
    plus direct re-verification that every claimed basis vector really is Weyl
    and really is supported in the (PP,MX) block.
(c) ABLATIONS - drop Bianchi, drop Ricci, drop both.
(d) The exact -1/2 eigenspace: is S(p,q) the WHOLE set of V in the support block
    with sharp_bilin(I_p,V) = -V/2, or a proper subspace of it?
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, time, math, random
import numpy as np
from fractions import Fraction as F
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r39_core import (struct, nullspace, weyl_rows, all_vars, support_vars,
                             block_of, entry_accessor)
from review_r39_e12 import log, Xdim, setup, Iproj, Tmat, intify, run
from itertools import combinations

PRIME=(1<<31)-1

def rank_modp(rows, cols, pmod=PRIME):
    pos={c:i for i,c in enumerate(cols)}
    M=np.zeros((len(rows),len(cols)),dtype=np.int64)
    for r,row in enumerate(rows):
        for k,v in row.items(): M[r,pos[k]]=v%pmod
    rk=0
    for c in range(len(cols)):
        piv=None
        for r in range(rk,M.shape[0]):
            if M[r,c]%pmod: piv=r;break
        if piv is None: continue
        M[[rk,piv]]=M[[piv,rk]]
        inv=pow(int(M[rk,c]),pmod-2,pmod)
        M[rk]=(M[rk]*inv)%pmod
        col=M[rk+1:,c].copy()
        nz=np.nonzero(col)[0]
        if len(nz):
            M[rk+1+nz]=(M[rk+1+nz]-np.outer(col[nz],M[rk]))%pmod
        rk+=1
        if rk==M.shape[0]: break
    return rk

def check_weyl_exact(n, idx, Vd):
    """Direct re-verification of Bianchi + Ricci on the dict Vd (var->value)."""
    get=entry_accessor(idx)
    def R(i,j,k,l):
        key,s=get(i,j,k,l)
        if key is None: return F(0)
        return s*Vd.get(key,F(0))
    for (a,b,d,e) in combinations(range(n),4):
        for perm in [(a,b,d,e),(b,a,d,e)]:
            i,j,k,l=perm
            if R(i,j,k,l)+R(i,k,l,j)+R(i,l,j,k)!=0: return False,'bianchi'
    for i in range(n):
        for k in range(n):
            if sum((R(i,j,k,j) for j in range(n)),F(0))!=0: return False,'ricci'
    return True,''

def ident_fails(p,q,V):
    n=p+q; pr,idx,c=setup(n); N=len(pr)
    B=np.tensordot(c.astype(float),Iproj(pr,p,N),axes=([2],[0]))
    T=Tmat(B,c,V)
    return int(np.count_nonzero(T+T.T-2*V)), np.abs(T+T.T-2*V).max()

def eigenspace_dim(p,q,cols):
    """dim { V supported on `cols` : T+T^T-2V = 0 on ALL entries }, exact."""
    n=p+q; pr,idx,c=setup(n); N=len(pr)
    B=np.tensordot(c.astype(float),Iproj(pr,p,N),axes=([2],[0]))
    rows={}
    for j,(a,b) in enumerate(cols):
        V=np.zeros((N,N)); V[a,b]=1.0; V[b,a]=1.0
        T=Tmat(B,c,V)
        D=T+T.T-2*V
        assert np.all(D==np.round(D))
        for (x,y) in zip(*np.nonzero(D)):
            rows.setdefault((int(x),int(y)),{})[(a,b)]=int(D[x,y])
    rl=list(rows.values())
    return len(nullspace(rl,cols)), len(cols)-rank_modp(rl,cols), len(rl)

if __name__=='__main__':
    log('PHASE 4 START: negative controls, independent rank certificate, ablations, eigenspace.')
    random.seed(7); rng=np.random.default_rng(11)

    # ---- (a) negative controls -------------------------------------------------
    log('--- (a) NEGATIVE CONTROLS: the test must be capable of failing ---')
    for (p,q) in [(3,3),(4,4),(3,5),(5,3)]:
        n=p+q; pr,idx,c=setup(n); N=len(pr)
        cols=support_vars(pr,N,p)
        # random vector in the raw support block (generically NOT Weyl)
        V=np.zeros((N,N))
        for (a,b) in cols:
            v=float(rng.integers(-3,4)); V[a,b]=v; V[b,a]=v
        k,w=ident_fails(p,q,V)
        # also: a genuine Weyl basis vector with one entry corrupted
        r=run(p,q); vec=intify(r['ns'][0]); V2=np.zeros((N,N))
        for (a,b),v in vec.items(): V2[a,b]=v; V2[b,a]=v
        nz=int(np.count_nonzero(V2))
        a,b=cols[0]; V2[a,b]+=1; V2[b,a]+=1
        k2,w2=ident_fails(p,q,V2)
        log(f'  {str((p,q)):>7} random support vector: {k:5d} violated entries (max {w:.0f}); '
            f'corrupted Weyl vector: {k2:5d} violated (max {w2:.0f}); '
            f'basis vec 1 has {nz} nonzero entries (non-vacuous)')

    # ---- (b) independent rank certificate --------------------------------------
    log('--- (b) INDEPENDENT certificate: mod-p nullity (upper bound on rational '
        'nullity) vs exact basis size (lower bound); plus direct Weyl re-verification ---')
    for (p,q) in [(3,3),(3,4),(4,3),(4,4),(3,5),(5,3),(4,5),(5,5),(6,3),(6,4)]:
        n=p+q; pr,idx,c=setup(n); N=len(pr)
        cols=support_vars(pr,N,p)
        bi,ric=weyl_rows(n,idx,set(cols))
        rk=rank_modp(bi+ric,cols)
        nl=len(cols)-rk
        r=run(p,q)
        # direct re-verification of a sample of basis vectors (all, when cheap)
        sample=r['ns'] if len(r['ns'])<=60 else random.sample(r['ns'],60)
        okall=True; supp_ok=True
        colset=set(cols)
        for vec in sample:
            good,why=check_weyl_exact(n,idx,vec)
            okall&=good
            supp_ok&= all(k in colset for k in vec)
        # independence of the exact basis
        rk2=rank_modp([{k:int(v*  (lambda d: d)(1)) if v.denominator==1 else 0 for k,v in intify(vv).items()} for vv in r['ns']],cols)
        log(f'  {str((p,q)):>7} vars={len(cols):4d} rank_p={rk:4d} nullity_p={nl:4d} '
            f'exact basis={r["dim"]:4d} rank(basis)={rk2:4d}  match={nl==r["dim"]==rk2}  '
            f'Weyl re-verified={okall} support-confined={supp_ok} (n sampled={len(sample)})')

    # ---- (c) ablations ---------------------------------------------------------
    log('--- (c) ABLATIONS: which of Bianchi / Ricci is load-bearing ---')
    log(f"  {'(p,q)':>7} {'cond':>8} {'dim':>5} {'bad vecs':>8} {'bad entries':>11}")
    for (p,q) in [(3,3),(3,4),(4,3),(4,4),(3,5),(5,3),(4,4),(5,5)]:
        for cond in ('both','bianchi','ricci','none'):
            r=run(p,q,conds=cond)
            log(f"  {str((p,q)):>7} {cond:>8} {r['dim']:5d} {r['bad']:8d} {r['badents']:11d}")

    # ---- (d) the exact -1/2 eigenspace inside the support block ----------------
    log('--- (d) EIGENSPACE: dim { V in raw (PP,MX) block : sharp_bilin(I_p,V) = -V/2 } ---')
    log(f"  {'(p,q)':>7} {'block dim':>9} {'eig dim (exact)':>15} {'eig dim (mod p)':>15} {'X(p)q':>6} {'equal?':>7}")
    for (p,q) in [(3,3),(3,4),(4,3),(4,4),(3,5),(5,3),(4,5),(5,4),(5,5),(6,3),(6,4),(3,6)]:
        n=p+q; pr,idx,c=setup(n); N=len(pr)
        cols=support_vars(pr,N,p)
        de,dp,nr=eigenspace_dim(p,q,cols)
        log(f"  {str((p,q)):>7} {len(cols):9d} {de:15d} {dp:15d} {Xdim(p)*q:6d} "
            f"{str(de==dp==Xdim(p)*q):>7}")
    log('PHASE 4 COMPLETE')
