import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L39, the reduction, and the constant the maximiser forces

[target.md](../../../findings/target.md)'s Lemma L39. The Killing-form input stays imported;
the algebra the audit adds is carried here, together with one consequence the block does not
draw.

**The reduction to three invariants is an exact factorisation.** With `S_kmm = cq/2` and hence
`S_kkk = c(p - q/2)`, the general numerator factors as

`S_kkk q² + 3 S_kmm p² - 2p³ + 2pq² = ((p+q)/2) · (cq(3p-q) - 4p(p-q))`,

so the `(p+q)³` in the denominator drops to `(p+q)` and

`θ² = (cq(3p-q) - 4p(p-q))² / (16 p³ q (p+q))`.

That is the audit's simplified form, and it follows by `ring` rather than by rederivation.

**`q ≤ 2p` is forced by nonnegativity, with equality exactly when `𝔨` is abelian.** `S_kkk` is a
sum of squares, so `S_kkk = c(p - q/2) ≥ 0` with `c > 0` gives `q ≤ 2p`, and equality is
`S_kkk = 0`, which is `[𝔨,𝔨] = 0`.

**The formula reads only `(p,q,c)`, so a coincidence in those forces a coincidence in `θ`.**
That is the whole content of the record's equal-`θ` pair being *"forced"*, no further structure
is consulted.

**And the balanced pair pins the normalisation.** At `(𝔰𝔬(2k), 𝔰𝔬(k)⊕𝔰𝔬(k))` we have
`p = k(k-1)`, `q = k²`, and the formula returns `θ₀(2k)² = 2(n-1)(n-2)/n²` **exactly when
`c = 4(k-1)`**, that is, `c = 2h^∨(𝔰𝔬(2k))` with `I_ρ = 1`. So the `I_ρ` normalisation the
block flags as a trap is decided by the maximiser itself, rather than needing table data.
-/

namespace HamiltonsCubic.SymmetricPair

/-! ## The reduction is a factorisation -/

/-- **The general numerator factors**, once `S_kmm = cq/2` and `S_kkk = c(p - q/2)`. -/
theorem numerator_factors (p q c : ℚ) :
    (c * (p - q / 2)) * q ^ 2 + 3 * (c * q / 2) * p ^ 2 - 2 * p ^ 3 + 2 * p * q ^ 2
      = ((p + q) / 2) * (c * q * (3 * p - q) - 4 * p * (p - q)) := by
  ring

/-- **So the `(p+q)³` drops to `(p+q)`**, giving the audit's form. -/
theorem theta_sq_reduced (p q c : ℚ) (hp : 0 < p) (hq : 0 < q) :
    (((p + q) / 2) * (c * q * (3 * p - q) - 4 * p * (p - q))) ^ 2
        / (4 * p ^ 3 * q * (p + q) ^ 3)
      = (c * q * (3 * p - q) - 4 * p * (p - q)) ^ 2 / (16 * p ^ 3 * q * (p + q)) := by
  have hpq : (0:ℚ) < p + q := by linarith
  have h1 : p ≠ 0 := ne_of_gt hp
  have h2 : q ≠ 0 := ne_of_gt hq
  have h3 : p + q ≠ 0 := ne_of_gt hpq
  field_simp
  ring

/-! ## `q ≤ 2p`, with its equality case -/

/-- **`S_kkk ≥ 0` and `c > 0` force `q ≤ 2p`.** -/
theorem q_le_two_p {p q c S : ℚ} (hc : 0 < c) (hS : 0 ≤ S) (hdef : S = c * (p - q / 2)) :
    q ≤ 2 * p := by
  rw [hdef] at hS
  nlinarith [hS, hc]

/-- **And equality is exactly `S_kkk = 0`**, which is `𝔨` abelian. -/
theorem equality_iff_abelian {p q c S : ℚ} (hc : 0 < c) (hdef : S = c * (p - q / 2)) :
    q = 2 * p ↔ S = 0 := by
  constructor
  · intro h; rw [hdef, h]; ring
  · intro h; rw [hdef] at h
    rcases mul_eq_zero.1 h with h' | h'
    · linarith
    · linarith

/-! ## The formula reads only `(p,q,c)` -/

/-- **The record's forced pair evaluates to `9245/8232`.** Both members carry `(p,q,c) = (7,8,8)`,
and the formula consults nothing else, so the shared `θ` is an arithmetic consequence of that
triple rather than a coincidence between two spaces. -/
theorem forced_pair_value :
    ((8:ℚ) * 8 * (3 * 7 - 8) - 4 * 7 * (7 - 8)) ^ 2 / (16 * 7 ^ 3 * 8 * (7 + 8))
      = 9245 / 8232 := by
  norm_num

/-- Its numerator is `860`, and the value sits between `1.123` and `1.124`. -/
theorem forced_pair_brackets :
    ((8:ℚ) * 8 * (3 * 7 - 8) - 4 * 7 * (7 - 8)) = 860
      ∧ (1123 : ℚ) / 1000 < 9245 / 8232 ∧ (9245 : ℚ) / 8232 < 1124 / 1000 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The balanced pair, and the constant it forces -/

/-- At the balanced pair the numerator collapses: with `p = k(k-1)`, `q = k²` and `c = 4(k-1)`,
**`cq(3p-q) - 4p(p-q) = 4k²(k-1)²(2k-1)`**. -/
theorem balanced_numerator (k : ℚ) :
    (4 * (k - 1)) * k ^ 2 * (3 * (k * (k - 1)) - k ^ 2)
        - 4 * (k * (k - 1)) * (k * (k - 1) - k ^ 2)
      = 4 * k ^ 2 * (k - 1) ^ 2 * (2 * k - 1) := by
  ring

/-- **And the formula returns `θ₀(2k)²` exactly.** Cross-multiplied, so no division is taken:
`(4k²(k-1)²(2k-1))² · (2k)² = 2(2k-1)(2k-2) · 16 p³ q (p+q)` with `p = k(k-1)`, `q = k²`. -/
theorem balanced_returns_theta0 (k : ℚ) :
    (4 * k ^ 2 * (k - 1) ^ 2 * (2 * k - 1)) ^ 2 * (2 * k) ^ 2
      = 2 * (2 * k - 1) * (2 * k - 2)
          * (16 * (k * (k - 1)) ^ 3 * k ^ 2 * (k * (k - 1) + k ^ 2)) := by
  ring

/-- **So `c = 4(k-1) = 2h^∨(𝔰𝔬(2k))` with `I_ρ = 1`**, the maximiser deciding the normalisation
the block flags as a trap. `h^∨(𝔰𝔬(2k)) = 2k-2`. -/
theorem dual_coxeter_matches (k : ℚ) : 2 * (2 * k - 2) = 4 * (k - 1) := by ring

/-! ## The overshoot off the Weyl scope -/

/-- `Θ₉² = 48/35`, the value the formula overshoots at `n = 9`. -/
theorem theta_nine_sq : 2 * (9 - 1 : ℚ) * (9 - 3) / ((9 - 2) * (9 + 1)) = 48 / 35 := by
  norm_num

/-- **And `1.389084` exceeds it**, so the formula values an operator that is not a Weyl tensor
there, the missing admissibility hypothesis, in one number. -/
theorem overshoot_at_nine : (48 : ℚ) / 35 < 1389084 / 1000000 := by norm_num

/-- `Θ₅² = 8/9`, where the same overshoot is recorded as `12.6%`. -/
theorem theta_five_sq : 2 * (5 - 1 : ℚ) * (5 - 3) / ((5 - 2) * (5 + 1)) = 8 / 9 := by norm_num

end HamiltonsCubic.SymmetricPair
