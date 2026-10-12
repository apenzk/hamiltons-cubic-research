# Brief, round L67

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict on this result is included.**

## Passage A, the result's block, statement and proof ([findings/bispectral.md](../findings/bispectral.md) lines 505 and 509-522)

#### Lemma L67, the second-kind spectrum of the balanced product

**Statement.** Let $m\ge2$, $n=2m$, and let $W$ be the Weyl tensor of $S^m\times S^m$, normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by [Lemma L50](../findings/bispectral.md#lemma-l50-the-potential-is-a-function-of-two-spectra-and-collapses-to-one-only-below-dimension-six-canonical-statement-and-proof)'s norm relation. With $R_{ijij}$ the sectional curvature and $\mathring W$ in Li's $iklj$ order ([conventions.md](../findings/conventions.md)), $\mathring W$ on $S^2_0$ has exactly three eigenvalues: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ with multiplicity $1$, where
$$A=\frac1{m\sqrt{(m-1)(2m-1)}}>0 .$$
At $m=1$ the product is flat and $W=0$.

**Proof.** Let $P_1,P_2$ be the orthogonal projections of $\mathbb R^{2m}$ onto the two factors, $G^{(a)}_{ijkl}=(P_a)_{ik}(P_a)_{jl}-(P_a)_{il}(P_a)_{jk}$ the curvature tensor of the unit sphere on factor $a$, and $G$ the same with $P_a$ replaced by the identity. Then $R=G^{(1)}+G^{(2)}$ is the curvature of the unit product, with Ricci tensor $(m-1)I$, and $W=R-cG$ with $c=\frac{m-1}{2m-1}$, since $G$ has Ricci tensor $(2m-1)I$. For $h\in S^2_0$ and $t_a=\operatorname{tr}(P_ah)$, the $iklj$ contraction gives $\mathring G^{(a)}h=P_ahP_a-t_aP_a$ and $\mathring Gh=h$, so
$$\mathring Wh=P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-ch .$$
It has three invariant summands, which together fill $S^2_0$ since $(m-1)(m+2)+m^2+1=2m^2+m-1=\dim S^2_0$.
- *The trace-free parts within each factor*, $h=P_ahP_a$ with $t_a=0$: $\mathring Wh=(1-c)h=\frac m{2m-1}h$, multiplicity $2\big(\binom{m+1}2-1\big)=(m-1)(m+2)$.
- *The cross block*, $h=P_1hP_2+P_2hP_1$: every term but the last vanishes, so $\mathring Wh=-\frac{m-1}{2m-1}h$, multiplicity $m^2$.
- *The line* $h=P_1-P_2$, with $t_1=m$ and $t_2=-m$: $\mathring Wh=(1-m-c)h=-\frac{2m(m-1)}{2m-1}h$, multiplicity $1$.

The unnormalised sum of squares is $\frac{m^2(m-1)}{(2m-1)^2}\big((m+2)+(m-1)+4(m-1)\big)=\frac{3m^2(m-1)}{2m-1}$, so the positive scale $s=\sqrt{(2m-1)/(m^2(m-1))}$ gives $\sum\omega^2=3$, and the eigenvalues become $mA$, $-(m-1)A$ and $-2m(m-1)A$ with $A=s/(2m-1)$. $\square$

*Li's Theorem 1.8 gives the same spectrum as a product rule, in the section on the maximiser's position in the bi-spectral plane above.*

## Passage B, the canonical statement ([results.md](../results.md) line 349, landscape, and lines 1167 and 1169, detail)

- **Lemma L67 (second-order). The second-kind spectrum of the balanced product.** At $S^m\times S^m$, $n=2m$, $m\ge2$, normalised to $\lVert W\rVert_F=1$, the second-kind operator $\mathring W$ in Li's $iklj$ order has exactly three eigenvalues: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ with multiplicity $1$, where $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$. Li's Theorem 1.8 gives the same spectrum as a product rule.

##### Lemma L67, the second-kind spectrum of the balanced product

Let $m\ge2$ and let $W$ be the Weyl tensor of $S^m\times S^m$ with $n=2m$, normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation, and let $\mathring W$ be its second-kind operator on $S^2_0$ in Li's $iklj$ order, with $R_{ijij}$ the sectional curvature. Then $\mathring W$ has exactly three eigenvalues: $mA$ on the trace-free parts within each factor, multiplicity $(m-1)(m+2)$; $-(m-1)A$ on the cross block, multiplicity $m^2$; and $-2m(m-1)A$ on $P_1-P_2$, multiplicity $1$; where $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$. The multiplicities sum to $\dim S^2_0=2m^2+m-1$. The proof substitutes $W=G^{(1)}+G^{(2)}-\frac{m-1}{2m-1}G$ into the operator, and Li's Theorem 1.8 gives the same spectrum as a product rule. The $\Lambda^2$ spectrum at the same point gives $p_3(\mu)=A$, and with Lemma L50 the two spectra return $\theta=\theta_0(2m)$ identically in $m$.

## Passage C, Lemma L50's statement, a given, with the debts its own block records ([findings/bispectral.md](../findings/bispectral.md) lines 133-139)

**Statement.** Let $W\in\mathrm{Weyl}_n$ act on $\Lambda^2\mathbb R^n$ as $M$, with $\lVert M\rVert_F=1$ and spectrum $\mu$. Let $\mathring W$ be the curvature operator of the second kind on trace-free symmetric $2$-tensors, $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$, with spectrum $\omega$. Then

$$\theta=\langle W,Q(W)\rangle=\tfrac32\,p_3(\mu)-\tfrac12\,p_3(\omega),\qquad \sum\mu=\sum\omega=0,\quad\sum\mu^2=1,\quad\sum\omega^2=3 .$$

The index order $iklj$ is Li's and is load-bearing: the order $ikjl$ negates $\mathring W$ and the second coefficient.

**Two links carry this lemma and neither is derived on the record.** **(a) $\beta=2\langle M^\#,M\rangle$** (the step the block calls new), has no derivation anywhere: Gate 2 proved the $\alpha$ half and confirmed this one at $10^{-16}$ over samples, and the pointer to the mathematics leads to a file that no longer carries it. *The whole coefficient pair is that constant: with $\beta=c\sigma$ the identity reads $\tfrac{2+c}{c}p_3(\mu)-\tfrac1cp_3(\omega)$.* **(b) the generalised-Kronecker display's proportionality**, whose source has no entry in [references/](../references), an unread source, and the whole $n\le5$ collapse rests on it. **And "only there" has no argument at all**: the delta's non-vanishing at $n\ge6$ says nothing about the Weyl cubic, and nothing on file reaches $n\ge10$.

## Passage D, the evaluation at the balanced product in the same file ([findings/bispectral.md](../findings/bispectral.md) lines 174-198)

#### Proved symbolically in $m$; the literature input is [Li 2022 Thm 1.8](../references/li-2022-product-manifolds-second-kind/README.md)

For an Einstein product, $\mathrm{spec}(\mathring R)=\mathrm{spec}(\mathring R_1)\cup\mathrm{spec}(\mathring R_2)\cup\{0^{(n_1n_2)}\}\cup\{-\tfrac{n_1\rho_2+n_2\rho_1}{n_1+n_2}\}$, verified here to $1.8\times10^{-15}$ on six sphere products built from true metrics rather than from the vertex matrix ([run_li_thm18_check.py](../scripts/runs/run_li_thm18_check.py)).

Specialising to the balanced $S^m\times S^m$ at $n=2m$ and subtracting the multiple $\frac{m-1}{2m-1}G$ of the round curvature tensor to reach the Weyl tensor, the $\omega$-spectrum is three values, derived directly in Lemma L67 below:

| eigenvalue of $\mathring W$ | multiplicity |
|---|---|
| $mA$ | $(m-1)(m+2)$ |
| $-(m-1)A$ | $m^2$ |
| $-2m(m-1)A$ | $1$ |

with $A=\dfrac1{m\sqrt{(m-1)(2m-1)}}$. The multiplicities sum to $2m^2+m-1=\dim S^2_0(\mathbb R^{2m})$, and $\sum\omega=0$, $\sum\omega^2=3$ identically, the normalisation the identity requires. Hence

$$p_3(\mu)=\frac1{m\sqrt{(m-1)(2m-1)}},\qquad p_3(\omega)=-\frac{4m^2-6m-1}{m\sqrt{(m-1)(2m-1)}} .$$

*The $\Lambda^2$ side.* $R$ acts on $\Lambda^2$ as the identity on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$ and as $0$ on the mixed part, so $W=R-c\,\mathrm{Id}$ has eigenvalues $\frac m{2m-1}$ at multiplicity $m(m-1)$ and $-\frac{m-1}{2m-1}$ at multiplicity $m^2$. Their unnormalised sum of squares is $\frac{m^2(m-1)}{2m-1}$, a third of the $\omega$ one, so the same scale $s$ normalises both, and $p_3(\mu)=s^3\frac{m^3\cdot m(m-1)-(m-1)^3m^2}{(2m-1)^3}=s^3\frac{m^2(m-1)}{(2m-1)^2}=A$.

#### $A$ is not a new constant

it equals the record's $\operatorname{tr}(W^3)=2\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)$ at the balanced product, checked to be identically zero difference. And the identity closes symbolically,

$$\tfrac32p_3(\mu)-\tfrac12p_3(\omega)-\theta_0(2m)=0\quad\text{identically in }m,$$

the residual radical resolving as $\sqrt{4m^4-12m^3+13m^2-6m+1}=2m^2-3m+1$ ([run_maximiser_closed_form.py](../scripts/runs/run_maximiser_closed_form.py)).

## Passage E, the index convention ([findings/conventions.md](../findings/conventions.md) lines 96-108)

## The second-kind operator, and the index order, SETTLED on Li's $iklj$

$\mathring W$ acts on $S^2_0$, and **the index order is load-bearing**: $W_{ikjl}$ in place of $W_{iklj}$ negates $\mathring W$ and flips the sign of the bi-spectral identity's $-\tfrac12$ term.

**The record's convention is Li's**, quoted from [Li 2021](../references/li-2021-nonnegative-second-kind/notes.md) §2, equation (2.2), on p. 6 of [arXiv:2112.08465](https://arxiv.org/abs/2112.08465) and again in the introduction on p. 2:

> The second one, denoted by $\mathring R:S^2(V)\to S^2(V)$, is defined by $\mathring R(e_i\odot e_j)=\sum_{k,l}R_{iklj}\,e_k\odot e_l$.

With $u\odot v=u\otimes v+v\otimes u$, so that $h=\tfrac12\sum_{i,j}h_{ij}\,e_i\odot e_j$, this is in matrix form

$$(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl},$$

the pair symmetries making the symmetrisation of the output automatic.

## Passage F, the Lean files, declarations with docstrings removed ([L67Statement.lean](../lean/HamiltonsCubic/Results/L67Statement.lean), [L67.lean](../lean/HamiltonsCubic/Results/L67.lean))

```lean
import Mathlib

set_option linter.style.longLine false

namespace HamiltonsCubic.L67Statement

open Real

noncomputable def Aconst (m : ℝ) : ℝ := 1 / (m * Real.sqrt ((m - 1) * (2 * m - 1)))

noncomputable def spec (m : ℝ) : Fin 3 → ℝ :=
  ![m * Aconst m, -(m - 1) * Aconst m, -2 * m * (m - 1) * Aconst m]

noncomputable def mult (m : ℝ) : Fin 3 → ℝ := ![(m - 1) * (m + 2), m ^ 2, 1]

theorem Aconst_pos {m : ℝ} (hm : 2 ≤ m) : 0 < Aconst m := by
  have hm0 : (0:ℝ) < m := by linarith
  have hrad : (0:ℝ) < (m - 1) * (2 * m - 1) := by nlinarith
  have hs : 0 < Real.sqrt ((m - 1) * (2 * m - 1)) := Real.sqrt_pos.mpr hrad
  unfold Aconst
  positivity

theorem Aconst_sq {m : ℝ} (hm : 2 ≤ m) :
    Aconst m ^ 2 = 1 / (m ^ 2 * ((m - 1) * (2 * m - 1))) := by
  have hm0 : (0:ℝ) < m := by linarith
  have hrad : (0:ℝ) < (m - 1) * (2 * m - 1) := by nlinarith
  have hsq : Real.sqrt ((m - 1) * (2 * m - 1)) ^ 2 = (m - 1) * (2 * m - 1) :=
    Real.sq_sqrt hrad.le
  have hs : Real.sqrt ((m - 1) * (2 * m - 1)) ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr hrad)
  unfold Aconst
  rw [div_pow, one_pow, mul_pow, hsq]

theorem mult_sum (m : ℝ) : ∑ i : Fin 3, mult m i = 2 * m ^ 2 + m - 1 := by
  simp [mult, Fin.sum_univ_three]; ring

theorem dim_sym_traceless (m : ℝ) : (2 * m) * (2 * m + 1) / 2 - 1 = 2 * m ^ 2 + m - 1 := by ring

theorem spec_trace_zero (m : ℝ) : ∑ i : Fin 3, mult m i * spec m i = 0 := by
  simp [mult, spec, Fin.sum_univ_three]; ring

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

theorem spec_strict_order {m : ℝ} (hm : 2 ≤ m) :
    spec m 2 < spec m 1 ∧ spec m 1 < spec m 0 := by
  have hA := Aconst_pos hm
  have hm1 : (0:ℝ) < m - 1 := by linarith
  have hkey : (0:ℝ) < (m - 1) * Aconst m * (2 * m - 1) := by
    have : (0:ℝ) < 2 * m - 1 := by linarith
    positivity
  constructor <;> simp [spec] <;> nlinarith [hkey, mul_pos hm1 hA]

theorem mult_pos {m : ℝ} (hm : 2 ≤ m) : ∀ i : Fin 3, 0 < mult m i := by
  intro i
  fin_cases i <;> simp [mult] <;> nlinarith

example : ∑ i : Fin 3, mult 1 i = 2 * (1:ℝ) ^ 2 + 1 - 1 := mult_sum 1

example : Aconst 1 = 0 := by unfold Aconst; norm_num

example :
    mult 2 0 = 4 ∧ mult 2 1 = 4 ∧ mult 2 2 = 1 ∧
      (∑ i : Fin 3, mult (2:ℝ) i) = 9 ∧
      (∑ i : Fin 3, mult (2:ℝ) i * spec 2 i) = 0 ∧
      (∑ i : Fin 3, mult (2:ℝ) i * spec 2 i ^ 2) = 3 := by
  refine ⟨by norm_num [mult], by norm_num [mult], by simp [mult], ?_,
    spec_trace_zero 2, spec_normalisation (by norm_num)⟩
  rw [mult_sum]; norm_num

end HamiltonsCubic.L67Statement
```

```lean
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.LinearCombination

namespace HamiltonsCubic.SecondKind

theorem multiplicities_sum (m : ℚ) :
    (m - 1) * (m + 2) + m ^ 2 + 1 = 2 * m ^ 2 + m - 1 := by ring

theorem dim_S2_zero (m : ℚ) : 2 * m * (2 * m + 1) / 2 - 1 = 2 * m ^ 2 + m - 1 := by ring

theorem spectrum_traceless (m A : ℚ) :
    (m - 1) * (m + 2) * (m * A) + m ^ 2 * (-((m - 1) * A))
      + 1 * (-(2 * m * (m - 1) * A)) = 0 := by ring

theorem sum_squares (m A : ℚ) :
    (m - 1) * (m + 2) * (m * A) ^ 2 + m ^ 2 * ((m - 1) * A) ^ 2
      + 1 * (2 * m * (m - 1) * A) ^ 2
      = 3 * m ^ 2 * (m - 1) * (2 * m - 1) * A ^ 2 := by ring

theorem A_from_omega (m A : ℚ) (hm : 2 ≤ m)
    (hnorm : 3 * m ^ 2 * (m - 1) * (2 * m - 1) * A ^ 2 = 3) :
    A ^ 2 * (m ^ 2 * (m - 1) * (2 * m - 1)) = 1 := by
  linear_combination hnorm / 3

theorem A_closed_form (m : ℚ) (hm : 2 ≤ m) :
    (1 / (m ^ 2 * ((m - 1) * (2 * m - 1)))) * (m ^ 2 * (m - 1) * (2 * m - 1)) = 1 := by
  have h0 : m ≠ 0 := by intro h; linarith
  have h1 : m - 1 ≠ 0 := by intro h; linarith
  have h2 : 2 * m - 1 ≠ 0 := by intro h; linarith
  have hX : m ^ 2 * ((m - 1) * (2 * m - 1)) = m ^ 2 * (m - 1) * (2 * m - 1) := by ring
  have hne : m ^ 2 * (m - 1) * (2 * m - 1) ≠ 0 :=
    mul_ne_zero (mul_ne_zero (pow_ne_zero 2 h0) h1) h2
  rw [hX]
  exact one_div_mul_cancel hne

theorem multiplicities_at_one : (1 - 1 : ℚ) * (1 + 2) + 1 ^ 2 + 1 = 2 * 1 ^ 2 + 1 - 1 := by
  norm_num

theorem A_denominator_vanishes : (1 : ℚ) ^ 2 * (1 - 1) * (2 * 1 - 1) = 0 := by norm_num

theorem A_sq_at_three : (1 : ℚ) / (3 ^ 2 * ((3 - 1) * (2 * 3 - 1))) = 1 / 90 := by norm_num

theorem B_block_sq : (2 : ℚ) ^ 2 * (1 / 90) = 2 / 45 := by norm_num

theorem B_block_bracket :
    ((210818510 : ℚ) / 1000000000) ^ 2 < 2 / 45
      ∧ (2 : ℚ) / 45 < ((210818512 : ℚ) / 1000000000) ^ 2 := by
  constructor <;> norm_num

theorem bottom_sq_at_three : (12 : ℚ) ^ 2 * (1 / 90) = 8 / 5 := by norm_num

end HamiltonsCubic.SecondKind
```

## Definitions

- $S^2_0$ is the space of trace-free symmetric $n\times n$ matrices, $p_3$ the sum of cubes of a spectrum, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.
- A 4-tensor $W$ acts on $\Lambda^2\mathbb R^n$ as the operator $M$. The passages use both $\lVert W\rVert_F$ and $\lVert M\rVert_F$, and fix no relation between them beyond what they state.
- **This loop does no numerical work.** A claim supported only by a run is `HYPOTHESIS-DEBT`. Screening a claim by hand on an object you construct is allowed, and is reported as a screen, never as evidence for a positive claim.

## What to attack, beyond the standing list

1. **The normalisation.** Passage A normalises $\lVert W\rVert_F=1$ and calls it $\sum\omega^2=3$ by Lemma L50's norm relation, which Passage C states for $\lVert M\rVert_F=1$. Whether these are one condition, under which convention for $\lVert W\rVert_F$ and for the action on $\Lambda^2$, and whether the scale $s$ in the proof meets the condition the statement names.
2. **The curvature of the product**: $R=G^{(1)}+G^{(2)}$, its Ricci tensor $(m-1)I$, $G$'s $(2m-1)I$, $c=\frac{m-1}{2m-1}$, and that $W=R-cG$ is the Weyl tensor.
3. **The contraction in Li's $iklj$ order**: $\mathring G^{(a)}h=P_ahP_a-t_aP_a$ and $\mathring Gh=h$ on $S^2_0$, with the signs fixed by Passage E and by $R_{ijij}$ being the sectional curvature.
4. **The three summands**: each eigenvalue computation, invariance, orthogonality, and that the dimensions fill $S^2_0$.
5. **The scale and $A$**: the unnormalised sum of squares, $s$, $A=s/(2m-1)$, and $A>0$.
6. **$m\ge2$**, and "at $m=1$ the product is flat and $W=0$".
7. **Passage B against Passage A**: every clause, the placement of each eigenvalue on its summand, and "Li's Theorem 1.8 gives the same spectrum as a product rule". For that sentence you may read references/li-2022-product-manifolds-second-kind/ at source, its PDF or text only.
8. **Passage B's further claims**: that the $\Lambda^2$ spectrum gives $p_3(\mu)=A$, and that with Lemma L50 the two spectra return $\theta=\theta_0(2m)$ identically in $m$. Check Passage D's $\Lambda^2$ eigenvalues and multiplicities, "the same scale $s$ normalises both", $p_3(\omega)$, and the closing identity with its radical, and say which of Lemma L50's recorded links the $\theta$ claim uses.
9. **Passage D's "$A$ is not a new constant"** against a closed form it quotes.
10. **Passage F against Passage A**: what each declaration states and what of the lemma is and is not typed.
11. **The boundary**: $m=2$, where $n=4$, a zero eigenvalue of $\mathring W$ or of $M$ at any $m\ge2$, and the $ikjl$ order in place of $iklj$.
