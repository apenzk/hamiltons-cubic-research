# Review r993: the pairing, `pf6`'s closed form, and L193's discharged `sorry`

Gate 2, sole reviewer by design, on [I67Relabel.lean](../lean/HamiltonsCubic/Results/I67Relabel.lean), [I67Pf6.lean](../lean/HamiltonsCubic/Results/I67Pf6.lean) and [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean). Brief: [BRIEF_I67_pairing_pf6.md](BRIEF_I67_pairing_pf6.md).

## Verdicts

| # | claim | Lean | verdict |
|---|---|---|---|
| 1 | `levi6` antisymmetric in slots 4,5 and 5,6 | `levi6_swap_de`, `levi6_swap_ef` | CONFIRMED |
| 2 | `B = -A` | `relabel_de` | CONFIRMED |
| 3 | `C = -B` | `relabel_fe` | CONFIRMED |
| 4 | `C = +A`, by an even substitution | `relabel_df` | CONFIRMED |
| 5 | pairing constant `12`, no hypothesis | `star_wedge_pairing` | CONFIRMED |
| 6 | `pf6 X` is the explicit cubic | `pf6_eq` | CONFIRMED |
| 7 | adjugate law proved, no `sorry`, skewness only | `adjugate_law` | CONFIRMED |
| 8 | `StarWedgeIdentity` from one input | `starWedge_of_pf` | CONFIRMED |
| 9 | standard axioms only | `#print axioms` | CONFIRMED |
| 10 | `Pf² = det` and `pf6 J = ±1` not claimed | none | CONFIRMED, with two stale docstrings to fix |

Nothing here is refuted. The two corrections below are documentation, and both are inside the files under review.

## Row 6: the cubic IS the Pfaffian, recomputed independently

The right-hand side of `pf6_eq` has fifteen terms. I enumerated the perfect matchings of `{0,…,5}` myself and signed each by the parity of its one-line word `(i₁ j₁ i₂ j₂ i₃ j₃)`, which is the standard Pfaffian convention, then compared the set of signed matchings against the Lean cubic as a dictionary equality rather than term by term by eye.

* There are `5!! = 15` matchings, the cubic has fifteen terms, and the two sets agree as signed sets, so every matching appears exactly once with the correct sign and no spurious monomial is present.
* Worked signs at the three that a transcription error would most likely reach: `X₀₁X₂₄X₃₅` has word `0,1,2,4,3,5`, one inversion, sign `-1`, and Lean writes `-`; `X₀₃X₁₄X₂₅` has word `0,3,1,4,2,5`, three inversions, sign `-1`, and Lean writes `-`; `X₀₅X₁₄X₂₃` has word `0,5,1,4,2,3`, six inversions, sign `+1`, and Lean writes `+`.

The convention question that the term-by-term check cannot settle is the **overall sign**, since `-Pf` is also a legitimate cubic in the fifteen entries. It is fixed by the layer's own normalisation. At `X = e₀₁ + e₂₃ + e₄₅` the definition `triple6 X X X = (1/48)∑ε X X X` has all `48` nonzero terms equal to `+1`, because flipping an index pair flips `ε` and the matrix entry together and permuting the three disjoint pairs is even, so `pf6 X = +1`, and the cubic reads `+1` too. The file's cubic is `+Pf` in the layer's own normalisation, not `-Pf`.

*Screen, asserted:* `triple6 X X X = cubic(X)` as exact rationals at `X = e₀₁+e₂₃+e₄₅` and at five random integer skew `X`, and the fifteen signed matchings equal the fifteen Lean terms as a set.

## Row 5: the constant is `12` over the FULL double sum, and that is what Lean writes

Derivation, from the quoted definitions alone:

1. `star6 T` carries `1/24` and `wedgeSelf X` carries the explicit `2`, so `∑_{a,b} star6(wedgeSelf X)_{ab} Z_{ab} = (1/12)(A - B + C)`.
2. `relabel_de` and `relabel_df` give `B = -A` and `C = A`, so the bracket is `3A` and the left side is `A/4`.
3. `triple6 Z X X = (1/48)A`, so `12 · triple6 Z X X = A/4` as well. The constant is `12`.

**The `12` belongs to `∑_{a,b}`, over ordered pairs.** Over `∑_{a<b}` with skew `Z` the same identity reads `6`, because the summand `star6(wedgeSelf X)_{ab} Z_{ab}` is symmetric under `a ↔ b` when both factors are skew, so the ordered sum is twice the unordered one. The Lean statement writes `∑ a : Fin 6, ∑ b : Fin 6`, the ordered double sum, against `12`. The pairing and its constant match.

A second, independent route to the same `12`, which is worth recording because it uses none of the relabellings: `σ₆ = ½⋆(X∧X)`, so the ordered sum is `4∑_{a<b} X_{ab} σ₆(X)_{ab}`. Each of the fifteen `σ₆(X)_{ab}` is the signed Pfaffian of the complementary four-set, and each monomial of `Pf` has three factors, so the Laplace count gives `∑_{a<b} X_{ab} σ₆(X)_{ab} = 3 Pf(X)` and `4 · 3 = 12`.

*Screen, asserted:* the identity at five random **general** `X, Z` with no skewness, both as `= 12·triple6` and as `= A/4`; the `a<b` form against `6` at random skew `X, Z`; and `∑_{a<b} X_{ab}σ₆(X)_{ab} = 3·cubic(X)`.

## Row 4: the substitution is EVEN, and the two swaps match

Rename the bound variables of `C = ∑ ε_{abcdef} Z_{ab} X_{cf} X_{de}` so that the `X` factors read `X_{cd} X_{ef}`: setting the new fourth slot to the old `f`, the new fifth to the old `d` and the new sixth to the old `e` gives `C = ∑ ε_{abcefd} Z_{ab} X_{cd} X_{ef}`. The last three slots of `ε` carry the three-cycle `(d e f)`, which is **even**, so `C = +A`. The odd alternative, the reversal `(d,e,f) ↦ (f,e,d)`, is the transposition `(d f)` and would have given `C = -A`.

The Lean proof of `relabel_df` is `rw [relabel_fe, relabel_de, neg_neg]`, that is `C = -B = -(-A) = A`. Each of the two rewrites is a single neighbour transposition of `ε`'s slots, `levi6_swap_ef` then `levi6_swap_de`, so the composite is a product of two transpositions and its parity is even. **The proof's parity matches the substitution's parity, and the sign the parent got wrong once is now right.**

Rows 2 and 3 are each one transposition and check the same way: renaming `d ↔ e` in `B` turns the pair `X_{ce}X_{df}` into `X_{cd}X_{ef}` at the cost of `ε_{abcedf} = -ε_{abcdef}`, and `relabel_fe` is the same motion on `e ↔ f`. Row 1 is those two swaps as lemmas, each a single `sgnR_swap` inside `levi6`.

*Screen, asserted:* `B = -A`, `C = -B` and `C = A` at five random **general** `X, Z`, exact rationals, no skewness assumed.

## Rows 7, 8, 9: hypotheses, `sorry`, axioms

The signatures as Lean elaborates them, from `#check` against the built artifacts:

* `star_wedge_pairing : ∀ (X Z : Matrix (Fin 6) (Fin 6) ℝ), ∑ a, ∑ b, star6 (wedgeSelf X) a b * Z a b = 12 * triple6 Z X X`. **No hypothesis of any kind**, skewness included.
* `pf6_eq : ∀ X, IsSkew X → pf6 X = <the cubic>`. `IsSkew` and nothing else.
* `adjugate_law : ∀ X, IsSkew X → X * sigma6 X = -pf6 X • 1`. `IsSkew` and nothing else, and the statement is the law with its minus sign.
* `starWedge_of_pf : (∀ J, IsComplexStructure J → pf6 J = 1 ∨ pf6 J = -1) → StarWedgeIdentity`. **One hypothesis**, where `starWedge_of_adjugate` takes two, `adjugate_law` being discharged into it.

No proof smuggles in an extra assumption: the hypotheses used inside `pf6_eq` (`hsk`, `hd`, `hxs`, the diagonal vanishing) are all derived from `hX : IsSkew X` and from `star6_isSkew`, which is a theorem about `star6` at every `T`.

`#print axioms` on all ten declarations returns exactly `[propext, Classical.choice, Quot.sound]`. **No `sorryAx` anywhere in the chain**, so L193's `sorry` is genuinely discharged rather than relocated. `lake build --no-build` reports `All targets up-to-date (8720 jobs)`, so the artifacts those axiom lines were read from are the sources reviewed here.

## Row 10: nothing is overclaimed, and two docstrings are stale

**The deliberate omission holds.** No theorem and no docstring in the three files asserts `Pf(X)² = det X`, asserts `pf6 J = ±1` at a complex structure, or asserts `StarWedgeIdentity` outright. `StarWedgeIdentity` appears only as the conclusion of two implications, and the docstring of `starWedge_of_pf` names the surviving debt correctly, *"what is still owed is `pf6 J = 1 or -1` at a complex structure, which follows from `Pf(X)^2 = det(X)` together with `det J = 1`. Neither is typed in this layer"*. That sentence is accurate.

Two corrections, both documentation, both inside files under review:

* **[I67Relabel.lean](../lean/HamiltonsCubic/Results/I67Relabel.lean)'s *What this leaves owed* is stale and contradicts the file.** It lists the pairing `⟪star6 (wedgeSelf X), Z⟫ = 12 · triple6 Z X X` as owed, and the file proves it as `star_wedge_pairing` at line 119. It also lists L193's `sorry`, now discharged. The sibling *What is proved* list omits `star_wedge_pairing` entirely, naming only the two swaps and the three relabellings. **The owed section should read: the pairing and the three relabellings are proved here, and what the chain still owes is `pf6 J = ±1` at a complex structure.** The trailing *"Gate 2 owed on this file"* is what this round discharges.
* **[L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) line 138, the docstring of `starWedge_of_adjugate`, says *"neither the adjugate law nor `Pf(J) = ±1` is proved in this layer"*.** The adjugate law is proved sixty lines above it, in the same file, which is exactly what makes `starWedge_of_pf` possible. **It should say that the first input is now the theorem `adjugate_law` and only `Pf(J) = ±1` remains unproved.**

One looser gloss, worth a line rather than a fix: [I67Pf6.lean](../lean/HamiltonsCubic/Results/I67Pf6.lean)'s header says the left side of the pairing is *"thirty-six entries of `σ₆` that are already theorems"*. The double sum has thirty-six terms, of which six are the vanishing diagonal and thirty are reduced by skewness to the **fifteen** `sigma_i_j` theorems. The header of [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) glosses the law as *"`A adj(A) = det(A)·Id` for the Pfaffian"*, which is an analogy and not a claim that `Pf² = det` is available. Both read correctly in context.

## Vacuity witnesses

* **`IsSkew` with `pf6 ≠ 0`.** `J = e₀₁ + e₂₃ + e₄₅`, which is the layer's own `stdJ6` and already carries `stdJ6_isComplexStructure`, hence `IsSkew`. `pf6 J = 1`. So `pf6_eq` and `adjugate_law` are not satisfied only where both sides collapse, and `adjugate_law` at `J` asserts `J σ₆(J) = -Id`, which is a non-trivial matrix identity.
* **`star_wedge_pairing` not trivially `0 = 0`.** At `X = Z = J` the left side is `12` and the right side is `12 · triple6 J J J = 12`. Both sides are nonzero at the same point.

*Screen, asserted:* `star_wedge_lhs(J,J) = 12`, `triple6 J J J = 1`, and the full adjugate law `X σ₆(X) = -cubic(X)·Id` entry by entry at `J` and at a random integer skew `X`.

## What this chain leaves owed

One sentence for the record: **what remains owed is `pf6 J = 1 or -1` at a complex structure, which needs `Pf(X)² = det X` together with `det J = 1`, neither of them typed in this layer**, and with that single input `StarWedgeIdentity` follows from `starWedge_of_pf` with no further debt.

## Postscript: the parent's `f886591a`, which landed mid-round

[I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean) arrived between this review's skeleton commit and its report. **It leaves [I67Relabel.lean](../lean/HamiltonsCubic/Results/I67Relabel.lean), [I67Pf6.lean](../lean/HamiltonsCubic/Results/I67Pf6.lean) and [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) untouched**, all three unchanged since `56fb4a3a`, so every verdict above stands as recorded. Three consequences for the record:

* The owed input is now a **proposition**, `pf6_complex_structure`, rather than a sentence in a docstring, which is what the *what this chain leaves owed* line above asked for. The debt itself is unchanged in size.
* `pf_sq_eq_det` and `det_complex_structure` each carry a **named `sorry`**, and `pf6_complex_structure` is proved from them, so `sorryAx` sits behind all three of that file's declarations.
* **The dependency runs from the new file into the reviewed chain and never back**, `I67PfSquared` importing `I67Pf6`, so the axiom lines above are unaffected and `adjugate_law`, `pf6_eq` and `star_wedge_pairing` remain free of `sorryAx`. **The trap to avoid is composing `starWedge_of_pf` with `pf6_complex_structure`**: the resulting term is a proof of `StarWedgeIdentity` that carries `sorryAx`, and it must not be recorded as the identity proved.

## Method note

Every number above is a screen on objects constructed for the purpose, exact over `ℚ`, each written as an assertion that fails the script rather than as a printed expectation, and each stated after the derivation it screens. The verdicts rest on the derivations, the elaborated signatures and the axiom lines.
