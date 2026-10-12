# REVIEW r1899: g2 torus family, trace at least 2

Log: [agent_logs/r1899-g2-trace.log](../agent_logs/r1899-g2-trace.log). Section under review: [2026-09-28l-I117-g2-torus.md](2026-09-28l-I117-g2-torus.md), "H asks nothing more of g2's torus family". Lean: [G2TorusTrace.lean](../lean/HamiltonsCubic/Results/G2TorusTrace.lean).

**Verdict: the g2 theorem and the sp(k) bullet are both correct. One correction to the statement's wording: the parabola alone does not give 4/5 at every trace of at least 2, so it has to be read together with the tau^2/14 bound.**

| # | claim | verdict |
|---|---|---|
| 1 | short rows | CONFIRMED |
| 2 | trace formula | CONFIRMED |
| 3 | proof chain | CONFIRMED |
| 4 | conclusion and what it settles | CONFIRMED with a wording correction |
| 5 | sp(k) bullet | CONFIRMED |
| 6 | Lean | CONFIRMED |

## 1. The short rows (CONFIRMED)

Concrete model: short roots S_0, S_1, S_2 at angles 0, 60 and 120 degrees with length^2 2/3, and long roots L_0, L_1, L_2 at 90, 150 and 30 degrees with length^2 2, so L_i is perpendicular to S_i.

- Dot products: short against short at 60 or 120 degrees gives (1/3)^2 = 1/9, and a short root against itself gives (2/3)^2 = 4/9. A long root meets a short one at 30 or 150 degrees with dot product (2/sqrt3)(sqrt3/2) = 1, squared 1. L_i against S_i gives 0. So sigma_i = x_j^2 + x_k^2 + (4/9)y_i^2 + (1/9)(y_j^2 + y_k^2) as written.
- Pairs that produce S_0: S_0 = S_1 - S_2, which is two short roots onto a short one, coefficient 2/3, giving (4/3)y_1y_2. S_0 = L_2 - S_1 gives x_2y_1 (coefficient 1/2, doubled). S_0 = S_2 - L_1 gives x_1y_2. S_0 +/- L_0 has length^2 8/3 and is not a root, and long plus or minus long is never short. The row is y_0(1 - sigma_0) = x_2y_1 + x_1y_2 + (4/3)y_1y_2, which is x_ky_j + x_jy_k at (i,j,k) = (0,1,2).
- The rotation by 60 degrees sends (S_0,S_1,S_2) to (S_1,S_2,-S_0) and (L_0,L_1,L_2) to (L_1,-L_2,L_0). It carries the S_0 row to y_1(1 - sigma_1) = x_2y_0 + x_0y_2 + (4/3)y_0y_2, which matches the pattern and Lean's r1. The proof uses the pattern only through x >= 0 and y_j, y_k <= y_i, so a transposition error would not have mattered anyway.
- Screen: all weights 1/4 satisfies the row (both sides equal 5/24) and has trace 7/2 = 14/4, which is consistent with I/4.

## 2. Trace formula (CONFIRMED)

C = A + sum_alpha w_alpha P_alpha. Each P_alpha has rank two, so its trace is 2. The trace of A = sum_alpha w_alpha^2 alpha alpha^T is sum_alpha w_alpha^2 |alpha|^2. That gives sum_alpha (2w_alpha + |alpha|^2 w_alpha^2), which is 2x + 2x^2 per long weight and 2y + (2/3)y^2 per short weight.

## 3. Proof chain (CONFIRMED)

Checked link by link:

- **Largest-weight step.** With y_j, y_k <= y_i and x >= 0, x_ky_j <= x_ky_i and x_jy_k <= x_jy_i. For the product term, (4/3)y_jy_k = (2/3)(y_jy_k + y_jy_k) <= (2/3)(y_iy_k + y_jy_i).
- **Division and G_i >= 1.** y_i > 0 gives 1 - sigma_i <= x_j + x_k + (2/3)(y_j + y_k).
- **Term comparisons.**
  - Long weights: 2x + 2x^2 = 2(x + x^2), with equality.
  - The other two short weights: 2y + (2/3)y^2 >= (4/3)y + (2/9)y^2.
  - The largest short weight: 2y_i + (2/3)y_i^2 >= (8/9)y_i^2 holds exactly when y_i <= 9.
- **The bound y_i <= 9.** The right side of the row is positive, so sigma_i < 1, which forces (4/9)y_i^2 < 1 and y_i < 3/2. This needs only y_j, y_k > 0, or a positive x.
- **The weights left out of G_i.** Only x_i remains, and 2x_i + 2x_i^2 >= 0 only adds. Every other weight appears in G_i exactly once. So tr C >= 2G_i >= 2.

## 4. Conclusion and what it settles (CONFIRMED, wording correction)

- **Correction.** The phrase "hence ||C||^2 >= (3/5)·2 - 4/10 = 4/5" treats the parabola f(tau) = (3/5)tau - tau^2/10 as if it were increasing. It peaks at tau = 3, and f(tau) >= 4/5 holds only on [2, 4]. For tau >= 4, Cauchy–Schwarz supplies the rest: tau^2/14 >= 16/14 > 4/5, and it already covers everything from sqrt(11.2) ≈ 3.35. So 4/5 holds for every tau >= 2, but only from the pair of bounds. The sentence should cite both, as the section above does for 12/7 ("the parabola covers [12/7, 30/7] and tau^2/14 the rest"). The 36/49 claim that H uses is unaffected, since it goes through g2_threshold, which splits the cases.
- **Coverage.** The trace bound needs only short weights > 0 and long weights >= 0. That covers every positive-definite torus idempotent, and also those with some long weights zero.
- **Stability.** No stability or stabiliser hypothesis enters. L270 asks for stable positive-definite C, so a bound over all positive-definite C is stronger than H needs.
- **"The trivial-stabiliser type needs no enumeration for H."** This follows, given that the type sits inside the positive-definite torus family. U_s at 7/8 is correctly left open: 4/5 < 7/8.
- **The su(2) remark.** It is consistent: w = 1/2 on one long root gives trace 1 + 1/2 = 3/2, with short weights zero.

## 5. The sp(k) bullet (CONFIRMED)

- **G from the p-row.** Let p_ij be the largest short weight among all p's and q's. Then (u_i + u_j)q_ij <= (u_i + u_j)p_ij. Also p_ilp_jl <= p_ij·min(p_il, p_jl) <= p_ij(p_il + p_jl)/2, and the same holds for q_ilq_jl. So the right side is at most p_ij[(u_i + u_j) + (1/4)sum_{l≠i,j}(p_il + p_jl + q_il + q_jl)]. Dividing by p_ij gives G >= 1 with X^-_ij. The q-row with q_ij the largest is the mirror image, with X^+_ij.
- **X^-_ij as a sum of squares.** Expanding a_i and a_j, the l = j term of a_i and the l = i term of a_j contribute (1/2)(p_ij^2 + q_ij^2). The rest gives X^-_ij = u_i^2 + u_j^2 + p_ij^2 + (1/4)sum_{l≠i,j}(p_il^2 + q_il^2 + p_jl^2 + q_jl^2), with q_ij^2 cancelling exactly.
- **Cross-check of X^-.** Take |eps|^2 = 1/2. Then (eps_i - eps_j)^2 = 1, giving coefficient 1 on p_ij^2 and 0 on q_ij^2. (2eps_i)·(eps_i - eps_j) = 1, giving 1 on u_i^2. (eps_i - eps_l)·(eps_i - eps_j) = 1/2, giving 1/4. All coefficients are nonnegative. X^+ is the mirror image, with q_ij^2.
- **Factor-two comparisons.** The trace terms are 2u + 2u^2 and 2p + p^2.
  - u_i and u_j have part u + u^2, so twice the part equals the trace term.
  - The other short weights p_il, q_il, p_jl, q_jl have part (1/4)(w + w^2), and 2w + w^2 >= (1/2)(w + w^2).
  - The largest weight p_ij has part p_ij^2, and 2p + p^2 >= 2p^2 when p <= 2. Here p_ij^2 <= X^- < 1, because the right side is positive once some u > 0.
  - q_ij has part 0 in the p-row.
  - The weights left out only add, so tr C >= 2.
- **Against tau_-.** Screen of k = 2: (1/2)(tau - tau^2/10) = 36/49 gives tau_- = 1.79, which matches the premise. Since 2 >= tau_- and the upper range is covered by Cauchy–Schwarz above tau_+ >= 2k+1, and 2 lies between tau_- and tau_+, the conclusion follows at k = 2 and k = 3 given the quoted thresholds. At k = 4, 2 < 2.08, so the argument falls short there, as stated.

## 6. Lean (CONFIRMED)

- **Compile.** A scratch copy of the file compiles with `lake env lean` (exit 0, no errors or sorry). `#print axioms` on `g2_torus_trace` and `g2_torus_H` gives only [propext, Classical.choice, Quot.sound].
- **`g2_torus_trace`.** The hypotheses are x_i >= 0 and y_i > 0. Its rows r0, r1 and r2 match the pattern derived in claim 1 exactly: r0 has x2*y1 + x1*y2, r1 has x2*y0 + x0*y2, r2 has x1*y0 + x0*y1. The conclusion is 2(sum x^2) + (2/3)(sum y^2) + 2(sum x) + 2(sum y) >= 2, which is claim 2's trace. The three-way case split on the largest y is exhaustive.
- **`row_bound`, `weight_lt` and `trace_of_row`** state the three proof links as in the table. `weight_lt` proves y0 < 9 from positive y_a and y_b.
- **`g2_torus_H`.** τ and q are abstract reals, with the pairing core and Cauchy–Schwarz entering as hypotheses. It is g2_threshold with 12/7 <= 2. The link from `g2_torus_trace`'s expression to τ = tr C, and the rows' derivation from C^#C = C, are prose, as the table says. The 4/5 of the statement is not in Lean. Only 36/49 is.
- **Non-vacuity.** The example checks that I/4 satisfies the row.
