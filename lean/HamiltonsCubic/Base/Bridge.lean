import HamiltonsCubic.Base.Sharp
import HamiltonsCubic.Base.Curvature

/-!
# B4, the bridge between the two encodings

The layer carries a curvature operator two ways: as a **matrix on the pair
basis**, where the witnesses live and `native_decide` works, and as a **map on
bivectors**, where the structural theorems live and everything is generic in
`n`. B4 makes them meet.

`ofMatrix R` reads the matrix as a map, and the two definitions of each Weyl
condition then agree:

* **Ricci** agrees definitionally, `Ric` was written through `Λ²` for exactly
  this reason, so `RicOf (ofMatrix R) = Ric R` is `rfl`;
* **first Bianchi** agrees by a computation: `bianchiOf` at `(0,1,2,3)` expands
  to `R 0 5 - R 1 4 + R 2 3`, which is `IsBianchi`. The sign comes from
  `φ₃₁ = -φ₁₃`, and the pair-index form hides it.
-/

namespace HamiltonsCubic.Base

open Matrix

/-- A pair-basis matrix, read as a map on bivectors. -/
def ofMatrix (R : Matrix (Fin 6) (Fin 6) ℚ) :
    Matrix (Fin 4) (Fin 4) ℚ → Matrix (Fin 4) (Fin 4) ℚ :=
  fun X => toMat4 (R *ᵥ coord4 X)

/-- **Ricci agrees definitionally.** `Ric` was built through `Λ²` so its signs
come from the basis; that is what makes this `rfl`. -/
theorem RicOf_ofMatrix (R : Matrix (Fin 6) (Fin 6) ℚ) (a b : Fin 4) :
    RicOf (ofMatrix R) a b = Ric R a b := rfl

/-- So Ricci-flatness transfers. -/
theorem isRicciFlat_iff (R : Matrix (Fin 6) (Fin 6) ℚ) :
    IsRicciFlat R ↔ ∀ a b, RicOf (ofMatrix R) a b = 0 := Iff.rfl

/-- **First Bianchi agrees too.** The `Λ²` form at `(0,1,2,3)` is the
pair-index equation, the sign on the middle term coming from `φ₃₁ = -φ₁₃`. -/
theorem bianchiOf_ofMatrix (R : Matrix (Fin 6) (Fin 6) ℚ) :
    bianchiOf (ofMatrix R) 0 1 2 3 = R 5 0 - R 4 1 + R 3 2 := by
  simp [bianchiOf, ofMatrix, inner2, toMat4, coord4, pair4, basis4, phi,
    Matrix.mulVec, dotProduct, Fin.sum_univ_succ, Matrix.single_apply,
    Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
    Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.sum_apply]
  ring

/-- Hence the two readings of `𝒲₄` agree on the conditions the witnesses carry. -/
theorem isBianchi_iff {R : Matrix (Fin 6) (Fin 6) ℚ} (hR : R.IsSymm) :
    IsBianchi R ↔ bianchiOf (ofMatrix R) 0 1 2 3 = 0 := by
  rw [bianchiOf_ofMatrix, ← hR.apply 5 0, ← hR.apply 4 1, ← hR.apply 3 2]
  rfl

end HamiltonsCubic.Base
