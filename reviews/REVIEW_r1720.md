# REVIEW r1720: statement fidelity of L71Theta.lean

**Standfirst.** Cold Gate 2 review of [L71Theta.lean](../lean/HamiltonsCubic/Results/L71Theta.lean) (commit 5cd82388), eight declarations, against [findings/bounds.md](../findings/bounds.md) Lemma L71 and the requests of [r1718](REVIEW_r1718.md) and [r1719](REVIEW_r1719.md) Q4. Analysis only: types and definitions read, algebra redone by hand, no `lake build`. Screens only (seconds, exact rationals at the n = 6 witness, floats at n = 6, 8, 10, 12 for the closed-form roots), reported as screens and never as evidence. Log: [agent_logs/review-r1720.log](../agent_logs/review-r1720.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | `theta0 n` is the record's θ₀(n) at the layer's unit norm, θ the multiplier of Q(W) = θW | CONFIRMED |
| 2 | `L71_theta_sq`, `L71_theta`: θ² = θ₀(n)², θ > 0, θ = θ₀(n) at every saturating unit-norm critical point, n ≥ 5 | CONFIRMED |
| 3 | `coeff_zero`, `mem_span_iff`: at any eigenframe the spans are the eigenspaces on Λ², both directions | CONFIRMED |
| 4 | `lmax_occurs` with `spectrum_two` and `hex`: W has exactly two eigenvalues on Λ² | CONFIRMED (as a composition of three statements) |
| 5 | `sup_eq_skewSub` with L71Cor's `inf_eq_bot`: 𝔰𝔬(n) = 𝔥 ⊕ 𝔪 | CONFIRMED |
| 6 | The L71 row now owes only the balanced sphere product (L169 plane step plus conjugacy, ending in Cartan) | CONFIRMED |
| 7a | Module docstring: "`sum_two`, `sum_sq_two`: the two sums" | REFUTED AS STATED (no `sum_sq_two` exists) |
| 7b | `spectrum_two` docstring: "... one of the two, and both occur" | REFUTED AS STATED (its type carries only the first half) |
| 7c | `sum_two`, a counting lemma | CONFIRMED |

**One line.** All eight declarations type what the record says and the θ = θ₀(n) derivation is correct and classification-free, but two docstrings claim more than the file declares: a phantom `sum_sq_two`, and "both occur" on a theorem whose conclusion is only `μ = lmin ∨ μ = lmax`.

## Conventions

- `normSq W = innerOp W W = ½ Σ_{i,j} inner2 (W φ_ij) (W φ_ij)`, and SpectralTrace's `sum_mu_sq` equates it with Σ over `Pairs n` of the squared `Mpair` eigenvalues: the Hilbert–Schmidt norm of W on Λ² in the orthonormal pair frame.
- `IsCritical W θ`: ⟨W²X, Y⟩ + ⟨W#X, Y⟩ = θ⟨WX, Y⟩ on skew X, Y, that is Q(W) = θW on Λ².
- `theta0Sq n = 2(n−1)(n−2)/n²`, `theta0 n = √(theta0Sq n)` ([Families.lean:490](../lean/HamiltonsCubic/Base/Families.lean#L490)). The record fixes θ₀(n) = √(2(n−1)(n−2))/n ([conventions.md](../findings/conventions.md), cited from route-a.md), which is the same number for n > 0.
- 𝔪 = `spanOf v (ev = lmin)`, 𝔥 = `spanOf v (ev = lmax)`, v the spectral frame `frameVec`, ev the `Mpair` eigenvalues.

## Hypothesis inventory (shared by `L71_theta_sq`, `L71_theta`, `lmax_occurs`, `spectrum_two`, `sup_eq_skewSub`)

| Binder | Record | Reading |
|---|---|---|
| `hn : 5 ≤ n` | n ≥ 5 | same |
| `hW : IsWeylOp W` | W ∈ 𝒲ₙ | same (linear, skew-preserving, self-adjoint, Bianchi, Ric = 0) |
| `hc : IsCritical W θ` | critical point, multiplier θ | same |
| `hneg`, `hpos`, `hlo`, `hhi`, `hex` | λ_min < 0 < λ_max, extremes of the spectrum | lmin is the attained minimum, lmax an upper bound whose attainment `lmax_occurs` now derives (a mild generalisation) |
| `hsat` | saturates L70 | the scalar equation θ = λ_min + (n−2)λ_max, as the record itself defines saturation |
| `hnorm : normSq W = 1` | "at unit norm" | same (Q1), taken by the two θ theorems only |

`mem_span_iff` and `coeff_zero` take instead `IsLinOp W`, self-adjointness on skew pairs and an `EigenFrame`, strictly weaker than the above. At odd n the shared hypotheses are inconsistent (L71Odd's `L71_odd_vacuous`), matching the record's odd-n clause. At even n = 2p ≥ 6 they are inhabited by L71Witness's `Wb p` at θ = 1. The unit-norm instance is its rescaling, which the layer does not exhibit as a declaration. The scaling step (W ↦ sW sends θ ↦ sθ, the spectrum ↦ s·spectrum, and preserves every other binder) is immediate by hand.

## 1. Is θ = theta0 n the record's θ = θ₀(n)?

- Formula: identical (Conventions).
- Normalisation: `hnorm` is in the layer's `normSq`, the quantity `sum_mu_sq` reads as Σμ², and θ is the multiplier of `IsCritical`. Both match the record's usage, since the record's θ₀ is the value at the unit-normalised balanced product.
- **Screen (exact rationals, one object).** `Wb 3` at n = 6: θ = 1, eigenvalues −1/5 (×9) and 3/10 (×6). Trace 0, saturation −1/5 + 4·3/10 = 1. normSq = 9/25 + 6·9/100 = 9/10. Rescaling by s = (9/10)^(−1/2) gives unit norm and θ' = s, so θ'² = 10/9. θ₀(6)² = 2·5·4/36 = 10/9. Agreement. A constant-factor mismatch between `normSq` and the record's norm would move θ'² off 10/9, and it does not.
- Falsifier: a convention in which the record's unit sphere differs from `normSq = 1`. Looked for through the definitions chain and the screen. None found. CONFIRMED.

## 2. The algebra of L71_theta_sq

By hand, with c_m = n²/4, c_M = n(n−2)/4 from `L71_dim_m` and two-valuedness from `L71_corollaries`:

- Trace: c_m λ_min + c_M λ_max = 0, so n²λ_min + n(n−2)λ_max = 0 (the Lean E1 is this divided by n, n ≠ 0). Hence λ_max = −nλ_min/(n−2).
- Norm: c_m λ_min² + c_M λ_max² = 1, so n²λ_min² + n(n−2)λ_max² = 4 (E2).
- Saturation: θ = λ_min + (n−2)λ_max = λ_min − nλ_min = −(n−1)λ_min (hA).
- Substituting λ_max into E2: n²λ_min²(1 + n/(n−2)) = 4, that is n²λ_min²(2n−2) = 4(n−2) (hB).
- Then θ²n² = (n−1)²λ_min²n² = (n−1)²·4(n−2)/(2(n−1)) = 2(n−1)(n−2) (hC).
- θ > 0: θ = −(n−1)λ_min with λ_min < 0 and n − 1 ≥ 4.
- `L71_theta` then takes `Real.sqrt_sq` at θ ≥ 0, which is the correct branch.
- Screen (floats, n = 6, 8, 10, 12): the closed-form roots λ_min = −√(4(n−2)/(n²(2n−2))), λ_max = −nλ_min/(n−2), θ = −(n−1)λ_min satisfy E1, E2 and hC to 10⁻¹³. A screen of the algebra, not of the theorem.
- The inputs are the four named in the brief and no more: `L71_corollaries.1`, `L71_dim_m`, `sum_mu_zero` (from Ric = 0, `hW.2.2.2.2`), `sum_mu_sq`. No classification enters. This discharges r1719 Q4 by a different route than the proposed `L117_eq` (direct counting instead of the chord sum), with the same conclusion.
- Falsifier: a saturating unit-norm critical W with θ ≠ θ₀(n), which would require a count other than n²/4, n(n−2)/4 or a third eigenvalue. Both are excluded by the cited theorems. CONFIRMED.

## 3. mem_span_iff

- Forward: span{v_k : λ_k = c} ≤ {Y : WY = cY}, the latter a submodule by `IsLinOp`. Correct, and it needs neither skewness nor self-adjointness.
- Backward: X skew, WX = cX, expand X = Σ⟨X, v_k⟩v_k by `EigenFrame.complete`. `coeff_zero` gives (λ_k − c)⟨X, v_k⟩ = 0 from self-adjointness and the eigen equation, so coefficients off the class vanish. Correct.
- The restriction to skew X is exactly right: W acts on all n×n matrices in this layer, and {X : WX = cX} over all matrices may contain non-skew matrices on which the record's E_c says nothing. The statement is E_c ∩ Λ² = span, which is the record's "𝔪 = E_min, 𝔥 = E_max".
- Degenerate c (not an eigenvalue): span = ⊥ and the backward direction forces X = 0. Consistent.
- It holds at any eigenframe, and `eigenFrame_exists` supplies the spectral one with `hW.1` and `hW.2.2.1`, so it applies to L71's 𝔪 and 𝔥. r1718 §1's open item is typed.
- Falsifier: a skew λ-eigenvector with a nonzero component on a frame vector of another eigenvalue. Excluded by `coeff_zero`. CONFIRMED.

## 4. spectrum_two and lmax_occurs: exactly two eigenvalues?

- `spectrum_two`: any μ with WX = μX, X skew and nonzero, equals lmin or lmax. Proof: otherwise every frame coefficient of X vanishes and completeness gives X = 0.
- `lmax_occurs`: some `Mpair` eigenvalue equals lmax, from 4·#{= lmax} = n(n−2) > 0.
- `hex`: some `Mpair` eigenvalue equals lmin. And lmin < 0 < lmax gives lmin ≠ lmax.
- Composition: the frame vector for an `Mpair` eigenvalue is a nonzero skew eigenvector (`frameVec_eigen`, orthonormality), so both values are eigenvalues on Λ², and `spectrum_two` says there are no others. That is "W has exactly two eigenvalues" on Λ².
- The composition is three statements plus the frame, not one declaration typing `spectrum = {lmin, lmax}`. The INDEX row's wording ("`lmax_occurs` and `spectrum_two`, W has exactly the two eigenvalues") names it as a composition, which is honest. CONFIRMED.
- Falsifier: a saturating W with every eigenvalue lmin, or a skew eigenvector at a third value. The first is excluded by `L71_dim_m`, the second by `spectrum_two`.

## 5. sup_eq_skewSub with inf_eq_bot

- `sup_eq_skewSub`: 𝔪 ⊔ 𝔥 = `skewSub (Fin n)`, both inclusions (≤ from `hf.skew`, ≥ from `L71_corollaries.2.1`).
- `inf_eq_bot` (inside `L71_corollaries.2.2`): 𝔪 ⊓ 𝔥 = ⊥ for the same two spans at the same frame.
- Together: 𝔪 and 𝔥 are complementary in Λ² = 𝔰𝔬(n), an internal direct sum. It is orthogonal as well, since `span_orth` puts them in orthogonal frame classes. That is 𝔰𝔬(n) = 𝔥 ⊕ 𝔪, and with `mem_span_iff` the summands are the eigenspaces. The symmetric-pair structure is `L71_saturated`'s, not this file's. CONFIRMED.
- Falsifier: a skew matrix outside 𝔪 + 𝔥, or a nonzero common element. Both excluded (completeness with 𝔯 = ⊥, and orthogonality).

## 6. The L71 row's residue

- The record's L71 conclusions and their Lean status: 𝔯 = 0, 𝔥 = [𝔪, 𝔪], [𝔥, 𝔥] ⊆ 𝔥 (`L71_saturated`); the inclusions (L71Incl); 𝔰𝔬(n) = 𝔥 ⊕ 𝔪 (Q5); exactly two eigenvalues (Q4); dimensions (`L71_dim_m`); θ = θ₀(n) (Q2); odd-n clause (`L71_odd_vacuous`). What remains is "W is the Weyl tensor of the balanced sphere product", which the record routes through L169 (two eigenvalues put W on the plane) and the SO(n)-conjugacy of 𝔥 to 𝔰𝔬(n/2) ⊕ 𝔰𝔬(n/2), ending in Cartan (`out`). The row lists exactly that. Right and complete. CONFIRMED.
- The n = 8 subtlety (O(8)- versus SO(8)-conjugacy, owed per the record's own blockquote) sits inside "the conjugacy" and is covered by the row's wording.
- Note, not a defect: the eigenvalues are now pinned by n alone at unit norm (λ_min = −θ₀(n)/(n−1), λ_max = nθ₀(n)/((n−1)(n−2)), from hA and E1), so once the conjugacy is in hand the plane step reduces to comparing two operators of the form λ_min P_𝔪 + λ_max P_𝔥 with equal eigenvalues. The L169 row can say so when it is next touched.
- Record gap, not a Lean defect: [bounds.md](../findings/bounds.md) Lemma L71 still reads θ = θ₀(n) as a consequence of the sphere product and carries no pointer to L71Theta.lean (grep: 0 hits). The record should say θ = θ₀(n) follows from the spectrum alone, with the machine-check pointer.

## 7. Docstring claims the types do not carry

- **7a, REFUTED AS STATED.** The module docstring lists "`sum_two`, `sum_sq_two`: the two sums over a two-valued spectrum". No declaration `sum_sq_two` exists in the file or anywhere under lean/ (grep: the docstring line is the only hit). The squared sum is `sum_two` at `g = fun x => x ^ 2`. Repair: drop `sum_sq_two` from the list, or say "`sum_two` (with `g = id` and `g = (·)²`)".
- **7b, REFUTED AS STATED, minor.** `spectrum_two`'s docstring: "every eigenvalue of `W` on a nonzero bivector is one of the two, and both occur". Its conclusion is `μ = lmin ∨ μ = lmax` only. "Both occur" is `hex` (a hypothesis) and `lmax_occurs` (a separate theorem), each as an `Mpair` eigenvalue rather than on a bivector. Repair: delete "and both occur" or point to `hex` and `lmax_occurs`, or add a conjunct.
- Inherited, already on r1719's record: the module docstring's "4 dim 𝔪 = n²" is typed as a card of an index filter, not a `finrank`. By orthonormality they agree, and the file uses only the count. Acceptable.
- `mem_span_iff`, `coeff_zero`, `lmax_occurs`, `sup_eq_skewSub`, `L71_theta_sq`, `L71_theta` and `sum_two`: docstrings match their types.

## Falsifier table

| Statement | Object that would falsify it | What I did |
|---|---|---|
| `L71_theta(_sq)` | saturating unit-norm critical W with θ ≠ θ₀(n) | hand derivation, exact screen at `Wb 3` rescaled |
| normalisation | a norm convention differing from `normSq` by a constant | definitions chain, and the screen, where a constant factor would move 10/9 |
| `mem_span_iff` | skew c-eigenvector outside the c-span | frame-expansion argument (`coeff_zero`) |
| `spectrum_two` / `lmax_occurs` | third eigenvalue on Λ², or ev ≡ lmin | read proofs, `L71_dim_m` count |
| `sup_eq_skewSub` | skew X outside 𝔪 + 𝔥 | read proof, `L71_corollaries.2.1` |
| row residue | an L71 conclusion neither proved nor listed as owed | walked the record's statement clause by clause |
| docstrings | a named claim with no carrying type | grep for `sum_sq_two`, compared each docstring with its conclusion |

## Overall verdict

**The eight declarations: CONFIRMED as typed, and they carry the record's L71 corollaries, including θ = θ₀(n) without the classification. The module docstring's `sum_sq_two` and `spectrum_two`'s "and both occur": REFUTED AS STATED, both one-line docstring repairs. The row's residue (the balanced sphere product only): CONFIRMED.** Recommended alongside: a pointer in bounds.md Lemma L71 saying θ = θ₀(n) follows from the spectrum, machine-checked in L71Theta.lean.
