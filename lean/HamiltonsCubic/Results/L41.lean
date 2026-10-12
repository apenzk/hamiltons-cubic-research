import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset

/-!
# L41, the `λ`-weighted identity, and the bound it gives

[target.md](../../../findings/target.md)'s Lemma L41. The identity `Σ_γ λ_γ g_γ = -4θ` and
the total `Σ_γ g_γ = 4(n-1)` are geometry and stay imported. **What is derived here is the
step from those two to the bound**, which the block states without giving.

**The `G₀` refinement has one source.** The block's bound subtracts both `Δ` and
`G₀ = Σ_{γ ∈ ker W} g_γ`, and the kernel term earns its place for exactly one reason: on the
kernel `λ_γ = 0`, so those indices contribute nothing to the weighted sum while still
carrying mass in the total. Dropping them from the negative side is what tightens
`4(n-1) - Δ` to `4(n-1) - Δ - G₀`.

**The two masses combine.** `Δ` (the strictly positive eigenvalues) and `G₀` (the kernel) are
together the mass on `{λ ≥ 0}`, and that is the only way they enter, so the bound is one
statement about the non-negative part, not two corrections.
-/

namespace HamiltonsCubic.WeightedBound

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {lam g : ι → ℝ} {θ lamMin total : ℝ}

/-- The mass carried by the non-negative eigenvalues, the record's `Δ + G₀`. -/
noncomputable def nonNegMass (lam g : ι → ℝ) : ℝ :=
  ∑ i ∈ univ.filter (fun i => ¬ (lam i < 0)), g i

/-- **The non-negative part contributes non-negatively to the weighted sum**, which is what
lets it be dropped. -/
theorem nonneg_part (hg : ∀ i, 0 ≤ g i) (hlam : ∀ i, ¬ (lam i < 0) → 0 ≤ lam i) :
    0 ≤ ∑ i ∈ univ.filter (fun i => ¬ (lam i < 0)), lam i * g i :=
  Finset.sum_nonneg fun i hi => by
    simp only [Finset.mem_filter] at hi
    exact mul_nonneg (hlam i hi.2) (hg i)

/-- **The negative part is bounded below by `λ_min` times its mass.** -/
theorem neg_part_bound (hg : ∀ i, 0 ≤ g i) (hmin : ∀ i, lamMin ≤ lam i) :
    lamMin * (∑ i ∈ univ.filter (fun i => lam i < 0), g i)
      ≤ ∑ i ∈ univ.filter (fun i => lam i < 0), lam i * g i := by
  rw [Finset.mul_sum]
  exact Finset.sum_le_sum fun i _ => mul_le_mul_of_nonneg_right (hmin i) (hg i)

/-- The two masses partition the total. -/
theorem mass_split (htot : ∑ i, g i = total) :
    (∑ i ∈ univ.filter (fun i => lam i < 0), g i) + nonNegMass lam g = total := by
  unfold nonNegMass
  rw [Finset.sum_filter_add_sum_filter_not univ (fun i => lam i < 0) g]
  exact htot

/-- **The bound.** From `Σ λ g = -4θ`, `Σ g = 4(n-1)` and `g ≥ 0`,
`4θ ≤ |λ_min| (4(n-1) - Δ - G₀)`. The kernel indices drop out of the weighted sum because
`λ = 0` there, which is the whole of the `G₀` refinement. -/
theorem weighted_bound (hg : ∀ i, 0 ≤ g i) (hmin : ∀ i, lamMin ≤ lam i)
    (hlam : ∀ i, ¬ (lam i < 0) → 0 ≤ lam i)
    (hid : ∑ i, lam i * g i = -4 * θ) (htot : ∑ i, g i = total) :
    4 * θ ≤ (-lamMin) * (total - nonNegMass lam g) := by
  have hsplit : (∑ i ∈ univ.filter (fun i => lam i < 0), lam i * g i)
      + ∑ i ∈ univ.filter (fun i => ¬ (lam i < 0)), lam i * g i = -4 * θ := by
    rw [Finset.sum_filter_add_sum_filter_not univ (fun i => lam i < 0) (fun i => lam i * g i)]
    exact hid
  have hpos := nonneg_part hg hlam
  have hneg := neg_part_bound (lamMin := lamMin) hg hmin
  have hmass := mass_split (lam := lam) (g := g) htot
  have hkey : lamMin * (total - nonNegMass lam g) ≤ -4 * θ := by
    have : total - nonNegMass lam g = ∑ i ∈ univ.filter (fun i => lam i < 0), g i := by
      linarith [hmass]
    rw [this]
    linarith [hneg, hpos, hsplit]
  linarith [hkey]

/-- **Equality needs `g` supported on the `λ_min` eigenspace**, in the direction the block
asserts: if the non-negative part carries no mass and every negative index sits at `λ_min`,
both inequalities above are equalities. -/
theorem equality_case (hg : ∀ i, 0 ≤ g i)
    (hsupp : ∀ i ∈ univ.filter (fun i => ¬ (lam i < 0)), g i = 0)
    (hat : ∀ i ∈ univ.filter (fun i => lam i < 0), lam i = lamMin)
    (hid : ∑ i, lam i * g i = -4 * θ) (htot : ∑ i, g i = total) :
    4 * θ = (-lamMin) * total := by
  have hzero : ∑ i ∈ univ.filter (fun i => ¬ (lam i < 0)), lam i * g i = 0 :=
    Finset.sum_eq_zero fun i hi => by rw [hsupp i hi]; ring
  have hgz : nonNegMass lam g = 0 := Finset.sum_eq_zero hsupp
  have hmass := mass_split (lam := lam) (g := g) htot
  have hneg : ∑ i ∈ univ.filter (fun i => lam i < 0), lam i * g i
      = lamMin * ∑ i ∈ univ.filter (fun i => lam i < 0), g i := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun i hi => by rw [hat i hi]
  have hsplit : (∑ i ∈ univ.filter (fun i => lam i < 0), lam i * g i)
      + ∑ i ∈ univ.filter (fun i => ¬ (lam i < 0)), lam i * g i = -4 * θ := by
    rw [Finset.sum_filter_add_sum_filter_not univ (fun i => lam i < 0) (fun i => lam i * g i)]
    exact hid
  rw [hgz] at hmass
  have hSneg : ∑ i ∈ univ.filter (fun i => lam i < 0), g i = total := by linarith [hmass]
  rw [hneg, hSneg] at hsplit
  linarith [hsplit, hzero]

end HamiltonsCubic.WeightedBound
