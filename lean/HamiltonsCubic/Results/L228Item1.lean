import Mathlib
import HamiltonsCubic.Results.L226Statement
import HamiltonsCubic.Results.L228Statement

set_option linter.style.longLine false

/-!
# L228 item 1: `P` and `‖W‖²` on `𝒮_J ∩ 𝒲ₙ` in the traceless parts of the blocks

[findings/second-order.md](../../../findings/second-order.md), Lemma L228, item 1: with blocks
$M_a=t_aI+X_a$, $\operatorname{tr}X_a=0$, outer diagonal $K$, $S=N-\tfrac12(\operatorname{tr}N)I$,
$X=\sum_aX_a$, $\mu=\sum_at_a$ and $\beta_{ab}=\tfrac32(K_{ab}-t_a-t_b-\tfrac12\mu)$,
*"$P(W)=2\operatorname{tr}X^3+3\sum_a\operatorname{tr}(XX_a^2)+\sum_a\operatorname{tr}X_a^3+\sum_{a\ne b}\beta_{ab}
\operatorname{tr}(X_aX_b)+P_0(t,K)$ and $\lVert W\rVert^2=\lvert X\rvert^2+\sum_a\lvert X_a\rvert^2+N_0(t,K)$, with
$P_0,N_0$ depending on the scalars only."* The L228 row owes *"a bridge from `cubicX` to L226's `blockP`, so
item 1 in full"*. This file:

* `cubicJ_shift`, `cube_shift`, `trace_adj_shift`, `trace_mul_shift`, `sq_shift`: the `3 × 3` identities at a
  traceless matrix shifted by a scalar, the adjugate through its entries;
* `L228_item1_poly`: the identity at the level of L226's `blockP` and norm, with `P₀`, `N₀` explicit;
* `L228_item1`: at the operator, `P(blockOp S M K)` and `‖blockOp S M K‖²` in that form, through
  `Pcubic_blockOp` and `normSq_blockOp`;
* `N_shift`, `L228_item1_ricci`: at any symmetric `S` whose `J`-rows of the Ricci form vanish, L226's
  `ricciJ_inverse` gives `S = N - ½(tr N)I = X - ½μ I`, so item 1 holds there.
-/

namespace HamiltonsCubic.L228Item1

open Matrix Finset HamiltonsCubic.L226Statement HamiltonsCubic.L228Statement

/-- `cubicJ (X + c I) = 2 tr X³ + (3c/2) tr X² + 6c³` at traceless `X`. -/
theorem cubicJ_shift (A : Matrix (Fin 3) (Fin 3) ℝ) (hA : A.trace = 0) (c : ℝ) :
    cubicJ (A + c • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      = 2 * (A * A * A).trace + 3 * c / 2 * (A * A).trace + 6 * c ^ 3 := by
  have h22 : A 2 2 = -(A 0 0) - A 1 1 := by rw [Matrix.trace_fin_three] at hA; linarith
  simp only [cubicJ, Matrix.det_fin_three, Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three,
    Matrix.add_apply, Matrix.smul_apply, Matrix.one_apply, smul_eq_mul]
  simp only [Fin.isValue, Fin.reduceEq, if_true, if_false]
  rw [h22]
  ring

theorem cube_shift (A : Matrix (Fin 3) (Fin 3) ℝ) (hA : A.trace = 0) (t : ℝ) :
    ((t • (1 : Matrix (Fin 3) (Fin 3) ℝ) + A) * (t • 1 + A) * (t • 1 + A)).trace
      = (A * A * A).trace + 3 * t * (A * A).trace + 3 * t ^ 3 := by
  have h22 : A 2 2 = -(A 0 0) - A 1 1 := by rw [Matrix.trace_fin_three] at hA; linarith
  simp only [Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three,
    Matrix.add_apply, Matrix.smul_apply, Matrix.one_apply, smul_eq_mul]
  simp only [Fin.isValue, Fin.reduceEq, if_true, if_false]
  rw [h22]
  ring

theorem trace_mul_shift (A B : Matrix (Fin 3) (Fin 3) ℝ) (hA : A.trace = 0) (hB : B.trace = 0) (t s : ℝ) :
    ((t • (1 : Matrix (Fin 3) (Fin 3) ℝ) + A) * (s • 1 + B)).trace = (A * B).trace + 3 * t * s := by
  have hA22 : A 2 2 = -(A 0 0) - A 1 1 := by rw [Matrix.trace_fin_three] at hA; linarith
  have hB22 : B 2 2 = -(B 0 0) - B 1 1 := by rw [Matrix.trace_fin_three] at hB; linarith
  simp only [Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three,
    Matrix.add_apply, Matrix.smul_apply, Matrix.one_apply, smul_eq_mul]
  simp only [Fin.isValue, Fin.reduceEq, if_true, if_false]
  rw [hA22, hB22]
  ring

theorem sq_shift (A : Matrix (Fin 3) (Fin 3) ℝ) (hA : A.trace = 0) (c : ℝ) :
    ((A + c • (1 : Matrix (Fin 3) (Fin 3) ℝ)) * (A + c • 1)).trace = (A * A).trace + 3 * c ^ 2 := by
  have h22 : A 2 2 = -(A 0 0) - A 1 1 := by rw [Matrix.trace_fin_three] at hA; linarith
  simp only [Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three,
    Matrix.add_apply, Matrix.smul_apply, Matrix.one_apply, smul_eq_mul]
  simp only [Fin.isValue, Fin.reduceEq, if_true, if_false]
  rw [h22]
  ring

/-- `tr((B + cI) adj(tI + A)) = tr(BA²) - t tr(BA) + c(3t² - ½ tr A²)` at traceless `A`, `B`. -/
theorem trace_adj_shift (A B : Matrix (Fin 3) (Fin 3) ℝ) (hA : A.trace = 0) (hB : B.trace = 0) (t c : ℝ) :
    ((B + c • (1 : Matrix (Fin 3) (Fin 3) ℝ)) * (t • 1 + A).adjugate).trace
      = (B * A * A).trace - t * (B * A).trace + c * (3 * t ^ 2 - 1 / 2 * (A * A).trace) := by
  have hA22 : A 2 2 = -(A 0 0) - A 1 1 := by rw [Matrix.trace_fin_three] at hA; linarith
  have hB22 : B 2 2 = -(B 0 0) - B 1 1 := by rw [Matrix.trace_fin_three] at hB; linarith
  simp [Matrix.adjugate_fin_three, Matrix.trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three,
    Matrix.one_apply, hA22, hB22]
  ring

variable {m : ℕ}

/-- Over ordered pairs a symmetric summand counts each unordered pair twice. -/
theorem sum_ne_eq_two_lt (f : Fin m → Fin m → ℝ) (hf : ∀ a b, f a b = f b a) :
    ∑ a, ∑ b, (if a ≠ b then f a b else 0) = 2 * ∑ a, ∑ b, (if a < b then f a b else 0) := by
  have hsplit : ∀ a b, (if a ≠ b then f a b else 0) = (if a < b then f a b else 0) + (if b < a then f a b else 0) := by
    intro a b
    rcases lt_trichotomy a b with h | h | h
    · simp [h, ne_of_lt h, not_lt_of_gt h]
    · simp [h]
    · simp [h, ne_of_gt h, not_lt_of_gt h]
  have hswap : ∑ a, ∑ b, (if b < a then f a b else 0) = ∑ a, ∑ b, (if a < b then f a b else 0) := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by rw [hf]
  simp only [hsplit, Finset.sum_add_distrib, hswap]
  ring

/-- `P₀(t, K)`, the scalar part of `P`, with `c = -μ/2`. -/
noncomputable def P0 (t : Fin m → ℝ) (K : Fin m → Fin m → ℝ) : ℝ :=
  6 * (-(∑ a, t a) / 2) ^ 3 + ∑ a, (3 * t a ^ 3 + 9 * (-(∑ d, t d) / 2) * t a ^ 2)
    + ∑ a, ∑ b, (if a < b then K a b ^ 3 + 9 * K a b * (t a * t b) else 0)
    + 3 * ∑ a, ∑ b, ∑ c, (if a < b ∧ b < c then K a b * K a c * K b c else 0)

/-- `N₀(t, K)`, the scalar part of `‖W‖²`. -/
noncomputable def N0 (t : Fin m → ℝ) (K : Fin m → Fin m → ℝ) : ℝ :=
  3 * (-(∑ a, t a) / 2) ^ 2 + 3 * ∑ a, t a ^ 2 + ∑ a, ∑ b, (if a < b then K a b ^ 2 else 0)

/-- `β_ab = (3/2)(K_ab - t_a - t_b - μ/2)`. -/
noncomputable def beta (t : Fin m → ℝ) (K : Fin m → Fin m → ℝ) (a b : Fin m) : ℝ :=
  3 / 2 * (K a b - t a - t b - (∑ d, t d) / 2)

theorem L228_item1_poly (t : Fin m → ℝ) (Xs : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hX : ∀ a, (Xs a).trace = 0)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) :
    blockP (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)) (fun a => t a • 1 + Xs a) K
      = cubicX Xs + ∑ a, ∑ b, (if a ≠ b then beta t K a b * (Xs a * Xs b).trace else 0) + P0 t K := by
  set c : ℝ := -(∑ a, t a) / 2 with hc
  set X := ∑ a, Xs a with hXdef
  have hXtr : X.trace = 0 := by rw [hXdef, Matrix.trace_sum]; exact Finset.sum_eq_zero fun a _ => hX a
  have hS : X - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ) = X + c • 1 := by
    rw [hc, sub_eq_add_neg, ← neg_smul, neg_div]
  have hQ : ∀ a b, (Xs a * Xs b).trace = (Xs b * Xs a).trace := fun a b => Matrix.trace_mul_comm _ _
  have hXX : (X * X).trace = ∑ a, ∑ b, (Xs a * Xs b).trace := by
    rw [hXdef, Finset.sum_mul, Matrix.trace_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum, Matrix.trace_sum]
  have hXa : ∀ a, (X * Xs a).trace = ∑ b, (Xs a * Xs b).trace := fun a => by
    rw [hXdef, Finset.sum_mul, Matrix.trace_sum]
    exact Finset.sum_congr rfl fun b _ => hQ b a
  unfold blockP cubicX P0 beta
  rw [← hXdef, hS, cubicJ_shift X hXtr c, ← hc]
  simp only [cube_shift, trace_adj_shift, trace_mul_shift, hX, hXtr, hXa]
  rw [hXX]
  -- the per-`a` terms
  have E1 : ∑ x, ((Xs x * Xs x * Xs x).trace + 3 * t x * (Xs x * Xs x).trace + 3 * t x ^ 3 +
        3 * ((X * Xs x * Xs x).trace - t x * ∑ b, (Xs x * Xs b).trace +
          c * (3 * t x ^ 2 - 1 / 2 * (Xs x * Xs x).trace)))
      = ∑ x, (Xs x * Xs x * Xs x).trace + 3 * ∑ x, (X * Xs x * Xs x).trace + ∑ x, (3 * t x ^ 3 + 9 * c * t x ^ 2)
        + ∑ x, (3 * t x * (Xs x * Xs x).trace - 3 * t x * ∑ b, (Xs x * Xs b).trace
          - 3 * c / 2 * (Xs x * Xs x).trace) := by
    rw [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun x _ => by ring
  -- the outer pairs
  have E2 : ∑ x, ∑ y, (if x < y then K x y ^ 3 + 3 * K x y * ((Xs x * Xs y).trace + 3 * t x * t y) else 0)
      = ∑ a, ∑ b, (if a < b then K a b ^ 3 + 9 * K a b * (t a * t b) else 0)
        + ∑ a, ∑ b, (if a < b then 3 * K a b * (Xs a * Xs b).trace else 0) := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    split_ifs <;> ring
  have E3 : ∑ a, ∑ b, (if a ≠ b then 3 / 2 * (K a b - t a - t b - (∑ d, t d) / 2) * (Xs a * Xs b).trace else 0)
      = ∑ a, ∑ b, (if a ≠ b then 3 / 2 * K a b * (Xs a * Xs b).trace else 0)
        + ∑ a, ∑ b, (if a ≠ b then 3 / 2 * (c - t a - t b) * (Xs a * Xs b).trace else 0) := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    split_ifs
    · rw [hc]; ring
    · ring
  have E4 : ∑ a, ∑ b, (if a ≠ b then 3 / 2 * K a b * (Xs a * Xs b).trace else 0)
      = ∑ a, ∑ b, (if a < b then 3 * K a b * (Xs a * Xs b).trace else 0) := by
    rw [sum_ne_eq_two_lt (fun a b => 3 / 2 * K a b * (Xs a * Xs b).trace)
      (fun a b => by rw [hK a b, hQ a b]), Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    split_ifs <;> ring
  -- the quadratic core
  have hne : ∀ (a b : Fin m) (x : ℝ), (if a ≠ b then x else 0) = x - (if a = b then x else 0) := by
    intro a b x; by_cases h : a = b <;> simp [h]
  have hswap : ∑ a, ∑ b, 3 / 2 * t b * (Xs a * Xs b).trace = ∑ a, ∑ b, 3 / 2 * t a * (Xs a * Xs b).trace := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by rw [hQ]
  have per : ∀ a, 3 * c / 2 * ∑ b, (Xs a * Xs b).trace
        + (3 * t a * (Xs a * Xs a).trace - 3 * t a * ∑ b, (Xs a * Xs b).trace - 3 * c / 2 * (Xs a * Xs a).trace)
      = ∑ b, (3 / 2 * c * (Xs a * Xs b).trace - 3 / 2 * t a * (Xs a * Xs b).trace)
        - ∑ b, 3 / 2 * t a * (Xs a * Xs b).trace - 3 / 2 * (c - t a - t a) * (Xs a * Xs a).trace := by
    intro a
    simp only [Finset.sum_sub_distrib, ← Finset.mul_sum]
    ring
  have E5 : 3 * c / 2 * ∑ a, ∑ b, (Xs a * Xs b).trace
        + ∑ x, (3 * t x * (Xs x * Xs x).trace - 3 * t x * ∑ b, (Xs x * Xs b).trace
          - 3 * c / 2 * (Xs x * Xs x).trace)
      = ∑ a, ∑ b, (if a ≠ b then 3 / 2 * (c - t a - t b) * (Xs a * Xs b).trace else 0) := by
    have hR : ∑ a, ∑ b, (if a ≠ b then 3 / 2 * (c - t a - t b) * (Xs a * Xs b).trace else 0)
        = ∑ a, ∑ b, (3 / 2 * c * (Xs a * Xs b).trace - 3 / 2 * t a * (Xs a * Xs b).trace)
          - ∑ a, ∑ b, 3 / 2 * t b * (Xs a * Xs b).trace
          - ∑ a, 3 / 2 * (c - t a - t a) * (Xs a * Xs a).trace := by
      conv_lhs => simp only [hne, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
      congr 1
      rw [← Finset.sum_sub_distrib]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [← Finset.sum_sub_distrib]
      refine Finset.sum_congr rfl fun b _ => ?_
      ring
    rw [hR, hswap, Finset.mul_sum, ← Finset.sum_add_distrib, Finset.sum_congr rfl fun a _ => per a,
      Finset.sum_sub_distrib, Finset.sum_sub_distrib]
  linarith [E1, E2, E3, E4, E5]

/-- **The norm half of item 1**, at the level of L226's norm formula. -/
theorem L228_item1_norm_poly (t : Fin m → ℝ) (Xs : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hX : ∀ a, (Xs a).trace = 0)
    (K : Fin m → Fin m → ℝ) :
    ((∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        * (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))).trace
      + ∑ a, ((t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) * (t a • 1 + Xs a)).trace
      + ∑ a, ∑ b, (if a < b then K a b ^ 2 else 0)
      = ((∑ a, Xs a) * (∑ a, Xs a)).trace + ∑ a, (Xs a * Xs a).trace + N0 t K := by
  set c : ℝ := -(∑ a, t a) / 2 with hc
  set X := ∑ a, Xs a with hXdef
  have hXtr : X.trace = 0 := by rw [hXdef, Matrix.trace_sum]; exact Finset.sum_eq_zero fun a _ => hX a
  have hS : X - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ) = X + c • 1 := by
    rw [hc, sub_eq_add_neg, ← neg_smul, neg_div]
  rw [hS, sq_shift X hXtr c]
  simp only [trace_mul_shift, hX]
  unfold N0
  rw [← hc]
  have h : ∑ a, ((Xs a * Xs a).trace + 3 * t a * t a) = ∑ a, (Xs a * Xs a).trace + 3 * ∑ a, t a ^ 2 := by
    rw [Finset.mul_sum, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun a _ => by ring
  linarith [h]

/-- **At the blocks `M_a = t_a I + X_a`**, `N - ½(tr N)I = X - ½μ I`. -/
theorem N_shift (t : Fin m → ℝ) (Xs : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hX : ∀ a, (Xs a).trace = 0) :
    ∑ a, (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a)
        - ((1 / 2 : ℝ) * (∑ a, (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a)).trace) • (1 : Matrix (Fin 3) (Fin 3) ℝ)
      = ∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ) := by
  have htr : (∑ a, (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a)).trace = 3 * ∑ a, t a := by
    rw [Matrix.trace_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Matrix.trace_add, Matrix.trace_smul, Matrix.trace_one, hX a]
    simp only [Fintype.card_fin, smul_eq_mul]
    push_cast
    ring
  rw [htr, Finset.sum_add_distrib, ← Finset.sum_smul]
  ext i j
  simp only [Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
  ring

open HamiltonsCubic.RealLayer in
/-- **L228 item 1 at the operator.** For symmetric traceless blocks `X_a`, `M_a = t_a I + X_a`, symmetric `K` with
zero diagonal and `S = X - ½μ I` (which `L228_item1_ricci` derives from Ricci-flatness on `J`),
`P(W) = 2 tr X³ + 3 ∑ tr(X X_a²) + ∑ tr X_a³ + ∑_{a≠b} β_ab tr(X_a X_b) + P₀(t, K)` and
`‖W‖² = |X|² + ∑ |X_a|² + N₀(t, K)`. -/
theorem L228_item1 (t : Fin m → ℝ) (Xs : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hX : ∀ a, (Xs a).trace = 0)
    (hXs : ∀ a, (Xs a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)) (fun a => t a • 1 + Xs a) K)
        = cubicX Xs + ∑ a, ∑ b, (if a ≠ b then beta t K a b * (Xs a * Xs b).trace else 0) + P0 t K ∧
      normSq (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)) (fun a => t a • 1 + Xs a) K)
        = ((∑ a, Xs a) * (∑ a, Xs a)).trace + ∑ a, (Xs a * Xs a).trace + N0 t K := by
  have hSs : (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)).IsSymm := by
    unfold Matrix.IsSymm
    rw [Matrix.transpose_sub, Matrix.transpose_sum, Matrix.transpose_smul, Matrix.transpose_one]
    congr 1
    exact Finset.sum_congr rfl fun a _ => (hXs a).eq
  have hMs : ∀ a, (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a).IsSymm := fun a => by
    unfold Matrix.IsSymm
    rw [Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_one, (hXs a).eq]
  refine ⟨?_, ?_⟩
  · rw [Pcubic_blockOp _ hSs _ hMs K hK hK0]
    exact L228_item1_poly t Xs hX K hK
  · rw [normSq_blockOp _ hSs _ hMs K hK hK0]
    exact L228_item1_norm_poly t Xs hX K

open HamiltonsCubic.RealLayer in
/-- **Item 1 at a point Ricci-flat on `J`**: for any symmetric `S` whose `J`-rows of the Ricci form vanish,
`S = X - ½μ I` (`ricciJ_inverse`, `N_shift`), so item 1 holds at `blockOp S M K`. -/
theorem L228_item1_ricci (t : Fin m → ℝ) (Xs : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hX : ∀ a, (Xs a).trace = 0)
    (hXs : ∀ a, (Xs a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (hRic : ∀ p q, Ric (blockOp S (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) (.inl p) (.inl q) = 0) :
    Pcubic (blockOp S (fun a => t a • 1 + Xs a) K)
        = cubicX Xs + ∑ a, ∑ b, (if a ≠ b then beta t K a b * (Xs a * Xs b).trace else 0) + P0 t K ∧
      normSq (blockOp S (fun a => t a • 1 + Xs a) K)
        = ((∑ a, Xs a) * (∑ a, Xs a)).trace + ∑ a, (Xs a * Xs a).trace + N0 t K := by
  have hMs : ∀ a, (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a).IsSymm := fun a => by
    unfold Matrix.IsSymm
    rw [Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_one, (hXs a).eq]
  have hmat : S.trace • (1 : Matrix (Fin 3) (Fin 3) ℝ) - S = -∑ a, (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) := by
    ext p q
    have h := hRic p q
    rw [Ric_blockOp_J S hS _ hMs K p q] at h
    simp only [Matrix.neg_apply, Matrix.sum_apply]
    linarith
  have hSeq := (ricciJ_inverse S _).mp hmat
  rw [N_shift t Xs hX] at hSeq
  subst hSeq
  exact L228_item1 t Xs hX hXs K hK hK0
end HamiltonsCubic.L228Item1
