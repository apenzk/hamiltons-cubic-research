# Screen for L273 (reviews/2026-09-26-I73-class-ceiling.md, batch 52): J1, max of T + lambda_m g^2 over the unit root sphere
# (1/2)(|P|^2+|Q|^2) = 1, against lambda_m; and the cap lambda_m(1-g^2) against Psi_kappa(g) on [1/sqrt m, 1].
# Run with sage -python; 120 BFGS starts per m, about two minutes. A screen, never evidence for a positive claim.
import numpy as np
from scipy.optimize import minimize
def Psi(g,k):
    a2=(-1+np.sqrt(1+4*g*g/k/k))/2
    return k*np.sqrt(1+a2)*(1-2*a2)
for m in (4,5,6,8):
    c=2*(m-1); N=m*(2*m-1); k=c/np.sqrt(N); iu=np.triu_indices(m,1); K=len(iu[0])
    Tu=np.sqrt(2)*(m-2)/np.sqrt(m*(m-1)); lam=Tu/(1-1/m)
    def unpack(z):
        P=np.zeros((m,m)); P[iu]=z[:K]; P=P+P.T; Q=np.zeros((m,m)); Q[iu]=z[K:]; Q=Q+Q.T
        b2=0.5*(np.sum(P*P)+np.sum(Q*Q)); return P/np.sqrt(b2), Q/np.sqrt(b2)
    def TG(z):
        P,Q=unpack(z); d=0.5*(P**2+Q**2).sum(1); g2=np.sum(d**2)+np.sum((P*Q)**2)
        return 0.5*(np.trace(P@P@P)+np.trace(Q@Q@Q)), g2
    obj=lambda z: -(TG(z)[0]+lam*TG(z)[1])
    rng=np.random.default_rng(3); best=-9; bz=None
    for t in range(120):
        r=minimize(obj,rng.normal(size=2*K),method='BFGS',options={'gtol':1e-10})
        if -r.fun>best: best=-r.fun; bz=r.x
    T,g2=TG(bz)
    gs=np.linspace(1/np.sqrt(m),1,400); cap=Tu*(1-gs**2)/(1-1/m); ps=Psi(gs,k)
    print(f"m{m}: max(T + lam g^2) = {best:.6f} vs lam = {lam:.6f} (cap holds iff <=) at T={T:.4f}, g^2={g2:.4f} | cap - Psi max on [1/sqrt m,1]: {np.max(cap-ps):.4f}")
