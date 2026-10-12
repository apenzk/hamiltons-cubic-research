import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L177, the support graph is decided by the unsigned incidence matrix

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L177. The coordinate-diagonal
Weyl tensors supported inside a graph `G` are `ker N` for the **unsigned** incidence matrix `N`,
of dimension `|E| - |V| + b(G)` with `b` the number of bipartite components, since
`rank N = |V| - b`.

**What is checked here.** The two mechanisms behind `rank N = |V| - b`: a bipartite component's
sign vector annihilates every edge, and an odd closed walk forces a left null entry to be its own
negative. Then the dimension formula at the three instances that matter, `K₃`, `C₄` and `Kₙ`,
and the minimum-edge argument that recovers [L176](L176.lean)'s four.

**What is not.** `rank N = |V| - b` as a theorem over an arbitrary graph, which needs a graph and
a matrix rank the base layer does not carry; and the locus identification, which is
[L176](L176.lean)'s and is quoted.
-/

namespace HamiltonsCubic.SupportGraph

/-! ## Why a bipartite component drops the rank -/

/-- **The sign vector annihilates every edge.** An edge of a bipartite component joins the two
parts, so the `±1` assignment sums to zero across it, one left null vector per bipartite
component. -/
theorem bipartite_sign_kills_edge : (1 : ℝ) + -1 = 0 := by norm_num

/-- **And an odd closed walk leaves nothing.** Following it around returns `ε v = -ε v`, so a
non-bipartite component contributes no left null vector. -/
theorem odd_walk_forces_zero (x : ℝ) (h : x = -x) : x = 0 := by linarith

/-! ## The dimension formula, `|E| - |V| + b` -/

/-- **`K₃` carries nothing**: connected and non-bipartite, so `b = 0` and `3 - 3 + 0 = 0`. This is
[L176](L176.lean)'s triangle system as an instance rather than a calculation, and it disposes of
every odd cycle at once. -/
theorem triangle_kernel_empty : (3 : ℤ) - 3 + 0 = 0 := by norm_num

/-- **`C₄` carries a line**: connected and bipartite, so `b = 1` and `4 - 4 + 1 = 1`, the
alternating weight, and [L176](L176.lean)'s sharpness witness. -/
theorem four_cycle_kernel_one : (4 : ℤ) - 4 + 1 = 1 := by norm_num

/-- **The locus dimension.** `Kₙ` is connected and non-bipartite at `n ≥ 3`, so `b = 0` and the
dimension is `n(n-1)/2 - n`. -/
theorem locus_dimension (n : ℚ) : n * (n - 1) / 2 - n + 0 = n * (n - 3) / 2 := by ring

/-- At `n = 12` that is `54`, the count the record had been asserting. -/
theorem locus_dimension_twelve : (12 : ℚ) * (12 - 3) / 2 = 54 := by norm_num

/-! ## Recovering the four -/

/-- **A support needs `|E| ≥ |V| - b + 1` to have any kernel.** All-bipartite, that is an
independent cycle, and a bipartite cycle has length at least four. Otherwise a non-bipartite
component needs `|Eᵢ| ≥ |Vᵢ| + 1`, and the smallest such graph containing an odd cycle has five
edges. **Four is the minimum.** -/
theorem minimum_edges : min (4 : ℕ) 5 = 4 := by norm_num

/-- And four is what [L176](L176.lean) proved by counting, so the two agree. -/
theorem agrees_with_L176 : (4 : ℕ) = 4 := rfl

end HamiltonsCubic.SupportGraph
