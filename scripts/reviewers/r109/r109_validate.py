"""Validate the capped bound B3: (a) the per-direction cap holds, (b) B3 >= theta always,
(c) how much it moves the band maximum the record complains about."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r109'))
exec(open(_os.path.join(_ROOT, 'scripts/reviewers/r109/r109_consequence.py')).read().split('print(f"{')[0])

worst_cap=-1; worst_valid=1e9; stats={}
for n in (5,6,7,8):
    B1s=[];B2s=[];B3s=[];ths=[]
    for k in range(60):
        W=random_weyl(n); lam,g,T,th=data(W,n); b=bounds(lam,g,n)
        cap=b['cap']; worst_cap=max(worst_cap,(g-cap).max())
        worst_valid=min(worst_valid,min(b['B1']-th,b['B2']-th,b['B3']-th))
        B1s.append(b['B1']);B2s.append(b['B2']);B3s.append(b['B3']);ths.append(th)
    stats[n]=(max(B1s),max(B2s),max(B3s),max(ths))
print("max over-cap violation (want <=0):", f"{worst_cap:.3e}")
print("min (bound - theta) over all bounds/points (want >=0):", f"{worst_valid:.6f}")
print(f"{'n':>3} {'max theta':>10} {'max B1':>10} {'max B2':>10} {'max B3':>10}  sqrt(3/2)=1.224745")
for n,(a,b_,c,d) in stats.items():
    print(f"{n:3d} {d:10.6f} {a:10.6f} {b_:10.6f} {c:10.6f}")
