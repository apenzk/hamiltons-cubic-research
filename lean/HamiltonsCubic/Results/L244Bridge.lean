import Mathlib
import HamiltonsCubic.Results.L244Caps
import HamiltonsCubic.Results.L244RowA

set_option linter.style.longLine false

/-!
# L244: the class family's bracket mass is the record's `b_ab`

[findings/second-order.md](../../../findings/second-order.md), Lemma L244: *$b_{ab}(x)=\langle B_{ab}x,x\rangle=\tfrac12\sum_{\gamma\in
E_a,\delta\in E_b}\langle[\psi_\gamma,\psi_\delta],x\rangle^2$ … with source caps $2\sum_bb_{ab}(x)\le\kappa_{m_a}(x)$.*

The rows (A), (B), (C) are stated in [L244RowA.lean](L244RowA.lean)'s `bAB ψ cls a b x`, a sum over the frame indices of class
`a`; the caps of [L244Caps.lean](L244Caps.lean) are stated for a family `Fin m → Matrix`, the class's own vectors. Reindexing
the class through an equivalence `Fin m ≃ {γ // cls γ = a}` identifies them:

* **`bMass_class`**: `bMass (ψ ∘ e) ψ cls b x = bAB ψ cls a b x`;
* **`rowMass_class`**: `rowMass (ψ ∘ e) ψ x = ∑_b bAB ψ cls a b x`, the quantity the caps bound.
-/

open HamiltonsCubic.RealLayer Matrix

namespace HamiltonsCubic.L244Bridge

variable {n r K m : ℕ}

/-- **The class family's mass is `b_ab`.** -/
theorem bMass_class (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (cls : Fin r → Fin K) (a b : Fin K)
    (e : Fin m ≃ {γ // cls γ = a}) (x : Matrix (Fin n) (Fin n) ℝ) :
    HamiltonsCubic.L244Caps.bMass (fun i => ψ (e i).1) ψ cls b x = HamiltonsCubic.L244RowA.bAB ψ cls a b x := by
  unfold HamiltonsCubic.L244Caps.bMass HamiltonsCubic.L244RowA.bAB
  congr 1
  rw [Finset.sum_subtype (Finset.univ.filter (fun γ => cls γ = a)) (p := fun γ => cls γ = a) (fun γ => by simp)]
  exact Equiv.sum_comp e (fun γ : {γ // cls γ = a} =>
    ∑ δ ∈ Finset.univ.filter (fun δ => cls δ = b), inner2 (br (ψ γ.1) (ψ δ)) x ^ 2)

/-- **The class family's row mass** is `∑_b b_ab`. -/
theorem rowMass_class (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (cls : Fin r → Fin K) (a : Fin K)
    (e : Fin m ≃ {γ // cls γ = a}) (x : Matrix (Fin n) (Fin n) ℝ) :
    HamiltonsCubic.L244Caps.rowMass (fun i => ψ (e i).1) ψ x = ∑ b, HamiltonsCubic.L244RowA.bAB ψ cls a b x := by
  rw [HamiltonsCubic.L244Caps.rowMass_split _ _ cls x]
  exact Finset.sum_congr rfl fun b _ => bMass_class ψ cls a b e x

end HamiltonsCubic.L244Bridge
