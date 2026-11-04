# Review r654, Observation L56, the graded families' floor

**Reviewer B of an independent pair (companion takes r653). Target: [findings/ungraded-slack.md](../findings/ungraded-slack.md) line 272, `#### Observation L56, at fixed $n$, the named graded families have a floor, and it is not the set's floor`, plus the section its provenance note names.**

**Standing rule observed: analysis only.** Every formula below is derived by hand. Two exact-rational screens were run over my own finished algebra to catch transcription slips, they are reported as screens in §3 and §4 and **no positive claim rests on them**. The block's table was not extended to further $n$ or further factorisations.

## Verdict

**REFUTED on both headline clauses, and the first is repairable into a Lemma at every $n$, the second has no witness anywhere on the record.**

| clause | verdict |
| --- | --- |
| "gap" is a distance from $\theta$ to the target | **REFUTED as a reading.** The quantity is the **smallest nonzero eigenvalue modulus of $W$ on $(\ker W)^\perp$**, from [nondegeneracy.md](../findings/nondegeneracy.md). The block never says so, and the section its provenance names never defines it |
| among the products the smallest gap at fixed $n$ is at the most unbalanced factorisation | **CONFIRMED in direction, and upgradable to a THEOREM at every $n\ge6$**, §3 derives $\mathrm{gap}(p,q)$ in closed form, strictly increasing in $p$ |
| $0.062994$ at $S^3\times S^7$ ($n=10$), $0.038925$ at $S^3\times S^9$ ($n=12$) | **numbers CORRECT, attainment point REFUTED.** These are the $p=3$ values. The minimum is at $p=2$: $0.031497$ and $0.020101$, at $S^2\times S^8$ and $S^2\times S^{10}$ |
| the balanced product sits at the largest gap | **CONFIRMED, and proved** in §3.4 for every even $n\ge6$, over the two-block splits |
| the families' floor is not the set's floor | **REFUTED as stated.** No witness exists. The block's own source says the question is **untouched**, and its one falsifier hunt returned nothing graded at all |
| *"the mathematics has always been in this file"* | **FALSE.** `git log -S` puts the mathematics in [nondegeneracy.md](../findings/nondegeneracy.md) on 2026-08-26 and in this file only on 2026-08-31, the day the file was created |
| *"the argument is in this file under 'The sharp (II)-side bound …'"* | **FALSE.** That section carries no spectral-gap material of any kind |

**The finding that matters most:** the correction landed on 2026-08-27 and the block was numbered on 2026-08-31. **L56 was stale at birth by four days**, and it is now the third of three live copies of a table the record has already withdrawn.

## 0. The readings I adopt, stated before deriving

[conventions.md](../findings/conventions.md) was repaired today; I state which line of it I use for each symbol and pin each to an anchor I can check independently.

| symbol | reading I use | anchor |
| --- | --- | --- |
| $\lVert W\rVert$ | $\mathop{\mathrm{tr}}(W^2)=\sum_\alpha\lambda_\alpha^2=1$ over $\Lambda^2$, the half-trace pairing under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal | the $M$ row and the "Norms and pairings" bullet of [conventions.md](../findings/conventions.md) |
| $\theta$ | $P(W)/\lVert W\rVert^3$; $Q(W)=\theta W$ at a critical point | the $\theta$ row |
| $\theta_0(n)$ | the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$ **alone** | the repaired $\theta_0$ row |
| $\Theta_n$ | the diagonal maximum; $=\theta_0(n)$ at even $n$ | the repaired $\Theta_n$ row |
| $K$, the vertex matrix | $K_{ab}=W_{abab}$, symmetric hollow; **on the diagonal locus the $\Lambda^2$ spectrum is the multiset of ENTRIES of $K$**, one per unordered pair | the $M$ row and "The vertex matrix" section |
| "diagonal" | diagonal in coordinate $2$-planes $e_i\wedge e_j$ | the "Diagonal means…" bullet |
| $S_{XYZ}$ | ordered slots, **not used below**; L56 touches no block contraction | the $S_{XYZ}$ row |

**And the reading the block itself omits.** L56 uses the bare word *gap* and defines it nowhere. It has exactly one meaning that reproduces its numbers, and it is not the one the word suggests:

> **gap$(W)$ = the smallest NONZERO modulus in the $\Lambda^2$ spectrum of the unit-norm $W$**, i.e. the spectral gap of $W$ on $(\ker W)^\perp$, which is padding-invariant.

That is the quantity [nondegeneracy.md](../findings/nondegeneracy.md) constructs under "The repair, scoped: it must be the smallest NONZERO modulus, and it cannot be uniform in $n$", and it is measured **against zero**, not against $\theta_0(n)$, $\Theta_n$ or $M(n)$. §1 shows this is forced.

**The parity trap does not bite, but for a reason the brief did not anticipate.** $S^3\times S^7$ has $n=10$ and $S^3\times S^9$ has $n=12$, both even, so $\Theta_n=\theta_0(n)$ there and the two symbols coincide. **That is irrelevant here**: neither $\Theta_n$ nor $\theta_0(n)$ appears anywhere in the quantity being measured. I state it because the brief asked, not because it is load-bearing.

## 1. Settling the direction, the brief's suspected sign error is not there, but a reading error is

The brief supplies the companion identity $\theta_{k,l}^2=2\frac{n-1}{n-2}\big(1-\frac{n-1}{kl}\big)$ and observes that it is strictly increasing in $kl$, so an unbalanced split has the **smaller** $\theta$ and hence the **larger** distance to the target. That is correct, and I verified the identity two ways.

**Check 1, against the multi-block closed form** in the same file, at $k=2$:

$$\theta^2=\frac{2(n-1)^2}{(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}}\ \xrightarrow{\ k=2\ }\ \frac{2(n-1)^2}{n^2+\frac{q^2}{p-1}+\frac{p^2}{q-1}}.$$

At $(p,q)=(3,7)$ the denominator is $100+\tfrac{49}2+\tfrac96=126$, giving $\theta^2=\tfrac{162}{126}=\tfrac97$. The brief's form gives $2\cdot\tfrac98\big(1-\tfrac9{21}\big)=\tfrac97$. **Agree.**

**Check 2, against [nondegeneracy.md](../findings/nondegeneracy.md)'s $\theta=\sqrt{2(p-1)(q-1)(n-1)/(pq(n-2))}$.** Since $pq-(n-1)=pq-p-q+1=(p-1)(q-1)$, the brief's bracket is $\tfrac{(p-1)(q-1)}{pq}$ and the two forms are identical. **All three expressions on the record are one expression.**

**So if "gap" meant $\theta_0(n)-\theta$, the block would be exactly backwards.** At $n=12$ those distances run $0.0942$, $0.0345$, $0.0078$, $0$ across $(3,9)$, $(4,8)$, $(5,7)$, $(6,6)$, smallest at the balanced split, largest at the most unbalanced. The block asserts the reverse.

**But that is not what "gap" means, and the numbers prove it.** Under the target-distance reading $S^3\times S^7$ would read $1.2-1.133893=0.066107$, not $0.062994$; and $S^3\times S^9$ would read $0.094234$, not $0.038925$. **Neither number is recoverable.** Under the spectral reading both come out exactly (§3). The block's direction is therefore **right**, and its defect is that it ships a bare noun whose two available readings give opposite answers, in a file whose own convention document exists to stop precisely that.

*Recorded as a convention hazard: the word "gap" now carries at least three objects on this record, this spectral gap, the $\theta$-to-target distance, and the $0.324$ ceiling gap named in the very section L56's provenance points at.*

## 2. The vertex matrix, derived cold, and one sign the block has backwards

Let $W$ be the Weyl operator of $S^p\times S^q$, $n=p+q$, coordinate-diagonal in $2$-planes. $K$ is hollow, symmetric, and constant on the three index-pair orbits of $O(p)\times O(q)$: value $\alpha$ inside the first block, $\beta$ inside the second, $\gamma$ across.

**Ricci-flatness of a Weyl operator is exactly vanishing row sums of $K$.** For $i$ in the first block, $(p-1)\alpha+q\gamma=0$; for $j$ in the second, $(q-1)\beta+p\gamma=0$. Two equations, three unknowns, one line of solutions, **the entries are forced, not fitted**:

$$\alpha=-\frac{q\gamma}{p-1},\qquad \beta=-\frac{p\gamma}{q-1}.$$

**Which sign is the Weyl operator?** $Q$ is quadratic, so $Q(-W)=Q(W)$ and only one of $\pm W$ is critical with $\theta>0$; the record fixes $\theta>0$ ([nondegeneracy.md](../findings/nondegeneracy.md), "The sign of $W$ is part of the definition of $S$"). For an Einstein product metric $W_{abab}=R_{abab}-s$ with $s=\mathrm{Scal}/(n(n-1))>0$, and the cross-factor sectional curvature is $0$, so **$\gamma=-s<0$ and the within-block entries are positive.**

- **The block prints the opposite sign:** "$-q/(p-1)$, $-p/(q-1)$ and $1$" is $\gamma=+1$, i.e. $-K$.
- **The section L56's provenance names prints the correct one:** $w_{ab}=-\theta/(n-1)$ across, $w_{aa}=+\theta(n-n_a)/((n-1)(n_a-1))$ within.
- **The generating script agrees with the section, not the block:** [run_graded_gap_at_fixed_n.py](../scripts/runs/run_graded_gap_at_fixed_n.py) builds `Lam` with the block's signs and then returns `-diag_weyl(Lam)`, negating it back.

**Impact: none on any claim of L56**, which uses only moduli. **Recorded anyway**, because the printed entries contradict both the section cited as the argument and the code cited as the source, and because [results.md](../results.md) line 176 repeats them as if they were the operator.

## 3. The floor in closed form, the block's table is a corollary of a one-line theorem

### 3.1 The spectrum and the norm

The $\Lambda^2$ spectrum is the multiset of $K$'s entries over unordered pairs. Taking $\gamma=-1$ (so the within-block entries are positive) and writing moduli:

| value | modulus | multiplicity |
| --- | --- | --- |
| within block $p$ | $\dfrac q{p-1}$ | $\binom p2$ |
| within block $q$ | $\dfrac p{q-1}$ | $\binom q2$ |
| across | $1$ | $pq$ |

**Trace check.** $\binom p2\frac q{p-1}+\binom q2\frac p{q-1}-pq=\frac{pq}2+\frac{pq}2-pq=0$. ✓

**Norm.** With $\mathcal N:=\sum_\alpha\lambda_\alpha^2$ before normalisation,

$$\mathcal N=\frac{pq^2}{2(p-1)}+\frac{qp^2}{2(q-1)}+pq=\frac{pq}2\left[\frac q{p-1}+\frac p{q-1}+2\right],$$

and the bracket collapses:

$$\frac{q(q-1)+p(p-1)+2(p-1)(q-1)}{(p-1)(q-1)}=\frac{(p+q)^2-3(p+q)+2}{(p-1)(q-1)}=\frac{(n-1)(n-2)}{(p-1)(q-1)}.$$

$$\boxed{\ \mathcal N=\frac{pq\,(n-1)(n-2)}{2(p-1)(q-1)}\ }$$

### 3.2 Which entry is smallest

For $p<q$: $\frac q{p-1}\ge\frac q{q-1}>1$, and $\frac p{q-1}\le1$. **So the minimum modulus is $\frac p{q-1}$, the entry inside the LARGE block**, which is what the block's mechanism sentence says, and correctly. At $p=q$ the two within-block moduli are $\frac p{p-1}>1$ and the minimum is the cross entry $1$; the $p<q$ formula does **not** extend to $p=q$ and must be handled separately.

### 3.3 The closed form

$$\mathrm{gap}(p,q)=\frac{p/(q-1)}{\sqrt{\mathcal N}}=\sqrt{\frac{p^2}{(q-1)^2}\cdot\frac{2(p-1)(q-1)}{pq(n-1)(n-2)}}$$

$$\boxed{\ \mathrm{gap}(p,q)=\sqrt{\frac{2p(p-1)}{q(q-1)(n-1)(n-2)}}\qquad (2\le p<q)\ }$$

and at the balanced split $p=q=n/2$, where the cross entry is the smallest,

$$\boxed{\ \mathrm{gap}\big(\tfrac n2,\tfrac n2\big)=\frac1{\sqrt{\mathcal N}}=\sqrt{\frac{2(n-2)}{n^2(n-1)}}=\frac{\sqrt2\,\sqrt{n-2}}{n\sqrt{n-1}}\ \sim\ \frac{\sqrt2}n\ }$$

which is exactly the shrinking sequence [post F27](../findings/nondegeneracy.md) records, reproduced here from the vertex system alone.

**Both of the block's numbers now fall out with no measurement.** $n=10$, $(p,q)=(3,7)$: $\sqrt{12/3024}=\sqrt{1/252}=\mathbf{0.06299408}$. $n=12$, $(p,q)=(3,9)$: $\sqrt{12/7920}=\sqrt{1/660}=\mathbf{0.03892495}$. **Both are exact algebraic numbers**: $1/(6\sqrt7)$ and $1/(2\sqrt{165})$.

### 3.4 Monotonicity, and hence the ordering, at every $n$

$$\frac{\partial}{\partial p}\ \frac{2p(p-1)}{q(q-1)}\Big|_{q=n-p}>0,$$

immediately: $p(p-1)$ is strictly increasing and $q(q-1)$ strictly decreasing in $p$ on $2\le p<q$. **So $\mathrm{gap}$ is strictly increasing in $p$, and the minimum over two-block splits is at $p=2$, at every $n\ge6$.**

**The balanced split is strictly the largest, and this needs its own line** because it is not covered by the $p<q$ formula. Write $n=2m$, $p=m-t$, $q=m+t$ with $t\ge1$:

$$\frac{\mathrm{gap}(p,q)^2}{\mathrm{gap}(m,m)^2}=\frac{2p(p-1)}{q(q-1)(n-1)(n-2)}\cdot\frac{n^2(n-1)}{2(n-2)}=\frac{(m-t)(m-t-1)}{(m+t)(m+t-1)}\cdot\frac{m^2}{(m-1)^2}.$$

At $t=1$ this is $\frac{(m-1)(m-2)}{m(m+1)}\cdot\frac{m^2}{(m-1)^2}=\frac{m(m-2)}{(m+1)(m-1)}=\frac{m^2-2m}{m^2-1}<1$, and the ratio is strictly decreasing in $t$. **So the balanced product carries the strictly largest gap of the family at every even $n\ge6$**, the block's third clause, proved.

### 3.5 What this means for the label

**The whole ordering is a theorem, valid at every $n$, in three lines from a forced $2\times3$ linear system.** The block presents it as a two-row table at $n=10$ and $n=12$ and labels it `Observation`. Per the record's own literal labelling rule, **it is a `Lemma`**, and stating it as a table at two dimensions understates it by an infinite family. This is the seventh measured table in this audit to collapse to a closed form.

*Screen (reported as a screen; no claim rests on it).* I recomputed $\mathcal N$ and $\min|\lambda|/\sqrt{\mathcal N}$ in exact rationals for every two-block split at $n=10,12$ directly from the entry multiset, and separately from the section's $\theta$-normalised vertex solution. Both routes return $\lVert W\rVert=1$ identically and reproduce $0.031497$, $0.062994$, $0.105409$, $0.133333$ at $n=10$ and $0.020101$, $0.038925$, $0.062419$, $0.093048$, $0.112367$ at $n=12$, agreeing with the closed forms above to machine precision. This caught nothing; it is recorded because the derivation above is what the verdict rests on.

## 4. The attainment point is wrong, and the record already knew

$\mathrm{gap}$ is strictly increasing in $p$, so **the floor is at $p=2$, not $p=3$**:

$$\mathrm{floor}(n)=\mathrm{gap}(2,n-2)=\sqrt{\frac{4}{(n-2)(n-3)(n-1)(n-2)}}=\frac2{(n-2)\sqrt{(n-1)(n-3)}},$$

giving $0.031497$ at $n=10$ and $0.020101$ at $n=12$, **half the block's figures.**

**$S^2\times S^{n-2}$ is in the family and is not a technicality.** It is a two-block sphere product like the others, critical by the same projection argument, graded with $\mathfrak{so}(2)\oplus\mathfrak{so}(n-2)$, and **already tabulated at [graded-half.md](../findings/graded-half.md) line 29 as a graded critical point at $n=12$, $\theta=0.994987437$**, which my $\theta^2=(n-1)(n-3)/(n-2)^2=99/100$ reproduces exactly. So the block excludes from "the named graded families" a member the record names three files away.

**The cause is visible in the source.** [run_graded_gap_at_fixed_n.py](../scripts/runs/run_graded_gap_at_fixed_n.py) loops `for p in range(3, n//2+1)`. The loop's start index was reported as a structural fact.

**And the record has already fixed this.** [nondegeneracy.md](../findings/nondegeneracy.md) carries the correction under "**The floor is at $p=2$, not $p=3$**", *Gate 2, reviewers 155 and 156, agreeing*, with the same closed form and the same monotonicity argument I derived independently above. `git log -S` dates it:

| event | commit | date |
| --- | --- | --- |
| the $p=3$ table enters [nondegeneracy.md](../findings/nondegeneracy.md) | `6f4f2af5` | 2026-08-26 |
| the same sentence enters [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) | `052c33b7` | 2026-08-26 |
| **the correction to $p=2$** | `2ae66e3a`, `3af38e91` | **2026-08-27** |
| the sentence is numbered as L56 into [findings/](../findings/) | `86621751` | **2026-08-31** |
| L56 lands in [ungraded-slack.md](../findings/ungraded-slack.md) by the file split | `7ad0455d` | 2026-08-31 |
| [results.md](../results.md) rebuilt, carrying the withdrawn numbers | `609004eb` | 2026-09-02 |

**L56 was numbered four days after the numbers it carries were withdrawn**, by a pass that copied [report/](../report/) rather than [findings/](../findings/). It is worse than "half-false at birth": it was wholly superseded at birth.

**Three live copies of the withdrawn table remain**, none citing the correction: [findings/ungraded-slack.md](../findings/ungraded-slack.md) line 272, [results.md](../results.md) lines 176 and 518, and [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 725. **The corrected form exists in exactly one place**, [findings/nondegeneracy.md](../findings/nondegeneracy.md). *I made no edits; this brief's output is this file and a log.*

### 4.1 The interleaving sentence is arithmetically true and out of scope

$(S^3)^4$ at $n=12$: the multi-block vertex solution gives min modulus $\theta/(n-1)=0.638285/11=0.058026$, which does sit between $0.038925$ and $0.062419$. **But $(S^3)^4$ is ungraded**, the same file proves graded $\iff k\le2$ via $e_3=0$, and $e_3\big((3,3,3,3)\big)=108\ne0$. So a block whose headline is about **the named graded families** compares them against a point that is not in them. The sentence neither supports nor threatens the floor.

*From the same derivation, the general multi-block rule, which the record does not state:* the smallest modulus is the cross entry $\theta/(n-1)$ unless some block satisfies $2n_a>n+1$, in which case it is $\theta(n-n_a)/\big((n-1)(n_a-1)\big)$ inside that block.

## 5. "It is not the set's floor", no witness exists, and the source says so

**The block's body never argues this clause.** It is in the heading only. [results.md](../results.md) line 518 supplies the missing sentence, *"the graded set is wider than the families ([Lemma L58](../findings/ungraded-slack.md)) and its floor is a different number"*, so the argument, such as it is, is an appeal to [L58](../findings/ungraded-slack.md).

**[L58](../findings/ungraded-slack.md) does not supply the witness.** Its three surviving witnesses establish that the graded set is wider than the **subalgebra family**, which is a different statement, and none of them sits below the floor:

| L58 witness | $n$ | its gap | against the floor at that $n$ |
| --- | --- | --- | --- |
| $S^5\times S^7$ | $12$ | $0.093048$ (§3, it *is* one of the named products) | $4.6\times$ **above** $0.020101$ |
| padded $W_{\mathbb{CP}^2}$ | $4\to n$ | $1/\sqrt6=0.408248$, from the spectrum $(2,-1,-1,0,0,0)/\sqrt6$ the block itself prints | far **above** |
| $\mathbb{CP}^3$ | $6$ | not at $n=10$ or $12$ | out of scope |

**And the source states the opposite of the heading, in terms.** [nondegeneracy.md](../findings/nondegeneracy.md), immediately after establishing the floor:

> *"What this settles and what it does not. … among the **named** families at fixed $n$ there is a floor with a closed form. **Whether the full graded critical set respects it is untouched**"*

The one attempt to settle it is recorded there too, and it came back empty:

- the falsifier hunt inside a single grading at $n=6$ is marked **"the candidate falsifier is DEAD, killed by a sign convention"**;
- of $355$ converged critical points in that cone, **$0$ are graded**, *"So the cone constrains the floor in neither direction."*

**So L56's second clause asserts, as a verified `Observation`, the negative side of an open question that its own source declares untouched and whose only search returned nothing.** It fails the record's label rule twice over: nothing about the graded set's floor was measured at $n=10$ or $n=12$, and a claim that a floor is not attained needs an object below it.

**What would settle it.** Two routes, and the honest statement of both:

1. **A witness**, one graded critical point at $n=10$ or $n=12$ with smallest nonzero modulus below $2/\big((n-2)\sqrt{(n-1)(n-3)}\big)$. Producing one is a **falsifier hunt: computation, blocked by the analysis-only rule.** *What the run would decide:* a witness turns the clause into a Lemma with a named object; an empty return at the dimensions searched is an `Observation` about the search, exactly as the $n=6$ hunt already is, and changes nothing.
2. **An analytic route that needs no search**, the honest form of the clause. The graded critical set at fixed $n$ contains the $\sigma$-invariant slices, whose dimensions the record measures at $44$–$48$ at $n=6$ and $155$–$160$ at $n=8$ against a $1$-dimensional enumerated slice. **Whether $\inf\{\mathrm{gap}\}$ over that set is positive is precisely the reduction Reviewers 111 and 112 proposed**, closedness of the graded set $\iff$ a uniform per-$n$ lower bound. L56's heading answers it; the record does not.

**What the whole block is for, said plainly.** *The named families cannot certify a spectral-gap bound for the graded set, because they are a measure-zero named list inside it.* What would certify one is a lower bound on $\min|\lambda|$ derived from criticality and gradedness alone, a statement about $Q(W)=\theta W$ restricted to a $\mathbb Z_2$-graded $W$, not a census. The families supply the **upper** bound on any such constant: $\mathrm{gap}(2,n-2)=2/\big((n-2)\sqrt{(n-1)(n-3)}\big)$, which decays like $2/n^2$ and is what any per-$n$ bound must respect.

*One further scope note the record already flags and the block does not: $\mathbb{CP}^{n/2}$ is a named graded family and is absent from the floor computation entirely. So even the corrected floor is a floor over the two-block sphere products, not over "the named graded families".*

## 6. Provenance, pointers, duplication

**Provenance sentence, FALSE.** *"the result was numbered in [report/](../report/) and the mathematics has always been in this file"*.

- *"numbered in report/"*: **TRUE**, `052c33b7`, 2026-08-26, into [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex).
- *"the mathematics has always been in this file"*: **FALSE.** `git log -S'the vertex entries of $S^p\times S^q$ are'` returns four commits. The mathematics entered [findings/nondegeneracy.md](../findings/nondegeneracy.md) on 2026-08-26, [report/](../report/) on 2026-08-26, [graded-half.md](../findings/graded-half.md) on 2026-08-31 by the numbering pass, and [ungraded-slack.md](../findings/ungraded-slack.md) on 2026-08-31 by the split. **The file it claims to have always been in was created that same day.** Five days, and a different home file.

**Named-section pointer, FALSE.** *"the argument is in this file under 'The sharp (II)-side bound is a valid inequality whose separation role '"*. The heading exists ([ungraded-slack.md](../findings/ungraded-slack.md) line 5) and the pointer resolves as a string, so this is a false pointer rather than a dangling one. **That section contains no spectral-gap material at all**, no vertex entries, no eigenvalue moduli, neither figure. It does contain two decoys that plausibly explain how an automated pass matched it: *"a floor of $0.43$"* (the $J_5/r^2$ floor, an unrelated quantity) and *"the $0.324$ gap"* (the $\theta$ ceiling gap, a third meaning of the word). **The argument is in [nondegeneracy.md](../findings/nondegeneracy.md) under "The repair, scoped: it must be the smallest NONZERO modulus, and it cannot be uniform in $n$".**

*On the `##`-contains-`####` question two prior audits disagreed on: it does not arise here. Both L56 and its named section are `####` siblings under the file's single `#` title, so the pointer is between siblings under either reading, and the named section's content is fully determined by lines 5–72.*

**Duplication, one pair, of a kind the audit has not yet catalogued.** L56's statement is a **verbatim copy** of the paragraph at [nondegeneracy.md](../findings/nondegeneracy.md) under "The repair, scoped", down to the table and the mechanism sentence. Neither block cites the other. This differs from [L55](../findings/diagonal-half.md)/[L93](../findings/bispectral.md) and the [L38](../findings/ungraded-slack.md)/[L10](../findings/graded-half.md) pair in that only one copy is numbered, **and that is what made it dangerous**: the unnumbered copy was corrected in place on 2026-08-27, the numbered copy inherited the pre-correction text on 2026-08-31, and nothing linked them. *The adjacent [post F27](../findings/nondegeneracy.md) states the complementary half (no gap uniform in $n$) and L56 does not cite it either, though F27's $\sqrt2/n$ is the balanced case of L56's own closed form.*

**Hedging clauses, each checked.**

| clause | holds? |
| --- | --- |
| "the named graded families" | **overstated**, the computation ranges over two-block sphere products only, silently starting at $p=3$, with $\mathbb{CP}^{n/2}$ absent |
| "at fixed $n$" | **necessary and correct**, no uniform-in-$n$ floor exists, by §3.3's $\sim\sqrt2/n$ |
| "the most unbalanced" | **false as applied**, the most unbalanced split is $p=2$, and the block names $p=3$ |
| "among the products" | correct, and it is the clause that excludes $\mathbb{CP}^m$, but the heading says "families", which does not |

## 7. What I could not decide, and why

**Whether any multi-block partition undercuts $\mathrm{gap}(2,n-2)$.** Deciding it over all partitions at a given $n$ is a sweep, which the analysis-only rule blocks. *What the run would decide:* if some partition goes lower, the floor's closed form is a floor over two-block splits only and the corrected boxed formula in [nondegeneracy.md](../findings/nondegeneracy.md) needs its scope narrowed; if none does, that formula is the floor over all sphere products and becomes a genuine per-$n$ constant. **What I can say without a sweep**, from §4.1's rule: for a partition with no dominant block the gap is $\theta/(n-1)$, and $\theta$ falls with $k$; for $(2,n-2)$ the gap is $\theta$ times the much smaller factor $2/\big((n-1)(n-3)\big)$. At $n=10$ I checked three partitions by hand, $(2,2,6)$ at $0.062167$, $(2,2,2,4)$ at $0.062994$, $(2,2,2,2,2)$ at $0.052705$, all above $0.031497$. **Three hand values are not a proof and I record no positive claim on them.**

**Whether $\mathbb{CP}^{n/2}$'s gap at $n=10,12$ lies above the floor.** It needs the $\mathbb{CP}^m$ $\Lambda^2$ spectrum at $m=5,6$, which I did not derive. Scope, not refuted, the record flags it too.

## 8. The repair I would put on the record

1. **Relabel to `Lemma` and restate at every $n$**, replacing the two-row table with §3.3's closed form and §3.4's monotonicity. That is the whole of the first clause and it needs no measurement.
2. **Correct the attainment point to $p=2$** and the figures to $0.031497$ and $0.020101$, in all three stale copies, each citing [nondegeneracy.md](../findings/nondegeneracy.md)'s Gate 2 by r155/r156.
3. **Split the second clause out of the heading.** It is not verified at the dimensions named and its source calls it untouched; it belongs in [plan.md](../plan.md) as the open question "is $\inf\{\mathrm{gap}\}$ over the graded critical set at fixed $n$ positive", with $2/\big((n-2)\sqrt{(n-1)(n-3)}\big)$ recorded as the upper bound any answer must respect.
4. **Define "gap" in [conventions.md](../findings/conventions.md)** as the smallest nonzero $\Lambda^2$ eigenvalue modulus, and note the two rival readings, the $\theta$-to-target distance and the $0.324$ ceiling gap, since all three appear within forty lines of each other in one file.
5. **Fix the sign of the printed vertex entries** to match the operator, the cited section and the script.
6. **Cross-cite [post F27](../findings/nondegeneracy.md)**, whose $\sqrt2/n$ is the balanced case of this block's own formula.

---

*Reviewer B, r654. Companion r653 worked the identical brief; neither reviewer read the other's report or log.*
