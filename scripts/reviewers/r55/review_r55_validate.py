"""Reviewer 55, phase 1: validate the independent core before using it."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *

def sphere_product(blocks):
    """Weyl operator of a product of round spheres, as a vertex matrix (diagonal)."""
    n = sum(blocks)
    lab = sum([[a] * b for a, b in enumerate(blocks)], [])
    lam = np.zeros((n, n))
    # within-block value x_a, cross-block value y: solve Ricci-flatness
    # standard: sphere product Weyl has w_ij = a_ab depending on blocks only.
    # take the ansatz w = alpha_a on same block, beta on different, and solve
    # row sums = 0 with the criticality; easiest: use the known 2-block form.
    return lab, lam

def main():
    print("=== struct constants vs explicit commutators ===")
    for n in (5, 6, 8, 10):
        print(f"  n={n}: max|c - c_explicit| = {check_struct(n):.2e}")

    print("=== dim Weyl_n ===")
    for n in (5, 6, 7, 8, 9, 10, 11, 12):
        B = weyl_basis(n)
        print(f"  n={n:2d}: dim = {B.shape[0]:5d}   formula = {dim_weyl(n):5d}   "
              f"{'OK' if B.shape[0]==dim_weyl(n) else 'MISMATCH'}")

    print("=== sharp: fast vs direct einsum ===")
    for n in (5, 6, 7):
        rng = np.random.default_rng(n)
        N = n*(n-1)//2
        X = rng.normal(size=(N, N)); X = X + X.T
        print(f"  n={n}: max diff = {np.abs(sharp(n,X)-sharp_slow(n,X)).max():.2e}")

    print("=== Weyl basis really lands in Weyl_n (Q preserves it) ===")
    n = 8
    B = weyl_basis(n); rng = np.random.default_rng(0)
    c = rng.normal(size=B.shape[0]); X = np.einsum('d,dij->ij', c, B)
    Bf = B.reshape(B.shape[0], -1)
    QX = Q(n, X)
    resid = QX.ravel() - Bf.T @ (Bf @ QX.ravel())
    print(f"  n={n}: ||Q(X) - Pi_Weyl Q(X)|| = {np.linalg.norm(resid):.2e}")

    print("=== trilinear symmetry T(X,Y,Z) = <X, Y o Z> ===")
    n = 7; N = n*(n-1)//2; rng = np.random.default_rng(1)
    Xs = []
    for k in range(3):
        M = rng.normal(size=(N,N)); Xs.append(M+M.T)
    X, Y, Z = Xs
    vals = [float(np.tensordot(X, circ(n,Y,Z))), float(np.tensordot(Y, circ(n,X,Z))),
            float(np.tensordot(Z, circ(n,X,Y)))]
    print(f"  values = {vals},  spread = {max(vals)-min(vals):.2e}")

    print("=== tr(L_x) = 0 ===")
    for n in (5, 6, 7):
        N = n*(n-1)//2; rng = np.random.default_rng(n)
        M = rng.normal(size=(N,N)); X = M+M.T
        # L_x on the full Sym^2(Lambda^2)
        sym = [(a,b) for a in range(N) for b in range(a,N)]
        tr = 0.0
        for (a,b) in sym:
            E = np.zeros((N,N)); E[a,b]=1.0; E[b,a]=1.0
            nrm = np.sqrt(2.0) if a!=b else 1.0
            E = E/nrm
            tr += float(np.tensordot(E, circ(n,X,E)))
        print(f"  n={n}: tr(L_x) on Sym^2 = {tr:.2e}")
        # and on Weyl_n
        B = weyl_basis(n)
        trW = sum(float(np.tensordot(b, circ(n,X,b))) for b in B)
        print(f"        tr(L_x) on Weyl_{n} = {trW:.2e}")

if __name__ == "__main__":
    t=time.time(); main(); print(f"[{time.time()-t:.1f}s]")
