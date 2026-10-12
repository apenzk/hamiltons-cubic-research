"""Reviewer 55: the three 'slack' normalisations at the C_5 blow-up, side by side."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k1 import c5_vertex

n=10; lam,_=c5_vertex([2]*5)
W=diag_operator(lam); W/=np.linalg.norm(W)
th=float(np.tensordot(W,Q(n,W)))
prs=pairs_of(n); ix=pidx(n); N=len(prs)

def ricci(X):
    R=np.zeros((n,n))
    def get(i,j,k,l):
        if i==j or k==l: return 0.0
        s=1.0
        if i>j: i,j,s=j,i,-s
        if k>l: k,l,s=l,k,-s
        return s*X[ix[(i,j)],ix[(k,l)]]
    for a in range(n):
        for b in range(n):
            R[a,b]=sum(get(a,m,b,m) for m in range(n))
    return R

def alt2(X):
    tot=0.0
    for (i,j,k,l) in itertools.combinations(range(n),4):
        def get(a,b,c,d):
            if a==b or c==d: return 0.0
            s=1.0
            if a>b: a,b,s=b,a,-s
            if c>d: c,d,s=d,c,-s
            return s*X[ix[(a,b)],ix[(c,d)]]
        tot+=(get(i,j,k,l)-get(i,k,j,l)+get(i,l,j,k))**2
    return tot/3.0

ev,V=np.linalg.eigh(W); neg=ev<0
Wm=(V[:,neg]*(-ev[neg]))@V[:,neg].T
d2=alt2(Wm)
ric=ricci(Wm)
S_theta=float((ric*ric).sum())+6*d2-th*float(np.trace(Wm))-float(np.trace(Wm@Wm))
S_struct=slack_struct(n,W)
from fractions import Fraction
print(f"C_5 blow-up n=10, theta={th:.9f}")
print(f"  structural slack  S = sum_{{a<b}} ||Pi_m [X_a,X_b]||^2  = {S_struct:.6e}   (= 3 x triangles = 0)")
print(f"  adjoint-rep helper (b_padded_s3s3.slack)                = {S_struct*(n-2)**2:.6e}")
print(f"  theta-identity slack (g1_second_order.slack)            = {S_theta:.9f}  ; 10/9 = {10/9:.9f}")
print(f"  |Alt(W_-)|^2 (delta^2) = {d2:.9f} ; ||Ric(W_-)||^2 = {float((ric*ric).sum()):.9f}")
print(f"  tr(W_-) = {np.trace(Wm):.9f} ; tr(W_-^2) = {np.trace(Wm@Wm):.9f}")
