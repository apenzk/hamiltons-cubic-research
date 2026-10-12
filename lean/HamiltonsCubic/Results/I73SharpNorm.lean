import Mathlib

set_option linter.style.longLine false

/-!
# The norm of Hamilton's `#`: idempotents outside the trace window satisfy statement H

[The D6 working note](../../../reviews/2026-09-26-I73-class-ceiling.md), batch 30, approach 1. A maximiser of
`F(X) = ⟨X#X, X⟩` on the unit sphere of `Sym² so(n)` gives a `#`-idempotent `C = X/κ` with `‖C‖ = 1/κ`, so
statement H (`κ = (n-2)/√N`) is `‖C‖² ≥ N/(n-2)²` for every nonzero idempotent. Pairing `C#C = C` with `I` and
using the scalars of `I#` on the trace, traceless-Ricci, Weyl and `Λ⁴` components gives, with `s = tr C`,
`a = ‖C₁‖²`, `c = ‖C₂‖²`, `b = ‖C₃‖²` and `N = n(n-1)/2`,

  `s = (n-2) s²/N + (n-4)/2 · a - c + 2 b`,   `‖C‖² = s²/N + a + b + c`.

## What is proved

* `idem_norm_eq`: eliminating the Weyl part, `‖C‖² = 2 s²/n - s + (n-2)/2 · a + 3 b`.
* `outer_bound`: `N/(n-2)² ≤ 2 s²/n - s` whenever `s ≤ -n/(2(n-2))` or `s ≥ N/(n-2)`.
* `window_bound`: for `n ≥ 8`, `s_- ≤ s ≤ N/(n-2)` with `s_- = (n-1)(n-4)/(2(n-2))` and the Weyl part
  nonnegative, `N/(n-2)² ≤ ‖C‖²`.
* `idem_norm_ge`: for `n ≥ 9` and `s ∉ (-n/(2(n-2)), s_-)`, `N/(n-2)² ≤ ‖C‖²`.

## What is NOT stated

The operator identity itself (the pairing with `I` and the four scalars of `I#`) enters as the hypothesis
`hstar`; the trace window `-n/(2(n-2)) < s < s_-`, where every involutive automorphism attains equality, is open.
-/

namespace HamiltonsCubic.I73SharpNorm

/-- Eliminating the Weyl component from the idempotent identity. -/
theorem idem_norm_eq (n s a b c q : ℝ) (hn : 0 < n) (hn1 : 0 < n - 1)
    (hstar : s = (n - 2) * s ^ 2 / (n * (n - 1) / 2) + (n - 4) / 2 * a - c + 2 * b)
    (hq : q = s ^ 2 / (n * (n - 1) / 2) + a + b + c) :
    q = 2 * s ^ 2 / n - s + (n - 2) / 2 * a + 3 * b := by
  have hc : c = (n - 2) * s ^ 2 / (n * (n - 1) / 2) + (n - 4) / 2 * a + 2 * b - s := by linarith
  rw [hq, hc]
  field_simp
  ring

/-- The outer range: the free components can only raise `‖C‖²`. -/
theorem outer_bound (n s : ℝ) (hn : 2 < n)
    (hs : s ≤ -n / (2 * (n - 2)) ∨ n * (n - 1) / 2 / (n - 2) ≤ s) :
    n * (n - 1) / 2 / (n - 2) ^ 2 ≤ 2 * s ^ 2 / n - s := by
  have hn0 : 0 < n := by linarith
  have hn2 : 0 < n - 2 := by linarith
  have key : 2 * s ^ 2 / n - s - n * (n - 1) / 2 / (n - 2) ^ 2
      = 2 / n * ((s + n / (2 * (n - 2))) * (s - n * (n - 1) / 2 / (n - 2))) := by
    field_simp
    ring
  have hprod : 0 ≤ (s + n / (2 * (n - 2))) * (s - n * (n - 1) / 2 / (n - 2)) := by
    have hr : -n / (2 * (n - 2)) ≤ n * (n - 1) / 2 / (n - 2) := by
      have h1 : -n / (2 * (n - 2)) ≤ 0 := by
        apply div_nonpos_of_nonpos_of_nonneg <;> nlinarith
      have h2 : 0 ≤ n * (n - 1) / 2 / (n - 2) := by
        apply div_nonneg <;> nlinarith
      linarith
    rcases hs with hs | hs
    · have e : -n / (2 * (n - 2)) = -(n / (2 * (n - 2))) := by ring
      apply mul_nonneg_of_nonpos_of_nonpos <;> linarith
    · have h1 : 0 ≤ n / (2 * (n - 2)) := div_nonneg hn0.le (by linarith)
      have h2 : 0 ≤ n * (n - 1) / 2 / (n - 2) := by apply div_nonneg <;> nlinarith
      apply mul_nonneg <;> linarith
  have : 0 ≤ 2 / n * ((s + n / (2 * (n - 2))) * (s - n * (n - 1) / 2 / (n - 2))) :=
    mul_nonneg (by positivity) hprod
  linarith

/-- The inner range `[s_-, N/(n-2)]`, where the nonnegative Weyl part forces the Ricci and `Λ⁴` parts up. -/
theorem window_bound (n s a b : ℝ) (hn : 8 ≤ n) (_ha : 0 ≤ a) (hb : 0 ≤ b)
    (hlo : (n - 1) * (n - 4) / (2 * (n - 2)) ≤ s) (hhi : s ≤ n * (n - 1) / 2 / (n - 2))
    (hweyl : s - (n - 2) * s ^ 2 / (n * (n - 1) / 2) ≤ (n - 4) / 2 * a + 2 * b) :
    n * (n - 1) / 2 / (n - 2) ^ 2 ≤ 2 * s ^ 2 / n - s + (n - 2) / 2 * a + 3 * b := by
  have hn4 : 0 < n - 4 := by linarith
  have hn1 : 0 < n - 1 := by linarith
  have hn0 : 0 < n := by linarith
  -- `(n-2)/2 a + 3 b ≥ (n-2)/(n-4) ((n-4)/2 a + 2 b)` since `2(n-2) ≤ 3(n-4)` at `n ≥ 8`
  have hmix : (n - 2) / (n - 4) * ((n - 4) / 2 * a + 2 * b) ≤ (n - 2) / 2 * a + 3 * b := by
    have e : (n - 2) / (n - 4) * ((n - 4) / 2 * a + 2 * b) = (n - 2) / 2 * a + 2 * (n - 2) / (n - 4) * b := by
      field_simp
    rw [e]
    have : 2 * (n - 2) / (n - 4) ≤ 3 := by
      rw [div_le_iff₀ hn4]; linarith
    nlinarith
  have hup : (n - 2) / (n - 4) * (s - (n - 2) * s ^ 2 / (n * (n - 1) / 2))
      ≤ (n - 2) / (n - 4) * ((n - 4) / 2 * a + 2 * b) :=
    mul_le_mul_of_nonneg_left hweyl (div_nonneg (by linarith) hn4.le)
  have key : 2 * s ^ 2 / n - s + (n - 2) / (n - 4) * (s - (n - 2) * s ^ 2 / (n * (n - 1) / 2))
      - n * (n - 1) / 2 / (n - 2) ^ 2
      = 2 / ((n - 4) * (n - 1)) * ((s - (n - 1) * (n - 4) / (2 * (n - 2))) * (n * (n - 1) / 2 / (n - 2) - s)) := by
    have : (n - 2) ≠ 0 := by linarith
    field_simp
    ring
  have hprod : 0 ≤ 2 / ((n - 4) * (n - 1)) * ((s - (n - 1) * (n - 4) / (2 * (n - 2))) * (n * (n - 1) / 2 / (n - 2) - s)) := by
    apply mul_nonneg (by positivity)
    apply mul_nonneg <;> linarith
  linarith

/-- Statement H on every idempotent whose trace lies outside the window `(-n/(2(n-2)), s_-)`. -/
theorem idem_norm_ge (n s a b c q : ℝ) (hn : 9 ≤ n) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c)
    (hstar : s = (n - 2) * s ^ 2 / (n * (n - 1) / 2) + (n - 4) / 2 * a - c + 2 * b)
    (hq : q = s ^ 2 / (n * (n - 1) / 2) + a + b + c)
    (hs : s ≤ -n / (2 * (n - 2)) ∨ (n - 1) * (n - 4) / (2 * (n - 2)) ≤ s) :
    n * (n - 1) / 2 / (n - 2) ^ 2 ≤ q := by
  have hq' := idem_norm_eq n s a b c q (by linarith) (by linarith) hstar hq
  rw [hq']
  rcases hs with hs | hs
  · have := outer_bound n s (by linarith) (Or.inl hs)
    nlinarith
  · rcases le_or_gt s (n * (n - 1) / 2 / (n - 2)) with hhi | hhi
    · exact window_bound n s a b (by linarith) ha hb hs hhi (by linarith)
    · have := outer_bound n s (by linarith) (Or.inr hhi.le)
      nlinarith

/-- Vacuity check: `C = I/(n-2)` at `n = 9` (`s = N/(n-2) = 36/7`, all traceless parts zero) meets `hstar`. -/
example : (36 / 7 : ℝ) = (9 - 2) * (36 / 7) ^ 2 / (9 * (9 - 1) / 2) + (9 - 4) / 2 * 0 - 0 + 2 * 0 := by
  norm_num

end HamiltonsCubic.I73SharpNorm
