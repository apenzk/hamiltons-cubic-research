"""Reviewer 32: gatekeeper validation of the independent implementation."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r32_core import (planes, plane_index, struct_constants_dense,
                             struct_sparse_lists, weyl_basis, W_pq,
                             sharp_bilin_ref, circ_ref, Q_ref, bianchi_defect,
                             ricci, L_operator_sparse, L_on_weyl)

rng = np.random.default_rng(20250822)


def sym_rand(N):
    M = rng.standard_normal((N, N))
    return 0.5 * (M + M.T)


print("=== 1. dim Weyl_n against n(n+1)(n+2)(n-3)/12 ===")
for n in range(4, 11):
    B = weyl_basis(n)
    got = B.shape[1]
    want = n * (n + 1) * (n + 2) * (n - 3) // 12
    print(f"  n={n:2d}  dim={got:5d}  formula={want:5d}  {'OK' if got == want else 'MISMATCH'}")
    assert got == want

print("\n=== 2. structure constants totally antisymmetric ===")
for n in (5, 6, 7):
    c = struct_constants_dense(n)
    d1 = np.abs(c + np.transpose(c, (1, 0, 2))).max()
    d2 = np.abs(c - np.transpose(c, (1, 2, 0))).max()
    d3 = np.abs(c + np.transpose(c, (0, 2, 1))).max()
    print(f"  n={n}: swap01 {d1:.2e}  cyclic {d2:.2e}  swap12 {d3:.2e}")
    assert max(d1, d2, d3) < 1e-10

print("\n=== 3. fast sparse L operator vs reference definition ===")
for n in (5, 6, 7):
    N = n * (n - 1) // 2
    c = struct_constants_dense(n)
    lists = struct_sparse_lists(n)
    e = sym_rand(N)
    X = sym_rand(N)
    ref = circ_ref(n, e, X, c)
    Lop = L_operator_sparse(n, e, lists)
    fast = (Lop @ X.ravel()).reshape(N, N)
    print(f"  n={n}: max|fast-ref| = {np.abs(fast - ref).max():.3e}")
    assert np.abs(fast - ref).max() < 1e-9

print("\n=== 4. trilinear form <X o Y, Z> fully symmetric (Frobenius) ===")
for n in (5, 6, 7):
    c = struct_constants_dense(n)
    B = weyl_basis(n)
    N = n * (n - 1) // 2
    D = B.shape[1]

    def randweyl():
        v = rng.standard_normal(D)
        return (B @ v).reshape(N, N)
    X, Y, Z = randweyl(), randweyl(), randweyl()
    vals = []
    for (a, b, d) in [(X, Y, Z), (Y, Z, X), (Z, X, Y), (Y, X, Z), (X, Z, Y), (Z, Y, X)]:
        vals.append(np.sum(circ_ref(n, a, b, c) * d))
    print(f"  n={n}: spread over 6 orderings = {max(vals) - min(vals):.3e}  (value {vals[0]:.6f})")
    assert max(vals) - min(vals) < 1e-9 * max(1.0, abs(vals[0]))
    # unrestricted symmetric arguments too
    X, Y, Z = sym_rand(N), sym_rand(N), sym_rand(N)
    vals = [np.sum(circ_ref(n, a, b, c) * d)
            for (a, b, d) in [(X, Y, Z), (Y, Z, X), (Z, X, Y)]]
    print(f"        unrestricted symmetric: spread {max(vals)-min(vals):.3e}")
    assert max(vals) - min(vals) < 1e-9 * max(1.0, abs(vals[0]))

print("\n=== 5. Weyl_n is closed under o, and tr(L_x)=0 on Weyl_n ===")
for n in (5, 6, 7):
    lists = struct_sparse_lists(n)
    B = weyl_basis(n)
    N = n * (n - 1) // 2
    D = B.shape[1]
    v = rng.standard_normal(D)
    x = (B @ v).reshape(N, N)
    Lop = L_operator_sparse(n, x, lists)
    LB = Lop @ B                        # (N^2, D)
    proj = B @ (B.T @ LB)
    print(f"  n={n}: closure residual {np.abs(LB - proj).max():.3e}   "
          f"tr(L_x) on Weyl = {np.trace(B.T @ LB):.3e}")
    assert np.abs(LB - proj).max() < 1e-9
    assert abs(np.trace(B.T @ LB)) < 1e-8

print("\n=== 6. W_{p,q}: Weyl membership, Q(W)=theta_raw W with theta_raw=(n-1)/(pq) ===")
for (p, q) in [(2, 2), (2, 3), (2, 5), (3, 3), (3, 4), (4, 4), (3, 5), (2, 6), (4, 5)]:
    n = p + q
    if n > 9:
        continue
    c = struct_constants_dense(n)
    W = W_pq(n, p, q)
    bd = np.abs(bianchi_defect(n, W)).max()
    rc = np.abs(ricci(n, W)).max()
    QW = Q_ref(n, W, c)
    th_pred = (n - 1) / (p * q)
    res = np.abs(QW - th_pred * W).max()
    print(f"  (p,q)=({p},{q}) n={n}: Bianchi {bd:.1e}  Ricci {rc:.1e}  "
          f"|Q(W)-theta_raw W| {res:.3e}   theta_raw={th_pred}")
    assert bd < 1e-12 and rc < 1e-12 and res < 1e-12

print("\n=== 7. e = W/theta_raw: block values, L_e e = e, L_e W_hat = W_hat ===")
for (p, q) in [(2, 3), (3, 3), (3, 4), (4, 4), (2, 5)]:
    n = p + q
    if n > 9:
        continue
    c = struct_constants_dense(n)
    lists = struct_sparse_lists(n)
    N = n * (n - 1) // 2
    W = W_pq(n, p, q)
    th_raw = (n - 1) / (p * q)
    e = W / th_raw
    pi = plane_index(n)
    ePP = e[pi[(0, 1)], pi[(0, 1)]]
    eQQ = e[pi[(p, p + 1)], pi[(p, p + 1)]]
    ePQ = e[pi[(0, p)], pi[(0, p)]]
    print(f"  (p,q)=({p},{q}): eps_PP {ePP:.9f} vs {q/((p-1)*(n-1)):.9f} | "
          f"eps_QQ {eQQ:.9f} vs {p/((q-1)*(n-1)):.9f} | "
          f"eps_PQ {ePQ:.9f} vs {-1/(n-1):.9f}")
    assert abs(ePP - q / ((p - 1) * (n - 1))) < 1e-12
    assert abs(eQQ - p / ((q - 1) * (n - 1))) < 1e-12
    assert abs(ePQ + 1 / (n - 1)) < 1e-12
    Lop = L_operator_sparse(n, e, lists)
    ee = (Lop @ e.ravel()).reshape(N, N)
    print(f"      |e o e - e| = {np.abs(ee - e).max():.3e}  (idempotent)")
    assert np.abs(ee - e).max() < 1e-12
    Wh = W / np.sqrt(np.sum(W * W))
    lw = (Lop @ Wh.ravel()).reshape(N, N)
    print(f"      |L_e W_hat - 1*W_hat| = {np.abs(lw - Wh).max():.3e}")
    assert np.abs(lw - Wh).max() < 1e-12

print("\nALL GATEKEEPERS PASSED")
