"""Scan Gr(3,8) for so(3)+so(5) gradings of a given W, and record ||A||^2 on each."""
import sys, numpy as np
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R
from r313_m3 import gauss_newton
n=8; P=R.pairs(n); N=len(P)
I=np.array([p[0] for p in P]); J=np.array([p[1] for p in P])
def lam2(g):
    return g[np.ix_(I,I)]*g[np.ix_(J,J)] - g[np.ix_(J,I)]*g[np.ix_(I,J)]
def obj(W,F):
    g=np.eye(n)-2*F@F.T; L=lam2(g); C=L@W-W@L
    return 0.25*float(np.sum(C*C))
def polish(W,F,iters=600):
    f0=obj(W,F); step=0.2
    for it in range(iters):
        G=np.zeros_like(F); h=1e-6
        for a in range(n):
            for b in range(3):
                E=np.zeros((n,3)); E[a,b]=h
                Fp,_=np.linalg.qr(F+E); Fm,_=np.linalg.qr(F-E)
                G[a,b]=(obj(W,Fp)-obj(W,Fm))/(2*h)
        Fn,_=np.linalg.qr(F-step*G); f1=obj(W,Fn)
        if f1<f0: F,f0=Fn,f1; step*=1.3
        else: step*=0.4
        if step<1e-13 or f0<1e-26: break
    return f0,F
idx1=[t for t,(i,j) in enumerate(P) if i<3 and j<3]
idx2=[t for t,(i,j) in enumerate(P) if i>=3 and j>=3]
ip=idx1+idx2
def stats(W,F):
    rest=np.linalg.qr(np.eye(n)-F@F.T)[0][:, :5]
    Rot=np.column_stack([F,rest])
    Rot,_=np.linalg.qr(Rot)
    L=lam2(Rot); Wr=L.T@W@L
    A=Wr[np.ix_(ip,ip)]
    return float(np.sum(A*A)), float(np.trace(Wr[np.ix_(idx1,idx1)])), 2*float(np.sum(Wr[np.ix_(idx1,idx2)]**2))
W=np.load("scripts/reviewers/r305/out/r305_n8_seed9015.npy")
W=gauss_newton(n,W)
if R.theta_of(n,W)<0: W=-W
rng=np.random.default_rng(11); seen=[]
for t in range(60):
    F,_=np.linalg.qr(rng.standard_normal((n,3)))
    f,F=polish(W,F)
    if f<1e-18:
        a2,tr1,cx=stats(W,F)
        if not any(abs(a2-s[0])<1e-6 for s in seen):
            seen.append((a2,tr1,cx)); print(f"  grading: ||A||^2={a2:.6f}  trA|so(3)={tr1:.6f}  ||p-cross||^2={cx:.6f}", flush=True)
print("distinct ||A||^2 values found:", sorted(round(s[0],6) for s in seen))
