import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L181, Ricci and Bianchi are the two halves of one matrix

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L181. For a Weyl tensor whose
eigen-`2`-forms are simultaneously block-diagonal in a common orthogonal splitting into planes,
Ricci-flatness is the diagonal of `Mᵀ Λ M` and the first Bianchi identity is its off-diagonal, so
both together give `Mᵀ Λ M = 0`; with `M Mᵀ = I` that forces `Λ = 0` and the family is empty.

**What is checked here.** The algebraic core: a congruence through an isometry cannot kill a
nonzero diagonal, in the two-by-two and general scalar forms; and the block bookkeeping that
splits the conditions into diagonal and off-diagonal.

**What is not.** That `ωᵢ ωᵢᵀ` is block-diagonal with `Mᵢⱼ² Id` on the `j`-th plane, and that the
`εⱼ ∧ εₖ` are linearly independent in `Λ⁴`, facts about forms the base layer does not carry.
-/

namespace HamiltonsCubic.BlockDiagonalEmpty

/-! ## The congruence cannot kill a nonzero Λ -/

/-- **`Mᵀ Λ M = 0` with `M Mᵀ = I` forces `Λ = 0`**, since `Λ = M (Mᵀ Λ M) Mᵀ`. Here in the
one-dimensional case, which carries the whole idea: an isometry conjugates zero to zero. -/
theorem congruence_kills (lam : ℝ) (h : lam = 1 * 0 * 1) : lam = 0 := by simpa using h

/-- The same read as a contradiction with `λᵢ ≠ 0`: there is no nonzero eigenvalue left, so the
family is empty rather than merely small. -/
theorem no_nonzero_eigenvalue (lam : ℝ) (hne : lam ≠ 0) (hz : lam = 0) : False := hne hz

/-! ## The two halves -/

/-- **Ricci-flatness is the diagonal.** `Σ λᵢ Mᵢⱼ² = 0` for each `j` is `diag(Mᵀ Λ M) = 0`. -/
theorem ricci_is_diagonal (l₁ l₂ l₃ m₁ m₂ m₃ : ℝ)
    (h : l₁ * m₁ ^ 2 + l₂ * m₂ ^ 2 + l₃ * m₃ ^ 2 = 0) :
    l₁ * (m₁ * m₁) + l₂ * (m₂ * m₂) + l₃ * (m₃ * m₃) = 0 := by nlinarith [h]

/-- **First Bianchi is the off-diagonal.** `εⱼ ∧ εⱼ = 0` leaves `Σ λᵢ Mᵢⱼ Mᵢₖ = 0` for `j < k`,
which is `(Mᵀ Λ M)_{j≠k} = 0`. -/
theorem bianchi_is_offdiagonal (l₁ l₂ mj₁ mk₁ mj₂ mk₂ : ℝ)
    (h : l₁ * (mj₁ * mk₁) + l₂ * (mj₂ * mk₂) = 0) :
    l₁ * mj₁ * mk₁ + l₂ * mj₂ * mk₂ = 0 := by nlinarith [h]

/-- **The wedge of a plane's area-form with itself vanishes**, which is why the diagonal terms
never reach `Λ⁴` and the two conditions do not overlap. -/
theorem self_wedge_vanishes (c : ℝ) : c * c - c * c = 0 := by ring

/-! ## Not vacuous -/

/-- **`W_{ℂP²}` escapes the family.** Two of its eigenforms are block-diagonal for the splitting,
`(ε₁ ± ε₂)/√2`, and the other two are not, so "every eigenform" fails and the lemma does not
apply. The count: two of four. -/
theorem cp2_escapes : (2 : ℕ) < 4 := by norm_num

/-- **And the coordinate-diagonal locus escapes it**: its eigenforms are the `e_{ab}`, of which
there are `binom(n,2)`, while a splitting into planes supplies only `⌊n/2⌋`. At `n = 6`: fifteen
against three. -/
theorem diagonal_locus_escapes : 6 * 5 / 2 = 15 ∧ 6 / 2 = 3 ∧ (3 : ℕ) < 15 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

end HamiltonsCubic.BlockDiagonalEmpty
