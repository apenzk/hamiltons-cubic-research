import Mathlib.Analysis.Normed.Module.Convex
import Mathlib.Analysis.Convex.Jensen
import Mathlib.Analysis.Convex.Combination
import Mathlib.Tactic.NormNum

/-!
# The polytope maximum, [L55](L55.lean)'s owed convexity, closed

[L55](L55.lean) records as owed *"that the row norm is maximised at the polytope's extreme
points, which is the convexity the statement invokes and this file takes as given"*. It is two
Mathlib facts composed, and needs nothing about the row structure.

**A norm is convex**, and **a convex function on a convex hull is dominated at a generator**. So
for any point of the hull there is a generator at least as large, which is the maximum principle
the statement invokes. The polytope's vertices are a generating set, so the row norm's maximum
over it is attained among them.

**Nothing about rows, Weyl tensors or the ambient dimension enters.** The statement holds in any
real normed space, for any generating set whatever, which is why the block was right to take it
as given, and why the debt closes without touching the block's own mathematics.
-/

namespace HamiltonsCubic.PolytopeMax

open Set

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- **The maximum principle for a norm on a convex hull.** Every point of `convexHull ℝ t` is
dominated in norm by some element of `t`. -/
theorem norm_le_of_mem_convexHull {t : Set E} {x : E} (hx : x ∈ convexHull ℝ t) :
    ∃ y ∈ t, ‖x‖ ≤ ‖y‖ :=
  convexOn_univ_norm.exists_ge_of_mem_convexHull (subset_univ t) hx

/-- **So a polytope's norm maximum sits at a generator.** With `t` the vertex set, no point of the
body exceeds every vertex. -/
theorem no_interior_point_exceeds_all_vertices {t : Set E} {x : E}
    (hx : x ∈ convexHull ℝ t) : ¬ (∀ y ∈ t, ‖y‖ < ‖x‖) := by
  intro hcon
  obtain ⟨y, hy, hle⟩ := norm_le_of_mem_convexHull hx
  exact absurd (hcon y hy) (not_lt.2 hle)

/-- And the bound transfers: any cap holding at every generator holds on the whole hull. -/
theorem cap_transfers {t : Set E} {x : E} {c : ℝ}
    (hx : x ∈ convexHull ℝ t) (hcap : ∀ y ∈ t, ‖y‖ ≤ c) : ‖x‖ ≤ c := by
  obtain ⟨y, hy, hle⟩ := norm_le_of_mem_convexHull hx
  exact le_trans hle (hcap y hy)

end HamiltonsCubic.PolytopeMax
