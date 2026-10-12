import Mathlib
import HamiltonsCubic.Results.L31Statement

/-!
# L31, the bracket cap's equality case, both directions

[findings/stratum-two-negative.md](../../../findings/stratum-two-negative.md), Lemma L31: for unit
skew `X`, `Y`, `‖[X,Y]‖² = 2` iff `XY = −YX`, both have rank `4` with all nonzero singular values
`1/√2`, and `im X = im Y`.

`cap_frob_chain` re-runs [L31Statement.lean](L31Statement.lean)'s `cap_frob` and returns its
intermediate facts: a rank-two `X`-invariant projection `P` with `(XP)ᵀ(XP) = c P` (`c` the top
squared singular value), the operator bound `d ≤ c` of `X(1 − P)`, the mass split
`‖X‖_F² = 2c + ‖X(1−P)‖_F²` with `‖X(1−P)‖_F² ≥ 2d`, and `‖[X,Y]‖_F² ≤ (√c + √d)² ‖Y‖_F²`.
**`cap_eq_rank`**: at equality `‖[X,Y]‖_F² = ‖X‖_F² ‖Y‖_F²` with `Y ≠ 0`, `c = d` and
`‖X(1−P)‖_F² = 2c`, so `X` carries exactly two singular pairs, both at `√c`, all its mass
(`‖X‖_F² = 4c`): the rank-four, equal-singular-value half of the equality case.

**`cap_eq_rank4`, the rank-four form**: at equality there is a symmetric idempotent `Q = P + P'` of
trace `4` with `X Q = X` and `Xᵀ X = c Q`, so `X` has rank four and all four nonzero singular values
equal `√c`. *The second plane `P'` is `plane` applied to `X(1−P)` at its maximiser, which the chain
now exports; `‖X(1−P)‖_F² = 2c` leaves no mass off `P'`, and `P P' = 0` because
`P (X(1−P))ᵀ = 0`.*

**`cap_eq_rank4_right`** gives the same for `Y` by swapping the arguments.

**`cap_eq_anticomm`** gives `XY = −YX` (the Cauchy–Schwarz step behind `fsq_comm_bound` is tight
with the negative sign), **`cap_eq_common_image`** one trace-4 projection carrying both `XᵀX` and
`YᵀY`, and **`cap_eq_converse`** the other direction, so L31's equality case is typed in full
([r1402](../../../reviews/REVIEW_r1402.md)).
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L31Statement.Proof

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem cap_frob_chain [Nonempty ι] (X Y : Matrix ι ι ℝ) (hX : Xᵀ = -X) (hY : Yᵀ = -Y)
    (hXpos : 0 < fsq X) :
    ∃ (c d : ℝ) (P : Matrix ι ι ℝ), Pᵀ = P ∧ P * P = P ∧ P.trace = 2 ∧ X * P = P * X ∧
      (X * P)ᵀ * (X * P) = c • P ∧ 0 < c ∧ (∀ x, nsq (X *ᵥ x) ≤ c * nsq x) ∧
      (∀ x, nsq ((X * (1 - P)) *ᵥ x) ≤ d * nsq x) ∧
      (∃ u' : ι → ℝ, nsq u' = 1 ∧ nsq ((X * (1 - P)) *ᵥ u') = d) ∧ 0 ≤ d ∧ d ≤ c ∧
      2 * d ≤ fsq (X * (1 - P)) ∧ fsq X = 2 * c + fsq (X * (1 - P)) ∧
      fsq (X * Y - Y * X) ≤ (Real.sqrt c + Real.sqrt d) ^ 2 * fsq Y := by
  obtain ⟨u, hu, hmax⟩ := exists_max X
  set c := nsq (X *ᵥ u) with hcdef
  have hc : c ≠ 0 := by
    intro hc
    have hX0 : X = 0 := by
      ext i j
      have h1 := hmax (Pi.single j 1)
      rw [hc, zero_mul] at h1
      have h2 : nsq (X *ᵥ Pi.single j 1) = 0 := le_antisymm h1 (nsq_nonneg _)
      have h3 := congrFun (nsq_eq_zero h2) i
      rw [Matrix.zero_apply]
      simpa [Matrix.mulVec, dotProduct, Pi.single_apply] using h3
    rw [hX0] at hXpos; simp [fsq] at hXpos
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
  refine ⟨c, d, P, hPt, hPP, htrP, hXP, hAA, hcpos, fun x => ?_, hmax', ⟨u', hu', rfl⟩, hd0, hdc, hfB,
    hfX, hZle⟩
  exact hmax x

/-- **The rank half of L31's equality case.** -/
theorem cap_eq_rank [Nonempty ι] (X Y : Matrix ι ι ℝ) (hX : Xᵀ = -X) (hY : Yᵀ = -Y)
    (hXpos : 0 < fsq X) (hYpos : 0 < fsq Y) (heq : fsq (X * Y - Y * X) = fsq X * fsq Y) :
    ∃ (c : ℝ) (P : Matrix ι ι ℝ), Pᵀ = P ∧ P * P = P ∧ P.trace = 2 ∧ X * P = P * X ∧
      (X * P)ᵀ * (X * P) = c • P ∧ 0 < c ∧ (∀ x, nsq (X *ᵥ x) ≤ c * nsq x) ∧
      (∀ x, nsq ((X * (1 - P)) *ᵥ x) ≤ c * nsq x) ∧
      (∃ u' : ι → ℝ, nsq u' = 1 ∧ nsq ((X * (1 - P)) *ᵥ u') = c) ∧
      fsq (X * (1 - P)) = 2 * c ∧ fsq X = 4 * c := by
  obtain ⟨c, d, P, hPt, hPP, htr, hXP, hAA, hc, hop, hopB, hu', hd0, hdc, hfB, hfX, hZ⟩ :=
    cap_frob_chain X Y hX hY hXpos
  have hsc := Real.sq_sqrt hc.le
  have hsd := Real.sq_sqrt hd0
  have hsc0 := Real.sqrt_nonneg c
  have hsd0 := Real.sqrt_nonneg d
  -- fsq X ≤ (√c + √d)² from equality, and (√c + √d)² ≤ 2c + 2d ≤ fsq X
  have h1 : fsq X ≤ (Real.sqrt c + Real.sqrt d) ^ 2 := by
    have : fsq X * fsq Y ≤ (Real.sqrt c + Real.sqrt d) ^ 2 * fsq Y := heq ▸ hZ
    exact le_of_mul_le_mul_right this hYpos
  have h2 : (Real.sqrt c - Real.sqrt d) ^ 2 ≤ 0 := by nlinarith
  have hcd : Real.sqrt c = Real.sqrt d := by nlinarith [sq_nonneg (Real.sqrt c - Real.sqrt d)]
  have hcd' : c = d := by rw [← hsc, ← hsd, hcd]
  subst hcd'
  refine ⟨c, P, hPt, hPP, htr, hXP, hAA, hc, hop, hopB, hu', ?_, ?_⟩ <;> nlinarith

/-- A matrix of zero Frobenius mass is zero. -/
theorem fsq_eq_zero {M : Matrix ι ι ℝ} (h : fsq M = 0) : M = 0 := by
  rw [fsq_eq_cols] at h
  have hc : ∀ i ∈ (Finset.univ : Finset ι), nsq (fun k => M k i) = 0 :=
    (Finset.sum_eq_zero_iff_of_nonneg fun i _ => nsq_nonneg _).mp h
  ext k i
  have := congrFun (nsq_eq_zero (hc i (Finset.mem_univ _))) k
  simpa using this

set_option maxHeartbeats 2000000 in
/-- **The rank-four half of L31's equality case.** At `‖[X,Y]‖_F² = ‖X‖_F² ‖Y‖_F²` with `X`, `Y`
nonzero and skew, there is a symmetric idempotent `Q` of trace `4` with `X Q = X` and
`Xᵀ X = c Q`: `X` has rank four and all four nonzero singular values equal `√c`. -/
theorem cap_eq_rank4 [Nonempty ι] (X Y : Matrix ι ι ℝ) (hX : Xᵀ = -X) (hY : Yᵀ = -Y)
    (hXpos : 0 < fsq X) (hYpos : 0 < fsq Y) (heq : fsq (X * Y - Y * X) = fsq X * fsq Y) :
    ∃ (c : ℝ) (Q : Matrix ι ι ℝ), Qᵀ = Q ∧ Q * Q = Q ∧ Q.trace = 4 ∧ X * Q = X ∧
      Xᵀ * X = c • Q ∧ 0 < c ∧ fsq X = 4 * c := by
  obtain ⟨c, P, hPt, hPP, htr, hXP, hAA, hc, -, hopB, ⟨u', hu', hu'c⟩, hfB, hfX⟩ :=
    cap_eq_rank X Y hX hY hXpos hYpos heq
  have hPX : P * X = X * P := hXP.symm
  have hQt : (1 - P)ᵀ = 1 - P := by rw [Matrix.transpose_sub, Matrix.transpose_one, hPt]
  set B := X * (1 - P) with hBdef
  have hBt : Bᵀ = -B := by
    rw [hBdef, Matrix.transpose_mul, hQt, hX, Matrix.mul_neg, Matrix.sub_mul, Matrix.mul_sub,
      Matrix.one_mul, Matrix.mul_one, hPX]
  have hmax' : ∀ x, nsq (B *ᵥ x) ≤ nsq (B *ᵥ u') * nsq x := fun x => by rw [hu'c]; exact hopB x
  obtain ⟨P', hP't, hP'P', hBP', hBB', htr', -⟩ := plane hBt hu' hmax' (by rw [hu'c]; exact hc)
  rw [hu'c] at hBB'
  -- the remainder off the second plane has no mass
  have hsplit := fsq_split_right hP't hP'P' B
  have e2 : fsq (B * P') = c * 2 := by
    unfold fsq; rw [hBB', Matrix.trace_smul, htr', smul_eq_mul]
  have hrem : B * (1 - P') = 0 := fsq_eq_zero (by linarith)
  have hBeq : B = B * P' := by
    have : B * (1 - P') = B - B * P' := by rw [Matrix.mul_sub, Matrix.mul_one]
    rw [this] at hrem; exact (sub_eq_zero.mp hrem)
  -- the two planes are orthogonal: P Bᵀ = 0, and P' = c⁻¹ Bᵀ P' B P'
  have hPB : P * Bᵀ = 0 := by
    rw [hBt, Matrix.mul_neg, hBdef, ← Matrix.mul_assoc, hPX, Matrix.mul_assoc, Matrix.mul_sub,
      Matrix.mul_one, hPP, sub_self, Matrix.mul_zero, neg_zero]
  have hPP' : P * P' = 0 := by
    have hBtP' : P' * Bᵀ = Bᵀ * P' := by
      rw [hBt, Matrix.mul_neg, Matrix.neg_mul, hBP']
    have e : (B * P')ᵀ * (B * P') = Bᵀ * (P' * (B * P')) := by
      rw [Matrix.transpose_mul, hP't, hBtP', Matrix.mul_assoc]
    have h0 : P * ((B * P')ᵀ * (B * P')) = 0 := by
      rw [e, ← Matrix.mul_assoc, hPB, Matrix.zero_mul]
    rw [hBB', Matrix.mul_smul] at h0
    exact (smul_eq_zero.mp h0).resolve_left hc.ne'
  have hP'P : P' * P = 0 := by
    have := congrArg Matrix.transpose hPP'
    rwa [Matrix.transpose_mul, hPt, hP't, Matrix.transpose_zero] at this
  have hXP' : X * P' = B * P' := by
    rw [hBdef, Matrix.mul_assoc, Matrix.sub_mul, Matrix.one_mul, hPP', sub_zero]
  refine ⟨c, P + P', ?_, ?_, ?_, ?_, ?_, hc, by linarith⟩
  · rw [Matrix.transpose_add, hPt, hP't]
  · rw [Matrix.add_mul, Matrix.mul_add, Matrix.mul_add, hPP, hP'P', hPP', hP'P, add_zero, zero_add]
  · rw [Matrix.trace_add, htr, htr']; norm_num
  · rw [Matrix.mul_add, hXP', ← hBeq, hBdef, Matrix.mul_sub, Matrix.mul_one]; abel
  · have hXdec : X = X * P + X * P' := by
      rw [hXP', ← hBeq, hBdef, Matrix.mul_sub, Matrix.mul_one]; abel
    have hcross : (X * P)ᵀ * (X * P') = 0 := by
      rw [Matrix.transpose_mul, hPt, hX, show P * -X * (X * P') = -(P * X * X * P') by
        simp only [Matrix.mul_neg, Matrix.neg_mul, Matrix.mul_assoc]]
      rw [show P * X * X * P' = X * X * (P * P') by
        rw [hPX, Matrix.mul_assoc X P X, hPX]; simp only [Matrix.mul_assoc]]
      rw [hPP', Matrix.mul_zero, neg_zero]
    have hcross' : (X * P')ᵀ * (X * P) = 0 := by
      have := congrArg Matrix.transpose hcross
      rwa [Matrix.transpose_mul, Matrix.transpose_transpose, Matrix.transpose_zero] at this
    have hB2 : (X * P')ᵀ * (X * P') = c • P' := by rw [hXP', hBB']
    conv_lhs => rw [hXdec]
    rw [Matrix.transpose_add, Matrix.add_mul, Matrix.mul_add, Matrix.mul_add, hAA, hcross, hcross',
      hB2, add_zero, zero_add, smul_add]

/-- **And the same for `Y`**, by the symmetry of the equality in its two arguments: `[Y,X] = −[X,Y]`
has the same Frobenius mass, so `cap_eq_rank4` applies with the roles swapped
([r1193](../../../reviews/REVIEW_r1193.md)). -/
theorem cap_eq_rank4_right [Nonempty ι] (X Y : Matrix ι ι ℝ) (hX : Xᵀ = -X) (hY : Yᵀ = -Y)
    (hXpos : 0 < fsq X) (hYpos : 0 < fsq Y) (heq : fsq (X * Y - Y * X) = fsq X * fsq Y) :
    ∃ (c : ℝ) (Q : Matrix ι ι ℝ), Qᵀ = Q ∧ Q * Q = Q ∧ Q.trace = 4 ∧ Y * Q = Y ∧
      Yᵀ * Y = c • Q ∧ 0 < c ∧ fsq Y = 4 * c := by
  have heq' : fsq (Y * X - X * Y) = fsq Y * fsq X := by
    rw [show Y * X - X * Y = -(X * Y - Y * X) by abel, fsq_neg, heq, mul_comm]
  exact cap_eq_rank4 Y X hY hX hYpos hXpos heq'

set_option maxHeartbeats 2000000 in
/-- **The anticommutation half of L31's equality case.** At `‖[X,Y]‖_F² = ‖X‖_F² ‖Y‖_F²` with `X`,
`Y` nonzero and skew, `XY = −YX`. *With `XᵀX = cQ` from `cap_eq_rank4`, `‖XY‖_F²` and `‖YX‖_F²` are
each at most `c‖Y‖_F²`, and `‖X‖_F² = 4c`, so the Cauchy–Schwarz step behind `fsq_comm_bound` is
tight with the negative sign: `⟨XY, YX⟩ = −c‖Y‖_F²` and `‖XY + YX‖_F² = 0`.* -/
theorem cap_eq_anticomm [Nonempty ι] (X Y : Matrix ι ι ℝ) (hX : Xᵀ = -X) (hY : Yᵀ = -Y)
    (hXpos : 0 < fsq X) (hYpos : 0 < fsq Y) (heq : fsq (X * Y - Y * X) = fsq X * fsq Y) :
    X * Y = -(Y * X) := by
  obtain ⟨c, Q, hQt, hQQ, -, -, hXX, hc, hfX⟩ := cap_eq_rank4 X Y hX hY hXpos hYpos heq
  -- `X` acts with operator norm `√c` from both sides
  have hL : ∀ M, fsq (X * M) ≤ c * fsq M := by
    intro M
    have e : fsq (X * M) = c * fsq (Q * M) := by
      unfold fsq
      rw [Matrix.transpose_mul, show Mᵀ * Xᵀ * (X * M) = Mᵀ * (Xᵀ * X) * M by
        simp only [Matrix.mul_assoc], hXX, Matrix.mul_smul, Matrix.smul_mul, Matrix.trace_smul,
        smul_eq_mul, Matrix.transpose_mul, hQt,
        show Mᵀ * Q * (Q * M) = Mᵀ * (Q * Q) * M by simp only [Matrix.mul_assoc], hQQ]
    have hs := fsq_split_left hQt hQQ M
    have h0 := fsq_nonneg ((1 - Q) * M)
    rw [e]; nlinarith
  have hR : ∀ M, fsq (M * X) ≤ c * fsq M := by
    intro M
    rw [← fsq_transpose, Matrix.transpose_mul, hX, Matrix.neg_mul, fsq_neg]
    have := hL Mᵀ; rwa [fsq_transpose] at this
  set F := fsq Y with hF
  set a := fsq (X * Y) with ha
  set b := fsq (Y * X) with hb
  set d := fdot (X * Y) (Y * X) with hd
  have hab : a ≤ c * F := hL Y
  have hbb : b ≤ c * F := hR Y
  have hcs : d ^ 2 ≤ a * b := fdot_sq_le _ _
  have ha0 : 0 ≤ a := fsq_nonneg _
  have hb0 : 0 ≤ b := fsq_nonneg _
  have hmain : a + b - 2 * d = 4 * c * F := by
    have := fsq_sub (X * Y) (Y * X)
    rw [heq, hfX] at this; linarith
  have hcF : 0 ≤ c * F := by positivity
  have hdd : -d ≤ c * F := by
    have hsq : d ^ 2 ≤ (c * F) ^ 2 := by nlinarith [mul_le_mul hab hbb hb0 hcF]
    nlinarith [sq_nonneg (d + c * F), sq_nonneg (d - c * F)]
  have hplus : fsq (X * Y + Y * X) = 0 := by
    have e : X * Y + Y * X = X * Y - -(Y * X) := by abel
    have hdn : fdot (X * Y) (-(Y * X)) = -d := by
      rw [hd]; unfold fdot; rw [Matrix.mul_neg, Matrix.trace_neg]
    rw [e, fsq_sub, fsq_neg, hdn]
    nlinarith
  have h0 := fsq_eq_zero hplus
  exact eq_neg_of_add_eq_zero_left h0

set_option maxHeartbeats 4000000 in
/-- **The common image, L31's last clause.** At equality one symmetric idempotent `Q` of trace `4`
carries both: `XᵀX = cQ` and `YᵀY = c'Q`, so `X` and `Y` have the same four-dimensional image,
with equal nonzero singular values each. *The same tightness as `cap_eq_anticomm` gives
`‖YX‖_F² = c‖Y‖_F²`, which is `c‖YQ‖_F²`, so `Y = YQ`; `Y`'s own projection `Q'` then satisfies
`Q'Q = Q'` at trace `4`, and `‖Q − Q'‖_F² = 4 − 2·4 + 4 = 0`.* -/
theorem cap_eq_common_image [Nonempty ι] (X Y : Matrix ι ι ℝ) (hX : Xᵀ = -X) (hY : Yᵀ = -Y)
    (hXpos : 0 < fsq X) (hYpos : 0 < fsq Y) (heq : fsq (X * Y - Y * X) = fsq X * fsq Y) :
    ∃ (c c' : ℝ) (Q : Matrix ι ι ℝ), Qᵀ = Q ∧ Q * Q = Q ∧ Q.trace = 4 ∧
      Xᵀ * X = c • Q ∧ Yᵀ * Y = c' • Q ∧ 0 < c ∧ 0 < c' := by
  obtain ⟨c, Q, hQt, hQQ, htr, -, hXX, hc, hfX⟩ := cap_eq_rank4 X Y hX hY hXpos hYpos heq
  obtain ⟨c', Q', hQ't, hQ'Q', htr', -, hYY, hc', -⟩ := cap_eq_rank4_right X Y hX hY hXpos hYpos heq
  have hXXt : X * Xᵀ = c • Q := by
    rw [hX, Matrix.mul_neg, ← Matrix.neg_mul, ← hX, hXX]
  -- `‖M X‖² = c ‖M Q‖²`
  have hRe : ∀ M, fsq (M * X) = c * fsq (M * Q) := by
    intro M
    unfold fsq
    rw [Matrix.transpose_mul, Matrix.transpose_mul,
      show Xᵀ * Mᵀ * (M * X) = Xᵀ * (Mᵀ * M * X) by simp only [Matrix.mul_assoc],
      Matrix.trace_mul_comm, show Mᵀ * M * X * Xᵀ = Mᵀ * M * (X * Xᵀ) by simp only [Matrix.mul_assoc],
      hXXt, Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul, hQt,
      show Q * Mᵀ * (M * Q) = Q * (Mᵀ * M * Q) by simp only [Matrix.mul_assoc],
      Matrix.trace_mul_comm Q, show Mᵀ * M * Q * Q = Mᵀ * M * (Q * Q) by simp only [Matrix.mul_assoc],
      hQQ, Matrix.mul_assoc]
  have hL : ∀ M, fsq (X * M) ≤ c * fsq M := by
    intro M
    have := hRe Mᵀ
    rw [← fsq_transpose (X * M), Matrix.transpose_mul, hX, Matrix.mul_neg, fsq_neg]
    rw [this]
    have hs := fsq_split_right hQt hQQ Mᵀ
    have h0 := fsq_nonneg (Mᵀ * (1 - Q))
    rw [fsq_transpose] at hs; nlinarith
  set F := fsq Y
  set a := fsq (X * Y)
  set b := fsq (Y * X)
  set d := fdot (X * Y) (Y * X)
  have hsplit := fsq_split_right hQt hQQ Y
  have hbQ : b = c * fsq (Y * Q) := hRe Y
  have hab : a ≤ c * F := hL Y
  have hbb : b ≤ c * F := by
    rw [hbQ]; have := fsq_nonneg (Y * (1 - Q)); nlinarith
  have hcs : d ^ 2 ≤ a * b := fdot_sq_le _ _
  have hb0 : 0 ≤ b := fsq_nonneg _
  have hmain : a + b - 2 * d = 4 * c * F := by
    have := fsq_sub (X * Y) (Y * X); rw [heq, hfX] at this; linarith
  have hcF : 0 ≤ c * F := by positivity
  have hbeq : b = c * F := by
    have hsq : d ^ 2 ≤ (c * F) ^ 2 := by nlinarith [mul_le_mul hab hbb hb0 hcF]
    nlinarith [sq_nonneg (d + c * F), sq_nonneg (d - c * F)]
  -- so `Y (1 − Q) = 0`
  have hYQ : Y * Q = Y := by
    have h0 : fsq (Y * (1 - Q)) = 0 := by
      have : c * fsq (Y * Q) = c * F := by rw [← hbQ, hbeq]
      have : fsq (Y * Q) = F := mul_left_cancel₀ hc.ne' this
      linarith
    have := fsq_eq_zero h0
    rw [Matrix.mul_sub, Matrix.mul_one] at this
    exact (sub_eq_zero.mp this).symm
  -- `Q' Q = Q'`, both trace 4, hence equal
  have hQ'Q : Q' * Q = Q' := by
    have e : c' • (Q' * Q) = c' • Q' := by
      rw [← Matrix.smul_mul, ← hYY, Matrix.mul_assoc, hYQ]
    exact smul_right_injective _ hc'.ne' e
  have hQQ' : Q * Q' = Q' := by
    have := congrArg Matrix.transpose hQ'Q
    rwa [Matrix.transpose_mul, hQt, hQ't] at this
  have hzero : fsq (Q - Q') = 0 := by
    rw [fsq_sub]
    unfold fsq fdot
    rw [hQt, hQ't, hQQ, hQ'Q', hQQ', htr, htr']
    norm_num
  have hEq : Q = Q' := sub_eq_zero.mp (fsq_eq_zero hzero)
  exact ⟨c, c', Q, hQt, hQQ, htr, hXX, by rw [hEq]; exact hYY, hc, hc'⟩

/-- **The converse, closing L31's equality case.** If `X` and `Y` anticommute and one symmetric
idempotent `Q` of trace `4` carries both, `XᵀX = cQ` and `YᵀY = c'Q`, then
`‖[X,Y]‖_F² = ‖X‖_F² ‖Y‖_F²`. *`[X,Y] = 2XY`, `‖XY‖_F² = c‖QY‖_F²`, and `YᵀY = c'Q` forces
`Y = QY`, so `‖[X,Y]‖_F² = 4c‖Y‖_F²` while `‖X‖_F² = c · tr Q = 4c`.* -/
theorem cap_eq_converse (X Y Q : Matrix ι ι ℝ) (c c' : ℝ) (hY : Yᵀ = -Y)
    (hQt : Qᵀ = Q) (hQQ : Q * Q = Q) (htr : Q.trace = 4)
    (hXX : Xᵀ * X = c • Q) (hYY : Yᵀ * Y = c' • Q)
    (hanti : X * Y = -(Y * X)) :
    fsq (X * Y - Y * X) = fsq X * fsq Y := by
  -- `Y = Y Q`, then `Y = Q Y`
  have hYQ : Y * Q = Y := by
    have h0 : fsq (Y * (1 - Q)) = 0 := by
      unfold fsq
      rw [Matrix.transpose_mul, show (1 - Q)ᵀ * Yᵀ * (Y * (1 - Q)) = (1 - Q)ᵀ * (Yᵀ * Y) * (1 - Q) by
        simp only [Matrix.mul_assoc], hYY, Matrix.mul_smul, Matrix.smul_mul, Matrix.trace_smul,
        Matrix.transpose_sub, Matrix.transpose_one, hQt, Matrix.sub_mul, Matrix.one_mul, hQQ,
        sub_self, Matrix.zero_mul, Matrix.trace_zero, smul_zero]
    have := fsq_eq_zero h0
    rw [Matrix.mul_sub, Matrix.mul_one] at this
    exact (sub_eq_zero.mp this).symm
  have hQY : Q * Y = Y := by
    have := congrArg Matrix.transpose hYQ
    rw [Matrix.transpose_mul, hY, hQt, Matrix.mul_neg] at this
    exact neg_injective this
  have hcomm : X * Y - Y * X = (2 : ℝ) • (X * Y) := by
    rw [hanti, two_smul]; abel
  have hXY : fsq (X * Y) = c * fsq Y := by
    unfold fsq
    rw [Matrix.transpose_mul, show Yᵀ * Xᵀ * (X * Y) = Yᵀ * (Xᵀ * X) * Y by
      simp only [Matrix.mul_assoc], hXX, Matrix.mul_smul, Matrix.smul_mul, Matrix.trace_smul,
      smul_eq_mul, Matrix.mul_assoc, hQY]
  have hfX : fsq X = 4 * c := by
    unfold fsq; rw [hXX, Matrix.trace_smul, htr, smul_eq_mul]; ring
  rw [hcomm]
  have e : fsq ((2 : ℝ) • (X * Y)) = 4 * fsq (X * Y) := by
    unfold fsq; rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.mul_smul, Matrix.trace_smul,
      Matrix.trace_smul, smul_eq_mul, smul_eq_mul]; ring
  rw [e, hXY, hfX]; ring

end HamiltonsCubic.L31Statement.Proof
