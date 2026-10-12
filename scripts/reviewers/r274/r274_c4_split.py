"""r274, Claim 4: the spectral split W^# = W_+^# + W_-^# - 2 W_+#W_-, and whether
Theorem 1 + L2 reach ||W^#||_F.  Independent build; no imports from scripts/."""
import numpy as np, sys, itertools
sys.path.insert(0, __file__.rsplit('/',1)[0])
from r274_weyl import Geo

def theta0(n): return np.sqrt(2.0*(n-1)*(n-2))/n

def sphere_product(g):
    m = g.n//2
    lam = np.array([1.0 if (i<m)==(j<m) else 0.0 for i,j in g.idx])
    c = 2.0*(m-1)/(g.n-2) - 2.0*m*(m-1)/((g.n-1)*(g.n-2))
    w = lam-c; return np.diag(w/np.linalg.norm(w))

def split(g, M):
    ev, V = np.linalg.eigh(M)
    Wp = V @ np.diag(np.clip(ev,0,None)) @ V.T
    Wm = V @ np.diag(np.clip(-ev,0,None)) @ V.T
    Sp, Sm = g.sharp(Wp), g.sharp(Wm)
    cross = 0.5*(g.sharp(Wp+Wm) - Sp - Sm)
    return Wp, Wm, Sp, Sm, cross

for n in (6, 8, 10, 12):
    g = Geo(n)
    for lab, M in (("S^mxS^m", sphere_product(g)),
                   ("random Weyl", None)):
        if M is None:
            rng = np.random.default_rng(5); A = rng.standard_normal((g.N,g.N))
            M = g.proj_weyl(0.5*(A+A.T)); M /= np.linalg.norm(M)
        Wp, Wm, Sp, Sm, cross = split(g, M)
        Ssum = Sp + Sm - 2*cross
        S = g.sharp(M)
        parts = Sp + Sm
        tau = float(np.trace(Wm))
        # Ric and Alt of W_-  (the package's rho and omega), from the 4-tensor
        Rm = g.to_tensor(Wm)
        rho = np.einsum('ijkj->ik', Rm)
        Alt = (Rm + np.transpose(Rm,(0,2,3,1)) + np.transpose(Rm,(0,3,1,2)))/3.0
        d2 = float(np.sum(Alt*Alt))/4.0   # normalisation-free: only used for the identity shape
        print(f"n={n:>2} {lab:>12}: ||W^# - (Wp^#+Wm^#-2cross)||={np.linalg.norm(S-Ssum):.2e}"
              f"  minEig(cross)={np.linalg.eigvalsh(cross)[0]:+.3e} minEig(parts)={np.linalg.eigvalsh(parts)[0]:+.3e}")
        print(f"      ||W^#||_F={np.linalg.norm(S):.5f} | ||parts||_F={np.linalg.norm(parts):.5f}"
              f"  2||cross||_F={2*np.linalg.norm(cross):.5f}  triangle bound={np.linalg.norm(parts)+2*np.linalg.norm(cross):.5f}"
              f"  ({(np.linalg.norm(parts)+2*np.linalg.norm(cross))/np.linalg.norm(S):.2f}x)")
        print(f"      tau={tau:.5f}  tr(parts)={np.trace(parts):.5f} (L2 cap 2tau^2={2*tau**2:.5f})"
              f"  2tr(cross)={2*np.trace(cross):.5f}  ||rho||^2={np.sum(rho*rho):.5f}"
              f"  => PSD chain tr(parts)+2tr(cross)={np.trace(parts)+2*np.trace(cross):.5f}"
              f"  ({(np.trace(parts)+2*np.trace(cross))/np.linalg.norm(S):.1f}x ||W^#||_F,"
              f" {(np.trace(parts)+2*np.trace(cross))/theta0(n):.1f}x theta_0)")
        print(f"      L2 chain tr(parts)<=2tau^2 gives ||W^#||_F <= 2tau^2+||rho||^2+6delta^2"
              f" = {2*tau**2+np.sum(rho*rho)+2*np.trace(cross)-np.sum(rho*rho):.4f}+... ; theta_0={theta0(n):.5f}")
        # the L3 caution: is tr(W^#) = -||W||^2 ?
        print(f"      trace(W^#) = {np.trace(S):+.6f}   -||W||_F^2 = {-np.sum(M*M):+.6f}")
        print()
