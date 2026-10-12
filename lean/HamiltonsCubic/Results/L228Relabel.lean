import Mathlib
import HamiltonsCubic.Results.L228Item4

set_option linter.style.longLine false

/-!
# L228: items 2, 3 and 4 at arbitrary blocks

[L228Item2.lean](L228Item2.lean), [L228Item3.lean](L228Item3.lean) and [L228Item4.lean](L228Item4.lean) state L228's items 2, 3
and 4 at the blocks `0` and `0, 1`; the record states them for every block `a` and every pair `a ≠ b`. A permutation `σ` of the outer indices
changes neither `P`, nor the norm, nor Ricci-flatness of a block operator. This file:

* `sum_lt_perm`, `six_orders`, `sum_distinct`, `sum_lt3_perm`: sums over `a < b` and `a < b < c` of symmetric
  summands are `½` and `⅙` of the sums over distinct indices, so they are permutation-invariant;
* `blockP_perm`, `normSq_perm`, `ricci_perm`: `blockP`, L226's norm formula and Ricci-flatness are invariant under
  `M ↦ M ∘ σ`, `K ↦ K(σ ·, σ ·)`;
* `perm_transfer`, `relabel_bound`: so a bound proved for relabelled data holds for the data;
* `L228_item2_any`, `L228_item3_any`, `L228_item4_any`: items 2, 3 and 4 at every block `a` and every pair `a ≠ b`.
-/

namespace HamiltonsCubic.L228Relabel

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L226Mixed
  HamiltonsCubic.L228Item1 HamiltonsCubic.L228Item3 HamiltonsCubic.L228Item4 HamiltonsCubic.L57Block

variable {m : ℕ}

/-- Ordered pairs: `∑_{a<b} g = ½ ∑_{a≠b} g` for symmetric `g`. -/
theorem sum_lt_perm (g : Fin m → Fin m → ℝ) (hg : ∀ a b, g a b = g b a) (σ : Equiv.Perm (Fin m)) :
    ∑ a, ∑ b, (if a < b then g (σ a) (σ b) else 0) = ∑ a, ∑ b, (if a < b then g a b else 0) := by
  have h1 := sum_ne_eq_two_lt (fun a b => g (σ a) (σ b)) (fun a b => hg _ _)
  have h2 := sum_ne_eq_two_lt g hg
  have h3 : ∑ a, ∑ b, (if a ≠ b then g (σ a) (σ b) else 0) = ∑ a, ∑ b, (if a ≠ b then g a b else 0) := by
    rw [← Equiv.sum_comp σ.symm]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Equiv.sum_comp σ.symm]
    refine Finset.sum_congr rfl fun b _ => ?_
    simp only [Equiv.apply_symm_apply, ne_eq, σ.symm.injective.eq_iff]
  linarith

/-- A triple sum. -/
def S3 (F : Fin m → Fin m → Fin m → ℝ) : ℝ := ∑ a, ∑ b, ∑ c, F a b c

theorem S3_outer (F : Fin m → Fin m → Fin m → ℝ) : S3 (fun a b c => F b a c) = S3 F := by
  unfold S3; exact Finset.sum_comm

theorem S3_inner (F : Fin m → Fin m → Fin m → ℝ) : S3 (fun a b c => F a c b) = S3 F := by
  unfold S3; exact Finset.sum_congr rfl fun a _ => Finset.sum_comm

theorem S3_add (F G : Fin m → Fin m → Fin m → ℝ) : S3 (fun a b c => F a b c + G a b c) = S3 F + S3 G := by
  unfold S3; simp only [Finset.sum_add_distrib]

/-- The six orders of three indices: exactly one holds when they are distinct, none otherwise. -/
theorem six_orders (a b c : Fin m) (x : ℝ) :
    (if a ≠ b ∧ a ≠ c ∧ b ≠ c then x else 0)
      = (if a < b ∧ b < c then x else 0) + (if a < c ∧ c < b then x else 0) + (if b < a ∧ a < c then x else 0)
        + (if b < c ∧ c < a then x else 0) + (if c < a ∧ a < b then x else 0) + (if c < b ∧ b < a then x else 0) := by
  simp only [ne_eq, Fin.ext_iff, Fin.lt_iff_val_lt_val]
  split_ifs <;> first | ring1 | (exfalso; omega)

/-- **Distinct triples are six times the increasing ones**, for a totally symmetric summand. -/
theorem sum_distinct (h : Fin m → Fin m → Fin m → ℝ) (h12 : ∀ a b c, h a b c = h b a c)
    (h23 : ∀ a b c, h a b c = h a c b) :
    S3 (fun a b c => if a ≠ b ∧ a ≠ c ∧ b ≠ c then h a b c else 0)
      = 6 * S3 (fun a b c => if a < b ∧ b < c then h a b c else 0) := by
  set G : Fin m → Fin m → Fin m → ℝ := fun a b c => if a < b ∧ b < c then h a b c else 0 with hG
  have hpt : ∀ a b c, (if a ≠ b ∧ a ≠ c ∧ b ≠ c then h a b c else 0)
      = G a b c + G a c b + G b a c + G b c a + G c a b + G c b a := by
    intro a b c
    rw [six_orders a b c (h a b c)]
    have e1 : h a c b = h a b c := (h23 a b c).symm
    have e2 : h b a c = h a b c := (h12 a b c).symm
    have e4 : h c a b = h a b c := by rw [h12 c a b, ← h23 a b c]
    have e3 : h b c a = h a b c := by rw [h12 b c a, h23 c b a, e4]
    have e5 : h c b a = h a b c := by rw [h23 c b a, e4]
    simp only [hG, e1, e2, e3, e4, e5]
  have hS : S3 (fun a b c => if a ≠ b ∧ a ≠ c ∧ b ≠ c then h a b c else 0)
      = S3 (fun a b c => G a b c + G a c b + G b a c + G b c a + G c a b + G c b a) := by
    unfold S3; simp only [hpt]
  rw [hS]
  simp only [S3_add]
  have k1 : S3 (fun a b c => G a c b) = S3 G := S3_inner G
  have k2 : S3 (fun a b c => G b a c) = S3 G := S3_outer G
  have k3 : S3 (fun a b c => G b c a) = S3 G := by
    rw [show (fun a b c => G b c a) = (fun a b c => (fun a b c => G a c b) b a c) from rfl, S3_outer, k1]
  have k4 : S3 (fun a b c => G c a b) = S3 G := by
    rw [show (fun a b c => G c a b) = (fun a b c => (fun a b c => G b a c) a c b) from rfl, S3_inner, k2]
  have k5 : S3 (fun a b c => G c b a) = S3 G := by
    rw [show (fun a b c => G c b a) = (fun a b c => (fun a b c => G c a b) b a c) from rfl, S3_outer, k4]
  rw [k1, k2, k3, k4, k5]
  ring

/-- Increasing triples of a totally symmetric summand are permutation-invariant. -/
theorem sum_lt3_perm (h : Fin m → Fin m → Fin m → ℝ) (h12 : ∀ a b c, h a b c = h b a c)
    (h23 : ∀ a b c, h a b c = h a c b) (σ : Equiv.Perm (Fin m)) :
    S3 (fun a b c => if a < b ∧ b < c then h (σ a) (σ b) (σ c) else 0)
      = S3 (fun a b c => if a < b ∧ b < c then h a b c else 0) := by
  have d1 := sum_distinct (fun a b c => h (σ a) (σ b) (σ c)) (fun a b c => h12 _ _ _) (fun a b c => h23 _ _ _)
  have d2 := sum_distinct h h12 h23
  have d3 : S3 (fun a b c => if a ≠ b ∧ a ≠ c ∧ b ≠ c then h (σ a) (σ b) (σ c) else 0)
      = S3 (fun a b c => if a ≠ b ∧ a ≠ c ∧ b ≠ c then h a b c else 0) := by
    unfold S3
    rw [← Equiv.sum_comp σ.symm]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Equiv.sum_comp σ.symm]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← Equiv.sum_comp σ.symm]
    refine Finset.sum_congr rfl fun c _ => ?_
    simp only [Equiv.apply_symm_apply, ne_eq, σ.symm.injective.eq_iff]
  linarith

/-- **`blockP` is invariant under a permutation of the outer indices.** -/
theorem blockP_perm (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (σ : Equiv.Perm (Fin m)) :
    blockP S (fun a => M (σ a)) (fun a b => K (σ a) (σ b)) = blockP S M K := by
  unfold blockP
  have h1 : ∑ a, ((M (σ a) * M (σ a) * M (σ a)).trace + 3 * (S * (M (σ a)).adjugate).trace)
      = ∑ a, ((M a * M a * M a).trace + 3 * (S * (M a).adjugate).trace) :=
    Equiv.sum_comp σ (fun a => (M a * M a * M a).trace + 3 * (S * (M a).adjugate).trace)
  have h2 := sum_lt_perm (fun a b => K a b ^ 3 + 3 * K a b * (M a * M b).trace)
    (fun a b => by rw [hK, Matrix.trace_mul_comm]) σ
  have h3 := sum_lt3_perm (fun a b c => K a b * K a c * K b c)
    (fun a b c => by rw [hK a b, hK a c]; ring)
    (fun a b c => by rw [hK b c]; ring) σ
  unfold S3 at h3
  simp only at h2 h3
  rw [h1, h2, h3]

/-- **And so is L226's norm formula.** -/
theorem normSq_perm (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (σ : Equiv.Perm (Fin m)) :
    (S * S).trace + ∑ a, (M (σ a) * M (σ a)).trace + ∑ a, ∑ b, (if a < b then K (σ a) (σ b) ^ 2 else 0)
      = (S * S).trace + ∑ a, (M a * M a).trace + ∑ a, ∑ b, (if a < b then K a b ^ 2 else 0) := by
  rw [Equiv.sum_comp σ (fun a => (M a * M a).trace),
    sum_lt_perm (fun a b => K a b ^ 2) (fun a b => by rw [hK]) σ]

/-- **And Ricci-flatness.** -/
theorem ricci_perm (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (hM : ∀ a, (M a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) (σ : Equiv.Perm (Fin m)) :
    ∀ i j, Ric (blockOp S (fun a => M (σ a)) (fun a b => K (σ a) (σ b))) i j = 0 := by
  obtain ⟨hJ, hO⟩ := (ricciFlat_iff S hS M hM K hK hK0).mp hRic
  refine (ricciFlat_iff S hS _ (fun a => hM _) _ (fun a b => hK _ _) (fun a => hK0 _)).mpr ⟨?_, fun a => ?_⟩
  · rw [Equiv.sum_comp σ M]; exact hJ
  · rw [Equiv.sum_comp σ (fun b => K (σ a) b)]; exact hO (σ a)

/-- **`P` and the norm are invariant under relabelling the outer indices.** -/
theorem perm_transfer (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (hM : ∀ a, (M a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (σ : Equiv.Perm (Fin m)) :
    Pcubic (blockOp S (fun a => M (σ a)) (fun a b => K (σ a) (σ b))) = Pcubic (blockOp S M K) ∧
      HamiltonsCubic.RealLayer.norm (blockOp S (fun a => M (σ a)) (fun a b => K (σ a) (σ b)))
        = HamiltonsCubic.RealLayer.norm (blockOp S M K) := by
  refine ⟨?_, ?_⟩
  · rw [Pcubic_blockOp S hS _ (fun a => hM _) _ (fun a b => hK _ _) (fun a => hK0 _), Pcubic_blockOp S hS M hM K hK hK0,
      blockP_perm S M K hK σ]
  · unfold HamiltonsCubic.RealLayer.norm
    rw [normSq_blockOp S hS _ (fun a => hM _) _ (fun a b => hK _ _) (fun a => hK0 _), normSq_blockOp S hS M hM K hK hK0,
      normSq_perm S M K hK σ]

theorem normal_symm (t : Fin m → ℝ) (Xs : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hXs : ∀ a, (Xs a).IsSymm) :
    (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ)).IsSymm ∧
      ∀ a, (t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a).IsSymm := by
  refine ⟨?_, fun a => ?_⟩
  · unfold Matrix.IsSymm
    rw [Matrix.transpose_sub, Matrix.transpose_smul, Matrix.transpose_one, (isSymm_sum _ _ hXs).eq]
  · unfold Matrix.IsSymm
    rw [Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_one, (hXs a).eq]

/-- **Relabelling a bound**: a bound proved for the relabelled data holds for the data. -/
theorem relabel_bound (c : ℝ) (t : Fin m → ℝ) (Xs : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) (σ : Equiv.Perm (Fin m))
    (h : Pcubic (blockOp (∑ a, Xs (σ a) - ((∑ a, t (σ a)) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t (σ a) • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs (σ a)) (fun a b => K (σ a) (σ b)))
      ≤ c * HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs (σ a) - ((∑ a, t (σ a)) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t (σ a) • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs (σ a)) (fun a b => K (σ a) (σ b))) ^ 3) :
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ c * HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) ^ 3 := by
  rw [Equiv.sum_comp σ Xs, Equiv.sum_comp σ t] at h
  obtain ⟨hS, hM⟩ := normal_symm t Xs hXs
  obtain ⟨hP, hN⟩ := perm_transfer _ hS (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) hM K hK hK0 σ
  rw [hP, hN] at h
  exact h

/-- **L228 item 3 at every block `a`**: if the blocks other than `a` are simultaneously diagonal in `F`, a Ricci-flat
`W` obeys every bound its diagonal tensors obey. -/
theorem L228_item3_any (c : ℝ)
    (hc : ∀ w : Matrix (Fin 3 ⊕ Fin (m + 1)) (Fin 3 ⊕ Fin (m + 1)) ℝ, HamiltonsCubic.FamilyLayer.IsWeight w →
      Pcubic (HamiltonsCubic.FamilyLayer.diagOp w) ≤ c * HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) ^ 3)
    (t : Fin (m + 1) → ℝ) (Xs : Fin (m + 1) → Matrix (Fin 3) (Fin 3) ℝ)
    (hX : ∀ a, (Xs a).trace = 0) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin (m + 1) → Fin (m + 1) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (a : Fin (m + 1)) (hdiag : ∀ d, d ≠ a → DiagIn F (Xs d)) :
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ c * HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
          (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) ^ 3 := by
  set σ : Equiv.Perm (Fin (m + 1)) := Equiv.swap 0 a with hσ
  have hσ0 : σ 0 = a := Equiv.swap_apply_left _ _
  refine relabel_bound c t Xs hXs K hK hK0 σ ?_
  obtain ⟨hS, hM⟩ := normal_symm t Xs hXs
  have hRic' := ricci_perm _ hS _ hM K hK hK0 hRic σ
  rw [← Equiv.sum_comp σ Xs, ← Equiv.sum_comp σ t] at hRic'
  refine L228_item3_of c hc (fun d => t (σ d)) (fun d => Xs (σ d)) (fun d => hX _) (fun d => hXs _)
    (fun d e => K (σ d) (σ e)) (fun d e => hK _ _) (fun d => hK0 _) hRic' F hF1 hF2 (fun i => hdiag _ ?_)
  intro h
  rw [← hσ0] at h
  exact Fin.succ_ne_zero i (σ.injective h)

/-- **L228 item 4 at every pair `a ≠ b`.** -/
theorem L228_item4_any (c : ℝ)
    (hc : ∀ w : Matrix (Fin 3 ⊕ Fin (m + 2)) (Fin 3 ⊕ Fin (m + 2)) ℝ, HamiltonsCubic.FamilyLayer.IsWeight w →
      Pcubic (HamiltonsCubic.FamilyLayer.diagOp w) ≤ c * HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) ^ 3)
    (t : Fin (m + 2) → ℝ) (Xs : Fin (m + 2) → Matrix (Fin 3) (Fin 3) ℝ)
    (hX : ∀ a, (Xs a).trace = 0) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin (m + 2) → Fin (m + 2) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) i j = 0)
    (F : Matrix (Fin 3) (Fin 3) ℝ) (hF1 : Fᵀ * F = 1) (hF2 : F * Fᵀ = 1)
    (a b : Fin (m + 2)) (hab : a ≠ b) (hUd : DiagIn F (Xs a + Xs b))
    (hrest : ∀ d, d ≠ a → d ≠ b → DiagIn F (Xs d)) :
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
      ≤ c * HamiltonsCubic.RealLayer.norm (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
          (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) ^ 3 := by
  set τ : Equiv.Perm (Fin (m + 2)) := Equiv.swap 0 a with hτ
  set σ : Equiv.Perm (Fin (m + 2)) := τ * Equiv.swap 1 (τ b) with hσ
  have hτb : τ b ≠ 0 := by
    intro h
    have : τ b = τ a := by rw [h, hτ, Equiv.swap_apply_right]
    exact hab (τ.injective this).symm
  have hσ0 : σ 0 = a := by
    rw [hσ, Equiv.Perm.mul_apply, Equiv.swap_apply_of_ne_of_ne (fun h => by simp [Fin.ext_iff] at h) (Ne.symm hτb), hτ, Equiv.swap_apply_left]
  have hσ1 : σ 1 = b := by
    rw [hσ, Equiv.Perm.mul_apply, Equiv.swap_apply_left, hτ, Equiv.swap_apply_self]
  refine relabel_bound c t Xs hXs K hK hK0 σ ?_
  obtain ⟨hS, hM⟩ := normal_symm t Xs hXs
  have hRic' := ricci_perm _ hS _ hM K hK hK0 hRic σ
  rw [← Equiv.sum_comp σ Xs, ← Equiv.sum_comp σ t] at hRic'
  refine L228_item4_of c hc (fun d => t (σ d)) (fun d => Xs (σ d)) (fun d => hX _) (fun d => hXs _)
    (fun d e => K (σ d) (σ e)) (fun d e => hK _ _) (fun d => hK0 _) hRic' F hF1 hF2 ?_ (fun i => hrest _ ?_ ?_)
  · show DiagIn F (Xs (σ 0) + Xs (σ 1))
    rw [hσ0, hσ1]; exact hUd
  · intro h
    rw [← hσ0] at h
    exact Fin.succ_ne_zero _ (σ.injective h)
  · intro h
    rw [← hσ1] at h
    have := σ.injective h
    exact Fin.succ_ne_zero i (Fin.succ_injective _ (this.trans Fin.succ_zero_eq_one.symm))

/-- **L228 item 2 at every block**: at the block `σ 0`, with the other blocks enumerated as `σ (i + 1)`. -/
theorem L228_item2_any (t : Fin (m + 1) → ℝ) (Xs : Fin (m + 1) → Matrix (Fin 3) (Fin 3) ℝ)
    (hX : ∀ a, (Xs a).trace = 0) (hXs : ∀ a, (Xs a).IsSymm)
    (K : Fin (m + 1) → Fin (m + 1) → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (σ : Equiv.Perm (Fin (m + 1))) :
    let R := ∑ i : Fin m, Xs (σ i.succ)
    let T := ∑ i : Fin m, Xs (σ i.succ) * Xs (σ i.succ)
    let Y := Xs (σ 0) + (1 / 2 : ℝ) • R
    let ℓ := (3 / 2 : ℝ) • (R * R) + (3 : ℝ) • T
      + (2 : ℝ) • ∑ i : Fin m, beta (fun d => t (σ d)) (fun d e => K (σ d) (σ e)) 0 i.succ • Xs (σ i.succ)
    Pcubic (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
        = 6 * (Y * Y * Y).trace + (Y * ℓ).trace
          + HamiltonsCubic.L228Item2.cA (fun d => t (σ d)) (fun d e => K (σ d) (σ e)) (fun i => Xs (σ i.succ)) ∧
      normSq (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K)
        = 2 * (Y * Y).trace
          + HamiltonsCubic.L228Item2.nA (fun d => t (σ d)) (fun d e => K (σ d) (σ e)) (fun i => Xs (σ i.succ)) := by
  intro R T Y ℓ
  obtain ⟨hP, hN⟩ := HamiltonsCubic.L228Item2.L228_item2 (fun d => t (σ d)) (fun d => Xs (σ d)) (fun d => hX _)
    (fun d => hXs _) (fun d e => K (σ d) (σ e)) (fun d e => hK _ _) (fun d => hK0 _)
  rw [Equiv.sum_comp σ Xs, Equiv.sum_comp σ t] at hP hN
  obtain ⟨hS, hM⟩ := normal_symm t Xs hXs
  obtain ⟨hPt, -⟩ := perm_transfer _ hS (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) hM K hK hK0 σ
  have hNt : normSq (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
      (fun a => t (σ a) • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs (σ a)) (fun a b => K (σ a) (σ b)))
      = normSq (blockOp (∑ a, Xs a - ((∑ a, t a) / 2) • (1 : Matrix (Fin 3) (Fin 3) ℝ))
        (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K) := by
    rw [normSq_blockOp _ hS _ (fun a => hM _) _ (fun a b => hK _ _) (fun a => hK0 _), normSq_blockOp _ hS _ hM K hK hK0,
      normSq_perm _ (fun a => t a • (1 : Matrix (Fin 3) (Fin 3) ℝ) + Xs a) K hK σ]
  refine ⟨?_, ?_⟩
  · rw [← hPt]; exact hP
  · rw [← hNt]; exact hN

end HamiltonsCubic.L228Relabel
