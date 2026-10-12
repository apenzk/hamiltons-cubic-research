import HamiltonsCubic.Results.L196Statement

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L196 step 3: `α` and `β` cannot both be degenerate, at every dimension

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L196, the paragraph *"Both degenerate at once is impossible"*:
with `α = ω₁ - ω₂`, `β = ω₁ + ω₂` and `T = -J₁J₂`, *`E₊ = ker(T - I)` and `E₋ = ker(T + I)` are `J₁`-invariant, and on them
`J₂ = J₁` and `J₂ = -J₁` respectively. Hence `α` annihilates `E₊` and `β` annihilates `E₋`, so the `Λ²E₋ ⊗ Λ²E₊` component of
`α ∧ β` is the single term `α|E₋ ∧ β|E₊`, with nothing to cancel it.*

**The component is read off by evaluating `α ∧ β` on `(u, J₁u, w, J₁w)`** with `u ∈ E₊` and `w ∈ E₋`, which gives
`4|u|²|w|²`. So `α ∧ β = 0` forces `u = 0` or `w = 0`.

* **`ev_halfw`**: the four-index `halfw X Y` evaluated on four vectors is `X(p,q)Y(r,s) - X(p,r)Y(q,s) + X(p,s)Y(q,r)`.
* **`ker_sub_iff`, `ker_add_iff`**: `α u = 0 ↔ T u = u` and `β w = 0 ↔ T w = -w`, which are the record's `E₊` and `E₋`.
* **`ev_cross`**: `(α ∧ β)(u, J₁u, w, J₁w) = 4|u|²|w|²` whenever `α u = 0` and `β w = 0`.
* **`L196_step3`**: at two skew complex structures with `α ∧ β = 0`, `α u = 0` and `β w = 0` force `u = 0` or `w = 0`.
* **`L196_step3_wedgeSelf`**: the same from the lemma's own hypothesis `ω₁ ∧ ω₁ = ω₂ ∧ ω₂`, through step 1.

**It holds over every finite index type**, so at every `m` including `m = 2`, where the record's counterexample to the full
lemma fails at step 2 (its `T` has `T² = -I` and no eigenvalue `±1`). At odd dimension it is empty, `(det J)² = (-1)ⁿ` ruling
out `J² = -1`. The hypotheses, skewness and `J² = -1`, are the record's orthogonal complex structures exactly, skew with
`J² = -1` giving `JᵀJ = I`. The proof applies `J₂` to `J₂u = J₁u` to get `J₂J₁u = -u`, and so runs without the orthogonality of `T`
that the record's argument uses ([r1914](../../../reviews/REVIEW_r1914.md)).
-/

namespace HamiltonsCubic.L196Step3

open Matrix Finset HamiltonsCubic.SelfDualLayer HamiltonsCubic.RealLayer HamiltonsCubic.L196Statement

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The bilinear form of a matrix, `X(p, q) = p ⬝ X q`. -/
def bil (X : Matrix ι ι ℝ) (p q : ι → ℝ) : ℝ := p ⬝ᵥ (X *ᵥ q)

/-- A four-index function evaluated on four vectors. -/
def ev (F : ι → ι → ι → ι → ℝ) (p q r s : ι → ℝ) : ℝ :=
  ∑ a, ∑ b, ∑ c, ∑ d, p a * q b * r c * s d * F a b c d

theorem bil_eq (X : Matrix ι ι ℝ) (p q : ι → ℝ) : bil X p q = ∑ a, ∑ b, p a * X a b * q b := by
  simp only [bil, dotProduct, mulVec, Finset.mul_sum, mul_assoc]

theorem prod4 (f g : ι → ι → ℝ) :
    (∑ a, ∑ b, f a b) * (∑ c, ∑ d, g c d) = ∑ a, ∑ b, ∑ c, ∑ d, f a b * g c d := by
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.mul_sum]

theorem t1 (X Y : Matrix ι ι ℝ) (p q r s : ι → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, p a * q b * r c * s d * (X a b * Y c d) = bil X p q * bil Y r s := by
  rw [bil_eq, bil_eq, prod4]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
  ring

theorem t2 (X Y : Matrix ι ι ℝ) (p q r s : ι → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, p a * q b * r c * s d * (X a c * Y b d) = bil X p r * bil Y q s := by
  rw [bil_eq, bil_eq, prod4]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun d _ => ?_
  ring

theorem t3 (X Y : Matrix ι ι ℝ) (p q r s : ι → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, p a * q b * r c * s d * (X a d * Y b c) = bil X p s * bil Y q r := by
  rw [bil_eq, bil_eq, prod4]
  refine Finset.sum_congr rfl fun a _ => ?_
  have e : ∀ b : ι, ∑ c, ∑ d, p a * q b * r c * s d * (X a d * Y b c)
      = ∑ d, ∑ c, p a * X a d * s d * (q b * Y b c * r c) := fun b => by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun c _ => by ring
  simp only [e]
  rw [Finset.sum_comm]

/-- **`halfw X Y` evaluated on four vectors.** -/
theorem ev_halfw (X Y : Matrix ι ι ℝ) (p q r s : ι → ℝ) :
    ev (halfw X Y) p q r s = bil X p q * bil Y r s - bil X p r * bil Y q s + bil X p s * bil Y q r := by
  rw [← t1, ← t2, ← t3]
  simp only [ev, halfw, mul_add, mul_sub, Finset.sum_add_distrib, Finset.sum_sub_distrib]

theorem ev_add (F G : ι → ι → ι → ι → ℝ) (p q r s : ι → ℝ) :
    ev (F + G) p q r s = ev F p q r s + ev G p q r s := by
  simp only [ev, Pi.add_apply, mul_add, Finset.sum_add_distrib]

/-- A skew form kills its kernel from the left as well. -/
theorem bil_left_zero {X : Matrix ι ι ℝ} (hX : IsSkew X) {u : ι → ℝ} (hu : X *ᵥ u = 0) (q : ι → ℝ) :
    bil X u q = 0 := by
  unfold bil
  rw [dotProduct_mulVec]
  have : u ᵥ* X = -(X *ᵥ u) := by
    rw [← vecMul_transpose, hX, vecMul_neg, neg_neg]
  rw [this, hu, neg_zero, zero_dotProduct]

theorem mv (A B : Matrix ι ι ℝ) (u : ι → ℝ) : A *ᵥ (B *ᵥ u) = (A * B) *ᵥ u := mulVec_mulVec u A B

/-- **`α u = 0` is `u ∈ E₊`**, `T = -J₁J₂`, at `J₁² = -1`. -/
theorem ker_sub_iff {J₁ J₂ : Matrix ι ι ℝ} (h1 : J₁ * J₁ = -1) (u : ι → ℝ) :
    (J₁ - J₂) *ᵥ u = 0 ↔ (-(J₁ * J₂)) *ᵥ u = u := by
  rw [sub_mulVec, sub_eq_zero, neg_mulVec, ← mv]
  constructor
  · intro h; rw [← h, mv, h1, neg_mulVec, one_mulVec, neg_neg]
  · intro h
    calc J₁ *ᵥ u = J₁ *ᵥ (-(J₁ *ᵥ (J₂ *ᵥ u))) := by rw [h]
      _ = J₂ *ᵥ u := by rw [mulVec_neg, mv J₁ J₁, h1, neg_mulVec, one_mulVec, neg_neg]

/-- **`β w = 0` is `w ∈ E₋`.** -/
theorem ker_add_iff {J₁ J₂ : Matrix ι ι ℝ} (h1 : J₁ * J₁ = -1) (w : ι → ℝ) :
    (J₁ + J₂) *ᵥ w = 0 ↔ (-(J₁ * J₂)) *ᵥ w = -w := by
  have neg_of : ∀ x y : ι → ℝ, x + y = 0 → y = -x := fun x y h => by
    rw [← sub_eq_zero, sub_neg_eq_add, add_comm]; exact h
  constructor
  · intro h
    rw [add_mulVec] at h
    have h' := neg_of _ _ h
    rw [neg_mulVec, ← mv, h', mulVec_neg, mv, h1]; simp [neg_mulVec, one_mulVec]
  · intro h
    rw [add_mulVec]
    have e : J₁ *ᵥ (J₂ *ᵥ w) = w := by rw [neg_mulVec, neg_inj, ← mv] at h; exact h
    have h2' : J₂ *ᵥ w = -(J₁ *ᵥ w) :=
      calc J₂ *ᵥ w = -(J₁ *ᵥ (J₁ *ᵥ (J₂ *ᵥ w))) := by rw [mv, h1, neg_mulVec, one_mulVec, neg_neg]
        _ = -(J₁ *ᵥ w) := by rw [e]
    rw [h2', add_neg_cancel]

/-- **The cross component.** `(α ∧ β)(u, J₁u, w, J₁w) = 4|u|²|w|²` at `α u = 0`, `β w = 0`. -/
theorem ev_cross {J₁ J₂ : Matrix ι ι ℝ} (hs1 : IsSkew J₁) (hs2 : IsSkew J₂) (h1 : J₁ * J₁ = -1)
    (h2 : J₂ * J₂ = -1) {u w : ι → ℝ} (hu : (J₁ - J₂) *ᵥ u = 0) (hw : (J₁ + J₂) *ᵥ w = 0) :
    ev (wedge2 (J₁ - J₂) (J₁ + J₂)) u (J₁ *ᵥ u) w (J₁ *ᵥ w) = 4 * (u ⬝ᵥ u) * (w ⬝ᵥ w) := by
  have hα : IsSkew (J₁ - J₂) := by unfold IsSkew at *; rw [transpose_sub, hs1, hs2]; abel
  have hβ : IsSkew (J₁ + J₂) := by unfold IsSkew at *; rw [transpose_add, hs1, hs2]; abel
  -- `J₂u = J₁u` and `J₂w = -J₁w`
  have hu' : J₂ *ᵥ u = J₁ *ᵥ u := by rw [sub_mulVec, sub_eq_zero] at hu; exact hu.symm
  have hw' : J₂ *ᵥ w = -(J₁ *ᵥ w) := by
    rw [add_mulVec] at hw; rw [← sub_eq_zero, sub_neg_eq_add, add_comm]; exact hw
  have J1u : J₁ *ᵥ (J₁ *ᵥ u) = -u := by rw [mv, h1, neg_mulVec, one_mulVec]
  have J1w : J₁ *ᵥ (J₁ *ᵥ w) = -w := by rw [mv, h1, neg_mulVec, one_mulVec]
  have J2u : J₂ *ᵥ (J₁ *ᵥ u) = -u := by rw [← hu', mv, h2, neg_mulVec, one_mulVec]
  have J2w : J₂ *ᵥ (J₁ *ᵥ w) = w := by
    have : J₁ *ᵥ w = -(J₂ *ᵥ w) := by rw [hw', neg_neg]
    rw [this, mulVec_neg, mv, h2, neg_mulVec, one_mulVec, neg_neg]
  -- `J₁u` lies in `E₊` and `J₁w` in `E₋`
  have hu2 : (J₁ - J₂) *ᵥ (J₁ *ᵥ u) = 0 := by rw [sub_mulVec, J1u, J2u, sub_self]
  have hw2 : (J₁ + J₂) *ᵥ (J₁ *ᵥ w) = 0 := by rw [add_mulVec, J1w, J2w, neg_add_cancel]
  have b1 : bil (J₁ + J₂) u (J₁ *ᵥ u) = -2 * (u ⬝ᵥ u) := by
    simp only [bil, add_mulVec, J1u, J2u, dotProduct_add, dotProduct_neg]; ring
  have b2 : bil (J₁ - J₂) w (J₁ *ᵥ w) = -2 * (w ⬝ᵥ w) := by
    simp only [bil, sub_mulVec, J1w, J2w, dotProduct_sub, dotProduct_neg]; ring
  unfold wedge2
  rw [ev_add, ev_halfw, ev_halfw, bil_left_zero hα hu, bil_left_zero hα hu, bil_left_zero hα hu,
    bil_left_zero hα hu2, bil_left_zero hα hu2, b1, b2]
  ring

/-- **L196 step 3, at every dimension.** Two skew complex structures with `α ∧ β = 0` cannot have both `α` and `β`
degenerate: a vector in `ker α` and a vector in `ker β` cannot both be nonzero. -/
theorem L196_step3 {J₁ J₂ : Matrix ι ι ℝ} (hs1 : IsSkew J₁) (hs2 : IsSkew J₂) (h1 : J₁ * J₁ = -1)
    (h2 : J₂ * J₂ = -1) (hαβ : wedge2 (J₁ - J₂) (J₁ + J₂) = 0) {u w : ι → ℝ}
    (hu : (J₁ - J₂) *ᵥ u = 0) (hw : (J₁ + J₂) *ᵥ w = 0) : u = 0 ∨ w = 0 := by
  have h := ev_cross hs1 hs2 h1 h2 hu hw
  rw [hαβ] at h
  simp only [ev, Pi.zero_apply, mul_zero, Finset.sum_const_zero] at h
  have : u ⬝ᵥ u = 0 ∨ w ⬝ᵥ w = 0 := by
    rcases mul_eq_zero.mp h.symm with h' | h'
    · left; rcases mul_eq_zero.mp h' with h'' | h''
      · norm_num at h''
      · exact h''
    · right; exact h'
  rcases this with h' | h'
  · exact Or.inl (dotProduct_self_eq_zero.mp h')
  · exact Or.inr (dotProduct_self_eq_zero.mp h')

/-- **Step 3 from the lemma's own hypothesis**, `ω₁ ∧ ω₁ = ω₂ ∧ ω₂`, through step 1. -/
theorem L196_step3_wedgeSelf {J₁ J₂ : Matrix ι ι ℝ} (hs1 : IsSkew J₁) (hs2 : IsSkew J₂)
    (h1 : J₁ * J₁ = -1) (h2 : J₂ * J₂ = -1) (hw : wedgeSelf J₁ = wedgeSelf J₂) {u v : ι → ℝ}
    (hu : (J₁ - J₂) *ᵥ u = 0) (hv : (J₁ + J₂) *ᵥ v = 0) : u = 0 ∨ v = 0 :=
  L196_step3 hs1 hs2 h1 h2 ((wedgeSelf_eq_iff J₁ J₂).mp hw) hu hv

/-- **A witness for the hypotheses**: `stdJ6` against itself, where `α = 0` and `β = 2J` is nondegenerate. -/
example : wedgeSelf stdJ6 = wedgeSelf stdJ6 ∧ IsSkew stdJ6 ∧ stdJ6 * stdJ6 = -1 :=
  ⟨rfl, stdJ6_isComplexStructure.1, stdJ6_isComplexStructure.2⟩

end HamiltonsCubic.L196Step3
