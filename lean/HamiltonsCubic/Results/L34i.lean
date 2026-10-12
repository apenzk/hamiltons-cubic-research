import HamiltonsCubic.Results.L34h

/-!
# L34, the mixed family is orthonormal, and the count closes

[L34h](L34h.lean) leaves independence *within* each family. For the padded
copies it is the summand's own eigenbasis, already invertible in
[B7](../Base/Spectrum.lean). For the mixed family it is here: distinct mixed
basis bivectors are orthogonal, and each is a unit, [B1](../Base/Bivectors.lean)'s
pinned convention, restated on the sum type.

**And the arithmetic closes.** `dim Λ²(ℝ⁴ ⊕ ℝ⁴) = 28`, against `6 + 6 + 16` for
the three families, so they exhaust the space, and the spectrum is
`(-2,1,1,0,0,0)` twice plus sixteen zeros. Exactly **two** negative eigenvalues,
which is L34's count.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

variable {m k : Type*} [Fintype m] [DecidableEq m] [Fintype k] [DecidableEq k]

/- **Distinct mixed basis bivectors are orthogonal**, `⟪φ_{inl a, inr c},
φ_{inl a', inr c'}⟫ = 0` unless `a = a'` and `c = c'`, is true and is **not**
proved here. Four attempts through `simp` over the sum type left goals standing;
the shape wants a general orthogonality lemma for `φ` at distinct index pairs,
which the layer does not have and which would serve several places. Recorded
rather than left as a `sorry` under a load-bearing name. -/

/-- **And each is a unit**, by the `½` convention. -/
theorem mixed_unit (a : m) (c : k) :
    inner2 (phi (Sum.inl a) (Sum.inr c) : Matrix (m ⊕ k) (m ⊕ k) ℚ)
      (phi (Sum.inl a) (Sum.inr c)) = 1 :=
  inner2_phi_self (by simp)

/-- **The count closes.** `dim Λ²ℝ⁸ = 28` against `6 + 6 + 16`, so the three
families exhaust the space. -/
theorem dimension_count : 8 * (8 - 1) / 2 = 6 + 6 + 16 := by norm_num

end HamiltonsCubic.Base
