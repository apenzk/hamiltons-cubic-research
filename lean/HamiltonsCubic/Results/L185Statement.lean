import HamiltonsCubic.Base.WeylReal

/-!
# L185, three decomposable image forms cannot span six dimensions

**The question this closes.** [I38](../../../plan.md) stays open at exactly one width:
*is every `Λ²`-rank-`≤3` Weyl tensor supported on a four-dimensional subspace?*
[L179](L179Statement.lean) reduces that to three `2`-forms, and
[diagonal-half.md](../../../findings/diagonal-half.md) records where the reduction stops:

> **THE DECOMPOSABLE CASE IS BOUNDED AT SIX, AND ITS PLANES CANNOT BE ORTHOGONAL.** … *But the
> three planes cannot be mutually orthogonal*: an adapted frame would make such a `W`
> coordinate-diagonal, and L176 forbids rank three there. **THAT EXCLUDES ORTHOGONALITY AND NOT
> `dim V = 6`**, which is less than the paragraph reads as saying: three pairwise non-orthogonal
> planes can still span six dimensions.

**They cannot, and orthogonality is not what rules it out.** *Ricci-flatness of
`W = Σ λᵢ ωᵢ ⊗ ωᵢ` reads `Σ λᵢ ωᵢ ωᵢᵀ = 0` ([L180](L180Statement.lean)), and for a unit
decomposable `ωᵢ` (the area form of a plane `Pᵢ`), `ωᵢ ωᵢᵀ` IS the orthogonal projection `Πᵢ`.
So Ricci-flatness is `Σ λᵢ Πᵢ = 0`.* **At `dim V = 6` the three planes have `2 + 2 + 2 = 6`, so
their sum is DIRECT**, and applying `Σ λᵢ Πᵢ = 0` to a nonzero `x ∈ P₁` puts the three summands in
`P₁`, `P₂`, `P₃`, which forces each to vanish and hence `λ₁ = 0`.

**The argument uses independence and nothing else**, not orthogonality, not the first Bianchi
identity, not the rank. So it is stated below at a general family of projections, and the
three-plane case is the instance.

## What is NOT typed here

- **That `ωᵢ ωᵢᵀ = Πᵢ` for a unit decomposable form.** [SelfDual.lean](../Base/SelfDual.lean)'s
  `areaForm_mul_apply` is that fact for `areaForm`; the bridge from a general decomposable `ω` to
  an `areaForm` is the real skew normal form, which the layer does not carry.
- **That `Λ²`-rank three forces three decomposable forms.** It does not, a non-decomposable image
  form has support of dimension at least four on its own, and that branch is a different case.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L185Statement

open Matrix

variable {n r : ℕ}

/-- **The independence hypothesis**: a sum of vectors, one from each projection's range, vanishes
only when every one of them does. *At three planes spanning six dimensions this is forced by
counting, `2 + 2 + 2 = 6`, and needs no orthogonality.* -/
def RangeIndependent (Pi : Fin r → Matrix (Fin n) (Fin n) ℝ) : Prop :=
  ∀ x : Fin r → (Fin n → ℝ), (∀ i, Pi i *ᵥ x i = x i) → ∑ i, x i = 0 → ∀ i, x i = 0

/-- **L185.** Projections whose ranges are independent, weighted to sum to zero, have every weight
zero on a nonzero range.

*Read at three planes: Ricci-flatness is `Σ λᵢ Πᵢ = 0`, independence is what `dim V = 6` forces,
and the conclusion contradicts `λᵢ ≠ 0`. So a rank-three Weyl tensor with three decomposable image
forms has `dim V ≤ 5`.* -/
theorem lam_eq_zero_of_rangeIndependent
    (lam : Fin r → ℝ) (Pi : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hidem : ∀ i, Pi i * Pi i = Pi i)
    (hsum : ∑ i, lam i • Pi i = 0)
    (hind : RangeIndependent Pi)
    (i : Fin r) (v : Fin n → ℝ) (hv : Pi i *ᵥ v = v) (hvne : v ≠ 0) :
    lam i = 0 := by
  -- the family of summands at `v`, each in its own projection's range
  set x : Fin r → (Fin n → ℝ) := fun j => lam j • (Pi j *ᵥ v) with hx
  have hfix : ∀ j, Pi j *ᵥ x j = x j := by
    intro j
    have : Pi j *ᵥ (Pi j *ᵥ v) = Pi j *ᵥ v := by
      rw [Matrix.mulVec_mulVec, hidem j]
    simp [hx, Matrix.mulVec_smul, this]
  have hzero : ∑ j, x j = 0 := by
    have h := congrArg (fun M => M *ᵥ v) hsum
    simp only [Matrix.sum_mulVec, Matrix.zero_mulVec] at h
    rw [hx]
    refine h.symm ▸ ?_
    exact Finset.sum_congr rfl fun j _ => by rw [Matrix.smul_mulVec]
  have := hind x hfix hzero i
  rw [hx] at this
  simp only [hv] at this
  rcases smul_eq_zero.mp this with h | h
  · exact h
  · exact absurd h hvne

/-! ## The lemma itself, by the squaring route

*Both Gate 2 reviewers corrected the first statement of L185 from `bounded at five` to EMPTY, and
[r798](../../../reviews/REVIEW_r798.md) gave the route below, which imports no range fact about
positive-semidefinite sums, so it is independent of the one [r799](../../../reviews/REVIEW_r799.md)
used.*
-/

/-- **The anticommutator step.** Squaring `λ₂Π₂ + λ₃Π₃ = -λ₁Π₁` against idempotence leaves
`{Π₂, Π₃} = Π₂ + Π₃` once `λ₂λ₃ ≠ 0`; this is that hypothesis's consequence. -/
theorem sq_eq_two_smul {A B : Matrix (Fin n) (Fin n) ℝ}
    (hA : A * A = A) (hB : B * B = B) (hanti : A * B + B * A = A + B) :
    (A + B) * (A + B) = (2 : ℝ) • (A + B) := by
  have : (A + B) * (A + B) = (A * A + B * B) + (A * B + B * A) := by
    simp [Matrix.add_mul, Matrix.mul_add]; abel
  rw [this, hA, hB, hanti]
  ext i j; simp [Matrix.add_apply, Matrix.smul_apply]; ring

/-- **So `½(Π₂ + Π₃)` is a projection**, and its trace being `2` is what collapses the two planes
into one. *The dimension count is the record's; what is typed here is the algebra it rests on.* -/
theorem half_sum_idem {A B : Matrix (Fin n) (Fin n) ℝ}
    (hA : A * A = A) (hB : B * B = B) (hanti : A * B + B * A = A + B) :
    ((1/2 : ℝ) • (A + B)) * ((1/2 : ℝ) • (A + B)) = (1/2 : ℝ) • (A + B) := by
  rw [Matrix.smul_mul, Matrix.mul_smul, sq_eq_two_smul hA hB hanti, smul_smul, smul_smul]
  norm_num

end HamiltonsCubic.L185Statement
