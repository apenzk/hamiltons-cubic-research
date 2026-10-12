import HamiltonsCubic.Results.L7Record
import HamiltonsCubic.Results.EigenFrameExist
import HamiltonsCubic.Results.L7Full

set_option linter.style.longLine false

/-!
# L7 with the eigenframe built

[L7Record.lean](L7Record.lean)'s `L7_record` and `L7_equality_record` take an orthonormal eigenframe
as a hypothesis. [EigenFrameExist.lean](EigenFrameExist.lean)'s `eigenFrame_exists` builds one from
Mathlib's spectral theorem for every `W` linear, preserving bivectors and self-adjoint on them, so:

- `L7_exists`: **`θ tr W₋ + tr W₋² ≤ 2 tr(W₊ # W₋)` at every critical such `W`**, in the frame the
  spectral theorem gives;
- `L7_equality_exists`: **equality iff that frame is graded**;
- `L7_full_exists`, `L7_full_equality_exists`: the same in the record's form,
  `‖Ric(W₋)‖² + 6‖Alt(W₋)‖²` on the right ([L7Full.lean](L7Full.lean)).
-/

namespace HamiltonsCubic.EigenFrameExist

open HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement HamiltonsCubic.SecondKind
  HamiltonsCubic.L7Frame

variable {n : ℕ}

section frame

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))

/-- **L7 at every critical operator, the frame supplied.** -/
theorem L7_exists (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical R θ) :
    θ * negTr (Mpair_isHermitian R hR hskew hsym).eigenvalues
        + negTr2 (Mpair_isHermitian R hR hskew hsym).eigenvalues
      ≤ cross2 (Mpair_isHermitian R hR hskew hsym).eigenvalues (omegaF (frameVec R hR hskew hsym)) :=
  L7_record (fun s' c x hx => R_lin R hR s' c x hx) hskew (eigenFrame_exists R hR hskew hsym) θ hc

/-- **L7's equality class at every critical operator, the frame supplied.** -/
theorem L7_equality_exists (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical R θ) :
    θ * negTr (Mpair_isHermitian R hR hskew hsym).eigenvalues
        + negTr2 (Mpair_isHermitian R hR hskew hsym).eigenvalues
      = cross2 (Mpair_isHermitian R hR hskew hsym).eigenvalues (omegaF (frameVec R hR hskew hsym))
      ↔ HamiltonsCubic.L155Frame.Graded (Mpair_isHermitian R hR hskew hsym).eigenvalues
          (omegaF (frameVec R hR hskew hsym)) :=
  L7_equality_record (fun s' c x hx => R_lin R hR s' c x hx) hskew
    (eigenFrame_exists R hR hskew hsym) θ hc

end frame

/-- **L7 AS THE RECORD STATES IT, THE FRAME SUPPLIED**: at every critical linear Weyl operator,
`θ tr W₋ + tr W₋² ≤ ‖Ric(W₋)‖² + 6‖Alt(W₋)‖²`, `W₋` built on Mathlib's eigenframe. -/
theorem L7_full_exists (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ) :
    θ * negTr (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
        + negTr2 (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
      ≤ HamiltonsCubic.L15Statement.ricNormSq (diagFrame (frameVec W hW.1 hW.2.1 hW.2.2.1)
            fun a => negP ((Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a))
        + 6 * HamiltonsCubic.AltLayer.altNormSq (diagFrame (frameVec W hW.1 hW.2.1 hW.2.2.1)
            fun a => negP ((Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a)) :=
  L7_full hW.2 (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1) θ hc

/-- **L7's equality class in the record's form, the frame supplied.** -/
theorem L7_full_equality_exists (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : HamiltonsCubic.L40Statement.IsCritical W θ) :
    θ * negTr (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
        + negTr2 (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
      = HamiltonsCubic.L15Statement.ricNormSq (diagFrame (frameVec W hW.1 hW.2.1 hW.2.2.1)
            fun a => negP ((Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a))
        + 6 * HamiltonsCubic.AltLayer.altNormSq (diagFrame (frameVec W hW.1 hW.2.1 hW.2.2.1)
            fun a => negP ((Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a))
      ↔ HamiltonsCubic.L155Frame.Graded (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues
          (omegaF (frameVec W hW.1 hW.2.1 hW.2.2.1)) :=
  L7_full_equality hW.2 (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1) θ hc

end HamiltonsCubic.EigenFrameExist
