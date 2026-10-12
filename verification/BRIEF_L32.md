# Brief for round L32

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical statement, from results.md lines 465-469

```markdown
##### Lemma L32, a bivector's centraliser collapses to a line

Let $m\ne3$, let $x\in\mathfrak{so}(m)$ be nonzero and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$, except when $x$ is a multiple of a complex structure on a $4$-dimensional subspace, where it is a $3$-dimensional $\mathfrak{su}(2)$. **The restriction is necessary**: at $m=3$ the centraliser $\mathfrak c$ is zero and the statement fails, which is [r463](reviews/REVIEW_r463.md)'s witness $x=e_{12}\in\mathfrak{so}(3)$. *That reviewer named this line for repair and it was missed; only the landscape entry above got it.*

**Proof:** [isotropy-cap.md](findings/isotropy-cap.md)
```

## B. The landscape statement, from results.md line 150

```markdown
- **Lemma L32 (landscape). A bivector's centraliser collapses to a line, REQUIRES $\mathfrak c\ne0$, a hypothesis this entry omitted.** *Refuted as stated by two reviewers with the witness $x=e_{12}$ in $\mathfrak{so}(3)$, which the stated exception does not cover.* For skew $x$ with $\mathfrak c=\mathfrak z(x)\cap x^\perp\ne0$, $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$ unless $x$ is a multiple of a complex structure on a $4$-plane, where it is an $\mathfrak{su}(2)$. Three root-system lines, uniform in the singular values.
```

## C. The block in findings/isotropy-cap.md, lines 74-110

```markdown
#### Lemma L32, a bivector's centraliser collapses to a line, canonical statement and proof

> **REFUTED AS STATED: A HYPOTHESIS IS MISSING.** *[r462](../reviews/REVIEW_r462.md) and [r463](../reviews/REVIEW_r463.md), independently, with the same witness.* Take $x=e_{12}$ in $\mathfrak{so}(3)$: then $\mathfrak c=\mathfrak z(x)\cap x^\perp=\{0\}$, so $\mathfrak z(\mathfrak c)=\mathfrak{so}(3)$ and $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ is all of $\mathfrak{so}(3)$, of dimension $3$ rather than the line $\mathbb Rx$. **The stated exception does not cover it**, $\mathfrak{so}(3)$ has no $4$-plane, so $x$ is no complex structure on one.

> **WHAT IT NEEDS IS $\mathfrak c\ne0$**, which fails only in dimensions too small to carry the configuration. *The one use on the record, in [stratum-two-negative.md](stratum-two-negative.md), is at $n\ge12$ where the hypothesis is expected to hold, **expected, and not yet checked there**.*

*Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: this file already carried a block for this result.*

Needed because the two defining conditions of a Weyl tensor, taken together, constrain the *centralisers*
of its eigenvectors rather than their eigenvalues, and that constrains anything only if the centraliser of
a centraliser is small.

**Statement.** Let $x\in\mathfrak{so}(m)$ be nonzero and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then
$\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$, except when $x$ is a multiple of a complex
structure on a $4$-dimensional subspace, where it is a $3$-dimensional $\mathfrak{su}(2)$.

**Proof, for nondegenerate $x$.** Let $\mathfrak t$ be the maximal torus spanned by $x$'s $p=m/2$ coordinate
$2$-planes and $a=(a_1,\dots,a_p)$ its singular values, all nonzero. Then $\mathfrak t\subseteq\mathfrak z(x)$,
so $\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$, and therefore

$$\mathfrak z(\mathfrak c)\ \subseteq\ \mathfrak z(a^\perp)\ =\ \mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}.$$

Every root of $D_p$ is $\pm e_i\pm e_j$ and so has $p-2$ zero coordinates, while $a$ has none. For $p\ge3$
that forces $\mathfrak z(\mathfrak c)\subseteq\mathfrak t$, whence
$\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathfrak t\cap(a^\perp)^\perp=\mathbb Rx$. For
$p=2$ the roots have no zero coordinate and $a\propto(1,1)$ is admissible, exactly the complex-structure
case. For degenerate $x$ the same argument runs inside the support, with $\mathfrak z(\mathfrak c)$
additionally centralising $\mathfrak{so}(\ker x)$. $\square$

**Scope, stated.** The criterion is the singular-value vector being proportional to a root of $D_p$, which is
*rank $4$ with equal singular values* (so **nondegeneracy is sufficient and not necessary at $m\ge6$**), *the qualifier was missing and the claim is false at $m=4,5$*, and the
degenerate case is not vacuous: a rank-$4$ complex structure padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$
returns $3$ every time. Gate 2 passed, both reviewers independently, at all $29$ multiplicity partitions to
$m=12$ and at $m=14,16$ on the hard patterns, under adversarial singular-value relations. The two reviewers
disagreed on whether a case split on the number of blocks is needed; it is not, and the disagreement was
settled by checking $\mathfrak t\cap x^\perp\subseteq\mathfrak c$ directly at every pattern.

```
