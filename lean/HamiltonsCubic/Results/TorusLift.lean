import Mathlib
import HamiltonsCubic.Results.L268Rep
import HamiltonsCubic.Results.J1
import HamiltonsCubic.Results.TorusEmbed

set_option linter.style.longLine false

/-!
# L277 and L282 (1) at every torus-invariant operator

[findings/second-order.md](../../../findings/second-order.md), Lemma L277 (*"H on the torus slice of
$\mathfrak{so}(2m)$"*, for $m\ge7$) and Lemma L282 (1) (every $\mathfrak{so}(k)$ torus slice with $k\le2M$ obeys
$\mathfrak{so}(2M)$'s bound, $M\ge7$, the even case). [J1.lean](J1.lean)'s `H_torus_slice` and
[TorusEmbed.lean](TorusEmbed.lean)'s `H_small_even` state them over `torusOp A U V`; [L268Rep.lean](L268Rep.lean)'s
`L268_rep` makes every self-adjoint operator commuting with each `ad_{J_x}` a `torusOp`. This file:

* `H_torus_slice_op`: for `m = n + 1 ≥ 7`, `F(C, C, C) ≤ κ ‖C‖³` for every such `C` on `𝔰𝔬(2m)`;
* `H_small_even_op`: for `M ≥ 7` and `j + 1 ≤ M`, `F(C, C, C) ≤ κ_{2M} ‖C‖³` for every such `C` on `𝔰𝔬(2(j + 1))`.
-/

namespace HamiltonsCubic.TorusLift

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.L268Rep

/-- **L277 for every torus-invariant self-adjoint operator.** -/
theorem H_torus_slice_op (n : ℕ) (hn : 6 ≤ n) (C : CurvOp2 (Fin (n + 1) × Fin 2))
    (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : skewSub (Fin (n + 1) × Fin 2),
      inner2 ((C X : skewSub (Fin (n + 1) × Fin 2)) : Matrix (Fin (n + 1) × Fin 2) (Fin (n + 1) × Fin 2) ℝ)
          (Y : Matrix (Fin (n + 1) × Fin 2) (Fin (n + 1) × Fin 2) ℝ)
        = inner2 (X : Matrix (Fin (n + 1) × Fin 2) (Fin (n + 1) × Fin 2) ℝ)
          ((C Y : skewSub (Fin (n + 1) × Fin 2)) : Matrix (Fin (n + 1) × Fin 2) (Fin (n + 1) × Fin 2) ℝ)) :
    Ftri C C C ≤ 2 * (((n + 1 : ℕ) : ℝ) - 1) / Real.sqrt ((n + 1 : ℕ) * (2 * ((n + 1 : ℕ) : ℝ) - 1)) *
      (normSq2 C) ^ ((3 : ℝ) / 2) := by
  obtain ⟨hrep, hA, hU, hV⟩ := L268_rep C hT hsa
  rw [hrep]
  exact HamiltonsCubic.J1.H_torus_slice n hn _ _ _ hA hU hV

/-- **L282 (1) for every torus-invariant self-adjoint operator.** -/
theorem H_small_even_op (M : ℕ) (hM : 7 ≤ M) (j : ℕ) (hj : j + 1 ≤ M) (C : CurvOp2 (Fin (j + 1) × Fin 2))
    (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : skewSub (Fin (j + 1) × Fin 2),
      inner2 ((C X : skewSub (Fin (j + 1) × Fin 2)) : Matrix (Fin (j + 1) × Fin 2) (Fin (j + 1) × Fin 2) ℝ)
          (Y : Matrix (Fin (j + 1) × Fin 2) (Fin (j + 1) × Fin 2) ℝ)
        = inner2 (X : Matrix (Fin (j + 1) × Fin 2) (Fin (j + 1) × Fin 2) ℝ)
          ((C Y : skewSub (Fin (j + 1) × Fin 2)) : Matrix (Fin (j + 1) × Fin 2) (Fin (j + 1) × Fin 2) ℝ)) :
    Ftri C C C ≤ HamiltonsCubic.TorusEmbed.kapE M * (normSq2 C) ^ ((3 : ℝ) / 2) := by
  obtain ⟨hrep, hA, hU, hV⟩ := L268_rep C hT hsa
  rw [hrep]
  exact HamiltonsCubic.TorusEmbed.H_small_even M hM j hj _ _ _ hA hU hV

end HamiltonsCubic.TorusLift
