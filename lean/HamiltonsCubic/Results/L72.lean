import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.FieldSimp

/-!
# L72, the rank-3 stratum is overdetermined

[stratum-two-negative.md](../../../findings/stratum-two-negative.md)'s Lemma L72. The three
criticality rows are pure algebra and the whole argument is carried here.

With spectrum `(λ₁, -a, -b, 0, …)`, `a, b > 0`, trace zero giving `λ₁ = a + b`, and
`T := T_{1,N-1,N}` the only bracket entry the rows see:

* `(i)  T a b   = λ₁(θ - λ₁)`
* `(ii) T λ₁ b  = a(θ + a)`
* `(iii)T λ₁ a  = b(θ + b)`

**A correction to the block's case analysis.** It writes *"`T = 0` fails (ii) outright"*.
It does not: `(ii)` with `T = 0` gives `θ = -a`, which is satisfiable. What fails is the
**pair** `(i)` and `(ii)`, `(i)` forces `θ = λ₁ > 0` and `(ii)` forces `θ = -a < 0`. So the
elimination needs both rows, and `(i)` is the one that does the work.

**No sign hypothesis on `θ` is used anywhere below**, as the audit says; `θ = 3a > 0` comes
out rather than going in.
-/

namespace HamiltonsCubic.RankThree

/-! ## The branch split -/

/-- **`a·(ii) = b·(iii)` gives the branch equation.** Both sides equal `T λ₁ a b`, so
`a²(θ+a) = b²(θ+b)`, which factors as `(a-b)(θ(a+b) + a² + ab + b²) = 0`. -/
theorem branch_split (a b θ T lam : ℚ)
    (hii : T * lam * b = a * (θ + a)) (hiii : T * lam * a = b * (θ + b)) :
    (a - b) * (θ * (a + b) + a ^ 2 + a * b + b ^ 2) = 0 := by
  have h : a ^ 2 * (θ + a) = b ^ 2 * (θ + b) := by
    linear_combination b * hiii - a * hii
  linear_combination h

/-- **The second branch's `θ`**, when `a + b ≠ 0`. -/
theorem second_branch_theta (a b θ : ℚ) (hab : a + b ≠ 0)
    (h : θ * (a + b) + a ^ 2 + a * b + b ^ 2 = 0) :
    θ = -(a ^ 2 + a * b + b ^ 2) / (a + b) := by
  field_simp
  linarith [h]

/-- **On it, `θ + a = -b²/(a+b)`**, the block's next step. -/
theorem second_branch_shift (a b θ : ℚ) (hab : a + b ≠ 0)
    (h : θ = -(a ^ 2 + a * b + b ^ 2) / (a + b)) :
    θ + a = -(b ^ 2) / (a + b) := by
  rw [h]; field_simp; ring

/-- **And then `(ii)` gives `T λ₁² = -ab`**, so `T < 0` whenever `a, b > 0`, impossible for
`T = c²`. Written division-free. -/
theorem second_branch_T (a b θ T lam : ℚ) (hlam : lam = a + b) (hab : a + b ≠ 0)
    (hshift : θ + a = -(b ^ 2) / (a + b))
    (hii : T * lam * b = a * (θ + a)) (hb : b ≠ 0) :
    T * lam ^ 2 = -(a * b) := by
  rw [hshift] at hii
  rw [hlam] at hii ⊢
  field_simp at hii
  field_simp
  linarith [hii]

/-- So the second branch dies: a square cannot be negative. -/
theorem second_branch_impossible {a b T lam c : ℚ} (ha : 0 < a) (hb : 0 < b) (hT : T = c ^ 2)
    (h : T * lam ^ 2 = -(a * b)) : False := by
  have h1 : 0 ≤ T * lam ^ 2 := by rw [hT]; positivity
  nlinarith [h1, h, ha, hb]

/-! ## `T = 0` is killed by (i) together with (ii), not by (ii) alone -/

/-- **`(ii)` with `T = 0` is satisfiable**: it says `θ = -a`. So the block's *"fails (ii)
outright"* overstates what one row does. -/
theorem T_zero_satisfies_ii (a : ℚ) (ha : a ≠ 0) :
    (0 : ℚ) * (a + a) * a = a * ((-a) + a) := by ring

/-- **The pair kills it.** `(i)` forces `θ = λ₁` and `(ii)` forces `θ = -a`, and with
`λ₁ = a + b`, `a > 0`, `b > 0` those are incompatible. -/
theorem T_zero_fails_pair {a b θ lam : ℚ} (ha : 0 < a) (hb : 0 < b) (hlam : lam = a + b)
    (hi : (0 : ℚ) * a * b = lam * (θ - lam)) (hii : (0 : ℚ) * lam * b = a * (θ + a)) :
    False := by
  have hlpos : 0 < lam := by rw [hlam]; linarith
  have h1 : θ = lam := by
    have : lam * (θ - lam) = 0 := by linarith [hi]
    rcases mul_eq_zero.1 this with h | h
    · linarith
    · linarith
  have h2 : θ = -a := by
    have : a * (θ + a) = 0 := by linarith [hii]
    rcases mul_eq_zero.1 this with h | h
    · linarith
    · linarith
  linarith [h1, h2, hlpos, ha]

/-! ## The surviving branch: `a = b` -/

/-- **`a = b` forces `θ = 3a` and `T = 2`.** From `(i)` and `(ii)` with `λ₁ = 2a`, and no
sign hypothesis on `θ`. -/
theorem equal_branch {a θ T : ℚ} (ha : a ≠ 0)
    (hi : T * a * a = (2 * a) * (θ - 2 * a))
    (hii : T * (2 * a) * a = a * (θ + a)) : θ = 3 * a ∧ T = 2 := by
  have hT : T * a = 2 * (θ - 2 * a) := by
    have : (T * a - 2 * (θ - 2 * a)) * a = 0 := by linarith [hi]
    rcases mul_eq_zero.1 this with h | h
    · linarith
    · exact absurd h ha
  have hT2 : 2 * (T * a) = θ + a := by
    have : (2 * (T * a) - (θ + a)) * a = 0 := by linarith [hii]
    rcases mul_eq_zero.1 this with h | h
    · linarith
    · exact absurd h ha
  have hθ : θ = 3 * a := by linarith [hT, hT2]
  refine ⟨hθ, ?_⟩
  have : T * a = 2 * a := by rw [hT, hθ]; ring
  have : (T - 2) * a = 0 := by linarith [this]
  rcases mul_eq_zero.1 this with h | h
  · linarith
  · exact absurd h ha

/-- **Unit norm fixes `a`**: `λ₁² + a² + b² = 6a² = 1`, so the spectrum is `(2,-1,-1)/√6`. -/
theorem unit_norm (a : ℚ) : (2 * a) ^ 2 + a ^ 2 + a ^ 2 = 6 * a ^ 2 := by ring

/-- **And `θ² = 3/2`**: `θ = 3a` with `6a² = 1` gives `θ² = 9a² = 9/6`. -/
theorem theta_sq (a : ℚ) (h : 6 * a ^ 2 = 1) : (3 * a) ^ 2 = 3 / 2 := by linarith [h]

/-! ## Why this stratum and no other -/

/-- **The count crosses at rank 4.** `r` equations against `C(r,3)` live entries:
overdetermined at `3`, determined at `4`, free from `5` on. -/
theorem count_crosses :
    (3 : ℕ) > 3 * 2 * 1 / 6 ∧ (4 : ℕ) = 4 * 3 * 2 / 6 ∧ (5 : ℕ) < 5 * 4 * 3 / 6 := by
  refine ⟨by decide, by decide, by decide⟩

/-! ## The closure is the weaker statement -/

/-- **Forcing a property at every critical point does not force it at every equality point**,
since critical points are a subset. The block calls its closure a different statement from
L29's clause and the weaker of the two; this is that, with nothing else in it. -/
theorem subset_gives_weaker :
    ∃ (S B : Set ℕ) (P : ℕ → Prop), S ⊆ B ∧ (∀ x ∈ S, P x) ∧ ∃ x ∈ B, ¬ P x := by
  refine ⟨{0}, {0, 1}, fun n => n = 0, ?_, ?_, ?_⟩
  · intro x hx; simp only [Set.mem_singleton_iff] at hx; simp [hx]
  · intro x hx; simpa using hx
  · exact ⟨1, by simp, by norm_num⟩

end HamiltonsCubic.RankThree
