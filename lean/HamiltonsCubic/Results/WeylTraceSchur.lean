import HamiltonsCubic.Results.WeylTraceOperator
import HamiltonsCubic.Results.WeylRadical
import HamiltonsCubic.Results.WeylModuleSNonzero

/-!
# `tr (L e ∘ L f) = κ ⟨e, f⟩` on the record's `𝒲ₙ`

Stage 3 of the approved `trace_leftMulS_comp` build, and its end. **`T` is a scalar**
(`Tw_scalar`), so `B(e,f) = ⟨T e, f⟩ = κ ⟨e, f⟩`, which is `trace_leftMulS_comp`. The statement
moved here from [WeylTraceStrict.lean](WeylTraceStrict.lean) because its proof imports more than
that file.

The argument runs on coordinates `v_ijkl = ⟨v φ_ij, φ_kl⟩` and needs no irreducibility theory.

* **An eigenvector** (`Tw_EQ`). For four distinct indices, `E_q` is the diagonal Weyl operator of
  the weight `+1` on `{a,b}` and `{c,d}`, `-1` on `{a,c}` and `{b,d}`. `T E_q` is fixed by every
  flip, so only `R_ijij` survives (`coord_reduce_flip`). It is fixed by `(a b)(c d)` and negated
  by `(b c)`, which forces its diagonal to be a multiple of the weight (`t_zero`).
* **One eigenvalue** (`EQ_transport`). A permutation carries any `E_q` to any other.
* **Spanning** (`span_EQ`). A Weyl operator orthogonal to every rotation of every `E_q` is zero.
  The four-term relations `v_abab + v_cdcd = v_acac + v_bdbd`, summed against Ricci-flatness,
  give `(n - 2)(v_abab - v_acac) = 0`, then `(n - 1) v_abab = 0` (`sdiag_zero`). The rational
  rotation with cosine `3/5` then gives `v_abcb = 0` (`one_common_zero`), the same rotation
  applied twice gives `v_abcd + v_adcb = 0`, and Bianchi gives `3 v_abcd = 0`.
* **Schur**. `T x - κ x` is orthogonal to every rotation of every `E_q`, since `T` is
  self-adjoint and commutes with the action, so it is zero.

At `n ≤ 3` there are no four distinct indices, the spanning hypothesis is empty, and the same
lemma shows `𝒲ₙ = 0`.
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.WeylRadical
  HamiltonsCubic.WeylModuleSNonzero Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedSectionVars false
set_option linter.style.longLine false

theorem inner2_phi_phi (i j k l : ι) :
    inner2 (phi i j) (phi k l) = (if i = k ∧ j = l then 1 else 0) - (if i = l ∧ j = k then 1 else 0) := by
  rw [inner2_phi_eq]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply]
  by_cases h1 : i = k <;> by_cases h2 : j = l <;> by_cases h3 : i = l <;> by_cases h4 : j = k <;>
    simp [h1, h2, h3, h4] <;> (try split_ifs) <;> (try norm_num) <;> tauto

theorem cd_sw12 (R : CurvLin ι) (i j k l : ι) : coord R i j k l = -coord R j i k l := by
  unfold coord; rw [phi_swap i j, map_neg]; simp [inner2]

theorem cd_sw34 (R : CurvLin ι) (i j k l : ι) : coord R i j k l = -coord R i j l k := by
  unfold coord; rw [phi_swap k l]; simp [inner2]

theorem cd_self12 (R : CurvLin ι) (i k l : ι) : coord R i i k l = 0 := by
  unfold coord; rw [phi_self, map_zero]; simp [inner2]

theorem cd_self34 (R : CurvLin ι) (i j k : ι) : coord R i j k k = 0 := by
  unfold coord; rw [phi_self]; simp [inner2]

theorem cd_pair (R : CurvLin ι) (hR : R ∈ weylModuleS ι) (i j k l : ι) :
    coord R i j k l = coord R k l i j := by
  unfold coord
  rw [hR.1.2.1 _ _ (phi_isSkew i j) (phi_isSkew k l), inner2_comm]

theorem cd_bianchi (R : CurvLin ι) (hR : R ∈ weylModuleS ι) (i j k l : ι) :
    coord R i j k l + coord R i k l j + coord R i l j k = 0 := hR.1.2.2.1 i j k l

theorem cd_ric (R : CurvLin ι) (hR : R ∈ weylModuleS ι) (a b : ι) :
    ∑ c, coord R a c b c = 0 := hR.1.2.2.2 a b

theorem cd_ext (R : CurvLin ι) (hR : R ∈ weylModuleS ι) (h : ∀ i j k l, coord R i j k l = 0) :
    R = 0 :=
  eq_zero_of_phi R hR fun i j =>
    skew_eq_zero_of_coord _ (hR.1.1 _ (phi_isSkew i j)) (fun k l => h i j k l)

/-- The indicator of the unordered pair `{x, y}`. -/
def pairF (x y i j : ι) : ℝ := if (i = x ∧ j = y) ∨ (i = y ∧ j = x) then 1 else 0

theorem pairF_symm (x y i j : ι) : pairF x y i j = pairF x y j i := by
  unfold pairF; congr 1; apply propext; constructor <;> rintro (⟨h1, h2⟩ | ⟨h1, h2⟩) <;> simp_all

theorem pairF_self {x y : ι} (hxy : x ≠ y) (i : ι) : pairF x y i i = 0 := by
  unfold pairF; rw [if_neg]; rintro (⟨h1, h2⟩ | ⟨h1, h2⟩) <;> exact hxy (h1 ▸ h2 ▸ rfl)

theorem pairF_sum {x y : ι} (hxy : x ≠ y) (i : ι) :
    ∑ j, pairF x y i j = (if i = x then 1 else 0) + (if i = y then 1 else 0) := by
  have : ∀ j, pairF x y i j = (if i = x ∧ j = y then 1 else 0) + (if i = y ∧ j = x then 1 else 0) := by
    intro j; unfold pairF
    by_cases h1 : i = x ∧ j = y
    · obtain ⟨rfl, rfl⟩ := h1; simp [hxy]
    · simp [h1]
  simp only [this, Finset.sum_add_distrib, ite_and, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  split_ifs <;> simp

theorem pairF_perm (σ : Equiv.Perm ι) (x y i j : ι) :
    pairF x y (σ i) (σ j) = pairF (σ.symm x) (σ.symm y) i j := by
  unfold pairF; simp only [Equiv.apply_eq_iff_eq_symm_apply]

/-- **The weight of `E_q`**: `+1` on `{a,b}` and `{c,d}`, `-1` on `{a,c}` and `{b,d}`. -/
def wQ (a b c d : ι) : Matrix ι ι ℝ :=
  Matrix.of fun i j => pairF a b i j + pairF c d i j - pairF a c i j - pairF b d i j

/-- Four distinct indices. -/
structure Distinct4 (a b c d : ι) : Prop where
  ab : a ≠ b
  ac : a ≠ c
  ad : a ≠ d
  bc : b ≠ c
  bd : b ≠ d
  cd : c ≠ d

theorem wQ_isWeight {a b c d : ι} (h : Distinct4 a b c d) : IsWeight (wQ a b c d) where
  symm i j := by simp only [wQ, Matrix.of_apply]; rw [pairF_symm a b, pairF_symm c d, pairF_symm a c, pairF_symm b d]
  hollow i := by simp [wQ, pairF_self h.ab, pairF_self h.cd, pairF_self h.ac, pairF_self h.bd]
  rowSum i := by
    simp only [wQ, Matrix.of_apply, Finset.sum_sub_distrib, Finset.sum_add_distrib,
      pairF_sum h.ab, pairF_sum h.cd, pairF_sum h.ac, pairF_sum h.bd]
    ring

/-- **`E_q`**, the diagonal Weyl operator of the weight `wQ`. -/
noncomputable def EQ (a b c d : ι) : CurvLin ι := diagOpL (wQ a b c d) ∘ₗ skewProj ι

theorem EQ_mem {a b c d : ι} (h : Distinct4 a b c d) : EQ a b c d ∈ weylModuleS ι :=
  comp_skewProj_mem _ (diagOpL_mem (wQ_isWeight h))

theorem EQ_phi {a b c d : ι} (h : Distinct4 a b c d) (i j : ι) :
    EQ a b c d (phi i j) = wQ a b c d i j • phi i j := by
  have hs := (wQ_isWeight h).symm
  show diagOp (wQ a b c d) (skewProj ι (phi i j)) = _
  rw [skewProj_skew _ (phi_isSkew i j)]
  ext p q
  simp only [diagOp, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, phi, Matrix.sub_apply,
    Matrix.single_apply]
  by_cases h1 : j = p <;> by_cases h2 : i = q <;> by_cases h3 : i = p <;> by_cases h4 : j = q <;>
    simp [h1, h2, h3, h4] <;> subst_vars <;> simp [hs]

theorem coord_EQ {a b c d : ι} (h : Distinct4 a b c d) (i j k l : ι) :
    coord (EQ a b c d) i j k l = wQ a b c d i j * inner2 (phi i j) (phi k l) := by
  unfold coord; rw [EQ_phi h, inner2_smul_left'']

/-! ## Stage B: `T E_q = κ_q E_q` -/

theorem coord_sub (R S : CurvLin ι) (i j k l : ι) :
    coord (R - S) i j k l = coord R i j k l - coord S i j k l := by
  unfold coord; simp only [LinearMap.sub_apply, inner2, Matrix.transpose_sub, Matrix.sub_mul,
    Matrix.trace_sub]; ring

theorem coord_smul (c : ℝ) (R : CurvLin ι) (i j k l : ι) :
    coord (c • R) i j k l = c * coord R i j k l := by
  unfold coord; rw [LinearMap.smul_apply, inner2_smul_left'']

theorem eq_of_coord (R S : CurvLin ι) (hR : R ∈ weylModuleS ι) (hS : S ∈ weylModuleS ι)
    (h : ∀ i j k l, coord R i j k l = coord S i j k l) : R = S :=
  sub_eq_zero.mp (cd_ext _ (sub_mem hR hS) fun i j k l => by rw [coord_sub, h, sub_self])

theorem sgn_mul_self (m i : ι) : sgn m i * sgn m i = 1 := by unfold sgn; split_ifs <;> norm_num

/-- An index met an odd number of times kills a flip-invariant coordinate. -/
theorem coord_odd (R : CurvLin ι) (m : ι) (hf : act (flip m) R = R) {i j k l : ι}
    (h : sgn m i * sgn m j * sgn m k * sgn m l = -1) : coord R i j k l = 0 := by
  have := coord_flip m R i j k l
  rw [hf, h] at this; linarith

/-- **A flip-invariant operator has only the coordinates `R_ijij` and `R_ijji`.** -/
theorem coord_reduce_flip (R : CurvLin ι) (hf : ∀ m, act (flip m) R = R) (i j k l : ι)
    (hkl : ¬(k = i ∧ l = j)) (hlk : ¬(k = j ∧ l = i)) : coord R i j k l = 0 := by
  by_cases hij : i = j
  · subst hij; exact cd_self12 R i k l
  by_cases hkl' : k = l
  · subst hkl'; exact cd_self34 R i j k
  by_cases hi : i = k ∨ i = l
  · by_cases hj : j = k ∨ j = l
    · exfalso
      rcases hi with hi | hi <;> rcases hj with hj | hj
      · exact hij (hi.trans hj.symm)
      · exact hkl ⟨hi.symm, hj.symm⟩
      · exact hlk ⟨hj.symm, hi.symm⟩
      · exact hij (hi.trans hj.symm)
    · push Not at hj
      apply coord_odd R j (hf j)
      simp [sgn, hij, Ne.symm hj.1, Ne.symm hj.2, Ne.symm hij]
  · push Not at hi
    apply coord_odd R i (hf i)
    simp [sgn, hij, hi.1, hi.2, Ne.symm hij, Ne.symm hi.1, Ne.symm hi.2]

theorem coord_EQ_eq {a b c d : ι} (h : Distinct4 a b c d) (i j k l : ι) :
    coord (EQ a b c d) i j k l =
      wQ a b c d i j * ((if i = k ∧ j = l then 1 else 0) - (if i = l ∧ j = k then 1 else 0)) := by
  rw [coord_EQ h, inner2_phi_phi]

theorem EQ_flip {a b c d : ι} (h : Distinct4 a b c d) (m : ι) :
    act (flip m) (EQ a b c d) = EQ a b c d :=
  eq_of_coord _ _ (act_mem _ (flip_orth m) _ (EQ_mem h)) (EQ_mem h) fun i j k l => by
    rw [coord_flip, coord_EQ_eq h]
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

theorem Distinct4.perm {a b c d : ι} (h : Distinct4 a b c d) (σ : Equiv.Perm ι) :
    Distinct4 (σ a) (σ b) (σ c) (σ d) :=
  ⟨σ.injective.ne h.ab, σ.injective.ne h.ac, σ.injective.ne h.ad, σ.injective.ne h.bc,
    σ.injective.ne h.bd, σ.injective.ne h.cd⟩

theorem wQ_perm (σ : Equiv.Perm ι) (a b c d i j : ι) :
    wQ a b c d (σ i) (σ j) = wQ (σ.symm a) (σ.symm b) (σ.symm c) (σ.symm d) i j := by
  simp only [wQ, Matrix.of_apply, pairF_perm]

/-- **A permutation moves `E_q` to `E_{σ⁻¹ q}`.** -/
theorem EQ_perm {a b c d : ι} (h : Distinct4 a b c d) (σ : Equiv.Perm ι) :
    act (permMat σ) (EQ a b c d) = EQ (σ.symm a) (σ.symm b) (σ.symm c) (σ.symm d) :=
  eq_of_coord _ _ (act_mem _ (permMat_orth σ) _ (EQ_mem h)) (EQ_mem (h.perm σ.symm)) fun i j k l => by
    rw [coord_perm, coord_EQ_eq h, coord_EQ_eq (h.perm σ.symm), wQ_perm]
    simp only [σ.injective.eq_iff]

theorem wQ_swap_bc (a b c d : ι) : wQ a c b d = -wQ a b c d := by
  ext i j; simp only [wQ, Matrix.of_apply, Matrix.neg_apply]; ring

theorem coord_neg (R : CurvLin ι) (i j k l : ι) : coord (-R) i j k l = -coord R i j k l := by
  unfold coord; simp [inner2]

theorem pairF_comm (x y i j : ι) : pairF x y i j = pairF y x i j := by
  unfold pairF; congr 1; apply propext; tauto

theorem Distinct4.acbd {a b c d : ι} (h : Distinct4 a b c d) : Distinct4 a c b d :=
  ⟨h.ac, h.ab, h.ad, h.bc.symm, h.cd, h.bd⟩

theorem EQ_acbd {a b c d : ι} (h : Distinct4 a b c d) : EQ a c b d = -EQ a b c d :=
  eq_of_coord _ _ (EQ_mem h.acbd) (neg_mem (EQ_mem h)) fun i j k l => by
    rw [coord_neg, coord_EQ_eq h.acbd, coord_EQ_eq h, wQ_swap_bc, Matrix.neg_apply]; ring

theorem EQ_badc (a b c d : ι) : EQ b a d c = EQ a b c d := by
  have : wQ b a d c = wQ a b c d := by
    ext i j; simp only [wQ, Matrix.of_apply]; rw [pairF_comm b a, pairF_comm d c, pairF_comm b d, pairF_comm a c]; ring
  simp only [EQ, this]

theorem wQ_ab {a b c d : ι} (h : Distinct4 a b c d) : wQ a b c d a b = 1 := by
  simp [wQ, pairF, h.ab, h.ac, h.ad, h.bc, h.bd, h.cd, h.ab.symm, h.ac.symm, h.ad.symm, h.bc.symm,
    h.bd.symm, h.cd.symm]

/-- **The combinatorial core of the eigenvector step.** -/
theorem t_zero {a b c d : ι} (h : Distinct4 a b c d) (t : ι → ι → ℝ)
    (hsym : ∀ x z, t x z = t z x) (hdiag : ∀ x, t x x = 0)
    (h1 : ∀ x z, t (Equiv.swap b c x) (Equiv.swap b c z) = -t x z)
    (h2 : ∀ x z, t (Equiv.swap a b (Equiv.swap c d x)) (Equiv.swap a b (Equiv.swap c d z)) = t x z)
    (hab : t a b = 0) : ∀ x z, t x z = 0 := by
  have A : ∀ x z, x ≠ b → x ≠ c → z ≠ b → z ≠ c → t x z = 0 := by
    intro x z hxb hxc hzb hzc
    have := h1 x z
    rw [Equiv.swap_apply_of_ne_of_ne hxb hxc, Equiv.swap_apply_of_ne_of_ne hzb hzc] at this
    linarith
  have hac : t a c = 0 := by
    have := h1 a b
    rw [Equiv.swap_apply_of_ne_of_ne h.ab h.ac, Equiv.swap_apply_left] at this
    linarith
  have B : ∀ z, z ≠ b → z ≠ c → t b z = 0 := by
    intro z hzb hzc
    by_cases hza : z = a
    · rw [hza, hsym]; exact hab
    by_cases hzd : z = d
    · have := h2 b d
      rw [Equiv.swap_apply_of_ne_of_ne h.bc h.bd, Equiv.swap_apply_right, Equiv.swap_apply_right,
        Equiv.swap_apply_of_ne_of_ne h.ac.symm h.bc.symm] at this
      rw [hzd]; linarith
    · have := h2 b z
      rw [Equiv.swap_apply_of_ne_of_ne h.bc h.bd, Equiv.swap_apply_right,
        Equiv.swap_apply_of_ne_of_ne hzc hzd, Equiv.swap_apply_of_ne_of_ne hza hzb] at this
      have := A a z h.ab h.ac hzb hzc
      linarith
  have C : ∀ z, z ≠ b → z ≠ c → t c z = 0 := by
    intro z hzb hzc
    have := h1 c z
    rw [Equiv.swap_apply_right, Equiv.swap_apply_of_ne_of_ne hzb hzc] at this
    have := B z hzb hzc
    linarith
  have hbc : t b c = 0 := by
    have := h1 b c
    rw [Equiv.swap_apply_left, Equiv.swap_apply_right, hsym c b] at this
    linarith
  intro x z
  by_cases hx : x = b ∨ x = c
  · by_cases hz : z = b ∨ z = c
    · rcases hx with hx | hx <;> rcases hz with hz | hz <;> rw [hx, hz]
      · exact hdiag b
      · exact hbc
      · rw [hsym]; exact hbc
      · exact hdiag c
    · push Not at hz
      rcases hx with hx | hx <;> rw [hx]
      · exact B z hz.1 hz.2
      · exact C z hz.1 hz.2
  · push Not at hx
    by_cases hz : z = b ∨ z = c
    · rw [hsym]
      rcases hz with hz | hz <;> rw [hz]
      · exact B x hx.1 hx.2
      · exact C x hx.1 hx.2
    · push Not at hz
      exact A x z hx.1 hx.2 hz.1 hz.2

theorem neg_one_smul_curv (R : CurvLin ι) : (-1 : ℝ) • R = -R := by
  ext Z p q; simp

/-- `E_q` as a member of `𝒲ₙ`. -/
noncomputable def EQs {a b c d : ι} (h : Distinct4 a b c d) : weylModuleS ι := ⟨EQ a b c d, EQ_mem h⟩

/-- `T` commutes with the action of a permutation or flip, read on coordinates. -/
theorem Tw_act_coe {g : Matrix ι ι ℝ} (hg : gᵀ * g = 1) (e : weylModuleS ι) :
    act g (Tw e : CurvLin ι) = (Tw (actS g hg e) : CurvLin ι) := by
  rw [Top_act hg e]; rfl

theorem swap2_symm (a b c d : ι) (h : Distinct4 a b c d) :
    (Equiv.swap a b * Equiv.swap c d).symm a = b ∧ (Equiv.swap a b * Equiv.swap c d).symm b = a ∧
    (Equiv.swap a b * Equiv.swap c d).symm c = d ∧ (Equiv.swap a b * Equiv.swap c d).symm d = c := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> rw [Equiv.symm_apply_eq, Equiv.Perm.mul_apply]
  · rw [Equiv.swap_apply_of_ne_of_ne h.bc h.bd, Equiv.swap_apply_right]
  · rw [Equiv.swap_apply_of_ne_of_ne h.ac h.ad, Equiv.swap_apply_left]
  · rw [Equiv.swap_apply_right, Equiv.swap_apply_of_ne_of_ne h.ac.symm h.bc.symm]
  · rw [Equiv.swap_apply_left, Equiv.swap_apply_of_ne_of_ne h.ad.symm h.bd.symm]

/-- **`E_q` is an eigenvector of `T`.** -/
theorem Tw_EQ {a b c d : ι} (h : Distinct4 a b c d) :
    Tw (EQs h) = coord (Tw (EQs h) : CurvLin ι) a b a b • EQs h := by
  set y : CurvLin ι := (Tw (EQs h) : CurvLin ι) with hy
  set lam := coord y a b a b
  have hymem : y ∈ weylModuleS ι := (Tw (EQs h)).2
  -- flips
  have hf : ∀ m, act (flip m) y = y := fun m => by
    rw [hy, Tw_act_coe (flip_orth m)]
    congr 2; exact Subtype.ext (EQ_flip h m)
  -- the swap `(b c)` negates
  have hp1 : act (permMat (Equiv.swap b c)) y = -y := by
    rw [hy, Tw_act_coe (permMat_orth _)]
    have : actS (permMat (Equiv.swap b c)) (permMat_orth _) (EQs h) = (-1 : ℝ) • EQs h := by
      apply Subtype.ext
      show act (permMat (Equiv.swap b c)) (EQ a b c d) = (-1 : ℝ) • EQ a b c d
      rw [neg_one_smul_curv]
      rw [EQ_perm h, Equiv.symm_swap, Equiv.swap_apply_of_ne_of_ne h.ab h.ac,
        Equiv.swap_apply_left, Equiv.swap_apply_right, Equiv.swap_apply_of_ne_of_ne h.bd.symm h.cd.symm]
      exact EQ_acbd h
    rw [this, map_smul]
    exact neg_one_smul_curv _
  -- the Klein element `(a b)(c d)` fixes
  have hp2 : act (permMat (Equiv.swap a b * Equiv.swap c d)) y = y := by
    rw [hy, Tw_act_coe (permMat_orth _)]
    have : actS (permMat (Equiv.swap a b * Equiv.swap c d)) (permMat_orth _) (EQs h) = EQs h := by
      apply Subtype.ext
      show act (permMat (Equiv.swap a b * Equiv.swap c d)) (EQ a b c d) = EQ a b c d
      obtain ⟨e1, e2, e3, e4⟩ := swap2_symm a b c d h
      rw [EQ_perm h, e1, e2, e3, e4]
      exact EQ_badc a b c d
    rw [this]
  have hw := wQ_isWeight h
  -- the diagonal
  set t : ι → ι → ℝ := fun x z => coord y x z x z - lam * wQ a b c d x z with ht
  have htz : ∀ x z, t x z = 0 := by
    apply t_zero h t
    · intro x z; simp only [ht]
      rw [cd_sw12 y x z, cd_sw34 y z x, neg_neg, hw.symm]
    · intro x; simp only [ht]; rw [cd_self12, hw.hollow]; ring
    · intro x z; simp only [ht]
      have e := coord_perm (Equiv.swap b c) y x z x z
      rw [hp1, coord_neg] at e
      rw [← e, wQ_perm, Equiv.symm_swap, Equiv.swap_apply_of_ne_of_ne h.ab h.ac,
        Equiv.swap_apply_left, Equiv.swap_apply_right, Equiv.swap_apply_of_ne_of_ne h.bd.symm h.cd.symm,
        wQ_swap_bc, Matrix.neg_apply]; ring
    · intro x z; simp only [ht]
      have e := coord_perm (Equiv.swap a b * Equiv.swap c d) y x z x z
      rw [hp2] at e
      obtain ⟨e1, e2, e3, e4⟩ := swap2_symm a b c d h
      have e' : wQ a b c d (Equiv.swap a b (Equiv.swap c d x)) (Equiv.swap a b (Equiv.swap c d z)) =
          wQ a b c d x z := by
        have := wQ_perm (Equiv.swap a b * Equiv.swap c d) a b c d x z
        rw [e1, e2, e3, e4] at this
        simp only [Equiv.Perm.mul_apply] at this
        rw [this]
        have k : wQ b a d c = wQ a b c d := by
          ext i j; simp only [wQ, Matrix.of_apply]
          rw [pairF_comm b a, pairF_comm d c, pairF_comm b d, pairF_comm a c]; ring
        rw [k]
      simp only [Equiv.Perm.mul_apply] at e
      rw [← e, e']
    · simp only [ht]; rw [wQ_ab h]; ring
  apply Subtype.ext
  show y = lam • EQ a b c d
  refine eq_of_coord _ _ hymem (Submodule.smul_mem _ _ (EQ_mem h)) fun i j k l => ?_
  rw [coord_smul, coord_EQ_eq h]
  by_cases h1 : k = i ∧ l = j
  · obtain ⟨rfl, rfl⟩ := h1
    by_cases hij : k = l
    · subst hij; rw [cd_self12, hw.hollow]; ring
    · have := htz k l; simp only [ht] at this
      simp [hij]; linarith
  by_cases h2 : k = j ∧ l = i
  · obtain ⟨rfl, rfl⟩ := h2
    by_cases hij : k = l
    · subst hij; rw [cd_self12, hw.hollow]; ring
    · have := htz l k; simp only [ht] at this
      rw [cd_sw34]; simp [hij, Ne.symm hij]; linarith
  · rw [coord_reduce_flip y hf i j k l h1 h2]
    have n1 : ¬(i = k ∧ j = l) := fun ⟨p, q⟩ => h1 ⟨p.symm, q.symm⟩
    have n2 : ¬(i = l ∧ j = k) := fun ⟨p, q⟩ => h2 ⟨q.symm, p.symm⟩
    simp [n1, n2]

/-! ## Stage C: the rotations of the `E_q` span `𝒲ₙ` -/

theorem sum_pair_single (x y : ι) (c : ℝ) : ∑ i, ∑ j, (if i = x ∧ j = y then c else 0) = c := by
  rw [Fintype.sum_eq_single x (fun i hi => by simp [hi])]
  simp

theorem pairF_wsum {x y : ι} (hxy : x ≠ y) (F : ι → ι → ℝ) :
    ∑ i, ∑ j, pairF x y i j * F i j = F x y + F y x := by
  have : ∀ i j, pairF x y i j * F i j =
      (if i = x ∧ j = y then F x y else 0) + (if i = y ∧ j = x then F y x else 0) := by
    intro i j; unfold pairF
    by_cases h1 : i = x ∧ j = y
    · obtain ⟨rfl, rfl⟩ := h1; simp [hxy]
    · by_cases h2 : i = y ∧ j = x
      · obtain ⟨rfl, rfl⟩ := h2; simp [hxy, Ne.symm hxy]
      · simp [h1, h2]
  simp only [this, Finset.sum_add_distrib, sum_pair_single]

/-- **`⟨v, E_q⟩ = v_abab + v_cdcd − v_acac − v_bdbd`.** -/
theorem innerOp_EQ (v : CurvLin ι) {a b c d : ι} (h : Distinct4 a b c d) :
    innerOp (fun Z => v Z) (fun Z => EQ a b c d Z) =
      (1 / 2) * ((coord v a b a b + coord v b a b a) + (coord v c d c d + coord v d c d c)
        - (coord v a c a c + coord v c a c a) - (coord v b d b d + coord v d b d b)) := by
  unfold innerOp
  have e : ∀ i j, inner2 (v (phi i j)) (EQ a b c d (phi i j)) =
      pairF a b i j * coord v i j i j + pairF c d i j * coord v i j i j
        - pairF a c i j * coord v i j i j - pairF b d i j * coord v i j i j := by
    intro i j; rw [EQ_phi h, inner2_smul_right'']; simp only [wQ, Matrix.of_apply, coord]; ring
  simp only [e, Finset.sum_sub_distrib, Finset.sum_add_distrib,
    pairF_wsum h.ab (fun i j => coord v i j i j), pairF_wsum h.cd (fun i j => coord v i j i j),
    pairF_wsum h.ac (fun i j => coord v i j i j), pairF_wsum h.bd (fun i j => coord v i j i j)]

theorem sdiag_symm (v : CurvLin ι) (x z : ι) : coord v z x z x = coord v x z x z := by
  rw [cd_sw12, cd_sw34 v x z, neg_neg]

/-- **The permutation step**: the four-term relations and Ricci-flatness kill `v_abab`. -/
theorem sdiag_zero (v : CurvLin ι) (hv : v ∈ weylModuleS ι)
    (hrel : ∀ a b c d : ι, Distinct4 a b c d →
      coord v a b a b + coord v c d c d - coord v a c a c - coord v b d b d = 0) (a b : ι) :
    coord v a b a b = 0 := by
  set s : ι → ι → ℝ := fun x z => coord v x z x z with hs
  have ssym : ∀ x z, s x z = s z x := fun x z => (sdiag_symm v x z).symm
  have sself : ∀ x, s x x = 0 := fun x => cd_self12 v x x x
  have sric : ∀ x, ∑ z, s x z = 0 := fun x => cd_ric v hv x x
  have n := (Fintype.card ι : ℝ)
  -- `s_ab = s_ac`
  have step : ∀ x y z : ι, x ≠ y → x ≠ z → y ≠ z → s x y = s x z := by
    intro x y z hxy hxz hyz
    set f : ι → ℝ := fun w => s x y + s z w - s x z - s y w with hf
    have hfw : ∀ w, f w = (if w = x then f x else 0) + (if w = y then f y else 0) + (if w = z then f z else 0) := by
      intro w
      by_cases h1 : w = x
      · subst h1; simp [hxy, hxz]
      by_cases h2 : w = y
      · subst h2; simp [h1, Ne.symm hxy, hyz]
      by_cases h3 : w = z
      · subst h3; simp [h1, h2]
      simp only [h1, h2, h3, if_false, add_zero]
      have := hrel x y z w ⟨hxy, hxz, Ne.symm h1, hyz, Ne.symm h2, Ne.symm h3⟩
      simp only [hf, hs]; linarith
    have hsum : ∑ w, f w = f x + f y + f z := by
      rw [Finset.sum_congr rfl fun w _ => hfw w]
      simp only [Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true]
    have hsum' : ∑ w, f w = (Fintype.card ι : ℝ) * (s x y - s x z) := by
      simp only [hf, Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ,
        nsmul_eq_mul, sric]; ring
    have hfx : f x = 0 := by simp only [hf]; rw [ssym z x, ssym y x]; ring
    have hfy : f y = s x y + s z y - s x z := by simp only [hf]; rw [sself]; ring
    have hfz : f z = s x y - s x z - s y z := by simp only [hf]; rw [sself]; ring
    have hcard : (3 : ℝ) ≤ Fintype.card ι := by
      have : ({x, y, z} : Finset ι).card ≤ Fintype.card ι := Finset.card_le_univ _
      rw [Finset.card_insert_of_notMem (by simp [hxy, hxz]), Finset.card_pair hyz] at this
      exact_mod_cast this
    rw [hsum', hfx, hfy, hfz, ssym z y] at hsum
    have : ((Fintype.card ι : ℝ) - 2) * (s x y - s x z) = 0 := by linarith
    rcases mul_eq_zero.mp this with h0 | h0
    · linarith
    · linarith
  by_cases hab : a = b
  · subst hab; exact sself a
  have hall : ∀ z, s a z = s a b - (if z = a then s a b else 0) := by
    intro z
    by_cases hza : z = a
    · subst hza; simp [sself]
    by_cases hzb : z = b
    · subst hzb; simp [hza]
    simp only [hza, if_false, sub_zero]
    exact (step a b z hab (Ne.symm hza) (Ne.symm hzb)).symm
  have h0 := sric a
  rw [Finset.sum_congr rfl fun z _ => hall z] at h0
  simp only [Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ, nsmul_eq_mul,
    Finset.sum_ite_eq', Finset.mem_univ, if_true] at h0
  have hcard : (2 : ℝ) ≤ Fintype.card ι := by
    have : ({a, b} : Finset ι).card ≤ Fintype.card ι := Finset.card_le_univ _
    rw [Finset.card_pair hab] at this
    exact_mod_cast this
  have : ((Fintype.card ι : ℝ) - 1) * s a b = 0 := by linarith
  rcases mul_eq_zero.mp this with h1 | h1
  · linarith
  · exact h1

/-- **The rational rotation** by the angle with cosine `3/5` in the plane `(a, c)`. -/
noncomputable def rotM (a c : ι) : Matrix ι ι ℝ := Matrix.of fun p q =>
  if p = a then (if q = a then 3 / 5 else if q = c then 4 / 5 else 0)
  else if p = c then (if q = a then -4 / 5 else if q = c then 3 / 5 else 0)
  else (if q = p then 1 else 0)

theorem sum_two {a c : ι} (hac : a ≠ c) (u v : ℝ) (F : ι → ℝ) :
    ∑ q, (if q = a then u else if q = c then v else 0) * F q = u * F a + v * F c := by
  have : ∀ q, (if q = a then u else if q = c then v else 0) * F q =
      (if q = a then u * F a else 0) + (if q = c then v * F c else 0) := by
    intro q
    by_cases h1 : q = a
    · subst h1; simp [hac]
    · by_cases h2 : q = c
      · subst h2; simp [h1]
      · simp [h1, h2]
  simp only [this, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true]

theorem rot_row_a {a c : ι} (hac : a ≠ c) (F : ι → ℝ) :
    ∑ q, rotM a c a q * F q = 3 / 5 * F a + 4 / 5 * F c := by
  simp only [rotM, Matrix.of_apply, if_true]; exact sum_two hac _ _ F

theorem rot_row_c {a c : ι} (hac : a ≠ c) (F : ι → ℝ) :
    ∑ q, rotM a c c q * F q = -4 / 5 * F a + 3 / 5 * F c := by
  simp only [rotM, Matrix.of_apply, Ne.symm hac, if_false, if_true]; exact sum_two hac _ _ F

theorem rot_row_o {a c p : ι} (hpa : p ≠ a) (hpc : p ≠ c) (F : ι → ℝ) :
    ∑ q, rotM a c p q * F q = F p := by
  simp only [rotM, Matrix.of_apply, hpa, hpc, if_false, ite_mul, one_mul, zero_mul,
    Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]

theorem rotM_orth {a c : ι} (hac : a ≠ c) : (rotM a c)ᵀ * rotM a c = 1 := by
  rw [mul_eq_one_comm]
  ext p r
  simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply]
  by_cases hpa : p = a
  · rw [hpa, rot_row_a hac (fun q => rotM a c r q)]
    by_cases hra : r = a
    · rw [hra]; simp [rotM, hac, Ne.symm hac] <;> norm_num
    by_cases hrc : r = c
    · rw [hrc]; simp [rotM, hac, Ne.symm hac] <;> norm_num
    · simp [rotM, hra, hrc, Ne.symm hra, Ne.symm hrc]
  by_cases hpc : p = c
  · rw [hpc, rot_row_c hac (fun q => rotM a c r q)]
    by_cases hra : r = a
    · rw [hra]; simp [rotM, hac, Ne.symm hac] <;> norm_num
    by_cases hrc : r = c
    · rw [hrc]; simp [rotM, hac, Ne.symm hac] <;> norm_num
    · simp [rotM, hra, hrc, Ne.symm hra, Ne.symm hrc]
  · rw [rot_row_o hpa hpc (fun q => rotM a c r q)]
    by_cases hra : r = a
    · rw [hra]; simp [rotM, hpa, hpc, Ne.symm hpa, Ne.symm hpc]
    by_cases hrc : r = c
    · rw [hrc]; simp [rotM, hpa, hpc, Ne.symm hpa, Ne.symm hpc, hac, Ne.symm hac]
    · simp [rotM, hra, hrc, Ne.symm hra, Ne.symm hrc]

theorem act_one' (R : CurvLin ι) : act 1 R = R := by
  apply LinearMap.ext; intro Z; simp [act_apply]

/-- The coordinate law, nested so that each row is summed on its own. -/
theorem coord_act_nested (g : Matrix ι ι ℝ) (R : CurvLin ι) (i j k l : ι) :
    coord (act g R) i j k l =
      ∑ p, g i p * ∑ q, g j q * ∑ r, g k r * ∑ t, g l t * coord R p q r t := by
  unfold coord; rw [act_coord]
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ =>
    Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun t _ => ?_
  ring

/-- Every diagonal coordinate of every rotation of `v` vanishes. -/
def AllDiagZero (v : CurvLin ι) : Prop :=
  ∀ g : Matrix ι ι ℝ, gᵀ * g = 1 → ∀ x z, coord (act g v) x z x z = 0

theorem AllDiagZero.act {v : CurvLin ι} (hv : AllDiagZero v) {h : Matrix ι ι ℝ} (hh : hᵀ * h = 1) :
    AllDiagZero (act h v) := fun g hg x z => by
  rw [act_comp]; exact hv _ (orth_mul hg hh) x z

/-- **One shared index**: `v_abcb = 0`. -/
theorem one_common_zero {v : CurvLin ι} (hvm : v ∈ weylModuleS ι) (hv : AllDiagZero v) {a b c : ι}
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) : coord v a b c b = 0 := by
  have h0 := hv (rotM a c) (rotM_orth hac) a b
  simp only [coord_act_nested, rot_row_a hac, rot_row_o (p := b) (Ne.symm hab) hbc] at h0
  have s1 := hv 1 (by simp) a b
  have s2 := hv 1 (by simp) c b
  rw [act_one'] at s1 s2
  rw [cd_pair v hvm c b a b] at h0
  linarith

/-- **Two pairs of indices**: `v_abcd + v_adcb = 0`. -/
theorem two_pair_rel {v : CurvLin ι} (hvm : v ∈ weylModuleS ι) (hv : AllDiagZero v) {a b c d : ι}
    (h : Distinct4 a b c d) : coord v a b c d + coord v a d c b = 0 := by
  have hu := one_common_zero (act_mem _ (rotM_orth h.bd) v hvm) (hv.act (rotM_orth h.bd)) h.ab h.ac h.bc
  simp only [coord_act_nested, rot_row_o (p := a) h.ab h.ad, rot_row_a h.bd,
    rot_row_o (p := c) h.bc.symm h.cd] at hu
  have z1 := one_common_zero hvm hv h.ab h.ac h.bc
  have z2 := one_common_zero hvm hv h.ad h.ac h.cd.symm
  linarith

/-- **Four distinct indices**: `v_abcd = 0`. -/
theorem four_distinct_zero {v : CurvLin ι} (hvm : v ∈ weylModuleS ι) (hv : AllDiagZero v) {a b c d : ι}
    (h : Distinct4 a b c d) : coord v a b c d = 0 := by
  have r1 := two_pair_rel hvm hv h
  have r2 := two_pair_rel hvm hv (a := a) (b := c) (c := d) (d := b)
    ⟨h.ac, h.ad, h.ab, h.cd, h.bc.symm, h.bd.symm⟩
  have bi := cd_bianchi v hvm a b c d
  have e1 := cd_sw34 v a d c b
  have e2 := cd_sw34 v a b d c
  linarith

/-- **Every coordinate vanishes**, so `v = 0`. -/
theorem eq_zero_of_allDiag {v : CurvLin ι} (hvm : v ∈ weylModuleS ι) (hv : AllDiagZero v) : v = 0 := by
  have hd : ∀ x z, coord v x z x z = 0 := fun x z => by
    have := hv 1 (by simp) x z; rwa [act_one'] at this
  apply cd_ext v hvm
  intro i j k l
  by_cases hij : i = j
  · subst hij; exact cd_self12 v i k l
  by_cases hkl : k = l
  · subst hkl; exact cd_self34 v i j k
  by_cases hik : i = k
  · subst hik
    by_cases hjl : j = l
    · subst hjl; exact hd i j
    · rw [cd_sw12, cd_sw34 v j i i l, neg_neg]
      exact one_common_zero hvm hv (Ne.symm hij) hjl hkl
  by_cases hil : i = l
  · subst hil
    by_cases hjk : j = k
    · subst hjk; rw [cd_sw34, hd, neg_zero]
    · rw [cd_sw12, one_common_zero hvm hv (Ne.symm hij) hjk hik, neg_zero]
  by_cases hjk : j = k
  · subst hjk
    rw [cd_sw34, one_common_zero hvm hv hij hil hkl, neg_zero]
  by_cases hjl : j = l
  · subst hjl
    exact one_common_zero hvm hv hij hik (Ne.symm hkl)
  exact four_distinct_zero hvm hv ⟨hij, hik, hil, hjk, hjl, hkl⟩

/-! ## Stage D: `T` is a scalar, and the trace identity -/

/-- **The spanning lemma**: a Weyl operator orthogonal to every rotation of every `E_q` is zero. -/
theorem span_EQ {v : CurvLin ι} (hvm : v ∈ weylModuleS ι)
    (h : ∀ g : Matrix ι ι ℝ, gᵀ * g = 1 → ∀ a b c d (_ : Distinct4 a b c d),
      innerOp (fun Z => act g v Z) (fun Z => EQ a b c d Z) = 0) : v = 0 := by
  apply eq_zero_of_allDiag hvm
  intro g hg x z
  apply sdiag_zero _ (act_mem g hg v hvm)
  intro a b c d hq
  have := h g hg a b c d hq
  rw [innerOp_EQ _ hq, sdiag_symm _ a b, sdiag_symm _ c d, sdiag_symm _ a c, sdiag_symm _ b d] at this
  linarith

theorem Fin4_inj {a b c d : ι} (h : Distinct4 a b c d) : Function.Injective ![a, b, c, d] := by
  intro i j hij
  fin_cases i <;> fin_cases j <;>
    simp_all [h.ab, h.ac, h.ad, h.bc, h.bd, h.cd, h.ab.symm, h.ac.symm, h.ad.symm, h.bc.symm,
      h.bd.symm, h.cd.symm]

/-- **Any `E_q` is a permutation of any other.** -/
theorem EQ_transport {a b c d a' b' c' d' : ι} (h : Distinct4 a b c d) (h' : Distinct4 a' b' c' d') :
    ∃ σ : Equiv.Perm ι, act (permMat σ) (EQ a b c d) = EQ a' b' c' d' := by
  obtain ⟨σ, hσ⟩ := Equiv.Perm.exists_extending_pair ![a', b', c', d'] ![a, b, c, d]
    (Fin4_inj h') (Fin4_inj h)
  refine ⟨σ, ?_⟩
  have e0 : σ.symm a = a' := by rw [Equiv.symm_apply_eq]; simpa using (hσ 0).symm
  have e1 : σ.symm b = b' := by rw [Equiv.symm_apply_eq]; simpa using (hσ 1).symm
  have e2 : σ.symm c = c' := by rw [Equiv.symm_apply_eq]; simpa using (hσ 2).symm
  have e3 : σ.symm d = d' := by rw [Equiv.symm_apply_eq]; simpa using (hσ 3).symm
  rw [EQ_perm h, e0, e1, e2, e3]

theorem act_sub' (g : Matrix ι ι ℝ) (R S : CurvLin ι) : act g (R - S) = act g R - act g S := by
  apply LinearMap.ext; intro Z
  simp only [act_apply, LinearMap.sub_apply, Matrix.mul_sub, Matrix.sub_mul]

theorem inner2_sub_left3 (A B C : Matrix ι ι ℝ) : inner2 (A - B) C = inner2 A C - inner2 B C := by
  simp only [inner2, Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]; ring

theorem innerOp_sub_l (R R' S : CurvLin ι) :
    innerOp (fun Z => (R - R') Z) (fun Z => S Z) =
      innerOp (fun Z => R Z) (fun Z => S Z) - innerOp (fun Z => R' Z) (fun Z => S Z) := by
  unfold innerOp; simp only [LinearMap.sub_apply, inner2_sub_left3, Finset.sum_sub_distrib]; ring

/-- **Schur, for the trace form: `T` is a scalar.** -/
theorem Tw_scalar : ∃ κ : ℝ, ∀ x : weylModuleS ι, Tw x = κ • x := by
  by_cases hq : ∃ a b c d : ι, Distinct4 a b c d
  · obtain ⟨a, b, c, d, h0⟩ := hq
    set κ := coord (Tw (EQs h0) : CurvLin ι) a b a b
    have hE : ∀ a' b' c' d' : ι, ∀ h : Distinct4 a' b' c' d', Tw (EQs h) = κ • EQs h := by
      intro a' b' c' d' h
      obtain ⟨σ, hσ⟩ := EQ_transport h0 h
      have e : EQs h = actS (permMat σ) (permMat_orth σ) (EQs h0) := Subtype.ext hσ.symm
      rw [e, Top_act, Tw_EQ h0, map_smul]
    refine ⟨κ, fun x => ?_⟩
    have hx : (x : CurvLin ι) ∈ weylModuleS ι := x.2
    have hTx : (Tw x : CurvLin ι) ∈ weylModuleS ι := (Tw x).2
    have hwm : (Tw x : CurvLin ι) - κ • (x : CurvLin ι) ∈ weylModuleS ι :=
      sub_mem hTx (Submodule.smul_mem _ κ hx)
    have hw0 : (Tw x : CurvLin ι) - κ • (x : CurvLin ι) = 0 := by
      apply span_EQ hwm
      intro g hg a' b' c' d' hq
      rw [act_sub', act_smul, innerOp_sub_l, innerOp_smul_l]
      have e1 : innerOp (fun Z => act g (Tw x : CurvLin ι) Z) (fun Z => EQ a' b' c' d' Z) =
          Jb (actS g hg (Tw x)) (EQs hq) := rfl
      have e2 : innerOp (fun Z => act g (x : CurvLin ι) Z) (fun Z => EQ a' b' c' d' Z) =
          Jb (actS g hg x) (EQs hq) := rfl
      rw [e1, e2, ← Top_act, Top_symm, hE a' b' c' d' hq, map_smul, smul_eq_mul, sub_self]
    apply Subtype.ext
    show (Tw x : CurvLin ι) = κ • (x : CurvLin ι)
    exact sub_eq_zero.mp hw0
  · refine ⟨0, fun x => ?_⟩
    have h0 : (x : CurvLin ι) = 0 :=
      span_EQ x.2 fun g _ a b c d hq' => absurd ⟨a, b, c, d, hq'⟩ hq
    have hx0 : x = 0 := Subtype.ext h0
    rw [hx0, map_zero, zero_smul]

/-- **`tr (L e ∘ L f) = κ ⟨e, f⟩` on the record's `𝒲ₙ`, with one `κ` for every pair.** -/
theorem trace_leftMulS_comp :
    ∃ kappa : ℝ, ∀ (e f : CurvLin ι) (_he : e ∈ weylModuleS ι) (_hf : f ∈ weylModuleS ι)
      (Le Lf : weylModuleS ι →ₗ[ℝ] weylModuleS ι),
      (∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
        (Le Y : CurvLin ι) Z = foxProd (fun A => e A) (fun A => (Y : CurvLin ι) A) Z) →
      (∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
        (Lf Y : CurvLin ι) Z = foxProd (fun A => f A) (fun A => (Y : CurvLin ι) A) Z) →
      LinearMap.trace ℝ (weylModuleS ι) (Le ∘ₗ Lf) =
        kappa * innerOp (fun A => e A) (fun A => f A) := by
  obtain ⟨κ, hκ⟩ := Tw_scalar (ι := ι)
  refine ⟨κ, fun e f he hf Le Lf hLe hLf => ?_⟩
  have e1 : Le = Lop ⟨e, he⟩ := leftMulS_unique e Le _ hLe (Lop_spec ⟨e, he⟩)
  have e2 : Lf = Lop ⟨f, hf⟩ := leftMulS_unique f Lf _ hLf (Lop_spec ⟨f, hf⟩)
  have hB : LinearMap.trace ℝ (weylModuleS ι) (Le ∘ₗ Lf) = Bform ⟨e, he⟩ ⟨f, hf⟩ := by
    rw [e1, e2]; rfl
  rw [hB, ← Top_spec, hκ, LinearMap.map_smul₂, smul_eq_mul]
  rfl

end HamiltonsCubic.Results
