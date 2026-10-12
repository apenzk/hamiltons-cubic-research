"""L1 on the SPECTRAL splitting: p = strictly positive eigenspace of W, m = strictly negative."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *

def spectral_split(n, W, tol=1e-9):
    lam, V = np.linalg.eigh(W)
    ip = lam > tol; im = lam < -tol; iz = np.abs(lam) <= tol
    Pp = V[:, ip] @ V[:, ip].T
    Pm = V[:, im] @ V[:, im].T
    return lam, V, Pp, Pm, int(iz.sum())

def brackets(n, V, mask1, mask2, maskT):
    """||component of [x,y] outside span(maskT)||, max over basis pairs, using so(n) brackets."""
    c = cstruct(n)                       # c[a,b,g]
    U1 = V[:, mask1]; U2 = V[:, mask2]; UT = V[:, maskT]
    # bracket in the eigenbasis: [U1_i, U2_j] = sum_g (c contracted)
    Br = np.einsum('abg,ai,bj->ijg', c, U1, U2, optimize=True)
    PT = UT @ UT.T
    resid = Br - np.einsum('ijg,gh->ijh', Br, PT)
    return float(np.abs(resid).max()), float(np.abs(Br).max())

def report(name, n, W):
    W = W / np.linalg.norm(W)
    th = float(np.tensordot(Q(n, W), W))
    crit = np.abs(Q(n, W) - th*W).max()
    lam, V, Pp, Pm, nz = spectral_split(n, W)
    A = Pp @ W @ Pp; B = Pm @ W @ Pm
    S = sharp(n, W)
    e1 = th*np.linalg.norm(A)**2 - (np.trace(A@A@A) + np.tensordot(A, S))
    e2 = th*np.linalg.norm(B)**2 - (np.trace(B@B@B) + np.tensordot(B, S))
    AA, AB, BB = sharp_bilin(n,A,A), sharp_bilin(n,A,B), sharp_bilin(n,B,B)
    def sortedness(X):
        return (np.linalg.norm(Pp@X@Pp), np.linalg.norm(Pm@X@Pm),
                np.linalg.norm(Pp@X@Pm))
    mp = lam > 1e-9; mm = lam < -1e-9
    bpp = brackets(n, V, mp, mp, mp); bpm = brackets(n, V, mp, mm, mm); bmm = brackets(n, V, mm, mm, mp)
    print(f"\n== {name}: theta={th:.9f} crit={crit:.1e} dim p={mp.sum()} dim m={mm.sum()} ker={nz}")
    print(f"   grading leaks  [p,p]->m {bpp[0]:.2e}   [p,m]->p {bpm[0]:.2e}   [m,m]->m {bmm[0]:.2e}"
          f"   (graded={'YES' if max(bpp[0],bpm[0],bmm[0])<1e-8 else 'NO'})")
    print(f"   distinct pos eigs = {len(set(np.round(lam[mp],7)))}  -> equivariant={'YES' if len(set(np.round(lam[mp],7)))<=2 else 'NO(candidate)'}")
    print(f"   |A|^2={np.linalg.norm(A)**2:.9f}  |B|^2={np.linalg.norm(B)**2:.9f}")
    print(f"   L1 residuals: p-eq {e1:.2e}   m-eq {e2:.2e}")
    for nm, X in (('A#A',AA),('A#B',AB),('B#B',BB)):
        pp, mm2, pm = sortedness(X)
        print(f"   {nm}: |pp|={pp:.6f} |mm|={mm2:.6f} |pm|={pm:.2e}")
    print(f"   trA^3={np.trace(A@A@A):.6f} <A,B#B>={np.tensordot(A,BB):.6f} <A,A#A>={np.tensordot(A,AA):.6f}")
    print(f"   trB^3={np.trace(B@B@B):.6f} <B,2A#B>={2*np.tensordot(B,AB):.6f}")
    return th, float(np.linalg.norm(A)**2)

n=8
report('S^3 x S^5', n, sphere_product_W(n,3))
report('n=8 witness', n, np.load('scripts/data/w_n8_nondiagonal_witness.npy'))
report('S^4 x S^4', n, sphere_product_W(n,4))
report('S^2 x S^6', n, sphere_product_W(n,2))
