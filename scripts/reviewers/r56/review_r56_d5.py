"""Reviewer 56 -- D5: independent recomputation of every row of the record's
unitary-isotropy slack table, plus the r>=8 hyperkaehler family it omits."""
import numpy as np, sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
from review_r56_core import *

def row(label, n, W, idx, c):
    W = W / np.linalg.norm(W)
    th, res = theta_res(W, c)
    if th < 0:
        W = -W; th, res = theta_res(W, c)
    S, leak = slack_struct(W, c)
    print(f"  {label:<34} n={n:<3d} theta={th:11.9f} th/th0={th/theta0(n):7.4f} "
          f"res={res:7.1e} S={S:11.4e} leak={leak:9.2e} "
          f"massF={offdiag_mass(W):6.4f} maxoff={offdiag_max(W):6.4f}")
    return th, S

print("=== D5 rows, my own construction and my own structural slack ===")
for n in (6, 8, 10, 12, 14):
    idx, pos, N, c = struct(n)
    print(f"-- n = {n} --")
    m = n // 2
    row(f"balanced S^{m}xS^{n-m}", n, sphere_product(n, (m, n - m), idx), idx, c)
    row("Fox S^4(alpha) = padded W_CP2", n, w_cp2_padded(n, idx), idx, c)
    row(f"CP^{m} (Fubini-Study)", n, cpm(n, idx), idx, c)
    if n % 4 == 0:
        row(f"QK HP^{n//4}", n, hpm(n, idx), idx, c)

print()
print("=== cross-check against the repository's own constructions ===")
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor
from run_defect_max_hunt import su_m_kahler_weyl
from run_cp2_ricci_flat import cp2_block_st_tensor
from run_hpm_qk import qk_tensor
for n in (6, 8, 12):
    idx, pos, N, c = struct(n)
    L2 = Lambda2(n)
    m = n // 2
    Wsu = su_m_kahler_weyl(L2, m)
    row(f"repo su({m}) Kaehler", n, Wsu, idx, c)
    Wfox = weyl_from_mop(L2, mop_from_4tensor(L2, cp2_block_st_tensor(n, 1, -1)))[0]
    row("repo Fox S^4(alpha)", n, Wfox, idx, c)
    mine = w_cp2_padded(n, idx); mine /= np.linalg.norm(mine)
    wf = Wfox / np.linalg.norm(Wfox)
    print(f"      |repo Fox - my padded W_CP2| (up to sign) = "
          f"{min(np.linalg.norm(wf-mine), np.linalg.norm(wf+mine)):.2e}")
    if n % 4 == 0:
        Wqk = weyl_from_mop(L2, mop_from_4tensor(L2, qk_tensor(n, n // 4, 1.0, 1.0)))[0]
        row(f"repo QK HP^{n//4}", n, Wqk, idx, c)
        mh = hpm(n, idx); mh /= np.linalg.norm(mh); wq = Wqk / np.linalg.norm(Wqk)
        print(f"      |repo HP - my HP| (up to sign) = "
              f"{min(np.linalg.norm(wq-mh), np.linalg.norm(wq+mh)):.2e}")
