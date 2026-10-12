# REVIEW r1179: Gate 2 on L248, the operator ceiling

Log: [agent_logs/r1179.log](../agent_logs/r1179.log)

Verdict: the lemma is correct as stated. One wording repair is recommended in "What it does" (item 6).

| item | verdict |
|---|---|
| 1 expansion of (W-b)#(W-b) | CONFIRMED |
| 2 PSD of the class sum | CONFIRMED |
| 3 every lambda_c, binding case | CONFIRMED |
| 4 symmetric specialisation | CONFIRMED |
| 5 S^5 x S^7 check | CONFIRMED |
| 6 no exclusion beyond class screen | CONFIRMED (wording repair) |
| 7 literature | PLAUSIBLE (ingredients known, inequality itself not found) |
| 8 Lean hypotheses | CONFIRMED |

## 1. Expansion

# is bilinear and symmetric, so (W-bI)#(W-bI) = W#W - 2b I#W + b^2 I#I = (theta W - W^2) + 2bW + (n-2) b^2 I. The signs are right and the cross term carries a factor of 2, which comes from I#W = W#I. Screen at S^5 x S^7 (n = 12, 66x66, the sharp built from the stated definition): the residual is 3e-16. The bilinearity residual at a random symmetric Y is 3e-14.

## 2. PSD

Each B_ab = P_a#P_b is PSD individually, including a != b. In a basis adapted to the eigenspaces, <B_ab x,x> = (1/2) sum over gamma in E_a and delta in E_b of <[psi_gamma, psi_delta], x>^2 >= 0. Every coefficient (lambda_a - b)(lambda_b - b) is >= 0, so the sum is PSD. A shorter route gives the same fact: (W-b)#(W-b) = X#X with X = bI - W >= 0, and X#X >= 0 in X's eigenbasis. Screen: the minimum eigenvalue of every B_ab is 0, and the minimum eigenvalue of (W-b)#(W-b) at S^5 x S^7 is 0.1886.

## 3. Every lambda_c

Pairing with a unit x in E_c gives lambda_c(theta - lambda_c) + 2b lambda_c + (n-2) b^2 >= 0, which is the stated form. Write f for the left side as a function of lambda_c. f is concave in lambda_c, so over the spectrum its minimum sits at an endpoint. f(b) - f(-a) = (a+b)(theta + a + b), so lambda_c = -a binds exactly when theta > -(a+b), and in particular whenever theta >= 0. The statement's "in particular" needs only lambda_c = -a to be an eigenvalue, which it is.

## 4. Symmetric case

At a = b: a(theta + 3a) <= (n-2) a^2, so theta <= a(n-5). With a = 1/sqrt(2p) this is L244 (ii)'s (n-5)/sqrt(2p).

## 5. S^5 x S^7

Take sectional curvatures 3 on S^5 and 2 on S^7 (Einstein, Ric = 12, scal = 144). Then W = R - (12/11) I has eigenvalues 21/11 (x10), 10/11 (x21) and -12/11 (x35), and |W|^2 = 11550/121. Normalised: lambda_min = -0.111658 and lambda_max = 0.195402. Screen: theta = 1.228239, with critical-point residual 8e-17, so lambda_min = -theta/11 and lambda_max = 7 theta/44 exactly. The inequality reads a(theta + a + 2b) = 0.19325 <= (n-2) b^2 = 0.38182, which matches the record's 0.193 <= 0.382.

## 6. Adds no exclusion to a class screen

This holds. At a unit x in E_c the inequality is identically b^2(A) - 2b(B) + (C) = sum (lambda_a - b)(lambda_b - b) b_ab(x). The right side is a nonnegative combination of the b_ab(x), and the rows are equalities. Traced over E_c, it is m_c times the inequality, obtained from the traced rows with the same multipliers plus t_abc >= 0. **Wording repair**: "a nonnegative combination of the traced rows" is loose, because the multiplier on row (B) is -2b < 0. The rows are equalities, so the sign is immaterial, but the precise statement is "the traced rows with multipliers b^2, -2b, 1 plus a nonnegative combination of the class traces t_abc". The claim that it is the ceiling behind F78 and slice_needs_rho_gt_one matches L247's text, whose "rows' own ceiling" a theta <= b^2(n-2) - 2ab - a^2 is this inequality.

## 7. Literature

The ingredients are standard. X >= 0 implies X#X >= 0 (Hamilton 1986, used throughout Boehm-Wilking 2008), as do the contraction identities I#I = (n-2)I and I#W = -W for Weyl (Boehm-Wilking, Lemma 2 area). A brief search found no statement of this particular ceiling at critical points of W^2 + W^# = theta W. Read it as a direct corollary and probably new in this form, with a low novelty claim.

## 8. Lean

[L248OperatorCeiling.lean](../lean/HamiltonsCubic/Results/L248OperatorCeiling.lean) compiles (lake env lean, 22 s). operator_ceiling, symmetric_case and witness depend only on propext, Classical.choice and Quot.sound. The hypotheses match L244 (i): hA is sum b_ij = n-2, hB is sum_i sum_j lam_j b_ij = -lc (row (B)), hC is sum lam_i lam_j b_ij = lc(theta - lc), and hM is lam_i <= M. The witness data check by hand: row (A) gives 8 = n-2, row (B) gives 1 = -lc, and row (C) gives -4 = (-1)(3+1). theta_ceiling is the lc = -a instance, a one-line linarith. The table's gap row (the # expansion and B_ab >= 0 in prose only) is recorded accurately.
