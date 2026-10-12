# Review r527, Lemma L26, "the dangerous eigenvalue of the two-block spectrum, in closed form"

**Target**: [findings/nondegeneracy.md](../findings/nondegeneracy.md), `#### Lemma L26` (line 78) through the next heading. Statement copy at [results.md:386–392](../results.md).
**Reviewer**: r527, cold, adversarial, working from the definitions. Analysis-only footing observed: everything below is derived by hand. One exact-arithmetic **screen** is reported as a screen and marked as such; it decides nothing that the hand derivation does not already decide.

**VERDICT: REFUTED**, the closing sentence of the Statement, *"For $p,q\ge3$ other than $(3,3)$ the gap is $1/(2\max(p,q)-2)$"*, is false, with witness $(p,q)=(3,4)$. **Everything else in the block is confirmed by independent derivation**, including the object, its membership in $\mathrm{Weyl}_n$, the eigenvector property, the closed form, the three-block generalisation, the range $p,q\ge2$ and the $p=2$ excess. Separately, the provenance line is false against git.

---

## What was rebuilt from the definitions, and what it confirms

I fixed the conventions before reading the block, against the record's anchors, and every anchor came out.

- $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ forces the diagonal sharp formula $(W^\#)_{ab,ab}=\sum_{c\ne a,b}K_{ac}K_{bc}$ and the normalisation $R^\#_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}R_{\gamma\epsilon}R_{\delta\zeta}$, using [conventions.md](../findings/conventions.md)'s Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$.
- $\operatorname{tr}W^\#=-1$ then falls out of Ricci-flatness of the vertex matrix: $\sum_{a\ne b}\sum_{c\ne a,b}K_{ac}K_{bc}=-\lVert K\rVert_F^2=-t$, so $\operatorname{tr}W^\#=-t/2=-1$ at the ordered $t=2$. **Both anchors reproduced, so the half-trace pairing of [conventions.md](../findings/conventions.md) is the one I am working in.**
- $\theta_0(6)=\sqrt{10}/3$ is reproduced at the end of the chain below.

### 1. The sphere product's $e$, CONFIRMED, and derived without reading it off the record

Taking the product metric with sectional curvatures $\alpha$ on $P$-planes, $\beta$ on $Q$-planes and $0$ on mixed, and subtracting the Ricci and scalar terms, the Weyl vertex matrix at the Einstein scaling $(p-1)\alpha=(q-1)\beta=\rho$ is

$$K_{PP}=\frac{\rho}{p-1}-\frac{\rho}{n-1},\qquad K_{QQ}=\frac{\rho}{q-1}-\frac{\rho}{n-1},\qquad K_{PQ}=-\frac{\rho}{n-1},$$

so at $\rho=-(n-1)$ the entries are $-q/(p-1)$, $-p/(q-1)$, $1$, **[nondegeneracy.md:207](../findings/nondegeneracy.md)'s recorded vertex entries, recovered independently.** For that $W$ the diagonal sharp formula gives $Q(W)=-(n-1)W$ on all three block types, so $e=W/\!\!-\!(n-1)$ is the unique positive multiple with $Q(e)=e$:

$$\varepsilon_{PP}=\frac{q}{(p-1)(n-1)},\qquad \varepsilon_{QQ}=\frac{p}{(q-1)(n-1)},\qquad \varepsilon_{PQ}=-\frac{1}{n-1}.$$

These are exactly the values [nondegeneracy.md:690](../findings/nondegeneracy.md) substitutes. **Full chain check**: $\lVert W\rVert^2=\frac{pq(n-1)(n-2)}{2(p-1)(q-1)}$, so $\lvert\theta\rvert=(n-1)/\lVert W\rVert=\sqrt{\frac{2(p-1)(q-1)(n-1)}{pq(n-2)}}$, [nondegeneracy.md:207](../findings/nondegeneracy.md)'s $\theta$, and at $(3,3)$ this is $\sqrt{40/36}=\sqrt{10}/3=\theta_0(6)$. *The record's $\theta$ anchor and its vertex entries both fall out of my own build, so the normalisation is not in dispute.*

### 2. $X\in\mathrm{Weyl}_n$, CONFIRMED, and the Ricci component vanishes for a reason the block does not give

With $\pi=\{1,2\}\subset P$, $\rho=\{3,4\}\subset Q$ and $S=\varphi_{12}\odot\varphi_{34}$: $\langle S,\star\rangle=2$ and $\lVert\star\rVert^2=6$, so $\mathrm{Alt}(S)=\tfrac13\star$ and $X=S-\tfrac13\star$ has entries $\tfrac23,\tfrac13,-\tfrac13$ on the three pairings and $\lVert X\rVert^2=2(\tfrac49+\tfrac19+\tfrac19)=\tfrac43$. **Both recorded numbers confirmed.** The Bianchi sum $c_1-c_2+c_3=0$ holds, so $\mathrm{Alt}(X)=0$.

**The Ricci part vanishes automatically, and the brief's worry is answered structurally**: $X$ is supported only on pairs of *disjoint* index pairs, while $\mathrm{Ric}_{ik}=\sum_j X_{ijkj}$ contracts two pairs sharing the index $j$. So every Ricci component is a sum of entries $X$ does not carry, and $\mathrm{Ric}(X)\equiv0$ before any hypothesis is used. It holds because $\pi\subset P$ and $\rho\subset Q$ are disjoint, which the construction guarantees at every $p,q\ge2$.

> **This is a real gap in the exposition, though not in the mathematics.** The block writes "Then $X\in\mathrm{Weyl}_n$" with no argument at all, and $\mathcal W_n=\mathrm{Sym}^2(\Lambda^2)\ominus\mathrm{Sym}^2\mathbb R^n\ominus\Lambda^4$ has two conditions, only one of which the construction visibly enforces. **The one-line reason above belongs in the block.**

**And the $\Lambda^4$ clause is not vacuous**, contrary to [r420](REVIEW_r420.md)'s first reading: $\langle\varphi_\pi\odot\varphi_\rho,\star\rangle=2\neq0$, so removing the $\Lambda^4$ part genuinely moves $(1,0,0)$ to $(\tfrac23,\tfrac13,-\tfrac13)$. r420's own closing note reaches the same conclusion, the clause is vacuous in *signed* coordinates and load-bearing on the raw object L26 names. **L26 is the block where the clause is correct**, and it should keep it.

### 3. $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$, CONFIRMED by hand from the structure constants

With $X\circ Y=\tfrac12(XY+YX)+\tfrac12\sum_{\gamma\delta\epsilon\zeta}c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}X_{\gamma\epsilon}Y_{\delta\zeta}$ and $e$ diagonal, I computed all three support components using $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$:

| component | $\tfrac12(eX+Xe)$ | $(e\#X)$ | total |
| --- | --- | --- | --- |
| $(12),(34)$ | $\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})c_1$ | $\varepsilon_{PQ}(c_3-c_2)=-\varepsilon_{PQ}c_1$ | $\lambda c_1$ |
| $(13),(24)$ | $\varepsilon_{PQ}c_2$ | $-\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})c_3-\varepsilon_{PQ}c_1$ | $\lambda c_2$ |
| $(14),(23)$ | (|), | $\lambda c_3$, by the transposition $(3\,4)$, which fixes $e$ and sends $X\mapsto-X$ |

**And $e\circ X$ has no support outside those three positions.** The sharp term needs $r$ to share one index with $\delta$ and one with $\zeta$, which are disjoint pairs inside $\{1,2,3,4\}$; so $r\subset\{1,2,3,4\}$, and $\alpha,\beta$ are third sides of triangles inside $\{1,2,3,4\}$. Enumerating the twelve $(\delta,\zeta,r)$ triples sends every one of them back to a support position. *The block's "the plane $r$ is determined by $a$ and $m$ as the third side of a triangle" is the right idea, loosely stated; the closure argument above is what actually finishes it.*

Substituting the $\varepsilon$'s: the numerator collapses to $p^2+q^2-n+2(p-1)(q-1)=(n-1)(n-2)$, so

$$\mu=\frac{n-2}{2(p-1)(q-1)}\qquad\text{\textbf{the closed form is right}.}$$

### 4. The range $p,q\ge2$, CONFIRMED, and it is sharp

The derivation uses $\varepsilon_{(12)}=\varepsilon_{PP}$, $\varepsilon_{(34)}=\varepsilon_{QQ}$ and $\varepsilon_{PQ}$ on all four cross planes; that needs $\{1,2\}\subseteq P$ and $\{3,4\}\subseteq Q$, i.e. exactly $p,q\ge2$. **No factor degenerates at $p=2$** ($(p-1)=1$ is where the numerator sits, not a denominator) and $p=1$ fails only because there is no $2$-plane in a $1$-block. So $p,q\ge2$ is the correct and sharp range, and **L27's narrower $p,q\ge3$, $(p,q)\ne(3,3)$ is a different scope**: it is the range in which the *sign* of $\tfrac12-\mu$ is positive, not the range in which the formula holds. The two ranges are consistent, and the brief's suspicion of an over-wide range is not borne out here.

Checks at the boundary: $p=2$ gives $\mu=\frac{n-2}{2(n-3)}=\tfrac12+\frac1{2(n-3)}$, the recorded excess; $\mu_{2,4}=\tfrac23$ and $\mu_{2,6}=\tfrac35$ reproduce [second-order.md:637](../findings/second-order.md)'s padding-invariant four-set values. $(3,3)$ gives $\mu=\tfrac12$ exactly. $(2,2)$ gives $\mu=1$, matching the block's own $(2,2)$ note.

### 5. Relation to L27, they are the same $\mu$, and L26 is the weaker of the two

$\tfrac12-\frac{n-2}{2(p-1)(q-1)}=\frac{pq-2n+3}{2(p-1)(q-1)}=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, identically. **[Lemma L27](../findings/nondegeneracy.md)'s $\mu$ is L26's $\mu$**, and the record knows it, L27's proof cites L26 for the value. Neither is redundant: L26 supplies the eigenvector and the lower bound on $\lambda_{\max}$; L27 supplies the summand list and the upper bound. The block's "What it does not reach" paragraph states that division correctly and is the best-written part of it.

**One over-citation in the neighbour.** [L27](../findings/nondegeneracy.md) writes "$-\mu$ and $+\mu$ on the two tensor summands, **by Lemma L26**". L26 exhibits one eigenvector and delivers $+\mu$ on $\Lambda^2\otimes\Lambda^2$ only; the $-\mu$ on $S^2_0\otimes S^2_0$ is nowhere in it, as [r345](REVIEW_r345.md) already noted. Harmless to L27's conclusion, since $-\mu<\tfrac12$ trivially, but the attribution should read "the $+\mu$ by Lemma L26".

---

## THE DEFECT: the gap sentence is false, and it is a different eigenvalue's gap misfiled into this block

> *"For $p,q\ge3$ other than $(3,3)$ the gap is $1/(2\max(p,q)-2)$."*, [findings/nondegeneracy.md:88](../findings/nondegeneracy.md), and verbatim again at [results.md:392](../results.md).

In a sentence that follows the display defining $\mu$ and the clause "at $(p,q)=(3,3)$, where it is an equality", **"the gap" can only read as $\tfrac12-\mu$**. Under that reading it is false at every admissible $(p,q)$ but two.

**Witness, by hand.** $(p,q)=(3,4)$, $n=7$: $\mu=\frac{5}{2\cdot2\cdot3}=\frac5{12}$, so $\tfrac12-\mu=\frac1{12}$. The sentence claims $\frac{1}{2\cdot4-2}=\frac16$, **wrong by a factor of two, and in the unsafe direction, since it overstates the margin.** At $(5,5)$ it errs the other way: $\tfrac12-\mu=\frac14$ against a claimed $\frac18$. *So it is not even a valid one-sided bound.*

**Where it is true, and why that is the tell.** $\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}=\frac{1}{2(q-1)}$ with $q=\max$ reduces to $p=\frac{2q-4}{q-3}$, integral only at $(4,4)$ and $(3,5)$, **both of them $n=8$.** The clause was generalised from one dimension's data.

**What the sentence is actually a statement about.** [L27](../findings/nondegeneracy.md) gives $L_e=\lambda_m=\frac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$, so $\tfrac12-\lambda_{\max(p,q)}=\frac{1}{2\max(p,q)-2}$ exactly. **The clause is L27's other eigenvalue's gap, imported into L26's block where the only $\mu$ in scope is L26's own.** [nondegeneracy.md:738–740](../findings/nondegeneracy.md), 660 lines below, says this in its own voice, *"$\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ is the gap to the family-B block, not to the spectrum… the real gap is $\frac1{2(M-1)}$"*, which is precisely the distinction L26's sentence erases.

**And under the charitable reading it is still false, at exactly one split.** Read as the spectral gap of $L_e\vert_{W^\perp}$ below $\tfrac12$, the value is $\min\{\tfrac12-\mu,\ \tfrac12-\lambda_{\max(p,q)}\}$, and $\tfrac12-\mu<\frac{1}{2(q-1)}$ reduces to $p(q-3)<2q-4$, whose only solution with $p,q\ge3$, $(p,q)\ne(3,3)$ is **$(3,4)$**. There $\mu=\frac5{12}>\lambda_4=\frac13$, so the second-largest eigenvalue below $\tfrac12$ is $\mu$, not $\lambda_M$, and the gap is $\frac1{12}$ rather than $\frac16$.

> **Screen** (exact `Fraction` arithmetic over $3\le p\le q\le9$, seconds of compute, on objects constructed for this check, reported as a screen and not as evidence): $\tfrac12-\mu$ equals $\frac{1}{2\max-2}$ only at $(3,5)$ and $(4,4)$; $\min\{\tfrac12-\mu,\tfrac12-\lambda_M\}$ equals it everywhere except $(3,4)$. Both agree with the hand derivation above.

**The clause also contradicts its own block.** Under the spectral-gap reading it is an *upper* bound on the rest of the spectrum, and the very next paragraph of L26 says "An exhibited eigenvector bounds $\lambda_{\max}$ and one multiplicity from **below** … upper bounds on the rest of the spectrum, which no eigenvector supplies." **L26 cannot prove the sentence it states.**

### The same $(3,4)$ hole sits in three other places, unrecorded

Under the spectral-gap reading, $(3,4)$ falsifies the general form of the margin claim wherever it is stated without a range:

| where | wording | status at $(3,4)$ |
| --- | --- | --- |
| [nondegeneracy.md:740](../findings/nondegeneracy.md) | "the **second-largest** eigenvalue of $L_e$ below $\tfrac12$ is $\lambda_2=\frac{M-2}{2(M-1)}$" | **false**, the second-largest is $\mu=\frac5{12}>\frac13$ |
| [plan.md:202](../plan.md) | "the true gap being $1/(2(M-1))$ with $M=\max(p,q)$ rather than the family-B formula" | **false**, unqualified |
| [graded-half.md:343](../findings/graded-half.md), [results.md:530](../results.md) | same margin, inside $p,q\ge5$ | **safe**, the hypothesis excludes $(3,4)$ |

*Nondegeneracy itself is untouched at $(3,4)$: $\mu=\frac5{12}<\tfrac12$, so $\tfrac12$ is still attained on the orbit alone and [L27](../findings/nondegeneracy.md) stands.* **Only the gap value is wrong, and only there.** $n=7$ is odd and outside every scanned range in the file, which is why it survived.

### The repair

Replace the sentence in both copies with the two statements it is confusing:

> For $p,q\ge3$ other than $(3,3)$ the gap is $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$. *The gap of the whole spectrum below $\tfrac12$ is a different and smaller quantity, $\min\{\tfrac12-\mu,\ \frac{1}{2\max(p,q)-2}\}$, which needs [Lemma L27](../findings/nondegeneracy.md#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof)'s summand list and is $\frac{1}{2\max(p,q)-2}$ at every split except $(3,4)$.*

---

## The other defects found

### D2, the provenance line is false against git

> *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy."*

**False.** At `a9e4b8c0^` (the commit before the move), [findings/fence-posts.md](../findings/fence-posts.md) lines 207–240 already carried the whole argument: the three-block formula $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$, the three $\varepsilon$ values, "so criticality is never used, it only fixes the number", and the "What this proves is one direction only" paragraph. That text is now [nondegeneracy.md:672–695](../findings/nondegeneracy.md), i.e. **the same file carries two copies of the argument today, 600 lines apart.** [Lemma L11](../findings/nondegeneracy.md)'s block, twelve lines below L26, already carries the repaired wording, *"**The claim once made here, that results.md held the only copy, is false against the commit before the move**"*, so the fix is known and L26 was skipped. This is one of the seven the sweep predicted.

### D3, the motivation miscalls its own citation, twice in one sentence

> *"Needed because Observation L3's nondegeneracy claim at $S^p\times S^q$ rested on a scan."*

[L3](../findings/second-order.md) is a **Lemma**, not an Observation, since `ea3a9c9f`; and its claim is that **the balanced product is a local maximum**, not a nondegeneracy claim. The sentence is stale on the kind and wrong on the content. [r525](REVIEW_r525.md) flagged it and [r526](REVIEW_r526.md) cleared it as "the one citation that reads L3 correctly", **r525 is right and r526 is wrong**, and the disagreement is still open on the record.

### D4, "reaches $\tfrac12$" carries two senses eleven lines apart, inside one block

The Statement says *"the family reaches $\tfrac12$ exactly at $p=2$ … and at $(p,q)=(3,3)$"*, where at $p=2$ it in fact **exceeds** $\tfrac12$. The "What it does not reach" paragraph then says nondegeneracy needs *"that $(3,3)$ is the **unique** split reaching $\tfrac12$"*, where "reaching" now means attaining exactly. **Read with one meaning the two sentences contradict each other.** The mathematics behind both is right; the word is not. This is the same class as the $\mu$, $B$ and $M$ collisions [conventions.md](../findings/conventions.md) already tables, and it propagates: [L126](../findings/second-order.md)'s title "*met in the two-factor family only at $S^3\times S^3$*" needs the same disambiguation, with [second-order.md:894](../findings/second-order.md)'s $\mu_{2,4}=\tfrac23$ as the witness that $p=2$ does more than meet it.

### D5, a restatement elsewhere pairs the signs with the wrong summands

[nondegeneracy.md:686](../findings/nondegeneracy.md) (and the identical fence-posts text) writes *"the eigenvalues are $\pm\mu$ at multiplicities $s_ps_q$ and $c_pc_q$"*, pairing $+\mu$ with $s_ps_q$. **Backwards.** Its own table forces the opposite: at $(4,4)$, $-\tfrac13$ has multiplicity $81=s_4s_4$ and $+\tfrac13$ has $54=c_4c_4+s_4=36+18$; at $(3,5)$, $-\tfrac38$ has $70=s_3s_5$ and $+\tfrac38$ has $44=c_3c_5+s_5=30+14$. So $-\mu$ sits on $S^2_0\otimes S^2_0$ and $+\mu$ on $\Lambda^2\otimes\Lambda^2$, which is where L26's own $X$ lives, and which is the order [L27](../findings/nondegeneracy.md)'s summand display gets right.

### D6, the "$n\ge5$" boundary on the multiplicity list is drawn too generously

The block's closing note excludes only $(2,2)$. But the dimensions of L27's ten-summand display do not sum to $\dim\mathcal W_n$ at $(2,3)$ either: $1+6+2+5+10+3+10=37$ against $\dim\mathcal W_5=35$. *L26 disclaims the list as numerical, so this is not L26's claim to defend*, but the note should say the list needs $p,q\ge3$, not $n\ge5$.

---

## What the citations use, none of them takes the false clause

Eighteen citations in the record proper (excluding review files). **Every one takes either the closed form, the eigenvector, or the $p=2$ excess. None takes the gap clause.**

| citation | what it takes | status |
| --- | --- | --- |
| [results.md:130](../results.md), [nondegeneracy.md:438](../findings/nondegeneracy.md), [:440](../findings/nondegeneracy.md), [INDEX-results.md:26](../findings/INDEX-results.md), [LEDGER.md:232](../findings/LEDGER.md) | closed form + $\tfrac12-\mu$ + the $p=2$ excess, for L11's corrected statement | **safe**, all values correct |
| [results.md:138](../results.md) (glance) | closed form, "criticality is unused", "bounds $\lambda_{\max}$ from below only" | **safe**, and notably it does **not** carry the false clause |
| [results.md:386–392](../results.md) | verbatim statement copy | **carries the false clause, second copy, must be fixed too** |
| [nondegeneracy.md:461](../findings/nondegeneracy.md), [:480](../findings/nondegeneracy.md) | L27's motivation and its $\pm\mu$ values | **safe**; the $\pm$ attribution over-cites (D-above) |
| [second-order.md:635](../findings/second-order.md), [:714](../findings/second-order.md), [:732](../findings/second-order.md), [:889](../findings/second-order.md) | $\mu_{p,q}$ as the four-set block value; the $(\tfrac23,\tfrac13,-\tfrac13)\to(2,-1,-1)$ sign reconciliation and $\lVert X\rVert^2=\tfrac43$ | **safe**; I reproduced $\mu_{m,m}=\frac{2}{n-2}$ and the norm |
| [second-order.md:869](../findings/second-order.md), [results.md:258](../results.md), [:748](../results.md), [INDEX-results.md:152](../findings/INDEX-results.md) | L133's attainment on L26's direction | **safe**, takes the eigenvector, not the range or the gap |
| [plan.md:51](../plan.md) | "$\mu=(n-2)/(2(p-1)(q-1))$ **only at $S^p\times S^q$**" | **safe, and correctly scoped** |
| [ATTEMPTS.md:2813](../ATTEMPTS.md), [:3972](../ATTEMPTS.md), [ELIM-canon.md:146](ELIM-canon.md), [ELIM-secondorder.md:185](ELIM-secondorder.md) | agreement notes and eliminations | **safe** |

**One propagation, in a review rather than the record.** [REVIEW_r526.md:52](REVIEW_r526.md) computes the balanced spectral gap as $\min\{\frac{1}{2(k-1)},\frac{k-3}{2(k-1)}\}=\frac{1}{2(k-1)}$ (correct) and then calls it *"matching [Lemma L26]'s own $1/(2\max(p,q)-2)$"*. **The match is with L27's $\lambda_M$, not with L26's $\mu$**, and r526 read the false clause as confirmation. That is the failure mode the clause invites.

---

## Summary

| item | verdict |
| --- | --- |
| $X=\phi_\pi\odot\phi_\rho$ minus $\Lambda^4$, coefficients $\tfrac23,\tfrac13,-\tfrac13$, $\lVert X\rVert^2=\tfrac43$ | **CONFIRMED** |
| $X\in\mathrm{Weyl}_n$ | **CONFIRMED**, Ricci vanishes automatically; the block gives no argument and should |
| $e\circ X=\mu X$, and no support outside the three pairings | **CONFIRMED** by hand |
| $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ for any three-block diagonal operator | **CONFIRMED** |
| $\mu=\frac{n-2}{2(p-1)(q-1)}$, every factor against the half-trace normalisation | **CONFIRMED** |
| $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$; excess $\frac1{2(n-3)}$ at $p=2$; equality at $(3,3)$ | **CONFIRMED** |
| the range $p,q\ge2$ | **CONFIRMED and sharp**; L27's narrower range is a different scope |
| threshold $\tfrac12$ is [L24](../findings/second-order.md)'s, and the set $\{\mu\ge\tfrac12\}=\{p=2\}\cup\{q=2\}\cup\{(3,3)\}$ is named | **CONFIRMED**, though the block never cites L24 for *why* $\tfrac12$ |
| **"For $p,q\ge3$ other than $(3,3)$ the gap is $1/(2\max(p,q)-2)$"** | **REFUTED**, witness $(3,4)$ |
| "results.md held the only copy" | **REFUTED** against `a9e4b8c0^` |
| "Observation L3's nondegeneracy claim" | **stale and miscalled** |

**VERDICT: REFUTED**, one clause of the canonical statement, in both copies. The lemma's load-bearing content is correct and, having rebuilt it from the definitions, I would defend every other line of it.
