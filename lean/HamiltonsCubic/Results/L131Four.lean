import HamiltonsCubic.Results.L131Diag
import HamiltonsCubic.Results.L121Block

set_option linter.style.longLine false

/-!
# L131's fourth entry: `# I = 2` on `Λ⁴`

[findings/isotropy-cap.md](../../../findings/isotropy-cap.md), Lemma L131: the sharp-`I` map has eigenvalues `-1`,
`(m - 4)/2`, `m - 2`, `2` on `Weyl_m`, `S²₀`, `ℝ · Id`, `Λ⁴`. [L131Diag.lean](L131Diag.lean) proves the first three on
their coordinate-diagonal representatives and leaves the fourth, `Λ⁴` having no diagonal representative. This file
proves it on the four-set representatives: at distinct `i, j, k, l` the totally antisymmetric element of the four-set
block is `v = a + b + c`, `a = φ_{ij} ⊙ φ_{kl}`, `b = φ_{ki} ⊙ φ_{jl}`, `c = φ_{il} ⊙ φ_{jk}`. Each of `a, b, c` orders
`(i, j, k, l)` by an even permutation, they have disjoint supports and equal norms, so `v` spans the orthogonal complement
of the Bianchi cut `x + y + z = 0` inside the block; that orthogonality is argued here and has no declaration. The
elements `v` over `i < j < k < l` are the standard basis of `Λ⁴`, and

* **`sharpCross_four_id`**: `v # I = 2 v` on bivectors.

The proof reads `v # I` off the Fox product: `I ∘ v = 3 v` by [L121Block.lean](L121Block.lean)'s `fourSet_span` with
every weight `1`, the Jordan half of `v ∘ I` is `v`, and `foxProd_split` leaves `v # I = 3 v − v`.
-/

namespace HamiltonsCubic.L131Diag

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The totally antisymmetric element of the four-set block, `a + b + c`. -/
noncomputable def lam4 (i j k l : ι) : CurvOp ι := fun Y =>
  rk2 (phi i j) (phi k l) Y + rk2 (phi k i) (phi j l) Y + rk2 (phi i l) (phi j k) Y

theorem lam4_lin (i j k l : ι) : IsLinOp (lam4 i j k l) := by
  refine ⟨fun X Y => ?_, fun c X => ?_⟩
  · simp only [lam4, (isLinOp_rk2 _ _).1]; abel
  · simp only [lam4, (isLinOp_rk2 _ _).2, smul_add]

theorem rk2_skew' {U V : Matrix ι ι ℝ} (hU : IsSkew U) (hV : IsSkew V) (X : Matrix ι ι ℝ) : IsSkew (rk2 U V X) := by
  unfold IsSkew at *; unfold rk2
  rw [Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_smul, hU, hV, smul_neg, smul_neg, neg_add]

theorem lam4_skew (i j k l : ι) (X : Matrix ι ι ℝ) : IsSkew (lam4 i j k l X) := by
  have h1 := rk2_skew' (phi_isSkew i j) (phi_isSkew k l) X
  have h2 := rk2_skew' (phi_isSkew k i) (phi_isSkew j l) X
  have h3 := rk2_skew' (phi_isSkew i l) (phi_isSkew j k) X
  unfold IsSkew at *; unfold lam4
  rw [Matrix.transpose_add, Matrix.transpose_add, h1, h2, h3]; abel

/-- **`# I = 2` on `Λ⁴`**: at distinct `i, j, k, l`, `v # I = 2 v` on every bivector, `v = a + b + c`. -/
theorem sharpCross_four_id {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) {Z : Matrix ι ι ℝ} (hZ : IsSkew Z) :
    sharpCross (lam4 i j k l) (fun X => X) Z = (2 : ℝ) • lam4 i j k l Z := by
  have hjs : ∀ p q, (jw : Matrix ι ι ℝ) p q = jw q p := fun p q => by simp only [jw, eq_comm]
  have hl := lam4_lin i j k l
  -- on bivectors the identity is `diagOp jw`
  have hcongr : sharpCross (lam4 i j k l) (fun X => X) Z = sharpCross (lam4 i j k l) (diagOp jw) Z := by
    unfold sharpCross
    have hskew : ∀ X, IsSkew X → IsSkew ((lam4 i j k l + (fun X => X) : Matrix ι ι ℝ → Matrix ι ι ℝ) X) :=
      fun X hX => by
        have h1 := lam4_skew i j k l X
        show IsSkew (lam4 i j k l X + X)
        unfold IsSkew at h1 hX ⊢; rw [Matrix.transpose_add, h1, hX]; abel
    have e1 : sharpOp (lam4 i j k l + (fun X => X) : Matrix ι ι ℝ → Matrix ι ι ℝ) Z
        = sharpOp (lam4 i j k l + diagOp jw) Z :=
      HamiltonsCubic.TensorBridge.sharpOp_congr_on_skew hskew
        (fun X hX => by change lam4 i j k l X + X = lam4 i j k l X + diagOp jw X; rw [diagOp_jw_skew hX]) _ hZ
    have e2 : sharpOp (fun X : Matrix ι ι ℝ => X) Z = sharpOp (diagOp jw) Z :=
      HamiltonsCubic.TensorBridge.sharpOp_congr_on_skew (fun X hX => hX)
        (fun X hX => (diagOp_jw_skew hX).symm) _ hZ
    rw [e1, e2]
  -- `∘` splits into the Jordan half and `#`
  have hsplit := congrFun (foxProd_split (lam4 i j k l) (diagOp jw) hl.1 (isLinOp_diagOp jw).1) Z
  -- `I ∘ v = 3 v`
  have hfox : foxProd (lam4 i j k l) (diagOp jw) Z = (3 : ℝ) • lam4 i j k l Z := by
    rw [foxProd_comm]
    have e : lam4 i j k l = fun Y => (1 : ℝ) • rk2 (phi i j) (phi k l) Y + (1 : ℝ) • rk2 (phi k i) (phi j l) Y
        + (1 : ℝ) • rk2 (phi i l) (phi j k) Y := by
      funext Y; simp only [lam4, one_smul]
    rw [e, fourSet_span jw hjs hij hik hil hjk hjl hkl hZ 1 1 1]
    simp only [jw, if_neg hij, if_neg hkl, if_neg hil, if_neg hjk, if_neg hik, if_neg hjl, one_smul, smul_add,
      smul_smul]
    norm_num
  -- the Jordan half of `v ∘ I` is `v`
  have hjord : jordanProd (lam4 i j k l) (diagOp jw) Z = lam4 i j k l Z := by
    unfold jordanProd
    rw [diagOp_jw_skew hZ, diagOp_jw_skew (lam4_skew i j k l Z)]
    module
  rw [hcongr]
  have := hsplit
  rw [hfox, hjord] at this
  rw [show sharpCross (lam4 i j k l) (diagOp jw) Z = (3 : ℝ) • lam4 i j k l Z - lam4 i j k l Z by rw [this]; abel]
  module

end HamiltonsCubic.L131Diag
