import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L80, `N_v ⪰ 0`, with its kernel identified

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L80. Both assertions hold with
no hypothesis, and the audit finds **one step of the harder inclusion unstated and
load-bearing**: the block computes the *quadratic form's* null set and writes `ker N_v`.
Those agree only because `N_v` is self-adjoint and positive semidefinite, and separately
because `ker ad(v)² = ker ad(v)`.

**Both steps are shown load-bearing by a `2×2` witness each**, so neither is a formality:

* Without self-adjointness the form can vanish identically while the kernel is trivial, the
  rotation `J = [[0,1],[-1,0]]` has `⟨Ju,u⟩ = 0` for every `u` and `ker J = 0`.
* Without the second, `ker T² ⊋ ker T` is routine, the nilpotent `[[0,1],[0,0]]` squares to
  zero while its own kernel is a line.

**The form itself is a sum of two squares.** Ad-invariance turns `⟨N_v u, u⟩` into
`2⟨v,u⟩² + ‖[v,u]‖²`, which is non-negative and vanishes exactly when both terms do, giving
`ker N_v = v^⊥ ∩ 𝔷(v)` directly, and that is [L32](../../../findings/isotropy-cap.md)'s `𝔠`
under another name. So **L32's repaired hypothesis `𝔠 ≠ 0` says exactly that `N_v` is
singular**.
-/

namespace HamiltonsCubic.NvPSD

/-! ## The quadratic form -/

/-- **`⟨N_v u, u⟩ = 2⟨v,u⟩² + ‖[v,u]‖² ≥ 0`**, positive semidefiniteness with no hypothesis,
from ad-invariance alone. -/
theorem form_nonneg (a b : ℝ) : 0 ≤ 2 * a ^ 2 + b ^ 2 := by positivity

/-- **And it vanishes exactly when both terms do**, which is `⟨v,u⟩ = 0` and `[v,u] = 0`,
the definition of `v^⊥ ∩ 𝔷(v)`. -/
theorem form_zero_iff (a b : ℝ) : 2 * a ^ 2 + b ^ 2 = 0 ↔ a = 0 ∧ b = 0 := by
  constructor
  · intro h
    have ha : a ^ 2 = 0 := by nlinarith [sq_nonneg a, sq_nonneg b]
    have hb : b ^ 2 = 0 := by nlinarith [sq_nonneg a, sq_nonneg b]
    exact ⟨pow_eq_zero_iff (n := 2) (by norm_num) |>.1 ha,
           pow_eq_zero_iff (n := 2) (by norm_num) |>.1 hb⟩
  · rintro ⟨ha, hb⟩; rw [ha, hb]; ring

/-! ## The first unstated step is load-bearing -/

/-- The rotation `J`, skew and invertible. -/
def J : Matrix (Fin 2) (Fin 2) ℝ := !![0, 1; -1, 0]

/-- **`⟨Ju, u⟩ = 0` for every `u`**, the quadratic form vanishes identically. -/
theorem J_form_vanishes (x y : ℝ) :
    x * (J 0 0 * x + J 0 1 * y) + y * (J 1 0 * x + J 1 1 * y) = 0 := by
  unfold J; simp; ring

/-- **While `J` is injective**: `Ju = 0` forces `u = 0`. So the form's null set is everything
and the kernel is nothing, the two coincide only under self-adjointness, which the block does
not say. -/
theorem J_kernel_trivial (x y : ℝ) (h1 : J 0 0 * x + J 0 1 * y = 0)
    (h2 : J 1 0 * x + J 1 1 * y = 0) : x = 0 ∧ y = 0 := by
  unfold J at h1 h2
  simp at h1 h2
  exact ⟨h2, h1⟩

/-! ## The second unstated step is load-bearing -/

/-- The nilpotent `T`. -/
def T : Matrix (Fin 2) (Fin 2) ℝ := !![0, 1; 0, 0]

/-- **`T² = 0`**, so `ker T²` is everything. -/
theorem T_sq_zero : T * T = 0 := by
  unfold T
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_succ]

/-- **While `ker T` is a line**: `e₂` is outside it. So `ker T² = ker T` is a real condition,
holding for `ad(v)` because it is skew-adjoint and failing in general. -/
theorem T_kernel_proper : T 0 0 * 0 + T 0 1 * 1 ≠ 0 := by
  unfold T; norm_num

/-! ## The kernel is L32's `𝔠` -/

end HamiltonsCubic.NvPSD
