"""B2/B3: the harmonic-square law, at block sums NOT on the record's list of five,
plus the degenerate cases (padding, k>=3, unequal dims, decomposable blocks,
theta_i = 0, theta_i < 0)."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r48_core import *

def emb(n, W0, n0, off):
    return pad(n0, W0, n, off)

def build(blocks, n=None, weights=None):
    """blocks = list of (label, n_i, W_i unit critical).  Returns W, theta_pred, offsets."""
    tot = sum(b[1] for b in blocks)
    n = n or tot
    ths = [P(b[1], b[2]) for b in blocks]
    th = 1.0 / np.sqrt(sum(1 / t**2 for t in ths))
    W = np.zeros((n * (n - 1) // 2,) * 2)
    off = 0
    for (lbl, ni, Wi), ti in zip(blocks, ths):
        W = W + (th / ti) * emb(n, Wi, ni, off)
        off += ni
    return W, th, ths

def report(name, blocks, n=None):
    W, th_pred, ths = build(blocks, n)
    nn = n or sum(b[1] for b in blocks)
    nrmW = nrm(W)
    th = P(nn, W)
    res = abs(Q(nn, W) - th * W).max()
    print(f"  {name:34s} n={nn:2d} |W|-1={nrmW-1:+.1e} theta={th:.12f} "
          f"pred={th_pred:.12f} d={abs(th-th_pred):.1e} res={res:.1e} weyl={is_weyl(nn,W)}"
          f"  thetas={[round(t,6) for t in ths]}", flush=True)
    return th, th_pred

FOX4 = fox_point(4)
S33 = sphere_product((3, 3)); S44 = sphere_product((4, 4)); S55 = sphere_product((5, 5))
S22 = sphere_product((2, 2)); S24 = sphere_product((2, 4)); S26 = sphere_product((2, 6))
print("=== held-out two-block sums (none on the recorded list of five) ===", flush=True)
report("Fox4 + Fox4", [("F", 4, FOX4), ("F", 4, FOX4)])
report("Fox4 + S^3xS^3", [("F", 4, FOX4), ("S", 6, S33)])
report("Fox4 + S^5xS^5", [("F", 4, FOX4), ("S", 10, S55)])
report("S^4xS^4 + S^4xS^4", [("A", 8, S44), ("B", 8, S44)])
report("S^2xS^2 + S^2xS^2", [("A", 4, S22), ("B", 4, S22)])
report("S^2xS^2 + S^2xS^6", [("A", 4, S22), ("B", 8, sphere_product((2, 6)))])
report("Fox4 + S^2xS^2 (unequal)", [("F", 4, FOX4), ("S", 4, S22)])
rng = np.random.default_rng(7)

print("\n=== ambient dimension exceeding the union (padding on top of a block sum) ===", flush=True)
for extra in (1, 2, 4):
    report(f"Fox4+Fox4 padded +{extra}", [("F", 4, FOX4), ("F", 4, FOX4)], n=8 + extra)

print("\n=== three and four blocks ===", flush=True)
report("Fox x3", [("F", 4, FOX4)] * 3)
report("Fox x4", [("F", 4, FOX4)] * 4)
report("S^3xS^3 x3", [("S", 6, S33)] * 3)
report("Fox + S^3xS^3 + S^4xS^4", [("F", 4, FOX4), ("A", 6, S33), ("B", 8, S44)])

print("\n=== blocks that are themselves decomposable (associativity) ===", flush=True)
W2, th2, _ = build([("F", 4, FOX4), ("F", 4, FOX4)])
W2 = W2 / nrm(W2)
print(f"  2-block Fox plateau as a block: theta={P(8,W2):.12f}", flush=True)
report("(Fox+Fox) + Fox", [("P", 8, W2), ("F", 4, FOX4)])
print(f"  direct Fox x3 predicts {np.sqrt(1.5)/np.sqrt(3):.12f}", flush=True)

print("\n=== degenerate: one block zero (padding is the b=0 case) ===", flush=True)
for n in (8, 12, 14):
    Wp = pad(4, FOX4, n)
    print(f"  Fox padded into n={n}: theta={P(n,Wp):.12f} (unpadded {P(4,FOX4):.12f}) "
          f"res={abs(Q(n,Wp)-P(n,Wp)*Wp).max():.1e}", flush=True)

print("\n=== degenerate: a block with theta_i < 0 -- does theta < min_i theta_i survive? ===", flush=True)
mF = -FOX4
print(f"  theta(-Fox) = {P(4,mF):.12f}", flush=True)
for (lbl, A, B) in [("(+Fox) + (-Fox)", FOX4, mF), ("(-Fox) + (-Fox)", mF, mF)]:
    thA, thB = P(4, A), P(4, B)
    for sgn in (+1, -1):
        th = sgn / np.sqrt(1 / thA**2 + 1 / thB**2)
        W = (th / thA) * pad(4, A, 8, 0) + (th / thB) * pad(4, B, 8, 4)
        thm = P(8, W)
        print(f"  {lbl:18s} branch{sgn:+d}: |W|={nrm(W):.6f} theta={thm:+.9f} "
              f"min(theta_i)={min(thA,thB):+.9f} res={abs(Q(8,W)-thm*W).max():.1e} "
              f"{'theta<min OK' if thm < min(thA,thB) else '*** theta >= min(theta_i): B3 FAILS ***'}",
              flush=True)

print("\n=== degenerate: a block with theta_i = 0 ===", flush=True)
# find a theta=0 critical point in low dim by direct search inside Weyl_n
def find_zero_theta(n, rng, tries=4000):
    B = weyl_basis(n)
    best = None
    for _ in range(tries):
        c = rng.standard_normal(B.shape[0])
        W = np.einsum('k,kij->ij', c, B); W /= nrm(W)
        for _ in range(400):
            Qm = Q(n, W)
            co = np.einsum('kij,ij->k', B, Qm)
            Wn = np.einsum('k,kij->ij', co, B)
            th = float(np.sum(W * Wn))
            g = Wn - th * W
            if np.linalg.norm(g) < 1e-13:
                break
            W = W + 0.3 * g / max(1.0, abs(th))
            W /= nrm(W)
        if np.linalg.norm(Q(n, W) - P(n, W) * W) < 1e-11 and abs(P(n, W)) < 1e-9:
            return W
    return None
Wz = find_zero_theta(6, np.random.default_rng(3), tries=60)
if Wz is not None:
    print(f"  found theta=0 critical point at n=6: theta={P(6,Wz):.2e} res={abs(Q(6,Wz)-P(6,Wz)*Wz).max():.1e}", flush=True)
    for t in (0.0, 0.3, 0.7, 1.0):
        W = np.sqrt(1 - t**2) * pad(6, Wz, 12, 0) + t * pad(6, Wz, 12, 6)
        print(f"    a={np.sqrt(1-t**2):.3f} b={t:.3f}: theta={P(12,W):.2e} "
              f"crit_res={abs(Q(12,W)-P(12,W)*W).max():.1e}", flush=True)
else:
    print("  no theta=0 point found at n=6 in the allotted tries", flush=True)
