import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core, points, le

def HA_span(n, W, project_weyl=True, project_perp=True, tol=1e-8):
    """span of H_A = D_A W + W D_A, A in Sym_0(R^n), optionally projected."""
    S = core.sym0_basis(n)
    rows = []
    for A in S:
        D = core.deriv(n, A)
        H = D @ W + W @ D
        H = 0.5 * (H + H.T)
        if project_weyl:
            H = core.proj_weyl(n, H)
        if project_perp:
            H = H - np.sum(H * W) * W / np.sum(W * W)
        rows.append(H.reshape(-1))
    F = np.array(rows)
    u, s, vt = np.linalg.svd(F, full_matrices=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return vt[:r], s, S.shape[0]

def full_L_operator(n, W, theta):
    """L_e on ALL of Sym^2(Lambda^2), as a matrix in the flattened N^2 coords
       (acting on symmetric matrices)."""
    P, _ = core.pairs_of(n); N = len(P)
    Sb = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0; Sb.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1/np.sqrt(2.0); Sb.append(E)
    Sb = np.array(Sb); D = Sb.shape[0]; Sf = Sb.reshape(D, -1)
    M = np.empty((D, D))
    for k in range(D):
        M[:, k] = Sf @ (core.circ(n, W, Sb[k]) / theta).reshape(-1)
    return M, Sf

def compress(n, W, theta, rowsflat, ambient="weyl"):
    """<L_e v, v> matrix for orthonormal rows (flattened N x N matrices)."""
    r = rowsflat.shape[0]
    P, _ = core.pairs_of(n); N = len(P)
    M = np.empty((r, r))
    for k in range(r):
        V = rowsflat[k].reshape(N, N)
        img = core.circ(n, W, V) / theta
        M[:, k] = rowsflat @ img.reshape(-1)
    return 0.5 * (M + M.T)

def run(nm, W, n):
    theta = core.P(n, W)
    Lm, th, B, Bf = le.Lmat(n, W, theta)
    Lp, Uc, w = le.restrict_perp(Lm, Bf, W)
    ev_full = np.linalg.eigvalsh(0.5*(Lp+Lp.T))
    out = {"name": nm, "n": n, "theta": theta, "lam_full": ev_full[-1],
           "d_weyl": Lm.shape[0]}
    for pw in (True, False):
        rows, s, nA = HA_span(n, W, project_weyl=pw, project_perp=True)
        Mc = compress(n, W, theta, rows)
        ev = np.linalg.eigvalsh(Mc)
        key = "W" if pw else "noW"
        out[f"dim_{key}"] = rows.shape[0]
        out[f"tr_{key}"] = float(np.trace(Mc))
        out[f"trdim_{key}"] = float(np.trace(Mc))/rows.shape[0]
        out[f"lmax_{key}"] = ev[-1]
        out[f"lmin_{key}"] = ev[0]
        if pw:
            # how much of V is really inside Weyl_n?  (it is by construction)
            resid = max(np.linalg.norm(r_.reshape(core.pairs_of(n)[0].__len__(), -1)) for r_ in [rows[0]])
    # projection-order experiment: e-perp FIRST then Weyl
    S = core.sym0_basis(n); rows2 = []
    for A in S:
        D = core.deriv(n, A); H = 0.5*((D@W+W@D)+(D@W+W@D).T)
        H = H - np.sum(H*W)*W
        H = core.proj_weyl(n, H)
        rows2.append(H.reshape(-1))
    F = np.array(rows2); u,s2,vt = np.linalg.svd(F, full_matrices=False)
    r2 = int((s2 > 1e-8*max(1.0,s2[0])).sum()); rows2 = vt[:r2]
    Mc2 = compress(n, W, theta, rows2); ev2 = np.linalg.eigvalsh(Mc2)
    out["dim_rev"] = r2; out["trdim_rev"] = float(np.trace(Mc2))/r2; out["lmax_rev"] = ev2[-1]
    # no projection at all (raw H_A, not into e-perp either)
    rows3, s3, nA = HA_span(n, W, project_weyl=False, project_perp=False)
    Mc3 = compress(n, W, theta, rows3); ev3 = np.linalg.eigvalsh(Mc3)
    out["dim_raw"] = rows3.shape[0]; out["trdim_raw"] = float(np.trace(Mc3))/rows3.shape[0]
    out["lmax_raw"] = ev3[-1]
    # weyl-projected but NOT into e-perp
    rows4, _, _ = HA_span(n, W, project_weyl=True, project_perp=False)
    Mc4 = compress(n, W, theta, rows4); ev4 = np.linalg.eigvalsh(Mc4)
    out["dim_wonly"] = rows4.shape[0]; out["trdim_wonly"] = float(np.trace(Mc4))/rows4.shape[0]
    out["lmax_wonly"] = ev4[-1]
    return out

if __name__ == "__main__":
    for nm, W, n in [("S^3xS^5",) + points.sphere_product([3,5]),
                     ("CP^4",) + points.cpm(4),
                     ("C5blowup",) + points.c5_blowup()]:
        o = run(nm, W, n)
        print(f"== {o['name']} n={o['n']} theta={o['theta']:.9f} dimWeyl={o['d_weyl']} lam_max(full,e-perp)={o['lam_full']:.9f}")
        print(f"   [Weyl then e-perp] dimV={o['dim_W']:3d} tr/dim={o['trdim_W']:.6f} lmax|V={o['lmax_W']:.6f} lmin|V={o['lmin_W']:.6f}")
        print(f"   [e-perp then Weyl] dimV={o['dim_rev']:3d} tr/dim={o['trdim_rev']:.6f} lmax|V={o['lmax_rev']:.6f}")
        print(f"   [no Weyl proj, e-perp] dimV={o['dim_noW']:3d} tr/dim={o['trdim_noW']:.6f} lmax|V={o['lmax_noW']:.6f}")
        print(f"   [Weyl proj only]   dimV={o['dim_wonly']:3d} tr/dim={o['trdim_wonly']:.6f} lmax|V={o['lmax_wonly']:.6f}")
        print(f"   [raw H_A, no proj] dimV={o['dim_raw']:3d} tr/dim={o['trdim_raw']:.6f} lmax|V={o['lmax_raw']:.6f}")
