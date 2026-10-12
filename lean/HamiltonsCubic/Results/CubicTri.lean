import HamiltonsCubic.Results.PcubicDiff

set_option linter.style.longLine false

/-!
# `P` as one trilinear form, and the estimate Fréchet differentiability needs

**[r1016](../../../reviews/REVIEW_r1016.md) named three pieces between the line derivative and
Fermat.** *[PcubicDiff.lean](PcubicDiff.lean) closed the FIRST, the `StrongDual` bundling. This file works
the SECOND: an
estimate on `Pcubic2Quad`, which [PhiTri.lean](PhiTri.lean) NAMED and nothing bounded.*

**THE WHOLE CUBIC IS ONE TRILINEAR FORM**, `cubicTri X Y Z = ⟨X ∘ Y, Z⟩ - ½ Φ(X;Y,Z)`, *and every
piece of the increment expansion is that one form at a different arrangement of `R` and `H`*:

- `Pcubic2 R` is `C(R,R,R)`,
- `Pcubic2Lin R H` is `C(H,R,R) + C(R,H,R) + C(R,R,H)`, the three arrangements with one `H`,
- `Pcubic2Quad R H` is `C(H,H,R) + C(H,R,H) + C(R,H,H)`, the three with two.

*So `Pcubic2_expand` is the trilinear expansion of `C(R+H,R+H,R+H)` and nothing else, which is what
the four separate definitions in [PhiTri.lean](PhiTri.lean) obscure.* **THE ESTIMATE IS THEN ONE
FACT ABOUT ONE OBJECT** rather than six about six terms: a trilinear form on a finite-dimensional
space is bounded, so `|Pcubic2Quad R H| ≤ 3‖C‖‖R‖‖H‖²` and `|Pcubic2 H| ≤ ‖C‖‖H‖³`, *both `o(‖H‖)`,
which is exactly the remainder `HasFDerivAt` wants.*

**WHAT IS PROVED HERE AND WHAT IS NOT.** *The identification of all four pieces with `cubicTri`,
the form's full trilinearity, AND THE BOUND, are all proved below.* **What is NOT here is the
`HasFDerivAt` statement itself.** *An earlier version of this paragraph said the bound was not
proved and stood three hundred lines above the proof of it*
([r1024](../../../reviews/REVIEW_r1024.md), [r1025](../../../reviews/REVIEW_r1025.md)).

**THE ITERATED-BUNDLING ROUTE IS UNREACHED BY SEARCH AND TEDIOUS, NOT CLOSED, AND A FIRST VERSION
OF THIS PARAGRAPH SAID IT WAS CLOSED "CHECKED IN THE KERNEL"** ([r1022](../../../reviews/REVIEW_r1022.md),
[r1023](../../../reviews/REVIEW_r1023.md), agreeing). *Three synthesis claims stood here and two were
false:* **`IsTopologicalAddGroup (CurvOp2 ι)` SYNTHESIZES**, inside the `OperatorNorm` scope and
outside it; **`ContinuousAdd (CurvOp2 ι)` fails in BOTH scopes**, so attributing that failure to the
scope boundary carries no information; and **`NormedAddCommGroup (CurvOp2 ι →L[ℝ] ℝ)` ELABORATES WHEN
NAMED**, `ContinuousLinearMap.toNormedAddCommGroup`, after which the next bundling level follows.
*The mechanism is the topology diamond this layer already records: the `TopologicalSpace` resolves to
`ContinuousLinearMap`'s native one while the scoped norm carries its own, equal at default
transparency and not reducibly, which defeats `infer_instance` and not the mathematics.*

**A FAILED `infer_instance` IS A FAILED SEARCH, AND SAYS NOTHING ABOUT WHETHER THE INSTANCE EXISTS.**
*That reading is what put the word "closed" here, and it is the reading to name the instance against
before concluding anything.*

**WHAT IS TRUE IS THAT MATHLIB CARRIES NO AUTOMATIC FINITE-DIMENSIONAL CONTINUITY FOR MULTILINEAR
MAPS**, the way `LinearMap.continuous_of_finiteDimensional` does for linear ones, *both reviewers
confirming it independently*, **so the constant is supplied by hand whichever route the bundling
takes.**

**AND NONE OF THIS IS A REASON TO REGISTER THE INNER PRODUCT**, which both reviewers also confirm.
*A first reading of the failed synthesis made `IsVonNBounded` a blocker again, which is the same
over-correction this layer has already made once.*

**THE ESTIMATE OWES THREE THINGS, AND A FIRST VERSION COUNTED TWO.** *`ContinuousLinearMap.opNorm_comp_le`
and `le_opNorm` reach the `⟨X ∘ Y, Z⟩ summand ONLY*, **`Φ` being built from `brS`, the commutator of
two matrix VALUES**, which needs submultiplicativity of the Frobenius norm and no norm lemma for
`brS` existed at all. The three:

1. **a Cauchy-Schwarz for `inner2`**, `inner2_sq_le`,
2. **`‖brS U V‖ ≤ 2‖U‖‖V‖`**, `norm_brS_le`, from `Matrix.frobenius_norm_mul`,
3. **`|innerOp2 A B| ≤ c‖A‖‖B‖`** from summing the first over the `φ` family, `abs_innerOp2_le`.

**ALL THREE ARE NOW PROVED BELOW**, and `c` came out as **exactly `normSq2 id`**, *the `½` of
`inner2_self_eq_frobenius` and the `½` of the ordered-pair doubling composing to the `¼` already
inside it*, which is what [r1022](../../../reviews/REVIEW_r1022.md) and
[r1023](../../../reviews/REVIEW_r1023.md) predicted independently from the arithmetic alone.

**ALL THREE ARE ASSEMBLED BELOW**, into `abs_cubicTri_le` on the form and `abs_Pcubic2Quad_le` on
the quadratic part of the increment, *together with `abs_Pcubic2_le` on the cubic part, which both
reviewers of this round observed is ONE REWRITE from `Pcubic2_eq_cubicTri`.* **What separates those
from `HasFDerivAt` is Mathlib's little-`o` machinery and nothing further about this cubic.**
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **THE TRILINEAR FORM THE WHOLE CUBIC IS BUILT FROM**, `⟨X ∘ Y, Z⟩ - ½ Φ(X;Y,Z)`. -/
noncomputable def cubicTri (X Y Z : CurvOp2 ι) : ℝ :=
  innerOp2 (X.comp Y) Z + -(1/2) * phiTri X Y Z

/-- **`P` IS THE FORM ON THE DIAGONAL.** -/
theorem Pcubic2_eq_cubicTri (R : CurvOp2 ι) : Pcubic2 R = cubicTri R R R := by
  unfold cubicTri Pcubic2 trCube2 compOp2
  rw [sharpPair2_eq_phiTri]

/-- **THE QUADRATIC PART IS THE THREE ARRANGEMENTS WITH TWO `H`s.** -/
theorem Pcubic2Quad_eq_cubicTri (R H : CurvOp2 ι) :
    Pcubic2Quad R H = cubicTri H H R + cubicTri H R H + cubicTri R H H := by
  unfold Pcubic2Quad cubicTri compOp2
  ring

/-- **AND THE LINEAR PART IS THE THREE WITH ONE.** -/
theorem Pcubic2Lin_eq_cubicTri (R H : CurvOp2 ι) :
    Pcubic2Lin R H = cubicTri H R R + cubicTri R H R + cubicTri R R H := by
  unfold Pcubic2Lin cubicTri compOp2
  ring

/-! ## Cauchy-Schwarz for the `Λ²` pairing, which the estimate owes

**`inner2` IS A EUCLIDEAN INNER PRODUCT ON MATRIX ENTRIES UP TO A HALF**, `inner2_eq_sum`, *so the
discrete Cauchy-Schwarz applies to it directly and the `½` CANCELS*: it appears once on the left
squared and once in each factor on the right, which is $\tfrac14$ against $\tfrac14$. **So the
inequality carries NO constant**, and the layer had it nowhere.
-/

/-- **CAUCHY-SCHWARZ ON `Λ²`**, with no constant. -/
theorem inner2_sq_le (X Y : Matrix ι ι ℝ) :
    inner2 X Y ^ 2 ≤ inner2 X X * inner2 Y Y := by
  have key : (∑ p : ι × ι, X p.1 p.2 * Y p.1 p.2) ^ 2
      ≤ (∑ p : ι × ι, X p.1 p.2 ^ 2) * ∑ p : ι × ι, Y p.1 p.2 ^ 2 :=
    Finset.sum_mul_sq_le_sq_mul_sq _ _ _
  have e1 : (∑ p : ι × ι, X p.1 p.2 * Y p.1 p.2) = ∑ a : ι, ∑ b : ι, X a b * Y a b :=
    Fintype.sum_prod_type (fun p : ι × ι => X p.1 p.2 * Y p.1 p.2)
  have e2 : (∑ p : ι × ι, X p.1 p.2 ^ 2) = ∑ a : ι, ∑ b : ι, X a b * X a b := by
    rw [Fintype.sum_prod_type (fun p : ι × ι => X p.1 p.2 ^ 2)]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => sq (X a b)
  have e3 : (∑ p : ι × ι, Y p.1 p.2 ^ 2) = ∑ a : ι, ∑ b : ι, Y a b * Y a b := by
    rw [Fintype.sum_prod_type (fun p : ι × ι => Y p.1 p.2 ^ 2)]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => sq (Y a b)
  rw [e1, e2, e3] at key
  rw [inner2_eq_sum, inner2_eq_sum, inner2_eq_sum]
  nlinarith [key]

/-- **AND IN THE FORM THE ESTIMATE USES**, an absolute value against the two self-pairings. -/
theorem abs_inner2_le (X Y : Matrix ι ι ℝ) :
    |inner2 X Y| ≤ Real.sqrt (inner2 X X) * Real.sqrt (inner2 Y Y) := by
  have h := inner2_sq_le X Y
  have hx := inner2_self_nonneg X
  have hy := inner2_self_nonneg Y
  have hprod : Real.sqrt (inner2 X X) * Real.sqrt (inner2 Y Y)
      = Real.sqrt (inner2 X X * inner2 Y Y) := (Real.sqrt_mul hx _).symm
  rw [hprod, ← Real.sqrt_sq_eq_abs]
  exact Real.sqrt_le_sqrt h

/-! ## The bridge to the norm the estimate is stated in

**THE RECORD'S PAIRING AND THE FROBENIUS NORM DIFFER BY EXACTLY A HALF**, `inner2 X X = ‖X‖²/2`,
*the `½` being the one `inner2`'s own definition carries.* **This is what lets a bound proved about
`inner2` be read as a bound in the norm `HasFDerivAt` will be stated in**, and the layer had no
statement relating the two.
-/

open scoped Matrix.Norms.Frobenius in
/-- **`inner2` IS HALF THE SQUARED FROBENIUS NORM.** -/
theorem inner2_self_eq_frobenius (X : Matrix ι ι ℝ) : inner2 X X = ‖X‖ ^ 2 / 2 := by
  have hsum : (0:ℝ) ≤ ∑ i : ι, ∑ j : ι, ‖X i j‖ ^ (2:ℝ) :=
    Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ =>
      Real.rpow_nonneg (_root_.norm_nonneg _) _
  rw [inner2_eq_sum, Matrix.frobenius_norm_def, ← Real.rpow_natCast _ 2, ← Real.rpow_mul hsum]
  norm_num
  rw [Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => (sq (X a b)).symm]
  ring

open scoped Matrix.Norms.Frobenius in
/-- **THE BRACKET IS BOUNDED**, `‖[X,Y]‖ ≤ 2‖X‖‖Y‖` in the Frobenius norm. *`Φ` reads its arguments
through `brS`, so the estimate needs this and the layer had NO norm lemma for the bracket at all*,
only additivity and `smul` ([r1022](../../../reviews/REVIEW_r1022.md),
[r1023](../../../reviews/REVIEW_r1023.md), which found the same gap independently). **The `2` is the
commutator's two terms and is not improvable by this argument.** -/
theorem norm_br_le (X Y : Matrix ι ι ℝ) : ‖br X Y‖ ≤ 2 * (‖X‖ * ‖Y‖) :=
  calc ‖br X Y‖ = ‖X * Y - Y * X‖ := rfl
    _ ≤ ‖X * Y‖ + ‖Y * X‖ := norm_sub_le _ _
    _ ≤ ‖X‖ * ‖Y‖ + ‖Y‖ * ‖X‖ :=
        add_le_add (Matrix.frobenius_norm_mul X Y) (Matrix.frobenius_norm_mul Y X)
    _ = 2 * (‖X‖ * ‖Y‖) := by ring

open scoped Matrix.Norms.Frobenius in
/-- **AND ON `Λ²`**, where `Φ` actually meets it. *The subtype norm is the ambient one by `rfl`.* -/
theorem norm_brS_le (X Y : skewSub ι) : ‖brS X Y‖ ≤ 2 * (‖X‖ * ‖Y‖) :=
  norm_br_le (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)

/-! ## The pairing is bounded by the operator norm, with an explicit constant

**THIS IS THE THIRD OF THE ESTIMATE'S PIECES**, and the constant is not an abstract supremum: it is
`normSq2 id`, *the `½` of `inner2_self_eq_frobenius` and the `½` of `innerOp2`'s ordered-pair
doubling composing to the `¼` already inside it* ([r1022](../../../reviews/REVIEW_r1022.md) and
[r1023](../../../reviews/REVIEW_r1023.md) predicted it independently, and it is what the proof
below produces).
-/

section Bounded

open scoped Matrix.Norms.Frobenius
open scoped HamiltonsCubic.RealLayer.OperatorNorm

/-- **AN OPERATOR MOVES PAST THE PAIRING AT THE COST OF ITS NORM SQUARED.** -/
theorem inner2_apply_self_le (A : CurvOp2 ι) (X : skewSub ι) :
    inner2 ((A X : skewSub ι) : Matrix ι ι ℝ) ((A X : skewSub ι) : Matrix ι ι ℝ)
      ≤ ‖A‖^2 * inner2 (X : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) := by
  rw [inner2_self_eq_frobenius, inner2_self_eq_frobenius]
  have h : ‖A X‖ ≤ ‖A‖ * ‖X‖ := A.le_opNorm X
  have hx : (0:ℝ) ≤ ‖A X‖ := _root_.norm_nonneg _
  have hs : ‖(A X : skewSub ι)‖ = ‖((A X : skewSub ι) : Matrix ι ι ℝ)‖ := rfl
  have hs2 : ‖X‖ = ‖(X : Matrix ι ι ℝ)‖ := rfl
  rw [← hs, ← hs2]
  nlinarith [h, hx, _root_.norm_nonneg A, _root_.norm_nonneg X]

/-- **SO THE PAIRING OF TWO IMAGES IS BOUNDED AT EVERY BIVECTOR**, by Cauchy-Schwarz. -/
theorem abs_inner2_apply_le (A B : CurvOp2 ι) (X : skewSub ι) :
    |inner2 ((A X : skewSub ι) : Matrix ι ι ℝ) ((B X : skewSub ι) : Matrix ι ι ℝ)|
      ≤ ‖A‖ * ‖B‖ * inner2 (X : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) := by
  set x := inner2 (X : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) with hx
  have hxnn : 0 ≤ x := inner2_self_nonneg _
  have hA := inner2_apply_self_le A X
  have hB := inner2_apply_self_le B X
  have h1 := abs_inner2_le ((A X : skewSub ι) : Matrix ι ι ℝ) ((B X : skewSub ι) : Matrix ι ι ℝ)
  have hrA : Real.sqrt (inner2 ((A X : skewSub ι) : Matrix ι ι ℝ) ((A X : skewSub ι) : Matrix ι ι ℝ))
      ≤ ‖A‖ * Real.sqrt x := by
    rw [show ‖A‖ * Real.sqrt x = Real.sqrt (‖A‖^2 * x) by
      rw [Real.sqrt_mul (sq_nonneg _), Real.sqrt_sq (_root_.norm_nonneg A)]]
    exact Real.sqrt_le_sqrt hA
  have hrB : Real.sqrt (inner2 ((B X : skewSub ι) : Matrix ι ι ℝ) ((B X : skewSub ι) : Matrix ι ι ℝ))
      ≤ ‖B‖ * Real.sqrt x := by
    rw [show ‖B‖ * Real.sqrt x = Real.sqrt (‖B‖^2 * x) by
      rw [Real.sqrt_mul (sq_nonneg _), Real.sqrt_sq (_root_.norm_nonneg B)]]
    exact Real.sqrt_le_sqrt hB
  have hsq : Real.sqrt x * Real.sqrt x = x := Real.mul_self_sqrt hxnn
  calc |inner2 ((A X : skewSub ι) : Matrix ι ι ℝ) ((B X : skewSub ι) : Matrix ι ι ℝ)|
      ≤ _ := h1
    _ ≤ (‖A‖ * Real.sqrt x) * (‖B‖ * Real.sqrt x) :=
        mul_le_mul hrA hrB (Real.sqrt_nonneg _) (by positivity)
    _ = ‖A‖ * ‖B‖ * (Real.sqrt x * Real.sqrt x) := by ring
    _ = ‖A‖ * ‖B‖ * x := by rw [hsq]

/-- **AND SUMMING OVER THE `φ` FAMILY GIVES THE BOUND WITH ITS CONSTANT**, `normSq2 id`. *The
identity's own squared norm is what the `φ` family contributes, which is why the constant is an
object the layer already computes rather than a supremum nobody can evaluate.* -/
theorem abs_innerOp2_le (A B : CurvOp2 ι) :
    |innerOp2 A B| ≤ ‖A‖ * ‖B‖ * normSq2 (ContinuousLinearMap.id ℝ (skewSub ι)) := by
  have hid : normSq2 (ContinuousLinearMap.id ℝ (skewSub ι))
      = (1/2) * ∑ i : ι, ∑ j : ι, inner2 (phi i j) (phi i j) := rfl
  have hterm : ∀ i j : ι, |inner2 (applyPhi A i j) (applyPhi B i j)|
      ≤ ‖A‖ * ‖B‖ * inner2 (phi i j) (phi i j) :=
    fun i j => abs_inner2_apply_le A B ⟨phi i j, phi_mem_skewSub i j⟩
  unfold innerOp2
  rw [abs_mul, abs_of_nonneg (by norm_num : (0:ℝ) ≤ 1/2), hid]
  have hsum : |∑ i : ι, ∑ j : ι, inner2 (applyPhi A i j) (applyPhi B i j)|
      ≤ ∑ i : ι, ∑ j : ι, ‖A‖ * ‖B‖ * inner2 (phi i j) (phi i j) := by
    refine (Finset.abs_sum_le_sum_abs _ _).trans (Finset.sum_le_sum fun i _ => ?_)
    exact (Finset.abs_sum_le_sum_abs _ _).trans (Finset.sum_le_sum fun j _ => hterm i j)
  have hfactor : ∑ i : ι, ∑ j : ι, ‖A‖ * ‖B‖ * inner2 (phi i j) (phi i j)
      = ‖A‖ * ‖B‖ * ∑ i : ι, ∑ j : ι, inner2 (phi i j) (phi i j) := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => (Finset.mul_sum _ _ _).symm
  rw [hfactor] at hsum
  nlinarith [hsum, abs_nonneg (∑ i : ι, ∑ j : ι, inner2 (applyPhi A i j) (applyPhi B i j))]


/-! ### The two summands of `cubicTri`, each bounded -/

/-- **CAUCHY-SCHWARZ IN THE FROBENIUS NORM**, the form the `Φ` bound consumes. -/
theorem abs_inner2_le_norm (U V : Matrix ι ι ℝ) : |inner2 U V| ≤ ‖U‖ * ‖V‖ / 2 := by
  have h := inner2_sq_le U V
  rw [inner2_self_eq_frobenius, inner2_self_eq_frobenius] at h
  have hb : (0:ℝ) ≤ ‖U‖ * ‖V‖ / 2 := by positivity
  have ha : (0:ℝ) ≤ |inner2 U V| := abs_nonneg _
  nlinarith [h, sq_abs (inner2 U V), ha, hb]

-- the per-term bound
/-- **ONE SUMMAND OF `Φ`**, bounded through `B`, then the bracket, then the two operators. -/
theorem phiTri_term_le (A B C : CurvOp2 ι) (i j k l : ι) :
    |inner2 ((B (brS (A ⟨phi i j, phi_mem_skewSub i j⟩) (C ⟨phi k l, phi_mem_skewSub k l⟩)) :
        skewSub ι) : Matrix ι ι ℝ)
      ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
        Matrix ι ι ℝ)|
      ≤ 2 * (‖A‖ * ‖B‖ * ‖C‖) * (‖phi i j‖^2 * ‖phi k l‖^2) := by
  set P : skewSub ι := ⟨phi i j, phi_mem_skewSub i j⟩
  set Q : skewSub ι := ⟨phi k l, phi_mem_skewSub k l⟩
  have hU : ‖B (brS (A P) (C Q))‖ ≤ ‖B‖ * (2 * (‖A‖ * ‖P‖ * (‖C‖ * ‖Q‖))) := by
    refine (B.le_opNorm _).trans (mul_le_mul_of_nonneg_left ?_ (_root_.norm_nonneg B))
    refine (norm_brS_le (A P) (C Q)).trans ?_
    have h1 : ‖A P‖ ≤ ‖A‖ * ‖P‖ := A.le_opNorm P
    have h2 : ‖C Q‖ ≤ ‖C‖ * ‖Q‖ := C.le_opNorm Q
    have : ‖A P‖ * ‖C Q‖ ≤ (‖A‖ * ‖P‖) * (‖C‖ * ‖Q‖) :=
      mul_le_mul h1 h2 (_root_.norm_nonneg _) (by positivity)
    linarith
  have hV : ‖brS P Q‖ ≤ 2 * (‖P‖ * ‖Q‖) := norm_brS_le P Q
  have hcs := abs_inner2_le_norm
    ((B (brS (A P) (C Q)) : skewSub ι) : Matrix ι ι ℝ) ((brS P Q : skewSub ι) : Matrix ι ι ℝ)
  have e1 : ‖((B (brS (A P) (C Q)) : skewSub ι) : Matrix ι ι ℝ)‖ = ‖B (brS (A P) (C Q))‖ := rfl
  have e2 : ‖((brS P Q : skewSub ι) : Matrix ι ι ℝ)‖ = ‖brS P Q‖ := rfl
  have ep : ‖P‖ = ‖phi i j‖ := rfl
  have eq2 : ‖Q‖ = ‖phi k l‖ := rfl
  rw [e1, e2] at hcs
  have hgoal : |inner2 ((B (brS (A P) (C Q)) : skewSub ι) : Matrix ι ι ℝ)
      ((brS P Q : skewSub ι) : Matrix ι ι ℝ)|
      ≤ 2 * (‖A‖ * ‖B‖ * ‖C‖) * (‖P‖^2 * ‖Q‖^2) := by
    calc |inner2 ((B (brS (A P) (C Q)) : skewSub ι) : Matrix ι ι ℝ)
            ((brS P Q : skewSub ι) : Matrix ι ι ℝ)|
        ≤ ‖B (brS (A P) (C Q))‖ * ‖brS P Q‖ / 2 := hcs
      _ ≤ (‖B‖ * (2 * (‖A‖ * ‖P‖ * (‖C‖ * ‖Q‖)))) * (2 * (‖P‖ * ‖Q‖)) / 2 := by
          have := mul_le_mul hU hV (_root_.norm_nonneg _) (by positivity)
          linarith
      _ = 2 * (‖A‖ * ‖B‖ * ‖C‖) * (‖P‖^2 * ‖Q‖^2) := by ring
  exact hgoal

/-- The `φ`-family weight the four-fold sum produces. -/
noncomputable def phiWeight (ι : Type*) [Fintype ι] [DecidableEq ι] : ℝ :=
  ∑ i : ι, ∑ j : ι, ‖phi i j‖^2

theorem phiWeight_nonneg : (0:ℝ) ≤ phiWeight ι :=
  Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _

/-- **AND `Φ` ITSELF**, with an explicit constant built from the `φ` family. *The constant is not
claimed sharp: the `2` of each bracket and the fourfold sum are taken at face value.* -/
theorem abs_phiTri_le (A B C : CurvOp2 ι) :
    |phiTri A B C| ≤ (1/2) * phiWeight ι ^ 2 * (‖A‖ * ‖B‖ * ‖C‖) := by
  unfold phiTri
  rw [abs_mul, abs_neg, abs_of_nonneg (by norm_num : (0:ℝ) ≤ 1/4)]
  have hsum : |∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι,
      inner2 ((B (brS (A ⟨phi i j, phi_mem_skewSub i j⟩) (C ⟨phi k l, phi_mem_skewSub k l⟩)) :
          skewSub ι) : Matrix ι ι ℝ)
        ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
          Matrix ι ι ℝ)|
      ≤ ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι,
          2 * (‖A‖ * ‖B‖ * ‖C‖) * (‖phi i j‖^2 * ‖phi k l‖^2) := by
    refine (Finset.abs_sum_le_sum_abs _ _).trans (Finset.sum_le_sum fun i _ => ?_)
    refine (Finset.abs_sum_le_sum_abs _ _).trans (Finset.sum_le_sum fun j _ => ?_)
    refine (Finset.abs_sum_le_sum_abs _ _).trans (Finset.sum_le_sum fun k _ => ?_)
    refine (Finset.abs_sum_le_sum_abs _ _).trans (Finset.sum_le_sum fun l _ => ?_)
    exact phiTri_term_le A B C i j k l
  have hfac : ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι,
      2 * (‖A‖ * ‖B‖ * ‖C‖) * (‖phi i j‖^2 * ‖phi k l‖^2)
      = 2 * (‖A‖ * ‖B‖ * ‖C‖) * (phiWeight ι * phiWeight ι) := by
    unfold phiWeight
    simp only [← Finset.mul_sum, ← Finset.sum_mul]
  rw [hfac] at hsum
  nlinarith [hsum, abs_nonneg (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι,
    inner2 ((B (brS (A ⟨phi i j, phi_mem_skewSub i j⟩) (C ⟨phi k l, phi_mem_skewSub k l⟩)) :
        skewSub ι) : Matrix ι ι ℝ)
      ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
        Matrix ι ι ℝ))]

/-! ### The estimate itself

**THE REMAINDER `HasFDerivAt` CONSUMES IS `Pcubic2Quad R H + Pcubic2 H`, BOTH SUMMANDS**, by
`Pcubic2_expand`, *and an earlier version of this paragraph called the quadratic bound alone the
remainder being `o(‖H‖)`* ([r1024](../../../reviews/REVIEW_r1024.md),
[r1025](../../../reviews/REVIEW_r1025.md)). **Both are bounded here**: the quadratic part at
`O(‖H‖²)` and the cubic part at `O(‖H‖³)`, each with the same explicit constant. *What is still
absent HERE is the `HasFDerivAt` declaration, *which [Frechet.lean](Frechet.lean)'s `hasFDerivAt_Pcubic2` carries.* **A first version said no statement in the tree carried it, and was falsified seven minutes later.**
-/

/-- **THE CONSTANT THE WHOLE CUBIC IS BOUNDED BY.** *Both summands contribute: `normSq2 id` from the
pairing and the `φ`-family weight from `Φ`. **It is not claimed sharp**, the `2` of each bracket and
the fourfold sum being taken at face value.* -/
noncomputable def cubicConst (ι : Type*) [Fintype ι] [DecidableEq ι] : ℝ :=
  normSq2 (ContinuousLinearMap.id ℝ (skewSub ι)) + (1/4) * phiWeight ι ^ 2

/-- **THE TRILINEAR FORM IS BOUNDED**, which is the one fact the collapse above was for. -/
theorem abs_cubicTri_le (X Y Z : CurvOp2 ι) :
    |cubicTri X Y Z| ≤ cubicConst ι * (‖X‖ * ‖Y‖ * ‖Z‖) := by
  unfold cubicTri cubicConst
  have h1 : |innerOp2 (X.comp Y) Z|
      ≤ normSq2 (ContinuousLinearMap.id ℝ (skewSub ι)) * (‖X‖ * ‖Y‖ * ‖Z‖) := by
    refine (abs_innerOp2_le (X.comp Y) Z).trans ?_
    have hc : ‖X.comp Y‖ ≤ ‖X‖ * ‖Y‖ := X.opNorm_comp_le Y
    have hn : (0:ℝ) ≤ normSq2 (ContinuousLinearMap.id ℝ (skewSub ι)) := by
      show (0:ℝ) ≤ (1/2) * ∑ i : ι, ∑ j : ι, inner2 (applyPhi _ i j) (applyPhi _ i j)
      have : (0:ℝ) ≤ ∑ i : ι, ∑ j : ι, inner2 (applyPhi
          (ContinuousLinearMap.id ℝ (skewSub ι)) i j) (applyPhi
          (ContinuousLinearMap.id ℝ (skewSub ι)) i j) :=
        Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => inner2_self_nonneg _
      linarith
    have hz : (0:ℝ) ≤ ‖Z‖ := _root_.norm_nonneg Z
    have step : ‖X.comp Y‖ * ‖Z‖ ≤ ‖X‖ * ‖Y‖ * ‖Z‖ := mul_le_mul_of_nonneg_right hc hz
    nlinarith [step, hn]
  have h2 : |(-(1/2) : ℝ) * phiTri X Y Z| ≤ (1/4) * phiWeight ι ^ 2 * (‖X‖ * ‖Y‖ * ‖Z‖) := by
    rw [abs_mul, abs_neg, abs_of_nonneg (by norm_num : (0:ℝ) ≤ 1/2)]
    have := abs_phiTri_le X Y Z
    linarith
  calc |innerOp2 (X.comp Y) Z + -(1/2) * phiTri X Y Z|
      ≤ |innerOp2 (X.comp Y) Z| + |(-(1/2) : ℝ) * phiTri X Y Z| := _root_.abs_add_le _ _
    _ ≤ _ := by linarith [h1, h2]

/-- **AND SO IS THE QUADRATIC PART OF THE INCREMENT**, `|Q_R(H)| ≤ 3c‖R‖‖H‖²`. *The three is the
three arrangements with two `H`s, which `Pcubic2Quad_eq_cubicTri` names.* -/
theorem abs_Pcubic2Quad_le (R H : CurvOp2 ι) :
    |Pcubic2Quad R H| ≤ 3 * cubicConst ι * ‖R‖ * ‖H‖^2 := by
  rw [Pcubic2Quad_eq_cubicTri]
  have a := abs_cubicTri_le H H R
  have b := abs_cubicTri_le H R H
  have c := abs_cubicTri_le R H H
  calc |cubicTri H H R + cubicTri H R H + cubicTri R H H|
      ≤ |cubicTri H H R + cubicTri H R H| + |cubicTri R H H| := _root_.abs_add_le _ _
    _ ≤ |cubicTri H H R| + |cubicTri H R H| + |cubicTri R H H| := by
        linarith [_root_.abs_add_le (cubicTri H H R) (cubicTri H R H)]
    _ ≤ 3 * cubicConst ι * ‖R‖ * ‖H‖^2 := by nlinarith [a, b, c]


/-- **THE CUBIC PART OF THE REMAINDER, BOUNDED THE SAME WAY.** *Both reviewers of this round
observed that it is ONE REWRITE from `Pcubic2_eq_cubicTri`, and that the two declarations sat far
apart with nothing joining them* ([r1024](../../../reviews/REVIEW_r1024.md),
[r1025](../../../reviews/REVIEW_r1025.md)). **With `abs_Pcubic2Quad_le` this bounds the WHOLE
remainder of `Pcubic2_expand`**, which is what the Fréchet statement needs. -/
theorem abs_Pcubic2_le (H : CurvOp2 ι) :
    |Pcubic2 H| ≤ cubicConst ι * (‖H‖ * ‖H‖ * ‖H‖) := by
  rw [Pcubic2_eq_cubicTri]
  exact abs_cubicTri_le H H H

/-- **AND THE `φ`-FAMILY WEIGHT IS FOUR TIMES `normSq2 id`**, so `cubicConst` is a function of ONE
quantity rather than two. *[r1025](../../../reviews/REVIEW_r1025.md) found this, the docstring above
reading as two independent contributions.* -/
theorem phiWeight_eq (ι : Type*) [Fintype ι] [DecidableEq ι] :
    phiWeight ι = 4 * normSq2 (ContinuousLinearMap.id ℝ (skewSub ι)) := by
  unfold phiWeight normSq2 innerOp2
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [show applyPhi (ContinuousLinearMap.id ℝ (skewSub ι)) i j = phi i j from rfl,
    inner2_self_eq_frobenius]
  ring

end Bounded

/-! ## The form is trilinear

*`innerOp2` is bilinear, `ContinuousLinearMap.comp` is bilinear, and `phiTri` is trilinear, each
already on file, so every clause below is a rewrite.*
-/

theorem cubicTri_add_left (X X' Y Z : CurvOp2 ι) :
    cubicTri (X + X') Y Z = cubicTri X Y Z + cubicTri X' Y Z := by
  unfold cubicTri
  rw [ContinuousLinearMap.add_comp, innerOp2_add_left, phiTri_add_left]
  ring

theorem cubicTri_add_mid (X Y Y' Z : CurvOp2 ι) :
    cubicTri X (Y + Y') Z = cubicTri X Y Z + cubicTri X Y' Z := by
  unfold cubicTri
  rw [ContinuousLinearMap.comp_add, innerOp2_add_left, phiTri_add_mid]
  ring

theorem cubicTri_add_right (X Y Z Z' : CurvOp2 ι) :
    cubicTri X Y (Z + Z') = cubicTri X Y Z + cubicTri X Y Z' := by
  unfold cubicTri
  rw [innerOp2_add_right, phiTri_add_right]
  ring

theorem cubicTri_smul_left (c : ℝ) (X Y Z : CurvOp2 ι) :
    cubicTri (c • X) Y Z = c * cubicTri X Y Z := by
  unfold cubicTri
  rw [ContinuousLinearMap.smul_comp, innerOp2_smul_left, phiTri_smul_left]
  ring

theorem cubicTri_smul_mid (c : ℝ) (X Y Z : CurvOp2 ι) :
    cubicTri X (c • Y) Z = c * cubicTri X Y Z := by
  unfold cubicTri
  rw [ContinuousLinearMap.comp_smul, innerOp2_smul_left, phiTri_smul_mid]
  ring

theorem cubicTri_smul_right (c : ℝ) (X Y Z : CurvOp2 ι) :
    cubicTri X Y (c • Z) = c * cubicTri X Y Z := by
  unfold cubicTri
  rw [innerOp2_smul_right, phiTri_smul_right]
  ring

end HamiltonsCubic.RealLayer
