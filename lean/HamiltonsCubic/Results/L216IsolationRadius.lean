import Mathlib.Tactic
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.Calculus.Deriv.Pow

/-!
# Lemma L216, an explicit isolation radius at a nondegenerate critical orbit

[findings/second-order.md](../../../findings/second-order.md), the L216 block.

**What the block says.** Along the great circle `φ(σ) = P(cos σ · W₁ + sin σ · H)` leaving an orbit
point in a unit normal direction, `φ'(0) = 0`, `φ''(0) ≤ -6θ₀γ` by the gap, and `|φ'''| ≤ 27M` by
Bernstein, `M = 1 + √(n-2)` being L143's global bound on `|P|`. So `φ'(σ) < 0` for
`0 < σ < 4θ₀γ/(9M)`, and no point of that open tube is critical.

## What is typed here

**The analytic step, not its arithmetic shadow**, which is the correction the last two Gate 2
rounds asked for. `taylor_bound` is a genuine calculus statement: a function whose derivative is
nonpositive at the start and whose second derivative is bounded above obeys the quadratic bound,
proved from Mathlib's `antitoneOn_of_deriv_nonpos` applied twice. `sign_step` turns the quadratic
bound into strict negativity below the radius, and `no_critical_in_tube` composes the two with the
block's own constants, so the radius `4θ₀γ/(9M)` appears in a type rather than a docstring.

`f`, `f1`, `f2` are `φ'`, `φ''`, `φ'''`.

**Not typed, and Gate 2 found this list incomplete in two places** ([r932]): that `φ` is a
trigonometric polynomial of degree three, Bernstein's inequality for it and L143's `M`, which enter
together as `hbern`; the values `φ'(0) = 0` and `φ''(0) ≤ -6θγ`, which are criticality and L24's
Hessian and enter as `h0` and `h1`; **all of step 1**, the attained distance, the normal geodesic,
the representation `W = cos s · W₁ + sin s · H` and equivariance, which appear nowhere, not even as
hypotheses; and **the final inference** that `φ'(s) < 0` makes the point non-critical, since no `P`,
sphere, orbit or `φ` occurs in this file. *So what type-checks is the real-variable calculus of
step 5, which is weaker than steps 4 and 5* ([r931], [r932]). *Mathlib's
`Mathlib/Analysis/SpecialFunctions/Bernstein.lean` is Bernstein POLYNOMIALS for Weierstrass
approximation, not Bernstein's inequality, which is absent.*
-/

namespace HamiltonsCubic.Results

/-- **THE TAYLOR BOUND.** If `f' = f1`, `f1' = f2`, `f 0 = 0`, `f1 0 ≤ -a` and `f2 ≤ b` on
`[0, ∞)`, then `f s ≤ -a s + (b/2) s²` for every `s ≥ 0`. *Only an UPPER bound on `f2` is used,
which is all the sign argument needs.* -/
theorem taylor_bound {f f1 f2 : ℝ → ℝ} {a b s : ℝ}
    (hf : ∀ u, HasDerivAt f (f1 u) u) (hf1 : ∀ u, HasDerivAt f1 (f2 u) u)
    (hb : ∀ u, 0 ≤ u → f2 u ≤ b) (h0 : f 0 = 0) (h1 : f1 0 ≤ -a) (hs : 0 ≤ s) :
    f s ≤ -a * s + b / 2 * s ^ 2 := by
  -- step A: f1 u ≤ f1 0 + b u on [0, ∞)
  have hk : ∀ u, HasDerivAt (fun u => f1 u - b * u) (f2 u - b) u := by
    intro u
    have h := (hf1 u).sub ((hasDerivAt_id u).const_mul b)
    convert h using 1
    all_goals first | rfl | simp
  have hkanti : AntitoneOn (fun u => f1 u - b * u) (Set.Ici 0) := by
    apply antitoneOn_of_deriv_nonpos (convex_Ici 0)
    · exact fun u _ => (hk u).continuousAt.continuousWithinAt
    · exact fun u _ => (hk u).differentiableAt.differentiableWithinAt
    · intro u hu
      rw [interior_Ici] at hu
      rw [(hk u).deriv]
      linarith [hb u (le_of_lt hu)]
  have hA : ∀ u, 0 ≤ u → f1 u ≤ f1 0 + b * u := by
    intro u hu
    have := hkanti (Set.mem_Ici.mpr le_rfl) (Set.mem_Ici.mpr hu) hu
    simp only at this
    linarith
  -- step B: h u = f u + a u - (b/2) u² is antitone on [0, ∞)
  have hh : ∀ u, HasDerivAt (fun u => f u + a * u - b / 2 * u ^ 2) (f1 u + a - b * u) u := by
    intro u
    have h2 := ((hf u).add ((hasDerivAt_id u).const_mul a)).sub
      ((hasDerivAt_pow 2 u).const_mul (b / 2))
    convert h2 using 1
    all_goals first | rfl | (simp; ring)
  have hhanti : AntitoneOn (fun u => f u + a * u - b / 2 * u ^ 2) (Set.Ici 0) := by
    apply antitoneOn_of_deriv_nonpos (convex_Ici 0)
    · exact fun u _ => (hh u).continuousAt.continuousWithinAt
    · exact fun u _ => (hh u).differentiableAt.differentiableWithinAt
    · intro u hu
      rw [interior_Ici] at hu
      rw [(hh u).deriv]
      linarith [hA u (le_of_lt hu)]
  have := hhanti (Set.mem_Ici.mpr le_rfl) (Set.mem_Ici.mpr hs) hs
  simp only [h0] at this
  nlinarith [this]

/-- **THE SIGN STEP.** The quadratic bound is strictly negative below `2a/b`. -/
theorem sign_step {a b s v : ℝ} (hb : 0 < b) (hs0 : 0 < s) (hsr : s < 2 * a / b)
    (htay : v ≤ -a * s + b / 2 * s ^ 2) : v < 0 := by
  have hbs : b * s < 2 * a := by
    have := (lt_div_iff₀ hb).mp hsr
    linarith
  nlinarith

/-- **NO CRITICAL POINT IN THE TUBE, WITH THE BLOCK'S OWN RADIUS IN THE TYPE.** `f = φ'` along a
unit normal great circle, `h1` is the gap read through L24's Hessian, and `hbern` is Bernstein with
L143's bound. The conclusion `f s < 0` is what makes the point at distance `s` non-critical. -/
theorem no_critical_in_tube {f f1 f2 : ℝ → ℝ} {θ γ M s : ℝ}
    (hf : ∀ u, HasDerivAt f (f1 u) u) (hf1 : ∀ u, HasDerivAt f1 (f2 u) u)
    (hM : 0 < M)
    (hbern : ∀ u, 0 ≤ u → f2 u ≤ 27 * M)
    (h0 : f 0 = 0) (h1 : f1 0 ≤ -(6 * θ * γ))
    (hs0 : 0 < s) (hsr : s < 4 * θ * γ / (9 * M)) :
    f s < 0 := by
  have htay := taylor_bound hf hf1 hbern h0 h1 hs0.le
  have hradius : 4 * θ * γ / (9 * M) = 2 * (6 * θ * γ) / (27 * M) := by
    field_simp
    ring
  rw [hradius] at hsr
  exact sign_step (by positivity) hs0 hsr htay

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.taylor_bound
#print axioms HamiltonsCubic.Results.sign_step
#print axioms HamiltonsCubic.Results.no_critical_in_tube
