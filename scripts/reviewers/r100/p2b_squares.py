import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *
rng = np.random.default_rng(2002)
print("=== CLAIM 1 consequence: are the two 'squares' PSD after pr? ===")
for n in [5,6,8]:
    B = weyl_basis(n)
    lo1=[];lo2=[]
    for _ in range(30):
        M,_ = random_weyl(n,B,rng); W=full_tensor(M,n); A=Wring(W,n)
        S1,_ = project_weyl(M@M, B, n)
        S2,_ = project_weyl(iota_star(A@A,n), B, n)
        lo1.append(np.linalg.eigvalsh(S1).min()); lo2.append(np.linalg.eigvalsh(S2).min())
    print(f"n={n}: min eig pr(W^2)  over 30 samples: worst {min(lo1):+.4f}, #negative {sum(1 for x in lo1 if x<-1e-9)}/30")
    print(f"      min eig pr(iota*(Wring^2)):        worst {min(lo2):+.4f}, #negative {sum(1 for x in lo2 if x<-1e-9)}/30")
    # also: is the *unprojected* difference already = M^# ? (it is not, by P2)
    # and check <pr(W^2),W> and <pr(iota*),W> signs
    s1=[];s2=[]
    for _ in range(30):
        M,_ = random_weyl(n,B,rng); W=full_tensor(M,n); A=Wring(W,n)
        s1.append(np.trace(M@M@M)); s2.append(np.trace(A@A@A))
    print(f"      p3(mu) range [{min(s1):+.4f},{max(s1):+.4f}]  p3(omega) range [{min(s2):+.4f},{max(s2):+.4f}] -> both signs, no positivity inherited")
