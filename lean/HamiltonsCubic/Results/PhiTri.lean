import HamiltonsCubic.Results.TraceOp
import HamiltonsCubic.Results.L33Statement
import HamiltonsCubic.Results.L76Statement

set_option linter.style.longLine false

/-!
# `Φ`, the trilinear form under the `#` half, and its outer-slot symmetry

**[second-order.md](../../../findings/second-order.md) derives `Φ`'s two symmetries by expanding
in the `φ` basis and relabelling six summation indices**, against two copies of the totally
antisymmetric structure constants. *That route is faithful and it is not the cheapest one.*

**THE OUTER SWAP NEEDS NO INDICES AT ALL.** Written as
`Φ(A;B,C) = -∑_{e,f} ⟨B[Ae, Cf], [e,f]⟩`, *which is one application of `ad_skewAdjoint` away from
the definition*, swapping the two summation pairs turns it into
`-∑ ⟨B[Cf, Ae], [f,e]⟩`, and the bracket is antisymmetric in each place at once, so the two signs
cancel through `B`'s own linearity. **No structure constant is named and no index is relabelled.**

*The rotation at a symmetric first slot is the harder half and DOES need the expansion, which is
below, under `Φ` in indices.*
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The bracket on `Λ²` is antisymmetric.** -/
theorem brS_neg (X Y : skewSub ι) : brS X Y = - brS Y X := by
  refine Subtype.ext ?_
  show br (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = -br (Y : Matrix ι ι ℝ) (X : Matrix ι ι ℝ)
  simp [br]

/-- **The pairing against a bracket is cyclic**, which is `ad_skewAdjoint` read once. -/
theorem inner2_brS_cyc (X Y Z : skewSub ι) :
    inner2 ((brS X Y : skewSub ι) : Matrix ι ι ℝ) ((Z : skewSub ι) : Matrix ι ι ℝ)
      = inner2 ((brS Z X : skewSub ι) : Matrix ι ι ℝ) ((Y : skewSub ι) : Matrix ι ι ℝ) := by
  have h := HamiltonsCubic.L33Statement.ad_skewAdjoint (u := (Y : Matrix ι ι ℝ))
    (v := (X : Matrix ι ι ℝ)) (w := (Z : Matrix ι ι ℝ)) Y.2 X.2 Z.2
  have hc : ((brS Z X : skewSub ι) : Matrix ι ι ℝ)
      = -br (X : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ) := by
    show br (Z : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) = _
    simp [br]
  show inner2 (br (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)) (Z : Matrix ι ι ℝ) = _
  rw [h, hc, inner2_comm]
  simp [inner2]

/-- **`Φ(A;B,C)`, in the form the outer swap reads**, `-∑_{e,f} ⟨B[Ae, Cf], [e,f]⟩` with the
ordered-pair doubling on both sums. -/
noncomputable def phiTri (A B C : CurvOp2 ι) : ℝ :=
  -(1/4) * ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι,
    inner2 ((B (brS (A ⟨phi i j, phi_mem_skewSub i j⟩) (C ⟨phi k l, phi_mem_skewSub k l⟩)) :
        skewSub ι) : Matrix ι ι ℝ)
      ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
        Matrix ι ι ℝ)

/-- **THE OUTER SLOTS SWAP, WITH NO HYPOTHESIS.** *Swapping the two summation pairs reverses both
brackets at once, and the two signs cancel through `B`'s linearity.* -/
theorem phiTri_swap_outer (A B C : CurvOp2 ι) : phiTri A B C = phiTri C B A := by
  unfold phiTri
  congr 1
  rw [sum4_swap fun i j k l =>
    inner2 ((B (brS (C ⟨phi i j, phi_mem_skewSub i j⟩) (A ⟨phi k l, phi_mem_skewSub k l⟩)) :
        skewSub ι) : Matrix ι ι ℝ)
      ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
        Matrix ι ι ℝ)]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  rw [brS_neg (C ⟨phi k l, phi_mem_skewSub k l⟩) (A ⟨phi i j, phi_mem_skewSub i j⟩),
    brS_neg ⟨phi k l, phi_mem_skewSub k l⟩ ⟨phi i j, phi_mem_skewSub i j⟩]
  simp [map_neg, Submodule.coe_neg, inner2]

/-! ## `crossPair2` is a trace, hence symmetric, hence IS `sharpBil2`

**The polarisation carries a `½(cp + cp)` because nothing said `crossPair2` was already symmetric.**
*It is*, and the reason is the one `TraceOp.lean` was built for: `crossPair2 R X Y` is
`-½ Tr(ad_X R ad_Y R)`, and cyclicity swaps the two halves.
-/

section Ad

open scoped Matrix.Norms.Frobenius

/-- **`ad_X` as a bundled operator on `Λ²`.** *Linear by `brS_add_right` and `brS_smul_right`,
continuous by finite dimensionality.* -/
noncomputable def adS (X : skewSub ι) : CurvOp2 ι :=
  LinearMap.toContinuousLinearMap
    { toFun := fun Y => brS X Y
      map_add' := brS_add_right X
      map_smul' := fun c Y => brS_smul_right c X Y }

@[simp] theorem adS_apply (X Y : skewSub ι) : adS X Y = brS X Y := rfl

/-- **`crossPair2` IS A TRACE**, `-½ Tr(ad_X R ad_Y R)`. -/
theorem crossPair2_eq_trOp (R : CurvOp2 ι) (X Y : skewSub ι) :
    crossPair2 R X Y
      = -(1/2) * trOp (((adS X).comp R).comp ((adS Y).comp R)) := by
  have hterm : ∀ i j : ι,
      inner2 ((crossTerm2 R X Y i j : skewSub ι) : Matrix ι ι ℝ) (phi i j)
        = inner2 (applyPhi (((adS X).comp R).comp ((adS Y).comp R)) i j) (phi i j) :=
    fun _ _ => rfl
  unfold crossPair2 trOp
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hterm i j]
  ring

/-- **SO IT IS SYMMETRIC**, with no hypothesis, by cyclicity of the trace. -/
theorem crossPair2_comm (R : CurvOp2 ι) (X Y : skewSub ι) :
    crossPair2 R X Y = crossPair2 R Y X := by
  rw [crossPair2_eq_trOp, crossPair2_eq_trOp, trOp_comp_comm]

/-- **AND THE POLARISATION COLLAPSES**: `sharpBil2` IS `crossPair2`, *so the `½(cp + cp)` in its
definition was symmetrising something already symmetric.* -/
theorem sharpBil2_eq_crossPair2 (R : CurvOp2 ι) (X Y : skewSub ι) :
    sharpBil2 R X Y = crossPair2 R X Y := by
  rw [sharpBil2_eq, crossPair2_comm R Y X]
  ring

end Ad

/-! ## `phiTri` is trilinear, and the OFF-DIAGONAL pairing

**[r1015](../../../reviews/REVIEW_r1015.md) found the record short by two lemmas**, and both are
here. *Without trilinearity nothing expands `phiTri (R + tS) (R + tS) (R + tS)`, and without the
off-diagonal pairing `phiTri S R R` is not `⟨S, R#⟩`, so the collapse below reached `Pcubic2`
through nothing at all.*
-/

theorem phiTri_add_left (A A' B C : CurvOp2 ι) :
    phiTri (A + A') B C = phiTri A B C + phiTri A' B C := by
  unfold phiTri
  rw [← mul_add, ← Finset.sum_add_distrib]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun l _ => ?_
  show inner2 ((B (brS ((A + A') _) _) : skewSub ι) : Matrix ι ι ℝ) _ = _
  rw [show ((A + A') ⟨phi i j, phi_mem_skewSub i j⟩)
      = A ⟨phi i j, phi_mem_skewSub i j⟩ + A' ⟨phi i j, phi_mem_skewSub i j⟩ from rfl,
    brS_add_left, map_add, Submodule.coe_add]
  exact inner2_add_left _ _ _

theorem phiTri_add_mid (A B B' C : CurvOp2 ι) :
    phiTri A (B + B') C = phiTri A B C + phiTri A B' C := by
  unfold phiTri
  rw [← mul_add, ← Finset.sum_add_distrib]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [show ((B + B') (brS (A ⟨phi i j, phi_mem_skewSub i j⟩) (C ⟨phi k l, phi_mem_skewSub k l⟩)))
      = B (brS (A ⟨phi i j, phi_mem_skewSub i j⟩) (C ⟨phi k l, phi_mem_skewSub k l⟩))
        + B' (brS (A ⟨phi i j, phi_mem_skewSub i j⟩) (C ⟨phi k l, phi_mem_skewSub k l⟩)) from rfl,
    Submodule.coe_add]
  exact inner2_add_left _ _ _

theorem phiTri_add_right (A B C C' : CurvOp2 ι) :
    phiTri A B (C + C') = phiTri A B C + phiTri A B C' := by
  unfold phiTri
  rw [← mul_add, ← Finset.sum_add_distrib]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [show ((C + C') ⟨phi k l, phi_mem_skewSub k l⟩)
      = C ⟨phi k l, phi_mem_skewSub k l⟩ + C' ⟨phi k l, phi_mem_skewSub k l⟩ from rfl,
    brS_add_right, map_add, Submodule.coe_add]
  exact inner2_add_left _ _ _

theorem phiTri_smul_left (c : ℝ) (A B C : CurvOp2 ι) :
    phiTri (c • A) B C = c * phiTri A B C := by
  unfold phiTri
  have h : ∀ i j k l : ι,
      inner2 ((B (brS ((c • A) ⟨phi i j, phi_mem_skewSub i j⟩)
          (C ⟨phi k l, phi_mem_skewSub k l⟩)) : skewSub ι) : Matrix ι ι ℝ)
        ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
          Matrix ι ι ℝ)
      = c * inner2 ((B (brS (A ⟨phi i j, phi_mem_skewSub i j⟩)
          (C ⟨phi k l, phi_mem_skewSub k l⟩)) : skewSub ι) : Matrix ι ι ℝ)
        ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
          Matrix ι ι ℝ) := by
    intro i j k l
    rw [show ((c • A) ⟨phi i j, phi_mem_skewSub i j⟩)
        = c • A ⟨phi i j, phi_mem_skewSub i j⟩ from rfl,
      brS_smul_left, map_smul, Submodule.coe_smul]
    exact inner2_smul_left _ _ c
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => h i j k l]
  simp only [← Finset.mul_sum]
  ring

theorem phiTri_smul_mid (c : ℝ) (A B C : CurvOp2 ι) :
    phiTri A (c • B) C = c * phiTri A B C := by
  unfold phiTri
  have h : ∀ i j k l : ι,
      inner2 (((c • B) (brS (A ⟨phi i j, phi_mem_skewSub i j⟩)
          (C ⟨phi k l, phi_mem_skewSub k l⟩)) : skewSub ι) : Matrix ι ι ℝ)
        ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
          Matrix ι ι ℝ)
      = c * inner2 ((B (brS (A ⟨phi i j, phi_mem_skewSub i j⟩)
          (C ⟨phi k l, phi_mem_skewSub k l⟩)) : skewSub ι) : Matrix ι ι ℝ)
        ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
          Matrix ι ι ℝ) := by
    intro i j k l
    rw [show ((c • B) (brS (A ⟨phi i j, phi_mem_skewSub i j⟩)
          (C ⟨phi k l, phi_mem_skewSub k l⟩)))
        = c • B (brS (A ⟨phi i j, phi_mem_skewSub i j⟩)
          (C ⟨phi k l, phi_mem_skewSub k l⟩)) from rfl, Submodule.coe_smul]
    exact inner2_smul_left _ _ c
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => h i j k l]
  simp only [← Finset.mul_sum]
  ring

theorem phiTri_smul_right (c : ℝ) (A B C : CurvOp2 ι) :
    phiTri A B (c • C) = c * phiTri A B C := by
  unfold phiTri
  have h : ∀ i j k l : ι,
      inner2 ((B (brS (A ⟨phi i j, phi_mem_skewSub i j⟩)
          ((c • C) ⟨phi k l, phi_mem_skewSub k l⟩)) : skewSub ι) : Matrix ι ι ℝ)
        ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
          Matrix ι ι ℝ)
      = c * inner2 ((B (brS (A ⟨phi i j, phi_mem_skewSub i j⟩)
          (C ⟨phi k l, phi_mem_skewSub k l⟩)) : skewSub ι) : Matrix ι ι ℝ)
        ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) :
          Matrix ι ι ℝ) := by
    intro i j k l
    rw [show ((c • C) ⟨phi k l, phi_mem_skewSub k l⟩)
        = c • C ⟨phi k l, phi_mem_skewSub k l⟩ from rfl,
      brS_smul_right, map_smul, Submodule.coe_smul]
    exact inner2_smul_left _ _ c
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => h i j k l]
  simp only [← Finset.mul_sum]
  ring

/-! ## What the `Φ` half of the first variation consumes

**Two identities, and the outer swap above is one of them.** *The other is the rotation, which
does appear to need the `φ` expansion and is typed here as a signature so the gap is one named
lemma rather than a paragraph.*
-/

/-- **`sharpBil2 R X` as a linear functional of its second slot**, which `sharpBil2_add_right` and
`sharpBil2_smul_right` license. -/
noncomputable def sharpBilRight (R : CurvOp2 ι) (X : skewSub ι) : skewSub ι →ₗ[ℝ] ℝ where
  toFun Z := sharpBil2 R X Z
  map_add' := sharpBil2_add_right R X
  map_smul' c Z := by simpa using sharpBil2_smul_right R c X Z

/-- **`sharpMap` EARNS ITS NAME**: pairing `R# X` against any `Y` returns `⟨R# X, Y⟩`. *This is
what the `φ` expansion in its definition is for, and `sum_phi_inner_sub` undoes that expansion
because `sharpBil2` is linear in the slot being expanded.* -/
theorem inner2_sharpMap (R : CurvOp2 ι) (X Y : skewSub ι) :
    inner2 ((sharpMap R X : skewSub ι) : Matrix ι ι ℝ) ((Y : skewSub ι) : Matrix ι ι ℝ)
      = sharpBil2 R X Y := by
  have h : (1/2 : ℝ) * ∑ k : ι, ∑ l : ι,
      inner2 (Y : Matrix ι ι ℝ) (phi k l) * sharpBil2 R X ⟨phi k l, phi_mem_skewSub k l⟩
      = sharpBil2 R X Y := sum_phi_inner_sub Y (sharpBilRight R X)
  have hL : innerRight ((Y : skewSub ι) : Matrix ι ι ℝ) (sharpMap R X)
      = (1/2 : ℝ) * ∑ k : ι, ∑ l : ι,
        sharpBil2 R X ⟨phi k l, phi_mem_skewSub k l⟩ * inner2 (phi k l) (Y : Matrix ι ι ℝ) := by
    unfold sharpMap
    rw [map_smul, map_sum]
    simp only [map_sum, map_smul, smul_eq_mul]
    rfl
  show innerRight ((Y : skewSub ι) : Matrix ι ι ℝ) (sharpMap R X) = _
  rw [hL, ← h]
  congr 1
  exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
    rw [inner2_comm]; ring

/-- **`⟨R, R#⟩` COLLAPSES TO ONE SUM.** -/
theorem sharpPair2_eq_sum (R : CurvOp2 ι) :
    sharpPair2 R = (1/2) * ∑ i : ι, ∑ j : ι,
      sharpBil2 R ⟨phi i j, phi_mem_skewSub i j⟩ (R ⟨phi i j, phi_mem_skewSub i j⟩) := by
  unfold sharpPair2
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [inner2_comm]
  exact inner2_sharpMap R ⟨phi i j, phi_mem_skewSub i j⟩ (R ⟨phi i j, phi_mem_skewSub i j⟩)

/-- **`crossPair2` WITH THE OUTER BRACKET MOVED ACROSS**, one `ad_skewAdjoint` per term. -/
theorem crossPair2_bracket (R : CurvOp2 ι) (X Y : skewSub ι) :
    crossPair2 R X Y = (1/4) * ∑ p : ι, ∑ q : ι,
      inner2 ((R (brS Y (R ⟨phi p q, phi_mem_skewSub p q⟩)) : skewSub ι) : Matrix ι ι ℝ)
        ((brS X ⟨phi p q, phi_mem_skewSub p q⟩ : skewSub ι) : Matrix ι ι ℝ) := by
  unfold crossPair2
  have key : ∀ p q : ι,
      inner2 ((crossTerm2 R X Y p q : skewSub ι) : Matrix ι ι ℝ) (phi p q)
        = - inner2 ((R (brS Y (R ⟨phi p q, phi_mem_skewSub p q⟩)) : skewSub ι) : Matrix ι ι ℝ)
            ((brS X ⟨phi p q, phi_mem_skewSub p q⟩ : skewSub ι) : Matrix ι ι ℝ) := by
    intro p q
    exact HamiltonsCubic.L33Statement.ad_skewAdjoint
      (R (brS Y (R ⟨phi p q, phi_mem_skewSub p q⟩))).2 X.2 (phi_mem_skewSub p q)
  rw [Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => key p q]
  simp only [Finset.sum_neg_distrib]
  ring

/-- **THE OFF-DIAGONAL PAIRING**, `⟨S, R#⟩ = -½ Φ(S;R,R)` at EVERY `S`, which is what
[second-order.md](../../../findings/second-order.md)'s step 1 actually states and what the first
variation consumes. *[r1015](../../../reviews/REVIEW_r1015.md) found the layer carrying only its
diagonal, so `phiTri S R R` was not `⟨S, R#⟩` anywhere on file.* -/
theorem innerOp2_sharpMap_eq_phiTri (R S : CurvOp2 ι) :
    innerOp2 S (sharpMapCL R) = -(1/2) * phiTri S R R := by
  have hsum : innerOp2 S (sharpMapCL R)
      = (1/2) * ∑ i : ι, ∑ j : ι,
        sharpBil2 R ⟨phi i j, phi_mem_skewSub i j⟩ (S ⟨phi i j, phi_mem_skewSub i j⟩) := by
    unfold innerOp2
    congr 1
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    rw [inner2_comm]
    exact inner2_sharpMap R ⟨phi i j, phi_mem_skewSub i j⟩ (S ⟨phi i j, phi_mem_skewSub i j⟩)
  rw [hsum]
  have hterm : ∀ i j : ι,
      sharpBil2 R ⟨phi i j, phi_mem_skewSub i j⟩ (S ⟨phi i j, phi_mem_skewSub i j⟩)
        = (1/4) * ∑ p : ι, ∑ q : ι,
            inner2 ((R (brS (S ⟨phi i j, phi_mem_skewSub i j⟩)
                (R ⟨phi p q, phi_mem_skewSub p q⟩)) : skewSub ι) : Matrix ι ι ℝ)
              ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi p q, phi_mem_skewSub p q⟩ : skewSub ι) :
                Matrix ι ι ℝ) := by
    intro i j
    rw [sharpBil2_eq_crossPair2, crossPair2_bracket]
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hterm i j]
  have hpull : ∀ i : ι,
      (∑ j : ι, (1/4 : ℝ) * ∑ p : ι, ∑ q : ι,
          inner2 ((R (brS (S ⟨phi i j, phi_mem_skewSub i j⟩)
              (R ⟨phi p q, phi_mem_skewSub p q⟩)) : skewSub ι) : Matrix ι ι ℝ)
            ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi p q, phi_mem_skewSub p q⟩ : skewSub ι) :
              Matrix ι ι ℝ))
      = (1/4 : ℝ) * ∑ j : ι, ∑ p : ι, ∑ q : ι,
          inner2 ((R (brS (S ⟨phi i j, phi_mem_skewSub i j⟩)
              (R ⟨phi p q, phi_mem_skewSub p q⟩)) : skewSub ι) : Matrix ι ι ℝ)
            ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi p q, phi_mem_skewSub p q⟩ : skewSub ι) :
              Matrix ι ι ℝ) := fun i => (Finset.mul_sum _ _ _).symm
  rw [Finset.sum_congr rfl fun i _ => hpull i, ← Finset.mul_sum]
  unfold phiTri
  ring

/-- **THE LINK TO THE LAYER'S OWN `sharpPair2`**, `⟨R, R#⟩ = -½ Φ(R;R,R)`, which is
[second-order.md](../../../findings/second-order.md)'s step 1 plus the reassembly of `sharpMap`.
*The constant was screened exactly before the statement was typed, at a genuine Weyl operator at
`n = 4`: `sharpPair2 = 12` against `phiTri = -24`.* **A `sorry` on a false statement is a debt that
can never be paid**, which is why the screen came first and why the `sorry` never had to be
written. -/
theorem sharpPair2_eq_phiTri (R : CurvOp2 ι) : sharpPair2 R = -(1/2) * phiTri R R R := by
  have h := innerOp2_sharpMap_eq_phiTri R R
  rw [← h]
  rfl

/-- **`A'` IS AN ADJOINT OF `A` ON `Λ²`.** *One `Prop`, no instance, and at `A' = A` it IS
`IsSelfAdjoint2` definitionally.* -/
def IsAdjoint2 (A A' : CurvOp2 ι) : Prop :=
  ∀ X Y : skewSub ι,
    inner2 ((A X : skewSub ι) : Matrix ι ι ℝ) ((Y : skewSub ι) : Matrix ι ι ℝ)
      = inner2 ((X : skewSub ι) : Matrix ι ι ℝ) ((A' Y : skewSub ι) : Matrix ι ι ℝ)

theorem IsSelfAdjoint2.isAdjoint2 {A : CurvOp2 ι} (h : IsSelfAdjoint2 A) : IsAdjoint2 A A := h

/-! ## `Φ` in indices, the form the rotation is proved in

**This was a separate `PhiIndex.lean` until the rotation was proved.** *That file imported this one,
so its `phiTri_starred_proof` sat downstream of the `sorry` it discharges; the machinery is here now and
the `sorry` is gone.*
-/


/-- **The bivector of an ordered index pair.** -/
noncomputable def phiS (p : ι × ι) : skewSub ι := ⟨phi p.1 p.2, phi_mem_skewSub p.1 p.2⟩

@[simp] theorem phiS_coe (p : ι × ι) : ((phiS p : skewSub ι) : Matrix ι ι ℝ) = phi p.1 p.2 := rfl

/-- **The structure constant** `c(p,q,r) = ⟨[φ_p, φ_q], φ_r⟩`. -/
noncomputable def ccS (p q r : ι × ι) : ℝ :=
  inner2 ((brS (phiS p) (phiS q) : skewSub ι) : Matrix ι ι ℝ) (phi r.1 r.2)

/-- **The matrix entry** `A(g,e) = ⟨A φ_e, φ_g⟩`. -/
noncomputable def matS (A : CurvOp2 ι) (g e : ι × ι) : ℝ :=
  inner2 (applyPhi A e.1 e.2) (phi g.1 g.2)

/-- **`c` IS CYCLIC**, which is the whole of what the relabelling turns on. -/
theorem ccS_cyclic (p q r : ι × ι) : ccS p q r = ccS r p q := by
  unfold ccS
  exact inner2_brS_cyc (phiS p) (phiS q) (phiS r)

/-- **AND ANTISYMMETRIC IN ITS FIRST TWO SLOTS**, from the bracket. -/
theorem ccS_swap12 (p q r : ι × ι) : ccS p q r = - ccS q p r := by
  unfold ccS
  rw [brS_neg (phiS p) (phiS q)]
  show inner2 (-((brS (phiS q) (phiS p) : skewSub ι) : Matrix ι ι ℝ)) _ = _
  simp [inner2]

/-- **So it is TOTALLY antisymmetric**: the cyclic rotation and one transposition generate every
permutation of the three slots, with the sign. -/
theorem ccS_swap23 (p q r : ι × ι) : ccS p q r = - ccS p r q := by
  rw [ccS_cyclic p q r, ccS_swap12 r p q, ccS_cyclic p r q]

/-! ## The four expansions, each one application of `sum_phi_inner_sub` -/

/-- **The `φ`-coordinate of a bivector.** -/
noncomputable def coordS (X : skewSub ι) (g : ι × ι) : ℝ :=
  inner2 ((X : skewSub ι) : Matrix ι ι ℝ) (phi g.1 g.2)

@[simp] theorem coordS_apply (A : CurvOp2 ι) (g e : ι × ι) :
    coordS (A (phiS e)) g = matS A g e := rfl

/-- **`sum_phi_inner_sub` over ORDERED PAIRS**, which is the shape every expansion below wants. -/
theorem sum_phi_inner_pair (Y : skewSub ι) (f : skewSub ι →ₗ[ℝ] ℝ) :
    (1/2 : ℝ) * ∑ p : ι × ι, coordS Y p * f (phiS p) = f Y := by
  rw [← sum_phi_inner_sub Y f]
  congr 1
  rw [Fintype.sum_prod_type]
  rfl

/-- **The bracket's left slot, as a functional.** -/
noncomputable def brLeftFun (q r : ι × ι) : skewSub ι →ₗ[ℝ] ℝ where
  toFun X := inner2 ((brS X (phiS q) : skewSub ι) : Matrix ι ι ℝ) (phi r.1 r.2)
  map_add' X Y := by
    simp only [brS_add_left, Submodule.coe_add]
    exact inner2_add_left _ _ _
  map_smul' c X := by
    simp only [brS_smul_left, Submodule.coe_smul, RingHom.id_apply, smul_eq_mul]
    exact inner2_smul_left _ _ c

/-- **The bracket's right slot, as a functional.** -/
noncomputable def brRightFun (X : skewSub ι) (r : ι × ι) : skewSub ι →ₗ[ℝ] ℝ where
  toFun Y := inner2 ((brS X Y : skewSub ι) : Matrix ι ι ℝ) (phi r.1 r.2)
  map_add' Y Z := by
    simp only [brS_add_right, Submodule.coe_add]
    exact inner2_add_left _ _ _
  map_smul' c Y := by
    simp only [brS_smul_right, Submodule.coe_smul, RingHom.id_apply, smul_eq_mul]
    exact inner2_smul_left _ _ c

/-- **EXPANDING THE BRACKET'S LEFT SLOT.** -/
theorem brS_expand_left (X : skewSub ι) (q r : ι × ι) :
    inner2 ((brS X (phiS q) : skewSub ι) : Matrix ι ι ℝ) (phi r.1 r.2)
      = (1/2 : ℝ) * ∑ g : ι × ι, coordS X g * ccS g q r :=
  (sum_phi_inner_pair X (brLeftFun q r)).symm

/-- **AND ITS RIGHT SLOT.** -/
theorem brS_expand_right (X Y : skewSub ι) (r : ι × ι) :
    inner2 ((brS X Y : skewSub ι) : Matrix ι ι ℝ) (phi r.1 r.2)
      = (1/2 : ℝ) * ∑ h : ι × ι, coordS Y h
          * inner2 ((brS X (phiS h) : skewSub ι) : Matrix ι ι ℝ) (phi r.1 r.2) :=
  (sum_phi_inner_pair Y (brRightFun X r)).symm

/-! ## The assembly -/

/-- **`phiTri` over ORDERED PAIRS**, which is the shape the four expansions act on. -/
theorem phiTri_pairs (A B C : CurvOp2 ι) :
    phiTri A B C = -(1/4) * ∑ p : ι × ι, ∑ q : ι × ι,
      inner2 ((B (brS (A (phiS p)) (C (phiS q))) : skewSub ι) : Matrix ι ι ℝ)
        ((brS (phiS p) (phiS q) : skewSub ι) : Matrix ι ι ℝ) := by
  unfold phiTri
  congr 1
  rw [Fintype.sum_prod_type]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [Fintype.sum_prod_type]
  rfl

/-- **Pairing an operator's value against a bivector, as a functional of the ARGUMENT.** -/
noncomputable def applyRight (B : CurvOp2 ι) (m : ι × ι) : skewSub ι →ₗ[ℝ] ℝ :=
  (innerRight (phi m.1 m.2)).comp (B : skewSub ι →ₗ[ℝ] skewSub ι)

@[simp] theorem applyRight_apply (B : CurvOp2 ι) (m : ι × ι) (u : skewSub ι) :
    applyRight B m u = inner2 ((B u : skewSub ι) : Matrix ι ι ℝ) (phi m.1 m.2) := rfl

/-- **EXPANSION ONE, the outer pairing.** -/
theorem expand_outer (B : CurvOp2 ι) (u : skewSub ι) (p q : ι × ι) :
    inner2 ((B u : skewSub ι) : Matrix ι ι ℝ) ((brS (phiS p) (phiS q) : skewSub ι) : Matrix ι ι ℝ)
      = (1/2 : ℝ) * ∑ m : ι × ι, ccS p q m * inner2 ((B u : skewSub ι) : Matrix ι ι ℝ) (phi m.1 m.2) := by
  have h := sum_phi_inner_pair (brS (phiS p) (phiS q))
    (innerRight ((B u : skewSub ι) : Matrix ι ι ℝ))
  rw [inner2_comm]
  rw [show inner2 ((brS (phiS p) (phiS q) : skewSub ι) : Matrix ι ι ℝ)
        ((B u : skewSub ι) : Matrix ι ι ℝ)
      = (innerRight ((B u : skewSub ι) : Matrix ι ι ℝ)) (brS (phiS p) (phiS q)) from rfl,
    ← h]
  congr 1
  refine Finset.sum_congr rfl fun r _ => ?_
  show ccS p q r * inner2 (phi r.1 r.2) ((B u : skewSub ι) : Matrix ι ι ℝ)
      = ccS p q r * inner2 ((B u : skewSub ι) : Matrix ι ι ℝ) (phi r.1 r.2)
  rw [inner2_comm]

/-- **EXPANSION TWO, the operator's argument.** -/
theorem expand_arg (B : CurvOp2 ι) (u : skewSub ι) (m : ι × ι) :
    inner2 ((B u : skewSub ι) : Matrix ι ι ℝ) (phi m.1 m.2)
      = (1/2 : ℝ) * ∑ k : ι × ι, coordS u k * matS B m k :=
  (sum_phi_inner_pair u (applyRight B m)).symm

/-- **EXPANSIONS THREE AND FOUR, the inner bracket's two slots.** -/
theorem coordS_brS_expand (A C : CurvOp2 ι) (p q k : ι × ι) :
    coordS (brS (A (phiS p)) (C (phiS q))) k
      = (1/4 : ℝ) * ∑ h : ι × ι, ∑ g : ι × ι, matS C h q * (matS A g p * ccS g h k) := by
  show inner2 ((brS (A (phiS p)) (C (phiS q)) : skewSub ι) : Matrix ι ι ℝ) (phi k.1 k.2) = _
  rw [brS_expand_right (A (phiS p)) (C (phiS q)) k]
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun h _ => ?_
  rw [brS_expand_left (A (phiS p)) h k]
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun g _ => ?_
  show (1/2 : ℝ) * (matS C h q * ((1/2 : ℝ) * (coordS (A (phiS p)) g * ccS g h k)))
      = (1/4 : ℝ) * (matS C h q * (matS A g p * ccS g h k))
  show (1/2 : ℝ) * (matS C h q * ((1/2 : ℝ) * (matS A g p * ccS g h k)))
      = (1/4 : ℝ) * (matS C h q * (matS A g p * ccS g h k))
  ring

/-- **THE SUMMAND, FULLY EXPANDED.** -/
theorem phiTri_summand (A B C : CurvOp2 ι) (p q : ι × ι) :
    inner2 ((B (brS (A (phiS p)) (C (phiS q))) : skewSub ι) : Matrix ι ι ℝ)
        ((brS (phiS p) (phiS q) : skewSub ι) : Matrix ι ι ℝ)
      = (1/16 : ℝ) * ∑ m : ι × ι, ∑ k : ι × ι, ∑ h : ι × ι, ∑ g : ι × ι,
          ccS g h k * ccS p q m * matS A g p * matS B m k * matS C h q := by
  rw [expand_outer B (brS (A (phiS p)) (C (phiS q))) p q]
  simp only [Finset.mul_sum, Finset.sum_mul]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [expand_arg B (brS (A (phiS p)) (C (phiS q))) m]
  simp only [Finset.mul_sum, Finset.sum_mul]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [coordS_brS_expand A C p q k]
  simp only [Finset.mul_sum, Finset.sum_mul]
  refine Finset.sum_congr rfl fun h _ => ?_
  refine Finset.sum_congr rfl fun g _ => ?_
  ring

/-- **`Φ` IN INDICES.** *Six ordered-pair sums, three matrix entries and two copies of the totally
antisymmetric structure constant. Every symmetry of `Φ` is a relabelling of this.*

**The constant `-1/64` was screened exactly before this was typed**: at `n = 4` on a random
operator triple, `Φ = -102` against a six-fold sum of `6528`. *Four expansions at `½` each and the
definition's own `¼` give it, and `2⁶ = 64` converts these ordered-pair sums to the derivation's
sums over the `i < j` basis.* -/
theorem phiTri_index (A B C : CurvOp2 ι) :
    phiTri A B C = -(1/64 : ℝ) * ∑ e : ι × ι, ∑ f : ι × ι, ∑ m : ι × ι, ∑ k : ι × ι,
      ∑ h : ι × ι, ∑ g : ι × ι,
        ccS g h k * ccS e f m * matS A g e * matS B m k * matS C h f := by
  rw [phiTri_pairs]
  rw [Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => phiTri_summand A B C p q]
  simp only [← Finset.mul_sum]
  ring

/-- **THE ADJOINT, IN INDICES**: `A*`'s matrix is `A`'s transposed. *This is the third ingredient
the relabelling needs, and it was on file nowhere* ([r1018](../../../reviews/REVIEW_r1018.md)):
`matS` lives only here and `IsAdjoint2` only in [PhiTri.lean](PhiTri.lean), *so no declaration
named both.* -/
theorem matS_adjoint {A A' : CurvOp2 ι} (h : IsAdjoint2 A A') (f g : ι × ι) :
    matS A' g f = matS A f g := by
  have := h (phiS g) (phiS f)
  show inner2 ((A' (phiS f) : skewSub ι) : Matrix ι ι ℝ) (phi g.1 g.2) = _
  rw [inner2_comm]
  exact this.symm

/-! ## The relabelling

**The rotation is the substitution `(e,f,m,k,h,g) ↦ (k,g,h,f,e,m)` on the six slots**, which is a
permutation because all six sums run over the same `univ`. *Under it the three matrix factors line
up as `A ↦ C`, `B ↦ A`, `C ↦ B`, the adjoint absorbing the one transposition, and the two structure
constants match by cyclicity alone.*
-/

/-- **The six summation slots, as one index.** -/
abbrev Six (ι : Type*) := (ι × ι) × (ι × ι) × (ι × ι) × (ι × ι) × (ι × ι) × (ι × ι)

/-- **THE RELABELLING**, `(e,f,m,k,h,g) ↦ (k,g,h,f,e,m)`. -/
def sixPerm : Six ι ≃ Six ι where
  toFun x := (x.2.2.2.1, x.2.2.2.2.2, x.2.2.2.2.1, x.2.1, x.1, x.2.2.1)
  invFun y := (y.2.2.2.2.1, y.2.2.2.1, y.2.2.2.2.2, y.1, y.2.2.1, y.2.1)
  left_inv _ := rfl
  right_inv _ := rfl

/-- **The six nested sums, as one.** -/
theorem sum6_collapse (F : (ι × ι) → (ι × ι) → (ι × ι) → (ι × ι) → (ι × ι) → (ι × ι) → ℝ) :
    (∑ e : ι × ι, ∑ f : ι × ι, ∑ m : ι × ι, ∑ k : ι × ι, ∑ h : ι × ι, ∑ g : ι × ι, F e f m k h g)
      = ∑ x : Six ι, F x.1 x.2.1 x.2.2.1 x.2.2.2.1 x.2.2.2.2.1 x.2.2.2.2.2 := by
  simp only [Fintype.sum_prod_type]

/-- **Cyclicity the other way round**, which is the form the two factors need. -/
theorem ccS_cyc2 (p q r : ι × ι) : ccS p q r = ccS q r p := by
  rw [ccS_cyclic q r p]

set_option maxHeartbeats 1000000 in
/-- **THE SIX-FOLD SUM IS INVARIANT UNDER THE RELABELLING.** -/
theorem phiTri_index_sum_eq {A A' : CurvOp2 ι} (hadj : IsAdjoint2 A A') (B C : CurvOp2 ι) :
    (∑ e : ι × ι, ∑ f : ι × ι, ∑ m : ι × ι, ∑ k : ι × ι, ∑ h : ι × ι, ∑ g : ι × ι,
        ccS g h k * ccS e f m * matS A g e * matS B m k * matS C h f)
      = ∑ e : ι × ι, ∑ f : ι × ι, ∑ m : ι × ι, ∑ k : ι × ι, ∑ h : ι × ι, ∑ g : ι × ι,
        ccS g h k * ccS e f m * matS B g e * matS C m k * matS A' h f := by
  rw [sum6_collapse (fun e f m k h g =>
        ccS g h k * ccS e f m * matS A g e * matS B m k * matS C h f),
    sum6_collapse (fun e f m k h g =>
        ccS g h k * ccS e f m * matS B g e * matS C m k * matS A' h f)]
  refine Fintype.sum_equiv sixPerm _ _ ?_
  rintro ⟨e, f, m, k, h, g⟩
  show ccS g h k * ccS e f m * matS A g e * matS B m k * matS C h f
      = ccS m e f * ccS k g h * matS B m k * matS C h f * matS A' e g
  rw [matS_adjoint hadj g e, ccS_cyc2 m e f, ccS_cyc2 k g h]
  ring



set_option maxHeartbeats 1000000 in
/-- **THE ROTATION, IN ITS UNCONDITIONAL STARRED FORM.** `Φ(A;B,C) = Φ(B;C,A*)`, which is what
[second-order.md](../../../findings/second-order.md)'s step 3 derives and what
[r1013](../../../reviews/REVIEW_r1013.md) and [r1014](../../../reviews/REVIEW_r1014.md) verified.
**PROVED, 2026-09-19**, by the index form and the relabelling `sixPerm`, *so nothing in the first
variation of `P` rests on a `sorry` any longer.*

*A first version typed only the self-adjoint specialisation and gave as the reason that stating the
starred form "needs an adjoint on `CurvOp2`, which the layer does not carry"*
([r1017](../../../reviews/REVIEW_r1017.md)). **That blocker was one `Prop` wide**: taking the
adjoint as a RELATION rather than as a constructed operator needs no instance at all, and it makes
the `sorry` a debt for the statement the reviewers actually checked rather than for a corollary of
it.

**THE HYPOTHESIS IS LOAD-BEARING AND A FIRST CONTROL SAID OTHERWISE**
([screen](../../../scripts/misc/screen_phitri_constants.py)): *one structured non-self-adjoint
witness cleared the plain rotation at residual exactly zero, while over random triples it fails
every time and the starred form never does.* **One witness is not a control.** *This lesson was
lost once already, deleted with the docstring that carried it when this `sorry` was promoted*
([r1018](../../../reviews/REVIEW_r1018.md)).

**IT HAD TO BE EARNED: `phiTri_swap_outer` GENERATES NO FURTHER SLOT PERMUTATION.** *Of `Φ`'s six slot
permutations exactly TWO agree at arbitrary triples, the identity and the outer swap, and the other
four fail at `n = 4` by exact counterexample*
([screen](../../../scripts/misc/screen_phitri_symmetry_group.py)). **So the subgroup the proved
swap generates has order two and contains no 3-cycle.** *That is a fact about slot permutations and
not about proofs, which is the reach [r1017](../../../reviews/REVIEW_r1017.md) corrected.*
**The three ingredients the relabelling needs are now all on file**: the substitution, `ccS_cyclic`,
and `matS_adjoint` above, *the last of which
[r1018](../../../reviews/REVIEW_r1018.md) found absent while the record called the list complete.* **At
self-adjoint triples all six agree**, which is [second-order.md](../../../findings/second-order.md)'s
step 5 full symmetry of `T`, sampled rather than proved. -/
theorem phiTri_starred {A A' : CurvOp2 ι} (h : IsAdjoint2 A A') (B C : CurvOp2 ι) :
    phiTri A B C = phiTri B C A' := by
  rw [phiTri_index, phiTri_index, phiTri_index_sum_eq h]

/-- **AND ITS SELF-ADJOINT SPECIALISATION**, which is what the first variation consumes. -/
theorem phiTri_rotate {A : CurvOp2 ι} (hA : IsSelfAdjoint2 A) (B C : CurvOp2 ι) :
    phiTri A B C = phiTri B C A :=
  phiTri_starred hA.isAdjoint2 B C

/-- **THE `Φ` HALF OF THE FIRST VARIATION**, from the two above. *The three terms of the
`t`-coefficient collapse to three copies of one, the first by the outer swap with no hypothesis
and the second by the rotation.* -/
theorem phiTri_first_variation {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R) (S : CurvOp2 ι) :
    phiTri S R R + phiTri R S R + phiTri R R S = 3 * phiTri S R R := by
  rw [phiTri_swap_outer R R S, phiTri_rotate hR S R]
  ring

/-! ## The sharp half along the line -/

/-- **`Φ(R+tS, R+tS, R+tS)` expanded**, which is what trilinearity is for. -/
theorem phiTri_line (R S : CurvOp2 ι) (t : ℝ) :
    phiTri (R + t • S) (R + t • S) (R + t • S)
      = phiTri R R R
        + t * (phiTri S R R + phiTri R S R + phiTri R R S)
        + t^2 * (phiTri R S S + phiTri S R S + phiTri S S R)
        + t^3 * phiTri S S S := by
  simp only [phiTri_add_left, phiTri_add_mid, phiTri_add_right,
    phiTri_smul_left, phiTri_smul_mid, phiTri_smul_right]
  ring

/-- **`⟨R, R#⟩` along the line, as a cubic polynomial in `t`.** -/
theorem sharpPair2_line (R S : CurvOp2 ι) (t : ℝ) :
    sharpPair2 (R + t • S)
      = sharpPair2 R
        + t * (-(1/2) * (phiTri S R R + phiTri R S R + phiTri R R S))
        + t^2 * (-(1/2) * (phiTri R S S + phiTri S R S + phiTri S S R))
        + t^3 * sharpPair2 S := by
  rw [sharpPair2_eq_phiTri (R + t • S), sharpPair2_eq_phiTri R, sharpPair2_eq_phiTri S,
    phiTri_line]
  ring

/-- **THE SHARP HALF IS A DERIVATIVE.** -/
theorem hasDerivAt_sharpPair2_line (R S : CurvOp2 ι) :
    HasDerivAt (fun t : ℝ => sharpPair2 (R + t • S))
      (-(1/2) * (phiTri S R R + phiTri R S R + phiTri R R S)) 0 := by
  rw [funext (sharpPair2_line R S)]
  exact hasDerivAt_cubic _ _ _ _

/-- **AND ITS VALUE IS `3⟨S, R#⟩` at a self-adjoint `R`**, through the `Φ` half's collapse. -/
theorem hasDerivAt_sharpPair2_line_selfAdjoint {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R)
    (S : CurvOp2 ι) :
    HasDerivAt (fun t : ℝ => sharpPair2 (R + t • S)) (3 * innerOp2 S (sharpMapCL R)) 0 := by
  have h := hasDerivAt_sharpPair2_line R S
  rw [phiTri_first_variation hR S] at h
  rw [innerOp2_sharpMap_eq_phiTri R S]
  convert h using 1
  ring

/-! ## The GENERAL increment for the sharp half, and for `P` -/

/-- **`Φ` at a general increment.** -/
theorem phiTri_expand (R H : CurvOp2 ι) :
    phiTri (R + H) (R + H) (R + H)
      = phiTri R R R
        + (phiTri H R R + phiTri R H R + phiTri R R H)
        + (phiTri R H H + phiTri H R H + phiTri H H R)
        + phiTri H H H := by
  simp only [phiTri_add_left, phiTri_add_mid, phiTri_add_right]
  ring

/-- **`⟨R, R#⟩` at a general increment.** -/
theorem sharpPair2_expand (R H : CurvOp2 ι) :
    sharpPair2 (R + H)
      = sharpPair2 R
        + (-(1/2) * (phiTri H R R + phiTri R H R + phiTri R R H))
        + (-(1/2) * (phiTri R H H + phiTri H R H + phiTri H H R))
        + sharpPair2 H := by
  rw [sharpPair2_eq_phiTri (R + H), sharpPair2_eq_phiTri R, sharpPair2_eq_phiTri H, phiTri_expand]
  ring

/-- **`P` AT A GENERAL INCREMENT**, constant, linear, quadratic and cubic. *This is the shape a
Fréchet derivative needs and the `_line` lemmas do not give, since they scalarise `t` out before
the remainder is named* ([r1016](../../../reviews/REVIEW_r1016.md)). **The remainder is still only
NAMED here, not estimated**: `Pcubic2Quad` is a function of `H` and nothing yet bounds it by
`‖H‖²`, which is what the estimate would need. -/
noncomputable def Pcubic2Lin (R H : CurvOp2 ι) : ℝ :=
  (innerOp2 (H.comp R) R + innerOp2 (R.comp H) R + innerOp2 (compOp2 R) H)
    + -(1/2) * (phiTri H R R + phiTri R H R + phiTri R R H)

/-- **The quadratic part of the increment.** -/
noncomputable def Pcubic2Quad (R H : CurvOp2 ι) : ℝ :=
  (innerOp2 (compOp2 H) R + innerOp2 (H.comp R) H + innerOp2 (R.comp H) H)
    + -(1/2) * (phiTri R H H + phiTri H R H + phiTri H H R)

theorem Pcubic2_expand (R H : CurvOp2 ι) :
    Pcubic2 (R + H) = Pcubic2 R + Pcubic2Lin R H + Pcubic2Quad R H + Pcubic2 H := by
  unfold Pcubic2 Pcubic2Lin Pcubic2Quad
  rw [trCube2_expand, sharpPair2_expand]
  ring

/-- **AND THE LINEAR PART IS `3⟨H, Q(R)⟩` at a self-adjoint `R`**, which is the first variation
read off the general increment rather than off a line. -/
theorem Pcubic2Lin_selfAdjoint {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R) (H : CurvOp2 ι) :
    Pcubic2Lin R H = 3 * innerOp2 H (Qop2 R) := by
  unfold Pcubic2Lin Qop2
  rw [trCube2_first_variation R H hR, phiTri_first_variation hR H, innerOp2_add_right,
    innerOp2_sharpMap_eq_phiTri R H]
  ring

end HamiltonsCubic.RealLayer
