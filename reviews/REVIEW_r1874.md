# REVIEW r1874: L221 at a local maximiser, L221Max.lean

Gate 2 review of [L221Max.lean](../lean/HamiltonsCubic/Results/L221Max.lean), which composes the reviewed lemmas `L221a_crit`, `L221b_step1`, `split_weyl`, `L221a_bound` and `L221b_bound` into both parts of [Lemma L221](../findings/second-order.md) at a local maximiser of P on the unit sphere of the space, with criticality derived. Footing: analysis only. The single run was `#print axioms` on the two theorems against a build whose olean postdates the source.

| # | Claim | Verdict |
|---|---|---|
| 1 | `L221a_at_max`: pairwise disjoint four-sets, local maximiser on the unit sphere of `SM Q`, P(W) > 0, some ν_i ≠ 0, gives P(W)² ≤ 3/2 | CONFIRMED |
| 2 | `L221b_at_max`: Q₁ = {a,b,c,d}, Q₂ = {a,b,e,f}, local maximiser on the unit sphere of `SK Q₁ Q₂`, P(W) > 0, two nonzero blocks, τ ≤ 0, gives P(W)² ≤ 6/5 | CONFIRMED |
| 3 | [lean/INDEX.md](../lean/INDEX.md) L221 rows: the bounds in the Q(W) = θW form the record defines, and at a local maximiser with criticality derived | CONFIRMED WITH OBSERVATIONS |

Summary: both theorems are sound compositions with the standard three axioms, their hypotheses match the record's with θ = P(W), and the INDEX rows describe them accurately, with one record cross-reference left to add.

## A. Hypothesis inventory, used and unused

- `L221a_at_max`. `hdis`, `hcard` feed `L221a_crit`, `L221a_bound`, and (through `hne`, `hinj`) `split_weyl`. `hW1`, `hWS`, `hmax` feed `L221a_crit`. `hWS.1` (W Weyl) feeds `split_weyl`. `hD`, `hν`, `hWeq` feed `split_weyl` and `L221a_bound`. `hθ`, `i0`, `hi0` feed `L221a_bound`. Every hypothesis is consumed.
- `L221b_at_max`. The fifteen distinctness hypotheses are passed wholesale to `L221b_bound`, and four of them build `hc2`, `he1`, which `L221b_step1` needs for non-nestedness. `hW1`, `hWS`, `hmax` feed `L221b_step1`. `h1`, `h2`, `h3`, `hD`, `hWeq` feed `split_weyl` through the repackaging `t`, `A`, `hsum`, and then `L221b_bound`. `hτ`, `htwo`, `hθ` feed `L221b_bound`. Every hypothesis is consumed.
- The decomposition. The user's D, ν are independent of the witnesses inside `SM Q` (`InM`) and `SK` (`InK`). The proof never unpacks those witnesses: it takes only the first conjunct of `L221a_crit` and `L221b_step1`, the decomposition-free Q(W) = P(W)·W, and discards the existential. `split_weyl` needs only W Weyl, the character hypotheses and W = D + Σ A_i at pairwise distinct nonempty sets, and `comp_eq_of_split` identifies each component with the isotypic projection `comp (t i) W`. So any decomposition by the right characters is the canonical one, and the nonzero-block hypotheses `hi0`, `htwo` refer to W's own components. Distinctness of the sets holds: in (a) from disjointness and card 4, in (b) from `n12`, `n13`, `n23`, each witnessed by c or e lying in one set and outside another. `Fin 3` repackaging with `Matrix.cons_val_*` and `abel` is sound.

## B. θ = P(W) and θ > 0

`crit_sub` returns Qop2 W = Pcubic2 W • W. At a unit W with Q(W) = θW, `Pcubic2_eq_innerOp2` gives P(W) = ⟨W, Q(W)⟩ = θ‖W‖² = θ, so the record's θ of a unit critical point is exactly P(W), and P(W) > 0 is the record's standing θ > 0. The rewrites `rw [hWeq] at hcrit hW1` and the `e`/`eP` rewrite of the goal and `hθ` put everything in the syntactic form `L221a_bound`, `L221b_bound` expect with θ := Pcubic2 (D + …). The conclusions P(W)² ≤ 3/2 and P(W)² ≤ 6/5 are the record's θ ≤ √(3/2) (equivalent at θ > 0) and θ² ≤ 6/5.

## C. Local maximiser against the record's criticality

The record defines a unit critical point as Q(W) = θW with W ∈ 𝒮 ∩ 𝒲ₙ and notes this is equivalent to criticality of P on the space's unit sphere, derived in Lean only at a local maximiser. `IsLocalMaxOn Pcubic2 {R | normSq2 R = 1 ∧ R ∈ S} W` is a local maximum on exactly that sphere, and a local maximiser is a sphere-critical point, hence the new theorems cover a special case of the record's statement. The general statement is carried by `L221a_bound`, `L221b_bound` in the Q(W) = θW form. Row 153 says the bounds hold "in the Q(W) = θW form the record's statement defines, and at a local maximiser", and row 154 says "both parts also at a local maximiser, criticality derived". Neither row claims that an arbitrary sphere-critical point (a saddle or minimum) is handled with criticality derived, so neither claims more than the Lean gives. This closes r1873 O1 and O3.

## D. Axioms

`#print axioms` on `HamiltonsCubic.L221Max.L221a_at_max` and `HamiltonsCubic.L221Max.L221b_at_max`: both depend on [propext, Classical.choice, Quot.sound], the standard three, with exit code 0. No `sorry` and no project axiom enters through the imported chain.

## E. Breakers, and how I looked

| Target | Object that would break it | What I did |
|---|---|---|
| Claim 1 | A decomposition D, ν of W with ν_{i0} ≠ 0 differing from W's isotypic components, so that the bound is about the wrong blocks, or with D, ν non-Weyl | Read `comp_eq_of_split` and `split_weyl`: the components are forced equal to `comp` of W and Weyl, so no such object exists |
| Claim 1 | A local maximiser with θ ≠ P(W), making `hθ` the wrong hypothesis | Read `crit_sub` and `Pcubic2_eq_innerOp2`: θ = P(W) at a unit W |
| Claim 2 | Configurations where {a,b,c,d}, {a,b,e,f}, {c,d,e,f} coincide, breaking `split_weyl`'s injectivity | Checked `n12`, `n13`, `n23` against the distinctness hypotheses |
| Claim 2 | A mismatch between `symmDiff Q₁ Q₂` in `SK` and {c,d,e,f} in `h3` | `L221b_step1` and `split_weyl` never need the equation, since `split_weyl` is fed t 2 = {c,d,e,f} directly and `hWS.1` only, and `L221b_bound` proves `hsd` itself. The local `hsd` in L221Max is unused (O2) |
| Claim 3 | Row text claiming sphere-criticality in general | Read rows 153 and 154 against C |
| All | A `sorry` or extra axiom in the imported chain | `#print axioms` (D) |

## Observations

- **O1.** The record's provenance paragraph for L221 in [second-order.md](../findings/second-order.md) and its criticality footnote cite `L221a_crit`, `L221b_step1` but not [L221Max.lean](../lean/HamiltonsCubic/Results/L221Max.lean). The footnote remains true, and it would now read better as "which the Lean derives at a local maximiser, and composes into both bounds as `L221a_at_max`, `L221b_at_max`".
- **O2.** In `L221b_at_max` the local `hsd` is computed and never used, and the linter would flag it. Harmless.
- **O3.** The theorems take D, ν from the caller. A variant obtaining them from `SM_components` or `SK_components` would state the nonzero-block and τ hypotheses about W's canonical components directly. By A the two are equivalent, so this is presentation only.
- **O4.** No witness shows the hypotheses of `L221b_at_max` jointly satisfiable (a local maximiser with two nonzero blocks and τ ≤ 0). Soundness does not depend on it, and the record claims no existence. For (a), a global maximiser on the compact sphere of a nonzero `SM Q` has P(W) > 0 whenever P is not identically zero there, since P(−W) = −P(W).
- **O5.** The record's standing n ≥ 6 is implicit in (b) through six distinct indices of Fin n, and absent from (a), which holds for any n admitting the four-sets. This is a mild generalisation.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** Claims 1 and 2 are CONFIRMED, claim 3 is CONFIRMED WITH OBSERVATIONS for the record cross-reference O1. O2 to O5 are presentation.
