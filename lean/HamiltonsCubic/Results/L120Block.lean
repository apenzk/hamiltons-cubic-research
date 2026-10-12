import HamiltonsCubic.Results.WeylFoxEquivariance
import HamiltonsCubic.Base.FoxBilinear

set_option linter.style.longLine false

/-!
# L120: `L_M` preserves every sign-isotypic subspace at a diagonal `M`

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: *let `Γ` be the full diagonal sign group.
At every diagonal `M` (criticality is unused; `Γ`-equivariance needs only that `M` is `Γ`-fixed) the operator
`L_M` preserves each summand* of the `Γ`-isotypic decomposition. **This file proves the equivariance route**:

- `signMat ε = diag(ε)` with `ε_i² = 1` is orthogonal (`signMat_orth`);
- `diagLin w`, the diagonal operator `X ↦ w ∘ X` as a linear map, is **`Γ`-fixed** (`act_signMat_diag`);
- `L120_block`: **at every `Γ`-fixed `M`, if `X` transforms by a character `c` of `Γ`, so does `M ∘ X`**, from
  [WeylFoxEquivariance.lean](WeylFoxEquivariance.lean)'s `foxProd_act`; and `L120_block_diag` at `M = diagLin w`.

So `L_M` maps each isotypic subspace `{X : g·X = c(g) X ∀ g ∈ Γ}` into itself, for every character `c`.
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The sign matrix `diag(ε)`. -/
def signMat (ε : ι → ℝ) : Matrix ι ι ℝ := Matrix.diagonal ε

theorem signMat_orth (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    (signMat ε)ᵀ * signMat ε = 1 ∧ signMat ε * (signMat ε)ᵀ = 1 := by
  unfold signMat
  rw [Matrix.diagonal_transpose, Matrix.diagonal_mul_diagonal]
  have : (fun i => ε i * ε i) = fun _ => (1 : ℝ) := funext hε
  rw [this, Matrix.diagonal_one]; exact ⟨rfl, rfl⟩

/-- The diagonal operator `X ↦ w ∘ X` (entrywise), as a linear map. -/
def diagLin (w : Matrix ι ι ℝ) : CurvLin ι where
  toFun X := Matrix.of fun a b => w a b * X a b
  map_add' X Y := by ext a b; simp [mul_add]
  map_smul' c X := by ext a b; simp; ring

/-- `diagLin w` is [Families.lean](../Base/Families.lean)'s `diagOp w`. -/
theorem diagLin_eq (w : Matrix ι ι ℝ) : (fun A => diagLin w A) = HamiltonsCubic.FamilyLayer.diagOp w := rfl

/-- **A diagonal operator is `Γ`-fixed.** -/
theorem act_signMat_diag (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) (w : Matrix ι ι ℝ) :
    act (signMat ε) (diagLin w) = diagLin w := by
  apply LinearMap.ext; intro Z
  rw [act_apply]
  ext a b
  simp only [signMat, Matrix.diagonal_transpose, Matrix.diagonal_mul, Matrix.mul_diagonal, diagLin,
    LinearMap.coe_mk, AddHom.coe_mk, Matrix.of_apply]
  have ha := hε a; have hb := hε b
  calc ε a * (w a b * (ε a * Z a b * ε b)) * ε b = (ε a * ε a) * (ε b * ε b) * (w a b * Z a b) := by ring
    _ = w a b * Z a b := by rw [ha, hb]; ring

/-- **L120's block-diagonality**: at a `Γ`-fixed `M`, if `X` transforms by `c` under every sign conjugation,
then so does `M ∘ X`. -/
theorem L120_block (M X : CurvLin ι) (c : (ι → ℝ) → ℝ)
    (hM : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) M = M)
    (hX : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) X = c ε • X)
    (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) (Z : Matrix ι ι ℝ) :
    signMat ε * foxProd (fun A => M A) (fun A => X A) ((signMat ε)ᵀ * Z * signMat ε) * (signMat ε)ᵀ
      = c ε • foxProd (fun A => M A) (fun A => X A) Z := by
  obtain ⟨hg, hg'⟩ := signMat_orth ε hε
  rw [← foxProd_act (signMat ε) hg hg' M X Z, hM ε hε, hX ε hε]
  have hMl : IsLinOp (fun A => M A) := ⟨fun _ _ => map_add M _ _, fun _ _ => map_smul M _ _⟩
  have hXl : IsLinOp (fun A => X A) := ⟨fun _ _ => map_add X _ _, fun _ _ => map_smul X _ _⟩
  have e : (fun A => (c ε • X) A) = fun A => c ε • X A := by funext A; rfl
  rw [e, foxProd_smul_right _ _ _ hMl hXl]

/-- **At a diagonal `M = diagLin w`**, `L_M` preserves every sign-isotypic subspace. -/
theorem L120_block_diag (w : Matrix ι ι ℝ) (X : CurvLin ι) (c : (ι → ℝ) → ℝ)
    (hX : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) X = c ε • X)
    (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) (Z : Matrix ι ι ℝ) :
    signMat ε * foxProd (fun A => diagLin w A) (fun A => X A) ((signMat ε)ᵀ * Z * signMat ε) * (signMat ε)ᵀ
      = c ε • foxProd (fun A => diagLin w A) (fun A => X A) Z :=
  L120_block (diagLin w) X c (fun ε hε => act_signMat_diag ε hε w) hX ε hε Z

end HamiltonsCubic.Results
