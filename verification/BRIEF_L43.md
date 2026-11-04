# Brief, round L43

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement as the findings file carries it ([findings/problem.md](../findings/problem.md) lines 594-608)

#### Lemma L43, the criterion at $a=0$ demands exactly $\theta_0(n)$

*The argument is in this file under **"The diagonal case: located in the literature, and it covers less than assumed"**.*

On the slice $R_{\mathrm{ric}_0}=0$ the invariance criterion at $a=0$ collapses with no residue to
\[
\langle W,Q(W)\rangle\;\le\;\theta_0(n)\,\|W\|^3,\qquad \theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}n .
\]

**The collapse is an identity on the whole slice, not merely a vanishing at the boundary.** $\lVert\mathrm{ric}(I)\rVert^2$ cancels between the criterion's $F$ and the pairing, and the $c^3(n-1)\lVert I\rVert^2$ term is common to both sides, leaving exactly $\langle W,Q(W)\rangle-c(n-1)\lVert W\rVert^2$ and nothing else.

**The constant is not imported.** The inputs are [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md)'s Lemma 2.1 and equation (6), Hamilton's scalar identity, [Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s cone, and $\lVert I\rVert^2=\binom n2$, **no sphere product enters at any step**, which is what makes $\theta_0(n)$ forced from outside the family it describes. And *exactly* holds in both halves: $\partial\Omega_0$ meets the slice at one ratio $c/\lVert W\rVert$, so each unit $W$ is tested against $\theta_0(n)$ and no other constant.

**The slice is the EINSTEIN one.** $R_{\mathrm{ric}_0}=0$ kills the trace-free Ricci part; Ricci-flatness would additionally need $c=0$, and there $\partial\Omega_0$ forces $\lVert W\rVert=0$, so **naming this the Ricci-flat slice states as hypothesis the one value $c$ cannot take.** *The cone also carries $\mathop{\mathrm{scal}}(R)>0$, which the printed $F$-sublevel set omits: $F$ is even in $R$, so without that clause the set is a double cone whose $c<0$ nappe reads $\langle W,Q(W)\rangle\le-\theta_0(n)\lVert W\rVert^3$, false at every sphere product. The clause is in the source's own definition and convexity forces it independently.* *Gate 2, [r523](../reviews/REVIEW_r523.md) and [r524](../reviews/REVIEW_r524.md) on identical briefs, both CONFIRMED, each rebuilding the collapse cold.*
So the constant of Problem P is what cone invariance requires, independently of any sphere product.

## Passage B, the canonical statement, landscape form ([results.md](../results.md) line 100)

- **Lemma L43. The invariance criterion at $a=0$ demands $\theta_0(n)$ and nothing weaker.** The cone bridge $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$ collapses Böhm–Wilking's criterion on $\Omega_0$ to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ with $c(n-1)=\theta_0(n)$ exactly. So the problem's constant is forced by the criterion, and the $a\to n/4$ end is Beitz's.

## Passage C, the canonical statement, detail form ([results.md](../results.md) lines 368-372)

##### Lemma L43, the invariance criterion at $a=0$ demands $\theta_0(n)$ and nothing weaker

Write $R=cI+W$ on the **Einstein** slice $R_{\mathrm{ric}_0}=0$, *Ricci-flatness is $c=0$, where the boundary forces $\lVert W\rVert=0$ and the statement is vacuous*, $F=\lVert R\rVert^2/\lVert\mathop{\mathrm{ric}}R\rVert^2$ and $\Omega_a=\{\mathop{\mathrm{scal}}(R)>0\}\cap F^{-1}((-\infty,\frac4{n-2+4a}])$. The quotient-rule expansion of the invariance condition uses $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$ and the $\lVert\mathop{\mathrm{ric}}\rVert^2$ identity, and at $a=0$ the whole condition collapses to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$, where $c(n-1)=\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. The cone has three endpoints; Beitz proves the degenerate end $a\to n/4$ for every $n$, and $n\ge12$ enters that end nowhere. The full symmetry of the cubic's trilinear form is a theorem rather than a hypothesis of the collapse. It does not reach $a$ strictly between $0$ and $n/4$; Lemma L45 gives the two-sided bound the criterion demands off the slice.

**Proof:** [problem.md](findings/problem.md)

## Passage D, the derivation Passage A points at ([findings/problem.md](../findings/problem.md) lines 32-70), under the heading at line 13, *"The diagonal case: located in the literature, and it covers less than assumed"*

**The Beitz thesis was also located, and is not the proof source.** Stine Franziska Beitz, PhD 2018 Münster (advisor Wilking), *Bianchi-convexity and applications to Ricci flow* ([full text](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf); chapters 1–4 as [arXiv:1902.09088](https://arxiv.org/abs/1902.09088)). It states the conjecture once, as Remark 6.3.15, in the *cone-invariance* formulation ("the cones $\Omega_a$ are invariant under the ODE for $a\in[0,\tfrac n4]$"), not the $P(W)$-maximization formulation, and never mentions sphere products, $\mathbb{CP}^2$, or diagonal Weyl operators. Its own contribution is a local Hessian computation near one boundary point, and *which* boundary point is the thing that matters, recorded here after the thesis was finally transcribed ([notes.md](../references/beitz-2018-bianchi-convexity/notes.md)).

**The cone family in decomposition form, and which end is hard.** The thesis (p. 96) shows $R\in\Omega_a$ is equivalent to

$$\frac{4a-n}4\lVert R_I\rVert^2+a\lVert R_{\mathrm{ric}_0}\rVert^2+\Big(\frac{n-2}4+a\Big)\lVert R_W\rVert^2\le0,$$

which pins the normalisation to $\lVert\mathrm{ric}(R)\rVert^2=\frac{n-1}2\lVert R_I\rVert^2+\frac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$. The two ends are utterly different:

| $a$ | $\Omega_a$ | |
|---|---|---|
| $>\frac n4$ | empty | |
| $=\frac n4$ | $\mathbb R_{>0}\cdot I$, **a single ray** | invariance is trivial, since $\Phi(I)=(n-1)I$ |
| $\to0$ | $\frac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$, with $R_{\mathrm{ric}_0}$ **unconstrained** | the whole content |

**So Beitz's Lemma 6.3.16 covers the degenerate end.** It proves invariance for $a\in[\frac n4-\varepsilon,\frac n4]$, a neighbourhood of the ray, by showing $I$ is a local maximum of $G(R)=dF_R(\Phi(R))$. The open region is $a\to0$, where the cone is at its largest and the constraint is purely a bound on the Weyl part against the scalar part.

**$\theta_0(n)$ IS DERIVED, NOT POSITED, the criterion at $a=0$ produces the target constant exactly.** Take the slice $R_{\mathrm{ric}_0}=0$, so $R=cI+W$. Three literature facts do all the work: *These three are what this derivation DEPENDS ON rather than an index of the shelf: every transcribed statement the record holds is in [INDEX-literature.md](INDEX-literature.md), which a candidate route is screened against first.*

| | |
|---|---|
| [BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.1 | $R+R\#I=(n-1)R_I+\frac{n-2}2R_{\mathrm{Ric}_0}$, with $\langle W\rangle$ in the **kernel**, so $W\#I=-W$ and $\Phi(I,W)=\tfrac12(IW+WI)+W\#I=W-W=0$ |
| [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6) | $\mathrm{Ric}(\Phi(R))_{ij}=\sum_k\mathrm{Ric}_{kk}R_{kijk}$, so $\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}(\Phi(W))=0$: **$\Phi$ preserves Weyl** |
| [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) p. 96 | $\Omega_0=\{\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$ **and** $\mathop{\mathrm{tr}}(R)>0\}$, so $\partial\Omega_0:\ \tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$ **on the positive-scalar nappe** |

Hence $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$, and **every cross term in the cubic vanishes**, $\langle W,\Phi(I)\rangle=(n-1)\langle W,I\rangle=0$ and $\langle I,\Phi(W)\rangle=0$ because $\Phi(W)$ is again Weyl. So $\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+\langle W,Q(W)\rangle$. On the right, $\lVert\mathrm{ric}(I)\rVert^2$ cancels between $F$ and the pairing, and the criterion collapses with **no residue at all** to

$$\langle W,Q(W)\rangle\ \le\ c\,(n-1)\lVert W\rVert^2 .$$

Normalising $\lVert W\rVert=1$, the $\partial\Omega_0$ constraint with $\lVert I\rVert^2=\dim\Lambda^2=\frac{n(n-1)}2$ gives $c=\frac1n\sqrt{\frac{2(n-2)}{n-1}}$, **the positive root, and $\mathop{\mathrm{tr}}(R)>0$ is what selects it.** *$F$ is even in $R$, so the inequality alone prints a double cone whose lower nappe demands $\langle W,Q(W)\rangle\le-\theta_0(n)$, false at every sphere product: at $n=12$, $R=-c_0I+W_{S^6\times S^6}$ sits on its boundary.* **Three verifiers, [ROUND_L43-arg](../verification/ROUND_L00r2.md)**, so the bound demanded is

$$c(n-1)=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

> **The constant is not a guess read off the sphere products, it is what cone invariance at $a=0$ requires.** Verified as squares, $\frac{2(n-2)(n-1)}{n^2}$ on both sides ([b_cone_bridge.py](../scripts/route-b/b_cone_bridge.py)).

**$n\ge12$ IS NECESSARY, NOT MERELY SUFFICIENT, and it is the same polynomial a fifth time.** *Reviewer 90.* The zero-padded $W_{\mathbb{CP}^2}$ keeps $\theta=\sqrt{3/2}$ at every $n$, and the operator $cI+W$ it defines sits on $\partial\Omega_0$, the Weyl tensor itself does not, so the criterion $\theta\le\theta_0(n)$ **fails** there exactly when $\theta_0(n)<\sqrt{3/2}$, i.e. when $n^2-12n+8<0$, i.e. $n\le11$. So $\Omega_0$ is **provably non-invariant** for $4\le n\le11$, Reviewer 92 confirmed the wider range, and notes the witness is Nienhaus's rather than new here. The conjecture's dimension hypothesis is therefore forced by an explicit witness rather than assumed, and the bridge is **sharp at $a=0$**.

**Sharpness at even $n$ only.** *Reviewer 89.* The criterion gives $P(W)\le\theta_0(n)$ at every $n$, but $\theta_0$ is attained by $S^{n/2}\times S^{n/2}$ only when $n$ is even. At odd $n$ the best sphere product gives $\frac{2(n-1)(n-3)}{(n-2)(n+1)}<\theta_0(n)^2$, independently reproducing the partition argument's values, $\tfrac{40}{27}$, $\tfrac{120}{77}$, $\tfrac{21}{13}$ at $n=11,13,15$. So this is the Conjecture A **bound**, sharp at even $n$.

**Two inputs the derivation uses and did not name.** *Reviewer 90.* $\Phi$ preserves the first Bianchi identity, without it $\Phi(W)$ could carry a $\Lambda^4$ component and "$\Phi(W)$ is Weyl" would not follow (standard Hamilton fact). And the bridge needs invariance $\Rightarrow G\le0$, where [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Lemma 2.3.4 supplies only the converse; it holds via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$.

## Passage E, a neighbouring canonical statement that uses L43 ([results.md](../results.md) line 376), quoted for its clause on the direction of Beitz's Lemma 2.3.4 alone

Zero-padded $W_{\mathbb{CP}^2}$ is a critical point of $\mathcal W_n$ at every $n\ge4$ with $\theta=\sqrt{3/2}$, and the curvature operator $cI+W$ it defines lies on $\partial\Omega_0$. Böhm–Wilking's invariance criterion at that point is exactly $\sqrt{3/2}\le\theta_0(n)$ (Lemma L43), which fails for $4\le n\le11$ and holds from $n=12$, **the direction *invariance $\Rightarrow dF_R(\Phi(R))\le0$* being the first clause of [Beitz](findings/problem.md)'s Lemma 2.3.4, whose hypotheses check.** *The witness is padded and every step is kernel-blind; $\lVert W\rVert=1$ is what makes the criterion's inequality homogeneous.* So the cone is non-invariant for $4\le n\le11$, by a witness, and the hypothesis $n\ge12$ in the conjecture is forced by the problem rather than by any method. It says nothing about whether the cone is invariant at $n\ge12$, which is the conjecture itself.

## Passage F, the Lean statement ([lean/HamiltonsCubic/Results/L43Statement.lean](../lean/HamiltonsCubic/Results/L43Statement.lean), whole file, 145 lines)

```lean
import Mathlib
import HamiltonsCubic.Base.WeylReal

set_option linter.style.longLine false

/-!
# L43, the criterion at `a = 0` demands exactly `θ₀(n)`

## The record's statement, quoted verbatim from [problem.md](../../../findings/problem.md)

> #### Lemma L43, the criterion at $a=0$ demands exactly $\theta_0(n)$

> On the slice $R_{\mathrm{ric}_0}=0$ the invariance criterion at $a=0$ collapses with no residue to
> \[
> \langle W,Q(W)\rangle\;\le\;\theta_0(n)\,\|W\|^3,\qquad \theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}n .
> \]

> **The collapse is an identity on the whole slice, not merely a vanishing at the boundary.**
> $\lVert\mathrm{ric}(I)\rVert^2$ cancels between the criterion's $F$ and the pairing, and the
> $c^3(n-1)\lVert I\rVert^2$ term is common to both sides, leaving exactly
> $\langle W,Q(W)\rangle-c(n-1)\lVert W\rVert^2$ and nothing else.

> **The slice is the EINSTEIN one.** […] *The cone also carries $\mathop{\mathrm{scal}}(R)>0$, which
> the printed $F$-sublevel set omits: $F$ is even in $R$, so without that clause the set is a double
> cone whose $c<0$ nappe reads $\langle W,Q(W)\rangle\le-\theta_0(n)\lVert W\rVert^3$, false at
> every sphere product.*

and the derivation the block points at, from the same file:

> Hence $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$, and **every cross term in the cubic vanishes** […] So
> $\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+\langle W,Q(W)\rangle$. On the right,
> $\lVert\mathrm{ric}(I)\rVert^2$ cancels between $F$ and the pairing, and the criterion collapses
> with **no residue at all** to
> $$\langle W,Q(W)\rangle\ \le\ c\,(n-1)\lVert W\rVert^2 .$$
> Normalising $\lVert W\rVert=1$, the $\partial\Omega_0$ constraint with
> $\lVert I\rVert^2=\dim\Lambda^2=\frac{n(n-1)}2$ gives $c=\frac1n\sqrt{\frac{2(n-2)}{n-1}}$,
> **the positive root, and $\mathop{\mathrm{tr}}(R)>0$ is what selects it.**

## What is typed here

The **second** half of the derivation, which is where the lemma's name lives: that the boundary
scalar `c` the cone `∂Ω₀` forces, multiplied by `n-1`, is exactly `θ₀(n)` and no other constant.

* `theta0` and `boundaryC`, the two constants, over `ℝ` throughout.
* `boundary_equation`, `c = boundaryC n` solves the `∂Ω₀` constraint
  `((n-2)/n)‖R_W‖² = ‖R_I‖²` at `‖W‖ = 1` with `‖I‖² = n(n-1)/2`, and it is the positive root.
* `collapse_constant`, **`c (n-1) = θ₀(n)`**, the lemma's "exactly `θ₀(n)`".
* `criterion_forms_agree`, at `‖W‖ = 1` the collapsed criterion `⟨W,Q(W)⟩ ≤ c(n-1)‖W‖²` and the
  lemma's display `⟨W,Q(W)⟩ ≤ θ₀(n)‖W‖³` are the same inequality, stated against the record's own
  `RealLayer.Pcubic`, `RealLayer.normSq` and `RealLayer.norm`.
* `lower_nappe_is_different`, the `scal(R) > 0` clause is load-bearing: `-θ₀(n) < θ₀(n)`, so the
  nappe the clause discards demands a different, and opposite, constant.

Everything below is proved; there is no `sorry`.

## What is NOT typed here

**The collapse itself is not stated.** Its subject is Beitz's cone `Ω₀`, the criterion function `F`,
and the Böhm–Wilking operator `Φ` with `Φ(I,W) = 0` and `Φ` preserving Weyl, none of which the
Lean layer carries; `RealLayer` has `Pcubic` and `normSq` but no `Φ`, no `I`, and no decomposition
`R = cI + R_ric₀ + R_W`. Writing those objects here would be stating the lemma about definitions
invented in this file rather than about the record's, so the first half of the derivation, the
step from the criterion to `⟨W,Q(W)⟩ ≤ c(n-1)‖W‖²`, is absent rather than approximated.

**Nothing here asserts the bound.** `criterion_forms_agree` is an equivalence between two readings
of one inequality; it does not claim `θ ≤ θ₀(n)`, which is not L43's content and is open.
-/

namespace HamiltonsCubic.L43Statement

open HamiltonsCubic.RealLayer

/-! ## The two constants -/

/-- **`θ₀(n) = √(2(n-1)(n-2))/n`**, the target constant. -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (2 * (n - 1) * (n - 2)) / n

/-- **`c = (1/n)√(2(n-2)/(n-1))`**, the scalar the boundary `∂Ω₀` forces at `‖W‖ = 1`. -/
noncomputable def boundaryC (n : ℝ) : ℝ := (1 / n) * Real.sqrt (2 * (n - 2) / (n - 1))

/-! ## The boundary equation, and the constant it produces -/

/-- **`boundaryC n` solves the `∂Ω₀` constraint**, and it is the positive root: with `‖W‖ = 1` and
`‖I‖² = n(n-1)/2`, the equation `((n-2)/n)‖W‖² = c²‖I‖²` reads `(n-2)/n = c² n(n-1)/2`. -/
theorem boundary_equation (n : ℝ) (hn : 3 ≤ n) :
    (n - 2) / n = boundaryC n ^ 2 * (n * (n - 1) / 2) ∧ 0 < boundaryC n := by
  have h1 : (0 : ℝ) < n - 1 := by linarith
  have h2 : (0 : ℝ) < n - 2 := by linarith
  have hnpos : (0 : ℝ) < n := by linarith
  have hs : Real.sqrt (2 * (n - 2) / (n - 1)) ^ 2 = 2 * (n - 2) / (n - 1) :=
    Real.sq_sqrt (by positivity)
  constructor
  · simp only [boundaryC, mul_pow, div_pow, one_pow, hs]
    field_simp
  · have hsp : 0 < Real.sqrt (2 * (n - 2) / (n - 1)) := Real.sqrt_pos.mpr (by positivity)
    exact mul_pos (div_pos one_pos hnpos) hsp

/-- **`c (n-1) = θ₀(n)`**, the lemma's "exactly `θ₀(n)`". -/
theorem collapse_constant (n : ℝ) (hn : 3 ≤ n) :
    boundaryC n * (n - 1) = theta0 n := by
  have h1 : (0 : ℝ) < n - 1 := by linarith
  have h2 : (0 : ℝ) ≤ n - 2 := by linarith
  have hnpos : (0 : ℝ) < n := by linarith
  have key : Real.sqrt (2 * (n - 1) * (n - 2))
      = (n - 1) * Real.sqrt (2 * (n - 2) / (n - 1)) := by
    have hrw : 2 * (n - 1) * (n - 2) = (n - 1) ^ 2 * (2 * (n - 2) / (n - 1)) := by
      field_simp
    rw [hrw, Real.sqrt_mul (by positivity), Real.sqrt_sq h1.le]
  simp only [theta0, boundaryC, key]
  field_simp

/-! ## The two readings of the collapsed criterion -/

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **At unit norm the two forms of the criterion are one inequality.** The collapsed form
`⟨W,Q(W)⟩ ≤ c(n-1)‖W‖²` and the lemma's display `⟨W,Q(W)⟩ ≤ θ₀(n)‖W‖³` agree, `c(n-1)` being
`θ₀(n)` by `collapse_constant`. -/
theorem criterion_forms_agree (n : ℝ) (hn : 3 ≤ n) (W : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hsq : normSq W = 1) (hnorm : norm W = 1) :
    (Pcubic W ≤ boundaryC n * (n - 1) * normSq W) ↔ (Pcubic W ≤ theta0 n * norm W ^ 3) := by
  rw [hsq, hnorm, collapse_constant n hn]
  norm_num

/-! ## The `scal(R) > 0` clause is load-bearing -/

/-- **The nappe the clause discards demands the opposite constant.** `F` is even in `R`, so without
`scal(R) > 0` the sublevel set is a double cone whose lower nappe reads
`⟨W,Q(W)⟩ ≤ -θ₀(n)‖W‖³`; the two constants are distinct, and of opposite sign. -/
theorem lower_nappe_is_different (n : ℝ) (hn : 3 ≤ n) : -theta0 n < 0 ∧ 0 < theta0 n := by
  have h1 : (0 : ℝ) < n - 1 := by linarith
  have h2 : (0 : ℝ) < n - 2 := by linarith
  have hnpos : (0 : ℝ) < n := by linarith
  have : 0 < Real.sqrt (2 * (n - 1) * (n - 2)) := Real.sqrt_pos.mpr (by positivity)
  have hpos : 0 < theta0 n := by simp only [theta0]; positivity
  exact ⟨by linarith, hpos⟩

/-! ## The constant at the dimensions the record names -/

/-- **`θ₀(4) = √3/2`**, a value the record uses, checked against the closed form. -/
theorem theta0_four : theta0 4 = Real.sqrt 12 / 4 := by
  norm_num [theta0]

end HamiltonsCubic.L43Statement

```

## Definitions and sources

- $\Lambda^2\mathbb R^n$ with the inner product the record uses; $N=\dim\Lambda^2=\binom n2$; $I$ the identity on $\Lambda^2$, $\lVert I\rVert^2=\binom n2$.
- A curvature operator decomposes as $R=R_I+R_{\mathrm{ric}_0}+R_W$; on the slice $R_{\mathrm{ric}_0}=0$ it is $R=cI+W$ with $W$ Weyl.
- $\Phi(R)=R^2+R^\#$ is Hamilton's reaction term, $\Phi(A,B)$ its polarisation, and on Weyl tensors $Q(W)=W^2+W^\#$, so $\langle W,Q(W)\rangle=\langle W,\Phi(W)\rangle$.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.
- **The imported sources are filed and may be read at source**: [references/boehm-wilking-2008-space-forms/](../references/boehm-wilking-2008-space-forms/) (Lemma 2.1, equation (6)) and [references/beitz-2018-bianchi-convexity/](../references/beitz-2018-bianchi-convexity/) (p. 96, Lemma 2.3.4, Lemma 6.3.16, Remark 6.3.15), each with `notes.md`, the PDF and a text extraction.

## What to attack, beyond the standing list

1. Whether the collapse follows as written: that $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$, that every cross term vanishes, that $\lVert\mathrm{ric}(I)\rVert^2$ "cancels between $F$ and the pairing", and what "the invariance criterion" is, as an explicit inequality, before and after the collapse.
2. Whether the collapsed inequality is $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ (Passage D, Passage C) or $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$ (Passage A), and under what normalisation or boundary condition the two agree. **In particular, whether "the collapse is an identity on the whole slice" (Passage A) and "at $a=0$ the whole condition collapses to … where $c(n-1)=\theta_0(n)$" (Passage C) hold off $\partial\Omega_0$.**
3. Whether "$\partial\Omega_0$ meets the slice at one ratio $c/\lVert W\rVert$" and the root selection by $\mathop{\mathrm{tr}}R>0$ are right.
4. Every imported fact against its source: Böhm–Wilking Lemma 2.1 and equation (6) as quoted; $\Phi$ preserving Weyl (including the first Bianchi identity); Beitz p. 96's $\Omega_0$; and **the direction of Beitz Lemma 2.3.4**, where Passage D says it "supplies only the converse" and Passage E says the needed direction is its first clause.
5. Whether the lemma's title claim, "demands $\theta_0(n)$ and nothing weaker", is established, and what "nothing weaker" quantifies over.
6. Whether Passage F's Lean statements are faithful to what they claim to type, and whether the file's account of what it does NOT type is accurate.
7. The boundary: $n=3,4$, odd $n$, $c\le0$, $W=0$, and $\ker W\ne0$ (zero-padded Weyl tensors).
8. Whether the sentence in Passage D containing *"Three verifiers, [ROUND_L43-arg](../verification/ROUND_L00r2.md)"* reads as a sentence, and whether that link's text and target agree.

