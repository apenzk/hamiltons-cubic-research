"""Biased hunt: perturb the lowest known lambda_max critical points and re-solve."""
import sys,os,time; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L, m3_lib as m3

def newton(n,x,B,Bf,iters=80):
    dim=B.shape[0]; N=B.shape[1]
    for it in range(iters):
        W=(x@Bf).reshape(N,N)
        Qm=L.Q(n,W); q=Bf@Qm.reshape(-1); th=float(x@q); F=q-th*x
        if np.linalg.norm(F)<1e-15: break
        M=L.LW_matrix_on_weyl(n,W,B)
        J=2*M-th*np.eye(dim)-3*np.outer(x,q)
        Jx=np.vstack([J,x[None,:]]); Fx=np.concatenate([F,[0.0]])
        if not np.isfinite(Jx).all(): return None
        try:
            u,s,vt=np.linalg.svd(Jx,full_matrices=False)
        except np.linalg.LinAlgError:
            return None
        si=np.where(s>1e-8*s[0],1.0/np.maximum(s,1e-300),0.0)
        h=-(vt.T*si)@(u.T@Fx)
        if not np.isfinite(h).all(): return None
        nh=np.linalg.norm(h)
        if nh>0.5: h*=0.5/nh
        x=x+h; x/=np.linalg.norm(x)
    W=(x@Bf).reshape(N,N); Qm=L.Q(n,W); th=float(np.sum(W*Qm))
    return x,W,th,float(np.abs(Qm-th*W).max())

if __name__=='__main__':
    n=int(sys.argv[1]); ntr=int(sys.argv[2]); seed=int(sys.argv[3])
    B=L.weyl_basis(n); dim=B.shape[0]; Bf=B.reshape(dim,-1)
    rng=np.random.default_rng(seed)
    pool=[]
    if n==8:
        for f in ['r305_n8_seed9018','r305_n8_seed9033','r305_n8_seed9015']:
            W=np.load('scripts/reviewers/r305/out/%s.npy'%f)
            pool.append(Bf@W.reshape(-1))
    best=[]; t0=time.time(); allpts=[]
    for tr in range(ntr):
        if pool and rng.random()<0.65:
            x0=pool[rng.integers(len(pool))].copy()
            d=rng.normal(size=dim); d/=np.linalg.norm(d)
            x0=x0+ (10**rng.uniform(-2,0.0))*d
        else:
            x0=rng.normal(size=dim)
        x0/=np.linalg.norm(x0)
        r=newton(n,x0,B,Bf)
        if r is None: continue
        x,W,th,res=r
        if res>1e-12 or th<=1e-6: continue
        D,lam,g=m3.Delta(n,W)
        ev,M=m3.lam_max(n,W,th,B)
        lm=ev[-1]
        allpts.append((lm,th,D,res))
        if D>1e-6:
            best.append((lm,th,D))
            if lm<0.60: pool.append(x.copy())
            if lm<0.5600:
                np.save(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                        'out_n%d_lam%.9f.npy'%(n,lm)), W)
        if tr%40==0:
            b=min(best)[0] if best else float('nan')
            print(f'[{time.time()-t0:7.1f}s] tr {tr} kept {len(allpts)} pool {len(pool)} min lam_max(D>0) = {b:.9f}',flush=True)
    best.sort()
    print('=== lowest 15 (Delta>0):')
    for lm,th,D in best[:15]:
        print(f'   lam_max={lm:.9f} theta={th:.9f} Delta={D:.6f}  {"VIOLATION<=1/2" if lm<=0.5+1e-9 else ""}')
    print('MIN =',best[0][0] if best else None)
