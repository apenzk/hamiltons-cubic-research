import Mathlib.Tactic
import HamiltonsCubic.Results.FoxBridge
import HamiltonsCubic.Results.WeylOrthogonal

/-!
# Lemma L234, step 1: the split through the orthogonal projection onto `𝒲ₙ`

[findings/second-order.md](../../../findings/second-order.md), the L234 block, step (1).

**The claim, quoted from the record**: "$\langle X,e\circ X\rangle=\langle Y_0,e\circ Y_0\rangle-\langle N,e\circ N\rangle$"
with $X=\pi_{\mathcal W_n}Y_0$, $N=Y_0-X$, from the symmetry of $T$, $e\circ\mathcal W_n\subseteq\mathcal W_n$
and $N\perp\mathcal W_n$.

## What is typed here

* `restrictLin`: the `CurvOp2` restriction of a linear, bivector-preserving operator, needing no Weyl
  hypothesis, with its bridge `foxTri_eq_foxTri2_restrictLin` and `isSelfAdjoint2_restrictLin`.
* `foxTri2_add_mid`, `foxTri2_add_right`: `T` is additive in its last two slots, from `foxTri2_split`.
* `L234_split`: **step (1) of L234, proved**, at every `e ∈ 𝒲ₙ`, every linear, bivector-preserving,
  self-adjoint `Y₀` and `n ≥ 3`, with `X = weylProj Y₀`. *The inputs are exactly the block's:
  `foxProd_isWeylOp` for `e ∘ X ∈ 𝒲ₙ`, `weylProj_orth` for `N ⟂ 𝒲ₙ`, `foxTri2_symm_right` for `T`.*
* **Not typed**: steps (2)-(4), the vanishing cross term and the Ricci and `Λ⁴` constants.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.TensorBridge

open Matrix Finset
open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`restrict` from linearity and bivector preservation alone**, no Weyl hypothesis. -/
noncomputable def restrictLin {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hl : IsLinOp R)
    (hs : ∀ X, IsSkew X → IsSkew (R X)) : CurvOp2 ι :=
  LinearMap.toContinuousLinearMap
    { toFun := fun X => ⟨R (X : Matrix ι ι ℝ), hs _ X.2⟩
      map_add' := fun X Y => Subtype.ext (by
        show R ((X : Matrix ι ι ℝ) + (Y : Matrix ι ι ℝ)) = R X + R Y
        exact hl.1 _ _)
      map_smul' := fun c X => Subtype.ext (by
        show R (c • (X : Matrix ι ι ℝ)) = c • R X
        exact hl.2 _ _) }

theorem extend_restrictLin_on_skew {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hl : IsLinOp R)
    (hs : ∀ X, IsSkew X → IsSkew (R X)) (Z : Matrix ι ι ℝ) (hZ : IsSkew Z) :
    extend (restrictLin hl hs) Z = R Z := by
  rw [show Z = ((⟨Z, hZ⟩ : skewSub ι) : Matrix ι ι ℝ) from rfl,
    extend_apply (restrictLin hl hs) ⟨Z, hZ⟩]
  rfl

theorem isSelfAdjoint2_restrictLin {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hl : IsLinOp R)
    (hs : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) :
    IsSelfAdjoint2 (restrictLin hl hs) :=
  fun X Y => hsym (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) X.2 Y.2

theorem foxTri_eq_foxTri2_restrictLin {X Y Z : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hXl : IsLinOp X) (hXs : ∀ W, IsSkew W → IsSkew (X W))
    (hYl : IsLinOp Y) (hYs : ∀ W, IsSkew W → IsSkew (Y W))
    (hZl : IsLinOp Z) (hZs : ∀ W, IsSkew W → IsSkew (Z W)) :
    foxTri X Y Z = foxTri2 (restrictLin hXl hXs) (restrictLin hYl hYs) (restrictLin hZl hZs) := by
  rw [← foxTri_extend (restrictLin hXl hXs) (restrictLin hYl hYs) (restrictLin hZl hZs)]
  exact foxTri_congr_on_skew hXs hYs
    (fun W hW => (extend_restrictLin_on_skew hXl hXs W hW).symm)
    (fun W hW => (extend_restrictLin_on_skew hYl hYs W hW).symm)
    (fun W hW => (extend_restrictLin_on_skew hZl hZs W hW).symm)

theorem foxTri2_add_mid (X Y Y' Z : CurvOp2 ι) :
    foxTri2 X (Y + Y') Z = foxTri2 X Y Z + foxTri2 X Y' Z := by
  rw [foxTri2_split, foxTri2_split, foxTri2_split, ContinuousLinearMap.comp_add,
    ContinuousLinearMap.add_comp, innerOp2_add_left, innerOp2_add_left, phiTri_add_mid,
    phiTri_add_right]
  ring

theorem foxTri2_add_right (X Y Z Z' : CurvOp2 ι) :
    foxTri2 X Y (Z + Z') = foxTri2 X Y Z + foxTri2 X Y Z' := by
  unfold foxTri2; rw [innerOp2_add_right]

open HamiltonsCubic.Results in
/-- **L234's STEP 1, THE SPLIT**: with `X = π_{𝒲ₙ} Y₀` and `N = Y₀ − X`,
`⟨Y₀, e ∘ Y₀⟩ = ⟨X, e ∘ X⟩ + ⟨N, e ∘ N⟩` at every `e ∈ 𝒲ₙ` and every linear, bivector-preserving,
self-adjoint `Y₀`, `n ≥ 3`. *The cross term is `⟨N, e ∘ X⟩`, zero because `e ∘ X ∈ 𝒲ₙ`
(`foxProd_isWeylOp`) and `N ⟂ 𝒲ₙ` (`weylProj_orth`), counted twice by the symmetry of `T`.* -/
theorem L234_split (hn : 3 ≤ Fintype.card ι) (e Y0 : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (he : IsWeylOp e) (hl : IsLinOp Y0) (hs : ∀ X, IsSkew X → IsSkew (Y0 X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (Y0 X) Y = inner2 X (Y0 Y)) :
    foxTri e Y0 Y0 = foxTri e (weylProj Y0) (weylProj Y0)
      + foxTri e (fun Z => Y0 Z - weylProj Y0 Z) (fun Z => Y0 Z - weylProj Y0 Z) := by
  have hX := weylProj_isWeylOp Y0 hn hl hs hsym
  obtain ⟨hXl, hXs, hXy, -, -⟩ := hX
  have hNl : IsLinOp (fun Z => Y0 Z - weylProj Y0 Z) :=
    ⟨fun A B => by simp only [hl.1, hXl.1]; abel, fun c A => by simp only [hl.2, hXl.2, smul_sub]⟩
  have hNs : ∀ W, IsSkew W → IsSkew (Y0 W - weylProj Y0 W) := fun W hW => by
    have h1 := hs W hW; have h2 := hXs W hW
    unfold IsSkew at *; rw [Matrix.transpose_sub, h1, h2]; abel
  have hNy : ∀ A B, IsSkew A → IsSkew B →
      inner2 (Y0 A - weylProj Y0 A) B = inner2 A (Y0 B - weylProj Y0 B) := fun A B hA hB => by
    rw [inner2_sub_left', inner2_sub_right', hsym A B hA hB, hXy A B hA hB]
  have hel := he.1; have hes := he.2.1
  have hABC : restrictLin hl hs = restrictLin hXl hXs + restrictLin hNl hNs := by
    apply ContinuousLinearMap.ext; intro Z; apply Subtype.ext
    show Y0 (Z : Matrix ι ι ℝ) = weylProj Y0 Z + (Y0 Z - weylProj Y0 Z); abel
  have horth : foxTri e (weylProj Y0) (fun Z => Y0 Z - weylProj Y0 Z) = 0 := by
    unfold foxTri
    rw [innerOp_comm]
    exact weylProj_orth Y0 hl hsym _ (foxProd_isWeylOp e (weylProj Y0) he
      (weylProj_isWeylOp Y0 hn hl hs hsym))
  rw [foxTri_eq_foxTri2_restrictLin hel hes hl hs hl hs,
    foxTri_eq_foxTri2_restrictLin hel hes hXl hXs hXl hXs,
    foxTri_eq_foxTri2_restrictLin hel hes hNl hNs hNl hNs]
  rw [foxTri_eq_foxTri2_restrictLin hel hes hXl hXs hNl hNs] at horth
  have hsymBC : foxTri2 (restrictLin hel hes) (restrictLin hNl hNs) (restrictLin hXl hXs)
      = foxTri2 (restrictLin hel hes) (restrictLin hXl hXs) (restrictLin hNl hNs) :=
    foxTri2_symm_right _ _ _ (isSelfAdjoint2_restrictLin hNl hNs hNy)
      (isSelfAdjoint2_restrictLin hXl hXs hXy)
  rw [hABC, foxTri2_add_mid, foxTri2_add_right, foxTri2_add_right, hsymBC, horth]
  ring

end HamiltonsCubic.TensorBridge

#print axioms HamiltonsCubic.TensorBridge.L234_split  -- [propext, Classical.choice, Quot.sound]
