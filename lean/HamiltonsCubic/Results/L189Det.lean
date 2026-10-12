import Mathlib
import HamiltonsCubic.Results.L186Rank

/-!
# L189's determinant step

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L189, closes the two-non-decomposable case by
`det(NNᵀ) = Pf(N)⁴ = Pf(M)⁴ = det(MMᵀ)` against Ricci-flatness `NNᵀ = MMᵀ + |λ₃| Π₃`, and the step that
makes the two incompatible is: **a nonzero positive-semidefinite bump on a positive-definite matrix strictly
raises the determinant.**

Proved here, over `ℝ` at every size:

* **`one_lt_det_one_add`**: `det(1 + P) > 1` for `P` positive semidefinite and nonzero, from the spectral
  theorem, `det(1 + P) = ∏ (1 + μᵢ)` with every `μᵢ ≥ 0` and one positive;
* **`det_lt_det_add`**: `det A < det(A + B)` for `A` positive definite and `B` positive semidefinite and
  nonzero, by writing `B = CᵀC` and the matrix determinant lemma, `det(A + CᵀC) = det A · det(1 + CA⁻¹Cᵀ)`;
* **`L189_core`**: the contradiction itself at every size. If `det N² = det M²`, `M` is invertible and
  `NNᵀ = MMᵀ + B` with `B` positive semidefinite and nonzero, then `False`;
* **`L189_four`**: at `dim V = 4`, where the Pfaffian is explicit, `N ∧ N = M ∧ M` gives `det N = det M`
  through [L186Rank.lean](L186Rank.lean)'s `det_skew4`, so the core applies.

**What stays with the record.** At `dim V = 2m` with `m` even and above `2`, the step `N ∧ N = M ∧ M ⇒
Pf N = Pf M` runs through `N^{∧m} = (N ∧ N)^{∧(m/2)}`, which needs the Pfaffian as a top wedge power, and the
layer has neither. The invertibility of `M` is [L188](../../../findings/diagonal-half.md)(1)'s full rank at
`dim V = 8`, and at general even `m` needs L180(3) with the same Pfaffian step. It enters `L189_core` as a
hypothesis, as do the linearised Ricci and Bianchi equations, whose reduction from the Weyl tensor is the
record's.
-/

namespace HamiltonsCubic.L189Det

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **`det(1 + P) > 1`** for a nonzero positive-semidefinite `P`. -/
theorem one_lt_det_one_add {P : Matrix n n ℝ} (hP : P.PosSemidef) (h0 : P ≠ 0) : 1 < (1 + P).det := by
  have hH := hP.isHermitian
  have hspec := hH.spectral_theorem
  set U := hH.eigenvectorUnitary
  set μ := hH.eigenvalues
  have h1P : 1 + P = (U : Matrix n n ℝ) * diagonal (fun i => 1 + μ i) * star (U : Matrix n n ℝ) := by
    conv_lhs => rw [hspec]
    rw [Unitary.conjStarAlgAut_apply]
    have hUU : (U : Matrix n n ℝ) * star (U : Matrix n n ℝ) = 1 := Unitary.mul_star_self_of_mem U.2
    have : diagonal (fun i => 1 + μ i) = 1 + diagonal (RCLike.ofReal ∘ μ) := by
      rw [← diagonal_one, diagonal_add]; rfl
    rw [this, Matrix.mul_add, Matrix.add_mul, Matrix.mul_one, hUU]
  have hdet : (1 + P).det = ∏ i, (1 + μ i) := by
    rw [h1P, det_mul, det_mul, det_diagonal, mul_comm, ← mul_assoc, ← det_mul,
      Unitary.star_mul_self_of_mem U.2, det_one, one_mul]
  have hnn : ∀ i, 0 ≤ μ i := hP.eigenvalues_nonneg
  obtain ⟨i0, hi0⟩ : ∃ i, μ i ≠ 0 := by
    by_contra h
    push Not at h
    exact h0 (hH.eigenvalues_eq_zero_iff.mp (funext h))
  have hpos : 0 < μ i0 := lt_of_le_of_ne (hnn i0) (Ne.symm hi0)
  rw [hdet, ← Finset.mul_prod_erase _ _ (Finset.mem_univ i0)]
  have hrest : 1 ≤ ∏ i ∈ Finset.univ.erase i0, (1 + μ i) := by
    have := Finset.prod_le_prod (s := Finset.univ.erase i0) (f := fun _ => (1 : ℝ)) (g := fun i => 1 + μ i)
      (fun i _ => zero_le_one) (fun i _ => by linarith [hnn i])
    simpa using this
  nlinarith

/-- **A nonzero positive-semidefinite bump strictly raises a positive-definite determinant.** -/
theorem det_lt_det_add {A B : Matrix n n ℝ} (hA : A.PosDef) (hB : B.PosSemidef) (hB0 : B ≠ 0) :
    A.det < (A + B).det := by
  obtain ⟨C, rfl⟩ : ∃ C : Matrix n n ℝ, B = star C * C := by
    open scoped MatrixOrder in
    exact CStarAlgebra.nonneg_iff_eq_star_mul_self.mp hB.nonneg
  have hAu : IsUnit A.det := (hA.det_pos).ne'.isUnit
  rw [det_add_mul (star C) C hAu]
  set P := C * A⁻¹ * star C with hPdef
  have hPpsd : P.PosSemidef := by
    have := hA.inv.posSemidef.mul_mul_conjTranspose_same C
    simpa [hPdef, star_eq_conjTranspose] using this
  have hP0 : P ≠ 0 := by
    intro hP
    apply hB0
    have hCt : star C = 0 := by
      ext i j
      have hx := congrArg (fun M => star (Pi.single j (1 : ℝ)) ⬝ᵥ M *ᵥ Pi.single j 1) hP
      simp only [hPdef, zero_mulVec, dotProduct_zero] at hx
      rw [← mulVec_mulVec, ← mulVec_mulVec, dotProduct_mulVec] at hx
      have hv : star (Pi.single j (1 : ℝ)) ᵥ* C = star (star C *ᵥ Pi.single j 1) := by
        rw [star_mulVec, star_eq_conjTranspose, conjTranspose_conjTranspose]
      rw [hv] at hx
      by_contra hne
      have hw : star C *ᵥ Pi.single j 1 ≠ 0 := by
        intro h
        apply hne
        have := congrFun h i
        simpa [mulVec, dotProduct, Pi.single_apply] using this
      exact (hA.inv.dotProduct_mulVec_pos hw).ne' hx
    rw [hCt, zero_mul]
  have h1 := one_lt_det_one_add hPpsd hP0
  have hd := hA.det_pos
  nlinarith

/-- **L189's contradiction, at every size**: equal squared determinants are incompatible with
`NNᵀ = MMᵀ + B` once `M` is invertible and `B` is a nonzero positive-semidefinite bump. -/
theorem L189_core {N M B : Matrix n n ℝ} (hdet : N.det ^ 2 = M.det ^ 2) (hM : IsUnit M.det)
    (hB : B.PosSemidef) (hB0 : B ≠ 0) (hric : N * Nᵀ = M * Mᵀ + B) : False := by
  have hMM : (M * Mᵀ).PosDef := by
    have := (Matrix.PosDef.one (n := n) (R := ℝ)).mul_mul_conjTranspose_same (B := M)
      (Matrix.vecMul_injective_iff_isUnit.mpr ((Matrix.isUnit_iff_isUnit_det M).mpr hM))
    rw [Matrix.mul_one] at this
    simpa [star_eq_conjTranspose] using this
  have hlt := det_lt_det_add hMM hB hB0
  rw [← hric, det_mul, det_mul, det_transpose, det_transpose, ← sq, ← sq, hdet] at hlt
  exact lt_irrefl _ hlt

/-- **L189 at `dim V = 4`**: two skew forms with `N ∧ N = M ∧ M`, `M` invertible, cannot satisfy
`NNᵀ = MMᵀ + B` with `B` a nonzero positive-semidefinite bump. -/
theorem L189_four {N M B : Matrix (Fin 4) (Fin 4) ℝ} (hN : Nᵀ = -N) (hMs : Mᵀ = -M)
    (hbianchi : HamiltonsCubic.SelfDualLayer.wedgeSelf N 0 1 2 3 = HamiltonsCubic.SelfDualLayer.wedgeSelf M 0 1 2 3)
    (hM : IsUnit M.det) (hB : B.PosSemidef) (hB0 : B ≠ 0) (hric : N * Nᵀ = M * Mᵀ + B) : False := by
  have hpf : N 0 1 * N 2 3 - N 0 2 * N 1 3 + N 0 3 * N 1 2 = M 0 1 * M 2 3 - M 0 2 * M 1 3 + M 0 3 * M 1 2 := by
    simp only [HamiltonsCubic.SelfDualLayer.wedgeSelf, HamiltonsCubic.SelfDualLayer.wedge2,
      HamiltonsCubic.SelfDualLayer.halfw, Pi.add_apply] at hbianchi
    linarith
  refine L189_core (N := N) (M := M) ?_ hM hB hB0 hric
  rw [HamiltonsCubic.L186Proof.det_skew4 N hN, HamiltonsCubic.L186Proof.det_skew4 M hMs, hpf]

end HamiltonsCubic.L189Det
