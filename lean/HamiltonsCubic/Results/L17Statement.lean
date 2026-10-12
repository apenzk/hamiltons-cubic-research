import Mathlib

set_option linter.style.longLine false

/-!
# L17, stated in the parts that do not need the curvature layer

## The record's statement, verbatim

> **LEMMA L17.** *Let $u$ be the padded $\mathbb{CP}^2$-type competitor in $\mathcal W_n$,
> $n\ge4$, **critical** ($Q(u)=\theta u$ with $\theta=\sqrt{3/2}$) and let $H\in\mathcal W_n$ be
> **tangent**, $\langle H,u\rangle=0$. Write $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ and
> $\Phi=P-\kappa_n\delta^2$. Then*
> $$d^+\delta^2(u;H)=-2a\,F(H)\le0,\qquad a=\tfrac1{3\sqrt6},$$
> *at every $n\ge4$; and consequently $d^+\Phi(u;H)=2a\kappa_nF(H)\le0$ **for exactly those $n$
> with $\kappa_n\le0$, which is $n\ge12$.***

with, from [ATTEMPTS.md](../../../ATTEMPTS.md) Result 6, the definition of `F` and the chain:

> $$F(H)=H_{22}+H_{33}+\operatorname{tr}\!\big(\Pi_{ASD}(P_0HP_0)_-\big)\ \ge\
> \tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)\ \ge\ 0,$$

where `P₀` projects onto `ker u`, `Π_ASD` onto the anti-self-dual 3-space, and
`B = Π_ASD H Π_ASD`; and, from [route-a.md](../../../findings/route-a.md):

> **the first Bianchi identity gives $H_{11}+H_{22}+H_{33}=\operatorname{tr}(B)$**, which is
> exactly $\langle H,\star\rangle=0$, and **tangency gives $2H_{11}=H_{22}+H_{33}$**, whence
> $F\ge\tfrac23\operatorname{tr}(B_+)+\tfrac13\operatorname{tr}(B_-)\ge0$.

## What is typed here and what is not

**The identity `d⁺δ²(u;H) = -2a F(H)` is proved in [L17Deriv.lean](L17Deriv.lean)** as
`hasDerivWithinAt_defect_u`, on `Λ²ℝⁿ` for every symmetric `H`, and [L17Close.lean](L17Close.lean)'s `L17_at_u`
feeds it through the chain below with `hcompress`, `hbianchi` and `htangent` discharged.
[L17Phi.lean](L17Phi.lean)'s `L17` proves `d⁺Φ(u;H) = 2aκF(H)`, and `≤ 0` for `κ ≤ 0`, with `d⁺P(u;H) = 0` from
criticality, and `L17_ge12` takes `κ = κₙ` at `n ≥ 12`. The theorems in this file state the chain over real numbers.
`L17_at_u` instantiates `dDelta_nonpos`'s hypothesis `hderiv`, and `L17` closes the `Φ` half directly, so nothing
instantiates `dPhi_nonpos`.

**Typed and proved here, with no `sorry`:**

* `F_ge` and `F_nonneg`, the inequality chain, which is the whole analytic content of the lemma
  once the derivative formula is in hand. Its three inputs are the compression
  `tr(Π_ASD (P₀HP₀)_-) ≥ tr(B_-)`, the first Bianchi identity and tangency, each an explicit
  hypothesis, exactly as the record lists them.
* `dDelta_nonpos` and `dPhi_nonpos`, the two conclusions, from the chain.
* `crossover_even`, `crossover_odd` and `theta0_sq_gt`, that the sign of `κₙ` flips at `n = 12`
  and at no other dimension, through [L2](../../../findings/problem.md)'s two polynomials rather
  than through the two values `Θ₁₁` and `Θ₁₃`, which step over `n = 12`, the one dimension the
  claim is about.
* `kink_*`, the record's witness for the mechanism at padded `CP²bar`, where
  `δ²(u+tH₀) = (1-|t|)²/9` exactly and both one-sided slopes are `-2/9`, exhibiting the kink that
  makes `δ²` non-smooth at `u`.
* `equality_set_dimensions`, the corrected size of `{F = 0}` at `n = 12`.
-/

namespace HamiltonsCubic.L17

/-! ## The inequality chain

*`trBpos` and `trBneg` are `tr(B₊)` and `tr(B₋)`, both nonnegative, with `tr(B) = tr(B₊) - tr(B₋)`
in the convention of [Hansen–Pedersen](../../../references/), where `x₋ = max(-x,0)` is the
nonnegative negative part. `sliver` is `tr(Π_ASD (P₀HP₀)_-)`, the kink branch's contribution.* -/

/-- **Tangency and Bianchi together give `H₂₂ + H₃₃ = (2/3) tr(B)`.** This is the step the record
names, and it is where both structural facts are consumed. -/
theorem smooth_branch {h11 h22 h33 trB : ℝ}
    (hbianchi : h11 + h22 + h33 = trB) (htangent : 2 * h11 = h22 + h33) :
    h22 + h33 = 2 / 3 * trB := by linarith

/-- **The chain's first inequality: `F ≥ (2/3) tr(B₊) + (1/3) tr(B₋)`.**

`hcompress` is the compression `tr(Π_ASD (P₀HP₀)_-) ≥ tr(B_-)`, which the record derives in four
lines from `0 ≤ Z ≤ Π` and `C₋ ⪰ 0`; `hbianchi` is the first Bianchi identity in the form
`H₁₁+H₂₂+H₃₃ = tr(B)`; `htangent` is tangency. -/
theorem F_ge {h11 h22 h33 sliver trBpos trBneg : ℝ}
    (hcompress : trBneg ≤ sliver)
    (hbianchi : h11 + h22 + h33 = trBpos - trBneg)
    (htangent : 2 * h11 = h22 + h33) :
    2 / 3 * trBpos + 1 / 3 * trBneg ≤ h22 + h33 + sliver := by
  have h := smooth_branch hbianchi htangent
  linarith

/-- **The chain's second inequality: `F ≥ 0`.** Both parts of `B`'s trace are nonnegative. -/
theorem F_nonneg {h11 h22 h33 sliver trBpos trBneg : ℝ}
    (hcompress : trBneg ≤ sliver)
    (hbianchi : h11 + h22 + h33 = trBpos - trBneg)
    (htangent : 2 * h11 = h22 + h33)
    (hpos : 0 ≤ trBpos) (hneg : 0 ≤ trBneg) :
    0 ≤ h22 + h33 + sliver := by
  have := F_ge hcompress hbianchi htangent
  linarith

/-! ## The two conclusions

*Stated over real numbers, with the derivative identity as the hypothesis `hderiv`. The identity is
proved in [L17Deriv.lean](L17Deriv.lean) as `hasDerivWithinAt_defect_u`, and
[L17Phi.lean](L17Phi.lean)'s `L17` proves the lemma in full on the operators themselves.* -/

/-- **`d⁺δ²(u;H) ≤ 0`**, given the record's identity `d⁺δ² = -2aF` and `F ≥ 0`. -/
theorem dDelta_nonpos {dDelta a F : ℝ} (hderiv : dDelta = -2 * a * F) (ha : 0 < a)
    (hF : 0 ≤ F) : dDelta ≤ 0 := by
  rw [hderiv]
  nlinarith

/-- **`d⁺Φ(u;H) = 2aκₙF ≤ 0` for `κₙ ≤ 0`.**

`hdP` is where criticality and tangency are consumed together: `d⁺P(u;H) = 3⟨Q(u),H⟩ = 3θ⟨u,H⟩`,
which tangency kills. *The record notes that criticality is load-bearing and was stated nowhere,
without `Q(u) = θu` the second display carries an extra `3⟨Q(u),H⟩`.* -/
theorem dPhi_nonpos {dPhi dP dDelta a kap F : ℝ}
    (hPhi : dPhi = dP - kap * dDelta) (hdP : dP = 0)
    (hderiv : dDelta = -2 * a * F) (ha : 0 < a) (hF : 0 ≤ F) (hkap : kap ≤ 0) :
    dPhi = 2 * a * kap * F ∧ dPhi ≤ 0 := by
  have heq : dPhi = 2 * a * kap * F := by rw [hPhi, hdP, hderiv]; ring
  refine ⟨heq, ?_⟩
  have h1 : 0 ≤ a * F := mul_nonneg ha.le hF
  have h2 : a * F * kap ≤ 0 := by nlinarith [h1, hkap]
  have h3 : 2 * a * kap * F = 2 * (a * F * kap) := by ring
  rw [heq, h3]
  linarith

/-! ## The crossover, settled by L2's polynomials rather than by two values

*The record: "the settling statement is [L2](../../../findings/problem.md)'s pair of polynomials,
`n² - 12n + 8` at even `n` and `n² - 13n + 18` at odd, and a bullet running `Θ₁₁ → Θ₁₃` steps over
`n = 12`, the one dimension its claim is about."* -/

/-- **`θ₀(n)² > 3/2` is exactly `n² - 12n + 8 > 0`**, with `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
theorem theta0_sq_gt {x : ℝ} (hx : 0 < x) :
    3 / 2 < 2 * (x - 1) * (x - 2) / x ^ 2 ↔ 0 < x ^ 2 - 12 * x + 8 := by
  rw [lt_div_iff₀ (by positivity)]
  constructor <;> intro h <;> nlinarith

/-- **The even branch: `n² - 12n + 8 > 0` exactly for `n ≥ 12`**, among `n ≥ 3`. -/
theorem crossover_even (n : ℕ) (hn : 3 ≤ n) :
    0 < (n : ℤ) ^ 2 - 12 * n + 8 ↔ 12 ≤ n := by
  constructor
  · intro h
    by_contra hlt
    push Not at hlt
    interval_cases n <;> omega
  · intro h
    have : (12 : ℤ) ≤ (n : ℤ) := by exact_mod_cast h
    nlinarith

/-- **The odd branch: `n² - 13n + 18 > 0` exactly for `n ≥ 12`**, among `n ≥ 3`. So the crossover
lands at `n ≥ 12` at both parities, which is why L17 survives
[Conjecture L16](../../../findings/problem.md)'s repair. -/
theorem crossover_odd (n : ℕ) (hn : 3 ≤ n) :
    0 < (n : ℤ) ^ 2 - 13 * n + 18 ↔ 12 ≤ n := by
  constructor
  · intro h
    by_contra hlt
    push Not at hlt
    interval_cases n <;> omega
  · intro h
    have : (12 : ℤ) ≤ (n : ℤ) := by exact_mod_cast h
    nlinarith

/-- **The two values the record quotes: `Θ₁₁² = 40/27 < 3/2 < 120/77 = Θ₁₃²`.** *They bracket the
crossover and do not establish it, `n = 12` lying between them.* -/
theorem theta_11_13 : (40 : ℝ) / 27 < 3 / 2 ∧ (3 : ℝ) / 2 < 120 / 77 := by
  constructor <;> norm_num

/-! ## The kink, exhibited

*The record's witness for the mechanism: at padded `CP²bar`, `δ²(u + tH₀) = (1-|t|)²/9` exactly,
so both one-sided slopes are `-2/9`, matching `-2aF` and showing that `δ²` is not differentiable
at `u`, which is what forces the derivative to split into a smooth and a kink branch.* -/

/-- The witness profile `t ↦ (1 - |t|)²/9`. -/
noncomputable def kinkProfile (t : ℝ) : ℝ := (1 - |t|) ^ 2 / 9

/-- `δ²(u) = 1/9`, the record's value at the competitor. -/
theorem kinkProfile_zero : kinkProfile 0 = 1 / 9 := by norm_num [kinkProfile]

/-- On `t ≥ 0` the profile is the smooth branch `(1-t)²/9`. -/
theorem kinkProfile_nonneg_eq {t : ℝ} (ht : 0 ≤ t) : kinkProfile t = (1 - t) ^ 2 / 9 := by
  rw [kinkProfile, abs_of_nonneg ht]

/-- On `t ≤ 0` it is the reflected branch `(1+t)²/9`. -/
theorem kinkProfile_nonpos_eq {t : ℝ} (ht : t ≤ 0) : kinkProfile t = (1 + t) ^ 2 / 9 := by
  rw [kinkProfile, abs_of_nonpos ht]
  ring_nf

/-- **The forward slope is `-2/9`.** -/
theorem kink_right_slope : HasDerivAt (fun t : ℝ => (1 - t) ^ 2 / 9) (-2 / 9) 0 := by
  have h : HasDerivAt (fun t : ℝ => (1 - t) ^ 2 / 9) ((2 * (1 - 0) ^ 1 * (-1)) / 9) 0 := by
    have h1 : HasDerivAt (fun t : ℝ => (1 - t)) (-1 : ℝ) 0 := by
      simpa using (hasDerivAt_id (0 : ℝ)).const_sub 1
    simpa using ((h1.pow 2).div_const 9)
  simpa using h

/-- **The backward slope of the reflected branch is `+2/9`**, so the two one-sided derivatives of
`kinkProfile` at `0` differ, the profile has a genuine corner, which is the kink. -/
theorem kink_left_slope : HasDerivAt (fun t : ℝ => (1 + t) ^ 2 / 9) (2 / 9) 0 := by
  have h1 : HasDerivAt (fun t : ℝ => (1 + t)) (1 : ℝ) 0 := by
    simpa using (hasDerivAt_id (0 : ℝ)).const_add 1
  simpa using ((h1.pow 2).div_const 9)

/-! ## The size of the equality set

*The record's count: `codim {F = 0} ≤ 186` at `n = 12`, the number of conditions
`Π_ASD H Π_ker u = 0`, so `{F = 0}` has dimension at least `1451` of `T_uS`'s `1637`. That is a ratio of
dimensions and not of directions, `{F = 0}` being a proper subspace and therefore measure zero. The
readings "about 89% of directions" and "most of the tangent space" are both false.* -/

/-- The dimension bookkeeping at `n = 12`: `dim 𝒲₁₂ = 1638`, `dim T_uS = 1637`, and `1637 − 186 = 1451`,
the lower bound on `dim {F=0}` that `codim {F=0} ≤ 186` gives. -/
theorem equality_set_dimensions : 1638 - 1 = 1637 ∧ 1637 - 186 = 1451 := by
  constructor <;> norm_num

end HamiltonsCubic.L17
