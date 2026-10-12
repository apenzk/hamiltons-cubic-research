import Mathlib
import HamiltonsCubic.Base.WeylReal

/-!
# L33, one eigenvalue of one sign forces the tensor to vanish, STATED here and PROVED in L33Proof

[stratum-two-negative.md](../../../findings/stratum-two-negative.md)'s Lemma L33, quoted
verbatim:

> **Statement.** Let `W ∈ Weyl_m` have a **one-dimensional** eigenspace on one side, exactly one
> eigenvalue counted *with multiplicity*. If that eigenvector is not a multiple of a complex
> structure on a `4`-dimensional subspace, then `W = 0`. In particular no rank-`3` `Weyl_m`
> tensor at even `m ≥ 6` has a nondegenerate minority-side eigenvector.

The block's own audit note fixes the reading of the hypothesis, and it is load-bearing:

> **"Exactly one eigenvalue of one sign" was ambiguous, and the lemma is FALSE under the other
> reading.** Counted as *one distinct value at any multiplicity*, a witness sits already in
> `Weyl₄`: `W⁺ = W⁻ = diag(2,−1,−1)` has spectrum `(2,2,−1,−1,−1,−1)` […] and `W ≠ 0`. **This
> file's own convention counts with multiplicity, so the statement was correct in place.**

**`MinoritySide` below counts with multiplicity**, and does so by the spectral characterisation
rather than by a basis: one eigenvector with a negative eigenvalue, and the form non-negative on
its orthogonal complement inside `Λ²`. That is exactly *"the negative spectrum is a single
eigenvalue of multiplicity one"*.

## How `L33` is proved

The record runs on the operator identity `∑_α λ_α N_{v_α} = 0` with `N_v := 2 v⊗v − ad(v)²`, obtained
by pairing the first Bianchi identity against `u ⊗ u`, and then on
[Lemma L32](../../../findings/isotropy-cap.md)'s centraliser step `𝔷(𝔠) ∩ 𝔠^⊥ = ℝx`. **The proof in
[L33Proof.lean](L33Proof.lean) needs no spectral decomposition**: it splits `W` into its `x`-part and a
positive semidefinite rest, uses [L41](L41Statement.lean)'s `aW2` (`A(W) = 2W`, which is the identity
read as a quadratic form), and takes the centraliser step from [L81](L81Proof.lean).

**What is proved here is the block's own *"What is new is the splitting"*.** `ad(v)` is
skew-adjoint on `𝔰𝔬(m)`, so `⟨u, N_v u⟩ = 2⟨v,u⟩² + ‖[v,u]‖²` and each `N_v` is positive
semidefinite; and the step the proof draws from that, a vanishing sum of non-negative terms
has every term zero, which is `ker N_x ⊆ ⋂ᵢ ker N_{yᵢ}`, is `psd_balance`.

## The exception, as a condition on a matrix

*"A multiple of a complex structure on a `4`-dimensional subspace"* is read here as: `x` has
rank `4` and `x³ = −c²x` for some `c ≠ 0`. **The second clause is what makes it a complex
structure rather than merely a rank-`4` bivector**, it forces the two nonzero skew-eigenvalue
pairs of `x` to be equal, so `x/c` restricts to `J` with `J² = −1` on `im x`.

## The statement is an emptiness statement, and that is not an accident

`W = 0` contradicts the hypothesis `W x = λ x` with `λ < 0` and `x ≠ 0`, so L33 says the
hypotheses are unsatisfiable, `L33_no_such_W` below draws that consequence from `L33` and is
proved. **So no non-vacuity witness is owed or possible**: the record's own realised case is the
exception, `W₄(q,r) ∈ Weyl₄` of signature `(2,1)`, whose minority eigenvector *is* a complex
structure on a `4`-plane. *The record adds that L33 is vacuous at `m = 4` for the same reason,
which is why the "in particular" clause's `m ≥ 6` is sharp.*

## Coverage, as the record's two notes leave it

[results.md](../../../results.md) records the statement as proved *"at even `m` with
nondegenerate `x`, and at degenerate `x` with `dim ker x ≥ 2`"*, with corank `1` true and its
proof not on file. The canonical block's later note supersedes that: with
[Lemma L160](../../../findings/isotropy-cap.md) written, *"the main statement stands wherever
L32 does, which is every `m ≠ 3`, with no debt outstanding."* **`L33` below carries the
hypothesis `m ≠ 3`**, which is the later reading; the earlier coverage note is quoted here so a
reader can see which one the file took.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L33Statement

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The `Λ²` pairing, and the two facts about it the splitting needs -/

/-- **`⟨X, Y⟩ = ⟨Y, X⟩`.** -/
theorem inner2_comm (X Y : Matrix ι ι ℝ) : inner2 X Y = inner2 Y X := by
  unfold inner2
  rw [← Matrix.trace_transpose (Xᵀ * Y)]
  simp [Matrix.transpose_mul]

/-- Linearity of the pairing in its second slot, for a scalar. -/
theorem inner2_smul_right (X Y : Matrix ι ι ℝ) (a : ℝ) : inner2 X (a • Y) = a * inner2 X Y := by
  unfold inner2
  rw [Matrix.mul_smul, Matrix.trace_smul]
  simp only [smul_eq_mul]
  ring

/-- Linearity of the pairing in its second slot, for a difference. -/
theorem inner2_sub_right (X Y Z : Matrix ι ι ℝ) : inner2 X (Y - Z) = inner2 X Y - inner2 X Z := by
  unfold inner2
  rw [Matrix.mul_sub, Matrix.trace_sub]
  ring

/-- **`⟨X, X⟩ ≥ 0`**, the pairing being `½` the Frobenius square. -/
theorem inner2_self_nonneg (X : Matrix ι ι ℝ) : 0 ≤ inner2 X X := by
  unfold inner2
  have h : (Xᵀ * X).trace = ∑ i : ι, ∑ j : ι, X j i * X j i := by
    simp [Matrix.trace, Matrix.mul_apply, Matrix.diag]
  rw [h]
  have hs : 0 ≤ ∑ i : ι, ∑ j : ι, X j i * X j i :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => mul_self_nonneg _
  linarith

/-- The trace is cyclic on triple products. -/
theorem trace_cycle3 (A B C : Matrix ι ι ℝ) : (A * B * C).trace = (B * C * A).trace :=
  calc (A * B * C).trace = (C * (A * B)).trace := Matrix.trace_mul_comm _ _
    _ = (C * A * B).trace := by rw [Matrix.mul_assoc]
    _ = (B * (C * A)).trace := Matrix.trace_mul_comm _ _
    _ = (B * C * A).trace := by rw [Matrix.mul_assoc]

/-- **`ad(v)` is skew-adjoint on `𝔰𝔬(m)`**: `⟨[v,u], w⟩ = −⟨u, [v,w]⟩` whenever `u`, `v`, `w`
are skew. *This is the one structural fact the splitting rests on.* -/
theorem ad_skewAdjoint {u v w : Matrix ι ι ℝ} (hu : IsSkew u) (hv : IsSkew v) (hw : IsSkew w) :
    inner2 (br v u) w = -inner2 u (br v w) := by
  unfold IsSkew at hu hv hw
  unfold inner2 br
  have e1 : ((v * u - u * v)ᵀ * w).trace = ((u * v - v * u) * w).trace := by
    rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hu, hv]
    simp
  have e2 : (uᵀ * (v * w - w * v)).trace = -((u * (v * w - w * v)).trace) := by
    rw [hu]; simp
  rw [e1, e2]
  simp only [Matrix.sub_mul, Matrix.mul_sub, Matrix.trace_sub]
  have h1 : (v * u * w).trace = (u * w * v).trace := trace_cycle3 v u w
  have h2 : (u * (v * w)).trace = (u * v * w).trace := by rw [Matrix.mul_assoc]
  have h3 : (u * (w * v)).trace = (u * w * v).trace := by rw [Matrix.mul_assoc]
  rw [h2, h3, h1]
  ring

/-! ## The splitting: `N_v` and its positive semidefiniteness -/

/-- **`N_v u := 2⟨v,u⟩ v − ad(v)² u`**, the operator the Bianchi identity produces. -/
noncomputable def Nop (v u : Matrix ι ι ℝ) : Matrix ι ι ℝ :=
  (2 * inner2 v u) • v - br v (br v u)

/-- **The splitting.** `⟨u, N_v u⟩ = 2⟨v,u⟩² + ‖[v,u]‖²`, for skew `u` and `v`, the record's
*"What is new is the splitting"*. -/
theorem Nop_quadratic_form {u v : Matrix ι ι ℝ} (hu : IsSkew u) (hv : IsSkew v) :
    inner2 u (Nop v u) = 2 * inner2 v u ^ 2 + inner2 (br v u) (br v u) := by
  have hbr : IsSkew (br v u) := by
    unfold IsSkew br at *
    rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hu, hv]
    simp only [Matrix.neg_mul, Matrix.mul_neg, neg_neg]
    abel
  have hadj : inner2 (br v u) (br v u) = -inner2 u (br v (br v u)) :=
    ad_skewAdjoint hu hv hbr
  unfold Nop
  rw [inner2_sub_right, inner2_smul_right, inner2_comm u v]
  rw [show inner2 u (br v (br v u)) = -inner2 (br v u) (br v u) by rw [hadj]; ring]
  ring

/-- **Hence each `N_v` is positive semidefinite.** -/
theorem Nop_psd {u v : Matrix ι ι ℝ} (hu : IsSkew u) (hv : IsSkew v) :
    0 ≤ inner2 u (Nop v u) := by
  rw [Nop_quadratic_form hu hv]
  have h1 : 0 ≤ inner2 (br v u) (br v u) := inner2_self_nonneg _
  nlinarith [sq_nonneg (inner2 v u)]

/-- **The balance step the proof draws from that.** A vanishing sum of non-negative terms has
every term zero, which, applied to `⟨u, N_x u⟩ = ∑ᵢ ⟨u, N_{yᵢ} u⟩`, is
`ker N_x ⊆ ⋂ᵢ ker N_{yᵢ}`. -/
theorem psd_balance {κ : Type*} (s : Finset κ) (q : κ → ℝ) (hnn : ∀ i ∈ s, 0 ≤ q i)
    (hzero : ∑ i ∈ s, q i = 0) : ∀ i ∈ s, q i = 0 :=
  (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hzero

/-! ## The hypotheses of the lemma -/

/-- **The minority side is one-dimensional, counted with multiplicity.** `x` is a bivector with
`W x = λ x` for some `λ < 0`, and the form `⟨W ·, ·⟩` is non-negative on the bivectors
orthogonal to `x`. *By the spectral theorem for the self-adjoint `W` on `Λ²`, this says the
negative spectrum is exactly one eigenvalue of multiplicity one.* -/
def MinoritySide (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (x : Matrix ι ι ℝ) (lam : ℝ) : Prop :=
  IsSkew x ∧ x ≠ 0 ∧ lam < 0 ∧ W x = lam • x ∧
    ∀ y : Matrix ι ι ℝ, IsSkew y → inner2 y x = 0 → 0 ≤ inner2 (W y) y

/-- **The exception.** `x` is a nonzero multiple of a complex structure on a `4`-plane: rank `4`,
and `x³ = −c²x` for some `c ≠ 0`, which forces the two nonzero skew-eigenvalue pairs equal. -/
def IsScaledComplexStructure (x : Matrix ι ι ℝ) : Prop :=
  x.rank = 4 ∧ ∃ c : ℝ, c ≠ 0 ∧ x * x * x = (-(c ^ 2)) • x

/-! ## The statement itself -/

/-! ## The statement

**`L33`, `L33_no_such_W` and `L33_nondegenerate` are stated and proved in
[L33Proof.lean](L33Proof.lean)**, in this namespace, because the proof runs through
[L81Proof.lean](L81Proof.lean). -/

end HamiltonsCubic.L33Statement
