# Review r395, Gate 2 on "the four-set discrepancy is built from the pair clause's own orbit vectors"

*Adversarial reviewer, cold brief, re-deriving before reading. Target: the last section of [ATTEMPTS.md](../ATTEMPTS.md), dated 2026-09-02, on [I18](../plan.md)'s four-set clause. **Analysis only**, inherited; the arithmetic below is a screen on objects built for the purpose from closed-form family data, reported as a screen.*

> **THE IDENTITY IS TRUE AND THE ROUTE IS A REGRESSION.** One of the three lines of (1) is sign-inverted; $\Sigma$ survives it because squares absorb the sign. And the object it delivers is **strictly weaker than what the record already holds**: at every in-band two-factor point the orbit bound on $\Sigma$ is $7$–$10\times$ looser than [post F50](../findings/INDEX-traps.md)'s surviving identity, and it lands **above** $\theta^2$ where the incumbent lands a factor $6$ **below**. The incumbent settles $\Sigma\ne\theta^2$ at every $(2,2)$-split of the family; the successor settles none of them.

## Verdicts

| # | Claim | Verdict |
|---|---|---|
| 1 | $A-B=o^{(jk)}_l-o^{(jk)}_i$ and cyclically | **PARTLY FALSE**, third line sign-inverted; two of three correct |
| 2 | $\Sigma=\tfrac12\sum(\text{o-differences})^2$ | **TRUE**, and confirmed to machine precision against [Lemma L121](../findings/second-order.md) at three families, but it is one of four unlabelled representations |
| 3 | $\Sigma=0$ at all-twin four-sets | **TRUE and weak**, two twins suffice, "pairings" should read "pairs", the converse is false with an on-record witness, and the causal gloss over-reads |
| 4 | The two clauses share their objects; nothing said it | **NARROWLY NEW as an identity, OVER-READ as a claim**, the $\lVert o\rVert$–[Lemma L68](../findings/diagonal-half.md) pricing is already printed in [I18](../plan.md)'s own body |
| 5 | $\lvert A-B\rvert\le2\lVert o\rVert_\infty\le2\sqrt{s_j+s_k-2\theta M_{jk}}$ | **TRUE, loose by $\sqrt2$** at the first step, and by a further $\approx2$ at the second in practice |
| 6 | $\Sigma\le6\max\lVert o\rVert^2\le12$ | **RIGHT NUMBER, BROKEN CHAIN**, $\max\lVert o\rVert^2\le2$ is **false**, and false at the record's own in-band points |
|, | Does it help? | **NO.** The bound it gives is worse than two bounds already on record |

## (1), the third line is sign-inverted, and the cause is that $o$ lives on an *ordered* pair

Direct expansion, symmetry of $M$ used freely.

**First line, correct.** $o^{(jk)}_l-o^{(jk)}_i=(M_{kl}-M_{jl})-(M_{ki}-M_{ji})=M_{ji}+M_{kl}-M_{ki}-M_{jl}=A-B$. Index legality holds: $o^{(jk)}$ is defined off $\{j,k\}$, and both $l$ and $i$ lie outside it in a four-subset.

**Second line, correct.** $o^{(kl)}_j-o^{(kl)}_i=(M_{lj}-M_{kj})-(M_{li}-M_{ki})=M_{ki}+M_{lj}-M_{li}-M_{kj}=B-C$. Legal: $i,j\notin\{k,l\}$.

**Third line, FALSE as written.** $o^{(jl)}_k-o^{(jl)}_i=(M_{lk}-M_{jk})-(M_{li}-M_{ji})=M_{ji}+M_{lk}-M_{li}-M_{jk}=A-C$, **not** $C-A$.

> **THE REPAIR IS ONE TRANSPOSITION, AND IT MAKES THE STATEMENT GENUINELY CYCLIC.** Since $o^{(kj)}=-o^{(jk)}$, the correct third line is
> $$C-A=o^{(lj)}_k-o^{(lj)}_i.$$
> The ordered pairs are then $(j,k)$, $(k,l)$, $(l,j)$ (a $3$-cycle on $\{j,k,l\}$) where the section wrote $(j,l)$ and broke it. **The root cause is that the record's set-notation $o^{(jk)}$ hides an orientation.** [Lemma L68](../findings/diagonal-half.md) only ever consumes $\lVert o\rVert^2$, which is order-symmetric, so the ambiguity was harmless until this section asked for a **signed** identity. A successor stating anything signed in $o$ must fix the ordered convention first.

**The consistency test the section did not run.** The three differences sum to zero identically, $(A-B)+(B-C)+(C-A)=0$. Under the section's own third line the sum reads $(A-B)+(B-C)+(A-C)=2A-B-C\ne0$, so the error is visible without any expansion at all.

**The uniform form, which is what should be recorded.** Fix any one vertex of $S$ as distinguished, say $i$. The three pairs inside $\{j,k,l\}$ are $\{j,k\},\{k,l\},\{l,j\}$, and each difference is taken between $o$'s entry at the **fourth** vertex and its entry at $i$. That single sentence carries all three lines and cannot be mis-cycled.

## (2), the formula is true, verified, and one of four

**True.** Squaring kills the sign error, so
$$\Sigma=\tfrac12\Big[\big(o^{(jk)}_l-o^{(jk)}_i\big)^2+\big(o^{(kl)}_j-o^{(kl)}_i\big)^2+\big(o^{(lj)}_k-o^{(lj)}_i\big)^2\Big]$$
holds. *It is worth saying plainly that this is a re-bracketing of four entries ($M_{ij}+M_{kl}-M_{ik}-M_{jl}$ regrouped as $(M_{kl}-M_{jl})-(M_{ki}-M_{ji})$) and not a lemma. Its whole value is whatever it buys downstream, which §"Does it help" prices.*

**Screened against the record, three families, machine precision.** Against [Lemma L121](../findings/second-order.md)'s spectrum through [Lemma L126](../findings/second-order.md)'s $\mu_{p,q}=\frac{n-2}{2(p-1)(q-1)}$, using $\Sigma=4\theta^2\mu^2$ at a $(2,2)$-split:

| point | $\theta$ (reproduces the record) | $\Sigma$, orbit-vector form | $\Sigma=4\theta^2\mu_{p,q}^2$ |
|---|---|---|---|
| $S^5\times S^{43}$, $n=48$ | $1.263631437$ | $0.119712071$ | $0.119712071$ |
| $S^6\times S^6$, $n=12$ | $1.236033081$ | $0.244444444$ | $0.244444444$ |
| $S^5\times S^7$, $n=12$ | $1.228239158$ | $0.261904762$ | $0.261904762$ |

*Criticality residual $0$ exactly at all three; $\theta$ matches [post F50](../findings/INDEX-traps.md)'s $1.263631$ and the record's $1.228239$. This is a screen, not evidence for a positive claim, it is here because it is what falsifies a mis-signed identity, and it did not.*

**The assignment is not forced, and the section does not say so.** The distinguished vertex is a free choice among the four elements of $S$, each giving a different triple of $(pair, index)$ assignments for the same three quantities, with $j$ distinguished, $o^{(ik)}_l-o^{(ik)}_j=A-C$ rather than $A-B$. So there are four representations (eight with orientation), all valid. **This is a missed strengthening rather than an error**: consequence (iii)'s bound may be minimised over the four choices, and the section takes one without noticing there were others.

## (3), true, but weaker than the sharp statement, and mislabelled

**The wording is wrong.** A four-set has three *pairings* (perfect matchings, the objects $A,B,C$ index) and six *pairs*. The identity consumes the three **pairs** inside $\{j,k,l\}$, not the three pairings. As written, consequence (i) names the wrong objects.

**Two twins suffice, not three.** The three differences sum to zero, so any two vanishing forces the third. $o^{(jk)}=o^{(kl)}=0$ already gives $\Sigma=0$.

**And twinness is not what is needed, constancy is.** $\Sigma=0$ iff each $o$ is *equal at its two evaluation points*, which is strictly weaker than $o=0$. **The gap is realised inside [post F50](../findings/INDEX-traps.md)'s own family**: at a $(3,1)$-split of $S^p\times S^q$ (three vertices in $F_1$, one in $F_2$) we get $A=B=C=\alpha+\gamma$, so $\Sigma=0$, while the two cross pairs used are emphatically **not** twins, carrying $\lVert o\rVert^2=0.437209$ at $S^5\times S^{43}$. They contribute nothing because $o^{(kl)}$ is *constant on $F_1$*, so its difference at two $F_1$ vertices vanishes. **So the converse is false, with a witness that is a recorded critical point rather than a construction.**

**The causal gloss over-reads.** "Which is why $\Sigma$ vanishes on the sphere-product four-sets" is false as a blanket: the $(2,2)$-splits of every $S^p\times S^q$ have $\Sigma=(\alpha+\beta-2\gamma)^2\ne0$, they are exactly [Lemma L121](../findings/second-order.md)'s nonzero four-set blocks and the only ones [I18](../plan.md) has to clear. What vanishes is $\Sigma$ at F50's *witness* four-sets, the $(4,0)$-splits, and the record already says so in those words.

## (4), new as an identity, over-read as a claim

**Nothing on record states the identity.** Grepping [findings/](../findings/) for the four-set block against $o$ returns only statements of the opposite flavour: [Lemma L128](../findings/second-order.md)(i) and [Lemma L126](../findings/second-order.md) both say *the four-set blocks carry no orbit direction*. **That is consistent with the identity and not a duplicate of it**, the orbit *tangent vector* lies in the pair blocks, while $\Sigma$ is a *scalar* assembled from entries of $o$. Both can hold, and both do.

**But "two of I18's three clauses are statements about the same family of vectors" is an over-read.** The pair clause is a spectral statement about $o^{(jk)}$ as an eigenvector of $\Delta^{(jk)}$ ([post F47](../findings/INDEX-traps.md)); the four-set clause is a scalar built from *differences of two entries* of three different $o$'s. Sharing a symbol is not sharing an object, and the section supplies no map between the two uses.

**And the pricing half is already printed.** [I18](../plan.md)'s own body states "$\lVert o\rVert$ is not free, [Lemma L68](../findings/diagonal-half.md) pins it", and [Lemma L68](../findings/diagonal-half.md)(i) is $g_{ab}=2\lVert o^{(ab)}\rVert^2$ with the twin characterisation $g_{ab}=0$ in (ii). So consequence (iii)'s "L68 prices it" is new only in its application to $\Sigma$.

## (5), correct, loose by $\sqrt2$, and looser still in practice

$\lvert A-B\rvert=\lvert o_l-o_i\rvert\le2\lVert o\rVert_\infty\le2\lVert o\rVert_2$ is valid, and $\lVert o\rVert_2^2=s_j+s_k-2\theta M_{jk}$ is [Lemma L68](../findings/diagonal-half.md)(iii) halved, correctly.

**The first step should be $\sqrt2$, not $2$.** $(o_l-o_i)^2\le2(o_l^2+o_i^2)\le2\lVert o\rVert_2^2$, so $\lvert A-B\rvert\le\sqrt2\lVert o\rVert_2$ directly, with no detour through $\lVert\cdot\rVert_\infty$. The $\ell^\infty$ step throws the factor away.

**In practice both steps cost.** At the $(2,2)$-split of $S^5\times S^{43}$: $\lvert A-B\rvert=0.345995$, $2\lVert o\rVert_\infty=0.631816$ (loose $1.8\times$), $2\lVert o\rVert_2=1.322431$ (loose $3.8\times$).

## (6), the number is right, the chain is broken, and it breaks at real points

The section's own arithmetic is self-consistent: $\Sigma\le\tfrac12\cdot3\cdot4\max\lVert o\rVert^2=6\max\lVert o\rVert^2$. **The second step, $\max\lVert o\rVert^2\le2$, is where it fails.**

The only route to $2$ from the stated inputs is $s_j+s_k\le\sum_as_a=\operatorname{tr}M^2=2$ together with discarding $-2\theta M_{jk}$, which needs $M_{jk}\ge0$, and cross entries of a sphere product are negative.

> **AND THE DISCARD IS NOT A TECHNICALITY: $\lVert o\rVert^2>s_j+s_k$ AT EVERY IN-BAND POINT ON RECORD.**
>
> | cross pair at | $s_j+s_k$ | $\lVert o\rVert^2$ |
> |---|---|---|
> | $S^5\times S^{43}$ | $0.369262$ | $0.437209$ |
> | $S^6\times S^6$ | $0.333333$ | $0.611111$ |
> | $S^5\times S^7$ | $0.354286$ | $0.628571$ |
>
> At $S^6\times S^6$ the discarded term is **$83\%$ of the total**. The bound the chain asserts is not merely unproved; the quantity it bounds routinely exceeds it.

**The unconditional constant from the stated inputs is $4$, not $2$**: $\lVert o\rVert^2\le2(s_j+s_k-2M_{jk}^2)\le4$. So the section's own chain gives $\Sigma\le24$. *The figure $12$ is recoverable (via the $\sqrt2$ repair of (5), $\Sigma\le3\max\lVert o\rVert^2\le12$) so the printed number survives by a coincidence of two errors in opposite directions.*

## The decisive question, does the identity help? No; it is a regression

Both forms evaluated at the $(2,2)$-splits, against the target $\Sigma\ne\theta^2$:

| point | $\Sigma$ (truth) | $\theta^2$ | **incumbent**: $\Sigma\le3m_4-\tfrac12\sigma^2$ ([post F50](../findings/INDEX-traps.md)) | **proposed**: orbit bound | ratio |
|---|---|---|---|---|---|
| $S^5\times S^{43}$ | $0.119712$ | $1.596764$ | $0.242253$ ✓ clears | $1.748837$ ✗ above $\theta^2$ | $7.2\times$ |
| $S^6\times S^6$ | $0.244444$ | $1.527778$ | $0.244444$ ✓ **exact** | $2.444444$ ✗ above $\theta^2$ | $10.0\times$ |
| $S^5\times S^7$ | $0.261905$ | $1.508571$ | $0.277619$ ✓ clears | $2.514286$ ✗ above $\theta^2$ | $9.1\times$ |

> **THE INCUMBENT SETTLES THE CLAUSE ON THIS FAMILY AND THE SUCCESSOR SETTLES NOTHING.** [Post F50](../findings/INDEX-traps.md)'s surviving identity $\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2$ proves $\Sigma\ne\theta^2$ at **every** $(2,2)$-split of the two-factor family, with a factor $6$ to spare and **exactly tight at $S^6\times S^6$**, where $\alpha=\beta$ makes the AM–GM step an equality. The orbit bound clears **none** of them. Where the orbit form *is* exact (the all-twin four-sets, $\Sigma=0$), the mass identity is exact too ($3m_4-\tfrac12\sigma^2=0$ at the $(4,0)$-split, checked). **So the orbit form is tied where it wins and $7$–$10\times$ behind everywhere that matters.**

**Even the crude constants go the wrong way.** $m_4\le\tfrac12\lVert M\rVert_F^2=1$ turns F50's identity into $\Sigma\le3$ with no further input. The section's crude chain reaches $12$, **a factor of $4$ worse than a bound the record already carries in one line**, and worse than [Lemma L124](../findings/second-order.md)'s $\Sigma=\tfrac32\lVert\operatorname{diag}V_+\rVert^2\le\tfrac32\rho^2$ on its own domain.

**And the framing misattributes what F50 refuted.** The section says it "replaces the refuted mass criterion". [Post F50](../findings/INDEX-traps.md) refuted the $m_4$-**only** criterion ("$m_4\ge\tfrac12$ forces $\theta<\sqrt{3/2}$") and in the same breath recorded the identity as *what survives*, with the instruction "a successor uses the identity, not the mass alone". The section replaces the survivor, not the casualty.

## What is worth keeping

- **The corrected identity**, with the ordered-pair convention fixed and the distinguished-vertex choice named as a choice. It is a one-line regrouping, so it belongs as a remark inside [Lemma L121](../findings/second-order.md), not as a route.
- **The sharp vanishing criterion**, which is strictly better than the section's: $\Sigma=0$ iff each of the three orbit vectors takes equal values at its two evaluation points. Twinness is a sufficient special case; the $(3,1)$-splits of every sphere product occupy the gap.
- **The ordered-pair warning**, which is a live trap for any future signed use of $o$.

## What a successor must clear

**Beat $\Sigma\le3m_4-\tfrac12\sigma^2$ at a $(2,2)$-split.** Any orbit-vector route must produce a number below the incumbent's at $S^5\times S^{43}$, $S^6\times S^6$ and $S^5\times S^7$ before it is worth carrying, the three points where the incumbent is $0.242$, $0.244$ (exact) and $0.278$ against $\theta^2\approx1.5$. **The obstruction is structural, not one of constants**: the identity expresses $\Sigma$ through *differences* of $o$-entries while [Lemma L68](../findings/diagonal-half.md) prices only the *norm*, and every route from a norm to a difference of two coordinates spends the factor the incumbent keeps. A successor bounds the **entry-spread** of $o^{(jk)}$, which is the section's own stated ambition, and which [Lemma L68](../findings/diagonal-half.md) does not deliver.

*Gate 2 debt on this section: **owed and now paid**, the identity stands with one line corrected, and the route it proposes is closed as a regression against the record's own surviving bound.*
