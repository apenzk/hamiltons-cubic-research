"""Multiplication table of the 3-dim U(m)-invariant algebra span{P_m,P_su,P_omega}."""
import numpy as np, sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *

def blocks(n, S):
    Pm, Ps, Po = P_mm(n), P_su(n), P_omega(n)
    out=[]
    for P in (Pm,Ps,Po):
        t=np.trace(P); out.append(np.sum(S*P)/t)
    rec = out[0]*Pm+out[1]*Ps+out[2]*Po
    return out, np.abs(rec-S).max()

names = ['sb(I,I)','sb(I,U)','sb(I,Om)','sb(U,U)','sb(U,Om)','sb(Om,Om)']
data = {k:[] for k in names}
ms = list(range(2,11))
for m in ms:
    n=2*m; N=len(pairs(n)); I=np.eye(N); U=P_u(n); Om=P_omega(n)
    for nm,(X,Y) in zip(names,[(I,I),(I,U),(I,Om),(U,U),(U,Om),(Om,Om)]):
        S=sb(n,X,Y); b,err=blocks(n,S)
        data[nm].append((m,b,err))
for nm in names:
    print(nm)
    for m,b,err in data[nm]:
        fr=[F(x).limit_denominator(10**6) for x in b]
        print(f"   m={m:2d} err={err:.1e}  m-part={b[0]:+.8f}={fr[0]}  su={b[1]:+.8f}={fr[1]}  om={b[2]:+.8f}={fr[2]}")
