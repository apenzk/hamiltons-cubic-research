import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L176, the coordinate-diagonal locus has minimum degree two

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L176, discharging what
[I36](../../../plan.md) owed. A nonzero coordinate-diagonal Weyl tensor has `Λ²`-rank at least
four, so a tensor of rank at most three (padded `W_{ℂP²}` among them), is coordinate-diagonal
in no frame.

**What is checked here.** The two linear systems the proof turns on: the triangle's row sums
force every edge to zero, and the four-cycle's alternating weights cancel at every vertex, which
is the sharpness witness.

**What is not.** The degree-sum counting that reduces `|E| = 3` to the triangle and `|E| ≤ 2` to
a single edge (combinatorics over a graph the base layer does not yet carry) and the identity
`W(f_a ∧ f_b) = K_ab · f_a ∧ f_b` on the locus, which is the definition being quoted.
-/

namespace HamiltonsCubic.DiagonalRank

/-! ## The triangle: three row sums, only the zero solution -/

/-- **`K = 0` on a triangle.** The row sums at the three vertices of `K₃` are `x + y = 0`,
`x + z = 0` and `y + z = 0`, and they have no nonzero solution, which is why a coordinate-
diagonal Weyl tensor cannot have exactly three nonzero sectional entries. -/
theorem triangle_forces_zero (x y z : ℝ) (ha : x + y = 0) (hb : x + z = 0) (hc : y + z = 0) :
    x = 0 ∧ y = 0 ∧ z = 0 := by
  refine ⟨by linarith, by linarith, by linarith⟩

/-- The same statement read as the determinant that kills it: the row-sum matrix of `K₃` is
nonsingular, `det = -2`. -/
theorem triangle_matrix_nonsingular :
    (1 : ℝ) * (0 * 1 - 1 * 1) - 1 * (1 * 1 - 1 * 0) + 0 * (1 * 1 - 0 * 0) = -2 := by norm_num

/-! ## The four-cycle: the bound is attained -/

/-- **Sharpness.** On the cycle `12, 23, 34, 41` with weights `c, -c, c, -c`, every row sum
cancels in pairs, so the locus does carry a tensor of `Λ²`-rank exactly four. -/
theorem four_cycle_row_sums (c : ℝ) :
    (c + -c = 0) ∧ (c + -c = 0) ∧ (-c + c = 0) ∧ (c + -c = 0) := by
  refine ⟨by ring, by ring, by ring, by ring⟩

/-- And the weights are nonzero whenever `c` is, so the rank is four rather than fewer. -/
theorem four_cycle_nonzero (c : ℝ) (hc : c ≠ 0) : c ≠ 0 ∧ -c ≠ 0 := by
  exact ⟨hc, neg_ne_zero.mpr hc⟩

/-! ## A degree-one vertex carries no edge -/

/-- **No vertex has degree one.** Where `a`'s only possibly-nonzero entry is `K a b`, the row sum
is `K a b` itself, so vanishing row sums force it to zero. -/
theorem degree_one_forces_zero (k : ℝ) (h : k + 0 = 0) : k = 0 := by linarith

/-! ## The application: `ℂP²`'s self-dual spectrum -/

/-- **`W_{ℂP²}` has `Λ²`-rank three.** `W⁻ = 0` by self-duality, and `W⁺` is the degenerate case,
proportional to `(2, -1, -1)` on `Λ⁺`, trace-free, and each entry nonzero. -/
theorem cp2_spectrum_traceless_and_nonzero :
    (2 : ℝ) + -1 + -1 = 0 ∧ (2 : ℝ) ≠ 0 ∧ (-1 : ℝ) ≠ 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- Three is below four, which is the whole of the application. -/
theorem three_lt_four : (3 : ℕ) < 4 := by norm_num

end HamiltonsCubic.DiagonalRank
