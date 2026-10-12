import Mathlib
import HamiltonsCubic.Results.FoxBridge
import HamiltonsCubic.Results.CubicBridge
import HamiltonsCubic.Results.L209WeylClosure

set_option linter.style.longLine false

/-!
# From `IsCritical` to the `CurvOp2` criticality equation

The layer states criticality two ways: `IsCritical W θ`, `Q(W) φ_ij = θ W φ_ij` on the basis bivectors
([WeylReal.lean](../Base/WeylReal.lean)), and on `CurvOp2` the operator equation
`Qop2 a = θ • a`, which [L120HessPair.lean](L120HessPair.lean)'s `hessOp_pair` and `hessOp_four` and
[L126GenBridge.lean](L126GenBridge.lean) take as a hypothesis. This file passes from the first to the
second at every linear Weyl operator:

* `linOf`: an `IsLinOp` map as an `ℝ`-linear map;
* `Qop_skew_of_critical`: `Q(W) X = θ W X` at every skew `X`, by `skew_expand` and the linearity of
  `Q(W)` (L209's `Qop_isWeylOp`);
* `extend_restrict_on_skew`: `extend (restrict W)` agrees with `W` on skew matrices;
* `Qop_restrict_on_skew`: so `Q(extend (restrict W))` agrees with `Q(W)` there (`sharpOp_congr_on_skew`);
* `Qop2_restrict_of_critical`: `Qop2 (restrict W) = θ • restrict W`, through TensorBridge's `Qop_extend`.
-/

namespace HamiltonsCubic.CriticalBridge

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.TensorBridge

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- An `IsLinOp` map as an `ℝ`-linear map. -/
def linOf {L : Matrix ι ι ℝ → Matrix ι ι ℝ} (hL : IsLinOp L) : Matrix ι ι ℝ →ₗ[ℝ] Matrix ι ι ℝ where
  toFun := L
  map_add' := hL.1
  map_smul' := hL.2

/-- **`Q(W) X = θ W X` at every skew `X`**, from the basis statement. -/
theorem Qop_skew_of_critical {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeylOp W) {θ : ℝ}
    (hc : IsCritical W θ) (X : Matrix ι ι ℝ) (hX : IsSkew X) : Qop W X = θ • W X := by
  have hQ := (HamiltonsCubic.Results.Qop_isWeylOp W hW).1
  rw [← skew_expand X hX]
  show linOf hQ _ = θ • linOf hW.1 _
  simp only [map_smul, map_sum]
  show (1 / 2 : ℝ) • ∑ i, ∑ j, inner2 X (phi i j) • Qop W (phi i j)
    = θ • ((1 / 2 : ℝ) • ∑ i, ∑ j, inner2 X (phi i j) • W (phi i j))
  simp only [hc _ _, smul_comm (inner2 X _) θ, ← Finset.smul_sum, smul_comm (1 / 2 : ℝ) θ]

/-- **`extend (restrict W)` agrees with `W` on skew matrices.** -/
theorem extend_restrict_on_skew {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W)
    (Z : Matrix ι ι ℝ) (hZ : IsSkew Z) : extend (restrict hW) Z = W Z := by
  rw [show Z = ((⟨Z, hZ⟩ : skewSub ι) : Matrix ι ι ℝ) from rfl, extend_apply]
  rfl

/-- **`Q` of `extend (restrict W)` agrees with `Q(W)` on skew matrices.** -/
theorem Qop_restrict_on_skew {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W)
    (X : Matrix ι ι ℝ) (hX : IsSkew X) : Qop (extend (restrict hW)) X = Qop W X := by
  have hRS : ∀ Z, IsSkew Z → W Z = extend (restrict hW) Z := fun Z hZ =>
    (extend_restrict_on_skew hW Z hZ).symm
  unfold Qop compOp
  rw [extend_restrict_on_skew hW X hX, extend_restrict_on_skew hW (W X) (hW.1 X hX),
    sharpOp_congr_on_skew hW.1 hRS X hX]

/-- **The `CurvOp2` criticality equation from `IsCritical`**: `Qop2 (restrict W) = θ • restrict W` at
every linear Weyl operator `W` with `Q(W) φ_ij = θ W φ_ij`. -/
theorem Qop2_restrict_of_critical {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeylOp W) {θ : ℝ}
    (hc : IsCritical W θ) : Qop2 (restrict hW.2) = θ • restrict hW.2 := by
  ext X
  have h1 := Qop_extend (restrict hW.2) X
  rw [Qop_restrict_on_skew hW.2 _ X.2, Qop_skew_of_critical hW hc _ X.2] at h1
  rw [← h1]
  rfl

end HamiltonsCubic.CriticalBridge
