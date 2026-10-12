import Mathlib

set_option linter.style.longLine false

/-!
# L23, the subalgebra family: the cap, the closed form, and the bound, in the part that is arithmetic

## The record's statement, verbatim

[ungraded-slack.md](../../../findings/ungraded-slack.md)'s *Lemma L23, the conjecture on the
subalgebra family, and gradedness as the cap, canonical statement and proof*:

> **Statement.** Let $\mathfrak h\subseteq\mathfrak{so}(n)=\Lambda^2\mathbb R^n$ be a subalgebra
> with $\mathfrak m=\mathfrak h^\perp$, $r=\dim\mathfrak h$, $N=\binom n2$ and $0<r<N$, and let
> $W_{\mathfrak h}$ be **either** unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$.
> If $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, then
> $$\theta=\frac2n\sqrt{\frac{rN}{N-r}},\qquad S_{\mathfrak{mmm}}:=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2=(N-r)\Big[2(n-2)-\frac{4(n-1)r}{N}\Big],$$
> hence $r\le n(n-2)/4$, and, **by a second step, the strict monotonicity of
> $r\mapsto rN/(N-r)$, which the proof uses and did not state**, $\theta\le\theta_0(n)$, with
> equality in either place exactly when $S_{\mathfrak{mmm}}=0$, that is, when
> $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, when $W_{\mathfrak h}$ is $\mathbb Z_2$-graded
> in the **sign** sense of [graded-half.md](../../../findings/graded-half.md), and when
> $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. [...] For $n$ even the equality case is
> $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ alone [...] so the maximum over the
> family is attained exactly at the Weyl operator of $S^{n/2}\times S^{n/2}$; for $n$ odd the cap
> is not an integer and the inequality is strict.

with, from the same block,

> On this family the graded-compression slack has the closed form
> $S=\tfrac{r}{nN}[4(N-r)-n^2]$, non-negative under the same condition.

## What is NOT typed here

**The derivation of the two closed forms from criticality.** Getting `θ = (2/n)√(rN/(N−r))` and
the formula for `S_mmm` out of `Q(W_h) = θ W_h` runs through the two scalar equations obtained by
tracing the eigen-equation against `Π_h` and `Π_m`, the Killing relations
`S_hhh + S_hmm = κr` and `2 S_hmm + S_mmm = κ(N−r)` with `κ = 2(n−2)`, and the structure
constants of a Lie subalgebra of `𝔰𝔬(n)` acting on `Λ²`. None of `Π_h`, `Q`, `S_•••` or
"subalgebra of `𝔰𝔬(n)`" has a Lean base layer in this repository, the real Weyl layer carries
`IsWeyl`, `Pcubic`, `norm` and `theta`, and no projector-indexed family, **so the closed forms
are taken here as the definitions of the family's `θ` and `S_mmm`, and what is proved is
everything the block derives FROM them.** That is: the cap, the monotonicity, the bound against
`θ₀(n)`, the equality case, the identification of the slack `S` with the same inequality, the
symmetric-pair arithmetic that isolates the balanced split, and the odd-`n` strictness.

**Also not typed:** that `S_mmm` is a sum of squares (which is what makes it non-negative, here
non-negativity is a hypothesis wherever it is used, named `hS`), and the three sufficient
conditions for membership (`K`-irreducibility and inequivalence, `(Sym²ℝⁿ)^K = ℝ Id`,
`(Λ⁴ℝⁿ)^K = 0`).

**Everything below is over `ℝ` with `n` and `r` real**, so that no truncated subtraction can
enter; integrality is used only in `cap_not_integer_odd`, which is the one clause that needs it.
-/

namespace HamiltonsCubic.L23Statement

open Real

/-! ## The family's data, exactly as the block displays it -/

/-- `N = binom n 2`, as a real number. -/
noncomputable def Ncount (n : ℝ) : ℝ := n * (n - 1) / 2

/-- **The cap** `n(n−2)/4`, the value of `r` at which `S_mmm` vanishes. -/
noncomputable def cap (n : ℝ) : ℝ := n * (n - 2) / 4

/-- **The family's `θ`**, `θ = (2/n)√(rN/(N−r))`. -/
noncomputable def thetaFam (n r : ℝ) : ℝ := (2 / n) * Real.sqrt (r * Ncount n / (Ncount n - r))

/-- **`θ₀(n) = √(2(n−1)(n−2))/n`**, as fixed in
[conventions.md](../../../findings/conventions.md). -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (2 * (n - 1) * (n - 2)) / n

/-- **`S_mmm = (N−r)[2(n−2) − 4(n−1)r/N]`**, the block's second closed form. -/
noncomputable def Smmm (n r : ℝ) : ℝ :=
  (Ncount n - r) * (2 * (n - 2) - 4 * (n - 1) * r / Ncount n)

/-- **The graded-compression slack on this family**, `S = (r/(nN))[4(N−r) − n²]`. -/
noncomputable def slack (n r : ℝ) : ℝ := r / (n * Ncount n) * (4 * (Ncount n - r) - n ^ 2)

/-! ## Two identities that make the rest arithmetic

*Both are `S_mmm` and `S` rewritten around the cap; they are what turns the block's two displays
into statements about `r ≤ n(n−2)/4`.* -/

/-- **`S_mmm = (N−r)·(8/n)·(cap n − r)`.** *`4(n−1)r/N` is `8r/n`, so the bracket is
`(8/n)(cap n − r)`.* -/
theorem Smmm_factored (n r : ℝ) (hn : 3 ≤ n) : Smmm n r = (Ncount n - r) * (8 / n) * (cap n - r) := by
  have hn0 : (0:ℝ) < n := by linarith
  have hn1 : n - 1 ≠ 0 := by intro h; linarith
  unfold Smmm Ncount cap
  field_simp
  ring

/-- **`S = 4r(cap n − r)/(nN)`.** *`4(N−r) − n²` is `4(cap n − r)`.* -/
theorem slack_factored (n r : ℝ) : slack n r = r / (n * Ncount n) * (4 * (cap n - r)) := by
  unfold slack Ncount cap; ring

/-! ## The cap: `S_mmm ≥ 0` is exactly `r ≤ n(n−2)/4` -/

/-- **`S_mmm ≥ 0 ↔ r ≤ n(n−2)/4`**, for `0 < r < N` and `n ≥ 3`. *This is the block's
"hence `r ≤ n(n−2)/4`", with the sum-of-squares non-negativity of `S_mmm` supplying the left
side.* -/
theorem Smmm_nonneg_iff (n r : ℝ) (hn : 3 ≤ n) (hr : 0 < r) (hrN : r < Ncount n) :
    0 ≤ Smmm n r ↔ r ≤ cap n := by
  have hn0 : (0:ℝ) < n := by linarith
  have hdiff : 0 < Ncount n - r := by linarith
  have hc : (0:ℝ) < (Ncount n - r) * (8 / n) := by positivity
  rw [Smmm_factored n r hn]
  constructor
  · intro h
    by_contra hcon
    push_neg at hcon
    nlinarith
  · intro h; nlinarith

/-- **The slack `S` is non-negative under exactly the same condition**, *"the cap is that
inequality restricted here"*, a cross-check rather than independent leverage. -/
theorem slack_nonneg_iff (n r : ℝ) (hn : 3 ≤ n) (hr : 0 < r) :
    0 ≤ slack n r ↔ r ≤ cap n := by
  have hn0 : (0:ℝ) < n := by linarith
  have hN : 0 < Ncount n := by unfold Ncount; nlinarith
  have hc : (0:ℝ) < r / (n * Ncount n) * 4 := by positivity
  rw [slack_factored n r, show r / (n * Ncount n) * (4 * (cap n - r))
      = r / (n * Ncount n) * 4 * (cap n - r) by ring]
  constructor
  · intro h
    by_contra hcon
    push_neg at hcon
    nlinarith
  · intro h; nlinarith

/-- **`S_mmm = 0` is exactly `r = cap n`**, so the two equality clauses of the statement, *"with
equality in either place"*, are one condition. -/
theorem Smmm_eq_zero_iff (n r : ℝ) (hn : 3 ≤ n) (hr : 0 < r) (hrN : r < Ncount n) :
    Smmm n r = 0 ↔ r = cap n := by
  have hn0 : (0:ℝ) < n := by linarith
  have hdiff : 0 < Ncount n - r := by linarith
  have hc : (0:ℝ) < (Ncount n - r) * (8 / n) := by positivity
  rw [Smmm_factored n r hn, mul_eq_zero]
  constructor
  · rintro (h | h)
    · exact absurd h (ne_of_gt hc)
    · linarith
  · intro h; right; rw [h]; ring

/-! ## The bound `θ ≤ θ₀(n)`, and where it is an equality

The block's *"second step, the strict monotonicity of `r ↦ rN/(N−r)`"*, run in the form the
conclusion needs. -/

/-- **`N − cap n = n²/4`**, the identity that makes the closed form evaluate to `θ₀(n)` at the
cap. -/
theorem Ncount_sub_cap (n : ℝ) : Ncount n - cap n = n ^ 2 / 4 := by
  unfold Ncount cap; ring

/-- **`√(4y) = 2√y`**, the one square-root manipulation the closed form needs. -/
private theorem sqrt_four_mul (y : ℝ) (hy : 0 ≤ y) : Real.sqrt (4 * y) = 2 * Real.sqrt y := by
  rw [show (4:ℝ) = 2 ^ 2 by norm_num, Real.sqrt_mul (by positivity), Real.sqrt_sq (by norm_num)]

/-- **The closed form at the cap is exactly `θ₀(n)`.** *`rN/(N−r)` at `r = n(n−2)/4` is
`(n−1)(n−2)/2`, and `(2/n)√((n−1)(n−2)/2) = √(2(n−1)(n−2))/n`.* -/
theorem thetaFam_at_cap (n : ℝ) (hn : 3 ≤ n) : thetaFam n (cap n) = theta0 n := by
  have hn0 : (0:ℝ) < n := by linarith
  unfold thetaFam theta0
  rw [Ncount_sub_cap]
  have hval : cap n * Ncount n / (n ^ 2 / 4) = (n - 1) * (n - 2) / 2 := by
    unfold cap Ncount; field_simp
  have hy : (0:ℝ) ≤ (n - 1) * (n - 2) / 2 := by nlinarith
  rw [hval, show 2 * (n - 1) * (n - 2) = 4 * ((n - 1) * (n - 2) / 2) by ring, sqrt_four_mul _ hy]
  ring

/-- **The bound.** For `0 < r ≤ cap n` and `n ≥ 3`, `θ ≤ θ₀(n)`. *The monotone quantity is
`rN/(N−r)`; both radicands are non-negative on the range, so the square roots compare.* -/
theorem thetaFam_le_theta0 (n r : ℝ) (hn : 3 ≤ n) (hr : 0 < r) (hcap : r ≤ cap n) :
    thetaFam n r ≤ theta0 n := by
  have hn0 : (0:ℝ) < n := by linarith
  have hN : 0 < Ncount n := by unfold Ncount; nlinarith
  have hcapN : cap n < Ncount n := by have := Ncount_sub_cap n; nlinarith
  have hdiff : 0 < Ncount n - r := by linarith
  have hdiffc : 0 < Ncount n - cap n := by linarith
  have key : r * Ncount n / (Ncount n - r) ≤ cap n * Ncount n / (Ncount n - cap n) := by
    rw [div_le_div_iff₀ hdiff hdiffc]
    nlinarith [mul_nonneg (mul_nonneg hN.le hN.le) (sub_nonneg.mpr hcap)]
  have h2n : (0:ℝ) < 2 / n := by positivity
  calc thetaFam n r = (2 / n) * Real.sqrt (r * Ncount n / (Ncount n - r)) := rfl
    _ ≤ (2 / n) * Real.sqrt (cap n * Ncount n / (Ncount n - cap n)) := by
        have := Real.sqrt_le_sqrt key; nlinarith
    _ = thetaFam n (cap n) := rfl
    _ = theta0 n := thetaFam_at_cap n hn

/-- **Equality only at the cap.** For `0 < r < cap n` the inequality is strict, so `θ = θ₀(n)`
forces `r = cap n`, which by `Smmm_nonneg_iff` is `S_mmm = 0`. -/
theorem thetaFam_lt_theta0 (n r : ℝ) (hn : 3 ≤ n) (hr : 0 < r) (hcap : r < cap n) :
    thetaFam n r < theta0 n := by
  have hn0 : (0:ℝ) < n := by linarith
  have hN : 0 < Ncount n := by unfold Ncount; nlinarith
  have hcapN : cap n < Ncount n := by have := Ncount_sub_cap n; nlinarith
  have hdiff : 0 < Ncount n - r := by linarith
  have hdiffc : 0 < Ncount n - cap n := by linarith
  have key : r * Ncount n / (Ncount n - r) < cap n * Ncount n / (Ncount n - cap n) := by
    rw [div_lt_div_iff₀ hdiff hdiffc]
    nlinarith [mul_pos (mul_pos hN hN) (sub_pos.mpr hcap)]
  have hnn : 0 ≤ r * Ncount n / (Ncount n - r) := by positivity
  have hs := Real.sqrt_lt_sqrt hnn key
  have h2n : (0:ℝ) < 2 / n := by positivity
  calc thetaFam n r = (2 / n) * Real.sqrt (r * Ncount n / (Ncount n - r)) := rfl
    _ < (2 / n) * Real.sqrt (cap n * Ncount n / (Ncount n - cap n)) := by nlinarith
    _ = thetaFam n (cap n) := rfl
    _ = theta0 n := thetaFam_at_cap n hn

/-! ## The equality case is the balanced split, and nothing else in the family

The block's closing algebra, which distinguishes `𝔰𝔬(n/2) ⊕ 𝔰𝔬(n/2)` inside the family before
any optimisation happens. -/

/-- **`binom p 2 + binom q 2 = cap (p+q)` with `p + q = n` forces `p = q`.** *One line: the
equation reduces to `(p−q)² = 0`.* -/
theorem symmetric_pair_balanced (p q : ℝ)
    (h : p * (p - 1) / 2 + q * (q - 1) / 2 = cap (p + q)) : p = q := by
  unfold cap at h
  have hsq : (p - q) ^ 2 = 0 := by nlinarith
  have := sq_eq_zero_iff.mp hsq
  linarith

/-- **`𝔲(m) ⊂ 𝔰𝔬(2m)` never enters the family**: it is a symmetric pair, so it would have to sit
*at* the cap, and `cap (2m) = m(m−1)` while `dim 𝔲(m) = m²`. -/
theorem um_off_cap (m : ℝ) (hm : 0 < m) : cap (2 * m) = m * (m - 1) ∧ m ^ 2 ≠ m * (m - 1) := by
  refine ⟨by unfold cap; ring, ?_⟩
  intro h
  nlinarith

/-- **`𝔤₂ ⊂ 𝔰𝔬(7)` and `𝔰𝔭𝔦𝔫(7) ⊂ 𝔰𝔬(8)` exceed the cap**, at `14` against `8.75` and `21`
against `12`; and `𝔰𝔬(5) ⊕ 𝔰𝔬(7) ⊂ 𝔰𝔬(12)` is a symmetric pair *above* the cap, at `31`
against `30`, *"so the cap is not a bound on symmetric pairs"*. -/
theorem cap_examples :
    cap 7 = 35 / 4 ∧ (14:ℝ) > cap 7 ∧ cap 8 = 12 ∧ (21:ℝ) > cap 8 ∧
      cap 12 = 30 ∧ (31:ℝ) > cap 12 := by
  refine ⟨by unfold cap; norm_num, by unfold cap; norm_num, by unfold cap; norm_num,
    by unfold cap; norm_num, by unfold cap; norm_num, by unfold cap; norm_num⟩

/-- **At odd `n` the cap is not an integer**, so no subalgebra attains it and the inequality is
strict. *`n(n-2)` is odd for odd `n`, hence not divisible by `4`: `4r = 4k^2 - 1` would make `4`
divide `1`.* -/
theorem cap_not_integer_odd (k r : ℕ) : (r : ℝ) ≠ cap ((2 * k + 1 : ℕ) : ℝ) := by
  intro h
  unfold cap at h
  push_cast at h
  have h4 : (4:ℤ) ∣ 1 := ⟨(k:ℤ) ^ 2 - r, by
    have hr4 : (4:ℝ) * r + 1 = 4 * (k:ℝ) ^ 2 := by nlinarith [h]
    have hz : ((1:ℤ) : ℝ) = ((4 * ((k:ℤ) ^ 2 - r) : ℤ) : ℝ) := by push_cast; linarith
    exact_mod_cast hz⟩
  norm_num at h4

/-! ## The bound, assembled

The two halves of the statement, put together in the form a consumer reads. -/

/-- **The conjecture on the subalgebra family.** Given the two closed forms and the
non-negativity of `S_mmm`, the family's `θ` is at most `θ₀(n)`, with equality exactly when
`S_mmm = 0`. -/
theorem family_bound (n r : ℝ) (hn : 3 ≤ n) (hr : 0 < r) (hrN : r < Ncount n)
    (hS : 0 ≤ Smmm n r) :
    thetaFam n r ≤ theta0 n ∧ (thetaFam n r = theta0 n ↔ Smmm n r = 0) := by
  have hcap : r ≤ cap n := (Smmm_nonneg_iff n r hn hr hrN).mp hS
  refine ⟨thetaFam_le_theta0 n r hn hr hcap, ?_⟩
  rw [Smmm_eq_zero_iff n r hn hr hrN]
  constructor
  · intro h
    rcases lt_or_eq_of_le hcap with hlt | heq
    · exact absurd h (ne_of_lt (thetaFam_lt_theta0 n r hn hr hlt))
    · exact heq
  · intro h; rw [h]; exact thetaFam_at_cap n hn

/-! ## Non-vacuity

The hypotheses are satisfied at the balanced split itself, which is the equality case. -/

/-- **A witness**: `n = 12`, `r = 30 = dim(𝔰𝔬(6) ⊕ 𝔰𝔬(6))`, at which `0 < r < N = 66`,
`S_mmm = 0`, and `θ = θ₀(12)`. -/
example : (0:ℝ) < 30 ∧ (30:ℝ) < Ncount 12 ∧ Smmm 12 30 = 0 ∧ thetaFam 12 30 = theta0 12 := by
  refine ⟨by norm_num, by unfold Ncount; norm_num, ?_, ?_⟩
  · unfold Smmm Ncount; norm_num
  · have h : (30:ℝ) = cap 12 := by unfold cap; norm_num
    rw [h]; exact thetaFam_at_cap 12 (by norm_num)

end HamiltonsCubic.L23Statement
