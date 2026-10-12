import Mathlib
import HamiltonsCubic.Results.L228Item1

set_option linter.style.longLine false

/-!
# L228 item 2: the shift `Y_a = X_a + ½R_a` at one block

[findings/second-order.md](../../../findings/second-order.md), Lemma L228, item 2: *"For each $a$, with
$R_a=\sum_{c\ne a}X_c$, $T_a=\sum_{c\ne a}X_c^2$ and $Y_a=X_a+\tfrac12R_a$: $P(W)=6\operatorname{tr}Y_a^3
+\operatorname{tr}(Y_a\ell'_a)+c_a$ and $\lVert W\rVert^2=2\lvert Y_a\rvert^2+n_a$, where
$\ell'_a=\tfrac32R_a^2+3T_a+2\sum_{c\ne a}\beta_{ac}X_c$ and $c_a,n_a$ do not depend on $X_a$."* The L228 row owes
*"item 2's Gram and norm expansions"*; [L228Statement.lean](L228Statement.lean) has the cubic split and the two
completed squares, and [L228Item1.lean](L228Item1.lean) item 1. This file, at the block `a = 0` of
`Fin (m + 1)` (the relabelling of the outer set that moves any block to `0` is prose):

* `sum_ne_succ`: the ordered-pair sum splits off the pairs through `0`;
* `cA`, `nA`: `c_a` and `n_a` as explicit functions of `t`, `K` and the other blocks `X_c`, `c ≠ a`;
* `L228_item2`: `P(W) = 6 tr Y³ + tr(Y ℓ') + c_a` and `‖W‖² = 2|Y|² + n_a` at the operator.
-/

namespace HamiltonsCubic.L228Item2

open Matrix Finset HamiltonsCubic.L226Statement HamiltonsCubic.L228Statement HamiltonsCubic.L228Item1
  HamiltonsCubic.RealLayer

variable {m : ℕ}

/-- **The pairs through `0`**: over `Fin (m + 1)`, a symmetric summand on ordered pairs is twice the pairs
`(0, i + 1)` plus the pairs among the others. -/
theorem sum_ne_succ (f : Fin (m + 1) → Fin (m + 1) → ℝ) (hf : ∀ a b, f a b = f b a) :
    ∑ a, ∑ b, (if a ≠ b then f a b else 0)
      = 2 * ∑ i : Fin m, f 0 i.succ + ∑ i : Fin m, ∑ j : Fin m, (if i ≠ j then f i.succ j.succ else 0) := by
  simp only [Fin.sum_univ_succ]
  simp only [ne_eq, not_true_eq_false, if_false, Fin.succ_ne_zero, not_false_eq_true, if_true,
    (Fin.succ_ne_zero _).symm, Fin.succ_inj, zero_add]
  have h : ∑ i : Fin m, f i.succ 0 = ∑ i : Fin m, f 0 i.succ := Finset.sum_congr rfl fun i _ => hf _ _
  rw [Finset.sum_add_distrib, h]
  ring

/-- `c_a` at `a = 0`, from the other blocks `Xr i = X_{i+1}`. -/
noncomputable def cA (t : Fin (m + 1) → ℝ) (K : Fin (m + 1) → Fin (m + 1) → ℝ) (Xr : Fin m → Matrix (Fin 3) (Fin 3) ℝ) :
    ℝ :=
  (2 * ((∑ i, Xr i) * (∑ i, Xr i) * (∑ i, Xr i)).trace + 3 * ((∑ i, Xr i) * (∑ i, Xr i * Xr i)).trace
      + ∑ i, (Xr i * Xr i * Xr i).trace)
    + (3 / 2 * ((∑ i, Xr i) * (∑ i, Xr i) * (∑ i, Xr i)).trace
      - 1 / 2 * ((∑ i, Xr i) * ((6 : ℝ) • ((∑ i, Xr i) * (∑ i, Xr i)) + (3 : ℝ) • (∑ i, Xr i * Xr i)
        + (2 : ℝ) • ∑ i, beta t K 0 i.succ • Xr i)).trace)
    + ∑ i, ∑ j, (if i ≠ j then beta t K i.succ j.succ * (Xr i * Xr j).trace else 0)
    + P0 t K

/-- `n_a` at `a = 0`. -/
noncomputable def nA (t : Fin (m + 1) → ℝ) (K : Fin (m + 1) → Fin (m + 1) → ℝ) (Xr : Fin m → Matrix (Fin 3) (Fin 3) ℝ) :
    ℝ :=
  1 / 2 * ((∑ i, Xr i) * (∑ i, Xr i)).trace + ∑ i, (Xr i * Xr i).trace + N0 t K

/-- **L228 item 2 at the operator.** -/
theorem L228_item2 (t : Fin (m + 1) → ℝ) (Xs : Fin (m + 1) → Matrix (Fin 3) (Fin 3) ℝ)
    (hX : ∀ a, (Xs a).trace = 0) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin (m + 1) → Fin (m + 1) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    let R := ∑ i : Fin m, Xs i.succ
    let T := ∑ i : Fin m, Xs i.succ * Xs i.succ
    let Y := Xs 0 + (1 / 2 : ℝ) • R
    let ℓ := (3 / 2 : ℝ) • (R * R) + (3 : ℝ) • T + (2 : ℝ) • ∑ i : Fin m, beta t K 0 i.succ • Xs i.succ
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)) (fun a => t a • 1 + Xs a) K)
        = 6 * (Y * Y * Y).trace + (Y * ℓ).trace + cA t K (fun i => Xs i.succ) ∧
      normSq (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)) (fun a => t a • 1 + Xs a) K)
        = 2 * (Y * Y).trace + nA t K (fun i => Xs i.succ) := by
  intro R T Y ℓ
  have hRdef : R = ∑ i : Fin m, Xs i.succ := rfl
  have hTdef : T = ∑ i : Fin m, Xs i.succ * Xs i.succ := rfl
  have hYdef : Y = Xs 0 + (1 / 2 : ℝ) • R := rfl
  set Bm := ∑ i : Fin m, beta t K 0 i.succ • Xs i.succ with hBm
  have hℓdef : ℓ = (3 / 2 : ℝ) • (R * R) + (3 : ℝ) • T + (2 : ℝ) • Bm := rfl
  obtain ⟨hP, hN⟩ := L228_item1 t Xs hX hXs K hK hK0
  set L := (6 : ℝ) • (R * R) + (3 : ℝ) • T + (2 : ℝ) • Bm with hL
  have hX0 : Xs 0 = Y - (1 / 2 : ℝ) • R := by rw [hYdef, add_sub_cancel_right]
  have hβ : ∀ a b, beta t K a b = beta t K b a := fun a b => by unfold beta; rw [hK]; ring
  have hB := sum_ne_succ (fun a b => beta t K a b * (Xs a * Xs b).trace)
    (fun a b => by rw [hβ, Matrix.trace_mul_comm])
  have hB0 : 2 * ∑ i : Fin m, beta t K 0 i.succ * (Xs 0 * Xs i.succ).trace = (Xs 0 * ((2 : ℝ) • Bm)).trace := by
    rw [Matrix.mul_smul, Matrix.trace_smul, hBm, Matrix.mul_sum, Matrix.trace_sum, smul_eq_mul]
    congr 1
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]
  have hsplit := cubic_split Xs
  rw [← hRdef, ← hTdef] at hsplit
  have hsq := complete_square Y R L
  rw [← hX0] at hsq
  have hL' : L - (9 / 2 : ℝ) • (R * R) = ℓ := by
    rw [hL, hℓdef]
    module
  rw [hL'] at hsq
  have hLs : (Xs 0 * L).trace = (Xs 0 * ((6 : ℝ) • (R * R) + (3 : ℝ) • T)).trace + (Xs 0 * ((2 : ℝ) • Bm)).trace := by
    rw [hL, Matrix.mul_add, Matrix.trace_add]
  refine ⟨?_, ?_⟩
  · rw [hP, hB]
    unfold cA
    beta_reduce
    rw [← hRdef, ← hTdef, ← hBm, ← hL]
    linarith [hsplit, hsq, hLs, hB0]
  · rw [hN]
    unfold nA
    beta_reduce
    rw [← hRdef, Fin.sum_univ_succ Xs, ← hRdef, Fin.sum_univ_succ (fun a => (Xs a * Xs a).trace)]
    have hn := complete_square_norm (Xs 0) R
    rw [← hYdef] at hn
    have hXX : ((Xs 0 + R) * (Xs 0 + R)).trace = (Xs 0 * Xs 0).trace + 2 * (Xs 0 * R).trace + (R * R).trace := by
      rw [Matrix.add_mul, Matrix.mul_add, Matrix.mul_add, Matrix.trace_add, Matrix.trace_add, Matrix.trace_add,
        Matrix.trace_mul_comm R (Xs 0)]
      ring
    rw [hXX]
    linarith [hn]

end HamiltonsCubic.L228Item2
