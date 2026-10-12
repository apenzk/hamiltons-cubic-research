import numpy as np, sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from review_r42_hw import *

def nu_of(m,name):
    z=np.zeros(m,int)
    if name=='V11;11':
        if m<4: return None
        z[0]+=1; z[1]+=1; z[m-2]-=1; z[m-1]-=1
    elif name=='su(m)':
        z[0]+=1; z[m-1]-=1
    elif name=='Lam2E':
        z[0]+=1; z[1]+=1
    elif name=='V21;1':
        if m<3: return None
        z[0]+=2; z[1]+=1; z[m-1]-=1
    elif name=='V2;2':
        z[0]+=2; z[m-1]-=2
    elif name=='V22;0':
        z[0]+=2; z[1]+=2
    return z

names=['Lam2E','su(m)','V11;11','V21;1','V2;2','V22;0']
for m in [3,4,5,6]:
    print(f"--- m={m} ---")
    for nm in names:
        nu=nu_of(m,nm)
        if nu is None: print(f"  {nm}: n/a"); continue
        out,dimw,khw,_=hw_vector(m,nu)
        if out is None:
            print(f"  {nm}: weight space dim {dimw}, hw-vectors {khw}  -> EMPTY")
            continue
        for lam,res,wl,nX in out:
            print(f"  {nm:8s} nu={list(nu)} wtdim={dimw} #hwv={khw}  lam={lam.real:+.12f}{lam.imag:+.1e}i "
                  f"res={res:.2e} weylerr={wl:.1e} |X|={nX:.3e}  ~ {F(lam.real).limit_denominator(2000)}")
