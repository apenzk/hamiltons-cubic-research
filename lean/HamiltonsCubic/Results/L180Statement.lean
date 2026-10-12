import Mathlib
import HamiltonsCubic.Base.AltPart

/-!
# L180, Ricci-flatness is a signed PSD identity, and it names the support

## The record's statement, verbatim

> #### Lemma L180, Ricci-flatness is a signed PSD identity, and it names the support
>
> **Statement.** Let $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ be a nonzero element of
> $\mathcal W_n$ in spectral form, the $\omega_i$ orthonormal $2$-forms and every
> $\lambda_i\ne0$. Writing each $2$-form as a skew matrix and setting
> $A_i=-\omega_i^2=\omega_i\omega_i^{\mathsf T}$:
>
> 1. **Ricci-flatness is exactly $\sum_i\lambda_i\,\omega_i^2=0$**, an identity in
>    $S^2(\mathbb R^n)$, equivalently $\sum_i\lambda_iA_i=0$ with **every $A_i$ positive
>    semidefinite of trace $2$**.
> 2. **Tracelessness is its trace** and is therefore not an extra condition, *and the first
>    Bianchi identity is used nowhere in this lemma, which is Ricci-only*:
>    $\operatorname{tr}(\omega_i^2)=-2\lVert\omega_i\rVert^2=-2$, so the trace of (1) is
>    $-2\sum_i\lambda_i$.
> 3. **At rank three the support $V$ is the support of the single form carrying the minority
>    sign**, and $\dim V$ is even and at least four.

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L180.

## What this file states

**(1) against the record's own Ricci contraction.** `RealLayer.Ric` is the record's contraction of
a curvature operator on `Λ²`, and `AltLayer.specOp` is `Σ λᵢ ωᵢ ⊗ ωᵢ` as such an operator, so
`ric_specOp` says the two readings agree entry by entry and `ricci_flat_iff_specOp` is
Ricci-flatness of the record's object in the record's own predicate, `Ric (specOp λ ω) = 0` iff
`Σ λᵢ ωᵢ ωᵢᵀ = 0`. *Skewness of the `ωᵢ` is what the identification costs, and it is carried as a
hypothesis rather than as a convention.* `ricci_flat_iff` keeps the same equivalence for the
index-level contraction with no skewness anywhere.

**(2) with the record's own norm.** `inner2` is the `Λ²` pairing the layer fixes, and
`trace_mul_transpose_eq_two_inner2` is `tr(ωωᵀ) = 2‖ω‖²` under it, so the record's `‖ωᵢ‖ = 1`
gives the trace `2` it quotes, and `sum_lam_eq_zero_of_unit` reads the trace of (1) as
`Σ λᵢ = 0` from unit norm directly.

**(3) as the kernel containment, at every rank.** The record's box states the general content as
`Σ_{λᵢ>0} supp ωᵢ = Σ_{λᵢ<0} supp ωᵢ = V`, and `ker_of_ker_minority` is the containment half of
it, proved: **if `x` is killed by one form and every other weight is strictly positive, then `x`
is killed by all of them.** *The mechanism is `psd_quad`, the identity
`xᵀ(ωωᵀ)x = ‖ωᵀx‖²`, which makes each summand of `xᵀ(Σ λᵢ Aᵢ)x` a weight times a square.*
`psd_quad_eq_zero_iff` and `ker_transpose_iff_ker` are the record's own footnote, `ker A` is
`ker ωᵀ`, which for skew `ω` is `ker ω`, in the two steps the containment uses. At rank three with the sign pattern `(+,+,−)` or `(+,−,−)`,
`rank_three_ker` is the containment the record reads as "the minority form's support already
contains the other two".

## What is NOT typed here

- **The passage from kernels to supports, and the evenness.** `ker_of_ker_minority` gives
  `ker ω_m ⊆ ker ωᵢ`, which is `supp ωᵢ ⊆ supp ω_m` only after taking orthogonal complements,
  the record's own "the passage from `ker A = ker ω` to equal ranges, which is the
  self-adjointness of `A`". Neither that passage nor **`dim V` even** (the rank of a real skew
  matrix is even) nor **`dim V ≥ 4`** (at `dim V = 2` the space `Λ²V` is a line, so the rank is
  at most one) is stated: each is a theorem about ranks of skew matrices that this layer does
  not carry.
- **The reverse containment**, `supp ω₁ + supp ω₂ = supp ω₃`, which is where
  [Fillmore–Williams](../../../references/fillmore-williams-1971-operator-ranges/) enters. Only
  the containment the conclusion uses is proved.
- **That `V` does not depend on the choice of eigenbasis inside a degenerate eigenspace**, one of
  the three steps the record names as previously unstated.
- **That `Σ λᵢ ωᵢ ⊗ ωᵢ` is a Weyl tensor**, which needs the first Bianchi identity as well,
  deliberately, since the record's own note is that this lemma is Ricci-only.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L180

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer

variable {n r : ℕ}

/-- The Ricci contraction of `Σ λᵢ ωᵢ ⊗ ωᵢ`, written out on indices. -/
noncomputable def ricci (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (a c : Fin n) : ℝ :=
  ∑ i, lam i * ∑ b, om i a b * om i c b

/-- **The Ricci contraction IS the entry of `Σ λᵢ ωᵢ ωᵢᵀ`.** This is the identity L180 turns on,
and it holds for any matrices at all, skewness enters only in reading `ωωᵀ` as `-ω²`. -/
theorem ricci_eq_sum_mul_transpose (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (a c : Fin n) :
    ricci lam om a c = (∑ i, lam i • (om i * (om i)ᵀ)) a c := by
  simp only [ricci, Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, Matrix.mul_apply,
             Matrix.transpose_apply, Finset.mul_sum]

/-- **`ωωᵀ = -ω²` for a skew matrix**, which turns the identity above into the block's form. -/
theorem mul_transpose_eq_neg_sq {om : Matrix (Fin n) (Fin n) ℝ} (h : omᵀ = -om) :
    om * omᵀ = -(om * om) := by
  rw [h, Matrix.mul_neg]

/-- **`ωωᵀ` is positive semidefinite**, for the reason any Gram matrix is: it is `ω` against its
own transpose. -/
theorem posSemidef_mul_transpose (om : Matrix (Fin n) (Fin n) ℝ) :
    (om * omᵀ).PosSemidef := by
  simpa using Matrix.posSemidef_self_mul_conjTranspose om

/-- **The trace is twice the squared norm.** `tr(ωωᵀ) = Σ_{a,b} ω_ab²`, which is `2‖ω‖²` under
the convention that `‖ω‖²` sums over `a < b`. -/
theorem trace_mul_transpose (om : Matrix (Fin n) (Fin n) ℝ) :
    (om * omᵀ).trace = ∑ a, ∑ b, om a b ^ 2 := by
  simp [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, sq]

/-- **`tr(ωωᵀ) = 2‖ω‖²` in the record's own `Λ²` pairing.** *[WeylReal.lean](../Base/WeylReal.lean)'s
`inner2` carries the `½`, so a unit `2`-form has `tr(ωωᵀ) = 2`, the trace the record quotes, here
derived from the norm rather than assumed alongside it.* -/
theorem trace_mul_transpose_eq_two_inner2 (om : Matrix (Fin n) (Fin n) ℝ) :
    (om * omᵀ).trace = 2 * inner2 om om := by
  rw [trace_mul_transpose, inner2_eq_sum]
  have h : ∀ a : Fin n, ∑ b, om a b ^ 2 = ∑ b, om a b * om a b :=
    fun a => Finset.sum_congr rfl fun b _ => sq _
  simp only [h]
  ring

/-! ## The statement itself -/

/-- **L180(1).** Ricci-flatness of `Σ λᵢ ωᵢ ⊗ ωᵢ` is exactly `Σ λᵢ ωᵢ ωᵢᵀ = 0`.

**Skewness is NOT assumed here and the record's form assumes it.** *The record writes the
condition as `Σ λᵢ ωᵢ² = 0`, and `ωωᵀ = -ω²` only for skew `ω`, `mul_transpose_eq_neg_sq` above
carries that step and this theorem does not invoke it, so the two conditions coincide on skew
matrices and differ in general.*

**Proved**, and directly from the identity above, this half of L180 needs nothing else. -/
theorem ricci_flat_iff (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ) :
    (∀ a c, ricci lam om a c = 0) ↔ (∑ i, lam i • (om i * (om i)ᵀ)) = 0 := by
  constructor
  · intro h
    ext a c
    rw [← ricci_eq_sum_mul_transpose]
    exact h a c
  · intro h a c
    rw [ricci_eq_sum_mul_transpose, h]
    simp

/-! ### The same, against the record's own curvature operator

*[AltPart.lean](../Base/AltPart.lean)'s `specOp` is `Σ λᵢ ωᵢ ⊗ ωᵢ` as an operator on `Λ²`, and
[WeylReal.lean](../Base/WeylReal.lean)'s `Ric` is `IsWeyl`'s fourth clause. So L180(1) can be read
on the object the record's statement is about rather than on a four-index array.*
-/

/-- **The record's `Ric` of `Σ λᵢ ωᵢ ⊗ ωᵢ` is this file's `ricci`.** *Skewness is what identifies
`⟨ωᵢ, φ_ac⟩` with `-（ωᵢ)_ac`, and it is the only place it is used.* -/
theorem ric_specOp (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hom : ∀ i, IsSkew (om i)) (a c : Fin n) :
    Ric (specOp lam om) a c = ricci lam om a c := by
  unfold Ric ricci
  have hstep : ∀ b : Fin n, inner2 (specOp lam om (phi a b)) (phi c b)
      = ∑ i, lam i * (om i a b * om i c b) := by
    intro b
    rw [inner2_specOp]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [inner2_phi _ (hom i) a b, inner2_phi _ (hom i) c b]
    ring
  simp only [hstep]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun i _ => (Finset.mul_sum _ _ _).symm

/-- **L180(1) ON THE RECORD'S OWN OBJECT.** Ricci-flatness of the curvature operator
`Σ λᵢ ωᵢ ⊗ ωᵢ`, `IsWeyl`'s fourth clause, at `AltLayer.specOp`, is exactly `Σ λᵢ ωᵢ ωᵢᵀ = 0`,
which for skew `ωᵢ` is the record's `Σ λᵢ ωᵢ² = 0`. -/
theorem ricci_flat_iff_specOp (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hom : ∀ i, IsSkew (om i)) :
    (∀ a c, Ric (specOp lam om) a c = 0) ↔ (∑ i, lam i • (om i * (om i)ᵀ)) = 0 := by
  rw [← ricci_flat_iff]
  constructor <;> intro h a c
  · rw [← ric_specOp lam om hom a c]; exact h a c
  · rw [ric_specOp lam om hom a c]; exact h a c

/-- **L180(2).** Tracelessness is the trace of Ricci-flatness: with every `‖ωᵢ‖ = 1`, so that
`tr(ωᵢωᵢᵀ) = 2`, the trace of `Σ λᵢ ωᵢ ωᵢᵀ = 0` is `2 Σ λᵢ = 0`.

**Proved.** -/
theorem sum_lam_eq_zero (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hnorm : ∀ i, (om i * (om i)ᵀ).trace = 2)
    (h : (∑ i, lam i • (om i * (om i)ᵀ)) = 0) : ∑ i, lam i = 0 := by
  have : (∑ i, lam i • (om i * (om i)ᵀ)).trace = 0 := by rw [h]; simp
  rw [Matrix.trace_sum] at this
  simp only [Matrix.trace_smul, hnorm, smul_eq_mul] at this
  rw [← Finset.sum_mul] at this
  linarith

/-- **L180(2), from the record's own orthonormality clause.** *`‖ωᵢ‖ = 1` in the `Λ²` pairing
gives the trace `2`, so tracelessness follows from the hypothesis the record actually states.* -/
theorem sum_lam_eq_zero_of_unit (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hnorm : ∀ i, inner2 (om i) (om i) = 1)
    (h : (∑ i, lam i • (om i * (om i)ᵀ)) = 0) : ∑ i, lam i = 0 :=
  sum_lam_eq_zero lam om (fun i => by rw [trace_mul_transpose_eq_two_inner2, hnorm i]; ring) h

/-! ## L180(3), the support, as the kernel containment

*The record's general box: `Σ_{λᵢ>0} supp ωᵢ = Σ_{λᵢ<0} supp ωᵢ = V`, at any rank. What is proved
here is the containment half, in the kernels, which is the direction the rank-three conclusion
uses.*
-/

/-- **`xᵀ(ωωᵀ)x = ‖ωᵀx‖²`**, the identity that makes each summand of the Ricci pairing a weight
times a square. -/
theorem psd_quad (om : Matrix (Fin n) (Fin n) ℝ) (x : Fin n → ℝ) :
    x ⬝ᵥ ((om * omᵀ) *ᵥ x) = ∑ c, (∑ a, om a c * x a) ^ 2 := by
  have L : x ⬝ᵥ ((om * omᵀ) *ᵥ x)
      = ∑ a, ∑ b, ∑ c, (om a c * x a) * (om b c * x b) := by
    simp only [dotProduct, Matrix.mulVec, Matrix.mul_apply, Matrix.transpose_apply]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [Finset.sum_mul, Finset.mul_sum]
    exact Finset.sum_congr rfl fun c _ => by ring
  have R : ∑ c, (∑ a, om a c * x a) ^ 2
      = ∑ c, ∑ a, ∑ b, (om a c * x a) * (om b c * x b) :=
    Finset.sum_congr rfl fun c _ => by rw [sq, Finset.sum_mul_sum]
  rw [L, R]
  calc ∑ a, ∑ b, ∑ c, (om a c * x a) * (om b c * x b)
      = ∑ a, ∑ c, ∑ b, (om a c * x a) * (om b c * x b) :=
        Finset.sum_congr rfl fun a _ => Finset.sum_comm
    _ = ∑ c, ∑ a, ∑ b, (om a c * x a) * (om b c * x b) := Finset.sum_comm

/-- **The quadratic form vanishes exactly on the kernel of `ωᵀ`.** -/
theorem psd_quad_eq_zero_iff (om : Matrix (Fin n) (Fin n) ℝ) (x : Fin n → ℝ) :
    x ⬝ᵥ ((om * omᵀ) *ᵥ x) = 0 ↔ ∀ c, (∑ a, om a c * x a) = 0 := by
  rw [psd_quad]
  constructor
  · intro h c
    have := (Finset.sum_eq_zero_iff_of_nonneg (fun c _ => sq_nonneg _)).1 h c (mem_univ c)
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.1 this
  · intro h
    exact Finset.sum_eq_zero fun c _ => by rw [h c]; ring

/-- **`ker(ωᵀ) = ker(ω)` for a skew matrix**, which is the record's own footnote read on the left
kernel. -/
theorem ker_transpose_iff_ker {om : Matrix (Fin n) (Fin n) ℝ} (h : IsSkew om) (x : Fin n → ℝ) :
    (∀ c, (∑ a, om a c * x a) = 0) ↔ om *ᵥ x = 0 := by
  have hentry : ∀ a c : Fin n, om a c = - om c a := by
    intro a c
    have := congrFun (congrFun h c) a
    simpa [Matrix.transpose_apply] using this
  have hrow : ∀ c : Fin n, (om *ᵥ x) c = ∑ a, om c a * x a := fun _ => rfl
  constructor
  · intro hc
    funext c
    have hcc := hc c
    have hflip : ∑ a, om a c * x a = - ∑ a, om c a * x a := by
      rw [← Finset.sum_neg_distrib]
      exact Finset.sum_congr rfl fun a _ => by rw [hentry a c]; ring
    rw [hflip] at hcc
    rw [Pi.zero_apply, hrow c]
    linarith [hcc]
  · intro hx c
    have hcc : ∑ a, om c a * x a = 0 := by rw [← hrow c, hx]; rfl
    have h2 : ∑ a, - (om c a * x a) = 0 := by
      rw [Finset.sum_neg_distrib, hcc]; ring
    rw [← h2]
    exact Finset.sum_congr rfl fun a _ => by rw [hentry a c]; ring

/-- **L180(3), THE CONTAINMENT, AT EVERY RANK.** If `Σ λᵢ ωᵢ ωᵢᵀ = 0`, every weight other than
`λ_m` is strictly positive, and `x` is killed by `ω_m`, then `x` is killed by every `ωᵢ`.

*This is the record's `Σ_{λᵢ>0} supp ωᵢ ⊆ supp ω_m` in the kernels: the pairing against `x` turns
the identity into `Σ λᵢ ‖ωᵢᵀx‖² = 0`, whose `m`-th term vanishes by hypothesis, so a sum of
strictly positive weights against squares is zero.* **The sign of `λ_m` is never used**, so the
lemma covers both of the record's rank-three patterns and the general box alike. -/
theorem ker_of_ker_minority (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hom : ∀ i, IsSkew (om i))
    (hric : (∑ i, lam i • (om i * (om i)ᵀ)) = 0)
    (m : Fin r) (hpos : ∀ i, i ≠ m → 0 < lam i)
    (x : Fin n → ℝ) (hxm : om m *ᵥ x = 0) :
    ∀ i, om i *ᵥ x = 0 := by
  set q : Fin r → ℝ := fun i => x ⬝ᵥ ((om i * (om i)ᵀ) *ᵥ x) with hq
  have hqnn : ∀ i, 0 ≤ q i := fun i => by
    rw [hq]; simp only [psd_quad]
    exact Finset.sum_nonneg fun c _ => sq_nonneg _
  have hqm : q m = 0 := by
    rw [hq]
    simp only
    exact (psd_quad_eq_zero_iff _ _).2 ((ker_transpose_iff_ker (hom m) x).2 hxm)
  have hsum : ∑ i, lam i * q i = 0 := by
    have h0 : x ⬝ᵥ ((∑ i, lam i • (om i * (om i)ᵀ)) *ᵥ x) = 0 := by
      rw [hric]; simp
    rw [← h0]
    simp only [hq, Matrix.sum_mulVec, Matrix.smul_mulVec, dotProduct_sum,
      dotProduct_smul, smul_eq_mul]
  have hrest : ∑ i ∈ univ.erase m, lam i * q i = 0 := by
    rw [← Finset.add_sum_erase univ (fun i => lam i * q i) (mem_univ m)] at hsum
    rw [hqm, mul_zero, zero_add] at hsum
    exact hsum
  have hterm : ∀ i ∈ univ.erase m, lam i * q i = 0 := by
    refine (Finset.sum_eq_zero_iff_of_nonneg fun i hi => ?_).1 hrest
    exact mul_nonneg (le_of_lt (hpos i (Finset.mem_erase.1 hi).1)) (hqnn i)
  intro i
  rcases eq_or_ne i m with rfl | hi
  · exact hxm
  · have h1 := hterm i (Finset.mem_erase.2 ⟨hi, mem_univ i⟩)
    have h2 : q i = 0 := by
      rcases mul_eq_zero.1 h1 with h' | h'
      · exact absurd h' (ne_of_gt (hpos i hi))
      · exact h'
    exact (ker_transpose_iff_ker (hom i) x).1 ((psd_quad_eq_zero_iff _ _).1 h2)

/-- **L180(3) at rank three, in the record's own sign pattern.** With `λ₀, λ₁ > 0 > λ₂`, the
pattern `(+,+,−)` up to relabelling, the other being this one applied to `−λ`, the kernel of the
minority form `ω₂` lies inside the kernels of `ω₀` and `ω₁`. *Read on supports through orthogonal
complements, this is "the minority form's support already contains the other two, so it is `V`";
that reading, and the evenness of `dim V`, are named above as not typed here.* -/
theorem rank_three_ker (lam : Fin 3 → ℝ) (om : Fin 3 → Matrix (Fin n) (Fin n) ℝ)
    (hom : ∀ i, IsSkew (om i))
    (hric : (∑ i, lam i • (om i * (om i)ᵀ)) = 0)
    (h0 : 0 < lam 0) (h1 : 0 < lam 1)
    (x : Fin n → ℝ) (hx : om 2 *ᵥ x = 0) :
    om 0 *ᵥ x = 0 ∧ om 1 *ᵥ x = 0 := by
  have hpos : ∀ i : Fin 3, i ≠ 2 → 0 < lam i := by
    intro i hi
    fin_cases i
    · exact h0
    · exact h1
    · exact absurd rfl hi
  have h := ker_of_ker_minority lam om hom hric 2 hpos x hx
  exact ⟨h 0, h 1⟩

end HamiltonsCubic.L180
