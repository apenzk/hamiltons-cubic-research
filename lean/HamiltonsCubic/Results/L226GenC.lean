import Mathlib
import HamiltonsCubic.Results.L226GenB

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L226 item 1 at every `|J| = k`, part C: the block sums through `V_a`, and item 1

[L226](../../../findings/second-order.md), item 1: *For every $W\in\mathcal S_J$, $P(W)=P(R_J)+\sum_{a\in A}(\operatorname{tr}M_a^3+3
\operatorname{tr}(R_J\Lambda^2M_a))+\sum_{a<b}(K_{ab}^3+3K_{ab}\operatorname{tr}(M_aM_b))+3\sum_{a<b<c}K_{ab}K_{ac}K_{bc}$.* With
[L226GenB.lean](L226GenB.lean)'s nine block sums, the five through `V_a` close here:

* `blockOpG_J`: `W φ_pq = ∑_{uv} ½ R_pquv φ_uv`; `br_JA_JA`, `br_JJ_JA`, `br_JA_AA`, the brackets across the blocks;
* `QG_JA_same`, `QG_JA_diff`, `QG_JA_AA`, `QG_JJ_JA` (through `LJ_br_inner`, `⟨[W φ_pq, φ_sa], φ_wa⟩ = R_pqsw`, and
  self-adjointness): `Q` at every pair of basis vectors meeting `V_a`;
* `Zs R A = ∑ R_pqsw A_ps A_qw`; **`S_JJJA`**, **`S_JAJJ`** `= 2 ∑_a Z(R, M_a)`; **`S_JAJA`** `= ∑_a Z(R, M_a) + ∑_{a≠b} K_ab tr(M_aM_b)`;
  **`S_JAAA`**, **`S_AAJA`** `= ∑_{a≠b} 2K_ab tr(M_aM_b)`;
* **`sharp_formula`**: `8⟨W, W#⟩ = 8⟨R_J, R_J#⟩ + 12 ∑_a Z + 12 ∑_{a≠b} K_ab tr(M_aM_b) + 4 ∑ K_ab K_ad K_bd`;
* **`Pcubic_blockOpG`**: item 1 at every `k`, with `P(R_J)` the layer's `Pcubic (opOf R)` on `Fin k` and `tr(R_J Λ²M) = trRL2 R M`;
* **`trRL2_eq`**: `trRL2 R M = ½ ∑_{pq} ⟨R_J(M φ_pq Mᵀ), φ_pq⟩`, the trace over `Λ²ℝ^J` of `R_J ∘ Λ²M` with `Λ²M : X ↦ M X Mᵀ`,
  `x ∧ y ↦ Mx ∧ My` (`lam2_phi`).

The step from `W ∈ 𝒮_J` to the block form is the block note's argument, untyped as in L226Gen (r1864 O1).
-/

namespace HamiltonsCubic.L226GenC

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L226Mixed HamiltonsCubic.L226Gen
  HamiltonsCubic.L226GenA HamiltonsCubic.L226GenB

variable {k m : ℕ}

local notation "Mt" => Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ

theorem blockOpG_J {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (p q : Fin k) :
    blockOpG R M K (phi (.inl p) (.inl q)) = ∑ u, ∑ v, (R p q u v / 2) • (phi (.inl u) (.inl v) : Mt) := by
  rw [← emb_phi, blockOpG_emb, opOf_phi, map_smul, map_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun u _ => ?_
  rw [map_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun v _ => ?_
  rw [map_smul, emb_phi, smul_smul, hR.anti1]
  congr 1; ring

theorem br_JA_JA (p q : Fin k) (a b : Fin m) :
    br (phi (.inl p) (.inr a) : Mt) (phi (.inl q) (.inr b))
      = (if p = q then phi (.inr a) (.inr b) else 0) + (if a = b then phi (.inl p) (.inl q) else 0) := by
  rw [br_phi_phi]
  by_cases h1 : p = q <;> by_cases h2 : a = b <;> simp [h1, h2]

theorem br_JJ_JA (p q r : Fin k) (a : Fin m) :
    br (phi (.inl p) (.inl q) : Mt) (phi (.inl r) (.inr a))
      = (if p = r then phi (.inl q) (.inr a) else 0) - (if q = r then phi (.inl p) (.inr a) else 0) := by
  rw [br_phi_phi]
  by_cases h1 : p = r <;> by_cases h2 : q = r <;> simp [h1, h2]

theorem br_JA_AA (p : Fin k) (c a b : Fin m) :
    br (phi (.inl p) (.inr c) : Mt) (phi (.inr a) (.inr b))
      = (if c = b then phi (.inl p) (.inr a) else 0) - (if c = a then phi (.inl p) (.inr b) else 0) := by
  rw [br_phi_phi]
  by_cases h1 : c = b <;> by_cases h2 : c = a <;> simp [h1, h2]

/-- `Q(φ_pa, φ_qa) = ∑_{uv} (M_a)_{pu} (M_a)_{qv} R_{uvpq}`. -/
theorem QG_JA_same {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (p q : Fin k) (a : Fin m) :
    QG R M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr a))
      = ∑ u, ∑ v, M a p u * M a q v * R u v p q := by
  have hL : ∀ X, blockOpG R M K X = opLin (blockCoeffG R M K) X := fun _ => rfl
  unfold QG
  rw [blockOpG_M, blockOpG_M, br_JA_JA]
  simp only [phi_self, ite_self, zero_add, if_true]
  simp only [← brB_apply]
  simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, brB_apply, br_JA_JA, phi_self, ite_self,
    zero_add, if_true, hL]
  simp only [inner2_sum_left', inner2_smul_left']
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun u _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun v _ => ?_
  rw [← hL, pairing_J hR]
  ring

/-- `Q(φ_pa, φ_qb) = δ_pq K_ab ∑_u (M_a)_{pu} (M_b)_{qu}` at `a ≠ b`. -/
theorem QG_JA_diff (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (p q : Fin k) (a b : Fin m) (hab : a ≠ b) :
    QG R M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr b))
      = if p = q then K a b * ∑ u, M a p u * M b q u else 0 := by
  have hL : ∀ X, blockOpG R M K X = opLin (blockCoeffG R M K) X := fun _ => rfl
  have hkk : inner2 (phi (Sum.inr a : Fin k ⊕ Fin m) (Sum.inr b)) (phi (Sum.inr a) (Sum.inr b)) = 1 := by
    rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]; simp [hab]
  unfold QG
  rw [blockOpG_M, blockOpG_M, br_JA_JA]
  simp only [hab, if_false, add_zero]
  simp only [← brB_apply]
  simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, brB_apply, br_JA_JA, hab, if_false,
    add_zero, hL]
  simp only [apply_ite (opLin (blockCoeffG R M K)), map_zero]
  simp only [← hL, blockOpG_K R M K hK]
  by_cases hpq : p = q
  · subst hpq
    simp only [if_true, inner2_sum_left', inner2_smul_left', apply_ite (fun X => inner2 X (phi (Sum.inr a) (Sum.inr b) : Mt)),
      inner2_zero_l, hkk, Finset.mul_sum]
    refine Finset.sum_congr rfl fun u _ => ?_
    rw [Finset.sum_eq_single u (fun v _ hv => by simp [hv, Ne.symm hv]) (by simp)]
    simp only [if_true, HamiltonsCubic.L226Statement.inner2_smul_left', hkk]
    ring
  · simp only [hpq, if_false, inner2_zero_r]

/-- `Q(φ_pc, φ_ab)` at `a ≠ b`: only `c = a, b` contribute. -/
theorem QG_JA_AA (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (p : Fin k) (c a b : Fin m) (hab : a ≠ b) :
    QG R M K (phi (.inl p) (.inr c)) (phi (.inr a) (.inr b))
      = (if c = b then K a b * ∑ u, M b p u * M a u p else 0) + (if c = a then K a b * ∑ u, M a p u * M b u p else 0) := by
  have hL : ∀ X, blockOpG R M K X = opLin (blockCoeffG R M K) X := fun _ => rfl
  have hba : b ≠ a := Ne.symm hab
  have orth : ∀ (w p' : Fin k) (d e : Fin m),
      inner2 (phi (Sum.inl w : Fin k ⊕ Fin m) (Sum.inr d)) (phi (Sum.inl p') (Sum.inr e)) = if w = p' ∧ d = e then 1 else 0 := by
    intro w p' d e; rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]; simp
  unfold QG
  rw [blockOpG_M, blockOpG_K R M K hK, br_JA_AA]
  simp only [← brB_apply]
  simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, brB_apply, br_JA_AA]
  by_cases hcb : c = b
  · subst hcb
    simp only [hba, if_true, if_false, sub_zero, hL, map_sum, map_smul]
    simp only [← hL, blockOpG_M, inner2_sum_left', inner2_smul_left', Finset.smul_sum, orth, and_true, mul_ite, mul_one,
      mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true, add_zero, Finset.mul_sum]
    try (refine Finset.sum_congr rfl fun u _ => ?_; ring)
  · by_cases hca : c = a
    · subst hca
      simp only [hcb, if_true, if_false, zero_sub, hL, map_neg, map_sum, map_smul, smul_neg, Finset.sum_neg_distrib]
      simp only [← hL, blockOpG_M, inner2_neg_left', inner2_neg_right', neg_neg, inner2_sum_left', inner2_smul_left',
        Finset.smul_sum, orth, and_true, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true,
        zero_add, Finset.mul_sum]
      try (refine Finset.sum_congr rfl fun u _ => ?_; ring)
    · simp only [hcb, hca, if_false, sub_zero, smul_zero, Finset.sum_const_zero, map_zero, inner2_zero_l, inner2_zero_r,
        add_zero]

/-- **`⟨[W φ_pq, φ_sa], φ_wa⟩ = R_pqsw`.** -/
theorem LJ_br_inner {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (p q s w : Fin k) (a : Fin m) :
    inner2 (br (blockOpG R M K (phi (.inl p) (.inl q))) (phi (.inl s) (.inr a))) (phi (.inl w) (.inr a) : Mt) = R p q s w := by
  have orth : ∀ (x y : Fin k),
      inner2 (phi (Sum.inl x : Fin k ⊕ Fin m) (Sum.inr a)) (phi (Sum.inl y) (Sum.inr a)) = if x = y then 1 else 0 := by
    intro x y; rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]; simp
  rw [blockOpG_J hR]
  simp only [← brB_apply]
  simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, brB_apply, br_JJ_JA]
  simp only [inner2_sum_left', inner2_smul_left', inner2_sub_l, apply_ite (fun X => inner2 X (phi (Sum.inl w) (Sum.inr a) : Mt)),
    inner2_zero_l, orth, mul_sub, mul_ite, mul_one, mul_zero, Finset.sum_sub_distrib]
  simp only [Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true, ite_and]
  rw [Finset.sum_comm (f := fun x y => if x = s then if y = w then R p q x y / 2 else 0 else 0)]
  simp only [Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  rw [hR.anti2 p q w s]
  ring

/-- `Q(φ_pq, φ_ra)` in closed form, through self-adjointness. -/
theorem QG_JJ_JA {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (hM : ∀ a, (M a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (p q r : Fin k) (a : Fin m) :
    QG R M K (phi (.inl p) (.inl q)) (phi (.inl r) (.inr a))
      = ∑ s, M a r s * ((if p = r then ∑ w, M a q w * R p q s w else 0) - (if q = r then ∑ w, M a p w * R p q s w else 0)) := by
  have hL : ∀ X, blockOpG R M K X = opLin (blockCoeffG R M K) X := fun _ => rfl
  have hY : br (blockOpG R M K (phi (.inl p) (.inl q))) (blockOpG R M K (phi (.inl r) (.inr a)))
      = ∑ s, M a r s • br (blockOpG R M K (phi (.inl p) (.inl q))) (phi (.inl s) (.inr a)) := by
    rw [blockOpG_M]
    simp only [← brB_apply, map_sum, map_smul]
  have hZ : blockOpG R M K (br (phi (.inl p) (.inl q)) (phi (.inl r) (.inr a)))
      = (if p = r then ∑ w, M a q w • phi (.inl w) (.inr a) else 0)
        - (if q = r then ∑ w, M a p w • phi (.inl w) (.inr a) else 0) := by
    have L0 : blockOpG R M K (0 : Mt) = 0 := by rw [hL]; exact map_zero _
    rw [br_JJ_JA, hL, map_sub]
    split_ifs <;> simp [← hL, blockOpG_M, L0]
  unfold QG
  rw [blockOpG_selfAdjoint hR M hM K hK, hY, hZ]
  simp only [inner2_sum_left', inner2_smul_left', inner2_sub_r]
  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun s _ => ?_
  by_cases hpr : p = r <;> by_cases hqr : q = r <;>
    simp only [hpr, hqr, if_true, if_false, inner2_zero_r, inner2_sum_right', L226Statement.inner2_smul_right',
      LJ_br_inner hR, mul_zero, sub_zero, zero_sub] <;> ring

/-- `Z(R, M) = ∑_{pqsw} R_pqsw M_ps M_qw`, twice `tr(R_J Λ²M)`. -/
def Zs (R : Fin k → Fin k → Fin k → Fin k → ℝ) (A : Matrix (Fin k) (Fin k) ℝ) : ℝ :=
  ∑ p, ∑ q, ∑ s, ∑ w, R p q s w * A p s * A q w

theorem QG_zero_right (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ)
    (X : Mt) : QG R M K X 0 = 0 := by
  unfold QG
  have : br X (0 : Mt) = 0 := by simp [br]
  rw [this, inner2_zero_r]

theorem collapse_r (A : Matrix (Fin k) (Fin k) ℝ) (p q : Fin k) (F G : Fin k → ℝ) :
    ∑ r, ∑ s, A r s * ((if p = r then F s else 0) - (if q = r then G s else 0)) = ∑ s, (A p s * F s - A q s * G s) := by
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun s _ => ?_
  simp only [mul_sub, mul_ite, mul_zero, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]

theorem Zs_swap (R : Fin k → Fin k → Fin k → Fin k → ℝ) (hR : IsCurvArray R) (A : Matrix (Fin k) (Fin k) ℝ) :
    ∑ p, ∑ q, ∑ s, A q s * ∑ w, A p w * R p q s w = -Zs R A := by
  unfold Zs
  rw [Finset.sum_comm, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun p _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun q _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun s _ => ?_
  rw [Finset.mul_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun w _ => ?_
  rw [hR.anti1 q p s w]
  ring

theorem Zs_direct (R : Fin k → Fin k → Fin k → Fin k → ℝ) (A : Matrix (Fin k) (Fin k) ℝ) :
    ∑ p, ∑ q, ∑ s, A p s * ∑ w, A q w * R p q s w = Zs R A := by
  unfold Zs
  refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun s _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun w _ => ?_
  ring

/-- **`S₂`**: the `J`-`V` block is `2 ∑_a Z(R, M_a)`. -/
theorem S_JJJA {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (hM : ∀ a, (M a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) :
    (∑ p, ∑ q, ∑ r, ∑ a, QG R M K (phi (.inl p) (.inl q)) (phi (.inl r) (.inr a))) = ∑ a, 2 * Zs R (M a) := by
  simp only [QG_JJ_JA hR M hM K hK]
  have step : ∀ p q : Fin k, ∑ r, ∑ a, ∑ s, M a r s * ((if p = r then ∑ w, M a q w * R p q s w else 0)
      - (if q = r then ∑ w, M a p w * R p q s w else 0))
      = ∑ a, ∑ s, (M a p s * ∑ w, M a q w * R p q s w - M a q s * ∑ w, M a p w * R p q s w) := by
    intro p q
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun a _ => collapse_r (M a) p q _ _
  simp only [step]
  rw [rot3' (fun p q a => ∑ s, (M a p s * ∑ w, M a q w * R p q s w - M a q s * ∑ w, M a p w * R p q s w))]
  refine Finset.sum_congr rfl fun a _ => ?_
  simp only [Finset.sum_sub_distrib]
  rw [Zs_direct, Zs_swap R hR]
  ring

/-- **`S₄`**: the `V`-`J` block equals `S₂`. -/
theorem S_JAJJ {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (hM : ∀ a, (M a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) :
    (∑ p, ∑ a, ∑ q, ∑ r, QG R M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inl r))) = ∑ a, 2 * Zs R (M a) := by
  rw [← S_JJJA hR M hM K hK, sum4_swap']
  refine Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun r _ => ?_
  refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun a _ => ?_
  rw [QG_symm]

/-- `∑_{pu} A_pu B_pu = tr(AB)` at a symmetric `B`. -/
theorem trace_sym (A B : Matrix (Fin k) (Fin k) ℝ) (hB : B.IsSymm) :
    ∑ p, ∑ u, A p u * B p u = (A * B).trace := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
  refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun u _ => ?_
  rw [hB.apply p u]

/-- **`S₅`**: the `V`-`V` block is `∑_a Z(R, M_a) + ∑_{a ≠ b} K_ab tr(M_a M_b)`. -/
theorem S_JAJA {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (hM : ∀ a, (M a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) :
    (∑ p, ∑ a, ∑ q, ∑ b, QG R M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr b)))
      = ∑ a, Zs R (M a) + ∑ a, ∑ b, (if a = b then 0 else K a b * (M a * M b).trace) := by
  rw [perm_MM]
  rw [split_diag]
  congr 1
  · refine Finset.sum_congr rfl fun a _ => ?_
    simp only [QG_JA_same hR M K]
    unfold Zs
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun u _ =>
      Finset.sum_congr rfl fun v _ => ?_
    rw [hR.pair p q u v]
    ring
  · refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    by_cases hab : a = b
    · simp [hab]
    · simp only [hab, not_false_eq_true, if_true, if_false, QG_JA_diff R M K hK _ _ a b hab]
      simp only [Finset.sum_ite_eq, Finset.mem_univ, if_true, ← Finset.mul_sum]
      rw [trace_sym _ _ (hM b)]

/-- **`S₆`**: the `V`-`A` block is `∑_{a ≠ b} 2 K_ab tr(M_a M_b)`. -/
theorem S_JAAA (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) :
    (∑ p, ∑ c, ∑ a, ∑ b, QG R M K (phi (.inl p) (.inr c)) (phi (.inr a) (.inr b)))
      = ∑ a, ∑ b, (if a = b then 0 else 2 * (K a b * (M a * M b).trace)) := by
  rw [sum4_swap']
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  by_cases hab : a = b
  · subst hab
    simp only [phi_self, QG_zero_right, Finset.sum_const_zero, if_true]
  · simp only [hab, if_false, QG_JA_AA R M K hK _ _ a b hab, Finset.sum_add_distrib]
    simp only [Finset.sum_ite_eq', Finset.mem_univ, if_true, ← Finset.mul_sum]
    have t1 : ∑ p, ∑ u, M b p u * M a u p = (M a * M b).trace := by
      rw [Matrix.trace_mul_comm]; simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
    have t2 : ∑ p, ∑ u, M a p u * M b u p = (M a * M b).trace := by
      simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
    rw [t1, t2]
    ring

/-- **`S₈`**: the `A`-`V` block equals `S₆`. -/
theorem S_AAJA (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) :
    (∑ a, ∑ b, ∑ p, ∑ c, QG R M K (phi (.inr a) (.inr b)) (phi (.inl p) (.inr c)))
      = ∑ a, ∑ b, (if a = b then 0 else 2 * (K a b * (M a * M b).trace)) := by
  rw [← S_JAAA R M K hK, sum4_swap']
  refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun a _ =>
    Finset.sum_congr rfl fun b _ => ?_
  rw [QG_symm]

/-- **The sharp pairing on the block form.** -/
theorem sharp_formula {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (hM : ∀ a, (M a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    8 * sharpPair (blockOpG R M K) = 8 * sharpPair (opOf R) + 12 * ∑ a, Zs R (M a)
      + 12 * ∑ a, ∑ b, (if a = b then 0 else K a b * (M a * M b).trace)
      + 4 * ∑ a, ∑ b, ∑ d, K a b * K a d * K b d := by
  rw [sharp_split, S_JJJJ, S_JJJA hR M hM K hK, S_JJAA, S_JAJJ hR M hM K hK, S_JAJA hR M hM K hK, S_JAAA R M K hK,
    S_AAJJ, S_AAJA R M K hK, S_AAAA R M K hK hK0]
  have h2 : ∑ a, ∑ b, (if a = b then (0 : ℝ) else 2 * (K a b * (M a * M b).trace))
      = 2 * ∑ a, ∑ b, (if a = b then 0 else K a b * (M a * M b).trace) := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    split_ifs <;> ring
  have hz : ∑ a, 2 * Zs R (M a) = 2 * ∑ a, Zs R (M a) := by rw [Finset.mul_sum]
  rw [h2, hz]
  ring

/-- **`tr(R_J Λ²M)`** in coordinates, `½ ∑ R_pqsw M_ps M_qw`. -/
noncomputable def trRL2 (R : Fin k → Fin k → Fin k → Fin k → ℝ) (A : Matrix (Fin k) (Fin k) ℝ) : ℝ := Zs R A / 2

theorem ite_eq_not (c : Prop) [Decidable c] (x : ℝ) : (if c then 0 else x) = if ¬c then x else 0 := by
  split_ifs <;> simp_all

/-- **L226 item 1 at every `|J| = k`**: for `W` the block operator of `(R_J, M, K)`,
`P(W) = P(R_J) + ∑_a (tr M_a³ + 3 tr(R_J Λ²M_a)) + ∑_{a<b} (K_ab³ + 3 K_ab tr(M_a M_b)) + 3 ∑_{a<b<c} K_ab K_ac K_bc`. -/
theorem Pcubic_blockOpG {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (hM : ∀ a, (M a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    Pcubic (blockOpG R M K) = Pcubic (opOf R) + ∑ a, ((M a * M a * M a).trace + 3 * trRL2 R (M a))
      + ∑ a, ∑ b, (if a < b then K a b ^ 3 + 3 * (K a b * (M a * M b).trace) else 0)
      + 3 * ∑ a, ∑ b, ∑ c, (if a < b ∧ b < c then K a b * K a c * K b c else 0) := by
  have hs := sharp_formula hR M hM K hK hK0
  have ht := trCube_blockOpG R M hM K hK
  have hsym : ∀ a b, K a b * (M a * M b).trace = K b a * (M b * M a).trace := fun a b => by
    rw [hK a b, Matrix.trace_mul_comm]
  have hoff := offdiag_sym (fun a b => K a b * (M a * M b).trace) hsym
  simp only [← ite_eq_not] at hoff
  have htri := tri6 K hK hK0
  have e1 : ∑ a, ((M a * M a * M a).trace + 3 * trRL2 R (M a)) = ∑ a, (M a * M a * M a).trace + 3 / 2 * ∑ a, Zs R (M a) := by
    rw [Finset.sum_add_distrib, Finset.mul_sum]
    congr 1
    refine Finset.sum_congr rfl fun a _ => ?_
    unfold trRL2; ring
  have e2 : ∑ a, ∑ b, (if a < b then K a b ^ 3 + 3 * (K a b * (M a * M b).trace) else 0)
      = ∑ a, ∑ b, (if a < b then K a b ^ 3 else 0) + 3 * ∑ a, ∑ b, (if a < b then K a b * (M a * M b).trace else 0) := by
    rw [Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    split_ifs <;> ring
  unfold Pcubic
  rw [e1, e2, ht]
  linarith

/-- `M φ_pq Mᵀ = ∑_{sw} M_sp M_wq φ_sw`, the action `x ∧ y ↦ Mx ∧ My` on the basis. -/
theorem lam2_phi (A : Matrix (Fin k) (Fin k) ℝ) (p q : Fin k) :
    A * phi p q * Aᵀ = ∑ s, ∑ w, (A s p * A w q) • phi s w := by
  ext i j
  simp only [phi, Matrix.mul_apply, Matrix.sub_apply, Matrix.single_apply, Matrix.transpose_apply, Matrix.sum_apply,
    Matrix.smul_apply, smul_eq_mul, mul_sub, sub_mul, Finset.sum_sub_distrib, mul_ite, ite_mul, mul_one, one_mul,
    mul_zero, zero_mul, ite_and]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq']
  try ring

/-- **`trRL2` is `tr(R_J Λ²M)`**: `½ ∑_{pq} ⟨R_J(M φ_pq Mᵀ), φ_pq⟩`, the trace over `Λ²ℝ^J` of `R_J` composed with
`Λ²M : X ↦ M X Mᵀ` (`x ∧ y ↦ Mx ∧ My`). -/
theorem trRL2_eq {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (A : Matrix (Fin k) (Fin k) ℝ) :
    (1 / 2) * ∑ p, ∑ q, inner2 (opOf R (A * phi p q * Aᵀ)) (phi p q) = trRL2 R A := by
  have hop : ∀ s w p q : Fin k, inner2 (opOf R (phi s w)) (phi p q) = R s w p q := by
    intro s w p q
    unfold opOf
    rw [pairing]
    rw [hR.anti1 s w p q, hR.anti2 s w p q, hR.anti1 s w q p, hR.anti2 s w p q]
    ring
  have hsum : ∀ p q : Fin k, inner2 (opOf R (∑ s, ∑ w, (A s p * A w q) • phi s w)) (phi p q)
      = ∑ s, ∑ w, A s p * A w q * R s w p q := by
    intro p q
    have hl : opOf R (∑ s, ∑ w, (A s p * A w q) • phi s w) = ∑ s, ∑ w, (A s p * A w q) • opOf R (phi s w) := by
      change opLin R _ = _
      simp only [map_sum, map_smul]
      rfl
    rw [hl]
    simp only [inner2_sum_left', HamiltonsCubic.L226Statement.inner2_smul_left', hop]
  unfold trRL2 Zs
  simp only [lam2_phi, hsum]
  have key : ∑ p, ∑ q, ∑ s, ∑ w, A s p * A w q * R s w p q = ∑ p, ∑ q, ∑ s, ∑ w, R p q s w * A p s * A q w := by
    rw [sum4_swap']
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun s _ =>
      Finset.sum_congr rfl fun w _ => ?_
    ring
  rw [key]
  ring

end HamiltonsCubic.L226GenC
