"""Reviewer r1851: check the CP^m calibration of reviews/2026-09-28d-I121-smallmass-direct.md from the Fubini-Study curvature tensor itself (holomorphic sectional curvature 4), independent of the quoted spectrum. Builds R on Lambda^2 R^{2m}, removes the scalar part, normalises, computes W^# from so(n) structure constants normalised by I^# = (n-2)I, and reports the spectrum, the criticality residual, theta, tr W^3, theta*lambda_max, E, eps_n, the J-adapted diagonal mass, and the L198 slack split. Run: sage -python review_r1851_cpm.py"""
import numpy as np, itertools
def run(m):
    n=2*m
    J=np.zeros((n,n))
    for i in range(m): J[2*i+1,2*i]=1; J[2*i,2*i+1]=-1
    g=np.eye(n)
    # R(X,Y)Z = <Y,Z>X - <X,Z>Y + <JY,Z>JX - <JX,Z>JY + 2<X,JY>JZ ; Rm(a,b,c,d)=<R(e_a,e_b)e_c,e_d>
    def Rvec(a,b,c):
        X,Y,Z=g[a],g[b],g[c]
        return (Y@Z)*X-(X@Z)*Y+((J@Y)@Z)*(J@X)-((J@X)@Z)*(J@Y)+2*(X@(J@Y))*(J@Z)
    pairs=list(itertools.combinations(range(n),2)); N=len(pairs)
    R=np.zeros((N,N))
    for p,(a,b) in enumerate(pairs):
        for q,(c,d) in enumerate(pairs):
            R[p,q]=Rvec(a,b,d)@g[c]   # <R(a,b)d,c> gives sec(a,b)=R[ab,ab]>0
    assert np.allclose(R,R.T)
    sec=np.array([R[p,p] for p in range(N)])
    W=R-np.trace(R)/N*np.eye(N)
    # Ricci of W must vanish (Einstein): row sums of diagonal-type contraction
    Ric=np.zeros((n,n))
    for p,(a,b) in enumerate(pairs):
        for q,(c,d) in enumerate(pairs):
            for (i,j,s1) in [(a,b,1),(b,a,-1)]:
                for (k,l,s2) in [(c,d,1),(d,c,-1)]:
                    if j==l: Ric[i,k]+=s1*s2*W[p,q]
    W/=np.linalg.norm(W)
    # structure constants of so(n) in basis E_ab-E_ba
    B=[]
    for (a,b) in pairs:
        M=np.zeros((n,n)); M[a,b]=1; M[b,a]=-1; B.append(M)
    def coords(M): return np.array([M[a,b] for (a,b) in pairs])
    C=np.zeros((N,N,N))
    for x in range(N):
        for y in range(N):
            C[x,y]=coords(B[x]@B[y]-B[y]@B[x])
    def sharp(A):
        # (A#)_{zw} = 1/2 sum C[x,y,z] C[u,v,w] A[x,u] A[y,v]
        return 0.5*np.einsum('xyz,uvw,xu,yv->zw',C,C,A,A,optimize=True)
    Is=sharp(np.eye(N)); k=(n-2)/Is[0,0]; assert np.allclose(k*Is,(n-2)*np.eye(N))
    Qw=W@W+k*sharp(W)
    th=np.sum(Qw*W)
    res=np.linalg.norm(Qw-th*W)
    ev=np.linalg.eigvalsh(W); tr3=np.sum(ev**3)
    lmax=ev.max(); E=th-1.5*tr3
    t0=np.sqrt(2*(n-1)*(n-2))/n; eps=t0-1.5/t0
    t2=np.sum(np.diag(W)**2)
    slack=ev**2*(1-th*ev)
    vals,cnt=np.unique(np.round(ev/ev.max(),8),return_counts=True)
    print(f"m={m} n={n}: Ric(W) max {np.abs(Ric).max():.1e}, crit residual {res:.1e}, theta={th:.6f} (formula {np.sqrt((m+1)*(2*m-1)/(3*m*(m-1))):.6f})")
    print(f"   spectrum/lmax: {dict(zip(vals,cnt))}  expected ratios {[-(m+1)/(2*(m*m-1)),(m-2)/(2*(m*m-1)),1.0]} mults {[m*m-m,m*m-1,1]}")
    print(f"   trW3={tr3:.6f} theta*lmax={th*lmax:.4f} E={E:.6f} eps_n={eps:+.6f} adapted-frame t^2={t2:.4f} (3/(n+2)={3/(n+2):.4f})")
    top=slack[np.argmax(ev)]; neg=slack[ev<-1e-9].sum(); mid=slack.sum()-top-neg
    print(f"   L198 slack 1-theta*trW3={1-th*tr3:.4f}: top eigenvalue {top:.4f}, su(m) part {mid:.4f}, negative part {neg:.4f}")
for m in [3,4,5,6]: run(m)
