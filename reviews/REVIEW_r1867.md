# r1867: Gate 2 verdicts on L216's gap at every sphere product

**Cold brief, analysis only.** Reviewer r1867 read [L216Unbal.lean](../lean/HamiltonsCubic/Results/L216Unbal.lean) at source together with the statements it consumes: `L3_gap` in [L3Gap.lean](../lean/HamiltonsCubic/Results/L3Gap.lean), `quad_le_of_gap` in [L3Quad.lean](../lean/HamiltonsCubic/Results/L3Quad.lean), `LeRestr` and `LeRestr_isSymmetric` in [L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean), `no_critical_in_tube_Le` in [L217Le.lean](../lean/HamiltonsCubic/Results/L217Le.lean), `P_plane` and `hasDerivAt_cub` in [L216Bern.lean](../lean/HamiltonsCubic/Results/L216Bern.lean), `L27_half_span` in [L27Span.lean](../lean/HamiltonsCubic/Results/L27Span.lean), and the balanced predecessor [L216Sphere.lean](../lean/HamiltonsCubic/Results/L216Sphere.lean). On the record side it read Lemma L216 and its corollary in [second-order.md](../findings/second-order.md), Lemmas L26 and L27 in [nondegeneracy.md](../findings/nondegeneracy.md), and the L216 row of [lean/INDEX.md](../lean/INDEX.md). The only computation was one `lake env lean` run on a scratch file in /private/tmp/r1867/, importing the built module: `#print axioms` on the three theorems, `norm_num` evaluations of `lamTop` at (3,4), (3,3) and (3,10), and a proof that the record's min form of the gap equals `1/2 - lamTop` on p, q ≥ 3. The olean was built at 16:26, one minute after the source was last written at 16:25.

| # | Claim | Verdict |
|---|---|---|
| 1 | `gap_lt_half`: max(λ_p, λ_q, μ) < ½ at p, q ≥ 3 off (3,3) | CONFIRMED |
| 2 | `Le_gap_sphere`: ⟨L_e H, H⟩ ≤ max(λ_p, λ_q, μ) for unit Weyl H ⊥ M orthogonal to the ½-eigenvectors | CONFIRMED |
| 3 | `L216_sphere_general`: step 5 with γ_{p,q} = ½ − max(λ_p, λ_q, μ) as a negative derivative | CONFIRMED WITH OBSERVATIONS |
| 4 | The L216 row's new text | CONFIRMED WITH OBSERVATIONS |

**Summary: all three theorems say what the row says they say, on the standard three axioms, and the γ they use is the record's γ_{p,q} identically, the only defect being that the record's own Lean note in second-order.md still lists the gap at p ≠ q as prose.**

## A. Hypothesis inventory, used and unused

`gap_lt_half` uses all three hypotheses: `hp` and `hq` for the two λ bounds and for positivity of the denominators, `hne` to force one of p, q strictly above 3 so that (p−2)(q−2) − 1 > 0. The case split is sound: at p = 3 the proof takes q > 3 from `hne`, and otherwise p > 3, and either gives (p−2)(q−2) > 1 over the reals with p, q ≥ 3 by `nlinarith`.

`Le_gap_sphere` uses `hp` and `hq` (passed to `L3_gap`, and cast for θ > 0), `ht` and `hn` (θ > 0, unit norm of M, criticality through `sphere_isCritical2`, all feeding `LeRestr_isSymmetric`), `hHW` and `hperp` (to build the element of `weylPerpR M`), `hH1` (to turn `lamTop * ‖v‖^2` into `lamTop`), and `horb` (as the orthogonality hypothesis of `quad_le_of_gap`). Nothing is unused. It carries no `hne`, correctly, since `L3_gap` needs none.

`L216_sphere_general` uses every hypothesis: the list above through `Le_gap_sphere`, plus `hM0`, `hM`, `hs0`, `hsr` passed to `no_critical_in_tube_Le`, whose `hgap` it discharges by `linarith` from ½ − (½ − lamTop) = lamTop. It also carries no `hne` (see D and O2).

## B. Is γ_{p,q} the record's?

Yes, identically. The corollary under Lemma L216 in [second-order.md](../findings/second-order.md) writes γ_{p,q} = min(1/(2(p−1)), 1/(2(q−1)), ½ − μ). Since ½ − λ_m = ½ − (m−2)/(2(m−1)) = 1/(2(m−1)), this is ½ − max(λ_p, λ_q, μ) = ½ − `lamTop p q`. The scratch file proves that equality in Lean for all real p, q ≥ 3 through `min_sub_sub_left`, so it holds whichever sector binds.

Which sector binds does vary at p ≠ q. At (3,4), μ = 5/12 binds over λ_4 = 1/3 (the record's own exception, [nondegeneracy.md](../findings/nondegeneracy.md) line 89). At (3,10), λ_10 = 4/9 binds over μ = 11/36, and `norm_num` confirms `lamTop 3 10 = 4/9`. So λ_q does sit above μ at unbalanced splits, and a γ written as ½ − μ alone would be wrong there. The file and the record both take the max (equivalently the min of gaps), so they agree.

## C. Is L3_gap's bound sharp enough to be a gap at every p, q ≥ 3 off (3,3)?

Yes. `L3_gap` bounds every eigenvalue off ½ by exactly `lamTop`, and `gap_lt_half` puts `lamTop` below ½. The bound is the record's spectrum (L27's ten values have maximum ½ on the orbit summand and next value max(λ_p, λ_q, μ)), so it is sharp, not merely sufficient. By hand at (3,4): λ_3 = 1/4, λ_4 = 2/6 = 1/3, μ = 5/(2·2·3) = 5/12, so `lamTop` = 5/12 and γ = 1/12, matching the record's "(3,4) being the one where μ binds at 1/12". `norm_num` confirms `lamTop 3 4 = 5/12`.

## D. Is horb still the orbit tangent at p ≠ q, and what happens at (3,3)?

`horb` asks H orthogonal to every Weyl K with K ⊥ M and L_e K = K/2. `L27_half_span` in [L27Span.lean](../lean/HamiltonsCubic/Results/L27Span.lean) identifies that set with the span of `crossOrbit T t` at every p, q ≥ 3 off (3,3), with no balance hypothesis, so at p ≠ q `horb` is exactly orthogonality to the cross orbit tangents, the record's hypothesis. Neither file composes the two, and the row does not claim they are composed. (r1866 O2 recorded the same for the balanced case.)

At (3,3) the hypotheses of `Le_gap_sphere` are satisfiable, the ½-eigenspace is 18-dimensional against an orbit of 9, and `horb` demands orthogonality to the extra nine directions too. The theorem stays true there but says only ⟨L_e H, H⟩ ≤ ½, since `lamTop 3 3 = 1/2` (confirmed by `norm_num`). `L216_sphere_general` at (3,3) is vacuous: `hsr` reads s < 0 against `hs0`. So admitting (3,3) costs nothing and asserts nothing false.

## E. Does the row claim more than the Lean proves?

The row's clause on [L216Unbal.lean](../lean/HamiltonsCubic/Results/L216Unbal.lean) matches the three statements word for word: `lamTop` as max(λ_p, λ_q, μ), `gap_lt_half` through (p−2)(q−2) > 1, `Le_gap_sphere` with H orthogonal to the ½-eigenvectors (the row says "½-eigenvectors", not "orbit tangent"), and `L216_sphere_general` as a negative derivative. What it owes is listed in the row's "does NOT state" paragraph, which already names step 1, equivariance to the orbit's other points, and the final inference from φ′(s) < 0 to non-criticality. It does not overclaim. Two gaps in what surrounds it are recorded as O1 and O3.

## F. #print axioms

All three theorems depend on `[propext, Classical.choice, Quot.sound]`, the standard three, with no `sorryAx`. In the same run `norm_num` closed `lamTop 3 4 = 5/12`, `lamTop 3 3 = 1/2` and `lamTop 3 10 = 4/9`, and `#check` returned the signature of `L216_sphere_general` as the brief states it. The identity of B (record's min form equals `1/2 - lamTop` for real p, q ≥ 3) closed on a second run, the first attempt having failed only because `field_simp` lacked p − 1 ≠ 0 and q − 1 ≠ 0 in context.

## G. The objects that would break each statement, and what was done to look for them

- `gap_lt_half`: breaks at (3,3), where μ = ½ exactly, and at min(p,q) = 2, where μ > ½. Both are excluded by the hypotheses. Checked by hand through ½ − μ = ((p−2)(q−2) − 1)/(2(p−1)(q−1)) and by `norm_num` at (3,3).
- `Le_gap_sphere`: breaks for H with a component along M (⟨L_e M, M⟩ = 1) or along a cross orbit tangent (value ½ > `lamTop`). `hperp` and `horb` exclude both. It would also break if `L3_gap` missed a sector of the spectrum. `L3_gap`'s statement covers every eigenvalue on `weylPerpR M` other than ½, and `quad_le_of_gap` expands v in an eigenbasis of the symmetric `LeRestr`, so no sector escapes. Looked for by reading both statements against L27's ten values.
- `L216_sphere_general`: breaks for s at or above 4θγ/(9 M_P), or for H along the orbit (φ constant, derivative zero). The first is `hsr`, the second `horb`. Looked for by reading `no_critical_in_tube_Le` and checking that its conclusion is literally the derivative that `hasDerivAt_cub` produces after `P_plane`.

No breaking object satisfies the hypotheses.

## Observations

- **O1. The record's Lean note for L216 is stale.** The italic Lean paragraph under Lemma L216 in [second-order.md](../findings/second-order.md) (line 1447) still lists "the gap at p ≠ q" among what stays prose and cites only [L216Sphere.lean](../lean/HamiltonsCubic/Results/L216Sphere.lean). With `Le_gap_sphere` and `L216_sphere_general` proved, that clause should now point at [L216Unbal.lean](../lean/HamiltonsCubic/Results/L216Unbal.lean). The working tree shows no change to second-order.md, so the downstream sweep is owed.
- **O2. The docstrings say "off (3,3)" while `Le_gap_sphere` and `L216_sphere_general` carry no `hne`.** Harmless (D), but a reader of the signature alone sees no exclusion. Positivity of γ lives only in `gap_lt_half`, which neither theorem calls. A version of `L216_sphere_general` taking `hne` and concluding the radius is positive would state the corollary's content in one place.
- **O3. The bridge from ½-eigenvectors to the orbit tangent is still two theorems apart.** `horb` is discharged by `L27_half_span` off (3,3), but nothing composes them, so the record's hypothesis "H orthogonal to T_M O" is not yet what the Lean consumes. Same as r1866 O2 in the balanced case.
- **O4. `L216Sphere.lean`'s `Le_gap_balanced` is now a special case.** At p = q = m ≥ 4, `lamTop` = (m−2)/(2(m−1)) (as `L3_gap_balanced` shows), so `Le_gap_sphere` subsumes it. Both can stay, but the row lists them as parallel results.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** The three theorems are correct, use every hypothesis, rest on the standard three axioms, and γ_{p,q} = ½ − `lamTop` is the record's corollary gap identically. The row states no more than the file proves. O1 (a stale record line) is the one item that needs an edit.
