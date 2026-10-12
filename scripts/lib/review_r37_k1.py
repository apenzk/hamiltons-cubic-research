"""K1: is sharp_bilin(I_p, V) = -V/2 on the RAW (pp,mix) support block?
Three readings of 'generic V supported on (pp,mix)':
  (a) raw symmetric V, arbitrary entries in the (pp,mix) off-diagonal support;
  (b) V additionally in Weyl_n;
  (c) V raw but averaged over O(p)xO(q) into the isotypic piece.
Also: is the image even supported on (pp,mix)?"""
import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r37_core import *

def mask_ppmix(p,q):
    k = kinds(p,q); N=len(k)
    M = np.zeros((N,N))
    for a in range(N):
        for b in range(N):
            if (k[a]==0 and k[b]==1) or (k[b]==0 and k[a]==1): M[a,b]=1.0
    return M

def support_in_weyl(B, mask, tol=1e-8):
    """Orthonormal basis of {V in span(B) : V = mask*V}, via the compression of the
    orthogonal projector P_mask to span(B) -- eigenvalue exactly 1."""
    D=B.shape[0]
    S = np.zeros((D,D))
    for j in range(D): S[:,j] = coords(B, mask*B[j])
    S = 0.5*(S+S.T)
    w,v = np.linalg.eigh(S)
    sel = v[:, w>1-tol]
    return np.einsum('kd,dij->kij', sel.T, B), w

print(f"{'(p,q)':>7} | raw generic V: ratio, resid | image outside (pp,mix) | Weyl-supported V: ratio, resid | dim")
for (p,q) in [(3,4),(3,5),(4,4),(4,5),(5,5),(3,6),(4,6)]:
    n=p+q
    A = struct_A(n); B = weyl_basis(n); N=A.shape[0]
    Ip = I_block(p,q,'p'); mask = mask_ppmix(p,q)
    rng = np.random.default_rng(1000+10*p+q)
    # (a) raw
    R = rng.normal(size=(N,N)); V = (R+R.T)*mask
    S = sharp_bilin(Ip, V, A)
    c = ip(S,V)/ip(V,V); resid = np.linalg.norm(S-c*V)/np.linalg.norm(V)
    off = np.linalg.norm(S*(1-mask))/np.linalg.norm(S)
    # (b) inside Weyl
    Bs, w = support_in_weyl(B, mask)
    d = Bs.shape[0]
    if d:
        V2 = expand(Bs, rng.normal(size=d))
        S2 = sharp_bilin(Ip, V2, A)
        c2 = ip(S2,V2)/ip(V2,V2); r2 = np.linalg.norm(S2-c2*V2)/np.linalg.norm(V2)
    else:
        c2=r2=float('nan')
    print(f"({p},{q}) | c={c:+.4f} resid={resid:.3f} | off-support {off:.3f} | c={c2:+.10f} resid={r2:.2e} | dim={d} (X(p)q={p*(p*p-4)//3*q})", flush=True)
