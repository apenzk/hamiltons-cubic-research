import HamiltonsCubic.Base.KillingForm

/-!
# B1, part 3: the layer at general `n`

The `n = 4` development indexes bivectors by `Fin 6` and carries the pair table
as data, so every new dimension needs a new table. This file removes the pair
index entirely.

**The device.** The quadratic form sums over an orthonormal basis of `Λ²`, i.e.
over pairs `i < j`. Its summand is quadratic in the basis vector, and
`φ_{ji} = -φ_{ij}` with `φ_{ii} = 0`, so summing over **all** ordered pairs
double-counts and nothing else:

`Σ_{i<j} g(φ_{ij}) = ½ Σ_{i,j} g(φ_{ij})`.

That replaces the pair table by `Finset.univ`, and every definition below is
generic in `n`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {n : ℕ}

/-- A curvature operator, as a map on bivectors. -/
abbrev Biv (n : ℕ) := Matrix (Fin n) (Fin n) ℚ

/-- `⟨R# η, η⟩` at general `n`. The `¼` is the `½` of the definition times the
`½` that pays for summing over ordered pairs. -/
def sharpQF' (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (η : Matrix ι ι ℚ) : ℚ :=
  -(1/4) * ∑ i : ι, ∑ j : ι, inner2 (br η (R (br η (R (phi i j))))) (phi i j)

/-- The Ricci contraction, signs coming from the basis. -/
def RicOf (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (a b : ι) : ℚ :=
  ∑ c : ι, inner2 (R (phi a c)) (phi b c)

/-- First Bianchi, as one number per four indices. -/
def bianchiOf (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (i j k l : ι) : ℚ :=
  inner2 (R (phi i j)) (phi k l) + inner2 (R (phi i k)) (phi l j)
    + inner2 (R (phi i l)) (phi j k)

/-- `𝒲ₙ` for an operator given as a map.

**The symmetry clause is quantified over bivectors, not over all matrices.** A
curvature operator acts on `Λ²`, and the pair-basis coordinates represent a
matrix faithfully only when it is skew; quantifying wider states something
stronger than the object supports and cannot be transferred from an operator's
own symmetry. -/
def IsWeylOf (R : Matrix ι ι ℚ → Matrix ι ι ℚ) : Prop :=
  (∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) ∧
  (∀ i j k l, bianchiOf R i j k l = 0) ∧
  (∀ a b, RicOf R a b = 0)

/-! ## The anchor, at every dimension

`Id# = (n-2) Id` is a statement about general `n`, and it is now proved as one here.

*This section read `blocked on sum_inner2_ad2 at ℚ` and carried three `native_decide` checks at
`n = 4`, `5` and `6`.* **What blocked it was the field and never the mathematics**: the chain
`sum_inner2_ad2` into `sharpQF_id` runs over `ℝ` in
[StructureConstants.lean](StructureConstants.lean), and every step of it is `ring`, `simp`,
`noncomm_ring` or `linarith`, so it ports to `ℚ` unchanged. [KillingForm.lean](KillingForm.lean)
carries the port, and the three dimensions below are corollaries of one line.
-/

/-- **`⟨Id# η, η⟩ = (n-2)‖η‖²` AT EVERY `n`, ON THE KERNEL.** *The `¼` in `sharpQF'` pays for the
ordered-pair doubling, and the Killing contraction supplies the matching `2`.* -/
theorem sharpQF'_id (η : Matrix ι ι ℚ) (hη : IsSkew η) :
    sharpQF' (ι := ι) id η = ((Fintype.card ι : ℚ) - 2) * inner2 η η := by
  have htr : (η * η).trace = -2 * inner2 η η := by
    have hηt : Matrix.transpose η = -η := hη
    simp [inner2, hηt, Matrix.neg_mul, Matrix.trace_neg]
  unfold sharpQF'
  simp only [id_eq]
  rw [sum_inner2_ad2 η η hη hη, htr]
  ring

/-- The three dimensions the record checked, now corollaries. -/
theorem sharpQF'_id_four : sharpQF' (ι := Fin 4) id (phi 0 1) = 2 := by
  rw [sharpQF'_id _ (phi_isSkew 0 1), inner2_phi_self (by decide)]; norm_num

theorem sharpQF'_id_five : sharpQF' (ι := Fin 5) id (phi 0 1) = 3 := by
  rw [sharpQF'_id _ (phi_isSkew 0 1), inner2_phi_self (by decide)]; norm_num

theorem sharpQF'_id_six : sharpQF' (ι := Fin 6) id (phi 0 1) = 4 := by
  rw [sharpQF'_id _ (phi_isSkew 0 1), inner2_phi_self (by decide)]; norm_num

/-- And the identity is Ricci-**flat** nowhere, `Ric(Id) = (n-1) δ`, which is
what makes `Id ∉ 𝒲ₙ` and is a check that `RicOf` normalises as the record does. -/
theorem phi_self_zero (i : ι) : phi (ι := ι) i i = 0 := by
  unfold phi; simp

/-- **`Ric(Id) = (n-1)` ON THE DIAGONAL, AT EVERY `n`.** *This was two `native_decide` checks at
`n = 4` and `n = 5` until 2026-09-20.* **The general statement removes the compiler from the trust
base AND says more than the two instances did**, which is the route
[plan-lean.md](../../../plan-lean.md) names for this debt: prove the general-`n` statement and take
the fixed dimension as a corollary. *It needs only that `φ_aa` vanishes and that `φ_ac` is a unit
bivector off the diagonal, both already on file.* -/
theorem RicOf_id_diag (a : ι) : RicOf (ι := ι) id a a = (Fintype.card ι : ℚ) - 1 := by
  unfold RicOf
  have key : ∀ c : ι, inner2 (id (phi a c)) (phi a c) = if c = a then (0:ℚ) else 1 := by
    intro c
    by_cases h : c = a
    · rw [h]
      show inner2 (phi a a) (phi a a) = _
      rw [phi_self_zero]
      unfold inner2
      simp
    · show inner2 (phi a c) (phi a c) = _
      rw [inner2_phi_self (Ne.symm h)]
      simp [h]
  rw [Finset.sum_congr rfl (fun c _ => key c)]
  have split : ∀ c : ι, (if c = a then (0:ℚ) else 1) = 1 - (if c = a then 1 else 0) := by
    intro c; by_cases h : c = a <;> simp [h]
  rw [Finset.sum_congr rfl (fun c _ => split c), Finset.sum_sub_distrib, Finset.sum_const,
    Finset.sum_ite_eq' Finset.univ a (fun _ => (1:ℚ))]
  simp [Finset.card_univ]

/-- The two dimensions the record checked, now corollaries. -/
theorem RicOf_id_four : RicOf (ι := Fin 4) id 0 0 = 3 := by
  rw [RicOf_id_diag]; norm_num

theorem RicOf_id_five : RicOf (ι := Fin 5) id 0 0 = 4 := by
  rw [RicOf_id_diag]; norm_num

end HamiltonsCubic.Base
