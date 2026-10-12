import Mathlib
import HamiltonsCubic.Results.L226Statement
import HamiltonsCubic.Results.KyFanPackaging

/-!
# L226, item 2: the mixed Ricci entries of the block operator vanish

[L226](../../../findings/second-order.md), proof step 4: *"For Ricci, `Ric_pq = ρ(R_J)_pq + Σ_a (M_a)_pq`
and `Ric_aa = tr M_a + Σ_{b≠a} K_ab`, while `Ric_pa` and `Ric_ab` pair vectors of different blocks and
vanish."* The diagonal entries are `Ric_blockOp_J` and `Ric_blockOp_outer` in
[L226Statement.lean](L226Statement.lean); this file proves the off-diagonal ones at `|J| = 3`:

* `Ric_blockOp_Jout`: `Ric_pa = 0` for `p ∈ J`, `a` outer;
* `Ric_blockOp_outJ`: `Ric_ap = 0`;
* `Ric_blockOp_outer_ne`: `Ric_ab = 0` for distinct outer `a ≠ b`;
* `ricciFlat_iff`: with the diagonal entries, Ricci-flatness is exactly `ρ(R_J) + Σ_a M_a = 0` and
  `tr M_a + Σ_b K_ab = 0` at every outer `a`, item 2's Ricci half;
* `blockOp_isSkew` and `blockOp_selfAdjoint`: `IsWeyl`'s first two clauses, the second from
  `blockCoeff_symm` (`C_{ijkl} = C_{klij}` under the record's symmetries) and `opOf_selfAdjoint`;
* `blockOp_bianchi`: first Bianchi, `IsWeyl`'s third clause, the all-`J` block by the `ε` table
  (item 3's automatic Bianchi) and the outer block by `bianchi_K`;
* `isWeyl_blockOp_iff`: item 2 at `|J| = 3`, membership in `𝒲ₙ` exactly when the two Ricci
  conditions hold;
* `Pcubic_ricciFlat`: item 3's closing formula, `S = N - ½ (tr N) I` and `P(W) = blockP` there.

Each term of `Ric_ij = Σ_r W_{ir,jr}`, read through `pairing`, is an entry of `blockCoeff` whose index
pattern the block form sets to zero.
-/

namespace HamiltonsCubic.L226Mixed

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement

variable {m : ℕ}

/-- **`Ric_pa = 0`**: a `J` index against an outer one. -/
theorem Ric_blockOp_Jout (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (p : Fin 3) (a : Fin m) :
    Ric (blockOp S M K) (.inl p) (.inr a) = 0 := by
  unfold Ric blockOp
  simp only [pairing]
  rw [Fintype.sum_sum_type]
  simp [blockCoeff]

/-- **`Ric_ap = 0`**: an outer index against a `J` one. -/
theorem Ric_blockOp_outJ (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (a : Fin m) (p : Fin 3) :
    Ric (blockOp S M K) (.inr a) (.inl p) = 0 := by
  unfold Ric blockOp
  simp only [pairing]
  rw [Fintype.sum_sum_type]
  simp [blockCoeff]

/-- **`Ric_ab = 0` for distinct outer indices.** -/
theorem Ric_blockOp_outer_ne (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) {a b : Fin m} (hab : a ≠ b) :
    Ric (blockOp S M K) (.inr a) (.inr b) = 0 := by
  unfold Ric blockOp
  simp only [pairing]
  rw [Fintype.sum_sum_type]
  simp only [blockCoeff]
  have h1 : ∀ c : Fin m, ¬(a = c ∧ c = b) := fun c h => hab (h.1.trans h.2)
  have h2 : ∀ c : Fin m, ¬(c = b ∧ a = c) := fun c h => hab (h.2.trans h.1)
  simp [hab, h1, h2]

/-- **L226, item 2's Ricci half at `|J| = 3`**: the block operator is Ricci-flat exactly when
`ρ(R_J) + Σ_a M_a = 0`, with `ρ(R_J) = (tr S) I - S` (`Ric_blockOp_J`), and `tr M_a + Σ_b K_ab = 0` at
every outer `a` (`Ric_blockOp_outer`), the mixed entries vanishing identically. -/
theorem ricciFlat_iff (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    (∀ i j, Ric (blockOp S M K) i j = 0) ↔
      (S.trace • (1 : Matrix (Fin 3) (Fin 3) ℝ) - S + ∑ a, M a = 0 ∧
        ∀ a, (M a).trace + ∑ b, K a b = 0) := by
  constructor
  · intro h
    refine ⟨?_, fun a => ?_⟩
    · ext p q
      have := h (.inl p) (.inl q)
      rw [Ric_blockOp_J S hS M hM K p q] at this
      simpa [Matrix.add_apply, Matrix.sum_apply] using this
    · have := h (.inr a) (.inr a)
      rwa [Ric_blockOp_outer S M K hK hK0 a] at this
  · rintro ⟨hJ, hA⟩ i j
    rcases i with p | a <;> rcases j with q | b
    · rw [Ric_blockOp_J S hS M hM K p q]
      have := congrFun (congrFun hJ p) q
      simpa [Matrix.add_apply, Matrix.sum_apply] using this
    · exact Ric_blockOp_Jout S M K p b
    · exact Ric_blockOp_outJ S M K a q
    · by_cases hab : a = b
      · subst hab; rw [Ric_blockOp_outer S M K hK hK0 a]; exact hA a
      · exact Ric_blockOp_outer_ne S M K hab

/-- **L226, item 3's closing formula**: at a Ricci-flat block operator, `S = N - ½ (tr N) I` with
`N = Σ_a M_a`, and `P(W)` is `blockP` evaluated there. -/
theorem Pcubic_ricciFlat (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) :
    S = ∑ a, M a - ((1 / 2 : ℝ) * (∑ a, M a).trace) • 1 ∧
      Pcubic (blockOp S M K) = blockP (∑ a, M a - ((1 / 2 : ℝ) * (∑ a, M a).trace) • 1) M K := by
  have hJ := ((ricciFlat_iff S hS M hM K hK hK0).mp hRic).1
  have hS' : S = ∑ a, M a - ((1 / 2 : ℝ) * (∑ a, M a).trace) • 1 :=
    (ricciJ_inverse S (∑ a, M a)).mp (eq_neg_of_add_eq_zero_left hJ)
  refine ⟨hS', ?_⟩
  rw [Pcubic_blockOp S hS M hM K hK hK0, ← hS']

/-- The outer block's entry of `blockCoeff` is pair-symmetric when `K` is symmetric. -/
theorem K_pat (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (a b c d : Fin m) :
    (if a ≠ b ∧ a = c ∧ b = d then K a b else if a ≠ b ∧ a = d ∧ b = c then -K a b else 0) =
      (if c ≠ d ∧ c = a ∧ d = b then K c d else if c ≠ d ∧ c = b ∧ d = a then -K c d else 0) := by
  have h1 := hK a b
  split_ifs <;> grind

/-- **`blockCoeff` is pair-symmetric**, `C_{ijkl} = C_{klij}`, under the record's symmetries of `S`,
`M_a` and `K`. -/
theorem blockCoeff_symm (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (i j k l : Fin 3 ⊕ Fin m) :
    blockCoeff S M K i j k l = blockCoeff S M K k l i j := by
  have hM' : ∀ a p q, M a p q = M a q p := fun a p q => (hM a).apply q p
  rcases i with p | a <;> rcases j with q | b <;> rcases k with r | c <;> rcases l with s | d <;>
    simp only [blockCoeff]
  · rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => ?_
    rw [hS.apply x y]; ring
  all_goals first
    | rfl
    | exact K_pat K hK _ _ _ _
    | (split_ifs <;> subst_vars <;>
        first
          | rfl
          | (simp only [hM'] at *; done)
          | (simp at *; done))

/-- **An operator with pair-symmetric coefficients is self-adjoint** for the `Λ²` pairing. -/
theorem opOf_selfAdjoint {κ : Type*} [Fintype κ] [DecidableEq κ] (C : κ → κ → κ → κ → ℝ)
    (hC : ∀ i j k l, C i j k l = C k l i j) (X Y : Matrix κ κ ℝ) :
    inner2 (opOf C X) Y = inner2 X (opOf C Y) := by
  have e : ∀ A B : Matrix κ κ ℝ, inner2 A B = KyFanPackaging.inner2Form A B := fun A B =>
    (KyFanPackaging.inner2Form_apply A B).symm
  have h : ∀ A B : Matrix κ κ ℝ, inner2 (opOf C A) B = (1 / 4) *
      ∑ i, ∑ j, ∑ k, ∑ l, inner2 A (phi i j) * C i j k l * inner2 (phi k l) B := by
    intro A B
    rw [e, opOf]
    simp only [map_smul, map_sum, LinearMap.smul_apply, LinearMap.sum_apply, smul_eq_mul, ← e]
  rw [h, inner2_comm X, h, RealLayer.sum4_swap]
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  rw [hC k l i j, inner2_comm (phi i j) Y, inner2_comm X (phi k l)]
  ring

/-- **The block operator is self-adjoint**, `IsWeyl`'s second clause, and preserves skew matrices,
its first (`opOf_isSkew`). -/
theorem blockOp_selfAdjoint (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (X Y : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) :
    inner2 (blockOp S M K X) Y = inner2 X (blockOp S M K Y) := by
  rw [blockOp_eq_opOf]
  exact opOf_selfAdjoint _ (blockCoeff_symm S hS M hM K hK) X Y

theorem blockOp_isSkew (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (X : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) :
    IsSkew (blockOp S M K X) := by
  rw [blockOp_eq_opOf]; exact opOf_isSkew _ X

/-- The outer block's entry of `blockCoeff`, `K_ab (δ_ac δ_bd − δ_ad δ_bc)` for `a ≠ b`. -/
noncomputable def kc (K : Fin m → Fin m → ℝ) (a b c d : Fin m) : ℝ :=
  if a ≠ b ∧ a = c ∧ b = d then K a b else if a ≠ b ∧ a = d ∧ b = c then -K a b else 0

/-- Its `pairing` term, `⟨W φ_ab, φ_cd⟩`. -/
noncomputable def pk (K : Fin m → Fin m → ℝ) (a b c d : Fin m) : ℝ :=
  1 / 4 * (kc K a b c d - kc K b a c d - (kc K a b d c - kc K b a d c))

set_option maxHeartbeats 1000000 in
/-- **First Bianchi on the outer block**: the cyclic sum of `pk` over `b, c, d` vanishes for
symmetric `K`, by cases on which of the four outer indices coincide. -/
theorem bianchi_K (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (a b c d : Fin m) :
    pk K a b c d + pk K a c d b + pk K a d b c = 0 := by
  have h1 := hK a b; have h2 := hK a c; have h3 := hK a d
  unfold pk kc
  simp only [@eq_comm _ b a, @eq_comm _ c a, @eq_comm _ d a, @eq_comm _ c b, @eq_comm _ d b,
    @eq_comm _ d c]
  by_cases hab : a = b <;> by_cases hac : a = c <;> by_cases had : a = d <;>
    by_cases hbc : b = c <;> by_cases hbd : b = d <;> by_cases hcd : c = d <;>
    simp only [hab, hac, had, hbc, hbd, hcd, ne_eq, not_true, not_false_eq_true, true_and,
      false_and, and_true, and_false, if_true, if_false] <;>
    first | ring1 | (subst_vars; simp_all)

set_option maxHeartbeats 1000000 in
/-- **First Bianchi for the block operator**, `IsWeyl`'s third clause: at `|J| = 3` every symmetric
`R_J` satisfies it (item 3), and every sum meeting an outer index vanishes by the pair symmetries
(proof step 4). -/
theorem blockOp_bianchi (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (i j k l : Fin 3 ⊕ Fin m) :
    bianchi (blockOp S M K) i j k l = 0 := by
  have hM' : ∀ a p q, M a p q = M a q p := fun a p q => (hM a).apply q p
  have h01 : S 1 0 = S 0 1 := hS.apply 0 1
  have h02 : S 2 0 = S 0 2 := hS.apply 0 2
  have h12 : S 2 1 = S 1 2 := hS.apply 1 2
  unfold bianchi blockOp
  simp only [pairing]
  rcases i with p | a <;> rcases j with q | b <;> rcases k with r | c <;> rcases l with s | d <;>
    simp only [blockCoeff]
  · fin_cases p <;> fin_cases q <;> fin_cases r <;> fin_cases s <;>
      simp [eps_table, E3, Fin.sum_univ_three, h01, h02, h12] <;> ring_nf
  all_goals first
    | ring1
    | exact bianchi_K K hK _ _ _ _
    | (split_ifs <;> subst_vars <;>
        first
          | ring1
          | (simp at *; done)
          | (rw [hM']; ring1))

/-- **L226, item 2 at `|J| = 3`**: the block operator lies in `𝒲ₙ` exactly when
`ρ(R_J) + Σ_a M_a = 0` and `tr M_a + Σ_b K_ab = 0` at every outer `a`, first Bianchi holding
automatically (item 3) and the first two clauses of `IsWeyl` unconditionally. -/
theorem isWeyl_blockOp_iff (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    IsWeyl (blockOp S M K) ↔
      (S.trace • (1 : Matrix (Fin 3) (Fin 3) ℝ) - S + ∑ a, M a = 0 ∧
        ∀ a, (M a).trace + ∑ b, K a b = 0) := by
  constructor
  · intro h
    exact (ricciFlat_iff S hS M hM K hK hK0).mp h.2.2.2
  · intro h
    exact ⟨fun X _ => blockOp_isSkew S M K X,
      fun X Y _ _ => blockOp_selfAdjoint S hS M hM K hK X Y,
      blockOp_bianchi S hS M hM K hK, (ricciFlat_iff S hS M hM K hK hK0).mpr h⟩

end HamiltonsCubic.L226Mixed
