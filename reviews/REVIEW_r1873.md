# REVIEW r1873: L221 (b) at the operators, L221bRay.lean and L221bChain.lean

**Standfirst.** Cold Gate 2 review of [L221bRay.lean](../lean/HamiltonsCubic/Results/L221bRay.lean) (commit ae9f120f) and [L221bChain.lean](../lean/HamiltonsCubic/Results/L221bChain.lean) (staged in the index at review time, olean built 17:17 after the 17:16 source), against Lemma L221 (b) and its proof, steps 1 to 5, in [second-order.md](../findings/second-order.md), and the two L221 rows of [lean/INDEX.md](../lean/INDEX.md). Footing: analysis only. Both files and every consumed lemma were read at source, the polynomial identities behind `rayleigh_sq` and the chain's arithmetic were re-derived by hand, and one `lake env lean` screen ran `#print axioms` on ten declarations. No sweep, no numerical search.

| # | Claim | Verdict |
|---|---|---|
| 1 | `rayleigh_sq`, the quadratic form bound on V_Q | CONFIRMED |
| 2 | `nunu_normSq`, ‖ν∘ν‖² = ¾‖ν‖⁴ | CONFIRMED |
| 3 | `angle12`, `angle13`, `angle23`, `cross_sq` | CONFIRMED |
| 4 | `chain_real`, `block_chain`, steps 2 and 4 on one block | CONFIRMED |
| 5 | `L221b_bound` is L221 (b) | CONFIRMED |
| 6 | The INDEX rows reading L221 proved | CONFIRMED WITH OBSERVATIONS |

**Summary.** L221b_bound is the record's L221 (b) with the record's own hypotheses, in the Q(W) = θW form the record's statement defines, and it rests on the standard three axioms. The only findings are wording on the INDEX rows.

## A. Hypothesis inventory

Hypotheses of L221b_bound, each matched to the record:

- Fifteen distinctness hypotheses on a, b, c, d, e, f. These are exactly |Q₁ ∩ Q₂| = 2 (see B), and they imply the record's n ≥ 6.
- `hDW`, `hD`: D Weyl of character 1. This is D ∈ 𝒟ₙ ∩ 𝒲ₙ, the record's first summand (`trivial_block_iff`).
- `hW1`…`h3`: ν_i Weyl of character χ_{Q_i}. This is ν_i ∈ V_{Q_i} (`four_block_iff`). The record's W ∈ 𝒮 ∩ 𝒲ₙ gives these through `SK_components` and `split_weyl`, as the record's preamble says.
- `hθ : 0 < θ`. The record's statement opens "Let n ≥ 6 and θ > 0".
- `hQ : Qop2 W = θ • W`. The record's definition of a unit critical point in 𝒮.
- `hunit`, `hτ`, `htwo`: unit norm, τ ≤ 0, two nonzero blocks, all in the record.

Nothing is assumed that the record does not assume, and nothing is unused: `hunit` feeds the norm identity, `htwo` closes the case split, and every other hypothesis reaches `block_chain` or `L221b_split`. The labelling Q₁ = {a,b,c,d}, Q₂ = {a,b,e,f} is universally quantified over the six letters, so it costs no generality (B). τ ≤ 0 is required even when ν₃ = 0, where it holds automatically as τ = ⟨ν₁∘ν₂, 0⟩ = 0, so this is the record's parenthetical rather than an extra assumption.

## B. Generality of the configuration

If |Q₁ ∩ Q₂| = 2, write Q₁ ∩ Q₂ = {a,b}, Q₁ \ Q₂ = {c,d}, Q₂ \ Q₁ = {e,f}. The six letters are distinct because the three sets are pairwise disjoint and each has two elements. Then Q₁ △ Q₂ = {c,d} ∪ {e,f} = {c,d,e,f}. Since `Finset` equality ignores order, every such pair is an instance of the theorem.

`hsd` is proved by `ext`, `simp only [mem_symmDiff, mem_insert, mem_singleton]` and `grind` with the fifteen distinctness hypotheses in scope. The goal after `simp` is a propositional statement about equalities of the form x = a, closed by case analysis. It is kernel-checked and its axioms are the standard three (F). Sound.

## C. The pinning

`rayleigh_sq` states ⟨q∘ν, ν⟩² ≤ ¾‖q‖²‖ν‖⁴ at q = Π_Q(x,y,z), x+y+z = 0, ν ∈ V_Q. I re-derived its three quantities by hand. With z = −x−y, the form is F = −6(xu + yv), u = b² − 2ab, v = a² − 2ab, since ⟨q, σ_A∘σ_B⟩ = 2x + 2y − 4z = 6(x+y), ⟨q, σ_A∘σ_A⟩ = −6y, ⟨q, σ_B∘σ_B⟩ = −6x. Also ‖q‖² = 4(x²+xy+y²) and ‖ν‖² = 4K, K = a² − ab + b². The claim reduces to 3(xu+yv)² ≤ 4K²(x²+xy+y²).

- The identity u² − uv + v² = K²: both sides expand to a⁴ + b⁴ + 3a²b² − 2a³b − 2ab³. Correct.
- The perfect square: 4(u² − uv + v²)(x² + xy + y²) − 3(xu + yv)² = (x(u − 2v) + y(2u − v))². Coefficients: x² gives u² − 4uv + 4v², y² gives 4u² − 4uv + v², xy gives 4u² − 10uv + 4v², each matching the square. Correct.

The bound is two-sided, |F| ≤ (√3/2)‖q‖‖ν‖², so it contains the upper bound the record takes from L220's step 5, with the right sign. In `block_chain` the pinning pairing 2⟨D∘ν, ν⟩ + 2τ = θ‖ν‖² is moved from D to q by `Lr_zero` (L220's step 4, ⟨r∘ν, ν⟩ = 0), so F = θN/2 − τ ≥ θN/2 uses τ ≤ 0 exactly where the record's step 2 does. `chain_real` then gets F ≤ (s/2)uN from the square bound (`le_of_sq_le`, s = √3) and divides by N > 0 to reach θ ≤ su, which is u ≥ θ/√3. Correct.

## D. Symmetry of τ

`t1`: ⟨ν₂∘ν₃, ν₁⟩ = ⟨ν₁, ν₂∘ν₃⟩ = ⟨ν₁∘ν₂, ν₃⟩ by `innerOp2_comm` and `inner_fox_move`. `t2`: ⟨ν₁∘ν₃, ν₂⟩ = ⟨ν₁, ν₃∘ν₂⟩ = ⟨ν₁, ν₂∘ν₃⟩ = τ by `inner_fox_move` and `foxProd2_comm`. `inner_fox_move` needs the three operators self-adjoint, which Weyl supplies. Both identities are the total symmetry of ⟨A∘B, C⟩ on self-adjoint operators. Correct, and each pinning `pin hE_i t_i` pairs the χ_{Q_i} equation with the matching cross term.

## E. The case split

- θ² < 1/3: the `by_cases` swap closes by `linarith` from 3θ² < 1. This is the record's "θ² ≤ 1/3 < 6/5 otherwise".
- Blocks: `b1`, `b2`, `b3` each hold under ν_i ≠ 0, with the D-equation reordered by `abel` so that the block's own square sits second.
- The eight zero patterns: those with at most one nonzero block are refuted by `htwo`. With ν₁ = 0, `sum_two` is applied at N = N₂ + N₃ with `b2` and `b3`, and `e1 : ‖ν₁‖² = 0` removes N₁ from their right sides. The cases ν₂ = 0 and ν₃ = 0 are symmetric, and the all-nonzero case uses `sum_three`.

`sum_two` is therefore applied correctly when the zero block is ν₁ or ν₂, and the record's "a block with ν_i = 0 contributes N_i = 0 and is not summed" is what `e1`, `e2`, `e3` implement. The `first | … | …` combinator only succeeds on an alternative whose `z z_i` elaborates, which pins each alternative to its own case.

The other components:

- The norm identity uses six orthogonalities through `char_orth` at a flip. The flip is at a for D against ν₁ and ν₂, at c for D against ν₃, at c for ν₁ against ν₂, and at a for ν₁ and ν₂ against ν₃. Each flip index lies in one set and outside the other. Correct.
- The cross bounds: in `cross_helper`, ν′∘ν′ = Q(ν′) = Π_{Q′}(x′,y′,z′) by `Q_nu`, with the entries summing to zero (`ring`). Correct.
- The angles: for Q₁ against Q₂ the only surviving term is the shared pair ab in both x-slots, for Q₁ against Q₃ it is cd, and for Q₂ against Q₃ it is ef (the (k,l) entry of Π(c,d,e,f), which is x′). I re-derived all three from `inner_PiQ` and the off-support zeros. Correct.
- `cross_sq`: `pattern_entry_sq_le` gives 3x² ≤ 2(x²+y²+z²) = ‖q‖² on each pattern, and the product of the two gives (xx′)² ≤ ‖q‖²‖q′‖²/9. Correct.

## F. Axioms

`lake env lean` on a scratch file in /private/tmp/r1873/ printed `[propext, Classical.choice, Quot.sound]` for all ten declarations: `L221b_bound`, `block_chain`, `chain_real`, `cross_helper`, `rayleigh_sq`, `nunu_normSq`, `angle12`, `angle13`, `angle23` and `cross_sq`. There is no `sorryAx`, and the exit code was 0. `#check @L221b_bound` printed the signature inventoried in A, with the fifteen distinctness hypotheses, the Weyl and character hypotheses, `0 < θ`, `Qop2 W = θ • W`, the unit norm, τ ≤ 0 and the two-nonzero disjunction, concluding `θ ^ 2 ≤ 6 / 5`.

## G. Does "L221 proved" overclaim?

L221b_bound takes `hQ : Qop2 W = θ • W`, the record's own definition of "unit critical point in 𝒮" in the statement's closing sentence, so "proved" is accurate against the record's statement. The local-maximiser caveat concerns a different step: going from criticality of P on the unit sphere of 𝒮 ∩ 𝒲ₙ to Q(W) = θW, which the Lean has only at a local maximiser (`L221b_step1`).

- The row for L221 at [INDEX.md line 154](../lean/INDEX.md#L154) cites `L221b_step1` next to `L221b_split`, but does not say that `L221b_bound` takes the Q(W) = θW form.
- The statement row at [INDEX.md line 153](../lean/INDEX.md#L153) says "every unit critical W … has θ² ≤ 6/5" with "critical" undefined in the row.

A reader of the rows alone could read "critical" as sphere-criticality. This is wording rather than overclaim, since the record defines the term (O1).

## H. Breakers, and how I looked

| Statement | Object that would break it | What I did |
|---|---|---|
| `rayleigh_sq` | ν with a component outside V_Q (a pair-block or another four-set part), where F is no longer the binary form in a, b | Checked that `four_eq_sig` forces ν = aσ_A + bσ_B from the Weyl and character hypotheses, and re-derived the square identity |
| `nunu_normSq` | Same as above: a non-Weyl ν of character χ_Q | Confirmed that `hνW` is required by `four_eq_sig` and present |
| angles | Two four-sets whose shared pair sits in different slots, or sharing three indices | Re-derived each angle at the stated labelling. The universally quantified letters cover every relabelling, and three shared indices are outside (b) |
| `block_chain` | τ > 0, which breaks F ≥ θN/2 (the record's open case), or ν = 0, where division by N fails | Traced `hτ` and `hν0` to their only uses, `hF1` and `hNi` |
| `L221b_bound` | One nonzero block (L220's regime, bound 3/2), or θ ≤ 0 | Confirmed that `htwo` and `hθ` are consumed, the former in the exfalso branch |
| INDEX rows | A sphere-critical, non-maximal W whose Q(W) = θW is not derived | Read `L221b_step1`'s hypotheses (`IsLocalMaxOn`), which is the O1 wording point |

I found no breaker that satisfies the hypotheses.

## Observations

- **O1.** Row 153 and row 154 of [INDEX.md](../lean/INDEX.md) should say that `L221b_bound` takes criticality as Q(W) = θW, the record's definition, and that sphere-criticality reaches this form in Lean only at a local maximiser through `L221b_step1`. The record's footnote already says so, and the rows should carry the same clause.
- **O2.** Row 153 carries "statement: typed" twice, italic at the head and bold at the tail. The tail copy is a leftover.
- **O3.** No single theorem composes `L221b_step1`, `SK_components` and `L221b_bound` into "a local maximiser on the sphere of 𝒮 ∩ 𝒲ₙ with two nonzero blocks and τ ≤ 0 has P(W)² ≤ 6/5". Every ingredient is present. This is optional, and would retire O1 at the source.
- **O4.** `L221b_bound` never uses n ≥ 6 explicitly. It follows from the six distinct letters, so the Lean statement is the record's with that hypothesis made implicit.
- **O5.** `rayleigh_sq` is two-sided, strictly more than the upper Rayleigh bound the record cites from L220's step 5. The docstring's phrase "as a bound on the quadratic form" is accurate.
- **O6.** At review time [L221bChain.lean](../lean/HamiltonsCubic/Results/L221bChain.lean), the [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) import and the INDEX rows are staged, but uncommitted. The verdicts are on the working-tree content read above.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** Claims 1 to 5 are CONFIRMED, and claim 6 is CONFIRMED WITH OBSERVATIONS for O1 and O2, which are wording only.
