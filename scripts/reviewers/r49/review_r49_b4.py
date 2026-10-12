"""Reviewer 49 phases P4/P5 -- B3 and B4.

B3: theta < min_i theta_i strictly; k equal blocks give theta_1/sqrt(k).
B4: the hypothesis "theta_i <= sqrt(3/2), known unconditionally for n_i <= 11",
    what happens once a block carries n_i >= 12, and whether the coincidence with
    the Fox plateau is meaningful.
"""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C

SQ32 = np.sqrt(1.5)
SQ3_2 = np.sqrt(3) / 2
th0 = lambda n: np.sqrt(2 * (n - 1) * (n - 2)) / n


# ---------- B3 ----------
print("=== B3: strictness and the k-equal-blocks law ===", flush=True)
for k in (2, 3, 4, 5, 6):
    n = 4 * k
    if n > 16:
        pred = SQ32 / np.sqrt(k)
        print(f"  k={k} Fox blocks, n={n}: predicted {pred:.9f} = sqrt(3/2)/sqrt({k}) "
              f"(too large to verify directly)", flush=True)
        continue
    W = sum(C.embed(C.fox_cp2(4), 4, n, tuple(range(4 * i, 4 * i + 4))) for i in range(k))
    W = C.normalize(W)
    res, th = C.crit_residual(n, W)
    print(f"  k={k} Fox blocks, n={n}: measured {th:.12f}  sqrt(3/2)/sqrt(k) = "
          f"{SQ32/np.sqrt(k):.12f}  resid {res:.1e}  theta<min_i theta_i: {th < SQ32}", flush=True)

# ---------- B4 part 1: max P at small n by ascent ----------
print("\n=== B4(i): is max P <= sqrt(3/2) at n <= 11? unconstrained ascent ===", flush=True)


def ascent(n, B, x0, iters=4000):
    """power iteration on the unit sphere of Weyl_n in coordinates; Q is Weyl-preserving."""
    x = x0 / np.linalg.norm(x0)
    prev = -1e9
    for it in range(iters):
        W = np.einsum('k,kij->ij', x, B)
        QW = C.Qmap(n, W)
        g = np.einsum('kij,ij->k', B, QW)
        val = float(x @ g)
        # gradient ascent with shift to keep the map monotone on the sphere
        y = g + 2.0 * abs(val) * x + 1e-12 * x
        ny = np.linalg.norm(y)
        if ny < 1e-14:
            break
        x = y / ny
        if abs(val - prev) < 1e-15:
            break
        prev = val
    W = np.einsum('k,kij->ij', x, B)
    r, t = C.crit_residual(n, W)
    return t, r, x


rng = np.random.default_rng(490049)
summary = []
for n in range(4, 12):
    t0 = time.time()
    B = C.weyl_basis(n)
    d = B.shape[0]
    nstart = 400 if d <= 300 else (150 if d <= 800 else 60)
    best, bres = -1e9, None
    vals = []
    for s in range(nstart):
        t, r, x = ascent(n, B, rng.standard_normal(d))
        vals.append(t)
        if t > best:
            best, bres = t, r
    vals = np.array(vals)
    top = np.sort(vals)[-6:]
    summary.append((n, d, best, bres))
    print(f"  n={n:2d} dim={d:5d} starts={nstart:4d}  max theta = {best:.9f} (resid {bres:.1e})  "
          f"sqrt(3/2)={SQ32:.9f}  excess={best-SQ32:+.2e}  theta_0(n)={th0(n):.6f}  "
          f"top values {np.array2string(top, precision=6)}  [{time.time()-t0:.0f}s]", flush=True)

# ---------- B4 part 2: blocks with n_i >= 12 ----------
print("\n=== B4(ii): a decomposable critical point above sqrt(3)/2, n = 16 ===", flush=True)
n = 16
WA = C.normalize(C.sphere_product((6, 6)))
WB = C.fox_cp2(4)
tA = C.Pval(12, WA); tB = C.Pval(4, WB)
pred = 1.0 / np.sqrt(1 / tA**2 + 1 / tB**2)
W = (pred / tA) * C.embed(WA, 12, n, tuple(range(12))) + \
    (pred / tB) * C.embed(WB, 4, n, (12, 13, 14, 15))
W = C.normalize(W)
res, th = C.crit_residual(n, W)
print(f"  blocks: S^6xS^6 on 12 coords (theta_A = {tA:.9f} = theta_0(12)) "
      f"+ W_CP2 on 4 coords (theta_B = {tB:.9f})", flush=True)
print(f"  predicted {pred:.12f}   measured {th:.12f}   crit resid {res:.1e}", flush=True)
print(f"  |Ricci| = {np.abs(C.ricci(n,W)).max():.1e}   |Bianchi| = {np.abs(C.bianchi(n,W)).max():.1e}"
      f"   (so it lies in Weyl_16)", flush=True)
print(f"  sqrt(3)/2 = {SQ3_2:.12f};  EXCESS = {th - SQ3_2:+.9f}  -> the claimed bound is violated",
      flush=True)

print("\n=== B4(iii): the decomposable ceiling D(n) with the true block maxima ===", flush=True)
print("  m(k) = sqrt(3/2) for 4<=k<=11 (the presumed low-dim max), theta_0(k) for k>=12", flush=True)


def m(k):
    return SQ32 if k <= 11 else max(SQ32, th0(k))


def D(n):
    best, arg = 0.0, None
    for a in range(4, n - 3):
        b = n - a
        if b < 4:
            continue
        v = 1.0 / np.sqrt(1 / m(a)**2 + 1 / m(b)**2)
        if v > best:
            best, arg = v, (a, b)
    return best, arg


print(f"{'n':>4} {'D(n)':>12} {'split':>10} {'sqrt(3)/2':>11} {'theta_0(n)':>11} {'D/theta_0':>10}", flush=True)
for n in [8, 12, 14, 15, 16, 18, 20, 24, 30, 40, 60, 100, 400]:
    v, a = D(n)
    print(f"{n:4d} {v:12.9f} {str(a):>10} {SQ3_2:11.6f} {th0(n):11.6f} {v/th0(n):10.6f}", flush=True)
print(f"  sup over n of D(n) = {1/np.sqrt(2*0.5):.6f} (both blocks large: theta_i -> sqrt2)", flush=True)

print("\n=== B4(iv): is the Fox plateau a block sum of two sqrt(3/2) points? ===", flush=True)
for n in (8, 10, 12):
    P1 = C.embed(C.fox_cp2(4), 4, n, (0, 1, 2, 3))
    P2 = C.embed(C.fox_cp2(4), 4, n, (4, 5, 6, 7))
    Wp = C.normalize(P1 + P2)
    res, th = C.crit_residual(n, Wp)
    print(f"  n={n}: (W1+W2)/sqrt2 on disjoint 4-blocks -> theta = {th:.12f}, "
          f"sqrt(3)/2 = {SQ3_2:.12f}, diff {abs(th-SQ3_2):.1e}, resid {res:.1e}", flush=True)
print("  so sqrt(3/2)/sqrt(2) IS the law evaluated at that very point, not an independent check.",
      flush=True)
