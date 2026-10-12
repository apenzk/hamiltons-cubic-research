"""r279: checks of the support-dichotomy theorem straight from the definitions.

Uses only scripts/review_r27_core.py (an independent from-definitions build):
  <X,Y> = tr(XY) on symmetric operators on Lambda^2 R^n
  Q(W) = W^2 + W#,  X o Y = (1/2)(Q(X+Y)-Q(X)-Q(Y)),  P(W) = <W,Q(W)>.
"""
import os, sys
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..'))
import review_r27_core as C

rng = np.random.default_rng(279)

def wb(n):
    return C.weyl_basis(n)

def rand_weyl(n, k=1):
    B = wb(n)
    out = []
    for _ in range(k):
        a = rng.standard_normal(B.shape[0])
        W = np.einsum('i,ijk->jk', a, B)
        out.append(W / np.sqrt(np.trace(W @ W)))
    return out

def T3(n, X, Y, Z):
    return float(np.trace(X @ C.circ(n, Y, Z)))

print("=== 1. full symmetry of T(X,Y,Z)=<X, Y o Z>, and P(W)=T(W,W,W) ===")
for n in (5, 6, 7):
    X, Y, Z = rand_weyl(n, 3)
    vals = [T3(n, X, Y, Z), T3(n, Y, X, Z), T3(n, Z, Y, X), T3(n, X, Z, Y)]
    print(f"  n={n}: spread over the 4 orderings = {max(vals)-min(vals):.3e}, "
          f"P(X)-T(X,X,X) = {C.P(n,X)-T3(n,X,X,X):.3e}")

print()
print("=== 2. padding: Weyl_{n0} -> Weyl_n preserves norm, P, Q ===")
def pad(n0, n, W):
    pr0, idx0, _ = C.struct(n0)
    pr, idx, _ = C.struct(n)
    N = len(pr)
    out = np.zeros((N, N))
    for a, p in enumerate(pr0):
        for b, q in enumerate(pr0):
            out[idx[p], idx[q]] = W[a, b]
    return out
for (n0, n) in ((4, 6), (5, 7), (6, 8)):
    W = rand_weyl(n0, 1)[0]
    Wp = pad(n0, n, W)
    # is it still Weyl?
    Cm, tidx, T = C.weyl_constraints(n)
    res = np.linalg.norm(Cm @ C.vec_scaled(Wp, tidx, T))
    print(f"  {n0}->{n}: Weyl residual {res:.2e}, |norm diff| "
          f"{abs(np.trace(Wp@Wp)-np.trace(W@W)):.2e}, |P diff| {abs(C.P(n,Wp)-C.P(n0,W)):.2e}, "
          f"|Q-padQ| {np.abs(C.Q(n,Wp)-pad(n0,n,C.Q(n0,W))).max():.2e}")

print()
print("=== 3. Weyl_4 = Lambda^+ + Lambda^-: circ-orthogonal, P additive ===")
n = 4
B = wb(4)
print(f"  dim Weyl_4 = {B.shape[0]}")
# Hodge star on Lambda^2 R^4 in the basis (01,02,03,12,13,23)
pr, idx, _ = C.struct(4)
star = np.zeros((6, 6))
comp = {(0,1):((2,3),1.0), (0,2):((1,3),-1.0), (0,3):((1,2),1.0),
        (1,2):((0,3),1.0), (1,3):((0,2),-1.0), (2,3):((0,1),1.0)}
for p,(q,s) in comp.items():
    star[idx[p], idx[q]] = s
Pp = 0.5*(np.eye(6)+star); Pm = 0.5*(np.eye(6)-star)
W = rand_weyl(4,1)[0]
Wp_, Wm_ = Pp@W@Pp, Pm@W@Pm
print(f"  W - (W+ + W-) = {np.abs(W-Wp_-Wm_).max():.2e}   (so Weyl_4 splits)")
print(f"  ||W+ o W-||   = {np.linalg.norm(C.circ(4,Wp_,Wm_)):.2e}")
print(f"  P(W)-P(W+)-P(W-) = {C.P(4,W)-C.P(4,Wp_)-C.P(4,Wm_):.2e}")

print()
print("=== 4. THE ONE-LINE BOUND vs the harmonic-square law ===")
# build a genuine circ-orthogonal maximiser-shaped split at n=4: A = CP2 piece in Lambda^+,
# B = same in Lambda^-.  Each is critical of unit norm.
def cp2_half(Proj):
    # trace-free symmetric on the 3-dim self-dual space, spectrum (2,-1,-1)/sqrt6
    u, s, _ = np.linalg.svd(Proj)
    E = u[:, s > 0.5]          # 6x3 orthonormal basis of the eigenspace
    d = np.diag([2, -1, -1]) / np.sqrt(6.0)
    return E @ d @ E.T
A = cp2_half(Pp); Bm = cp2_half(Pm)
for (nm, X) in (("A", A), ("B", Bm)):
    th = C.P(4, X)
    r = np.linalg.norm(C.Q(4, X) - th*X)
    print(f"  {nm}: ||X||^2={np.trace(X@X):.12f}  theta={th:.12f}  criticality residual={r:.2e}")
print(f"  A o B = {np.linalg.norm(C.circ(4,A,Bm)):.2e}")
for a in (0.5, 1/np.sqrt(2), 0.8):
    b = np.sqrt(1-a*a)
    Wab = a*A + b*Bm
    print(f"   a={a:.4f} b={b:.4f}: P={C.P(4,Wab):.9f}   "
          f"a^3+b^3={a**3+b**3:.9f} times theta_A={(a**3+b**3)*C.P(4,A):.9f}   "
          f"critical? residual={np.linalg.norm(C.Q(4,Wab)-C.P(4,Wab)*Wab):.2e}")

print()
print("=== 5. the saddle direction: every circ-summand is an E(1) eigenvector of L_e ===")
a = b = 1/np.sqrt(2.0)
W = a*A + b*Bm
th = C.P(4, W)
e = W/th
H = b*A - a*Bm                      # unit, orthogonal to W, in the span of the pieces
LeH = C.circ(4, e, H)
print(f"  theta={th:.12f}, ||H||^2={np.trace(H@H):.12f}")
print(f"  ||L_e H - H|| = {np.linalg.norm(LeH-H):.2e}   (eigenvalue 1, against the max-condition bound 1/2)")
print(f"  Hess = 6 theta (L_e - 1/2) on H = {6*th*(float(np.trace(H@LeH))-0.5*np.trace(H@H)):.12f}"
      f"   vs 3 theta ||H||^2 = {3*th*np.trace(H@H):.12f}")
