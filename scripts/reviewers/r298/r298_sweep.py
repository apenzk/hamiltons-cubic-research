"""F3(d): the decisive sweep.  Solve criticality from many random starts and ask for a
critical point with Delta > 0 that SATISFIES the second-order bound lambda_max <= 1/2.
Such a point refutes "Delta > 0 => the second-order condition fails" outright."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r298')
import r298_core as C
from scipy.optimize import least_squares

def sharp_bil(n, X, Y):
    A = C.ad(n)
    MX = np.einsum('agb,bh->agh', A, X); MY = np.einsum('agb,bh->agh', A, Y)
    T = np.einsum('amn,bnm->ab', MX, MY)
    return -0.25*(T+T.T)

def solver(n, basis):
    def unpack(c): return np.einsum('a,aij->ij', c, basis)
    def resid(c):
        W=unpack(c); QW=C.Qf(n,W); th=float(np.sum(QW*W))
        return np.append(np.einsum('aij,ij->a',basis,QW-th*W), float(c@c)-1.0)
    def jac(c):
        W=unpack(c); QW=C.Qf(n,W); th=float(np.sum(QW*W))
        DQ=np.array([W@B+B@W+2.0*sharp_bil(n,W,B) for B in basis])
        M=np.einsum('aij,bij->ab',basis,DQ)
        gq=np.einsum('ij,bij->b',QW,basis); Bw=np.einsum('aij,ij->a',basis,W)
        return np.vstack([M-3.0*np.outer(Bw,gq)-th*np.eye(len(c)), 2.0*c])
    return resid, jac, unpack

def graded_basis(n, p):
    """Weyl_n operators commuting with Lambda^2(diag(I_p,-I_q)): block-diagonal on k+m."""
    P=C.pairs(n); sg=np.array([1.0 if (j<p)==(i<p) else -1.0 for (i,j) in P])
    B=C.weyl_basis(n)
    Bp=np.array([0.5*(X+np.outer(sg,sg)*X) for X in B])
    F=Bp.reshape(len(Bp),-1); u,s,vt=np.linalg.svd(F,full_matrices=False)
    r=int((s>1e-9*s[0]).sum())
    return vt[:r].reshape(r,B.shape[1],B.shape[2])

def audit(n, W, WB):
    W=W/np.linalg.norm(W); th=float(np.sum(W*C.Qf(n,W)))
    lam=np.linalg.eigvalsh(W); D,tot,_=C.Delta(n,W)
    out=np.array([C.circ_f(n,W,X) for X in WB])/th
    M=np.einsum('kij,lij->kl',out,WB); M=0.5*(M+M.T)
    w=np.einsum('kij,ij->k',WB,W)
    Pm=np.eye(len(WB))-np.outer(w,w)/(w@w)
    u,s,vt=np.linalg.svd(Pm); E=vt[:len(WB)-1]
    ev=np.linalg.eigvalsh(0.5*(E@M@E.T+(E@M@E.T).T))
    return th, D, ev[-1], int((lam<-1e-9).sum()), int((abs(lam)<=1e-9).sum()), ev

def sweep(n, basis, WB, nstarts, seed, lbl):
    resid,jac,unpack=solver(n,basis)
    rng=np.random.default_rng(seed); rows=[]
    for t in range(nstarts):
        c=rng.normal(size=basis.shape[0]); c/=np.linalg.norm(c)
        try:
            s=least_squares(resid,c,jac=jac,xtol=1e-14,ftol=1e-14,gtol=1e-14,max_nfev=300)
        except Exception as e:
            print(f'    start {t}: solver failed ({e})', flush=True); continue
        if np.abs(s.fun).max()>1e-10:
            print(f"    start {t}: no convergence", flush=True); continue
        W=unpack(s.x); W=W/np.linalg.norm(W)
        full=np.linalg.norm(C.project_weyl(n,C.Qf(n,W))-float(np.sum(W*C.Qf(n,W)))*W)
        if full>1e-9: continue
        th,D,lmax,dm,kk,ev=audit(n,W,WB)
        rows.append((th,D,lmax,dm,kk))
        print(f"    start {t}: theta={th:+.6f} Delta={D:9.5f} dim m={dm:3d} ker={kk:3d} lmax={lmax:+.8f}", flush=True)
    print(f"\n--- {lbl}: {len(rows)} converged critical points of {nstarts} starts ---")
    pos=[r for r in rows if r[0]>1e-9]
    dpos=[r for r in pos if r[1]>1e-7]
    print(f"    theta>0: {len(pos)}   of those Delta>0: {len(dpos)}")
    if dpos:
        lm=np.array([r[2] for r in dpos])
        print(f"    among Delta>0, theta>0:  min lambda_max = {lm.min():.8f}"
              f"   max = {lm.max():.6f}   #(lambda_max <= 0.5+1e-9) = {int((lm<=0.5+1e-9).sum())}")
        srt=sorted(dpos,key=lambda r:r[2])[:6]
        for th,D,lmax,dm,kk in srt:
            print(f"      theta={th:+.6f} Delta={D:9.5f} dim m={dm:3d} ker={kk:3d} lambda_max={lmax:+.8f}")
    dz=[r for r in pos if r[1]<=1e-7]
    if dz:
        lm=np.array([r[2] for r in dz])
        print(f"    among Delta=0, theta>0:  min lambda_max = {lm.min():.8f}  max = {lm.max():.6f}"
              f"   #(<=1/2) = {int((lm<=0.5+1e-9).sum())} of {len(dz)}")
    return rows

if __name__=='__main__':
    n=6; WB6=C.weyl_basis(6); sweep(6,WB6,WB6,int(sys.argv[1]) if len(sys.argv)>1 else 40,17,"full Weyl_6")
    WB8=C.weyl_basis(8)
    for p in (3,4):
        gb=graded_basis(8,p)
        print(f"\n[graded block-diagonal space over so({p})+so({8-p}) at n=8: dim {gb.shape[0]}]")
        sweep(8,gb,WB8,int(sys.argv[2]) if len(sys.argv)>2 else 30,23,f"n=8 graded so({p})+so({8-p})")
