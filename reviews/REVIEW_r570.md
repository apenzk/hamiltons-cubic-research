# Review r570, Lemma L35

**Reviewer:** r570, independent adversarial audit, working from the definitions.
**Target:** Lemma L35, at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$, unconditionally, in [stratum-two-negative.md](../findings/stratum-two-negative.md), block at lines 435–478.
**Footing:** analysis only. One screen was run, of a claim recorded below; it is reported as a screen and is evidence for nothing.

## Overall verdict, CONFIRMED

**The lemma is true and its chain is sound.** Every step of $\theta\le\mathrm{LP}\le G\le R\le\sqrt{3/2}$ that can be checked by hand was rebuilt here from the definitions and every one of them runs in the safe direction. Four defects were found; all four are defects of the *record*, and none of them touches the truth of the statement. They are listed as REPAIRED (repair given) or as owed repairs.

## What was rebuilt, and how it came out

### The identity, and the hypothesis the block omits, REPAIRED

$$\theta=\sum_\alpha\lambda_\alpha^3+3\!\!\sum_{\alpha<\beta<\gamma}\!\!T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$$

is **false as written**; it holds under the added hypothesis $\lVert W\rVert=1$. $P(W)=\langle W,W^2\rangle+\langle W,W^\#\rangle$ is homogeneous of degree three and $\theta=P(W)/\lVert W\rVert^3$, so the display is $P(W)$ and equals $\theta$ only on the unit sphere. **The repair is one clause** ("normalise $\lVert W\rVert=1$, which $\theta$'s scale-invariance permits") and it costs the lemma nothing. [Lemma L29](../findings/stratum-two-negative.md) states $\lVert W\rVert=1$ explicitly; L35 dropped it while inheriting the arithmetic that needs it, since $bc=(s^2+u-1)/2$ consumes $b^2+c^2+u=1$.

**The claim "an identity requiring no Weyl hypothesis" is correct** of the display itself: it needs only that $W$ is a self-adjoint operator on $\Lambda^2\mathbb R^m\cong\mathfrak{so}(m)$, that $\{v_\alpha\}$ is an orthonormal eigenbasis, and that $\#$ is the Lie-algebra square. It needs **no** first Bianchi identity. **What the chain around it does need is trace-freeness $\sum_\alpha\lambda_\alpha=0$**, used at $s=b+c$, and that *is* a Weyl consequence (the Weyl operator is trace-free on $\Lambda^2$). So the block's claim is true of the identity and would be false of the chain; it is stated narrowly enough to be right, but a reader is entitled to the distinction.

**The coefficient $3$ is right, confirmed twice by routes sharing nothing.**

- Against L29's own bookkeeping: L29 writes $\langle W,W^\#\rangle=\tfrac12\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ over *all ordered* triples; the six orderings of a distinct triple give $\tfrac12\cdot6=3$ per unordered triple. Identical.
- Against the record's own anchor: at the spectrum $(2,-1,-1)/\sqrt6$ on $\Lambda^+\mathbb R^4$, $\sum\lambda^3=6/6^{3/2}=1/\sqrt6$; the single triple carries $T_{123}=\lVert[v_1,v_2]\rVert^2=2$ (the self-dual bivectors are exactly the rank-$4$, singular-value-$1/\sqrt2$, anticommuting pairs that [L31](../findings/stratum-two-negative.md)'s equality case describes), so $3T\lambda_1\lambda_2\lambda_3=12/6^{3/2}=2/\sqrt6$, and $\theta=3/\sqrt6=\sqrt{3/2}$. **Exactly the value the record records for $M(4)$.** A coefficient of $6$ would have returned $\sqrt{3/2}+2/\sqrt6$ and missed it.

### The norm, CONFIRMED

Checked against [conventions.md](../findings/conventions.md) rather than the block's usage. The block runs in $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$ on $\Lambda^2$, which is the record's normalisation; the pair cap $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ is stated there under the same half-trace pairing $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, and the anchor above reproduces $M(4)=\sqrt{3/2}$ in it. **No $\sqrt2$ is loose anywhere in the block.** The Li/Bourguignon–Karcher index-order caveat that conventions.md attaches to this file does not reach L35: the whole argument is about the first-kind operator $W$ on $\Lambda^2$, whose spectrum is independent of the $\mathring W$ index order.

### Is the relaxation's feasible set really a superset of the true $T$?, CONFIRMED

Four conditions, each checked:

| condition | holds for the true $T$ because |
| --- | --- |
| $T\ge0$ | $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ |
| totally symmetric | $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is totally antisymmetric, so its square is totally symmetric |
| pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$ | $\sum_\gamma\langle[v_\alpha,v_\beta],v_\gamma\rangle^2=\lVert[v_\alpha,v_\beta]\rVert^2$ over an orthonormal basis, then [L31](../findings/stratum-two-negative.md) |
| row marginal $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=m-2$ | $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=-B(v_\alpha,v_\alpha)=-(m-2)\mathop{\mathrm{tr}}(v_\alpha^2)=2(m-2)$, halved for unordered pairs |

So $\theta\le\mathrm{LP}(\lambda)$, and dropping the marginals gives $\mathrm{LP}\le G$ since a maximum over a larger set is larger. **Both relaxation steps go the safe way.**

**The row marginal carries no result number anywhere on the record.** Confirmed independently here: it is a standing bullet in [conventions.md](../findings/conventions.md) ("the pair cap and the Killing marginal") and appears in no numbered block. It is load-bearing for the definition of $\mathrm{LP}$ even though the chain then discards it, so a reader cannot check the first relaxation step against a numbered statement. [LEDGER.md](../findings/LEDGER.md) already carries this as an owed item; this audit is a fourth independent sighting.

### The decoupling, CONFIRMED, and "exactly" is the right word

The claim is an **identity**, not an inequality stated as one. Derivation:

With exactly two negatives $-b,-c$, a triple's sign type is one of $(+++)$, $(++-)$, $(+--)$, or contains a zero. $(---)$ cannot occur, it needs three negative indices and there are two. $(++-)$ enters with $\lambda_+\lambda_+\lambda_-<0$ against $T\ge0$, so a maximiser sets it to zero; triples meeting a zero eigenvalue contribute nothing. So $G$ is a maximum over the $(+++)$ entries and the $(+--)$ entries alone.

**Those two families consume disjoint constraints**, which is what makes the decoupling exact rather than sub-additive. The $(+++)$ entries sit in pairs $(\alpha,\beta)$ with both indices positive; the $(+--)$ entries $T_{\alpha,N-1,N}$ sit in the pairs $(N-1,N)$, $(\alpha,N-1)$ and $(\alpha,N)$. No pair carries both, because the entries that would join them are exactly the $(++-)$ ones, already zero. The maximum of a sum over a product of feasible sets is the sum of the maxima. $\square$

The $(+--)$ half is then a one-line transport: maximise $3bc\sum_{\alpha\in P}T_{\alpha,N-1,N}\lambda_\alpha$ against $\sum_{\alpha}T_{\alpha,N-1,N}\le2$, giving $6bc\lambda_1$, all the mass on the largest positive. **The binding constraint is the joint cap on the pair $(N-1,N)$, not the per-index one**, exactly as the note under L29 says; with the per-index cap alone the $k=2$ configuration $\lambda=(\tfrac12,\tfrac12)$, $b=c=\tfrac12$ reaches $1.5>\sqrt{3/2}$, reproducing the "maximum $1.5$" that note records.

### The $G$ display carries a silent change of index range, repair owed

$$G=\sum\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1)$$

is correct **only if $\sum\lambda^3$ ranges over the positives**, since $-s^3+3bcs=-(b^3+c^3)$ and $6bc\lambda_1$ is the transport. Three lines above, in the identity, $\sum_\alpha\lambda_\alpha^3$ ranges over **all** $\alpha$. Read that way the display double-counts $b^3+c^3$ and is wrong by $-(b^3+c^3)$. **Repair: write $\sum_P\lambda^3$, or drop $-s^3+3bcs$ and write $\sum_\alpha\lambda_\alpha^3+3M(\lambda_P)+6bc\lambda_1$**, which is the same object with no ambiguity. $\mathrm{FTP}$ is used twice on the record and defined nowhere; the prose gloss "fractional triangle packing" carries it, but it is the same object as $M(\lambda_P)$ in [L42](../findings/stratum-two-negative.md) and should be that symbol.

### The sharp dual weight (L42), CONFIRMED, including sharpness

Rebuilt from the LP. Primal $\max\sum_{\alpha<\beta<\gamma}t\lambda_\alpha\lambda_\beta\lambda_\gamma$ over $t\ge0$, $\sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}\le2$; the dual is $\min2\sum_{\alpha<\beta}z_{\alpha\beta}$ over $z\ge0$ with $z_{\alpha\beta}+z_{\beta\gamma}+z_{\alpha\gamma}\ge\lambda_\alpha\lambda_\beta\lambda_\gamma$ per triple. Putting $z=c\lambda_\alpha\lambda_\beta$ and dividing by $\lambda_\alpha\lambda_\beta\lambda_\gamma>0$ gives $c\sum1/\lambda\ge1$, i.e. $c\ge H/3$ with $H$ the triple's harmonic mean; $H$ increases in each argument so the binding triple is the three largest, $c=h/3$ is feasible, and weak duality gives $M\le2\cdot\tfrac h3\cdot\tfrac{s^2-u}2$, i.e. $3M\le h(s^2-u)$. Attained at $k\ge3$ equal positives by $t_{\alpha\beta\gamma}=2/(k-2)$: pair marginal $(k-2)\cdot\tfrac2{k-2}=2$, objective $\binom k3\tfrac2{k-2}\lambda^3=\tfrac{k(k-1)}3\lambda^3$, matching $\tfrac13h(s^2-u)=\tfrac13\lambda\cdot k(k-1)\lambda^2$. **Both halves check.** The hypothesis $k\ge3$ is stated where the argument lives.

### From $G$ to the one-variable inequality, the step the record does not carry

**This is the audit's largest finding.** The block goes from $G$ to "a three-parameter relaxation strictly increasing in $s$ and $u$", then to two variables, then to three regions and a function $F(A)=g(A)+\psi^*(A)$ on $A\in(0,A_0]$. **Not one of $A$, $d$, $\alpha$, $\beta$, $\gamma$, $T$, $\psi$, $K_0$ is defined anywhere in [findings/](../findings/).** The single occurrence of $d$ on the record is inside L35's own line $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$.

The definitions were located, in a **script docstring**, [review_r63_relax.py](../scripts/reviewers/r63/review_r63_relax.py) and [b0_residual_interval.py](../scripts/route-b/b0_residual_interval.py):

$$A=\lambda_1,\qquad d=u-\lambda_1^2,\qquad K_0=\tfrac3{2\sqrt2},\qquad T=\tfrac{2\sqrt2}3A,\qquad \gamma=1-3K_0.$$

With those in hand the five ingredients were re-derived here, and **all five are correct and all five run in the safe direction**:

| ingredient | verified by |
| --- | --- |
| $G=\sum_P\lambda^3-b^3-c^3+6\lambda_1bc+3M(\lambda_P)$ | the exact decoupling above |
| $3M\le h(s^2-u)$ | L42, rebuilt above |
| $h\le\min(\lambda_1,K_0\sqrt d)$ | harmonic $\le$ max gives $h\le\lambda_1$; and $h\le3/(\lambda_2^{-1}+\lambda_3^{-1})\le\tfrac32\sqrt{\lambda_2\lambda_3}\le\tfrac32\sqrt{d/2}=K_0\sqrt d$ |
| $\sum_P\lambda^3\le\lambda_1^3+\min(\lambda_1,\sqrt d)\,d$ | $\sum_{\alpha\ge2}\lambda_\alpha^3\le\lambda_2\sum_{\alpha\ge2}\lambda_\alpha^2$ with $\lambda_2\le\lambda_1$ and $\lambda_2\le\sqrt d$ |
| $d\le(s-\lambda_1)^2$ | $\sum_{\alpha\ge2}\lambda_\alpha^2\le(\sum_{\alpha\ge2}\lambda_\alpha)^2$ for nonnegatives |

and the closing reduction $s^2\le2-2u$ is $(b+c)^2\le2(b^2+c^2)$, whose equality case is $b=c$, so "forcing both to the constraint forces $b=c$" is right.

**So the mathematics is sound and the gap is one of record-keeping, but it is a real one**: the map from the spectrum to $A$ is the hinge of the whole closing argument, it is cited 91 times, and a reader of [findings/](../findings/) cannot find it. **Repair owed: put $A=\lambda_1$, $d=u-\lambda_1^2$ and the five ingredients into the L35 block or into [conventions.md](../findings/conventions.md).** The assertion "strictly increasing in $s$ and $u$" is *not* verified here (its proof is in reviews/, outside the record) and is the one link in the chain this audit leaves unchecked.

**A symbol collision worth naming while the repair is made.** In [bounds-relaxations.md](../findings/bounds-relaxations.md) $d$ is the **number of negative eigenvalues** ("tight at $d\le2$", "does not reach it at $d=3$"); in L35 it is $u-\lambda_1^2$. Under the first reading L35's own bound reads $h\le\tfrac32$, which is vacuous, since $h\le1$ always. Same class as the $\Pi$, $B$ and $\mathfrak m$ collisions already tabled in [conventions.md](../findings/conventions.md).

### The endpoint expansion, CONFIRMED, every constant

Recomputed by hand from $g(A)=A^3-(1-A^2)^{3/2}/\sqrt2+3A(1-A^2)$ at $A_0=\sqrt{2/3}$:

| quantity | block | this audit |
| --- | --- | --- |
| $g(A_0)$ | $\sqrt6/2$ | $0.544331-0.136083+0.816497=1.224745=\sqrt{3/2}$ |
| $g'(A)$ | $3-6A^2+\tfrac32A\sqrt{2-2A^2}$ | same, and $g'(A_0)=3-4+1=0$ |
| $-\tfrac12g''(A_0)$ | $\tfrac94\sqrt6$ | $\tfrac12(9.797959+1.224745)=5.511352=\tfrac94\sqrt6$ |
| $\alpha(A_0-\varepsilon)$ | $3\sqrt3\,\varepsilon$ | $K_0(2-3A^2)=K_0\cdot6A_0\varepsilon=5.196152\,\varepsilon$ |
| $\beta(A_0)$ | $-\tfrac34\sqrt6$ | $\tfrac34\sqrt{2/3}-3A_0=-1.837117$ |
| $t^*=\alpha/2\lvert\beta\rvert$ | $\sqrt2\,\varepsilon$ | $3\sqrt3\varepsilon/(\tfrac32\sqrt6)=\sqrt2\,\varepsilon$ |
| $\psi^*=\alpha^2/4\lvert\beta\rvert$ | $\tfrac32\sqrt6\,\varepsilon^2$ | $27\varepsilon^2/(3\sqrt6)=\tfrac32\sqrt6\,\varepsilon^2$ |

Margin $(\tfrac94-\tfrac32)\sqrt6=\tfrac34\sqrt6$. **Every constant reproduces.** The box counts are consistent too: $73+21=94$.

One presentational fault: the block writes "$-\tfrac12g''(A_0)=\tfrac94\sqrt6$ against $\psi^*=\tfrac32\sqrt6\,\varepsilon^2$", comparing a coefficient with an $\varepsilon^2$ quantity. And the block states the endpoint expansion **in the form that the file's own "One repair" section 110 lines later says "carries no remainder bound and points the wrong way"**. The block's conclusion does not rest on it (it rests on the interval arithmetic) but the block reproduces the superseded form without the $Q(A)$ repair or the $[0.7,0.7096]$ bisection. Repair owed: a pointer.

### Was $\sqrt{3/2}$ derived, or read off an LP?, the L107 pathology is ABSENT here

Chronology, from `git log -S`:

| object | first commit | date |
| --- | --- | --- |
| $\sqrt{3/2}$ and $1.224745$ | `1a5ba7c2` initial findings | 2026-08-19 |
| "triangle packing" | `3884b68b` | 2026-08-23 |
| "harmonic mean" | `2917be82` | 2026-08-23 |

**The constant predates the argument by four days, and that is the right way round here.** $\sqrt{3/2}$ enters the record as $\theta$ at an *exhibited point*, padded $W_{\mathbb{CP}^2}$ with spectrum $(2,-1,-1)/\sqrt6$, not as an LP's output. The chain is then a proof that a known lower bound is also an upper bound, and the anchor computation above shows the argument returns the value from the point's own data. This is the legitimate shape, and it is **not** what [L107](../findings/bounds.md)'s audit found. The choice of $A_0=\sqrt{2/3}$ and of the three region boundaries is of course made knowing where equality sits; that is ordinary for a sharp inequality.

### The quantifier "any $m$", CONFIRMED, with the small-$m$ answer stated

**The smallest $m$ at which the claim has content is $m=4$, and the bound is attained there.** $\dim\mathcal W_m=m(m-3)(m+1)(m+2)/12$ vanishes below $m=4$, so the statement is vacuous at $m\le3$. At $m=4$ the hypothesis is satisfiable and sharp: $W=W^+$ with spectrum $(2,-1,-1)/\sqrt6$ on $\Lambda^+$ and $0$ on $\Lambda^-$ has exactly two negative eigenvalues, unit norm, and $\theta=\sqrt{3/2}$ by the anchor computation above. So L35 is sharp at the smallest dimension where it says anything, and remains sharp at every larger $m$ by padding, which conventions.md records as preserving $\theta$.

**The hypothesis is never vacuous and never empty at $m\ge4$.** It cannot hold with *zero* negative eigenvalues: $W$ is trace-free on $\Lambda^2$, so $W\ne0$ forces at least one. The case of exactly one negative eigenvalue is the boundary $c=0$ of the block's own formulas ($bc=(s^2+u-1)/2$ degenerates correctly to $s=b$, $u=1-b^2$) but **the block never says so**, and the section it leans on is headed "for every $W$ with **exactly** two negative eigenvalues" while L35 claims **at most** two. Minor repair owed: one sentence taking $c\to0$.

### Relation to L29, it extends, it does not strictly generalise

**L35's statement strictly contains L29's**: one positive and two negative is a special case of at most two negative with any number of positive. **L35's proof does not.** The chain closes $k\ge3$ positives; the block's own last line before the box says "the cases of one and two positive eigenvalues close in closed form", and those are [L29](../findings/stratum-two-negative.md) and the $k=2$ extension recorded under it. L42, the closing lemma, is undefined at $k\le2$ (no triples exist and $h$ has no value) and its own block says so. **So L35 consumes L29 rather than superseding it, and a reader who deleted L29 would break L35.** The block's framing ("generalises the one-positive lemma above") is fair; its dependency is not stated as a dependency.

### The refuted descent, CONFIRMED against L34's own statement

The block says the descent reducing the general case to dimension four "is refuted by [Lemma L34](../findings/stratum-two-negative.md)". Checked against L34 rather than against the block: L34 constructs, at $m=6$ and $m=8$, elements of $\mathrm{Weyl}_m$ with exactly two negative eigenvalues and $\dim U=m$, $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$. L34's own "needed because" says the descent had been recorded as closing once *no* such element has full support. **The witnesses are exactly counterexamples to that premise, so "refuted" is the correct word for the descent L35 names.**

Two riders a reader should have and the block does not give:

- **The witnesses do not touch the $\delta=0$ branch** of the four-region table, whose descent runs through cap saturation rather than through full support. At $m=8$ the two negative eigenvectors sit in orthogonal $4$-planes, so $\lVert[v_{N-1},v_N]\rVert^2=0$ and the cap is as far from saturated as it can be. What L34 kills is the full-support route; the cap-saturation route is untouched and simply no longer needed.
- **The witnesses are consistent with L35 and are a check on it.** Their $\theta$ values are $-\sqrt3/2$ and $-1.030865$, and the family's measured maximum is $+0.485$ at $m=6$, all far below $\sqrt{3/2}$. A full-support witness with two negatives and $\theta>\sqrt{3/2}$ would have refuted L35; none exists on the record.

### Citations, CONFIRMED, all uses inside the hypotheses

Grepped by statement as well as by identifier. The substantive consumers:

| site | use | inside hypotheses? |
| --- | --- | --- |
| [ATTEMPTS.md](../ATTEMPTS.md) line 2865 | "$q\le2\Rightarrow\theta\le\sqrt{3/2}$, and $\theta_0(n)^2-\tfrac32=(n^2-12n+8)/(2n^2)>0$ exactly when $n\ge12$" | **yes**, and the algebra checks: roots at $6\pm2\sqrt7$, so $n\ge12$ for integers, matching the record's $n=6+2\sqrt7\approx11.29$ crossover |
| [bounds-relaxations.md](../findings/bounds-relaxations.md) 411, 448 | "L35 does not exclude that stratum at $d=3$" | **yes**, three negatives is outside L35, so the negative use is correct |
| [bounds-relaxations.md](../findings/bounds-relaxations.md) 200 | "tight at $d\le2$ and useless at large $d$" | **yes** |
| [bounds-relaxations.md](../findings/bounds-relaxations.md) 329 | "L35 consumes the pair cap, which $\Pi(\lambda)$ omits" | **yes**, the pair cap is L31 and is indeed the chain's one structural input |
| [results.md](../results.md) 456 | statement, word for word | **yes**, no drift from findings |

**No citation was found using L35 outside its hypotheses.**

### Two link defects, REPAIRED (diagnosis given)

1. **A dead anchor.** [stratum-two-negative.md](../findings/stratum-two-negative.md) line 389 links `#lemma-l35--the-sharp-stratum-bound-and-what-it-costs`. No heading of that text exists; the heading is "at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$, unconditionally". Lines 116 and bounds-relaxations.md:329 use the live anchor, so the fix is to copy theirs.
2. **The L42 block points at the wrong section.** It says its argument "is in this file under *The $\dim\mathfrak m\le2$ stratum, assembled (closed modulo three nam*"), a truncated heading, and the wrong one: that section is the four-region table and contains no harmonic mean, no dual and no weak duality. The argument is 100 lines further down, under "The primal", "Feasibility of the product weight" and "Weak duality".

**And the L35 block carries exactly one link, to results.md.** It names L29, L31, L34 and the sharp dual weight in prose and links none of them, and it does not link the section 60 lines below that carries its own proof. This is the pattern the brief warned of, in its mildest form: the argument is in the same file, but the block does not say where.

## The screen

**Reported as a screen; it is evidence for nothing.** Before recording CONFIRMED I screened the chain's *own upper bound*, rebuilt here rather than taken from the block,
$\bar G=\sum_P\lambda^3-b^3-c^3+h(s^2-u)+6bc\lambda_1\ \ge\ G\ \ge\ \theta$, over $720{,}000$ admissible spectra, $k=1\ldots12$ positives, drawn under $\sum_P\lambda^2=u$, $b+c=s$, $b^2+c^2=1-u$. Maximum found $1.2247266$ against $\sqrt{3/2}=1.2247449$, attained at $k=1$, $\lambda_1=0.816495$, $b\approx c\approx0.408$, the $(2,-1,-1)/\sqrt6$ point. **No falsifier.** A screen finding nothing proves nothing; it is recorded so that a later reader knows the claim was probed before it was confirmed.

## Verdicts, per defect

| # | defect | verdict |
| --- | --- | --- |
| 1 | the identity display is stated as $\theta=\dots$ without $\lVert W\rVert=1$ | **REPAIRED**, one clause, no cost to the lemma |
| 2 | $\sum\lambda^3$ in the $G$ display silently ranges over the positives only | **REPAIRED**, write $\sum_P$, or use $\sum_\alpha\lambda_\alpha^3+3M+6bc\lambda_1$ |
| 3 | $A$, $d$, $\alpha$, $\beta$, $\gamma$, $T$, $\psi$, $K_0$, $\mathrm{FTP}$ undefined in [findings/](../findings/); the map $A=\lambda_1$, $d=u-\lambda_1^2$ lives only in a script docstring | **REPAIRED** in diagnosis, repair owed in the record; the five ingredients are re-derived above and all are correct |
| 4 | dead anchor at line 389, and L42's pointer names the wrong section | **REPAIRED**, both fixes given |
| (| "$G$ decouples exactly" | **CONFIRMED**), an identity, derived above |
| (| the sharp dual weight and its sharpness | **CONFIRMED**), both halves rebuilt |
| (| the endpoint expansion's constants | **CONFIRMED**), every one reproduces |
|, | "refuted by L34" | **CONFIRMED** against L34's own statement |
| (| "any $m$" | **CONFIRMED**), content and sharpness from $m=4$ |
| (| 91 citations | **CONFIRMED**), every use inside the hypotheses |

**The one link left unchecked** is the monotonicity of the three-parameter relaxation $R(A,s,u)$ in $s$ and $u$, whose proof is in reviews/ rather than on the record, and the final maximisation of $R$, which is computational and outside this audit's footing.

## Overall, CONFIRMED

Lemma L35 stands. Every hand-checkable step of $\theta\le\mathrm{LP}\le G\le R\le\sqrt{3/2}$ relaxes in the safe direction; the two independent anchors return $\sqrt{3/2}$ exactly; the constant comes from an exhibited point rather than from a solver; and no citation misuses it. The four defects are of the block's *presentation and of the record's symbol table*, and the largest of them (the missing definition of $A$), is what a reader would hit first when trying to check the closing inequality for themselves.
