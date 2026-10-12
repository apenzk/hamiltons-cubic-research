import HamiltonsCubic.Results.L178Frame

set_option linter.style.longLine false

/-!
# L178 on `ℝⁿ`: a rotated `𝔰𝔲(2)` frame is an `SUFrame`

Milestone 2 of [the L178 padding plan](../../../reviews/2026-09-26-lean-L178-padding-plan.md). For an
`SUFrame` `A` and an orthogonal `3 × 3` matrix `O`, the rotated triple `A'_a = Σ_b O_{ab} A_b` is again an
`SUFrame`, with sign `s det O`:

* **`cof_eps`**: `Σ_{c,d} O_{ac} O_{bd} ε_{cde} = det O Σ_f ε_{abf} O_{fe}`, the rows' cross product, from
  `adj O = det O · Oᵀ`;
* **`rotFrame`**: the rotated triple, each of the eight `SUFrame` facts carried through `O`;
* **`sym_spectral`**, **`WMatF_spectral`**: every symmetric trace-free `M` is `Oᵀ diag(μ) O` with `O`
  orthogonal, and `W_M = Σ_{b,c} M_{bc} ⟨·, ω_b⟩ ω_c` is the rotated diagonal operator;
* **`WMatF_weyl`**, **`WMatF_bound`**, **`WMatF_theta_le`**: `W_M` is Weyl with `θ(W_M) ≤ √(3/2)` for every
  nonzero symmetric trace-free `M`, on any `SUFrame`, and `WMat_weyl`, `WMat_bound`, `WMat_theta_le` on
  CP2Real's self-dual forms.
-/

namespace HamiltonsCubic.CP2Real

open Matrix HamiltonsCubic.RealLayer

variable {O : Matrix (Fin 3) (Fin 3) ℝ}

theorem OOt (hO : Oᵀ * O = 1) : O * Oᵀ = 1 := mul_eq_one_comm.mp hO

theorem row_sq (hO : Oᵀ * O = 1) (a : Fin 3) : O a 0 ^ 2 + O a 1 ^ 2 + O a 2 ^ 2 = 1 := by
  have := congrFun (congrFun (OOt hO) a) a
  simp [Matrix.mul_apply, Fin.sum_univ_three] at this
  linarith [this]

theorem row_dot (hO : Oᵀ * O = 1) {a b : Fin 3} (hab : a ≠ b) :
    O a 0 * O b 0 + O a 1 * O b 1 + O a 2 * O b 2 = 0 := by
  have := congrFun (congrFun (OOt hO) a) b
  simp [Matrix.mul_apply, Fin.sum_univ_three, hab] at this
  linarith [this]

theorem det_sq (hO : Oᵀ * O = 1) : O.det ^ 2 = 1 := by
  have := congrArg Matrix.det hO
  rw [Matrix.det_mul, Matrix.det_transpose, Matrix.det_one] at this
  nlinarith [this]

/-- `adj O = det O · Oᵀ` for orthogonal `O`. -/
theorem adj_eq (hO : Oᵀ * O = 1) (i j : Fin 3) : Matrix.adjugate O i j = O.det * O j i := by
  have h : Matrix.adjugate O = O.det • Oᵀ := by
    calc Matrix.adjugate O = Matrix.adjugate O * (O * Oᵀ) := by rw [OOt hO, Matrix.mul_one]
      _ = (Matrix.adjugate O * O) * Oᵀ := by rw [Matrix.mul_assoc]
      _ = O.det • Oᵀ := by rw [Matrix.adjugate_mul, Matrix.smul_mul, Matrix.one_mul]
  rw [h]; simp

/-- **The rows' cross product**: `Σ_{c,d} O_{ac} O_{bd} ε_{cde} = det O Σ_f ε_{abf} O_{fe}`. -/
theorem cof_eps (hO : Oᵀ * O = 1) (a b e : Fin 3) :
    ∑ c, ∑ d, O a c * O b d * ((eps c d e : ℤ) : ℝ) = O.det * ∑ f, ((eps a b f : ℤ) : ℝ) * O f e := by
  have h := adj_eq hO
  have h00 := h 0 0; have h01 := h 0 1; have h02 := h 0 2
  have h10 := h 1 0; have h11 := h 1 1; have h12 := h 1 2
  have h20 := h 2 0; have h21 := h 2 1; have h22 := h 2 2
  simp [Matrix.adjugate_fin_three] at h00 h01 h02 h10 h11 h12 h20 h21 h22
  fin_cases a <;> fin_cases b <;> fin_cases e <;>
    simp [Fin.sum_univ_three, eps] <;> linarith

/-! ## Products in an `SUFrame` -/

section Prod

variable (A : SUFrame)

theorem sqF (b : Fin 3) : A.F b * A.F b = -1 := by
  have h := A.orth b
  rw [A.skew, Matrix.neg_mul] at h
  rw [← neg_neg (A.F b * A.F b), h]

theorem mulF (a b c : Fin 3) (hab : a ≠ b) (e : ((eps a b c : ℤ) : ℝ) = 1)
    (h0 : ∀ d, d ≠ c → ((eps a b d : ℤ) : ℝ) = 0) : A.F a * A.F b = A.s • A.F c := by
  have hb := A.br a b
  have ha := A.anti a b hab
  rw [Finset.sum_eq_single c (fun d _ hd => by rw [h0 d hd, zero_smul]) (by simp), e, one_smul] at hb
  have : (2 : ℝ) • (A.F a * A.F b) = (2 : ℝ) • (A.s • A.F c) := by
    rw [smul_smul, show (2 : ℝ) * A.s = 2 * A.s from rfl, ← hb, two_smul]
    rw [← sub_eq_zero]
    have : A.F b * A.F a = -(A.F a * A.F b) := by rw [eq_neg_iff_add_eq_zero, add_comm]; exact ha
    rw [this]; abel
  exact smul_right_injective _ (two_ne_zero) this

theorem F01 : A.F 0 * A.F 1 = A.s • A.F 2 :=
  mulF A 0 1 2 (by decide) (by simp [eps]) (fun d hd => by fin_cases d <;> simp_all [eps])
theorem F12 : A.F 1 * A.F 2 = A.s • A.F 0 :=
  mulF A 1 2 0 (by decide) (by simp [eps]) (fun d hd => by fin_cases d <;> simp_all [eps])
theorem F20 : A.F 2 * A.F 0 = A.s • A.F 1 :=
  mulF A 2 0 1 (by decide) (by simp [eps]) (fun d hd => by fin_cases d <;> simp_all [eps])

theorem swapF {a b : Fin 3} (hab : a ≠ b) : A.F b * A.F a = -(A.F a * A.F b) := by
  rw [eq_neg_iff_add_eq_zero, add_comm]; exact A.anti a b hab

theorem F10 : A.F 1 * A.F 0 = -(A.s • A.F 2) := by rw [swapF A (by decide), F01]
theorem F21 : A.F 2 * A.F 1 = -(A.s • A.F 0) := by rw [swapF A (by decide), F12]
theorem F02 : A.F 0 * A.F 2 = -(A.s • A.F 1) := by rw [swapF A (by decide), F20]

end Prod

/-! ## The rotated triple -/

section Rot

variable (A : SUFrame) (O : Matrix (Fin 3) (Fin 3) ℝ)

/-- The rotated triple `A'_a = Σ_b O_{ab} A_b`. -/
noncomputable def rotF (a : Fin 3) : Matrix (Fin 4) (Fin 4) ℝ := ∑ b, O a b • A.F b

theorem rotF_expand (a : Fin 3) : rotF A O a = O a 0 • A.F 0 + O a 1 • A.F 1 + O a 2 • A.F 2 := by
  simp [rotF, Fin.sum_univ_three]

theorem rotF_skew (a : Fin 3) : (rotF A O a)ᵀ = -(rotF A O a) := by
  rw [rotF_expand]
  simp only [Matrix.transpose_add, Matrix.transpose_smul, A.skew]
  module

theorem rotF_mul (a b : Fin 3) : rotF A O a * rotF A O b =
    (-(O a 0 * O b 0 + O a 1 * O b 1 + O a 2 * O b 2)) • (1 : Matrix (Fin 4) (Fin 4) ℝ)
      + (A.s * (O a 1 * O b 2 - O a 2 * O b 1)) • A.F 0
      + (A.s * (O a 2 * O b 0 - O a 0 * O b 2)) • A.F 1
      + (A.s * (O a 0 * O b 1 - O a 1 * O b 0)) • A.F 2 := by
  rw [rotF_expand, rotF_expand]
  simp only [add_mul, mul_add, Matrix.smul_mul, Matrix.mul_smul, smul_smul, sqF, F01, F12, F20, F10, F21, F02]
  module

variable {O} in
theorem rotF_orth (hO : Oᵀ * O = 1) (a : Fin 3) : (rotF A O a)ᵀ * rotF A O a = 1 := by
  rw [rotF_skew, Matrix.neg_mul, rotF_mul]
  have h := row_sq hO a
  have e : -(O a 0 * O a 0 + O a 1 * O a 1 + O a 2 * O a 2) = -1 := by nlinarith
  rw [e]
  simp only [mul_zero, zero_smul, add_zero, show O a 1 * O a 2 - O a 2 * O a 1 = 0 by ring,
    show O a 2 * O a 0 - O a 0 * O a 2 = 0 by ring, show O a 0 * O a 1 - O a 1 * O a 0 = 0 by ring]
  module

variable {O} in
theorem rotF_anti (hO : Oᵀ * O = 1) (a b : Fin 3) (hab : a ≠ b) :
    rotF A O a * rotF A O b + rotF A O b * rotF A O a = 0 := by
  rw [rotF_mul, rotF_mul]
  have h := row_dot hO hab
  match_scalars <;>
    first
      | linear_combination (2 : ℝ) * h
      | linear_combination (-2 : ℝ) * h
      | linear_combination (-4 : ℝ) * h
      | linear_combination (4 : ℝ) * h
      | ring1

theorem trace_F (b : Fin 3) : (A.F b).trace = 0 := by
  have h := congrArg Matrix.trace (A.skew b)
  rw [Matrix.trace_transpose, Matrix.trace_neg] at h
  linarith

variable {O} in
theorem rotF_inner (hO : Oᵀ * O = 1) (a b : Fin 3) :
    ((rotF A O a)ᵀ * rotF A O b).trace = if a = b then 4 else 0 := by
  rw [rotF_skew, Matrix.neg_mul, rotF_mul]
  simp only [Matrix.trace_neg, Matrix.trace_add, Matrix.trace_smul, trace_F, Matrix.trace_one,
    Fintype.card_fin, smul_eq_mul, mul_zero, add_zero]
  split_ifs with hab
  · subst hab; have := row_sq hO a; push_cast; nlinarith
  · have := row_dot hO hab; push_cast; nlinarith

set_option linter.flexible false in
variable {O} in
theorem rotF_br (hO : Oᵀ * O = 1) (a b : Fin 3) :
    rotF A O a * rotF A O b - rotF A O b * rotF A O a
      = (2 * (A.s * O.det)) • ∑ c, ((eps a b c : ℤ) : ℝ) • rotF A O c := by
  rw [rotF_mul, rotF_mul]
  simp only [Fin.sum_univ_three, rotF_expand]
  have c0 := cof_eps hO a b 0
  have c1 := cof_eps hO a b 1
  have c2 := cof_eps hO a b 2
  simp only [Fin.sum_univ_three] at c0 c1 c2
  fin_cases a <;> fin_cases b <;>
    simp [eps] at c0 c1 c2 ⊢ <;> match_scalars <;>
    first
      | ring1
      | linear_combination (2 * A.s) * c0
      | linear_combination (2 * A.s) * c1
      | linear_combination (2 * A.s) * c2

theorem cyc_as_cyc2 (M : Matrix (Fin 4) (Fin 4) ℝ) (p q r t : Fin 4) : cyc M p q r t = cyc2 M M p q r t := rfl

theorem cyc2_rot (a b : Fin 3) (p q r t : Fin 4) :
    cyc2 (rotF A O a) (rotF A O b) p q r t = ∑ c, ∑ d, O a c * O b d * cyc2 (A.F c) (A.F d) p q r t := by
  simp only [cyc2, rotF_expand, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, Fin.sum_univ_three]
  ring

variable {O} in
theorem rotF_cyc (hO : Oᵀ * O = 1) (a : Fin 3) (p q r t : Fin 4) :
    cyc (rotF A O a) p q r t = cyc (A.F 0) p q r t := by
  rw [cyc_as_cyc2, cyc2_rot]
  have e1 := A.cyc_eq 1 p q r t
  have e2 := A.cyc_eq 2 p q r t
  have x01 := A.cyc_cross 0 1 (by decide) p q r t
  have x02 := A.cyc_cross 0 2 (by decide) p q r t
  have x12 := A.cyc_cross 1 2 (by decide) p q r t
  have hr := row_sq hO a
  simp only [cyc_as_cyc2] at e1 e2
  simp only [Fin.sum_univ_three, cyc_as_cyc2 (A.F 0)]
  linear_combination O a 1 ^ 2 * e1 + O a 2 ^ 2 * e2 + O a 0 * O a 1 * x01 + O a 0 * O a 2 * x02
    + O a 1 * O a 2 * x12 + cyc2 (A.F 0) (A.F 0) p q r t * hr

variable {O} in
theorem rotF_cyc_cross (hO : Oᵀ * O = 1) (a b : Fin 3) (hab : a ≠ b) (p q r t : Fin 4) :
    cyc2 (rotF A O a) (rotF A O b) p q r t + cyc2 (rotF A O b) (rotF A O a) p q r t = 0 := by
  rw [cyc2_rot, cyc2_rot]
  have e1 := A.cyc_eq 1 p q r t
  have e2 := A.cyc_eq 2 p q r t
  have x01 := A.cyc_cross 0 1 (by decide) p q r t
  have x02 := A.cyc_cross 0 2 (by decide) p q r t
  have x12 := A.cyc_cross 1 2 (by decide) p q r t
  have hd := row_dot hO hab
  simp only [cyc_as_cyc2] at e1 e2
  simp only [Fin.sum_univ_three]
  linear_combination 2 * O a 1 * O b 1 * e1 + 2 * O a 2 * O b 2 * e2
    + (O a 0 * O b 1 + O b 0 * O a 1) * x01 + (O a 0 * O b 2 + O b 0 * O a 2) * x02
    + (O a 1 * O b 2 + O b 1 * O a 2) * x12 + 2 * cyc2 (A.F 0) (A.F 0) p q r t * hd

variable {O} in
/-- **The rotated triple is an `SUFrame`**, with sign `s det O`. -/
noncomputable def rotFrame (hO : Oᵀ * O = 1) : SUFrame where
  F := rotF A O
  s := A.s * O.det
  s_sq := by rw [mul_pow, A.s_sq, det_sq hO, one_mul]
  skew := rotF_skew A O
  orth := rotF_orth A hO
  inner := rotF_inner A hO
  br := rotF_br A hO
  cyc_eq := fun a p q r t => by rw [rotF_cyc A hO a, rotF_cyc A hO 0]
  anti := rotF_anti A hO
  cyc_cross := rotF_cyc_cross A hO

end Rot


/-! ## Every symmetric trace-free coefficient matrix -/

section Sym

variable {n : ℕ} (Φ : SUFrame)

theorem omF_std (a : Fin 3) : omF (n := n) stdFrame a = om a := rfl

theorem omF_rot {O : Matrix (Fin 3) (Fin 3) ℝ} (hO : Oᵀ * O = 1) (a : Fin 3) :
    omF (n := n) (rotFrame Φ hO) a = ∑ b, O a b • omF Φ b := by
  simp only [omF, rotFrame, rotF, Matrix.mul_sum, Matrix.sum_mul, Finset.smul_sum, Matrix.mul_smul,
    Matrix.smul_mul]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [smul_comm]

/-- **`W_M = Σ_{b,c} M_{bc} ⟨·, ω_b⟩ ω_c`** on `ℝⁿ`, a coefficient matrix on the frame's bivectors. -/
noncomputable def WMatF (n : ℕ) (M : Matrix (Fin 3) (Fin 3) ℝ) (X : Matrix (Fin n) (Fin n) ℝ) :
    Matrix (Fin n) (Fin n) ℝ :=
  ∑ b, ∑ c, (M b c * inner2 X (omF Φ b)) • omF Φ c

/-- `W_M` on CP2Real's self-dual forms. -/
noncomputable abbrev WMat (n : ℕ) (M : Matrix (Fin 3) (Fin 3) ℝ) := WMatF stdFrame n M

/-- A rotated diagonal operator is `W_M` for `M = Oᵀ diag(μ) O`. -/
theorem WF_rot_eq {O : Matrix (Fin 3) (Fin 3) ℝ} (hO : Oᵀ * O = 1) (μ : Fin 3 → ℝ) :
    WF (rotFrame Φ hO) n μ = WMatF Φ n (Oᵀ * Matrix.diagonal μ * O) := by
  funext X
  simp only [WF, WMatF, omF_rot Φ hO, HamiltonsCubic.L41Statement.Frame.inner2_sum_r,
    HamiltonsCubic.L41Statement.Frame.inner2_smul_r]
  simp only [Fin.sum_univ_three, Matrix.mul_apply, Matrix.transpose_apply, Matrix.diagonal_apply]
  simp only [Fin.isValue, Fin.reduceEq, if_false, if_true, mul_zero, add_zero, zero_add]
  module

/-- **The spectral form of a symmetric `3 × 3` matrix**: `M = Oᵀ diag(μ) O` with `O` orthogonal. -/
theorem sym_spectral {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) :
    ∃ (O : Matrix (Fin 3) (Fin 3) ℝ) (μ : Fin 3 → ℝ), Oᵀ * O = 1 ∧ M = Oᵀ * Matrix.diagonal μ * O := by
  have hH : M.IsHermitian := by
    rw [Matrix.IsHermitian, Matrix.conjTranspose_eq_transpose_of_trivial]; exact hM
  set U : Matrix (Fin 3) (Fin 3) ℝ := (hH.eigenvectorUnitary : Matrix (Fin 3) (Fin 3) ℝ)
  have hU1 : U * star U = 1 := Unitary.mul_star_self_of_mem hH.eigenvectorUnitary.2
  have hst : star U = Uᵀ := by rw [Matrix.star_eq_conjTranspose, Matrix.conjTranspose_eq_transpose_of_trivial]
  refine ⟨Uᵀ, hH.eigenvalues, ?_, ?_⟩
  · rw [Matrix.transpose_transpose, ← hst, hU1]
  · conv_lhs => rw [hH.spectral_theorem]
    rw [Unitary.conjStarAlgAut_apply, Matrix.transpose_transpose, hst]
    congr 2

/-- The spectral data of a symmetric trace-free `M`: an orthogonal `O` and a trace-free weight `μ` with
`W_M` the rotated diagonal operator. -/
theorem WMatF_spectral {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) (htr : M.trace = 0) :
    ∃ (O : Matrix (Fin 3) (Fin 3) ℝ) (hO : Oᵀ * O = 1) (μ : Fin 3 → ℝ), ∑ a, μ a = 0 ∧
      M = Oᵀ * Matrix.diagonal μ * O ∧ WMatF Φ n M = WF (rotFrame Φ hO) n μ := by
  obtain ⟨O, μ, hO, hMe⟩ := sym_spectral hM
  refine ⟨O, hO, μ, ?_, hMe, by rw [WF_rot_eq Φ hO, ← hMe]⟩
  have : M.trace = (Matrix.diagonal μ).trace := by
    rw [hMe, Matrix.trace_mul_cycle, OOt hO, Matrix.one_mul]
  rw [htr, Matrix.trace_diagonal] at this
  exact this.symm

/-- **`W_M` is Weyl** for every symmetric trace-free `M`. -/
theorem WMatF_weyl (hn : 4 ≤ n) {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) (htr : M.trace = 0) :
    IsWeyl (WMatF Φ n M) := by
  obtain ⟨O, hO, μ, hμ, -, hW⟩ := WMatF_spectral (n := n) Φ hM htr
  rw [hW]; exact WF_weyl _ hn hμ

/-- **L178's bound on `W_M`**: `P(W_M)² ≤ (3/2) ‖W_M‖⁶`. -/
theorem WMatF_bound (hn : 4 ≤ n) {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) (htr : M.trace = 0) :
    Pcubic (WMatF Φ n M) ^ 2 ≤ (3 / 2) * normSq (WMatF Φ n M) ^ 3 := by
  obtain ⟨O, hO, μ, hμ, -, hW⟩ := WMatF_spectral (n := n) Φ hM htr
  rw [hW]; exact WF_bound _ hn hμ

/-- **`θ(W_M) ≤ √(3/2)`** for every nonzero symmetric trace-free `M`. -/
theorem WMatF_theta_le (hn : 4 ≤ n) {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) (htr : M.trace = 0)
    (h0 : M ≠ 0) : theta (WMatF Φ n M) ≤ Real.sqrt (3 / 2) := by
  obtain ⟨O, hO, μ, hμ, hMe, hW⟩ := WMatF_spectral (n := n) Φ hM htr
  have hμ0 : μ ≠ 0 := by
    rintro rfl
    apply h0
    rw [hMe]; simp
  rw [hW]; exact WF_theta_le _ hn hμ hμ0

/-- **Every self-dual padded operator is Weyl.** -/
theorem WMat_weyl (hn : 4 ≤ n) {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) (htr : M.trace = 0) :
    IsWeyl (WMat n M) := WMatF_weyl stdFrame hn hM htr

/-- **L178's bound on every self-dual padded operator.** -/
theorem WMat_bound (hn : 4 ≤ n) {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) (htr : M.trace = 0) :
    Pcubic (WMat n M) ^ 2 ≤ (3 / 2) * normSq (WMat n M) ^ 3 := WMatF_bound stdFrame hn hM htr

/-- **`θ(W_M) ≤ √(3/2)`** on the self-dual forms. -/
theorem WMat_theta_le (hn : 4 ≤ n) {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) (htr : M.trace = 0)
    (h0 : M ≠ 0) : theta (WMat n M) ≤ Real.sqrt (3 / 2) := WMatF_theta_le stdFrame hn hM htr h0

end Sym

end HamiltonsCubic.CP2Real
