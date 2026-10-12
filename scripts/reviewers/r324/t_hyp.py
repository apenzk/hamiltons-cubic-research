"""Which hypotheses does each half of the identity actually need?"""
import sys, numpy as np, core
rng = np.random.default_rng(7)

def cvab(v, lamU, n):
    lam, U = lamU
    C = core.struct(n)
    Ce = np.einsum('abc,ai,bj,ck->ijk', C, U, U, U, optimize=True)
    return np.einsum('i,ijk->jk', v, Ce)

for n in (5, 6, 7):
    N = n*(n-1)//2
    print(f"--- n={n} ---")
    for kind in ('random symmetric (NOT Weyl)', 'random Weyl', 'random symmetric, kernel forced'):
        for trial in range(3):
            A = rng.normal(size=(N, N)); W = (A + A.T)/2
            if kind.startswith('random Weyl'):
                W = core.weyl_proj(W, n)
            if kind.endswith('kernel forced'):
                lam, U = np.linalg.eigh(W); lam[2:6] = 0.0; W = U @ np.diag(lam) @ U.T
            W /= np.linalg.norm(W)
            lam, U = np.linalg.eigh(W)
            Wsh = core.sharp(W, n)
            lmin, lmax = lam[0], lam[-1]
            # pick eigenvectors: the lambda_min one, a middle one, and a non-eigenvector
            tests = [('v=e_min, unit', U[:, 0], 1.0),
                     ('v=e_mid,  unit', U[:, N//2], 1.0),
                     ('v=e_min, norm 2.3', 2.3*U[:, 0], 2.3),
                     ('v random non-eigvec unit', None, 1.0)]
            for label, v, s in tests:
                if v is None:
                    v = rng.normal(size=N); v /= np.linalg.norm(v)
                ve = U.T @ v
                c = cvab(ve, (lam, U), n)
                mass = float((c**2).sum())
                wv = 0.5*float((np.outer(lam, lam)*c**2).sum())
                wv_direct = float(v @ Wsh @ v)
                D = 0.5*float(((np.outer(lam, lam)-lmin*lmax)*c**2).sum())
                # the L1 algebraic core (no criticality):  <v,W#v> = D + (n-2)*lmin*lmax*||v||^2
                l1core = wv - (D + (n-2)*lmin*lmax*s*s)
                # the L5 algebraic core (no criticality)
                Am = core.adv(v, n)
                g = float(np.sum((Am@W - W@Am)**2))
                t2 = float(np.trace(Am@Am@W@W))
                l5core = wv_direct - (-0.25*g - 0.5*t2)
                if trial == 0:
                    print(f"  {kind:32s} {label:26s} mass={mass:.6f} (2(n-2)|v|^2={2*(n-2)*s*s:.4f}) "
                          f"|#-def|={abs(wv-wv_direct):.1e} L1core={l1core:+.1e} L5core={l5core:+.1e} Dsign={'>=0' if D>=-1e-12 else 'NEG!'}")
