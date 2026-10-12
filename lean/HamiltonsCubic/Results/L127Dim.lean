import HamiltonsCubic.Results.L127WMult

set_option linter.style.longLine false

/-!
# L127's dimension counts, as declarations

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table: the cross-factor pair block has
spectrum `{½ simple, 0^{n−4}}`, and the within-factor block carries `(−μ)^{q−1}` and a kernel of dimension `p − 3`.
[L127Mult.lean](L127Mult.lean) and [L127WMult.lean](L127WMult.lean) characterise each eigenspace on the Ricci cut by
its coefficients. This file counts them. A coefficient vector is taken to vanish off the pair index set
`s = {i : i ≠ j, i ≠ k}`, and on such vectors the coefficient map `c ↦ ∑ c_i f_i` is injective (`pairCoeff_inj`), and
[L127DimOp.lean](L127DimOp.lean) carries each count to the eigenspace of operators:

* **`finrank_ker_blockSums2`**, **`finrank_ker_blockSums1`**: the vectors vanishing off `A ∪ B` with zero sum on each
  of the disjoint nonempty blocks `A`, `B` form a space of dimension `|A| + |B| − 2`, and on one block `|A| − 1`;
* **`cross_kernel_finrank`**: at `j ∈ T`, `k ∉ T`, the cross kernel on the Ricci cut has dimension `n − 4`;
* **`cross_top_finrank`**: its `t(n − 1)/2`-eigenspace on the Ricci cut is one line, spanned by `(q − 1)` on the first
  factor and `−(p − 1)` on the second;
* **`within_kernel_finrank`**: at `j, k ∈ T`, `p ≥ 3`, the within kernel on the Ricci cut has dimension `p − 3`;
* **`within_neg_finrank`**: its negative eigenspace on the Ricci cut has dimension `q − 1`.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- Restriction to the complement of `A ∪ B`, and the sums over `A` and over `B`. -/
def blockSums2 (A B : Finset ι) : (ι → ℝ) →ₗ[ℝ] ((↥(A ∪ B)ᶜ → ℝ) × ℝ × ℝ) where
  toFun c := (fun x => c x, ∑ i ∈ A, c i, ∑ i ∈ B, c i)
  map_add' c d := by
    simp only [Pi.add_apply, Finset.sum_add_distrib, Prod.mk_add_mk]; rfl
  map_smul' r c := by
    simp only [Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, RingHom.id_apply, Prod.smul_mk]; rfl

/-- Restriction to the complement of `A`, and the sum over `A`. -/
def blockSums1 (A : Finset ι) : (ι → ℝ) →ₗ[ℝ] ((↥Aᶜ → ℝ) × ℝ) where
  toFun c := (fun x => c x, ∑ i ∈ A, c i)
  map_add' c d := by
    simp only [Pi.add_apply, Finset.sum_add_distrib, Prod.mk_add_mk]; rfl
  map_smul' r c := by
    simp only [Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, RingHom.id_apply, Prod.smul_mk]; rfl

theorem mem_ker_blockSums1 (A : Finset ι) (c : ι → ℝ) :
    c ∈ LinearMap.ker (blockSums1 A) ↔ (∀ i ∉ A, c i = 0) ∧ ∑ i ∈ A, c i = 0 := by
  rw [LinearMap.mem_ker]
  change ((fun x : ↥Aᶜ => c x, ∑ i ∈ A, c i) : (↥Aᶜ → ℝ) × ℝ) = 0 ↔ _
  rw [Prod.ext_iff, funext_iff]
  simp only [Prod.fst_zero, Prod.snd_zero, Pi.zero_apply, Subtype.forall, Finset.mem_compl]

theorem mem_ker_blockSums2 (A B : Finset ι) (c : ι → ℝ) :
    c ∈ LinearMap.ker (blockSums2 A B)
      ↔ (∀ i ∉ A ∪ B, c i = 0) ∧ ∑ i ∈ A, c i = 0 ∧ ∑ i ∈ B, c i = 0 := by
  rw [LinearMap.mem_ker]
  change ((fun x : ↥(A ∪ B)ᶜ => c x, ∑ i ∈ A, c i, ∑ i ∈ B, c i) : (↥(A ∪ B)ᶜ → ℝ) × ℝ × ℝ) = 0 ↔ _
  rw [Prod.ext_iff, Prod.ext_iff, funext_iff]
  simp only [Prod.fst_zero, Prod.snd_zero, Pi.zero_apply, Subtype.forall, Finset.mem_compl]

/-- **One block**: the vectors vanishing off a nonempty `A` with zero sum on it form a space of dimension `|A| − 1`. -/
theorem finrank_ker_blockSums1 (A : Finset ι) (hA : A.Nonempty) :
    Module.finrank ℝ (LinearMap.ker (blockSums1 A)) = A.card - 1 := by
  obtain ⟨a, ha⟩ := hA
  have hsurj : Function.Surjective (blockSums1 A) := by
    rintro ⟨z, r⟩
    refine ⟨fun i => if hi : i ∈ A then (if i = a then r else 0) else z ⟨i, Finset.mem_compl.mpr hi⟩, ?_⟩
    change ((fun x : ↥Aᶜ => _, ∑ i ∈ A, _) : (↥Aᶜ → ℝ) × ℝ) = (z, r)
    refine Prod.ext (funext fun x => ?_) ?_
    · have hx : (x : ι) ∉ A := Finset.mem_compl.mp x.2
      simp only [dif_neg hx]
    · change ∑ i ∈ A, (if hi : i ∈ A then (if i = a then r else 0) else _) = r
      have e : ∀ i ∈ A, (if hi : i ∈ A then (if i = a then r else 0) else z ⟨i, Finset.mem_compl.mpr hi⟩)
          = if i = a then r else 0 := fun i hi => dif_pos hi
      rw [Finset.sum_congr rfl e, Finset.sum_ite_eq' A a, if_pos ha]
  have h := LinearMap.finrank_range_add_finrank_ker (blockSums1 A)
  rw [LinearMap.range_eq_top.mpr hsurj, finrank_top, Module.finrank_prod, Module.finrank_fintype_fun_eq_card,
    Module.finrank_fintype_fun_eq_card, Fintype.card_coe, Module.finrank_self] at h
  have hc := Finset.card_compl_add_card A
  have := Finset.card_pos.mpr ⟨a, ha⟩
  omega

/-- **Two blocks**: the vectors vanishing off `A ∪ B`, `A`, `B` disjoint and nonempty, with zero sum on each block, form
a space of dimension `|A| + |B| − 2`. -/
theorem finrank_ker_blockSums2 (A B : Finset ι) (hAB : Disjoint A B) (hA : A.Nonempty) (hB : B.Nonempty) :
    Module.finrank ℝ (LinearMap.ker (blockSums2 A B)) = A.card + B.card - 2 := by
  obtain ⟨a, ha⟩ := hA
  obtain ⟨b, hb⟩ := hB
  have hbA : b ∉ A := fun h => Finset.disjoint_left.mp hAB h hb
  have hsurj : Function.Surjective (blockSums2 A B) := by
    rintro ⟨z, r, r'⟩
    refine ⟨fun i => if hi : i ∈ A ∪ B then (if i = a then r else if i = b then r' else 0)
      else z ⟨i, Finset.mem_compl.mpr hi⟩, ?_⟩
    change ((fun x : ↥(A ∪ B)ᶜ => _, ∑ i ∈ A, _, ∑ i ∈ B, _) : (↥(A ∪ B)ᶜ → ℝ) × ℝ × ℝ) = (z, r, r')
    refine Prod.ext (funext fun x => ?_) (Prod.ext ?_ ?_)
    · have hx : (x : ι) ∉ A ∪ B := Finset.mem_compl.mp x.2
      simp only [dif_neg hx]
    · change ∑ i ∈ A, (if hi : i ∈ A ∪ B then _ else _) = r
      have e : ∀ i ∈ A, (if hi : i ∈ A ∪ B then (if i = a then r else if i = b then r' else 0)
          else z ⟨i, Finset.mem_compl.mpr hi⟩) = if i = a then r else 0 := fun i hi => by
        rw [dif_pos (Finset.mem_union_left B hi)]
        have hib : i ≠ b := fun e => hbA (e ▸ hi)
        split_ifs <;> rfl
      rw [Finset.sum_congr rfl e, Finset.sum_ite_eq' A a, if_pos ha]
    · change ∑ i ∈ B, (if hi : i ∈ A ∪ B then _ else _) = r'
      have haB : a ∉ B := fun h => Finset.disjoint_left.mp hAB ha h
      have e : ∀ i ∈ B, (if hi : i ∈ A ∪ B then (if i = a then r else if i = b then r' else 0)
          else z ⟨i, Finset.mem_compl.mpr hi⟩) = if i = b then r' else 0 := fun i hi => by
        rw [dif_pos (Finset.mem_union_right A hi)]
        have hia : i ≠ a := fun e => haB (e ▸ hi)
        rw [if_neg hia]
      rw [Finset.sum_congr rfl e, Finset.sum_ite_eq' B b, if_pos hb]
  have h := LinearMap.finrank_range_add_finrank_ker (blockSums2 A B)
  rw [LinearMap.range_eq_top.mpr hsurj, finrank_top, Module.finrank_prod, Module.finrank_prod,
    Module.finrank_fintype_fun_eq_card, Module.finrank_fintype_fun_eq_card, Fintype.card_coe, Module.finrank_self] at h
  have hc := Finset.card_compl_add_card (A ∪ B)
  rw [Finset.card_union_of_disjoint hAB] at hc
  have := Finset.card_pos.mpr ⟨a, ha⟩
  have := Finset.card_pos.mpr ⟨b, hb⟩
  omega

/-- **The coefficient map is injective on vectors vanishing off the pair index set**: two such coefficient vectors
giving the same operator on every bivector are equal, which [L127DimOp.lean](L127DimOp.lean) uses to carry each count
below to the operators. -/
theorem pairCoeff_inj {j k : ι} (hjk : j ≠ k) (c d : ι → ℝ)
    (hc : ∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) (hd : ∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), d i = 0)
    (h : ∀ X : Matrix ι ι ℝ, IsSkew X →
      ∑ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c q • rk2 (phi j q) (phi k q) X
        = ∑ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), d q • rk2 (phi j q) (phi k q) X) : c = d := by
  have h1 := (pairSpan_eq_iff hjk c d 1).mp (fun X hX => by rw [one_smul]; exact h X hX)
  funext i
  by_cases hi : i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i)
  · rw [h1 i hi, one_mul]
  · rw [hc i hi, hd i hi]

/-- The pair index set has `n − 2` elements. -/
theorem pairIdx_card {j k : ι} (hjk : j ≠ k) : (univ.filter (fun i => j ≠ i ∧ k ≠ i)).card + 2 = Fintype.card ι := by
  have h := Finset.card_filter_add_card_filter_not (s := (univ : Finset ι)) (fun i => j ≠ i ∧ k ≠ i)
  have e : (univ : Finset ι).filter (fun i => ¬ (j ≠ i ∧ k ≠ i)) = {j, k} := by
    ext i; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_insert, Finset.mem_singleton]
    constructor
    · intro hi; by_contra hc; push Not at hc; exact hi ⟨Ne.symm hc.1, Ne.symm hc.2⟩
    · rintro (rfl | rfl) ⟨h1, h2⟩ <;> simp_all
  rw [e, Finset.card_pair hjk, Finset.card_univ] at h
  exact h

/-- **The cross kernel's coefficients** (`j ∈ T`, `k ∉ T`): vanishing off the pair index set, on the Ricci cut, and
annihilated by `M ∘`, exactly the kernel of `blockSums2` on the two factors' parts of the pair index set. -/
theorem cross_kernel_mem (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∉ T) (c : ι → ℝ) :
    ((∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
      ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0
      ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
        foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
          c i • rk2 (phi j i) (phi k i) Y) X = 0)
      ↔ c ∈ LinearMap.ker (blockSums2 ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T))
          ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∉ T))) := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  rw [mem_ker_blockSums2, Finset.filter_union_filter_not_eq]
  have hsplit := sum_split_T T s c
  constructor
  · rintro ⟨h0, hsum, hker⟩
    have hA := (cross_kernel_iff T hp hq t ht hj hk c hsum).mp hker
    exact ⟨h0, hA, by linarith⟩
  · rintro ⟨h0, hA, hB⟩
    have hsum : ∑ i ∈ s, c i = 0 := by linarith
    exact ⟨h0, hsum, (cross_kernel_iff T hp hq t ht hj hk c hsum).mpr hA⟩

/-- **The cross kernel has dimension `n − 4`.** -/
theorem cross_kernel_finrank (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) {j k : ι} (hj : j ∈ T) (hk : k ∉ T) :
    Module.finrank ℝ (LinearMap.ker (blockSums2 ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T))
      ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∉ T)))) = Fintype.card ι - 4 := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hA : (s.filter (· ∈ T)).Nonempty := by
    obtain ⟨q, hqT, hqj⟩ : ∃ q ∈ T, q ≠ j := by
      by_contra hc; push Not at hc
      have : T ⊆ {j} := fun x hx => Finset.mem_singleton.mpr (hc x hx)
      have := Finset.card_le_card this; simp at this; omega
    exact ⟨q, Finset.mem_filter.mpr ⟨Finset.mem_filter.mpr ⟨Finset.mem_univ _, Ne.symm hqj,
      fun e => hk (e ▸ hqT)⟩, hqT⟩⟩
  have hB : (s.filter (· ∉ T)).Nonempty := by
    obtain ⟨q, hqT, hqk⟩ : ∃ q ∈ Tᶜ, q ≠ k := by
      by_contra hc; push Not at hc
      have : Tᶜ ⊆ {k} := fun x hx => Finset.mem_singleton.mpr (hc x hx)
      have := Finset.card_le_card this; simp at this; omega
    have hqT' := Finset.mem_compl.mp hqT
    exact ⟨q, Finset.mem_filter.mpr ⟨Finset.mem_filter.mpr ⟨Finset.mem_univ _, fun e => hqT' (e ▸ hj),
      Ne.symm hqk⟩, hqT'⟩⟩
  rw [finrank_ker_blockSums2 _ _ (Finset.disjoint_filter_filter_not s s _) hA hB,
    Finset.card_filter_add_card_filter_not]
  have : s.card + 2 = Fintype.card ι := pairIdx_card hjk
  omega

/-- At `j, k ∈ T` the second-factor part of the pair index set is all of `Tᶜ`. -/
theorem within_B_eq {T : Finset ι} {j k : ι} (hj : j ∈ T) (hk : k ∈ T) :
    (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∉ T) = Tᶜ := by
  ext i; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_compl]
  constructor
  · exact fun h => h.2
  · intro hi; exact ⟨⟨fun e => hi (e ▸ hj), fun e => hi (e ▸ hk)⟩, hi⟩

/-- **The within kernel's coefficients** (`j, k ∈ T`): vanishing off the pair index set, on the Ricci cut, and
annihilated by `M ∘`, exactly the kernel of `blockSums1` on the first factor's part of the pair index set. -/
theorem within_kernel_mem (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (c : ι → ℝ) :
    ((∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
      ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0
      ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
        foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
          c i • rk2 (phi j i) (phi k i) Y) X
          = (0 : ℝ) • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X)
      ↔ c ∈ LinearMap.ker (blockSums1 ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T))) := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  rw [mem_ker_blockSums1]
  have hsplit := sum_split_T T s c
  constructor
  · rintro ⟨h0, hsum, h⟩
    obtain ⟨hA, hB⟩ := (within_kernel_iff T hp hq t ht hj hk hjk c hsum).mp h
    refine ⟨fun i hi => ?_, hA⟩
    by_cases his : i ∈ s
    · exact hB i his (fun hiT => hi (Finset.mem_filter.mpr ⟨his, hiT⟩))
    · exact h0 i his
  · rintro ⟨h0, hA⟩
    have hB : ∀ q ∈ s, q ∉ T → c q = 0 := fun q _ hqT => h0 q (fun h => hqT (Finset.mem_filter.mp h).2)
    have hBs : ∑ i ∈ s.filter (· ∉ T), c i = 0 :=
      Finset.sum_eq_zero fun i hi => hB i (Finset.mem_filter.mp hi).1 (Finset.mem_filter.mp hi).2
    have hsum : ∑ i ∈ s, c i = 0 := by linarith
    exact ⟨fun i hi => h0 i (fun h => hi (Finset.mem_filter.mp h).1), hsum,
      (within_kernel_iff T hp hq t ht hj hk hjk c hsum).mpr ⟨hA, hB⟩⟩

/-- **The within kernel has dimension `p − 3`**, at `p ≥ 3`. -/
theorem within_kernel_finrank (T : Finset ι) (hp : 3 ≤ T.card) {j k : ι} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) :
    Module.finrank ℝ (LinearMap.ker (blockSums1 ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T))))
      = T.card - 3 := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  have hA : (s.filter (· ∈ T)).Nonempty := by
    obtain ⟨q, hqT, hqj, hqk⟩ : ∃ q ∈ T, q ≠ j ∧ q ≠ k := by
      by_contra hc; push Not at hc
      have : T ⊆ {j, k} := fun x hx => by
        by_cases e : x = j
        · simp [e]
        · simp [hc x hx e]
      have := (Finset.card_le_card this).trans (Finset.card_le_two); omega
    exact ⟨q, Finset.mem_filter.mpr ⟨Finset.mem_filter.mpr ⟨Finset.mem_univ _, Ne.symm hqj, Ne.symm hqk⟩, hqT⟩⟩
  rw [finrank_ker_blockSums1 _ hA]
  have h1 := Finset.card_filter_add_card_filter_not (s := s) (· ∈ T)
  rw [within_B_eq hj hk] at h1
  have h2 : s.card + 2 = Fintype.card ι := pairIdx_card hjk
  have h3 := Finset.card_compl_add_card T
  omega

/-- **The within negative eigenspace's coefficients** (`j, k ∈ T`): vanishing off the pair index set, on the Ricci
cut, and in the `−½(2t + α + β)`-eigenspace, exactly the kernel of `blockSums1` on `Tᶜ`. -/
theorem within_neg_mem (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (c : ι → ℝ) :
    ((∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
      ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0
      ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
        foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
          c i • rk2 (phi j i) (phi k i) Y) X
          = ((1 / 2 : ℝ) * (-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))))
            • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X)
      ↔ c ∈ LinearMap.ker (blockSums1 Tᶜ) := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  rw [mem_ker_blockSums1]
  have hsplit := sum_split_T T s c
  have hB := within_B_eq (T := T) hj hk
  rw [← hsdef] at hB
  constructor
  · rintro ⟨h0, hsum, h⟩
    obtain ⟨hA, hBs⟩ := (within_neg_iff T hp hq t ht hj hk hjk c hsum).mp h
    rw [hB] at hBs
    refine ⟨fun i hi => ?_, hBs⟩
    have hiT : i ∈ T := by simpa using hi
    by_cases his : i ∈ s
    · exact hA i his hiT
    · exact h0 i his
  · rintro ⟨h0, hBs⟩
    have hA : ∀ q ∈ s, q ∈ T → c q = 0 := fun q _ hqT => h0 q (by simpa using hqT)
    have hAs : ∑ i ∈ s.filter (· ∈ T), c i = 0 :=
      Finset.sum_eq_zero fun i hi => hA i (Finset.mem_filter.mp hi).1 (Finset.mem_filter.mp hi).2
    rw [hB] at hsplit
    have hsum : ∑ i ∈ s, c i = 0 := by linarith
    refine ⟨fun i hi => ?_, hsum, (within_neg_iff T hp hq t ht hj hk hjk c hsum).mpr ⟨hA, by rw [hB]; exact hBs⟩⟩
    have hiT : i ∈ T := by
      by_contra hiT; exact hi (Finset.mem_filter.mpr ⟨Finset.mem_univ _, fun e => hiT (e ▸ hj), fun e => hiT (e ▸ hk)⟩)
    exact h0 i (by simpa using hiT)

/-- **The within negative eigenspace has dimension `q − 1`**, the record's `(−μ)^{q−1}`. -/
theorem within_neg_finrank (T : Finset ι) (hq : 2 ≤ Tᶜ.card) :
    Module.finrank ℝ (LinearMap.ker (blockSums1 Tᶜ)) = Tᶜ.card - 1 :=
  finrank_ker_blockSums1 _ (Finset.card_pos.mp (by omega))

/-- The orbit direction's coefficients at `j ∈ T`, `k ∉ T`: `q − 1` on the first factor's part of the pair index set,
`−(p − 1)` on the second's, zero at `j` and `k`. -/
noncomputable def crossTopVec (T : Finset ι) (j k : ι) : ι → ℝ := fun i =>
  if i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i) then (if i ∈ T then (Tᶜ.card : ℝ) - 1 else -((T.card : ℝ) - 1)) else 0

theorem cross_parts_card (T : Finset ι) {j k : ι} (hj : j ∈ T) (hk : k ∉ T) :
    ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T)).card + 1 = T.card
      ∧ ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∉ T)).card + 1 = Tᶜ.card := by
  have eA : (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T) = T.erase j := by
    ext i; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_erase]
    constructor
    · rintro ⟨⟨h1, _⟩, h3⟩; exact ⟨Ne.symm h1, h3⟩
    · rintro ⟨h1, h3⟩; exact ⟨⟨Ne.symm h1, fun e => hk (e ▸ h3)⟩, h3⟩
  have eB : (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∉ T) = Tᶜ.erase k := by
    ext i; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_erase, Finset.mem_compl]
    constructor
    · rintro ⟨⟨_, h2⟩, h3⟩; exact ⟨Ne.symm h2, h3⟩
    · rintro ⟨h2, h3⟩; exact ⟨⟨fun e => h3 (e ▸ hj), Ne.symm h2⟩, h3⟩
  rw [eA, eB, Finset.card_erase_add_one hj, Finset.card_erase_add_one (Finset.mem_compl.mpr hk)]
  exact ⟨rfl, rfl⟩

/-- **The cross `t(n − 1)/2`-eigenspace's coefficients** (`j ∈ T`, `k ∉ T`): vanishing off the pair index set, on the
Ricci cut, and in the `t(n − 1)/2`-eigenspace, exactly the multiples of `crossTopVec`. -/
theorem cross_top_mem (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∉ T) (c : ι → ℝ) :
    ((∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
      ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0
      ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
        foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
          c i • rk2 (phi j i) (phi k i) Y) X
          = (t * ((T.card : ℝ) + Tᶜ.card - 1) / 2) • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X)
      ↔ c ∈ Submodule.span ℝ {crossTopVec T j k} := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  obtain ⟨cA, cB⟩ := cross_parts_card T hj hk
  rw [← hsdef] at cA cB
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hp1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have hq1 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by linarith
  have cAR : ((s.filter (· ∈ T)).card : ℝ) = (T.card : ℝ) - 1 := by rw [← cA]; push_cast; ring
  have cBR : ((s.filter (· ∉ T)).card : ℝ) = (Tᶜ.card : ℝ) - 1 := by rw [← cB]; push_cast; ring
  -- the block sums of `a • crossTopVec`
  have hSA : ∀ a : ℝ, ∑ i ∈ s.filter (· ∈ T), (a • crossTopVec T j k) i = a * ((Tᶜ.card : ℝ) - 1) * ((T.card : ℝ) - 1) := by
    intro a
    rw [Finset.sum_congr rfl (fun i hi => show (a • crossTopVec T j k) i = a * ((Tᶜ.card : ℝ) - 1) by
      simp only [Pi.smul_apply, smul_eq_mul, crossTopVec, ← hsdef, if_pos (Finset.mem_filter.mp hi).1,
        if_pos (Finset.mem_filter.mp hi).2]), Finset.sum_const, nsmul_eq_mul, cAR]
    ring
  have hSB : ∀ a : ℝ, ∑ i ∈ s.filter (· ∉ T), (a • crossTopVec T j k) i = -(a * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)) := by
    intro a
    rw [Finset.sum_congr rfl (fun i hi => show (a • crossTopVec T j k) i = a * -((T.card : ℝ) - 1) by
      simp only [Pi.smul_apply, smul_eq_mul, crossTopVec, ← hsdef, if_pos (Finset.mem_filter.mp hi).1,
        if_neg (Finset.mem_filter.mp hi).2]), Finset.sum_const, nsmul_eq_mul, cBR]
    ring
  rw [Submodule.mem_span_singleton]
  constructor
  · rintro ⟨h0, hsum, h⟩
    have hc := (cross_top_iff T hp hq t ht hj hk c hsum).mp h
    rw [← hsdef] at hc
    have hsplit := sum_split_T T s c
    refine ⟨(∑ i ∈ s.filter (· ∈ T), c i) / (((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)), funext fun i => ?_⟩
    simp only [Pi.smul_apply, smul_eq_mul, crossTopVec, ← hsdef]
    by_cases his : i ∈ s
    · rw [if_pos his, hc i his]
      split_ifs
      · field_simp
      · rw [show ∑ i ∈ s.filter (· ∉ T), c i = -∑ i ∈ s.filter (· ∈ T), c i by linarith]
        field_simp
    · rw [if_neg his, h0 i his, mul_zero]
  · rintro ⟨a, rfl⟩
    have hsplit := sum_split_T T s (a • crossTopVec T j k)
    have hsum : ∑ i ∈ s, (a • crossTopVec T j k) i = 0 := by rw [hsplit, hSA, hSB]; ring
    refine ⟨fun i hi => by simp only [Pi.smul_apply, smul_eq_mul, crossTopVec, ← hsdef, if_neg hi, mul_zero], hsum,
      (cross_top_iff T hp hq t ht hj hk _ hsum).mpr fun q hq' => ?_⟩
    rw [← hsdef] at hq' ⊢
    rw [hSA, hSB]
    simp only [Pi.smul_apply, smul_eq_mul, crossTopVec, ← hsdef, if_pos hq']
    split_ifs
    · field_simp
    · field_simp

/-- **The cross `t(n − 1)/2`-eigenspace on the Ricci cut is one line**: `crossTopVec` is nonzero. -/
theorem cross_top_finrank (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) {j k : ι} (hk : k ∉ T) :
    Module.finrank ℝ (Submodule.span ℝ {crossTopVec T j k}) = 1 := by
  apply finrank_span_singleton
  obtain ⟨q, hqT, hqj⟩ : ∃ q ∈ T, q ≠ j := by
    by_contra hc; push Not at hc
    have : T ⊆ {j} := fun x hx => Finset.mem_singleton.mpr (hc x hx)
    have := Finset.card_le_card this; simp at this; omega
  have hqs : q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i) :=
    Finset.mem_filter.mpr ⟨Finset.mem_univ _, Ne.symm hqj, fun e => hk (e ▸ hqT)⟩
  intro h
  have e := congrFun h q
  simp only [crossTopVec, if_pos hqs, if_pos hqT, Pi.zero_apply] at e
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  linarith

end HamiltonsCubic.L121Block
