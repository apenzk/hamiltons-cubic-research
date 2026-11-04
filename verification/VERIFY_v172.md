# Verifier v172, Lemma L11, the two-block sphere products, and the contradiction over $\min(p,q)=2$

Read cold from the definitions in [conventions.md](../findings/conventions.md) and from the four imported results at source, [L26](../findings/nondegeneracy.md), [L27](../findings/nondegeneracy.md), [L24](../findings/second-order.md), [L128](../findings/second-order.md), with [BRIEF_L11.md](BRIEF_L11.md) as the verbatim text under audit. **No numerical work was done: no script, no Sage, no floating point, no evaluation of any kind.** Every value below is exact and every derivation is three lines of integer algebra or a character evaluation. The 36-split sweep and the eight exact-arithmetic splits the block cites were neither repeated nor relied on. Log: [agent_logs/verify-L11-v172.log](../agent_logs/verify-L11-v172.log).

## The claim table

| # | Claim, as written | Where | Verdict |
| --- | --- | --- | --- |
| 1 | $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ follows from $\mu=\frac{n-2}{2(p-1)(q-1)}$ with $n=p+q$ | [nondegeneracy.md](../findings/nondegeneracy.md) L11 proof | **CORRECT** |
| 2 | $(p-2)(q-2)>1$ fails, among $p,q\ge2$, exactly at $\min(p,q)=2$ and at $(3,3)$ | same | **CORRECT** |
| 3 | At $p=2$, $\mu=\tfrac12+\frac1{2(n-3)}$, strictly above $\tfrac12$ | same | **CORRECT** |
| 4 | *"[L26](../findings/nondegeneracy.md) records the dangerous eigenvalue **reaching** $\tfrac12$ at $p=2$ with excess $\tfrac1{2(n-3)}>0$, which is degeneracy"* | [results.md:130](../results.md), [BRIEF_L11.md](BRIEF_L11.md) §D ¶2 | **BROKEN**, self-contradictory; a positive excess above $\tfrac12$ is not attainment of $\tfrac12$ |
| 5 | *"degenerate at $\min(p,q)=2$"* | [results.md:393](../results.md), [INDEX-results.md:26](../findings/INDEX-results.md) | **BROKEN**, false at native dimension, closed-form counterexample at $(2,2)$ |
| 6 | $\mu>\tfrac12$ costs maximality, not nondegeneracy | [BRIEF_L11.md](BRIEF_L11.md) §D ¶1 | **CORRECT** |
| 7 | *"at $\min(p,q)=2$ … the point is nondegenerate but not a maximiser"* | [BRIEF_L11.md](BRIEF_L11.md) §D ¶3 | **HYPOTHESIS-DEBT**, the "not a maximiser" half is proven; the "nondegenerate" half has no argument on file |
| 8 | The $S^2\times S^4$ spectrum $1,\tfrac12,0,\tfrac13,\pm\tfrac23$ with $\tfrac12$ at multiplicity $pq=8$ | [BRIEF_L11.md](BRIEF_L11.md) §D ¶1 | **GAP**, it is [L27](../findings/nondegeneracy.md)'s ten-summand template read at $q=2$, where [L126](../findings/second-order.md) and [L128.1](../findings/second-order.md) both record it over-counting $86$ against $84$ |
| 9 | The $(3,3)$ isomorphism *"is true and computes nothing"* | [BRIEF_L11.md](BRIEF_L11.md) §D ¶4 | **CORRECT** |
| 10 | *"the content lies in the representation isomorphism above"*, the same isomorphism as the mechanism | [BRIEF_L11.md](BRIEF_L11.md) §D trailing prose | **BROKEN**, refuted by an $O(3)\times O(3)$ character evaluation and by [L27](../findings/nondegeneracy.md)'s own text |
| 11 | Kernel $18$ against an orbit of $9$ at $(3,3)$ | same | **CORRECT** |
| 12 | The core statement: $p,q\ge3$, $(p,q)\ne(3,3)$ $\Rightarrow$ Morse–Bott nondegenerate, kernel $=$ orbit tangent of dimension $pq$ | [BRIEF_L11.md](BRIEF_L11.md) §D ¶1, §A, §B, §C | **PROVEN**, by [L27](../findings/nondegeneracy.md), subject to its own recorded import |
| 13 | The statement holds for padded sphere products ($\ker W\ne0$) | never stated; the block is silent | **BROKEN by omission**, [L126](../findings/second-order.md) gives $\tfrac1{2(p-1)}=\tfrac12$ at $p=2$ in closed form, so every padding of $S^2\times S^q$ is degenerate |
| 14 | *"a value-localised version survives"* | [nondegeneracy.md:454](../findings/nondegeneracy.md) | **BROKEN as worded**, what survives is a hypothesis not yet refuted, which the same file states correctly forty lines later |
| 15 | *"the rival maximizer satisfies the same identity"* | [results.md:130](../results.md) | **HYPOTHESIS-DEBT**, a theorem at $n=4$ natively and a measurement stopping at $n=10$ when padded |

## Summary, one line

**The two paragraphs are both wrong, in opposite directions, and the mathematics decides against the earlier one: at native dimension $\min(p,q)=2$ is not a degenerate family, because $\mu_{2,q}=\frac q{2(q-1)}$ exceeds $\tfrac12$ strictly at every $q\ge2$, but the corrected paragraph's replacement claim, that those points are nondegenerate, is asserted from a decomposition the record twice records as invalid there, and is circular against [L128](../findings/second-order.md).**

## 0. Conventions, fixed once

Quoted, not restated.

Morse–Bott nondegeneracy, from [nondegeneracy.md](../findings/nondegeneracy.md) line 49:

> A critical point is *Morse–Bott nondegenerate* when $\ker(\mathrm{Hess})$ equals the tangent space to the critical orbit through it, the standard definition.

The Hessian, from [Lemma L24](../findings/second-order.md):

> Let $W$ be a critical point with $\theta=P(W)>0$, put $e=W/\theta$, and let $L_e=e\circ(\cdot)$ where $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. The **Riemannian** Hessian of $P$ on the unit sphere of $\mathrm{Weyl}_n$ … is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$. Hence if $W$ is a **local** maximiser, $\lambda_{\max}\big(L_e|_{W^\perp}\big)\ \le\ \tfrac12$.

The reading of that identity, from [Lemma L128](../findings/second-order.md)'s proof of (ii):

> $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)\cap W^\perp$, an eigenspace, which is why the criterion excludes the value $\tfrac12$ rather than bounding the spectrum.

The orbit tangent, from [nondegeneracy.md](../findings/nondegeneracy.md) line 53, citing Nienhaus:

> $$T_{W_{S^k\times S^l}}\,SO(n).W_{S^k\times S^l}\;\cong\;\mathbb R^k\otimes\mathbb R^l,\qquad \dim=k\,l.$$

$\mu$ is **not tabled in [conventions.md](../findings/conventions.md)** in the sense used here. That file's only entry for the letter is the collision note:

> **$\mu$ CARRIES TWO MEANINGS THIRTY LINES APART IN [bispectral.md](../findings/bispectral.md), AND A THIRD IN [target.md](../findings/target.md).**

$\mu$ as [L26](../findings/nondegeneracy.md)'s $\Lambda^2\otimes\Lambda^2$ eigenvalue is a fourth sense, untabled. See §9.

## 1. Hypothesis inventory

**A pass with no inventory is not a pass, so here is the full list, and which of them the written proof uses.**

| hypothesis | where it lives | does L11's written proof use it? |
| --- | --- | --- |
| $\theta=P(W)>0$ | [L24](../findings/second-order.md) Scope: *"$\theta>0$ carries the division by $6\theta$ … and it carries the definition of $e=W/\theta$ itself, **two places, not one**"* | **used silently, never stated.** It holds at every $S^p\times S^q$ on record, so the omission costs nothing mathematically |
| $\mathrm{Hess}=6\theta(L_e-\tfrac12)$, hence $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)\cap W^\perp$ | [L24](../findings/second-order.md), restated in [L128](../findings/second-order.md)(ii) | **used and not cited.** The proof paragraph names only L26 and L27; the bridge from "$\dim E(\tfrac12)=pq$" to "Morse–Bott nondegenerate" is L24's, and neither L24 nor L128 appears in it |
| orbit tangent $\cong\mathbb R^p\otimes\mathbb R^q$, $\dim=pq$ | Nienhaus, quoted in [nondegeneracy.md](../findings/nondegeneracy.md) line 53 | **used and not cited in the proof paragraph**; it appears only in the trailing prose |
| $p,q\ge2$, $\pi$ a coordinate $2$-plane in the $p$-block, $\rho$ one in the $q$-block | [L26](../findings/nondegeneracy.md) Statement | **used**, and correctly scoped: the block writes *"which among $p,q\ge2$ fails only at …"* |
| $p,q\ge3$ and $(p,q)\ne(3,3)$; the ten-summand $O(p)\times O(q)$ decomposition; each summand irreducible; the ten dimensions summing to $\dim\mathrm{Weyl}_n$ | [L27](../findings/nondegeneracy.md) Statement | **used for the core range and silently over-run at $\min(p,q)=2$.** See §5 |
| criticality of the pieces, $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ | [L26](../findings/nondegeneracy.md) Argument | **used**, inside L26 |
| $n=p+q$, i.e. no padding | [L126](../findings/second-order.md) closing: *"Stated at $n=p+q$: under padding the nonzero blocks are no longer only the $(2,2)$-splits"* | **never stated in L11, and load-bearing.** See §7 |
| Nienhaus's irreducibility, proved in the source at $p,q\ge5$ and supplied by commutant computation at $m=3,4$ | [L27](../findings/nondegeneracy.md) | **used**; nothing on file supplies it at $m=2$. See §5 and §10 |

**Stated but never used.** Nothing in the L11 block states a hypothesis it then leaves idle. The nearest thing is the trailing prose's exact-arithmetic list, which is corroboration rather than hypothesis, and which [L27](../findings/nondegeneracy.md) has superseded, §8.

**Used but never stated.** Three, all in the table above: $\theta>0$; the L24 Hessian bridge; and $n=p+q$.

## 2. Claim 1, the closed form, derived

With $\mu=\dfrac{n-2}{2(p-1)(q-1)}$ and $p,q\ge2$ so that $(p-1)(q-1)\ge1$,

$$\tfrac12-\mu=\frac{(p-1)(q-1)-(n-2)}{2(p-1)(q-1)}.$$

Substituting $n=p+q$ in the numerator, $(p-1)(q-1)-(p+q-2)=pq-p-q+1-p-q+2=pq-2p-2q+3$, and $(p-2)(q-2)=pq-2p-2q+4$, so the numerator is exactly $(p-2)(q-2)-1$:

$$\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}.$$

**CORRECT.** The denominator is positive for $p,q\ge2$, so the sign is the numerator's:

- **positive** ($\mu<\tfrac12$) iff $(p-2)(q-2)>1$;
- **zero** ($\mu=\tfrac12$) iff $(p-2)(q-2)=1$;
- **negative** ($\mu>\tfrac12$) iff $(p-2)(q-2)<1$.

## 3. Claim 2, the criterion, and the edge at $p=1$

Over integers $p,q\ge2$ both factors $p-2,q-2$ are $\ge0$, so the product is a non-negative integer.

- $(p-2)(q-2)=1$ forces $p-2=q-2=1$, i.e. $(p,q)=(3,3)$. The other integer factorisation $(-1)(-1)$ needs $p=q=1$, excluded.
- $(p-2)(q-2)<1$ forces the product to be $0$, i.e. $p=2$ or $q=2$, i.e. $\min(p,q)=2$.

**CORRECT: the criterion fails exactly at $\min(p,q)=2$ and at $(3,3)$, among $p,q\ge2$.**

**At $p=1$** the closed form has denominator $2(p-1)(q-1)=0$ and $\mu$ does not exist. Nor does the eigenvector: [L26](../findings/nondegeneracy.md) builds $X$ from *"a coordinate $2$-plane inside the $p$-block"*, which needs $p\ge2$. Read formally, $(p-2)(q-2)>1$ becomes $-(q-2)>1$, false for every $q\ge2$, so a reader applying the criterion at $p=1$ would conclude "failure" from an expression whose denominator is zero. **The block does not fall into this**: it writes *"which among $p,q\ge2$ fails only at …"*, and [L126](../findings/second-order.md) adds the structural reason, *"$p=1$ is excluded structurally, Ricci-flatness forcing $M\equiv0$ there"*. Checked and clear.

**Orbit dimension at every admissible split.** $\binom{p+q}2=\binom p2+\binom q2+pq$ identically, so with isotropy algebra $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ the orbit has dimension exactly $pq$ at every $p,q\ge2$, at $p=2$ ($15-1-6=8$ at $(2,4)$), at $(3,3)$ ($15-3-3=9$), and at large $p,q$. The factor swap at $p=q$ has determinant $(-1)^p$ and is discrete either way, so it never changes the dimension. Checked and clear.

## 4. Claims 3, 4, 6, the disputed inference, decided

**At $p=2$, $q=n-2$:** $(p-1)(q-1)=n-3$, so

$$\mu=\frac{n-2}{2(n-3)}=\frac{(n-3)+1}{2(n-3)}=\tfrac12+\frac1{2(n-3)}.$$

Equivalently, in $q$ alone, $\mu_{2,q}=\dfrac q{2(q-1)}>\tfrac12$ for every $q\ge2$, since $q>q-1$. **$\mu$ is strictly above $\tfrac12$, at every $q$, with no exception and no upper bound on $n$.**

**What an eigenvalue strictly above $\tfrac12$ outside the orbit implies.** By [L24](../findings/second-order.md) the Hessian on $W^\perp$ is $6\theta(L_e-\tfrac12\mathrm{Id})$ with $\theta>0$. On the direction $X$ it is therefore $6\theta(\mu-\tfrac12)X=\frac{3\theta}{n-3}X$, **strictly positive**. So $W$ is not a local maximiser. That is the contrapositive of L24's own bound, and [L126](../findings/second-order.md) states the conclusion by name: *"$\mu_{2,q}=\frac q{2(q-1)}>\tfrac12$ at every $q$, so **no $S^2\times S^q$ is a local maximum**"*.

**What degeneracy requires.** By the definition in §0 together with L24, $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)\cap W^\perp$. A direction is in the kernel iff its eigenvalue **equals** $\tfrac12$. A direction at $\tfrac12+\frac1{2(n-3)}$ is not in the kernel, it is a strictly positive direction of the Hessian. **Degeneracy needs the value $\tfrac12$ itself; excess above it is the opposite of degeneracy.**

**So one of the two paragraphs did read an excess above $\tfrac12$ as attaining $\tfrac12$, and it is the earlier one.** [BRIEF_L11.md](BRIEF_L11.md) §D ¶2 writes *"the dangerous eigenvalue **reaches** $\tfrac12$ at $p=2$ with excess $\tfrac1{2(n-3)}>0$, a direction outside the orbit carrying the orbit's own eigenvalue, which is degeneracy"*. The clause is self-contradictory in seven words: a quantity carrying a positive excess over $\tfrac12$ does not carry $\tfrac12$. **Claim 4: BROKEN.** **Claim 6: CORRECT.**

### 4.1 The seed of the error is in [L26](../findings/nondegeneracy.md)'s own prose, not only in L11

[nondegeneracy.md:89](../findings/nondegeneracy.md) reads:

> So the family reaches $\tfrac12$ exactly at $p=2$, where it gives the recorded excess $\tfrac1{2(n-3)}$, and at $(p,q)=(3,3)$, where it is an equality.

L26 is using "reaches" for its own displayed "$\mu\ge\tfrac12$", and then distinguishes the two cases by "excess" against "equality". That is defensible inside L26, where the display is two lines above. It is what propagated, stripped of the display, into [results.md:130](../results.md), [results.md:393](../results.md) and [INDEX-results.md:26](../findings/INDEX-results.md), where nothing remains to warn the reader that "reaches" means "meets or exceeds". **The one-word repair is L26's, and it is upstream of all three.**

### 4.2 Claim 5, a closed-form counterexample to *"degenerate at $\min(p,q)=2$"*

Take $(p,q)=(2,2)$, $n=4$. [L26](../findings/nondegeneracy.md) records the spectrum in its own text: *"at $(2,2)$ … the spectrum is $(-1)^4,(\tfrac12)^4,1^2$, and $1$ is not simple"*. Then:

- $\mu_{2,2}=\frac{4-2}{2\cdot1\cdot1}=1$, which is exactly the second $1$ in that list, $L_ee=e$ supplies the first.
- The multiplicities sum to $4+4+2=10=\dim\mathcal W_4$, so the list is the whole spectrum with nothing hidden.
- $\dim E(\tfrac12)=4$.
- $\dim\mathcal O=\binom42-\binom22-\binom22=6-1-1=4=pq$.
- $\theta=\sqrt3/2>0$ ([second-order.md:255](../findings/second-order.md) assigns $0.866$ to $S^2\times S^2$), so L24 applies.
- $E(\tfrac12)\subseteq W^\perp$ automatically, since $L_ee=e$ and $L_e$ is self-adjoint.

Hence $\ker\mathrm{Hess}=E(\tfrac12)=4=\dim\mathcal O$: **$S^2\times S^2$ is Morse–Bott nondegenerate, and it is a saddle**, $\lambda_{\max}=1>\tfrac12$, which [second-order.md:255](../findings/second-order.md) records independently (*"$\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ is a $\circ$-orthogonal sum, so $\lambda_{\max}(L_e|_{W^\perp})=1$ there"*). **A universal claim over $\min(p,q)=2$ is refuted by one member. Claim 5: BROKEN.**

*Caveat carried, not hidden.* $n=4$ is a special dimension, L26 itself notes *"at $(2,2)$ the operator $e$ is non-primitive under the Hodge splitting of $\Lambda^2(\mathbb R^4)$"*. The caveat concerns primitivity of $e$, not the recorded spectrum, so the count above stands. The dimension-independent half of the refutation needs no witness at all: $\mu_{2,q}>\tfrac12$ strictly at every $q\ge2$, so the family L26 exhibits **never** sits at $\tfrac12$ anywhere on $\min(p,q)=2$, and the cited evidence for degeneracy there is empty at every $n$.

### 4.3 Discrepancy protocol, applied to claims 4 and 5

1. **Located.** [results.md:393](../results.md) title clause "degenerate at $\min(p,q)=2$"; [results.md:130](../results.md) "reaching $\tfrac12$ with excess $\tfrac1{2(n-3)}>0$"; [INDEX-results.md:26](../findings/INDEX-results.md) "two exceptional families, not one"; [BRIEF_L11.md](BRIEF_L11.md) §D ¶2. The missing definition is the one in §0, degeneracy is attainment of the value $\tfrac12$, which L128(ii) states in as many words.
2. **Failure exhibited in closed form.** $\mu_{2,q}-\tfrac12=\frac1{2(q-1)}>0$ at every $q\ge2$, and $(2,2)$ above, with $\ker\mathrm{Hess}=4=\dim\mathcal O$.
3. **The opposite argued.** The most charitable reading the words support is **the padded one**, and it is *true*. [L126](../findings/second-order.md) supplies the mechanism in closed form: *"A four-set carrying two indices from the first factor, one from the second and one **padded** index has $L_e$ value $\frac1{2(p-1)}$, which is exactly $\tfrac12$ at $p=2$ for every $q$."* And $\frac1{2(p-1)}=\tfrac12$ iff $p=2$. So padded $S^2\times S^q$ *is* degenerate at every padding and every $q$, which is exactly what [nondegeneracy.md:409](../findings/nondegeneracy.md) records from the other side: *"the whole $S^2\times S^k$ family is nondegenerate natively but degenerate at every larger $n$"*. **The dispute is a scope collapse: the refuted paragraph is right about padded $S^2\times S^q$ and wrong about native $S^2\times S^q$, and L11 says which nowhere.** That is the repair the record actually needs, and it is stronger than deleting the clause.

## 5. Claims 7 and 8, the corrected paragraph over-claims, and its witness is out of range

The proof paragraph asserts: *"at $\min(p,q)=2$, $\mu>\tfrac12$ and the point is nondegenerate but not a maximiser."* The second half is proven (§4). **The first half is not, and the record says so twice.**

**Why L26 cannot give it.** L26's own scope note: *"An exhibited eigenvector bounds $\lambda_{\max}$ and one multiplicity from **below**. The statements nondegeneracy needs (that $(3,3)$ is the *unique* split reaching $\tfrac12$, and that $\dim E(\tfrac12)=pq$), are upper bounds on the rest of the spectrum, which no eigenvector supplies."* Showing $\mu\ne\tfrac12$ at $p=2$ removes one candidate from the kernel and says nothing about the other summands.

**Why L27 cannot give it.** L27's statement is $p,q\ge3$, and it names $q\le2$ as the case where *"the decomposition itself is false, the ten dimensions over-counting by $2$ at $q=2$ … at every $n$"*.

**Rebuilding the quoted $S^2\times S^4$ spectrum cold, in closed form.** The ten values in L27's template, at $(p,q)=(2,4)$, $n=6$: $1$ on $\langle W\rangle$; $\tfrac12$ on $\mathbb R^2\otimes\mathbb R^4$; $\lambda_2=\frac{2-2}{2\cdot1}=0$ on $S^2_0(\mathbb R^2)$; $\lambda_4=\frac{4-2}{2\cdot3}=\tfrac13$ on $S^2_0(\mathbb R^4)$; $+\mu_{2,4}=\frac{6-2}{2\cdot1\cdot3}=\tfrac23$ on $\Lambda^2\otimes\Lambda^2$; $-\mu=-\tfrac23$ on $S^2_0\otimes S^2_0$; $0$ on the remaining four. **This reproduces $1,\tfrac12,0,\tfrac13,\pm\tfrac23$ exactly, so the quoted list is the template evaluated at $(2,4)$ and nothing else.**

Now the dimensions, with the true value $\dim\mathrm{Weyl}_2=0$ rather than the polynomial's $-2$:

$$1+0+10+8+2+9+18+6+0+32=86,\qquad \dim\mathrm{Weyl}_6=\frac{6\cdot3\cdot7\cdot8}{12}=84.$$

The ten spaces over-count by $2$. This is not my inference against the record, it is the record's own figure, in two places: [L128.1](../findings/second-order.md), *"at $p=2$ it over-counts, $86$ against $84$ at $S^2\times S^4$"*; and [L126](../findings/second-order.md)'s box, *"[Lemma L27]'s decomposition **over-counts at $p=2$**, $86$ against $\dim\mathrm{Weyl}_6=84$ at $S^2\times S^4$, so the summand route does not reach this case"*.

**The multiplicity is the load-bearing part, and it is what the over-count puts in doubt.** The claim that decides nondegeneracy is *"$\tfrac12$ at multiplicity $pq=8$, exactly the orbit"*, an upper bound on $\dim E(\tfrac12)$. The lower bound $\ge8$ is free from Nienhaus's orbit tangent. The upper bound comes only from "the summands exhaust $\mathrm{Weyl}_n$ and only one carries $\tfrac12$", and the summands do not exhaust $\mathrm{Weyl}_6$ at $(2,4)$, they over-shoot it. **So the spectrum settles the dispute only in the direction that was never contested.**

**Two further checks, both cold, on how far the template can be trusted here.**

- **The trace test does not detect the failure.** $\mathop{\mathrm{tr}}L_e=0$ unconditionally ([L27](../findings/nondegeneracy.md)). At $(2,4)$ the template gives $1\cdot1+\tfrac12\cdot8+\tfrac13\cdot9-\tfrac23\cdot18+\tfrac23\cdot6=1+4+3-12+4=0$. It passes. **A passing trace at $q=2$ is therefore not evidence that the list is right there**, the over-counted dimensions carry eigenvalue $0$ and are invisible to it.
- **At $(3,3)$ the same count closes.** $1+0+0+9+5+5+25+9+15+15=84$, and the trace is $1+\tfrac12\cdot9+\tfrac14\cdot10-\tfrac12\cdot25+\tfrac12\cdot9=1+4.5+2.5-12.5+4.5=0$. So the decomposition genuinely holds at $(3,3)$ and genuinely fails at $(2,4)$, exactly as L27 states.

**And [L127](../findings/second-order.md) names the surviving hole precisely.** Its box records that the within-factor row is *"false at $p=2$: … at $p=2$ the block is entirely $-\mu$ and the stated top $\frac{p-2}{2(p-1)}=0$ is **not in the spectrum at all**, at $S^2\times S^4$ it is $(-\tfrac23)^3$ against a printed $0$"*, and continues: *"the $\mathcal D_n$ row's stated source has the same gap, [r392](../reviews/REVIEW_r392.md) having recommended the repair"*. The $\mathcal D_n$ row is quoted *"from [Lemma L27](../findings/nondegeneracy.md)'s summands"*.

**GAP, stated as what would have to be proved:** *at $S^2\times S^q$ with $n=p+q$, the $L_e$-spectrum of $\mathcal D_n\cap W^\perp$ omits the value $\tfrac12$.* With that and no more, [L128](../findings/second-order.md)(ii) closes, the four-set family is $\{\mu_{2,q},0\}$ with $\mu_{2,q}>\tfrac12$ by [L126](../findings/second-order.md), the cross-factor pair blocks are $\{\tfrac12$ simple on the orbit$,0^{n-4}\}$ and the within-factor blocks are $\{-\mu,\lambda_q,0\}$ by [L127](../findings/second-order.md), all by results whose derivations rest on [L120](../findings/second-order.md) and [L121](../findings/second-order.md) rather than on L27's summand list. **I have not supplied that proof and do not attempt one.** Until it exists, *"the point is nondegenerate"* at $\min(p,q)=2$ has no argument on file.

### 5.1 The corrected paragraph's corroborating citation is circular

The paragraph closes: *"**[Lemma L128](../findings/second-order.md) says the same and is right.**"* L128's box reads: *"$S^2\times S^4$ at $n=6$ is pure, critical and Morse–Bott nondegenerate ([Lemma L11](../findings/nondegeneracy.md)), while its $(2,2)$ four-set blocks sit at $\mu_{2,4}=\tfrac23>\tfrac12$."* **L128 cites L11 for the nondegeneracy and L121 only for the value $\tfrac23$; L11 cites L128 for the nondegeneracy.** Neither derives it. The only non-circular content shared by the two is $\mu_{2,4}=\tfrac23>\tfrac12$, which is the non-maximality half.

## 6. Claims 9, 10, 11, the $(3,3)$ exception, and which of the two readings is right

The block says both of these, thirteen lines apart:

- ¶4: *"$\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$. **That isomorphism is true and computes nothing**, it is a coincidence of dimension in three variables"*;
- trailing prose: *"two copies land on the same eigenvalue … the equivariant decomposition organises the computation without proving the result, and **the content lies in the representation isomorphism above**."*

**The first is right, by a character evaluation.** For $\dim V=3$, $\Lambda^2V\cong V^*\otimes\det V$, so over $\mathbb R$ with $V$ the standard $O(3)$-representation, $\Lambda^2\mathbb R^3\cong\mathbb R^3\otimes\det$. Evaluate at $-I\in O(3)$: on $\mathbb R^3$ the trace is $-3$; on $\Lambda^2\mathbb R^3$ each basis bivector picks up $(-1)^2=+1$, trace $+3$. Hence $\Lambda^2\mathbb R^3\not\cong\mathbb R^3$ as $O(3)$-representations. Taking outer products, at $(-I,I)\in O(3)\times O(3)$ the character of $\Lambda^2\boxtimes\Lambda^2$ is $3\cdot3=9$ and that of $\mathbb R^3\boxtimes\mathbb R^3$ is $(-3)\cdot3=-9$. **The two summands are non-isomorphic under $O(3)\times O(3)$** (which is precisely the group in which L27's multiplicity-freeness lives) and isomorphic only after restricting to $SO(3)\times SO(3)$, where $\det$ is trivial.

This is L27's own finding, stated there as *"an **eigenvalue coincidence, not representation mixing**: under $O(3)$, $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det\not\cong\mathbb R^3$, measured as $\dim\mathrm{Comm}_{O(3)^2}=2$ against $\dim\mathrm{Comm}_{SO(3)^2}=4$"*. And even in the group where the isomorphism does hold, it settles nothing: a commutant of dimension $4$ is a $2\times2$ matrix algebra, in which a symmetric element has two eigenvalues that are free to differ. **Isomorphic summands do not carry equal scalars.** The block's own line says this (*"multiplicity-freeness forces one scalar per piece but never forces the scalars apart"*) and then draws the opposite conclusion in the same sentence group.

**Claim 9: CORRECT. Claim 10: BROKEN.** The trailing prose is stale refuted text still standing inside the block, and the same refuted mechanism stands a third time outside it, at [nondegeneracy.md:127](../findings/nondegeneracy.md): *"At $k=l=3$, $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$ (the orbit's own irrep) so two copies land on $\tfrac\theta2$."*

**Claim 11, the arithmetic: CORRECT.** At $(3,3)$, $\mu=\frac{6-2}{2\cdot2\cdot2}=\tfrac12$, so both $\mathbb R^3\otimes\mathbb R^3$ (dimension $9$) and $\Lambda^2\otimes\Lambda^2$ (dimension $3\cdot3=9$) sit at $\tfrac12$: $\dim E(\tfrac12)=18$ against $\dim\mathcal O=\binom62-3-3=9$, excess $9$. The *mechanism* is that $\mu$ solves $(p-2)(q-2)=1$, which over the integers is $(3,3)$ alone, a Diophantine fact, not a representation-theoretic one. The record's independent restatement, [L126](../findings/second-order.md)'s $\frac1{p-1}+\frac1{q-1}=1\iff(u-1)(v-1)=1\iff u=v=2$, is the same fact in the same closed form.

## 7. Claim 13, $\ker W\ne0$ and padded sphere products

**Answered by name, and it is the block's most consequential omission.**

L11's statement is *"$S^p\times S^q$ is Morse–Bott nondegenerate"*, with no dimension attached. Read at face value it covers the zero-padded operator in $\mathcal W_N$, $N>p+q$, which [nondegeneracy.md:409](../findings/nondegeneracy.md) establishes is *"already in $\mathrm{Weyl}_n$"* and critical at the same $\theta$. Under that reading the statement is **false**, and the record says so from two independent directions:

- **In closed form**, [L126](../findings/second-order.md): a four-set with two indices from the first factor, one from the second and one padded has $L_e$ value $\frac1{2(p-1)}$, equal to $\tfrac12$ exactly at $p=2$, so every padding of $S^2\times S^q$ is degenerate. At $p\ge3$ that same value is $\le\tfrac14<\tfrac12$, so this particular block manufactures no degeneracy there.
- **As measurement**, [nondegeneracy.md:409](../findings/nondegeneracy.md): *"Padding does **not** preserve nondegeneracy: $S^3\times S^3$ keeps excess $9$ at $n=6\ldots14$ including odd $n$ … and the whole $S^2\times S^k$ family is nondegenerate natively but degenerate at every larger $n$ with excess growing linearly, $4(n-4)$ for $S^2\times S^2$."*

The two agree, and the closed-form one is the mechanism for the measured one. **The block's only hint of native scope is the phrase "at the same $n=6$" in its trailing prose.** The statement needs "$n=p+q$" written into it; [L126](../findings/second-order.md) writes it into its own, and [L28](../findings/nondegeneracy.md) is likewise *"stated at $m\ge3$ in native dimension"*.

**Odd $n$ and the smallest admissible dimension, checked.** The core range $p,q\ge3$, $(p,q)\ne(3,3)$ has smallest members $(3,4)$ at $n=7$ (odd) and $(3,5)$, $(4,4)$ at $n=8$. Nothing in L27's argument distinguishes parity, the summand dimensions and the two inequalities $\tfrac12-\lambda_m=\frac1{2(m-1)}>0$ and $\tfrac12-\mu>0$ are polynomial in $p,q$, and the $(3,4)$ case is exactly where [L26](../findings/nondegeneracy.md) records a *separate* subtlety, that $\mu=\tfrac5{12}$ overtakes $\lambda_{\max(p,q)}=\tfrac13$ so the gap is $\tfrac1{12}$ rather than $\frac1{2\max(p,q)-2}$. That affects the size of the gap, not its sign, so nondegeneracy is untouched at $(3,4)$. Checked and clear.

## 8. The sweep, and a claim proven on a subfamily

The trailing prose reads as an evidence list: *"Verified at all 36 splits with $k,l\ge2$ up to $n=14$, and established in **exact arithmetic** … at eight of them"*, closing *"$S^7\times S^7$ at $n=14$ rests on floating point."* Three observations, none of them a numerical claim of my own:

- **The stated scope is internally consistent.** Splits $2\le k\le l$, $k+l=n\le14$ number $1,1,2,2,3,3,4,4,5,5,6$ at $n=4,\ldots,14$, summing to $36$. So the sweep is over $k,l\ge2$, a range *including* the disputed $\min=2$ family and *bounded* at $n\le14$, under a statement with no upper bound. As evidence for a claim quantified over all $p,q$ it is an open hypothesis, per the standing rule.
- **It is now superseded and the prose does not say so.** [L27](../findings/nondegeneracy.md) proves the core range at every $p,q\ge3$ with $(p,q)\ne(3,3)$, so the sweep and the floating-point entry at $(7,7)$ are corroboration whose failure would cost nothing. The paragraph still reads as though they carried the result.
- **The "eight" splits and the missing name.** The block names seven ($(4,4)$, $(3,5)$, $(5,5)$, $(3,7)$, $(6,6)$, $(5,7)$, $(3,9)$) while saying "eight". [nondegeneracy.md:123](../findings/nondegeneracy.md) lists the eight: *"$(4,4),(3,5),(2,6)$; $(5,5),(3,7)$; $(6,6),(5,7),(3,9)$"*. **The one the block omits is $(2,6)$**, the only $\min(p,q)=2$ entry, and the one bearing directly on the dispute. Whether or not that omission was deliberate, it removes from view the record's own exact-arithmetic entry at a $p=2$ split.

## 9. Symbol collisions

- **$\mu$.** [conventions.md](../findings/conventions.md) tables three senses ($\Lambda^2$ spectrum and $-\min\omega$ in [bispectral.md](../findings/bispectral.md), a third in [target.md](../findings/target.md)). L26/L27/L11/L126/L127 use a fourth, the $L_e$-eigenvalue on $\Lambda^2\otimes\Lambda^2$, equivalently on the $(2,2)$-split four-set blocks, **which is not in the table.** It is used consistently across those five blocks, so nothing is mis-derived; the debt is documentary.
- **$p$.** Collides with [conventions.md](../findings/conventions.md)'s tabled *"$p=\lfloor m/2\rfloor$, the torus rank"* in [isotropy-cap.md](../findings/isotropy-cap.md), and with the prime modulus in the exact-arithmetic prose (*"modulo two primes"*, *"$\mathrm{rank}_p$"*, *"$\mathrm{nullity}_p$"*), the latter **inside L11's own block and the display at [nondegeneracy.md:121](../findings/nondegeneracy.md)**, where $\mathrm{rank}_p$ and $\mathrm{nullity}_p$ sit twenty lines from a $\mu$ whose denominator is $2(p-1)(q-1)$. Read from context; no derivation is affected, but the two live within one screen of each other.
- **$q$.** Tabled in [conventions.md](../findings/conventions.md) as carrying two further senses in [stratum-two-negative.md](../findings/stratum-two-negative.md). Unambiguous here.
- **$k,l$ against $p,q$.** The statement, L26 and L27 use $p,q$; the trailing prose of the same block switches to $k,l$ (*"For $S^k\times S^l$ the common value is $k\,l$"*, *"36 splits with $k,l\ge2$"*, *"That isomorphism holds for no other $(k,l)$"*). Same objects, two alphabets, inside one block. Cosmetic, and it makes the $k,l\ge2$ scope of the sweep read as though it were a different family from the $p,q\ge3$ statement.
- **$n$.** Used for $p+q$ throughout L11, L26, L27, L126, L127, and for the *ambient* dimension in the padding passages at [nondegeneracy.md:409](../findings/nondegeneracy.md) and in [L126](../findings/second-order.md)'s padding clause. **This is the collision that produced §7's omission**: "$S^p\times S^q$ at $n$" means two different objects on the two sides of it.

## 10. An imported theorem whose hypotheses were checked against the object

The brief names a precedent, a cited theorem assuming a *unital* algebra, while $\mathcal W_n$ has no unit. I looked for the analogue and found one, already flagged inside L27 rather than hidden:

**Nienhaus, [arXiv:2311.02404](https://arxiv.org/abs/2311.02404), Proposition 4.6 and Remark 4.7(ii).** L27 states its own audit of the import: *"**Each summand is irreducible under $O(p)\times O(q)$ for every $p,q\ge3$** … The multiplicity-freeness at $p,q\le4$, asserted rather than proved in the source, is supplied by exact $O(m)$-commutant computation at $m=3,4$ … The $p,q\ge5$ case is proved in the source."* So the source's hypothesis is $p,q\ge5$; the gap at $m=3,4$ is filled by computation and labelled as such; **and nothing at all covers $m=2$.** The orbit-tangent identification quoted at [nondegeneracy.md:53](../findings/nondegeneracy.md) is stated *"for **any** $k+l=n$"*, but the decomposition it sits inside demonstrably fails at $q=2$ by its own dimension count. **So the import is correctly checked in the core range and unchecked at the value the corrected paragraph relies on**, the same conclusion as §5, reached from the source rather than from the arithmetic.

## 11. Claim 14, the trailing prose's last paragraph

[nondegeneracy.md:454](../findings/nondegeneracy.md):

> The use intended for it, that *every* graded critical point is nondegenerate, hence the graded set is a union of connected components, **is false**: the Kähler family $\mathfrak{su}(m)$ and the two-block plateau at the rival maximizer are graded and Morse–Bott degenerate, with kernel excesses of $5$, $9$, $14$, $20$ and $16$ … Every known exception sits at value at most $1.054$ … so a **value-localised** version survives: on $\{\,\theta\ge t\,\}\cap\mathrm{Crit}$, which is compact, the exceptions are excluded by fiat.

- **The refutation half is sound in form.** Falsifying a universal claim needs one witness, and named ones are given. They were established by exact arithmetic over $\mathbb Q$ rather than by an argument, so what is on file is a computation, and no closed-form derivation of the $\mathfrak{su}(m)$ excesses $5,9,14,20$ exists in the record. As a *refutation* that is the weakest place for the burden to sit, and it is acceptable; as a *positive* statement about the family at general $m$ it would not be.
- **"A value-localised version survives" is BROKEN as worded.** What is on file is *"every **known** exception sits at value at most $1.054$"*, a statement about the current census, not about $\mathrm{Crit}(P)$. The compactness of $\{\theta\ge t\}\cap\mathrm{Crit}$ makes the localisation *well posed*; it does not make the localised statement *true*. The paragraph's own last three words, "by fiat", concede exactly this and then the sentence says "survives" anyway. **The same file states it correctly at [nondegeneracy.md:559](../findings/nondegeneracy.md)**, *"A **value-localised** hypothesis is still viable … That is the form the route must take, and it is weaker than what was claimed"*, and [LEDGER.md](../findings/LEDGER.md) repeats the honest form. The repair is one word: *survives* → *is still open*.

## 12. Claim 15, *"the rival maximizer satisfies the same identity"*

- **At $n=4$, natively, it is a theorem and a clean $\ker W\ne0$ case.** [second-order.md:255](../findings/second-order.md) records $W_{\mathbb{CP}^2}=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ with $\dim\ker W=3$, spectrum $\{1,\tfrac12^{(2)},0^{(5)},(-1)^{(2)}\}$ summing to $10=\dim\mathcal W_4$, and $\dim E(\tfrac12)=2$. The orbit: $\dim\mathfrak{so}(4)-\dim\mathfrak u(2)=6-4=2$. **So $\ker\mathrm{Hess}=2=\dim\mathcal O$ with $W$ having a three-dimensional kernel**, the identity holds, and a nonzero $\ker W$ costs it nothing at this point.
- **At $m\ge3$ natively it is [L28](../findings/nondegeneracy.md).**
- **Padded, it is a measurement stopping at $n=10$**, by [second-order.md:205](../findings/second-order.md)'s own words: *"At padded $W_{\mathbb{CP}^2}$ it is a measurement stopping at $n=10$: [Lemma L28] is stated at $m\ge3$ in native dimension."*
- **And the "rival maximizer" reading must be pinned.** The *two-block plateau* (two Fox blocks, not a padding), is **degenerate with excess $16$** ([nondegeneracy.md:454](../findings/nondegeneracy.md)), and [nondegeneracy.md:423](../findings/nondegeneracy.md) records that a padded $S^2\times S^2$ shares the plateau's nullity column while having a different orbit, *"a coincidence in nullity [that] misled one audit into reading the orbit column as an error"*. So "the rival maximizer" satisfies the identity under one reading and fails it under another, and the landscape line names neither. **HYPOTHESIS-DEBT.**

## 13. Withdrawn candidates

- **"The $0$ in the quoted $S^2\times S^4$ spectrum is not in the spectrum."** [L127](../findings/second-order.md)'s box says the within-factor pair block at $p=2$ is $(-\tfrac23)^3$ rather than carrying the printed $0$, which invited the reading that $0$ is absent from the spectrum entirely. **Withdrawn at protocol step 2:** even at $(2,4)$ the summands $\mathrm{Weyl}_4$ (dimension $10$) and $X_4\otimes\mathbb R^2$ (dimension $32$) carry $L_e=0$, so $0$ is in the spectrum in abundance and the *list of values* is defensible. The defect is confined to the multiplicity claim at $\tfrac12$, which is §5.
- **"$p=1$ is a live gap."** **Withdrawn at protocol step 1:** the block scopes its criterion to $p,q\ge2$ in the same sentence, L26 requires a coordinate $2$-plane in each block, and [L126](../findings/second-order.md) excludes $p=1$ structurally. There is nothing to locate.
- **"L11 asserts the isolation consequence without argument."** True as written, [L128](../findings/second-order.md) says so in as many words, *"the proof of (iii), which [Lemma L11](../findings/nondegeneracy.md) asserts without argument"*, but **withdrawn as a finding against L11** at protocol step 3: L128(iii) now supplies the proof, so the charitable reading is that the debt is discharged elsewhere and only the citation is missing.
- **"Trace-zero corroborates the template at $(2,4)$."** Considered as a defence of claim 8 and **withdrawn**: §5 shows the trace test passes at $(2,4)$ *and* the dimensions over-count, because the over-counted directions carry eigenvalue $0$. The test is blind to this failure mode and is therefore no defence.

## 14. What would falsify the statement I conclude is correct

The statement I conclude is correct is **claim 12**: for $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$, $S^p\times S^q$ is Morse–Bott nondegenerate, $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)\cap W^\perp=\mathbb R^p\otimes\mathbb R^q$ of dimension $pq$.

**The object that would falsify it:** a pair $p,q\ge3$ with $(p,q)\ne(3,3)$ and an $L_e$-eigenvector at $\tfrac12$ inside $\mathrm{Weyl}_{p+q}$ that is not in $\mathbb R^p\otimes\mathbb R^q$. Since L27 makes $L_e$ a scalar on each of ten summands, such a vector must live in a summand whose scalar is $\tfrac12$, so it would have to be one of these two things:

1. **A second summand whose value is $\tfrac12$.** The candidates are exactly the seven non-orbit values in L27's list: $1$ (only on $\langle W\rangle$, which is not in $W^\perp$), $\lambda_p$, $\lambda_q$, $+\mu$, $-\mu$, and $0$ on the four remaining summands. I checked each against $\tfrac12$ in closed form: $\tfrac12-\lambda_m=\frac1{2(m-1)}>0$ for every $m\ge2$; $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$ for $p,q\ge3$ off $(3,3)$ by §2–§3; $-\mu<0$ since $\mu>0$; $0\ne\tfrac12$. **None can be $\tfrac12$ in the stated range**, and the only two that can approach it do so from strictly below.
2. **An eleventh summand, i.e. a failure of the decomposition to exhaust $\mathrm{Weyl}_n$.** This is the failure mode that is *real* at $q\le2$ and that §5 turns on. I looked for it in the stated range by the same dimension count that exposes it at $(2,4)$: at $(3,3)$ the ten dimensions sum to $84=\dim\mathrm{Weyl}_6$ exactly, and L27 records the sum as an identity in $p,q$ once the polynomial $\dim\mathrm{Weyl}_m$ is used, which agrees with the true dimension at every $m\ge3$ and disagrees only at $m=2$, where the polynomial gives $-2$ against $0$. **So the exhaustion can fail only where a factor has dimension $\le2$, which the hypothesis $p,q\ge3$ excludes.** That is also the reason $(3,3)$ is a genuine exception of type 1 rather than type 2.

**What I did to look for it:** read L27's ten values against $\tfrac12$ one by one in closed form; re-derived $\tfrac12-\mu$ and $\tfrac12-\lambda_m$ from scratch (§2); recomputed the ten-summand dimension sum by hand at $(2,4)$ and at $(3,3)$, getting $86$ and $84$ against $\dim\mathrm{Weyl}_6=84$; cross-read the same operator through the independent block decomposition of [L127](../findings/second-order.md), whose four block families reproduce the same values and whose $\tfrac12$ appears only on the cross-factor pair blocks, on the orbit; and checked $\mathop{\mathrm{tr}}L_e=0$ at both splits. **No numerical work; no sweep repeated; no search run.** I found no such object in the stated range, and I found the two places outside it ($q\le2$ and padding) where objects of exactly this kind do exist.

## Verdict

**BROKEN**, and the break is in the clauses around a correct theorem, not in the theorem.

| what | verdict |
| --- | --- |
| The core statement, $p,q\ge3$ with $(p,q)\ne(3,3)$, at $n=p+q$ | **PROVEN** by [L27](../findings/nondegeneracy.md), with the imports checked in §10 |
| *"degenerate at $\min(p,q)=2$"* in [results.md:393](../results.md), the *"TWO exceptional families"* framing in [results.md:130](../results.md), and the same in [INDEX-results.md:26](../findings/INDEX-results.md) | **BROKEN**, false at native dimension, by §4 and §4.2, and true only of the padded family the clause does not name |
| *"at $\min(p,q)=2$ … the point is nondegenerate"* | **HYPOTHESIS-DEBT**, §5, with the missing statement written out there and circularity against [L128](../findings/second-order.md) in §5.1 |
| The $S^2\times S^4$ spectrum offered as its witness | **GAP**, §5, the template read outside its own recorded range |
| *"the content lies in the representation isomorphism above"* and the identical passage at [nondegeneracy.md:127](../findings/nondegeneracy.md) | **BROKEN**, §6, stale text refuted by [L27](../findings/nondegeneracy.md) and by a character evaluation |
| The absence of *"$n=p+q$"* from the statement | **BROKEN by omission**, §7, with [L126](../findings/second-order.md)'s closed-form $\tfrac1{2(p-1)}$ as the mechanism |
| *"a value-localised version survives"* | **BROKEN as worded**, §11, one word from the correct form the same file already carries |
