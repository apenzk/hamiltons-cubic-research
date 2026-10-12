"""Reviewer 35 / M4,M5,M8: full L_e spectrum at S^p x S^q vs the ten predicted values."""
import numpy as np, sys, time, json
sys.path.insert(0, 'scripts/lib')
from review_r35_core import *

def predicted(p, q):
    n = p + q
    Wd = lambda m: m*(m+1)*(m+2)*(m-3)//12
    s  = lambda m: (m+2)*(m-1)//2
    c  = lambda m: m*(m-1)//2
    X  = lambda m: m*(m*m-4)//3
    lam = lambda m: (m-2)/(2*(m-1))
    mu = (n-2)/(2*(p-1)*(q-1))
    return [("<W>", 1.0, 1), ("R^p(x)R^q", 0.5, p*q),
            ("S^2_0(R^p)", lam(p), s(p)), ("S^2_0(R^q)", lam(q), s(q)),
            ("S0(x)S0", -mu, s(p)*s(q)), ("L2(x)L2", +mu, c(p)*c(q)),
            ("Weyl_p", 0.0, Wd(p)), ("Weyl_q", 0.0, Wd(q)),
            ("X_p(x)R^q", 0.0, X(p)*q), ("X_q(x)R^p", 0.0, X(q)*p)]

def cluster(ev, tol=1e-8):
    out = []
    for v in np.sort(ev):
        if out and abs(v - out[-1][0]) < tol:
            out[-1][1] += 1
        else:
            out.append([v, 1])
    return out

def run(p, q, verbose=True):
    n = p + q
    B = weyl_basis(n)
    Wn, th, res = unit_and_theta(n, W_sphere_product(p, q))
    e = Wn / th
    M = Le_matrix(n, e, B)
    ev = np.linalg.eigvalsh(0.5*(M+M.T))
    cl = cluster(ev)
    pred = predicted(p, q)
    # merge predicted values that coincide
    agg = {}
    for name, val, dim in pred:
        if dim == 0: continue
        key = round(val, 12)
        agg.setdefault(key, [0, []])
        agg[key][0] += dim; agg[key][1].append(name)
    predlist = sorted((k, v[0], v[1]) for k, v in agg.items())
    ok = len(cl) == len(predlist) and all(
        abs(a[0]-b[0]) < 1e-8 and a[1] == b[1] for a, b in zip(cl, predlist))
    if verbose:
        print(f"\n--- (p,q)=({p},{q})  n={n}  D={len(B)}  theta={th:.9f} res={res:.1e} ---")
        print(f"  {'measured':>26} | {'predicted':>26}")
        for i in range(max(len(cl), len(predlist))):
            a = f"{cl[i][0]:+.9f} x{cl[i][1]:<5d}" if i < len(cl) else ""
            b = (f"{predlist[i][0]:+.9f} x{predlist[i][1]:<5d} {'+'.join(predlist[i][2])}"
                 if i < len(predlist) else "")
            print(f"  {a:>26} | {b}")
        print(f"  MATCH: {ok}")
        lam_top = max(v for v, m in cl if abs(v-1.0) > 1e-8)
        nul = sum(m for v, m in cl if abs(v) < 1e-8)
        Wd = lambda m: m*(m+1)*(m+2)*(m-3)//12
        pz = Wd(p)+Wd(q)+p*q*(p*p+q*q-8)//3
        print(f"  lambda_max on W-perp = {lam_top:+.9f} (mult {[m for v,m in cl if abs(v-lam_top)<1e-8][0]}), "
              f"orbit dim = {p*q}")
        print(f"  nullity = {nul}, formula W(p)+W(q)+pq(p^2+q^2-8)/3 = {pz}  {'OK' if nul==pz else 'MISMATCH'}")
    return cl, predlist, ok

if __name__ == "__main__":
    splits = eval(sys.argv[1]) if len(sys.argv) > 1 else [(3,3),(3,4),(4,4),(3,5),(4,5),(3,6),(5,5),(4,6),(3,7)]
    summ = []
    for (p, q) in splits:
        t0 = time.time()
        cl, pl, ok = run(p, q)
        summ.append((p, q, ok, time.time()-t0))
        print(f"  [{time.time()-t0:.1f}s]", flush=True)
    print("\n=== summary ===")
    for p, q, ok, t in summ:
        print(f"  ({p},{q}) match={ok}  {t:.1f}s")
