import HamiltonsCubic.Results.L74
import Mathlib.Tactic.FieldSimp

/-!
# L144, no DGK point lies in the band except the balanced product

[diagonal-half.md](../../../findings/diagonal-half.md)'s Observation L144. The arithmetic
checkable without the representation theory is here: the parameter set that kills the
parabola route, the imprimitive bound, and the shape of the primitive claim.

**The parabola counterexample is reproduced exactly**, through [L74](L74.lean)'s closed form
rather than by restating the block's decimal. At `(v, k, μ) = (100, 50, 1)` the graph identity
forces `λ = 2401/50`, which is **not an integer**, that is the whole point, since the
parabola route treats the parameters as continuous. There `θ² = 11647251/6250000 ≈ 1.8636`,
above `3/2`, so convexity in `μ` cannot be the proof and multiplicity integrality is what
carries it.

**One sentence in the block does not resolve.** It reads *"`θ < ½` for every primitive
strongly regular graph … and `¼` the sharp, never-attained supremum, which is what the
screened `0.4758` was approaching."* `0.4758` approaches `½`, not `¼`; and read instead as a
value of `θ²`, it **exceeds** the `¼` it is said to approach. Both readings are recorded
below as arithmetic; which was meant is not recoverable from the block.
-/

namespace HamiltonsCubic.DGKBand

open HamiltonsCubic.SRG

/-! ## The parameter set that kills the parabola route -/

/-- At `(v, k, μ) = (100, 50, 1)` the strongly-regular identity forces `λ = 2401/50`. -/
theorem parabola_lambda : (50 : ℚ) * (50 - 2401 / 50 - 1) = (100 - 50 - 1) * 1 := by
  norm_num

/-- **And that `λ` is not an integer**, so the parameter set is not a graph. The parabola
route reaches it only by treating the parameters as continuous. -/
theorem parabola_lambda_not_integer : ¬ ∃ z : ℤ, (z : ℚ) = 2401 / 50 := by
  rintro ⟨z, hz⟩
  have h50 : (50 : ℚ) * (z : ℚ) = 2401 := by rw [hz]; ring
  have : (50 : ℤ) * z = 2401 := by exact_mod_cast h50
  omega

/-- `λ ≥ 0` there, which is why the block calls the parameter set admissible to the
parabola argument. -/
theorem parabola_lambda_nonneg : (0 : ℚ) ≤ 2401 / 50 := by norm_num

/-- The numerator of [L74](L74.lean)'s closed form at these parameters, over `ℚ`:
`F/w² = 4851/50`. -/
theorem parabola_F_over_wsq :
    ((100 - 1 : ℚ) ^ 2 * (2401 / 50) + 2 * 50 * (100 - 1) - 50 ^ 2 * 100
      + (100 - 1 - 50) ^ 2) / (100 - 1 - 50 : ℚ) ^ 2 = 4851 / 50 := by
  norm_num

/-- **`θ² = 11647251/6250000` at the parabola point**, from `(F/w²)² · 2w/(vk(v-1))`. -/
theorem parabola_theta_sq :
    (4851 / 50 : ℚ) ^ 2 * (2 * (100 - 1 - 50) / (100 * 50 * (100 - 1)))
      = 11647251 / 6250000 := by
  norm_num

/-- **It exceeds `3/2`.** So `θ²` convex in `μ` at fixed `(n, k)` cannot be the proof, and
integrality of the multiplicities is the load-bearing hypothesis. -/
theorem parabola_exceeds : (3 : ℚ) / 2 < 11647251 / 6250000 := by norm_num

/-- The decimal the block prints, to the four places it prints. -/
theorem parabola_decimal :
    (18635 : ℚ) / 10000 < 11647251 / 6250000 ∧ (11647251 : ℚ) / 6250000 < 18637 / 10000 := by
  constructor <;> norm_num

/-! ## The imprimitive half -/

/-- **Every `g ≤ n/3` gives `θ² ≤ (n-1)(n-3)/n² < 1`**, so the imprimitive members below a
third of `n` are out of band with room to spare. -/
theorem imprimitive_bound (n : ℚ) (hn : 1 ≤ n) : (n - 1) * (n - 3) / n ^ 2 < 1 := by
  have hpos : 0 < n := by linarith
  rw [div_lt_one (by positivity)]
  nlinarith [hn]

/-- The gap is `(4n-3)/n²`, which is what "with room to spare" means quantitatively. -/
theorem imprimitive_gap (n : ℚ) (hn : n ≠ 0) :
    1 - (n - 1) * (n - 3) / n ^ 2 = (4 * n - 3) / n ^ 2 := by
  field_simp; ring

/-- *"Maximised uniquely at `g = n/2`"* needs `n` even, since `g` runs over **divisors** of
`n` with `g ≤ n/2`, at `n` odd there is no such divisor, and the largest available is at
most `n/3`. -/
theorem no_half_divisor_odd (n g : ℤ) (hodd : ¬ (2 ∣ n)) (hdvd : g ∣ n) : 2 * g ≠ n := by
  rintro rfl
  exact hodd ⟨g, rfl⟩

/-! ## The primitive half, and the sentence that does not resolve -/

/-- `θ < ½` and `θ² < ¼` are the same statement for `θ > 0`, so the two constants the block
names are consistent with each other. -/
theorem half_iff_quarter {θ : ℚ} (hθ : 0 < θ) : θ < 1 / 2 ↔ θ ^ 2 < 1 / 4 := by
  constructor <;> intro h <;> nlinarith [h, hθ]

/-- **Read as a value of `θ`, the screened `0.4758` approaches `½`**, it is within `0.0242`
of it. -/
theorem screened_near_half : (1 : ℚ) / 2 - 4758 / 10000 = 242 / 10000 := by norm_num

/-- **Read as a value of `θ²`, it exceeds the `¼` it is said to approach**, by a factor
above `1.9`. Under neither reading is `¼` what `0.4758` approaches. -/
theorem screened_above_quarter : (1 : ℚ) / 4 < 4758 / 10000 := by norm_num

theorem screened_ratio_to_quarter : (19 : ℚ) / 10 < (4758 / 10000) / (1 / 4) := by norm_num

/-- Conference graphs sit at the other end: `θ = 0` exactly, by
[L74](L74.lean)'s `conference_F_zero`, so they are the family the primitive bound is not
about. -/
theorem conference_theta_zero (s : ℤ) : F (4 * s + 1) (2 * s) (s - 1) = 0 :=
  conference_F_zero s

end HamiltonsCubic.DGKBand
