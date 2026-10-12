"""r208, claim 5: the conclusion stated as the thing the route actually needs.

rank = 13 says the image of the certificate map on K is the WHOLE 13-dimensional
space of invariant sextics vanishing at W_0.  F_5 is one of them.  This checks it
directly rather than by inference: F_5 is expanded in the 14 explicit sextics by
evaluation, and the residual of its projection onto span{A(x_a^2)} is measured.

F_5 = (3/2)|W|^6 - 9 tr(W^3)^2 with |W|^2 = tr(M^2), M the Lambda^2 operator;
F_5(W_0) = 3/2 - 9/6 = 0 exactly, which is how W_0 enters at all.
"""
import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L, sextics as SX

BAS = SX.load_basis(); NV = 25
E = np.load(sys.argv[1]); SEED = int(sys.argv[2])
rng = np.random.default_rng(SEED)
_ = rng.standard_normal((30, 35)); _ = rng.standard_normal((40, 35))
V = rng.standard_normal((NV, 35)); V /= np.linalg.norm(V, axis=1, keepdims=True)
V[0] = L.w0
PHI = np.array([[SX.evaluate(m, SX.tensor(V[p])).real for m in BAS] for p in range(NV)])

def F5(v):
    M = L.expand(v)
    return 1.5*np.trace(M @ M)**3 - 9.0*np.trace(M @ M @ M)**2
print(f"F_5(W_0) = {F5(L.w0):.3e}   (must be 0)")
print(f"F_5 at three random unit points: "
      f"{[round(F5(V[k]), 6) for k in (1, 2, 3)]}")

f5 = np.array([F5(V[p]) for p in range(NV)])
c, res, rk, _ = np.linalg.lstsq(PHI, f5, rcond=None)
resid = np.linalg.norm(PHI @ c - f5)/np.linalg.norm(f5)
print(f"\nF_5 expanded in the 14 explicit sextics: relative residual {resid:.3e}"
      f"   (so F_5 IS a degree-6 invariant, an independent check on the basis)")

AL = np.linalg.lstsq(PHI, E.T, rcond=None)[0].T
AL = AL/np.linalg.norm(AL, axis=1, keepdims=True)
Q, _ = np.linalg.qr(AL.T)                                  # onb of span{A(x_a^2)}
Q13 = Q[:, :13]
u = c/np.linalg.norm(c)
print(f"\nprojection of F_5 onto span{{A(x_a^2)}} (13-dimensional):")
print(f"   residual  |F_5 - P F_5| / |F_5| = {np.linalg.norm(u - Q13 @ (Q13.T @ u)):.3e}")
p0 = np.array([SX.evaluate(m, SX.tensor(L.w0)).real for m in BAS])
print(f"\ncontrol -- the SAME projection applied to the one sextic known NOT to be")
print(f"in the image, the A(W_0^6) direction (Phi_r(W_0))_r:")
q = p0/np.linalg.norm(p0)
print(f"   residual = {np.linalg.norm(q - Q13 @ (Q13.T @ q)):.3e}   (must be ~1)")
rng2 = np.random.default_rng(9)
for k in range(3):
    z = rng2.standard_normal(14); z /= np.linalg.norm(z)
    print(f"   a random direction in the 14: residual "
          f"{np.linalg.norm(z - Q13 @ (Q13.T @ z)):.3e}")
