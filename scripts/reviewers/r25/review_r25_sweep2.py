import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time; sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np, review_r25_core as R, review_r25_tests as T, review_r25_subalgebras as S, review_r25_fix as F

cases = [F.g2_in_so7(), F.spin7_in_so8()]
for m in [3,4,5,6]:
    cases.append(F.u_m_fixed(m)); cases.append(F.su_m_fixed(m))
for (p,q) in [(3,3),(4,4),(5,5),(6,6),(3,5),(2,4),(4,6),(3,4),(2,6)]:
    cases.append(F.so_p_so_q_full(p,q))
for parts in [(2,2,2),(3,3,3),(2,2,2,2),(4,4,4),(2,2,3)]:
    cases.append(F.so_blocks_full(list(parts)))

def show(d):
    ok = (d['F1h']==1 and d['F1m']==1 and d['F2']==1 and d['F3']==0)
    print(f"{d['name']:>18s} n={d['n']:2d} r={d['r']:3d} N={d['N']:3d} cap={d['cap']:7.2f} "
          f"F1h={d['F1h']} F1m={d['F1m']} F2={d['F2']} F3={d['F3']} MEMBER={ok} "
          f"th={d['theta']:.6f} thpred={d['theta_pred']:.6f} th0={d['th0']:.6f} "
          f"resid={d['crit_resid']:.2e} ric={d['ric_norm']:.2e} alt2={d['alt2']:.2e} "
          f"Smmm={d['Smmm']:.4f} pred={d['Smmm_pred']:.4f} slack={d['slack']:.6f}", flush=True)

for (nm,n,g,ex) in cases:
    t=time.time()
    d = T.analyse(nm,n,g,ex)
    if 'skip' in d: print("degenerate", nm, d); continue
    show(d); print(f"    ({time.time()-t:.1f}s)", flush=True)
