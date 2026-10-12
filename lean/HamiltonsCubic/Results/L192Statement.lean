import HamiltonsCubic.Results.L191Statement
import HamiltonsCubic.Base.Pfaffian6

/-!
# L192, both Weyl conditions read on the span as one weighted Laplacian

**What is typed here is the identity the reformulation rests on**, in the form that needs no
Pfaffian: for a symmetric trilinear `C` and `w x = x 0 • ω 0 + x 1 • ω 1 + x 2 • ω 2`, the second
partial `∂ᵢ²` of the cubic `C (w x) (w x) (w x)` is `6 • C (ω i) (ω i) (w x)`.

*Differentiation is not needed to say it.* **The `i`-th second difference of a cubic in one variable
is what the derivative reads off**, so the statement is `cube_second_diff` below: the coefficient of
`t` in the expansion of the cubic along `x + t·eᵢ` at second order. That makes it a polynomial
identity, provable by `ring`, and it is the whole content of the reformulation's step 2.

**The Pfaffian on `Λ²ℝ⁶` is not built in this layer**, so `Pf (w x)` is not typed and neither is the
statement that first Bianchi implies its harmonicity. *What the block says beyond this identity is
[L179](../../../findings/diagonal-half.md)(b) and [L180](../../../findings/diagonal-half.md)(1)
applied to it, both already on the record.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L192Statement

variable {V : Type*} [AddCommGroup V] [Module ℝ V]

/-- **A symmetric trilinear form**, which is what `(α, β, γ) ↦ (α ∧ β ∧ γ)/vol` is on `Λ²ℝ⁶`. -/
structure SymTri (V : Type*) [AddCommGroup V] [Module ℝ V] where
  form : V → V → V → ℝ
  add_left : ∀ a b c d, form (a + b) c d = form a c d + form b c d
  smul_left : ∀ (r : ℝ) a c d, form (r • a) c d = r * form a c d
  symm12 : ∀ a b c, form a b c = form b a c
  symm23 : ∀ a b c, form a b c = form a c b

namespace SymTri

variable (C : SymTri V)

theorem add_mid (a b c d : V) : C.form a (b + c) d = C.form a b d + C.form a c d := by
  rw [C.symm12, C.symm12 a b, C.symm12 a c, C.add_left]

theorem smul_mid (r : ℝ) (a b d : V) : C.form a (r • b) d = r * C.form a b d := by
  rw [C.symm12, C.symm12 a b, C.smul_left]

theorem add_right (a b c d : V) : C.form a b (c + d) = C.form a b c + C.form a b d := by
  rw [C.symm23, C.symm23 a b c, C.symm23 a b d, C.add_mid]

theorem smul_right (r : ℝ) (a b c : V) : C.form a b (r • c) = r * C.form a b c := by
  rw [C.symm23, C.symm23 a b c, C.smul_mid]

/-- **THE IDENTITY THE REFORMULATION RESTS ON.** *Expanding the cubic `t ↦ C(w+tω, w+tω, w+tω)`
gives `C(w,w,w) + 3t·C(ω,w,w) + 3t²·C(ω,ω,w) + t³·C(ω,ω,ω)`, so the second-order coefficient is
`3·C(ω,ω,w)` and the second derivative is twice it.* **That is what `∂ᵢ²` reads off the Pfaffian
cubic**, with `ω` the `i`-th form of the triple. -/
theorem cube_expand (w ω : V) (t : ℝ) :
    C.form (w + t • ω) (w + t • ω) (w + t • ω)
      = C.form w w w + 3 * t * C.form ω w w + 3 * (t * t) * C.form ω ω w
        + (t * t * t) * C.form ω ω ω := by
  have h1 : C.form w w ω = C.form ω w w := by rw [C.symm23, C.symm12]
  have h2 : C.form w ω w = C.form ω w w := by rw [C.symm12]
  have h3 : C.form w ω ω = C.form ω ω w := by rw [C.symm12, C.symm23]
  have h4 : C.form ω w ω = C.form ω ω w := by rw [C.symm23]
  simp only [C.add_left, C.add_mid, C.add_right, C.smul_left, C.smul_mid, C.smul_right,
    h1, h2, h3, h4]
  ring

/-- **The second difference of the cubic is `6·C(ω, ω, w)`**, which is `∂ᵢ²` without derivatives:
`f(w+ω) - 2f(w) + f(w-ω)` at the cubic `f(v) = C v v v`. -/
theorem cube_second_diff (w ω : V) :
    C.form (w + (1:ℝ) • ω) (w + (1:ℝ) • ω) (w + (1:ℝ) • ω)
      - 2 * C.form w w w
      + C.form (w + (-1:ℝ) • ω) (w + (-1:ℝ) • ω) (w + (-1:ℝ) • ω)
      = 6 * C.form ω ω w := by
  rw [C.cube_expand w ω 1, C.cube_expand w ω (-1)]
  ring

end SymTri

/-! ## The identity, and the implication as its corollary -/

open HamiltonsCubic.SelfDualLayer

/-- **The Bianchi defect tested at one form**, in the symmetrised reading `triple6` forces here.
*Its vanishing for every `η` is [L179](../../../findings/diagonal-half.md)(b).* -/
noncomputable def defectAt (lam : Fin 3 → ℝ) (om : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ)
    (η : Matrix (Fin 6) (Fin 6) ℝ) : ℝ :=
  ∑ i : Fin 3, lam i *
    (triple6 (om i) (om i) η + triple6 (om i) η (om i) + triple6 η (om i) (om i))

/-- **THE WEIGHTED LAPLACIAN OF THE PFAFFIAN IS THE BIANCHI DEFECT, TESTED AT `w`.**

*An identity, with no hypothesis*, which is what the first version of this file failed to state: it
took Bianchi as a hypothesis and concluded the harmonicity, and quantified over every `w` that
conclusion is literally twice the hypothesis at `η = w`, so the theorem was its own assumption.
**Both Gate 2 reviewers found that independently.** Stated as an equation it carries the content:
the left side is `L[Pf(w)]` written as second differences, the right is `⋆(B ∧ w)` at `m = 3`. -/
theorem laplacian_pf_eq_defect
    (lam : Fin 3 → ℝ) (om : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ)
    (w : Matrix (Fin 6) (Fin 6) ℝ) :
    ∑ i : Fin 3, lam i * (pf6 (w + om i) - 2 * pf6 w + pf6 (w - om i))
      = 2 * defectAt lam om w := by
  rw [defectAt, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [pf6_second_diff]; ring

/-- **First Bianchi implies the Pfaffian cubic is harmonic**, now a corollary of the identity rather
than a restatement of its own hypothesis. -/
theorem bianchi_implies_harmonic
    (lam : Fin 3 → ℝ) (om : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ)
    (hB : ∀ η : Matrix (Fin 6) (Fin 6) ℝ, defectAt lam om η = 0)
    (w : Matrix (Fin 6) (Fin 6) ℝ) :
    ∑ i : Fin 3, lam i * (pf6 (w + om i) - 2 * pf6 w + pf6 (w - om i)) = 0 := by
  rw [laplacian_pf_eq_defect, hB w, mul_zero]

/-- **The span-restricted test, which is the reformulation's actual content.** *Harmonicity of the
Pfaffian cubic asks only that the defect vanish at `w(x)` for every `x`, and over all `x` that is the
three tests `η = ω₁, ω₂, ω₃` and nothing more*, three of the fifteen conditions `B = 0` carries in
`Λ⁴ℝ⁶`. **Whether those three imply the fifteen ON THE RICCI-FLAT CLASS is open**, and is what the
block records as unanswered. -/
theorem harmonic_on_span_iff
    (lam : Fin 3 → ℝ) (om : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ) :
    (∀ x : Fin 3 → ℝ,
        ∑ i : Fin 3, lam i *
          (pf6 (∑ j : Fin 3, x j • om j + om i) - 2 * pf6 (∑ j : Fin 3, x j • om j)
            + pf6 (∑ j : Fin 3, x j • om j - om i)) = 0)
      ↔ ∀ x : Fin 3 → ℝ, defectAt lam om (∑ j : Fin 3, x j • om j) = 0 := by
  constructor <;> intro h x
  · have := h x; rw [laplacian_pf_eq_defect] at this; linarith
  · rw [laplacian_pf_eq_defect, h x, mul_zero]

end HamiltonsCubic.L192Statement
