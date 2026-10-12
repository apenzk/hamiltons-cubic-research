"""F2: is every orbit direction an exact 1/2-eigenvector of L_e?  What are the
hypotheses -- criticality? Weyl-ness? projection? orthogonality to e?"""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r298')
import r298_core as C

def c5(sizes=(2,)*5, diag=4.0, adjv=-2.0, nonadj=1.0):
    k=len(sizes); n=sum(sizes); P=C.pairs(n)
    G=[[1 if (abs(a-b)%k in (1,k-1)) else 0 for b in range(k)] for a in range(k)]
    lab=[]
    for bi,b in enumerate(sizes): lab+=[bi]*b
    W=np.zeros((len(P),len(P)))
    for a,(i,j) in enumerate(P):
        A_,B_=lab[i],lab[j]
        W[a,a]=diag if A_==B_ else (adjv if G[A_][B_] else nonadj)
    return W/np.linalg.norm(W), n

def audit(n, W, lbl, project=True):
    W = W / np.linalg.norm(W)
    th = float(np.sum(W*C.Qop(n,W)))
    QW = C.Qop(n,W)
    res_full = np.linalg.norm(QW - th*W)
    res_proj = np.linalg.norm(C.project_weyl(n,QW) - th*W)
    offW = np.linalg.norm(W - C.project_weyl(n,W))
    OT = C.orbit_tangent(n, W)                       # (N_so, N, N)
    F = OT.reshape(OT.shape[0], -1)
    u,s,vt = np.linalg.svd(F, full_matrices=False)
    r = int((s > 1e-9*max(1.0,s[0])).sum())
    basis = vt[:r].reshape(r, W.shape[0], W.shape[0])
    # orthogonality to e
    ortho = max(abs(float(np.sum(z*W))) for z in basis) if r else 0.0
    # L_e z  = (1/theta) W o z
    devs=[]
    for z in basis:
        Lz = C.circ(n, W, z)/th
        devs.append(np.linalg.norm(Lz - 0.5*z)/np.linalg.norm(z))
    dev = max(devs) if devs else float('nan')
    # is the orbit tangent inside Weyl_n?
    inW = max(np.linalg.norm(z - C.project_weyl(n,z))/np.linalg.norm(z) for z in basis) if r else 0.0
    print(f"  {lbl:28s} n={n:2d} th={th:+9.6f} |Q-thW|={res_full:7.1e} |PQ-thW|={res_proj:7.1e} "
          f"offW={offW:6.1e} dimO={r:3d} <z,W>={ortho:7.1e} zoffW={inW:7.1e} max|L_e z - z/2|={dev:.3e}")
    return dev

print("=== critical points in Weyl_n ===")
for blocks in ([3,3],[3,5],[5,5],[3,3,3]):
    n=sum(blocks); audit(n, C.sphere_product(blocks), f"S^"+"xS^".join(map(str,blocks)))
for m in (2,3,4): audit(2*m, C.cpm(m), f"CP^{m}")
audit(8, C.pad(4,8,C.cpm(2)), "CP^2 padded n=8")
Wc,n5=c5(); audit(n5, Wc, "C_5 blow-up n=10")

print("\n=== NON-critical Weyl tensors: does the 1/2 survive? ===")
rng=np.random.default_rng(11)
for n in (5,6):
    B=C.weyl_basis(n)
    for t in range(2):
        co=rng.normal(size=B.shape[0]); audit(n, np.einsum('k,kij->ij',co,B), f"random Weyl n={n} #{t}")

print("\n=== critical OFF Weyl_n: ascent on the FULL Sym^2(so(n)) sphere ===")
def ascend(n, W, steps=4000, lr=0.05, weyl=False):
    W=W/np.linalg.norm(W)
    for _ in range(steps):
        G=3*C.Qop(n,W)
        if weyl: G=C.project_weyl(n,G)
        G=G-np.sum(G*W)*W
        W=W+lr*G; W=W/np.linalg.norm(W)
    return W
for n in (5,6):
    N=n*(n-1)//2
    A=rng.normal(size=(N,N)); S=(A+A.T)/2
    Wf=ascend(n,S)
    audit(n, Wf, f"full-space critical n={n}")

print("\n=== Weyl-constrained ascent (projected criticality) ===")
for n in (6,):
    B=C.weyl_basis(n)
    for t in range(2):
        co=rng.normal(size=B.shape[0]); W0=np.einsum('k,kij->ij',co,B)
        audit(n, ascend(n,W0,weyl=True), f"Weyl ascent n={n} #{t}")

print("\n=== theta < 0 branch: does 1/2 still hold? ===")
for n in (6,):
    B=C.weyl_basis(n)
    co=rng.normal(size=B.shape[0]); W0=np.einsum('k,kij->ij',co,B)
    Wn=ascend(n,-W0,weyl=True)  # ascend from the negative
    audit(n, -ascend(n,W0,weyl=True), f"negated critical n={n}")
