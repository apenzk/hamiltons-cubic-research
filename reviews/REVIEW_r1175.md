# Review r1175: I73(c), the Ricci defect on the certificate space

Log: agent_logs/r1175.log

Verdict: no defect found. Every link of the chain follows from the givens, and the sign of h is right. One gap of scope is noted under claim 7.

| claim | verdict | note |
|---|---|---|
| 1 | CONFIRMED | (P_0C)^T w has uv-entry <[u,v],w>, so its range is span{x_w}; dim = rank of the adjoint = rank P_0C = p, and w -> x_w is injective. |
| 2 | CONFIRMED | range M_0 = U and M_0 = 0 on U-perp, so tr_U M_0 = tr M_0; tr_U M_2 <= tr M_2 since M_2 >= 0; lambda_max(B) >= lambda_max(compression) >= tr_U/p >= T/p. The prose says "the -lambda_2 term" where it means the M_2 term (wording only). |
| 3 | CONFIRMED | <[u,v],w> = <v,[w,u]> by ad-invariance (checked by trace expansion); (uv)^T = vu for skew u, v gives sym part (1/2) sum c {u,v}, skew part (1/2) Cx. |
| 4 | CONFIRMED | sum_u {u,[w,u]} = [w, sum u^2] = [w,-A_0] = [A_0,w]; c antisymmetric on E_0 x E_0; the full delta-sum splits over E_0, E_1, E_2. Lean sym_split states exactly this with S_0 = sum psi^2 = -A_0, [w,S_0] = [A_0,w]; hypotheses (skew, completeness hψ, arbitrary labels) are adequate. |
| 5 | CONFIRMED | A_1 = (n-1)I - 2A_0 gives [A_0,w] = -(1/2)[A_1,w]; comm_middle in S-form is the same identity (both sides negate). Sign: sym part = -h, so h = -(1/2)[A_0,w] + (1/2)S_01 = (1/4)[A_1,w] + (1/2)S_01. |
| 6 | CONFIRMED | m = 0 gives A_1 = 0 and S_01 = 0, and h is linear in x, so h = 0 on all of U. Bound: sum c(u,z)^2 = 2 b_01(w); ||{u,z}||_F^2 = 4 tr(u^2 z^2) - ||[u,z]||_F^2 <= 4 tr(u^2 z^2), summing to <= 4 G_01; Cauchy-Schwarz gives <= 8 b_01 G_01. |
| 7 | CONFIRMED, with a scope note | For any symmetric B and any p-dim subspace U, lambda_max(B) >= tr_U(B)/p, so tr_U of (B_lead + corrections) is a valid lower-bound route. It is a chosen route, and it can be weaker than bounding lambda_max directly. The x_w are not orthonormal: tr_U of a quadratic correction Q equals tr(K^{-1} [Q(x_w,x_w')]) with Gram K_{ww'} = <x_w,x_w'> (= 2 b_02-type form on E_0), so the formula for h_{x_w} evaluates the correction only after this Gram normalisation, which the prose leaves unstated. |

Screen (seconds, constructed objects, a screen only): n = 6, random orthonormal basis of so(6) split 5/4/6 into arbitrary classes, random w in E_0. The formula for X_{x_w}, the split of claim 4 and the bound of claim 6 (2.65 <= 172.5) all held. Claim 5 needs A_0 = A_2 and was checked by hand only.
