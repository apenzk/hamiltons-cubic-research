import Mathlib
import HamiltonsCubic.Results.L35Weyl
import HamiltonsCubic.Base.WeylReal

/-!
# L35, at most two negative eigenvalues caps `θ` at `√(3/2)`, unconditionally, STATED

From [stratum-two-negative.md](../../../findings/stratum-two-negative.md), the block headed
*"Lemma L35, at most two negative eigenvalues caps `θ` at `√(3/2)`, unconditionally"*, quoted
verbatim:

> **Statement.** Let $W\in\mathrm{Weyl}_m$ have **unit norm** and at most two negative eigenvalues,
> at any number of positive ones, at any $m$. Then $\theta\le\sqrt{3/2}$.

with the two clauses the block attaches to it:

> *Content and sharpness both begin at $m=4$: zero negative eigenvalues is impossible by
> trace-freeness, and the bound is attained at $(2,-1,-1)/\sqrt6$.* **The argument below is written
> for exactly two negative eigenvalues. THE ONE-NEGATIVE CASE IS CLOSED, 2026-09-17, AND MORE STRONGLY
> THAN THIS LEMMA NEEDS: $\theta\le0$.**

> *And $W=0$ satisfies the canonical statement's hypotheses as written, zero negative eigenvalues,
> trace-free, while $\theta$ is $0/0$ there, which the unit-norm form of the statement excludes and
> the canonical form does not.*

and the chain's opening identity, which the file's arithmetic is checked against:

> In an orthonormal eigenbasis, with $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma
> \rangle^2$,
> $$\theta=\sum_\alpha\lambda_\alpha^3+3\!\!\sum_{\alpha<\beta<\gamma}\!\!T_{\alpha\beta\gamma}
> \lambda_\alpha\lambda_\beta\lambda_\gamma,$$
> an identity requiring no Weyl hypothesis, **but requiring $\lVert W\rVert=1$**. […] The
> coefficient $3$ is confirmed twice by disjoint routes: […] and at $(2,-1,-1)/\sqrt6$, where
> $\sum\lambda^3=1/\sqrt6$ and $3T\lambda_1\lambda_2\lambda_3=2/\sqrt6$ with $T=2$ sum to exactly
> $\sqrt{3/2}$.

## What is typed here

**`L35` below is the lemma, PROVED.** The chain is [L35Weyl.lean](L35Weyl.lean)'s `L35_weyl`: the
eigenframe cubic identity, the sign split of the bracket tensor, weak duality for the `(+++)` block,
[L35Pack.lean](L35Pack.lean)'s bounds, [L35Mono.lean](L35Mono.lean)'s monotonicity,
[L35Reduce.lean](L35Reduce.lean)'s two-variable bound and [L35Residual.lean](L35Residual.lean)'s
residual inequality, whose middle band is rational interval arithmetic carried out by the kernel. This
file converts its span-form `Eigenframe` to the layer's expansion form and reads `θ = P` at unit norm.

**Proved here, with no `sorry`:** the identity `bc = (s²+u−1)/2` relating the two negative
eigenvalues to the positive spectrum through trace-freeness and unit norm, the substitution the
relaxation `G` is written in; that the `(++−)` entries enter with a non-positive sign and so are
free to drop from an upper bound, which is what lets the two blocks decouple; that dropping the row
marginals only enlarges the maximum, the record's *"legitimate, since dropping constraints only
enlarges a maximum"*; and the coefficient check at `(2,−1,−1)/√6`, where the two halves of the
identity read `1/√6` and `2/√6` and sum to `√(3/2)` exactly.

## Scope

**The one-negative and zero-negative cases are proved with the rest**: `negatives` in
[L35Weyl.lean](L35Weyl.lean) writes at most two negatives as `−b₀, −c₀` with `c₀ = 0` (and `b₀ = 0`)
when fewer are present, and the same chain runs.

*`θ` is [WeylReal.lean](../Base/WeylReal.lean)'s, `P/‖W‖³` with `P = tr W³ + ⟨W, W#⟩`, the pairing
`innerOp W (sharpOp W)`.*
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L35Statement

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {κ : Type*} [Fintype κ] [DecidableEq κ]

/-! ## The hypothesis -/

/-- **An orthonormal eigenframe for `W` on `Λ²`.** The `v a` are orthonormal skew matrices, each an
eigenvector with eigenvalue `lam a`, and together they span the skew matrices, so `lam` is the
spectrum of `W` on `Λ²`, counted with multiplicity. -/
structure Eigenframe (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (v : κ → Matrix ι ι ℝ) (lam : κ → ℝ) :
    Prop where
  skew : ∀ a, IsSkew (v a)
  orthonormal : ∀ a b, inner2 (v a) (v b) = if a = b then 1 else 0
  eigen : ∀ a, W (v a) = lam a • v a
  complete : ∀ X : Matrix ι ι ℝ, IsSkew X → X ∈ Submodule.span ℝ (Set.range v)

/-- **At most two negative eigenvalues, counted with multiplicity.** -/
def AtMostTwoNegative (lam : κ → ℝ) : Prop :=
  ((Finset.univ : Finset κ).filter fun a => lam a < 0).card ≤ 2

/-! ## The statement -/

/-- **L35.** Let `W ∈ 𝒲_m` have unit norm and at most two negative eigenvalues, at any number of
positive ones and at any `m`. Then `θ(W) ≤ √(3/2)`.

*Unit norm is a normalisation rather than a restriction, `θ` being `0`-homogeneous, and it carries
the eigenframe identity the proof opens with, and it excludes `W = 0`, the one point the hypotheses
otherwise admit and at which `θ` is `0/0`.*

**Proved** through [L35Weyl.lean](L35Weyl.lean)'s `L35_weyl`; standard three axioms. -/
theorem L35 (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeyl W) (hnorm : norm W = 1)
    (v : κ → Matrix ι ι ℝ) (lam : κ → ℝ) (hframe : Eigenframe W v lam)
    (hneg : AtMostTwoNegative lam) : theta W ≤ Real.sqrt (3 / 2) := by
  -- the span-form frame is an expansion-form frame
  have hlin : ∀ (c : κ → ℝ) (δ : κ), inner2 (∑ i, c i • v i) (v δ) = ∑ i, c i * inner2 (v i) (v δ) := by
    intro c δ
    unfold inner2
    simp only [Matrix.transpose_sum, Matrix.transpose_smul, Matrix.sum_mul, Matrix.smul_mul, Matrix.trace_sum,
      Matrix.trace_smul, smul_eq_mul, Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by ring
  have hf : HamiltonsCubic.L41Statement.EigenFrame W v lam := by
    refine ⟨hframe.skew, hframe.orthonormal, hframe.eigen, fun X hX => ?_⟩
    obtain ⟨c, hc⟩ := (Submodule.mem_span_range_iff_exists_fun ℝ).mp (hframe.complete X hX)
    have hcoef : ∀ δ, inner2 X (v δ) = c δ := by
      intro δ
      rw [← hc, hlin]
      simp [hframe.orthonormal]
    conv_lhs => rw [← hc]
    exact Finset.sum_congr rfl fun δ _ => by rw [hcoef]
  have hn : normSq W = 1 := by
    have h := hnorm
    unfold HamiltonsCubic.RealLayer.norm at h
    rw [Real.sqrt_eq_one] at h
    exact h
  have hP := HamiltonsCubic.L35Residual.L35_weyl hW hf hn hneg
  unfold theta
  rw [hnorm, one_pow, div_one]
  exact hP

/-! ## The substitution the relaxation is written in -/

/-- **`bc = (s² + u − 1)/2`**, from trace-freeness `s = b + c` and unit norm `u + b² + c² = 1`,
where `b, c` are the two negative eigenvalues' magnitudes and `s`, `u` the first and second power
sums of the positive ones. *This is the record's own substitution inside `G`.* -/
theorem neg_product {b c s u : ℝ} (htrace : s = b + c) (hnorm : u + b ^ 2 + c ^ 2 = 1) :
    b * c = (s ^ 2 + u - 1) / 2 := by
  subst htrace; nlinarith [hnorm]

/-! ## The `(++−)` block drops -/

/-- **The `(++−)` entries enter with a non-positive sign**, since `T ≥ 0` and `λ₊λ₊λ₋ < 0`, so they
are free to drop from an upper bound, which is what lets the `(+++)` and `(+--)` blocks consume
disjoint pair caps. -/
theorem plus_plus_minus_nonpos {T lp lq lm : ℝ} (hT : 0 ≤ T) (hp : 0 < lp) (hq : 0 < lq)
    (hm : lm < 0) : T * (lp * lq * lm) ≤ 0 :=
  mul_nonpos_of_nonneg_of_nonpos hT (le_of_lt (mul_neg_of_pos_of_neg (mul_pos hp hq) hm))

/-! ## Dropping constraints only enlarges a maximum -/

/-- **Dropping the row marginals is legitimate**: an upper bound for the larger feasible set is an
upper bound for the smaller one. *The record's reason `LP ≤ G`.* -/
theorem upper_bound_of_subset {A B : Set ℝ} (hAB : A ⊆ B) {x : ℝ} (hx : x ∈ upperBounds B) :
    x ∈ upperBounds A := fun _ ha => hx (hAB ha)

/-! ## The coefficient check at `(2,−1,−1)/√6` -/

theorem sqrt_six_sq : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)

theorem sqrt_six_pos : 0 < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)

theorem sqrt_three_halves : Real.sqrt (3 / 2) = Real.sqrt 6 / 2 := by
  have h : (3:ℝ) / 2 = (Real.sqrt 6 / 2) ^ 2 := by
    rw [div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 6)]; norm_num
  rw [h, Real.sqrt_sq (by positivity)]

/-- **`∑λ³ = 1/√6` at the spectrum `(2,−1,−1)/√6`.** -/
theorem cube_sum_at_maximiser :
    (2 / Real.sqrt 6) ^ 3 + (-(1 / Real.sqrt 6)) ^ 3 + (-(1 / Real.sqrt 6)) ^ 3
      = 1 / Real.sqrt 6 := by
  have hne : Real.sqrt 6 ≠ 0 := ne_of_gt sqrt_six_pos
  field_simp
  linear_combination (-1 : ℝ) * sqrt_six_sq

/-- **`3Tλ₁λ₂λ₃ = 2/√6` there, at `T = 2`.** -/
theorem bracket_term_at_maximiser :
    3 * 2 * ((2 / Real.sqrt 6) * (-(1 / Real.sqrt 6)) * (-(1 / Real.sqrt 6)))
      = 2 / Real.sqrt 6 := by
  have hne : Real.sqrt 6 ≠ 0 := ne_of_gt sqrt_six_pos
  field_simp
  linear_combination (-1 : ℝ) * sqrt_six_sq

/-- **And the two halves sum to `√(3/2)` exactly**, the record's second confirmation of the
coefficient `3`. -/
theorem identity_at_maximiser :
    ((2 / Real.sqrt 6) ^ 3 + (-(1 / Real.sqrt 6)) ^ 3 + (-(1 / Real.sqrt 6)) ^ 3)
      + 3 * 2 * ((2 / Real.sqrt 6) * (-(1 / Real.sqrt 6)) * (-(1 / Real.sqrt 6)))
      = Real.sqrt (3 / 2) := by
  rw [cube_sum_at_maximiser, bracket_term_at_maximiser, sqrt_three_halves]
  have hne : Real.sqrt 6 ≠ 0 := ne_of_gt sqrt_six_pos
  field_simp
  linear_combination (-1 : ℝ) * sqrt_six_sq

/-- **The maximiser's spectrum is trace-free and of unit norm**, so the statement's hypotheses are
satisfied at the scalar level by the point at which the record says the bound is attained. -/
theorem maximiser_admissible :
    (2 / Real.sqrt 6) + (-(1 / Real.sqrt 6)) + (-(1 / Real.sqrt 6)) = 0 ∧
    (2 / Real.sqrt 6) ^ 2 + (-(1 / Real.sqrt 6)) ^ 2 + (-(1 / Real.sqrt 6)) ^ 2 = 1 := by
  have hne : Real.sqrt 6 ≠ 0 := ne_of_gt sqrt_six_pos
  constructor
  · field_simp
    norm_num
  · field_simp
    linear_combination (-1 : ℝ) * sqrt_six_sq

end HamiltonsCubic.L35Statement
