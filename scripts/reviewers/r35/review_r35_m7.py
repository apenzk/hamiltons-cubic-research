"""Reviewer 35 / M3, M7: the (3,3) merge dissected, and the O(p)xO(q) refinement.

Tests:
 (a) is L_e really O(p)xO(q)-equivariant (reflections included, not just so(p)+so(q))?
 (b) at (3,3), is the 18-dim block really  R^3(x)R^3 (+) Lambda^2(x)Lambda^2  with the
     two pieces ISOMORPHIC as SO(3)xSO(3)-modules?  and are they isomorphic under
     O(3)xO(3)?
 (c) does the SO(3)xSO(3)-isomorphism explain the eigenvalue 1/2, or is the eigenvalue
     an independent coincidence?
"""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r35_core import *
np.random.seed(357)

def Lam2(g):
    n = g.shape[0]; P, idx = pairs_of(n); N = len(P)
    M = np.empty((N, N))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            M[a, b] = g[i, k]*g[j, l] - g[i, l]*g[j, k]
    return M

def act_on_weyl(n, B, g):
    """matrix of X -> (Lam2 g) X (Lam2 g)^T on the Weyl basis"""
    Lg = Lam2(g); D = len(B); Bf = np.array([b.ravel() for b in B])
    M = np.empty((D, D))
    for c, X in enumerate(B):
        Z = Lg @ X @ Lg.T
        M[:, c] = 0.5*(Bf @ Z.ravel())
    return M

def refl(n, i):
    g = np.eye(n); g[i, i] = -1.0; return g

print("== (a) equivariance of L_e under the FULL O(p)xO(q), reflections included ==")
for (p, q) in [(3,3),(3,4),(4,4),(3,5),(4,5),(5,5)]:
    n = p+q; B = weyl_basis(n)
    Wn, th, _ = unit_and_theta(n, W_sphere_product(p, q)); e = Wn/th
    L = Le_matrix(n, e, B)
    worst_rot = 0.0; worst_ref = 0.0; worst_inv = 0.0
    gens = []
    # random rotations inside each factor
    for _ in range(4):
        A1 = np.random.randn(p, p); A1 -= A1.T
        A2 = np.random.randn(q, q); A2 -= A2.T
        from scipy.linalg import expm
        g = np.zeros((n, n)); g[:p, :p] = expm(A1); g[p:, p:] = expm(A2)
        gens.append(('rot', g))
    for i in [0, p]:                      # a reflection in each factor
        gens.append(('refl', refl(n, i)))
    gens.append(('refl-both', refl(n, 0) @ refl(n, p)))
    if p == q:
        sw = np.zeros((n, n))
        for i in range(p): sw[i, p+i] = 1.0; sw[p+i, i] = 1.0
        gens.append(('swap', sw))
    for kind, g in gens:
        Mg = act_on_weyl(n, B, g)
        d = np.abs(Mg @ L - L @ Mg).max()
        # also: is e itself invariant?
        Lg = Lam2(g); di = np.abs(Lg @ e @ Lg.T - e).max()
        if kind == 'rot': worst_rot = max(worst_rot, d)
        elif kind == 'swap': worst_inv = max(worst_inv, d)
        else: worst_ref = max(worst_ref, d)
        assert di < 1e-12, (p, q, kind, di)
    print(f"  ({p},{q}) |[g,L_e]| rot {worst_rot:.2e}  refl {worst_ref:.2e}"
          + (f"  swap {worst_inv:.2e}" if p == q else "")
          + "   (e invariant under all of them, dev<1e-12)")

print("\n== (b),(c) the (3,3) 18-dimensional 1/2-eigenspace ==")
p = q = 3; n = 6
B = weyl_basis(n); D = len(B)
Wn, th, _ = unit_and_theta(n, W_sphere_product(p, q)); e = Wn/th
L = Le_matrix(n, e, B)
ev, U = np.linalg.eigh(0.5*(L+L.T))
sel = np.abs(ev-0.5) < 1e-9
E = U[:, sel]
print(f"  dim E(1/2) = {E.shape[1]}")

# the orbit tangent: [A_v, W] for v in R^p (x) R^q
Pn, idx = pairs_of(n)
A = adjoints(n)
Bf = np.array([b.ravel() for b in B])
orb = []
for (i, j) in Pn:
    if i < p <= j:
        a = idx[(i, j)]
        Z = A[a] @ Wn - Wn @ A[a]
        orb.append(0.5*(Bf @ Z.ravel()))
O = np.array(orb).T
uo, so, _ = np.linalg.svd(O, full_matrices=False)
rk = int((so > 1e-10).sum())
O = uo[:, :rk]
print(f"  orbit tangent dim = {rk}   inside E(1/2)? residual = "
      f"{np.linalg.norm(O - E@(E.T@O)):.2e}")

# the complement of the orbit inside E(1/2)
Cc = E - O @ (O.T @ E)
uc, sc, _ = np.linalg.svd(Cc, full_matrices=False)
C = uc[:, sc > 1e-8]
print(f"  complement dim = {C.shape[1]}")

def char_on(sub, g):
    Mg = act_on_weyl(n, B, g)
    return float(np.trace(sub.T @ Mg @ sub))

for name, g in [("refl in P (det1=-1)", refl(n,0)),
                ("refl in Q (det2=-1)", refl(n,3)),
                ("both (det1det2=+1)", refl(n,0)@refl(n,3))]:
    Mg = act_on_weyl(n, B, g)
    print(f"  {name:24s}: preserves E(1/2)? {np.linalg.norm(Mg@E - E@(E.T@Mg@E)):.1e}"
          f"   preserves orbit? {np.linalg.norm(Mg@O - O@(O.T@Mg@O)):.1e}"
          f"   chi(orbit)={char_on(O,g):+.4f}  chi(compl)={char_on(C,g):+.4f}")

print("\n  => under SO(3)xSO(3) the two 9-dim pieces have equal characters on rotations;")
print("     a reflection with det=-1 in ONE factor separates them (characters differ in sign),")
print("     so under O(3)xO(3) they are NON-isomorphic, yet both still carry L_e = 1/2.")

# is the eigenvalue on the complement predicted by mu?
lamC = float(np.trace(C.T @ L @ C)/C.shape[1])
print(f"  L_e on the complement = {lamC:.12f} ;  mu=(n-2)/(2(p-1)(q-1)) = {(n-2)/(2*(p-1)*(q-1)):.12f}")

print("\n== (c') does mu = 1/2 happen anywhere else?  scan p,q in [2,60] ==")
hits = [(a,b) for a in range(2,61) for b in range(a,61) if abs((a+b-2)/(2*(a-1)*(b-1)) - 0.5) < 1e-12]
print("  mu == 1/2 exactly at:", hits)
hits2 = [(a,b) for a in range(3,61) for b in range(a,61) if (a+b-2)/(2*(a-1)*(b-1)) > 0.5]
print("  mu > 1/2 with p,q>=3 :", hits2 if hits2 else "none")
hits3 = [(a,b) for a in range(2,61) for b in range(a,61) if (a+b-2)/(2*(a-1)*(b-1)) > 0.5]
print("  mu > 1/2 allowing p=2:", hits3[:12], "...")

print("\n== (b2) SO(3)xSO(3)-characters of the two 9-dim pieces at (3,3) ==")
from scipy.linalg import expm
diffs = []
for _ in range(6):
    A1 = np.random.randn(3,3); A1 -= A1.T
    A2 = np.random.randn(3,3); A2 -= A2.T
    g = np.zeros((6,6)); g[:3,:3] = expm(A1); g[3:,3:] = expm(A2)
    diffs.append(abs(char_on(O, g) - char_on(C, g)))
print(f"   max |chi_orbit(g) - chi_compl(g)| over 6 random rotations = {max(diffs):.2e}")
print("   => equal characters on the identity component: the two ARE isomorphic as")
print("      SO(3)xSO(3)-modules (Lambda^2 R^3 = R^3), but the det-twist separates them over O(3)xO(3).")
