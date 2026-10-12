import sys, time, numpy as np
SP='/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/9c01c4ed-757d-4406-8bef-25a9d1df3dd0/scratchpad'
sys.path.insert(0,SP)
import r288_core as R, r288_run as X
np.random.seed(288)
coords=X.coords

def go(name,n,W):
    t0=time.time(); print(f"\n### {name} n={n} start",flush=True)
    B,_=R.weyl_basis288(n); D=len(B); print(f"  weyl dim {D} built in {time.time()-t0:.0f}s",flush=True)
    W=W/np.linalg.norm(W)
    QW=R.Q(n,W); th=float(np.tensordot(W,QW)); res=np.linalg.norm(QW-th*W)
    wc=coords(B,W); print(f"  theta={th:.9f} resid={res:.2e} projerr={np.linalg.norm(np.einsum('a,aij->ij',wc,B)-W):.1e}",flush=True)
    LW=X.LW_fast(n,B,W); print(f"  L_W built {time.time()-t0:.0f}s",flush=True)
    ev,U=np.linalg.eigh(LW)
    tol=1e-7*max(1.0,abs(th))
    sel=[k for k in range(D) if abs(ev[k]-th/2)<tol]
    half=np.array([U[:,k] for k in sel]) if sel else np.zeros((0,D))
    ad=R.adrep(n); orb=np.array([coords(B,a@W-W@a) for a in ad])
    u,s,vt=np.linalg.svd(orb,full_matrices=False); dorb=int((s>1e-9*s[0]).sum()); orbv=vt[:dorb]
    perpmax=max(ev[k] for k in range(D) if abs(U[:,k]@wc)/np.linalg.norm(wc)<1e-6)
    orbres=max(np.linalg.norm(LW@v-th/2*v) for v in orbv) if dorb else 0
    print(f"  dim A(1/2)={len(half)}  orbit={dorb}  EXCESS={len(half)-dorb}  maxeig on W-perp={perpmax:.9f} (th/2={th/2:.9f})  orb-in-A residual={orbres:.1e}",flush=True)
    st=dict(B=B,D=D,W=W,th=th,LW=LW,wc=wc,half=half,orbv=orbv,ev=ev,n=n)
    X.c1_check(st); X.c4_identity(st)
    def sig(a):
        Z=np.einsum('k,kij->ij',a/np.linalg.norm(a),B); return R.T3(n,Z,Z,Z)
    if len(half):
        print("  sup|T(z,z,z)| over A(1/2), 500 rand:",max(abs(sig(np.random.randn(len(half))@half)) for _ in range(500)),flush=True)
        X.sup_check(st,'A(1/2)',half,ntrial=200)
    print(f"  done {time.time()-t0:.0f}s",flush=True)

if __name__=='__main__':
    go('padded W_CP2',10,R.padded_cp2_288(10))
    go('S^6 x S^6',12,R.sphereprod([6,6]))
    go('S^5 x S^7',12,R.sphereprod([5,7]))
    go('padded W_CP2',12,R.padded_cp2_288(12))
