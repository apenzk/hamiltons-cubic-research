import Mathlib
import HamiltonsCubic.Results.L120Ident
import HamiltonsCubic.Results.L120DiagDim

set_option linter.style.longLine false

/-!
# L120, the trivial block of $W^\perp$ on `CurvOp2` has dimension $n(n-3)/2-1$

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: the trivial block of the decomposition is
$\mathcal D_n$, of dimension $n(n-3)/2$, and $W^\perp$ cuts it by $\langle M\rangle$ alone.
[L120DiagDim.lean](L120DiagDim.lean) counts $\mathcal D_n$ on bivector-level operators and
[L120Ident.lean](L120Ident.lean) identifies the trivial block on `CurvOp2` with the diagonal operators of weights.
This file counts the block on `CurvOp2`:

* `weightOp2`, $w\mapsto$ `restrict (diagOp w)` on the weights, linear and injective (`weightOp2_injective`, read at
  $\varphi_{ab}$'s $(b,a)$ entry);
* `mem_range_weightOp2`: its range is the trivial block, the sign-fixed Weyl operators on $\Lambda^2$;
* **`finrank_perp`**: at a nonzero $M$ in the block, the block's intersection with $M^\perp$ has dimension
  $\binom n2-n-1$, which is $n(n-3)/2-1$ (`two_mul_choose_two_sub`), and `mem_perp` names its members.
-/

namespace HamiltonsCubic.L120DimPerp

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results
  HamiltonsCubic.L120Hess HamiltonsCubic.FamilyLayer HamiltonsCubic.L120Ident

variable {n : ℕ}

/-- **The weights, as operators on `Λ²`.** -/
noncomputable def weightOp2 : LinearMap.ker (rowSumL (ι := Fin n)) →ₗ[ℝ] CurvOp2 (Fin n) where
  toFun w := RealLayer.restrict (diagOp_isWeyl (isWeight_of_ker w))
  map_add' w v := ContinuousLinearMap.ext fun X => Subtype.ext (by
    show diagOp (((w + v : LinearMap.ker (rowSumL (ι := Fin n))) : symHollow (Fin n)) : Matrix (Fin n) (Fin n) ℝ) X
      = diagOp ((w : symHollow (Fin n)) : Matrix (Fin n) (Fin n) ℝ) X
        + diagOp ((v : symHollow (Fin n)) : Matrix (Fin n) (Fin n) ℝ) X
    ext p q
    simp [diagOp, add_mul])
  map_smul' c w := ContinuousLinearMap.ext fun X => Subtype.ext (by
    show diagOp (((c • w : LinearMap.ker (rowSumL (ι := Fin n))) : symHollow (Fin n)) : Matrix (Fin n) (Fin n) ℝ) X
      = c • diagOp ((w : symHollow (Fin n)) : Matrix (Fin n) (Fin n) ℝ) X
    ext p q
    simp [diagOp, mul_assoc])

theorem weightOp2_apply (w : LinearMap.ker (rowSumL (ι := Fin n))) (X : skewSub (Fin n)) :
    ((weightOp2 w X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = diagOp ((w : symHollow (Fin n)) : Matrix (Fin n) (Fin n) ℝ) (X : Matrix (Fin n) (Fin n) ℝ) := rfl

theorem weightOp2_injective : Function.Injective (weightOp2 (n := n)) := by
  intro w v h
  have hw := isWeight_of_ker w
  have hv := isWeight_of_ker v
  apply Subtype.ext
  apply Subtype.ext
  ext a b
  by_cases hab : a = b
  · subst hab
    rw [hw.hollow a, hv.hollow a]
  · have e := congrArg
      (fun V : CurvOp2 (Fin n) => ((V ⟨phi a b, phi_mem_skewSub a b⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) b a) h
    simp only [weightOp2_apply] at e
    rw [diagOp_phi _ hw.symm, diagOp_phi _ hv.symm] at e
    simpa [phi, Matrix.single_apply, hab, Ne.symm hab] using e

/-- **The range of the weights is the trivial block.** -/
theorem mem_range_weightOp2 (V : CurvOp2 (Fin n)) (hV : IsWeyl2 V) :
    V ∈ LinearMap.range (weightOp2 (n := n)) ↔ SignChar (fun _ => 1) V := by
  rw [trivial_block_iff V hV]
  constructor
  · rintro ⟨w, rfl⟩
    exact ⟨_, isWeight_of_ker w, rfl⟩
  · rintro ⟨w, hw, rfl⟩
    exact ⟨⟨⟨w, hw.symm, hw.hollow⟩, LinearMap.mem_ker.mpr (funext hw.rowSum)⟩, rfl⟩

/-- `⟨M, ·⟩` as a linear functional. -/
noncomputable def innerOp2L (M : CurvOp2 (Fin n)) : CurvOp2 (Fin n) →ₗ[ℝ] ℝ where
  toFun V := innerOp2 M V
  map_add' V V' := innerOp2_add_right M V V'
  map_smul' c V := by rw [innerOp2_smul_right, smul_eq_mul, RingHom.id_apply]

/-- The weights whose operator is orthogonal to `M`. -/
noncomputable abbrev perpW (M : CurvOp2 (Fin n)) : Submodule ℝ (LinearMap.ker (rowSumL (ι := Fin n))) :=
  LinearMap.ker ((innerOp2L M).comp weightOp2)

/-- **The members of the trivial block orthogonal to `M`.** -/
theorem mem_perp (M V : CurvOp2 (Fin n)) (hV : IsWeyl2 V) :
    V ∈ (perpW M).map weightOp2 ↔ SignChar (fun _ => 1) V ∧ innerOp2 M V = 0 := by
  constructor
  · rintro ⟨w, hw, rfl⟩
    exact ⟨(mem_range_weightOp2 _ hV).mp ⟨w, rfl⟩, hw⟩
  · rintro ⟨hs, h0⟩
    obtain ⟨w, rfl⟩ := (mem_range_weightOp2 V hV).mpr hs
    exact ⟨w, h0, rfl⟩

/-- **`dim(𝒟ₙ ∩ M^⊥) = C(n,2) − n − 1`** on `CurvOp2`, at every nonzero `M` in the trivial block. -/
theorem finrank_perp (hn : 3 ≤ n) (w0 : LinearMap.ker (rowSumL (ι := Fin n))) (h0 : weightOp2 w0 ≠ 0) :
    Module.finrank ℝ ((perpW (weightOp2 w0)).map weightOp2) = n.choose 2 - n - 1 := by
  rw [← LinearEquiv.finrank_eq (Submodule.equivMapOfInjective (weightOp2 (n := n)) weightOp2_injective
    (perpW (weightOp2 w0)))]
  set h := (innerOp2L (weightOp2 w0)).comp weightOp2 with hdef
  have hpos : 0 < h w0 := by
    show 0 < innerOp2 (weightOp2 w0) (weightOp2 w0)
    rcases (normSq2_nonneg (weightOp2 w0)).lt_or_eq with hlt | heq
    · exact hlt
    · exact absurd (normSq2_eq_zero heq.symm) h0
  have hsurj : LinearMap.range h = ⊤ := LinearMap.range_eq_top.mpr fun r =>
    ⟨(r / h w0) • w0, by rw [map_smul, smul_eq_mul, div_mul_cancel₀ _ hpos.ne']⟩
  have hrn := LinearMap.finrank_range_add_finrank_ker (K := ℝ) (V := LinearMap.ker (rowSumL (ι := Fin n))) h
  rw [hsurj, finrank_top, Module.finrank_self, finrank_weights (by simpa using hn), Fintype.card_fin] at hrn
  have hk : Module.finrank ℝ (perpW (weightOp2 w0)) = Module.finrank ℝ (LinearMap.ker h) := rfl
  omega

end HamiltonsCubic.L120DimPerp
