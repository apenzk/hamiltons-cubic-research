# Brief for round L31

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical statement, from results.md lines 461-465

```markdown
##### Lemma L31, the bracket cap, characterised

For orthonormal $X,Y\in\mathfrak{so}(n)$, $\|[X,Y]\|^2=2$ if and only if $XY=-YX$, both $X$ and $Y$ have rank $4$ with all singular values $1/\sqrt2$, and $\mathrm{im}\,X=\mathrm{im}\,Y$.

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)
```

## B. The landscape statement, from results.md line 148

```markdown
- **Lemma L31 (landscape). The bracket cap, characterised.** For orthonormal $X,Y\in\mathfrak{so}(n)$, $\|[X,Y]\|^2=2$ exactly when they anticommute, both have rank $4$ with every singular value $1/\sqrt2$, and their images agree. The root system gives $\max_Y\|[X,Y]\|^2=(s_1+s_2)^2$, and Cauchy–Schwarz forces the rest.
```

## C. The block in findings/stratum-two-negative.md, lines 417-438

```markdown
#### Lemma L31, the bracket cap, characterised, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: this file already carried the whole argument, root system and both equality steps.*

Needed because the sharp stratum's one inequality is the pair cap, and knowing exactly when it is attained
converts that estimate into an identity.

**Statement.** For orthonormal $X,Y\in\mathfrak{so}(n)$, $\|[X,Y]\|^2=2$ if and only if $XY=-YX$, both $X$
and $Y$ have rank $4$ with all singular values $1/\sqrt2$, and $\mathrm{im}\,X=\mathrm{im}\,Y$. *The rank is derived for $X$ and follows for $Y$ by the symmetry of the bracket in its two arguments, a clause the canonical block dropped.*

**Proof.** The roots of $\mathfrak{so}(n)$ give $\mathrm{ad}_X$ the eigenvalues $i(\pm s_i\pm s_j)$ and
$i(\pm s_i)$ for the angles $s_i$ of $X$, so $\max_{\|Y\|=1}\|[X,Y]\|^2=(s_1+s_2)^2$ exactly. With
$\sum_is_i^2=1$, Cauchy–Schwarz gives $(s_1+s_2)^2\le2$ with equality only at $s_1=s_2=1/\sqrt2$ and the
rest zero, rank exactly $4$. Equality in $\|[X,Y]\|_F\le\|XY\|_F+\|YX\|_F\le2\|X\|_{\rm op}\|Y\|_F$ then
forces the columns of $Y$ into $X$'s top singular subspace, which is all of $\mathrm{im}\,X$ since the
nonzero singular values coincide, so $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$ and symmetrically; and the
triangle step with $\|XY\|_F=\|YX\|_F$ forces $XY=-YX$. Conversely, $X^2=Y^2=-P_V/2$ and $[X,Y]=2XY$ give
$\|[X,Y]\|^2=\operatorname{tr}(Y^{\mathsf T}Y)=2$. $\square$

**A correction carried into the statement.** An earlier derivation argued from $\|[X,Y]\|^2\le4s_1^2$ that
the cap forces rank $4$; that step is invalid, $s^2=(0.5,0.3,0.2)$ satisfies $s_1^2\ge\tfrac12$ at rank
$6$, and the root-system identity replaces it. Gate 2 passed, the repair supplied by the review.
```

## D. The clause L31 is now credited with, from results.md line 451

```markdown
Let $W\in\mathrm{Weyl}_n$ have $\|W\|=1$ and exactly one positive and two negative eigenvalues, $\lambda_1>0>-a\ge-b$. Then $\theta(W)\le\sqrt{3/2}$, attained at the spectrum $(2,-1,-1)/\sqrt6$. The bound carries no dimension restriction. **The converse comes in two strengths and neither is the lemma the record credited.** *Equality forces the spectrum* follows in two lines from this proof's own equality case, needing no further result; *equality forces the support to have $r=4$* is [Lemma L31](../findings/fence-posts.md#post-f31-the-sharp-target-is-not-freely-described-and-n-cannot-be-smuggled-in-as-a-trace)'s, in three. **The credit to Lemma L72 is withdrawn**, L72 quantifies over *critical* points and this clause over *equality* points, and the containment runs the wrong way.
```
