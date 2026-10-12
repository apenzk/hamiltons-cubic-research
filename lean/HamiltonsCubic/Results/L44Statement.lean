import Mathlib
import HamiltonsCubic.Base.WeylReal

set_option linter.style.longLine false

/-!
# L44, `n ≥ 12` cannot be weakened, STATED

[problem.md](../../../findings/problem.md)'s Lemma L44, quoted verbatim from
[results.md](../../../results.md)'s canonical statement:

> Zero-padded `W_{ℂP²}` is a critical point of `𝒲ₙ` at every `n ≥ 4` with `θ = √(3/2)`, and the
> curvature operator `cI + W` it defines lies on `∂Ω₀`. Böhm–Wilking's invariance criterion at
> that point is exactly `√(3/2) ≤ θ₀(n)` (Lemma L43), which fails for `4 ≤ n ≤ 11` and holds
> from `n = 12`, **the direction *invariance ⇒ dF_R(Φ(R)) ≤ 0* being the first clause of
> Beitz's Lemma 2.3.4, whose hypotheses check.** *The witness is padded and every step is
> kernel-blind; `‖W‖ = 1` is what makes the criterion's inequality homogeneous.* So the cone is
> non-invariant for `4 ≤ n ≤ 11`, by a witness, and the hypothesis `n ≥ 12` in the conjecture is
> forced by the problem rather than by any method. It says nothing about whether the cone is
> invariant at `n ≥ 12`, which is the conjecture itself.

The block also records a second, independent route to the same conclusion, and calls it the
elementary one:

> **The conclusion is overdetermined, and the elementary route is one line at both parities.**
> Padded `W_{ℂP²}` sits at `θ = √(3/2)` at every `n ≥ 4`, while the sphere-product maximum is
> `Θₙ`, so wherever `Θₙ < √(3/2)` the conjecture's conclusion is **false outright**, with the
> padded tensor as witness and no cone theory involved.

**`L44_elementary` below is that route, stated in full over `𝒲ₙ` and proved.** It delivers the
lemma's heading, that the conjecture's conclusion fails for `4 ≤ n ≤ 11` (the hypothesis `n ≥ 12` is
the problem's), from the padded `ℂP²` value as the binder `hwitness` and the arithmetic, and it is the
route the record itself calls overdetermining. [L44Witness.lean](L44Witness.lean) discharges the binder.

## What is NOT typed here

**The cone route, which is the block's own argument.** `Ω₀`, `F = ‖R‖²/‖ric(R)‖²`, `Φ`, the
boundary `∂Ω₀` and Böhm–Wilking's invariance criterion have no Lean base layer in this
repository, and Beitz's Lemma 2.3.4 is about a locally Lipschitz flow on an open cone in a
vector space. What *is* typed of that route is the arithmetic it turns on,
`criterion_lt_of_le_eleven`, `criterion_gt_of_twelve_le` and `roots_between_eleven_and_twelve`
below, which is the whole of the block's numerical content: the criterion `√(3/2) ≤ θ₀(n)`
fails exactly on `4 ≤ n ≤ 11`. **The step from that failure to non-invariance of `Ω₀` is not
stated**, since neither predicate exists here; carrying it in a binder would make the file's
theorem true of any pair of predicates and so say nothing.

*The record's own Lemma L43, that the criterion at the padded witness reads `√(3/2) ≤ θ₀(n)`,
is likewise absent, being about `Q`, `Φ` and the Einstein slice.*

## The padded value, the one input beyond arithmetic

`θ(S⁴(α)) = √(3/2)` at every `n ≥ 4`
([Nienhaus](../../../references/nienhaus-2023-second-best-einstein/notes.md) Thm 4.14(a) at
`n = 4`, then zero-padding) enters as the hypothesis `hwitness`. **The record names this value a
single point of failure for every route to the threshold.** It is proved in the same types by
[CP2Real.lean](CP2Real.lean)'s `Wc_theta`, and [L44Witness.lean](L44Witness.lean) discharges the binder.
`θ(S^p × S^q)² = 2(n-1)(p-1)(q-1)/((n-2)pq)` (the same source, Prop 2.25, squared) is the
definition of `thetaSpSq`.

*`Θₙ` and `θ₀(n)` are different numbers at odd `n`, they differ by
`θ₀(n)² - Θₙ² = 8(n-1)/(n²(n+1)(n-2))`, and the two routes use different ones: the criterion
demands `θ₀(n)` at both parities, while what the diagonal locus attains is `Θₙ`. Both are
carried below, under their own names.*
-/

namespace HamiltonsCubic.L44Statement

open HamiltonsCubic.RealLayer

/-! ## The two constants -/

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`, the value the invariance criterion demands at both parities. -/
noncomputable def theta0Sq (n : ℕ) : ℝ := 2 * ((n : ℝ) - 1) * ((n : ℝ) - 2) / (n : ℝ) ^ 2

/-- `θ(S^p × S^q)² = 2(n-1)(p-1)(q-1)/((n-2)pq)` at `n = p + q`, whose maximum over splits is
`Θₙ²`. -/
noncomputable def thetaSpSq (p q : ℕ) : ℝ :=
  2 * ((p : ℝ) + (q : ℝ) - 1) * ((p : ℝ) - 1) * ((q : ℝ) - 1) /
    (((p : ℝ) + (q : ℝ) - 2) * ((p : ℝ) * (q : ℝ)))

/-! ## The criterion's arithmetic, which is the whole numerical content of the cone route -/

/-- **The criterion fails for `4 ≤ n ≤ 11`**: `θ₀(n)² < 3/2`, the record's `n² - 12n + 8 < 0`. -/
theorem criterion_lt_of_le_eleven {n : ℕ} (h4 : 4 ≤ n) (h11 : n ≤ 11) : theta0Sq n < 3 / 2 := by
  interval_cases n <;> (unfold theta0Sq; norm_num)

/-- **And holds from `n = 12` on**: `θ₀(n)² > 3/2`, the record's `n² - 12n + 8 > 0`. -/
theorem criterion_gt_of_twelve_le {n : ℕ} (h12 : 12 ≤ n) : 3 / 2 < theta0Sq n := by
  have hx : (12 : ℝ) ≤ (n : ℝ) := by exact_mod_cast h12
  unfold theta0Sq
  rw [lt_div_iff₀ (by nlinarith)]
  nlinarith

/-- **What forces the integer threshold is that both roots lie in `(11, 12)`**, stronger than
there being no integer between them. The even root is `6 + 2√7` and the odd one is
`(13 + √97)/2`. -/
theorem roots_between_eleven_and_twelve :
    (11 : ℝ) < 6 + 2 * Real.sqrt 7 ∧ 6 + 2 * Real.sqrt 7 < (13 + Real.sqrt 97) / 2 ∧
      (13 + Real.sqrt 97) / 2 < 12 := by
  have h7 : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt (by norm_num)
  have h7pos : (0 : ℝ) < Real.sqrt 7 := Real.sqrt_pos.mpr (by norm_num)
  have h97 : Real.sqrt 97 ^ 2 = 97 := Real.sq_sqrt (by norm_num)
  have h97pos : (0 : ℝ) < Real.sqrt 97 := Real.sqrt_pos.mpr (by norm_num)
  have hb7 : Real.sqrt 7 < 2.6458 := by nlinarith
  have ha7 : 2.6457 < Real.sqrt 7 := by nlinarith
  have hb97 : Real.sqrt 97 < 9.8489 := by nlinarith
  have ha97 : 9.8488 < Real.sqrt 97 := by nlinarith
  refine ⟨by linarith, by linarith, by linarith⟩

/-! ## The elementary route, in full

`Θₙ²` is pinned by the two clauses that make a real number a maximum: it dominates every split
and some split attains it. **Attainment is what the argument needs**, an upper bound alone
would leave `Θₙ² = 3/2` open. -/

/-- **Every split of every `n` with `4 ≤ n ≤ 11` sits below `3/2`.** -/
theorem thetaSpSq_lt_of_le_eleven {n p q : ℕ} (h4 : 4 ≤ n) (h11 : n ≤ 11)
    (hp : 2 ≤ p) (hq : 2 ≤ q) (hpq : p + q = n) : thetaSpSq p q < 3 / 2 := by
  subst hpq
  have hp9 : p ≤ 9 := by omega
  have hq9 : q ≤ 9 := by omega
  clear h4
  interval_cases p <;> interval_cases q <;>
    first
      | omega
      | (unfold thetaSpSq; norm_num)

/-- **L44, elementary route.** Let `4 ≤ n ≤ 11` and let `M = Θₙ²` be the maximum of
`θ(S^p × S^q)²` over the splits `p + q = n`. Given the padded witness, a unit `W ∈ 𝒲ₙ` with
`P(W) = √(3/2)`, there is a unit Weyl tensor whose `θ²` **exceeds** `M`. So the conjecture's
conclusion `θ ≤ Θₙ` is false at every such `n`, by a witness, and the hypothesis `n ≥ 12` is
forced by the problem rather than by any method.

*The `hwitness` binder carries `θ(S⁴(α)) = √(3/2)` (Nienhaus Thm 4.14(a) plus zero-padding), the only
input beyond arithmetic. [L44Witness.lean](L44Witness.lean)'s `L44_heading` supplies it from
[CP2Real.lean](CP2Real.lean)'s `Wc_theta`.* -/
theorem L44_elementary {n : ℕ} (h4 : 4 ≤ n) (h11 : n ≤ 11) (M : ℝ)
    (hub : ∀ p q : ℕ, 2 ≤ p → 2 ≤ q → p + q = n → thetaSpSq p q ≤ M)
    (hatt : ∃ p q : ℕ, 2 ≤ p ∧ 2 ≤ q ∧ p + q = n ∧ thetaSpSq p q = M)
    (hwitness : ∃ W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ,
      IsWeyl W ∧ normSq W = 1 ∧ Pcubic W = Real.sqrt (3 / 2)) :
    ∃ W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ,
      IsWeyl W ∧ normSq W = 1 ∧ M < Pcubic W ^ 2 := by
  have _ := hub
  obtain ⟨W, hW, hnorm, hP⟩ := hwitness
  refine ⟨W, hW, hnorm, ?_⟩
  have hMlt : M < 3 / 2 := by
    obtain ⟨p, q, hp, hq, hpq, hM⟩ := hatt
    rw [← hM]
    exact thetaSpSq_lt_of_le_eleven h4 h11 hp hq hpq
  have : Pcubic W ^ 2 = 3 / 2 := by
    rw [hP]; exact Real.sq_sqrt (by norm_num)
  rw [this]
  exact hMlt

/-! ## Non-vacuity

The hypotheses of `L44_elementary` quantify over splits, and at every `n` in range there is
one. -/

/-- **At `n = 11` the split `5 + 6` is admissible**, and the record's own value `40/27` sits
short of `3/2` by `1/54`. So the maximum `L44_elementary` runs over is taken on a non-empty
set. -/
theorem eleven_witness : thetaSpSq 5 6 = 40 / 27 ∧ (40 / 27 : ℝ) - 3 / 2 = -(1 / 54) := by
  refine ⟨by unfold thetaSpSq; norm_num, by norm_num⟩

/-- **And at `n = 4` too**, the smallest dimension the lemma covers. -/
theorem four_witness : thetaSpSq 2 2 < 3 / 2 := by unfold thetaSpSq; norm_num

end HamiltonsCubic.L44Statement
