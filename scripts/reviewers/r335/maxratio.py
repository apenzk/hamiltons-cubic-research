import sys; sys.path.insert(0,'scripts/reviewers/r335')
import numpy as np, w335 as w, cvxpy as cp
rng=np.random.default_rng(5)
for n in [5,6]:
    c=w.struct(n); N=c.shape[0]; B=np.array(w.weyl_basis(n)); d=len(B)
    x=cp.Variable(d)
    M=sum(x[i]*B[i] for i in range(d))
    v=cp.Parameter((N,N))
    prob=cp.Problem(cp.Maximize(cp.sum(cp.multiply(M,v))), [M+np.eye(N)>>0])
    best=0; bx=None
    for t in range(10):
        x0=rng.normal(size=d); W0=np.tensordot(x0,B,axes=1)
        lam,U=np.linalg.eigh(W0); vv=U[:,-1]
        r=0
        for it in range(30):
            v.value=np.outer(vv,vv); prob.solve(solver=cp.SCS, eps=1e-10, max_iters=100000)
            W=np.tensordot(x.value,B,axes=1); W=(W+W.T)/2
            lam,U=np.linalg.eigh(W); vv=U[:,-1]
            r=lam[-1]/abs(lam[0])
        print("   restart",t,"ratio %.6f"%r, flush=True)
        if r>best: best=r; bx=x.value.copy()
    W=np.tensordot(bx,B,axes=1); W=(W+W.T)/2; W/=np.sqrt((W*W).sum())
    lam=np.linalg.eigvalsh(W); Q=w.Qmap(W,c); th=float((W*Q).sum())
    print("n=%d  max lmax/|lmin| over Weyl_n = %.6f   (bound n-2 = %d)"%(n,lam[-1]/abs(lam[0]),n-2))
    print("   spectrum:",np.round(lam,5))
    print("   crit residual %.4f  theta %.5f"%(np.linalg.norm(Q-th*W),th), flush=True)
    np.save('scripts/reviewers/r335/maxratio_n%d.npy'%n, bx)
