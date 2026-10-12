import HamiltonsCubic.Results.L57OddEq
import HamiltonsCubic.Results.L2Operators

set_option linter.style.longLine false

/-!
# L57's bound is attained, at both parities

The converse half of L57's equality clause: the sphere product at the extremal split attains the bound
([SphereValue.lean](../Base/SphereValue.lean)'s `theta_sphereProduct_value` with
[Families.lean](../Base/Families.lean)'s split identities):

- `L57_attained_even`: at `n = 2m`, a unit multiple of `sphereWeight` on `m` indices has
  `θ = √(2(n−1)(n−2))/n`, which is `Θₙ`;
- `L57_attained_odd`: at `n = 2m + 1`, a unit multiple of `sphereWeight` on `m` indices has
  `θ = √(thetaOddSq n)`, which is `Θₙ`.

With [L57OddEq.lean](L57OddEq.lean) and [L57Equality.lean](L57Equality.lean) this makes the equality
case of L57 two-sided.
-/

namespace HamiltonsCubic.L57Critical

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L2Operators

theorem thetaOddSq_eq (n : ℝ) : thetaOddSq n = ThetaSqOdd n := by
  unfold thetaOddSq ThetaSqOdd; ring

/-- **Attainment at odd `n = 2m + 1`.** -/
theorem L57_attained_odd (m : ℕ) (hm : 2 ≤ m) :
    ∃ (S : Finset (Fin (2 * m + 1))) (t : ℝ), 0 < t ∧ normSq (diagOp (t • sphereWeight S)) = 1 ∧
      theta (diagOp (t • sphereWeight S)) = Real.sqrt (thetaOddSq ((2 * m + 1 : ℕ) : ℝ)) := by
  have hle : m ≤ 2 * m + 1 := by omega
  have hS : (firstP (2 * m + 1) m).card = m := card_firstP hle
  have hSc : (firstP (2 * m + 1) m)ᶜ.card = m + 1 := by rw [card_compl_firstP hle]; omega
  have hp : 2 ≤ (firstP (2 * m + 1) m).card := by rw [hS]; exact hm
  have hq : 2 ≤ (firstP (2 * m + 1) m)ᶜ.card := by rw [hSc]; omega
  obtain ⟨t, ht, hn⟩ := sphere_unit (firstP (2 * m + 1) m) hp hq
  refine ⟨firstP (2 * m + 1) m, t, ht, hn, ?_⟩
  rw [theta_sphereProduct_value _ hp hq t ht hn, hS, hSc, thetaSplit]
  congr 1
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast hm
  rw [thetaOddSq_eq]
  push_cast
  have := thetaSplitSq_odd (m : ℝ) (by positivity) (by positivity) (by linarith)
  rw [this]

/-- **Attainment at even `n = 2m`.** -/
theorem L57_attained_even (m : ℕ) (hm : 2 ≤ m) :
    ∃ (S : Finset (Fin (2 * m))) (t : ℝ), 0 < t ∧ normSq (diagOp (t • sphereWeight S)) = 1 ∧
      theta (diagOp (t • sphereWeight S))
        = Real.sqrt (2 * (((2 * m : ℕ) : ℝ) - 1) * (((2 * m : ℕ) : ℝ) - 2)) / ((2 * m : ℕ) : ℝ) := by
  have hle : m ≤ 2 * m := by omega
  have hS : (firstP (2 * m) m).card = m := card_firstP hle
  have hSc : (firstP (2 * m) m)ᶜ.card = m := by rw [card_compl_firstP hle]; omega
  have hp : 2 ≤ (firstP (2 * m) m).card := by rw [hS]; exact hm
  have hq : 2 ≤ (firstP (2 * m) m)ᶜ.card := by rw [hSc]; exact hm
  obtain ⟨t, ht, hn⟩ := sphere_unit (firstP (2 * m) m) hp hq
  refine ⟨firstP (2 * m) m, t, ht, hn, ?_⟩
  rw [theta_sphereProduct_value _ hp hq t ht hn, hS, hSc, thetaSplit]
  have hmR : (2 : ℝ) ≤ m := by exact_mod_cast hm
  rw [thetaSplitSq_balanced (m : ℝ) (by positivity) (by linarith)]
  unfold theta0Sq
  push_cast
  have hpos : (0 : ℝ) < 2 * m := by positivity
  rw [Real.sqrt_div' _ (by positivity), Real.sqrt_sq hpos.le]
