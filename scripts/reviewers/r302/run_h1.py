"""H1: is L_e (compressed to V = span Pi_{e-perp} Pi_Weyl H_A) scalar on each k(W)-isotypic piece?

Direct test, avoiding any tolerance-sensitive commutant basis:
  M scalar on isotypes  <=>  no two distinct eigenvalues of M share an irreducible k-type
                        <=>  Hom_k(E_lambda, E_mu) = 0 for all lambda != mu.
Hom_k is computed as a nullspace of {T : T rho(x) - rho(x) T = 0}, with the singular-value
gap printed so the rank decision is auditable.
"""
import sys, os, time, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from core import Geom
from points import sphere_product, c5_blowup, cpm, witness
from le import build_weyl, Le_matrix, HA_span, compression, sym0_basis


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open('agent_logs/r302-v3-branching.log', 'a') as f:
        f.write(line + "\n")


def isotropy(g, W, tol=1e-8):
    rows = []
    for a in range(g.N):
        v = np.zeros(g.N); v[a] = 1.0
        DX = g.D(g.to_mat(v))
        rows.append((DX @ W - W @ DX).ravel())
    A = np.array(rows).T
    u, s, vt = np.linalg.svd(A)
    r = int((s > tol * max(s[0], 1e-300)).sum())
    return [g.to_mat(row) for row in vt[r:]]


def rep_on_V(g, B, sv, U, ks):
    reps = []
    for X in ks:
        DX = g.D(X)
        cols = [U.T @ (B.T @ sv.vec(DX @ sv.mat(B @ U[:, j]) - sv.mat(B @ U[:, j]) @ DX))
                for j in range(U.shape[1])]
        reps.append(np.array(cols).T)
    return reps


def hom_dim(reps, Ea, Eb, tol=1e-7):
    """dim Hom_k(Ea, Eb) with Ea, Eb orthonormal column blocks inside V."""
    da, db = Ea.shape[1], Eb.shape[1]
    blocks = []
    for R in reps:
        Ra = Ea.T @ R @ Ea          # action on Ea
        Rb = Eb.T @ R @ Eb          # action on Eb
        blocks.append(np.kron(Ra.T, np.eye(db)) - np.kron(np.eye(da), Rb))
    A = np.vstack(blocks)
    s = np.linalg.svd(A, compute_uv=False)
    # ABSOLUTE scale: the size of the representation itself, never the block's own s[0]
    scale = max(max(np.linalg.norm(R) for R in reps), 1e-12)
    r = int((s > tol * scale).sum())
    lo = s[r - 1] / scale if r > 0 else np.inf
    hi = s[r] / scale if r < len(s) else 0.0
    return da * db - r, (lo, hi)


def analyse(name, g, W, verbose=True):
    t0 = time.time()
    B, sv = build_weyl(g)
    theta = g.P(W)
    Le = Le_matrix(g, W, B, sv, theta)
    ks = isotropy(g, W)
    C, As = HA_span(g, W, B, sv)
    U, M, _ = compression(Le, C)
    M = 0.5 * (M + M.T)
    reps = rep_on_V(g, B, sv, U, ks)
    comm = max((np.max(np.abs(R @ M - M @ R)) for R in reps), default=0.0)
    ev, evec = np.linalg.eigh(M)
    vals = np.round(ev, 8)
    uniq = sorted(set(vals.tolist()))
    groups = [(v, evec[:, vals == v]) for v in uniq]
    log(f"{name:12s} n={g.n} theta={theta:.6f} dim k={len(ks)} dimV={U.shape[1]} "
        f"|[rho,M]|={comm:.1e} lam_max={ev.max():.9f} eigvals={len(uniq)} t={time.time()-t0:.1f}s")
    bad = []
    for (va, Ea), (vb, Eb) in itertools.combinations(groups, 2):
        h, gap = hom_dim(reps, Ea, Eb)
        if h > 0:
            bad.append((va, vb, h, Ea.shape[1], Eb.shape[1], gap))
    if bad:
        log(f"   *** NOT scalar on isotypes: {len(bad)} eigenvalue pairs share a k-type")
        for va, vb, h, da, db, gap in bad[:6]:
            log(f"       lambda={va:+.6f}(dim {da}) and {vb:+.6f}(dim {db}): dim Hom_k = {h} "
                f"(svd gap {gap[0]:.1e} / {gap[1]:.1e})")
    else:
        log("   scalar on isotypes: every pair of distinct eigenvalues has Hom_k = 0")
    return dict(ks=ks, U=U, M=M, reps=reps, ev=ev, bad=bad, g=g, W=W, B=B, sv=sv, Le=Le, C=C)


if __name__ == '__main__':
    log("[p2] H1 scalarity test (Hom_k form)")
    for nm, f in [("S3xS5", lambda: sphere_product(3, 5)),
                  ("S4xS4", lambda: sphere_product(4, 4)),
                  ("CP4", lambda: cpm(4)),
                  ("witness_n8", witness),
                  ("C5blowup", c5_blowup),
                  ("S5xS5", lambda: sphere_product(5, 5))]:
        g, W = f()
        analyse(nm, g, W)
