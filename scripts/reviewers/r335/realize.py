"""Attempt to realize a prescribed spectrum as an actual Weyl tensor of W_n.
Two routes: (i) alternating projection between W_n and the isospectral orbit,
(ii) direct minimisation of ||Pi_perp(U Lam U^T)||^2 over O(N) by Riemannian gradient descent."""
import sys; sys.path.insert(0,'scripts/reviewers/r335')
import numpy as np, w335 as w
def run(lam,n,ntry=40,iters=4000,seed=0):
    B=np.array(w.weyl_basis(n)); N=len(lam)
    Bf=B.reshape(len(B),-1)
    def PiW(X): return (Bf.T@(Bf@X.reshape(-1))).reshape(N,N)
    lam=np.sort(lam); rng=np.random.default_rng(seed)
    best=(np.inf,None)
    for t in range(ntry):
        A=rng.normal(size=(N,N)); X=(A+A.T)/2
        for it in range(iters):
            ev,U=np.linalg.eigh(X)
            Y=(U*lam)@U.T           # project onto isospectral orbit
            X=PiW(Y); X=(X+X.T)/2   # project onto W_n
        ev,U=np.linalg.eigh(X); Y=(U*lam)@U.T
        dist=np.linalg.norm(PiW(Y)-Y)
        if dist<best[0]: best=(dist,Y.copy())
    return best
if __name__=="__main__":
    lam=np.load(sys.argv[1]); n=int(sys.argv[2])
    d,Y=run(lam,n,ntry=int(sys.argv[3]) if len(sys.argv)>3 else 20)
    print("spectrum:",np.round(np.sort(lam),6))
    print("best dist(orbit, W_n) = %.3e   (||lam||=%.4f)"%(d,np.linalg.norm(lam)))
    B=np.array(w.weyl_basis(n)); c=w.struct(n)
    W=w.proj_weyl(Y,B)
    print("realised? spec of Pi_W(Y):",np.round(np.sort(np.linalg.eigvalsh(W)),6))
    if d<1e-7:
        Wn=W/np.sqrt((W*W).sum()); Q=w.Qmap(Wn,c); th=float((Wn*Q).sum())
        print("REALIZED. theta at that Weyl tensor = %.6f  crit residual %.3e"%(th,np.linalg.norm(Q-th*Wn)))
