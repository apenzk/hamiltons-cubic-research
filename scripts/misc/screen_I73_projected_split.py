"""I73 sub-step (c): screens of the projected pair quotient's closed form.

<X, e.X> = <Y0, e.Y0> - <h, e h>/(2(n-2)) - (3/8)<w, e<>w>, with h = Ric(u (.) v) and w = Alt(u (.) v),
derived in reviews/2026-09-23-I73c-projected-pair.md.  Checks, at random Weyl e (the identities are
homogeneous in e and need no criticality): the split, the vanishing Ricci/Lambda^4 cross term, both
constants, the four-symbol law for disjoint coordinate pairs at a NON-diagonal e, and the three witness
pairs at padded W_CP2, n = 8, whose shared (lambda, T) data give quotients 0, -1/12, +1/24.
Seconds of linear algebra on objects constructed for the check.
"""
import sys, itertools, numpy as np
sys.path.insert(0, __file__.rsplit("/", 1)[0])
from screen_I73_pair_direction import pairs, structure_constants, weyl_projector, sharp_mat, circ, ortho_basis
rng=np.random.default_rng(3)

def curv_projector(n):
    pr=pairs(n); N=len(pr); idx={p:k for k,p in enumerate(pr)}
    def cell(i,j,k,l):
        if i==j or k==l: return None
        s=1.0
        if i>j: i,j,s=j,i,-s
        if k>l: k,l,s=l,k,-s
        return idx[(i,j)],idx[(k,l)],s
    rows=[]
    for (i,j,k,l) in itertools.combinations(range(n),4):
        row=np.zeros((N,N))
        for (p,q,r,s) in ((i,j,k,l),(i,k,l,j),(i,l,j,k)):
            t=cell(p,q,r,s)
            if t: x,y,sg=t; row[x,y]+=sg; row[y,x]+=sg
        rows.append(row.ravel())
    A=np.array(rows)
    Sy=[]
    for a in range(N):
        for b in range(a,N):
            M=np.zeros((N,N)); M[a,b]=M[b,a]=1.0; Sy.append(M.ravel()/np.linalg.norm(M))
    Sy=np.array(Sy).T
    _,sv,Vt=np.linalg.svd(A@Sy)
    nul=Vt[(sv>1e-9).sum():].T
    B,_=np.linalg.qr(Sy@nul)
    return B@B.T

def run(n, W, label, npairs=6):
    N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n); Pc=curv_projector(n); P=ortho_basis(n)
    W=W/np.sqrt(np.trace(W@W)); th=np.trace(W@W@W)+np.sum(W*sharp_mat(c,W,W)); E=W/th
    lam,V=np.linalg.eigh(E)
    print(f"\n{label} n={n} theta={th:.6f}")
    kap=[]
    for _ in range(npairs):
        a,b=rng.choice(N,2,replace=False); u,v=V[:,a],V[:,b]
        Y0=0.5*(np.outer(u,v)+np.outer(v,u))
        X=(Pi@Y0.ravel()).reshape(N,N); Nn=Y0-X
        Yc=(Pc@Y0.ravel()).reshape(N,N); N4=Y0-Yc; Nr=Yc-X
        lhs=np.sum(X*circ(c,E,X)); rhs=np.sum(Y0*circ(c,E,Y0))-np.sum(Nn*circ(c,E,Nn))
        cross=np.sum(Nr*circ(c,E,N4))
        um=sum(u[k]*P[k] for k in range(N)); vm=sum(v[k]*P[k] for k in range(N)); H=um@vm+vm@um
        form=-0.5*sum(lam[g]*np.linalg.norm(sum(V[k,g]*P[k] for k in range(N))@H-H@sum(V[k,g]*P[k] for k in range(N)))**2 for g in range(N))
        rr=np.sum(Nr*circ(c,E,Nr))
        kap.append(rr/form if abs(form)>1e-12 else np.nan)
        print(f"  split |lhs-rhs|={abs(lhs-rhs):.1e}  Ricci-L4 cross={cross:.1e}  <Nr,e.Nr>={rr:+.6f}  eh-form={form:+.6f}  ratio={kap[-1]:.9f}")
    return kap


rng=np.random.default_rng(5)

def to4(M,n):
    """operator on Lambda^2 in the i<j basis -> 4-tensor R_ijkl, antisymmetric in each pair"""
    pr=pairs(n); R=np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(pr):
        for b,(k,l) in enumerate(pr):
            x=M[a,b]; R[i,j,k,l]=x; R[j,i,k,l]=-x; R[i,j,l,k]=-x; R[j,i,l,k]=x
    return R

def pieces(n,E,u,v,c,Pi,Pc):
    N=len(pairs(n))
    Y0=0.5*(np.outer(u,v)+np.outer(v,u))
    X=(Pi@Y0.ravel()).reshape(N,N); Yc=(Pc@Y0.ravel()).reshape(N,N); N4=Y0-Yc; Nr=Yc-X
    e4=to4(E,n); Y4=to4(Y0,n); w4=to4(N4,n)
    hp=np.einsum('ijkj->ik',Y4)
    ricform=np.einsum('ijkl,ik,jl->',e4,hp,hp)
    l4form=np.einsum('ijkl,ijab,klab->',e4,w4,w4)
    return Y0,X,Nr,N4,hp,ricform,l4form

for n in (5,6,7,8):
    N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n); Pc=curv_projector(n)
    M=rng.normal(size=(N,N)); M=(M+M.T)/2; W=(Pi@M.ravel()).reshape(N,N); W/=np.sqrt(np.trace(W@W))
    th=np.trace(W@W@W)+np.sum(W*sharp_mat(c,W,W)); E=W/th
    lam,V=np.linalg.eigh(E)
    rr=[];r4=[];nn=[]
    for _ in range(5):
        a,b=rng.choice(N,2,replace=False)
        Y0,X,Nr,N4,hp,rf,lf=pieces(n,E,V[:,a],V[:,b],c,Pi,Pc)
        rr.append(np.sum(Nr*circ(c,E,Nr))/rf); r4.append(np.sum(N4*circ(c,E,N4))/lf)
        nn.append(abs(np.sum(Nr*Nr)-np.sum(hp*hp)/(n-2)))
    print(f"n={n}: Ricci ratio {np.round(rr,12)} vs 1/(2(n-2))={1/(2*(n-2)):.12f}; L4 ratio {np.round(r4,12)} vs 3/8; |Nr|^2 check {max(nn):.1e}")

# decisive pair test at padded W_CP2, n=8: two commuting pairs in the 0-eigenspace
n=8; N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n); Pc=curv_projector(n)
ip={pr:k for k,pr in enumerate(pairs(n))}
def vec(terms):
    v=np.zeros(N)
    for (i,j),s in terms: v[ip[(i,j)]]+=s
    return v/np.linalg.norm(v)
w1=vec([((0,1),1),((2,3),1)]); w2=vec([((0,2),1),((1,3),-1)]); w3=vec([((0,3),1),((1,2),1)])
W=2*np.outer(w1,w1)-np.outer(w2,w2)-np.outer(w3,w3); W/=np.sqrt(np.trace(W@W))
th=np.trace(W@W@W)+np.sum(W*sharp_mat(c,W,W)); E=W/th
print(f"\npadded W_CP2 n=8, theta={th:.9f}")
for lab,(p1,p2) in [("A (4,5)&(6,7)",((4,5),(6,7))),("B (0,4)&(1,5)",((0,4),(1,5))),("C (0,4)&(2,5)",((0,4),(2,5)))]:
    u=np.zeros(N); v=np.zeros(N); u[ip[p1]]=1; v[ip[p2]]=1
    assert np.allclose(E@u,0) and np.allclose(E@v,0)
    Y0,X,Nr,N4,hp,rf,lf=pieces(n,E,u,v,c,Pi,Pc)
    unp=np.sum(Y0*circ(c,E,Y0)); q=np.sum(X*circ(c,E,X))/np.sum(X*X)
    print(f"  {lab}: eigenvalues (0,0), [u,v]=0 so every T_(ab.)=0; unprojected num {unp:+.6f}; |piY0|^2={np.sum(X*X):.6f}; PROJECTED quotient {q:+.9f}")

rng=np.random.default_rng(9)
for n in (5,6,7):
    N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n); Pc=curv_projector(n)
    ip={pr:k for k,pr in enumerate(pairs(n))}
    M=rng.normal(size=(N,N)); M=(M+M.T)/2; W=(Pi@M.ravel()).reshape(N,N); W/=np.sqrt(np.trace(W@W))
    E=W  # the identities are homogeneous in e, so any Weyl e will do
    d=lambda i,j: E[ip[(min(i,j),max(i,j))],ip[(min(i,j),max(i,j))]]
    worst=0; l4=0
    for (a,b,cc,dd) in [(0,1,2,3),(0,2,1,4),(1,3,0,4),(0,4,2,3)]:
        u=np.zeros(N); v=np.zeros(N); u[ip[(a,b)]]=1; v[ip[(min(cc,dd),max(cc,dd))]]=1
        Y0,X,Nr,N4,hp,rf,lf=pieces(n,E,u,v,c,Pi,Pc)
        q=np.sum(X*circ(c,E,X))/np.sum(X*X)
        law=0.5*(d(a,b)+d(cc,dd))-0.25*(d(a,cc)+d(a,dd)+d(b,cc)+d(b,dd))
        worst=max(worst,abs(q-law)); l4=max(l4,abs(np.sum(N4*circ(c,E,N4))),abs(lf))
    print(f"n={n}: generic Weyl e, disjoint coordinate pairs, max|quotient - four-symbol law| = {worst:.1e};  max |<N4,e.N4>|,|L4 form| = {l4:.1e}")
