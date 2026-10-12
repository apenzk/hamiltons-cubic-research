"""Reviewer 12: reproducibility probe for review_r11_sp_classes.py.

FINDINGS' Family C section says the (sp(m), u(m)) construction was FIXED
(sp(m) from right multiplications, u(m) cut by a left complex structure) and
that the fix produced ranks 4/9/16 for k and the tabulated critical points.
This driver runs the ON-DISK sp_m_projections to record what ranks the
committed code actually yields.  (Diagnostic only -- imports the pipeline
under review on purpose; my independent construction lives in
review_r12_independent.py.)
"""
import numpy as np
from curvature_operator import Lambda2
from review_r11_sp_classes import sp_m_projections, quaternion_structure

for m in (2, 3):
    n = 4 * m
    L2 = Lambda2(n)
    Pks, Pm = sp_m_projections(L2, m, None)
    dims_k = [float(np.round(np.trace(P), 6)) for P in Pks]
    dim_m = float(np.round(np.trace(Pm), 6))
    print(f"(sp({m}), u({m})) n={n}: on-disk code gives dim(k ideals) = "
          f"{dims_k}, dim m = {dim_m}   [theory: k = {m*m} split as "
          f"{m*m-1}+1, m = {m*(m+1)}]")
    Ic, Jc, Kc = quaternion_structure(m)
    # is the I used for u(m) inside the centraliser that defines sp(m)?
    # sp(m) is cut by commuting with I, J, K, so I trivially commutes with
    # every element of sp(m): u(m)-as-coded == sp(m).
    print(f"   [I,J] anticommute check: {np.max(np.abs(Ic@Jc + Jc@Ic)):.1e}; "
          f"total k-dim = {sum(dims_k):.1f} vs dim sp({m}) = {m*(2*m+1)}")
