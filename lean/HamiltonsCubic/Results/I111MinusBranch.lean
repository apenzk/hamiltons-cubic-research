import Mathlib

set_option linter.style.longLine false

/-!
# I111's `-` branch: the structural half of the combined bound

[reviews/2026-09-22-I111-minus-branch.md](../../../reviews/2026-09-22-I111-minus-branch.md) closes
I111's `-` branch on the equal-`N` ansatz by taking the MAXIMUM of two bounds the record already
held, [r1070](../../../reviews/REVIEW_r1070.md)'s from the Gram shape pin and
[r1069](../../../reviews/REVIEW_r1069.md)'s from `|ψ - π| ≤ 2 arccos f + 2β`.

**BOTH BOUNDS LIVE IN ONE REVIEW, NOT TWO** ([r1078](../../../reviews/REVIEW_r1078.md),
[r1079](../../../reviews/REVIEW_r1079.md) independently): *r1069's own line 45 carries
`Σ cos²ψ_a ≥ (5/2)K`, which with `Σm² ≤ 3M²` yields r1070's bound exactly.* **What is new is the
EVALUATION, that their maximum clears the deficit everywhere, and not the combining.**

**WHAT IS TYPED HERE IS THE STRUCTURE, NOT THE MINIMAX.** *The closure's number,
`min ratio = 1.014293`, is a minimum of a transcendental function over a three-dimensional region
and needs interval arithmetic, which this layer does not have. What IS typeable, and is what makes
the boundary check legitimate, is the MONOTONICITY: the gain factor falls as the permitted
displacement grows, and that displacement grows as `f` falls and as `β` grows.*

## What is proved

* `gainFactor_antitoneOn`: `δ ↦ (1 - cos(π/3 - δ))/√3` is antitone on `[0, π/3]`.
* `displacement_antitone_f`: `f ↦ 2 arccos f + 2β` is antitone, from Mathlib's `antitone_arccos`.
* `gain_max_lower_bound`: if two quantities each bound the gain below, so does their maximum.
  *Trivial as a proposition, and it is the ONLY new logical step in the closure. It is typed
  because the round's whole claim is that nobody had taken it, not because it is deep.*

## What is NOT stated

The minimax value, the surviving region, either input bound's derivation, or anything off the
equal-`u` ansatz.
-/

namespace HamiltonsCubic.I111MinusBranch

open Real

/-- The gain factor at permitted displacement `δ`, as [r1069](../../../reviews/REVIEW_r1069.md)
line 37 writes it. -/
noncomputable def gainFactor (δ : ℝ) : ℝ := (1 - Real.cos (π / 3 - δ)) / Real.sqrt 3

/-- **The gain factor FALLS as the permitted displacement grows**, on `[0, π/3]`.

**WHAT THIS DOES NOT LICENSE IS A BOUNDARY CHECK, AND A FIRST VERSION OF THIS DOCSTRING SAID IT
DID** ([r1078](../../../reviews/REVIEW_r1078.md)). *`δ = 2 arccos f + 2β` is NOT monotone in `f`:
the pinning identity `cos 2β = u_lo(f)/u` makes `β` RISE as `f` rises, while `arccos f` falls, and
the two do not cancel. At `s = 0.455838, u = 0.446191` the displacement runs `15.04°` at
`f = 0.9914`, up to `16.05°` at `f = 0.9930`, then down to `5.77°` at `f = 1`.* **So the minimiser
is INTERIOR in `f`, and checking the endpoints returns `1.0567` and `1.5511` and misses the
minimum at `0.992111` entirely.** *The statement below is true and is used at fixed `β`; the
inference drawn from it was not.* -/
theorem gainFactor_antitoneOn : AntitoneOn gainFactor (Set.Icc 0 (π / 3)) := by
  intro a ha b hb hab
  have h3 : (0:ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  rw [gainFactor, gainFactor, div_le_div_iff_of_pos_right h3, sub_le_sub_iff_left]
  apply Real.cos_le_cos_of_nonneg_of_le_pi
  · linarith [hb.2]
  · linarith [ha.1, Real.pi_pos]
  · linarith [ha.2, hb.1]

/-- **The permitted displacement grows as `f` falls**, from Mathlib's `antitone_arccos`. -/
theorem displacement_antitone_f (β : ℝ) :
    Antitone (fun f : ℝ => 2 * Real.arccos f + 2 * β) := by
  intro x y hxy
  have := Real.arccos_le_arccos hxy
  linarith

/-- **The permitted displacement grows with `β`.** -/
theorem displacement_mono_beta (f : ℝ) :
    Monotone (fun β : ℝ => 2 * Real.arccos f + 2 * β) := by
  intro x y hxy; linarith

/-- **THE COMBINATION STEP, AND IT IS THE ONLY NEW ONE.** Two bounds that each hold at a point
give a third: their maximum.

*Trivial as a proposition, and typed because the closure turns on it rather than because it is
deep. A first version of this docstring justified it by saying neither reviewer had taken the
other's bound; that is FALSE, r1069 derived both, and the justification is withdrawn. Each bound is
short where the other is tight, which is what makes the maximum clear the deficit.* -/
theorem gain_max_lower_bound {gGram gDir gain : ℝ}
    (hG : gGram ≤ gain) (hD : gDir ≤ gain) : max gGram gDir ≤ gain :=
  max_le hG hD

end HamiltonsCubic.I111MinusBranch
