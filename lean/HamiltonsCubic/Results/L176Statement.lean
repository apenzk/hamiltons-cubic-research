import Mathlib

/-!
# L176, stated and proved as a matrix theorem

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L176 says a nonzero
coordinate-diagonal Weyl tensor has `Λ²`-rank at least four. **Its content needs no curvature
tensor**: the coordinate-diagonal locus is exactly the hollow symmetric matrices with vanishing
row sums, and the `Λ²`-rank is the number of nonzero entries above the diagonal. So the lemma is
a statement about matrices, and this file states it as one.

**The lemma itself is proved here, with no `sorry` and at general `n`.** `four_le_card_edges` is
L176's conclusion, and every step it rests on is a theorem in this file: the locus is a structure
rather than a description in prose; no vertex of the support graph has degree one, because the row
sum at a degree-one vertex collapses to its single entry; a support of one, two or three edges is
impossible, the last of these because three edges force a triangle whose three row sums make all
three entries vanish.

*This is the record's first numbered lemma proved in Lean rather than merely stated there.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L176

open Finset

variable {n : ℕ}

/-- The coordinate-diagonal locus: hollow, symmetric, with vanishing row sums. -/
structure IsSectional (K : Matrix (Fin n) (Fin n) ℝ) : Prop where
  symm : ∀ a b, K a b = K b a
  hollow : ∀ a, K a a = 0
  rowsum : ∀ a, ∑ b, K a b = 0

/-- The neighbours of `a`: the indices carrying a nonzero entry in row `a`. -/
noncomputable def nbr (K : Matrix (Fin n) (Fin n) ℝ) (a : Fin n) : Finset (Fin n) :=
  univ.filter (fun b => K a b ≠ 0)

/-- The support graph's edges, as unordered pairs. -/
noncomputable def edges (K : Matrix (Fin n) (Fin n) ℝ) : Finset (Fin n × Fin n) :=
  univ.filter (fun p => p.1 < p.2 ∧ K p.1 p.2 ≠ 0)

/-- **The degree step, which is what L176's argument turns on: no vertex has degree one.**
If `a`'s only neighbour is `b`, the row sum collapses to `K a b`, which vanishing row sums force
to zero, contradicting `b` being a neighbour. -/
theorem card_nbr_ne_one (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) (a : Fin n) :
    (nbr K a).card ≠ 1 := by
  intro h
  obtain ⟨b, hb⟩ := card_eq_one.mp h
  have hmem : b ∈ nbr K a := by rw [hb]; exact mem_singleton_self b
  have hne : K a b ≠ 0 := by
    simpa [nbr, mem_filter] using hmem
  have hzero : ∀ c, c ≠ b → K a c = 0 := by
    intro c hc
    by_contra hcz
    have : c ∈ nbr K a := by simp [nbr, mem_filter, hcz]
    rw [hb, mem_singleton] at this
    exact hc this
  have : ∑ c, K a c = K a b := by
    rw [Finset.sum_eq_single b]
    · intro c _ hc; exact hzero c hc
    · intro hb'; exact absurd (mem_univ b) hb'
  exact hne (this ▸ hK.rowsum a)

/-- **Every degree is zero or at least two**, which is the form the edge count uses. -/
theorem card_nbr_zero_or_two_le (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) (a : Fin n) :
    (nbr K a).card = 0 ∨ 2 ≤ (nbr K a).card := by
  have h1 := card_nbr_ne_one K hK a
  omega

/-- **A vertex with a nonzero entry has at least two neighbours**, the contrapositive form. -/
theorem two_le_card_nbr (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) {a b : Fin n}
    (hab : K a b ≠ 0) : 2 ≤ (nbr K a).card := by
  rcases card_nbr_zero_or_two_le K hK a with h | h
  · exfalso
    have : b ∈ nbr K a := by simp [nbr, mem_filter, hab]
    rw [card_eq_zero] at h
    simp [h] at this
  · exact h

/-- A nonzero entry off the diagonal gives an edge, in whichever order the indices fall. -/
theorem mem_edges_of_ne {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) {a c : Fin n}
    (h : K a c ≠ 0) : (a, c) ∈ edges K ∨ (c, a) ∈ edges K := by
  have hac : a ≠ c := by
    rintro rfl; exact h (hK.hollow a)
  rcases lt_or_gt_of_ne hac with hlt | hgt
  · exact Or.inl (by simp [edges, mem_filter, hlt, h])
  · exact Or.inr (by
      have : K c a ≠ 0 := by rw [← hK.symm a c]; exact h
      simp [edges, mem_filter, hgt, this])

/-- **A single edge is impossible.** Its lower endpoint would then have exactly one neighbour,
which `card_nbr_ne_one` forbids. -/
theorem card_edges_ne_one (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) :
    (edges K).card ≠ 1 := by
  intro h
  obtain ⟨p, hp⟩ := card_eq_one.mp h
  have hpm : p ∈ edges K := by rw [hp]; exact mem_singleton_self p
  have hpm' : p.1 < p.2 ∧ K p.1 p.2 ≠ 0 := by simpa [edges, mem_filter] using hpm
  have hlt : p.1 < p.2 := hpm'.1
  have hne : K p.1 p.2 ≠ 0 := hpm'.2
  have : nbr K p.1 = {p.2} := by
    apply Finset.eq_singleton_iff_unique_mem.mpr
    refine ⟨by simp [nbr, mem_filter, hne], ?_⟩
    intro c hc
    have hcne : K p.1 c ≠ 0 := by simpa [nbr, mem_filter] using hc
    rcases mem_edges_of_ne hK hcne with hin | hin
    · rw [hp, mem_singleton] at hin; exact congrArg Prod.snd hin
    · rw [hp, mem_singleton] at hin
      have h1 : c = p.1 := congrArg Prod.fst hin
      have h2 : p.1 = p.2 := congrArg Prod.snd hin
      exact absurd h2 (ne_of_lt hlt)
  exact card_nbr_ne_one K hK p.1 (by rw [this]; simp)

/-- The edge carrying an unordered pair, written with the smaller index first. -/
def edgeOf (a c : Fin n) : Fin n × Fin n := if a < c then (a, c) else (c, a)

/-- **A neighbour of `a` gives an edge**, whichever way the indices fall. -/
theorem edgeOf_mem {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) {a c : Fin n}
    (h : K a c ≠ 0) : edgeOf a c ∈ edges K := by
  have hac : a ≠ c := by rintro rfl; exact h (hK.hollow a)
  unfold edgeOf
  rcases lt_or_gt_of_ne hac with hlt | hgt
  · simp only [if_pos hlt, edges, mem_filter, mem_univ, true_and]
    exact ⟨hlt, h⟩
  · simp only [if_neg (not_lt.mpr hgt.le), edges, mem_filter, mem_univ, true_and]
    refine ⟨hgt, ?_⟩
    rw [← hK.symm a c]; exact h

/-- **And distinct neighbours give distinct edges**, so `a`'s neighbours inject into the edges. -/
theorem edgeOf_inj {a c d : Fin n} (hc : c ≠ a) (hd : d ≠ a) (h : edgeOf a c = edgeOf a d) :
    c = d := by
  unfold edgeOf at h
  by_cases h1 : a < c <;> by_cases h2 : a < d <;> simp_all [Prod.ext_iff]

/-- **An empty support means the matrix is zero.** Hollowness kills the diagonal and symmetry
carries the rest, so `K ≠ 0` gives at least one edge. -/
theorem card_edges_ne_zero (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) (hne : K ≠ 0) :
    (edges K).card ≠ 0 := by
  intro h
  apply hne
  ext a c
  rcases lt_trichotomy a c with hlt | heq | hgt
  · by_contra hz
    have : (a, c) ∈ edges K := by
      simp only [edges, mem_filter, mem_univ, true_and]
      exact ⟨hlt, hz⟩
    rw [card_eq_zero.mp h] at this; simp at this
  · subst heq; simpa using hK.hollow a
  · by_contra hz
    have hz' : K c a ≠ 0 := by rw [hK.symm c a]; exact hz
    have : (c, a) ∈ edges K := by
      simp only [edges, mem_filter, mem_univ, true_and]
      exact ⟨hgt, hz'⟩
    rw [card_eq_zero.mp h] at this; simp at this

/-- **At a two-edge support, `a`'s neighbours map ONTO the edges.** They inject into them, and at
two of each the image exhausts them. -/
theorem edges_eq_image {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) {a : Fin n}
    (ha : 2 ≤ (nbr K a).card) (h2 : (edges K).card = 2) :
    edges K = (nbr K a).image (edgeOf a) := by
  have hsub : (nbr K a).image (edgeOf a) ⊆ edges K := by
    intro e he
    obtain ⟨c, hc, rfl⟩ := mem_image.mp he
    exact edgeOf_mem hK (by simpa [nbr, mem_filter] using hc)
  have hinj : Set.InjOn (edgeOf a) (nbr K a) := by
    intro c hc d hd h
    have hca : c ≠ a := by
      rintro rfl
      have hnz : K c c ≠ 0 := by simpa [nbr, mem_filter] using hc
      exact hnz (hK.hollow c)
    have hda : d ≠ a := by
      rintro rfl
      have hnz : K d d ≠ 0 := by simpa [nbr, mem_filter] using hd
      exact hnz (hK.hollow d)
    exact edgeOf_inj hca hda h
  have hcard : ((nbr K a).image (edgeOf a)).card = (nbr K a).card := card_image_of_injOn hinj
  exact (eq_of_subset_of_card_le hsub (by omega)).symm

/-- **Every edge then carries that vertex as one of its two components.** -/
theorem mem_edges_has {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) {a : Fin n}
    (ha : 2 ≤ (nbr K a).card) (h2 : (edges K).card = 2) {e : Fin n × Fin n} (he : e ∈ edges K) :
    e.1 = a ∨ e.2 = a := by
  rw [edges_eq_image hK ha h2] at he
  obtain ⟨c, _, rfl⟩ := mem_image.mp he
  unfold edgeOf
  by_cases hc : a < c <;> simp [hc]

/-- **Two edges are impossible.** Both endpoints of one edge lie in every edge, so the two edges
coincide. -/
theorem card_edges_ne_two (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) :
    (edges K).card ≠ 2 := by
  intro h2
  obtain ⟨p, q, hpq, hset⟩ := card_eq_two.mp h2
  have hp : p ∈ edges K := by rw [hset]; exact mem_insert_self p {q}
  have hq : q ∈ edges K := by rw [hset]; simp
  have hp' : p.1 < p.2 ∧ K p.1 p.2 ≠ 0 := by simpa [edges, mem_filter] using hp
  have hq' : q.1 < q.2 ∧ K q.1 q.2 ≠ 0 := by simpa [edges, mem_filter] using hq
  have hsym : K p.2 p.1 ≠ 0 := by rw [← hK.symm p.1 p.2]; exact hp'.2
  have h1 := mem_edges_has hK (two_le_card_nbr K hK hp'.2) h2 hq
  have h2' := mem_edges_has hK (two_le_card_nbr K hK hsym) h2 hq
  apply hpq
  have hne : p.1 ≠ p.2 := ne_of_lt hp'.1
  rcases h1 with e1 | e1 <;> rcases h2' with e2 | e2
  · exact absurd (e1.symm.trans e2) hne
  · exact (Prod.ext e1 e2).symm
  · have hlt : p.2 < p.1 := by rw [← e2, ← e1]; exact hq'.1
    exact absurd hlt (asymm hp'.1)
  · exact absurd (e1.symm.trans e2) hne

/-- **The triangle's row-sum system has only the zero solution.** On three mutually adjacent
vertices the three row sums read `x + y = 0`, `x + z = 0`, `y + z = 0`, whose matrix has
determinant `-2`. -/
theorem triangle_forces_zero {x y z : ℝ} (h1 : x + y = 0) (h2 : x + z = 0) (h3 : y + z = 0) :
    x = 0 ∧ y = 0 ∧ z = 0 := ⟨by linarith, by linarith, by linarith⟩

/-- The edges incident to `a`. -/
noncomputable def edgesAt (K : Matrix (Fin n) (Fin n) ℝ) (a : Fin n) : Finset (Fin n × Fin n) :=
  (edges K).filter (fun e => e.1 = a ∨ e.2 = a)

/-- **`a`'s neighbours and `a`'s edges are equinumerous.** `edgeOf a` maps one onto the other. -/
theorem card_edgesAt (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) (a : Fin n) :
    (edgesAt K a).card = (nbr K a).card := by
  have himg : (nbr K a).image (edgeOf a) = edgesAt K a := by
    ext e
    simp only [mem_image, edgesAt, mem_filter]
    constructor
    · rintro ⟨c, hc, rfl⟩
      have hnz : K a c ≠ 0 := by simpa [nbr, mem_filter] using hc
      refine ⟨edgeOf_mem hK hnz, ?_⟩
      unfold edgeOf; by_cases h : a < c <;> simp [h]
    · rintro ⟨he, hae⟩
      have he' : e.1 < e.2 ∧ K e.1 e.2 ≠ 0 := by simpa [edges, mem_filter] using he
      rcases hae with h | h
      · refine ⟨e.2, ?_, ?_⟩
        · simp only [nbr, mem_filter, mem_univ, true_and]; rw [← h]; exact he'.2
        · unfold edgeOf
          rw [← h, if_pos he'.1]
      · refine ⟨e.1, ?_, ?_⟩
        · simp only [nbr, mem_filter, mem_univ, true_and]
          rw [← h, hK.symm]; exact he'.2
        · unfold edgeOf
          have hnlt : ¬ (a < e.1) := by rw [← h]; exact not_lt.mpr he'.1.le
          rw [if_neg hnlt, ← h]
  rw [← himg]
  refine card_image_of_injOn ?_
  intro c hc d hd h
  have hca : c ≠ a := by
    rintro rfl
    have hnz : K c c ≠ 0 := by simpa [nbr, mem_filter] using hc
    exact hnz (hK.hollow c)
  have hda : d ≠ a := by
    rintro rfl
    have hnz : K d d ≠ 0 := by simpa [nbr, mem_filter] using hd
    exact hnz (hK.hollow d)
  exact edgeOf_inj hca hda h

/-- **Every support vertex lies in at least two edges.** The degree step, transported along the
bijection between neighbours and incident edges. -/
theorem two_le_card_edgesAt {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) {a b : Fin n}
    (hab : K a b ≠ 0) : 2 ≤ (edgesAt K a).card := by
  rw [card_edgesAt K hK a]
  exact two_le_card_nbr K hK hab

/-- **A vertex lying in two or more edges has one other than any given one.** -/
theorem exists_other_edge {K : Matrix (Fin n) (Fin n) ℝ} {p : Fin n × Fin n} {a : Fin n}
    (hpin : p ∈ edgesAt K a) (h2 : 2 ≤ (edgesAt K a).card) :
    ∃ e ∈ edgesAt K a, e ≠ p := by
  have hnon : ((edgesAt K a).erase p).Nonempty := by
    rw [← card_pos, card_erase_of_mem hpin]; omega
  obtain ⟨e, he⟩ := hnon
  exact ⟨e, (mem_erase.mp he).2, (mem_erase.mp he).1⟩

/-- Both endpoints of an edge are support vertices, so each lies in at least two edges. -/
theorem edge_endpoints_deg {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K)
    {p : Fin n × Fin n} (hp : p ∈ edges K) :
    p ∈ edgesAt K p.1 ∧ p ∈ edgesAt K p.2 ∧
      2 ≤ (edgesAt K p.1).card ∧ 2 ≤ (edgesAt K p.2).card := by
  have hp' : p.1 < p.2 ∧ K p.1 p.2 ≠ 0 := by simpa [edges, mem_filter] using hp
  have hsym : K p.2 p.1 ≠ 0 := by rw [← hK.symm p.1 p.2]; exact hp'.2
  exact ⟨mem_filter.mpr ⟨hp, Or.inl rfl⟩, mem_filter.mpr ⟨hp, Or.inr rfl⟩,
         two_le_card_edgesAt hK hp'.2, two_le_card_edgesAt hK hsym⟩

/-- **The far endpoint of an edge at `a`.** -/
def far (a : Fin n) (e : Fin n × Fin n) : Fin n := if e.1 = a then e.2 else e.1

/-- **The far endpoint of an edge at `a` is a neighbour of `a`.** -/
theorem far_mem_nbr {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) {a : Fin n}
    {e : Fin n × Fin n} (he : e ∈ edgesAt K a) : K a (far a e) ≠ 0 := by
  have h := mem_filter.mp he
  have he' : e.1 < e.2 ∧ K e.1 e.2 ≠ 0 := by simpa [edges, mem_filter] using h.1
  unfold far
  rcases h.2 with h1 | h1
  · rw [if_pos h1, ← h1]; exact he'.2
  · have hne : e.1 ≠ a := by
      rintro rfl
      exact absurd (h1.trans rfl) (ne_of_gt he'.1)
    rw [if_neg hne, ← h1, hK.symm]; exact he'.2

/-- **The far endpoint differs from `a`.** -/
theorem far_ne {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) {a : Fin n}
    {e : Fin n × Fin n} (he : e ∈ edgesAt K a) : far a e ≠ a := by
  intro h
  have hne := far_mem_nbr hK he
  rw [h] at hne
  exact hne (hK.hollow a)

/-- **An edge at `a` has `a` and its far endpoint as its two components.** -/
theorem far_components {K : Matrix (Fin n) (Fin n) ℝ} {a : Fin n} {e : Fin n × Fin n}
    (he : e ∈ edgesAt K a) :
    (e.1 = a ∧ e.2 = far a e) ∨ (e.1 = far a e ∧ e.2 = a) := by
  have h := mem_filter.mp he
  have he' : e.1 < e.2 ∧ K e.1 e.2 ≠ 0 := by simpa [edges, mem_filter] using h.1
  unfold far
  rcases h.2 with h1 | h1
  · rw [if_pos h1]; exact Or.inl ⟨h1, rfl⟩
  · have hne : e.1 ≠ a := by rw [← h1]; exact ne_of_lt he'.1
    rw [if_neg hne]; exact Or.inr ⟨rfl, h1⟩

/-- **A vertex with exactly two neighbours has those two entries summing to zero.** The row sum
runs over the whole index set, and every term off the neighbour set vanishes by definition. -/
theorem rowsum_pair {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) {a x y : Fin n}
    (hxy : x ≠ y) (hnbr : nbr K a = {x, y}) : K a x + K a y = 0 := by
  have hsum : ∑ b ∈ nbr K a, K a b = ∑ b, K a b := by
    refine Finset.sum_subset (subset_univ _) ?_
    intro b _ hb
    simpa [nbr] using hb
  rw [hnbr, Finset.sum_pair hxy] at hsum
  rw [hsum, hK.rowsum a]

/-- **A vertex lying in at most two edges has at most two neighbours, and if two named distinct
neighbours are among them, those are exactly its neighbours.** -/
theorem nbr_eq_pair {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) {a x y : Fin n}
    (hxy : x ≠ y) (hx : K a x ≠ 0) (hy : K a y ≠ 0) (hle : (edgesAt K a).card ≤ 2) :
    nbr K a = {x, y} := by
  have hsub : ({x, y} : Finset (Fin n)) ⊆ nbr K a := by
    intro b hb
    rcases mem_insert.mp hb with rfl | hb
    · simpa [nbr] using hx
    · rw [mem_singleton.mp hb]; simpa [nbr] using hy
  have hcard : (nbr K a).card ≤ ({x, y} : Finset (Fin n)).card := by
    rw [card_pair hxy, ← card_edgesAt K hK a]
    exact hle
  exact (eq_of_subset_of_card_le hsub hcard).symm

/-! ## The three-edge case

*A support of exactly three edges is a triangle, and a triangle's three row sums force its three
entries to vanish, contradicting each edge being nonzero. This is the last case standing between
the degree bound and the four-edge minimum.*
-/

/-- **No sectional matrix has a support of exactly three edges.** -/
theorem card_edges_ne_three {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) :
    (edges K).card ≠ 3 := by
  intro h3
  obtain ⟨p, hp⟩ : (edges K).Nonempty := by rw [← card_pos, h3]; omega
  obtain ⟨hp1, hp2, hd1, hd2⟩ := edge_endpoints_deg hK hp
  have hp' : p.1 < p.2 ∧ K p.1 p.2 ≠ 0 := by simpa [edges, mem_filter] using hp
  have hp12 : p.1 ≠ p.2 := ne_of_lt hp'.1
  obtain ⟨e2, he2, hne2⟩ := exists_other_edge hp1 hd1
  obtain ⟨e3, he3, hne3⟩ := exists_other_edge hp2 hd2
  set c := far p.1 e2 with hcdef
  have hc1 : K p.1 c ≠ 0 := far_mem_nbr hK he2
  have hcp1 : c ≠ p.1 := far_ne hK he2
  have h2c : (e2.1 = p.1 ∧ e2.2 = c) ∨ (e2.1 = c ∧ e2.2 = p.1) := far_components he2
  have he2edge : e2 ∈ edges K := (mem_filter.mp he2).1
  have he2' : e2.1 < e2.2 := by
    have : e2.1 < e2.2 ∧ K e2.1 e2.2 ≠ 0 := by simpa [edges, mem_filter] using he2edge
    exact this.1
  -- `c` is not the far endpoint of `p`, else `e2` would be `p` itself.
  have hcp2 : c ≠ p.2 := by
    intro hcq
    rcases h2c with ⟨ha, hb⟩ | ⟨ha, hb⟩
    · exact hne2 (Prod.ext ha (by rw [hb, hcq]))
    · rw [ha, hb, hcq] at he2'; exact absurd he2' (not_lt.mpr hp'.1.le)
  -- `e2` is an edge at `c`.
  have hc3 : e2 ∈ edgesAt K c :=
    mem_filter.mpr ⟨he2edge, by rcases h2c with ⟨_, hb⟩ | ⟨ha, _⟩
                                · exact Or.inr hb
                                · exact Or.inl ha⟩
  have hdc : 2 ≤ (edgesAt K c).card := two_le_card_edgesAt hK (by rw [hK.symm]; exact hc1)
  obtain ⟨e4, he4, hne4⟩ := exists_other_edge hc3 hdc
  -- `e2` and `e3` are distinct: `e2`'s endpoints are `p.1` and `c`, and neither is `p.2`.
  have h23 : e2 ≠ e3 := by
    rintro rfl
    have := (mem_filter.mp he3).2
    rcases h2c with ⟨ha, hb⟩ | ⟨ha, hb⟩
    · rcases this with h | h
      · exact hp12 (ha.symm.trans h)
      · exact hcp2 (hb.symm.trans h)
    · rcases this with h | h
      · exact hcp2 (ha.symm.trans h)
      · exact hp12 (hb.symm.trans h)
  have he3edge : e3 ∈ edges K := (mem_filter.mp he3).1
  -- the support is exactly these three edges
  have htriple : edges K = {p, e2, e3} := by
    have hsub : ({p, e2, e3} : Finset (Fin n × Fin n)) ⊆ edges K := by
      intro e he
      rcases mem_insert.mp he with rfl | he
      · exact hp
      · rcases mem_insert.mp he with rfl | he
        · exact he2edge
        · rw [mem_singleton.mp he]; exact he3edge
    have hc : ({p, e2, e3} : Finset (Fin n × Fin n)).card = 3 := by
      rw [card_insert_of_notMem (by simp [hne2.symm, hne3.symm]), card_pair h23]
    exact (eq_of_subset_of_card_le hsub (by rw [hc, h3])).symm
  -- `p` is not an edge at `c`, so the second edge at `c` is `e3`
  have hpnotc : p ∉ edgesAt K c := by
    intro hmem
    rcases (mem_filter.mp hmem).2 with h | h
    · exact hcp1 h.symm
    · exact hcp2 h.symm
  have he3c : e3 ∈ edgesAt K c := by
    have : e4 ∈ ({p, e2, e3} : Finset (Fin n × Fin n)) := htriple ▸ (mem_filter.mp he4).1
    rcases mem_insert.mp this with rfl | h
    · exact absurd he4 hpnotc
    · rcases mem_insert.mp h with rfl | h
      · exact absurd rfl hne4
      · rw [← mem_singleton.mp h]; exact he4
  -- so `e3` joins `p.2` to `c`
  have h3c : K p.2 c ≠ 0 := by
    have hd : (e3.1 = p.2 ∧ e3.2 = far p.2 e3) ∨ (e3.1 = far p.2 e3 ∧ e3.2 = p.2) :=
      far_components he3
    have hcmem := (mem_filter.mp he3c).2
    have hfar : far p.2 e3 = c := by
      rcases hd with ⟨ha, hb⟩ | ⟨ha, hb⟩
      · rcases hcmem with h | h
        · exact absurd (ha ▸ h) hcp2.symm
        · rw [← hb, h]
      · rcases hcmem with h | h
        · rw [← ha, h]
        · exact absurd (hb ▸ h) hcp2.symm
    rw [← hfar]; exact far_mem_nbr hK he3
  -- the three vertices each lie in exactly two of the three edges
  have hnot3at1 : e3 ∉ edgesAt K p.1 := by
    intro hmem
    have hd : (e3.1 = p.2 ∧ e3.2 = far p.2 e3) ∨ (e3.1 = far p.2 e3 ∧ e3.2 = p.2) :=
      far_components he3
    have hfar : far p.2 e3 = c := by
      have hcmem := (mem_filter.mp he3c).2
      rcases hd with ⟨ha, hb⟩ | ⟨ha, hb⟩
      · rcases hcmem with h | h
        · exact absurd (ha ▸ h) hcp2.symm
        · rw [← hb, h]
      · rcases hcmem with h | h
        · rw [← ha, h]
        · exact absurd (hb ▸ h) hcp2.symm
    rw [hfar] at hd
    rcases (mem_filter.mp hmem).2 with h | h
    · rcases hd with ⟨ha, _⟩ | ⟨ha, _⟩
      · exact hp12 (ha.symm.trans h).symm
      · exact hcp1 (ha.symm.trans h)
    · rcases hd with ⟨_, hb⟩ | ⟨_, hb⟩
      · exact hcp1 (hb.symm.trans h)
      · exact hp12 (hb.symm.trans h).symm
  have hnot2at2 : e2 ∉ edgesAt K p.2 := by
    intro hmem
    rcases (mem_filter.mp hmem).2 with h | h
    · rcases h2c with ⟨ha, _⟩ | ⟨ha, _⟩
      · exact hp12 (ha.symm.trans h)
      · exact hcp2 (ha.symm.trans h)
    · rcases h2c with ⟨_, hb⟩ | ⟨_, hb⟩
      · exact hcp2 (hb.symm.trans h)
      · exact hp12 (hb.symm.trans h)
  have hle1 : (edgesAt K p.1).card ≤ 2 := by
    have : edgesAt K p.1 ⊆ ({p, e2} : Finset (Fin n × Fin n)) := by
      intro e he
      have : e ∈ ({p, e2, e3} : Finset (Fin n × Fin n)) := htriple ▸ (mem_filter.mp he).1
      rcases mem_insert.mp this with rfl | h
      · exact mem_insert_self _ _
      · rcases mem_insert.mp h with rfl | h
        · exact mem_insert_of_mem (mem_singleton_self _)
        · rw [mem_singleton.mp h] at he; exact absurd he hnot3at1
    exact (card_le_card this).trans ((card_insert_le p {e2}).trans (by simp))
  have hle2 : (edgesAt K p.2).card ≤ 2 := by
    have : edgesAt K p.2 ⊆ ({p, e3} : Finset (Fin n × Fin n)) := by
      intro e he
      have : e ∈ ({p, e2, e3} : Finset (Fin n × Fin n)) := htriple ▸ (mem_filter.mp he).1
      rcases mem_insert.mp this with rfl | h
      · exact mem_insert_self _ _
      · rcases mem_insert.mp h with rfl | h
        · exact absurd he hnot2at2
        · rw [mem_singleton.mp h]; exact mem_insert_of_mem (mem_singleton_self _)
    exact (card_le_card this).trans ((card_insert_le p {e3}).trans (by simp))
  have hlec : (edgesAt K c).card ≤ 2 := by
    have : edgesAt K c ⊆ ({e2, e3} : Finset (Fin n × Fin n)) := by
      intro e he
      have : e ∈ ({p, e2, e3} : Finset (Fin n × Fin n)) := htriple ▸ (mem_filter.mp he).1
      rcases mem_insert.mp this with rfl | h
      · exact absurd he hpnotc
      · rcases mem_insert.mp h with rfl | h
        · exact mem_insert_self _ _
        · rw [mem_singleton.mp h]; exact mem_insert_of_mem (mem_singleton_self _)
    exact (card_le_card this).trans ((card_insert_le e2 {e3}).trans (by simp))
  -- the three row sums, and the triangle they force
  have r1 : K p.1 p.2 + K p.1 c = 0 :=
    rowsum_pair hK hcp2.symm (nbr_eq_pair hK hcp2.symm hp'.2 hc1 hle1)
  have r2 : K p.2 p.1 + K p.2 c = 0 :=
    rowsum_pair hK hcp1.symm (nbr_eq_pair hK hcp1.symm (by rw [hK.symm]; exact hp'.2) h3c hle2)
  have r3 : K c p.1 + K c p.2 = 0 :=
    rowsum_pair hK hp12 (nbr_eq_pair hK hp12 (by rw [hK.symm]; exact hc1)
      (by rw [hK.symm]; exact h3c) hlec)
  rw [hK.symm p.2 p.1] at r2
  rw [hK.symm c p.1, hK.symm c p.2] at r3
  exact hp'.2 (triangle_forces_zero r1 r2 r3).1

/-! ## The lemma

*The sentence naming the theorem, written as a Lean statement and discharged by the four
cardinality exclusions above.*
-/

/-- **L176.** A nonzero element of the coordinate-diagonal locus has at least four nonzero
entries above the diagonal, equivalently, `Λ²`-rank at least four.

A nonzero sectional matrix has a nonempty support, and one, two and three edges are each ruled
out above, so the support carries four edges or more. -/
theorem four_le_card_edges (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) (hne : K ≠ 0) :
    4 ≤ (edges K).card := by
  have h0 := card_edges_ne_zero K hK hne
  have h1 := card_edges_ne_one K hK
  have h2 := card_edges_ne_two K hK
  have h3 := card_edges_ne_three hK
  omega

end HamiltonsCubic.L176
