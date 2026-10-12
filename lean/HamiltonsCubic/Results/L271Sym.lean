import Mathlib
import HamiltonsCubic.Results.I117Statements

set_option linter.style.longLine false

/-!
# L271 (2): the symmetries of the torus system and of `F`, and positivity as `P_ij > |Q_ij|`

[findings/second-order.md](../../../findings/second-order.md), Lemma L271 (2): *"The system and $F$ are invariant
under $P\leftrightarrow Q$ and under $Q\mapsto SQS$, $A\mapsto SAS$ for a diagonal sign matrix $S$, and
$(A_{\mathrm{off}},Q)\mapsto-(A_{\mathrm{off}},Q)$ fixes every term of $F$ except $\tfrac12\operatorname{tr}Q^3$. At an
idempotent, positive definiteness is $P_{ij}>\lvert Q_{ij}\rvert$ ..."* [I117Statements.lean](I117Statements.lean)
proves the system in `P, Q` (`L271_pq_system`) and `F` on the slice (`Ftri_torus`). This file, in the coordinates
`P = U + V`, `Q = U - V`, `d_i = ½ ∑_l (P_il² + Q_il²)`:

* `PQSys`, `Fpq`: the system and `F`'s value as functions of `A`, `P`, `Q`; `torus_iff_PQSys`, `Ftri_eq_Fpq` identify
  them with L268's `TorusSystem` and with `F(C, C, C)` at `C = torusOp A U V`;
* `PQSys_swap`, `Fpq_swap`: invariance under `P ↔ Q`;
* `PQSys_sign`, `Fpq_sign`: invariance under `Q ↦ SQS`, `A ↦ SAS`, `S` a diagonal sign matrix;
* `Fpq_neg`: `(A_off, Q) ↦ -(A_off, Q)` changes `F` by `-tr Q³` only;
* `pos_iff`: `U_ij > 0 ∧ V_ij > 0 ↔ P_ij > |Q_ij|`.
-/

namespace HamiltonsCubic.L271Sym

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S

variable {m : ℕ}

/-- `d_i` in the pair coordinates. -/
noncomputable def dPQ (P Q : Matrix (Fin m) (Fin m) ℝ) (i : Fin m) : ℝ := (1 / 2) * ∑ l, (P i l ^ 2 + Q i l ^ 2)

/-- **The torus system in `P`, `Q`.** -/
def PQSys (P Q : Matrix (Fin m) (Fin m) ℝ) : Prop :=
  ∀ i j : Fin m, i ≠ j →
    P i j * (1 - dPQ P Q i - dPQ P Q j - 2 * Q i j ^ 2) = (P * P) i j ∧
    Q i j * (1 - dPQ P Q i - dPQ P Q j - 2 * P i j ^ 2) = (Q * Q) i j

/-- **`F` on the slice in `A`, `P`, `Q`.** -/
noncomputable def Fpq (A P Q : Matrix (Fin m) (Fin m) ℝ) : ℝ :=
  3 * ∑ i, A i i * dPQ P Q i - 3 * (∑ i, ∑ j, if i = j then 0 else A i j * P i j * Q i j)
    + (1 / 2) * Matrix.trace (P * P * P) + (1 / 2) * Matrix.trace (Q * Q * Q)

theorem dvec_eq (U V : Matrix (Fin m) (Fin m) ℝ) (i : Fin m) : dvec U V i = dPQ (U + V) (U - V) i := by
  unfold dvec dPQ
  rw [Finset.mul_sum]
  exact Finset.sum_congr rfl fun l _ => by simp only [Matrix.add_apply, Matrix.sub_apply]; ring

/-- **L268's system is the `P, Q` system.** -/
theorem torus_iff_PQSys (U V : Matrix (Fin m) (Fin m) ℝ) : TorusSystem U V ↔ PQSys (U + V) (U - V) := by
  rw [L271_pq_system]
  unfold PQSys
  simp only [dvec_eq]

/-- **`F(C, C, C)` on the slice is `Fpq`.** -/
theorem Ftri_eq_Fpq (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V) = Fpq A (U + V) (U - V) := by
  rw [Ftri_torus A U V hA hU hV]
  unfold Fpq
  simp only [dvec_eq]

theorem dPQ_swap (P Q : Matrix (Fin m) (Fin m) ℝ) (i : Fin m) : dPQ Q P i = dPQ P Q i := by
  unfold dPQ; congr 1; exact Finset.sum_congr rfl fun l _ => by ring

/-- **The system is invariant under `P ↔ Q`.** -/
theorem PQSys_swap (P Q : Matrix (Fin m) (Fin m) ℝ) : PQSys Q P ↔ PQSys P Q := by
  unfold PQSys
  simp only [dPQ_swap]
  exact ⟨fun h i j hij => (h i j hij).symm, fun h i j hij => (h i j hij).symm⟩

/-- **`F` is invariant under `P ↔ Q`.** -/
theorem Fpq_swap (A P Q : Matrix (Fin m) (Fin m) ℝ) : Fpq A Q P = Fpq A P Q := by
  unfold Fpq
  simp only [dPQ_swap]
  have h : ∀ i j, (if i = j then (0 : ℝ) else A i j * Q i j * P i j) = (if i = j then 0 else A i j * P i j * Q i j) :=
    fun i j => by split_ifs <;> ring
  simp only [h]
  ring

section Sign
variable (s : Fin m → ℝ) (hs : ∀ i, s i ^ 2 = 1)
include hs

theorem sign_sq : diagonal s * diagonal s = (1 : Matrix (Fin m) (Fin m) ℝ) := by
  rw [Matrix.diagonal_mul_diagonal, ← Matrix.diagonal_one]
  congr 1; funext i; rw [← sq, hs i]

theorem conj_apply (Q : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) :
    (diagonal s * Q * diagonal s) i j = s i * Q i j * s j := by
  rw [Matrix.mul_diagonal, Matrix.diagonal_mul]

theorem conj_sq (Q : Matrix (Fin m) (Fin m) ℝ) :
    (diagonal s * Q * diagonal s) * (diagonal s * Q * diagonal s) = diagonal s * (Q * Q) * diagonal s := by
  rw [show (diagonal s * Q * diagonal s) * (diagonal s * Q * diagonal s)
      = diagonal s * Q * (diagonal s * diagonal s) * Q * diagonal s by simp only [Matrix.mul_assoc],
    sign_sq s hs, Matrix.mul_one]
  simp only [Matrix.mul_assoc]

theorem dPQ_sign (P Q : Matrix (Fin m) (Fin m) ℝ) (i : Fin m) :
    dPQ P (diagonal s * Q * diagonal s) i = dPQ P Q i := by
  unfold dPQ
  congr 1
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [conj_apply s hs]
  have h1 := hs i
  have h2 := hs l
  calc P i l ^ 2 + (s i * Q i l * s l) ^ 2 = P i l ^ 2 + s i ^ 2 * s l ^ 2 * Q i l ^ 2 := by ring
    _ = P i l ^ 2 + Q i l ^ 2 := by rw [h1, h2]; ring

/-- **The system is invariant under `Q ↦ SQS`.** -/
theorem PQSys_sign (P Q : Matrix (Fin m) (Fin m) ℝ) : PQSys P (diagonal s * Q * diagonal s) ↔ PQSys P Q := by
  unfold PQSys
  simp only [dPQ_sign s hs, conj_sq s hs, conj_apply s hs]
  refine forall_congr' fun i => forall_congr' fun j => forall_congr' fun _ => ?_
  have h1 := hs i
  have h2 := hs j
  have hss : (s i * s j) ^ 2 = 1 := by rw [mul_pow, h1, h2]; ring
  have e1 : ∀ x : ℝ, (s i * x * s j) ^ 2 = x ^ 2 := fun x => by
    calc (s i * x * s j) ^ 2 = (s i * s j) ^ 2 * x ^ 2 := by ring
      _ = x ^ 2 := by rw [hss]; ring
  rw [e1]
  constructor
  · rintro ⟨h1', h2'⟩
    refine ⟨h1', ?_⟩
    linear_combination (s i * s j) * h2' - (Q i j * (1 - dPQ P Q i - dPQ P Q j - 2 * P i j ^ 2) - (Q * Q) i j) * hss
  · rintro ⟨h1', h2'⟩
    refine ⟨h1', ?_⟩
    linear_combination (s i * s j) * h2'

/-- **`F` is invariant under `Q ↦ SQS`, `A ↦ SAS`.** -/
theorem Fpq_sign (A P Q : Matrix (Fin m) (Fin m) ℝ) :
    Fpq (diagonal s * A * diagonal s) P (diagonal s * Q * diagonal s) = Fpq A P Q := by
  unfold Fpq
  simp only [dPQ_sign s hs, conj_apply s hs]
  have hQ3 : Matrix.trace ((diagonal s * Q * diagonal s) * (diagonal s * Q * diagonal s) * (diagonal s * Q * diagonal s))
      = Matrix.trace (Q * Q * Q) := by
    rw [conj_sq s hs, show diagonal s * (Q * Q) * diagonal s * (diagonal s * Q * diagonal s)
        = diagonal s * (Q * Q) * (diagonal s * diagonal s) * Q * diagonal s by simp only [Matrix.mul_assoc],
      sign_sq s hs, Matrix.mul_one, Matrix.trace_mul_comm, ← Matrix.mul_assoc, ← Matrix.mul_assoc, sign_sq s hs,
      Matrix.one_mul, Matrix.mul_assoc]
  rw [hQ3]
  have hd : ∀ i, s i * A i i * s i * dPQ P Q i = A i i * dPQ P Q i := fun i => by
    have := hs i; linear_combination (A i i * dPQ P Q i) * this
  have ho : ∀ i j, (if i = j then (0 : ℝ) else s i * A i j * s j * P i j * (s i * Q i j * s j))
      = (if i = j then 0 else A i j * P i j * Q i j) := fun i j => by
    split_ifs
    · rfl
    · have h1 := hs i; have h2 := hs j
      linear_combination (A i j * P i j * Q i j * s j ^ 2) * h1 + (A i j * P i j * Q i j) * h2
  simp only [hd, ho]

end Sign

/-- **`(A_off, Q) ↦ -(A_off, Q)` changes `F` by `-tr Q³` only.** -/
theorem Fpq_neg (A P Q : Matrix (Fin m) (Fin m) ℝ) :
    Fpq (Matrix.of fun i j => if i = j then A i j else -A i j) P (-Q) = Fpq A P Q - Matrix.trace (Q * Q * Q) := by
  unfold Fpq
  have hd : ∀ i, dPQ P (-Q) i = dPQ P Q i := fun i => by
    unfold dPQ; congr 1; exact Finset.sum_congr rfl fun l _ => by simp only [Matrix.neg_apply]; ring
  simp only [hd, Matrix.of_apply, if_true]
  have ho : ∀ i j, (if i = j then (0 : ℝ) else (if i = j then A i j else -A i j) * P i j * (-Q) i j)
      = (if i = j then 0 else A i j * P i j * Q i j) := fun i j => by
    split_ifs <;> simp only [Matrix.neg_apply] <;> ring
  simp only [ho]
  rw [show (-Q) * (-Q) * (-Q) = -(Q * Q * Q) by noncomm_ring, Matrix.trace_neg]
  ring

/-- **Positivity is `P_ij > |Q_ij|`.** -/
theorem pos_iff (u v : ℝ) : (0 < u ∧ 0 < v) ↔ |u - v| < u + v := by
  rw [abs_lt]
  constructor
  · rintro ⟨hu, hv⟩; constructor <;> linarith
  · rintro ⟨h1, h2⟩; constructor <;> linarith

end HamiltonsCubic.L271Sym
