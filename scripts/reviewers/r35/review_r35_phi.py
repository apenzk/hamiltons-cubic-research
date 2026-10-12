"""Reviewer 35 / M4: PROVING  L_e V = 0  for V in Weyl_p embedded in Weyl_n.

Reduction (derived by hand, checked here).  Write the sphere-product operator as
W = a Pi_P + b Pi_Q + c Pi_M on Lambda^2(R^n), with Pi_P/Pi_Q/Pi_M the projections
onto Lambda^2(R^p), Lambda^2(R^q), R^p (x) R^q.  Let V in Weyl_p, i.e. V is
supported on Lambda^2(R^p) and is Bianchi + Ricci-flat there.  Then

  (1/2)(WV+VW) = a V,

and a block-by-block trace analysis kills every block of sharp_bilin(W,V) except
the PP and MM blocks, on which

  sharp_bilin(W,V)|_PP = -(a/2) Phi(V)|_PP ,   sharp_bilin(W,V)|_MM = -(c/2) Phi(V)|_MM ,
  Phi(V)_{ab} := (1/2) tr( (A_a A_b + A_b A_a) V ).

So  W o V = 0  for every V in Weyl_p  <==>  Phi(V) = 2V  on Weyl_p (embedded).

Phi is O(n)-equivariant and symmetric, and Weyl_n is an irreducible O(n)-summand
of S^2(Lambda^2 R^n), so Schur forces Phi|_{Weyl_n} = lambda_n Id.  This script
(i) measures lambda_n, (ii) checks Phi on the other three O(n)-summands, and
(iii) verifies the block reduction directly.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r35_core import *
np.random.seed(3535)

def Phi(n, V):
    A = adjoints(n); N = A.shape[0]
    # Phi_ab = 1/2 tr(A_a A_b V + A_b A_a V) ; tr(A_a A_b V) = sum_{c,d}(A_a)_{cd}(A_b V)_{dc}
    AbV = A @ V                                     # AbV[b] = A_b V
    M = A.reshape(N, -1) @ np.transpose(AbV, (0, 2, 1)).reshape(N, -1).T
    return 0.5 * (M + M.T)

print("== Phi on Weyl_n is a scalar (Schur) ==")
for n in range(5, 12):
    B = weyl_basis(n); D = len(B)
    lams = []
    for _ in range(3):
        V = sum(ci*b for ci, b in zip(np.random.randn(D), B))
        P = Phi(n, V)
        lams.append(ip(P, V)/ip(V, V))
        dev = np.linalg.norm(P - lams[-1]*V)/np.linalg.norm(V)
    print(f"  n={n:2d}  lambda = {np.mean(lams):.12f}  (spread {np.ptp(lams):.1e})  "
          f"|Phi(V)-lam V|/|V| = {dev:.2e}")

print("\n== Phi on the other O(n)-summands of S^2(Lambda^2) ==")
for n in (6, 8):
    N = n*(n-1)//2
    P_, idx = pairs_of(n)
    # trivial: Id
    I = np.eye(N); print(f"  n={n}  Id      -> lambda = {ip(Phi(n,I),I)/ip(I,I):+.6f}")
    # S^2_0(R^n) type:  h wedge id  for traceless symmetric h
    h = np.random.randn(n, n); h = h+h.T; h -= np.trace(h)/n*np.eye(n)
    Hw = np.zeros((N, N))
    for a, (i, j) in enumerate(P_):
        for b, (k, l) in enumerate(P_):
            # (h ^ id)(e_i^e_j, e_k^e_l) = h_ik d_jl + h_jl d_ik - h_il d_jk - h_jk d_il
            Hw[a, b] = (h[i,k]*(j==l) + h[j,l]*(i==k) - h[i,l]*(j==k) - h[j,k]*(i==l))
    print(f"  n={n}  h^id    -> lambda = {ip(Phi(n,Hw),Hw)/ip(Hw,Hw):+.6f}  "
          f"|dev|={np.linalg.norm(Phi(n,Hw)-ip(Phi(n,Hw),Hw)/ip(Hw,Hw)*Hw)/np.linalg.norm(Hw):.1e}")
    # Lambda^4 type: a purely antisymmetric-Bianchi operator, built by projection
    Xr = np.random.randn(N, N); Xr = Xr + Xr.T
    # project out Weyl, S^2_0-type and trivial by Gram-Schmidt against them
    Bw = weyl_basis(n)
    for b in Bw:  Xr -= ip(Xr, b)*b/ip(b, b)
    Xr -= ip(Xr, I)*I/ip(I, I)
    # S^2_0 wedge block: build a full basis of it
    basH = []
    for i in range(n):
        for j in range(i, n):
            hh = np.zeros((n, n)); hh[i, j] += 1; hh[j, i] += 1
            hh -= np.trace(hh)/n*np.eye(n)
            if np.abs(hh).max() < 1e-12: continue
            HW = np.zeros((N, N))
            for a, (ii, jj) in enumerate(P_):
                for bb, (k, l) in enumerate(P_):
                    HW[a, bb] = (hh[ii,k]*(jj==l) + hh[jj,l]*(ii==k)
                                 - hh[ii,l]*(jj==k) - hh[jj,k]*(ii==l))
            basH.append(HW)
    # orthonormalise basH then project
    for HW in basH:
        nn = ip(HW, HW)
        if nn > 1e-12: Xr -= ip(Xr, HW)*HW/nn
    for HW in basH:
        nn = ip(HW, HW)
        if nn > 1e-12: Xr -= ip(Xr, HW)*HW/nn
    print(f"  n={n}  Lam^4   -> lambda = {ip(Phi(n,Xr),Xr)/ip(Xr,Xr):+.6f}  "
          f"|dev|={np.linalg.norm(Phi(n,Xr)-ip(Phi(n,Xr),Xr)/ip(Xr,Xr)*Xr)/np.linalg.norm(Xr):.1e}"
          f"   |Xr|={np.linalg.norm(Xr):.3f}")

print("\n== the block reduction, checked directly:  W o V for V in Weyl_p ==")
for (p, q) in [(3,4),(4,4),(3,5),(4,5),(5,5),(5,6),(4,7),(6,6)]:
    n = p+q
    Bn = weyl_basis(n); Bp = weyl_basis(p)
    if not Bp:
        print(f"  ({p},{q}): Weyl_{p} = 0, nothing to check"); continue
    Pn, idxn = pairs_of(n); Pp, idxp = pairs_of(p)
    W = W_sphere_product(p, q); Wn, th, _ = unit_and_theta(n, W); e = Wn/th
    a = 1.0/(p*(p-1)); c = -1.0/(p*q)
    worst = 0.0; worstPhi = 0.0
    for Vp in Bp[:min(8, len(Bp))]:
        V = np.zeros((len(Pn), len(Pn)))
        for aa, pr in enumerate(Pp):
            for bb, pr2 in enumerate(Pp):
                V[idxn[pr], idxn[pr2]] = Vp[aa, bb]
        worst = max(worst, np.linalg.norm(circ(n, e, V))/np.linalg.norm(V))
        worstPhi = max(worstPhi, np.linalg.norm(Phi(n, V) - 2*V)/np.linalg.norm(V))
    print(f"  ({p},{q}) n={n}: max |e o V|/|V| = {worst:.2e}   max |Phi(V)-2V|/|V| = {worstPhi:.2e}")
