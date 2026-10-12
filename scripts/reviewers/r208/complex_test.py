"""r208, claim 4: are the complex maximisers of rho off the COMPLEXIFIED orbit cone?

The first test -- "Re v and Im v are linearly independent" -- is too weak.  The
complexified cone is {alpha * g W_0 : alpha in C, g in O(5,C)}, and O(5,C)
already contains elements taking a real W_0 to a point with independent real and
imaginary parts.  The right test is a similarity invariant.

For g in O(5,C), Lambda^2(g) is complex orthogonal, so M = expand(v) transforms
by SIMILARITY, M -> L M L^{-1}.  Hence v lies on the complexified cone only if
M is similar to alpha * M_0, i.e.

    rank M = 3, M diagonalisable, eigenvalues alpha*(2,-1,-1)/sqrt6.

Equivalently the characteristic polynomial is lambda^7 (lambda^3 - c3) up to the
scale, which in trace coordinates reads  t3^2/t2^3 = 1/6  and  t4/t2^2 = 1/2 and
t_k determined for all k.  These are polynomial identities in v, valid over C.
"""
import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L
from scipy.optimize import minimize

U = np.load("/tmp/r208_U.npy")
G = (U @ U.T)**3
w, V = np.linalg.eigh(G); keep = w > 1e-9*w.max()
Gp = (V[:, keep]/w[keep]) @ V[:, keep].T

def rho_grad_c(z):
    a, bb = z[:35], z[35:]; v = a + 1j*bb
    s = U @ v; b = s**3; c = Gp @ b
    N = float(np.vdot(b, c).real); n2 = float(a@a + bb@bb); D = n2**3
    g = 3.0*(U.T @ (np.conj(c)*s*s))
    return N/D, (np.concatenate([2*g.real, -2*g.imag])*D
                 - N*6.0*n2**2*np.concatenate([a, bb]))/D**2

M0 = L.expand(L.w0)
e0 = np.sort(np.linalg.eigvalsh(M0))[::-1]
print("W_0 Lambda^2 spectrum:", np.round(e0, 6))
t = lambda M, k: np.trace(np.linalg.matrix_power(M, k))
print(f"W_0 invariants: t3^2/t2^3 = {t(M0,3)**2/t(M0,2)**3:.9f}  (1/6 = {1/6:.9f})")
print(f"                t4  /t2^2 = {t(M0,4)/t(M0,2)**2:.9f}  (1/2)")
print(f"                t6  /t2^3 = {t(M0,6)/t(M0,2)**3:.9f}  (66/216 = {66/216:.9f})")

rng = np.random.default_rng(20811)
print("\n rho     rank(M)  |t3^2/t2^3 - 1/6|  |t4/t2^2 - 1/2|  |t6/t2^3-66/216|  verdict")
off = 0
for i in range(40):
    r = minimize(lambda z: (lambda p: (-p[0], -p[1]))(rho_grad_c(z)),
                 rng.standard_normal(70), jac=True, method="L-BFGS-B",
                 options=dict(maxiter=400, ftol=1e-16, gtol=1e-13))
    z = r.x/np.linalg.norm(r.x); rho = rho_grad_c(z)[0]
    v = z[:35] + 1j*z[35:]
    M = L.expand(v)
    sv = np.linalg.svd(M, compute_uv=False)
    rk = int((sv > 1e-7*sv[0]).sum())
    t2, t3, t4, t6 = t(M,2), t(M,3), t(M,4), t(M,6)
    d1 = abs(t3**2/t2**3 - 1/6); d2 = abs(t4/t2**2 - 0.5); d3 = abs(t6/t2**3 - 66/216)
    oncone = rk == 3 and max(d1, d2, d3) < 1e-6
    if rho > 1-1e-6 and not oncone: off += 1
    print(f" {rho:.9f}   {rk}     {d1:.3e}        {d2:.3e}       {d3:.3e}   "
          f"{'ON complexified cone' if oncone else '*** OFF CONE ***'}")
print(f"\n{off} of 40 complex maximisers are off the complexified orbit cone")
