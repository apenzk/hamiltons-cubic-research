import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.L31Statement
import HamiltonsCubic.Results.FrameExtension
import HamiltonsCubic.Results.L41Statement
import HamiltonsCubic.Results.CP2Real

/-!
# L29, one positive and two negative eigenvalues cap `θ` at `√(3/2)`, STATED

From [stratum-two-negative.md](../../../findings/stratum-two-negative.md), the block headed
*"Lemma L29 (one positive and two negative eigenvalues cap `θ` at `√(3/2)`), canonical statement
and proof"*, quoted verbatim:

> **Statement.** Let $W\in\mathrm{Weyl}_n$ have $\|W\|=1$ and exactly one positive and two negative
> eigenvalues, $\lambda_1>0>-a\ge-b$. Then $\theta(W)\le\sqrt{3/2}$, attained at the spectrum
> $(2,-1,-1)/\sqrt6$. The bound carries no dimension restriction.

with the proof's own closing display, which is what this file proves:

> Trace-freeness gives $\lambda_1=a+b$ and unit norm $(a+b)^2+a^2+b^2=1$; both are scale-free in
> $t=b/a$, and substituting collapses the estimate to
> $$\theta\le f(t)=\frac{9\sqrt2\,t(t+1)}{4\,(t^2+t+1)^{3/2}},$$
> whose unique stationary point on $t\ge0$ is $t=1$, with $f(1)=\sqrt{3/2}$, $f(0)=0$ and $f\to0$ as
> $t\to\infty$. Hence the maximum is $\sqrt{3/2}$, attained only at $a=b$.

and the record's reading of the counting convention, which the Lean hypothesis follows:

> **The counting convention is load-bearing on the positive side: under the distinct-value reading
> the proof fails**, and no covering result closes that case. ([results.md](../../../results.md))

## What is typed here

**`L29` below is the lemma, proved.** The eigenframe is completed by
[FrameExtension.lean](FrameExtension.lean), the expansion and the vanishing blocks come from
[L41Statement.lean](L41Statement.lean)'s frame formulas, and [L31Statement.lean](L31Statement.lean)'s
pair cap `‖[v_α,v_β]‖² ≤ 2` bounds the surviving `(+--)` block.

**Also proved here:** the whole of the last step, that the estimate, once collapsed by
trace-freeness and unit norm, is `9ab(a+b)` and is at most `√(3/2)` with equality exactly at
`a = b`; the same statement in the record's scale-free variable `t = b/a` as the displayed `f`; and
that the maximiser is the spectrum `(2,−1,−1)/√6`, which is trace-free and of unit norm.

**The inequality is an exact square**, which is why it needs no calculus:

`4(a²+ab+b²)³ − 27a²b²(a+b)² = ((2a+b)(b−a)(a+2b))²`.

*The record reaches the same point by locating the unique stationary point of `f` on `t ≥ 0`.*

## What is NOT typed here

**The universal attainment.** `L29_attained` is the record's *"attained at the spectrum
`(2,−1,−1)/√6`"* as an existence statement, proved with padded `W_{ℂP²}`, which also shows the
hypotheses of `L29` non-empty. That EVERY `W` with that spectrum attains is open and not typed: it
is the claim `κ² = 2` on the whole stratum.

*`θ` is [WeylReal.lean](../Base/WeylReal.lean)'s, whose own docstring records that its `sharpPair`
term is even in `R` and so is `tr(R#)` rather than `⟨R#,R⟩`; the statement here is against that
`theta`, so that a repair at the base repairs this consumer with it.*
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L29Statement

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## `√(3/2)` in the form the algebra wants -/

/-- **`√(3/2) = √6/2`.** -/
theorem sqrt_three_halves : Real.sqrt (3 / 2) = Real.sqrt 6 / 2 := by
  have h : (3:ℝ) / 2 = (Real.sqrt 6 / 2) ^ 2 := by
    rw [div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 6)]; norm_num
  rw [h, Real.sqrt_sq (by positivity)]

theorem sqrt_six_sq : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)

theorem sqrt_six_pos : 0 < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)

/-! ## The identity the whole last step runs on -/

/-- **The estimate's numerator collapses to `9ab(a+b)`**: the exact `tr W³ = λ₁³ − (a³+b³)` at
`λ₁ = a + b`, plus the pair-capped `(+--)` block `6λ₁ab`. -/
theorem chain_numerator (a b : ℝ) :
    (a + b) ^ 3 - (a ^ 3 + b ^ 3) + 6 * (a + b) * a * b = 9 * a * b * (a + b) := by ring

/-- **The inequality is an exact square.** *`4(a²+ab+b²)³ − 27a²b²(a+b)² = ((2a+b)(b−a)(a+2b))²`*,
which is why the maximum needs no calculus and why it is attained exactly at `a = b`. -/
theorem key_square (a b : ℝ) :
    4 * (a ^ 2 + a * b + b ^ 2) ^ 3 - 27 * a ^ 2 * b ^ 2 * (a + b) ^ 2
      = ((2 * a + b) * (b - a) * (a + 2 * b)) ^ 2 := by ring

/-! ## The estimate at unit norm -/

/-- The estimate the proof's chain produces, at `λ₁ = a + b`. -/
noncomputable def chainValue (a b : ℝ) : ℝ := (a + b) ^ 3 - (a ^ 3 + b ^ 3) + 6 * (a + b) * a * b

/-- **The estimate is at most `√(3/2)` on the unit-norm stratum.** *`‖W‖ = 1` reads
`(a+b)² + a² + b² = 1` once trace-freeness has given `λ₁ = a + b`.* -/
theorem chainValue_le {a b : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hnorm : (a + b) ^ 2 + a ^ 2 + b ^ 2 = 1) : chainValue a b ≤ Real.sqrt (3 / 2) := by
  rw [sqrt_three_halves, chainValue, chain_numerator]
  have hL : 0 ≤ 9 * a * b * (a + b) := by positivity
  have hR : 0 ≤ Real.sqrt 6 / 2 := by positivity
  have hu : a ^ 2 + a * b + b ^ 2 = 1 / 2 := by nlinarith [hnorm]
  have hsq : (9 * a * b * (a + b)) ^ 2 ≤ (Real.sqrt 6 / 2) ^ 2 := by
    have e : (Real.sqrt 6 / 2) ^ 2 = 6 / 4 := by rw [div_pow, sqrt_six_sq]; norm_num
    rw [e]
    have h4 : 4 * (a ^ 2 + a * b + b ^ 2) ^ 3 = 1 / 2 := by rw [hu]; norm_num
    have h27 : 27 * a ^ 2 * b ^ 2 * (a + b) ^ 2 ≤ 1 / 2 := by
      linarith [key_square a b, sq_nonneg ((2 * a + b) * (b - a) * (a + 2 * b)), h4]
    have hexp : (9 * a * b * (a + b)) ^ 2 = 3 * (27 * a ^ 2 * b ^ 2 * (a + b) ^ 2) := by ring
    linarith [hexp, h27]
  nlinarith [hsq, hL, hR]

/-- **Equality exactly at `a = b`.** -/
theorem chainValue_eq_iff {a b : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hnorm : (a + b) ^ 2 + a ^ 2 + b ^ 2 = 1) :
    chainValue a b = Real.sqrt (3 / 2) ↔ a = b := by
  have hu : a ^ 2 + a * b + b ^ 2 = 1 / 2 := by nlinarith [hnorm]
  constructor
  · intro h
    rw [sqrt_three_halves, chainValue, chain_numerator] at h
    have hsq : (9 * a * b * (a + b)) ^ 2 = (Real.sqrt 6 / 2) ^ 2 := by rw [h]
    have e : (Real.sqrt 6 / 2) ^ 2 = 6 / 4 := by rw [div_pow, sqrt_six_sq]; norm_num
    rw [e] at hsq
    have h4 : 4 * (a ^ 2 + a * b + b ^ 2) ^ 3 = 1 / 2 := by rw [hu]; norm_num
    have hexp : (9 * a * b * (a + b)) ^ 2 = 3 * (27 * a ^ 2 * b ^ 2 * (a + b) ^ 2) := by ring
    have hz : ((2 * a + b) * (b - a) * (a + 2 * b)) ^ 2 = 0 := by
      linarith [key_square a b, h4, hexp, hsq]
    have hz' : (2 * a + b) * (b - a) * (a + 2 * b) = 0 := by
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hz
    rcases mul_eq_zero.mp hz' with h1 | h1
    · rcases mul_eq_zero.mp h1 with h2 | h2
      · nlinarith [h2]
      · linarith [h2]
    · nlinarith [h1]
  · rintro rfl
    rw [sqrt_three_halves, chainValue, chain_numerator]
    have hu' : a ^ 2 = 1 / 6 := by nlinarith [hu]
    have hapos : 0 < a := ha
    have h6 : Real.sqrt 6 / 2 = 9 * a * a * (a + a) := by
      have : (9 * a * a * (a + a)) ^ 2 = 6 / 4 := by
        have e3 : (9 * a * a * (a + a)) ^ 2 = 324 * (a ^ 2) ^ 3 := by ring
        rw [e3, hu']; norm_num
      have hnn : 0 ≤ 9 * a * a * (a + a) := by positivity
      have hs : Real.sqrt 6 / 2 = Real.sqrt (6 / 4) := by
        rw [show (6:ℝ)/4 = (Real.sqrt 6 / 2) ^ 2 by rw [div_pow, sqrt_six_sq]; norm_num,
          Real.sqrt_sq (by positivity)]
      rw [hs, ← this, Real.sqrt_sq hnn]
    exact h6.symm

/-! ## The same statement in the record's scale-free variable -/

/-- The record's `f(t) = 9√2 t(t+1) / (4 (t²+t+1)^{3/2})`. -/
noncomputable def f (t : ℝ) : ℝ :=
  9 * Real.sqrt 2 * t * (t + 1) / (4 * Real.sqrt (t ^ 2 + t + 1) ^ 3)

/-- **`f(1) = √(3/2)`.** -/
theorem f_one : f 1 = Real.sqrt (3 / 2) := by
  have h3 : Real.sqrt ((1:ℝ) ^ 2 + 1 + 1) = Real.sqrt 3 := by norm_num
  have hs3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hs2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hp3 : 0 < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  have hp2 : 0 < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  rw [f, h3, sqrt_three_halves]
  have hden : (0:ℝ) < 4 * Real.sqrt 3 ^ 3 := by positivity
  rw [div_eq_iff (ne_of_gt hden)]
  have h6 : Real.sqrt 6 = Real.sqrt 2 * Real.sqrt 3 := by
    rw [← Real.sqrt_mul (by norm_num : (0:ℝ) ≤ 2)]; norm_num
  rw [h6]
  linear_combination (-2 * Real.sqrt 2 * (Real.sqrt 3 ^ 2 + 3)) * hs3

/-- **`f(0) = 0`**, the record's left endpoint. -/
theorem f_zero : f 0 = 0 := by simp [f]

/-- **`f(t) ≤ √(3/2)` on `t ≥ 0`**, which with `f 1` is the record's *"the maximum is `√(3/2)`,
attained only at `a = b`"* read at `t = b/a`. -/
theorem f_le {t : ℝ} (ht : 0 ≤ t) : f t ≤ Real.sqrt (3 / 2) := by
  rw [sqrt_three_halves, f]
  have hq : (0:ℝ) < t ^ 2 + t + 1 := by nlinarith
  have hs : 0 < Real.sqrt (t ^ 2 + t + 1) := Real.sqrt_pos.mpr hq
  have hs2 : Real.sqrt (t ^ 2 + t + 1) ^ 2 = t ^ 2 + t + 1 := Real.sq_sqrt hq.le
  have hden : (0:ℝ) < 4 * Real.sqrt (t ^ 2 + t + 1) ^ 3 := by positivity
  rw [div_le_iff₀ hden]
  have hL : 0 ≤ 9 * Real.sqrt 2 * t * (t + 1) := by positivity
  have hR : 0 ≤ Real.sqrt 6 / 2 * (4 * Real.sqrt (t ^ 2 + t + 1) ^ 3) := by positivity
  have hsq : (9 * Real.sqrt 2 * t * (t + 1)) ^ 2
      ≤ (Real.sqrt 6 / 2 * (4 * Real.sqrt (t ^ 2 + t + 1) ^ 3)) ^ 2 := by
    have e1 : (9 * Real.sqrt 2 * t * (t + 1)) ^ 2 = 162 * t ^ 2 * (t + 1) ^ 2 := by
      have : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
      nlinarith [this]
    have e2 : (Real.sqrt 6 / 2 * (4 * Real.sqrt (t ^ 2 + t + 1) ^ 3)) ^ 2
        = 24 * (t ^ 2 + t + 1) ^ 3 := by
      have h6 : Real.sqrt 6 ^ 2 = 6 := sqrt_six_sq
      have e : (Real.sqrt 6 / 2 * (4 * Real.sqrt (t ^ 2 + t + 1) ^ 3)) ^ 2
          = Real.sqrt 6 ^ 2 * 4 * (Real.sqrt (t ^ 2 + t + 1) ^ 2) ^ 3 := by ring
      rw [e, h6, hs2]; ring
    rw [e1, e2]
    nlinarith [key_square 1 t, sq_nonneg ((2 + t) * (t - 1) * (1 + 2 * t))]
  nlinarith [hsq, hL, hR]

/-! ## The maximiser, and the two constraints it satisfies -/

/-- **The spectrum `(2,−1,−1)/√6` is trace-free and of unit norm**, so it is admissible for the
statement's hypotheses at the scalar level: `a = b = 1/√6`, `λ₁ = 2/√6 = a + b`. -/
theorem spectrum_admissible :
    (1 / Real.sqrt 6 + 1 / Real.sqrt 6) = 2 / Real.sqrt 6 ∧
    (1 / Real.sqrt 6 + 1 / Real.sqrt 6) ^ 2 + (1 / Real.sqrt 6) ^ 2 + (1 / Real.sqrt 6) ^ 2 = 1 := by
  have h6 : Real.sqrt 6 ^ 2 = 6 := sqrt_six_sq
  have hne : Real.sqrt 6 ≠ 0 := ne_of_gt sqrt_six_pos
  refine ⟨by ring, ?_⟩
  field_simp
  nlinarith [h6]

/-- **And there the estimate reads exactly `√(3/2)`.** -/
theorem chainValue_at_maximiser :
    chainValue (1 / Real.sqrt 6) (1 / Real.sqrt 6) = Real.sqrt (3 / 2) := by
  have hpos : 0 < 1 / Real.sqrt 6 := by positivity
  exact (chainValue_eq_iff hpos hpos spectrum_admissible.2).mpr rfl

/-! ## The lemma -/

/-- **The stratum's hypothesis, counted WITH multiplicity.** `v₁`, `v₂`, `v₃` are orthonormal
bivectors with `W v₁ = λ₁ v₁`, `W v₂ = −a v₂`, `W v₃ = −b v₃`, and `W` annihilates every bivector
orthogonal to all three, so the spectrum is `(λ₁, −a, −b, 0, …)`, *exactly one positive and two
negative eigenvalues*.

*The counting convention is the record's own and is load-bearing: under the distinct-value reading
the proof fails.* -/
structure OnePosTwoNeg (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (v₁ v₂ v₃ : Matrix ι ι ℝ)
    (lam a b : ℝ) : Prop where
  skew₁ : IsSkew v₁
  skew₂ : IsSkew v₂
  skew₃ : IsSkew v₃
  unit₁ : inner2 v₁ v₁ = 1
  unit₂ : inner2 v₂ v₂ = 1
  unit₃ : inner2 v₃ v₃ = 1
  orth₁₂ : inner2 v₁ v₂ = 0
  orth₁₃ : inner2 v₁ v₃ = 0
  orth₂₃ : inner2 v₂ v₃ = 0
  eig₁ : W v₁ = lam • v₁
  eig₂ : W v₂ = (-a) • v₂
  eig₃ : W v₃ = (-b) • v₃
  rest : ∀ Y : Matrix ι ι ℝ, IsSkew Y → inner2 v₁ Y = 0 → inner2 v₂ Y = 0 → inner2 v₃ Y = 0 →
    W Y = 0
  pos : 0 < lam
  aneg : 0 < a
  bneg : 0 < b
  order : a ≤ b

/-- **Cauchy–Schwarz for the `Λ²` pairing.** -/
theorem inner2_cs (X Y : Matrix ι ι ℝ) : inner2 X Y ^ 2 ≤ inner2 X X * inner2 Y Y := by
  have := HamiltonsCubic.L31Statement.Proof.fdot_sq_le X Y
  unfold HamiltonsCubic.L31Statement.Proof.fdot HamiltonsCubic.L31Statement.Proof.fsq at this
  unfold inner2
  nlinarith [this]

open HamiltonsCubic.L41Statement.Frame in
/-- **L29.** Let `W ∈ 𝒲ₙ` have `‖W‖ = 1` and exactly one positive and two negative eigenvalues,
`λ₁ > 0 > −a ≥ −b`. Then `θ(W) ≤ √(3/2)`. **The bound carries no dimension restriction**, `ι` is
an arbitrary finite index type.

**Proved.** *[FrameExtension.lean](FrameExtension.lean) completes `v₁, v₂, v₃` to an eigenframe,
the rest carrying eigenvalue `0` by `rest`; Ricci-flatness makes the frame trace vanish, so
`λ₁ = a + b`; [L41Statement.lean](L41Statement.lean)'s frame formulas give
`P = λ³ - a³ - b³ + 3λab κ²` with `κ = ⟨[v₁,v₂],v₃⟩`, the structure constants with a repeated index
vanishing and the six permutations sharing `κ²`; and Cauchy–Schwarz with
[L31](L31Statement.lean)'s cap gives `κ² ≤ 2`, so `P ≤ chainValue a b ≤ √(3/2)`.* -/
theorem L29 (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeyl W) (hnorm : norm W = 1)
    {v₁ v₂ v₃ : Matrix ι ι ℝ} {lam a b : ℝ} (hspec : OnePosTwoNeg W v₁ v₂ v₃ lam a b) :
    theta W ≤ Real.sqrt (3 / 2) := by
  classical
  let f : Fin 3 → Matrix ι ι ℝ := ![v₁, v₂, v₃]
  have hfs : ∀ i, IsSkew (f i) := by
    intro i; fin_cases i
    exacts [hspec.skew₁, hspec.skew₂, hspec.skew₃]
  have hsym : ∀ X Y : Matrix ι ι ℝ, inner2 X Y = inner2 Y X := inner2_comm
  have hfon : ∀ i j, inner2 (f i) (f j) = if i = j then 1 else 0 := by
    intro i j; fin_cases i <;> fin_cases j <;>
      simp [f, hspec.unit₁, hspec.unit₂, hspec.unit₃, hspec.orth₁₂, hspec.orth₁₃, hspec.orth₂₃,
        hsym v₂ v₁, hsym v₃ v₁, hsym v₃ v₂]
  obtain ⟨r, g, hgs, hgon, hfg, hcomp⟩ := HamiltonsCubic.FrameExtension.extend_frame f hfs hfon
  have hgf : ∀ c i, inner2 (g c) (f i) = 0 := fun c i => by rw [hsym]; exact hfg i c
  let lamF : Fin 3 → ℝ := ![lam, -a, -b]
  let v : Fin 3 ⊕ Fin r → Matrix ι ι ℝ := Sum.elim f g
  let lv : Fin 3 ⊕ Fin r → ℝ := Sum.elim lamF (fun _ => 0)
  have hWg : ∀ c, W (g c) = 0 := fun c =>
    hspec.rest (g c) (hgs c) (by rw [hsym]; exact hgf c 0) (by rw [hsym]; exact hgf c 1)
      (by rw [hsym]; exact hgf c 2)
  have hf : HamiltonsCubic.L41Statement.EigenFrame W v lv := by
    refine ⟨?_, ?_, ?_, ?_⟩
    · rintro (i|c); exacts [hfs i, hgs c]
    · rintro (i|c) (j|d) <;> simp [v, hfon, hgon, hfg, hgf]
    · rintro (i|c)
      · fin_cases i
        · simp [v, lv, f, lamF, hspec.eig₁]
        · simp [v, lv, f, lamF, hspec.eig₂]
        · simp [v, lv, f, lamF, hspec.eig₃]
      · simp [v, lv, hWg]
    · intro X hX; rw [Fintype.sum_sum_type]; exact hcomp X hX
  -- the norm
  have hns : normSq W = 1 := by
    unfold HamiltonsCubic.RealLayer.norm at hnorm; exact Real.sqrt_eq_one.mp hnorm
  have hn3 : lam ^ 2 + a ^ 2 + b ^ 2 = 1 := by
    have := normSq_frame hW hf
    rw [hns] at this
    simp only [Fintype.sum_sum_type, lv, Sum.elim_inl, Sum.elim_inr, Fin.sum_univ_three, lamF,
      Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons,
      ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, Finset.sum_const_zero, add_zero] at this
    nlinarith [this]
  -- trace-freeness from Ricci-flatness
  have htr : lam - a - b = 0 := by
    have e1 := innerOp_frame hf W (fun X => X) (fun c => weyl_lin hW _ c v hf.skew) (fun c => rfl)
    have e3 : innerOp W (fun X => X) = 0 := by
      unfold innerOp
      have : ∀ i, ∑ j, inner2 (W (phi i j)) (phi i j) = 0 := fun i => hW.2.2.2 i i
      simp [this]
    rw [e3] at e1
    simp only [hf.eigen, inner2_smul_l, hf.orthonormal, if_true, mul_one] at e1
    simp only [Fintype.sum_sum_type, lv, Sum.elim_inl, Sum.elim_inr, Fin.sum_univ_three, lamF,
      Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons,
      Finset.sum_const_zero, add_zero] at e1
    linarith
  -- the structure constants
  have c12 : ∀ x y, cst v x x y = 0 := fun x y => by
    unfold cst; simp [br, inner2]
  have c23 : ∀ x y, cst v x y y = 0 := fun x y => by
    have := cst_swap23 hf x y y; linarith
  have c13 : ∀ x y, cst v x y x = 0 := fun x y => by
    rw [cst_swap23 hf, c12, neg_zero]
  set κ := cst v (Sum.inl 0) (Sum.inl 1) (Sum.inl 2) with hκ
  have p1 : cst v (Sum.inl 0) (Sum.inl 2) (Sum.inl 1) ^ 2 = κ ^ 2 := by rw [T23 hf]
  have p2 : cst v (Sum.inl 1) (Sum.inl 0) (Sum.inl 2) ^ 2 = κ ^ 2 := by rw [T12 hf]
  have p3 : cst v (Sum.inl 1) (Sum.inl 2) (Sum.inl 0) ^ 2 = κ ^ 2 := by rw [T23 hf, T12 hf]
  have p4 : cst v (Sum.inl 2) (Sum.inl 0) (Sum.inl 1) ^ 2 = κ ^ 2 := by rw [T12 hf, T23 hf]
  have p5 : cst v (Sum.inl 2) (Sum.inl 1) (Sum.inl 0) ^ 2 = κ ^ 2 := by rw [T23 hf, T12 hf, T23 hf]
  have hsharp : sharpPair W = 3 * lam * a * b * κ ^ 2 := by
    rw [sharpPair_T hW hf]
    simp only [Fintype.sum_sum_type, lv, Sum.elim_inl, Sum.elim_inr, zero_mul, mul_zero,
      Finset.sum_const_zero, add_zero, Fin.sum_univ_three]
    simp only [c12, c23, c13, p1, p2, p3, p4, p5, lamF, Matrix.cons_val_zero, Matrix.cons_val_one,
      Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons, ne_eq, OfNat.ofNat_ne_zero,
      not_false_eq_true, zero_pow, mul_zero, zero_mul, add_zero, zero_add]
    ring
  have hcube : trCube W = lam ^ 3 - a ^ 3 - b ^ 3 := by
    rw [trCube_frame hW hf]
    simp only [Fintype.sum_sum_type, lv, Sum.elim_inl, Sum.elim_inr, Fin.sum_univ_three, lamF,
      Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons,
      ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, Finset.sum_const_zero, add_zero]
    ring
  -- the pair cap
  have hκ2 : κ ^ 2 ≤ 2 := by
    have hκe : κ = inner2 (br v₁ v₂) v₃ := rfl
    have hcs := inner2_cs (br v₁ v₂) v₃
    have hcap := HamiltonsCubic.L31Statement.L31_cap_unit v₁ v₂ hspec.skew₁ hspec.skew₂ hspec.unit₁
      hspec.unit₂
    rw [hκe]; rw [hspec.unit₃] at hcs; nlinarith
  -- assemble
  have hθ : theta W = lam ^ 3 - a ^ 3 - b ^ 3 + 3 * lam * a * b * κ ^ 2 := by
    unfold theta Pcubic; rw [hnorm, one_pow, div_one, hcube, hsharp]
  have hlam : lam = a + b := by linarith
  have hpos : 0 < lam * a * b := by
    have := hspec.pos; have := hspec.aneg; have := hspec.bneg; positivity
  have hchain := chainValue_le hspec.aneg hspec.bneg (by rw [← hlam]; linarith)
  unfold chainValue at hchain
  rw [hθ]
  rw [hlam] at hpos ⊢
  nlinarith [hκ2, hpos]


/-- **The attainment clause.** At the spectrum `(2,−1,−1)/√6` the bound is attained: at every `n ≥ 4`
some unit `W ∈ 𝒲ₙ` has that spectrum on an orthonormal triple, vanishes off it, and has
`θ = √(3/2)`.

**Proved**, with [CP2Real.lean](CP2Real.lean)'s padded `W_{ℂP²}` and its frame `ω₀, ω₁, ω₂`.
*The universal form, that EVERY such `W` attains, is not typed: at `a = b` the chain gives
`θ = (1 + κ²)/√6` with `κ = ⟨[v₁,v₂],v₃⟩`, and whether Weyl forces `κ² = 2` on the whole stratum is
open. [L41](L41Statement.lean)'s `A(W) = 2W` row forces every pair bracket to saturate,
`‖[v_i,v_j]‖² = 2`, which bounds `κ²` by `2` and does not fix it.* -/
theorem L29_attained (n : ℕ) (hn : 4 ≤ n) :
    ∃ (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (v₁ v₂ v₃ : Matrix (Fin n) (Fin n) ℝ),
      IsWeyl W ∧ norm W = 1 ∧
      OnePosTwoNeg W v₁ v₂ v₃ (2 / Real.sqrt 6) (1 / Real.sqrt 6) (1 / Real.sqrt 6) ∧
      theta W = Real.sqrt (3 / 2) := by
  open HamiltonsCubic.CP2Real in
  have hp : (0 : ℝ) < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  have hrest : ∀ Y : Matrix (Fin n) (Fin n) ℝ, IsSkew Y → inner2 (om 0) Y = 0 → inner2 (om 1) Y = 0 →
      inner2 (om 2) Y = 0 → Wc n Y = 0 := by
    intro Y _ h0 h1 h2
    refine Wc_perp Y fun a => ?_
    rw [inner2_comm]
    fin_cases a
    exacts [h0, h1, h2]
  refine ⟨Wc n, om 0, om 1, om 2, Wc_weyl hn, ?_, ⟨om_skew 0, om_skew 1, om_skew 2, ?_, ?_, ?_, ?_, ?_, ?_,
    ?_, ?_, ?_, hrest, by positivity, by positivity, by positivity, le_refl _⟩, Wc_theta hn⟩
  · unfold HamiltonsCubic.RealLayer.norm; rw [(Wc_values hn).1, Real.sqrt_one]
  all_goals first
    | (simp [om_inner hn]; done)
    | (rw [Wc_om hn]; rfl)
    | (rw [Wc_om hn]; simp [mu, s6])

end HamiltonsCubic.L29Statement
