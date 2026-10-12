import HamiltonsCubic.Results.PhiTri

set_option linter.style.longLine false

/-!
# The first variation of `P` at every direction, and the full symmetry of `T`: the STATEMENTS

**Derived in prose on 2026-09-19, typed here first as signatures with named `sorry`s so the claims
elaborated before anyone proved them, and then proved.** The
derivation is in [second-order.md](../../../findings/second-order.md), under *the first variation
of $P$ at an arbitrary direction*. **Both are now PROVED**, and this file carries no `sorry`.

**What the two statements say, and what each does NOT.** `hasDerivAt_Pcubic2_line` is the first
variation along a LINE, `t ↦ P(R + tS)`, at a self-adjoint `R` and an ARBITRARY direction `S`,
which is what Fermat over the full unit sphere consumes; *Euler's identity `DP(R)[R] = 3P(R)` is
its case `S = R` and nothing more.* It is a statement about a real function of one variable and
needs no topology on `CurvOp2`. **The Fréchet form `HasFDerivAt` is a further step**, one that a
cubic polynomial on a finite-dimensional space always takes, and it is owed beyond this.
`foxTri2_symm_right` is the symmetry in the LAST two slots at self-adjoint arguments, which with
`foxTri2_comm` is full symmetry; *neither is claimed at a non-self-adjoint argument, and the
derivation shows the `Φ` half needs the rotated slot symmetric.*
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset
open scoped Matrix.Norms.Frobenius

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **THE FIRST VARIATION ALONG A LINE, AT EVERY DIRECTION.** *At a self-adjoint `R` and any
`S`, the derivative of `t ↦ P(R + tS)` at `0` is `3⟨S, Q(R)⟩`.*

**IT IS PROVED AND CARRIES NO `sorry`.** *The composition half is
`hasDerivAt_trCube2_line_selfAdjoint` in [TraceOp.lean](TraceOp.lean) and the sharp half is
`hasDerivAt_sharpPair2_line_selfAdjoint` in [PhiTri.lean](PhiTri.lean), each an expansion of the
cubic in `t` followed by `hasDerivAt_cubic`.* **Both halves needed something the layer had never
stated**: bilinearity of `innerOp2` for the first, trilinearity of `phiTri` and the off-diagonal
pairing for the second. -/
theorem hasDerivAt_Pcubic2_line (R S : CurvOp2 ι) (hR : IsSelfAdjoint2 R) :
    HasDerivAt (fun t : ℝ => Pcubic2 (R + t • S)) (3 * innerOp2 S (Qop2 R)) 0 := by
  have hfun : (fun t : ℝ => Pcubic2 (R + t • S))
      = (fun t : ℝ => trCube2 (R + t • S)) + fun t : ℝ => sharpPair2 (R + t • S) := rfl
  rw [hfun]
  have key := (hasDerivAt_trCube2_line_selfAdjoint hR S).add
    (hasDerivAt_sharpPair2_line_selfAdjoint hR S)
  have hv : 3 * innerOp2 S (compOp2 R) + 3 * innerOp2 S (sharpMapCL R)
      = 3 * innerOp2 S (Qop2 R) := by
    unfold Qop2
    rw [innerOp2_add_right]
    ring
  rw [hv] at key
  exact key

/-- **The Fox product on `Λ²`**, `X ∘ Y = ½(Q(X+Y) − Q(X) − Q(Y))`, the record's definition with
the domain changed. -/
noncomputable def foxProd2 (X Y : CurvOp2 ι) : CurvOp2 ι :=
  (1 / 2 : ℝ) • (Qop2 (X + Y) - Qop2 X - Qop2 Y)

/-- **`T(X,Y,Z) = ⟨X ∘ Y, Z⟩` on `Λ²`.** -/
noncomputable def foxTri2 (X Y Z : CurvOp2 ι) : ℝ := innerOp2 (foxProd2 X Y) Z

/-- **Symmetric in the first two slots**, which is commutativity of `∘` and holds with no
hypothesis. -/
theorem foxTri2_comm (X Y Z : CurvOp2 ι) : foxTri2 X Y Z = foxTri2 Y X Z := by
  unfold foxTri2 foxProd2
  rw [add_comm X Y]
  congr 2
  abel

/-- **`Qop2` at a sum, polarised.** -/
theorem Qop2_add (X Y : CurvOp2 ι) :
    Qop2 (X + Y) - Qop2 X - Qop2 Y
      = (X.comp Y + Y.comp X) + (sharpMapCL (X + Y) - sharpMapCL X - sharpMapCL Y) := by
  unfold Qop2
  rw [compOp2_add]
  abel

/-- **`T` SPLIT INTO ITS JORDAN AND `#` HALVES.** *The first is the symmetrisation of the
composition, the second the polarised `#` read through `innerOp2_sharpMap_eq_phiTri`.* -/
theorem foxTri2_split (X Y Z : CurvOp2 ι) :
    foxTri2 X Y Z
      = (1/2 : ℝ) * (innerOp2 (X.comp Y) Z + innerOp2 (Y.comp X) Z)
        + -(1/4 : ℝ) * (phiTri Z X Y + phiTri Z Y X) := by
  unfold foxTri2 foxProd2
  rw [Qop2_add, innerOp2_smul_left, innerOp2_add_left, innerOp2_add_left, innerOp2_sub_left,
    innerOp2_sub_left]
  rw [innerOp2_comm (sharpMapCL (X + Y)) Z, innerOp2_comm (sharpMapCL X) Z,
    innerOp2_comm (sharpMapCL Y) Z]
  rw [innerOp2_sharpMap_eq_phiTri (X + Y) Z, innerOp2_sharpMap_eq_phiTri X Z,
    innerOp2_sharpMap_eq_phiTri Y Z]
  rw [phiTri_add_mid, phiTri_add_right, phiTri_add_right]
  ring

/-- **SYMMETRIC IN THE LAST TWO SLOTS AT SELF-ADJOINT ARGUMENTS**, which with `foxTri2_comm` is
the full symmetry of `T` ON `CurvOp2`.

**PROVED, 2026-09-19.** *`foxTri2_split` separates the Jordan half from the `#` half; the first is
symmetric by cyclicity of `trOp` and the second by `phiTri_swap_outer` with `phiTri_rotate`.*

**`X` NEEDS NO HYPOTHESIS AT ALL**: *the Jordan half needs `Y` and `Z` self-adjoint to read
`innerOp2` as a trace, and the `Φ` half needs `Y` and `Z` to rotate.* **A first version carried a
third binder as `_hX`, unused, so the recorded theorem was strictly weaker than its own proof**
([r1019](../../../reviews/REVIEW_r1019.md)).

**WHAT THIS DISCHARGES IS THE `CurvOp2` ANALOGUE, AND A FIRST VERSION CLAIMED MORE**
([r1019](../../../reviews/REVIEW_r1019.md)): *[FoxProduct.lean](../Base/FoxProduct.lean)'s `foxTri`
is over BARE operators with `sharpOp`, this one is over `CurvOp2` with `sharpMapCL`, **no file in
the tree names both**, and this file does not import that one.* **The bridge is near and absent**:
`Qop_extend` crosses, `extend_add` is nowhere. *And of the three consumers the record named, only
[L98](L98Statement.lean) names this debt; [L99](L99Statement.lean)'s own `NOT typed` section names
`dim ker M`, and its `sorry` needs BILINEARITY of `∘`, a separate owed item.* -/
theorem foxTri2_symm_right (X Y Z : CurvOp2 ι)
    (hY : IsSelfAdjoint2 Y) (hZ : IsSelfAdjoint2 Z) :
    foxTri2 X Y Z = foxTri2 X Z Y := by
  rw [foxTri2_split, foxTri2_split]
  have hphi1 : phiTri Z X Y = phiTri Y X Z := phiTri_swap_outer Z X Y
  have hphi2 : phiTri Z Y X = phiTri Y Z X := by
    rw [phiTri_rotate hZ Y X, ← phiTri_swap_outer Z X Y, ← phiTri_rotate hY Z X]
  have htr1 : innerOp2 (Z.comp X) Y = innerOp2 (X.comp Y) Z := by
    rw [innerOp2_eq_trOp_right _ hY, innerOp2_eq_trOp_right _ hZ,
      ContinuousLinearMap.comp_assoc]
    exact trOp_comp_comm Z (X.comp Y)
  have htr2 : innerOp2 (X.comp Z) Y = innerOp2 (Y.comp X) Z := by
    rw [innerOp2_eq_trOp_right _ hY, innerOp2_eq_trOp_right _ hZ, trOp_comp_comm,
      ← ContinuousLinearMap.comp_assoc]
  rw [hphi1, hphi2, htr1, htr2]
  ring

end HamiltonsCubic.RealLayer
