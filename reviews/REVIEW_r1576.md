# Review r1576: batch 46, the Weyl-invariant instability test Phi on torus-invariant idempotents of so(2m)

Log: agent_logs/r1576.log

**Overall: CONFIRMED WITH CORRECTIONS** (two wording corrections, one count discrepancy, no mathematical defect).

| claim | verdict | reason in one line |
|---|---|---|
| W1 the forms on span{C, I_t, I_R} | CONFIRMED | every entry of G and L rederived from L268's bracket data. screened exactly (to 1e-14) on L267's idempotent at m = 4, 5, 6, 7, 10 |
| W2 the factorisation and p(1/2) = -Phi | CONFIRMED | C's column of L equals its column of G, so (1 - lambda) factors. leading coefficient of p computed by hand equals det G. det G > 0 exactly off the uniform point |
| W3 the instability conclusion | CONFIRMED (wording corrected) | sign logic and orthogonality to C are right, but the destabilising vector lies in span{C, I_t, I_R} ∩ C^perp, which is the projection of span{I_t, I_R} onto C^perp, and is generally not itself in span{I_t, I_R} nor Weyl-invariant |
| W4 the screens and the conjecture | CONFIRMED (count corrected) | all eight Phi values reproduced. stated as a conjecture. implication to U_s on positive-definite torus-invariant idempotents holds. obstacle accurate. but a bounded so(8) screen finds 25 distinct positive solutions, not sixteen |
| W5 Lean | CONFIRMED | weyl_test's matrices are L - lambda G entry by entry and its p is the row-cofactor after extracting (1 - lambda). leading coefficient, det G > 0 and the sign logic are prose, correctly so labelled |

## Method

- Footing: analysis only. Every entry and every algebraic step below derived by hand first.
- Screens (reported as screens, never as proof): numpy under sage -python, building so(2m) in the basis E_ij with <X,Y> = -1/2 tr XY (checked I#I = (n-2)I exactly), # via C#X = 1/2 sum lambda_i ad_{v_i} X ad_{v_i}^T. Script at the session scratchpad, r1576.py and r1576b.py.
  - L267's idempotent at n = 2m, m = 4, 5, 6, 7, 10: idempotency error <= 2e-16, commutes with the torus exactly, Gram and form on span{C, I_t, I_R} computed directly and compared with the record's G and L.
  - so(8): 400 fsolve starts on L268's system (fixed budget, 9 seconds), deduplicated at 1e-8.

## W1

- C#I_t: A#I_t = 0 (Cartan abelian). (pp^T)#(h_k h_k^T) = 1/2 alpha_k^2 qq^T, so P_alpha#I_t = 1/2 |alpha|^2 P_alpha = P_alpha. Hence C#I_t = sum mu_alpha P_alpha: zero Cartan block, root scalars mu_alpha. So <C#I_t, I_t> = 0 and <C#I_t, I_R> = 2x (planes are 2-dimensional).
- C#I_R: A#P_beta = (u_beta^T A u_beta)P_beta. From L268's (C#C)_alpha coefficient 1 on sum over unordered pairs, (P_beta#P_gamma)|_{R_alpha} = 1/2 P_alpha, so C#I_R's root scalar at alpha is u^T A u + 1/2 sum_pairs (mu_beta + mu_gamma). Check: I#I root scalar = 2 (from 2 I_t#I_R) + 2(m-2) = 2m-2. Correct.
- <C#I_R, I_R> = 2 tr(A sum u u^T) + sum_alpha sum_pairs(mu_beta+mu_gamma). sum over positive roots of alpha alpha^T = 2(m-1)I, so sum u u^T = (m-1)I, and tr A = 2 sum mu^2 |u|^2 = 2y: first term 4(m-1)y. For alpha = e1-e2 the pairs are {e1-ek, e2-ek}, {e1+ek, e2+ek}. For e1+e2 they are {e1-ek, e2+ek}, {e1+ek, e2-ek}: the 4(m-2) roots in the 2(m-2) pairs are distinct and are exactly the neighbours. So each beta is counted once per neighbour alpha, 4(m-2) times: second term 4(m-2)x. W confirmed.
- Remaining entries: <C#C,H> = <C,H> gives L's first row (q, 2y, 2x). symmetry of L is self-adjointness of L_C. Gram: ||I_t||^2 = m, ||I_R||^2 = 2R, <I_t,I_R> = 0, <C,I_t> = tr A = 2y, <C,I_R> = 2x.
- Screen: record's G and L agree with direct computation to 3e-14 at m = 4, 5, 6, 7, 10.

## W2

- L's first column equals G's first column (q, 2y, 2x), so C is a pencil eigenvector at lambda = 1. Row 1 of L - lambda G is (1-lambda)(q, 2y, 2x): extract it, leaving M with rows (q,2y,2x), (2y(1-lambda), -lambda m, 2x), (2x(1-lambda), 2x, W-2R lambda). det M is quadratic in lambda.
- Leading coefficient by hand: q(-m)(-2R) - 2y(-2y)(-2R) - 2x(-m)(-2x) = 2qmR - 8y^2 R - 4x^2 m = det G. Also consistent with the lambda^3 coefficient -det G of det(L - lambda G).
- G is the Gram matrix of (C, I_t, I_R), with I_t, I_R independent, so det G > 0 iff C is not in span{I_t, I_R}. Uniform mu gives A = 2 mu^2 (m-1) I, so C is in the span. Conversely, membership forces mu constant. So det G > 0 exactly off the uniform point.
- p(1/2) = -Phi is kernel-checked (fidelity in W5).

## W3

- Logic: G > 0 and L symmetric, so the pencil has real eigenvalues with G-orthogonal eigenvectors. C is the lambda = 1 eigenvector, so the 2-dimensional complement span ∩ C^perp is invariant under G^{-1}L and its eigenvalues are the roots of p. p has positive leading coefficient and p(1/2) = -Phi < 0, so it has a root above 1/2. By Rayleigh there is H in span ∩ C^perp with <C#H,H> > 1/2 ||H||^2, which is instability in L264's sense. Correct.
- **Wording correction.** The record says the eigenvalue sits "on a direction of span{I_t, I_R} orthogonal to C", and the heading says "along the Weyl-invariant directions". Since C is not in span{I_t, I_R}, span{C, I_t, I_R} ∩ C^perp = {v - (<v,C>/q)C : v in span{I_t, I_R}}, the orthogonal projection of span{I_t, I_R} onto C^perp. The destabilising H is such a projection. It carries a C component, so it is generically neither in span{I_t, I_R} nor Weyl-invariant, since C is Weyl-invariant only at the uniform point. Suggested wording: "on the projection to C^perp of a direction in span{I_t, I_R}", and "along projections of Weyl-invariant directions".
- Phi = 0 at I/c: there C lies in the span, so G and L share a kernel vector, det(L - lambda G) vanishes identically, and p = 0 as a polynomial, so Phi = -p(1/2) = 0. The test is then degenerate at I/c and gives no stability information there. The record claims only Phi = 0, which is correct.
- Screen: top non-unit pencil eigenvalue 0.6036, 0.6027, 0.5869, 0.5693, 0.5238 at L267, m = 4, 5, 6, 7, 10. All exceed 1/2, consistent with Phi > 0.

## W4

- Values reproduced: Phi = 1.6708, 4.5960, 7.9885, 11.2382, 13.2950 at L267, m = 4, 5, 6, 7, 10, matching the record's 1.671, 4.60, 7.99, 11.24, 13.30.
- so(8), a bounded screen: 25 distinct positive solutions of L268's system (none of them the uniform point, which fsolve did not hit), with Phi in {1.0378 (9 solutions), 1.0408 (15), 1.6708 (1)}, all positive. The three values match the record's 1.038, 1.041, 1.671. **Count discrepancy:** the record says "so(8)'s sixteen", and this screen finds at least 25 distinct ones (24 non-uniform besides L267's). The record should say "at least 25" or state the equivalence under which it counts sixteen. The conclusion is unaffected: Phi > 0 on every solution found.
- The conjecture is stated as a conjecture. Implication: Phi > 0 at every non-uniform positive solution makes every non-uniform positive-definite torus-invariant idempotent unstable (W3). By L268, uniform mu solves only at mu = 1/(2m-2), which is I/c. So U_s holds on the positive-definite torus-invariant idempotents of so(2m). The scope word "positive-definite" should be carried in the sentence, since L268's system covers only mu > 0. The "Weyl-invariant directions" phrase needs the W3 correction.
- Obstacle: summing L268's equation over alpha gives x = 4 sum mu^3 + sum_alpha mu_alpha^2 sum_{beta~alpha} mu_beta + sum over unordered neighbour pairs mu_beta mu_gamma. With (u_alpha . u_beta)^2 in {1, 1/4, 0}, tr(AB) = 4 sum mu^3 + sum_alpha mu_alpha^2 sum_{beta~alpha} mu_beta. So the stated identity holds with the last sum read over unordered pairs, and the record should say so. Pairing with mu gives y = ||A||^2 + T, T = sum_alpha mu_alpha sum_pairs mu_beta mu_gamma, one further relation of the same kind. The obstacle as stated is accurate.

## W5

- weyl_test (lean/HamiltonsCubic/Results/I117LemmaF.lean, line 262): first det3 is L - lG with L = [[q,2y,2x],[2y,0,2x],[2x,2x,W]], G = [[q,2y,2x],[2y,m,0],[2x,0,2R]], entry by entry. The right side is (1-l) times det3 of exactly my M, and the second conjunct is det3 M at l = 1/2 equal to -Phi with Phi as written. det3_eq ties det3 to Matrix.det. No sorry or native_decide in the file.
- Prose, untyped: the entries of G and L (W1), the leading coefficient of p equal to det G, det G > 0 off the uniform point, and the eigenvalue/sign argument. The table says this for the entries. The leading-coefficient and sign steps are also untyped, which the record should state alongside.
