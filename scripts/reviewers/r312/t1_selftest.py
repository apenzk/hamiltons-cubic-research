import sys; sys.path.insert(0,'scripts/reviewers/r312')
import numpy as np, r312lib as L
np.set_printoptions(precision=10, suppress=True)

def sphere_product(a, p, q):
    """Weyl part of the Einstein product S^p x S^q, Ricci=rho, in Lambda^2 R^n."""
    n = a.n; assert p+q == n
    V1 = list(range(p)); V2 = list(range(p,n))
    w = np.zeros(a.N)
    for k,(i,j) in enumerate(a.pairs):
        if i<p and j<p: w[k] = 1.0/(p-1) - 1.0/(n-1)
        elif i>=p and j>=p: w[k] = 1.0/(q-1) - 1.0/(n-1)
        else: w[k] = -1.0/(n-1)
    return np.diag(w)   # rho = 1

for (p,q) in [(3,3),(3,4),(3,5),(4,4),(2,4),(4,5),(5,5),(5,7)]:
    n=p+q; a=L.Amb(n); W=sphere_product(a,p,q)
    print(f"--- S^{p} x S^{q}  n={n}")
    print("   in Weyl (rel resid):", a.in_weyl(W))
    nw2 = np.sum(W*W)
    pred = 0.5*(p/(p-1)+q/(q-1)-n/(n-1))     # rho=1
    print("   ||W||^2 =", nw2, " predicted", pred, " diff", abs(nw2-pred))
    Qw = a.Q(W); th = np.sum(Qw*W)/nw2
    print("   Q(W)-th W resid:", np.linalg.norm(Qw-th*W), " lambda(Q)=",th, " (rho=1 -> expect 1)")
    # unit-normalise
    U = W/np.sqrt(nw2); QU=a.Q(U); theta=np.sum(QU*U)
    print("   theta =", theta, " theta^2 =", theta**2, " 1/(4 theta^2) =", 1/(4*theta**2), " ||W_nat||^2=", nw2/4)
