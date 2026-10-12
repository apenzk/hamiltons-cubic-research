"""Reviewer 39, phases 2-3: E1 (dim S(p,q)) and E2 (sharp_bilin(I_p,V) = -V/2).

Everything integer-exact.  Writing T_ab = tr(A_a I_p A_b V), the claim
  sharp_bilin(I_p,V) = -V/2  <=>  -1/4 (T_ab+T_ba) = -1/2 V_ab
                              <=>  T_ab + T_ba = 2 V_ab   for ALL a,b.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, time, math
import numpy as np
from fractions import Fraction as F
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r39_core import (pair_list, struct, nullspace, weyl_rows, all_vars,
                             support_vars, block_of, to_matrix)

LOG=_os.path.join(_ROOT, 'agent_logs/review_r39_exact.log')
def log(m):
    with open(LOG,'a') as f:
        f.write(time.strftime('%Y-%m-%dT%H:%M:%SZ',time.gmtime())+'  '+m+'\n')
    print(m,flush=True)

def Xdim(m): return m*(m*m-4)//3

_cache={}
def setup(n):
    if n not in _cache: _cache[n]=struct(n)
    return _cache[n]

def Iproj(pr,p,N):
    blk=block_of(pr,p)
    return np.diag([1.0 if blk(a)=='PP' else 0.0 for a in range(N)])

def Tmat(B, A, V):
    """T_ab = tr(A_a I_p A_b V) with B[a] = A_a I_p precomputed."""
    N=V.shape[0]
    C=np.tensordot(A.astype(float),V,axes=([2],[0]))     # C[b,m,n]=(A_b V)_{mn}
    return B.reshape(N,N*N) @ C.transpose(0,2,1).reshape(N,N*N).T

def intify(vec):
    d=1
    for v in vec.values(): d=d*v.denominator//math.gcd(d,v.denominator)
    return {k:int(v*d) for k,v in vec.items()}

def run(p,q,conds='both',verbose=True):
    n=p+q; pr,idx,c=setup(n); N=len(pr)
    cols=support_vars(pr,N,p)
    bi,ric=weyl_rows(n,idx,set(cols))
    rows = bi+ric if conds=='both' else bi if conds=='bianchi' else ric if conds=='ricci' else []
    ns=nullspace(rows,cols)
    A=c
    Ip=Iproj(pr,p,N)
    B=np.tensordot(A.astype(float),Ip,axes=([2],[0]))
    bad=0; badents=0; worst=0.0; maxT=0.0
    for vec in ns:
        iv=intify(vec)
        V=np.zeros((N,N))
        for (a,b),v in iv.items(): V[a,b]=v; V[b,a]=v
        T=Tmat(B,A,V)
        D=T+T.T-2*V
        maxT=max(maxT,np.abs(T).max())
        assert np.all(T==np.round(T)) and np.abs(T).max()<2**40
        k=int(np.count_nonzero(D))
        if k: bad+=1; badents+=k; worst=max(worst,np.abs(D).max())
    return dict(n=n,dim=len(ns),pred=Xdim(p)*q,nvars=len(cols),bad=bad,
                badents=badents,worst=worst,maxT=maxT,ns=ns,N=N)

if __name__=='__main__':
    splits=[(3,3),(3,4),(4,3),(4,4),(3,5),(5,3),(4,5),(5,4),(5,5),(3,6),(6,3),
            (6,4),(4,6),(3,7),(7,3),(5,6),(6,5),(4,7),(7,4),(6,6),(3,8),(8,3),(5,7),(7,5)]
    log('PHASE 2/3 START: E1 dim + E2 exhaustive off-support check, ALL N^2 entries.')
    log(f"{'(p,q)':>8} {'n':>3} {'#supp vars':>10} {'dim S':>6} {'X(p)q':>6} {'E1':>4} "
        f"{'bad vecs':>8} {'bad entries':>11} {'E2':>4}")
    for (p,q) in splits:
        t0=time.time()
        r=run(p,q)
        e1='OK' if r['dim']==r['pred'] else 'FAIL'
        e2='OK' if r['bad']==0 else 'FAIL'
        log(f"{str((p,q)):>8} {r['n']:3d} {r['nvars']:10d} {r['dim']:6d} {r['pred']:6d} {e1:>4} "
            f"{r['bad']:8d} {r['badents']:11d} {e2:>4}   [{time.time()-t0:.1f}s, max|T|={r['maxT']:.0f}]")
