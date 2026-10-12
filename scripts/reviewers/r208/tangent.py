"""r208, claim 4: the Zariski tangent space of V(K) at W_0, and at other points.

V(K) is the common zero locus of the cubics vanishing on the orbit cone of W_0.
A(v^6) lies in ANN exactly when v lies in V(K).  V(K) contains the orbit cone,
which is 7-dimensional (orbit 6 + the scaling direction, since dim O(5) = 10 and
the stabiliser of W_0 has dimension 4).  If the tangent space at W_0 is exactly
7-dimensional then W_0 is a smooth point, V(K) coincides with the orbit cone in
a neighbourhood, and any witness lies on a component disjoint from the orbit.

f = P_K u^3 has  grad f(W_0) = 3<u,W_0>^2 u - 3 sum_k c_k <u_k,W_0>^2 u_k,
c = G^+ (<u,u_k>^3)_k -- again only 35-dimensional inner products.
"""
import sys, os, time, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L

t0 = time.time()
U = np.load("/tmp/r208_U.npy")
G = (U @ U.T)**3
w, V = np.linalg.eigh(G); keep = w > 1e-9*w.max()
Gp = (V[:, keep]/w[keep]) @ V[:, keep].T
print(f"dim C = {keep.sum()};  setup {time.time()-t0:.1f}s", flush=True)

rng = np.random.default_rng(2082)

def tangent_dim(p, m=400):
    p = p/np.linalg.norm(p)
    s0 = U @ p
    Uu = rng.standard_normal((m, 35))
    Cc = ((Uu @ U.T)**3) @ Gp.T                       # (m, 4200) coefficients
    R = 3*((Uu @ p)**2)[:, None]*Uu - 3*(Cc*(s0*s0)) @ U
    sv = np.linalg.svd(R, compute_uv=False)
    d = int((sv > 1e-8*sv[0]).sum())
    return d, sv

d, sv = tangent_dim(L.w0)
print(f"\nat W_0:  dim span{{grad f(W_0) : f in K}} = {d}")
print(f"   singular value gap: sigma_{d} = {sv[d-1]:.3e}  ->  sigma_{d+1} = {sv[d]:.3e}"
      f"   (ratio {sv[d]/sv[d-1]:.2e})")
print(f"   dim T_W0 V(K) = 35 - {d} = {35-d}")
print(f"   orbit cone dimension 7;  W_0 a smooth point of V(K): {35-d == 7}")

# same at another orbit point, as a control, and at a generic point (must be 0-dim)
gp = L.orbit(1, seed=999)[0]
d2, _ = tangent_dim(gp)
print(f"\nat a second orbit point: dim T = {35-d2}")
r = rng.standard_normal(35)
d3, sv3 = tangent_dim(r)
print(f"at a generic point (NOT in V(K), so this is only the rank of the Jacobian):"
      f" rank {d3}, dim ker {35-d3}")
print(f"\ntotal {time.time()-t0:.0f}s")
