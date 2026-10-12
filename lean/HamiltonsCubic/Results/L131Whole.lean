import HamiltonsCubic.Results.L131Lin
import HamiltonsCubic.Results.L209WeylClosure
import HamiltonsCubic.Results.WeylInvariantZero
import HamiltonsCubic.Results.L126Orbit

set_option linter.style.longLine false

/-!
# L131's diagonal entries on every bivector

[L131Diag.lean](L131Diag.lean) states `eig_weyl`, `eig_ricci` and `eig_scalar` on the basis bivectors `φ_{ab}`. This
file carries them to every bivector, since `Z ↦ X # Y (Z)` is linear:

* **`isLinOp_sharpCross`**: `X # Y` is a linear operator at linear `X`, `Y`, from
  [L209WeylClosure.lean](L209WeylClosure.lean)'s `sharpOp_isLinOp`;
* **`eq_on_skew_of_phi`**: two linear operators agreeing on every `φ_{ab}` agree on every bivector, by `skew_expand`;
* **`eig_weyl_all`**, **`eig_ricci_all`**, **`eig_scalar_all`**: the three diagonal entries `−1`, `(n − 4)/2` and
  `n − 2` of the sharp-`I` map on every bivector. With `sharpCross_smul_left` the scalar entry holds on all of `ℝ · Id`.
-/

namespace HamiltonsCubic.L131Diag

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`X # Y` is linear** at linear `X` and `Y`. -/
theorem isLinOp_sharpCross {X Y : CurvOp ι} (hX : IsLinOp X) (hY : IsLinOp Y) : IsLinOp (sharpCross X Y) := by
  have hXY : IsLinOp (X + Y) :=
    ⟨fun A B => by simp only [Pi.add_apply, hX.1, hY.1]; abel,
     fun c A => by simp only [Pi.add_apply, hX.2, hY.2, smul_add]⟩
  have h1 := HamiltonsCubic.Results.sharpOp_isLinOp (X + Y) hXY
  have h2 := HamiltonsCubic.Results.sharpOp_isLinOp X hX
  have h3 := HamiltonsCubic.Results.sharpOp_isLinOp Y hY
  refine ⟨fun A B => ?_, fun c A => ?_⟩
  · unfold sharpCross; rw [h1.1, h2.1, h3.1]; module
  · unfold sharpCross; rw [h1.2, h2.2, h3.2]; module

/-- **Two linear operators agreeing on every `φ_{ab}` agree on every bivector.** -/
theorem eq_on_skew_of_phi {F G : CurvOp ι} (hF : IsLinOp F) (hG : IsLinOp G) (h : ∀ a b, F (phi a b) = G (phi a b))
    {Z : Matrix ι ι ℝ} (hZ : IsSkew Z) : F Z = G Z := by
  rw [← skew_expand Z hZ, hF.2, hG.2, lin_sum F hF, lin_sum G hG]
  congr 1
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [lin_sum F hF, lin_sum G hG]
  exact Finset.sum_congr rfl fun l _ => by rw [hF.2, hG.2, h k l]

omit [Fintype ι] [DecidableEq ι] in
theorem isLinOp_id' : IsLinOp (fun X : Matrix ι ι ℝ => X) := ⟨fun _ _ => rfl, fun _ _ => rfl⟩

omit [Fintype ι] [DecidableEq ι] in
theorem isLinOp_smul_op (c : ℝ) {F : CurvOp ι} (hF : IsLinOp F) : IsLinOp (fun X => c • F X) :=
  ⟨fun A B => by simp only [hF.1, smul_add], fun d A => by simp only [hF.2, smul_comm c d]⟩

/-- **The Weyl entry on every bivector**: at a diagonal weight `u` with zero row sums, `(diagOp u) # I = −diagOp u`. -/
theorem eig_weyl_all (u : Matrix ι ι ℝ) (hu : ∀ p q, u p q = u q p) (hhu : ∀ a, u a a = 0) (hr : ∀ a, ∑ c, u a c = 0)
    {Z : Matrix ι ι ℝ} (hZ : IsSkew Z) :
    sharpCross (diagOp u) (fun X => X) Z = (-1 : ℝ) • diagOp u Z :=
  eq_on_skew_of_phi (isLinOp_sharpCross (isLinOp_diagOp u) isLinOp_id')
    (isLinOp_smul_op (-1) (isLinOp_diagOp u)) (fun a b => eig_weyl u hu hhu hr a b) hZ

/-- **The Ricci entry on every bivector**: at `u = h ∧ g` with `∑ h = 0`, `(diagOp u) # I = ((n − 4)/2) diagOp u`. -/
theorem eig_ricci_all (h : ι → ℝ) (hsum : ∑ c, h c = 0) {Z : Matrix ι ι ℝ} (hZ : IsSkew Z) :
    sharpCross (diagOp (knw h)) (fun X => X) Z = (((Fintype.card ι : ℝ) - 4) / 2) • diagOp (knw h) Z :=
  eq_on_skew_of_phi (isLinOp_sharpCross (isLinOp_diagOp _) isLinOp_id')
    (isLinOp_smul_op _ (isLinOp_diagOp _)) (fun a b => eig_ricci h hsum a b) hZ

/-- **The scalar entry on every bivector**: `I # I = (n − 2) I`, `I` read as `diagOp (J − I)`, the identity on
bivectors. -/
theorem eig_scalar_all {Z : Matrix ι ι ℝ} (hZ : IsSkew Z) :
    sharpCross (diagOp jw) (fun X => X) Z = ((Fintype.card ι : ℝ) - 2) • Z := by
  rw [eq_on_skew_of_phi (isLinOp_sharpCross (isLinOp_diagOp _) isLinOp_id')
    (isLinOp_smul_op _ (isLinOp_diagOp _)) (fun a b => eig_scalar a b) hZ, diagOp_jw_skew hZ]

/-- **The scalar entry on all of `ℝ · Id`**: `(c I) # I = (n − 2)(c I)` on every bivector. -/
theorem eig_scalar_line (c : ℝ) {Z : Matrix ι ι ℝ} (hZ : IsSkew Z) :
    sharpCross (fun W => c • diagOp jw W) (fun X => X) Z = ((Fintype.card ι : ℝ) - 2) • (c • Z) := by
  rw [sharpCross_smul_left c (diagOp jw) (fun X => X) (isLinOp_diagOp _) isLinOp_id', eig_scalar_all hZ, smul_comm]

end HamiltonsCubic.L131Diag
