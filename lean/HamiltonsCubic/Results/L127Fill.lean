import HamiltonsCubic.Results.L127Dim
import HamiltonsCubic.Results.L127WTop

set_option linter.style.longLine false

/-!
# L127's pair blocks: their eigenspaces fill the Ricci cut

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, cross-factor row: the pair block
carries `{½ simple, 0^{n−4}}` on the Ricci cut. [L127Dim.lean](L127Dim.lean) gives the coefficient spaces of the two
eigenspaces (`cross_kernel_mem`, `cross_top_mem`) and their dimensions `n − 4` and `1`. This file shows they fill the
cut, at `j ∈ T`, `k ∉ T`, `p, q ≥ 2`, with `s` the pair index set:

* **`cut_finrank`**: the Ricci cut `ker (blockSums1 s)` (vanishing off `s`, zero sum) has dimension `n − 3`;
* **`crossKer_le_cut`**, **`crossTopVec_mem_cut`**: both eigenspaces lie in it;
* **`crossKer_inf_top`**: they meet in `0`, the top vector's first-factor sum being `(p − 1)(q − 1) ≠ 0`;
* **`cross_fill`**: their sum is the whole cut, by dimension;
* **`within_A_card`**, **`withinK1_le_cut`**, **`withinK2_le_cut`**, **`withinTopVec_mem_cut`**, **`withinK1_inf_K2`**,
  **`withinK12_inf_top`**, **`within_fill`**: at `j, k ∈ T`, `p ≥ 3`, `q ≥ 2` the within block's kernel, negative
  eigenspace and top line fill the cut, `(p − 3) + (q − 1) + 1 = n − 3`;
* **`within_fill_two`**: at `p = 2` the pair index set is `Tᶜ` and the negative eigenspace is the whole cut.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

section cross

variable (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) {j k : ι} (hj : j ∈ T) (hk : k ∉ T)

/-- The pair index set. -/
abbrev pidx (j k : ι) : Finset ι := univ.filter (fun i => j ≠ i ∧ k ≠ i)

include hp hj hk in
theorem cut_finrank : Module.finrank ℝ (LinearMap.ker (blockSums1 (pidx j k))) = Fintype.card ι - 3 := by
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hc : (pidx j k).card + 2 = Fintype.card ι := pairIdx_card hjk
  obtain ⟨x, hxT, hxj⟩ : ∃ x ∈ T, x ≠ j := by
    by_contra hcon; push Not at hcon
    have : T ⊆ {j} := fun y hy => Finset.mem_singleton.mpr (hcon y hy)
    have := Finset.card_le_card this; simp at this; omega
  have hne : (pidx j k).Nonempty :=
    ⟨x, Finset.mem_filter.mpr ⟨Finset.mem_univ _, Ne.symm hxj, fun e => hk (e ▸ hxT)⟩⟩
  rw [finrank_ker_blockSums1 _ hne]; omega

omit [Fintype ι] in
theorem crossKer_le_cut [Fintype ι] :
    LinearMap.ker (blockSums2 ((pidx j k).filter (· ∈ T)) ((pidx j k).filter (· ∉ T)))
      ≤ LinearMap.ker (blockSums1 (pidx j k)) := by
  intro c hc
  rw [mem_ker_blockSums2, Finset.filter_union_filter_not_eq] at hc
  rw [mem_ker_blockSums1]
  refine ⟨hc.1, ?_⟩
  rw [← Finset.sum_filter_add_sum_filter_not (pidx j k) (· ∈ T), hc.2.1, hc.2.2, add_zero]

/-- The first-factor sum of the top vector. -/
theorem crossTop_sumA :
    ∑ i ∈ (pidx j k).filter (· ∈ T), crossTopVec T j k i
      = (((pidx j k).filter (· ∈ T)).card : ℝ) * ((Tᶜ.card : ℝ) - 1) := by
  rw [Finset.sum_congr rfl fun i hi => (show crossTopVec T j k i = (Tᶜ.card : ℝ) - 1 by
    have := Finset.mem_filter.mp hi; simp [crossTopVec, this.1, this.2]), Finset.sum_const, nsmul_eq_mul]

theorem crossTop_sumB :
    ∑ i ∈ (pidx j k).filter (· ∉ T), crossTopVec T j k i
      = (((pidx j k).filter (· ∉ T)).card : ℝ) * (-((T.card : ℝ) - 1)) := by
  rw [Finset.sum_congr rfl fun i hi => (show crossTopVec T j k i = -((T.card : ℝ) - 1) by
    have := Finset.mem_filter.mp hi; simp [crossTopVec, this.1, this.2]), Finset.sum_const, nsmul_eq_mul]

include hj hk in
theorem crossTopVec_mem_cut : crossTopVec T j k ∈ LinearMap.ker (blockSums1 (pidx j k)) := by
  obtain ⟨cA, cB⟩ := cross_parts_card T hj hk
  have eA : (((pidx j k).filter (· ∈ T)).card : ℝ) = (T.card : ℝ) - 1 := by
    have : (((pidx j k).filter (· ∈ T)).card : ℝ) + 1 = T.card := by exact_mod_cast cA
    linarith
  have eB : (((pidx j k).filter (· ∉ T)).card : ℝ) = (Tᶜ.card : ℝ) - 1 := by
    have : (((pidx j k).filter (· ∉ T)).card : ℝ) + 1 = Tᶜ.card := by exact_mod_cast cB
    linarith
  rw [mem_ker_blockSums1]
  refine ⟨fun i hi => by simp [crossTopVec, hi], ?_⟩
  rw [← Finset.sum_filter_add_sum_filter_not (pidx j k) (· ∈ T), crossTop_sumA, crossTop_sumB, eA, eB]
  ring

include hp hq hj hk in
/-- **The two cross eigenspaces meet in `0`.** -/
theorem crossKer_inf_top :
    LinearMap.ker (blockSums2 ((pidx j k).filter (· ∈ T)) ((pidx j k).filter (· ∉ T)))
      ⊓ Submodule.span ℝ {crossTopVec T j k} = ⊥ := by
  obtain ⟨cA, -⟩ := cross_parts_card T hj hk
  have eA : (((pidx j k).filter (· ∈ T)).card : ℝ) = (T.card : ℝ) - 1 := by
    have : (((pidx j k).filter (· ∈ T)).card : ℝ) + 1 = T.card := by exact_mod_cast cA
    linarith
  have hpR : (2 : ℝ) ≤ T.card := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  rw [eq_bot_iff]
  rintro v ⟨hK, hL⟩
  obtain ⟨r, rfl⟩ := Submodule.mem_span_singleton.mp hL
  rw [SetLike.mem_coe, mem_ker_blockSums2] at hK
  have hs := hK.2.1
  simp only [Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, crossTop_sumA, eA] at hs
  have hr : r = 0 := by
    rcases mul_eq_zero.mp hs with h | h
    · exact h
    · exfalso; rcases mul_eq_zero.mp h with h' | h' <;> linarith
  rw [hr, zero_smul]; exact Submodule.zero_mem _

include hp hq hj hk in
/-- **The cross block's two eigenspaces fill the Ricci cut**: kernel `⊔` top line is the whole cut, dimension
`(n − 4) + 1 = n − 3`. -/
theorem cross_fill :
    LinearMap.ker (blockSums2 ((pidx j k).filter (· ∈ T)) ((pidx j k).filter (· ∉ T)))
      ⊔ Submodule.span ℝ {crossTopVec T j k} = LinearMap.ker (blockSums1 (pidx j k)) := by
  have hle : LinearMap.ker (blockSums2 ((pidx j k).filter (· ∈ T)) ((pidx j k).filter (· ∉ T)))
      ⊔ Submodule.span ℝ {crossTopVec T j k} ≤ LinearMap.ker (blockSums1 (pidx j k)) :=
    sup_le (crossKer_le_cut T) ((Submodule.span_singleton_le_iff_mem _ _).mpr (crossTopVec_mem_cut T hj hk))
  apply Submodule.eq_of_le_of_finrank_eq hle
  have hsum := Submodule.finrank_sup_add_finrank_inf_eq
    (LinearMap.ker (blockSums2 ((pidx j k).filter (· ∈ T)) ((pidx j k).filter (· ∉ T))))
    (Submodule.span ℝ {crossTopVec T j k})
  rw [crossKer_inf_top T hp hq hj hk, finrank_bot, cross_kernel_finrank T hp hq hj hk,
    cross_top_finrank T hp hq hk] at hsum
  rw [cut_finrank T hp hj hk]
  have : 4 ≤ Fintype.card ι := by
    have := Finset.card_add_card_compl T; omega
  omega

end cross

section within

variable (T : Finset ι) (hp : 3 ≤ T.card) (hq : 2 ≤ Tᶜ.card) {j k : ι} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k)

include hj hk hjk in
theorem within_A_card : ((pidx j k).filter (· ∈ T)).card + 2 = T.card := by
  have e : (pidx j k).filter (· ∈ T) = (T.erase j).erase k := by
    ext i; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_erase]
    constructor
    · rintro ⟨⟨h1, h2⟩, h3⟩; exact ⟨Ne.symm h2, Ne.symm h1, h3⟩
    · rintro ⟨h2, h1, h3⟩; exact ⟨⟨Ne.symm h1, Ne.symm h2⟩, h3⟩
  rw [e, Finset.card_erase_of_mem (Finset.mem_erase.mpr ⟨Ne.symm hjk, hk⟩), Finset.card_erase_of_mem hj]
  have : 2 ≤ T.card := by
    have := Finset.card_le_card (Finset.insert_subset hj (Finset.singleton_subset_iff.mpr hk))
    rw [Finset.card_pair hjk] at this; exact this
  omega

omit [Fintype ι] in
theorem withinK1_le_cut [Fintype ι] :
    LinearMap.ker (blockSums1 ((pidx j k).filter (· ∈ T))) ≤ LinearMap.ker (blockSums1 (pidx j k)) := by
  intro c hc
  rw [mem_ker_blockSums1] at hc ⊢
  refine ⟨fun i hi => hc.1 i (fun h => hi (Finset.mem_filter.mp h).1), ?_⟩
  rw [← Finset.sum_filter_add_sum_filter_not (pidx j k) (· ∈ T), hc.2, zero_add]
  exact Finset.sum_eq_zero fun i hi => hc.1 i (fun h => (Finset.mem_filter.mp hi).2 (Finset.mem_filter.mp h).2)

include hj hk in
theorem withinK2_le_cut : LinearMap.ker (blockSums1 Tᶜ) ≤ LinearMap.ker (blockSums1 (pidx j k)) := by
  have hB := within_B_eq (T := T) hj hk
  intro c hc
  rw [mem_ker_blockSums1] at hc ⊢
  refine ⟨fun i hi => hc.1 i (fun h => hi (by rw [← hB] at h; exact (Finset.mem_filter.mp h).1)), ?_⟩
  rw [← Finset.sum_filter_add_sum_filter_not (pidx j k) (· ∈ T), hB, hc.2, add_zero]
  exact Finset.sum_eq_zero fun i hi => hc.1 i (fun h => (Finset.mem_compl.mp h) (Finset.mem_filter.mp hi).2)

theorem withinTop_sumA :
    ∑ i ∈ (pidx j k).filter (· ∈ T), withinTopVec T j k i = (((pidx j k).filter (· ∈ T)).card : ℝ) * Tᶜ.card := by
  rw [Finset.sum_congr rfl fun i hi => (show withinTopVec T j k i = (Tᶜ.card : ℝ) by
    have := Finset.mem_filter.mp hi; simp [withinTopVec, this.1, this.2]), Finset.sum_const, nsmul_eq_mul]

include hj hk hjk in
theorem withinTopVec_mem_cut : withinTopVec T j k ∈ LinearMap.ker (blockSums1 (pidx j k)) := by
  have hB := within_B_eq (T := T) hj hk
  have cA := within_A_card T hj hk hjk
  have eA : (((pidx j k).filter (· ∈ T)).card : ℝ) = (T.card : ℝ) - 2 := by
    have : (((pidx j k).filter (· ∈ T)).card : ℝ) + 2 = T.card := by exact_mod_cast cA
    linarith
  rw [mem_ker_blockSums1]
  refine ⟨fun i hi => by simp [withinTopVec, hi], ?_⟩
  rw [← Finset.sum_filter_add_sum_filter_not (pidx j k) (· ∈ T), withinTop_sumA, eA]
  have eB : ∑ i ∈ (pidx j k).filter (· ∉ T), withinTopVec T j k i = (Tᶜ.card : ℝ) * (-((T.card : ℝ) - 2)) := by
    rw [Finset.sum_congr rfl fun i hi => (show withinTopVec T j k i = -((T.card : ℝ) - 2) by
      have := Finset.mem_filter.mp hi; simp [withinTopVec, this.1, this.2]), Finset.sum_const, nsmul_eq_mul, hB]
  rw [eB]; ring

omit [Fintype ι] in
theorem withinK1_inf_K2 [Fintype ι] :
    LinearMap.ker (blockSums1 ((pidx j k).filter (· ∈ T))) ⊓ LinearMap.ker (blockSums1 Tᶜ) = ⊥ := by
  rw [eq_bot_iff]
  rintro c ⟨h1, h2⟩
  rw [SetLike.mem_coe, mem_ker_blockSums1] at h1 h2
  rw [Submodule.mem_bot]
  funext i
  by_cases hi : i ∈ T
  · exact h2.1 i (fun h => (Finset.mem_compl.mp h) hi)
  · exact h1.1 i (fun h => hi (Finset.mem_filter.mp h).2)

include hp hq hj hk hjk in
theorem withinK12_inf_top :
    (LinearMap.ker (blockSums1 ((pidx j k).filter (· ∈ T))) ⊔ LinearMap.ker (blockSums1 Tᶜ))
      ⊓ Submodule.span ℝ {withinTopVec T j k} = ⊥ := by
  have cA := within_A_card T hj hk hjk
  have eA : (((pidx j k).filter (· ∈ T)).card : ℝ) = (T.card : ℝ) - 2 := by
    have : (((pidx j k).filter (· ∈ T)).card : ℝ) + 2 = T.card := by exact_mod_cast cA
    linarith
  have hpR : (3 : ℝ) ≤ T.card := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  rw [eq_bot_iff]
  rintro v ⟨hS, hL⟩
  obtain ⟨a, ha, b, hb, hab⟩ := Submodule.mem_sup.mp hS
  obtain ⟨r, rfl⟩ := Submodule.mem_span_singleton.mp hL
  rw [mem_ker_blockSums1] at ha hb
  have hsA : ∑ i ∈ (pidx j k).filter (· ∈ T), (a + b) i = 0 := by
    rw [Pi.add_def, Finset.sum_add_distrib, ha.2, zero_add]
    exact Finset.sum_eq_zero fun i hi => hb.1 i (fun h => (Finset.mem_compl.mp h) (Finset.mem_filter.mp hi).2)
  rw [hab] at hsA
  simp only [Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, withinTop_sumA, eA] at hsA
  have hr : r = 0 := by
    rcases mul_eq_zero.mp hsA with h | h
    · exact h
    · exfalso; rcases mul_eq_zero.mp h with h' | h' <;> linarith
  rw [hr, zero_smul]; exact Submodule.zero_mem _

include hp hq hj hk hjk in
/-- **The within block's three eigenspaces fill the Ricci cut**: kernel `⊔` negative eigenspace `⊔` top line is the
whole cut, dimension `(p − 3) + (q − 1) + 1 = n − 3`. -/
theorem within_fill :
    LinearMap.ker (blockSums1 ((pidx j k).filter (· ∈ T))) ⊔ LinearMap.ker (blockSums1 Tᶜ)
      ⊔ Submodule.span ℝ {withinTopVec T j k} = LinearMap.ker (blockSums1 (pidx j k)) := by
  have hle := sup_le (sup_le (withinK1_le_cut T) (withinK2_le_cut T hj hk))
    ((Submodule.span_singleton_le_iff_mem _ _).mpr (withinTopVec_mem_cut T hj hk hjk))
  apply Submodule.eq_of_le_of_finrank_eq hle
  have h12 := Submodule.finrank_sup_add_finrank_inf_eq (LinearMap.ker (blockSums1 ((pidx j k).filter (· ∈ T))))
    (LinearMap.ker (blockSums1 Tᶜ))
  rw [withinK1_inf_K2 T, finrank_bot, within_kernel_finrank T hp hj hk hjk, within_neg_finrank T hq] at h12
  have h3 := Submodule.finrank_sup_add_finrank_inf_eq
    (LinearMap.ker (blockSums1 ((pidx j k).filter (· ∈ T))) ⊔ LinearMap.ker (blockSums1 Tᶜ))
    (Submodule.span ℝ {withinTopVec T j k})
  rw [withinK12_inf_top T hp hq hj hk hjk, finrank_bot, within_top_finrank T hp hq hj hk] at h3
  have hc : (pidx j k).card + 2 = Fintype.card ι := pairIdx_card hjk
  have cA := within_A_card T hj hk hjk
  have hne : ((pidx j k).filter (· ∈ T)).Nonempty := Finset.card_pos.mp (by omega)
  obtain ⟨x, hx⟩ := hne
  rw [finrank_ker_blockSums1 _ ⟨x, (Finset.mem_filter.mp hx).1⟩]
  have := Finset.card_add_card_compl T
  omega

include hj hk hjk in
/-- **At `p = 2` the within cut is the negative eigenspace alone**: the pair index set is `Tᶜ`. -/
theorem within_fill_two (hp2 : T.card = 2) : LinearMap.ker (blockSums1 Tᶜ) = LinearMap.ker (blockSums1 (pidx j k)) := by
  have hT : T = {j, k} := by
    symm; apply Finset.eq_of_subset_of_card_le (Finset.insert_subset hj (Finset.singleton_subset_iff.mpr hk))
    rw [hp2, Finset.card_pair hjk]
  have e : pidx j k = Tᶜ := by
    ext i; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_compl, hT, Finset.mem_insert,
      Finset.mem_singleton]
    constructor
    · rintro ⟨h1, h2⟩ (rfl | rfl) <;> simp_all
    · intro h; exact ⟨fun e => h (Or.inl e.symm), fun e => h (Or.inr e.symm)⟩
  rw [e]

end within

end HamiltonsCubic.L121Block
