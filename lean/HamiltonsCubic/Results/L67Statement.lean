import Mathlib

set_option linter.style.longLine false

/-!
# L67, the second-kind spectrum of the balanced product

## The record's statement, verbatim

[bispectral.md](../../../findings/bispectral.md)'s *Lemma L67, the second-kind spectrum of the
balanced product*:

> Let $m\ge2$, $n=2m$, and let $W$ be the Weyl tensor of $S^m\times S^m$, normalised to
> $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation. With $R_{ijij}$ the
> sectional curvature and $\mathring W$ in Li's $iklj$ order, $\mathring W$ on $S^2_0$ has exactly
> three eigenvalues: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and
> $-2m(m-1)A$ with multiplicity $1$, where $$A=\frac1{m\sqrt{(m-1)(2m-1)}}>0 .$$

and, from its proof, the multiplicity total
$(m-1)(m+2)+m^2+1=2m^2+m-1=\dim S^2_0$ and the normalisation $\sum\omega^2=3$ that fixes $A$.

## What is NOT typed here

**The identification of the three values with the eigenvalues of `ringW` at `Sᵐ × Sᵐ`.** That is
the lemma's geometric clause, and it needs the curvature operator of the second kind on
trace-free symmetric `2`-tensors in Li's convention `(W̊h)_{ij} = Σ_{k,l} W_{iklj} h_{kl}`, the
Weyl tensor of a product of round spheres, and the `O(m)×O(m)`-invariant splitting
`S²₀ = (two within-factor trace-free parts) ⊕ (cross block) ⊕ ℝ(P₁ - P₂)` the block's proof
runs through. The real Weyl layer ([WeylReal.lean](../Base/WeylReal.lean)) carries `IsWeyl`,
`Qop`, `IsCritical`, `Pcubic` and `theta`, and neither the second-kind operator nor the sphere
product family, so none of that can be named. **So the theorem below is about the tabulated
spectrum as a list of values with multiplicities, and not about `W̊`.**

**Consequently the file states a fragment of L67 and says so.** What is typed is every
constraint the block puts on that list, the constant `A`, its sign, the multiplicity total, the
tracelessness, the normalisation that pins `A`, and the ordering that identifies the bottom
eigenvalue, and what is missing is that the list is the spectrum.

## Convention

`‖W‖_F = 1` in the `Λ²` normalisation of [bispectral.md](../../../findings/bispectral.md), where
`Σμ² = 1` on `Λ²` and `Σω² = 3` on `S²₀`, the factor `|W|² = 4‖M‖_F²` being what converts the
source's `¾|W|²`. **`Σω² = 3` is the constraint that pins `A` here**: the second-kind spectrum is
what this lemma tabulates, and the first-kind normalisation `Σμ² = 1` is a different sum over a
different space.
-/

namespace HamiltonsCubic.L67Statement

open Real

/-! ## The constant and the spectrum -/

/-- **`A = 1/(m√((m−1)(2m−1)))`**, in the record's `iklj` index order, where it is positive. -/
noncomputable def Aconst (m : ℝ) : ℝ := 1 / (m * Real.sqrt ((m - 1) * (2 * m - 1)))

/-- **The three eigenvalues**, in the block's order: `mA`, `−(m−1)A`, `−2m(m−1)A`. -/
noncomputable def spec (m : ℝ) : Fin 3 → ℝ :=
  ![m * Aconst m, -(m - 1) * Aconst m, -2 * m * (m - 1) * Aconst m]

/-- **The three multiplicities**: `(m−1)(m+2)`, `m²`, `1`. -/
noncomputable def mult (m : ℝ) : Fin 3 → ℝ := ![(m - 1) * (m + 2), m ^ 2, 1]

/-! ## `A` is positive, and `A²` is what the normalisation fixes -/

/-- **`A > 0` at `m ≥ 2`.** *The normalisation fixes `A²`; the sign is the index order, and with
the record's `iklj` order it is `+`.* -/
theorem Aconst_pos {m : ℝ} (hm : 2 ≤ m) : 0 < Aconst m := by
  have hm0 : (0:ℝ) < m := by linarith
  have hrad : (0:ℝ) < (m - 1) * (2 * m - 1) := by nlinarith
  have hs : 0 < Real.sqrt ((m - 1) * (2 * m - 1)) := Real.sqrt_pos.mpr hrad
  unfold Aconst
  positivity

/-- **`A² = 1/(m²(m−1)(2m−1))`**, the quantity the normalisation actually determines. -/
theorem Aconst_sq {m : ℝ} (hm : 2 ≤ m) :
    Aconst m ^ 2 = 1 / (m ^ 2 * ((m - 1) * (2 * m - 1))) := by
  have hm0 : (0:ℝ) < m := by linarith
  have hrad : (0:ℝ) < (m - 1) * (2 * m - 1) := by nlinarith
  have hsq : Real.sqrt ((m - 1) * (2 * m - 1)) ^ 2 = (m - 1) * (2 * m - 1) :=
    Real.sq_sqrt hrad.le
  have hs : Real.sqrt ((m - 1) * (2 * m - 1)) ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr hrad)
  unfold Aconst
  rw [div_pow, one_pow, mul_pow, hsq]

/-! ## The three checks the block records -/

/-- **The multiplicities sum to `dim S²₀(ℝ^{2m}) = 2m² + m − 1`**, identically in `m`. *The
identity is polynomial, so it holds at `m = 1` too, which is why the cheapest check cannot
supply the hypothesis `m ≥ 2`.* -/
theorem mult_sum (m : ℝ) : ∑ i : Fin 3, mult m i = 2 * m ^ 2 + m - 1 := by
  simp [mult, Fin.sum_univ_three]; ring

/-- **`dim S²₀(ℝⁿ) = n(n+1)/2 − 1` reads `2m² + m − 1` at `n = 2m`.** -/
theorem dim_sym_traceless (m : ℝ) : (2 * m) * (2 * m + 1) / 2 - 1 = 2 * m ^ 2 + m - 1 := by ring

/-- **The spectrum is traceless**, `tr W̊ = 0`, a joint condition on eigenvalues and
multiplicities that the block never uses. -/
theorem spec_trace_zero (m : ℝ) : ∑ i : Fin 3, mult m i * spec m i = 0 := by
  simp [mult, spec, Fin.sum_univ_three]; ring

/-- **`Σω² = 3` PINS `A`.** Summing the squares of the tabulated spectrum gives
`A²·3m²(m−1)(2m−1)`, so the normalisation returns exactly `A² = 1/(m²(m−1)(2m−1))`. -/
theorem spec_normalisation {m : ℝ} (hm : 2 ≤ m) : ∑ i : Fin 3, mult m i * spec m i ^ 2 = 3 := by
  have hm0 : (0:ℝ) < m := by linarith
  have hm1 : (0:ℝ) < m - 1 := by linarith
  have hm2 : (0:ℝ) < 2 * m - 1 := by linarith
  have hA := Aconst_sq hm
  have hne0 : m ≠ 0 := ne_of_gt hm0
  have hne1 : m - 1 ≠ 0 := ne_of_gt hm1
  have hne2 : 2 * m - 1 ≠ 0 := ne_of_gt hm2
  have hsum : ∑ i : Fin 3, mult m i * spec m i ^ 2
      = Aconst m ^ 2 * (3 * m ^ 2 * ((m - 1) * (2 * m - 1))) := by
    simp [mult, spec, Fin.sum_univ_three, mul_pow]; ring
  have hDpos : (0:ℝ) < m ^ 2 * ((m - 1) * (2 * m - 1)) :=
    mul_pos (pow_pos hm0 2) (mul_pos hm1 hm2)
  have hD : m ^ 2 * ((m - 1) * (2 * m - 1)) ≠ 0 := ne_of_gt hDpos
  rw [hsum, hA, show (3:ℝ) * m ^ 2 * ((m - 1) * (2 * m - 1))
        = 3 * (m ^ 2 * ((m - 1) * (2 * m - 1))) from by ring,
    div_mul_eq_mul_div, one_mul, mul_div_assoc, div_self hD, mul_one]

/-! ## The ordering, and the bottom eigenvalue

*"A reader of the canon could not previously conclude that the bottom eigenvalue is
`−2m(m−1)A`"*, so it is stated. -/

/-- **The three values are strictly ordered**, `−2m(m−1)A < −(m−1)A < mA`, at `m ≥ 2`. So the
bottom of the spectrum is `−2m(m−1)A` and the top is `mA`. -/
theorem spec_strict_order {m : ℝ} (hm : 2 ≤ m) :
    spec m 2 < spec m 1 ∧ spec m 1 < spec m 0 := by
  have hA := Aconst_pos hm
  have hm1 : (0:ℝ) < m - 1 := by linarith
  have hkey : (0:ℝ) < (m - 1) * Aconst m * (2 * m - 1) := by
    have : (0:ℝ) < 2 * m - 1 := by linarith
    positivity
  constructor <;> simp [spec] <;> nlinarith [hkey, mul_pos hm1 hA]

/-- **The multiplicities are positive at `m ≥ 2`**, so all three values really occur, the
clause `m ≥ 2` is doing work here as well: at `m = 1` the first multiplicity is `0`. -/
theorem mult_pos {m : ℝ} (hm : 2 ≤ m) : ∀ i : Fin 3, 0 < mult m i := by
  intro i
  fin_cases i <;> simp [mult] <;> nlinarith

/-! ## The hypothesis `m ≥ 2`, and what fails without it

*"The multiplicity identity is a polynomial identity and holds vacuously at `m = 1`, so the
cheapest check cannot supply it."* -/

/-- **The multiplicity identity holds at `m = 1` as well**: `0 + 1 + 1 = 2 = 2·1 + 1 − 1`. So the
check that passes everywhere cannot be the source of the hypothesis. -/
example : ∑ i : Fin 3, mult 1 i = 2 * (1:ℝ) ^ 2 + 1 - 1 := mult_sum 1

/-- **What fails at `m = 1` is `A` itself**: the radicand `(m−1)(2m−1)` vanishes, so the
denominator of `A` is `0`. *The hypothesis is about the constant, not about the counts.* -/
example : Aconst 1 = 0 := by unfold Aconst; norm_num

/-! ## Non-vacuity

The smallest admissible case, `m = 2`, the balanced product `S² × S²` at `n = 4`. -/

/-- **A witness at `m = 2`**: `A = 1/(2√3)`, the multiplicities are `4, 4, 1` summing to `9`, the
spectrum is `(2A, −A, −4A)`, it is traceless and satisfies `Σω² = 3`. -/
example :
    mult 2 0 = 4 ∧ mult 2 1 = 4 ∧ mult 2 2 = 1 ∧
      (∑ i : Fin 3, mult (2:ℝ) i) = 9 ∧
      (∑ i : Fin 3, mult (2:ℝ) i * spec 2 i) = 0 ∧
      (∑ i : Fin 3, mult (2:ℝ) i * spec 2 i ^ 2) = 3 := by
  refine ⟨by norm_num [mult], by norm_num [mult], by simp [mult], ?_,
    spec_trace_zero 2, spec_normalisation (by norm_num)⟩
  rw [mult_sum]; norm_num

end HamiltonsCubic.L67Statement
