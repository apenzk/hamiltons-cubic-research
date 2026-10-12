import sys
sys.path.insert(0,'scripts/reviewers/r316')
import numpy as np, core
from n3_slice import Slice, ascend, certify

def newton_polish(sl, W, steps=60):
    """Project-and-normalise fixed point iteration on the slice, then a few Newton steps."""
    alg=sl.alg
    for _ in range(steps):
        G = sl.PV(alg.Q(W)); th=float(np.sum(G*W))
        r = G - th*W
        if np.linalg.norm(r) < 1e-14: break
        # Gauss-Newton on F(W)=PV(Q(W))-<W,Q(W)>W with |W|=1, using L
        sh=core.Sharp(alg,W)
        # build Jacobian on a basis of V
        d=sl.VB.shape[0]
        J=np.zeros((d,d))
        for i in range(d):
            H=sl.VB[i]
            dG = sl.PV(2.0*sh.L(H))
            dth = float(np.sum(dG*W)+np.sum(G*H))
            J[:,i] = (dG - dth*W - th*H).reshape(-1)@sl.VB.reshape(d,-1).T
        rv = r.reshape(-1)@sl.VB.reshape(d,-1).T
        # constrain to W-perp
        c = sl.VB.reshape(d,-1)@W.reshape(-1)
        Pp = np.eye(d)-np.outer(c,c)/(c@c)
        step,*_ = np.linalg.lstsq(Pp@J@Pp, -Pp@rv, rcond=None)
        step = Pp@step
        W = W + np.einsum('d,dij->ij', step, sl.VB)
        W = W/np.linalg.norm(W)
    return W

def kernel_rank(alg, W, tol=1e-8):
    """Frame-independent padding test: rank of the span of vectors appearing in ker W."""
    w,V=np.linalg.eigh(W)
    K=V[:,np.abs(w)<tol]
    # support: the subspace of R^n spanned by vectors moved by the NON-kernel bivectors
    R=V[:,np.abs(w)>=tol]
    n=alg.n
    supp=np.zeros((n,n))
    for c in range(R.shape[1]):
        B=np.zeros((n,n))
        for k,(i,j) in enumerate(alg.prs):
            B[i,j]+=R[k,c]; B[j,i]-=R[k,c]
        supp+= B@B.T
    ev=np.linalg.eigvalsh(supp)
    return int(np.sum(ev>tol*max(1,ev.max()))), K.shape[1]

if __name__=='__main__':
    n,a,ntrial,seed=8,3,60,7
    sl=Slice(n,a); sl.VB=sl.basisV()
    rng=np.random.default_rng(seed)
    found={}
    for t in range(ntrial):
        M=rng.normal(size=(sl.alg.N,sl.alg.N)); M=M+M.T
        W=sl.PV(M); W/=np.linalg.norm(W)
        W,P,gn=ascend(sl,W)
        W=newton_polish(sl,W)
        th,res,lmax,spec=certify(sl,W,sl.VB)
        key=round(th,7)
        if key not in found: found[key]=(W,th,res,lmax,spec)
    print(f"{len(found)} distinct theta")
    for key in sorted(found,reverse=True):
        W,th,res,lmax,spec=found[key]
        r,kd=kernel_rank(sl.alg,W)
        ev=np.round(np.linalg.eigvalsh(W),6)
        uniq=sorted(set(np.round(ev,6)),reverse=True)
        print(f"theta={th:.12f} fullcrit={res:.2e} lam_max(slice)={lmax:.12f} "
              f"support-dim={r} dim ker W={kd}\n   distinct eigs={uniq}")
        np.save(f'/tmp/r316_pt_{key:.7f}.npy', W)
