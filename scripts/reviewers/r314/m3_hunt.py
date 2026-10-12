"""Hunt for a critical point with Delta>0 and lambda_max(L_e|W^perp) <= 1/2."""
import sys,os,time,json; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L, m3_lib as m3

def newton(n,x,B,Bf,iters=60):
    dim=B.shape[0]
    for it in range(iters):
        W=(x@Bf).reshape(B.shape[1],B.shape[1])
        Qm=L.Q(n,W); q=Bf@Qm.reshape(-1); th=float(x@q)
        F=q-th*x
        nf=np.linalg.norm(F)
        if nf<1e-14: break
        M=L.LW_matrix_on_weyl(n,W,B)
        J=2*M-th*np.eye(dim)-3*np.outer(x,q)
        Jx=np.vstack([J,x[None,:]]); Fx=np.concatenate([F,[0.0]])
        if not (np.isfinite(Jx).all() and np.isfinite(Fx).all()): return x,None,0.0,1e9
        try:
            h,*_=np.linalg.lstsq(Jx,-Fx,rcond=1e-10)
        except np.linalg.LinAlgError:
            u_,s_,vt_=np.linalg.svd(Jx,full_matrices=False)
            si=np.where(s_>1e-10*s_[0],1.0/np.maximum(s_,1e-300),0.0)
            h=-(vt_.T*si)@(u_.T@Fx)
        if not np.isfinite(h).all(): return x,None,0.0,1e9
        s=1.0
        if np.linalg.norm(h)>0.5: s=0.5/np.linalg.norm(h)
        x=x+s*h; x/=np.linalg.norm(x)
    W=(x@Bf).reshape(B.shape[1],B.shape[1])
    Qm=L.Q(n,W); th=float(np.sum(W*Qm)); res=float(np.abs(Qm-th*W).max())
    return x,W,th,res

if __name__=='__main__':
    n=int(sys.argv[1]); ntr=int(sys.argv[2]); seed=int(sys.argv[3])
    B=L.weyl_basis(n); dim=B.shape[0]; Bf=B.reshape(dim,-1)
    rng=np.random.default_rng(seed)
    best=[]; found=[]
    t0=time.time()
    for tr in range(ntr):
        x=rng.normal(size=dim); x/=np.linalg.norm(x)
        x,W,th,res=newton(n,x,B,Bf)
        if W is None: continue
        if res>1e-12 or th<=1e-6: continue
        D,lam,g=m3.Delta(n,W)
        ev,M=m3.lam_max(n,W,th,B)
        lm=ev[-1]
        found.append((th,D,lm,res))
        if D>1e-6:
            best.append(lm)
        if tr%25==0:
            print(f'[{time.time()-t0:7.1f}s] trial {tr}: n={n} kept={len(found)} minlam(D>0)={min(best) if best else float("nan"):.6f}',flush=True)
    found.sort(key=lambda z:z[2])
    print('n',n,'kept',len(found))
    for th,D,lm,res in found[:15]:
        print(f'   theta={th:.9f} Delta={D:.6f} lam_max={lm:.9f} res={res:.1e}  {"<=1/2 !!!" if lm<=0.5+1e-9 and D>1e-6 else ""}')
    print('MIN lam_max over Delta>0 :',min(best) if best else None)
