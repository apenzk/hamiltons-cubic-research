"""Reviewer 39, phase 9: Phi_p on the companion summand X_q (x) R^p, and a
p-sweep of Phi_p on the raw (PP,MX) block eigenvalues."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r39_core import struct, nullspace, weyl_rows, support_vars, block_of
from review_r39_e12 import log, setup, Iproj, Tmat, intify, Xdim

def companion(p,q):
    """S(q,p) = {V in Weyl_n : supp V in (QQ,MX)}; measure sharp_bilin(I_p, V)."""
    n=p+q; pr,idx,c=setup(n); N=len(pr); blk=block_of(pr,p)
    cols=[(a,b) for a in range(N) for b in range(a,N)
          if {blk(a),blk(b)}=={'QQ','MX'}]
    bi,ric=weyl_rows(n,idx,set(cols)); ns=nullspace(bi+ric,cols)
    B=np.tensordot(c.astype(float),Iproj(pr,p,N),axes=([2],[0]))
    worst0=0.0; worsthalf=0.0
    for vec in ns:
        iv=intify(vec); V=np.zeros((N,N))
        for (a,b),v in iv.items(): V[a,b]=v; V[b,a]=v
        T=Tmat(B,c,V); S=-(T+T.T)/4.0
        worst0=max(worst0,np.abs(S).max()); worsthalf=max(worsthalf,np.abs(S+V/2).max())
    return len(ns), Xdim(q)*p, worst0, worsthalf

if __name__=='__main__':
    log('PHASE 9: Phi_p := sharp_bilin(I_p,.) on the COMPANION summand X_q (x) R^p.')
    for (p,q) in [(3,3),(3,4),(4,3),(4,4),(3,5),(5,3),(4,5)]:
        d,pred,w0,wh=companion(p,q)
        log(f"  {str((p,q)):>7} dim S(q,p)={d:4d} (X(q)p={pred:4d})  "
            f"max|Phi_p(V)| = {w0:.1e}  max|Phi_p(V)+V/2| = {wh:.1e}  "
            f"-> Phi_p = {'0 there' if w0==0 else 'NOT 0'}")
    log('PHASE 9 COMPLETE')
