"""r208, claim 5: the kernel found must BE the A(W_0^6) direction, and it is.

A(x_a^2) = sum_r alpha_{a,r} Phi_r.  A linear functional beta on the 14 kills the
image iff sum_r alpha_{a,r} beta_r = 0 for all a, i.e. beta spans the left kernel
of the coefficient matrix.  The one functional known to kill the image is
F |-> <F, A(W_0^6)>, and for the basis vectors

    <Phi_r, A(W_0^6)> = <Phi_r, W_0^6> proportional to Phi_r(W_0).

So the prediction is exact and checkable: the null vector of the fitted
coefficient matrix is proportional to (Phi_r(W_0))_r, a vector computed from a
completely different part of the machinery.  Agreement turns "rank came out 13"
into "the kernel is the direction the theory names".
"""
import sys, os, glob, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L, sextics as SX

BAS = SX.load_basis()
NV = 25
# reproduce ann_rank.py's random stream EXACTLY, so V matches the columns of E
rng = np.random.default_rng(int(sys.argv[2]) if len(sys.argv) > 2 else 7777)
_ = rng.standard_normal((30, 35))                       # Ua
_ = rng.standard_normal((40, 35))                       # rnd, the scale probe
V = rng.standard_normal((NV, 35)); V /= np.linalg.norm(V, axis=1, keepdims=True)
V[0] = L.w0
PHI = np.array([[SX.evaluate(m, SX.tensor(V[p])).real for m in BAS] for p in range(NV)])

E = np.load(sys.argv[1])
AL = np.linalg.lstsq(PHI, E.T, rcond=None)[0].T
AL = AL/np.linalg.norm(AL, axis=1, keepdims=True)
Uu, sv, Vt = np.linalg.svd(AL)
print(f"singular values / sigma_1:")
print("  ", np.array2string(sv/sv[0], precision=4, max_line_width=110))
print(f"  gap sigma_13/sigma_14 = {sv[12]/sv[13]:.1f}")

beta = Vt[-1]
P0 = np.array([SX.evaluate(m, SX.tensor(L.w0)).real for m in BAS])
b, p = beta/np.linalg.norm(beta), P0/np.linalg.norm(P0)
ang = abs(float(b @ p))
print(f"\nnull vector vs (Phi_r(W_0))_r:  |cos| = {ang:.10f}"
      f"   angle {np.degrees(np.arccos(min(1, ang))):.4f} degrees")
print(f"  relative distance to the predicted line: "
      f"{np.linalg.norm(b - np.sign(b @ p)*p):.3e}")
print("\ncontrols -- the same comparison against (Phi_r(v)) at random v:")
for k in range(4):
    q = np.array([SX.evaluate(m, SX.tensor(V[k+1])).real for m in BAS]); q /= np.linalg.norm(q)
    print(f"   random point {k}: |cos| = {abs(float(b @ q)):.6f}")
print(f"\n  second-smallest right singular vector vs (Phi_r(W_0)): "
      f"|cos| = {abs(float(Vt[-2] @ p)):.6f}   (must NOT align)")
