import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np
from find_crit import solve, analyse
from diagcore import V_basis, crit_residual_strong, theta_of

n = int(sys.argv[1]); ns = int(sys.argv[2])
B = V_basis(n)
tab = {}
for seed in range(ns):
    try:
        M, r = solve(n, seed, B)
    except Exception:
        continue
    if r > 1e-10:
        continue
    a = analyse(M, B)
    if abs(a["theta"]) < 1e-7: continue
    key = (round(a['theta'], 7), round(a['Delta'], 6), round(a['ratio'], 6), a['kerdim'])
    if key not in tab:
        tab[key] = (M, a, float(np.abs(crit_residual_strong(M)).max()))
rows = sorted(tab.items(), key=lambda kv: -kv[1][1]['theta'])
print(f"n={n}  {len(rows)} distinct signatures from {ns} starts")
print(f"{'theta':>10} {'Delta':>10} {'lmax/th':>10} {'lmin/th':>9} {'ker':>3} {'strong':>8}   FLAG")
hits = []
for key, (M, a, st) in rows:
    flag = ''
    if a['theta'] > 1e-9 and a['Delta'] > 1e-7 and a['ratio'] <= 0.5 + 1e-9:
        flag = '<<< PRIZE'
        hits.append(M)
    if st > 1e-9:
        flag += ' STRONG-FORM-FAILS'
    print(f"{a['theta']:10.6f} {a['Delta']:10.5f} {a['ratio']:10.6f} "
          f"{a['lam_min']/a['theta'] if a['theta'] else 0:9.4f} {a['kerdim']:3d} {st:8.1e}   {flag}")
np.save(f"/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/hits_{n}.npy",
        np.array(hits) if hits else np.zeros((0, n, n)))
