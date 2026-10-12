"""L1: does criticality split by block, and does the split need gradedness?"""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *

np.set_printoptions(precision=6, suppress=True)

def blocks(n, p, W):
    ip, im = pm_index(n, p)
    N = W.shape[0]
    A = np.zeros_like(W); A[np.ix_(ip, ip)] = W[np.ix_(ip, ip)]
    B = np.zeros_like(W); B[np.ix_(im, im)] = W[np.ix_(im, im)]
    return ip, im, A, B

def report(name, n, p, W):
    ip, im, A, B = blocks(n, p, W)
    off = np.abs(W[np.ix_(ip, im)]).max()
    th = float(np.tensordot(Q(n, W), W))
    crit = np.abs(Q(n, W) - th*W).max()
    S = sharp(n, W)
    # the two scalar equations
    e1 = th*np.linalg.norm(A)**2 - (np.trace(A@A@A) + np.tensordot(A, S))
    e2 = th*np.linalg.norm(B)**2 - (np.trace(B@B@B) + np.tensordot(B, S))
    # where does sharp put each piece?
    AA, AB, BB = sharp_bilin(n,A,A), sharp_bilin(n,A,B), sharp_bilin(n,B,B)
    def mass(X):
        return (np.linalg.norm(X[np.ix_(ip,ip)]), np.linalg.norm(X[np.ix_(im,im)]),
                np.linalg.norm(X[np.ix_(ip,im)]))
    print(f"\n== {name}  n={n} pair so({p})+so({n-p})  dim p={len(ip)} dim m={len(im)}")
    print(f"   offblock(W)={off:.2e}  theta={th:.9f}  crit={crit:.2e}")
    la, lb = np.linalg.eigvalsh(A[np.ix_(ip,ip)]), np.linalg.eigvalsh(B[np.ix_(im,im)])
    print(f"   A eigs min/max {la.min():.6f}/{la.max():.6f}   B eigs min/max {lb.min():.6f}/{lb.max():.6f}"
          f"   graded={'YES' if la.min()>1e-9 and lb.max()<-1e-9 else 'NO'}")
    print(f"   |A|^2 = {np.linalg.norm(A)**2:.9f}   |B|^2 = {np.linalg.norm(B)**2:.9f}")
    print(f"   L1 residuals:  p-eq {e1:.3e}   m-eq {e2:.3e}")
    for nm, X in (('A#A', AA), ('A#B', AB), ('B#B', BB)):
        pp, mm, pm = mass(X)
        print(f"   {nm}: |pp|={pp:.6f} |mm|={mm:.6f} |pm|={pm:.2e}")
    print(f"   <A, (B#B)|p> = {np.tensordot(A, BB):.9f}   <A,(A#A)|p> = {np.tensordot(A,AA):.9f}")
    print(f"   <B, 2(A#B)|m> = {2*np.tensordot(B, AB):.9f}")
    print(f"   tr A^3 = {np.trace(A@A@A):.9f}   tr B^3 = {np.trace(B@B@B):.9f}")
    return th, np.linalg.norm(A)**2

n = 8
Wsp = sphere_product_W(n, 3)
report('S^3 x S^5', n, 3, Wsp)
Ww = np.load('scripts/data/w_n8_nondiagonal_witness.npy'); Ww /= np.linalg.norm(Ww)
report('n=8 witness', n, 3, Ww)

# --- is the split trivial?  test on a splitting that is NOT a Z_2 grading ---
print("\n== TRIVIALITY TEST: same critical W, splitting by an arbitrary group of eigenspaces")
W = Wsp
lam, V = np.linalg.eigh(W)
rng = np.random.default_rng(0)
for trial in range(3):
    keep = rng.permutation(len(lam))[:11]
    Pv = V[:, keep] @ V[:, keep].T          # projector onto a W-invariant subspace
    Qv = np.eye(len(lam)) - Pv
    A = Pv @ W @ Pv; B = Qv @ W @ Qv
    th = float(np.tensordot(Q(n, W), W)); S = sharp(n, W)
    e1 = th*np.linalg.norm(A)**2 - (np.trace(A@A@A) + np.tensordot(A, S))
    e2 = th*np.linalg.norm(B)**2 - (np.trace(B@B@B) + np.tensordot(B, S))
    # is the sharp sorted?
    AA, AB, BB = sharp_bilin(n,A,A), sharp_bilin(n,A,B), sharp_bilin(n,B,B)
    srt = (np.linalg.norm(Qv@AA@Qv), np.linalg.norm(Pv@AB@Pv), np.linalg.norm(Qv@BB@Qv))
    print(f"  trial {trial}: L1 resid p {e1:.2e}  m {e2:.2e} | "
          f"leak |A#A|_perp={srt[0]:.4f} |A#B|_V={srt[1]:.4f} |B#B|_perp={srt[2]:.4f}")
