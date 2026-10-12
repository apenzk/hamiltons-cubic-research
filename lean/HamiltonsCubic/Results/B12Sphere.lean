import HamiltonsCubic.Results.B12Sectors

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12: the diagonal Weyl operators of `weylModuleS`, and the sphere product among them, are fixed by the sign group

[r1917](../../../reviews/REVIEW_r1917.md) found that B12's last step needs the unit sphere product as an element of the record's
`weylModuleS` at every `n`, fixed by every `diagSet u` so that [B12Sectors.lean](B12Sectors.lean)'s `Lop_projS` applies,
while `weylModuleS` carried a sphere product only at `Fin 4`. [WeylTraceSchur.lean](WeylTraceSchur.lean)'s `E_q` is the
diagonal operator of one weight, and its argument runs at every weight:

* **`diagW w`**, `diagOpL w ∘ skewProj`, and **`diagW_mem`**: at every weight `w` it lies in `weylModuleS`;
* **`diagW_phi`**, **`coord_diagW`**: at a symmetric `w` it sends `φ_ij` to `w_ij φ_ij`;
* **`diagW_flip`**, **`diagW_diagSet`**: it is fixed by every single flip, hence by every `diagSet u`;
* **`sphS T t`**: the element `diagW (t · sphereWeight T)` of `weylModuleS` at `|T|, |Tᶜ| ≥ 2`, and **`sphS_fixed`**, the
  hypothesis of `Lop_projS` at it.
-/

namespace HamiltonsCubic.B12Sphere

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.WeylRadical
  HamiltonsCubic.WeylModuleSNonzero HamiltonsCubic.Results HamiltonsCubic.L120HessPair

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The diagonal operator of a weight**, on the record's encoding. -/
noncomputable def diagW (w : Matrix ι ι ℝ) : CurvLin ι := diagOpL w ∘ₗ skewProj ι

theorem diagW_mem {w : Matrix ι ι ℝ} (h : IsWeight w) : diagW w ∈ weylModuleS ι :=
  comp_skewProj_mem _ (diagOpL_mem h)

theorem diagW_phi {w : Matrix ι ι ℝ} (hs : ∀ a b, w a b = w b a) (i j : ι) :
    diagW w (phi i j) = w i j • phi i j := by
  show diagOp w (skewProj ι (phi i j)) = _
  rw [skewProj_skew _ (phi_isSkew i j)]
  ext p q
  simp only [diagOp, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, phi, Matrix.sub_apply,
    Matrix.single_apply]
  by_cases h1 : j = p <;> by_cases h2 : i = q <;> by_cases h3 : i = p <;> by_cases h4 : j = q <;>
    simp [h1, h2, h3, h4] <;> subst_vars <;> simp [hs]

theorem coord_diagW {w : Matrix ι ι ℝ} (hs : ∀ a b, w a b = w b a) (i j k l : ι) :
    coord (diagW w) i j k l = w i j * ((if i = k ∧ j = l then 1 else 0) - (if i = l ∧ j = k then 1 else 0)) := by
  unfold coord; rw [diagW_phi hs, inner2_smul_left'', Results.inner2_phi_phi]

/-- **Fixed by every single flip.** -/
theorem diagW_flip {w : Matrix ι ι ℝ} (h : IsWeight w) (m : ι) : act (flip m) (diagW w) = diagW w :=
  eq_of_coord _ _ (act_mem _ (flip_orth m) _ (diagW_mem h)) (diagW_mem h) fun i j k l => by
    rw [coord_flip, coord_diagW h.symm]
    by_cases h1 : i = k ∧ j = l
    · obtain ⟨rfl, rfl⟩ := h1
      have : sgn m i * sgn m j * sgn m i * sgn m j = 1 := by
        calc _ = (sgn m i * sgn m i) * (sgn m j * sgn m j) := by ring
          _ = 1 := by rw [sgn_mul_self, sgn_mul_self, one_mul]
      rw [this, one_mul]
    by_cases h2 : i = l ∧ j = k
    · obtain ⟨rfl, rfl⟩ := h2
      have : sgn m i * sgn m j * sgn m j * sgn m i = 1 := by
        calc _ = (sgn m i * sgn m i) * (sgn m j * sgn m j) := by ring
          _ = 1 := by rw [sgn_mul_self, sgn_mul_self, one_mul]
      rw [this, one_mul]
    · simp [h1, h2]

/-- **Fixed by every `diagSet u`**, the hypothesis of `Lop_projS`. -/
theorem diagW_diagSet {w : Matrix ι ι ℝ} (h : IsWeight w) (u : Finset ι) : act (diagSet u) (diagW w) = diagW w := by
  rw [act_diag_set (diagW w) (fun _ => 1) (fun m => by rw [one_smul]; exact diagW_flip h m) u,
    Finset.prod_const_one, one_smul]

/-- **The sphere product `t · W_T` as an element of `weylModuleS`**, at every `n` with `|T|, |Tᶜ| ≥ 2`. -/
noncomputable def sphS (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) : weylModuleS ι :=
  ⟨diagW (t • sphereWeight T), diagW_mem ((sphereWeight_isWeight T hp hq).smul t)⟩

theorem sphS_fixed (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (u : Finset ι) :
    act (diagSet u) ((sphS T hp hq t : weylModuleS ι) : CurvLin ι) = sphS T hp hq t :=
  diagW_diagSet ((sphereWeight_isWeight T hp hq).smul t) u

end HamiltonsCubic.B12Sphere
