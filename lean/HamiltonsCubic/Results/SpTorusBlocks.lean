import Mathlib

/-!
# `𝔰𝔭(k)`'s torus rows as two square completions

[The working note](../../../reviews/2026-09-28l-I117-g2-torus.md) on I117's R48, "The whole system
as two square completions". In the note's notation (`P` the short weights on `ε_i − ε_j`, `Q` those
on `ε_i + ε_j`, `u` the long weights, `a` the Cartan diagonal), with `S = P + Q`, `D = P − Q`, the
definition of `a`, the long rows, the `p`-rows and the `q`-rows of `C # C = C` are equivalent, entry
by entry, to
`(S + diag(a + 2u − 1))² = diag(1 − 2u + a²) − S ⊙ D ⊙ D` (`plus_block`) and
`(D + diag(a − 2u − 1))² = diag(1 + 2u + a²) − D ⊙ S ⊙ S` (`minus_block`). At `D = 0` the first is
[L285]'s square completion.

**Typed**: both identities from the rows (`TorusRows`), Gate 2 [r1893], [r1894]. **Not typed**: the
converse (the two combinations of the rows are invertible, prose), and the derivation of the rows
from `C # C = C` (Gate 2 [r1888], [r1889]).
-/

namespace HamiltonsCubic.SpTorusBlocks

open Matrix

variable {k : ℕ}

/-- The torus rows of `𝔰𝔭(k)`, as the working note displays them, with `P` and `Q` symmetric with
zero diagonal. -/
structure TorusRows (P Q : Matrix (Fin k) (Fin k) ℝ) (u a : Fin k → ℝ) : Prop where
  symP : ∀ i j, P i j = P j i
  symQ : ∀ i j, Q i j = Q j i
  diagP : ∀ i, P i i = 0
  diagQ : ∀ i, Q i i = 0
  ha : ∀ i, a i = 2 * u i ^ 2 + 1 / 2 * ∑ j, (P i j ^ 2 + Q i j ^ 2)
  hlong : ∀ i, u i * (1 - 2 * a i) = ∑ j, P i j * Q i j
  hp : ∀ i j, i ≠ j → P i j * (1 - ((a i + a j) / 2 - (Q i j ^ 2 - P i j ^ 2) / 2))
    = (u i + u j) * Q i j + 1 / 2 * ∑ l, (P i l * P j l + Q i l * Q j l)
  hq : ∀ i j, i ≠ j → Q i j * (1 - ((a i + a j) / 2 + (Q i j ^ 2 - P i j ^ 2) / 2))
    = (u i + u j) * P i j + 1 / 2 * ∑ l, (P i l * Q j l + Q i l * P j l)

/-- The entries of the square of a matrix shifted by a diagonal. -/
lemma sq_diag_entry (M : Matrix (Fin k) (Fin k) ℝ) (τ : Fin k → ℝ) (i j : Fin k) :
    ((M + diagonal τ) * (M + diagonal τ)) i j
      = (M * M) i j + (τ i + τ j) * M i j + (if i = j then τ i ^ 2 else 0) := by
  simp only [add_mul, mul_add, Matrix.add_apply, mul_diagonal, diagonal_mul,
    diagonal_mul_diagonal, diagonal_apply]
  split_ifs <;> ring

variable {P Q : Matrix (Fin k) (Fin k) ℝ} {u a : Fin k → ℝ}

/-- **The `s`-block.** -/
theorem plus_block (h : TorusRows P Q u a) :
    (P + Q + diagonal (fun i => a i + 2 * u i - 1)) * (P + Q + diagonal (fun i => a i + 2 * u i - 1))
      = diagonal (fun i => 1 - 2 * u i + a i ^ 2) - (P + Q) ⊙ (P - Q) ⊙ (P - Q) := by
  ext i j
  rw [sq_diag_entry]
  have hSS : ((P + Q) * (P + Q)) i j
      = (∑ l, (P i l * P j l + Q i l * Q j l)) + ∑ l, (P i l * Q j l + Q i l * P j l) := by
    rw [mul_apply, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun l _ => ?_
    simp only [Matrix.add_apply]
    rw [h.symP l j, h.symQ l j]
    ring
  rw [hSS]
  simp only [Matrix.sub_apply, hadamard_apply, diagonal_apply, Matrix.add_apply]
  by_cases hij : i = j
  · subst hij
    simp only [if_true, h.diagP, h.diagQ]
    have e1 : ∑ l, (P i l * P i l + Q i l * Q i l) = ∑ l, (P i l ^ 2 + Q i l ^ 2) :=
      Finset.sum_congr rfl fun l _ => by ring
    have e2 : ∑ l, (P i l * Q i l + Q i l * P i l) = 2 * ∑ l, P i l * Q i l := by
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun l _ => by ring
    rw [e1, e2]
    linear_combination (-2 : ℝ) * h.ha i + (-2 : ℝ) * h.hlong i
  · simp only [hij, if_false]
    linear_combination (-2 : ℝ) * h.hp i j hij + (-2 : ℝ) * h.hq i j hij

/-- **The `d`-block.** -/
theorem minus_block (h : TorusRows P Q u a) :
    (P - Q + diagonal (fun i => a i - 2 * u i - 1)) * (P - Q + diagonal (fun i => a i - 2 * u i - 1))
      = diagonal (fun i => 1 + 2 * u i + a i ^ 2) - (P - Q) ⊙ (P + Q) ⊙ (P + Q) := by
  ext i j
  rw [sq_diag_entry]
  have hDD : ((P - Q) * (P - Q)) i j
      = (∑ l, (P i l * P j l + Q i l * Q j l)) - ∑ l, (P i l * Q j l + Q i l * P j l) := by
    rw [mul_apply, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun l _ => ?_
    simp only [Matrix.sub_apply]
    rw [h.symP l j, h.symQ l j]
    ring
  rw [hDD]
  simp only [Matrix.sub_apply, hadamard_apply, diagonal_apply, Matrix.add_apply]
  by_cases hij : i = j
  · subst hij
    simp only [if_true, h.diagP, h.diagQ]
    have e1 : ∑ l, (P i l * P i l + Q i l * Q i l) = ∑ l, (P i l ^ 2 + Q i l ^ 2) :=
      Finset.sum_congr rfl fun l _ => by ring
    have e2 : ∑ l, (P i l * Q i l + Q i l * P i l) = 2 * ∑ l, P i l * Q i l := by
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun l _ => by ring
    rw [e1, e2]
    linear_combination (-2 : ℝ) * h.ha i + (2 : ℝ) * h.hlong i
  · simp only [hij, if_false]
    linear_combination (-2 : ℝ) * h.hp i j hij + (2 : ℝ) * h.hq i j hij

end HamiltonsCubic.SpTorusBlocks
