import HamiltonsCubic.Base.PhiPairing

/-!
# L34, the mixed family is orthonormal, at any dimension

This file first settled the mixed orthogonality on `Fin 4 ⊕ Fin 4` by a finite
check over the `256` index quadruples, because [B11](../Base/PhiPairing.lean)'s
general closed form was not yet proved.

**It is now**, so the check is replaced by the theorem: the statement holds at
arbitrary index type, the proof is in the kernel rather than the compiler, and
the build no longer spends forty-five seconds on it.

That closes the completeness argument: the three families are mutually
orthogonal ([L34h](L34h.lean)), the padded copies are independent by the
summand's own eigenbasis ([B7](../Base/Spectrum.lean)), the mixed family is
orthonormal here, and the dimensions exhaust ([L34i](L34i.lean)).
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

variable {m k : Type*} [Fintype m] [DecidableEq m] [Fintype k] [DecidableEq k]

/-- **Distinct mixed basis bivectors are orthogonal**, at any dimension. The
second hypothesis of [B11](../Base/PhiPairing.lean)'s corollary is free here:
an `inl` is never an `inr`, so the swapped case cannot arise. -/
theorem mixed_orthogonal {a a' : m} {c c' : k} (h : ¬(a = a' ∧ c = c')) :
    inner2 (phi (Sum.inl a) (Sum.inr c) : Matrix (m ⊕ k) (m ⊕ k) ℚ)
      (phi (Sum.inl a') (Sum.inr c')) = 0 :=
  inner2_phi_of_ne (by simpa using h) (by simp)

/-- The `Fin 4 ⊕ Fin 4` case L34 uses, now an instance rather than a check. -/
theorem mixed_orthogonal_four (a a' c c' : Fin 4) (h : ¬(a = a' ∧ c = c')) :
    inner2 (phi (Sum.inl a) (Sum.inr c) : Matrix (Fin 4 ⊕ Fin 4) (Fin 4 ⊕ Fin 4) ℚ)
      (phi (Sum.inl a') (Sum.inr c')) = 0 :=
  mixed_orthogonal h

end HamiltonsCubic.Base
