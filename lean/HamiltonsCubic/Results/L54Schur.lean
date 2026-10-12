import HamiltonsCubic.Results.L54Basis
import HamiltonsCubic.Results.SchurMajor

set_option linter.style.longLine false

/-!
# L54 (2), first half: `μ ≻ d_φ`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L54 (2): the spectrum `μ` of `M`
majorises its pair-basis diagonal `d_φ = (K_ab)_{a<b}`. **Proved** from
[SchurMajor.lean](SchurMajor.lean)'s `schur_majorizes` at the pair-basis matrix:

- `Mpair R`: `M` in the pair basis `{φ_ab}_{a<b}`, entries `W_{abcd}`, symmetric by pair symmetry;
- `Mpair_diag`: its diagonal is `K_ab`;
- `L54_mu_majorizes`: `Majorizes (eigenvalues of Mpair R) (fun p => K_{p.1 p.2})`.

The second half `ω ≻ d` is [L54Rigid.lean](L54Rigid.lean)'s `L54_omega_majorizes` on `S²` and
[L54Converse.lean](L54Converse.lean)'s `L54_majorizes_S20_sub` on `S²₀`.
-/

namespace HamiltonsCubic.SecondKind

open HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.L54Statement

variable {n : ℕ}

/-- The ordered pairs `a < b`, indexing the pair basis of `Λ²`. -/
abbrev Pairs (n : ℕ) := {p : Fin n × Fin n // p.1 < p.2}

/-- **`M` in the pair basis**, `M_{(ab),(cd)} = W_{abcd}`. -/
noncomputable def Mpair (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) :
    Matrix (Pairs n) (Pairs n) ℝ :=
  fun p q => R4 R p.1.1 p.1.2 q.1.1 q.1.2

theorem Mpair_diag (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (p : Pairs n) :
    Mpair R p p = Kmat R p.1.1 p.1.2 := rfl

/-- `Mpair` is symmetric at an operator self-adjoint on bivectors. -/
theorem Mpair_isHermitian (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) :
    (Mpair R).IsHermitian := by
  ext p q
  simp only [Matrix.conjTranspose_apply, star_trivial]
  exact (R4_pair R hR hskew hsym q.1.1 q.1.2 p.1.1 p.1.2)

/-- **L54 (2), `μ ≻ d_φ`**: the spectrum of `M` majorises its pair-basis diagonal `K`. -/
theorem L54_mu_majorizes (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) :
    Majorizes (Mpair_isHermitian R hR hskew hsym).eigenvalues
      (fun p : Pairs n => Kmat R p.1.1 p.1.2) :=
  schur_majorizes (Mpair R) (Mpair_isHermitian R hR hskew hsym)

end HamiltonsCubic.SecondKind
