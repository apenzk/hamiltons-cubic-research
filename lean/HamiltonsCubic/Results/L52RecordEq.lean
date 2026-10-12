import HamiltonsCubic.Results.L52Frame
import HamiltonsCubic.Results.L52Equality

set_option linter.style.longLine false

/-!
# L52's equality clause at the record's objects

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L52's equality clause: exactness forces the shared
frame. [L52Equality.lean](L52Equality.lean) proves both halves on any two real symmetric matrices, and
[L52Frame.lean](L52Frame.lean)'s `L52_record` instantiates the bound at `A = Mpair R` and `B = Bw w (ringW R)` for any
complete family `w`. This file instantiates the equality clause there:

* **`L52_record_eq`**: at a first-Bianchi unit-norm `R`, equality in `L52_record` makes `M` in the pair basis and `W̊` in
  the basis `{φ_ab} ∪ {diag w_k}` both diagonal, which at `w = wK`, an eigenbasis of `K`, is the basis of `S²` the record's
  stipulation picks;
* **`L52_record_if`**: conversely, if both are diagonal the bound is an equality;
* **`L52_eq_diagonalises`**: at equality `w_kᵀ K w_l = 0` for `k ≠ l`, so an equality-attaining `w` diagonalises `K`,
  the record's `ψ` stipulation forced by equality.

At an eigenbasis `w` of `K` the `ψ`-block of `W̊` is `diag(−κ_k)` (`psi_block`), so the stipulated basis makes the
`ψ`-block diagonal for free; at another complete `w` diagonality of `Bw w (ringW R)` is a condition on `w`, which is the
record's staircase counterexample to the unstipulated "if" half.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (w : Fin n → Fin n → ℝ) (hw : ∀ i j, ∑ k, w k i * w k j = if i = j then 1 else 0)
include hR hskew hsym hw

/-- **The "only if" half at the record's objects.** -/
theorem L52_record_eq (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1) (Mp m : ℝ)
    (hμ : ∀ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ≤ Mp)
    (hω : ∀ j, -m ≤ (Bw_isHermitian R hR hskew hsym w hw).eigenvalues j)
    (heq : Pcubic R = (3 / 2) * (∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 3
          + 3 * Mp * (1 - ∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 2))
        - (1 / 2) * (∑ u, Bw w (ringW R) u u ^ 3
          + 3 * m * (∑ u, Bw w (ringW R) u u ^ 2 - 3))) :
    (∀ p q, p ≠ q → Mpair R p q = 0) ∧ (∀ u v, u ≠ v → Bw w (ringW R) u v = 0) := by
  refine L52Bound.L52_matrix_eq_frame (Mpair R) (Mpair_isHermitian R hR hskew hsym)
    (Bw w (ringW R)) (Bw_isHermitian R hR hskew hsym w hw) Mp m hμ hω
    (by rw [sum_mu_sq R hR hskew hsym, hunit])
    (by rw [sum_omega_w_sq R hR hskew hsym w hw hB, hunit]; ring) ?_
  rw [sum_omega_w_cube R hR hskew hsym w hw]
  rw [L50Spectra.L50_bispectral R hR hskew hsym hB, ← sum_mu_cube R hR hskew hsym] at heq
  exact heq

/-- **The "if" half at the record's objects**: diagonal `M` and `W̊` in the frame make `L52_record` an equality. -/
theorem L52_record_if (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1) (Mp m : ℝ)
    (hMd : ∀ p q, p ≠ q → Mpair R p q = 0) (hWd : ∀ u v, u ≠ v → Bw w (ringW R) u v = 0) :
    Pcubic R = (3 / 2) * (∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 3
          + 3 * Mp * (1 - ∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 2))
        - (1 / 2) * (∑ u, Bw w (ringW R) u u ^ 3
          + 3 * m * (∑ u, Bw w (ringW R) u u ^ 2 - 3)) := by
  have h := L52Bound.L52_matrix_if (Mpair R) (Mpair_isHermitian R hR hskew hsym)
    (Bw w (ringW R)) (Bw_isHermitian R hR hskew hsym w hw) Mp m
    (by rw [sum_mu_sq R hR hskew hsym, hunit])
    (by rw [sum_omega_w_sq R hR hskew hsym w hw hB, hunit]; ring) hMd hWd
  rw [sum_omega_w_cube R hR hskew hsym w hw] at h
  rw [L50Spectra.L50_bispectral R hR hskew hsym hB, ← sum_mu_cube R hR hskew hsym]
  exact h

/-- **Equality forces the frame to diagonalise `K`**: at equality in `L52_record`, `w_kᵀ K w_l = 0` for `k ≠ l`, the
`ψ`–`ψ` entries of `W̊` being `−w_kᵀ K w_l` (`diag_block`). So an equality-attaining complete `w` diagonalises `K`
(and, `w` being an orthonormal basis, is then an eigenbasis of `K`), the record's stipulation forced rather than
assumed. -/
theorem L52_eq_diagonalises (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1) (Mp m : ℝ)
    (hμ : ∀ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ≤ Mp)
    (hω : ∀ j, -m ≤ (Bw_isHermitian R hR hskew hsym w hw).eigenvalues j)
    (heq : Pcubic R = (3 / 2) * (∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 3
          + 3 * Mp * (1 - ∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 2))
        - (1 / 2) * (∑ u, Bw w (ringW R) u u ^ 3
          + 3 * m * (∑ u, Bw w (ringW R) u u ^ 2 - 3))) {k l : Fin n} (hkl : k ≠ l) :
    w k ⬝ᵥ (Kmat R *ᵥ w l) = 0 := by
  obtain ⟨-, hW⟩ := L52_record_eq R hR hskew hsym w hw hB hunit Mp m hμ hω heq
  have h := hW (Sum.inr k) (Sum.inr l) (fun e => hkl (Sum.inr_injective e))
  have e : Bw w (ringW R) (Sum.inr k) (Sum.inr l) = -(w k ⬝ᵥ (Kmat R *ᵥ w l)) :=
    diag_block R hR hskew hsym (w k) (w l)
  rw [e] at h
  linarith

end HamiltonsCubic.SecondKind
