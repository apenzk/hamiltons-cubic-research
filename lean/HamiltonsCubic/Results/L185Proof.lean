import HamiltonsCubic.Results.L180Statement
import HamiltonsCubic.Results.L185Statement

set_option linter.style.longLine false

/-!
# L185: the all-decomposable branch is empty

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L185: *"There is no rank-three Weyl tensor whose three
image forms are all decomposable."* On the layer's objects: `W = specOp λ ω` with `ω_i = u_i ∧ v_i` and Ricci-flatness
as [WeylReal.lean](../Base/WeylReal.lean)'s `Ric`.

- `dform`, `ONPair`, `dform_skew`, `proj`, **`dform_mul_transpose`**: a unit decomposable form has `ω ωᵀ = Π`, the
  projection onto its plane, idempotent (`proj_idem`), symmetric and of trace `2`;
- **`eq_of_anticomm`**: two symmetric projections with `AB + BA = A + B` are equal, since `(A − B)² = 0`;
- **`anticomm_of_sum`**: `λ₀Π₀ + λ₁Π₁ + λ₂Π₂ = 0` with `λ₀ = −λ₁ − λ₂` and `λ₁λ₂ ≠ 0` gives that anticommutator, the
  record's squaring step, with no sign grouping needed;
- `proj_mulVec`, `dform_comb`, `inner2_dform_self`: equal planes make `ω₁ = (ad − bc) ω₀` with `(ad − bc)² = 1`;
- **`L185`**: Ricci-flatness ([L180Statement.lean](L180Statement.lean)'s `ric_specOp`, `ricci_flat_iff`) reads
  `∑ λ_i Π_i = 0`, so all three planes coincide and `⟨ω₀, ω₁⟩ = ±1`, against orthogonality.
-/

namespace HamiltonsCubic.L185Proof

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.L180

variable {n : ℕ}

/-- The decomposable form `u ∧ v = u vᵀ − v uᵀ`. -/
def dform (u v : Fin n → ℝ) : Matrix (Fin n) (Fin n) ℝ := vecMulVec u v - vecMulVec v u

/-- An orthonormal pair of vectors. -/
structure ONPair (u v : Fin n → ℝ) : Prop where
  uu : u ⬝ᵥ u = 1
  vv : v ⬝ᵥ v = 1
  uv : u ⬝ᵥ v = 0

theorem dform_skew (u v : Fin n → ℝ) : IsSkew (dform u v) := by
  unfold IsSkew dform; rw [transpose_sub, transpose_vecMulVec, transpose_vecMulVec]; abel

/-- The projection onto the plane `span{u, v}`. -/
def proj (u v : Fin n → ℝ) : Matrix (Fin n) (Fin n) ℝ := vecMulVec u u + vecMulVec v v

theorem dform_mul_transpose {u v : Fin n → ℝ} (h : ONPair u v) : dform u v * (dform u v)ᵀ = proj u v := by
  have hvu : v ⬝ᵥ u = 0 := by rw [dotProduct_comm]; exact h.uv
  rw [(dform_skew u v)]
  simp only [dform, proj, Matrix.mul_neg, Matrix.sub_mul, Matrix.mul_sub, vecMulVec_mul_vecMulVec, h.uu, h.vv, h.uv,
    hvu, zero_smul, one_smul, vecMulVec_zero, sub_zero, zero_sub]
  abel

theorem proj_idem {u v : Fin n → ℝ} (h : ONPair u v) : proj u v * proj u v = proj u v := by
  have hvu : v ⬝ᵥ u = 0 := by rw [dotProduct_comm]; exact h.uv
  simp only [proj, Matrix.add_mul, Matrix.mul_add, vecMulVec_mul_vecMulVec, h.uu, h.vv, h.uv, hvu, zero_smul,
    one_smul, vecMulVec_zero, add_zero, zero_add]

theorem proj_symm (u v : Fin n → ℝ) : (proj u v)ᵀ = proj u v := by
  simp only [proj, transpose_add, transpose_vecMulVec]

theorem proj_trace {u v : Fin n → ℝ} (h : ONPair u v) : (proj u v).trace = 2 := by
  simp only [proj, trace_add, trace_vecMulVec, h.uu, h.vv]; norm_num

/-- **Two symmetric projections whose anticommutator is their sum are equal**: `(A − B)² = 0`. -/
theorem eq_of_anticomm {A B : Matrix (Fin n) (Fin n) ℝ} (hAs : Aᵀ = A) (hBs : Bᵀ = B) (hA : A * A = A)
    (hB : B * B = B) (hanti : A * B + B * A = A + B) : A = B := by
  have hD : (A - B)ᴴ * (A - B) = 0 := by
    rw [conjTranspose_eq_transpose_of_trivial, transpose_sub, hAs, hBs]
    simp only [Matrix.sub_mul, Matrix.mul_sub, hA, hB]
    have : A - B * A - (A * B - B) = (A + B) - (A * B + B * A) := by abel
    rw [this, hanti, sub_self]
  exact sub_eq_zero.mp (conjTranspose_mul_self_eq_zero.mp hD)

/-- **The anticommutator from a vanishing weighted sum**: `λ₀Π₀ + λ₁Π₁ + λ₂Π₂ = 0` with `λ₀ = −λ₁ − λ₂` and
`λ₁λ₂ ≠ 0` gives `Π₁Π₂ + Π₂Π₁ = Π₁ + Π₂`. -/
theorem anticomm_of_sum {P₀ P₁ P₂ : Matrix (Fin n) (Fin n) ℝ} {l₀ l₁ l₂ : ℝ} (h₀ : P₀ * P₀ = P₀) (h₁ : P₁ * P₁ = P₁)
    (h₂ : P₂ * P₂ = P₂) (hsum : l₀ • P₀ + l₁ • P₁ + l₂ • P₂ = 0) (hl : l₀ = -l₁ - l₂) (h12 : l₁ * l₂ ≠ 0) :
    P₁ * P₂ + P₂ * P₁ = P₁ + P₂ := by
  have hS : l₀ • P₀ = -(l₁ • P₁ + l₂ • P₂) := by rw [← sub_eq_zero, sub_neg_eq_add, ← add_assoc]; exact hsum
  have hsq : (l₁ • P₁ + l₂ • P₂) * (l₁ • P₁ + l₂ • P₂) = l₀ • -(l₁ • P₁ + l₂ • P₂) := by
    have : (l₀ • P₀) * (l₀ • P₀) = l₀ • (l₀ • P₀) := by rw [smul_mul_smul_comm, h₀, smul_smul]
    rw [hS, neg_mul_neg] at this; rw [this]
  have key : (l₁ * l₂) • (P₁ * P₂ + P₂ * P₁ - (P₁ + P₂)) = 0 := by
    ext i j
    have e := congrFun (congrFun hsq i) j
    simp only [Matrix.add_mul, Matrix.mul_add, smul_mul_smul_comm, h₁, h₂, Matrix.add_apply, Matrix.smul_apply,
      Matrix.neg_apply, smul_eq_mul] at e
    simp only [Matrix.smul_apply, Matrix.sub_apply, Matrix.add_apply, Matrix.zero_apply, smul_eq_mul]
    rw [hl] at e
    linear_combination e
  have := (smul_eq_zero.mp key).resolve_left h12
  exact sub_eq_zero.mp this

theorem proj_mulVec (u v w : Fin n → ℝ) : proj u v *ᵥ w = (u ⬝ᵥ w) • u + (v ⬝ᵥ w) • v := by
  simp only [proj, Matrix.add_mulVec, vecMulVec_mulVec, op_smul_eq_smul]

theorem dform_comb (u v : Fin n → ℝ) (a b c d : ℝ) :
    dform (a • u + b • v) (c • u + d • v) = (a * d - b * c) • dform u v := by
  ext i j; simp only [dform, Matrix.sub_apply, vecMulVec_apply, Pi.add_apply, Pi.smul_apply, smul_eq_mul,
    Matrix.smul_apply]; ring

theorem inner2_dform_self {u v : Fin n → ℝ} (h : ONPair u v) : inner2 (dform u v) (dform u v) = 1 := by
  unfold inner2
  have e : (dform u v)ᵀ * dform u v = dform u v * (dform u v)ᵀ := by
    rw [dform_skew u v, neg_mul, Matrix.mul_neg]
  rw [e, dform_mul_transpose h, proj_trace h]
  norm_num

/-- **L185: the all-decomposable branch is empty.** There are no unit decomposable forms `ω_i = u_i ∧ v_i`, orthonormal
in `Λ²`, with nonzero `λ_i` and `W = ∑ λ_i ω_i ⊗ ω_i` Ricci-flat. -/
theorem L185 (u v : Fin 3 → Fin n → ℝ) (hON : ∀ i, ONPair (u i) (v i)) (lam : Fin 3 → ℝ) (hlam : ∀ i, lam i ≠ 0)
    (horth : inner2 (dform (u 0) (v 0)) (dform (u 1) (v 1)) = 0)
    (hR : ∀ a c, Ric (specOp lam fun i => dform (u i) (v i)) a c = 0) : False := by
  set om := fun i => dform (u i) (v i)
  have hsk : ∀ i, IsSkew (om i) := fun i => dform_skew _ _
  have hflat : (∑ i, lam i • (om i * (om i)ᵀ)) = 0 := by
    rw [← ricci_flat_iff]; intro a c; rw [← ric_specOp lam om hsk]; exact hR a c
  simp only [Fin.sum_univ_three, om, dform_mul_transpose (hON _)] at hflat
  -- the weights sum to zero
  have htr := congrArg Matrix.trace hflat
  simp only [trace_add, trace_smul, proj_trace (hON _), trace_zero, smul_eq_mul] at htr
  have hl0 : lam 0 = -lam 1 - lam 2 := by linarith
  have hl2 : lam 2 = -lam 0 - lam 1 := by linarith
  have hP := fun i => proj_idem (hON i)
  have hPs := fun i => proj_symm (u i) (v i)
  -- all three planes coincide
  have e12 : proj (u 1) (v 1) = proj (u 2) (v 2) :=
    eq_of_anticomm (hPs 1) (hPs 2) (hP 1) (hP 2)
      (anticomm_of_sum (hP 0) (hP 1) (hP 2) hflat hl0 (mul_ne_zero (hlam 1) (hlam 2)))
  have hflat' : lam 2 • proj (u 2) (v 2) + lam 0 • proj (u 0) (v 0) + lam 1 • proj (u 1) (v 1) = 0 := by
    rw [← hflat]; abel
  have e01 : proj (u 0) (v 0) = proj (u 1) (v 1) :=
    eq_of_anticomm (hPs 0) (hPs 1) (hP 0) (hP 1)
      (anticomm_of_sum (hP 2) (hP 0) (hP 1) hflat' hl2 (mul_ne_zero (hlam 0) (hlam 1)))
  -- so `u₁, v₁` lie in the plane of `u₀, v₀`
  have hin : ∀ w, proj (u 1) (v 1) *ᵥ w = w → w = (u 0 ⬝ᵥ w) • u 0 + (v 0 ⬝ᵥ w) • v 0 := fun w hw => by
    rw [← proj_mulVec, e01, hw]
  have hu1 : proj (u 1) (v 1) *ᵥ u 1 = u 1 := by
    rw [proj_mulVec, (hON 1).uu, dotProduct_comm, (hON 1).uv, one_smul, zero_smul, add_zero]
  have hv1 : proj (u 1) (v 1) *ᵥ v 1 = v 1 := by
    rw [proj_mulVec, (hON 1).uv, (hON 1).vv, one_smul, zero_smul, zero_add]
  obtain ⟨a, ha⟩ : ∃ a, a = u 0 ⬝ᵥ u 1 := ⟨_, rfl⟩
  obtain ⟨b, hb⟩ : ∃ b, b = v 0 ⬝ᵥ u 1 := ⟨_, rfl⟩
  obtain ⟨c, hc⟩ : ∃ c, c = u 0 ⬝ᵥ v 1 := ⟨_, rfl⟩
  obtain ⟨d, hd⟩ : ∃ d, d = v 0 ⬝ᵥ v 1 := ⟨_, rfl⟩
  have eu : u 1 = a • u 0 + b • v 0 := by rw [ha, hb]; exact hin _ hu1
  have ev : v 1 = c • u 0 + d • v 0 := by rw [hc, hd]; exact hin _ hv1
  have h0 := hON 0
  have hvu0 : v 0 ⬝ᵥ u 0 = 0 := by rw [dotProduct_comm]; exact h0.uv
  have dot : ∀ p q r s : ℝ, (p • u 0 + q • v 0) ⬝ᵥ (r • u 0 + s • v 0) = p * r + q * s := fun p q r s => by
    simp only [add_dotProduct, dotProduct_add, smul_dotProduct, dotProduct_smul, h0.uu, h0.vv, h0.uv, hvu0,
      smul_eq_mul]; ring
  have n1 : a * a + b * b = 1 := by have := (hON 1).uu; rw [eu, dot] at this; exact this
  have n2 : c * c + d * d = 1 := by have := (hON 1).vv; rw [ev, dot] at this; exact this
  have n3 : a * c + b * d = 0 := by have := (hON 1).uv; rw [eu, ev, dot] at this; exact this
  have hform : dform (u 1) (v 1) = (a * d - b * c) • dform (u 0) (v 0) := by
    rw [eu, ev, dform_comb]
  rw [hform] at horth
  unfold inner2 at horth
  rw [Matrix.mul_smul, trace_smul, smul_eq_mul] at horth
  have hself := inner2_dform_self h0
  unfold inner2 at hself
  have hdet : a * d - b * c = 0 := by nlinarith [hself, horth]
  nlinarith [sq_nonneg (a * c + b * d), sq_nonneg (a * d - b * c)]

end HamiltonsCubic.L185Proof
