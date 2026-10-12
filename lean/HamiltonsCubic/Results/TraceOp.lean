import HamiltonsCubic.Base.Bivectors2

set_option linter.style.longLine false

/-!
# The trace on `End(Λ²)`, and `innerOp2` read through it

**The layer pairs operators and never traces them.** *`innerOp2 A B = ∑_e ⟨Ae, Be⟩` is the
Hilbert-Schmidt pairing, and every move the first variation of `P` needs is a CYCLIC one,*
`⟨SR, R⟩ = ⟨S, R²⟩` and its two companions, *which the pairing cannot make on its own because
the sum runs over one basis and cyclicity has to pass through a second.*

**So the trace is built here**, `trOp M = ∑_e ⟨Me, e⟩`, with cyclicity by the one honest route:
expand `Be` in the `φ` family, which `skew_expand` licenses, and swap the two summation names.
**Then `innerOp2 A B = trOp (A ∘ B)` AT A SELF-ADJOINT `A`**, *or at a self-adjoint `B`*, the
residual being `Tr((A* - A) B)`; **the hypothesis cannot be dropped once `3 ≤ |ι|`**, since
`trOp (A ∘ A)` is `-innerOp2 A A` at every skew-adjoint `A`, *while at `|ι| ≤ 2` every operator on
the at-most-one-dimensional `Λ²` is self-adjoint and there is no such `A`.*

*This file is the composition half of the first variation derived in
[second-order.md](../../../findings/second-order.md). The `#` half needs the structure constants
and is separate.*
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The trace on `End(Λ²)`**, with the ordered-pair doubling `innerOp2` uses. -/
noncomputable def trOp (M : CurvOp2 ι) : ℝ :=
  (1/2) * ∑ i : ι, ∑ j : ι, inner2 (applyPhi M i j) (phi i j)

/-- **The pairing of an operator against a bivector, expanded in the `φ` family.** *This is
`skew_expand` in the form the trace needs: a linear functional of `Y` is its own expansion.* -/
theorem sum_phi_inner (Y : skewSub ι) (f : Matrix ι ι ℝ →ₗ[ℝ] ℝ) :
    (1/2 : ℝ) * ∑ i : ι, ∑ j : ι, inner2 (Y : Matrix ι ι ℝ) (phi i j) * f (phi i j)
      = f (Y : Matrix ι ι ℝ) := by
  have hexp : (1/2 : ℝ) • (∑ i : ι, ∑ j : ι,
      (inner2 (Y : Matrix ι ι ℝ) (phi i j)) • phi i j) = (Y : Matrix ι ι ℝ) :=
    skew_expand _ Y.2
  conv_rhs => rw [← hexp]
  simp only [map_smul, map_sum, smul_eq_mul]

/-- **The `φ` expansion inside the submodule.** -/
theorem skew_expand_sub (Y : skewSub ι) :
    (1/2 : ℝ) • (∑ i : ι, ∑ j : ι, (inner2 (Y : Matrix ι ι ℝ) (phi i j)) •
      (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι)) = Y := by
  refine Subtype.ext ?_
  simp only [Submodule.coe_smul, AddSubmonoidClass.coe_finsetSum]
  exact skew_expand _ Y.2

/-- **A linear functional of `Y` IS its own `φ` expansion**, on `Λ²`. -/
theorem sum_phi_inner_sub (Y : skewSub ι) (f : skewSub ι →ₗ[ℝ] ℝ) :
    (1/2 : ℝ) * ∑ i : ι, ∑ j : ι,
        inner2 (Y : Matrix ι ι ℝ) (phi i j) * f ⟨phi i j, phi_mem_skewSub i j⟩
      = f Y := by
  conv_rhs => rw [← skew_expand_sub Y]
  simp only [map_smul, map_sum, smul_eq_mul]

/-- **Pairing against a fixed bivector, as a functional on `Λ²`.** -/
noncomputable def innerRight (m : Matrix ι ι ℝ) : skewSub ι →ₗ[ℝ] ℝ where
  toFun X := inner2 (X : Matrix ι ι ℝ) m
  map_add' X Y := by simpa using inner2_add_left (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) m
  map_smul' c X := by simpa using inner2_smul_left (X : Matrix ι ι ℝ) m c

/-- **The matrix entry of an operator in the `φ` family.** -/
noncomputable def matOp (M : CurvOp2 ι) (i j k l : ι) : ℝ :=
  inner2 (applyPhi M i j) (phi k l)

/-- **The trace of a composite, in entries.** *One expansion of the inner operator's value.* -/
theorem trOp_comp_entries (A B : CurvOp2 ι) :
    trOp (A.comp B) = (1/4) * ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι,
      matOp B i j k l * matOp A k l i j := by
  unfold trOp matOp
  have key : ∀ i j : ι,
      inner2 (applyPhi (A.comp B) i j) (phi i j)
        = (1/2 : ℝ) * ∑ k : ι, ∑ l : ι,
            inner2 (applyPhi B i j) (phi k l) * inner2 (applyPhi A k l) (phi i j) := by
    intro i j
    have := sum_phi_inner_sub (B ⟨phi i j, phi_mem_skewSub i j⟩)
      ((innerRight (phi i j)).comp (A : skewSub ι →ₗ[ℝ] skewSub ι))
    simpa [innerRight, applyPhi] using this.symm
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => key i j]
  have hpull : ∀ i : ι, (∑ j : ι, (1/2 : ℝ) * ∑ k : ι, ∑ l : ι,
        inner2 (applyPhi B i j) (phi k l) * inner2 (applyPhi A k l) (phi i j))
      = (1/2 : ℝ) * ∑ j : ι, ∑ k : ι, ∑ l : ι,
        inner2 (applyPhi B i j) (phi k l) * inner2 (applyPhi A k l) (phi i j) := by
    intro i; rw [Finset.mul_sum]
  rw [Finset.sum_congr rfl fun i _ => hpull i, ← Finset.mul_sum]
  ring

/-- **A four-index sum is invariant under swapping its two index PAIRS.** -/
theorem sum4_swap (F : ι → ι → ι → ι → ℝ) :
    (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, F i j k l)
      = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, F k l i j := by
  calc (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, F i j k l)
      = ∑ p : ι × ι, ∑ q : ι × ι, F p.1 p.2 q.1 q.2 := by
        simp [Fintype.sum_prod_type]
    _ = ∑ q : ι × ι, ∑ p : ι × ι, F p.1 p.2 q.1 q.2 := Finset.sum_comm
    _ = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, F k l i j := by
        simp [Fintype.sum_prod_type]

/-- **THE TRACE IS CYCLIC.** *The one move `innerOp2` cannot make on its own: the pairing sums over
one basis, and cyclicity has to pass through a second.* -/
theorem trOp_comp_comm (A B : CurvOp2 ι) : trOp (A.comp B) = trOp (B.comp A) := by
  rw [trOp_comp_entries, trOp_comp_entries]
  congr 1
  rw [sum4_swap fun i j k l => matOp A i j k l * matOp B k l i j]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  ring

/-! ## `innerOp2` through the trace, and the composition half of the first variation -/

/-! **`innerOp2` IS BILINEAR AND THE LAYER NEVER SAID SO** ([r1015](../../../reviews/REVIEW_r1015.md)).
*Nothing could expand `innerOp2` at a sum, so nothing could call `trCube2_first_variation`'s left
side the `t`-coefficient of anything.* -/

theorem innerOp2_add_left (A A' B : CurvOp2 ι) :
    innerOp2 (A + A') B = innerOp2 A B + innerOp2 A' B := by
  unfold innerOp2
  rw [← mul_add, ← Finset.sum_add_distrib]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  show inner2 (((A + A') ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) _ = _
  rw [show ((A + A') ⟨phi i j, phi_mem_skewSub i j⟩)
      = A ⟨phi i j, phi_mem_skewSub i j⟩ + A' ⟨phi i j, phi_mem_skewSub i j⟩ from rfl,
    Submodule.coe_add]
  exact inner2_add_left _ _ _

theorem innerOp2_smul_left (c : ℝ) (A B : CurvOp2 ι) :
    innerOp2 (c • A) B = c * innerOp2 A B := by
  unfold innerOp2
  have h : ∀ i j : ι,
      inner2 (applyPhi (c • A) i j) (applyPhi B i j)
        = c * inner2 (applyPhi A i j) (applyPhi B i j) := by
    intro i j
    show inner2 (((c • A) ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) _ = _
    rw [show ((c • A) ⟨phi i j, phi_mem_skewSub i j⟩)
        = c • A ⟨phi i j, phi_mem_skewSub i j⟩ from rfl, Submodule.coe_smul]
    exact inner2_smul_left _ _ c
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => h i j]
  simp only [← Finset.mul_sum]
  ring

theorem innerOp2_sub_left (A A' B : CurvOp2 ι) :
    innerOp2 (A - A') B = innerOp2 A B - innerOp2 A' B := by
  have h : A - A' + A' = A := by abel
  have := innerOp2_add_left (A - A') A' B
  rw [h] at this
  linarith

theorem innerOp2_add_right (A B B' : CurvOp2 ι) :
    innerOp2 A (B + B') = innerOp2 A B + innerOp2 A B' := by
  rw [innerOp2_comm, innerOp2_add_left, innerOp2_comm B A, innerOp2_comm B' A]

theorem innerOp2_smul_right (c : ℝ) (A B : CurvOp2 ι) :
    innerOp2 A (c • B) = c * innerOp2 A B := by
  rw [innerOp2_comm, innerOp2_smul_left, innerOp2_comm B A]

/-- **The composite of a sum, expanded.** *`compOp2` is quadratic, and this is its polarisation.* -/
theorem compOp2_add (A B : CurvOp2 ι) :
    compOp2 (A + B) = compOp2 A + (A.comp B + B.comp A) + compOp2 B := by
  refine ContinuousLinearMap.ext fun X => ?_
  show (A + B) ((A + B) X) = _
  show A ((A + B) X) + B ((A + B) X) = _
  show A (A X + B X) + B (A X + B X) = _
  rw [map_add, map_add]
  show _ = A (A X) + (A (B X) + B (A X)) + B (B X)
  abel


/-- **Self-adjoint against the pairing on `Λ²`**, which is `IsWeyl2`'s second clause on its own. -/
def IsSelfAdjoint2 (R : CurvOp2 ι) : Prop :=
  ∀ X Y : skewSub ι,
    inner2 ((R X : skewSub ι) : Matrix ι ι ℝ) ((Y : skewSub ι) : Matrix ι ι ℝ)
      = inner2 ((X : skewSub ι) : Matrix ι ι ℝ) ((R Y : skewSub ι) : Matrix ι ι ℝ)

theorem IsWeyl2.isSelfAdjoint2 {R : CurvOp2 ι} (h : IsWeyl2 R) : IsSelfAdjoint2 R :=
  h.selfAdjoint

/-- **A composite of a self-adjoint operator with itself is self-adjoint.** -/
theorem IsSelfAdjoint2.compOp2 {R : CurvOp2 ι} (h : IsSelfAdjoint2 R) :
    IsSelfAdjoint2 (HamiltonsCubic.RealLayer.compOp2 R) := by
  intro X Y
  show inner2 ((R (R X) : skewSub ι) : Matrix ι ι ℝ) _ = _
  rw [h (R X) Y, h X (R Y)]
  rfl

/-- **THE PAIRING IS THE TRACE OF THE COMPOSITE, AT A SELF-ADJOINT FIRST ARGUMENT.**

**"AND ONLY THERE" IS FALSE AND A FIRST VERSION SAID IT** ([r1015](../../../reviews/REVIEW_r1015.md)):
*the residual of `innerOp2 A B - trOp (A ∘ B)` is `Tr((A* - A) B)`, so self-adjointness of EITHER
argument suffices*, and `innerOp2_eq_trOp_right` below is the other side. **The hypothesis cannot be dropped ONCE `3 ≤ |ι|`**: at a
skew-adjoint `A`, `trOp (A ∘ A) = -innerOp2 A A`, and `adS X` inhabits that at `n = 3`, where
`innerOp2 A A = 2` against `trOp (A ∘ A) = -2`. **BELOW THAT THE NECESSITY CLAIM IS FALSE AND A
FIRST VERSION CARRIED NO BOUND** ([r1016](../../../reviews/REVIEW_r1016.md)): *at `|ι| ≤ 2` the space
`Λ²` has dimension at most one, every operator on it is self-adjoint, and `adS X` is exactly zero
there.* -/
theorem innerOp2_eq_trOp {A : CurvOp2 ι} (hA : IsSelfAdjoint2 A) (B : CurvOp2 ι) :
    innerOp2 A B = trOp (A.comp B) := by
  unfold innerOp2 trOp
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  show inner2 (applyPhi A i j) (applyPhi B i j)
      = inner2 ((A (B ⟨phi i j, phi_mem_skewSub i j⟩) : skewSub ι) : Matrix ι ι ℝ) (phi i j)
  rw [hA (B ⟨phi i j, phi_mem_skewSub i j⟩) ⟨phi i j, phi_mem_skewSub i j⟩]
  exact inner2_comm _ _

/-- **AND AT A SELF-ADJOINT SECOND ARGUMENT**, which is the same fact read through cyclicity. -/
theorem innerOp2_eq_trOp_right (A : CurvOp2 ι) {B : CurvOp2 ι} (hB : IsSelfAdjoint2 B) :
    innerOp2 A B = trOp (A.comp B) := by
  rw [innerOp2_comm, innerOp2_eq_trOp hB, trOp_comp_comm]

/-- **THE COMPOSITION HALF OF THE FIRST VARIATION.** *The three terms of the `t`-coefficient of
`⟨(R+tS)², R+tS⟩` are each `Tr(R²S)`, so their sum is `3⟨S, R²⟩`.* **EXACTLY ONE OF THE THREE NEEDS CYCLICITY, AND A FIRST VERSION SAID TWO**
([r1013](../../../reviews/REVIEW_r1013.md), [r1014](../../../reviews/REVIEW_r1014.md)): *only `h1`
below calls `trOp_comp_comm`, `h2` being associativity and `h3` a bare application, and both of
those reach their value without a trace at all.* **One is still enough to make the trace
necessary**, since `innerOp2` sums over one basis and that term's cyclic move has to pass through
a second. -/
theorem trCube2_first_variation (R S : CurvOp2 ι) (hR : IsSelfAdjoint2 R) :
    innerOp2 (S.comp R) R + innerOp2 (R.comp S) R + innerOp2 (compOp2 R) S
      = 3 * innerOp2 S (compOp2 R) := by
  have hRR : IsSelfAdjoint2 (compOp2 R) := hR.compOp2
  have h1 : innerOp2 (S.comp R) R = trOp ((compOp2 R).comp S) := by
    rw [innerOp2_comm, innerOp2_eq_trOp hR, trOp_comp_comm, ContinuousLinearMap.comp_assoc]
    show trOp (S.comp (compOp2 R)) = _
    exact trOp_comp_comm S (compOp2 R)
  have h2 : innerOp2 (R.comp S) R = trOp ((compOp2 R).comp S) := by
    rw [innerOp2_comm, innerOp2_eq_trOp hR, ← ContinuousLinearMap.comp_assoc]
    rfl
  have h3 : innerOp2 (compOp2 R) S = trOp ((compOp2 R).comp S) := innerOp2_eq_trOp hRR S
  rw [h1, h2, h3, innerOp2_comm, h3]
  ring

/-! ## The line `t ↦ R + tS`, and the composition half as a genuine derivative -/

/-- **The derivative at `0` of a cubic in `t` is its linear coefficient.** *Stated over abstract
coefficients so that no normalisation reaches inside them, which is what broke a first attempt to
assemble it in place.* -/
theorem hasDerivAt_cubic (a b c d : ℝ) :
    HasDerivAt (fun t : ℝ => a + t * b + t^2 * c + t^3 * d) b 0 := by
  have hfun : (fun t : ℝ => a + t * b + t^2 * c + t^3 * d)
      = (((fun _ : ℝ => a) + fun t : ℝ => t * b) + fun t : ℝ => t^2 * c)
          + fun t : ℝ => t^3 * d := rfl
  rw [hfun]
  have hc : HasDerivAt (fun _ : ℝ => a) 0 0 := hasDerivAt_const _ _
  have h1 : HasDerivAt (fun t : ℝ => t * b) b 0 := by
    simpa using (hasDerivAt_id (0 : ℝ)).mul_const b
  have h2 : HasDerivAt (fun t : ℝ => t^2 * c) 0 0 := by
    simpa using (hasDerivAt_pow 2 (0 : ℝ)).mul_const c
  have h3 : HasDerivAt (fun t : ℝ => t^3 * d) 0 0 := by
    simpa using (hasDerivAt_pow 3 (0 : ℝ)).mul_const d
  have key := ((hc.add h1).add h2).add h3
  have hv : (0 : ℝ) + b + 0 + 0 = b := by ring
  rw [hv] at key
  exact key


/-- **`R²` along the line.** -/
theorem compOp2_line (R S : CurvOp2 ι) (t : ℝ) :
    compOp2 (R + t • S) = compOp2 R + t • (R.comp S + S.comp R) + (t^2) • compOp2 S := by
  refine ContinuousLinearMap.ext fun X => ?_
  show (R + t • S) ((R + t • S) X) = _
  show R ((R + t • S) X) + t • S ((R + t • S) X) = _
  show R (R X + t • S X) + t • S (R X + t • S X) = _
  rw [map_add, map_add, map_smul, map_smul, smul_add, smul_smul]
  show _ = R (R X) + t • (R (S X) + S (R X)) + (t^2) • S (S X)
  rw [smul_add]
  rw [show t * t = t^2 from (sq t).symm]
  abel

/-- **`⟨R², R⟩` along the line, as a cubic polynomial in `t`.** -/
theorem trCube2_line (R S : CurvOp2 ι) (t : ℝ) :
    trCube2 (R + t • S)
      = trCube2 R
        + t * (innerOp2 (S.comp R) R + innerOp2 (R.comp S) R + innerOp2 (compOp2 R) S)
        + t^2 * (innerOp2 (compOp2 S) R + innerOp2 (S.comp R) S + innerOp2 (R.comp S) S)
        + t^3 * trCube2 S := by
  unfold trCube2
  rw [compOp2_line]
  simp only [innerOp2_add_left, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_right]
  ring

/-- **THE COMPOSITION HALF IS A DERIVATIVE**, not merely an identity. *[r1015](../../../reviews/REVIEW_r1015.md)
found nothing on file calling `trCube2_first_variation`'s left side a `t`-coefficient, because
`innerOp2` had no additivity lemma anywhere in the layer.* -/
theorem hasDerivAt_trCube2_line (R S : CurvOp2 ι) :
    HasDerivAt (fun t : ℝ => trCube2 (R + t • S))
      (innerOp2 (S.comp R) R + innerOp2 (R.comp S) R + innerOp2 (compOp2 R) S) 0 := by
  rw [funext (trCube2_line R S)]
  exact hasDerivAt_cubic _ _ _ _

/-- **AND ITS VALUE IS `3⟨S, R²⟩` at a self-adjoint `R`.** -/
theorem hasDerivAt_trCube2_line_selfAdjoint {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R)
    (S : CurvOp2 ι) :
    HasDerivAt (fun t : ℝ => trCube2 (R + t • S)) (3 * innerOp2 S (compOp2 R)) 0 := by
  have := hasDerivAt_trCube2_line R S
  rwa [trCube2_first_variation R S hR] at this

/-! ## The GENERAL increment, which the line form does not give

**`trCube2_line` scalarises `t` out before any estimate is made**, so it controls each line
separately and says nothing across directions ([r1016](../../../reviews/REVIEW_r1016.md)). *A
Fréchet derivative needs the expansion at an arbitrary increment `H`, with the remainder a
FUNCTION of `H` rather than a coefficient times a power of `t`.* **The algebra is the same and the
shape is what differs.**
-/

/-- **`⟨R², R⟩` at a general increment**, split into its constant, linear, quadratic and cubic
parts. -/
theorem trCube2_expand (R H : CurvOp2 ι) :
    trCube2 (R + H)
      = trCube2 R
        + (innerOp2 (H.comp R) R + innerOp2 (R.comp H) R + innerOp2 (compOp2 R) H)
        + (innerOp2 (compOp2 H) R + innerOp2 (H.comp R) H + innerOp2 (R.comp H) H)
        + trCube2 H := by
  unfold trCube2
  rw [compOp2_add]
  simp only [innerOp2_add_left, innerOp2_add_right]
  ring

end HamiltonsCubic.RealLayer
