import HamiltonsCubic.Results.L131Four
import HamiltonsCubic.Base.FoxBilinear

set_option linter.style.longLine false

/-!
# `X ↦ X # Y` is linear in `X`, and L131's `Λ⁴` entry on the whole span

[findings/isotropy-cap.md](../../../findings/isotropy-cap.md), Lemma L131's table is stated on whole summands, and a
check on representatives reaches a summand only through the linearity of `X ↦ X # I`. This file proves that
linearity, at linear operators, from the Fox product's:

* **`sharpCross_add_left`**, **`sharpCross_smul_left`**, **`sharpCross_sum_left`**: `(X + X') # Y = X # Y + X' # Y`,
  `(c X) # Y = c (X # Y)` and the finite sums, through `foxProd_split` (`# = ∘ −` the Jordan half),
  [FoxBilinear.lean](../Base/FoxBilinear.lean)'s `foxProd_add_right` and `foxProd_smul_right`, and `foxProd_comm`;
* **`sharpCross_lam4_span`**: every finite combination `∑_t c_t v_t` of four-set elements `v_t = a + b + c` at distinct
  indices has `(∑ c_t v_t) # I = 2 ∑ c_t v_t` on bivectors. Those elements over `i < j < k < l` are the standard basis
  of `Λ⁴`, so this is L131's fourth entry on the whole summand.
-/

namespace HamiltonsCubic.L131Diag

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`#` is additive in its first slot**, at linear operators. -/
theorem sharpCross_add_left (X X' Y : CurvOp ι) (hX : IsLinOp X) (hX' : IsLinOp X') (hY : IsLinOp Y)
    (Z : Matrix ι ι ℝ) :
    sharpCross (fun W => X W + X' W) Y Z = sharpCross X Y Z + sharpCross X' Y Z := by
  have hXX : IsLinOp (fun W => X W + X' W) :=
    ⟨fun A B => by simp only [hX.1, hX'.1]; abel, fun c A => by simp only [hX.2, hX'.2, smul_add]⟩
  have s1 := congrFun (foxProd_split (fun W => X W + X' W) Y hXX.1 hY.1) Z
  have s2 := congrFun (foxProd_split X Y hX.1 hY.1) Z
  have s3 := congrFun (foxProd_split X' Y hX'.1 hY.1) Z
  have hf : foxProd (fun W => X W + X' W) Y Z = foxProd X Y Z + foxProd X' Y Z := by
    rw [foxProd_comm, foxProd_add_right Y X X' hY hX hX', foxProd_comm Y X, foxProd_comm Y X']
  have hj : jordanProd (fun W => X W + X' W) Y Z = jordanProd X Y Z + jordanProd X' Y Z := by
    unfold jordanProd; rw [hY.1]; module
  have e1 : sharpCross (fun W => X W + X' W) Y Z = foxProd (fun W => X W + X' W) Y Z
      - jordanProd (fun W => X W + X' W) Y Z := by rw [s1]; abel
  rw [e1, hf, hj, s2, s3]; abel

/-- **`#` is homogeneous in its first slot**, at linear operators. -/
theorem sharpCross_smul_left (c : ℝ) (X Y : CurvOp ι) (hX : IsLinOp X) (hY : IsLinOp Y) (Z : Matrix ι ι ℝ) :
    sharpCross (fun W => c • X W) Y Z = c • sharpCross X Y Z := by
  have hcX : IsLinOp (fun W => c • X W) :=
    ⟨fun A B => by simp only [hX.1, smul_add], fun d A => by simp only [hX.2, smul_comm c d]⟩
  have s1 := congrFun (foxProd_split (fun W => c • X W) Y hcX.1 hY.1) Z
  have s2 := congrFun (foxProd_split X Y hX.1 hY.1) Z
  have hf : foxProd (fun W => c • X W) Y Z = c • foxProd X Y Z := by
    rw [foxProd_comm, foxProd_smul_right c Y X hY hX, foxProd_comm Y X]
  have hj : jordanProd (fun W => c • X W) Y Z = c • jordanProd X Y Z := by
    unfold jordanProd; rw [hY.2]; module
  have e1 : sharpCross (fun W => c • X W) Y Z = foxProd (fun W => c • X W) Y Z - jordanProd (fun W => c • X W) Y Z := by
    rw [s1]; abel
  have e2 : sharpCross X Y Z = foxProd X Y Z - jordanProd X Y Z := by rw [s2]; abel
  rw [e1, hf, hj, e2, smul_sub]

/-- **`#` is linear in its first slot over finite sums.** -/
theorem sharpCross_sum_left {κ : Type*} (s : Finset κ) (c : κ → ℝ) (X : κ → CurvOp ι) (hX : ∀ t, IsLinOp (X t))
    (Y : CurvOp ι) (hY : IsLinOp Y) (Z : Matrix ι ι ℝ) :
    sharpCross (fun W => ∑ t ∈ s, c t • X t W) Y Z = ∑ t ∈ s, c t • sharpCross (X t) Y Z := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    simp only [Finset.sum_empty]
    have := sharpCross_smul_left 0 Y Y hY hY Z
    simp only [zero_smul] at this
    exact this
  | insert t s ht ih =>
    have hS : IsLinOp (fun W => ∑ u ∈ s, c u • X u W) :=
      ⟨fun A B => by simp only [(hX _).1, smul_add, Finset.sum_add_distrib],
       fun d A => by simp only [(hX _).2, Finset.smul_sum, smul_comm d]⟩
    have hcX : IsLinOp (fun W => c t • X t W) :=
      ⟨fun A B => by simp only [(hX t).1, smul_add], fun d A => by simp only [(hX t).2, smul_comm (c t) d]⟩
    simp only [Finset.sum_insert ht]
    rw [sharpCross_add_left (fun W => c t • X t W) (fun W => ∑ u ∈ s, c u • X u W) Y hcX hS hY,
      sharpCross_smul_left (c t) (X t) Y (hX t) hY, ih]

/-- **L131's fourth entry on the span**: every finite combination of four-set elements at distinct indices has
`# I = 2`, on bivectors. -/
theorem sharpCross_lam4_span {κ : Type*} (s : Finset κ) (c : κ → ℝ) (i j k l : κ → ι)
    (hd : ∀ t, i t ≠ j t ∧ i t ≠ k t ∧ i t ≠ l t ∧ j t ≠ k t ∧ j t ≠ l t ∧ k t ≠ l t)
    {Z : Matrix ι ι ℝ} (hZ : IsSkew Z) :
    sharpCross (fun W => ∑ t ∈ s, c t • lam4 (i t) (j t) (k t) (l t) W) (fun X => X) Z
      = (2 : ℝ) • ∑ t ∈ s, c t • lam4 (i t) (j t) (k t) (l t) Z := by
  have hI : IsLinOp (fun X : Matrix ι ι ℝ => X) := ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  rw [sharpCross_sum_left s c (fun t => lam4 (i t) (j t) (k t) (l t)) (fun t => lam4_lin _ _ _ _) _ hI,
    Finset.smul_sum]
  refine Finset.sum_congr rfl fun t _ => ?_
  obtain ⟨h1, h2, h3, h4, h5, h6⟩ := hd t
  rw [sharpCross_four_id h1 h2 h3 h4 h5 h6 hZ, smul_comm]

end HamiltonsCubic.L131Diag
