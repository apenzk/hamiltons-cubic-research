import HamiltonsCubic.Results.L79
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L131, `𝒜 = -2(·#I)`, and what it settles for L79

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L131 identifies
[L79](L79.lean)'s operator with the sharp-`I` map, *"so L79's table is proven at every `n`"*.

**That discharges what L79 left owed**, and it also gives a table L131 does not print. With
`𝒜 = -2(·#I)`, the sharp-`I` eigenvalues are `-𝒜/2` on each summand:

| summand | `𝒜` | `·#I` |
|---|---|---|
| `Weylₘ` | `2` | `-1` |
| `S²₀` | `-(m-4)` | `(m-4)/2` |
| `ℝ·Id` | `-2(m-2)` | `m-2` |
| `Λ⁴` | `-4` | `2` |

**And L79's trace closure transfers with the factor.** `Σ dim × 𝒜 = C(m,2)(m-2)` is imported
from L79 rather than restated, so `Σ dim × (·#I) = -m(m-1)(m-2)/4` follows, a closure for the
sharp map obtained without recomputing anything.

**The two expressions for `𝒜` then give a Casimir identity**: `½Cas - 2(m-2)Id = -2(·#I)`
means `Cas = 4(m-2)Id - 4(·#I)`, relating the Casimir to the sharp map with no representation
theory beyond the two forms.
-/

namespace HamiltonsCubic.SharpI

open HamiltonsCubic.FourSummand

/-- The sharp-`I` eigenvalue on a summand, from `𝒜 = -2(·#I)`. -/
def sharpEig (a : ℚ) : ℚ := -a / 2

/-! ## The four sharp-`I` eigenvalues -/

theorem sharp_weyl : sharpEig eigWeyl = -1 := by unfold sharpEig eigWeyl; norm_num

theorem sharp_S20 (m : ℚ) : sharpEig (eigS20 m) = (m - 4) / 2 := by
  unfold sharpEig eigS20; ring

theorem sharp_Id (m : ℚ) : sharpEig (eigId m) = m - 2 := by
  unfold sharpEig eigId; ring

theorem sharp_Lam4 : sharpEig eigLam4 = 2 := by unfold sharpEig eigLam4; norm_num

/-! ## L79's trace closure transfers -/

/-- **`Σ dim × (·#I) = -m(m-1)(m-2)/4`**, from [L79](L79.lean)'s `trace_matches` and the
factor `-1/2`, no recomputation. -/
theorem sharp_trace (m : ℚ) :
    dimWeyl m * sharpEig eigWeyl + dimS20 m * sharpEig (eigS20 m)
      + dimId * sharpEig (eigId m) + dimLam4 m * sharpEig eigLam4
      = -(m * (m - 1) * (m - 2) / 4) := by
  have h := trace_matches m
  unfold sharpEig
  unfold dimWeyl dimS20 dimId dimLam4 eigWeyl eigS20 eigId eigLam4 at h ⊢
  linarith [h]

/-! ## The Casimir identity -/

/-- **`½Cas - 2(m-2)Id = -2(·#I)` gives `Cas = 4(m-2)Id - 4(·#I)`**, the two expressions for
`𝒜` combined, with nothing else used. -/
theorem casimir_from_sharp (m cas sharp : ℚ)
    (h : cas / 2 - 2 * (m - 2) = -2 * sharp) : cas = 4 * (m - 2) - 4 * sharp := by
  linarith [h]

/-- And the sharp map's eigenvalue determines the Casimir's on each summand. -/
theorem casimir_eigen (m a : ℚ) : 4 * (m - 2) - 4 * sharpEig a = 4 * (m - 2) + 2 * a := by
  unfold sharpEig; ring

end HamiltonsCubic.SharpI
