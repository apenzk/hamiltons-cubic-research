import Mathlib
import HamiltonsCubic.Base.WeylReal

/-!
# `Alt`, the negative spectral part `W₋`, and the Bianchi defect `δ² = ‖Alt(W₋)‖²`

**Why this file exists.** [WeylReal.lean](WeylReal.lean) carries `IsWeyl`, `Pcubic`, `theta`,
`Qop` and `IsCritical`, and stops there. Six numbered results state themselves in `Alt`, in the
spectral parts, or in `δ²`, [L141](../Results/L141Statement.lean),
[L133](../Results/L133Statement.lean), [L12](../Results/L12Statement.lean),
[L135](../Results/L135Statement.lean), [L140](../Results/L140Statement.lean) and
[L15](../Results/L15Statement.lean), and each of them records the absence in its own
*What is NOT typed here*. This file names the three objects.

## The record's definitions, quoted

From [conventions.md](../../../findings/conventions.md), *Structure constants, brackets and
padding*:

> **`Alt` is the ORTHOGONAL PROJECTION of `S²(Λ²)` onto `Λ⁴`**, carrying its `⅓`:
> `Alt(R)_{ijkl} = ⅓(R_{ijkl} + R_{iklj} + R_{iljk})`. So `‖Alt(X)‖ ≤ ‖X‖`, `Alt` is
> self-adjoint and idempotent, and `Alt(H) = 0` for every `H` satisfying the first Bianchi
> identity, in particular for every Weyl tensor. **Inside `Λ²ℝ⁴`, `Λ⁴` is one-dimensional and
> `Alt` is the projection onto the Hodge star `⋆ = Π_SD − Π_ASD`, with `‖⋆‖² = 6`.**

> **The sign of `W₋` is `W₋ := ½(|W| − W) ⪰ 0`, the POSITIVE-SEMIDEFINITE magnitude of the
> negative part.**

and, from [problem.md](../../../findings/problem.md)'s Observation L15, the defect
`δ² = ‖Alt(W₋)‖²` that [Conjecture L16](../../../findings/problem.md) is written in.

## The two normalisations, settled here against the record

**The `⅓` is the record's own, not a reconstruction.** The line quoted above writes
`Alt(R)_{ijkl} = ⅓(R_{ijkl} + R_{iklj} + R_{iljk})` outright, and
[WeylReal.lean](WeylReal.lean)'s `bianchi` is that cyclic sum with no `⅓`, so `altCoeff` is
`⅓ · bianchi`, `altCoeff_eq_third_bianchi` below. The record's *"under the unnormalised Bianchi
map the `6` becomes `2/3`"* ([results.md](../../../results.md), Observation L15) agrees with it
and is a second reading of the same choice: `6 · (⅓)² = 2/3`. *That remark fixes the ratio `9`
between the two `Alt` conventions and is silent about the norm, which the next paragraph settles
separately.*

**The `¼` in `‖Alt(R)‖²` is the record's own `‖·‖`, read in ordered four-index components.**
`Alt` projects `S²(Λ²)` onto `Λ⁴` *inside* `S²(Λ²)`, so `‖Alt(R)‖` is measured in the same norm
as `‖R‖`, which is [WeylReal.lean](WeylReal.lean)'s `normSq`, the Hilbert–Schmidt norm on `Λ²`
in the basis `{φ_ij}_{i<j}`. Written over *ordered* quadruples that norm carries a `¼`, one `½`
for each pair, and `normSq_eq_fourNormSq_comp` below **proves** the two agree rather than
assuming it. Two record anchors read the same way:

* `‖⋆‖² = 6`. In `Λ²ℝ⁴` the Hodge star has components `⋆_{ijkl} = ε_{ijkl}`, so
  `∑_{ijkl} ⋆_{ijkl}² = 24` and `¼ · 24 = 6`. *Under the undivided sum the same object would read
  `24`.*
* `δ²(W_{ℂP²}) = 1/9`, from `Alt(u₋) = a⋆` with `a = 1/(3√6)`
  ([conventions.md](../../../findings/conventions.md),
  [route-a.md](../../../findings/route-a.md)): `‖a⋆‖² = 6a² = 1/9` under the same `¼`.

Neither anchor is computed here (the layer builds no `ℂP²` and no Hodge star) and both are
recorded as the record's reasons for the constant.

## What the record does not define, and the reading taken

**`|W|` and `W₋` at an operator given as a bare function.** The record's `W₋ = ½(|W| − W)` is
functional calculus, which needs a spectral decomposition. `specOp` below takes one: a family of
bivectors `ωᵢ` and reals `λᵢ`, assembling `Σᵢ λᵢ ωᵢ ⊗ ωᵢ`, the same shape
[L179](../Results/L179Statement.lean) uses for the record's spectral form, and `negPartOp`
applies `x ↦ x₋` to the `λᵢ`. `negPartOp_eq_half_sub` is then the record's own formula
`W₋ = ½(|W| − W)`, proved for this presentation, and `negPartScalar` carries the record's sign:
`x₋ ≥ 0`, vanishing where `x ≥ 0`.

*Orthonormality of the `ωᵢ` is used in exactly one statement*, `posPartOp_comp_negPartOp`;
everything else here holds for a bare sum of rank-one terms. What it would additionally give,
that `negPartOp` is the negative part of `specOp` in the functional-calculus sense, and that the
split is unique, is **owed** rather than stated.

**The split this construction produces meets the characterisation the Results layer already
uses.** [L6](../Results/L6Statement.lean) and [L16](../Results/L16Statement.lean) pin `W₋` by
four properties, both parts linear and symmetric, `W = W₊ − W₋`, both positive semidefinite on
bivectors, and `W₊ ∘ W₋ = 0`, and `specOp_add`, `specOp_smul`, `specOp_symmetric`,
`specOp_eq_pos_sub_neg`, `posPartOp_psd`, `negPartOp_psd` and `posPartOp_comp_negPartOp` are
those seven clauses for this pair. *The sign agrees with
[L148](../Results/L148Statement.lean)'s entrywise `x ↦ (|x| − x)/2`, which is the record's.*

## What is owed

* **The identity `scal(R² + R#) = ‖Ric(R)‖² + 6‖Alt(R)‖²`**, [L15](../Results/L15Statement.lean)
  states it and carries its `sorry` there; nothing here proves it.
* **`Alt(W₋) = a⋆` at the `ℂP²`-type competitor.** `δ² = 1/9` there is proved in
  [DefectCP2.lean](../Results/DefectCP2.lean) as `defect_u`, by direct evaluation at `n = 4` and padding.
* **`D(Alt W₋)`, the Daleckii–Krein derivative** that [L133](../Results/L133Statement.lean) and
  [L141](../Results/L141Statement.lean) are stated in. `negPartScalar`'s divided differences are
  the scalar half of it and are not developed here.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.AltLayer

open Matrix Finset HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

noncomputable section

/-! ## Two pairing facts the layer does not carry -/

/-- `⟨·,·⟩` on `Λ²` is linear in its first slot at a scalar. -/
theorem inner2_smul_left (c : ℝ) (X Y : Matrix ι ι ℝ) :
    inner2 (c • X) Y = c * inner2 X Y := by
  simp only [inner2, Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]
  ring

/-- `⟨·,·⟩` on `Λ²` carries a sign out of its first slot. -/
theorem inner2_neg_left (X Y : Matrix ι ι ℝ) : inner2 (-X) Y = - inner2 X Y := by
  simp only [inner2, Matrix.transpose_neg, Matrix.neg_mul, Matrix.trace_neg]
  ring

/-- `⟨·,·⟩` on `Λ²` carries a sign out of its second slot. -/
theorem inner2_neg_right (X Y : Matrix ι ι ℝ) : inner2 X (-Y) = - inner2 X Y := by
  simp only [inner2, Matrix.mul_neg, Matrix.trace_neg]
  ring

/-- `⟨·,·⟩` on `Λ²` is additive in its first slot. -/
theorem inner2_add_left (A B Y : Matrix ι ι ℝ) :
    inner2 (A + B) Y = inner2 A Y + inner2 B Y := by
  rw [inner2_comm, inner2_add_right, inner2_comm Y A, inner2_comm Y B]

/-- The pairing against a finite combination of bivectors, which is what a spectral operator is
built from. -/
theorem inner2_sum_smul {r : ℕ} (c : Fin r → ℝ) (M : Fin r → Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) :
    inner2 (∑ i, c i • M i) Y = ∑ i, c i * inner2 (M i) Y := by
  classical
  induction r with
  | zero => simp [inner2, Matrix.trace]
  | succ n ih =>
      rw [Fin.sum_univ_castSucc, Fin.sum_univ_castSucc, inner2_add_left, inner2_smul_left]
      rw [ih (fun i => c i.castSucc) (fun i => M i.castSucc)]

/-! ## The components of a curvature operator, and the `¼`

*`comp R i j k l` is the four-index array of the operator `R` in the pair basis. The record's
`R_{ijkl}` is this up to the global sign `⟨R φ_ij, φ_kl⟩ = -(R φ_ij)_{kl}` that
[WeylReal.lean](WeylReal.lean)'s `phi` carries, and every quantity built below is a square or a
cyclic sum, in which that sign is common to all terms.*
-/

/-- **The four-index array of `R`**, `⟨R φ_ij, φ_kl⟩`. -/
def comp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) : ℝ :=
  inner2 (R (phi i j)) (phi k l)

/-- **`bianchi` is the undivided cyclic sum of `comp`**, which is the record's
`R_{ijkl} + R_{iklj} + R_{iljk}`. -/
theorem bianchi_eq_comp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    bianchi R i j k l = comp R i j k l + comp R i k l j + comp R i l j k := rfl

/-- **`comp` is antisymmetric in its last pair**, with no hypothesis on `R`. -/
theorem comp_antisym_right (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    comp R i j l k = - comp R i j k l := by
  unfold comp
  rw [phi_swap k l, inner2_neg_right]

/-- **`comp` is antisymmetric in its first pair** once `R` respects the sign of its argument. -/
theorem comp_antisym_left (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hneg : ∀ X, R (-X) = -R X) (i j k l : ι) :
    comp R j i k l = - comp R i j k l := by
  unfold comp
  rw [phi_swap i j, hneg, inner2_neg_left]

/-- **`comp` is symmetric between its pairs** at a symmetric operator, the second clause of
`IsWeyl`. -/
theorem comp_pair_symm (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (i j k l : ι) :
    comp R k l i j = comp R i j k l := by
  unfold comp
  rw [hsym _ _ (phi_isSkew k l) (phi_isSkew i j), inner2_comm]

/-! ### The inner product on four-index arrays

**This is the `¼`.** `fourInner` is `‖·‖` of [WeylReal.lean](WeylReal.lean) written in ordered
quadruples: `normSq_eq_fourNormSq_comp` is the proof, and it is what makes `‖Alt(R)‖` and `‖R‖`
one norm rather than two. -/

/-- Rewriting the body of a four-fold sum. -/
theorem sum4_congr {f g : ι → ι → ι → ι → ℝ} (h : ∀ i j k l : ι, f i j k l = g i j k l) :
    (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, f i j k l)
      = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, g i j k l :=
  Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => h i j k l

/-- A constant comes out of a four-fold sum. -/
theorem sum4_const_mul (c : ℝ) (f : ι → ι → ι → ι → ℝ) :
    (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, c * f i j k l)
      = c * ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, f i j k l := by
  simp [Finset.mul_sum]

/-- A four-fold sum splits over a three-term sum. -/
theorem sum4_add3 (f g h : ι → ι → ι → ι → ℝ) :
    (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, (f i j k l + g i j k l + h i j k l))
      = (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, f i j k l)
        + (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, g i j k l)
        + ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, h i j k l := by
  simp [Finset.sum_add_distrib]

/-- **The `Λ²`-induced pairing on four-index arrays**, `¼ Σ_{ijkl} S T`. *The `¼` is one `½` per
antisymmetric pair, exactly the two double counts an ordered sum makes.* -/
def fourInner (S T : ι → ι → ι → ι → ℝ) : ℝ :=
  (1/4) * ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i j k l * T i j k l

/-- **`‖T‖²` on four-index arrays.** -/
def fourNormSq (T : ι → ι → ι → ι → ℝ) : ℝ := fourInner T T

theorem fourInner_comm (S T : ι → ι → ι → ι → ℝ) : fourInner S T = fourInner T S := by
  unfold fourInner
  congr 1
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => mul_comm _ _

theorem fourNormSq_nonneg (T : ι → ι → ι → ι → ℝ) : 0 ≤ fourNormSq T := by
  unfold fourNormSq fourInner
  have : (0 : ℝ) ≤ ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T i j k l :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => Finset.sum_nonneg fun k _ =>
      Finset.sum_nonneg fun l _ => mul_self_nonneg _
  linarith

/-- **`‖T‖² = 0` exactly when `T` vanishes at every four indices.** -/
theorem fourNormSq_eq_zero_iff (T : ι → ι → ι → ι → ℝ) :
    fourNormSq T = 0 ↔ ∀ i j k l : ι, T i j k l = 0 := by
  unfold fourNormSq fourInner
  constructor
  · intro h i j k l
    have h0 : ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T i j k l = 0 := by linarith
    have hi := (Finset.sum_eq_zero_iff_of_nonneg
      (fun i _ => Finset.sum_nonneg fun j _ => Finset.sum_nonneg fun k _ =>
        Finset.sum_nonneg fun l _ => mul_self_nonneg _)).1 h0 i (mem_univ i)
    have hj := (Finset.sum_eq_zero_iff_of_nonneg
      (fun j _ => Finset.sum_nonneg fun k _ => Finset.sum_nonneg fun l _ =>
        mul_self_nonneg _)).1 hi j (mem_univ j)
    have hk := (Finset.sum_eq_zero_iff_of_nonneg
      (fun k _ => Finset.sum_nonneg fun l _ => mul_self_nonneg _)).1 hj k (mem_univ k)
    have hl := (Finset.sum_eq_zero_iff_of_nonneg
      (fun l _ => mul_self_nonneg _)).1 hk l (mem_univ l)
    exact mul_self_eq_zero.1 hl
  · intro h
    have : ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T i j k l = 0 := by
      refine Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ =>
        Finset.sum_eq_zero fun k _ => Finset.sum_eq_zero fun l _ => ?_
      rw [h i j k l]; ring
    rw [this]; ring

/-- A four-fold sum splits over a difference. -/
theorem sum4_sub (f g : ι → ι → ι → ι → ℝ) :
    (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, (f i j k l - g i j k l))
      = (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, f i j k l)
        - ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, g i j k l := by
  simp [Finset.sum_sub_distrib]

theorem fourInner_sub_left (S T U : ι → ι → ι → ι → ℝ) :
    fourInner (S - T) U = fourInner S U - fourInner T U := by
  unfold fourInner
  rw [← mul_sub, ← sum4_sub]
  congr 1
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
      simp only [Pi.sub_apply]; ring

theorem fourInner_sub_right (S T U : ι → ι → ι → ι → ℝ) :
    fourInner S (T - U) = fourInner S T - fourInner S U := by
  rw [fourInner_comm, fourInner_sub_left, fourInner_comm U S, fourInner_comm T S]

/-- **`‖S − T‖² = ‖S‖² − 2⟨S,T⟩ + ‖T‖²`**, the expansion every projection argument uses. -/
theorem fourNormSq_sub (S T : ι → ι → ι → ι → ℝ) :
    fourNormSq (S - T) = fourNormSq S - 2 * fourInner S T + fourNormSq T := by
  unfold fourNormSq
  rw [fourInner_sub_left, fourInner_sub_right, fourInner_sub_right,
      fourInner_comm T S]
  ring

/-- **`‖R‖² = ¼ Σ_{ijkl} R_{ijkl}²`.** *This is where the `¼` is earned rather than chosen: the
left side is [WeylReal.lean](WeylReal.lean)'s `normSq`, the record's `‖·‖`, and the right side is
the four-index reading `‖Alt(R)‖²` is written in.* The hypothesis is that `R` sends basis
bivectors to bivectors, which is what makes the `φ` coordinates faithful. -/
theorem normSq_eq_fourNormSq_comp (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hR : ∀ i j : ι, IsSkew (R (phi i j))) :
    normSq R = fourNormSq (comp R) := by
  have key : ∀ i j : ι, inner2 (R (phi i j)) (R (phi i j))
      = ∑ k : ι, ∑ l : ι, (1/2 : ℝ) * (comp R i j k l * comp R i j k l) := by
    intro i j
    have hentry : ∀ k l : ι, comp R i j k l = - (R (phi i j)) k l := fun k l =>
      inner2_phi _ (hR i j) k l
    rw [inner2_eq_sum]
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => by rw [hentry k l]; ring
  unfold normSq innerOp fourNormSq fourInner
  rw [Finset.sum_congr rfl (fun i _ => Finset.sum_congr rfl (fun j _ => key i j))]
  simp only [← Finset.mul_sum]
  ring

/-! ## `Alt`

*The record's `Alt` is a projection on `S²(Λ²)`; `alt4` is the same average applied to any
four-index array, and `altCoeff` is its value on the array of a curvature operator. Idempotence
and self-adjointness hold for every array, so they are proved without hypotheses.*

*`Λ⁴` is nonzero from four indices on, which is where the record records the defect as having
content, `Alt` and `altNormSq` are defined at every `ι` here, and their content begins at
`n = 4`.* -/

/-- **The normalised cyclic average**, `⅓(T_{ijkl} + T_{iklj} + T_{iljk})`, the record's `Alt` in
components. -/
def alt4 (T : ι → ι → ι → ι → ℝ) (i j k l : ι) : ℝ :=
  (1/3) * (T i j k l + T i k l j + T i l j k)

/-- **`Alt` is idempotent**, and it needs nothing of `T`: the three cyclic rotations of `alt4 T`
are the same three terms in a different order. -/
theorem alt4_idem (T : ι → ι → ι → ι → ℝ) : alt4 (alt4 T) = alt4 T := by
  funext i j k l
  unfold alt4
  ring

/-- Relabelling the last three summation indices cyclically. -/
theorem sum4_cycle (F : ι → ι → ι → ι → ℝ) :
    (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, F i j k l)
      = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, F i k l j := by
  refine Finset.sum_congr rfl fun i _ => ?_
  have h1 : (∑ j : ι, ∑ k : ι, ∑ l : ι, F i k l j)
      = ∑ k : ι, ∑ j : ι, ∑ l : ι, F i k l j := Finset.sum_comm
  have h2 : ∀ k : ι, (∑ j : ι, ∑ l : ι, F i k l j) = ∑ l : ι, ∑ j : ι, F i k l j :=
    fun k => Finset.sum_comm
  rw [h1, Finset.sum_congr rfl (fun k _ => h2 k)]

/-- **`Alt` is self-adjoint** for `fourInner`, again with no hypothesis on the arrays. -/
theorem alt4_selfAdjoint (S T : ι → ι → ι → ι → ℝ) :
    fourInner (alt4 S) T = fourInner S (alt4 T) := by
  have e1 : (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i l j k * T i j k l)
      = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i j k l * T i k l j :=
    sum4_cycle (fun i j k l => S i l j k * T i j k l)
  have e2 : (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i k l j * T i j k l)
      = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i l j k * T i k l j :=
    sum4_cycle (fun i j k l => S i k l j * T i j k l)
  have e3 : (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i l j k * T i k l j)
      = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i j k l * T i l j k :=
    sum4_cycle (fun i j k l => S i l j k * T i k l j)
  unfold fourInner alt4
  have expandL : (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι,
        (1/3 : ℝ) * (S i j k l + S i k l j + S i l j k) * T i j k l)
      = (1/3 : ℝ) * ((∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i j k l * T i j k l)
        + (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i k l j * T i j k l)
        + ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i l j k * T i j k l) := by
    rw [sum4_congr (g := fun i j k l => (1/3 : ℝ) *
      (S i j k l * T i j k l + S i k l j * T i j k l + S i l j k * T i j k l))
      (fun i j k l => by ring), sum4_const_mul, sum4_add3]
  have expandR : (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι,
        S i j k l * ((1/3 : ℝ) * (T i j k l + T i k l j + T i l j k)))
      = (1/3 : ℝ) * ((∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i j k l * T i j k l)
        + (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i j k l * T i k l j)
        + ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, S i j k l * T i l j k) := by
    rw [sum4_congr (g := fun i j k l => (1/3 : ℝ) *
      (S i j k l * T i j k l + S i j k l * T i k l j + S i j k l * T i l j k))
      (fun i j k l => by ring), sum4_const_mul, sum4_add3]
  rw [expandL, expandR, e1, ← e3, ← e2]
  ring

/-- **`‖Alt T‖ ≤ ‖T‖`**, the record's contraction clause, from idempotence and self-adjointness
alone. -/
theorem fourNormSq_alt4_le (T : ι → ι → ι → ι → ℝ) : fourNormSq (alt4 T) ≤ fourNormSq T := by
  have hcross : fourInner (alt4 T) T = fourInner (alt4 T) (alt4 T) := by
    rw [← alt4_selfAdjoint (alt4 T) T, alt4_idem, alt4_selfAdjoint T T]
  have hsplit : fourNormSq (T - alt4 T)
      = fourNormSq T - 2 * fourInner T (alt4 T) + fourNormSq (alt4 T) := fourNormSq_sub _ _
  have hsym : fourInner T (alt4 T) = fourNormSq (alt4 T) := by
    rw [fourInner_comm, hcross]; rfl
  have hnn := fourNormSq_nonneg (T - alt4 T)
  rw [hsplit, hsym] at hnn
  linarith

/-- **`Alt(R)` in components**, `⅓(R_{ijkl} + R_{iklj} + R_{iljk})`. -/
def altCoeff (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ι → ι → ι → ι → ℝ := alt4 (comp R)

/-- **`Alt = ⅓ · bianchi`**, the layer's `bianchi` being the undivided cyclic sum. *This is the
first of the two normalisations, and it is the record's own line rather than a reconstruction from
its `2/3` remark.* -/
theorem altCoeff_eq_third_bianchi (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    altCoeff R i j k l = (1/3) * bianchi R i j k l := rfl

set_option maxRecDepth 8000 in
/-- **`Alt(Id) = 0`**, at every `ι`, with no hypothesis and no dimension restriction.

*`comp Id` is the Kulkarni-Nomizu square of the metric, `δ_ik δ_jl - δ_il δ_jk`, and the symmetry
that kills its cyclic average is the symmetry of `δ` ALONE: the three rotations cancel in pairs.*

**WHY IT IS HERE.** *The record carried this as a screen to machine zero, and two Gate 2 readers
independently derived it and asked for the lemma* (r995, r996). **It is the first of the two free
relations that put the `Λ⁴` obstructions in the kernel of a `2 × s` Vandermonde**, which is what
makes [I75](../../../plan.md) a finite list of `max (s-2) 0` conditions rather than an infinite
family. *Underneath it, `Id` is the curvature operator of the round sphere, so this is first
Bianchi there.* -/
theorem altCoeff_id_eq_zero :
    altCoeff (fun M : Matrix ι ι ℝ => M) = fun _ _ _ _ => (0 : ℝ) := by
  funext i j k l
  have h : ∀ a b c d : ι, comp (fun M : Matrix ι ι ℝ => M) a b c d = -(phi a b) c d :=
    fun a b c d => inner2_phi _ (phi_isSkew a b) c d
  simp only [altCoeff, alt4, h, phi, Matrix.sub_apply, Matrix.single_apply]
  -- the six products cancel in pairs that differ only by the order of the conjunction
  -- and the orientation of each equation, so the permutative lemmas align them as atoms
  simp only [and_comm, eq_comm]
  ring


/-- **`Alt(R)` alternates in `j` and `k`**, from the antisymmetry of `comp` in its last pair
alone. *With the cyclic invariance of `alt4`, which is `ring`, this makes `Alt(R)` alternating in
its last three indices with no hypothesis on `R`.* -/
theorem altCoeff_antisym_mid (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    altCoeff R i k j l = - altCoeff R i j k l := by
  unfold altCoeff alt4
  rw [show comp R i k j l = - comp R i k l j from comp_antisym_right R i k l j,
      show comp R i j l k = - comp R i j k l from comp_antisym_right R i j k l,
      show comp R i l k j = - comp R i l j k from comp_antisym_right R i l j k]
  ring

/-- **`Alt(R)` alternates in `i` and `j` too** at a linear symmetric `R`, so it is totally
antisymmetric, **this is what places `Alt(R)` in `Λ⁴`**. *The pair symmetry is `IsWeyl`'s second
clause; the sign clause is what a linear operator gives.* -/
theorem altCoeff_antisym_first (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hneg : ∀ X, R (-X) = -R X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (i j k l : ι) :
    altCoeff R j i k l = - altCoeff R i j k l := by
  have h1 : comp R j i k l = - comp R i j k l := comp_antisym_left R hneg i j k l
  have h2 : comp R j k l i = - comp R i l j k := by
    rw [show comp R j k l i = comp R l i j k from comp_pair_symm R hsym l i j k]
    exact comp_antisym_left R hneg i l j k
  have h3 : comp R j l i k = - comp R i k l j := by
    rw [show comp R j l i k = comp R i k j l from comp_pair_symm R hsym i k j l]
    exact comp_antisym_right R i k l j
  unfold altCoeff alt4
  rw [h1, h2, h3]
  ring

/-- **`δ²`-style norm of `Alt(R)`.** -/
def altNormSq (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := fourNormSq (altCoeff R)

theorem altNormSq_nonneg (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : 0 ≤ altNormSq R :=
  fourNormSq_nonneg _

/-- **`‖Alt(R)‖² = 0` exactly when `R` satisfies the first Bianchi identity.** *So the defect
measures that failure and nothing else, which is the sense in which the record calls it the
Bianchi defect.* -/
theorem altNormSq_eq_zero_iff (R : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    altNormSq R = 0 ↔ ∀ i j k l : ι, bianchi R i j k l = 0 := by
  unfold altNormSq
  rw [fourNormSq_eq_zero_iff]
  constructor
  · intro h i j k l
    have := h i j k l
    rw [altCoeff_eq_third_bianchi] at this
    linarith
  · intro h i j k l
    rw [altCoeff_eq_third_bianchi, h i j k l]
    ring

/-- **`Alt` annihilates every Weyl tensor**, the record's clause, here through `IsWeyl`'s Bianchi
component. -/
theorem altNormSq_of_isWeyl (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeyl R) :
    altNormSq R = 0 :=
  (altNormSq_eq_zero_iff R).2 hW.2.2.1

/-- **`‖Alt(R)‖ ≤ ‖R‖`** in the record's own `‖·‖`, the two sides being one norm by
`normSq_eq_fourNormSq_comp`. -/
theorem altNormSq_le_normSq (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hR : ∀ i j : ι, IsSkew (R (phi i j))) : altNormSq R ≤ normSq R := by
  rw [normSq_eq_fourNormSq_comp R hR]
  exact fourNormSq_alt4_le _

/-! ### `Alt` is linear, and the record's `Alt(|W|) = 2 Alt(W₋)` -/

theorem comp_add (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    comp (fun X => R X + S X) i j k l = comp R i j k l + comp S i j k l :=
  inner2_add_left _ _ _

theorem comp_smul (c : ℝ) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    comp (fun X => c • R X) i j k l = c * comp R i j k l :=
  inner2_smul_left _ _ _

theorem altCoeff_add (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    altCoeff (fun X => R X + S X) i j k l = altCoeff R i j k l + altCoeff S i j k l := by
  unfold altCoeff alt4
  rw [comp_add, comp_add, comp_add]
  ring

theorem altCoeff_smul (c : ℝ) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i j k l : ι) :
    altCoeff (fun X => c • R X) i j k l = c * altCoeff R i j k l := by
  unfold altCoeff alt4
  rw [comp_smul, comp_smul, comp_smul]
  ring

/-- **`‖Alt(cR)‖² = c²‖Alt(R)‖²`**, so the defect is `2`-homogeneous. -/
theorem altNormSq_smul (c : ℝ) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    altNormSq (fun X => c • R X) = c ^ 2 * altNormSq R := by
  unfold altNormSq fourNormSq fourInner
  rw [sum4_congr (f := fun i j k l => altCoeff (fun X => c • R X) i j k l
        * altCoeff (fun X => c • R X) i j k l)
      (g := fun i j k l => c ^ 2 * (altCoeff R i j k l * altCoeff R i j k l))
      (fun i j k l => by rw [altCoeff_smul]; ring), sum4_const_mul]
  ring

/-- **`Alt(0) = 0`**, the sanity check the definition owes. -/
theorem altNormSq_zero : altNormSq (ι := ι) (fun _ => 0) = 0 := by
  refine (altNormSq_eq_zero_iff _).2 fun i j k l => ?_
  simp [bianchi, inner2]

/-! ## The negative spectral part

*`negPartScalar` is the record's `x ↦ x₋ = ½(|x| − x)`, the sign that makes `W₋ ⪰ 0`.* -/

/-- **`x₋ = ½(|x| − x)`.** -/
def negPartScalar (x : ℝ) : ℝ := (|x| - x) / 2

/-- **`x₊ = ½(|x| + x)`.** -/
def posPartScalar (x : ℝ) : ℝ := (|x| + x) / 2

theorem negPartScalar_nonneg (x : ℝ) : 0 ≤ negPartScalar x := by
  unfold negPartScalar
  have := le_abs_self x
  linarith

theorem negPartScalar_of_nonneg {x : ℝ} (h : 0 ≤ x) : negPartScalar x = 0 := by
  unfold negPartScalar
  rw [abs_of_nonneg h]
  ring

theorem negPartScalar_of_nonpos {x : ℝ} (h : x ≤ 0) : negPartScalar x = -x := by
  unfold negPartScalar
  rw [abs_of_nonpos h]
  ring

/-- **`x = x₊ − x₋`**, the record's spectral split at the scalar level. -/
theorem sub_partScalar (x : ℝ) : posPartScalar x - negPartScalar x = x := by
  unfold posPartScalar negPartScalar; ring

/-- **`|x| = x + 2x₋`**, which is `W₋ = ½(|W| − W)` read forwards. -/
theorem abs_eq_add_two_negPart (x : ℝ) : |x| = x + 2 * negPartScalar x := by
  unfold negPartScalar; ring

/-- **`(-x)₋ = x₊`**, the behaviour under negation. -/
theorem negPartScalar_neg (x : ℝ) : negPartScalar (-x) = posPartScalar x := by
  unfold negPartScalar posPartScalar
  rw [abs_neg]
  ring

/-- **`x ↦ x₋` is positively homogeneous of degree one.** *This is the clause
[L17](../Results/L17Statement.lean)'s kink branch uses.* -/
theorem negPartScalar_smul {c : ℝ} (hc : 0 ≤ c) (x : ℝ) :
    negPartScalar (c * x) = c * negPartScalar x := by
  unfold negPartScalar
  rw [abs_mul, abs_of_nonneg hc]
  ring

/-! ### A curvature operator in spectral form, and its parts -/

variable {r : ℕ}

/-- **`Σᵢ λᵢ ωᵢ ⊗ ωᵢ` as an operator on bivectors**, the presentation the record's functional
calculus needs. *Orthonormality of the `ωᵢ` is what would make the `λᵢ` the eigenvalues; nothing
below assumes it.* -/
def specOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => ∑ i, (lam i * inner2 (om i) X) • om i

/-- **`|W|`**, the entrywise absolute value on the spectrum. -/
def absOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  specOp (fun i => |lam i|) om

/-- **`W₋`, the record's negative spectral part**, positive semidefinite by construction. -/
def negPartOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  specOp (fun i => negPartScalar (lam i)) om

/-- **`W₊`.** -/
def posPartOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  specOp (fun i => posPartScalar (lam i)) om

/-- The pairing of a spectral operator against a bivector, which every statement below reduces
to. -/
theorem inner2_specOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (X Y : Matrix ι ι ℝ) :
    inner2 (specOp lam om X) Y = ∑ i, lam i * (inner2 (om i) X * inner2 (om i) Y) := by
  simp only [specOp]
  rw [inner2_sum_smul]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **A spectral operator is symmetric on `Λ²`**, `IsWeyl`'s second clause, with no hypothesis at
all. -/
theorem specOp_symmetric (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (X Y : Matrix ι ι ℝ) :
    inner2 (specOp lam om X) Y = inner2 X (specOp lam om Y) := by
  rw [inner2_specOp, inner2_comm, inner2_specOp]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **A spectral operator sends bivectors to bivectors** when its `ωᵢ` are bivectors. -/
theorem specOp_isSkew (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hom : ∀ i, IsSkew (om i)) (X : Matrix ι ι ℝ) : IsSkew (specOp lam om X) := by
  have hentry : ∀ (i : Fin r) (a b : ι), om i b a = - om i a b := by
    intro i a b
    have := congrFun (congrFun (hom i) a) b
    simpa [Matrix.transpose_apply] using this
  unfold IsSkew specOp
  ext a b
  simp only [Matrix.transpose_apply, Matrix.neg_apply, Matrix.sum_apply, Matrix.smul_apply,
    smul_eq_mul, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun i _ => by rw [hentry i a b]; ring

/-- **`W₋ = ½(|W| − W)`, the record's own formula**, proved for this presentation rather than
taken as the definition. -/
theorem negPartOp_eq_half_sub (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :
    negPartOp lam om X = (1/2 : ℝ) • (absOp lam om X - specOp lam om X) := by
  simp only [negPartOp, absOp, specOp]
  rw [← Finset.sum_sub_distrib, Finset.smul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← sub_smul, smul_smul]
  congr 1
  rw [abs_eq_add_two_negPart (lam i)]
  ring

/-- **`W = W₊ − W₋`**, the spectral split. -/
theorem specOp_eq_pos_sub_neg (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :
    specOp lam om X = posPartOp lam om X - negPartOp lam om X := by
  simp only [posPartOp, negPartOp, specOp]
  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← sub_smul]
  congr 1
  rw [← sub_mul, sub_partScalar]

/-- **`|W| = W + 2W₋`**, which is the previous formula read forwards. -/
theorem absOp_eq_add (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :
    absOp lam om X = specOp lam om X + (2 : ℝ) • negPartOp lam om X := by
  simp only [absOp, negPartOp, specOp]
  rw [Finset.smul_sum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [smul_smul, ← add_smul]
  congr 1
  rw [abs_eq_add_two_negPart (lam i)]
  ring

/-- **`W₋ ⪰ 0`**, the record's sign clause: its quadratic form is nonnegative at every
bivector. -/
theorem negPartOp_psd (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :
    0 ≤ inner2 (negPartOp lam om X) X := by
  simp only [negPartOp]
  rw [inner2_specOp]
  refine Finset.sum_nonneg fun i _ => ?_
  have h1 : (0 : ℝ) ≤ negPartScalar (lam i) := negPartScalar_nonneg _
  have h2 : (0 : ℝ) ≤ inner2 (om i) X * inner2 (om i) X := mul_self_nonneg _
  exact mul_nonneg h1 h2

/-- **`W₊ ⪰ 0`.** -/
theorem posPartOp_psd (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :
    0 ≤ inner2 (posPartOp lam om X) X := by
  simp only [posPartOp]
  rw [inner2_specOp]
  refine Finset.sum_nonneg fun i _ => ?_
  have h1 : (0 : ℝ) ≤ posPartScalar (lam i) := by
    unfold posPartScalar
    have := neg_abs_le (lam i)
    linarith
  exact mul_nonneg h1 (mul_self_nonneg _)

/-- **A spectral operator is additive in its argument.** -/
theorem specOp_add (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (X Y : Matrix ι ι ℝ) :
    specOp lam om (X + Y) = specOp lam om X + specOp lam om Y := by
  simp only [specOp]
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← add_smul, inner2_add_right]
  congr 1
  ring

/-- **A spectral operator is homogeneous in its argument.** -/
theorem specOp_smul (c : ℝ) (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :
    specOp lam om (c • X) = c • specOp lam om X := by
  simp only [specOp]
  rw [Finset.smul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [smul_smul, inner2_comm, inner2_smul_left, inner2_comm]
  congr 1
  ring

/-- **`x₊ x₋ = 0`**, the scalar behind the orthogonality of the two spectral parts. -/
theorem posPartScalar_mul_negPartScalar (x : ℝ) : posPartScalar x * negPartScalar x = 0 := by
  unfold posPartScalar negPartScalar
  have : |x| * |x| = x * x := by
    rw [abs_mul_abs_self]
  nlinarith [this]

/-- **`W₊ ∘ W₋ = 0`**, the last clause of the record's characterisation of the spectral split.
*This is the one statement here that needs the `ωᵢ` orthonormal, which is what makes `specOp` a
spectral decomposition rather than a bare sum of rank-one terms.* -/
theorem posPartOp_comp_negPartOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (horth : ∀ i j : Fin r, inner2 (om i) (om j) = if i = j then 1 else 0) (X : Matrix ι ι ℝ) :
    posPartOp lam om (negPartOp lam om X) = 0 := by
  have hinner : ∀ i : Fin r, inner2 (om i) (negPartOp lam om X)
      = negPartScalar (lam i) * inner2 (om i) X := by
    intro i
    simp only [negPartOp, specOp]
    rw [inner2_comm, inner2_sum_smul]
    have hbody : ∀ j : Fin r, negPartScalar (lam j) * inner2 (om j) X * inner2 (om j) (om i)
        = if j = i then negPartScalar (lam i) * inner2 (om i) X else 0 := by
      intro j
      rw [horth j i]
      by_cases hj : j = i
      · subst hj; simp
      · simp [hj]
    rw [Finset.sum_congr rfl (fun j _ => hbody j), Finset.sum_ite_eq' univ i]
    simp
  simp only [posPartOp, specOp]
  refine Finset.sum_eq_zero fun i _ => ?_
  rw [hinner i, ← mul_assoc, posPartScalar_mul_negPartScalar, zero_mul, zero_smul]

/-- **A positive semidefinite spectrum has no negative part**, so `W₋ = 0` there. -/
theorem negPartOp_of_nonneg (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (h : ∀ i, 0 ≤ lam i) (X : Matrix ι ι ℝ) : negPartOp lam om X = 0 := by
  simp only [negPartOp, specOp]
  refine Finset.sum_eq_zero fun i _ => ?_
  rw [negPartScalar_of_nonneg (h i), zero_mul, zero_smul]

/-- **Negation exchanges the two spectral parts**, the behaviour under `W ↦ −W`. -/
theorem negPartOp_neg (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :
    negPartOp (fun i => -lam i) om X = posPartOp lam om X := by
  simp only [negPartOp, posPartOp, specOp]
  exact Finset.sum_congr rfl fun i _ => by rw [negPartScalar_neg]

/-- **`W₋` is positively homogeneous of degree one in the spectrum.** -/
theorem negPartOp_smul {c : ℝ} (hc : 0 ≤ c) (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (X : Matrix ι ι ℝ) :
    negPartOp (fun i => c * lam i) om X = c • negPartOp lam om X := by
  simp only [negPartOp, specOp]
  rw [Finset.smul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [negPartScalar_smul hc, smul_smul]
  congr 1
  ring

/-! ## The Bianchi defect -/

/-- **`δ² = ‖Alt(W₋)‖²`**, the defect of [Observation L15](../../../findings/problem.md), written
at a spectral presentation of `W`. -/
def defectSq (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) : ℝ :=
  altNormSq (ι := ι) (negPartOp lam om)

theorem defectSq_nonneg (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) :
    0 ≤ defectSq (ι := ι) lam om := altNormSq_nonneg _

/-- **A positive semidefinite `W` has zero defect**, since it has no negative part. -/
theorem defectSq_of_nonneg (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (h : ∀ i, 0 ≤ lam i) : defectSq (ι := ι) lam om = 0 := by
  unfold defectSq
  refine (altNormSq_eq_zero_iff _).2 fun _ _ _ _ => ?_
  simp only [bianchi, negPartOp_of_nonneg lam om h]
  simp [inner2]

/-- **`δ²` is `2`-homogeneous in `W`.** -/
theorem defectSq_smul {c : ℝ} (hc : 0 ≤ c) (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) :
    defectSq (ι := ι) (fun i => c * lam i) om = c ^ 2 * defectSq (ι := ι) lam om := by
  unfold defectSq
  rw [show (negPartOp (ι := ι) (fun i => c * lam i) om)
        = (fun X => c • negPartOp lam om X) from funext (negPartOp_smul hc lam om)]
  exact altNormSq_smul _ _

/-- **`δ² ≤ ‖W₋‖²`**, the record's contraction clause applied to the defect. -/
theorem defectSq_le_normSq (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hom : ∀ i, IsSkew (om i)) :
    defectSq (ι := ι) lam om ≤ normSq (negPartOp lam om) :=
  altNormSq_le_normSq _ fun _ _ => specOp_isSkew _ om hom _

/-- **`Alt(|W|) = 2 Alt(W₋)` when `W` satisfies the first Bianchi identity**, the record's step,
proved from linearity of `Alt` rather than asserted. *It is what turns
[L15](../Results/L15Statement.lean)'s `6‖Alt(|W|)‖²` into `24 δ²`.* -/
theorem altCoeff_absOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hB : ∀ i j k l : ι, bianchi (specOp lam om) i j k l = 0) (i j k l : ι) :
    altCoeff (absOp lam om) i j k l = 2 * altCoeff (negPartOp lam om) i j k l := by
  have hfun : (absOp (ι := ι) lam om)
      = fun X => specOp lam om X + (2 : ℝ) • negPartOp lam om X :=
    funext (absOp_eq_add lam om)
  rw [hfun, altCoeff_add, altCoeff_smul, altCoeff_eq_third_bianchi, hB i j k l]
  ring

/-- **And so `‖Alt(|W|)‖² = 4δ²`**, the `4` the record's `24 = 6·4` carries. -/
theorem altNormSq_absOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hB : ∀ i j k l : ι, bianchi (specOp lam om) i j k l = 0) :
    altNormSq (ι := ι) (absOp lam om) = 4 * defectSq (ι := ι) lam om := by
  unfold altNormSq defectSq altNormSq fourNormSq fourInner
  rw [sum4_congr (f := fun i j k l => altCoeff (absOp lam om) i j k l
        * altCoeff (absOp lam om) i j k l)
      (g := fun i j k l => (4 : ℝ) * (altCoeff (negPartOp lam om) i j k l
        * altCoeff (negPartOp lam om) i j k l))
      (fun i j k l => by rw [altCoeff_absOp lam om hB]; ring), sum4_const_mul]
  ring

/-! ## Witnesses, so the hypotheses are inhabited -/

/-- **The zero operator is a Weyl tensor**, so `altNormSq_of_isWeyl` speaks about something. -/
theorem isWeyl_zero : IsWeyl (ι := ι) (fun _ => 0) := by
  refine ⟨fun X _ => by simp [IsSkew], fun X Y _ _ => by simp [inner2],
    fun i j k l => by simp [bianchi, inner2], fun a b => by simp [Ric, inner2]⟩

/-- **A spectral operator at spectrum zero is the zero operator**, and its defect is zero. -/
theorem defectSq_zero_spectrum (om : Fin r → Matrix ι ι ℝ) :
    defectSq (ι := ι) (fun _ => (0 : ℝ)) om = 0 :=
  defectSq_of_nonneg _ om fun _ => le_refl 0

end

end HamiltonsCubic.AltLayer
