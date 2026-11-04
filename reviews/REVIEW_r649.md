# Review r649, Lemma L112, the doubly stochastic row calculus

**Reviewer A of an identical-brief pair (r649/r650). Cold derivation from [conventions.md](../findings/conventions.md) and the three relations, not from the block's reasoning. Analysis only: no computation was run, and the linear programme this block reports was not re-run.**

## Verdict

> **REFUTED, the lemma is right, the sentence it carries is not.** The doubly stochastic statement is correct and I rebuild it below in four lines, and Lemma L73 is genuinely its one-index shadow. **But "both of this record's standing spectral bounds are one system read twice … neither was ever an independent result" does not follow from it and is false as stated**, and the two reviews the block cites, [r337](REVIEW_r337.md) and [r338](REVIEW_r338.md), both say so in terms that were never folded in.

| claim | verdict |
| --- | --- |
| $\lambda$ is a $-\tfrac1{n-2}$-eigenvector of a symmetric hollow doubly stochastic matrix | **CONFIRMED**, from (A)+(B)+$T\ge0$; needs no criticality, no unit norm, and no trace-freeness hypothesis |
| [Lemma L73](../findings/bounds.md) is the one-index shadow | **CONFIRMED** as a *strict* consequence, precisely, the $k=1$ case of $-\tfrac\lambda{n-2}\prec\lambda$ |
| both standing spectral bounds are one system read twice; neither was ever independent | **REFUTED**, see §1 |
| $\max\theta\ge1.340542$ at $n=6$ is a floor, not the maximum | **CONFIRMED**, and the direction is the one the conclusion needs |
| the pinned class does not close the conjecture | **GAP**, the conclusion is not reachable from an $n=6$ run, for a reason the block itself records four blockquotes later |
| the two figures derived from the floor ($1.09\times$, "(B) closes two-thirds of the gap") | **REFUTED**, both are computed from the number the same sentence declares superseded |

## Readings I adopt, stated because two of them are contested

- **$T_{abc}=c_{abc}^2$** with $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric in an orthonormal eigenbasis $\{v_a\}$ of $W$ on $\Lambda^2\mathbb R^n$, $Wv_a=\lambda_av_a$, $N=\binom n2$. So $T$ is totally symmetric, non-negative, and hollow **in the 3-tensor sense** of [conventions.md](../findings/conventions.md), it vanishes whenever any two indices coincide.
- **Ordered sums**, per [conventions.md](../findings/conventions.md)'s default. So (A) reads $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$, and the run's own $\sum_{b<c}T_{abc}=n-2$ in [run_pinned_lp_spectra.py](../scripts/runs/run_pinned_lp_spectra.py) is the same relation halved. The block is consistent on this.
- **$S_{ab}:=\sum_cT_{abc}$ is a single sum and needs no ordering convention.** It does **not** collide with [conventions.md](../findings/conventions.md)'s $S_{XYZ}$ in the sense of an ambiguity: $S_{XYZ}$ carries three *block* labels and is a projector contraction, $S_{ab}$ carries two *index* labels and is a slot contraction. **But the letter is now carrying four objects** ($S_{XYZ}$, this $S_{ab}$, $S(W)$ the gradedness slack, and the $S$ of $\mathcal D_n$), three of them tabled in conventions.md and this one not. It belongs in that table beside $B$, $M$ and $\mu$.
- **$M$**: I use $M(n)$ for the global maximum only. The bare $M_a$ of the [Lemma L107](../findings/bounds.md) block (extreme pair product) and the $M_{kl}$ of [Lemma L111](../findings/bounds.md) are two further senses inside this one file; I name the row or the lemma every time.

## 1. The unification claim, leading, as the brief asks

### 1.1 The "SO" is a non sequitur, and the reason is one line

The blockquote opens **"SO BOTH OF THIS RECORD'S STANDING SPECTRAL BOUNDS ARE ONE SYSTEM READ TWICE"**, positioned to follow from the doubly stochastic paragraph immediately above it. It cannot.

> **Relations (A) and (B) do not contain the symbol $\theta$.** (A) is a Lie-algebra identity about an orthonormal basis; (B) is $W\#I=-W$, linear in $W$. Neither mentions $\theta$, so no consequence of them alone (doubly stochastic, majorised, subset-summed, or otherwise), can be an upper bound on $\theta$. Both standing bounds are bounds on $\theta$. **Therefore neither is a reading of the system L112 states.**

The record already holds this as a graded theorem, at [plan.md](../plan.md) item I17: *"no Schur-convexity argument reaches $\theta$, because every object the SDIEP toolbox produces is built from (A) and (B), which contain no $\theta$."* The L112 block asserts the opposite twenty lines from where its own lemma is stated.

The sharper form, which also says what $S$ throws away. Every scalar built from the pair matrix by $\lambda$-weighted contraction, $\sum_{ab}f(\lambda_a,\lambda_b)S_{ab}=\sum_{abc}f(\lambda_a,\lambda_b)T_{abc}$, is a contraction of $T$ whose **third slot carries weight $\lambda^0$**. At unit norm

$$\theta=P(W)=\mathop{\mathrm{tr}}W^3+\tfrac12\sum_{k\alpha\beta}\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta},$$

whose $T$-dependence is the $\{1,1,1\}$ pattern. **$\theta$ is invisible to $S$.** The compression $T\mapsto S$ is $\binom N3\to\binom N2$ ($455\to105$ at $n=6$) and it discards exactly the contraction $\theta$ lives in.

### 1.2 What the two bounds actually consume, derived cold

**[Lemma L70](../findings/bounds.md), at the $\lambda_{\min}$ row.** With $v$ a unit $\lambda_{\min}$-eigenvector, (C) at row $v$ and (A) at row $v$ give

$$2D(v)=\sum_{ab}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})T_{vab}=2\lambda_{\min}(\theta-\lambda_{\min})-2(n-2)\lambda_{\min}\lambda_{\max},$$

so $D(v)=\lambda_{\min}\big[\theta-\lambda_{\min}-(n-2)\lambda_{\max}\big]$ and, dividing by $\lambda_{\min}<0$, $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$ exactly as boxed. **Inputs: (A), (C), $T\ge0$, $\lambda_{\min}<0<\lambda_{\max}$, unit norm. (B) is never used.**

**The $\Pi$-bound, at the $\lambda_{\max}$ row.** $\mu_a=T_{a\bullet\bullet}/2(n-2)$ is a probability measure by (A); (B) gives $\mathbb E[X]=-\lambda_a/(n-2)$ with $X=\tfrac{\lambda_b+\lambda_c}2$; (C) gives $\mathbb E[Y]=\lambda_a(\theta-\lambda_a)/(n-2)$ with $Y=\lambda_b\lambda_c$. Then $Y\le X^2$ and the chord give $\lambda_a(\theta-\lambda_a)\le-(\lambda_{\min}+\lambda_{\max})\lambda_a-(n-2)\lambda_{\min}\lambda_{\max}$; at $a=\arg\max$, with $h=\lambda_{\max}$, $m=\lvert\lambda_{\min}\rvert$, the $h^2$ terms cancel and $h\theta\le mh+(n-2)mh$, i.e. $\theta\le(n-1)m$. **Inputs: (A), (B), (C), plus two convexity steps.** Reproduced exactly; the block's display is right.

So the two derivations differ in the row, in the relations, **and in the inequality step**, a lower bound on $\mathbb E[Y]$ by the global minimum product at one, an upper bound on $\mathbb E[Y]$ through a pinned first moment at the other. Reading the $\Pi$-derivation at $a=\arg\min$ returns $\theta\ge-(n-1)\lambda_{\max}$, which is vacuous; **the "same reading at the other row" produces nothing**, which is the cleanest disproof of "one system read twice" in its literal sense.

### 1.3 The witness against "neither was ever an independent result"

**The two bounds' non-(A) inputs are disjoint on this record.**

| bound | derivation on the record | (B)? | (C)? | quantifier proved |
| --- | --- | --- | --- | --- |
| L70 | row $\arg\min$, termwise product bound | no | **yes** | critical points, unit norm |
| $\Pi$-bound, row route | row $\arg\max$, chord + $Y\le X^2$ | **yes** | **yes** | critical points |
| $\Pi$-bound, $g$-route ([L107](../findings/bounds.md) block) | $\sum_kg_k=4(n-1)$, $\sum_k\lambda_kg_k=-4P$, $g\ge0$ | **yes** | **no** | **all of $\mathcal W_n$** |
| $\Pi$-bound, vertex route ([bounds-relaxations.md:381](../findings/bounds-relaxations.md)) | $t_{112}\ge0$ at the $d=2$ reduction | yes | yes | two-value spectra |

I checked the $g$-route consumes no criticality, since the block's quantifier claim rests on it: $\sum_{k\alpha\beta}\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=2\sum_k\lambda_k\langle v_k,W^\#v_k\rangle=2\langle W,W^\#\rangle$ is the definitional identity $\langle v,W^\#v\rangle=\tfrac12\sum\lambda_a\lambda_bT_{vab}$, **not** relation (C), which is only its critical-point *value*. With $\{1,1,0\}$ and $\{2,1,0\}$ handled by (A) and (B), $\sum_k\lambda_kg_k=-4P(W)$ falls out at every $W\in\mathcal W_n$, and $-4P\ge\lambda_{\min}\sum g_k=4(n-1)\lambda_{\min}$ gives the bound everywhere.

**So the $\Pi$-bound has a derivation proving strictly more than any (C)-consuming row reading can**, this is [INDEX-results.md](../findings/INDEX-results.md) row 107's own settled finding, *"the quantifier was understated, the $g$-route needs no criticality and proves it on all of $\mathcal W_n$"*. A result whose recorded content exceeds what the alleged parent system can state is not "never an independent result". **REFUTED, with the record's own row 107 as the witness.**

*The honest replacement, which is true and worth having:* both bounds are consequences of the per-row calculus (A)+(B)+(C) under $T\ge0$; L70 spends (A)+(C) at the $\arg\min$ row, the $\Pi$-bound spends (A)+(B)+(C) at the $\arg\max$ row; and the $\Pi$-bound is additionally derivable from (A)+(B)+$T\ge0$ summed across all rows, where it holds without criticality.

### 1.4 The block's own file settles this, twice, above the block

- **Twenty-five lines above**, the [Lemma L107](../findings/bounds.md) block already records the L70 half: *"its negative half is [Lemma L70], already insufficient."*
- **The same block already carries a stronger and correct unification**, credited to [r337](REVIEW_r337.md): *"[Lemma L70], the $\Pi$-bound and the per-row family are all 1-D projections of it"*, the two-moment convex-hull condition. That is the true statement in the neighbourhood, it is attributed, and L112's blockquote states a weaker version of it unattributed and as a consequence of a system that cannot carry it.

### 1.5 Provenance, the sentence has already been reviewed twice, and lost twice

Both reviews are cited *inside this very block* for other things.

- **[r337](REVIEW_r337.md)** quotes the sentence verbatim under the heading *"The positive half is NOT the $\Pi$-bound, the identification is refuted in both directions"*, and closes **"Neither direction holds"**, with a table: at the balanced product the $\Pi$-bound is exact and the row family is slack by $n/(n-2)$; at padded $W_{\mathbb{CP}^2}$ at $n=12$ the family beats the $\Pi$-bound by $1.57\times$. Neither dominates.
- **[r338](REVIEW_r338.md)** quotes it and rules it *"correct about which **rows** are read and wrong if it is taken to mean the family reproduces them"*, with the same two evaluation points.

Neither verdict appears in the block. The block cites r337 for the r335/r336 dispute and r338 for the construction, and passes over what both wrote about its headline.

**Attribution of the construction itself is clean.** [r338](REVIEW_r338.md) §U2 Objection 2 sets $S_{ab}:=\sum_cT_{abc}$, derives symmetry, hollowness, non-negativity, the row sum and $S\lambda=-2\lambda$, and boxes the normalised statement, the block reproduces it faithfully. One overstatement: *"a subset-sum family follows immediately and is unexplored"* understates the source, which **writes the family out in full**, with $w_b:=\sum_{a\in A}P_{ab}\in[0,1]$, $\sum_bw_b=\lvert A\rvert$ and the partial-sum display. It is derived, not merely implied.

## 2. The doubly stochastic structure, CONFIRMED, and it needs less than the block says

**Symmetric**: $T$ is totally symmetric, so $S_{ab}=S_{ba}$. **Non-negative**: $T_{abc}=c_{abc}^2\ge0$. **Hollow**: $c$ is totally antisymmetric, so $T$ vanishes on repeated indices and $S_{aa}=\sum_cT_{aac}=0$, this is the **3-tensor** sense of hollow, and the matrix sense for $S$ follows from it.

**The row sum is $2(n-2)$, and it is the Killing marginal**, not the pair cap: $\sum_bS_{ab}=\sum_{bc}T_{abc}=2(n-2)$ is exactly (A). Directly, $\sum_b\lVert[v_a,v_b]\rVert^2=-\mathop{\mathrm{tr}}(\mathop{\mathrm{ad}}(v_a)^2)=-B(v_a,v_a)=-(n-2)\mathop{\mathrm{tr}}(v_a^2)=2(n-2)$ under [conventions.md](../findings/conventions.md)'s $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ and $\mathop{\mathrm{tr}}(v^2)=-2$. **The brief is right that it carries no result number**: [INDEX-results.md](../findings/INDEX-results.md) mentions it only as an input to rows 70, 79 and 143, never as a numbered result, while its companion the pair cap is [Lemma L31](../findings/stratum-two-negative.md). It is doing load-bearing work in four lemmas unnumbered.

With $\hat S:=S/2(n-2)$ symmetric, non-negative, hollow with unit row sums (hence doubly stochastic), relation (B) reads $\sum_b\lambda_bS_{ab}=-2\lambda_a$, i.e. $S\lambda=-2\lambda$, i.e.

$$\hat S\lambda=-\frac{1}{n-2}\lambda .$$

**Which vector $\lambda$ is**: the vector of $\Lambda^2$-eigenvalues of $W$ in the eigenbasis indexing $S$, length $N=\binom n2$, *not* the sectional matrix's spectrum, and not indexed by $\mathbb R^n$. The $-\tfrac1{n-2}$ is the ratio of (B)'s constant $-2$ to (A)'s marginal $2(n-2)$: **the marginal, not the pair cap.**

**The sign check the brief asks for, and it closes:** $\hat S\mathbf 1=\mathbf 1$, so $1$ is the Perron value; $\hat S$ is symmetric, so eigenvectors at distinct eigenvalues are orthogonal, and $-\tfrac1{n-2}\ne1$ forces $\langle\lambda,\mathbf 1\rangle=0$. **Trace-freeness of $W$ is a consequence here, not a hypothesis**, the block lists it nowhere, correctly, but the point is worth stating because the neighbouring [Lemma L70](../findings/bounds.md) does need $\mathop{\mathrm{tr}}W=0$ as an input.

**Hypotheses, in full.** $W\in\mathcal W_n$ and $\{v_a\}$ an orthonormal eigenbasis of $W$. That is all. **No criticality**, (C) is nowhere in it. **No unit norm**, both sides of (B) are homogeneous of degree $1$ in $\lambda$, so the eigenvector relation is scale-invariant, and (A) carries no $\lambda$. **No trace-freeness as input.** The heading claims nothing beyond this, so unlike the companion audit's case the heading is not over-narrow; if anything the block under-sells it by never saying the criticality-freeness out loud, where the neighbouring [Lemma L73](../findings/bounds.md) block makes a point of it.

**One thing the block does not notice about its own object.** $S_{ab}=\sum_cc_{abc}^2=\lVert[v_a,v_b]\rVert^2$. So:

- The **pair cap** [Lemma L31](../findings/stratum-two-negative.md), $\lVert[v_a,v_b]\rVert^2\le2$, is exactly an entrywise cap on this matrix: $\hat S_{ab}\le\tfrac1{n-2}$. A symmetric doubly stochastic matrix with entries capped at $\tfrac1{n-2}$ has at least $n-2$ non-zeros in every row, a support bound available for free, and a strictly stronger object than "doubly stochastic".
- The **deficit** $\epsilon_{ab}=2-\lVert[v_a,v_b]\rVert^2$ of conventions.md is $2(J-I)-S$, so the deficit matrix has constant row sums $2(N-1)-2(n-2)=(n-1)(n-2)$. The record already carries this matrix under another name, with no cross-reference either way.

## 3. "L73 is the one-index shadow", CONFIRMED, as a strict consequence

$\hat S_{a\bullet}$ is a probability vector supported off $a$, so row $a$ of the eigenvector equation puts $-\lambda_a/(n-2)$ in $[\min_{b\ne a}\lambda_b,\max_{b\ne a}\lambda_b]\subseteq[\lambda_{\min},\lambda_{\max}]$, giving $-(n-2)\lambda_{\max}\le\lambda_a\le(n-2)\lvert\lambda_{\min}\rvert$, [Lemma L73](../findings/bounds.md) verbatim, both halves.

**"Shadow" is not a defined relation, and the precise claim is available.** $\hat S$ doubly stochastic gives Hardy–Littlewood–Pólya $\hat S\lambda\prec\lambda$, i.e.

$$-\tfrac1{n-2}\lambda\ \prec\ \lambda ,$$

whose $k=1$ partial-sum inequality in each direction **is** L73, and whose $k\ge2$ inequalities are r338's subset-sum family. So the exact relation is: **L73 is the $k=1$ case of a majorisation, hence a strict consequence and not an equivalent**, L112 additionally delivers $\sum\lambda=0$ and every $k\ge2$ inequality. The [Lemma L73](../findings/bounds.md) block's own phrasing, *"L73 is the $k=1$ majorization shadow of the first"*, and [INDEX-results.md](../findings/INDEX-results.md) row 73's *"a lossy projection of Lemma L112"*, are both right and both stronger than the bare word "shadow". [plan.md](../plan.md) I17 records the majorisation reading as a theorem. **Nothing owed here except the word.**

## 4. The linear-programme figures

### 4.1 Floor versus maximum, CONFIRMED, and the direction is right

With the spectrum **free**, the problem is an inner LP in $(T,\theta)$ at fixed $\lambda$ wrapped in a non-convex outer search over $\lambda$, the structure is stated in [run_pinned_lp_spectra.py](../scripts/runs/run_pinned_lp_spectra.py)'s docstring, *"theta enters (C) linearly, so max theta at fixed lambda is an LP. Outer: Nelder-Mead over the spectrum"*. A local outer search returns a **feasible value**, hence a lower bound on the supremum. The block says "a floor, not the maximum" and writes $\ge$; **correct, and correctly directed**: the conclusion drawn is "the class admits values above the target", which needs a floor. A ceiling would be needed for the opposite conclusion, and none exists, [r331](REVIEW_r331.md) states flatly that *"nobody has measured the full pinned class"*.

*One thing the block does not state and the run does*: the outer search is over **trace-free unit-norm** spectra. Without a norm constraint $(\lambda,\theta)\mapsto(t\lambda,t\theta)$ preserves feasibility and $\max\theta=+\infty$, so the normalisation is not a detail. It is in the script and not in the block.

### 4.2 Two derived figures are computed from a number the same sentence retires

The sentence reads: $\max\theta\ge1.340542$, *"[Reviewer 335] reaching $1.392879$ in eight restarts and still climbing, so the class overshoots by **more** than first reported … an overshoot of $1.09\times$ … where (A)+(C) alone gives $1.30\times$ … **So relation (B) closes two-thirds of the gap**."*

- $1.340542/1.224745=1.0945$. **The printed $1.09\times$ is the ratio of the superseded number**, in a clause asserting the overshoot is larger than that.
- $1.392879/1.224745=1.1373$, so the honest figure is $1.14\times$.
- Gap closure against (A)+(C)'s $1.30\times$: $(0.30-0.09)/0.30=0.70$ at the old floor, but $(0.30-0.137)/0.30=0.54$ at r335's. **"Two-thirds" becomes "just over half."**
- The attribution to [r335](REVIEW_r335.md) is **accurate**, $1.392879$, eight restarts, still climbing, all verified in the source.
- [r336](REVIEW_r336.md) independently reached $1.366272$ and wrote the warning this sentence walks into: *"Any later claim that some added relation 'closes $x$ of the gap' computed against $1.340542$ is measuring against a moving floor."* The block cites r336 three times and folds this in nowhere; r336's own figure is unrecorded here.

### 4.3 "The true maximum $\sqrt{3/2}$" at $n=6$ is not on the record as a maximum

The overshoot ratios are taken against $M(6)=\sqrt{3/2}$. What is proved is $M(6)\ge\sqrt{3/2}$, by padded $W_{\mathbb{CP}^2}$. The **only** attempted upper bound, [second-order.md](../findings/second-order.md)'s $M(6)\le\Phi(15)$ chain, is withdrawn there in terms: *"$1.630017$ is the best value an ascent found … nothing here bounds $\Phi(15)$ above."* The proved analogue is one dimension down, [Lemma L61](../results.md) gives $\Theta_5=M(5)=\sqrt{3/2}$ on all of $\mathcal W_5$ by an exact rational SOS certificate, and does not transfer. Meanwhile every LP maximum is an **upper** bound for $M(6)$, since a critical maximiser supplies a feasible $(\lambda,T)$.

**So "the class overshoots the true maximum" is not established at $n=6$**, and cannot be until $M(6)$ has a ceiling below $1.34$. What *is* established is that the class admits $\theta$ far above $\theta_0(6)=1.054093$. [conventions.md](../findings/conventions.md) and [W5](../findings/INDEX-traps.md) both assert $M(6)=\sqrt{3/2}$ flatly; that is a separate defect, outside this block, and I flag it rather than chase it.

### 4.4 "The pinned class does not close the conjecture", GAP, at the scope

Take the figures as given, either of them. At $n=6$:

$$\text{LP floor }1.340542\ \ (\text{or }1.392879)\ >\ \sqrt{3/2}=1.224745\ >\ \theta_0(6)=\Theta_6=1.054093 .$$

The conclusion survives moving either number, anything above $1.054093$ does the same work, and the ordering against $\Theta_6$ and against $\sqrt{3/2}$ is unchanged. **But that is not what makes it a gap.** Conjecture A is asserted for $n\ge12$, and at $n=6$ the target inequality $\theta\le\theta_0(6)$ is **false**, padded $W_{\mathbb{CP}^2}$ is a genuine critical point at $\sqrt{3/2}>\theta_0(6)$. **No sound relaxation can certify a false statement**, so the class's failure to certify it at $n=6$ is forced and carries no information about $n\ge12$. The $n=6$ run cannot distinguish "the class is too weak" from "the statement is false at this dimension".

The block records [r335](REVIEW_r335.md)'s form of exactly this observation four blockquotes later (*"the run could not have reached outcome (iv) at the dimension it ran at"*) and leaves the headline conclusion standing above it unqualified. [plan.md](../plan.md) already lists *"bounds.md's 'T9 at $n=6$ shows the pinned class fails', which is outside the conjecture's range"* as a verification-loop candidate. **What is owed is a dimension, not an argument**: the same system at $n\ge12$, which is [plan.md](../plan.md) I24a and is blocked on the user's approval for computation.

### 4.5 "Full system" overstates what was run, and L112 supplies the missing constraint

The run imposes (A), (B), (C) and $T\ge0$. It does **not** impose the pair cap, which is proved ([Lemma L31](../findings/stratum-two-negative.md)) and which the record's own *"full pinned relaxation"* at [post F45](../findings/fence-posts.md) includes: *"(A), (B), (C), the proved row cap and $T\ge0$"*. So the reported floor is for a relaxation strictly weaker than the one the record calls full, and a weaker relaxation overshooting is weaker evidence.

**This is where the lemma under audit earns something the block does not claim for it.** §2 above: the pair cap *is* an entrywise cap on L112's own matrix, $\hat S_{ab}\le\tfrac1{n-2}$, linear in $T$, hence free to add to the inner LP. **The one constructive consequence of L112 for T9 is a constraint the T9 run omitted**, and the block instead spends its L112 corollary budget on a subset-sum family it calls unexplored.

### 4.6 Which parts are Lemma and which are Observation

[INDEX-results.md](../findings/INDEX-results.md) row 112 is labelled **Lemma** and its statement is the doubly stochastic eigenvector claim alone, correctly, since that is the part with a proof. Everything else under this heading is measurement at $n=6$: $1.340542$ and $1.392879$; the two Newton-point gaps $+0.2296$ and $+0.2287$; the $3.1\times10^{-29}$ realizability fit and its $\theta=0.266701$; $0.230284$/$0.231181$; the $\theta\in[0.17568,1.054093]$ interval; the $2.77$ Nelder–Mead trap. **Under the record's literal labels these are Observations at the dimensions named, sitting inside a Lemma block with no number and no dimension rider.** The r335 caveat that padded $W_{\mathbb{CP}^2}$ already realises outcome (iv) at $n=6$ makes the dimension rider load-bearing rather than decorative.

## 5. Pointers, and one that does not resolve

| pointer in the block | resolves? |
| --- | --- |
| `#lemma-l70--the-deficiency-identity-and-what-saturates-it` (twice) | **yes**, matches the heading at [bounds.md](../findings/bounds.md) under GitHub slugging |
| `#lemma-l112--lambda-is-a--tfrac1n-2-eigenvector-…` (used from the L73 block) | **yes**, including the doubled hyphen from the sign |
| `#lemma-l107--the-pi-bound-thetalen-1lvertlambda_minrvert` (neighbouring block) | **yes** |
| `[Lemma L104](../findings/LEDGER.md#lemma-l104-the-value-type-reduction)` | **NO**, L104's heading is in [bounds-relaxations.md](../findings/bounds-relaxations.md), not this file. A same-file anchor to another file's heading. The block's *own next clause* links it correctly as [L104](../findings/bounds-relaxations.md) |
| `[T9](../plan.md)` ×3, `[T10](../plan.md)` | **stale**, plan.md carries neither item |
| `[I24](../plan.md)`, in *"This is what I24 should be built on"* | **stale**, plan.md marks I24 CLOSED, subsumed by I13. The live heir is I17, which contains the theorem that this system carries no $\theta$ |

## 6. What is owed, and whether it is reachable

**Reachable by hand, now.**

1. **Withdraw the unification sentence** and replace it with §1.3's honest form, crediting [r337](REVIEW_r337.md)'s two-moment hull for the correct unification the same block already carries. Both cited reviewers reached this independently; a third reviewer here makes it three.
2. **Detach the L112 lemma from the "SO"**, which is refuted by (A) and (B) carrying no $\theta$, [plan.md](../plan.md) I17's own theorem.
3. **Recompute or drop $1.09\times$ and "two-thirds"**; at r335's floor they are $1.14\times$ and "just over half", and both move again if the outer search moves.
4. **Say "does not certify $\theta\le\theta_0(6)$" rather than "does not close the conjecture"**, with the note that $\theta\le\theta_0(6)$ is false and so the run could not have gone otherwise.
5. **Replace "the true maximum $\sqrt{3/2}$"** with $M(6)\ge\sqrt{3/2}$ wherever the ratio is quoted, or supply a ceiling on $M(6)$.
6. **Number the Killing marginal.** It is the row sum this lemma turns on and it is unnumbered across four lemmas.
7. **Record $\hat S_{ab}\le\tfrac1{n-2}$** as L112's corollary from [Lemma L31](../findings/stratum-two-negative.md), and note that the T9 run omitted it.
8. **Fix the L104 anchor and the T9/T10/I24 pointers.**

**Needs computation, therefore blocked and named rather than started.** Whether the pinned system's ceiling exceeds $\theta_0(n)$ at $n\ge12$, [plan.md](../plan.md) I24a, at the $n=12$ witness spectrum. Outcomes: a ceiling **at or below** $\theta_0(12)$ would prove Conjecture A at that spectrum's class and would make the pinned LP the bound; a floor **above** $\theta_0(12)$ at a realizable spectrum would be the first in-scope evidence that the class fails, which the $n=6$ run cannot supply at any precision. Adding the pair cap to the inner LP changes what either outcome means and should be in the same run. **I did not run it, and no figure in this review was computed.**

---

*Reviewer A, cold brief, no contact with the reviewer holding r650. Everything above is derivation from the definitions plus reading of the record; the only numbers I produced are the four ratios in §4.2, each a division of two figures already on the record.*
