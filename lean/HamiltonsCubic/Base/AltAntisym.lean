import HamiltonsCubic.Base.AltPart

/-!
# `Alt(R)` is totally antisymmetric, as lemmas rather than as a case split

**THIS FILE EXISTS BECAUSE THE CASE SPLIT DOES NOT WORK.** *Proving a statement about all `4⁴`
index tuples by `fin_cases` over four indices, with the generators supplied as hints, reached
5.5 GB and was killed.* **The generators themselves are cheap**: two are already in
[AltPart.lean](AltPart.lean) and the third is `ring`.

**WHAT IS BUILT HERE.** The three adjacent transpositions, and then vanishing whenever ANY two of
the four indices coincide. *Each of the six coincidence patterns is one `linarith` from one or two
instances*, which is what makes them affordable where the monolith was not.

**WHO NEEDED IT, AND THE DEBT IS PAID, 2026-09-22.** `WCP2_bianchiOf` and `W33_bianchiOf` in
[L34c.lean](../Results/L34c.lean) are now TERM PROOFS through `bianchiOf_eq_zero_of_base`, carrying
the base tuple by `norm_num` and the other 232 by the `S₄` generators, so the lemmas here are
consumed rather than owed. **The whole tree carries NO `native_decide` TACTIC use**, the last,
`WCP2_sharp_one`, being kernel-checked in [WCP2Sharp1.lean](WCP2Sharp1.lean) since 2026-09-23.
Every occurrence of the word in this layer is a docstring recording a retirement. *A count of 27 in this layer and 32 in the repository
stood here after both had ceased to be true, which is why the figure above is stated as what a grep
for the tactic returns rather than as a remembered total.*

`alt_eq_smul_levi4` in [I36DiagTest.lean](../Results/I36DiagTest.lean) also wants these lemmas, and
is counted nowhere above: *its taint is `sorryAx` rather than the compiler, it sits in `Results`
rather than the layer, and it carries exactly itself.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.AltLayer

open Matrix Finset HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`alt4` is CYCLIC in its last three indices**, straight from the definition: the three
rotations are the same three summands in a different order. *This is `ring` and needs nothing of
`R`.* -/
theorem altCoeff_cyclic (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    altCoeff R i k l j = altCoeff R i j k l := by
  unfold altCoeff alt4; ring

/-- **Swapping the LAST two indices flips the sign**, from `altCoeff_antisym_mid` conjugated by the
cycle. *The middle swap and the cycle generate the whole symmetric group on the last three.* -/
theorem altCoeff_antisym_last (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    altCoeff R i j l k = -altCoeff R i j k l := by
  linarith [altCoeff_antisym_mid R i l k j, altCoeff_cyclic R i j k l, altCoeff_cyclic R i j l k]

/-! ## Vanishing whenever two indices coincide

*The hypotheses are explicit binders rather than section variables*: Lean includes a section
variable only when the STATEMENT mentions it, and these are used in the proofs alone.
-/

/-- Positions 2 and 3 equal, which needs no hypothesis at all. -/
theorem altCoeff_zero_23 (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j l : ι) :
    altCoeff R i j j l = 0 := by
  have h := altCoeff_antisym_mid R i j j l; linarith

/-- Positions 3 and 4 equal. -/
theorem altCoeff_zero_34 (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k : ι) :
    altCoeff R i j k k = 0 := by
  linarith [altCoeff_cyclic R i j k k, altCoeff_zero_23 R i k j]

/-- Positions 2 and 4 equal. -/
theorem altCoeff_zero_24 (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k : ι) :
    altCoeff R i j k j = 0 := by
  linarith [altCoeff_cyclic R i j k j, altCoeff_zero_34 R i k j]

/-- Positions 1 and 2 equal, the first that needs the operator's sign and symmetry. -/
theorem altCoeff_zero_12 (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hneg : ∀ X, R (-X) = -R X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (i k l : ι) :
    altCoeff R i i k l = 0 := by
  have h := altCoeff_antisym_first R hneg hsym i i k l; linarith

/-- Positions 1 and 3 equal. -/
theorem altCoeff_zero_13 (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hneg : ∀ X, R (-X) = -R X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (i j l : ι) :
    altCoeff R i j i l = 0 := by
  linarith [altCoeff_antisym_mid R i j i l, altCoeff_zero_12 R hneg hsym i j l]

/-- Positions 1 and 4 equal. -/
theorem altCoeff_zero_14 (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hneg : ∀ X, R (-X) = -R X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (i j k : ι) :
    altCoeff R i j k i = 0 := by
  linarith [altCoeff_cyclic R i j k i, altCoeff_zero_13 R hneg hsym i k j]

end HamiltonsCubic.AltLayer
