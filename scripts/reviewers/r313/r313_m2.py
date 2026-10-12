"""M2: the B1 resolution at the C_5 blow-up (n=10).
(a) does H_A = D_A W + W D_A leave Weyl_n?
(b) does projecting reproduce the recorded Sym_0 table?
(c) is the projected image L_e-invariant?"""
import sys, numpy as np, itertools
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R

n = 10
# ---- the C_5 blow-up: 5 blocks of 2, adjacency = the 5-cycle
blk = [i//2 for i in range(n)]
def cls(a,b):
    if a==b: return None
    if blk[a]==blk[b]: return 0
    d = (blk[a]-blk[b]) % 5
    return 1 if d in (1,4) else 2

def Mof(p):
    x,y,z = p
    M = np.zeros((n,n))
    for a in range(n):
        for b in range(n):
            c = cls(a,b)
            if c is not None: M[a,b] = (x,y,z)[c]
    return M

def eqs(v):
    x,y,z,th = v
    M = Mof((x,y,z))
    F = M*M + M@M - th*M - np.diag(np.einsum('ab,ab->a',M,M))
    # three independent class equations + normalisation ||W||^2 = 1
    r = [F[0,1], F[0,2], F[0,4]]
    nrm = 0.0
    for a in range(n):
        for b in range(a+1,n): nrm += M[a,b]**2
    r.append(nrm - 1.0)
    return np.array(r)

from numpy.linalg import solve, norm
def newton(v):
    for _ in range(200):
        F = eqs(v)
        J = np.zeros((4,4))
        for k in range(4):
            e = np.zeros(4); e[k] = 1e-7
            J[:,k] = (eqs(v+e)-eqs(v-e))/2e-7
        v = v - solve(J, F)
        if norm(eqs(v)) < 1e-14: break
    return v

sols = []
rng = np.random.default_rng(7)
for _ in range(300):
    v = newton(np.concatenate([rng.standard_normal(3), [rng.standard_normal()]]))
    if norm(eqs(v)) < 1e-12 and v[3] > 0:
        if not any(norm(v-s) < 1e-6 for s in sols): sols.append(v)
for v in sols:
    print("block-constant C_5 solution: x,y,z =", np.round(v[:3],9), " theta =", round(v[3],9),
          " row-sum:", round(Mof(v[:3])[0].sum(), 12))

# ---------------- the blow-up point itself
v = [s for s in sols if abs(s[3]-0.670820393)<1e-6][0]
M = Mof(v[:3])
P = R.pairs(n); N=len(P)
W = np.zeros((N,N))
for t,(i,j) in enumerate(P): W[t,t] = M[i,j]
res, th = R.crit_residual(n, W)
print(f"\nC_5 blow-up: theta = {th:.12f}  crit residual = {res:.2e}  dist to Weyl = {np.linalg.norm(W-R.proj_weyl(n,W)):.2e}  ||W||^2={np.tensordot(W,W,axes=2):.12f}")

# ---------------- Sym_0(R^n) basis and D_A
def sym0_basis(n):
    B=[]
    for i in range(n):
        for j in range(i+1,n):
            E=np.zeros((n,n)); E[i,j]=E[j,i]=1/np.sqrt(2); B.append(E)
    for k in range(1,n):
        d=np.zeros(n); d[:k]=1.0; d[k]=-k
        d/=np.linalg.norm(d); B.append(np.diag(d))
    return np.array(B)

S0 = sym0_basis(n)
print("dim Sym_0 =", S0.shape[0])
Bm = R.basis_mats(n)
def D_A(A):
    Cm = A @ Bm + np.einsum('sij,jk->sik', Bm, A)
    return np.array([[Cm[s,i,j] for s in range(N)] for (i,j) in P])

Hs = []
leave = []
for A in S0:
    DA = D_A(A)
    H = DA @ W + W @ DA
    H = 0.5*(H+H.T)
    Hp = R.proj_weyl(n, H)
    leave.append(np.linalg.norm(H-Hp)/np.linalg.norm(H))
    Hs.append(Hp)
leave=np.array(leave)
print(f"(a) fraction of ||H_A|| leaving Weyl_n: min={leave.min():.4f} median={np.median(leave):.4f} max={leave.max():.4f}; number with >1e-12: {(leave>1e-12).sum()} of {len(leave)}")

# ---------------- (b) compression of L_e on the projected images
lam, evec, evs, Cperp, Lm = R.lam_max_perp(n, W, th)
print(f"full-space lambda_max(L_e | W-perp) = {lam:.9f}")
w = R.coords(n,W); w/=np.linalg.norm(w)
X = np.array([R.coords(n,H) for H in Hs])          # (54, dim)
X = X - np.outer(X@w, w)                            # strip the radial direction
u,s,vt = np.linalg.svd(X, full_matrices=False)
rank = int((s>1e-9*s[0]).sum())
print("rank of the projected image inside W-perp:", rank, " singular values tail:", np.array2string(s[max(0,rank-3):rank+3], precision=4))
Vb = vt[:rank]                                      # orthonormal basis of the image
K = Vb @ Lm @ Vb.T
K = 0.5*(K+K.T)
ee = np.linalg.eigvalsh(K)
print("compression eigenvalues on the image (rounded, with multiplicity):")
vals, cnt = np.unique(np.round(ee,6), return_counts=True)
for a,b in zip(vals,cnt): print(f"    {a:.6f}  x{b}")

# generalized eigenproblem on the raw 54 directions (Gram may be singular)
G = X @ Lm @ X.T; G=0.5*(G+G.T); Sg = X @ X.T
ev2 = np.linalg.eigvalsh(np.linalg.pinv(Sg, rcond=1e-9) @ G) if False else None

# ---------------- (c) L_e invariance of the image
Pi = Vb.T @ Vb
resid = np.linalg.norm((np.eye(Lm.shape[0]) - Pi) @ Lm @ Pi)
print(f"(c) ||(I-Pi) L_e Pi|| = {resid:.6f}   (0 iff the image is L_e-invariant)")

# ---------------- torus invariants of Sym_0
Tinv = []
for k in range(n//2):
    d = np.zeros(n); d[2*k]=d[2*k+1]=1.0
    Tinv.append(np.diag(d))
Tinv = np.array(Tinv)
# trace-free part
Tinv0 = Tinv - np.trace(Tinv, axis1=1, axis2=2)[:,None,None]*np.eye(n)/n
q,_ = np.linalg.qr(Tinv0.reshape(5,-1).T)
Tb = q.T.reshape(-1,n,n)
Tb = [A for A in Tb if np.linalg.norm(A)>1e-9]
print("\ntorus-invariant Sym_0 directions:", len(Tb))
Xt=[]
for A in Tb:
    DA=D_A(A); H=DA@W+W@DA; H=0.5*(H+H.T); Hp=R.proj_weyl(n,H)
    Xt.append(R.coords(n,Hp))
Xt=np.array(Xt); Xt = Xt - np.outer(Xt@w,w)
u,s,vt=np.linalg.svd(Xt, full_matrices=False); r=int((s>1e-9*s[0]).sum())
Vt2=vt[:r]; Kt=Vt2@Lm@Vt2.T
print("torus-invariant compression eigenvalues:", np.array2string(np.linalg.eigvalsh(0.5*(Kt+Kt.T)), precision=6), " rank", r)
# and A = I
DI = D_A(np.eye(n)); HI = DI@W + W@DI
print("A=I: ||H_I - 2*theta*... ||; H_I vs W:", np.linalg.norm(HI - 4*W)/np.linalg.norm(HI), " Rayleigh:", float(np.tensordot(R.coords(n,HI), Lm@R.coords(n,HI),axes=1)/np.dot(R.coords(n,HI),R.coords(n,HI))))
