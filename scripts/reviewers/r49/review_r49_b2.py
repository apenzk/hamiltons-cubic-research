"""Reviewer 49 phase P3 -- B2: the harmonic-square law at block sums NOT on record.

Record: verified at (3,3)+(3,3), (3,3)+(2,4), (4,4)+(3,3), (4,4)+(2,4), (5,5)+(3,3).
Everything here is off that list: Fox blocks, three and four blocks, unequal block
dimensions, blocks that are themselves decomposable, scattered coordinates,
padding (the b=0 case), and the n=16 case where a block carries n_i >= 12.
"""
import sys
import numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C

SQ32 = np.sqrt(1.5)


def piece(kind, arg):
    """return (n_i, unit operator on Lambda^2 R^{n_i}, theta_i)."""
    if kind == "sphere":
        n = sum(arg)
        W = C.normalize(C.sphere_product(arg))
    elif kind == "fox":
        n = 4
        W = C.fox_cp2(4)
    elif kind == "foxpair":          # a decomposable block: two Fox operators on 8 coords
        n = 8
        WA = C.embed(C.fox_cp2(4), 4, 8, (0, 1, 2, 3))
        WB = C.embed(C.fox_cp2(4), 4, 8, (4, 5, 6, 7))
        W = C.normalize(WA + WB)
    elif kind == "sdpair":           # Lambda^+ (+) Lambda^- CP2 on the same 4 coords
        n = 4
        ps, idx = C.pindex(4)
        a, b, c, d = 0, 1, 2, 3
        V = []
        for sgn in (+1, -1):
            for (p, q) in [((a, b), (c, d)), ((a, c), (d, b)), ((a, d), (b, c))]:
                v = np.zeros(len(ps))
                g, s = C._sgn_idx(idx, *p); v[g] += s / np.sqrt(2.0)
                g, s = C._sgn_idx(idx, *q); v[g] += sgn * s / np.sqrt(2.0)
                V.append(v)
        lam = np.array([2, -1, -1]) / np.sqrt(6.0)
        Wp = sum(l * np.outer(v, v) for l, v in zip(lam, V[:3]))
        Wm = sum(l * np.outer(v, v) for l, v in zip(lam, V[3:]))
        W = C.normalize(Wp + Wm)
    else:
        raise ValueError(kind)
    th = C.Pval(n, W)
    return n, W, th


def build(specs, ambient=None, coordsets=None):
    ns, Ws, ths = [], [], []
    for k, a in specs:
        n_i, W_i, t_i = piece(k, a)
        ns.append(n_i); Ws.append(W_i); ths.append(t_i)
    n = ambient if ambient is not None else sum(ns)
    if coordsets is None:
        coordsets, off = [], 0
        for m in ns:
            coordsets.append(tuple(range(off, off + m))); off += m
    pred = 1.0 / np.sqrt(sum(1.0 / t**2 for t in ths))
    W = sum((pred / t) * C.embed(Wi, ni, n, cs)
            for Wi, ni, t, cs in zip(Ws, ns, ths, coordsets))
    nrm = np.sqrt(C.fro(W))
    Wn = W / nrm
    res, th = C.crit_residual(n, Wn)
    ric = np.abs(C.ricci(n, Wn)).max()
    bia = np.abs(C.bianchi(n, Wn)).max()
    return dict(n=n, ths=ths, pred=pred, meas=th, res=res, norm_before=nrm,
                ric=ric, bia=bia)


CASES = [
    ("Fox4 + Fox4  (the Fox plateau)", [("fox", None), ("fox", None)], None, None),
    ("Fox4 + Fox4 padded to n=12", [("fox", None), ("fox", None)], 12, None),
    ("Fox4 + S^3xS^3", [("fox", None), ("sphere", (3, 3))], None, None),
    ("Fox4 + S^4xS^4", [("fox", None), ("sphere", (4, 4))], None, None),
    ("S^2xS^4 + S^4xS^4  (unequal dims)", [("sphere", (2, 4)), ("sphere", (4, 4))], None, None),
    ("S^2xS^2 + S^2xS^2", [("sphere", (2, 2)), ("sphere", (2, 2))], None, None),
    ("S^3xS^3 x3  (three blocks, n=18)", [("sphere", (3, 3))] * 3, None, None),
    ("Fox4 x3  (three blocks, n=12)", [("fox", None)] * 3, None, None),
    ("Fox4 x4  (four blocks, n=16)", [("fox", None)] * 4, None, None),
    ("(Fox4+Fox4) + S^3xS^3  decomposable block", [("foxpair", None), ("sphere", (3, 3))], None, None),
    ("Fox4 + Fox4 + S^3xS^3  same point, 3 blocks", [("fox", None), ("fox", None), ("sphere", (3, 3))], None, None),
    ("S^3xS^3 + S^3xS^3 on scattered coords", [("sphere", (3, 3))] * 2, 14,
     [(0, 2, 4, 6, 8, 10), (1, 3, 5, 7, 9, 11)]),
    ("S^6xS^6 (n=12) + Fox4   -> n=16", [("sphere", (6, 6)), ("fox", None)], None, None),
    ("S^6xS^6 + S^6xS^6      -> n=24", [("sphere", (6, 6))] * 2, None, None),
]

print(f"{'case':>44} {'n':>3} {'theta_i':>26} {'predicted':>12} {'measured':>12} {'|diff|':>9} {'crit resid':>10}", flush=True)
rows = []
for lbl, specs, amb, cs in CASES:
    if (amb or sum(piece(k, a)[0] for k, a in specs)) > 20:
        continue
    r = build(specs, amb, cs)
    tstr = ",".join(f"{t:.6f}" for t in r["ths"])
    print(f"{lbl:>44} {r['n']:3d} {tstr:>26} {r['pred']:12.9f} {r['meas']:12.9f} "
          f"{abs(r['pred']-r['meas']):9.1e} {r['res']:10.1e}", flush=True)
    rows.append((lbl, r))

print("\n=== degenerate case: padding is b = 0 ===", flush=True)
for kind, arg, tgt in [("fox", None, (8, 10, 12, 14)), ("sphere", (3, 3), (8, 10, 12)),
                       ("sphere", (4, 4), (10, 12)), ("sphere", (6, 6), (14, 16))]:
    n0, W0, t0 = piece(kind, arg)
    line = f"  {kind}{arg if arg else ''} native n={n0} theta={t0:.12f} ->"
    for n in tgt:
        Wp = C.embed(W0, n0, n, tuple(range(n0)))
        res, th = C.crit_residual(n, Wp)
        line += f"  n={n}: {th:.12f} (res {res:.1e})"
    print(line, flush=True)

print("\n=== degenerate case: a block with theta = 0 ===", flush=True)
# W and -W are both critical (Q is quadratic), with thetas of opposite sign;
# a block at theta = 0 would make the law read 1/theta^2 = infinity.
n0, W0, t0 = piece("fox", None)
n = 8
WA = C.embed(W0, 4, 8, (0, 1, 2, 3))
WB = C.embed(-W0, 4, 8, (4, 5, 6, 7))
print(f"  theta(W_CP2) = {t0:.9f},  theta(-W_CP2) = {C.Pval(4, -W0):.9f}", flush=True)
for a in np.linspace(0, 1, 11):
    b = np.sqrt(max(0.0, 1 - a * a))
    W = a * WA + b * WB
    if np.linalg.norm(W) < 1e-12:
        continue
    res, th = C.crit_residual(8, W)
    if res < 1e-10:
        print(f"    a={a:.3f} b={b:.3f}: CRITICAL theta={th:+.9f} resid={res:.1e}", flush=True)

print("\n=== is a critical point forced to have critical blocks? ===", flush=True)
# take W_A critical and W_B NON-critical on a disjoint block; can the sum ever be critical?
n = 10
WA = C.embed(C.fox_cp2(4), 4, n, (0, 1, 2, 3))
rng = np.random.default_rng(5)
Bs = C.weyl_basis(6)
Y = np.einsum('k,kij->ij', rng.standard_normal(Bs.shape[0]), Bs)
Y = C.normalize(Y)
rY, tY = C.crit_residual(6, Y)
WB = C.embed(Y, 6, n, (4, 5, 6, 7, 8, 9))
best = 1e9
for a in np.linspace(0.02, 0.98, 97):
    W = C.normalize(a * WA + np.sqrt(1 - a * a) * WB)
    r, t = C.crit_residual(n, W)
    best = min(best, r)
print(f"  block B non-critical (own residual {rY:.3f}); min criticality residual over the "
      f"whole 2-plane = {best:.4f}", flush=True)
