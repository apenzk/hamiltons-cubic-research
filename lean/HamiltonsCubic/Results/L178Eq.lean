import HamiltonsCubic.Results.L178N4
import HamiltonsCubic.Results.L225Matrix

set_option linter.style.longLine false

/-!
# L178's equality clause at `n = 4`, in spectral form

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L178, step 5: *"Equality forces the discriminant to
vanish, hence a repeated root, and `x³ − ½x − 1/(3√6)` has roots `(2, −1, −1)/√6`, which is `ℂP²`'s self-dual
spectrum."* On the layer's `n = 4` model of [L178N4.lean](L178N4.lean):

- `blockR`, `blockR_hermitian`, `blockR_trace`, `blockR_trace_sq`, `blockR_trace_cube`: the trace-free block as a real
  symmetric matrix, with `tr B = 0`, `tr B² = s` and `tr B³ = 3 det B`;
- **`L178_eq_block`**: `(9 det B)² = (3/2) s³` with `det B > 0` forces the normalised block `B/√s` to have eigenvalues
  `2/√6` once and `−1/√6` twice, through [L225Matrix.lean](L225Matrix.lean)'s `matrix_cube_eq` at `k = 3`;
- **`L178_n4_form`**: every `n = 4` Weyl operator of rank at most three is a trace-free block on `Λ⁺` or on `Λ⁻`;
- **`L178_n4_eq`**: such an operator with `θ = +√(3/2)` has normalised block spectrum `(2, −1, −1)/√6`;
- **`L178_n4_attained`**: the converse at the `ℂP²` block `R⁺(diag(2, −1, −1))`, a Weyl operator of rank at most three with
  `P(R)² = (3/2)‖R‖⁶` and `P(R) > 0`.

The rigidity the record states, *"`W_{ℂP²}` up to positive scale and an `O(n)` frame change"*, further needs that
`SO(4)` acts transitively on the oriented orthonormal frames of `Λ^±` and an orientation-reversing element of `O(4)`
carrying `Λ⁻` onto `Λ⁺`. Both are in [L178Quat.lean](L178Quat.lean) and [L178Rigid.lean](L178Rigid.lean), which
prove the rigidity as `L178_frame_eq_iff`.
-/

namespace HamiltonsCubic.Base

open Matrix Finset

/-- The trace-free block `[[a,b,c],[b,d,e],[c,e,−a−d]]` as a real matrix. -/
def blockR (a b c d e : ℚ) : Matrix (Fin 3) (Fin 3) ℝ :=
  Matrix.of fun i j => (match i, j with
    | 0, 0 => a | 0, 1 => b | 0, 2 => c | 1, 0 => b | 1, 1 => d | 1, 2 => e
    | 2, 0 => c | 2, 1 => e | 2, 2 => -a - d : ℚ)

theorem blockR_hermitian (a b c d e : ℚ) : (blockR a b c d e).IsHermitian := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [blockR, Matrix.conjTranspose_apply]

theorem blockR_trace (a b c d e : ℚ) : (blockR a b c d e).trace = 0 := by
  simp [blockR, Matrix.trace, Fin.sum_univ_three]

theorem blockR_trace_sq (a b c d e : ℚ) :
    ((blockR a b c d e) ^ 2).trace = ((a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) : ℚ) : ℝ) := by
  simp [blockR, Matrix.trace, pow_two, Matrix.mul_apply, Fin.sum_univ_three]; ring

theorem blockR_trace_cube (a b c d e : ℚ) :
    ((blockR a b c d e) ^ 3).trace = ((3 * det3 a b c d e (-a - d) : ℚ) : ℝ) := by
  simp [blockR, Matrix.trace, pow_succ, pow_zero, Matrix.mul_apply, Fin.sum_univ_three, det3]; ring

/-- **L178's equality clause for a trace-free block, in spectral form**: if `(9 det B)² = (3/2)(tr B²)³` with
`det B > 0`, the normalised block `B/√(tr B²)` has eigenvalues `2/√6` once and `−1/√6` twice, the `ℂP²` spectrum. -/
theorem L178_eq_block (a b c d e : ℚ) (hs : 0 < a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2))
    (heq : (9 * det3 a b c d e (-a - d)) ^ 2 = (3 / 2) * (a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2)) ^ 3)
    (hpos : 0 < det3 a b c d e (-a - d)) :
    let M := (1 / Real.sqrt ((a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) : ℚ) : ℝ)) • blockR a b c d e
    ∃ hM : M.IsHermitian, (∀ i, hM.eigenvalues i = 2 / Real.sqrt 6 ∨ hM.eigenvalues i = -1 / Real.sqrt 6) ∧
      (univ.filter fun i => hM.eigenvalues i = 2 / Real.sqrt 6).card = 1 := by
  intro M
  set s : ℚ := a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) with hsdef
  set D : ℚ := det3 a b c d e (-a - d) with hD
  have hsR : (0 : ℝ) < s := by exact_mod_cast hs
  set t := Real.sqrt (s : ℝ) with ht
  have ht0 : 0 < t := Real.sqrt_pos.mpr hsR
  have hts : t ^ 2 = s := Real.sq_sqrt hsR.le
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h60 : 0 < Real.sqrt 6 := by positivity
  -- `D = t³ / (3√6)`
  have hDR : (D : ℝ) = t ^ 3 / (3 * Real.sqrt 6) := by
    have heqR : (81 : ℝ) * (D : ℝ) ^ 2 = (3 / 2) * (s : ℝ) ^ 3 := by
      have := congrArg (fun q : ℚ => (q : ℝ)) heq; push_cast at this; linarith
    have hDp : (0 : ℝ) < D := by exact_mod_cast hpos
    have key : ((D : ℝ) - t ^ 3 / (3 * Real.sqrt 6)) * ((D : ℝ) + t ^ 3 / (3 * Real.sqrt 6)) = 0 := by
      have : (t ^ 3 / (3 * Real.sqrt 6)) ^ 2 = (s : ℝ) ^ 3 / 54 := by
        rw [div_pow, mul_pow, h6, ← hts]; ring
      nlinarith [this]
    have hpos2 : 0 < (D : ℝ) + t ^ 3 / (3 * Real.sqrt 6) := by positivity
    have := (mul_eq_zero.mp key).resolve_right hpos2.ne'
    linarith
  have hM : M.IsHermitian := Matrix.IsHermitian.smul (blockR_hermitian a b c d e) (IsSelfAdjoint.all _)
  refine ⟨hM, ?_⟩
  have hr : (1 / t) ^ 2 * (s : ℝ) = 1 := by rw [div_pow, one_pow, hts]; field_simp
  have h1 : M.trace = 0 := by simp only [M, Matrix.trace_smul, blockR_trace, smul_zero]
  have h2 : (M ^ 2).trace = 1 := by
    simp only [M, smul_pow, Matrix.trace_smul, blockR_trace_sq, smul_eq_mul]
    rw [← ht]; exact hr
  have h3 : (M ^ 3).trace = ((Fintype.card (Fin 3) : ℝ) - 2) / Real.sqrt 6 := by
    simp only [M, smul_pow, Matrix.trace_smul, blockR_trace_cube, smul_eq_mul, Fintype.card_fin]
    rw [← ht]; push_cast; rw [← hD, hDR]
    field_simp
    ring
  have hc : Real.sqrt 6 ^ 2 = (Fintype.card (Fin 3) : ℝ) * ((Fintype.card (Fin 3) : ℝ) - 1) := by
    rw [h6]; norm_num
  obtain ⟨hev, hcard⟩ := HamiltonsCubic.L225Statement.matrix_cube_eq M hM (Real.sqrt 6) h60 hc (by simp) h1 h2 h3
  simp only [Fintype.card_fin] at hev hcard
  norm_num at hev hcard
  exact ⟨hev, hcard⟩

/-- **Every `n = 4` Weyl operator of rank at most three is a trace-free block on `Λ⁺` or on `Λ⁻`.** -/
theorem L178_n4_form {R : Matrix (Fin 6) (Fin 6) ℚ} (hW : IsWeyl R) (hrank : R.rank ≤ 3) :
    ∃ a b c d e : ℚ, R = Rp a b c d e (-a - d) ∨ R = Rm a b c d e (-a - d) := by
  obtain ⟨hS, hB, hR⟩ := hW
  have hd := decomp4 hS (mixed_zero4 hS hR)
  obtain ⟨htp, htm⟩ := trace4 hS hB hR
  rcases rank4 hS hB hR hrank with h | h
  · have hf : blkM R 2 2 = -blkM R 0 0 - blkM R 1 1 := by simp only [blkM]; linarith
    rw [show blkP R 0 0 = 0 from h 0 0, show blkP R 0 1 = 0 from h 0 1, show blkP R 0 2 = 0 from h 0 2,
      show blkP R 1 1 = 0 from h 1 1, show blkP R 1 2 = 0 from h 1 2, show blkP R 2 2 = 0 from h 2 2, Rp_zero,
      zero_add, hf] at hd
    exact ⟨_, _, _, _, _, Or.inr hd⟩
  · have hf : blkP R 2 2 = -blkP R 0 0 - blkP R 1 1 := by simp only [blkP]; linarith
    rw [show blkM R 0 0 = 0 from h 0 0, show blkM R 0 1 = 0 from h 0 1, show blkM R 0 2 = 0 from h 0 2,
      show blkM R 1 1 = 0 from h 1 1, show blkM R 1 2 = 0 from h 1 2, show blkM R 2 2 = 0 from h 2 2, Rm_zero,
      add_zero, hf] at hd
    exact ⟨_, _, _, _, _, Or.inl hd⟩

/-- **L178's equality clause at `n = 4`, in spectral form**: an `n = 4` Weyl operator of rank at most three with
`θ = +√(3/2)`, that is `P(R)² = (3/2)‖R‖⁶` and `P(R) > 0`, is a trace-free block on `Λ⁺` or on `Λ⁻` whose normalised
spectrum is `(2, −1, −1)/√6`, the `ℂP²` spectrum. -/
theorem L178_n4_eq {R : Matrix (Fin 6) (Fin 6) ℚ} (hW : IsWeyl R) (hrank : R.rank ≤ 3)
    (heq : Pcubic R ^ 2 = (3 / 2) * ((Rᵀ * R).trace) ^ 3) (hpos : 0 < Pcubic R) :
    ∃ a b c d e : ℚ, (R = Rp a b c d e (-a - d) ∨ R = Rm a b c d e (-a - d)) ∧
      let M := (1 / Real.sqrt ((a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) : ℚ) : ℝ)) • blockR a b c d e
      ∃ hM : M.IsHermitian, (∀ i, hM.eigenvalues i = 2 / Real.sqrt 6 ∨ hM.eigenvalues i = -1 / Real.sqrt 6) ∧
        (univ.filter fun i => hM.eigenvalues i = 2 / Real.sqrt 6).card = 1 := by
  obtain ⟨a, b, c, d, e, hR⟩ := L178_n4_form hW hrank
  refine ⟨a, b, c, d, e, hR, ?_⟩
  have hPs : Pcubic R = 9 * det3 a b c d e (-a - d) ∧
      (Rᵀ * R).trace = a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) := by
    rcases hR with hR | hR <;> subst hR
    · exact ⟨(L178_theta_sd a b c d e).1, normSq_Rp _ _ _ _ _ _⟩
    · exact ⟨(L178_theta_asd a b c d e).1, normSq_Rm _ _ _ _ _ _⟩
  obtain ⟨hP, hN⟩ := hPs
  rw [hP, hN] at heq
  rw [hP] at hpos
  have hD : 0 < det3 a b c d e (-a - d) := by linarith
  have hs : 0 < a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) := by
    by_contra hle
    push Not at hle
    have h0 : 0 ≤ a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) := by positivity
    have hz : a ^ 2 + d ^ 2 + (-a - d) ^ 2 + 2 * (b ^ 2 + c ^ 2 + e ^ 2) = 0 := le_antisymm hle h0
    rw [hz] at heq
    nlinarith [hD]
  exact L178_eq_block a b c d e hs heq hD

set_option maxHeartbeats 16000000 in
-- Ten Ricci contractions of the witness, expanded symbolically.
/-- **The converse: the `ℂP²` block attains the bound.** `R = R⁺(diag(2, −1, −1))` is an `n = 4` Weyl operator of rank
at most three with `P(R)² = (3/2)‖R‖⁶` and `P(R) > 0`. -/
theorem L178_n4_attained :
    IsWeyl (Rp 2 0 0 (-1) 0 (-1)) ∧ (Rp 2 0 0 (-1) 0 (-1)).rank ≤ 3 ∧ 0 < Pcubic (Rp 2 0 0 (-1) 0 (-1)) ∧
      Pcubic (Rp 2 0 0 (-1) 0 (-1)) ^ 2 = (3 / 2) * (((Rp 2 0 0 (-1) 0 (-1))ᵀ * Rp 2 0 0 (-1) 0 (-1)).trace) ^ 3 := by
  have hP : Pcubic (Rp 2 0 0 (-1) 0 (-1)) = 18 := by
    have := (L178_theta_sd 2 0 0 (-1) 0).1
    norm_num at this; rw [this]; norm_num [det3]
  have hN := normSq_Rp 2 0 0 (-1) 0 (-1)
  refine ⟨⟨?_, ?_, ?_⟩, ?_, by rw [hP]; norm_num, by rw [hP, hN]; norm_num⟩
  · ext p q; fin_cases p <;> fin_cases q <;> simp [Rp, wp, Matrix.transpose_apply]
  · simp [IsBianchi, Rp, wp]; norm_num
  · intro a b
    fin_cases a <;> fin_cases b <;>
      simp only [Ric, toMat4, coord4, basis4, pair4, phi, inner2, Matrix.mulVec, dotProduct, Fin.sum_univ_six,
        Fin.sum_univ_four, Matrix.single, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, Fin.isValue,
        Matrix.of_apply, Matrix.transpose_apply, Matrix.mul_apply, Matrix.trace, Matrix.diag, Rp, wp, Fin.zero_eta,
        Fin.mk_one, Fin.reduceFinMk] <;> norm_num [Fin.ext_iff]
  · -- `R = W N` with `W` the `6 × 3` matrix of `ω⁺`
    let Wm : Matrix (Fin 6) (Fin 3) ℚ := Matrix.of fun p i => wp i p
    let Nm : Matrix (Fin 3) (Fin 6) ℚ := Matrix.of fun i q => (1 / 2 : ℚ) * (match i with
      | 0 => 2 * wp 0 q | 1 => -wp 1 q | 2 => -wp 2 q)
    have e : Rp 2 0 0 (-1) 0 (-1) = Wm * Nm := by
      ext p q; fin_cases p <;> fin_cases q <;> simp [Rp, Wm, Nm, wp, Matrix.mul_apply, Fin.sum_univ_three]
    rw [e]
    exact (Matrix.rank_mul_le_left Wm Nm).trans (by simpa using Matrix.rank_le_width Wm)

end HamiltonsCubic.Base
