import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-!
# L68, the symmetry defect on the diagonal locus

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L68 gives the Petersen–Wink
density `g_ab` in closed form on the diagonal locus, then specialises it at a critical point
and traces it. The block is careful about hypotheses in one place, *"the cap needs criticality
**and hollowness**"*, and silent elsewhere, so this file **carries each hypothesis on the
statement that uses it**:

* `(i)` needs hollowness and symmetry, and nothing else.
* `(iii)` needs `(i)` plus the off-diagonal criticality equation.
* `(iv)` needs `(iii)` plus **Ricci-flatness**, the vanishing row sums. The block never names
  that at this step; it is the standing hypothesis of the file, stated once at the top as the
  second constraint on `θ`, and `(iv)` is the only one of the four that reaches for it.

`M` is the off-diagonal weight matrix, `s a = ‖M_a‖²`, and the whole file is real linear
algebra over a finite index, no curvature, exactly as the record's heading promises.
-/

namespace HamiltonsCubic.Diagonal

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι] (M : ι → ι → ℝ)

/-- `s a = ‖M_a‖²`, the squared norm of row `a`. -/
def rowSq (a : ι) : ℝ := ∑ d, M a d ^ 2

/-- `(M²)_{ab}`. -/
def sq (a b : ι) : ℝ := ∑ d, M a d * M d b

/-- The Petersen–Wink density `g_ab = 2 Σ_{d ≠ a,b} (M_ad - M_bd)²`. -/
def g (a b : ι) : ℝ := 2 * ∑ d ∈ univ \ {a, b}, (M a d - M b d) ^ 2

variable {M}

/-- The density is non-negative, it is twice a sum of squares, with no hypothesis. -/
theorem g_nonneg (a b : ι) : 0 ≤ g M a b := by
  unfold g
  have : (0:ℝ) ≤ ∑ d ∈ univ \ {a, b}, (M a d - M b d) ^ 2 :=
    Finset.sum_nonneg fun d _ => sq_nonneg _
  linarith

/-- **(i)**, the closed form, from hollowness and symmetry alone. -/
theorem g_eq (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a b : ι} (hab : a ≠ b) :
    g M a b = 2 * (rowSq M a + rowSq M b) - 4 * sq M a b - 4 * M a b ^ 2 := by
  have hsplit : ∑ d ∈ univ \ {a, b}, (M a d - M b d) ^ 2
      = (∑ d, (M a d - M b d) ^ 2) - (M a a - M b a) ^ 2 - (M a b - M b b) ^ 2 := by
    have hsub : ({a, b} : Finset ι) ⊆ univ := subset_univ _
    have := Finset.sum_sdiff (f := fun d => (M a d - M b d) ^ 2) hsub
    have hpair : ∑ d ∈ ({a, b} : Finset ι), (M a d - M b d) ^ 2
        = (M a a - M b a) ^ 2 + (M a b - M b b) ^ 2 := by
      rw [Finset.sum_pair hab]
    linarith [this, hpair]
  have hfull : ∑ d, (M a d - M b d) ^ 2
      = rowSq M a + rowSq M b - 2 * sq M a b := by
    unfold rowSq sq
    have key : ∀ d : ι, (M a d - M b d) ^ 2
        = M a d ^ 2 + M b d ^ 2 - 2 * (M a d * M d b) := fun d => by
      rw [hs b d]; ring
    rw [Finset.sum_congr rfl (fun d _ => key d), Finset.sum_sub_distrib,
      Finset.sum_add_distrib, ← Finset.mul_sum]
  have h1 : (M a a - M b a) ^ 2 = M a b ^ 2 := by
    rw [hh a, hs b a]; ring
  have h2 : (M a b - M b b) ^ 2 = M a b ^ 2 := by rw [hh b]; ring
  unfold g
  rw [hsplit, hfull, h1, h2]; ring

/-- **(iii)**, at a critical point the density is affine in the entry. The criticality
equation is `M_ab² + (M²)_ab = θ M_ab` off the diagonal. -/
theorem g_critical (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a b : ι} (hab : a ≠ b)
    {θ : ℝ} (hc : M a b ^ 2 + sq M a b = θ * M a b) :
    g M a b = 2 * (rowSq M a + rowSq M b) - 4 * θ * M a b := by
  rw [g_eq hh hs hab]; linarith

/-- **The entry cap**, every entry of a diagonal critical point is capped by its own two
row norms. This is `(iii)` together with `g ≥ 0`, and needs no sign condition on `θ`. -/
theorem entry_cap (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a b : ι} (hab : a ≠ b)
    {θ : ℝ} (hc : M a b ^ 2 + sq M a b = θ * M a b) :
    2 * θ * M a b ≤ rowSq M a + rowSq M b := by
  have := g_nonneg (M := M) a b
  rw [g_critical hh hs hab hc] at this
  linarith

/-- **Equality in the cap is exactly a twin pair**, `g_ab = 0` iff the two rows agree
off the pair. The block asserts this; here it is both directions. -/
theorem g_eq_zero_iff {a b : ι} :
    g M a b = 0 ↔ ∀ d ∈ univ \ ({a, b} : Finset ι), M a d = M b d := by
  unfold g
  constructor
  · intro h d hd
    have hsum : ∑ d ∈ univ \ ({a, b} : Finset ι), (M a d - M b d) ^ 2 = 0 := by linarith
    have := (Finset.sum_eq_zero_iff_of_nonneg
      (fun d _ => sq_nonneg (M a d - M b d))).1 hsum d hd
    have : M a d - M b d = 0 := by
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.1 this
    linarith
  · intro h
    have : ∑ d ∈ univ \ ({a, b} : Finset ι), (M a d - M b d) ^ 2 = 0 :=
      Finset.sum_eq_zero fun d hd => by rw [h d hd]; ring
    linarith

/-! ## (iv), the trace, and the hypothesis it needs that the block does not name

The conversion of defect into a `θ` deficit runs over the positive edges. The step that
carries **Ricci-flatness** is `posSum`: that the positive entries hold exactly half the `ℓ¹`
mass. Every other statement in L68 goes through without it.
-/

variable (M)

/-- The ordered off-diagonal pairs. -/
def offPairs : Finset (ι × ι) := univ.filter (fun p : ι × ι => p.1 ≠ p.2)

/-- The ordered off-diagonal pairs carrying a positive entry. -/
noncomputable def posPairs : Finset (ι × ι) :=
  (offPairs (ι := ι)).filter (fun p : ι × ι => 0 < M p.1 p.2)

/-- `‖M‖₁` over ordered pairs, twice the record's `Σ_{a<b}|M_ab|`. -/
def l1 : ℝ := ∑ p ∈ offPairs (ι := ι), |M p.1 p.2|

variable {M}

/-- The off-diagonal entries sum to zero, hollowness plus vanishing row sums. -/
theorem offSum_eq_zero (hh : ∀ a, M a a = 0) (hr : ∀ a, ∑ b, M a b = 0) :
    ∑ p ∈ offPairs (ι := ι), M p.1 p.2 = 0 := by
  classical
  have htot : ∑ p : ι × ι, M p.1 p.2 = 0 := by
    rw [Fintype.sum_prod_type]
    exact Finset.sum_eq_zero fun a _ => hr a
  have hdiag : ∑ p ∈ univ.filter (fun p : ι × ι => ¬ p.1 ≠ p.2), M p.1 p.2 = 0 :=
    Finset.sum_eq_zero fun p hp => by
      simp only [Finset.mem_filter, not_not] at hp
      rw [hp.2]; exact hh p.2
  have hsplit := Finset.sum_filter_add_sum_filter_not
    (univ : Finset (ι × ι)) (fun p : ι × ι => p.1 ≠ p.2) (fun p => M p.1 p.2)
  unfold offPairs
  linarith [htot, hdiag, hsplit]

/-- **Ricci-flatness is what splits the `ℓ¹` mass in half.** With every row summing to zero
the positive entries carry exactly half of `‖M‖₁`. This is the only step of L68 that uses
the hypothesis, and the block does not name it here. -/
theorem posSum (hh : ∀ a, M a a = 0) (hr : ∀ a, ∑ b, M a b = 0) :
    2 * ∑ p ∈ posPairs M, M p.1 p.2 = l1 M := by
  classical
  have hoff := offSum_eq_zero hh hr
  have hsplitM := Finset.sum_filter_add_sum_filter_not
    (offPairs (ι := ι)) (fun p : ι × ι => 0 < M p.1 p.2) (fun p => M p.1 p.2)
  have hsplitA := Finset.sum_filter_add_sum_filter_not
    (offPairs (ι := ι)) (fun p : ι × ι => 0 < M p.1 p.2) (fun p => |M p.1 p.2|)
  have hpos : ∑ p ∈ (offPairs (ι := ι)).filter (fun p : ι × ι => 0 < M p.1 p.2),
      |M p.1 p.2| = ∑ p ∈ posPairs M, M p.1 p.2 := by
    unfold posPairs
    exact Finset.sum_congr rfl fun p hp => by
      simp only [Finset.mem_filter] at hp
      exact abs_of_pos hp.2
  have hposM : ∑ p ∈ (offPairs (ι := ι)).filter (fun p : ι × ι => 0 < M p.1 p.2),
      M p.1 p.2 = ∑ p ∈ posPairs M, M p.1 p.2 := by unfold posPairs; rfl
  have hneg : ∑ p ∈ (offPairs (ι := ι)).filter (fun p : ι × ι => ¬ 0 < M p.1 p.2),
      |M p.1 p.2| + ∑ p ∈ (offPairs (ι := ι)).filter (fun p : ι × ι => ¬ 0 < M p.1 p.2),
      M p.1 p.2 = 0 := by
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_eq_zero fun p hp => by
      simp only [Finset.mem_filter, not_lt] at hp
      rw [abs_of_nonpos hp.2]; ring
  unfold l1
  linarith [hoff, hsplitM, hsplitA, hpos, hposM, hneg]

/-- `d_a⁺`, the number of positive edges at `a`. -/
noncomputable def degPos (M : ι → ι → ℝ) (a : ι) : ℕ :=
  (univ.filter (fun b => a ≠ b ∧ 0 < M a b)).card

theorem posPairs_eq :
    posPairs M = univ.filter (fun p : ι × ι => p.1 ≠ p.2 ∧ 0 < M p.1 p.2) := by
  classical
  unfold posPairs offPairs
  rw [Finset.filter_filter]

/-- Summing a function of the first index over the positive pairs is the degree-weighted
sum, the fibering step the record's `Σ_a d_a⁺ s_a` performs silently. -/
theorem sumFst (f : ι → ℝ) :
    ∑ p ∈ posPairs M, f p.1 = ∑ a, (degPos M a : ℝ) * f a := by
  classical
  rw [posPairs_eq, Finset.sum_filter, ← Finset.univ_product_univ, Finset.sum_product]
  refine Finset.sum_congr rfl fun a _ => ?_
  simp only [← Finset.sum_filter, Finset.sum_const, nsmul_eq_mul, degPos]

/-- Symmetry of `M` makes the positive pairs swap-closed, so the second index sums the same
way as the first. -/
theorem sumSnd (hs : ∀ a b, M a b = M b a) (f : ι → ℝ) :
    ∑ p ∈ posPairs M, f p.2 = ∑ a, (degPos M a : ℝ) * f a := by
  classical
  rw [← sumFst (M := M) f]
  refine Finset.sum_nbij' (i := Prod.swap) (j := Prod.swap) ?_ ?_ ?_ ?_ ?_
  · intro p hp
    rw [posPairs_eq] at hp ⊢
    simp only [Finset.mem_filter, Finset.mem_univ, true_and, Prod.fst_swap, Prod.snd_swap] at hp ⊢
    exact ⟨hp.1.symm, by rw [hs]; exact hp.2⟩
  · intro p hp
    rw [posPairs_eq] at hp ⊢
    simp only [Finset.mem_filter, Finset.mem_univ, true_and, Prod.fst_swap, Prod.snd_swap] at hp ⊢
    exact ⟨hp.1.symm, by rw [hs]; exact hp.2⟩
  · intro p _; exact Prod.swap_swap p
  · intro p _; exact Prod.swap_swap p
  · intro p _; rfl

/-- **(iv)**, the trace of the density over the positive edges, in the record's shape.
`Σ_{p ∈ posPairs} g` is twice the record's `Δ`, and `l1` is twice its `‖M‖₁`, so this is
`θ‖M‖₁ = Σ_a d_a⁺ s_a - Δ/2` with both doublings carried explicitly.

The hypotheses are exactly the three the block uses and names only two of: hollowness,
symmetry, criticality at every positive edge, and **Ricci-flatness**. -/
theorem trace_conversion (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a)
    (hr : ∀ a, ∑ b, M a b = 0) {θ : ℝ}
    (hc : ∀ p ∈ posPairs M, M p.1 p.2 ^ 2 + sq M p.1 p.2 = θ * M p.1 p.2) :
    ∑ p ∈ posPairs M, g M p.1 p.2
      = 4 * (∑ a, (degPos M a : ℝ) * rowSq M a) - 2 * θ * l1 M := by
  classical
  have hrw : ∀ p ∈ posPairs M, g M p.1 p.2
      = 2 * rowSq M p.1 + 2 * rowSq M p.2 - 4 * θ * M p.1 p.2 := by
    intro p hp
    have hne : p.1 ≠ p.2 := by
      rw [posPairs_eq] at hp; simp only [Finset.mem_filter] at hp; exact hp.2.1
    have := g_critical hh hs hne (hc p hp)
    linarith [this]
  rw [Finset.sum_congr rfl hrw]
  rw [Finset.sum_sub_distrib, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum,
    ← Finset.mul_sum, sumFst, sumSnd hs]
  have hS : ∑ p ∈ posPairs M, M p.1 p.2 = l1 M / 2 := by
    linarith [posSum hh hr]
  rw [hS]; ring

/-- **(iv) in the record's own variables.** With `Δ` the defect (the sum over unordered
positive edges, so half the ordered sum) and `‖M‖₁ = l1 / 2`, the conversion reads
`θ‖M‖₁ = Σ_a d_a⁺ s_a - Δ/2`, route R10's exchange of defect for `θ` deficit, exact. -/
theorem trace_conversion' (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a)
    (hr : ∀ a, ∑ b, M a b = 0) {θ Δ nrm : ℝ}
    (hΔ : 2 * Δ = ∑ p ∈ posPairs M, g M p.1 p.2) (hn : 2 * nrm = l1 M)
    (hc : ∀ p ∈ posPairs M, M p.1 p.2 ^ 2 + sq M p.1 p.2 = θ * M p.1 p.2) :
    θ * nrm = (∑ a, (degPos M a : ℝ) * rowSq M a) - Δ / 2 := by
  have := trace_conversion hh hs hr hc
  rw [← hΔ, ← hn] at this
  linarith [this]

end HamiltonsCubic.Diagonal
