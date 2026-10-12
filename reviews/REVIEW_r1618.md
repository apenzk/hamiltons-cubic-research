# REVIEW r1618: L127's within-factor eigenspaces, and the second family's top

Log: [agent_logs/r1618.log](../agent_logs/r1618.log)

Scope: pairSpan_eq_iff, within_kernel_iff and within_neg_iff in [L127WMult.lean](../lean/HamiltonsCubic/Results/L127WMult.lean) at commit 87da67cf, within_top_exists_out and within_top_ne_zero_out in [L127Within.lean](../lean/HamiltonsCubic/Results/L127Within.lean) and the docstring fix in [L127Mult.lean](../lean/HamiltonsCubic/Results/L127Mult.lean) at commit 1f867eff, and the L127 row of [lean/INDEX.md](../lean/INDEX.md), against [findings/second-order.md](../findings/second-order.md) Lemma L127 and its full within-factor spectrum {λ_p, (−μ)^{q−1}, 0^{p−3}}. Analysis only: the build and the axiom audit were run, and every identity below was checked by hand.

**All five declarations are correct in both directions and kernel-checked on the standard three. The kernel and the negative eigenspace are characterised exactly, −½(2t + α + β) is −μθ identically in p, q, and the second family's top now occurs at q ≥ 3, closing r1616's gap 1. One gap: the stated kernel dimension p − 3 and the exhaustion count are asserted under the theorem's hypothesis p ≥ 2, where at p = 2 the kernel is {0} and the top is absent, the very defect the record flags for this row.**

| claim | declaration | verdict |
|---|---|---|
| C1 | pairSpan_eq_iff, eigen-equation on the pair span iff coefficient equations | CONFIRMED |
| C2 | within_kernel_iff, kernel on the Ricci cut iff C_T = 0 and c = 0 on the second factor | CONFIRMED (p = 2 included) |
| C3 | the kernel has dimension p − 3 | GAP (true at p ≥ 3, stated under p ≥ 2, prose) |
| C4 | within_neg_iff, the −½(2t + α + β)-eigenspace is second-factor supported with zero sum, dimension q − 1 | CONFIRMED (dimension is prose, disclosed) |
| C5 | −½(2t + α + β) = −μθ, the record's (−μ)^{q−1} | CONFIRMED (by hand, prose in the file, owed in the row) |
| C6 | the three eigenspaces exhaust the Ricci cut, (p − 3) + (q − 1) + 1 = n − 3 | CONFIRMED at p ≥ 3, marked prose, GAP at p = 2 (see C3) |
| C7 | within_top_exists_out, within_top_ne_zero_out | CONFIRMED (closes r1616 gap 1) |
| C8 | L127Mult docstring splice removed | CONFIRMED (closes r1616 gap 2) |
| C9 | the L127 row's owed list | CONFIRMED (honest) |
| C10 | build and axiom audit | CONFIRMED (3/3 and 14/14 on propext, Classical.choice, Quot.sound) |
| C11 | downstream text | CONFIRMED (nothing stale) |
| C12 | style | CONFIRMED |

Summary: the within-factor eigenspaces are characterised soundly and the second family's top is closed, and what remains is a p = 2 qualification on two prose dimension statements.

## 1. The block in coefficients

withinPair ([L127Within.lean:243](../lean/HamiltonsCubic/Results/L127Within.lean#L243)) gives, at j, k ∈ T on the Ricci cut C_A + C_B = 0 (C_A the sum over s ∩ T, which has p − 2 indices, C_B over s ∖ T, which has q), κ_q = ½(α + t) C_A at q ∈ T and κ_q = ½(−2t − α − β) c_q + (t + β) C_B at q ∉ T, with α = tq/(p − 1), β = tp/(q − 1). This was confirmed by r1614.

## 2. pairSpan_eq_iff (C1)

- **Forward.** Evaluating at φ_jq, pair_eval returns κ_q φ_kq on the left and λ c_q φ_kq on the right, and the (q, k) entry of φ_kq is nonzero (phi_entry'), so κ_q = λ c_q. The needed facts, q ≠ j, q ≠ k, j ≠ k, are all in hand.
- **Converse.** Pointwise substitution under the sum. Correct for arbitrary κ and c, as the docstring says.

## 3. within_kernel_iff (C2, C3)

- **Forward.** If s ∩ T is nonempty, κ_q = 0 at some q ∈ T gives C_A = 0 since ½(α + t) > 0 at t > 0. If it is empty (exactly p = 2), C_A = 0 as an empty sum. Then C_B = −C_A = 0, and at q ∉ T the equation reads ½(−2t − α − β) c_q = 0 with a strictly negative factor, so c_q = 0. Both branches are sound, including p = 2.
- **Converse.** C_A = 0 kills the first-factor coefficients, and c = 0 off T gives C_B = 0 and the second-factor coefficients vanish.
- **The sign.** The second-factor coefficient −½(2t + α + β) is strictly negative at t > 0, which is what the proof uses. Correct.
- **Dimension.** The kernel is {c on s ∩ T with zero sum}, which is p − 3 at p ≥ 3. At p = 2 it is {0}, dimension 0 rather than p − 3 = −1. The theorem is stated under hp : 2 ≤ T.card, and the docstrings at [L127WMult.lean:13](../lean/HamiltonsCubic/Results/L127WMult.lean#L13) and [L127WMult.lean:49](../lean/HamiltonsCubic/Results/L127WMult.lean#L49) and the row's "(dimension $p-3$)" at [lean/INDEX.md:495](../lean/INDEX.md#L495) state p − 3 without the p ≥ 3 qualification. The record's own 0^{p−3} carries the same implicit assumption, and the record says this row is false at p = 2. **GAP**, prose only.

## 4. within_neg_iff and −μθ (C4, C5)

- **Forward.** An index q ∈ Tᶜ exists and lies in s since j, k ∈ T. At that q the equation reduces to (t + β) C_B = 0, so C_B = 0, then C_A = 0, and at q' ∈ T the equation reads 0 = neg · c_q' with neg < 0, so c_q' = 0. Sound.
- **Converse.** c = 0 on T gives C_A = 0 and κ = neg · c on T, and at q ∉ T C_B = 0 leaves κ_q = neg · c_q.
- **Dimension.** q second-factor coefficients with one sum constraint, q − 1. The Ricci cut is automatic there. Prose, disclosed.
- **Identification.** 2 + q/(p − 1) + p/(q − 1) has numerator 2(p − 1)(q − 1) + q(q − 1) + p(p − 1) = n² − 3n + 2 = (n − 1)(n − 2) over (p − 1)(q − 1), so −½(2t + α + β) = −t(n − 1)(n − 2)/(2(p − 1)(q − 1)) = −θ μ_{p,q} with θ = t(n − 1) and μ_{p,q} = (n − 2)/(2(p − 1)(q − 1)), the four-set row's μ. At S² × S⁴ this is −⅔θ, the record's (−⅔)³. The division by θ is listed as owed.

## 5. Exhaustion (C6)

At p ≥ 3 the kernel (p − 3), the negative eigenspace (q − 1) and the top line from within_top_exists (1) sum to n − 3 = |s| − 1, the Ricci cut's dimension, and three eigenspaces for distinct eigenvalues are independent, so they exhaust it. The module docstring says the counts are prose. At p = 2 within_top_exists does not apply (it needs 3 ≤ T.card) and the Ricci cut is the negative eigenspace alone, dimension q − 1 = n − 3, which is what the record's p = 2 box says. The arithmetic (p − 3) + (q − 1) + 1 = n − 3 still holds at p = 2 formally, but its summands do not, so [L127WMult.lean:16](../lean/HamiltonsCubic/Results/L127WMult.lean#L16) wants "at p ≥ 3". Folded into the C3 gap.

## 6. within_top_exists_out and within_top_ne_zero_out (C7, C8)

- within_top_exists applied at Tᶜ with the hypotheses swapped (3 ≤ |Tᶜ|, 2 ≤ |Tᶜᶜ| = |T|), and sphereWeight_compl rewriting the weight back to T. The vector is |T| = p on Tᶜ ∖ {j, k} (q − 2 indices) and −(q − 2) on T (p indices), sum p(q − 2) − p(q − 2) = 0. The eigenvalue ½(β + t)(q − 2) = t(n − 1)(q − 2)/(2(q − 1)) is θ λ_q. Correct.
- within_top_ne_zero_out is within_top_ne_zero at Tᶜ. Correct. r1616 gap 1 is closed.
- The L127Mult docstring now reads "gives the inclusion and the occurrence, and this file characterises", no splice. r1616 gap 2 is closed.

## 7. Soundness (C10)

- `lake build HamiltonsCubic.Results.L127WMult HamiltonsCubic.Results.L127Within`: completed successfully, no `sorry` in the output.
- axiom_audit.py --only L127WMult.lean: 3/3 clean. --only L127Within.lean: 14/14 clean. Only propext, Classical.choice, Quot.sound.

## 8. The row and downstream (C9, C11)

- The L127 row names all five declarations and lists as owed the dimension counts as declarations, the division by θ, the D_n row and the agreement of the two decompositions. That is honest about what remains.
- findings/second-order.md and findings/INDEX-results.md carry no reference to the Lean files and nothing stale. STATUS.md and plan-lean.md moved from 865 to 866 files, consistent with one new file.

## 9. Style (C12)

No em dashes and no backticks inside link text in either commit's added lines. The semicolons in the row and the module docstring separate list items that carry commas, the permitted use.

## Gaps

1. [L127WMult.lean:13](../lean/HamiltonsCubic/Results/L127WMult.lean#L13), [L127WMult.lean:16](../lean/HamiltonsCubic/Results/L127WMult.lean#L16), [L127WMult.lean:49](../lean/HamiltonsCubic/Results/L127WMult.lean#L49) and [lean/INDEX.md:495](../lean/INDEX.md#L495): "dimension p − 3" and the exhaustion count are stated under within_kernel_iff's 2 ≤ T.card, but at p = 2 the kernel is {0} and the top is absent. Qualify both with p ≥ 3 (at p = 2 the Ricci cut is the negative eigenspace alone).

## Verdict

**CONFIRMED WITH GAPS**
