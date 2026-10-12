"""Refine the second 3+5 splitting and redo M5/M6 in BOTH gradings."""
import sys,os; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L, m3_lib as m3
from m4_slack import conj_lambda2
n=8; Pr=L.pairs(n)
proj,coords,fromc,B=L.weyl_proj_factory(n); dim=B.shape[0]

def frame_from_U(Q):
    u,s,vt=np.linalg.svd(Q,full_matrices=False); P=u@u.T
    e,V=np.linalg.eigh(P); g=np.hstack([V[:,-3:],V[:,:5]])
    if np.linalg.det(g)<0: g[:,-1]*=-1
    return g

def blocks3():
    U={0,1,2}; p1=[];p2=[];m=[]
    for a,(i,j) in enumerate(Pr):
        if i in U and j in U: p1.append(a)
        elif i not in U and j not in U: p2.append(a)
        else: m.append(a)
    return p1,p2,m
P1,P2,MM=blocks3()

def crossnorm(W,Q):
    g=frame_from_U(Q); R=conj_lambda2(n,g.T); Wr=R@W@R.T
    return np.linalg.norm(Wr[np.ix_(P1+P2,MM)]), Wr, g

def refine(W,Q,iters=4000,step0=0.05,seed=0):
    rng=np.random.default_rng(seed); x=Q.copy(); c0=crossnorm(W,x)[0]; step=step0
    for it in range(iters):
        y,_=np.linalg.qr(x+rng.normal(size=x.shape)*step)
        c1=crossnorm(W,y)[0]
        if c1<c0: x,c0=y,c1
        else: step*=0.998
        if step<1e-14: break
    return x,c0

def report(tag,W,Wr,g):
    A=Wr[np.ix_(P1+P2,P1+P2)]
    t1=float(np.trace(Wr[np.ix_(P1,P1)])); t2=float(np.trace(Wr[np.ix_(P2,P2)]))
    print(f'  [{tag}] cross={np.linalg.norm(Wr[np.ix_(P1+P2,MM)]):.2e}  ||A||^2={float(np.sum(A*A)):.9f}'
          f'  traces so(3)={t1:.6f} so(5)={t2:.6f}  CSfloor={t1*t1/3+t2*t2/10:.6f}')
    th=float(np.sum(Wr*L.Q(n,Wr)))
    Lm=L.LW_matrix_on_weyl(n,Wr,B)/th
    Bf=B.reshape(dim,-1); wv=Bf@Wr.reshape(-1); wv/=np.linalg.norm(wv)
    ev,evec=np.linalg.eigh((np.eye(dim)-np.outer(wv,wv))@Lm@(np.eye(dim)-np.outer(wv,wv)))
    H=fromc(evec[:,-1]); H/=np.linalg.norm(H); tot=float(np.sum(H*H))
    sh=lambda I,J,f=1: f*float(np.sum(H[np.ix_(I,J)]**2))/tot
    print(f'  [{tag}] lam_max={ev[-1]:.9f}  blocks: pxm={sh(P1+P2,MM,2):.4f}  mxm={sh(MM,MM):.4f}'
          f'  so5={sh(P2,P2):.4f}  cross={sh(P1,P2,2):.4f}  so3={sh(P1,P1):.4f}')
    # cross-block test direction
    Hc=np.zeros_like(Wr); Hc[np.ix_(P1,P2)]=Wr[np.ix_(P1,P2)]; Hc[np.ix_(P2,P1)]=Wr[np.ix_(P2,P1)]
    nh=np.linalg.norm(Hc)
    if nh>1e-10:
        Hp=proj(Hc); c=coords(Hp); c=c-(c@wv)*wv
        print(f'  [{tag}] cross-block dir: ||H||={nh:.6f} outside={np.linalg.norm(Hc-Hp)/nh:.4f} Rayleigh={float(c@Lm@c/(c@c)):.6f}')

if __name__=='__main__':
    from m1_graded import sphere_product, theta_of
    W15=np.load('scripts/reviewers/r305/out/r305_n8_seed9015.npy')
    W15,th,res=m3.polish(n,W15)
    lam,V=np.linalg.eigh(W15); ip=np.where(lam>1e-9)[0]
    A=L.so_mats(n); Cm=sum(np.einsum('a,aij->ij',V[:,i],A)@np.einsum('a,aij->ij',V[:,i],A).T for i in ip)
    e,U8=np.linalg.eigh(Cm)
    print('=== witness seed9015, theta=%.12f res=%.1e'%(th,res))
    g1=frame_from_U(U8[:,:3]); R=conj_lambda2(n,g1.T)
    report('G1 spectral',W15,R@W15@R.T,g1)
    rng=np.random.default_rng(5)
    best=None
    for t in range(25):
        Q,_=np.linalg.qr(rng.normal(size=(n,3)))
        Q,c=refine(W15,Q,seed=t)
        if np.abs(np.abs(np.linalg.svd(Q.T@U8[:,:3])[1]).prod()-1)<1e-6: continue   # same as G1
        if best is None or c<best[1]: best=(Q,c)
    Q,c=best
    Q,c=refine(W15,Q,iters=20000,step0=1e-3,seed=99)
    cc,Wr,g2=crossnorm(W15,Q)
    print('  second splitting found, cross-block=%.3e ; principal cosines vs G1: %s'%(cc,np.round(np.linalg.svd(Q.T@U8[:,:3])[1],4)))
    report('G2 second',W15,Wr,g2)
    # does S^3xS^5 admit a second one?
    Ws=sphere_product(n,3); t2,r2,Ws=theta_of(n,Ws)
    print('=== control S^3 x S^5')
    lo=[]
    for t in range(25):
        Q,_=np.linalg.qr(rng.normal(size=(n,3)))
        Q,c=refine(Ws,Q,seed=100+t); lo.append((c,Q))
    lo.sort(key=lambda z:z[0])
    print('  lowest cross-block norms over Gr(3,8):',[round(z[0],8) for z in lo[:6]])
    Q,c=refine(Ws,lo[0][1],iters=20000,step0=1e-3,seed=7)
    cc,Wr,g=crossnorm(Ws,Q)
    print('  best cross=%.3e'%cc)
    report('S3xS5 best',Ws,Wr,g)
