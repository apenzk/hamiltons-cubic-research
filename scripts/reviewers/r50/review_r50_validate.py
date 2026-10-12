"""Reviewer 50 validation gates, before any claim is attacked."""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r50_core as C

rng = np.random.default_rng(50)

print("--- dim Weyl_n: formula vs nullspace ---")
for n in range(4, 13):
    d = C.weyl_basis_vec(n)[0].shape[0]
    print(f"  n={n:2d}  formula={C.dim_weyl_formula(n):5d}  computed={d:5d}  {'OK' if d==C.dim_weyl_formula(n) else 'MISMATCH'}")

print("--- diagonal Q formula (independent check of #) ---")
for n in (5, 6, 7):
    pairs, idx = C.pairs_idx(n)
    N = len(pairs)
    lam = rng.normal(size=N)
    M = np.diag(lam)
    Qm = C.Q(n, M)
    worst = 0.0
    for a, (i, j) in enumerate(pairs):
        want = lam[a] ** 2 + sum(lam[idx[(min(i, k), max(i, k))]] * lam[idx[(min(j, k), max(j, k))]]
                                 for k in range(n) if k not in (i, j))
        worst = max(worst, abs(Qm[a, a] - want))
    off = np.max(np.abs(Qm - np.diag(np.diag(Qm))))
    print(f"  n={n}  diag err={worst:.2e}  offdiag={off:.2e}")

print("--- L_e W = W at sphere products (criticality) ---")
for blocks in [(3, 3), (4, 4), (5, 5), (3, 4), (6, 6)]:
    n = sum(blocks)
    W = C.sphere_product_W(blocks); W = W / np.linalg.norm(W)
    th = C.P(n, W)
    res = np.linalg.norm(C.Q(n, W) - th * W)
    e = W / th
    LW = C.circ(n, e, W)
    th0 = C.theta0(n)
    print(f"  S^{blocks[0]}xS^{blocks[1]} n={n}: theta={th:.9f} theta0={th0:.9f} ratio={th/th0:.6f} "
          f"crit_res={res:.2e} |L_eW-W|={np.linalg.norm(LW-W):.2e}")

print("--- trilinear symmetry <X o Y, Z> ---")
for n in (5, 6, 7):
    N = len(C.pairs_idx(n)[0])
    X, Y, Z = [0.5 * (lambda A: A + A.T)(rng.normal(size=(N, N))) for _ in range(3)]
    v = [float(np.tensordot(C.circ(n, a, b), c)) for a, b, c in
         [(X, Y, Z), (Y, Z, X), (Z, X, Y), (Y, X, Z), (X, Z, Y), (Z, Y, X)]]
    print(f"  n={n}: values spread={max(v)-min(v):.2e}  (val={v[0]:.6f})")

print("--- tr(L_x) = 0 ---")
for n in (5, 6, 7):
    N = len(C.pairs_idx(n)[0])
    D = N * (N + 1) // 2
    X = rng.normal(size=(N, N)); X = 0.5 * (X + X.T)
    tr = 0.0
    for k in range(D):
        v = np.zeros(D); v[k] = 1.0
        B = C.vec2mat(N, v)
        tr += float(np.dot(C.mat2vec(N, C.circ(n, X, B)), v))
    # and restricted to Weyl_n
    Bw, _ = C.weyl_basis_vec(n)
    Xw = C.vec2mat(N, Bw.T @ (Bw @ C.mat2vec(N, X)))
    trw = sum(float(np.dot(C.mat2vec(N, C.circ(n, Xw, C.vec2mat(N, b))), b)) for b in Bw)
    print(f"  n={n}: tr(L_x) on Sym^2 = {tr:.3e}   tr(L_x|Weyl) for x in Weyl = {trw:.3e}")
