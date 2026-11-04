# Review r595, Lemma L13 (spectral-moment method)

Reviewer r595, independent adversarial audit. Target: Lemma L13 at [findings/curvature-invariants.md](../findings/curvature-invariants.md), lines 48–52, with its statement copy at [results.md](../results.md) lines 536–540 and its glance line at [results.md](../results.md) line 186. Worked from [findings/conventions.md](../findings/conventions.md) and the definitions alone; the record is not assumed correct. The concurrent reviewer on this brief (r596) was not read, nor their log.

Standing rule for this audit: **analysis only**. No sweep, census, optimisation or falsifier hunt was run. One screen appears below, a few seconds of arithmetic on closed forms already in the block, run to check a discrepancy I was about to record. It is reported as a screen and never as evidence for a positive claim. Every positive claim below is a derivation.

## Verdict

**REFUTED as stated.** The block's headline sentence (*"spectral moments of $L_u$ are the wrong invariants for this problem"*), is false in the only precise reading available, and its quoted margin is false against its own displayed inequality. A weaker statement survives, at every $n$, and the surviving statement is a `Lemma` only if one closed form the record has never derived is granted.

| item | verdict |
| --- | --- |
| **D1** the block as *"canonical statement and proof"* | **REFUTED as a record entry.** The block is a byte-identical copy of [results.md](../results.md) line 538. It contains no derivation of any of its four ingredients. §1 |
| **D2** the provenance note, *"where the argument was the only copy … that file now carries the statement and points here"* | **FALSE IN BOTH CLAUSES.** [ATTEMPTS.md](../ATTEMPTS.md) held the entire derivation at the migration's parent commit, and [results.md](../results.md) carries the whole paragraph, not a statement. §1 |
| **D3** the chain $\lambda^2(1+\tfrac{k_0}4)\le\tfrac{(n-1)(2n-1)}4$ from criticality | **CONFIRMED at every $n$**, rebuilt in §2 in five lines from criticality and $O(n)$-invariance alone. The block's *"from criticality alone"* is exact |
| **D4** the ceiling $\lambda\le2-o(1)$ | **CONFIRMED, conditional on $\kappa_n$.** $\lambda^2\le\frac{2(n-1)(2n-1)}{8+n(n-1)}\to4$. The limit $2$ depends entirely on the *value* of $\kappa_n$, which the record fits rather than derives. §4 |
| **D5** *"an excess of $49.7\times$ at $n=12$"* | **REFUTED.** The block's own inequality gives $58.9\times$. The $1.7974$ behind $49.7$ requires an orbit of dimension $74.3$ inside a $66$-dimensional group. §3 |
| **D6** *"spectral moments of $L_u$ are the wrong invariants for this problem"* | **REFUTED as stated.** $\theta=\lambda_{\max}(L_u)$ at any local maximum, so the moment sequence of $L_u$ determines $\theta$ **exactly**. §5 |
| **D7** the label `Lemma` | **MISLABELLED.** The load-bearing constant $\kappa_n$ is on the record only as a fit at $n\in\{5,6,8,9,10\}$ and the margin table only at $n=12,14,20,100$. §4, §6 |
| **D8** *"a Peirce cap at $\lambda/2$ on $u^\perp$"* | **HYPOTHESIS DROPPED.** The cap on all of $u^\perp$ needs local maximality; only the *equality on the orbit tangent* follows from criticality, and only that is used. §2 |
| **D9** symbols $B$, $\lambda$, $u$, $k_0$ | **THREE LIVE COLLISIONS**, one of them a letter [conventions.md](../findings/conventions.md) already flags as ambiguous. §7 |

---

## 1. The proof is absent, and the provenance note is false in both clauses

**The block and the statement are the same bytes.** [findings/curvature-invariants.md](../findings/curvature-invariants.md) line 52 and [results.md](../results.md) line 538 differ in nothing; `diff` on the two lines is empty. So [results.md](../results.md) does not "carry the statement and point here", it carries the whole paragraph, and the pointer leads to a copy of itself.

**What the block asserts, and what it derives.** Four ingredients are named and none is argued:

| ingredient | status in the block |
| --- | --- |
| $\mathop{\mathrm{tr}}(L_W)=0$ | asserted |
| $\mathop{\mathrm{tr}}(L_W^2)=\tfrac{(n-1)(2n-1)}4\lVert W\rVert^2$ | asserted |
| the cap attained on a subspace of dimension $\dim(O(n)\cdot u)$ | asserted |
| *"together yielding"* $\lambda^2(1+\tfrac{k_0}4)\le\tfrac{(n-1)(2n-1)}4$ | the combining step is the word *"together"* |

$B$, $u$, $\lambda$ and $k_0$ are never defined in the block, and $k_0$ appears for the first time inside the displayed inequality.

**Where the argument is.** [ATTEMPTS.md](../ATTEMPTS.md) lines 636–676, *"Spectral trace method at idempotents"*, holds all of it: the setup, the trace identities with their provenance, the cap lemma with its one-line proof, the Cauchy–Schwarz step, the kill-criterion table and the diagnosis. The block does not cite it. `git show a9e4b8c0^:ATTEMPTS.md` confirms that section was present at the parent of the migration commit, so the note's first clause (*"where the argument was the only copy"*), is false: [results.md](../results.md) held a summary while [ATTEMPTS.md](../ATTEMPTS.md) held the derivation, in a strictly stronger form.

**This is the pattern the record has already named.** [LEDGER.md](../findings/LEDGER.md) line 1674 records that the stamp is *"one sentence pasted $42$ times"*, that [r586](REVIEW_r586.md) found the same shape at L12, derivation in [ATTEMPTS.md](../ATTEMPTS.md), stamp false in both clauses, and that **the record bars [ATTEMPTS.md](../ATTEMPTS.md) from carrying a numbered result's proof**. L13 is the same case, and the same repair applies: transcribe, do not strike.

The commit that made this is `a9e4b8c0`, *"the proofs move to findings, results.md states and points"*, whose own message claims sentence-level verification that nothing was lost. Nothing was lost; nothing was moved either. `git show a9e4b8c0 -- findings/bounds.md` shows the identical paragraph *added* to [findings/bounds.md](../findings/bounds.md) while [results.md](../results.md) kept its own, and `2d66938e` later carried that copy into this file.

**Where L13 now sits.** [findings/curvature-invariants.md](../findings/curvature-invariants.md) line 3 declares the file's subject to be $\theta$ through *sectional-curvature* moments and the second-kind operator. L13 is about spectral moments of the multiplication operator on $\mathcal W_n$, a different object, sharing only the word "moment". Nothing above or below it in the file bears on it, and nothing in the file supplies the missing steps.

## 2. The chain, rebuilt, CONFIRMED, and tighter than the block states its hypothesis

Take $W$ critical of unit norm, so $Q(W)=\theta W$. With $B(X,Y)=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, the $\circ$ product of [conventions.md](../findings/conventions.md), bilinearity gives $B(W,W)=Q(W)$, hence $L_W W=\theta W$ and the block's $\lambda$ is the record's $\theta$.

**Step 1, the orbit-tangent equality, from criticality alone.** Write $T(x,y,z)=\langle B(x,y),z\rangle$, symmetric, with $P(x)=T(x,x,x)$. Let $u(t)=\exp(t\,\mathrm{ad}A)\cdot W$; the action is by isometries and $P$ is $O(n)$-invariant, so $P(u(t))$ and $\lVert u(t)\rVert$ are both constant. Differentiating twice at $t=0$, with $H=u'(0)$:

$$0=\tfrac{d^2}{dt^2}P(u(t))\big\rvert_0=6\,T(W,H,H)+3\,T(W,W,u''),\qquad 0=\tfrac{d^2}{dt^2}\lVert u\rVert^2\big\rvert_0=2\lVert H\rVert^2+2\langle W,u''\rangle .$$

Now $T(W,W,u'')=\langle Q(W),u''\rangle=\theta\langle W,u''\rangle=-\theta\lVert H\rVert^2$, so

$$\boxed{\ \langle L_WH,H\rangle=\tfrac\theta2\lVert H\rVert^2\ }\qquad\text{for every orbit tangent }H .$$

Also $\langle H,W\rangle=0$, so the orbit tangent space $\mathcal T$, of dimension $k_0=\dim(O(n)\cdot W)$, sits inside $W^\perp$.

**Step 2, the trace bound.** $L_W$ is self-adjoint, so $L_W^2\succeq0$. In an orthonormal basis adapted to $\mathbb RW\oplus\mathcal T\oplus(\cdot)$,

$$\mathop{\mathrm{tr}}(L_W^2)\ \ge\ \lVert L_WW\rVert^2+\mathop{\mathrm{tr}}(\Pi_{\mathcal T}L_W^2\Pi_{\mathcal T})\ \ge\ \theta^2+\frac{\big(\mathop{\mathrm{tr}}\Pi_{\mathcal T}L_W\Pi_{\mathcal T}\big)^2}{k_0}=\theta^2+\frac{(\theta k_0/2)^2}{k_0}=\theta^2\Big(1+\frac{k_0}4\Big),$$

the middle step being $\Pi L_W^2\Pi\succeq(\Pi L_W\Pi)^2$ followed by Cauchy–Schwarz on the $k_0$ diagonal entries, each equal to $\theta/2$ by Step 1. With $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n$ at $\lVert W\rVert=1$ this is the block's display. **CONFIRMED**, at every $n$, and the block's *"from criticality alone"* is exactly right.

**One misstatement that the chain survives.** The block writes *"a Peirce cap at $\lambda/2$ on $u^\perp$ attained on a subspace of dimension exactly $\dim(O(n)\cdot u)$"*, as though the cap $\langle L_uH,H\rangle\le\theta/2$ held on all of $u^\perp$ under the same hypothesis. It does not: the cap is the second-variation condition at a **local maximum** ([ATTEMPTS.md](../ATTEMPTS.md) line 639 states the hypothesis; the block drops it), while the *equality* on $\mathcal T$ needs only criticality. Since the chain uses only the equality, no step breaks, but the sentence as written asserts a local-maximum consequence under a criticality hypothesis, and the two are used in opposite directions elsewhere in this record.

**Convention covariance, checked because [conventions.md](../findings/conventions.md) warns about it.** Under $\langle\cdot,\cdot\rangle\mapsto c\langle\cdot,\cdot\rangle$ the unit $W$ rescales by $c^{-1/2}$, so $\theta\mapsto c^{-1/2}\theta$ and $\kappa_n\mapsto c^{-1}\kappa_n$. Both sides of the display scale identically, so the half-trace/Frobenius trap does **not** bite here, *provided $\kappa_n$ and $\theta_0(n)$ were computed in the same pairing*. The block names no pairing, and the record cannot settle it without recomputation. A $\sqrt2$ mismatch would move the ceiling to $2.83$ or to $1.41$; the latter sits **below** $\lim\theta_0=\sqrt2$ and would appear to prove Conjecture A, which [ATTEMPTS.md](../ATTEMPTS.md) itself names as an error signal. The recorded ceiling of $2$ passes that filter, which is weak evidence the two are in the same pairing.

## 3. The margin $49.7\times$ is REFUTED by the block's own inequality

The block's display, with the block's own $k_0\le\binom n2$, gives

$$\theta^2\ \le\ \frac{(n-1)(2n-1)/4}{1+\tfrac18n(n-1)}=\frac{2(n-1)(2n-1)}{8+n(n-1)} .$$

At $n=12$: $\kappa_{12}=\tfrac{11\cdot23}4=63.25$, $k_0\le\binom{12}2=66$, so $\theta^2\le63.25/17.5=3.61429$ and $\theta\le1.90113$. Against $\theta_0(12)=1.236033$ and $\mathrm{gap}^*=\theta_0(12)-\sqrt{3/2}=0.0112884$, the excess is

$$\frac{1.90113-1.236033}{0.0112884}=58.92 .$$

*Screen (arithmetic on the block's closed forms, seconds, no search):* the same computation at $n=14,20,100$ gives $1.92217,\ 1.95438,\ 1.99419$ and excesses $17.88,\ 7.80,\ 3.57$, against the $15.4,\ 7.0,\ 3.4$ carried in [ATTEMPTS.md](../ATTEMPTS.md)'s table. The asymptotic row alone agrees: the chain's limit is exactly $2$ and $(2-\sqrt2)/(\sqrt2-\sqrt{3/2})=3.0917$, matching the recorded $3.09$.

**The recorded number is not merely different, it is unreachable.** $49.7$ is generated by a *"best bound"* of $1.7974$, and

$$1+\frac{k_0}4=\frac{63.25}{1.7974^2}=19.578\quad\Longrightarrow\quad k_0=74.31 ,$$

which exceeds $\dim\mathfrak{so}(12)=66$. **No orbit in $O(12)$ has that dimension**, so no choice of critical point reproduces $1.7974$ from the displayed chain. Either an ingredient outside the block was used and never recorded, or the column is wrong. Adding the remaining constraints the record does state, $\mathop{\mathrm{tr}}(L_W)=0$ with the residual spectrum spread over $\dim\mathcal W_{12}-1-k_0=1571$ directions, pushes the ceiling only to $1.8624$, still well above $1.7974$.

**Direction of the error.** The true ceiling from the chain is *larger*, so the method falls *further* short than recorded. **The closure conclusion is unaffected; only the number is wrong**, and it is wrong in the direction that understates the record's own case.

**Prior art, and one correction to it.** [ELIM-bounds.md](ELIM-bounds.md) §W6 reached $1.9012$ before me; I derived it independently and read W6 only afterwards, on the citation search. W6 is right that the multipliers are not reconstructible, and **wrong** in its stated reason: it argues that *"the excess decreasing in $n$"* is impossible because the ceiling rises toward $2$. The recorded excess is normalised by $\mathrm{gap}^*=\theta_0(n)-\sqrt{3/2}$, which grows from $0.0113$ to $0.1682$ over $n=12\dots100$, so a rising ceiling and a falling ratio are perfectly consistent, as the corrected column $58.9\to3.57$ shows. The real defect is the arithmetic and the inadmissible $k_0$, not the monotonicity. **W6's finding was never folded into the block**: the sentence still reads $49.7\times$ in both [findings/curvature-invariants.md](../findings/curvature-invariants.md) line 52 and [results.md](../results.md) lines 186 and 538.

## 4. What is derived and what is measured, and why the label is wrong

Splitting the block's ingredients by what supports them:

| ingredient | support | valid at |
| --- | --- | --- |
| $\mathop{\mathrm{tr}}(L_x)=0$ and $\mathop{\mathrm{tr}}(L_xL_y)=\kappa_n\langle x,y\rangle$ | Schur: $\mathcal W_n$ is $O(n)$-irreducible, so the invariant symmetric form is a multiple of the metric and the invariant vector vanishes | **every $n$** |
| the **value** $\kappa_n=\tfrac{(n-1)(2n-1)}4$ | *fitted*. [ATTEMPTS.md](../ATTEMPTS.md) line 1954: *"$\kappa_W=(2n-1)(n-1)/4$ **fitted** from $n=5,6,8,9,10$"*; line 646: obtained by fitting explicit $L_W$ matrices to exact rationals with held-out prediction at three unseen $n$ | $n\in\{5,6,8,9,10\}$, plus $6\dots12$ |
| the cap attained with multiplicity $k_0$ | proved, §2 Step 1. The recorded numerical check at $n=8,10,12$ is redundant | **every $n$** |
| the Cauchy–Schwarz combination | proved, §2 Step 2 | **every $n$** |
| $k_0\le\binom n2$ | counting | **every $n$** |
| the margin table | measured | $n=12,14,20,100$ |
| *"the fourth moment reaches only $14\times$ even granting an oracle"* | an explicitly granted oracle; [ATTEMPTS.md](../ATTEMPTS.md) reports the level-4 assessment *"as a recommendation rather than a theorem"* and gives $30\times$ as the honest figure | nowhere |

**The one gap that matters.** The ceiling of $2$ is *not* insensitive to $\kappa_n$: it is $\lim_n \kappa_n/(n^2/8)$, and $\kappa_n\sim n^2/2$ is precisely what makes it $4$ before the square root. Schur gives the *form* at every $n$; the *constant* is a fit at six dimensions. So the block's central quantitative claim rests on an unproven closed form, and the record's own labels then make L13 an `Observation` at the dimensions where $\kappa_n$ was measured, the exact failure mode the brief names, and the one [LEDGER.md](../findings/LEDGER.md) records for a sibling.

**This gap is reachable, and cheaply.** $\kappa_n$ is determined by the symmetric $3$-tensor $T(x,y,z)=\langle B(x,y),z\rangle$ alone: summing $\mathop{\mathrm{tr}}(L_{e_a}^2)=\kappa_n$ over an orthonormal basis of $\mathcal W_n$ gives

$$\kappa_n\cdot\dim\mathcal W_n=\sum_{a,b,c}T(e_a,e_b,e_c)^2=\lVert T\rVert^2 ,$$

so one contraction of $\lVert T\rVert^2$ for $Q(W)=W^2+W^\#$ over $\mathcal W_n$ closes it at every $n$. That is a derivation, not a run, and it is what the block owes.

**Scope.** The block names $n=12$ and *"asymptotically"* and no other dimension, and it does not say the figures were measured or where. The margin table lives in [ATTEMPTS.md](../ATTEMPTS.md) and is uncited. Nothing in the block restricts to $n\ge12$ or to any range; the chain of §2 does hold at every $n\ge4$, so the *scope* of the surviving statement is fine, it is the *support* that is dimension-bound.

## 5. "The wrong invariants", REFUTED as stated, and undefined under the intended reading

**The witness.** At a local maximum $W$ of $P$ on the unit sphere, $L_WW=\theta W$, and the Peirce cap gives $\langle L_WH,H\rangle\le\tfrac\theta2\lVert H\rVert^2$ for every $H\perp W$. $L_W$ is self-adjoint and $W$ is an eigenvector, so every other eigenvector lies in $W^\perp$ and every other eigenvalue is $\le\theta/2<\theta$. Hence

$$\theta=\lambda_{\max}(L_W).$$

The moments $\mathop{\mathrm{tr}}(L_W^k)$, $k=1,\dots,\dim\mathcal W_n$, determine the characteristic polynomial of $L_W$, hence its spectrum, hence its largest eigenvalue, hence $\theta$, **exactly, with no loss**. So the spectral moments of $L_u$ are not "the wrong invariants" for $\theta$; they are *complete* invariants for it. The literal claim is false, and it is the claim the block makes twice and [results.md](../results.md) line 186 promotes to *"Proven to be the wrong invariant for this problem"*.

**What the block presumably means, and what it would have to say.** The intended object is a *relaxation*: fix a family $\mathcal F$ of functionals of $\mathop{\mathrm{spec}}(L_u)$ that are computable in closed form from $O(n)$-invariants of $W$, bound their values over critical points, and take

$$\sup\{\lambda_{\max}(L):\mathop{\mathrm{spec}}(L)\text{ consistent with those bounds}\}.$$

An impossibility theorem is then: *for every $\mathcal F$ in the admissible class, that supremum exceeds $\theta_0(n)$ for infinitely many $n$.* **The block states no such thing.** It proves it for exactly one $\mathcal F$ (the second moment together with the dimension count $k_0$) and asserts it for a second, the fourth moment, under an oracle it explicitly grants. Two instances plus an extrapolation is not a theorem about a family, and the block never names the family, the admissible class, or what the functionals fail to separate.

**What is genuinely proven, and it is worth keeping.** The diagnosis sentence, $\mathop{\mathrm{tr}}(L_W^2)$ is a constant multiple of $\lVert W\rVert^2$, hence carries no information about $W$ beyond its norm, **is a theorem at every $n$**, and it needs only Schur, not the fitted value of $\kappa_n$. It closes the *second moment alone* as a source of information about $\theta$. That is the sentence the record should carry, and it is strictly weaker than the one it does carry.

## 6. The label

Under the record's literal labels the block is **mislabelled**, and the honest split is three statements at three labels:

- **`Lemma`, every $n$:** $\mathop{\mathrm{tr}}(L_x)=0$; $\mathop{\mathrm{tr}}(L_xL_y)=\kappa_n\langle x,y\rangle$ for some $\kappa_n$; the orbit-tangent equality $\langle L_WH,H\rangle=\tfrac\theta2\lVert H\rVert^2$; and hence $\theta^2(1+\tfrac{k_0}4)\le\kappa_n$ at every critical point. The second moment alone therefore determines nothing about $W$ beyond $\lVert W\rVert$.
- **`Observation`, at $n\in\{5,6,8,9,10\}$ (and $6\dots12$):** $\kappa_n=\tfrac{(n-1)(2n-1)}4$, and with it the ceiling $\theta\le2-o(1)$ and the margins. Promotable to a `Lemma` by the contraction in §4.
- **`Conjecture`:** that no family of spectral functionals of $L_u$ decides the problem. This is the sentence the block heads with, and it has no proof anywhere on the record.

The conclusion that this route is closed **survives** all three demotions, with the ceiling at $58.9\times$ rather than $49.7\times$, further from sufficing, not nearer. **The block is wrong in its headline and its number, and mislabelled in its support; the route stays closed.**

## 7. Pointers, symbols and hedges

**Pointers.** The block contains no links at all. Everything resolves elsewhere: the anchor at [findings/curvature-invariants.md](../findings/curvature-invariants.md) line 5 matches the heading; [results.md](../results.md) line 540's `Proof:` resolves to the file though not to a section; [INDEX-results.md](../findings/INDEX-results.md) row 13 points at this file and records *"Gate 2: no verdict on the record"*, which was accurate until now. The two scripts [ATTEMPTS.md](../ATTEMPTS.md) names for this method, [run_lw_trace_identities.py](../scripts/lib/run_lw_trace_identities.py) and [run_lw_spectral_bound.py](../scripts/runs/run_lw_spectral_bound.py), both exist. **The only broken pointer is the missing one**: nothing in the block leads to the argument.

**Consumers.** [plan-verification.md](../plan-verification.md) line 60 (tier 2, unchecked), [findings/INDEX.md](../findings/INDEX.md) line 44, and [report/sections/diagram-closed.tex](../report/sections/diagram-closed.tex) line 178, which prints the displayed inequality with an `L13` tag. No lemma consumes L13, so §3's defect does not propagate into any other proof, but the report reproduces the inequality, and the report is where the wrong margin would be read.

**Symbol collisions, three, all live.**

- **$B$.** The block's $B(u,H)$ is the polarisation of $Q$, the object [conventions.md](../findings/conventions.md) calls $\circ$. That file already tables $B$ as carrying the $\mathfrak{so}(n)$ Killing form, [sym3-blocks.md](../findings/sym3-blocks.md)'s form, and $\tfrac\theta2\mathrm{Id}-L_W$, with the warning **"THE LETTER $B$ MEANS TWO THINGS, live"**. This block adds a fourth sense, and it is the one sense that is a *bilinear map into $\mathcal W_n$* rather than a form or an operator, so the collision is with the sense whose very definition contains $L_W$.
- **$\lambda$.** Here $\lambda=\theta$. Everywhere else in the record $\lambda$ is an eigenvalue of $W$ on $\Lambda^2$, $\lambda_{\min}$, $\lambda_{\max}$, $\lambda_\alpha$. Read with the record's $\lambda$, *"$\lambda\le2-o(1)$ against a true $\sqrt2$"* is a statement about $\lambda_{\max}(W)$ and is a different, false claim.
- **$u$ and $k_0$.** Neither is defined in the block. $u=W$ at unit norm; $k_0=\dim(O(n)\cdot u)$, defined only in [ATTEMPTS.md](../ATTEMPTS.md).

**Hedges, five, each concealing something.**

| clause | what it conceals |
| --- | --- |
| *"a proof about the method rather than about the bound"* | no proof is present, of either |
| *"closed with a measured margin rather than left as a maybe"* | the margin is measured, at four dimensions, in an uncited file, and the measured value contradicts the block's own inequality (§3) |
| *"together yielding"* | the whole combining argument (§2 Step 2) |
| *"a Peirce cap at $\lambda/2$ on $u^\perp$"* | a local-maximum hypothesis, stated in [ATTEMPTS.md](../ATTEMPTS.md) and dropped here (§2) |
| *"even granting an oracle"* | the level-4 assessment is *"a recommendation rather than a theorem"* in its own source, whose honest figure is $30\times$, and no level-4 bound was ever proved |

## 8. What is owed

1. **Transcribe the derivation** of §2 into the block (five lines) so that [findings/](../findings/) carries the proof rather than [ATTEMPTS.md](../ATTEMPTS.md), which the record bars from carrying one.
2. **Strike or re-derive $49.7\times$.** The chain gives $58.9\times$ at $n=12$; the recorded $1.7974$ needs $k_0=74.3>\dim\mathfrak{so}(12)$ and is unreachable. Same for the $15.4/7.0/3.4$ rows and for [report/sections/diagram-closed.tex](../report/sections/diagram-closed.tex).
3. **Replace the headline.** *"Spectral moments of $L_u$ are the wrong invariants"* is refuted by $\theta=\lambda_{\max}(L_u)$. The true sentence is the diagnosis: $\mathop{\mathrm{tr}}(L_W^2)$ is a constant multiple of $\lVert W\rVert^2$, so the **second** moment carries no information beyond the norm.
4. **Derive $\kappa_n$** by the contraction $\kappa_n\dim\mathcal W_n=\lVert T\rVert^2$ of §4, or relabel the ceiling as an `Observation` at $n\in\{5,6,8,9,10\}$.
5. **Correct the provenance stamp**, false in both clauses, seventh of seven audited.
6. **Name the pairing** in which $\kappa_n$ and $\theta_0(n)$ were computed, since the comparison is covariant only if they share one.
7. **Fix the three symbol collisions**, at minimum by writing $\theta$ for $\lambda$ and $\circ$ for $B$.
