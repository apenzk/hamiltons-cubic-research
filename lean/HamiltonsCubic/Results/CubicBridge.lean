import HamiltonsCubic.Results.TensorBridge

set_option linter.style.longLine false

/-!
# [I36](../../../plan.md): the cubic form of an extended operator IS the native one

**[TensorBridge.lean](TensorBridge.lean) carries the NORM across and stops there**, `normSq_extend`,
which leaves `I36Shape`'s other two hypotheses, the value of `Pcubic2` and local maximality of it,
saying nothing about the record's `Pcubic`. *A statement about a layer nobody has tied to the
record is a statement about that layer.* **[r1010](../../../reviews/REVIEW_r1010.md) recorded the
absence**; this file removes it.

**WHAT IT TAKES IS `br_mem_skewSub` AND `extend_apply`, AND NOT `IsWeyl2`.** *The bracket of two
skew matrices is skew, so every intermediate value of `sharpQF`'s double bracket is already a
bivector, and the extension is the identity on those.* **So the two forms agree at EVERY continuous
operator on `Λ²`**, not only at the Weyl ones, which is the strongest form available and the one
that makes the tie unconditional.
-/

namespace HamiltonsCubic.TensorBridge

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

open scoped Matrix.Norms.Frobenius

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The extension of a bracket is the bracket of the extensions**, the step everything below
runs on. -/
theorem extend_brS (R : CurvOp2 ι) (X Y : skewSub ι) :
    extend R (br (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ))
      = ((R (brS X Y) : skewSub ι) : Matrix ι ι ℝ) :=
  extend_apply R (brS X Y)

/-- **`sharpQF` OF THE EXTENSION IS `sharpQF2`**, at every bivector. -/
theorem sharpQF_extend (R : CurvOp2 ι) (η : skewSub ι) :
    sharpQF (extend R) (η : Matrix ι ι ℝ) = sharpQF2 R η := by
  unfold sharpQF sharpQF2
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  congr 1
  rw [show extend R (phi i j) = ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) from
    extend_apply R ⟨phi i j, phi_mem_skewSub i j⟩]
  rw [extend_brS R η (R ⟨phi i j, phi_mem_skewSub i j⟩)]
  rfl

/-- **And `sharpBil` with it**, the polarisation being taken inside `Λ²` either way. -/
theorem sharpBil_extend (R : CurvOp2 ι) (X Y : skewSub ι) :
    sharpBil (extend R) (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)
      = sharpBil2 R X Y := by
  unfold sharpBil sharpBil2
  rw [← Submodule.coe_add, sharpQF_extend, sharpQF_extend, sharpQF_extend]

/-- **`R#` OF THE EXTENSION IS `sharpMap`**, on `Λ²`. -/
theorem sharpOp_extend (R : CurvOp2 ι) (X : skewSub ι) :
    sharpOp (extend R) (X : Matrix ι ι ℝ)
      = ((sharpMap R X : skewSub ι) : Matrix ι ι ℝ) := by
  have key : (∑ i : ι, ∑ j : ι,
        (sharpBil (extend R) (X : Matrix ι ι ℝ) (phi i j)) • (phi i j))
      = (((∑ i : ι, ∑ j : ι,
        (sharpBil2 R X ⟨phi i j, phi_mem_skewSub i j⟩) •
          (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι)) : skewSub ι)
        : Matrix ι ι ℝ) := by
    simp only [AddSubmonoidClass.coe_finsetSum, Submodule.coe_smul]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    congr 1
    exact sharpBil_extend R X ⟨phi i j, phi_mem_skewSub i j⟩
  unfold sharpOp sharpMap
  rw [Submodule.coe_smul, key]

/-- **`⟨R, R#⟩` OF THE EXTENSION IS `sharpPair2`.** -/
theorem sharpPair_extend (R : CurvOp2 ι) :
    sharpPair (extend R) = sharpPair2 R := by
  unfold sharpPair sharpPair2 innerOp
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  have hs : sharpOp (extend R) (phi i j)
      = ((sharpMap R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) :=
    sharpOp_extend R ⟨phi i j, phi_mem_skewSub i j⟩
  rw [show extend R (phi i j) = applyPhi R i j from
      extend_apply R ⟨phi i j, phi_mem_skewSub i j⟩, hs]

/-- **`⟨R², R⟩` OF THE EXTENSION IS `trCube2`**, *which is `tr R³` at a self-adjoint `R`.* -/
theorem trCube_extend (R : CurvOp2 ι) :
    trCube (extend R) = trCube2 R := by
  unfold trCube trCube2 innerOp innerOp2 compOp compOp2
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [show extend R (phi i j) = ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) from
    extend_apply R ⟨phi i j, phi_mem_skewSub i j⟩]
  rw [extend_apply R (R ⟨phi i j, phi_mem_skewSub i j⟩)]
  rfl

/-- **THE CUBIC FORM CROSSES**, `P(extend R) = Pcubic2 R`, *which is what ties `I36Shape`'s value
hypothesis to the quantity the conjecture is about.* -/
theorem Pcubic_extend (R : CurvOp2 ι) :
    Pcubic (extend R) = Pcubic2 R := by
  unfold Pcubic Pcubic2
  rw [trCube_extend, sharpPair_extend]

/-- **AND `θ` WITH IT**, the norm having crossed already. -/
theorem theta_extend (R : CurvOp2 ι) :
    HamiltonsCubic.RealLayer.theta (extend R) = theta2 R := by
  unfold HamiltonsCubic.RealLayer.theta theta2 HamiltonsCubic.RealLayer.norm
  rw [Pcubic_extend, normSq_extend]

/-- **HAMILTON'S MAP CROSSES**, on `Λ²`. -/
theorem Qop_extend (R : CurvOp2 ι) (X : skewSub ι) :
    Qop (extend R) (X : Matrix ι ι ℝ)
      = ((Qop2 R X : skewSub ι) : Matrix ι ι ℝ) := by
  unfold Qop compOp
  rw [extend_apply R X, extend_apply R (R X), sharpOp_extend]
  rfl

/-- **THE EIGEN-EQUATION AT THE ZERO OPERATOR**, at every multiplier and every `n`. *This is why
inhabitation is not the interesting question.* -/
theorem isCritical2_zero (th : ℝ) : IsCritical2 (0 : CurvOp2 ι) th := by
  have hq : sharpMap (0 : CurvOp2 ι) = fun _ => 0 := by
    funext X
    have hb : ∀ Y Z : skewSub ι, sharpBil2 (0 : CurvOp2 ι) Y Z = 0 := by
      intro Y Z
      have hqf : ∀ eta : skewSub ι, sharpQF2 (0 : CurvOp2 ι) eta = 0 := by
        intro eta
        unfold sharpQF2
        have : ∀ i j : ι,
            inner2 ((brS eta ((0 : CurvOp2 ι) (brS eta ((0 : CurvOp2 ι)
              ⟨phi i j, phi_mem_skewSub i j⟩))) : skewSub ι) : Matrix ι ι ℝ)
              (phi i j) = 0 := by
          intro i j
          have hz : ((brS eta ((0 : CurvOp2 ι) (brS eta ((0 : CurvOp2 ι)
              ⟨phi i j, phi_mem_skewSub i j⟩))) : skewSub ι) : Matrix ι ι ℝ) = 0 := by
            show br (eta : Matrix ι ι ℝ) _ = 0
            simp [br]
          rw [hz]
          simp [inner2]
        have hb0 : brS eta (0 : skewSub ι) = 0 := by
          refine Subtype.ext ?_
          show br (eta : Matrix ι ι ℝ) (0 : Matrix ι ι ℝ) = 0
          simp [br]
        simp [this, hb0, inner2]
      unfold sharpBil2
      rw [hqf, hqf, hqf]
      ring
    unfold sharpMap
    simp [hb]
  refine ContinuousLinearMap.ext fun X => ?_
  show (0 : CurvOp2 ι) ((0 : CurvOp2 ι) X) + sharpMapCL (0 : CurvOp2 ι) X
      = (th • (0 : CurvOp2 ι)) X
  show (0 : CurvOp2 ι) ((0 : CurvOp2 ι) X) + sharpMap (0 : CurvOp2 ι) X
      = th • ((0 : CurvOp2 ι) X)
  rw [hq]
  simp

/-- **AND SO DOES CRITICALITY**, *which is the point of the chain: a critical point of the cubic
form on `Λ²` is a critical point in the record's own sense, so an argument run over `CurvOp2` says
something about the objects the conjecture is about.* -/
theorem isCritical_extend {R : CurvOp2 ι} {th : ℝ} (h : IsCritical2 R th) :
    IsCritical (extend R) th := by
  intro i j
  have hx := Qop_extend R ⟨phi i j, phi_mem_skewSub i j⟩
  rw [hx, h]
  rw [show ((th • R : CurvOp2 ι) ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι)
      = th • (R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) from rfl,
    Submodule.coe_smul,
    show extend R (phi i j) = ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) from
      extend_apply R ⟨phi i j, phi_mem_skewSub i j⟩]

/-- **AND THE CONVERSE HOLDS**, *which the layer had not written*
([r1012](../../../reviews/REVIEW_r1012.md)). `Qop2 R - th • R` is linear by its type, the record's
`IsCritical` says it kills every `φ_ij`, and `eq_zero_of_phi` says a linear map out of `Λ²` that
kills the `φ` family is zero. -/
theorem isCritical2_of_extend {R : CurvOp2 ι} {th : ℝ} (h : IsCritical (extend R) th) :
    IsCritical2 R th := by
  have hz : ((Qop2 R : CurvOp2 ι) - th • R : CurvOp2 ι) = 0 := by
    have hl : ((Qop2 R : CurvOp2 ι) - th • R).toLinearMap = 0 := by
      refine eq_zero_of_phi _ fun i j => ?_
      refine Subtype.ext ?_
      have hx := h i j
      rw [Qop_extend R ⟨phi i j, phi_mem_skewSub i j⟩] at hx
      rw [show extend R (phi i j)
          = ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) from
        extend_apply R ⟨phi i j, phi_mem_skewSub i j⟩] at hx
      show ((Qop2 R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ)
          - th • ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) = 0
      rw [hx]
      simp
    exact ContinuousLinearMap.coe_injective (by simpa using hl)
  exact sub_eq_zero.mp hz

/-- **SO THE TWO CRITICALITIES ARE THE SAME CONDITION.** -/
theorem isCritical_extend_iff {R : CurvOp2 ι} {th : ℝ} :
    IsCritical2 R th ↔ IsCritical (extend R) th :=
  ⟨isCritical_extend, isCritical2_of_extend⟩

/-! ## A NONZERO solution of the eigen-equation, and it is not a Weyl operator

**INHABITATION IS FREE AND A FIRST VERSION OF THIS SECTION CLAIMED IT WAS THE POINT**
([r1012](../../../reviews/REVIEW_r1012.md)): *`isCritical2_zero` below holds at EVERY multiplier
and every `n`, so "a predicate nobody can satisfy" was never the risk.* **What is worth having is a
NONZERO solution at a determined multiplier**, and the record's own anchor supplies one: `sharpOp_id`
says `id# = (n-2)\,id` at every bivector, so `Q(id) = (n-1)\,id`.

**AND THAT WITNESS IS NOT `IsWeyl2`**, its Ricci clause returning `n-1` rather than `0`
([r1011](../../../reviews/REVIEW_r1011.md)). *So the pair says the equation has a nonzero solution
and says NOTHING about whether a WEYL operator has one*, which is a different question and is what
[I36](../../../plan.md) is about.
-/

/-- **`sharpQF2` at the bundled identity IS the record's at the bare one**, by definition. -/
theorem sharpQF2_id (eta : skewSub ι) :
    sharpQF2 (ContinuousLinearMap.id ℝ (skewSub ι)) eta
      = sharpQF (fun Z => Z) (eta : Matrix ι ι ℝ) := rfl

/-- **So `R#` at the identity is `(n-2)` times it**, the record's normalisation anchor, on `Λ²`. -/
theorem sharpMap_id (X : skewSub ι) :
    ((sharpMap (ContinuousLinearMap.id ℝ (skewSub ι)) X : skewSub ι) : Matrix ι ι ℝ)
      = ((Fintype.card ι : ℝ) - 2) • (X : Matrix ι ι ℝ) := by
  have hco : ((sharpMap (ContinuousLinearMap.id ℝ (skewSub ι)) X : skewSub ι) : Matrix ι ι ℝ)
      = sharpOp (fun Z => Z) (X : Matrix ι ι ℝ) := by
    unfold sharpMap sharpOp
    simp only [Submodule.coe_smul, AddSubmonoidClass.coe_finsetSum]
    rfl
  rw [hco, sharpOp_id (X : Matrix ι ι ℝ) X.2]

/-- **THE IDENTITY IS A CRITICAL POINT**, with multiplier `n-1`. *This is what makes
`isCritical_extend` a statement about something.* -/
theorem isCritical2_id : IsCritical2 (ContinuousLinearMap.id ℝ (skewSub ι)) ((Fintype.card ι : ℝ) - 1) := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  show ((ContinuousLinearMap.id ℝ (skewSub ι) (ContinuousLinearMap.id ℝ (skewSub ι) X) : skewSub ι) : Matrix ι ι ℝ)
      + ((sharpMap (ContinuousLinearMap.id ℝ (skewSub ι)) X : skewSub ι) : Matrix ι ι ℝ)
      = (((Fintype.card ι : ℝ) - 1) • (X : skewSub ι) : skewSub ι)
  rw [sharpMap_id, Submodule.coe_smul]
  show (X : Matrix ι ι ℝ) + ((Fintype.card ι : ℝ) - 2) • (X : Matrix ι ι ℝ)
      = ((Fintype.card ι : ℝ) - 1) • (X : Matrix ι ι ℝ)
  rw [show ((Fintype.card ι : ℝ) - 1) = 1 + ((Fintype.card ι : ℝ) - 2) by ring, add_smul, one_smul]

/-- **AND THE WITNESS IS NOT A WEYL OPERATOR**, its Ricci clause returning `n-1` rather than `0`.
*So `isCritical2_id` settles that `IsCritical2` has content and says nothing about whether a Weyl
operator satisfies it, which is [I36](../../../plan.md)'s question and a different one.* -/
theorem not_isWeyl2_id (hn : 2 ≤ Fintype.card ι) :
    ¬ IsWeyl2 (ContinuousLinearMap.id ℝ (skewSub ι)) := by
  intro h
  have hne : Nonempty ι := Fintype.card_pos_iff.mp (lt_of_lt_of_le two_pos hn)
  obtain ⟨a⟩ := hne
  have hric := h.ric a a
  have hterm : ∀ c : ι,
      inner2 (applyPhi (ContinuousLinearMap.id ℝ (skewSub ι)) a c) (phi a c)
        = 1 - (if c = a then (1 : ℝ) else 0) := by
    intro c
    show inner2 (phi a c) (phi a c) = _
    rw [inner2_phi_phi]
    by_cases hc : c = a
    · subst hc; simp
    · simp [hc, Ne.symm hc]
  rw [Finset.sum_congr rfl fun c _ => hterm c, Finset.sum_sub_distrib] at hric
  simp only [Finset.sum_const, Finset.card_univ,  nsmul_eq_mul, mul_one,
    Finset.sum_ite_eq' Finset.univ a (fun _ => (1 : ℝ)), Finset.mem_univ, if_true] at hric
  have hn1 : (Fintype.card ι : ℝ) = 1 := by linarith
  have : (2 : ℝ) ≤ (Fintype.card ι : ℝ) := by exact_mod_cast hn
  linarith

/-! ## The bridge to the BARE-operator layer, which `foxTri2`'s symmetry needs

**[r1019](../../../reviews/REVIEW_r1019.md) found the record claiming that `foxTri2_symm_right`
discharges [FoxProduct.lean](../Base/FoxProduct.lean)'s recorded debt**, *and it does not*: that
file's `foxTri` is over BARE operators with `sharpOp` where `foxTri2` is over `CurvOp2` with
`sharpMapCL`, and **no file in the tree named both.** *The reviewer also named what is missing,
`extend_add`, and it is one line.*
-/

/-- **`extend` IS ADDITIVE.** -/
theorem extend_add (A B : CurvOp2 ι) (X : Matrix ι ι ℝ) :
    extend (A + B) X = extend A X + extend B X := rfl

/-- **`extend` COMMUTES WITH SCALARS.** -/
theorem extend_smul (c : ℝ) (A : CurvOp2 ι) (X : Matrix ι ι ℝ) :
    extend (c • A) X = c • extend A X := rfl

/-- **THE PAIRING CROSSES**, `⟨extend A, extend B⟩ = ⟨A, B⟩`, *which `normSq_extend` is the
diagonal of.* -/
theorem innerOp_extend (A B : CurvOp2 ι) :
    HamiltonsCubic.RealLayer.innerOp (extend A) (extend B) = innerOp2 A B := by
  unfold HamiltonsCubic.RealLayer.innerOp innerOp2
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [show extend A (phi i j) = applyPhi A i j from
      extend_apply A ⟨phi i j, phi_mem_skewSub i j⟩,
    show extend B (phi i j) = applyPhi B i j from
      extend_apply B ⟨phi i j, phi_mem_skewSub i j⟩]

end HamiltonsCubic.TensorBridge
