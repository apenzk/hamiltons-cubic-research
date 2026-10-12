import Mathlib.Tactic
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.StructureConstants

/-!
# Lemma L208, Ricci-flatness of the Fox square on the diagonal locus

[findings/curvature-invariants.md](../../../findings/curvature-invariants.md), the L208 block.

On the coordinate-diagonal locus a Weyl tensor is its sectional matrix `K`, symmetric with zero
diagonal, and Ricci-flatness is `K * 1 = 0`, that is every row summing to zero. There both halves
of `Q` are pair-diagonal, with `(W²) a c = (K a c)²` and `(W#) a c = (K * K) a c`, so the Ricci
contraction of `Q(W)` at `a` is the sum over `c ≠ a` of `(K a c)² + (K * K) a c`.

**THIS FILE TYPES AND PROVES THAT THE SUM VANISHES**, which is the lemma's ARITHMETIC and not the
lemma: pure matrix algebra, with no curvature operator, no bivector and no dimension in it. *The
step from a coordinate-diagonal Weyl tensor to that sum is the geometry, proved in
[L208Geom.lean](L208Geom.lean) as `Qop_diag_eq` and `L208_operator`*
([r899](../../../reviews/REVIEW_r899.md) derived it from the record's half-carrying index formula
and found it exact rather than true up to a factor, and the lemma SHARP in that `½`: under the
other convention in circulation the conclusion would read `-∑ K²` and be false at every `W ≠ 0`).

`rowSum_sq_add_sq_cancel` is the statement. Its two halves are `sum_sq_offDiag`, that dropping
`c = a` costs nothing when the diagonal is zero, and `sum_sqMul_offDiag`, that the off-diagonal
sum of `K * K` is the negative of the diagonal sum of squares.

**The content is the CANCELLATION and neither half vanishes alone.** `sum_sq_pos_of_ne` records
the first half as strictly positive at any `K` with a nonzero entry, and `Kss` below is the
sectional matrix of `S² × S²` with the lemma applied to it, so nothing here is a statement about
two zeros.

**What this file does NOT state**: that a coordinate-diagonal Weyl tensor's `Q` has these two
halves, which is the geometry and is [L208Geom.lean](L208Geom.lean)'s `Qop_diag_eq`, and the off-diagonal case, which
needs the general identity and is the open half of the item.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Dropping the diagonal term costs nothing when the diagonal is zero.** -/
theorem sum_sq_offDiag (K : Matrix ι ι ℝ) (hdiag : ∀ a, K a a = 0) (a : ι) :
    ∑ c ∈ univ.erase a, (K a c) ^ 2 = ∑ c, (K a c) ^ 2 := by
  rw [← Finset.sum_erase_add univ _ (mem_univ a), hdiag a]
  simp

/-- **The off-diagonal sum of `K * K` is the negative of the diagonal sum of squares**, which is
where `K * 1 = 0` enters and is the only place it is used. -/
theorem sum_sqMul_offDiag (K : Matrix ι ι ℝ) (hsymm : ∀ a c, K c a = K a c)
    (hrow : ∀ a, ∑ c, K a c = 0) (a : ι) :
    ∑ c ∈ univ.erase a, (K * K) a c = -∑ c, (K a c) ^ 2 := by
  have hfull : ∑ c, (K * K) a c = 0 := by
    simp only [Matrix.mul_apply]
    rw [Finset.sum_comm]
    simp only [← Finset.mul_sum, hrow, mul_zero, Finset.sum_const_zero]
  have hdiagval : (K * K) a a = ∑ c, (K a c) ^ 2 := by
    simp only [Matrix.mul_apply]
    exact Finset.sum_congr rfl fun c _ => by rw [hsymm a c]; ring
  have := Finset.sum_erase_add univ (fun c => (K * K) a c) (mem_univ a)
  rw [hfull, hdiagval] at this
  linarith

/-- **Lemma L208 on the diagonal locus: the Ricci contraction of the Fox square vanishes.**

The two halves cancel identically, with no dimension entering. -/
theorem rowSum_sq_add_sq_cancel (K : Matrix ι ι ℝ) (hsymm : ∀ a c, K c a = K a c)
    (hdiag : ∀ a, K a a = 0) (hrow : ∀ a, ∑ c, K a c = 0) (a : ι) :
    ∑ c ∈ univ.erase a, ((K a c) ^ 2 + (K * K) a c) = 0 := by
  rw [Finset.sum_add_distrib, sum_sq_offDiag K hdiag a, sum_sqMul_offDiag K hsymm hrow a]
  ring

/-- **Neither half is zero on its own, so the cancellation is the content.** At any `K` with a
nonzero entry off the diagonal the square sum is strictly positive. -/
theorem sum_sq_pos_of_ne (K : Matrix ι ι ℝ) {a c : ι} (h : K a c ≠ 0) :
    0 < ∑ d, (K a d) ^ 2 :=
  Finset.sum_pos' (fun d _ => sq_nonneg (K a d)) ⟨c, mem_univ c, by positivity⟩

/-! ## The off-diagonal Ricci components, which vanish by pair-diagonality alone

**[r900](../../../reviews/REVIEW_r900.md) found this step used and never stated.** The matrix
identity above is the DIAGONAL Ricci component. The off-diagonal ones have to vanish too, and they
do for a reason with nothing to do with `K`: distinct pairs are orthogonal. *The same orthogonality
is what makes the first Bianchi condition free on this locus, so the two come together rather than
needing separate arguments.* -/

open RealLayer FamilyLayer in
/-- **A pair-diagonal operator has vanishing off-diagonal Ricci components.**

`R` sends each `phi a c` to a multiple of itself, so the Ricci sum is over
`q a c * ⟨phi a c, phi b c⟩`, and at `a ≠ b` the pairs `{a,c}` and `{b,c}` differ, so every term
is zero. **No hypothesis about the multipliers is used, which is the point.** -/
theorem Ric_offDiag_of_pairDiagonal (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (q : ι → ι → ℝ)
    (hdiag : ∀ a c, R (phi a c) = q a c • phi a c) {a b : ι} (hab : a ≠ b) :
    Ric R a b = 0 := by
  simp only [Ric, hdiag, inner2_smul_left, inner2_phi_phi]
  refine Finset.sum_eq_zero fun c _ => ?_
  have h2 : ¬(c = b ∧ a = c) := fun h => hab (h.2.trans h.1)
  simp [h2, hab]

/-! ## The Ricci convention, pinned against the record's own definition

**THIS IS THE STATEMENT THAT SHOULD HAVE BEEN TYPED BEFORE THE PROSE.** The sign of the general
Ricci identity was pinned in prose at `R = Id`, using `Ric(Id) = (n-1)δ` computed as an index
contraction. The record defines `Ric` as a sum of `inner2` pairings of an OPERATOR against
bivectors, so whether the two agree in sign and in factor was left for a reviewer to settle.
*The compiler settles it, and they agree.* -/

open RealLayer FamilyLayer in
/-- **`Ric` of the identity operator on bivectors is `(n-1)δ`**, from the record's own definition
rather than from an index convention.

*The off-diagonal case falls out of pair orthogonality in `inner2_phi_phi`, and the diagonal case
counts the single coincident index.* **This is what pins the `+` reading of
`Ric(Q(R))_ab = ∑ R_acbd Ric(R)_cd`**, since `Q(Id) = (n-1)Id` then makes both sides `(n-1)²δ`
while the `-` reading returns their negative. -/
theorem Ric_id_eq (a b : ι) :
    Ric (id : Matrix ι ι ℝ → Matrix ι ι ℝ) a b
      = (Fintype.card ι - 1 : ℝ) * (if a = b then 1 else 0) := by
  simp only [Ric, id_eq, inner2_phi_phi]
  by_cases hab : a = b
  · subst hab
    simp
    have : (univ.filter (fun x => x = a ∧ a = x)) = {a} := by
      ext x; simp [and_comm, eq_comm]
    rw [this, Finset.card_singleton]
  · simp [hab]

open RealLayer in
/-- **`Q(Id) = (n-1)Id` on bivectors, at every `n` and over `ℝ`.** *The other leg of the sign pin,
and it rests on [StructureConstants.lean](../Base/StructureConstants.lean)'s `sharpOp_id`, which
proves `Id# X = (n-2)X` at every skew `X` in general rather than on the `n = 4` rational anchor the
prose first cited* ([r905](../../../reviews/REVIEW_r905.md)). -/
theorem Qop_id_eq (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    Qop (ι := ι) (fun Z => Z) X = ((Fintype.card ι : ℝ) - 1) • X := by
  simp only [Qop, compOp, sharpOp_id X hX]
  module

/-! ## The deciding object, in the file rather than beside it

**A WITNESS BELONGS IN THE LAYER, NOT IN A SCRATCH FILE.** [r898](../../../reviews/REVIEW_r898.md)
found that the Weyl module file exhibited no nonzero member anywhere, so its non-vacuity claim was
carried by nothing. *This section is that lesson applied in the same session it was learned.* -/

/-- **The sectional matrix of `S² × S²` at `n = 4`**, pairs `{0,1}` and `{2,3}`. -/
noncomputable def Kss : Matrix (Fin 4) (Fin 4) ℝ :=
  !![0, 2/3, -1/3, -1/3; 2/3, 0, -1/3, -1/3; -1/3, -1/3, 0, 2/3; -1/3, -1/3, 2/3, 0]

theorem Kss_symm : ∀ a c, Kss c a = Kss a c := by
  intro a c; fin_cases a <;> fin_cases c <;> norm_num [Kss]

theorem Kss_diag : ∀ a, Kss a a = 0 := by intro a; fin_cases a <;> norm_num [Kss]

theorem Kss_row : ∀ a, ∑ c, Kss a c = 0 := by
  intro a
  fin_cases a <;>
    simp [Kss, Fin.sum_univ_four, Matrix.cons_val_two, Matrix.cons_val_three,
      Matrix.tail_cons, Matrix.head_cons] <;> norm_num

/-- **It is not the zero matrix**, so the hypotheses above are jointly satisfiable with content. -/
theorem Kss_ne_zero : Kss 0 1 ≠ 0 := by norm_num [Kss]

/-- **The two sharp-half entries, as the prose block states them.** -/
theorem Kss_sq_pair : (Kss * Kss) 0 1 = 2/9 := by
  simp [Kss, Matrix.mul_apply, Fin.sum_univ_four, Matrix.cons_val_two, Matrix.cons_val_three,
    Matrix.tail_cons, Matrix.head_cons] <;> norm_num

theorem Kss_sq_mixed : (Kss * Kss) 0 2 = -4/9 := by
  simp [Kss, Matrix.mul_apply, Fin.sum_univ_four, Matrix.cons_val_two, Matrix.cons_val_three,
    Matrix.tail_cons, Matrix.head_cons] <;> norm_num

/-- **And the lemma applies to it**, which is what makes the whole file non-vacuous. -/
theorem rowSum_cancel_at_Kss (a : Fin 4) :
    ∑ c ∈ univ.erase a, ((Kss a c) ^ 2 + (Kss * Kss) a c) = 0 :=
  rowSum_sq_add_sq_cancel Kss Kss_symm Kss_diag Kss_row a

/-!
## The axiom check, recorded where a reader meets it

```
#print axioms sum_sq_offDiag             -- [propext, Classical.choice, Quot.sound]
#print axioms sum_sqMul_offDiag          -- [propext, Classical.choice, Quot.sound]
#print axioms rowSum_sq_add_sq_cancel    -- [propext, Classical.choice, Quot.sound]
#print axioms sum_sq_pos_of_ne           -- [propext, Classical.choice, Quot.sound]
#print axioms Ric_offDiag_of_pairDiagonal -- [propext, Classical.choice, Quot.sound]
#print axioms Ric_id_eq                  -- [propext, Classical.choice, Quot.sound]
#print axioms Qop_id_eq                  -- [propext, Classical.choice, Quot.sound]
#print axioms Kss                        -- [propext, Classical.choice, Quot.sound]
#print axioms Kss_symm                   -- [propext, Classical.choice, Quot.sound]
#print axioms Kss_diag                   -- [propext, Classical.choice, Quot.sound]
#print axioms Kss_row                    -- [propext, Classical.choice, Quot.sound]
#print axioms Kss_ne_zero                -- [propext, Classical.choice, Quot.sound]
#print axioms Kss_sq_pair                -- [propext, Classical.choice, Quot.sound]
#print axioms Kss_sq_mixed               -- [propext, Classical.choice, Quot.sound]
#print axioms rowSum_cancel_at_Kss       -- [propext, Classical.choice, Quot.sound]
```

**What this file does NOT state**: that a coordinate-diagonal Weyl tensor's `Q` has the two halves
`(K a c)²` and `(K * K) a c`, which [L208Geom.lean](L208Geom.lean) proves as `Qop_diag_eq`; the
off-diagonal case, which needs the general identity; and the Bianchi half. *The last two are the
open half of [I83](../../../plan.md).*
-/

end HamiltonsCubic.Results
