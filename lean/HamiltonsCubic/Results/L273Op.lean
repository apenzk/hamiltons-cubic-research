import Mathlib
import HamiltonsCubic.Results.L268Rep
import HamiltonsCubic.Results.L273Owed

set_option linter.style.longLine false

/-!
# L273 at every torus-invariant operator

[findings/second-order.md](../../../findings/second-order.md), Lemma L273 (3): for $m\ge5$, J1 implies H on the torus
slice, *"for every torus-invariant $X$"*. [I117Statements.lean](I117Statements.lean) proves it over `torusOp A U V`
(`L273_J1_implies_H`) and the bound (1) there (`L273_F_bound`); [L268Rep.lean](L268Rep.lean)'s `L268_rep` makes every
self-adjoint operator commuting with each `ad_{J_x}` a `torusOp`. This file:

* `L273_J1_op`: J1 implies `F(C, C, C) ≤ κ ‖C‖³` for every such `C`, `κ = 2(m - 1)/√(m(2m - 1))`;
* `L273_F_bound_op`: (1)'s bound at every such `C`, in its Gram values `Aof C`, `Uof C`, `Vof C`;
* `L273_F_eq_op`: (1)'s equality case at every such `C` whose Cartan block is a non-negative multiple of `A_μ`, and
  `L273_g_ge_op`: (1)'s `g ≥ 1/√m` at every such `C` on the unit root sphere, from [L273Owed.lean](L273Owed.lean).
-/

namespace HamiltonsCubic.L273Op

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.L268Rep

variable {m : ℕ}

local notation "SK" => skewSub (Fin m × Fin 2)
local notation "MM" => Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ

/-- **L273 (3) for every torus-invariant self-adjoint operator.** -/
theorem L273_J1_op (hm : 5 ≤ m)
    (J1 : ∀ U V : Matrix (Fin m) (Fin m) ℝ, IsPairWeights U → IsPairWeights V →
      (1 / 2 : ℝ) * ((∑ i, ∑ j, (U + V) i j ^ 2) + (∑ i, ∑ j, (U - V) i j ^ 2)) = 1 →
      (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V)))
        + Real.sqrt (2 * m) * ((m : ℝ) - 2) / (((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1))
          * ((∑ i, dvec U V i ^ 2) + ∑ i, ∑ j, if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2)
        ≤ Real.sqrt (2 * m) * ((m : ℝ) - 2) / (((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1)))
    (C : CurvOp2 (Fin m × Fin 2)) (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : SK, inner2 ((C X : SK) : MM) (Y : MM) = inner2 (X : MM) ((C Y : SK) : MM)) :
    Ftri C C C ≤ 2 * ((m : ℝ) - 1) / Real.sqrt (m * (2 * m - 1)) * (normSq2 C) ^ ((3 : ℝ) / 2) := by
  obtain ⟨hrep, hA, hU, hV⟩ := L268_rep C hT hsa
  rw [hrep]
  exact L273_J1_implies_H hm J1 _ _ _ hA hU hV

/-- **L273 (1) for every torus-invariant self-adjoint operator.** -/
theorem L273_F_bound_op (C : CurvOp2 (Fin m × Fin 2)) (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : SK, inner2 ((C X : SK) : MM) (Y : MM) = inner2 (X : MM) ((C Y : SK) : MM)) :
    Ftri C C C ≤ 3 * Real.sqrt (∑ i, ∑ j, Aof C i j ^ 2) * Real.sqrt (∑ i, ∑ j, Amu (Uof C) (Vof C) i j ^ 2)
        + (1 / 2) * (Matrix.trace ((Uof C + Vof C) * (Uof C + Vof C) * (Uof C + Vof C))
          + Matrix.trace ((Uof C - Vof C) * (Uof C - Vof C) * (Uof C - Vof C))) := by
  obtain ⟨hrep, hA, hU, hV⟩ := L268_rep C hT hsa
  have h := L273_F_bound _ _ _ hA hU hV
  rw [← hrep] at h
  exact h

/-- **L273 (1)'s equality case for every torus-invariant self-adjoint operator.** -/
theorem L273_F_eq_op (C : CurvOp2 (Fin m × Fin 2)) (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : SK, inner2 ((C X : SK) : MM) (Y : MM) = inner2 (X : MM) ((C Y : SK) : MM)) (s : ℝ) (hs : 0 ≤ s)
    (hA : Aof C = s • Amu (Uof C) (Vof C)) :
    Ftri C C C = 3 * Real.sqrt (∑ i, ∑ j, Aof C i j ^ 2) * Real.sqrt (∑ i, ∑ j, Amu (Uof C) (Vof C) i j ^ 2)
        + (1 / 2) * (Matrix.trace ((Uof C + Vof C) * (Uof C + Vof C) * (Uof C + Vof C))
          + Matrix.trace ((Uof C - Vof C) * (Uof C - Vof C) * (Uof C - Vof C))) := by
  obtain ⟨hrep, -, hU, hV⟩ := L268_rep C hT hsa
  have h := HamiltonsCubic.L273Owed.L273_F_eq (Uof C) (Vof C) hU hV s hs
  rw [← hA, ← hrep] at h
  exact h

/-- **L273 (1)'s `g ≥ 1/√m` for every torus-invariant self-adjoint operator** on the unit root sphere. -/
theorem L273_g_ge_op (C : CurvOp2 (Fin m × Fin 2))
    (hb : (1 / 2 : ℝ) * ((∑ i, ∑ j, (Uof C + Vof C) i j ^ 2) + (∑ i, ∑ j, (Uof C - Vof C) i j ^ 2)) = 1) :
    1 / Real.sqrt m ≤ Real.sqrt (∑ i, ∑ j, Amu (Uof C) (Vof C) i j ^ 2) :=
  HamiltonsCubic.L273Owed.L273_g_ge (Uof C) (Vof C) hb

end HamiltonsCubic.L273Op
