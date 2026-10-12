"""r208, claim 4: hunt for v with v^3 in C off the orbit cone of W_0.

rho(v) = |P_C v^3|^2/|v^3|^2 in [0,1], equal to 1 exactly when v lies in V(K).

Two things reviewer 203's twelve real ascents did not do:
  (1) many more restarts, from random and from structured starts;
  (2) the COMPLEX search.  If v in C^35 has v^3 in C tensor C then Re A(v^6) and
      Im A(v^6) are BOTH real elements of ANN, because Cat is real-linear in F
      and Cat_F(K,K)=0 splits into its real and imaginary parts.  V(K) is a real
      variety whose real points may be far smaller than its complex ones, so the
      real search is the wrong ambient space for the question the file asks.
"""
import sys, os, time, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L
from scipy.optimize import minimize

t0 = time.time()
U = np.load("/tmp/r208_U.npy")
G = (U @ U.T)**3
w, V = np.linalg.eigh(G); keep = w > 1e-9*w.max()
Gp = (V[:, keep]/w[keep]) @ V[:, keep].T
print(f"dim C = {keep.sum()};  setup {time.time()-t0:.1f}s", flush=True)

def rho_grad(v):
    s = U @ v; b = s**3; c = Gp @ b
    N = float(b @ c); n2 = float(v @ v); D = n2**3
    gN = 6.0*(U.T @ (c*s*s))
    return N/D, (gN*D - N*6.0*n2**2*v)/D**2

def rho_grad_c(z):
    a, bb = z[:35], z[35:]; v = a + 1j*bb
    s = U @ v; b = s**3; c = Gp @ b
    N = float(np.vdot(b, c).real); n2 = float(a@a + bb@bb); D = n2**3
    g = 3.0*(U.T @ (np.conj(c)*s*s))
    gN = np.concatenate([2*g.real, -2*g.imag])
    return N/D, (gN*D - N*6.0*n2**2*np.concatenate([a, bb]))/D**2

rng = np.random.default_rng(0)
for f, dim in ((rho_grad, 35), (rho_grad_c, 70)):
    x = rng.standard_normal(dim); r, g = f(x)
    e = np.zeros(dim); e[3] = 1e-6
    print(f"  gradient check dim {dim}: analytic {g[3]:.9f}  finite-difference "
          f"{(f(x+e)[0]-f(x-e)[0])/2e-6:.9f}", flush=True)

def spec(v):
    v = v/np.linalg.norm(v)
    return np.sort(np.linalg.eigvalsh(L.expand(v)))
W0S = spec(L.w0)
def on_orbit(v, tol=1e-4):
    s = spec(v)
    return min(np.abs(s-W0S).max(), np.abs(s+W0S[::-1]).max()) < tol

def ascend(f, x0, maxiter=250):
    r = minimize(lambda z: (lambda p: (-p[0], -p[1]))(f(z)), x0, jac=True,
                 method="L-BFGS-B", options=dict(maxiter=maxiter, ftol=1e-16, gtol=1e-12))
    x = r.x/np.linalg.norm(r.x)
    return x, f(x)[0]

rng = np.random.default_rng(2081)
NR = 120
print(f"\n=== REAL ascents ({NR} restarts) ===", flush=True)
hits, offs, best_off, tops = 0, [], 0.0, []
for i in range(NR):
    x, r = ascend(rho_grad, rng.standard_normal(35))
    tops.append(r)
    if r > 1-1e-6:
        hits += 1
        if not on_orbit(x):
            offs.append((r, x)); print(f"  !!! OFF-ORBIT rho={r:.12f} spec={spec(x)}", flush=True)
    else:
        best_off = max(best_off, r)
    if (i+1) % 20 == 0:
        print(f"   {i+1}/{NR}  hits {hits}  off-orbit {len(offs)}  "
              f"best sub-1 {best_off:.6f}  [{time.time()-t0:.0f}s]", flush=True)
tops = np.sort(np.array(tops))[::-1]
print(f"  {NR} restarts: {hits} reached rho=1; off the orbit cone: {len(offs)}")
print(f"  largest rho among the {NR-hits} that did not reach 1: {best_off:.6f}")
print(f"  top 12 values: {np.round(tops[:12], 6)}")

NC = 120
print(f"\n=== COMPLEX ascents ({NC} restarts) ===", flush=True)
hitsc, offc, best_offc = 0, [], 0.0
for i in range(NC):
    x, r = ascend(rho_grad_c, rng.standard_normal(70))
    if r > 1-1e-6:
        hitsc += 1
        v = x[:35] + 1j*x[35:]
        sv = np.linalg.svd(np.stack([v.real, v.imag]), compute_uv=False)
        if sv[1]/sv[0] > 1e-5: offc.append((r, x, sv[1]/sv[0]))
    else:
        best_offc = max(best_offc, r)
    if (i+1) % 20 == 0:
        print(f"   {i+1}/{NC}  hits {hitsc}  genuinely complex {len(offc)}  "
              f"best sub-1 {best_offc:.6f}  [{time.time()-t0:.0f}s]", flush=True)
print(f"  {NC} restarts: {hitsc} reached rho=1")
print(f"  of those, {len(offc)} have Re v and Im v independent (not a complex")
print(f"  scalar times a real point, i.e. genuinely off the complexified cone)")
if offc:
    r, x, p = max(offc, key=lambda t: t[2])
    print(f"  largest independence ratio {p:.3e} at rho={r:.12f}")
    np.save("/tmp/r208_complex_witness.npy", x)
print(f"  largest rho among the {NC-hitsc} that did not reach 1: {best_offc:.6f}")

print(f"\n=== STRUCTURED starts ===", flush=True)
# padded Weyl tensors of S^2 x S^3 and of low-rank / diagonal operators, plus
# sums of two orbit points -- points a random start is unlikely to reach.
cands = {}
E = np.eye(35)
for k in range(6):
    cands[f"basis e_{k}"] = E[k].copy()
o = L.orbit(6, seed=77)
for k in range(1, 5):
    cands[f"W_0 + g_{k} W_0"] = L.w0 + o[k]
    cands[f"W_0 - g_{k} W_0"] = L.w0 - o[k]
for k in range(4):
    cands[f"random rank-1 lift {k}"] = L.coords(np.outer(*(2*[np.linalg.qr(
        np.random.default_rng(k).standard_normal((10, 1)))[0][:, 0]])))
for nm, v in cands.items():
    if np.linalg.norm(v) < 1e-12: continue
    x, r = ascend(rho_grad, v)
    tag = "ON orbit" if (r > 1-1e-6 and on_orbit(x)) else ("OFF ORBIT !!!" if r > 1-1e-6 else "sub-1")
    print(f"  {nm:24s} start rho={rho_grad(v)[0]:.6f}  ->  {r:.10f}  {tag}")
print(f"\ntotal {time.time()-t0:.0f}s")
