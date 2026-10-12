import Mathlib
import HamiltonsCubic.Results.L260One

set_option linter.style.longLine false

/-!
# L264 (1): `Sym² 𝔥` is closed under `#`

[findings/second-order.md](../../../findings/second-order.md), Lemma L264, proof (1): *"$\operatorname{Sym}^2\mathfrak h$
is closed under $\#$"*, which is what lets $\mathfrak h$'s own `#` be read as $\mathfrak{so}(n)$'s restricted. This file:

* `rk1_expand`: a self-adjoint operator is $\sum_k\lambda_k\,b_kb_k^{\mathsf T}$ in an eigenbasis;
* `sharp_closed`: for $\mathfrak h\subseteq\mathfrak{so}(n)$ closed under the bracket and $A$ self-adjoint with range in
  $\mathfrak h$, $A\#A$ has range in $\mathfrak h$, since $A\#A=\tfrac12\sum\lambda_i\lambda_j[b_i,b_j][b_i,b_j]^{\mathsf T}$
  (`sharp_rk1_sum`) and $b_k\in\mathfrak h$ whenever $\lambda_k\ne0$.
-/

namespace HamiltonsCubic.L264Sym

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.L260One

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **A self-adjoint operator in its eigenbasis**: `A = ∑ λ_k b_k b_kᵀ`. -/
theorem rk1_expand {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) (A : CurvOp2 ι)
    (lam : Fin N → ℝ) (hAb : ∀ β, A (ofSk (b β)) = lam β • ofSk (b β)) :
    A = ∑ k, lam k • rk1 (ofSk (b k)) := by
  refine ContinuousLinearMap.ext fun Z => ?_
  conv_lhs => rw [onb_expand b Z]
  simp only [map_sum, map_smul, hAb, _root_.sum_apply, _root_.smul_apply, rk1_apply, smul_smul]
  exact Finset.sum_congr rfl fun k _ => by rw [mul_comm]

/-- **`Sym² 𝔥` is closed under `#`.** -/
theorem sharp_closed (h : Submodule ℝ (skewSub ι)) (hbr : ∀ X ∈ h, ∀ Y ∈ h, brS X Y ∈ h) (A : CurvOp2 ι)
    (hA : IsSelfAdjoint2 A) (hran : ∀ X, A X ∈ h) (X : skewSub ι) : sharpMapCL A X ∈ h := by
  have hs := opSk_symm hA
  let b := hs.eigenvectorBasis (n := Module.finrank ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) rfl
  let lam := hs.eigenvalues (n := Module.finrank ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) rfl
  have hAb : ∀ β, A (ofSk (b β)) = lam β • ofSk (b β) := fun β => by
    have hh := hs.apply_eigenvectorBasis (n := Module.finrank ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) rfl β
    have h2 : A (ofSk (b β)) = ofSk (opSk A (b β)) := rfl
    rw [h2, hh, ofSk_smul]; rfl
  have hmem : ∀ k, lam k ≠ 0 → ofSk (b k) ∈ h := fun k hk => by
    have := h.smul_mem (lam k)⁻¹ (hran (ofSk (b k)))
    rwa [hAb, smul_smul, inv_mul_cancel₀ hk, one_smul] at this
  rw [rk1_expand b A lam hAb, sharp_rk1_sum, _root_.sum_apply]
  refine Submodule.sum_mem _ fun i _ => ?_
  rw [_root_.sum_apply]
  refine Submodule.sum_mem _ fun j _ => ?_
  rw [_root_.smul_apply, rk1_apply]
  by_cases hij : lam i = 0 ∨ lam j = 0
  · rcases hij with h0 | h0 <;> simp [h0]
  · simp only [not_or] at hij
    exact h.smul_mem _ (h.smul_mem _ (hbr _ (hmem i hij.1) _ (hmem j hij.2)))

end HamiltonsCubic.L264Sym
