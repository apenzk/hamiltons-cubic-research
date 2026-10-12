import HamiltonsCubic.Results.GaussianPairForm
import HamiltonsCubic.Results.FrameGaussianBound

set_option linter.style.longLine false

/-!
# The rank step of L238 (ii) and L243, pointwise

## What is typed here

For vectors `w₁, …, w_k ∈ ℝⁿ` with Gram matrix `G_ij = wᵢ ⬝ wⱼ`:

* `trace_sq_le_k`: `(tr G)² ≤ k ‖G‖²_F`, Cauchy–Schwarz against the all-ones vector.
* `gram_frob_eq`: `‖G‖²_F = ‖A‖²_F` for `A = ∑ᵢ wᵢ wᵢᵀ`, and `tr G = tr A`.
* `trace_sq_le_perp`: if every `wᵢ ⊥ v` with `v ≠ 0`, then `(tr G)² ≤ (n − 1) ‖G‖²_F`, Cauchy–Schwarz of `A`
  against the scaled projector `|v|² I − v vᵀ`.

These are the pointwise inequality `(tr G)² − ‖G‖²_F ≤ (1 − 1/r)(tr G)²` with `r = k` or `r = n − 1`, which
L238 (ii) and L243 take at `wᵢ = Xᵢ v` (skew `Xᵢ`, so `Xᵢ v ⊥ v`).
-/

namespace HamiltonsCubic.GaussianRankStep

open Finset

variable {n k : ℕ}

/-- The Gram entries. -/
def gram (w : Fin k → Fin n → ℝ) (i j : Fin k) : ℝ := w i ⬝ᵥ w j

/-- `(tr G)² ≤ k ‖G‖²_F`. -/
theorem trace_sq_le_k (w : Fin k → Fin n → ℝ) :
    (∑ i, gram w i i) ^ 2 ≤ k * ∑ i, ∑ j, gram w i j ^ 2 := by
  have cs := Finset.sum_mul_sq_le_sq_mul_sq (Finset.univ : Finset (Fin k)) (fun _ => (1 : ℝ)) (fun i => gram w i i)
  simp only [one_mul, one_pow, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, mul_one] at cs
  have hdiag : ∑ i, gram w i i ^ 2 ≤ ∑ i, ∑ j, gram w i j ^ 2 := by
    refine Finset.sum_le_sum fun i _ => ?_
    exact Finset.single_le_sum (f := fun j => gram w i j ^ 2) (fun j _ => sq_nonneg _) (Finset.mem_univ i)
  calc (∑ i, gram w i i) ^ 2 ≤ k * ∑ i, gram w i i ^ 2 := cs
    _ ≤ k * ∑ i, ∑ j, gram w i j ^ 2 := by gcongr

/-- `‖G‖²_F = ∑_{p,q} A_pq²` with `A_pq = ∑ᵢ wᵢ_p wᵢ_q`. -/
theorem gram_frob_eq (w : Fin k → Fin n → ℝ) :
    ∑ i, ∑ j, gram w i j ^ 2 = ∑ p, ∑ q, (∑ i, w i p * w i q) ^ 2 := by
  have L : ∀ i j, gram w i j ^ 2 = ∑ p, ∑ q, w i p * w j p * (w i q * w j q) := by
    intro i j; simp only [gram, dotProduct, sq, Finset.sum_mul_sum]
  have R : ∀ p q, (∑ i, w i p * w i q) ^ 2 = ∑ i, ∑ j, w i p * w j p * (w i q * w j q) := by
    intro p q; rw [sq, Finset.sum_mul_sum]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  simp only [L, R]
  calc ∑ i : Fin k, ∑ j : Fin k, ∑ p : Fin n, ∑ q : Fin n, w i p * w j p * (w i q * w j q)
      = ∑ i : Fin k, ∑ p : Fin n, ∑ j : Fin k, ∑ q : Fin n, w i p * w j p * (w i q * w j q) :=
        Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ p : Fin n, ∑ i : Fin k, ∑ j : Fin k, ∑ q : Fin n, w i p * w j p * (w i q * w j q) := Finset.sum_comm
    _ = ∑ p : Fin n, ∑ i : Fin k, ∑ q : Fin n, ∑ j : Fin k, w i p * w j p * (w i q * w j q) :=
        Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ p : Fin n, ∑ q : Fin n, ∑ i : Fin k, ∑ j : Fin k, w i p * w j p * (w i q * w j q) :=
        Finset.sum_congr rfl fun p _ => Finset.sum_comm

/-- **The rank step at `r = n − 1`.** If every `wᵢ ⊥ v` and `v ≠ 0`, `(tr G)² ≤ (n − 1) ‖G‖²_F`. -/
theorem trace_sq_le_perp (w : Fin k → Fin n → ℝ) (v : Fin n → ℝ) (hv : v ⬝ᵥ v ≠ 0)
    (hperp : ∀ i, w i ⬝ᵥ v = 0) :
    (∑ i, gram w i i) ^ 2 ≤ ((n : ℝ) - 1) * ∑ i, ∑ j, gram w i j ^ 2 := by
  set s := v ⬝ᵥ v with hsdef
  set A : Fin n → Fin n → ℝ := fun p q => ∑ i, w i p * w i q with hAdef
  set Pm : Fin n → Fin n → ℝ := fun p q => (if p = q then s else 0) - v p * v q with hPdef
  have htr : ∑ i, gram w i i = ∑ p, A p p := by
    simp only [gram, dotProduct, hAdef]; exact Finset.sum_comm
  have hvAv : ∑ p, ∑ q, A p q * (v p * v q) = 0 := by
    have e : ∑ p, ∑ q, A p q * (v p * v q) = ∑ i, (w i ⬝ᵥ v) ^ 2 := by
      calc ∑ p, ∑ q, A p q * (v p * v q)
          = ∑ p : Fin n, ∑ q : Fin n, ∑ i : Fin k, (w i p * v p) * (w i q * v q) := by
            refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
            simp only [hAdef, Finset.sum_mul]; exact Finset.sum_congr rfl fun i _ => by ring
        _ = ∑ p : Fin n, ∑ i : Fin k, ∑ q : Fin n, (w i p * v p) * (w i q * v q) :=
            Finset.sum_congr rfl fun p _ => Finset.sum_comm
        _ = ∑ i : Fin k, ∑ p : Fin n, ∑ q : Fin n, (w i p * v p) * (w i q * v q) := Finset.sum_comm
        _ = ∑ i, (w i ⬝ᵥ v) ^ 2 := by
            refine Finset.sum_congr rfl fun i _ => ?_
            rw [sq, dotProduct, Finset.sum_mul_sum]
    rw [e]; simp [hperp]
  have hinner : ∑ p, ∑ q, A p q * Pm p q = s * ∑ p, A p p := by
    have e : ∀ p q, A p q * Pm p q = (if p = q then s * A p q else 0) - A p q * (v p * v q) := by
      intro p q; simp only [hPdef]; split_ifs <;> ring
    simp only [e, Finset.sum_sub_distrib, hvAv, sub_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true,
      Finset.mul_sum]
  have hs : ∑ p, v p ^ 2 = s := by simp [hsdef, dotProduct, sq]
  have hnormP : ∑ p, ∑ q, Pm p q ^ 2 = s ^ 2 * ((n : ℝ) - 1) := by
    have e : ∀ p q, Pm p q ^ 2 = (if p = q then s ^ 2 - 2 * s * v p ^ 2 else 0) + v p ^ 2 * v q ^ 2 := by
      intro p q; simp only [hPdef]; split_ifs with h
      · subst h; ring
      · ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true, ← Finset.sum_mul,
      ← Finset.mul_sum, hs, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ, Fintype.card_fin,
      nsmul_eq_mul]
    ring
  have cs := Finset.sum_mul_sq_le_sq_mul_sq (Finset.univ : Finset (Fin n × Fin n))
    (fun pq => A pq.1 pq.2) (fun pq => Pm pq.1 pq.2)
  rw [← Finset.univ_product_univ, Finset.sum_product, Finset.sum_product, Finset.sum_product] at cs
  rw [hinner, hnormP, ← gram_frob_eq w] at cs
  have hs2 : 0 < s ^ 2 := by positivity
  rw [htr]
  nlinarith [cs, sq_nonneg (∑ p, A p p)]

open MeasureTheory Matrix HamiltonsCubic.Results HamiltonsCubic.GaussianPairForm

/-- A skew matrix moves `v` perpendicular to itself. -/
theorem skew_perp (X : Matrix (Fin n) (Fin n) ℝ) (hX : Xᵀ = -X) (v : Fin n → ℝ) : X.mulVec v ⬝ᵥ v = 0 := by
  have h : X.mulVec v ⬝ᵥ v = v ⬝ᵥ (Xᵀ).mulVec v := by
    rw [Matrix.mulVec_transpose, dotProduct_comm, Matrix.dotProduct_mulVec, dotProduct_comm]
  have h2 : v ⬝ᵥ (Xᵀ).mulVec v = -(X.mulVec v ⬝ᵥ v) := by
    rw [hX, Matrix.neg_mulVec, dotProduct_neg, dotProduct_comm]
  linarith

/-- `∑_{i≠j}(G_ii G_jj − G_ij²) = (tr G)² − ‖G‖²_F`. -/
theorem offdiag_sum (G : Fin k → Fin k → ℝ) (hG : ∀ i j, G i j = G j i) :
    ∑ i, ∑ j, (if i = j then (0 : ℝ) else G i i * G j j - G i j ^ 2)
      = (∑ i, G i i) ^ 2 - ∑ i, ∑ j, G i j ^ 2 := by
  have e : ∀ i j, (if i = j then (0 : ℝ) else G i i * G j j - G i j ^ 2) = G i i * G j j - G i j ^ 2 := by
    intro i j; split_ifs with h
    · subst h; ring
    · rfl
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => e i j]
  simp only [Finset.sum_sub_distrib, sq, Finset.sum_mul_sum]

/-- **The pointwise rank step at `r = n − 1`**, for skew `Xᵢ` and every `v`. -/
theorem pointwise_rank_step (hn : 2 ≤ n) (X : Fin k → Matrix (Fin n) (Fin n) ℝ) (hskew : ∀ i, (X i)ᵀ = -X i)
    (v : Fin n → ℝ) :
    (∑ i, gram (fun i => (X i).mulVec v) i i) ^ 2 - ∑ i, ∑ j, gram (fun i => (X i).mulVec v) i j ^ 2
      ≤ (1 - 1 / ((n : ℝ) - 1)) * (∑ i, gram (fun i => (X i).mulVec v) i i) ^ 2 := by
  have hn1 : (0 : ℝ) < (n : ℝ) - 1 := by
    have : (2 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  by_cases hv : v ⬝ᵥ v = 0
  · have hv0 : v = 0 := by
      funext p
      have := (dotProduct_self_eq_zero).mp hv
      simp [this]
    subst hv0; simp [gram]
  · have h := trace_sq_le_perp (fun i => (X i).mulVec v) v hv (fun i => skew_perp _ (hskew i) v)
    set T := ∑ i, gram (fun i => (X i).mulVec v) i i
    set F := ∑ i, ∑ j, gram (fun i => (X i).mulVec v) i j ^ 2
    have : T ^ 2 / ((n : ℝ) - 1) ≤ F := by rw [div_le_iff₀ hn1]; linarith
    have e : (1 - 1 / ((n : ℝ) - 1)) * T ^ 2 = T ^ 2 - T ^ 2 / ((n : ℝ) - 1) := by field_simp
    linarith

/-- `tr G = v ⬝ᵥ P v` with `P = ∑ᵢ Xᵢᵀ Xᵢ`. -/
theorem trace_gram_eq (X : Fin k → Matrix (Fin n) (Fin n) ℝ) (v : Fin n → ℝ) :
    ∑ i, gram (fun i => (X i).mulVec v) i i = v ⬝ᵥ (∑ i, (X i)ᵀ * X i).mulVec v := by
  rw [Matrix.sum_mulVec, dotProduct_sum]
  exact Finset.sum_congr rfl fun i _ => inner_eq_quad (X i) (X i) v

/-- **L243 at `r = n − 1`, in Lean** (the `r = k` branch is `frame_bound` in FrameGaussianBound.lean). For `k` skew matrices orthonormal in the record's norm on `ℝⁿ`, `n ≥ 2`, with
`P = ∑ᵢ Xᵢᵀ Xᵢ`, the ordered bracket total is at most `(1 − 1/(n−1))(4k² + 2 tr P²) − 4k(k−1)`. -/
theorem L243_frame (hn : 2 ≤ n) {k : ℕ} (X : Fin k → Matrix (Fin n) (Fin n) ℝ)
    (hskew : ∀ i, (X i)ᵀ = -X i) (hnorm : ∀ i, (X i * X i).trace = -2)
    (horth : ∀ i j, i ≠ j → (X i * X j).trace = 0) :
    ∑ i, ∑ j, (if i = j then (0 : ℝ) else -(1/2) * ((X i * X j - X j * X i) * (X i * X j - X j * X i)).trace)
      ≤ (1 - 1 / ((n : ℝ) - 1)) * (4 * (k : ℝ) ^ 2 + 2 * ((∑ i, (X i)ᵀ * X i) * (∑ i, (X i)ᵀ * X i)).trace)
        - 4 * k * (k - 1) := by
  set P := ∑ i, (X i)ᵀ * X i
  have hPsym : P.IsSymm := by
    unfold Matrix.IsSymm; simp only [P, Matrix.transpose_sum, Matrix.transpose_mul, Matrix.transpose_transpose]
  have htrP : P.trace = 2 * k := by
    simp only [P, Matrix.trace_sum]
    have : ∀ i, ((X i)ᵀ * X i).trace = 2 := fun i => by rw [hskew i, Matrix.neg_mul, Matrix.trace_neg, hnorm i]; ring
    simp [this]; ring
  apply frame_cap X hskew hnorm horth
  -- the rank step, integrated
  have hpt : ∀ v : Fin n → ℝ, (∑ i, ∑ j, (if i = j then (0 : ℝ) else
        ((X i).mulVec v ⬝ᵥ (X i).mulVec v) * ((X j).mulVec v ⬝ᵥ (X j).mulVec v)
          - ((X i).mulVec v ⬝ᵥ (X j).mulVec v) ^ 2))
      ≤ (1 - 1 / ((n : ℝ) - 1)) * ((v ⬝ᵥ P.mulVec v) * (v ⬝ᵥ P.mulVec v)) := by
    intro v
    have e := offdiag_sum (gram fun i => (X i).mulVec v) (fun i j => dotProduct_comm _ _)
    simp only [gram] at e
    rw [e, ← sq, ← trace_gram_eq X v]
    simpa [gram] using pointwise_rank_step hn X hskew v
  have hIL : Integrable (fun v : Fin n → ℝ => ∑ i, ∑ j, (if i = j then (0 : ℝ) else
        ((X i).mulVec v ⬝ᵥ (X i).mulVec v) * ((X j).mulVec v ⬝ᵥ (X j).mulVec v)
          - ((X i).mulVec v ⬝ᵥ (X j).mulVec v) ^ 2)) (μ n) := by
    refine integrable_finset_sum _ fun i _ => integrable_finset_sum _ fun j _ => ?_
    by_cases h : i = j
    · simp [h]
    · simp only [h, if_false]; exact integrable_pair _ _
  have hIR : Integrable (fun v : Fin n → ℝ => (1 - 1 / ((n : ℝ) - 1)) * ((v ⬝ᵥ P.mulVec v) * (v ⬝ᵥ P.mulVec v))) (μ n) :=
    (integrable_quad_mul P P).const_mul _
  calc _ ≤ ∫ v, (1 - 1 / ((n : ℝ) - 1)) * ((v ⬝ᵥ P.mulVec v) * (v ⬝ᵥ P.mulVec v)) ∂(μ n) :=
        integral_mono hIL hIR hpt
    _ = (1 - 1 / ((n : ℝ) - 1)) * (4 * (k : ℝ) ^ 2 + 2 * (P * P).trace) := by
        rw [integral_const_mul, integral_quadForm_mul_quadForm P P hPsym hPsym, htrP]; ring

/-- The bracket total in `L243_frame`'s form equals L238's `frameT`. -/
theorem total_eq_frameT (X : Fin k → Matrix (Fin n) (Fin n) ℝ) :
    ∑ i, ∑ j, (if i = j then (0 : ℝ) else -(1/2) * ((X i * X j - X j * X i) * (X i * X j - X j * X i)).trace)
      = HamiltonsCubic.Results.frameT X := by
  unfold HamiltonsCubic.Results.frameT
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  split_ifs with h
  · subst h; ring
  · have c1 : (X i * X j * (X j * X i)).trace = (X i * X i * (X j * X j)).trace := by
      have h1 := Matrix.trace_mul_comm (X i) (X j * (X j * X i))
      have h2 := Matrix.trace_mul_comm (X j * X j) (X i * X i)
      simp only [Matrix.mul_assoc] at h1 h2 ⊢; rw [h1, h2]
    have c2 : (X j * X i * (X i * X j)).trace = (X i * X i * (X j * X j)).trace := by
      have h := Matrix.trace_mul_comm (X j) (X i * (X i * X j))
      simp only [Matrix.mul_assoc] at h ⊢; exact h
    have c3 : (X j * X i * (X j * X i)).trace = (X i * X j * (X i * X j)).trace := by
      have h := Matrix.trace_mul_comm (X j) (X i * (X j * X i))
      simp only [Matrix.mul_assoc] at h ⊢; exact h
    simp only [Matrix.sub_mul, Matrix.mul_sub, Matrix.trace_sub, c1, c2, c3]
    ring

/-- `frameP = ∑ᵢ Xᵢᵀ Xᵢ` for skew `Xᵢ`. -/
theorem frameP_eq (X : Fin k → Matrix (Fin n) (Fin n) ℝ) (hskew : ∀ i, (X i)ᵀ = -X i) :
    HamiltonsCubic.Results.frameP X = ∑ i, (X i)ᵀ * X i := by
  unfold HamiltonsCubic.Results.frameP HamiltonsCubic.Results.frameQ
  exact Finset.sum_congr rfl fun i _ => by rw [hskew i, Matrix.neg_mul]

/-- **L243 at `r = min(k, n − 1)`**, assembled from `L243_frame` (`r = n − 1`) and L238's `frame_bound`
(`r = k`, whose right side `2(1 − 1/k) tr P²` equals the cap at `r = k`). -/
theorem L243_min (hn : 2 ≤ n) {k : ℕ} (hk : 0 < k) (X : Fin k → Matrix (Fin n) (Fin n) ℝ)
    (hskew : ∀ i, (X i)ᵀ = -X i) (hnorm : ∀ i, (X i * X i).trace = -2)
    (horth : ∀ i j, i ≠ j → (X i * X j).trace = 0) :
    ∑ i, ∑ j, (if i = j then (0 : ℝ) else -(1/2) * ((X i * X j - X j * X i) * (X i * X j - X j * X i)).trace)
      ≤ (1 - 1 / (min (k : ℝ) ((n : ℝ) - 1))) * (4 * (k : ℝ) ^ 2 + 2 * ((∑ i, (X i)ᵀ * X i) * (∑ i, (X i)ᵀ * X i)).trace)
        - 4 * k * (k - 1) := by
  rcases le_total (k : ℝ) ((n : ℝ) - 1) with h | h
  · rw [min_eq_left h, total_eq_frameT]
    have fb := HamiltonsCubic.Results.frame_bound X hk (fun i => hskew i)
    rw [frameP_eq X hskew] at fb
    have hk' : (0 : ℝ) < k := by exact_mod_cast hk
    have e : (1 - 1 / (k : ℝ)) * (4 * (k : ℝ) ^ 2 + 2 * ((∑ i, (X i)ᵀ * X i) * (∑ i, (X i)ᵀ * X i)).trace)
        - 4 * k * (k - 1) = 2 * (1 - 1 / (k : ℝ)) * ((∑ i, (X i)ᵀ * X i) * (∑ i, (X i)ᵀ * X i)).trace := by
      field_simp; ring
    rw [e]; exact fb
  · rw [min_eq_right h]; exact L243_frame hn X hskew hnorm horth

end HamiltonsCubic.GaussianRankStep
