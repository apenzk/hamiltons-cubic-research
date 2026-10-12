import HamiltonsCubic.Base.WeylReal

/-!
# L31, the bracket cap, PROVED (the cap half)

[stratum-two-negative.md](../../../findings/stratum-two-negative.md)'s Lemma L31, quoted verbatim:

> **Statement, in two parts.** For **unit** $X,Y\in\mathfrak{so}(n)$:
>
> $$\lVert[X,Y]\rVert^2\ \le\ 2,$$
>
> **with equality if and only if** $XY=-YX$, both $X$ and $Y$ have rank $4$ with all **nonzero**
> singular values equal to $1/\sqrt2$, and $\mathrm{im}\,X=\mathrm{im}\,Y$.

**What is typed and proved here is the cap**, the half the record's seven consumers cite, as
`L31_cap`: `‖[X,Y]‖² ≤ 2 ‖X‖² ‖Y‖²` in the record's norm `‖Z‖² = ½ tr(ZᵀZ)`, which at unit `X`, `Y`
is the display. **The equality characterisation is NOT typed.**

## How it is proved, without the skew canonical form

The record's proof reads `‖ad_X‖` off the root decomposition. This one uses only a top singular
vector. *Compactness of the unit sphere gives `u` maximising `|Xu|` (`exists_max`), and a variation
argument makes it a top eigenvector of `XᵀX` (`max_eigen`).* **The plane `P` spanned by `u` and `Xu`
is `X`-invariant** (`plane`), `X` acting there as `σJ`, and for skew `Y` the block `PYP` is a
multiple of the same rank-two matrix as `XP`, so the in-plane block of `[X,Y]` vanishes. The three
other blocks are bounded by `(σ+τ)` with `τ ≤ σ` the operator norm of `X` off the plane
(`fsq_comm_bound`), and skewness pairs the singular values: `‖X‖_F² = 2σ² + ‖X_Q‖_F²` with
`‖X_Q‖_F² ≥ 2τ²` (the plane lemma again), so `(σ+τ)² ≤ 2σ² + 2τ² ≤ ‖X‖_F²` (`cap_frob`).
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L31Statement

open Matrix Finset

namespace Proof

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `|x|²`. -/
def nsq (x : ι → ℝ) : ℝ := ∑ i, x i ^ 2

theorem nsq_nonneg (x : ι → ℝ) : 0 ≤ nsq x := Finset.sum_nonneg fun _ _ => sq_nonneg _

theorem nsq_add_smul (a b : ι → ℝ) (t : ℝ) :
    nsq (a + t • b) = nsq a + 2 * t * (a ⬝ᵥ b) + t ^ 2 * nsq b := by
  simp only [nsq, dotProduct, Pi.add_apply, Pi.smul_apply, smul_eq_mul, Finset.mul_sum,
    ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun i _ => by ring

theorem nsq_eq_zero {x : ι → ℝ} (h : nsq x = 0) : x = 0 := by
  funext i
  have := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => sq_nonneg (x j))).mp h i (Finset.mem_univ i)
  simpa using this

theorem nsq_smul (t : ℝ) (x : ι → ℝ) : nsq (t • x) = t ^ 2 * nsq x := by
  simp only [nsq, Pi.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **A maximiser of `|Mx|` on the unit sphere exists.** -/
theorem exists_max [Nonempty ι] (M : Matrix (ι) (ι) ℝ) :
    ∃ u : ι → ℝ, nsq u = 1 ∧ ∀ x, nsq (M *ᵥ x) ≤ nsq (M *ᵥ u) * nsq x := by
  let S : Set (ι → ℝ) := {x | nsq x = 1}
  have hcont : Continuous (fun x : ι → ℝ => nsq x) := by unfold nsq; fun_prop
  have hS : IsCompact S := by
    apply Metric.isCompact_of_isClosed_isBounded
    · exact isClosed_eq hcont continuous_const
    · refine (Metric.isBounded_closedBall (x := (0 : ι → ℝ)) (r := 1)).subset fun x hx => ?_
      rw [Metric.mem_closedBall, dist_zero_right, pi_norm_le_iff_of_nonneg zero_le_one]
      intro i
      have hi : x i ^ 2 ≤ 1 := by
        have := Finset.single_le_sum (f := fun j => x j ^ 2) (fun j _ => sq_nonneg _) (Finset.mem_univ i)
        simp only [S, Set.mem_setOf_eq, nsq] at hx
        linarith
      rw [Real.norm_eq_abs]
      nlinarith [abs_nonneg (x i), sq_abs (x i)]
  have hne : S.Nonempty := ⟨Pi.single (Classical.arbitrary ι) 1, by simp [S, nsq, Pi.single_apply]⟩
  have hf : Continuous (fun x : ι → ℝ => nsq (M *ᵥ x)) := by
    unfold nsq; simp only [Matrix.mulVec, dotProduct]; fun_prop
  obtain ⟨u, hu, hmax⟩ := hS.exists_isMaxOn hne hf.continuousOn
  refine ⟨u, hu, fun x => ?_⟩
  by_cases hx : nsq x = 0
  · rw [nsq_eq_zero hx, Matrix.mulVec_zero]; simp [nsq]
  · have hxpos : 0 < nsq x := lt_of_le_of_ne (nsq_nonneg x) (Ne.symm hx)
    set r := Real.sqrt (nsq x)
    have hr : 0 < r := Real.sqrt_pos.mpr hxpos
    have hr2 : r ^ 2 = nsq x := Real.sq_sqrt hxpos.le
    have hmem : r⁻¹ • x ∈ S := by
      show nsq (r⁻¹ • x) = 1
      rw [nsq_smul, inv_pow, hr2, inv_mul_cancel₀ hx]
    have := hmax hmem
    change nsq (M *ᵥ (r⁻¹ • x)) ≤ nsq (M *ᵥ u) at this
    rw [Matrix.mulVec_smul, nsq_smul, inv_pow, hr2] at this
    rw [inv_mul_le_iff₀ hxpos] at this
    linarith

theorem lin_zero {a b : ℝ} (h : ∀ t : ℝ, 0 ≤ a * t + b * t ^ 2) : a = 0 := by
  by_contra ha
  have hb : 0 < |b| + 1 := by positivity
  have := h (-a / (|b| + 1))
  have key : a * (-a / (|b| + 1)) + b * (-a / (|b| + 1)) ^ 2
      = a ^ 2 * (b - (|b| + 1)) / (|b| + 1) ^ 2 := by field_simp; ring
  rw [key] at this
  have h1 : b - (|b| + 1) < 0 := by linarith [le_abs_self b]
  have h2 : 0 < a ^ 2 := by positivity
  have : a ^ 2 * (b - (|b| + 1)) / (|b| + 1) ^ 2 < 0 := div_neg_of_neg_of_pos (by nlinarith) (by positivity)
  linarith

/-- **The maximiser is a top eigenvector of `MᵀM`.** -/
theorem max_eigen (M : Matrix (ι) (ι) ℝ) {u : ι → ℝ} (hu : nsq u = 1)
    (hmax : ∀ x, nsq (M *ᵥ x) ≤ nsq (M *ᵥ u) * nsq x) :
    Mᵀ *ᵥ (M *ᵥ u) = nsq (M *ᵥ u) • u := by
  set c := nsq (M *ᵥ u)
  set r := Mᵀ *ᵥ (M *ᵥ u) - c • u
  have hdot : ∀ v, (M *ᵥ u) ⬝ᵥ (M *ᵥ v) = (Mᵀ *ᵥ (M *ᵥ u)) ⬝ᵥ v := by
    intro v
    rw [Matrix.dotProduct_mulVec, ← Matrix.mulVec_transpose]
  have hr : ∀ v, r ⬝ᵥ v = 0 := by
    intro v
    have key : ∀ t : ℝ, 0 ≤ (-2 * (r ⬝ᵥ v)) * t + (c * nsq v - nsq (M *ᵥ v)) * t ^ 2 := by
      intro t
      have := hmax (u + t • v)
      rw [Matrix.mulVec_add, Matrix.mulVec_smul, nsq_add_smul, nsq_add_smul, hu, hdot] at this
      have e : r ⬝ᵥ v = (Mᵀ *ᵥ (M *ᵥ u)) ⬝ᵥ v - c * (u ⬝ᵥ v) := by
        simp only [r, sub_dotProduct, smul_dotProduct, smul_eq_mul]
      rw [e]
      nlinarith [this]
    have := lin_zero key
    linarith
  have hr0 : r = 0 := by
    apply nsq_eq_zero
    have := hr r
    simpa [nsq, dotProduct, sq] using this
  exact sub_eq_zero.mp hr0


/-! ## Frobenius norms through the trace -/

def fsq (M : Matrix (ι) (ι) ℝ) : ℝ := (Mᵀ * M).trace
def fdot (M N : Matrix (ι) (ι) ℝ) : ℝ := (Mᵀ * N).trace

theorem fsq_eq_cols (M : Matrix (ι) (ι) ℝ) : fsq M = ∑ i, nsq (fun k => M k i) := by
  simp only [fsq, nsq, Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, sq]

theorem fsq_nonneg (M : Matrix (ι) (ι) ℝ) : 0 ≤ fsq M := by
  rw [fsq_eq_cols]; exact Finset.sum_nonneg fun i _ => nsq_nonneg _

theorem fsq_transpose (M : Matrix (ι) (ι) ℝ) : fsq Mᵀ = fsq M := by
  unfold fsq; rw [Matrix.transpose_transpose, Matrix.trace_mul_comm]

theorem fsq_neg (M : Matrix (ι) (ι) ℝ) : fsq (-M) = fsq M := by
  unfold fsq; simp

theorem fsq_sub (U V : Matrix (ι) (ι) ℝ) : fsq (U - V) = fsq U + fsq V - 2 * fdot U V := by
  unfold fsq fdot
  have : (Vᵀ * U).trace = (Uᵀ * V).trace := by
    rw [← Matrix.trace_transpose, Matrix.transpose_mul, Matrix.transpose_transpose]
  rw [Matrix.transpose_sub, Matrix.sub_mul, Matrix.mul_sub, Matrix.mul_sub, Matrix.trace_sub,
    Matrix.trace_sub, Matrix.trace_sub, this]
  ring

theorem fdot_sq_le (U V : Matrix (ι) (ι) ℝ) : fdot U V ^ 2 ≤ fsq U * fsq V := by
  have e : ∀ A B : Matrix (ι) (ι) ℝ, (Aᵀ * B).trace = ∑ p : ι × ι, A p.1 p.2 * B p.1 p.2 := by
    intro A B
    simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, Fintype.sum_prod_type]
    rw [Finset.sum_comm]
  unfold fdot fsq
  rw [e, e, e]
  have := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ (fun p : ι × ι => U p.1 p.2)
    (fun p => V p.1 p.2)
  simpa [sq] using this

/-- **The commutator-with-a-block bound.** -/
theorem fsq_comm_bound {L R : Matrix (ι) (ι) ℝ} {α β : ℝ} (hα : 0 ≤ α) (hβ : 0 ≤ β)
    (hL : ∀ M, fsq (L * M) ≤ α ^ 2 * fsq M) (hR : ∀ M, fsq (M * R) ≤ β ^ 2 * fsq M)
    (M : Matrix (ι) (ι) ℝ) : fsq (L * M - M * R) ≤ (α + β) ^ 2 * fsq M := by
  rw [fsq_sub]
  have h1 := hL M; have h2 := hR M; have hM := fsq_nonneg M
  have hcs := fdot_sq_le (L * M) (M * R)
  have hc : fdot (L * M) (M * R) ^ 2 ≤ (α * β * fsq M) ^ 2 := by
    calc _ ≤ fsq (L * M) * fsq (M * R) := hcs
      _ ≤ (α ^ 2 * fsq M) * (β ^ 2 * fsq M) :=
          mul_le_mul h1 h2 (fsq_nonneg _) (by positivity)
      _ = (α * β * fsq M) ^ 2 := by ring
  have hpos : 0 ≤ α * β * fsq M := by positivity
  have hd : -(α * β * fsq M) ≤ fdot (L * M) (M * R) := by
    by_contra hlt; push Not at hlt
    nlinarith
  nlinarith

/-- **Columnwise operator bound.** -/
theorem fsq_mul_le {B : Matrix (ι) (ι) ℝ} {c : ℝ} (h : ∀ x, nsq (B *ᵥ x) ≤ c * nsq x)
    (M : Matrix (ι) (ι) ℝ) : fsq (B * M) ≤ c * fsq M := by
  rw [fsq_eq_cols, fsq_eq_cols, Finset.mul_sum]
  refine Finset.sum_le_sum fun i _ => ?_
  have e : (fun k => (B * M) k i) = B *ᵥ (fun k => M k i) := by
    funext k; simp [Matrix.mul_apply, Matrix.mulVec, dotProduct]
  rw [e]; exact h _

/-- **The left split** by a symmetric idempotent. -/
theorem fsq_split_left {P : Matrix (ι) (ι) ℝ} (hPt : Pᵀ = P) (hPP : P * P = P)
    (Z : Matrix (ι) (ι) ℝ) : fsq Z = fsq (P * Z) + fsq ((1 - P) * Z) := by
  unfold fsq
  have hQ : (1 - P)ᵀ * (1 - P) = 1 - P := by
    rw [Matrix.transpose_sub, Matrix.transpose_one, hPt, Matrix.sub_mul, Matrix.mul_sub, Matrix.mul_sub,
      Matrix.one_mul, Matrix.mul_one, Matrix.one_mul, hPP]; abel
  rw [Matrix.transpose_mul, Matrix.transpose_mul, show Zᵀ * Pᵀ * (P * Z) = Zᵀ * (Pᵀ * P) * Z by
    simp only [Matrix.mul_assoc], show Zᵀ * (1 - P)ᵀ * ((1 - P) * Z) = Zᵀ * ((1 - P)ᵀ * (1 - P)) * Z by
    simp only [Matrix.mul_assoc], hQ, hPt, hPP, ← Matrix.trace_add, ← Matrix.add_mul, ← Matrix.mul_add,
    add_sub_cancel, Matrix.mul_one]

/-- **The right split.** -/
theorem fsq_split_right {P : Matrix (ι) (ι) ℝ} (hPt : Pᵀ = P) (hPP : P * P = P)
    (Z : Matrix (ι) (ι) ℝ) : fsq Z = fsq (Z * P) + fsq (Z * (1 - P)) := by
  have h := fsq_split_left hPt hPP Zᵀ
  rw [fsq_transpose] at h
  rw [h, ← fsq_transpose (Z * P), ← fsq_transpose (Z * (1 - P)), Matrix.transpose_mul, Matrix.transpose_mul,
    hPt, Matrix.transpose_sub, Matrix.transpose_one, hPt]


/-! ## The top plane of a skew matrix -/

theorem nsq_eq_dot (x : ι → ℝ) : nsq x = x ⬝ᵥ x := by simp [nsq, dotProduct, sq]

theorem vmv_smul_l (c : ℝ) (a b : ι → ℝ) : vecMulVec (c • a) b = c • vecMulVec a b := by
  ext i j; simp [vecMulVec_apply]; ring
theorem vmv_smul_r (c : ℝ) (a b : ι → ℝ) : vecMulVec a (c • b) = c • vecMulVec a b := by
  ext i j; simp [vecMulVec_apply]; ring

theorem skew_self_dot {M : Matrix (ι) (ι) ℝ} (hM : Mᵀ = -M) (x : ι → ℝ) :
    x ⬝ᵥ (M *ᵥ x) = 0 := by
  have h : x ⬝ᵥ (M *ᵥ x) = (Mᵀ *ᵥ x) ⬝ᵥ x := by
    rw [Matrix.dotProduct_mulVec, ← Matrix.mulVec_transpose]
  rw [hM, Matrix.neg_mulVec, neg_dotProduct, dotProduct_comm (M *ᵥ x) x] at h
  linarith

/-- **The top plane.** -/
theorem plane {M : Matrix (ι) (ι) ℝ} (hM : Mᵀ = -M) {u : ι → ℝ} (hu : nsq u = 1)
    (hmax : ∀ x, nsq (M *ᵥ x) ≤ nsq (M *ᵥ u) * nsq x) (hc : 0 < nsq (M *ᵥ u)) :
    ∃ P : Matrix (ι) (ι) ℝ, Pᵀ = P ∧ P * P = P ∧ M * P = P * M ∧
      (M * P)ᵀ * (M * P) = nsq (M *ᵥ u) • P ∧ P.trace = 2 ∧
      (∀ Y : Matrix (ι) (ι) ℝ, Yᵀ = -Y → (M * P) * (P * Y * P) = (P * Y * P) * (M * P)) := by
  set c := nsq (M *ᵥ u) with hcdef
  set σ := Real.sqrt c with hσ
  have hσpos : 0 < σ := Real.sqrt_pos.mpr hc
  have hσ2 : σ ^ 2 = c := Real.sq_sqrt hc.le
  have heig := max_eigen M hu hmax
  have hMM : M *ᵥ (M *ᵥ u) = -(c • u) := by
    rw [hM, Matrix.neg_mulVec] at heig; rw [← heig, neg_neg]
  obtain ⟨w, hw⟩ : ∃ w : ι → ℝ, w = σ⁻¹ • (M *ᵥ u) := ⟨_, rfl⟩
  have hMu : M *ᵥ u = σ • w := by rw [hw, smul_smul, mul_inv_cancel₀ hσpos.ne', one_smul]
  have hMw : M *ᵥ w = -(σ • u) := by
    rw [hw, Matrix.mulVec_smul, hMM, smul_neg, smul_smul, ← hσ2]
    congr 1; congr 1; field_simp
  have huu : u ⬝ᵥ u = 1 := by rw [← nsq_eq_dot]; exact hu
  have hww : w ⬝ᵥ w = 1 := by
    rw [← nsq_eq_dot, hw, nsq_smul, inv_pow, hσ2]; exact inv_mul_cancel₀ hc.ne'
  have huw : u ⬝ᵥ w = 0 := by
    rw [hw, dotProduct_smul, skew_self_dot hM u, smul_zero]
  have hwu : w ⬝ᵥ u = 0 := by rw [dotProduct_comm]; exact huw
  have hvM : ∀ x : ι → ℝ, x ᵥ* M = -(M *ᵥ x) := fun x => by
    rw [← Matrix.mulVec_transpose, hM, Matrix.neg_mulVec]
  refine ⟨vecMulVec u u + vecMulVec w w, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · rw [Matrix.transpose_add, transpose_vecMulVec, transpose_vecMulVec]
  · simp only [Matrix.add_mul, Matrix.mul_add, vecMulVec_mul_vecMulVec, huu, hww, huw, hwu, one_smul,
      zero_smul]
    ext i j; simp [vecMulVec_apply]
  · rw [Matrix.mul_add, Matrix.add_mul, mul_vecMulVec, mul_vecMulVec, vecMulVec_mul, vecMulVec_mul, hvM,
      hvM, hMu, hMw]
    ext i j; simp [vecMulVec_apply]; ring
  · have e : M * (vecMulVec u u + vecMulVec w w) = σ • (vecMulVec w u - vecMulVec u w) := by
      rw [Matrix.mul_add, mul_vecMulVec, mul_vecMulVec, hMu, hMw]
      ext i j; simp [vecMulVec_apply]; ring
    rw [e, Matrix.transpose_smul, Matrix.transpose_sub, transpose_vecMulVec, transpose_vecMulVec,
      Matrix.smul_mul, Matrix.mul_smul, smul_smul]
    simp only [Matrix.sub_mul, Matrix.mul_sub, vecMulVec_mul_vecMulVec, huu, hww, huw, hwu, zero_smul,
      one_smul]
    ext i j; simp [vecMulVec_apply, ← hσ2]
    left; ring
  · rw [Matrix.trace_add, trace_vecMulVec, trace_vecMulVec, huu, hww]; norm_num
  · intro Y hY
    set N := vecMulVec u w - vecMulVec w u
    have hN : M * (vecMulVec u u + vecMulVec w w) = (-σ) • N := by
      rw [Matrix.mul_add, mul_vecMulVec, mul_vecMulVec, hMu, hMw]
      ext i j; simp [N, vecMulVec_apply]; ring
    have hvY : ∀ x : ι → ℝ, x ᵥ* Y = -(Y *ᵥ x) := fun x => by
      rw [← Matrix.mulVec_transpose, hY, Matrix.neg_mulVec]
    have d1 : (u ᵥ* Y) ⬝ᵥ u = 0 := by rw [hvY, neg_dotProduct, dotProduct_comm, skew_self_dot hY, neg_zero]
    have d2 : (w ᵥ* Y) ⬝ᵥ w = 0 := by rw [hvY, neg_dotProduct, dotProduct_comm, skew_self_dot hY, neg_zero]
    have d3 : (u ᵥ* Y) ⬝ᵥ w = u ⬝ᵥ (Y *ᵥ w) := by rw [Matrix.dotProduct_mulVec]
    have d4 : (w ᵥ* Y) ⬝ᵥ u = -(u ⬝ᵥ (Y *ᵥ w)) := by rw [hvY, neg_dotProduct, dotProduct_comm]
    have hPYP : (vecMulVec u u + vecMulVec w w) * Y * (vecMulVec u u + vecMulVec w w)
        = (u ⬝ᵥ (Y *ᵥ w)) • N := by
      simp only [Matrix.add_mul, Matrix.mul_add, vecMulVec_mul, ← Matrix.vecMul_vecMul, vecMul_vecMulVec,
        d1, d2, d3, d4, zero_smul]
      ext i j; simp [N, vecMulVec_apply]; ring
    rw [hN, hPYP, Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_smul, smul_smul, smul_smul,
      mul_comm]


theorem nsq_quad (M : Matrix (ι) (ι) ℝ) (x : ι → ℝ) :
    nsq (M *ᵥ x) = x ⬝ᵥ ((Mᵀ * M) *ᵥ x) := by
  rw [nsq_eq_dot, ← Matrix.mulVec_mulVec, Matrix.dotProduct_mulVec, Matrix.mulVec_transpose, dotProduct_comm]

/-- **L31, the bracket cap, in Frobenius form**: `‖[X,Y]‖_F² ≤ ‖X‖_F² ‖Y‖_F²` for skew `X`, `Y`. -/
theorem cap_frob (X Y : Matrix (ι) (ι) ℝ) (hX : Xᵀ = -X) (hY : Yᵀ = -Y) :
    fsq (X * Y - Y * X) ≤ fsq X * fsq Y := by
  rcases isEmpty_or_nonempty ι with hι | hι
  · simp [fsq, Matrix.trace]
  obtain ⟨u, hu, hmax⟩ := exists_max X
  set c := nsq (X *ᵥ u) with hcdef
  by_cases hc : c = 0
  · have hX0 : X = 0 := by
      ext i j
      have h1 := hmax (Pi.single j 1)
      rw [hc, zero_mul] at h1
      have h2 : nsq (X *ᵥ Pi.single j 1) = 0 := le_antisymm h1 (nsq_nonneg _)
      have h3 := congrFun (nsq_eq_zero h2) i
      rw [Matrix.zero_apply]
      simpa [Matrix.mulVec, dotProduct, Pi.single_apply] using h3
    subst hX0; simp [fsq]
  have hcpos : 0 < c := lt_of_le_of_ne (nsq_nonneg _) (Ne.symm hc)
  obtain ⟨P, hPt, hPP, hXP, hAA, htrP, hcomm⟩ := plane hX hu hmax hcpos
  have hPX : P * X = X * P := hXP.symm
  have hPXM : ∀ M, P * (X * M) = X * (P * M) := fun M => by rw [← Matrix.mul_assoc, hPX, Matrix.mul_assoc]
  have hPPM : ∀ M, P * (P * M) = P * M := fun M => by rw [← Matrix.mul_assoc, hPP]
  have hQt : (1 - P)ᵀ = 1 - P := by rw [Matrix.transpose_sub, Matrix.transpose_one, hPt]
  have hQQ : (1 - P) * (1 - P) = 1 - P := by
    rw [Matrix.sub_mul, Matrix.mul_sub, Matrix.mul_sub, Matrix.one_mul, Matrix.mul_one, Matrix.one_mul, hPP]
    abel
  set A := X * P with hAdef
  set B := X * (1 - P) with hBdef
  have hAt : Aᵀ = -A := by rw [hAdef, Matrix.transpose_mul, hPt, hX, Matrix.mul_neg, hPX]
  have hBt : Bᵀ = -B := by
    rw [hBdef, Matrix.transpose_mul, hQt, hX, Matrix.mul_neg, Matrix.sub_mul, Matrix.mul_sub, Matrix.one_mul,
      Matrix.mul_one, hPX]
  have hAL : ∀ M, fsq (A * M) ≤ c * fsq M := by
    intro M
    have e : fsq (A * M) = c * fsq (P * M) := by
      unfold fsq
      rw [Matrix.transpose_mul, show Mᵀ * Aᵀ * (A * M) = Mᵀ * (Aᵀ * A) * M by simp only [Matrix.mul_assoc],
        hAA, Matrix.mul_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul, Matrix.transpose_mul, hPt,
        show Mᵀ * P * (P * M) = Mᵀ * (P * P) * M by simp only [Matrix.mul_assoc], hPP]
    have hs := fsq_split_left hPt hPP M
    have h0 := fsq_nonneg ((1 - P) * M)
    rw [e]; nlinarith
  have hAR : ∀ M, fsq (M * A) ≤ c * fsq M := by
    intro M
    rw [← fsq_transpose, Matrix.transpose_mul, hAt, Matrix.neg_mul, fsq_neg]
    have := hAL Mᵀ; rwa [fsq_transpose] at this
  obtain ⟨u', hu', hmax'⟩ := exists_max B
  set d := nsq (B *ᵥ u') with hddef
  have hBL : ∀ M, fsq (B * M) ≤ d * fsq M := fun M => fsq_mul_le hmax' M
  have hBR : ∀ M, fsq (M * B) ≤ d * fsq M := by
    intro M
    rw [← fsq_transpose, Matrix.transpose_mul, hBt, Matrix.neg_mul, fsq_neg]
    have := hBL Mᵀ; rwa [fsq_transpose] at this
  have hd0 : 0 ≤ d := nsq_nonneg _
  have hdc : d ≤ c := by
    have e : B *ᵥ u' = X *ᵥ ((1 - P) *ᵥ u') := by rw [hBdef, Matrix.mulVec_mulVec]
    have h1 := hmax ((1 - P) *ᵥ u')
    have h2 : nsq ((1 - P) *ᵥ u') ≤ 1 := by
      have hsplit : nsq u' = nsq (P *ᵥ u') + nsq ((1 - P) *ᵥ u') := by
        rw [nsq_quad, nsq_quad, hQt, hQQ, hPt, hPP, ← dotProduct_add, ← Matrix.add_mulVec, add_sub_cancel,
          Matrix.one_mulVec, nsq_eq_dot]
      have := nsq_nonneg (P *ᵥ u')
      linarith
    rw [hddef, e]
    nlinarith
  have hfB : 2 * d ≤ fsq B := by
    by_cases hd : d = 0
    · rw [hd]; simpa using fsq_nonneg B
    · obtain ⟨P', hP't, hP'P', -, hBB', htrP', -⟩ := plane hBt hu' hmax' (lt_of_le_of_ne hd0 (Ne.symm hd))
      have hs := fsq_split_right hP't hP'P' B
      have e : fsq (B * P') = d * 2 := by unfold fsq; rw [hBB', Matrix.trace_smul, htrP', smul_eq_mul]
      have := fsq_nonneg (B * (1 - P'))
      linarith
  have hfX : fsq X = 2 * c + fsq B := by
    have hs := fsq_split_right hPt hPP X
    have e : fsq (X * P) = c * 2 := by unfold fsq; rw [hAA, Matrix.trace_smul, htrP, smul_eq_mul]
    rw [hs, e]; ring
  set Z := X * Y - Y * X with hZ
  have hZs : fsq Z = fsq (P * Z * P) + fsq (P * Z * (1 - P)) + fsq ((1 - P) * Z * P)
      + fsq ((1 - P) * Z * (1 - P)) := by
    rw [fsq_split_left hPt hPP Z, fsq_split_right hPt hPP (P * Z), fsq_split_right hPt hPP ((1 - P) * Z)]
    ring
  have hYs : fsq Y = fsq (P * Y * P) + fsq (P * Y * (1 - P)) + fsq ((1 - P) * Y * P)
      + fsq ((1 - P) * Y * (1 - P)) := by
    rw [fsq_split_left hPt hPP Y, fsq_split_right hPt hPP (P * Y), fsq_split_right hPt hPP ((1 - P) * Y)]
    ring
  have b1 : P * Z * P = 0 := by
    have c1 : P * Z * P = A * (P * Y * P) - (P * Y * P) * A := by
      simp only [hZ, hAdef, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_assoc, hPXM, hPX, hPP, hPPM]
    rw [c1, hcomm Y hY, sub_self]
  have b2 : P * Z * (1 - P) = A * (P * Y * (1 - P)) - (P * Y * (1 - P)) * B := by
    simp only [hZ, hAdef, hBdef, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_one, Matrix.one_mul,
      Matrix.mul_assoc, hPXM, hPX, hPP, hPPM]
    abel
  have b3 : (1 - P) * Z * P = B * ((1 - P) * Y * P) - ((1 - P) * Y * P) * A := by
    simp only [hZ, hAdef, hBdef, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_one, Matrix.one_mul,
      Matrix.mul_assoc, hPXM, hPX, hPP, hPPM]
    abel
  have b4 : (1 - P) * Z * (1 - P) = B * ((1 - P) * Y * (1 - P)) - ((1 - P) * Y * (1 - P)) * B := by
    simp only [hZ, hAdef, hBdef, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_one, Matrix.one_mul,
      Matrix.mul_assoc, hPXM, hPX, hPP, hPPM]
    abel
  set sc := Real.sqrt c
  set sd := Real.sqrt d
  have hsc2 : sc ^ 2 = c := Real.sq_sqrt hcpos.le
  have hsd2 : sd ^ 2 = d := Real.sq_sqrt hd0
  have hsc0 : 0 ≤ sc := Real.sqrt_nonneg _
  have hsd0 : 0 ≤ sd := Real.sqrt_nonneg _
  have hsdc : sd ≤ sc := Real.sqrt_le_sqrt hdc
  have hAL' : ∀ M, fsq (A * M) ≤ sc ^ 2 * fsq M := fun M => by rw [hsc2]; exact hAL M
  have hAR' : ∀ M, fsq (M * A) ≤ sc ^ 2 * fsq M := fun M => by rw [hsc2]; exact hAR M
  have hBL' : ∀ M, fsq (B * M) ≤ sd ^ 2 * fsq M := fun M => by rw [hsd2]; exact hBL M
  have hBR' : ∀ M, fsq (M * B) ≤ sd ^ 2 * fsq M := fun M => by rw [hsd2]; exact hBR M
  have k2 := fsq_comm_bound hsc0 hsd0 hAL' hBR' (P * Y * (1 - P))
  have k3 := fsq_comm_bound hsd0 hsc0 hBL' hAR' ((1 - P) * Y * P)
  have k4 := fsq_comm_bound hsd0 hsd0 hBL' hBR' ((1 - P) * Y * (1 - P))
  rw [← b2] at k2; rw [← b3] at k3; rw [← b4] at k4
  have hK : (sc + sd) ^ 2 ≤ fsq X := by nlinarith [sq_nonneg (sc - sd)]
  have hq4 : (sd + sd) ^ 2 ≤ (sc + sd) ^ 2 := by nlinarith
  have p1 := fsq_nonneg (P * Y * P)
  have p2 := fsq_nonneg (P * Y * (1 - P))
  have p3 := fsq_nonneg ((1 - P) * Y * P)
  have p4 := fsq_nonneg ((1 - P) * Y * (1 - P))
  have hZle : fsq Z ≤ (sc + sd) ^ 2 * fsq Y := by
    rw [hZs, b1, hYs]
    have z0 : fsq (0 : Matrix (ι) (ι) ℝ) = 0 := by simp [fsq]
    rw [z0]
    nlinarith [mul_le_mul_of_nonneg_right hq4 p4]
  calc fsq Z ≤ (sc + sd) ^ 2 * fsq Y := hZle
    _ ≤ fsq X * fsq Y := mul_le_mul_of_nonneg_right hK (fsq_nonneg Y)

end Proof

open HamiltonsCubic.RealLayer

/-- **L31, the bracket cap.** For skew `X`, `Y` on `ℝⁿ`, `‖[X,Y]‖² ≤ 2 ‖X‖² ‖Y‖²` in the record's
`Λ²` norm, so `‖[X,Y]‖² ≤ 2` at unit `X` and `Y`. -/
theorem L31_cap {ι : Type*} [Fintype ι] [DecidableEq ι] (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    inner2 (br X Y) (br X Y) ≤ 2 * inner2 X X * inner2 Y Y := by
  have h := Proof.cap_frob X Y hX hY
  unfold Proof.fsq at h
  unfold inner2 br
  nlinarith [h]

/-- **At unit norms the cap is the record's display.** -/
theorem L31_cap_unit {ι : Type*} [Fintype ι] [DecidableEq ι] (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y)
    (hXn : inner2 X X = 1) (hYn : inner2 Y Y = 1) : inner2 (br X Y) (br X Y) ≤ 2 := by
  have := L31_cap X Y hX hY
  rw [hXn, hYn] at this
  linarith

end HamiltonsCubic.L31Statement
