# Review r653, Observation L56, the graded families' floor

Reviewer r653, reviewer A of an independent pair on identical briefs. Cold audit from [conventions.md](../findings/conventions.md). Target: [Observation L56, at fixed $n$, the named graded families have a floor, and it is not the set's floor](../findings/ungraded-slack.md#L272), body at [ungraded-slack.md:276](../findings/ungraded-slack.md#L276), together with the section its provenance note names, [The sharp (II)-side bound is a valid inequality whose separation role is dead](../findings/ungraded-slack.md#L5).

**Verdict: REFUTED on the values and the attainment point; CONFIRMED and upgradable to a Lemma on the ordering; GAP (no witness at all), on "it is not the set's floor".** The block's arithmetic is exact and its mechanism sentence is right, but its named minimiser $S^3\times S^7$ is not the most unbalanced factorisation, the true floor is roughly half the stated value, and **the record corrected exactly this four days before the block was stamped, in a different file the block does not cite**.

---

## Readings adopted, stated before anything is derived

| symbol | reading I use | why |
| --- | --- | --- |
| $\theta_0(n)$ | the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$ **and nothing more** | [conventions.md](../findings/conventions.md), as repaired 2026-09-04 |
| $\Theta_n$ | the diagonal maximum; $=\theta_0(n)$ at **even** $n$ | same. $n=10$ and $n=12$ are both even, so at both dimensions in this block $\Theta_n=\theta_0(n)$ and **the parity trap does not bite**, stated rather than assumed |
| norm | $\lVert W\rVert=1$ means $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$ on $\Lambda^2$ | [conventions.md](../findings/conventions.md), "the two spectra" |
| spectrum on the diagonal locus | the $\Lambda^2$ spectrum **is the multiset of entries** of the vertex matrix, with multiplicities | [conventions.md](../findings/conventions.md), the $M$/$K$ entry |
| $S_{XYZ}$ | ordered slots | [conventions.md](../findings/conventions.md). *It plays no part below; L56 uses no $S_{XYZ}$.* |
| section containment | I read each `####` as a **sibling section**, not nested inside the file's `##`. L56 sits under the file's top-level `#`, and the block it points at is a sibling `####` in the same file | stated because two prior audits disagreed on this |

**"Gap", settled, and this is the first finding.** The block never says what the gap is or against what it is measured. There are two candidate readings and they give opposite orderings:

- **(θ-gap)** $\Theta_n-\theta$, the distance from the family member's critical value to the target;
- **(spectral gap)** $\min\{\lvert\lambda\rvert:\lambda\in\mathop{\mathrm{spec}}(W),\ \lambda\ne0\}$ at $\lVert W\rVert=1$, the distance from the nonzero spectrum to $0$.

**The intended reading is the spectral one**, and the record fixes it elsewhere: [nondegeneracy.md:172](../findings/nondegeneracy.md#L172) is the section that introduces this quantity, and it explicitly repairs "$\min\lvert\lambda\rvert$" to "the smallest **nonzero** modulus", because padding a graded point makes $\min\lvert\lambda\rvert=0$ exactly and the padded point is still graded. I adopt that. **Neither the L56 block nor [results.md:518](../results.md#L518) says any of this**, and the word "floor" in the header pulls the reader toward the θ-reading, in which the block is false, see §1.

---

## 1. The direction, settled first

**The companion formula is correct, and I re-derived it from this file's own multi-block closed form rather than taking it on trust.** [ungraded-slack.md:31](../findings/ungraded-slack.md#L31) gives, for $S^{n_1}\times\dots\times S^{n_k}$,

$$\theta^2=\frac{2(n-1)^2}{(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}}.$$

At $k=2$, $n_1=p$, $n_2=q$, $p+q=n$, put $u=pq$. Over the common denominator $(p-1)(q-1)=u-n+1$,

$$\frac{q^2}{p-1}+\frac{p^2}{q-1}=\frac{p^3+q^3-p^2-q^2}{u-n+1}=\frac{n^2(n-1)-u(3n-2)}{u-n+1},$$

using $p^3+q^3=n^3-3un$ and $p^2+q^2=n^2-2u$. Adding $n^2$ collapses the numerator to $u(n^2-3n+2)=u(n-1)(n-2)$, so the denominator is $u(n-1)(n-2)/(u-n+1)$ and

$$\boxed{\ \theta_{p,q}^2=\frac{2(n-1)}{n-2}\Big(1-\frac{n-1}{pq}\Big).\ }$$

Two anchors it was not built from: at $p=q=n/2$ it gives $2(n-1)(n-2)/n^2=\theta_0(n)^2$; at $(5,7)$, $n=12$ it gives $264/175$, i.e. $\theta=1.2282390$, the record's own value for $S^5\times S^7$ at [ungraded-slack.md:287](../findings/ungraded-slack.md#L287). A third: at $(2,10)$ it gives $\theta^2=0.99$, $\theta=0.994987437$, the value [graded-half.md:29](../findings/graded-half.md#L29) tabulates for $S^2\times S^{10}$. **The companion result is confirmed.**

It is strictly increasing in $pq$, and $pq$ is minimal at the most unbalanced split, so:

| $n=10$ | $(3,7)$ | $(4,6)$ | $(5,5)$ |
| --- | --- | --- | --- |
| $\theta$ | $3/\sqrt7=1.133893$ | $1.185854$ | $1.2=\Theta_{10}$ |
| $\Theta_n-\theta$ | $0.066107$ | $0.014146$ | $0$ |

**So under the θ-reading the block is exactly backwards**: the θ-gap is *largest* at the most unbalanced factorisation and *zero* at the balanced one. It is also unsalvageable as a "floor" claim in that reading, because the balanced member attains $0$ and nothing can go below.

**And the block's numbers are not θ-gaps.** $0.066107\ne0.062994$. What they are is settled in §2.

---

## 2. The two numbers in closed form, the ordering is a theorem at every $n$

On the diagonal locus the $\Lambda^2$ spectrum is the multiset of vertex entries. For $S^p\times S^q$ the block gives $-q/(p-1)$, $-p/(q-1)$, $1$; the multiplicities are forced by which pair of indices the $2$-plane sits in ($\binom p2$, $\binom q2$, $pq$) and the trace vanishes identically, $-\binom p2\frac q{p-1}-\binom q2\frac p{q-1}+pq=-\tfrac{pq}2-\tfrac{pq}2+pq=0$, which is the Ricci-flatness check. Then

$$\Sigma:=\sum_\alpha\lambda_\alpha^2=\frac{pq}2\Big[\frac q{p-1}+\frac p{q-1}+2\Big]=\frac{pq}2\cdot\frac{n^2-3n+2}{pq-n+1}=\frac{pq\,(n-1)(n-2)}{2(p-1)(q-1)}.$$

For $p<q$ the smallest modulus is $p/(q-1)$, so the normalised value is

$$\mathrm{gap}(p,q)=\frac{p}{q-1}\Big/\sqrt\Sigma=\sqrt{\frac{2p^2(p-1)(q-1)}{(q-1)^2pq(n-1)(n-2)}}\ =\ \boxed{\ \sqrt{\frac{2\,p(p-1)}{q(q-1)\,(n-1)(n-2)}}\ }=\sqrt{\frac{2}{(n-1)(n-2)}\cdot\frac{\binom p2}{\binom q2}}.$$

At $p=q$ the smallest modulus switches to the cross-block entry $1$, giving $\mathrm{gap}=\sqrt{2(n-2)/(n^2(n-1))}$.

**The block's two numbers are exactly this.** At $(3,7)$, $n=10$: $\mathrm{gap}^2=\frac2{72}\cdot\frac3{21}=\frac1{252}$, $\mathrm{gap}=0.06299408$. At $(3,9)$, $n=12$: $\frac2{110}\cdot\frac3{36}=\frac1{660}$, $\mathrm{gap}=0.03892495$. Both exact algebraic numbers, both reproducing the block digit for digit. **So the table is a corollary of a closed form and the numerical `Observation` label understates it**, this is the seventh measured table in this audit to collapse.

**Monotonicity, and hence the ordering, is one line.** $\binom p2/\binom q2$ is strictly increasing in $p$ on $2\le p\le n/2-1$ (numerator up, denominator $\binom{n-p}2$ down), so $\mathrm{gap}$ is strictly increasing in $p$: **smallest at the most unbalanced split, largest at the balanced one**. The balanced case needs its own comparison because the minimising entry changes: $\frac{2(n-2)}{n^2(n-1)}$ against the $p=n/2-1$ value $\frac{2(n-4)}{n(n-1)(n+2)}$ reduces to $\frac{n-2}n>\frac{n-4}{n+2}$, i.e. $n^2-4>n^2-4n$. **So the balanced product is the strict maximum, at every even $n$.**

This is the most valuable thing available here: the two-row table becomes a statement at every $n$ and every factorisation. **It is also already on the record**, the identical formula stands at [nondegeneracy.md:199](../findings/nondegeneracy.md#L199), derived there for the same purpose. I reached it cold; the agreement is a cross-check, not a source.

---

## 3. REFUTED, the floor is at $p=2$, and the record said so four days before the block was written

**$S^3\times S^7$ is not the most unbalanced factorisation at $n=10$.** $S^2\times S^8$ is, and the closed form gives

$$\mathrm{floor}(n)=\mathrm{gap}(2,n-2)=\frac{2}{(n-2)\sqrt{(n-1)(n-3)}},\qquad 0.031497\ (n=10),\quad 0.020101\ (n=12),$$

roughly **half** the values the block names. $S^2\times S^{n-2}$ is not a marginal object: [graded-half.md:29](../findings/graded-half.md#L29) tabulates $S^2\times S^{10}$ as a graded critical point at $\theta=0.994987437$, which §1's formula reproduces exactly, and this very file uses partitions $(2,2,56)$ and $(2,2,2,2,2,50)$ in its own first section at [ungraded-slack.md:31](../findings/ungraded-slack.md#L31). The vertex solution $w_{ab}=-\theta/(n-1)$, $w_{aa}=\theta(n-n_a)/((n-1)(n_a-1))$ is Ricci-flat for every $n_a\ge2$, so nothing excludes $p=2$.

**The block's own hedges do not save it.** "The most unbalanced" is a superlative over a family whose index range the block never states; "at fixed $n$" is honoured; "the named graded families" is the clause that fails, because it silently means the two-block products with $p\ge3$.

**Multi-block products break the stated floor too.** The block says they "interleave rather than extending the trend", with $(S^3)^4$ at $0.0580$ between $S^3\times S^9$ and $S^4\times S^8$, which I verify exactly ($1/\sqrt{297}=0.058026$, against $0.038925$ and $0.062419$). But over **all** partitions of $12$ into blocks of size $\ge2$, $(2,2,8)$ gives $0.036497$ and $(2,2,2,2,2,2)$ gives $0.038925$, so the multi-block family reaches *below* the block's floor and *ties* it. At $n=10$ the block's minimiser $(3,7)$ is only fourth-equal, tied with $(2,2,2,4)$.

**And the record already holds the correction.** [nondegeneracy.md:195](../findings/nondegeneracy.md#L195) reads *"The floor is at $p=2$, not $p=3$, and the closed form below is for $p=3$ only"*, credited to Gate 2, [r155](REVIEW_r155.md) and [r156](REVIEW_r156.md) agreeing, with the corrected boxed floor at [nondegeneracy.md:203](../findings/nondegeneracy.md#L203). The dates are the finding:

| commit | date | what |
| --- | --- | --- |
| [6f4f2af5](../findings/nondegeneracy.md) | 2026-08-26 | the $p=3$ table first enters, in [nondegeneracy.md](../findings/nondegeneracy.md) |
| 99bfd7a4, 8f2c7a39 | 2026-08-27 | r155 and r156 refute the attainment point |
| 2ae66e3a, 3af38e91 | 2026-08-27 | the correction lands in [nondegeneracy.md](../findings/nondegeneracy.md) |
| 86621751 | **2026-08-31** | **L56's block is stamped**, in [graded-half.md](../findings/graded-half.md), carrying the refuted $p=3$ statement |
| 7ad0455d | 2026-08-31 | the split moves it into [ungraded-slack.md](../findings/ungraded-slack.md) |
| 609004eb | 2026-09-02 | it is copied into [results.md](../results.md) |

So the block is not a claim that was later refuted. **It is a refuted claim re-stamped as a numbered result four days after its refutation was folded into the record**, by a pass whose commit subject was "number the 24 results that only the report had numbered", the numbering pass took the text from [report/sections/07-gradedness-split.tex:725](../report/sections/07-gradedness-split.tex#L725), which had never received the correction.

---

## 4. The $\mathbb{CP}^m$ family, closing the record's own open scope note

[nondegeneracy.md:207](../findings/nondegeneracy.md#L207) leaves this hanging: *"$\mathbb{CP}^{n/2}$ is named in the record's graded list and is also absent from the floor computation; scope, not refuted."* It is decidable in closed form.

Under $\mathfrak u(m)\subset\mathfrak{so}(2m)$ write $\Lambda^2\mathbb R^{2m}=\mathfrak m\oplus\mathfrak{su}(m)\oplus\mathbb R\omega$ at dimensions $m^2-m$, $m^2-1$, $1$. The Fubini–Study curvature operator is $\mathrm{Id}+\Phi$ up to normalisation plus a rank-one term on $\omega$, with $\Phi(A)=-JAJ$ equal to $+1$ on $\mathfrak u(m)$ and $-1$ on $\mathfrak m$; fixing the normalisation against the record's printed $W_{\mathbb{CP}^2}$ spectrum gives $R$-eigenvalues $0$, $1$, $1+m$ on the three pieces, hence, after removing the trace,

$$\mathop{\mathrm{spec}}(W_{\mathbb{CP}^m})=\Big\{-c^{\,(m^2-m)},\ (1-c)^{\,(m^2-1)},\ (1+m-c)^{\,(1)}\Big\},\qquad c=\frac{m+1}{2m-1},$$

before normalisation. **Two anchors it was not built to hit**: at $m=2$ it returns $(2,-1,-1,0,0,0)$ with $\Sigma=6$, the record's own $W_{\mathbb{CP}^2}$ spectrum at [ungraded-slack.md:252](../findings/ungraded-slack.md#L252); at $m=3$ it returns multiplicities $6,8,1$ with $\ker W=0$, exactly [Lemma L58](../findings/ungraded-slack.md#L279)'s row for $\mathbb{CP}^3$. Then $\Sigma_m=3m(m^2-1)/(2m-1)$, which also reproduces [L38](../findings/ungraded-slack.md#L244)'s $\theta^2_{\mathbb{CP}^m}=(m+1)^2/\Sigma_m=\frac{(m+1)(2m-1)}{3m(m-1)}$, and

$$\mathrm{gap}(\mathbb{CP}^m)=\sqrt{\frac{(m-2)^2}{3m(m^2-1)(2m-1)}}\qquad(m\ge3;\ \text{at }m=2\text{ that eigenvalue is }0\text{ and the nonzero floor is }1/\sqrt6).$$

Comparing with the product floor at $n=2m$, the ratio is $\frac{(m-2)^2(m-1)(2m-3)}{3m(m+1)}$:

| $n$ | products' floor, at $S^2\times S^{n-2}$ | $\mathbb{CP}^{n/2}$ | named families' floor |
| --- | --- | --- | --- |
| $6$ | $0.129099$ | $0.052705$ | $\mathbb{CP}^3$ |
| $8$ | $0.056344$ | $0.056344$ | **exact tie** |
| $10$ | $0.031497$ | $0.052705$ | $S^2\times S^8$ |
| $12$ | $0.020101$ | $0.048050$ | $S^2\times S^{10}$ |

So the scope note resolves: **$\mathbb{CP}^{n/2}$ sits strictly below the products at $n=6$, ties them exactly at $n=8$, and lies above from $n\ge10$**, so it changes the named families' floor only at $n=6$ and the corrected $\mathrm{floor}(n)=2/((n-2)\sqrt{(n-1)(n-3)})$ stands at every even $n\ge8$. That is a complete statement over the named families, at every $n$, and it is a Lemma.

---

## 5. "It is not the set's floor", no witness, anywhere

**The block's body never states this half.** Read [ungraded-slack.md:276](../findings/ungraded-slack.md#L276): it says the smallest gap among products is at the most unbalanced split, gives the mechanism, and notes the multi-block interleaving. **The clause "and it is not the set's floor" exists only in the heading**, and in [results.md:518](../results.md#L518)'s closing sentence, *"the graded set is wider than the families (Lemma L58) and its floor is a different number"*.

**The next block does not supply the witness.** [Lemma L58](../findings/ungraded-slack.md#L279) proves the graded set is strictly wider than the **subalgebra family** by an eigenvalue count, and its surviving witnesses are $\mathbb{CP}^3$, $S^5\times S^7$ and $W_{\mathbb{CP}^2}$. That is a different statement and its witnesses do not do this job:

- $S^5\times S^7$ **is** a member of the family under audit, with $\mathrm{gap}=0.093048$, well above the $n=12$ floor;
- $\mathbb{CP}^3$ and $W_{\mathbb{CP}^2}$ belong to the $\mathbb{CP}^m$ family, which [L38](../findings/ungraded-slack.md#L244) names as one of the two capped families, so under the heading's own phrase "the named graded families" they are members, not witnesses. Under the *body's* narrower phrase "among the products", $\mathbb{CP}^3$ **is** a witness below at $n=6$ (§4). **The two phrasings disagree, and the block never says which family set it means.**

**"Wider" and "lower" are independent, and the record has only the first.** A graded point outside the families says nothing about the floor unless its own gap is computed. **A claim that a floor is not the set's floor needs an object below it, and the record names none.** What it does hold is [nondegeneracy.md:161](../findings/nondegeneracy.md#L161)'s measurement ($306$ of $400$ cone starts at $n=6$ reaching $61$ distinct graded critical points) which is a **search**, so the most it can support is an `Observation` about the search, not a statement about the set.

**What would settle it.** Either (a) a named graded critical point at $n=10$ or $n=12$ with smallest nonzero modulus below $\mathrm{floor}(n)$, exhibited and its gap computed, that would be a Lemma; or (b) a proof that $\mathrm{floor}(n)$ **is** the graded set's infimum, which is the form [nondegeneracy.md:172](../findings/nondegeneracy.md#L172) actually needs for closedness. Until one of the two exists, the honest statement is the one [results.md:518](../results.md#L518) very nearly makes: *the floor is a property of the named families at the dimensions stated, and the graded set's floor is unknown*.

---

## 6. Provenance, the boilerplate is false, on two counts

The note reads: *"the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block."*

- **"Numbered in report/" is true**, [report/sections/07-gradedness-split.tex:725](../report/sections/07-gradedness-split.tex#L725) carries the paragraph verbatim, and the numbering commit took it from there.
- **"Has always been in this file" is false.** [ungraded-slack.md](../findings/ungraded-slack.md) was **created** on 2026-08-31 by the split commit 7ad0455d. The mathematics entered the record on 2026-08-26 in [nondegeneracy.md](../findings/nondegeneracy.md) (6f4f2af5) and has lived there ever since, corrected. `git log -S"062994"` shows the string in this file for the first time at the split, five days after it existed elsewhere.
- **The section pointer does not resolve and names the wrong section.** The quoted anchor *"The sharp (II)-side bound is a valid inequality whose separation role "* is **truncated** (the heading ends "is dead") so it fails as a literal anchor. Read charitably as naming [ungraded-slack.md:5](../findings/ungraded-slack.md#L5), that section carries the multi-block $\theta$ closed form and the vertex solution, which are ingredients, but it contains **no gap, no ordering over factorisations, and neither of the two numbers**. The argument is in [nondegeneracy.md:186–205](../findings/nondegeneracy.md#L186), a different file, which the block never cites. *L58's pointer next door is truncated the same way ("the subalgebra family, " for "…, at every threshold") so this is a systematic defect of the numbering pass, not a one-off.*

This is the second half-false-at-birth provenance stamp the audit has found, and a harder case than the [L38](../findings/ungraded-slack.md#L244) one: there the file held one of two formulas at stamping time; here it held **neither the mathematics nor the correction**, and the stamping pass reintroduced a refuted statement.

---

## 7. Duplication, four copies, one corrected, three not

L56's content appears, near-verbatim, in four places:

| location | state |
| --- | --- |
| [nondegeneracy.md:186](../findings/nondegeneracy.md#L186) | the original, **followed immediately by its correction** at [:195](../findings/nondegeneracy.md#L195) and the closed form at [:199](../findings/nondegeneracy.md#L199) |
| [ungraded-slack.md:276](../findings/ungraded-slack.md#L276) | **uncorrected**, numbered as L56 |
| [results.md:518](../results.md#L518) | **uncorrected**, canon |
| [report/sections/07-gradedness-split.tex:725](../report/sections/07-gradedness-split.tex#L725) | **uncorrected**, and the source the numbering pass copied |

**No copy cites any other.** This is the third duplicate-statement pair the audit has found, after [L55](../findings/diagonal-half.md)/[L93](../findings/bispectral.md) and [L38](../findings/ungraded-slack.md)/[L10](../findings/graded-half.md), and the first where the duplication is *load-bearing*, because the two copies now say different things and the numbered one says the refuted thing.

---

## 8. Label, scope, and what this is for

**Clause by clause.**

| clause | verdict | label it deserves |
| --- | --- | --- |
| gap ordering over two-block factorisations at fixed $n$ | **CONFIRMED**, in closed form at every $n$ | **Lemma** |
| balanced product at the largest gap | **CONFIRMED**, proved above including the switch of minimising entry | **Lemma** |
| the floor is $0.062994$ at $S^3\times S^7$, $0.038925$ at $S^3\times S^9$ | **REFUTED**, those are the $p=3$ values; the floor is $0.031497$ and $0.020101$ at $S^2\times S^{n-2}$ | withdraw |
| named families' floor at every even $n$ | derivable, §4 | **Lemma** |
| multi-block products interleave | **true as stated for $(S^3)^4$, misleading as a general claim**, $(2,2,8)$ falls below the block's floor | **Observation**, scoped |
| "it is not the set's floor" | **GAP**, no witness on the record | withdraw, or restate as unknown |

**What this is for, plainly.** The quantity exists because [nondegeneracy.md:172](../findings/nondegeneracy.md#L172) reduced closedness of the graded critical set to a uniform lower bound on the smallest nonzero modulus, and showed no such bound can be uniform in $n$, the balanced product itself supplies a sequence $\sim\sqrt2/n\to0$. So the only usable form is per-$n$, and the value of a floor over the *named families* is that it is a **candidate** for the set's floor. **Precisely because the families do not exhaust the graded set, a floor over them certifies nothing about the set**, which is what the heading's second clause was reaching for and what nothing in the block establishes. The thing that would close it is (b) of §5: a proof that $2/((n-2)\sqrt{(n-1)(n-3)})$ bounds $\min_{\lambda\ne0}\lvert\lambda\rvert$ below over the whole graded critical set at dimension $n$, which is a statement about all graded critical points and not about any list of them.

---

## Repairs proposed

I edit nothing outside this file. The repairs, in order of cost:

1. **Withdraw the two numbers and the attainment point from [ungraded-slack.md:276](../findings/ungraded-slack.md#L276), [results.md:518](../results.md#L518) and [report/sections/07-gradedness-split.tex:725](../report/sections/07-gradedness-split.tex#L725)**, replacing them with the corrected floor already standing at [nondegeneracy.md:203](../findings/nondegeneracy.md#L203). Three copies of a refuted number is the live defect.
2. **Say what the gap is, in the block, in one clause**: the smallest nonzero modulus of the normalised $\Lambda^2$ spectrum, measured against $0$, and quote it from [conventions.md](../findings/conventions.md) rather than restating it. It belongs in the conventions table, the symbol has no entry there and three files use it.
3. **Relabel the ordering as a Lemma** on the closed form of §2, and fold §4's $\mathbb{CP}^m$ gap in, which closes [nondegeneracy.md:207](../findings/nondegeneracy.md#L207)'s open scope note and completes the named-families floor at every even $n$.
4. **Withdraw "and it is not the set's floor" from the heading** until a witness exists, and make L56 cite [nondegeneracy.md](../findings/nondegeneracy.md) as its source in place of the false provenance sentence.
5. **Repair the truncated anchors** in L56's and L58's provenance notes; both were cut mid-heading by the numbering pass.

**Computation.** Nothing here needed a run. The screening allowance was used once, for seconds, on exact rationals I constructed for the purpose: reproducing the block's three quoted numbers, the $p=2$ column, the $\mathbb{CP}^m$ column, and enumerating the partitions of $10$ and $12$ into blocks of size $\ge2$ to locate $(2,2,8)$. **That is reported as a screen. Every positive claim above is carried by the derivations in §§1–4.** No sweep, census or falsifier hunt was opened, and the block's table was not extended to further $n$ beyond what the closed forms give in one line.
