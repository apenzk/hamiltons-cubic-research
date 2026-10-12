import Mathlib.Tactic
import Mathlib.Algebra.Order.Chebyshev

/-!
# Lemma L206, the trace-form bound on `θ`, and the floor that keeps it off `√(3/2)`

[findings/bounds.md](../../../findings/bounds.md), the trace-form section, and
[routes.md](../../../routes.md)'s `R19`.

At a critical point of `P` on the unit sphere, `e = W/θ` is an idempotent of Fox's algebra and
the multiplication operator `L e` has `1` with multiplicity `p`, `1/2` with multiplicity `d`,
and the remaining `k = D - p - d` eigenvalues free. Two trace identities are on the record:
`tr (L e) = 0` and `tr (L e ^ 2) = κ(n) / θ ^ 2` with `κ(n) = (2n-1)(n-1)/4`. Cauchy-Schwarz on
the free eigenvalues turns the pair into an upper bound on `θ`.

`traceFormDenom` is the denominator `p + d/4 + (2p+d)^2 / (4k)`, and `trace_form_bound` is the
inequality. Both are stated over abstract `p`, `d`, `k`, `θ` and `κ`, so nothing here assumes
the spectrum comes from a Weyl tensor: what is typed is the arithmetic of the two traces.

**`p` is a parameter and not the literal `1`.** It is `1` at every point the record tabulates
except the balanced product in dimension four, where it is `2` and the bound is ATTAINED, which
is `bound_attained_n4`. So the Cauchy-Schwarz step is sharp and no sharpening of it can lower
the bound in general.

`traceFormDenom_lt_succ` is monotonicity in `d`, which is what makes the bound WEAKEST at the
SMALLEST `1/2`-multiplicity and so decides where the route has to be evaluated.

**The parameter `d` is the MULTIPLICITY OF `1/2`, not the orbit dimension.** The two agree
exactly when the excess is zero, and the orbit tangent is a lower bound for the first by (G3),
so `d ≥ dim (orbit)` always. This distinction is what the floor statements below turn on.

`floor_n12` is the fence post at the dimension the programme cares about, and it is
CONDITIONAL: at `d = 66 = dim SO(12)`, the largest value the orbit tangent alone could supply,
the cap on `θ ^ 2` exceeds `3/2`. `floor_arith` and `third_term_le` carry the same statement
to every `n ≥ 5`.

`threshold_n12_below` and `threshold_n12_at` locate where the conditionality bites: the cap
drops to `3/2` only once `d` reaches `150`, which is `2.27` times `dim SO(12)`. So the bound
reaches the target only at a critical point whose `1/2`-eigenspace exceeds its orbit tangent by
at least `84`, and the route's question is therefore a question about the EXCESS.

**The prose derivation uses self-adjointness of `L e` and this file does not.** Reading
`tr (L e)` and `tr (L e ^ 2)` as sums of real eigenvalues against multiplicities needs `L e`
diagonalisable over the reals, which follows from the total symmetry of the structure tensor:
`⟨e ∘ x, y⟩` is the polarisation of the cubic form, hence symmetric in `x` and `y`. The theorem
below takes the eigenvalue list as given and so is free of it, which is the honest division of
labour between the file and the prose.

**What this file does not state.** That the `L e` spectrum has the assumed shape: `L e e = e`,
`L e = 1/2` on the orbit tangent, and `tr (L e ^ 2) = κ / θ ^ 2` are all taken as hypotheses
here and proved in the prose record, at [second-order.md](../../../findings/second-order.md)
and [algebra.md](../../../findings/algebra.md). Nor any upper bound on the multiplicity of
`1/2`: `d ≤ n(n-1)/2` holds for the orbit tangent, and whether the whole `1/2`-eigenspace
obeys it is exactly the open excess question, so the floor theorems are stated at that value of
`d` rather than proved to cover every critical point.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

open Finset

/-- **The Killing constant of Fox's algebra**, in the Frobenius normalisation this project
uses throughout. Fox's own metric is four times this one, where the value reads
`(2n-1)(n-1)/16` and is `21/16` at `n = 4`. -/
noncomputable def killingConst (n : ℕ) : ℝ := (2 * n - 1) * (n - 1) / 4

/-- **The dimension of the space of Weyl tensors** in dimension `n`, as a real number.
`10` at `n = 4`, `300` at `n = 8`, `1638` at `n = 12`. -/
noncomputable def weylDim (n : ℕ) : ℝ := n * (n + 1) * (n + 2) * (n - 3) / 12

/-- **The denominator of the trace-form bound.** `p` is the multiplicity of the eigenvalue `1`
of `L e`, `d` the multiplicity of `1/2`, and `k` the number of remaining eigenvalues, so
`p + d + k = D`. The multiplicity of `1` is a parameter rather than the literal `1`: it is `2`
at the balanced product in dimension four, which is where the bound turns out to be attained. -/
noncomputable def traceFormDenom (p d k : ℝ) : ℝ := p + d / 4 + (2 * p + d) ^ 2 / (4 * k)

/-- **THE TRACE-FORM BOUND.** Given the two trace identities and the assumed shape of the
`L e` spectrum, Cauchy-Schwarz on the `k` free eigenvalues bounds `θ ^ 2`.

`htr` is `tr (L e) = 0` written as `p + d/2 + ∑ μ = 0`, and `htr2` is
`tr (L e ^ 2) = κ / θ ^ 2` written as `p + d/4 + ∑ μ ^ 2 = κ / θ ^ 2`. -/
theorem trace_form_bound {k : ℕ} (hk : 0 < k) (μ : Fin k → ℝ) (p d θ κ : ℝ)
    (hθ : θ ≠ 0)
    (htr : p + d / 2 + ∑ j, μ j = 0)
    (htr2 : p + d / 4 + ∑ j, (μ j) ^ 2 = κ / θ ^ 2) :
    θ ^ 2 * traceFormDenom p d k ≤ κ := by
  have hkR : (0 : ℝ) < (k : ℝ) := by exact_mod_cast hk
  -- Cauchy-Schwarz: `(∑ μ)^2 ≤ k * ∑ μ^2`.
  have hcs : (∑ j, μ j) ^ 2 ≤ (k : ℝ) * ∑ j, (μ j) ^ 2 := by
    have := sq_sum_le_card_mul_sum_sq (s := (univ : Finset (Fin k))) (f := μ)
    simpa using this
  -- `∑ μ = -(2p + d)/2`, so `(∑ μ)^2 = (2p + d)^2/4`.
  have hsum : ∑ j, μ j = -((2 * p + d) / 2) := by linarith
  have hsq : (2 * p + d) ^ 2 / 4 ≤ (k : ℝ) * ∑ j, (μ j) ^ 2 := by
    rw [hsum] at hcs; nlinarith [hcs]
  -- Hence `∑ μ^2 ≥ (2p+d)^2/(4k)`.
  have hlow : (2 * p + d) ^ 2 / (4 * (k : ℝ)) ≤ ∑ j, (μ j) ^ 2 := by
    rw [div_le_iff₀ (by positivity)]
    nlinarith [hsq]
  -- Substitute into the second trace identity and clear `θ ^ 2 > 0`, for which `θ ≠ 0` suffices:
  -- the SIGN of `θ` is never used, so the bound covers the negative branch too.
  have hθ2 : (0 : ℝ) < θ ^ 2 := by positivity
  have : traceFormDenom p d k ≤ κ / θ ^ 2 := by
    unfold traceFormDenom; rw [← htr2]; linarith
  rw [le_div_iff₀ hθ2] at this
  linarith [this]

/-- **THE BOUND IS ATTAINED**, at the balanced product `S² × S²` in dimension four, where
`p = 2`, `d = 4`, `k = 4`, the four remaining eigenvalues are each `-1`, and `θ² = 3/4` is
`θ₀(4)² = 3/4`. So the Cauchy-Schwarz step is sharp and cannot be improved in general: equality
holds exactly when the free eigenvalues are all equal. -/
theorem bound_attained_n4 :
    killingConst 4 / traceFormDenom 2 4 4 = 3 / 4 := by
  unfold killingConst traceFormDenom
  norm_num

/-- **The denominator increases with the multiplicity of `1/2`**, so the bound is weakest where
that multiplicity is smallest, which by (G3) is where the orbit tangent exhausts the
eigenspace. This is what forces the route to be evaluated at zero excess rather than at a
generic point. -/
theorem traceFormDenom_lt_succ (p d k : ℝ) (hp : 0 ≤ p) (hd : 0 ≤ d) (hk : 0 < k) :
    traceFormDenom p d k < traceFormDenom p (d + 1) k := by
  unfold traceFormDenom
  have key : (2 * p + (d + 1)) ^ 2 / (4 * k) - (2 * p + d) ^ 2 / (4 * k)
      = (4 * p + 2 * d + 1) / (4 * k) := by
    field_simp; ring
  have hgap : (0 : ℝ) ≤ (4 * p + 2 * d + 1) / (4 * k) :=
    div_nonneg (by linarith) (by positivity)
  linarith [key, hgap]

/-- **THE FENCE POST AT `n = 12`.** `κ(12) = 253/4`, `D = 1638`, and at
`d = dim SO(12) = 66`, the largest multiplicity the orbit tangent alone could supply, the cap
on `θ ^ 2` is above `3/2`. With monotonicity this covers every smaller `d` too, so the
trace-form bound certifies `θ ≤ √(3/2)` at no critical point of zero excess. -/
theorem floor_n12 :
    (3 : ℝ) / 2 < killingConst 12 / traceFormDenom 1 66 (1638 - 1 - 66) := by
  unfold killingConst traceFormDenom
  norm_num

/-- **THE THRESHOLD, BELOW.** At `d = 149` the cap is still above `3/2`. -/
theorem threshold_n12_below :
    (3 : ℝ) / 2 < killingConst 12 / traceFormDenom 1 149 (1638 - 1 - 149) := by
  unfold killingConst traceFormDenom
  norm_num

/-- **THE THRESHOLD, AT.** At `d = 150` the cap reaches `3/2`, and `150 = 2.27 × dim SO(12)`.
So the bound reaches the target only where the `1/2`-eigenspace exceeds the orbit tangent by
at least `150 - 66 = 84`, which is the excess the route would have to produce. -/
theorem threshold_n12_at :
    killingConst 12 / traceFormDenom 1 150 (1638 - 1 - 150) ≤ (3 : ℝ) / 2 := by
  unfold killingConst traceFormDenom
  norm_num

/-- **AND AT EVERY `n ≥ 5`.** With `d ≤ n(n-1)/2` the denominator is at most
`1 + n(n-1)/8 + 3/2`, while reaching `3/2` would need it to be at least `2κ(n)/3`, and the
gap is the positivity of `5n^2 - 9n - 56`. The two arithmetic facts are separated out so the
shape of the argument is visible. -/
theorem floor_arith (n : ℕ) (hn : 5 ≤ n) :
    1 + (n : ℝ) * (n - 1) / 8 + 3 / 2 < 2 * killingConst n / 3 := by
  unfold killingConst
  have h : (5 : ℝ) * n ^ 2 - 9 * n - 56 > 0 := by
    have hn' : (5 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
    nlinarith [hn']
  nlinarith [h]

/-- **The third term of the denominator never exceeds `3/2` at `d = n(n-1)/2`**, which is what
lets `floor_arith` carry the whole statement. It is `3/2` exactly at `n = 5` and decreases from
there, the ratio tending to `1/2`. -/
theorem third_term_le (n : ℕ) (hn : 5 ≤ n) :
    (2 + (n : ℝ) * (n - 1) / 2) ^ 2 ≤ 6 * (weylDim n - 1 - (n : ℝ) * (n - 1) / 2) := by
  unfold weylDim
  have h5 : (5 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  -- Clearing denominators, the claim is `0 ≤ n^4 + 2n^3 - 35n^2 + 8n - 40`,
  -- which factors as `(n - 5) * (n^3 + 7n^2 + 8)`: zero at `n = 5`, positive above.
  have hfac : (n : ℝ) ^ 4 + 2 * n ^ 3 - 35 * n ^ 2 + 8 * n - 40
      = ((n : ℝ) - 5) * ((n : ℝ) ^ 3 + 7 * n ^ 2 + 8) := by ring
  have hpos : (0 : ℝ) ≤ ((n : ℝ) - 5) * ((n : ℝ) ^ 3 + 7 * n ^ 2 + 8) :=
    mul_nonneg (by linarith) (by positivity)
  nlinarith [hfac, hpos]

/-!
## The axiom check, recorded where a reader meets it

Every declaration above depends only on the three axioms Mathlib itself rests on, so no `sorry`
hides behind a name and nothing trusts the compiler in place of the kernel:

```
#print axioms trace_form_bound       -- [propext, Classical.choice, Quot.sound]
#print axioms bound_attained_n4      -- [propext, Classical.choice, Quot.sound]
#print axioms traceFormDenom_lt_succ -- [propext, Classical.choice, Quot.sound]
#print axioms floor_n12              -- [propext, Classical.choice, Quot.sound]
#print axioms threshold_n12_below    -- [propext, Classical.choice, Quot.sound]
#print axioms threshold_n12_at       -- [propext, Classical.choice, Quot.sound]
#print axioms floor_arith            -- [propext, Classical.choice, Quot.sound]
#print axioms third_term_le          -- [propext, Classical.choice, Quot.sound]
```

**One object satisfying the hypotheses, so vacuity is visible.** `bound_attained_n4` is that
object: `p = 2`, `d = 4`, `k = 4` is the spectrum of a real critical point, and the bound holds
there with equality rather than trivially.
-/

end HamiltonsCubic.Results
