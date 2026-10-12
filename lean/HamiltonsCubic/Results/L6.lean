import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Data.Nat.Choose.Basic

/-!
# L6, the two defects, and what the codimension claim costs under each reading

[curvature-invariants.md](../../../findings/curvature-invariants.md)'s Conjecture L6, refuted at
Gate 2 as written. The geometry stays imported; the arithmetic each refutation turns on is here.

**The block conflates two defects, and one witness separates them.** It sits under the symmetry
defect `Δ = Σ ‖[ad(v_δ), W]‖²` and says *"the defect"*, while its quantitative claims are about
the Bianchi defect `δ² = ‖Alt(W₋)‖²`. Padded `W_{ℂP²}` has `Δ = 0` and `δ² = 1/9`, so the two
zero sets differ, and under the `Δ` reading the codimension claim is **false at `n = 4`**:
`codim = 4` against `C(4,4) = 1`.

**The codimension bound is free, and equality is a separate claim.** `F : 𝒲ₙ → Λ⁴` gives
`codim ≤ dim Λ⁴ = C(n,4)` for any map at all, since a rank never exceeds its codomain's
dimension. Equality is surjectivity of `dF`, and a rank strictly below the target dimension is
the ordinary case rather than a pathology, so the number `C(n,4)` is the target's dimension
being read as a count of independent conditions.

**The threshold is the record's `n² - 12n + 8` again**, and the identity behind it is exact:
`θ₀(n)² - 3/2 = (n² - 12n + 8)/(2n²)`, so the sign question is `(n-6)² > 28`, i.e. `n > 6 + 2√7`.
At integers that is `n ≥ 12`, `n = 11` gives `-3` and `n = 12` gives `8`.

**And the defect is not an `Aut(𝔤)`-invariant**, which is what makes any step reading it off
Cartan's list unsound at `n = 8`: `ℍP²` and `S³ × S⁵` share `θ² = 56/45` and carry defects
`2/63` and `0`.
-/

namespace HamiltonsCubic.ZeroDefect

/-! ## The two defects are separated by one witness -/

/-- **Padded `W_{ℂP²}` has `Δ = 0` and `δ² = 1/9`.** So a claim proved for one zero set says
nothing about the other. -/
theorem defects_differ : (0 : ℚ) ≠ 1 / 9 := by norm_num

/-! ## The codimension claim under the `Δ` reading -/

/-- `dim Λ⁴ℝⁿ = C(n,4)`, and at `n = 4` that is `1`. -/
theorem lambda4_at_four : Nat.choose 4 4 = 1 := by decide

/-- **`codim = 4` against `C(4,4) = 1`**, so the claim is false at the smallest dimension where
it can be read. -/
theorem codim_false_at_four : Nat.choose 4 4 < 4 := by decide

/-- The measured ranks the block cites are the target dimensions at those `n`. -/
theorem lambda4_measured :
    Nat.choose 6 4 = 15 ∧ Nat.choose 7 4 = 35 ∧ Nat.choose 8 4 = 70 := by
  refine ⟨by decide, by decide, by decide⟩

/-- **A rank below the codomain's dimension is the ordinary case**, so `codim ≤ C(n,4)` carries
no information about independence: this map has rank `1` into a `2`-dimensional target, and its
image misses a point. -/
theorem bound_gives_no_equality :
    ∃ f : ℚ × ℚ → ℚ × ℚ, (∀ p, (f p).2 = 0) ∧ ∀ p, f p ≠ (0, 1) := by
  refine ⟨fun p => (p.1, 0), fun p => rfl, fun p h => ?_⟩
  have : (0 : ℚ) = 1 := congrArg Prod.snd h
  norm_num at this

/-! ## The threshold, exactly -/

/-- **`θ₀(n)² - 3/2 = (n² - 12n + 8)/(2n²)`**, identically. -/
theorem threshold_identity (n : ℚ) (hn : n ≠ 0) :
    2 * (n - 1) * (n - 2) / n ^ 2 - 3 / 2 = (n ^ 2 - 12 * n + 8) / (2 * n ^ 2) := by
  field_simp
  ring

/-- **So the sign question is `(n-6)² > 28`**, whose positive root is `6 + 2√7`. -/
theorem threshold_completes_square (n : ℚ) :
    n ^ 2 - 12 * n + 8 = (n - 6) ^ 2 - 28 := by ring

/-- At integers the crossing is between `11` and `12`. -/
theorem threshold_at_eleven : (11:ℚ) ^ 2 - 12 * 11 + 8 = -3 := by norm_num

theorem threshold_at_twelve : (12:ℚ) ^ 2 - 12 * 12 + 8 = 8 := by norm_num

/-- **And `6 + 2√7` sits strictly between them**, since `28 < (12-6)² = 36` and
`(11-6)² = 25 < 28`, bracketed without taking a root. -/
theorem crossover_bracketed : (11 - 6:ℚ) ^ 2 < 28 ∧ (28:ℚ) < (12 - 6) ^ 2 := by
  constructor <;> norm_num

/-! ## The defect is not an `Aut(𝔤)`-invariant -/

/-- **`ℍP²` and `S³ × S⁵` share `θ² = 56/45` and carry different defects, `2/63` against `0`.**
The shared value sits below the target, and the defects separate, so the defect is not an
`Aut(𝔤)`-invariant, and a step reading it off Cartan's list is unsound at `n = 8`. -/
theorem triality_shared_value_split_defect :
    (56:ℚ) / 45 < 3 / 2 ∧ (2:ℚ) / 63 ≠ (0:ℚ) := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## The sample behind the surviving clause -/

/-- The symmetry-free half rests on `17` seeds at `n = 12` of which `14` converged, so `3` are
unaccounted, a sample the block does not state. -/
theorem seeds_unaccounted : 17 - 14 = 3 := by norm_num

end HamiltonsCubic.ZeroDefect
