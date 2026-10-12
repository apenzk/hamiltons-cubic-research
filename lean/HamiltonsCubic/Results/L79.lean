import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L79, the four-summand table, its two closures, and the collisions

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L79. The four eigenvalues are
representation theory and stay imported; **both checks the audit says the table could not
pass by accident are polynomial identities in `m`, and they are proved here**, so they hold
at every `m ≥ 3` rather than at the tabulated sizes.

**The collisions are enumerated, not spotted.** The audit reports *two* unrecorded eigenvalue
collisions. Running all six pairs of `{2, -(m-4), -2(m-2), -4}` shows there are **exactly
two** in range: `S²₀` meets `Λ⁴` at `m = 8`, and `ℝ·Id` meets `Λ⁴` at `m = 4`. The other four
pairs meet only at `m = 0, 1, 2` or never. So the audit's list is complete, which the audit
does not claim.

**And the `m = 4` collision is between two lines of dimension one** (`Λ⁴ℝ⁴` and `ℝ·Id`) so
they are isomorphic as `SO(4)`-representations and Schur licenses mixing, exactly as the
record says.
-/

namespace HamiltonsCubic.FourSummand

/-! ## The four dimensions -/

def dimWeyl (m : ℚ) : ℚ := m * (m + 1) * (m + 2) * (m - 3) / 12

def dimS20 (m : ℚ) : ℚ := m * (m + 1) / 2 - 1

def dimId : ℚ := 1

def dimLam4 (m : ℚ) : ℚ := m * (m - 1) * (m - 2) * (m - 3) / 24

/-- `dim Λ²ℝᵐ = m(m-1)/2`. -/
def dimLam2 (m : ℚ) : ℚ := m * (m - 1) / 2

/-- `dim S²(Λ²) = N(N+1)/2` with `N = dim Λ²`. -/
def dimS2Lam2 (m : ℚ) : ℚ := dimLam2 m * (dimLam2 m + 1) / 2

/-- **The first closure: the four dimensions sum to `dim S²(Λ²)`, identically in `m`.** -/
theorem dims_sum (m : ℚ) :
    dimWeyl m + dimS20 m + dimId + dimLam4 m = dimS2Lam2 m := by
  unfold dimWeyl dimS20 dimId dimLam4 dimS2Lam2 dimLam2
  ring

/-! ## The four eigenvalues -/

def eigWeyl : ℚ := 2

def eigS20 (m : ℚ) : ℚ := -(m - 4)

def eigId (m : ℚ) : ℚ := -2 * (m - 2)

def eigLam4 : ℚ := -4

/-- **The second closure: `Σ dim × eigenvalue = C(m,2)(m-2)`, the Killing marginal's trace,
identically in `m`.** -/
theorem trace_matches (m : ℚ) :
    dimWeyl m * eigWeyl + dimS20 m * eigS20 m + dimId * eigId m + dimLam4 m * eigLam4
      = m * (m - 1) / 2 * (m - 2) := by
  unfold dimWeyl dimS20 dimId dimLam4 eigWeyl eigS20 eigId eigLam4
  ring

/-- The two closures at the tabulated sizes, as a sanity anchor. -/
theorem anchors :
    dimS2Lam2 4 = 21 ∧ dimS2Lam2 5 = 55 ∧ dimS2Lam2 6 = 120 := by
  unfold dimS2Lam2 dimLam2
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The collisions, enumerated over all six pairs -/

/-- `2 = -(m-4)` forces `m = 2`, below the range. -/
theorem pair_Weyl_S20 (m : ℚ) (h : eigWeyl = eigS20 m) : m = 2 := by
  unfold eigWeyl eigS20 at h; linarith

/-- `2 = -2(m-2)` forces `m = 1`, below the range. -/
theorem pair_Weyl_Id (m : ℚ) (h : eigWeyl = eigId m) : m = 1 := by
  unfold eigWeyl eigId at h; linarith

/-- `2 = -4` never. -/
theorem pair_Weyl_Lam4 : eigWeyl ≠ eigLam4 := by
  unfold eigWeyl eigLam4; norm_num

/-- `-(m-4) = -2(m-2)` forces `m = 0`, below the range. -/
theorem pair_S20_Id (m : ℚ) (h : eigS20 m = eigId m) : m = 0 := by
  unfold eigS20 eigId at h; linarith

/-- **`-(m-4) = -4` forces `m = 8`**, the first unrecorded collision, `S²₀` with `Λ⁴`. -/
theorem pair_S20_Lam4 (m : ℚ) (h : eigS20 m = eigLam4) : m = 8 := by
  unfold eigS20 eigLam4 at h; linarith

/-- **`-2(m-2) = -4` forces `m = 4`**, the second, `ℝ·Id` with `Λ⁴`. -/
theorem pair_Id_Lam4 (m : ℚ) (h : eigId m = eigLam4) : m = 4 := by
  unfold eigId eigLam4 at h; linarith

/-- **So exactly two collisions occur at `m ≥ 3`**, and the audit's list is complete. -/
theorem collisions_complete (m : ℚ) (hm : 3 ≤ m)
    (h : eigWeyl = eigS20 m ∨ eigWeyl = eigId m ∨ eigWeyl = eigLam4
       ∨ eigS20 m = eigId m ∨ eigS20 m = eigLam4 ∨ eigId m = eigLam4) :
    m = 8 ∨ m = 4 := by
  rcases h with h | h | h | h | h | h
  · exact absurd (pair_Weyl_S20 m h) (by linarith)
  · exact absurd (pair_Weyl_Id m h) (by linarith)
  · exact absurd h pair_Weyl_Lam4
  · exact absurd (pair_S20_Id m h) (by linarith)
  · exact Or.inl (pair_S20_Lam4 m h)
  · exact Or.inr (pair_Id_Lam4 m h)

/-- **The `m = 4` collision is between two lines**: `dim Λ⁴ℝ⁴ = 1 = dim ℝ·Id`, so the
summands are isomorphic as `SO(4)`-representations and Schur licenses mixing. -/
theorem m4_both_lines : dimLam4 4 = 1 ∧ dimId = 1 := by
  unfold dimLam4 dimId
  refine ⟨by norm_num, rfl⟩

/-- At `m = 8` the two colliding summands have **different** dimensions, so that collision is
numerical rather than representation-theoretic. -/
theorem m8_dims_differ : dimS20 8 ≠ dimLam4 8 := by
  unfold dimS20 dimLam4
  norm_num

end HamiltonsCubic.FourSummand
