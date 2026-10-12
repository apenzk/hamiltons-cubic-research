"""Reviewer 39, phase 5: pin down the index formula for sharp_bilin, then use it."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, time
import numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r39_core import struct, nullspace, weyl_rows, all_vars, support_vars, block_of
from review_r39_e12 import log, setup, Iproj, Tmat, intify, run

def tensor4(M, pr, n):
    """N x N operator matrix -> full 4-tensor R_{ijkl} = <M phi_ij, phi_kl>."""
    N=len(pr); idx={p:a for a,p in enumerate(pr)}
    R=np.zeros((n,n,n,n))
    for i in range(n):
        for j in range(n):
            if i==j: continue
            a=idx[(min(i,j),max(i,j))]; s1=1 if i<j else -1
            for k in range(n):
                for l in range(n):
                    if k==l: continue
                    b=idx[(min(k,l),max(k,l))]; s2=1 if k<l else -1
                    R[i,j,k,l]=s1*s2*M[a,b]
    return R

def frommat4(R, pr):
    return np.array([[R[i,j,k,l] for (k,l) in pr] for (i,j) in pr])

if __name__=='__main__':
    log('PHASE 5 START: identifying the index formula of sharp_bilin.')
    n=7; pr,idx,c=setup(n); N=len(pr)
    rng=np.random.default_rng(3)
    cols=all_vars(N); bi,ric=weyl_rows(n,idx,set(cols)); ns=nullspace(bi+ric,cols)
    def randweyl():
        M=np.zeros((N,N))
        for vec in ns:
            t=float(rng.integers(-3,4))
            if t:
                for (a,b),v in vec.items(): M[a,b]+=t*float(v); M[b,a]+= t*float(v) if a!=b else 0
        return M
    X=randweyl(); Y=randweyl()
    S=Tmat(np.tensordot(c.astype(float),X,axes=([2],[0])),c,Y)   # T_ab with I_p replaced by X
    S=-(S+S.T)/4.0
    RX=tensor4(X,pr,n); RY=tensor4(Y,pr,n)
    G=np.einsum('iakb,jalb->ijkl',RX,RY)-np.einsum('ialb,jakb->ijkl',RX,RY)
    Gs=(G-G.transpose(1,0,2,3))/2.0
    Gs=(Gs+Gs.transpose(2,3,0,1))/2.0
    Gm=frommat4(Gs,pr)
    for lab,cand in [('G/1',frommat4(G,pr)),('Gsym',Gm),('Gsym/2',Gm/2),('-Gsym/2',-Gm/2),
                     ('Gsym/4',Gm/4)]:
        num=np.abs(S-cand).max(); log(f'   candidate {lab:8s}: max|sharp_bilin - cand| = {num:.6f}   '
                                      f'ratio med = {np.median(cand[np.abs(S)>1e-9]/S[np.abs(S)>1e-9]):.6f}')
