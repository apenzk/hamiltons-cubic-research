"""G1's reach: canonical subspaces at the C_5 blow-up, and the orbit component (G5)."""
import sys; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C
rng=np.random.default_rng(11)

W,n = C.c5_blowup(); W=W/np.linalg.norm(W)
th=float(np.tensordot(W,C.Q(n,W))); e=W/th
B=C.weyl_basis(n); D=len(B)
M,_=C.Le_matrix(n,e)
w=C.to_coords(n,W); w/=np.linalg.norm(w)
Pp=np.eye(D)-np.outer(w,w); Mp=Pp@M@Pp
ev,U=np.linalg.eigh(Mp)
lam=ev[-1]; top=U[:,np.abs(ev-lam)<1e-8]
print(f"C5: theta={th:.9f} lambda_max={lam:.9f} mult={top.shape[1]} dim={D}")
print(f"    spectrum >1/2+1e-9 count = {int(np.sum(ev>0.5+1e-9))}, sum of those = {float(ev[ev>0.5+1e-9].sum()):.4f}")

# ---- G5: orbit component of the top eigenvectors
O = C.orbit_tangent(n,W)
Oc = np.einsum('kij,mij->km', O, B)
Uo,_ = C.orth_rows(Oc)
print(f"    dim orbit = {len(Uo)};  ||P_orbit v|| for the top eigenvectors: "
      f"{[f'{np.linalg.norm(Uo@top[:,i]):.2e}' for i in range(top.shape[1])]}")
# and P rising along it
for i in range(top.shape[1]):
    v = np.einsum('k,kij->ij', top[:,i], B)
    ts=1e-3
    Xp=(W+ts*v)/np.linalg.norm(W+ts*v)
    print(f"    (P(W+tv)-theta)/t^2 = {(C.P(n,Xp)-th)/ts**2:.6f}   3 theta (lam-1/2) = {3*th*(lam-0.5):.6f}")

# ---- canonical subspaces
S0=C.sym0_basis(n)
def stats(coords, label):
    Ub,_ = C.orth_rows(coords)
    if len(Ub)==0: return
    Mv=Ub@M@Ub.T; Mv=0.5*(Mv+Mv.T); evv=np.linalg.eigvalsh(Mv)
    print(f"    {label:34s} dim={len(Ub):3d}  tr/dim={float(np.trace(Mv))/len(Ub):+.6f}  lam_max={evv[-1]:.6f}")

def HAcoords(As):
    HA=np.array([C.D_A(n,A)@W + W@C.D_A(n,A) for A in As])
    co=np.einsum('kij,mij->km',HA,B)
    return co - np.outer(co@w,w)

lab=[]
for bi in range(5): lab+=[bi]*2
lab=np.array(lab)
diag=[A for A in S0 if np.allclose(A-np.diag(np.diag(A)),0)]
off =[A for A in S0 if np.allclose(np.diag(np.diag(A)),0)]
inblk=[A for A in S0 if all(abs(A[i,j])<1e-12 for i in range(n) for j in range(n) if lab[i]!=lab[j])]
xblk =[A for A in S0 if all(abs(A[i,j])<1e-12 for i in range(n) for j in range(n) if lab[i]==lab[j])]
adjA =[A for A in S0 if all(abs(A[i,j])<1e-12 for i in range(n) for j in range(n)
        if not (lab[i]!=lab[j] and (abs(lab[i]-lab[j])%5 in (1,4))))]
nonadjA=[A for A in S0 if all(abs(A[i,j])<1e-12 for i in range(n) for j in range(n)
        if not (lab[i]!=lab[j] and (abs(lab[i]-lab[j])%5 in (2,3))))]
print("\n  canonical subspaces at the C_5 blow-up (target: tr/dim > 1/2)")
stats(HAcoords(S0),          "V = all Sym_0 (the record's V)")
stats(HAcoords(diag),        "A diagonal traceless")
stats(HAcoords(off),         "A off-diagonal")
stats(HAcoords(inblk),       "A supported inside blocks")
stats(HAcoords(xblk),        "A supported across blocks")
stats(HAcoords(adjA),        "A on C_5-adjacent block pairs")
stats(HAcoords(nonadjA),     "A on C_5-non-adjacent block pairs")
# skew analogue: the orbit itself
stats(Oc - np.outer(Oc@w,w), "orbit tangent (skew directions)")
# Sym^2(m): m = negative eigenspace of W
evW,UW=np.linalg.eigh(W)
m=UW[:,evW<-1e-9]; p=UW[:,evW>1e-9]
def sym2(sub):
    out=[]
    for a in range(sub.shape[1]):
        for b in range(a,sub.shape[1]):
            E=np.outer(sub[:,a],sub[:,b]); E=0.5*(E+E.T); out.append(E)
    return np.array(out)
for nm,sub in (("Sym^2(m), m = W-negative",m),("Sym^2(p), p = W-positive",p)):
    co=np.einsum('kij,mij->km',sym2(sub),B); co=co-np.outer(co@w,w)
    stats(co, nm)
print(f"    (dim m = {m.shape[1]}, dim p = {p.shape[1]}, N = {B.shape[1]})")
# random subspaces of matching dimension, as a control
for d in (54,15,2):
    best=-9
    for _ in range(40):
        Z=rng.standard_normal((d,D)); Z=Z-np.outer(Z@w,w)
        Ub,_=C.orth_rows(Z); Mv=Ub@M@Ub.T
        best=max(best,float(np.trace(Mv))/len(Ub))
    print(f"    best of 40 RANDOM dim-{d} subspaces: tr/dim = {best:+.6f}")
