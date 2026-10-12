import HamiltonsCubic.Results.L57Attain

set_option linter.style.longLine false

/-!
# L16: `Θₙ` is the sphere-product maximum, at both parities

[findings/problem.md](../../../findings/problem.md) (the L16 discussion, "the sphere-product maximum is `Θₙ`") uses
among the unit sphere products `S^p × S^q`, `p + q = n`, the largest `θ` is `Θₙ`, the `(m, m+1)` split at odd `n` and
the balanced split at even `n`.

- `thetaSplitSq_le_odd`, `thetaSplitSq_le_even`: **`θ²_{p,q} ≤ Θₙ²`** for all integers `p, q ≥ 2` with `p + q = n`, from
  `θ²_{p,q} = 2(n−1)/(n−2) · (1 − (n−1)/(pq))` increasing in `pq` and `pq ≤ (n² − 1)/4`, respectively `n²/4`;
- `sphere_theta_le_odd`, `sphere_theta_le_even`: **every unit sphere product has `θ ≤ Θₙ`**, with equality at the
  extremal split by [L57Attain.lean](L57Attain.lean).
-/

namespace HamiltonsCubic.L57Critical

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

/-- `θ²_{p,q}` in terms of `pq`. -/
theorem thetaSplitSq_pq (p q : ℝ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    thetaSplitSq p q = 2 * (p + q - 1) / (p + q - 2) * (1 - (p + q - 1) / (p * q)) := by
  unfold thetaSplitSq
  have : p + q - 2 ≠ 0 := by linarith
  have : p * q ≠ 0 := by positivity
  field_simp; ring

/-- The bound from `pq ≤ B`. -/
theorem thetaSplitSq_le_of_pq (p q B : ℝ) (hp : 2 ≤ p) (hq : 2 ≤ q) (hB : p * q ≤ B) :
    thetaSplitSq p q ≤ 2 * (p + q - 1) / (p + q - 2) * (1 - (p + q - 1) / B) := by
  rw [thetaSplitSq_pq p q hp hq]
  have hpq : 0 < p * q := by positivity
  have hc : 0 ≤ 2 * (p + q - 1) / (p + q - 2) := div_nonneg (by linarith) (by linarith)
  apply mul_le_mul_of_nonneg_left _ hc
  have : (p + q - 1) / B ≤ (p + q - 1) / (p * q) :=
    div_le_div_of_nonneg_left (by linarith) hpq hB
  linarith

/-- **At odd `n = p + q`, `θ²_{p,q} ≤ Θₙ²`.** -/
theorem thetaSplitSq_le_odd (p q : ℕ) (hp : 2 ≤ p) (hq : 2 ≤ q) (hodd : ¬ Even (p + q)) :
    thetaSplitSq (p : ℝ) (q : ℝ) ≤ ThetaSqOdd ((p + q : ℕ) : ℝ) := by
  have hZ : (4 * ((p : ℤ) * q)) ≤ ((p : ℤ) + q) ^ 2 - 1 := by
    have hne : (p : ℤ) - q ≠ 0 := by intro h; apply hodd; exact ⟨p, by omega⟩
    have h1 : 1 ≤ ((p : ℤ) - q) ^ 2 := by
      have := Int.one_le_abs hne
      nlinarith [sq_abs ((p : ℤ) - q), abs_nonneg ((p : ℤ) - q)]
    nlinarith
  have hpR : (2 : ℝ) ≤ p := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ q := by exact_mod_cast hq
  have hB : (p : ℝ) * q ≤ (((p : ℝ) + q) ^ 2 - 1) / 4 := by
    have := (Int.cast_le (R := ℝ)).mpr hZ
    push_cast at this
    linarith
  refine le_trans (thetaSplitSq_le_of_pq _ _ _ hpR hqR hB) (le_of_eq ?_)
  unfold ThetaSqOdd; push_cast
  have : (p : ℝ) + q - 2 ≠ 0 := by linarith
  have : (p : ℝ) + q + 1 ≠ 0 := by linarith
  have : ((p : ℝ) + q) ^ 2 - 1 ≠ 0 := by nlinarith
  field_simp; ring

/-- **At even `n = p + q`, `θ²_{p,q} ≤ θ₀(n)²`.** -/
theorem thetaSplitSq_le_even (p q : ℕ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    thetaSplitSq (p : ℝ) (q : ℝ) ≤ theta0Sq ((p + q : ℕ) : ℝ) := by
  have hpR : (2 : ℝ) ≤ p := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ q := by exact_mod_cast hq
  have hB : (p : ℝ) * q ≤ ((p : ℝ) + q) ^ 2 / 4 := by nlinarith [sq_nonneg ((p : ℝ) - q)]
  refine le_trans (thetaSplitSq_le_of_pq _ _ _ hpR hqR hB) (le_of_eq ?_)
  unfold theta0Sq; push_cast
  have : (p : ℝ) + q - 2 ≠ 0 := by linarith
  have : (p : ℝ) + q ≠ 0 := by linarith
  field_simp; ring

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Every unit sphere product has `θ ≤ Θₙ` at odd `n`.** -/
theorem sphere_theta_le_odd (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) (hodd : ¬ Even (Fintype.card ι)) :
    theta (diagOp (t • sphereWeight T)) ≤ Real.sqrt (ThetaSqOdd (Fintype.card ι : ℝ)) := by
  have htot : T.card + Tᶜ.card = Fintype.card ι := (Finset.card_add_card_compl T).trans Finset.card_univ
  rw [theta_sphereProduct_value T hp hq t ht hn, thetaSplit, ← htot]
  exact Real.sqrt_le_sqrt (thetaSplitSq_le_odd _ _ hp hq (by rw [htot]; exact hodd))

/-- **Every unit sphere product has `θ ≤ θ₀(n)`**, which is `Θₙ` at even `n`. -/
theorem sphere_theta_le_even (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) :
    theta (diagOp (t • sphereWeight T)) ≤ Real.sqrt (theta0Sq (Fintype.card ι : ℝ)) := by
  have htot : T.card + Tᶜ.card = Fintype.card ι := (Finset.card_add_card_compl T).trans Finset.card_univ
  rw [theta_sphereProduct_value T hp hq t ht hn, thetaSplit, ← htot]
  exact Real.sqrt_le_sqrt (thetaSplitSq_le_even _ _ hp hq)

end HamiltonsCubic.L57Critical
