# Review 616, Lemma L95, $\kappa^2(\mathbb{CP}^m)=3/(m+1)$

Reviewer B of an independent pair on identical briefs. Derived cold from [conventions.md](../findings/conventions.md) and the Fubini–Study curvature tensor; the block's own reasoning was read only after the derivation closed. **Analysis only, no computation was run, and none is needed for anything below.**

## Verdict

**CONFIRMED, and the lemma is now actually a lemma, which it was not before this review.**

$\kappa^2(\mathbb{CP}^m)=3/(m+1)$ is **true and fully derivable**, including the global maximality over $O(2m)$ that [r101](REVIEW_r101.md) left numerical. Three of the block's four subsidiary claims are also confirmed, two of them upgraded from tables to closed forms. The defects are in **support, attribution and hedging**, not in the arithmetic:

| # | Claim | Verdict |
|---|---|---|
| 1 | $\kappa^2(\mathbb{CP}^m)=3/(m+1)$ | **CONFIRMED, and proved here in full**, r101 proved only the standard-frame value |
| 2 | $\min_F\lVert K(F)\rVert_F=0$ on padded $W_{\mathbb{CP}^2}$ | **CONFIRMED, and it is a theorem**, but the *general* form is **REFUTED**: it fails at $\mathbb{CP}^m$ for every odd $m$ |
| 3 | $(2m+1)/2$ times the generic value | **arithmetic CONFIRMED, reading REFUTED**, the denominator is a universal frame-average, not a generic $\kappa^2$ |
| 4 | $\theta(\mathbb{CP}^m)<\theta_0(2m)$ for $m\ge4$, by $25\%$ at $n=12$ | **CONFIRMED, and proved here in closed form**, the $25\%$ is $\mathbb{CP}^6$, no conflation |
| 5 | "$\mathbb{CP}^{n/2}$ is the lemma's sharpness case" | **GAP**, stated flatly; its own source calls it a conjecture, not a theorem |

---

## 1. The closed form

### 1a. The attribution, r101 does contain a derivation, of half of what the block claims

The brief's suspicion is half right and the correction cuts the other way from what it expects.

- **[r101](REVIEW_r101.md) does contain a closed-form derivation.** Its claim 3 is L95's statement verbatim, and its "Claim 3, confirmed, and now analytic on the standard frame" gives $K_{ab}=3J_{ab}^2-\frac3{2m-1}$, $\lVert K\rVert_F^2=\frac{36m(m-1)}{2m-1}$, $\lVert W\rVert^2=\frac{48m(m-1)(m+1)}{2m-1}$. All three agree **exactly** with my independent derivation below. The block's attribution is honest.
- **What the block dropped is r101's own limiting clause**, one sentence later: *"That it is the **global** maximum over $O(2m)$ remains numerical (basin-hopping, $m\le5$)."* Since $\kappa^2:=\max_Ft_F$, the standard-frame value is not the lemma. **At the moment the block was written, the `Lemma` label was premature**, what was proved was $t_{F_0}(\mathbb{CP}^m)=3/(m+1)$ at one frame, and $\kappa^2=t_{F_0}$ was numerics.
- **The block also credits the wrong number of reviewers.** [r102](REVIEW_r102.md) confirmed claim 3 independently, supplied the generic-value constant $\frac{12}{(n+1)(n+2)}$ verified to twelve digits at $n=5,\dots,12$, and is the sole source of the block's closing sharpness sentence. The block names only Reviewer 101.

**The maximality gap is closed below, so the label is now correct.** It was not correct on the evidence the block cites.

### 1b. The derivation, cold

Fubini–Study with $R=s(A+B)$, $A_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}$ and $B_{ijkl}=J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$, so $R_{ijij}=s(1+3J_{ab}^2)$ with $J$ skew orthogonal, $J^2=-I$, $n=2m$.

**The vertex matrix.** $\mathrm{Ric}(A)=(n-1)g$ and $\mathrm{Ric}(B)=3g$, so $\mathrm{Ric}(R)=s(n+2)g$ and the Ricci-flat part is $W=R-\lambda A$ with $\lambda=\frac{s(n+2)}{n-1}$. Hence, off the diagonal,

$$K(F)_{ab}=W_{abab}=3s\Big(J^F_{ab}{}^2-\tfrac1{n-1}\Big),\qquad J^F=F^{\mathsf T}JF,$$

which is [target.md](../findings/target.md) line 37's formula, reached independently.

**The frame functional.** $\sum_{a\ne b}J^F_{ab}{}^2=n$ in every frame (rows of an orthogonal matrix, zero diagonal), so the cross term is frame-free and

$$\boxed{\;t_F=\lVert K(F)\rVert_F^2=9s^2\Big(\textstyle\sum_{a\ne b}J^F_{ab}{}^4-\tfrac n{n-1}\Big).\;}$$

**The maximum, one line, and this is the piece r101 left open.** Each row of $J^F$ is a unit vector, so $\sum_b J^F_{ab}{}^4\le\big(\sum_bJ^F_{ab}{}^2\big)^2=1$, with equality iff the row has a single nonzero entry. Hence $\sum_{a\ne b}J^F_{ab}{}^4\le n$, attained at the frame $e_1,Je_1,\dots,e_m,Je_m$ where $J^F$ is the standard block form. Therefore

$$\kappa^2=\max_Ft_F=9s^2\Big(n-\tfrac n{n-1}\Big)=\frac{9s^2n(n-2)}{n-1}.$$

**The normalisation.** $\lVert A\rVert^2=2n(n-1)$, $\lVert B\rVert^2=6n(n+1)$, $\langle A,B\rangle=6n$ give $\lVert R\rVert^2=8s^2n(n+2)$ and $\langle R,A\rangle=2s\,n(n+2)$, whence

$$\lVert W\rVert^2=\frac{6s^2n(n+2)(n-2)}{n-1}.$$

[conventions.md](../findings/conventions.md) runs at $\lVert M\rVert_F=1$ with the half-trace pairing, under which $\lVert M\rVert_F^2=\tfrac14\lVert W\rVert^2$ (its own $\lvert W\rvert^2=4\lVert W\rVert_F^2$ bullet). So $s^2=\frac{2(n-1)}{3n(n+2)(n-2)}$ and

$$\kappa^2(\mathbb{CP}^m)=\frac{9\cdot2(n-1)}{3n(n+2)(n-2)}\cdot\frac{n(n-2)}{n-1}=\frac6{n+2}=\frac3{m+1}. \qquad\blacksquare$$

**Consistency.** $\kappa^2\le2\lVert M\rVert_F^2$ ([L94](../findings/bispectral.md)) reads $6/(n+2)\le2$: satisfied at every $n\ge4$, strictly, so $\mathbb{CP}^m$ is never coordinate-diagonal, as it must not be. At $m=2$, $\kappa^2=1$; at $m=6$, $3/7=0.428571$, the block's $0.4286$.

**So "to $10^{-15}$ at $m=2,\dots,7$" is now decoration.** The $10^{-15}$ was a measurement of a quantity that has a five-line proof, and the block presents the measurement first and the derivation as a parenthetical credit.

---

## 2. The withdrawn range, and what its withdrawal costs

### 2a. Why the minimum vanishes, it is a theorem, and the record already holds the reason

The same identity gives the minimum. By Cauchy–Schwarz over the $n-1$ off-diagonal entries of a row, $\sum_bJ^F_{ab}{}^4\ge\frac1{n-1}$, so $\sum_{a\ne b}J^F_{ab}{}^4\ge\frac n{n-1}$ and

$$\min_Ft_F=0\iff\text{some frame has }\lvert J^F_{ab}\rvert=\tfrac1{\sqrt{n-1}}\ \text{for all }a\ne b.$$

That is exactly [target.md](../findings/target.md) line 37's condition, and $\sqrt{n-1}\,J^F$ is then a **skew conference matrix** of order $n$. **The block's own file already settles its first bullet, 180 lines above it, and does not cite it.**

**For padded $W_{\mathbb{CP}^2}$ the answer is affirmative and exact.** A skew conference matrix of order $4$ exists, so $K$ vanishes identically in that frame at $n=4$; padding to any $n>4$ keeps it, since every entry with an index in the padded block vanishes anyway. So r101's measured $6\times10^{-12}$ (and its "$3$–$5\times10^{-4}$, still descending" at $n=6,\dots,12$) is a **theorem**, not a numerical coincidence. The brief's question is answered in the affirmative for the object the range was recorded on.

**The recorded upper end was right.** $\kappa(\mathbb{CP}^2)=\sqrt{3/(2+1)}=1$, exactly the $1.000$ of $[0.105,1.000]$. Only the lower end was the artefact, a distinction the block's blanket "was a sampling artefact" erases.

### 2b. The general claim is false, and it is false on this block's own family

$\sqrt{n-1}\,J^F$ being a skew conference matrix forces $I+\sqrt{n-1}J^F$ to be a skew-Hadamard matrix of order $n$, hence $n\equiv0\pmod4$. With $n=2m$:

> **$\min_F\lVert K(F)\rVert_F>0$ strictly at $\mathbb{CP}^m$ for every odd $m$**, $\mathbb{CP}^3$ ($n=6$) and $\mathbb{CP}^5$ ($n=10$) are witnesses.

So the block writes, inside a block whose subject is $\mathbb{CP}^m$, a structural-sounding sentence that the odd half of $\mathbb{CP}^m$ refutes. The literal wording ("for *every* tensor tested"), survives, because r101 tested padded $\mathbb{CP}^2$, sphere products and random tensors, none of them an odd-$m$ $\mathbb{CP}^m$. **The hedge is doing exactly the work the brief's checklist predicts:** it is what stands between the sentence and a counterexample, and the sentence's next clause ("the witness should be the vanishing minimum"), spends it as though it were general.

**Is the retraction on firmer ground than what it retracts?** Partly, and the block does not say which part.

- For padded $W_{\mathbb{CP}^2}$, **yes, decisively**: the retraction is now a proof, the retracted range was sampling.
- For "every tensor", **no**: descent from 25 starts to $10^{-9}$ is the same kind of evidence as sampling 400 rotations, run in the other direction. r101's dimension count ($\binom n2$ equations against $\dim O(n)=\binom n2$, with $n$ row-sum dependencies) is a heuristic, and the odd-$m$ obstruction shows the heuristic has genuine exceptions.
- **The two reviewers disagree on the provenance of the retracted range and the block records only one side.** r101: "an artifact of sampling rotations rather than minimising over them". [r102](REVIEW_r102.md) line 41: "the record's $[0.105,1.000]$ used descent and the standard frame". These are incompatible accounts of how the number was made. The block adopts r101's without noting the conflict.

### 2c. "The fixed-frame lemma", the pointer does not resolve

**There is no such numbered result on the record.** The object is r101's claim 4, the lemma $\theta\le C\lVert K(F)\rVert_F$ in a fixed frame, which was never numbered and never entered [INDEX-results.md](../findings/INDEX-results.md). The nearest same-phrase entry, **[fence post F29](../findings/INDEX-traps.md)**, is a *different* statement ($\lambda\le\mu_{\max}(K)$ in a fixed frame), with a different witness and a different scope note.

**Nothing relies on it, so nothing breaks.** The $\kappa$ route's own retirement is recorded on independent grounds (a lower bound on $\kappa$ leaves the relaxation at $4.0129$ for every $c\le3$, provably). The single downstream consumer of L95's *value* is [diagonal-half.md](../findings/diagonal-half.md) line 266, which uses $\mu_1(K)^2\le t$ with $t(\mathbb{CP}^m)=3/(m+1)$ against $\lambda^2=3/2$, and substitutes the **extremal** $\kappa^2$ where a **per-frame** $t_F$ is wanted. That is the swap [conventions.md](../findings/conventions.md) line 22 warns about, but here it is in the **safe** direction: $t_F\le\kappa^2<\lambda^2$ makes the conclusion stronger, not weaker. **That consumer is sound.**

### 2d. Residual gap, small but real

L95 is stated at $\mathbb{CP}^m$ in its own dimension $n=2m$; the record repeatedly quotes $\kappa^2$ of **padded** $\mathbb{CP}^m$ at larger $n$ (r101's and r102's frontier tables, and $\kappa^2=1$ for padded $W_{\mathbb{CP}^2}$ at $n=12$). **Padding-invariance of $\kappa$ is not implied by L95 and is not proved anywhere.** For a padded tensor the frame vectors project to a Parseval frame $\{x_a\}$ of the support ($\sum_ax_ax_a^{\mathsf T}=I_V$) rather than to an orthonormal basis, so $\max_Ft_F$ is over a strictly larger set and could in principle exceed $\kappa$. r102 reports $\kappa^2=1.0000000000$ at $40$ starts, which is strong but is numerics. **What is owed:** either a proof that the Parseval relaxation does not gain, or the word "measured" on every padded $\kappa$. Reachable, it is a statement about maximising $\sum_{a\ne b}W(x_a,x_b,x_a,x_b)^2$ over Parseval frames of a fixed $4$-dimensional support.

---

## 3. The two comparison claims

### 3a. The $(2m+1)/2$ arithmetic is exactly right, and I derived the denominator too

For fixed $a\ne b$, $J^F_{ab}=\langle Ju,v\rangle$ with $u,v$ a random orthonormal pair; $Ju$ is a unit vector in $u^\perp$ and $v$ is uniform on the sphere of $u^\perp$, so $J^F_{ab}{}^2\sim\mathrm{Beta}(\tfrac12,\tfrac{n-2}2)$, giving $\mathbb E[x]=\frac1{n-1}$ and $\mathbb E[x^2]=\frac3{n^2-1}$. Hence $\mathbb E_F\sum_{a\ne b}J^F_{ab}{}^4=\frac{3n}{n+1}$ and

$$\mathbb E_Ft_F=9s^2\Big(\tfrac{3n}{n+1}-\tfrac n{n-1}\Big)=\frac{12}{(n+1)(n+2)}\quad\text{at }\lVert M\rVert_F=1,$$

the block's stated constant, **derived rather than quoted**. The ratio follows:

$$\frac{\kappa^2(\mathbb{CP}^m)}{\mathbb E_F\lVert K(F)\rVert_F^2}=\frac{6/(n+2)}{12/((n+1)(n+2))}=\frac{n+1}2=\frac{2m+1}2,$$

and $6.5$ at $n=12$. **The arithmetic closes cleanly. So does the block's.**

### 3b. But "generic" carries two different denominators in one sentence, and the block's reading of the ratio is wrong

$\mathcal W_n$ is $O(n)$-irreducible, so an $O(n)$-invariant quadratic form on it is unique up to scale: $\mathbb E_F\lVert K(F)\rVert_F^2=\frac{12}{(n+1)(n+2)}\lVert M\rVert_F^2$ holds at **every** Weyl tensor, not at a typical one. r102 line 80 says so outright, its Monte Carlo returns $0.0657$, $0.0657$, $0.0660$ at $S^6\times S^6$, $\mathbb{CP}^6$ and a random tensor, and it calls this "the irreducibility showing up in the arithmetic". **It is a constant of the normalisation, not a property of a generic tensor, and calling it "the generic value" is a category error.**

The damage is in the sentence's own arrangement. Within one clause:

| "generic" | value at $n=12$ | what it is |
|---|---|---|
| "random Weyl tensors reach $\kappa^2\approx0.372$" | $0.372$ | a $\kappa^2$, a max over frames |
| "the generic value $\mathbb E_F\lVert K(F)\rVert_F^2$" | $0.0659$ | a **mean** over frames, identical for every tensor |

"$6.5\times$ generic at $n=12$" reads against the second and is heard against the first. **Against the first (the only comparison that could support "a *high*-spread family"), the true factor is $0.4286/0.372=1.15$.** And a random tensor's own max-to-mean ratio is $0.372/0.0659=5.64$, against $\mathbb{CP}^6$'s $6.5$: the same order. **$\mathbb{CP}^m$ is not a high-spread outlier; it is $15\%$ above typical.** The divergence of $(2m+1)/2$ measures the frame-average decaying like $12/n^2$ against $\kappa^2$ decaying like $6/n$, which is a fact about maximising over a group of growing dimension, not about $\mathbb{CP}^m$.

The defect is inherited: r102 §2 is titled "$\mathbb{CP}^m$ is a *high*-spread family" and makes the same substitution. The block compresses it and loses the one qualifier ("$\mathbb E_F$") that made it checkable.

### 3c. $0.372$, legitimate in kind, under-margined here, and the block distinguishes nothing

$3/(6+1)=0.428571$ is consistent with the closed form, and the brief is right that a sampled figure supporting a negative existence claim is a legitimate use of numerics. **The block does not distinguish the two.** It sets an exact closed form and a sampled figure side by side in one clause with no marker, and drops r101's provenance entirely: *"min over 12 samples, 20-start ascent"*.

That provenance matters more than usual here, because **r101's own claim 2, four paragraphs earlier, is the warning**: single-start ascent under-reports $\kappa^2$ by $7\%$ at $n=12$, and *"every quoted $\kappa$ should carry a start count"*. The block quotes $0.372$ with no start count, against a margin of $15\%$, the same order as the documented bias, and biased in the direction that would kill the claim. Note also that r102's independent figure for a random tensor, $\lVert K\rVert_F^2\approx0.05$, is an **identity-frame** value and does not corroborate this at all. **So "$\mathbb{CP}^m$ is not the $\kappa$-minimiser" rests on twelve samples from one reviewer with a margin the same review says the method can eat.** True, most likely; supported thinly, certainly; and presented with the same typographic weight as $3/(m+1)$.

---

## 4. The threshold claim, confirmed, and it deserves a closed form rather than a table

### 4a. Parity is safe, on two independent grounds

$\mathbb{CP}^m$ has $n=2m$ even, and [conventions.md](../findings/conventions.md) line 19 fixes $\Theta_n=\theta_0(n)$ at even $n$, so $\theta_0(2m)$ and $\Theta_{2m}$ coincide and the comparison cannot be the error that refuted the neighbouring result. Independently, [problem.md](../findings/problem.md) line 200 records that the Böhm–Wilking criterion *demands* $\theta_0(n)$ at both parities (*"$\Theta_n$ is what the diagonal locus attains, never what the criterion demands"*) so $\theta_0$ is the right constant here whatever the parity. **Confirmed twice over.**

### 4b. "For every $m\ge4$" is exactly right, and provable

Taking r101's and r102's independently derived $\theta^2(\mathbb{CP}^m)=\frac{(m+1)(2m-1)}{3m(m-1)}$ against $\theta_0(2m)^2=\frac{(2m-1)(m-1)}{m^2}$:

$$\frac{\theta^2(\mathbb{CP}^m)}{\theta_0(2m)^2}=\frac{m(m+1)}{3(m-1)^2},\qquad\text{and}\qquad \frac{m(m+1)}{3(m-1)^2}<1\iff(2m-1)(m-3)>0\iff m>3.$$

**So the threshold is crossed at exactly $m=3$, with equality there, and $\theta(\mathbb{CP}^m)<\theta_0(2m)$ for every $m\ge4$, at every $m$, not merely the six tabulated.** The $m=3$ tie ($\theta(\mathbb{CP}^3)=\theta_0(6)=1.05409$) and the $m=2$ reversal ($1.2247>0.866$) both fall out of the same factorisation. r101 reports both as table entries; neither review derives this. **This is the cheapest improvement available to the block: replace a six-column table with one factorisation.**

*(This is conditional on the $\theta^2$ closed form, which I did not re-derive from $Q(W)$. It has two independent derivations, r101's and r102's, and two exact anchors: $m=2$ gives $3/2$, matching the record's independently established $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$, and $m=3$ gives $\theta_0(6)$ on the nose.)*

### 4c. The $25\%$ is $\mathbb{CP}^6$, and there is no conflation

$\theta(\mathbb{CP}^6)=\sqrt{77/90}=0.924966$ against $\theta_0(12)=\sqrt{220}/12=1.236033$: the ratio is $0.74833$, so **$25.2\%$ below**. The figure is $\mathbb{CP}^6$ itself. **The brief's suspected conflation with padded $W_{\mathbb{CP}^2}$ is not present**, that object gives $\sqrt{3/2}/\theta_0(12)=0.99087$, the "under $1\%$" figure, which appears in r102 line 124 and nowhere in the block.

**But the block reports the wrong one of the two.** r102's near-threshold witness is the load-bearing fact of that review: padded $W_{\mathbb{CP}^2}$ at $n=12$ sits at $99.087\%$ of threshold with $\kappa^2=1.0000000000$, half the maximum, so any bound $\theta\le C_{12}\kappa$ is forced to $C_{12}\ge1.2247$ right up against threshold, and r102 concludes from this that the lead should be retired *"and it uses $\mathbb{CP}^m$ nowhere"*. **The block keeps the out-of-region argument and discards the in-region witness that made it unnecessary.** The two objects behave oppositely against the threshold, the block's first bullet is about one and its last paragraph about the other, and nothing marks the switch.

*(The out-of-region conclusion is nonetheless correct at $n\ge12$, which is Conjecture A's stated range. At $4\le n\le11$, padded $W_{\mathbb{CP}^2}$ is strictly **above** $\theta_0(n)$, [problem.md](../findings/problem.md) line 66's $n^2-12n+8<0$, so "out of the region any bound must cover" is a statement that holds only because of the dimension restriction, which the block does not mention.)*

### 4d. The sharpness sentence, GAP

> "Per $n$, $\mathbb{CP}^{n/2}$ is the lemma's **sharpness case**, ratio ascent approaches its $\theta/\kappa$ from below and never beats it."

**This is r102 §4, and r102's own caveat list, line 160, reads:** *"$C_n$ values are lower bounds from a 14-start ascent; that $\mathbb{CP}^{n/2}$ is the exact extremiser is a **conjecture** supported at $n=6,8,10$, not a theorem."* r102's body says "appears to *be* the extremiser". **The block states it flatly, drops "appears to", drops the caveat, drops the start count, drops $n\in\{6,8,10\}$, and attributes nothing**, it sits in a paragraph whose only named source is Reviewer 101, who ran a different search (maximise $\theta$ subject to $\kappa^2\le c$, not maximise $\theta/\kappa$).

**What is owed:** either the attribution and the hedge restored, or a proof that $\max_{\lVert W\rVert=1}\theta/\kappa$ is attained at $\mathbb{CP}^{n/2}$. The closed form $\theta/\kappa=\frac{(m+1)\sqrt{2m-1}}{3\sqrt{m(m-1)}}$ is exact and confirms r102's $1.27292$ and $1.34164$, so what is missing is only the extremality, which is the same shape of gap as §1a's, and which I have not closed. **Deciding it needs computation and is therefore blocked**; a ratio ascent at $n=14,16$ that beat the $\mathbb{CP}^{n/2}$ value would refute the sentence outright, and one that did not would leave it exactly where r102 left it, a conjecture at three more dimensions.

---

## 5. Bookkeeping, the Gate 2 exists and three places deny it

This is the checkable-provenance item, and it fails.

- **[INDEX-results.md](../findings/INDEX-results.md) line 110** records L95 as **"Gate 2: no verdict on the record."** Both [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md) returned **CONFIRMED** on claim 3, which is L95's statement verbatim, on identical briefs, a Gate 2 by this programme's own definition.
- **[reviews/INDEX.md](INDEX.md) lines 209–210** already say so for both reviewers: *"also confirms $\kappa^2(\mathbb{CP}^m)=3/(m+1)$"*. The information is one file away from the row that denies it.
- **[LEDGER.md](../findings/LEDGER.md) line 1325** goes further and gets it wrong on the merits: a sweep for unrecorded Gate 2s concluded that *"[L95]'s cited pair had audited [L94] and [L54]"*. **They audited L95 too, as claim 3 of five.** This is not a lag, it is a check that was performed and returned the wrong answer, which is the more expensive kind.

**The same defect, one row up, was found and recovered.** [L94](../findings/bispectral.md)'s row now reads *"the record had lost it… three indexes carried none of it"*, and [LEDGER.md](../findings/LEDGER.md) line 1297 lists it as *"a Gate 2 in two reports, against three indexes"*. **L95 is the identical case in the identical pair of reviews, and the recovery pass walked past it.** The ledger's own diagnosis (*"only the block carries the evidence"*), is exactly what happened: the sweep read the block's citation line, which names L94's reviewers, and inferred the subject from it.

## 6. Pointers

**The block contains no links at all.** Not one, across thirteen lines it names Reviewer 101, $\theta_0(2m)$, $\lVert M\rVert_F$, $\mathbb E_F\lVert K(F)\rVert_F^2$, padded $W_{\mathbb{CP}^2}$ and "the fixed-frame lemma", and resolves none of them. Every neighbouring block in [bispectral.md](../findings/bispectral.md) links its conventions and its reviewers. Concretely missing: [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md) at the attribution; [conventions.md](../findings/conventions.md) at $\theta_0$, $\Theta_n$ and the $\lVert M\rVert_F$ normalisation; [target.md](../findings/target.md) at the $K_{ab}=3s(J_{ab}^2-\frac1{n-1})$ formula that its own first bullet turns on; and a real referent for "the fixed-frame lemma", which currently has none.

---

## What the record is owed

1. **The maximality proof of §1b**, it converts L95 from a measured closed form into a lemma, in five lines, and it is the difference between the label and the evidence.
2. **The skew-conference characterisation of §2a–2b**, it makes $\min_F\lVert K(F)\rVert_F=0$ a theorem at padded $W_{\mathbb{CP}^2}$ and simultaneously bounds how far the sentence generalises. **The general form must lose "for every tensor tested" or gain "at $m$ even".**
3. **"Generic" split into its two senses** in the $(2m+1)/2$ bullet, with the frame-average named as universal and the honest factor against a random tensor's $\kappa^2$ ($1.15$) stated alongside the factor against the frame-average ($6.5$).
4. **The $m\ge4$ factorisation of §4b**, replacing the table.
5. **The sharpness sentence attributed to r102 and re-hedged**, or proved.
6. **[INDEX-results.md](../findings/INDEX-results.md) row 95 corrected to a Gate 2**, and [LEDGER.md](../findings/LEDGER.md) line 1325's conclusion about this pair withdrawn.
7. **Padded $\kappa$ marked as measured** until the Parseval-frame question of §2d is settled.

**None of the seven changes the value $3/(m+1)$, and none of them is blocked on computation except the extremality in item 5.**
