"""M4/M5: full L_e spectrum at S^p x S^q against the ten predicted (eigenvalue, mult) pairs."""
import numpy as np, sys, time
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from review_r34_core import weyl_basis, idempotent, Le_matrix

Wd = lambda m: m*(m+1)*(m+2)*(m-3)//12
sdim = lambda m: (m+2)*(m-1)//2
cdim = lambda m: m*(m-1)//2
Xdim = lambda m: m*(m*m-4)//3

def predicted(p, q):
    n = p+q
    mu  = F(n-2, 2*(p-1)*(q-1))
    lam = lambda m: F(m-2, 2*(m-1))
    items = [(F(1), 1), (F(1,2), p*q),
             (lam(p), sdim(p)), (lam(q), sdim(q)),
             (-mu, sdim(p)*sdim(q)), (mu, cdim(p)*cdim(q)),
             (F(0), Wd(p)+Wd(q)+Xdim(p)*q+Xdim(q)*p)]
    agg = {}
    for v, m in items:
        if m > 0:
            agg[v] = agg.get(v, 0) + m
    return dict(sorted(agg.items()))

def measured(p, q, tol=1e-8):
    n = p+q
    e, theta, Wu = idempotent(p, q)
    B = weyl_basis(n)
    M = Le_matrix(e, n, B)
    M = 0.5*(M+M.T)
    ev = np.linalg.eigvalsh(M)
    groups = []
    for v in ev:
        if groups and abs(v-groups[-1][0][-1]) < tol:
            groups[-1][0].append(v)
        else:
            groups.append(([v], 0))
    return [(float(np.mean(g)), len(g)) for g, _ in groups], M.shape[0], theta

if __name__ == "__main__":
    splits = eval(sys.argv[1]) if len(sys.argv) > 1 else [
        (3,3),(3,4),(3,5),(4,4),(3,6),(4,5),(3,7),(4,6),(5,5)]
    for (p,q) in splits:
        t0=time.time()
        meas, D, theta = measured(p,q)
        pred = predicted(p,q)
        ok = (len(meas)==len(pred)) and all(
            abs(mv-float(pv))<1e-7 and mm==pm
            for (mv,mm),(pv,pm) in zip(meas, pred.items()))
        print(f"({p},{q}) n={p+q} D={D:5d} theta={theta:.6f} match={ok}  [{time.time()-t0:.0f}s]")
        print(f"   measured : " + "  ".join(f"{v:+.6f}x{m}" for v,m in meas))
        print(f"   predicted: " + "  ".join(f"{float(v):+.6f}x{m}" for v,m in pred.items()))
        zp = Wd(p)+Wd(q)+p*q*(p*p+q*q-8)//3
        zm = dict((round(v,7),m) for v,m in meas).get(0.0, 0)
        print(f"   zero block: formula {zp}   measured nullity {zm}   "
              f"{'OK' if zp==zm else 'MISMATCH'}", flush=True)
