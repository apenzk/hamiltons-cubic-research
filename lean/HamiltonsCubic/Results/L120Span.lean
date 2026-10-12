import HamiltonsCubic.Results.L120DiagDim

set_option linter.style.longLine false

/-!
# L120's three summands span `𝒲ₙ`

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: *"`𝒲ₙ = 𝒟ₙ ⊕ ⨁ V_{ijkl} ⊕ ⨁ V_{jk}`"*.
[L120Pair.lean](L120Pair.lean), [L120Four.lean](L120Four.lean) and [L120Diag.lean](L120Diag.lean) identify each
summand. This file shows that every member of `𝒲ₙ` is the sum of its three parts, on `Fin n`: the parts read `R`'s own
coordinates and each carries `R` exactly on its own positions.

* **`coord_pairPart`**, **`coord_fourPart`**, **`coord_diagPart`**: the pair part `pairPart R j k`, the four-set part
  `fourPart R i j k l` and the diagonal part `diagPart R` of a Weyl operator `R` have `R`'s coordinate at a `PairForm`,
  `FourForm` or diagonal position respectively, and `0` elsewhere;
* **`pairForm_shape`**, **`fourForm_shape`**, **`pairForm_iff_one`**, **`count_two`**, **`fourForm_iff_perm`**,
  **`count_24`**: a position is diagonal, shares one index, or is four-distinct, and exactly one diagonal part, two
  ordered pairs, or twenty-four ordered four-sets carry it;
* **`weyl_span`**: every member of `weylModuleS` is `diagPart R + ½ ∑_{j ≠ k} pairPart R j k + (1/24) ∑_{distinct}
  fourPart R i j k l`, so the three summands span `𝒲ₙ`.

* **`pairPart_mem`**, **`fourPart_mem`**, **`diagPart_mem`**: each part lies in its own summand, the pair part
  `{j, k}`-isotypic, the four-set part `{i, j, k, l}`-isotypic, the diagonal part flip-fixed, all in `weylModuleS`.

The sum is direct, [L120Direct.lean](L120Direct.lean)'s `weyl_direct`: every member of a summand vanishes off its own positions
(`iso_coord_form`, `four_coord_form`, and the flip-fixed reduction `coord_reduce_flip`); those positions are disjoint
across the three kinds, between distinct pairs (`pairForm_iff_one`) and between distinct four-sets (`fourForm_iff_perm`);
and a Weyl operator whose coordinates all vanish is zero (`cd_ext`).
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.WeylRadical

variable {n : ℕ}

instance (j k a b c d : Fin n) : Decidable (PairForm j k a b c d) := by unfold PairForm; infer_instance

instance (i j k l a b c d : Fin n) : Decidable (FourForm i j k l a b c d) := by
  unfold FourForm PP; infer_instance

theorem coord_add' {ι : Type*} [Fintype ι] [DecidableEq ι] (R S : CurvLin ι) (a b c d : ι) :
    coord (R + S) a b c d = coord R a b c d + coord S a b c d := by
  have := coord_sub (R + S) S a b c d
  rw [add_sub_cancel_right] at this; linarith

theorem coord_zero' {ι : Type*} [Fintype ι] [DecidableEq ι] (a b c d : ι) : coord (0 : CurvLin ι) a b c d = 0 := by
  have := coord_smul 0 (0 : CurvLin ι) a b c d
  rwa [zero_smul, zero_mul] at this

theorem coord_sum' {ι κ : Type*} [Fintype ι] [DecidableEq ι] (s : Finset κ) (f : κ → CurvLin ι) (a b c d : ι) :
    coord (∑ x ∈ s, f x) a b c d = ∑ x ∈ s, coord (f x) a b c d := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [coord_zero']
  | insert x s hx ih => rw [Finset.sum_insert hx, Finset.sum_insert hx, coord_add', ih]

theorem coord_ite' {ι : Type*} [Fintype ι] [DecidableEq ι] (p : Prop) [Decidable p] (R : CurvLin ι) (a b c d : ι) :
    coord (if p then R else 0) a b c d = if p then coord R a b c d else 0 := by
  split_ifs
  · rfl
  · exact coord_zero' a b c d

/-- The Ricci relation behind the pair part: `∑_{y ∉ {j,k}} R_{jyky} = 0`. -/
theorem pair_ricci (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) {j k : Fin n} (hjk : j ≠ k) :
    ∑ y ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), coord R j y k y = 0 := by
  have h := cd_ric R hR j k
  rw [← Finset.sum_filter_add_sum_filter_not univ (fun i => j ≠ i ∧ k ≠ i)] at h
  have e : (univ : Finset (Fin n)).filter (fun i => ¬ (j ≠ i ∧ k ≠ i)) = {j, k} := by
    ext i; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_insert, Finset.mem_singleton]
    constructor
    · intro hi; by_contra hc; push Not at hc; exact hi ⟨Ne.symm hc.1, Ne.symm hc.2⟩
    · rintro (rfl | rfl) ⟨h1, h2⟩ <;> simp_all
  rw [e, Finset.sum_pair hjk, cd_self12, cd_self34, add_zero, add_zero] at h
  exact h

/-- The pair part of `R` at `{j, k}`: the pair-span operator with `c_y = R_{jyky}`. -/
noncomputable def pairPart (R : CurvLin (Fin n)) (j k : Fin n) : CurvLin (Fin n) :=
  pairMap j k (fun y => coord R j y k y)

/-- **The pair part carries `R` exactly on the `PairForm` positions.** -/
theorem coord_pairPart (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) {j k : Fin n} (hjk : j ≠ k)
    (a b c d : Fin n) :
    coord (pairPart R j k) a b c d = if PairForm j k a b c d then coord R a b c d else 0 := by
  have hsum := pair_ricci R hR hjk
  have hS : pairPart R j k ∈ weylModuleS (Fin n) := pairS_mem hjk _ hsum
  split_ifs with h
  · have hE : R - pairPart R j k ∈ weylModuleS (Fin n) := sub_mem hR hS
    have h0 : ∀ y, coord (R - pairPart R j k) j y k y = 0 := fun y => by
      by_cases hyj : y = j
      · rw [hyj]; exact cd_self12 _ j k j
      by_cases hyk : y = k
      · rw [hyk]; exact cd_self34 _ j k k
      rw [coord_sub]
      change coord R j y k y - coord (pairLin j k _ ∘ₗ _) j y k y = 0
      rw [coord_pairS_diag hjk _ hyj hyk, sub_self]
    have := pairForm_coord_zero _ hE h h0
    rw [coord_sub] at this; linarith
  · by_contra hne
    exact h (iso_coord_form _ hS hjk (pairS_iso hjk _ hsum) hne)

/-- The Bianchi relation behind the four-set part. -/
theorem four_bianchi (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) (i j k l : Fin n) :
    coord R i j k l + -coord R i k j l + coord R i l j k = 0 := by
  have h := cd_bianchi R hR i j k l
  rw [cd_sw34 R i k l j] at h
  linarith

/-- The four-set part of `R` at `(i, j, k, l)`: the four-set span operator with `x = R_{ijkl}`, `y = −R_{ikjl}`,
`z = R_{iljk}`. -/
noncomputable def fourPart (R : CurvLin (Fin n)) (i j k l : Fin n) : CurvLin (Fin n) :=
  fourS i j k l (coord R i j k l) (-coord R i k j l) (coord R i l j k)

/-- **The four-set part carries `R` exactly on the `FourForm` positions**, at distinct indices. -/
theorem coord_fourPart (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) {i j k l : Fin n} (hij : i ≠ j)
    (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) (a b c d : Fin n) :
    coord (fourPart R i j k l) a b c d = if FourForm i j k l a b c d then coord R a b c d else 0 := by
  have hs := four_bianchi R hR i j k l
  have hS : fourPart R i j k l ∈ weylModuleS (Fin n) := fourS_mem hij hik hil hjk hjl hkl hs
  split_ifs with h
  · have hE : R - fourPart R i j k l ∈ weylModuleS (Fin n) := sub_mem hR hS
    obtain ⟨cA, cB, cC⟩ := coord_fourS_pairings hij hik hil hjk hjl hkl (coord R i j k l) (-coord R i k j l)
      (coord R i l j k)
    have hA : coord (R - fourPart R i j k l) i j k l = 0 := by rw [coord_sub]; unfold fourPart; rw [cA, sub_self]
    have hB : coord (R - fourPart R i j k l) i k j l = 0 := by
      rw [coord_sub]; unfold fourPart; rw [cB, neg_neg, sub_self]
    have hC : coord (R - fourPart R i j k l) i l j k = 0 := by rw [coord_sub]; unfold fourPart; rw [cC, sub_self]
    have := fourForm_coord_zero _ hE hA hB hC h
    rw [coord_sub] at this; linarith
  · by_contra hne
    exact h (four_coord_form _ hij hik hil hjk hjl hkl (fourS_iso hij hik hil hjk hjl hkl hs) hne)

/-- The diagonal part of `R`: the diagonal operator of its read-off weight. -/
noncomputable def diagPart (R : CurvLin (Fin n)) : CurvLin (Fin n) := diagS (diagWeight R)

/-- **The diagonal part carries `R` exactly on the positions `{a, b} = {c, d}`.** -/
theorem coord_diagPart (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) (a b c d : Fin n) :
    coord (diagPart R) a b c d = if (c = a ∧ d = b) ∨ (c = b ∧ d = a) then coord R a b c d else 0 := by
  have hw := diagWeight_isWeight hR
  unfold diagPart
  rw [coord_diagS hw.symm, inner2_phi_phi]
  simp only [diagWeight, Matrix.of_apply]
  by_cases hab : a = b
  · subst hab
    rw [cd_self12, cd_self12]; simp
  by_cases h1 : c = a ∧ d = b
  · obtain ⟨rfl, rfl⟩ := h1
    rw [if_pos (Or.inl ⟨rfl, rfl⟩), if_pos ⟨rfl, rfl⟩, if_neg (fun h => hab h.1)]; ring
  · by_cases h2 : c = b ∧ d = a
    · obtain ⟨rfl, rfl⟩ := h2
      rw [if_pos (Or.inr ⟨rfl, rfl⟩), if_neg (fun h => hab h.1), if_pos ⟨rfl, rfl⟩, cd_sw34]; ring
    · rw [if_neg (not_or.mpr ⟨h1, h2⟩), if_neg (fun h => h1 ⟨h.1.symm, h.2.symm⟩),
        if_neg (fun h => h2 ⟨h.2.symm, h.1.symm⟩)]; ring

/-- Four distinct indices. -/
def D4 (i j k l : Fin n) : Prop := i ≠ j ∧ i ≠ k ∧ i ≠ l ∧ j ≠ k ∧ j ≠ l ∧ k ≠ l

instance (i j k l : Fin n) : Decidable (D4 i j k l) := by unfold D4; infer_instance

/-- A `PairForm` position shares exactly one index between its two pairs: it is neither diagonal nor four-distinct. -/
theorem pairForm_shape {j k a b c d : Fin n} (hjk : j ≠ k) (h : PairForm j k a b c d) :
    ¬ ((c = a ∧ d = b) ∨ (c = b ∧ d = a)) ∧ ¬ D4 a b c d := by
  obtain ⟨y, hyj, hyk, h⟩ := h
  rcases h with ⟨hab, hcd⟩ | ⟨hab, hcd⟩ <;>
    rcases hab with ⟨ha, hb⟩ | ⟨ha, hb⟩ <;> rcases hcd with ⟨hc, hd⟩ | ⟨hc, hd⟩ <;> subst ha hb hc hd <;>
    refine ⟨?_, ?_⟩ <;> intro h <;> (try unfold D4 at h) <;> simp_all

/-- A `FourForm` position at distinct indices is four-distinct. -/
theorem fourForm_shape {i j k l a b c d : Fin n} (hD : D4 i j k l) (h : FourForm i j k l a b c d) : D4 a b c d := by
  unfold D4 at hD ⊢
  obtain ⟨hij, hik, hil, hjk, hjl, hkl⟩ := hD
  unfold FourForm PP at h
  rcases h with ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ | ⟨hab, hcd⟩ <;>
    rcases hab with ⟨ha, hb⟩ | ⟨ha, hb⟩ <;> rcases hcd with ⟨hc, hd⟩ | ⟨hc, hd⟩ <;> subst ha hb hc hd <;>
    refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> intro h <;> simp_all

/-- **The pair count at a one-shared position**: with `{a, b} = {u, y}` and `{c, d} = {v, y}`, `u, v, y` distinct, the
ordered pairs `(j, k)`, `j ≠ k`, with `PairForm j k a b c d` are exactly `(u, v)` and `(v, u)`. -/
theorem pairForm_iff_one {u v y a b c d : Fin n} (huv : u ≠ v) (huy : u ≠ y) (hvy : v ≠ y)
    (hab : (a = u ∧ b = y) ∨ (a = y ∧ b = u)) (hcd : (c = v ∧ d = y) ∨ (c = y ∧ d = v)) (j k : Fin n) :
    (j ≠ k ∧ PairForm j k a b c d) ↔ ((j = u ∧ k = v) ∨ (j = v ∧ k = u)) := by
  constructor
  · rintro ⟨hjk, y', hy'j, hy'k, h⟩
    rcases hab with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> rcases hcd with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;>
      rcases h with ⟨h1, h2⟩ | ⟨h1, h2⟩ <;>
      rcases h1 with ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> rcases h2 with ⟨e3, e4⟩ | ⟨e3, e4⟩ <;> subst_vars <;> simp_all
  · rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩)
    · refine ⟨huv, y, Ne.symm huy, Ne.symm hvy, Or.inl ⟨?_, ?_⟩⟩
      · rcases hab with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
        · exact Or.inl ⟨rfl, rfl⟩
        · exact Or.inr ⟨rfl, rfl⟩
      · rcases hcd with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
        · exact Or.inl ⟨rfl, rfl⟩
        · exact Or.inr ⟨rfl, rfl⟩
    · refine ⟨Ne.symm huv, y, Ne.symm hvy, Ne.symm huy, Or.inr ⟨?_, ?_⟩⟩
      · rcases hab with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
        · exact Or.inl ⟨rfl, rfl⟩
        · exact Or.inr ⟨rfl, rfl⟩
      · rcases hcd with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
        · exact Or.inl ⟨rfl, rfl⟩
        · exact Or.inr ⟨rfl, rfl⟩

/-- Two ordered pairs, counted. -/
theorem count_two {u v : Fin n} (huv : u ≠ v) :
    ∑ j : Fin n, ∑ k : Fin n, (if (j = u ∧ k = v) ∨ (j = v ∧ k = u) then (1 : ℝ) else 0) = 2 := by
  have e : ∀ j k : Fin n, (if (j = u ∧ k = v) ∨ (j = v ∧ k = u) then (1 : ℝ) else 0)
      = (if j = u then (if k = v then 1 else 0) else 0) + (if j = v then (if k = u then 1 else 0) else 0) := by
    intro j k
    by_cases h1 : j = u <;> by_cases h2 : k = v <;> by_cases h3 : j = v <;> by_cases h4 : k = u <;>
      simp_all
  simp only [e, Finset.sum_add_distrib]
  have one : ∀ p q : Fin n, ∑ j : Fin n, ∑ k : Fin n, (if j = p then (if k = q then (1 : ℝ) else 0) else 0) = 1 := by
    intro p q
    rw [Finset.sum_eq_single p (fun j _ hj => by simp [hj]) (by simp)]
    simp
  rw [one, one]; norm_num

/-- **The four-set count at a four-distinct position**: the distinct ordered tuples `(i, j, k, l)` with
`FourForm i j k l a b c d` are exactly the orderings of `{a, b, c, d}`. -/
theorem fourForm_iff_perm {a b c d : Fin n} (hD : D4 a b c d) (i j k l : Fin n) :
    (D4 i j k l ∧ FourForm i j k l a b c d)
      ↔ (i ∈ ({a, b, c, d} : Finset (Fin n)) ∧ j ∈ ({a, b, c, d} : Finset (Fin n))
          ∧ k ∈ ({a, b, c, d} : Finset (Fin n)) ∧ l ∈ ({a, b, c, d} : Finset (Fin n)) ∧ D4 i j k l) := by
  unfold D4 at hD
  obtain ⟨hab, hac, had, hbc, hbd, hcd⟩ := hD
  simp only [Finset.mem_insert, Finset.mem_singleton]
  constructor
  · rintro ⟨hD4, h⟩
    refine ⟨?_, ?_, ?_, ?_, hD4⟩ <;> unfold FourForm PP at h <;>
      rcases h with ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ <;>
      rcases h1 with ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> rcases h2 with ⟨e3, e4⟩ | ⟨e3, e4⟩ <;> subst e1 e2 e3 e4 <;> simp
  · rintro ⟨hi, hj, hk, hl, hD4⟩
    refine ⟨hD4, ?_⟩
    unfold D4 at hD4
    obtain ⟨hij, hik, hil, hjk, hjl, hkl⟩ := hD4
    unfold FourForm PP
    rcases hi with rfl | rfl | rfl | rfl <;> rcases hj with rfl | rfl | rfl | rfl <;>
      rcases hk with rfl | rfl | rfl | rfl <;> rcases hl with rfl | rfl | rfl | rfl <;>
      first
      | contradiction
      | (exfalso; exact hij rfl) | (exfalso; exact hik rfl) | (exfalso; exact hil rfl)
      | (exfalso; exact hjk rfl) | (exfalso; exact hjl rfl) | (exfalso; exact hkl rfl)
      | simp only [true_and, and_true, true_or, or_true, and_self]

/-- The orderings of four distinct indices, counted. -/
theorem count_24 {a b c d : Fin n} (hD : D4 a b c d) :
    ∑ i : Fin n, ∑ j : Fin n, ∑ k : Fin n, ∑ l : Fin n,
      (if D4 i j k l ∧ FourForm i j k l a b c d then (1 : ℝ) else 0) = 24 := by
  have e : ∀ i j k l : Fin n, (if D4 i j k l ∧ FourForm i j k l a b c d then (1 : ℝ) else 0)
      = if i ∈ ({a, b, c, d} : Finset (Fin n)) then (if j ∈ ({a, b, c, d} : Finset (Fin n)) then
          (if k ∈ ({a, b, c, d} : Finset (Fin n)) then (if l ∈ ({a, b, c, d} : Finset (Fin n)) then
            (if D4 i j k l then 1 else 0) else 0) else 0) else 0) else 0 := by
    intro i j k l
    rw [if_congr (fourForm_iff_perm hD i j k l) rfl rfl]
    by_cases h1 : i ∈ ({a, b, c, d} : Finset (Fin n)) <;> by_cases h2 : j ∈ ({a, b, c, d} : Finset (Fin n)) <;>
      by_cases h3 : k ∈ ({a, b, c, d} : Finset (Fin n)) <;> by_cases h4 : l ∈ ({a, b, c, d} : Finset (Fin n)) <;>
      simp only [h1, h2, h3, h4, true_and, false_and, if_true, if_false]
  simp only [e]
  simp only [Finset.sum_ite_irrel, Finset.sum_const_zero]
  simp only [Finset.sum_ite_mem, Finset.univ_inter]
  unfold D4 at hD
  obtain ⟨hab, hac, had, hbc, hbd, hcd⟩ := hD
  have ha' : a ∉ ({b, c, d} : Finset (Fin n)) := by simp [hab, hac, had]
  have hb' : b ∉ ({c, d} : Finset (Fin n)) := by simp [hbc, hbd]
  simp only [Finset.sum_insert ha', Finset.sum_insert hb', Finset.sum_pair hcd]
  simp only [D4, ne_eq, hab, hac, had, hbc, hbd, hcd, Ne.symm hab, Ne.symm hac, Ne.symm had, Ne.symm hbc,
    Ne.symm hbd, Ne.symm hcd, not_true_eq_false, not_false_eq_true, and_true, true_and, and_false, false_and,
    if_true, if_false]
  norm_num

/-- **L120's decomposition spans `𝒲ₙ`.** Every member of `weylModuleS` is the sum of its diagonal part, its pair parts
(each unordered pair counted twice, hence `½`) and its four-set parts (each four-set counted `24` times). -/
theorem weyl_span (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) :
    R = diagPart R + (1 / 2 : ℝ) • ∑ j : Fin n, ∑ k : Fin n, (if j = k then 0 else pairPart R j k)
      + (1 / 24 : ℝ) • ∑ i : Fin n, ∑ j : Fin n, ∑ k : Fin n, ∑ l : Fin n,
          (if D4 i j k l then fourPart R i j k l else 0) := by
  have memP : ∀ j k : Fin n, (if j = k then 0 else pairPart R j k) ∈ weylModuleS (Fin n) := by
    intro j k; split_ifs with h
    · exact zero_mem _
    · exact pairS_mem h _ (pair_ricci R hR h)
  have memF : ∀ i j k l : Fin n, (if D4 i j k l then fourPart R i j k l else 0) ∈ weylModuleS (Fin n) := by
    intro i j k l; split_ifs with h
    · obtain ⟨hij, hik, hil, hjk, hjl, hkl⟩ := h
      exact fourS_mem hij hik hil hjk hjl hkl (four_bianchi R hR i j k l)
    · exact zero_mem _
  have hRHS : diagPart R + (1 / 2 : ℝ) • ∑ j : Fin n, ∑ k : Fin n, (if j = k then 0 else pairPart R j k)
      + (1 / 24 : ℝ) • ∑ i : Fin n, ∑ j : Fin n, ∑ k : Fin n, ∑ l : Fin n,
          (if D4 i j k l then fourPart R i j k l else 0) ∈ weylModuleS (Fin n) := add_mem (add_mem (diagS_mem (diagWeight_isWeight hR))
    (Submodule.smul_mem _ _ (Submodule.sum_mem _ fun j _ => Submodule.sum_mem _ fun k _ => memP j k)))
    (Submodule.smul_mem _ _ (Submodule.sum_mem _ fun i _ => Submodule.sum_mem _ fun j _ =>
      Submodule.sum_mem _ fun k _ => Submodule.sum_mem _ fun l _ => memF i j k l))
  refine eq_of_coord _ _ hR hRHS fun a b c d => ?_
  have eP : ∀ j k : Fin n, coord (if j = k then 0 else pairPart R j k) a b c d
      = if j ≠ k ∧ PairForm j k a b c d then coord R a b c d else 0 := by
    intro j k
    by_cases h : j = k
    · rw [if_pos h, coord_zero', if_neg (fun h' => h'.1 h)]
    · rw [if_neg h, coord_pairPart R hR h]
      by_cases hp : PairForm j k a b c d
      · rw [if_pos hp, if_pos ⟨h, hp⟩]
      · rw [if_neg hp, if_neg (fun h' => hp h'.2)]
  have eF : ∀ i j k l : Fin n, coord (if D4 i j k l then fourPart R i j k l else 0) a b c d
      = if D4 i j k l ∧ FourForm i j k l a b c d then coord R a b c d else 0 := by
    intro i j k l
    by_cases h : D4 i j k l
    · obtain ⟨hij, hik, hil, hjk, hjl, hkl⟩ := h
      rw [if_pos ⟨hij, hik, hil, hjk, hjl, hkl⟩, coord_fourPart R hR hij hik hil hjk hjl hkl]
      by_cases hp : FourForm i j k l a b c d
      · rw [if_pos hp, if_pos ⟨⟨hij, hik, hil, hjk, hjl, hkl⟩, hp⟩]
      · rw [if_neg hp, if_neg (fun h' => hp h'.2)]
    · rw [if_neg h, coord_zero', if_neg (fun h' => h h'.1)]
  rw [coord_add', coord_add', coord_smul, coord_smul, coord_diagPart R hR]
  simp only [coord_sum', eP, eF]
  set X := coord R a b c d with hXdef
  have t : ∀ (p : Prop) [Decidable p], (if p then X else 0) = X * (if p then (1 : ℝ) else 0) := by
    intro p _; split_ifs <;> ring
  simp only [t, ← Finset.mul_sum]
  by_cases hX : X = 0
  · rw [hX]; ring
  have hab : a ≠ b := fun h => hX (by rw [hXdef, h]; exact cd_self12 R b c d)
  have hcd : c ≠ d := fun h => hX (by rw [hXdef, h]; exact cd_self34 R a b d)
  -- the pair count and the four-set count vanish off their own positions
  have zeroP : (¬ ∃ j k : Fin n, j ≠ k ∧ PairForm j k a b c d) →
      ∑ j : Fin n, ∑ k : Fin n, (if j ≠ k ∧ PairForm j k a b c d then (1 : ℝ) else 0) = 0 := fun h =>
    Finset.sum_eq_zero fun j _ => Finset.sum_eq_zero fun k _ => if_neg fun h' => h ⟨j, k, h'⟩
  have zeroF : ¬ D4 a b c d →
      ∑ i : Fin n, ∑ j : Fin n, ∑ k : Fin n, ∑ l : Fin n,
        (if D4 i j k l ∧ FourForm i j k l a b c d then (1 : ℝ) else 0) = 0 := fun h =>
    Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => Finset.sum_eq_zero fun k _ =>
      Finset.sum_eq_zero fun l _ => if_neg fun h' => h (fourForm_shape h'.1 h'.2)
  by_cases hD : (c = a ∧ d = b) ∨ (c = b ∧ d = a)
  · have hD4 : ¬ D4 a b c d := by
      rintro ⟨_, hac, had, hbc, hbd, _⟩
      rcases hD with ⟨h1, _⟩ | ⟨h1, _⟩
      · exact hac h1.symm
      · exact hbc h1.symm
    rw [if_pos hD, zeroP (fun ⟨j, k, hjk, hp⟩ => (pairForm_shape hjk hp).1 hD), zeroF hD4]; ring
  by_cases h4 : D4 a b c d
  · rw [if_neg hD, zeroP (fun ⟨j, k, hjk, hp⟩ => (pairForm_shape hjk hp).2 h4), count_24 h4]; ring
  -- one shared index
  rw [if_neg hD, zeroF h4]
  have hone : ∃ u v y : Fin n, u ≠ v ∧ u ≠ y ∧ v ≠ y ∧ ((a = u ∧ b = y) ∨ (a = y ∧ b = u))
      ∧ ((c = v ∧ d = y) ∨ (c = y ∧ d = v)) := by
    by_cases hac : a = c
    · refine ⟨b, d, a, fun h => hD (Or.inl ⟨hac.symm, h.symm⟩), Ne.symm hab, fun h => hcd (hac ▸ h.symm),
        Or.inr ⟨rfl, rfl⟩, Or.inr ⟨hac.symm, rfl⟩⟩
    by_cases had : a = d
    · refine ⟨b, c, a, fun h => hD (Or.inr ⟨h.symm, had.symm⟩), Ne.symm hab, fun h => hcd (had ▸ h),
        Or.inr ⟨rfl, rfl⟩, Or.inl ⟨rfl, had.symm⟩⟩
    by_cases hbc : b = c
    · refine ⟨a, d, b, fun h => hD (Or.inr ⟨hbc.symm, h.symm⟩), hab, fun h => hcd (hbc ▸ h.symm),
        Or.inl ⟨rfl, rfl⟩, Or.inr ⟨hbc.symm, rfl⟩⟩
    by_cases hbd : b = d
    · refine ⟨a, c, b, fun h => hD (Or.inl ⟨h.symm, hbd.symm⟩), hab, fun h => hcd (hbd ▸ h),
        Or.inl ⟨rfl, rfl⟩, Or.inl ⟨rfl, hbd.symm⟩⟩
    exact absurd ⟨hab, hac, had, hbc, hbd, hcd⟩ h4
  obtain ⟨u, v, y, huv, huy, hvy, hab', hcd'⟩ := hone
  have eq2 : ∑ j : Fin n, ∑ k : Fin n, (if j ≠ k ∧ PairForm j k a b c d then (1 : ℝ) else 0) = 2 := by
    rw [← count_two huv]
    exact Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
      if_congr (pairForm_iff_one huv huy hvy hab' hcd' j k) rfl rfl
  rw [eq2]; ring

/-- **The pair part lies in the pair summand**: a member of `weylModuleS`, `{j, k}`-isotypic. -/
theorem pairPart_mem (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) {j k : Fin n} (hjk : j ≠ k) :
    pairPart R j k ∈ weylModuleS (Fin n)
      ∧ ∀ m, act (flip m) (pairPart R j k) = (sgn m j * sgn m k) • pairPart R j k :=
  ⟨pairS_mem hjk _ (pair_ricci R hR hjk), pairS_iso hjk _ (pair_ricci R hR hjk)⟩

/-- **The four-set part lies in the four-set summand**: a member of `weylModuleS`, `{i, j, k, l}`-isotypic. -/
theorem fourPart_mem (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) {i j k l : Fin n} (hij : i ≠ j)
    (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l) :
    fourPart R i j k l ∈ weylModuleS (Fin n)
      ∧ ∀ m, act (flip m) (fourPart R i j k l) = (sgn m i * sgn m j * sgn m k * sgn m l) • fourPart R i j k l :=
  ⟨fourS_mem hij hik hil hjk hjl hkl (four_bianchi R hR i j k l),
    fourS_iso hij hik hil hjk hjl hkl (four_bianchi R hR i j k l)⟩

/-- **The diagonal part lies in `𝒟ₙ`**: a member of `weylModuleS`, fixed by every flip. -/
theorem diagPart_mem (R : CurvLin (Fin n)) (hR : R ∈ weylModuleS (Fin n)) :
    diagPart R ∈ weylModuleS (Fin n) ∧ ∀ m, act (flip m) (diagPart R) = diagPart R :=
  ⟨diagS_mem (diagWeight_isWeight hR), diagS_flip (diagWeight_isWeight hR)⟩

end HamiltonsCubic.Results
