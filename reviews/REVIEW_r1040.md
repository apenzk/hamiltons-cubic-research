# r1040, the `k = 4` collapse of the Hadamard products on the zero-diagonal face

**Scope.** The seven claims of the i106b `k = 4` brief, read against the declarations in [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) and against the definitions, not against anyone's account of them. Every verdict below comes from the definitions plus two matrices constructed by hand and checked exactly.

| # | claim | verdict |
|---|---|---|
| 1 | criticality at `(l,m)` is `(ν_m − ν_l)·⟨h_lm, β(ν_l+ν_m)u + c⟩ = 0`, and `⟨h_lm, 1⟩ = 0` is free | **CONFIRMED** |
| 2 | at a zero-diagonal `Q`, `h_lm` vanishes at coordinates `l` and `m`, structurally | **CONFIRMED** |
| 3 | `h_lm` lies in a `(k−2)`-dimensional coordinate subspace, and two dimensions go there | **PLAUSIBLE**, the count is right and the attribution is not: one condition is criticality, the other is orthogonality |
| 4 | at `k = 4` this forces `h_lm = 0` for every pair, under distinct complementary weights | **REFUTED as stated**, with an exact counterexample. The hypothesis is insufficient and the repair is `ν_l ≠ ν_m` |
| 5 | `Σ_{l<m} ‖h_lm‖² = (k − ‖Q‖₄⁴)/2` for unit rows | **CONFIRMED**, factor and `l < m` bookkeeping both |
| 6 | every `h_lm` vanishes iff `‖Q‖₄⁴ = k`, so the open statement is the `ℓ₄` maximisation | **CONFIRMED**, and it imports nothing from Jin: both directions are elementary here |
| 7 | the pair-sum map is injective, so the `C(k,2)` sums span a `k`-dimensional space | **CONFIRMED** for `k ≥ 3`, which is what the Lean statement's three distinct indices supply |

## The finding that outranks the seven claims: the typed open statement is FALSE

`zero_diag_critical_is_isSignedPerm` carries no hypothesis on `ν` at all. Its `hcrit` is `∀ l m, (ν_m − ν_l)·(…) = 0`, so **at a constant spectrum every factor is zero and `hcrit` holds for every `Q` whatever**. Take `ν ≡ 0` at `k = 4` and

```
Q₁ = (1/√3) · [[0,1,1,1], [1,0,1,−1], [1,−1,0,1], [1,1,−1,0]]
```

which satisfies `Q₁ Q₁ᵀ = 1` to `2.2e−16`, has exact zero diagonal, has `‖Q₁‖₄⁴ = 4/3`, and has three nonzeros in every column. It satisfies `hk`, `hQ`, `hzero` and `hcrit` exactly, and it fails `IsSignedPerm`. **The `sorry` on that declaration can never be discharged.**

This is not news to the record, only to the type. [r1035](REVIEW_r1035.md) already states it: *"At the fully degenerate spectrum `ν = const` every `Q ∈ O(k)` is critical, so criticality is then vacuous and the face is entirely critical."* The same [lean/INDEX.md](../lean/INDEX.md) row that announces the `k = 4` theorem also says *"pairs with `ν_l = ν_m` impose nothing at all, identically in `Q`"*. The statement needs `Function.Injective nu`, or at least pairwise distinctness, written into its binders.

## Claim 4, refuted as stated, and what survives

**The dimension count itself is right, which is the thing the brief asked me to check first.** For `l ≠ m` the product `h_lm` lives in the two coordinates `a, b` complementary to `l, m`, and there are exactly two linear conditions on it: `h_a + h_b = 0` from `hadamard_inner_one`, and `w_a h_a + w_b h_b = 0` from criticality, with `w = β(ν_l+ν_m)u + c`. The `2 × 2` system has determinant `w_b − w_a`, so **its kernel is trivial exactly when `w_a ≠ w_b`**, which is precisely `hadamard_collapse_of_two_conditions`'s `hne`. Nothing further is secretly needed: the lemma proves triviality of the kernel rather than assuming it.

**The gap is one step earlier, in reaching that lemma's `hcrit` at all.** Criticality delivers `(ν_m − ν_l)·⟨h_lm, w⟩ = 0`, and dividing out to get `⟨h_lm, w⟩ = 0` needs `ν_l ≠ ν_m`. Claim 4's stated hypothesis speaks only of the complementary indices `a, b`, so it does not license that division. A counterexample with **one** coincidence in `ν` and every complementary weight distinct:

```
Q₂ = [[0,0,0,1], [0,0,1,0], [1/√2, 1/√2, 0,0], [−1/√2, 1/√2, 0,0]]
ν = (0.5, 0.5, −1.2, 2.4),  β = 1.9,  u = (1.3,−0.4,2.1,0.5),  c = (−0.9,1.7,0.2,3.3)
```

`Q₂` is orthogonal to `2.2e−16`, has exact zero diagonal, and all six criticality residuals are exactly `0`: five pairs because `h_lm = 0`, and the pair `(1,2)` because `ν_1 = ν_2`. Its complementary weight gaps are all nonzero, including `w_3 − w_4 = −0.06` for the pair `(1,2)`, so **claim 4's genericity holds in full and the conclusion still fails**: `h_12 = (0, 0, 1/2, −1/2) ≠ 0` and `‖Q₂‖₄⁴ = 3 < 4`, so `Q₂` is not a signed permutation.

**With the repair the argument is sound.** Assume `ν_l ≠ ν_m` and `w^{(lm)}_a ≠ w^{(lm)}_b` for every pair. Then every `h_lm` vanishes, distinct columns have disjoint support, `k` nonempty pairwise disjoint supports in a `k`-set are singletons, and unit columns make each entry `±1`. That is a signed permutation. The genericity cost is therefore **twelve** conditions at `k = 4`, six on `ν` and six on the weights, where the claim advertises six.

**Vacuity, checked.** The hypotheses are satisfiable: derangement signed permutations are zero-diagonal, orthogonal and critical for every `(β,ν,u,c)`, as [r1035](REVIEW_r1035.md) established at every `k ≥ 2`. The statement also has real content, since `Q₁` shows that non-permutation zero-diagonal members of `O(4)` are plentiful, and the repaired claim rules them all out.

## Claims 1, 2, 3, 5, 6, 7 in detail

**Claim 1** is `asym_factor_columns` read literally, sign and all, and the free condition is `hadamard_inner_one`, which needs `l ≠ m`. One bookkeeping note: `hadamard_inner_one` takes `Qᵀ * Q = 1` while `zero_diag_critical_is_isSignedPerm` and `face_hands_down` hypothesise `Q * Qᵀ = 1`. The two agree for square matrices by `Matrix.mul_eq_one_comm`, and the bridge is currently unwritten in the file.

**Claim 2** is `hadamard_vanishes_at_own_indices`, and the column reading checks out: `h_lm(l) = Q_ll Q_lm` and `h_lm(m) = Q_ml Q_mm`. Structural, as advertised, with the zero diagonal the only input.

**Claim 3**, the count is `(k−2) − 2 = k − 4` and it is right, but *"criticality removes two more dimensions"* misattributes one of them. Orthogonality supplies `⟨h_lm, 1⟩ = 0` without any reference to `A`, and criticality supplies exactly one scalar equation per pair. The file's own prose gets this right two sections earlier, calling the first condition free. The wording matters because it hides that the criticality half is the one that evaporates at `ν_l = ν_m`.

**Claim 5** is correct, and the `1/2` is right. Per row `i`, `row_offdiag_eq_sq_sub_quartic` reads `Σ_{l≠m} Q_il² Q_im² = (Σ_l Q_il²)² − Σ_l Q_il⁴`. Summing over `i` turns the left side into `Σ_{l≠m} ‖h_lm‖² = 2 Σ_{l<m} ‖h_lm‖²` and the right side into `k − ‖Q‖₄⁴` under unit rows. **The Lean lemma is a bare vector identity with no unit hypothesis**, and the summation over rows, the use of unit rows, and the halving are all outside the layer. The claim is true and only its per-row core is machine-checked.

**Claim 6** holds in both directions and **does not import Jin**. Forward is the identity plus nonnegativity. Backward, `‖Q‖₄⁴ = k` gives every `h_lm = 0`, hence disjoint supports, hence a signed permutation by the pigeonhole above. So the file's prose citing [Jin 2026](../references/jin-2026-l4-norm-orthogonal-group/notes.md) Theorem 1(i) for *"equality exactly at the signed permutation matrices"* is citing an in-house corollary of `row_offdiag_eq_sq_sub_quartic`. Jin's substance is parts (ii) and (iii), the local-maximum classification, which this identity does not touch. The equivalence is stated at the right strength and the attribution is generous to the source.

**Claim 7**, `pairSum_determines` is a correct `linarith` from three pair sums, and the image of `ν ↦ (ν_l+ν_m)_{l<m}` has rank `k` for `k ≥ 3`. At `k = 2` the rank is `1`, so the phrase *"span only a `k`-dimensional space"* needs `k ≥ 3`, which the lemma's three distinct indices already force on the caller.

## Kernel state

`#print axioms` over all thirteen named declarations, via `lake env lean` on a scratch file at the `lean/` top level with no `lake build`. Every proved declaration depends on `[propext, Classical.choice, Quot.sound]` alone. `sorryAx` appears on exactly two, `face_hands_down` and `zero_diag_critical_is_isSignedPerm`, and on nothing that cites them. `face_hands_down_of_isSignedPerm` and `splits_of_isSignedPerm` are sorry-free, so the reduction of the item to the single open statement is real.

## How the analysis-only rule was honoured

Everything here is derivation. The two counterexamples were constructed by hand from the structure of the argument, and arithmetic confirmed them in under a second on objects already in hand. The claim-5 identity was proved by hand first and then screened on 200 random orthogonal matrices at `k ∈ {3,4,5,7}`, worst residual `2.7e−15`, reported as a screen and carrying no positive weight. **No sweep, no census, no optimisation and no falsifier hunt was opened.**
