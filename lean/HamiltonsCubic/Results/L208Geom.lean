import HamiltonsCubic.Results.L208RicciFoxSquare
import HamiltonsCubic.Results.L99Statement

set_option linter.style.longLine false

/-!
# L208 at the operator: `Ric(Q(W)) = 0` on the diagonal locus

[curvature-invariants.md](../../../findings/curvature-invariants.md), Lemma L208: *"Let `W` be coordinate-diagonal with
sectional matrix `K`, so `K` is symmetric with zero diagonal, and let `W` be Ricci-flat, which on this locus is
`K𝟙 = 0`. Then `Ric(Q(W)) = 0`."* [L208RicciFoxSquare.lean](L208RicciFoxSquare.lean) proves the cancellation
`Σ_{c≠a}(K_{ac}² + (K²)_{ac}) = 0` and names the step from the operator to that sum as geometry. That step is typed here:

* **`Qop_diag_eq`**: on every bivector `φ_{ab}`, `Q(diagOp K) = diagOp(K∘K + K²)`, from
  [L99Statement.lean](L99Statement.lean)'s `Qop_diag`;
* **`L208_operator`**: **`Ric(Q(diagOp K)) = 0`** for `K` symmetric, hollow and with zero row sums, through
  [Families.lean](../Base/Families.lean)'s `diagOp_ric` (the Ricci contraction of a diagonal operator is its
  off-diagonal row sum) and `rowSum_sq_add_sq_cancel`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The weight of `Q(diagOp K)`: `(K∘K + K²)_{ab} = K_{ab}² + (K²)_{ab}`. -/
def qWeight (K : Matrix ι ι ℝ) : Matrix ι ι ℝ := fun a b => K a b * K a b + (K * K) a b

omit [DecidableEq ι] in
theorem qWeight_symm {K : Matrix ι ι ℝ} (hK : ∀ a c, K c a = K a c) (a b : ι) : qWeight K a b = qWeight K b a := by
  unfold qWeight
  rw [hK a b, Matrix.mul_apply, Matrix.mul_apply]
  congr 1
  exact Finset.sum_congr rfl fun c _ => by rw [hK a c, hK c b]; ring

/-- **`Q(diagOp K)` is `diagOp(K∘K + K²)` on every bivector `φ_{ab}`.** -/
theorem Qop_diag_eq {K : Matrix ι ι ℝ} (hK : ∀ a c, K c a = K a c) (hdiag : ∀ a, K a a = 0) (a b : ι) :
    Qop (diagOp K) (phi a b) = diagOp (qWeight K) (phi a b) := by
  rw [HamiltonsCubic.L99Statement.Qop_diag K (fun p q => (hK p q).symm) hdiag,
    diagOp_phi (qWeight K) (fun p q => qWeight_symm hK p q)]
  rfl

/-- **L208 at the operator**: on the coordinate-diagonal locus, a Ricci-flat `diagOp K` has `Ric(Q(diagOp K)) = 0`. -/
theorem L208_operator {K : Matrix ι ι ℝ} (hK : ∀ a c, K c a = K a c) (hdiag : ∀ a, K a a = 0)
    (hrow : ∀ a, ∑ c, K a c = 0) (a b : ι) : Ric (Qop (diagOp K)) a b = 0 := by
  have hR : Ric (Qop (diagOp K)) a b = Ric (diagOp (qWeight K)) a b := by
    unfold Ric
    exact Finset.sum_congr rfl fun c _ => by rw [Qop_diag_eq hK hdiag a c]
  rw [hR, diagOp_ric (qWeight K) (fun p q => qWeight_symm hK p q)]
  split_ifs with hab
  · -- `Σ_c v_{ac} - v_{aa} = Σ_{c ≠ a} v_{ac}`, the cancellation
    have hsplit : ∑ c, qWeight K a c = qWeight K a a + ∑ c ∈ univ.erase a, qWeight K a c :=
      (Finset.add_sum_erase _ _ (Finset.mem_univ a)).symm
    rw [hsplit, add_sub_cancel_left]
    have h := rowSum_sq_add_sq_cancel K hK hdiag hrow a
    rw [← h]
    exact Finset.sum_congr rfl fun c _ => by unfold qWeight; ring
  · rfl

end HamiltonsCubic.Results
