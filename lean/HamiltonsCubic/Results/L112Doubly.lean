import Mathlib
import HamiltonsCubic.Results.DoublyStochastic

set_option linter.style.longLine false

/-!
# L112: `λ` is a `-1/(n-2)`-eigenvector of a symmetric hollow doubly stochastic matrix, and L73 is its shadow

[findings/bounds.md](../../../findings/bounds.md), Lemma L112. With `T_{abc} = c_{abc}²` totally symmetric (so
nonnegative and zero on a repeated index) and the per-index relations of the same file,
*(A)* `Σ_{βγ} T_{kβγ} = 2(n-2)` and *(B)* `Σ_{βγ} λ_β T_{kβγ} = -2λ_k`, set `S_{ab} = Σ_c T_{abc}`:

* **`S_symm`**, **`S_hollow`**, **`S_nonneg`**, **`R_doublyStochastic`**, **`R_eigen`**: `S` is symmetric, hollow and
  nonnegative, `R = S / (2(n-2))` is doubly stochastic and `R λ = -λ/(n-2)`. These restate
  [L112Statement.lean](L112Statement.lean)'s `Smat_*`, `hatS_doublyStochastic` and `hatS_eigenvector` in
  [DoublyStochastic.lean](DoublyStochastic.lean)'s `IsDoublyStochastic` form, which `diagonal_le_spectrum` takes;
* **`shadow_convex`**, the new theorem here: for every convex `g`, `Σ_k g(-λ_k/(n-2)) ≤ Σ_k g(λ_k)`, the majorisation
  `-λ/(n-2) ≺ λ` in its convex form;
* **`L73_shadow`**: each `-λ_k/(n-2)` lies between `min λ` and `max λ`, which is
  [Lemma L73](../../../findings/bounds.md)'s `-(n-2)λ_max ≤ λ_k ≤ (n-2)|λ_min|`, the one-index case, repeating
  [L73Statement.lean](L73Statement.lean)'s `two_sided` and L112Statement's `L73_one_index_shadow`.

The relations enter as hypotheses: (A) and (B) are the record's per-index relations, from Böhm–Wilking's Lemma 2.1.
-/

namespace HamiltonsCubic.L112Doubly

open Finset HamiltonsCubic.DoublyStochastic

variable {ι : Type*} [Fintype ι]

/-- `S_{ab} = Σ_c T_{abc}`. -/
def S (T : ι → ι → ι → ℝ) (a b : ι) : ℝ := ∑ c, T a b c

section

variable (T : ι → ι → ι → ℝ)

theorem S_symm (hT : ∀ a b c, T a b c = T b a c) (a b : ι) : S T a b = S T b a := by
  unfold S; exact Finset.sum_congr rfl fun c _ => hT a b c

theorem S_hollow (h0 : ∀ a c, T a a c = 0) (a : ι) : S T a a = 0 := by
  unfold S; simp [h0]

theorem S_nonneg (hT0 : ∀ a b c, 0 ≤ T a b c) (a b : ι) : 0 ≤ S T a b :=
  Finset.sum_nonneg fun c _ => hT0 a b c

/-- `R = S / (2(n-2))`. -/
noncomputable def R (n : ℝ) (a b : ι) : ℝ := S T a b / (2 * (n - 2))

theorem R_doublyStochastic (n : ℝ) (hn : 2 < n) (hT : ∀ a b c, T a b c = T b a c)
    (hT0 : ∀ a b c, 0 ≤ T a b c) (hA : ∀ k, ∑ β, ∑ γ, T k β γ = 2 * (n - 2)) :
    IsDoublyStochastic (R T n) := by
  have hpos : 0 < 2 * (n - 2) := by linarith
  have hrow : ∀ i, ∑ j, R T n i j = 1 := fun i => by
    unfold R S; rw [← Finset.sum_div, hA i, div_self hpos.ne']
  refine ⟨fun i j => div_nonneg (S_nonneg T hT0 i j) hpos.le, hrow, fun j => ?_⟩
  rw [← hrow j]
  exact Finset.sum_congr rfl fun i _ => by unfold R; rw [S_symm T hT]

theorem R_eigen (n : ℝ) (hn : 2 < n) (lam : ι → ℝ) (hB : ∀ k, ∑ β, ∑ γ, lam β * T k β γ = -2 * lam k) (k : ι) :
    ∑ β, R T n k β • lam β = -lam k / (n - 2) := by
  have hne : n - 2 ≠ 0 := by linarith
  have : ∑ β, R T n k β • lam β = (∑ β, ∑ γ, lam β * T k β γ) / (2 * (n - 2)) := by
    unfold R S
    rw [Finset.sum_div]
    refine Finset.sum_congr rfl fun β _ => ?_
    rw [smul_eq_mul, ← Finset.mul_sum]; ring
  rw [this, hB k]; field_simp

variable [DecidableEq ι]

/-- **`-λ/(n-2) ≺ λ`, in its convex form.** -/
theorem shadow_convex (n : ℝ) (hn : 2 < n) (hT : ∀ a b c, T a b c = T b a c)
    (hT0 : ∀ a b c, 0 ≤ T a b c) (hA : ∀ k, ∑ β, ∑ γ, T k β γ = 2 * (n - 2))
    (lam : ι → ℝ) (hB : ∀ k, ∑ β, ∑ γ, lam β * T k β γ = -2 * lam k) {g : ℝ → ℝ} (hg : ConvexOn ℝ Set.univ g) :
    ∑ k, g (-lam k / (n - 2)) ≤ ∑ k, g (lam k) := by
  have h := diagonal_le_spectrum (R_doublyStochastic T n hn hT hT0 hA) hg lam
  simpa only [R_eigen T n hn lam hB] using h

omit [DecidableEq ι] in
/-- **L73 as the one-index shadow**: `-λ_k/(n-2)` is a convex combination of the spectrum, so it lies between `λ_min`
and `λ_max`. -/
theorem L73_shadow (n : ℝ) (hn : 2 < n) (hT : ∀ a b c, T a b c = T b a c)
    (hT0 : ∀ a b c, 0 ≤ T a b c) (hA : ∀ k, ∑ β, ∑ γ, T k β γ = 2 * (n - 2))
    (lam : ι → ℝ) (hB : ∀ k, ∑ β, ∑ γ, lam β * T k β γ = -2 * lam k) (lmin lmax : ℝ)
    (hmin : ∀ j, lmin ≤ lam j) (hmax : ∀ j, lam j ≤ lmax) (k : ι) :
    -((n - 2) * lmax) ≤ lam k ∧ lam k ≤ (n - 2) * (-lmin) := by
  have hP := R_doublyStochastic T n hn hT hT0 hA
  have he := R_eigen T n hn lam hB k
  have hpos : 0 < n - 2 := by linarith
  have hup : ∑ β, R T n k β • lam β ≤ lmax := by
    calc ∑ β, R T n k β • lam β ≤ ∑ β, R T n k β • lmax :=
          Finset.sum_le_sum fun β _ => smul_le_smul_of_nonneg_left (hmax β) (hP.nonneg k β)
      _ = lmax := by rw [← Finset.sum_smul, hP.rows k, one_smul]
  have hlo : lmin ≤ ∑ β, R T n k β • lam β := by
    calc lmin = ∑ β, R T n k β • lmin := by rw [← Finset.sum_smul, hP.rows k, one_smul]
      _ ≤ ∑ β, R T n k β • lam β :=
          Finset.sum_le_sum fun β _ => smul_le_smul_of_nonneg_left (hmin β) (hP.nonneg k β)
  rw [he] at hup hlo
  rw [div_le_iff₀ hpos] at hup
  rw [le_div_iff₀ hpos] at hlo
  constructor <;> nlinarith

end

end HamiltonsCubic.L112Doubly
