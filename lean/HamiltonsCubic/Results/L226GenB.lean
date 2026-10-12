import Mathlib
import HamiltonsCubic.Results.L226GenA

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L226 item 1 at every `|J| = k`, part B: the sharp pairing split by block, and the blocks without `V_a`

[L226](../../../findings/second-order.md), item 1. The sharp pairing is `⟨W, W#⟩ = ⅛ ∑_{ijkl} Q(φ_ij, φ_kl)` with
`Q(X, Y) = ⟨W[WX, WY], [X, Y]⟩`, and `Q` is even in each slot, so the ordered basis of `Λ²ℝ^{J ⊔ A}` splits into the `J`-pairs, the
mixed pairs counted twice, and the `A`-pairs:

* `sharpPair_opOf`: `⟨C, C#⟩ = ⅛ ∑ Q` for every `opOf C`;
* `QG`, `QG_neg_left`, `QG_neg_right`, `QG_symm`; `split_even`;
* **`sharp_split`**: `8⟨W, W#⟩` as nine block sums;
* **`S_JJJJ`**: the `J`-`J` block is `8⟨R_J, R_J#⟩`, through `emb`;
* `S_JJAA`, `S_AAJJ`: the `J`-`A` blocks vanish, `[Λ²ℝ^J, Λ²ℝ^A] = 0`;
* **`S_AAAA`**: the `A`-`A` block is `4 ∑_{abd} K_{ab} K_{ad} K_{bd}`.
-/

namespace HamiltonsCubic.L226GenB

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L226Mixed HamiltonsCubic.L226Gen
  HamiltonsCubic.L226GenA

section Generic
variable {κ : Type*} [Fintype κ] [DecidableEq κ]

/-- **The sharp pairing of an `opOf` operator.** -/
theorem sharpPair_opOf (C : κ → κ → κ → κ → ℝ) :
    sharpPair (opOf C) = (1 / 8) * ∑ i, ∑ j, ∑ k, ∑ l,
      inner2 (opOf C (br (opOf C (phi i j)) (opOf C (phi k l)))) (br (phi i j) (phi k l)) := by
  have h1 : sharpPair (opOf C) = -(1 / 2) * phiTri (opL C) (opL C) (opL C) := by
    rw [← extend_opL C, HamiltonsCubic.TensorBridge.sharpPair_extend, sharpPair2_eq_phiTri]
  rw [h1]
  unfold phiTri
  have hc : ∀ x : ℝ, -(1 / 2 : ℝ) * (-(1 / 4) * x) = 1 / 8 * x := fun x => by ring
  rw [hc]
  rfl

end Generic

variable {k m : ℕ}

/-- The summand of the sharp pairing. -/
noncomputable def QG (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ)
    (X Y : Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ) : ℝ :=
  inner2 (blockOpG R M K (br (blockOpG R M K X) (blockOpG R M K Y))) (br X Y)

theorem L_neg (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ)
    (X : Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ) : blockOpG R M K (-X) = -blockOpG R M K X :=
  map_neg (opLin (blockCoeffG R M K)) X

theorem QG_neg_left (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ)
    (X Y : Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ) : QG R M K (-X) Y = QG R M K X Y := by
  unfold QG
  rw [L_neg, br_neg_left', L_neg, br_neg_left', inner2_neg_left', inner2_neg_right', neg_neg]

theorem QG_neg_right (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ)
    (X Y : Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ) : QG R M K X (-Y) = QG R M K X Y := by
  unfold QG
  rw [L_neg, br_neg_right', L_neg, br_neg_right', inner2_neg_left', inner2_neg_right', neg_neg]

theorem QG_symm (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ)
    (X Y : Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ) : QG R M K X Y = QG R M K Y X := by
  unfold QG
  rw [br_anti' (blockOpG R M K Y), L_neg, br_anti' Y, inner2_neg_left', inner2_neg_right', neg_neg]

/-- **An even function summed over the ordered basis**, split by block. -/
theorem split_even (F : Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ → ℝ) (hF : ∀ X, F (-X) = F X) :
    ∑ i, ∑ j, F (phi i j) = ∑ p, ∑ q, F (phi (.inl p) (.inl q)) + 2 * ∑ p, ∑ a, F (phi (.inl p) (.inr a))
      + ∑ a, ∑ b, F (phi (.inr a) (.inr b)) := by
  have h : ∑ a, ∑ p, F (phi (.inr a) (.inl p) : Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ)
      = ∑ p, ∑ a, F (phi (.inl p) (.inr a)) := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun a _ => ?_
    rw [phi_swap (Sum.inr a) (Sum.inl p), hF]
  simp only [Fintype.sum_sum_type, Finset.sum_add_distrib]
  rw [h]
  ring

/-- **The sharp pairing in nine block sums.** -/
theorem sharp_split (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ) :
    8 * sharpPair (blockOpG R M K)
      = (∑ p, ∑ q, ∑ r, ∑ s, QG R M K (phi (.inl p) (.inl q)) (phi (.inl r) (.inl s)))
        + 2 * (∑ p, ∑ q, ∑ r, ∑ a, QG R M K (phi (.inl p) (.inl q)) (phi (.inl r) (.inr a)))
        + (∑ p, ∑ q, ∑ a, ∑ b, QG R M K (phi (.inl p) (.inl q)) (phi (.inr a) (.inr b)))
        + 2 * (∑ p, ∑ a, ∑ q, ∑ r, QG R M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inl r)))
        + 4 * (∑ p, ∑ a, ∑ q, ∑ b, QG R M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr b)))
        + 2 * (∑ p, ∑ c, ∑ a, ∑ b, QG R M K (phi (.inl p) (.inr c)) (phi (.inr a) (.inr b)))
        + (∑ a, ∑ b, ∑ p, ∑ q, QG R M K (phi (.inr a) (.inr b)) (phi (.inl p) (.inl q)))
        + 2 * (∑ a, ∑ b, ∑ p, ∑ c, QG R M K (phi (.inr a) (.inr b)) (phi (.inl p) (.inr c)))
        + (∑ a, ∑ b, ∑ c, ∑ d, QG R M K (phi (.inr a) (.inr b)) (phi (.inr c) (.inr d))) := by
  have hs : sharpPair (blockOpG R M K) = (1 / 8) * ∑ i, ∑ j, ∑ k, ∑ l, QG R M K (phi i j) (phi k l) :=
    sharpPair_opOf (blockCoeffG R M K)
  have inner : ∀ X, ∑ k, ∑ l, QG R M K X (phi k l)
      = ∑ r, ∑ s, QG R M K X (phi (.inl r) (.inl s)) + 2 * ∑ r, ∑ a, QG R M K X (phi (.inl r) (.inr a))
        + ∑ a, ∑ b, QG R M K X (phi (.inr a) (.inr b)) :=
    fun X => split_even (fun Y => QG R M K X Y) (fun Y => QG_neg_right R M K X Y)
  have outer := split_even (fun X => ∑ k, ∑ l, QG R M K X (phi k l))
    (fun X => Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => QG_neg_left R M K X _)
  rw [hs]
  rw [show (8 : ℝ) * (1 / 8 * ∑ i, ∑ j, ∑ k, ∑ l, QG R M K (phi i j) (phi k l))
      = ∑ i, ∑ j, ∑ k, ∑ l, QG R M K (phi i j) (phi k l) by ring, outer]
  simp only [inner, Finset.sum_add_distrib, ← Finset.mul_sum]
  ring

/-- **The `J`-`J` block is `8⟨R_J, R_J#⟩`.** -/
theorem S_JJJJ (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ) :
    (∑ p, ∑ q, ∑ r, ∑ s, QG R M K (phi (.inl p) (.inl q)) (phi (.inl r) (.inl s))) = 8 * sharpPair (opOf R) := by
  rw [sharpPair_opOf R]
  have e : ∀ p q r s : Fin k, QG R M K (phi (.inl p) (.inl q)) (phi (.inl r) (.inl s))
      = inner2 (opOf R (br (opOf R (phi p q)) (opOf R (phi r s)))) (br (phi p q) (phi r s)) := by
    intro p q r s
    unfold QG
    rw [← emb_phi, ← emb_phi, blockOpG_emb, blockOpG_emb, br_emb, blockOpG_emb, br_emb, inner2_emb]
  simp only [e]
  ring

theorem br_JJ_AA (p q : Fin k) (a b : Fin m) :
    br (phi (.inl p) (.inl q) : Matrix (Fin k ⊕ Fin m) (Fin k ⊕ Fin m) ℝ) (phi (.inr a) (.inr b)) = 0 := by
  rw [br_phi_phi]; simp

theorem S_JJAA (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ) :
    (∑ p, ∑ q, ∑ a, ∑ b, QG R M K (phi (.inl p) (.inl q)) (phi (.inr a) (.inr b))) = 0 := by
  refine Finset.sum_eq_zero fun p _ => Finset.sum_eq_zero fun q _ => Finset.sum_eq_zero fun a _ =>
    Finset.sum_eq_zero fun b _ => ?_
  unfold QG; rw [br_JJ_AA]; exact inner2_zero_r _

theorem S_AAJJ (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ) (K : Fin m → Fin m → ℝ) :
    (∑ a, ∑ b, ∑ p, ∑ q, QG R M K (phi (.inr a) (.inr b)) (phi (.inl p) (.inl q))) = 0 := by
  refine Finset.sum_eq_zero fun a _ => Finset.sum_eq_zero fun b _ => Finset.sum_eq_zero fun p _ =>
    Finset.sum_eq_zero fun q _ => ?_
  rw [QG_symm]; unfold QG; rw [br_JJ_AA]; exact inner2_zero_r _

theorem KK_pairG (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) (a b c d : Fin m) (hab : a ≠ b) (hcd : c ≠ d) :
    inner2 (blockOpG R M K (br (phi (Sum.inr a : Fin k ⊕ Fin m) (Sum.inr b)) (phi (Sum.inr c) (Sum.inr d))))
        (br (phi (Sum.inr a : Fin k ⊕ Fin m) (Sum.inr b)) (phi (Sum.inr c) (Sum.inr d)))
      = (if a = c then K b d else 0) + (if b = d then K a c else 0) + (if a = d then K b c else 0)
        + (if b = c then K a d else 0) := by
  have hL : ∀ X, blockOpG R M K X = opLin (blockCoeffG R M K) X := fun _ => rfl
  have LK : ∀ a b, opLin (blockCoeffG R M K) (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) :=
    fun a b => blockOpG_K R M K hK a b
  rw [br_phi_phi, hL]
  simp only [Sum.inr.injEq, map_add, map_sub, map_smul, LK, inner2_add_l, inner2_add_r, inner2_sub_l,
    inner2_sub_r, inner2_smul_left', HamiltonsCubic.L226Statement.inner2_smul_right',
    HamiltonsCubic.FamilyLayer.inner2_phi_phi]
  by_cases h1 : a = c <;> by_cases h2 : b = d <;> by_cases h3 : a = d <;> by_cases h4 : b = c <;>
    by_cases h5 : c = d <;> subst_vars <;> simp_all [hK0] <;> ring_nf <;> simp_all [hK0, hK]

/-- **The `A`-`A` block** is `4 ∑_{abd} K_{ab} K_{ad} K_{bd}`. -/
theorem S_AAAA (R : Fin k → Fin k → Fin k → Fin k → ℝ) (M : Fin m → Matrix (Fin k) (Fin k) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    (∑ a, ∑ b, ∑ c, ∑ d, QG R M K (phi (.inr a) (.inr b)) (phi (.inr c) (.inr d)))
      = 4 * ∑ a, ∑ b, ∑ d, K a b * K a d * K b d := by
  have hL : ∀ X, blockOpG R M K X = opLin (blockCoeffG R M K) X := fun _ => rfl
  have LK : ∀ a b, opLin (blockCoeffG R M K) (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) :=
    fun a b => blockOpG_K R M K hK a b
  have Qg : ∀ a b c d : Fin m, QG R M K (phi (.inr a) (.inr b)) (phi (.inr c) (.inr d))
      = K a b * K c d * ((if a = c then K b d else 0) + (if b = d then K a c else 0)
          + (if a = d then K b c else 0) + (if b = c then K a d else 0)) := by
    intro a b c d
    unfold QG
    by_cases hab : a = b
    · subst hab; simp [phi_self, hK0, br, inner2]
    by_cases hcd : c = d
    · subst hcd; simp [phi_self, hK0, br, inner2]
    rw [← KK_pairG R M K hK hK0 a b c d hab hcd]
    simp only [hL, LK]
    simp only [← brB_apply]
    simp only [map_smul, LinearMap.smul_apply, brB_apply, inner2_smul_left']
    ring
  simp only [Qg, mul_add, mul_ite, mul_zero, Finset.sum_add_distrib]
  simp only [Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true, coll_fst']
  have e2 : ∑ a, ∑ b, ∑ c, K a b * K c b * K a c = ∑ a, ∑ b, ∑ d, K a b * K a d * K b d :=
    Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => by
      rw [hK c b]; ring
  have e3 : ∑ a, ∑ b, ∑ c, K a b * K c a * K b c = ∑ a, ∑ b, ∑ d, K a b * K a d * K b d :=
    Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => by
      rw [hK c a]
  have e4 : ∑ a, ∑ b, ∑ d, K a b * K b d * K a d = ∑ a, ∑ b, ∑ d, K a b * K a d * K b d :=
    Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => by
      ring
  linarith [e2, e3, e4]

end HamiltonsCubic.L226GenB
