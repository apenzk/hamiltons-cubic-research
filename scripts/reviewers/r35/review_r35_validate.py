"""Reviewer 35: gatekeeper validation of the independent rebuild."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r35_core import *

np.random.seed(35)
print("== dim Weyl_n ==")
for n in range(4, 12):
    B = weyl_basis(n)
    print(f"  n={n:2d}  built={len(B):5d}  formula={weyl_dim_formula(n):5d}  "
          f"{'OK' if len(B)==weyl_dim_formula(n) else 'MISMATCH'}")

print("== orthonormality / Bianchi / Ricci-flat of the basis ==")
for n in (6, 8):
    B = weyl_basis(n); D = len(B)
    G = np.array([[ip(X, Y) for Y in B] for X in B])
    print(f"  n={n}  |Gram-I|={np.abs(G-np.eye(D)).max():.2e}")

print("== trilinear symmetry  <X o Y, Z> ==")
for n in (5, 6, 7):
    B = weyl_basis(n)
    err = 0.0
    for _ in range(6):
        c = np.random.randn(3, len(B))
        X, Y, Z = [sum(ci*b for ci, b in zip(cc, B)) for cc in c]
        v = [ip(circ(n, X, Y), Z), ip(circ(n, Y, Z), X), ip(circ(n, Z, X), Y)]
        err = max(err, max(v) - min(v))
    print(f"  n={n}  max spread = {err:.3e}")

print("== circ closes on Weyl_n ==")
for n in (6, 7):
    B = weyl_basis(n)
    Bf = np.array([b.ravel() for b in B])
    c = np.random.randn(2, len(B))
    X, Y = [sum(ci*b for ci, b in zip(cc, B)) for cc in c]
    Z = circ(n, X, Y)
    proj = 0.5*(Bf @ Z.ravel())
    Zp = sum(pi*b for pi, b in zip(proj, B))
    print(f"  n={n}  |Z - proj Z| = {np.linalg.norm(Z-Zp):.3e}   |Z|={np.linalg.norm(Z):.3f}")

print("== sphere products: theta, criticality residual, theta_0 ==")
for (p, q) in [(3,3),(3,4),(4,4),(3,5),(5,5),(5,7),(6,6)]:
    n = p+q
    W = W_sphere_product(p, q)
    Wn, th, res = unit_and_theta(n, W)
    th0 = np.sqrt(2*(n-1)*(n-2))/n
    # Nienhaus Prop 2.25
    thkl = np.sqrt(2)*np.sqrt((p-1)/p*(q-1)/q*(n-1)/(n-2))
    print(f"  ({p},{q}) n={n:2d}  theta={th:.10f}  Prop2.25={thkl:.10f}  res={res:.2e}  theta_0={th0:.10f}")

print("== L_e W = W, tr(L_x)=0 ==")
for (p, q) in [(3,3),(3,4),(4,4),(3,5)]:
    n = p+q
    B = weyl_basis(n)
    Wn, th, res = unit_and_theta(n, W_sphere_product(p, q))
    e = Wn/th
    M = Le_matrix(n, e, B)
    Bf = np.array([b.ravel() for b in B])
    wc = 0.5*(Bf @ Wn.ravel())
    print(f"  ({p},{q}) |L_e W - W| = {np.linalg.norm(M@wc - wc):.2e}   tr(L_e)={np.trace(M):+.3e}  "
          f"|M-M^T|={np.abs(M-M.T).max():.2e}")
    # tr(L_x) = 0 for a random x
    X = sum(ci*b for ci, b in zip(np.random.randn(len(B)), B))
    print(f"        tr(L_x) random = {np.trace(Le_matrix(n, X, B)):+.3e}")
