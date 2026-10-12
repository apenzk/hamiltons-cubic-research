import HamiltonsCubic.Base.StructureConstants
import HamiltonsCubic.Base.FoxProduct
import HamiltonsCubic.Base.SharpDiag

/-!
# The finite-stabiliser stratum is inhabited

**What this file settles.** The record's parameter count reasoned that a solution with finite
stabiliser would need a `15`-dimensional orbit inside a `5`-dimensional set, and concluded that the
case "cannot occur at all". The bound behind that sentence caps the stabiliser at `4`, which is an
*upper* bound and therefore permits `0` and the `15`-dimensional orbit with it.

**So the sentence needed a witness, and one exists.** With `Λ²ℝ⁶ ≅ 𝔰𝔬(6)` a triple's stabiliser
algebra is the centraliser of the three matrices, and

`ω₁ = (φ₀₁ + 2φ₂₃ + 4φ₄₅)/√21`,  `ω₂ = φ₀₂`,  `ω₃ = φ₀₄`

is orthonormal under `inner2` with centraliser `0`. *The normalisation plays no part in the
centraliser, so `centraliser_trivial` is stated at the unscaled `omegaA` and transported.*

**What the witness does NOT say.** These three carry no Ricci-flatness and no first Bianchi
condition, so nothing here bears on whether a *constrained* triple can have a finite stabiliser,
which is the open question. What it kills is the count's reasoning and every claim that no triple
has a finite stabiliser.
-/

set_option linter.style.longLine false
set_option maxHeartbeats 1000000

namespace HamiltonsCubic.RealLayer

open Matrix

/-- The unscaled first form, `φ₀₁ + 2φ₂₃ + 4φ₄₅`. -/
def omegaA : Matrix (Fin 6) (Fin 6) ℝ := phi 0 1 + (2 : ℝ) • phi 2 3 + (4 : ℝ) • phi 4 5

/-- The second form of the exhibit, `φ₀₂`. -/
def omegaB : Matrix (Fin 6) (Fin 6) ℝ := phi 0 2

/-- The third form of the exhibit, `φ₀₄`. -/
def omegaC : Matrix (Fin 6) (Fin 6) ℝ := phi 0 4

/-- The first form, normalised: `ω₁ = (φ₀₁ + 2φ₂₃ + 4φ₄₅)/√21`. -/
noncomputable def omega1 : Matrix (Fin 6) (Fin 6) ℝ := (Real.sqrt 21)⁻¹ • omegaA

/-- **The exhibit is orthonormal**, `⟨ωᵢ, ωⱼ⟩ = δᵢⱼ` under `inner2 X Y = ½tr(XᵀY)`.

*The three index-pair sets `{01, 23, 45}`, `{02}` and `{04}` are pairwise disjoint, which is what
makes the cross terms vanish, and `(1 + 4 + 16)/21 = 1` is what normalises the first.* -/
theorem exhibit_orthonormal :
    inner2 omega1 omega1 = 1 ∧ inner2 omegaB omegaB = 1 ∧ inner2 omegaC omegaC = 1 ∧
      inner2 omega1 omegaB = 0 ∧ inner2 omega1 omegaC = 0 ∧ inner2 omegaB omegaC = 0 := by
  have h21 : Real.sqrt 21 * Real.sqrt 21 = 21 := Real.mul_self_sqrt (by norm_num)
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
    simp [inner2, omega1, omegaA, omegaB, omegaC, phi, Matrix.trace, Matrix.mul_apply,
      Matrix.single_apply, Fin.sum_univ_six, Matrix.transpose_apply, Matrix.smul_apply,
      Matrix.add_apply, Matrix.sub_apply] <;>
    field_simp <;> nlinarith [h21, Real.sqrt_nonneg 21]

/-- **The entry form of a bracket against a basis bivector.** Every index coincidence is carried by
the four conditionals, exactly as [`br_phi_phi`](../Base/StructureConstants.lean) carries them by
four Kronecker deltas, so no case split on `a` and `b` is needed anywhere below. -/
theorem br_phi_entry {ι : Type*} [Fintype ι] [DecidableEq ι]
    (X : Matrix ι ι ℝ) (a b i j : ι) :
    br X (phi a b) i j
      = (if a = j then X i b else 0) - (if b = j then X i a else 0)
        - (if b = i then X a j else 0) + (if a = i then X b j else 0) := by
  simp [br, phi, Matrix.mul_apply, Matrix.single_apply, ite_and, Matrix.sub_apply,
    mul_sub, sub_mul, mul_ite, ite_mul, mul_zero, zero_mul, mul_one, one_mul,
    Finset.sum_sub_distrib, Finset.sum_ite_eq]
  ring

/-- **The centraliser of the exhibit is trivial.** A skew `X` commuting with all three is `0`.

*The mechanism.* `ω₂ = φ₀₂` and `ω₃ = φ₀₄` between them kill every entry meeting an index in
`{0, 2, 4}`, which is the Schur step: the two generate `𝔰𝔬(3)` on `span(e₀, e₂, e₄)`, and the
commutant's skew part is `𝔰𝔬(3)` on the complementary axes. *What is left is `X₁₃`, `X₁₅` and
`X₃₅`, and `ω₁`'s three distinct coefficients kill those one apiece, at the entries `(3,0)`,
`(5,0)` and `(5,2)`, each of which reads off a single unknown once the first step has run. -/
theorem centraliser_trivial (X : Matrix (Fin 6) (Fin 6) ℝ) (hX : IsSkew X)
    (h1 : br X omegaA = 0) (h2 : br X omegaB = 0) (h3 : br X omegaC = 0) : X = 0 := by
  have hs : ∀ a b : Fin 6, X b a = - X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simpa [Matrix.transpose_apply] using this
  have hd : ∀ a : Fin 6, X a a = 0 := by intro a; have := hs a a; linarith
  have B : ∀ i j : Fin 6,
      (if (0 : Fin 6) = j then X i 1 else 0) - (if (1 : Fin 6) = j then X i 0 else 0)
        - (if (1 : Fin 6) = i then X 0 j else 0) + (if (0 : Fin 6) = i then X 1 j else 0)
      + 2 * ((if (2 : Fin 6) = j then X i 3 else 0) - (if (3 : Fin 6) = j then X i 2 else 0)
        - (if (3 : Fin 6) = i then X 2 j else 0) + (if (2 : Fin 6) = i then X 3 j else 0))
      + 4 * ((if (4 : Fin 6) = j then X i 5 else 0) - (if (5 : Fin 6) = j then X i 4 else 0)
        - (if (5 : Fin 6) = i then X 4 j else 0) + (if (4 : Fin 6) = i then X 5 j else 0)) = 0 := by
    intro i j
    have h : br X omegaA i j = 0 := by rw [h1]; rfl
    rw [omegaA, br_add_right, br_add_right, br_smul_right, br_smul_right] at h
    simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, br_phi_entry] at h
    linarith [h]
  have C : ∀ i j : Fin 6,
      (if (0 : Fin 6) = j then X i 2 else 0) - (if (2 : Fin 6) = j then X i 0 else 0)
        - (if (2 : Fin 6) = i then X 0 j else 0) + (if (0 : Fin 6) = i then X 2 j else 0) = 0 := by
    intro i j
    have h : br X omegaB i j = 0 := by rw [h2]; rfl
    rw [omegaB, br_phi_entry] at h
    linarith [h]
  have D : ∀ i j : Fin 6,
      (if (0 : Fin 6) = j then X i 4 else 0) - (if (4 : Fin 6) = j then X i 0 else 0)
        - (if (4 : Fin 6) = i then X 0 j else 0) + (if (0 : Fin 6) = i then X 4 j else 0) = 0 := by
    intro i j
    have h : br X omegaC i j = 0 := by rw [h3]; rfl
    rw [omegaC, br_phi_entry] at h
    linarith [h]
  -- rows and columns 0, 2 and 4 vanish: the Schur step
  have h01 : X 0 1 = 0 := by have := C 2 1; norm_num [Fin.ext_iff] at this; linarith
  have h02 : X 0 2 = 0 := by have := D 4 2; norm_num [Fin.ext_iff] at this; linarith
  have h03 : X 0 3 = 0 := by have := C 2 3; norm_num [Fin.ext_iff] at this; linarith
  have h04 : X 0 4 = 0 := by have := C 2 4; norm_num [Fin.ext_iff] at this; linarith
  have h05 : X 0 5 = 0 := by have := C 2 5; norm_num [Fin.ext_iff] at this; linarith
  have h12 : X 1 2 = 0 := by have := C 1 0; norm_num [Fin.ext_iff] at this; linarith
  have h14 : X 1 4 = 0 := by have := D 1 0; norm_num [Fin.ext_iff] at this; linarith
  have h23 : X 2 3 = 0 := by have := C 0 3; norm_num [Fin.ext_iff] at this; linarith
  have h24 : X 2 4 = 0 := by have := C 0 4; norm_num [Fin.ext_iff] at this; linarith
  have h25 : X 2 5 = 0 := by have := C 0 5; norm_num [Fin.ext_iff] at this; linarith
  have h34 : X 3 4 = 0 := by
    have := D 0 3; norm_num [Fin.ext_iff] at this; linarith [hs 3 4]
  have h45 : X 4 5 = 0 := by have := D 0 5; norm_num [Fin.ext_iff] at this; linarith
  -- ω₁'s three coefficients then kill the three surviving unknowns
  have h13 : X 1 3 = 0 := by
    have := B 3 0; norm_num [Fin.ext_iff] at this; linarith [hs 0 2, hs 1 3]
  have h15 : X 1 5 = 0 := by
    have := B 5 0; norm_num [Fin.ext_iff] at this; linarith [hs 0 4, hs 1 5]
  have h35 : X 3 5 = 0 := by
    have := B 5 2; norm_num [Fin.ext_iff] at this; linarith [hs 2 4, hs 3 5]
  clear B C D h1 h2 h3 hX
  have hz : ∀ a b : Fin 6, X a b = 0 := by
    intro a b
    fin_cases a <;> fin_cases b <;>
      first
        | exact hd _
        | assumption
        | (rw [hs]; simp [h01, h02, h03, h04, h05, h12, h13, h14, h15,
            h23, h24, h25, h34, h35, h45])
  ext i j
  simpa using hz i j

end HamiltonsCubic.RealLayer
