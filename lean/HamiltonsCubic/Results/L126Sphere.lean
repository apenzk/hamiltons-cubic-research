import HamiltonsCubic.Results.L57Attain
import HamiltonsCubic.Results.L130Statement

set_option linter.style.longLine false

/-!
# L126: at `S^p × S^q` the four-set threshold `Σ = θ²` is `1/(p−1) + 1/(q−1) = 1`

[findings/second-order.md](../../../findings/second-order.md), Lemma L126: *at `S^p × S^q` the nonzero four-set blocks
are the `(2,2)`-splits, with the common value `μ_{p,q} = (n−2)/(2(p−1)(q−1))`, and
`μ_{p,q} = ½ ⟺ 1/(p−1) + 1/(q−1) = 1 ⟺ (p, q) = (3, 3)`.* The block meets the `½`-eigenspace of `L_e` exactly when
`Σ_{ijkl} = θ²` ([L121](../../../findings/second-order.md)), `Σ = A² + B² + C² − AB − BC − CA` with `A, B, C` the
opposite-pair sums.

- `fourSet_sigma`: **at a unit sphere product and a `(2,2)`-split four-subset, `Σ/θ² = ((n−2)/((p−1)(q−1)))²`**, so the
  `L_e`-value `½√Σ/θ` is `μ_{p,q}`;
- `L126_threshold`: **`Σ = θ² ⟺ 1/(p−1) + 1/(q−1) = 1`**, which [L126.lean](L126.lean) resolves to `(p, q) = (3, 3)`.
-/

namespace HamiltonsCubic.L57Critical

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The four-set sum at a `(2,2)`-split of a unit sphere product**: `Σ/θ² = ((n−2)/((p−1)(q−1)))²`. -/
theorem fourSet_sigma (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) (i j k l : ι) (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T) (hl : l ∉ T)
    (hij : i ≠ j) (hkl : k ≠ l) :
    let w := t • sphereWeight T
    let A := w i j + w k l
    let B := w i k + w j l
    let C := w i l + w j k
    let p : ℝ := T.card
    let q : ℝ := Tᶜ.card
    A ^ 2 + B ^ 2 + C ^ 2 - A * B - B * C - C * A
      = ((p + q - 2) / ((p - 1) * (q - 1))) ^ 2 * theta (diagOp w) ^ 2 := by
  intro w A B C p q
  have hpR : (2 : ℝ) ≤ p := by show (2 : ℝ) ≤ (T.card : ℝ); exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ q := by show (2 : ℝ) ≤ (Tᶜ.card : ℝ); exact_mod_cast hq
  have hp1 : p - 1 ≠ 0 := by linarith
  have hq1 : q - 1 ≠ 0 := by linarith
  have hpq2 : p + q - 2 ≠ 0 := by linarith
  have hpq1 : p + q - 1 ≠ 0 := by linarith
  have hp0 : p ≠ 0 := by linarith
  have hq0 : q ≠ 0 := by linarith
  -- the entries
  have hwij : w i j = t * (q / (p - 1)) := by
    show t * sphereWeight T i j = _; rw [sphereWeight_in T hi hj hij]
  have hwkl : w k l = t * (p / (q - 1)) := by
    show t * sphereWeight T k l = _; rw [sphereWeight_out T hk hl hkl]
  have hwx : ∀ a b, a ∈ T → b ∉ T → w a b = -t := fun a b ha hb => by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_cross T ha hb]; ring
  have hB : B = -2 * t := by
    simp only [B]; rw [hwx i k hi hk, hwx j l hj hl]; ring
  have hC : C = -2 * t := by
    simp only [C]; rw [hwx i l hi hl, hwx j k hj hk]; ring
  have hA : A = t * (q / (p - 1) + p / (q - 1)) := by
    simp only [A]; rw [hwij, hwkl]; ring
  -- `t²` from the unit norm
  have hsum := HamiltonsCubic.L130Statement.sphereWeight_sumSq T hp hq
  have hnorm := diagOp_normSq w (fun a b => by
      simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_symm T a b])
    (fun a => by simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_hollow T a, mul_zero])
  rw [hn] at hnorm
  have ht2 : t ^ 2 * (p * q * (p + q - 1) * (p + q - 2) / ((p - 1) * (q - 1))) = 2 := by
    have e : ∑ a, ∑ b, w a b ^ 2 = t ^ 2 * ∑ a, ∑ b, sphereWeight T a b ^ 2 := by
      simp only [w, Matrix.smul_apply, smul_eq_mul, mul_pow, Finset.mul_sum]
    rw [e, hsum] at hnorm
    linarith
  -- `θ² = thetaSplitSq p q`
  have hθ : theta (diagOp w) ^ 2 = thetaSplitSq p q := by
    rw [show w = t • sphereWeight T from rfl, theta_sphereProduct_value T hp hq t ht hn, thetaSplit,
      Real.sq_sqrt]
    unfold thetaSplitSq
    apply div_nonneg
    · have : 0 ≤ p - 1 := by linarith
      have : 0 ≤ q - 1 := by linarith
      have : 0 ≤ p + q - 1 := by linarith
      positivity
    · have h2 : 0 ≤ p + q - 2 := by linarith
      exact mul_nonneg h2 (mul_nonneg (by linarith) (by linarith))
  rw [hθ, hA, hB, hC]
  unfold thetaSplitSq
  have hX : p * q * (p + q - 1) * (p + q - 2) / ((p - 1) * (q - 1)) ≠ 0 := by
    apply div_ne_zero
    · exact mul_ne_zero (mul_ne_zero (mul_ne_zero hp0 hq0) hpq1) hpq2
    · exact mul_ne_zero hp1 hq1
  have ht2' : t ^ 2 = 2 / (p * q * (p + q - 1) * (p + q - 2) / ((p - 1) * (q - 1))) := by
    rw [eq_div_iff hX]; exact ht2
  have e : (t * (q / (p - 1) + p / (q - 1))) ^ 2 + (-2 * t) ^ 2 + (-2 * t) ^ 2
      - t * (q / (p - 1) + p / (q - 1)) * (-2 * t) - (-2 * t) * (-2 * t)
      - (-2 * t) * (t * (q / (p - 1) + p / (q - 1)))
      = t ^ 2 * (q / (p - 1) + p / (q - 1) + 2) ^ 2 := by ring
  rw [e, ht2']
  field_simp
  ring

/-- **L126's threshold at a sphere product**: `Σ = θ² ⟺ 1/(p−1) + 1/(q−1) = 1`. -/
theorem L126_threshold (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) (i j k l : ι) (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T) (hl : l ∉ T)
    (hij : i ≠ j) (hkl : k ≠ l) :
    let w := t • sphereWeight T
    let A := w i j + w k l
    let B := w i k + w j l
    let C := w i l + w j k
    A ^ 2 + B ^ 2 + C ^ 2 - A * B - B * C - C * A = theta (diagOp w) ^ 2 ↔
      1 / ((T.card : ℝ) - 1) + 1 / ((Tᶜ.card : ℝ) - 1) = 1 := by
  intro w A B C
  have h := fourSet_sigma T hp hq t ht hn i j k l hi hj hk hl hij hkl
  simp only at h
  rw [h]
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  set p : ℝ := (T.card : ℝ)
  set q : ℝ := (Tᶜ.card : ℝ)
  have hθ0 : 0 < theta (diagOp w) := by
    rw [show w = t • sphereWeight T from rfl, theta_sphereProduct_value T hp hq t ht hn, thetaSplit]
    apply Real.sqrt_pos.mpr
    unfold thetaSplitSq
    apply div_pos
    · have : 0 < p - 1 := by linarith
      have : 0 < q - 1 := by linarith
      have : 0 < p + q - 1 := by linarith
      positivity
    · have : 0 < p + q - 2 := by linarith
      positivity
  have hθ2 : 0 < theta (diagOp w) ^ 2 := by positivity
  have hp1 : 0 < p - 1 := by linarith
  have hq1 : 0 < q - 1 := by linarith
  constructor
  · intro h1
    have hr : ((p + q - 2) / ((p - 1) * (q - 1))) ^ 2 = 1 := by
      have := mul_right_cancel₀ hθ2.ne' (h1.trans (one_mul _).symm)
      exact this
    have hr' : (p + q - 2) / ((p - 1) * (q - 1)) = 1 := by
      have hpos : 0 < (p + q - 2) / ((p - 1) * (q - 1)) := by
        apply div_pos (by linarith) (by positivity)
      nlinarith [sq_nonneg ((p + q - 2) / ((p - 1) * (q - 1)) - 1)]
    rw [div_eq_one_iff_eq (by positivity)] at hr'
    field_simp; linarith
  · intro h1
    have hr' : (p + q - 2) / ((p - 1) * (q - 1)) = 1 := by
      rw [div_eq_one_iff_eq (by positivity)]
      field_simp at h1; linarith
    rw [hr']; ring

end HamiltonsCubic.L57Critical
