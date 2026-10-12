import HamiltonsCubic.Results.DoublyStochastic

set_option linter.style.longLine false

/-!
# The equality case of the doubly stochastic Jensen bound: the diagonal is a rearrangement

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L52's equality clause, the "only if" half: Jensen's
equality makes the variable constant on the support of each row, which at a repeated eigenvalue leaves the weight spread
over the eigenspace, and the column sums then make the diagonal a rearrangement of the spectrum:

* **`rowwise_const`**: at equality with `g` strictly convex on a convex `s` holding the spectrum, `μ` is constant on the
  support of each row, so `Kᵢ = μⱼ` wherever `Pᵢⱼ ≠ 0` (`K = Pμ`);
* **`eq_rearrangement`**: then for every value `v` the diagonal takes `v` exactly as often as the spectrum does. Rows with
  `Kᵢ = v` put all their mass on the columns with `μⱼ = v`, and those columns receive mass only from such rows, so both
  counts equal the mass between the two sets;
* **`eq_multiset`**: the diagonal and the spectrum are the same multiset.

`P` need not be a permutation (a rotation inside a repeated eigenvalue is row-tight), and the conclusion holds anyway.
-/

namespace HamiltonsCubic.DoublyStochastic

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **At equality, each diagonal entry is the eigenvalue on its row's support.** -/
theorem rowwise_const {P : ι → ι → ℝ} (hP : IsDoublyStochastic P) {s : Set ℝ} {g : ℝ → ℝ}
    (hg : StrictConvexOn ℝ s g) (μ : ι → ℝ) (hμ : ∀ j, μ j ∈ s)
    (heq : ∑ i, g (∑ j, P i j • μ j) = ∑ j, g (μ j)) {i j : ι} (hij : P i j ≠ 0) :
    ∑ k, P i k • μ k = μ j := by
  have hrow : ∀ k : ι, k ∈ Finset.univ → g (∑ l, P k l • μ l) ≤ ∑ l, P k l • g (μ l) := fun k _ =>
    hg.convexOn.map_sum_le (fun l _ => hP.nonneg k l) (hP.rows k) (fun l _ => hμ l)
  have htot : ∑ i, g (∑ j, P i j • μ j) = ∑ i, ∑ j, P i j • g (μ j) := by rw [heq, sum_collapses hP μ g]
  have hi := (Finset.sum_eq_sum_iff_of_le hrow).1 htot i (Finset.mem_univ i)
  have hc := (hg.map_sum_eq_iff_of_nonneg (fun l _ => hP.nonneg i l) (hP.rows i) (fun l _ => hμ l)).1 hi
  calc ∑ k, P i k • μ k = ∑ k, P i k • μ j := Finset.sum_congr rfl fun k _ => by
        by_cases hk : P i k = 0
        · simp [hk]
        · rw [hc (Finset.mem_univ k) hk (Finset.mem_univ j) hij]
    _ = μ j := by rw [← Finset.sum_smul, hP.rows i, one_smul]

/-- **Equal counts at every value.** -/
theorem eq_rearrangement {P : ι → ι → ℝ} (hP : IsDoublyStochastic P) {s : Set ℝ} {g : ℝ → ℝ}
    (hg : StrictConvexOn ℝ s g) (μ : ι → ℝ) (hμ : ∀ j, μ j ∈ s)
    (heq : ∑ i, g (∑ j, P i j • μ j) = ∑ j, g (μ j)) (v : ℝ) :
    (univ.filter (fun i => ∑ j, P i j • μ j = v)).card = (univ.filter (fun j => μ j = v)).card := by
  set K : ι → ℝ := fun i => ∑ j, P i j • μ j with hK
  have key : ∀ i j, P i j ≠ 0 → K i = μ j := fun i j h => rowwise_const hP hg μ hμ heq h
  set Rv := univ.filter (fun i => K i = v)
  set Cv := univ.filter (fun j => μ j = v)
  have hR : (Rv.card : ℝ) = ∑ i ∈ Rv, ∑ j ∈ Cv, P i j := by
    rw [Finset.card_eq_sum_ones, Nat.cast_sum]
    refine Finset.sum_congr rfl fun i hi => ?_
    rw [Nat.cast_one, ← hP.rows i, ← Finset.sum_add_sum_compl Cv]
    have : ∑ j ∈ Cvᶜ, P i j = 0 := Finset.sum_eq_zero fun j hj => by
      by_contra h
      have := key i j h
      exact (Finset.mem_compl.mp hj) (Finset.mem_filter.mpr ⟨Finset.mem_univ _,
        by rw [← this]; exact (Finset.mem_filter.mp hi).2⟩)
    rw [this, add_zero]
  have hC : (Cv.card : ℝ) = ∑ j ∈ Cv, ∑ i ∈ Rv, P i j := by
    rw [Finset.card_eq_sum_ones, Nat.cast_sum]
    refine Finset.sum_congr rfl fun j hj => ?_
    rw [Nat.cast_one, ← hP.cols j, ← Finset.sum_add_sum_compl Rv]
    have : ∑ i ∈ Rvᶜ, P i j = 0 := Finset.sum_eq_zero fun i hi => by
      by_contra h
      have := key i j h
      exact (Finset.mem_compl.mp hi) (Finset.mem_filter.mpr ⟨Finset.mem_univ _,
        by rw [this]; exact (Finset.mem_filter.mp hj).2⟩)
    rw [this, add_zero]
  have : (Rv.card : ℝ) = Cv.card := by rw [hR, hC, Finset.sum_comm]
  exact_mod_cast this

/-- **The diagonal and the spectrum are the same multiset.** -/
theorem eq_multiset {P : ι → ι → ℝ} (hP : IsDoublyStochastic P) {s : Set ℝ} {g : ℝ → ℝ}
    (hg : StrictConvexOn ℝ s g) (μ : ι → ℝ) (hμ : ∀ j, μ j ∈ s)
    (heq : ∑ i, g (∑ j, P i j • μ j) = ∑ j, g (μ j)) :
    Multiset.map (fun i => ∑ j, P i j • μ j) univ.val = Multiset.map μ univ.val := by
  ext v
  rw [Multiset.count_map, Multiset.count_map]
  have h := eq_rearrangement hP hg μ hμ heq v
  simp only [Finset.card_def, Finset.filter_val] at h
  simpa only [eq_comm] using h

end HamiltonsCubic.DoublyStochastic
