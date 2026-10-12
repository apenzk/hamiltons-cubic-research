import HamiltonsCubic.Results.SkewNormalForm
import HamiltonsCubic.Results.L81Statement

/-!
# The centraliser of a skew matrix, in the coordinates of its normal form

Stage 2 of the [L81](L81Statement.lean) build, whose plan is written there. With
[SkewNormalForm.lean](SkewNormalForm.lean)'s `x = Σ a_j R_j`, entries are read as `co y p q = p · (y q)`
on the plane vectors `u_j, w_j` and on their orthogonal complement `K`:

* `recon`: a matrix all of whose entries vanish there is zero;
* `T_mem`: every torus element `Σ b_j R_j` with `Σ a_j b_j = 0` lies in `𝔠 = 𝔷(x) ∩ x^⊥`;
* `rotK_mem`: every rotation `z'zᵀ - zz'ᵀ` of two kernel vectors lies in `𝔠`;
* `x_mem_zPerp`: `x ∈ 𝔷(𝔠) ∩ 𝔠^⊥`;
* `torus_eqs`, `torus_K`: commuting with a torus element `Σ b_j R_j` is four linear equations on each
  pair of planes' entries and two on each plane-kernel entry;
* `upper_general`, **the upper bound off the exception**: every `y ∈ 𝔷(𝔠) ∩ 𝔠^⊥` is a multiple of `x`
  unless `x` has exactly two planes with equal singular values. Rank two uses `m ≠ 3` (`kernel_one`).
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.SkewCentraliser

open Matrix HamiltonsCubic.SkewNormalForm HamiltonsCubic.L81Statement

variable {m : ℕ}

/-- `p · (M q)`. -/
def co (M : Matrix (Fin m) (Fin m) ℝ) (p q : Fin m → ℝ) : ℝ := p ⬝ᵥ (M *ᵥ q)

theorem co_rot (u w p q : Fin m → ℝ) : co (rot u w) p q = (u ⬝ᵥ q) * (p ⬝ᵥ w) - (w ⬝ᵥ q) * (p ⬝ᵥ u) := by
  unfold co; rw [rot_mulVec, dotProduct_sub, dotProduct_smul, dotProduct_smul, smul_eq_mul, smul_eq_mul]

theorem co_skew {y : Matrix (Fin m) (Fin m) ℝ} (hy : Skew y) (p q : Fin m → ℝ) : co y q p = -co y p q := by
  unfold co; exact dot_skew' hy q p |>.trans (by rw [dotProduct_comm])

theorem inner2_rot {y : Matrix (Fin m) (Fin m) ℝ} (hy : Skew y) (p q : Fin m → ℝ) :
    inner2 y (rot p q) = -co y p q := by
  unfold inner2 rot co
  have h1 : (yᵀ * vecMulVec q p).trace = q ⬝ᵥ (y *ᵥ p) := by
    rw [Matrix.trace_mul_comm, Matrix.vecMulVec_mul, Matrix.trace_vecMulVec, Matrix.vecMul_transpose]
  have h2 : (yᵀ * vecMulVec p q).trace = p ⬝ᵥ (y *ᵥ q) := by
    rw [Matrix.trace_mul_comm, Matrix.vecMulVec_mul, Matrix.trace_vecMulVec, Matrix.vecMul_transpose]
  rw [Matrix.mul_sub, Matrix.trace_sub, h1, h2]
  have := co_skew hy p q
  unfold co at this
  rw [this]; ring

theorem co_br (A B : Matrix (Fin m) (Fin m) ℝ) (p q : Fin m → ℝ) :
    co (br A B) p q = p ⬝ᵥ (A *ᵥ (B *ᵥ q)) - p ⬝ᵥ (B *ᵥ (A *ᵥ q)) := by
  unfold co br; rw [Matrix.sub_mulVec, dotProduct_sub, ← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec]

theorem co_eq_zero {d : Matrix (Fin m) (Fin m) ℝ} (h : ∀ p q, co d p q = 0) : d = 0 := by
  ext i j
  have := h (Pi.single i 1) (Pi.single j 1)
  simpa [co, Matrix.mulVec_single, dotProduct_single] using this


theorem co_add_l (M : Matrix (Fin m) (Fin m) ℝ) (p p' q : Fin m → ℝ) : co M (p + p') q = co M p q + co M p' q := by
  unfold co; rw [add_dotProduct]
theorem co_add_r (M : Matrix (Fin m) (Fin m) ℝ) (p q q' : Fin m → ℝ) : co M p (q + q') = co M p q + co M p q' := by
  unfold co; rw [Matrix.mulVec_add, dotProduct_add]
theorem co_sub_l (M : Matrix (Fin m) (Fin m) ℝ) (p p' q : Fin m → ℝ) : co M (p - p') q = co M p q - co M p' q := by
  unfold co; rw [sub_dotProduct]
theorem co_sub_r (M : Matrix (Fin m) (Fin m) ℝ) (p q q' : Fin m → ℝ) : co M p (q - q') = co M p q - co M p q' := by
  unfold co; rw [Matrix.mulVec_sub, dotProduct_sub]
theorem co_smul_l (M : Matrix (Fin m) (Fin m) ℝ) (c : ℝ) (p q : Fin m → ℝ) : co M (c • p) q = c * co M p q := by
  unfold co; rw [smul_dotProduct, smul_eq_mul]
theorem co_smul_r (M : Matrix (Fin m) (Fin m) ℝ) (c : ℝ) (p q : Fin m → ℝ) : co M p (c • q) = c * co M p q := by
  unfold co; rw [Matrix.mulVec_smul, dotProduct_smul, smul_eq_mul]
theorem co_sum_l {κ : Type*} (s : Finset κ) (M : Matrix (Fin m) (Fin m) ℝ) (f : κ → Fin m → ℝ) (q : Fin m → ℝ) :
    co M (∑ i ∈ s, f i) q = ∑ i ∈ s, co M (f i) q := by
  unfold co; rw [sum_dotProduct]
theorem co_sum_r {κ : Type*} (s : Finset κ) (M : Matrix (Fin m) (Fin m) ℝ) (p : Fin m → ℝ) (f : κ → Fin m → ℝ) :
    co M p (∑ i ∈ s, f i) = ∑ i ∈ s, co M p (f i) := by
  unfold co; rw [Matrix.mulVec_sum, dotProduct_sum]

/-- **The normal-form data of a skew matrix.** -/
structure NF (x : Matrix (Fin m) (Fin m) ℝ) where
  k : ℕ
  u : Fin k → Fin m → ℝ
  w : Fin k → Fin m → ℝ
  a : Fin k → ℝ
  apos : ∀ j, 0 < a j
  uu : ∀ i j, u i ⬝ᵥ u j = if i = j then 1 else 0
  ww : ∀ i j, w i ⬝ᵥ w j = if i = j then 1 else 0
  uw : ∀ i j, u i ⬝ᵥ w j = 0
  eq : x = ∑ j, a j • rot (u j) (w j)

theorem nf_exists {x : Matrix (Fin m) (Fin m) ℝ} (hx : Skew x) : Nonempty (NF x) := by
  obtain ⟨k, u, w, a, h1, h2, h3, h4, -, h6⟩ := skew_normal_form _ x hx rfl
  exact ⟨⟨k, u, w, a, h1, h2, h3, h4, h6⟩⟩

variable {x : Matrix (Fin m) (Fin m) ℝ} (N : NF x)

/-- The orthogonal complement of the planes. -/
def InK (z : Fin m → ℝ) : Prop := ∀ j, N.u j ⬝ᵥ z = 0 ∧ N.w j ⬝ᵥ z = 0

def proj (v : Fin m → ℝ) : Fin m → ℝ := ∑ j, ((N.u j ⬝ᵥ v) • N.u j + (N.w j ⬝ᵥ v) • N.w j)

theorem wu (i j : Fin N.k) : N.w i ⬝ᵥ N.u j = 0 := by rw [dotProduct_comm]; exact N.uw j i

theorem u_proj (i : Fin N.k) (v : Fin m → ℝ) : N.u i ⬝ᵥ proj N v = N.u i ⬝ᵥ v := by
  simp only [proj, dotProduct_sum, dotProduct_add, dotProduct_smul, smul_eq_mul, N.uu, N.uw, mul_ite, mul_one,
    mul_zero, add_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true]

theorem w_proj (i : Fin N.k) (v : Fin m → ℝ) : N.w i ⬝ᵥ proj N v = N.w i ⬝ᵥ v := by
  simp only [proj, dotProduct_sum, dotProduct_add, dotProduct_smul, smul_eq_mul, N.ww, wu N, mul_ite, mul_one,
    mul_zero, zero_add, Finset.sum_ite_eq, Finset.mem_univ, if_true]

theorem kp_inK (v : Fin m → ℝ) : InK N (v - proj N v) := fun j =>
  ⟨by rw [dotProduct_sub, u_proj, sub_self], by rw [dotProduct_sub, w_proj, sub_self]⟩

/-- **Reconstruction**: a matrix whose entries vanish on the planes and on their complement is zero. -/
theorem recon (d : Matrix (Fin m) (Fin m) ℝ)
    (hVV : ∀ j l, co d (N.u j) (N.u l) = 0 ∧ co d (N.u j) (N.w l) = 0 ∧ co d (N.w j) (N.u l) = 0 ∧
      co d (N.w j) (N.w l) = 0)
    (hVK : ∀ j z, InK N z → co d (N.u j) z = 0 ∧ co d (N.w j) z = 0)
    (hKV : ∀ j z, InK N z → co d z (N.u j) = 0 ∧ co d z (N.w j) = 0)
    (hKK : ∀ z z', InK N z → InK N z' → co d z z' = 0) : d = 0 := by
  apply co_eq_zero
  have hq : ∀ (p : Fin m → ℝ) (q : Fin m → ℝ), (∀ j, co d p (N.u j) = 0 ∧ co d p (N.w j) = 0) →
      (∀ z, InK N z → co d p z = 0) → co d p q = 0 := by
    intro p q h1 h2
    rw [show q = proj N q + (q - proj N q) by abel, co_add_r, h2 _ (kp_inK N q), add_zero]
    simp only [proj, co_sum_r, co_add_r, co_smul_r, (h1 _).1, (h1 _).2, mul_zero, add_zero,
      Finset.sum_const_zero]
  intro p q
  rw [show p = proj N p + (p - proj N p) by abel, co_add_l]
  have hk := kp_inK N p
  rw [hq _ q (fun j => hKV j _ hk) (fun z hz => hKK _ z hk hz), add_zero]
  simp only [proj, co_sum_l, co_add_l, co_smul_l]
  refine Finset.sum_eq_zero fun j _ => ?_
  rw [hq (N.u j) q (fun l => ⟨(hVV j l).1, (hVV j l).2.1⟩) (fun z hz => (hVK j z hz).1),
    hq (N.w j) q (fun l => ⟨(hVV j l).2.2.1, (hVV j l).2.2.2⟩) (fun z hz => (hVK j z hz).2)]
  ring


/-- The plane rotation `R_j`. -/
def R (j : Fin N.k) : Matrix (Fin m) (Fin m) ℝ := rot (N.u j) (N.w j)

/-- A torus element `Σ b_j R_j`. -/
def T (b : Fin N.k → ℝ) : Matrix (Fin m) (Fin m) ℝ := ∑ j, b j • R N j

theorem R_skew (j : Fin N.k) : Skew (R N j) := rot_skew _ _

theorem skew_sum_smul {κ : Type*} (s : Finset κ) (c : κ → ℝ) (M : κ → Matrix (Fin m) (Fin m) ℝ)
    (h : ∀ i, Skew (M i)) : Skew (∑ i ∈ s, c i • M i) := by
  unfold Skew at *
  rw [Matrix.transpose_sum]
  simp only [Matrix.transpose_smul, h, smul_neg, Finset.sum_neg_distrib]

theorem T_skew (b : Fin N.k → ℝ) : Skew (T N b) := skew_sum_smul _ _ _ (R_skew N)

theorem x_eq_T : x = T N N.a := N.eq

theorem R_mulVec (j : Fin N.k) (v : Fin m → ℝ) :
    R N j *ᵥ v = (N.u j ⬝ᵥ v) • N.w j - (N.w j ⬝ᵥ v) • N.u j := rot_mulVec _ _ _

theorem R_mul_R {j l : Fin N.k} (h : j ≠ l) : R N j * R N l = 0 := by
  apply co_eq_zero; intro p q
  unfold co
  rw [← Matrix.mulVec_mulVec, R_mulVec N l, Matrix.mulVec_sub, Matrix.mulVec_smul, Matrix.mulVec_smul,
    R_mulVec, R_mulVec]
  simp [N.uu, N.uw, N.ww, wu N, h, Ne.symm h]

theorem R_comm (j l : Fin N.k) : R N j * R N l = R N l * R N j := by
  by_cases h : j = l
  · rw [h]
  · rw [R_mul_R N h, R_mul_R N (Ne.symm h)]

theorem T_comm (b c : Fin N.k → ℝ) : T N b * T N c = T N c * T N b := by
  unfold T
  rw [Finset.sum_mul_sum, Finset.sum_mul_sum, Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
  rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_smul, smul_smul, smul_smul, R_comm, mul_comm]

theorem inner2_R_R (j l : Fin N.k) : inner2 (R N j) (R N l) = if j = l then 1 else 0 := by
  unfold R
  rw [inner2_rot (rot_skew _ _), co_rot, N.uw, N.ww, N.uu]
  rw [show N.u l ⬝ᵥ N.w j = 0 from N.uw l j]
  by_cases h : j = l
  · subst h; simp [N.uu, N.ww]
  · simp [h, Ne.symm h]

theorem inner2_sum_l' {κ : Type*} (s : Finset κ) (f : κ → Matrix (Fin m) (Fin m) ℝ) (Y : Matrix (Fin m) (Fin m) ℝ) :
    inner2 (∑ i ∈ s, f i) Y = ∑ i ∈ s, inner2 (f i) Y := by
  unfold inner2; rw [Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]

theorem inner2_T_T (b c : Fin N.k → ℝ) : inner2 (T N b) (T N c) = ∑ j, b j * c j := by
  unfold T
  rw [inner2_sum_l']
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [inner2_smul_left]
  have : inner2 (R N j) (∑ l, c l • R N l) = c j := by
    unfold inner2
    rw [Matrix.mul_sum, Matrix.trace_sum, Finset.mul_sum]
    simp only [Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]
    have e : ∀ l, 1 / 2 * (c l * ((R N j)ᵀ * R N l).trace) = c l * inner2 (R N j) (R N l) := by
      intro l; unfold inner2; ring
    simp only [e, inner2_R_R, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  rw [this]

/-- **The torus part of `𝔠`**: `Σ b_j R_j ∈ 𝔠` when `Σ a_j b_j = 0`. -/
theorem T_mem (b : Fin N.k → ℝ) (hb : ∑ j, N.a j * b j = 0) : T N b ∈ cc x := by
  refine ⟨T_skew N b, ?_, ?_⟩
  · have h : inner2 (T N N.a) (T N b) = 0 := by rw [inner2_T_T, hb]
    rwa [← x_eq_T N] at h
  · have h : T N N.a * T N b - T N b * T N N.a = 0 := by rw [T_comm, sub_self]
    unfold br; rwa [← x_eq_T N] at h

theorem x_K {z : Fin m → ℝ} (hz : InK N z) : x *ᵥ z = 0 := by
  rw [x_eq_T N]; unfold T
  rw [Matrix.sum_mulVec]
  refine Finset.sum_eq_zero fun j _ => ?_
  rw [Matrix.smul_mulVec, R_mulVec, (hz j).1, (hz j).2]; simp

/-- **Rotations inside the kernel lie in `𝔠`.** -/
theorem rotK_mem (hx : Skew x) {z z' : Fin m → ℝ} (hz : InK N z) (hz' : InK N z') : rot z z' ∈ cc x := by
  refine ⟨rot_skew _ _, ?_, ?_⟩
  · rw [inner2_rot hx]; unfold co; rw [x_K N hz', dotProduct_zero]; ring
  · apply co_eq_zero; intro p q
    rw [co_br, rot_mulVec, Matrix.mulVec_sub, Matrix.mulVec_smul, Matrix.mulVec_smul, x_K N hz, x_K N hz']
    rw [rot_mulVec]
    have h1 : z ⬝ᵥ (x *ᵥ q) = 0 := by rw [dot_skew' hx, x_K N hz, zero_dotProduct, neg_zero]
    have h2 : z' ⬝ᵥ (x *ᵥ q) = 0 := by rw [dot_skew' hx, x_K N hz', zero_dotProduct, neg_zero]
    rw [h1, h2]; simp

theorem x_mem_zPerp (hx : Skew x) : x ∈ zPerp x := ⟨hx, fun w hw => hw.2.2, fun w hw => hw.2.1⟩


theorem T_u (b : Fin N.k → ℝ) (k : Fin N.k) : T N b *ᵥ N.u k = b k • N.w k := by
  unfold T
  simp only [Matrix.sum_mulVec, Matrix.smul_mulVec, R_mulVec, N.uu, wu N, ite_smul, one_smul, zero_smul,
    sub_zero, smul_ite, smul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]

theorem T_w (b : Fin N.k → ℝ) (k : Fin N.k) : T N b *ᵥ N.w k = -(b k • N.u k) := by
  unfold T
  simp only [Matrix.sum_mulVec, Matrix.smul_mulVec, R_mulVec, N.uw, N.ww, ite_smul, one_smul, zero_smul,
    zero_sub, smul_neg, smul_ite, smul_zero, neg_ite, neg_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]

theorem T_K (b : Fin N.k → ℝ) {z : Fin m → ℝ} (hz : InK N z) : T N b *ᵥ z = 0 := by
  unfold T
  simp only [Matrix.sum_mulVec, Matrix.smul_mulVec, R_mulVec, (hz _).1, (hz _).2, zero_smul, sub_zero,
    smul_zero, Finset.sum_const_zero]

theorem u_T (b : Fin N.k → ℝ) (j : Fin N.k) (v : Fin m → ℝ) :
    N.u j ⬝ᵥ (T N b *ᵥ v) = -(b j * (N.w j ⬝ᵥ v)) := by
  rw [dot_skew' (T_skew N b), T_u, smul_dotProduct, smul_eq_mul]

theorem w_T (b : Fin N.k → ℝ) (j : Fin N.k) (v : Fin m → ℝ) :
    N.w j ⬝ᵥ (T N b *ᵥ v) = b j * (N.u j ⬝ᵥ v) := by
  rw [dot_skew' (T_skew N b), T_w, neg_dotProduct, smul_dotProduct, smul_eq_mul, neg_neg]

/-- **What commuting with a torus element says, entry by entry.** -/
theorem torus_eqs {y : Matrix (Fin m) (Fin m) ℝ} {b : Fin N.k → ℝ} (hc : br y (T N b) = 0) (j k : Fin N.k) :
    b k * co y (N.u j) (N.w k) + b j * co y (N.w j) (N.u k) = 0 ∧
    b k * co y (N.w j) (N.u k) + b j * co y (N.u j) (N.w k) = 0 ∧
    b j * co y (N.w j) (N.w k) - b k * co y (N.u j) (N.u k) = 0 ∧
    b k * co y (N.w j) (N.w k) - b j * co y (N.u j) (N.u k) = 0 := by
  have e : ∀ p q, co y p (T N b *ᵥ q) - p ⬝ᵥ (T N b *ᵥ (y *ᵥ q)) = 0 := by
    intro p q
    have := congrArg (fun M => co M p q) hc
    simp only [co_br] at this
    unfold co at *
    simpa [co] using this
  refine ⟨?_, ?_, ?_, ?_⟩
  · have h := e (N.u j) (N.u k)
    rw [T_u, co_smul_r, u_T] at h; unfold co at *; linarith
  · have h := e (N.w j) (N.w k)
    rw [T_w, show co y (N.w j) (-(b k • N.u k)) = -(b k * co y (N.w j) (N.u k)) by
      unfold co; rw [Matrix.mulVec_neg, Matrix.mulVec_smul, dotProduct_neg, dotProduct_smul, smul_eq_mul], w_T] at h
    unfold co at *; linarith
  · have h := e (N.u j) (N.w k)
    rw [T_w, show co y (N.u j) (-(b k • N.u k)) = -(b k * co y (N.u j) (N.u k)) by
      unfold co; rw [Matrix.mulVec_neg, Matrix.mulVec_smul, dotProduct_neg, dotProduct_smul, smul_eq_mul], u_T] at h
    unfold co at *; linarith
  · have h := e (N.w j) (N.u k)
    rw [T_u, co_smul_r, w_T] at h; unfold co at *; linarith

theorem torus_K {y : Matrix (Fin m) (Fin m) ℝ} {b : Fin N.k → ℝ} (hc : br y (T N b) = 0) (j : Fin N.k)
    {z : Fin m → ℝ} (hz : InK N z) : b j * co y (N.w j) z = 0 ∧ b j * co y (N.u j) z = 0 := by
  have e : ∀ p q, co y p (T N b *ᵥ q) - p ⬝ᵥ (T N b *ᵥ (y *ᵥ q)) = 0 := by
    intro p q
    have := congrArg (fun M => co M p q) hc
    simp only [co_br] at this
    unfold co at *
    simpa [co] using this
  refine ⟨?_, ?_⟩
  · have h := e (N.u j) z
    rw [T_K N b hz, u_T] at h; unfold co at *; simp at h; rcases h with h | h <;> simp [h]
  · have h := e (N.w j) z
    rw [T_K N b hz, w_T] at h; unfold co at *; simp at h; rcases h with h | h <;> simp [h]

/-! ## Dimension facts -/

/-- **Fewer than `m` vectors have a nonzero common orthogonal vector.** -/
theorem exists_perp {r : ℕ} (vs : Fin r → Fin m → ℝ) (h : r < m) : ∃ v : Fin m → ℝ, v ≠ 0 ∧ ∀ i, vs i ⬝ᵥ v = 0 := by
  let M : Matrix (Fin r) (Fin m) ℝ := Matrix.of fun i j => vs i j
  have hk : LinearMap.ker (Matrix.mulVecLin M) ≠ ⊥ :=
    LinearMap.ker_ne_bot_of_finrank_lt (by simpa using h)
  obtain ⟨v, hv, hne⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hk
  refine ⟨v, hne, fun i => ?_⟩
  have := congrFun (LinearMap.mem_ker.mp hv) i
  simpa [M, Matrix.mulVec, dotProduct] using this

/-- **Nonzero pairwise orthogonal vectors number at most `m`.** -/
theorem orth_card {r : ℕ} (vs : Fin r → Fin m → ℝ) (hne : ∀ i, vs i ≠ 0)
    (horth : ∀ i j, i ≠ j → vs i ⬝ᵥ vs j = 0) : r ≤ m := by
  have hli : LinearIndependent ℝ vs := by
    rw [Fintype.linearIndependent_iff]
    intro g hg i
    have := congrArg (fun v => vs i ⬝ᵥ v) hg
    simp only [dotProduct_sum, dotProduct_smul, smul_eq_mul, dotProduct_zero] at this
    rw [Finset.sum_eq_single i (fun j _ hj => by rw [horth i j (Ne.symm hj), mul_zero]) (by simp)] at this
    rcases mul_eq_zero.mp this with h | h
    · exact h
    · exact absurd (dotProduct_self_eq_zero.mp h) (hne i)
  simpa using hli.fintype_card_le_finrank

/-! ## `x`'s own entries -/

theorem x_u (l : Fin N.k) : x *ᵥ N.u l = N.a l • N.w l := by
  have h := T_u N N.a l; rwa [← x_eq_T N] at h
theorem x_w (l : Fin N.k) : x *ᵥ N.w l = -(N.a l • N.u l) := by
  have h := T_w N N.a l; rwa [← x_eq_T N] at h

theorem co_x_uu (j l : Fin N.k) : co x (N.u j) (N.u l) = 0 := by
  unfold co; rw [x_u, dotProduct_smul, N.uw, smul_zero]
theorem co_x_ww (j l : Fin N.k) : co x (N.w j) (N.w l) = 0 := by
  unfold co; rw [x_w, dotProduct_neg, dotProduct_smul, wu N, smul_zero, neg_zero]
theorem co_x_uw (j l : Fin N.k) : co x (N.u j) (N.w l) = if j = l then -N.a j else 0 := by
  unfold co; rw [x_w, dotProduct_neg, dotProduct_smul, N.uu, smul_eq_mul]
  by_cases h : j = l <;> simp [h]
theorem co_x_wu (j l : Fin N.k) : co x (N.w j) (N.u l) = if j = l then N.a j else 0 := by
  unfold co; rw [x_u, dotProduct_smul, N.ww, smul_eq_mul]
  by_cases h : j = l <;> simp [h]
theorem co_x_K_r (p : Fin m → ℝ) {z : Fin m → ℝ} (hz : InK N z) : co x p z = 0 := by
  unfold co; rw [x_K N hz, dotProduct_zero]

/-! ## Orthogonality to the torus -/

theorem inner2_sum_r' {κ : Type*} (s : Finset κ) (X : Matrix (Fin m) (Fin m) ℝ) (f : κ → Matrix (Fin m) (Fin m) ℝ) :
    inner2 X (∑ i ∈ s, f i) = ∑ i ∈ s, inner2 X (f i) := by
  unfold inner2; rw [Matrix.mul_sum, Matrix.trace_sum, Finset.mul_sum]

theorem inner2_T {y : Matrix (Fin m) (Fin m) ℝ} (hy : Skew y) (b : Fin N.k → ℝ) :
    inner2 y (T N b) = -∑ j, b j * co y (N.u j) (N.w j) := by
  unfold T
  rw [inner2_sum_r', ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [inner2_smul_right, R, inner2_rot hy]; ring

/-- The two-index torus element `a_l e_j - a_j e_l`, orthogonal to `a`. -/
def bb (j l : Fin N.k) : Fin N.k → ℝ := fun i => (if i = j then N.a l else 0) - (if i = l then N.a j else 0)

theorem bb_perp (j l : Fin N.k) : ∑ i, N.a i * bb N j l i = 0 := by
  simp only [bb, mul_sub, mul_ite, mul_zero, Finset.sum_sub_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  ring

theorem bb_j {j l : Fin N.k} (h : j ≠ l) : bb N j l j = N.a l := by simp [bb, h]
theorem bb_l {j l : Fin N.k} (h : j ≠ l) : bb N j l l = -N.a j := by simp [bb, Ne.symm h]
theorem bb_other {j l i : Fin N.k} (hj : i ≠ j) (hl : i ≠ l) : bb N j l i = 0 := by simp [bb, hj, hl]

/-! ## The upper bound, entry by entry -/

section Upper

variable {y : Matrix (Fin m) (Fin m) ℝ} (hy : y ∈ zPerp x)
include hy

theorem hcomm (b : Fin N.k → ℝ) (hb : ∑ j, N.a j * b j = 0) : br y (T N b) = 0 := hy.2.1 _ (T_mem N b hb)

/-- **Off-diagonal entries die when a third plane exists.** -/
theorem offdiag_third {j l i : Fin N.k} (hij : i ≠ j) (hil : i ≠ l) (hjl : j ≠ l) :
    co y (N.u j) (N.u l) = 0 ∧ co y (N.w j) (N.w l) = 0 ∧ co y (N.u j) (N.w l) = 0 ∧
      co y (N.w j) (N.u l) = 0 := by
  have hc := hcomm N hy (bb N j i) (bb_perp N j i)
  obtain ⟨e1, e2, e3, e4⟩ := torus_eqs N hc j l
  rw [bb_j N (Ne.symm hij), bb_other N (Ne.symm hjl) (Ne.symm hil)] at e1 e2 e3 e4
  have ha := N.apos i
  refine ⟨?_, ?_, ?_, ?_⟩
  · have : N.a i * co y (N.u j) (N.u l) = 0 := by linarith
    exact (mul_eq_zero.mp this).resolve_left ha.ne'
  · have : N.a i * co y (N.w j) (N.w l) = 0 := by linarith
    exact (mul_eq_zero.mp this).resolve_left ha.ne'
  · have : N.a i * co y (N.u j) (N.w l) = 0 := by linarith
    exact (mul_eq_zero.mp this).resolve_left ha.ne'
  · have : N.a i * co y (N.w j) (N.u l) = 0 := by linarith
    exact (mul_eq_zero.mp this).resolve_left ha.ne'

/-- **Off-diagonal entries die between planes of different singular value.** -/
theorem offdiag_neq {j l : Fin N.k} (hjl : j ≠ l) (hne : N.a j ≠ N.a l) :
    co y (N.u j) (N.u l) = 0 ∧ co y (N.w j) (N.w l) = 0 ∧ co y (N.u j) (N.w l) = 0 ∧
      co y (N.w j) (N.u l) = 0 := by
  have hc := hcomm N hy (bb N j l) (bb_perp N j l)
  obtain ⟨e1, e2, e3, e4⟩ := torus_eqs N hc j l
  rw [bb_j N hjl, bb_l N hjl] at e1 e2 e3 e4
  have hj := N.apos j
  have hl := N.apos l
  have hsq : N.a l ^ 2 - N.a j ^ 2 ≠ 0 := by
    intro h
    have : (N.a l - N.a j) * (N.a l + N.a j) = 0 := by linear_combination h
    rcases mul_eq_zero.mp this with h' | h'
    · exact hne (by linarith)
    · linarith
  refine ⟨?_, ?_, ?_, ?_⟩
  · have : (N.a l ^ 2 - N.a j ^ 2) * co y (N.u j) (N.u l) = 0 := by
      linear_combination (-N.a j) * e3 + (-N.a l) * e4
    exact (mul_eq_zero.mp this).resolve_left hsq
  · have : (N.a l ^ 2 - N.a j ^ 2) * co y (N.w j) (N.w l) = 0 := by
      linear_combination N.a l * e3 + N.a j * e4
    exact (mul_eq_zero.mp this).resolve_left hsq
  · have : (N.a l ^ 2 - N.a j ^ 2) * co y (N.u j) (N.w l) = 0 := by
      linear_combination N.a j * e1 + N.a l * e2
    exact (mul_eq_zero.mp this).resolve_left hsq
  · have : (N.a l ^ 2 - N.a j ^ 2) * co y (N.w j) (N.u l) = 0 := by
      linear_combination N.a l * e1 + N.a j * e2
    exact (mul_eq_zero.mp this).resolve_left hsq

/-- **Plane-kernel entries die when a second plane exists.** -/
theorem kernel_two {j l : Fin N.k} (hjl : j ≠ l) {z : Fin m → ℝ} (hz : InK N z) :
    co y (N.u j) z = 0 ∧ co y (N.w j) z = 0 := by
  have hc := hcomm N hy (bb N j l) (bb_perp N j l)
  obtain ⟨h1, h2⟩ := torus_K N hc j hz
  rw [bb_j N hjl] at h1 h2
  have ha := N.apos l
  exact ⟨(mul_eq_zero.mp h2).resolve_left ha.ne', (mul_eq_zero.mp h1).resolve_left ha.ne'⟩

/-- **Kernel-kernel entries die against `𝔠`.** -/
theorem kernel_kernel (hx : Skew x) {z z' : Fin m → ℝ} (hz : InK N z) (hz' : InK N z') : co y z z' = 0 := by
  have h := hy.2.2 _ (rotK_mem N hx hz hz')
  rw [inner2_rot hy.1] at h
  linarith

/-- **The kernel-rotation identity**: for `p` orthogonal to two kernel vectors `z, z'`,
`(z·z') y(p,z') = (z'·z') y(p,z)`. -/
theorem kernel_rot (hx : Skew x) {z z' p : Fin m → ℝ} (hz : InK N z) (hz' : InK N z')
    (hpz : z ⬝ᵥ p = 0) (hpz' : z' ⬝ᵥ p = 0) :
    (z ⬝ᵥ z') * co y p z' - (z' ⬝ᵥ z') * co y p z = 0 := by
  have hc := hy.2.1 _ (rotK_mem N hx hz hz')
  have := congrArg (fun M => co M p z') hc
  simp only [co_br] at this
  rw [rot_mulVec, Matrix.mulVec_sub, Matrix.mulVec_smul, Matrix.mulVec_smul, dotProduct_sub, dotProduct_smul,
    dotProduct_smul, smul_eq_mul, smul_eq_mul] at this
  have h2 : p ⬝ᵥ (rot z z' *ᵥ (y *ᵥ z')) = 0 := by
    rw [rot_mulVec, dotProduct_sub, dotProduct_smul, dotProduct_smul, smul_eq_mul, smul_eq_mul,
      dotProduct_comm p z', dotProduct_comm p z, hpz, hpz']; ring
  rw [h2] at this
  unfold co at this ⊢
  rw [Matrix.zero_mulVec, dotProduct_zero] at this
  rw [dotProduct_comm z z'] at *; linarith

end Upper


theorem exists_third {k : ℕ} (hk : 3 ≤ k) (j l : Fin k) : ∃ i : Fin k, i ≠ j ∧ i ≠ l := by
  by_contra h
  have e : ∀ i : Fin k, i = j ∨ i = l := fun i => by
    by_contra hh
    exact h ⟨i, fun h1 => hh (Or.inl h1), fun h2 => hh (Or.inr h2)⟩
  rcases e ⟨0, by omega⟩ with h0 | h0 <;> rcases e ⟨1, by omega⟩ with h1 | h1 <;>
    rcases e ⟨2, by omega⟩ with h2 | h2 <;> simp only [Fin.ext_iff] at h0 h1 h2 <;> omega

theorem exists_other {k : ℕ} (hk : 2 ≤ k) (j : Fin k) : ∃ l : Fin k, j ≠ l := by
  by_cases h : j.val = 0
  · exact ⟨⟨1, by omega⟩, fun h' => by simp [Fin.ext_iff] at h'; omega⟩
  · exact ⟨⟨0, by omega⟩, fun h' => by simp [Fin.ext_iff] at h'; omega⟩

theorem co_matsub (A B : Matrix (Fin m) (Fin m) ℝ) (p q : Fin m → ℝ) : co (A - B) p q = co A p q - co B p q := by
  unfold co; rw [Matrix.sub_mulVec, dotProduct_sub]
theorem co_matsmul (c : ℝ) (A : Matrix (Fin m) (Fin m) ℝ) (p q : Fin m → ℝ) : co (c • A) p q = c * co A p q := by
  unfold co; rw [Matrix.smul_mulVec, dotProduct_smul, smul_eq_mul]
theorem co_self {y : Matrix (Fin m) (Fin m) ℝ} (hy : Skew y) (p : Fin m → ℝ) : co y p p = 0 := by
  have := co_skew hy p p; linarith

section Upper2

variable {y : Matrix (Fin m) (Fin m) ℝ} (hy : y ∈ zPerp x)
include hy

/-- **Rank two: the kernel entries die by a kernel rotation**, which needs a third direction
orthogonal to the plane and to `z`, and that is where `m ≠ 3` enters. -/
theorem kernel_one (hx : Skew x) (hm : m ≠ 3) (hk1 : N.k = 1) (j : Fin N.k) {z : Fin m → ℝ} (hz : InK N z) :
    co y (N.u j) z = 0 ∧ co y (N.w j) z = 0 := by
  by_cases hz0 : z = 0
  · subst hz0; simp [co]
  have huj : N.u j ≠ 0 := fun h => by have := N.uu j j; simp [h] at this
  have hwj : N.w j ≠ 0 := fun h => by have := N.ww j j; simp [h] at this
  have hzu : N.u j ⬝ᵥ z = 0 := (hz j).1
  have hzw : N.w j ⬝ᵥ z = 0 := (hz j).2
  have huw : N.u j ⬝ᵥ N.w j = 0 := N.uw j j
  have h3 : 3 ≤ m := by
    refine orth_card ![N.u j, N.w j, z] (fun i => by fin_cases i <;> simpa) (fun i l hil => ?_)
    fin_cases i <;> fin_cases l <;> simp_all [dotProduct_comm]
  obtain ⟨z', hz'0, hz'⟩ := exists_perp ![N.u j, N.w j, z] (by omega)
  have hsub : ∀ i : Fin N.k, i = j := fun i => by
    have : Subsingleton (Fin N.k) := by rw [hk1]; infer_instance
    exact Subsingleton.elim _ _
  have hz'K : InK N z' := fun i => by rw [hsub i]; exact ⟨hz' 0, hz' 1⟩
  have hz'z : z ⬝ᵥ z' = 0 := hz' 2
  have hz'z' : z' ⬝ᵥ z' ≠ 0 := fun h => hz'0 (dotProduct_self_eq_zero.mp h)
  have e1 := kernel_rot N hy hx hz hz'K (p := N.u j) (by rw [dotProduct_comm]; exact hzu)
    (by rw [dotProduct_comm]; exact hz' 0)
  have e2 := kernel_rot N hy hx hz hz'K (p := N.w j) (by rw [dotProduct_comm]; exact hzw)
    (by rw [dotProduct_comm]; exact hz' 1)
  rw [hz'z, zero_mul, zero_sub, neg_eq_zero] at e1 e2
  exact ⟨(mul_eq_zero.mp e1).resolve_left hz'z', (mul_eq_zero.mp e2).resolve_left hz'z'⟩

/-- **The diagonal entries are proportional to the singular values.** -/
theorem diag_prop (j j0 : Fin N.k) :
    N.a j0 * co y (N.u j) (N.w j) = N.a j * co y (N.u j0) (N.w j0) := by
  by_cases h : j = j0
  · subst h; ring
  have h1 := hy.2.2 _ (T_mem N (bb N j j0) (bb_perp N j j0))
  rw [inner2_T N hy.1] at h1
  have : ∑ i, bb N j j0 i * co y (N.u i) (N.w i) = N.a j0 * co y (N.u j) (N.w j) - N.a j * co y (N.u j0) (N.w j0) := by
    simp only [bb, sub_mul, ite_mul, zero_mul, Finset.sum_sub_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  linarith

/-- **THE UPPER BOUND OFF THE EXCEPTION**: `y ∈ 𝔷(𝔠) ∩ 𝔠^⊥` is a multiple of `x`, unless `x` has exactly two
planes with equal singular values. -/
theorem upper_general (hx : Skew x) (hm : m ≠ 3) (hk : 0 < N.k)
    (hexc : N.k = 2 → ∀ j l : Fin N.k, j ≠ l → N.a j ≠ N.a l) : ∃ s : ℝ, y = s • x := by
  set j0 : Fin N.k := ⟨0, hk⟩
  set s : ℝ := -(co y (N.u j0) (N.w j0) / N.a j0) with hs
  have ha0 := N.apos j0
  refine ⟨s, ?_⟩
  have hd : Skew (y - s • x) := by
    unfold Skew at *; rw [Matrix.transpose_sub, Matrix.transpose_smul, hy.1, hx, smul_neg]; abel
  suffices h : y - s • x = 0 from sub_eq_zero.mp h
  apply recon N
  · intro j l
    simp only [co_matsub, co_matsmul, co_x_uu, co_x_ww, co_x_uw, co_x_wu]
    by_cases hjl : j = l
    · subst hjl
      simp only [if_true]
      have hd1 := diag_prop N hy j j0
      have hsk : co y (N.w j) (N.u j) = -co y (N.u j) (N.w j) := co_skew hy.1 _ _
      refine ⟨by rw [co_self hy.1]; ring, ?_, ?_, by rw [co_self hy.1]; ring⟩
      · rw [hs]; field_simp; linarith
      · rw [hsk, hs]; field_simp; linarith
    · simp only [if_neg hjl, mul_zero, sub_zero]
      by_cases h3 : 3 ≤ N.k
      · obtain ⟨i, hij, hil⟩ := exists_third h3 j l
        obtain ⟨a1, a2, a3, a4⟩ := offdiag_third N hy hij hil hjl
        exact ⟨a1, a3, a4, a2⟩
      · have h2 : N.k = 2 := by
          have : j.val ≠ l.val := fun h => hjl (Fin.ext h)
          have := j.2; have := l.2; omega
        obtain ⟨a1, a2, a3, a4⟩ := offdiag_neq N hy hjl (hexc h2 j l hjl)
        exact ⟨a1, a3, a4, a2⟩
  · intro j z hz
    simp only [co_matsub, co_matsmul, co_x_K_r N _ hz, mul_zero, sub_zero]
    by_cases h2 : 2 ≤ N.k
    · obtain ⟨l, hjl⟩ := exists_other h2 j
      exact kernel_two N hy hjl hz
    · exact kernel_one N hy hx hm (by omega) j hz
  · intro j z hz
    have hK : co y (N.u j) z = 0 ∧ co y (N.w j) z = 0 := by
      by_cases h2 : 2 ≤ N.k
      · obtain ⟨l, hjl⟩ := exists_other h2 j
        exact kernel_two N hy hjl hz
      · exact kernel_one N hy hx hm (by omega) j hz
    simp only [co_matsub, co_matsmul]
    rw [co_skew hy.1 (N.u j) z, co_skew hy.1 (N.w j) z, co_skew hx (N.u j) z, co_skew hx (N.w j) z,
      co_x_K_r N _ hz, co_x_K_r N _ hz, hK.1, hK.2]
    simp
  · intro z z' hz hz'
    rw [co_matsub, co_matsmul, co_x_K_r N _ hz', kernel_kernel N hy hx hz hz']; ring

end Upper2


/-! ## The exception: two planes with equal singular values -/

section Exc

/-- The two elements that survive in the exception: the anti-linear maps between the two planes. -/
def Y1 (i j : Fin N.k) : Matrix (Fin m) (Fin m) ℝ := rot (N.u j) (N.u i) - rot (N.w j) (N.w i)
def Y2 (i j : Fin N.k) : Matrix (Fin m) (Fin m) ℝ := rot (N.w j) (N.u i) + rot (N.u j) (N.w i)

theorem Y1_skew (i j : Fin N.k) : Skew (Y1 N i j) := by
  unfold Skew Y1; rw [Matrix.transpose_sub, rot_skew, rot_skew]; abel
theorem Y2_skew (i j : Fin N.k) : Skew (Y2 N i j) := by
  unfold Skew Y2; rw [Matrix.transpose_add, rot_skew, rot_skew]; abel

variable {i j : Fin N.k} (hij : i ≠ j)
include hij

theorem uu_ne : N.u i ⬝ᵥ N.u j = 0 := by rw [N.uu, if_neg hij]
theorem uu_ne' : N.u j ⬝ᵥ N.u i = 0 := by rw [N.uu, if_neg (Ne.symm hij)]
theorem ww_ne : N.w i ⬝ᵥ N.w j = 0 := by rw [N.ww, if_neg hij]
theorem ww_ne' : N.w j ⬝ᵥ N.w i = 0 := by rw [N.ww, if_neg (Ne.symm hij)]

omit hij in
theorem uu_one (l : Fin N.k) : N.u l ⬝ᵥ N.u l = 1 := by rw [N.uu, if_pos rfl]
omit hij in
theorem ww_one (l : Fin N.k) : N.w l ⬝ᵥ N.w l = 1 := by rw [N.ww, if_pos rfl]

theorem Y1_ui : Y1 N i j *ᵥ N.u i = -N.u j := by
  unfold Y1; rw [Matrix.sub_mulVec, rot_mulVec, rot_mulVec, uu_ne' N hij, uu_one, wu N]; simp [wu N, N.uw]
theorem Y1_uj : Y1 N i j *ᵥ N.u j = N.u i := by
  unfold Y1; rw [Matrix.sub_mulVec, rot_mulVec, rot_mulVec, uu_ne N hij, uu_one, wu N]; simp [wu N, N.uw]
theorem Y1_wi : Y1 N i j *ᵥ N.w i = N.w j := by
  unfold Y1; rw [Matrix.sub_mulVec, rot_mulVec, rot_mulVec, ww_ne' N hij, ww_one, N.uw]; simp [wu N, N.uw]
theorem Y1_wj : Y1 N i j *ᵥ N.w j = -N.w i := by
  unfold Y1; rw [Matrix.sub_mulVec, rot_mulVec, rot_mulVec, ww_ne N hij, ww_one, N.uw]; simp [wu N, N.uw]
theorem Y2_ui : Y2 N i j *ᵥ N.u i = -N.w j := by
  unfold Y2; rw [Matrix.add_mulVec, rot_mulVec, rot_mulVec, uu_ne' N hij, uu_one, wu N]; simp [wu N, N.uw]
theorem Y2_uj : Y2 N i j *ᵥ N.u j = N.w i := by
  unfold Y2; rw [Matrix.add_mulVec, rot_mulVec, rot_mulVec, uu_ne N hij, uu_one, wu N]; simp [wu N, N.uw]
theorem Y2_wi : Y2 N i j *ᵥ N.w i = -N.u j := by
  unfold Y2; rw [Matrix.add_mulVec, rot_mulVec, rot_mulVec, ww_ne' N hij, ww_one, N.uw]; simp [wu N, N.uw]
theorem Y2_wj : Y2 N i j *ᵥ N.w j = N.u i := by
  unfold Y2; rw [Matrix.add_mulVec, rot_mulVec, rot_mulVec, ww_ne N hij, ww_one, N.uw]; simp [wu N, N.uw]

omit hij in
theorem Y1_K {z : Fin m → ℝ} (hz : InK N z) : Y1 N i j *ᵥ z = 0 := by
  unfold Y1; rw [Matrix.sub_mulVec, rot_mulVec, rot_mulVec, (hz i).1, (hz j).1, (hz i).2, (hz j).2]; simp
omit hij in
theorem Y2_K {z : Fin m → ℝ} (hz : InK N z) : Y2 N i j *ᵥ z = 0 := by
  unfold Y2; rw [Matrix.add_mulVec, rot_mulVec, rot_mulVec, (hz i).1, (hz j).1, (hz i).2, (hz j).2]; simp

end Exc


theorem co_matadd (A B : Matrix (Fin m) (Fin m) ℝ) (p q : Fin m → ℝ) : co (A + B) p q = co A p q + co B p q := by
  unfold co; rw [Matrix.add_mulVec, dotProduct_add]

section ExcCoords

variable {i j : Fin N.k} (hij : i ≠ j)
include hij

theorem coY1_ui (p : Fin m → ℝ) : co (Y1 N i j) p (N.u i) = -(p ⬝ᵥ N.u j) := by
  unfold co; rw [Y1_ui N hij, dotProduct_neg]
theorem coY1_uj (p : Fin m → ℝ) : co (Y1 N i j) p (N.u j) = p ⬝ᵥ N.u i := by
  unfold co; rw [Y1_uj N hij]
theorem coY1_wi (p : Fin m → ℝ) : co (Y1 N i j) p (N.w i) = p ⬝ᵥ N.w j := by
  unfold co; rw [Y1_wi N hij]
theorem coY1_wj (p : Fin m → ℝ) : co (Y1 N i j) p (N.w j) = -(p ⬝ᵥ N.w i) := by
  unfold co; rw [Y1_wj N hij, dotProduct_neg]
theorem coY2_ui (p : Fin m → ℝ) : co (Y2 N i j) p (N.u i) = -(p ⬝ᵥ N.w j) := by
  unfold co; rw [Y2_ui N hij, dotProduct_neg]
theorem coY2_uj (p : Fin m → ℝ) : co (Y2 N i j) p (N.u j) = p ⬝ᵥ N.w i := by
  unfold co; rw [Y2_uj N hij]
theorem coY2_wi (p : Fin m → ℝ) : co (Y2 N i j) p (N.w i) = -(p ⬝ᵥ N.u j) := by
  unfold co; rw [Y2_wi N hij, dotProduct_neg]
theorem coY2_wj (p : Fin m → ℝ) : co (Y2 N i j) p (N.w j) = p ⬝ᵥ N.u i := by
  unfold co; rw [Y2_wj N hij]

end ExcCoords


section ExcUpper

variable {y : Matrix (Fin m) (Fin m) ℝ} (hy : y ∈ zPerp x)
include hy

/-- **Equal singular values couple the two planes**: `y(u_j,u_l) = -y(w_j,w_l)` and
`y(u_j,w_l) = y(w_j,u_l)`. -/
theorem offdiag_eq {j l : Fin N.k} (hjl : j ≠ l) (heq : N.a j = N.a l) :
    co y (N.u j) (N.u l) = -co y (N.w j) (N.w l) ∧ co y (N.u j) (N.w l) = co y (N.w j) (N.u l) := by
  have hc := hcomm N hy (bb N j l) (bb_perp N j l)
  obtain ⟨e1, -, e3, -⟩ := torus_eqs N hc j l
  rw [bb_j N hjl, bb_l N hjl, ← heq] at e1 e3
  have ha := N.apos j
  constructor
  · have : N.a j * (co y (N.u j) (N.u l) + co y (N.w j) (N.w l)) = 0 := by linarith
    have := (mul_eq_zero.mp this).resolve_left ha.ne'; linarith
  · have : N.a j * (co y (N.w j) (N.u l) - co y (N.u j) (N.w l)) = 0 := by linarith
    have := (mul_eq_zero.mp this).resolve_left ha.ne'; linarith

end ExcUpper


theorem coY1_K (i j : Fin N.k) (p : Fin m → ℝ) {z : Fin m → ℝ} (hz : InK N z) : co (Y1 N i j) p z = 0 := by
  unfold co; rw [Y1_K N hz, dotProduct_zero]
theorem coY2_K (i j : Fin N.k) (p : Fin m → ℝ) {z : Fin m → ℝ} (hz : InK N z) : co (Y2 N i j) p z = 0 := by
  unfold co; rw [Y2_K N hz, dotProduct_zero]

section ExcUpper2

variable {y : Matrix (Fin m) (Fin m) ℝ} (hy : y ∈ zPerp x)
include hy

/-- **THE UPPER BOUND IN THE EXCEPTION**: with exactly two planes of equal singular value,
`y = s x + α Y₁ + γ Y₂`. -/
theorem upper_exc (hx : Skew x) {i j : Fin N.k} (hij : i ≠ j) (hall : ∀ l : Fin N.k, l = i ∨ l = j)
    (heq : N.a i = N.a j) : ∃ s α γ : ℝ, y = s • x + α • Y1 N i j + γ • Y2 N i j := by
  set α := co y (N.u i) (N.u j) with hα
  set γ := co y (N.u i) (N.w j) with hγ
  set s : ℝ := -(co y (N.u i) (N.w i) / N.a i) with hs_def
  have ha := N.apos i
  have hs : s * N.a i = -co y (N.u i) (N.w i) := by rw [hs_def]; field_simp
  have hs' : s * N.a j = -co y (N.u i) (N.w i) := by rw [← heq]; exact hs
  have hcj : co y (N.u j) (N.w j) = co y (N.u i) (N.w i) := by
    have := diag_prop N hy j i
    rw [← heq] at this
    exact (mul_left_cancel₀ ha.ne' this)
  obtain ⟨hβ, hδ⟩ := offdiag_eq N hy hij heq
  have sk := co_skew hy.1
  have s1 := sk (N.u i) (N.u j); have s2 := sk (N.w i) (N.w j); have s3 := sk (N.w i) (N.u j)
  have s4 := sk (N.u i) (N.w j); have s5 := sk (N.u i) (N.w i); have s6 := sk (N.u j) (N.w j)
  have z1 := co_self hy.1 (N.u i); have z2 := co_self hy.1 (N.u j)
  have z3 := co_self hy.1 (N.w i); have z4 := co_self hy.1 (N.w j)
  refine ⟨s, α, γ, ?_⟩
  suffices h : y - (s • x + α • Y1 N i j + γ • Y2 N i j) = 0 from sub_eq_zero.mp h
  apply recon N
  · intro p l
    rcases hall p with rfl | rfl <;> rcases hall l with rfl | rfl <;>
    simp only [co_matsub, co_matadd, co_matsmul, coY1_ui N hij, coY1_uj N hij, coY1_wi N hij,
      coY1_wj N hij, coY2_ui N hij, coY2_uj N hij, coY2_wi N hij, coY2_wj N hij, co_x_uu, co_x_ww, co_x_uw,
      co_x_wu, uu_one, ww_one, uu_ne N hij, uu_ne' N hij, ww_ne N hij, ww_ne' N hij, N.uw, wu N, if_pos,
      if_neg hij, if_neg (Ne.symm hij), mul_zero, mul_one, neg_zero, mul_neg, heq] <;>
    refine ⟨?_, ?_, ?_, ?_⟩ <;> linarith
  · intro l z hz
    have hK : co y (N.u l) z = 0 ∧ co y (N.w l) z = 0 := by
      rcases hall l with rfl | rfl
      · exact kernel_two N hy hij hz
      · exact kernel_two N hy (Ne.symm hij) hz
    simp only [co_matsub, co_matadd, co_matsmul, co_x_K_r N _ hz, coY1_K N _ _ _ hz, coY2_K N _ _ _ hz,
      hK.1, hK.2, mul_zero, add_zero, sub_zero, and_self]
  · intro l z hz
    have hK : co y (N.u l) z = 0 ∧ co y (N.w l) z = 0 := by
      rcases hall l with rfl | rfl
      · exact kernel_two N hy hij hz
      · exact kernel_two N hy (Ne.symm hij) hz
    have hd : Skew (y - (s • x + α • Y1 N i j + γ • Y2 N i j)) := by
      have h1 := hy.1; have h2 := Y1_skew N i j; have h3 := Y2_skew N i j
      unfold Skew at *
      simp only [Matrix.transpose_sub, Matrix.transpose_add, Matrix.transpose_smul, h1, hx, h2, h3, smul_neg]
      abel
    rw [co_skew hd (N.u l) z, co_skew hd (N.w l) z]
    simp only [co_matsub, co_matadd, co_matsmul, co_x_K_r N _ hz, coY1_K N _ _ _ hz, coY2_K N _ _ _ hz,
      hK.1, hK.2, mul_zero, add_zero, sub_zero, neg_zero, and_self]
  · intro z z' hz hz'
    simp only [co_matsub, co_matadd, co_matsmul, co_x_K_r N _ hz', coY1_K N _ _ _ hz', coY2_K N _ _ _ hz',
      kernel_kernel N hy hx hz hz', mul_zero, add_zero, sub_zero]

end ExcUpper2


theorem co_neg_l (M : Matrix (Fin m) (Fin m) ℝ) (p q : Fin m → ℝ) : co M (-p) q = -co M p q := by
  unfold co; rw [neg_dotProduct]
theorem co_neg_r (M : Matrix (Fin m) (Fin m) ℝ) (p q : Fin m → ℝ) : co M p (-q) = -co M p q := by
  unfold co; rw [Matrix.mulVec_neg, dotProduct_neg]
theorem co_zero_l (M : Matrix (Fin m) (Fin m) ℝ) (q : Fin m → ℝ) : co M 0 q = 0 := by
  unfold co; rw [zero_dotProduct]
theorem co_zero_r (M : Matrix (Fin m) (Fin m) ℝ) (p : Fin m → ℝ) : co M p 0 = 0 := by
  unfold co; rw [Matrix.mulVec_zero, dotProduct_zero]

/-- Entries of a bracket with a skew matrix. -/
theorem co_brY {A : Matrix (Fin m) (Fin m) ℝ} (hA : Skew A) (B : Matrix (Fin m) (Fin m) ℝ) (p q : Fin m → ℝ) :
    co (br A B) p q = -co B (A *ᵥ p) q - co B p (A *ᵥ q) := by
  rw [co_br, dot_skew' hA]; unfold co; ring

theorem inner2_comm' (X Y : Matrix (Fin m) (Fin m) ℝ) : inner2 X Y = inner2 Y X := by
  unfold inner2; rw [← Matrix.trace_transpose, Matrix.transpose_mul, Matrix.transpose_transpose]

theorem inner2_sub_right' (X A B : Matrix (Fin m) (Fin m) ℝ) : inner2 X (A - B) = inner2 X A - inner2 X B := by
  unfold inner2; rw [Matrix.mul_sub, Matrix.trace_sub]; ring
theorem inner2_add_right' (X A B : Matrix (Fin m) (Fin m) ℝ) : inner2 X (A + B) = inner2 X A + inner2 X B := by
  unfold inner2; rw [Matrix.mul_add, Matrix.trace_add]; ring

section ExcLower

variable (hx : Skew x) {i j : Fin N.k} (hij : i ≠ j) (hall : ∀ l : Fin N.k, l = i ∨ l = j)
  (heq : N.a i = N.a j)
include hx hij hall heq

theorem sum_two (f : Fin N.k → ℝ) : ∑ l, f l = f i + f j := by
  have : (Finset.univ : Finset (Fin N.k)) = {i, j} := by
    ext l; simp only [Finset.mem_univ, Finset.mem_insert, Finset.mem_singleton, true_iff]; exact hall l
  rw [this, Finset.sum_pair hij]

/-- **What membership in `𝔠` says about `w` in the exception.** -/
theorem c_rel {w : Matrix (Fin m) (Fin m) ℝ} (hw : w ∈ cc x) :
    co w (N.u i) (N.u j) = co w (N.w i) (N.w j) ∧ co w (N.u i) (N.w j) = -co w (N.w i) (N.u j) ∧
    co w (N.u i) (N.w i) + co w (N.u j) (N.w j) = 0 ∧
    (∀ l z, InK N z → co w (N.u l) z = 0 ∧ co w (N.w l) z = 0) := by
  have hbx : br w x = 0 := by
    have := hw.2.2; unfold br at *; rw [← neg_sub, this, neg_zero]
  have hwT : br w (T N N.a) = 0 := by rw [← x_eq_T N]; exact hbx
  obtain ⟨e1, -, e3, -⟩ := torus_eqs N hwT i j
  rw [← heq] at e1 e3
  have ha := N.apos i
  refine ⟨?_, ?_, ?_, ?_⟩
  · have : N.a i * (co w (N.w i) (N.w j) - co w (N.u i) (N.u j)) = 0 := by linarith
    have := (mul_eq_zero.mp this).resolve_left ha.ne'; linarith
  · have : N.a i * (co w (N.u i) (N.w j) + co w (N.w i) (N.u j)) = 0 := by linarith
    have := (mul_eq_zero.mp this).resolve_left ha.ne'; linarith
  · have h : inner2 w (T N N.a) = 0 := by rw [← x_eq_T N, inner2_comm']; exact hw.2.1
    rw [inner2_T N hw.1, sum_two N hx hij hall heq, ← heq] at h
    have : N.a i * (co w (N.u i) (N.w i) + co w (N.u j) (N.w j)) = 0 := by linarith
    exact (mul_eq_zero.mp this).resolve_left ha.ne'
  · intro l z hz
    obtain ⟨h1, h2⟩ := torus_K N hwT l hz
    have hl := N.apos l
    exact ⟨(mul_eq_zero.mp h2).resolve_left hl.ne', (mul_eq_zero.mp h1).resolve_left hl.ne'⟩

end ExcLower


section ExcMem

variable (hx : Skew x) {i j : Fin N.k} (hij : i ≠ j) (hall : ∀ l : Fin N.k, l = i ∨ l = j)
  (heq : N.a i = N.a j)
include hx hij hall heq

/-- **`Y₁ ∈ 𝔷(𝔠) ∩ 𝔠^⊥` in the exception.** -/
theorem Y1_mem : Y1 N i j ∈ zPerp x := by
  refine ⟨Y1_skew N i j, fun w hw => ?_, fun w hw => ?_⟩
  · obtain ⟨r1, r2, r3, r4⟩ := c_rel N hx hij hall heq hw
    have sk := co_skew hw.1
    have a1 := sk (N.u i) (N.u j); have a2 := sk (N.w i) (N.w j); have a3 := sk (N.u i) (N.w j)
    have a4 := sk (N.w i) (N.u j); have a5 := sk (N.u i) (N.w i); have a6 := sk (N.u j) (N.w j)
    have z1 := co_self hw.1 (N.u i); have z2 := co_self hw.1 (N.u j)
    have z3 := co_self hw.1 (N.w i); have z4 := co_self hw.1 (N.w j)
    apply recon N
    · intro p l
      rcases hall p with rfl | rfl <;> rcases hall l with rfl | rfl <;>
      simp only [co_brY (Y1_skew N _ _), Y1_ui N hij, Y1_uj N hij, Y1_wi N hij, Y1_wj N hij, co_neg_l,
        co_neg_r] <;>
      refine ⟨?_, ?_, ?_, ?_⟩ <;> linarith
    · intro l z hz
      have hz0 := Y1_K N (i := i) (j := j) hz
      rcases hall l with h | h <;> rw [h] <;>
      simp only [co_brY (Y1_skew N _ _), Y1_ui N hij, Y1_uj N hij, Y1_wi N hij, Y1_wj N hij, hz0, co_neg_l,
        co_zero_r, (r4 _ z hz).1, (r4 _ z hz).2, (r4 j z hz).1, (r4 j z hz).2, neg_zero, sub_zero, and_self]
    · intro l z hz
      have hz0 := Y1_K N (i := i) (j := j) hz
      have k1 := sk (N.u i) z; have k2 := sk (N.w i) z; have k3 := sk (N.u j) z; have k4 := sk (N.w j) z
      rcases hall l with h | h <;> rw [h] <;>
      simp only [co_brY (Y1_skew N _ _), Y1_ui N hij, Y1_uj N hij, Y1_wi N hij, Y1_wj N hij, hz0, co_neg_r,
        co_zero_l, k1, k2, k3, k4, (r4 _ z hz).1, (r4 _ z hz).2, (r4 j z hz).1, (r4 j z hz).2, neg_zero,
        sub_zero, and_self]
    · intro z z' hz hz'
      rw [co_brY (Y1_skew N _ _), Y1_K N hz, Y1_K N hz', co_zero_l, co_zero_r]; ring
  · have h := hw.1
    rw [inner2_comm', Y1, inner2_sub_right', inner2_rot h, inner2_rot h]
    obtain ⟨r1, -, -, -⟩ := c_rel N hx hij hall heq hw
    have a1 := co_skew h (N.u i) (N.u j); have a2 := co_skew h (N.w i) (N.w j)
    linarith

/-- **`Y₂ ∈ 𝔷(𝔠) ∩ 𝔠^⊥` in the exception.** -/
theorem Y2_mem : Y2 N i j ∈ zPerp x := by
  refine ⟨Y2_skew N i j, fun w hw => ?_, fun w hw => ?_⟩
  · obtain ⟨r1, r2, r3, r4⟩ := c_rel N hx hij hall heq hw
    have sk := co_skew hw.1
    have a1 := sk (N.u i) (N.u j); have a2 := sk (N.w i) (N.w j); have a3 := sk (N.u i) (N.w j)
    have a4 := sk (N.w i) (N.u j); have a5 := sk (N.u i) (N.w i); have a6 := sk (N.u j) (N.w j)
    have z1 := co_self hw.1 (N.u i); have z2 := co_self hw.1 (N.u j)
    have z3 := co_self hw.1 (N.w i); have z4 := co_self hw.1 (N.w j)
    apply recon N
    · intro p l
      rcases hall p with rfl | rfl <;> rcases hall l with rfl | rfl <;>
      simp only [co_brY (Y2_skew N _ _), Y2_ui N hij, Y2_uj N hij, Y2_wi N hij, Y2_wj N hij, co_neg_l,
        co_neg_r] <;>
      refine ⟨?_, ?_, ?_, ?_⟩ <;> linarith
    · intro l z hz
      have hz0 := Y2_K N (i := i) (j := j) hz
      rcases hall l with h | h <;> rw [h] <;>
      simp only [co_brY (Y2_skew N _ _), Y2_ui N hij, Y2_uj N hij, Y2_wi N hij, Y2_wj N hij, hz0, co_neg_l,
        co_zero_r, (r4 _ z hz).1, (r4 _ z hz).2, (r4 j z hz).1, (r4 j z hz).2, neg_zero, sub_zero, and_self]
    · intro l z hz
      have hz0 := Y2_K N (i := i) (j := j) hz
      have k1 := sk (N.u i) z; have k2 := sk (N.w i) z; have k3 := sk (N.u j) z; have k4 := sk (N.w j) z
      rcases hall l with h | h <;> rw [h] <;>
      simp only [co_brY (Y2_skew N _ _), Y2_ui N hij, Y2_uj N hij, Y2_wi N hij, Y2_wj N hij, hz0, co_neg_r,
        co_zero_l, k1, k2, k3, k4, (r4 _ z hz).1, (r4 _ z hz).2, (r4 j z hz).1, (r4 j z hz).2, neg_zero,
        sub_zero, and_self]
    · intro z z' hz hz'
      rw [co_brY (Y2_skew N _ _), Y2_K N hz, Y2_K N hz', co_zero_l, co_zero_r]; ring
  · have h := hw.1
    rw [inner2_comm', Y2, inner2_add_right', inner2_rot h, inner2_rot h]
    obtain ⟨-, r2, -, -⟩ := c_rel N hx hij hall heq hw
    have a3 := co_skew h (N.u i) (N.w j); have a4 := co_skew h (N.w i) (N.u j)
    linarith

end ExcMem


/-! ## Rank and cube of a torus element -/

/-- Nonzero pairwise orthogonal vectors are linearly independent. -/
theorem orth_li {ι : Type*} [Fintype ι] (vs : ι → Fin m → ℝ) (hne : ∀ i, vs i ≠ 0)
    (horth : ∀ i j, i ≠ j → vs i ⬝ᵥ vs j = 0) : LinearIndependent ℝ vs := by
  rw [Fintype.linearIndependent_iff]
  intro g hg i
  have := congrArg (fun v => vs i ⬝ᵥ v) hg
  simp only [dotProduct_sum, dotProduct_smul, smul_eq_mul, dotProduct_zero] at this
  rw [Finset.sum_eq_single i (fun j _ hj => by rw [horth i j (Ne.symm hj), mul_zero]) (by simp)] at this
  rcases mul_eq_zero.mp this with h | h
  · exact h
  · exact absurd (dotProduct_self_eq_zero.mp h) (hne i)

/-- The plane vectors as one family. -/
def V : Fin N.k ⊕ Fin N.k → Fin m → ℝ := Sum.elim N.u N.w

theorem V_li : LinearIndependent ℝ (V N) := by
  refine orth_li _ (fun s => ?_) (fun s t hst => ?_)
  · rcases s with l | l
    · intro h; have := N.uu l l; simp only [V, Sum.elim_inl] at h; simp [h] at this
    · intro h; have := N.ww l l; simp only [V, Sum.elim_inr] at h; simp [h] at this
  · rcases s with l | l <;> rcases t with l' | l'
    · simp only [V, Sum.elim_inl]; rw [N.uu, if_neg (fun h => hst (by rw [h]))]
    · simp only [V, Sum.elim_inl, Sum.elim_inr]; exact N.uw l l'
    · simp only [V, Sum.elim_inl, Sum.elim_inr]; exact wu N l l'
    · simp only [V, Sum.elim_inr]; rw [N.ww, if_neg (fun h => hst (by rw [h]))]

/-- **A torus element with nonzero coefficients has rank `2k`**: its image is the span of the planes. -/
theorem rank_T (b : Fin N.k → ℝ) (hb : ∀ l, b l ≠ 0) : (T N b).rank = 2 * N.k := by
  unfold Matrix.rank
  have hr : LinearMap.range (Matrix.mulVecLin (T N b)) = Submodule.span ℝ (Set.range (V N)) := by
    apply le_antisymm
    · rintro _ ⟨q, rfl⟩
      simp only [Matrix.mulVecLin_apply, T, Matrix.sum_mulVec, Matrix.smul_mulVec, R_mulVec]
      refine Submodule.sum_mem _ fun l _ => Submodule.smul_mem _ _ (Submodule.sub_mem _
        (Submodule.smul_mem _ _ (Submodule.subset_span ⟨Sum.inr l, rfl⟩))
        (Submodule.smul_mem _ _ (Submodule.subset_span ⟨Sum.inl l, rfl⟩)))
    · rw [Submodule.span_le]
      rintro _ ⟨s, rfl⟩
      rcases s with l | l
      · refine ⟨(-(b l)⁻¹) • N.w l, ?_⟩
        simp only [Matrix.mulVecLin_apply, Matrix.mulVec_neg, Matrix.mulVec_smul, T_w, V, Sum.elim_inl, smul_neg, neg_smul, neg_neg,
          smul_smul, inv_mul_cancel₀ (hb l), one_smul]
      · refine ⟨(b l)⁻¹ • N.u l, ?_⟩
        simp only [Matrix.mulVecLin_apply, Matrix.mulVec_smul, T_u, V, Sum.elim_inr, smul_smul,
          inv_mul_cancel₀ (hb l), one_smul]
  rw [hr, finrank_span_eq_card (V_li N)]
  simp [two_mul]

/-- **The cube of a torus element**: `(Σ b_l R_l)³ = -Σ b_l³ R_l`. -/
theorem T_cube (b : Fin N.k → ℝ) : T N b * T N b * T N b = -T N (fun l => b l ^ 3) := by
  apply Matrix.toLin'.injective
  refine LinearMap.ext fun q => ?_
  simp only [Matrix.toLin'_apply, ← Matrix.mulVec_mulVec, Matrix.neg_mulVec]
  have hT : ∀ (c : Fin N.k → ℝ) (v : Fin m → ℝ),
      T N c *ᵥ v = ∑ l, ((c l * (N.u l ⬝ᵥ v)) • N.w l - (c l * (N.w l ⬝ᵥ v)) • N.u l) := by
    intro c v
    simp only [T, Matrix.sum_mulVec, Matrix.smul_mulVec, R_mulVec]
    exact Finset.sum_congr rfl fun l _ => by rw [smul_sub, smul_smul, smul_smul]
  have h2 : T N b *ᵥ (T N b *ᵥ q) = ∑ l, ((-(b l ^ 2 * (N.u l ⬝ᵥ q))) • N.u l + (-(b l ^ 2 * (N.w l ⬝ᵥ q))) • N.w l) := by
    rw [hT b q, Matrix.mulVec_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [Matrix.mulVec_sub, Matrix.mulVec_smul, Matrix.mulVec_smul, T_u, T_w]
    module
  have h3 : T N b *ᵥ (T N b *ᵥ (T N b *ᵥ q)) = ∑ l, ((-(b l ^ 3 * (N.u l ⬝ᵥ q))) • N.w l - (-(b l ^ 3 * (N.w l ⬝ᵥ q))) • N.u l) := by
    rw [h2, Matrix.mulVec_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [Matrix.mulVec_add, Matrix.mulVec_smul, Matrix.mulVec_smul, T_u, T_w]
    module
  rw [h3, hT, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun l _ => ?_
  module

/-- The diagonal entry reads off a torus coefficient. -/
theorem co_T_uw (d : Fin N.k → ℝ) (l : Fin N.k) : co (T N d) (N.u l) (N.w l) = -d l := by
  unfold co; rw [T_w, dotProduct_neg, dotProduct_smul, uu_one, smul_eq_mul, mul_one]


theorem co_neg_mat (M : Matrix (Fin m) (Fin m) ℝ) (p q : Fin m → ℝ) : co (-M) p q = -co M p q := by
  unfold co; rw [Matrix.neg_mulVec, dotProduct_neg]

theorem T_smul (c : ℝ) (b : Fin N.k → ℝ) : T N (fun l => c * b l) = c • T N b := by
  unfold T; rw [Finset.smul_sum]; exact Finset.sum_congr rfl fun l _ => by rw [smul_smul]

theorem T_const (hk2 : N.k = 2) (heq : ∀ i j, N.a i = N.a j) (i0 : Fin N.k) :
    x = N.a i0 • T N (fun _ => 1) := by
  have h : T N N.a = N.a i0 • T N (fun _ => 1) := by
    rw [← T_smul]; congr 1; funext l; rw [mul_one, heq l i0]
  rw [← x_eq_T N] at h; exact h

theorem co_matsum {κ : Type*} (s : Finset κ) (f : κ → Matrix (Fin m) (Fin m) ℝ) (p q : Fin m → ℝ) :
    co (∑ t ∈ s, f t) p q = ∑ t ∈ s, co (f t) p q := by
  unfold co; rw [Matrix.sum_mulVec, dotProduct_sum]

/-- **The exception is exactly a multiple of a rank-`4` complex structure.** -/
theorem mult_iff (hx : Skew x) :
    MultipleOfRankFour x ↔ (N.k = 2 ∧ ∀ i j, N.a i = N.a j) := by
  constructor
  · rintro ⟨c, J, hc, ⟨hJs, hJ3, hJr⟩, hxJ⟩
    have hrx : x.rank = 2 * N.k := by
      have := rank_T N N.a (fun l => (N.apos l).ne'); rwa [← x_eq_T N] at this
    have hrJ : x.rank = 4 := by
      rw [hxJ, Matrix.rank_smul_of_mem_nonZeroDivisors _ (mem_nonZeroDivisors_of_ne_zero hc), hJr]
    have hk2 : N.k = 2 := by omega
    refine ⟨hk2, ?_⟩
    have hx3 : T N N.a * T N N.a * T N N.a = (-(c ^ 2)) • T N N.a := by
      rw [← x_eq_T N, hxJ]
      simp only [Matrix.smul_mul, Matrix.mul_smul, smul_smul, hJ3, smul_neg]
      rw [← neg_smul]; congr 1; ring
    rw [T_cube] at hx3
    have hsq : ∀ l, N.a l ^ 2 = c ^ 2 := by
      intro l
      have := congrArg (fun M => co M (N.u l) (N.w l)) hx3
      simp only [co_neg_mat, co_matsmul, co_T_uw] at this
      have ha := N.apos l
      have : N.a l * (N.a l ^ 2 - c ^ 2) = 0 := by linear_combination this
      have := (mul_eq_zero.mp this).resolve_left ha.ne'; linarith
    intro i j
    have h := (hsq i).trans (hsq j).symm
    have hi := N.apos i; have hj := N.apos j
    nlinarith [sq_nonneg (N.a i - N.a j), sq_nonneg (N.a i + N.a j)]
  · rintro ⟨hk2, heq⟩
    set i0 : Fin N.k := ⟨0, by omega⟩
    refine ⟨N.a i0, T N (fun _ => 1), (N.apos i0).ne', ⟨T_skew N _, ?_, ?_⟩, T_const N hk2 heq i0⟩
    · rw [T_cube]; congr 2; funext l; ring
    · rw [rank_T N _ (fun _ => one_ne_zero), hk2]

end HamiltonsCubic.SkewCentraliser
