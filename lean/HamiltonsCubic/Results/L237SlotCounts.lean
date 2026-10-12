import Mathlib
import HamiltonsCubic.Results.L237GraphLoad
import HamiltonsCubic.Results.L237Cap

/-!
# L237, reading the slot counts off a slot set

`counts_bound` in [L237GraphLoad.lean](L237GraphLoad.lean) bounds a sum of slot eigenvalues given
the counts of each kind; this file classifies each slot of a normal form (`slotCls`) and shows its
eigenvalue is a function of the class (`slotμ_eq_val`).
-/

open HamiltonsCubic.RealLayer Matrix

namespace HamiltonsCubic.L237SlotCounts

open HamiltonsCubic.L240SlotBasis

variable {ι : Type*} [Fintype ι] [DecidableEq ι] [LinearOrder ι] {k : ℕ} (N : NormalForm ι k)

/-- A slot's class: a cross slot's ordered block pair and whether its lower-block index is the
`p`-side (plus sign), a block-free slot's block, or `none` (Cartan and free-free, eigenvalue `0`). -/
noncomputable def slotCls (ij : {x : ι × ι // x.1 < x.2}) :
    Option (((Fin k × Fin k) × Bool) ⊕ Fin k) :=
  match N.blockOf ij.1.1, N.blockOf ij.1.2 with
  | some a, some b =>
      if a = b then none
      else if a < b then some (Sum.inl ((a, b), decide (N.p a = ij.1.1)))
      else some (Sum.inl ((b, a), decide (N.p b = ij.1.2)))
  | some a, none => some (Sum.inr a)
  | none, some b => some (Sum.inr b)
  | none, none => none

/-- The eigenvalue of a class. -/
noncomputable def clsVal : Option (((Fin k × Fin k) × Bool) ⊕ Fin k) → ℝ
  | none => 0
  | some (Sum.inl ((a, b), true)) => (N.s a + N.s b) ^ 2
  | some (Sum.inl ((a, b), false)) => (N.s a - N.s b) ^ 2
  | some (Sum.inr c) => N.s c ^ 2

theorem slotμ_eq_val (ij : {x : ι × ι // x.1 < x.2}) : slotμ N ij = clsVal N (slotCls N ij) := by
  unfold slotμ slotCls
  cases N.blockOf ij.1.1 with
  | none => cases N.blockOf ij.1.2 <;> rfl
  | some a =>
    cases N.blockOf ij.1.2 with
    | none => rfl
    | some b =>
      simp only
      split_ifs with h1 h2 <;> simp only [clsVal, pairMu] <;> split_ifs <;> simp_all [clsVal]

/-- The sorted pair. -/
def srt (u v : ι) : ι × ι := (min u v, max u v)

/-- The two index pairs a slot of class `((a, b), t)` can be. -/
def cand (a b : Fin k) (t : Bool) : Finset (ι × ι) :=
  let e := if t then N.p a else N.q a
  {srt e (N.p b), srt e (N.q b)}

theorem srt_of_lt {u v : ι} (h : u < v) : srt u v = (u, v) := by
  simp [srt, min_eq_left h.le, max_eq_right h.le]

theorem srt_of_gt {u v : ι} (h : v < u) : srt u v = (v, u) := by
  simp [srt, min_eq_right h.le, max_eq_left h.le]

theorem side {x : ι} {c : Fin k} (h : N.blockOf x = some c) (t : Bool) (ht : t = decide (N.p c = x)) :
    x = if t then N.p c else N.q c := by
  rcases blockOf_spec N h with h' | h'
  · subst ht; simp [h']
  · subst ht
    by_cases hp : N.p c = x
    · simp [hp]
    · simp [hp, h']

theorem cls_mem_cand (ij : {x : ι × ι // x.1 < x.2}) {a b : Fin k} {t : Bool}
    (h : slotCls N ij = some (Sum.inl ((a, b), t))) : ij.1 ∈ cand N a b t := by
  obtain ⟨⟨i, j⟩, hij⟩ := ij
  simp only at hij
  unfold slotCls at h
  simp only at h
  cases hi : N.blockOf i with
  | none => cases hj : N.blockOf j <;> simp [hi, hj] at h
  | some a' =>
    cases hj : N.blockOf j with
    | none => simp [hi, hj] at h
    | some b' =>
      simp only [hi, hj] at h
      split_ifs at h with h1 h2
      · simp only [Option.some.injEq, Sum.inl.injEq, Prod.mk.injEq] at h
        obtain ⟨⟨rfl, rfl⟩, rfl⟩ := h
        have hie := side N hi _ rfl
        rcases blockOf_spec N hj with hjp | hjq
        · simp only [cand, Finset.mem_insert, Finset.mem_singleton]; left
          rw [← hie, hjp, srt_of_lt hij]
        · simp only [cand, Finset.mem_insert, Finset.mem_singleton]; right
          rw [← hie, hjq, srt_of_lt hij]
      · simp only [Option.some.injEq, Sum.inl.injEq, Prod.mk.injEq] at h
        obtain ⟨⟨rfl, rfl⟩, rfl⟩ := h
        have hje := side N hj _ rfl
        rcases blockOf_spec N hi with hip | hiq
        · simp only [cand, Finset.mem_insert, Finset.mem_singleton]; left
          rw [← hje, hip, srt_of_gt hij]
        · simp only [cand, Finset.mem_insert, Finset.mem_singleton]; right
          rw [← hje, hiq, srt_of_gt hij]

/-- **A cross class holds at most two slots of any slot set.** -/
theorem cls_card_le_two (S : Finset {x : ι × ι // x.1 < x.2}) (a b : Fin k) (t : Bool) :
    (S.filter (fun ij => slotCls N ij = some (Sum.inl ((a, b), t)))).card ≤ 2 := by
  calc _ ≤ (cand N a b t).card := by
        refine Finset.card_le_card_of_injOn (fun ij => ij.1) (fun ij hij => ?_) ?_
        · exact cls_mem_cand N ij (Finset.mem_filter.mp hij).2
        · intro x _ y _ hxy; exact Subtype.ext hxy
    _ ≤ 2 := Finset.card_le_two

/-- A cross class's block pair is ordered. -/
theorem cls_lt (ij : {x : ι × ι // x.1 < x.2}) {a b : Fin k} {t : Bool}
    (h : slotCls N ij = some (Sum.inl ((a, b), t))) : a < b := by
  unfold slotCls at h
  cases hi : N.blockOf ij.1.1 with
  | none => cases hj : N.blockOf ij.1.2 <;> simp [hi, hj] at h
  | some a' =>
    cases hj : N.blockOf ij.1.2 with
    | none => simp [hi, hj] at h
    | some b' =>
      simp only [hi, hj] at h
      split_ifs at h with h1 h2
      · simp only [Option.some.injEq, Sum.inl.injEq, Prod.mk.injEq] at h
        obtain ⟨⟨rfl, rfl⟩, rfl⟩ := h; exact h2
      · simp only [Option.some.injEq, Sum.inl.injEq, Prod.mk.injEq] at h
        obtain ⟨⟨rfl, rfl⟩, rfl⟩ := h
        exact lt_of_le_of_ne (not_lt.mp h2) (Ne.symm h1)

open Finset in
/-- **Any set of slots sums to at most `(|S| + 2) ∑ s²`**: `κ_r ≤ r + 2` on a normal form. -/
theorem slot_set_bound (S : Finset {x : ι × ι // x.1 < x.2}) :
    ∑ ij ∈ S, slotμ N ij ≤ (S.card + 2) * ∑ c, N.s c ^ 2 := by
  classical
  set cnt : Option (((Fin k × Fin k) × Bool) ⊕ Fin k) → ℕ :=
    fun z => (S.filter (fun ij => slotCls N ij = z)).card with hcnt
  have h1 : ∑ ij ∈ S, slotμ N ij = ∑ z, (cnt z : ℝ) * clsVal N z := by
    simp only [slotμ_eq_val]
    rw [← sum_fiberwise S (slotCls N) (fun ij => clsVal N (slotCls N ij))]
    refine sum_congr rfl fun z _ => ?_
    rw [sum_congr rfl (fun ij hij => by rw [(mem_filter.mp hij).2]), sum_const, nsmul_eq_mul]
  set P : Fin k × Fin k → ℕ := fun x => cnt (some (Sum.inl (x, true))) with hP
  set M : Fin k × Fin k → ℕ := fun x => cnt (some (Sum.inl (x, false))) with hM
  set F : Fin k → ℕ := fun c => cnt (some (Sum.inr c)) with hF
  have hzero : ∀ x ∉ L237GraphLoad.pairs k, ∀ t, cnt (some (Sum.inl (x, t))) = 0 := by
    intro x hx t
    simp only [hcnt, card_eq_zero, filter_eq_empty_iff]
    intro ij _ h
    apply hx
    simp only [L237GraphLoad.pairs, mem_filter, mem_univ, true_and]
    exact cls_lt N ij h
  have h2 : ∑ z, (cnt z : ℝ) * clsVal N z
      = ∑ x ∈ L237GraphLoad.pairs k, ((P x : ℝ) * (N.s x.1 + N.s x.2) ^ 2
          + M x * (N.s x.1 - N.s x.2) ^ 2) + ∑ c, (F c : ℝ) * N.s c ^ 2 := by
    rw [Fintype.sum_option, Fintype.sum_sum_type, Fintype.sum_prod_type]
    simp only [clsVal, mul_zero, zero_add, Fintype.sum_bool]
    congr 1
    symm
    apply sum_subset (subset_univ _)
    intro x _ hx
    have h0 : P x = 0 := hzero x hx true
    have h0' : M x = 0 := hzero x hx false
    rw [h0, h0']; simp
  have htot : ∑ z, cnt z = S.card := by
    simp only [hcnt]
    exact (card_eq_sum_card_fiberwise (f := slotCls N) (s := S) (t := univ)
      (fun _ _ => mem_univ _)).symm
  have hr : ∑ x ∈ L237GraphLoad.pairs k, (P x + M x) + ∑ c, F c ≤ S.card := by
    rw [← htot, Fintype.sum_option, Fintype.sum_sum_type, Fintype.sum_prod_type]
    simp only [Fintype.sum_bool]
    have : ∑ x ∈ L237GraphLoad.pairs k, (P x + M x)
        ≤ ∑ x, (cnt (some (Sum.inl (x, true))) + cnt (some (Sum.inl (x, false)))) :=
      sum_le_sum_of_subset (subset_univ _)
    have hFd : ∑ c, F c = ∑ a, cnt (some (Sum.inr a)) := rfl
    omega
  rw [h1, h2]
  exact L237GraphLoad.counts_bound N.s P M F (fun x => cls_card_le_two N S x.1 x.2 true)
    (fun x => cls_card_le_two N S x.1 x.2 false) S.card hr

/-- **L237, the Ky Fan bracket cap `κ_r ≤ r + 2`**: at `X = O N.X Oᵀ` with `O` orthogonal, any `r ≥ 1`
orthonormal skew matrices `yⱼ` have `∑ⱼ ⟨yⱼ, -ad_X² yⱼ⟩ ≤ (r + 2) ∑_c s_c²`; at `r = 6`, the cap `8`. -/
theorem kappa_cap {O X : Matrix ι ι ℝ} (hO : O * Oᵀ = 1) (hO' : Oᵀ * O = 1)
    (hX : X = O * N.X * Oᵀ) {r : ℕ} (hr : 0 < r) (y : Fin r → Matrix ι ι ℝ)
    (hyS : ∀ j, IsSkew (y j)) (hy : ∀ i j, inner2 (y i) (y j) = if i = j then 1 else 0) :
    ∑ j, inner2 (y j) (-br X (br X (y j))) ≤ (r + 2) * ∑ c, N.s c ^ 2 := by
  refine L237Cap.rowSum_le_of_slotSets N hO hO' hX hr _ (fun S hS => ?_) y hyS hy
  have hsq : 0 ≤ ∑ c, N.s c ^ 2 := Finset.sum_nonneg fun _ _ => sq_nonneg _
  calc _ ≤ (S.card + 2) * ∑ c, N.s c ^ 2 := slot_set_bound N S
    _ ≤ _ := mul_le_mul_of_nonneg_right (by exact_mod_cast (by omega : S.card + 2 ≤ r + 2)) hsq

/-- **The normal form's weights are its norm**: `⟨N.X, N.X⟩ = ∑_c s_c²`. -/
theorem inner2_X_X : inner2 N.X N.X = ∑ c, N.s c ^ 2 := by
  have h : ∀ a b, inner2 (phi (N.p a) (N.q a)) (phi (N.p b) (N.q b)) = if a = b then 1 else 0 := by
    intro a b
    rw [HamiltonsCubic.Results.inner2_phi_phi]
    have h2 : ¬(N.p a = N.q b ∧ N.q a = N.p b) := fun h => N.hpq a b h.1
    by_cases hab : a = b
    · subst hab; simp [h2]
    · have h1 : ¬(N.p a = N.p b ∧ N.q a = N.q b) := fun h => hab (N.hp h.1)
      simp [h1, h2, hab]
  have e : ∀ A B : Matrix ι ι ℝ, inner2 A B = KyFanPackaging.inner2Form A B := fun A B =>
    (KyFanPackaging.inner2Form_apply A B).symm
  rw [e, NormalForm.X]
  simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, smul_eq_mul, ← e, h]
  simp [Finset.sum_ite_eq, sq]

/-- **`κ_r ≤ r + 2` in `X`'s own norm**: at every skew `X` and `r ≥ 1` orthonormal skew `yⱼ`,
`∑ⱼ ‖[X, yⱼ]‖² ≤ (r + 2) ⟨X, X⟩`; at `r = 6` the cap `8 ⟨X, X⟩`. -/
theorem kappa_cap_norm (X : Matrix ι ι ℝ) (hX : IsSkew X) {r : ℕ} (hr : 0 < r)
    (y : Fin r → Matrix ι ι ℝ) (hyS : ∀ j, IsSkew (y j))
    (hy : ∀ i j, inner2 (y i) (y j) = if i = j then 1 else 0) :
    ∑ j, inner2 (br X (y j)) (br X (y j)) ≤ (r + 2) * inner2 X X := by
  obtain ⟨k, N, O, hO, hO', hXO⟩ := L240NormalForm.skew_normal_form X hX
  have hNX : Oᵀ * X * O = N.X := by
    rw [hXO]
    calc Oᵀ * (O * N.X * Oᵀ) * O = (Oᵀ * O) * N.X * (Oᵀ * O) := by
          simp only [Matrix.mul_assoc]
      _ = N.X := by rw [hO']; simp
  have hnorm : inner2 X X = ∑ c, N.s c ^ 2 := by
    rw [← inner2_X_X N, ← hNX, L240NormalForm.inner2_conj hO]
  have e : ∀ j, inner2 (br X (y j)) (br X (y j)) = inner2 (y j) (-br X (br X (y j))) :=
    fun j => (KyFanPackaging.inner2_negAdSq X (y j) hX).symm
  simp only [e, hnorm]
  exact kappa_cap N hO hO' hXO hr y hyS hy

end HamiltonsCubic.L237SlotCounts
