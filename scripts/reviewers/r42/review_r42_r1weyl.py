import numpy as np, sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *
for m in range(2,11):
    n=2*m
    Pm,Ps,Po = P_mm(n),P_su(n),P_omega(n)
    out=[]
    for P in (Pm,Ps,Po):
        R=ricci(n,P)
        rho=np.trace(R)/n
        dev=np.abs(R-rho*np.eye(n)).max()
        A=alt(n,P)
        out.append((rho,dev,A))
    # express alt coefficients relative to alt(P_omega)
    ref=out[2][2]; nref=np.sqrt(np.sum(ref*ref))
    coefs=[np.sum(o[2]*ref)/ (nref**2) if nref>1e-12 else 0.0 for o in out]
    res=[np.abs(o[2]-c*ref).max() for o,c in zip(out,coefs)]
    print(f"m={m:2d} ric scalars: Pm={out[0][0]:+.8f}({F(out[0][0]).limit_denominator(10**6)}) "
          f"Psu={out[1][0]:+.8f}({F(out[1][0]).limit_denominator(10**6)}) Po={out[2][0]:+.8f}({F(out[2][0]).limit_denominator(10**6)}) "
          f"| dev={max(o[1] for o in out):.1e} | alt coefs vs alt(Po): "
          f"{coefs[0]:+.6f}({F(coefs[0]).limit_denominator(10**6)}) {coefs[1]:+.6f}({F(coefs[1]).limit_denominator(10**6)}) {coefs[2]:+.6f} "
          f"res={max(res):.1e} |alt(Po)|={nref:.4f}")
