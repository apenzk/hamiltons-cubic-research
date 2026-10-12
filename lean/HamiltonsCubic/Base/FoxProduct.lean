import HamiltonsCubic.Base.WeylReal

/-!
# The Fox product `∘`, and the multiplication operators `L_W` and `L_e`

**Why this file exists.** [WeylReal.lean](WeylReal.lean) carries `Qop`, `Pcubic`, `theta` and
`IsCritical` over `ℝ` at a general index type, and stops there. The record's second-order
apparatus is built on one further object, and three numbered results say so in their own words:
[L98](../Results/L98Statement.lean), [L99](../Results/L99Statement.lean) and
[L127](../Results/L127Statement.lean) each carry a `## What is NOT typed here` heading naming
**the Fox product and `L_e`** as the absence that keeps their subject unstatable.

**The record's definition, quoted verbatim** from
[conventions.md](../../../findings/conventions.md):

> **The `∘` product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and
> $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.

and from [second-order.md](../../../findings/second-order.md), Lemma L24:

> At a critical point $Q(W)=\theta W$ with $\theta>0$, put $e=W/\theta$, an idempotent of
> $X\circ Y:=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, and $L_e=e\circ(\cdot)$.

and the trilinear form, from [conventions.md](../../../findings/conventions.md)'s `T` row:

> the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$,
> whose symmetry is what makes $L_e$ self-adjoint.

The algebra is Fox's, [references/fox-2019-nonassociative-curvature-algebra](../../../references/fox-2019-nonassociative-curvature-algebra/notes.md),
where `L_∘(x)` is the multiplication operator and critical points of `P` on the unit sphere are
the idempotents.

## The normalisations, and which readings are chosen here

- **The pairing is `innerOp`**, WeylReal's `Λ²` pairing with the `½` and the ordered-pair
  doubling. *Fox's own metric is complete contraction, four times the Frobenius metric, so
  `κ_Fox = ¼ κ_Frob`; nothing here is stated in Fox's normalisation.*
- **The `½` in `∘` is the record's.** It is the reading that makes `X ∘ X = Q(X)` rather than
  `2Q(X)`, and the record commits to it: L24 calls `e = W/θ` an *idempotent*, i.e.
  `e ∘ e = Q(e) = e`. `foxProd_self` proves that reading is the one this definition has.
- **`e = θ⁻¹ • W` is `idemOf W θ`**, at any `θ`. The record's `θ > 0` is the case it uses; at
  `θ = 0` the definition returns the zero operator, which is why `foxProd_idemOf_self` holds
  without the hypothesis and carries none.

## What the record does not define, and the readings taken here

- **`𝒲ₙ` as a set of operators.** The record's `𝒲ₙ` is a linear subspace of operators on `Λ²`;
  WeylReal's `IsWeyl` carries the three curvature conditions and **not** linearity, a clause its
  own closing note records as owed and [plan.md](../../../plan.md)'s B1 lists. `IsWeylOp` here is
  `IsLinOp ∧ IsWeyl`, and every statement below that needs a quadratic `Q` takes `IsLinOp` as a
  hypothesis rather than assuming it.
- **`λ_max(L_e|_{W^⊥})`.** The record writes a largest eigenvalue; a largest eigenvalue of a
  self-adjoint operator on a finite-dimensional inner-product space is the supremum of its
  Rayleigh quotient, and **that** is what `RayleighLE` and `RayleighGE` state, `⟨X, L_e X⟩ ≤ c‖X‖²`
  on `𝒲ₙ ∩ W^⊥`, and its opposite at one witness. *The equivalence with a spectral maximum needs
  `L_e` self-adjoint, which [FoxBridge.lean](../Results/FoxBridge.lean)'s `lidem_isSelfAdjoint` now
  PROVES at record-Weyl arguments, AND ALSO `L_e` LINEAR, which is still owed through bilinearity of
  `∘`, so these remain the quadratic-form readings and are named as such.* They are the shape L24's `≤ ½`, L98's `≥ 1` and L99's `≥ 1` need.

## What is owed, and deliberately absent rather than `sorry`-ed

- **Full symmetry of `T`, and self-adjointness of `L_e`: DISCHARGED**, in
  [FoxBridge.lean](../Results/FoxBridge.lean), at record-Weyl operators and at a general index type.
  *`foxTri_comm` gives the first two slots, `foxTri_symm_right` gives the last two, and
  `lidem_isSelfAdjoint` is what the consumers of this file need: `⟨L_e X, Y⟩ = ⟨X, L_e Y⟩` at
  `e = idemOf W θ`.* **The route does not go through `sharpOp` being `R#`**, which this bullet once
  named as the obligation it waited on: it goes through `T` reading its arguments only on bivectors,
  so `foxTri` at a bare operator equals `foxTri2` at its restriction, where the symmetry is proved.
  *Three earlier claims of discharge were refuted before this one held*
  ([r1019](../../../reviews/REVIEW_r1019.md), [r1020](../../../reviews/REVIEW_r1020.md),
  [r1021](../../../reviews/REVIEW_r1021.md)), **each with a correct theorem at a domain the
  consumers do not use**: the wrong operator type, then `extend` of something, then `Fin n` with no
  closure of `IsWeyl` under scaling.
- **Bilinearity of `∘`.** `foxProd_split` isolates the whole question in `sharpCross`, the
  polarised `#`; the Jordan half `½(X(YZ) + Y(XZ))` is bilinear on its face. Consequently
  `L_e = L_W/θ` is **owed** and absent, the fact the consumers use is `L_e e = e` at a critical
  point, which goes through `Qop`'s homogeneity and needs no bilinearity at all.
- **`tr L_e = 0` and `tr(L_e L_f) = κ⟨e,f⟩`** (Fox Theorem 1.3), which need a trace on the
  operators of `𝒲ₙ` and so a basis of `𝒲ₙ`. This layer has neither.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- A curvature operator: a map on bivectors, WeylReal's ambient type for `R`. *Reducible, so it
unifies with WeylReal's spelled-out type everywhere.* -/
abbrev CurvOp (ι : Type*) := Matrix ι ι ℝ → Matrix ι ι ℝ

noncomputable section

/-! ## `𝒲ₙ`'s missing clause: linearity

*`Qop` is quadratic in `R` only when `R` is linear, and `∘` is the polarisation of a quadratic
map. WeylReal's `IsWeyl` does not carry linearity, so it is supplied here.*
-/

/-- **`R` is a linear operator on bivectors**, additive and `ℝ`-homogeneous. *This is the clause
`IsWeyl` omits; `𝒲ₙ` is a linear subspace of `End(Λ²)`, so every object the programme studies
satisfies it.* -/
def IsLinOp (R : CurvOp ι) : Prop :=
  (∀ X Y, R (X + Y) = R X + R Y) ∧ (∀ (c : ℝ) (X), R (c • X) = c • R X)

/-- **The record's `𝒲ₙ`**: a *linear* operator meeting WeylReal's three curvature conditions. -/
def IsWeylOp (R : CurvOp ι) : Prop := IsLinOp R ∧ IsWeyl R

theorem isLinOp_zero : IsLinOp (0 : CurvOp ι) := ⟨fun _ _ => by simp, fun _ _ => by simp⟩

/-- **The hypotheses are not empty**, the zero operator is a linear Weyl operator. *It is the
degenerate point of the space and certifies nothing beyond non-vacuity.* -/
theorem isWeylOp_zero : IsWeylOp (0 : CurvOp ι) := by
  refine ⟨isLinOp_zero, ?_, ?_, ?_, ?_⟩
  · intro X _; simp [IsSkew]
  · intro X Y _ _; simp [inner2]
  · intro i j k l; simp [bianchi, inner2]
  · intro a b; simp [Ric, inner2]

/-- **A nonzero witness for `IsLinOp`**, so the predicate is not satisfied by `0` alone: every
scalar multiple of the identity is a linear operator on bivectors. *It is not a Weyl operator,
`Ric` does not vanish on it, so this witnesses `IsLinOp` and not `IsWeylOp`.* -/
theorem isLinOp_smul_id (c : ℝ) : IsLinOp (fun X : Matrix ι ι ℝ => c • X) :=
  ⟨fun X Y => by simp [smul_add], fun d X => by simp [smul_comm c d]⟩

theorem IsLinOp.smul {R : CurvOp ι} (h : IsLinOp R) (c : ℝ) : IsLinOp (c • R) :=
  ⟨fun X Y => by simp [Pi.smul_apply, h.1 X Y], fun d X => by
    simp [Pi.smul_apply, h.2 d X, smul_comm c d]⟩

/-! ## `Q` is quadratic in `R`

*Everything below that touches `∘` rests on this: `Qop (c • R) = c² • Qop R`. It is proved from
`IsLinOp` alone, primitive by primitive.*
-/

theorem br_smul_right (η A : Matrix ι ι ℝ) (c : ℝ) : br η (c • A) = c • br η A := by
  unfold br; simp [smul_sub]

theorem inner2_smul_left (A B : Matrix ι ι ℝ) (c : ℝ) : inner2 (c • A) B = c * inner2 A B := by
  simp only [inner2_eq_sum, Matrix.smul_apply, smul_eq_mul]
  have h : ∑ a : ι, ∑ b : ι, c * A a b * B a b
      = c * ∑ a : ι, ∑ b : ι, A a b * B a b := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun b _ => by ring
  rw [h]; ring

theorem compOp_smul (R : CurvOp ι) (hR : IsLinOp R) (c : ℝ) (Z : Matrix ι ι ℝ) :
    compOp (c • R) Z = c ^ 2 • compOp R Z := by
  show (c • R) ((c • R) Z) = c ^ 2 • R (R Z)
  simp only [Pi.smul_apply, hR.2 c (R Z), smul_smul]
  ring_nf

/-- **`sharpQF` is homogeneous of degree `2` in `R`**, since `R` enters it exactly twice. -/
theorem sharpQF_smul (R : CurvOp ι) (hR : IsLinOp R) (c : ℝ) (η : Matrix ι ι ℝ) :
    sharpQF (c • R) η = c ^ 2 * sharpQF R η := by
  unfold sharpQF
  have key : ∀ i j : ι, inner2 (br η ((c • R) (br η ((c • R) (phi i j))))) (phi i j)
      = c ^ 2 * inner2 (br η (R (br η (R (phi i j))))) (phi i j) := by
    intro i j
    have h1 : (c • R) (phi i j) = c • R (phi i j) := rfl
    rw [h1, br_smul_right]
    have h2 : (c • R) (c • br η (R (phi i j))) = c • (c • R (br η (R (phi i j)))) := by
      show c • R (c • br η (R (phi i j))) = _
      rw [hR.2 c (br η (R (phi i j)))]
    rw [h2, br_smul_right, br_smul_right, inner2_smul_left, inner2_smul_left]
    ring
  have hsum : ∑ i : ι, ∑ j : ι, inner2 (br η ((c • R) (br η ((c • R) (phi i j))))) (phi i j)
      = c ^ 2 * ∑ i : ι, ∑ j : ι, inner2 (br η (R (br η (R (phi i j))))) (phi i j) := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun j _ => key i j
  rw [hsum]; ring

theorem sharpBil_smul (R : CurvOp ι) (hR : IsLinOp R) (c : ℝ) (X Y : Matrix ι ι ℝ) :
    sharpBil (c • R) X Y = c ^ 2 * sharpBil R X Y := by
  unfold sharpBil
  rw [sharpQF_smul R hR, sharpQF_smul R hR, sharpQF_smul R hR]
  ring

theorem sharpOp_smul (R : CurvOp ι) (hR : IsLinOp R) (c : ℝ) (X : Matrix ι ι ℝ) :
    sharpOp (c • R) X = c ^ 2 • sharpOp R X := by
  unfold sharpOp
  rw [smul_comm]
  congr 1
  rw [Finset.smul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.smul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [sharpBil_smul R hR, smul_smul]

/-- **`Q` IS QUADRATIC**: `Q(cR) = c²Q(R)` for a linear `R`. *This is what makes `∘` the
polarisation of a quadratic map, and it is the only structural fact the idempotency of `e` needs.* -/
theorem Qop_smul (R : CurvOp ι) (hR : IsLinOp R) (c : ℝ) (X : Matrix ι ι ℝ) :
    Qop (c • R) X = c ^ 2 • Qop R X := by
  unfold Qop
  rw [compOp_smul R hR, sharpOp_smul R hR, smul_add]

/-- **`Q(0) = 0`**, the sanity check the definition owes at zero. -/
theorem Qop_zero : Qop (0 : CurvOp ι) = 0 := by
  funext X
  simp [Qop, compOp, sharpOp, sharpBil, sharpQF, br, inner2]

/-! ## The Fox product -/

/-- **THE FOX PRODUCT `∘`**, verbatim from the record: `X ∘ Y = ½(Q(X+Y) − Q(X) − Q(Y))`.

*`X + Y` is pointwise addition of operators, and `Q` is WeylReal's `Qop`. The definition takes no
hypothesis on `X` or `Y`. The two facts that make it the record's product hold at linear arguments:
`X ∘ X = Q(X)` (`foxProd_self`), and the split into a Jordan half and a polarised `#`
(`foxProd_split`).* -/
def foxProd (X Y : CurvOp ι) : CurvOp ι :=
  fun Z => (1 / 2 : ℝ) • (Qop (X + Y) Z - Qop X Z - Qop Y Z)

@[inherit_doc] scoped infixl:70 " ∘w " => foxProd

/-- **`∘` is commutative**, which is the whole of what its polarised form gives for free. -/
theorem foxProd_comm (X Y : CurvOp ι) : X ∘w Y = Y ∘w X := by
  funext Z
  unfold foxProd
  rw [add_comm X Y]
  congr 1
  abel

/-- **`X ∘ 0 = 0`**, the sanity check at zero. -/
theorem foxProd_zero_right (X : CurvOp ι) : foxProd X 0 = 0 := by
  funext Z
  unfold foxProd
  rw [add_zero, Qop_zero]
  simp

theorem foxProd_zero_left (X : CurvOp ι) : foxProd 0 X = 0 := by
  rw [foxProd_comm]; exact foxProd_zero_right X

/-- **`X ∘ X = Q(X)` at a linear `X`**, the record's normalisation, and the reason its `½` is
where it is. *Under the `½`-free reading the right-hand side would be `2Q(X)` and `e` would fail
to be an idempotent, which L24 asserts it is.* -/
theorem foxProd_self (R : CurvOp ι) (hR : IsLinOp R) : foxProd R R = Qop R := by
  funext Z
  have hRR : R + R = (2 : ℝ) • R := by funext X; simp [two_smul]
  unfold foxProd
  rw [hRR, Qop_smul R hR]
  norm_num
  module

/-! ### The two halves of `∘`

*The record splits the trilinear form into a `W²` part (the symmetrisation of `tr(XYZ)`) and a
`#` part. `foxProd_split` is that split one level down, on `∘` itself: the composition half
polarises under additivity alone, and the `#` half is carried as a polarisation.*
-/

/-- **The Jordan half**, `½(X(YZ) + Y(XZ))`, the symmetrisation of the composition. -/
def jordanProd (X Y : CurvOp ι) : CurvOp ι := fun Z => (1 / 2 : ℝ) • (X (Y Z) + Y (X Z))

/-- **The `#` half**, the polarisation of `sharpOp`. *Left as the polarisation rather than
expanded: whether `sharpOp` is `R#` is WeylReal's own standing obligation, and expanding here would
commit this file to an answer it cannot prove.* -/
def sharpCross (X Y : CurvOp ι) : CurvOp ι :=
  fun Z => (1 / 2 : ℝ) • (sharpOp (X + Y) Z - sharpOp X Z - sharpOp Y Z)

/-- **`∘` SPLITS INTO THE JORDAN PRODUCT AND THE POLARISED `#`**, at additive `X` and `Y`. *The
composition half polarises exactly (no `#`-normalisation enters it) so any doubt about the
product's constant is confined to `sharpCross`.* -/
theorem foxProd_split (X Y : CurvOp ι)
    (hX : ∀ A B, X (A + B) = X A + X B) (hY : ∀ A B, Y (A + B) = Y A + Y B) :
    foxProd X Y = fun Z => jordanProd X Y Z + sharpCross X Y Z := by
  funext Z
  have hcomp : compOp (X + Y) Z = X (X Z) + X (Y Z) + Y (X Z) + Y (Y Z) := by
    show (X + Y) ((X + Y) Z) = _
    show X ((X + Y) Z) + Y ((X + Y) Z) = _
    show X (X Z + Y Z) + Y (X Z + Y Z) = _
    rw [hX (X Z) (Y Z), hY (X Z) (Y Z)]
    abel
  unfold foxProd jordanProd sharpCross Qop
  rw [hcomp]
  show (1 / 2 : ℝ) • (X (X Z) + X (Y Z) + Y (X Z) + Y (Y Z) + sharpOp (X + Y) Z
      - (compOp X Z + sharpOp X Z) - (compOp Y Z + sharpOp Y Z)) = _
  show (1 / 2 : ℝ) • (X (X Z) + X (Y Z) + Y (X Z) + Y (Y Z) + sharpOp (X + Y) Z
      - (X (X Z) + sharpOp X Z) - (Y (Y Z) + sharpOp Y Z)) = _
  rw [smul_add, smul_sub, smul_sub]
  module

/-! ## The trilinear form `T` -/

/-- **`T(X,Y,Z) = ⟨X ∘ Y, Z⟩`**, the record's fully symmetric trilinear form, paired with
WeylReal's `innerOp`. -/
def foxTri (X Y Z : CurvOp ι) : ℝ := innerOp (foxProd X Y) Z

/-- **`T` is symmetric in its first two slots.** *This is `∘`'s commutativity and nothing more.*
**The third slot is `foxTri_symm_right` in [FoxBridge.lean](../Results/FoxBridge.lean)**, at
record-Weyl arguments, *and with this one it gives the full symmetry that makes `L_e` self-adjoint,
`lidem_isSelfAdjoint`.* **A first version of this line said the third slot was owed**, which it was
when written and had stopped being by the time the module docstring above was updated. -/
theorem foxTri_comm (X Y Z : CurvOp ι) : foxTri X Y Z = foxTri Y X Z := by
  unfold foxTri; rw [foxProd_comm]

/-- **`T(R,R,R) = P(R)` at a linear `R`**, the coherence obligation this definition owes the
layer it extends. *`P` is `⟨R, Q(R)⟩`, `R ∘ R` is `Q(R)`, and `innerOp` is symmetric; if the `½`
in `∘` were anywhere else this would fail by a factor.* -/
theorem foxTri_self (R : CurvOp ι) (hR : IsLinOp R) : foxTri R R R = Pcubic R := by
  unfold foxTri
  rw [foxProd_self R hR, innerOp_comm, ← Pcubic_eq_inner_Qop]

/-! ## `L_W`, `e` and `L_e` -/

/-- **`L_W = W ∘ (·)`**, the multiplication operator of the algebra, Fox's `L_∘(W)`. -/
def Lmul (W : CurvOp ι) : CurvOp ι → CurvOp ι := fun X => foxProd W X

/-- **`e = W/θ`**, the idempotent attached to a critical point. -/
def idemOf (W : CurvOp ι) (θ : ℝ) : CurvOp ι := θ⁻¹ • W

/-- **`IsWeyl` IS CLOSED UNDER SCALING THE OPERATOR.** *Every clause is linear in `R`: skewness of
the values survives a scalar, and the symmetry, Bianchi and Ricci clauses each pull the scalar out
of `inner2` and multiply a zero.*

**THIS IS WHAT CARRIES ANY STATEMENT ABOUT A RECORD-WEYL OPERATOR TO `idemOf W θ`**, which is where
this file's consumers evaluate `foxTri`, *and its absence was the reach gap
[r1021](../../../reviews/REVIEW_r1021.md) found under a discharge claim that had the right theorem
and the wrong domain.* **It is a DIFFERENT statement from `isWeyl_smul`**, which is homogeneity of a
fixed `R` along its argument. -/
theorem isWeyl_smul_op {R : CurvOp ι} (hW : IsWeyl R) (c : ℝ) : IsWeyl (c • R) := by
  have hskew : ∀ X : Matrix ι ι ℝ, IsSkew X → IsSkew (c • X) := by
    intro X hX
    show (c • X)ᵀ = -(c • X)
    rw [Matrix.transpose_smul, show Xᵀ = -X from hX, smul_neg]
  have hright : ∀ X Y : Matrix ι ι ℝ, inner2 X (c • Y) = c * inner2 X Y := by
    intro X Y
    simp only [inner2_eq_sum, Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  refine ⟨fun X hX => hskew _ (hW.1 X hX), fun X Y hX hY => ?_,
    fun i j k l => ?_, fun a b => ?_⟩
  · show inner2 (c • R X) Y = inner2 X (c • R Y)
    rw [inner2_smul_left, hright, hW.2.1 X Y hX hY]
  · have h := hW.2.2.1 i j k l
    unfold bianchi at h
    show inner2 (c • R (phi i j)) (phi k l) + inner2 (c • R (phi i k)) (phi l j)
        + inner2 (c • R (phi i l)) (phi j k) = 0
    rw [inner2_smul_left, inner2_smul_left, inner2_smul_left, ← mul_add, ← mul_add, h, mul_zero]
  · have h := hW.2.2.2 a b
    unfold Ric at h
    show ∑ d : ι, inner2 (c • R (phi a d)) (phi b d) = 0
    rw [Finset.sum_congr rfl fun d _ => inner2_smul_left (R (phi a d)) (phi b d) c,
      ← Finset.mul_sum, h, mul_zero]

/-- **SO `idemOf W θ` IS WEYL WHENEVER `W` IS**, at every `θ`, `θ = 0` included, where it is the
zero operator. -/
theorem isWeyl_idemOf {W : CurvOp ι} (hW : IsWeyl W) (θ : ℝ) : IsWeyl (idemOf W θ) :=
  isWeyl_smul_op hW θ⁻¹

/-- **`L_e = e ∘ (·)`**, the operator the whole second-order apparatus is about. -/
def Lidem (W : CurvOp ι) (θ : ℝ) : CurvOp ι → CurvOp ι := Lmul (idemOf W θ)

theorem Lidem_apply (W : CurvOp ι) (θ : ℝ) (X : CurvOp ι) :
    Lidem W θ X = foxProd (idemOf W θ) X := rfl

theorem idemOf_apply (W : CurvOp ι) (θ : ℝ) (Z : Matrix ι ι ℝ) :
    idemOf W θ Z = θ⁻¹ • W Z := rfl

theorem isLinOp_idemOf {W : CurvOp ι} (hW : IsLinOp W) (θ : ℝ) : IsLinOp (idemOf W θ) :=
  hW.smul θ⁻¹

/-- **`e` IS AN IDEMPOTENT OF `∘`, ON THE BASIS BIVECTORS**: `e ∘ e = Q(e) = Q(W)/θ² = θW/θ² = e`.

*Stated at `phi i j` rather than at every matrix because `IsCritical` is stated there,
WeylReal quantifies criticality over the pair basis, and `Qop e` is not known to be linear, so no
extension to a general argument is available without the linearity of `Q`'s value.*

*The record carries `θ > 0` here and the identity holds at every `θ`: at `θ = 0` the definition
`e = θ⁻¹ • W` gives the zero operator, where both sides vanish. The hypothesis is therefore
dropped rather than carried unused.*

**This is the fact L24, L98, L99, L125, L126 and L127 all use**, in the form `L_e e = e`. -/
theorem foxProd_idemOf_self {W : CurvOp ι} (hW : IsLinOp W) {θ : ℝ}
    (hc : IsCritical W θ) (i j : ι) :
    foxProd (idemOf W θ) (idemOf W θ) (phi i j) = idemOf W θ (phi i j) := by
  rw [foxProd_self _ (isLinOp_idemOf hW θ)]
  show Qop (θ⁻¹ • W) (phi i j) = θ⁻¹ • W (phi i j)
  rw [Qop_smul W hW, hc i j, smul_smul]
  congr 1
  rcases eq_or_ne θ 0 with h | h
  · simp [h]
  · field_simp

/-- **`L_e e = e`**, the same fact in the form the record cites it. -/
theorem Lidem_idemOf {W : CurvOp ι} (hW : IsLinOp W) {θ : ℝ}
    (hc : IsCritical W θ) (i j : ι) :
    Lidem W θ (idemOf W θ) (phi i j) = idemOf W θ (phi i j) :=
  foxProd_idemOf_self hW hc i j

/-! ## `λ_max(L_e|_{W^⊥})`, as a quadratic form

*The record's second-order statements are eigenvalue bounds on `L_e` restricted to `𝒲ₙ ∩ W^⊥`.
What is available here is the Rayleigh reading: `⟨X, L_e X⟩ ≤ c⟨X,X⟩` for every admissible `X`,
and its opposite at one witness. For a self-adjoint operator the two readings agree, and **`L_e` is now
self-adjoint HERE too**, `lidem_isSelfAdjoint` in [FoxBridge.lean](../Results/FoxBridge.lean). *What
keeps these named as quadratic-form statements is the OTHER half, `L_e` linear, which bilinearity of
`∘` still owes.*
-/

theorem inner2_self_nonneg (A : Matrix ι ι ℝ) : 0 ≤ inner2 A A := by
  rw [inner2_eq_sum]
  have h : (0 : ℝ) ≤ ∑ a : ι, ∑ b : ι, A a b * A a b :=
    Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _
  linarith

/-- **`⟨R,R⟩ ≥ 0`**, which is what makes a Rayleigh quotient comparison legitimate. -/
theorem innerOp_self_nonneg (R : CurvOp ι) : 0 ≤ innerOp R R := by
  unfold innerOp
  have h : (0 : ℝ) ≤ ∑ i : ι, ∑ j : ι, inner2 (R (phi i j)) (R (phi i j)) :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => inner2_self_nonneg _
  linarith

/-- **`λ_max(L_e|_{W^⊥}) ≤ c`, read as a quadratic form.** *Admissible directions are the record's:
elements of `𝒲ₙ` (linear and Weyl), orthogonal to `W`. This is L24's shape at `c = ½`, and
L125's.* -/
def RayleighLE (W : CurvOp ι) (θ c : ℝ) : Prop :=
  ∀ X : CurvOp ι, IsWeylOp X → innerOp X W = 0 → foxTri (idemOf W θ) X X ≤ c * innerOp X X

/-- **`λ_max(L_e|_{W^⊥}) ≥ c`, read as a quadratic form**, one admissible direction of nonzero
norm on which the quotient reaches `c`. *This is the shape [L98](../Results/L98Statement.lean) and
[L99](../Results/L99Statement.lean) need at `c = 1`.* -/
def RayleighGE (W : CurvOp ι) (θ c : ℝ) : Prop :=
  ∃ X : CurvOp ι, IsWeylOp X ∧ innerOp X X ≠ 0 ∧ innerOp X W = 0 ∧
    c * innerOp X X ≤ foxTri (idemOf W θ) X X

/-- **THE TWO READINGS ARE COHERENT**: a `≥ c` witness and a `≤ c'` bound force `c ≤ c'`. *So
`RayleighGE W θ 1` together with L24's `RayleighLE W θ ½` is a contradiction, which is exactly
how [L99](../Results/L99Statement.lean) concludes that its point is not a maximiser.* -/
theorem RayleighGE.le_of_RayleighLE {W : CurvOp ι} {θ c c' : ℝ}
    (hge : RayleighGE W θ c) (hle : RayleighLE W θ c') : c ≤ c' := by
  obtain ⟨X, hX, hne, hperp, hlow⟩ := hge
  have hpos : 0 < innerOp X X := lt_of_le_of_ne (innerOp_self_nonneg X) (Ne.symm hne)
  have hup := hle X hX hperp
  have : c * innerOp X X ≤ c' * innerOp X X := le_trans hlow hup
  exact le_of_mul_le_mul_right (by linarith) hpos

/-- **`RayleighLE` is monotone in its bound**, the other half of the comparison. -/
theorem RayleighLE.mono {W : CurvOp ι} {θ c c' : ℝ} (h : RayleighLE W θ c) (hcc : c ≤ c') :
    RayleighLE W θ c' := by
  intro X hX hperp
  refine le_trans (h X hX hperp) ?_
  exact mul_le_mul_of_nonneg_right hcc (innerOp_self_nonneg X)

end

end HamiltonsCubic.RealLayer
