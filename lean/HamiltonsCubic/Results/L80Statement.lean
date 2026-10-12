import Mathlib

set_option linter.style.longLine false

/-!
# L80, `N_v ⪰ 0`, with `ker N_v = v^⊥ ∩ 𝔷(v)`, STATED AND PROVED

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L80, quoted verbatim:

> `ad(v)` is skew-adjoint on `𝔰𝔬(m)` (`⟨u, N_v u⟩ = 2⟨v,u⟩² + ‖[v,u]‖²` in one line) so
> `N_v ⪰ 0`, `ker N_v = v^⊥ ∩ 𝔷(v)`.
>
> **AUDITED 2026-09-04, BOTH ASSERTIONS CONFIRMED WITH NO HYPOTHESIS AT ALL**, r471 and r472,
> independently, for every `v ∈ 𝔰𝔬(m)` including `v = 0` and degenerate `v`, on ad-invariance of
> the pairing alone.
>
> **ONE STEP OF THE HARDER INCLUSION IS UNSTATED, AND IT IS LOAD-BEARING.** The block computes
> the **quadratic form**'s null set and writes `ker N_v`. *Those are the same set only because
> `N_v` is self-adjoint and positive semidefinite*, and separately because
> `ker ad(v)² = ker ad(v)`. Both hold; neither is said.

The operator is `N_v u = 2⟨v,u⟩ v − [v,[v,u]]`, which is the form the block's own kernel
computation uses (`ker N_v = {u : ⟨v,u⟩ = 0, [v,u] = 0}`).

## Everything the record asserts is proved here, with no hypothesis on `v`

Both assertions are theorems below at every `m` and every skew `v`, `v = 0` included. The
audit's "unstated load-bearing step" is discharged by `ker_N` in the direction the block skipped:
`N_v u = 0` forces `⟨N_v u, u⟩ = 0`, and the form being a sum of two squares forces both terms to
vanish, so the operator kernel and the form's null set coincide **without** appealing to a
general PSD-plus-self-adjoint argument, and without `ker ad(v)² = ker ad(v)` as a separate input.

## What is NOT typed here

`ker N_v` is stated as the **set equality** `N_v u = 0 ↔ (⟨v,u⟩ = 0 ∧ [v,u] = 0)`, quantified
over skew `u`, rather than as an equality of `Submodule`s; `𝔠 = v^⊥ ∩ 𝔷(v)` is that set by
definition. The record's surrounding claims, that this `𝔠` is [L32](../../../findings/isotropy-cap.md)'s,
and that `∑_α λ_α N_{v_α} = 0` splits the spectrum into two PSD sums with **equal**
side-intersections of centralisers, are separate statements about a curvature operator and are
not typed here.

Ad-invariance is derived from the trace form rather than assumed, so nothing classical enters
through a binder.
-/

namespace HamiltonsCubic.L80Statement

open Matrix

variable {m : ℕ}

/-- The `Λ²` inner product `⟨X, Y⟩ = ½ tr(Xᵀ Y)`, the normalisation
[conventions.md](../../../findings/conventions.md) fixes. -/
noncomputable def inner2 (X Y : Matrix (Fin m) (Fin m) ℝ) : ℝ := (1 / 2) * (Xᵀ * Y).trace

/-- The bracket on `𝔰𝔬(m)`. -/
def br (X Y : Matrix (Fin m) (Fin m) ℝ) : Matrix (Fin m) (Fin m) ℝ := X * Y - Y * X

/-- Membership in `𝔰𝔬(m)`. -/
def Skew (X : Matrix (Fin m) (Fin m) ℝ) : Prop := Xᵀ = -X

/-- `N_v u = 2⟨v,u⟩ v − [v,[v,u]]`. -/
noncomputable def N (v u : Matrix (Fin m) (Fin m) ℝ) : Matrix (Fin m) (Fin m) ℝ :=
  (2 * inner2 v u) • v - br v (br v u)

/-! ## The pairing -/

theorem inner2_self_eq_sum (X : Matrix (Fin m) (Fin m) ℝ) :
    inner2 X X = (1 / 2) * ∑ i, ∑ j, (X i j) ^ 2 := by
  unfold inner2
  congr 1
  rw [Matrix.trace]
  simp only [Matrix.diag_apply, Matrix.mul_apply, Matrix.transpose_apply, sq]
  exact Finset.sum_comm

theorem inner2_self_nonneg (X : Matrix (Fin m) (Fin m) ℝ) : 0 ≤ inner2 X X := by
  rw [inner2_self_eq_sum]
  have : 0 ≤ ∑ i, ∑ j, (X i j) ^ 2 := by positivity
  linarith

theorem inner2_self_eq_zero {X : Matrix (Fin m) (Fin m) ℝ} : inner2 X X = 0 ↔ X = 0 := by
  rw [inner2_self_eq_sum]
  constructor
  · intro h
    have hs : ∑ i, ∑ j, (X i j) ^ 2 = 0 := by linarith
    ext i j
    have h1 : ∀ i ∈ Finset.univ, (0 : ℝ) ≤ ∑ j, (X i j) ^ 2 := by
      intro i _; positivity
    have h2 := (Finset.sum_eq_zero_iff_of_nonneg h1).mp hs i (Finset.mem_univ i)
    have h3 : ∀ j ∈ Finset.univ, (0 : ℝ) ≤ (X i j) ^ 2 := by intro j _; positivity
    have h4 := (Finset.sum_eq_zero_iff_of_nonneg h3).mp h2 j (Finset.mem_univ j)
    simpa using pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h4
  · intro h; subst h; simp

theorem inner2_sub_left (X Y Z : Matrix (Fin m) (Fin m) ℝ) :
    inner2 (X - Y) Z = inner2 X Z - inner2 Y Z := by
  unfold inner2
  rw [Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]
  ring

theorem inner2_smul_left (c : ℝ) (X Z : Matrix (Fin m) (Fin m) ℝ) :
    inner2 (c • X) Z = c * inner2 X Z := by
  unfold inner2
  rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul]
  simp [mul_comm, mul_assoc]

/-! ## The bracket is skew and ad-invariant -/

theorem br_skew {v u : Matrix (Fin m) (Fin m) ℝ} (hv : Skew v) (hu : Skew u) :
    Skew (br v u) := by
  unfold Skew br at *
  simp only [Matrix.transpose_sub, Matrix.transpose_mul, hv, hu]
  noncomm_ring

/-- `(br v a)ᵀ = br a v` for skew `v`, `a`, the one transposition the ad-invariance uses. -/
theorem br_transpose {v a : Matrix (Fin m) (Fin m) ℝ} (hv : Skew v) (ha : Skew a) :
    (br v a)ᵀ = br a v := by
  unfold Skew br at *
  simp only [Matrix.transpose_sub, Matrix.transpose_mul, hv, ha]
  noncomm_ring

/-- **`ad(v)` is skew-adjoint for the trace form**, `⟨[v,a],b⟩ = −⟨a,[v,b]⟩`, from cyclicity of
the trace alone. -/
theorem ad_skew_adjoint {v a b : Matrix (Fin m) (Fin m) ℝ} (hv : Skew v) (ha : Skew a) :
    inner2 (br v a) b = - inner2 a (br v b) := by
  have hcyc : (v * a * b).trace = (a * b * v).trace := (Matrix.trace_mul_cycle a b v).symm
  unfold inner2
  rw [br_transpose hv ha]
  have haT : aᵀ = -a := ha
  rw [haT]
  unfold br
  simp only [Matrix.sub_mul, Matrix.mul_sub, Matrix.neg_mul, Matrix.trace_sub, Matrix.trace_neg,
    Matrix.mul_assoc]
  have h1 : (a * (v * b)).trace = (a * v * b).trace := by rw [Matrix.mul_assoc]
  have h2 : (v * (a * b)).trace = (v * a * b).trace := by rw [Matrix.mul_assoc]
  have h3 : (a * (b * v)).trace = (a * b * v).trace := by rw [Matrix.mul_assoc]
  rw [h1, h2, h3, hcyc]
  ring

/-! ## The form, and the two assertions -/

/-- **`⟨N_v u, u⟩ = 2⟨v,u⟩² + ‖[v,u]‖²`**, the one line the record gives, proved. -/
theorem form_eq {v u : Matrix (Fin m) (Fin m) ℝ} (hv : Skew v) (hu : Skew u) :
    inner2 (N v u) u = 2 * (inner2 v u) ^ 2 + inner2 (br v u) (br v u) := by
  unfold N
  rw [inner2_sub_left, inner2_smul_left,
    ad_skew_adjoint (b := u) hv (br_skew hv hu)]
  ring

/-- **`N_v ⪰ 0`**, at every `m` and every skew `v`, `v = 0` included. -/
theorem N_psd {v u : Matrix (Fin m) (Fin m) ℝ} (hv : Skew v) (hu : Skew u) :
    0 ≤ inner2 (N v u) u := by
  rw [form_eq hv hu]
  have := inner2_self_nonneg (br v u)
  positivity

/-- **`ker N_v = v^⊥ ∩ 𝔷(v)`.** The direction the block leaves unstated is the forward one, and it
is proved here from the sum-of-squares form rather than from self-adjointness. -/
theorem ker_N {v u : Matrix (Fin m) (Fin m) ℝ} (hv : Skew v) (hu : Skew u) :
    N v u = 0 ↔ (inner2 v u = 0 ∧ br v u = 0) := by
  constructor
  · intro h
    have h0 : inner2 (N v u) u = 0 := by rw [h]; unfold inner2; simp
    rw [form_eq hv hu] at h0
    have hb : 0 ≤ inner2 (br v u) (br v u) := inner2_self_nonneg _
    have hs : 0 ≤ 2 * (inner2 v u) ^ 2 := by positivity
    have e1 : inner2 (br v u) (br v u) = 0 := by linarith
    have e2 : (inner2 v u) ^ 2 = 0 := by linarith
    exact ⟨by simpa using pow_eq_zero_iff (n := 2) (by norm_num) |>.mp e2,
      inner2_self_eq_zero.mp e1⟩
  · rintro ⟨h1, h2⟩
    unfold N
    rw [h1, h2]
    unfold br
    simp

/-! ## The hypotheses are inhabited -/

/-- A nonzero skew matrix, so neither theorem above is vacuous. -/
example : Skew (Matrix.of ![![0, 1], ![-1, 0]] : Matrix (Fin 2) (Fin 2) ℝ) := by
  unfold Skew
  ext i j
  fin_cases i <;> fin_cases j <;> simp

/-! ## The statement -/

/-- **L80.** For every `v ∈ 𝔰𝔬(m)`, the operator `N_v u = 2⟨v,u⟩v − [v,[v,u]]` is positive
semidefinite on `𝔰𝔬(m)`, and its kernel is `v^⊥ ∩ 𝔷(v)`. No hypothesis on `v`. -/
theorem L80 (v : Matrix (Fin m) (Fin m) ℝ) (hv : Skew v) :
    (∀ u : Matrix (Fin m) (Fin m) ℝ, Skew u → 0 ≤ inner2 (N v u) u) ∧
      (∀ u : Matrix (Fin m) (Fin m) ℝ, Skew u →
        (N v u = 0 ↔ (inner2 v u = 0 ∧ br v u = 0))) :=
  ⟨fun u hu => N_psd hv hu, fun u hu => ker_N hv hu⟩

end HamiltonsCubic.L80Statement
