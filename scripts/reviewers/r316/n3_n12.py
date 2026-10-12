"""Ascents on the graded slice at n=12, matrix-free (shifted power + line-searched gradient)."""
import sys, time
sys.path.insert(0,'scripts/reviewers/r316')
import numpy as np, core
from scipy.sparse.linalg import LinearOperator, eigsh

class SliceFree:
    def __init__(self, n, a):
        self.alg=core.Alg(n); self.n=n; self.a=a
        self.pr=core.ProjFast(self.alg)
        self.sg=core.grading_involution(self.alg,a)
        self.Weq=core.sphere_product_weyl(self.alg,a)
    def PV(self,M):
        M=self.pr.apply(M); return 0.5*(M+self.sg*M)
    def P(self,W): return float(np.sum(W*self.alg.Q(W)))

def shifted_power(sl,W,c=4.0,iters=800,tol=1e-13):
    P=sl.P(W)
    for it in range(iters):
        G=sl.PV(sl.alg.Q(W))
        th=float(np.sum(G*W)); r=np.linalg.norm(G-th*W)
        Wn=G+c*W; Wn/=np.linalg.norm(Wn)
        Pn=sl.P(Wn)
        if Pn<P-1e-13:
            c*=2.0; continue
        W,P=Wn,Pn
        if r<tol: break
    return W,P,r

def lam_max_slice(sl,W,k=6):
    alg=sl.alg; sh=core.Sharp(alg,W); sg=sl.sg
    QW=alg.Q(W); PQ=sl.pr.apply(QW); th=float(np.sum(PQ*W))
    res=float(np.linalg.norm(PQ-th*W))
    def op(v):
        H=v.reshape(alg.N,alg.N); H=0.5*(H+H.T)
        H=sl.PV(H); H=H-np.sum(H*W)*W
        Y=sl.PV(sh.L(H)); Y=Y-np.sum(Y*W)*W
        return Y.reshape(-1)
    D=alg.N*alg.N
    w=eigsh(LinearOperator((D,D),matvec=op,dtype=float),k=k,which='LA',
            return_eigenvectors=False,tol=1e-10,maxiter=20000)
    return th,res,float(np.sort(w)[-1]/th)

if __name__=='__main__':
    n=int(sys.argv[1]); a=int(sys.argv[2]); nt=int(sys.argv[3]); seed=int(sys.argv[4])
    sl=SliceFree(n,a); rng=np.random.default_rng(seed)
    th_eq=sl.P(sl.Weq)
    print(f"n={n} pair ({a},{n-a}) theta_eq={th_eq:.9f}",flush=True)
    res={}
    t0=time.time()
    for t in range(nt):
        M=rng.normal(size=(sl.alg.N,sl.alg.N)); M=M+M.T
        W=sl.PV(M); W/=np.linalg.norm(W)
        W,P,r=shifted_power(sl,W)
        th,rf,lm=lam_max_slice(sl,W)
        key=round(th,7); res.setdefault(key,[0,lm,rf]); res[key][0]+=1
        print(f"  trial {t+1}: theta={th:.9f} fullcrit={rf:.1e} lam_max(slice)={lm:.9f} "
              f"({time.time()-t0:.0f}s)",flush=True)
    print("\nDISTINCT theta:",flush=True)
    for k in sorted(res,reverse=True):
        print(f"  {k:.9f}  count={res[k][0]} lam_max={res[k][1]:.9f}")
    print(f"max found {max(res):.9f} vs theta_eq {th_eq:.9f}")
