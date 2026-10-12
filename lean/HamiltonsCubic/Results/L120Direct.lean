import HamiltonsCubic.Results.L120Span

set_option linter.style.longLine false

/-!
# L120's decomposition is direct

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: `𝒲ₙ = 𝒟ₙ ⊕ ⨁ V_{ijkl} ⊕ ⨁ V_{jk}`.
[L120Span.lean](L120Span.lean) proves the spanning. This file proves the sum direct, on `Fin n`, with pairs indexed by
`j < k` and four-sets by `i < j < k < l`:

* **`pairForm_unique`**: two `PairForm` positions that coincide name the same unordered pair;
* **`fourForm_sorted_unique`**: two sorted four-sets whose `FourForm` positions coincide are equal;
* **`weyl_direct`**: if a flip-fixed Weyl `D`, `{j,k}`-isotypic Weyl `P_{jk}` (`j < k`) and `{i,j,k,l}`-isotypic Weyl
  `F_{ijkl}` (`i < j < k < l`) sum to zero, every one of them is zero.

The argument is by coordinates: each component vanishes off its own positions (`coord_reduce_flip`, `iso_coord_form`,
`four_coord_form`), those positions are disjoint across the three kinds (`pairForm_shape`, `fourForm_shape`) and
between distinct pairs and four-sets, so at each of a component's positions the sum reads that component alone.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.WeylRadical

variable {n : ℕ}

/-- **Two coinciding `PairForm` positions name the same unordered pair.** -/
theorem pairForm_unique {j k j' k' a b c d : Fin n} (hjk : j ≠ k) (hjk' : j' ≠ k') (h : PairForm j k a b c d)
    (h' : PairForm j' k' a b c d) : (j' = j ∧ k' = k) ∨ (j' = k ∧ k' = j) := by
  obtain ⟨y, hyj, hyk, hpos⟩ := h
  rcases hpos with ⟨hab, hcd⟩ | ⟨hab, hcd⟩
  · exact (pairForm_iff_one hjk (Ne.symm hyj) (Ne.symm hyk) hab hcd j' k').mp ⟨hjk', h'⟩
  · rcases (pairForm_iff_one (Ne.symm hjk) (Ne.symm hyk) (Ne.symm hyj) hab hcd j' k').mp ⟨hjk', h'⟩ with h1 | h1
    · exact Or.inr h1
    · exact Or.inl h1

/-- **Two sorted four-sets with the same element set are equal.** -/
theorem sorted4_unique {i j k l i' j' k' l' : Fin n} (h1 : i < j) (h2 : j < k) (h3 : k < l) (h1' : i' < j')
    (h2' : j' < k') (h3' : k' < l')
    (hi : i' = i ∨ i' = j ∨ i' = k ∨ i' = l) (hj : j' = i ∨ j' = j ∨ j' = k ∨ j' = l)
    (hk : k' = i ∨ k' = j ∨ k' = k ∨ k' = l) (hl : l' = i ∨ l' = j ∨ l' = k ∨ l' = l) :
    i' = i ∧ j' = j ∧ k' = k ∧ l' = l := by
  rw [Fin.lt_def] at h1 h2 h3 h1' h2' h3'
  simp only [Fin.ext_iff] at hi hj hk hl ⊢
  omega

/-- **Two sorted four-sets whose `FourForm` positions coincide are equal.** -/
theorem fourForm_sorted_unique {i j k l i' j' k' l' a b c d : Fin n} (h1 : i < j) (h2 : j < k) (h3 : k < l)
    (h1' : i' < j') (h2' : j' < k') (h3' : k' < l') (h : FourForm i j k l a b c d) (h' : FourForm i' j' k' l' a b c d) :
    i' = i ∧ j' = j ∧ k' = k ∧ l' = l := by
  have hD : D4 i j k l := ⟨ne_of_lt h1, ne_of_lt (h1.trans h2), ne_of_lt (h1.trans (h2.trans h3)), ne_of_lt h2,
    ne_of_lt (h2.trans h3), ne_of_lt h3⟩
  have hD' : D4 i' j' k' l' := ⟨ne_of_lt h1', ne_of_lt (h1'.trans h2'), ne_of_lt (h1'.trans (h2'.trans h3')),
    ne_of_lt h2', ne_of_lt (h2'.trans h3'), ne_of_lt h3'⟩
  have habcd := fourForm_shape hD h
  -- `{i', j', k', l'} ⊆ {a, b, c, d}` and `{a, b, c, d} = {i, j, k, l}`
  have m' := (fourForm_iff_perm habcd i' j' k' l').mp ⟨hD', h'⟩
  have m := (fourForm_iff_perm habcd i j k l).mp ⟨hD, h⟩
  simp only [Finset.mem_insert, Finset.mem_singleton] at m m'
  obtain ⟨mi, mj, mk, ml, _⟩ := m
  obtain ⟨mi', mj', mk', ml', _⟩ := m'
  -- `a, b, c, d` are `i, j, k, l` in some order, so each of `i', j', k', l'` is one of `i, j, k, l`
  have hcover : ∀ x : Fin n, (x = a ∨ x = b ∨ x = c ∨ x = d) → (x = i ∨ x = j ∨ x = k ∨ x = l) := by
    obtain ⟨hab, hac, had, hbc, hbd, hcd⟩ := habcd
    obtain ⟨hij, hik, hil, hjk, hjl, hkl⟩ := hD
    intro x hx
    rcases mi with rfl | rfl | rfl | rfl <;> rcases mj with rfl | rfl | rfl | rfl <;>
      rcases mk with rfl | rfl | rfl | rfl <;> rcases ml with rfl | rfl | rfl | rfl <;>
      first
      | contradiction
      | (rcases hx with rfl | rfl | rfl | rfl <;> simp)
  exact sorted4_unique h1 h2 h3 h1' h2' h3' (hcover _ mi') (hcover _ mj') (hcover _ mk') (hcover _ ml')

theorem sum2_single (g : Fin n → Fin n → ℝ) (j0 k0 : Fin n) (h : ∀ j k, ¬ (j = j0 ∧ k = k0) → g j k = 0) :
    ∑ j, ∑ k, g j k = g j0 k0 := by
  rw [Finset.sum_eq_single j0 (fun j _ hj => Finset.sum_eq_zero fun k _ => h j k (fun e => hj e.1)) (by simp),
    Finset.sum_eq_single k0 (fun k _ hk => h j0 k (fun e => hk e.2)) (by simp)]

theorem sum4_single (g : Fin n → Fin n → Fin n → Fin n → ℝ) (i0 j0 k0 l0 : Fin n)
    (h : ∀ i j k l, ¬ (i = i0 ∧ j = j0 ∧ k = k0 ∧ l = l0) → g i j k l = 0) :
    ∑ i, ∑ j, ∑ k, ∑ l, g i j k l = g i0 j0 k0 l0 := by
  rw [Finset.sum_eq_single i0 (fun i _ hi => Finset.sum_eq_zero fun j _ => Finset.sum_eq_zero fun k _ =>
      Finset.sum_eq_zero fun l _ => h i j k l (fun e => hi e.1)) (by simp),
    Finset.sum_eq_single j0 (fun j _ hj => Finset.sum_eq_zero fun k _ =>
      Finset.sum_eq_zero fun l _ => h i0 j k l (fun e => hj e.2.1)) (by simp),
    Finset.sum_eq_single k0 (fun k _ hk => Finset.sum_eq_zero fun l _ => h i0 j0 k l (fun e => hk e.2.2.1)) (by simp),
    Finset.sum_eq_single l0 (fun l _ hl => h i0 j0 k0 l (fun e => hl e.2.2.2)) (by simp)]

/-- **L120's decomposition is direct.** A flip-fixed Weyl `D`, `{j,k}`-isotypic Weyl `P_{jk}` (`j < k`) and
`{i,j,k,l}`-isotypic Weyl `F_{ijkl}` (`i < j < k < l`) that sum to zero are all zero. -/
theorem weyl_direct (D : CurvLin (Fin n)) (hD : D ∈ weylModuleS (Fin n)) (hDf : ∀ m, act (flip m) D = D)
    (P : Fin n → Fin n → CurvLin (Fin n))
    (hP : ∀ j k, j < k → P j k ∈ weylModuleS (Fin n) ∧ ∀ m, act (flip m) (P j k) = (sgn m j * sgn m k) • P j k)
    (F : Fin n → Fin n → Fin n → Fin n → CurvLin (Fin n))
    (hF : ∀ i j k l, i < j → j < k → k < l → F i j k l ∈ weylModuleS (Fin n)
      ∧ ∀ m, act (flip m) (F i j k l) = (sgn m i * sgn m j * sgn m k * sgn m l) • F i j k l)
    (h0 : D + ∑ j, ∑ k, (if j < k then P j k else 0)
      + ∑ i, ∑ j, ∑ k, ∑ l, (if i < j ∧ j < k ∧ k < l then F i j k l else 0) = 0) :
    D = 0 ∧ (∀ j k, j < k → P j k = 0) ∧ (∀ i j k l, i < j → j < k → k < l → F i j k l = 0) := by
  -- the coordinate identity at every position
  have hc : ∀ a b c d, coord D a b c d + ∑ j, ∑ k, (if j < k then coord (P j k) a b c d else 0)
      + ∑ i, ∑ j, ∑ k, ∑ l, (if i < j ∧ j < k ∧ k < l then coord (F i j k l) a b c d else 0) = 0 := by
    intro a b c d
    have := congrArg (fun R : CurvLin (Fin n) => coord R a b c d) h0
    simp only [coord_add', coord_sum', coord_ite', coord_zero'] at this
    exact this
  -- each kind vanishes off its own positions
  have offD : ∀ a b c d, ¬ ((c = a ∧ d = b) ∨ (c = b ∧ d = a)) → coord D a b c d = 0 := fun a b c d h =>
    coord_reduce_flip D hDf a b c d (fun e => h (Or.inl e)) (fun e => h (Or.inr e))
  have offP : ∀ j k a b c d, j < k → coord (P j k) a b c d ≠ 0 → PairForm j k a b c d := fun j k a b c d hjk hne =>
    iso_coord_form _ (hP j k hjk).1 (ne_of_lt hjk) (hP j k hjk).2 hne
  have offF : ∀ i j k l a b c d, i < j → j < k → k < l → coord (F i j k l) a b c d ≠ 0 →
      FourForm i j k l a b c d := fun i j k l a b c d h1 h2 h3 hne =>
    four_coord_form _ (ne_of_lt h1) (ne_of_lt (h1.trans h2)) (ne_of_lt (h1.trans (h2.trans h3))) (ne_of_lt h2)
      (ne_of_lt (h2.trans h3)) (ne_of_lt h3) (hF i j k l h1 h2 h3).2 hne
  have D4_of : ∀ i j k l : Fin n, i < j → j < k → k < l → D4 i j k l := fun i j k l h1 h2 h3 =>
    ⟨ne_of_lt h1, ne_of_lt (h1.trans h2), ne_of_lt (h1.trans (h2.trans h3)), ne_of_lt h2, ne_of_lt (h2.trans h3),
      ne_of_lt h3⟩
  refine ⟨?_, ?_, ?_⟩
  · -- `D = 0`
    refine cd_ext D hD fun a b c d => ?_
    by_cases hdg : (c = a ∧ d = b) ∨ (c = b ∧ d = a)
    · have hPz : ∀ j k, (if j < k then coord (P j k) a b c d else 0) = 0 := fun j k => by
        split_ifs with hjk
        · by_contra hne; exact (pairForm_shape (ne_of_lt hjk) (offP j k a b c d hjk hne)).1 hdg
        · rfl
      have hFz : ∀ i j k l, (if i < j ∧ j < k ∧ k < l then coord (F i j k l) a b c d else 0) = 0 := fun i j k l => by
        split_ifs with h
        · by_contra hne
          obtain ⟨_, hac, _, hbc, _, _⟩ := fourForm_shape (D4_of i j k l h.1 h.2.1 h.2.2) (offF i j k l a b c d h.1 h.2.1 h.2.2 hne)
          rcases hdg with ⟨e, _⟩ | ⟨e, _⟩
          · exact hac e.symm
          · exact hbc e.symm
        · rfl
      have := hc a b c d
      simp only [hPz, hFz, Finset.sum_const_zero, add_zero] at this
      exact this
    · exact offD a b c d hdg
  · -- each `P_{jk} = 0`
    intro j0 k0 hjk0
    refine cd_ext _ (hP j0 k0 hjk0).1 fun a b c d => ?_
    by_cases hpf : PairForm j0 k0 a b c d
    · have hsh := pairForm_shape (ne_of_lt hjk0) hpf
      have hDz : coord D a b c d = 0 := offD a b c d hsh.1
      have hFz : ∀ i j k l, (if i < j ∧ j < k ∧ k < l then coord (F i j k l) a b c d else 0) = 0 := fun i j k l => by
        split_ifs with h
        · by_contra hne
          exact hsh.2 (fourForm_shape (D4_of i j k l h.1 h.2.1 h.2.2) (offF i j k l a b c d h.1 h.2.1 h.2.2 hne))
        · rfl
      have hsum : ∑ j, ∑ k, (if j < k then coord (P j k) a b c d else 0) = coord (P j0 k0) a b c d := by
        rw [sum2_single _ j0 k0 fun j k hjk => ?_, if_pos hjk0]
        split_ifs with hlt
        · by_contra hne
          rcases pairForm_unique (ne_of_lt hjk0) (ne_of_lt hlt) hpf (offP j k a b c d hlt hne) with e | e
          · exact hjk ⟨e.1, e.2⟩
          · rw [e.1, e.2] at hlt; exact absurd (hlt.trans hjk0) (lt_irrefl _)
        · rfl
      have := hc a b c d
      simp only [hFz, Finset.sum_const_zero, add_zero, hDz, zero_add, hsum] at this
      exact this
    · by_contra hne; exact hpf (offP j0 k0 a b c d hjk0 hne)
  · -- each `F_{ijkl} = 0`
    intro i0 j0 k0 l0 h1 h2 h3
    refine cd_ext _ (hF i0 j0 k0 l0 h1 h2 h3).1 fun a b c d => ?_
    by_cases hff : FourForm i0 j0 k0 l0 a b c d
    · have hd4 := fourForm_shape (D4_of i0 j0 k0 l0 h1 h2 h3) hff
      have hDz : coord D a b c d = 0 := offD a b c d (by
        obtain ⟨_, hac, _, hbc, _, _⟩ := hd4
        rintro (⟨e, _⟩ | ⟨e, _⟩)
        · exact hac e.symm
        · exact hbc e.symm)
      have hPz : ∀ j k, (if j < k then coord (P j k) a b c d else 0) = 0 := fun j k => by
        split_ifs with hjk
        · by_contra hne; exact (pairForm_shape (ne_of_lt hjk) (offP j k a b c d hjk hne)).2 hd4
        · rfl
      have hsum : ∑ i, ∑ j, ∑ k, ∑ l, (if i < j ∧ j < k ∧ k < l then coord (F i j k l) a b c d else 0)
          = coord (F i0 j0 k0 l0) a b c d := by
        rw [sum4_single _ i0 j0 k0 l0 fun i j k l hne' => ?_, if_pos ⟨h1, h2, h3⟩]
        split_ifs with h
        · by_contra hne
          have e := fourForm_sorted_unique h1 h2 h3 h.1 h.2.1 h.2.2 hff (offF i j k l a b c d h.1 h.2.1 h.2.2 hne)
          exact hne' e
        · rfl
      have := hc a b c d
      simp only [hPz, Finset.sum_const_zero, add_zero, hDz, zero_add, hsum] at this
      exact this
    · by_contra hne; exact hff (offF i0 j0 k0 l0 a b c d h1 h2 h3 hne)

end HamiltonsCubic.Results
