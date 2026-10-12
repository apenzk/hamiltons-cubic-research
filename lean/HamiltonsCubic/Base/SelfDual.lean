import Mathlib
import HamiltonsCubic.Base.WeylReal

/-!
# Area forms, the wedge, `Φ`, and the Hodge star on `Λ²`

**Why this file exists.** [L181Statement.lean](../Results/L181Statement.lean),
[L183Statement.lean](../Results/L183Statement.lean) and
[L184Statement.lean](../Results/L184Statement.lean) each carry a local copy of the wedge and of
`Φ`, and each says under its own *"What is NOT typed here"* that the objects around them, the unit
area form of a plane, the self-dual `2`-forms of `ℝ⁴`, the Hodge star, are not built. This file
builds them once, over `ℝ`, beside [WeylReal.lean](WeylReal.lean).

**The convention is the one those three files already fixed**, and is not a third reading:
`(X ∧ X)_{abcd} = 2(X_{ab}X_{cd} - X_{ac}X_{bd} + X_{ad}X_{bc})`, with `Λ⁴` realised by its
components. `inner2`, [WeylReal.lean](WeylReal.lean)'s `Λ²` pairing, which carries the `½`, is
the pairing throughout, so a plane's unit area form has norm `1` and not the Frobenius `2`.

**What supersedes what.** `inner2_areaForm` generalises L184's `inner2_phi_self` (its `a ≠ b` case
is the orthonormality of two standard basis vectors) and `wedgeSelf_areaForm` generalises L184's
`wedgeSelf_decomposable` (`areaForm u v` is that file's `u vᵀ - v uᵀ` up to the sign that makes
`areaForm eᵢ eⱼ = φᵢⱼ` hold on the nose).

## What the record does not define

* **The record never writes `Φ`'s wedge in components.** It writes `ω ∧ ω` and reads it in `Λ⁴`.
  The component realisation, and with it the factor `2`, is
  [L179Statement.lean](../Results/L179Statement.lean)'s and is adopted here; the anchor that fixes
  it is `wedgeSelf_sdForm_apply` below, where the record's own
  *`ω ∧ ω = ⟨ω, ⋆ω⟩ f₁₂₃₄ = ‖ω‖² f₁₂₃₄`* comes out with the coefficient the record states.
* **`Λ²₊` is named and never defined.** [diagonal-half.md](../../../findings/diagonal-half.md)
  speaks of *"the self-dual forms of `ℝ⁴`"* and [conventions.md](../../../findings/conventions.md)
  of *"`⋆ = Π_SD − Π_ASD`, with `‖⋆‖² = 6`"*. The reading taken here is the eigenspace one:
  `star4` is the Hodge star on `Λ²ℝ⁴` built from the Levi-Civita symbol of the standard
  orientation, `IsSelfDual X` is `star4 X = X`, and `selfDualForms` is the submodule they cut out.
  *`star4_phi` gives `⋆` on the whole `φ` basis in closed form and `sdForm_selfDual` exhibits three
  self-dual forms, so the reading is checkable against the record's own numbers, `‖ω‖² = 1` and
  `ω² = -½Id₄` at `inner2_unitSD` and `unitSD_sq`, rather than against prose.*
* **`⋆_V` is `V`'s star, and `V` is a six-dimensional subspace of `ℝⁿ`.** The record is emphatic
  that this is not `ℝⁿ`'s star. What is built here is `star6`, the star `Λ⁴ℝ⁶ → Λ²ℝ⁶` at
  `ι = Fin 6`, which is `⋆_V` read in an orthonormal frame of `V`; **the reduction of a
  six-dimensional `V ⊆ ℝⁿ` to `ℝ⁶` is not typed**, so a consumer at general `ι` must supply it.
* **The normalisation of `star6` is a choice this file makes.** `(⋆T)_{ab} = (1/4!)·Σ ε_{abcdef}
  T_{cdef}`, the one under which the record's `⋆e₁₂₃₄ = e₅₆` holds for a `4`-form written in
  components. *That anchor is not verified in Lean here*, see the debt below.

## The owed identity

**`⋆_V(J ∧ J) = 2 ε_J J` IS PROVED**, as `starWedgeIdentity_holds` in
[I67PfSign.lean](../Results/I67PfSign.lean): `pf6 J = ±1` at every complex structure, from `pf6_conj` and an
orthogonal normal form, then [L193Statement.lean](../Results/L193Statement.lean)'s `starWedge_of_pf`.
*The predicate `StarWedgeIdentity` states it, `pm_of_eq_wedgeSelf` is the step of L184's case 2
that follows from it, and `stdJ6_isComplexStructure` exhibits a complex structure on `ℝ⁶`, so
neither is vacuous.*

**It holds at `dim V = 6` only**, the record: *"`⋆(J ∧ J)` lands in `Λ²` only in six dimensions,
and read on `ℝⁿ` for `n > 6` the identity is false"*, which is why the predicate is stated at
`Fin 6` and not at general `ι`.

## What is NOT typed here

* **The `finrank` statement `dim Λ²₊ = 3`.** `star4_star4` proves `⋆ ∘ ⋆ = id` on bivectors,
  `selfDual_expand` proves the three exhibited members span, and `sdCombo_independent` proves they
  are independent, so `Λ²₊` has a three-element basis. **No declaration states the dimension**, and
  no declaration in this file states it. *`finrank` and `Submodule.span` are used freely in
  [Results/](../Results/), so the absence is this layer's rather than the repository's.*
* **The splitting `Λ²ℝ⁴ = Λ²₊ ⊕ Λ²₋`.** `IsAntiSelfDual` is defined and is the subject of no
  theorem, so the minus side of `W^±` is untouched. *L178's step 1 also needs `W` block-diagonal for
  the splitting and each summand trace-free, the second coming from tracelessness together with
  first Bianchi, and neither is typed.*
* **The `4`-form identity `ω ∧ ω = ‖ω‖² f₁₂₃₄`.** Only its `(0,1,2,3)` component is proved, which
  with the alternating lemmas above determines the rest; the step needing `Λ⁴ℝ⁴`'s
  one-dimensionality is left out. **So L183's *"at `n = 4` the three images coincide"* is typed in
  its first component only** (`sdForm_sq`) and not as `Φ(ω₁) = Φ(ω₂) = Φ(ω₃)`.
* **`star6`'s normalisation anchor `⋆e₁₂₃₄ = e₅₆`.** The constant `1/4!` is taken from the record
  and is not checked in Lean.
* **The owed identity itself**, above.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.SelfDualLayer

open HamiltonsCubic.RealLayer Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

noncomputable section

/-! ## The wedge on components, and `Φ`

*The convention of [L179](../Results/L179Statement.lean), [L181](../Results/L181Statement.lean),
[L183](../Results/L183Statement.lean) and [L184](../Results/L184Statement.lean), carried unchanged.*
-/

/-- One half of the wedge of two `2`-forms: `X_{ab}Y_{cd} - X_{ac}Y_{bd} + X_{ad}Y_{bc}`. -/
def halfw (X Y : Matrix ι ι ℝ) : ι → ι → ι → ι → ℝ :=
  fun a b c d => X a b * Y c d - X a c * Y b d + X a d * Y b c

/-- **`(X ∧ Y)_{abcd}`**, the symmetrised sum of the two halves. -/
def wedge2 (X Y : Matrix ι ι ℝ) : ι → ι → ι → ι → ℝ := halfw X Y + halfw Y X

/-- **`(X ∧ X)_{abcd} = 2(X_{ab}X_{cd} - X_{ac}X_{bd} + X_{ad}X_{bc})`.** -/
def wedgeSelf (X : Matrix ι ι ℝ) : ι → ι → ι → ι → ℝ := wedge2 X X

/-- **`Φ(ω) = (ω², ω ∧ ω)`**, the record's map `Λ²ℝⁿ → S²(ℝⁿ) ⊕ Λ⁴ℝⁿ`, with the direct sum
realised as the product of a matrix and a four-index function. -/
def Phi (X : Matrix ι ι ℝ) : Matrix ι ι ℝ × (ι → ι → ι → ι → ℝ) := (X * X, wedgeSelf X)

theorem wedgeSelf_apply (X : Matrix ι ι ℝ) (a b c d : ι) :
    wedgeSelf X a b c d = 2 * (X a b * X c d - X a c * X b d + X a d * X b c) := by
  unfold wedgeSelf wedge2 halfw; simp only [Pi.add_apply]; ring

theorem wedge2_comm (X Y : Matrix ι ι ℝ) : wedge2 X Y = wedge2 Y X := by
  unfold wedge2; exact add_comm _ _

theorem wedge2_add_left (X Y Z : Matrix ι ι ℝ) :
    wedge2 (X + Y) Z = wedge2 X Z + wedge2 Y Z := by
  funext a b c d; simp only [wedge2, halfw, Pi.add_apply, Matrix.add_apply]; ring

theorem wedge2_smul_left (c : ℝ) (X Y : Matrix ι ι ℝ) :
    wedge2 (c • X) Y = c • wedge2 X Y := by
  funext a b p q; simp only [wedge2, halfw, Pi.add_apply, Pi.smul_apply, Matrix.smul_apply,
    smul_eq_mul]; ring

theorem wedgeSelf_zero : wedgeSelf (0 : Matrix ι ι ℝ) = 0 := by
  funext a b c d; simp [wedgeSelf_apply]

/-- **`ω ∧ ω` is quadratic**, which is why the record's `Φ` separates `ω` from `2ω` and why
rescaling an eigenform changes the configuration. -/
theorem wedgeSelf_smul (c : ℝ) (X : Matrix ι ι ℝ) :
    wedgeSelf (c • X) = (c ^ 2) • wedgeSelf X := by
  funext a b p q
  simp only [wedgeSelf_apply, Pi.smul_apply, Matrix.smul_apply, smul_eq_mul]
  ring

theorem wedgeSelf_neg (X : Matrix ι ι ℝ) : wedgeSelf (-X) = wedgeSelf X := by
  funext a b c d; simp only [wedgeSelf_apply, Matrix.neg_apply]; ring

/-! ### `ω ∧ ω` is alternating on a skew `ω`

*`Λ⁴` is realised by components, so this is the fact that those components really are a `4`-form.*
-/

theorem wedgeSelf_swap01 {X : Matrix ι ι ℝ} (hX : IsSkew X) (a b c d : ι) :
    wedgeSelf X b a c d = - wedgeSelf X a b c d := by
  have h : ∀ p q : ι, X q p = - X p q := fun p q => by
    have := congrFun (congrFun hX p) q; simpa [Matrix.transpose_apply] using this
  simp only [wedgeSelf_apply, h b a]
  ring

theorem wedgeSelf_swap12 {X : Matrix ι ι ℝ} (hX : IsSkew X) (a b c d : ι) :
    wedgeSelf X a c b d = - wedgeSelf X a b c d := by
  have h : ∀ p q : ι, X q p = - X p q := fun p q => by
    have := congrFun (congrFun hX p) q; simpa [Matrix.transpose_apply] using this
  simp only [wedgeSelf_apply, h c b]
  ring

theorem wedgeSelf_swap23 {X : Matrix ι ι ℝ} (hX : IsSkew X) (a b c d : ι) :
    wedgeSelf X a b d c = - wedgeSelf X a b c d := by
  have h : ∀ p q : ι, X q p = - X p q := fun p q => by
    have := congrFun (congrFun hX p) q; simpa [Matrix.transpose_apply] using this
  simp only [wedgeSelf_apply, h d c]
  ring

/-- **A repeated index kills it**, the other half of being alternating. -/
theorem wedgeSelf_diag01 {X : Matrix ι ι ℝ} (hX : IsSkew X) (a c d : ι) :
    wedgeSelf X a a c d = 0 := by
  have h : ∀ p q : ι, X q p = - X p q := fun p q => by
    have := congrFun (congrFun hX p) q; simpa [Matrix.transpose_apply] using this
  have haa : X a a = 0 := by have := h a a; linarith
  simp only [wedgeSelf_apply, haa]
  ring

/-! ### `Φ`'s own sanity facts -/

theorem Phi_zero : Phi (0 : Matrix ι ι ℝ) = 0 := by
  unfold Phi; rw [Prod.ext_iff]; exact ⟨by simp, wedgeSelf_zero⟩

/-- **`Φ` does not see a sign**, both components being quadratic. -/
theorem Phi_neg (X : Matrix ι ι ℝ) : Phi (-X) = Phi X := by
  unfold Phi; rw [Prod.ext_iff]
  exact ⟨by simp, wedgeSelf_neg X⟩

/-- **`Φ` is quadratic**, which is the record's reason that rescaling an eigenform moves its image
off the others, *"`Φ` being quadratic gives `Φ(ω₃') = 4P` against `Φ₁ = Φ₂ = P`"*. -/
theorem Phi_smul (c : ℝ) (X : Matrix ι ι ℝ) : Phi (c • X) = (c ^ 2) • Phi X := by
  unfold Phi
  rw [Prod.ext_iff]
  refine ⟨?_, wedgeSelf_smul c X⟩
  simp only [Matrix.smul_mul, Matrix.mul_smul, smul_smul, Prod.smul_fst]
  ring_nf

/-! ## Area forms

**The record's `ε_j`**, *the unit area-form of a plane `P_j`*, and the object L184's case 1 means
by *"a skew map on a plane is a multiple of its area form"*. The definition is fixed so that the
area form of two standard basis vectors is [WeylReal.lean](WeylReal.lean)'s basis bivector:
`areaForm eᵢ eⱼ = φᵢⱼ`. -/

/-- **The area form of the ordered pair `(u, v)`**, `v uᵀ - u vᵀ` entrywise. *The order of the
outer products is what makes `areaForm eᵢ eⱼ = φᵢⱼ` hold, `phi` carrying `-1` at `(i,j)`.* -/
def areaForm (u v : ι → ℝ) : Matrix ι ι ℝ := Matrix.of fun a b => u b * v a - v b * u a

theorem areaForm_apply (u v : ι → ℝ) (a b : ι) :
    areaForm u v a b = u b * v a - v b * u a := rfl

theorem areaForm_isSkew (u v : ι → ℝ) : IsSkew (areaForm u v) := by
  unfold IsSkew
  ext a b
  simp only [Matrix.transpose_apply, areaForm_apply, Matrix.neg_apply]
  ring

theorem areaForm_swap (u v : ι → ℝ) : areaForm v u = - areaForm u v := by
  ext a b; simp only [areaForm_apply, Matrix.neg_apply]; ring

theorem areaForm_self (u : ι → ℝ) : areaForm u u = 0 := by
  ext a b; simp [areaForm_apply]

/-- **The basis bivector is an area form**: `φᵢⱼ = areaForm eᵢ eⱼ`. *This is the anchor that fixes
the sign of `areaForm`, and it makes every lemma below a statement about `phi` as well.* -/
theorem areaForm_single (i j : ι) :
    areaForm (Pi.single i (1 : ℝ)) (Pi.single j (1 : ℝ)) = phi i j := by
  ext a b
  have hs : ∀ p q : ι, (Pi.single p (1 : ℝ) : ι → ℝ) q = if p = q then 1 else 0 := by
    intro p q; rw [Pi.single_apply]; exact if_congr eq_comm rfl rfl
  have hm : ∀ p q : ι, (Matrix.single p q (1 : ℝ)) a b
      = if p = a then (if q = b then (1 : ℝ) else 0) else 0 := by
    intro p q; simp [Matrix.single_apply, ite_and]
  simp only [areaForm_apply, phi, Matrix.sub_apply, hs, hm]
  split_ifs <;> norm_num

/-- **The `Λ²` pairing of two area forms is the Gram determinant of the four vectors.** *Every
normalisation fact this file needs is a case of it: unit norm, orthogonality of the forms of
orthogonal planes, and L184's `inner2_phi_self`.* -/
theorem inner2_areaForm (u v u' v' : ι → ℝ) :
    inner2 (areaForm u v) (areaForm u' v')
      = (u ⬝ᵥ u') * (v ⬝ᵥ v') - (u ⬝ᵥ v') * (v ⬝ᵥ u') := by
  rw [inner2_eq_sum]
  have inner : ∀ a : ι, ∑ b : ι, areaForm u v a b * areaForm u' v' a b
      = (v a * v' a) * (u ⬝ᵥ u') - (v a * u' a) * (u ⬝ᵥ v')
        - (u a * v' a) * (v ⬝ᵥ u') + (u a * u' a) * (v ⬝ᵥ v') := by
    intro a
    have hb : ∀ b : ι, areaForm u v a b * areaForm u' v' a b
        = (v a * v' a) * (u b * u' b) - (v a * u' a) * (u b * v' b)
          - (u a * v' a) * (v b * u' b) + (u a * u' a) * (v b * v' b) := by
      intro b; simp only [areaForm_apply]; ring
    simp only [hb, dotProduct]
    rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_sub_distrib,
        ← Finset.mul_sum, ← Finset.mul_sum, ← Finset.mul_sum, ← Finset.mul_sum]
  simp only [inner]
  rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_sub_distrib,
      ← Finset.sum_mul, ← Finset.sum_mul, ← Finset.sum_mul, ← Finset.sum_mul]
  simp only [dotProduct]
  ring

/-- **The unit area form of a plane has `Λ²` norm `1`.** *Under plain Frobenius it would be `2`;
this is the convention [WeylReal.lean](WeylReal.lean)'s `½` buys, and the one the record's
"orthonormal triple" is read in.* -/
theorem inner2_areaForm_self_of_orthonormal (u v : ι → ℝ)
    (huu : u ⬝ᵥ u = 1) (hvv : v ⬝ᵥ v = 1) (huv : u ⬝ᵥ v = 0) :
    inner2 (areaForm u v) (areaForm u v) = 1 := by
  rw [inner2_areaForm, huu, hvv, huv]; ring

/-- **Area forms of orthogonal planes are `Λ²`-orthogonal.** -/
theorem inner2_areaForm_eq_zero (u v u' v' : ι → ℝ)
    (h1 : u ⬝ᵥ u' = 0) (h2 : u ⬝ᵥ v' = 0) (h3 : v ⬝ᵥ u' = 0) (h4 : v ⬝ᵥ v' = 0) :
    inner2 (areaForm u v) (areaForm u' v') = 0 := by
  rw [inner2_areaForm, h1, h2, h3, h4]; ring

/-- **The product of two area forms, entrywise.** *L181's `IsPlaneFamily` clause
`εⱼ εₖᵀ = δ_{jk} Πⱼ` is this lemma read twice.* -/
theorem areaForm_mul_apply (u v u' v' : ι → ℝ) (a b : ι) :
    (areaForm u v * areaForm u' v') a b
      = (u ⬝ᵥ v') * (v a * u' b) - (u ⬝ᵥ u') * (v a * v' b)
        - (v ⬝ᵥ v') * (u a * u' b) + (v ⬝ᵥ u') * (u a * v' b) := by
  simp only [Matrix.mul_apply, areaForm_apply, dotProduct]
  have hc : ∀ c : ι, (u c * v a - v c * u a) * (u' b * v' c - v' b * u' c)
      = (u c * v' c) * (v a * u' b) - (u c * u' c) * (v a * v' b)
        - (v c * v' c) * (u a * u' b) + (v c * u' c) * (u a * v' b) := by
    intro c; ring
  simp only [hc]
  rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_sub_distrib,
      ← Finset.sum_mul, ← Finset.sum_mul, ← Finset.sum_mul, ← Finset.sum_mul]

/-- **Area forms of orthogonal planes annihilate each other.** -/
theorem areaForm_mul_eq_zero (u v u' v' : ι → ℝ)
    (h1 : u ⬝ᵥ u' = 0) (h2 : u ⬝ᵥ v' = 0) (h3 : v ⬝ᵥ u' = 0) (h4 : v ⬝ᵥ v' = 0) :
    areaForm u v * areaForm u' v' = 0 := by
  ext a b; rw [areaForm_mul_apply, h1, h2, h3, h4]; simp

/-- **`ε² = -Π` for a unit area form**, `Π` the orthogonal projection onto its plane. *So
`ε εᵀ = Π`, which is L181's clause, and `tr(ε²) = -2`, which is what L183's `sum_lam_eq_zero`
consumes.* -/
theorem areaForm_sq_of_orthonormal (u v : ι → ℝ)
    (huu : u ⬝ᵥ u = 1) (hvv : v ⬝ᵥ v = 1) (huv : u ⬝ᵥ v = 0) :
    areaForm u v * areaForm u v = -(Matrix.of fun a b => u a * u b + v a * v b) := by
  have hvu : v ⬝ᵥ u = 0 := by rw [dotProduct_comm]; exact huv
  ext a b
  rw [areaForm_mul_apply, huu, hvv, huv, hvu]
  simp only [Matrix.neg_apply, Matrix.of_apply]
  ring

/-- **The unit area form times its transpose is the projection onto its plane.** -/
theorem areaForm_mul_transpose_of_orthonormal (u v : ι → ℝ)
    (huu : u ⬝ᵥ u = 1) (hvv : v ⬝ᵥ v = 1) (huv : u ⬝ᵥ v = 0) :
    areaForm u v * (areaForm u v)ᵀ = Matrix.of fun a b => u a * u b + v a * v b := by
  have hskew := areaForm_isSkew u v
  unfold IsSkew at hskew
  rw [hskew, Matrix.mul_neg, areaForm_sq_of_orthonormal u v huu hvv huv, neg_neg]

/-- **A decomposable `2`-form has vanishing self-wedge**, the Plücker cancellation, which holds
for this alternating pattern of signs and for no other. *L181's `IsPlaneFamily` clause
`εⱼ ∧ εⱼ = 0`, and L184's `wedgeSelf_decomposable`.* -/
theorem wedgeSelf_areaForm (u v : ι → ℝ) : wedgeSelf (areaForm u v) = 0 := by
  funext a b c d
  simp only [wedgeSelf_apply, areaForm_apply, Pi.zero_apply]
  ring

/-- **`Φ` of a unit area form**, both components at once. -/
theorem Phi_areaForm_of_orthonormal (u v : ι → ℝ)
    (huu : u ⬝ᵥ u = 1) (hvv : v ⬝ᵥ v = 1) (huv : u ⬝ᵥ v = 0) :
    Phi (areaForm u v) = (-(Matrix.of fun a b => u a * u b + v a * v b), 0) := by
  unfold Phi
  rw [Prod.ext_iff]
  exact ⟨areaForm_sq_of_orthonormal u v huu hvv huv, wedgeSelf_areaForm u v⟩


/-! ## The Levi-Civita symbol

*The orientation form of the standard frame, in the shape that makes both stars below one formula:
`ε` is the product of the pair signs, which is `+1` on an even rearrangement, `-1` on an odd one
and `0` when two indices repeat.* -/

/-- The sign of an ordered pair: `+1`, `-1` or `0`. -/
def sgnR {α : Type*} [LinearOrder α] (x y : α) : ℝ :=
  if x < y then 1 else if y < x then -1 else 0

theorem sgnR_swap {α : Type*} [LinearOrder α] (x y : α) : sgnR y x = - sgnR x y := by
  unfold sgnR
  rcases lt_trichotomy x y with h | h | h
  · simp [h, asymm h]
  · subst h; simp
  · simp [h, asymm h]

/-! ## The Hodge star on `Λ²ℝ⁴`, and `Λ²₊`

**The record's `⋆ = Π_SD − Π_ASD` on `Λ²ℝ⁴`**, built here from the Levi-Civita symbol of the
standard orientation as `(⋆X)_{ab} = ½ Σ_{cd} ε_{abcd} X_{cd}`, and `Λ²₊` as its `+1` eigenspace
inside the skew matrices. -/

/-- The Levi-Civita symbol on four indices. -/
def levi4 (a b c d : Fin 4) : ℝ :=
  sgnR a b * sgnR a c * sgnR a d * sgnR b c * sgnR b d * sgnR c d

theorem levi4_swap01 (a b c d : Fin 4) : levi4 b a c d = - levi4 a b c d := by
  unfold levi4; rw [sgnR_swap b a]; ring

theorem levi4_swap23 (a b c d : Fin 4) : levi4 a b d c = - levi4 a b c d := by
  unfold levi4; rw [sgnR_swap d c]; ring

/-- **The Hodge star on `Λ²ℝ⁴`.** *The `½` pays for the ordered-pair double count in the
contraction, exactly as [WeylReal.lean](WeylReal.lean)'s sums do.* -/
def star4 (X : Matrix (Fin 4) (Fin 4) ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  Matrix.of fun a b => (1 / 2) * ∑ c : Fin 4, ∑ d : Fin 4, levi4 a b c d * X c d

theorem star4_apply (X : Matrix (Fin 4) (Fin 4) ℝ) (a b : Fin 4) :
    star4 X a b = (1 / 2) * ∑ c : Fin 4, ∑ d : Fin 4, levi4 a b c d * X c d := rfl

theorem star4_add (X Y : Matrix (Fin 4) (Fin 4) ℝ) : star4 (X + Y) = star4 X + star4 Y := by
  ext a b
  simp only [Matrix.add_apply, star4_apply, mul_add, Finset.sum_add_distrib]

theorem star4_smul (c : ℝ) (X : Matrix (Fin 4) (Fin 4) ℝ) : star4 (c • X) = c • star4 X := by
  ext a b
  have h : ∀ p : Fin 4, ∑ q : Fin 4, levi4 a b p q * (c * X p q)
      = c * ∑ q : Fin 4, levi4 a b p q * X p q := by
    intro p
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun q _ => by ring
  simp only [Matrix.smul_apply, star4_apply, smul_eq_mul, h, ← Finset.mul_sum]
  ring

theorem star4_neg (X : Matrix (Fin 4) (Fin 4) ℝ) : star4 (-X) = - star4 X := by
  have := star4_smul (-1) X
  simpa using this

/-- **The star of a bivector is a bivector**, from the antisymmetry of `ε` in its first two
slots. -/
theorem star4_isSkew (X : Matrix (Fin 4) (Fin 4) ℝ) : IsSkew (star4 X) := by
  unfold IsSkew
  ext a b
  have h : ∀ c d : Fin 4, levi4 b a c d * X c d = -(levi4 a b c d * X c d) := by
    intro c d; rw [levi4_swap01]; ring
  simp only [Matrix.transpose_apply, star4_apply, Matrix.neg_apply, h,
    Finset.sum_neg_distrib, mul_neg]

/-- **The star on the basis bivectors**, in closed form. *Everything below reads off this: the
`φ` family is `Λ²`'s basis, so this is the whole of `⋆`.* -/
theorem star4_phi (i j : Fin 4) :
    star4 (phi i j) = Matrix.of fun a b => - levi4 a b i j := by
  ext a b
  rw [star4_apply]
  have hentry : ∀ c d : Fin 4, levi4 a b c d * (phi i j) c d
      = (if i = d then (if j = c then levi4 a b c d else 0) else 0)
        - (if j = d then (if i = c then levi4 a b c d else 0) else 0) := by
    intro c d
    simp only [phi, Matrix.sub_apply, Matrix.single_apply, ite_and, mul_sub, mul_ite, mul_one,
      mul_zero]
    split_ifs <;> ring
  simp only [hentry, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  rw [levi4_swap23 a b i j]
  simp only [Matrix.of_apply]
  ring

/-! ### The self-dual forms

*The record calls them "the self-dual forms of `ℝ⁴`" and never defines them; this is the eigenspace
reading, and the anchors below let a consumer check it against the record's own numbers.* -/

/-- **`Λ²₊`**: the self-dual bivectors of `ℝ⁴`. -/
def IsSelfDual (X : Matrix (Fin 4) (Fin 4) ℝ) : Prop := star4 X = X

/-- The anti-self-dual bivectors, `Λ²₋`. -/
def IsAntiSelfDual (X : Matrix (Fin 4) (Fin 4) ℝ) : Prop := star4 X = -X

/-- **`Λ²₊` as a subspace.** *`sdForm` exhibits three members, `inner2_sdForm` makes them pairwise
orthogonal, `selfDual_expand` shows they span and `sdCombo_independent` shows they are independent,
so `Λ²₊` has a three-element basis.* **The `finrank` statement itself is owed**, and until a
declaration carries it the three-dimensionality is a consequence of what is here rather than
something this layer states. -/
def selfDualForms : Submodule ℝ (Matrix (Fin 4) (Fin 4) ℝ) where
  carrier := {X | IsSkew X ∧ IsSelfDual X}
  add_mem' := by
    rintro X Y ⟨hX1, hX2⟩ ⟨hY1, hY2⟩
    refine ⟨?_, ?_⟩
    · unfold IsSkew at hX1 hY1 ⊢; rw [Matrix.transpose_add, hX1, hY1]; abel
    · unfold IsSelfDual at hX2 hY2 ⊢; rw [star4_add, hX2, hY2]
  zero_mem' := by
    refine ⟨?_, ?_⟩
    · unfold IsSkew; simp
    · unfold IsSelfDual; ext a b; simp [star4_apply]
  smul_mem' := by
    rintro c X ⟨hX1, hX2⟩
    refine ⟨?_, ?_⟩
    · unfold IsSkew at hX1 ⊢; rw [Matrix.transpose_smul, hX1]; simp
    · unfold IsSelfDual at hX2 ⊢; rw [star4_smul, hX2]

/-- **The three self-dual forms of the standard frame.** *Not normalised: each has `Λ²` norm
squared `2`, so the record's unit self-dual forms are these over `√2`, which is `unitSD`.* -/
def sdForm : Fin 3 → Matrix (Fin 4) (Fin 4) ℝ :=
  ![phi 0 1 + phi 2 3, phi 0 2 - phi 1 3, phi 0 3 + phi 1 2]

theorem sdForm_isSkew (k : Fin 3) : IsSkew (sdForm k) := by
  have hadd : ∀ X Y : Matrix (Fin 4) (Fin 4) ℝ, IsSkew X → IsSkew Y → IsSkew (X + Y) := by
    intro X Y hX hY; unfold IsSkew at *; rw [Matrix.transpose_add, hX, hY]; abel
  have hsub : ∀ X Y : Matrix (Fin 4) (Fin 4) ℝ, IsSkew X → IsSkew Y → IsSkew (X - Y) := by
    intro X Y hX hY; unfold IsSkew at *; rw [Matrix.transpose_sub, hX, hY]; abel
  fin_cases k
  · show IsSkew (phi 0 1 + phi 2 3); exact hadd _ _ (phi_isSkew 0 1) (phi_isSkew 2 3)
  · show IsSkew (phi 0 2 - phi 1 3); exact hsub _ _ (phi_isSkew 0 2) (phi_isSkew 1 3)
  · show IsSkew (phi 0 3 + phi 1 2); exact hadd _ _ (phi_isSkew 0 3) (phi_isSkew 1 2)

theorem sdForm_selfDual (k : Fin 3) : IsSelfDual (sdForm k) := by
  unfold IsSelfDual sdForm
  fin_cases k
  · show star4 (phi 0 1 + phi 2 3) = _
    rw [star4_add, star4_phi, star4_phi]
    ext a b
    fin_cases a <;> fin_cases b <;> simp [levi4, sgnR, phi]
  · show star4 (phi 0 2 - phi 1 3) = _
    rw [sub_eq_add_neg, star4_add, star4_neg, star4_phi, star4_phi]
    ext a b
    fin_cases a <;> fin_cases b <;> simp [levi4, sgnR, phi]
  · show star4 (phi 0 3 + phi 1 2) = _
    rw [star4_add, star4_phi, star4_phi]
    ext a b
    fin_cases a <;> fin_cases b <;> simp [levi4, sgnR, phi]

theorem sdForm_mem (k : Fin 3) : sdForm k ∈ selfDualForms :=
  ⟨sdForm_isSkew k, sdForm_selfDual k⟩

/-- **The three are `Λ²`-orthogonal with norm squared `2`**, so `sdForm k / √2` is the record's
unit self-dual form. -/
theorem inner2_sdForm (i j : Fin 3) : inner2 (sdForm i) (sdForm j) = if i = j then 2 else 0 := by
  fin_cases i <;> fin_cases j <;>
    simp [sdForm, inner2_eq_sum, Fin.sum_univ_four, phi, Matrix.single_apply, Matrix.add_apply,
      Matrix.sub_apply] <;> norm_num

/-- **The `Λ²` pairing is quadratic under a common rescaling**, which is what turns the
unnormalised anchors below into the record's unit ones. -/
theorem inner2_smul_smul (c : ℝ) (X Y : Matrix ι ι ℝ) :
    inner2 (c • X) (c • Y) = c ^ 2 * inner2 X Y := by
  simp only [inner2, Matrix.transpose_smul, Matrix.smul_mul, Matrix.mul_smul, smul_smul,
    Matrix.trace_smul, smul_eq_mul]
  ring

/-- **The square of a self-dual form of the standard frame is `-Id₄`.** *The record reads it at
unit norm as `ωᵢ² = -½Id₄`, which is `unitSD_sq` below; the factor is the `√2` between the two.* -/
theorem sdForm_sq (k : Fin 3) : sdForm k * sdForm k = -1 := by
  have hp : ∀ i j a b : Fin 4, phi i j a b
      = (if j = a then (if i = b then (1 : ℝ) else 0) else 0)
        - (if i = a then (if j = b then (1 : ℝ) else 0) else 0) := by
    intro i j a b
    simp only [phi, Matrix.sub_apply, Matrix.single_apply, ite_and]
  fin_cases k
  · show (phi 0 1 + phi 2 3) * (phi 0 1 + phi 2 3) = -1
    ext a b
    simp only [Matrix.mul_apply, Matrix.add_apply, Fin.sum_univ_four, hp, Matrix.neg_apply,
      Matrix.one_apply]
    fin_cases a <;> fin_cases b <;> simp
  · show (phi 0 2 - phi 1 3) * (phi 0 2 - phi 1 3) = -1
    ext a b
    simp only [Matrix.mul_apply, Matrix.sub_apply, Fin.sum_univ_four, hp, Matrix.neg_apply,
      Matrix.one_apply]
    fin_cases a <;> fin_cases b <;> simp
  · show (phi 0 3 + phi 1 2) * (phi 0 3 + phi 1 2) = -1
    ext a b
    simp only [Matrix.mul_apply, Matrix.add_apply, Fin.sum_univ_four, hp, Matrix.neg_apply,
      Matrix.one_apply]
    fin_cases a <;> fin_cases b <;> simp

/-- **The self-wedge of a self-dual form of the standard frame has `(0,1,2,3)` component `2`**,
which is `‖ω‖²`, the record's `ω ∧ ω = ⟨ω, ⋆ω⟩ f₁₂₃₄ = ‖ω‖² f₁₂₃₄` read at the one component
`Λ⁴ℝ⁴` has. *This is the anchor that fixes the wedge's factor `2`: any other normalisation of
`wedgeSelf` puts a different constant here.*

**The `4`-form identity itself is not typed.** *`wedgeSelf` of a skew form is alternating,
`wedgeSelf_swap01`, `wedgeSelf_swap12`, `wedgeSelf_swap23` and `wedgeSelf_diag01` above, so this
one component does determine the rest; the step from those to the full identity needs
`Λ⁴ℝ⁴`'s one-dimensionality, which is `4! = 24` sign bookkeeping at `Fin 4` and is left out.
**With it would come L183's `Φ(ω₁) = Φ(ω₂) = Φ(ω₃)` at `n = 4`, which is therefore also not
typed**, only the first component of that coincidence, `sdForm_sq`, is.* -/
theorem wedgeSelf_sdForm_apply (k : Fin 3) : wedgeSelf (sdForm k) 0 1 2 3 = 2 := by
  have hp : ∀ i j a b : Fin 4, phi i j a b
      = (if j = a then (if i = b then (1 : ℝ) else 0) else 0)
        - (if i = a then (if j = b then (1 : ℝ) else 0) else 0) := by
    intro i j a b
    simp only [phi, Matrix.sub_apply, Matrix.single_apply, ite_and]
  fin_cases k
  · show wedgeSelf (phi 0 1 + phi 2 3) 0 1 2 3 = 2
    simp only [wedgeSelf_apply, Matrix.add_apply, hp]
    simp
  · show wedgeSelf (phi 0 2 - phi 1 3) 0 1 2 3 = 2
    simp only [wedgeSelf_apply, Matrix.sub_apply, hp]
    simp
  · show wedgeSelf (phi 0 3 + phi 1 2) 0 1 2 3 = 2
    simp only [wedgeSelf_apply, Matrix.add_apply, hp]
    simp

/-! ### The record's unit self-dual forms

*`ωᵢ² = -½Id₄` and `ωᵢ ∧ ωᵢ = f₁₂₃₄` are the two numbers the record states, and they come out of
the definitions above with the `√2` that unit `Λ²` norm requires.* -/

/-- The unit self-dual forms of the standard frame, `sdForm k / √2`. -/
def unitSD (k : Fin 3) : Matrix (Fin 4) (Fin 4) ℝ := (Real.sqrt 2)⁻¹ • sdForm k

theorem inv_sqrt_two_sq : ((Real.sqrt 2)⁻¹ : ℝ) ^ 2 = 1 / 2 := by
  rw [inv_pow, Real.sq_sqrt (by norm_num : (2 : ℝ) ≥ 0)]
  norm_num

theorem inner2_unitSD (i j : Fin 3) :
    inner2 (unitSD i) (unitSD j) = if i = j then 1 else 0 := by
  unfold unitSD
  rw [inner2_smul_smul, inv_sqrt_two_sq, inner2_sdForm]
  by_cases h : i = j <;> simp [h]

/-- **`ω² = -½ Id₄` on a unit self-dual form**, the record's own figure. -/
theorem unitSD_sq (k : Fin 3) :
    unitSD k * unitSD k = (-(1 / 2 : ℝ)) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  unfold unitSD
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, sdForm_sq, ← sq, inv_sqrt_two_sq]
  simp

/-- **`ω ∧ ω = f₁₂₃₄` on a unit self-dual form**, the record's own figure, read at `Λ⁴ℝ⁴`'s one
component. -/
theorem wedgeSelf_unitSD_apply (k : Fin 3) : wedgeSelf (unitSD k) 0 1 2 3 = 1 := by
  unfold unitSD
  rw [wedgeSelf_smul, Pi.smul_apply, Pi.smul_apply, Pi.smul_apply, Pi.smul_apply,
    wedgeSelf_sdForm_apply, inv_sqrt_two_sq]
  norm_num

/-- **`‖⋆‖² = 6`**, [conventions.md](../../../findings/conventions.md)'s figure for the Hodge star
read as a curvature operator through [WeylReal.lean](WeylReal.lean)'s `normSq`. *The value is
`dim Λ²ℝ⁴ = 6`: the `24` four-index tuples with distinct entries each contribute `1`,
against the `¼` the two ordered-pair sums carry. **It is the record's number, so it is a check on
`star4`'s `½`**, halving or doubling the star's constant moves it to `3/2` or `24`.* -/
theorem normSq_star4 : normSq star4 = 6 := by
  simp only [normSq, innerOp, star4_phi, inner2_eq_sum, Matrix.of_apply]
  simp [Fin.sum_univ_four, levi4, sgnR]
  norm_num

/-! ## `⋆_V` at `dim V = 6`, and the star-wedge identity

*The record's case 2 of [L184](../Results/L184Statement.lean) runs on `⋆_V(J ∧ J) = 2 ε_J J`. The
objects it relates are built here, and the relation is `starWedgeIdentity_holds` in
[I67PfSign.lean](../Results/I67PfSign.lean).* -/

/-- The Levi-Civita symbol on six indices. -/
def levi6 (a b c d e f : Fin 6) : ℝ :=
  sgnR a b * sgnR a c * sgnR a d * sgnR a e * sgnR a f *
    (sgnR b c * sgnR b d * sgnR b e * sgnR b f) *
    (sgnR c d * sgnR c e * sgnR c f) * (sgnR d e * sgnR d f) * sgnR e f

theorem levi6_swap01 (a b c d e f : Fin 6) :
    levi6 b a c d e f = - levi6 a b c d e f := by
  unfold levi6; rw [sgnR_swap b a]; ring

/-- **`⋆_V : Λ⁴V → Λ²V` at `dim V = 6`**, read in an orthonormal frame of `V`.

`(⋆T)_{ab} = (1/4!)·Σ_{cdef} ε_{abcdef} T_{cdef}`, the normalisation under which the record's
`⋆e₁₂₃₄ = e₅₆` holds for a `4`-form written in components. **That anchor is not verified in
Lean.** *The record is emphatic that this is `V`'s star and not `ℝⁿ`'s, `⋆(J ∧ J)` lands in `Λ²`
only in six dimensions, which is why this is stated at `Fin 6` and the reduction of a
six-dimensional `V ⊆ ℝⁿ` to `ℝ⁶` is left to the consumer.* -/
def star6 (T : Fin 6 → Fin 6 → Fin 6 → Fin 6 → ℝ) : Matrix (Fin 6) (Fin 6) ℝ :=
  Matrix.of fun a b =>
    (1 / 24) * ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6, levi6 a b c d e f * T c d e f

theorem star6_apply (T : Fin 6 → Fin 6 → Fin 6 → Fin 6 → ℝ) (a b : Fin 6) :
    star6 T a b =
      (1 / 24) * ∑ c : Fin 6, ∑ d : Fin 6, ∑ e : Fin 6, ∑ f : Fin 6,
        levi6 a b c d e f * T c d e f := rfl

/-- **`⋆_V` lands in `Λ²`**, from the antisymmetry of `ε` in its first two slots. -/
theorem star6_isSkew (T : Fin 6 → Fin 6 → Fin 6 → Fin 6 → ℝ) : IsSkew (star6 T) := by
  unfold IsSkew
  ext a b
  have h : ∀ c d e f : Fin 6, levi6 b a c d e f * T c d e f
      = -(levi6 a b c d e f * T c d e f) := by
    intro c d e f; rw [levi6_swap01]; ring
  simp only [Matrix.transpose_apply, star6_apply, Matrix.neg_apply, h,
    Finset.sum_neg_distrib, mul_neg]

theorem star6_add (S T : Fin 6 → Fin 6 → Fin 6 → Fin 6 → ℝ) :
    star6 (S + T) = star6 S + star6 T := by
  ext a b
  simp only [Matrix.add_apply, star6_apply, Pi.add_apply, mul_add, Finset.sum_add_distrib]

/-- **A metric-compatible complex structure**: skew and squaring to `-1`, which together are
orthogonality and `J² = -Id`. -/
def IsComplexStructure (J : Matrix (Fin 6) (Fin 6) ℝ) : Prop := IsSkew J ∧ J * J = -1

/-- **A complex structure is orthogonal**, which is the half of the record's *"`ωᵢ/√c` is both
orthogonal and skew"* that the definition does not state outright. -/
theorem IsComplexStructure.orthogonal {J : Matrix (Fin 6) (Fin 6) ℝ} (h : IsComplexStructure J) :
    J * Jᵀ = 1 := by
  obtain ⟨h1, h2⟩ := h
  unfold IsSkew at h1
  rw [h1, Matrix.mul_neg, h2, neg_neg]

/-- **A complex structure on `ℝ⁶` has `Λ²` norm squared `3`**, so the record's unit form is `J/√3`
and its square is `-⅓Id₆`, *"unit norm forces `c = ⅓`, so `ωᵢ² = -⅓Id₆` and `c` is not a free
parameter"*. -/
theorem inner2_complexStructure {J : Matrix (Fin 6) (Fin 6) ℝ} (h : IsComplexStructure J) :
    inner2 J J = 3 := by
  obtain ⟨h1, h2⟩ := h
  unfold IsSkew at h1
  unfold inner2
  rw [h1, Matrix.neg_mul, h2, neg_neg, Matrix.trace_one]
  norm_num

/-- **A complex structure on `ℝ⁶`**, the record's `J = ε₁ + ε₂ + ε₃` in a `J`-adapted frame. -/
def stdJ6 : Matrix (Fin 6) (Fin 6) ℝ := phi 0 1 + phi 2 3 + phi 4 5

/-- **The hypotheses of `StarWedgeIdentity` and `pm_of_eq_wedgeSelf` are not empty**, `stdJ6`
satisfying them. *Without this the predicate below would be vacuously satisfiable and the
conditional lemma would say nothing.* -/
theorem stdJ6_isComplexStructure : IsComplexStructure stdJ6 := by
  have hp : ∀ i j a b : Fin 6, phi i j a b
      = (if j = a then (if i = b then (1 : ℝ) else 0) else 0)
        - (if i = a then (if j = b then (1 : ℝ) else 0) else 0) := by
    intro i j a b
    simp only [phi, Matrix.sub_apply, Matrix.single_apply, ite_and]
  refine ⟨?_, ?_⟩
  · have hadd : ∀ X Y : Matrix (Fin 6) (Fin 6) ℝ, IsSkew X → IsSkew Y → IsSkew (X + Y) := by
      intro X Y hX hY; unfold IsSkew at *; rw [Matrix.transpose_add, hX, hY]; abel
    exact hadd _ _ (hadd _ _ (phi_isSkew 0 1) (phi_isSkew 2 3)) (phi_isSkew 4 5)
  · ext a b
    simp only [stdJ6, Matrix.mul_apply, Matrix.add_apply, Fin.sum_univ_six, hp, Matrix.neg_apply,
      Matrix.one_apply]
    fin_cases a <;> fin_cases b <;> simp

/-- **`(det J)² = 1` at every complex structure**, which is all that taking determinants in
`J² = -I` gives. *Both signs survive it, and `det_eq_one_of_complexStructure` below pins the sign.* -/
theorem det_sq_eq_one_of_complexStructure {J : Matrix (Fin 6) (Fin 6) ℝ}
    (h : IsComplexStructure J) : (J.det) ^ 2 = 1 := by
  have h2 : J * J = -1 := h.2
  have := congrArg Matrix.det h2
  rw [Matrix.det_mul] at this
  simp only [Matrix.det_neg, Matrix.det_one, Fintype.card_fin] at this
  rw [sq]
  norm_num at this ⊢
  exact this

/-- **`det J = 1` at every complex structure.**

**THE PROOF IS THREE LINES AND IT IS NOT THE OBVIOUS ONE.** *Taking determinants in `J² = -I` gives
`(det J)² = 1`, proved above, and both signs survive it. Pinning the sign by `det J = Pf(J)² ≥ 0`
ASSUMES the identity `Pf(X)² = det X` that this lemma exists to feed, so that route proves nothing.*

**The argument that works uses only that `J` is REAL.** *The minimal polynomial divides `x² + 1`,
which splits over `ℂ` with DISTINCT roots, so `J` is diagonalisable over `ℂ` with every eigenvalue
in `{i, -i}`. Complex conjugation carries the `i`-eigenspace onto the `-i`-eigenspace and back, so
the two have equal dimension `n`, and `det J = iⁿ(-i)ⁿ = 1`.* **It needs no skewness and no
orthogonality**, so it holds well beyond `IsComplexStructure`.

*The first version's `sorry`, the passage to `ℂ`, is gone: the skew route below never leaves `ℝ`.*
Recorded in [diagonal-half.md](../../../findings/diagonal-half.md). -/
theorem det_eq_one_of_complexStructure {J : Matrix (Fin 6) (Fin 6) ℝ}
    (h : IsComplexStructure J) : J.det = 1 := by
  obtain ⟨hskew, hsq⟩ := h
  have hT : Jᵀ = -J := hskew
  -- `det (1 + J) = det (1 - J)`, because transposing swaps them and `det Mᵀ = det M`.
  have hswap : (1 + J).det = (1 - J).det := by
    -- `ring_nf` cannot act: matrices are not a COMMUTATIVE ring, and the tactic says so.
    rw [← Matrix.det_transpose (1 + J), Matrix.transpose_add, Matrix.transpose_one, hT,
      ← sub_eq_add_neg]
  -- `(1 + J)(1 - J) = 1 - J² = 2`, so neither factor can vanish.
  have hprod : (1 + J) * (1 - J) = (2 : ℝ) • (1 : Matrix (Fin 6) (Fin 6) ℝ) := by
    rw [Matrix.add_mul, Matrix.mul_sub, Matrix.mul_sub, Matrix.one_mul, Matrix.mul_one,
      Matrix.one_mul, hsq]
    ext p q; simp [Matrix.smul_apply, Matrix.one_apply]; split_ifs <;> ring
  have hne : (1 + J).det ≠ 0 := by
    intro h0
    have := congrArg Matrix.det hprod
    rw [Matrix.det_mul, h0, zero_mul] at this
    simp [Matrix.det_smul] at this
    norm_num at this
  -- `J(1 + J) = J + J² = -(1 - J)`, and the sign cancels in even dimension.
  have hkey : J * (1 + J) = -(1 - J) := by
    rw [Matrix.mul_add, Matrix.mul_one, hsq]; ext p q; simp; ring
  have := congrArg Matrix.det hkey
  rw [Matrix.det_mul, Matrix.det_neg, ← hswap] at this
  simp only [Fintype.card_fin] at this
  norm_num at this
  exact mul_right_cancel₀ hne (by linarith [this])

/-- **THE STAR-WEDGE IDENTITY.** *`⋆_V(J ∧ J) = 2 ε_J J` with `ε_J = ±1` according to
whether `J`'s orientation agrees with the fixed one.*

**It is proved**, as `starWedgeIdentity_holds` in [I67PfSign.lean](../Results/I67PfSign.lean), with `ε_J = Pf(J)`. -/
def StarWedgeIdentity : Prop :=
  ∀ J : Matrix (Fin 6) (Fin 6) ℝ, IsComplexStructure J →
    ∃ eps : ℝ, (eps = 1 ∨ eps = -1) ∧ star6 (wedgeSelf J) = (2 * eps) • J

/-- **What L184's case 2 gets from the star-wedge identity, and from nothing else.** Two complex
structures on `ℝ⁶` with equal self-wedges differ by a sign.

*The record's own reading: `ω₂ = ±ω₁` follows "from the identity `⋆_V(J ∧ J) = 2 ε_J J` alone,
not from `⋆` being injective, which the block cites and never uses, since applying any linear map
to an equality suffices".* **Stated conditionally on `StarWedgeIdentity`, which `starWedgeIdentity_holds` proves.** -/
theorem pm_of_eq_wedgeSelf (h : StarWedgeIdentity) {J K : Matrix (Fin 6) (Fin 6) ℝ}
    (hJ : IsComplexStructure J) (hK : IsComplexStructure K)
    (hw : wedgeSelf J = wedgeSelf K) : J = K ∨ J = -K := by
  have cancel : ∀ (c : ℝ) (A B : Matrix (Fin 6) (Fin 6) ℝ), c ≠ 0 → c • A = c • B → A = B := by
    intro c A B hc hAB
    have h2 := congrArg (fun M : Matrix (Fin 6) (Fin 6) ℝ => c⁻¹ • M) hAB
    simpa [smul_smul, inv_mul_cancel₀ hc] using h2
  obtain ⟨e1, he1, hJ'⟩ := h J hJ
  obtain ⟨e2, he2, hK'⟩ := h K hK
  have hEq : (2 * e1) • J = (2 * e2) • K := by rw [← hJ', ← hK', hw]
  rcases he1 with rfl | rfl <;> rcases he2 with rfl | rfl
  · left
    exact cancel 2 J K (by norm_num) (by simpa using hEq)
  · right
    refine cancel 2 J (-K) (by norm_num) ?_
    have : (2 : ℝ) • J = (2 * (-1) : ℝ) • K := by simpa using hEq
    rw [this]
    module
  · right
    refine cancel 2 J (-K) (by norm_num) ?_
    have : (2 * (-1) : ℝ) • J = (2 : ℝ) • K := by simpa using hEq
    have h3 : (2 : ℝ) • J = (2 * (-1) : ℝ) • K := by
      linear_combination (norm := module) -this
    rw [h3]
    module
  · left
    refine cancel 2 J K (by norm_num) ?_
    have : (2 * (-1) : ℝ) • J = (2 * (-1) : ℝ) • K := hEq
    exact cancel (2 * (-1)) J K (by norm_num) this ▸ rfl

end

/-! ## The star is an involution on bivectors, and `Λ⁺` is three-dimensional

**This is the step [lean/INDEX.md](../../../lean/INDEX.md) recorded as owed**: `sdForm` exhibits
three orthonormal self-dual forms, and `selfDual_expand` shows they SPAN, so `dim Λ⁺ℝ⁴ = 3`, which
is what [L178](../Results/L178Statement.lean)'s step 1 needs to call `W^±` trace-free on a
three-dimensional space.
-/

theorem star4_star4 (X : Matrix (Fin 4) (Fin 4) ℝ) (hX : IsSkew X) :
    star4 (star4 X) = X := by
  have hs : ∀ p q : Fin 4, X q p = - X p q := by
    intro p q
    have := congrFun (congrFun hX p) q
    simpa [Matrix.transpose_apply] using this
  have d0 : X 0 0 = 0 := by have := hs 0 0; linarith
  have d1 : X 1 1 = 0 := by have := hs 1 1; linarith
  have d2 : X 2 2 = 0 := by have := hs 2 2; linarith
  have d3 : X 3 3 = 0 := by have := hs 3 3; linarith
  ext a b
  simp only [star4_apply]
  fin_cases a <;> fin_cases b <;>
    simp [Fin.sum_univ_four, levi4, sgnR, hs 0 1, hs 0 2, hs 0 3, hs 1 2, hs 1 3, hs 2 3,
      d0, d1, d2, d3] <;> ring

theorem selfDual_expand (X : Matrix (Fin 4) (Fin 4) ℝ) (hX : IsSkew X) (hd : IsSelfDual X) :
    X = (-X 0 1) • sdForm 0 + (-X 0 2) • sdForm 1 + (-X 0 3) • sdForm 2 := by
  have hs : ∀ p q : Fin 4, X q p = - X p q := by
    intro p q
    have := congrFun (congrFun hX p) q
    simpa [Matrix.transpose_apply] using this
  have d0 : X 0 0 = 0 := by have := hs 0 0; linarith
  have d1 : X 1 1 = 0 := by have := hs 1 1; linarith
  have d2 : X 2 2 = 0 := by have := hs 2 2; linarith
  have d3 : X 3 3 = 0 := by have := hs 3 3; linarith
  have he : ∀ a b : Fin 4, star4 X a b = X a b := fun a b => congrFun (congrFun hd a) b
  have h01 := he 0 1
  have h02 := he 0 2
  have h03 := he 0 3
  simp [star4_apply, Fin.sum_univ_four, levi4, sgnR, hs 0 1, hs 0 2, hs 0 3, hs 1 2, hs 1 3,
    hs 2 3, d0, d1, d2, d3] at h01 h02 h03
  ext a b
  fin_cases a <;> fin_cases b <;>
    simp [sdForm, phi, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply,
      hs 0 1, hs 0 2, hs 0 3, hs 1 2, hs 1 3, hs 2 3, d0, d1, d2, d3] <;> linarith

/-- **The three exhibited forms are linearly independent**, read off the same three entries the
spanning is read off. *With `selfDual_expand` this gives `Λ²₊` a three-element basis.* -/
theorem sdCombo_independent (x y z : ℝ)
    (h : x • sdForm 0 + y • sdForm 1 + z • sdForm 2 = 0) : x = 0 ∧ y = 0 ∧ z = 0 := by
  refine ⟨?_, ?_, ?_⟩
  · have := congrFun (congrFun h 0) 1
    simpa [sdForm, phi, Matrix.single_apply, Matrix.add_apply, Matrix.sub_apply,
      Matrix.smul_apply] using this
  · have := congrFun (congrFun h 0) 2
    simpa [sdForm, phi, Matrix.single_apply, Matrix.add_apply, Matrix.sub_apply,
      Matrix.smul_apply] using this
  · have := congrFun (congrFun h 0) 3
    simpa [sdForm, phi, Matrix.single_apply, Matrix.add_apply, Matrix.sub_apply,
      Matrix.smul_apply] using this

end HamiltonsCubic.SelfDualLayer
