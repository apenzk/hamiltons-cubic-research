import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time; sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np, review_r25_tests as T, review_r25_subalgebras as S, review_r25_fix as F, review_r25_struct as ST

def so1_soq(q):
    n = 1+q; g = S.so_gens(n, range(1, n))
    r1 = np.eye(n); r1[0,0]=-1; r2=np.eye(n); r2[1,1]=-1
    return f"so({q}) in so({q}+1)", n, g, [r1, r2]

cases = [
 F.so_p_so_q_full(3,3), F.so_p_so_q_full(4,4), F.so_p_so_q_full(5,5), F.so_p_so_q_full(6,6),
 F.so_blocks_full([2,2,2]), F.so_blocks_full([3,3,3]), F.so_blocks_full([2,2,2,2]), F.so_blocks_full([4,4,4]),
 S.so3_irrep(2), S.so_k_adjoint(5), S.su_k_adjoint(3), S.so_p_tensor_so_q(3,3),
 F.g2_in_so7(), F.spin7_in_so8(), F.u_m_fixed(4), F.su_m_fixed(4),
 S.sp_m_plus_sp1(2), F.so_p_so_q_full(3,5), F.so_p_so_q_full(4,6), so1_soq(7),
 S.so3_irrep(3), S.so_p_tensor_so_q(2,4),
]
rows=[]
print("| n | h | r | cap | member | theta meas | theta pred | th0 | S_mmm meas | S_mmm pred | crit resid | slack meas | slack form |")
print("|---|---|---|---|---|---|---|---|---|---|---|---|---|")
for (nm,n,g,ex) in cases:
    d = T.analyse(nm,n,g,ex)
    ok = (d['F1h']==1 and d['F1m']==1 and d['F2']==1 and d['F3']==0)
    tag = "yes" if ok else f"NO (F1h={d['F1h']},F1m={d['F1m']},F2={d['F2']},F3={d['F3']})"
    cf = ST.slack_closed_form(n, d['N'], d['r'])
    print(f"| {n} | {nm} | {d['r']} | {d['cap']:.2f} | {tag} | {d['theta']:.6f} | {d['theta_pred']:.6f} | {d['th0']:.6f} | "
          f"{d['Smmm']:.4f} | {d['Smmm_pred']:.4f} | {d['crit_resid']:.1e} | {d['slack']:.6f} | {cf:.6f} |", flush=True)
