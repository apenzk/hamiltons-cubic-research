# Review r1718: L71Cor, the typed corollaries CONFIRMED, the owed list REFUTED AS STATED

*Cold brief, Gate 2 statement-fidelity review of [L71Cor.lean](../lean/HamiltonsCubic/Results/L71Cor.lean) (commit f0d6b914) against Lemma L71 in [findings/bounds.md](../findings/bounds.md) and the L71 row of [lean/INDEX.md](../lean/INDEX.md). Analysis only: Lean source and definitions read, no `lake build` or `lake env`. One screen, exact rational arithmetic at the balanced sphere product for p = 3, 4, 5, seconds of compute, reported as a screen. Log: [agent_logs/review-r1718.log](../agent_logs/review-r1718.log).*

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1a | The file's 𝔪, 𝔥 (`spanOf v (ev = lmin)`, `spanOf v (ev = lmax)`) are the record's E_min, E_max | CONFIRMED mathematically (by hand, below), untyped |
| 1b | "The spans are the eigenspaces" is discharged, so leaves the owed list | REFUTED AS STATED |
| 2a | `two_valued`: every frame eigenvalue is lmin or lmax | CONFIRMED |
| 2b | INDEX: "W has exactly two eigenvalues" | REFUTED AS STATED |
| 3a | `skew_mem_sup` and `inf_eq_bot` as typed | CONFIRMED |
| 3b | INDEX and docstring: "𝔰𝔬(n) = 𝔪 ⊕ 𝔥" | REFUTED AS STATED (one inclusion untyped, one-line repair) |
| 4 | `L71_corollaries` hypotheses are `L71_saturated`'s, none vacuous at even n ≥ 6 | CONFIRMED |
| 5 | `witness_two_valued` at the balanced sphere product | CONFIRMED, screen passes at p = 3, 4, 5 |
| 6a | Withdrawal of the owed odd-n witness | CONFIRMED |
| 6b | Odd-n clause owed "after the classification" | REFUTED |
| 6c | Owed list complete | REFUTED AS STATED (θ = θ_0(n) is neither typed nor listed) |
| 7 | Docstrings carry no claim the types do not | REFUTED AS STATED (the INDEX and `L71_corollaries` wording of 2b and 3b), otherwise CONFIRMED |

**One line.** The seven declarations say what their types say and are the right one-step consequences of `L71_saturated`, but the INDEX row reads more into them than they type ("exactly two", "direct sum", "spans are the eigenspaces"), and it still lists the odd-n clause as waiting on Cartan when it is now a two-line composition with `L117_no_eq_odd`.

## Conventions

- 𝔪 = `spanOf v (fun k => ev k = lmin)`, 𝔥 = `spanOf v (fun k => ev k = lmax)`, 𝔯 = `spanOf v (fun k => ev k ≠ lmin ∧ ev k ≠ lmax)`, with `v = frameVec W …` and `ev = (Mpair_isHermitian W …).eigenvalues`, indexed by `Pairs n`, |Pairs n| = N = n(n-1)/2.
- `spanOf v p = Submodule.span ℝ (v '' {k | p k})` in `Matrix (Fin n) (Fin n) ℝ`, [L71Sat.lean:30](../lean/HamiltonsCubic/Results/L71Sat.lean#L30).
- `EigenFrame` ([L41Statement.lean:97](../lean/HamiltonsCubic/Results/L41Statement.lean#L97)): `skew`, `orthonormal`, `eigen : W (v γ) = ev γ • v γ`, `complete : IsSkew X → X = Σ ⟨X, v γ⟩ v γ`. `eigenFrame_exists` supplies it for the spectral frame.
- The record: 𝔪 = E_min, 𝔥 = E_max, 𝔯 the other eigenspaces, kernel included ([findings/bounds.md](../findings/bounds.md), Lemma L71 block).

## Hypothesis inventory (`L71_corollaries`)

| Hypothesis | Record counterpart | Status |
|---|---|---|
| `hn : 5 ≤ n` | n ≥ 5 | verbatim |
| `hW : IsWeylOp W` | W ∈ 𝒲_n | verbatim |
| `hc : IsCritical W θ` | critical point | verbatim |
| (absent) | unit norm | dropped, a generalisation, since every conclusion is scale invariant |
| `hneg`, `hpos` | λ_min < 0 < λ_max | verbatim |
| `hlo`, `hex` | lmin is λ_min | lmin a lower bound and attained, so equal to λ_min |
| `hhi` | lmax is λ_max | lmax an upper bound only, attainment derivable (section 2), a generalisation |
| `hsat` | saturates L70 | verbatim scalar form |

Identical, argument for argument, to `L71_saturated` ([L71Sat.lean:154](../lean/HamiltonsCubic/Results/L71Sat.lean#L154)). None vacuous at even n ≥ 6, where `witness_two_valued` instantiates all of them at `Wb p`. At odd n they are jointly unsatisfiable, which is the odd-n clause (section 6).

## 1. Are the spans the eigenspaces?

- **Mathematically yes.** 𝔪 ⊆ E_min by `eigen` and linearity. Conversely, for skew X with W X = λ_min X, expanding by `complete` and applying `eigen` gives Σ (ev_k − λ_min)⟨X, v_k⟩ v_k = 0, so by `orthonormal` ⟨X, v_k⟩ = 0 whenever ev_k ≠ λ_min, and `complete` puts X in 𝔪. Likewise 𝔥 = E_max.
- **Not typed anywhere.** A grep of [lean/HamiltonsCubic/](../lean/HamiltonsCubic/) finds `spanOf` only in L71Sat, L71Witness and L71Cor, and no lemma relating `spanOf` to `{X | IsSkew X ∧ W X = c • X}`. L71Cor never uses `eigen` at all.
- **Gap, small but real for the row's bookkeeping.** The row before f0d6b914 owed "the spans are the eigenspaces E_min, E_max" as its own item. The commit removes it from the owed list and the new text does not claim to type it. Either type it (a ten-line lemma from `EigenFrame`'s four fields) or keep it owed. The falsifier would be a skew eigenvector of W for λ_min outside 𝔪, and the argument above shows none exists.

## 2. two_valued versus "exactly two eigenvalues"

- `two_valued` types: every `ev k` equals lmin or lmax. CONFIRMED, proof is the correct one (a frame vector in 𝔯 = ⊥ is zero, contradicting unit norm).
- **λ_min occurs**: only through the hypothesis `hex`, which is fine.
- **λ_max occurs: not typed.** Nothing in the file excludes `ev ≡ lmin`. It is true: `L117_counts` ([L117Frame.lean:187](../lean/HamiltonsCubic/Results/L117Frame.lean#L187)), whose hypotheses are exactly L71_corollaries' plus `htwo`, gives 4·#{ev = lmax} = n(n−2) > 0. Alternatively tracelessness gives Σ ev = 0 with lmin < 0.
- **All eigenvalues of W on Λ², not just the frame list**: untyped, true by the section 1 argument (an eigenvector's expansion has a nonzero coefficient at some k with ev_k equal to its eigenvalue).
- So the types carry "at most two values, λ_min attained". The INDEX's "so W has exactly two eigenvalues" is REFUTED AS STATED. Repair: add `L117_counts … (two_valued …)` as a third conjunct, or reword to "every eigenvalue is λ_min or λ_max".

## 3. The direct sum

- `skew_mem_sup` types skewSub ≤ 𝔪 ⊔ 𝔥, and `inf_eq_bot` types 𝔪 ⊓ 𝔥 = ⊥. Both CONFIRMED.
- **Missing**: 𝔪 ⊔ 𝔥 ≤ skewSub. `inf_eq_bot`'s proof derives 𝔪 ≤ `skewSub (Fin n)` internally from `hskew`, but no statement exports it, and `L71_corollaries` does not state it. Without it the typed pair reads "𝔪, 𝔥 are disjoint and their sum contains 𝔰𝔬(n)", which in the ambient `Matrix` is weaker than 𝔰𝔬(n) = 𝔪 ⊕ 𝔥.
- The record's ⊕ is also an orthogonal sum. `span_orth` has the ingredients but orthogonality of 𝔪 and 𝔥 is not exported.
- REFUTED AS STATED, minor. Repair: conclude `spanOf v (ev = lmin) ⊔ spanOf v (ev = lmax) = skewSub (Fin n)` (le_antisymm with `Submodule.span_le` and `hf.skew`), or `IsCompl` inside skewSub.

## 4. Hypotheses

Copied verbatim from `L71_saturated` (table above). The proof calls `L71_saturated` with the same arguments and uses only its first conjunct (𝔯 = ⊥), plus `eigenFrame_exists`, `lmin ≠ lmax` by linarith from `hneg`, `hpos`. Non-vacuous at every even n = 2p ≥ 6 through `witness_two_valued`. CONFIRMED.

## 5. witness_two_valued and the screen

- The instantiation: n = 2p, θ = 1, lmin = −C, lmax = A − C with A = 1/(p−1), C = 1/(2p−1). `hsat`: −C + (2p−2)(A − C) = 2 − (2p−1)C = 1. Correct.
- Hand check against geometry: for S^p × S^p with unit factors, Weyl sectional curvatures are p/(2p−1) within a factor and −(p−1)/(2p−1) across. Ratio across/within = −(p−1)/p, and Lean's −C/(A−C) = −(p−1)/p. So `Wb p` is that Weyl tensor scaled by 1/(p−1). Consistent.
- **Screen** (exact fractions, p = 3, 4, 5): values (−1/5, 3/10), (−1/7, 4/21), (−1/9, 5/36); across/within counts (9, 6), (16, 12), (25, 20), summing to N; trace 0 each time; `hsat` gives 1 each time; 4·across = n² and 4·within = n(n−2), matching `L117_counts`; ‖W‖² = p²/((2p−1)(p−1)) (9/10 at p = 3) and θ_0(n)²·‖W‖² = 1, so θ/‖W‖ = θ_0(n), the equality case of L117 after rescaling. A screen, not evidence for a positive claim.
- **Note**: `Wb p` is at norm √(9/10) at p = 3, not unit norm. Harmless because `L71_saturated` has no unit-norm hypothesis, but the witness cannot be fed to `L117_eq` without rescaling.
- The theorem types only "every eigenvalue is one of the two", not the multiplicities or that A − C occurs. That matches its docstring ("only"). CONFIRMED.

## 6. The owed list

- **Withdrawal of the odd-n witness: CONFIRMED.** The record says no critical point saturates at odd n ≥ 5, so an owed witness there was an owed false object.
- **The odd-n clause is available now, with no classification: REFUTED.** `L117_no_eq_odd` ([L117Frame.lean:238](../lean/HamiltonsCubic/Results/L117Frame.lean#L238)) takes `hn : 3 ≤ n`, `¬ Even n` and exactly L71_corollaries' remaining hypotheses (with `hex`'s witness as `γ₀`) and concludes `¬ ∀ j, ev j = lmin ∨ ev j = lmax`. `(L71_corollaries …).1` supplies that conjunction. So at odd n ≥ 5 no W satisfies the hypotheses, a two-line theorem, needing neither Cartan nor unit norm. The row's "which the record reads off dim 𝔪 = n²/4 after the classification" misplaces the dependency: the count n²/4 comes from L117_counts, not from Cartan.
- **θ = θ_0(n) exactly is neither typed nor listed**: REFUTED AS STATED (list incomplete). The record's "Consequently θ = θ_0(n) exactly" follows from `L117_eq` (backward direction) applied to `two_valued`, with the extra hypothesis `normSq W = 1`, again a composition. It should be typed or listed.
- Corrected owed list: the balanced sphere product (Cartan, `out`) and, until typed, "the spans are the eigenspaces" (section 1). The odd-n clause, λ_max attained and θ = θ_0(n) are one-line compositions and should be discharged rather than owed.

## 7. Docstrings

- Module docstring: "They hold at any orthonormal complete eigenframe whose middle span vanishes". `inf_eq_bot` also needs lmin ≠ lmax and skew frame vectors, which its own docstring and signature carry. Acceptable.
- `L71_corollaries` docstring: "the skew matrices split as 𝔪 ⊕ 𝔥", same overreach as section 3.
- `pairWith` docstring: "The pairing with `v j`" names a variable the definition does not have (the argument is `Y`). Nit.
- INDEX row: "so W has exactly two eigenvalues and 𝔰𝔬(n) = 𝔪 ⊕ 𝔥", sections 2 and 3.

## Falsifiers named and sought

| Statement | Falsifier | What was done |
|---|---|---|
| spans = eigenspaces | skew λ_min-eigenvector outside 𝔪 | excluded by the frame-expansion argument, section 1 |
| exactly two | saturating W with every ev = lmin | excluded by tracelessness and `L117_counts`, not by the file |
| direct sum | element of 𝔪 ⊔ 𝔥 not skew | excluded by `hf.skew`, not exported |
| hypotheses | a vacuous hypothesis set at even n | refuted by `witness_two_valued` at p ≥ 3 |
| witness values | wrong eigenvalue or multiplicity at p = 3 | screen, section 5 |
| odd-n owed after Cartan | a proof path without Cartan | found: `L117_no_eq_odd` ∘ `L71_corollaries` |

## Overall verdict

**The seven declarations: CONFIRMED as typed. The INDEX row: REFUTED AS STATED.** Repairs, all compositions of material in hand: export 𝔪 ⊔ 𝔥 = skewSub; add λ_max attainment via `L117_counts`; type the odd-n clause as `L117_no_eq_odd` applied to `(L71_corollaries …).1`; type θ = θ_0(n) at unit norm via `L117_eq`; either type the spans-equal-eigenspaces lemma or restore it to the owed list. The only owed item needing new mathematics is the balanced sphere product (Cartan).
