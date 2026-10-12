"""Claim 3: ||[X,Y]||^2 = 2  iff  anticommute + rank 4 + all sing vals 1/sqrt2 + im X = im Y."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from itertools import combinations

def ip(X,Y): return 0.5*np.trace(X.T@Y)
def nrm(X): return np.sqrt(ip(X,X))

print('=== (a) REVERSE direction: build the hypothesised configuration and measure the bracket ===')
def quat(n):
    I=np.zeros((n,n)); J=np.zeros((n,n)); K=np.zeros((n,n))
    for (M,(p,q,r_,s)) in [(I,(0,1,2,3)),(J,(0,2,3,1)),(K,(0,3,1,2))]:
        M[p,q]=1;M[q,p]=-1;M[r_,s]=1;M[s,r_]=-1
    return I,J,K
for n in [4,5,6,8,10]:
    I,J,K=quat(n)
    X=I/np.sqrt(2); Y=J/np.sqrt(2)
    C=X@Y-Y@X
    sx=np.linalg.svd(X,compute_uv=False)
    print(' n=%2d  |X|=%.6f |Y|=%.6f <X,Y>=%.1e  anticomm=%.1e  sv(X)=%s  imX=imY: %.1e   ||[X,Y]||^2 = %.12f'%(
        n,nrm(X),nrm(Y),ip(X,Y),np.max(np.abs(X@Y+Y@X)),np.round(sx[:6],4),
        np.max(np.abs(np.linalg.pinv(X)@X-np.linalg.pinv(Y)@Y)), ip(C,C)))
# random rotations of the configuration + random 2-dim eigenspace members
rng=np.random.default_rng(0); n=8
I,J,K=quat(n); vals=[]
for _ in range(200):
    A=rng.standard_normal((n,n)); Qo,_=np.linalg.qr(A)
    t=rng.uniform(0,2*np.pi)
    X=Qo@(I/np.sqrt(2))@Qo.T; Y=Qo@((np.cos(t)*J+np.sin(t)*K)/np.sqrt(2))@Qo.T
    C=X@Y-Y@X; vals.append(ip(C,C))
print(' 200 random rotations / mixtures in the top eigenspace: ||[X,Y]||^2 in [%.12f, %.12f]'%(min(vals),max(vals)))

print()
print('=== (b) FORWARD direction: exact operator norm of ad_X, and the gap in the recorded proof ===')
def admax(n, s):
    """max ||[X,Y]||^2 over unit Y, for X block-diagonal with rotation angles s (sum s_i^2 = 1)."""
    N=n*(n-1)//2; P=phis(n); pr=pairs(n)
    X=np.zeros((n,n))
    for k,v in enumerate(s): X[2*k,2*k+1]=v; X[2*k+1,2*k]=-v
    ad=np.zeros((N,N))
    for b in range(N):
        C=X@P[b]-P[b]@X
        ad[:,b]=[0.5*np.trace(C.T@P[a]) for a in range(N)]
    ev=np.linalg.eigvalsh(ad.T@ad)
    return X, ev[-1]
print('  s (singular values of X)            sum s^2   lam_max(ad_X^T ad_X) = max||[X,Y]||^2   (s1+s2)^2   4 s1^2')
tests=[[1/np.sqrt(2)]*2, [1.0,0.0], [np.sqrt(.5),np.sqrt(.3),np.sqrt(.2)], [np.sqrt(.6),np.sqrt(.3),np.sqrt(.1)],
       [np.sqrt(.7),np.sqrt(.3),0.0],[np.sqrt(.34),np.sqrt(.33),np.sqrt(.33)],[np.sqrt(.5),np.sqrt(.25),np.sqrt(.25)]]
for s in tests:
    s=np.array(s); n=2*len(s)+2
    X,mx=admax(n,s)
    print('  %-34s %.4f    %.12f            %.9f  %.6f'%(np.round(s,4),np.sum(s**2),mx,(s[0]+s[1])**2 if len(s)>1 else s[0]**2,4*s[0]**2))
print()
print('  -> recorded proof only derives s1^2 >= 1/2 from the cap; profiles like s^2=(.5,.3,.2) and (.6,.3,.1)')
print('     satisfy s1^2>=1/2 with RANK 6, so that step does NOT force rank 4. Correct bound is ||ad_X||_op = s1+s2.')
print()
print('=== (c) max of (s1+s2)^2 subject to sum s_i^2 = 1 ===')
import sympy as sp
s1,s2,l=sp.symbols('s1 s2 l',positive=True)
print('   max (s1+s2)^2 with s1^2+s2^2<=1 is', sp.simplify(sp.Max()), '-> 2 at s1=s2=1/sqrt2 (Cauchy-Schwarz), so cap 2 forces rank 4.')
