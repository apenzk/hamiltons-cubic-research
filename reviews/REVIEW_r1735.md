# REVIEW r1735: L105Op.lean, L105 at the operator

**Cold Gate 2 review of [L105Op.lean](../lean/HamiltonsCubic/Results/L105Op.lean) at commit 50d0dcf2, against [L105Closing.lean](../lean/HamiltonsCubic/Results/L105Closing.lean), [L244Frame.lean](../lean/HamiltonsCubic/Results/L244Frame.lean), [L244RowA.lean](../lean/HamiltonsCubic/Results/L244RowA.lean), [L244RowBMass.lean](../lean/HamiltonsCubic/Results/L244RowBMass.lean), Lemmas L104 and L105 of [bounds-relaxations.md](../findings/bounds-relaxations.md) and the L105 row of [lean/INDEX.md](../lean/INDEX.md).** Analysis-only footing: Lean source read, no `lake build` or `lake env`. One screen was run (both linear eliminations evaluated at 200 random exact-rational points, all equal), reported as a screen and not as evidence. The "6/6 on the standard three" axiom claim is taken from the commit and was not re-run. Log: [agent_logs/review-r1735.log](../agent_logs/review-r1735.log).

| Claim | Verdict |
|---|---|
| `rows_two`: (A), (B), (C) specialised to two classes with lam = (u, -w), b10 = b01, (C) = lc(theta - lc) | CONFIRMED |
| `row_u`: (u+w)^2 b01 = u((n-1)w - theta) via (uw, u-w, -1) | CONFIRMED |
| `row_w`: (u+w)^2 b11 = (n-2)u^2 - 2uw - w^2 - w theta via (u^2, -2u, 1) | CONFIRMED |
| The per-vector route replaces the record's class rows with nothing lost | CONFIRMED |
| `uwN_one`: uw n(n-1)/2 = 1 from tracelessness and unit norm | CONFIRMED |
| `L105_op`: hypotheses match the record's L105 setting, conclusion theta <= theta_0(n) | CONFIRMED |
| INDEX L105 row claims only what is typed | CONFIRMED WITH OBSERVATIONS |

**Summary: CONFIRMED WITH OBSERVATIONS. The Lean route proves the record's two row identities in their pointwise form, which is stronger than the class-averaged rows, and the owed list is right. Two wording points in the INDEX row and the file header are observations only.**

## 1. The rows and the two eliminations

- **Row (A).** `rowA_frame` gives the sum over a, b of b_ab(x) = (n-2)<x,x>. With two classes that is b00 + b01 + b10 + b11. `bAB_symm` gives b10 = b01, and `hunit` gives <x,x> = 1, so b00 + 2 b01 + b11 = n - 2. Correct.
- **Row (B).** `rowB_frame` gives the sum of lam_b b_ab = -<Wx,x>. The terms are u b00 + (-w) b01 + u b10 + (-w) b11 = u b00 + (u-w) b01 - w b11. With Wx = lc x and <x,x> = 1, the right side is -lc. Correct.
- **Row (C).** `rowC_frame` gives the sum of lam_a lam_b b_ab = sharpQF W x, which is u^2 b00 - 2uw b01 + w^2 b11. `rowC_critical` evaluates sharpQF W x = lc(theta - lc) at a unit eigenvector of a theta-critical W. That matches the record's (C_i) right side 2 nu_i(theta - nu_i) at the per-vector normalisation. Correct.
- **`row_u` by hand.** uw(A) + (u-w)(B) - (C) at lc = u. The b00 coefficient is uw + u(u-w) - u^2 = 0. The b01 coefficient is 2uw + (u-w)^2 + 2uw = (u+w)^2. The b11 coefficient is uw - w(u-w) - w^2 = 0. The right side is uw(n-2) - u(u-w) - u(theta - u) = u((n-1)w - theta). Correct.
- **`row_w` by hand.** u^2(A) - 2u(B) + (C) at lc = -w, where (B)'s right side is w. The b00 coefficient is u^2 - 2u^2 + u^2 = 0. The b01 coefficient is 2u^2 - 2u(u-w) - 2uw = 0. The b11 coefficient is u^2 + 2uw + w^2 = (u+w)^2. The right side is (n-2)u^2 - 2uw - w(theta + w). Correct.
- **Screen.** Both identities are affine in (b00, b01, b11). Evaluating both sides at 200 random exact-rational points agreed in every case, as a cross-check of the hand work.

## 2. Same bounds as the record, and the per-vector route

- **Same conclusions.** In `L105_op`, `hpi : theta <= (n-1)w` and `htan : theta w <= (n-2)u^2 - 2uw - w^2` are exactly the conclusions of `L105_pi_bound` and `L105_tangent_bound`. Both are fed to `L105_closing` unchanged. The sign step in `hpi` (0 <= u((n-1)w - theta) with u > 0) is sound.
- **The record's rows are class averages of these.** For x in class u, b01(x) = (1/2) times the sum over gamma in class u and delta in class -w of <[psi_gamma, psi_delta], x>^2. Under the record's T_xgd = c_xgd^2, class-averaged to t112, the gamma sum has r - 1 terms (the gamma = x term vanishes because <[x, y], x> = 0) and the delta sum has N - r. So b01 = (1/2)(r-1)(N-r) t112, and `row_u` becomes (r-1)(N-r)(u+w)^2 t112 = 2u((n-1)w - theta). That is the record's class-1 row exactly. Likewise b11(x) = (1/2)(N-r-1)(N-r-2) t222 for x in class -w turns `row_w` into the record's class-2 row.
- **Nothing is lost.** The record uses only t112 >= 0 and t222 >= 0. The Lean uses b01(x) >= 0 and b11(x) >= 0, which are sums of squares by definition (`bAB_nonneg'`). No link through T is needed.
- **The Lean route is stronger.** It needs no multiplicity hypothesis, which removes both the `hcoef` hypothesis of `L105_tangent_bound` and the record's "segment for multiplicities at least 3" route. This agrees with the record's note that the multiplicity-at-least-3 hypothesis guarded the route and not the conclusion, and with its paragraph on "the block understates its own footing".

## 3. uwN_one

- **N.** `hcard` proves card(Pairs n) = n choose 2 = n(n-1)/2, which is the record's N = binom(n, 2) = dim of Lambda^2 (Lemma L104's first sentence).
- **Counting.** `sum_two` splits each eigenvalue sum over the two classes. The id sum with `sum_mu_zero` (from the Ricci-flat conjunct hW.2.2.2.2) gives r u - s w = 0, which is the record's r u = (N-r) w. The square sum with `sum_mu_sq` and `hunit` gives r u^2 + s w^2 = 1, the record's norm of lambda = 1. The constant sum gives r + s = N. Then uwN = w(ru) + u(sw) = s w^2 + r u^2 = 1. Correct.
- **Normalisation.** `sum_mu_sq` identifies normSq W with the sum of eigenvalues squared on Lambda^2, so `normSq W = 1` is the record's unit norm.

## 4. The hypotheses of L105_op

- **They match the record's setting.** Unit norm, theta-critical, `htwo` (every Lambda^2 eigenvalue is u or -w), `hexu` and `hexw` (both occur, so 1 <= r <= N - 1), and u, w > 0. That is "spectrum takes exactly two values, u > 0 with multiplicity r and -w < 0 with multiplicity N - r".
- **n >= 3.** This is used only by `L105_closing`. At n = 2, N = 1 and two values cannot occur, so no case is excluded. The record notes that n >= 5 is never used, consistent with this.
- **Criticality.** `IsCritical W theta` is the layer's Q(W) = theta W on the phi basis. It is extended to every bivector inside `rowC_critical`, the same predicate used across the reviewed L244 files.
- **Vacuity.** No hypothesis is vacuous or stronger than the record's. The record puts the balanced sphere product at even n in this stratum. The Lean does not construct a witness, and it is not asked to.

## 5. The INDEX row and what is owed

- **Typed claims match the file.** The row names `row_u`, `row_w`, `uwN_one` and `L105_op` with their exact statements.
- **O1 (wording).** The row says "the two row identities and uwN = 1 are PROVED at the operator". What is proved is the pointwise form in b01(x) and b11(x). The `hrow` hypotheses of `L105_pi_bound` and `L105_tangent_bound`, stated in t112 and t222, are never instantiated. `L105_op` goes around those two theorems to `L105_closing`. The mathematics is fully covered (see section 2), but a reader looking for an instance of `L105_pi_bound` will not find one. The file header's "derives both at the operator" has the same reading. A clause such as "in their per-vector form, of which the record's class rows are the average" would make it exact.
- **O2 (not exported).** The record's first inequality, theta <= min{(n-1)w, Q/w}, exists only as the local facts `hpi` and `htan` inside `L105_op`, not as a named theorem at the operator. The INDEX row does not claim it as exported, so this is an observation only.
- **Owed list.** T_abc = c_abc^2, the equality case (r = n(n-2)/4, u/w = n/(n-2), even n, strict at odd n), and r <= 8 from T >= 0. These are the parts of the record's L105 block that nothing in L105Op or L105Closing types. The list is complete for the statement and its proof. The record's side remarks (u/w <= n-2, monotonicity of the branches in r) are not claimed and are not owed by the statement.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** `rows_two`, `row_u`, `row_w`, `uwN_one` and `L105_op` are faithful and sound as read. The per-vector route replaces the record's class-sum row identities with their pointwise form, which is stronger and loses nothing. O1 and O2 are wording and packaging observations with no defect.
