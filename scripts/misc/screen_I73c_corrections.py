"""I73 (c), section 5 of reviews/2026-09-23-I73c-summed-pairs.md: screens of the correction terms.

Phi(e;X,Y) and Om(e;X,Y) are the eigenspace-summed Ricci and Lambda^4 corrections as trilinear
contractions, checked against brute force; the Schur reductions Phi(e;Id,Y) = 12<e,Y> and
Om(e;Id,Y) = (n-4)(n-5)/9 <e,Y>; the cubic reductions Phi(e;e,e) = 8 tr e^3 - 4<e,e#> = 9 Om(e;e,e);
the operator form <N4, e.N4> = 3 tr(e N4^2) and its spectral bound; and the explicit summed inequality
at padded W_CP2.  Seconds per object, on random or stored objects.
"""
import sys, io, contextlib, numpy as np
sys.path.insert(0, __file__.rsplit("/", 1)[0])
from screen_I73_pair_direction import pairs, structure_constants, weyl_projector, sharp_mat, ortho_basis
from screen_I113_defect_identity import to4
rng=np.random.default_rng(8)
def Phi(e4,X4,Y4):
    t=lambda A,B: np.einsum('ijkl,imjp,mkpl->',e4,A,B,optimize=True)+np.einsum('ijkl,impl,mkjp->',e4,A,B,optimize=True)
    return t(X4,Y4)+t(Y4,X4)
def Om(e4,X4,Y4):
    # sum over alpha,beta of x_a y_b * sum e_ijkl w_ijab w_klab with w = Alt(psi_a (x) psi_b); built from Alt of X(x)Y
    n=e4.shape[0]
    # w_{ijkl}^{ab} = Alt(u_ij v_kl); sum_ab x y w w  -> contraction of Alt-projected product; do via explicit perms
    import itertools
    perms=list(itertools.permutations(range(4)))
    def sgn(p):
        s=1
        for a in range(4):
            for b in range(a+1,4):
                if p[a]>p[b]: s=-s
        return s
    # Alt(u(x)v)_{i j k l} = 1/24 sum_s sgn(s) (u(x)v)_{s(ijkl)}; bilinear sum over basis uses X4,Y4 as sum x u(x)u, y v(x)v
    # compute T = sum_ab x y Alt(u v)_{ijcd} Alt(u v)_{klcd} e_ijkl  via 24x24 terms of X4/Y4 contractions
    tot=0.0
    idx='ijcd'; idx2='klcd'
    for p in perms:
        for q in perms:
            A=[idx[p[0]],idx[p[1]]]; B=[idx[p[2]],idx[p[3]]]
            C=[idx2[q[0]],idx2[q[1]]]; D=[idx2[q[2]],idx2[q[3]]]
            # (u v)_{..} (u v)_{..} -> u_A v_B u_C v_D -> X4_{A C} Y4_{B D}
            s=f"ijkl,{A[0]}{A[1]}{C[0]}{C[1]},{B[0]}{B[1]}{D[0]}{D[1]}->"
            tot+=sgn(p)*sgn(q)*np.einsum(s,e4,X4,Y4,optimize=True)
    return tot/576.0
for n in (6,7):
    N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n); P=ortho_basis(n)
    M=rng.normal(size=(N,N)); M=(M+M.T)/2; E=(Pi@M.ravel()).reshape(N,N); E/=np.sqrt(np.trace(E@E))
    e4=to4(E,n); lam,V=np.linalg.eigh(E)
    # brute force check of Phi and Om on two random "eigenspace" groups
    a=list(range(0,3)); b=list(range(5,8))
    bfR=0; bfL=0
    for i in a:
        for j in b:
            U=sum(V[k,i]*P[k] for k in range(N)); W_=sum(V[k,j]*P[k] for k in range(N))
            H=U@W_+W_@U; bfR+=np.einsum('ijkl,ik,jl->',e4,H,H)
            w=np.einsum('ij,kl->ijkl',to4(np.outer(V[:,i],V[:,i]),n)[:,:,0,1]*0+0,np.zeros((n,n))) if False else None
    Pa=V[:,a]@V[:,a].T; Pb=V[:,b]@V[:,b].T
    print(f"n={n}: brute sum e(H,H) = {bfR:.10f}   Phi(e;Pa,Pb) = {Phi(e4,to4(Pa,n),to4(Pb,n)):.10f}")
    # Schur: Phi(e;Id,Y) = kappa <e,Y>
    Y=rng.normal(size=(N,N)); Y=(Y+Y.T)/2
    I4=to4(np.eye(N),n)
    r1=Phi(e4,I4,to4(Y,n))/np.sum(E*Y); r2=Phi(e4,I4,to4(E@E,n))/np.sum(E*(E@E))
    print(f"   Phi(e;Id,Y)/<e,Y> = {r1:.10f} and at Y=e^2: {r2:.10f}")
    Omr1=Om(e4,I4,to4(Y,n))/np.sum(E*Y); Omr2=Om(e4,I4,to4(E@E,n))/np.sum(E*(E@E))
    print(f"   Om(e;Id,Y)/<e,Y>  = {Omr1:.10f} and at Y=e^2: {Omr2:.10f}")

print("---- Om brute force, and cubic fits ----")
import itertools
def alt(T):
    out=np.zeros_like(T)
    for p in itertools.permutations(range(4)):
        s=1
        for a_ in range(4):
            for b_ in range(a_+1,4):
                if p[a_]>p[b_]: s=-s
        out+=s*np.transpose(T,p)
    return out/24
for n in (6,7,8):
    N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n); P=ortho_basis(n)
    rows=[]
    for trial in range(3):
        M=rng.normal(size=(N,N)); M=(M+M.T)/2; E=(Pi@M.ravel()).reshape(N,N); E/=np.sqrt(np.trace(E@E))
        e4=to4(E,n); lam,V=np.linalg.eigh(E)
        if trial==0:
            a=list(range(0,2)); b=list(range(4,6)); bf=0
            for i in a:
                for j in b:
                    # psi as antisymmetric 2-tensor with the to4 convention u_ij = <phi_ij, psi>
                    u=to4(np.outer(V[:,i],V[:,i]),n)  # u(x)u as 4-tensor; extract u_ij from a row
                    ui=np.zeros((n,n)); vj=np.zeros((n,n))
                    for k_,(p_,q_) in enumerate(pairs(n)):
                        ui[p_,q_]=V[k_,i]; ui[q_,p_]=-V[k_,i]; vj[p_,q_]=V[k_,j]; vj[q_,p_]=-V[k_,j]
                    w=alt(np.einsum('ij,kl->ijkl',ui,vj))
                    bf+=np.einsum('ijkl,ijab,klab->',e4,w,w)
            Pa=V[:,a]@V[:,a].T; Pb=V[:,b]@V[:,b].T
            print(f"n={n}: Om brute {bf:.10f}  Om(e;Pa,Pb) {Om(e4,to4(Pa,n),to4(Pb,n)):.10f}")
        tr3=np.trace(E@E@E); es=np.sum(E*sharp_mat(c,E,E))
        rows.append((tr3,es,Phi(e4,e4,e4),Om(e4,e4,e4)))
    R=np.array(rows)
    for col,name in ((2,'Phi(e;e,e)'),(3,'Om(e;e,e)')):
        coef,res,_,_=np.linalg.lstsq(R[:2,:2],R[:2,col],rcond=None)
        pred=R[2,:2]@coef
        print(f"   {name} = {coef[0]:.9f} tr e^3 + {coef[1]:.9f} <e,e#>;  out-of-sample residual {abs(pred-R[2,col]):.1e}")

# ---- the Lambda^4 operator form and bound ----
import io, contextlib
with contextlib.redirect_stdout(io.StringIO()):
    from screen_I73_pair_blindness import padded_cp2
from screen_I73_pair_direction import circ, ortho_basis
with contextlib.redirect_stdout(io.StringIO()):
    from screen_I73_projected_split import curv_projector
rng=np.random.default_rng(21)
for n in (6,7,8):
    N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n); Pc=curv_projector(n)
    M=rng.normal(size=(N,N)); M=(M+M.T)/2; E=(Pi@M.ravel()).reshape(N,N); E/=np.sqrt(np.trace(E@E))
    epsmax=np.linalg.eigvalsh(E).max(); worst=-9; exact=0
    Q,_=np.linalg.qr(rng.normal(size=(N,N)))
    for t in range(min(8,N//2)):
        u,v=Q[:,2*t],Q[:,2*t+1]
        Y0=0.5*(np.outer(u,v)+np.outer(v,u)); Yc=(Pc@Y0.ravel()).reshape(N,N); N4=Y0-Yc
        c4=np.sum(N4*circ(c,E,N4)); w2=np.sum(N4*N4)
        worst=max(worst,c4-3*epsmax*w2)
        # operator form: <N4,e.N4> = (3/8)*8*tr(e N4^2)?  check the tr(e w^2) form directly
        exact=max(exact,abs(c4-3*np.trace(E@N4@N4)))
    I4=to4(np.eye(N),n); Y=rng.normal(size=(N,N)); Y=(Y+Y.T)/2
    kap=Om(to4(E,n),I4,to4(Y,n))/np.sum(E*Y) if n<=8 else float('nan')
    print(f"n={n}: max(C4 - 3 eps_max |N4|^2) = {worst:+.3e} (must be <= 0);  |C4 - 3 tr(e N4^2)| = {exact:.1e};  kappa'(n) = {kap:.10f} vs (n-4)(n-5)/9 = {(n-4)*(n-5)/9:.10f}")

# ---- the explicit summed inequality at padded W_CP2 ----
for n in (6,8):
    N=len(pairs(n)); c=structure_constants(n); P=ortho_basis(n)
    W=padded_cp2(n); W/=np.sqrt(np.trace(W@W)); th=np.trace(W@W@W)+np.sum(W*sharp_mat(c,W,W)); E=W/th
    lam,V=np.linalg.eigh(E); vals=sorted(set(np.round(lam,9)))
    groups=[V[:,np.isclose(lam,x,atol=1e-7)] for x in vals]
    # second-kind top eigenvalue (note's S convention) of e
    e4=to4(E,n)
    S=[]
    for i in range(n):
        for j in range(i,n):
            m=np.zeros((n,n)); m[i,j]=m[j,i]=1; S.append((m/np.linalg.norm(m)).ravel())
    I=np.eye(n).ravel()/np.sqrt(n); S=np.array([s-(s@I)*I for s in S]).T; U,sv,_=np.linalg.svd(S,full_matrices=False); B0=U[:,sv>1e-9]
    Sm=np.array([[np.sum(B0[:,a].reshape(n,n)*np.einsum('ijkl,jl->ik',e4,B0[:,b].reshape(n,n))) for b in range(B0.shape[1])] for a in range(B0.shape[1])])
    mu_ring=np.linalg.eigvalsh((Sm+Sm.T)/2).max(); epsmax=lam.max()
    Theta=np.sqrt(2*(n-1)*(n-2))/n; cap=n/(n-1)*Theta/th
    Amat=[]
    for g in groups:
        Aa=np.zeros((n,n))
        for a in range(g.shape[1]):
            Psi=sum(g[k,a]*P[k] for k in range(N)); Aa+=Psi@Psi.T
        Amat.append(Aa)
    cb=np.einsum('xa,yb,zc,xyz->abc',V,V,V,c); T=cb**2
    idx=[np.where(np.isclose(lam,x,atol=1e-7))[0] for x in vals]
    print(f"n={n}: theta={th:.6f}, eigenvalues of e {np.round(vals,4)}, mu_ring={mu_ring:.6f}, projection cap={cap:.6f}, eps_max={epsmax:.4f}")
    for a in range(3):
        for b in range(a+1,3):
            ma,mb=len(idx[a]),len(idx[b]); ea,eb=vals[a],vals[b]
            tau_c=[T[np.ix_(idx[a],idx[b],idx[cc])].sum() for cc in range(3)]
            G=np.trace(Amat[a]@Amat[b])
            lhs=0.25*ma*mb*(ea+eb-1)-0.25*sum(vals[cc]*tau_c[cc] for cc in range(3))
            rhs=(mu_ring-1)/(2*(n-2))*(G-0.5*sum(tau_c))+(3*epsmax-0.5)*(ma*mb-G)/6
            print(f"   pair ({ea:+.3f},{eb:+.3f}): LHS {lhs:+.5f} <= RHS {rhs:+.5f} ? {lhs<=rhs+1e-12}")
