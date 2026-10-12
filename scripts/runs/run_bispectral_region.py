"""Item 1(iii): map the realisable region  R_n = {(p3(mu), p3(omega))}  at n=6,8.

Ascent gives a LOWER bound on the support function in each direction, so this can only
REFUTE that the line 3/2 x - 1/2 y = theta_0(n) supports R_n -- by finding a point above it.
It cannot confirm support. That is the intended use.
"""
import numpy as np, itertools, sys
rng=np.random.default_rng(23)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def setup(n):
    pr=list(itertools.combinations(range(n),2)); N=len(pr); dim=n*(n+1)*(n+2)*(n-3)//12
    def to_M(W): return np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr])
    def from_M(M):
        W=np.zeros((n,n,n,n))
        for a,(i,j) in enumerate(pr):
            for b,(k,l) in enumerate(pr):
                v=M[a,b]
                for (p,q,sp) in ((i,j,1),(j,i,-1)):
                    for (r,s_,sq) in ((k,l,1),(l,k,-1)): W[p,q,r,s_]=sp*sq*v
        return W
    V=np.array([to_M(proj_weyl(rng.standard_normal((n,n,n,n)),n)).ravel() for _ in range(4*dim+60)])
    U,sv,_=np.linalg.svd(V.T,full_matrices=False)
    B=[U[:,k].reshape(N,N) for k in range(dim)]
    idx=[(i,j) for i in range(n) for j in range(i,n)]
    def bs(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    SB=[bs(i,j) for (i,j) in idx]
    gv=np.array([np.trace(b) for b in SB]); gv/=np.linalg.norm(gv); P0=np.eye(len(idx))-np.outer(gv,gv)
    def ring_of(W):
        Op=np.zeros((len(idx),len(idx)))
        for a,h in enumerate(SB):
            Wh=np.einsum('iklj,kl->ij',W,h)
            for b,hb in enumerate(SB): Op[a,b]=np.sum(Wh*hb)
        return P0@Op@P0
    ringB=[ring_of(from_M(b)) for b in B]
    def prw(X): return sum(np.sum(X*b)*b for b in B)
    def istar(X): return sum(np.sum(ringB[k]*X)*B[k] for k in range(dim))
    return pr,N,dim,to_M,from_M,ring_of,prw,istar,B,sv
def xy(M,ring_of,from_M):
    R=ring_of(from_M(M)); return np.trace(M@M@M), np.trace(R@R@R), R
def ascend(a,b,n,tools,iters=400,starts=6):
    pr,N,dim,to_M,from_M,ring_of,prw,istar,B,sv=tools
    best=None
    for s0 in range(starts):
        M=sum(rng.standard_normal()*bb for bb in B); M/=np.linalg.norm(M)
        step=0.25
        for t in range(iters):
            R=ring_of(from_M(M))
            G=3*a*prw(M@M)+3*b*istar(R@R)
            G=G-np.sum(G*M)*M
            ng=np.linalg.norm(G)
            if ng<1e-12: break
            Mn=M+step*G/ng; Mn/=np.linalg.norm(Mn)
            x0,y0,_=xy(M,ring_of,from_M); x1,y1,_=xy(Mn,ring_of,from_M)
            if a*x1+b*y1 > a*x0+b*y0: M=Mn
            else: step*=0.6
            if step<1e-10: break
        x,y,_=xy(M,ring_of,from_M)
        v=a*x+b*y
        if best is None or v>best[0]: best=(v,x,y)
    return best
def sphere_product(p,q,n):
    Lam=np.zeros((n,n)); b=1.0; a1=-q*b/(p-1); a2=-p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i==j: continue
            Lam[i,j]=a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    I=np.eye(n)
    return -(np.einsum('ij,ik,jl->ijkl',Lam,I,I)-np.einsum('ij,il,jk->ijkl',Lam,I,I))
import os
NS=[int(v) for v in os.environ.get("REGION_NS","6,8,10").split(",")]
for n in NS:
    tools=setup(n); pr,N,dim,to_M,from_M,ring_of,prw,istar,B,sv=tools
    t0=np.sqrt(2*(n-1)*(n-2))/n
    Wsp=sphere_product(n//2,n//2,n); Msp=to_M(Wsp); Msp/=np.linalg.norm(Msp)
    xs,ys,_=xy(Msp,ring_of,from_M)
    print(f"\nn={n} dim={dim} svgap={sv[dim-1]:.1e}/{sv[dim]:.1e} | theta_0={t0:.6f}")
    print(f"  balanced sphere product: p3(mu)={xs:+.6f} p3(omega)={ys:+.6f} -> 3/2x-1/2y={1.5*xs-0.5*ys:+.6f}")
    print(f"  {'direction (a,b)':>18} {'max a*x+b*y':>13} {'p3(mu)':>10} {'p3(om)':>10} {'3/2x-1/2y':>11} {'vs theta_0':>11}")
    DIRS=[(1.5,-0.5),(0,-1),(1,0),(1,-1),(2,-1),(1,-2)] if os.environ.get("REGION_DIRS") is None else [tuple(float(z) for z in d.split(":")) for d in os.environ["REGION_DIRS"].split(",")]
    for (a,b) in DIRS:
        nb=np.hypot(a,b); v,x,y=ascend(a/nb,b/nb,n,tools)
        th=1.5*x-0.5*y
        flag='  <-- above theta_0 (EXPECTED below the crossover n=6+2sqrt7=11.29: CP^2 wins there)' if th>t0+1e-7 else ''
        print(f"  {f'({a},{b})':>18} {v:>13.6f} {x:>10.6f} {y:>10.6f} {th:>11.6f} {th/t0:>11.4f}{flag}")
