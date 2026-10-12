# REVIEW r1719: L71Odd.lean, statement fidelity

*Cold brief, Gate 2, analysis only. Read Lean source and definitions, no `lake build` and no `lake env`. One screen: exact rational arithmetic on the balanced n = 6 witness, reported as a screen. Log: [agent_logs/review-r1719.log](../agent_logs/review-r1719.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | `L71_odd_vacuous` is the record's "no critical point saturates at odd n ≥ 5" | **CONFIRMED** |
| 2 | `L71_dim_m`: 4·#{λ = λ_min} = n² and 4·#{λ = λ_max} = n(n−2), the record's dim 𝔪 = n²/4 and dim 𝔥 = n(n−2)/4 | **CONFIRMED** |
| 3 | `L117_no_eq_odd` forbids two-valuedness at odd n, with binders matching L71's | **CONFIRMED** |
| 4 | The L71 row owes only "the balanced sphere product, which needs Cartan's classification (out)" | **REFUTED AS STATED** |
| 5 | Docstrings | **PLAUSIBLE** (two nits) |

**One line.** Both declarations say what the record says, with hypotheses no stronger than the record's, but the row's residue is wrong in both directions: θ = θ₀(n) is a two-line composition with the already proved `L117_eq` (unit norm added) and owes nothing to Cartan, while the sphere-product identification also owes L169's plane step, which the row leaves out.

## Conventions

- `IsCritical W θ` ([L40Statement.lean:77](../lean/HamiltonsCubic/Results/L40Statement.lean#L77)) is Q(W) = θW on bivectors. That is [conventions.md](../findings/conventions.md) line 151's "critical point". θ here is the Lagrange multiplier, equal to the record's θ = P/‖W‖³ at unit norm.
- `IsWeylOp` ([FoxProduct.lean:110](../lean/HamiltonsCubic/Base/FoxProduct.lean#L110)) is linearity plus [WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)'s skew-preserving, self-adjoint, Bianchi and Ricci-flat clauses. That is 𝒲ₙ.
- Eigenvalues are `(Mpair_isHermitian W …).eigenvalues`, indexed by `Pairs n` with multiplicity, card C(n,2). 𝔪 = E_min is the lmin class, 𝔥 = E_max the lmax class ([conventions.md](../findings/conventions.md) line 38).
- The saturation form θ = lmin + (n−2)·lmax is homogeneous of degree one in W on both sides under the multiplier convention, so it holds at every scale. The record's warning that L70's identity "needs ‖W‖ = 1" concerns θ = P/‖W‖³, which is scale-invariant. At unit norm the two readings coincide.

## Hypothesis inventory

| Binder | `L71_odd_vacuous` / `L71_dim_m` | `L71_saturated` ([L71Sat.lean:154](../lean/HamiltonsCubic/Results/L71Sat.lean#L154)) | `L117_no_eq_odd` / `L117_counts` ([L117Frame.lean:187](../lean/HamiltonsCubic/Results/L117Frame.lean#L187)) | Record (L71) |
|---|---|---|---|---|
| dimension | `hn : 5 ≤ n` (+ `hodd : ¬ Even n`) | `5 ≤ n` | `3 ≤ n` (+ `hodd`), fed by `omega` | n ≥ 5 (odd) |
| operator | `hW : IsWeylOp W` | same | same | W ∈ 𝒲ₙ |
| criticality | `hc : IsCritical W θ` | same | same | critical point |
| norm | absent | absent | absent | unit norm |
| sign | `hneg : lmin < 0`, `hpos : 0 < lmax` | same | same | λ_min < 0 < λ_max |
| bracketing | `hlo`, `hhi` | same | same | lmin, lmax are the extreme eigenvalues |
| attainment | `hex : ∃ γ, ev γ = lmin` | same | `γ₀`, `hγ` (hex with the witness named) | λ_min is an eigenvalue |
| saturation | `hsat : θ = lmin + (n−2)·lmax` | same | same | D(v) = 0, equivalently θ = λ_min + (n−2)λ_max |

Binder for binder, `L71_odd_vacuous` takes exactly `L71_saturated`'s list with `hodd` added. The destructured `⟨γ, hγ⟩` passes into L117's `γ₀`, `hγ` unchanged.

## 1. L71_odd_vacuous against the record

**CONFIRMED.**

- **The saturation form matches "saturating L70".** L70's boxed identity is θ = λ_min + (n−2)λ_max − D(v)/|λ_min|, with D ≥ 0 ([bounds.md:214](../findings/bounds.md#lemma-l70-the-deficiency-identity-and-what-saturates-it)). Saturation is D(v) = 0, which by the identity is `hsat` with lmin the attained minimum (`hlo` + `hex`) and lmax an upper bound (`hhi`).
- **No Lean hypothesis is stronger than the record's**, so the vacuity is at least as strong as the record's clause:
  - unit norm is dropped, a weakening that costs nothing since every hypothesis is scale-covariant;
  - `lmax` is only required to bound the spectrum, not to be attained, which is again a weakening (the conclusion then forces it attained, see Section 2);
  - `IsCritical` is Q(W) = θW, the record's own definition of a critical point, with no projection onto 𝒲ₙ added or dropped.
- **Every record saturating point at odd n ≥ 5 is a Lean instance.** Take its unit-norm representative, θ = P(W) as the multiplier, lmin = λ_min, lmax = λ_max. Then `L71_odd_vacuous` returns `False`, which is "no critical point saturates at odd n ≥ 5".
- **Falsifier and search.** The falsifier would be a Weyl operator at odd n ≥ 5 meeting all of `L71_saturated`'s binders. Such an object would also falsify the kernel-checked `L117_no_eq_odd` composed with `L71_corollaries`. I read the proof chain (Section 3) for an unsound step and found none. [r1717](REVIEW_r1717.md) §7 records no odd saturating object anywhere on the record.

## 2. L71_dim_m: which count is which

**CONFIRMED.**

- `L117_counts` concludes `4·#lmax = n(n−2) ∧ 4·#lmin = n²` (lmax first). `L71_dim_m` states `4·#lmin = n² ∧ 4·#lmax = n(n−2)`, and the proof's `⟨h.2, h.1⟩` swaps it into that order. So the first conjunct is 𝔪 = E_min and the second is 𝔥 = E_max, as the docstring says.
- 4·dim 𝔪 = n² is the record's dim 𝔪 = n²/4 over ℕ, and 4·dim 𝔥 = n(n−2) is the record's dim 𝔥 = n(n−2)/4 ([bounds.md](../findings/bounds.md), "Where dim 𝔥 = n(n−2)/4 comes from"). `n - 2` is truncated subtraction, which is harmless at n ≥ 5.
- **Screen (exact rationals, n = 6, p = 3).** At the balanced witness C = 1/5 and A − C = 3/10. Nine across pairs sit at −1/5 and six within pairs at 3/10. The trace is 9(−1/5) + 6(3/10) = 0 and the saturation value is −1/5 + 4(3/10) = 1 = θ. Also 4·9 = 36 = 6² and 4·6 = 24 = 6·4. Norm² = 9/10, and 1/√(9/10) = 1.05409 = √40/6 = θ₀(6), so the witness sits at θ₀ after normalising. This is a screen at one object, not evidence for the general claim.
- **A consequence the row can use.** n(n−2) > 0 at n ≥ 5, so the lmax class is nonempty. `L71_dim_m` therefore upgrades `L71_corollaries`' "every eigenvalue is lmin or lmax" (at most two) to the record's "exactly two eigenvalues", and it also shows the non-attained `lmax` of Section 1 is attained.
- **Falsifier and search.** A saturating point at n ≥ 5 with 4·#lmin ≠ n². At n = 4, W_{ℂP²} saturates with 𝔯 ≠ 0 and the formula fails there, as the record notes. `hn : 5 ≤ n` excludes that case, and `L71_corollaries` needs it.

## 3. L117_no_eq_odd and the binder match

**CONFIRMED.**

- Chain: `L117_mass` gives (λ_min + λ_max)(n−2) = −2λ_min from `support_of_saturation` and rows (A), (B). Under two-valuedness, B = Aᶜ and |A| + |B| = C(n,2) (`card_tri`). Tracelessness (`sum_mu_zero`) gives |A|λ_max + |B|λ_min = 0. Combining these gives |A|·n = |B|(n−2), and with the total count, 4|B| = n² and 4|A| = n(n−2).
- `L117_no_eq_odd` takes `.2`, 4|B| = n², so n² is even and `Nat.even_pow'` makes n even, contradicting `hodd`. The step is sound and uses no hypothesis beyond those listed.
- **Binder mismatch: none.** L117 needs `3 ≤ n`, discharged from `5 ≤ n` by `omega`. `γ₀ : Pairs n` and `hγ` are `hex` destructured. `hW` is passed whole, and both files project `hW.1 hW.2.1 hW.2.2.1` in the same way, so the `Mpair_isHermitian` terms are syntactically identical and `htwo` from `L71_corollaries` typechecks against L117's `htwo` binder (the file compiles, per the brief).
- **Falsifier.** An odd-n two-valued saturating spectrum. It is excluded by integrality of |B|, which the proof reads directly.

## 4. The row's residue

**REFUTED AS STATED.** The residue is incomplete in two ways.

- **θ = θ₀(n) is available now, without the classification.** `L117_eq` ([L117Frame.lean:122](../lean/HamiltonsCubic/Results/L117Frame.lean#L122)) proves, at a saturating critical point with `normSq W = 1`, that θ = √(2(n−1)(n−2))/n holds iff every eigenvalue is lmin or lmax. `L71_corollaries.1` supplies the right side. So `(L117_eq … hunit …).mpr (L71_corollaries …).1` gives θ = θ₀(n) under L71's binders plus `hunit`.
  - The route is the chord sum: with two values, Σ(λ−λ_min)(λ_max−λ) = 0, so 1 = −λ_min·λ_max·C(n,2), and with (n−2)λ_max = n|λ_min| and θ = (n−1)|λ_min| this gives θ² = θ₀². That is normalisation plus the saturation identity, which is the question the brief asked.
  - Grep: `L117_eq` has no user outside [L117Frame.lean](../lean/HamiltonsCubic/Results/L117Frame.lean), so the composition is not in the layer. It is a bounded Lean step for the loop, one declaration of a few lines, and the row should list θ = θ₀(n) as provable now rather than leaving it under Cartan.
  - `hunit` is genuinely needed. At the unnormalised witness θ = 1 ≠ θ₀(6), per the screen in Section 2.
- **"W is the Weyl tensor of the balanced sphere product" owes two things.** The record's aside says L71 gives SO(n)-conjugacy of 𝔥 to 𝔰𝔬(n/2) ⊕ 𝔰𝔬(n/2) (Cartan) and hands the identification to [L169](../findings/bounds.md#lemma-l169-the-grading-and-tracelessness-determine-the-saturating-operator). The [L169 row](../lean/INDEX.md) lists as owed "that two eigenvalues put W on the plane, and the SO(n)-conjugacy". The L71 row should name both: the conjugacy (Cartan, `out`) and L169's plane step, which is not Cartan and may be in reach.
- **Everything else in L71's statement is now typed**: 𝔯 = 0, 𝔥 = [𝔪, 𝔪], [𝔥, 𝔥] ⊆ 𝔥 (`L71_saturated`); two eigenvalues and 𝔰𝔬(n) = 𝔪 ⊕ 𝔥 (`L71_corollaries`, with "exactly" from `L71_dim_m`); and the odd clause (`L71_odd_vacuous`).

## 5. Docstrings

**PLAUSIBLE**, two nits.

- **Module docstring: "The record reads the clause off the classification."** The record reads it off dim 𝔪 = n²/4, and its own paragraph "Where dim 𝔥 = n(n−2)/4 comes from" derives that from relations (A), (B) and tracelessness after 𝔯 = 0. That is the same route the Lean file takes, not Cartan. The sentence should say the record derives it from the counting and the Lean file types that derivation.
- **"dim 𝔪", "dim 𝔥" in `L71_dim_m`'s docstring.** The types carry the cardinalities of eigenvalue index classes, not `finrank` of `spanOf`. The module docstring discloses "counted as frame multiplicities", and equality with the span dimension follows from orthonormality, but it is untyped. Acceptable as disclosed.
- The row text "the hypotheses of `L71_saturated` are inconsistent at odd n ≥ 5" matches the type exactly (Section 1 inventory).

## Overall verdict

**CONFIRMED** for [L71Odd.lean](../lean/HamiltonsCubic/Results/L71Odd.lean). `L71_odd_vacuous` is the record's odd-n clause under hypotheses no stronger than the record's, and `L71_dim_m` is dim 𝔪 = n²/4 and dim 𝔥 = n(n−2)/4 with the conjuncts correctly assigned. **REFUTED AS STATED** for the L71 row's residue:

- θ = θ₀(n) follows now from `L117_eq` plus `L71_corollaries` under unit norm, a bounded Lean step for the loop;
- the sphere-product identification owes L169's plane step besides Cartan's conjugacy.

Two docstring nits.
