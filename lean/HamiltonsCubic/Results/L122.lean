import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-!
# L122, the pair block, its trace, and the two things that kill the wrong form

[second-order.md](../../../findings/second-order.md)'s Lemma L122 puts the pair block of
`{j,k}` at a coordinate-diagonal `M` as
`½[diag(M_ji + M_ki) - M_jk·Id + M^(jk)] = -½Δ^(jk) - ½M_jk·Id`.

Three separate things are checked here, each stated with the hypotheses it needs:

* **`tr Δ^(jk) = 2 M_jk`**, from hollowness, symmetry and Ricci-flatness. The block asserts
  it while warning that "graph Laplacian" overreaches, and it is what forces a negative
  eigenvalue when `M_jk < 0`.
* **The row-sum test that killed the withdrawn halved form.** The correct block has constant
  row sums (`-½M_jk`, so `1` is an eigenvector) and the halved form's row sums vary with
  the index exactly when the two column entries do. Both directions are proved, so the test
  is decisive rather than suggestive.
* **Post F48's falsifier**, the padded `S⁶ × S⁶` at `n = 14`. Ricci-flatness gives
  `5α + 6γ = 0`, hence `5α - 6γ = -12γ` against a floor of `-11γ`.

**The falsifier needs `γ > 0` and the record does not say so.** At `γ < 0` the same
arithmetic gives no violation, so the sign is load-bearing; it is available from the record's
own `θ = 11γ > 0`, but it is a step and the post reads as though the direction were automatic.
Both directions are below.
-/

namespace HamiltonsCubic.PairBlock

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {M : ι → ι → ℝ}

/-- The row of `M` restricted off the pair `{j,k}` sums to `-(M_ij + M_ik)`, one Ricci
condition per index outside the pair, which is the `n - 2` the block names. -/
theorem deleted_row_sum (hr : ∀ a, ∑ b, M a b = 0) (j k i : ι) (hjk : j ≠ k) :
    ∑ m ∈ univ \ ({j, k} : Finset ι), M i m = -(M i j + M i k) := by
  classical
  have hsub : ({j, k} : Finset ι) ⊆ univ := subset_univ _
  have hsplit := Finset.sum_sdiff (f := fun m => M i m) hsub
  have hpair : ∑ m ∈ ({j, k} : Finset ι), M i m = M i j + M i k := Finset.sum_pair hjk
  have := hr i
  linarith [hsplit, hpair, this]

/-- **`tr Δ^(jk) = 2 M_jk`.** The Kirchhoff trace is the sum of the deleted matrix's row
sums, and hollowness kills its own diagonal. Needs hollowness, symmetry and Ricci-flatness. -/
theorem trace_kirchhoff (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a)
    (hr : ∀ a, ∑ b, M a b = 0) {j k : ι} (hjk : j ≠ k) :
    ∑ i ∈ univ \ ({j, k} : Finset ι), (∑ m ∈ univ \ ({j, k} : Finset ι), M i m)
      = 2 * M j k := by
  classical
  have hrow : ∀ i, ∑ m ∈ univ \ ({j, k} : Finset ι), M i m = -(M i j + M i k) :=
    fun i => deleted_row_sum hr j k i hjk
  rw [Finset.sum_congr rfl (fun i _ => hrow i)]
  have hcol : ∀ c : ι, ∑ i ∈ univ \ ({j, k} : Finset ι), M i c = -(M j c + M k c) := by
    intro c
    have hsub : ({j, k} : Finset ι) ⊆ univ := subset_univ _
    have hsplit := Finset.sum_sdiff (f := fun i => M i c) hsub
    have hpair : ∑ i ∈ ({j, k} : Finset ι), M i c = M j c + M k c := Finset.sum_pair hjk
    have hzero : ∑ i, M i c = 0 := by
      rw [Finset.sum_congr rfl (fun i _ => hs i c)]; exact hr c
    linarith [hsplit, hpair, hzero]
  have hexp : ∑ i ∈ univ \ ({j, k} : Finset ι), (-(M i j + M i k))
      = -((∑ i ∈ univ \ ({j, k} : Finset ι), M i j)
          + ∑ i ∈ univ \ ({j, k} : Finset ι), M i k) := by
    rw [← Finset.sum_add_distrib, ← Finset.sum_neg_distrib]
  rw [hexp, hcol j, hcol k, hh j, hh k, hs k j]
  ring

/-- A negative trace forces a negative entry, the shape of *"`tr Δ = 2M_jk` forces a
negative eigenvalue when `M_jk < 0`"*, with the spectral theorem left imported. -/
theorem neg_trace_has_neg (s : Finset ι) (f : ι → ℝ) (h : ∑ i ∈ s, f i < 0) :
    ∃ i ∈ s, f i < 0 := by
  by_contra hcon
  push_neg at hcon
  exact absurd (Finset.sum_nonneg fun i hi => hcon i hi) (not_le.2 h)

/-! ## The row-sum test that killed the halved form -/

/-- **The correct block has constant row sums.** Every row of
`diag(M_ji + M_ki) - M_jk·Id + M^(jk)` sums to `-M_jk`, so `1` is an eigenvector and the
block preserves the Ricci cut. -/
theorem correct_row_sum (hs : ∀ a b, M a b = M b a) (hr : ∀ a, ∑ b, M a b = 0)
    {j k : ι} (hjk : j ≠ k) (i : ι) :
    (M j i + M k i) - M j k + ∑ m ∈ univ \ ({j, k} : Finset ι), M i m = -M j k := by
  rw [deleted_row_sum hr j k i hjk, hs j i, hs k i]; ring

/-- **The halved form's row sums vary with the index.** Its row `i` sums to
`-¼M_jk - ¼(M_ij + M_ik)`, so two indices disagree exactly when their two column entries do,
and then `1` is not an eigenvector. This is the test the record says needs no normalisation. -/
theorem halved_row_sum (hr : ∀ a, ∑ b, M a b = 0) {j k : ι} (hjk : j ≠ k) (i : ι) :
    -(1 / 4) * M j k + (1 / 4) * ∑ m ∈ univ \ ({j, k} : Finset ι), M i m
      = -(1 / 4) * M j k - (1 / 4) * (M i j + M i k) := by
  rw [deleted_row_sum hr j k i hjk]; ring

/-- The two rows differ precisely when the column entries differ, the halved form fails the
test exactly on the inputs that carry information. -/
theorem halved_rows_differ (hr : ∀ a, ∑ b, M a b = 0) {j k : ι} (hjk : j ≠ k) (i i' : ι)
    (hne : M i j + M i k ≠ M i' j + M i' k) :
    (-(1 / 4) * M j k + (1 / 4) * ∑ m ∈ univ \ ({j, k} : Finset ι), M i m)
      ≠ (-(1 / 4) * M j k + (1 / 4) * ∑ m ∈ univ \ ({j, k} : Finset ι), M i' m) := by
  rw [halved_row_sum hr hjk i, halved_row_sum hr hjk i']
  intro h
  exact hne (by linarith)

end HamiltonsCubic.PairBlock

/-! ## Post F48, the falsifier at the padded `S⁶ × S⁶`, and the sign it needs -/

namespace HamiltonsCubic.F48

/-- Ricci-flatness at the padded point: `5α + 6γ = 0`. -/
def ricci (α γ : ℝ) : Prop := 5 * α + 6 * γ = 0

/-- **The `1⊥` eigenvalue is `-12γ`.** -/
theorem eigen_value {α γ : ℝ} (h : ricci α γ) : 5 * α - 6 * γ = -12 * γ := by
  unfold ricci at h; linarith

/-- **The violation, with the sign hypothesis the post does not state.** At `γ > 0` the
eigenvalue falls strictly below the floor `-11γ`. -/
theorem violation {α γ : ℝ} (h : ricci α γ) (hγ : 0 < γ) : 5 * α - 6 * γ < -11 * γ := by
  rw [eigen_value h]; linarith

/-- **And the sign is load-bearing**: at `γ < 0` the same point clears the floor, so the
post's arithmetic alone does not produce a counterexample. -/
theorem no_violation {α γ : ℝ} (h : ricci α γ) (hγ : γ < 0) : -11 * γ < 5 * α - 6 * γ := by
  rw [eigen_value h]; linarith

/-- The gap is exactly one unit of `γ`, so the failure is `O(1)` rather than marginal. -/
theorem gap {α γ : ℝ} (h : ricci α γ) : (-11 * γ) - (5 * α - 6 * γ) = γ := by
  rw [eigen_value h]; ring

end HamiltonsCubic.F48

/-! ## The block census, from the character decomposition -/

namespace HamiltonsCubic.PairCensus

/-- `S³ × S³` has `15` pair blocks, of which the `6` within-factor ones carry no orbit
direction, the record's *"six of the fifteen"*. -/
theorem s3s3_pair_blocks : Nat.choose 6 2 = 15 := by decide

theorem s3s3_within_factor : Nat.choose 3 2 + Nat.choose 3 2 = 6 := by decide

theorem s3s3_cross_blocks : Nat.choose 6 2 - (Nat.choose 3 2 + Nat.choose 3 2) = 9 := by decide

/-- The cross-factor pair blocks are the `3 × 3` choices of one index from each factor,
which is the `9` the subtraction leaves, reached the other way. -/
theorem s3s3_cross_direct : 3 * 3 = 9 := by decide

end HamiltonsCubic.PairCensus
