"""Ascent inside the u(4)-graded slice at n=8, hunting a CRITICAL point that is
sign-graded (A) but admits no orthogonal grading involution (not (B))."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r318_lib as L, r318_spaces as S
np.random.seed(31805)
n=8; m=4
Pj,Psu,Pm,um,mm,jv=S.cp_blocks(m)
J=S.Jmat(m); AdJ=L.lam2(J,n)
wb=L.weyl_basis(n)
rows=np.array([(AdJ@B-B@AdJ).ravel() for B in wb]).T
s=np.linalg.svd(rows, compute_uv=False); rank=int((s>1e-8*s.max()).sum())
ns=np.linalg.svd(rows)[2][rank:]
V=np.array([sum(c*B for c,B in zip(r,wb)) for r in ns])
Vf=V.reshape(len(V),-1)
def to_V(W): return Vf@W.ravel()
def from_V(x): return np.einsum('a,aij->ij', x, V)

def ascent(x, iters=4000, lr=0.05):
    x=x/np.linalg.norm(x)
    for it in range(iters):
        W=from_V(x); g=to_V(L.Q(W,n))
        g=g-np.dot(g,x)*x
        x=x+lr*g; x/=np.linalg.norm(x)
    return x

def newton(x, iters=60):
    d=len(x)
    for it in range(iters):
        W=from_V(x); QW=L.Q(W,n); th=float(np.sum(W*QW))
        F=to_V(QW)-th*x
        if np.linalg.norm(F)<1e-13: break
        Jc=np.zeros((d,d)); h=1e-6
        for k in range(d):
            xp=x.copy(); xp[k]+=h; xp/=np.linalg.norm(xp)
            Wp=from_V(xp); Qp=L.Q(Wp,n); tp=float(np.sum(Wp*Qp))
            Jc[:,k]=(to_V(Qp)-tp*xp-F)/h
        try: dx=np.linalg.lstsq(Jc,-F,rcond=None)[0]
        except Exception: break
        x=x+dx; x/=np.linalg.norm(x)
    return x

found=[]
for trial in range(30):
    x0=np.random.randn(len(V))
    x=ascent(x0)
    x=newton(x)
    W=from_V(x); W/=np.linalg.norm(W)
    th,r=L.theta_of(W,n)
    if r>1e-9: continue
    rep=L.grading_report(W,n)
    dlt=L.defect(W,n)
    key=(round(th,7), rep['dim_p'], rep['dim_m'], rep['dim_ker'], round(dlt,5))
    if key in [f[0] for f in found]: continue
    found.append((key,W,th,r,rep,dlt))
    print(f'trial {trial}: theta={th:.9f} resid={r:.1e} dims (+,-,0)=({rep["dim_p"]},{rep["dim_m"]},{rep["dim_ker"]}) '
          f'sign-graded={rep["sign_graded"]} Delta={dlt:.6f} dim k(W)={L.symmetry_algebra(W,n)[0].shape[1]}')
print(f'\n{len(found)} distinct critical points in the u(4) slice')
# for the sign-graded, non-equivariant ones: run the exhaustive involution test
c=L.C(n)
for key,W,th,r,rep,dlt in found:
    if not rep['sign_graded'] or dlt<1e-8: continue
    w,Vp=np.linalg.eigh(W); pos=Vp[:, w>1e-9]
    ev=w[w>1e-9]
    if len(ev)<2: continue
    gaps=np.diff(np.sort(ev))
    print(f'\n candidate theta={th:.9f} Delta={dlt:.6f}: dim E+={pos.shape[1]}, min gap in E+ = {gaps.min():.2e}')
    if gaps.min() < 1e-6:
        print('   E+ spectrum is degenerate -> the finite sign-pattern test does not apply directly'); continue
    cc=np.einsum('abg,ai,bj,gk->ijk',c,pos,pos,pos)
    d=pos.shape[1]; bad=np.abs(cc)>1e-6
    good=[]
    for mask in range(1<<d):
        eps=np.array([1.0 if (mask>>t)&1 else -1.0 for t in range(d)])
        if np.all(np.einsum('i,j,k->ijk',eps,eps,eps)[bad]>0): good.append(mask)
    print(f'   sign patterns on E+ that are Lie automorphisms: {len(good)}  -> {"only identity" if good==[(1<<d)-1] else good[:5]}')
    np.save(os.path.join(os.path.dirname(os.path.abspath(__file__)),f'crit_A_not_B_th{th:.6f}.npy'), W)
