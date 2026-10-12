"""R54 step 1 hook screen, built on r1816's construction (scripts/reviewers/r1816_product_coupling_screen.py): splits the frame-allowed subspace V_e by L_e eigenvalue with the within-factor four-sets killed, reports max P on each piece, beta = the top eigenvalue of L_Z on the hooks over unit Z, and checks the reduced formula P(u) = d x^3 + 3 c_* x z^2 + p_+ z^3 + 3 beta y^2 z at a random point. Run: sage -python screen_I121_R54_hook_beta.py 4,4 5,5"""
"""r1816 screen: at the unit product Weyl tensor e of S^p x S^q in its own frame, the largest eigenvalue of L_e = Q(e,.) compressed to the subspace the maximal frame allows (B perp D, within-factor pair profiles zero, mixed pair profiles perp delta) versus c_*, and with only the orbit line removed. Run with sage -python."""
import numpy as np, itertools, sys
def run(p,q):
    n=p+q; P=list(range(p))
    pairs=list(itertools.combinations(range(n),2)); idx={pr:i for i,pr in enumerate(pairs)}; N=len(pairs)
    def mat(a,b):
        M=np.zeros((n,n)); M[a,b]=1; M[b,a]=-1; return M/np.sqrt(2)
    basis=[mat(a,b) for (a,b) in pairs]
    C=np.zeros((N,N,N))
    for i in range(N):
        for j in range(N):
            br=basis[i]@basis[j]-basis[j]@basis[i]
            for k in range(N): C[i,j,k]=np.sum(br*basis[k])
    def sharp(X,Y): return 0.5*np.einsum('ack,bdl,cd,kl->ab',C,C,X,Y,optimize=True)
    I=np.eye(N); scale=(n-2)/sharp(I,I)[0,0]
    def Qb(X,Y): return 0.5*(X@Y+Y@X)+scale*0.5*(sharp(X,Y)+sharp(Y,X))
    # W_n basis: symmetric N x N, Bianchi, Ricci-free
    def ent(R,a,b,c,d):
        s=1
        if a>b: a,b=b,a; s=-s
        if c>d: c,d=d,c; s=-s
        if a==b or c==d: return None
        return (s,idx[(a,b)],idx[(c,d)])
    sym=[]
    for i in range(N):
        for j in range(i,N):
            M=np.zeros((N,N)); M[i,j]=M[j,i]=1 if i!=j else 1; sym.append(M)
    cons=[]
    for a,b,c,d in itertools.combinations(range(n),4):
        row=np.zeros(len(sym))
        cons_ops=[(a,b,c,d),(b,c,a,d),(c,a,b,d)]
        # linear functional R -> R_abcd + R_bcad + R_cabd
        cons.append(cons_ops)
    def bianchi(R):
        out=[]
        for a,b,c,d in itertools.combinations(range(n),4):
            v=0
            for (x,y,z,w) in [(a,b,c,d),(b,c,a,d),(c,a,b,d)]:
                s,i,j=ent(R,x,y,z,w); v+=s*R[i,j]
            out.append(v)
        return out
    def ricci(R):
        out=[]
        for a in range(n):
            for b in range(a,n):
                v=0
                for k in range(n):
                    if k in (a,b): continue
                    s1=ent(R,a,k,b,k)
                    s,i,j=s1; v+=s*R[i,j]
                out.append(v)
        return out
    A=np.array([bianchi(M)+ricci(M) for M in sym]).T
    _,sv,vt=np.linalg.svd(A); rank=(sv>1e-9).sum(); null=vt[rank:]
    Wb=[sum(c*M for c,M in zip(v,sym)) for v in null]
    Wb=[M/np.linalg.norm(M) for M in Wb]
    G=np.array([M.ravel() for M in Wb]).T; Qo,_=np.linalg.qr(G)   # orthonormal basis of W_n in HS
    dimW=Qo.shape[1]; assert dimW==n*(n-3)*(n+1)*(n+2)//12, dimW
    # product e
    Nn=(n-1)*(n-2); al=q*(q-1)/Nn; be=-(p-1)*(q-1)/Nn; ga=p*(p-1)/Nn
    E=np.zeros((N,N))
    for (a,b),i in idx.items(): E[i,i]= al if (a in P and b in P) else (ga if (a not in P and b not in P) else be)
    e=E/np.linalg.norm(E); d=np.sum(Qb(e,e)*e)
    L=np.array([Qo.T@Qb(e,Qo[:,k].reshape(N,N)).ravel() for k in range(dimW)]).T; L=(L+L.T)/2
    cstar=d*(n-2)/(2*(p-1)*(q-1)); tauP=d*(p-2)/(2*(p-1)); tauQ=d*(q-2)/(2*(q-1))
    # constraint functionals on W (in Qo coordinates)
    rows=[]
    diag=[np.zeros((N,N)) for _ in range(N)]
    for i in range(N): diag[i][i,i]=1; rows.append(Qo.T@diag[i].ravel())   # B perp D
    orbit_rows=[]; plane_rows=[]
    for i,j in itertools.combinations(range(n),2):
        same=(i in P)==(j in P)
        prof=[]
        for k in range(n):
            if k in (i,j): continue
            s,a1,b1=ent(None,i,k,j,k); M=np.zeros((N,N)); M[a1,b1]+=s; M[b1,a1]+=s
            prof.append(Qo.T@M.ravel())
        if same: plane_rows+=prof
        else:
            delta=np.array([0.5*(e[idx[tuple(sorted((i,k)))],idx[tuple(sorted((i,k)))]]-e[idx[tuple(sorted((j,k)))],idx[tuple(sorted((j,k)))]]) for k in range(n) if k not in (i,j)])
            orbit_rows.append(sum(c*r for c,r in zip(delta,prof)))

    # double rotation at (ij|kl), {i,j} in P, {k,l} in Q': v+w = W_{ik,jl}+W_{il,jk} = 0
    dr_rows=[]
    Qs=[x for x in range(n) if x not in P]
    for i_,j_ in itertools.combinations(P,2):
        for k_,l_ in itertools.combinations(Qs,2):
            M=np.zeros((N,N))
            for (a1,b1,c1,d1) in [(i_,k_,j_,l_),(i_,l_,j_,k_)]:
                s,x,y=ent(None,a1,b1,c1,d1); M[x,y]+=s; M[y,x]+=s
            dr_rows.append(Qo.T@M.ravel())
    # within-factor four-sets: the double rotation forces every pairing's combination to zero, so the whole block vanishes
    for fac in (P,Qs):
        for quad in itertools.combinations(fac,4):
            a_,b_,c_,d_=quad
            for (x1,y1,x2,y2) in [(a_,b_,c_,d_),(a_,c_,b_,d_),(a_,d_,b_,c_)]:
                M=np.zeros((N,N)); s_,x,y=ent(None,x1,y1,x2,y2); M[x,y]+=s_; M[y,x]+=s_
                dr_rows.append(Qo.T@M.ravel())
    Cm=np.array(rows+orbit_rows+plane_rows+dr_rows); _,sv,vt=np.linalg.svd(Cm); rk=(sv>1e-9).sum(); S=vt[rk:].T
    dV=S.shape[1]
    Ls=S.T@L@S
    ops=[(Qo@S[:,k]).reshape(N,N) for k in range(dV)]
    def Pv(x):
        X=sum(c*o for c,o in zip(x,ops)); return np.sum(Qb(X,X)*X), X
    def grad(x,lam):
        X=sum(c*o for c,o in zip(x,ops)); G=3*Qb(X,X)
        gP=np.array([np.sum(G*o) for o in ops]); return gP+2*lam*(Ls@x)
    # split V into L_e eigenspaces: 0-modes and +c* modes
    w,U=np.linalg.eigh(Ls)
    V0=U[:,np.abs(w)<1e-8]; Vp=U[:,np.abs(w-cstar)<1e-8]
    print(f"  eigen split of V: dim0={V0.shape[1]} dim+c*={Vp.shape[1]} other={dV-V0.shape[1]-Vp.shape[1]}")
    def maxP(B,starts=8,its=400):
        best=-1e9; rng2=np.random.default_rng(1)
        for st in range(starts):
            y=rng2.standard_normal(B.shape[1]); y/=np.linalg.norm(y)
            for it in range(its):
                x=B@y; g=B.T@grad(x,0.0); g-=np.dot(g,y)*y; y=y+0.05*g; y/=np.linalg.norm(y)
            best=max(best,Pv(B@y)[0])
        return best
    # beta: sup over unit nu0 in V0 of |pi_+ Q(nu0)|, and the reduced formula check
    B0=[ (Qo@(S@V0[:,k])).reshape(N,N) for k in range(V0.shape[1]) ]
    Bp=[ (Qo@(S@Vp[:,k])).reshape(N,N) for k in range(Vp.shape[1]) ]
    # T(nu0_a, nu0_b, Z_c) tensor contracted: for each Z_c, matrix M_c[a,b] = <Q(B0_a,B0_b), Bp_c>
    k0=len(B0); kp=len(Bp)
    Mc=np.zeros((kp,k0,k0))
    for a1 in range(k0):
        for b1 in range(a1,k0):
            Qab=Qb(B0[a1],B0[b1])
            for c1 in range(kp):
                v=np.sum(Qab*Bp[c1]); Mc[c1,a1,b1]=v; Mc[c1,b1,a1]=v
    # beta_max = max over unit Z (coeffs z) of lambda_max(sum z_c M_c): ascent
    best=0; rng3=np.random.default_rng(2)
    for st in range(10):
        z=rng3.standard_normal(kp); z/=np.linalg.norm(z)
        for it in range(200):
            Mz=np.tensordot(z,Mc,1); w,U=np.linalg.eigh(Mz); u=U[:,-1]
            g=np.einsum('cab,a,b->c',Mc,u,u); z=g/np.linalg.norm(g)
        best=max(best,np.linalg.eigvalsh(np.tensordot(z,Mc,1)).max())
    print(f"  beta_max (top eig of L_Z on the hooks, unit Z) = {best:.6f}")
    # formula check at a random point of R e + V
    y0=rng3.standard_normal(k0); y0/=np.linalg.norm(y0); z0=rng3.standard_normal(kp); z0/=np.linalg.norm(z0)
    X0=sum(c*o for c,o in zip(y0,B0)); Z0=sum(c*o for c,o in zip(z0,Bp))
    xx,yy,zz=0.6,0.5,np.sqrt(1-0.36-0.25); U_=xx*e+yy*X0+zz*Z0
    lhs=np.sum(Qb(U_,U_)*U_)
    pplus=np.sum(Qb(Z0,Z0)*Z0); beta=np.sum(Qb(X0,X0)*Z0)
    rhs=d*xx**3+3*cstar*xx*zz**2+pplus*zz**3+3*beta*yy**2*zz
    print(f"  formula check: P(u)={lhs:.12f} reduced={rhs:.12f} diff={abs(lhs-rhs):.1e}")
    print(f"  max P on 0-modes: {maxP(V0):.6f}   max P on +c* modes: {maxP(Vp):.6f}   d={d:.6f}")
    rng=np.random.default_rng(0)
    print(f"n={n} d={d:.9f} c*={cstar:.6f} dim V={dV}  top eig of L_e on V={np.linalg.eigvalsh(Ls).max():.6f}")
    worst=-1e9
    for lam in [0,0.25*d,0.5*d,1.0*d,2.0*d]:
        best=None
        for st in range(8):
            x=rng.standard_normal(dV); x/=np.linalg.norm(x)
            for it in range(300):
                g=grad(x,lam); g-=np.dot(g,x)*x; x=x+0.05*g; x/=np.linalg.norm(x)
            q,_=Pv(x); r=x@Ls@x; val=q+lam*r
            if best is None or val>best[0]: best=(val,q,r)
        _,q,r=best
        ph=np.linspace(0,np.pi/2,2001); g=d*np.cos(ph)**3+3*r*np.cos(ph)*np.sin(ph)**2+q*np.sin(ph)**3
        excess=g.max()-d; worst=max(worst,excess)
        print(f"  lam={lam:.3f}: q=P(nu)={q:.6f} r={r:.6f}  arc max - d = {excess:.3e}  criterion d q^2-(d+r)^2(d-2r) = {d*q*q-(d+r)**2*(d-2*r):.4e}")
    print("  worst arc excess over d:", f"{worst:.3e}")

import sys
for pq in sys.argv[1:]:
    p,q=map(int,pq.split(',')); run(p,q)
