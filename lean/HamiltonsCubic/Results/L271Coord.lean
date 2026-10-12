import Mathlib
import HamiltonsCubic.Results.I117Statements
import HamiltonsCubic.Results.L271Sym

set_option linter.style.longLine false

/-!
# L271 (3): a torus idempotent has `Q = 0` exactly when it is coordinate-diagonal

[findings/second-order.md](../../../findings/second-order.md), Lemma L271 (3): *"An idempotent in the family has
$Q=0$ exactly when it is coordinate-diagonal, so by L261 the only positive solution with $Q=0$ is $I/c$."*
[I117Statements.lean](I117Statements.lean) has the second clause (`L271_Q_zero`). This file, with coordinate-diagonal
meaning `coordOp w` for some weight matrix `w` on `Fin m × Fin 2`:

* `wT`, `torusMat_coord`, `torus_coord`: at `U = V` and diagonal `A`, `torusOp A U U = coordOp (wT A U)`, the
  off-diagonal blocks multiplied by `U_ij` and the Cartan block by `A_kk`;
* `coord_torus`: conversely, a coordinate-diagonal `torusOp A U V` with symmetric `U`, `V` has `U = V` off the
  diagonal and `A` diagonal, read at one test bivector per pair and one Cartan vector;
* `L271_three_coord`: an idempotent `torusOp A U V` is coordinate-diagonal exactly when `U = V`, that is `Q = 0`;
* `AEq`, `AEq_swap`, `AEq_sign`: (2)'s Cartan equations `A_ii = d_i`, `A_ij = -P_ij Q_ij` are invariant under
  `P ↔ Q` and under `Q ↦ SQS`, `A ↦ SAS`, completing [L271Sym.lean](L271Sym.lean)'s symmetries;
* `pos_not_swap`: `P_ij > |Q_ij|` excludes `Q_ij > |P_ij|`, so `P ↔ Q` does not preserve positivity.
-/

namespace HamiltonsCubic.L271Coord

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.L271Sym

variable {m : ℕ}

/-- The weight of a coordinate-diagonal torus operator. -/
def wT (A U : Matrix (Fin m) (Fin m) ℝ) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ :=
  fun p r => if p.1 = r.1 then (if p.2 = r.2 then 0 else A p.1 p.1) else U p.1 r.1

/-- **At `U = V` and diagonal `A` the torus matrix is `wT ⊙ X` on skew `X`.** -/
theorem torusMat_coord (A U : Matrix (Fin m) (Fin m) ℝ) (hAd : ∀ i j, i ≠ j → A i j = 0)
    (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (hX : Xᵀ = -X) :
    torusMat A U U X = wT A U ⊙ X := by
  have hsk : ∀ p r, X r p = -X p r := fun p r => by
    have := congrFun (congrFun hX p) r
    simpa [Matrix.transpose_apply] using this
  ext ⟨i, a⟩ ⟨j, b⟩
  by_cases hij : i = j
  · subst hij
    have hsum : ∑ k, A i k * X (k, 1) (k, 0) = A i i * X (i, 1) (i, 0) :=
      Finset.sum_eq_single i (fun k _ hk => by rw [hAd i k (Ne.symm hk), zero_mul]) (by simp)
    simp only [torusMat, wT, Matrix.hadamard_apply, if_true, hsum]
    have h00 := hsk (i, 0) (i, 0)
    have h11 := hsk (i, 1) (i, 1)
    have h01 := hsk (i, 0) (i, 1)
    fin_cases a <;> fin_cases b <;> simp [J2] <;> (rw [h01]; ring)
  · simp only [torusMat, wT, Matrix.hadamard_apply, if_neg hij, cPart, aPart, blk, Matrix.smul_apply,
      Matrix.sub_apply, Matrix.add_apply, smul_eq_mul]
    ring

/-- **At `U = V` and diagonal `A`, `torusOp A U U` is coordinate-diagonal.** -/
theorem torus_coord (A U : Matrix (Fin m) (Fin m) ℝ) (hAd : ∀ i j, i ≠ j → A i j = 0) :
    torusOp A U U = coordOp (wT A U) := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  show skewPartM (torusMat A U U (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))
    = skewPartM (wT A U ⊙ (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))
  rw [torusMat_coord A U hAd _ X.2]

theorem cPart_10 (B : Matrix (Fin 2) (Fin 2) ℝ) : cPart B 1 0 = (1 / 2) * (B 1 0 - B 0 1) := by
  rw [cPart, Matrix.smul_apply, Matrix.sub_apply, Matrix.mul_apply, Fin.sum_univ_two, Matrix.mul_apply, Matrix.mul_apply,
    Fin.sum_univ_two, Fin.sum_univ_two]
  simp [J2]
theorem aPart_10 (B : Matrix (Fin 2) (Fin 2) ℝ) : aPart B 1 0 = (1 / 2) * (B 1 0 + B 0 1) := by
  rw [aPart, Matrix.smul_apply, Matrix.add_apply, Matrix.mul_apply, Fin.sum_univ_two, Matrix.mul_apply, Matrix.mul_apply,
    Fin.sum_univ_two, Fin.sum_univ_two]
  simp [J2]
theorem cPart_01 (B : Matrix (Fin 2) (Fin 2) ℝ) : cPart B 0 1 = (1 / 2) * (B 0 1 - B 1 0) := by
  rw [cPart, Matrix.smul_apply, Matrix.sub_apply, Matrix.mul_apply, Fin.sum_univ_two, Matrix.mul_apply, Matrix.mul_apply,
    Fin.sum_univ_two, Fin.sum_univ_two]
  simp [J2]
theorem aPart_01 (B : Matrix (Fin 2) (Fin 2) ℝ) : aPart B 0 1 = (1 / 2) * (B 0 1 + B 1 0) := by
  rw [aPart, Matrix.smul_apply, Matrix.add_apply, Matrix.mul_apply, Fin.sum_univ_two, Matrix.mul_apply, Matrix.mul_apply,
    Fin.sum_univ_two, Fin.sum_univ_two]
  simp [J2]

/-- **A coordinate-diagonal torus operator has `U = V` off the diagonal and `A` diagonal.** -/
theorem coord_torus (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V)
    (w : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (h : torusOp A U V = coordOp w) :
    (∀ i j, i ≠ j → U i j = V i j) ∧ (∀ i j, i ≠ j → A i j = 0) := by
  have hUs : ∀ i j, U j i = U i j := fun i j => by rw [← Matrix.transpose_apply U i j, hU]
  have hVs : ∀ i j, V j i = V i j := fun i j => by rw [← Matrix.transpose_apply V i j, hV]
  constructor
  · intro i j hij
    have e := congrArg (fun T : CurvOp2 (Fin m × Fin 2) =>
      ((T ⟨phi (j, 1) (i, 0), phi_mem_skewSub _ _⟩ : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
        (i, 1) (j, 0)) h
    change skewPartM (torusMat A U V (phi (j, 1) (i, 0))) (i, 1) (j, 0)
      = skewPartM (w ⊙ phi (j, 1) (i, 0)) (i, 1) (j, 0) at e
    simp only [skewPartM, Matrix.smul_apply, Matrix.sub_apply, Matrix.transpose_apply, Matrix.hadamard_apply,
      torusMat, if_neg hij, if_neg (Ne.symm hij), cPart_10, aPart_10, cPart_01, aPart_01, blk, smul_eq_mul] at e
    simp [phi, Matrix.single_apply, hij, Ne.symm hij, hUs, hVs] at e
    linarith
  · intro k l hkl
    have e := congrArg (fun T : CurvOp2 (Fin m × Fin 2) =>
      ((T ⟨phi (l, 0) (l, 1), phi_mem_skewSub _ _⟩ : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
        (k, 0) (k, 1)) h
    change skewPartM (torusMat A U V (phi (l, 0) (l, 1))) (k, 0) (k, 1)
      = skewPartM (w ⊙ phi (l, 0) (l, 1)) (k, 0) (k, 1) at e
    have hsum : ∑ x, A k x * phi (l, 0) (l, 1) (x, 1) (x, 0) = A k l := by
      rw [Finset.sum_eq_single l]
      · simp [phi, Matrix.single_apply]
      · intro x _ hx; simp [phi, Matrix.single_apply, hx, Ne.symm hx]
      · simp
    simp only [skewPartM, Matrix.smul_apply, Matrix.sub_apply, Matrix.transpose_apply, Matrix.hadamard_apply,
      torusMat, if_true, hsum, smul_eq_mul] at e
    simp [phi, Matrix.single_apply, hkl, Ne.symm hkl, J2] at e
    linarith

/-- **L271 (3), the first clause**: an idempotent torus operator is coordinate-diagonal exactly when `U = V`, that is
`Q = U - V = 0`. -/
theorem L271_three_coord (hm : 3 ≤ m) (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hV : IsPairWeights V) (hidem : IsIdem (torusOp A U V)) :
    (∃ w : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ, torusOp A U V = coordOp w) ↔ U - V = 0 := by
  rw [sub_eq_zero]
  constructor
  · rintro ⟨w, hw⟩
    obtain ⟨h1, -⟩ := coord_torus A U V hU.1 hV.1 w hw
    ext i j
    by_cases hij : i = j
    · subst hij; rw [hU.2, hV.2]
    · exact h1 i j hij
  · intro hUV
    subst hUV
    obtain ⟨hAmu, -⟩ := (L268_torus_idem hm A U U hA hU hU).mp hidem
    refine ⟨wT A U, torus_coord A U fun i j hij => ?_⟩
    rw [hAmu]
    simp [Amu, hij]

/-- **The Cartan equations of (2)**, `A_ii = d_i` and `A_ij = -P_ij Q_ij`. -/
def AEq (A P Q : Matrix (Fin m) (Fin m) ℝ) : Prop :=
  (∀ i, A i i = dPQ P Q i) ∧ ∀ i j, i ≠ j → A i j = -(P i j * Q i j)

/-- They are invariant under `P ↔ Q`. -/
theorem AEq_swap (A P Q : Matrix (Fin m) (Fin m) ℝ) : AEq A Q P ↔ AEq A P Q := by
  unfold AEq
  simp only [dPQ_swap, mul_comm (Q _ _)]

/-- And under `Q ↦ SQS`, `A ↦ SAS`. -/
theorem AEq_sign (s : Fin m → ℝ) (hs : ∀ i, s i ^ 2 = 1) (A P Q : Matrix (Fin m) (Fin m) ℝ) :
    AEq (diagonal s * A * diagonal s) P (diagonal s * Q * diagonal s) ↔ AEq A P Q := by
  unfold AEq
  simp only [dPQ_sign s hs, conj_apply s hs]
  constructor
  · rintro ⟨h1, h2⟩
    refine ⟨fun i => ?_, fun i j hij => ?_⟩
    · have := h1 i; have hi := hs i
      linear_combination this - A i i * hi
    · have := h2 i j hij; have hi := hs i; have hj := hs j
      linear_combination (s i * s j) * this - (A i j + P i j * Q i j) * s j ^ 2 * hi - (A i j + P i j * Q i j) * hj
  · rintro ⟨h1, h2⟩
    refine ⟨fun i => ?_, fun i j hij => ?_⟩
    · have := h1 i; have hi := hs i
      linear_combination A i i * hi + this
    · have := h2 i j hij
      linear_combination (s i * s j) * this

/-- **`P ↔ Q` does not preserve positivity**: `P_ij > |Q_ij|` excludes `Q_ij > |P_ij|`. -/
theorem pos_not_swap (p q : ℝ) (h : |q| < p) : ¬ |p| < q := fun h' => by
  have h1 := abs_lt.mp h
  have h2 := abs_lt.mp h'
  linarith [h1.2, h2.2]

end HamiltonsCubic.L271Coord
