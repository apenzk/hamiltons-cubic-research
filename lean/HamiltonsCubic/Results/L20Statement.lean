import Mathlib

set_option linter.style.longLine false

/-!
# L20, the tube theorem's chain, and the two threshold polynomials

## The record's statement, verbatim

[route-a.md](../../../findings/route-a.md)'s *Lemma L20, no maximizer lies near the rival
maximizer's orbit, for every `n ≥ 12`*, whose proof runs:

> **$d$ is geodesic angular distance on the unit sphere of $\mathrm{Weyl}_n$**,
> $\cos d(X,Y)=\langle X,Y\rangle$ [...] The unit sphere of $\mathrm{Weyl}_n$ is compact, so
> $m:=\sqrt{2/3}\max P$ is attained, at some $W^*$. [...] Suppose
> $\varphi:=d(W^*,SO(n).W_{\mathbb{CP}^2})\le0.5748$ [...] the expansion is exact and has no
> linear term:
> $$m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V,\qquad \alpha=\sqrt{\tfrac23}\langle F_uV,V\rangle,\quad \gamma_V=\sqrt{\tfrac23}P(V),$$
> [...] The largest eigenvalue of $F_u$ on $u^\perp\cap T_u(SO(n).u)^\perp$ is $\tfrac13\theta^*$,
> so $\alpha\le1/3$. [...] And $\gamma_V\le m$ because $V$ is itself a unit Weyl operator and $m$
> is the maximum over all of them. Substituting both and using
> $\cos^3\varphi+\cos\varphi\sin^2\varphi=\cos\varphi$,
> $$m\le\cos\varphi+m\sin^3\varphi,\qquad\text{i.e.}\qquad m\le\psi(\varphi):=\frac{\cos\varphi}{1-\sin^3\varphi}.$$
> On $[0,0.5748]$ one has $\psi\le\psi(0)=1$. **The reduction is exact**: $\psi\le1\iff\sin\varphi\le s^*$
> with $s^*$ the real root of $s^3+s^2+s=1$ [...] Hence $m\le1$, i.e. $\max P\le\sqrt{3/2}$. **The
> contradiction needs a unit Weyl operator with $P>\sqrt{3/2}$, and at odd $n$ the balanced sphere
> product is not one, it does not exist.** The witness is the best split:
> $\Theta_n^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$ at odd $n$, exceeding $\tfrac32$ exactly when
> $n^2-13n+18>0$, so from $n=13$; at even $n$ it is $\theta_0(n)$, exceeding $\tfrac32$ when
> $n^2-12n+8>0$, so from $n=12$. **The two parities carry different polynomials and both clear
> from $n\ge12$.** Therefore $\varphi>0.5748$. $\square$

## What is NOT typed here

**The geometry the chain sits on.** `Weyl_n`, `W_{ℂP²}` at general `n`, the `SO(n)`-action, the
orbit and its tangent space, the cubic form `P` and its polarisation `T`, and the operator
`F_u(h) = ½(uh + hu) + u # h`, none has a Lean base layer in this repository. The real Weyl layer
([WeylReal.lean](../Base/WeylReal.lean)) carries `IsWeyl`, `Pcubic`, `norm` and `theta` over `ℝ`,
and no competitor, no orbit and no mixed sharp. **So the exact expansion, `α ≤ ⅓` (which is
[Lemma L21](../../../findings/route-a.md)) and `γ_V ≤ m` enter `tube_exclusion` as named
hypotheses**, and its conclusion is the one the proof draws, `0.5748 < φ`. *Nothing in the binder
is the conclusion: the expansion is a Taylor identity, `α ≤ ⅓` is a separate numbered lemma of the
record, and `γ_V ≤ m` is the definition of a maximum.*

**Also not typed:** compactness of the unit sphere, `SO(n)`-invariance of `d`, and the
first-variation condition at a nearest orbit point, the three further hypotheses the block
states it uses. And the degenerate branch `φ = 0`, which the block treats separately.

## The one numeric, `sin_radius_le`

`sin_radius_le`, the bound `sin 0.5748 ≤ 0.54368`. **The margin is `1.3 × 10⁻⁵`**, the true
crossing is `φ_c = 0.5748262975…`, and `0.5748` is that truncated in the safe direction, while
Mathlib's `Real.sin_bound` applied directly at this argument is too coarse. *It is proved by
doubling twice from the quarter angle `0.1437`, where `Real.sin_bound`, `Real.cos_bound` and
`Real.sin_gt_sub_cube` are sharp enough (the helpers `sin_quarter_bounds` and `cos_quarter_le`).
Everything in the file is proved. The chain runs at radius `arcsin 0.54368`, a certified lower bound for
`arcsin s*`; the identification of the exact radius `arcsin s*` is [L20Arcsin.lean](L20Arcsin.lean)'s
`radius_eq_sStar`.*
-/

namespace HamiltonsCubic.L20Statement

open Real

/-! ## The reduction to a cubic in `sin φ`

`ψ(φ) ≤ 1 ⟺ cos φ + sin³φ ≤ 1 ⟺ sin³φ + sin²φ + sin φ ≤ 1`, the last being exact. -/

/-- **`ψ(φ) = cos φ / (1 − sin³φ)`.** -/
noncomputable def psi (φ : ℝ) : ℝ := Real.cos φ / (1 - Real.sin φ ^ 3)

/-- **`ψ(0) = 1`**, the value the whole interval is compared against. -/
theorem psi_at_zero : psi 0 = 1 := by simp [psi]

/-- **The cubic bracket for `s*`, the real root of `s³ + s² + s = 1`.** *The record brackets it in
`(0.5436, 0.5437)`; this is the tighter bracket the radius actually needs.* -/
theorem sStar_bracket :
    (0.54368:ℝ) ^ 3 + 0.54368 ^ 2 + 0.54368 < 1 ∧ 1 < (0.54369:ℝ) ^ 3 + 0.54369 ^ 2 + 0.54369 := by
  constructor <;> norm_num

/-- **The cubic criterion, in the direction the proof consumes.** If `0 ≤ s ≤ 0.54368` and
`c ≥ 0` with `c² = 1 − s²`, then `c + s³ ≤ 1`. *The chain is
`s³+s²+s ≤ 1 ⟹ s²(1+s) ≤ 1−s ⟹ s²c² ≤ (1−s)² ⟹ sc ≤ 1−s ⟹ s(1+c) ≤ 1 ⟹ s³ ≤ s²/(1+c) = 1−c`.*
-/
theorem cos_add_sin_cube_le_one {s c : ℝ} (hs0 : 0 ≤ s) (hsb : s ≤ 0.54368)
    (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2) : c + s ^ 3 ≤ 1 := by
  have hcubic : s ^ 3 + s ^ 2 + s ≤ 1 := by nlinarith [sStar_bracket.1, sq_nonneg s]
  have hs1 : s < 1 := by nlinarith
  have hkey : s ^ 2 * (1 + s) ≤ 1 - s := by nlinarith
  have hsq : (s * c) ^ 2 ≤ (1 - s) ^ 2 := by nlinarith
  have hsc : s * c ≤ 1 - s := by nlinarith [mul_nonneg hs0 hc0]
  have hone : s * (1 + c) ≤ 1 := by nlinarith
  have hcpos : (0:ℝ) < 1 + c := by linarith
  have hres : (1 - c) * (1 + c) = s ^ 2 := by nlinarith
  nlinarith [mul_nonneg (mul_nonneg hs0 hs0) hc0, sq_nonneg s, mul_nonneg hs0 hc0]

/-! ## The chain in the sine variable, at `sin φ ≤ 0.54368` -/

/-- **The chain, at radius `arcsin 0.54368`.** *`0.54368` is a certified lower bound for the root
`s*`, so `arcsin 0.54368 ≤ φ_c` and this is the truncated-in-the-safe-direction radius in the
`sin` variable.* -/
theorem max_le_one_of_sin_le {m φ α γ : ℝ}
    (hcos : 0 ≤ Real.cos φ) (hsin : 0 ≤ Real.sin φ) (hsb : Real.sin φ ≤ 0.54368)
    (hexp : m = Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * α + Real.sin φ ^ 3 * γ)
    (hα : α ≤ 1 / 3) (hγ : γ ≤ m) : m ≤ 1 := by
  have hpyth : Real.cos φ ^ 2 = 1 - Real.sin φ ^ 2 := by
    have := Real.sin_sq_add_cos_sq φ; linarith
  have hcs : Real.cos φ + Real.sin φ ^ 3 ≤ 1 :=
    cos_add_sin_cube_le_one hsin hsb hcos hpyth
  have hsin3 : 0 ≤ Real.sin φ ^ 3 := by positivity
  have hstep : m ≤ Real.cos φ + m * Real.sin φ ^ 3 := by
    have h1 : 3 * Real.cos φ * Real.sin φ ^ 2 * α ≤ 3 * Real.cos φ * Real.sin φ ^ 2 * (1 / 3) := by
      have : (0:ℝ) ≤ 3 * Real.cos φ * Real.sin φ ^ 2 := by positivity
      nlinarith
    have h2 : Real.sin φ ^ 3 * γ ≤ Real.sin φ ^ 3 * m := by nlinarith
    have h3 : Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * (1 / 3) = Real.cos φ := by
      nlinarith [hpyth]
    nlinarith
  have hs3lt : Real.sin φ ^ 3 < 1 := by nlinarith
  by_contra hcon
  push_neg at hcon
  nlinarith [mul_pos (sub_pos.mpr hcon) (sub_pos.mpr hs3lt)]

/-! ## The radius `0.5748`, and the one numeric it needs -/

/-- **`0.14320543 ≤ sin 0.1437 ≤ 0.14320606`**, from `Real.sin_gt_sub_cube` below and
`Real.sin_bound` above, at the quarter angle `0.1437 = 0.5748 / 4`. -/
theorem sin_quarter_bounds :
    (0.14320543:ℝ) ≤ Real.sin (1437 / 10000) ∧ Real.sin (1437 / 10000) ≤ 0.14320606 := by
  have hy0 : (0:ℝ) < 1437 / 10000 := by norm_num
  have habs : |(1437 / 10000 : ℝ)| ≤ 1 := by rw [abs_of_pos hy0]; norm_num
  obtain ⟨_, hb⟩ := abs_le.mp (Real.sin_bound habs)
  have hl := Real.sin_gt_sub_cube hy0
  rw [abs_of_pos hy0] at hb
  have hl' : (0.14320543:ℝ) ≤ 1437 / 10000 - (1437 / 10000) ^ 3 / 6 := by norm_num
  have hu' : (1437 / 10000 : ℝ) - (1437 / 10000) ^ 3 / 6 + (1437 / 10000) ^ 5 / 100 ≤ 0.14320606 := by
    norm_num
  constructor <;> linarith

/-- **`cos 0.1437 ≤ 0.98969737`**, from `Real.cos_bound` at the quarter angle. -/
theorem cos_quarter_le : Real.cos (1437 / 10000) ≤ (0.98969737:ℝ) := by
  have hy0 : (0:ℝ) < 1437 / 10000 := by norm_num
  have habs : |(1437 / 10000 : ℝ)| ≤ 1 := by rw [abs_of_pos hy0]; norm_num
  obtain ⟨_, hb⟩ := abs_le.mp (Real.cos_bound habs)
  rw [abs_of_pos hy0] at hb
  have hu' : 1 - (1437 / 10000 : ℝ) ^ 2 / 2 + (1437 / 10000) ^ 4 * (5 / 96) ≤ 0.98969737 := by
    norm_num
  linarith

/-- **`sin 0.5748 ≤ 0.54368`.**

The true value is `0.54366692…` and the bound leaves a margin of `1.3 × 10⁻⁵`, while Mathlib's
`Real.sin_bound` at `x = 0.5748` is too coarse. *Proved by doubling twice from the quarter angle
`y = 0.1437`:* `sin_quarter_bounds` and `cos_quarter_le` bound `sin y` and `cos y`, then
`sin 2y = 2 sin y cos y ≤ 0.28346134` and `cos 2y = 1 − 2 sin²y ≤ 0.95898442`, and
`sin 4y = 2 sin 2y cos 2y ≤ 0.54367001`, each step using nonnegativity of the factors. -/
theorem sin_radius_le : Real.sin 0.5748 ≤ 0.54368 := by
  have hx : (0.5748:ℝ) = 2 * (2 * (1437 / 10000)) := by norm_num
  obtain ⟨hsl, hsu⟩ := sin_quarter_bounds
  have hcu := cos_quarter_le
  have hs0 : 0 ≤ Real.sin (1437 / 10000 : ℝ) :=
    Real.sin_nonneg_of_nonneg_of_le_pi (by norm_num) (by linarith [Real.pi_gt_three])
  have hc0 : 0 ≤ Real.cos (1437 / 10000 : ℝ) :=
    Real.cos_nonneg_of_mem_Icc ⟨by linarith [Real.pi_gt_three], by linarith [Real.pi_gt_three]⟩
  have hs2u : Real.sin (2 * (1437 / 10000)) ≤ (0.28346134:ℝ) := by
    rw [Real.sin_two_mul]
    have := mul_le_mul hsu hcu hc0 (by norm_num)
    have hn : 2 * ((0.14320606:ℝ) * 0.98969737) ≤ 0.28346134 := by norm_num
    nlinarith
  have hs20 : 0 ≤ Real.sin (2 * (1437 / 10000) : ℝ) :=
    Real.sin_nonneg_of_nonneg_of_le_pi (by norm_num) (by linarith [Real.pi_gt_three])
  have hc2u : Real.cos (2 * (1437 / 10000)) ≤ (0.95898442:ℝ) := by
    rw [Real.cos_two_mul, Real.cos_sq']
    have := mul_le_mul hsl hsl (by norm_num) hs0
    have hn : 2 * (1 - (0.14320543:ℝ) * 0.14320543) - 1 ≤ 0.95898442 := by norm_num
    nlinarith
  have hc20 : 0 ≤ Real.cos (2 * (1437 / 10000) : ℝ) :=
    Real.cos_nonneg_of_mem_Icc ⟨by linarith [Real.pi_gt_three], by linarith [Real.pi_gt_three]⟩
  rw [hx, Real.sin_two_mul]
  have := mul_le_mul hs2u hc2u hc20 (by norm_num)
  have hn : 2 * ((0.28346134:ℝ) * 0.95898442) ≤ 0.54368 := by norm_num
  nlinarith

/-- **Hence `sin φ ≤ 0.54368` throughout `[0, 0.5748]`**, by monotonicity of `sin` on
`[−π/2, π/2]`. -/
theorem sin_le_of_le_radius {φ : ℝ} (h0 : 0 ≤ φ) (h : φ ≤ 0.5748) : Real.sin φ ≤ 0.54368 := by
  have hpi : (0.5748:ℝ) ≤ Real.pi / 2 := by nlinarith [Real.pi_gt_three]
  have hmono : Real.sin φ ≤ Real.sin 0.5748 :=
    Real.sin_le_sin_of_le_of_le_pi_div_two (by nlinarith [Real.pi_gt_three]) hpi h
  linarith [sin_radius_le]

/-- **`cos φ ≥ 0` and `sin φ ≥ 0` on `[0, 0.5748]`**, since `0.5748 < π/2`. -/
theorem trig_nonneg {φ : ℝ} (h0 : 0 ≤ φ) (h : φ ≤ 0.5748) :
    0 ≤ Real.cos φ ∧ 0 ≤ Real.sin φ := by
  have hpi : (0.5748:ℝ) ≤ Real.pi / 2 := by nlinarith [Real.pi_gt_three]
  refine ⟨Real.cos_nonneg_of_mem_Icc ⟨by nlinarith [Real.pi_gt_three], by linarith⟩, ?_⟩
  exact Real.sin_nonneg_of_nonneg_of_le_pi h0 (by nlinarith [Real.pi_gt_three])

/-- **`max P ≤ √(3/2)` inside the tube**, in the normalisation `m = √(2/3)·max P`. -/
theorem max_le_one {m φ α γ : ℝ} (h0 : 0 ≤ φ) (h : φ ≤ 0.5748)
    (hexp : m = Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * α + Real.sin φ ^ 3 * γ)
    (hα : α ≤ 1 / 3) (hγ : γ ≤ m) : m ≤ 1 :=
  max_le_one_of_sin_le (trig_nonneg h0 h).1 (trig_nonneg h0 h).2
    (sin_le_of_le_radius h0 h) hexp hα hγ

/-- **THE TUBE EXCLUSION.** If the attained maximum `m = √(2/3)·max P` exceeds `1`, which is
`max P > √(3/2)`, then the nearest-orbit angle `φ` at which it is attained exceeds `0.5748`. -/
theorem tube_exclusion {m φ α γ : ℝ} (h0 : 0 ≤ φ)
    (hexp : m = Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * α + Real.sin φ ^ 3 * γ)
    (hα : α ≤ 1 / 3) (hγ : γ ≤ m) (hm : 1 < m) : 0.5748 < φ := by
  by_contra hcon
  push_neg at hcon
  linarith [max_le_one h0 hcon hexp hα hγ]

/-! ## The witness, at both parities

*The final step is empty at odd `n` as written*, its witness being the balanced sphere product,
which does not exist there. The repair is `Θ_n` in place of `θ₀(n)`, and it costs nothing. -/

/-- **`θ₀(n)² = 2(n−1)(n−2)/n²`**, the even-`n` sphere-product value. -/
noncomputable def theta0Sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- **`Θ_n² = 2(n−1)(n−3)/((n−2)(n+1))`**, the best-split value at odd `n`. -/
noncomputable def thetaOddSq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 3) / ((n - 2) * (n + 1))

/-- **At even `n`: `θ₀(n)² > 3/2 ↔ n² − 12n + 8 > 0`.** -/
theorem even_threshold (n : ℝ) (hn : 3 ≤ n) : 3 / 2 < theta0Sq n ↔ 0 < n ^ 2 - 12 * n + 8 := by
  have hn2 : (0:ℝ) < n ^ 2 := by nlinarith
  simp only [theta0Sq]
  rw [lt_div_iff₀ hn2]
  constructor <;> intro h <;> nlinarith

/-- **At odd `n`: `Θ_n² > 3/2 ↔ n² − 13n + 18 > 0`.** -/
theorem odd_threshold (n : ℝ) (hn : 3 < n) : 3 / 2 < thetaOddSq n ↔ 0 < n ^ 2 - 13 * n + 18 := by
  have hd : (0:ℝ) < (n - 2) * (n + 1) := by nlinarith
  simp only [thetaOddSq]
  rw [lt_div_iff₀ hd]
  constructor <;> intro h <;> nlinarith

/-- **Both polynomials reach the same integer threshold**, by independent arithmetic: `n² − 12n + 8`
is `−3` at `n = 11` and `8` at `n = 12`; `n² − 13n + 18` is `−4` at `n = 11`, `6` at `n = 12` and
`38` at `n = 13`. *They differ by `10 − n`, with discriminants `112` and `97`.* -/
theorem thresholds_at_eleven_twelve :
    ((11:ℝ) ^ 2 - 12 * 11 + 8 = -3) ∧ ((12:ℝ) ^ 2 - 12 * 12 + 8 = 8) ∧
    ((11:ℝ) ^ 2 - 13 * 11 + 18 = -4) ∧ ((12:ℝ) ^ 2 - 13 * 12 + 18 = 6) ∧
    ((13:ℝ) ^ 2 - 13 * 13 + 18 = 18) := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- **And both are strictly increasing past `n = 12`**, so the witness clears `√(3/2)` at every
`n ≥ 12` in both parities. -/
theorem thresholds_positive (n : ℝ) (hn : 12 ≤ n) :
    0 < n ^ 2 - 12 * n + 8 ∧ 0 < n ^ 2 - 13 * n + 18 := by
  constructor <;> nlinarith

/-- **The crossover is `n = 6 + 2√7`**, the root of `n² − 12n + 8`, which lies strictly between
`11` and `12`. -/
theorem crossover_bracket : (11:ℝ) < 6 + 2 * Real.sqrt 7 ∧ 6 + 2 * Real.sqrt 7 < 12 := by
  have h7 : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt (by norm_num)
  have hpos : (0:ℝ) ≤ Real.sqrt 7 := Real.sqrt_nonneg 7
  constructor <;> nlinarith

/-! ## Non-vacuity

The tube is not empty and the hypotheses of `tube_exclusion` are satisfiable: at `φ = 0`, `α = ⅓`
and `γ = m`, the expansion holds with `m = 1`, which is the degenerate branch the block treats
separately. -/

example : (1:ℝ) = Real.cos 0 ^ 3 + 3 * Real.cos 0 * Real.sin 0 ^ 2 * (1 / 3)
    + Real.sin 0 ^ 3 * 1 := by norm_num

/-- **And the radius is a genuine interval**: `0 < 0.5748 < π/2`. -/
example : (0:ℝ) < 0.5748 ∧ (0.5748:ℝ) < Real.pi / 2 := by
  refine ⟨by norm_num, by nlinarith [Real.pi_gt_three]⟩

end HamiltonsCubic.L20Statement
