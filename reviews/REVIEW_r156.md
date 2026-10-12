# Review r156, the gap floor closed form, the calibration defect, the 3a/3b split

Derivation only. No script was run, no machinery rebuilt, no eigendecomposition computed. Every number below is hand arithmetic on a closed form derived here from the definition of $\mathrm{Weyl}_n$ and of $Q$, and every recorded number quoted is used as a *check on my derivation*, never as an input to it.

## Verdict table

| Claim | Statement audited | Verdict |
|---|---|---|
| 1 | entries and multiplicities at $p=3$ | **CONFIRMED**, derived independently |
| 1 | the normalisation | **CONFIRMED**, and confirmed three further ways the commit did not use |
| 1 | $\mathrm{floor}(n)$ as an arithmetic formula for $p=3$ | **CONFIRMED** for $n\ge7$; **WRONG at $n\le6$**, by a factor $3/2$ at $n=6$ |
| 1 | "the floor is at $p=3$" | **REFUTED**. $S^2\times S^{n-2}$ is on the record's own graded list and is strictly lower at every $n\ge6$ |
| 1 | $\sim2/n^{3/2}$ | **REFUTED**. The true rate is $2\sqrt3\,n^{-2}$, wrong exponent, not a wrong constant |
| 1 | "polynomial decay is what a per-$n$ statement can absorb" | **DECORATION**, and the decoration is the part that is wrong |
| 2 | $\mathrm{tr}\,\mathring W=0$ on $S^2_0$ | **CONFIRMED**, derivable in three lines, and already quoted in the record's own transcription |
| 2 | Lemma 3.2 degenerates | **CONFIRMED and UNDERSTATED**, it is *vacuous*, not merely uncalibrated |
| 3 | the $6=6$ tie and its tie-break | the **tie is an artefact**; 3a should be $3\times1\times1=3$, and then no tie-break is needed |

---

## The closed forms this review derives, since everything else follows from them

Take $\Lambda$ to be the hollow symmetric $n\times n$ vertex matrix of a diagonal Weyl operator, so $W$ is diagonal in the $\phi_{ij}$ basis with $W_{(ij),(ij)}=\Lambda_{ij}$. For $S^p\times S^q$, $p+q=n$, the Einstein condition $(p-1)a=(q-1)b$ and the Weyl projection $\Lambda_{ij}=K_{ij}-\frac{\mathrm{Ric}_{ii}+\mathrm{Ric}_{jj}}{n-2}+\frac{\mathrm{Scal}}{(n-1)(n-2)}$ give, after the constant $-1/(n-1)$ is scaled out and the sign flipped to the record's $\theta>0$ convention,

$$\Lambda_{ij}=-\tfrac q{p-1}\ (i,j\in B_1),\qquad -\tfrac p{q-1}\ (i,j\in B_2),\qquad +1\ (\text{mixed}).$$

Row sums vanish identically ($(p-1)\cdot\frac{-q}{p-1}+q=0$) so this is in $\mathrm{Weyl}_n$ for **every** $p,q\ge2$. Three consequences, all derived here and none of them in the record:

**(i) Criticality is exact for every $p,q\ge2$.** For diagonal $W$, $Q(W)=W^2+W^\#$ is diagonal with $Q_{ij}=\Lambda_{ij}^2+(\Lambda^2)_{ij}$, because $(W^\#)_{(ij),(ij)}=\sum_{k\ne i,j}\Lambda_{ik}\Lambda_{jk}$ from $c_{abg}$ being supported on triangles of pairs. Evaluating the three cases:

$$Q_{B_1}=(p-1)\tfrac{q^2}{(p-1)^2}+q=\tfrac{q(n-1)}{p-1},\qquad Q_{B_2}=\tfrac{p(n-1)}{q-1},\qquad Q_{\text{mixed}}=1-p-q=-(n-1),$$

i.e. $Q(\Lambda)=-(n-1)\Lambda$ **exactly**, with no projection step. So $S^p\times S^q$ is an exact critical point at every $p,q\ge2$, and $p=1$ is excluded only because its row sums fail. $p=2$ is the true boundary of the family, not $p=3$.

**(ii) Norm and $\theta$ in closed form.**

$$\lVert\Lambda\rVert^2=\frac{pq(n-1)(n-2)}{2(p-1)(q-1)},\qquad \theta(S^p\times S^q)=\frac{n-1}{\lVert\Lambda\rVert}=\sqrt{\frac{2(p-1)(q-1)(n-1)}{pq\,(n-2)}}.$$

**(iii) The gap in closed form.** The smallest modulus among $\{q/(p-1),\,p/(q-1),\,1\}$ is $p/(q-1)$ exactly when $p<q$ (both $p/(q-1)\le1$ and $p(p-1)\le q(q-1)$ reduce to $p\le q$), and is $1$ when $p=q$. So for $p<q$,

$$\boxed{\ \mathrm{gap}(S^p\times S^q)=\sqrt{\frac{2p(p-1)}{q(q-1)(n-1)(n-2)}}\ }$$

and for $p=q$, $\mathrm{gap}=\sqrt{2(n-2)/(n^2(n-1))}$.

### Six independent confirmations of the normalisation, against numbers the commit never used

The convention is: $\lVert W\rVert^2=\sum_{i<j}\Lambda_{ij}^2$, each unordered pair once, matching [run_graded_gap_at_fixed_n.py](../scripts/runs/run_graded_gap_at_fixed_n.py)'s pair-indexed matrix. It is pinned by these, all reproduced from the formulas above by hand:

| quantity | derived here | on record | source |
|---|---|---|---|
| $\theta(S^3\times S^3)$ | $5/\sqrt{22.5}=1.054093$ | $1.054093$ | [nondegeneracy.md](../findings/nondegeneracy.md) |
| $\theta(S^2\times S^{10})$ | $\sqrt{11\cdot9}/10=0.994987437$ | $0.994987437$ | [graded-half.md](../findings/graded-half.md) |
| $\theta(S^3\times S^9)$ | $\sqrt{352/270}=1.141798451$ | $1.141798451$ | [graded-half.md](../findings/graded-half.md) |
| $\theta(S^4\times S^8)$ | $\sqrt{462/320}=1.201561484$ | $1.201561484$ | [graded-half.md](../findings/graded-half.md) |
| $\theta(S^5\times S^7)$ | $\sqrt{528/350}=1.228239158$ | $1.228239158$ | [graded-half.md](../findings/graded-half.md) |
| $\theta(S^6\times S^6)$ | $\sqrt{550/360}=1.236033081$ | $1.236033081$ | [graded-half.md](../findings/graded-half.md) |
| balanced gap | $\sqrt{2(n-2)/(n^2(n-1))}$ | $\sqrt2(n-2)/(n\sqrt{(n-1)(n-2)})$ | [nondegeneracy.md](../findings/nondegeneracy.md) |
| $\theta^2(S^2\times S^6)$ | $1-1/(n-2)^2=35/36$ | $35/36$ | [target.md](../findings/target.md) |

Nine digits at five separate points, from a construction that shares nothing with the code. **The normalisation is right.** The factor-of-two scare recorded in `4b95a64` was real and was fixed correctly; what two agreeing data points failed to catch is everything below.

---

## Claim 1, entries and multiplicities: CONFIRMED

At $p=3$, $q=n-3$: $-q/(p-1)=-(n-3)/2$ with multiplicity $\binom32=3$; $-p/(q-1)=-3/(n-4)$ with multiplicity $\binom{n-3}2$; $+1$ with multiplicity $pq=3(n-3)$. All three match the commit exactly. Total $3+\binom{n-3}2+3(n-3)=\binom n2$ ✓.

### Which entry is smallest at $p=3$, the record's general mechanism is false, the $p=3$ instance is right only for $n\ge7$

The record's sentence *"the vertex entries are $-q/(p-1)$, $-p/(q-1)$ and $1$, so the smallest modulus is $p/(q-1)$"* is a general claim and it is **false at every balanced product**, where the smallest modulus is the mixed entry $1$ (since $p/(p-1)>1$). It happens not to bite because the balanced case is handled by its own recorded formula.

At $p=3$ specifically, comparing $\{(n-3)/2,\ 3/(n-4),\ 1\}$:

| $n$ | entries | smallest | formula's claim |
|---|---|---|---|
| $5$ | $1,\ 3,\ 1$ | $1$ | $3$, **wrong** |
| $6$ | $3/2,\ 3/2,\ 1$ | $1$ | $3/2$, **wrong** |
| $7$ | $2,\ 1,\ 1$ | $1$ | $1$, right (tie) |
| $\ge8$ |, | $3/(n-4)$ | right |

So $\mathrm{floor}(n)$ as written is **invalid for $n\le6$**: at $n=6$ it returns $1.5/\sqrt{22.5}=0.316228$ against the true $1/\sqrt{22.5}=0.210819$, a factor of $3/2$. The commit's stated domain is "every $n$" and "positive at every $n$"; the correct domain is $n\ge7$. No quoted number is affected (the quoted set starts at $n=8$) but the $n=6$ value collides with the record's own $S^3\times S^3$ gap $0.210818511$ two paragraphs above, which is the same point.

### The arithmetic for $n\ge8$: CONFIRMED, and the formula has a far cleaner equivalent

$\tfrac34(n-3)^2+\tfrac{9(n-3)}{2(n-4)}+3(n-3)$ factorises to $\dfrac{3(n-1)(n-2)(n-3)}{4(n-4)}$, so

$$\mathrm{floor}_{p=3}(n)=\frac{2\sqrt3}{\sqrt{(n-1)(n-2)(n-3)(n-4)}},$$

which is the $p=3$ case of the general gap formula above. I verified this against all six values the commit quotes: $0.119523$, $0.062994$, $0.038925$, $0.026444$, $0.019139$, $0.011358$ at $n=8,10,12,14,16,20$, all six reproduced exactly. **The arithmetic is right.** Recording the factorised form would be an improvement; it makes both defects below visible on inspection.

### The asymptotic $\sim2/n^{3/2}$: REFUTED, wrong exponent

From the factorised form the rate is immediate:

$$\mathrm{floor}_{p=3}(n)=\frac{2\sqrt3}{\sqrt{(n-1)(n-2)(n-3)(n-4)}}\ \sim\ \frac{2\sqrt3}{n^2}\approx\frac{3.4641}{n^2}.$$

Not $2n^{-3/2}$. The claim is off by a factor $n^{1/2}$ and diverges from the truth without bound:

| $n$ | $\mathrm{floor}(n)$ | $2/n^{3/2}$ | ratio |
|---|---|---|---|
| $10$ | $0.062994$ | $0.063246$ | $1.004$ |
| $12$ | $0.038925$ | $0.048113$ | $1.236$ |
| $20$ | $0.011358$ | $0.022361$ | $1.969$ |
| $100$ | $3.6445\times10^{-4}$ | $2.0\times10^{-3}$ | $5.487$ |

**This is exactly the failure mode the brief flagged.** $2/n^{3/2}$ agrees with the truth to $0.4\%$ at $n=10$ and to $24\%$ at $n=12$ (the two recorded values) and is wrong by a factor $5.5$ at $n=100$ and unboundedly wrong thereafter. It is a fit to the two check points wearing the notation of an asymptotic. The one-line derivation that would have caught it is that $\lVert\Lambda\rVert^2$ is dominated by the three entries of size $(n-3)/2$, giving $\lVert\Lambda\rVert\sim\frac{\sqrt3}2n$ against a numerator $\sim3/n$.

*Disagreement stated explicitly:* I do not accept "asymptotically $2/n^{3/2}$" in the commit message or "$\sim\frac2{n^{3/2}}$" in [nondegeneracy.md](../findings/nondegeneracy.md). Both should read $2\sqrt3\,n^{-2}$.

### "The floor is at $p=3$": REFUTED

**$p=2$ is admissible, and the record already knows it.** Three separate arguments, any one sufficient:

1. **Derived.** By (i) above, $Q(\Lambda)=-(n-1)\Lambda$ exactly at $p=2$, I checked it entry by entry at $n=6$: block-$1$ pair $1\cdot16+4=20=-5\cdot(-4)$ ✓, block-$2$ pair $3\cdot\frac49+2=\frac{10}3=-5\cdot(-\frac23)$ ✓, mixed $1-6=-5$ ✓. It is an exact critical point.
2. **Graded.** The negative graph of $W$ is $K_{2,n-2}$, so $\mathfrak m=\mathbb R^2\otimes\mathbb R^{n-2}$ and $\mathfrak h=\mathfrak{so}(2)\oplus\mathfrak{so}(n-2)$, with $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ and $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$. $(\mathfrak{so}(n),\mathfrak{so}(2)\oplus\mathfrak{so}(n-2))$ is a symmetric pair (the real Grassmannian $\mathrm{Gr}_2(\mathbb R^n)$), exactly as for $p\ge3$.
3. **On record, repeatedly.** [fence-posts.md](../findings/fence-posts.md) states the graded set as *"the two-block sphere products together with $\mathbb{CP}^{n/2}$"* and tabulates $S^2\times S^6$ at $n=8$ and $S^2\times S^8$ at $n=10$ as nondegenerate graded critical points with orbit dimensions $12$ and $16$, my $\dim\mathfrak m=pq=16$ at $n=10$ ✓. [graded-half.md](../findings/graded-half.md) lists the $2+10$ split at $n=12$ with $\theta=0.994987437$. [nondegeneracy.md](../findings/nondegeneracy.md) itself discusses "the whole $S^2\times S^k$ family" and its $\theta\uparrow1$. **$p=2$ was never excluded by an argument. It was excluded by `for p in range(3, n//2+1)` in [run_graded_gap_at_fixed_n.py](../scripts/runs/run_graded_gap_at_fixed_n.py), and the closed-form commit inherited the loop bound as if it were a hypothesis.**

**And $p=2$ is strictly the minimiser, by monotonicity, at every $n$.** From the boxed formula with $q=n-p$,

$$\mathrm{gap}^2(S^p\times S^{n-p})=\frac{2}{(n-1)(n-2)}\cdot\frac{p(p-1)}{(n-p)(n-p-1)},$$

in which $p(p-1)$ strictly increases and $(n-p)(n-p-1)$ strictly decreases as $p$ runs $2,3,\dots,\lfloor n/2\rfloor-1$. **The gap is strictly increasing in $p$ on the unbalanced range, so the minimum over two-block products is at $p=2$ for every $n\ge6$, with no sweep.** The recorded observation that the balanced product sits at the *largest* gap is the same monotonicity read at the other end.

The corrected floor over two-block products:

$$\mathrm{floor}_{\text{2-block}}(n)=\mathrm{gap}(S^2\times S^{n-2})=\frac{2}{(n-2)\sqrt{(n-1)(n-3)}}\ \sim\ \frac2{n^2},$$

against the recorded claim, at the tabulated dimensions:

| $n$ | recorded floor ($p=3$) | true $p=2$ value | ratio |
|---|---|---|---|
| $8$ | $0.119523$ | $0.056344$ | $2.12$ |
| $10$ | $0.062994$ | $0.031497$ | $2.00$ |
| $12$ | $0.038925$ | $0.020101$ | $1.94$ |
| $14$ | $0.026444$ | $0.013937$ | $1.90$ |
| $20$ | $0.011358$ | $0.006182$ | $1.84$ |
| $\to\infty$ | $2\sqrt3/n^2$ | $2/n^2$ | $\sqrt3$ |

So the tabulated table in [nondegeneracy.md](../findings/nondegeneracy.md) is wrong in both columns: at $n=10$ the smallest gap is $0.031497$ attained at $S^2\times S^8$, and at $n=12$ it is $0.020101$ attained at $S^2\times S^{10}$. The $\times$-2-ish discrepancy is *not* the factor-of-two normalisation error the commit reports catching; that one was in $\lVert\Lambda\rVert$ and is genuinely fixed. This is a second, independent factor near two, in the choice of attaining point, and the two recorded check values could not have separated them because both are $p=3$ values.

**A second family is missing too.** The record's own graded list is two-block sphere products **together with $\mathbb{CP}^{n/2}$**, and [run_graded_gap_at_fixed_n.py](../scripts/runs/run_graded_gap_at_fixed_n.py) contains no $\mathbb{CP}^m$ member. I have not derived $\mathbb{CP}^m$'s smallest nonzero modulus here, it is outside the brief and would need the reducible-isotropy spectrum, not the two-eigenvalue projector ansatz, since [graded-half.md](../findings/graded-half.md) records that $\mathfrak u(m)$ splits. **Flagged as an open scope gap, not as a refutation.** Until it is closed, "the floor among the named families" is a claim about a strict subset of the named families.

### "Decays polynomially, which a per-$n$ statement can absorb": decoration

What item 3b needs from this paragraph is $\mathrm{floor}(n)>0$ at each fixed $n$. A per-$n$ statement absorbs *any* positive floor (exponentially small ones included) so polynomiality contributes nothing to the stated purpose. It would become load-bearing only if some downstream estimate had to beat the gap at a rate; nothing on record does. **So the rate is decoration**, and it is the decoration, rather than the load-bearing part, that turned out to be wrong, which is a fair description of how the error survived: nothing depended on it, so nothing tested it.

---

## Claim 2, the calibration defect: CONFIRMED, and understated

### $\mathrm{tr}\,\mathring W=0$ on $S^2_0$ is a theorem, and the record already held it

Two derivations, neither needing a computation.

*From the definition.* For $A_{ijkl}=\tfrac12(R_{ikjl}+R_{iljk})$ acting on $S^2$, $\mathrm{tr}_{S^2}=\sum_{i,j}A_{ijij}=\tfrac12\sum_{i,j}(R_{iijj}+R_{ijji})=-\tfrac12\mathrm{Scal}$ (normalisation checked against $A=\mathrm{id}$, which returns $n(n+1)/2$). The splitting $S^2=S^2_0\oplus\mathbb Rg$ costs $\langle\mathring R g,g\rangle/\lVert g\rVert^2=\mathrm{Scal}/n$. For a Weyl tensor both $\mathrm{Scal}$ and $\mathrm{Ric}$ vanish, so $\mathrm{tr}_{S^2_0}\mathring W=0$ and hence $\bar\lambda=0$. Correct for every Weyl tensor, every $n$.

*From the record's own transcription.* Cheng–Wang eq. (2.2), on page 5 of the stored [paper.txt](https://arxiv.org/abs/2508.11226) and reachable from the record's [notes.md](../references/cone-conditions-2025-second-kind/notes.md), reads $\mathrm{Scal}=n(n-1)\bar\lambda$. **$\bar\lambda=0\iff\mathrm{Scal}=0$ is one line of the paper being cited.** *Question (a) hit:* "verified to $10^{-16}$ at $n=5,6,7,8$" measured an identity the record had transcribed from the source eight minutes earlier, in `79b4ac8`. This is a measurement standing in for a citation, which is the failure mode the plan's own standing rule names.

### The degeneracy is total: the hypothesis is unsatisfiable, not merely uncalibrated

The record says the $\theta(n,k)$ constants multiply zero, so the conclusion becomes $\sum_j\lambda_j\lvert S^jW\rvert^2\ge0$ under $\lambda_1+\lambda_2\ge0$. That reading stops one step early. Take the hypothesis on its own:

- $\bar\lambda=0$ means $\sum_{j=1}^N\lambda_j=0$, by definition of the average.
- Suppose $\lambda_1\ge0$. Then all $\lambda_j\ge0$ with zero sum, so $\mathring W=0$, so $W=0$ (as $\mathring W=0$ on $S^2$, using $\mathring W g=\mathrm{Ric}(W)=0$, and first Bianchi recovers $W$ from its symmetrisation).
- Suppose $\lambda_1<0$. Then $\lambda_2\ge-\lambda_1>0$, so every $\lambda_j\ge\lambda_2>0$ for $j\ge2$, giving $-\lambda_1=\sum_{j\ge2}\lambda_j\ge(N-1)\lambda_2$. With $-\lambda_1\le\lambda_2$ this forces $(N-2)\lambda_2\le0$, i.e. $N\le2$. But $N=(n+2)(n-1)/2\ge9$ for $n\ge4$. Contradiction.

**So on $\mathrm{Weyl}_n$ the cone condition $\lambda_1+\lambda_2\ge-2\theta\bar\lambda$ is satisfied only by $W=0$.** Lemma 3.2 is not a degenerate inequality; it is a statement about the empty set. Cheng–Wang's own Theorem 1.1 confirms this reading: its conclusion is "flat **or** a round sphere", and the scalar-flat branch of the hypothesis is precisely the flat alternative.

**Consequence for the grade.** The record's residue (*"what may survive is the mechanism, recalibrated against $\lVert W\rVert$"*), is not a partly-spent route. Replacing the hypothesis $\lambda_1+\lambda_2\ge-2\theta\bar\lambda$ by $\lambda_1+\lambda_2\ge-c\lVert W\rVert$ leaves nothing of Cheng–Wang beyond the split-off-the-bottom-two trick, which the record has already exercised with one eigenvalue; and the record's own accounting says the spectral constraints alone are short by a factor of $59$ at $n=12$. That is an untried estimate with no citation behind it, in the shape of an argument already known to fall far short.

*Disagreement stated explicitly:* the demotion is right in direction and too generous in degree. **3a should be `closes 3 × attackable 1 × margin 1 = 3`**, not $6$. "Attackable 2, partly spent, mechanism may survive" describes borrowing that is dead outright and a remnant that is untried and unpromising.

---

## Claim 3, the split and the grades

**The tie is an artefact of over-grading 3a.** With 3a at $3$ and 3b at $6$, the ordering is forced and the tie-break rule never fires. Judging the tie-break on its own terms anyway: "3b's obligation is a single named estimate" is a *true statement about the sentence* and a misleading one about the work, because the estimate quantifies over the full graded critical set, and the record simultaneously holds that this set is not characterised, $61$ distinct critical points inside one grading at $n=6$ against a $1$-dimensional invariant slice. "A single named estimate over an unenumerated set" is not obviously more attackable than a recalibration. It is defensible, but it should be stated with the set attached.

**3b's own grade survives this review.** Claim 1's defects are repairs to sub-step 1, not to the item: the corrected floor is still positive, still closed-form, still explicit, and now with a two-line monotonicity proof of where it is attained. Attackable $2$ stands.

**One inconsistency between plan and findings, worth fixing while 3b is open.** [plan.md](../plan.md) item 3b's falsifier reads *"an ungraded component with no spectral gap"*, while the whole line of work in [nondegeneracy.md](../findings/nondegeneracy.md) (and its falsifier), is about the **graded** critical set, closedness of the graded set being the missing piece. One of the two says the opposite of the other.

---

## Question (a), asserted as new, already held

| item | where it already was |
|---|---|
| the vertex entries $-q/(p-1),\,-p/(q-1),\,1$ | the paragraph immediately above the insertion, before `4b95a64`, the diff adds them back as the new derivation's content |
| $\bar\lambda=0$ for a Weyl tensor | Cheng–Wang eq. (2.2), in [paper.txt](https://arxiv.org/abs/2508.11226), stored by the previous-but-one commit |
| $S^2\times S^{n-2}$ as a graded critical point | [fence-posts.md](../findings/fence-posts.md) (twice), [graded-half.md](../findings/graded-half.md), [nondegeneracy.md](../findings/nondegeneracy.md), [target.md](../findings/target.md), [diagonal-half.md](../findings/diagonal-half.md), the closed form asserts it is not in the family |

The genuinely new content of `4b95a64` is the multiplicities and the closed form; the entries and the smallest-modulus mechanism were restated.

## Question (b), has the closed form changed what 3b owes?

**No, and the record's sentence is still the right one.** *"Whether the full graded critical set respects the floor is untouched"* remains exact.

But the closed form has produced **new evidence about the shape of that obligation, and it points the wrong way**: the floor moved by a factor near $2$ under the smallest possible enlargement of the named list (one member, $p=3\to p=2$) and a second named family, $\mathbb{CP}^{n/2}$, is still outside the computation. A floor that is not stable under adding one already-catalogued point is not a candidate for the true floor, and the honest statement of 3b's obligation should now say so. The falsifier is unchanged and correct.

## What I would change in the record

1. Replace $\sim2/n^{3/2}$ with $\sim2\sqrt3\,n^{-2}$, and replace the unfactored radical with $\mathrm{floor}_{p=3}(n)=2\sqrt3/\sqrt{(n-1)(n-2)(n-3)(n-4)}$.
2. State the general two-block gap $\sqrt{2p(p-1)/(q(q-1)(n-1)(n-2))}$ for $p<q$, note that it is strictly increasing in $p$, and record the floor as $2/((n-2)\sqrt{(n-1)(n-3)})$ at $S^2\times S^{n-2}$.
3. Correct the "attained at" column of the fixed-$n$ table to $S^2\times S^8$ and $S^2\times S^{10}$, with $0.031497$ and $0.020101$.
4. Restrict the $p=3$ formula's stated domain to $n\ge7$.
5. Drop "the smallest modulus is $p/(q-1)$" as a general sentence, or qualify it to $p<q$.
6. Note that $\mathbb{CP}^{n/2}$ is absent from the floor computation, so "among the named families" currently means a proper subset of them.
7. Regrade 3a to $3$, with the reason being vacuity of the cone condition on $\mathrm{Weyl}_n$ rather than uncalibrated constants; delete the tie-break sentence as unnecessary.
8. Reconcile 3b's falsifier in [plan.md](../plan.md) with the graded-set statement in [nondegeneracy.md](../findings/nondegeneracy.md).

*Reviewer r156. Log at [gate2_156.log](../agent_logs/gate2_156.log).*
