import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L0, the constant that broke the biconditional, and the split formula that fixes it

[problem.md](../../../findings/problem.md)'s Lemma L0, refuted at Gate 2 as stated and repaired
by both reviewers the same way. The arithmetic deciding the constant is carried here; the
reduction to critical points, with its compactness and Lagrange condition, is
[WeylMaximiser.lean](WeylMaximiser.lean)'s `L0_critical_reduction`.

**The gap is the `margin of four`, divided.** With `θ₀(n)² = 2(n-1)(n-2)/n²` and
`Θₙ² = 2(n-1)(n-3)/((n+1)(n-2))`,

`θ₀² - Θₙ² = 8(n-1) / (n²(n+1)(n-2))`,

and the `8` is `2 × 4` where the `4` is exactly `(n-2)²(n+1) - n²(n-3)`, the constant margin
[L16](L16.lean) records. **So the two blocks turn on one identity**: L16 reads it as a gap that
never closes, L0 as the reason a substituted constant asserted Conjecture A's own negation at
odd `n`. At `n = 13` the difference is `48/13013`.

**The split formula reproduces both recorded values.** `θ_{k,l}² = 2·(n-1)/(n-2)·(1 - (n-1)/kl)`
gives `55/36` at the balanced `(6,6)` and `264/175` at `(5,7)`, the same two numbers
[L5](L5.lean) reaches from the norm formula by a different route. It is strictly increasing in
`kl`, and `4k(n-k) = n² - (n-2k)²` puts the maximum at the balanced split, `(n²-1)/4` at odd `n`.

**And the `⟸` direction gives only `sup ≤ Θₙ`.** Equality needs the balanced product as a
witness, which the block asserted without citing, the half the audit found missing.
-/

namespace HamiltonsCubic.ProblemEquivalence

/-! ## The gap, and its `4` -/

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
def theta0Sq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- `Θₙ²` at odd `n`. -/
def ThetaOddSq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))

/-- **The margin is `4`, identically**, [L16](L16.lean)'s identity, which this gap divides. -/
theorem margin_is_four (n : ℚ) : (n - 2) ^ 2 * (n + 1) - n ^ 2 * (n - 3) = 4 := by ring

/-- **So the gap is `8(n-1)/(n²(n+1)(n-2))`.** -/
theorem gap_closed_form (n : ℚ) (hn : 4 ≤ n) :
    theta0Sq n - ThetaOddSq n = 8 * (n - 1) / (n ^ 2 * ((n + 1) * (n - 2))) := by
  unfold theta0Sq ThetaOddSq
  have h0 : n ≠ 0 := by intro h; linarith
  have h1 : n + 1 ≠ 0 := by intro h; linarith
  have h2 : n - 2 ≠ 0 := by intro h; linarith
  field_simp
  ring

/-- **And it is strictly positive at every `n ≥ 4`**, so `θ₀` overstates `Θₙ` at odd `n`. -/
theorem gap_positive (n : ℚ) (hn : 4 ≤ n) : ThetaOddSq n < theta0Sq n := by
  have h := gap_closed_form n hn
  have hn2 : (0:ℚ) < n - 2 := by linarith
  have hn1 : (0:ℚ) < n + 1 := by linarith
  have hnsq : (0:ℚ) < n ^ 2 := by nlinarith
  have hpos : (0:ℚ) < 8 * (n - 1) / (n ^ 2 * ((n + 1) * (n - 2))) :=
    div_pos (by linarith) (mul_pos hnsq (mul_pos hn1 hn2))
  linarith

/-! ## The witness at `n = 13` -/

theorem values_at_thirteen : theta0Sq 13 = 264 / 169 ∧ ThetaOddSq 13 = 120 / 77 := by
  constructor
  · unfold theta0Sq; norm_num
  · unfold ThetaOddSq; norm_num

/-- **The difference is `48/13013`**, so the substituted constant exceeds the right one there. -/
theorem gap_at_thirteen : (264 : ℚ) / 169 - 120 / 77 = 48 / 13013 := by norm_num

/-! ## The split formula -/

/-- `θ_{k,l}² = 2(n-1)/(n-2) · (1 - (n-1)/(kl))`. -/
def splitSq (n kl : ℚ) : ℚ := 2 * (n - 1) / (n - 2) * (1 - (n - 1) / kl)

/-- **It reproduces both recorded values at `n = 12`**: `55/36` balanced, `264/175` at `(5,7)`. -/
theorem split_values :
    splitSq 12 36 = 55 / 36 ∧ splitSq 12 35 = 264 / 175 := by
  constructor <;> (unfold splitSq; norm_num)

/-- **And it is strictly increasing in `kl`.** -/
theorem split_increasing {n a b : ℚ} (hn : 4 ≤ n) (ha : 0 < a) (hab : a < b) :
    splitSq n a < splitSq n b := by
  unfold splitSq
  have hb : (0:ℚ) < b := by linarith
  have hfac : (0:ℚ) < 2 * (n - 1) / (n - 2) := by
    apply div_pos (by linarith) (by linarith)
  have hinner : (n - 1) / b < (n - 1) / a := by
    apply div_lt_div_of_pos_left (by linarith) ha hab
  nlinarith [hfac, hinner]

/-- **The balanced split maximises `kl`**: `4k(n-k) = n² - (n-2k)²`, so the product is largest
where `n - 2k` is smallest, `(n²-1)/4` at odd `n`. -/
theorem product_identity (n k : ℚ) : 4 * (k * (n - k)) = n ^ 2 - (n - 2 * k) ^ 2 := by ring

theorem odd_balanced_product (m : ℚ) :
    4 * (m * ((2 * m + 1) - m)) = (2 * m + 1) ^ 2 - 1 := by ring

/-! ## The `n ≤ 11` clause carries live content -/

/-- At `n = 10` the sphere value `36/25` sits **below** the `ℂP²` competitor's `3/2`, so the
published conjecture's second clause is not implied by the `n ≥ 12` one. -/
theorem ten_clause_live : theta0Sq 10 = 36 / 25 ∧ (36 : ℚ) / 25 < 3 / 2 := by
  constructor
  · unfold theta0Sq; norm_num
  · norm_num

/-! ## The `⟸` direction stops at `≤` -/

/-- **From criticality of the maximiser one gets `sup ≤ Θₙ` and no more.** The reverse
inequality needs a point attaining `Θₙ`, which is a citation rather than an argument. -/
theorem backward_gives_only_le {P Θ s : ℚ} (hcrit : P ≤ Θ) (hmax : s = P) : s ≤ Θ := by
  rw [hmax]; exact hcrit

/-- And equality genuinely needs the witness: `s ≤ Θ` alone leaves `s < Θ` open. -/
theorem equality_needs_witness : ∃ s Θ : ℚ, s ≤ Θ ∧ s ≠ Θ := ⟨0, 1, by norm_num, by norm_num⟩

end HamiltonsCubic.ProblemEquivalence
