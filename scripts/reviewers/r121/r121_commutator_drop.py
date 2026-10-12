import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
SP=_os.path.join(_ROOT, 'scripts/reviewers/r121/')
exec(open(SP+'r121_noncritical_and_projection.py').read().split('print("=== (b/d)')[0])
print("=== cost of 'drop the commutator mass' at the equality case ===")
for n in [4,6,8,10]:
    Wc=pad(cp2(),n); Wc/=np.sqrt(op_norm2(Wc))
    ev,h=bottom(Wc); mu=-ev[0]; t1,t2,t3=LOSS(Wc,h); lam=ip4(Wc,Q(Wc))
    sharp=t2-mu*mu
    N=np.einsum('impq,kmpq->ik',Wc,Wc)
    bound=(-t3-sharp)/mu; bmax=(0.5*np.linalg.eigvalsh(N).max()-sharp)/mu
    print(f" padded CP^2 n={n}: lam={lam:.6f} t1(dropped)={t1:.6f} t2={t2:.6f} t3={t3:.6f}")
    print(f"    drop-commutator bound lam<= {bound:.6f}  (= sqrt(8/3)={np.sqrt(8/3):.6f}), via lam_max(N): {bmax:.6f}; target {np.sqrt(1.5):.6f}; overshoot {bound/np.sqrt(1.5)-1:+.1%}")
print()
print("=== same relaxation at balanced sphere products (branch-1 equality case) ===")
for (p,q) in [(2,2),(3,3),(4,4),(6,6)]:
    W=sphere_prod(p,q,1.,1.); n=p+q; W/=np.sqrt(op_norm2(W))
    ev,h=bottom(W); mu=-ev[0]; t1,t2,t3=LOSS(W,h); lam=ip4(W,Q(W))
    sharp=t2-mu*mu; N=np.einsum('impq,kmpq->ik',W,W)
    bound=(-t3-sharp)/mu
    print(f" S^{p}xS^{q} n={n}: lam={lam:.6f} t1(dropped)={t1:.6f} drop-commutator bound={bound:.6f} Theta_n={np.sqrt(2*(n-1)*(n-2))/n:.6f} overshoot {bound/lam-1:+.1%}")
