import Mathlib
import HamiltonsCubic.Results.L226Mixed

set_option linter.style.longLine false
set_option linter.unusedTactic false

/-!
# L226, item 2 at every `|J| = k`: the block operator is Weyl exactly when `R_J` is Bianchi and the two Ricci conditions hold

[L226](../../../findings/second-order.md), item 2: *$W\in\mathcal S_J$ lies in $\mathcal W_n$ exactly when $R_J$ satisfies the first
Bianchi identity on $\mathbb R^J$, $\rho(R_J)+\sum_aM_a=0$ with $\rho(R_J)_{pq}=\sum_{r\in J}\langle R_J\varphi_{pr},\varphi_{qr}\rangle$,
and $\operatorname{tr}M_a+\sum_{b\ne a}K_{ab}=0$ at every $a\in A$.* [L226Mixed.lean](L226Mixed.lean) proves it at `k = 3`, where
`R_J` is written through the `ε` table. Here `R_J` is an arbitrary array `R` on `J = Fin k` with the curvature symmetries
(antisymmetric in each pair, pair-symmetric), and the proof is proof step 4 at every `k`:

* `blockCoeffG`, `blockOpG`: the block operator with `R_J`'s entries `R p q r s`, built by `opOf`;
* `pairing_J`: `⟨W φ_pq, φ_rs⟩ = R p q r s` on `J`;
* `Ric_blockOpG_J`, `Ric_blockOpG_outer`, `Ric_blockOpG_Jout`, `Ric_blockOpG_outJ`, `Ric_blockOpG_outer_ne`: the Ricci entries,
  `ρ(R)_pq + Σ_a (M_a)_pq` on `J`, `tr M_a + Σ_b K_ab` on the outer diagonal, zero across blocks;
* `blockCoeffG_symm`, `blockOpG_selfAdjoint`: pair symmetry and self-adjointness;
* `blockOpG_bianchi_J`: on four `J` indices the Bianchi sum is `R`'s;
* **`isWeyl_blockOpG_iff`**: item 2 at every `k`.
-/

namespace HamiltonsCubic.L226Gen

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L226Mixed

variable {k m : ℕ}

/-- **The curvature symmetries of an array on `J`**: antisymmetric in each pair and pair-symmetric. -/
structure IsCurvArray (R : Fin k → Fin k → Fin k → Fin k → ℝ) : Prop where
  anti1 : ∀ p q r s, R q p r s = -R p q r s
  anti2 : ∀ p q r s, R p q s r = -R p q r s
  pair : ∀ p q r s, R r s p q = R p q r s

/-- `ρ(R)_pq = Σ_r R p r q r`, the Ricci contraction on `J`. -/
def rhoJ (R : Fin k → Fin k → Fin k → Fin k → ℝ) : Matrix (Fin k) (Fin k) ℝ := fun p q => ∑ r, R p r q r

/-- First Bianchi on `J`. -/
def BianchiJ (R : Fin k → Fin k → Fin k → Fin k → ℝ) : Prop := ∀ p q r s, R p q r s + R p r s q + R p s q r = 0

/-- **The entries of the block operator** at a general `R_J`. -/
noncomputable def blockCoeffG (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) : Fin k ⊕ Fin m → Fin k ⊕ Fin m → Fin k ⊕ Fin m → Fin k ⊕ Fin m → ℝ
  | .inl p, .inl q, .inl r, .inl s => R p q r s
  | .inl p, .inr a, .inl q, .inr b => if a = b then M a p q else 0
  | .inr a, .inl p, .inl q, .inr b => if a = b then -M a p q else 0
  | .inl p, .inr a, .inr b, .inl q => if a = b then -M a p q else 0
  | .inr a, .inl p, .inr b, .inl q => if a = b then M a p q else 0
  | .inr a, .inr b, .inr c, .inr d =>
      if a ≠ b ∧ a = c ∧ b = d then K a b else if a ≠ b ∧ a = d ∧ b = c then -K a b else 0
  | _, _, _, _ => 0

/-- **The block operator at a general `R_J`.** -/
noncomputable def blockOpG (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) :
    Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ → Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ :=
  opOf (blockCoeffG R M K)

/-- **`⟨W φ_pq, φ_rs⟩ = R p q r s`** on `J`. -/
theorem pairing_J {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (p q r s : Fin k) :
    inner2 (blockOpG R M K (phi (.inl p) (.inl q))) (phi (.inl r) (.inl s)) = R p q r s := by
  unfold blockOpG opOf
  rw [pairing]
  simp only [blockCoeffG]
  rw [hR.anti1 p q r s, hR.anti2 p q r s, hR.anti1 p q s r, hR.anti2 p q r s]
  ring

theorem Ric_blockOpG_J {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R)
    (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ) (p q : Fin k) :
    Ric (blockOpG R M K) (.inl p) (.inl q) = rhoJ R p q + ∑ a, M a p q := by
  unfold Ric blockOpG opOf
  simp only [pairing]
  rw [Fintype.sum_sum_type]
  simp only [blockCoeffG, if_true, rhoJ]
  congr 1
  · refine Finset.sum_congr rfl fun r _ => ?_
    rw [hR.anti1 p r q r, hR.anti2 p r q r, hR.anti1 p r r q, hR.anti2 p r q r]
    ring
  · refine Finset.sum_congr rfl fun a _ => ?_
    ring

theorem Ric_blockOpG_outer (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) (a : Fin m) :
    Ric (blockOpG R M K) (.inr a) (.inr a) = (M a).trace + ∑ b, K a b := by
  unfold Ric blockOpG opOf
  simp only [pairing]
  rw [Fintype.sum_sum_type]
  simp only [blockCoeffG, if_true, and_self, Matrix.trace, Matrix.diag]
  congr 1
  · refine Finset.sum_congr rfl fun p _ => ?_; ring
  · refine Finset.sum_congr rfl fun b _ => ?_
    by_cases hab : a = b
    · subst hab; simp [hK0]
    · simp [hab, Ne.symm hab, hK b a]; ring

theorem Ric_blockOpG_Jout (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (p : Fin k) (a : Fin m) :
    Ric (blockOpG R M K) (.inl p) (.inr a) = 0 := by
  unfold Ric blockOpG opOf
  simp only [pairing]
  rw [Fintype.sum_sum_type]
  simp [blockCoeffG]

theorem Ric_blockOpG_outJ (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (a : Fin m) (p : Fin k) :
    Ric (blockOpG R M K) (.inr a) (.inl p) = 0 := by
  unfold Ric blockOpG opOf
  simp only [pairing]
  rw [Fintype.sum_sum_type]
  simp [blockCoeffG]

theorem Ric_blockOpG_outer_ne (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) {a b : Fin m} (hab : a ≠ b) :
    Ric (blockOpG R M K) (.inr a) (.inr b) = 0 := by
  unfold Ric blockOpG opOf
  simp only [pairing]
  rw [Fintype.sum_sum_type]
  simp only [blockCoeffG]
  have h1 : ∀ c : Fin m, ¬(a = c ∧ c = b) := fun c h => hab (h.1.trans h.2)
  have h2 : ∀ c : Fin m, ¬(c = b ∧ a = c) := fun c h => hab (h.2.trans h.1)
  simp [hab, h1, h2]

/-- **Item 2's Ricci half at every `k`.** -/
theorem ricciFlatG_iff {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R)
    (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a)
    (hK0 : ∀ a, K a a = 0) :
    (∀ i j, Ric (blockOpG R M K) i j = 0) ↔ (rhoJ R + ∑ a, M a = 0 ∧ ∀ a, (M a).trace + ∑ b, K a b = 0) := by
  constructor
  · intro h
    refine ⟨?_, fun a => ?_⟩
    · ext p q
      have := h (.inl p) (.inl q)
      rw [Ric_blockOpG_J hR M K p q] at this
      simpa [Matrix.add_apply, Matrix.sum_apply] using this
    · have := h (.inr a) (.inr a)
      rwa [Ric_blockOpG_outer R M K hK hK0 a] at this
  · rintro ⟨hJ, hA⟩ i j
    rcases i with p | a <;> rcases j with q | b
    · rw [Ric_blockOpG_J hR M K p q]
      have := congrFun (congrFun hJ p) q
      simpa [Matrix.add_apply, Matrix.sum_apply] using this
    · exact Ric_blockOpG_Jout R M K p b
    · exact Ric_blockOpG_outJ R M K a q
    · by_cases hab : a = b
      · subst hab; rw [Ric_blockOpG_outer R M K hK hK0 a]; exact hA a
      · exact Ric_blockOpG_outer_ne R M K hab

/-- **`blockCoeffG` is pair-symmetric.** -/
theorem blockCoeffG_symm {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R)
    (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (i j l t : Fin k ⊕ Fin m) :
    blockCoeffG R M K i j l t = blockCoeffG R M K l t i j := by
  have hM' : ∀ a p q, M a p q = M a q p := fun a p q => (hM a).apply q p
  rcases i with p | a <;> rcases j with q | b <;> rcases l with r | c <;> rcases t with s | d <;>
    simp only [blockCoeffG]
  · exact (hR.pair p q r s).symm
  all_goals first
    | rfl
    | exact K_pat K hK _ _ _ _
    | (split_ifs <;> subst_vars <;>
        first
          | rfl
          | (simp only [hM'] at *; done)
          | (simp at *; done))

theorem blockOpG_selfAdjoint {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R)
    (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (X Y : Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ) :
    inner2 (blockOpG R M K X) Y = inner2 X (blockOpG R M K Y) :=
  opOf_selfAdjoint _ (blockCoeffG_symm hR M hM K hK) X Y

/-- **Bianchi on four `J` indices is `R`'s.** -/
theorem blockOpG_bianchi_J {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R)
    (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ) (p q r s : Fin k) :
    bianchi (blockOpG R M K) (.inl p) (.inl q) (.inl r) (.inl s) = R p q r s + R p r s q + R p s q r := by
  unfold bianchi
  rw [pairing_J hR, pairing_J hR, pairing_J hR]

set_option maxHeartbeats 1000000 in
/-- **Bianchi off the all-`J` block holds for every `R`**, the pair symmetries of `M_a` and `K` doing the work. -/
theorem blockOpG_bianchi_mixed (R : Fin k → Fin k → Fin k → Fin k → ℝ)
    (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (i j l t : Fin k ⊕ Fin m)
    (hJ : ¬ ∃ p q r s, i = .inl p ∧ j = .inl q ∧ l = .inl r ∧ t = .inl s) :
    bianchi (blockOpG R M K) i j l t = 0 := by
  have hM' : ∀ a p q, M a p q = M a q p := fun a p q => (hM a).apply q p
  unfold bianchi blockOpG opOf
  simp only [pairing]
  rcases i with p | a <;> rcases j with q | b <;> rcases l with r | c <;> rcases t with s | d <;>
    simp only [blockCoeffG]
  · exact absurd ⟨p, q, r, s, rfl, rfl, rfl, rfl⟩ hJ
  all_goals first
    | ring1
    | exact bianchi_K K hK _ _ _ _
    | (split_ifs <;> subst_vars <;>
        first
          | ring1
          | (simp at *; done)
          | (rw [hM']; ring1))

/-- **L226, item 2 at every `|J| = k`**: the block operator lies in `𝒲ₙ` exactly when `R_J` satisfies first Bianchi on
`J`, `ρ(R_J) + Σ_a M_a = 0`, and `tr M_a + Σ_b K_ab = 0` at every outer `a`. -/
theorem isWeyl_blockOpG_iff {R : Fin k → Fin k → Fin k → Fin k → ℝ} (hR : IsCurvArray R)
    (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    IsWeyl (blockOpG R M K) ↔
      (BianchiJ R ∧ rhoJ R + ∑ a, M a = 0 ∧ ∀ a, (M a).trace + ∑ b, K a b = 0) := by
  constructor
  · intro h
    refine ⟨fun p q r s => ?_, (ricciFlatG_iff hR M K hK hK0).mp h.2.2.2⟩
    rw [← blockOpG_bianchi_J hR M K p q r s]
    exact h.2.2.1 _ _ _ _
  · rintro ⟨hB, hRic⟩
    refine ⟨fun X _ => opOf_isSkew _ X, fun X Y _ _ => blockOpG_selfAdjoint hR M hM K hK X Y, ?_,
      (ricciFlatG_iff hR M K hK hK0).mpr hRic⟩
    intro i j l t
    by_cases hJ : ∃ p q r s, i = .inl p ∧ j = .inl q ∧ l = .inl r ∧ t = .inl s
    · obtain ⟨p, q, r, s, rfl, rfl, rfl, rfl⟩ := hJ
      rw [blockOpG_bianchi_J hR M K p q r s]
      exact hB p q r s
    · exact blockOpG_bianchi_mixed R M hM K hK i j l t hJ

end HamiltonsCubic.L226Gen
