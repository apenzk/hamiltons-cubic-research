"""Reviewer 56 -- validation gates before any claim is tested."""
import numpy as np, sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
from review_r56_core import *

print("=== gate 1: dim Weyl_n = n(n+1)(n+2)(n-3)/12 ===")
for n in (4, 5, 6, 7, 8):
    idx, pos, N, c, basis = weyl_basis(n)
    want = n * (n + 1) * (n + 2) * (n - 3) // 12
    G = np.array([[np.sum(a * b) for b in basis] for a in basis])
    print(f"  n={n}: dim={len(basis):5d}  formula={want:5d}  "
          f"orthonormal_err={np.abs(G-np.eye(len(basis))).max():.1e}  "
          f"{'OK' if len(basis)==want else 'MISMATCH'}")
    # membership check
    rng = np.random.default_rng(0)
    v = sum(rng.normal() * b for b in basis)
    print(f"        random member: ||Ric||={np.linalg.norm(ricci(v,idx,n)):.1e} "
          f" ||Bianchi||={np.linalg.norm(bianchi(v,idx,n)):.1e}")

print()
print("=== gate 2: kappa, Q(Id), Q preserves Weyl, trilinear symmetry, tr(L_x)=0 ===")
for n in (5, 6, 7, 8):
    idx, pos, N, c, basis = weyl_basis(n)
    kap = float(np.sum(c[0] ** 2))
    Id = np.eye(N)
    QI = Q(Id, c)
    rng = np.random.default_rng(1)
    X = sum(rng.normal() * b for b in basis)
    Y = sum(rng.normal() * b for b in basis)
    Z = sum(rng.normal() * b for b in basis)
    QX = Q(X, c)
    ricQ = np.linalg.norm(ricci(QX, idx, n))
    biQ = np.linalg.norm(bianchi(QX, idx, n))
    t1 = np.sum(X * bil(Y, Z, c)); t2 = np.sum(Y * bil(X, Z, c)); t3 = np.sum(Z * bil(X, Y, c))
    # tr(L_X) over Weyl_n
    trL = sum(float(np.sum(b * bil(X, b, c))) for b in basis)
    print(f"  n={n}: kappa={kap:.6f} (2(n-2)={2*(n-2)})   Q(Id)/Id={QI[0,0]:.6f} (n-1={n-1})")
    print(f"        Q(X) in Weyl: ||Ric||={ricQ:.1e} ||Bianchi||={biQ:.1e}")
    print(f"        trilinear symmetry spread={max(abs(t1-t2),abs(t1-t3)):.1e}   tr(L_X)={trL:.3e}")

print()
print("=== gate 3: L_e W = W at a known critical point (e = W/theta) ===")
for n in (6, 8, 10):
    idx, pos, N, c, basis = weyl_basis(n) if n <= 8 else (None,)*5
    if idx is None:
        idx, pos, N, c = struct(n)
        basis = None
    m = n // 2
    lab = [0]*m + [1]*(n-m)
    R = np.zeros((N, N))
    for a, (i, j) in enumerate(idx):
        R[a, a] = 1.0 if lab[i] == lab[j] else 0.0
    T = tensor4(R, idx, n)
    # Weyl-project by hand: subtract kn(h) with h chosen to kill Ricci, then normalise
    M = mat_from_tensor4(T, idx)
    ric = ricci(M, idx, n)
    h = (ric - np.trace(ric)/(2*(n-1))*np.eye(n)) / (n - 2)
    W = M - mat_from_tensor4(kn(h, n), idx)
    W = W / np.linalg.norm(W)
    th, res = theta_res(W, c)
    e = W / th
    LeW = bil(e, W, c)
    print(f"  n={n}: S^{m}xS^{n-m}  theta={th:.9f}  theta_0={theta0(n):.9f}  "
          f"crit_res={res:.1e}  ||Ric||={np.linalg.norm(ricci(W,idx,n)):.1e}  "
          f"||L_e W - W||={np.linalg.norm(LeW-W):.1e}")
