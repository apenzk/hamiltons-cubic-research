# Brief, round L46

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement as the findings file carries it ([findings/problem.md](../findings/problem.md) lines 628-635, under the heading at line 610)

Let $R$ be the curvature operator of a locally symmetric Einstein space, $\Ric=\lambda g$, and set $W=R-cI$ with $c=\lambda/(n-1)$. Then
\[
Q(W)=\lambda W,\qquad\text{so}\qquad \theta\Big(\tfrac W{\|W\|}\Big)=\frac\lambda{\|W\|}\qquad(\lambda\ne0).
\]
In Petersen--Stanfield's normalisation \cite{ps2025}, where $\lambda=\tfrac12$ for every compact irreducible symmetric space, this reads
\[
\theta^2=\frac1{4\big(\|R\|^2-(\tr R)^2/N\big)},\qquad N=\tbinom n2 .
\]

## Passage B, the proof as the findings file writes it ([findings/problem.md](../findings/problem.md) lines 614-622)

> **PROOF, IN THREE STEPS, AND THE HYPOTHESIS $\lambda\ne0$ IS PART OF THE STATEMENT**, at $\lambda=0$ a locally symmetric Ricci-flat space is flat, so $W=0$ and $\theta$ is undefined. **THE INSTRUMENT IS NOT CARTAN--AMBROSE--HICKS, WHICH AN EARLIER VERSION OF THIS PARENTHETICAL NAMED** ([r920](../reviews/REVIEW_r920.md), [r921](../reviews/REVIEW_r921.md), independently, at [L211](../findings/problem.md#lemma-l211-a-compact-einstein-symmetric-space-has-lambda0-which-is-where-compactness-and-global-symmetry-do-their-work)'s audit, where the same misattribution stood): *that theorem does not give $\operatorname{Ric}=0\Rightarrow R=0$.* The work is done by the decomposition of [L210](../findings/problem.md#lemma-l210-the-de-rham-reduction-done-at-the-algebra-so-it-costs-no-topology) with the definiteness of $\beta$ on an irreducible factor, which leaves only the Euclidean summand at $\lambda=0$.
>
> **(A) $Q(R)=\lambda R$, flow-free.** [Richard–Seshadri](../references/richard-seshadri-2013-noncoercive-cones/notes.md) Lemma 4.1 gives it directly for a locally symmetric Einstein space, with no completeness hypothesis. *The Ricci-flow reading, $\nabla R=0$ gives $\Delta R=0$, so $\partial_tR=2Q(R)$, and the homothety $\partial_tg=-2\lambda g$ pins $\partial_tR\vert_0=2\lambda R_0$, reaches the same identity and needs short-time existence, so it is the weaker route.*
>
> **(B) The shift to $W$ is exactly the one that cancels.** $Q(W+cI)=Q(W)+2c\,(W\circ I)+c^2Q(I)$ with $Q(I)=(n-1)I$, so $Q(W)=\lambda W+\lambda cI-c^2(n-1)I-2c(W\circ I)$, and $c=\lambda/(n-1)$ is the choice that kills the remainder.
>
> **(B$'$) $W\circ I$ AND $W\#I$ ARE NOT THE SAME OPERATION**, they differ by $+W$, and step (B) does not bridge them. *The bridge is on the record: $\Phi(I,W)=W-W=0$, earlier in this file ([r464](../reviews/REVIEW_r464.md)).*
>
> **(C) $W\#I=-W$, which is on the record in [isotropy-cap.md](isotropy-cap.md).** Writing $W\#I=-\tfrac12\sum_\alpha\mathrm{ad}(v_\alpha)W\,\mathrm{ad}(v_\alpha)$ and expanding the Casimir gives it, the $-2$ eigenvalue being the one that file records. *Consistency: $\operatorname{tr}(W^\#)=\langle W\#I,W\rangle=-\lVert W\rVert^2$, the record's $\operatorname{tr}W^\#=-1$ at unit norm ([conventions.md](conventions.md)).*

## Passage C, the canonical statement, landscape form ([results.md](../results.md) line 106)

- **Lemma L46. Locally symmetric Einstein spaces with $\lambda\ne0$ are critical, with $\theta$ quadratic in $\lVert W\rVert$.** *Two hypotheses corrected here: $\lambda\ne0$, since a Ricci-flat locally symmetric space is flat and $\theta$ is then undefined; and **compactness is not needed**, this entry required it, and [Richard–Seshadri](references/richard-seshadri-2013-noncoercive-cones/notes.md) Lemma 4.1 gives the identity flow-free.*act locally symmetric Einstein space, $Q(W)=\lambda W$, so $W/\lVert W\rVert$ is a critical point with $\theta^2=1/(4(\lVert R\rVert^2-(\operatorname{tr}R)^2/N))$ under the Einstein normalisation. The cubic problem on these spaces is a quadratic condition on $\lVert W\rVert$.

## Passage D, the canonical statement, detail form ([results.md](../results.md) lines 386-390)

##### Lemma L46, locally symmetric Einstein spaces with $\lambda\ne0$ are critical, with $\theta$ quadratic in $\lVert W\rVert$

Let $(M,g)$ be a compact locally symmetric Einstein space of dimension $n$ with curvature operator $R$ on $\Lambda^2$, $N=\binom n2$, and Weyl part $W$. Then $Q(W)=W^2+W^\#=\lambda W$ for a scalar $\lambda$, so $W/\lVert W\rVert$ is a critical point of $P$ on the unit sphere, and its value is $\theta=\lambda/\lVert W\rVert$ with $\theta^2=\frac1{4(\lVert R\rVert^2-(\operatorname{tr}R)^2/N)}$. Normalising to Einstein constant $\tfrac12$ makes $\operatorname{tr}R=n/4$ and the centre constant $c=\frac1{2(n-1)}$, so $\theta\le\theta_0(n)$ becomes $\lVert W\rVert^2\ge\frac1{4\theta_0(n)^2}$. **That is not $\lVert W\rVert^2\ge\tfrac16$**, which is [Lemma L47](../results.md#lemma-l47-the-dimension-lemma-for-symmetric-spaces)'s **irreducible** threshold: *the balanced product $S^6\times S^6$ has $\lVert W\rVert^2=\tfrac9{55}<\tfrac16$ while attaining $\theta_0(12)$ exactly*, and the two inequalities coincide only at $n=6+2\sqrt7$, which is not an integer. **[Lemma L48](../results.md#lemma-l48-the-reducible-case-and-the-symmetric-space-theorem) carries the reducible floor $\frac1{4\theta_0(n)^2}$ and L47 the irreducible $\tfrac16$**, and the two halves meet because $\tfrac16\ge\frac{n^2}{8(n-1)(n-2)}$ exactly when $n^2-12n+8\ge0$. The lemma reaches locally symmetric spaces only; a general Einstein space has no reason to be critical.

**Proof:** [problem.md](findings/problem.md)

## Passage E, the four-line proof and its consequence as [graded-half.md](../findings/graded-half.md) writes them (lines 210-214 and 220-224)

> Let $R$ be the curvature operator of a locally symmetric **Einstein** space, $\mathrm{Ric}=\lambda g$ **with $\lambda\ne0$**, and $W=R-cI$ with $c=\lambda/(n-1)$. Then $\boxed{Q(W)=\lambda W}$, so $W$ is critical automatically, and $\theta(W/\lVert W\rVert)=\lambda/\lVert W\rVert$.
>
> *This is [Lemma L46](problem.md), whose canonical block is in [problem.md](problem.md); the four-line argument below is its proof.*

Four lines: $Q(R)=\lambda R$ for locally symmetric Einstein ($\nabla R=0\Rightarrow\Delta R=0$, and the metric shrinks homothetically under Ricci flow); $Q(I)=(n-1)I$ since $I^\#=(n-2)I$; $B(X,Y,Z)=\langle X\circ Y,Z\rangle$ totally symmetric collapses $P(W)$ and $\lambda\lVert W\rVert^2$ to the same expression; and $R\#I=\lambda I-R$ gives $R\circ I=\lambda I$. Reviewer 86 reached the same place through the **bridge identity** $\lambda_i=1/(c_i+2)$, which ties the eigenvalue data to the block-mass data the record had been treating as independent, and showed the residual vanishes *precisely* on $\operatorname{tr}R=n/4$, **the Einstein hypothesis is not incidental**.

**Consequence: $\theta$ is a QUADRATIC functional of published tables.** Since $\lambda=\tfrac12$ for every compact irreducible symmetric space in Petersen–Stanfield's normalisation,

$$\theta=\frac1{2\lVert W\rVert},\qquad \theta^2=\frac1{4\big(\lVert R\rVert^2-(\operatorname{tr}R)^2/N\big)} .$$

**No structure constants, no $S$-blocks, no $S_{333}$, no Casimir dictionary, no dual Coxeter numbers, no Dynkin indices**, it removes the single most error-prone input in the block route, and would have made both the $S_{333}=0$ error and the index-convention worry structurally impossible. It reproduces $\mathbb{HP}^m$, $\mathbb{CP}^m$, $\mathrm{Gr}_{\mathbb C}(2,2)=14/27$ and $\mathrm{Gr}_{\mathbb C}(2,3)=275/774$ exactly, and gives a new family:

## Passage F, the Lean statement ([lean/HamiltonsCubic/Results/L46Statement.lean](../lean/HamiltonsCubic/Results/L46Statement.lean), whole file, 152 lines)

```lean
import Mathlib
import HamiltonsCubic.Base.WeylReal

set_option linter.style.longLine false

/-!
# L46, at a locally symmetric Einstein space the Weyl part is critical, and `θ` is quadratic

## The record's statement, quoted verbatim from [problem.md](../../../findings/problem.md)

> #### Lemma L46, at a locally symmetric einstein space the weyl part is critical, and $\theta$ is quadratic

> Let $R$ be the curvature operator of a locally symmetric Einstein space, $\Ric=\lambda g$, and set
> $W=R-cI$ with $c=\lambda/(n-1)$. Then
> \[
> Q(W)=\lambda W,\qquad\text{so}\qquad \theta\Big(\tfrac W{\|W\|}\Big)=\frac\lambda{\|W\|}\qquad(\lambda\ne0).
> \]
> In Petersen--Stanfield's normalisation \cite{ps2025}, where $\lambda=\tfrac12$ for every compact
> irreducible symmetric space, this reads
> \[
> \theta^2=\frac1{4\big(\|R\|^2-(\tr R)^2/N\big)},\qquad N=\tbinom n2 .
> \]

and, from the Gate 2 block above it, the three steps and the hypothesis the statement owes:

> **(A) $Q(R)=\lambda R$, flow-free.** [Richard–Seshadri] Lemma 4.1 gives it directly for a locally
> symmetric Einstein space, with no completeness hypothesis.

> **(B) The shift to $W$ is exactly the one that cancels.** $Q(W+cI)=Q(W)+2c\,(W\circ I)+c^2Q(I)$
> with $Q(I)=(n-1)I$, so $Q(W)=\lambda W+\lambda cI-c^2(n-1)I-2c(W\circ I)$, and $c=\lambda/(n-1)$
> is the choice that kills the remainder.

> **(B$'$) $W\circ I$ AND $W\#I$ ARE NOT THE SAME OPERATION**, they differ by $+W$ […] *The bridge
> is on the record: $\Phi(I,W)=W-W=0$*

> **(C) $W\#I=-W$** […]

> **PROOF, IN THREE STEPS, AND THE HYPOTHESIS $\lambda\ne0$ IS PART OF THE STATEMENT**, at
> $\lambda=0$ a locally symmetric Ricci-flat space is flat by Cartan–Ambrose–Hicks with de Rham, so
> $W=0$ and $\theta$ is undefined.

## What is typed here

The lemma is a formal consequence of three inputs, and all three are classical and published, so
each enters as a named hypothesis rather than as a `sorry`:

* `Qcrit`, **(A)**, Richard–Seshadri Lemma 4.1: `Q(R) = λ R` at a locally symmetric Einstein space.
* `hQI`, `Q(I) = (n-1) I`, Böhm–Wilking.
* `hWI`, `W ∘ I = 0`, which is **(B′)** and **(C)** together: `W # I = -W` is Böhm–Wilking
  Lemma 2.1, and `W ∘ I = W # I + W`.

Given those, `shift_kills_remainder` is the whole of steps (A)–(C): pure bilinear algebra in the
metrised algebra, over an arbitrary `ℝ`-module, with the symmetric bilinear `Qb` in place of `Q`
and `Qb x x` in place of `Q(x)`. `theta_of_eigenvalue` and `petersen_stanfield` are the two
displays, the first stated against the record's own `RealLayer.theta`, `RealLayer.Pcubic` and
`RealLayer.normSq`.

Everything below is proved; there is no `sorry`.

## What is NOT typed here

**The identification of the abstract `Qb` with the record's curvature product is not made**, because
the real Weyl layer carries `Pcubic` and `normSq` but no operator `Q` with `P(R) = ⟨Q(R), R⟩`. The
bridge from `Qb W W = lam • W` to `theta_of_eigenvalue`'s hypothesis `Pcubic W = lam * normSq W` is
therefore that pairing, taken as the hypothesis of the second theorem rather than derived from the
first.

**`θ` is read at `W` rather than at `W/‖W‖`.** `θ` is homogeneous of degree `0`, so the two agree;
the homogeneity itself is not proved here, the real Weyl layer carrying no scaling lemma for
`Pcubic`.
-/

namespace HamiltonsCubic.L46Statement

open HamiltonsCubic.RealLayer

/-! ## Steps (A)–(C): the shift that cancels -/

variable {E : Type*} [AddCommGroup E] [Module ℝ E]

/-- **Step (B), with (A), (B′) and (C) as its inputs: `Q(W) = λ W`.**

`Qb` is the symmetric bilinear form of the metrised algebra, so `Qb x x` is `Q(x)` and
`Qb W I` is `W ∘ I`. The hypotheses are, in the record's labelling: `hcrit` is (A),
Richard–Seshadri Lemma 4.1; `hQI` is `Q(I) = (n-1) I`; `hWI` is `W ∘ I = 0`, which is
(C) `W # I = -W` together with (B′) `W ∘ I = W # I + W`. The conclusion is the lemma's
`Q(W) = λ W`, and `c = λ/(n-1)` is what makes the two `I`-terms cancel. -/
theorem shift_kills_remainder (Qb : E →ₗ[ℝ] E →ₗ[ℝ] E) (hsymm : ∀ x y, Qb x y = Qb y x)
    (I W : E) (n : ℕ) (lam c : ℝ) (hn : ((n : ℝ) - 1) ≠ 0)
    (hQI : Qb I I = ((n : ℝ) - 1) • I) (hWI : Qb W I = 0)
    (hc : c = lam / ((n : ℝ) - 1))
    (hcrit : Qb (W + c • I) (W + c • I) = lam • (W + c • I)) :
    Qb W W = lam • W := by
  have hIW : Qb I W = 0 := by rw [hsymm]; exact hWI
  have hexp : Qb (W + c • I) (W + c • I)
      = Qb W W + (c * c * ((n : ℝ) - 1)) • I := by
    simp only [map_add, LinearMap.add_apply, map_smul, LinearMap.smul_apply, hWI, hIW, hQI,
      smul_zero, smul_smul]
    module
  have hrhs : lam • (W + c • I) = lam • W + (lam * c) • I := by
    rw [smul_add, smul_smul]
  rw [hexp, hrhs] at hcrit
  have hcoef : c * c * ((n : ℝ) - 1) = lam * c := by
    rw [hc]; field_simp
  rw [hcoef] at hcrit
  exact add_right_cancel hcrit

/-! ## The first display: `θ = λ/‖W‖` -/

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`θ(W) = λ/‖W‖`.** The hypothesis is `Q(W) = λ W` paired against `W`, i.e.
`P(W) = λ‖W‖²`; `hnn` is nonnegativity of `‖W‖²`, and `hpos` is the record's `λ ≠ 0` clause in the
form it is actually needed, `W ≠ 0`. -/
theorem theta_of_eigenvalue (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (lam : ℝ)
    (hnn : 0 ≤ normSq R) (hpos : 0 < norm R) (hP : Pcubic R = lam * normSq R) :
    theta R = lam / norm R := by
  have hsq : norm R ^ 2 = normSq R := Real.sq_sqrt hnn
  have hne : norm R ≠ 0 := ne_of_gt hpos
  rw [theta, hP, ← hsq]
  field_simp

/-! ## The second display: Petersen–Stanfield's normalisation -/

/-- **`θ² = 1/(4(‖R‖² - (tr R)²/N))`**, at `λ = 1/2`.

`nR` is `‖R‖`, `trR` is `tr R`, `NN` is `N = binom n 2`, and `w` is `‖W‖`; the hypothesis `hw` is
`‖W‖² = ‖R‖² - (tr R)²/N`, which is what `W = R - cI` says for the trace part, and `hth` is the
first display at `λ = 1/2`. -/
theorem petersen_stanfield (nR trR NN w th : ℝ) (hNN : 0 < NN) (hwpos : 0 < w)
    (hw : w ^ 2 = nR ^ 2 - trR ^ 2 / NN) (hth : th = (1 / 2) / w) :
    th ^ 2 = 1 / (4 * (nR ^ 2 - trR ^ 2 / NN)) := by
  have hwne : w ≠ 0 := ne_of_gt hwpos
  have hNNne : NN ≠ 0 := ne_of_gt hNN
  rw [hth, ← hw]
  field_simp
  norm_num

/-! ## Non-vacuity -/

/-- **A witness for `shift_kills_remainder`'s hypotheses**, so the theorem is not vacuous: take
`E = ℝ`, `Qb x y = x * y`, `I = n - 1`, `W = 0`, `λ` arbitrary. *This exhibits a satisfying
instance of the binder; it is not a curvature operator.* -/
example (n : ℕ) :
    letI Qb : ℝ →ₗ[ℝ] ℝ →ₗ[ℝ] ℝ := LinearMap.mul ℝ ℝ
    Qb ((n : ℝ) - 1) ((n : ℝ) - 1) = ((n : ℝ) - 1) • ((n : ℝ) - 1) ∧ Qb 0 ((n : ℝ) - 1) = 0 := by
  refine ⟨?_, ?_⟩
  · simp [smul_eq_mul]; ring
  · simp

end HamiltonsCubic.L46Statement

```

## Definitions and sources

- $\Lambda^2\mathbb R^n$ with $\langle R,S\rangle=\operatorname{tr}(R\circ S)$, $I$ the identity, $N=\binom n2=\lVert I\rVert^2$. $Q(R)=R^2+R^\#$, $B$ its symmetric polarisation, $X\circ Y$ the product with $B(X,Y)=X\circ Y$ as the passages use it, and $P(W)=\langle W,Q(W)\rangle$, $\theta(W)=P(W)/\lVert W\rVert^3$.
- An Einstein curvature operator with $\mathrm{Ric}=\lambda g$ decomposes as $R=cI+W$, $c=\lambda/(n-1)$, $W$ Weyl.
- **Filed sources, readable at source**: [references/richard-seshadri-2013-noncoercive-cones/](../references/richard-seshadri-2013-noncoercive-cones/) (Lemma 4.1 and its proof), [references/boehm-wilking-2008-space-forms/](../references/boehm-wilking-2008-space-forms/) (Lemma 2.1), [references/petersen-stanfield-2025-symmetric-curvature-operators/](../references/petersen-stanfield-2025-symmetric-curvature-operators/). **Brendle's Proposition 3 of [Bre10a], which Richard–Seshadri's proof invokes, is not filed**; the Brendle source in [references/](../references/), `brendle-2019-pic-surgery`, is a different work.

## What to attack, beyond the standing list

1. **Step (A) against its source.** Richard–Seshadri Lemma 4.1's stated hypotheses, read at source, against the object Passages A, B and E apply it to: a *locally* symmetric Einstein space, $\lambda$ of either sign, no completeness or compactness. Whether the source's proof reaches that object, and what its proof imports.
2. Step (B)'s expansion and the choice $c=\lambda/(n-1)$; step (B$'$), $X\circ I=X\#I+X$; step (C), $W\#I=-W$; and whether the chain yields $Q(W)=\lambda W$.
3. **$\lambda\ne0$ against $W\ne0$**: whether the conclusion $\theta(W/\lVert W\rVert)=\lambda/\lVert W\rVert$ needs $W\ne0$, and whether any passage's hypotheses exclude a locally symmetric Einstein space with $\lambda\ne0$ and $W=0$.
4. The argument at $\lambda=0$ in Passage B's first paragraph.
5. The display $\theta^2=\frac1{4(\lVert R\rVert^2-(\operatorname{tr}R)^2/N)}$: under which value of $\lambda$ it holds in each passage that prints it, and $\lVert W\rVert^2=\lVert R\rVert^2-(\operatorname{tr}R)^2/N$.
6. Compactness: Passage D says *compact*, Passages A, B and C do not; which hypotheses the proof uses.
7. Passage D's reformulation: $\operatorname{tr}R=n/4$ and $c=\frac1{2(n-1)}$ at $\lambda=\tfrac12$, $\theta\le\theta_0(n)\iff\lVert W\rVert^2\ge\frac1{4\theta_0(n)^2}$, $\lVert W\rVert^2=\tfrac9{55}$ at $S^6\times S^6$, and the $n^2-12n+8$ comparison.
8. Petersen–Stanfield's "$\lambda=\tfrac12$ for every compact irreducible symmetric space", read at source.
9. Whether Passage F's Lean statements are the claim, and whether each named hypothesis excludes anything.
10. The boundary: $\lambda<0$, $W=0$, $n=3$ (where $\mathcal W_n=0$), $n=4$, and reducible spaces.
11. Whether the sentence at the end of the block's annotations, *"The statement is below; the section it used to point at is"*, and the pointer sentence heading the block read as sentences.

