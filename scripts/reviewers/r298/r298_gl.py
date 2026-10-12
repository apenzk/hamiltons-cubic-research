"""Complement to F3: the SYMMETRIC (metric-deformation) directions H_A = D_A W + W D_A,
A in Sym_0(R^n).  Delta is built from ad(v) -- SKEW directions -- and those are exactly
the ones on which every variational statement is vacuous.  Are the symmetric ones?"""
import sys, numpy as np
sys.path.insert(0,'scripts/reviewers/r298')
import r298_core as C

def D_A(n, A):
    ph = C.phi(n)
    out = np.einsum('ik,akj->aij', A, ph) + np.einsum('aik,kj->aij', ph, A)
    return 0.5*np.einsum('aij,bij->ba', ph, out)   # matrix on Lambda^2, columns a

def audit(n, W, lbl):
    W = W/np.linalg.norm(W); th = float(np.sum(W*C.Qf(n,W)))
    rng = np.random.default_rng(4); worst=0.0; vals=[]
    for t in range(6):
        A = rng.normal(size=(n,n)); A = A+A.T; A -= np.trace(A)/n*np.eye(n)
        D = D_A(n, A); H = D@W + W@D
        H = C.project_weyl(n, H)
        H = H - np.sum(H*W)*W
        if np.linalg.norm(H) < 1e-10: continue
        H /= np.linalg.norm(H)
        r = float(np.sum(H*C.circ_f(n,W,H)))/th        # Rayleigh quotient of L_e
        vals.append(r)
    print(f"  {lbl:18s} Rayleigh quotient of L_e on symmetric directions H_A: "
          + " ".join(f"{v:+.4f}" for v in vals))

for blocks in ([3,3],[3,5]):
    n=sum(blocks); audit(n, C.sphere_product(blocks), "S^"+"xS^".join(map(str,blocks)))
audit(6, C.cpm(3), "CP^3")
audit(8, C.pad(4,8,C.cpm(2)), "CP^2 padded n=8")

print("\n=== where does the VIOLATING direction live?  top eigenvector of L_e|e-perp ===")
def c5(sizes=(2,)*5):
    k=len(sizes); n=sum(sizes); P=C.pairs(n)
    G=[[1 if (abs(a-b)%k in (1,k-1)) else 0 for b in range(k)] for a in range(k)]
    lab=[]
    for bi,b in enumerate(sizes): lab+=[bi]*b
    W=np.zeros((len(P),len(P)))
    for a,(i,j) in enumerate(P):
        W[a,a]=4.0 if lab[i]==lab[j] else (-2.0 if G[lab[i]][lab[j]] else 1.0)
    return W/np.linalg.norm(W), n

def where(n, W, lbl):
    W=W/np.linalg.norm(W); th=float(np.sum(W*C.Qf(n,W))); B=C.weyl_basis(n)
    out=np.array([C.circ_f(n,W,X) for X in B])/th
    M=np.einsum('kij,lij->kl',out,B); M=0.5*(M+M.T)
    w=np.einsum('kij,ij->k',B,W)
    Pm=np.eye(len(B))-np.outer(w,w)/(w@w)
    u,s,vt=np.linalg.svd(Pm); E=vt[:len(B)-1]
    ev,U=np.linalg.eigh(E@M@E.T)
    top=E.T@U[:,-1]; V=np.einsum('k,kij->ij',top,B); V/=np.linalg.norm(V)
    # skew (orbit) span
    OT=C.orbit_tangent(n,W).reshape(-1,W.shape[0]*W.shape[1])
    us,ss,vs=np.linalg.svd(OT,full_matrices=False); rs=int((ss>1e-9*ss[0]).sum())
    fo=np.linalg.norm(vs[:rs]@V.ravel())**2
    # symmetric (metric) span
    rows=[]
    for i in range(n):
        for j in range(i,n):
            A=np.zeros((n,n)); A[i,j]=A[j,i]=1.0
            if i==j: A-=np.eye(n)/n
            D=D_A(n,A); H=C.project_weyl(n,D@W+W@D); H=H-np.sum(H*W)*W
            if np.linalg.norm(H)>1e-10: rows.append(H.ravel())
    R=np.array(rows); ur,sr,vr=np.linalg.svd(R,full_matrices=False); rr=int((sr>1e-9*sr[0]).sum())
    fs=np.linalg.norm(vr[:rr]@V.ravel())**2
    print(f"  {lbl:18s} lambda_max={ev[-1]:+.8f}  ||P_orbit v||^2={fo:.6f} (dim {rs})"
          f"   ||P_symmetric v||^2={fs:.6f} (dim {rr})")

where(6, C.cpm(3), "CP^3")
where(8, C.cpm(4), "CP^4")
Wc,nc=c5(); where(nc, Wc, "C_5 blow-up")
audit(nc, Wc, "C_5 blow-up")
