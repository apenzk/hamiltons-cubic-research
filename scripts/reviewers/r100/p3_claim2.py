import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
from collections import Counter
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *

def sphere_product_R(m1, m2, k1=1.0, k2=1.0):
    """Riemann tensor of S^{m1}(k1) x S^{m2}(k2), n = m1+m2, as an n^4 array.
       Constant-curvature block: R_ijkl = k (g_ik g_jl - g_il g_jk)."""
    n = m1+m2
    R = np.zeros((n,n,n,n))
    for (off,mm,k) in ((0,m1,k1),(m1,m2,k2)):
        g = np.zeros((n,n))
        for a in range(off,off+mm): g[a,a]=1.0
        R += k*(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g))
    return R

print("=== CLAIM 2: balanced S^m x S^m, Weyl part ===")
for m in [2,3,4,5,6]:
    n = 2*m
    if n < 4: continue
    B = weyl_basis(n)
    R = sphere_product_R(m,m)
    MR = M_from_tensor(R,n)
    # Weyl part = orthogonal projection onto W_n
    MW,_ = project_weyl(MR, B, n)
    nrm = np.linalg.norm(MW)
    if nrm < 1e-12:
        print(f"m={m} n={n}: Weyl part vanishes"); continue
    MW = MW/nrm
    W = full_tensor(MW,n); A = Wring(W,n)
    mu = np.linalg.eigvalsh(MW); om = np.linalg.eigvalsh(A)
    Acl = 1.0/(m*np.sqrt((m-1)*(2*m-1))) if m>1 else float('nan')
    # cluster omega
    r = np.round(om,9); c = Counter(r)
    print(f"m={m} n={n}: dim S^2_0={A.shape[0]}  A_claim={Acl:.9f}")
    print("   omega clusters (value, mult):", sorted(((float(v),k) for v,k in c.items())))
    print("   claimed:", [(-2*m*(m-1)*Acl,1), (-(m-1)*Acl, m*m), (m*Acl,(m-1)*(m+2))])
    P3m, P3o = p3(mu), p3(om)
    print(f"   p3(mu)={P3m:.9f}  claim A={Acl:.9f}  diff={P3m-Acl:.2e}")
    p3o_claim = -(4*m*m-6*m-1)*Acl
    print(f"   p3(om)={P3o:.9f}  claim={p3o_claim:.9f}  diff={P3o-p3o_claim:.2e}")
    th = theta_from_M(MW,n)
    print(f"   theta={th:.9f}  theta0({n})={theta0(n):.9f}  diff={th-theta0(n):.2e}")
    print(f"   sum mu^2={np.sum(mu**2):.9f} sum om^2={np.sum(om**2):.9f}")
    # mu spectrum too
    rm=np.round(mu,9); cm=Counter(rm)
    print("   mu clusters:", sorted(((float(v),k) for v,k in cm.items())))
