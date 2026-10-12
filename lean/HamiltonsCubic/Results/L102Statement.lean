import Mathlib

set_option linter.style.longLine false

/-!
# L102, annihilation against orthogonality, and the closed form `V(t)` it feeds

## The record's statement, quoted verbatim from [route-a.md](../../../findings/route-a.md)

> #### Observation L102, $M_{W_1}\cdot\Pi_{\ker}Q(W_1)=0$, residual $\le8.5\times10^{-15}$ at $n=12,14,16$, load-bearing for Observation L22

> **The frontier has an exact closed form, and it is the true maximum rather than an estimate.** For
> every $W_1\in V_{1/3}$,
> $$M_{W_1}\cdot\Pi_{\ker}Q(W_1)=0\qquad(\text{residual}\le8.5\times10^{-15}\text{ at }n=12,14,16;\ \text{control }0.33),$$
> so the inner maximisation over $K$ is a **hard-case trust-region problem**, globally solvable
> rather than ascended. Its value is monotone in both $a\le\sqrt{5/6}$ and $\lambda\le2/3$, and both
> suprema are attained at the same $W_1^*$, giving
> $$V(t)=\begin{cases}\sqrt{5/6}, & t\le t^*\\[2pt] \dfrac{5}{16t}+\dfrac{2t}{3}, & t>t^*\end{cases}\qquad t^*=\tfrac34\sqrt{\tfrac56}=\tfrac{\sqrt{30}}8=0.6846532,$$

and the Gate 2 verdict, which is what makes the distinction below load-bearing:

> **THE RECORD STATED THIS TWICE IN INEQUIVALENT FORMS** […] [ATTEMPTS.md](../ATTEMPTS.md) reads
> *"orthogonal to the top eigenspace, **not** annihilated by the operator"*. **Annihilation is the
> measured statement**: […] returning $2.2$, $7.5$ and $8.5\times10^{-15}$ at $n=12,14,16$ against
> a control of $0.33$, **jointly a separation of more than thirteen orders at every dimension
> measured, and more than fourteen at $n=12$** […] *The separation narrows as $n$ grows, the
> residuals increasing so that the margin crosses below fourteen orders between $n=12$ and $n=16$*

> **AND THE DIFFERENCE IS LOAD-BEARING.** L22's closed form $V(t)$ needs $M\hat q=0$ to split $K$.
> *Mere orthogonality to the top eigenspace permits $M\hat q=\mu\hat q$ with $0<\mu<\lambda_{\max}$,
> and then $K=\hat q$ gives $a+t\mu>V(t)$*, **so the weaker sentence, read as written, destroys
> the derivation it was recorded to support.**

## What is typed here

* `annihilation_implies_orthogonality`, the implication that does hold: for a self-adjoint `M`,
  `M q = 0` forces `q ⊥ v` at every eigenvector `v` with nonzero eigenvalue. *So annihilation is
  the strictly stronger of the record's two forms.*
* `orthogonality_permits_nonzero_eigenvalue` and `configuration_witness`, the converse fails, and
  the failing configuration exists: a self-adjoint `M` with `M v = λ_max • v`, `M q = μ • q`,
  `0 < μ < λ_max` and `⟪q, v⟫ = 0`, where `M q ≠ 0`. `trust_region_value_exceeded` is the
  consequence the record draws (`a + tμ > a`) which is why the weaker sentence destroys the
  derivation.
* `separation_of_orders`, the measured separations: more than thirteen orders at every dimension,
  more than fourteen at `n = 12` and **not** at `n = 16`, with the residuals increasing in `n`.
  *These are the record's figures checked as arithmetic; they are not evidence that the residual is
  zero.*
* `t_star_closed_form`, `t_star_decimal`, `t* = ¾√(5/6) = √30/8`, and the bracket
  `0.6846531 < t* < 0.6846532`, so the record's `0.6846532` is the rounded value.
* `V_continuous_at_t_star`, the two branches of `V` agree at `t*`.
* `t_star_minimises_branch`, `√(5/6) ≤ 5/(16t) + 2t/3` for every `t > 0`, so the first branch is
  the smaller everywhere and `t*` is exactly where the hyperbola branch takes over.

Everything is proved; there is no `sorry`.

## What is NOT typed here

**The observation itself is not stated.** `M_{W₁} · Π_ker Q(W₁) = 0` needs `V_{1/3}`, the kernel
projection, `Q` on that eigenspace and the operator `M_{W₁}`, which the record's own Gate 2 notes
is *defined nowhere* in [findings/](../../../findings/) or
[conventions.md](../../../findings/conventions.md). None of it is nameable against
[WeylReal.lean](../Base/WeylReal.lean).

**The sharper true statement `Π₀(V_{1/3} ∘ V_{1/3}) ⊥ Π₀(V_{1/3} ∘ V_0)` is not stated**, for the
same reason: it is a subspace orthogonality between images of the Fox product, and the product `∘`
is not in the Lean layer at all.

**Nothing here is evidence that the residual is zero.** The claim rests on `40` random draws at
`n = 12` and fewer at `n = 14, 16`, with no error model; the arithmetic below records the
separation the record reports and the direction in which it narrows, and settles neither.

**`V(t)` is not proved to be the value of the trust-region problem.** What is typed is that the
two branches meet at `t*` and that the constant branch is the lower one; the identification of
either with a maximisation over `K` needs the objects above.
-/

namespace HamiltonsCubic.L102Statement

open RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-! ## Annihilation is strictly stronger than orthogonality -/

/-- **ANNIHILATION IMPLIES ORTHOGONALITY.** If `M` is self-adjoint, `M q = 0` and `M v = λ v` with
`λ ≠ 0`, then `q ⊥ v`. -/
theorem annihilation_implies_orthogonality {M : E →ₗ[ℝ] E} {q v : E} {lam : ℝ}
    (hsa : ∀ x y, ⟪M x, y⟫ = ⟪x, M y⟫)
    (hq : M q = 0) (hv : M v = lam • v) (hlam : lam ≠ 0) :
    ⟪q, v⟫ = 0 := by
  have h1 : ⟪M q, v⟫ = 0 := by rw [hq, inner_zero_left]
  have h2 : ⟪q, M v⟫ = lam * ⟪q, v⟫ := by rw [hv, real_inner_smul_right]
  rw [hsa q v, h2] at h1
  exact (mul_eq_zero.mp h1).resolve_left hlam

/-- **THE CONVERSE FAILS.** Orthogonality to the top eigenvector permits `M q = μ q` with `μ ≠ 0`,
and then `M q ≠ 0`. -/
theorem orthogonality_permits_nonzero_eigenvalue {M : E →ₗ[ℝ] E} {q v : E} {mu : ℝ}
    (hq : M q = mu • q) (hqne : q ≠ 0) (hmu : mu ≠ 0) (horth : ⟪q, v⟫ = 0) :
    ⟪q, v⟫ = 0 ∧ M q ≠ 0 := by
  refine ⟨horth, ?_⟩
  rw [hq]
  exact smul_ne_zero hmu hqne

/-- **THE CONSEQUENCE THE RECORD DRAWS.** With `K = q̂` the objective reads `a + tμ`, which exceeds
the constant branch `a` whenever `t, μ > 0`, so the derivation that needs `M q̂ = 0` does not
survive the weaker sentence. -/
theorem trust_region_value_exceeded {a t mu : ℝ} (ht : 0 < t) (hmu : 0 < mu) :
    a < a + t * mu := by nlinarith

/-! ## The failing configuration exists -/

/-- The rank-two self-adjoint operator `c_q ⟪q, ·⟫ q + c_v ⟪v, ·⟫ v`. -/
noncomputable def rankTwoOp (q v : E) (cq cv : ℝ) : E →ₗ[ℝ] E :=
  cq • ((innerSL ℝ q).smulRight q).toLinearMap + cv • ((innerSL ℝ v).smulRight v).toLinearMap

theorem rankTwoOp_apply (q v : E) (cq cv : ℝ) (x : E) :
    rankTwoOp q v cq cv x = (cq * ⟪q, x⟫) • q + (cv * ⟪v, x⟫) • v := by
  simp [rankTwoOp, mul_smul]

/-- **THE CONFIGURATION THE RECORD DESCRIBES EXISTS.** Given orthogonal nonzero `q` and `v` and any
`0 < μ < λ_max`, there is a self-adjoint `M` with `M v = λ_max • v`, `M q = μ • q` and
`⟪q, v⟫ = 0`, so `q` is orthogonal to the top eigenvector and is **not** annihilated. -/
theorem configuration_witness {q v : E} {mu lmax : ℝ}
    (hq : q ≠ 0) (hv : v ≠ 0) (horth : ⟪q, v⟫ = 0) (hmu : 0 < mu) (hlt : mu < lmax) :
    ∃ M : E →ₗ[ℝ] E, (∀ x y, ⟪M x, y⟫ = ⟪x, M y⟫) ∧ M q = mu • q ∧ M v = lmax • v ∧
      M q ≠ 0 ∧ ⟪q, v⟫ = 0 ∧ 0 < mu ∧ mu < lmax := by
  have hqq : ⟪q, q⟫ ≠ 0 := by
    simpa [real_inner_self_eq_norm_sq] using (fun h => hq (by simpa using h) : ¬ ‖q‖ = 0)
  have hvv : ⟪v, v⟫ ≠ 0 := by
    simpa [real_inner_self_eq_norm_sq] using (fun h => hv (by simpa using h) : ¬ ‖v‖ = 0)
  have hvq : ⟪v, q⟫ = 0 := by rw [real_inner_comm]; exact horth
  refine ⟨rankTwoOp q v (mu / ⟪q, q⟫) (lmax / ⟪v, v⟫), ?_, ?_, ?_, ?_, horth, hmu, hlt⟩
  · intro x y
    rw [rankTwoOp_apply, rankTwoOp_apply]
    rw [inner_add_left, real_inner_smul_left, real_inner_smul_left,
      inner_add_right, real_inner_smul_right, real_inner_smul_right]
    rw [real_inner_comm q x, real_inner_comm v x]
    ring
  · rw [rankTwoOp_apply, hvq]
    rw [div_mul_cancel₀ _ hqq]
    simp
  · rw [rankTwoOp_apply, horth]
    rw [div_mul_cancel₀ _ hvv]
    simp
  · rw [rankTwoOp_apply, hvq, div_mul_cancel₀ _ hqq]
    simpa using smul_ne_zero (ne_of_gt hmu) hq

/-! ## The measured separations -/

/-- **THE SEPARATION, AS ARITHMETIC.** Residuals `2.2`, `7.5`, `8.5 × 10⁻¹⁵` against a control of
`0.33`: more than fourteen orders at `n = 12`, more than thirteen at `n = 16` and **not** more than
fourteen there, and the residuals increase with `n`, so the margin narrows. -/
theorem separation_of_orders :
    ((22 : ℝ) / 10 ^ 16 * 10 ^ 14 < 33 / 100) ∧
      ((85 : ℝ) / 10 ^ 16 * 10 ^ 13 < 33 / 100) ∧
      ¬ ((85 : ℝ) / 10 ^ 16 * 10 ^ 14 < 33 / 100) ∧
      ((22 : ℝ) / 10 ^ 16 < 75 / 10 ^ 16 ∧ (75 : ℝ) / 10 ^ 16 < 85 / 10 ^ 16) := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

/-! ## The closed form `V(t)` -/

/-- **`t* = ¾√(5/6) = √30/8`.** -/
theorem t_star_closed_form : (3 / 4 : ℝ) * Real.sqrt (5 / 6) = Real.sqrt 30 / 8 := by
  have h : Real.sqrt (5 / 6) = Real.sqrt 30 / 6 := by
    rw [show (5 : ℝ) / 6 = (Real.sqrt 30 / 6) ^ 2 by
      rw [div_pow, Real.sq_sqrt (by norm_num : (30 : ℝ) ≥ 0)]; norm_num]
    exact Real.sqrt_sq (by positivity)
  rw [h]; ring

/-- **`t*` lies strictly between `0.6846531` and `0.6846532`**, so the record's `0.6846532` is the
rounded value rather than a bound the number attains. -/
theorem t_star_decimal :
    (6846531 : ℝ) / 10 ^ 7 < Real.sqrt 30 / 8 ∧ Real.sqrt 30 / 8 < 6846532 / 10 ^ 7 := by
  have h30 : Real.sqrt 30 ^ 2 = 30 := Real.sq_sqrt (by norm_num)
  have hpos : (0 : ℝ) < Real.sqrt 30 := Real.sqrt_pos.mpr (by norm_num)
  constructor
  · rw [lt_div_iff₀ (by norm_num : (0 : ℝ) < 8)]
    nlinarith [h30, hpos]
  · rw [div_lt_iff₀ (by norm_num : (0 : ℝ) < 8)]
    nlinarith [h30, hpos]

/-- **THE TWO BRANCHES OF `V` AGREE AT `t*`.** -/
theorem V_continuous_at_t_star :
    5 / (16 * (Real.sqrt 30 / 8)) + 2 * (Real.sqrt 30 / 8) / 3 = Real.sqrt (5 / 6) := by
  have h30 : Real.sqrt 30 ^ 2 = 30 := Real.sq_sqrt (by norm_num)
  have hpos : (0 : ℝ) < Real.sqrt 30 := Real.sqrt_pos.mpr (by norm_num)
  have h : Real.sqrt (5 / 6) = Real.sqrt 30 / 6 := by
    rw [show (5 : ℝ) / 6 = (Real.sqrt 30 / 6) ^ 2 by
      rw [div_pow, Real.sq_sqrt (by norm_num : (30 : ℝ) ≥ 0)]; norm_num]
    exact Real.sqrt_sq (by positivity)
  have hs : Real.sqrt 30 ≠ 0 := ne_of_gt hpos
  have key : 5 / (16 * (Real.sqrt 30 / 8)) + 2 * (Real.sqrt 30 / 8) / 3 - Real.sqrt 30 / 6
      = (30 - Real.sqrt 30 ^ 2) / (12 * Real.sqrt 30) := by
    field_simp
    ring
  rw [h, ← sub_eq_zero, key, h30]
  simp

/-- **THE CONSTANT BRANCH IS THE LOWER ONE EVERYWHERE**, `√(5/6) ≤ 5/(16t) + 2t/3` for `t > 0`,
with equality exactly at `t*`, so `t*` is where the hyperbola branch takes over. -/
theorem t_star_minimises_branch {t : ℝ} (ht : 0 < t) :
    Real.sqrt (5 / 6) ≤ 5 / (16 * t) + 2 * t / 3 := by
  have h30 : Real.sqrt 30 ^ 2 = 30 := Real.sq_sqrt (by norm_num)
  have hpos : (0 : ℝ) < Real.sqrt 30 := Real.sqrt_pos.mpr (by norm_num)
  have h : Real.sqrt (5 / 6) = Real.sqrt 30 / 6 := by
    rw [show (5 : ℝ) / 6 = (Real.sqrt 30 / 6) ^ 2 by
      rw [div_pow, Real.sq_sqrt (by norm_num : (30 : ℝ) ≥ 0)]; norm_num]
    exact Real.sqrt_sq (by positivity)
  rw [h, ← sub_nonneg]
  have hexp : 5 / (16 * t) + 2 * t / 3 - Real.sqrt 30 / 6
      = (32 * t ^ 2 - 8 * t * Real.sqrt 30 + 15) / (48 * t) := by
    field_simp
    ring
  have hnum : 32 * t ^ 2 - 8 * t * Real.sqrt 30 + 15
      = 32 * (t - Real.sqrt 30 / 8) ^ 2 := by
    linear_combination (-1 / 2 : ℝ) * h30
  rw [hexp, hnum]
  positivity

end HamiltonsCubic.L102Statement
