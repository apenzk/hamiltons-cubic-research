# REVIEW_r589, Lemma L30 (a small negative eigenspace forces a small support)

Reviewer r589, independent adversarial audit, worked from the definitions. Target: `Lemma L30 (a small negative eigenspace forces a small support), canonical statement and proof`, [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) lines 208–231, block boundaries taken from the heading above (the provenance italic and the "Needed because" line belong to the block) down to the next `####` at line 234.

Analysis only. Two screens were run, each seconds of compute on objects I constructed for the purpose, and each is labelled a screen below; neither is offered as evidence for a positive claim.

**Overall: CONFIRMED with five repairs owed.** The statement is true and the proof is a correct sketch of a correct argument, missing three routine steps. The defects are around it: the provenance note, the only in-file pointer to it, the Gate-2 line against the index, the second half of the statement which the proof never touches, and both of its consuming citations.

---

## What the block leans on that [conventions.md](../findings/conventions.md) does not define

| needed | status in conventions.md |
| --- | --- |
| the reading of a bivector as a skew matrix | **absent.** The file fixes the *norms* of both objects (the half-trace pairing bullet, and $\lVert\varphi_{ab}\rVert^2=1$ against $2$) but never the map. L30 needs $x\wedge y\mapsto xy^{\mathsf T}-yx^{\mathsf T}$, under which $\langle v,x\wedge y\rangle=x^{\mathsf T}vy$ and hence $\mathrm{Ric}(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$ with **no constant**. Under $x\wedge y\mapsto\tfrac12(xy^{\mathsf T}-yx^{\mathsf T})$ a factor appears. L30 survives either way because every conclusion it draws is a vanishing statement, but the identity it quotes is normalisation-dependent and the normalisation is nowhere on the record |
| $\mathrm{im}$ | **absent.** Load-bearing twice: $\mathrm{im}(v^{\mathsf T}v)=\mathrm{im}\,v$ for skew $v$, and $u\perp U\Rightarrow u\in\ker v$ via $\mathrm{im}\,v=(\ker v)^\perp$ |
| the padding relation | **named, never defined.** The bullet "Padding commutes with $Q$, and preserves both the norm and $\theta$. The stratum reduction turns on this." asserts the property of an operation the record never states. The definition the block needs: for an isometric $\mathbb R^m\hookrightarrow\mathbb R^n$, extend by zero on the orthogonal complement of $\Lambda^2\mathbb R^m$ in $\Lambda^2\mathbb R^n$ |
| $\mathrm{Weyl}_n$ | usable, $\mathcal W_n$ is tabled, and Ricci-flat plus first Bianchi is the working definition throughout the file |

The BK-versus-Li index-order note in conventions.md, which the same file flags as live for [stratum-two-negative.md](../findings/stratum-two-negative.md), **does not reach L30**: the block uses only the first-kind operator on $\Lambda^2$, never $\mathring W$.

---

## The derivation, rebuilt

Write $W=\sum_\alpha\lambda_\alpha\,v_\alpha\otimes v_\alpha$ in an orthonormal eigenbasis of $\Lambda^2\mathbb R^n$, each $v_\alpha$ read as a skew matrix.

1. **The identity.** With $x\wedge y\mapsto xy^{\mathsf T}-yx^{\mathsf T}$ and the half-trace pairing, $\langle v,x\wedge y\rangle=x^{\mathsf T}vy$, so $\sum_j\langle v,x\wedge e_j\rangle^2=\lVert vx\rVert^2$ and $\mathrm{Ric}(x,x)=\sum_j\langle W(x\wedge e_j),x\wedge e_j\rangle=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$. Ricci-flatness is therefore $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$, and $v^{\mathsf T}v=-v^2\succeq0$. **Correct as printed.**
2. **The two sides.** $S:=\sum_{\lambda_\alpha>0}\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=\sum_{\lambda_\alpha<0}\lvert\lambda_\alpha\rvert v_\alpha^{\mathsf T}v_\alpha$. Under *at most two* negative eigenvalues the right side runs over $v_{N-1},v_N$ alone, and $\mathrm{im}(A+B)=\mathrm{im}\,A+\mathrm{im}\,B$ for positive semidefinite $A,B$ together with $\mathrm{im}(v^{\mathsf T}v)=\mathrm{im}\,v$ gives $\mathrm{im}\,S=U$ exactly. Both facts are used silently.
3. **The positive side.** The same PSD-sum fact read on the left gives $\mathrm{im}\,v_\alpha\subseteq\mathrm{im}\,S=U$ for every $\lambda_\alpha>0$.
4. **Vanishing.** For $u\perp U$ and $\lambda_\alpha\ne0$, $u\in(\mathrm{im}\,v_\alpha)^\perp=\ker v_\alpha$, so $\langle v_\alpha,u\wedge w\rangle=u^{\mathsf T}v_\alpha w=0$ and $W(u\wedge w)=0$ for every $w$. Since $u\wedge u=0$ this is exactly $W(u\wedge u^\perp)=0$.
5. **Padding.** $\Lambda^2\mathbb R^n=\Lambda^2U\oplus(U\wedge U^\perp)\oplus\Lambda^2U^\perp$, and step 4 kills the last two summands. $W$ is symmetric, so $\mathrm{im}\,W\perp\ker W\supseteq(\Lambda^2U)^\perp$ and $\Lambda^2U$ is $W$-invariant. The restriction $W'$ satisfies first Bianchi (an identity on indices, inherited) and is Ricci-flat: for $x\in U$, $\mathrm{Ric}_U(x,x)=\mathrm{Ric}(x,x)-\sum_{f_j\in U^\perp}\langle W(x\wedge f_j),x\wedge f_j\rangle=0-0$. So $W'\in\mathrm{Weyl}_{\dim U}$ and $W=\mathrm{pad}(W')$.
6. **Norm and $\theta$.** $\{e_i\wedge e_j\}_{i<j}$ for a basis adapted to $U$ is orthonormal in $\Lambda^2\mathbb R^n$ and its $U$-part is orthonormal in $\Lambda^2U$, so $\lVert W'\rVert=\lVert W\rVert$. For $\theta$: $\Lambda^2U=\mathfrak{so}(U)$ is a **Lie subalgebra** of $\mathfrak{so}(n)$, and $W^\#$ is assembled from structure constants alone, so a $W$ supported on $\mathfrak{so}(U)$ has $W^\#$ supported there and equal to the intrinsic $W'^\#$; $W^2$ is block-diagonal for the same reason. Hence $Q$ commutes with padding, $P(W)=P(W')$, $\theta(W)=\theta(W')$.

Step 6 is where the block stops short, see D4.

---

## Verdicts, per defect

### D1, the provenance line: SPLIT, and REPAIR owed on the first clause

> *Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

The move is commit a9e4b8c0, *refactor(results): the proofs move to findings, results.md states and points*; its parent is 84cada75.

- **True of the proof text.** Three distinctive-phrase `git grep`s at `a9e4b8c0^` over the whole tree, "identity among positive semidefinite", "every eigenvector with nonzero eigenvalue", "involving directions outside", each return `results.md` and nothing else.
- **False of the argument.** At that same parent, [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) line 69 already carried `#### Lemma. Two negative eigenvalues of low rank force $n-1$ zero eigenvalues`, whose **Statement** contains L30's padding conclusion word for word, "$W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor with $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$", and whose **Proof** establishes the same vanishing by the trace-on-$u\wedge u^\perp$ route. That block is today the section "The low-rank case, in development form" **thirty-four lines above L30 in the same file**. Its hypothesis $\bigcap_{v\in\mathfrak m}\ker v\ne0$ is *equivalent* to $\dim U<n$, since $U^\perp=\ker v_{N-1}\cap\ker v_N$ and a vector killed by both generators is killed by the whole span.
- Also at the parent, `results.md:162` carried a second, argument-bearing summary of the same lemma, so "the only copy" fails even inside results.md on a generous reading.
- **Second clause TRUE.** [results.md](../results.md) lines 418–422 carry the statement verbatim followed by `**Proof:** [stratum-two-negative.md]`. Two qualifications: the pointer resolves to the *file*, not the block, and `results.md:146` still carries the argument in compressed form rather than the statement alone.

**Verdict: REPAIRED wording owed.** The honest note is that the *proof text* moved from results.md, while an argument for the same statement stayed in place in the destination file.

### D2, the only in-file pointer to L30 is broken: REFUTED as a working link

[findings/stratum-two-negative.md](../findings/stratum-two-negative.md) line 176 reads

> *The statement and its proof are [Lemma L30](../findings/LEDGER.md#lemma-l30-a-small-negative-eigenspace-forces-a-small-support) below; this is the working it came from.*

The heading is `#### Lemma L30, …`, so its anchor is `#lemma-l30--a-small-negative-eigenspace-forces-a-small-support--canonical-statement-and-proof`. The link omits the `l`. **Every sibling link in the same file is of the `lemma-lNN` form** (L31 at lines 82, 200, 253, 504; L33 at 84; L34 at 130; L35 at 116, 389, 427; L29 at 451, 504) which isolates this one. A second instance of the identical defect sits at line 11, `#lemma-29--…`, pointing at L29. Two anchors, one repair each.

### D3, the Gate-2 clause contradicts the record's own index: REFUTED

The block closes: "**Gate 2 passed, both reviewers independently, each reaching the identity by its own route.**"

[findings/INDEX-results.md](../findings/INDEX-results.md) line 45 reads, for result 30: "**Gate 2: no verdict on the record.**"

One of the two is wrong, and the index is the record's own register of verdicts. The block asserts a Gate-2 pass that the register denies.

### D4, the second half of the statement is asserted, never proved: REPAIRED here

The statement promises a padding "**with the same norm and the same $\theta$**". The Proof establishes the vanishing, the Ricci-flatness of the restriction, and nothing else, no line of it mentions the norm or $\theta$. The heading says "canonical statement and proof", so the reader is owed the two lines, which are step 6 above. The single fact they turn on is that $\Lambda^2U$ is a Lie subalgebra, which is what makes $W^\#$ stay inside; [conventions.md](../findings/conventions.md) asserts "Padding commutes with $Q$, and preserves both the norm and $\theta$" without proof and without defining padding, so quoting it moves the gap rather than closing it.

*Screen (seconds, on objects I built for it): the Weyl part of Fubini–Study on $\mathbb R^4$, taken as $\mathrm{diag}(2,-1,-1)$ on $\Lambda^2_+$ and $0$ on $\Lambda^2_-$, has Bianchi residual $0$ and Ricci residual $2\times10^{-16}$; padded into $\mathbb R^8$ it returns $\theta=1.224744871392$ and norm $2.449489742783$, digit for digit the values at $n=4$. Reported as a screen of a claim I am recording, not as evidence.*

### D5, three steps omitted from the proof: REPAIRED here

- **$\Lambda^2U$ is $W$-invariant** is never stated; the proof jumps from "$W(u\wedge w)=0$" to "the restriction to $\Lambda^2(U)$". One line from the symmetry of $W$ (step 5).
- **$\mathrm{im}(A+B)=\mathrm{im}\,A+\mathrm{im}\,B$ for positive semidefinite $A,B$** is used twice and stated nowhere. It is the step that carries "hence … every eigenvector with nonzero eigenvalue has its image inside $U$".
- **$\mathrm{im}(v^{\mathsf T}v)=\mathrm{im}\,v$ for skew $v$** is used to identify $\mathrm{im}\,S$ with $U$.

All three are true and routine; the block is a correct sketch rather than a complete proof.

### D6, "$v_\alpha u=0$ for all $\alpha$" overstates: REPAIRED here

It holds for $\alpha$ with $\lambda_\alpha\ne0$. An eigenvector in $\ker W$ can have image meeting $U^\perp$, nothing in the argument constrains it. The conclusion is unaffected, since the $\lambda_\alpha=0$ terms drop out of $W(u\wedge w)=\sum_\alpha\lambda_\alpha\langle v_\alpha,u\wedge w\rangle v_\alpha$, but the quantifier as printed is false.

### D7, $\dim U<n$ carries no logical weight: scope note, CONFIRMED as harmless

At $\dim U=n$ the first conclusion is vacuous (no $u\perp U$ exists) and the second is trivial ($W$ is a padding of itself). So the hypothesis is a non-degeneracy flag marking where the lemma says something, not a premise either conclusion consumes. Where it *does* bite is downstream: it is what makes $\dim U$ a strictly smaller ambient dimension for the bound to be proved in.

### D8, "at most two negative eigenvalues" IS load-bearing, and the generalisation needs $U$ redefined: CONFIRMED

The proof shape suggests the count is bookkeeping, and it nearly is, what step 2 actually needs is that $U$ contain the image of **every** negative eigenvector. Under three or more negatives, with $U$ still built from two of them, the lemma is false. Witness, by a route sharing nothing with the block's:

Let $V_1\perp V_2$ be orthogonal $4$-planes in $\mathbb R^8$ and put $W=\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$. First Bianchi and Ricci-flatness are linear conditions and each summand is a padding of a $\mathrm{Weyl}_4$ element, so $W\in\mathrm{Weyl}_8$. Its spectrum is $2,-1,-1$ from each block and zero elsewhere, so it has **four** negative eigenvalues. Take $v_{N-1},v_N$ to be the two supported on $V_1$: every nonzero self-dual $2$-form on $V_1$ is nondegenerate there, so $U=V_1$ and $\dim U=4<8$. Yet $u=e_5\in V_2$ is orthogonal to $U$ and $W(u\wedge e_6)\ne0$.

**So the correct general statement replaces the count by $U:=\sum_{\lambda_\alpha<0}\mathrm{im}\,v_\alpha$**, under which the proof is verbatim, dimension-free, and free of any restriction on the number of negative eigenvalues.

*Screen: the tensor above was constructed and checked, Bianchi residual $0$, Ricci residual $2.2\times10^{-16}$, four negative eigenvalues at $-1$, rank $U=4$, and $\lVert W(e_5\wedge e_6)\rVert=\sqrt2$. The witness stands on the paragraph above; the screen is a check of it.*

### D9, $\theta$ at $W=0$: minor, REPAIR owed

$\dim U=0$ forces $W=0$ through the lemma itself, and then "the same $\theta$" is $0/0$ under [conventions.md](../findings/conventions.md)'s $\theta=P(W)/\lVert W\rVert^3$. The norm-and-$\theta$ clause needs $W\ne0$.

### D10, the scope paragraph: CONFIRMED on substance, one endpoint short

> **Scope, stated.** The hypothesis is $\dim U<n$ and **not** a condition on the individual ranks: under a repeated negative eigenvalue those are not determined by $W$, and the rank-sum form fails to apply at padded $W_{\mathbb{CP}^2}$ for $n=6,7,8$, where the ranks are $4+4=8\ge n$ while $\dim U=4$ and the conclusion holds.

- **$U$ is well defined under a repeated negative eigenvalue.** For an $O(2)$ rotation inside a $2$-dimensional negative eigenspace, $v_1'^{\mathsf T}v_1'+v_2'^{\mathsf T}v_2'=v_1^{\mathsf T}v_1+v_2^{\mathsf T}v_2$ (the cross terms cancel) so $\mathrm{im}\,S$, and hence $U$, is basis-independent. **The clause is right, and the reason is worth having on the record.**
- **The ranks genuinely are not determined**: the eigenspace $\mathrm{span}(e_{12},e_{34})$ contains rank-$2$ and rank-$4$ elements. **But the example the sentence then offers does not illustrate that half of it**, at padded $W_{\mathbb{CP}^2}$ every element of the negative eigenspace is a self-dual form on the $4$-plane and so has rank $4$ exactly. Two independent points are welded into one sentence and only the second is witnessed.
- **The list $n=6,7,8$ omits $n=5$**, which meets the description exactly: ranks $4+4=8\ge5$, $\dim U=4<5$, conclusion holds. The development-form block above states the same range as "below $n=9$", which reaches $n=5$ but wrongly includes $n=4$, where $\dim U=4=n$ and the conclusion is trivial rather than holding "anyway". **Each version has one endpoint wrong; the correct range is $n=5,6,7,8$.**

### D11, the block's own file, above and below

- The **development-form** section at line 174 states the same lemma under the equivalent hypothesis and proves it by a second route. It is not a competitor; it is a second proof the canonical block does not acknowledge, and the provenance note in D1 is what obscures it.
- The **Proposition (padding reduction)** at line 249, eighteen lines *below* L30, is stated with the rank-sum hypothesis $r_1+r_2<n$ and the one-dimension-at-a-time conclusion $W'\in\mathrm{Weyl}_{n-1}$, precisely the form L30's own Scope paragraph says "fails to apply". It is true (rank sum $<n$ implies $\dim U<n$) but strictly weaker, and it sits under a heading of its own as a live Proposition beneath the lemma that supersedes it.

### D12, the citations, counted

Every occurrence of `L30` in [findings/](../findings/), [results.md](../results.md) and [report/](../report/), with `#L30` anchors and brief labels discounted. **Eight lines, of which two are the result itself and two are consuming uses.**

| site | what it is |
| --- | --- |
| [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):176 | in-file pointer, anchor broken, D2 |
| [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):208 | the block itself |
| [findings/bounds-relaxations.md](../findings/bounds-relaxations.md):110 | passing mention, "Lemma 30/31", unlinked |
| [findings/LEDGER.md](../findings/LEDGER.md):1056 | record of the figure repair below |
| [results.md](../results.md):146 | landscape entry, statement plus argument sketch |
| [results.md](../results.md):418 | canonical statement and proof pointer |
| [report/sections/diagram.tex](../report/sections/diagram.tex):68 | figure node, "L66, L30" |
| [report/sections/diagram-closed.tex](../report/sections/diagram-closed.tex):79 | figure node, "L66, L30" |

**Both consuming uses fall outside L30's hypotheses.** The figure nodes read "support $s$ forces a padding, $\theta\le M(s)$" with no restriction on the number of negative eigenvalues. The general fact they need (a Weyl tensor whose support is an $s$-plane is a padding of a $\mathrm{Weyl}_s$ element), is elementary and is on the record in [reviews/REVIEW_r281.md](REVIEW_r281.md); it is *not* L30, which is the sharper and hypothesised statement that a **small negative eigenspace** forces the small support in the first place. [findings/LEDGER.md](../findings/LEDGER.md):1056 records that both figures were repaired *into* this attribution after a reviewer found the clause tagged to L66 alone, so the repair moved a general clause from one lemma that disclaims it to another that hypothesises it. **The clause wants no lemma number at all, or r281's.**

The [findings/bounds-relaxations.md](../findings/bounds-relaxations.md):110 mention, "any contraction of Prop 1.7 against a $\gamma$-independent weight recovers only Lemma 30/31", names facts that are the pair cap and the Killing marginal, which [conventions.md](../findings/conventions.md) attributes to L31. L30 has no bearing on contractions of Petersen–Wink Prop 1.7. The un-prefixed "Lemma 30/31" is very likely a pre-rename number that the L-prefix pass left behind.

---

## Overall

**CONFIRMED.** The statement of Lemma L30 is true as written and its proof is a correct argument with three routine steps left out. Nothing in the mathematics is wrong.

Repairs owed, in order of cost to a reader:

1. **The anchor at line 176**, the only in-file pointer to the lemma does not resolve. Same defect at line 11 for L29.
2. **The Gate-2 line**, which the record's own index contradicts.
3. **The provenance note**, true of the proof text and false of the argument, which stayed in the destination file thirty-four lines above.
4. **The norm-and-$\theta$ clause**, promised by the statement and untouched by the proof; two lines, given above.
5. **The two figure citations**, which use L30 for a clause that needs no hypothesis on the negative eigenspace.

And two improvements the block could carry cheaply: the scope range is $n=5,6,7,8$, and the lemma generalises to any number of negative eigenvalues once $U$ is defined as the sum of *all* their images, with the four-negative witness above showing that redefinition is necessary rather than cosmetic.
