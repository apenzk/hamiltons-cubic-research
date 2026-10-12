import Mathlib
import HamiltonsCubic.Results.L268Rep

set_option linter.style.longLine false

/-!
# L270 (4) at every torus-invariant operator

[findings/second-order.md](../../../findings/second-order.md), Lemma L270 (4): *"On the torus family of L268, a
positive-definite idempotent lighter than $I/c$ has $\sum_\alpha\mu_\alpha^2<\tfrac m{4(m-1)}$, the value at $I/c$."*
[I117Statements.lean](I117Statements.lean)'s `L270_torus_light` proves it over `torusOp (Amu U V) U V`;
[L268Rep.lean](L268Rep.lean)'s `L268_full` makes every torus-invariant self-adjoint positive-definite idempotent of that
form. This file:

* `L270_light_op`: every self-adjoint positive-definite `#`-idempotent `C` of `𝔰𝔬(2m)` commuting with each
  `ad_{J_x}`, with `‖C‖² < ‖I‖²/(2(m-1))²`, has `∑_α μ_α² < m/(4(m-1))`, the weights being its Gram values.
-/

namespace HamiltonsCubic.L270Op

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.L268Rep

variable {m : ℕ}

local notation "SK" => skewSub (Fin m × Fin 2)
local notation "MM" => Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ

/-- **L270 (4) for every torus-invariant self-adjoint positive-definite idempotent.** -/
theorem L270_light_op (hm : 3 ≤ m) (C : CurvOp2 (Fin m × Fin 2)) (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : SK, inner2 ((C X : SK) : MM) (Y : MM) = inner2 (X : MM) ((C Y : SK) : MM))
    (hidem : IsIdem C) (hpd : IsPD2 C)
    (hlight : normSq2 C < normSq2 (idOp : CurvOp2 (Fin m × Fin 2)) / (2 * ((m : ℝ) - 1)) ^ 2) :
    (1 / 2 : ℝ) * ∑ i, ∑ j, (Uof C i j ^ 2 + Vof C i j ^ 2) < (m : ℝ) / (4 * ((m : ℝ) - 1)) := by
  obtain ⟨hrep, -, hU, hV⟩ := L268_rep C hT hsa
  obtain ⟨hAmu, -, hpos⟩ := (L268_full hm C hT hsa).mp ⟨hidem, hpd⟩
  have hC : C = torusOp (Amu (Uof C) (Vof C)) (Uof C) (Vof C) := hAmu ▸ hrep
  have hidem' : IsIdem (torusOp (Amu (Uof C) (Vof C)) (Uof C) (Vof C)) := hC ▸ hidem
  have hlight' : normSq2 (torusOp (Amu (Uof C) (Vof C)) (Uof C) (Vof C))
      < normSq2 (idOp : CurvOp2 (Fin m × Fin 2)) / (2 * ((m : ℝ) - 1)) ^ 2 := hC ▸ hlight
  exact L270_torus_light hm (Uof C) (Vof C) hU hV hpos hidem' hlight'

end HamiltonsCubic.L270Op
