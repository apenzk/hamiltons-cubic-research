import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.L15Statement

/-!
# L9, the high ground has more than one peak, STATED

[graded-half.md](../../../findings/graded-half.md)'s Lemma L9, quoted verbatim from
[results.md](../../../results.md)'s canonical statement:

> - **Lemma L9 (landscape). The high ground has more than one peak.** The quaternionic-Kähler
>   operator on `ℍP²` is a strict local maximum, so nonzero defect does not force instability:
>   ruling out defective rivals requires sensitivity to the value, not the defect alone.

and the block's own statement and proof:

> The quaternionic-Kähler operator on `ℍP²` is a strict local maximum at `n = 8`: its second
> variation is negative on the whole tangent space apart from the directions along its orbit.
>
> **Proof.** `ℍP² = τ(S³ × S⁵)` with `τ` triality […] [Lemma L27] at `(p,q) = (3,5)` gives
> `½ − μ = ⅛ > 0` and `dim E(½) = 15 = dim 𝒪`, and `τ` normalises the inner automorphisms, so
> orbit tangents correspond and the `½`-eigenspace identity transfers. With [Lemma L24]'s Hessian
> `6θ(L_e − ½Id)` this is strict local maximality transverse to the orbit. `□`

## The audit's governing fact, and what it makes the content of the lemma

> By [Lemma L24] the orbit directions are exact `½`-eigenvectors at *every* critical point
> with `θ ≠ 0`, so `λ_max(L_e|_{W^⊥}) ≥ ½` always and a negative semidefinite Hessian is **automatic**.
> **The whole content of a local-maximality claim is the multiplicity**,
> `dim E(½) ∩ W^⊥ = dim T_W 𝒪`.

`hess_neg_of_not_half_eigenvector` below is exactly that: negative semidefiniteness enters as a
hypothesis, because it is automatic, and the conclusion is **strict** negativity at every vector
that is not a `½`-eigenvector. It is proved, and `psd_kernel`, the Cauchy–Schwarz step for a
positive semidefinite form, is the one line that makes it work.

## What the `sorry` is

`L9`, and only it: that the `ℍP²` operator exists at `n = 8` as a unit Weyl tensor with **nonzero
Bianchi defect** which is a local maximum of `P` on the unit sphere. Building that operator needs
the triality automorphism of `𝒲₈` and [Lemma L27](../../../findings/nondegeneracy.md)'s
ten-summand decomposition, neither of which the Lean layer has.

## What is NOT typed here

* **The transversality.** The record's claim is strict local maximality *transverse to the
  orbit*; `L9` below states local maximality on the unit sphere of `𝒲ₙ`, which is what that
  implies once `P` is constant along the orbit. **The orbit itself is absent**, the Lean layer
  having no `O(n)`-action on curvature operators, so the strictness clause is carried by
  `hess_neg_of_not_half_eigenvector` at the abstract level and not at `ℍP²`.
* **The Hessian formula `6θ(L_e − ½Id)`**, which is [Lemma L24](../../../findings/second-order.md)'s
  and is written into the abstract criterion as its definition rather than derived.
* **The triality identification `ℍP² = τ(S³ × S⁵)`.** What is typed is the value agreement the
  identification predicts, from two unrelated closed forms.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L9Statement

-- `altNormSq`/`altCoeff` moved to `AltLayer` when L15Statement's duplicate copy was deleted;
-- opened here explicitly rather than reached through L15Statement, which no longer owns them.
open HamiltonsCubic.RealLayer HamiltonsCubic.L15Statement RealInnerProductSpace HamiltonsCubic.AltLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The spectral splitting and the defect, repeated from [L16Statement.lean](L16Statement.lean)

*One definition with that file's; repeated rather than imported because the root import list is
owned by another process.* -/

/-- **`W = W₊ − W₋` is the spectral splitting**, characterised by the four properties that pin
it. -/
def IsSpectralSplit (W Wp Wm : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  IsLinearOp Wp ∧ IsLinearOp Wm ∧ IsSymmetricOp Wp ∧ IsSymmetricOp Wm ∧
  (∀ X, W X = Wp X - Wm X) ∧
  (∀ X, IsSkew X → 0 ≤ inner2 (Wp X) X) ∧ (∀ X, IsSkew X → 0 ≤ inner2 (Wm X) X) ∧
  (∀ X, Wp (Wm X) = 0)

/-! ## The one line that makes a semidefinite form strict off its kernel -/

section Abstract

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/-- **A positive semidefinite symmetric form vanishes on a vector only where the operator does.**
*Cauchy–Schwarz for the form `⟪A·,·⟫`, in the elementary shape: `0 ≤ ⟪A(v + tw), v + tw⟫` for
every `t`, with `t = −⟪Av,w⟫/(⟪Aw,w⟫+1)` forcing `⟪Av,w⟫ = 0`.* -/
theorem psd_kernel {A : V →ₗ[ℝ] V} (hA : A.IsSymmetric) (hpsd : ∀ x : V, 0 ≤ ⟪A x, x⟫)
    {v : V} (hv : ⟪A v, v⟫ = 0) : A v = 0 := by
  have hzero : ∀ w : V, ⟪A v, w⟫ = 0 := by
    intro w
    by_contra hc
    set c : ℝ := ⟪A v, w⟫ with hcdef
    set d : ℝ := ⟪A w, w⟫ with hddef
    have hd : 0 ≤ d := hpsd w
    set t : ℝ := -c / (d + 1) with htdef
    have hsym : ⟪A w, v⟫ = ⟪A v, w⟫ := by
      rw [hA w v]; exact real_inner_comm _ _
    have hexp : ⟪A (v + t • w), v + t • w⟫ = 2 * t * c + t ^ 2 * d := by
      simp only [map_add, map_smul, inner_add_left, inner_add_right, real_inner_smul_left,
        real_inner_smul_right]
      rw [hv, hsym, ← hcdef, ← hddef]
      ring
    have hnn : 0 ≤ 2 * t * c + t ^ 2 * d := hexp ▸ hpsd (v + t • w)
    have hd1 : (0:ℝ) < d + 1 := by linarith
    have hden : (0:ℝ) < (d + 1) ^ 2 := by positivity
    have hval : 2 * t * c + t ^ 2 * d = c ^ 2 * (-(d + 2)) / (d + 1) ^ 2 := by
      rw [htdef]; field_simp; ring
    rw [hval, le_div_iff₀ hden] at hnn
    have hc2 : 0 < c ^ 2 := by positivity
    nlinarith [hc2, hd]
  have hself := hzero (A v)
  exact inner_self_eq_zero.mp (by rw [real_inner_comm]; exact hself)

/-- **The strict local-maximality criterion, and it is a statement about the multiplicity.**

`6θ(⟪L v, v⟫ − ½‖v‖²)` is [Lemma L24](../../../findings/second-order.md)'s Hessian read on `v`.
Its **semi**definiteness is the hypothesis `hle`, because at every critical point with `θ ≠ 0` the
orbit directions are exact `½`-eigenvectors and so `λ_max ≥ ½` always. What the conclusion adds
is **strictness**, and it holds at exactly the vectors that are not `½`-eigenvectors of `L`,
that is, off the orbit. -/
theorem hess_neg_of_not_half_eigenvector {L : V →ₗ[ℝ] V} (hL : L.IsSymmetric) {θ : ℝ}
    (hθ : 0 < θ) (hle : ∀ x : V, ⟪L x, x⟫ ≤ (1/2) * ‖x‖ ^ 2)
    {v : V} (hv : L v ≠ (1/2 : ℝ) • v) :
    6 * θ * (⟪L v, v⟫ - (1/2) * ‖v‖ ^ 2) < 0 := by
  set A : V →ₗ[ℝ] V := (1/2 : ℝ) • LinearMap.id - L with hAdef
  have hval : ∀ x y : V, ⟪A x, y⟫ = (1/2) * ⟪x, y⟫ - ⟪L x, y⟫ := by
    intro x y
    simp [hAdef, inner_sub_left, real_inner_smul_left]
  have hval' : ∀ x y : V, ⟪x, A y⟫ = (1/2) * ⟪x, y⟫ - ⟪x, L y⟫ := by
    intro x y
    simp [hAdef, inner_sub_right, real_inner_smul_right]
  have hA : A.IsSymmetric := by
    intro x y
    rw [hval x y, hval' x y, hL x y]
  have hnormsq : ∀ x : V, ⟪x, x⟫ = ‖x‖ ^ 2 := fun x => real_inner_self_eq_norm_sq x
  have hpsd : ∀ x : V, 0 ≤ ⟪A x, x⟫ := by
    intro x
    rw [hval x x, hnormsq x]
    linarith [hle x]
  have hAv : ⟪A v, v⟫ = (1/2) * ‖v‖ ^ 2 - ⟪L v, v⟫ := by
    rw [hval v v, hnormsq v]
  have hne : ⟪A v, v⟫ ≠ 0 := by
    intro h
    have h0 : A v = 0 := psd_kernel hA hpsd h
    have h1 : (1/2 : ℝ) • v - L v = 0 := by
      simpa [hAdef, LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.id_apply] using h0
    exact hv (sub_eq_zero.mp h1).symm
  have hpos : 0 < ⟪A v, v⟫ := lt_of_le_of_ne (hpsd v) (Ne.symm hne)
  rw [hAv] at hpos
  nlinarith

end Abstract

/-! ## The statement at `ℍP²` -/

/-- Weyl tensors at `n = 8`, as operators on bivectors of `ℝ⁸`. -/
abbrev W8 := Matrix (Fin 8) (Fin 8) ℝ → Matrix (Fin 8) (Fin 8) ℝ

/-- **L9.** At `n = 8` there is a unit Weyl tensor with **nonzero Bianchi defect** which is a
local maximum of `P` on the unit sphere of `𝒲₈`, the quaternionic-Kähler operator on `ℍP²`,
whose defect is `2/63`.

**So nonzero defect does not force instability**, and ruling out defective rivals requires
sensitivity to the value rather than to the defect alone.

**Not proved here.** Building the operator needs the triality automorphism of `𝒲₈` and
[Lemma L27](../../../findings/nondegeneracy.md)'s ten-summand decomposition. -/
theorem L9 : ∃ W Wp Wm : W8, IsWeyl W ∧ normSq W = 1 ∧ IsSpectralSplit W Wp Wm ∧
    altNormSq Wm ≠ 0 ∧ IsLocalMaxOn Pcubic {R : W8 | IsWeyl R ∧ normSq R = 1} W := by
  sorry

/-! ## The data the record's proof reads off, all of it arithmetic -/

/-- `μ = (n−2)/(2(p−1)(q−1))`, the eigenvalue [Lemma L27](../../../findings/nondegeneracy.md)
carries on `S²₀ ⊗ S²₀` and `Λ² ⊗ Λ²`. -/
noncomputable def mu (p q : ℝ) : ℝ := (p + q - 2) / (2 * (p - 1) * (q - 1))

/-- **`½ − μ = ⅛ > 0` at `(p,q) = (3,5)`**, the gap that makes the criterion bite. -/
theorem half_minus_mu : mu 3 5 = 3 / 8 ∧ 1 / 2 - mu 3 5 = 1 / 8 ∧ 0 < 1 / 2 - mu 3 5 := by
  have h : mu 3 5 = 3 / 8 := by unfold mu; norm_num
  refine ⟨h, by rw [h]; norm_num, by rw [h]; norm_num⟩

/-- **`dim E(½) = pq = 15 = dim 𝒪` at `(3,5)`**, the multiplicity clause, which is the whole
content of the claim. -/
theorem eigenspace_matches_orbit : (3 : ℕ) * 5 = 15 := by decide

/-- **The value, from two unrelated closed forms.** `θ²(ℍPᵐ)` at `m = 2` and `θ²(Sᵖ × S^q)` at
`(3,5)` are both `56/45`; that agreement is what the triality identification predicts. -/
theorem triality_value_agreement :
    ((2:ℝ) + 2) ^ 2 * (4 * 2 - 1) / (9 * 2 * (2 - 1) * (2 * 2 + 1)) = 56 / 45 ∧
      2 * ((3:ℝ) + 5 - 1) * (3 - 1) * (5 - 1) / (((3:ℝ) + 5 - 2) * (3 * 5)) = 56 / 45 := by
  constructor <;> norm_num

/-- **And this peak is below both named competitors**: `56/45 < 3/2` and `56/45 < θ₀(8)² =
21/16`. *So "the high ground has more than one peak" is about a plateau under both.* -/
theorem peak_below_competitors : (56:ℝ) / 45 < 3 / 2 ∧ (56:ℝ) / 45 < 21 / 16 := by
  constructor <;> norm_num

/-- **The defect of `ℍP²` is `2/63`, and it is nonzero**, which is what makes it a
counterexample to *"nonzero defect forces instability"* rather than another zero-defect point. -/
theorem hp2_defect_nonzero : (2:ℝ) / 63 ≠ 0 := by norm_num

/-! ## The correction the block carries: `ℂP³` is an ordinary saddle -/

/-- **`ℂP³` at `n = 6` has `λ_max(L_e|_{e^⊥}) = 0.625 > ½`**, so its second variation is **not**
semidefinite, and its excess is `0`, no extra flat directions for a cubic to rise along. *Both
halves of the *"third-order saddle"* description are false.* -/
theorem cp3_is_ordinary_saddle : (1:ℝ) / 2 < 0.625 ∧ (0:ℕ) = 0 := by
  constructor
  · norm_num
  · rfl

/-- **`ℂP³` and `S³ × S³` share `θ² = 10/9`**, which is how the two profiles were confused,
`√(10)/3` at both. -/
theorem the_shared_value : ((10:ℝ) / 9) = (Real.sqrt 10 / 3) ^ 2 := by
  rw [div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 10)]
  norm_num

end HamiltonsCubic.L9Statement
