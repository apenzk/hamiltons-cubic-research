"""Phase 3: validate the independent machinery before attacking anything."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r48_core import *

t0 = time.time()
print("== dim Weyl_n vs n(n+1)(n+2)(n-3)/12 ==", flush=True)
for n in (4, 5, 6, 7, 8, 9, 10):
    f = n * (n + 1) * (n + 2) * (n - 3) // 12
    d = weyl_dim(n)
    print(f"  n={n:2d} formula={f:5d} computed={d:5d} {'OK' if f == d else 'MISMATCH'}", flush=True)

print("\n== structure constants: total antisymmetry, tr(A_a)=0, A_a antisym ==", flush=True)
for n in (4, 6, 8):
    c = cconst(n)
    a1 = abs(c + np.transpose(c, (1, 0, 2))).max()
    a2 = abs(c + np.transpose(c, (0, 2, 1))).max()
    a3 = abs(c - np.transpose(c, (2, 0, 1))).max()
    tr = abs(np.einsum('amm->a', c)).max()
    print(f"  n={n}: antisym(ab)={a1:.1e} antisym(mn)={a2:.1e} cyclic={a3:.1e} tr(A_a)={tr:.1e}", flush=True)

print("\n== named critical points: Weyl membership, Q(W)=theta W, theta value ==", flush=True)
cases = []
for n in (6, 8, 10, 12):
    cases.append((f"S^{n//2}xS^{n//2}", n, sphere_product((n // 2, n // 2)), theta0(n)))
cases.append(("S^2xS^4", 6, sphere_product((2, 4)), np.sqrt(2) * np.sqrt(0.5 * (3 / 4) * (5 / 4))))
cases.append(("S^3xS^5", 8, sphere_product((3, 5)), np.sqrt(2) * np.sqrt((2 / 3) * (4 / 5) * (7 / 6))))
for n in (4, 6, 8, 10, 12):
    cases.append((f"Fox pad n={n}", n, fox_point(n), np.sqrt(1.5)))
for lbl, n, W, pred in cases:
    th = P(n, W)
    res = abs(Q(n, W) - th * W).max()
    ok = is_weyl(n, W)
    print(f"  {lbl:16s} n={n:2d} |W|={nrm(W):.12f} theta={th:.12f} pred={pred:.12f} "
          f"crit_res={res:.1e} weyl={ok}", flush=True)

print("\n== trilinear symmetry of T(X,Y,Z)=<X, circ(Y,Z)> ==", flush=True)
rng = np.random.default_rng(0)
for n in (5, 6, 7):
    N = len(pairs_of(n)[0])
    def circ(X, Y):
        return 0.5 * (X @ Y + Y @ X) + sharp_pol(n, X, Y)
    X, Y, Z = [(lambda M: M + M.T)(rng.standard_normal((N, N))) for _ in range(3)]
    t1 = np.sum(X * circ(Y, Z)); t2 = np.sum(Y * circ(X, Z)); t3 = np.sum(Z * circ(X, Y))
    print(f"  n={n}: {t1:.10f} {t2:.10f} {t3:.10f} spread={max(abs(t1-t2),abs(t1-t3)):.1e}", flush=True)

print("\n== L_e W = W at a critical point (e = W/theta, L_X Y = 2 circ(X,Y)) ==", flush=True)
for lbl, n, W, pred in [("S^3xS^3", 6, sphere_product((3, 3)), 0), ("Fox n=8", 8, fox_point(8), 0),
                        ("S^5xS^5", 10, sphere_product((5, 5)), 0)]:
    th = P(n, W); e = W / th
    LeW = 2 * (0.5 * (e @ W + W @ e) + sharp_pol(n, e, W))
    print(f"  {lbl:10s} max|L_e W - W| = {abs(LeW - W).max():.2e}", flush=True)

print("\n== diagonal cross-check: <W#,W> = 1/2 tr(Lambda^3) for coordinate-diagonal W ==", flush=True)
for blocks in [(3, 3), (2, 4), (4, 4), (3, 5), (2, 2, 4)]:
    n = sum(blocks); W = sphere_product(blocks)
    Pp, idx = pairs_of(n)
    Lam = np.zeros((n, n))
    for a, (i, j) in enumerate(Pp):
        Lam[i, j] = Lam[j, i] = W[a, a]
    lhs = np.sum(sharp(n, W) * W); rhs = 0.5 * np.trace(Lam @ Lam @ Lam)
    print(f"  blocks={blocks} <W#,W>={lhs:.12f} 1/2 tr(L^3)={rhs:.12f} diff={abs(lhs-rhs):.1e}", flush=True)
print(f"\nelapsed {time.time()-t0:.1f}s")
