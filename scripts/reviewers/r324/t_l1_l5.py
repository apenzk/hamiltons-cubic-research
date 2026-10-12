import sys, numpy as np, core, points
np.set_printoptions(precision=12, suppress=True)

def data(W, n, vec=None, tol=1e-9):
    lam, U = np.linalg.eigh(W)
    N = len(lam)
    C = core.struct(n)
    # structure constants in the eigenbasis
    Ce = np.einsum('abc,ai,bj,ck->ijk', C, U, U, U, optimize=True)
    imin, imax = 0, N - 1
    lmin, lmax = lam[imin], lam[imax]
    Emin = np.where(np.abs(lam - lmin) < tol)[0]
    return lam, U, Ce, Emin, lmin, lmax

def report(name, W, n, nv=3, seed=0):
    rng = np.random.default_rng(seed)
    cr, th = core.crit_resid(W, n)
    lam, U, Ce, Emin, lmin, lmax = data(W, n)
    N = len(lam)
    out = []
    for t in range(nv):
        if t == 0:
            coef = np.zeros(len(Emin)); coef[0] = 1.0
        else:
            coef = rng.normal(size=len(Emin))
        coef /= np.linalg.norm(coef)
        # v in the eigenbasis coordinates
        ve = np.zeros(N); ve[Emin] = coef
        c = np.einsum('i,ijk->jk', ve, Ce)          # c_{vab}
        mass = float((c**2).sum())
        Dv = 0.5 * float(((np.outer(lam, lam) - lmin*lmax) * c**2).sum())
        wv = 0.5 * float((np.outer(lam, lam) * c**2).sum())   # <v,W# v>
        # HS form, built basis-free from the original basis
        v = U @ ve
        A = core.adv(v, n)
        comm = A @ W - W @ A
        g = float(np.sum(comm*comm))
        adW = float(np.sum((A@W)*(A@W)))
        hs = -0.25*g - 0.5*float(np.trace(A@A@W@W))
        l1 = lmin + (n-2)*lmax - Dv/abs(lmin)
        l5 = lmin + g/(4*abs(lmin)) - adW/(2*abs(lmin))
        off = float(((np.abs(np.outer(lam,lam)-lmin*lmax) > 1e-9) * c**2).sum())
        out.append(dict(mass=mass, D=Dv, wv=wv, hs=hs, g=g, adW=adW,
                        l1=l1, l5=l5, off=off, trA2W2=float(np.trace(A@A@W@W))))
    print(f"{name:34s} n={n} crit={cr:.2e} weyl={core.weyl_resid(W,n):.2e} theta={th:.9f} "
          f"lmin={lmin:.6f} lmax={lmax:.6f} dimEmin={len(Emin)}")
    for o in out:
        print(f"    mass={o['mass']:.9f} (2(n-2)={2*(n-2)})  D={o['D']:.9f}  slackL1={o['l1']-th:+.3e}  "
              f"slackL5={o['l5']-th:+.3e}  <v,W#v>-HS={o['wv']-o['hs']:+.2e}  g={o['g']:.9f} "
              f" ||adW||^2={o['adW']:.9f} offmass={o['off']:.6f}")
    return out
