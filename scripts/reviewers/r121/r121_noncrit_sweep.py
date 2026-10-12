import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
SP=_os.path.join(_ROOT, 'scripts/reviewers/r121/')
exec(open(SP+'r121_noncritical_and_projection.py').read().split('print("=== (b/d)')[0])
print("=== LOSS - mu^2/n at random unit Weyl tensors (non-critical), 1000 draws ===")
for n in [4,5,6,7,8]:
    rng=np.random.default_rng(77000+n); bad=0; worst=9e9; wex=None
    for t in range(1000 if n<8 else 300):
        W=rand_weyl(n,rng); W/=np.sqrt(op_norm2(W))
        ev,h=bottom(W); mu=-ev[0]; L=sum(LOSS(W,h)); d=L-mu*mu/n
        gap=ev[1]-ev[0]
        if d<worst: worst=d; wex=(mu,gap,ip4(W,Q(W)),np.abs(Q(W)-ip4(W,Q(W))*W).max())
        bad+= d<-1e-9
    N=1000 if n<8 else 300
    print(f" n={n}: {bad}/{N} violations, worst {worst:+.6f}  (at mu={wex[0]:.4f}, ring gap={wex[1]:.4f}, theta={wex[2]:.4f}, crit_res={wex[3]:.2f})")
print()
print("=== targeted: perturb padded CP^2 inside Weyl_n, stay non-critical ===")
for n in [5,6,8]:
    rng=np.random.default_rng(5+n)
    W0=pad(cp2(),n); W0/=np.sqrt(op_norm2(W0))
    for eps in [0.05,0.2,0.5]:
        P=rand_weyl(n,rng); P/=np.sqrt(op_norm2(P))
        W=W0+eps*P; W/=np.sqrt(op_norm2(W))
        ev,h=bottom(W); mu=-ev[0]; L=sum(LOSS(W,h))
        print(f"  n={n} eps={eps}: theta={ip4(W,Q(W)):.5f} crit_res={np.abs(Q(W)-ip4(W,Q(W))*W).max():.2f} mu={mu:.5f} LOSS-mu^2/n={L-mu*mu/n:+.6f}")
