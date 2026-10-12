import Mathlib

/-!
# The Weyl tensor over `ℝ`, at general `n`

**Why this file exists.** [Bivectors.lean](Bivectors.lean), [Curvature.lean](Curvature.lean) and
[QPGeneral.lean](QPGeneral.lean) build the same objects over `ℚ`. That scalar is load-bearing
there, nine files in this folder discharge concrete anchors by `native_decide`, which needs
decidable arithmetic, and it is also why the programme's own quantity cannot be stated: `θ` is
`P(W)/‖W‖³`, and `‖W‖` is not rational. *The record's own witness is `g₁₂ = ⅙√(5/11)`.*

**So the reals get their own file rather than a refactor.** Generalising the scalar in place would
touch every call site of `phi`, whose scalar is not inferable from its arguments, and would have to
carry the `native_decide` anchors along. This file duplicates four primitives and builds upward;
the `ℚ` layer is untouched.

**What it buys.** Of the numbered results with a Lean file and no typed statement, the largest
group is blocked on exactly this: a Weyl tensor over `ℝ` at general `n`, with `P`, `‖·‖` and `θ`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

noncomputable section

/-! ## The bivector primitives, over `ℝ` -/

/-- A bivector is a skew-symmetric matrix. -/
def IsSkew (X : Matrix ι ι ℝ) : Prop := Xᵀ = -X

/-- The `Λ²` inner product, `½ tr(Xᵀ Y)`. **The `½` lives here**, and the choice matters: under
plain Frobenius the basis bivector below has norm `2`, and reading `θ` under that convention
inflates it by `√2`. -/
def inner2 (X Y : Matrix ι ι ℝ) : ℝ := (1 / 2) * (Xᵀ * Y).trace

/-- The bracket on `𝔰𝔬(n)`. -/
def br (X Y : Matrix ι ι ℝ) : Matrix ι ι ℝ := X * Y - Y * X

/-- The basis bivector `φ_{ij}`: entry `-1` at `(i,j)` and `+1` at `(j,i)`. -/
def phi (i j : ι) : Matrix ι ι ℝ := Matrix.single j i 1 - Matrix.single i j 1

theorem phi_isSkew (i j : ι) : IsSkew (phi i j) := by
  unfold IsSkew phi
  simp [Matrix.transpose_sub, Matrix.transpose_single]

theorem phi_swap (i j : ι) : phi j i = -phi i j := by unfold phi; abel

theorem phi_self (i : ι) : phi i i = 0 := by unfold phi; abel

/-! ### The `φ` basis resolves a bivector -/

/-- The pairing written entrywise, which is Frobenius with the `½`. -/
theorem inner2_eq_sum (X Y : Matrix ι ι ℝ) :
    inner2 X Y = (1/2) * ∑ a : ι, ∑ b : ι, X a b * Y a b := by
  unfold inner2 Matrix.trace
  congr 1
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun a _ => ?_
  simp [Matrix.mul_apply, Matrix.diag]

/-- **`⟨Y, φᵢⱼ⟩ = -Yᵢⱼ` on a skew `Y`.** -/
theorem inner2_phi (Y : Matrix ι ι ℝ) (hY : IsSkew Y) (i j : ι) :
    inner2 Y (phi i j) = - Y i j := by
  have hji : Y j i = - Y i j := by
    have := congrFun (congrFun hY i) j
    simpa [Matrix.transpose_apply] using this
  rw [inner2_eq_sum]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, mul_sub, Finset.sum_sub_distrib]
  simp [ite_and, Finset.sum_ite_eq, hji]
  ring

/-- **The `φ` family resolves a skew matrix**, with the ordered-pair doubling that every sum in
this file carries. *This is what makes `sharpOp` and `sharpPair` the same normalisation.* -/
theorem skew_expand (Y : Matrix ι ι ℝ) (hY : IsSkew Y) :
    (1/2 : ℝ) • (∑ i : ι, ∑ j : ι, (inner2 Y (phi i j)) • phi i j) = Y := by
  have hji : ∀ i j : ι, Y j i = - Y i j := by
    intro i j
    have := congrFun (congrFun hY i) j
    simpa [Matrix.transpose_apply] using this
  ext a b
  rw [Matrix.smul_apply]
  rw [show ((∑ i : ι, ∑ j : ι, (inner2 Y (phi i j)) • phi i j) a b)
        = ∑ i : ι, ∑ j : ι, (inner2 Y (phi i j)) * (phi i j a b) by
      simp [Matrix.sum_apply, Matrix.smul_apply]]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply]
  simp [ite_and, Finset.sum_ite_eq, Finset.sum_sub_distrib, mul_sub]
  have h1 : inner2 Y (phi b a) = - Y b a := inner2_phi Y hY b a
  have h2 : inner2 Y (phi a b) = - Y a b := inner2_phi Y hY a b
  simp only [phi] at h1 h2
  rw [h1, h2]
  linarith [hji a b]

/-! ## Curvature as a map on bivectors -/

/-- `⟨R# η, η⟩`. The `¼` is the `½` of the definition times the `½` paying for the ordered-pair
double count. -/
def sharpQF (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) : ℝ :=
  -(1/4) * ∑ i : ι, ∑ j : ι, inner2 (br η (R (br η (R (phi i j))))) (phi i j)

/-- The Ricci contraction. -/
def Ric (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (a b : ι) : ℝ :=
  ∑ c : ι, inner2 (R (phi a c)) (phi b c)

/-- First Bianchi, one number per four indices. -/
def bianchi (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) : ℝ :=
  inner2 (R (phi i j)) (phi k l) + inner2 (R (phi i k)) (phi l j)
    + inner2 (R (phi i l)) (phi j k)

/-- **`𝒲ₙ`, over `ℝ`.**

**The first clause (that `R` maps bivectors to bivectors), is load-bearing and was once absent.**
*Without it the definition constrains `R` only through `inner2 (R X) Y` at SKEW `Y`, so a
symmetric-valued map is invisible to all three remaining clauses while `normSq`, `trCube` and
`innerOp` see it in full.* **An audit built such an operator at `n = 5`**: linear, satisfying every
other clause, unit norm, and `Pcubic = 3` against the record's `√(3/2)`, *and `Pcubic` is unbounded
on that set, so `ProblemP` was a false proposition.* **A hypothesis in a `∀` is not a description of
the objects studied; it is the range of the quantifier, and the unstudied objects are what falsify.**

*The symmetry clause is quantified over bivectors rather than over all matrices*: the pair-basis
coordinates represent a matrix faithfully only when it is skew. -/
def IsWeyl (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  (∀ X, IsSkew X → IsSkew (R X)) ∧
  (∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) ∧
  (∀ i j k l, bianchi R i j k l = 0) ∧
  (∀ a b, Ric R a b = 0)

/-! ## The cubic form, the norm, and `θ` -/

/-- The `Λ²` pairing of two curvature operators, with the ordered-pair doubling. -/
def innerOp (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ :=
  (1/2) * ∑ i : ι, ∑ j : ι, inner2 (R (phi i j)) (S (phi i j))

/-- `R ∘ R`, which is `R²` in the operator reading. -/
def compOp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => R (R X)

/-- `⟨R², R⟩`, which is `tr R³`. -/
def trCube (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := innerOp (compOp R) R

/-- **`⟨R# X, Y⟩`, recovered from the quadratic form by polarisation**, the device
[Sharp.lean](Sharp.lean)'s `sharpMat` uses at `n = 4`, here on bivectors directly rather than on a
pair basis. *`R#` is self-adjoint, so the symmetric polarisation is the whole of it.* -/
def sharpBil (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (X Y : Matrix ι ι ℝ) : ℝ :=
  (1/2) * (sharpQF R (X + Y) - sharpQF R X - sharpQF R Y)

/-- **`R#` AS AN OPERATOR**, expanded in the `φ` basis with the ordered-pair doubling.
*`sharpBil R X (φ_{ij})` is the `φ_{ij}` coordinate of `R# X`, so this reassembles the vector from
its coordinates.* -/
def sharpOp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => (1/2 : ℝ) • ∑ i : ι, ∑ j : ι, (sharpBil R X (phi i j) : ℝ) • (phi i j)

/-- **`⟨R, R#⟩`, written the way the record writes it**, the pairing of `R` against the operator
`R#`, rather than a sum of `R#`'s coordinates against `R`'s.

*The two agree when `sharpBil R X` is linear in its second slot, which needs `R` linear; taking the
operator form as the definition means `P = ⟨R, Q(R)⟩` holds without that hypothesis, and moves the
linearity question to where it belongs, whether `sharpOp` is `R#`, which is a fact about `#` and
not about `P`.*

**Summing `sharpQF R φ` over the basis would instead contract the two `η` slots and return
`tr(R#)`, quadratic in `R` where this is cubic.** *Both this file and
[QPGeneral.lean](QPGeneral.lean) carried that shape and both are repaired.* -/
def sharpPair (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := innerOp R (sharpOp R)

/-- **`P(R) = ⟨R, R² + R#⟩`**, the cubic form the programme maximises. -/
def Pcubic (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := trCube R + sharpPair R

/-- **`‖R‖² = ⟨R, R⟩`.** -/
def normSq (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := innerOp R R

/-- **`‖R‖`.** *This is the definition the `ℚ` layer cannot carry, and the reason this file is
over `ℝ`.* -/
def norm (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := Real.sqrt (normSq R)

/-- **`θ(R) = P(R)/‖R‖³`**, the quantity the conjecture is about. -/
def theta (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := Pcubic R / norm R ^ 3

/-! ## `R#` as an operator, `Q`, and Problem P

*Every consumer so far could name `P` and `θ` and could not name `Q`, the map the problem is
actually about. These give it, by expanding `R# X` in the basis the pairing already uses.*
-/

/-- **Hamilton's map `Q(R) = R² + R#`.** -/
def Qop (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => compOp R X + sharpOp R X

/-- **`R` is a critical point of `P` on the unit sphere with multiplier `θ`**, the eigen-equation
`Q(R) = θ R`, read on bivectors. -/
def IsCritical (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (th : ℝ) : Prop :=
  ∀ i j, Qop R (phi i j) = th • R (phi i j)

/-- **PROBLEM P, stated.** *For `n ≥ 12`, `P` on the unit sphere of `𝒲ₙ` is maximised on the Weyl
tensor of a product of spheres.* Here the competitor is left as a predicate `IsSphereProduct`,
because the layer does not construct the family, **so this is the shape of the problem and not a
theorem about a named object**, and it is recorded that way. -/
def ProblemP (IsSphereProduct : (Matrix ι ι ℝ → Matrix ι ι ℝ) → Prop) : Prop :=
  12 ≤ Fintype.card ι →
  ∀ R : Matrix ι ι ℝ → Matrix ι ι ℝ, IsWeyl R → normSq R = 1 →
    ∃ S : Matrix ι ι ℝ → Matrix ι ι ℝ,
      IsWeyl S ∧ normSq S = 1 ∧ IsSphereProduct S ∧ Pcubic R ≤ Pcubic S

/-! ## What is proved -/

theorem Pcubic_eq (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Pcubic R = trCube R + sharpPair R := rfl

/-- **THE LAYER'S OWN COHERENCE OBLIGATION, AND IT IS OWED.** The record defines `P(W)` as
`⟨W, Q(W)⟩`; this file defines `Pcubic` as `tr R³ + ⟨R#, R⟩` and `Qop` as `R² + R#` separately, so
the two must agree. *They agree iff `sharpOp` reassembles `R# X` with the same normalisation
`sharpPair` uses, which is exactly the factor this layer got wrong once already.*

**Nothing that reads `Qop` against `Pcubic` is safe until this is discharged**, and it carries a
`sorry` rather than a binder because it is this layer's own claim and not a classical one. -/
theorem inner2_comm (X Y : Matrix ι ι ℝ) : inner2 X Y = inner2 Y X := by
  rw [inner2_eq_sum, inner2_eq_sum]
  congr 1
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => mul_comm _ _

theorem inner2_add_right (X A B : Matrix ι ι ℝ) :
    inner2 X (A + B) = inner2 X A + inner2 X B := by
  simp only [inner2_eq_sum, Matrix.add_apply, mul_add]
  rw [← mul_add]
  congr 1
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_add_distrib

/-- **`innerOp` is additive in its second argument**, since `inner2` is. -/
theorem innerOp_add_right (R S T : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    innerOp R (fun X => S X + T X) = innerOp R S + innerOp R T := by
  unfold innerOp
  rw [← mul_add]
  congr 1
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun j _ => inner2_add_right _ _ _

/-- **`innerOp` is symmetric**, since `inner2` is. -/
theorem innerOp_comm (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) : innerOp R S = innerOp S R := by
  unfold innerOp
  congr 1
  exact Finset.sum_congr rfl fun i _ =>
    Finset.sum_congr rfl fun j _ => inner2_comm _ _

theorem Pcubic_eq_inner_Qop (R : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    Pcubic R = innerOp R (Qop R) := by
  unfold Pcubic Qop sharpPair trCube
  rw [innerOp_add_right, innerOp_comm (compOp R) R]

/-! ### What this rests on, and what it moved

**`P = ⟨R, Q(R)⟩` holds with no hypothesis on `R`, and it is a TAUTOLOGY rather than a check.**
*`sharpPair` is defined as `innerOp R (sharpOp R)` and `Qop` as `compOp R + sharpOp R`, so the
theorem is `innerOp`'s additivity and symmetry and cannot fail for any `R`, wrong normalisation
included.* **An earlier definition summed `sharpQF R φ` over the basis, which returns `tr(R#)`,
quadratic where `P` is cubic, and the identity DID fail there.** So the redefinition fixed a real
defect and dissolved the only cross-check the layer had on `#`.

**What is owed, and it is not visible here**: that `sharpOp R X` is `R# X`, which needs
`sharpBil R X` linear in its second slot, hence `R` linear. *`sharpQF R η = -½ tr(ad_η R ad_η R)`
is quadratic in `η` only then.*

**AND THE RECORD'S OWN ANCHOR ON ANY `#` FORMULA IS ABSENT FROM THIS LAYER**: `id# = (n-2)·id`.
[Sharp.lean](Sharp.lean) discharges it at `n = 4` by `native_decide`; this file's `-¼` over ordered
pairs is `2×` that file's `-½` over the six basis bivectors, so the normalisation agrees, *through
a coincidence of shape no file records, rather than through a check.*
-/

/-- **The zero operator has zero cubic form**, the sanity check any such definition owes. -/
theorem Pcubic_zero : Pcubic (ι := ι) (fun _ => 0) = 0 := by
  simp [Pcubic, trCube, sharpPair, sharpBil, innerOp, compOp, sharpQF, inner2, br]

theorem normSq_zero : normSq (ι := ι) (fun _ => 0) = 0 := by
  simp [normSq, innerOp, inner2]

theorem norm_nonneg (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : 0 ≤ norm R := Real.sqrt_nonneg _

/-- **The bracket is linear in its second argument at a sign**: `br η (-Z) = -br η Z`. -/
theorem br_neg (η Z : Matrix ι ι ℝ) : br η (-Z) = -br η Z := by
  unfold br; simp [Matrix.mul_neg, Matrix.neg_mul]; abel

/-- **`sharpQF` (the QUADRATIC FORM, not `sharpPair`), is even in `R`** for linear `R`, since `R`
enters it exactly twice.

**This says nothing against `sharpPair` or `Pcubic` below, which are cubic and are the record's
`⟨R#, R⟩` and `P`.** *It is kept because it is the fact that exposed an earlier defect: a file that
summed this form over the basis got `tr(R#)` and called it `⟨R#, R⟩`, and a term of `P` must be
odd. Both files that did so are repaired.* -/
theorem sharpQF_neg (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hlin : ∀ X, R (-X) = -R X)
    (η : Matrix ι ι ℝ) : sharpQF (fun X => -R X) η = sharpQF R η := by
  unfold sharpQF
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  simp only [br_neg, hlin, neg_neg]

/-- **`‖·‖² ` is even**, the other half of the oddness of `θ`. -/
theorem normSq_neg (R : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    normSq (fun X => -R X) = normSq R := by
  simp only [normSq, innerOp, inner2, Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg,
             neg_neg, Matrix.trace_neg]

end

end HamiltonsCubic.RealLayer
