import Mathlib.Tactic
import HamiltonsCubic.Results.FoxClosedProof

/-!
# The two trace identities, restated on the record's `𝒲ₙ`

[WeylRadical.lean](WeylRadical.lean) proved that `weylModule` is not the record's `𝒲ₙ`: every
clause of `IsWeyl` reads an operator on bivectors alone, so the module also carries every linear
map that kills the bivectors and acts freely on symmetric matrices, a whole `Hom(Sym, M)`.
[r1004](../../../reviews/REVIEW_r1004.md) located the damage in the TRACE, and the two trace
identities of [WeylTraceStatement.lean](../Base/WeylTraceStatement.lean) were stated over that
larger space. **Through `sharpQF`, whose bracket `[η, R φ]` is symmetric when `η` is, the radical
reaches `L e` itself**, so a trace over `weylModule` is a trace of a different operator.

**This file states them on `weylModuleS`**: the Weyl operators that also kill every symmetric
matrix. Restriction to `Λ²` identifies it with the record's `𝒲ₙ`, an operator here being
determined by its values on bivectors. The Fox product is closed on it (`foxClosedS`), because
`compOp` and `sharpOp` both vanish on symmetric inputs once the factors do, so `L e` is an
operator on it (`leftMulS_exists`), with no closure binder since `foxClosed` is proved.

**Typed**: the module, the vanishing of `Qop` and of the Fox product on symmetric inputs,
closure, `L e`. **Both identities are proved downstream**: the first in
[WeylTraceZero.lean](WeylTraceZero.lean), the second, `trace_leftMulS_comp`, in
[WeylTraceSchur.lean](WeylTraceSchur.lean).
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedSectionVars false

/-- Kills every symmetric matrix. -/
def KillsSym (R : CurvLin ι) : Prop := ∀ Z : Matrix ι ι ℝ, Zᵀ = Z → R Z = 0

/-- **The record's `𝒲ₙ`**: Weyl operators that kill the symmetric matrices. -/
def weylModuleS (ι : Type*) [Fintype ι] [DecidableEq ι] : Submodule ℝ (CurvLin ι) :=
  weylModule ι ⊓
    { carrier := {R | KillsSym R}
      zero_mem' := fun _ _ => rfl
      add_mem' := by
        intro R S hR hS Z hZ
        simp [hR Z hZ, hS Z hZ]
      smul_mem' := by
        intro c R hR Z hZ
        simp [hR Z hZ] }

theorem br_sym_skew {Z S : Matrix ι ι ℝ} (hZ : Zᵀ = Z) (hS : IsSkew S) : (br Z S)ᵀ = br Z S := by
  unfold IsSkew at hS
  simp only [br, Matrix.transpose_sub, Matrix.transpose_mul, hZ, hS, Matrix.neg_mul,
    Matrix.mul_neg]
  abel

theorem inner2_sym_skew {A S : Matrix ι ι ℝ} (hA : Aᵀ = A) (hS : IsSkew S) : inner2 A S = 0 := by
  unfold IsSkew at hS
  have h : trace (A * S) = trace ((A * S)ᵀ) := (Matrix.trace_transpose _).symm
  rw [Matrix.transpose_mul, hA, hS, Matrix.neg_mul, Matrix.trace_neg, Matrix.trace_mul_comm] at h
  simp only [inner2, hA]
  rw [Matrix.trace_mul_comm A S]
  linarith

theorem br_add_left' (Z η W : Matrix ι ι ℝ) : br (Z + η) W = br Z W + br η W := by
  simp only [br, Matrix.add_mul, Matrix.mul_add]; abel

theorem inner2_add_left'' (A B C : Matrix ι ι ℝ) : inner2 (A + B) C = inner2 A C + inner2 B C := by
  simp only [inner2, Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring

/-- **A symmetric shift is invisible to `sharpQF`** when `R` kills symmetric matrices and maps
bivectors to bivectors. -/
theorem sharpQF_add_sym (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hadd : ∀ X Y, R (X + Y) = R X + R Y)
    (hsk : ∀ X, IsSkew X → IsSkew (R X)) (hK : ∀ Z, Zᵀ = Z → R Z = 0)
    {Z η : Matrix ι ι ℝ} (hZ : Zᵀ = Z) (hη : IsSkew η) :
    sharpQF R (Z + η) = sharpQF R η := by
  unfold sharpQF
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  have hRφ : IsSkew (R (phi i j)) := hsk _ (phi_isSkew i j)
  have hK1 : R (br Z (R (phi i j))) = 0 := hK _ (br_sym_skew hZ hRφ)
  have hsk2 : IsSkew (R (br η (R (phi i j)))) := hsk _ (br_isSkew_real _ _ hη hRφ)
  rw [br_add_left' Z η (R (phi i j)), hadd, hK1, zero_add,
    br_add_left' Z η (R (br η (R (phi i j)))), inner2_add_left'',
    inner2_sym_skew (br_sym_skew hZ hsk2) (phi_isSkew i j), zero_add]

theorem sharpQF_sym (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hadd : ∀ X Y, R (X + Y) = R X + R Y)
    (hsk : ∀ X, IsSkew X → IsSkew (R X)) (hK : ∀ Z, Zᵀ = Z → R Z = 0)
    {Z : Matrix ι ι ℝ} (hZ : Zᵀ = Z) : sharpQF R Z = 0 := by
  have h0 : IsSkew (0 : Matrix ι ι ℝ) := by simp [IsSkew]
  have := sharpQF_add_sym R hadd hsk hK hZ h0
  rw [add_zero] at this
  rw [this]; simp [sharpQF, br, inner2]

/-- **`Q(R)` vanishes on symmetric inputs.** -/
theorem Qop_sym (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hadd : ∀ X Y, R (X + Y) = R X + R Y)
    (hsk : ∀ X, IsSkew X → IsSkew (R X)) (hK : ∀ Z, Zᵀ = Z → R Z = 0)
    {Z : Matrix ι ι ℝ} (hZ : Zᵀ = Z) : Qop R Z = 0 := by
  have hR0 : R 0 = 0 := hK 0 (by simp)
  have hsb : ∀ i j, sharpBil R Z (phi i j) = 0 := by
    intro i j
    unfold sharpBil
    rw [sharpQF_add_sym R hadd hsk hK hZ (phi_isSkew i j), sharpQF_sym R hadd hsk hK hZ]
    ring
  simp only [Qop, compOp, sharpOp, hK Z hZ, hR0, hsb, zero_smul, Finset.sum_const_zero,
    smul_zero, add_zero]

theorem mem_S_parts {R : CurvLin ι} (hR : R ∈ weylModuleS ι) :
    (∀ X, IsSkew X → IsSkew (R X)) ∧ KillsSym R :=
  ⟨hR.1.1, hR.2⟩

/-- **The Fox product of two members vanishes on symmetric inputs.** -/
theorem foxProd_sym {X Y : CurvLin ι} (hX : X ∈ weylModuleS ι) (hY : Y ∈ weylModuleS ι)
    {Z : Matrix ι ι ℝ} (hZ : Zᵀ = Z) :
    foxProd (fun A => X A) (fun A => Y A) Z = 0 := by
  obtain ⟨hXs, hXk⟩ := mem_S_parts hX
  obtain ⟨hYs, hYk⟩ := mem_S_parts hY
  have hsum_sk : ∀ A, IsSkew A → IsSkew (X A + Y A) := by
    intro A hA
    have h1 := hXs A hA; have h2 := hYs A hA
    unfold IsSkew at *; rw [Matrix.transpose_add, h1, h2, neg_add]
  have e1 := Qop_sym (fun A => X A + Y A) (fun A B => by simp only [map_add]; abel) hsum_sk
    (fun A hA => by simp [hXk A hA, hYk A hA]) hZ
  have e2 := Qop_sym (fun A => X A) (fun A B => map_add X A B) hXs hXk hZ
  have e3 := Qop_sym (fun A => Y A) (fun A B => map_add Y A B) hYs hYk hZ
  unfold foxProd
  have : ((fun A => X A) + fun A => Y A) = fun A => X A + Y A := rfl
  rw [this, e1, e2, e3]; simp

/-- **Closure on the record's `𝒲ₙ`.** -/
theorem foxClosedS (X Y : CurvLin ι) (hX : X ∈ weylModuleS ι) (hY : Y ∈ weylModuleS ι) :
    ∃ W : CurvLin ι, W ∈ weylModuleS ι ∧
      ∀ Z : Matrix ι ι ℝ, foxProd (fun A => X A) (fun A => Y A) Z = W Z := by
  obtain ⟨W, hW, hWeq⟩ := foxClosed X Y hX.1 hY.1
  refine ⟨W, ⟨hW, fun Z hZ => ?_⟩, hWeq⟩
  show W Z = 0
  rw [← hWeq]; exact foxProd_sym hX hY hZ

/-- **`L e` on the record's `𝒲ₙ`**, unconditionally. -/
theorem leftMulS_exists (e : CurvLin ι) (he : e ∈ weylModuleS ι) :
    ∃ L : weylModuleS ι →ₗ[ℝ] weylModuleS ι,
      ∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
        (L Y : CurvLin ι) Z = foxProd (fun A => e A) (fun A => (Y : CurvLin ι) A) Z := by
  have hel : IsLinOp (fun A => e A) := ⟨fun X Y => e.map_add X Y, fun c X => e.map_smul c X⟩
  have hl : ∀ Y : weylModuleS ι, IsLinOp (fun A => (Y : CurvLin ι) A) :=
    fun Y => ⟨fun X W => (Y : CurvLin ι).map_add X W, fun c X => (Y : CurvLin ι).map_smul c X⟩
  choose W hW hWeq using fun Y : weylModuleS ι => foxClosedS e Y he Y.2
  refine ⟨{ toFun := fun Y => ⟨W Y, hW Y⟩, map_add' := ?_, map_smul' := ?_ },
    fun Y Z => (hWeq Y Z).symm⟩
  · intro Y1 Y2
    apply Subtype.ext; apply LinearMap.ext; intro Z
    show W (Y1 + Y2) Z = W Y1 Z + W Y2 Z
    rw [← hWeq, ← hWeq, ← hWeq]
    exact foxProd_add_right _ _ _ hel (hl Y1) (hl Y2) Z
  · intro c Y
    apply Subtype.ext; apply LinearMap.ext; intro Z
    show W (c • Y) Z = c • W Y Z
    rw [← hWeq, ← hWeq]
    exact foxProd_smul_right c _ _ hel (hl Y) Z

/-! **`tr (L e) = 0` is PROVED**, as `trace_leftMulS_eq_zero'` in
[WeylTraceZero.lean](WeylTraceZero.lean), by orthogonal equivariance and averaging over signed
permutations. -/

/-! **`tr (L e ∘ L f) = κ ⟨e, f⟩` is PROVED**, as `trace_leftMulS_comp` in
[WeylTraceSchur.lean](WeylTraceSchur.lean), with ONE constant for every pair, quantified OUTSIDE the
pair. *A statement taking `kappa` as a parameter asserts the identity for every `κ` and is false at
any `e = f ≠ 0` ([r1116](../../../reviews/REVIEW_r1116.md), typed at `Fin 4`).* -/

end HamiltonsCubic.Results
