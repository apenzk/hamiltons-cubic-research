import Mathlib

set_option linter.style.longLine false

/-!
# L125, L24 off `W^⊥`, stated and PROVED

## The record's statement, verbatim

> #### Lemma L125, L24 off $W^\perp$: the same statement, in the form the four-set application needs
>
> **At a maximiser $W$ of unit norm with $\theta>0$, for every $Y\in\mathcal W_n$,**
> $$\langle Y,L_eY\rangle\ \le\ \tfrac12\lVert Y\rVert^2+\tfrac12\langle W,Y\rangle^2 .$$
>
> **Proof, and why it is Lemma L24.** $L_e$ is self-adjoint with $L_eW=W$, so $W^\perp$ is
> invariant. Split $Y=aW+Z$ with $Z\perp W$: the cross term $2a\langle Z,L_eW\rangle=2a\langle
> Z,W\rangle$ vanishes, both sides become $a^2+{}$their $Z$-parts, and the statement collapses to
> $\langle Z,L_eZ\rangle\le\tfrac12\lVert Z\rVert^2$, **L24, in both directions.**
>
> > **THE EQUALITY AT $Y=W$ CERTIFIES NOTHING.** It is the radial direction of a degree-zero
> > homogeneous function, identically zero at *any* point, using neither maximality nor criticality.

[second-order.md](../../../findings/second-order.md), Lemma L125.

## What is stated here, and what enters as a hypothesis

The record's own reading is that L125 **is** L24 rearranged, so the file states the equivalence:
`L125_of_L24` and `L24_of_L125` are proved in both directions, which is the lemma's whole content.

`hL24` (the extremal spectral cap `σ(L_e|_{W^⊥}) ⊆ (-∞, ½]`), enters as an explicit hypothesis
because it is **classical and external**: Proposition 6.6 of Krasnov–Tkachev, *Variety of
idempotents in nonassociative algebras*, and again Proposition 2.5 of Tkachev's survey, as
[second-order.md](../../../findings/second-order.md) records under L24. The maximiser hypothesis
of the record is what supplies that cap and nothing else, so it is spent here as the cap.

The setting is a real inner product space with a self-adjoint `L` fixing a unit vector `W`. That is
exactly what the record uses: `L_e = L_W/θ`, self-adjoint because `⟨X ∘ Y, Z⟩` is fully symmetric,
and `L_e W = W` by criticality. **No Weyl structure is consumed anywhere in the argument**, which
is why it is stated at this generality rather than against `HamiltonsCubic.RealLayer`.

The final section proves the record's own caveat: at `Y = W` the inequality is an equality, on no
hypothesis beyond `L W = W` and `‖W‖ = 1`.
-/

namespace HamiltonsCubic.L125Statement

open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- **L24, as the record states it**: the Rayleigh quotient of `L` is capped by `½` on `W^⊥`.

*Krasnov–Tkachev Proposition 6.6, for an extremal idempotent of a Euclidean metrised algebra.* -/
def L24Cap (L : E →ₗ[ℝ] E) (W : E) : Prop :=
  ∀ Z : E, ⟪W, Z⟫ = 0 → ⟪Z, L Z⟫ ≤ (1 / 2) * ‖Z‖ ^ 2

/-- **L125, as the record states it**: the projection-corrected form, on all of the space. -/
def L125Form (L : E →ₗ[ℝ] E) (W : E) : Prop :=
  ∀ Y : E, ⟪Y, L Y⟫ ≤ (1 / 2) * ‖Y‖ ^ 2 + (1 / 2) * ⟪W, Y⟫ ^ 2

/-- The orthogonal part of `Y` against a unit `W`. -/
noncomputable def perpPart (W Y : E) : E := Y - ⟪W, Y⟫ • W

theorem perpPart_orth (W Y : E) (hW : ‖W‖ = 1) : ⟪W, perpPart W Y⟫ = 0 := by
  simp [perpPart, inner_sub_right, real_inner_smul_right, hW]

theorem perpPart_add (W Y : E) : Y = ⟪W, Y⟫ • W + perpPart W Y := by
  simp [perpPart]

/-- `‖Y‖² = ⟨W,Y⟩² + ‖Y - ⟨W,Y⟩W‖²`, Pythagoras against a unit `W`. -/
theorem norm_split (W Y : E) (hW : ‖W‖ = 1) :
    ‖Y‖ ^ 2 = ⟪W, Y⟫ ^ 2 + ‖perpPart W Y‖ ^ 2 := by
  have hWW : ⟪W, W⟫ = (1 : ℝ) := by
    rw [real_inner_self_eq_norm_sq, hW]; norm_num
  have h1 : ‖perpPart W Y‖ ^ 2 = ‖Y‖ ^ 2 - ⟪W, Y⟫ ^ 2 := by
    rw [← real_inner_self_eq_norm_sq, ← real_inner_self_eq_norm_sq]
    simp only [perpPart, inner_sub_left, inner_sub_right, real_inner_smul_left,
      real_inner_smul_right, hWW, real_inner_comm W Y]
    ring
  linarith

/-- **L125 from L24.** The cross term dies because `L W = W` and `Z ⊥ W`. -/
theorem L125_of_L24 (L : E →ₗ[ℝ] E) (W : E) (hW : ‖W‖ = 1) (hfix : L W = W)
    (hsa : ∀ x y : E, ⟪L x, y⟫ = ⟪x, L y⟫) (hcap : L24Cap L W) : L125Form L W := by
  intro Y
  set a : ℝ := ⟪W, Y⟫ with ha
  set Z : E := perpPart W Y with hZ
  have hWZ : ⟪W, Z⟫ = 0 := perpPart_orth W Y hW
  have hZW : ⟪Z, W⟫ = 0 := by rw [real_inner_comm]; exact hWZ
  have hWW : ⟪W, W⟫ = (1 : ℝ) := by
    rw [real_inner_self_eq_norm_sq, hW]; norm_num
  have hWLZ : ⟪W, L Z⟫ = (0 : ℝ) := by rw [← hsa W Z, hfix]; exact hWZ
  have hY : Y = a • W + Z := perpPart_add W Y
  have hquad : ⟪Y, L Y⟫ = a ^ 2 + ⟪Z, L Z⟫ := by
    conv_lhs => rw [hY]
    rw [map_add, map_smul, hfix]
    simp only [inner_add_left, inner_add_right, real_inner_smul_left, real_inner_smul_right,
      hWW, hWLZ, hZW]
    ring
  have hnorm := norm_split W Y hW
  have hcapZ := hcap Z hWZ
  rw [hquad]
  rw [← ha, ← hZ] at hnorm
  linarith

/-- **L24 from L125**, the other direction: restrict to `Z ⊥ W`, where the correction vanishes.
*This is what makes the record's "L24, in both directions" a theorem rather than a slogan.* -/
theorem L24_of_L125 (L : E →ₗ[ℝ] E) (W : E) (h : L125Form L W) : L24Cap L W := by
  intro Z hZ
  have := h Z
  rw [hZ] at this
  simpa using this

/-- **The record's caveat, proved: equality at `Y = W` certifies nothing.** It holds on `L W = W`
and `‖W‖ = 1` alone, neither maximality nor the cap is used. -/
theorem equality_at_W (L : E →ₗ[ℝ] E) (W : E) (hW : ‖W‖ = 1) (hfix : L W = W) :
    ⟪W, L W⟫ = (1 / 2) * ‖W‖ ^ 2 + (1 / 2) * ⟪W, W⟫ ^ 2 := by
  have hWW : ⟪W, W⟫ = (1 : ℝ) := by
    rw [real_inner_self_eq_norm_sq, hW]; norm_num
  rw [hfix, hWW, hW]
  norm_num

/-! ## A witness, so the hypotheses are not empty

*`L = id` on `ℝ`, `W = 1`.* `L24Cap` holds because `Z ⊥ W` forces `Z = 0` there, so the cap is
not vacuous as a hypothesis and `L125Form` is inhabited. -/

example : L24Cap (LinearMap.id : ℝ →ₗ[ℝ] ℝ) 1 := by
  intro Z hZ
  have : Z = 0 := by simpa using hZ
  simp [this]

example : ‖(1 : ℝ)‖ = 1 := by norm_num

end HamiltonsCubic.L125Statement
