# Review r1176: I73(c), the Ricci defect on the certificate space

Log: agent_logs/r1176.log

Verdict: the chain holds from the givens, sign included. One caveat on claim 7: the vectors x_w for orthonormal w are orthogonal in U only when the Gram operator P_0 C C^T P_0 on E_0 is scalar.

| claim | verdict | note |
|---|---|---|
| 1 | CONFIRMED | (P_0C)^T w has coefficients <[u,v],w>, so it equals x_w; dim U = rank (P_0C)^T = rank P_0C = p (given). |
| 2 | CONFIRMED | range M_0 = range (P_0C)^T = U, so tr_U M_0 = tr M_0; M_2 >= 0 gives tr_U M_2 <= tr M_2, so tr_U B_lead >= T. lambda_max(B) >= lambda_max(compression) >= tr_U B / p (Cauchy interlacing). |
| 3 | CONFIRMED | <[u,v],w> = -(1/2)tr(uvw - vuw) = <v,[w,u]>; sum over v in E_2 gives P_2[w,u]; (uv)^T = vu gives the symmetric part (1/2){u,v}. |
| 4 | CONFIRMED | {u,[w,u]} = [w,u^2], so the sum is [w,-A_0] = [A_0,w]; expanding [w,u] over all classes, the E_0 x E_0 block dies by antisymmetry of c. Lean sym_split states exactly this with S_0 = sum psi^2 = -A_0, so its [w,S_0] is the prose's [A_0,w]. Quantifiers: any complete orthonormal skew family (hψ is the expansion identity), any class labelling, any skew w. |
| 5 | CONFIRMED | 2A_0 + A_1 = (n-1)I gives [A_0,w] = -(1/2)[A_1,w]. Symmetric part = (1/2)(-(1/2)[A_1,w] - S_01) = -(1/4)[A_1,w] - (1/2)S_01, and it equals -h, so h = (1/4)[A_1,w] + (1/2)S_01. Sign correct. Lean comm_middle is stated with S_c = -A_c, and the relation is homogeneous, so it transfers. |
| 6 | CONFIRMED | m = 0 empties both terms. CS: sum c^2 = sum <[u,z],w>^2 = 2 b_01(w); \|\|{u,z}\|\|_F^2 = 2tr(uzuz) + 2tr(u^2 z^2) <= 4 tr(u^2 z^2), since tr(M^2) <= tr(M^T M) = tr(u^2 z^2) for M = uz; summing gives 4 tr(A_0A_1) = 4G_01. |
| 7 | PLAUSIBLE | A valid lower bound route: lambda_max(B_lead + R) >= tr_U(B_lead + R)/p for any symmetric R. A route, and a lossy one (U is fixed). Caveat: tr_U R = tr(Gamma^{-1} [R(x_w, x_w')]) with Gamma_{ww'} = <x_w, x_w'> = <w, P_0 C C^T w'>, and <x_w,x_w> = 2 b_02(w). Summing a per-vector quantity like \|h_{x_w}\|^2 over orthonormal w is tr_U only when b_02 is isotropic on E_0. |

Screen (seconds, so(6), random orthonormal basis split 5/5/5, random w in E_0, general family): the X_{x_w} formula, the skew part (1/2)Cx, the split of claim 4 and the bound of claim 6 all hold (bound 2.73 <= 173). A screen only. Claim 5 was left unscreened because a random split does not satisfy A_0 = A_2.
