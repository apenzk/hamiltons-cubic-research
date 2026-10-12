import HamiltonsCubic.Base.PhiPairing
import HamiltonsCubic.Base.Curvature

/-!
# `bianchiOf`'s symmetries at `ℚ`, as lemmas

**THE RATIONAL TWIN OF [AltAntisym.lean](AltAntisym.lean)**, which states the same symmetries for
`altCoeff` over `ℝ`. *The proofs there are `ring` and `linarith`, neither of which uses an order or
a completeness*, so they transcribe; what does NOT transcribe is the lemma itself, the two layers
being over different fields.

**WHY IT IS WANTED.** `WCP2_bianchiOf` and `W33_bianchiOf` in [L34c.lean](../Results/L34c.lean)
quantify over all `4⁴` index tuples and are `native_decide`. *With these, the value at ONE tuple
plus the symmetries gives every tuple*, and [Bridge.lean](Bridge.lean)'s `bianchiOf_ofMatrix`
already evaluates that one tuple.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `inner2` is odd in its right argument. *The `ℝ` layer has this; the `ℚ` layer did not, and it
is three lines from the definition.* -/
theorem inner2_neg_right_q (X Y : Matrix ι ι ℚ) : inner2 X (-Y) = -inner2 X Y := by
  unfold inner2
  rw [Matrix.mul_neg, Matrix.trace_neg]
  ring

/-- `inner2` is odd in its LEFT argument too. -/
theorem inner2_neg_left_q (X Y : Matrix ι ι ℚ) : inner2 (-X) Y = -inner2 X Y := by
  unfold inner2
  rw [Matrix.transpose_neg, Matrix.neg_mul, Matrix.trace_neg]
  ring

/-- `inner2` is symmetric at `ℚ`. -/
theorem inner2_comm_q (X Y : Matrix ι ι ℚ) : inner2 X Y = inner2 Y X := by
  unfold inner2
  rw [← Matrix.trace_transpose (Xᵀ * Y), Matrix.transpose_mul, Matrix.transpose_transpose]

/-- **`bianchiOf` is CYCLIC in its last three indices**, straight from the definition: the three
rotations are the same three summands reordered. *`ring` after unfolding, and it needs nothing of
`R`.* -/
theorem bianchiOf_cyclic (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (i j k l : ι) :
    bianchiOf R i k l j = bianchiOf R i j k l := by
  unfold bianchiOf; ring

/-- **Swapping the last two indices flips the sign**, from `φ_ji = -φ_ij` in the three summands. -/
theorem bianchiOf_antisym_last (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (i j k l : ι) :
    bianchiOf R i j l k = -bianchiOf R i j k l := by
  unfold bianchiOf
  rw [show phi l k = -phi k l from phi_swap k l, show phi k j = -phi j k from phi_swap j k,
    show phi j l = -phi l j from phi_swap l j, inner2_neg_right_q, inner2_neg_right_q,
    inner2_neg_right_q]
  ring

/-- **So it vanishes when the LAST TWO indices coincide**, the swap fixing the tuple. -/
theorem bianchiOf_zero_34 (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (i j k : ι) :
    bianchiOf R i j k k = 0 := by
  have h := bianchiOf_antisym_last R i j k k; linarith

/-- **And when the second and fourth coincide**, by the cycle. -/
theorem bianchiOf_zero_24 (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (i j k : ι) :
    bianchiOf R i j k j = 0 := by
  linarith [bianchiOf_cyclic R i j k j, bianchiOf_zero_34 R i k j]

/-- **And when the second and third coincide.** -/
theorem bianchiOf_zero_23 (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (i j l : ι) :
    bianchiOf R i j j l = 0 := by
  linarith [bianchiOf_cyclic R i j j l, bianchiOf_zero_24 R i j l]

/-! ## The first pair, which is the only swap needing the operator's own properties

*The last three indices are handled by `phi_swap` and `ring` alone.* **Swapping the FIRST two needs
`R` to be odd and to be symmetric for the `Λ²` pairing**, which is `IsWeyl`'s second clause.
-/

/-- **Swapping the first two indices flips the sign**, at an odd and pairing-symmetric `R`. -/
theorem bianchiOf_antisym_first (R : Matrix ι ι ℚ → Matrix ι ι ℚ)
    (hneg : ∀ X, R (-X) = -R X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (i j k l : ι) :
    bianchiOf R j i k l = -bianchiOf R i j k l := by
  have hleft : ∀ a b c d : ι,
      inner2 (R (phi b a)) (phi c d) = -inner2 (R (phi a b)) (phi c d) := by
    intro a b c d
    rw [show phi b a = -phi a b from phi_swap a b, hneg, inner2_neg_left_q]
  have hpair : ∀ a b c d : ι,
      inner2 (R (phi a b)) (phi c d) = inner2 (R (phi c d)) (phi a b) := by
    intro a b c d
    rw [hsym _ _ (phi_isSkew a b) (phi_isSkew c d), inner2_comm_q]
  have hright : ∀ a b c d : ι,
      inner2 (R (phi a b)) (phi d c) = -inner2 (R (phi a b)) (phi c d) := by
    intro a b c d
    rw [show phi d c = -phi c d from phi_swap c d, inner2_neg_right_q]
  -- each summand of the swapped tuple is MINUS a summand of the original
  have t1 : inner2 (R (phi j i)) (phi k l) = -inner2 (R (phi i j)) (phi k l) := hleft i j k l
  have t2 : inner2 (R (phi j k)) (phi l i) = -inner2 (R (phi i l)) (phi j k) := by
    rw [hpair j k l i, hleft l i j k]
    ring
  have t3 : inner2 (R (phi j l)) (phi i k) = -inner2 (R (phi i k)) (phi l j) := by
    rw [hpair j l i k, hright i k j l]
    ring
  unfold bianchiOf
  linarith [t1, t2, t3]

/-! ## And the three coincidences involving the FIRST index

*Each is one instance of the first-pair antisymmetry, carried by the cycle.* **With the three
above, `bianchiOf` now vanishes whenever ANY two of the four indices coincide.**
-/

/-- Positions 1 and 2 equal: the swap fixes the tuple. -/
theorem bianchiOf_zero_12 (R : Matrix ι ι ℚ → Matrix ι ι ℚ)
    (hneg : ∀ X, R (-X) = -R X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (i k l : ι) :
    bianchiOf R i i k l = 0 := by
  have h := bianchiOf_antisym_first R hneg hsym i i k l; linarith

/-- Positions 1 and 3 equal, by the cycle from the case above. -/
theorem bianchiOf_zero_13 (R : Matrix ι ι ℚ → Matrix ι ι ℚ)
    (hneg : ∀ X, R (-X) = -R X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (i j l : ι) :
    bianchiOf R i j i l = 0 := by
  linarith [bianchiOf_cyclic R i j i l, bianchiOf_zero_12 R hneg hsym i l j]

/-- Positions 1 and 4 equal. -/
theorem bianchiOf_zero_14 (R : Matrix ι ι ℚ → Matrix ι ι ℚ)
    (hneg : ∀ X, R (-X) = -R X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (i j k : ι) :
    bianchiOf R i j k i = 0 := by
  linarith [bianchiOf_cyclic R i j k i, bianchiOf_zero_13 R hneg hsym i k j]

/-- Swapping the MIDDLE PAIR, which the cyclic rotation and the last-pair swap give together. -/
theorem bianchiOf_swap_mid (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (i j k l : ι) :
    bianchiOf R i k j l = -bianchiOf R i j k l :=
  (bianchiOf_cyclic R i k j l).symm.trans (bianchiOf_antisym_last R i j k l)

/-- **ONE TUPLE CARRIES ALL TWO HUNDRED AND FIFTY-SIX.**

*The three adjacent transpositions above generate the whole symmetric group on four letters*, so a
tuple with four distinct entries in `Fin 4` is a permutation of `(0,1,2,3)` and its value is the base
value up to sign. **The split is 24 all-distinct against 232 that repeat an index and vanish outright**, rather than
the even halving an earlier note claimed. Together that is what
replaces a `native_decide` over the full index range: the case split remains, and what it does in
each case is apply a named lemma rather than evaluate the `Λ²` form. -/
theorem bianchiOf_eq_zero_of_base (R : Matrix (Fin 4) (Fin 4) ℚ → Matrix (Fin 4) (Fin 4) ℚ)
    (hneg : ∀ X, R (-X) = -R X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (h0 : bianchiOf R 0 1 2 3 = 0) :
    ∀ i j k l, bianchiOf R i j k l = 0 := by
  have p0123 : bianchiOf R 0 1 2 3 = 0 := by
    exact h0
  have p0132 : bianchiOf R 0 1 3 2 = 0 := by
    rw [bianchiOf_antisym_last R 0 1 2 3, h0]
    ring
  have p0213 : bianchiOf R 0 2 1 3 = 0 := by
    rw [bianchiOf_swap_mid R 0 1 2 3, h0]
    ring
  have p0231 : bianchiOf R 0 2 3 1 = 0 := by
    rw [bianchiOf_antisym_last R 0 2 1 3, bianchiOf_swap_mid R 0 1 2 3, h0]
    ring
  have p0312 : bianchiOf R 0 3 1 2 = 0 := by
    rw [bianchiOf_swap_mid R 0 1 3 2, bianchiOf_antisym_last R 0 1 2 3, h0]
    ring
  have p0321 : bianchiOf R 0 3 2 1 = 0 := by
    rw [bianchiOf_swap_mid R 0 2 3 1, bianchiOf_antisym_last R 0 2 1 3, bianchiOf_swap_mid R 0 1 2 3, h0]
    ring
  have p1023 : bianchiOf R 1 0 2 3 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 0 1 2 3, h0]
    ring
  have p1032 : bianchiOf R 1 0 3 2 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 0 1 3 2, bianchiOf_antisym_last R 0 1 2 3, h0]
    ring
  have p1203 : bianchiOf R 1 2 0 3 = 0 := by
    rw [bianchiOf_swap_mid R 1 0 2 3, bianchiOf_antisym_first R hneg hsym 0 1 2 3, h0]
    ring
  have p1230 : bianchiOf R 1 2 3 0 = 0 := by
    rw [bianchiOf_antisym_last R 1 2 0 3, bianchiOf_swap_mid R 1 0 2 3, bianchiOf_antisym_first R hneg hsym 0 1 2 3, h0]
    ring
  have p1302 : bianchiOf R 1 3 0 2 = 0 := by
    rw [bianchiOf_swap_mid R 1 0 3 2, bianchiOf_antisym_first R hneg hsym 0 1 3 2, bianchiOf_antisym_last R 0 1 2 3, h0]
    ring
  have p1320 : bianchiOf R 1 3 2 0 = 0 := by
    rw [bianchiOf_swap_mid R 1 2 3 0, bianchiOf_antisym_last R 1 2 0 3, bianchiOf_swap_mid R 1 0 2 3, bianchiOf_antisym_first R hneg hsym 0 1 2 3, h0]
    ring
  have p2013 : bianchiOf R 2 0 1 3 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 0 2 1 3, bianchiOf_swap_mid R 0 1 2 3, h0]
    ring
  have p2031 : bianchiOf R 2 0 3 1 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 0 2 3 1, bianchiOf_antisym_last R 0 2 1 3, bianchiOf_swap_mid R 0 1 2 3, h0]
    ring
  have p2103 : bianchiOf R 2 1 0 3 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 1 2 0 3, bianchiOf_swap_mid R 1 0 2 3, bianchiOf_antisym_first R hneg hsym 0 1 2 3, h0]
    ring
  have p2130 : bianchiOf R 2 1 3 0 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 1 2 3 0, bianchiOf_antisym_last R 1 2 0 3, bianchiOf_swap_mid R 1 0 2 3, bianchiOf_antisym_first R hneg hsym 0 1 2 3, h0]
    ring
  have p2301 : bianchiOf R 2 3 0 1 = 0 := by
    rw [bianchiOf_swap_mid R 2 0 3 1, bianchiOf_antisym_first R hneg hsym 0 2 3 1, bianchiOf_antisym_last R 0 2 1 3, bianchiOf_swap_mid R 0 1 2 3, h0]
    ring
  have p2310 : bianchiOf R 2 3 1 0 = 0 := by
    rw [bianchiOf_swap_mid R 2 1 3 0, bianchiOf_antisym_first R hneg hsym 1 2 3 0, bianchiOf_antisym_last R 1 2 0 3, bianchiOf_swap_mid R 1 0 2 3, bianchiOf_antisym_first R hneg hsym 0 1 2 3, h0]
    ring
  have p3012 : bianchiOf R 3 0 1 2 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 0 3 1 2, bianchiOf_swap_mid R 0 1 3 2, bianchiOf_antisym_last R 0 1 2 3, h0]
    ring
  have p3021 : bianchiOf R 3 0 2 1 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 0 3 2 1, bianchiOf_swap_mid R 0 2 3 1, bianchiOf_antisym_last R 0 2 1 3, bianchiOf_swap_mid R 0 1 2 3, h0]
    ring
  have p3102 : bianchiOf R 3 1 0 2 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 1 3 0 2, bianchiOf_swap_mid R 1 0 3 2, bianchiOf_antisym_first R hneg hsym 0 1 3 2, bianchiOf_antisym_last R 0 1 2 3, h0]
    ring
  have p3120 : bianchiOf R 3 1 2 0 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 1 3 2 0, bianchiOf_swap_mid R 1 2 3 0, bianchiOf_antisym_last R 1 2 0 3, bianchiOf_swap_mid R 1 0 2 3, bianchiOf_antisym_first R hneg hsym 0 1 2 3, h0]
    ring
  have p3201 : bianchiOf R 3 2 0 1 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 2 3 0 1, bianchiOf_swap_mid R 2 0 3 1, bianchiOf_antisym_first R hneg hsym 0 2 3 1, bianchiOf_antisym_last R 0 2 1 3, bianchiOf_swap_mid R 0 1 2 3, h0]
    ring
  have p3210 : bianchiOf R 3 2 1 0 = 0 := by
    rw [bianchiOf_antisym_first R hneg hsym 2 3 1 0, bianchiOf_swap_mid R 2 1 3 0, bianchiOf_antisym_first R hneg hsym 1 2 3 0, bianchiOf_antisym_last R 1 2 0 3, bianchiOf_swap_mid R 1 0 2 3, bianchiOf_antisym_first R hneg hsym 0 1 2 3, h0]
    ring
  have z12 := bianchiOf_zero_12 R hneg hsym
  have z13 := bianchiOf_zero_13 R hneg hsym
  have z14 := bianchiOf_zero_14 R hneg hsym
  intro i j k l
  fin_cases i <;> fin_cases j <;> fin_cases k <;> fin_cases l <;>
    simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue,
      z12, z13, z14, bianchiOf_zero_23, bianchiOf_zero_24, bianchiOf_zero_34,
      p0123,
      p0132,
      p0213,
      p0231,
      p0312,
      p0321,
      p1023,
      p1032,
      p1203,
      p1230,
      p1302,
      p1320,
      p2013,
      p2031,
      p2103,
      p2130,
      p2301,
      p2310,
      p3012,
      p3021,
      p3102,
      p3120,
      p3201,
      p3210]

end HamiltonsCubic.Base
