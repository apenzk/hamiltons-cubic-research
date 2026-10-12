import HamiltonsCubic.Results.DoublyStochasticEq

set_option linter.style.longLine false

/-!
# L52's remarks: the row-tight rotation, the one-line bound and the second display's arithmetic

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L52. Remarks the block makes, declared:

* **`rot4`**, **`rot4_ds`**, **`rot4_rowtight`**, **`rot4_not_perm`**: the "only if" bullet's example. At `μ = (1, 1, 2)` the
  rotation by `π/4` inside the repeated eigenplane gives the doubly stochastic `P = [[½, ½, 0], [½, ½, 0], [0, 0, 1]]`,
  which is Jensen-tight in every row for every `g` and is no permutation, so row-tightness alone does not make `U` a
  permutation (and [DoublyStochasticEq.lean](DoublyStochasticEq.lean)'s counting is what delivers the rearrangement);
* **`ratio_le`**: `(1 + u + u²)/(1 + u) ≤ 3/2` on `[0, 1]`, in the cleared form `1 + u + u² ≤ (3/2)(1 + u)`;
* **`display_needs_small_C`**: if the second display `θ ≤ u³ Θ + (9/2) C (1 − u²)`, `u² = t_F/2`, returns `Θ` at some
  `u ∈ [0, 1)`, then `C ≤ Θ/3`;
* **`one_line_bound`**: the one-line bound `θ ≤ (3/2)(M₊ + m)` on the bi-spectral form;
* **`penalty_half`**: the penalty half of the second display, `(9/2)M₊(1 − s) + (9/2)m(1 − s) = (9/2)C(1 − s)`;
* **`one_line_half`**: and then the one-line bound `θ ≤ (3/2) C` gives `θ ≤ Θ/2`, so the display is informative only at
  `t_F = 2`.

The second display itself, derived in r480, is not declared here.
-/

namespace HamiltonsCubic.DoublyStochastic

open Finset

/-- The entrywise squares of the `π/4` rotation in the `e₀e₁` plane, `P_ij = U_ij²` with `U` that rotation
([L52Rot.lean](L52Rot.lean)'s `U4`, `U4_sq`), the degenerate eigenplane of `μ = (1, 1, 2)`. -/
noncomputable def rot4 : Fin 3 → Fin 3 → ℝ := ![![1 / 2, 1 / 2, 0], ![1 / 2, 1 / 2, 0], ![0, 0, 1]]

/-- The spectrum with a repeated eigenvalue. -/
noncomputable def mu4 : Fin 3 → ℝ := ![1, 1, 2]

theorem rot4_ds : IsDoublyStochastic rot4 where
  nonneg i j := by fin_cases i <;> fin_cases j <;> simp [rot4]
  rows i := by fin_cases i <;> simp [rot4, Fin.sum_univ_three] <;> norm_num
  cols j := by fin_cases j <;> simp [rot4, Fin.sum_univ_three] <;> norm_num

/-- **Every row is Jensen-tight, for every `g`**: `μ` is constant on each row's support. -/
theorem rot4_rowtight (g : ℝ → ℝ) (i : Fin 3) :
    g (∑ j, rot4 i j • mu4 j) = ∑ j, rot4 i j • g (mu4 j) := by
  have p00 : rot4 0 0 = 1 / 2 := rfl
  have p01 : rot4 0 1 = 1 / 2 := rfl
  have p02 : rot4 0 2 = 0 := rfl
  have p10 : rot4 1 0 = 1 / 2 := rfl
  have p11 : rot4 1 1 = 1 / 2 := rfl
  have p12 : rot4 1 2 = 0 := rfl
  have p20 : rot4 2 0 = 0 := rfl
  have p21 : rot4 2 1 = 0 := rfl
  have p22 : rot4 2 2 = 1 := rfl
  have m0 : mu4 0 = 1 := rfl
  have m1 : mu4 1 = 1 := rfl
  have m2 : mu4 2 = 2 := rfl
  rw [Fin.sum_univ_three, Fin.sum_univ_three]
  fin_cases i <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, smul_eq_mul, p00, p01, p02, p10, p11, p12, p20, p21, p22, m0, m1, m2] <;>
    norm_num <;> ring

/-- **And `P` is no permutation**: it has an entry strictly between `0` and `1`. -/
theorem rot4_not_perm : ¬ ∀ i j, rot4 i j = 0 ∨ rot4 i j = 1 := by
  intro h
  rcases h 0 0 with h0 | h0 <;> simp [rot4] at h0

end HamiltonsCubic.DoublyStochastic

namespace HamiltonsCubic.L52Remarks

/-- **`(1 + u + u²)/(1 + u) ≤ 3/2` on `[0, 1]`**, cleared of the denominator: `2u² − u − 1 = (2u + 1)(u − 1) ≤ 0`. -/
theorem ratio_le {u : ℝ} (h0 : 0 ≤ u) (h1 : u ≤ 1) : 1 + u + u ^ 2 ≤ (3 / 2) * (1 + u) := by
  nlinarith [mul_nonneg (by linarith : (0 : ℝ) ≤ 2 * u + 1) (by linarith : (0 : ℝ) ≤ 1 - u)]

/-- **The second display returns `Θ` below `t_F = 2` only if `C ≤ Θ/3`.** -/
theorem display_needs_small_C {u Θ C : ℝ} (h0 : 0 ≤ u) (h1 : u < 1) (hΘ : 0 ≤ Θ) (_hC : 0 ≤ C)
    (h : u ^ 3 * Θ + (9 / 2) * C * (1 - u ^ 2) ≤ Θ) : C ≤ Θ / 3 := by
  have hu : 0 < 1 - u := by linarith
  have key : (9 / 2) * C * (1 + u) ≤ Θ * (1 + u + u ^ 2) := by
    have e : (1 - u) * ((9 / 2) * C * (1 + u)) ≤ (1 - u) * (Θ * (1 + u + u ^ 2)) := by nlinarith
    exact le_of_mul_le_mul_left e hu
  have hr := ratio_le h0 h1.le
  have : (9 / 2) * C * (1 + u) ≤ Θ * ((3 / 2) * (1 + u)) := key.trans (mul_le_mul_of_nonneg_left hr hΘ)
  nlinarith

/-- **Then the one-line bound already gives `θ ≤ Θ/2`.** -/
theorem one_line_half {θ C Θ : ℝ} (hθ : θ ≤ (3 / 2) * C) (hC : C ≤ Θ / 3) : θ ≤ Θ / 2 := by linarith

/-- **The one-line bound**: for spectra `μ ≤ M₊` with `∑ μ² = 1` and `ω ≥ −m` with `∑ ω² = 3`,
`(3/2) ∑ μ³ − (1/2) ∑ ω³ ≤ (3/2)(M₊ + m)`, termwise from `μ³ ≤ M₊ μ²` and `−ω³ ≤ m ω²`. -/
theorem one_line_bound {P Q : Type*} [Fintype P] [Fintype Q] (μ : P → ℝ) (ω : Q → ℝ) (Mp m : ℝ)
    (hμ : ∀ j, μ j ≤ Mp) (hω : ∀ j, -m ≤ ω j) (hμ2 : ∑ j, μ j ^ 2 = 1) (hω2 : ∑ j, ω j ^ 2 = 3) :
    (3 / 2) * ∑ j, μ j ^ 3 - (1 / 2) * ∑ j, ω j ^ 3 ≤ (3 / 2) * (Mp + m) := by
  have h1 : ∑ j, μ j ^ 3 ≤ Mp * ∑ j, μ j ^ 2 := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun j _ => by nlinarith [sq_nonneg (μ j), hμ j]
  have h2 : -∑ j, ω j ^ 3 ≤ m * ∑ j, ω j ^ 2 := by
    rw [Finset.mul_sum, ← Finset.sum_neg_distrib]
    exact Finset.sum_le_sum fun j _ => by nlinarith [sq_nonneg (ω j), hω j]
  rw [hμ2] at h1
  rw [hω2] at h2
  linarith

/-- **The penalty-half identity**: `(9/2)M₊(1 − s) + (9/2)m(1 − s) = (9/2)C(1 − s)` with `C = M₊ + m`. -/
theorem penalty_half (Mp m s : ℝ) : (9 / 2) * Mp * (1 - s) + (9 / 2) * m * (1 - s) = (9 / 2) * (Mp + m) * (1 - s) := by
  ring

end HamiltonsCubic.L52Remarks
