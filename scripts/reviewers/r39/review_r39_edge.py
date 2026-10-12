"""Reviewer 39, phase 8: dim( eig(-1/2) cap Weyl_n ), and edge cases p or q small."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, math
import numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r39_core import struct, nullspace, weyl_rows, all_vars, support_vars
from review_r39_e12 import log, setup, Iproj, Tmat, intify, run, Xdim
from review_r39_attack import rank_modp

def eig_cap_weyl(p,q):
    n=p+q; pr,idx,c=setup(n); N=len(pr)
    cols=all_vars(N)
    B=np.tensordot(c.astype(float),Iproj(pr,p,N),axes=([2],[0]))
    rows={}
    for (a,b) in cols:
        V=np.zeros((N,N)); V[a,b]=1.0; V[b,a]=1.0
        T=Tmat(B,c,V); D=T+T.T-2*V
        for (x,y) in zip(*np.nonzero(D)):
            rows.setdefault(('E',int(x),int(y)),{})[(a,b)]=int(D[x,y])
    bi,ric=weyl_rows(n,idx,set(cols))
    rl=list(rows.values())
    dW=len(cols)-rank_modp(bi+ric,cols)
    dE=len(cols)-rank_modp(rl,cols)
    dEW=len(cols)-rank_modp(rl+bi+ric,cols)
    return dW,dE,dEW

if __name__=='__main__':
    log('PHASE 8 START: is the identity true on more of Weyl_n than the summand?')
    log(f"  {'(p,q)':>7} {'dim Weyl_n':>10} {'dim eig(-1/2)':>13} {'dim intersection':>16} {'X(p)q':>6}")
    for (p,q) in [(3,3),(3,4),(4,3),(4,4),(3,5),(5,3)]:
        dW,dE,dEW=eig_cap_weyl(p,q)
        log(f"  {str((p,q)):>7} {dW:10d} {dE:13d} {dEW:16d} {Xdim(p)*q:6d}"
            f"   {'summand is EXACTLY the -1/2 eigenspace inside Weyl_n' if dEW==Xdim(p)*q else 'LARGER than the summand'}")
    log('--- edge cases: small p or q (proof should be uniform in p>=1, q>=1) ---')
    log(f"  {'(p,q)':>7} {'blockdim':>8} {'dim S':>6} {'X(p)q':>6} {'E1':>4} {'bad vecs':>8} {'E2':>4}")
    for (p,q) in [(2,3),(3,1),(4,1),(5,1),(3,2),(4,2),(2,4),(6,1),(2,2),(6,2),(7,1)]:
        try:
            r=run(p,q)
            log(f"  {str((p,q)):>7} {r['nvars']:8d} {r['dim']:6d} {Xdim(p)*q:6d} "
                f"{'OK' if r['dim']==Xdim(p)*q else 'FAIL':>4} {r['bad']:8d} {'OK' if r['bad']==0 else 'FAIL':>4}")
        except Exception as e:
            log(f"  {str((p,q)):>7} error {e}")
    log('PHASE 8 COMPLETE')
