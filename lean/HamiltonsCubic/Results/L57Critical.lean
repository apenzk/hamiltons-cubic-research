import HamiltonsCubic.Results.L223Statement
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false

/-!
# L57 at a critical point: `λ ≤ √(2(n−1)(n−2))/n` on the diagonal locus

[findings/problem.md](../../../findings/problem.md), Lemma L57, the diagonal theorem. Its three steps,
at a unit vertex matrix `S ∈ 𝒟ₙ` (`IsWeight`, `∑_{a,b} s_ab² = 2`) satisfying the criticality equation
`s_ab² + (S²)_ab = λ s_ab` off the diagonal, with `μ` a positive eigenvalue of `S` and `v` a unit
eigenvector:

- `sum_v_zero`: `∑ v = 0`, since `S𝟙 = 0`;
- `pairing`: **`λμ = μ² − T`**, `T = ½ ∑ s_ab² (v_a − v_b)²`, the criticality equation paired with
  `v ⊗ v`;
- `step1`: **`μ² ≤ n T`** by Cauchy–Schwarz with `∑ s_ab (v_a − v_b)² = −2μ` and
  `∑ (v_a − v_b)² = 2n`, so `λ ≤ (n−1)μ/n`, the record's Dirichlet inequality;
- `step23`: **`μ² ≤ 2(n−2)/(n−1)`**, pairing `S` with L223's projection
  `Z_ab = v_a v_b + (v_a² + v_b²)/(n−2) − 1/((n−1)(n−2))`, whose off-diagonal rows sum to zero, then
  `Z_norm_sq` and the fourth-moment bound `∑ v⁴ ≥ 1/n`;
- `L57_critical`: **`λ ≤ √(2(n−1)(n−2))/n`**, which is `Θₙ = θ₀(n)` at even `n`, at every `n ≥ 4`;
- `diagP_eq_lam` and `L57_critical_P`: at a unit critical weight `P(diag S) = diagP S = λ`
  ([SharpDiag.lean](../Base/SharpDiag.lean)'s `diagCubicFormula`), so **`P(diag S) ≤ √(2(n−1)(n−2))/n`
  at every critical point of the diagonal locus**.

**The bridge to every diagonal `W`** is [L57Diagonal.lean](L57Diagonal.lean)'s `L57_diagonal`. **Not
typed**: the sharper `Θₙ` at odd `n` and the equality case.

The top eigenvector is supplied by Mathlib's spectral theorem in `exists_pos_eigen`.
-/

namespace HamiltonsCubic.L57Critical

open Finset Matrix HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [DecidableEq ι] in
/-- Cauchy–Schwarz over pairs. -/
theorem cs_pairs (f g : ι → ι → ℝ) :
    (∑ a, ∑ b, f a b * g a b) ^ 2 ≤ (∑ a, ∑ b, f a b ^ 2) * (∑ a, ∑ b, g a b ^ 2) := by
  have h := Finset.sum_mul_sq_le_sq_mul_sq (Finset.univ : Finset (ι × ι))
    (fun p => f p.1 p.2) (fun p => g p.1 p.2)
  simpa only [Fintype.sum_prod_type] using h

section core

variable (S : Matrix ι ι ℝ) (hS : IsWeight S) (v : ι → ℝ) (μ : ℝ)
  (hv : S *ᵥ v = μ • v)
include hS hv

/-- **`∑ v = 0`** at a nonzero eigenvalue, the rows of `S` summing to zero. -/
theorem sum_v_zero (hμ : μ ≠ 0) : ∑ a, v a = 0 := by
  have h : ∑ a, (S *ᵥ v) a = μ * ∑ a, v a := by
    rw [hv]; simp [Finset.mul_sum]
  have h0 : ∑ a, (S *ᵥ v) a = 0 := by
    simp only [Matrix.mulVec, dotProduct]
    rw [Finset.sum_comm]
    refine Finset.sum_eq_zero fun b _ => ?_
    rw [← Finset.sum_mul]
    have : ∑ a, S a b = 0 := by
      simp only [hS.symm _ b]; exact hS.rowSum b
    rw [this, zero_mul]
  rw [h0] at h
  exact (mul_eq_zero.mp h.symm).resolve_left hμ

/-- `vᵀ S v = μ` for a unit eigenvector. -/
theorem quad_eq (h2 : ∑ a, v a ^ 2 = 1) : ∑ a, ∑ b, S a b * v a * v b = μ := by
  have : ∀ a, ∑ b, S a b * v a * v b = v a * (S *ᵥ v) a := fun a => by
    simp only [Matrix.mulVec, dotProduct, Finset.mul_sum]
    exact Finset.sum_congr rfl fun b _ => by ring
  simp only [this, hv, Pi.smul_apply, smul_eq_mul]
  have e : ∀ a, v a * (μ * v a) = μ * v a ^ 2 := fun a => by ring
  simp only [e, ← Finset.mul_sum, h2, mul_one]

/-- **The pairing**: `λμ = μ² − ½ ∑ s_ab² (v_a − v_b)²`. -/
theorem pairing (lam : ℝ) (h2 : ∑ a, v a ^ 2 = 1)
    (hcrit : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b) :
    lam * μ = μ ^ 2 - (1 / 2) * ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2 := by
  have hq := quad_eq S hS v μ hv h2
  -- `vᵀ S² v = μ²`
  have hSS : ∑ a, ∑ b, (S * S) a b * v a * v b = μ ^ 2 := by
    have e : ∀ a, ∑ b, (S * S) a b * v a * v b = v a * ((S * S) *ᵥ v) a := fun a => by
      simp only [Matrix.mulVec, dotProduct, Finset.mul_sum]
      exact Finset.sum_congr rfl fun b _ => by ring
    simp only [e, ← Matrix.mulVec_mulVec, hv, Matrix.mulVec_smul, Pi.smul_apply, smul_eq_mul]
    have e2 : ∀ a, v a * (μ * (μ * v a)) = μ ^ 2 * v a ^ 2 := fun a => by ring
    simp only [e2, ← Finset.mul_sum, h2, mul_one]
  -- the criticality equation summed against `v ⊗ v`, the diagonal carrying `(S²)_aa v_a²`
  have hsum : ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b - lam * S a b) * v a * v b
      = ∑ a, (S * S) a a * v a ^ 2 := by
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.sum_eq_single a]
    · rw [hS.hollow a]; ring
    · intro b _ hb
      rw [hcrit a b (Ne.symm hb)]; ring
    · intro h; exact absurd (Finset.mem_univ a) h
  have hdiag : ∀ a, (S * S) a a = ∑ c, S a c ^ 2 := fun a => by
    simp only [Matrix.mul_apply, sq, hS.symm _ a]
  have hsplit : ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b - lam * S a b) * v a * v b
      = ∑ a, ∑ b, S a b ^ 2 * v a * v b + μ ^ 2 - lam * μ := by
    rw [← hSS, ← hq]
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  have hT : (1 / 2) * ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2
      = ∑ a, (∑ c, S a c ^ 2) * v a ^ 2 - ∑ a, ∑ b, S a b ^ 2 * v a * v b := by
    have e : ∀ a b, S a b ^ 2 * (v a - v b) ^ 2
        = S a b ^ 2 * v a ^ 2 + S b a ^ 2 * v b ^ 2 - 2 * (S a b ^ 2 * v a * v b) := by
      intro a b; rw [hS.symm b a]; ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
    rw [Finset.sum_comm (f := fun a b => S b a ^ 2 * v b ^ 2)]
    simp only [← Finset.sum_mul]
    ring
  have key := hsum
  rw [hsplit] at key
  have : ∑ a, (S * S) a a * v a ^ 2 = ∑ a, (∑ c, S a c ^ 2) * v a ^ 2 := by simp only [hdiag]
  rw [this] at key
  linarith

/-- **Step 1**: `μ² ≤ n T`, the record's Dirichlet inequality before dividing by `μ`. -/
theorem step1 (h2 : ∑ a, v a ^ 2 = 1) (h1 : ∑ a, v a = 0) :
    μ ^ 2 ≤ (Fintype.card ι : ℝ) * ((1 / 2) * ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2) := by
  have hq := quad_eq S hS v μ hv h2
  have hrow : ∀ a, ∑ b, S a b = 0 := hS.rowSum
  have hcol : ∀ b, ∑ a, S a b = 0 := fun b => by simp only [hS.symm _ b]; exact hS.rowSum b
  have hm : ∑ a, ∑ b, S a b * (v a - v b) * (v a - v b) = -2 * μ := by
    have e : ∀ a b, S a b * (v a - v b) * (v a - v b)
        = S a b * v a ^ 2 + S a b * v b ^ 2 - 2 * (S a b * v a * v b) := fun a b => by ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, hq]
    have t1 : ∑ a, ∑ b, S a b * v a ^ 2 = 0 := by
      refine Finset.sum_eq_zero fun a _ => ?_
      rw [← Finset.sum_mul, hrow a, zero_mul]
    have t2 : ∑ a, ∑ b, S a b * v b ^ 2 = 0 := by
      rw [Finset.sum_comm]
      refine Finset.sum_eq_zero fun b _ => ?_
      rw [← Finset.sum_mul, hcol b, zero_mul]
    rw [t1, t2]; ring
  have hd : ∑ a, ∑ b, (v a - v b) ^ 2 = 2 * (Fintype.card ι : ℝ) := by
    have e : ∀ a b, (v a - v b) ^ 2 = v a ^ 2 + v b ^ 2 - 2 * (v a * v b) := fun a b => by ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ,
      nsmul_eq_mul, ← Finset.mul_sum, ← Finset.sum_mul, h2, h1]
    ring
  have hcs := cs_pairs (fun a b => S a b * (v a - v b)) (fun a b => v a - v b)
  simp only [hm, mul_pow, hd] at hcs
  have e2 : ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2 = ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2 := rfl
  nlinarith [hcs]

/-- **Steps 2 and 3**: `μ² ≤ 2(n−2)/(n−1)` at a unit `S`, through L223's projection `Z`. -/
theorem step23 (h2 : ∑ a, v a ^ 2 = 1) (h1 : ∑ a, v a = 0) (hn : 4 ≤ Fintype.card ι)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) :
    μ ^ 2 ≤ 2 * ((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1) := by
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  have hn4 : (4 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
  have hn2 : n - 2 ≠ 0 := by linarith
  have hn1 : n - 1 ≠ 0 := by linarith
  have hq := quad_eq S hS v μ hv h2
  have hrow : ∀ a, ∑ b, S a b = 0 := hS.rowSum
  have hcol : ∀ b, ∑ a, S a b = 0 := fun b => by simp only [hS.symm _ b]; exact hS.rowSum b
  set c : ℝ := 1 / ((n - 1) * (n - 2)) with hc
  set Z : ι → ι → ℝ := fun a b => v a * v b + (v a ^ 2 + v b ^ 2) / (n - 2) - c with hZ
  set Z' : ι → ι → ℝ := fun a b => if a = b then 0 else Z a b with hZ'
  -- `⟨S, Z'⟩ = μ`
  have hSZ : ∑ a, ∑ b, S a b * Z' a b = μ := by
    have e : ∀ a b, S a b * Z' a b = S a b * v a * v b + (S a b * v a ^ 2 + S a b * v b ^ 2) / (n - 2)
        - c * S a b := by
      intro a b
      simp only [hZ', hZ]
      split_ifs with h
      · subst h; rw [hS.hollow a]; ring
      · ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.sum_div, hq,
      ← Finset.mul_sum]
    have t1 : ∑ a, ∑ b, S a b * v a ^ 2 = 0 :=
      Finset.sum_eq_zero fun a _ => by rw [← Finset.sum_mul, hrow a, zero_mul]
    have t2 : ∑ a, ∑ b, S a b * v b ^ 2 = 0 := by
      rw [Finset.sum_comm]
      exact Finset.sum_eq_zero fun b _ => by rw [← Finset.sum_mul, hcol b, zero_mul]
    have t3 : ∑ a, ∑ b, S a b = 0 := Finset.sum_eq_zero fun a _ => hrow a
    rw [t1, t2, t3]; ring
  -- the rows of `Z'` sum to zero
  have hs3 : ∀ a, ∑ b, Z a b = v a * ∑ b, v b + ((n * v a ^ 2) + 1) / (n - 2) - n * c := by
    intro a
    simp only [hZ, Finset.sum_sub_distrib, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.sum_div,
      h2, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
    rw [← hndef]
    try ring
  have hrowZ : ∀ a, ∑ b, Z' a b = 0 := by
    intro a
    have e : ∑ b, Z' a b = ∑ b, Z a b - Z a a := by
      rw [eq_sub_iff_add_eq, ← Finset.add_sum_erase _ _ (Finset.mem_univ a)]
      simp only [hZ', if_pos rfl, zero_add]
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a)]
      rw [add_comm]
      congr 1
      exact Finset.sum_congr rfl fun b hb => by rw [if_neg (Ne.symm (Finset.ne_of_mem_erase hb))]
    rw [e, hs3, h1]
    simp only [hZ, hc]
    field_simp
    ring
  have hsymZ : ∀ a b, Z' a b = Z' b a := by
    intro a b; simp only [hZ', hZ]
    by_cases h : a = b
    · subst h; rfl
    · rw [if_neg h, if_neg (Ne.symm h)]; ring
  have hcolZ : ∀ b, ∑ a, Z' a b = 0 := fun b => by simp only [hsymZ _ b]; exact hrowZ b
  -- `‖Z'‖² = ⟨Z', v ⊗ v⟩`, then L223
  have hZZ : ∑ a, ∑ b, Z' a b ^ 2 = ∑ a, ∑ b, Z' a b * (v a * v b) := by
    have e : ∀ a b, Z' a b ^ 2 = Z' a b * (v a * v b)
        + (Z' a b * v a ^ 2 + Z' a b * v b ^ 2) / (n - 2) - c * Z' a b := by
      intro a b
      simp only [hZ', hZ]
      split_ifs <;> ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.sum_div, ← Finset.mul_sum]
    have t1 : ∑ a, ∑ b, Z' a b * v a ^ 2 = 0 :=
      Finset.sum_eq_zero fun a _ => by rw [← Finset.sum_mul, hrowZ a, zero_mul]
    have t2 : ∑ a, ∑ b, Z' a b * v b ^ 2 = 0 := by
      rw [Finset.sum_comm]
      exact Finset.sum_eq_zero fun b _ => by rw [← Finset.sum_mul, hcolZ b, zero_mul]
    have t3 : ∑ a, ∑ b, Z' a b = 0 := Finset.sum_eq_zero fun a _ => hrowZ a
    rw [t1, t2, t3]; ring
  have hZV : ∑ a, ∑ b, Z' a b * (v a * v b)
      = 2 * ((n ^ 2 - 3 * n + 3) / (2 * (n - 1) * (n - 2)) - n / (2 * (n - 2)) * ∑ a, v a ^ 4) := by
    rw [← HamiltonsCubic.L223Statement.Z_norm_sq v n (by linarith) h1 h2]
    have e : ∀ a, ∑ b, Z' a b * (v a * v b)
        = ∑ b, Z a b * v a * v b - Z a a * v a * v a := by
      intro a
      rw [eq_sub_iff_add_eq, ← Finset.add_sum_erase _ _ (Finset.mem_univ a)]
      simp only [hZ', if_pos rfl, zero_mul, zero_add]
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a), add_comm]
      congr 1
      · exact Finset.sum_congr rfl fun b hb => by
          rw [if_neg (Ne.symm (Finset.ne_of_mem_erase hb))]; ring
    simp only [e, Finset.sum_sub_distrib]
    simp only [hZ, hc]
  -- Cauchy–Schwarz and the fourth moment
  have hcs := cs_pairs S Z'
  rw [hSZ, hunit, hZZ, hZV] at hcs
  have h4 : 1 / n ≤ ∑ a, v a ^ 4 := by
    have := HamiltonsCubic.L223Statement.fourth_moment_defect v (by linarith) h2
    rw [← hndef] at this
    have hnn : 0 ≤ ∑ a, (v a ^ 2 - 1 / n) ^ 2 := Finset.sum_nonneg fun a _ => sq_nonneg _
    linarith
  have hb : (n ^ 2 - 3 * n + 3) / (2 * (n - 1) * (n - 2)) - n / (2 * (n - 2)) * ∑ a, v a ^ 4
      ≤ (n - 2) / (2 * (n - 1)) := by
    have hpos : 0 < n / (2 * (n - 2)) := by apply div_pos <;> linarith
    have := mul_le_mul_of_nonneg_left h4 hpos.le
    have e : (n ^ 2 - 3 * n + 3) / (2 * (n - 1) * (n - 2)) - n / (2 * (n - 2)) * (1 / n)
        = (n - 2) / (2 * (n - 1)) := by field_simp; ring
    linarith
  have e2 : 2 * (n - 2) / (n - 1) = 2 * (2 * ((n - 2) / (2 * (n - 1)))) := by field_simp
  rw [e2]
  nlinarith [hcs, hb]

end core

/-- A weight is a real symmetric, hence Hermitian, matrix. -/
theorem isHermitian_of_weight {S : Matrix ι ι ℝ} (hS : IsWeight S) : S.IsHermitian := by
  ext i j; simp [Matrix.conjTranspose_apply, hS.symm j i]

/-- **A unit weight has a positive eigenvalue with a unit eigenvector**, from Mathlib's spectral
theorem and `tr S = 0`. -/
theorem exists_pos_eigen {S : Matrix ι ι ℝ} (hS : IsWeight S) (hne : Nonempty ι)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) :
    ∃ (μ : ℝ) (v : ι → ℝ), 0 < μ ∧ S *ᵥ v = μ • v ∧ ∑ a, v a ^ 2 = 1 := by
  have hA := isHermitian_of_weight hS
  have hS0 : S ≠ 0 := by
    intro h; rw [h] at hunit; simp at hunit
  obtain ⟨j, -, hj⟩ := Finset.exists_max_image Finset.univ hA.eigenvalues Finset.univ_nonempty
  have htr : ∑ i, hA.eigenvalues i = 0 := by
    have h := hA.trace_eq_sum_eigenvalues
    have h0 : S.trace = 0 := by simp [Matrix.trace, hS.hollow]
    rw [h0] at h
    simpa using h.symm
  have hpos : 0 < hA.eigenvalues j := by
    by_contra hle
    push Not at hle
    have hall : ∀ i, hA.eigenvalues i ≤ 0 := fun i => le_trans (hj i (Finset.mem_univ i)) hle
    have hz := (Finset.sum_eq_zero_iff_of_nonpos fun i _ => hall i).mp htr
    apply hS0
    exact hA.eigenvalues_eq_zero_iff.mp (funext fun i => hz i (Finset.mem_univ i))
  refine ⟨hA.eigenvalues j, ⇑(hA.eigenvectorBasis j), hpos, hA.mulVec_eigenvectorBasis j, ?_⟩
  have hn := hA.eigenvectorBasis.orthonormal.1 j
  rw [EuclideanSpace.norm_eq, Real.sqrt_eq_one] at hn
  simpa [Real.norm_eq_abs, sq_abs] using hn

/-- **L57 AT A CRITICAL POINT**: a unit weight `S` satisfying the criticality equation with
multiplier `λ` has `λ ≤ √(2(n−1)(n−2))/n`, which is `Θₙ` at even `n`. -/
theorem L57_critical {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 4 ≤ Fintype.card ι)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (lam : ℝ)
    (hcrit : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b) :
    lam ≤ Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))
      / (Fintype.card ι : ℝ) := by
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  have hn4 : (4 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
  have hnpos : 0 < n := by linarith
  by_cases hl : lam ≤ 0
  · exact le_trans hl (div_nonneg (Real.sqrt_nonneg _) hnpos.le)
  push Not at hl
  have hne : Nonempty ι := Fintype.card_pos_iff.mp (by omega)
  obtain ⟨μ, v, hμ, hv, h2⟩ := exists_pos_eigen hS hne hunit
  have h1 := sum_v_zero S hS v μ hv hμ.ne'
  have hp := pairing S hS v μ hv lam h2 hcrit
  have hs1 := step1 S hS v μ hv h2 h1
  have hs23 := step23 S hS v μ hv h2 h1 hn hunit
  rw [← hndef] at hs1 hs23
  set T := (1 / 2) * ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2 with hT
  -- `λ ≤ (n−1)μ/n`
  have hlm : lam * n ≤ (n - 1) * μ := by
    have : lam * μ * n ≤ (n - 1) * μ ^ 2 := by nlinarith
    have hμ2 : lam * n * μ ≤ (n - 1) * μ * μ := by nlinarith
    exact le_of_mul_le_mul_right hμ2 hμ
  rw [le_div_iff₀ hnpos, Real.le_sqrt (by positivity) (by nlinarith)]
  have hn1 : 0 < n - 1 := by linarith
  have hsq : (lam * n) ^ 2 ≤ (n - 1) ^ 2 * μ ^ 2 := by
    have h0 : 0 ≤ lam * n := by positivity
    nlinarith
  have hμ2 : (n - 1) ^ 2 * μ ^ 2 ≤ (n - 1) ^ 2 * (2 * (n - 2) / (n - 1)) :=
    mul_le_mul_of_nonneg_left hs23 (by positivity)
  have e : (n - 1) ^ 2 * (2 * (n - 2) / (n - 1)) = 2 * (n - 1) * (n - 2) := by
    field_simp
  nlinarith

/-- **At a unit critical weight the cubic is the multiplier**: `diagP S = λ`, the criticality
equation contracted against `S`. -/
theorem diagP_eq_lam {S : Matrix ι ι ℝ} (hS : IsWeight S) (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (lam : ℝ)
    (hcrit : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b) : diagP S = lam := by
  have hall : ∀ a b, (S a b ^ 2 + (S * S) a b) * S a b = lam * S a b ^ 2 := by
    intro a b
    by_cases h : a = b
    · subst h; rw [hS.hollow a]; ring
    · rw [hcrit a b h]; ring
  have htr : (S * S * S).trace = ∑ a, ∑ b, (S * S) a b * S a b := by
    simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [hS.symm b a]
  have hsum : ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b) * S a b = lam * 2 := by
    simp only [hall, ← Finset.mul_sum, hunit]
  unfold diagP
  rw [htr]
  have e : ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b) * S a b
      = ∑ a, ∑ b, S a b ^ 3 + ∑ a, ∑ b, (S * S) a b * S a b := by
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun a _ => by rw [← Finset.sum_add_distrib]; exact Finset.sum_congr rfl fun b _ => by ring
  rw [e] at hsum
  linarith

/-- **L57 AT A CRITICAL DIAGONAL OPERATOR**: `P(diag S) ≤ √(2(n−1)(n−2))/n` at every unit weight
satisfying the criticality equation. -/
theorem L57_critical_P {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 4 ≤ Fintype.card ι)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (lam : ℝ)
    (hcrit : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b) :
    HamiltonsCubic.RealLayer.Pcubic (diagOp S) ≤
      Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2)) / (Fintype.card ι : ℝ) := by
  rw [HamiltonsCubic.RealLayer.diagCubicFormula S hS, diagP_eq_lam hS hunit lam hcrit]
  exact L57_critical hS hn hunit lam hcrit

end HamiltonsCubic.L57Critical
