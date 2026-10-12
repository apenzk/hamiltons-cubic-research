"""Reviewer 45, phase 3-5: attack P1-P4 on the padded S^3 x S^3 point."""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r45_core import (struct, weyl_basis, Qop, circ, sphere_product, pad,
                             theta_and_residual, orbit_tangent, Le_matrix,
                             slack, pairs_of)

LOG = 'agent_logs/review_r45_padded.log'


def log(msg):
    with open(LOG, 'a') as f:
        f.write(f"{time.strftime('%H:%M:%S')} {msg}\n")
    print(msg, flush=True)


def stabilizer_dim(W, A, tol=1e-9):
    """dim{x in so(n) : [A_x, W] = 0}, from the singular values of a -> [A_a,W]."""
    N = A.shape[0]
    T = np.einsum('amn,np->amp', A, W) - np.einsum('mn,anp->amp', W, A)
    s = np.linalg.svd(T.reshape(N, N * N), compute_uv=False)
    tol_ = max(N, N * N) * np.finfo(float).eps * s[0]
    return int((s <= tol_).sum()), s


def analyse(k, l, n0, n, Bcache, tag=None):
    tag = tag or f"pad(S^{k}xS^{l}, {n0}) -> n={n}"
    A = struct(n)
    N = A.shape[0]
    B = Bcache[n]
    Bf = B.reshape(B.shape[0], -1)
    D = B.shape[0]

    Wsmall = sphere_product(k, l, n0)
    Wraw = pad(Wsmall, n0, n) if n0 != n else Wsmall
    # (i) is the padded operator already IN Weyl_n?  (projector-independent test)
    v = Bf @ Wraw.reshape(-1)
    proj = (v @ Bf).reshape(N, N)
    dev = np.linalg.norm(proj - Wraw) / np.linalg.norm(Wraw)
    W = Wraw / np.linalg.norm(Wraw)

    th, res = theta_and_residual(W, A)
    S = slack(W, A)
    sd, ssv = stabilizer_dim(W, A)
    orb = N - sd
    Ot, _ = orbit_tangent(W, A)
    orb_svd = Ot.shape[0]
    # orbit tangent inside Weyl_n?
    leak = np.linalg.norm(Ot - (Ot @ Bf.T) @ Bf) if orb_svd else 0.0

    t0 = time.time()
    e = W / th
    M = Le_matrix(Bf, e, A)
    w, V = np.linalg.eigh(M)
    log(f"  [{tag}] Le built D={D} in {time.time()-t0:.1f}s")

    d = np.abs(w - 0.5)
    dimE = int((d < 1e-8).sum())
    srt = np.sort(d)
    gap = (srt[dimE - 1], srt[dimE]) if dimE < D else (srt[-1], np.inf)
    return dict(tag=tag, n=n, D=D, dev=dev, theta=th, res=res, S=S,
                orb=orb, orb_svd=orb_svd, leak=leak, dimE=dimE,
                gap=gap, w=w, V=V, Bf=Bf, A=A, W=W, N=N, Ot=Ot, n0=n0)


if __name__ == "__main__":
    log("PHASE 3/4/5: padded S^3xS^3 -- P1,P2,P3,P4")
    Bc = {}
    for n in (6, 8, 10, 12):
        t = time.time()
        Bc[n] = weyl_basis(n)
        log(f"  weyl_basis n={n} D={Bc[n].shape[0]} ({time.time()-t:.1f}s)")

    results = []
    for n in (6, 8, 10, 12):
        r = analyse(3, 3, 6, n, Bc)
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        log(f"n={n:2d} D={r['D']:5d} projdev={r['dev']:.2e} theta={r['theta']:.9f} "
            f"theta0={th0:.9f} resid={r['res']:.2e} S={r['S']:.2e} "
            f"orbit(stab)={r['orb']} orbit(svd)={r['orb_svd']} leak={r['leak']:.1e} "
            f"dimE(1/2)={r['dimE']} excess={r['dimE']-r['orb']} "
            f"gap=[{r['gap'][0]:.1e},{r['gap'][1]:.1e}]")
        results.append(r)

    # --- where do the excess eigenvectors live? ---
    log("PHASE 5b: locating the excess 1/2-eigenvectors")
    for r in results:
        n, N, Bf, V, w = r['n'], r['N'], r['Bf'], r['V'], r['w']
        ps, idx = pairs_of(n)
        inner = np.array([a for a, (i, j) in enumerate(ps) if j < r['n0']])
        mask = np.zeros((N, N), bool)
        mask[np.ix_(inner, inner)] = True
        sel = np.where(np.abs(w - 0.5) < 1e-8)[0]
        E = (V[:, sel].T @ Bf).reshape(len(sel), N, N)     # eigenvectors as matrices
        # split off the orbit tangent
        Ot = r['Ot']
        Ecoef = V[:, sel]                                  # (D, dimE)
        Ocoef = (Ot @ Bf.T).T                              # (D, orb) orbit in basis coords
        q, _ = np.linalg.qr(Ocoef)
        Perp = Ecoef - q @ (q.T @ Ecoef)
        u, s, _ = np.linalg.svd(Perp, full_matrices=False)
        exc = int((s > 1e-8).sum())
        Xexc = (u[:, :exc].T @ Bf).reshape(exc, N, N)
        fr = [float((X[mask] ** 2).sum() / (X ** 2).sum()) for X in Xexc]
        log(f"  n={n}: excess dim = {exc}; fraction of each excess eigenvector's "
            f"norm^2 inside the {r['n0']}-block: min={min(fr):.12f} max={max(fr):.12f}")
        # how much of the orbit tangent reaches the new coordinates
        fo = [float((X[mask] ** 2).sum() / (X ** 2).sum())
              for X in (Ot.reshape(-1, N, N))]
        log(f"       orbit tangent inside-block fractions: min={min(fo):.6f} "
            f"max={max(fo):.6f}  (dim {len(fo)})")
