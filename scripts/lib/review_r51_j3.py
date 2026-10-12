"""J3/J4: full eigensolve of L_e on Weyl_n at padded critical points."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r51_core import *

def full_Le(n, W, verbose=True):
    th = float(np.tensordot(W, Qop(n, W)))
    e = W / th
    B = weyl_basis(n); d = B.shape[0]
    N = B.shape[1]
    t0 = time.time()
    Call = np.empty_like(B)
    for l in range(d):
        Call[l] = circ(n, e, B[l])
        if verbose and l % 500 == 0:
            print(f"    circ {l}/{d}  {time.time()-t0:.1f}s", flush=True)
    L = B.reshape(d, -1) @ Call.reshape(d, -1).T
    asym = np.abs(L - L.T).max()
    L = 0.5 * (L + L.T)
    # invariance of Weyl_n under L_e: how much of e o B_l left the subspace
    leak = np.linalg.norm(Call.reshape(d,-1) - L @ B.reshape(d,-1)) / np.linalg.norm(Call)
    if verbose: print(f"    built in {time.time()-t0:.1f}s  |L-L^T|={asym:.2e}  leak out of Weyl={leak:.2e}", flush=True)
    return th, L, B, asym, leak

def report(name, n, W, tol=1e-6):
    W = normalize(W)
    th, L, B, asym, leak = full_Le(n, W)
    d = B.shape[0]
    ev = np.linalg.eigvalsh(L)
    # orbit tangent, expressed in the Weyl basis
    Tg = orbit_tangent(n, W)
    U = onb_rows(Tg, tol=1e-9)
    orb = U.shape[0]
    # dim E(1/2)
    half = int(np.sum(np.abs(ev - 0.5) < tol))
    # the deflated quantity: min over complement of orbit + <W>
    Bf = B.reshape(d, -1)
    coU = U @ Bf.T                      # (orb, d) orbit in Weyl coordinates
    coW = (W.ravel() @ Bf.T)[None, :]
    Cmb = np.vstack([coU, coW])
    q, _ = np.linalg.qr(Cmb.T)          # (d, orb+1)
    Pperp = np.eye(d) - q @ q.T
    Lr = Pperp @ L @ Pperp
    evr = np.linalg.eigvalsh(0.5*(Lr+Lr.T))
    # drop the (orb+1) spurious zeros introduced by the projection
    order = np.argsort(np.abs(evr))
    keep = np.ones(d, bool); keep[order[:orb+1]] = False
    evr_keep = evr[keep]
    mind = np.min(np.abs(evr_keep - 0.5))
    print(f"\n### {name}: n={n} dim Weyl={d} theta={th:.9f} theta/theta0={th/theta0(n):.4f}")
    print(f"    orbit dim = {orb}   dim E(1/2) = {half}   excess = {half-orb}   "
          f"{'NONDEGENERATE' if half==orb else 'DEGENERATE'}")
    print(f"    eigenvalues nearest 1/2 off orbit+<W>: min|lam-1/2| = {mind:.6e}  "
          f"-> (L_e-1/2)^2 min = {mind**2:.4e}")
    near = np.sort(np.abs(ev-0.5))[:orb+6]
    print(f"    |lam-1/2| sorted (first {orb+6}): "
          + " ".join(f"{x:.3e}" for x in near[:8]) + " ... " + " ".join(f"{x:.3e}" for x in near[-6:]))
    print(f"    spectrum range [{ev.min():.4f},{ev.max():.4f}]  eig=1 count={int(np.sum(np.abs(ev-1)<tol))}")
    return dict(n=n, d=d, th=th, orb=orb, half=half, mind=mind, ev=ev)

if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "small"
    res = {}
    if which == "small":
        cases = [("S3xS3 native", 6, (3,3)), ("S4xS4 native", 8, (4,4)),
                 ("S4xS4 pad->10", 10, (4,4)), ("S3xS3 pad->10", 10, (3,3)),
                 ("S5xS5 native", 10, (5,5))]
    elif which == "n12":
        cases = [("S5xS5 pad->12", 12, (5,5)), ("S6xS6 native n=12", 12, (6,6))]
    elif which == "n14":
        cases = [("S6xS6 pad->14", 14, (6,6))]
    elif which == "s2":
        cases = [("S2xS2 native", 4, (2,2)), ("S2xS2 pad->6", 6, (2,2)),
                 ("S2xS2 pad->8", 8, (2,2)), ("S2xS4 native", 6, (2,4)),
                 ("S2xS4 pad->8", 8, (2,4)), ("S2xS6 native", 8, (2,6)),
                 ("S2xS6 pad->10", 10, (2,6)), ("S2xS8 native", 10, (2,8)),
                 ("S2xS8 pad->12", 12, (2,8)), ("S3xS5 native", 8, (3,5)),
                 ("S4xS6 native", 10, (4,6)), ("S4xS6 pad->12", 12, (4,6)),
                 ("S5xS7 native", 12, (5,7))]
    for name, n, blocks in cases:
        res[name] = report(name, n, sphere_product_W(blocks, n))
