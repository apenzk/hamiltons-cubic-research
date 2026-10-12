import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Base.SelfDual

/-!
# L181, stated over the real Weyl layer

**The record's statement**, from [diagonal-half.md](../../../findings/diagonal-half.md)'s
*Lemma L181, Ricci-flatness and first Bianchi are the two halves of one matrix, and together they
empty the simultaneously-block-diagonal family*:

> **Statement.** Fix an orthogonal decomposition `ℝⁿ = P₁ ⊕ … ⊕ P_m ⊕ P₀` with each `P_j` a plane,
> and let `ε_j` be the unit area-form of `P_j`. Call `W ∈ 𝒲ₙ` **simultaneously block-diagonal** for
> this splitting when every eigen-`2`-form with nonzero eigenvalue is a combination of the `ε_j`.
> **Then `W = 0`.**

The proof the record gives is the one typed here: orthonormality of the eigenforms is `M Mᵀ = I_r`;
Ricci-flatness is `diag(Mᵀ Λ M) = 0`; first Bianchi is `(Mᵀ Λ M)_{j≠k} = 0`; so `Mᵀ Λ M = 0`, and
`Λ = M (Mᵀ Λ M) Mᵀ = 0`.

**`W` is `rankSumOp lam om`, an operator on bivectors, and the Weyl hypothesis is
[WeylReal.lean](../Base/WeylReal.lean)'s `IsWeyl`**, so this is a statement about `𝒲ₙ` and not
about a local definition. The conclusion `∀ i, lam i = 0` is `W = 0` in the record's reading, where
the index set runs over the nonzero eigenvalues; `rankSumOp_eq_zero` states the operator form.

## The planes are built, and the predicate is now a theorem about them

The area forms `ε_j` enter through the predicate `IsPlaneFamily`, which records the seven
properties of a unit-area-form family that the proof consumes: skewness, `ε_j ε_kᵀ = δ_{jk} Π_j`
for the orthogonal projections `Π_j`, those projections being idempotent, orthogonal and nonzero,
`Λ²`-orthonormality of the `ε_j`, `ε_j ∧ ε_j = 0` (each plane's area form is decomposable), and
linear independence of the `ε_j ∧ ε_k` for `j ≠ k` in `Λ⁴`.

**`isPlaneFamily_planeEps` proves all seven** of an orthonormal system of planes: `IsPlaneSystem`
gives `m` planes by an orthonormal basis `u_j, v_j` of each, `planeEps` is
[SelfDual.lean](../Base/SelfDual.lean)'s `areaForm` of the `j`-th pair and `planePr` the
projection onto the `j`-th plane. *The `2m` vectors are not asked to span, so the record's
remainder `P₀` is the orthogonal complement of their span and needs nothing said about it.*
`isPlaneSystem_std` exhibits such a system on `ℝ^{2m}`, so the hypothesis of the main theorem is
inhabited and the theorem is not conditional on a family existing.

*The typed Bianchi step consumes the independence clause alone, stated for symmetric coefficient
matrices, it already tolerates the diagonal terms, so `ε_j ∧ ε_j = 0` is carried in the predicate
as a property of the objects and is not used.* *That clause is box (i) of
[L184](L184Statement.lean) in the record.*

The independence clause is proved by **evaluating the `4`-form on the four vectors
`u_p, v_p, u_q, v_q`**: `eval4` is that evaluation, linear in the form, and `eval4_wedge2` computes
it on a wedge of two area forms as a product of Gram entries. *That is the record's "the
`ε_j ∧ ε_k` are the distinct basis `4`-forms" carried out through a pairing rather than through a
choice of frame.*

## What is NOT typed here

`Λ⁴` is realised by components, as in [L179](L179Statement.lean): `wedge2 X Y` is the four-index
function `(X ∧ Y)_{abcd}`, and "`= 0` in `Λ⁴`" is "vanishes at every four indices"; `eval4` is a
functional on those components and not on an exterior-algebra object.

**Every `2`-form is block-diagonal for some splitting**, by the real skew normal form, the
record's remark on why no naming of a particular form can escape the lemma. That normal form is
not typed here, so the reach of the hypothesis is taken from the record.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L181

open HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m r : ℕ}

noncomputable section

/-! ## The wedge on components

*`halfw`, `wedge2` and `wedgeSelf` are [SelfDual.lean](../Base/SelfDual.lean)'s, so the convention
is the layer's and this file keeps no copy of it.* -/

theorem halfw_sum (u v : Fin m → ℝ) (E : Fin m → Matrix ι ι ℝ) :
    halfw (∑ j, u j • E j) (∑ k, v k • E k)
      = ∑ j, ∑ k, (u j * v k) • halfw (E j) (E k) := by
  funext a b c d
  simp only [halfw, Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, Finset.sum_apply,
             Pi.smul_apply, Finset.sum_mul_sum]
  simp only [← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
  ring

/-- **The self-wedge of a combination of the `ε_j`**, expanded on the pairs. -/
theorem wedgeSelf_sum (u : Fin m → ℝ) (E : Fin m → Matrix ι ι ℝ) :
    wedgeSelf (∑ j, u j • E j) = ∑ j, ∑ k, (u j * u k) • wedge2 (E j) (E k) := by
  have h1 : wedgeSelf (∑ j, u j • E j) = (2 : ℝ) • ∑ j, ∑ k, (u j * u k) • halfw (E j) (E k) := by
    unfold wedgeSelf wedge2
    rw [halfw_sum, two_smul]
  rw [h1]
  unfold wedge2
  have h2 : ∑ j, ∑ k, (u j * u k) • halfw (E k) (E j)
      = ∑ j, ∑ k, (u j * u k) • halfw (E j) (E k) := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => by rw [mul_comm]
  simp only [smul_add, Finset.sum_add_distrib, h2, two_smul]

/-! ## The spectral operator and its bridge to `IsWeyl` -/

/-- `Σᵢ λᵢ ωᵢ ⊗ ωᵢ` as an operator on bivectors. -/
def rankSumOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) :
    Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => ∑ i, (lam i * inner2 (om i) X) • om i

theorem inner2_phi (X : Matrix ι ι ℝ) (a c : ι) :
    inner2 X (phi a c) = (1 / 2) * (X c a - X a c) := by
  unfold inner2 phi
  simp [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
        Matrix.sub_apply, Matrix.single_apply, mul_sub, Finset.sum_sub_distrib,
        ite_and, mul_ite, Finset.sum_ite_eq]

theorem inner2_phi_skew {X : Matrix ι ι ℝ} (h : Xᵀ = -X) (a c : ι) :
    inner2 X (phi a c) = -X a c := by
  have hx : X c a = -X a c := by
    have := congrFun (congrFun h a) c
    simpa [Matrix.transpose_apply] using this
  rw [inner2_phi, hx]; ring

theorem inner2_comm (X Y : Matrix ι ι ℝ) : inner2 X Y = inner2 Y X := by
  unfold inner2
  rw [show (Xᵀ * Y).trace = ((Xᵀ * Y)ᵀ).trace from (Matrix.trace_transpose _).symm]
  simp [Matrix.transpose_mul]

theorem inner2_sum_smul {κ : Type*} [Fintype κ] (c : κ → ℝ) (M : κ → Matrix ι ι ℝ)
    (Y : Matrix ι ι ℝ) : inner2 (∑ i, c i • M i) Y = ∑ i, c i * inner2 (M i) Y := by
  simp [inner2, Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]
  ring_nf

/-- The `Λ²` pairing of two combinations of an orthonormal family is the dot product of their
coefficients. -/
theorem inner2_bilin (u v : Fin m → ℝ) (E : Fin m → Matrix ι ι ℝ)
    (hE : ∀ j k, inner2 (E j) (E k) = if j = k then 1 else 0) :
    inner2 (∑ j, u j • E j) (∑ k, v k • E k) = ∑ j, u j * v j := by
  rw [inner2_sum_smul]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [inner2_comm, inner2_sum_smul]
  simp only [hE, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]

/-- **The Ricci bridge**: the layer's `Ric` of `Σᵢ λᵢ ωᵢ ⊗ ωᵢ` is the entry of `Σᵢ λᵢ ωᵢ ωᵢᵀ`. -/
theorem Ric_rankSumOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i) (a b : ι) :
    Ric (rankSumOp lam om) a b = (∑ i, lam i • (om i * (om i)ᵀ)) a b := by
  have step : ∀ c : ι, inner2 (rankSumOp lam om (phi a c)) (phi b c)
      = ∑ i, lam i * (om i a c * om i b c) := by
    intro c
    unfold rankSumOp
    rw [inner2_sum_smul]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [inner2_phi_skew (hskew i), inner2_phi_skew (hskew i)]
    ring
  unfold Ric
  simp only [step]
  rw [Finset.sum_comm]
  simp [Matrix.sum_apply, Matrix.mul_apply, Matrix.transpose_apply, Finset.mul_sum]

/-- **The Bianchi bridge**: the layer's `bianchi` of `Σᵢ λᵢ ωᵢ ⊗ ωᵢ` is `½ Σᵢ λᵢ (ωᵢ ∧ ωᵢ)`. -/
theorem bianchi_rankSumOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i) (a b c d : ι) :
    bianchi (rankSumOp lam om) a b c d
      = (1 / 2) * (∑ i, lam i • wedgeSelf (om i)) a b c d := by
  have key : ∀ p q s t : ι, inner2 (rankSumOp lam om (phi p q)) (phi s t)
      = ∑ i, lam i * (om i p q * om i s t) := by
    intro p q s t
    unfold rankSumOp
    rw [inner2_sum_smul]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [inner2_phi_skew (hskew i), inner2_phi_skew (hskew i)]
    ring
  have hswap : ∀ (i : Fin r) (p q : ι), om i q p = -om i p q := by
    intro i p q
    have := congrFun (congrFun (hskew i) p) q
    simpa [Matrix.transpose_apply] using this
  unfold bianchi
  rw [key, key, key, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  simp only [Finset.sum_apply, Pi.smul_apply, smul_eq_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  unfold wedgeSelf wedge2 halfw
  simp only [Pi.add_apply]
  rw [hswap i b d]
  ring

/-! ## The hypothesis package: the unit area forms of an orthogonal family of planes -/

/-- **What a family of unit area forms of pairwise-orthogonal planes supplies**, and nothing more:
the seven properties the proof of L181 consumes. `pr j` is the orthogonal projection onto `P_j`.

*`isPlaneFamily_planeEps` below proves all seven of the area forms of an orthonormal system of
planes, and `isPlaneSystem_std` exhibits such a system, so the predicate is inhabited.* -/
def IsPlaneFamily (eps pr : Fin m → Matrix ι ι ℝ) : Prop :=
  (∀ j, (eps j)ᵀ = -eps j) ∧
  (∀ j k, eps j * (eps k)ᵀ = if j = k then pr j else 0) ∧
  (∀ j k, pr j * pr k = if j = k then pr j else 0) ∧
  (∀ j, pr j ≠ 0) ∧
  (∀ j k, inner2 (eps j) (eps k) = if j = k then 1 else 0) ∧
  (∀ j, wedge2 (eps j) (eps j) = 0) ∧
  (∀ c : Fin m → Fin m → ℝ, (∀ j k, c j k = c k j) →
    (∑ j, ∑ k, c j k • wedge2 (eps j) (eps k)) = 0 → ∀ j k, j ≠ k → c j k = 0)

/-! ## Evaluating a form on vectors

*The `Λ²` and `Λ⁴` of this file are realised by components, so "linearly independent in `Λ⁴`" is
proved by evaluating the components on vectors. `eval2` and `eval4` are those evaluations, and
`eval4` is linear in the form so that it passes through the sums the clause is stated over.* -/

/-- **The value of a `2`-form on a pair of vectors**, `Σ_{ab} X_{ab} x_a y_b`. -/
def eval2 (X : Matrix ι ι ℝ) (x y : ι → ℝ) : ℝ := ∑ a, ∑ b, X a b * (x a * y b)

/-- **An area form's value is a `2 × 2` Gram determinant.** -/
theorem eval2_areaForm (u v x y : ι → ℝ) :
    eval2 (areaForm u v) x y = (v ⬝ᵥ x) * (u ⬝ᵥ y) - (u ⬝ᵥ x) * (v ⬝ᵥ y) := by
  unfold eval2
  have hb : ∀ a b : ι, areaForm u v a b * (x a * y b)
      = (v a * x a) * (u b * y b) - (u a * x a) * (v b * y b) := by
    intro a b; simp only [areaForm_apply]; ring
  simp only [hb, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.sum_mul]
  simp only [dotProduct]

/-- **The value of a `4`-form on four vectors**, as a linear map in the form. -/
def eval4 (x y z w : ι → ℝ) : (ι → ι → ι → ι → ℝ) →ₗ[ℝ] ℝ where
  toFun T := ∑ a, ∑ b, ∑ c, ∑ d, T a b c d * (x a * y b * z c * w d)
  map_add' := by
    intro T S
    simp only [Pi.add_apply, add_mul, Finset.sum_add_distrib]
  map_smul' := by
    intro r T
    simp only [Pi.smul_apply, smul_eq_mul, RingHom.id_apply, Finset.mul_sum, mul_assoc]

theorem eval4_apply (T : ι → ι → ι → ι → ℝ) (x y z w : ι → ℝ) :
    eval4 x y z w T = ∑ a, ∑ b, ∑ c, ∑ d, T a b c d * (x a * y b * z c * w d) := rfl

theorem sum4_ab_cd (F G : ι → ι → ℝ) :
    (∑ a, ∑ b, ∑ c, ∑ d, F a b * G c d) = (∑ a, ∑ b, F a b) * (∑ c, ∑ d, G c d) := by
  simp only [← Finset.mul_sum, ← Finset.sum_mul]

theorem sum4_ac_bd (F G : ι → ι → ℝ) :
    (∑ a, ∑ b, ∑ c, ∑ d, F a c * G b d) = (∑ a, ∑ c, F a c) * (∑ b, ∑ d, G b d) := by
  have h : ∀ a : ι, (∑ b, ∑ c, ∑ d, F a c * G b d) = ∑ c, F a c * (∑ b, ∑ d, G b d) := by
    intro a
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun b _ => by rw [Finset.mul_sum]
  simp only [h, ← Finset.sum_mul]

theorem sum4_ad_bc (F G : ι → ι → ℝ) :
    (∑ a, ∑ b, ∑ c, ∑ d, F a d * G b c) = (∑ a, ∑ d, F a d) * (∑ b, ∑ c, G b c) := by
  simp only [← Finset.sum_mul, ← Finset.mul_sum]

/-- **Half of a wedge, evaluated**: the three pair-splittings become three products of `2`-form
values. -/
theorem eval4_halfw (X Y : Matrix ι ι ℝ) (x y z w : ι → ℝ) :
    eval4 x y z w (halfw X Y)
      = eval2 X x y * eval2 Y z w - eval2 X x z * eval2 Y y w + eval2 X x w * eval2 Y y z := by
  rw [eval4_apply]
  have hsplit : ∀ a b c d : ι, halfw X Y a b c d * (x a * y b * z c * w d)
      = (X a b * (x a * y b)) * (Y c d * (z c * w d))
        - (X a c * (x a * z c)) * (Y b d * (y b * w d))
        + (X a d * (x a * w d)) * (Y b c * (y b * z c)) := by
    intro a b c d; simp only [halfw]; ring
  simp only [hsplit, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  rw [sum4_ab_cd (fun a b => X a b * (x a * y b)) (fun c d => Y c d * (z c * w d)),
      sum4_ac_bd (fun a c => X a c * (x a * z c)) (fun b d => Y b d * (y b * w d)),
      sum4_ad_bc (fun a d => X a d * (x a * w d)) (fun b c => Y b c * (y b * z c))]
  rfl

/-- **`(X ∧ Y)` evaluated on four vectors**, which is what the independence clause is read on. -/
theorem eval4_wedge2 (X Y : Matrix ι ι ℝ) (x y z w : ι → ℝ) :
    eval4 x y z w (wedge2 X Y)
      = (eval2 X x y * eval2 Y z w - eval2 X x z * eval2 Y y w + eval2 X x w * eval2 Y y z)
        + (eval2 Y x y * eval2 X z w - eval2 Y x z * eval2 X y w + eval2 Y x w * eval2 X y z) := by
  show eval4 x y z w (halfw X Y + halfw Y X) = _
  rw [map_add, eval4_halfw, eval4_halfw]

/-! ## The planes, and the family their area forms make -/

/-- **`m` pairwise orthogonal planes of `ℝⁿ`**, each named by an orthonormal basis. *The `2m`
vectors are not asked to span, so their orthogonal complement is the record's remainder `P₀`.* -/
def IsPlaneSystem (u v : Fin m → ι → ℝ) : Prop :=
  (∀ j k, u j ⬝ᵥ u k = if j = k then 1 else 0) ∧
  (∀ j k, v j ⬝ᵥ v k = if j = k then 1 else 0) ∧
  (∀ j k, u j ⬝ᵥ v k = 0)

/-- **`ε_j`, the unit area form of the `j`-th plane.** -/
def planeEps (u v : Fin m → ι → ℝ) (j : Fin m) : Matrix ι ι ℝ := areaForm (u j) (v j)

/-- **`Π_j`, the orthogonal projection onto the `j`-th plane.** -/
def planePr (u v : Fin m → ι → ℝ) (j : Fin m) : Matrix ι ι ℝ :=
  Matrix.of fun a b => u j a * u j b + v j a * v j b

/-- **THE FAMILY IS CONSTRUCTED.** The area forms of an orthogonal system of planes satisfy all
seven clauses of `IsPlaneFamily`. **Proved**, so the main theorem below is a statement about
planes and not about a predicate.

*Six clauses are [SelfDual.lean](../Base/SelfDual.lean)'s area-form lemmas read at an orthonormal
pair. The seventh (independence of the `ε_j ∧ ε_k` in `Λ⁴`), is the evaluation of the vanishing
combination on `u_p, v_p, u_q, v_q`, where every term but `c_{pq}` and `c_{qp}` drops out.* -/
theorem isPlaneFamily_planeEps (u v : Fin m → ι → ℝ) (h : IsPlaneSystem u v) :
    IsPlaneFamily (planeEps u v) (planePr u v) := by
  obtain ⟨hu, hv, huv⟩ := h
  have hvu : ∀ j k, v j ⬝ᵥ u k = 0 := by
    intro j k; rw [dotProduct_comm]; exact huv k j
  have huu1 : ∀ j, u j ⬝ᵥ u j = 1 := by intro j; simpa using hu j j
  have hvv1 : ∀ j, v j ⬝ᵥ v j = 1 := by intro j; simpa using hv j j
  refine ⟨fun j => areaForm_isSkew (u j) (v j), ?_, ?_, ?_, ?_, ?_, ?_⟩
  · -- `εⱼ εₖᵀ = δ_{jk} Πⱼ`
    intro j k
    by_cases hjk : j = k
    · subst hjk
      rw [if_pos rfl]
      exact areaForm_mul_transpose_of_orthonormal (u j) (v j) (huu1 j) (hvv1 j) (huv j j)
    · rw [if_neg hjk]
      have hskew := areaForm_isSkew (u k) (v k)
      unfold IsSkew at hskew
      unfold planeEps
      rw [hskew, Matrix.mul_neg,
        areaForm_mul_eq_zero (u j) (v j) (u k) (v k) (by simp [hu, hjk]) (huv j k) (hvu j k)
          (by simp [hv, hjk]), neg_zero]
  · -- the projections are idempotent and mutually annihilating
    intro j k
    ext a b
    have hc : ∀ c : ι, planePr u v j a c * planePr u v k c b
        = (u j a * u k b) * (u j c * u k c) + (u j a * v k b) * (u j c * v k c)
          + (v j a * u k b) * (v j c * u k c) + (v j a * v k b) * (v j c * v k c) := by
      intro c; simp only [planePr, Matrix.of_apply]; ring
    simp only [Matrix.mul_apply, hc, Finset.sum_add_distrib, ← Finset.mul_sum]
    have e1 : ∑ c, u j c * u k c = u j ⬝ᵥ u k := rfl
    have e2 : ∑ c, u j c * v k c = u j ⬝ᵥ v k := rfl
    have e3 : ∑ c, v j c * u k c = v j ⬝ᵥ u k := rfl
    have e4 : ∑ c, v j c * v k c = v j ⬝ᵥ v k := rfl
    rw [e1, e2, e3, e4, hu j k, hv j k, huv j k, hvu j k]
    by_cases hjk : j = k
    · subst hjk; simp [planePr]
    · simp [hjk]
  · -- the projections are nonzero, their trace being `2`
    intro j hj
    have htr : (planePr u v j).trace = 2 := by
      simp only [Matrix.trace, Matrix.diag, planePr, Matrix.of_apply, Finset.sum_add_distrib]
      rw [show ∑ a, u j a * u j a = u j ⬝ᵥ u j from rfl,
          show ∑ a, v j a * v j a = v j ⬝ᵥ v j from rfl, huu1 j, hvv1 j]
      norm_num
    rw [hj] at htr
    simp at htr
  · -- `Λ²`-orthonormality
    intro j k
    unfold planeEps
    rw [inner2_areaForm, hu j k, hv j k, huv j k, hvu j k]
    by_cases hjk : j = k
    · subst hjk; simp
    · simp [hjk]
  · -- each plane's area form is decomposable
    intro j
    exact wedgeSelf_areaForm (u j) (v j)
  · -- the `εⱼ ∧ εₖ` are linearly independent in `Λ⁴`
    intro c hsymm hzero p q hpq
    have heval : ∀ j k : Fin m,
        eval4 (u p) (v p) (u q) (v q) (wedge2 (planeEps u v j) (planeEps u v k))
          = (if j = p then (1:ℝ) else 0) * (if k = q then (1:ℝ) else 0)
            + (if k = p then (1:ℝ) else 0) * (if j = q then (1:ℝ) else 0) := by
      intro j k
      rw [eval4_wedge2]
      unfold planeEps
      simp only [eval2_areaForm, hu, hv, huv, hvu]
      by_cases h1 : j = p <;> by_cases h2 : k = q <;> by_cases h3 : k = p <;> by_cases h4 : j = q <;>
        simp [h1, h2, h3, h4, hpq, hpq.symm]
    have key := congrArg (eval4 (u p) (v p) (u q) (v q)) hzero
    simp only [map_sum, map_smul, smul_eq_mul, map_zero] at key
    have hval : ∀ j k : Fin m,
        c j k * eval4 (u p) (v p) (u q) (v q) (wedge2 (planeEps u v j) (planeEps u v k))
          = (if k = q then (if j = p then c j k else 0) else 0)
            + (if k = p then (if j = q then c j k else 0) else 0) := by
      intro j k
      rw [heval j k]
      by_cases h1 : j = p <;> by_cases h2 : k = q <;> by_cases h3 : k = p <;> by_cases h4 : j = q <;>
        simp [h1, h2, h3, h4, hpq, hpq.symm]
    rw [Finset.sum_congr rfl (fun j _ => Finset.sum_congr rfl (fun k _ => hval j k))] at key
    simp only [Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true] at key
    rw [hsymm q p] at key
    linarith

theorem dot_single {κ : Type*} [Fintype κ] [DecidableEq κ] (i j : κ) :
    (Pi.single i (1:ℝ)) ⬝ᵥ (Pi.single j (1:ℝ)) = if i = j then 1 else 0 := by
  by_cases h : i = j
  · subst h; simp [dotProduct, Pi.single_apply]
  · simp [dotProduct, Pi.single_apply, h, Ne.symm h]

/-- **A system of `m` planes exists**, the coordinate planes of `ℝ^{2m}`, so `IsPlaneFamily` is
inhabited and the main theorem below has content. -/
theorem isPlaneSystem_std (m : ℕ) :
    IsPlaneSystem (ι := Fin m × Fin 2)
      (fun j => Pi.single (j, 0) (1:ℝ)) (fun j => Pi.single (j, 1) (1:ℝ)) := by
  refine ⟨?_, ?_, ?_⟩ <;> intro j k <;> rw [dot_single] <;> simp [Prod.ext_iff]

/-! ## The two halves of `Mᵀ Λ M` -/

/-- The entries of `Mᵀ Λ M`, written out. -/
theorem tLM (lam : Fin r → ℝ) (M : Matrix (Fin r) (Fin m) ℝ) (j k : Fin m) :
    (Mᵀ * Matrix.diagonal lam * M) j k = ∑ i, lam i * (M i j * M i k) := by
  simp [Matrix.mul_apply, Matrix.diagonal_apply, Matrix.transpose_apply]
  exact Finset.sum_congr rfl fun i _ => by ring

theorem tLM_symm (lam : Fin r → ℝ) (M : Matrix (Fin r) (Fin m) ℝ) (j k : Fin m) :
    (Mᵀ * Matrix.diagonal lam * M) j k = (Mᵀ * Matrix.diagonal lam * M) k j := by
  rw [tLM, tLM]
  exact Finset.sum_congr rfl fun i _ => by ring

theorem blockSq (M : Matrix (Fin r) (Fin m) ℝ) (eps pr : Fin m → Matrix ι ι ℝ)
    (hmul : ∀ j k, eps j * (eps k)ᵀ = if j = k then pr j else 0) (i : Fin r) :
    (∑ j, M i j • eps j) * (∑ j, M i j • eps j)ᵀ = ∑ j, (M i j * M i j) • pr j := by
  rw [Matrix.transpose_sum]
  simp only [Matrix.transpose_smul, Finset.sum_mul, Matrix.mul_sum, Matrix.smul_mul,
             Matrix.mul_smul, hmul, smul_ite, smul_zero]
  rw [Finset.sum_congr rfl (fun j _ => Finset.sum_ite_eq _ j _)]
  simp [mul_smul]

theorem gatherDiag (lam : Fin r → ℝ) (M : Matrix (Fin r) (Fin m) ℝ) (pr : Fin m → Matrix ι ι ℝ) :
    ∑ i, lam i • (∑ j, (M i j * M i j) • pr j)
      = ∑ j, ((Mᵀ * Matrix.diagonal lam * M) j j) • pr j := by
  simp only [Finset.smul_sum, smul_smul]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.sum_smul, tLM]

theorem gatherWedge (lam : Fin r → ℝ) (M : Matrix (Fin r) (Fin m) ℝ)
    (eps : Fin m → Matrix ι ι ℝ) :
    ∑ i, lam i • (∑ j, ∑ k, (M i j * M i k) • wedge2 (eps j) (eps k))
      = ∑ j, ∑ k, ((Mᵀ * Matrix.diagonal lam * M) j k) • wedge2 (eps j) (eps k) := by
  simp only [Finset.smul_sum, smul_smul]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [← Finset.sum_smul, tLM]

/-- **Ricci-flatness is the diagonal of `Mᵀ Λ M`.** -/
theorem ricci_diag (lam : Fin r → ℝ) (M : Matrix (Fin r) (Fin m) ℝ)
    (eps pr : Fin m → Matrix ι ι ℝ)
    (hmul : ∀ j k, eps j * (eps k)ᵀ = if j = k then pr j else 0)
    (hpr : ∀ j k, pr j * pr k = if j = k then pr j else 0) (hne : ∀ j, pr j ≠ 0)
    (hR : (∑ i, lam i • ((∑ j, M i j • eps j) * (∑ j, M i j • eps j)ᵀ)) = 0) (k : Fin m) :
    (Mᵀ * Matrix.diagonal lam * M) k k = 0 := by
  simp only [blockSq M eps pr hmul] at hR
  rw [gatherDiag] at hR
  have := congrArg (fun X : Matrix ι ι ℝ => X * pr k) hR
  simp only [Finset.sum_mul, Matrix.smul_mul, hpr, smul_ite, smul_zero, Matrix.zero_mul] at this
  rw [Finset.sum_ite_eq' _ k _] at this
  simp only [Finset.mem_univ, if_true] at this
  rcases smul_eq_zero.mp this with h | h
  · exact h
  · exact absurd h (hne k)

/-- **First Bianchi is the off-diagonal of `Mᵀ Λ M`.** -/
theorem bianchi_offdiag (lam : Fin r → ℝ) (M : Matrix (Fin r) (Fin m) ℝ)
    (eps : Fin m → Matrix ι ι ℝ)
    (_hself : ∀ j, wedge2 (eps j) (eps j) = 0)
    (hindep : ∀ c : Fin m → Fin m → ℝ, (∀ j k, c j k = c k j) →
      (∑ j, ∑ k, c j k • wedge2 (eps j) (eps k)) = 0 → ∀ j k, j ≠ k → c j k = 0)
    (hB : (∑ i, lam i • wedgeSelf (∑ j, M i j • eps j)) = 0) (j k : Fin m) (hjk : j ≠ k) :
    (Mᵀ * Matrix.diagonal lam * M) j k = 0 := by
  simp only [wedgeSelf_sum] at hB
  rw [gatherWedge] at hB
  exact hindep _ (tLM_symm lam M) hB j k hjk

/-! ## The core: an isometric congruence cannot kill a nonzero diagonal -/

/-- **`Λ = M (Mᵀ Λ M) Mᵀ`**, so `Mᵀ Λ M = 0` with `M Mᵀ = I` forces `Λ = 0`. This is the whole of
the record's last step, and it needs no dimension, spectrum or inequality. -/
theorem lam_eq_zero_of_congr (lam : Fin r → ℝ) (M : Matrix (Fin r) (Fin m) ℝ)
    (hMM : M * Mᵀ = 1) (hN : Mᵀ * Matrix.diagonal lam * M = 0) : ∀ i, lam i = 0 := by
  have key : Matrix.diagonal lam = M * (Mᵀ * Matrix.diagonal lam * M) * Mᵀ := by
    have e : M * (Mᵀ * Matrix.diagonal lam * M) * Mᵀ
        = (M * Mᵀ) * Matrix.diagonal lam * (M * Mᵀ) := by
      simp only [Matrix.mul_assoc]
    rw [e, hMM, Matrix.one_mul, Matrix.mul_one]
  rw [hN] at key
  simp only [Matrix.mul_zero, Matrix.zero_mul] at key
  intro i
  have := congrFun (congrFun key i) i
  simpa [Matrix.diagonal_apply] using this

/-! ## The lemma -/

/-- **L181.** A `W ∈ 𝒲ₙ` simultaneously block-diagonal for an orthogonal family of planes is zero.

`om i = Σ_j M i j • eps j` is the block-diagonality hypothesis, every eigenform with nonzero
eigenvalue is a combination of the area forms, and `hon` is orthonormality of the eigenforms, so
`lam` is the nonzero spectrum. The conclusion `∀ i, lam i = 0` contradicts `lam i ≠ 0` at every
`i`, which is the record's `W = 0`.

**Proved**, from `IsPlaneFamily`. *Ricci-flatness and first Bianchi are taken from `IsWeyl`; the
self-adjointness clause of `IsWeyl` is not used, which matches the record's proof.* -/
theorem block_diagonal_weyl_eq_zero
    (lam : Fin r → ℝ) (M : Matrix (Fin r) (Fin m) ℝ) (eps pr : Fin m → Matrix ι ι ℝ)
    (hfam : IsPlaneFamily eps pr)
    (om : Fin r → Matrix ι ι ℝ) (hom : ∀ i, om i = ∑ j, M i j • eps j)
    (hon : ∀ i i', inner2 (om i) (om i') = if i = i' then 1 else 0)
    (hW : IsWeyl (rankSumOp lam om)) : ∀ i, lam i = 0 := by
  obtain ⟨heskew, hmul, hpr, hne, hortho, hself, hindep⟩ := hfam
  -- every eigenform is skew, being a combination of skew area forms
  have hskew : ∀ i, (om i)ᵀ = -om i := by
    intro i
    rw [hom i, Matrix.transpose_sum]
    simp only [Matrix.transpose_smul, heskew, smul_neg, Finset.sum_neg_distrib]
  -- orthonormality of the eigenforms is `M Mᵀ = 1`
  have hMM : M * Mᵀ = 1 := by
    ext i i'
    have h1 : inner2 (om i) (om i') = ∑ j, M i j * M i' j := by
      rw [hom i, hom i', inner2_bilin _ _ _ hortho]
    rw [hon i i'] at h1
    simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply]
    rw [← h1]
  -- Ricci-flatness gives the diagonal
  have hRic : (∑ i, lam i • (om i * (om i)ᵀ)) = 0 := by
    ext a b
    rw [← Ric_rankSumOp lam om hskew a b, hW.2.2.2 a b]
    simp
  have hdiag : ∀ k, (Mᵀ * Matrix.diagonal lam * M) k k = 0 := by
    intro k
    refine ricci_diag lam M eps pr hmul hpr hne ?_ k
    simpa only [hom] using hRic
  -- first Bianchi gives the off-diagonal
  have hBia : (∑ i, lam i • wedgeSelf (om i)) = 0 := by
    funext a b c d
    have := bianchi_rankSumOp lam om hskew a b c d
    rw [hW.2.2.1 a b c d] at this
    simp only [Pi.zero_apply]
    linarith
  have hoff : ∀ j k, j ≠ k → (Mᵀ * Matrix.diagonal lam * M) j k = 0 := by
    intro j k hjk
    refine bianchi_offdiag lam M eps hself hindep ?_ j k hjk
    simpa only [hom] using hBia
  -- so the whole matrix vanishes, and with it `Λ`
  have hN : Mᵀ * Matrix.diagonal lam * M = 0 := by
    ext j k
    by_cases h : j = k
    · subst h; simpa using hdiag j
    · simpa using hoff j k h
  exact lam_eq_zero_of_congr lam M hMM hN

/-- **L181 IN THE RECORD'S OWN TERMS.** Fix `m` pairwise orthogonal planes of `ℝⁿ`, given by an
orthonormal basis `u_j, v_j` of each, and let `ε_j` be the unit area form of `P_j`. A `W ∈ 𝒲ₙ`
every one of whose eigenforms with nonzero eigenvalue is a combination of the `ε_j` is zero.

**Proved**, the seven properties of the `ε_j` coming from `isPlaneFamily_planeEps` rather than
from a hypothesis. *`isPlaneSystem_std` exhibits such a system, so this is not vacuous.* -/
theorem block_diagonal_weyl_eq_zero_planes
    (lam : Fin r → ℝ) (M : Matrix (Fin r) (Fin m) ℝ) (u v : Fin m → ι → ℝ)
    (hsys : IsPlaneSystem u v)
    (om : Fin r → Matrix ι ι ℝ) (hom : ∀ i, om i = ∑ j, M i j • planeEps u v j)
    (hon : ∀ i i', inner2 (om i) (om i') = if i = i' then 1 else 0)
    (hW : IsWeyl (rankSumOp lam om)) : ∀ i, lam i = 0 :=
  block_diagonal_weyl_eq_zero lam M (planeEps u v) (planePr u v)
    (isPlaneFamily_planeEps u v hsys) om hom hon hW

/-- **The `ωᵢ` really are eigenforms of `W` with eigenvalues `λᵢ`**, so `lam` is the spectrum the
record's statement speaks of. *This follows from orthonormality alone and is proved here so the
reading of the main theorem's conclusion is not left to the docstring.* -/
theorem rankSumOp_eigen (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hon : ∀ i i', inner2 (om i) (om i') = if i = i' then 1 else 0) (i' : Fin r) :
    rankSumOp lam om (om i') = lam i' • om i' := by
  unfold rankSumOp
  rw [Finset.sum_congr rfl (fun i _ => by rw [hon i i'])]
  simp only [mul_ite, mul_one, mul_zero, ite_smul, zero_smul]
  rw [Finset.sum_ite_eq' _ i' _]
  simp

/-- **`W = 0` as an operator**, which is the record's phrasing of the conclusion. -/
theorem rankSumOp_eq_zero
    (lam : Fin r → ℝ) (M : Matrix (Fin r) (Fin m) ℝ) (eps pr : Fin m → Matrix ι ι ℝ)
    (hfam : IsPlaneFamily eps pr)
    (om : Fin r → Matrix ι ι ℝ) (hom : ∀ i, om i = ∑ j, M i j • eps j)
    (hon : ∀ i i', inner2 (om i) (om i') = if i = i' then 1 else 0)
    (hW : IsWeyl (rankSumOp lam om)) : rankSumOp lam om = fun _ => 0 := by
  have h := block_diagonal_weyl_eq_zero lam M eps pr hfam om hom hon hW
  funext X
  unfold rankSumOp
  refine Finset.sum_eq_zero fun i _ => ?_
  rw [h i]
  simp

/-- **The family has content only at `r ≤ m`**, which `M Mᵀ = I_r` already forces, the record's
own count, and the reason `W_{ℂP²}` escapes the lemma at `n = 4`. -/
theorem rank_le_blocks (M : Matrix (Fin r) (Fin m) ℝ) (hMM : M * Mᵀ = 1) : r ≤ m := by
  have hinj : Function.Injective (Matrix.mulVecLin (Mᵀ) : (Fin r → ℝ) →ₗ[ℝ] (Fin m → ℝ)) := by
    intro x y hxy
    simp only [Matrix.mulVecLin_apply] at hxy
    have h2 : M *ᵥ (Mᵀ *ᵥ x) = M *ᵥ (Mᵀ *ᵥ y) := by rw [hxy]
    rwa [Matrix.mulVec_mulVec, Matrix.mulVec_mulVec, hMM, Matrix.one_mulVec,
         Matrix.one_mulVec] at h2
  have hle := LinearMap.finrank_le_finrank_of_injective hinj
  simpa using hle

end

end HamiltonsCubic.L181
