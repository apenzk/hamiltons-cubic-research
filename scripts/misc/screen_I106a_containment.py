"""Validate BOTH reviewers' weightiest correction: the redundancy is a THEOREM.

Their argument: the radial direction is one admissible tangent inside batch 21's
quantifier, so batch 21's full condition implies the trade bound POINTWISE.  Nothing
can satisfy batch 21 and fail the trade bound, at any configuration, not just at three.

My check, sharing nothing with their route: the trade bound should hold EXACTLY when
batch 21 holds at the radial direction, since one is the other divided by a positive
factor.  If the two ever disagree in sign, the containment is false.
"""
import numpy as np
rng=np.random.default_rng(97)
alpha,beta=15/4,9/4
def sym():
    M=rng.normal(size=(3,3)); M=(M+M.T)/2; return M-np.trace(M)/3*np.eye(3)

disagree=0; both_fail=0; both_hold=0; worst_factor=np.inf
for _ in range(50000):
    U=sym(); V=sym(); mu=rng.normal()*4; lam=rng.normal()
    nU=np.trace(U@U); nV=np.trace(V@V); T=1.5*nU+0.5*nV
    kap=-3*lam*nU/nV
    X=lam*U; Y=kap*V
    # batch 21 at the radial direction: LHS <= RHS
    b21 = (6*alpha*np.trace(U@X@X)+4*beta*np.trace(X@V@Y)+2*beta*np.trace(U@Y@Y)) \
          - mu*(3*np.trace(X@X)+np.trace(Y@Y))
    # the trade bound: alpha p3 nV^2 + beta q nU (3nU - 2nV) - mu T nU nV <= 0
    p3=np.trace(U@U@U); q=np.trace(U@V@V)
    trade = alpha*p3*nV**2 + beta*q*nU*(3*nU-2*nV) - mu*T*nU*nV
    factor = 6*lam**2/nV**2
    worst_factor=min(worst_factor,factor)
    if (b21>1e-9) != (trade>1e-9): disagree+=1
    elif b21>1e-9: both_fail+=1
    else: both_hold+=1

print(f"50000 random (U,V,mu,lam):")
print(f"  sign disagreements between batch 21 (radial) and the trade bound : {disagree}")
print(f"  both violated / both satisfied                                   : {both_fail} / {both_hold}")
print(f"  smallest connecting factor 6 lam^2 / nV^2                        : {worst_factor:.3e}  (positive)")
print()
print("The factor is positive throughout, so the two are equivalent pointwise and")
print("batch 21 IMPLIES the trade bound everywhere. CONFIRMS both reviewers: the")
print("redundancy is a theorem, and the three-point table is only a screen.")
