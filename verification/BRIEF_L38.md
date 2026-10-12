# Brief for round L38

**Verbatim extracts. Nothing here is paraphrased. Where the record states the same thing twice, both are given unlabelled.**

## A. The canonical entry, results.md lines 517-521

```markdown
##### Lemma L38, two families capped, in closed form and strictly decreasing

For the $\mathbb{CP}^m$ family, $m\ge2$, the unit Weyl tensor has $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$. For the two-eigenvalue point of the symmetric pair $(\mathfrak{su}(m),\mathfrak{so}(m))$ inside $\mathfrak{so}(2m)$, with $p=\dim\mathfrak k=\binom m2$ and $q=\dim\mathfrak m=\binom{m+1}2-1$, $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}=\frac X{X-2}$ with $X=m(m+1)$. Both are strictly decreasing in $m$ with maximum $\tfrac32$ at $m=2$, and the $m=2$ member of the second family is $W_{\mathbb{CP}^2}$ itself, so neither family exceeds $\sqrt{3/2}$ anywhere. The lemma is a value statement about two families and says nothing about points outside them.

**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)
```

## B. The landscape statement, results.md line 162

```markdown
- **Lemma L38 (landscape). Two families capped, in closed form and strictly decreasing.** On the $\mathbb{CP}^m$ family $\theta^2=(m+1)(2m-1)/(3m(m-1))$, and on the Kähler family of $(\mathfrak{su}(m),\mathfrak{so}(m))$ inside $\mathfrak{so}(2m)$, $\theta^2=m(m+1)/((m-1)(m+2))$. Both decrease strictly in $m$ with maximum $\tfrac32$ at $m=2$, where the second family's member is $W_{\mathbb{CP}^2}$.
```

## C. The block, findings/ungraded-slack.md lines 244-269

```markdown
#### Lemma L38, two families capped, in closed form and strictly decreasing


> **BOTH FORMS ARE EXACT, AND NEITHER WAS FITTED.** The $\mathbb{CP}^m$ value was rebuilt from the Fubini–Study curvature operator with the bracket masses taken from the Killing marginal alone; **it reproduces two anchors it was not built from**, $m=2\to\tfrac32=M(4)^2$ and $m=3\to\tfrac{10}9=\theta_0(6)^2$, both already on the record. The Kähler value was reproduced **twice**, from [L39](target.md)'s four-invariant form and from today's three-invariant reduction with $c=2m$ derived independently by three routes.

> **MONOTONICITY IS PROVED FOR BOTH, ON A RANGE THE BLOCK NEVER STATES.** The second family is $1+2/(X-2)$, immediate; the first needs the derivative, whose numerator $-3(3m^2-2m+1)$ has discriminant $-8$ and so is **negative-definite**. **Both formulas are undefined at $m=1$, excluded silently rather than by hypothesis**, the canon states $m\ge2$ for the first family only.

> **THE TWO FAMILIES MEET AT $m=2$ AND NOWHERE ELSE** ($m^2-3m+2=0$), and **the identification of the $m=2$ member with $W_{\mathbb{CP}^2}$ is now proved rather than asserted**: it is supported on one chiral $\mathfrak{su}(2)\subset\mathfrak{so}(4)$ with $\mathbb R\omega=\mathfrak{so}(2)$ as $\mathfrak k$, giving $p=1$, $q=2$ and $ap+bq=0$, and the full normalised spectrum $(2,-1,-1,0,0,0)/\sqrt6$ checks.

> **"CAPPED" DOES NOT MEAN "BELOW THE TARGET" AT THE FAMILY'S OWN $n$.** Both families **exceed** $\theta_0(2m)$ at $m=2$; $\mathbb{CP}^m$ **ties exactly at $m=3$**, the difference carrying the sign of $-(2m-1)(m-3)$; and the Kähler $m=3$ member $(\mathfrak{su}(3),\mathfrak{so}(3))$ sits at $\sqrt{6/5}=1.0954$ against $\Theta_6=1.0541$, **above it.** *Both drop below only from $m\ge4$.* **What the caps license at $n\ge12$ is that the padded closure of both families stays at $\sqrt{3/2}<\Theta_n$**, but the cap is *attained* at $\mathbb{CP}^2$, **so it fences and never separates.** *And $\tfrac32$ here is $\theta^2$, where the record quotes $\sqrt{3/2}$ everywhere else.*

> **THE POINTER IS FALSE, AND WAS HALF-FALSE THE DAY IT WAS STAMPED.** The named section derives the two-eigenvalue Casimir family and **its own closing paragraph lists $\mathbb{CP}^m$ as lying outside it**; the Kähler family is not two-eigenvalue either, carrying an $(m^2-m+1)$-dimensional kernel. *`git` shows that at the commit which stamped the boilerplate, this file carried the $\mathbb{CP}^m$ form and **never** the Kähler form, which has always been in [target.md](target.md); a later split left both derivations behind.* **Neither formula appears anywhere in this file outside this block.** The real arguments are in [algebra.md](algebra.md) and [target.md](target.md). *"Numbered in report/" is true.*

> **THE $\mathbb{CP}^m$ HALF DUPLICATES [LEMMA L10](graded-half.md)**, same formula, two numbers, neither block citing the other. *That is the second duplicate-statement pair this audit has found, after [L55](diagonal-half.md)/[L93](bispectral.md).*

*The block's closing LaTeX has been broken since it was created, alongside five raw report macros; the canon has the sentence correct. And [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) gives the $\mathbb{CP}^m$ row's limit as $1$, which is the **other** family's limit written onto the wrong row, it is $2/3$, and the appendix has it right.*
For the $\CP^m$ family,
\[
\theta^2\;=\;\frac{(m+1)(2m-1)}{3m(m-1)},
\]
strictly decreasing in $m$ with maximum $\tfrac32$ at $m=2$. For the K\"ahler family of the symmetric pair $(\su(m),\so(m))$ inside $\so(2m)$, with $p=\dim\kk=\binom m2$ and $q=\dim\mm=\binom{m+1}2-1$,
\[
\theta^2\;=\;\frac{m(m+1)}{(m-1)(m+2)}\;=\;\frac X{X-2},\qquad X=m(m+1),
\]
again strictly decreasing, with maximum $\tfrac32$ at $m=2$. **The $m=2$ member of the second family is $W_{\CP^2**$ itself.}
```
