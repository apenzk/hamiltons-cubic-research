import HamiltonsCubic.Results.L17WeylUpper
import HamiltonsCubic.Results.L17Converse

set_option linter.style.longLine false

/-!
# The bivector model of `𝒲ₙ ∩ T_uS` is the layer's

[L17WeylDim.lean](L17WeylDim.lean) and [L17WeylUpper.lean](L17WeylUpper.lean) count `weylT`, the tangent Weyl operators
in the bivector model. This file identifies it with the layer's own tangent Weyl operators, `IsWeyl2` operators on skew
matrices orthogonal to the padded competitor `u₂`.

- `ofB`, `coords_ofB`, `opB_ofB`, `ofB_opB`, **`opBEquiv`**: `opB` is a linear equivalence between `CurvOp2 (Fin n)` and
  operators on `Λ²ℝⁿ`, with inverse `H ↦ (X ↦ toSkew (H (coords X)))`;
- **`opB_mem_weylT`**, **`isWeyl2_ofB`**: `opB` carries a tangent `IsWeyl2` operator into `weylT`, and `ofB` carries
  `weylT` back, through `compOf_opB` and `innerOp2_eq_trace`;
- `weylT2`, **`mem_weylT2`**: the preimage of `weylT` is exactly `{R | IsWeyl2 R ∧ ⟨R, u₂⟩ = 0}`;
- **`finrank_weylT2_12`**: `dim 𝒲₁₂ ∩ T_uS = 1637` for the layer's Weyl operators;
- **`F_zero_proper`**, `L17_proper_12`: `{F = 0}` is a proper subspace of `𝒲ₙ ∩ T_uS` at every `n ≥ 4`, through
  [L17Converse.lean](L17Converse.lean)'s witness, so `dim {F = 0} < 1637` at `n = 12`, against
  [L17WeylDim.lean](L17WeylDim.lean)'s `L17_dim_12` lower bound `1451`.
-/

namespace HamiltonsCubic.L17Deriv

open Module HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.SpectralFn HamiltonsCubic.BivModel

variable {n : ℕ}

/-- The operator on skew matrices of an operator on `Λ²ℝⁿ`: `X ↦ toSkew (H (coords X))`. -/
noncomputable def ofB (H : Biv n →ₗ[ℝ] Biv n) : CurvOp2 (Fin n) :=
  LinearMap.toContinuousLinearMap (toSkew ∘ₗ H ∘ₗ coordsL ∘ₗ (skewSub (Fin n)).subtype)

theorem ofB_apply (H : Biv n →ₗ[ℝ] Biv n) (X : skewSub (Fin n)) :
    ofB H X = toSkew (H (coords (X : Matrix (Fin n) (Fin n) ℝ))) := rfl

theorem coords_ofB (H : Biv n →ₗ[ℝ] Biv n) (X : skewSub (Fin n)) :
    coords ((ofB H X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = H (coords (X : Matrix (Fin n) (Fin n) ℝ)) := by
  rw [ofB_apply, coords_toSkew]

theorem opB_ofB (H : Biv n →ₗ[ℝ] Biv n) : opB (ofB H) = H := by
  refine LinearMap.ext fun c => ?_
  rw [opB_apply, coords_ofB, coords_toSkew]

theorem ofB_opB (R : CurvOp2 (Fin n)) : ofB (opB R) = R := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [ofB_apply, opB_apply]
  have hX : toSkew (coords (X : Matrix (Fin n) (Fin n) ℝ)) = X := Subtype.ext (toSkew_coords X.2)
  rw [hX]
  exact toSkew_coords (R X).2

/-- **`opB` is a linear equivalence** between the layer's operators on skew matrices and operators on `Λ²ℝⁿ`. -/
noncomputable def opBEquiv : CurvOp2 (Fin n) ≃ₗ[ℝ] (Biv n →ₗ[ℝ] Biv n) where
  toFun := opB
  invFun := ofB
  map_add' R S := by simpa using opB_add_smul R S 1
  map_smul' c R := by
    refine LinearMap.ext fun x => ?_
    simp only [opB_apply, LinearMap.smul_apply, smul_apply, Submodule.coe_smul, ← coordsL_apply,
      map_smul, RingHom.id_apply]
  left_inv := ofB_opB
  right_inv := opB_ofB

/-- A tangent Weyl operator of the layer is in `weylT`. -/
theorem opB_mem_weylT (hn : 4 ≤ n) {R : CurvOp2 (Fin n)} (hR : IsWeyl2 R) (hT : innerOp2 R (u2 hn) = 0) :
    opB R ∈ weylT n := by
  refine ⟨opB_isSymmetric hR.selfAdjoint, alt4_opB_eq_zero hR, ?_, ?_⟩
  · funext a b
    simp only [ric, compOf_opB, Pi.zero_apply]
    exact hR.ric a b
  · rw [innerOp2_eq_trace hR.selfAdjoint, opB_u2] at hT; exact hT

/-- An operator in `weylT` comes from a tangent Weyl operator of the layer. -/
theorem isWeyl2_ofB (hn : 4 ≤ n) {H : Biv n →ₗ[ℝ] Biv n} (hH : H ∈ weylT n) :
    IsWeyl2 (ofB H) ∧ innerOp2 (ofB H) (u2 hn) = 0 := by
  obtain ⟨hS, hA, hR, hT⟩ := hH
  have hc : ∀ i j k l, inner2 (applyPhi (ofB H) i j) (phi k l) = compOf H i j k l := fun i j k l => by
    rw [← compOf_opB, opB_ofB]
  have hsa : IsSelfAdjoint2 (ofB H) := fun X Y => by
    rw [← inner_coords (ofB H X).2 Y.2, ← inner_coords X.2 (ofB H Y).2, coords_ofB, coords_ofB, hS]
  refine ⟨⟨hsa, fun i j k l => ?_, fun a b => ?_⟩, ?_⟩
  · rw [hc, hc, hc]
    have := congrFun (congrFun (congrFun (congrFun hA i) j) k) l
    simp only [alt4, Pi.zero_apply] at this
    linarith
  · simp only [hc]
    exact congrFun (congrFun hR a) b
  · rw [innerOp2_eq_trace hsa, opB_ofB, opB_u2]; exact hT

/-- **The layer's tangent Weyl operators**, as a subspace of `CurvOp2`: the preimage of `weylT` under `opB`. -/
noncomputable def weylT2 (n : ℕ) : Submodule ℝ (CurvOp2 (Fin n)) :=
  (weylT n).map ((opBEquiv (n := n)).symm : (Biv n →ₗ[ℝ] Biv n) →ₗ[ℝ] CurvOp2 (Fin n))

theorem mem_weylT2 (hn : 4 ≤ n) (R : CurvOp2 (Fin n)) :
    R ∈ weylT2 n ↔ IsWeyl2 R ∧ innerOp2 R (u2 hn) = 0 := by
  rw [weylT2, Submodule.mem_map_equiv, LinearEquiv.symm_symm]
  refine ⟨fun h => ?_, fun ⟨hR, hT⟩ => opB_mem_weylT hn hR hT⟩
  have := isWeyl2_ofB hn h
  rwa [show ofB (opBEquiv R) = R from ofB_opB R] at this

/-- **`dim 𝒲₁₂ ∩ T_uS = 1637`** for the layer's own Weyl operators. -/
theorem finrank_weylT2_12 : finrank ℝ (weylT2 12) = 1637 := by
  rw [weylT2, LinearEquiv.finrank_map_eq, finrank_weylT_12_eq]

/-- **`{F = 0}` is a proper subspace of `𝒲ₙ ∩ T_uS`** at every `n ≥ 4`: [L17Converse.lean](L17Converse.lean)'s
`ℂP²`-bar witness is a tangent Weyl operator with `F > 0`. -/
theorem F_zero_proper (hn : 4 ≤ n) {N : ℕ} (hN : finrank ℝ (Biv n) = N) :
    LinearMap.ker (condMap hn ∘ₗ (weylT n).subtype) ≠ ⊤ := by
  intro htop
  set H : weylT n := ⟨opB (restrict (Wb_weyl hn)), opB_mem_weylT hn (isWeyl2_restrict (Wb_weyl hn)) (Wb_tangent hn)⟩
  have hmem : H ∈ LinearMap.ker (condMap hn ∘ₗ (weylT n).subtype) := htop ▸ Submodule.mem_top
  have h0 := ((L17_codim hN hn (weylT n) fun H hH => admissible_of_weylT hH).1 H).mp hmem
  exact (Wb_F_pos hn hN).ne' h0

/-- At `n = 12`: `dim {F = 0} < 1637`. -/
theorem L17_proper_12 {N : ℕ} (hN : finrank ℝ (Biv 12) = N) :
    finrank ℝ (LinearMap.ker (condMap (by norm_num) ∘ₗ (weylT 12).subtype)) < 1637 := by
  rw [← finrank_weylT_12_eq]
  exact Submodule.finrank_lt (F_zero_proper (by norm_num) hN)

end HamiltonsCubic.L17Deriv
