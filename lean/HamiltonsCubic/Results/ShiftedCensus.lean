import HamiltonsCubic.Base.WeylReal

/-!
# The shifted census has a barycentre, and the shift cancels out of it

**The situation.** A Weyl tensor whose spectrum is one value `μ` of multiplicity `N - 3` together
with three others satisfies, for `c α = λ α - μ` over the three exceptional eigenvectors,

`∑ c α • Φ(v α) = (μ(n-1)·Id, 0)` and `∑ c α = -N·μ`,

the first because `∑ v α v αᵀ = (n-1)·Id` over any orthonormal basis of `Λ²`, the second because the
whole spectrum is trace-free.

**What this file proves is the step that makes the statement usable**: dividing by the weight sum
turns the display into an AFFINE combination, and `μ` cancels. The target becomes `(-(2/n)·Id, 0)`,
which carries no reference to the multiplicity or to the value `μ`.

*The check that the constant is right is the trace: every `Φ(ω)` at a unit `ω` has first component
of trace `-2`, so every affine combination of them does, and `tr(-(2/n)·Id) = -2`.* **So the trace
is uninformative here**, which is the same fact as the Ricci display's trace being exactly
trace-freeness.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

open Finset Matrix

/-- **The shifted census is an affine condition on four points, with `μ` cancelled.**

*`X α` stands for `Φ(v α)`, `Y` for the pair `(Id, 0)`, and `n (n-1) / 2` for `dim Λ²ℝⁿ`.
*The index type is `Fin 3`: attaining the chain's ceiling fills the spectrum with a top eigenvalue,
`N - 3` equal positives and two negatives, so a zero eigenvalue is EXCLUDED rather than present.** Given the
weight sum `-N μ` and the Ricci display `μ(n-1) • Y`, the barycentric combination of the four points
is `-(2/n) • Y`. **Both `μ` and the multiplicity are gone**, so the target of the three-point census
is the same object at every configuration the chain admits. -/
theorem barycentre_of_shifted_census
    {V : Type*} [AddCommGroup V] [Module ℝ V]
    (n μ : ℝ) (hn : n ≠ 0) (hn1 : n ≠ 1) (hμ : μ ≠ 0)
    (c : Fin 3 → ℝ) (X : Fin 3 → V) (Y : V)
    (hsum : ∑ α, c α = -(n * (n - 1) / 2) * μ)
    (hricci : ∑ α, c α • X α = (μ * (n - 1)) • Y) :
    ∑ α, (c α / (-(n * (n - 1) / 2) * μ)) • X α = (-(2 / n)) • Y := by
  have h1 : n - 1 ≠ 0 := sub_ne_zero.mpr hn1
  have hscalar : (-(n * (n - 1) / 2) * μ)⁻¹ * (μ * (n - 1)) = -(2 / n) := by
    field_simp
  have hsmul : ∀ α : Fin 3, (c α / (-(n * (n - 1) / 2) * μ)) • X α
      = (-(n * (n - 1) / 2) * μ)⁻¹ • (c α • X α) := by
    intro α
    rw [smul_smul, div_eq_inv_mul]
  rw [Finset.sum_congr rfl (fun α _ => hsmul α), ← Finset.smul_sum, hricci, smul_smul,
    hscalar]

/-- **The census's `S²` half is an isotropy condition, holding at every vector.**

*Pairing `∑ w α • (v α)² = -(2/n)·Id` against `x` and using `⟨v²x, x⟩ = -|vx|²` at a skew `v` turns
the matrix identity into a statement about the three quadratic forms `|v α x|²`.* **And `2/n` is
exactly the spherical average of `|vx|²` at a unit bivector**, so the weighted combination is its
own average, uniformly in `x` rather than on average. -/
theorem census_isotropy {ι : Type*} [Fintype ι] [DecidableEq ι]
    (w : Fin 3 → ℝ) (v : Fin 3 → Matrix ι ι ℝ) (r : ℝ)
    (hR : ∑ α, w α • (v α * (v α)ᵀ) = r • (1 : Matrix ι ι ℝ)) (x : ι → ℝ) :
    ∑ α, w α * (((v α)ᵀ *ᵥ x) ⬝ᵥ ((v α)ᵀ *ᵥ x)) = r * (x ⬝ᵥ x) := by
  have h := congrArg (fun M : Matrix ι ι ℝ => x ⬝ᵥ (M *ᵥ x)) hR
  simp only [Matrix.sum_mulVec, Matrix.smul_mulVec, dotProduct_sum, dotProduct_smul,
    Matrix.one_mulVec, smul_eq_mul] at h
  rw [← h]
  refine Finset.sum_congr rfl fun α _ => ?_
  congr 1
  simp only [dotProduct, Matrix.mulVec, Matrix.mul_apply, Matrix.transpose_apply,
    Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun i _ => by ring

end HamiltonsCubic.RealLayer
