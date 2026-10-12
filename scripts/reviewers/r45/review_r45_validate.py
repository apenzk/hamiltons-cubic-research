"""Reviewer 45, phase 2: gatekeepers on the independent implementation."""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r45_core import (struct, weyl_basis, Qop, circ, sharp, sharp_bilin,
                             sphere_product, pad, theta_and_residual,
                             orbit_tangent, Le_matrix, slack, pairs_of)

rng = np.random.default_rng(45)

print("=== G1: dim Weyl_n vs n(n+1)(n+2)(n-3)/12 ===", flush=True)
Bs = {}
for n in range(4, 13):
    t = time.time()
    B = weyl_basis(n)
    Bs[n] = B
    want = n * (n + 1) * (n + 2) * (n - 3) // 12
    print(f"  n={n:3d}  D={B.shape[0]:5d}  formula={want:5d}  "
          f"{'OK' if B.shape[0]==want else 'MISMATCH'}   ({time.time()-t:.1f}s)",
          flush=True)

print("\n=== G2: sharp/# conventions ===", flush=True)
for n in (5, 6):
    A = struct(n)
    N = A.shape[0]
    X = rng.standard_normal((N, N)); X = X + X.T
    Y = rng.standard_normal((N, N)); Y = Y + Y.T
    print(f"  n={n}: sharp_bilin(X,X)-X^# = "
          f"{np.abs(sharp_bilin(X, X, A) - sharp(X, A)).max():.2e}")
    print(f"  n={n}: sharp_bilin symmetric in args = "
          f"{np.abs(sharp_bilin(X, Y, A) - sharp_bilin(Y, X, A)).max():.2e}")
    print(f"  n={n}: (X#) symmetric matrix = "
          f"{np.abs(sharp(X, A) - sharp(X, A).T).max():.2e}")
    # round sphere control: R = Id has R^# = (n-2) Id  (classical)
    I = np.eye(N)
    sh = sharp(I, A)
    print(f"  n={n}: Id^# = {sh[0,0]:.6f} * Id  (classical (n-2)={n-2}), "
          f"offdiag {np.abs(sh - np.diag(np.diag(sh))).max():.2e}")

print("\n=== G3: full symmetry of the trilinear form <X o Y, Z> ===", flush=True)
for n in (5, 6, 8):
    A = struct(n)
    N = A.shape[0]
    def sym(a, b):
        return a + b.T if False else None
    M = [rng.standard_normal((N, N)) for _ in range(3)]
    M = [m + m.T for m in M]
    X, Y, Z = M
    t1 = np.tensordot(circ(X, Y, A), Z)
    t2 = np.tensordot(circ(Y, Z, A), X)
    t3 = np.tensordot(circ(Z, X, A), Y)
    print(f"  n={n}: T(X,Y,Z) = {t1:.9f} {t2:.9f} {t3:.9f}   "
          f"spread {max(abs(t1-t2), abs(t2-t3)):.2e}")

print("\n=== G4: known critical points, L_e W = W, tr(L_x)=0 ===", flush=True)
for (k, l, n) in [(3, 3, 6), (2, 4, 6), (4, 4, 8), (3, 5, 8), (5, 5, 10)]:
    A = struct(n)
    B = Bs[n].reshape(Bs[n].shape[0], -1)
    W = sphere_product(k, l, n)
    # confirm it already lies in Weyl_n (projection is a no-op)
    Pw = (B @ W.reshape(-1)) @ B
    dev = np.linalg.norm(Pw - W.reshape(-1))
    W = W / np.linalg.norm(W)
    th, res = theta_and_residual(W, A)
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    e = W / th
    LeW = circ(e, W, A)
    print(f"  S^{k}xS^{l} n={n}: proj-devi={dev:.2e}  theta={th:.9f}  "
          f"(theta_0={th0:.9f})  resid={res:.2e}  ||L_e W - W||={np.linalg.norm(LeW-W):.2e}")

print("\n  tr(L_x) = 0 on Weyl_n for random x in Weyl_n:", flush=True)
for n in (6, 8):
    A = struct(n)
    B = Bs[n].reshape(Bs[n].shape[0], -1)
    x = (rng.standard_normal(B.shape[0]) @ B).reshape(A.shape[0], A.shape[0])
    L = Le_matrix(B, x, A)
    print(f"  n={n}: tr(L_x) = {np.trace(L):.3e}   ||x||={np.linalg.norm(x):.3f}")
    # Fox Killing constant kappa_F(n) = (2n-1)(n-1)/4 at a critical point
    W = sphere_product(n // 2, n - n // 2, n)
    W /= np.linalg.norm(W)
    th, _ = theta_and_residual(W, A)
    LW = Le_matrix(B, W, A)
    print(f"     tr(L_W^2) = {np.trace(LW@LW):.9f}  vs (2n-1)(n-1)/4 = "
          f"{(2*n-1)*(n-1)/4:.9f}")

print("\n=== G5: slack S at controls ===", flush=True)
for (k, l, n) in [(3, 3, 6), (2, 4, 6), (4, 4, 8)]:
    A = struct(n)
    W = sphere_product(k, l, n); W /= np.linalg.norm(W)
    print(f"  S^{k}xS^{l} n={n}: S = {slack(W, A):.3e}")
# ungraded control: 3-block product (S=0 iff k<=2 blocks)
def three_block(n, sizes):
    ps, idx = pairs_of(n)
    N = len(ps)
    lab = []
    for b, s in enumerate(sizes):
        lab += [b] * s
    th_n = n
    M = np.zeros((N, N))
    # vertex solution from FINDINGS: w_ab = -1/(n-1) offdiag,
    # w_aa = (n-n_a)/((n-1)(n_a-1))
    for p, (i, j) in enumerate(ps):
        a, b = lab[i], lab[j]
        if a == b:
            M[p, p] = (n - sizes[a]) / ((n - 1.0) * (sizes[a] - 1.0))
        else:
            M[p, p] = -1.0 / (n - 1.0)
    return M
A6 = struct(6)
W3 = three_block(6, [2, 2, 2]); W3 /= np.linalg.norm(W3)
th, res = theta_and_residual(W3, A6)
print(f"  (S^2)^3 n=6: theta={th:.9f} resid={res:.2e} S = {slack(W3, A6):.6f}  "
      f"(expect S>0, ungraded)")
A9 = struct(9)
W3 = three_block(9, [3, 3, 3]); W3 /= np.linalg.norm(W3)
th, res = theta_and_residual(W3, A9)
S9 = slack(W3, A9)
# closed form from FINDINGS: S = 3 theta^2 e_3 / (n-1)^2
print(f"  (S^3)^3 n=9: theta={th:.9f} resid={res:.2e} S = {S9:.6f}  "
      f"closed form 3*th^2*e3/(n-1)^2 = {3*th*th*27/64:.6f}")
