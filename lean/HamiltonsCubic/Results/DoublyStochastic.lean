import Mathlib.Data.Real.Basic
import Mathlib.Analysis.Convex.Jensen
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# `L52`'s inequality by Jensen and double stochasticity

[L52](L52.lean) derives its bound from *"Schur's theorem gives `K ≺ μ`"* and the equality case from
the strict convexity of `t³ + 3mt²`. **The
inequality needs no Karamata**, which Mathlib does not carry, and neither does the "only if" half of the
equality clause ([DoublyStochasticEq.lean](DoublyStochasticEq.lean)).

**The majorization here is a special one.** `K` is the diagonal of an operator and `μ` its
spectrum, so `Kᵢ = Σⱼ |Uᵢⱼ|² μⱼ` with `U` the diagonalising frame, and `Pᵢⱼ = |Uᵢⱼ|²` is
**doubly stochastic**. Each diagonal entry is therefore a convex combination of eigenvalues, and
that is all the argument uses.

**Jensen then gives the bound row by row.** For convex `g`,
`g(Kᵢ) = g(Σⱼ Pᵢⱼ μⱼ) ≤ Σⱼ Pᵢⱼ g(μⱼ)`, and summing over `i` collapses by the *column* sums:
`Σᵢ Σⱼ Pᵢⱼ g(μⱼ) = Σⱼ g(μⱼ)`. **No majorization, no Abel summation, no sorting.**

**The equality case forces every row tight.** Equality forces
`g(Σⱼ Pᵢⱼ μⱼ) = Σⱼ Pᵢⱼ g(μⱼ)` in every row. For strictly convex `g` that makes `μ` constant on the
support of each row. At a simple spectrum that is a point mass and `U` a signed permutation. At a
repeated eigenvalue a rotation inside the eigenspace is row-tight too, so `U` need not be a permutation, and
[DoublyStochasticEq.lean](DoublyStochasticEq.lean)'s `eq_multiset` shows the diagonal is still a rearrangement of the
spectrum, by counting with the column sums.

**The spectral statement** that `Pᵢⱼ = |Uᵢⱼ|²` is doubly stochastic is proved in
[SchurMajor.lean](SchurMajor.lean) (`diag_doublyStochastic`, with the convex form
`diag_convex_le_spectrum`), and the strict convexity the equality case needs is at
[CubicConvexity](CubicConvexity.lean).
-/

namespace HamiltonsCubic.DoublyStochastic

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- A doubly stochastic matrix: nonnegative, with unit row and column sums. -/
structure IsDoublyStochastic (P : ι → ι → ℝ) : Prop where
  nonneg : ∀ i j, 0 ≤ P i j
  rows : ∀ i, ∑ j, P i j = 1
  cols : ∀ j, ∑ i, P i j = 1

/-! ## The bound, row by row and then summed -/

/-- **Each row is Jensen.** A diagonal entry is a convex combination of eigenvalues, so a convex
`g` is dominated there by the corresponding combination of its values. -/
theorem row_jensen {P : ι → ι → ℝ} (hP : IsDoublyStochastic P) {g : ℝ → ℝ}
    (hg : ConvexOn ℝ Set.univ g) (μ : ι → ℝ) (i : ι) :
    g (∑ j, P i j • μ j) ≤ ∑ j, P i j • g (μ j) :=
  hg.map_sum_le (fun j _ => hP.nonneg i j) (hP.rows i) (fun j _ => Set.mem_univ _)

/-- **Summing collapses by the column sums.** -/
theorem sum_collapses {P : ι → ι → ℝ} (hP : IsDoublyStochastic P) (μ : ι → ℝ) (g : ℝ → ℝ) :
    ∑ i, ∑ j, P i j • g (μ j) = ∑ j, g (μ j) := by
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => ?_
  simp only [smul_eq_mul, ← Finset.sum_mul, hP.cols j, one_mul]

/-- **So the diagonal is dominated by the spectrum, for every convex `g`.** This is the whole of
the majorization step L52 uses, and it needs no majorization. -/
theorem diagonal_le_spectrum {P : ι → ι → ℝ} (hP : IsDoublyStochastic P) {g : ℝ → ℝ}
    (hg : ConvexOn ℝ Set.univ g) (μ : ι → ℝ) :
    ∑ i, g (∑ j, P i j • μ j) ≤ ∑ j, g (μ j) := by
  calc ∑ i, g (∑ j, P i j • μ j) ≤ ∑ i, ∑ j, P i j • g (μ j) :=
        Finset.sum_le_sum fun i _ => row_jensen hP hg μ i
    _ = ∑ j, g (μ j) := sum_collapses hP μ g

/-! ## The equality case is a shared frame -/

/-- **Equality forces every row to be tight in Jensen.** With the sum equal and each row bounded,
no row can have slack. -/
theorem equality_forces_rowwise {P : ι → ι → ℝ} (hP : IsDoublyStochastic P) {g : ℝ → ℝ}
    (hg : ConvexOn ℝ Set.univ g) (μ : ι → ℝ)
    (heq : ∑ i, g (∑ j, P i j • μ j) = ∑ j, g (μ j)) (i : ι) :
    g (∑ j, P i j • μ j) = ∑ j, P i j • g (μ j) := by
  have hle : ∀ k : ι, k ∈ Finset.univ →
      g (∑ j, P k j • μ j) ≤ ∑ j, P k j • g (μ j) := fun k _ => row_jensen hP hg μ k
  have htot : ∑ i, g (∑ j, P i j • μ j) = ∑ i, ∑ j, P i j • g (μ j) := by
    rw [heq, sum_collapses hP μ g]
  exact (Finset.sum_eq_sum_iff_of_le hle).1 htot i (Finset.mem_univ i)

/-- A permutation frame gives equality, so the equality case is attained exactly there, the
converse direction being the one L52 states. -/
theorem permutation_gives_equality {P : ι → ι → ℝ} (hP : IsDoublyStochastic P) {g : ℝ → ℝ}
    (μ : ι → ℝ) (σ : ι → ι) (hσ : ∀ i j, P i j = if j = σ i then 1 else 0) :
    ∀ i, g (∑ j, P i j • μ j) = ∑ j, P i j • g (μ j) := by
  intro i
  simp only [hσ, ite_smul, one_smul, zero_smul, Finset.sum_ite_eq', Finset.mem_univ, if_true]

end HamiltonsCubic.DoublyStochastic
