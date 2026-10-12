import HamiltonsCubic.Results.L225Matrix

set_option linter.style.longLine false

/-!
# L225's equality case as a matrix identity

[second-order.md](../../../findings/second-order.md), Lemma L225: *"with equality exactly when
`M⁰ = |M⁰|(k/c uuᵀ - I/c)` for a unit vector `u`."* [L225Matrix.lean](L225Matrix.lean) proves the equality case in
eigenvalue form (`matrix_cube_eq`). This file reads it as the matrix identity:

* **`sym_spectral_gen`**: a symmetric `M` is `Oᵀ diag(λ) O` with `O` orthogonal, at every finite index;
* **`eq_identity`**: at `tr M = 0`, `tr M² = 1` and `tr M³ = (k-2)/c`, `M = (k/c) uuᵀ - (1/c) I` with `u` unit;
* **`identity_attains`**: conversely every such `M` is trace-free of unit norm with `tr M³ = (k-2)/c`;
* **`eq_iff_identity`**: the two together, the normalised equality case as an equivalence;
* **`eq_iff_identity_unnormalised`**: the record's form, `tr M³ = (k-2)/c · |M|³` exactly when
  `M = |M| ((k/c) uuᵀ - (1/c) I)` with `u` unit, `M = 0` included;
* **`exists_orth_to_single`**, **`k3_clause`**: a Householder reflection carries a unit `u` to `e₀`, so at `k = 3`
  equality holds exactly at the nonnegative multiples of `diag(2, -1, -1)` in some orthonormal frame.
-/

namespace HamiltonsCubic.L225Statement

open Finset Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The spectral theorem, real form**: `M = Oᵀ diag(λ) O` with `OᵀO = 1`. -/
theorem sym_spectral_gen {M : Matrix ι ι ℝ} (hH : M.IsHermitian) :
    ∃ O : Matrix ι ι ℝ, Oᵀ * O = 1 ∧ M = Oᵀ * Matrix.diagonal hH.eigenvalues * O := by
  set U : Matrix ι ι ℝ := (hH.eigenvectorUnitary : Matrix ι ι ℝ)
  have hU1 : U * star U = 1 := Unitary.mul_star_self_of_mem hH.eigenvectorUnitary.2
  have hst : star U = Uᵀ := by rw [Matrix.star_eq_conjTranspose, Matrix.conjTranspose_eq_transpose_of_trivial]
  refine ⟨Uᵀ, ?_, ?_⟩
  · rw [Matrix.transpose_transpose, ← hst, hU1]
  · conv_lhs => rw [hH.spectral_theorem]
    rw [Unitary.conjStarAlgAut_apply, Matrix.transpose_transpose, hst]
    congr 2

/-- **The normalised equality case as a matrix identity.** -/
theorem eq_identity (M : Matrix ι ι ℝ) (hM : M.IsHermitian) (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (hk : 2 ≤ Fintype.card ι)
    (h1 : M.trace = 0) (h2 : (M ^ 2).trace = 1) (heq : (M ^ 3).trace = ((Fintype.card ι : ℝ) - 2) / c) :
    ∃ u : ι → ℝ, ∑ j, u j ^ 2 = 1 ∧
      M = ((Fintype.card ι : ℝ) / c) • Matrix.vecMulVec u u - (1 / c) • (1 : Matrix ι ι ℝ) := by
  obtain ⟨hvals, hcard⟩ := matrix_cube_eq M hM c hc0 hc hk h1 h2 heq
  obtain ⟨i₀, hi₀⟩ := Finset.card_eq_one.mp hcard
  have hmem : ∀ i, hM.eigenvalues i = ((Fintype.card ι : ℝ) - 1) / c ↔ i = i₀ := fun i => by
    have := congrArg (i ∈ ·) hi₀
    simpa using this
  have hval : ∀ i, hM.eigenvalues i = -1 / c + (if i = i₀ then (Fintype.card ι : ℝ) / c else 0) := fun i => by
    by_cases h : i = i₀
    · rw [if_pos h, (hmem i).mpr h]; field_simp; ring
    · rw [if_neg h, add_zero]
      rcases hvals i with h' | h'
      · exact absurd ((hmem i).mp h') h
      · exact h'
  obtain ⟨O, hO, hMO⟩ := sym_spectral_gen hM
  have hO' : O * Oᵀ = 1 := mul_eq_one_comm.mp hO
  refine ⟨fun j => O i₀ j, ?_, ?_⟩
  · have := congrFun (congrFun hO' i₀) i₀
    simpa [Matrix.mul_apply, Matrix.transpose_apply, sq] using this
  · have hD : Matrix.diagonal hM.eigenvalues = (-1 / c) • (1 : Matrix ι ι ℝ)
        + ((Fintype.card ι : ℝ) / c) • Matrix.diagonal (Pi.single i₀ 1) := by
      ext a b
      simp only [Matrix.diagonal_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.one_apply, smul_eq_mul]
      by_cases hab : a = b
      · subst hab; rw [if_pos rfl, if_pos rfl, if_pos rfl, hval a]
        by_cases ha : a = i₀
        · subst ha; simp
        · simp [ha]
      · simp [hab]
    have hE : Oᵀ * Matrix.diagonal (Pi.single i₀ (1 : ℝ)) * O = Matrix.vecMulVec (fun j => O i₀ j) (fun j => O i₀ j) := by
      ext a b
      rw [Matrix.mul_apply]
      simp only [Matrix.mul_diagonal, Matrix.transpose_apply, Matrix.vecMulVec_apply]
      rw [Finset.sum_eq_single i₀]
      · simp
      · intro i _ hi; simp [hi]
      · simp
    rw [hMO, hD, Matrix.mul_add, Matrix.add_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_one, hO,
      Matrix.mul_smul, Matrix.smul_mul, hE]
    rw [show (-1 / c : ℝ) = -(1 / c) by ring, neg_smul]; abel

/-- **Conversely**, `(k/c) uuᵀ - (1/c) I` with `u` unit is trace-free, of unit norm, with `tr M³ = (k-2)/c`. -/
theorem identity_attains (c : ℝ) (hc0 : 0 < c) (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1))
    (u : ι → ℝ) (hu : ∑ j, u j ^ 2 = 1) :
    let M := ((Fintype.card ι : ℝ) / c) • Matrix.vecMulVec u u - (1 / c) • (1 : Matrix ι ι ℝ)
    M.trace = 0 ∧ (M ^ 2).trace = 1 ∧ (M ^ 3).trace = ((Fintype.card ι : ℝ) - 2) / c := by
  intro M
  set P : Matrix ι ι ℝ := Matrix.vecMulVec u u with hP
  have hPP : P * P = P := by
    ext a b
    simp only [hP, Matrix.mul_apply, Matrix.vecMulVec_apply]
    have : ∑ x, u a * u x * (u x * u b) = u a * u b * ∑ x, u x ^ 2 := by
      rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun x _ => by ring
    rw [this, hu, mul_one]
  have htrP : P.trace = 1 := by
    simp only [hP, Matrix.trace, Matrix.diag, Matrix.vecMulVec_apply]
    rw [← hu]; exact Finset.sum_congr rfl fun x _ => by ring
  have htr1 : (1 : Matrix ι ι ℝ).trace = (Fintype.card ι : ℝ) := by simp
  have hMd : M = ((Fintype.card ι : ℝ) / c) • P - (1 / c) • (1 : Matrix ι ι ℝ) := rfl
  have hM2 : M ^ 2 = ((Fintype.card ι : ℝ) / c) ^ 2 • P - (2 * ((Fintype.card ι : ℝ) / c) * (1 / c)) • P + (1 / c) ^ 2 • (1 : Matrix ι ι ℝ) := by
    rw [hMd]
    simp only [sq, sub_mul, mul_sub, Matrix.smul_mul, Matrix.mul_smul, hPP, Matrix.mul_one, Matrix.one_mul,
      smul_smul]
    module
  have hM3 : M ^ 3 = (((Fintype.card ι : ℝ) / c) ^ 3 - 3 * ((Fintype.card ι : ℝ) / c) ^ 2 * (1 / c) + 3 * ((Fintype.card ι : ℝ) / c) * (1 / c) ^ 2) • P
      - (1 / c) ^ 3 • (1 : Matrix ι ι ℝ) := by
    rw [pow_succ, hM2, hMd]
    simp only [sub_mul, mul_sub, add_mul, Matrix.smul_mul, Matrix.mul_smul, hPP, Matrix.mul_one, Matrix.one_mul,
      smul_smul]
    module
  have hk1 : (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1) = c ^ 2 := hc.symm
  refine ⟨?_, ?_, ?_⟩
  · rw [hMd]; simp only [Matrix.trace_sub, Matrix.trace_smul, htrP, htr1, smul_eq_mul]; field_simp; ring
  · rw [hM2]; simp only [Matrix.trace_add, Matrix.trace_sub, Matrix.trace_smul, htrP, htr1, smul_eq_mul]
    field_simp; nlinarith [hk1]
  · rw [hM3]; simp only [Matrix.trace_sub, Matrix.trace_smul, htrP, htr1, smul_eq_mul]
    field_simp; nlinarith [hk1]

/-- **The normalised equality case, as an equivalence.** -/
theorem eq_iff_identity (M : Matrix ι ι ℝ) (hM : M.IsHermitian) (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (hk : 2 ≤ Fintype.card ι)
    (h1 : M.trace = 0) (h2 : (M ^ 2).trace = 1) :
    (M ^ 3).trace = ((Fintype.card ι : ℝ) - 2) / c ↔
      ∃ u : ι → ℝ, ∑ j, u j ^ 2 = 1 ∧
        M = ((Fintype.card ι : ℝ) / c) • Matrix.vecMulVec u u - (1 / c) • (1 : Matrix ι ι ℝ) := by
  refine ⟨eq_identity M hM c hc0 hc hk h1 h2, ?_⟩
  rintro ⟨u, hu, rfl⟩
  exact (identity_attains c hc0 hc u hu).2.2

/-- A symmetric matrix with `tr M² = 0` is zero. -/
theorem eq_zero_of_trace_sq {M : Matrix ι ι ℝ} (hM : M.IsHermitian) (h : (M ^ 2).trace = 0) : M = 0 := by
  have hs : ∀ i j, M j i = M i j := fun i j => by
    have := congrFun (congrFun hM i) j
    simpa [Matrix.conjTranspose_apply] using this
  have e : (M ^ 2).trace = ∑ i, ∑ j, M i j ^ 2 := by
    simp only [sq, Matrix.trace, Matrix.diag, Matrix.mul_apply]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [hs j i]
  rw [e] at h
  ext i j
  have hij := (Finset.sum_eq_zero_iff_of_nonneg (fun a _ => Finset.sum_nonneg fun b _ => sq_nonneg (M a b))).mp h i
    (Finset.mem_univ i)
  have := (Finset.sum_eq_zero_iff_of_nonneg (fun b _ => sq_nonneg (M i b))).mp hij j (Finset.mem_univ j)
  simpa using this

/-- **The unnormalised equality case**: at a trace-free symmetric `M`, `tr M³ = (k-2)/c · |M|³` exactly when
`M = |M| ((k/c) uuᵀ - (1/c) I)` for a unit `u`, with `|M| = √(tr M²)`. -/
theorem eq_iff_identity_unnormalised (M : Matrix ι ι ℝ) (hM : M.IsHermitian) (c : ℝ) (hc0 : 0 < c)
    (hc : c ^ 2 = (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1)) (hk : 2 ≤ Fintype.card ι) (h1 : M.trace = 0) :
    (M ^ 3).trace = ((Fintype.card ι : ℝ) - 2) / c * Real.sqrt ((M ^ 2).trace) ^ 3 ↔
      ∃ u : ι → ℝ, ∑ j, u j ^ 2 = 1 ∧ M = Real.sqrt ((M ^ 2).trace) •
        (((Fintype.card ι : ℝ) / c) • Matrix.vecMulVec u u - (1 / c) • (1 : Matrix ι ι ℝ)) := by
  have hne : Nonempty ι := Fintype.card_pos_iff.mp (by omega)
  obtain ⟨i₁⟩ := hne
  have hN : 0 ≤ (M ^ 2).trace := by
    rw [HamiltonsCubic.SecondKind.trace_pow_eq_sum_eigenvalues M hM 2]
    exact Finset.sum_nonneg fun i _ => by positivity
  rcases eq_or_lt_of_le hN with h0 | hpos
  · -- `M = 0`: both sides hold
    have hM0 := eq_zero_of_trace_sq hM h0.symm
    subst hM0
    refine ⟨fun _ => ⟨Pi.single i₁ 1, by simp [Pi.single_apply], by rw [← h0, Real.sqrt_zero, zero_smul]⟩,
      fun _ => by simp⟩
  · set s := Real.sqrt ((M ^ 2).trace) with hsdef
    have hs : 0 < s := Real.sqrt_pos.mpr hpos
    set N := s⁻¹ • M with hNdef
    have hNH : N.IsHermitian := by
      rw [hNdef, Matrix.IsHermitian, Matrix.conjTranspose_smul, hM.eq, star_trivial]
    have hN1 : N.trace = 0 := by rw [hNdef, Matrix.trace_smul, h1, smul_zero]
    have hN2 : (N ^ 2).trace = 1 := by
      rw [hNdef, smul_pow, Matrix.trace_smul, smul_eq_mul, inv_pow, ← Real.sq_sqrt hN, ← hsdef]
      field_simp
    have hN3 : (N ^ 3).trace = s⁻¹ ^ 3 * (M ^ 3).trace := by
      rw [hNdef, smul_pow, Matrix.trace_smul, smul_eq_mul]
    have hMN : M = s • N := by rw [hNdef, smul_smul, mul_inv_cancel₀ hs.ne', one_smul]
    have key := eq_iff_identity N hNH c hc0 hc hk hN1 hN2
    constructor
    · intro heq
      have : (N ^ 3).trace = ((Fintype.card ι : ℝ) - 2) / c := by
        rw [hN3, heq]; field_simp
      obtain ⟨u, hu, hNu⟩ := key.mp this
      exact ⟨u, hu, by rw [hMN, hNu]⟩
    · rintro ⟨u, hu, hMu⟩
      have hNu : N = ((Fintype.card ι : ℝ) / c) • Matrix.vecMulVec u u - (1 / c) • (1 : Matrix ι ι ℝ) := by
        rw [hNdef, hMu, smul_smul, inv_mul_cancel₀ hs.ne', one_smul]
      have h3 := key.mpr ⟨u, hu, hNu⟩
      rw [hN3] at h3
      have : (M ^ 3).trace = s ^ 3 * (s⁻¹ ^ 3 * (M ^ 3).trace) := by field_simp
      rw [this, h3]; ring

/-! ## The `k = 3` clause, through a Householder reflection -/

omit [DecidableEq ι] in
/-- `A (u vᵀ) Bᵀ = (A u)(B v)ᵀ`. -/
theorem conj_vecMulVec (A B : Matrix ι ι ℝ) (u v : ι → ℝ) :
    A * Matrix.vecMulVec u v * Bᵀ = Matrix.vecMulVec (A *ᵥ u) (B *ᵥ v) := by
  ext a b
  simp only [Matrix.mul_apply, Matrix.vecMulVec_apply, Matrix.transpose_apply, Matrix.mulVec, dotProduct]
  simp_rw [Finset.sum_mul]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.mul_sum]
  exact Finset.sum_congr rfl fun x _ => by ring

/-- **A Householder reflection carries a unit vector to a coordinate vector.** -/
theorem exists_orth_to_single (u : ι → ℝ) (hu : ∑ j, u j ^ 2 = 1) (i₁ : ι) :
    ∃ H : Matrix ι ι ℝ, Hᵀ * H = 1 ∧ H *ᵥ u = Pi.single i₁ 1 := by
  set e : ι → ℝ := Pi.single i₁ 1 with he
  by_cases hue : u = e
  · exact ⟨1, by simp, by rw [Matrix.one_mulVec, hue]⟩
  set w : ι → ℝ := u - e with hw
  have hee : ∑ j, e j ^ 2 = 1 := by simp [he, Pi.single_apply]
  have hue1 : ∑ j, u j * e j = u i₁ := by simp [he, Pi.single_apply]
  have hww : ∑ j, w j ^ 2 = 2 * (1 - u i₁) := by
    have : ∀ j, w j ^ 2 = u j ^ 2 - 2 * (u j * e j) + e j ^ 2 := fun j => by simp only [hw, Pi.sub_apply]; ring
    simp only [this, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, hu, hee, hue1]; ring
  have hpos : 0 < ∑ j, w j ^ 2 := by
    have hne : ∃ j, w j ≠ 0 := by
      by_contra h; push Not at h
      exact hue (funext fun j => by have := h j; simp only [hw, Pi.sub_apply] at this; linarith)
    obtain ⟨j, hj⟩ := hne
    exact lt_of_lt_of_le (by positivity) (Finset.single_le_sum (f := fun j => w j ^ 2) (fun _ _ => sq_nonneg _)
      (Finset.mem_univ j))
  set d := ∑ j, w j ^ 2
  refine ⟨1 - (2 / d) • Matrix.vecMulVec w w, ?_, ?_⟩
  · have hsym : (Matrix.vecMulVec w w)ᵀ = Matrix.vecMulVec w w := by
      ext a b; simp [Matrix.vecMulVec_apply, mul_comm]
    have hsq : Matrix.vecMulVec w w * Matrix.vecMulVec w w = d • Matrix.vecMulVec w w := by
      ext a b
      simp only [Matrix.mul_apply, Matrix.vecMulVec_apply, Matrix.smul_apply, smul_eq_mul]
      have : ∑ x, w a * w x * (w x * w b) = (∑ x, w x ^ 2) * (w a * w b) := by
        rw [Finset.sum_mul]; exact Finset.sum_congr rfl fun x _ => by ring
      rw [this]
    have hd : d ≠ 0 := hpos.ne'
    rw [Matrix.transpose_sub, Matrix.transpose_one, Matrix.transpose_smul, hsym]
    simp only [sub_mul, mul_sub, Matrix.one_mul, Matrix.mul_one, Matrix.smul_mul, Matrix.mul_smul, hsq, smul_smul]
    rw [show 2 / d * (2 / d * d) = 2 * (2 / d) by field_simp, mul_smul, two_smul]
    abel
  · have hwu : ∑ j, w j * u j = 1 - u i₁ := by
      have : ∀ j, w j * u j = u j ^ 2 - u j * e j := fun j => by simp only [hw, Pi.sub_apply]; ring
      simp only [this, Finset.sum_sub_distrib, hu, hue1]
    have hd2 : d = 2 * (1 - u i₁) := hww
    have h1u : 1 - u i₁ ≠ 0 := by
      intro h; rw [h, mul_zero] at hd2; exact hpos.ne' hd2
    rw [Matrix.sub_mulVec, Matrix.one_mulVec, Matrix.smul_mulVec]
    funext a
    simp only [Pi.sub_apply, Pi.smul_apply, smul_eq_mul, Matrix.mulVec, dotProduct, Matrix.vecMulVec_apply]
    have : ∑ x, w a * w x * u x = w a * (1 - u i₁) := by
      rw [← hwu, Finset.mul_sum]; exact Finset.sum_congr rfl fun x _ => by ring
    rw [this, hd2]
    simp only [hw, Pi.sub_apply]
    field_simp
    ring

/-- **L225 at `k = 3`**: a trace-free symmetric `3 × 3` matrix has `tr M³ = |M|³/√6` exactly when it is a
nonnegative multiple of `diag(2, -1, -1)` in some orthonormal frame. -/
theorem k3_clause (M : Matrix (Fin 3) (Fin 3) ℝ) (hM : M.IsHermitian) (h1 : M.trace = 0) :
    (M ^ 3).trace = 1 / Real.sqrt 6 * Real.sqrt ((M ^ 2).trace) ^ 3 ↔
      ∃ (O : Matrix (Fin 3) (Fin 3) ℝ) (t : ℝ), Oᵀ * O = 1 ∧ 0 ≤ t ∧
        M = t • (Oᵀ * Matrix.diagonal ![2, -1, -1] * O) := by
  have hc0 : (0 : ℝ) < Real.sqrt 6 := by positivity
  have hc : Real.sqrt 6 ^ 2 = (Fintype.card (Fin 3) : ℝ) * ((Fintype.card (Fin 3) : ℝ) - 1) := by
    rw [Real.sq_sqrt (by norm_num)]; simp; norm_num
  have key := eq_iff_identity_unnormalised M hM (Real.sqrt 6) hc0 hc (by simp) h1
  simp only [Fintype.card_fin] at key
  rw [show ((3 : ℕ) : ℝ) - 2 = 1 by norm_num] at key
  have hD : Matrix.diagonal ![(2 : ℝ), -1, -1] = (3 : ℝ) • Matrix.vecMulVec (Pi.single 0 1) (Pi.single 0 1) - 1 := by
    ext a b; fin_cases a <;> fin_cases b <;> simp [Matrix.vecMulVec_apply]; norm_num
  rw [key]
  set s := Real.sqrt ((M ^ 2).trace) with hsdef
  have hs0 : 0 ≤ s := Real.sqrt_nonneg _
  have h6 : Real.sqrt 6 ≠ 0 := hc0.ne'
  -- `s((3/√6) uuᵀ - (1/√6) I) = (s/√6)(3 uuᵀ - I)`
  have hform : ∀ u : Fin 3 → ℝ, s • ((((3 : ℕ) : ℝ) / Real.sqrt 6) • Matrix.vecMulVec u u - (1 / Real.sqrt 6) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      = (s / Real.sqrt 6) • ((3 : ℝ) • Matrix.vecMulVec u u - 1) := fun u => by
    rw [smul_sub, smul_sub, smul_smul, smul_smul, smul_smul]; push_cast
    congr 1
    · congr 1; field_simp
    · rw [show s * (1 / Real.sqrt 6) = s / Real.sqrt 6 * 1 by ring, ← smul_smul, one_smul]
  constructor
  · rintro ⟨u, hu, hMu⟩
    obtain ⟨H, hH, hHu⟩ := exists_orth_to_single u hu 0
    have hHtu : Hᵀ *ᵥ Pi.single 0 1 = u := by rw [← hHu, Matrix.mulVec_mulVec, hH, Matrix.one_mulVec]
    have hconj : Hᵀ * Matrix.vecMulVec (Pi.single 0 1) (Pi.single 0 1) * H = Matrix.vecMulVec u u := by
      have := conj_vecMulVec Hᵀ Hᵀ (Pi.single (0 : Fin 3) (1 : ℝ)) (Pi.single 0 1)
      rw [Matrix.transpose_transpose, hHtu] at this
      exact this
    refine ⟨H, s / Real.sqrt 6, hH, by positivity, ?_⟩
    rw [hMu, hform, hD, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_one, hH, Matrix.mul_smul, Matrix.smul_mul, hconj]
  · rintro ⟨O, t, hO, ht, hMt⟩
    have hO' : O * Oᵀ = 1 := mul_eq_one_comm.mp hO
    set u : Fin 3 → ℝ := Oᵀ *ᵥ Pi.single 0 1 with hu
    have hunit : ∑ j, u j ^ 2 = 1 := by
      have : ∀ j, u j = O 0 j := fun j => by simp [hu]
      simp only [this]
      have := congrFun (congrFun hO' 0) 0
      simpa [Matrix.mul_apply, Matrix.transpose_apply, sq] using this
    have hconj : Oᵀ * Matrix.vecMulVec (Pi.single 0 1) (Pi.single 0 1) * O = Matrix.vecMulVec u u := by
      have := conj_vecMulVec Oᵀ Oᵀ (Pi.single (0 : Fin 3) (1 : ℝ)) (Pi.single 0 1)
      rw [Matrix.transpose_transpose] at this
      exact this
    have hM2 : (M ^ 2).trace = 6 * t ^ 2 := by
      rw [hMt, smul_pow, Matrix.trace_smul, smul_eq_mul, sq (Oᵀ * _ * O)]
      rw [show Oᵀ * Matrix.diagonal ![(2 : ℝ), -1, -1] * O * (Oᵀ * Matrix.diagonal ![2, -1, -1] * O)
          = Oᵀ * (Matrix.diagonal ![(2 : ℝ), -1, -1] * Matrix.diagonal ![2, -1, -1]) * O by
        simp only [Matrix.mul_assoc]; rw [← Matrix.mul_assoc O Oᵀ, hO', Matrix.one_mul]]
      rw [Matrix.trace_mul_cycle, ← Matrix.mul_assoc, hO', Matrix.one_mul, Matrix.diagonal_mul_diagonal,
        Matrix.trace_diagonal]
      simp [Fin.sum_univ_three]; ring
    have hs : s = Real.sqrt 6 * t := by
      rw [hsdef, hM2, Real.sqrt_mul (by norm_num), Real.sqrt_sq ht]
    refine ⟨u, hunit, ?_⟩
    rw [hform, hs, show Real.sqrt 6 * t / Real.sqrt 6 = t by field_simp, hMt, hD, Matrix.mul_sub, Matrix.sub_mul,
      Matrix.mul_one, hO, Matrix.mul_smul, Matrix.smul_mul, hconj]

end HamiltonsCubic.L225Statement
