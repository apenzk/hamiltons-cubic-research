"""r208, claim 4: does a complex maximiser of rho give a SECOND obstruction?

A(v^6) is a new element of ANN exactly when it is NOT proportional to A(W_0^6).
Since <A(v^6), Phi> is proportional to Phi(v) for every invariant sextic Phi,
and the 14 Phi_r span the invariant sextics,

    A(v^6) proportional to A(W_0^6)   <=>   (Phi_r(v))_r  proportional to  (Phi_r(W_0))_r.

This test subsumes the geometry.  The set {v : A(v^6) in C.A(W_0^6)} is Zariski
closed and contains the orbit cone, hence contains its closure, so a point of the
closure -- including the non-semisimple boundary points the ascents reach -- can
never separate.  A v that DOES separate is off the closure and is a witness.
"""
import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L, sextics as SX
from scipy.optimize import minimize

BAS = SX.load_basis()
U = np.load("/tmp/r208_U.npy")
G = (U @ U.T)**3
w, V = np.linalg.eigh(G); keep = w > 1e-9*w.max()
Gp = (V[:, keep]/w[keep]) @ V[:, keep].T

def rho_grad_c(z):
    a, bb = z[:35], z[35:]; v = a + 1j*bb
    s = U @ v; b = s**3; c = Gp @ b
    Nn = float(np.vdot(b, c).real); n2 = float(a@a + bb@bb); D = n2**3
    g = 3.0*(U.T @ (np.conj(c)*s*s))
    return Nn/D, (np.concatenate([2*g.real, -2*g.imag])*D
                  - Nn*6.0*n2**2*np.concatenate([a, bb]))/D**2

def phivec(v):
    R = SX.tensor(np.asarray(v))
    return np.array([SX.evaluate(m, R) for m in BAS])

P0 = phivec(L.w0.astype(complex))
print("Phi_r(W_0), the 14 invariant sextics at W_0:")
print("  ", np.array2string(P0.real, precision=6, max_line_width=110))
print(f"   |Phi(W_0)| = {np.linalg.norm(P0):.6f}")

def sep(v):
    """relative distance of (Phi_r(v)) from the line through (Phi_r(W_0))."""
    p = phivec(v)
    n = np.linalg.norm(p)
    if n == 0: return np.nan, p
    q = p/n; e = P0/np.linalg.norm(P0)
    return float(np.linalg.norm(q - (np.vdot(e, q))*e)), p

# --- control: real orbit points must NOT separate; random points must ---
print("\ncontrol -- separation from the A(W_0^6) line:")
for k, gpt in enumerate(L.orbit(3, seed=4242)):
    print(f"   real orbit point {k}: {sep(gpt.astype(complex))[0]:.3e}   (must be ~0)")
rng = np.random.default_rng(31)
for k in range(3):
    print(f"   random point    {k}: {sep(rng.standard_normal(35).astype(complex))[0]:.3e}"
          f"   (must be O(1))")

print("\ncomplex maximisers of rho:")
print("  rho            rank(M)  separation from the A(W_0^6) line   verdict")
rng = np.random.default_rng(20811)
newhits = 0
for i in range(40):
    r = minimize(lambda z: (lambda p: (-p[0], -p[1]))(rho_grad_c(z)),
                 rng.standard_normal(70), jac=True, method="L-BFGS-B",
                 options=dict(maxiter=400, ftol=1e-16, gtol=1e-13))
    z = r.x/np.linalg.norm(r.x); rho = rho_grad_c(z)[0]
    v = z[:35] + 1j*z[35:]
    M = L.expand(v); sv = np.linalg.svd(M, compute_uv=False)
    rk = int((sv > 1e-7*sv[0]).sum())
    d, _ = sep(v)
    new = rho > 1-1e-6 and d > 1e-6
    newhits += new
    print(f"  {rho:.10f}    {rk}      {d:.3e}    "
          f"{'*** SECOND OBSTRUCTION ***' if new else 'A(v^6) prop. to A(W_0^6)'}")
print(f"\n{newhits} of 40 complex maximisers give an element of ANN independent of A(W_0^6)")
