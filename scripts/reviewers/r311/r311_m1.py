"""M1: Lemma 69.  Independent rebuild of every quantity."""
import numpy as np, sys, os, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import r311_core as K

def diag_op(n, M):
    return np.diag(np.array([M[i,j] for (i,j) in K.pair_list(n)]))

def sphere_product(ns):
    """Killing-normalised product of round spheres: each factor S^m has
    sec = 1/(2(m-1)), Ric = g/2, so the product is Einstein with constant 1/2."""
    n = sum(ns)
    M = np.zeros((n,n))
    off = 0
    for m in ns:
        for i in range(off, off+m):
            for j in range(off, off+m):
                if i!=j: M[i,j] = 1.0/(2*(m-1))
        off += m
    R = diag_op(n, M)
    W = R - np.eye(len(R))/(2*(n-1))
    return n, W

def report(name, n, W):
    nrm2 = float(np.sum(W*W))
    QW = K.Q(n,W)
    # criticality Q(W) = lam W
    lam = float(np.sum(QW*W)/nrm2)
    res = np.abs(QW - lam*W).max()
    inW = np.abs(W - K.weyl_project(n,W)).max()
    Wn = W/np.sqrt(nrm2)
    theta = float(np.sum(K.Q(n,Wn)*Wn))
    print(f"{name:16s} n={n:3d} |W|^2={nrm2:.9f}  Q(W)=lam*W lam={lam:.9f} res={res:.2e}"
          f"  inWeyl={inW:.1e}  theta={theta:.9f}  0.5/|W|={0.5/np.sqrt(nrm2):.9f}")
    return nrm2, theta

def f(m): return m/(8.0*(m-1))

print("=== A. sphere products: |W|^2 formula and Q(W)=W/2 ===")
for ns in [(3,5),(5,5),(5,7),(6,6),(4,8),(3,3,3),(4,4,4),(2,10),(3,9),(4,6),(2,4)]:
    n,W = sphere_product(ns)
    nrm2, theta = report("S"+"xS".join(str(x) for x in ns), n, W)
    pred = sum(f(m) for m in ns) - n/(8.0*(n-1))
    print(f"    partition formula sum f(n_a) - n/(8(n-1)) = {pred:.12f}  diff {nrm2-pred:+.2e}")

print()
print("=== B. CP^m, Killing-normalised (Ric = g/2) ===")
def cpm(m):
    n = 2*m
    J = np.zeros((n,n))
    for a in range(m):
        J[2*a,2*a+1] = 1.0; J[2*a+1,2*a] = -1.0
    g = np.eye(n)
    c = 1.0/(4*(m+1))          # Ric = 2c(m+1) g  ->  c = 1/(4(m+1)) gives Ric = g/2
    R = c*(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
           + np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
           + 2*np.einsum('ij,kl->ijkl',J,J))
    return n, R
for m in [2,3,4]:
    n,R = cpm(m)
    Rop = K.tensor_to_op(n,R)
    Ric = K.ricci(n,R)
    W = Rop - np.eye(len(Rop))/(2*(n-1))
    print(f"CP^{m}: Ric = {np.diag(Ric)[:3]} (want 0.5) ; R eigs {np.round(np.linalg.eigvalsh(Rop),6)[-4:]}")
    report(f"CP^{m}", n, W)
    print(f"    closed form 3m(m-1)/(4(m+1)(2m-1)) = {3*m*(m-1)/(4.0*(m+1)*(2*m-1)):.9f}")
