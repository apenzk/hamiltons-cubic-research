import sys, time, numpy as np
SP='/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/9c01c4ed-757d-4406-8bef-25a9d1df3dd0/scratchpad'
sys.path.insert(0,SP); sys.path.insert(0, 'scripts/lib')
import r288_core as R
np.random.seed(288)

def coords(B,X): return np.einsum('aij,ij->a',B,X)

def analyse(name,n,W,check_c1=True,do_sup=True):
    t0=time.time()
    B,_=R.weyl_basis288(n); D=len(B)
    W=W/np.linalg.norm(W)
    # project W into the Weyl space (should be a no-op)
    wc=coords(B,W); Wp=np.einsum('a,aij->ij',wc,B)
    proj_err=np.linalg.norm(Wp-W)
    QW=R.Q(n,W); th=float(np.tensordot(W,QW)); res=np.linalg.norm(QW-th*W)
    # L_W on the Weyl basis
    LW=np.empty((D,D))
    for j,X in enumerate(B):
        LW[:,j]=coords(B,R.circ(n,W,X))
    asym=abs(LW-LW.T).max(); LW=0.5*(LW+LW.T)
    ev,U=np.linalg.eigh(LW)
    # A(1/2): eigenvalue th/2 AND perp W
    tol=1e-7*max(1.0,abs(th))
    sel=[k for k in range(D) if abs(ev[k]-th/2)<tol]
    half=np.array([U[:,k] for k in sel]) if sel else np.zeros((0,D))
    if len(half):
        # orthogonalise against W just in case
        half=half-np.outer(half@wc,wc)/(wc@wc)
        u,s,vt=np.linalg.svd(half,full_matrices=False)
        half=vt[s>1e-9*max(1,s[0])]
    # orbit tangent: [ad(phi_a), W]
    ad=R.adrep(n); orb=np.array([coords(B,a@W-W@a) for a in ad])
    u,s,vt=np.linalg.svd(orb,full_matrices=False)
    dorb=int((s>1e-9*s[0]).sum()) if s.size and s[0]>0 else 0
    orbv=vt[:dorb]
    # is orbit tangent inside A(1/2)?  check L_W(orb) = th/2 orb
    orbres=max([np.linalg.norm(LW@v-th/2*v) for v in orbv]) if dorb else 0.0
    print(f"\n=== {name} (n={n}) ===  dimWeyl={D}  proj_err={proj_err:.1e}  t={time.time()-t0:.0f}s")
    print(f"  theta={th:.9f}  crit residual={res:.2e}  eigval(W of L_W)={wc@LW@wc/(wc@wc):.9f}  LW asym={asym:.1e}")
    print(f"  eigenvalues of L_W near th/2: count={len(half)};  max eig={ev.max():.9f} vs theta={th:.9f}"
          f"  2nd largest={sorted(ev)[-2]:.9f}  th/2={th/2:.9f}")
    print(f"  L_W <= th/2 on W-perp ?  largest eig on W-perp = "
          f"{max(ev[k] for k in range(D) if abs(U[:,k]@wc)/np.linalg.norm(wc)<1e-6):.9f}")
    print(f"  dim A(1/2)={len(half)}   dim orbit tangent={dorb}   EXCESS={len(half)-dorb}   orbit-in-A(1/2) residual={orbres:.1e}")
    if dorb and len(half):
        # containment: project orbit onto A(1/2)
        cont=max(np.linalg.norm(v-half.T@(half@v)) for v in orbv)
        print(f"  max ||orb_v - Proj_A(1/2) orb_v|| = {cont:.2e}")
    return dict(B=B,D=D,W=W,th=th,LW=LW,wc=wc,half=half,orbv=orbv,ev=ev,n=n)

def c1_check(st,z=None,w=None):
    """Independent check of the C1 t^3,t^4 coefficients via multinomial expansion."""
    n,B,D,W,th=st['n'],st['B'],st['D'],st['W'],st['th']
    if z is None: z=st['half'][0]
    z=z/np.linalg.norm(z); Z=np.einsum('a,aij->ij',z,B)
    if w is None:
        w=np.random.randn(D); w-=(w@st['wc'])*st['wc']/(st['wc']@st['wc'])
    Wm=np.einsum('a,aij->ij',w,B)
    a0,a1,a2=W,Z,0.5*Wm
    T=lambda X,Y,ZZ: R.T3(n,X,Y,ZZ)
    p=[T(a0,a0,a0), 3*T(a0,a0,a1), 3*T(a0,a0,a2)+3*T(a0,a1,a1),
       6*T(a0,a1,a2)+T(a1,a1,a1), 3*T(a0,a2,a2)+3*T(a1,a1,a2)]
    ip=lambda X,Y: float(np.tensordot(X,Y))
    q=np.array([ip(a0,a0), 2*ip(a0,a1), ip(a1,a1)+2*ip(a0,a2), 2*ip(a1,a2), ip(a2,a2)])
    s=q.copy(); s[0]-=1.0
    ser=np.zeros(5); ser[0]=1.0; pw=np.zeros(5); pw[0]=1.0
    for cf in [-1.5,15/8,-35/16,315/128]:
        pw=np.convolve(pw,s)[:5]; ser+=cf*pw
    prod=np.convolve(np.array(p),ser)[:5]
    LWm=st['LW']
    pred4=0.75*(w@(LWm-th/2*np.eye(D))@w)+1.5*(coords(B,R.circ(n,Z,Z))@w)-3*th/8
    pred3=T(Z,Z,Z)
    print(f"  C1 check: [t^3] series={prod[3]:+.12f} formula={pred3:+.12f} diff={prod[3]-pred3:+.2e}")
    print(f"            [t^4] series={prod[4]:+.12f} formula={pred4:+.12f} diff={prod[4]-pred4:+.2e}")
    # w=0 geodesic
    p0=[T(a0,a0,a0),3*T(a0,a0,a1),3*T(a0,a1,a1),T(a1,a1,a1),0.0]
    q0=np.array([1.0,0.0,ip(a1,a1),0.0,0.0]); s0=q0.copy(); s0[0]-=1
    ser0=np.zeros(5); ser0[0]=1; pw=np.zeros(5); pw[0]=1
    for cf in [-1.5,15/8,-35/16,315/128]:
        pw=np.convolve(pw,s0)[:5]; ser0+=cf*pw
    g=np.convolve(np.array(p0),ser0)[:5]
    print(f"  C2 check: geodesic [t^4]={g[4]:+.12f}   -3th/8={-3*th/8:+.12f}   diff={g[4]+3*th/8:+.2e}"
          f"   [t^3]={g[3]:+.3e}")

def c4_identity(st):
    """B(X^2 W) = (XW) o (XW) for X in so(n), where B = th/2 - L_W on the full space."""
    n,W,th,B=st['n'],st['W'],st['th'],st['B']
    ad=R.adrep(n); worst=0.0; worst2=0.0
    for _ in range(6):
        X=sum(np.random.randn()*a for a in ad)
        z=X@W-W@X                     # X.W  (action on operators)
        X2W=X@z-z@X                   # X.(X.W)
        lhs=th/2*X2W-R.circ(n,W,X2W)
        rhs=R.circ(n,z,z)
        worst=max(worst,np.linalg.norm(lhs-rhs)/max(1e-12,np.linalg.norm(rhs)))
        worst2=max(worst2,np.linalg.norm(R.circ(n,W,z)-th/2*z)/max(1e-12,np.linalg.norm(z)))
    print(f"  C4 identity  ||B(X^2W)-(XW)o(XW)||/||.|| = {worst:.2e}   ||L_W(XW)-th/2 XW||/||.|| = {worst2:.2e}")

def sup_check(st,label,vecs,ntrial=400):
    """sup over span(vecs) of <b,B^+ b>, b = Pi(z o z)."""
    n,B,D,th,LW,wc=st['n'],st['B'],st['D'],st['th'],st['LW'],st['wc']
    half=st['half']
    K=np.eye(D)-np.outer(wc,wc)/(wc@wc)
    for v in half:
        u=K@v; nu=np.linalg.norm(u)
        if nu>1e-9: K-=np.outer(u,u)/nu**2
    Bop=K@(th/2*np.eye(D)-LW)@K
    ew,EV=np.linalg.eigh(Bop)
    keep=ew>1e-8*max(1,abs(ew).max())
    Bi=EV[:,keep]@np.diag(1/ew[keep])@EV[:,keep].T
    print(f"    [{label}] B restricted: min eig kept={ew[keep].min():.3e}, num neg eigs of Bop={(ew<-1e-8).sum()}")
    def val(a):
        Z=np.einsum('k,kij->ij',a,B)
        bb=K@coords(B,R.circ(n,Z,Z))
        leak=np.linalg.norm(coords(B,R.circ(n,Z,Z))@half.T) if len(half) else 0.0
        return float(bb@Bi@bb), leak
    best=-1; bleak=0
    cands=[v/np.linalg.norm(v) for v in vecs]+[ (lambda r: r/np.linalg.norm(r))(np.random.randn(len(vecs))@vecs) for _ in range(ntrial)]
    for a in cands:
        v,lk=val(a)
        if v>best: best=v
        bleak=max(bleak,lk)
    print(f"    [{label}] sup <b,B^+b> = {best:.9f}   theta/2 = {th/2:.9f}   "
          f"{'VIOLATED' if best>th/2+1e-6 else 'satisfied'}   max |<zoz,A(1/2)>| = {bleak:.2e}")
    return best

def LW_fast(n,B,W):
    """L[l,j] = T(W,B_j,B_l) = tr(W B_j B_l) - 1/2 sum_ab (B_l)_ab tr(A_a W A_b B_j)."""
    c=R.cstruct(n); N=c.shape[0]; D=len(B)
    G=c@W                                  # G[a] = A_a W
    Gf=G.reshape(N,N*N)
    Bf=B.reshape(D,N*N)
    L=np.empty((D,D))
    for j in range(D):
        K=c@B[j]                            # K[b] = A_b B_j
        H=Gf@K.transpose(0,2,1).reshape(N,N*N).T    # H[a,b] = tr(A_a W A_b B_j)
        M=W@B[j]                            # tr(W B_j B_l) = <(W B_j)^T, B_l> = <B_j W, B_l>
        col=Bf@M.T.reshape(-1) - 0.5*(Bf@H.reshape(-1))
        L[:,j]=col
    return 0.5*(L+L.T)
