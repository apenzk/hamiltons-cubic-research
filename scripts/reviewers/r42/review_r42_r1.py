import numpy as np, sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *

def exact_e(m):
    a = F(-1, 2*m-1); b = F(m-2, (m+1)*(2*m-1)); c = F(2*(m-1), 2*m-1)
    return a, b, c

print("m |  |e|^2 target 3m(m-1)/((m+1)(2m-1))  |  measured |e|^2 | Q(e)-e | alt | ric")
for m in range(3, 10):
    n = 2*m
    a, b, c = exact_e(m)
    E = float(a)*P_mm(n) + float(b)*P_su(n) + float(c)*P_omega(n)
    tgt = F(3*m*(m-1), (m+1)*(2*m-1))
    nrm = np.sum(E*E)
    Qe = Qop(n, E)
    print(f"{m}: target {float(tgt):.10f}  meas {nrm:.10f}  |Q(e)-e|={np.abs(Qe-E).max():.2e}"
          f"  alt={np.abs(alt(n,E)).max():.2e}  ric={np.abs(ricci(n,E)).max():.2e}")
