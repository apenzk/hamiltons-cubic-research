"""Reviewer 55, K2: degeneracy and the L_e spectrum at the C_5 blow-up."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k1 import c5_vertex

def Le_matrix(n, e, B):
    """L_e restricted to the span of B (orthonormal), as a D x D matrix."""
    c = struct(n); N = c.shape[0]; D = B.shape[0]
    U = np.einsum('am,dmn->adn', e, c, optimize=True)             # (N,N,N)
    ct = np.ascontiguousarray(c.transpose(0,2,1)).reshape(N*N, N) # [g,b | a]
    Sh = 0.5 * (ct @ U.reshape(N, N*N))                           # (g,b, d,n)
    Sh = Sh.reshape(N,N,N,N).transpose(0,2,1,3).reshape(N*N, N*N) # (g,d | b,n)
    Bf = B.reshape(D, -1)
    sharp_part = (Sh @ Bf.T).T                                    # (D, N*N)
    anti = 0.5*(np.einsum('ij,djk->dik', e, B) + np.einsum('dij,jk->dik', B, e))
    img = sharp_part + anti.reshape(D,-1)
    M = Bf @ img.T                                                # M[i,j] = <B_i, e o B_j>
    return M

def main():
    n = 10
    lam,_ = c5_vertex([2]*5)
    W = diag_operator(lam); W = W/np.linalg.norm(W)
    th = float(np.tensordot(W, Q(n,W))); e = W/th
    B = weyl_basis(n); D = B.shape[0]; Bf = B.reshape(D,-1)
    print(f"n={n}, dim Weyl = {D}, theta = {th:.12f}")
    t=time.time(); M = Le_matrix(n, e, B); print(f"  L_e built in {time.time()-t:.1f}s")
    print(f"  symmetry ||M-M^T|| = {np.abs(M-M.T).max():.2e}")
    print(f"  trace(L_e)         = {np.trace(M):.2e}   (should be 0)")
    Ms = 0.5*(M+M.T)
    wv = Bf @ W.ravel()
    print(f"  ||L_e W - W||      = {np.linalg.norm(Ms@wv - wv):.2e}")
    ev, V = np.linalg.eigh(Ms)
    print(f"  spectrum range     = [{ev.min():.9f}, {ev.max():.9f}]")
    for tol in (1e-8, 1e-6):
        print(f"  dim E(1/2) (tol {tol:g}) = {(np.abs(ev-0.5)<tol).sum()}")
    # eigenvalue multiplicities
    from collections import Counter
    cnt = Counter(np.round(ev,7))
    print("  distinct eigenvalues (value: multiplicity):")
    for v,m in sorted(cnt.items()): print(f"     {v:12.7f} : {m}")
    # orbit
    OT = orbit_tangent(n, W)
    Ob = onb(OT)
    print(f"  dim orbit tangent  = {Ob.shape[0]}")
    # orbit inside Weyl?
    proj = Ob - (Ob @ Bf.T) @ Bf
    print(f"  orbit inside Weyl_n: leak {np.linalg.norm(proj):.2e}")
    # orbit inside E(1/2)?
    half = V[:, np.abs(ev-0.5)<1e-8]
    Ocoef = (Ob @ Bf.T)
    Ocoef = np.linalg.qr(Ocoef.T)[0]
    cos = np.linalg.svd(Ocoef.T @ half, compute_uv=False)
    print(f"  principal cosines orbit vs E(1/2): min={cos.min():.12f} max={cos.max():.12f}")
    print(f"  EXCESS = {half.shape[1]} - {Ob.shape[0]} = {half.shape[1]-Ob.shape[0]}")
    # lambda_max on W-perp
    mask = np.abs(V.T @ wv) < 1e-6
    lam_perp = ev[mask]
    print(f"  lambda_max(L_e | W-perp) = {lam_perp.max():.9f}")
    print(f"  (eigenvalue of W direction = {ev[~mask]})")
    np.save('scratchpad/r55_ev.npy', ev)
    np.save('scratchpad/r55_V.npy', V)

if __name__=="__main__": main()
