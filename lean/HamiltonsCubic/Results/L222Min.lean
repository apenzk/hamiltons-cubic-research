import Mathlib
import HamiltonsCubic.Results.L222Rot
import HamiltonsCubic.Results.L224EqRot
import HamiltonsCubic.Results.PairNorm

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L222 item 5 at a minimising angle: `⟨x, K_{j·} − K_{k·}⟩ = 0` and `‖ν‖² ≤ ½ Σ (K_{ka} − K_{ja})²`

[findings/second-order.md](../../../findings/second-order.md), Lemma L222, item 5: *At an angle of the $(j,k)$-rotation minimising
$\lVert\nu\rVert^2$, with $D$, $K$ and $x$ those of the rotated tensor: $\langle x,K_{j\cdot}-K_{k\cdot}\rangle=0$, and
$\lVert\nu\rVert^2\le\tfrac12\sum_a(K_{ka}-K_{ja})^2$.* [L222Rot.lean](L222Rot.lean)'s rotation turns the pair part `ν_x` of
`W = coordOp w + ν_x` into `2cs ν_y + (c² − s²) ν_x`, `y_a = (w_{ja} − w_{ka})/2`. At an angle minimising `‖ν‖²` every such rotation has
`‖ν_x‖² ≤ ‖2cs ν_y + (c² − s²) ν_x‖²`, which is the hypothesis `hmin` below:

* **`min_angle_real`**: `X ≤ C²X + S²Y + 2CSZ` at every unit `(C, S)` forces `Z = 0` and `X ≤ Y`;
* `nuX_add`, `vy_add`, `vy_vy`: `ν_x` is additive, `vy` additive and idempotent;
* **`L222_min`**: at `hmin`, `Σ_a x_a (w_{ja} − w_{ka}) = 0` and `‖ν_x‖² ≤ ½ Σ_{a ∉ {j,k}} (w_{ka} − w_{ja})²`, through
  `double_angle` and `normSq2_nuX`.

The identification of `2cs ν_y + (c² − s²) ν_x` with the pair part of the rotated tensor is typed in [L222MinW.lean](L222MinW.lean):
`rot_formula`, `pair_part_unique` and `hmin_iff`.
-/

namespace HamiltonsCubic.L222Min

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L224EqRot HamiltonsCubic.L224Step4

variable {n : ℕ} {j k : Fin n}

/-- **The minimising angle, as arithmetic.** -/
theorem min_angle_real {X Y Z : ℝ} (h : ∀ C S : ℝ, C ^ 2 + S ^ 2 = 1 → X ≤ C ^ 2 * X + S ^ 2 * Y + 2 * C * S * Z) :
    Z = 0 ∧ X ≤ Y := by
  have hXY : X ≤ Y := by have := h 0 1 (by norm_num); linarith
  refine ⟨?_, hXY⟩
  -- at `(C, S) = ((1 − t²)/(1 + t²), 2t/(1 + t²))`: `0 ≤ t (Y − X) + (1 − t²) Z` for every `t`
  have key : ∀ t : ℝ, 0 ≤ t * (t * (Y - X) + (1 - t ^ 2) * Z) := by
    intro t
    have hd : (0 : ℝ) < 1 + t ^ 2 := by positivity
    have hu : ((1 - t ^ 2) / (1 + t ^ 2)) ^ 2 + (2 * t / (1 + t ^ 2)) ^ 2 = 1 := by
      field_simp; ring
    have h1 := h _ _ hu
    have e : ((1 - t ^ 2) / (1 + t ^ 2)) ^ 2 * X + (2 * t / (1 + t ^ 2)) ^ 2 * Y
        + 2 * ((1 - t ^ 2) / (1 + t ^ 2)) * (2 * t / (1 + t ^ 2)) * Z - X
        = 4 * (t * (t * (Y - X) + (1 - t ^ 2) * Z)) / (1 + t ^ 2) ^ 2 := by
      field_simp; ring
    have h2 : 0 ≤ 4 * (t * (t * (Y - X) + (1 - t ^ 2) * Z)) / (1 + t ^ 2) ^ 2 := by rw [← e]; linarith
    have h3 : 0 ≤ 4 * (t * (t * (Y - X) + (1 - t ^ 2) * Z)) := by
      have := mul_nonneg h2 (le_of_lt (by positivity : (0 : ℝ) < (1 + t ^ 2) ^ 2))
      rwa [div_mul_cancel₀ _ (by positivity)] at this
    linarith
  -- `t → 0` from both sides
  by_contra hZ
  set B := |Y - X| + 1 with hB
  have hB0 : 0 < B := by positivity
  set t := min (1 / 2) (|Z| / (4 * B)) with htdef
  have hZa : 0 < |Z| := abs_pos.mpr hZ
  have ht0 : 0 < t := lt_min (by norm_num) (by positivity)
  have ht1 : t ≤ 1 / 2 := min_le_left _ _
  have ht2 : t ≤ |Z| / (4 * B) := min_le_right _ _
  have htB : t * B ≤ |Z| / 4 := by
    have := mul_le_mul_of_nonneg_right ht2 hB0.le
    rwa [div_mul_eq_mul_div, mul_div_mul_right _ _ hB0.ne'] at this
  have hk1 := key t
  have hk2 := key (-t)
  have e1 : 0 ≤ t * (Y - X) + (1 - t ^ 2) * Z := by
    have := hk1; exact nonneg_of_mul_nonneg_right (by linarith) ht0
  have e2 : (-t) * (Y - X) + (1 - t ^ 2) * Z ≤ 0 := by
    have : 0 ≤ (-t) * ((-t) * (Y - X) + (1 - (-t) ^ 2) * Z) := hk2
    rw [neg_sq] at this
    nlinarith
  have habs : |t * (Y - X)| ≤ t * B := by
    rw [abs_mul, abs_of_pos ht0]; exact mul_le_mul_of_nonneg_left (by linarith [hB]) ht0.le
  have hts : 3 / 4 ≤ 1 - t ^ 2 := by nlinarith
  rcases lt_or_gt_of_ne hZ with hneg | hpos
  · have hZab : |Z| = -Z := abs_of_neg hneg
    have hA : 3 / 4 * (-Z) ≤ (1 - t ^ 2) * (-Z) := mul_le_mul_of_nonneg_right hts (by linarith)
    have hB' := le_abs_self (t * (Y - X))
    nlinarith [hA, hB', habs, htB, e1, hZab]
  · have hZab : |Z| = Z := abs_of_pos hpos
    have hA : 3 / 4 * Z ≤ (1 - t ^ 2) * Z := mul_le_mul_of_nonneg_right hts hpos.le
    have hB' := le_abs_self (t * (Y - X))
    nlinarith [hA, hB', habs, htB, e2, hZab]

theorem vy_vy (y : Fin n → ℝ) : vy j k (vy j k y) = vy j k y := by
  funext i; unfold vy; split_ifs <;> rfl

theorem vy_add (y y' : Fin n → ℝ) : vy j k (y + y') = vy j k y + vy j k y' := by
  funext i; simp only [vy, Pi.add_apply]; split_ifs <;> ring

theorem nuX_add (x x' : Fin n → ℝ) : nuX j k (x + x') = nuX j k x + nuX j k x' := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  unfold nuX
  show _ = ((sandOp (Smat j k) (diagonal (vy j k x)) (Smat_T j k) (diag_T _) X
    + sandOp (Smat j k) (diagonal (vy j k x')) (Smat_T j k) (diag_T _) X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
  have hd : diagonal (vy j k x + vy j k x') = diagonal (vy j k x) + diagonal (vy j k x') := by
    ext a b; simp only [diagonal_apply, Matrix.add_apply, Pi.add_apply]; split_ifs <;> simp
  rw [Submodule.coe_add, sandOp_coe, sandOp_coe, sandOp_coe, vy_add, hd]
  simp only [Matrix.add_mul, Matrix.mul_add]
  abel

/-- **L222 item 5 at a minimising angle.** -/
theorem L222_min (hjk : j ≠ k) (w : Matrix (Fin n) (Fin n) ℝ) {x : Fin n → ℝ} (hxj : x j = 0) (hxk : x k = 0)
    (hxs : ∑ i, x i = 0) (hys : ∑ c, vy j k (fun a => (w j a - w k a) / 2) c = 0)
    (hmin : ∀ c s : ℝ, c ^ 2 + s ^ 2 = 1 →
      normSq2 (nuX j k x) ≤ normSq2 ((2 * c * s) • nuX j k (fun a => (w j a - w k a) / 2) + (c ^ 2 - s ^ 2) • nuX j k x)) :
    ∑ a, x a * (w j a - w k a) = 0 ∧
      normSq2 (nuX j k x) ≤ 1 / 2 * ∑ a, vy j k (fun a => w k a - w j a) a ^ 2 := by
  set y : Fin n → ℝ := fun a => (w j a - w k a) / 2 with hydef
  set yv := vy j k y with hyv
  have hxv : vy j k x = x := HamiltonsCubic.PairIdent.vy_of_zero x hxj hxk
  have hny : nuX j k y = nuX j k yv := by unfold nuX; simp only [hyv, vy_vy]
  -- the combination is one `ν`
  have hcomb : ∀ a b : ℝ, a • nuX j k y + b • nuX j k x = nuX j k (a • yv + b • x) := by
    intro a b
    rw [hny, nuX_add, nuX_smul, nuX_smul]
  have hsum : ∀ a b : ℝ, ∑ c, vy j k (a • yv + b • x) c = 0 := by
    intro a b
    rw [vy_add, vy_smul, vy_smul, hyv, vy_vy, hxv]
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, Finset.sum_add_distrib, ← Finset.mul_sum, hxs]
    rw [hyv] at hys
    rw [hys]; ring
  have hnorm : ∀ a b : ℝ, normSq2 (nuX j k (a • yv + b • x))
      = a ^ 2 * (2 * ∑ c, yv c ^ 2) + b ^ 2 * (2 * ∑ c, x c ^ 2) + 2 * a * b * (2 * ∑ c, x c * yv c) := by
    intro a b
    rw [HamiltonsCubic.PairNorm.normSq2_nuX hjk _ (hsum a b), vy_add, vy_smul, vy_smul, hyv, vy_vy, hxv]
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun c _ => ?_
    ring
  have hX : normSq2 (nuX j k x) = 2 * ∑ c, x c ^ 2 := by
    rw [HamiltonsCubic.PairNorm.normSq2_nuX hjk x (by rw [hxv]; exact hxs), hxv]
  have h : ∀ C S : ℝ, C ^ 2 + S ^ 2 = 1 →
      2 * ∑ c, x c ^ 2 ≤ C ^ 2 * (2 * ∑ c, x c ^ 2) + S ^ 2 * (2 * ∑ c, yv c ^ 2) + 2 * C * S * (2 * ∑ c, x c * yv c) := by
    intro C S hCS
    obtain ⟨c, s, hcs, hp, hq⟩ := HamiltonsCubic.L224EqRot.double_angle hCS
    have := hmin c s hcs
    rw [hcomb, hnorm, hX, hp, hq] at this
    linarith
  obtain ⟨hZ, hXY⟩ := min_angle_real h
  have hyv_val : ∀ c, c ≠ j → c ≠ k → yv c = (w j c - w k c) / 2 := by
    intro c h1 h2; simp [hyv, hydef, vy, h1, h2]
  have hyj : yv j = 0 := by simp [hyv, vy]
  have hyk : yv k = 0 := by simp [hyv, vy]
  refine ⟨?_, ?_⟩
  · have e : ∑ a, x a * (w j a - w k a) = 2 * ∑ c, x c * yv c := by
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun c _ => ?_
      by_cases h1 : c = j
      · subst h1; rw [hxj]; ring
      · by_cases h2 : c = k
        · subst h2; rw [hxk]; ring
        · rw [hyv_val c h1 h2]; ring
    rw [e]; linarith
  · rw [hX]
    have e : ∑ a, vy j k (fun a => w k a - w j a) a ^ 2 = 4 * ∑ c, yv c ^ 2 := by
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun c _ => ?_
      by_cases h1 : c = j
      · subst h1; rw [hyj]; simp [vy]
      · by_cases h2 : c = k
        · subst h2; rw [hyk]; simp [vy]
        · rw [hyv_val c h1 h2]; simp only [vy, h1, h2, or_self, if_false]; ring
    rw [e]; linarith
end HamiltonsCubic.L222Min
