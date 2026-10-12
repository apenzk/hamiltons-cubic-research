import HamiltonsCubic.Results.L140Statement

set_option linter.style.longLine false

/-!
# L140's `‖|D|‖ = ‖D‖` on the kernel block, discharged

[L140Statement.lean](L140Statement.lean)'s `g1_sq_le_quarter` carries `habs`, that `|D|` and `D` have the same Frobenius
norm on the kernel block `K × K`. That is classical, and this file proves it from what `|D|` is:

* **`frob_eq_of_sq_eq`**: two arrays symmetric on `K × K` whose squares agree there (`Σ_{c ∈ K} A_ic A_cj =
  Σ_{c ∈ K} D_ic D_cj` for `i, j ∈ K`) have the same Frobenius norm on `K × K`, both being the trace of the square;
* **`g1_sq_le_quarter_of_sq`**: `g1_sq_le_quarter` with `habs` replaced by `|D|` symmetric and `|D|² = D²` on the
  kernel block, `D` being `H`'s kernel block and `H` symmetric.

The shape of `Z` (`hE`, `hKK`), L135(c)'s owed step, stays a binder.
-/

namespace HamiltonsCubic.L140Statement

open Finset

variable {N : ℕ}

theorem kk_sum_eq (K : Finset (Fin N)) (f : Fin N → Fin N → ℝ) :
    (∑ i, ∑ j, if i ∈ K ∧ j ∈ K then f i j else 0) = ∑ i ∈ K, ∑ j ∈ K, f i j := by
  classical
  simp only [ite_and]
  have h : ∀ i, (∑ j, if i ∈ K then (if j ∈ K then f i j else 0) else 0)
      = if i ∈ K then ∑ j ∈ K, f i j else 0 := fun i => by
    split_ifs
    · exact Fintype.sum_ite_mem K (f i)
    · simp
  simp only [h]
  exact Fintype.sum_ite_mem K (fun i => ∑ j ∈ K, f i j)

/-- **Same square, same Frobenius norm**, on the block `K × K`. -/
theorem frob_eq_of_sq_eq (K : Finset (Fin N)) (A D : Mat N)
    (hA : ∀ i ∈ K, ∀ j ∈ K, A i j = A j i) (hD : ∀ i ∈ K, ∀ j ∈ K, D i j = D j i)
    (hsq : ∀ i ∈ K, ∀ j ∈ K, ∑ c ∈ K, A i c * A c j = ∑ c ∈ K, D i c * D c j) :
    (∑ i, ∑ j, if i ∈ K ∧ j ∈ K then A i j ^ 2 else 0)
      = ∑ i, ∑ j, if i ∈ K ∧ j ∈ K then D i j ^ 2 else 0 := by
  rw [kk_sum_eq, kk_sum_eq]
  have tr : ∀ X : Mat N, (∀ i ∈ K, ∀ j ∈ K, X i j = X j i) →
      ∑ i ∈ K, ∑ j ∈ K, X i j ^ 2 = ∑ i ∈ K, ∑ c ∈ K, X i c * X c i := fun X hX =>
    Finset.sum_congr rfl fun i hi => Finset.sum_congr rfl fun j hj => by rw [sq, hX j hj i hi]
  rw [tr A hA, tr D hD]
  exact Finset.sum_congr rfl fun i hi => hsq i hi i hi

/-- **L140's boxed statement with `habs` discharged**: `|D|` enters as a matrix symmetric on the kernel block whose
square there is `D²`, `D` being `H`'s kernel block. -/
theorem g1_sq_le_quarter_of_sq (Alt : Mat N →ₗ[ℝ] Mat N) (hidem : ∀ X, Alt (Alt X) = Alt X)
    (hsa : ∀ X Y, fip (Alt X) Y = fip X (Alt Y))
    (H Z absD m : Mat N) (K : Finset (Fin N))
    (haltH : Alt H = 0) (hnorm : fn2 H = 1) (hHs : ∀ i j, H i j = H j i)
    (hm : ∀ i j, -1 ≤ m i j ∧ m i j ≤ 0)
    (hE : ∀ i j, ¬(i ∈ K ∧ j ∈ K) → Z i j = m i j * H i j)
    (hKK : ∀ i j, i ∈ K → j ∈ K → Z i j = (absD i j - H i j) / 2)
    (hAs : ∀ i ∈ K, ∀ j ∈ K, absD i j = absD j i)
    (hsq : ∀ i ∈ K, ∀ j ∈ K, ∑ c ∈ K, absD i c * absD c j = ∑ c ∈ K, H i c * H c j) :
    fn2 (Alt Z) ≤ 1 / 4 :=
  g1_sq_le_quarter Alt hidem hsa H Z absD m K haltH hnorm hm hE hKK
    (frob_eq_of_sq_eq K absD H hAs (fun i _ j _ => hHs i j) hsq)

end HamiltonsCubic.L140Statement
