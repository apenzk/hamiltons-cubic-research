import sys,os,itertools; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L, m3_lib as m3
from m4_slack import slacks
n=8
proj,coords,fromc,B=L.weyl_proj_factory(n); dim=B.shape[0]
P=L.pairs(n)

def blocks(idxU):
    U=set(idxU)
    b={'pp1':[],'pp2':[],'m':[]}
    for a,(i,j) in enumerate(P):
        if i in U and j in U: b['pp1'].append(a)
        elif i not in U and j not in U: b['pp2'].append(a)
        else: b['m'].append(a)
    return b

def report(tag,W):
    th=float(np.sum(W*L.Q(n,W))); res=np.abs(L.Q(n,W)-th*W).max()
    print(f'--- {tag}: theta={th:.12f} res={res:.1e}')
    # find the best coordinate 3+5 split
    best=None
    for U in itertools.combinations(range(n),3):
        b=blocks(U); pidx=b['pp1']+b['pp2']; midx=b['m']
        cross=np.linalg.norm(W[np.ix_(pidx,midx)])
        if best is None or cross<best[0]: best=(cross,U,b)
    cross,U,b=best
    print(f'  best coordinate 3+5 split U={U}, ||W_[p,m]||={cross:.3e}')
    p1,p2,mm=b['pp1'],b['pp2'],b['m']
    A=W[np.ix_(p1+p2,p1+p2)]
    nA=float(np.sum(A*A))
    t1=float(np.trace(W[np.ix_(p1,p1)])); t2=float(np.trace(W[np.ix_(p2,p2)]))
    floor=t1*t1/len(p1)+t2*t2/len(p2)
    lam=np.linalg.eigvalsh(W); spec=float((lam[lam>1e-9]**2).sum())
    xb=float(np.sum(W[np.ix_(p1,p2)]**2))*2
    print(f'  ||A||^2 (p-block reading) = {nA:.6f}   spectral sum_+ lam^2 = {spec:.6f}')
    print(f'  block traces: so(3)={t1:.6f}  so(5)={t2:.6f}   CS floor = {floor:.6f}'
          f'   (so3 term {t1*t1/len(p1):.6f}, so5 term {t2*t2/len(p2):.6f})')
    print(f'  p-internal cross-block mass ||W_[p1,p2]||^2 (both halves) = {xb:.6f}')
    s=slacks(n,W); print(f"  S_mmm={s['Smmm']:.3e} S_mpp={s['Smpp']:.3e} dim p={s['dimp']} dim m={s['dimm']} dim z={s['dimz']}")
    D,_,_=m3.Delta(n,W); print(f'  Delta={D:.6f}')
    return th,U,b

def cross_test(tag,W,b,th):
    p1,p2=b['pp1'],b['pp2']
    H=np.zeros_like(W)
    H[np.ix_(p1,p2)]=W[np.ix_(p1,p2)]; H[np.ix_(p2,p1)]=W[np.ix_(p2,p1)]
    nh=np.linalg.norm(H)
    if nh<1e-12:
        print(f'  [{tag}] cross-block direction is ZERO (equivariant)'); return
    Hp=proj(H)
    outside=np.linalg.norm(H-Hp)/nh
    M=L.LW_matrix_on_weyl(n,W,B)/th
    c=coords(Hp); rq=float(c@M@c/(c@c))
    # raw (unprojected) Rayleigh quotient for comparison
    print(f'  [{tag}] cross-block: ||H||={nh:.6f}  fraction outside Weyl_n = {outside:.4f} ({100*outside:.1f}%)  repaired Rayleigh = {rq:.6f}')

def m6(tag,W,b,th,U):
    M=L.LW_matrix_on_weyl(n,W,B)/th
    Bf=B.reshape(dim,-1); w=Bf@W.reshape(-1); w/=np.linalg.norm(w)
    Pp=np.eye(dim)-np.outer(w,w)
    ev,evec=np.linalg.eigh(Pp@M@Pp)
    top=ev[-1]; mult=int((np.abs(ev-top)<1e-8).sum())
    print(f'  [{tag}] lambda_max={top:.9f} multiplicity={mult}')
    v=evec[:,-1]; H=fromc(v); H=H/np.linalg.norm(H)
    p1,p2,mm=b['pp1'],b['pp2'],b['m']
    pidx=p1+p2
    def m2(I,J): return float(np.sum(H[np.ix_(I,J)]**2))
    tot=float(np.sum(H*H))
    off = 2*m2(pidx,mm)
    print(f'    mass off p(+)m (the p x m block)        : {off:.6f}  ({100*off/tot:.4f}%)')
    print(f'    m x m                                   : {m2(mm,mm)/tot*100:.2f}%')
    print(f'    so(5) x so(5)                           : {m2(p2,p2)/tot*100:.2f}%')
    print(f'    cross so(3) x so(5)                     : {2*m2(p1,p2)/tot*100:.2f}%')
    print(f'    so(3) x so(3)                           : {m2(p1,p1)/tot*100:.2f}%')
    return ev

if __name__=='__main__':
    from m1_graded import sphere_product,theta_of
    Ws=sphere_product(n,3); t,r,Ws=theta_of(n,Ws)
    th,U,b=report('S^3 x S^5',Ws); cross_test('S3xS5',Ws,b,th); m6('S3xS5',Ws,b,th,U)
    for f in ['r305_n8_seed9015','r305_n8_seed9018','r305_n8_seed9033']:
        W=np.load('scripts/reviewers/r305/out/%s.npy'%f)
        Wp,thp,resp=m3.polish(n,W)
        th,U,b=report(f,Wp); cross_test(f,Wp,b,th); m6(f,Wp,b,th,U)
