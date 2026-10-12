import Mathlib

set_option linter.style.longLine false

/-!
# I77: one aggregation of the pair cap is redundant, and the cap itself BINDS

[I77](../../../plan.md)'s programme splits the ordered triples of bivector indices by how many lie
in the positive level set, writing `t j` for the mass on triples with exactly `j` indices there.
Its optimum is a forced vertex carrying all mass on `j ∈ {1, 3}`, with
`t 1 = 3(n-2)(N-s)` and `t 3 = (n-2)(3s-N)`, where `N` is the number of bivector indices and `s`
the size of the positive level set. *That derivation is [diagonal-half.md](../../../findings/diagonal-half.md)'s and is not repeated here.*

**What this file types is ARITHMETIC ABOUT ONE AGGREGATION OF THE PAIR CAP, and nothing about whether the cap
binds.** *A first version of this docstring claimed it typed why the cap cannot move the optimum. That is FALSE,
refuted by [r1053](../../../reviews/REVIEW_r1053.md): the `t_j` are defined by a partition and admit THREE
aggregations, and the one over pairs inside the positive level set is violated by the record's own low-branch vertex.* Summed over ordered pairs
the cap `∑_c T_{abc} ≤ 2` IS a bound on the total triple mass, since each ordered triple of distinct
indices is counted exactly once, so the `N(N-1)` caps together give only `∑_j t j ≤ 2N(N-1)`.

**The two facts below are the whole of it.** The vertex total is FREE of `s`, and the resulting
inequality `n - 2 ≤ N - 1` is slack by a factor growing linearly in `n`.

*Classified as AGREEMENT rather than discovery*: [stratum-two-negative.md](../../../findings/stratum-two-negative.md)
already gives the mean of `‖[v_a,v_b]‖²` as `4/(n+1)`, whose ratio against the cap `2` is the
reciprocal of the slack here. It was reached there from the PAIR MARGINAL and here from the TRIPLE
TOTAL, so the two are one fact.
-/

namespace HamiltonsCubic.I77PairCap

/-- **The vertex total is `s`-FREE**, which is what makes the summed pair cap say nothing about
where the positive level set sits. *The `s` cancels identically, at every `n` and every `N`.* -/
theorem vertex_total_s_free (n N s : ℤ) :
    3 * (n - 2) * (N - s) + (n - 2) * (3 * s - N) = 2 * N * (n - 2) := by
  ring

/-- **`2(N-1) = (n-2)(n+1)` at `N = n(n-1)/2`**, stated over `ℤ` with the halving as a hypothesis so
no division enters the proposition. -/
theorem two_mul_pred_card (n N : ℤ) (hN : 2 * N = n * (n - 1)) :
    2 * (N - 1) = (n - 2) * (n + 1) := by
  nlinarith [hN]

/-- **THE CAP IS SLACK, AND THE FACTOR IS `(n+1)/2`.** *Written without division: the vertex total
`2N(n-2)` against the cap `2N(N-1)` is the claim `n - 2 ≤ N - 1`, and `2(N-1) = (n-2)(n+1)` makes
that `2(n-2) ≤ (n-2)(n+1)`, which holds at every `n ≥ 1` once `n ≥ 2` makes `n - 2` nonnegative.* -/
theorem pair_cap_slack (n N : ℤ) (hn : 2 ≤ n) (hN : 2 * N = n * (n - 1)) :
    n - 2 ≤ N - 1 := by
  have h := two_mul_pred_card n N hN
  nlinarith [h, hn]

/-- **So the summed cap holds at the vertex with room to spare**, at every `N ≥ 0`: the vertex
total never approaches the bound the `N(N-1)` pair caps impose on it. -/
theorem vertex_total_le_cap (n N : ℤ) (hn : 2 ≤ n) (hNpos : 0 ≤ N) (hN : 2 * N = n * (n - 1)) :
    2 * N * (n - 2) ≤ 2 * N * (N - 1) := by
  have h := pair_cap_slack n N hn hN
  nlinarith [h, hNpos]

end HamiltonsCubic.I77PairCap
