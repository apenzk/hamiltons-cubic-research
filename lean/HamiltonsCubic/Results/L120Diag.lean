import HamiltonsCubic.Results.L120Four

set_option linter.style.longLine false

/-!
# L120's trivial summand: the sign-invariant Weyl operators are the diagonal ones, `𝒟ₙ`

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: *"the trivial character on the `binom n 2`
diagonal entries … Ricci-flatness cuts the trivial block by its `n` row sums to `𝒟ₙ`."* A member of `weylModuleS`
fixed by every coordinate flip is:

* **`diag_isotypic`**: the diagonal operator `diagOp w` (precomposed with the skew projection) of the weight
  `w_{ij} = R_{ijij}`, which is symmetric, hollow and has zero row sums (`diagWeight_isWeight`, the row sums being the
  Ricci relations), through [WeylTraceSchur.lean](WeylTraceSchur.lean)'s `coord_reduce_flip`;
* **`diagS_mem`**, **`diagS_flip`**, **`diagS_signMat`**: conversely the diagonal operator of any weight is in
  `weylModuleS` and is fixed by every flip and by every diagonal sign matrix;
* **`diagSummand_iff`**: a member of `weylModuleS` is fixed by the whole sign group `Γ` exactly when it is the diagonal
  operator of a weight.

Its dimension `n(n − 3)/2`, at `n ≥ 3`, is [L120DiagDim.lean](L120DiagDim.lean)'s `diagSummand_finrank` and
`diagSummand_finrank_closed`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.WeylRadical

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The diagonal operator of `w`, precomposed with the skew projection. -/
noncomputable abbrev diagS (w : Matrix ι ι ℝ) : CurvLin ι :=
  diagOpL w ∘ₗ HamiltonsCubic.WeylModuleSNonzero.skewProj ι

theorem diagS_mem {w : Matrix ι ι ℝ} (hw : IsWeight w) : diagS w ∈ weylModuleS ι :=
  HamiltonsCubic.WeylModuleSNonzero.comp_skewProj_mem _ (diagOpL_mem hw)

/-- `diagOp w` scales `φ_{ij}` by `w_{ij}` at a symmetric `w`. -/
theorem diagS_phi {w : Matrix ι ι ℝ} (hs : ∀ a b, w a b = w b a) (i j : ι) :
    diagS w (phi i j) = w i j • phi i j := by
  show diagOp w (HamiltonsCubic.WeylModuleSNonzero.skewProj ι (phi i j)) = _
  rw [HamiltonsCubic.WeylModuleSNonzero.skewProj_skew _ (phi_isSkew i j)]
  ext p q
  simp only [diagOp, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, phi, Matrix.sub_apply,
    Matrix.single_apply]
  by_cases h1 : j = p <;> by_cases h2 : i = q <;> by_cases h3 : i = p <;> by_cases h4 : j = q <;>
    simp [h1, h2, h3, h4] <;> subst_vars <;> simp [hs]

theorem coord_diagS {w : Matrix ι ι ℝ} (hs : ∀ a b, w a b = w b a) (a b c d : ι) :
    coord (diagS w) a b c d = w a b * inner2 (phi a b) (phi c d) := by
  unfold coord; rw [diagS_phi hs, inner2_smul_left'']

/-- The weight read off an operator: `w_{ij} = R_{ijij}`. -/
noncomputable def diagWeight (R : CurvLin ι) : Matrix ι ι ℝ := Matrix.of fun i j => coord R i j i j

/-- **At a Weyl operator the read-off weight is a weight**: symmetric by the index symmetries, hollow, and with zero
row sums by the Ricci relations. -/
theorem diagWeight_isWeight {R : CurvLin ι} (hR : R ∈ weylModuleS ι) : IsWeight (diagWeight R) where
  symm a b := by
    simp only [diagWeight, Matrix.of_apply]
    rw [cd_sw12, cd_sw34, neg_neg]
  hollow a := by simp only [diagWeight, Matrix.of_apply]; exact cd_self12 R a a a
  rowSum a := by simp only [diagWeight, Matrix.of_apply]; exact cd_ric R hR a a

/-- **L120's trivial summand.** A member of `weylModuleS` fixed by every flip is the diagonal operator of its
read-off weight. -/
theorem diag_isotypic (R : CurvLin ι) (hR : R ∈ weylModuleS ι) (hf : ∀ m, act (flip m) R = R) :
    R = diagS (diagWeight R) := by
  have hw := diagWeight_isWeight hR
  refine eq_of_coord _ _ hR (diagS_mem hw) fun a b c d => ?_
  rw [coord_diagS hw.symm, inner2_phi_phi]
  simp only [diagWeight, Matrix.of_apply]
  by_cases h1 : a = c ∧ b = d
  · obtain ⟨rfl, rfl⟩ := h1
    by_cases hab : a = b
    · subst hab; rw [cd_self12]; ring
    · rw [if_pos ⟨rfl, rfl⟩, if_neg (fun h => hab h.1)]; ring
  · by_cases h2 : a = d ∧ b = c
    · obtain ⟨rfl, rfl⟩ := h2
      rw [if_neg h1, if_pos ⟨rfl, rfl⟩, cd_sw34]; ring
    · rw [if_neg h1, if_neg h2, sub_zero, mul_zero]
      exact coord_reduce_flip R hf a b c d (fun h => h1 ⟨h.1.symm, h.2.symm⟩)
        (fun h => h2 ⟨h.2.symm, h.1.symm⟩)

/-- **The diagonal operator of a weight is fixed by every diagonal sign matrix.** -/
theorem diagS_signMat {w : Matrix ι ι ℝ} (hw : IsWeight w) (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    act (signMat ε) (diagS w) = diagS w := by
  refine eq_of_coord _ _ (act_mem _ (signMat_orth ε hε).1 _ (diagS_mem hw)) (diagS_mem hw) fun a b c d => ?_
  rw [coord_sign, coord_diagS hw.symm]
  by_cases h0 : inner2 (phi a b) (phi c d) = 0
  · rw [h0]; ring
  · have ha := hε a
    have hb := hε b
    have hcd := phi_ip_ne h0
    generalize w a b * inner2 (phi a b) (phi c d) = X
    rcases hcd with ⟨hc, hd⟩ | ⟨hc, hd⟩ <;> rw [hc, hd] <;> linear_combination (X * ε b * ε b) * ha + X * hb

/-- The same at every flip. -/
theorem diagS_flip {w : Matrix ι ι ℝ} (hw : IsWeight w) (m : ι) : act (flip m) (diagS w) = diagS w :=
  diagS_signMat hw (sgn m) (sgn_mul_self m)

/-- **The trivial summand at L120's own hypothesis**: a member of `weylModuleS` is fixed by the whole sign group exactly
when it is the diagonal operator of a weight. -/
theorem diagSummand_iff (R : CurvLin ι) (hR : R ∈ weylModuleS ι) :
    (∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) R = R) ↔ ∃ w, IsWeight w ∧ R = diagS w := by
  constructor
  · intro h
    exact ⟨diagWeight R, diagWeight_isWeight hR, diag_isotypic R hR fun m => h (sgn m) (sgn_mul_self m)⟩
  · rintro ⟨w, hw, rfl⟩ ε hε
    exact diagS_signMat hw ε hε

end HamiltonsCubic.Results
