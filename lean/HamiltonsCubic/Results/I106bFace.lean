import Mathlib

set_option linter.style.longLine false

/-!
# I106b, the face `{tr = 0}` of the orthostochastic image

## The theorem this file names

[L230](../../../findings/second-order.md) left [R28](../../../routes.md)'s rung owing one thing at general `|J|`.
The rung excludes an interior tangency, concludes the maximum sits on the boundary, and wants that boundary to be
the SPLIT locus, which is the previous rung. Gate 2 (r974, r975) showed the obstruction is not a second singular
stratum but a whole FACE of the image: `tr` is nonnegative on `φ_r(O(k))`, vanishes exactly on the images of
zero-diagonal `Q`, and is nonconstant, so that set lies in the boundary relative to the affine hull, and it holds
non-split points at `k = 4` and `k = 6`.

**So the rung's remaining obligation is exactly this**: *if the value's maximum over the image is attained at a
zero-diagonal `Q`, it is also attained at a splitting one.* That is what lets the induction hand down to the
previous rung, and it is stated below as `face_hands_down` with its proof outstanding.

*Naming it this way rather than as "the face does not carry the maximum" is deliberate: R28 does not need the face
to be avoided, only that landing on it costs nothing, and the weaker statement is the one the induction consumes.*

## The value is linear in the orthostochastic matrix, which is why a face is the right object

R28's frame dependence is `∑ₖ (β νₖ² pₖᵀ Û pₖ + νₖ pₖᵀ C pₖ)` over an orthonormal frame. With `Û` and `C` diagonal
in the field frame and `R = P∘2` the orthostochastic matrix of the frame `P`, `pₖᵀ Û pₖ = (Rᵀ u)ₖ`, so the whole
value is `⟪R, A⟫` with `A i k = β νₖ² uᵢ + νₖ cᵢ`. **It is a LINEAR functional on a compact set**, which is what
makes "the maximum is on the boundary" meaningful and what makes a face, rather than a stratum, the obstruction.

## What is stated here, and what is deliberately not

`Splits` generalises `SplitsAt` from [I106bSingularLocus.lean](I106bSingularLocus.lean) to every size, with the
source's two-sided definition: rows and columns are permuted INDEPENDENTLY, so a proper nonempty row set `R` and
an equinumerous column set `C` with the matrix vanishing on `R × Cᶜ` and on `Rᶜ × C`.

**`face_hands_down` is PROVED, from Birkhoff-von Neumann rather than from the face.** It was stated before any
derivation, so that a proof reaching something weaker would be visible as a mismatch rather than absorbed into a
rewritten claim, and the proof that landed is stronger than the route it was written for: `value A ·` is linear and
`Q ∘ Q` is doubly stochastic, so the maximum sits at a permutation matrix and `hzero` is never used.
*It closes the COMMUTING case. R28's rung is the coupled pair and is untouched, per
[post F72](../../../findings/fence-posts.md).*
-/

namespace HamiltonsCubic.I106bFace

open Matrix

/-- **Splitting at any size**, the source's own two-sided definition. Rows and columns are permuted
INDEPENDENTLY, so the row set and the column set are separate and only their sizes agree.

*The single-index reading would be strictly stronger and is not what Au-Yeung and Poon's Theorem 2.2 uses.* -/
def Splits {k : ℕ} (Q : Matrix (Fin k) (Fin k) ℝ) : Prop :=
  ∃ R C : Finset (Fin k), R.Nonempty ∧ R ≠ Finset.univ ∧ R.card = C.card ∧
    (∀ i ∈ R, ∀ j, j ∉ C → Q i j = 0) ∧ (∀ i, i ∉ R → ∀ j ∈ C, Q i j = 0)

/-- The value R28 maximises, `⟪R, A⟫`, linear in the orthostochastic matrix `R`. -/
noncomputable def value {k : ℕ} (A R : Matrix (Fin k) (Fin k) ℝ) : ℝ := (Aᵀ * R).trace

/-- `tr` on the image is `∑ᵢ Qᵢᵢ²`, so it is nonnegative and vanishes exactly on zero-diagonal `Q`.
This is the functional that cuts out the face, and it needs no hypothesis on `Q` at all. -/
theorem trace_image_eq {k : ℕ} (Q : Matrix (Fin k) (Fin k) ℝ) :
    (Q ⊙ Q).trace = ∑ i, Q i i ^ 2 := by
  simp [Matrix.trace, Matrix.hadamard_apply, sq]

/-- `tr` is nonnegative on the image, half of what makes `{tr = 0}` a face. -/
theorem trace_image_nonneg {k : ℕ} (Q : Matrix (Fin k) (Fin k) ℝ) :
    0 ≤ (Q ⊙ Q).trace := by
  rw [trace_image_eq]
  exact Finset.sum_nonneg fun i _ => sq_nonneg _

/-- `tr` vanishes on the image exactly at the zero-diagonal matrices, the other half. -/
theorem trace_image_eq_zero_iff {k : ℕ} (Q : Matrix (Fin k) (Fin k) ℝ) :
    (Q ⊙ Q).trace = 0 ↔ ∀ i, Q i i = 0 := by
  rw [trace_image_eq]
  constructor
  · intro h i
    have := (Finset.sum_eq_zero_iff_of_nonneg
      (fun j _ => sq_nonneg (Q j j))).mp h i (Finset.mem_univ i)
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
  · intro h
    exact Finset.sum_eq_zero fun i _ => by rw [h i]; ring

/-- **The pairing identity behind the first-order condition.**

The derivative of `f(Q) = ⟪A, Q ⊙ Q⟫` along the tangent `Q * W` is `2 ⟪Qᵀ (A ⊙ Q), W⟫`, and this is the
algebraic half of that: moving the Hadamard factor across the pairing and then the `Q` across the trace.
*Since `W` ranges over all skew matrices, criticality is exactly symmetry of `Qᵀ (A ⊙ Q)`.*

**Screened at `1e-10` against a central difference before being typed**
([screen_I106b_face.py](../../../scripts/misc/screen_I106b_face.py)). The factor `2` and the restriction
of `W` to skew matrices are NOT part of this statement, which is an identity for every `W`. -/
theorem grad_pairing {k : ℕ} (A Q W : Matrix (Fin k) (Fin k) ℝ) :
    ∑ i, ∑ j, A j i * (Q ⊙ (Q * W)) j i = ∑ i, ∑ j, (Qᵀ * (A ⊙ Q)) j i * W j i := by
  simp only [Matrix.hadamard_apply, Matrix.mul_apply, Matrix.transpose_apply,
    Finset.mul_sum, Finset.sum_mul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun m _ => Finset.sum_congr rfl fun j _ => by ring

/-- **A unit entry forces the rest of its row to vanish**, when the row of entrywise squares sums to `1`.

*This is half of the fact both Gate 2 readers confirmed: a real matrix whose entrywise square is a
permutation matrix is a signed permutation matrix. Orthogonality is NOT used, which is what makes the
statement stronger than the geometry it serves.* -/
theorem others_zero_of_unit_entry {n : ℕ} (Q : Matrix (Fin n) (Fin n) ℝ) (i j₀ : Fin n)
    (hrow : ∑ j, (Q i j) ^ 2 = 1) (h0 : (Q i j₀) ^ 2 = 1) :
    ∀ j, j ≠ j₀ → Q i j = 0 := by
  have hsplit : (Q i j₀) ^ 2 + ∑ j ∈ Finset.univ.erase j₀, (Q i j) ^ 2 = 1 := by
    rw [← hrow]
    exact Finset.add_sum_erase (Finset.univ : Finset (Fin n))
      (fun j => (Q i j) ^ 2) (Finset.mem_univ j₀)
  have hzero : ∑ j ∈ Finset.univ.erase j₀, (Q i j) ^ 2 = 0 := by
    rw [h0] at hsplit; linarith
  intro j hj
  have hmem : j ∈ Finset.univ.erase j₀ := Finset.mem_erase.mpr ⟨hj, Finset.mem_univ j⟩
  have := (Finset.sum_eq_zero_iff_of_nonneg
    (fun l _ => sq_nonneg (Q i l))).mp hzero j hmem
  exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this

/-- **The other half: a squared entry equal to `1` is `±1`.**

*Together with `others_zero_of_unit_entry` this says each row of such a `Q` has a single nonzero entry
of modulus one, which is exactly what a signed permutation matrix is, without needing that definition
in the layer.* -/
theorem eq_one_or_neg_one_of_sq {x : ℝ} (h : x ^ 2 = 1) : x = 1 ∨ x = -1 := by
  have : (x - 1) * (x + 1) = 0 := by nlinarith
  rcases mul_eq_zero.mp this with h1 | h2
  · exact Or.inl (by linarith)
  · exact Or.inr (by linarith)

/-- **A diagonal commutator reads off entrywise**: `[diag a, U]ᵢⱼ = (aᵢ - aⱼ) Uᵢⱼ`.

*This is the whole algebraic content of the first-order condition on `O(k)`, and it needs no smooth
structure: the differential enters only in choosing which matrix to set to zero.* -/
theorem diagonal_commutator_apply {n : ℕ} (a : Fin n → ℝ) (U : Matrix (Fin n) (Fin n) ℝ) (i j : Fin n) :
    (Matrix.diagonal a * U - U * Matrix.diagonal a) i j = (a i - a j) * U i j := by
  rw [Matrix.sub_apply, Matrix.diagonal_mul, Matrix.mul_diagonal]
  ring

/-- **The first-order condition, entrywise.** Criticality of the frame problem on `O(k)` is
`M = 0` for `M = [diag a, Ũ] + [diag b, C̃]`, and this types the entries of `M`. -/
theorem first_order_apply {n : ℕ} (a b : Fin n → ℝ) (U C : Matrix (Fin n) (Fin n) ℝ) (i j : Fin n) :
    ((Matrix.diagonal a * U - U * Matrix.diagonal a)
        + (Matrix.diagonal b * C - C * Matrix.diagonal b)) i j
      = (a i - a j) * U i j + (b i - b j) * C i j := by
  rw [Matrix.add_apply, diagonal_commutator_apply, diagonal_commutator_apply]

/-- **`M` is ALREADY antisymmetric when `Ũ` and `C̃` are symmetric.**

*This is what makes criticality EQUIVALENT to `M = 0` rather than merely implied by it: pairing
against skew `Ω` loses nothing, so no symmetrisation is dropped and no factor is owed.* -/
theorem first_order_antisymm {n : ℕ} (a b : Fin n → ℝ) (U C : Matrix (Fin n) (Fin n) ℝ)
    (hU : ∀ p q, U p q = U q p) (hC : ∀ p q, C p q = C q p) (i j : Fin n) :
    ((Matrix.diagonal a * U - U * Matrix.diagonal a)
        + (Matrix.diagonal b * C - C * Matrix.diagonal b)) j i
      = -(((Matrix.diagonal a * U - U * Matrix.diagonal a)
        + (Matrix.diagonal b * C - C * Matrix.diagonal b)) i j) := by
  rw [first_order_apply, first_order_apply, hU j i, hC j i]
  ring

/-- **The factorisation of the coefficient**, `aᵢ - aⱼ = β(νᵢ - νⱼ)(νᵢ + νⱼ)` at `a = β ν∘2`.

*It is what splits the condition's two degeneracies: the outer factor gives `νᵢ = νⱼ` and the inner
sum gives `νᵢ + νⱼ = 0`, where the relation constrains `C̃ᵢⱼ` alone and leaves `Ũᵢⱼ` free.* -/
theorem coeff_factor (beta nui nuj : ℝ) :
    beta * nui ^ 2 - beta * nuj ^ 2 = beta * (nui - nuj) * (nui + nuj) := by
  ring

/-! **`face_hands_down` is proved below**, after `splits_of_isSignedPerm`, which its proof needs.
*It is the item's headline statement and it follows from Birkhoff-von Neumann, not from the face.* -/

/-! ## The first-order route, and the exact statement it still owes

**[r1034](../../../reviews/REVIEW_r1034.md) REFUTED the claim that the second-order condition must do the
whole separation.** *A first-order route survives:* **every zero-diagonal critical point of the value is a
signed permutation matrix.** That gives `face_hands_down` with `P = Q` outright, because a signed permutation
`Splits`, which is what the two declarations below establish. **So the item's open content is now ONE
statement rather than a condition to be invented**, and the reduction to it is machine-checked. -/

/-- A signed permutation: one nonzero entry per row, at `σ i`, of modulus one. -/
def IsSignedPerm {k : ℕ} (Q : Matrix (Fin k) (Fin k) ℝ) : Prop :=
  ∃ (σ : Equiv.Perm (Fin k)) (ε : Fin k → ℝ),
    (∀ i, ε i = 1 ∨ ε i = -1) ∧ ∀ i j, Q i j = if j = σ i then ε i else 0

/-- **A signed permutation splits**, taking `R = {i₀}` against `C = {σ i₀}`. *`2 ≤ k` is what makes `R`
proper, and it is the same hypothesis `face_hands_down` carries.* -/
theorem splits_of_isSignedPerm {k : ℕ} (hk : 2 ≤ k) {Q : Matrix (Fin k) (Fin k) ℝ}
    (hQ : IsSignedPerm Q) : Splits Q := by
  obtain ⟨σ, ε, _, hval⟩ := hQ
  have hk0 : 0 < k := lt_of_lt_of_le (by norm_num) hk
  refine ⟨{⟨0, hk0⟩}, {σ ⟨0, hk0⟩}, ⟨⟨0, hk0⟩, Finset.mem_singleton_self _⟩, ?_, by simp, ?_, ?_⟩
  · intro h
    have h1 : (⟨1, lt_of_lt_of_le (by norm_num) hk⟩ : Fin k) ∈ ({⟨0, hk0⟩} : Finset (Fin k)) := by
      rw [h]; exact Finset.mem_univ _
    simp only [Finset.mem_singleton, Fin.ext_iff] at h1
    exact absurd h1 (by norm_num)
  · intro i hi j hj
    rw [Finset.mem_singleton] at hi
    subst hi
    rw [hval]
    exact if_neg (by simpa [Finset.mem_singleton] using hj)
  · intro i hi j hj
    rw [Finset.mem_singleton] at hj
    subst hj
    rw [hval]
    refine if_neg fun hcontra => hi ?_
    rw [Finset.mem_singleton]
    exact (σ.injective hcontra).symm

/-- **DISJOINT ROW SUPPORTS MAKE A SIGNED PERMUTATION, AT EVERY `k`.** *If no row of an orthogonal
`Q` carries two nonzero entries, then each row carries exactly one, of modulus one, and the map
sending a row to its column is a bijection.*

**This is Jin Theorem 1(i)'s equality case, reached here rather than imported**: combined with
`row_offdiag_eq_sq_sub_quartic` it says `‖Q‖₄⁴ = k` forces a signed permutation, which is the half
of the source this item was quoting. *The hypothesis is exactly that every Hadamard product of two
distinct columns vanishes, read one coordinate at a time.* -/
theorem isSignedPerm_of_rows_disjoint {k : ℕ} {Q : Matrix (Fin k) (Fin k) ℝ}
    (hQ : Q * Qᵀ = 1) (hdis : ∀ i l m : Fin k, l ≠ m → Q i l * Q i m = 0) :
    IsSignedPerm Q := by
  have hQ' : Qᵀ * Q = 1 := mul_eq_one_comm.mp hQ
  have hrow : ∀ i, ∑ j, Q i j ^ 2 = 1 := by
    intro i
    have h := congrFun (congrFun hQ i) i
    rw [Matrix.one_apply_eq] at h
    rw [← h]
    simp [Matrix.mul_apply, Matrix.transpose_apply, sq]
  have hcol : ∀ j, ∑ i, Q i j ^ 2 = 1 := by
    intro j
    have h := congrFun (congrFun hQ' j) j
    rw [Matrix.one_apply_eq] at h
    rw [← h]
    simp [Matrix.mul_apply, Matrix.transpose_apply, sq]
  have hex : ∀ i, ∃ j, Q i j ≠ 0 := by
    intro i
    by_contra h
    push_neg at h
    have hz : ∑ j, Q i j ^ 2 = 0 := by simp [h]
    rw [hrow i] at hz
    norm_num at hz
  choose f hf using hex
  have hzeroOff : ∀ i j, j ≠ f i → Q i j = 0 := by
    intro i j hne
    rcases mul_eq_zero.mp (hdis i j (f i) hne) with h | h
    · exact h
    · exact absurd h (hf i)
  have hsq : ∀ i, Q i (f i) ^ 2 = 1 := by
    intro i
    have he : ∑ j, Q i j ^ 2 = Q i (f i) ^ 2 :=
      Finset.sum_eq_single (f i) (fun b _ hb => by rw [hzeroOff i b hb]; ring)
        (fun h => absurd (Finset.mem_univ _) h)
    rw [← he, hrow i]
  have hinj : Function.Injective f := by
    intro i i' hii
    by_contra hne
    have hle : ∑ a ∈ ({i, i'} : Finset (Fin k)), Q a (f i) ^ 2 ≤ ∑ a, Q a (f i) ^ 2 :=
      Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _) fun a _ _ => sq_nonneg _
    rw [Finset.sum_pair hne, hcol (f i), hsq i, hii, hsq i'] at hle
    norm_num at hle
  have hpm : ∀ i, Q i (f i) = 1 ∨ Q i (f i) = -1 := by
    intro i
    have h : (Q i (f i) - 1) * (Q i (f i) + 1) = 0 := by nlinarith [hsq i]
    rcases mul_eq_zero.mp h with h | h
    · exact Or.inl (by linarith)
    · exact Or.inr (by linarith)
  refine ⟨Equiv.ofBijective f ((Fintype.bijective_iff_injective_and_card f).mpr ⟨hinj, rfl⟩),
    fun i => Q i (f i), hpm, ?_⟩
  intro i j
  by_cases h : j = f i
  · subst h; simp [Equiv.ofBijective]
  · rw [hzeroOff i j h]
    simp [Equiv.ofBijective, h]

/-! ### The Birkhoff route, which settles `face_hands_down` without the face

**`value A ·` IS LINEAR AND `Q ⊙ Q` IS DOUBLY STOCHASTIC, SO BIRKHOFF-VON NEUMANN APPLIES.** *The
file's own docstring on `value` already says it is "linear in the orthostochastic matrix `R`", and
[Au-Yeung-Poon](../../../references/au-yeung-poon-1979-orthostochastic-numerical-ranges/notes.md),
filed in this record, already says `φ_r : O(n) → B_n` lands in BIRKHOFF'S POLYTOPE. Both halves were
on the record and the consequence was not drawn.*

**The maximum of a linear functional over the Birkhoff polytope sits at a permutation matrix**, a
permutation matrix is orthogonal and `Splits`, so `face_hands_down` follows with `P` that
permutation. **`hzero` IS NEVER USED**, which is why the binder below is named `_hzero`: the
zero-diagonal hypothesis, the whole point of the face analysis, is irrelevant to this statement.

*This does NOT touch the criticality work beside it.* `zero_diag_critical_is_isSignedPerm_four` is
about CRITICAL POINTS rather than maxima, and Birkhoff says nothing there. **What it shows is that
the item's headline statement was the commuting-case simplification**, which
[routes.md](../../../routes.md) already flags: R28's object is a COUPLED PAIR
`((EᵀP)^∘2, (FᵀP)^∘2)`, and the argument here works only because a single `Q` gives a single
doubly stochastic matrix. -/

/-- `Q ⊙ Q` is doubly stochastic at an orthogonal `Q`: the entries are squares, and the row and
column sums are the diagonals of `Q Qᵀ` and `Qᵀ Q`. -/
theorem hadamardSelf_mem_doublyStochastic {k : ℕ} {Q : Matrix (Fin k) (Fin k) ℝ}
    (hQ : Q * Qᵀ = 1) : (Q ⊙ Q) ∈ doublyStochastic ℝ (Fin k) := by
  have hQ' : Qᵀ * Q = 1 := mul_eq_one_comm.mp hQ
  rw [mem_doublyStochastic]
  refine ⟨fun i j => mul_self_nonneg _, ?_, ?_⟩
  · ext i
    have h := congrFun (congrFun hQ i) i
    rw [Matrix.one_apply_eq] at h
    simp only [Matrix.mulVec, dotProduct, Matrix.hadamard_apply, Pi.one_apply, mul_one]
    rw [← h]
    simp [Matrix.mul_apply, Matrix.transpose_apply]
  · ext j
    have h := congrFun (congrFun hQ' j) j
    rw [Matrix.one_apply_eq] at h
    simp only [Matrix.vecMul, dotProduct, Matrix.hadamard_apply, Pi.one_apply, one_mul]
    rw [← h]
    simp [Matrix.mul_apply, Matrix.transpose_apply]

/-- A permutation matrix is its own Hadamard square. -/
theorem permMatrix_hadamard_self {k : ℕ} (s : Equiv.Perm (Fin k)) :
    ((s.permMatrix ℝ) ⊙ (s.permMatrix ℝ)) = s.permMatrix ℝ := by
  ext i j
  simp only [Matrix.hadamard_apply, Equiv.Perm.permMatrix, PEquiv.toMatrix_apply,
    Equiv.toPEquiv_apply, Option.mem_def, Option.some.injEq]
  by_cases h : s i = j <;> simp [h]

/-- A permutation matrix is a signed permutation, with every sign `1`. -/
theorem isSignedPerm_permMatrix {k : ℕ} (s : Equiv.Perm (Fin k)) :
    IsSignedPerm (s.permMatrix ℝ) := by
  refine ⟨s, fun _ => 1, fun _ => Or.inl rfl, ?_⟩
  intro i j
  simp only [Equiv.Perm.permMatrix, PEquiv.toMatrix_apply, Equiv.toPEquiv_apply,
    Option.mem_def, Option.some.injEq]
  by_cases h : j = s i <;> simp [h, eq_comm]

/-- **BIRKHOFF, APPLIED**: at every orthogonal `Q` the value is at most its value at some
permutation matrix. *This is the whole content, and `face_hands_down` is its corollary.* -/
theorem value_le_perm {k : ℕ} (A : Matrix (Fin k) (Fin k) ℝ) {Q : Matrix (Fin k) (Fin k) ℝ}
    (hQ : Q * Qᵀ = 1) :
    ∃ s : Equiv.Perm (Fin k), value A (Q ⊙ Q) ≤ value A (s.permMatrix ℝ) := by
  have hmem : (Q ⊙ Q) ∈ (doublyStochastic ℝ (Fin k) : Set (Matrix (Fin k) (Fin k) ℝ)) :=
    hadamardSelf_mem_doublyStochastic hQ
  rw [doublyStochastic_eq_convexHull_permMatrix] at hmem
  have hconv : ConvexOn ℝ Set.univ (fun M : Matrix (Fin k) (Fin k) ℝ => (Aᵀ * M).trace) :=
    ⟨convex_univ, by
      intro x _ y _ p q _ _ _
      simp only [Matrix.mul_add, Matrix.mul_smul, Matrix.trace_add, Matrix.trace_smul,
        smul_eq_mul]
      exact le_of_eq rfl⟩
  obtain ⟨M, hM, hle⟩ := hconv.exists_ge_of_mem_convexHull (Set.subset_univ _) hmem
  obtain ⟨s, rfl⟩ := hM
  exact ⟨s, hle⟩

/-- **THE OPEN CONTENT OF [I106b](../../../plan.md), stated before it is derived.**

*If the value's maximum over the orthostochastic image is attained at a zero-diagonal `Q`, then it is
also attained at a splitting one.*

This is exactly what R28's induction consumes: the rung does not need the face `{tr = 0}` to be avoided,
only that landing on it costs nothing, so that the step can hand down to the previous rung. The hypothesis
`hmax` is maximality over the image and `hzero` places `Q` on the face.

**Proved from Birkhoff**, through `value_le_perm` below, with `_hzero` unused. -/
theorem face_hands_down {k : ℕ} (hk : 2 ≤ k) (A : Matrix (Fin k) (Fin k) ℝ)
    (Q : Matrix (Fin k) (Fin k) ℝ) (hQ : Q * Qᵀ = 1)
    (_hzero : ∀ i, Q i i = 0)
    (hmax : ∀ P : Matrix (Fin k) (Fin k) ℝ, P * Pᵀ = 1 →
      value A (P ⊙ P) ≤ value A (Q ⊙ Q)) :
    ∃ P : Matrix (Fin k) (Fin k) ℝ, P * Pᵀ = 1 ∧ Splits P ∧
      value A (P ⊙ P) = value A (Q ⊙ Q) := by
  obtain ⟨s, hs⟩ := value_le_perm A hQ
  refine ⟨s.permMatrix ℝ, ?_, ?_, ?_⟩
  · rw [Matrix.transpose_permMatrix, ← Matrix.permMatrix_mul, inv_mul_cancel,
      Matrix.permMatrix_one]
  · exact splits_of_isSignedPerm hk (isSignedPerm_permMatrix s)
  · refine le_antisymm (hmax _ ?_) ?_
    · rw [Matrix.transpose_permMatrix, ← Matrix.permMatrix_mul, inv_mul_cancel,
        Matrix.permMatrix_one]
    · rw [value, value, permMatrix_hadamard_self]
      exact hs


/-- **The genericity the criticality condition needs**, as one predicate so that both statements
below carry the same hypothesis and a reader can see what it excludes.

`nu` is injective, so no pair is degenerate and the factor `(ν_m - ν_l)` can be cancelled; and for
every pair `(l,m)` the weight vector `w = β(ν_l+ν_m)u + c` separates the indices OUTSIDE that pair,
which is what makes criticality bite on the two coordinates the zero diagonal leaves alive.

**Both clauses were established by counterexample rather than assumed.** *Dropping the first admits
`ν ≡ 0`, where every pair's factor vanishes and criticality constrains nothing; dropping the second
admits a `Q` with pairwise distinct `ν` whose one surviving pair has equal complementary weights.*
Each is exhibited in [r1040](../../../reviews/REVIEW_r1040.md) and
[r1041](../../../reviews/REVIEW_r1041.md), the second machine-checked against the statement itself. -/
def CriticalityGeneric {k : ℕ} (beta : ℝ) (nu u c : Fin k → ℝ) : Prop :=
  Function.Injective nu ∧
    ∀ l m a b : Fin k, l ≠ m → a ≠ l → a ≠ m → b ≠ l → b ≠ m → a ≠ b →
      beta * (nu l + nu m) * u a + c a ≠ beta * (nu l + nu m) * u b + c b

/-! ### The general statement is FALSE at `k = 5`, and is gone

**IT WAS TYPED HERE TWICE AND WAS FALSE BOTH TIMES.** *First with no hypothesis on `ν`, where `ν ≡ 0`
makes criticality vacuous ([r1040](../../../reviews/REVIEW_r1040.md)) and a distinct-`ν` witness has
equal complementary weights on its one surviving pair ([r1041](../../../reviews/REVIEW_r1041.md),
machine-checked against the declaration). Then with `CriticalityGeneric` in force, where
[r1043](../../../reviews/REVIEW_r1043.md) exhibits a `k = 5` counterexample*: zero-diagonal and
orthogonal, every off-diagonal entry at least `0.116`, `ν` injective with gap at least `0.311`, every
complementary weight gap at least `0.050`, criticality residual `5e-62` at all twenty-five pairs, and
`‖Q‖₄⁴ = 1.90` against `k = 5`.

**ITS STATUS IS A VERIFIED NUMERICAL WITNESS RATHER THAN AN EXACT ONE**, the solution variety being
cut out by conditions whose real points are irrational. *Newton to residual `5e-62` from a float
start, smallest singular value of the Jacobian `1.8e-3`, so Newton-Kantorovich places an exact real
solution within `1e-59` of the printed point, and every hypothesis that could fail under perturbation
is an OPEN condition with margin at least `5e-2`.* **The conclusion fails by `3.1` in `‖Q‖₄⁴`**, so
no perturbation of that size recovers it.

**A STRUCTURAL LEMMA SAYS WHY, AND IT IS CHECKABLE BY HAND.** At `k = 5` the complement of a pair is
three coordinates and the two conditions cut it to the line spanned by
`(w_d - w_b, w_a - w_d, w_b - w_a)`, the cross product of `1` with `w`. *Under the weight clause all
three entries are nonzero*, so a nonvanishing `h_lm` has FULL complementary support: a counterexample
has no zero off the diagonal and its pair graph is complete. **That is why block constructions are
correctly excluded by the repair and this witness is not**, and why the `k - 4` count in the
paragraph below is a bound on the space `h_lm` MAY occupy rather than a proof that it is empty.

**So `zero_diag_critical_is_isSignedPerm_four` IS the statement**, and the general form is deleted
rather than left `sorry`'d. *A false proposition behind a `sorry` is exactly the defect the previous
repair was written to remove, and restating it as OPEN would repeat it in weaker words.* **What falls
is the ROUTE at `k ≥ 5`**: first-order information plus genericity of this shape does not separate.
*It costs `face_hands_down` nothing: the witness has value `0.3828` against `1.4688` at the best
signed permutation on the same `A`, so it is critical and nowhere near maximal.* -/

/-! **The `k = 4` case is `zero_diag_critical_is_isSignedPerm_four`, below the collapse lemma it
uses.** *It is stated there rather than here because its proof needs `conj_diagonal_eq_hadamard_inner`,
`hadamard_inner_one` and `hadamard_collapse_of_two_conditions`, none of which is declared yet.* -/

/-- **THE REDUCTION, AND IT IS THE WHOLE OF WHAT `face_hands_down` NOW NEEDS.** *Given that the
zero-diagonal maximiser is a signed permutation, the conclusion holds at `P = Q` with nothing further
to prove.* -/
theorem face_hands_down_of_isSignedPerm {k : ℕ} (hk : 2 ≤ k) (A : Matrix (Fin k) (Fin k) ℝ)
    (Q : Matrix (Fin k) (Fin k) ℝ) (hQ : Q * Qᵀ = 1) (hperm : IsSignedPerm Q) :
    ∃ P : Matrix (Fin k) (Fin k) ℝ, P * Pᵀ = 1 ∧ Splits P ∧
      value A (P ⊙ P) = value A (Q ⊙ Q) :=
  ⟨Q, hQ, splits_of_isSignedPerm hk hperm, rfl⟩

/-! ## The rank-two bridge, and criticality per pair

**`A` HAS RANK AT MOST TWO BY CONSTRUCTION**, `A_{ik} = u_i(β ν_k²) + c_i ν_k`, which the matrix form of
the criticality condition hides. Writing `X = Qᵀ diag(u) Q` and `Y = Qᵀ diag(c) Q`, both symmetric, the
Hadamard product collapses entry by entry and the antisymmetric part FACTORS.

*The consequence is that criticality is ONE SCALAR RELATION PER PAIR of distinct `ν`, and pairs with
`ν_l = ν_m` impose nothing at all, identically in `Q`.* **Verified independently before being lifted here**
([r1035](../../../reviews/REVIEW_r1035.md)). -/

/-- The bridge: a rank-two `A` sends the Hadamard form to a combination of two conjugated diagonals. -/
theorem hadamard_rank_two_apply {n : ℕ} (u c a b : Fin n → ℝ)
    (Q : Matrix (Fin n) (Fin n) ℝ) (l m : Fin n) :
    (Qᵀ * ((Matrix.of fun i k => u i * a k + c i * b k) ⊙ Q)) l m
      = a m * (Qᵀ * Matrix.diagonal u * Q) l m + b m * (Qᵀ * Matrix.diagonal c * Q) l m := by
  simp only [Matrix.mul_apply, Matrix.hadamard_apply, Matrix.of_apply, Matrix.transpose_apply,
    Matrix.diagonal_apply, Finset.sum_mul, Finset.mul_sum, Finset.sum_ite_eq,
    Finset.sum_ite_eq', Finset.mem_univ, if_true, ite_mul, zero_mul, mul_ite, mul_zero]
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **CRITICALITY, FACTORED.** The antisymmetric part of `Qᵀ(A ∘ Q)` at `(l,m)` is
`(ν_m - ν_l)` times a single scalar relation, so a pair with `ν_l = ν_m` imposes nothing. -/
theorem asym_factor {n : ℕ} (beta : ℝ) (nu u c : Fin n → ℝ)
    (Q : Matrix (Fin n) (Fin n) ℝ) (l m : Fin n) :
    (Qᵀ * ((Matrix.of fun i k => u i * (beta * nu k ^ 2) + c i * nu k) ⊙ Q)) l m
      - (Qᵀ * ((Matrix.of fun i k => u i * (beta * nu k ^ 2) + c i * nu k) ⊙ Q)) m l
      = (nu m - nu l) * (beta * (nu l + nu m) * (Qᵀ * Matrix.diagonal u * Q) l m
          + (Qᵀ * Matrix.diagonal c * Q) l m) := by
  have hX : (Qᵀ * Matrix.diagonal u * Q) m l = (Qᵀ * Matrix.diagonal u * Q) l m := by
    simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.diagonal_apply, ite_mul,
      zero_mul, mul_ite, mul_zero, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
    exact Finset.sum_congr rfl fun i _ => by ring
  have hY : (Qᵀ * Matrix.diagonal c * Q) m l = (Qᵀ * Matrix.diagonal c * Q) l m := by
    simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.diagonal_apply, ite_mul,
      zero_mul, mul_ite, mul_zero, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
    exact Finset.sum_congr rfl fun i _ => by ring
  rw [hadamard_rank_two_apply u c (fun k => beta * nu k ^ 2) nu Q l m,
      hadamard_rank_two_apply u c (fun k => beta * nu k ^ 2) nu Q m l, hX, hY]
  ring

/-! ## Criticality read on the COLUMNS

**The conjugated diagonal is an inner product against a Hadamard product of two columns.** Writing
`q_l` for the `l`th column, `(Qᵀ diag(u) Q)_{lm} = ⟨q_l ∘ q_m, u⟩`, so the per-pair factor
`asym_factor` produces is `⟨q_l ∘ q_m, β(ν_l+ν_m)u + c⟩` and criticality is ONE LINEAR CONDITION
PER PAIR on that product.

*Orthogonality of the columns says `⟨q_l ∘ q_m, 1⟩ = 0` for free.* **And at a signed permutation
distinct columns have DISJOINT SUPPORT, so `q_l ∘ q_m = 0` identically**: the zero vector is
orthogonal to everything, which is why every signed permutation is critical for every `A`. -/

/-- `(Qᵀ diag(u) Q)_{lm}` is the inner product of `u` against the entrywise product of columns
`l` and `m`. -/
theorem conj_diagonal_eq_hadamard_inner {n : ℕ} (u : Fin n → ℝ)
    (Q : Matrix (Fin n) (Fin n) ℝ) (l m : Fin n) :
    (Qᵀ * Matrix.diagonal u * Q) l m = ∑ i, (Q i l * Q i m) * u i := by
  simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.diagonal_apply, ite_mul,
    zero_mul, mul_ite, mul_zero, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **The free condition.** Distinct columns of an orthogonal matrix have entrywise product
summing to zero, which is `⟨q_l ∘ q_m, 1⟩ = 0`. -/
theorem hadamard_inner_one {n : ℕ} {Q : Matrix (Fin n) (Fin n) ℝ} (hQ : Qᵀ * Q = 1)
    {l m : Fin n} (hlm : l ≠ m) : ∑ i, Q i l * Q i m = 0 := by
  have h := congrFun (congrFun hQ l) m
  rw [Matrix.one_apply_ne hlm] at h
  rw [← h]
  simp [Matrix.mul_apply, Matrix.transpose_apply]

/-- **CRITICALITY, ON THE COLUMNS.** The antisymmetric part at `(l,m)` is `(ν_m - ν_l)` times the
inner product of `β(ν_l+ν_m)u + c` against the entrywise product of columns `l` and `m`. -/
theorem asym_factor_columns {n : ℕ} (beta : ℝ) (nu u c : Fin n → ℝ)
    (Q : Matrix (Fin n) (Fin n) ℝ) (l m : Fin n) :
    (Qᵀ * ((Matrix.of fun i k => u i * (beta * nu k ^ 2) + c i * nu k) ⊙ Q)) l m
      - (Qᵀ * ((Matrix.of fun i k => u i * (beta * nu k ^ 2) + c i * nu k) ⊙ Q)) m l
      = (nu m - nu l) * ∑ i, (Q i l * Q i m) * (beta * (nu l + nu m) * u i + c i) := by
  rw [asym_factor beta nu u c Q l m, conj_diagonal_eq_hadamard_inner,
      conj_diagonal_eq_hadamard_inner, Finset.mul_sum, ← Finset.sum_add_distrib]
  congr 1
  exact Finset.sum_congr rfl fun i _ => by ring

/-! ## The pair sums determine the spectrum

**The rank fact behind the pinning count is INJECTIVITY, and it needs no rank development.** The
`C(k,2)` sums `ν_l + ν_m` span a `k`-dimensional space because `ν` is recoverable from them:
`ν_l = ((ν_l+ν_m) + (ν_l+ν_n) - (ν_m+ν_n)) / 2` at any two further distinct indices.

*So the pinning branch of the per-pair dichotomy cannot be imposed freely across pairs: beyond `k`
of them the sums are forced.* **What this does NOT say is that the branch is empty**, since the
ratios it pins to depend on `Q` and `Q` can move to meet the sums. -/

/-- **Three pair sums recover one eigenvalue**, which is why the pair-sum map is injective and its
image is only `k`-dimensional. *The two further indices are supplied by the caller, so no index
construction is needed and the statement holds at every `k` carrying three distinct indices.* -/
theorem pairSum_determines {k : ℕ} (nu nu' : Fin k → ℝ) (l m n : Fin k)
    (hlm : l ≠ m) (hln : l ≠ n) (hmn : m ≠ n)
    (h : ∀ a b : Fin k, a ≠ b → nu a + nu b = nu' a + nu' b) :
    nu l = nu' l := by
  have h1 := h l m hlm
  have h2 := h l n hln
  have h3 := h m n hmn
  linarith

/-! ## The zero diagonal puts two zeros in every Hadamard product

**This is what makes the open statement reachable at small `k`.** At a zero-diagonal `Q` the product
`h_lm = q_l ∘ q_m` has `h_lm l = Q l l * Q l m = 0` and `h_lm m = Q m l * Q m m = 0`, so it lives in
the coordinate subspace avoiding BOTH `l` and `m`, of dimension `k - 2`.

*Two conditions act on it there, and they come from DIFFERENT places*: orthogonality of the columns
gives `⟨h_lm, 1⟩ = 0` and criticality gives `⟨h_lm, β(ν_l+ν_m)u + c⟩ = 0`. **Criticality removes ONE
dimension, not two**, which is worth stating because the count is the same either way and the
attribution is what decides how much genericity the argument costs.

**At `k = 4` the two conditions leave dimension zero**, so every `h_lm` vanishes, distinct columns
have disjoint support, and `Q` is a signed permutation. *The cost is `CriticalityGeneric`, which is
injective `ν` plus a separation of the complementary weights at every pair, twelve scalar conditions
at `k = 4` rather than the six an earlier reading of this paragraph claimed.* **At `k ≥ 5` the same
two conditions leave `k - 4` coordinates alive and the argument stops.** -/

/-- **The zero diagonal kills the `l` and `m` components of `q_l ∘ q_m`.** *Structural, not
generic: it holds at every zero-diagonal `Q` whatever else is true of it.* -/
theorem hadamard_vanishes_at_own_indices {k : ℕ} {Q : Matrix (Fin k) (Fin k) ℝ}
    (hzero : ∀ i, Q i i = 0) (l m : Fin k) :
    Q l l * Q l m = 0 ∧ Q m l * Q m m = 0 := by
  constructor
  · rw [hzero l]; ring
  · rw [hzero m]; ring

/-- **THE COLLAPSE AT `k = 4`, and it is two lines of algebra.**

*Two surviving coordinates, two conditions.* Orthogonality to `1` gives `h_a + h_b = 0`, so
`h_b = -h_a`; criticality gives `w_a h_a + w_b h_b = 0`, hence `(w_a - w_b) h_a = 0`. **With
distinct weights the product vanishes at both surviving coordinates**, and with the two it already
loses to the zero diagonal, `h_lm = 0` outright.

*The hypothesis `w_a ≠ w_b` is the whole cost of `k = 4`: where the complementary indices carry
equal weights the system drops rank and nothing follows.* -/
theorem hadamard_collapse_of_two_conditions {ha hb wa wb : ℝ}
    (hsum : ha + hb = 0) (hcrit : wa * ha + wb * hb = 0) (hne : wa ≠ wb) :
    ha = 0 ∧ hb = 0 := by
  have hb_eq : hb = -ha := by linarith
  subst hb_eq
  have : (wa - wb) * ha = 0 := by linarith
  have hza : ha = 0 := by
    rcases mul_eq_zero.mp this with h | h
    · exact absurd (sub_eq_zero.mp h) hne
    · exact h
  exact ⟨hza, by rw [hza]; ring⟩

/-- **THE `k = 4` CASE, WHICH IS WHERE THE DIMENSION COUNT CLOSES.** *Two coordinates survive the
zero diagonal, orthogonality of the columns removes one and criticality removes the other*, so every
Hadamard product of distinct columns vanishes, distinct columns have disjoint support, and `Q` is a
signed permutation. **The whole of the general case's difficulty is that `k - 4` coordinates survive
instead of none.**

**Not vacuous**: a derangement signed permutation at `k = 4` has zero diagonal and is critical for
every `A`, since its distinct columns have disjoint support, and `CriticalityGeneric` holds off a
proper closed set of `(β, ν, u, c)`. *The disjoint-support half is `isSignedPerm_of_rows_disjoint`
and holds at every `k`; only the collapse is dimensional.* -/
theorem zero_diag_critical_is_isSignedPerm_four
    (beta : ℝ) (nu u c : Fin 4 → ℝ) (Q : Matrix (Fin 4) (Fin 4) ℝ)
    (hQ : Q * Qᵀ = 1) (hzero : ∀ i, Q i i = 0)
    (hgen : CriticalityGeneric beta nu u c)
    (hcrit : ∀ l m : Fin 4,
      (nu m - nu l) * (beta * (nu l + nu m) * (Qᵀ * Matrix.diagonal u * Q) l m
        + (Qᵀ * Matrix.diagonal c * Q) l m) = 0) :
    IsSignedPerm Q := by
  obtain ⟨hnu, hwsep⟩ := hgen
  have hQ' : Qᵀ * Q = 1 := mul_eq_one_comm.mp hQ
  refine isSignedPerm_of_rows_disjoint hQ ?_
  intro i l m hlm
  -- the pair's weight vector
  set w : Fin 4 → ℝ := fun j => beta * (nu l + nu m) * u j + c j with hwdef
  -- orthogonality of the columns, free
  have hsum : ∑ j, Q j l * Q j m = 0 := hadamard_inner_one hQ' hlm
  -- criticality, after cancelling the nondegenerate factor
  have hcw : ∑ j, (Q j l * Q j m) * w j = 0 := by
    have hne : nu m - nu l ≠ 0 := sub_ne_zero.mpr fun h => hlm (hnu h).symm
    have h2 : beta * (nu l + nu m) * (Qᵀ * Matrix.diagonal u * Q) l m
        + (Qᵀ * Matrix.diagonal c * Q) l m = 0 := by
      rcases mul_eq_zero.mp (hcrit l m) with h | h
      · exact absurd h hne
      · exact h
    rw [conj_diagonal_eq_hadamard_inner, conj_diagonal_eq_hadamard_inner, Finset.mul_sum,
      ← Finset.sum_add_distrib] at h2
    rw [← h2]
    exact Finset.sum_congr rfl fun j _ => by simp only [hwdef]; ring
  -- the two coordinates the zero diagonal leaves alive
  have hcard : (Finset.univ \ ({l, m} : Finset (Fin 4))).card = 2 := by
    simp [Finset.card_sdiff, Finset.card_pair hlm]
  obtain ⟨a, b, hab, hset⟩ := Finset.card_eq_two.mp hcard
  have hmem : ∀ x : Fin 4, x ∈ ({a, b} : Finset (Fin 4)) → x ≠ l ∧ x ≠ m := by
    intro x hx
    rw [← hset, Finset.mem_sdiff] at hx
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hx
    exact hx.2
  obtain ⟨hal, ham⟩ := hmem a (by simp)
  obtain ⟨hbl, hbm⟩ := hmem b (by simp)
  have hsplit : ∀ g : Fin 4 → ℝ, ∑ j, g j = (g a + g b) + (g l + g m) := by
    intro g
    rw [← Finset.sum_sdiff (Finset.subset_univ ({l, m} : Finset (Fin 4))), hset,
      Finset.sum_pair hab, Finset.sum_pair hlm]
  -- the zero diagonal kills the pair's own two coordinates
  have hzl : Q l l * Q l m = 0 := by rw [hzero l]; ring
  have hzm : Q m l * Q m m = 0 := by rw [hzero m]; ring
  rw [hsplit] at hsum
  rw [hsplit (fun j => (Q j l * Q j m) * w j)] at hcw
  simp only [hzl, hzm, zero_mul] at hsum hcw
  obtain ⟨hza, hzb⟩ := hadamard_collapse_of_two_conditions (ha := Q a l * Q a m)
    (hb := Q b l * Q b m) (wa := w a) (wb := w b) (by linarith)
    (by rw [mul_comm (w a), mul_comm (w b)]; linarith) (hwsep l m a b hlm hal ham hbl hbm hab)
  -- every coordinate is one of the four
  have hall : i = l ∨ i = m ∨ i = a ∨ i = b := by
    by_cases h1 : i = l
    · exact Or.inl h1
    by_cases h2 : i = m
    · exact Or.inr (Or.inl h2)
    have : i ∈ ({a, b} : Finset (Fin 4)) := by
      rw [← hset, Finset.mem_sdiff]
      exact ⟨Finset.mem_univ _, by simp [h1, h2]⟩
    simp only [Finset.mem_insert, Finset.mem_singleton] at this
    exact Or.inr (Or.inr this)
  rcases hall with h | h | h | h
  · subst h; exact hzl
  · subst h; exact hzm
  · subst h; exact hza
  · subst h; exact hzb

/-! ## The SECOND-ORDER condition, stated for the CRITICALITY question

**WHAT IT IS FOR, AND WHAT IT IS NOT FOR.** *A claim that the second-order condition must do the whole
separation was recorded and REFUTED by [r1034](../../../reviews/REVIEW_r1034.md), on the grounds that a
first-order route survived.* [r1043](../../../reviews/REVIEW_r1043.md) closed THAT route at `k = 5`, so
r1034's ground is gone. **The rung it was aimed at is gone too**: `face_hands_down` is proved from Birkhoff
with no second-order content at all, so this section serves the CRITICALITY question, where the open task is
a condition using MAXIMALITY rather than criticality, and it serves no rung.

**AND AT A PERMUTATION IT CARRIES NO INFORMATION**, confirmed independently by
[r1048](../../../reviews/REVIEW_r1048.md) and [r1049](../../../reviews/REVIEW_r1049.md) and reproduced by the
parent: the second variation is DIAGONAL in the elementary skew basis `E_ab`, with
`½f''(0)[E_ab] = (A_{σ⁻¹(a),b} + A_{σ⁻¹(b),a}) − (A_{σ⁻¹(a),a} + A_{σ⁻¹(b),b})`, exactly the change in
assignment value under the transposition `(a b)`. *So `SecondOrderMax` at a permutation IS 2-opt optimality
for the linear assignment problem, and since Birkhoff makes the best permutation the global maximum, it holds
there automatically. Only a NON-permutation critical point tests anything.*

**The derivation, along `Q(s) = Q exp(sΩ)` with `Ω` skew.** With `f(Q) = Σ_{ik} A_{ik} Q_{ik}²`,
`Q'(0) = QΩ` and `Q''(0) = QΩ²`, so
`½ f''(0) = ⟨A, (QΩ) ∘ (QΩ)⟩ + tr(S Ω²)`, where `S = Qᵀ(A ∘ Q)`.

*The first-order term reproduces the recorded condition: `f'(0) = 2 tr(Ωᵀ S)` vanishes at every skew
`Ω` exactly when `S` is symmetric, which is `asym_factor`'s hypothesis and is the check that this
derivation is in the record's own conventions.*

**`skew_sq_eq_neg_gram` below is what makes the condition usable**: at skew `Ω` the second term is
`- tr(S ΩᵀΩ)`, so maximality reads
`⟨A, (QΩ) ∘ (QΩ)⟩ ≤ tr(S ΩᵀΩ)` at every skew `Ω`,
**the same Hadamard-square language the first-order condition is written in**, with a quadratic form
in `S` on the right. *At a signed permutation `S` is diagonal, which is where the comparison with
[r1043](../../../reviews/REVIEW_r1043.md)'s witness should be made.* -/

/-- **`Ω² = -ΩᵀΩ` at skew `Ω`**, which turns the second variation's second term into a quadratic
form. *One line, and it is the step that makes the second-order condition comparable with the
first-order one rather than a different kind of object.* -/
theorem skew_sq_eq_neg_gram {k : ℕ} {Om : Matrix (Fin k) (Fin k) ℝ} (hOm : Omᵀ = -Om) :
    Om * Om = -(Omᵀ * Om) := by
  rw [hOm, Matrix.neg_mul, neg_neg]

/-- **The second-order condition, stated.** At a local maximum of `value A (Q ∘ Q)` over the
orthogonal group, the second variation along every skew direction is nonpositive, which by
`skew_sq_eq_neg_gram` reads as a bound on the Hadamard square of the tangent direction by a
quadratic form in `S = Qᵀ(A ∘ Q)`.

*Stated as a predicate rather than derived from a curve*, since the layer carries no differential
structure on `O(k)`: what is typed is the ALGEBRAIC shadow, exactly as `zero_diag_critical_*` types
the first-order one. -/
def SecondOrderMax {k : ℕ} (A Q : Matrix (Fin k) (Fin k) ℝ) : Prop :=
  ∀ Om : Matrix (Fin k) (Fin k) ℝ, Omᵀ = -Om →
    value A ((Q * Om) ⊙ (Q * Om)) ≤ (Qᵀ * (A ⊙ Q) * (Omᵀ * Om)).trace

/-! ## The bridge to the entrywise fourth power

**The Hadamard products and the `ℓ₄` norm are one quantity.** For any `Q` whose rows are unit
vectors,
`Σ_{l<m} ‖q_l ∘ q_m‖² = (k - ‖Q‖₄⁴) / 2`,
because `Σ_{l≠m} Σ_i q_il² q_im² = Σ_i (Σ_l q_il²)² - Σ_i Σ_l q_il⁴`.

**So every Hadamard product vanishes exactly when `‖Q‖₄⁴ = k`.** *That bound and its equality case,
[Jin 2026](../../../references/jin-2026-l4-norm-orthogonal-group/notes.md) Theorem 1(i), follow from
the identity below together with orthonormality and are reached here rather than imported*: the
source's own contribution to this item is its parts (ii) and (iii), the local and global maximiser
classification. The open statement
`zero_diag_critical_is_isSignedPerm_four` is equivalent to: **zero-diagonal criticality forces `Q` to
MAXIMISE the entrywise fourth power.**

*That is why the filed source is the right one to have read: it settles what the maximisers are, and
this identity says our question is a question about reaching that maximum.* -/

/-- **The pairwise Hadamard mass is the `ℓ₄` deficit**, at one row, which is where the content is.

*The off-diagonal sum of `q_l² q_m²` is the square of the row's `ℓ₂` mass less its `ℓ₄` mass.*
Summed over rows with `Σ_l q_il² = 1` this reads `Σ_{l<m} ‖q_l ∘ q_m‖² = (k - ‖Q‖₄⁴)/2`. -/
theorem row_offdiag_eq_sq_sub_quartic {k : ℕ} (q : Fin k → ℝ) :
    ∑ l, ∑ m ∈ Finset.univ.erase l, q l ^ 2 * q m ^ 2
      = (∑ l, q l ^ 2) ^ 2 - ∑ l, q l ^ 4 := by
  have e : ∀ l : Fin k, ∑ m ∈ Finset.univ.erase l, q l ^ 2 * q m ^ 2
      = (∑ m, q l ^ 2 * q m ^ 2) - q l ^ 4 := by
    intro l
    rw [← Finset.sum_erase_add _ _ (Finset.mem_univ l)]
    ring
  simp_rw [e]
  rw [Finset.sum_sub_distrib, sq, Finset.sum_mul_sum]

/-! ## The maximality input: WHAT WAS TYPED HERE WAS FALSE, and this is the record of it

**[Post F69](../../../findings/fence-posts.md) fixes what a maximality input must do**: *a genuine
input must see the second variation or the value*, because a condition phrased on a Lagrange field
is checked by substituting that field's form and is usually criticality wearing a different coat.
*The commit that opened this section cited F72, which is about Birkhoff vertices and is a different
post ([r1058](../../../reviews/REVIEW_r1058.md)).*

**A `def` NAMED `MaxValueForcesFourthPeak` STOOD HERE AND WAS A FALSE PROPOSITION.** It read
`∀ Q, Q * Qᵀ = 1 → SecondOrderMax A Q → fourthPower Q = k`, **with no hypothesis on `A` at all**.
*At `A = 0` the inequality in `SecondOrderMax` reads `0 ≤ 0` and holds at every `Q`, so the
statement asserts that every orthogonal matrix peaks the entrywise fourth power. A rotation by
`0.7` in one plane at `k = 4` gives `3.0289` against `4`.* **The falsity is one line of reading and
needed no computation.**

**AND IT FAILS FOR THE RECORD'S OWN `A` TOO, WHICH IS THE FINDING THAT COSTS.**
*[r1058](../../../reviews/REVIEW_r1058.md): at a permutation the second-order form is DIAGONAL with
the 2-opt assignment gaps as entries, at the value-optimal permutation those gaps are strictly
positive, so the form is strictly positive definite. Strict definiteness of a form POLYNOMIAL in
`Q` is an OPEN condition, so `SecondOrderMax A Q` survives on a whole neighbourhood, while
`fourthPower` reaches `k` only at the signed permutations, which are isolated.*

**THE DEFENCE OFFERED FOR WRITING IT AS A `def` WAS THE WRONG ONE.** *It was defended as stating
something the record has no reason to believe, where the record can REFUTE it in one line, and a
`def` gives a false statement a name that later work can bind.*

**AND THE SECOND GAP POINTS UPHILL.** *With `X = Σ q²(QΩ)² ≥ 0` and `T = tr(QᵀQ^{∘3}Ω²)`, the
frozen-weight second variation is `2X + 2T` and Jin's is `12X + 4T`, so `f''_Jin = 2 f''_frozen +
8X`.* **Nonpositivity of ours does not give nonpositivity of Jin's**, the deficit `8X` being
strictly positive at almost every direction, so the route ran against the inequality rather than
with it.

**WHAT SURVIVES IS PART (i), AND IT IS REACHED HERE RATHER THAN IMPORTED.** `row_offdiag_eq_sq_sub_quartic`
above plus orthonormality give `f_k ≤ k` with equality exactly at the signed permutations, so the
citation carries no deductive load and a `Prop` naming it as an external hypothesis was misleading.
**Part (iii), the only second-variation clause and the only one that could clear
[post F69](../../../findings/fence-posts.md), reaches no declaration here and has no route to one.**
-/

/-- **`f_k(Q) = Σ_{ij} q_ij⁴`**, the entrywise fourth power. -/
noncomputable def fourthPower {k : ℕ} (Q : Matrix (Fin k) (Fin k) ℝ) : ℝ :=
  ∑ i : Fin k, ∑ j : Fin k, (Q i j) ^ 4

/-- **THE WITNESS THAT THE DELETED STATEMENT WAS FALSE**, kept so the refutation is checkable here
rather than only in a review.

*The `(3,4,5)` rotation in one plane is orthogonal over `ℚ` and gives `f_4 = 2 + 674/625`.*
**A FIRST VERSION OF THIS WITNESS WAS THE PERMUTATION `![![0,-1,0,0],![1,0,0,0],…]`, WHICH IS A
SIGNED PERMUTATION AND THEREFORE PEAKS `f_4` EXACTLY.** *So the witness for a falsity claim was
itself false, and the kernel is what caught it, which is the third wrong statement this item has
produced.* -/
theorem fourthPower_lt_of_rotation :
    ∃ Q : Matrix (Fin 4) (Fin 4) ℝ, Q * Qᵀ = 1 ∧ fourthPower Q ≠ (4 : ℝ) := by
  refine ⟨Matrix.of ![![3/5, -4/5, 0, 0], ![4/5, 3/5, 0, 0], ![0, 0, 1, 0], ![0, 0, 0, 1]], ?_, ?_⟩
  · ext p q
    fin_cases p <;> fin_cases q <;>
      norm_num [Matrix.mul_apply, Fin.sum_univ_four, Matrix.one_apply, Matrix.cons_val_zero,
        Matrix.cons_val_one, Matrix.head_cons, Matrix.cons_val_two, Matrix.cons_val_three,
        Matrix.vecHead, Matrix.vecTail]
  · unfold fourthPower
    norm_num [Fin.sum_univ_four, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
      Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail]

end HamiltonsCubic.I106bFace
