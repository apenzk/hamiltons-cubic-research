import HamiltonsCubic.Results.L30Statement
import HamiltonsCubic.Results.FrameExtension


/-!
# `W_{ℂP²}` in the real Weyl layer, padded to every `n ≥ 4`

**The record's witness for [L40](L40Statement.lean)'s attainment and [L29](L29Statement.lean)'s
equality case**, built on bivectors rather than on the pair basis, so it lives at every `n ≥ 4` at once.

`J 0, J 1, J 2` are the three self-dual complex structures on `ℝ⁴`, `Emb n` includes `ℝ⁴` as the
first four coordinates, `ω_a = E J_a Eᵀ/√2` are orthonormal bivectors, and
`W = Σ_a μ_a ⟨·, ω_a⟩ ω_a` with `μ = (2,-1,-1)/√6`.

**Proved here:**

* `Wc_weyl`, `W ∈ 𝒲ₙ`: first Bianchi because the three forms share one cyclic sum (`cyc_eq`, checked
  over `ℤ` by `decide`) and `Σ μ = 0`; Ricci-flatness because `ω_aᵀω_a` is one matrix for every `a`.
* `om_br_eps`, `[ω_a, ω_b] = √2 Σ_c ε_{abc} ω_c`, the `𝔰𝔲(2)` relations.
* `Wc_values` and `Wc_theta`: `‖W‖ = 1`, `tr W³ = 1/√6`, `⟨W, W#⟩ = 2/√6`, so `θ = √(3/2)`.
* `Wc_crit`: `⟨W²X, Y⟩ + ⟨W#X, Y⟩ = √(3/2)⟨WX, Y⟩` on all bivectors, from `W#` in closed form.
* `Wc_not_diag`: no orthonormal frame diagonalises `W`. The top eigenvalue is simple with eigenvector
  `ω₀`, so a coordinate plane pairing with `ω₀` would be `±ω₀`, but a unit decomposable `X` has
  `X³ = -X` while `ω₀³ = -½ω₀`.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

namespace HamiltonsCubic.CP2Real

open Matrix HamiltonsCubic.RealLayer

/-- The three unnormalised self-dual forms on `ℝ⁴`. -/
def J : Fin 3 → Matrix (Fin 4) (Fin 4) ℝ
  | 0 => !![0, -1, 0, 0; 1, 0, 0, 0; 0, 0, 0, -1; 0, 0, 1, 0]
  | 1 => !![0, 0, -1, 0; 0, 0, 0, 1; 1, 0, 0, 0; 0, -1, 0, 0]
  | 2 => !![0, 0, 0, -1; 0, 0, -1, 0; 0, 1, 0, 0; 1, 0, 0, 0]

theorem J_skew (a : Fin 3) : (J a)ᵀ = -(J a) := by
  fin_cases a <;> (ext i j; fin_cases i <;> fin_cases j <;> simp [J])

theorem J_orth (a : Fin 3) : (J a)ᵀ * J a = 1 := by
  fin_cases a <;> (ext i j; fin_cases i <;> fin_cases j <;> simp [J, Matrix.mul_apply, Fin.sum_univ_four])

theorem J_inner (a b : Fin 3) : ((J a)ᵀ * J b).trace = if a = b then 4 else 0 := by
  fin_cases a <;> fin_cases b <;> simp [J, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num

theorem J_br01 : J 0 * J 1 - J 1 * J 0 = 2 • J 2 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [J, Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num
theorem J_br02 : J 0 * J 2 - J 2 * J 0 = (-2 : ℝ) • J 1 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [J, Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num
theorem J_br12 : J 1 * J 2 - J 2 * J 1 = 2 • J 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [J, Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num

/-- The cyclic sum `J_{qp}J_{sr} + J_{rp}J_{qs} + J_{sp}J_{rq}`. -/
def cyc (M : Matrix (Fin 4) (Fin 4) ℝ) (p q r s : Fin 4) : ℝ :=
  M q p * M s r + M r p * M q s + M s p * M r q

def Jz : Fin 3 → Matrix (Fin 4) (Fin 4) ℤ
  | 0 => !![0, -1, 0, 0; 1, 0, 0, 0; 0, 0, 0, -1; 0, 0, 1, 0]
  | 1 => !![0, 0, -1, 0; 0, 0, 0, 1; 1, 0, 0, 0; 0, -1, 0, 0]
  | 2 => !![0, 0, 0, -1; 0, 0, -1, 0; 0, 1, 0, 0; 1, 0, 0, 0]

theorem J_cast (a : Fin 3) (i j : Fin 4) : J a i j = ((Jz a i j : ℤ) : ℝ) := by
  fin_cases a <;> fin_cases i <;> fin_cases j <;> simp [J, Jz]

theorem cycz_eq : ∀ (a : Fin 3) (p q r s : Fin 4),
    Jz a q p * Jz a s r + Jz a r p * Jz a q s + Jz a s p * Jz a r q
      = Jz 0 q p * Jz 0 s r + Jz 0 r p * Jz 0 q s + Jz 0 s p * Jz 0 r q := by decide

theorem cyc_eq (a : Fin 3) (p q r s : Fin 4) : cyc (J a) p q r s = cyc (J 0) p q r s := by
  simp only [cyc, J_cast]
  exact_mod_cast cycz_eq a p q r s


/-! ## On `ℝⁿ`, through the first four coordinates -/

variable {n : ℕ}

def Emb (n : ℕ) : Matrix (Fin n) (Fin 4) ℝ := fun p x => if (p : ℕ) = x then 1 else 0

theorem Emb_orth (hn : 4 ≤ n) : (Emb n)ᵀ * Emb n = 1 := by
  ext x y
  simp only [Matrix.mul_apply, Matrix.transpose_apply, Emb, Matrix.one_apply]
  rw [Finset.sum_eq_single (⟨x, lt_of_lt_of_le x.2 hn⟩ : Fin n)]
  · by_cases h : x = y
    · subst h; simp
    · simp [h, Fin.val_ne_of_ne h]
  · intro p _ hp
    have : (p : ℕ) ≠ x := fun h' => hp (Fin.ext h')
    simp [this]
  · simp

noncomputable def sq2 : ℝ := Real.sqrt 2

noncomputable def om (a : Fin 3) : Matrix (Fin n) (Fin n) ℝ := sq2⁻¹ • (Emb n * J a * (Emb n)ᵀ)

theorem sq2_sq : sq2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
theorem sq2_pos : 0 < sq2 := Real.sqrt_pos.mpr (by norm_num)

theorem om_skew (a : Fin 3) : IsSkew (om (n := n) a) := by
  unfold IsSkew om
  rw [Matrix.transpose_smul, Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose,
    J_skew]
  simp [Matrix.mul_assoc, Matrix.neg_mul, Matrix.mul_neg]

theorem om_entry (a : Fin 3) (p q : Fin n) :
    om a q p = sq2⁻¹ * dotProduct (fun x => Emb n q x) (J a *ᵥ fun x => Emb n p x) := by
  simp only [om, Matrix.smul_apply, smul_eq_mul, Matrix.mul_apply, Matrix.transpose_apply, dotProduct,
    Matrix.mulVec, Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => by ring

theorem conjT (A : Matrix (Fin 4) (Fin 4) ℝ) : (Emb n * A * (Emb n)ᵀ)ᵀ = Emb n * Aᵀ * (Emb n)ᵀ := by
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, Matrix.mul_assoc]

theorem sandwich (hn : 4 ≤ n) (A B : Matrix (Fin 4) (Fin 4) ℝ) :
    Emb n * A * (Emb n)ᵀ * (Emb n * B * (Emb n)ᵀ) = Emb n * (A * B) * (Emb n)ᵀ := by
  rw [show Emb n * A * (Emb n)ᵀ * (Emb n * B * (Emb n)ᵀ)
      = Emb n * A * ((Emb n)ᵀ * Emb n) * B * (Emb n)ᵀ by simp only [Matrix.mul_assoc],
    Emb_orth hn, Matrix.mul_one]
  simp only [Matrix.mul_assoc]

theorem om_inner (hn : 4 ≤ n) (a b : Fin 3) : inner2 (om (n := n) a) (om b) = if a = b then 1 else 0 := by
  have h : (om (n := n) a)ᵀ * om b = (sq2⁻¹ * sq2⁻¹) • (Emb n * ((J a)ᵀ * J b) * (Emb n)ᵀ) := by
    unfold om
    rw [Matrix.transpose_smul, conjT, Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hn]
  unfold inner2
  rw [h, Matrix.trace_smul, Matrix.trace_mul_comm, ← Matrix.mul_assoc, Emb_orth hn, Matrix.one_mul, J_inner,
    smul_eq_mul]
  have := sq2_sq
  have := sq2_pos
  split_ifs
  · field_simp; linarith
  · simp

theorem om_br (hn : 4 ≤ n) (a b : Fin 3) :
    br (om (n := n) a) (om b) = (sq2⁻¹ * sq2⁻¹) • (Emb n * (J a * J b - J b * J a) * (Emb n)ᵀ) := by
  unfold br om
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hn, Matrix.smul_mul, Matrix.mul_smul, smul_smul,
    sandwich hn, ← smul_sub, Matrix.mul_sub, Matrix.sub_mul]

theorem om_sq (hn : 4 ≤ n) (a : Fin 3) :
    (om (n := n) a)ᵀ * om a = (sq2⁻¹ * sq2⁻¹) • (Emb n * (Emb n)ᵀ) := by
  unfold om
  rw [Matrix.transpose_smul, conjT, Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hn, J_orth,
    Matrix.mul_one]

theorem om_cyc (a : Fin 3) (i j k l : Fin n) :
    om (n := n) a j i * om a l k + om a k i * om a j l + om a l i * om a k j
      = sq2⁻¹ * sq2⁻¹ * ∑ x, ∑ y, ∑ z, ∑ t, Emb n i x * Emb n j y * Emb n k z * Emb n l t * cyc (J a) x y z t := by
  rw [om_entry a i j, om_entry a k l, om_entry a i k, om_entry a l j, om_entry a i l, om_entry a j k]
  set ri : Fin 4 → ℝ := fun x => Emb n i x
  set rj : Fin 4 → ℝ := fun x => Emb n j x
  set rk : Fin 4 → ℝ := fun x => Emb n k x
  set rl : Fin 4 → ℝ := fun x => Emb n l x
  calc _ = sq2⁻¹ * sq2⁻¹ * (dotProduct rj (J a *ᵥ ri) * dotProduct rl (J a *ᵥ rk)
        + dotProduct rk (J a *ᵥ ri) * dotProduct rj (J a *ᵥ rl)
        + dotProduct rl (J a *ᵥ ri) * dotProduct rk (J a *ᵥ rj)) := by ring
    _ = _ := by
      rw [HamiltonsCubic.L30Statement.e1, HamiltonsCubic.L30Statement.e2, HamiltonsCubic.L30Statement.e3]
      congr 1
      simp only [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ =>
        Finset.sum_congr rfl fun z _ => Finset.sum_congr rfl fun t _ => ?_
      simp only [cyc, ri, rj, rk, rl]; ring

/-! ## The operator -/

noncomputable def mu : Fin 3 → ℝ := ![2 / Real.sqrt 6, -(1 / Real.sqrt 6), -(1 / Real.sqrt 6)]

theorem mu_sum : ∑ a, mu a = 0 := by simp [mu, Fin.sum_univ_three]; ring

/-- **`W_{ℂP²}` on `ℝⁿ`**, padded by zero off the first four coordinates. -/
noncomputable def Wc (n : ℕ) (X : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  ∑ a, (mu a * inner2 X (om a)) • om a

theorem Wc_inner (X Y : Matrix (Fin n) (Fin n) ℝ) :
    inner2 (Wc n X) Y = ∑ a, mu a * inner2 X (om a) * inner2 (om a) Y := by
  unfold Wc
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  exact Finset.sum_congr rfl fun a _ => by rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l]

theorem Wc_weyl (hn : 4 ≤ n) : IsWeyl (Wc n) := by
  have hphi : ∀ a i j, inner2 (phi i j) (om (n := n) a) = om a j i := fun a i j => by
    rw [inner2_comm, inner2_phi _ (om_skew a), HamiltonsCubic.L30Statement.skew_entry (om_skew a)]
    ring
  refine ⟨fun X _ => ?_, fun X Y _ _ => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · unfold Wc
    exact HamiltonsCubic.L41Statement.Frame.isSkew_sum _ _ _ fun a => om_skew a
  · rw [Wc_inner, inner2_comm X, Wc_inner]
    exact Finset.sum_congr rfl fun a _ => by rw [inner2_comm (om a) Y, inner2_comm X (om a)]; ring
  · unfold bianchi
    simp only [Wc_inner, hphi, inner2_comm (om _) (phi _ _)]
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    calc _ = ∑ a, mu a * (sq2⁻¹ * sq2⁻¹ * ∑ x, ∑ y, ∑ z, ∑ t,
          Emb n i x * Emb n j y * Emb n k z * Emb n l t * cyc (J 0) x y z t) := by
          refine Finset.sum_congr rfl fun a _ => ?_
          have h := om_cyc a i j k l
          simp only [cyc_eq] at h
          rw [← h]
          ring
      _ = 0 := by rw [← Finset.sum_mul, mu_sum, zero_mul]
  · unfold Ric
    simp only [Wc_inner, hphi, inner2_comm (om _) (phi _ _)]
    rw [Finset.sum_comm]
    calc _ = ∑ α, mu α * (sq2⁻¹ * sq2⁻¹ * ∑ j, Emb n a j * Emb n b j) := by
          refine Finset.sum_congr rfl fun α _ => ?_
          have h := congrFun (congrFun (om_sq hn α) a) b
          simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.smul_apply, smul_eq_mul] at h
          rw [← h, Finset.mul_sum]
          exact Finset.sum_congr rfl fun c _ => by ring
      _ = 0 := by rw [← Finset.sum_mul, mu_sum, zero_mul]


/-! ## The brackets, in Levi-Civita form -/

def eps : Fin 3 → Fin 3 → Fin 3 → ℤ :=
  ![![![0, 0, 0], ![0, 0, 1], ![0, -1, 0]],
    ![![0, 0, -1], ![0, 0, 0], ![1, 0, 0]],
    ![![0, 1, 0], ![-1, 0, 0], ![0, 0, 0]]]

theorem Jz_br' : ∀ (a b : Fin 3) (i j : Fin 4),
    ∑ k, Jz a i k * Jz b k j - ∑ k, Jz b i k * Jz a k j = 2 * ∑ c, eps a b c * Jz c i j := by decide

theorem Jz_br (a b : Fin 3) (i j : Fin 4) :
    (Jz a * Jz b - Jz b * Jz a) i j = 2 * ∑ c, eps a b c * Jz c i j := by
  rw [Matrix.sub_apply, Matrix.mul_apply, Matrix.mul_apply]; exact Jz_br' a b i j

theorem J_br (a b : Fin 3) : J a * J b - J b * J a = (2 : ℝ) • ∑ c, ((eps a b c : ℤ) : ℝ) • J c := by
  ext i j
  have h := Jz_br a b i j
  simp only [Matrix.sub_apply, Matrix.mul_apply, Matrix.smul_apply, Matrix.sum_apply, smul_eq_mul, J_cast]
    at h ⊢
  exact_mod_cast h

theorem EJE (a : Fin 3) : Emb n * J a * (Emb n)ᵀ = sq2 • om (n := n) a := by
  unfold om; rw [smul_smul, mul_inv_cancel₀ sq2_pos.ne', one_smul]

theorem om_br_eps (hn : 4 ≤ n) (a b : Fin 3) :
    br (om (n := n) a) (om b) = sq2 • ∑ c, ((eps a b c : ℤ) : ℝ) • om c := by
  rw [om_br hn, J_br, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_sum, Matrix.sum_mul]
  simp only [Matrix.mul_smul, Matrix.smul_mul, EJE, smul_smul, Finset.smul_sum]
  refine Finset.sum_congr rfl fun c _ => ?_
  congr 1
  have h2 := sq2_sq
  have hp := sq2_pos
  field_simp
  rw [h2]

theorem cst_om (hn : 4 ≤ n) (a b c : Fin 3) :
    inner2 (br (om (n := n) a) (om b)) (om c) = sq2 * ((eps a b c : ℤ) : ℝ) := by
  rw [om_br_eps hn, HamiltonsCubic.L41Statement.Frame.inner2_smul_l, HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  simp only [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, om_inner hn, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq', Finset.mem_univ, if_true]


/-! ## The eigenframe, and the values -/

theorem Wc_om (hn : 4 ≤ n) (b : Fin 3) : Wc n (om b) = mu b • om b := by
  unfold Wc
  simp only [om_inner hn, mul_ite, mul_one, mul_zero, ite_smul, zero_smul, Finset.sum_ite_eq, Finset.mem_univ,
    if_true]

theorem Wc_perp (X : Matrix (Fin n) (Fin n) ℝ) (h : ∀ a, inner2 X (om a) = 0) : Wc n X = 0 := by
  unfold Wc; simp [h]

open HamiltonsCubic.L41Statement in
theorem Wc_frame (hn : 4 ≤ n) : ∃ (r : ℕ) (g : Fin r → Matrix (Fin n) (Fin n) ℝ),
    (∀ c a, inner2 (g c) (om a) = 0) ∧
    EigenFrame (Wc n) (Sum.elim om g) (Sum.elim mu (fun _ => (0 : ℝ))) := by
  obtain ⟨r, g, hgs, hgon, hfg, hcomp⟩ :=
    HamiltonsCubic.FrameExtension.extend_frame (om (n := n)) om_skew (om_inner hn)
  have hgf : ∀ c a, inner2 (g c) (om (n := n) a) = 0 := fun c a => by rw [inner2_comm]; exact hfg a c
  refine ⟨r, g, hgf, ⟨?_, ?_, ?_, ?_⟩⟩
  · rintro (a|c); exacts [om_skew a, hgs c]
  · rintro (a|c) (b|e) <;> simp [om_inner hn, hgon, hfg, hgf]
  · rintro (a|c)
    · simp [Wc_om hn]
    · simp [Wc_perp _ (hgf c)]
  · intro X hX; rw [Fintype.sum_sum_type]; exact hcomp X hX

noncomputable def s6 : ℝ := Real.sqrt 6
theorem s6_sq : s6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
theorem s6_pos : 0 < s6 := Real.sqrt_pos.mpr (by norm_num)

theorem mu_vals : mu 0 = 2 / s6 ∧ mu 1 = -(1 / s6) ∧ mu 2 = -(1 / s6) := ⟨rfl, rfl, rfl⟩

theorem sqrt32 : Real.sqrt (3 / 2) = 3 / s6 := by
  rw [eq_div_iff s6_pos.ne', s6, ← Real.sqrt_mul (by norm_num)]
  rw [show (3 / 2 * 6 : ℝ) = 3 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]

theorem eps_sum (f : Fin 3 → ℝ) :
    ∑ a, ∑ b, ∑ c, f a * f b * f c * (sq2 * ((eps a b c : ℤ) : ℝ)) ^ 2 = 12 * f 0 * f 1 * f 2 := by
  simp only [Fin.sum_univ_three, eps, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.head_cons, Matrix.tail_cons, mul_pow, sq2_sq]
  push_cast
  ring

open HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame in
theorem Wc_values (hn : 4 ≤ n) :
    normSq (Wc n) = 1 ∧ trCube (Wc n) = 1 / s6 ∧ sharpPair (Wc n) = 2 / s6 := by
  obtain ⟨r, g, hgf, hf⟩ := Wc_frame hn
  have hW := Wc_weyl hn
  have h6 := s6_sq
  have hp := s6_pos
  have h2 := sq2_sq
  refine ⟨?_, ?_, ?_⟩
  · rw [normSq_frame hW hf, Fintype.sum_sum_type]
    simp only [Sum.elim_inl, Sum.elim_inr, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow,
      Finset.sum_const_zero, add_zero, Fin.sum_univ_three, mu_vals.1, mu_vals.2.1, mu_vals.2.2]
    field_simp; linarith
  · rw [trCube_frame hW hf, Fintype.sum_sum_type]
    simp only [Sum.elim_inl, Sum.elim_inr, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow,
      Finset.sum_const_zero, add_zero, Fin.sum_univ_three, mu_vals.1, mu_vals.2.1, mu_vals.2.2]
    field_simp; nlinarith
  · rw [sharpPair_T hW hf]
    simp only [Fintype.sum_sum_type, Sum.elim_inl, Sum.elim_inr, zero_mul, mul_zero, Finset.sum_const_zero,
      add_zero]
    simp only [cst, Sum.elim_inl, cst_om hn]
    rw [eps_sum, mu_vals.1, mu_vals.2.1, mu_vals.2.2]
    field_simp; nlinarith


/-! ## `θ`, and the critical equation -/

theorem Wc_theta (hn : 4 ≤ n) : theta (Wc n) = Real.sqrt (3 / 2) := by
  obtain ⟨hn1, hc, hs⟩ := Wc_values hn
  have hp := s6_pos
  unfold theta Pcubic HamiltonsCubic.RealLayer.norm
  rw [hn1, hc, hs, Real.sqrt_one, one_pow, div_one, sqrt32]
  ring

theorem br_om_frame (hn : 4 ≤ n) (η : Matrix (Fin n) (Fin n) ℝ) (hη : IsSkew η) (α β : Fin 3) :
    inner2 (br η (om α)) (om β) = sq2 * ∑ c, ((eps α β c : ℤ) : ℝ) * inner2 η (om c) := by
  have hanti : br η (om (n := n) α) = -br (om α) η := by simp only [br]; abel
  rw [hanti, inner2_comm, HamiltonsCubic.L41Statement.Frame.inner2_neg_r', inner2_comm,
    HamiltonsCubic.L41Statement.Frame.adinv _ (om_skew α) hη, neg_neg, om_br_eps hn,
    HamiltonsCubic.L41Statement.Frame.inner2_smul_r, HamiltonsCubic.L41Statement.Frame.inner2_sum_r]
  simp only [HamiltonsCubic.L41Statement.Frame.inner2_smul_r]

open HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame in
/-- **`W#` of `W_{ℂP²}` in closed form**: with `x_c = ⟨η, ω_c⟩`,
`⟨W# η, η⟩ = Σ_{αβ} μ_α μ_β (Σ_c ε_{αβc} x_c)²`. -/
theorem Wc_sharpQF (hn : 4 ≤ n) (η : Matrix (Fin n) (Fin n) ℝ) (hη : IsSkew η) :
    sharpQF (Wc n) η = ∑ α, ∑ β, mu α * mu β * (∑ c, ((eps α β c : ℤ) : ℝ) * inner2 η (om c)) ^ 2 := by
  obtain ⟨r, g, hgf, hf⟩ := Wc_frame hn
  rw [sharpQF_frame (Wc_weyl hn) hf η hη]
  simp only [Fintype.sum_sum_type, Sum.elim_inl, Sum.elim_inr, zero_mul, mul_zero, Finset.sum_const_zero,
    add_zero, br_om_frame hn η hη, mul_pow, sq2_sq, Finset.mul_sum]
  refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
  rw [← Finset.mul_sum, mul_pow, sq2_sq]
  ring

/-- **`W_{ℂP²}` is critical with multiplier `√(3/2)`**, in the bilinear form: for bivectors `X, Y`,
`⟨W²X, Y⟩ + ⟨W#X, Y⟩ = √(3/2)⟨WX, Y⟩`. -/
theorem Wc_crit (hn : 4 ≤ n) (X Y : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    inner2 (compOp (Wc n) X) Y + sharpBil (Wc n) X Y = Real.sqrt (3 / 2) * inner2 (Wc n X) Y := by
  have hWom : ∀ Z a, inner2 (Wc n Z) (om a) = mu a * inner2 Z (om a) := by
    intro Z a
    rw [Wc_inner]
    simp only [om_inner hn, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have hc : inner2 (compOp (Wc n) X) Y = ∑ a, mu a * (mu a * inner2 X (om a)) * inner2 (om a) Y := by
    unfold compOp; rw [Wc_inner]; simp only [hWom]
  have hXY : IsSkew (X + Y) := by unfold IsSkew at *; rw [Matrix.transpose_add, hX, hY, neg_add]
  unfold sharpBil
  rw [hc, Wc_inner, Wc_sharpQF hn _ hXY, Wc_sharpQF hn _ hX, Wc_sharpQF hn _ hY]
  simp only [HamiltonsCubic.L41Statement.Frame.inner2_add_l, inner2_comm (om _) Y]
  simp only [Fin.sum_univ_three, eps, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.head_cons, Matrix.tail_cons, mu_vals.1, mu_vals.2.1, mu_vals.2.2, sqrt32]
  push_cast
  have hp := s6_pos
  field_simp
  ring


/-! ## Non-diagonality -/

theorem wedge_cube (u w : Fin n → ℝ) (huu : dotProduct u u = 1) (hww : dotProduct w w = 1)
    (huw : dotProduct u w = 0) :
    let X := HamiltonsCubic.L30Statement.wedgeVec u w
    X * X * X = -X := by
  intro X
  have hwu : dotProduct w u = 0 := by rw [dotProduct_comm]; exact huw
  simp only [X, HamiltonsCubic.L30Statement.wedgeVec, Matrix.sub_mul, Matrix.mul_sub,
    Matrix.vecMulVec_mul_vecMulVec, huu, hww, huw, hwu, one_smul, zero_smul]
  ext i j
  simp [Matrix.vecMulVec_apply, Matrix.sub_apply]
  ring

theorem om_cube (hn : 4 ≤ n) : om (n := n) 0 * om 0 * om 0 = (-(1 / 2) : ℝ) • om 0 := by
  have hsq : om (n := n) 0 * om 0 = (-(sq2⁻¹ * sq2⁻¹)) • (Emb n * (Emb n)ᵀ) := by
    have h := om_sq hn (n := n) 0
    have hs := om_skew (n := n) 0
    unfold IsSkew at hs
    rw [hs, Matrix.neg_mul] at h
    rw [neg_smul, ← h, neg_neg]
  have hEE : Emb n * (Emb n)ᵀ * om (n := n) 0 = om 0 := by
    unfold om
    rw [Matrix.mul_smul]
    congr 1
    rw [show Emb n * (Emb n)ᵀ * (Emb n * J 0 * (Emb n)ᵀ) = Emb n * ((Emb n)ᵀ * Emb n) * J 0 * (Emb n)ᵀ by
      simp only [Matrix.mul_assoc], Emb_orth hn, Matrix.mul_one]
  rw [hsq, Matrix.smul_mul, hEE]
  congr 1
  have := sq2_sq; have := sq2_pos
  field_simp; linarith

theorem dot_col_conj (g M : Matrix (Fin n) (Fin n) ℝ) (i j : Fin n) :
    dotProduct (fun p => g p j) (M *ᵥ fun p => g p i) = (gᵀ * M * g) j i := by
  simp only [dotProduct, Matrix.mulVec, Matrix.mul_apply, Matrix.transpose_apply, Finset.mul_sum,
    Finset.sum_mul]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => by ring

/-- **`W_{ℂP²}` is diagonal in no orthonormal frame.** Its top eigenvalue is simple with eigenvector
`ω₀`, so a coordinate plane pairing with `ω₀` would be a multiple of it; but a unit decomposable
`X` has `X³ = -X` while `ω₀³ = -½ω₀`. -/
theorem Wc_not_diag (hn : 4 ≤ n) (g : Matrix (Fin n) (Fin n) ℝ) (hg : gᵀ * g = 1) :
    ¬ ∀ i j : Fin n, ∃ c : ℝ, Wc n (HamiltonsCubic.L30Statement.wedgeVec (fun p => g p i) (fun p => g p j))
      = c • HamiltonsCubic.L30Statement.wedgeVec (fun p => g p i) (fun p => g p j) := by
  intro hd
  have hgg : g * gᵀ = 1 := mul_eq_one_comm.mp hg
  have hp6 := s6_pos
  have hw : ∀ i j, inner2 (HamiltonsCubic.L30Statement.wedgeVec (fun p => g p i) (fun p => g p j)) (om (n := n) 0)
      = (gᵀ * om (n := n) 0 * g : Matrix (Fin n) (Fin n) ℝ) j i := fun i j => by
    rw [HamiltonsCubic.L30Statement.inner2_wedge _ _ (om_skew 0), dot_col_conj]
  -- some coordinate plane pairs with `ω₀`
  obtain ⟨i, j, hij⟩ : ∃ i j, (gᵀ * om (n := n) 0 * g : Matrix (Fin n) (Fin n) ℝ) j i ≠ 0 := by
    by_contra h
    push Not at h
    have h0 : gᵀ * om (n := n) 0 * g = 0 := by ext j i; exact h i j
    have : om (n := n) 0 = 0 := by
      have e : om (n := n) 0 = g * (gᵀ * om 0 * g) * gᵀ := by
        rw [show g * (gᵀ * om (n := n) 0 * g) * gᵀ = (g * gᵀ) * om 0 * (g * gᵀ) by simp only [Matrix.mul_assoc],
          hgg, Matrix.one_mul, Matrix.mul_one]
      rw [e, h0]; simp
    have h1 := om_inner hn (n := n) 0 0
    rw [this] at h1
    simp [inner2] at h1
  have hij' : i ≠ j := by
    intro h
    subst h
    apply hij
    rw [← hw]
    simp [HamiltonsCubic.L30Statement.wedgeVec, inner2]
  set u : Fin n → ℝ := fun p => g p i
  set w : Fin n → ℝ := fun p => g p j
  set X := HamiltonsCubic.L30Statement.wedgeVec u w with hX
  set x0 := inner2 X (om (n := n) 0) with hx0
  have hx0ne : x0 ≠ 0 := by rw [hx0, hw]; exact hij
  obtain ⟨c, hc⟩ := hd i j
  have hXs : IsSkew X := HamiltonsCubic.L30Statement.wedgeVec_isSkew u w
  have hWom : ∀ a, inner2 (Wc n X) (om a) = mu a * inner2 X (om a) := by
    intro a
    rw [Wc_inner]
    simp only [om_inner hn, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have hcom : ∀ a, c * inner2 X (om a) = mu a * inner2 X (om a) := by
    intro a
    rw [← hWom a, hc, HamiltonsCubic.L41Statement.Frame.inner2_smul_l]
  have hcm : c = mu 0 := by
    have := hcom 0
    exact mul_right_cancel₀ hx0ne this
  have hx12 : ∀ a, a ≠ 0 → inner2 X (om a) = 0 := by
    intro a ha
    have h := hcom a
    rw [hcm] at h
    have hne : mu 0 ≠ mu a := by
      fin_cases a
      · exact absurd rfl ha
      · show mu 0 ≠ mu 1
        rw [mu_vals.1, mu_vals.2.1]; intro h'; field_simp at h'; linarith
      · show mu 0 ≠ mu 2
        rw [mu_vals.1, mu_vals.2.2]; intro h'; field_simp at h'; linarith
    have := sub_eq_zero.mpr h
    rw [← sub_mul] at this
    exact (mul_eq_zero.mp this).resolve_left (sub_ne_zero.mpr hne)
  -- so `X = x₀ ω₀`
  have hWX : Wc n X = (mu 0 * x0) • om 0 := by
    unfold Wc
    rw [Fin.sum_univ_three, hx12 1 (by decide), hx12 2 (by decide)]
    simp [hx0]
  have hXeq : X = x0 • om (n := n) 0 := by
    have h := hc
    rw [hWX, hcm, mul_comm, ← smul_smul] at h
    have hm : mu 0 ≠ 0 := by rw [mu_vals.1]; positivity
    rw [smul_comm x0 (mu 0)] at h
    exact (smul_right_injective _ hm h).symm
  -- orthonormality of the two columns
  have hcol : ∀ a b, dotProduct (fun p => g p a) (fun p => g p b) = if a = b then 1 else 0 := by
    intro a b
    have := congrFun (congrFun hg a) b
    simpa [Matrix.mul_apply, Matrix.one_apply, dotProduct] using this
  have huu : dotProduct u u = 1 := by simpa [u] using hcol i i
  have hww : dotProduct w w = 1 := by simpa [w] using hcol j j
  have huw : dotProduct u w = 0 := by simpa [u, w, hij'] using hcol i j
  have hwu : dotProduct w u = 0 := by rw [dotProduct_comm]; exact huw
  have hcube := wedge_cube u w huu hww huw
  simp only at hcube
  rw [← hX, hXeq] at hcube
  have e : (x0 • om (n := n) 0) * (x0 • om 0) * (x0 • om 0) = (x0 ^ 3) • (om 0 * om 0 * om 0) := by
    simp only [Matrix.smul_mul, Matrix.mul_smul, smul_smul]; congr 1; ring
  rw [e, om_cube hn, smul_smul] at hcube
  have hpair := congrArg (fun Y => inner2 Y (om (n := n) 0)) hcube
  simp only [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, om_inner hn, if_true, mul_one] at hpair
  rw [show inner2 (-(x0 • om (n := n) 0)) (om 0) = -x0 by
    rw [inner2_comm, HamiltonsCubic.L41Statement.Frame.inner2_neg_r', inner2_comm,
      HamiltonsCubic.L41Statement.Frame.inner2_smul_l, om_inner hn, if_pos rfl, mul_one]] at hpair
  -- unit norm of the plane
  have hnorm : inner2 X X = 1 := by
    rw [HamiltonsCubic.L30Statement.inner2_wedge _ _ hXs]
    simp only [hX, HamiltonsCubic.L30Statement.wedgeVec, Matrix.sub_mulVec, Matrix.vecMulVec_mulVec,
      op_smul_eq_smul, dotProduct_sub, dotProduct_smul, smul_eq_mul, huu, hww, hwu]
    ring
  rw [hXeq, HamiltonsCubic.L41Statement.Frame.inner2_smul_l, inner2_comm,
    HamiltonsCubic.L41Statement.Frame.inner2_smul_l, om_inner hn, if_pos rfl] at hnorm
  have : x0 ^ 2 = 2 := by
    have h' : x0 * (x0 ^ 2 - 2) = 0 := by linarith
    rcases mul_eq_zero.mp h' with h | h
    · exact absurd h hx0ne
    · linarith
  nlinarith


theorem eps_neg (i j k : Fin 3) (hi : i ≠ 0) (hj : j ≠ 0) (hk : k ≠ 0) : eps i j k = 0 := by
  revert i j k; decide

end HamiltonsCubic.CP2Real
