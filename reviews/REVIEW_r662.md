# Review r662, Lemma L96, the weighted 2-class scheme

**Reviewer B, review number 662.** Target: [findings/diagonal-half.md:377](../findings/diagonal-half.md#L377), *"Lemma L96, the weighted 2-class scheme maximises at $\theta_0(n)$, only at $K_{n/2,n/2}$"*. Derived cold from [conventions.md](../findings/conventions.md); no computation was run, and nothing below is a screen, every number is a closed form evaluated by hand.

## Verdict

**REFUTED as written**, on two counts, with the even-$n$ core **CONFIRMED for attainment** and **subsumed**.

| claim | status |
| --- | --- |
| the heading, read at odd $n$ | **REFUTED**, $K_{n/2,n/2}$ does not exist, the family's maximum is nowhere near $\theta_0(n)$, and $\theta_0(n)$ **exceeds** the diagonal maximum $\Theta_n$ there |
| the value $\theta_0(n)$ at $K_{n/2,n/2}$, even $n$ | **CONFIRMED**, derived below in closed form |
| *"attained only at $(k,\lambda,\mu)=(n/2,0,n/2)$"* | **REFUTED**, witness $\mathrm{SRG}(6,2,1,0)=2K_3$, a second feasible parameter set attaining the same maximum |
| maximality over all feasible parameter sets, all even $n$ | **GAP**, an enumeration over $6\le n\le24$, with no script on the record, and the same file 140 lines below grades the primitive half *"screened and not proved"* |
| the whole lemma | **SUBSUMED** by [Lemma L57](../findings/problem.md#L540), which is stronger on every axis |

## 1. Parity, the lead

**The heading carries no parity qualifier and the body does.** The body ends *"at every even $n$ from $6$ to $24$"* ([:385](../findings/diagonal-half.md#L385)); the heading ([:377](../findings/diagonal-half.md#L377)) and the index row that copies it verbatim ([INDEX-results.md:111](../findings/INDEX-results.md#L111)) do not. Downstream is better: the report carries the qualifier in both places it restates the claim ([09-status.tex:59](../report/sections/09-status.tex#L59), [07-gradedness-split.tex:1269](../report/sections/07-gradedness-split.tex#L1269)). So the unqualified form lives in exactly two lines, and the repair is two lines.

**At odd $n$ the statement is false three times over.**

- $K_{n/2,n/2}$ does not exist. The named maximiser is not an object.
- The odd balanced split $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ is **not in the family**: $K_{k,l}$ with $k\ne l$ is not regular, so it is not a strongly regular graph and carries three distinct off-diagonal entry values rather than two. The block's own table four lines above already records the even-$n$ instance of this, $S^4\times S^8$ at $n=12$ is *"not a scheme"*, failing Hadamard closure by $0.18$ ([:373](../findings/diagonal-half.md#L373)). The odd balanced split fails for the same reason.
- $\theta_0(n)$ is **above** the diagonal maximum at odd $n$. [conventions.md](../findings/conventions.md) now fixes $\theta_0(n)^2=2(n-1)(n-2)/n^2$ as a closed form and nothing more, with $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))>0$ at odd $n$. I checked the identity behind it: $(n-2)^2(n+1)=n^3-3n^2+4$ and $n^2(n-3)=n^3-3n^2$, difference $4$ identically. So an odd-$n$ reading of L96 asserts a maximum strictly above what the diagonal locus attains, **the exact failure mode already paid for twice on this record**, at [L0](../findings/problem.md) and at [L16](../findings/problem.md#L337), where *"four places said it did"*.

**What the true odd-$n$ maximum is.** Over the 2-class family at odd $n$, using the closed forms in §2:

| $n=9$, the complete family | $\theta$ |
| --- | --- |
| $K_{3,3,3}$ and its complement $3K_3$ (the only imprimitive case, $g=3$) | $0.769800$ |
| Paley$(9)=\mathrm{SRG}(9,4,1,2)$, self-complementary conference graph | $0$ |
| **maximum over 2-class schemes** | $\mathbf{0.769800}$ |
| $\Theta_9$ | $1.171080$ |
| $\theta_0(9)$ | $1.175921$ |

The family's maximum is $0.655\,\theta_0(9)$. In general at odd $n$ the imprimitive maximum is at $g=n/p$ with $p$ the least prime factor of $n$, so $g\le n/3$ and $\theta^2\le(n-1)(n-3)/n^2<\tfrac12\theta_0^2$; at odd prime $n$ no imprimitive 2-class scheme exists at all. **The right odd-$n$ statement is a strict inequality with no maximiser named**, and it is far from tight.

## 2. The maximum, derived

**Setup.** Coordinate-diagonal $W$, vertex matrix $M$ symmetric, hollow, $M\mathbf1=0$, at $\lVert M\rVert_F^2=t=2$, the **ordered**-pair sum that [conventions.md](../findings/conventions.md) pins. From that file's own identity, $2\theta=\langle M^{\circ2}+M^2,M\rangle$, i.e.

$$2\theta=\sum_{i\ne j}M_{ij}^3+\operatorname{tr}M^3 .$$

This reproduces the record's script formula $\theta=\sum_{a<b}w_{ab}^3+3\sum_{a<b<c}w_{ab}w_{bc}w_{ca}$ ([b_diagonal_functional.py](../scripts/route-b/b_diagonal_functional.py)) exactly, the trace contributing $6$ per triangle.

**The block's displayed $\theta$ is correct.** With $M=\alpha A+\beta(J-I-A)$, each row carries $k$ entries $\alpha$ and $n-1-k$ entries $\beta$, giving $\sum_{i\ne j}M_{ij}^3=n(k\alpha^3+(n-1-k)\beta^3)$; and $\operatorname{tr}M^3=f\mu_r^3+g\mu_s^3$, the eigenvalue $0$ on $\mathbf1$ contributing nothing. That is the block's display verbatim.

**The weights are forced, so the maximisation is discrete.** Writing $k'=n-1-k$: zero row sums give $\beta=-k\alpha/k'$, and $\lVert M\rVert_F^2=2$ gives $\alpha^2=2k'/\big(nk(n-1)\big)$. The only residual freedom is the sign of $\alpha$, and $\theta$ is odd in $M$, so each parameter set contributes $\pm\theta$ and one takes the positive branch. **"Weighted" therefore does not mean continuous weights**, the answer to the brief's §2 question is that the family is discrete and an enumeration is the right instrument. The block says so in one clause (*"the row-sum and norm conditions fix $\alpha,\beta$ from $(n,k)$"*) and should say it in the heading's word *weighted*, which currently reads as if it meant a variational problem.

**Closed form.** Carrying the SRG identities $fr+gs=-k$, $fr^2+gs^2=k(n-k)$, $fr^3+gs^3=nk\lambda-k^3$, $f+g=n-1$ through, I get

$$\theta^2=\frac{2\Phi^2}{n^3k(n-1)k'^3},\qquad \Phi=nk'(n-1-2k)+(n-1)^2(n\lambda-k^2)+3(n-1)k(n-k)-2k^2,$$

and $\Phi=\pm n(n-1)k'(1+\lambda-\mu)$ identically, so this **is** the record's [Lemma L74](../findings/diagonal-half.md#L451) closed form

$$\theta(\Gamma)=\lvert1+\lambda-\mu\rvert\sqrt{\frac{2(n-1)}{nk(n-1-k)}}$$

re-derived independently. Checked at four points: $\lvert\Phi\rvert=120,180,288,1188$ against $n(n-1)k'\lvert1+\lambda-\mu\rvert=120,180,288,1188$ at $K_{3,3}$, $2K_3$, $K_{3,3,3}$, $K_{4,4,4}$.

**The maximiser's value.** At $K_{n/2,n/2}=\mathrm{SRG}(n,n/2,0,n/2)$: $r=0$, $s=-n/2$, so $1+\lambda-\mu=1-n/2$, $k=n/2$, $k'=n/2-1$, and

$$\theta^2=\frac{2(n-1)\big(\tfrac n2-1\big)^2}{n\cdot\tfrac n2\cdot\big(\tfrac n2-1\big)}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2 .$$

**Confirmed.** I also derived it a second way, straight from the block structure, $M=\beta(B-I)+\alpha(J-B)$ with spectrum $0,\ \beta(c-1)n/(n-c)$ at multiplicity $m-1$, $-\beta$ at multiplicity $n-m$, which gives, for the $m$-equal-block complete multipartite $K_{m\times g}$, $n=mg$,

$$\boxed{\ \theta^2=\frac{2(n-1)(g-1)}{n(n-g)}\ }$$

This is **exactly** the formula the same file already carries 140 lines below, at [Observation L144](../findings/diagonal-half.md#L517), and it reproduces both of the block's recorded runners-up to all printed digits: $g=4$, $n=12$ gives $11/16$, $\theta=0.829156$ (the block's $K_{4,4,4}=(S^4)^3$); $g=3$, $n=12$ gives $44/108$, $\theta=0.638285$ (the block's $K_{3,3,3,3}=(S^3)^4$). It is strictly increasing in $g$, so the imprimitive maximum is at $g$ largest, i.e. $g=n/2$, i.e. **$n$ even**.

**Is L96 a restatement of the $\theta_{k,l}$ monotonicity?** Partly, and the brief's guess is right about the mechanism but not the scope. The record's $\theta_{k,l}^2=2\frac{n-1}{n-2}\big(1-\frac{n-1}{kl}\big)$ agrees with $\theta^2=2(n-1)(g-1)/(n(n-g))$ at $k=l=g=n/2$ (I checked both reduce to $2(n-1)(n-2)/n^2$) and [L57](../findings/problem.md#L540)'s $\theta(S^p\times S^q)^2=2(n-1)(p-1)(q-1)/((n-2)pq)$ is algebraically identical to $\theta_{k,l}^2$ since $(p-1)(q-1)=pq-n+1$. But the 2-class family is **larger** than the two-block products: it contains every SRG, most of which are not sphere products at all. So L96 is the $\theta_{k,l}$ monotonicity **on the imprimitive slice only**, and its content beyond that is the claim that no primitive SRG beats it. That extra content is the part that is not proved.

## 3. "Only at", refuted, with a witness

**Uniqueness is asserted by enumeration, not proved.** No inequality is named, no equality case is tracked, and there is no argument in the block that could carry a rigidity statement.

**And as stated it is false.** The maximum is attained at a **second** feasible parameter set: the complement.

> **Witness, $n=6$.** $\mathrm{SRG}(6,3,0,3)=K_{3,3}$ gives $\Phi=-120$ and $\theta^2=2\cdot120^2/(216\cdot3\cdot5\cdot8)=28800/25920=10/9$. $\mathrm{SRG}(6,2,1,0)=2K_3$ gives $\Phi=+180$ and $\theta^2=2\cdot180^2/(216\cdot2\cdot5\cdot27)=64800/58320=10/9$. **Both equal $\theta_0(6)^2$.** Both satisfy $k(k-\lambda-1)=(n-k-1)\mu$, so both are inside the block's own enumeration set. The block names only $(3,0,3)$.

In general $(n/2,0,n/2)$ and $(n/2-1,n/2-2,0)$ are a complementary pair, $M\mapsto-M$ carries one to the other, and $\theta$ is odd, so both branches deliver $+\theta_0(n)$ once the sign of $\alpha$ is chosen for positivity. **The record already knows this and says it correctly one lemma away**: [INDEX-results.md row 74](../findings/INDEX-results.md#L88), *"$\mathrm{SRG}(2m,m,0,m)=K_{m,m}$ and $\mathrm{SRG}(2m,m-1,m-2,0)=2K_m$ are the only saturating sets, complements, hence one point up to sign"*, and [results.md:200](../results.md#L200) calls them *"the two sign branches of $S^m\times S^m$"*. L96 contradicts its own file's neighbour.

**Up to what?** The block states nothing. The correct qualifier, and it is available on the record, is [L57](../findings/problem.md#L540)'s: **up to sign and permutation, uniquely for $n\ge5$**. Add graph complementation, which is the sign in disguise. Three group actions, none named in L96.

## 4. The block is subsumed

[**Lemma L57**](../findings/problem.md#L540), *"the diagonal theorem, all $n$, both parities"*, proves

$$\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3\quad\text{for every diagonal }W\text{ at every }n\ge4,$$

with equality exactly at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$, up to sign and permutation, uniquely for $n\ge5$, two independent Gate 2 proofs of its one open lemma ([findings/INDEX.md](../findings/INDEX.md#L28): *"the all-$n$ diagonal theorem is complete, every step proved, both equality cases proved, constants symbolic in $n$"*).

L57 beats L96 on **every** axis the brief asks about:

| axis | L96 | L57 |
| --- | --- | --- |
| domain | 2-class schemes (a discrete subset) | the whole diagonal locus $\mathcal D_n$ |
| range of $n$ | even, $6\le n\le24$ | every $n\ge4$, both parities |
| constant | $\theta_0(n)$ (wrong at odd $n$ | $\Theta_n$), right at both |
| evidence | enumeration | proof |
| rigidity | asserted, and false as stated | proved, with the group named |

Every 2-class scheme is a diagonal critical point ([L74](../findings/diagonal-half.md#L451)), so L57 gives L96's even-$n$ content in one line, **with** the uniqueness L96 lacks; and at odd $n$ it gives the correct strict inequality. **L96 is redundant, and its constant is the one L57 was repaired to stop using.**

## 5. Scope, consumers, provenance, duplication, pointers

- **Scope.** *"Weighted 2-class association scheme"* = strongly regular graph with the two weights fixed by row sums and norm. That is a large, classified, infinite family, but it is a **discrete set inside a continuum**: $\mathcal D_n$ has dimension $n(n-3)/2$ and the schemes are isolated points in it. The block is honest about the residual (*"$d\ge3$ classes"*, the non-vertex-transitive points), and the heading should carry the fence too.
- **Consumers.** [diagonal-half.md:389–396](../findings/diagonal-half.md#L389) (*"And the two halves of B1 now meet"*, which cites *"$\theta\le\theta_0$ with equality only at $K_{n/2,n/2}$, **closed**"* and inherits both defects), [findings/INDEX.md:25](../findings/INDEX.md#L25), [report/sections/09-status.tex:59](../report/sections/09-status.tex#L59), [report/sections/07-gradedness-split.tex:1269](../report/sections/07-gradedness-split.tex#L1269). **Blast radius: moderate and entirely inside the diagonal half**, which L57 has since closed independently, so nothing load-bearing falls if L96 is restated.
- **The $K_{n/2,n/2}$ ↔ balanced product correspondence is stated, not assumed**, in the block itself, again at [L144](../findings/diagonal-half.md#L517) (*"maximised uniquely at $g=n/2$, which is the balanced product"*), and again at [results.md:200](../results.md#L200). Confirmed.
- **Provenance.** The block carries no self-historical note, so nothing to falsify. `git log -S` puts the body at [559a75af](../findings/diagonal-half.md), 2026-08-23 (*"B1 settled on the 2-class locus, by enumeration over SRG parameters"*) and the heading at [03bab2f9](../findings/diagonal-half.md), 2026-09-02 (*"place headings for results 96–99"*). **The unqualified heading was written nine days after the qualified body, by a commit whose job was numbering, not stating**, which is how the parity restriction was dropped.
- **Reading used for the section question.** I take L96's block as lines 377–388, terminated by the next `####`. This file has no `##` headings at all, only one `###` at line 11 and `####` blocks beneath it, so the ambiguity the brief flags does not arise here; under the wider reading lines 389–397 are a consumer of L96, not part of it, and I have treated them that way.
- **Duplication.** No verbatim duplicate under another number. But the same family is covered twice more in the same file, at **better** evidence grade: [L74](../findings/diagonal-half.md#L451) has the closed form, and [L144](../findings/diagonal-half.md#L517) splits the maximisation into *"THE IMPRIMITIVE HALF, PROVED"* (the closed form I re-derived, maximised uniquely at $g=n/2$) and *"THE PRIMITIVE HALF, SCREENED AND NOT PROVED"* (screened to $n\le200$, max $0.4758$). **L96's enumeration reaches $n\le24$; L144's screen reaches $n\le200$ and declines to call it a theorem.** The weaker evidence is the one carrying the word *settled*.
- **Pointers.** The block contains no links, so all pointers resolve vacuously. **It also cites no script**, and I found none in [scripts/](../scripts/) performing the parameter enumeration, so the block's only evidence is not reproducible from the record.
- **Index.** L96 has an entry in [INDEX-results.md:111](../findings/INDEX-results.md#L111) (*"Gate 2: no verdict on the record"*) and **no entry in [results.md](../results.md)** at all, while L74, its weaker neighbour, has two.
- **An unstated hypothesis.** The constant $\theta_0$ comes out only at $\lVert M\rVert_F^2=t=2$, the ordered-pair normalisation. Under the unordered reading every $\theta$ here scales by $2^{-3/2}$ and nothing matches. The block never names the normalisation, the same omission [L55](../findings/diagonal-half.md#L410) two blocks below carries an explicit note about.

## 6. The repair, and what may be cited

1. **Heading and index row**: *"at even $n$, the weighted 2-class scheme maximises at $\theta_0(n)=\Theta_n$, attained exactly on the complementary pair $K_{n/2,n/2}$ / $2K_{n/2}$, one point up to sign and permutation"*. Two lines, [findings/diagonal-half.md:377](../findings/diagonal-half.md#L377) and [findings/INDEX-results.md:111](../findings/INDEX-results.md#L111).
2. **Add the odd-$n$ sentence**: at odd $n$ the family contains no sphere product, its maximum is at most $(n-1)(n-3)/n^2$ over the imprimitive cases and is $0$ for conference graphs, and $\theta<\Theta_n<\theta_0(n)$ strictly.
3. **Grade the evidence**: enumeration over $6\le n\le24$, no script recorded, and [L144](../findings/diagonal-half.md#L519) already declines to call the primitive half proved. Either cite a script or downgrade *settled* to *screened*.
4. **Or retire the lemma into [L57](../findings/problem.md#L540)**, which proves strictly more and states the rigidity group. That is my recommendation: L96 as a separate number buys nothing and keeps a refuted constant alive on the record.

**What the record may cite today.** Attainment at even $n$ ($\theta=\theta_0(n)$ at $K_{n/2,n/2}$), is **proved**, by the derivation in §2. Maximality over the 2-class family is **proved for the imprimitive half** (§2's monotone closed form) and **screened only for the primitive half**. Uniqueness is **not proved anywhere in L96**, and as stated is false; the uniqueness the record actually owns comes from [L57](../findings/problem.md#L540), not from here.
