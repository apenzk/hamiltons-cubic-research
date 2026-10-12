import HamiltonsCubic.Base.WeylReal

/-!
# The `𝔰𝔬(n)` structure constants, and the `#` anchor

**Why this file exists.** Three places in the layer are blocked on one fact, the bracket of two
basis bivectors, and none of them could name it: [L68](../Results/L68Statement.lean)'s commutator
identification, [L99](../Results/L99Statement.lean)'s `indicator_eigen`, and the record's own
mandated check on any `#` formula, `id# = (n-2)·id`.

**That check matters more than the other two.** [WeylReal.lean](WeylReal.lean)'s
`Pcubic_eq_inner_Qop` is a tautology, `sharpPair` is defined as the pairing against `sharpOp`, so
the identity cannot fail for any `R`, wrong normalisation included. *So the `#` normalisation in
that file has no check at all*, and everything the layer says about `P` and `θ` rests on it.
[Sharp.lean](Sharp.lean) anchors the `ℚ` layer at `n = 4` IN THE KERNEL, `sharpQF_one_basis`, *which was `native_decide` until 2026-09-20*.

**THE ANCHOR IS STATED AND PROVED HERE**, as `sharpOp_id`: `id# X = (n-2)·X` at every bivector `X`
and every `n`, over `ℝ`, from the three standard axioms alone. *So the `-¼` over ordered pairs in
`sharpQF` IS the record's normalisation, held by a check rather than by a coincidence of shape.*

**The route is the Killing form, reached without naming it.** `sum_inner2_conj` evaluates
`∑ ⟨A φᵢⱼ B, φᵢⱼ⟩` as `tr(A)tr(B) - tr(ABᵀ)` for arbitrary `A, B`; `ad_X ad_Y` is four such
conjugations, and summing them gives `2(n-2) tr(XY)`, which is `𝔰𝔬(n)`'s `B(X,Y) = (n-2) tr(XY)`
with the ordered-pair doubling. *The `φ` family enters only through that one conjugation sum, so no
case split on index coincidences is needed anywhere in the chain.*
-/

set_option linter.style.longLine false
set_option maxHeartbeats 2000000

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The `𝔰𝔬(n)` structure constants.** With `φ_ij = E_ji - E_ij`,

`[φ_ab, φ_cd] = δ_ac φ_bd + δ_bd φ_ac - δ_ad φ_bc - δ_bc φ_ad`.

*Every index coincidence is carried by the four Kronecker deltas, so the special cases the record
reasons with, `[φ_ab, φ_bd] = -φ_ad`, `[φ_ab, φ_ad] = φ_bd`, and vanishing on disjoint pairs,
are instances rather than separate lemmas.* -/
theorem br_phi_phi (a b c d : ι) :
    br (phi a b) (phi c d) =
      (if a = c then (1:ℝ) else 0) • phi b d + (if b = d then (1:ℝ) else 0) • phi a c
        - (if a = d then (1:ℝ) else 0) • phi b c - (if b = c then (1:ℝ) else 0) • phi a d := by
  ext p q
  simp only [br, phi, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.mul_apply,
             Matrix.single_apply, smul_eq_mul, ite_and]
  simp only [Finset.sum_ite_eq', Finset.mem_univ,
             if_true, mul_ite, mul_one, mul_zero, ite_mul, zero_mul, one_mul]
  by_cases hac : a = c <;> by_cases hbd : b = d <;> by_cases had : a = d <;>
    by_cases hbc : b = c <;> simp_all <;> split_ifs <;> simp_all
  all_goals first
    | ring
    | (intro h; simp_all)
    | tauto

/-! ## The special cases the record reasons with -/

/-- **`[φ_ab, φ_bd] = -φ_ad`** at distinct `a, b, d`. -/
theorem br_phi_share (a b d : ι) (hab : a ≠ b) (had : a ≠ d) (hbd : b ≠ d) :
    br (phi a b) (phi b d) = - phi a d := by
  rw [br_phi_phi]
  simp [hab, had, hbd, Ne.symm hab, Ne.symm had, Ne.symm hbd]

/-- **The bracket vanishes on disjoint pairs.** -/
theorem br_phi_disjoint (a b c d : ι) (hac : a ≠ c) (had : a ≠ d) (hbc : b ≠ c) (hbd : b ≠ d) :
    br (phi a b) (phi c d) = 0 := by
  rw [br_phi_phi]; simp [hac, had, hbc, hbd]

/-! ## The bracket fact behind the anchor

*`br_br_phi` is the pointwise reading of `ad²`: it moves `φ_ad` and `φ_bd` by `-1`, and those are
the `2(n-2)` basis directions the trace collects. The anchor below is proved from the conjugation
sum instead, which reaches the same `n-2` without enumerating those directions.*
-/

/-- **`ad_{φab}²` acts by `-1` on `φ_ad` and `φ_bd` for `d ∉ {a,b}`**, which is the whole content of
the anchor: those are the `2(n-2)` basis directions it moves. -/
theorem br_br_phi (a b d : ι) (hab : a ≠ b) (had : a ≠ d) (hbd : b ≠ d) :
    br (phi a b) (br (phi a b) (phi a d)) = - phi a d := by
  have h1 : br (phi a b) (phi a d) = phi b d := by
    rw [br_phi_phi]
    simp [hab, had, hbd, Ne.symm hab, Ne.symm had, Ne.symm hbd]
  rw [h1, br_phi_phi]
  simp [hab, had, hbd, Ne.symm hab, Ne.symm had, Ne.symm hbd]

/-! ## Where the anchor came from

**[r797](../../../reviews/REVIEW_r797.md) derived it by hand**: `sharpQF R η = -½ tr(ad_η R ad_η R)`,
whose polarisation is `-½ tr(ad_X R ad_Y R) = ⟨R# X, Y⟩` under the record's `½`-carrying index
formula, and at `R = id` the Killing form returns `(n-2)`. **The chain below carries that derivation
as Lean declarations**, so the `ℝ` layer's `#` normalisation is checked where
[Sharp.lean](Sharp.lean) checks the `ℚ` layer's at `n = 4` in the KERNEL, here at every `n`,
and by the kernel.
-/


/-! ## The conjugation sum -/

/-- **Pairing any entry family against `φᵢⱼ` reads off the antisymmetric part at `(j,i)`.** -/
theorem sum_mul_phi (f : ι → ι → ℝ) (i j : ι) :
    ∑ a : ι, ∑ b : ι, f a b * (phi i j a b) = f j i - f i j := by
  simp [phi, Matrix.single_apply, ite_and, mul_sub, Finset.sum_sub_distrib,
    Finset.sum_ite_eq, Finset.sum_ite_eq']

/-- **`A φᵢⱼ B` entrywise**: the conjugation moves one index of `A` and one of `B`. -/
theorem conj_apply (A B : Matrix ι ι ℝ) (i j a b : ι) :
    (A * phi i j * B) a b = A a j * B i b - A a i * B j b := by
  simp [Matrix.mul_apply, phi, Matrix.single_apply, ite_and, Finset.sum_ite_eq,
    Finset.sum_ite_eq', Finset.sum_sub_distrib, sub_mul, mul_sub]

/-- **The conjugation sum over the whole `φ` family.** -/
theorem sum_inner2_conj (A B : Matrix ι ι ℝ) :
    ∑ i : ι, ∑ j : ι, inner2 (A * phi i j * B) (phi i j)
      = A.trace * B.trace - (A * Matrix.transpose B).trace := by
  have key : ∀ i j : ι, inner2 (A * phi i j * B) (phi i j)
      = (1/2) * (A j j * B i i + A i i * B j j - A i j * B i j - A j i * B j i) := by
    intro i j
    rw [inner2_eq_sum]
    simp only [conj_apply]
    rw [sum_mul_phi (fun a b => A a j * B i b - A a i * B j b) i j]
    ring
  have hA : A.trace = ∑ a : ι, A a a := by simp [Matrix.trace, Matrix.diag]
  have hB : B.trace = ∑ a : ι, B a a := by simp [Matrix.trace, Matrix.diag]
  have htr : (A * Matrix.transpose B).trace = ∑ a : ι, ∑ b : ι, A a b * B a b := by
    simp [Matrix.trace, Matrix.diag, Matrix.mul_apply]
  have s1 : ∑ i : ι, ∑ j : ι, (1/2:ℝ) * (A j j * B i i)
      = ∑ i : ι, ∑ j : ι, (1/2:ℝ) * (A i i * B j j) := Finset.sum_comm
  have s2 : ∑ i : ι, ∑ j : ι, (1/2:ℝ) * (A j i * B j i)
      = ∑ i : ι, ∑ j : ι, (1/2:ℝ) * (A i j * B i j) := Finset.sum_comm
  have s3 : ∑ i : ι, ∑ j : ι, (1/2:ℝ) * (A i i * B j j)
      = (1/2:ℝ) * ((∑ a : ι, A a a) * (∑ a : ι, B a a)) := by
    rw [Finset.sum_mul_sum, Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [Finset.mul_sum]
  have s4 : ∑ i : ι, ∑ j : ι, (1/2:ℝ) * (A i j * B i j)
      = (1/2:ℝ) * (∑ a : ι, ∑ b : ι, A a b * B a b) := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [Finset.mul_sum]
  simp only [key, mul_add, mul_sub, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  rw [s1, s2, s3, s4, hA, hB, htr]
  ring

/-! ## The anchor: `id# = (n-2)·id` -/

theorem inner2_sub_left (X Y Z : Matrix ι ι ℝ) :
    inner2 (X - Y) Z = inner2 X Z - inner2 Y Z := by
  simp [inner2, Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]; ring

theorem inner2_add_left (X Y Z : Matrix ι ι ℝ) :
    inner2 (X + Y) Z = inner2 X Z + inner2 Y Z := by
  simp [inner2, Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring

/-- **`ad_X ad_Y` written as four conjugations**, which is the form `sum_inner2_conj` reads. -/
theorem br_br_eq (X Y Z : Matrix ι ι ℝ) :
    br X (br Y Z) = (X * Y) * Z * 1 - X * Z * Y - Y * Z * X + 1 * Z * (Y * X) := by
  simp only [br]; noncomm_ring

/-- **The Killing contraction on the `φ` family**: `∑ ⟨ad_X ad_Y φ, φ⟩ = 2(n-2) tr(XY)`.
*This is `𝔰𝔬(n)`'s Killing form `B(X,Y) = (n-2) tr(XY)`, with the ordered-pair doubling.* -/
theorem sum_inner2_ad2 (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ i : ι, ∑ j : ι, inner2 (br X (br Y (phi i j))) (phi i j)
      = 2 * ((Fintype.card ι : ℝ) - 2) * (X * Y).trace := by
  have hXt : Matrix.transpose X = -X := hX
  have hYt : Matrix.transpose Y = -Y := hY
  have htrX : X.trace = 0 := by
    have := congrArg Matrix.trace hXt
    simp [Matrix.trace_transpose, Matrix.trace_neg] at this
    linarith
  have htrY : Y.trace = 0 := by
    have := congrArg Matrix.trace hYt
    simp [Matrix.trace_transpose, Matrix.trace_neg] at this
    linarith
  have hsum : ∀ i j : ι, inner2 (br X (br Y (phi i j))) (phi i j)
      = inner2 ((X * Y) * phi i j * 1) (phi i j) - inner2 (X * phi i j * Y) (phi i j)
        - inner2 (Y * phi i j * X) (phi i j) + inner2 (1 * phi i j * (Y * X)) (phi i j) := by
    intro i j
    rw [br_br_eq, inner2_add_left, inner2_sub_left, inner2_sub_left]
  simp only [hsum, Finset.sum_add_distrib, Finset.sum_sub_distrib,
    sum_inner2_conj]
  simp only [Matrix.transpose_one, Matrix.mul_one, Matrix.one_mul, Matrix.trace_one,
    hXt, hYt, Matrix.transpose_mul, Matrix.mul_neg, Matrix.neg_mul, Matrix.trace_neg,
    htrX, htrY]
  rw [Matrix.trace_mul_comm Y X]
  ring

/-- **`⟨id# η, η⟩ = (n-2)‖η‖²`.** -/
theorem sharpQF_id (η : Matrix ι ι ℝ) (hη : IsSkew η) :
    sharpQF (ι := ι) (fun Z => Z) η = ((Fintype.card ι : ℝ) - 2) * inner2 η η := by
  have htr : (η * η).trace = -2 * inner2 η η := by
    have hηt : Matrix.transpose η = -η := hη
    simp [inner2, hηt, Matrix.neg_mul, Matrix.trace_neg]
  unfold sharpQF
  rw [sum_inner2_ad2 η η hη hη, htr]
  ring

/-- **The polarised anchor**: `⟨id# X, Y⟩ = (n-2)⟨X, Y⟩` on bivectors. -/
theorem sharpBil_id (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    sharpBil (ι := ι) (fun Z => Z) X Y = ((Fintype.card ι : ℝ) - 2) * inner2 X Y := by
  have hXY : IsSkew (X + Y) := by
    have hXt : Matrix.transpose X = -X := hX
    have hYt : Matrix.transpose Y = -Y := hY
    show Matrix.transpose (X + Y) = -(X + Y)
    rw [Matrix.transpose_add, hXt, hYt, neg_add]
  unfold sharpBil
  rw [sharpQF_id _ hXY, sharpQF_id _ hX, sharpQF_id _ hY]
  have hexp : inner2 (X + Y) (X + Y) = inner2 X X + 2 * inner2 X Y + inner2 Y Y := by
    rw [inner2_add_left, inner2_add_right, inner2_add_right]
    have h := inner2_comm Y X
    linarith
  rw [hexp]; ring

/-- **`id# = (n-2)·id`**, the record's mandated check on any `#` formula, discharged in the real
layer at every `n`. *This is what makes the `-¼` of `sharpQF` the record's normalisation.* -/
theorem sharpOp_id (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    sharpOp (ι := ι) (fun Z => Z) X = ((Fintype.card ι : ℝ) - 2) • X := by
  have hb : ∀ i j : ι, sharpBil (fun Z => Z) X (phi i j)
      = ((Fintype.card ι : ℝ) - 2) * inner2 X (phi i j) :=
    fun i j => sharpBil_id X (phi i j) hX (phi_isSkew i j)
  unfold sharpOp
  simp only [hb, mul_smul, ← Finset.smul_sum]
  rw [smul_comm, skew_expand X hX]

end HamiltonsCubic.RealLayer
