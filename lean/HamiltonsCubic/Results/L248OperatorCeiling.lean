import Mathlib

/-!
# L248: the operator ceiling at every critical point

[findings/second-order.md](../../../findings/second-order.md), Lemma L248.

At a unit critical point, `W^# = θW − W²` and `I#W = −W`, `I#I = (n − 2) I`, so with `M = λ_max`,
`(W − M)#(W − M) = θW − W² + 2MW + M²(n − 2) I`. Written in the classes of `W`'s spectrum this is
`∑_{a,b} (λ_a − M)(λ_b − M) B_ab`, a nonnegative combination of the positive semidefinite
`B_ab = P_a # P_b`. At a unit eigenvector of eigenvalue `λ_c` it gives
`λ_c (θ − λ_c + 2M) + M² (n − 2) ≥ 0` (`operator_ceiling`); at `λ_c = λ_min = −a < 0` with
`M = b` this is `a (θ + a + 2b) ≤ (n − 2) b²` (`theta_ceiling`), which is L244's `x`-free bound
`θ ≤ a (n − 5)` at `a = b`.

The per-vector rows enter as hypotheses, as in L244: `b i j = ⟨B_ij x, x⟩` over any number of classes.
-/

namespace HamiltonsCubic.L248OperatorCeiling

/-- **The operator ceiling**, from the per-vector rows at a unit eigenvector of eigenvalue `lc`. -/
theorem operator_ceiling {k : ℕ} (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (M n θ lc : ℝ)
    (hsymm : ∀ i j, b i j = b j i) (hb : ∀ i j, 0 ≤ b i j) (hM : ∀ i, lam i ≤ M)
    (hA : ∑ i, ∑ j, b i j = n - 2)
    (hB : ∑ i, ∑ j, lam j * b i j = -lc)
    (hC : ∑ i, ∑ j, lam i * lam j * b i j = lc * (θ - lc)) :
    0 ≤ lc * (θ - lc + 2 * M) + M ^ 2 * (n - 2) := by
  have key : 0 ≤ ∑ i, ∑ j, (lam i - M) * (lam j - M) * b i j :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ =>
      mul_nonneg (mul_nonneg_of_nonpos_of_nonpos (by linarith [hM i]) (by linarith [hM j])) (hb i j)
  have hsplit : ∑ i, ∑ j, (lam i - M) * (lam j - M) * b i j
      = ∑ i, ∑ j, lam i * lam j * b i j - M * ∑ i, ∑ j, lam i * b i j
        - M * ∑ i, ∑ j, lam j * b i j + M ^ 2 * ∑ i, ∑ j, b i j := by
    simp only [Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    ring
  have hB' : ∑ i, ∑ j, lam i * b i j = -lc := by
    rw [Finset.sum_comm, ← hB]
    refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun i _ => ?_
    rw [hsymm]
  rw [hsplit, hC, hB', hB, hA] at key
  linarith

/-- **The ceiling on `θ`** at `λ_min = −a < 0`, `λ_max = b`: `a (θ + a + 2b) ≤ (n − 2) b²`. -/
theorem theta_ceiling (a b n θ : ℝ) (h : 0 ≤ -a * (θ + a + 2 * b) + b ^ 2 * (n - 2)) :
    a * (θ + a + 2 * b) ≤ (n - 2) * b ^ 2 := by linarith

/-- **L244's `x`-free bound** at the symmetric spectrum `a = b > 0`: `θ ≤ a (n − 5)`. -/
theorem symmetric_case (a n θ : ℝ) (ha : 0 < a) (h : a * (θ + a + 2 * a) ≤ (n - 2) * a ^ 2) :
    θ ≤ a * (n - 5) := by nlinarith

/-- **Nonvacuity**: every hypothesis holds at two classes `λ = (−1, 1)`, `n = 10`, `θ = 3`, `λ_c = −1`,
with `b = ((1/2, 3), (3, 3/2))`; the conclusion there is `2 ≥ 0`. -/
theorem witness : 0 ≤ (-1 : ℝ) * (3 - (-1) + 2 * 1) + 1 ^ 2 * (10 - 2) :=
  operator_ceiling (k := 2) ![![1/2, 3], ![3, 3/2]] ![-1, 1] 1 10 3 (-1)
    (by intro i j; fin_cases i <;> fin_cases j <;> simp)
    (by intro i j; fin_cases i <;> fin_cases j <;> norm_num)
    (by intro i; fin_cases i <;> norm_num)
    (by simp [Fin.sum_univ_two]; norm_num)
    (by simp [Fin.sum_univ_two]; norm_num)
    (by simp [Fin.sum_univ_two]; norm_num)

end HamiltonsCubic.L248OperatorCeiling
