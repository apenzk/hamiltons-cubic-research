import HamiltonsCubic.Results.L54Rigid
import HamiltonsCubic.Results.L54Basis

set_option linter.style.longLine false

/-!
# L54's `ψ`-block over `ℝⁿ` is the record's over `𝟏^⊥` with one extra `0`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L54, reads the `ψ`-block over `𝟏^⊥`, the trace-free
diagonal matrices. [L54Basis.lean](L54Basis.lean) computes it over `ℝⁿ`: `diag_block`,
`⟨W̊ diag(u), diag(v)⟩ = −uᵀKv`, and `K_row_sum`, `K𝟏 = 0` at a Ricci-flat `R`. **This file proves the splitting**:

- `null_compress`, `null_zero_eigen` (any real symmetric `B` with `B g = 0`, `g ≠ 0`): **`B = P B P`** with
  `P = 1 − g gᵀ/(g·g)` the orthogonal projector onto `g^⊥` (`projAway_idem`, `projAway_g`), and **one eigenvalue is `0`**;
- `K_compress`, `K_zero_eigen`: at a Ricci-flat `R`, **`K = P K P` with `P` the projector onto `𝟏^⊥`, and `K` has the
  eigenvalue `0` on `𝟏`**, so the `ψ`-block `−K` over `ℝⁿ` is its restriction to `𝟏^⊥` beside `0` on `𝟏`;
- `psi_one_null`: **`⟨W̊ I, diag(v)⟩ = 0` for every `v`**, the extra `0` read on the `ψ`-block itself.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {m : Type*} [Fintype m] [DecidableEq m]

/-- The orthogonal projector onto `g^⊥`. -/
noncomputable def projAway (g : m → ℝ) : Matrix m m ℝ := 1 - (1 / (g ⬝ᵥ g)) • vecMulVec g g

theorem projAway_g (g : m → ℝ) (hg : g ⬝ᵥ g ≠ 0) : projAway g *ᵥ g = 0 := by
  unfold projAway
  rw [Matrix.sub_mulVec, Matrix.one_mulVec, Matrix.smul_mulVec, Matrix.vecMulVec_mulVec]
  ext u; simp; field_simp; ring

theorem projAway_idem (g : m → ℝ) (hg : g ⬝ᵥ g ≠ 0) : projAway g * projAway g = projAway g := by
  have hG : vecMulVec g g * vecMulVec g g = (g ⬝ᵥ g) • vecMulVec g g := by
    rw [Matrix.vecMulVec_mul_vecMulVec]; ext u v; simp [vecMulVec_apply]; ring
  unfold projAway
  rw [Matrix.sub_mul, Matrix.mul_sub, Matrix.mul_sub, Matrix.one_mul, Matrix.mul_one, Matrix.one_mul,
    Matrix.smul_mul, Matrix.mul_smul, hG, smul_smul, smul_smul,
    show 1 / (g ⬝ᵥ g) * (1 / (g ⬝ᵥ g)) * (g ⬝ᵥ g) = 1 / (g ⬝ᵥ g) by field_simp]
  abel

/-- **`B = P B P`** for a symmetric `B` killing `g`. -/
theorem null_compress (B : Matrix m m ℝ) (hB : Bᵀ = B) (g : m → ℝ) (hBg : B *ᵥ g = 0) :
    projAway g * B * projAway g = B := by
  have h2 : g ᵥ* B = 0 := by rw [← Matrix.mulVec_transpose, hB, hBg]
  have hBP : B * projAway g = B := by
    unfold projAway
    rw [Matrix.mul_sub, Matrix.mul_one, Matrix.mul_smul, Matrix.mul_vecMulVec, hBg]; simp
  have hPB : projAway g * B = B := by
    unfold projAway
    rw [Matrix.sub_mul, Matrix.one_mul, Matrix.smul_mul, Matrix.vecMulVec_mul, h2]; simp
  rw [hPB, hBP]

/-- **A symmetric `B` killing a nonzero `g` has the eigenvalue `0`.** -/
theorem null_zero_eigen {B : Matrix m m ℝ} (hA : B.IsHermitian) (g : m → ℝ) (hg : g ≠ 0) (hBg : B *ᵥ g = 0) :
    ∃ k, hA.eigenvalues k = 0 := by
  have hdet : B.det = 0 := Matrix.exists_mulVec_eq_zero_iff.mp ⟨g, hg, hBg⟩
  rw [hA.det_eq_prod_eigenvalues] at hdet
  obtain ⟨k, _, hk⟩ := Finset.prod_eq_zero_iff.mp hdet
  exact ⟨k, by exact_mod_cast hk⟩

variable {n : ℕ}

section K

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))

theorem K_one (hRic : ∀ a b, Ric R a b = 0) : Kmat R *ᵥ (fun _ => (1 : ℝ)) = 0 := by
  ext a; simp only [Matrix.mulVec, dotProduct, mul_one, Pi.zero_apply]; exact K_row_sum R hRic a

include hR hskew hsym in
/-- **`K = P K P`** at a Ricci-flat `R`, `P` the projector onto `𝟏^⊥`. -/
theorem K_compress (hRic : ∀ a b, Ric R a b = 0) :
    projAway (fun _ => (1 : ℝ)) * Kmat R * projAway (fun _ => (1 : ℝ)) = Kmat R := by
  have hT : (Kmat R)ᵀ = Kmat R := by ext a b; exact Kmat_symm R hR hskew hsym b a
  exact null_compress _ hT _ (K_one R hRic)

include hR hskew hsym in
/-- **`K` has the eigenvalue `0`** at a Ricci-flat `R` and `n ≥ 1`. -/
theorem K_zero_eigen (hn : 0 < n) (hRic : ∀ a b, Ric R a b = 0) :
    ∃ k, (Kmat_isHermitian R hR hskew hsym).eigenvalues k = 0 := by
  refine null_zero_eigen _ (fun _ => 1) (fun h => ?_) (K_one R hRic)
  have := congrFun h ⟨0, hn⟩; simp at this

include hR hskew hsym in
/-- **The extra `0` on the `ψ`-block**: `⟨W̊ I, diag(v)⟩ = 0` for every `v` at a Ricci-flat `R`. -/
theorem psi_one_null (hRic : ∀ a b, Ric R a b = 0) (v : Fin n → ℝ) :
    frob (ringW R (Matrix.diagonal (fun _ => (1 : ℝ)))) (Matrix.diagonal v) = 0 := by
  rw [diag_block R hR hskew hsym]
  have hT : (Kmat R)ᵀ = Kmat R := by ext a b; exact Kmat_symm R hR hskew hsym b a
  rw [Matrix.dotProduct_mulVec, ← Matrix.mulVec_transpose, hT, K_one R hRic]
  simp

end K

end HamiltonsCubic.SecondKind
