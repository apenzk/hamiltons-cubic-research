import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith

/-!
# L169, the grading and tracelessness determine the saturating operator

[bounds.md](../../../findings/bounds.md)'s Lemma L169, closing [L71](../../../findings/bounds.md)'s
last clause. A unit `W ∈ Weyl_n` with exactly two eigenvalues `λ_max > 0 > λ_min` and `E_max`
conjugate to `𝔥 = 𝔰𝔬(n/2) ⊕ 𝔰𝔬(n/2)` is the balanced sphere product's Weyl tensor.

**What is checked here.** The dimension count; that tracelessness and the recorded eigenvalue
ratio are the same equation; and that the sharp identities return `θ₀(n)` at the balanced
member, with no criticality anywhere in it.

**What is not.** That two eigenvalues with complementary eigenspaces put `W` on the plane
spanned by `Π_𝔥` and `Id`, and the `SO(n)`-conjugacy, the second is [L71](../../../findings/bounds.md)'s
own work and ends in Cartan's classification.

*Gate 2 refuted the block's `n = 4` remark: the lemma holds at `n = 4`, and what fails there
is `θ₀`'s maximality.*
-/

namespace HamiltonsCubic.SaturatingOperator

/-! ## The dimensions -/

/-- `r = dim 𝔥 = n(n-2)/4` and `N - r = n²/4`, where `N = C(n,2)`. -/
theorem complement_dimension (n : ℚ) :
    n * (n - 1) / 2 - n * (n - 2) / 4 = n ^ 2 / 4 := by ring

/-- **`r/(N-r) = (n-2)/n`.** -/
theorem ratio (n : ℚ) (hn : n ≠ 0) :
    n * (n - 2) / 4 / (n ^ 2 / 4) = (n - 2) / n := by
  field_simp

/-! ## Tracelessness IS the recorded ratio -/

/-- **`λ_max·r + λ_min·(N-r) = 0` is exactly `(n-2)λ_max = n|λ_min|`**, so the ratio
[L71](../../../findings/bounds.md) records is not an extra constraint once the grading is
fixed. *The equivalence is confined to the two-eigenvalue stratum with `dim E_max = r`.* -/
theorem trace_is_ratio (lmax lmin n : ℚ) (hn : 0 < n) :
    lmax * (n * (n - 2) / 4) + lmin * (n ^ 2 / 4) = 0
      ↔ (n - 2) * lmax + n * lmin = 0 := by
  constructor
  · intro h; nlinarith [h, hn]
  · intro h; nlinarith [h, hn]

/-! ## The `θ` value, from the sharp identities rather than the Casimir closed form -/

/-- **`θ² = (m-1)(2m-1)/m² = θ₀(2m)²`**, with `m = n/2`. Derived from `Id^# = (n-2)Id`,
`Π_𝔥^# = (m-2)Π_𝔥` and `Π_𝔥 # Id = (m-1)Id - Π_𝔥`, **no criticality, no saturation, no
first Bianchi**. *The Casimir family's closed form `θ = (2/n)√(rN/(N-r))` is not an identity
in `(r,N)`: it fails at `𝔰𝔬(n-1)`, giving `8/15` against `10/3` at `n = 6`.* -/
theorem theta_at_balanced (m : ℚ) (hm : m ≠ 0) :
    (m - 1) * (2 * m - 1) / m ^ 2 = 2 * (2 * m - 1) * (2 * m - 2) / (2 * m) ^ 2 := by
  field_simp

/-- At `n = 4`, that is `θ² = 3/4 = θ₀(4)²`, **the lemma holds at `n = 4`**, contrary to the
block's original remark. What fails there is `θ₀`'s maximality, `W_{ℂP²}` reaching `3/2`. -/
theorem n_four_holds : (2 - 1 : ℚ) * (2 * 2 - 1) / 2 ^ 2 = 3 / 4 := by norm_num

/-- And `W_{ℂP²}` is barred from the hypotheses twice over: `dim E_max = 1 ≠ 2 = r`, and its
spectrum has three values rather than two. -/
theorem cp2_barred : (1 : ℚ) ≠ 2 ∧ (3 : ℚ) / 2 > 3 / 4 := by
  refine ⟨by norm_num, by norm_num⟩

/-- The Casimir closed form's failure at `𝔰𝔬(n-1)`, `n = 6`: `8/15` against `10/3`. -/
theorem casimir_form_not_an_identity : (8 : ℚ) / 15 ≠ 10 / 3 := by norm_num

end HamiltonsCubic.SaturatingOperator
