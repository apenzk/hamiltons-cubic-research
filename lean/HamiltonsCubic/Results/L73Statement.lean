import Mathlib

set_option linter.style.longLine false

/-!
# L73, stated and proved as a theorem about the row calculus

## The record's statement, verbatim

> **LEMMA L73.** *At **every** $W\in\mathcal W_n$ (critical or not), the spectrum alone satisfies
> $-(n-2)\lambda_{\max}\le\lambda_a\le(n-2)\lvert\lambda_{\min}\rvert$ for every $a$; equivalently
> $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ and
> $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$.*
> **It is not implied by tracelessness**, which gives only $N-1$ in place of $n-2$, for every
> $n\ge3$; and **the constant $n-2$ cannot be improved**, being **attained at $S^2\times S^{n-2}$
> for every $n$, odd and even**.

[bounds.md](../../../findings/bounds.md), Lemma L73.

## What this file states, and what it takes as given

The record's account of the inputs is exact: *"The derivation uses (A), (B) and $T\ge0$"*,
**(A)** the Killing row mass, **(B)** the Weyl identity `W # I = -W` in row form, and
nonnegativity of the bracket array. Criticality, which is relation (C), appears nowhere. So the
lemma is a statement about a nonnegative pair-symmetric array obeying two linear relations, and
this file states it as one: `RowCalculus` carries exactly those hypotheses and nothing else.

**(A) and (B) are the record's inputs, not this file's results.** They are proved there, (A)
from the Killing form, (B) from Ricci-flatness with the first Bianchi identity, which is
[Böhm–Wilking](../../../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1, and enter
here as the defining fields of the structure. **What is proved here is everything the record
derives from them**: the two-sided bound at every index, both one-sided forms, the signs of the
extreme eigenvalues (which the record leaves to tracelessness and which follow from (A) and (B)
alone), and the tracelessness comparison.

`n` enters only through (A)'s row mass `2(n-2)`. The index type `ι` is the eigenbasis of
`Λ²ℝⁿ`, and `Fintype.card ι` is the record's `N`.

**Not typed here:** sharpness at `S² × S^{n-2}`, which needs the curvature layer to exhibit the
tensor. The witness at the foot of the file satisfies every hypothesis and saturates the bound,
so the statement is non-vacuous and the constant is unimprovable *for the hypotheses as stated*;
the record's claim is the stronger one, that a Weyl tensor attains it.
-/

namespace HamiltonsCubic.L73Statement

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The row calculus on the eigenbasis of a Weyl tensor: `lam` is the spectrum and
`T a b c = ⟨[v_a,v_b],v_c⟩²` the bracket array.

The four fields are the record's inputs and nothing more: `T ≥ 0`, symmetry of `T` in the pair
indices, **(A)** the Killing row mass `2(n-2)`, and **(B)** the row form of `W # I = -W`.
Relation (C), which is the only one needing criticality, is deliberately absent, L73 holds on
all of `𝒲ₙ`. -/
structure RowCalculus (n : ℕ) (lam : ι → ℝ) (T : ι → ι → ι → ℝ) : Prop where
  /-- `T` is a square of a structure constant, hence nonnegative. -/
  nonneg : ∀ a b c, 0 ≤ T a b c
  /-- `T` is totally symmetric; only symmetry in the pair indices is used below. -/
  pairSymm : ∀ a b c, T a b c = T a c b
  /-- **(A)**, the Killing form: the row mass is `2(n-2)`. -/
  killing : ∀ a, ∑ b, ∑ c, T a b c = 2 * ((n : ℝ) - 2)
  /-- **(B)**, Ricci-flatness with the first Bianchi identity, in row form. -/
  bianchi : ∀ a, ∑ b, ∑ c, T a b c * (lam b + lam c) = -4 * lam a

variable {n : ℕ} {lam : ι → ℝ} {T : ι → ι → ι → ℝ}

/-- The pair-summed array `S a b = ∑_c T a b c`, which is
[Lemma L112](../../../findings/bounds.md)'s symmetric hollow matrix. -/
noncomputable def rowMat (T : ι → ι → ι → ℝ) (a b : ι) : ℝ := ∑ c, T a b c

theorem rowMat_nonneg (h : RowCalculus n lam T) (a b : ι) : 0 ≤ rowMat T a b :=
  Finset.sum_nonneg fun c _ => h.nonneg a b c

/-- **(A) read on `S`: every row of `S` sums to `2(n-2)`.** -/
theorem rowMat_sum (h : RowCalculus n lam T) (a : ι) :
    ∑ b, rowMat T a b = 2 * ((n : ℝ) - 2) := h.killing a

/-- **(B) read on `S`: `S λ = -2 λ`.** Symmetry in the pair indices is consumed exactly here,
the two orders of a mixed pair carry the two eigenvalues of (B)'s sum. -/
theorem rowMat_moment (h : RowCalculus n lam T) (a : ι) :
    ∑ b, rowMat T a b * lam b = -2 * lam a := by
  have e1 : ∑ b, ∑ c, T a b c * (lam b + lam c)
      = (∑ b, ∑ c, T a b c * lam b) + (∑ b, ∑ c, T a b c * lam c) := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun c _ => by ring
  have e2 : (∑ b, ∑ c, T a b c * lam b) = ∑ b, rowMat T a b * lam b := by
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [rowMat, Finset.sum_mul]
  have e3 : (∑ b, ∑ c, T a b c * lam c) = ∑ b, rowMat T a b * lam b := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [rowMat, Finset.sum_mul]
    exact Finset.sum_congr rfl fun b _ => by rw [h.pairSymm a c b]
  have hb := h.bianchi a
  rw [e1, e2, e3] at hb
  linarith

section Extremes

variable [Nonempty ι]

/-- `λ_max`, the largest eigenvalue. -/
noncomputable def lamMax (lam : ι → ℝ) : ℝ := Finset.univ.sup' Finset.univ_nonempty lam

/-- `λ_min`, the smallest eigenvalue. -/
noncomputable def lamMin (lam : ι → ℝ) : ℝ := Finset.univ.inf' Finset.univ_nonempty lam

theorem le_lamMax (lam : ι → ℝ) (b : ι) : lam b ≤ lamMax lam :=
  Finset.le_sup' lam (Finset.mem_univ b)

theorem lamMin_le (lam : ι → ℝ) (b : ι) : lamMin lam ≤ lam b :=
  Finset.inf'_le lam (Finset.mem_univ b)

theorem exists_lamMax (lam : ι → ℝ) : ∃ a, lam a = lamMax lam := by
  obtain ⟨a, _, ha⟩ := Finset.exists_mem_eq_sup' Finset.univ_nonempty lam
  exact ⟨a, ha.symm⟩

theorem exists_lamMin (lam : ι → ℝ) : ∃ a, lam a = lamMin lam := by
  obtain ⟨a, _, ha⟩ := Finset.exists_mem_eq_inf' Finset.univ_nonempty lam
  exact ⟨a, ha.symm⟩

/-- The row average of the spectrum against `S`'s row, bounded above by `λ_max`. -/
theorem row_le (h : RowCalculus n lam T) (a : ι) :
    ∑ b, rowMat T a b * lam b ≤ 2 * ((n : ℝ) - 2) * lamMax lam := by
  have : ∑ b, rowMat T a b * lam b ≤ ∑ b, rowMat T a b * lamMax lam :=
    Finset.sum_le_sum fun b _ =>
      mul_le_mul_of_nonneg_left (le_lamMax lam b) (rowMat_nonneg h a b)
  rwa [← Finset.sum_mul, rowMat_sum h a] at this

/-- The same average, bounded below by `λ_min`. -/
theorem le_row (h : RowCalculus n lam T) (a : ι) :
    2 * ((n : ℝ) - 2) * lamMin lam ≤ ∑ b, rowMat T a b * lam b := by
  have : ∑ b, rowMat T a b * lamMin lam ≤ ∑ b, rowMat T a b * lam b :=
    Finset.sum_le_sum fun b _ =>
      mul_le_mul_of_nonneg_left (lamMin_le lam b) (rowMat_nonneg h a b)
  rwa [← Finset.sum_mul, rowMat_sum h a] at this

/-- **L73, the two-sided form: `-(n-2) λ_max ≤ λ_a ≤ (n-2) (-λ_min)` at every index `a`.**

This is the record's display, with `|λ_min|` written as `-λ_min`; `neg_lamMin_eq_abs` below
identifies the two, from `λ_min ≤ 0`. -/
theorem two_sided (h : RowCalculus n lam T) (a : ι) :
    -((n : ℝ) - 2) * lamMax lam ≤ lam a ∧ lam a ≤ ((n : ℝ) - 2) * (-lamMin lam) := by
  have hu := row_le h a
  have hl := le_row h a
  rw [rowMat_moment h a] at hu hl
  constructor <;> nlinarith [hu, hl]

/-- **`λ_min ≤ 0`, from (A) and (B) alone.** If every eigenvalue were positive the row average
would be nonnegative while (B) makes it `-2 λ_min < 0`. The record leaves this to tracelessness. -/
theorem lamMin_nonpos (h : RowCalculus n lam T) : lamMin lam ≤ 0 := by
  by_contra hpos
  push_neg at hpos
  obtain ⟨a, ha⟩ := exists_lamMin (lam := lam)
  have hsum : 0 ≤ ∑ b, rowMat T a b * lam b :=
    Finset.sum_nonneg fun b _ =>
      mul_nonneg (rowMat_nonneg h a b) (le_trans hpos.le (lamMin_le lam b))
  rw [rowMat_moment h a, ha] at hsum
  linarith

/-- **`0 ≤ λ_max`, by the mirror argument.** -/
theorem lamMax_nonneg (h : RowCalculus n lam T) : 0 ≤ lamMax lam := by
  by_contra hneg
  push_neg at hneg
  obtain ⟨a, ha⟩ := exists_lamMax (lam := lam)
  have hsum : ∑ b, rowMat T a b * lam b ≤ 0 :=
    Finset.sum_nonpos fun b _ =>
      mul_nonpos_of_nonneg_of_nonpos (rowMat_nonneg h a b)
        (le_trans (le_lamMax lam b) hneg.le)
  rw [rowMat_moment h a, ha] at hsum
  linarith

/-- `|λ_min| = -λ_min`, which is what lets the record write the bound with an absolute value. -/
theorem neg_lamMin_eq_abs (h : RowCalculus n lam T) : |lamMin lam| = -lamMin lam :=
  abs_of_nonpos (lamMin_nonpos h)

/-- **L73's first equivalent form: `λ_max ≤ (n-2) |λ_min|`.** -/
theorem lamMax_le (h : RowCalculus n lam T) :
    lamMax lam ≤ ((n : ℝ) - 2) * |lamMin lam| := by
  obtain ⟨a, ha⟩ := exists_lamMax (lam := lam)
  rw [neg_lamMin_eq_abs h, ← ha]
  exact (two_sided h a).2

/-- **L73's second equivalent form: `|λ_min| ≤ (n-2) λ_max`.** -/
theorem abs_lamMin_le (h : RowCalculus n lam T) :
    |lamMin lam| ≤ ((n : ℝ) - 2) * lamMax lam := by
  obtain ⟨a, ha⟩ := exists_lamMin (lam := lam)
  rw [neg_lamMin_eq_abs h]
  have := (two_sided h a).1
  rw [ha] at this
  linarith

/-! ## "It is not implied by tracelessness"

*The record's second sentence: tracelessness alone gives the same shape with `N-1` in place of
`n-2`, and `N-1` is strictly the larger constant at every `n ≥ 3`, so it is strictly weaker.* -/

/-- **What tracelessness alone gives: `λ_a ≤ (N-1) |λ_min|`, with `N = card ι`.** -/
theorem traceless_le (hlam : ∑ b, lam b = 0) (a : ι) :
    lam a ≤ ((Fintype.card ι : ℝ) - 1) * (-lamMin lam) := by
  have hsplit : lam a + ∑ b ∈ Finset.univ.erase a, lam b = 0 := by
    rw [Finset.add_sum_erase _ lam (Finset.mem_univ a)]; exact hlam
  have hge : ((Finset.univ.erase a).card : ℝ) * lamMin lam
      ≤ ∑ b ∈ Finset.univ.erase a, lam b := by
    have := Finset.card_nsmul_le_sum (Finset.univ.erase a) lam (lamMin lam)
      (fun b _ => lamMin_le lam b)
    simpa [nsmul_eq_mul] using this
  have h1 : 1 ≤ Fintype.card ι := Fintype.card_pos
  have hcard : ((Finset.univ.erase a).card : ℝ) = (Fintype.card ι : ℝ) - 1 := by
    rw [Finset.card_erase_of_mem (Finset.mem_univ a), Finset.card_univ,
      Nat.cast_sub h1, Nat.cast_one]
  rw [hcard] at hge
  linarith

end Extremes

/-- **And `N - 1` is the strictly larger constant at every `n ≥ 3`**, with `N = n(n-1)/2`, so the
tracelessness bound is strictly weaker than L73. -/
theorem killing_constant_lt_traceless_constant {x : ℝ} (hx : 3 ≤ x) :
    x - 2 < x * (x - 1) / 2 - 1 := by nlinarith

/-! ## A witness, so the hypotheses are not empty

*Two indices, `n = 3`, spectrum `(1,-1)`, and `T a b c = 2` exactly when `b = c ≠ a`. Every field
of `RowCalculus` holds and the bound is attained: `λ_max = 1 = (n-2)|λ_min|`.*

**This is a witness for the hypotheses as stated, not a Weyl tensor**, the array is supported on
repeated pair indices, which a genuine bracket array is not. The record's saturating witness is
`S² × S^{n-2}`, which this file cannot construct. -/

/-- The witness array. -/
noncomputable def witT : Fin 2 → Fin 2 → Fin 2 → ℝ :=
  fun a b c => if b = c ∧ b ≠ a then (2 : ℝ) else 0

/-- The witness spectrum. -/
def witLam : Fin 2 → ℝ := ![1, -1]

/-- **The hypotheses are satisfiable at `n = 3`.** -/
theorem witness : RowCalculus 3 witLam witT := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro a b c; unfold witT; split <;> norm_num
  · intro a b c
    unfold witT
    by_cases h : b = c
    · subst h; simp
    · have h' : ¬ (c = b) := fun hc => h hc.symm
      simp [h, h']
  · intro a
    fin_cases a <;>
      simp [witT, Fin.sum_univ_two] <;> norm_num
  · intro a
    fin_cases a <;>
      simp [witT, witLam, Fin.sum_univ_two] <;> norm_num

/-- **The witness saturates the bound**: `λ_max = 1` and `(n-2)|λ_min| = 1`. -/
theorem witness_saturates :
    lamMax witLam = ((3 : ℝ) - 2) * |lamMin witLam| := by
  have hmax : lamMax witLam = 1 := by
    refine le_antisymm (Finset.sup'_le _ _ fun b _ => ?_) ?_
    · fin_cases b <;> simp [witLam] <;> norm_num
    · have := le_lamMax witLam (0 : Fin 2)
      simpa [witLam] using this
  have hmin : lamMin witLam = -1 := by
    refine le_antisymm ?_ (Finset.le_inf' _ _ fun b _ => ?_)
    · have := lamMin_le witLam (1 : Fin 2)
      simpa [witLam] using this
    · fin_cases b <;> simp [witLam] <;> norm_num
  rw [hmax, hmin]
  norm_num

end HamiltonsCubic.L73Statement
