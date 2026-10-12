import HamiltonsCubic.Base.StructureConstants
import HamiltonsCubic.Base.StructureSquare
import HamiltonsCubic.Base.FoxProduct
import HamiltonsCubic.Base.Families

set_option linter.style.longLine false

/-!
# `#` on the diagonal locus: `DiagCubicFormula`, proved

[Families.lean](Families.lean)'s `DiagCubicFormula` WAS the record's largest single unproved
dependency. It is proved at the foot of this file.

**It is the SUM of [L57](../../../findings/problem.md)'s two bridge identities and NOT their
conjunction**, so it follows from L57's bridge and does not imply it
([r1001](../../../reviews/REVIEW_r1001.md)). *A cancelling pair of errors satisfies the sum and
neither conjunct, which is the pair [post F11](../../../findings/second-order.md) says must be
priced together.* **What discharges L57 is that `trCube_diagOp` and `sharpPair_diagOp` prove the
two conjuncts SEPARATELY**, and the record said "the same statement under another name" at three
sites.

**The whole gap is `sharpOp (diagOp w)` on the `φ` basis**, which no file evaluates.
[StructureConstants.lean](StructureConstants.lean)'s `sum_inner2_ad2` cannot reach it: it computes
`br X (br Y ·)` with nothing between the brackets, while `sharpQF R η` has `R` in the middle, and
`diagOp` is a Hadamard action rather than a matrix multiplication, so the four-conjugation route
the anchor uses does not apply.

**What this file does instead is evaluate the double bracket directly**, from `br_phi_phi`: at
`η = φ_ab` the inner bracket lands on the basis directions sharing exactly one index with `{a,b}`,
`diagOp` scales each by its own weight, and the outer bracket returns it. *So the `2(n-2)`
directions the anchor counts each contribute their COMPLEMENTARY weight.*

**`sharpQF_diagOp` is PROVED here**, on the standard three axioms, and it was the whole of the
missing evaluation. *The mechanism is that `ad_{φab} ∘ diagOp w` squared is DIAGONAL on the `φ`
family, with eigenvalue `-w_ad·w_bd` on `φ_ad` and on `φ_bd` and zero everywhere else, so the
ordered-pair sum is four copies of one number per index `d`.*

**AND `DiagCubicFormula` FOLLOWS**, `diagCubicFormula` at the foot of this file, on the same
axioms. *`trCube (diagOp w)` is HALF the entrywise cube sum and `sharpPair (diagOp w)` is `½ tr w³`, so
`Pcubic` on the locus is [diagonal-half.md](../../../findings/diagonal-half.md)'s weighted-graph
functional verbatim.*

**THIS FILE IS WHAT MACHINE-CHECKS [L231](../../../findings/INDEX-results.md)**, *`P` on the diagonal
locus is the weighted-graph functional at every `n` and every weight*, and the id is written here so a
grep for `L231` reaches it. *It carried no row in [lean/INDEX.md](../../INDEX.md) for as long as the
file named only the SUBJECT, which is the invisible half of the layer's debt: no `sorry` to grep and no
declaration to check, the mathematics proved the whole time.*
-/

namespace HamiltonsCubic.RealLayer

open HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`diagOp` is additive**, which the layer needs to push it through `br_phi_phi`'s four-term
bracket and did not carry. *One `ext` and a `ring`.* -/
theorem diagOp_add (w X Y : Matrix ι ι ℝ) :
    diagOp w (X + Y) = diagOp w X + diagOp w Y := by
  ext p q
  simp only [diagOp, Matrix.of_apply, Matrix.add_apply]
  ring

/-- **`diagOp` commutes with scaling.** -/
theorem diagOp_smul_arg (w : Matrix ι ι ℝ) (c : ℝ) (X : Matrix ι ι ℝ) :
    diagOp w (c • X) = c • diagOp w X := by
  ext p q
  simp only [diagOp, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul]
  ring

/-- **`diagOp` of a difference.** -/
theorem diagOp_sub (w X Y : Matrix ι ι ℝ) :
    diagOp w (X - Y) = diagOp w X - diagOp w Y := by
  ext p q
  simp only [diagOp, Matrix.of_apply, Matrix.sub_apply]
  ring

/-! ## The pieces the evaluation needs

**`br_smul_right`, `br_self` and `inner2_smul_left` already exist**, in
[FoxProduct.lean](FoxProduct.lean) and [StructureSquare.lean](StructureSquare.lean), and are
imported rather than restated, as is [Families.lean](Families.lean)'s `inner2_self_phi`, the
normalisation every coefficient below is read against. *What this section adds is the `diagOp`
facts the argument side lacked.*
`edgeProd` names the quantity the whole evaluation returns, so the case analysis and the summation
can be read separately.
-/

/-- **`br` of zero on the right.** -/
theorem br_zero_right (X : Matrix ι ι ℝ) : br X 0 = 0 := by simp [br]

/-- **`diagOp` of zero.** -/
theorem diagOp_zero (w : Matrix ι ι ℝ) : diagOp w (0 : Matrix ι ι ℝ) = 0 := by
  ext p q
  simp [diagOp]

/-- **`diagOp` of a negative**, which is `diagOp_sub` at `X = 0`. -/
theorem diagOp_neg (w X : Matrix ι ι ℝ) : diagOp w (-X) = -diagOp w X := by
  ext p q
  simp [diagOp]

/-- **The per-index contributor.** *A `d` sharing an index with `{a,b}` contributes nothing, and
every other `d` contributes the PRODUCT of the two weights on the edges joining it to `a` and
to `b`.* -/
def edgeProd (w : Matrix ι ι ℝ) (a b d : ι) : ℝ :=
  if d = a then 0 else if d = b then 0 else w a d * w b d

/-! ## `(ad_η ∘ W)²` on one basis direction

**The composite is DIAGONAL on the `φ` family**, and that is the whole evaluation. *`W` is met
twice, once on the direction and once on its partner across `{a,b}`, which is where the product
comes from and where the first version of this file's closed form went wrong.*
-/

/-- **The composite is ODD in its argument**, which carries each case below to its swapped one. -/
theorem adW_sq_neg (w : Matrix ι ι ℝ) (a b : ι) (Y : Matrix ι ι ℝ) :
    br (phi a b) (diagOp w (br (phi a b) (diagOp w (-Y))))
      = -br (phi a b) (diagOp w (br (phi a b) (diagOp w Y))) := by
  rw [diagOp_neg, br_neg, diagOp_neg, br_neg]

/-- **`(ad_η ∘ W)² φ_ad = -(w_ad·w_bd)·φ_ad`** at `d ∉ {a,b}`. -/
theorem adW_sq_phi_left (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (a b d : ι)
    (hab : a ≠ b) (had : a ≠ d) (hbd : b ≠ d) :
    br (phi a b) (diagOp w (br (phi a b) (diagOp w (phi a d))))
      = (-(w a d * w b d)) • phi a d := by
  have h1 : br (phi a b) (phi a d) = phi b d := by
    rw [br_phi_phi]
    simp [hab, had, hbd, Ne.symm hab, Ne.symm had, Ne.symm hbd]
  have h2 : br (phi a b) (phi b d) = - phi a d := br_phi_share a b d hab had hbd
  rw [diagOp_phi w hw, br_smul_right, h1, diagOp_smul_arg, diagOp_phi w hw, smul_smul,
    br_smul_right, h2, smul_neg, ← neg_smul]

/-- **`(ad_η ∘ W)² φ_bd = -(w_ad·w_bd)·φ_bd`** at `d ∉ {a,b}`, the partner direction. -/
theorem adW_sq_phi_right (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (a b d : ι)
    (hab : a ≠ b) (had : a ≠ d) (hbd : b ≠ d) :
    br (phi a b) (diagOp w (br (phi a b) (diagOp w (phi b d))))
      = (-(w a d * w b d)) • phi b d := by
  have h1 : br (phi a b) (phi b d) = - phi a d := br_phi_share a b d hab had hbd
  have h2 : br (phi a b) (phi a d) = phi b d := by
    rw [br_phi_phi]
    simp [hab, had, hbd, Ne.symm hab, Ne.symm had, Ne.symm hbd]
  rw [diagOp_phi w hw, br_smul_right, h1, smul_neg, ← neg_smul, diagOp_smul_arg, diagOp_phi w hw,
    smul_smul, br_smul_right, h2]
  congr 1
  ring

/-- **The composite kills every direction disjoint from `{a,b}`.** -/
theorem adW_sq_phi_disjoint (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (a b i j : ι)
    (hai : a ≠ i) (haj : a ≠ j) (hbi : b ≠ i) (hbj : b ≠ j) :
    br (phi a b) (diagOp w (br (phi a b) (diagOp w (phi i j)))) = 0 := by
  rw [diagOp_phi w hw, br_smul_right, br_phi_disjoint a b i j hai haj hbi hbj, smul_zero,
    diagOp_zero, br_zero_right]

/-- **The composite kills `φ_ab` itself**, the one direction of the pair. -/
theorem adW_sq_phi_eta (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (a b : ι) :
    br (phi a b) (diagOp w (br (phi a b) (diagOp w (phi a b)))) = 0 := by
  rw [diagOp_phi w hw, br_smul_right, br_self, smul_zero, diagOp_zero, br_zero_right]

/-- **`(ad_η ∘ W)² φ_da = -(w_ad·w_bd)·φ_da`**, the direction of `adW_sq_phi_left` reversed. -/
theorem adW_sq_phi_left_swap (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (a b d : ι)
    (hab : a ≠ b) (had : a ≠ d) (hbd : b ≠ d) :
    br (phi a b) (diagOp w (br (phi a b) (diagOp w (phi d a))))
      = (-(w a d * w b d)) • phi d a := by
  rw [phi_swap a d, adW_sq_neg, adW_sq_phi_left w hw a b d hab had hbd]
  simp

/-- **`(ad_η ∘ W)² φ_db = -(w_ad·w_bd)·φ_db`**, the direction of `adW_sq_phi_right` reversed. -/
theorem adW_sq_phi_right_swap (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (a b d : ι)
    (hab : a ≠ b) (had : a ≠ d) (hbd : b ≠ d) :
    br (phi a b) (diagOp w (br (phi a b) (diagOp w (phi d b))))
      = (-(w a d * w b d)) • phi d b := by
  rw [phi_swap b d, adW_sq_neg, adW_sq_phi_right w hw a b d hab had hbd]
  simp

/-- **`⟨(diagOp w)# φ_ab, φ_ab⟩` in closed form**, at every symmetric weight, with no hollowness
and no row-sum hypothesis. *Each surviving direction is scaled on the way IN by one weight and on
the way OUT by its complementary one, so it contributes the PRODUCT `w_ad · w_bd`.*

**The first version of this statement was FALSE and is corrected here**, r999 and r1000 on
identical briefs, agreeing. *It claimed `½ Σ (w_ad + w_bd)`, which is LINEAR in `w` where `sharpQF`
is quadratic: the definition applies `R` TWICE, `br η (R (br η (R φ)))`, and the brief that stated
it applied `R` once.* **A linear form cannot equal a quadratic one**, so it failed before any
arithmetic. Separating witness at `n = 3`, symmetric hollow `w₀₂ = 2`, `w₁₂ = 3`, `w₀₁ = -5`: the
record's `sharpQF` returns `6` and the claimed form `5/2`.

**Symmetry of `w` is a hypothesis of the statement**, and the first version of this theorem bound
only `hab` while this comment named the regime. *`diagOp w (phi i j)` carries `w_ji` at `(j,i)` and
`-w_ij` at `(i,j)`, so at an asymmetric `w` it is neither skew nor a multiple of `phi i j`, and the
mechanism below, each direction keeping its own weight through both applications of `R`, has
nothing to act on.* **A screen agrees at 144 of 144 symmetric weights and disagrees at 72 of 72
asymmetric ones**, [screen_I66_sharpQF_symmetry.py](../../../scripts/misc/screen_I66_sharpQF_symmetry.py).

*With `w` hollow the sum is `(w²)_ab`.* -/
theorem sharpQF_diagOp (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (a b : ι) (hab : a ≠ b) :
    sharpQF (diagOp w) (phi a b)
      = ∑ d : ι, (if d = a then 0 else if d = b then 0 else w a d * w b d) := by
  -- **The composite is diagonal on the `φ` family**, so each ordered pair contributes one number.
  have key : ∀ i j : ι,
      inner2 (br (phi a b) (diagOp w (br (phi a b) (diagOp w (phi i j))))) (phi i j)
        = -((if i = a then edgeProd w a b j else 0) + (if i = b then edgeProd w a b j else 0)
            + (if j = a then edgeProd w a b i else 0)
            + (if j = b then edgeProd w a b i else 0)) := by
    intro i j
    by_cases hij : i = j
    · -- `φ_ii = 0`, and every `edgeProd` that could fire sits at `a` or at `b`
      rw [hij, phi_self]
      by_cases h1 : j = a
      · rw [h1]; simp [inner2, edgeProd, hab]
      · by_cases h2 : j = b
        · rw [h2]; simp [inner2, edgeProd, hab, Ne.symm hab]
        · simp [inner2, edgeProd, h1, h2]
    by_cases hia : i = a
    · have haj : a ≠ j := fun h => hij (hia.trans h)
      by_cases hjb : j = b
      · -- `φ_ab` itself, which the composite kills
        rw [hia, hjb, adW_sq_phi_eta w hw]
        simp [inner2, edgeProd, hab, Ne.symm hab]
      · have hbj : b ≠ j := fun h => hjb h.symm
        rw [hia, adW_sq_phi_left w hw a b j hab haj hbj, HamiltonsCubic.RealLayer.inner2_smul_left,
          inner2_self_phi a j haj]
        simp [edgeProd, hab, Ne.symm haj, hjb]
    by_cases hib : i = b
    · by_cases hja : j = a
      · -- `φ_ba`, which is `-φ_ab`
        rw [hib, hja, phi_swap a b, adW_sq_neg, adW_sq_phi_eta w hw]
        simp [inner2, edgeProd, hab, Ne.symm hab]
      · have haj : a ≠ j := fun h => hja h.symm
        have hbj : b ≠ j := fun h => hij (hib.trans h)
        rw [hib, adW_sq_phi_right w hw a b j hab haj hbj, HamiltonsCubic.RealLayer.inner2_smul_left,
          inner2_self_phi b j hbj]
        simp [edgeProd, hab, Ne.symm hab, hja, Ne.symm hbj]
    · have hai : a ≠ i := fun h => hia h.symm
      have hbi : b ≠ i := fun h => hib h.symm
      by_cases hja : j = a
      · rw [hja, adW_sq_phi_left_swap w hw a b i hab hai hbi, HamiltonsCubic.RealLayer.inner2_smul_left,
          inner2_self_phi i a hia]
        simp [edgeProd, hab, hia, hib, Ne.symm hai, Ne.symm hbi]
      · by_cases hjb : j = b
        · rw [hjb, adW_sq_phi_right_swap w hw a b i hab hai hbi, HamiltonsCubic.RealLayer.inner2_smul_left,
            inner2_self_phi i b hib]
          simp [edgeProd, hab, Ne.symm hab, hia, hib, Ne.symm hai, Ne.symm hbi]
        · have haj : a ≠ j := fun h => hja h.symm
          have hbj : b ≠ j := fun h => hjb h.symm
          rw [adW_sq_phi_disjoint w hw a b i j hai haj hbi hbj]
          simp [inner2, edgeProd, hia, hib, hja, hjb]
  -- **Each of the four terms sums to the same thing**, `a` and `b` each taking one index.
  have hsumA : ∀ c : ι, (∑ i : ι, ∑ j : ι, (if i = c then edgeProd w a b j else 0))
      = ∑ d : ι, edgeProd w a b d := by
    intro c
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun j _ => by simp
  have hsumB : ∀ c : ι, (∑ i : ι, ∑ j : ι, (if j = c then edgeProd w a b i else 0))
      = ∑ d : ι, edgeProd w a b d := by
    intro c
    exact Finset.sum_congr rfl fun i _ => by simp
  have hbig : (∑ i : ι, ∑ j : ι,
      -((if i = a then edgeProd w a b j else 0) + (if i = b then edgeProd w a b j else 0)
        + (if j = a then edgeProd w a b i else 0) + (if j = b then edgeProd w a b i else 0)))
      = -(4 * ∑ d : ι, edgeProd w a b d) := by
    simp only [neg_add, Finset.sum_add_distrib, Finset.sum_neg_distrib]
    rw [hsumA a, hsumA b, hsumB a, hsumB b]
    ring
  unfold sharpQF
  simp only [key]
  rw [hbig]
  simp only [edgeProd]
  ring

/-! ## From the evaluation to `DiagCubicFormula`

**What is left is assembly.** *`Pcubic` is `trCube + sharpPair`, each of which is one `innerOp` over
the `φ` family, and `diagOp_phi` makes every basis direction an eigenvector. The only work is that
`sharpPair` reaches `sharpQF` through `sharpOp` and `sharpBil`, so the polarisation has to be
collapsed back to the quadratic form before `sharpQF_diagOp` can be read.*
-/

/-- **`br` scales in its FIRST argument**, the side [FoxProduct.lean](FoxProduct.lean) leaves out. -/
theorem br_smul_left (c : ℝ) (X Y : Matrix ι ι ℝ) : br (c • X) Y = c • br X Y := by
  simp [br, Matrix.mul_smul, Matrix.smul_mul, smul_sub]

/-- **`br` of zero on the left.** -/
theorem br_zero_left (Y : Matrix ι ι ℝ) : br 0 Y = 0 := by simp [br]

/-- **`inner2` distributes over a finite sum on the right.** -/
theorem inner2_sum_right {κ : Type*} (X : Matrix ι ι ℝ) (s : Finset κ)
    (f : κ → Matrix ι ι ℝ) : inner2 X (∑ k ∈ s, f k) = ∑ k ∈ s, inner2 X (f k) := by
  unfold inner2
  rw [Matrix.mul_sum, Matrix.trace_sum, Finset.mul_sum]

/-- **`diagOp w` is linear**, which is what lets the polarisation below be collapsed. -/
theorem isLinOp_diagOp (w : Matrix ι ι ℝ) : IsLinOp (diagOp w) :=
  ⟨diagOp_add w, fun c X => diagOp_smul_arg w c X⟩

/-- **`sharpQF` is homogeneous of degree `2` in its ARGUMENT**, `η` entering it twice.
*[FoxProduct.lean](FoxProduct.lean)'s `sharpQF_smul` is the same degree in the OPERATOR slot.* -/
theorem sharpQF_arg_smul (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (c : ℝ)
    (η : Matrix ι ι ℝ) : sharpQF R (c • η) = c ^ 2 * sharpQF R η := by
  unfold sharpQF
  have key : ∀ i j : ι, inner2 (br (c • η) (R (br (c • η) (R (phi i j))))) (phi i j)
      = c ^ 2 * inner2 (br η (R (br η (R (phi i j))))) (phi i j) := by
    intro i j
    have h1 : br (c • η) (R (phi i j)) = c • br η (R (phi i j)) := br_smul_left c η _
    rw [h1, hR.2, br_smul_left, br_smul_right, smul_smul,
      HamiltonsCubic.RealLayer.inner2_smul_left]
    ring
  have hsum : ∑ i : ι, ∑ j : ι, inner2 (br (c • η) (R (br (c • η) (R (phi i j))))) (phi i j)
      = c ^ 2 * ∑ i : ι, ∑ j : ι, inner2 (br η (R (br η (R (phi i j))))) (phi i j) := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun j _ => key i j
  rw [hsum]; ring

/-- **`sharpQF` vanishes at `0`.** -/
theorem sharpQF_arg_zero (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : sharpQF R 0 = 0 := by
  unfold sharpQF
  have : ∀ i j : ι, inner2 (br 0 (R (br 0 (R (phi i j))))) (phi i j) = 0 := by
    intro i j
    rw [br_zero_left]
    simp [inner2]
  simp [this]

/-- **The polarisation on the diagonal**, `⟨R# X, X⟩ = sharpQF R X`. -/
theorem sharpBil_self (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (X : Matrix ι ι ℝ) :
    sharpBil R X X = sharpQF R X := by
  unfold sharpBil
  rw [show X + X = (2 : ℝ) • X from (two_smul ℝ X).symm, sharpQF_arg_smul R hR]
  ring

/-- **The polarisation against the reversed direction**, which is where the sign comes from that
doubles `sharpPair`'s per-pair contribution rather than cancelling it. -/
theorem sharpBil_neg_self (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (X : Matrix ι ι ℝ) :
    sharpBil R X (-X) = - sharpQF R X := by
  have hneg : sharpQF R (-X) = sharpQF R X := by
    rw [show -X = (-1 : ℝ) • X from by module, sharpQF_arg_smul R hR]
    ring
  unfold sharpBil
  rw [show X + -X = (0 : Matrix ι ι ℝ) from by abel, sharpQF_arg_zero, hneg]
  ring

/-- **`tr W³` on the diagonal locus** is HALF the entrywise cube sum, `½ ∑_{a,b} w_{ab}³`, **at
every `w`, symmetric or not**. *The factor is in the statement and was twice dropped from the prose
around it, where an ordered-pair sum double counts and the `½` is what undoes it.* *Each ordered pair contributes `½(w_ji³ + w_ij³)` because `diagOp` meets the two entries of
`φ_ij` separately, and the two halves of the ordered-pair sum put that back together.* **Hollowness
is the only hypothesis**, and it is there to kill `w_aa³` on the right rather than anything on the
left.

*The first version of this bound symmetry as well, which [r1001](../../../reviews/REVIEW_r1001.md)
found superfluous.* **The binder was inherited from the route rather than from the statement**: the
proof reached for `diagOp_phi`, which makes `φ_ij` an eigenvector and needs symmetry, where the
entries alone suffice. -/
theorem trCube_diagOp (w : Matrix ι ι ℝ) (hh : ∀ a, w a a = 0) :
    trCube (diagOp w) = (1/2) * ∑ a : ι, ∑ b : ι, (w a b) ^ 3 := by
  -- `∑_p ∑_q f p q` supported at one cell reads off that cell.
  have hcol : ∀ c d : ι,
      (∑ p : ι, ∑ q : ι, (if c = p then (if d = q then (w p q) ^ 3 else 0) else 0))
        = (w c d) ^ 3 := by
    intro c d
    have h1 : ∀ p : ι, (∑ q : ι, (if c = p then (if d = q then (w p q) ^ 3 else 0) else 0))
        = (if c = p then (w p d) ^ 3 else 0) := by
      intro p
      by_cases hp : c = p <;> simp [hp]
    rw [Finset.sum_congr rfl fun p _ => h1 p]
    simp
  have key : ∀ i j : ι,
      inner2 (diagOp w (diagOp w (phi i j))) (diagOp w (phi i j))
        = (1/2) * ((w j i) ^ 3 + (w i j) ^ 3) := by
    intro i j
    have hpt : ∀ p q : ι,
        (diagOp w (diagOp w (phi i j))) p q * (diagOp w (phi i j)) p q
          = (w p q) ^ 3 * (phi i j p q) ^ 2 := by
      intro p q
      simp only [diagOp, Matrix.of_apply]
      ring
    rw [inner2_eq_sum]
    by_cases hij : i = j
    · subst hij
      have hz : ∀ p q : ι, (w p q) ^ 3 * (phi i i p q) ^ 2 = 0 := by
        intro p q; rw [phi_self]; simp
      simp only [hpt, hz, Finset.sum_const_zero]
      rw [hh i]
      ring
    · have hv : ∀ p q : ι, phi i j p q
          = (if j = p then (if i = q then (1:ℝ) else 0) else 0)
            - (if i = p then (if j = q then (1:ℝ) else 0) else 0) := by
        intro p q
        simp [phi, Matrix.single_apply, ite_and]
      have hne : ∀ p : ι, j = p → ¬ i = p := fun p hjp hip => hij (hip.trans hjp.symm)
      have hsq : ∀ p q : ι, (w p q) ^ 3 * (phi i j p q) ^ 2
          = (if j = p then (if i = q then (w p q) ^ 3 else 0) else 0)
            + (if i = p then (if j = q then (w p q) ^ 3 else 0) else 0) := by
        intro p q
        rw [hv p q]
        by_cases h1 : j = p
        · have h3 : ¬ i = p := hne p h1
          by_cases h2 : i = q
          · have h5 : ¬ q = p := fun h => h3 (h2.trans h)
            simp [h1, h2, h3, h5]
          · simp [h1, h2, h3]
        · by_cases h3 : i = p
          · by_cases h4 : j = q
            · have h7 : ¬ q = p := fun h => h1 (h4.trans h)
              simp [h1, h3, h4, h7]
            · simp [h1, h3, h4]
          · simp [h1, h3]
      simp only [hpt, hsq, Finset.sum_add_distrib]
      rw [hcol j i, hcol i j]
  unfold trCube innerOp compOp
  have e : ∑ i : ι, ∑ j : ι, inner2 (diagOp w (diagOp w (phi i j))) (diagOp w (phi i j))
      = ∑ i : ι, ∑ j : ι, ((1/2 : ℝ) * (w j i) ^ 3 + (1/2 : ℝ) * (w i j) ^ 3) := by
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    rw [key i j]; ring
  rw [e]
  simp only [Finset.sum_add_distrib]
  rw [show (∑ i : ι, ∑ j : ι, (1/2 : ℝ) * (w j i) ^ 3)
      = ∑ i : ι, ∑ j : ι, (1/2 : ℝ) * (w i j) ^ 3 from Finset.sum_comm]
  simp only [← Finset.mul_sum]
  ring

/-- **`⟨W, W#⟩` reads one `sharpQF` per ordered pair.** *`sharpOp` resolves `R# φ_ij` in the `φ`
family, `inner2_phi_phi` collapses the resolution to the two pairs `(i,j)` and `(j,i)`, and the
second contributes `+sharpQF` rather than `-sharpQF` because `φ_ji = -φ_ij` reverses the sign
twice.* -/
theorem sharpPair_term_diagOp (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (i j : ι) :
    inner2 (diagOp w (phi i j)) (sharpOp (diagOp w) (phi i j))
      = w i j * sharpQF (diagOp w) (phi i j) := by
  have hlin := isLinOp_diagOp w
  unfold sharpOp
  rw [diagOp_phi w hw, HamiltonsCubic.RealLayer.inner2_smul_left, inner2_smul_right,
    inner2_sum_right]
  have hinner : ∀ k : ι, inner2 (phi i j) (∑ l : ι, (sharpBil (diagOp w) (phi i j) (phi k l)) • phi k l)
      = ∑ l : ι, (sharpBil (diagOp w) (phi i j) (phi k l)) * inner2 (phi i j) (phi k l) := by
    intro k
    rw [inner2_sum_right]
    exact Finset.sum_congr rfl fun l _ => inner2_smul_right _ _ _
  rw [Finset.sum_congr rfl fun k _ => hinner k]
  have hcollapse : ∑ k : ι, ∑ l : ι,
      (sharpBil (diagOp w) (phi i j) (phi k l)) * inner2 (phi i j) (phi k l)
      = sharpBil (diagOp w) (phi i j) (phi i j) - sharpBil (diagOp w) (phi i j) (phi j i) := by
    simp only [inner2_phi_phi, mul_sub, Finset.sum_sub_distrib, mul_ite, mul_one, mul_zero,
      ite_and, Finset.sum_ite_eq]
    simp
  rw [hcollapse, sharpBil_self _ hlin, phi_swap i j, sharpBil_neg_self _ hlin]
  ring

/-- **`⟨W, W#⟩` on the diagonal locus** is `½ tr w³`. *Each ordered pair contributes
`w_ij · ∑_{d ∉ {i,j}} w_id w_jd`, and hollowness kills exactly the terms the exclusion drops, so
the triple sum is the unrestricted one, which symmetry turns into the matrix cube.* -/
theorem sharpPair_diagOp (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0) :
    sharpPair (diagOp w) = (1/2) * (w * w * w).trace := by
  unfold sharpPair innerOp
  have hterm : ∀ i j : ι, inner2 (diagOp w (phi i j)) (sharpOp (diagOp w) (phi i j))
      = ∑ d : ι, w i j * (w i d * w j d) := by
    intro i j
    rw [sharpPair_term_diagOp w hw i j]
    by_cases hij : i = j
    · subst hij
      simp [hh]
    · rw [sharpQF_diagOp w hw i j hij, Finset.mul_sum]
      refine Finset.sum_congr rfl fun d _ => ?_
      by_cases hdi : d = i
      · subst hdi; simp [hh]
      · by_cases hdj : d = j
        · subst hdj; simp [hh]
        · simp [hdi, hdj]
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hterm i j]
  have hTr : (w * w * w).trace = ∑ i : ι, ∑ j : ι, ∑ d : ι, w i j * (w i d * w j d) := by
    simp only [Matrix.trace, Matrix.diag_apply, Matrix.mul_apply, Finset.sum_mul]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun j _ => ?_
    refine Finset.sum_congr rfl fun d _ => ?_
    rw [hw d i]
    ring
  rw [hTr]

/-- **`DiagCubicFormula`, PROVED.** *The record's largest single unproved dependency.* **It is
the SUM of [L57](../../../findings/problem.md)'s two bridge identities and not their conjunction**,
so it follows from L57's bridge and does not imply it
([r1001](../../../reviews/REVIEW_r1001.md)). *What discharges L57 is that `trCube_diagOp` and
`sharpPair_diagOp` above prove the two conjuncts SEPARATELY.* -/
theorem diagCubicFormula : DiagCubicFormula (ι := ι) := by
  intro w hwt
  unfold Pcubic diagP
  rw [trCube_diagOp w hwt.hollow, sharpPair_diagOp w hwt.symm hwt.hollow]
  ring

/-- **`br` is additive in its left slot.** -/
theorem br_add_left (X Y Z : Matrix ι ι ℝ) : br (X + Y) Z = br X Z + br Y Z := by
  unfold br; rw [Matrix.add_mul, Matrix.mul_add]; abel

/-- **`br` is additive in its right slot**, which the polarisation needs as well: the OUTER
bracket takes a sum only after `R` has been distributed inside it. -/
theorem br_add_right (X Y Z : Matrix ι ι ℝ) : br X (Y + Z) = br X Y + br X Z := by
  unfold br; rw [Matrix.mul_add, Matrix.add_mul]; abel

/-- **`br` is subtractive in its right slot.** *`br_phi_phi` returns a signed SUM of four `φ`s, so
expanding it through the outer bracket needs this as well as `br_add_right`.* -/
theorem br_sub_right (X Y Z : Matrix ι ι ℝ) : br X (Y - Z) = br X Y - br X Z := by
  unfold br; rw [Matrix.mul_sub, Matrix.sub_mul]; abel

/-- **THE POLARISATION, WRITTEN OUT.** *`sharpQF R η` applies `R` twice and brackets against `η`
twice, so it is a QUADRATIC form in `η` and `sharpBil` is its associated symmetric bilinear form.
Expanding `br (X + Y) ·` in both slots gives four terms, two of which are `sharpQF R X` and
`sharpQF R Y`, and the halving in `sharpBil` cancels against the two cross terms.*

**THIS IS WHAT `sharpQF_diagOp` ALONE CANNOT REACH.** *That theorem evaluates the quadratic form at
a single `φ`, which suffices for the SCALAR `⟨W, W#⟩` because `inner2_phi_phi` collapses the
resolution back to `(a,b)` and `(b,a)`. The OPERATOR needs the bilinear form at MIXED pairs, and
this is the identity that puts them within reach of the same mechanism.* -/
theorem sharpBil_expand (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (X Y : Matrix ι ι ℝ) :
    sharpBil R X Y
      = -(1/8 : ℝ) * ∑ i : ι, ∑ j : ι,
          (inner2 (br X (R (br Y (R (phi i j))))) (phi i j)
            + inner2 (br Y (R (br X (R (phi i j))))) (phi i j)) := by
  unfold sharpBil sharpQF
  have h : ∀ i j : ι,
      inner2 (br (X + Y) (R (br (X + Y) (R (phi i j))))) (phi i j)
        = inner2 (br X (R (br X (R (phi i j))))) (phi i j)
          + inner2 (br Y (R (br Y (R (phi i j))))) (phi i j)
          + (inner2 (br X (R (br Y (R (phi i j))))) (phi i j)
             + inner2 (br Y (R (br X (R (phi i j))))) (phi i j)) := by
    intro i j
    -- `rw` fires on the OUTER bracket first, leaving `R (br (X+Y) _)` with no sum for `hR.1`
    -- to match. `simp only` rewrites to a fixpoint, so the nesting resolves in either order.
    simp only [br_add_left, br_add_right, hR.1, HamiltonsCubic.RealLayer.inner2_add_left]
    ring
  simp only [h, Finset.sum_add_distrib]
  ring

/-- **THE `φ` FAMILY RESOLVES A BASIS BIVECTOR**, with the ordered-pair halving.
*`inner2_phi_phi` is the Gram matrix `δ_ik δ_jl - δ_jk δ_il`, so the double sum keeps `(a,b)` with
coefficient `+1` and `(b,a)` with `-1`, and `φ_ba = -φ_ab` makes both contribute `φ_ab`.* -/
theorem phi_resolve (a b : ι) :
    (1/2 : ℝ) • ∑ k : ι, ∑ l : ι, (inner2 (phi a b) (phi k l)) • phi k l = phi a b := by
  -- `a = b` is split off FIRST. Left in, it produces a case where `k` equals both, which the
  -- case simp cannot discharge because nothing tells it `a = b` follows from the two hypotheses.
  by_cases hab : a = b
  · subst hab; simp [phi_self, inner2, Matrix.transpose_zero, Matrix.zero_mul]
  -- Stated with a SUBTRACTION rather than a negated `phi`, because `phi_swap` inside the
  -- case simp rewrites `φ_ij = -φ_ji` forever and the tactic hits the recursion limit.
  have h : ∀ k : ι, ∑ l : ι, (inner2 (phi a b) (phi k l)) • phi k l
      = (if k = a then phi a b else 0) - (if k = b then phi b a else 0) := by
    intro k
    simp only [inner2_phi_phi, sub_smul, Finset.sum_sub_distrib, ite_and, ite_smul, zero_smul,
      Finset.mem_univ, if_true, one_smul]
    by_cases hka : k = a <;> by_cases hkb : k = b <;>
      simp_all [Finset.sum_ite_eq', Finset.sum_ite_eq, phi_self, eq_comm]
  rw [Finset.sum_congr rfl fun k _ => h k, Finset.sum_sub_distrib]
  simp only [Finset.sum_ite_eq', Finset.mem_univ, if_true]
  rw [phi_swap b a]
  module

/-- **`⟨W# φ_ab, φ_ab⟩ = (w²)_ab`**, the closed form of `sharpQF_diagOp` under hollowness.

*That theorem's sum EXCLUDES `d = a` and `d = b`, and hollowness is exactly what makes the excluded
terms zero anyway: `w_aa·w_ba = 0` and `w_ab·w_bb = 0`. So the restricted sum is the unrestricted
one, which is the matrix product.* **This is the diagonal case of the evaluation the chain rests
on, and it is reachable from what the layer already has.** -/
theorem sharpQF_diagOp_eq_sq (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0)
    (a b : ι) (hab : a ≠ b) : sharpQF (diagOp w) (phi a b) = (w * w) a b := by
  rw [sharpQF_diagOp w hw a b hab, Matrix.mul_apply]
  refine Finset.sum_congr rfl fun d _ => ?_
  by_cases hda : d = a
  · subst hda; simp [hh d, hw d b]
  · by_cases hdb : d = b
    · subst hdb; simp [hh d, hw a d]
    · simp [hda, hdb, hw d b]

/-- **THE COINCIDENT CASE OF THE EVALUATION, PROVED.** *At `{k,l} = {a,b}` the two `φ`s are equal
or opposite, so `sharpBil` collapses to `±sharpQF` through `sharpBil_self` and
`sharpBil_neg_self`, and `sharpQF_diagOp_eq_sq` closes it. The MIXED pairs are what remains.* -/
theorem sharpBil_diagOp_phi_same (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p)
    (hh : ∀ a, w a a = 0) (a b : ι) (hab : a ≠ b) :
    sharpBil (diagOp w) (phi a b) (phi a b)
      = (w * w) a b * inner2 (phi a b) (phi a b) := by
  rw [sharpBil_self _ (isLinOp_diagOp w), sharpQF_diagOp_eq_sq w hw hh a b hab,
    inner2_self_phi a b hab, mul_one]

/-- **THE COINCIDENT CASE WITH THE PAIR REVERSED.** *`φ_ba = -φ_ab`, so `sharpBil` picks up one
sign and `inner2` picks up the same one, and the identity holds unchanged.* -/
theorem sharpBil_diagOp_phi_swap (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p)
    (hh : ∀ a, w a a = 0) (a b : ι) (hab : a ≠ b) :
    sharpBil (diagOp w) (phi a b) (phi b a)
      = (w * w) a b * inner2 (phi a b) (phi b a) := by
  -- `phi_swap i j : phi j i = -phi i j`, so the instance that turns `φ_ba` into `-φ_ab` is
  -- `phi_swap a b`. `phi_swap b a` rewrites the FIRST slot instead and strands the goal.
  -- The pairing is settled FIRST, so the swap has only the left side left to act on.
  have hin : inner2 (phi a b) (phi b a) = -1 := by
    rw [inner2_phi_phi]; simp [hab, Ne.symm hab]
  rw [hin, phi_swap a b, sharpBil_neg_self _ (isLinOp_diagOp w),
    sharpQF_diagOp_eq_sq w hw hh a b hab]
  ring

/-! ### The mixed double bracket, where the two outer bivectors differ

**EVERY `adW_sq_phi_*` LEMMA ABOVE CARRIES THE SAME `φ_ab` IN BOTH BRACKETS**, which is all
`sharpQF` needs. *`sharpBil_expand` brackets against two DIFFERENT bivectors, so none of them
applies and the family has to be built.* The two lemmas here are its shared first moves.
-/

/-- **THE INNER STEP, WHICH IS THE SAME WHATEVER THE OUTER BIVECTOR IS.** *`diagOp` scales a basis
bivector by its own weight, so the inner bracket is one scalar times a bracket of two `φ`s, and
`br_phi_phi` decides that.* -/
theorem adW_mixed_step (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (k l i j : ι) :
    br (phi k l) (diagOp w (phi i j)) = w i j • br (phi k l) (phi i j) := by
  rw [diagOp_phi w hw, br_smul_right]

/-- **THE MIXED COMPOSITE KILLS EVERY DIRECTION THE INNER PAIR IS DISJOINT FROM.** *The inner
bracket vanishes before the outer one is reached, so the outer bivector never matters and no case
analysis on `{a,b}` is needed.* **This is what makes the mixed sum finite work rather than a double
enumeration**: only the `φ_ij` sharing an index with `{k,l}` survive to be bracketed against
`φ_ab`. -/
theorem adW_mixed_disjoint (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (a b k l i j : ι)
    (hki : k ≠ i) (hkj : k ≠ j) (hli : l ≠ i) (hlj : l ≠ j) :
    br (phi a b) (diagOp w (br (phi k l) (diagOp w (phi i j)))) = 0 := by
  rw [adW_mixed_step w hw, br_phi_disjoint k l i j hki hkj hli hlj, smul_zero, diagOp_zero,
    br_zero_right]

/-- **THE MIXED COMPOSITE AT A SHARED INDEX**, which is the only case `adW_mixed_disjoint` leaves.

*The inner bracket returns `-φ_kj` by `br_phi_share`, `diagOp` scales it by `w_kj`, and the outer
bracket is then the only thing left undecided.* **So the whole composite is a PRODUCT OF TWO
WEIGHTS times one bracket of two `φ`s**, exactly the shape `adW_sq_phi_left` has in the
single-bivector case, with the outer pair free instead of equal to the inner one. -/
theorem adW_mixed_share (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (a b k l j : ι)
    (hkl : k ≠ l) (hkj : k ≠ j) (hlj : l ≠ j) :
    br (phi a b) (diagOp w (br (phi k l) (diagOp w (phi l j))))
      = (-(w l j * w k j)) • br (phi a b) (phi k j) := by
  rw [adW_mixed_step w hw, br_phi_share k l j hkl hkj hlj]
  -- The simp set closes it outright; a trailing `congr 1; ring` errors with no goals.
  simp only [smul_neg, diagOp_neg, diagOp_smul_arg, diagOp_phi w hw, smul_smul, br_neg,
    br_smul_right, neg_smul]

/-- **THE MIXED COMPOSITE IN FULL, WITH NO CASE SPLIT.** *`br_phi_phi` gives the inner bracket as a
signed sum of at most four `φ`s, `diagOp` scales each by its own weight, and the outer bracket is
linear, so the whole composite is one expression in four conditionals.*

**ONE STATEMENT IN PLACE OF A CASE ENUMERATION**, and it subsumes `adW_mixed_disjoint` (every
conditional false) and `adW_mixed_share` (exactly one true). *The single-bivector family above is
six lemmas because it was built case by case; the mixed case does not need to be.* -/
theorem adW_mixed_expand (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (a b k l i j : ι) :
    br (phi a b) (diagOp w (br (phi k l) (diagOp w (phi i j))))
      = w i j • ((if k = i then w l j else 0) • br (phi a b) (phi l j)
          + (if l = j then w k i else 0) • br (phi a b) (phi k i)
          - (if k = j then w l i else 0) • br (phi a b) (phi l i)
          - (if l = i then w k j else 0) • br (phi a b) (phi k j)) := by
  rw [adW_mixed_step w hw, br_phi_phi]
  -- Four conditionals, sixteen cases, each an identity in a MODULE rather than a ring, so
  -- `ring` fails on them and `module` is the tactic that closes them. The split comes FIRST,
  -- because `ite_smul` leaves the conditionals inside the `diagOp` argument where `diagOp_phi`
  -- cannot see a bare `phi` to act on.
  split_ifs <;>
    simp only [diagOp_smul_arg, diagOp_add, diagOp_sub, diagOp_zero, diagOp_phi w hw,
      br_smul_right, br_add_right, br_sub_right, br_zero_right, smul_smul, smul_add, smul_sub,
      zero_smul, smul_zero, one_smul] <;>
    module

/-- **`(w²)` IS SYMMETRIC AT A SYMMETRIC WEIGHT.** *The last branch of the evaluation needs it:
the two orderings of the same matrix entry appear on one side and have to be recognised as one
quantity.* -/
theorem mul_self_symm (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (p q : ι) :
    (w * w) p q = (w * w) q p := by
  simp only [Matrix.mul_apply]
  exact Finset.sum_congr rfl fun x _ => by rw [hw p x, hw x q]; ring

/-- **A CONDITIONAL THAT DOES NOT MENTION THE SUMMATION VARIABLE COMES OUT OF THE SUM.**

*This is the step that makes `sum_weight_pair` applicable at all.* **The expansion leaves sums of
the form `∑ x, if c then w_px w_qx else 0`, and where `c` does not mention `x` the sum inside is
the bare shape the identity matches, while the whole expression is not.** *`Finset.sum_ite_eq`
handles the conditionals that DO mention `x` and has nothing to say about these.* -/
theorem sum_ite_const {c : Prop} [Decidable c] (f : ι → ℝ) :
    ∑ x : ι, (if c then f x else 0) = if c then ∑ x : ι, f x else 0 := by
  split_ifs <;> simp

/-- **`∑ₓ w_px w_qx = (w²)_pq` at a symmetric weight**, the shape every one of the eight sums the
expansion leaves reduces to.

*It is one rewrite and one relabelling, and it is worth a NAME rather than a step inside a case
tree: the term the expansion leaves is large, so a tactic that re-derives this per branch pays for
the whole term each time, which is what made both case analyses run away.* -/
theorem sum_weight_pair (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (p q : ι) :
    ∑ x : ι, w p x * w q x = (w * w) p q := by
  rw [Matrix.mul_apply]
  exact Finset.sum_congr rfl fun x _ => by rw [hw q x]

/-- **THE ONE EVALUATION THE WHOLE CHAIN NOW RESTS ON**, `sharpBil` on a pair of basis bivectors.

*`sharpBil_expand` above puts it in the same double-bracket form `sharpQF_diagOp` runs on, and the
mechanism is that one's: `ad_{φab} ∘ diagOp w` lands on the directions sharing exactly one index
with `{a,b}`, so a second bracket against a `φ_kl` disjoint from `{a,b}` has nothing to return.*

**SCREENED AND IT HOLDS AT EVERY PAIR, NOT ONLY THE DISJOINT ONES.** *Over random symmetric hollow
weights at `n = 4, 5, 6`, all ordered `(a,b)` against all ordered `(k,l)`, the largest discrepancy
is `9.3e-16` and there are ZERO failures in each of the three regimes, disjoint, sharing one index,
and the same pair. The share-one-index regime is the one the mechanism makes least obvious and it
passes.* **The screen is not the proof**: the evaluation below is proved, with no `sorry`. -/
theorem sharpBil_diagOp_phi (w : Matrix ι ι ℝ) (_hw : ∀ p q, w p q = w q p) (_hh : ∀ a, w a a = 0)
    (a b k l : ι) :
    sharpBil (diagOp w) (phi a b) (phi k l) = (w * w) a b * inner2 (phi a b) (phi k l) := by
  rw [sharpBil_expand _ (isLinOp_diagOp w)]
  -- `ite_smul` is DELIBERATELY ABSENT. With it, the conditional moves INSIDE `inner2`'s first
  -- argument, where no lemma can reach it and the sums cannot collapse. Without it the scalar
  -- stays an `ite` that `inner2_smul_left` carries straight out, and `ite_mul` then flattens.
  simp only [adW_mixed_expand w _hw, HamiltonsCubic.RealLayer.inner2_add_left,
    inner2_sub_left, inner2_smul_left, ite_mul, zero_mul]
  -- The conditionals read `k = i` where `Finset.sum_ite_eq'` wants `i = k`, so `eq_comm`
  -- is what lets the double sum collapse onto the four named index pairs.
  -- `mul_add` and `mul_sub` come FIRST. The weight multiplies a SUM of four conditionals, and
  -- `mul_ite` matches `a * if c then x else y`, so without the distribution it never fires.
  -- Then `mul_ite` and `mul_zero` push the weight inside, which is what the sum-collapse
  -- lemmas need: they match `∑ x, if x = c then f x else 0` and nothing else.
  simp only [mul_add, mul_sub, mul_ite, mul_zero, eq_comm, Finset.sum_add_distrib,
    Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true,
    inner2_phi_phi]
  -- The double sums are now EIGHT single sums. Expand the remaining brackets on the basis and
  -- pair them, which leaves conditionals in `x` that collapse the same way the last pass did.
  simp only [br_phi_phi, HamiltonsCubic.RealLayer.inner2_add_left, inner2_sub_left,
    inner2_smul_left, inner2_phi_phi, mul_add, mul_sub, mul_ite, mul_zero, ite_mul, zero_mul,
    eq_comm, Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq,
    Finset.sum_ite_eq', Finset.mem_univ, if_true, ite_and, mul_one, one_mul, sum_ite_const,
    sum_weight_pair w _hw]
  -- **NOTHING GEOMETRIC IS LEFT.** Every bracket and every pairing is discharged by the three
  -- passes above, and what remains is index bookkeeping over sums `∑ x, w_kx w_lx`, which
  -- `Matrix.mul_apply` names and symmetry orients.
  --
  -- **A BLANKET `split_ifs` HERE EXPLODES**: the goal carries ten or so nested conditionals, so
  -- the split is exponential and the elaborator times out at `whnf`. The case analysis has to be
  -- driven by the THREE coincidences that matter, `a = k ∧ b = l`, `b = k ∧ a = l`, and neither,
  -- rather than by every conditional the expansion happens to have produced.
  --
  -- **AND THAT SPLIT IS TOO EXPENSIVE AS WELL**, which is a fact about the GOAL rather than
  -- about the choice of tactic: driving it by the three coincidences and closing each branch
  -- with `simp_all` ran past ten minutes without returning, where every pass above came back
  -- in seconds. The term the three passes leave is large, so any tactic that copies it per
  -- branch pays for the size however few branches there are.
  --
  -- **What a next round should try instead is naming the eight single sums.** Each is one
  -- identity of the form `∑ x, w_px w_qx = (w * w) p q` under symmetry, provable on its own
  -- with a goal that stays small, and the assembly then adds eight short facts rather than
  -- re-deriving them inside a case tree.
  --
  -- **`sum_weight_pair` IS THAT LEMMA AND IT DOES NOT FIRE HERE, WHICH IS THE NEXT THING TO
  -- FIX.** The sums the expansion leaves are not `∑ x, w_px w_qx`. They are
  -- `∑ x, if <condition on x> then w_px w_qx else 0`, with the conditional INSIDE the sum, so
  -- the identity has nothing to match. The sums have to be split on their conditionals first,
  -- and only the survivors are bare.
  --
  -- *This is the same shape as the three ordering facts above: a lemma that does not fire is
  -- saying the term never reached the form it matches, and the repair is upstream of it.*
  -- `sum_weight_pair` DOES fire from inside the simp set, once `mul_one` and `one_mul` have
  -- cleared the unit factors the expansion leaves: the sums read `w_kx * (w_lx * (1 * 1))` and
  -- the identity matches `w_kx * w_lx`. A targeted `rw` here found nothing left to do.
  -- Hollowness then kills every single term the collapse left, each carrying a diagonal weight.
  simp only [_hh, mul_zero, zero_mul, neg_zero, mul_neg, sub_zero, zero_sub, add_zero, zero_add]
  -- `simp_all` before `ring` because several branches are VACUOUS: the split produces cases
  -- carrying `a = k`, `b = k` and `¬a = b` together, and arithmetic cannot see the
  -- contradiction. The surviving branch needs the two sums read back as `(w²)` and the two
  -- orderings of that entry recognised as one quantity, which is `mul_self_symm`.
  split_ifs <;>
    simp_all [sum_weight_pair w _hw, mul_self_symm w _hw] <;> ring

/-- **`W# φ_ab = (w²)_ab · φ_ab`**, the evaluation of `sharpOp` on the `φ` family that
[Families.lean](Families.lean) names as the base layer's owed step.

*`sharpQF_diagOp` above evaluates the QUADRATIC form on a single `φ`, which is enough for the
scalar `⟨W, W#⟩` because `inner2_phi_phi` collapses the resolution back to `(a,b)` and `(b,a)`.
The OPERATOR needs the bilinear form at MIXED pairs, `sharpBil (diagOp w) (φ_ab) (φ_kl)` for
`{k,l} ≠ {a,b}`.*

**THE ROUTE TO IT IS NOW OPEN AND THE GAP IS ONE EVALUATION.** *`sharpBil_expand` above puts the
mixed pairs in the same form `sharpQF_diagOp` already runs on, a double bracket with `diagOp` in
the middle, so what remains is to evaluate*
`-(1/8) Σ_ij [ ⟨[φ_ab, W[φ_kl, Wφ_ij]], φ_ij⟩ + ⟨[φ_kl, W[φ_ab, Wφ_ij]], φ_ij⟩ ]`
*and show it is `(w²)_ab · ⟨φ_ab, φ_kl⟩, i.e. that it vanishes unless `{k,l} = {a,b}`.*
**The mechanism is `sharpQF_diagOp`'s own**: `ad_{φab} ∘ diagOp w` lands on the basis directions
sharing exactly one index with `{a,b}`, so a second bracket against a `φ_kl` disjoint from `{a,b}`
has nothing to return. *That evaluation is `sharpBil_diagOp_phi`, proved above with no `sorry`.*

**HOLLOWNESS IS LOAD-BEARING AND SYMMETRY IS TOO.** *A screen over random weights at `n = 4, 5, 6`
agrees to `4e-16` under both hypotheses and disagrees by `2.27` on the same weights with the
diagonal restored, so a proof that never uses `hh` is proving something else.* Symmetry fails for
the reason `sharpQF_diagOp` records above: an asymmetric weight sends a bivector partly into the
symmetric matrices, where `φ_ij` is not an eigenvector.

*The screen is not the proof. The theorem below is proved from `sharpBil_diagOp_phi`.* -/
theorem sharpOp_diagOp (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0)
    (a b : ι) : sharpOp (diagOp w) (phi a b) = (w * w) a b • phi a b := by
  unfold sharpOp
  -- `smul_comm` in this simp set loops on the nested scalars and blows the recursion limit.
  simp only [sharpBil_diagOp_phi w hw hh a b, mul_smul, ← Finset.smul_sum]
  rw [← smul_comm, phi_resolve a b]

/-- **`DiagCriticalityIsCritical`, PROVED FROM THAT ONE EVALUATION.**

*The `Prop` was carried as a hypothesis by [L68Statement.lean](../Results/L68Statement.lean) and
[L74Statement.lean](../Results/L74Statement.lean) so that one cycle discharging `sharpOp` would
discharge both consumers at once. This is that reduction: everything except `sharpOp_diagOp` is
`diagOp_phi` applied twice.*

**`rowSum` IS NOT USED, and the record did not say so.** *`IsWeight` carries three clauses and the
bridge needs two, so a weight with nonzero row sums still lands in the critical locus whenever the
off-diagonal equation holds. That is a fact about the locus rather than about this proof.* -/
theorem diagCriticalityIsCritical : DiagCriticalityIsCritical (ι := ι) := by
  intro w th hwt hoff i j
  have hR : diagOp w (phi i j) = w i j • phi i j := diagOp_phi w hwt.symm i j
  show compOp (diagOp w) (phi i j) + sharpOp (diagOp w) (phi i j) = th • diagOp w (phi i j)
  unfold compOp
  rw [hR, diagOp_smul_arg, hR, sharpOp_diagOp w hwt.symm hwt.hollow, smul_smul, smul_smul,
    ← add_smul]
  by_cases hij : i = j
  · subst hij; simp [phi_self]
  · congr 1
    have h := hoff i j hij
    nlinarith [h]

/-! ## What this file settles

**`DiagCubicFormula` is PROVED**, standard axioms, no `sorry`, and it was the record's largest
single unproved dependency. **L57 is discharged too, and by a longer route than the record
claimed**: its bridge is the CONJUNCTION of `tr W³ = ½⟨M^{∘2}, M⟩` and `⟨W, W#⟩ = ½⟨M², M⟩`, where
`DiagCubicFormula` is their SUM, *so what settles L57 is `trCube_diagOp` and `sharpPair_diagOp`
proving the two conjuncts separately rather than `diagCubicFormula` proving the sum*
([r1001](../../../reviews/REVIEW_r1001.md)).

**The tree's consumer count was ONE Lean binder, not seven**, `twoClass_theta_abs` in
[L96Statement.lean](../Results/L96Statement.lean), now discharged. *Six further files name the
`Prop` in prose as a gap the base layer owes and bind nothing, and the record had been counting
those as hypotheses.* **A prose mention is a reader's signpost and a binder is a debt**, and the
two were not being told apart.

**The evaluation and the assembly are separate facts and are worth reading separately.**

- `sharpQF_diagOp` is the evaluation [Families.lean](Families.lean) named as the thing no file
  does, `sharpOp (diagOp w)` read on the `φ` basis. *The mechanism is that
  `ad_{φab} ∘ diagOp w` SQUARED is diagonal on the `φ` family, eigenvalue `-w_ad·w_bd` on `φ_ad`
  and on `φ_bd` and zero elsewhere, so the ordered-pair sum is four copies of one number per `d`.*
- `trCube_diagOp` and `sharpPair_diagOp` are the assembly. *The first is `diagOp_phi` twice. The
  second reaches `sharpQF` through `sharpOp` and `sharpBil`, so the polarisation is collapsed back
  to the quadratic form first, `inner2_phi_phi` leaving the two pairs `(i,j)` and `(j,i)` and
  `φ_ji = -φ_ij` making the second ADD rather than cancel.*

**Hollowness enters in exactly two places and symmetry in three**, which is why `IsWeight`'s row-sum
clause is never used here. *Hollowness disposes of `trCube`'s diagonal and of the triple-sum terms
`sharpPair`'s index exclusion drops. Symmetry makes `φ_ij` an eigenvector at all, and turns `w_id`
into `w_di` at the last step.*

## The two corrections this statement went through

**Both are the same mistake read from two places**, and both reached a commit.

*First the closed form.* **`R` enters `sharpQF` TWICE**, so a direction is scaled on the way in and
again on the way out, giving the PRODUCT `w_ad · w_bd`. The brief that stated it applied `R` once
and claimed the SUM, which is linear where the functional is quadratic
([r999](../../../reviews/REVIEW_r999.md), [r1000](../../../reviews/REVIEW_r1000.md)).

*Then the binder.* **The corrected closed form was typed with `w` still quantified over every
matrix**, so the theorem asserted the symmetric answer at every weight,
[screen_I66_sharpQF_symmetry.py](../../../scripts/misc/screen_I66_sharpQF_symmetry.py) disagreeing
at 72 of 72 asymmetric ones. *A `sorry` on a false statement is a debt that can never be paid, and
the proof above would have ground against an unprovable goal.*

**SYMMETRY IS NECESSARY IN `sharpQF_diagOp`, and here is the witness.** *[r1001](../../../reviews/REVIEW_r1001.md)
left this unresolved, two hand-built candidates having failed to separate.* At `n = 3`, `a = 0`,
`b = 1`, take `w` HOLLOW with `w₀₂ = w₁₂ = 1` and every other entry `0`, so `w₂₀ = w₂₁ = 0` and `w`
is not symmetric. **`diagOp w` sends `φ_ij` to `(φ_ij)₀₂ E₀₂ + (φ_ij)₁₂ E₁₂`**, which is nonzero
only at `(i,j) ∈ {(0,2),(2,0),(1,2),(2,1)}`, and with `[φ₀₁, E₀₂] = E₁₂` and `[φ₀₁, E₁₂] = -E₀₂`
each of those four pairs contributes `-½`. *So the sum is `-2` and `sharpQF` is `½`, against the
closed form's `w₀₂·w₁₂ = 1`.* **Exact, and checkable by hand from `br_phi_phi` alone.**

*Why symmetry is what fails*: `diagOp w (φ_ij)` equals `s_ij φ_ij + A_ji (E_ij + E_ji)` with `s` and
`A` the symmetric and antisymmetric parts of `w`, **so an asymmetric weight sends a bivector partly
into the SYMMETRIC matrices**, where `φ_ij` is no longer an eigenvector and the mechanism the proof
runs on has nothing to act on.

**The control that passed the false form is the lesson under both.** *The anchor `id# = (n-2)·id`
was chosen as the known value, and `id` is `diagOp` of the ALL-ONES weight, which is the one point
of weight space where a linear and a quadratic form in `w` must agree, every factor being `1`.*
**A control that cannot distinguish the claim from its competitor is not a control.**
-/

end HamiltonsCubic.RealLayer
