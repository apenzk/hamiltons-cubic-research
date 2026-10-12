"""r1842: value checks for the I121 sweep-c brief (screens, not evidence for positive claims).
1. F81 witness at n=12: t^2, sum a_e^2, E(M), and f(phi)-f(0) against 4u g(u) from the block coefficients.
2. Padded W_CP2 at n=8: max over O(8) of diagonal mass t^2 (few random starts).
"""
import numpy as np, itertools
from scipy.linalg import expm
from scipy.optimize import minimize

def pairs(n): return list(itertools.combinations(range(n), 2))

def to4(Rop, n):
    P = pairs(n); idx = {p: k for k, p in enumerate(P)}
    R = np.zeros((n,)*4)
    for (a, b), k in idx.items():
        for (c, d), l in idx.items():
            v = Rop[k, l]
            R[a,b,c,d]=v; R[b,a,c,d]=-v; R[a,b,d,c]=-v; R[b,a,d,c]=v
    return R

def weyl_proj(R):
    n = R.shape[0]; Ric = np.einsum('iaja->ij', R); s = np.trace(Ric)
    g = np.eye(n)
    def KN(h, k):
        return (np.einsum('ac,bd->abcd', h, k) + np.einsum('bd,ac->abcd', h, k)
                - np.einsum('ad,bc->abcd', h, k) - np.einsum('bc,ad->abcd', h, k))
    A = (Ric - s / (2*(n-1)) * g) / (n-2)
    return R - KN(A, g)

def diag(R):
    n = R.shape[0]; return np.array([R[a,b,a,b] for a, b in pairs(n)])

def norm(R): return np.sqrt(np.sum(R**2)/4)  # HS on Lambda^2

def rot(R, Q): return np.einsum('ai,bj,ck,dl,ijkl->abcd', Q, Q, Q, Q, R, optimize=True)

# 1. F81 witness
n = 12; m = 6
R = np.zeros((n,)*4)
for blk in (range(m), range(m, n)):
    for a in blk:
        for b in blk:
            if a != b: R[a,b,a,b] += 1; R[a,b,b,a] -= 1
W = weyl_proj(R); print('ricci resid', np.abs(np.einsum('iaja->ij', W)).max())
W /= norm(W)
print('product t^2', np.sum(diag(W)**2))
M = [(k, k+m) for k in range(m)]
def Qmatch(phi):
    Q = np.eye(n)
    for p, q in M:
        c, s = np.cos(phi), np.sin(phi); Q[p,p]=c; Q[q,q]=c; Q[p,q]=-s; Q[q,p]=s
    return Q
Wt = rot(W, Qmatch(np.pi/4)); d = diag(Wt); P = pairs(n)
t2 = np.sum(d**2); ae2 = sum(Wt[p,q,p,q]**2 for p, q in M)
pairmax = max(abs(Wt[a,b,a,c]) for a in range(n) for b in range(n) for c in range(n) if len({a,b,c})==3)
E = sum((Wt[e[0],f[0],e[1],f[1]] + Wt[e[0],f[1],e[1],f[0]])**2 for e, f in itertools.combinations(M, 2))
print(f'witness t^2={t2:.6f} (1/n={1/n:.6f}) sum a_e^2={ae2:.6f} E(M)={E:.6f} max pair entry={pairmax:.2e}')
# block coefficients on Wt, then compare f(phi)-f(0) with 4u g(u)
SIZ=SZZ=SZX=SXX=0.0
Z=np.diag([1.,-1.]); X=np.array([[0,1.],[1,0]]); I2=np.eye(2)
for (i,j),(k,l) in itertools.combinations(M,2):
    basis=[(i,k),(i,l),(j,k),(j,l)]
    B=np.array([[Wt[a,b,c,d] for (c,d) in basis] for (a,b) in basis])
    co=lambda A,C: np.trace(B@np.kron(A,C))/4
    SIZ+=co(I2,Z)**2+co(Z,I2)**2; SZZ+=co(Z,Z)**2; SZX+=co(Z,Z)*co(X,X); SXX+=co(X,X)**2
g=lambda u: -SIZ-2*SZZ+2*SZX+u*(SZZ-2*SZX+SXX)
for phi in (0.1,0.3,0.5,np.pi/4):
    u=np.sin(2*phi)**2; Wp=rot(Wt,Qmatch(phi))
    print(f'phi={phi:.3f} f-f0={np.sum(diag(Wp)**2)-t2:.6f} 4ug(u)={4*u*g(u):.6f}')
# random pair-bearing check of the formula failing (sanity that pair-freeness is used): skip

# 2. padded CP2 at n=8
n=8
w=np.zeros((4,4,4,4))
# W+ = diag(2,-1,-1) on (e12+e34)/r2, (e13-e24)/r2 ... use self-dual basis
def bv(a,b,n=4):
    B=np.zeros((n,n)); B[a,b]=1; B[b,a]=-1; return B
om=[(bv(0,1)+bv(2,3))/np.sqrt(2),(bv(0,2)-bv(1,3))/np.sqrt(2),(bv(0,3)+bv(1,2))/np.sqrt(2)]
lam=np.array([2,-1,-1])/np.sqrt(6)
for L,o in zip(lam,om): w+=L*np.einsum('ab,cd->abcd',o,o)/1.0
Wc=np.zeros((n,)*4); Wc[:4,:4,:4,:4]=w
print('CP2 ricci resid',np.abs(np.einsum('iaja->ij',Wc)).max(),'norm',norm(Wc),'t2 std frame',np.sum(diag(Wc)**2))
evs=np.linalg.eigvalsh(np.array([[Wc[a,b,c,d] for (c,d) in pairs(n)] for (a,b) in pairs(n)]))
print('CP2 spectrum ext', evs.min(), evs.max())
tri=np.triu_indices(n,1)
def negt2(x):
    S=np.zeros((n,n)); S[tri]=x; S=S-S.T; Q=expm(S); return -np.sum(diag(rot(Wc,Q))**2)
rng=np.random.default_rng(1); best=0
for r in range(6):
    res=minimize(negt2,rng.normal(size=len(tri[0]))*1.5,method='BFGS'); best=max(best,-res.fun)
print('CP2 max t^2 over 6 starts',best)
