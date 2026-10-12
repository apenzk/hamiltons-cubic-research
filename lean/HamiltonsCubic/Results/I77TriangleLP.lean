import Mathlib.Tactic

/-!
# [I77](../../../plan.md), the triangle-type linear programme

[findings/diagonal-half.md](../../../findings/diagonal-half.md), the I77 block. Splitting the
ordered index triples by how many lie in the positive level set `A` gives counts `t j` with
two linear constraints from the marginal of `T`, and at two eigenvalues `θ` is a linear
functional of them. This file types the programme's closed form and its two exact checks.

`lpObjective` is `θ` as a function of the counts, with the scale `k` factored out;
`vertexValue` is the value at the forced vertex `t₁ = 3(n-2)(N-s)`, `t₃ = (n-2)(3s-N)`.
`lp_vertex_closed_form` is the algebraic simplification the prose does in one line.
The two `sq` theorems are the checks against `θ₀(4)` and `θ₀(12)`, in squared form so the
square roots never appear.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

/-- The numerator of the programme's bound at level-set size `s`: the cubic trace term plus
the vertex value of the triangle sum, before dividing by `√(sN(N-s))`. -/
noncomputable def lpNumerator (n N s : ℝ) : ℝ :=
  (N - 2 * s) + (n - 2) * (N - s) * (4 * s - N) / (2 * s)

/-- **The vertex value simplifies to the prose's closed form.** With the two constraints
forcing `t₁ = 3(n-2)(N-s)` and `t₃ = (n-2)(3s-N)`, the triangle sum
`(s²(N-s)·t₁ + (N-s)³·t₃)/2` divided by `sN(N-s)` is `(n-2)(N-s)(4s-N)/(2s)`. -/
theorem lp_vertex_closed_form (n N s : ℝ) (hs : s ≠ 0) (hN : N ≠ 0) (hNs : N - s ≠ 0) :
    (s ^ 2 * (N - s) * (3 * (n - 2) * (N - s)) + (N - s) ^ 3 * ((n - 2) * (3 * s - N))) / 2
      / (s * N * (N - s))
      = (n - 2) * (N - s) * (4 * s - N) / (2 * s) := by
  field_simp
  ring

/-- **The check at `n = 4`**: with `N = 6` and `s = 2` the bound is `6/√48`, whose square is
`3/4`, and `θ₀(4)² = 2·3·2/16 = 3/4`. -/
theorem lp_bound_sq_n4 :
    lpNumerator 4 6 2 ^ 2 / (2 * 6 * (6 - 2)) = 2 * (4 - 1) * (4 - 2) / (4 : ℝ) ^ 2 := by
  norm_num [lpNumerator]

/-- **The check at `n = 12`**: with `N = 66` and `s = 30` the bound is `330/√71280`, whose
square is `108900/71280`, and `θ₀(12)² = 2·11·10/144 = 220/144`. The two are equal. -/
theorem lp_bound_sq_n12 :
    lpNumerator 12 66 30 ^ 2 / (30 * 66 * (66 - 30)) = 2 * (12 - 1) * (12 - 2) / (12 : ℝ) ^ 2 := by
  norm_num [lpNumerator]

/-- **And the gap at `n = 12` is real**: at `s = 31` the same bound is strictly larger than at
`s = 30`, so the programme alone does not close the case. -/
theorem lp_gap_n12 :
    lpNumerator 12 66 30 ^ 2 / (30 * 66 * (66 - 30))
      < lpNumerator 12 66 31 ^ 2 / (31 * 66 * (66 - 31)) := by
  norm_num [lpNumerator]

end HamiltonsCubic.Results
