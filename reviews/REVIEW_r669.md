# Review r669, Lemma L82, the operator-norm lever

**Reviewer A of a pair on identical briefs; the other took r670. Derived cold from the definitions. Analysis only, no computation was run; every number below is arithmetic on spectra this record already tables.**

Target: [findings/isotropy-cap.md:372–380](../findings/isotropy-cap.md#L372), the block headed *Lemma L82, the operator-norm lever $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2\ge1$ for two negative eigenvalues*.

## Verdict

**GAP**, the numbered inequality is TRUE and I re-derive it below; but one clause of the block, *"with equality at the $m=6$ witness"*, is **REFUTED**, twice, from this file's own contents; the equality $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2$ is **asserted, not derived**, though it is proved elsewhere on the record as [Lemma L31](../findings/stratum-two-negative.md#L267) and is not cited; and two hypotheses the argument consumes, trace-freeness and the *most negative* ordering, are never stated.

[INDEX-results.md:97](../findings/INDEX-results.md#L97) records *"Gate 2: no verdict on the record"* for result 82, so this is a first verdict.

## My reading of the symbols, and what [conventions.md](../findings/conventions.md) does not carry

| symbol | my reading | status in [conventions.md](../findings/conventions.md) |
| --- | --- | --- |
| $\lambda_N$ | the most negative eigenvalue of $W$ acting on $\Lambda^2\mathbb R^m$, in the ordering $\lambda_1\ge\dots\ge\lambda_N$ | **absent.** $N$ is tabled as the *dimension* $\binom n2$, never as an eigenvalue index. The ordering is inferred from [Lemma L29](../findings/stratum-two-negative.md#L69), which writes the two negatives as $\lambda_{N-1},\lambda_N$ |
| $v_N$ | the unit eigenvector of $\lambda_N$, one member of an orthonormal eigenbasis $\{v_\alpha\}$ of $\Lambda^2\mathbb R^m\cong\mathfrak{so}(m)$ | **absent** |
| $s_1\ge s_2$ | the two largest *pair* singular values (angles) of the skew matrix $v_N$: $v_N\simeq\bigoplus_j s_jJ$ in a canonical frame, with $s_j=0$ padding when the rank is short | **present but under-specified**, at [conventions.md:53](../findings/conventions.md#L53). *"$\sum_i s_i^2=1$"* does not say whether $i$ runs over pairs or over all $2p$ singular values. **The pairs reading is forced** by the same bullet's $\mathop{\mathrm{tr}}(v^2)=-2$; under the other reading $\sum_j s_j^2=\tfrac12$, $s_1+s_2\le1$, and L82 would collapse into a rigidity statement rather than an inequality, see D5 |
| $T_+$ | $\sum_{\lambda>0}\lambda$, the positive trace mass | **absent**, and it **collides**: [conventions.md](../findings/conventions.md) fixes $T_{abc}=c_{abc}^2$ as the bracket tensor, which is the $T$ of [L29](../findings/stratum-two-negative.md#L69), [L31](../findings/stratum-two-negative.md#L267) and [L35](../findings/stratum-two-negative.md#L443), the neighbouring lemmas on the same stratum, where $T_{1,N-1,N}$ is a scalar. A reader arriving from L29 reads $T_+$ as a bracket entry |
| $\lVert\cdot\rVert_{\rm op}$ | operator norm of $\mathrm{ad}(v_N)$ on $\mathfrak{so}(m)$, not of $v_N$ on $\mathbb R^m$ | inferred; on $\mathbb R^m$ the answer would be $s_1$, not $s_1+s_2$ |

Also unstated: the block writes $m$ for the ambient dimension where the rest of the record writes $n$, and it writes $\dim\mathfrak m\le2$ two lines later, so $m$ and $\mathfrak m$ appear in adjacent sentences meaning a dimension and a subspace.

## 1. The contraction bound, CONFIRMED, and it holds far more widely than the heading claims

The identity is the one this same file states at [:266](../findings/isotropy-cap.md#L266) and [stratum-two-negative.md:137](../findings/stratum-two-negative.md#L137):

$$\sum_\alpha\lambda_\alpha N_{v_\alpha}=0,\qquad N_v:=2\,v\otimes v-\mathrm{ad}(v)^2,\qquad \langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2 .$$

Contract at $u=v_N$. Orthonormality of the eigenbasis gives $\langle v_\alpha,v_N\rangle=\delta_{\alpha N}$, so

$$2\lambda_N+\sum_\alpha\lambda_\alpha\lVert[v_\alpha,v_N]\rVert^2=0 .$$

The $\alpha=N$ bracket term is zero because $[v_N,v_N]=0$. Dropping the remaining negative terms, which enter with the sign that helps,

$$\sum_{\lambda_\alpha>0}\lambda_\alpha\lVert[v_\alpha,v_N]\rVert^2\ \ge\ 2\lvert\lambda_N\rvert,$$

and $\lVert[v_\alpha,v_N]\rVert\le\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}\lVert v_\alpha\rVert=\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}$ gives

$$\boxed{\ \lVert\mathrm{ad}_{v_N}\rVert_{\rm op}^2\ \ge\ 2\lvert\lambda_N\rvert/T_+\ }$$

**The hypotheses actually consumed, against the four the brief names.**

- **First Bianchi**, load-bearing, it is what produces the identity. **Ricci-flatness**, used only to delete the $\mathop{\mathrm{tr}}(u^2v_\alpha^2)$ terms. Both hold for $W\in\mathrm{Weyl}_m$. Neither appears in the L82 block or its heading.
- **Unit norm of the eigenvectors**, used twice, once for $\langle v_\alpha,v_N\rangle=\delta_{\alpha N}$ and once in the operator-norm step. Not stated.
- **Criticality is never used.** $Q(W)=\theta W$ enters nowhere; the lemma is a statement about every $W\in\mathrm{Weyl}_m$ with a negative eigenvalue, critical or not.
- **Trace-freeness is not used here**, it enters at step 2 only, and there it is indispensable. See D2.

**D1, "the most negative eigenvector" is not needed for this bound, and "kills" is the wrong verb.** Nothing above uses $\lambda_N$ being the *most* negative; $\lambda_N<0$ is the whole hypothesis, so $\lVert\mathrm{ad}_{v}\rVert_{\rm op}^2\ge2\lvert\lambda\rvert/T_+$ holds at **every** negative eigenvector, and the most negative one is chosen because it makes the bound strongest, not because it makes it true. (The most-negative choice does real work at step 2, just not here.) And the negative terms are not *killed*: only the single diagonal term $[v_N,v_N]=0$ vanishes structurally. The other negative eigenvalue's bracket term is generally nonzero and is **discarded on sign**, which is a different and weaker thing. It happens to vanish at the $m=8$ witness, where the two 4-planes are orthogonal, which is probably why the wrong verb survived.

## 2. The two-negative step, CONFIRMED, with two hypotheses the block does not state, and "at most two" suffices

As written, *"With exactly two negative eigenvalues $T_+\le2\lvert\lambda_N\rvert$"* is a non-sequitur. Two facts are silently used:

1. **Trace-freeness**, $\mathop{\mathrm{tr}}_{\Lambda^2}W=\sum_\alpha\lambda_\alpha=0$, hence $T_+=T_-=\sum_{\lambda<0}\lvert\lambda\rvert$. A Weyl tensor is totally trace-free so its $\Lambda^2$ trace is $\tfrac12\mathrm{scal}=0$; both tabled witnesses at [:350–:352](../findings/isotropy-cap.md#L351) have spectra summing to zero.
2. **$\lambda_N$ is the most negative**, hence $\lvert\lambda_{N-1}\rvert\le\lvert\lambda_N\rvert$ and $T_-\le2\lvert\lambda_N\rvert$.

**D2, the general form is free and the block states the $d=2$ specialisation.** With $d$ negative eigenvalues counted with multiplicity, the same two lines give $T_+=T_-\le d\lvert\lambda_N\rvert$ and therefore

$$\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}^2\ \ge\ 2/d .$$

So **"at most two" suffices** (at $d=1$ the conclusion is stronger, not absent) and the "exactly two" of the heading is the same over-narrow hypothesis the brief notes for [L35](../findings/stratum-two-negative.md#L443) (stated for *at most* two) and [L29](../findings/stratum-two-negative.md#L69) (one-and-two). The record already carries the subsumption; L82 does not use it.

**D3, the $d=1$ case is a two-line reproof of [Lemma L33](../findings/stratum-two-negative.md#L119), by a route L33 does not use, and the block does not notice.** At $d=1$ the display gives $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}^2\ge2$, while $s_1+s_2\le\sqrt2$ always. The two together force $s_1+s_2=\sqrt2$, hence $s_1=s_2=1/\sqrt2$ with every other $s_j=0$: **$v_N$ is a multiple of a rank-4 complex structure**, which is exactly L33's exception clause. The argument is symmetric in the sign, so contracting at the lone *positive* eigenvector gives the other half. L33's own proof runs on kernel containment and [Lemma L32](../findings/isotropy-cap.md#L74); this is a genuinely independent route to the same statement, and it is sitting unclaimed inside L82.

## 3. $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2$, TRUE, but ASSERTED here and PROVED elsewhere, uncited

The equality is correct. Under the identification $\mathfrak{so}(m)\cong\Lambda^2\mathbb R^m$, $\mathrm{ad}(v)$ is the derivation extension of $v$, so its eigenvalues on $\Lambda^2\mathbb C^m$ are the pairwise sums $\mu_a+\mu_b$ of $v$'s eigenvalues $\{\pm is_j\}\cup\{0\}$. The largest modulus among $\lvert is_a+is_b\rvert=s_a+s_b$, $\lvert is_a-is_b\rvert=s_a-s_b$ and $s_a$ is $s_1+s_2$. $\mathrm{ad}(v)$ is skew-adjoint for the ad-invariant pairing, hence normal, hence its operator norm is that maximum. Then $s_1+s_2\le\sqrt{2(s_1^2+s_2^2)}\le\sqrt2$, with equality iff $s_1=s_2=1/\sqrt2$ and the rest vanish (rank exactly 4) which is the block's own next sentence, and it is right.

**D4, the block derives none of this, and the record already proves it forty lines away in a sibling file.** [stratum-two-negative.md:267](../findings/stratum-two-negative.md#L267) states $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$ **exactly**, with the root-system argument and the Cauchy–Schwarz equality case; that *is* [Lemma L31](../findings/stratum-two-negative.md#L267), it is audited ([r543](REVIEW_r543.md), [r544](REVIEW_r544.md)), and it is the whole of L82's equality. L82 cites nothing at all, the block contains **zero markdown links**, including the bare-text "Lemma L29" at [:380](../findings/isotropy-cap.md#L380), which lives in another file. So an equality the record can cite is presented as an assertion a reader must take on trust.

**D5, the half-trace pairing is load-bearing here and the block never names it.** Under [conventions.md:53](../findings/conventions.md#L53)'s $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$, a unit $v_N$ has $\sum_js_j^2=1$ and $s_1+s_2\le\sqrt2$, so "$\ge1$" is a genuine inequality with room in it. **Under plain Frobenius $\sum_js_j^2=\tfrac12$ and $s_1+s_2\le1$**, so the identical sentence would assert $s_1+s_2=1$ (a rigidity claim forcing every $v_N$ to be rank-4) and would contradict the block's own $\le\sqrt2$. The constant $2$ in $\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$ carries the same dependence. This is the defect [r471](REVIEW_r471.md) recorded against [L79](../findings/isotropy-cap.md#L270) in this same file and which the record notes was not applied; L82 has it too.

## 4. The equality clause, REFUTED, twice, from this file alone

The block claims $s_1+s_2\ge1$ holds **"with equality at the $m=6$ witness"**.

**Refutation 1, L82's own first inequality, on the spectrum this file tables.** [isotropy-cap.md:351](../findings/isotropy-cap.md#L351) gives the $m=6$ witness spectrum as $(-3,-1,1,1,1,1)/\sqrt{14}$. Then $\lvert\lambda_N\rvert=3/\sqrt{14}$ and $T_+=4/\sqrt{14}$, so

$$\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}^2\ \ge\ \frac{2\cdot3}{4}\ =\ \frac32,\qquad s_1+s_2\ \ge\ \sqrt{3/2}\ =\ 1.2247\ldots\ >\ 1 .$$

The block's own step 1, applied to the block's own witness, already excludes equality. (Note also that step 2 is slack there: $T_+\le2\lvert\lambda_N\rvert$ reads $4\le6$, since $-3\ne-1$.)

**Refutation 2, the paragraph two blocks above says $s_1+s_2=\sqrt2$ at that witness.** [isotropy-cap.md:370](../findings/isotropy-cap.md#L370) records that the feasible class at $m=6$ and $m=8$ alike is *"$(4,4)$ with **equal** singular values, two rank-4 complex structures"*. A unit rank-4 element with equal singular values has $s_1=s_2=1/\sqrt2$, so $s_1+s_2=\sqrt2$: the **opposite end** of the range $[1,\sqrt2]$, not the equality point.

**And the $m=8$ witness fails it too, by hand and exactly.** Take the orthogonal-plane witness of [:352](../findings/isotropy-cap.md#L352), spectrum $\{-1/\sqrt3^{\times2},\,1/(2\sqrt3)^{\times4}\}$, built as two padded $W_4(q,q)$ with $q=1/(2\sqrt3)$ on orthogonal 4-planes $A,B$. Then $v_N=w_1$ is a unit self-dual form on $A$, i.e. $\tfrac1{\sqrt2}J_1$ for a quaternionic triple, and the self-dual algebra gives $[w_1,w_2]=\sqrt2\,w_3$, so $\lVert[w_1,w_2]\rVert^2=\lVert[w_1,w_3]\rVert^2=2$ while $w_1$ commutes with everything supported on $B$ and with the anti-self-dual forms. The contraction identity checks exactly:

$$\sum_\alpha\lambda_\alpha\lVert[v_\alpha,v_N]\rVert^2=q\cdot2+q\cdot2=4q=2\lvert\lambda_N\rvert\ \checkmark$$

Here $2\lvert\lambda_N\rvert/T_+=1$ exactly, so step 2 *is* tight at $m=8$, but $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}^2=(\sqrt2)^2=2$, a factor 2 above the bound, because two of the four positive eigenvectors live on the orthogonal plane $B$ and **commute** with $v_N$, so the operator-norm step is strictly lossy. So the tight step-2 witness is $m=8$, not $m=6$; and even there the conclusion is slack. **Under no reading of "equality" is the $m=6$ witness the equality case.**

**Suggested repair:** delete the clause. Replacing it with *"with equality at the $m=8$ witness"* would be true of step 2 alone and still false of the conclusion.

## 5. Sharpness, and what the lever actually buys

**Is $\ge1$ sharp?** No equality case is on the record, and the chain has three inequalities that must saturate together: the discarded negative bracket term must vanish; **every** positive eigenvector must be a top singular vector of $\mathrm{ad}(v_N)$; and the two negative eigenvalues must be equal. The second fails at $m=8$ and the third fails at $m=6$. Worse, saturation forces $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=1$, i.e. $s_1+s_2=1$, which puts $v_N$ **away** from the rank-4 shape both recorded witnesses have. Whether any $W\in\mathrm{Weyl}_m$ attains it is open, and settling it needs a construction, not a run.

**What it buys.** $s_1+s_2\ge1$ gives $s_1^2+s_2^2\ge\tfrac12(s_1+s_2)^2\ge\tfrac12$, so the block's gloss (*"at least half the norm of the most negative eigenvector sits inside a single 4-plane"*), is the correct reading. That is the whole content.

**What remains owed, and it is more than the block says.** The bound places **no constraint on $\dim U$**: $v_N$ may keep $s_3,s_4,\dots>0$ and $W$ may have full support at every $m$, so **the lever closes nothing**. The block is honest about this in its last sentence, only $s_1+s_2=\sqrt2$ would close $m\ge10$, by forcing both negative eigenvectors into 4-planes whose union spans at most 8 dimensions. But the heading above it, *"The lever for closing it"* at [:374](../findings/isotropy-cap.md#L374), oversells an inequality that closes nothing.

**D6, "What B0 now owes" is stale in its first item.** [:380](../findings/isotropy-cap.md#L380) owes *"$\sup\theta$ over $\dim\mathfrak m\le2$ with any number of positive eigenvalues, Lemma L29 covers rank 3 only, which closes B0 without any descent"*. That is verbatim the statement of [Lemma L35](../findings/stratum-two-negative.md#L443), *at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$, unconditionally*, *"at any number of positive ones, at any $m$"*, which is on the record, in [results.md:156](../results.md#L156), and marked closed. The $\theta\le\mathrm{LP}\le G\le\sqrt{3/2}$ chain that proves it **was re-filed out of this very file** on 2026-09-02 ([stratum-two-negative.md:521–523](../findings/stratum-two-negative.md#L521)), and the move left the debt statement behind. Two caveats survive on L35 and should be what the block owes instead: its one-negative case is *"owed a line"*, and its residual interval closes by 200-bit interval arithmetic rather than by hand. The second item (the sharpening to $\sqrt2$), is genuinely open and correctly stated.

## Provenance

`git log -S 'operator-norm lever' -- findings/isotropy-cap.md` returns exactly **5b258c14, `docs(isotropy-cap): place headings for Lemmas 75-82`**, the same bulk retrofit that produced the four defective headings the brief names, [L75](../findings/isotropy-cap.md#L197), [L76](../findings/isotropy-cap.md#L232), [L77](../findings/isotropy-cap.md#L112) and [L78](../findings/isotropy-cap.md#L155). `git log -S 'kills the negative terms'` returns **62ccb443** and the later split **51ab61f8**, so the body predates the heading.

**The retrofit here removed nothing**, the diff shows one inserted line above the pre-existing `#### The lever for closing it`. **The defect is a different one from L75–L78's**: the heading did not lose a hypothesis that was there, it **failed to add the hypotheses that were already missing from the prose** ($W\in\mathrm{Weyl}_m$, unit norm, trace-freeness, and the most-negative ordering) while promoting the prose to a numbered, citable Lemma. A statement a reader may now cite by number carries fewer hypotheses than the argument needs.

## Duplication

**One verbatim unnumbered twin, and it carries the same false clause.** [ATTEMPTS.md:2108–2109](../ATTEMPTS.md#L2108), *"The lever the review left behind"*, is the same three sentences word for word, ending *"with equality at the $m=6$ witness"*. This is the brief's third kind (a verbatim unnumbered twin), with the twist that **neither copy has been corrected**, so a repair to [isotropy-cap.md:376](../findings/isotropy-cap.md#L376) must reach ATTEMPTS.md too. The twin also drops the $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2$ equality entirely, writing only *"hence $s_1+s_2\ge1$"*, so the numbered form and the twin are not the same statement.

Nothing in [results.md](../results.md) carries L82; [INDEX-results.md:97](../findings/INDEX-results.md#L97) is the only index line. The *content* $\lVert\mathrm{ad}_X\rVert_{\rm op}=s_1+s_2$ appears in three further places, [stratum-two-negative.md:267](../findings/stratum-two-negative.md#L267), [:412](../findings/stratum-two-negative.md#L412), [results.md:148](../results.md#L148), all as [Lemma L31](../findings/stratum-two-negative.md#L267), all correct, and **none of them connected to L82**.

## Pointers

The L82 block contains **no links at all**, so nothing in it is dead and nothing in it resolves either; its one cross-file reference, *"Lemma L29"* at [:380](../findings/isotropy-cap.md#L380), is bare text for a lemma in [stratum-two-negative.md](../findings/stratum-two-negative.md#L69). The file's empty `(#)` target is at [:396](../findings/isotropy-cap.md#L396), in [L131](../findings/isotropy-cap.md#L382), pointing at Lemma L36, outside this block, and reported for completeness.

## Screen

**None run.** Every number above is arithmetic on spectra already tabled in [findings/isotropy-cap.md](../findings/isotropy-cap.md#L351) or hand computation in the quaternionic algebra. Nothing here rests on a computation, and nothing here needed one.

## Summary of defects

| # | where | defect |
| --- | --- | --- |
| **D0** | [:376](../findings/isotropy-cap.md#L376) | **REFUTED clause**, *"with equality at the $m=6$ witness"* is false; the block's own step 1 on the file's own tabled spectrum gives $\ge\sqrt{3/2}>1$, and [:370](../findings/isotropy-cap.md#L370) says the witness has $s_1+s_2=\sqrt2$. Same error in the [ATTEMPTS.md](../ATTEMPTS.md#L2108) twin |
| **D1** | [:376](../findings/isotropy-cap.md#L376) | *"most negative"* is unnecessary for step 1, every negative eigenvector works; and *"kills the negative terms"* should read *discards them on sign* |
| **D2** | [:372](../findings/isotropy-cap.md#L372) | *"exactly two"* is over-narrow; the free general form is $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}^2\ge2/d$, so *at most two* suffices |
| **D3** | [:376](../findings/isotropy-cap.md#L376) | the $d=1$ case is an unclaimed two-line reproof of [L33](../findings/stratum-two-negative.md#L119) by an independent route |
| **D4** | [:376](../findings/isotropy-cap.md#L376) | the equality $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2$ is **asserted**; it is [L31](../findings/stratum-two-negative.md#L267), proved and audited, and uncited |
| **D5** | [:376](../findings/isotropy-cap.md#L376) | the half-trace pairing is load-bearing and unnamed; under plain Frobenius the same words are a rigidity claim contradicting the block's own $\le\sqrt2$ |
| **D6** | [:378–:380](../findings/isotropy-cap.md#L378) | *"What B0 now owes"* item 1 **is** [L35](../findings/stratum-two-negative.md#L443), on the record and closed; the chain proving it was re-filed out of this file and the debt statement stayed |
| **D7** | [:372](../findings/isotropy-cap.md#L372), [:374](../findings/isotropy-cap.md#L374) | heading omits every hypothesis ($\mathrm{Weyl}_m$, unit norm, trace-free, most-negative), and *"The lever for closing it"* oversells an inequality that closes nothing |
| **D8** | [conventions.md](../findings/conventions.md#L53) | $T_+$, $v_N$ and the eigenvalue index $N$ are absent from the conventions file; $T_+$ collides with the bracket tensor $T$ of the neighbouring lemmas; $s_i$'s index range at [:53](../findings/conventions.md#L53) is ambiguous |

**What the record may cite.** For every $W\in\mathrm{Weyl}_m$ of unit norm with $d\ge1$ negative eigenvalues counted with multiplicity, in the half-trace pairing, $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2\ge\sqrt{2/d}$, where $v_N$ is the most negative eigenvector. At $d\le2$ this is $\ge1$; at $d=1$ it forces $v_N$ to be a rank-4 complex structure. It is an **equality** in $s_1+s_2$ and an **inequality** in the bound, and no equality case for the bound is known.
