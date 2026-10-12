"""Does the NORM-TRADE (radial) specialisation of batch 21 exclude any surviving point?

The bound, derived by hand and checked against batch 21 at 5e-11:

    mu  >=  [ alpha p3 n_V^2 + beta q n_U (3 n_U - 2 n_V) ] / (T n_U n_V)

Tested at the THREE non-commuting critical points that clear batch 18, batch 21 and
batch 33's orbit bound together.  Reconstruction reused from the record's own
screen_I106_value_survivors.py rather than rebuilt.

CONTROLS.  (i) ||[A,C]|| at each point: a point whose fields do not commute is not a
critical point of the block problem and its row means nothing.  (ii) the bound must be
BREACHABLE, or it is vacuous rather than strong.
"""
import sys, numpy as np
sys.path.insert(0,'scripts/misc')
from screen_I106_value_survivors import critical_point, AF, BF, br

def radial_bound(U, V):
    nU=np.trace(U@U); nV=np.trace(V@V)
    T=1.5*nU+0.5*nV
    p3=np.trace(U@U@U); q=np.trace(U@V@V)
    return (AF*p3*nV**2 + BF*q*nU*(3*nU-2*nV))/(T*nU*nV)

SURV=[(1,-3,11.60060,"(1,-3,2)"),(-1,-3,24.43870,"(-1,-3,4)"),(19,-20,762.38453,"(19,-20,1)")]
print(f"{'spectrum':<12} {'mu':>14} {'radial needs':>16} {'margin':>14}  verdict   ||[A,C]||")
for u1,u2,mu,tag in SURV:
    out=critical_point(u1,u2,mu)
    U,V=(out[0],out[1]) if isinstance(out,(tuple,list)) else (None,None)
    if U is None:
        print(f"{tag:<12} reconstruction returned {type(out)}; inspect"); continue
    A=(3*mu)*U-(3*AF)*(U@U)-BF*(V@V)
    C=mu*V-BF*(U@V+V@U)
    need=radial_bound(U,V)
    ok="CLEARS" if mu>=need-1e-9 else "EXCLUDED"
    print(f"{tag:<12} {mu:>14.5f} {need:>16.5f} {mu-need:>14.5f}  {ok:<9} {np.abs(br(A,C)).max():.2e}")

print()
print("CONTROL (ii): can the bound be breached at all?")
rng=np.random.default_rng(5); breached=0
def sym():
    M=rng.normal(size=(3,3)); M=(M+M.T)/2; return M-np.trace(M)/3*np.eye(3)
for _ in range(20000):
    U=sym(); V=sym(); mu=rng.normal()*5
    if mu < radial_bound(U,V)-1e-12: breached+=1
print(f"  {breached} of 20000 random (U,V,mu) violate it, so it is not vacuous")
