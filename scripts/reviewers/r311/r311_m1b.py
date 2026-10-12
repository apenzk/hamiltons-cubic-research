"""M1 continued: the Dimension Lemma residue over Cartan's list, the
Type II class, non-Einstein sphere products, and mixed products."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import r311_core as K
from fractions import Fraction as F

print("=== C. Dimension Lemma residue over Cartan's list (irreducible, type I and II) ===")
print("    passes  <=>  dim h <= 3 n^2 (n-1) / (2(7n-4))  =>  ||W||^2 >= 1/6")
def thr(n): return F(3*n*n*(n-1), 2*(7*n-4))
resid = []
def check(name,n,dh):
    if n < 3: return
    ok = F(dh) <= thr(n)
    if not ok: resid.append((name,n,dh))
    return ok
# type I families
for k in range(3,30):
    check(f"AI SU({k})/SO({k})", (k-1)*(k+2)//2, k*(k-1)//2)
for k in range(2,20):
    check(f"AII SU({2*k})/Sp({k})", (k-1)*(2*k+1), k*(2*k+1))
for p in range(1,20):
    for q in range(p,25):
        check(f"AIII SU({p+q})/S(U{p}xU{q})", 2*p*q, p*p+q*q-1)
        check(f"BDI SO({p+q})/SO{p}xSO{q}", p*q, p*(p-1)//2+q*(q-1)//2)
        check(f"CII Sp({p+q})/Sp{p}xSp{q}", 4*p*q, p*(2*p+1)+q*(2*q+1))
for k in range(3,25):
    check(f"DIII SO({2*k})/U({k})", k*(k-1), k*k)
    check(f"CI Sp({k})/U({k})", k*(k+1), k*k)
# exceptionals: (name, dim M, dim H)
exc = [("EI E6/Sp(4)",42,36),("EII E6/SU(6)xSU(2)",40,38),("EIII E6/SO(10)xSO(2)",32,46),
       ("EIV E6/F4",26,52),("EV E7/SU(8)",70,63),("EVI E7/SO(12)xSU(2)",64,69),
       ("EVII E7/E6xSO(2)",54,79),("EVIII E8/SO(16)",128,120),("EIX E8/E7xSU(2)",112,136),
       ("FI F4/Sp(3)xSU(2)",28,24),("FII F4/Spin(9)",16,36),("G G2/SO(4)",8,6)]
for nm,n,dh in exc: check(nm,n,dh)
# type II: G itself, n = dim g, isotropy g
for nm,dg in [("SU(2)",3),("SU(3)",8),("SU(4)",15),("SU(5)",24),("SO(5)",10),("SO(7)",21),
              ("G2",14),("F4",52),("E6",78),("E7",133),("E8",248),("Sp(2)",10),("Sp(3)",21)]:
    check("II "+nm, dg, dg)
print("    residue (fails the dimension test):")
for nm,n,dh in resid:
    print(f"      {nm:32s} n={n:4d} dim h={dh:4d}  thr={float(thr(n)):8.2f}")

print()
print("=== D. Type II (bi-invariant simple groups), built from the Lie algebra ===")
def bi_invariant(struct, n):
    """Curvature operator of a bi-invariant metric on a compact simple group,
    <R(X^Y),Z^W> = c <[X,Y],[Z,W]>, c fixed by Ric = g/2."""
    N = n*(n-1)//2
    P = [(i,j) for i in range(n) for j in range(i+1,n)]
    Rop = np.zeros((N,N))
    br = struct  # br[a,b,:] = [X_a,X_b] in the orthonormal basis
    for u,(i,j) in enumerate(P):
        for v,(k,l) in enumerate(P):
            Rop[u,v] = float(np.dot(br[i,j], br[k,l]))
    # Ric of this operator, as a curvature tensor
    T = K.op_to_tensor(n, Rop)
    Ric = K.ricci(n,T)
    c = 0.5/ (Ric[0,0])
    return c*Rop
def su(m):
    """orthonormal basis of su(m) for the metric -B/2 = -(2m)tr(XY)/2 ... we only
    need brackets in SOME orthonormal basis; normalisation is fixed afterwards."""
    B=[]
    for i in range(m):
        for j in range(i+1,m):
            A=np.zeros((m,m),complex); A[i,j]=1; A[j,i]=-1; B.append(A)
            A=np.zeros((m,m),complex); A[i,j]=1j; A[j,i]=1j; B.append(A)
    for d in range(1,m):
        A=np.zeros((m,m),complex)
        for k in range(d): A[k,k]=1j
        A[d,d]=-1j*d
        B.append(A/np.sqrt(d*(d+1)))
    B=[X/np.sqrt(-np.trace(X@X).real) for X in B]   # <X,Y> = -tr(XY)
    n=len(B)
    br=np.zeros((n,n,n))
    for a in range(n):
        for b in range(n):
            C=B[a]@B[b]-B[b]@B[a]
            for c_ in range(n):
                br[a,b,c_] = (-np.trace(C@B[c_])).real
    return br,n
for m in [2,3,4]:
    br,n = su(m)
    Rop = bi_invariant(br,n)
    W = Rop - np.eye(len(Rop))/(2*(n-1)) if n>2 else None
    nrm2=float(np.sum(W*W)); QW=K.Q(n,W)
    lam = float(np.sum(QW*W)/nrm2) if nrm2>1e-14 else float('nan')
    print(f"SU({m}) bi-invariant n={n}: ||W||^2={nrm2:.9f}  Q=lam W lam={lam:.9f} res={np.abs(QW-lam*W).max():.1e}"
          f"  theta={(0.5/np.sqrt(nrm2) if nrm2>1e-14 else float('nan')):.9f}  (record: 5/14={5/14:.9f}, sqrt(7/10)={np.sqrt(0.7):.9f})")

print()
print("=== E. non-Einstein products S^p(K1) x S^q(K2): is W a critical point? ===")
def two_sphere(p,q,K1,K2):
    n=p+q
    M=np.zeros((n,n))
    for i in range(p):
        for j in range(p):
            if i!=j: M[i,j]=K1
    for i in range(p,n):
        for j in range(p,n):
            if i!=j: M[i,j]=K2
    R=np.diag(np.array([M[i,j] for (i,j) in K.pair_list(n)]))
    return n, K.weyl_project(n,R)
p,q=4,8
n,W0 = two_sphere(p,q,1.0/(2*(p-1)),1.0/(2*(q-1)))
W0n = W0/np.linalg.norm(W0)
for r in [0.3,0.7,1.0,1.7,3.0]:
    n,W = two_sphere(p,q,1.0/(2*(p-1)), r/(2*(q-1)))
    nw = np.linalg.norm(W)
    Wn = W/nw
    cos = abs(float(np.sum(Wn*W0n)))
    QW=K.Q(n,Wn); th=float(np.sum(QW*Wn))
    print(f"  S^{p}(1) x S^{q}({r}): |W|={nw:.6f}  |<Wn,W0n>|={cos:.12f}  "
          f"criticality residual |Q-thW|={np.abs(QW-th*Wn).max():.2e} theta={th:.9f}")

print()
print("=== F. mixed products: CP^2 x S^8 (n=12), CP^2 x S^4, HP^2 x S^4 ===")
def cpm_tensor(m):
    n=2*m
    J=np.zeros((n,n))
    for a in range(m): J[2*a,2*a+1]=1.0; J[2*a+1,2*a]=-1.0
    g=np.eye(n); c=1.0/(4*(m+1))
    return n, c*(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
       + np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)+2*np.einsum('ij,kl->ijkl',J,J))
def embed(nt, blocks):
    """blocks: list of (dim, tensor R) placed on consecutive coordinate blocks."""
    R=np.zeros((nt,nt,nt,nt)); off=0
    for (d,Rb) in blocks:
        R[off:off+d,off:off+d,off:off+d,off:off+d]=Rb; off+=d
    return R
def sphere_tensor(m):
    g=np.eye(m); c=1.0/(2*(m-1))
    return m, c*(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g))
for name, parts in [("CP2 x S8",[cpm_tensor(2),sphere_tensor(8)]),
                    ("CP2 x S4",[cpm_tensor(2),sphere_tensor(4)]),
                    ("CP2 x CP2",[cpm_tensor(2),cpm_tensor(2)]),
                    ("CP3 x S6",[cpm_tensor(3),sphere_tensor(6)])]:
    nt=sum(d for d,_ in parts)
    R=embed(nt,parts); Rop=K.tensor_to_op(nt,R)
    W=Rop-np.eye(len(Rop))/(2*(nt-1))
    nrm2=float(np.sum(W*W)); QW=K.Q(nt,W); lam=float(np.sum(QW*W)/nrm2)
    f=lambda m: m/(8.0*(m-1))
    Wa=[]
    for d,Rb in parts:
        Wb=K.tensor_to_op(d,Rb)-np.eye(d*(d-1)//2)/(2*(d-1))
        Wa.append(float(np.sum(Wb*Wb)))
    pred=sum(Wa)+sum(f(d) for d,_ in parts)-nt/(8.0*(nt-1))
    print(f"  {name:10s} n={nt:3d} ||W||^2={nrm2:.9f} pred={pred:.9f} diff={nrm2-pred:+.1e}"
          f"  Q=lam W lam={lam:.9f} res={np.abs(QW-lam*W).max():.1e} theta={0.5/np.sqrt(nrm2):.9f}"
          f"  |W_a|^2={[round(x,6) for x in Wa]}")
