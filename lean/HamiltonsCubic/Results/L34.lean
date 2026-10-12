import HamiltonsCubic.Base.Curvature

/-!
# L34, the construction's load-bearing step

L34 exhibits, at `m = 6` and `m = 8`, a `W ∈ 𝒲ₘ` with exactly two negative
eigenvalues and full support, by padding two copies of a `𝒲₄` element onto
4-planes and adding. The block's own justification is one sentence:

> Both defining conditions are linear, so the sum is a `𝒲ₘ` element **whatever
> the planes do**.

**The split.** That sentence is a general theorem and is proved here, in the
kernel, at every `n`. What it does not give, the eigenvalue count, the support
dimension, the spectra and the `θ` values, needs the explicit witnesses and is
not in this file.

The point of separating them is that the linearity step is what makes the
construction work for *any* pair of planes; the witnesses only show that some
particular pair lands where the statement wants.
-/

namespace HamiltonsCubic.Base

open Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {n : ℕ}


theorem inner2_add_right (X Y Z : Matrix ι ι ℚ) :
    inner2 X (Y + Z) = inner2 X Y + inner2 X Z := by
  unfold inner2
  rw [Matrix.mul_add, Matrix.trace_add]
  ring

theorem bianchiOf_add (R S : Matrix ι ι ℚ → Matrix ι ι ℚ) (i j k l : ι) :
    bianchiOf (fun X => R X + S X) i j k l
      = bianchiOf R i j k l + bianchiOf S i j k l := by
  unfold bianchiOf
  simp only [inner2_add_left]
  ring

theorem RicOf_add (R S : Matrix ι ι ℚ → Matrix ι ι ℚ) (a b : ι) :
    RicOf (fun X => R X + S X) a b = RicOf R a b + RicOf S a b := by
  unfold RicOf
  simp only [inner2_add_left, Finset.sum_add_distrib]

/-- **`𝒲ₙ` is closed under addition.** Symmetry, first Bianchi and
Ricci-flatness are each linear in the operator, so a sum of Weyl operators is a
Weyl operator, with no hypothesis relating the two summands, which is exactly
what lets L34's construction use *any* pair of planes. -/
theorem IsWeylOf.add {R S : Matrix ι ι ℚ → Matrix ι ι ℚ} (hR : IsWeylOf R) (hS : IsWeylOf S) :
    IsWeylOf (fun X => R X + S X) := by
  obtain ⟨hRs, hRb, hRr⟩ := hR
  obtain ⟨hSs, hSb, hSr⟩ := hS
  refine ⟨?_, ?_, ?_⟩
  · intro X Y hX hY
    rw [inner2_add_left, hRs X Y hX hY, hSs X Y hX hY, inner2_add_right]
  · intro i j k l
    rw [bianchiOf_add, hRb, hSb, add_zero]
  · intro a b
    rw [RicOf_add, hRr, hSr, add_zero]

end HamiltonsCubic.Base
