"""Reviewer 35 / M4: the four zero eigenvalues, structurally.

Two lemmas and one experiment.
  L1.  Id o V = 0 for every V in Weyl_n            (from Phi(V) = 2V)
  L2.  W o V = 0 for every V in Weyl_p (padded)    (block reduction + Phi(V)=2V)
  E.   the explicit Nienhaus element of X_p (x) R^q, and whether its eigenvalue 0
       needs criticality or holds for every three-block diagonal W = a Pi_P + b Pi_Q + c Pi_M.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r35_core import *
np.random.seed(3599)

def three_block(p, q, a, b, c):
    n = p+q; P, idx = pairs_of(n)
    d = np.zeros(len(P))
    for k, (i, j) in enumerate(P):
        d[k] = a if j < p else (b if i >= p else c)
    return np.diag(d)

def Xelem(p, q, i, j, k, aq):
    """Nienhaus's  e_i^e_j (x) e_k + e_i^e_k (x) e_j  in X_p, tensored with f_aq in R^q."""
    n = p+q; P, idx = pairs_of(n); N = len(P)
    V = np.zeros((N, N))
    def put(u, v, s):
        V[u, v] += s; V[v, u] += s
    A = idx[tuple(sorted((i, j)))]; B = idx[tuple(sorted((k, p+aq)))]
    C = idx[tuple(sorted((i, k)))]; Dd = idx[tuple(sorted((j, p+aq)))]
    put(A, B, 1.0); put(C, Dd, 1.0)
    return V

print("== L1: Id o V = 0 on Weyl_n ==")
for n in (5, 6, 7, 8, 9):
    B = weyl_basis(n); N = n*(n-1)//2
    w = max(np.linalg.norm(circ(n, np.eye(N), V))/np.linalg.norm(V) for V in B[:12])
    print(f"  n={n}: max |Id o V|/|V| = {w:.2e}")

print("\n== the explicit X_p (x) R^q element: is it in Weyl_n, and in ker L_e? ==")
for (p, q) in [(3,3),(3,4),(4,4),(3,5),(4,5),(5,5),(5,6),(4,7),(6,6)]:
    n = p+q
    V = Xelem(p, q, 0, 1, 2, 0)
    Bn = weyl_basis(n); Bf = np.array([b.ravel() for b in Bn])
    proj = 0.5*(Bf @ V.ravel())
    Vp = sum(c*b for c, b in zip(proj, Bn))
    inweyl = np.linalg.norm(V - Vp)/np.linalg.norm(V)
    Wn, th, _ = unit_and_theta(n, W_sphere_product(p, q)); e = Wn/th
    z = np.linalg.norm(circ(n, e, V))/np.linalg.norm(V)
    # does it need criticality?  random three-block diagonal W
    worst = 0.0
    for _ in range(5):
        a, b, c = np.random.randn(3)
        Wr = three_block(p, q, a, b, c)
        worst = max(worst, np.linalg.norm(circ(n, Wr, V))/np.linalg.norm(V)/max(abs(a),abs(b),abs(c)))
    print(f"  ({p},{q}): V in Weyl_n? dev={inweyl:.1e}   |e o V|/|V| = {z:.2e}   "
          f"generic (a,b,c): max |W o V|/|V| = {worst:.3f}")

print("\n== does L_e V = 0 on Weyl_p need criticality? ==")
for (p, q) in [(4,4),(4,5),(5,5),(5,6)]:
    n = p+q
    Bp = weyl_basis(p); Pn, idxn = pairs_of(n); Pp, idxp = pairs_of(p)
    V = np.zeros((len(Pn), len(Pn)))
    Vp = Bp[0]
    for aa, pr in enumerate(Pp):
        for bb, pr2 in enumerate(Pp):
            V[idxn[pr], idxn[pr2]] = Vp[aa, bb]
    out = []
    for _ in range(4):
        a, b, c = np.random.randn(3)
        out.append(np.linalg.norm(circ(n, three_block(p,q,a,b,c), V))/np.linalg.norm(V))
    print(f"  ({p},{q}): |W(a,b,c) o V|/|V| for random (a,b,c) = {['%.2e'%x for x in out]}")

print("\n== and for the other summands: is the eigenvalue criticality-dependent? ==")
for (p, q) in [(4,5),(5,6)]:
    n = p+q
    Bn = weyl_basis(n)
    Wn, th, _ = unit_and_theta(n, W_sphere_product(p, q)); e = Wn/th
    L = Le_matrix(n, e, Bn)
    ev, U = np.linalg.eigh(0.5*(L+L.T))
    mu = (n-2)/(2*(p-1)*(q-1))
    for lab, val in [("L2(x)L2 (+mu)", mu), ("S0(x)S0 (-mu)", -mu)]:
        sel = np.abs(ev-val) < 1e-9
        E = U[:, sel]
        v = sum(cc*b for cc, b in zip(E[:, 0], Bn))
        rows = []
        for _ in range(3):
            a, b, c = np.random.randn(3)
            Wr = three_block(p, q, a, b, c)
            Z = circ(n, Wr, v)
            r = ip(Z, v)/ip(v, v)
            rows.append(np.linalg.norm(Z - r*v)/np.linalg.norm(v))
        print(f"  ({p},{q}) {lab:16s}: still an eigenvector for generic (a,b,c)? "
              f"residuals {['%.2e'%x for x in rows]}")
