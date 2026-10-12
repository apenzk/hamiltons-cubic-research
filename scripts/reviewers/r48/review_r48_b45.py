"""B4/B5: what the decomposability bound actually rests on."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r48_core import *

def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_pol(n, X, Y)

print("=== (1) direct-sum saddle lemma: Hess_P(H) = +3 theta |H|^2 exactly ===", flush=True)
print("    (H = |W_2|^2 W_1 - |W_1|^2 W_2; second derivative along the great circle)", flush=True)
FOX4 = fox_point(4)
tests = [("Fox+Fox n=8", 4, FOX4, 4, FOX4, 8),
         ("Fox+S^3xS^3 n=10", 4, FOX4, 6, sphere_product((3, 3)), 10),
         ("S^4xS^4+S^3xS^3 n=14", 8, sphere_product((4, 4)), 6, sphere_product((3, 3)), 14),
         ("Fox+S^5xS^5 n=14", 4, FOX4, 10, sphere_product((5, 5)), 14)]
for lbl, nA, WA, nB, WB, n in tests:
    thA, thB = P(nA, WA), P(nB, WB)
    th = 1 / np.sqrt(1 / thA**2 + 1 / thB**2)
    W1 = (th / thA) * pad(nA, WA, n, 0); W2 = (th / thB) * pad(nB, WB, n, nA)
    W = W1 + W2
    c1, c2 = np.sum(W1 * W1), np.sum(W2 * W2)
    H = c2 * W1 - c1 * W2
    H = H / nrm(H)
    # exact geodesic second derivative
    f = lambda t: P(n, np.cos(t) * W + np.sin(t) * H)
    h = 1e-4
    num = (f(h) - 2 * f(0) + f(-h)) / h**2
    ana = 6 * np.sum(H * circ(n, W, H)) - 3 * P(n, W)
    print(f"  {lbl:22s} <W,H>={np.sum(W*H):+.1e} Hess_num={num:+.9f} Hess_exact={ana:+.9f} "
          f"3*theta={3*P(n,W):+.9f}  -> {'SADDLE' if ana>1e-9 else 'not positive'}", flush=True)

print("\n=== (2) does anything in Weyl_n, n<=11, beat sqrt(3/2)? (gradient ascent) ===", flush=True)
def ascend(n, rng, starts=40, iters=1500):
    B = weyl_basis(n); d = B.shape[0]
    best = -9; bestW = None
    for s in range(starts):
        c = rng.standard_normal(d); W = np.einsum('k,kij->ij', c, B); W /= nrm(W)
        step = 0.4
        for it in range(iters):
            Qm = Q(n, W)
            th = float(np.sum(W * Qm))
            g = Qm - th * W
            gn = np.linalg.norm(g)
            if gn < 1e-14: break
            Wn = W + step * g / max(gn, 1e-12)
            Wn /= nrm(Wn)
            if P(n, Wn) < P(n, W):
                step *= 0.5
                if step < 1e-14: break
            else:
                W = Wn
        v = P(n, W)
        if v > best: best, bestW = v, W
    return best, bestW

rng = np.random.default_rng(48)
t0 = time.time()
for n in (4, 5, 6, 7, 8, 9, 10, 11):
    st = 40 if n <= 9 else 15
    b, Wb = ascend(n, rng, starts=st)
    res = np.linalg.norm(Q(n, Wb) - P(n, Wb) * Wb)
    print(f"  n={n:2d} dim={weyl_basis(n).shape[0]:5d} starts={st:3d} best theta={b:.9f}  "
          f"sqrt(3/2)={np.sqrt(1.5):.9f}  theta_0(n)={theta0(n):.9f}  res={res:.1e}  "
          f"({time.time()-t0:.0f}s)", flush=True)

print("\n=== (3) the bound when a block has n_i >= 12 (theta_0(n_i) > sqrt(3/2)) ===", flush=True)
def M(m):
    """conjectured max theta in Weyl_m: sqrt(3/2) for m<=11, theta_0(m) for m>=12."""
    return 0.0 if m <= 3 else max(np.sqrt(1.5), theta0(m)) if m >= 12 else np.sqrt(1.5)
print(f"  {'n':>4} {'theta_0(n)':>11} {'worst 2-block':>14} {'split':>10} {'worst k-block':>14} "
      f"{'sqrt(3)/2 valid?':>17}", flush=True)
for n in (8, 12, 14, 16, 20, 24, 30, 40, 60, 100):
    worst = 0; arg = None
    for n1 in range(4, n - 3):
        n2 = n - n1
        if n2 < 4: continue
        v = 1 / np.sqrt(1 / M(n1)**2 + 1 / M(n2)**2)
        if v > worst: worst, arg = v, (n1, n2)
    # k blocks: more blocks only lowers theta, so 2 is worst
    ok = "yes" if worst <= np.sqrt(3) / 2 + 1e-12 else "NO"
    print(f"  {n:4d} {theta0(n):11.6f} {worst:14.6f} {str(arg):>10} {worst:14.6f} {ok:>17}", flush=True)

print("\n=== (4) padded critical points: indecomposable, theta frozen, close to the top ===", flush=True)
for n in (8, 10, 12, 14, 16, 20):
    Wp = pad(4, FOX4, n)
    print(f"  Fox padded to n={n:2d}: theta={P(n,Wp):.9f}  theta_0(n)={theta0(n):.9f}  "
          f"ratio={P(n,Wp)/theta0(n):.6f}  crit_res={np.linalg.norm(Q(n,Wp)-P(n,Wp)*Wp):.1e}", flush=True)
print(f"\n  block-sum cap sqrt(3)/2 as a fraction of theta_0(12): "
      f"{(np.sqrt(3)/2)/theta0(12):.6f}   (FINDINGS says the law caps theta/theta_0 at 0.89 for n=12)", flush=True)
