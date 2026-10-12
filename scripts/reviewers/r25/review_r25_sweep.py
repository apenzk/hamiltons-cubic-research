import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, traceback
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import numpy as np, review_r25_core as R, review_r25_tests as T, review_r25_subalgebras as S

cases = []
for (p, q) in [(3,3),(4,4),(5,5),(6,6),(2,4),(3,5),(2,6),(3,7),(4,6),(2,3),(3,4),(4,5),(5,7),(2,8)]:
    cases.append(S.so_p_so_q(p, q))
for parts in [(2,2,2),(3,3,3),(2,2,2,2),(3,3,4)]:
    cases.append(S.so_blocks(list(parts)))
for m in [2,3,4,5,6]:
    cases.append(S.u_m(m)); cases.append(S.su_m(m))
for m in [2,3]:
    cases.append(S.sp_m_sp_1(m)); cases.append(S.sp_m_plus_sp1(m))
for l in [2,3,4,5]:
    cases.append(S.so3_irrep(l))
for k in [4,5,6]:
    cases.append(S.so_k_adjoint(k))
for k in [3,4]:
    cases.append(S.su_k_adjoint(k))
for (p,q) in [(3,3),(2,3),(3,4),(2,4)]:
    cases.append(S.so_p_tensor_so_q(p,q))
cases.append(S.g2_in_so7())
cases.append(S.spin7_in_so8())

rows = []
for (nm, n, g, ex) in cases:
    if n > 16 or n < 4:
        print("skip", nm, n); continue
    t = time.time()
    try:
        d = T.analyse(nm, n, g, ex)
    except Exception as e:
        print("ERR", nm, n, e); traceback.print_exc(); continue
    if 'skip' in d:
        print("degenerate", nm, n, d); continue
    rows.append(d)
    ok = (d['F1h'] == 1 and d['F1m'] == 1 and d['F2'] == 1 and d['F3'] == 0)
    print(f"{nm:>18s} n={n:2d} r={d['r']:3d} N={d['N']:3d} cap={d['cap']:7.2f} "
          f"F1h={d['F1h']} F1m={d['F1m']} F2={d['F2']} F3={d['F3']} MEMBER={ok} "
          f"th={d['theta']:.6f} thpred={d['theta_pred']:.6f} th0={d['th0']:.6f} "
          f"resid={d['crit_resid']:.2e} ric={d['ric_norm']:.2e} alt2={d['alt2']:.2e} "
          f"Smmm={d['Smmm']:.4f} pred={d['Smmm_pred']:.4f} Shmm={d['Shmm']:.3f}/{d['Shmm_pred']:.3f} "
          f"slack={d['slack']:.6f} ({time.time()-t:.1f}s)", flush=True)
np.save(_os.path.join(_ROOT, 'agent_logs/review_r25_rows.npy'), np.array(rows, dtype=object), allow_pickle=True)
