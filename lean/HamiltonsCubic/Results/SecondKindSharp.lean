import HamiltonsCubic.Results.SecondKindE

set_option linter.style.longLine false

/-!
# The second-kind bound on `E` with the record's sharp frame constant

[The working note](../../../reviews/2026-09-28d-I121-smallmass-direct.md) on I121, "`E` is the
second-kind cubic". [SecondKindE.lean](SecondKindE.lean) proves `E ≤ (3/2)√((n−1)/n)√B‖W‖²` with
a Cauchy–Schwarz that spends hollowness alone. **This file spends the two facts the record's cap
also spends** ([bispectral.md](../../../findings/bispectral.md), `μ ≤ √(t_F(n−2)/(n−1))`, Gate 2
r555, r556): the sectional matrix of every frame has zero row sums at a Ricci-flat operator, and
the bottom eigenvector of `W̊` is trace-free. The constant becomes `√((n−2)/(n−1))`.

- `rowsum_secK`: `∑_q K_pq = Ric(u_p, u_p)`, zero at a Ricci-flat operator;
- `vertex_quad_sq_le`: for `K` hollow with zero row sums and `∑e = 0`,
  `(eᵀKe)² ≤ ‖K‖²_F (n−2)/(n−1) (∑e²)²`, by Cauchy–Schwarz against
  `ee^T − c(I − J/n)` at `c = ∑e²/(n−1)`;
- `frob_ringW_traceless`: at a Ricci-flat operator `⟨W̊h, h⟩` depends only on `h`'s trace-free
  part, whose norm is at most `‖h‖`;
- **`E_le_tmax_sharp`: `E ≤ (3/2)√(2(n−2)/(n−1)) t ‖W‖²`** whenever every orthonormal frame has
  `∑_{p,q} K_pq² ≤ 2t²`.
-/

namespace HamiltonsCubic.SecondKindSharp

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.SecondKind
  HamiltonsCubic.L50Spectra HamiltonsCubic.SecondKindE

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [DecidableEq ι] in
/-- **The vertex-space Cauchy–Schwarz.** For `K` hollow with zero row sums and `∑ e = 0`,
`(∑ K_pq e_p e_q)² ≤ (∑ K_pq²) · (n−2)/(n−1) · (∑ e²)²`. -/
theorem vertex_quad_sq_le (K : ι → ι → ℝ) (hK : ∀ p, K p p = 0) (hrow : ∀ p, ∑ q, K p q = 0)
    (e : ι → ℝ) (he : ∑ p, e p = 0) (hn : (1 : ℝ) < Fintype.card ι) :
    (∑ p, ∑ q, K p q * e p * e q) ^ 2
      ≤ (∑ p, ∑ q, K p q ^ 2) * (((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1)
          * (∑ p, e p ^ 2) ^ 2) := by
  classical
  set N : ℝ := (Fintype.card ι : ℝ) with hN
  set S : ℝ := ∑ p, e p ^ 2 with hS
  set c : ℝ := S / (N - 1) with hc
  have hN1 : N - 1 ≠ 0 := by linarith
  have hNpos : (0 : ℝ) < N := by linarith
  set X : ι × ι → ℝ := fun pq => e pq.1 * e pq.2 - c * ((if pq.1 = pq.2 then 1 else 0) - 1 / N)
    with hX
  -- the form is the pairing with X
  have hdiag : (∑ p, K p p) = 0 := Finset.sum_eq_zero fun p _ => hK p
  have hall : (∑ p, ∑ q, K p q) = 0 := Finset.sum_eq_zero fun p _ => hrow p
  have e1 : (∑ p, ∑ q, K p q * e p * e q) = ∑ pq : ι × ι, K pq.1 pq.2 * X pq := by
    rw [← Finset.univ_product_univ, Finset.sum_product]
    have : ∀ p, (∑ q, K p q * X (p, q)) = (∑ q, K p q * e p * e q)
        - c * K p p + c / N * ∑ q, K p q := fun p => by
      simp only [hX, mul_sub, mul_ite, mul_one, mul_zero, Finset.sum_sub_distrib,
        Finset.sum_ite_eq, Finset.mem_univ, if_true, Finset.mul_sum]
      rw [Finset.sum_congr rfl fun q _ => (by ring : K p q * (c * (1 / N)) = c / N * K p q)]
      rw [Finset.sum_congr rfl fun q _ => (by ring : K p q * (e p * e q) = K p q * e p * e q)]
      rw [← Finset.mul_sum]
      ring
    rw [Finset.sum_congr rfl fun p _ => this p, Finset.sum_add_distrib, Finset.sum_sub_distrib,
      ← Finset.mul_sum, ← Finset.mul_sum, hdiag, hall]
    ring
  have e2 : (∑ p, ∑ q, K p q ^ 2) = ∑ pq : ι × ι, K pq.1 pq.2 ^ 2 := by
    rw [← Finset.univ_product_univ, Finset.sum_product]
  -- the norm of X
  have e3 : (∑ pq : ι × ι, X pq ^ 2) = (N - 2) / (N - 1) * S ^ 2 := by
    rw [← Finset.univ_product_univ, Finset.sum_product]
    have row : ∀ p, (∑ q, X (p, q) ^ 2)
        = e p ^ 2 * S - 2 * c * (e p ^ 2 - e p * (∑ q, e q) / N)
          + c ^ 2 * ((1 - 1 / N) ^ 2 + (N - 1) * (1 / N) ^ 2) := fun p => by
      have hsplit : ∀ q, X (p, q) ^ 2 = (e p * e q) ^ 2 - 2 * c * (e p * e q) * ((if p = q then 1 else 0) - 1 / N)
          + c ^ 2 * ((if p = q then 1 else 0) - 1 / N) ^ 2 := fun q => by simp only [hX]; ring
      simp only [hsplit, Finset.sum_add_distrib, Finset.sum_sub_distrib]
      have t1 : (∑ q, (e p * e q) ^ 2) = e p ^ 2 * S := by
        rw [hS, Finset.mul_sum]; exact Finset.sum_congr rfl fun q _ => by ring
      have t2 : (∑ q, 2 * c * (e p * e q) * ((if p = q then (1 : ℝ) else 0) - 1 / N))
          = 2 * c * (e p ^ 2 - e p * (∑ q, e q) / N) := by
        have hq : ∀ q, 2 * c * (e p * e q) * ((if p = q then (1 : ℝ) else 0) - 1 / N)
            = 2 * c * (if p = q then e p * e q else 0) - 2 * c / N * (e p * e q) := by
          intro q; split_ifs <;> ring
        simp only [hq, Finset.sum_sub_distrib, ← Finset.mul_sum, Finset.sum_ite_eq,
          Finset.mem_univ, if_true]
        ring
      have t3 : (∑ q, c ^ 2 * ((if p = q then (1 : ℝ) else 0) - 1 / N) ^ 2)
          = c ^ 2 * ((1 - 1 / N) ^ 2 + (N - 1) * (1 / N) ^ 2) := by
        rw [← Finset.mul_sum, ← Finset.add_sum_erase _ _ (Finset.mem_univ p), if_pos rfl]
        have : (∑ q ∈ Finset.univ.erase p, ((if p = q then (1 : ℝ) else 0) - 1 / N) ^ 2)
            = (N - 1) * (1 / N) ^ 2 := by
          rw [Finset.sum_congr rfl fun q hq => by
            rw [if_neg (Ne.symm (Finset.ne_of_mem_erase hq))]]
          rw [Finset.sum_const, Finset.card_erase_of_mem (Finset.mem_univ p), Finset.card_univ,
            nsmul_eq_mul, Nat.cast_sub (Fintype.card_pos_iff.mpr ⟨p⟩), hN]
          push_cast; ring
        rw [this]
      rw [t1, t2, t3]
    rw [Finset.sum_congr rfl fun p _ => row p, he]
    simp only [zero_div, mul_zero, sub_zero, Finset.sum_add_distrib, Finset.sum_sub_distrib,
      ← Finset.sum_mul, ← Finset.mul_sum, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
    rw [← hS, ← hN, hc]
    field_simp
    ring
  rw [e1, e2, ← e3]
  exact Finset.sum_mul_sq_le_sq_mul_sq _ _ _

section frame

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))

/-- **The sectional matrix of every frame has zero row sums at a Ricci-flat operator**:
`∑_q K_pq = Ric(u_p, u_p)`. -/
theorem rowsum_secK (hRic : ∀ a b, Ric R a b = 0) (U : Matrix ι ι ℝ) (hU : Uᵀ * U = 1)
    (p : ι) : ∑ q, secK R U p q = 0 := by
  have hUU : U * Uᵀ = 1 := mul_eq_one_comm.mp hU
  have hδ : ∀ b d, (∑ q, U b q * U d q) = if b = d then 1 else 0 := fun b d => by
    have := congrFun (congrFun hUU b) d
    simpa [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply] using this
  set F : ι → ι → ι → ι → ι → ℝ :=
    fun a b c d q => R4 R a b c d * U a p * U b q * U c p * U d q with hF
  have key : ∀ a c, (∑ b, ∑ d, ∑ q, F a b c d q) = U a p * U c p * Ric R a c := by
    intro a c
    have inner : ∀ b d, (∑ q, F a b c d q)
        = R4 R a b c d * U a p * U c p * (if b = d then 1 else 0) := by
      intro b d
      rw [← hδ b d, Finset.mul_sum]
      exact Finset.sum_congr rfl fun q _ => by simp only [hF]; ring
    simp only [inner, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true]
    unfold Ric
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun b _ => by unfold R4; ring
  unfold secK
  calc (∑ q, ∑ a, ∑ b, ∑ c, ∑ d, R4 R a b c d * U a p * U b q * U c p * U d q)
      = ∑ q, ∑ a, ∑ b, ∑ c, ∑ d, F a b c d q := rfl
    _ = ∑ a, ∑ q, ∑ b, ∑ c, ∑ d, F a b c d q := Finset.sum_comm
    _ = ∑ a, ∑ b, ∑ q, ∑ c, ∑ d, F a b c d q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ a, ∑ b, ∑ c, ∑ q, ∑ d, F a b c d q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ a, ∑ b, ∑ c, ∑ d, ∑ q, F a b c d q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
          Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ a, ∑ c, ∑ b, ∑ d, ∑ q, F a b c d q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ a, ∑ c, U a p * U c p * Ric R a c :=
        Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun c _ => key a c
    _ = 0 := by simp [hRic]

include hR in
/-- `W̊` ignores the trace part at a Ricci-flat operator. -/
theorem ringW_sub_smul_one (hRic : ∀ a b, Ric R a b = 0) (h : Matrix ι ι ℝ) (s : ℝ) :
    ringW R (h - s • (1 : Matrix ι ι ℝ)) = ringW R h := by
  have h1 : ringW R 1 = 0 := by
    ext i j; rw [ringW_one R hR i j, hRic]; simp
  have hlin : ringW R (h - s • (1 : Matrix ι ι ℝ)) = ringW R h - s • ringW R 1 := by
    ext i j
    simp only [ringW, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul, mul_sub,
      Finset.sum_sub_distrib, Finset.mul_sum]
    congr 1
    exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by ring
  rw [hlin, h1, smul_zero, sub_zero]

include hR hskew hsym

/-- **The trace-free reduction.** At a Ricci-flat operator, `⟨W̊h, h⟩ = ⟨W̊h₀, h₀⟩` for
`h₀ = h − (tr h / n)·1`. -/
theorem frob_ringW_traceless (hRic : ∀ a b, Ric R a b = 0) (h : Matrix ι ι ℝ) (s : ℝ) :
    frob (ringW R (h - s • (1 : Matrix ι ι ℝ))) (h - s • (1 : Matrix ι ι ℝ))
      = frob (ringW R h) h := by
  rw [ringW_sub_smul_one R hR hRic h s]
  have htr := trace_ringW R hR hskew hsym h
  have hric0 : frob (fun k l => Ric R k l) h = 0 := by simp [frob, hRic]
  rw [hric0, neg_zero] at htr
  have : frob (ringW R h) (s • (1 : Matrix ι ι ℝ)) = s * (ringW R h).trace := by
    simp only [frob, Matrix.smul_apply, Matrix.one_apply, smul_eq_mul, mul_ite, mul_one,
      mul_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true, Matrix.trace, Matrix.diag,
      Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by ring
  have hsub : frob (ringW R h) (h - s • (1 : Matrix ι ι ℝ))
      = frob (ringW R h) h - frob (ringW R h) (s • (1 : Matrix ι ι ℝ)) := by
    simp only [frob, Matrix.sub_apply, mul_sub, Finset.sum_sub_distrib]
  rw [hsub, this, htr, mul_zero, sub_zero]

omit hR hskew hsym in
/-- The trace-free part has norm at most `‖h‖`. -/
theorem frob_traceless_le [Nonempty ι] (h : Matrix ι ι ℝ) :
    frob (h - (h.trace / Fintype.card ι) • (1 : Matrix ι ι ℝ))
        (h - (h.trace / Fintype.card ι) • (1 : Matrix ι ι ℝ)) ≤ frob h h := by
  have hn : (0 : ℝ) < Fintype.card ι := by exact_mod_cast Fintype.card_pos
  set s := h.trace / Fintype.card ι with hs
  have e : frob (h - s • (1 : Matrix ι ι ℝ)) (h - s • (1 : Matrix ι ι ℝ))
      = frob h h - 2 * s * h.trace + s ^ 2 * Fintype.card ι := by
    simp only [frob, Matrix.sub_apply, Matrix.smul_apply, Matrix.one_apply, smul_eq_mul]
    have : ∀ i j, (h i j - s * (if i = j then (1 : ℝ) else 0)) * (h i j - s * (if i = j then 1 else 0))
        = h i j * h i j - 2 * s * (if i = j then h i j else 0) + s ^ 2 * (if i = j then 1 else 0) := by
      intro i j; split_ifs with hij
      · subst hij; ring
      · ring
    simp only [this, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum,
      Finset.sum_ite_eq, Finset.mem_univ, if_true, Finset.sum_const, Finset.card_univ,
      nsmul_eq_mul, mul_one, Matrix.trace, Matrix.diag]
    ring
  rw [e, hs]
  have : 2 * (h.trace / Fintype.card ι) * h.trace - (h.trace / Fintype.card ι) ^ 2 * Fintype.card ι
      = h.trace ^ 2 / Fintype.card ι := by field_simp; ring
  have hsq : 0 ≤ h.trace ^ 2 / Fintype.card ι := div_nonneg (sq_nonneg _) hn.le
  linarith

variable [Nonempty ι]

omit [Nonempty ι] in
/-- The sharp frame step on a trace-free symmetric `h`. -/
theorem neg_frob_ringW_le_traceless (hRic : ∀ a b, Ric R a b = 0) (hn : (1 : ℝ) < Fintype.card ι)
    (B : ℝ) (hKB : ∀ U : Matrix ι ι ℝ, Uᵀ * U = 1 → ∑ p, ∑ q, secK R U p q ^ 2 ≤ B)
    (h : Matrix ι ι ℝ) (hh : hᵀ = h) (htr : h.trace = 0) :
    -frob (ringW R h) h
      ≤ Real.sqrt (((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1)) * Real.sqrt B
          * frob h h := by
  obtain ⟨U, hU, e, he⟩ := eigen_expand h hh
  have hUU : ∀ p q, (∑ i, U i p * U i q) = if p = q then 1 else 0 := fun p q => by
    have := congrFun (congrFun hU p) q
    simpa [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply] using this
  have hsum : ∑ p, e p = 0 := by
    have : h.trace = ∑ p, e p := by
      simp only [Matrix.trace, Matrix.diag, he]
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun p _ => ?_
      have hpp : (∑ i, U i p * U i p) = 1 := by simpa using hUU p p
      calc (∑ i, e p * U i p * U i p) = e p * ∑ i, U i p * U i p := by
            rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun i _ => by ring
        _ = e p := by rw [hpp, mul_one]
    rw [← this, htr]
  rw [neg_frob_ringW R hR h, quad_eigen R U e h he, frob_eigen U hU e h he]
  set X := ∑ p, ∑ q, e p * e q * secK R U p q with hX
  set S := ∑ p, e p ^ 2 with hS
  have hS0 : 0 ≤ S := Finset.sum_nonneg fun p _ => sq_nonneg _
  have hK := hKB U hU
  have hK0 : 0 ≤ ∑ p, ∑ q, secK R U p q ^ 2 :=
    Finset.sum_nonneg fun p _ => Finset.sum_nonneg fun q _ => sq_nonneg _
  have hq := vertex_quad_sq_le (secK R U) (secK_diag R hR hskew hsym U)
    (rowsum_secK R hRic U hU) e hsum hn
  have hX' : X = ∑ p, ∑ q, secK R U p q * e p * e q := Finset.sum_congr rfl fun p _ =>
    Finset.sum_congr rfl fun q _ => by ring
  rw [← hX'] at hq
  have h2 : (2 : ℝ) ≤ Fintype.card ι := by
    have h1 : 1 < Fintype.card ι := by exact_mod_cast hn
    exact_mod_cast h1
  have hc0 : 0 ≤ ((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1) :=
    div_nonneg (by linarith) (by linarith)
  have hB0 : 0 ≤ B := hK0.trans hK
  have hX2 : X ^ 2 ≤ B * (((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1) * S ^ 2) :=
    hq.trans (mul_le_mul_of_nonneg_right hK (by positivity))
  calc X ≤ |X| := le_abs_self X
    _ ≤ Real.sqrt (B * (((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1) * S ^ 2)) :=
        Real.abs_le_sqrt hX2
    _ = _ := by rw [Real.sqrt_mul hB0, Real.sqrt_mul hc0, Real.sqrt_sq hS0]; ring

/-- **THE SHARP FRAME STEP.** At a Ricci-flat operator, if every orthonormal frame has
`∑ K_pq² ≤ B`, then `−⟨W̊ h, h⟩ ≤ √((n−2)/(n−1)) √B ‖h‖²` on symmetric `h`. -/
theorem neg_frob_ringW_le_sharp (hRic : ∀ a b, Ric R a b = 0) (hn : (1 : ℝ) < Fintype.card ι)
    (B : ℝ) (hKB : ∀ U : Matrix ι ι ℝ, Uᵀ * U = 1 → ∑ p, ∑ q, secK R U p q ^ 2 ≤ B)
    (h : Matrix ι ι ℝ) (hh : hᵀ = h) :
    -frob (ringW R h) h
      ≤ Real.sqrt (((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1)) * Real.sqrt B
          * frob h h := by
  have hn0 : (0 : ℝ) < Fintype.card ι := by linarith
  rw [← frob_ringW_traceless R hR hskew hsym hRic h (h.trace / Fintype.card ι)]
  have hsym₀ : (h - (h.trace / Fintype.card ι) • (1 : Matrix ι ι ℝ))ᵀ
      = h - (h.trace / Fintype.card ι) • (1 : Matrix ι ι ℝ) := by
    rw [Matrix.transpose_sub, Matrix.transpose_smul, Matrix.transpose_one, hh]
  have htr₀ : (h - (h.trace / Fintype.card ι) • (1 : Matrix ι ι ℝ)).trace = 0 := by
    rw [Matrix.trace_sub, Matrix.trace_smul, Matrix.trace_one, smul_eq_mul]
    field_simp
    ring
  have hmain := neg_frob_ringW_le_traceless R hR hskew hsym hRic hn B hKB _ hsym₀ htr₀
  have hfr := frob_traceless_le h
  have hcoef : 0 ≤ Real.sqrt (((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1))
      * Real.sqrt B := mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)
  exact hmain.trans (mul_le_mul_of_nonneg_left hfr hcoef)

variable (hB : ∀ i j k l, bianchi R i j k l = 0)
include hB

/-- **`E ≤ (3/2) √(2(n−2)/(n−1)) t ‖W‖²`** at a Ricci-flat operator whose frames all have
`∑ K_pq² ≤ 2t²`: the frame-free bound with the record's sharp constant. -/
theorem E_le_tmax_sharp (hRic : ∀ a b, Ric R a b = 0) (hn : (1 : ℝ) < Fintype.card ι)
    (t : ℝ) (ht : 0 ≤ t)
    (hKB : ∀ U : Matrix ι ι ℝ, Uᵀ * U = 1 → ∑ p, ∑ q, secK R U p q ^ 2 ≤ 2 * t ^ 2) :
    Pcubic R - (3 / 2) * trCube R
      ≤ (3 / 2) * Real.sqrt (2 * (((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1))) * t
          * normSq R := by
  have key := E_le R hR hskew hsym hB
    (Real.sqrt (((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1)) * Real.sqrt (2 * t ^ 2))
    (fun h hh => by
      have := neg_frob_ringW_le_sharp R hR hskew hsym hRic hn (2 * t ^ 2) hKB h hh
      linarith)
  have e : Real.sqrt (((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1)) * Real.sqrt (2 * t ^ 2)
      = Real.sqrt (2 * (((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1))) * t := by
    rw [Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 2) (t ^ 2), Real.sqrt_sq ht,
      Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 2)]
    ring
  rw [e] at key
  linarith

end frame

end HamiltonsCubic.SecondKindSharp
