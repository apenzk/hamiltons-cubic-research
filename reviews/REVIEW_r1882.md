# REVIEW r1882: L244Norm, the unit norm and tracelessness fixing a = 1/√(2p)

*Gate 2 on [L244Norm.lean](../lean/HamiltonsCubic/Results/L244Norm.lean) at commit 09fa1c90, against Lemma L244 (ii) in [second-order.md](../findings/second-order.md). Every claim is CONFIRMED. The normalisation is the record's, the trace identity uses only the Ricci clause (plus linearity for the antisymmetry of W φ), the basis-independence lemmas need completeness and skewness of both families and the symmetry of W but no orthonormality, and the arithmetic of `L244_mult` and `L244_a` is right, with p = 0 excluded by the unit norm inside the proof. Four observations, none a defect in the Lean.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `parseval2`, `trace_indep`, `sq_indep`: basis independence over complete skew families | CONFIRMED WITH OBSERVATIONS (O1) |
| 2 | `trace_zero`: Σ_k λ_k = 0 from Σ_i Ric_ii = 0 | CONFIRMED |
| 3 | `normSq_eq`: normSq W = Σ_k λ_k² in the layer's normalisation | CONFIRMED |
| 4 | `L244_mult`: ±a classes of one size p, normSq W = 2pa² | CONFIRMED |
| 5 | `L244_a`: a = 1/√(2p) at normSq W = 1, a > 0 | CONFIRMED |
| 6 | `exists_cls`: the labelling constructed from a spectrum in {−a, 0, a} | CONFIRMED WITH OBSERVATIONS (O2) |
| 7 | lean/INDEX.md L244 row, new text and owed list | CONFIRMED WITH OBSERVATIONS (O3, O4) |

**Summary.** The file proves what it claims, in the record's normalisation, with the standard three axioms, and the hypotheses are met by a nonzero linear Weyl operator (W_{CP²}).

## Conventions

- `inner2 X Y = ½ tr(XᵀY)` ([WeylReal.lean:39](../lean/HamiltonsCubic/Base/WeylReal.lean#L39)), the half-trace pairing that [conventions.md](../findings/conventions.md) fixes as the record's: ‖φ_ab‖² = 1 and {φ_ab}_{a<b} orthonormal.
- `innerOp R S = ½ Σ_{i,j} inner2 (R φ_ij) (S φ_ij)` over ordered pairs, `normSq R = innerOp R R` ([WeylReal.lean:135](../lean/HamiltonsCubic/Base/WeylReal.lean#L135), [:173](../lean/HamiltonsCubic/Base/WeylReal.lean#L173)).
- `Ric R a b = Σ_c inner2 (R (φ a c)) (φ b c)` ([WeylReal.lean:106](../lean/HamiltonsCubic/Base/WeylReal.lean#L106)).
- `IsWeylOp W = IsLinOp W ∧ IsWeyl W`, with `IsWeyl` the four clauses: skew-valued on skew input, symmetric under inner2 on skew pairs, first Bianchi, Ric = 0. In the proofs `hW.1.2` is homogeneity, `hW.2.1` skew-valued, `hW.2.2.1` symmetry, `hW.2.2.2.2` the Ricci clause.
- The record's (ii), quoted at source: "If the eigenvalues are $(-a,0,a)$, $a=1/\sqrt{2p}$, with multiplicities $(p,N-2p,p)$, **the indices $0,1,2$ label the eigenvalues $-a,0,a$ in that order, so $E_0$ is the NEGATIVE eigenspace and $E_1$ the kernel of $W$**", followed by "*The family's value $a=1/\sqrt{2p}$ is the unit norm $2pa^2=1$.*" The Setting takes $W$ "a unit critical point".

## Hypothesis inventory

| Declaration | Hypotheses | Used where |
|---|---|---|
| `parseval2` | `hexp` (expansion of every skew Y), `hB : IsSkew B` | linearity of inner2 in its second slot and `inner2_comm`, with A arbitrary |
| `trace_indep` | `IsWeylOp W`, both families skew and complete | `parseval2` twice, symmetry `hW.2.2.1` at (φ_d, ψ_k) |
| `sq_indep` | as above | also `hW.2.1` (W ψ_k skew, so Parseval applies with B = W ψ_k) |
| `trace_zero` | `IsWeylOp W` | `ψf_eigen`, `ψf_orth` (diagonal only), `trace_indep` to the coordinate family, `sum_pairs` (needs `W_phi_self`, `W_phi_swap`, i.e. homogeneity), the Ricci clause on the diagonal |
| `normSq_eq` | `IsWeylOp W` | as above with `sq_indep`, no Ricci |
| `L244_mult` | `a ≠ 0`, a labelling `cls` with `evf k = ![-a,0,a] (cls k)` | `trace_zero`, `normSq_eq`, `sum_cls` |
| `L244_a` | `0 < a`, `normSq W = 1`, `cls` as above | `L244_mult` |
| `exists_cls` | `a ≠ 0`, `hspec` | a nested `if` on `evf k` |

## 1. Normalisations

- **The layer's normSq is the record's ‖W‖².** By `sum_pairs`, ½ Σ_{i,j} inner2(Wφ_ij, Wφ_ij) = Σ_{i<j} inner2(Wφ_ij, Wφ_ij), which is Σ over an inner2-orthonormal basis of ⟨Wφ, Wφ⟩, i.e. tr_{Λ²}(W²) = Σ λ_k². That is the operator norm in the pairing conventions.md tables as the one every result uses, and in it the family's (p, N−2p, p) spectrum gives ‖W‖² = 2pa², which is the record's own sentence "$a=1/\sqrt{2p}$ is the unit norm $2pa^2=1$". Under plain Frobenius on Λ² the value would move by a factor, and the record's sentence would be false, so the record commits to this pairing.
- **Ordered pairs against i < j.** The coordinate side of `normSq_eq` is exactly `unfold normSq innerOp` followed by `hp : Σ_{i,j} = 2 Σ_{p : Pairs n}` and `ring`, so the ½ in `innerOp` cancels the ordered-pair double count. `sum_pairs`' hypotheses are discharged by W φ_ii = 0 and W φ_ji = −W φ_ij, both from homogeneity with φ_ji = −φ_ij. Correct.
- **The frame's orthonormality uses the same inner2.** `ψf_orth` ([L244Unit.lean:228](../lean/HamiltonsCubic/Results/L244Unit.lean#L228)) states `inner2 (ψf i) (ψf j) = if i = j then 1 else 0`, the layer's inner2, from `eigenFrame_exists.orthonormal`. The coordinate family `coordFam` is complete in the same inner2 (`L240SlotBasis.phi_expand_ordered`), which is consistent with ‖φ_ij‖² = 1 under inner2. So both sides of `trace_indep`/`sq_indep` are read in one pairing.

## 2. trace_zero

- By definition Ric W i i = Σ_c inner2 (W (φ i c)) (φ i c), which is `hric`'s `this : ∀ i, Σ_j inner2 (W (phi i j)) (phi i j) = Ric W i i := rfl`. So Σ_{i,j} ⟨Wφ_ij, φ_ij⟩ = Σ_i Ric_ii = 0, and `sum_pairs` halves it: Σ_{i<j} ⟨Wφ_ij, φ_ij⟩ = ½ Σ_i Ric_ii = 0. Confirmed by hand and against the code.
- **What it relies on**: the Ricci clause (diagonal entries only), homogeneity (for `sum_pairs`' diagonal and symmetry hypotheses), and symmetry of W enters through `trace_indep`, and the frame's eigen equation and diagonal orthonormality in `h1`. First Bianchi is not used. This is the expected content: tracelessness of a Weyl operator is Ric's trace.

## 3. Basis independence via polarised Parseval

- `parseval2` uses only `hexp` for the family and skewness of B, then linearity of inner2 in the second argument (through `KyFanPackaging.inner2Form`) and `inner2_comm`. **Orthonormality is used nowhere**: `hexp` alone is the Parseval-frame property, so the lemmas hold at any tight frame with constant 1 (O1).
- `trace_indep`: Parseval over φ at (A, B) = (Wψ_k, ψ_k), ψ_k skew. Then the swap uses ⟨φ_d, Wψ_k⟩ = ⟨Wφ_d, ψ_k⟩ (`hW.2.2.1` at skew φ_d, ψ_k, then `inner2_comm`) and ⟨φ_d, ψ_k⟩ = ⟨ψ_k, φ_d⟩. Then Parseval over ψ at (Wφ_d, φ_d). Both completeness hypotheses, both skewness hypotheses and the symmetry of W are used, and nothing else.
- `sq_indep`: the same, with B = Wψ_k and Wφ_d, whose skewness is `hW.2.1`. It uses skew-valuedness in addition. Correct.
- Only `h1` in `trace_zero` and `normSq_eq` uses orthonormality, and only its diagonal, to read inner2 (λψ, ψ) = λ.

## 4. L244_mult and L244_a by hand

- With p₀, p₁, p₂ the class sizes, Σ_k λ_k = −a p₀ + a p₂ = 0, so a(p₂ − p₀) = 0 and p₀ = p₂ at a ≠ 0. And Σ_k λ_k² = a²(p₀ + p₂) = 2p₀a². The Lean does exactly this through `sum_cls` and `Fin.sum_univ_three`. p₁ = N − 2p is implicit from the cardinality of the index and not stated (O4 records it as a presentation point only).
- `L244_a`: 1 = 2pa². **p = 0 is excluded by the unit norm**: it would give 1 = 0, and the proof's `hp : 0 < 2p` is exactly this (`nlinarith` from 1 = 2pa² and 2p ≤ 0). Then √(2p) = 1/a since (1/a)² = 2p and 1/a > 0, so a = 1/√(2p). Correct. The statement's p is the size of the negative class `cls γ = 0`, matching the record's E₀ as the negative eigenspace.
- The hypothesis `a > 0` in `L244_a` is the record's orientation (λ = (−a, 0, a) with E₀ negative). At a < 0 the same algebra gives a = −1/√(2p), so the sign hypothesis is necessary and correctly placed.

## 5. exists_cls

- Faithful: cls k = 0, 1, 2 according as evf k = −a, 0, else, and each case evaluates `![-a,0,a]` correctly.
- **It does not need a ≠ 0** (O2). The proof cases on `hspec`, which forces it to show the `if` tests disagree across cases, hence `a ≠ 0`. Casing on the `if` tests instead proves the statement at every a, since the else branch has evf k ≠ −a and evf k ≠ 0, so `hspec` gives evf k = a. I compiled that variant (section 6). The hypothesis is harmless, because `L244_mult` needs a ≠ 0 anyway and the record's a is positive.

## 6. Axioms and a nonvacuous instance

- `#print axioms` against the built tree (`lake env lean` on a scratch file importing [L244Norm.lean](../lean/HamiltonsCubic/Results/L244Norm.lean)): `L244_a`, `L244_mult`, `exists_cls`, `trace_zero` and `normSq_eq` each depend on `[propext, Classical.choice, Quot.sound]`, the standard three.
- **Nonvacuous instance (screen).** `trace_zero` and `normSq_eq` were instantiated at `WCPm (m := 2)` with `WCPm_isWeylOp` from [L70CPm.lean](../lean/HamiltonsCubic/Results/L70CPm.lean#L282), a nonzero linear Weyl operator on Fin 4. Both `example`s compiled without error, so the hypotheses of the two theorems are met by a real Weyl operator. The screen is a type check and supports no further claim.
- **The exists_cls variant** without `ha` (O2) compiled with exit 0: `dsimp only`, then `if_pos`/`if_neg` on the two tests, and `hspec` in the else branch only to exclude its first two disjuncts.

## 7. The lean/INDEX.md L244 row

- **The new text is accurate.** Each named declaration exists with the stated content: `parseval2`, `trace_indep`, `sq_indep` (at any two complete skew families), `trace_zero` (from Σ_i Ric_ii = 0), `normSq_eq`, `L244_mult` (a ≠ 0, the ±a classes of one size p, ‖W‖² = 2pa²), `L244_a` (a = 1/√(2p) at unit norm, which answers r1856 O1), `exists_cls` (which answers r1881 O2), standard three axioms (section 6).
- **Owed list against the record's (ii).** The record's (ii) needs: the three-value spectrum and its labelling (now `exists_cls`), a = 1/√(2p) and the multiplicities (now `L244_mult`, `L244_a`), the rows (proved earlier in the row), the caps with κ read as top eigenvalue sums of −ad_x² (the owed item), and the bound at every unit x ∈ E₀ (`L244_ceiling_unit`). Two items the list omits (O3): the p = 1 corner, excluded by `L244_ceiling_unit`'s `h0size : 2 ≤ m₀` and recorded in the row's prose as r1881 O1 but not on the owed list, and the assembly of `L244_a` with `L244_ceiling_unit` into the record's displayed form θ ≤ (min(…) − 1)/√(2p), which the row states in prose rather than as a declaration.
- **A stale clause** (O3): the row's older "Not typed" sentence still lists "`cls` being quantified rather than constructed", "for `h0` a basis of E₀ starting with the unit x" and "the per-vector rows … which enter as hypotheses", all three since discharged further along the same row (`exists_cls`, L244Unit's reflected frame, `rowA_frame`/`rowB_frame`/`rowC_frame`). A reader stopping at that sentence would count three gaps that are closed.

## Falsifier

The claims would fall to a linear Weyl operator W whose Λ² trace Σ_{i<j} ⟨Wφ_ij, φ_ij⟩ is nonzero, or whose layer normSq differs from Σ λ_k² (a normalisation mismatch between `innerOp` and the frame's inner2), or to a labelled spectrum (−a, 0, a) with unequal ±a multiplicities. I looked for each by hand: the trace is ½ Σ Ric_ii by the definitions, the ½ in `innerOp` exactly cancels the ordered-pair count, and the multiplicity equality is forced by the trace. The screens are the compiled instances of `trace_zero` and `normSq_eq` at W_{CP²} (a nonzero `IsWeylOp` witness), and the axiom check. None falsified.

## Verdict

**CONFIRMED WITH OBSERVATIONS.** All seven claims hold. The Lean is sound, in the record's normalisation, with the standard three axioms, and the p = 0 case is excluded by the unit norm.

## Observations

- **O1.** `parseval2`, `trace_indep` and `sq_indep` use completeness in the expansion form and skewness only, no orthonormality. The docstrings say "complete skew families", which is accurate. The lemmas hold at every Parseval frame.
- **O2.** `exists_cls`'s `ha : a ≠ 0` is unused in substance. A proof casing on the `if` tests closes it at every a (compiled, section 6). Harmless, since every consumer carries a ≠ 0.
- **O3.** The INDEX row's owed list omits the p = 1 corner (r1881 O1, stated in the row's prose as outside `L244_ceiling_unit`) and the one-declaration assembly of `L244_a` with `L244_ceiling_unit`. Its older "Not typed" sentence lists three gaps since closed in the same row. Suggest pruning that sentence and adding "p = 1 (`h0size`)" to the owed list.
- **O4.** `L244_mult` states p₀ = p₂ and ‖W‖² = 2p₀a², leaving the middle multiplicity N − 2p implicit in the index cardinality. The record's (p, N − 2p, p) follows in one line from `Finset.card_univ` over the three fibres. Presentation only.
