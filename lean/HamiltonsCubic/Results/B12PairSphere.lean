import HamiltonsCubic.Results.B12PairSector
import HamiltonsCubic.Results.B12DiagTrace

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 6a: the pair sectors at the sphere product

[B12PairSector.lean](B12PairSector.lean)'s `trace_pair_sector` gives the pair sector `{j, k}` as
`V(j,k) = ∑_{m,i∈S} Lb_{mi}² − ¼ w_jk²`, `S = Sset j k`. At a block weight (`A` within `T`, `B` within `Tᶜ`, `G` across) the
entries of `Lb` depend only on which block each index lies in, so `V` is a polynomial in `A, B, G` and the block counts of
`S`. At the sphere product `t · W_T` (`A = tq/(p−1)`, `B = tp/(q−1)`, `G = −t`, [L127Dn.lean](L127Dn.lean)'s
`smul_sphereWeight_eq`):

* **`pair_cross_sphere`**: a cross pair (`j ∈ T`, `k ∉ T`) gives `θ²/4`;
* **`pair_within_sphere`**: a pair within `T` gives `θ²(λ_p² + (q − 1)μ²)`;
* **`pair_within_compl_sphere`**: a pair within `Tᶜ` gives `θ²(λ_q² + (p − 1)μ²)`, by `sphereWeight_compl`.

`θ`, `λ_p`, `λ_q` and `−μ` are [L127DnEig.lean](L127DnEig.lean)'s `dnθ`, `dnLp`, `dnLq`, `dnMu`, as in
[B12DiagTrace.lean](B12DiagTrace.lean). These are the values [r1920](../../../reviews/REVIEW_r1920.md) derived by hand.
-/

namespace HamiltonsCubic.B12PairSphere

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results HamiltonsCubic.L122Statement

variable {n : ℕ}

theorem sum_by_T (S T : Finset (Fin n)) (f : Fin n → ℝ) (a b : ℝ) (ha : ∀ i ∈ S, i ∈ T → f i = a)
    (hb : ∀ i ∈ S, i ∉ T → f i = b) :
    ∑ i ∈ S, f i = ((S.filter (· ∈ T)).card : ℝ) * a + ((S.filter (· ∉ T)).card : ℝ) * b := by
  rw [← Finset.sum_filter_add_sum_filter_not S (· ∈ T)]
  rw [Finset.sum_congr rfl (fun i hi => ha i (Finset.mem_filter.mp hi).1 (Finset.mem_filter.mp hi).2),
    Finset.sum_congr rfl (fun i hi => hb i (Finset.mem_filter.mp hi).1 (Finset.mem_filter.mp hi).2)]
  simp [Finset.sum_const, nsmul_eq_mul]

/-- The double sum of `Lb²`, split into its diagonal and off-diagonal parts. -/
theorem sq_sum_split (w : Matrix (Fin n) (Fin n) ℝ) (j k : Fin n) :
    ∑ m ∈ Sset j k, ∑ i ∈ Sset j k, Lb w j k m i ^ 2
      = ∑ m ∈ Sset j k, (((1 / 2) * (w j m + w k m - w j k)) ^ 2
          + ∑ i ∈ (Sset j k).erase m, ((1 / 2) * w m i) ^ 2) := by
  refine Finset.sum_congr rfl fun m hm => ?_
  rw [← Finset.add_sum_erase _ _ hm]
  congr 1
  · simp [Lb]
  · refine Finset.sum_congr rfl fun i hi => ?_
    rw [Lb, if_neg (Finset.ne_of_mem_erase hi).symm]

theorem filter_erase_card (S T : Finset (Fin n)) {m : Fin n} (hm : m ∈ S) (hmT : m ∈ T) :
    (((S.erase m).filter (· ∈ T)).card : ℝ) = ((S.filter (· ∈ T)).card : ℝ) - 1 ∧
      (((S.erase m).filter (· ∉ T)).card : ℝ) = ((S.filter (· ∉ T)).card : ℝ) := by
  have e1 : (S.erase m).filter (· ∈ T) = (S.filter (· ∈ T)).erase m := Finset.filter_erase _ _ _
  have e2 : (S.erase m).filter (· ∉ T) = S.filter (· ∉ T) := by
    ext i; simp only [Finset.mem_filter, Finset.mem_erase]
    constructor
    · exact fun h => ⟨h.1.2, h.2⟩
    · intro h; exact ⟨⟨fun e => h.2 (e ▸ hmT), h.1⟩, h.2⟩
  have hmem : m ∈ S.filter (· ∈ T) := Finset.mem_filter.mpr ⟨hm, hmT⟩
  have h1 : 1 ≤ (S.filter (· ∈ T)).card := Finset.card_pos.mpr ⟨m, hmem⟩
  rw [e1, e2, Finset.card_erase_of_mem hmem, Nat.cast_sub h1, Nat.cast_one]
  exact ⟨rfl, rfl⟩

theorem filter_erase_card' (S T : Finset (Fin n)) {m : Fin n} (hm : m ∈ S) (hmT : m ∉ T) :
    (((S.erase m).filter (· ∈ T)).card : ℝ) = ((S.filter (· ∈ T)).card : ℝ) ∧
      (((S.erase m).filter (· ∉ T)).card : ℝ) = ((S.filter (· ∉ T)).card : ℝ) - 1 := by
  have e1 : (S.erase m).filter (· ∉ T) = (S.filter (· ∉ T)).erase m := Finset.filter_erase _ _ _
  have e2 : (S.erase m).filter (· ∈ T) = S.filter (· ∈ T) := by
    ext i; simp only [Finset.mem_filter, Finset.mem_erase]
    constructor
    · exact fun h => ⟨h.1.2, h.2⟩
    · intro h; exact ⟨⟨fun e => hmT (e ▸ h.2), h.1⟩, h.2⟩
  have hmem : m ∈ S.filter (· ∉ T) := Finset.mem_filter.mpr ⟨hm, hmT⟩
  have h1 : 1 ≤ (S.filter (· ∉ T)).card := Finset.card_pos.mpr ⟨m, hmem⟩
  rw [e1, e2, Finset.card_erase_of_mem hmem, Nat.cast_sub h1, Nat.cast_one]
  exact ⟨rfl, rfl⟩

/-- **The pair value at a block weight**, in terms of the diagonal values `dT`, `dC` of `Lb` on the two blocks and the block
counts `cT`, `cC` of `S`. -/
theorem pair_block (T : Finset (Fin n)) (A B G : ℝ) (j k : Fin n) (dT dC : ℝ)
    (hdT : ∀ m ∈ Sset j k, m ∈ T → (1 / 2) * (HamiltonsCubic.Results.blockW T A B G j m
      + HamiltonsCubic.Results.blockW T A B G k m - HamiltonsCubic.Results.blockW T A B G j k) = dT)
    (hdC : ∀ m ∈ Sset j k, m ∉ T → (1 / 2) * (HamiltonsCubic.Results.blockW T A B G j m
      + HamiltonsCubic.Results.blockW T A B G k m - HamiltonsCubic.Results.blockW T A B G j k) = dC) :
    ∑ m ∈ Sset j k, ∑ i ∈ Sset j k, Lb (HamiltonsCubic.Results.blockW T A B G) j k m i ^ 2
      = (((Sset j k).filter (· ∈ T)).card : ℝ) * (dT ^ 2 + ((((Sset j k).filter (· ∈ T)).card : ℝ) - 1) * (A / 2) ^ 2
            + (((Sset j k).filter (· ∉ T)).card : ℝ) * (G / 2) ^ 2)
        + (((Sset j k).filter (· ∉ T)).card : ℝ) * (dC ^ 2 + (((Sset j k).filter (· ∈ T)).card : ℝ) * (G / 2) ^ 2
            + ((((Sset j k).filter (· ∉ T)).card : ℝ) - 1) * (B / 2) ^ 2) := by
  rw [sq_sum_split]
  apply sum_by_T
  · intro m hm hmT
    rw [hdT m hm hmT]
    have hin : ∑ i ∈ (Sset j k).erase m, ((1 / 2) * HamiltonsCubic.Results.blockW T A B G m i) ^ 2
        = (((((Sset j k).erase m).filter (· ∈ T)).card : ℝ)) * (A / 2) ^ 2
          + (((((Sset j k).erase m).filter (· ∉ T)).card : ℝ)) * (G / 2) ^ 2 := by
      apply sum_by_T
      · intro i hi hiT
        have him : m ≠ i := (Finset.ne_of_mem_erase hi).symm
        simp [HamiltonsCubic.Results.blockW, him, hmT, hiT]; ring
      · intro i hi hiT
        have him : m ≠ i := (Finset.ne_of_mem_erase hi).symm
        simp [HamiltonsCubic.Results.blockW, him, hmT, hiT]; ring
    obtain ⟨c1, c2⟩ := filter_erase_card (Sset j k) T hm hmT
    rw [hin, c1, c2]; ring
  · intro m hm hmT
    rw [hdC m hm hmT]
    have hin : ∑ i ∈ (Sset j k).erase m, ((1 / 2) * HamiltonsCubic.Results.blockW T A B G m i) ^ 2
        = (((((Sset j k).erase m).filter (· ∈ T)).card : ℝ)) * (G / 2) ^ 2
          + (((((Sset j k).erase m).filter (· ∉ T)).card : ℝ)) * (B / 2) ^ 2 := by
      apply sum_by_T
      · intro i hi hiT
        have him : m ≠ i := (Finset.ne_of_mem_erase hi).symm
        simp [HamiltonsCubic.Results.blockW, him, hmT, hiT]; ring
      · intro i hi hiT
        have him : m ≠ i := (Finset.ne_of_mem_erase hi).symm
        simp [HamiltonsCubic.Results.blockW, him, hmT, hiT]; ring
    obtain ⟨c1, c2⟩ := filter_erase_card' (Sset j k) T hm hmT
    rw [hin, c1, c2]; ring

/-! ## The block counts of `S` -/

theorem cards_within {T : Finset (Fin n)} {j k : Fin n} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) :
    (((Sset j k).filter (· ∈ T)).card : ℝ) = (T.card : ℝ) - 2 ∧ (((Sset j k).filter (· ∉ T)).card : ℝ) = Tᶜ.card := by
  have e1 : (Sset j k).filter (· ∈ T) = (T.erase j).erase k := by
    ext i; simp only [Finset.mem_filter, mem_Sset, Finset.mem_erase]; tauto
  have e2 : (Sset j k).filter (· ∉ T) = Tᶜ := by
    ext i; simp only [Finset.mem_filter, mem_Sset, Finset.mem_compl]
    constructor
    · exact fun h => h.2
    · intro h; exact ⟨⟨fun e => h (e ▸ hj), fun e => h (e ▸ hk)⟩, h⟩
  have hk' : k ∈ T.erase j := Finset.mem_erase.mpr ⟨Ne.symm hjk, hk⟩
  rw [e1, e2, Finset.card_erase_of_mem hk', Finset.card_erase_of_mem hj]
  have h2 : 2 ≤ T.card := by
    have := Finset.card_le_card (show ({j, k} : Finset (Fin n)) ⊆ T by
      intro x hx; simp only [Finset.mem_insert, Finset.mem_singleton] at hx; rcases hx with rfl | rfl <;> assumption)
    rwa [Finset.card_pair hjk] at this
  refine ⟨?_, rfl⟩
  push_cast [Nat.cast_sub (show 1 ≤ T.card by omega), Nat.cast_sub (show 1 ≤ T.card - 1 by omega)]
  ring

theorem cards_cross {T : Finset (Fin n)} {j k : Fin n} (hj : j ∈ T) (hk : k ∉ T) :
    (((Sset j k).filter (· ∈ T)).card : ℝ) = (T.card : ℝ) - 1 ∧
      (((Sset j k).filter (· ∉ T)).card : ℝ) = (Tᶜ.card : ℝ) - 1 := by
  have e1 : (Sset j k).filter (· ∈ T) = T.erase j := by
    ext i; simp only [Finset.mem_filter, mem_Sset, Finset.mem_erase]
    constructor
    · exact fun h => ⟨h.1.1, h.2⟩
    · intro h; exact ⟨⟨h.1, fun e => hk (e ▸ h.2)⟩, h.2⟩
  have e2 : (Sset j k).filter (· ∉ T) = Tᶜ.erase k := by
    ext i; simp only [Finset.mem_filter, mem_Sset, Finset.mem_erase, Finset.mem_compl]
    constructor
    · exact fun h => ⟨h.1.2, h.2⟩
    · intro h; exact ⟨⟨fun e => h.2 (e ▸ hj), h.1⟩, h.2⟩
  rw [e1, e2, Finset.card_erase_of_mem hj, Finset.card_erase_of_mem (Finset.mem_compl.mpr hk)]
  have h1 : 1 ≤ T.card := Finset.card_pos.mpr ⟨j, hj⟩
  have h2 : 1 ≤ Tᶜ.card := Finset.card_pos.mpr ⟨k, Finset.mem_compl.mpr hk⟩
  push_cast [Nat.cast_sub h1, Nat.cast_sub h2]
  exact ⟨rfl, rfl⟩

/-! ## The sphere product -/

section sphere

variable (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ)

theorem sw_entry {a b : Fin n} (hab : a ≠ b) :
    (t • sphereWeight T) a b = if a ∈ T then (if b ∈ T then t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) else -t)
      else (if b ∈ T then -t else t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))) := by
  rw [smul_sphereWeight_eq]
  simp [HamiltonsCubic.Results.blockW, hab]

include hp hq in
/-- **A cross pair contributes `θ²/4`.** -/
theorem pair_cross_sphere {j k : Fin n} (hj : j ∈ T) (hk : k ∉ T) :
    ∑ m ∈ Sset j k, ∑ i ∈ Sset j k, Lb (t • sphereWeight T) j k m i ^ 2 - (t • sphereWeight T) j k ^ 2 / 4
      = dnθ T t ^ 2 / 4 := by
  have hjk : j ≠ k := fun e => hk (e ▸ hj)
  set A := t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1))
  set B := t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))
  have hw := smul_sphereWeight_eq T t
  rw [hw]
  obtain ⟨c1, c2⟩ := cards_cross hj hk
  rw [pair_block T A B (-t) j k (A / 2) (B / 2)
    (fun m hm hmT => by
      obtain ⟨hmj, hmk⟩ := mem_Sset.mp hm
      simp [HamiltonsCubic.Results.blockW, hmj.symm, hmk.symm, hjk, hj, hk, hmT]; ring)
    (fun m hm hmT => by
      obtain ⟨hmj, hmk⟩ := mem_Sset.mp hm
      simp [HamiltonsCubic.Results.blockW, hmj.symm, hmk.symm, hjk, hj, hk, hmT]; ring), c1, c2]
  have hjkv : HamiltonsCubic.Results.blockW T A B (-t) j k = -t := by
    simp [HamiltonsCubic.Results.blockW, hjk, hj, hk]
  rw [hjkv]
  have hp1 : (T.card : ℝ) - 1 ≠ 0 := by have : (3 : ℝ) ≤ T.card := by exact_mod_cast hp
                                        linarith
  have hq1 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by have : (3 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
                                         linarith
  simp only [A, B, dnθ]
  field_simp
  ring

include hp hq in
/-- **A pair within `T` contributes `θ²(λ_p² + (q − 1)μ²)`.** -/
theorem pair_within_sphere {j k : Fin n} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) :
    ∑ m ∈ Sset j k, ∑ i ∈ Sset j k, Lb (t • sphereWeight T) j k m i ^ 2 - (t • sphereWeight T) j k ^ 2 / 4
      = dnθ T t ^ 2 * (dnLp T ^ 2 + ((Tᶜ.card : ℝ) - 1) * dnMu T ^ 2) := by
  set A := t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1))
  set B := t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))
  have hw := smul_sphereWeight_eq T t
  rw [hw]
  obtain ⟨c1, c2⟩ := cards_within hj hk hjk
  rw [pair_block T A B (-t) j k (A / 2) ((1 / 2) * (2 * (-t) - A))
    (fun m hm hmT => by
      obtain ⟨hmj, hmk⟩ := mem_Sset.mp hm
      simp [HamiltonsCubic.Results.blockW, hmj.symm, hmk.symm, hjk, hj, hk, hmT]; ring)
    (fun m hm hmT => by
      obtain ⟨hmj, hmk⟩ := mem_Sset.mp hm
      simp [HamiltonsCubic.Results.blockW, hmj.symm, hmk.symm, hjk, hj, hk, hmT]; ring), c1, c2]
  have hjkv : HamiltonsCubic.Results.blockW T A B (-t) j k = A := by
    simp [HamiltonsCubic.Results.blockW, hjk, hj, hk, A]
  rw [hjkv]
  have hp1 : (T.card : ℝ) - 1 ≠ 0 := by have : (3 : ℝ) ≤ T.card := by exact_mod_cast hp
                                        linarith
  have hq1 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by have : (3 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
                                         linarith
  simp only [A, B, dnθ, dnLp, dnMu]
  field_simp
  ring

theorem sphereWeight_compl : sphereWeight Tᶜ = sphereWeight T := by
  ext a b
  unfold sphereWeight
  simp only [Matrix.of_apply, compl_compl, Finset.mem_compl]
  by_cases hab : a = b
  · simp [hab]
  · by_cases ha : a ∈ T <;> by_cases hb : b ∈ T <;> simp [hab, ha, hb]

theorem dnθ_compl : dnθ Tᶜ t = dnθ T t := by unfold dnθ; rw [compl_compl]; ring
theorem dnLp_compl : dnLp Tᶜ = dnLq T := by unfold dnLp dnLq; rfl
theorem dnMu_compl : dnMu Tᶜ = dnMu T := by unfold dnMu; rw [compl_compl]; ring

include hp hq in
/-- **A pair within `Tᶜ` contributes `θ²(λ_q² + (p − 1)μ²)`.** -/
theorem pair_within_compl_sphere {j k : Fin n} (hj : j ∉ T) (hk : k ∉ T) (hjk : j ≠ k) :
    ∑ m ∈ Sset j k, ∑ i ∈ Sset j k, Lb (t • sphereWeight T) j k m i ^ 2 - (t • sphereWeight T) j k ^ 2 / 4
      = dnθ T t ^ 2 * (dnLq T ^ 2 + ((T.card : ℝ) - 1) * dnMu T ^ 2) := by
  have h := pair_within_sphere Tᶜ hq (by rwa [compl_compl]) t (Finset.mem_compl.mpr hj) (Finset.mem_compl.mpr hk) hjk
  rw [sphereWeight_compl, dnθ_compl, dnLp_compl, dnMu_compl, compl_compl] at h
  exact h

end sphere

end HamiltonsCubic.B12PairSphere
