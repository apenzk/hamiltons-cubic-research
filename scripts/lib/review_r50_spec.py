"""J2/J3: FULL eigensolve of L_e on Weyl_n, replacing the deflated power iteration.

For a critical W with Q(W)=theta W, e=W/theta, builds the matrix of L_e X = e o X
in an orthonormal basis of Weyl_n and diagonalises it exactly.  Morse-Bott
nondegeneracy is dim E(1/2) == dim(orbit tangent).

Reachable at n=14 (dim Weyl_14 = 3080) because the basis is built in
sym-coordinates (D = 4186) and never materialised as 3080 dense N x N matrices.
"""
import sys, time, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r50_core as C


def le_matrix(n, W, theta, chunk=64, log=None):
    N = len(C.pairs_idx(n)[0])
    B, _ = C.weyl_basis_vec(n)
    d = B.shape[0]
    e = W / theta
    A = C.struct(n)
    A2 = A.reshape(N * N, N)
    Ae = (A2 @ e).reshape(N, N, N)
    AeT = Ae.transpose(0, 2, 1).reshape(N, N * N)          # (N, N*N)
    out = np.empty((d, B.shape[1]))
    t0 = time.time()
    for j in range(d):
        X = C.vec2mat(N, B[j])
        AX = (A2 @ X).reshape(N, N * N)
        T = AX @ AeT.T
        L = 0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)
        out[j] = C.mat2vec(N, L)
        if log and (j % 200 == 0):
            log(f"    le_matrix n={n}: col {j}/{d}  {time.time()-t0:.1f}s")
    M = B @ out.T
    return 0.5 * (M + M.T), B, float(np.max(np.abs(M - M.T)))


def orbit_dim(n, W):
    N = len(C.pairs_idx(n)[0])
    T = C.orbit_tangent(n, W)
    F = np.array([C.mat2vec(N, t) for t in T])
    return C.orthonormalize_rows(F), F


def analyse(name, n, W, log=print, tol=1e-8):
    N = len(C.pairs_idx(n)[0])
    W = W / np.linalg.norm(W)
    th = C.P(n, W)
    res = np.linalg.norm(C.Q(n, W) - th * W)
    th0 = C.theta0(n)
    U, F = orbit_dim(n, W)
    orb = U.shape[0]
    log(f"  [{name}] n={n} theta={th:.9f} th/th0={th/th0:.6f} crit_res={res:.2e} orbit={orb}")
    M, B, asym = le_matrix(n, W, th, log=log)
    w = np.linalg.eigvalsh(M)
    dimE = int((np.abs(w - 0.5) < tol).sum())
    # how well does the orbit sit inside Weyl_n and inside E(1/2)?
    Uw = U @ B.T @ B                       # orbit tangent projected into Weyl coords
    leak = np.linalg.norm(U - Uw) / max(1.0, np.linalg.norm(U))
    near = np.sort(np.abs(w - 0.5))[:orb + 8]
    log(f"  [{name}] asym(M)={asym:.2e} dimE(1/2)={dimE} orbit={orb} "
        f"{'NONDEGENERATE' if dimE==orb else 'DEGENERATE excess=%d' % (dimE-orb)}")
    log(f"  [{name}] orbit-in-Weyl leak={leak:.2e}  |lam-1/2| sorted[{orb-2}:{orb+6}]="
        + " ".join(f"{x:.3e}" for x in near[max(0, orb - 2):orb + 6]))
    log(f"  [{name}] spectrum: min={w.min():.6f} max={w.max():.6f}  "
        f"gap above 1/2 (nearest |lam-1/2| off-orbit) = {near[orb]:.6e}")
    return dict(theta=th, ratio=th / th0, orbit=orb, dimE=dimE, w=w, res=res)


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("case")
    args = ap.parse_args()
    LOG = open("agent_logs/review_r50_projector.log", "a", buffering=1)
    def log(s):
        print(s, flush=True); LOG.write(s + "\n")

    cases = {
        # name: (blocks, n0, n)
        "s4s4_8_10":  ((4, 4), 8, 10),
        "s5s5_10_12": ((5, 5), 10, 12),
        "s3s3_6_10":  ((3, 3), 6, 10),
        "s6s6_12_12": ((6, 6), 12, 12),
        "s6s6_12_14": ((6, 6), 12, 14),
        "s6s7_13_14": ((6, 7), 13, 14),
        "s7s7_14_14": ((7, 7), 14, 14),
        "s2s2_4_6":   ((2, 2), 4, 6),
        "s2s2_4_8":   ((2, 2), 4, 8),
        "s2s4_6_8":   ((2, 4), 6, 8),
        "s2s5_7_8":   ((2, 5), 7, 8),
        "s2s2_4_4":   ((2, 2), 4, 4),
        "s2s4_6_6":   ((2, 4), 6, 6),
        "s5s6_11_12": ((5, 6), 11, 12),
        "s5s5_10_14": ((5, 5), 10, 14),
        "s4s4_8_8":   ((4, 4), 8, 8),
    }
    blocks, n0, n = cases[args.case]
    t0 = time.time()
    W0 = C.sphere_product_W(blocks)
    W = C.pad(W0, n0, n) if n0 != n else W0
    analyse(args.case, n, W, log=log)
    log(f"  [{args.case}] wall {time.time()-t0:.1f}s")
