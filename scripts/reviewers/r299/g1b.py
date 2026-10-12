import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core, points, le, g123

def orbit_basis(n, W):
    A = core.ad(n); N = A.shape[0]
    rows = [ (A[a]@W - W@A[a]).reshape(-1) for a in range(N) ]
    F = np.array(rows); u,s,vt = np.linalg.svd(F, full_matrices=False)
    return vt[s > 1e-9*max(1.0,s[0])]

def avgs(nm, W, n):
    theta = core.P(n, W)
    Lm, th, B, Bf = le.Lmat(n, W, theta)
    d = Lm.shape[0]
    Lp, Uc, w = le.restrict_perp(Lm, Bf, W); Lp = 0.5*(Lp+Lp.T)
    P_, _ = core.pairs_of(n); N = len(P_)
    S = core.sym0_basis(n)
    Hs = []
    for Amat in S:
        D = core.deriv(n, Amat); H = D@W + W@D; H = 0.5*(H+H.T)
        H = core.proj_weyl(n, H); H = H - np.sum(H*W)*W
        Hs.append(H)
    Hs = np.array(Hs)
    num_mass = 0.0; den_mass = 0.0; rq = []
    for H in Hs:
        nrm2 = float(np.sum(H*H))
        if nrm2 < 1e-18: continue
        q = float(np.sum(core.circ(n, W, H) * H)) / theta
        num_mass += q; den_mass += nrm2
        rq.append(q/nrm2)
    rows, s, nA = g123.HA_span(n, W, True, True)
    Mc = g123.compress(n, W, theta, rows)
    evV, evecV = np.linalg.eigh(Mc)
    # V restricted to non-kernel of L_e|V
    keep = np.abs(evV) > 1e-8
    tr_nonker = evV[keep].mean() if keep.sum() else float('nan')
    # V cap orbit^perp
    O = orbit_basis(n, W)
    Vf = rows                                  # (r, N*N) orthonormal
    Mo = Vf @ O.T
    u2,s2,vt2 = np.linalg.svd(Mo, full_matrices=True)
    # directions of V orthogonal to O = left-singular vectors with sigma ~ 0
    ncomp = int((s2 > 1e-8).sum())
    Uperp = u2[:, ncomp:]
    if Uperp.shape[1] > 0:
        Vperp = Uperp.T @ Vf
        Mc2 = g123.compress(n, W, theta, Vperp)
        tr_operp = np.trace(Mc2)/Vperp.shape[0]
        lmax_operp = np.linalg.eigvalsh(0.5*(Mc2+Mc2.T))[-1]
    else:
        tr_operp = float('nan'); lmax_operp = float('nan')
    uq = {}
    for x in np.round(evV, 6): uq[x] = uq.get(x,0)+1
    print(f"== {nm} n={n} theta={theta:.6f} dimV={rows.shape[0]} dimOrbit={O.shape[0]}")
    print(f"   (a) tr/dim orthonormal V              = {np.trace(Mc)/rows.shape[0]:.6f}")
    print(f"   (b) mass-weighted sum<L H,H>/sum||H||^2 = {num_mass/den_mass:.6f}")
    print(f"   (c) mean Rayleigh quotient over A     = {np.mean(rq):.6f}  (max over A = {np.max(rq):.6f})")
    print(f"   (d) tr/dim on V minus ker(L_e|V)      = {tr_nonker:.6f}  (dim {int(keep.sum())})")
    print(f"   (e) tr/dim on V cap orbit^perp        = {tr_operp:.6f}  lmax={lmax_operp:.6f} (dim {Uperp.shape[1]})")
    print(f"   spec(L_e|V) multiplicities: {sorted(uq.items())}")

if __name__ == "__main__":
    for nm, W, n in [("S^3xS^5",)+points.sphere_product([3,5]),
                     ("CP^4",)+points.cpm(4),
                     ("C5blowup",)+points.c5_blowup()]:
        avgs(nm, W, n)
