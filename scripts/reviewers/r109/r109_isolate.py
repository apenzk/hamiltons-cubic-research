"""Isolate the cap's own contribution: B1' = cap-only sharpening of the RECORDED bound
(no lam_p_min term), so the improvement is attributable solely to substituting Prop 1.7."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
exec(open(_os.path.join(_ROOT, 'scripts/reviewers/r109/r109_consequence.py')).read().split('print(f"{')[0])

def capped_only(lam,g,n,tol=1e-9):
    pos=lam>tol; neg=lam<-tol; ker=~(pos|neg)
    Delta=g[pos].sum(); G0=g[ker].sum(); m=4*(n-1)-Delta-G0
    cap=2*(n-2)*(lam.max()-lam.min())**2
    idx=[i for i in np.argsort(lam) if neg[i]]
    rem=m; acc=0.0
    for i in idx:
        take=min(cap,rem); acc+=lam[i]*take; rem-=take
        if rem<=1e-12: break
    assert rem<=1e-9
    return abs(lam.min())*m/4, -acc/4          # B1 recorded, B1cap

print(f"{'point':>10} {'n':>2} {'theta':>9} {'B1 recorded':>12} {'B1+cap only':>12} {'cut':>7}")
for (p,q) in [(3,3),(4,4)]:
    W,n=sphere_product(p,q); lam,g,T,th=data(W,n); a,b=capped_only(lam,g,n)
    print(f"{'S^%d x S^%d'%(p,q):>10} {n:2d} {th:9.6f} {a:12.6f} {b:12.6f} {100*(1-b/a):6.1f}%")
for n in (5,6,7,8):
    ws=[]
    for k in range(40):
        W=random_weyl(n); lam,g,T,th=data(W,n); a,b=capped_only(lam,g,n); ws.append((a,b,th))
    a=max(x[0] for x in ws); b=max(x[1] for x in ws); t=max(x[2] for x in ws)
    print(f"{'rand max':>10} {n:2d} {t:9.6f} {a:12.6f} {b:12.6f} {100*(1-b/a):6.1f}%")
