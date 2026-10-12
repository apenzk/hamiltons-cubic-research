"""D(v), saturation, and the m/h/r bracket structure -- all from my own definitions."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
import core

def spectrum_blocks(n, W, tol=1e-8):
    lam, V = np.linalg.eigh(W)
    lmin, lmax = lam[0], lam[-1]
    m = V[:, np.abs(lam - lmin) < tol]
    h = V[:, np.abs(lam - lmax) < tol]
    rmask = (np.abs(lam - lmin) >= tol) & (np.abs(lam - lmax) >= tol)
    r = V[:, rmask]
    return lam, V, lmin, lmax, m, h, r

def D_of(n, W, v, tol=1e-8):
    """D(v) = 1/2 sum_ab (l_a l_b - lmin lmax) c_{vab}^2, in the eigenbasis of W."""
    lam, V = np.linalg.eigh(W)
    A = core.ad(n, v)                     # (ad v)_{cb} = c_{v b c}
    Ae = V.T @ A @ V                      # in the eigenbasis
    C2 = Ae ** 2                          # C2[c,b] = c_{v b c}^2
    lmin, lmax = lam[0], lam[-1]
    Lprod = np.outer(lam, lam)
    return 0.5 * float(np.sum((Lprod - lmin * lmax) * C2)), C2, lam

def saturation(n, W, tol=1e-8):
    """max over an orthonormal basis of E_min of D(v); also the mass off E_min x E_max."""
    lam, V, lmin, lmax, m, h, r = spectrum_blocks(n, W, tol)
    Ds, offs = [], []
    for k in range(m.shape[1]):
        d, C2, lam2 = D_of(n, W, m[:, k])
        Ds.append(d)
        inmin = np.abs(lam2 - lmin) < tol; inmax = np.abs(lam2 - lmax) < tol
        allow = np.outer(inmin, inmax) | np.outer(inmax, inmin)
        offs.append(float(np.sum(C2[~allow])))
    return max(Ds), min(Ds), max(offs), (lam, lmin, lmax, m, h, r)

def bracket_span(n, X, Y, tol=1e-9):
    """span of [x,y] for x in cols(X), y in cols(Y) -- returns orthonormal basis and its dim."""
    vecs = []
    for k in range(X.shape[1]):
        A = core.ad(n, X[:, k])
        vecs.append(A @ Y)
    Mt = np.hstack(vecs) if vecs else np.zeros((core.struct(n)[1].shape[0], 0))
    if Mt.shape[1] == 0: return Mt, 0, 0.0
    u, s, vt = np.linalg.svd(Mt, full_matrices=False)
    d = int(np.sum(s > tol * max(1.0, s[0])))
    return u[:, :d], d, float(np.linalg.norm(Mt))

def comp_in(n, S, basis):
    """norm of the component of the columns of S inside span(basis) (and outside)."""
    if S.shape[1] == 0: return 0.0, 0.0
    if basis.shape[1] == 0: return 0.0, float(np.linalg.norm(S))
    Pb = basis @ basis.T
    inn = np.linalg.norm(Pb @ S); out = np.linalg.norm(S - Pb @ S)
    return float(inn), float(out)

def structure_report(n, W, tol=1e-8):
    dmax, dmin, off, (lam, lmin, lmax, m, h, r) = saturation(n, W, tol)
    res, th = core.crit_res(n, W)
    out = dict(n=n, crit_res=res, theta=th, wdist=core.weyl_dist(n, W),
               lmin=lmin, lmax=lmax, ratio=lmax/abs(lmin),
               dim_m=m.shape[1], dim_h=h.shape[1], dim_r=r.shape[1],
               Dmax=dmax, Dmin=dmin, off_mass=off,
               nspec=len(np.unique(np.round(lam, 8))))
    # brackets
    for (nameX, X), (nameY, Y) in [(('m', m), ('m', m)), (('m', m), ('h', h)),
                                   (('m', m), ('r', r)), (('h', h), ('h', h)),
                                   (('h', h), ('r', r)), (('r', r), ('r', r))]:
        B, d, nrm = bracket_span(n, X, Y)
        vecs = []
        for k in range(X.shape[1]):
            vecs.append(core.ad(n, X[:, k]) @ Y)
        S = np.hstack(vecs) if vecs else np.zeros((len(lam), 0))
        _, out_m = comp_in(n, S, m); _, out_h = comp_in(n, S, h)
        in_m, _ = comp_in(n, S, m); in_h, _ = comp_in(n, S, h); in_r, _ = comp_in(n, S, r)
        out[f'[{nameX},{nameY}]'] = dict(dim=d, norm=nrm, in_m=in_m, in_h=in_h, in_r=in_r)
    # g' = m + [m,m]
    Bmm, dmm, _ = bracket_span(n, m, m)
    G = np.hstack([m, Bmm]) if Bmm.shape[1] else m
    u, s, vt = np.linalg.svd(G, full_matrices=False)
    out['dim_gprime'] = int(np.sum(s > 1e-9))
    out['dim_mm'] = dmm
    return out
