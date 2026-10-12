import HamiltonsCubic.Results.L184Statement
import HamiltonsCubic.Results.L193Statement
import HamiltonsCubic.Results.SkewNormalForm
import HamiltonsCubic.Base.Pfaffian6Conj
import HamiltonsCubic.Results.I67PfSign

/-!
# L184, proved

[L184Statement.lean](L184Statement.lean) carries the definitions and case 2; **`coincident_six_empty`
is proved here**, in the statement's namespace, and it needs neither the case split nor the three
cases. **The proof uses two of the three forms**, so `coincident_six_pair` is the stronger statement:
no orthonormal PAIR of `2`-forms with a common six-dimensional support has equal squares and equal
self-wedges.

* **A frame.** `skew_normal_form` writes `ω₀ = Σ aⱼ (wⱼuⱼᵀ - uⱼwⱼᵀ)` with `aⱼ > 0` and the `uⱼ, wⱼ`
  orthonormal in the support, so there are three planes and the six vectors are an orthonormal frame
  of `V`. With `U` the frame matrix, `P = UUᵀ` fixes `V`, so `Pωᵢ = ωᵢ = ωᵢP`.
* **Transport to `ℝ⁶`.** `Xᵢ = Uᵀ ωᵢ U` keeps the inner products and the squares (`P` is absorbed),
  and the self-wedge is natural under congruence (`wedgeSelf_congr`), so equal wedges stay equal.
  `X₀ = a₀φ₀₁ + a₁φ₂₃ + a₂φ₄₅`, whose Pfaffian is `-a₀a₁a₂ ≠ 0` (`pf6_blocks`).
* **The adjugate law** `X σ(X) = -Pf(X) Id` ([L193](L193Statement.lean)), with one `σ` for both
  forms since their wedges agree, gives `X₀²σ = -Pf(X₀) X₀` and `X₁²σ = -Pf(X₁) X₁`. The squares
  agree, so `Pf(X₀) X₀ = Pf(X₁) X₁`, and pairing with `X₀` gives `Pf(X₀) = 0` (`core6`).
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L184Statement

open HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer Matrix

theorem inner2_smul_l (c : ℝ) {κ : Type*} [Fintype κ] (A B : Matrix κ κ ℝ) :
    inner2 (c • A) B = c * inner2 A B := by
  simp only [inner2, Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]; ring

/-- **The core at `ℝ⁶`**: two orthonormal skew forms with equal squares and equal self-wedges force
`Pf(X₀) = 0`. -/
theorem core6 (X0 X1 : Matrix (Fin 6) (Fin 6) ℝ) (h0 : IsSkew X0) (h1 : IsSkew X1)
    (hn : inner2 X0 X0 = 1) (horth : inner2 X1 X0 = 0)
    (hsq : X0 * X0 = X1 * X1) (hw : wedgeSelf X0 = wedgeSelf X1) : pf6 X0 = 0 := by
  have hs : L193Statement.sigma6 X0 = L193Statement.sigma6 X1 := by
    unfold L193Statement.sigma6; rw [hw]
  have e0 : X0 * X0 * L193Statement.sigma6 X0 = (-(pf6 X0)) • X0 := by
    rw [Matrix.mul_assoc, L193Statement.adjugate_law X0 h0, Matrix.mul_smul, Matrix.mul_one]
  have e1 : X1 * X1 * L193Statement.sigma6 X1 = (-(pf6 X1)) • X1 := by
    rw [Matrix.mul_assoc, L193Statement.adjugate_law X1 h1, Matrix.mul_smul, Matrix.mul_one]
  have e : (-(pf6 X0)) • X0 = (-(pf6 X1)) • X1 := by rw [← e0, ← e1, hsq, hs]
  have := congrArg (fun M => inner2 M X0) e
  simp only [inner2_smul_l, hn, horth, mul_zero, mul_one] at this
  linarith

/-- **The Pfaffian of a block-diagonal form** `a₀φ₀₁ + a₁φ₂₃ + a₂φ₄₅` is `-a₀a₁a₂`. -/
theorem pf6_blocks (a0 a1 a2 : ℝ) :
    pf6 (a0 • phi 0 1 + a1 • phi 2 3 + a2 • phi 4 5 : Matrix (Fin 6) (Fin 6) ℝ) = -(a0 * a1 * a2) := by
  set Q : Matrix (Fin 6) (Fin 6) ℝ := Matrix.diagonal ![a0, 1, a1, 1, a2, 1]
  have hQ : Q * stdJ6 * Qᵀ = a0 • phi 0 1 + a1 • phi 2 3 + a2 • phi 4 5 := by
    ext m n
    simp only [Q, stdJ6, Matrix.diagonal_mul, Matrix.mul_diagonal, Matrix.diagonal_transpose,
      Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, phi, Matrix.sub_apply, Matrix.single_apply]
    fin_cases m <;> fin_cases n <;> simp
  have hd : Q.det = a0 * a1 * a2 := by
    simp [Q, Matrix.det_diagonal, Fin.prod_univ_six]; try ring
  rw [← hQ, pf6_conj, hd, pf6_stdJ6]; ring

/-- The entries of a congruence. -/
theorem congr_apply {κ μ : Type*} [Fintype κ] [Fintype μ] (U : Matrix κ μ ℝ) (X : Matrix κ κ ℝ) (a b : μ) :
    (Uᵀ * X * U) a b = ∑ i, ∑ j, U i a * X i j * U j b := by
  simp only [Matrix.mul_apply, Matrix.transpose_apply, Finset.sum_mul]
  rw [Finset.sum_comm]

theorem prod_sums {κ : Type*} [Fintype κ] (f g : κ → κ → ℝ) :
    (∑ i, ∑ j, f i j) * (∑ k, ∑ l, g k l) = ∑ i, ∑ j, ∑ k, ∑ l, f i j * g k l := by
  rw [Finset.sum_mul]; refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul]; refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.mul_sum]

/-- **The self-wedge is natural under congruence.** -/
theorem wedgeSelf_congr {κ μ : Type*} [Fintype κ] [Fintype μ] [DecidableEq κ] [DecidableEq μ]
    (U : Matrix κ μ ℝ) (X : Matrix κ κ ℝ) (a b c d : μ) :
    wedgeSelf (Uᵀ * X * U) a b c d =
      ∑ i, ∑ j, ∑ k, ∑ l, U i a * U j b * U k c * U l d * wedgeSelf X i j k l := by
  simp only [wedgeSelf_apply, congr_apply]
  have T1 : (∑ i, ∑ j, U i a * X i j * U j b) * (∑ k, ∑ l, U k c * X k l * U l d) =
      ∑ i, ∑ j, ∑ k, ∑ l, U i a * U j b * U k c * U l d * (X i j * X k l) := by
    rw [prod_sums]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
      Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by ring
  have T2 : (∑ i, ∑ j, U i a * X i j * U j c) * (∑ k, ∑ l, U k b * X k l * U l d) =
      ∑ i, ∑ j, ∑ k, ∑ l, U i a * U j b * U k c * U l d * (X i k * X j l) := by
    rw [prod_sums]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
      Finset.sum_congr rfl fun l _ => by ring
  have T3 : (∑ i, ∑ j, U i a * X i j * U j d) * (∑ k, ∑ l, U k b * X k l * U l c) =
      ∑ i, ∑ j, ∑ k, ∑ l, U i a * U j b * U k c * U l d * (X i l * X j k) := by
    rw [prod_sums]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by ring
  rw [T1, T2, T3]
  simp only [← Finset.sum_sub_distrib, ← Finset.sum_add_distrib, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by ring

/-! ## The frame -/

section Frame

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The frame matrix, with the vectors `v m` as its columns. -/
def frameU (v : Fin 6 → ι → ℝ) : Matrix ι (Fin 6) ℝ := Matrix.of fun i m => v m i

theorem dot_sum_sum (x y z t : ι → ℝ) :
    ∑ i, ∑ j, x i * (y i * z j) * t j = (x ⬝ᵥ y) * (z ⬝ᵥ t) := by
  rw [dotProduct, dotProduct, Finset.sum_mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring

theorem mat_eq_of_mulVec {A B : Matrix ι ι ℝ} (h : ∀ z, A *ᵥ z = B *ᵥ z) : A = B := by
  ext i j
  have := congrFun (h (Pi.single j 1)) i
  simpa [Matrix.mulVec_single_one] using this

variable {v : Fin 6 → ι → ℝ} (hv : ∀ m n, v m ⬝ᵥ v n = if m = n then 1 else 0)
include hv

theorem frame_proj_mulVec (x : ι → ℝ) :
    (frameU v * (frameU v)ᵀ) *ᵥ x = ∑ m, (v m ⬝ᵥ x) • v m := by
  ext i
  rw [← Matrix.mulVec_mulVec]
  simp only [Matrix.mulVec, dotProduct, Matrix.transpose_apply, frameU, Matrix.of_apply,
    Finset.sum_apply, Pi.smul_apply, smul_eq_mul]
  refine Finset.sum_congr rfl fun m _ => by ring

theorem frame_proj_fix (n : Fin 6) : (frameU v * (frameU v)ᵀ) *ᵥ v n = v n := by
  rw [frame_proj_mulVec hv]
  simp only [hv, ite_smul, one_smul, zero_smul, Finset.sum_ite_eq', Finset.mem_univ, if_true]

theorem congr_rot (p q : Fin 6) :
    (frameU v)ᵀ * SkewNormalForm.rot (v p) (v q) * frameU v = phi p q := by
  ext m n
  rw [congr_apply]
  simp only [SkewNormalForm.rot, Matrix.sub_apply, Matrix.vecMulVec_apply, frameU, Matrix.of_apply,
    mul_sub, sub_mul, Finset.sum_sub_distrib]
  have e1 : ∑ i, ∑ j, v m i * (v q i * v p j) * v n j = (v m ⬝ᵥ v q) * (v p ⬝ᵥ v n) := dot_sum_sum _ _ _ _
  have e2 : ∑ i, ∑ j, v m i * (v p i * v q j) * v n j = (v m ⬝ᵥ v p) * (v q ⬝ᵥ v n) := dot_sum_sum _ _ _ _
  rw [e1, e2, hv, hv, hv, hv]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, @eq_comm _ q m, @eq_comm _ p m]
  by_cases h1 : m = q <;> by_cases h2 : p = n <;> by_cases h3 : m = p <;> by_cases h4 : q = n <;>
    simp [h1, h2, h3, h4]

end Frame

/-! ## L184 -/

theorem lin_indep_orthonormal {κ ι : Type*} [Fintype κ] [Fintype ι] [DecidableEq κ] (f : κ → ι → ℝ)
    (hf : ∀ s t, f s ⬝ᵥ f t = if s = t then 1 else 0) : LinearIndependent ℝ f := by
  rw [Fintype.linearIndependent_iff]
  intro g hg s
  have h := congrArg (fun x => x ⬝ᵥ f s) hg
  simp only [sum_dotProduct, smul_dotProduct, hf, smul_eq_mul, mul_ite, mul_one,
    mul_zero, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true, zero_dotProduct] at h
  exact h

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **A frame of the common support.** *`skew_normal_form` on `ω₀` gives three orthonormal planes
in `V`, and their six vectors are the columns of `U`: `P = UUᵀ` fixes both forms on either side, and
`Uᵀω₀U` is block diagonal with nonzero Pfaffian.* -/
theorem six_frame (V : Submodule ℝ (ι → ℝ)) (om0 om1 : Matrix ι ι ℝ)
    (hs0 : IsSkew om0) (hs1 : IsSkew om1)
    (hsupp0 : support om0 = V) (hsupp1 : support om1 = V)
    (hdim : Module.finrank ℝ V = 6) :
    ∃ U : Matrix ι (Fin 6) ℝ, U * Uᵀ * om0 = om0 ∧ om0 * (U * Uᵀ) = om0 ∧
      U * Uᵀ * om1 = om1 ∧ om1 * (U * Uᵀ) = om1 ∧ pf6 (Uᵀ * om0 * U) ≠ 0 := by
  have hdim' : Module.finrank ℝ (LinearMap.range (Matrix.mulVecLin om0)) = 6 := by
    rw [← hdim, ← hsupp0]; rfl
  obtain ⟨k, u, w, a, ha, huu, hww, huw, hmem, hx⟩ :=
    SkewNormalForm.skew_normal_form 6 om0 hs0 hdim'
  -- the planes span the support, so `k = 3`
  set f : Fin k ⊕ Fin k → ι → ℝ := Sum.elim u w with hf
  have hfo : ∀ s t, f s ⬝ᵥ f t = if s = t then 1 else 0 := by
    rintro (s | s) (t | t)
    · simp [hf, huu]
    · simp [hf, huw]
    · simp [hf, dotProduct_comm, huw]
    · simp [hf, hww]
  have hli := lin_indep_orthonormal f hfo
  have hspan : LinearMap.range (Matrix.mulVecLin om0) = Submodule.span ℝ (Set.range f) := by
    apply le_antisymm
    · rintro _ ⟨z, rfl⟩
      rw [Matrix.mulVecLin_apply, hx, Matrix.sum_mulVec]
      refine Submodule.sum_mem _ fun j _ => ?_
      rw [Matrix.smul_mulVec, SkewNormalForm.rot_mulVec]
      refine Submodule.smul_mem _ _ (Submodule.sub_mem _ (Submodule.smul_mem _ _ ?_)
        (Submodule.smul_mem _ _ ?_))
      · exact Submodule.subset_span ⟨Sum.inr j, rfl⟩
      · exact Submodule.subset_span ⟨Sum.inl j, rfl⟩
    · rw [Submodule.span_le]
      rintro _ ⟨s | s, rfl⟩
      · exact (hmem s).1
      · exact (hmem s).2
  have hk : k + k = 6 := by
    have := finrank_span_eq_card hli
    rw [← hspan, hdim'] at this
    simpa using this.symm
  obtain rfl : k = 3 := by omega
  -- the frame
  set v : Fin 6 → ι → ℝ := ![u 0, w 0, u 1, w 1, u 2, w 2] with hvdef
  have hv : ∀ m n, v m ⬝ᵥ v n = if m = n then 1 else 0 := by
    intro m n
    fin_cases m <;> fin_cases n <;> simp [hvdef, huu, hww, huw, dotProduct_comm (w _) (u _)]
  set U := frameU v with hU
  set P := U * Uᵀ with hP
  have hfix : ∀ j : Fin 3, P *ᵥ u j = u j ∧ P *ᵥ w j = w j := by
    intro j
    fin_cases j
    · exact ⟨frame_proj_fix hv 0, frame_proj_fix hv 1⟩
    · exact ⟨frame_proj_fix hv 2, frame_proj_fix hv 3⟩
    · exact ⟨frame_proj_fix hv 4, frame_proj_fix hv 5⟩
  have hfix0 : ∀ z, P *ᵥ (om0 *ᵥ z) = om0 *ᵥ z := by
    intro z
    conv_lhs => rw [hx]
    rw [hx, Matrix.sum_mulVec, Matrix.mulVec_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Matrix.smul_mulVec, SkewNormalForm.rot_mulVec, Matrix.mulVec_smul, Matrix.mulVec_sub,
      Matrix.mulVec_smul, Matrix.mulVec_smul, (hfix j).1, (hfix j).2]
  have hfix1 : ∀ z, P *ᵥ (om1 *ᵥ z) = om1 *ᵥ z := by
    intro z
    have hm : om1 *ᵥ z ∈ LinearMap.range (Matrix.mulVecLin om0) := by
      have : om1 *ᵥ z ∈ support om1 := ⟨z, rfl⟩
      rw [hsupp1, ← hsupp0] at this; exact this
    obtain ⟨z', hz'⟩ := hm
    rw [← hz']; exact hfix0 z'
  have hPT : Pᵀ = P := by rw [hP, Matrix.transpose_mul, Matrix.transpose_transpose]
  have hL : ∀ om : Matrix ι ι ℝ, (∀ z, P *ᵥ (om *ᵥ z) = om *ᵥ z) → P * om = om := fun om h =>
    mat_eq_of_mulVec fun z => by rw [← Matrix.mulVec_mulVec]; exact h z
  have hR : ∀ om : Matrix ι ι ℝ, IsSkew om → P * om = om → om * P = om := by
    intro om hs h
    unfold IsSkew at hs
    have : (om * P)ᵀ = omᵀ := by rw [Matrix.transpose_mul, hPT, hs, Matrix.mul_neg, h]
    simpa using congrArg Matrix.transpose this
  have hL0 := hL om0 hfix0
  have hL1 := hL om1 hfix1
  refine ⟨U, hL0, hR om0 hs0 hL0, hL1, hR om1 hs1 hL1, ?_⟩
  set X0 := Uᵀ * om0 * U with hX0
  have hX0form : X0 = a 0 • phi 0 1 + a 1 • phi 2 3 + a 2 • phi 4 5 := by
    rw [hX0, hx, Fin.sum_univ_three]
    simp only [Matrix.mul_add, Matrix.add_mul, Matrix.mul_smul, Matrix.smul_mul]
    have r0 : Uᵀ * SkewNormalForm.rot (u 0) (w 0) * U = phi 0 1 := congr_rot hv 0 1
    have r1 : Uᵀ * SkewNormalForm.rot (u 1) (w 1) * U = phi 2 3 := congr_rot hv 2 3
    have r2 : Uᵀ * SkewNormalForm.rot (u 2) (w 2) * U = phi 4 5 := congr_rot hv 4 5
    rw [r0, r1, r2]
  rw [hX0form, pf6_blocks]
  have := mul_pos (mul_pos (ha 0) (ha 1)) (ha 2)
  intro h; linarith

/-- **L184, for an orthonormal PAIR**: two orthonormal `2`-forms with a common six-dimensional
support cannot have both their squares and their self-wedges equal. -/
theorem coincident_six_pair (V : Submodule ℝ (ι → ℝ)) (om0 om1 : Matrix ι ι ℝ)
    (hs0 : IsSkew om0) (hs1 : IsSkew om1)
    (hn : inner2 om0 om0 = 1) (horth : inner2 om1 om0 = 0)
    (hsupp0 : support om0 = V) (hsupp1 : support om1 = V)
    (hdim : Module.finrank ℝ V = 6)
    (hsq : om0 * om0 = om1 * om1) (hwedge : wedgeSelf om0 = wedgeSelf om1) : False := by
  obtain ⟨U, hL0, hR0, hL1, hR1, hpf0⟩ := six_frame V om0 om1 hs0 hs1 hsupp0 hsupp1 hdim
  set P := U * Uᵀ with hP
  have hPT : Pᵀ = P := by rw [hP, Matrix.transpose_mul, Matrix.transpose_transpose]
  -- the forms read in the frame
  set X0 := Uᵀ * om0 * U with hX0
  set X1 := Uᵀ * om1 * U with hX1
  have hskewX : ∀ om : Matrix ι ι ℝ, IsSkew om → IsSkew (Uᵀ * om * U) := by
    intro om hs; unfold IsSkew at hs ⊢
    rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hs]
    simp [Matrix.mul_assoc]
  have hsqX : ∀ om : Matrix ι ι ℝ, om * P = om →
      (Uᵀ * om * U) * (Uᵀ * om * U) = Uᵀ * (om * om) * U := by
    intro om h
    calc (Uᵀ * om * U) * (Uᵀ * om * U) = Uᵀ * (om * P) * om * U := by
          simp only [hP, Matrix.mul_assoc]
      _ = _ := by rw [h, Matrix.mul_assoc Uᵀ om om]
  have hinner : inner2 X1 X0 = inner2 om1 om0 := by
    unfold inner2
    congr 1
    have e : X1ᵀ * X0 = Uᵀ * (om1ᵀ * om0) * U := by
      simp only [hX1, hX0, Matrix.transpose_mul, Matrix.transpose_transpose, Matrix.mul_assoc]
      rw [← Matrix.mul_assoc U Uᵀ, ← hP, ← Matrix.mul_assoc P om0, hL0]
    rw [e, Matrix.trace_mul_comm, ← Matrix.mul_assoc, ← hP, ← Matrix.mul_assoc]
    have : P * om1ᵀ = om1ᵀ := by
      rw [← hPT, ← Matrix.transpose_mul, hR1]
    rw [this]
  have hn0 : inner2 X0 X0 = 1 := by
    rw [← hn]
    unfold inner2
    congr 1
    have e : X0ᵀ * X0 = Uᵀ * (om0ᵀ * om0) * U := by
      simp only [hX0, Matrix.transpose_mul, Matrix.transpose_transpose, Matrix.mul_assoc]
      rw [← Matrix.mul_assoc U Uᵀ, ← hP, ← Matrix.mul_assoc P om0, hL0]
    rw [e, Matrix.trace_mul_comm, ← Matrix.mul_assoc, ← hP, ← Matrix.mul_assoc]
    have : P * om0ᵀ = om0ᵀ := by
      rw [← hPT, ← Matrix.transpose_mul, hR0]
    rw [this]
  have hsq6 : X0 * X0 = X1 * X1 := by rw [hsqX om0 hR0, hsqX om1 hR1, hsq]
  have hw6 : wedgeSelf X0 = wedgeSelf X1 := by
    funext a b c d; rw [wedgeSelf_congr, wedgeSelf_congr, hwedge]
  exact hpf0 (core6 X0 X1 (hskewX om0 hs0) (hskewX om1 hs1) hn0 (by rw [hinner, horth]) hsq6 hw6)

noncomputable section

/-! ## The lemma -/

/-- **L184.** *No orthonormal triple `ω₁, ω₂, ω₃` of `2`-forms with a common six-dimensional
support has both its squares and its self-wedges coincident.*

*Proved from `coincident_six_pair`, the first two forms alone.* -/
theorem coincident_six_empty (V : Submodule ℝ (ι → ℝ)) (om : Fin 3 → Matrix ι ι ℝ)
    (hskew : ∀ i, IsSkew (om i))
    (hon : ∀ i j, inner2 (om i) (om j) = if i = j then 1 else 0)
    (hsupp : ∀ i, support (om i) = V)
    (hdim : Module.finrank ℝ V = 6)
    (hsq : ∀ i j, om i * om i = om j * om j)
    (hwedge : ∀ i j, wedgeSelf (om i) = wedgeSelf (om j)) :
    False :=
  coincident_six_pair V (om 0) (om 1) (hskew 0) (hskew 1) (by simpa using hon 0 0)
    (by simpa using hon 1 0) (hsupp 0) (hsupp 1) hdim (hsq 0 1) (hwedge 0 1)

/-- **The same statement in `Φ`'s language**, which is the form [L183](L183Statement.lean) hands
over: the three images coincide. *`Φ`'s two components are exactly `hsq` and `hwedge`, so this is
a restatement and not a second claim.* -/
theorem coincident_six_empty_Phi (V : Submodule ℝ (ι → ℝ)) (om : Fin 3 → Matrix ι ι ℝ)
    (hskew : ∀ i, IsSkew (om i))
    (hon : ∀ i j, inner2 (om i) (om j) = if i = j then 1 else 0)
    (hsupp : ∀ i, support (om i) = V)
    (hdim : Module.finrank ℝ V = 6)
    (hcoin : ∀ i j, Phi (om i) = Phi (om j)) :
    False :=
  coincident_six_empty V om hskew hon hsupp hdim
    (fun i j => congrArg Prod.fst (hcoin i j))
    (fun i j => congrArg Prod.snd (hcoin i j))

/-! ## The corollary, with the Weyl hypothesis carried and unused -/

/-- **The corollary the programme wanted.** There is no rank-three `W ∈ 𝒲ₙ` with `dim V = 6` whose
three images under `Φ` coincide.

**The `IsWeyl` and nonzero-weight hypotheses are named and never used**, which is the record's
*"no Weyl hypothesis is used anywhere"* made visible: the proof is the bare-triple theorem. -/
theorem no_rank_three_coincident (V : Submodule ℝ (ι → ℝ))
    (lam : Fin 3 → ℝ) (om : Fin 3 → Matrix ι ι ℝ)
    (_hlam : ∀ i, lam i ≠ 0)
    (_hW : IsWeyl (rankSumOp lam om))
    (hskew : ∀ i, IsSkew (om i))
    (hon : ∀ i j, inner2 (om i) (om j) = if i = j then 1 else 0)
    (hsupp : ∀ i, support (om i) = V)
    (hdim : Module.finrank ℝ V = 6)
    (hcoin : ∀ i j, Phi (om i) = Phi (om j)) :
    False :=
  coincident_six_empty_Phi V om hskew hon hsupp hdim hcoin

end

end HamiltonsCubic.L184Statement
