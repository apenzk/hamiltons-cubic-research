# REVIEW r1135: L246, the pair isotropy inequality (Gate 2)

Log: [agent_logs/r1135.log](../agent_logs/r1135.log). Brief: [2026-09-25-L246-gate2-brief.md](2026-09-25-L246-gate2-brief.md). Analysis by hand. One screen of seconds is reported as a screen.

| item | claim | verdict |
|---|---|---|
| 1 | pair inequality, proof steps | CONFIRMED (with a scope correction, see item 4) |
| 2 | corollary (star sign, lambda_1 = 0) | CONFIRMED |
| 3 | sharpness | REFUTED in part: S^5 x S^7 confirmed, the n = 4 Hodge star point is out of scope and vacuous |
| 4 | scope | REFUTED in part: the inequality uses no Ric(W) = 0 at all |
| 5 | non-triviality | CONFIRMED (the L245 comparison PLAUSIBLE, L245's ceiling is outside the givens) |
| 6 | What it does | CONFIRMED on F77, the "couples two eigenspaces ... with only Ric(W)=0" sentence needs correction, heuristic label owed |

## Item 1, the inequality

Every link checked by hand.

- Commuting: the two identities are two linear equations in A_0, A_1, A_2 with coefficient determinant lambda_2 - lambda_1 != 0 for (A_1, A_2), so A_1, A_2 are affine in A_0 and all three commute. Correct.
- Sum of M_c(e) = I - ee^T: the sum over an orthonormal basis of Lambda^2 of (psi e)(psi e)^T is basis-independent. In the basis e_i ^ e_j with e_1 = e only the pairs containing 1 contribute, each giving e_k e_k^T for k != 1. Correct. The third class gives M_c >= 0, so X <= I on e-perp.
- M_c(e) <= hat A_c: for z perp e, z^T psi e = -(psi z)^T e, so <psi e, z>^2 <= |psi z|^2 and summing gives z^T M_c z <= z^T A_c z. Correct.
- Compression eigenvalues: e is a vector of the common eigenbasis, so e-perp is invariant under A_a + A_b and the compression has eigenvalues beta_i, i != j. Correct.
- Capped trace: tr X = tr QXQ + tr (I-Q)X(I-Q) since tr(QX(I-Q)) = 0. X <= I bounds the first by rank Q, and X <= hat A and [Q, hat A] = 0 bound the second by the sum of beta_i < 1. Correct.
- tr X = beta_j: tr M_c(e) = sum |psi e|^2 = e^T A_c e. Correct.

## Item 2, the corollary

- A_0 = p ee^T + P_U for E_0 = e ^ U (U perp e), so A_0 = 0 on Z = (e + U)-perp, and Z != 0 exactly when p <= n-2. On z in Z the two identities give (lambda_2 - lambda_1) A_2 z = -lambda_1 (n-1) z, and A_2 >= 0 forces lambda_1 <= 0. Correct.
- At lambda_1 = 0: lambda_2 A_2 = -lambda_0 A_0, so A_2 = r A_0 with r = |lambda_0|/lambda_2 > 0 everywhere, not only on Z. The pair (0,2) has A_0 + A_2 = (1+r)A_0: beta = (1+r)p at e, 1+r on U, 0 on Z, and p < (1+r)p contradicts the inequality at e. Complete, and it needs only p >= 1: at lambda_1 = 0 the contradiction holds even for p = n-1. The hypothesis p <= n-2 is needed only for the lambda_1 > 0 exclusion.
- E_2: -W is again traceless with Ric = 0, has spectrum -lambda_2 < -lambda_1 < -lambda_0, and turns a star E_2 into a star lowest class, giving -lambda_1 < 0. Correct.
- Lean: `star_sign` and `star_impossible_at_zero` state the scalar steps faithfully. The module docstring names a declaration `star_forces` that does not exist (the file has `star_impossible_at_zero` and `star_sign`), a cosmetic defect.

## Item 3, sharpness

- S^5 x S^7: pair 10, 35 gives A = 11 P_5 + 5 P_7, and at an R^5 direction the right side is 4 + 7 = 11, equality. Pair 21, 35 gives 7 P_5 + 11 P_7, and at an R^7 direction 6 + 5 = 11, equality. Traces 20, 42, 70 and the sum 11 I check. CONFIRMED, and the Lean `example` states it.
- n = 4 Hodge star: A_+ = A_- = (3/2) I and 3 = 3 are arithmetically right, but the point fails as evidence. (i) The Hodge star on Lambda^2 R^4 is not a Weyl tensor: it spans the Lambda^4 summand of Sym^2(Lambda^2 R^4), the part that violates the first Bianchi identity. (ii) It has two eigenvalues, outside the lemma's three. (iii) Its "pair" is all of Lambda^2, where A_a + A_b = (n-1) I and the inequality reads n-1 <= n-1 for every W, so equality is automatic and says nothing about the lemma.

## Item 4, scope

- The inequality uses neither Ric(W) = 0 nor three eigenvalues. The proof needs only that e is an eigenvector of A_a + A_b, and every other step (sum of M_c, M_c <= hat A_c, the trace) holds for any self-adjoint W. So for ANY subspace F of Lambda^2, the eigenvalues of A_F = sum over an orthonormal basis of F of psi^T psi satisfy beta_j <= sum_{i != j} min(1, beta_i). With F = E_a + E_b, A_F = A_a + A_b.
- Screen (seconds, objects constructed here, reported as a screen only): 1200 random subspaces F of Lambda^2 R^n, n = 4 to 7, random dimension. The max over j of beta_j - rhs was 1.8e-15, no violation.
- Ric(W) = 0 and the three eigenvalues enter only in the corollary (A_2 affine in A_0, and A_2 = r A_0 at lambda_1 = 0), and in phrasing the statement on a common eigenbasis of all three classes.
- Symmetric family (-a, 0, a) has lambda_1 = 0 and is covered. Correct.

## Item 5, non-triviality

- Not implied by beta_i <= n-1: the configuration of item 2 at lambda_1 = 0 has every beta_i <= n-1 whenever (1+r)p <= n-1, and violates the inequality.
- Single-class form screen, derived by hand on the symmetric family (r = 1): A_1 = (n-1) I - 2 A_0 has eigenvalues n-1-2p at e, n-3 on U, n-1 on Z. The single-class inequality for E_1 at a Z direction reads n-1 <= (n-2-p) + p + min(1, n-1-2p), which fails exactly at p = (n-1)/2 and holds for p <= (n-2)/2. E_0 alone gives p <= p (equality) and E_2 = E_0 in isotropy. So the per-class forms leave the stars 1 <= p <= (n-2)/2 open and the pair form removes them. The claim that L245's ceiling does not exclude them is PLAUSIBLE only: L245's ceiling is outside the givens, and the block's own Gate 1 (d) says the single-class form does not exceed it.

## Item 6, What it does

- F77's window (star E_0, 9 <= p <= (n-1)/2, symmetric family) lies inside lambda_1 = 0 with p >= 1, so the corollary removes it. CONFIRMED.
- "the first ingredient on file that couples two eigenspaces, and it holds at every n with only Ric(W)=0" overstates both halves: the inequality is the single-subspace inequality for F = E_a + E_b and holds with no hypothesis. The coupling that does the work is the corollary's A_2 = r A_0 at lambda_1 = 0, which is where Ric(W) = 0 enters.
- The near-star sentence: the arithmetic is right for an exact star ((1+r)p - p = rp), but it is not labelled as heuristic, and "near-star" and "approx" are undefined. It sits under "Owed", which is the right place.

## Corrections, exact wording

1. Sharp paragraph, replace "It is also sharp at $n=4$ for the Hodge star, where $A_\pm=\tfrac32I$ and $3=3$." with "(For a pair making up all of $\Lambda^2$, $A_a+A_b=(n-1)I$ and equality is automatic, so only pairs within three classes test sharpness.)" and replace "(a) and (c) by these two points" with "(a) and (c) by the $S^5\times S^7$ pairs".
2. Statement, append after the displayed inequality: "The inequality holds for $A_F=\sum_{\psi}\psi^{\mathsf T}\psi$ over an orthonormal basis of any subspace $F\subseteq\Lambda^2$, and uses $\operatorname{Ric}(W)=0$ only through the common eigenbasis. The corollary is where $\operatorname{Ric}(W)=0$ does the work."
3. What it does, replace "*It is the first ingredient on file that couples two eigenspaces, and it holds at every $n$ with only $\operatorname{Ric}(W)=0$.*" with "*Applied to $F=E_0\oplus E_2$ with $\operatorname{Ric}(W)=0$, which at $\lambda_1=0$ gives $A_2=\tfrac{\lvert\lambda_0\rvert}{\lambda_2}A_0$, it is the first ingredient on file that couples two eigenspaces, at every $n$.*"
4. What it does, replace "A near-star at $\lambda_1=0$ has" with "Heuristically, a near-star at $\lambda_1=0$ has".
5. Corollary (optional sharpening): "whenever $\lambda_1=0$, no extreme eigenspace is a star $e\wedge U$ with $1\le p\le n-1$".
6. Lean docstring: `star_forces` should read `star_impossible_at_zero` and `star_sign`.
