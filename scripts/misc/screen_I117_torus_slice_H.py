# Screen for R47 (reviews/2026-09-26-I73-class-ceiling.md, batch 50): sup of F/||X||^3 over torus-invariant X in Sym^2 so(2m),
# F in L271 (1)'s (A, P, Q) coordinates. Control: at m = 4 the sup must reach Lambda^2_+'s 2/sqrt(3) > c/sqrt(N).
# Run with sage -python; 150 BFGS starts per m, about 90 s. A screen, never evidence for a positive claim.
import numpy as np
from scipy.optimize import minimize
# screen: sup of F/||.||^3 on the torus slice of so(2m), F from L271 (1); control at m=4 must reach Lambda^2_+'s 2/sqrt3
def make(m):
    iu=np.triu_indices(m,1); k=len(iu[0]); off=1-np.eye(m)
    def unpack(z):
        A=np.zeros((m,m)); A[np.diag_indices(m)]=z[:m]; T=np.zeros((m,m)); T[iu]=z[m:m+k]/np.sqrt(2); A=A+T+T.T
        P=np.zeros((m,m)); P[iu]=z[m+k:m+2*k]; P=P+P.T; Q=np.zeros((m,m)); Q[iu]=z[m+2*k:]; Q=Q+Q.T
        return A,P,Q
    def f(z):
        A,P,Q=unpack(z); d=0.5*((P**2+Q**2)*off).sum(1)
        F=3*np.sum(np.diag(A)*d)-3*np.sum(A*P*Q*off)+0.5*np.trace(P@P@P)+0.5*np.trace(Q@Q@Q)
        return -F/(z@z)**1.5
    return f, m+3*k
for m in (4,5,6):
    f,n=make(m); c=2*(m-1); N=m*(2*m-1); rng=np.random.default_rng(2); best=-1
    vals=[]
    for t in range(150):
        z0=rng.normal(size=n)
        r=minimize(f,z0,method='BFGS',options={'gtol':1e-10,'maxiter':4000})
        vals.append(-r.fun)
    vals=np.array(vals)
    print(f"m{m}: max {vals.max():.6f}  c/sqrtN {c/np.sqrt(N):.6f}  Lambda2+ {2/np.sqrt(3):.6f}  top values {np.round(np.sort(vals)[-5:],5)}")
