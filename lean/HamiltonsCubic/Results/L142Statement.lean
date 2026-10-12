import Mathlib

set_option linter.style.longLine false

/-!
# L142, WITHDRAWN: dominated by bounds already on the record

The record's block, quoted verbatim from [bounds.md](../../../findings/bounds.md):

> #### Lemma L142, WITHDRAWN: dominated by bounds already on the record
>
> **The inequality is true**, both Gate 2 reviewers re-derived it independently and every
> convention checked ([r435], [r436]), **and it is worth nothing, being dominated in both of its
> terms.** [second-order.md] already proves, pointwise at unit norm, `⟨W, W#⟩ ≤ (n-2)y` and
> `θ ≤ √y + (n-2)y` with `y = ‖λ‖₄²`; since `∑|λ|³ ≤ y ≤ ‖λ‖_∞ ≤ 1` that bound is stronger term by
> term, with the identical worst case `n-1`. **L142 is that same AM–GM chain stopped one
> Cauchy–Schwarz short.** [Lemma L107] and [Lemma L108] each give the constant again by other
> routes.
>
> **Three framing errors went with it**, each caught by both reviewers: *"the record carries no
> proved bound at all"*, false, and the bound sat twenty lines below the post the lemma cited;
> *"the record's numerics put the true supremum near `1.545`"*, that figure is the supremum of a
> **relaxation bound**, not of `P`, and points a successor above the true target `√2`; and the
> statement `1 + (n-2)‖λ‖_∞` was **weaker than the lemma's own proof**, which gives
> `(n-1)‖λ‖_∞`. *Its "where it is loose" note also blamed the wrong step: the row-mass bound is
> saturated on the balanced products, and all the loss is in `‖λ‖_∞ ≤ 1`.*

## What this file types

**The block is a withdrawal notice, so what it asserts is the domination, and that is what is
stated and proved here.** `λ` is the eigenvalue list of a unit `W` on `Λ²`, so `∑ λ² = 1`; write
`y = ‖λ‖₄² = (∑ λ⁴)^{1/2}` and `L = ‖λ‖_∞`.

* `cube_le_quartic`, `∑ |λ|³ ≤ y`, by Cauchy–Schwarz against `∑ λ² = 1`.
* `quartic_le_sup`, `y ≤ L`, since `∑ λ⁴ ≤ L² ∑ λ² = L²`.
* `sup_le_one`, `L ≤ 1`, since `L² ≤ ∑ λ² = 1`.
* `chain`, the three together, which is the record's `∑|λ|³ ≤ y ≤ ‖λ‖_∞ ≤ 1`.
* `dominates`, **the domination, term by term**: `√y + (n-2)y ≤ 1 + (n-2)L` at every `n ≥ 2`, the
  first term because `y ≤ 1` and the second because `y ≤ L`. This is the whole content of the
  withdrawal.
* `worst_case_equal`, both sides read `n-1` at `y = L = 1`, the record's "identical worst case
  `n-1`".
* `witness_admissible`, a two-point eigenvalue list with `∑ λ² = 1`, so the hypotheses are
  satisfiable.

## What is NOT typed here

* **The withdrawn inequality itself.** L142's own statement is off the record: the block reports it
  as `1 + (n-2)‖λ‖_∞` while noting that the lemma's own proof gives the stronger
  `(n-1)‖λ‖_∞`, and does not settle which sentence is the lemma. What is typed is the surviving
  claim (that whichever it was, the incumbent bound dominates it), with `1 + (n-2)L` carried as
  the block's own written form.
* **The incumbent bound `θ ≤ √y + (n-2)y`**, which is second-order.md's and enters here only as the
  left side of a comparison of two real expressions. Nothing about `θ`, `P`, `W#` or criticality is
  stated; `y` and `L` are functionals of an eigenvalue list, not of a Weyl tensor.
* **That `λ` is the spectrum of a unit Weyl operator on `Λ²`.** Only `∑ λ² = 1` is used, which is
  the one consequence the domination needs.
* The three framing errors, the attribution to L107/L108, and the note about where the loss sits.
-/

namespace HamiltonsCubic.L142Statement

open Finset

variable {ι : Type*} [Fintype ι]

/-- `y = ‖λ‖₄² = (∑ λ⁴)^{1/2}`. -/
noncomputable def yq (lam : ι → ℝ) : ℝ := Real.sqrt (∑ a, (lam a) ^ 4)

/-- `L = ‖λ‖_∞`, as a hypothesis-carried bound rather than as a `sup'`, every statement below uses
only that `L` bounds each `|λ_a|`. -/
def IsSupBound (lam : ι → ℝ) (L : ℝ) : Prop := ∀ a, |lam a| ≤ L

theorem yq_nonneg (lam : ι → ℝ) : 0 ≤ yq lam := Real.sqrt_nonneg _

/-! ## The chain `∑|λ|³ ≤ y ≤ ‖λ‖_∞ ≤ 1` -/

/-- `∑ |λ|³ ≤ y`, by Cauchy–Schwarz against the unit-norm constraint `∑ λ² = 1`. -/
theorem cube_le_quartic (lam : ι → ℝ) (hunit : ∑ a, (lam a) ^ 2 = 1) :
    ∑ a, |lam a| ^ 3 ≤ yq lam := by
  classical
  have hcs := Real.sum_mul_le_sqrt_mul_sqrt (Finset.univ : Finset ι)
    (fun a => (lam a) ^ 2) (fun a => |lam a|)
  have hL : ∑ a, (lam a) ^ 2 * |lam a| = ∑ a, |lam a| ^ 3 := by
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← sq_abs (lam a)]; ring
  have h4 : ∑ a, ((lam a) ^ 2) ^ 2 = ∑ a, (lam a) ^ 4 := by
    refine Finset.sum_congr rfl fun a _ => by ring
  have h2 : ∑ a, |lam a| ^ 2 = 1 := by
    rw [← hunit]
    exact Finset.sum_congr rfl fun a _ => sq_abs (lam a)
  rw [hL, h4, h2] at hcs
  simpa [yq] using hcs

/-- `y ≤ ‖λ‖_∞`, since `∑ λ⁴ ≤ L² ∑ λ² = L²`. -/
theorem quartic_le_sup (lam : ι → ℝ) (L : ℝ) (hL : IsSupBound lam L)
    (hunit : ∑ a, (lam a) ^ 2 = 1) : yq lam ≤ L := by
  have hL0 : 0 ≤ L := by
    classical
    rcases Finset.eq_empty_or_nonempty (Finset.univ : Finset ι) with he | ⟨a, _⟩
    · exfalso; rw [he] at hunit; simp at hunit
    · exact le_trans (abs_nonneg _) (hL a)
  have hstep : ∑ a, (lam a) ^ 4 ≤ L ^ 2 := by
    calc ∑ a, (lam a) ^ 4 ≤ ∑ a, L ^ 2 * (lam a) ^ 2 := by
          refine Finset.sum_le_sum fun a _ => ?_
          have h1 : (lam a) ^ 2 ≤ L ^ 2 := by
            rw [← sq_abs (lam a)]
            exact pow_le_pow_left₀ (abs_nonneg _) (hL a) 2
          nlinarith [sq_nonneg (lam a)]
      _ = L ^ 2 := by rw [← Finset.mul_sum, hunit, mul_one]
  calc yq lam = Real.sqrt (∑ a, (lam a) ^ 4) := rfl
    _ ≤ Real.sqrt (L ^ 2) := Real.sqrt_le_sqrt hstep
    _ = L := by rw [Real.sqrt_sq hL0]

/-- `‖λ‖_∞ ≤ 1`, since `L² ≤ ∑ λ² = 1` once `L` is attained. Stated for the attained supremum, the
form the record uses. -/
theorem sup_le_one (lam : ι → ℝ) (a₀ : ι) (hunit : ∑ a, (lam a) ^ 2 = 1) : |lam a₀| ≤ 1 := by
  classical
  have hle : (lam a₀) ^ 2 ≤ ∑ a, (lam a) ^ 2 :=
    Finset.single_le_sum (f := fun a => (lam a) ^ 2) (fun a _ => sq_nonneg _) (Finset.mem_univ a₀)
  rw [hunit] at hle
  rw [← sq_abs] at hle
  nlinarith [abs_nonneg (lam a₀)]

/-- **The record's chain**, `∑|λ|³ ≤ y ≤ ‖λ‖_∞ ≤ 1`, with `‖λ‖_∞` carried as an attained bound. -/
theorem chain (lam : ι → ℝ) (a₀ : ι) (hL : IsSupBound lam |lam a₀|)
    (hunit : ∑ a, (lam a) ^ 2 = 1) :
    (∑ a, |lam a| ^ 3) ≤ yq lam ∧ yq lam ≤ |lam a₀| ∧ |lam a₀| ≤ 1 :=
  ⟨cube_le_quartic lam hunit, quartic_le_sup lam _ hL hunit, sup_le_one lam a₀ hunit⟩

/-! ## The domination, which is the whole content of the withdrawal -/

/-- **THE DOMINATION, TERM BY TERM.** The incumbent bound `√y + (n-2)y` is at most the withdrawn
lemma's `1 + (n-2)L` at every `n ≥ 2`: the first term because `y ≤ L ≤ 1`, the second because
`y ≤ L`. -/
theorem dominates (n y L : ℝ) (hn : 2 ≤ n) (hyL : y ≤ L) (hL1 : L ≤ 1) :
    Real.sqrt y + (n - 2) * y ≤ 1 + (n - 2) * L := by
  have hy1 : y ≤ 1 := le_trans hyL hL1
  have h1 : Real.sqrt y ≤ 1 := by
    rw [show (1 : ℝ) = Real.sqrt 1 by simp]
    exact Real.sqrt_le_sqrt hy1
  have h2 : (n - 2) * y ≤ (n - 2) * L := mul_le_mul_of_nonneg_left hyL (by linarith)
  linarith

/-- **The identical worst case `n - 1`**: at `y = L = 1` both sides read `n - 1`. -/
theorem worst_case_equal (n : ℝ) :
    Real.sqrt 1 + (n - 2) * 1 = n - 1 ∧ 1 + (n - 2) * 1 = n - 1 := by
  constructor <;> simp <;> ring

/-- **The domination in the lemma's own terms**: with `λ` a unit eigenvalue list and `L` an attained
supremum bound, the incumbent bound is at most the withdrawn one. -/
theorem dominates_at_unit (n : ℝ) (hn : 2 ≤ n) (lam : ι → ℝ) (a₀ : ι)
    (hL : IsSupBound lam |lam a₀|) (hunit : ∑ a, (lam a) ^ 2 = 1) :
    Real.sqrt (yq lam) + (n - 2) * yq lam ≤ 1 + (n - 2) * |lam a₀| :=
  dominates n (yq lam) |lam a₀| hn (quartic_le_sup lam _ hL hunit) (sup_le_one lam a₀ hunit)

/-! ## Nothing above is vacuous -/

/-- A two-point eigenvalue list with `∑ λ² = 1` and an attained supremum, so the hypotheses of
`chain` and `dominates_at_unit` are satisfiable. -/
noncomputable def wit : Fin 2 → ℝ := ![Real.sqrt 2 / 2, -(Real.sqrt 2 / 2)]

theorem witness_admissible :
    (∑ a : Fin 2, (wit a) ^ 2) = 1 ∧ IsSupBound wit |wit 0| := by
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hpos : (0 : ℝ) ≤ Real.sqrt 2 / 2 := by positivity
  have h0 : |wit 0| = Real.sqrt 2 / 2 := by
    show |Real.sqrt 2 / 2| = Real.sqrt 2 / 2
    exact abs_of_nonneg hpos
  refine ⟨?_, ?_⟩
  · rw [Fin.sum_univ_two]
    show (Real.sqrt 2 / 2) ^ 2 + (-(Real.sqrt 2 / 2)) ^ 2 = 1
    nlinarith
  · intro a
    rw [h0]
    fin_cases a
    · show |Real.sqrt 2 / 2| ≤ Real.sqrt 2 / 2
      exact le_of_eq (abs_of_nonneg hpos)
    · show |(-(Real.sqrt 2 / 2))| ≤ Real.sqrt 2 / 2
      rw [abs_neg]
      exact le_of_eq (abs_of_nonneg hpos)

end HamiltonsCubic.L142Statement
