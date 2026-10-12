import Mathlib

/-!
# L177, stated over the unsigned incidence matrix

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L177 says the coordinate-diagonal
tensors supported inside a graph `G` are exactly `ker N` for the **unsigned** incidence matrix,
of dimension `|E| - |V| + b(G)`, since `rank N = |V| - b(G)`. **Its content is linear algebra over
a graph and needs no curvature base layer.**

*The last of the four results an audit found typable all along.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L177

open Finset Matrix

variable {V E : Type*} [Fintype V] [Fintype E] [DecidableEq V]

/-- The **unsigned** incidence matrix of an edge assignment: `N v e = 1` when `v` is an endpoint
of `e`, and `0` otherwise. The edge `e` is given by its two endpoints. -/
noncomputable def incidence (ends : E → V × V) : Matrix V E ℝ :=
  fun v e => if v = (ends e).1 ∨ v = (ends e).2 then 1 else 0

/-- **The kernel condition IS the vanishing row sum.** A weight `x` lies in `ker N` exactly when
the weights at each vertex sum to zero, which is what makes the coordinate-diagonal locus the
kernel of this matrix. -/
theorem mulVec_apply_eq (ends : E → V × V) (x : E → ℝ) (v : V) :
    (incidence ends).mulVec x v = ∑ e, (if v = (ends e).1 ∨ v = (ends e).2 then x e else 0) := by
  simp [incidence, Matrix.mulVec, dotProduct, ite_mul, zero_mul, one_mul]

/-- The arithmetic behind "a bipartite component's sign vector annihilates every edge": each
edge crosses the two parts, so the `±1` assignment sums to zero across it.

**This is `(1 : ℝ) + -1 = 0` and nothing more.** *It is not the first half of `rank N = |V| - b`,
which quantifies over components and edges; a docstring here claimed it was.* -/
theorem bipartite_sign_kills_edge : (1 : ℝ) + -1 = 0 := by norm_num

/-- The arithmetic behind "an odd closed walk leaves nothing": following it around returns
`ε v = -ε v`.

**This is `x = -x → x = 0` and nothing more**, not the second half of the rank identity. -/
theorem odd_walk_forces_zero (x : ℝ) (h : x = -x) : x = 0 := by linarith

/-- The rank–nullity arithmetic over `ℤ`, where the subtraction is total.

**Note it is stated over `ℤ` here and the theorem below once stated it over `ℕ`**, where truncated
subtraction makes `|E| - |V| + b` read as `b` whenever `|E| < |V|`, which made that theorem's
goal false. -/
theorem dim_ker_eq (nE nV b : ℤ) : nE - (nV - b) = nE - nV + b := by ring

/-! ## The statement itself -/

/-- **The dimension of `ker N`**, which is the counting half of L177(1). *The identification of the
supported tensors WITH `ker N` is not stated here; the goal below is the dimension alone.*

**And the hypothesis restricts no graph.** *Taking `b := |V| - rank N` satisfies it at every graph,
since `rank N ≤ |V|`, so `b` is pinned as the corank rather than constrained to be the bipartite
component count.* **What is proved is therefore rank–nullity restated over `ℤ`, importing no graph
theory**, `rank N = |V| - b(G)` is classical (Zaslavsky's Theorem IV.1, credited there to
Jeurissen and originally van Nuffelen, over any field of characteristic `≠ 2`) and the content it
carries stays outside this file. *At `K₂` the satisfying `b = 1` is the true component count and
`dim ker = 1 - 2 + 1 = 0`, which is also the exact counterexample to the withdrawn `ℕ` form.* -/
theorem finrank_ker_incidence (ends : E → V × V) (b : ℕ)
    (hrank : ((incidence ends).rank : ℤ) = (Fintype.card V : ℤ) - b) :
    (Module.finrank ℝ (LinearMap.ker (Matrix.mulVecLin (incidence ends))) : ℤ) =
      (Fintype.card E : ℤ) - (Fintype.card V : ℤ) + b := by
  have hrn := LinearMap.finrank_range_add_finrank_ker (Matrix.mulVecLin (incidence ends))
  rw [Module.finrank_fintype_fun_eq_card] at hrn
  have hr : Module.finrank ℝ (LinearMap.range (Matrix.mulVecLin (incidence ends)))
      = (incidence ends).rank := rfl
  rw [hr] at hrn
  omega

end HamiltonsCubic.L177
