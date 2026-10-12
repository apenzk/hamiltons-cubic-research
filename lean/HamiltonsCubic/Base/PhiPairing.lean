import HamiltonsCubic.Base.Bivectors

/-!
# B11, the `φ` pairing in closed form

[B1](Bivectors.lean) pinned `‖φ_{ij}‖ = 1`, the convention that had cost a
cycle, and stopped there. The orthogonality that goes with it was never taken,
and [L34](../Results/L34i.lean) then wanted it on a sum type and could not have
it.

The general form is one line of `δ`s:

`⟪φ_{ij}, φ_{kl}⟫ = δ_{ik} δ_{jl} - δ_{il} δ_{jk}`,

which gives `1` on a repeated pair, `-1` on a swapped one, and `0` whenever the
pairs differ in either slot. `‖φ_{ij}‖ = 1` at `i ≠ j` is its diagonal case.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The pairing as an entrywise double sum, which is what makes the `single`
terms collapse. -/
theorem inner2_eq_sum (X Y : Matrix ι ι ℚ) :
    inner2 X Y = (1/2) * ∑ a, ∑ b, X b a * Y b a := by
  unfold inner2
  simp [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply]

/-- **The pairing of two `single` matrices.** One `δ` comes from the product,
one from the trace. -/
theorem inner2_single (i j k l : ι) :
    inner2 (Matrix.single i j (1:ℚ)) (Matrix.single k l 1)
      = if i = k then (if j = l then (1:ℚ)/2 else 0) else 0 := by
  unfold inner2
  rw [Matrix.transpose_single]
  by_cases hik : i = k
  · subst hik
    by_cases hjl : j = l
    · subst hjl
      simp [Matrix.single_mul_single_same]
    · simp [Matrix.single_mul_single_same, Matrix.trace_single_eq_of_ne, hjl]
  · have hz : Matrix.single j i (1:ℚ) * Matrix.single k l 1 = 0 := by
      ext a b
      rw [Matrix.mul_apply]
      refine Finset.sum_eq_zero fun c _ => ?_
      by_cases hc : c = i
      · subst hc
        simp [Matrix.single_apply, Ne.symm hik]
      · simp [Matrix.single_apply, hc, Ne.symm hc]
    rw [hz]
    simp [hik]

theorem inner2_sub_left (X Y Z : Matrix ι ι ℚ) :
    inner2 (X - Y) Z = inner2 X Z - inner2 Y Z := by
  unfold inner2
  rw [Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]
  ring

theorem inner2_sub_right (X Y Z : Matrix ι ι ℚ) :
    inner2 X (Y - Z) = inner2 X Y - inner2 X Z := by
  unfold inner2
  rw [Matrix.mul_sub, Matrix.trace_sub]
  ring

/-- **The pairing of two basis bivectors, in closed form**:
`⟪φ_{ij}, φ_{kl}⟫ = δ_{ik} δ_{jl} - δ_{il} δ_{jk}`.

`‖φ_{ij}‖ = 1` at `i ≠ j` is its diagonal case, which [B1](Bivectors.lean)
proved separately; this gives the whole table. -/
theorem inner2_phi (i j k l : ι) :
    inner2 (phi i j) (phi k l)
      = (if i = k then (1:ℚ) else 0) * (if j = l then 1 else 0)
        - (if i = l then (1:ℚ) else 0) * (if j = k then 1 else 0) := by
  unfold phi
  rw [inner2_sub_left, inner2_sub_right, inner2_sub_right,
    inner2_single, inner2_single, inner2_single, inner2_single]
  by_cases h1 : i = k <;> by_cases h2 : j = l <;> by_cases h3 : i = l <;>
    by_cases h4 : j = k <;> simp_all <;> ring

/-- **Distinct pairs are orthogonal** unless one is the other swapped. -/
theorem inner2_phi_of_ne {i j k l : ι} (h1 : ¬(i = k ∧ j = l)) (h2 : ¬(i = l ∧ j = k)) :
    inner2 (phi i j) (phi k l) = 0 := by
  rw [inner2_phi]
  rcases not_and_or.mp h1 with ha | ha <;> rcases not_and_or.mp h2 with hb | hb <;>
    simp [ha, hb]


/-- **PAIRING A SKEW MATRIX AGAINST A BASIS BIVECTOR READS OFF ITS ENTRY**, `⟨Y, φ_ij⟩ = -Y_ij`.
*The real layer has carried this as `inner2_phi` in [WeylReal.lean](WeylReal.lean); this file's own
`inner2_phi` is the FOUR-INDEX pairing of two basis bivectors, a different statement under the same
name in a different namespace.* -/
theorem inner2_phi_skew (Y : Matrix ι ι ℚ) (hY : IsSkew Y) (i j : ι) :
    inner2 Y (phi i j) = - Y i j := by
  have hji : Y j i = - Y i j := by
    have := congrFun (congrFun hY i) j
    simpa [Matrix.transpose_apply] using this
  rw [inner2_eq_sum]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, mul_sub, Finset.sum_sub_distrib]
  simp [ite_and, Finset.sum_ite_eq, hji]
  ring

/-- **A BIVECTOR IS ITS OWN COORDINATE EXPANSION**, with the ordered-pair `½`. *Ported from
[WeylReal.lean](WeylReal.lean), proof unchanged.* -/
theorem skew_expand (Y : Matrix ι ι ℚ) (hY : IsSkew Y) :
    (1/2 : ℚ) • (∑ i : ι, ∑ j : ι, (inner2 Y (phi i j)) • phi i j) = Y := by
  have hji : ∀ i j : ι, Y j i = - Y i j := by
    intro i j
    have := congrFun (congrFun hY i) j
    simpa [Matrix.transpose_apply] using this
  ext a b
  rw [Matrix.smul_apply]
  rw [show ((∑ i : ι, ∑ j : ι, (inner2 Y (phi i j)) • phi i j) a b)
        = ∑ i : ι, ∑ j : ι, (inner2 Y (phi i j)) * (phi i j a b) by
      simp [Matrix.sum_apply, Matrix.smul_apply]]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply]
  simp [ite_and, Finset.sum_ite_eq, Finset.sum_sub_distrib, mul_sub]
  have h1 : inner2 Y (phi b a) = - Y b a := inner2_phi_skew Y hY b a
  have h2 : inner2 Y (phi a b) = - Y a b := inner2_phi_skew Y hY a b
  simp only [phi] at h1 h2
  rw [h1, h2]
  linarith [hji a b]

/-- **THE ORDERED-PAIR DOUBLING**: the squared coordinates of a bivector sum to twice its norm. -/
theorem sum_inner2_sq (Y : Matrix ι ι ℚ) (hY : IsSkew Y) :
    ∑ i : ι, ∑ j : ι, (inner2 Y (phi i j))^2 = 2 * inner2 Y Y := by
  have hc : ∀ i j : ι, (inner2 Y (phi i j))^2 = (Y i j)^2 := by
    intro i j; rw [inner2_phi_skew Y hY i j]; ring
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hc i j, inner2_eq_sum]
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  have hba : Y b a = - Y a b := by
    have := congrFun (congrFun hY a) b
    simpa [Matrix.transpose_apply] using this
  rw [hba]; ring

end HamiltonsCubic.Base
