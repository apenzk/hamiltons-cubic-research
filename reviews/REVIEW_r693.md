# Review r693, Lemma L108, the Cauchy–Schwarz bound $\theta\le\tfrac12\sqrt{(n-1)G_2}$

**Review number: r693.** Reviewer A of a Gate 2 pair on identical briefs; r694 works the same brief independently and was not read. Target: the block headed `#### Lemma L108, the Cauchy–Schwarz bound ..., the first legal bound` in [findings/bounds.md](../findings/bounds.md). Analysis only; no computation was run, and nothing below rests on any.

## Verdict

**CONFIRMED, the inequality, its constant and its equality clause all rebuild cold from the definitions; six statements around them do not.** The bound is *not* a weakening of [L107](../findings/bounds.md): the same file's own elimination shows L108 together with the free support inequality *implies* L107, so it is the logically stronger of the two, and at padded $W_{\mathbb{CP}^2}$ it is numerically stronger as well. What is wrong is the scoping and the framing: the quantifier is understated in exactly the way [L107](../findings/bounds.md)'s audit repaired eleven headings below, the displayed $\tfrac12$ is convention-dependent through a convention the record does not table for this symbol, the "iff" needs $\theta\ge0$, and *"passes every gate the record now has"* cites a gate that was withdrawn **46 minutes after the block was committed**.

## Readings adopted, stated before use

[conventions.md](../findings/conventions.md) fixes these and I use them throughout:

- $\theta=P(W)/\lVert W\rVert^3$ **at every** $W$, not only at critical points; $Q(W)=\theta W$ is the extra content of criticality.
- **Sums over pairs are over ORDERED pairs unless the line says otherwise**, and $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes on repeated indices.
- $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)=\sum_\alpha\lambda_\alpha^2=1$ on the unit sphere of $\mathcal W_n$, the $\Lambda^2$ half-trace pairing; $\mathop{\mathrm{tr}}W=\sum_\alpha\lambda_\alpha=0$ from scalar-flatness.
- Hamilton's $\#$ carries $\tfrac12$: $(R\#S)_{kk}=\tfrac12\sum_{\alpha\beta}c_{k\alpha\beta}^2R_{\alpha\alpha}S_{\beta\beta}$ in a common eigenbasis.
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$ is **the closed form alone**, equal to $\Theta_n$ at even $n$ only.

**Two symbols the lemma is built from are in no conventions table.** $g_k$ and $G_2$ appear nowhere in [conventions.md](../findings/conventions.md). I take the record's own definitions, read off [L70](../findings/bounds.md) and the census block above L108:

$$g_k:=\big\lVert[\mathrm{ad}(v_k),W]\big\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}\ \ge0,\qquad G_2:=\sum_k\lambda_k^2g_k,$$

with $k,\alpha,\beta$ running over an orthonormal eigenbasis of $W$ on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, and **both sums over ordered slots**. Nothing below is stable under changing that last choice; see §3.

## 1. The derivation, cold

**Hypotheses consumed.** Unit norm; $\mathop{\mathrm{tr}}W=0$; total antisymmetry of $c_{abc}$ (hence $T\ge0$ and $T$ totally symmetric); relations **(A)** $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$ and **(B)** $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, which are [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1's $I\#I=(n-2)I$ and $W\#I=-W$ and consume first Bianchi and Ricci-flatness. **Criticality is not consumed**, and neither is relation (C).

*The zeroth moment.* Expanding the square and using total symmetry to move the free index onto the squared slot,

$$m_0=\sum_kg_k=2\sum_{k\alpha\beta}\lambda_\alpha^2T_{k\alpha\beta}-2\sum_{k\alpha\beta}\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=2\cdot2(n-2)\textstyle\sum_\alpha\lambda_\alpha^2-2\big(-2\sum_k\lambda_k^2\big)=4(n-2)+4=4(n-1),$$

the first term by **(A)** with weight $\lambda^2$, the second by **(B)** with weight $\lambda$ (pattern $\{1,1,0\}$). ✔

*The first moment.* The $\{2,1,0\}$ term is **(B)** with $f=\lambda^2$ after relabelling, $\sum_{k\alpha\beta}\lambda_k\lambda_\alpha^2T=-2\mathop{\mathrm{tr}}W^3$; the $\{1,1,1\}$ term is the **cubic identity**, which is definitional rather than critical, $\theta=P(W)=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$ and $\langle W,W^\#\rangle=\tfrac12\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}$, so that sum is $2(\theta-\mathop{\mathrm{tr}}W^3)$. Hence

$$m_1=\sum_k\lambda_kg_k=2(-2\mathop{\mathrm{tr}}W^3)-2\cdot2(\theta-\mathop{\mathrm{tr}}W^3)=-4\theta.\qquad✔$$

*The bound.* $g\ge0$ makes $\langle u,v\rangle_g=\sum_ku_kv_kg_k$ a semi-inner product; Cauchy–Schwarz on $u=\lambda$, $v=\mathbf1$ gives $m_1^2\le m_2m_0$, i.e. $16\theta^2\le4(n-1)G_2$, i.e.

$$\theta\le\tfrac12\sqrt{(n-1)G_2}.\qquad\blacksquare$$

**Which relation this bound uses, answering the brief.** (A) and (B) only, plus the definitional cubic identity. **Criticality (relation (C)), never enters.** The companion finding the brief quotes is correct and applies here verbatim: this is the same criticality-free core that [L107](../findings/bounds.md)'s block already records for the $g$-route, and it is why [L142](../findings/bounds.md) was withdrawn as a duplicate of a bound that holds on all of $\mathcal W_n$.

*Where (C) does enter is one heading above*: the bridge $S_{22}=2\theta\mathop{\mathrm{tr}}W^3-2\mathop{\mathrm{tr}}W^4+\tfrac12G_2$ is (C) with $f=\lambda^2$, and that block correctly says "at a critical point". I reproduce it exactly: $G_2=2S_{22}-2\big(2\theta\mathop{\mathrm{tr}}W^3-2\mathop{\mathrm{tr}}W^4\big)$. **So $G_2$ and $S_{22}$ are interchangeable only at critical points, while the bound itself is not**, a distinction the block does not draw.

## 2. The constant and the direction, derived, not confirmed

Both constants come out of the two pinned moments and nothing else:

| where it comes from | value |
| --- | --- |
| $m_1^2$, the square of $-4\theta$ | $16\theta^2$ |
| $m_0$, the Killing mass $4(n-1)$ | the $(n-1)$, and a $4$ |
| $16/4=4$, square-rooted | the $\tfrac12$ |

Equivalently the bound is $\theta\le\tfrac12\sqrt{m_0}\cdot\sqrt{m_2}/\sqrt{m_0}\cdot\ldots$, more usefully, **the content is $m_2\ge m_1^2/m_0$ and every constant is a ratio of the two pinned moments**. The $(n-1)$ is $m_0/4$; the $\tfrac12$ is $\tfrac12$ because $m_1=-4\theta$ and $m_0=4(n-1)$ share the factor $4$.

**Direction.** Cauchy–Schwarz gives $\lvert\theta\rvert\le\tfrac12\sqrt{(n-1)G_2}$. The display drops the modulus for free, since the right side is $\ge0$; nothing is lost. But it costs the equality clause, see §3.

**Does the constant depend on the ordered-slot convention or on Hamilton's $\tfrac12$? Yes, jointly, and the block never says which reading it is in.** Under the unordered reading each of (A), (B), (C) loses its factor $2$ (this is [L113](../findings/bounds.md)'s audited finding, that the constant $2$ is "one $2$ from one source": Hamilton's $\tfrac12$ together with ordered slots), $g$ halves, and the moments become $m_0=2(n-1)$, $m_1=-2\theta$. Cauchy–Schwarz then reads

$$4\theta^2\le 2(n-1)\,G_2^{\mathrm{unord}}\quad\Longrightarrow\quad\theta\le\tfrac1{\sqrt2}\sqrt{(n-1)G_2^{\mathrm{unord}}} ,$$

**so the displayed $\tfrac12$ becomes $1/\sqrt2$.** The inequality is of course the same inequality ($G_2^{\mathrm{unord}}=\tfrac12G_2^{\mathrm{ord}}$) but *the printed constant is only correct in the ordered reading*, and the record has just paid for exactly this ambiguity twice: [L77](../findings/isotropy-cap.md)'s factor-$2$ dispute in which both reviewers were right, and [L114](../findings/bounds-relaxations.md)'s $6/4/2$ display. **This is the single most likely way a successor gets L108 wrong.** Owed: $g_k$ and $G_2$ in [conventions.md](../findings/conventions.md), with "ordered slots" attached.

**And $G_2$ collides with a symbol the record uses five times for something else.** $G_2$ is the exceptional group in [target.md](../findings/target.md) (twice in the Killing-constant paragraph and three quadric rows), in [INDEX-values.md](../findings/INDEX-values.md) (three rows), in [curvature-invariants.md](../findings/curvature-invariants.md), and is a Gram-matrix summand in [report/sections/90-appendix.tex](../report/sections/90-appendix.tex). This is the same class as the $B$, $M$, $\mu$, $\Pi$ and $d$ collisions [conventions.md](../findings/conventions.md) already tables, and it is untabled.

## 3. The equality case, both directions, and the witnesses

**($\Rightarrow$) and ($\Leftarrow$), as a statement about the Cauchy–Schwarz step: CONFIRMED.** Equality in $\langle\lambda,\mathbf1\rangle_g^2\le\lVert\lambda\rVert_g^2\lVert\mathbf1\rVert_g^2$ holds iff $\lambda$ and $\mathbf1$ are dependent in the semi-inner-product space, i.e. iff $\lambda_k=c$ for every $k$ with $g_k>0$. Forward: dependence forces $\lambda\equiv c$ on $\mathop{\mathrm{supp}}(g)$. Backward: $\lambda\equiv c$ gives $m_1=cm_0$, $m_2=c^2m_0$, so $m_1^2=c^2m_0^2=m_2m_0$. $\mathop{\mathrm{supp}}(g)\neq\varnothing$ since $m_0=4(n-1)>0$, so the constant is well defined and is forced to

$$c=\frac{m_1}{m_0}=\frac{-\theta}{n-1}\;<0\quad(\theta>0),\qquad\text{whence}\qquad G_2=c^2m_0=\frac{4\theta^2}{n-1}. \qquad✔$$

**The one break: the "iff" as printed is false in the $\Leftarrow$ direction at $\theta<0$.** The displayed bound is obtained by square-rooting $16\theta^2\le4(n-1)G_2$, and that step is equality-preserving only for $\theta\ge0$. At $\theta<0$ one can have $\lambda$ constant on $\mathop{\mathrm{supp}}(g)$ while $\theta<\tfrac12\sqrt{(n-1)G_2}$ strictly. Since the block never states a scope (§5) and the same file proves the companion bound on all of $\mathcal W_n$ (where $P$ is odd, so half of every orbit has $\theta<0$), this is a live gap rather than a pedantic one. **Repair: state the lemma at $\theta\ge0$, or write $\lvert\theta\rvert$ on the left.** [conventions.md](../findings/conventions.md)'s "normalise $W$ to $\theta>0$" covers it once the block says so.

**Witnesses on the record, three, and the block names only the first.**

1. **The balanced sphere product, every even $n$.** By hand, with no computation and no appeal to a screen: at $S^{m}\times S^{m}$, $\mathfrak h=\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ and $E_{\min}=\mathfrak m$ with $\dim\mathfrak m=m^2=n^2/4$; [L70](../findings/bounds.md) records $g_v=16(n-1)/n^2$ there, and $\tfrac{n^2}4\cdot\tfrac{16(n-1)}{n^2}=4(n-1)=m_0$ **exactly**, so $g$ vanishes off $E_{\min}$, $\lambda\equiv\lambda_{\min}$ on $\mathop{\mathrm{supp}}(g)$, and equality holds. *Two independently recorded numbers meeting the total to the digit is a real check on both.* Consistency: $\lambda_{\min}=-\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$ gives $(n-1)^2\lambda_{\min}^2=2(n-1)(n-2)/n^2=\theta_0(n)^2$, so $\theta=\theta_0(n)=(n-1)\lvert\lambda_{\min}\rvert$ and $G_2=4\theta_0^2/(n-1)=8(n-2)/n^2$, the block's own $0.56$ at $n=12$. ✔
2. **Every Einstein $S^p\times S^q$, at both parities, a one-line mechanism the block does not have.** $W$ is $\mathfrak h$-equivariant, so $[\mathrm{ad}(v),W]=0$ for every $v\in\mathfrak h$, so $g$ vanishes identically on $\mathfrak h=\Lambda^2V_p\oplus\Lambda^2V_q$ and is carried entirely by the mixed block $\mathfrak m$, on which $W$ is a scalar (the three blocks are $\mathrm{ad}(\mathfrak h)$-irreducible, so $W$ is scalar on each). Tracelessness makes that scalar the negative one, hence $\lambda_{\min}$. **So $\mathop{\mathrm{supp}}(g)\subseteq E_{\min}$ and equality holds.** This matches [L107](../findings/bounds.md)'s "equality holds at every Einstein $S^p\times S^q$" and supplies the reason, and it is what settles the brief's parity question in §5.
3. **Unpadded $W_{\mathbb{CP}^2}$ at $n=4$, a witness that is not a sphere product, and the record says the opposite.** The block's own arithmetic, continued one line: $\Delta=0$ puts $g$ on $E_{\min}\cup\ker W$, $m_1$ fixes the $E_{\min}$ share at $4\theta\sqrt6=12$ exactly, so the kernel share is $m_0-12=4(n-1)-12=4n-16$. **At $n=4$ that is $0$**, the kernel carries no $g$ at all, $\mathop{\mathrm{supp}}(g)\subseteq E_{\min}$, and equality holds: $\tfrac12\sqrt{3\cdot2}=\sqrt{3/2}=\theta$. The block's *"the kernel mass breaks the equality case"* is true **for padded** $W_{\mathbb{CP}^2}$, $n>4$, and false at $n=4$; the sentence carries no dimension.

**And the equality class is strictly larger than [L107](../findings/bounds.md)'s.** L107's equality case is $\mathop{\mathrm{supp}}(g)\subseteq E_{\min}$, which implies L108's $\lambda\equiv\text{const}$ on $\mathop{\mathrm{supp}}(g)$ but is not implied by it: L108 also admits $g$ concentrated on a *non-minimal* negative eigenspace at $\lambda=-\theta/(n-1)$. No such $W$ is on the record, and I do not claim one exists, but the record nowhere records that the two equality cases differ, and a successor reading "sharp at the same points" off the two blocks would be wrong.

## 4. "The first legal bound", the hedge does not survive, and the domination runs the other way

**"Legal" means: its lever passes [post F42](../findings/fence-posts.md)'s elimination test, the lever being a $\{2,2,0\}$ weight rather than a pinned $f(\lambda_a)$, $f(\lambda_a)\lambda_\beta$ or $f(\lambda_a)\lambda_\beta\lambda_\gamma$ one. "First" means: first bound on the record built on free rather than pinned data**, it is not a chronological claim, [L7](../findings/bounds.md), [L70](../findings/bounds.md) and [L73](../findings/bounds.md) all predating it. Under that reading the word was defensible when written and is not now:

- **The gate it names was withdrawn 46 minutes after the block was committed.** *Provenance, checked.* The block is [a60ced04](../findings/bounds.md), `feat(bounds): the first free invariant named, and the first legal bound through it`, **2026-09-01 22:12:08**. [post F42](../findings/fence-posts.md)'s positive half (*"use a $\{2,2,0\}$ moment or higher"*), was withdrawn in [365198e2](../findings/fence-posts.md), `fix(fence-posts): post 42 largely withdrawn`, **2026-09-01 22:58:48**. *"It passes every gate the record now has ... so post F42 admits it"* was therefore **stale within the hour**, in the same pattern the [L113](../findings/bounds.md) audit found one heading below. F42 now reads that the recommended lever "is spectrum-determined at the extremum, and the post pointed a successor at a door that is shut precisely where the conjecture is decided".
- **The block half-concedes this and keeps the heading.** The inserted r332 clause ("its lever is dead exactly where this record tests levers"), *is* F42's withdrawal, restated. So the heading asserts legality by a criterion the same sentence removes. **The word "legal" should come off the heading and the index row**, or be replaced by what is actually true: *the first bound whose lever is free at generic spectra and pinned at every extremal family on the record*.
- **"Sharp at the extremum and built from a quantity the spectrum does not determine" is self-cancelling at the extremum.** The balanced product has two eigenvalues, so $\lambda^2$ is affine there and $\{2,2,0\}$ collapses into the pinned class, the census block above says so explicitly. At the one point where the bound is sharp, $G_2$ *is* spectrally determined. The hedge "appears to be" is doing a great deal of work.

**Is it the weakest of the record's standing bounds? No, and the brief's hypothesis that it is a strict weakening of [L107](../findings/bounds.md) is REFUTED, by the block's own file, two headings below.**

- **Logically, L108 is the stronger statement.** The "moment problem" block immediately after L108 eliminates $m_2$ between Cauchy–Schwarz (from below) and the support inequality $m_2\le(\lambda_{\min}+\lambda_{\max})m_1-\lambda_{\min}\lambda_{\max}m_0$ (from above) and lands **exactly** on $\theta\le(n-1)\lvert\lambda_{\min}\rvert$. I reproduce the collapse: with $s=\lambda_{\max}$, $m=\lvert\lambda_{\min}\rvert$, $4\theta^2\le(n-1)\big[4(n-1)ms-4\theta(s-m)\big]$ gives $\theta^2+(n-1)(s-m)\theta-(n-1)^2ms\le0$, whose positive root is $\tfrac{n-1}2[-(s-m)+(s+m)]=(n-1)m$, the discriminant telescoping to $(s+m)^2$. **The support inequality is free (it is a consequence of the spectrum alone) so L108 implies L107 pointwise, and L107 implies nothing about $G_2$.** L107 is the complete consequence of the class *after* $m_2$ is eliminated ([L113](../findings/bounds.md)'s repaired theorem); L108 is the constraint *before* elimination, and it carries strictly more.
- **Numerically the two are incomparable, and L108 wins at the record's own stress point.** At padded $W_{\mathbb{CP}^2}$, $n=12$: L108 gives $\tfrac12\sqrt{11\cdot2}=2.345$, while L107 gives $11\cdot\tfrac1{\sqrt6}=4.491$. **L108 is the stronger of the two there by nearly a factor $2$**, on the very example the block introduces to deflate it. They coincide at the equality family.
- **As an *a priori* bound in $n$ alone it is the weakest thing on the record**, and that is the honest form of the brief's suspicion. $G_2\le\lVert\lambda\rVert_\infty^2m_0=4(n-1)\lVert\lambda\rVert_\infty^2\le4(n-1)$ gives $\theta\le(n-1)$, $O(n)$, against [L143](../findings/bounds.md)'s $1+\sqrt{n-2}=4.162$ at $n=12$ and [second-order.md](../findings/second-order.md)'s $\sqrt y+(n-2)y$. *That same chain incidentally verifies the [L142](../findings/bounds.md) withdrawal note's claim that L108 "gives the constant again": $\theta\le(n-1)\lVert\lambda\rVert_\infty$ falls straight out of it.* ✔
- **Does the record say any of this?** Partly. The elimination is in the file and is cross-linked from the L108 block's successor heading; [LEDGER.md](../findings/LEDGER.md) notes the missing back-link from L107 to these routes. **What the record nowhere says is the direction: that L108 $\wedge$ support $\Rightarrow$ L107, so L108 is not dominated.** Both the L108 block and index row 108 leave a reader to infer domination from the collapse, which is backwards.

**[Post F34](../findings/fence-posts.md) is cited on one of its three legs and fails on another.** F34's clearance criterion is *"a bound on the sharp term that is not a rearrangement of $\theta$, that is sharp to $O(n^{-2})$ uniformly in $n$, and whose worst case is the extremal family rather than the interior."* L108 clears the second (exact at the extremal family at every $n$, both parities, §3). It fails the third by the block's own next paragraph: at padded $W_{\mathbb{CP}^2}$ its value is $2.345$ against $\theta_0(12)=1.236$, so its worst case is the interior. And F34's first leg ("it is the conjecture restated"), is precisely what the block's closing sentence concedes, *"the surviving question is ... what realizability forbids for the pair $(G_2,\theta)$ jointly."* **So "post F34 has no lossy step to object to" reads F34 through a lossy-step lens it does not have here, and two of its three legs bite.**

## 5. Scope, understated, in the same way and in the same file as [L107](../findings/bounds.md)

**The bound holds at every $W\in\mathcal W_n$ with $\lVert W\rVert=1$, not only at critical points.** Every input is criticality-free: $g_k\ge0$ is manifest from $T=c^2$; $m_0$ and $m_1$ come from (A), (B) and the definitional cubic identity (§1). **The block states no quantifier at all**, sits under a heading about "what a critical point carries beyond its spectrum", and defines $G_2$ through an identity flagged "at a critical point", so it reads as a critical-point bound. This is exactly the defect [r563](REVIEW_r563.md)/[r564](REVIEW_r564.md) repaired for L107 eleven headings below, in a block that now says in bold: *"the $g$-route does not need criticality ... So the record files as a critical-point bound something that holds everywhere."* **The repair did not travel the forty-five lines up the file.**

**And the display is a unit-norm statement.** Off the unit sphere the moments are $m_0=4(n-1)\lVert W\rVert^2$ and $m_1=-4P(W)$ (L107's block gets this right and L108's drops both factors) so Cauchy–Schwarz gives $P(W)\le\tfrac12\sqrt{(n-1)G_2}\,\lVert W\rVert$ and, since $\theta=P/\lVert W\rVert^3$, the boxed display holds at $\lVert W\rVert=1$ only. Same trap [L70](../findings/bounds.md)'s block records against itself ("it needs $\lVert W\rVert=1$ ... the left side is scale-invariant while the right is homogeneous").

**Both parities.** The bound is exact at the maximiser at even *and* odd $n$: at even $n$ the balanced product with $\theta=\theta_0(n)=\Theta_n$; at odd $n$ the Einstein $S^p\times S^q$, by the equivariance mechanism of §3.2, where $\theta=\Theta_n<\theta_0(n)$, the gap being [conventions.md](../findings/conventions.md)'s $8(n-1)/(n^2(n+1)(n-2))$. **The block's phrase "exact at the balanced product" is unqualified**, and it is the phrase [conventions.md](../findings/conventions.md) flags today as the one that regrew [L0](../findings/problem.md)'s refuted constant. It happens to be harmless here (the exactness genuinely holds at both parities) but the sentence as written invites the reading that $\theta_0(n)$ is the attained value at odd $n$, which it is not.

## Provenance, duplication, pointers

| check | result |
| --- | --- |
| *"passes every gate the record now has"* | **STALE AT 46 MINUTES.** Block [a60ced04](../findings/bounds.md) 2026-09-01 22:12:08; F42's positive half withdrawn [365198e2](../findings/fence-posts.md) 22:58:48 the same evening. |
| *"appears to be the first bound ... sharp at the extremum and built from a quantity the spectrum does not determine"* | **Self-cancelling at the extremum**, $\{2,2,0\}$ is spectrally pinned at two-eigenvalue spectra, which the balanced product has. Hedged with "appears", so not a false statement, but it is the block's headline and it is empty. |
| *"$G_2=2$ exactly"* at padded $W_{\mathbb{CP}^2}$ | **CONFIRMED, and the tightening from the birth version's "$G_2\ge2$" is right**: the kernel contributes $0$ to $G_2$, so the $E_{\min}$ share alone gives $\tfrac16\cdot12=2$. |
| *"the kernel mass breaks the equality case"* | **TRUE for $n>4$, FALSE at $n=4$**, where the kernel share $4n-16$ vanishes. Missing dimension hypothesis. |
| *"$4\theta\sqrt6=12$"* | **CONFIRMED exactly**: $\theta=\sqrt{3/2}$, $4\sqrt{3/2}\sqrt6=4\sqrt9=12$. |
| *"$8(n-2)/n^2\approx0.56$ at $n=12$"* | **CONFIRMED**: $80/144=0.5\overline5$. |
| Duplication | The bound is restated as *"Cauchy–Schwarz (below): $m_2\ge m_1^2/m_0=4\theta^2/(n-1)$"* in the very next heading, cross-linked, which is fine. **It appears nowhere else in [findings/](../findings/), [results.md](../results.md) or [report/](../report/)**, and no other file numbers it. No duplication defect. |
| Pointers out of the block | [post F42](../findings/fence-posts.md), [post F34](../findings/fence-posts.md) and [r332](REVIEW_r332.md) all resolve. |
| Pointers *to* it | **[L142](../findings/bounds.md)'s withdrawal note links `[Lemma L108](#)`, an empty anchor.** It is the only inbound same-file link and it is dead. |
| Index row | **Row 108 of [INDEX-results.md](../findings/INDEX-results.md) carries no verdict marker at all**, unlike rows 106, 107, 109–114 which all carry one. Confirmed as the brief describes; it is also the *reason* this was the last block audited. |

**Does the block's own file settle anything it leaves open? Yes, three times.** The elimination two headings down settles its relation to L107; the [L107](../findings/bounds.md) block eleven headings down settles its quantifier; the [L113](../findings/bounds.md) block one heading down settles the source of the factor $2$ in its moments. None of the three is cited from the L108 block.

## What is owed

1. **State the quantifier**: "at every $W\in\mathcal W_n$ with $\lVert W\rVert=1$", and note that only the $G_2\leftrightarrow S_{22}$ bridge needs criticality.
2. **State $\theta\ge0$ on the equality clause**, or write $\lvert\theta\rvert$ on the left.
3. **Table $g_k$ and $G_2$ in [conventions.md](../findings/conventions.md)**, with "ordered slots" attached and the $G_2$/exceptional-group collision recorded alongside the $B$, $M$, $\mu$, $\Pi$, $d$ entries.
4. **Drop "legal" from the heading and from index row 108**, F42's positive half being withdrawn; or restate it as free-at-generic-spectra, pinned at every extremal family.
5. **Record the direction against [L107](../findings/bounds.md)**: L108 $\wedge$ support $\Rightarrow$ L107 pointwise, so L108 is the stronger statement and is strictly stronger numerically at padded $W_{\mathbb{CP}^2}$. It is not dominated, and the record currently implies it is.
6. **Add the two missing equality witnesses**, every Einstein $S^p\times S^q$ by $\mathfrak h$-equivariance at both parities, and unpadded $W_{\mathbb{CP}^2}$ at $n=4$, and dimension the "kernel mass breaks it" sentence to $n>4$.
7. **Fix `[Lemma L108](#)`** in the [L142](../findings/bounds.md) block.
8. **Note that L108's equality class strictly contains L107's**, the two coinciding only when the constant is $\lambda_{\min}$.

**No computation was run.** Every figure above is exact arithmetic on values already on the record, and every mechanism is by hand. The one thing I would want a run for, and did not open: whether any critical point has $g$ concentrated on a *non-minimal* negative eigenspace, which is the only way L108's equality class can be strictly larger than L107's in fact rather than in principle. **What such a search would decide**: a witness would show the two bounds are sharp at genuinely different points and would give the first $W$ where L108 bites and L107 does not; an exhaustive negative over the catalogue would decide nothing, the catalogue's isospectral pairs being triality pairs and so equal on every functional of $T$.
