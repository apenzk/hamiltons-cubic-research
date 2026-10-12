import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L115, the free clause: `θ ≥ max_α λ_α` at a maximiser, strictly

## The record's statement, as audited in [ROUND_L115](../../../verification/ROUND_L115.md)

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L115, for a unit
$W\in\mathcal W_n$, $n\ge4$:

> 1. At a global maximiser, $\theta-\lambda_\alpha\ge\sqrt{3/2}-1$ for every $\alpha$.
> 2. At a coordinate-diagonal global maximiser, with $M$ formed in the coordinate frame,
>    $\lambda_{\max}(M)=\theta$, and at the unit Weyl tensor of $S^m\times S^m$, $m\ge2$, in its
>    coordinate frame, with no maximality assumed.

$\lambda_{\max}(M)=\theta$ at every global maximiser is recorded there as open, since it needs a cap
on the part of $\mathcal D$ orthogonal to $\mathcal W_n$, and $M$ depends on the eigenbasis when
eigenvalues repeat.

## What this file states

**The second clause, which the record grades free and strict, is stated and PROVED in full**,
including its strictness and the record's margin `√(3/2) - 1 ≥ 0.2247`. It is proved twice, by the
two routes the record distinguishes:

* `theta_ge_diag`, the by-product route: a diagonal entry of a symmetric matrix never exceeds its
  top Rayleigh value, so `diag M = λ` together with `λ_max(M) = θ` gives `θ ≥ max_α λ_α`. The
  equality `λ_max(M) = θ` is a **hypothesis** here, and is the clause the record grades a `GAP`.
* `theta_gt_lambda`, the free route, which spends neither `M` nor Lemma L24: `max_α λ_α ≤ ‖λ‖ = 1`
  and `1 < √(3/2) ≤ θ`.

`hθ` in the free route is the record's separately established `θ ≥ √(3/2)` at a maximiser, which
holds at every `n ≥ 4` because padded `W_{ℂP²}` competes; it is an input from elsewhere on the
record and is **not** this clause's conclusion in disguise.

The last section proves the record's `C₅` remark as the arithmetic it is: `0.809017 > 1/√2`, which
is why the top there must lie in the Weyl part.

## What is NOT typed here

**The first clause, `λ_max(M) = θ`, is absent, and its `M` with it.** `M` is defined by
`⟨x, Mx⟩ = ⟨L_W X, X⟩` for `X` ranging over the eigenframe-diagonal algebra `𝒟`, which needs the
Fox product `∘` and the operator `L_W`; `HamiltonsCubic.Base.WeylReal` carries neither, so `M` is
unnameable and `theta_ge_diag` takes an abstract symmetric matrix instead. **The record itself
grades that clause a `GAP`**, repaired only on the coordinate-diagonal locus and at `Sᵐ × Sᵐ`,
`m ≥ 4`, with the residual obligation a cap on `λ_max(L_W|_{𝒲ₙ^⊥})` that is nowhere on the record
so nothing here should be read as supplying it.

**Also absent**: the repair's own ingredients, that coordinate-diagonal operators are hollow
symmetric, Weyl iff `S𝟙 = 0`, with non-Weyl complement `{S_ij = u_i + u_j}` and Rayleigh quotient
at most `½λ_max(K)`, which again need `L_W`. And the block's "strictly stronger than Conjecture A"
sentence, which the record refutes three ways.
-/

namespace HamiltonsCubic.L115Statement

open Finset Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`t` is the top Rayleigh value of the symmetric matrix `A`.** -/
def IsTopRayleigh (A : Matrix ι ι ℝ) (t : ℝ) : Prop :=
  ∀ x : ι → ℝ, x ⬝ᵥ (A *ᵥ x) ≤ t * (x ⬝ᵥ x)

/-! ## The by-product route -/

/-- The coordinate vector at `α`. -/
def evec (α : ι) : ι → ℝ := fun i => if i = α then 1 else 0

/-- A diagonal entry is a Rayleigh value, at the coordinate vector. -/
theorem diag_is_rayleigh (A : Matrix ι ι ℝ) (α : ι) :
    evec α ⬝ᵥ (A *ᵥ evec α) = A α α ∧ evec α ⬝ᵥ evec α = 1 := by
  have hrow : ∀ i : ι, (∑ j, A i j * evec α j) = A i α := by
    intro i
    simp [evec, Finset.sum_ite_eq']
  constructor
  · show ∑ i, evec α i * (∑ j, A i j * evec α j) = A α α
    simp only [hrow]
    simp [evec, Finset.sum_ite_eq']
  · show ∑ i, evec α i * evec α i = 1
    simp [evec, Finset.sum_ite_eq']

/-- **The by-product**: with `diag M = λ` and `λ_max(M) = θ`, every `λ_α` is at most `θ`.

*`hlam` is the clause the record grades a `GAP`. It is a hypothesis here, and the conclusion is
only what it implies.* -/
theorem theta_ge_diag (A : Matrix ι ι ℝ) (lam : ι → ℝ) (θ : ℝ)
    (hdiag : ∀ α, A α α = lam α) (hlam : IsTopRayleigh A θ) :
    ∀ α, lam α ≤ θ := by
  intro α
  obtain ⟨h1, h2⟩ := diag_is_rayleigh A α
  have h := hlam (evec α)
  rw [h1, h2, hdiag α] at h
  linarith

/-! ## The free route: neither `M` nor Lemma L24 -/

/-- **Every eigenvalue is at most the norm of the spectrum**, `max_α λ_α ≤ ‖λ‖`. -/
theorem le_norm_of_sum_sq (lam : ι → ℝ) (hnorm : ∑ a, lam a ^ 2 = 1) (α : ι) :
    lam α ≤ 1 := by
  have hle : lam α ^ 2 ≤ ∑ a, lam a ^ 2 :=
    Finset.single_le_sum (f := fun a => lam a ^ 2) (fun a _ => sq_nonneg _) (Finset.mem_univ α)
  rw [hnorm] at hle
  nlinarith [hle, sq_nonneg (lam α - 1), sq_nonneg (lam α + 1)]

/-- **`1 < √(3/2)`**, the gap that makes the clause strict. -/
theorem one_lt_sqrt_three_halves : (1 : ℝ) < Real.sqrt (3 / 2) := by
  rw [show (1 : ℝ) = Real.sqrt 1 by simp]
  exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)

/-- **The record's margin: `√(3/2) - 1 ≥ 0.2247`.** -/
theorem margin : (0.2247 : ℝ) ≤ Real.sqrt (3 / 2) - 1 := by
  have h : (1.2247 : ℝ) ≤ Real.sqrt (3 / 2) := by
    rw [show (1.2247 : ℝ) = Real.sqrt (1.2247 ^ 2) from (Real.sqrt_sq (by norm_num)).symm]
    exact Real.sqrt_le_sqrt (by norm_num)
  linarith

/-- **L115's second clause, free and strict.** At `‖λ‖ = 1` and `θ ≥ √(3/2)`, the record's
separately established lower bound at a maximiser, from padded `W_{ℂP²}` competing at every
`n ≥ 4`, every eigenvalue is *strictly* below `θ`, with equality at no maximiser. -/
theorem theta_gt_lambda (lam : ι → ℝ) (θ : ℝ)
    (hnorm : ∑ a, lam a ^ 2 = 1) (hθ : Real.sqrt (3 / 2) ≤ θ) :
    ∀ α, lam α < θ := by
  intro α
  have h1 := le_norm_of_sum_sq lam hnorm α
  have h2 := one_lt_sqrt_three_halves
  linarith

/-- **And the gap is at least the record's margin.** -/
theorem theta_sub_lambda_ge (lam : ι → ℝ) (θ : ℝ)
    (hnorm : ∑ a, lam a ^ 2 = 1) (hθ : Real.sqrt (3 / 2) ≤ θ) :
    ∀ α, (0.2247 : ℝ) ≤ θ - lam α := by
  intro α
  have h1 := le_norm_of_sum_sq lam hnorm α
  have h2 := margin
  linarith

/-! ## The `C₅` blow-up remark, as arithmetic

*The record's `0.809017` exceeds `1/√2`, which is why the top there must lie in the Weyl part,
the non-Weyl complement's Rayleigh quotient being capped by `1/√2`.* -/

theorem c5_exceeds_nonWeyl_cap : 1 / Real.sqrt 2 < (0.809017 : ℝ) := by
  have h2 : (1.4142 : ℝ) ≤ Real.sqrt 2 := by
    rw [show (1.4142 : ℝ) = Real.sqrt (1.4142 ^ 2) from (Real.sqrt_sq (by norm_num)).symm]
    exact Real.sqrt_le_sqrt (by norm_num)
  have hpos : (0 : ℝ) < Real.sqrt 2 := Real.sqrt_pos.2 (by norm_num)
  rw [div_lt_iff₀ hpos]
  nlinarith [h2]

/-! ## A witness, so the hypotheses are not empty

*Two eigenvalues `(1/√2, -1/√2)` with `θ = √(3/2)`: `‖λ‖ = 1`, and the strict clause holds.* -/

noncomputable def witLam : Fin 2 → ℝ := ![1 / Real.sqrt 2, -(1 / Real.sqrt 2)]

theorem wit_norm : ∑ a, witLam a ^ 2 = 1 := by
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have h2' : Real.sqrt 2 ≠ 0 := ne_of_gt (Real.sqrt_pos.2 (by norm_num))
  simp only [witLam, Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one]
  field_simp
  linarith [h2]

example : ∀ α, witLam α < Real.sqrt (3 / 2) :=
  theta_gt_lambda witLam (Real.sqrt (3 / 2)) wit_norm le_rfl

end HamiltonsCubic.L115Statement
