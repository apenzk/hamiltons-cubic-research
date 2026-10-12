# REVIEW r1178: Gate 2 on Lemma L248, the operator ceiling

Log: [agent_logs/r1178.log](../agent_logs/r1178.log). Analysis-only footing: items argued from the definitions. One seconds-scale screen at S^5 x S^7 (a construction of the reviewer's own), reported as a screen.

| item | verdict |
|---|---|
| (1) expansion of (W-b)#(W-b) | CONFIRMED |
| (2) PSD of the class sum, B_ab >= 0 for every pair | CONFIRMED |
| (3) every eigenvalue, lambda_min binding | CONFIRMED |
| (4) symmetric specialisation theta <= a(n-5) | CONFIRMED |
| (5) S^5 x S^7 check | CONFIRMED |
| (6) no exclusion beyond class screens, F78 link | CONFIRMED |
| (7) literature | PLAUSIBLE (PSD fact standard, inequality not found stated) |
| Lean statements | CONFIRMED |

## (1) The expansion

With # bilinear and symmetric, (W - bI)#(W - bI) = W#W - 2b I#W + b^2 I#I = (theta W - W^2) + 2bW + (n-2) b^2 I. The cross term is -2b(I#W) = +2bW. Signs and factor as stated.

## (2) Positivity

W - bI = sum_a (lambda_a - b) P_a, so bilinearity gives sum_{a,b} (lambda_a - b)(lambda_b - b) P_a#P_b. Every coefficient is a product of two numbers <= 0. For each pair, including a != b, taking phi an eigenbasis of W, the definition gives <(P_a#P_b)x, x> = (1/2) sum_{alpha in E_a, beta in E_b} <[phi_alpha, phi_beta], x>^2 >= 0. So each B_ab is PSD and the combination is PSD. Equivalently (W-b)#(W-b) = C#C with C = bI - W >= 0, and A#A >= 0 for A >= 0.

## (3) Every eigenvalue, the binding case

At a unit x in E_c the quadratic form is f(lambda_c) = -lambda_c^2 + (theta + 2b) lambda_c + (n-2) b^2 >= 0. f is concave, so on [-a, b] its minimum is at an endpoint. f(b) = b(theta + (n-1) b) > 0 for theta >= 0, so lambda_c = -a is the binding case, giving a(theta + a + 2b) <= (n-2) b^2.

## (4) Symmetric case

a = b: a(theta + 3a) <= (n-2) a^2 gives theta <= (n-5) a, which is L244's x-free bound at a = 1/sqrt(2p).

## (5) S^5 x S^7

Einstein radii with sectional curvatures 3 on S^5, 2 on S^7 (Ric = 12). s = 20*3 + 42*2 = 144, s/(n(n-1)) = 12/11. The Weyl eigenvalues are 21/11 (mult 10), 10/11 (mult 21), -12/11 (mult 35), trace 0, |W|^2 = 11550/121. Normalised: lambda_min = -0.111658, lambda_max = 0.195402. These equal -rho/11 and 7rho/44 at rho = 132/sqrt(11550) = 1.22824. Screen (66 x 66 structure constants, # from the definition): I#I = (n-2)I and I#W = -W to 1e-16, W^2 + W# = theta W with theta = 1.2282392, residual 8e-17, so rho = theta holds. Inequality: 0.19325 <= 0.38182. The smallest eigenvalue of (W-b)#(W-b) is 0.18857, which is exactly rhs minus lhs, consistent with lambda_min binding.

## (6) What it does

The pointwise inequality is b^2 (A) - 2b (B) + (C) of the rows, rewritten as sum (lambda_i - b)(lambda_j - b) b_ij(x) >= 0, which uses only b_ij(x) >= 0. Traced over E_min it is m_min f(-a) = sum (lambda_i - b)(lambda_j - b) t_ij with t_ij = tr(P_min B_ij) >= 0, a nonnegative combination of trace nonnegativities plus the traced rows. Any screen carrying those imposes it. The claim is right. The F78 link checks: F78's slice ceiling a theta <= b^2(n-2) - 2ab - a^2 is the same inequality rearranged.

## (7) Literature

PSD of A#B for A, B >= 0 is standard and immediate from the definition (write A, B as sums of rank-one projections: (uu^T)#(vv^T) is (1/2)[u,v][u,v]^T). It underlies the Böhm-Wilking and Hamilton framework ([Böhm-Wilking circle, arXiv 1011.3561](https://arxiv.org/pdf/1011.3561), [Lei Ni survey](https://mathweb.ucsd.edu/~lni/academic/wallachfest.pdf)). A brief search found no statement of the ceiling a(theta + a + 2b) <= (n-2) b^2 for critical points of P. The novelty is plausible, and the result is a short corollary of known facts.

## Lean

[L248OperatorCeiling.lean](../lean/HamiltonsCubic/Results/L248OperatorCeiling.lean) compiles cleanly (`lake env lean`, exit 0, no output). hA, hB (sum_i sum_j lam_j b_ij = -lc) and hC match L244 (i)'s rows. hsymm is B_ab = B_ba, which holds by symmetry of #. hb is b_ij >= 0, and hM is lambda_i <= M. theta_ceiling is operator_ceiling's conclusion at lc = -a, M = b. symmetric_case is correct. The witness data satisfy A = 8, B = 1 = -lc, C = -4 = lc(theta - lc) (hand check). The expansion and B_ab >= 0 stay in prose as the table says.
