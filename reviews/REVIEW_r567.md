# REVIEW_r567, Lemma L71 (saturation forces the balanced sphere product)

Reviewer r567, independent adversarial audit, cold brief. Analysis-only footing: no computation was run beyond screening claims about to be recorded, and no screen is cited as evidence for a positive claim.

Status: COMPLETE. Overall verdict REPAIRED, see the table at the end.

## What the prior rounds settled, and whether either gates the block as it stands

Chronology from `git log`, which is what settles this:

| time (2026-09-01) | commit | what it did |
| --- | --- | --- |
| 20:42 | 1782be6f | L71 first written, conditional on $\mathfrak r=0$ |
| 21:13 | ab9a8ce6 | **the ideal argument lands**, L71 becomes unconditional, and the four-defect blockquote is written; the paragraph credits [Reviewer 328](REVIEW_r328.md) as its source |
| 21:21 | 55ab2c3c | the superseded $\mathfrak r\subseteq\ker W$ material is deleted |
| 22:04 | 04955d88 | all four reports filed at once; "three errors r329 and r330 found independently" folded in |

**Neither pair is a Gate 2 on the central paragraph, and for two different reasons.**

- **[r327](REVIEW_r327.md) and [r328](REVIEW_r328.md) are authors of it, not gates on it.** r328 supplied the ideal argument and the block says so in terms; r327 audited the *conditional* lemma ("M4: does saturation force $\mathfrak r\subseteq\ker W$"), whose hypothesis the 21:13 commit removed. A reviewer whose derivation is copied into the block cannot also be the independent check on it.
- **[r329](REVIEW_r329.md) and [r330](REVIEW_r330.md) did gate the 21:13 text, and their central finding was never applied.** Both independently refused the uniqueness step's $n=8$ justification; the 22:04 commit folded three of their findings and left that one. It is the subject of the first verdict below.

So the block as it now stands carries **one confirmed, twice-independently-found, three-day-old unapplied refutation**, and its ideal argument has never had an independent check. This round is the first.

## Verdict 1, the $n=8$ triality sentence: REFUTED AS STATED, and the refutation is three days old and unapplied

The block says, twice:

> *"$\dim\mathfrak g^\theta$ is an $\mathrm{Aut}$-invariant, so triality can never produce a new dimension at $n=8$"*, [findings/bounds.md](../findings/bounds.md) defect (iv)
>
> *"and $\dim\mathfrak g^\theta$ is an $\mathrm{Aut}$-invariant, so triality produces no new dimension at $n=8$"*, the uniqueness paragraph

and [results.md](../results.md) repeats it a third time as *"triality produces no new dimension at $n=8$"*.

**The sentence is true and proves the wrong thing.** Cartan's classification enumerates involutions up to conjugacy in $\mathrm{Aut}(\mathfrak g)$. What the lemma consumes is $O(n)$-conjugacy, because $W=\lambda_{\max}\Pi_{\mathfrak h}+\lambda_{\min}\Pi_{\mathfrak m}$ is recovered from $\mathfrak h$ as an operator on $\Lambda^2\mathbb R^n$, and only $O(n)$ acts on $\mathbb R^n$. The two relations agree at every $n\ge5$ except $n=8$, where triality is outer and is not induced by $O(8)$. Ruling out a second *dimension* leaves a second $O(8)$-*class at dimension $12$* untouched, and that is precisely what would break "$W$ is the balanced sphere product".

**This is the record's own documented failure mode, verbatim.** [ATTEMPTS.md](../ATTEMPTS.md), 2026-08-22, "the Cartan reduction, refuted at both ends by Gate 2": *"Cartan's classification is up to $\mathrm{Aut}(\mathfrak g)$; the argument needed $SO(n)$-conjugacy. These agree for $\mathfrak{so}(n)$ at every $n\ge5$ except $n=8$. **The rule:** when a classification theorem is invoked, check that its equivalence relation is the one the argument consumes, the exceptional dimension is where the two come apart."* The rule was written down nine days before this block reintroduced the step it forbids.

### The repair, by a route that shares nothing with the block's

The block's route is dimension counting. Mine is the weight of the involution on the three eight-dimensional representations of $\mathrm{Spin}(8)$, which never mentions a dimension of $\mathfrak g^\theta$.

Realise the involution as a torus element $t(\theta_1,\dots,\theta_4)$ rotating the four coordinate planes. The vector representation carries eigenvalues $e^{\pm i\theta_j}$; the half-spin representations carry $\exp\!\big(\tfrac i2\sum_j\epsilon_j\theta_j\big)$ over the sixteen sign vectors $\epsilon\in\{\pm1\}^4$, split by $\prod_j\epsilon_j=\pm1$.

- **The dimension-$12$ class.** $\mathrm{diag}(I_4,-I_4)$ is $t(0,0,\pi,\pi)$, giving eigenvalues $(1^4,(-1)^4)$ on $V$. On $S^\pm$ the eigenvalue is $\exp\!\big(\tfrac{i\pi}2(\epsilon_3+\epsilon_4)\big)$, which is $-1$ when $\epsilon_3=\epsilon_4$ and $+1$ otherwise; the parity constraint splits the eight weights $4$–$4$ either way. So the pattern is $(1^4,(-1)^4)$ on **all three** eight-dimensional representations. Triality permutes those three, so the triality image of this element has the same $(4,4)$ pattern on $V$, hence is $SO(8)$-conjugate to $\mathrm{diag}(I_4,-I_4)$ itself. **The class is triality-stable, and $\mathfrak h$ is $O(8)$-conjugate to the standard $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$.** The conclusion stands, on this argument, not on the invariance of a dimension.
- **The control that validates the method.** Run the same computation on the complex structure $J=t(\tfrac\pi2,\tfrac\pi2,\tfrac\pi2,\tfrac\pi2)$, whose fixed algebra is $\mathfrak u(4)$. On $S^+$ the eigenvalue is $\exp\!\big(\tfrac{i\pi}4\sum_j\epsilon_j\big)$: the single weight at $\sum\epsilon_j=4$ and the single one at $-4$ give $-1$, the six at $\sum\epsilon_j=0$ give $+1$. Pattern $(1^6,(-1)^2)$, an order-two element with a two-dimensional $(-1)$-eigenspace, i.e. the $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ class. **The method reproduces the known triality swap $\mathfrak u(4)\leftrightarrow\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ at dimension $16$**, which is the check that it can detect a class that moves.

**Verdict: REPAIRED.** The statement of L71 survives; the argument as written does not reach it at $n=8$. Replace both occurrences of the triality sentence, and the one in results.md, with the triality-stability sentence.

## Verdict 2, the chain from the hypothesis to $\mathfrak r=0$: CONFIRMED, rebuilt line by line

Rebuilt from the definitions, naming what supplies each step.

**The three bracket relations.** [Lemma L70](../findings/bounds.md)'s equality case is $c_{vab}=0$ unless $\{a,b\}$ has one index in $E_{\min}$ and one in $E_{\max}$, for every unit $v\in\mathfrak m$. With $c_{vab}=\langle[v,v_a],v_b\rangle$ and $c$ totally antisymmetric ([conventions.md](../findings/conventions.md)): taking $v_a\in\mathfrak m$ leaves $\langle[v,v_a],v_b\rangle=0$ for $v_b\notin\mathfrak h$, giving $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$; taking $v_a\in\mathfrak h$ gives $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$; taking $v_a\in\mathfrak r$ leaves no admissible $v_b$ at all, giving $[\mathfrak m,\mathfrak r]=0$. All three are correct translations, and the eigenspace-blockwise reading is basis-independent.

**$\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$ is an ideal.** $[\mathfrak m,\mathfrak g']\subseteq[\mathfrak m,\mathfrak m]+[\mathfrak m,\mathfrak h]\subseteq\mathfrak g'$; $[\mathfrak h,\mathfrak g']\subseteq[\mathfrak h,\mathfrak m]+[\mathfrak h,[\mathfrak m,\mathfrak m]]\subseteq\mathfrak m+[\mathfrak m,\mathfrak m]=\mathfrak g'$ by Jacobi and $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$; $[\mathfrak r,\mathfrak g']=0$ by Jacobi from $[\mathfrak r,\mathfrak m]=0$. So $[\mathfrak{so}(n),\mathfrak g']\subseteq\mathfrak g'$.

**$\mathfrak m\ne0$** because $\mathop{\mathrm{tr}}W=0$ at $W\ne0$ forces $\lambda_{\min}<0$. The block asserts it without this line; it is one line and should be there, since it is the same strictness [Lemma L70](../findings/bounds.md) was corrected for this session.

**Simplicity closes it.** $\mathfrak{so}(n)$ simple gives $\mathfrak g'=\mathfrak{so}(n)$, and since $\mathfrak g'\subseteq\mathfrak m\oplus\mathfrak h$ orthogonally, $\mathfrak r=0$ and $[\mathfrak m,\mathfrak m]=\mathfrak h$.

**One presentational slip.** The written Jacobi step $[[\mathfrak m,\mathfrak m],[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,[\mathfrak m,[\mathfrak m,\mathfrak m]]]$ drops one of the two terms the identity produces. Both terms have the same shape, so the containment holds; the display should carry both, as the $\mathfrak h$ and $\mathfrak r$ displays beside it do.

**Verdict: CONFIRMED.** The ideal argument is correct, and this is its first independent check, [r328](REVIEW_r328.md) authored it and [r327](REVIEW_r327.md) audited the version it replaced.

## Verdict 3, where simplicity is invoked, and why $n\ge5$ rather than $n\ge3$

**Simplicity is invoked in exactly one place**, the sentence *"$\mathfrak{so}(n)$ is simple for $n\ge5$ and $\mathfrak m\ne0$, so $\mathfrak g'=\mathfrak{so}(n)$"*, and it is **asserted, never cited**. It is true: $\mathfrak{so}(5)\cong\mathfrak{sp}(2)$ and $\mathfrak{so}(6)\cong\mathfrak{su}(4)$ are simple, $\mathfrak{so}(8)$ is simple with triality outer, and $\mathfrak{so}(4)$ is the one non-simple member. [conventions.md](../findings/conventions.md) tables the Killing form and the Killing constant of a simple subalgebra but carries no simplicity row, so the block's load-bearing algebraic input has no source anywhere on the record.

**$n=3$ is excluded because $\mathcal W_3=0$, and for no other reason.** $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$ vanishes at $n=3$, so there is no nonzero $W$ and the statement is vacuous there; $\mathfrak{so}(3)$ is itself simple and the ideal argument would run. So the honest range is $n\ge3$ with $n\ne4$, of which $n\ge5$ is the non-vacuous part. **The difference is cosmetic and the block's choice is the right one to print**, but the block gives no reason at all, which leaves a reader to guess that $\mathfrak{so}(3)$ might be the obstruction. One clause fixes it.

## Verdict 4, the measurement inside the algebraic proof: corroboration, and circular corroboration at that

> *"using only $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, measured off-$[\mathfrak m,\mathfrak m]$ residual $\le7\times10^{-16}$ at the balanced products and $0$ at $W_{\mathbb{CP}^2}$"*

**Nothing rests on it.** $[\mathfrak h,[\mathfrak m,\mathfrak m]]\subseteq[[\mathfrak h,\mathfrak m],\mathfrak m]+[\mathfrak m,[\mathfrak h,\mathfrak m]]\subseteq[\mathfrak m,\mathfrak m]$ is Jacobi plus one inclusion, and it is proved outright for every saturating point in any dimension. A measurement at four points adds nothing a proof of the general statement does not already give.

**And the points it measures are the theorem's own output.** The balanced products and $W_{\mathbb{CP}^2}$ are exactly the set L71 concludes with, so the measurement cannot see a saturating point that fails the containment, there are none to see, by the theorem. Worse, at those points $\mathfrak h=[\mathfrak m,\mathfrak m]$ already holds, so what is being measured is $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, true of any subalgebra whatsoever. **The residual $7\times10^{-16}$ is the floating-point noise of a tautology.**

The same reading applies to the *"Verified structure at the saturating points"* paragraph and to *"Searches found no saturating point outside the balanced products"*: both are measurements of the conclusion at the conclusion's own points, of a theorem that is now unconditional. [ELIM-bounds](ELIM-bounds.md) already asked for the search controls to be labelled as history rather than evidence; the same is owed here.

**Verdict: corroboration only, load-bearing nowhere.** The block should say so, or delete the clause. This is the third instance today of a measurement decorating a short proof, with [L99](../findings/diagonal-half.md)'s census of 400 points and [L107](../findings/bounds.md)'s post-dated derivations.

## Verdict 5, the uniqueness step's input $\dim\mathfrak h=n(n-2)/4$ arrives with no derivation and no citation

The uniqueness paragraph opens *"so the required $\dim\mathfrak h=\tfrac{n(n-2)}4$ forces $t=0$"*. **Required by what is never said, in this block or in [results.md](../results.md).** The block below it concedes the debt in a different context, *"the step to the closed form $\dim\mathfrak h(n-4)$ **assumes** $\dim\mathfrak m/\dim\mathfrak h=n/(n-2)$"*, discharged there by pointing at [r327](REVIEW_r327.md), but the uniqueness step, which needs the same ratio, points nowhere. A reader of L71 alone cannot get from $\mathfrak r=0$ to a dimension.

**It is three lines from the record's own relations, and here they are.** Work with $h=\lambda_{\max}$, $m=\lvert\lambda_{\min}\rvert$, and take relations (A) and (B) of [findings/bounds.md](../findings/bounds.md) at a row $k=v\in\mathfrak m$:

$$\text{(A)}\ \sum_{\beta\gamma}T_{v\beta\gamma}=2(n-2),\qquad\text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{v\beta\gamma}=-2\lambda_v=2m .$$

Saturation supports $T_{v\beta\gamma}$ on pairs with one index in $\mathfrak m$ and one in $\mathfrak h$, and $T$ is symmetric in $\beta,\gamma$, so (A)'s mass splits evenly: $(n-2)$ with $\beta\in\mathfrak m$ and $(n-2)$ with $\beta\in\mathfrak h$. Then (B) reads $(n-2)(-m)+(n-2)h=2m$, i.e.

$$(n-2)h=nm,\qquad\boxed{\ \frac{\lambda_{\max}}{\lvert\lambda_{\min}\rvert}=\frac n{n-2}\ }$$

Substituting into (C) gives $\theta=(n-2)h-m=(n-1)m$, which is [Lemma L117](../findings/bounds.md)'s conclusion. **Only now**, after $\mathfrak r=0$, so that $\mathop{\mathrm{tr}}W=0$ reads $h\dim\mathfrak h=m\dim\mathfrak m$ with no third term, does $\dim\mathfrak m/\dim\mathfrak h=h/m=n/(n-2)$ follow, and with $\dim\mathfrak m+\dim\mathfrak h=\binom n2$ it gives $\dim\mathfrak h=n(n-2)/4$ and $\dim\mathfrak m=n^2/4$.

**Two things this ordering settles that the block leaves implicit.**

- **The ratio does not need $\mathfrak r=0$; the dimensions do.** The derivation above uses only (A), (B) and the support condition. Checked against $W_{\mathbb{CP}^2}$ at $n=4$, where $\mathfrak r\ne0$: its spectrum is $(2a,-a,-a,0,0,0)$, so $h/m=2=n/(n-2)$, the ratio holds, while $\dim\mathfrak h=1$ against the formula's $2$, because $\dim\mathfrak h+\dim\mathfrak m=3\ne\binom42$. The block's order of steps is right; nothing on the record says why.
- **The arithmetic is consistent with $\theta_0$.** At $n=6$: $\dim\mathfrak h=6$, $\dim\mathfrak m=9$, $h=1.5m$, $\sum\lambda^2=6h^2+9m^2=22.5\,m^2=1$, so $m=0.2108$ and $\theta=(n-1)m=1.0541=\theta_0(6)$, matching [conventions.md](../findings/conventions.md)'s $\theta_0(n)^2=2(n-1)(n-2)/n^2$. Done by hand, under the record's $\sum\lambda^2=1$ normalisation.

**Verdict: REPAIRED.** The statement holds; the block owes the three lines above, or a citation to [r327](REVIEW_r327.md) at the point of use.

## Verdict 6, "the two routes are NOT independent": CONFIRMED, and the Cartan citation is missing entirely

**The block's own defect (iii) is right, and understated in one direction and overstated in none.** Both routes to uniqueness derive $\dim\mathfrak h$ by different means and then hand the identification to the same classification, so they are one derivation with two front ends, the same shape as [L107](../findings/bounds.md)'s "derived twice" this afternoon. [r327](REVIEW_r327.md) and [r328](REVIEW_r328.md) reached this independently and the block records it correctly.

**But the classification itself has no citation anywhere on the record.** No reference folder for Cartan, Helgason, or any classification of involutions of the compact $\mathfrak{so}(n)$ exists under [references/](../references/); the word "Cartan" appears in [ATTEMPTS.md](../ATTEMPTS.md), [routes.md](../routes.md) and several findings files, always as an appeal, never with a source. **A step that both uniqueness routes terminate in, and that the record has already been broken on once, is the last step that should be uncited.**

**On the level of generality**, the answer is Verdict 1: the block invokes the classification up to $\mathrm{Aut}$ and consumes $O(n)$-conjugacy, which is the wrong relation at $n=8$.

## Verdict 7, the deletion: CONFIRMED COMPLETE

Grepping the statement rather than the identifier, for the surviving phrases [r327](REVIEW_r327.md) listed, *"open half of Lemma L71"*, *"conjecture with a witness"*, *"named rather than hidden"*, *"Route (i) uses nothing"*, returns **nothing** in [findings/](../findings/), [results.md](../results.md) or [report/](../report/). `multiplicity formula` survives only in unrelated contexts ([ATTEMPTS.md](../ATTEMPTS.md)'s branching fit and a script index row). The one occurrence of $\mathfrak r\subseteq\ker W$ on the record is the deletion notice itself.

**Verdict: CONFIRMED.** This is the deletion the audit did apply. The one it did not is Verdict 1.

## Verdict 8, the quantifier and the $n=4$ classification: CONFIRMED, rebuilt in closed form

The block claims the $n=4$ critical points are exactly $\pm S^2\times S^2$ and $\pm W_{\mathbb{CP}^2}$ up to $O(4)$, and that the saturating ones are $S^2\times S^2$ and $W_{\mathbb{CP}^2}$ alone. **Rebuilt from scratch and confirmed.**

$Q$ acts blockwise on $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$, each block a traceless symmetric $3\times3$ with $A^\#=2\mathop{\mathrm{cof}}A$. With eigenvalues $a_1,a_2,a_3$ summing to zero, $Q_i=a_i^2+2a_ja_k=3a_i^2-p_2$, so criticality $Q_i=\theta a_i$ differenced over $i,j$ gives $3(a_i+a_j)=\theta$ whenever $a_i\ne a_j$, i.e. $(a_i-a_j)(3a_k+\theta)=0$, the block's equation, reproduced. All three distinct forces all three equal, a contradiction; so each block is $0$ or of type $(a,a,-2a)$, with $\theta=-3a$ read off either entry. A nonzero second block forces the same $a$, since the two blocks share $\theta$.

- **one block nonzero**: $6a^2=1$, $\theta=3/\sqrt6=\sqrt{3/2}$, $W_{\mathbb{CP}^2}$;
- **both blocks nonzero**: $12a^2=1$, $\theta=3/\sqrt{12}=\sqrt3/2=0.866=\theta_0(4)$, $S^2\times S^2$.

**The defect figures reproduce exactly.** Defect $=\lambda_{\min}+2\lambda_{\max}-\theta$. At $-W_{\mathbb{CP}^2}$, spectrum $(1,1,-2)/\sqrt6$ and $\theta=-\sqrt{3/2}$, the defect is $0+\sqrt{3/2}=1.224744871$; at $-(S^2\times S^2)$ it is $0+\sqrt3/2=0.866025404$. **Both match the block's recorded values to every printed digit**, and $S^2\times S^2$ and $W_{\mathbb{CP}^2}$ both come out at defect $0$. The sign-asymmetry correction [r329](REVIEW_r329.md) and [r330](REVIEW_r330.md) made is right.

**One thing the block does not say, and should.** At $n=4$ the saturating set contains a point at $\theta=\sqrt{3/2}$, which is **strictly above** $\theta_0(4)=0.866$, so the exception is not merely a dimension where the classification is longer, it is the one dimension where saturation fails to pin $\theta$ to $\theta_0$. That is the fact the conjecture cares about, and it is the reason padded $W_{\mathbb{CP}^2}$ is the record's standing competitor. Stated positively: *at $n\ge5$ saturation forces $\theta=\theta_0(n)$; at $n=4$ it permits $\theta=\sqrt{3/2}=M(4)$.*

## Verdict 9, what the new dimension theorem gives L71: neither a shorter proof nor a stronger statement, and one real gain at $n=4$

The theorem [r565](REVIEW_r565.md) and [r566](REVIEW_r566.md) proved an hour ago, *saturation forces $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$*, from the pair cap [L31](../findings/stratum-two-negative.md) and the Killing marginal alone, bears on L71 in three places, and only the third is a gain.

- **It does not shorten the proof.** The only dimension fact the chain consumes is $\mathfrak m\ne0$, which $\mathop{\mathrm{tr}}W=0$ at $W\ne0$ already gives in one line. Substituting $\dim\mathfrak m\ge n/2$ there replaces a one-line argument with a citation to a longer one.
- **It does not strengthen the statement at $n\ge5$.** L71 concludes $\dim\mathfrak m=n^2/4$ and $\dim\mathfrak h=n(n-2)/4$ exactly. Against those, $n/2$ and $(n-2)/2$ are weaker by a factor of $n/2$, the new bounds are a corollary of L71's conclusion, not an input to it.
- **It does upgrade the $n=4$ sentence, and that is worth taking.** At $W_{\mathbb{CP}^2}$ the spectrum is $(2a,-a,-a,0,0,0)$, so $\dim E_{\min}=2=n/2$ and $\dim E_{\max}=1=(n-2)/2$, **both bounds attained exactly**. The block currently says *"$n=4$ is the sole exception and it is structural: $\mathfrak{so}(4)$ is the only non-simple $\mathfrak{so}(n)$, and $W_{\mathbb{CP}^2}$ realises the exception exactly."* That sentence exhibits the exception; the dimension theorem makes it **extremal**, the exception sits at the floor of both bounds simultaneously, which is a statement about every saturating point rather than about one exhibited one.

**Consistency check across the two results, done by hand.** $W_{\mathbb{CP}^2}$'s $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$ is $\Lambda^+\cong\mathfrak{so}(3)$ of dimension $3=2+1$, and $\mathfrak r=\Lambda^-\cong\mathfrak{so}(3)$ of dimension $3$, with $[\Lambda^+,\Lambda^-]=0$ giving $[\mathfrak m,\mathfrak r]=0$ for free. Both the block's $n=4$ sentence and the new dimension theorem land on the same decomposition.

**Verdict on item (1): neither, plus one sentence.** Add the extremality clause to the $n=4$ paragraph; change nothing in the proof.

## Verdict 10, three symbols carrying the whole argument have no row in conventions.md, and two of them collide

[findings/conventions.md](../findings/conventions.md) is the file whose stated rule is that *"definitions and conventions are quoted, never restated"*. It tables $\Pi$'s four senses, $B$'s three, $M$'s two and $\mu$'s three. It carries **no row for $\mathfrak m$, $\mathfrak h$ or $\mathfrak r$**, and none for $E_{\min}$ or $E_{\max}$, which [r565](REVIEW_r565.md) flagged an hour ago.

**And $\mathfrak m$ is already a collision of exactly the tabled kind.**

| file | what $\mathfrak m$ means |
| --- | --- |
| [bounds.md](../findings/bounds.md), L71 | $E_{\min}$, the **minimal** eigenspace alone |
| [isotropy-cap.md](../findings/isotropy-cap.md), [Lemma L36](../findings/isotropy-cap.md) | the **whole negative eigenspace**, the span of every $\lambda<0$ |
| [target.md](../findings/target.md), [graded-half.md](../findings/graded-half.md) | the **odd part of a symmetric pair**, an algebraic object with no eigenvalue attached |

At a saturating point all three coincide, because there are exactly two eigenvalues, but **that coincidence is L71's conclusion, so it cannot be assumed when reading its hypothesis.** L36's cap $\dim\mathfrak m\le\lfloor n^2/4\rfloor$ is stated for the second sense; L71's $\dim\mathfrak m=n^2/4$ is the first. They agree here and would not agree at a point with three negative eigenvalues.

**Verdict: a defect of the record rather than of the lemma.** Three rows are owed in [conventions.md](../findings/conventions.md), one of them a collision row.

## Verdict 11, what cites L71, and whether the use is inside its hypotheses

Grepping the statement rather than the identifier:

| consumer | verdict |
| --- | --- |
| [results.md](../results.md) lines 22, 196, 568 | inside hypotheses, **but line 568 repeats the $n=8$ triality sentence**, so Verdict 1's repair is owed in two files |
| [Lemma L74](../findings/diagonal-half.md), the SRG family | inside. Checked independently: $K_{m,m}$ has $a$ at multiplicity $m^2=n^2/4$ and $2K_m$ has it at $m(m-1)=n(n-2)/4$, so the two label the *same* operator with the roles of $E_{\min}$ and $E_{\max}$ exchanged, and the record's "two sign branches of one point" is right, no conflict with saturation failing to be sign-invariant |
| [Theorem A](DERIVE-t11.md) and [DERIVE-mx2](DERIVE-mx2.md) | inside. mx2 uses L71 only at the equality of $(n-2)h-m\ge\theta\ge\theta_0(n)$, and already carries the odd-$n$ warning |
| [bounds-relaxations.md](../findings/bounds-relaxations.md) line 454 | **a correct guard**: it records that L71 characterises saturation of L70, not of the $\Pi$-bound, and refuses a use that would have been outside the hypotheses |
| [INDEX-results.md](../findings/INDEX-results.md) row 71 | states the content and **carries no Gate 2 marking**, unlike row 70. Accurate as of before this round |

## Verdict 12, "rigidity, not a route" against a block that reads as a strong positive result

[plan.md](../plan.md) opens with *"Lemma L71 is rigidity, not a route"*, and [ELIM-bounds](ELIM-bounds.md) §T2 gives the reason: the hypothesis *"saturates Lemma L70"* is the scalar equation $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$, checkable from $(\lambda,\theta)$ alone, so verifying it needs $\theta$, which is what a proof of the conjecture would be producing. **That reading is correct and I confirm it.**

**The L71 block does not carry it.** The demotion lives one section below, inside [Lemma L117](../findings/bounds.md)'s block, where a reader arrives only after L71's own heading, statement box, defect blockquote, deletion notice, uniqueness paragraph, verification paragraph and $n=4$ classification. Everything before it reads as an unconditional classification theorem (which it is), with no statement of what it cannot be used for.

**This is a placement defect, not a mathematical one.** The scope limit belongs in L71's own block, as a positive statement of what the lemma is: *a classification of the saturating set, whose hypothesis is a spectral identity and therefore an output of a proof rather than an input to one.* [ELIM-bounds](ELIM-bounds.md) recorded the same thing as *"a scope limit on Lemma L71 that the file does not record"*, and the file still does not record it.

## Overall verdict

**REPAIRED.** The statement of Lemma L71 is true as printed, at every $n\ge5$ and at $n=4$, and the ideal argument (the part that makes it unconditional), is correct and now has its first independent check. Two steps of the write-up do not reach the statement, and one of them was refuted three days ago by two reviewers independently and never fixed.

| # | finding | verdict |
| --- | --- | --- |
| 1 | the $n=8$ triality sentence proves list-completeness where the argument consumes $O(8)$-conjugacy; **refuted by [r329](REVIEW_r329.md) and [r330](REVIEW_r330.md) on 2026-09-01 and still standing in two files** | **REFUTED AS STATED / REPAIRED** |
| 2 | the chain from L70's equality case to $\mathfrak r=0$ and $\mathfrak h=[\mathfrak m,\mathfrak m]$ | CONFIRMED |
| 3 | simplicity invoked once, uncited; $n=3$ excluded by $\mathcal W_3=0$, unstated | CONFIRMED with two clauses owed |
| 4 | the off-$[\mathfrak m,\mathfrak m]$ measurement | corroboration only, and circular |
| 5 | $\dim\mathfrak h=n(n-2)/4$ asserted with no derivation or citation | REPAIRED, three lines from (A), (B) and the support condition |
| 6 | "the two routes are not independent" correct; **the classification has no citation anywhere on the record** | CONFIRMED / defect |
| 7 | the $\mathfrak r\subseteq\ker W$ deletion | CONFIRMED COMPLETE |
| 8 | the $n=4$ classification and the two defect figures | CONFIRMED, rebuilt in closed form |
| 9 | the new dimension theorem's effect on L71 | neither shortens nor strengthens; upgrades the $n=4$ sentence to extremality |
| 10 | $\mathfrak m$, $\mathfrak h$, $\mathfrak r$ absent from conventions.md, $\mathfrak m$ carrying three senses | defect of the record |
| 11 | consumers | all inside hypotheses; results.md carries the same triality defect |
| 12 | "rigidity, not a route" absent from L71's own block | placement defect |

**Analysis-only compliance.** No computation was run. Every figure in this report, $\theta_0(4)=\sqrt3/2$, $\theta_0(6)=1.0541$, $\sqrt{3/2}$, the defects $1.224744871$ and $0.866025404$, the spin weights on $V$, $S^+$, $S^-$, and the multiplicities $m^2$ and $m(m-1)$, was derived by hand from the definitions and is offered as derivation, not as measurement.
