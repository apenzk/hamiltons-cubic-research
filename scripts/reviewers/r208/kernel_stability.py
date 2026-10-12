"""r208, claim 5: is sigma_13 signal, or is dim ANN really 2?

The kernel of the coefficient matrix is INTRINSIC -- it is ANN in the Phi basis,
and does not depend on which x_a or which v_r were sampled.  A signal direction
does depend on the sample.  So compare the bottom-TWO right singular subspaces
of two independent runs by principal angles:

   dim ANN = 1  ->  ONE small angle (the shared kernel) and one LARGE one;
   dim ANN = 2  ->  BOTH angles small, the whole 2-plane shared.

Both runs express alpha in the same Phi basis, so the subspaces are directly
comparable even though the sampled points differ.
"""
import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L, sextics as SX

BAS = SX.load_basis(); NV = 25
def bottom(path, seed, k):
    rng = np.random.default_rng(seed)
    _ = rng.standard_normal((30, 35)); _ = rng.standard_normal((40, 35))
    V = rng.standard_normal((NV, 35)); V /= np.linalg.norm(V, axis=1, keepdims=True)
    V[0] = L.w0
    PHI = np.array([[SX.evaluate(m, SX.tensor(V[p])).real for m in BAS] for p in range(NV)])
    AL = np.linalg.lstsq(PHI, np.load(path).T, rcond=None)[0].T
    AL = AL/np.linalg.norm(AL, axis=1, keepdims=True)
    _, sv, Vt = np.linalg.svd(AL)
    return Vt[-k:].T, sv

RUNS = [("/tmp/r208_E_100000_7777.npy", 7777), ("/tmp/r208_E_200000_31337.npy", 31337)]
for k in (1, 2, 3):
    A, s1 = bottom(*RUNS[0], k); B, s2 = bottom(*RUNS[1], k)
    ang = np.degrees(np.arccos(np.clip(np.linalg.svd(A.T @ B, compute_uv=False), -1, 1)))
    print(f"bottom-{k} subspaces, principal angles (degrees): "
          f"{np.array2string(ang, precision=3)}")
print("\n  one small angle and the rest large  =>  the shared kernel is"
      " 1-dimensional, dim ANN = 1")
P0 = np.array([SX.evaluate(m, SX.tensor(L.w0)).real for m in BAS]); P0 /= np.linalg.norm(P0)
for path, seed in RUNS:
    A, sv = bottom(path, seed, 1)
    print(f"  {os.path.basename(path)}: null vector to (Phi_r(W_0)) "
          f"{np.degrees(np.arccos(min(1, abs(float(A[:,0] @ P0))))):.4f} deg,"
          f"  sigma_13/sigma_14 = {sv[12]/sv[13]:.0f}")
