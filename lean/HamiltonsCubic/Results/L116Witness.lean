import HamiltonsCubic.Results.L116Statement

set_option linter.style.longLine false

/-!
# L116's `n = 4` witness: without first Bianchi, `b(R^#) = -b(R²)` fails

[findings/bounds-relaxations.md](../../../findings/bounds-relaxations.md), Lemma L116, proved on `S²_B` in
[L116Statement.lean](L116Statement.lean) as `L116`. **Bianchi is load-bearing**, and a rank-one operator shows it:

* **`sharp_rankOne`**: `(v ⊗ v)^# = 0` for every bivector `v`, the two terms of Böhm–Wilking's (4) being one product
  of the same two sums;
* **`comp_rankOne`**: `(v ⊗ v)² = ½|v|²_F (v ⊗ v)`;
* **`witness`**: at `n = 4` and `v = e₁₂ + e₃₄`, `b(R^#)_{0123} = 0` while `-b(R²)_{0123} = -2`, so the identity fails
  at `R = v ⊗ v`, which violates first Bianchi (`b(R)_{0123} = (v ∧ v)_{0123} = 1`).
-/

namespace HamiltonsCubic.L116Statement

open Finset

variable {n : ℕ}

/-- **`(v ⊗ v)^# = 0`.** -/
theorem sharp_rankOne (v : Bivector n) : sharp (rankOne v) = 0 := by
  funext i j k l
  simp only [sharp, rankOne, Pi.zero_apply]
  have : ∀ p q, v i p * v k q * (v j p * v l q) - v i p * v l q * (v j p * v k q) = 0 := fun p q => by ring
  simp [this]

/-- **`(v ⊗ v)² = ½|v|²_F (v ⊗ v)`.** -/
theorem comp_rankOne (v : Bivector n) (i j k l : Fin n) :
    comp (rankOne v) (rankOne v) i j k l = (1 / 2) * (∑ p, ∑ q, v p q * v p q) * rankOne v i j k l := by
  simp only [comp, rankOne]
  rw [mul_assoc]
  congr 1
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun p _ => ?_
  rw [Finset.sum_mul]
  exact Finset.sum_congr rfl fun q _ => by ring

/-- `v = e₁₂ + e₃₄` on `ℝ⁴`, indices `0, 1, 2, 3`. -/
def vW : Bivector 4 := fun i j =>
  if i = 0 ∧ j = 1 then 1 else if i = 1 ∧ j = 0 then -1 else
  if i = 2 ∧ j = 3 then 1 else if i = 3 ∧ j = 2 then -1 else 0

/-- **The witness**: at `R = vW ⊗ vW`, `b(R^#)_{0123} = 0 ≠ -2 = -b(R²)_{0123}`, and `R` violates first Bianchi. -/
theorem witness :
    bianchi (sharp (rankOne vW)) 0 1 2 3 = 0 ∧ -bianchi (comp (rankOne vW) (rankOne vW)) 0 1 2 3 = -2 ∧
      bianchi (rankOne vW) 0 1 2 3 = 1 := by
  refine ⟨by rw [sharp_rankOne]; simp [bianchi], ?_, ?_⟩
  · simp only [bianchi, comp_rankOne, rankOne, vW, Fin.sum_univ_four]
    simp
    norm_num
  · simp [bianchi, rankOne, vW]

/-- **So the identity needs first Bianchi**: it fails at `vW ⊗ vW`. -/
theorem not_identity_without_bianchi :
    bianchi (sharp (rankOne vW)) ≠ -bianchi (comp (rankOne vW) (rankOne vW)) := by
  intro h
  have := congrFun (congrFun (congrFun (congrFun h 0) 1) 2) 3
  obtain ⟨h1, h2, _⟩ := witness
  simp only [Pi.neg_apply] at this h2
  rw [h1, h2] at this
  norm_num at this

end HamiltonsCubic.L116Statement
