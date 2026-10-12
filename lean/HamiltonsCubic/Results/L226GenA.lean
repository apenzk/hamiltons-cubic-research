import Mathlib
import HamiltonsCubic.Results.L226Gen

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L226 item 1 at every `|J| = k`, part A: the embedding of `Λ²ℝ^J`, the three block actions, and `tr W³`

[L226](../../../findings/second-order.md), item 1: *For every $W\in\mathcal S_J$, $P(W)=P(R_J)+\sum_{a\in A}(\operatorname{tr}M_a^3+3
\operatorname{tr}(R_J\Lambda^2M_a))+\sum_{a<b}(K_{ab}^3+3K_{ab}\operatorname{tr}(M_aM_b))+3\sum_{a<b<c}K_{ab}K_{ac}K_{bc}$, where
$P(R_J)=\operatorname{tr}R_J^3+\langle R_J,R_J^\#\rangle$ is the cubic of $\Lambda^2\mathbb R^J=\mathfrak{so}(k)$.* [L226Statement.lean](L226Statement.lean)
proves it at `k = 3` through the `ε` table. Here `R_J` is an array `R` on `J = Fin k` with the curvature symmetries
([L226Gen.lean](L226Gen.lean)'s `IsCurvArray`), and `P(R_J)` is the layer's `Pcubic` of `opOf R` on `Fin k`:

* `emb`, `Λ²ℝ^J` inside `Λ²ℝ^{J ⊔ A}` as the top-left block, with `emb_phi`, `inner2_emb`, `br_emb`;
* **`blockOpG_emb`**: `W (emb X) = emb (R X)` at every `X`, so `W` restricted to `Λ²ℝ^J` is `R_J`;
* `blockOpG_M`, `blockOpG_K`: `W φ_{pa} = ∑_q (M_a)_{pq} φ_{qa}` and `W φ_{ab} = K_{ab} φ_{ab}`;
* **`trCube_blockOpG`**: `tr W³ = tr R_J³ + ∑_a tr M_a³ + ∑_{a<b} K_{ab}³`, true at every array `R`; `trCube (opOf R)` is the record's
  `tr R_J³` when `R` is pair-symmetric, as an `IsCurvArray` is ([r1886](../../../reviews/REVIEW_r1886.md) O1).

The step from `W ∈ 𝒮_J` to the block form is the block note's argument, untyped here as in L226Gen (r1864 O1, r1886 O5).
-/

namespace HamiltonsCubic.L226GenA

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L226Mixed HamiltonsCubic.L226Gen

variable {k m : ℕ}

/-- **`Λ²ℝ^J` as the top-left block.** -/
noncomputable def emb : Matrix (Fin k) (Fin k) ℝ →ₗ[ℝ] Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ where
  toFun X := Matrix.fromBlocks X 0 0 0
  map_add' X Y := by simp [Matrix.fromBlocks_add]
  map_smul' c X := by simp [Matrix.fromBlocks_smul]

theorem emb_apply (X : Matrix (Fin k) (Fin k) ℝ) : emb (m := m) X = Matrix.fromBlocks X 0 0 0 := rfl

theorem emb_phi (p q : Fin k) : emb (m := m) (phi p q) = phi (.inl p) (.inl q) := by
  ext i j
  rcases i with i | i <;> rcases j with j | j <;> simp [emb_apply, phi, Matrix.single_apply]

theorem inner2_emb (X Y : Matrix (Fin k) (Fin k) ℝ) : inner2 (emb (m := m) X) (emb Y) = inner2 X Y := by
  simp only [inner2, emb_apply, Matrix.fromBlocks_transpose, Matrix.fromBlocks_multiply]
  simp [Matrix.trace, Fintype.sum_sum_type]

theorem br_emb (X Y : Matrix (Fin k) (Fin k) ℝ) : br (emb (m := m) X) (emb Y) = emb (br X Y) := by
  simp only [br, emb_apply, Matrix.fromBlocks_multiply]
  ext i j
  rcases i with i | i <;> rcases j with j | j <;> simp

theorem inner2_emb_M (X : Matrix (Fin k) (Fin k) ℝ) (p : Fin k) (a : Fin m) :
    inner2 (emb X) (phi (.inl p) (.inr a)) = 0 := by
  rw [inner2_phi_eq']; simp [emb_apply]

theorem inner2_emb_M' (X : Matrix (Fin k) (Fin k) ℝ) (a : Fin m) (p : Fin k) :
    inner2 (emb X) (phi (.inr a) (.inl p)) = 0 := by
  rw [inner2_phi_eq']; simp [emb_apply]

theorem inner2_emb_K (X : Matrix (Fin k) (Fin k) ℝ) (a b : Fin m) :
    inner2 (emb X) (phi (.inr a) (.inr b)) = 0 := by
  rw [inner2_phi_eq']; simp [emb_apply]

theorem inner2_emb_J (X : Matrix (Fin k) (Fin k) ℝ) (p q : Fin k) :
    inner2 (emb (m := m) X) (phi (.inl p) (.inl q)) = inner2 X (phi p q) := by
  rw [← emb_phi, inner2_emb]

/-- **`W` on `Λ²ℝ^J` is `R_J`**: `W (emb X) = emb (R X)` at every `X`. -/
theorem blockOpG_emb (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (X : Matrix (Fin k) (Fin k) ℝ) :
    blockOpG R M K (emb X) = emb (opOf R X) := by
  unfold blockOpG opOf
  simp only [Fintype.sum_sum_type, inner2_emb_M, inner2_emb_M', inner2_emb_K, inner2_emb_J, zero_mul, zero_smul,
    Finset.sum_const_zero, add_zero, zero_add, blockCoeffG, mul_zero, smul_zero]
  rw [map_smul, map_sum]
  congr 1
  refine Finset.sum_congr rfl fun p _ => ?_
  rw [map_sum]
  refine Finset.sum_congr rfl fun q _ => ?_
  rw [map_sum]
  refine Finset.sum_congr rfl fun r _ => ?_
  rw [map_sum]
  refine Finset.sum_congr rfl fun s _ => ?_
  rw [map_smul, emb_phi]

theorem blockOpG_M (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (p : Fin k) (a : Fin m) :
    blockOpG R M K (phi (.inl p) (.inr a)) = ∑ q, M a p q • phi (.inl q) (.inr a) := by
  unfold blockOpG
  rw [opOf_phi]
  simp only [Fintype.sum_sum_type, blockCoeffG, sub_self, zero_smul, Finset.sum_const_zero,
    zero_add, add_zero, ite_sub_neg, ite_neg_sub, ite_smul, Finset.sum_ite_eq, Finset.mem_univ,
    if_true, coll_fst]
  simp only [phi_swap (Sum.inr a), smul_neg, neg_smul, Finset.sum_neg_distrib]
  simp only [← Finset.sum_neg_distrib, ← Finset.sum_add_distrib, Finset.smul_sum]
  refine Finset.sum_congr rfl fun q _ => ?_
  module

theorem blockOpG_K_ne (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (a b : Fin m) (hab : a ≠ b) :
    blockOpG R M K (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) := by
  unfold blockOpG
  rw [opOf_phi]
  simp only [Fintype.sum_sum_type, blockCoeffG]
  have e : ∀ x x1 : Fin m,
      ((if a ≠ b ∧ a = x ∧ b = x1 then K a b else if a ≠ b ∧ a = x1 ∧ b = x then -K a b else 0) -
        if b ≠ a ∧ b = x ∧ a = x1 then K b a else if b ≠ a ∧ b = x1 ∧ a = x then -K b a else 0)
      = (if x = a ∧ x1 = b then 2 * K a b else 0) + (if x = b ∧ x1 = a then -(2 * K a b) else 0) := by
    intro x x1
    rw [hK b a]
    by_cases h1 : x = a <;> by_cases h2 : x1 = b <;> by_cases h3 : x = b <;> by_cases h4 : x1 = a <;>
      subst_vars <;> simp_all [eq_comm] <;> ring
  simp only [sub_self, zero_smul, Finset.sum_const_zero, zero_add, e, add_smul, ite_smul,
    Finset.sum_add_distrib, sum_pt]
  rw [phi_swap (Sum.inr a) (Sum.inr b)]
  module

theorem blockOpG_K (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (a b : Fin m) :
    blockOpG R M K (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) := by
  by_cases h : a = b
  · subst h
    rw [phi_self, smul_zero]
    have := opOf_smul (blockCoeffG R M K) 0 0
    rwa [zero_smul, zero_smul] at this
  · exact blockOpG_K_ne R M K hK a b h

theorem trk (A : Matrix (Fin k) (Fin k) ℝ) (hA : A.IsSymm) :
    ∑ i, ∑ j, ∑ l, A i j * A j l * A i l = (A * A * A).trace := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Finset.sum_mul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
  rw [hA.apply i j]

/-- **`tr W³` on the three blocks**: `tr R_J³ + ∑_a tr M_a³ + ∑_{a<b} K_{ab}³`, `tr R_J³` being the layer's `trCube` on `Fin k`. -/
theorem trCube_blockOpG (R : Fin k → Fin k → Fin k → Fin k → ℝ)
    (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) :
    trCube (blockOpG R M K) = trCube (opOf R) + ∑ a, (M a * M a * M a).trace
      + ∑ a, ∑ b, (if a < b then K a b ^ 3 else 0) := by
  set L := opLin (blockCoeffG R M K) with hLdef
  have hL : ∀ X, blockOpG R M K X = L X := fun _ => rfl
  have LM : ∀ a p, L (phi (.inl p) (.inr a)) = ∑ q, M a p q • phi (.inl q) (.inr a) :=
    fun a p => blockOpG_M R M K p a
  have LK : ∀ a b, L (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) :=
    fun a b => blockOpG_K R M K hK a b
  have B1 : ∑ p, ∑ q, inner2 (L (L (phi (.inl p) (.inl q)))) (L (phi (.inl p) (.inl q)))
      = ∑ p, ∑ q, inner2 (opOf R (opOf R (phi p q))) (opOf R (phi p q)) := by
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
    rw [← emb_phi, ← hL, ← hL, blockOpG_emb, blockOpG_emb, inner2_emb]
  have orthM : ∀ a : Fin m, ∀ p q : Fin k,
      inner2 (phi (Sum.inl p : Fin k ⊕ Fin m) (Sum.inr a)) (phi (Sum.inl q) (Sum.inr a))
      = if p = q then 1 else 0 := by
    intro a p q
    rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]; simp
  have B2 : ∑ p, ∑ a, inner2 (L (L (phi (.inl p) (.inr a)))) (L (phi (.inl p) (.inr a)))
      = ∑ a, (M a * M a * M a).trace := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun a _ => by
      rw [tri_orth L (fun p => phi (.inl p) (.inr a)) (M a) (orthM a) (LM a), trk _ (hM a)]
  have B3 : ∑ a, ∑ p, inner2 (L (L (phi (.inr a) (.inl p)))) (L (phi (.inr a) (.inl p)))
      = ∑ a, (M a * M a * M a).trace := by
    rw [← B2, Finset.sum_comm]
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun a _ => ?_
    rw [phi_swap (Sum.inl p) (Sum.inr a), map_neg, map_neg,
      inner2_neg_left', inner2_neg_right', neg_neg]
  have B4 : ∑ a, ∑ b, inner2 (L (L (phi (.inr a) (.inr b)))) (L (phi (.inr a) (.inr b)))
      = 2 * ∑ a, ∑ b, (if a < b then K a b ^ 3 else 0) := by
    rw [← offdiag_sym (fun a b => K a b ^ 3) (fun a b => by rw [hK])]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [LK, map_smul, LK, inner2_smul_left', inner2_smul_left', L226Statement.inner2_smul_right',
      HamiltonsCubic.FamilyLayer.inner2_phi_phi]
    by_cases h : a = b
    · subst h; simp
    · simp [h]; ring
  simp only [trCube, innerOp, compOp, hL, Fintype.sum_sum_type, Finset.sum_add_distrib]
  rw [B1, B2, B3, B4]
  ring

end HamiltonsCubic.L226GenA
