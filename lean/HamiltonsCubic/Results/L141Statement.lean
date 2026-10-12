import Mathlib

set_option linter.style.longLine false

/-!
# L141, the defect derivative is a `½`-contraction, and the balanced orbit's penalised form is definite

The record's statement, quoted verbatim from
[second-order.md](../../../findings/second-order.md):

> **(a) A `½`-contraction, everywhere, degenerate spectrum included.** Let `V ∈ 𝒲ₙ` be **any**
> tensor and `H ∈ 𝒲ₙ`, the derivative being one-sided where `V` has a kernel. Then
> $$\big\lVert D(\mathrm{Alt}\,W_-)_V[H]\big\rVert \le \tfrac12\lVert H\rVert .$$
> *Proof*: `Alt(H) = 0` since `H` satisfies the first Bianchi identity, so
> `Alt(DW_-[H]) = Alt(DW_-[H] + μH)` for every `μ`; the Daleckii–Krein multiplier of
> `f(x) = ½(|x| - x)` has every entry in `[-1,0]`, being a divided difference of a function with
> slopes `0` and `-1`; centring at `μ = ½` makes every entry of `DW_-[H] + ½H` at most half the
> corresponding entry of `H`; and `Alt` is an orthogonal projection. **On a kernel block, where the
> multiplier does not exist, the exact value is `D_-` and `D_- + ½D = ½|D|`, of norm `½‖D‖`**, so
> the degenerate case is covered by the same constant rather than excluded, which is what lets the
> statement hold at the competitor. **The constant is the half-length of the multiplier's range and
> nothing else, so it is the same in either sign convention.**
>
> **(b) Definiteness at the balanced orbit, with the sharp constant.** At `W*` with `n = 2m ≥ 12`,
> write `Q(H) = ½Hess(P|_S)_{W*}[H,H] - κ_n‖D(Alt W_-)[H]‖²` on `T_{W*}S ∩ T_{W*}𝒪^⊥`. Then
> $$Q(H) \le -c_n\lVert H\rVert^2,\qquad c_n = \frac{3\,\theta_0(n)}{n-2},$$
> **and this is attained, so the constant is unimprovable.**

and the step of (b)'s proof this file checks, also verbatim:

> Writing `s` for the fraction of a direction's weight carried by the defect-active part of the
> block,
> $$\frac{Q}{\lVert H\rVert^2}=3\theta_0\big(2\mu s-\mu-\tfrac12\big)+\tfrac29\lvert\kappa_n\rvert s,$$
> **increasing in `s`**, so its maximum sits at `s = 1` … **So the pair block binds, and the
> minimum is exactly `-3θ₀/(n-2)`.**

## What this file types

**Part (a)'s constant**, which the record itself says is "the half-length of the multiplier's range
and nothing else":

* `negPart` is `f(x) = ½(|x| - x)`, `divDiff` its divided difference.
* `divDiff_mem_Icc`, every entry of the Daleckii–Krein multiplier lies in `[-1, 0]`, from `f`
  being nonincreasing and `1`-Lipschitz.
* `recentred_abs_le_half`, **centring at `μ = ½` halves it**: `|f^{[1]}(x,y) + ½| ≤ ½`, the
  multiplier bound that gives the `½` and the whole of (a)'s constant.
* `kernel_block_identity`, the degenerate case as an identity, `f(d) + ½d = ½|d|`, the record's
  "`D_- + ½D = ½|D|`, of norm `½‖D‖`" written out; and `kernel_block_abs`, that its absolute value
  is exactly `½|d|`, so the kernel block meets the same constant with equality rather than being
  excluded.

**Part (b)'s comparison**, at the balanced product `W*` with `n = 2m`:

* `theta0` is `θ₀(n) = √(2(n-1)(n-2))/n`, `kappaAbs` is `|κ_n| = 9(θ₀(n) - √(3/2))`, and `muE` is
  the `(2,2)` four-set block's `L_e` eigenvalue `μ = 2/(n-2)`.
* `Qratio_strictMono`, the displayed ratio is **strictly increasing in `s`**, so its maximum over
  `s ∈ [0,1]` is at `s = 1` (`Qratio_le_at_one`). That is the sentence the record struck an earlier
  version for getting backwards.
* `pair_block_value`, the pair block's value is `3θ₀(λ_m - ½) = -3θ₀/(n-2)`, with
  `λ_m = (m-2)/(2(m-1))` and `n = 2m`, so `c_n = 3θ₀/(n-2)` as displayed.
* `pair_block_binds`, **the `(2,2)` block at `s = 1` is at most the pair block's value**, for every
  `n ≥ 12`. So the maximum over the two competing blocks is the pair block's, which is the record's
  "the pair block binds, and the minimum is exactly `-3θ₀/(n-2)`".
* `cn_pos`, `theta0_lt_sqrt_two`, `c_n > 0`, and `θ₀(n) < √2`, which the comparison uses.

## What is NOT typed here

* **Part (a)'s derivative.** The estimate from a multiplier bound to `‖Alt Z‖² ≤ ¼‖H‖²` is
  [L141Contract.lean](L141Contract.lean)'s `half_contraction`, with `Alt` an abstract orthogonal
  projection and `Alt(H) = 0`. `Alt` and `W_-` are built in [AltPart.lean](../Base/AltPart.lean). What
  stays untyped is the derivative `D(Alt W_-)_V` itself and its Daleckii–Krein shape, which needs the
  Daleckii–Krein calculus, and the instantiation at AltPart's `Alt` in `V`'s eigenbasis.
* **Part (b) itself.** `Hess(P|_S)`, `κ_n`, the block decomposition of L120, the support table of
  L133, and the domain `T_{W*}S ∩ T_{W*}𝒪^⊥` are all outside the layer. What is typed is the
  arithmetic of the block comparison on the record's own displayed formulas: monotonicity in `s`,
  the pair block's value, and that the `(2,2)` block does not beat it.
* **That the two blocks above are the only competitors**, and that `Q` is additive over L120's
  blocks. Those are the record's, and the conclusion `Q(H) ≤ -c_n‖H‖²` needs them.
* **The attainment clause**, that `-c_n` is reached on the within-factor pair block, so `c_n` is
  unimprovable.
* **The load-bearing domain caveat**: that `H = W*` is orthogonal to `T_{W*}𝒪` and gives
  `Q(W*) = +3θ₀ > 0`, so the radial direction must be excluded by hand. Nothing here names `W*` as
  a tensor, so the caveat has no expression in this file.
* **`μ = 2/(n-2)` as the `(2,2)` block's `L_e` eigenvalue**, which is L27's; here it is a
  definition, read off the record's own `μ = 1/(m-1)` at `n = 2m`.
-/

namespace HamiltonsCubic.L141Statement

/-! ## Part (a): the multiplier, and the half it is centred to -/

/-- `f(x) = ½(|x| - x)`, the negative part, the function whose Daleckii–Krein multiplier part (a)
prices. -/
noncomputable def negPart (x : ℝ) : ℝ := (|x| - x) / 2

theorem negPart_eq_max (x : ℝ) : negPart x = max 0 (-x) := by
  unfold negPart
  rcases le_or_gt 0 x with h | h
  · rw [abs_of_nonneg h, max_eq_left (by linarith)]; ring
  · rw [abs_of_neg h, max_eq_right (by linarith)]; ring

theorem negPart_antitone : Antitone negPart := by
  intro a b hab
  rw [negPart_eq_max, negPart_eq_max]
  exact max_le_max le_rfl (by linarith)

theorem negPart_lipschitz (x y : ℝ) : |negPart x - negPart y| ≤ |x - y| := by
  rw [negPart_eq_max, negPart_eq_max, max_comm 0 (-x), max_comm 0 (-y)]
  calc |max (-x) 0 - max (-y) 0| ≤ |(-x) - (-y)| := abs_max_sub_max_le_abs _ _ _
    _ = |x - y| := by rw [show (-x) - (-y) = -(x - y) by ring, abs_neg]

/-- The Daleckii–Krein multiplier entry: the divided difference `f^{[1]}(x,y)`. -/
noncomputable def divDiff (x y : ℝ) : ℝ := (negPart x - negPart y) / (x - y)

theorem divDiff_nonpos {x y : ℝ} (hxy : x ≠ y) : divDiff x y ≤ 0 := by
  rw [divDiff, div_nonpos_iff]
  rcases lt_or_gt_of_ne hxy with h | h
  · exact Or.inl ⟨by linarith [negPart_antitone h.le], by linarith⟩
  · exact Or.inr ⟨by linarith [negPart_antitone h.le], by linarith⟩

theorem divDiff_abs_le_one {x y : ℝ} (hxy : x ≠ y) : |divDiff x y| ≤ 1 := by
  have hD : (0 : ℝ) < |x - y| := abs_pos.mpr (sub_ne_zero.mpr hxy)
  rw [divDiff, abs_div, div_le_one hD]
  exact negPart_lipschitz x y

/-- **Every entry of the multiplier lies in `[-1, 0]`**, the record's "a divided difference of a
function with slopes `0` and `-1`". -/
theorem divDiff_mem_Icc {x y : ℝ} (hxy : x ≠ y) : divDiff x y ∈ Set.Icc (-1 : ℝ) 0 := by
  have h1 := divDiff_abs_le_one hxy
  rw [abs_le] at h1
  exact ⟨h1.1, divDiff_nonpos hxy⟩

/-- **THE CONSTANT OF PART (a).** Centring the multiplier at `μ = ½` halves it: every entry of
`f^{[1]} + ½` has absolute value at most `½`. *The `½` is the half-length of the range `[-1,0]` and
nothing else, so it is the same in either sign convention.* -/
theorem recentred_abs_le_half {x y : ℝ} (hxy : x ≠ y) : |divDiff x y + 1 / 2| ≤ 1 / 2 := by
  obtain ⟨h1, h2⟩ := divDiff_mem_Icc hxy
  rw [abs_le]
  constructor <;> linarith

/-- **THE KERNEL BLOCK, AS AN IDENTITY.** Where the multiplier does not exist the exact value is
`D_-`, and `D_- + ½D = ½|D|`. -/
theorem kernel_block_identity (d : ℝ) : negPart d + d / 2 = |d| / 2 := by
  unfold negPart; ring

/-- …**of norm `½‖D‖`**, so the degenerate case meets the same constant, with equality. -/
theorem kernel_block_abs (d : ℝ) : |negPart d + d / 2| = |d| / 2 := by
  rw [kernel_block_identity, abs_div, abs_abs, abs_of_nonneg (by norm_num : (0:ℝ) ≤ 2)]

/-! ## Part (b): the block comparison -/

/-- `θ₀(n) = √(2(n-1)(n-2))/n`, the balanced product's own value. -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (2 * (n - 1) * (n - 2)) / n

/-- `|κ_n| = 9(θ₀(n) - √(3/2))`, the penalty coefficient, nonnegative from `n = 12`. -/
noncomputable def kappaAbs (n : ℝ) : ℝ := 9 * (theta0 n - Real.sqrt (3 / 2))

/-- `μ = 2/(n-2)`, the `L_e` eigenvalue on the `(2,2)` four-set block, the record's `1/(m-1)` at
`n = 2m`. -/
noncomputable def muE (n : ℝ) : ℝ := 2 / (n - 2)

/-- `c_n = 3θ₀(n)/(n-2)`, the lemma's displayed constant. -/
noncomputable def cn (n : ℝ) : ℝ := 3 * theta0 n / (n - 2)

/-- The record's displayed ratio on the `(2,2)` four-set block, as a function of the weight
fraction `s`. -/
noncomputable def Qratio (n s : ℝ) : ℝ :=
  3 * theta0 n * (2 * muE n * s - muE n - 1 / 2) + (2 / 9) * kappaAbs n * s

theorem theta0_sq {n : ℝ} (hn : 3 ≤ n) : theta0 n ^ 2 = 2 * (n - 1) * (n - 2) / n ^ 2 := by
  rw [theta0, div_pow, Real.sq_sqrt (by nlinarith)]

theorem theta0_pos {n : ℝ} (hn : 3 ≤ n) : 0 < theta0 n :=
  div_pos (Real.sqrt_pos.mpr (by nlinarith)) (by linarith)

/-- `θ₀(n) < √2` at every `n ≥ 3`, since `θ₀² = 2 - (6n - 4)/n²`. -/
theorem theta0_lt_sqrt_two {n : ℝ} (hn : 3 ≤ n) : theta0 n < Real.sqrt 2 := by
  refine (Real.lt_sqrt (theta0_pos hn).le).mpr ?_
  rw [theta0_sq hn, div_lt_iff₀ (by positivity)]
  nlinarith

/-- `θ₀(n) ≥ √(3/2)` at every `n ≥ 12`, which is `n² - 12n + 8 ≥ 0`. -/
theorem sqrt_three_halves_le_theta0 {n : ℝ} (hn : 12 ≤ n) : Real.sqrt (3 / 2) ≤ theta0 n := by
  have h0 : 0 < theta0 n := theta0_pos (by linarith)
  have hge : (3 : ℝ) / 2 ≤ theta0 n ^ 2 := by
    rw [theta0_sq (by linarith), le_div_iff₀ (by positivity)]
    nlinarith
  calc Real.sqrt (3 / 2) ≤ Real.sqrt (theta0 n ^ 2) := Real.sqrt_le_sqrt hge
    _ = theta0 n := Real.sqrt_sq h0.le

theorem kappaAbs_nonneg {n : ℝ} (hn : 12 ≤ n) : 0 ≤ kappaAbs n := by
  have := sqrt_three_halves_le_theta0 hn
  rw [kappaAbs]; linarith

theorem cn_pos {n : ℝ} (hn : 12 ≤ n) : 0 < cn n :=
  div_pos (by linarith [theta0_pos (show (3:ℝ) ≤ n by linarith)]) (by linarith)

/-! ### The ratio increases in `s`, so its maximum is at `s = 1` -/

theorem Qratio_slope_pos {n : ℝ} (hn : 12 ≤ n) :
    0 < 6 * theta0 n * muE n + (2 / 9) * kappaAbs n := by
  have h0 : 0 < theta0 n := theta0_pos (by linarith)
  have hmu : 0 < muE n := div_pos (by norm_num) (by linarith)
  have hk : 0 ≤ kappaAbs n := kappaAbs_nonneg hn
  nlinarith

/-- **THE RATIO IS STRICTLY INCREASING IN `s`.** *This is the sentence the record struck an earlier
version of the lemma for getting backwards, that version multiplied a negative bound by `σ` and
then bounded `σ` above.* -/
theorem Qratio_strictMono {n : ℝ} (hn : 12 ≤ n) {s t : ℝ} (hst : s < t) :
    Qratio n s < Qratio n t := by
  have hslope := Qratio_slope_pos hn
  unfold Qratio
  nlinarith

/-- Hence the maximum over `s ∈ [0,1]` sits at `s = 1`, which is `σ = 2/9`. -/
theorem Qratio_le_at_one {n : ℝ} (hn : 12 ≤ n) {s : ℝ} (hs : s ≤ 1) :
    Qratio n s ≤ Qratio n 1 := by
  rcases lt_or_eq_of_le hs with h | h
  · exact le_of_lt (Qratio_strictMono hn h)
  · rw [h]

/-! ### The pair block's value, and that it binds -/

/-- **The pair block's value is `-3θ₀/(n-2)`**: `3θ₀(λ_m - ½)` with `λ_m = (m-2)/(2(m-1))` and
`n = 2m`. So the lemma's `c_n = 3θ₀(n)/(n-2)`. -/
theorem pair_block_value {m : ℝ} (hm : 2 < m) :
    3 * theta0 (2 * m) * ((m - 2) / (2 * (m - 1)) - 1 / 2) = -cn (2 * m) := by
  have h1 : (m : ℝ) - 1 ≠ 0 := by linarith
  have h2 : (2 : ℝ) * m - 2 ≠ 0 := by linarith
  rw [cn]
  field_simp
  ring

/-- **THE PAIR BLOCK BINDS.** At `s = 1` the `(2,2)` four-set block's ratio is at most the pair
block's `-3θ₀/(n-2)`, at every `n ≥ 12`, so the maximum over the two competing blocks is the pair
block's and the lemma's constant is `c_n`.

*The reduction is `9θ₀/(n-2) + θ₀/2 ≤ √6`, and `9/10 + 1/2 = 7/5` with `θ₀ < √2` gives it, since
`(7/5)²·2 = 98/25 < 6`.* -/
theorem pair_block_binds {n : ℝ} (hn : 12 ≤ n) : Qratio n 1 ≤ -cn n := by
  have h0 : 0 < theta0 n := theta0_pos (by linarith)
  have hlt : theta0 n < Real.sqrt 2 := theta0_lt_sqrt_two (by linarith)
  have hs6 : Real.sqrt (3 / 2) * 2 = Real.sqrt 6 := by
    rw [show (6 : ℝ) = 2 ^ 2 * (3 / 2) by norm_num, Real.sqrt_mul (by positivity),
      Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 2)]
    ring
  have hsq2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hsq6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h6pos : (0 : ℝ) < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  have h2pos : (0 : ℝ) ≤ Real.sqrt 2 := Real.sqrt_nonneg 2
  have hkey : (7 : ℝ) / 5 * Real.sqrt 2 < Real.sqrt 6 := by nlinarith
  have hdiv : 9 * theta0 n / (n - 2) ≤ 9 * theta0 n / 10 := by
    apply div_le_div_of_nonneg_left (by linarith) (by norm_num) (by linarith)
  have hmain : 9 * theta0 n / (n - 2) + theta0 n / 2 ≤ Real.sqrt 6 := by nlinarith
  have hexp : Qratio n 1
      = 6 * theta0 n / (n - 2) + theta0 n / 2 - Real.sqrt (3 / 2) * 2 := by
    unfold Qratio kappaAbs muE
    have hne : (n : ℝ) - 2 ≠ 0 := by linarith
    field_simp
    ring
  have hcn : cn n = 3 * theta0 n / (n - 2) := rfl
  rw [hexp, hs6, hcn]
  have hsplit : 9 * theta0 n / (n - 2) = 6 * theta0 n / (n - 2) + 3 * theta0 n / (n - 2) := by
    rw [← add_div]; ring_nf
  linarith

end HamiltonsCubic.L141Statement
