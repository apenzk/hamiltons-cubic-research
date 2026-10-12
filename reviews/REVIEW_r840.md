# Review r840 on the row block: contracting the rows, the per-eigenvalue bound, and its claimed ceiling

*Gate 2, reviewer r840, cold brief. I read no other reviewer's log or report and wrote nothing to [INDEX.md](INDEX.md). **No screening was run and no script was executed**: every figure below is closed form, and the two catalogued points I use are reconstructed from the record's own relations ($\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$ and $\theta_0=(n-1)\lvert\lambda_{\min}\rvert$ at the balanced product, and $\lambda=(2,-1,-1)/\sqrt6$ at padded $W_{\mathbb{CP}^2}$) rather than measured. Log at [agent_logs/g2-rows-r840.log](../agent_logs/g2-rows-r840.log).*

## Claim table

| # | Claim under review | Verdict |
|---|---|---|
| 1 | Pairing (C) with any weight $w_k$ returns $\sum_kw_k\cdot2\lambda_k(\theta-\lambda_k)$ | **CONFIRMED AS AN IDENTITY** |
| 1b | "which is a relation among power sums and nothing else" | **OVER-BROAD: FALSE FOR A NON-SPECTRAL WEIGHT, AND WEAKER THAN THE TRUE STATEMENT** |
| 1c | The uncontracted rows number $N-1$ | **CONFIRMED, BY A DEPENDENCY THE BLOCK DOES NOT GIVE** |
| 2 | $\lambda^{\mathsf T}T^{(k)}\lambda=2\lambda_k(\theta-\lambda_k)$ at $T^{(k)}_{\alpha\gamma}=T_{\alpha k\gamma}$ | **CONFIRMED, AND THE MIDDLE SLOT IS IMMATERIAL** |
| 3 | $\sum_\gamma T_{\alpha k\gamma}=\lVert[v_\alpha,v_k]\rVert^2\le2$ is the pair cap | **CONFIRMED, AND IT COMES WITH A FREE ROW THE BLOCK DROPS** |
| 4 | Nonnegative entries and row sums $\le2$ give $\lvert\lambda^{\mathsf T}T^{(k)}\lambda\rvert\le2\lVert\lambda\rVert^2$ | **TRUE WITH ITS JUSTIFICATION ELIDED, AND THE CONSTANT $2$ IS SHARP FOR THE STATED HYPOTHESES AND WRONG FOR THE REAL ONES** |
| 5 | $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ and $\theta\le\lambda_{\max}+1/\lambda_{\max}$ | **CONFIRMED, WITH $\lambda_{\max}>0$ AVAILABLE AND ONE NOTATION COLLISION** |
| 6 | The screen: products $\tfrac13,-\tfrac23,-\tfrac23$ and the bound $2.041$ | **CONFIRMED EXACTLY, THE BOUND BEING $5/\sqrt6$** |
| 7 | "Its ceiling is $2$, which is why this use alone cannot reach the target" | **REFUTED OF THE USE, TRUE ONLY OF THE DISPLAY: THE SAME RELATION AT THE $\lambda_{\min}$ ROW HAS NO FLOOR AT $2$** |
| 7b | The repaired display $\theta\le1/\lambda_{\max}$ | **NEW, AND EXACT AT PADDED $W_{\mathbb{CP}^2}$ AT EVERY $n$** |
| 8 | The loss is in bounding $\lambda_{\max}(T^{(k)})$ by the cap, and (A) must be kept alongside it | **DIAGNOSIS CONFIRMED, PRESCRIPTION CONFIRMED, AND ALREADY CARRIED OUT $220$ LINES BELOW IN THIS FILE** |
| 9 | Scope: no $n\ge12$, no $S=0$, no non-diagonality, criticality rather than maximality | **CONFIRMED, WITH TWO HYPOTHESES THE BLOCK LEAVES UNSTATED** |
| 10 | Falsifiers | **NAMED, WITH NONE FOUND FOR ANY EQUATION AND TWO FOUND FOR THE HEADLINE** |

## The line someone can act on

**Every equation in the block is true, and the block's own inequality, repaired by a fact it states one line earlier and then forgets, gives $\theta\le1/\lambda_{\max}$ instead of $\theta\le\lambda_{\max}+1/\lambda_{\max}$, which is exact at padded $W_{\mathbb{CP}^2}$ and has no ceiling at $2$.** The forgotten fact is that $T$ vanishes on repeated indices, so row $k$ of $T^{(k)}$ is identically zero and the quadratic form sees only $\sum_{\alpha\ne k}\lambda_\alpha^2=1-\lambda_k^2$ rather than $\lVert\lambda\rVert^2=1$.

## Conventions

- $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)=-\tfrac12\operatorname{tr}(XY)$, the record's normalisation from [conventions.md](../findings/conventions.md). Throughout, $N:=\binom n2$.
- $\{v_\alpha\}$ is an orthonormal eigenbasis of $W$ with $Wv_\alpha=\lambda_\alpha v_\alpha$, $\sum_\alpha\lambda_\alpha=0$ and $\sum_\alpha\lambda_\alpha^2=\lVert W\rVert^2=1$.
- $c_{\alpha\beta\gamma}:=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ is totally antisymmetric, by ad-invariance of the form together with antisymmetry of the bracket, so $T_{\alpha\beta\gamma}:=c_{\alpha\beta\gamma}^2$ is totally symmetric, nonnegative, and **zero whenever any two indices coincide**. That last property is the hollowness [conventions.md](../findings/conventions.md) tables for a $3$-tensor, and it is load-bearing throughout section 4 below.
- $M:=T^{(k)}$, the symmetric $N\times N$ matrix $M_{\alpha\gamma}=T_{\alpha k\gamma}$ at a fixed $k$; $R_\alpha:=\sum_\gamma M_{\alpha\gamma}$ its row sums; $\mathbf 1$ the all-ones vector; $m:=\lvert\lambda_{\min}\rvert$.
- Sums over Greek indices run over ordered tuples, which is the reading under which (A), (B) and (C) carry their stated constants.
- $\rho(\cdot)$ is the spectral radius, and $\lambda_{\max}$ without an argument always means the largest eigenvalue of $W$, never of $M$.

## Hypothesis inventory

| Hypothesis | Where the block needs it | Status in the block |
|---|---|---|
| $Q(W)=\theta W$ as operators on $\Lambda^2$ | relation (C), which is that equation's diagonal | stated, and correct |
| $Q$ maps $\mathcal W_n$ into itself | the Lagrange condition carries no $\mathcal W_n$-projection, so (C) is the full diagonal | used silently, and this is the only place first Bianchi enters the block |
| $\lVert W\rVert=1$ | the constant $2\lVert\lambda\rVert^2=2$, hence the $1$ in $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$, and the $1-\lambda_k^2$ of the repair | assumed and unstated, and the display is not scale-consistent, $\theta$ being degree $0$ and $\lambda_{\max}+1/\lambda_{\max}$ neither homogeneous nor invariant |
| $\operatorname{tr}W=0$ with $W\ne0$ | $\lambda_{\max}>0$, without which the division at the last step is illegal | undischarged, and true |
| $T$ hollow | nowhere in the block, and it is what the block is missing | absent |
| pair cap $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ | the row-sum bound, and it holds at every $n$, on all of $\mathfrak{so}(n)$, with no Weyl input | stated, and correctly attributed |
| relation (A) | quoted in the diagnosis, used in no step | correctly described as discarded |
| relation (B) | used nowhere, and section 8 shows what it gives | not mentioned |
| $n\ge12$, $S=0$, non-diagonality, $W$ a maximiser | nowhere | correctly absent |

## 1. Contracting the rows, and what "cannot give more than the spectrum" is worth

**The identity is trivially true and its gloss is not.** Multiplying row $k$ of (C) by a number $w_k$ and summing gives $\sum_{k\beta\gamma}w_k\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=\sum_kw_k\cdot2\lambda_k(\theta-\lambda_k)$ by linearity, for any real numbers $w_k$ whatever. So claim 1 holds as written.

**The gloss "a relation among power sums and nothing else" is over-broad in two steps.** It is exact only when $w_k=f(\lambda_k)$ with $f$ a polynomial, in which case $\sum_kf(\lambda_k)\lambda_k(\theta-\lambda_k)$ is a combination of $\sum_k\lambda_k^j$ and $\theta\sum_k\lambda_k^j$. For a general spectral weight $f$ the right side is a spectral function that is not a power sum. And for a weight that depends on the eigenVECTORS, which is what the brief asks about, the right side is not spectral at all: $w_k=\langle v_k,Xv_k\rangle$ at a fixed $X\in\mathcal W_n$ makes $\sum_kw_k\cdot2\lambda_k(\theta-\lambda_k)$ a joint function of the spectrum and of the eigenframe's position relative to $X$, and that number is not determined by $(\lambda,\theta)$.

**But the escape is illusory, because the true statement is stronger than the one the block makes.** The full content of the family (C) is the $N$-vector $\big(2\lambda_k(\theta-\lambda_k)\big)_k$, whose $k$-th entry is a function of $\lambda_k$ and $\theta$ alone. A weight extracts a linear functional of a vector that is already known coordinatewise from $(\lambda,\theta)$, so no weight can extract anything the family does not already state, eigenvector-dependent weights included. What such a weight buys is a non-spectral *identity*, in which both sides are non-spectral and the row data cancels out of the difference. The correct formulation is therefore: **the family (C) is spectrally determined index by index, so every linear functional of it is, and the choice of weight is free of consequence.** The block's route to that conclusion runs through a false intermediate.

**Contracting (A) or (B) instead changes nothing and needs even less.** (A) gives $\sum_kw_k\cdot2(n-2)=2(n-2)\sum_kw_k$, which does not see the spectrum at all, and (B) gives $-2\sum_kw_k\lambda_k$. Both are spectrally determined index by index for the same reason.

**The count $N-1$ is right, and the block gives no reason for it.** The reason is a dependency: summing (C) over $k$ and using total symmetry,
$$\sum_k\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=\sum_\beta\lambda_\beta\sum_{k\gamma}\lambda_\gamma T_{\beta k\gamma}=\sum_\beta\lambda_\beta(-2\lambda_\beta)=-2 ,$$
by (B) at index $\beta$, while the right sides sum to $\sum_k2\lambda_k(\theta-\lambda_k)=2\theta\sum_k\lambda_k-2\sum_k\lambda_k^2=-2$. So one linear combination of the $N$ rows of (C) is a consequence of (B) with tracelessness and unit norm, and at most $N-1$ of them are independent of what the record already has. **That is a check the block owed and did not run, and it comes out in its favour.**

## 2. The quadratic-form reading and the index placement

**Correct, and the middle slot is immaterial.** $T$ is totally symmetric, so $T_{\alpha k\gamma}=T_{k\alpha\gamma}=T_{\alpha\gamma k}$ and the matrix $M_{\alpha\gamma}=T_{\alpha k\gamma}$ is symmetric in $\alpha\leftrightarrow\gamma$ as required for a quadratic form. Relation (C) reads $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=\sum_{\alpha\gamma}\lambda_\alpha\lambda_\gamma M_{\alpha\gamma}=\lambda^{\mathsf T}M\lambda$, so the identity is as stated.

**It matters in one direction only.** Nothing in the block depends on which slot carries $k$, but total symmetry is what makes the *row sums* of $M$ equal to the pair cap's quantity in the next step, and total symmetry is what makes the sum in section 1 collapse onto (B). So the fact is used twice and stated once.

## 3. The row sums, and the row the block leaves on the table

**It is the pair cap, at the same contraction and not a different one.** $\{v_\gamma\}$ is an orthonormal basis of $\Lambda^2\cong\mathfrak{so}(n)$ and $[v_\alpha,v_k]\in\mathfrak{so}(n)$, so Parseval gives
$$R_\alpha=\sum_\gamma M_{\alpha\gamma}=\sum_\gamma\langle[v_\alpha,v_k],v_\gamma\rangle^2=\lVert[v_\alpha,v_k]\rVert^2\le2 ,$$
which is the given cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ with $\beta=k$. No second contraction and no re-derivation.

**And the same line carries a fact the block does not collect.** At $\alpha=k$,
$$R_k=\lVert[v_k,v_k]\rVert^2=0 ,$$
so $M$ has an identically zero $k$-th row and column, and it has a zero diagonal for the same reason, $T$ being hollow. **Section 4 shows that this free fact, and not relation (A), is the cheapest repair of the block's constant.**

## 4. The bound on the form, the constant, and where Perron actually applies

**The block's inference is valid and its stated justification is incomplete.** From $\lambda_{\max}(M)\le2$ alone one gets $\lambda^{\mathsf T}M\lambda\le2\lVert\lambda\rVert^2$ and nothing about the other side, since a symmetric matrix with $\lambda_{\max}\le2$ may have $\lambda_{\min}$ arbitrarily negative. The repair is one line and it is where the brief's Perron question lands: **Perron applies to the matrix, not to the vector.** For a symmetric matrix with nonnegative entries, $\rho(M)=\lVert M\rVert_2\le\lVert M\rVert_\infty=\max_\alpha R_\alpha\le2$, so *both* extreme eigenvalues lie in $[-2,2]$ and $\lvert\lambda^{\mathsf T}M\lambda\rvert\le2\lVert\lambda\rVert^2$ for every $\lambda$, mixed signs included. The mixed signs of $\lambda$ never enter, because an operator-norm bound is sign-blind. A proof that avoids Perron entirely, and which section 4's improvement then sharpens, is
$$\lvert\lambda^{\mathsf T}M\lambda\rvert\le\sum_{\alpha\gamma}M_{\alpha\gamma}\lvert\lambda_\alpha\rvert\lvert\lambda_\gamma\rvert\le\tfrac12\sum_{\alpha\gamma}M_{\alpha\gamma}(\lambda_\alpha^2+\lambda_\gamma^2)=\sum_\alpha R_\alpha\lambda_\alpha^2\le2\lVert\lambda\rVert^2 . \tag{4.1}$$

**The constant $2$ is sharp for the hypotheses the block names.** Take $M_{12}=M_{21}=2$ and all other entries zero, and $\lambda=(1/\sqrt2,-1/\sqrt2,0,\dots,0)$. Then $M$ is symmetric, nonnegative, hollow, with row sums $\le2$; $\lambda$ has $\sum\lambda_\alpha=0$ and $\lVert\lambda\rVert=1$; and $\lambda^{\mathsf T}M\lambda=-2=-2\lVert\lambda\rVert^2$. So no argument using only nonnegativity, the cap, tracelessness and unit norm can improve $2$.

**But those hypotheses are strictly weaker than the truth, and the witness proves it.** That $M$ is not a $T^{(k)}$: relation (A) forces its entries to sum to $2(n-2)$ where they sum to $4$, and the two indices carrying the mass would have to avoid $k$, whose row is zero by section 3. Using the zero row, the last step of (4.1) improves for free to
$$\sum_\alpha R_\alpha\lambda_\alpha^2\le2\sum_{\alpha\ne k}\lambda_\alpha^2=2\big(1-\lambda_k^2\big) ,$$
so that
$$\boxed{\;\lvert\lambda_k(\theta-\lambda_k)\rvert\;\le\;1-\lambda_k^2\quad\text{at every }k.\;} \tag{4.2}$$
**This is strictly stronger than the block's $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ at every index where $\lambda_k\ne0$, it uses no ingredient the block does not already have on the page, and it is attained.** At padded $W_{\mathbb{CP}^2}$ with $\lambda_k=\lambda_{\max}=2/\sqrt6$ the left side is $\tfrac13$ and the right side is $1-\tfrac23=\tfrac13$, at every $n$. Equality there also reads off that the pair cap is saturated between $E_{\max}$ and $E_{\min}$ at that point, since (4.1) is an equality only if $R_\alpha=2$ on every row carrying a nonzero $\lambda_\alpha$.

## 5. The two conclusions

**Both follow.** From $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ at $k=\arg\max$, the upper half gives $\lambda_{\max}\theta-\lambda_{\max}^2\le1$, and $\lambda_{\max}>0$ permits division: $\theta\le\lambda_{\max}+1/\lambda_{\max}$. Only the upper half is used, and only at one index.

**$\lambda_{\max}>0$ is available and the block does not say so.** $\sum_\alpha\lambda_\alpha=0$ with $\lVert W\rVert=1$ forces at least one strictly positive eigenvalue. The same argument gives $\lambda_{\min}<0$, which section 7 needs.

**Among the positive indices the block picks the right one.** $x\mapsto x+1/x$ is decreasing on $(0,1)$ and every $\lambda_k$ lies in $(0,1)$ at unit norm, so $\lambda_{\max}$ gives the strongest member of the positive half of the family. **The choice is optimal within the half the block uses and not within the family**, which is section 7.

**One presentational defect.** The symbol $\lambda_{\max}$ carries the largest eigenvalue of $T^{(k)}$ in one clause and the largest eigenvalue of $W$ in the next, inside a single sentence and a single display. The record's own [conventions.md](../findings/conventions.md) warns about names carrying more than one object, and this is one.

## 6. The screen, recomputed in closed form

With $\lambda=(2,-1,-1)/\sqrt6$ on the support and $\theta=\sqrt{3/2}=3/\sqrt6$:

| index | $\lambda_k$ | $\theta-\lambda_k$ | $\lambda_k(\theta-\lambda_k)$ |
|---|---|---|---|
| $E_{\max}$ | $2/\sqrt6$ | $1/\sqrt6$ | $2/6=\tfrac13$ |
| $E_{\min}$, twice | $-1/\sqrt6$ | $4/\sqrt6$ | $-4/6=-\tfrac23$ |
| kernel, $N-3$ times | $0$ | $3/\sqrt6$ | $0$ |

so the three quoted products are exact, all three satisfy $\lvert\cdot\rvert\le1$, and the block's silence about the $N-3$ kernel indices is harmless because they give $0$. The bound is
$$\lambda_{\max}+\frac1{\lambda_{\max}}=\frac2{\sqrt6}+\frac{\sqrt6}2=\frac2{\sqrt6}+\frac3{\sqrt6}=\frac5{\sqrt6}=2.041241\ldots$$
against $\theta=1.224745\ldots$, confirming the quoted $2.041$ and giving it a closed form the block does not.

## 7. The ceiling claim, which is true of the display and false of the use

**The statement about the display is correct.** $\lambda+1/\lambda\ge2$ for every $\lambda>0$ by AM-GM, with equality at $\lambda=1$, so $\theta\le\lambda_{\max}+1/\lambda_{\max}$ never returns anything below $2$.

**The headline it supports is false. The block's own relation, at a non-maximal index, has no floor at $2$.** Relation (4.2)'s weaker form $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ is two-sided, and the block uses one side. At $k=\arg\min$ with $\lambda_k=-m$, $m>0$, the *other* side gives $-m(\theta+m)\ge-1$, that is
$$\theta\;\le\;\frac1m-m\;=\;\frac1{\lvert\lambda_{\min}\rvert}-\lvert\lambda_{\min}\rvert , \tag{7.1}$$
which is strictly decreasing in $m$ and drops below $2$ as soon as $m>\sqrt2-1=0.414214$. It is below the conjecture's own $\sqrt{3/2}$ as soon as $m\ge0.560220$, the positive root of $m^2+\sqrt{3/2}\,m-1$. So the conjunction over $k$ does better than the single best positive index whenever $\lvert\lambda_{\min}\rvert$ is large, and the block's "however the spectrum falls" is exactly the quantifier that fails. **This is the sixth instance of the pattern the brief names: a relation derived in full and then used in a strict weakening, here the weakening being one of the two signs of an absolute value the block wrote itself.**

**And with the free row of section 3, the display itself has no ceiling.** Feeding (4.2) instead of the block's $\le1$ into the same two steps:

- at $\lambda_k>0$: $\lambda_k\theta-\lambda_k^2\le1-\lambda_k^2$, the $\lambda_k^2$ cancels, and
$$\boxed{\;\theta\;\le\;\frac1{\lambda_{\max}}\;}\tag{7.2}$$
- at $\lambda_k=-m<0$: $m\theta+m^2\le1-m^2$, so
$$\theta\;\le\;\frac1m-2m . \tag{7.3}$$

(7.2) is the block's display **less $\lambda_{\max}$**, it drops below $2$ as soon as $\lambda_{\max}>1/2$, and it is **exact at padded $W_{\mathbb{CP}^2}$ at every $n$**: $1/\lambda_{\max}=\sqrt6/2=\sqrt{3/2}=\theta$. Equivalently, that point saturates $\theta\lambda_{\max}=1$. For contrast, on [Lemma L23](../findings/ungraded-slack.md)'s two-eigenvalue subalgebra family the same quantity is $\theta\lambda_{\max}=2/n$ exactly wherever [Lemma L107](../findings/bounds.md) is tight, since $\theta\lambda_{\max}=(n-1)\lvert\lambda_{\min}\rvert\lambda_{\max}=(n-1)/N=2/n$ using $\lvert\lambda_{\min}\rvert\lambda_{\max}=1/N$ for that family. That reproduces $\tfrac13$ at $n=6$ at the balanced product and at the maximal torus alike, and it says the new display is slack there by a factor $n/2$ and sharp at the low-rank point.

**Two members of the family also close a gap the record leaves open.** (7.3) with [Lemma L107](../findings/bounds.md)'s $\theta\le(n-1)m$ brackets $m$ from both sides, the first decreasing and the second increasing, so the worst case is the crossing at $m=1/\sqrt{n+1}$:
$$\theta\;\le\;\frac{n-1}{\sqrt{n+1}}\qquad\text{at every critical point.}$$
Since $\sup\lvert P\rvert=\sup P$ is attained at a critical point, where $P=\theta$, this is $M(n)\le(n-1)/\sqrt{n+1}$: $1.341641$ at $n=4$, $1.632993$ at $n=5$, $1.889822$ at $n=6$, $7/3$ at $n=8$, $3.050851$ at $n=12$. **That is the record's standing unconditional constant $M(n)\le n-1$ improved by a factor $\sqrt{n+1}$, and it settles $M(n)\le\sqrt3$ at $n=4$ and $n=5$**, which [second-order.md](../findings/second-order.md) names as the target its own $\theta\le\sqrt y+(n-2)y$ reaches only numerically. It stays above $\sqrt3$ from $n=6$, so it does not close [post F11](../findings/second-order.md)'s question.

## 8. The located loss, and what the rows give in full

**The diagnosis is right.** Relation (A) puts $\sum_{\alpha\gamma}M_{\alpha\gamma}=2(n-2)$, and row sums are capped at $2$, so at most $n-2$ of the $N=\binom n2$ rows can sit at the cap and the average row sum is $4(n-2)/\big(n(n-1)\big)$, which tends to $0$. Bounding every row by $2$ is therefore lossy at all but $O(n)$ rows out of $O(n^2)$, exactly as the block says.

**The prescription is right, it does improve the constant, and here is the improved bound.** Keeping (A) alongside the cap in (4.1), the last step becomes a fractional knapsack: maximise $\sum_\alpha R_\alpha\lambda_\alpha^2$ over $0\le R_\alpha\le2$ with $\sum_\alpha R_\alpha=2(n-2)$ and $R_k=0$. Its value is $2\Lambda_k$ with $\Lambda_k$ the sum of the $n-2$ largest $\lambda_\alpha^2$ over $\alpha\ne k$, so
$$\lvert\lambda_k(\theta-\lambda_k)\rvert\le\Lambda_k ,\qquad\text{hence}\qquad \theta\;\le\;\lambda_{\max}+\frac{\Lambda_{\arg\max}}{\lambda_{\max}} . \tag{8.1}$$
Since $\Lambda_k\le1-\lambda_k^2$ this dominates (7.2), which in turn dominates the block. Two closed-form values:

| point | block's display | (7.2) | (8.1) | $\theta$ |
|---|---|---|---|---|
| padded $W_{\mathbb{CP}^2}$, every $n$ | $5/\sqrt6=2.041241$ | $\sqrt6/2=1.224745$ | $\sqrt6/2=1.224745$ | $\sqrt{3/2}=1.224745$ |
| balanced product, $n=6$ | $\tfrac1{\sqrt{10}}+\sqrt{10}=3.478505$ | $\sqrt{10}=3.162278$ | $\sqrt{10}/2=1.581139$ | $1.054093$ |

At padded $W_{\mathbb{CP}^2}$, $\Lambda_{\arg\max}=2\cdot\tfrac16=\tfrac13$ at every $n$, because only two indices off $\arg\max$ carry a nonzero eigenvalue, and (8.1) returns $2/\sqrt6+1/\sqrt6=\sqrt{3/2}$ exactly. At the balanced product, $\Lambda_{\arg\max}=4\cdot\tfrac1{10}$ and (8.1) returns $\sqrt{10}/2$.

**But the prescription was already carried out, $220$ lines below, in this same file, and the block cites it nowhere.** The passage after [Lemma L107](../findings/bounds.md) reads row $a$ of (C) against the probability measure $\mu_a=T_{a\bullet\bullet}/2(n-2)$, whose normaliser *is* relation (A), and records the family $\theta\le\lambda_a+(n-2)M_a/\lambda_a$ for $\lambda_a>0$ and $\theta\le\lambda_a+(n-2)m_a/\lambda_a$ for $\lambda_a<0$, with the minimum over rows equal to $\theta_0(n)$ exactly at the balanced product on the negative side. **So "a use of the rows that survives must keep (A) alongside the cap" describes a use the file already contains, and "the $N-1$ uncontracted rows carry $\dots$ and [I71](../plan.md) is the item that asks what" understates what the record has by a whole family.** Two differences are worth keeping rather than merging: that family uses (A) and does not use the cap, while (8.1) uses both, and at padded $W_{\mathbb{CP}^2}$ the difference decides the answer, $(n-2)M_a=(n-2)/6$ growing without bound in $n$ where $\Lambda_a=\tfrac13$ does not. **(8.1) is therefore a strict strengthening of the recorded family at that point, and it recovers by two elementary steps the $\sqrt{3/2}$ that [r337](REVIEW_r337.md)'s convex-hull reading obtains there.** Neither dominates the other everywhere, since $(n-2)M_a$ can be the smaller when the extreme product pairs two eigenvalues of very different magnitude, so the usable statement is the minimum of the two, and the sharp statement is the transportation problem both relax: maximise $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma\mu_{\beta\gamma}$ over $\mu\ge0$ hollow, vanishing on index $k$, with row sums $\le2$ and total $2(n-2)$.

**And the block names the wrong relation as the missing one.** Relation (B) is not mentioned in the block at all, and with (A) and (C) it gives more than either repair above. The three relations are the three moments of the *same* matrix $M=T^{(k)}$ against $\mathbf 1$ and $\lambda$:
$$\mathbf 1^{\mathsf T}M\mathbf 1=2(n-2)\ \text{(A)},\qquad \mathbf 1^{\mathsf T}M\lambda=-2\lambda_k\ \text{(B)},\qquad \lambda^{\mathsf T}M\lambda=2\lambda_k(\theta-\lambda_k)\ \text{(C)} ,$$
the middle one because $\sum_{\alpha\gamma}T_{k\alpha\gamma}\lambda_\gamma$ is (B) after relabelling under total symmetry. Since $M\ge0$ entrywise, $x^{\mathsf T}Mx\ge0$ for every entrywise nonnegative $x$, and $x=\lambda+m\mathbf 1$ is one such, $m=\lvert\lambda_{\min}\rvert$. At $k=\arg\min$, so that $\lambda_k=-m$,
$$0\le x^{\mathsf T}Mx=\lambda^{\mathsf T}M\lambda+2m\,\mathbf 1^{\mathsf T}M\lambda+m^2\,\mathbf 1^{\mathsf T}M\mathbf 1=-2m(\theta+m)+4m^2+2(n-2)m^2=-2m\theta+2(n-1)m^2 ,$$
so $\theta\le(n-1)\lvert\lambda_{\min}\rvert$. **That is [Lemma L107](../findings/bounds.md) in four lines from the rows alone, with no cap, no measure, no chord and no Cauchy–Schwarz, and it is a third route to a bound the record derives twice elsewhere.** It is tight at the balanced sphere products, which is precisely the target this block says the rows cannot reach. So the sentence "**this use alone cannot reach the target**" is refuted twice over: the rows read at the $\lambda_{\min}$ index give a bound that equals $\theta_0(n)$ at the conjectured maximiser, and the choice of $x$ in the span of $\mathbf 1$ and $\lambda$ is the whole of the freedom, since those are the only two vectors against which the rows pin a moment.

## 9. Scope

**Nothing in the block needs $n\ge12$, $S=0$, non-diagonality, or maximality rather than criticality**, and this is correct as far as it is stated. Three qualifications:

- **First Bianchi enters once, through $Q(\mathcal W_n)\subseteq\mathcal W_n$.** Relation (C) is the diagonal of the operator equation $Q(W)=\theta W$, and that the Lagrange condition carries no $\mathcal W_n$-projection is the record's own result at [problem.md](../findings/problem.md), resting on first Bianchi. Beyond that the block needs Bianchi nowhere: total symmetry and hollowness of $T$, the pair cap and Parseval are facts about $\mathfrak{so}(n)$ with an ad-invariant form.
- **Unit norm is load-bearing and unstated in the block.** The constant $1$ in $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ is $\lVert\lambda\rVert^2$, and $\theta$ is scale-invariant while $\lambda_{\max}+1/\lambda_{\max}$ is neither invariant nor homogeneous, so the display holds on the unit sphere only. The record has paid for this omission before, at [Lemma L70](../findings/bounds.md) and at [L41](../results.md).
- **$\lambda_{\max}>0$ needs tracelessness**, which is a $\mathcal W_n$ hypothesis rather than a Lie-algebra one, and the block divides by $\lambda_{\max}$ without discharging it.

Relation (A) holds on all of $\mathfrak{so}(n)$ and relation (B) on all of $\mathcal W_n$, so the section 8 derivation of L107 needs criticality only through (C), which is consistent with the record's finding that L107 itself holds on all of $\mathcal W_n$ by a route that does not use (C).

## 10. What would falsify the block, and what I did

**Named falsifiers.**

1. A critical point with $\lvert\lambda_k(\theta-\lambda_k)\rvert>1$ at some $k$, which would refute the central inequality.
2. A critical point with $\theta>\lambda_{\max}+1/\lambda_{\max}$, refuting the display.
3. A weight $w_k$ whose contraction of (C) returns something not determined by $(\lambda,\theta)$ and $w$, refuting item 1.
4. A bound derived from $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ alone that returns less than $2$, refuting the ceiling claim.
5. A $T^{(k)}$ realising the extremal matrix of section 4, which would show the constant $2$ cannot be improved for the real hypotheses.

**What I did.** For 1 and 2, I recomputed the block's own screen in closed form (section 6) and checked the two-eigenvalue subalgebra family through the record's relations $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$ and $\theta_0=(n-1)\lvert\lambda_{\min}\rvert$, which give $\theta\lambda_{\max}=2/n$ there and hence enormous slack. No violation, and the stronger (4.2) survives both. For 3, I constructed the eigenvector-dependent weight $w_k=\langle v_k,Xv_k\rangle$, found that it does defeat the block's literal wording, and then found that it defeats nothing about the conclusion, which section 1 restates correctly. For 4, I took the sign the block discards and got (7.1), which falls below $2$ at $\lvert\lambda_{\min}\rvert>\sqrt2-1$: **falsifier 4 is realised, and it is the block's own inequality.** For 5, I exhibited the extremal matrix and then showed it is not realisable, since relation (A) fixes its total mass and section 3 forces its $k$-th row to vanish: **falsifier 5 is refuted, which is why (4.2) exists.**

**No numerical work was done.** Every number above is a closed-form evaluation of an expression derived by hand, and the two catalogued points are reconstructed from relations already on the record rather than measured. Under the discrepancy protocol, each of the two recorded discrepancies is located to a clause, exhibited concretely in closed form, and argued against: for item 1b the opposite case is that the block means only spectral weights, which is why the verdict is "over-broad" rather than "false", and for item 7 the opposite case is that "this use" means "the display", under which the sentence is true, which is why the verdict separates the two readings rather than refuting the block outright.

## Verdict

**GAP.** Every equation in the block is correct and every figure in its screen is exact. Two claims around them fail. The gloss that contracting (C) returns "a relation among power sums and nothing else" is false for a non-spectral weight and is weaker than the true statement, which is that the family is spectrally determined index by index. And the headline that this use cannot reach the target because its ceiling is $2$ is true of the display and false of the use: the discarded sign of the block's own $\lvert\lambda_k(\theta-\lambda_k)\rvert\le1$ gives $\theta\le1/\lvert\lambda_{\min}\rvert-\lvert\lambda_{\min}\rvert$, with no floor at $2$; the free fact that $T$ is hollow, stated one line above and never used, upgrades the display to $\theta\le1/\lambda_{\max}$, which is exact at padded $W_{\mathbb{CP}^2}$ at every $n$; keeping relation (A) as the block prescribes gives $\theta\le\lambda_{\max}+\Lambda/\lambda_{\max}$, a use the file already contains $220$ lines below and strengthens here by the cap; and the relation the block never mentions, (B), turns the same row at the $\lambda_{\min}$ index into [Lemma L107](../findings/bounds.md) in four lines, which is tight at the conjectured maximiser. **The rows are not the weak ingredient. They give $\theta\le(n-1)/\sqrt{n+1}$ at every critical point, improving the record's standing $M(n)\le n-1$ by $\sqrt{n+1}$ and settling $M(n)\le\sqrt3$ at $n=4$ and $n=5$.**
