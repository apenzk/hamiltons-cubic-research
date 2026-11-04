# Review r497, Lemma L1

**Target**: [Lemma L1](../findings/problem.md), "the granted diagonal case, repaired at the threshold dimensions", in [findings/problem.md](../findings/problem.md), the canonical block at line 398 together with the discursive block at line 378 that carries the same argument in three numbered steps.

**Reviewer**: r497, independent adversarial auditor, working cold. Replacement for r496, which died without writing to disk.

**Footing**: analysis only. No searches, sweeps, censuses or falsifier hunts. **L1's exact root isolation and validated interval arithmetic were not re-run.** What is audited is the reduction to them and the honesty of the block's claims. Two screens were run on objects built for the purpose, both reported as screens and never as evidence for a positive claim.

**Sources used**: [findings/conventions.md](../findings/conventions.md), the block itself, [references/jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md), narrow `grep`/`sed` slices of the local `pdftotext` extraction (never the PDF), the three cited scripts read but not executed, and [ATTEMPTS.md](../ATTEMPTS.md).

## VERDICT: PLAUSIBLE

**The mathematics reproduces and I believe the conclusion. The block does not state the result it proves.** Three of its five load-bearing sentences are wrong as written, one of them defining an optimisation problem whose value is *below* the line the block certifies against it, and each is repaired by a hypothesis that exists in the scripts' docstrings and is absent from the record. Under the record's own label rule the block is also mislabelled.

| step | verdict |
| --- | --- |
| 1. the $n=14$ half, exact endpoint evaluation | **CONFIRMED**, and the interior-maximum worry is answered by Jäger himself. Independently reproduced |
| 2. the $n=12$ corner elimination, mechanism | **CONFIRMED**. The $\mathop{\mathrm{tr}}S^3$ floor does force the flat spectrum |
| 2'. the $n=12$ moment problem, as stated | **REFUTED as written.** The stated $F(v)$ has value $\approx1/\sqrt{12}$, strictly below $\varphi(v)$ on almost the whole range |
| 3. the duality step | **CONFIRMED**, and stronger than the block claims: weak duality suffices, so no constraint qualification is owed |
| 4. "machine-checked", "ten subintervals" | **CONFIRMED as arithmetic**, misleading as scope |
| 5. the census, "nothing else binds above $n=12$" | **REFUTED as written.** The census found a genuine residual and the block conceals its discharge |
| 6. the `Lemma` label | **wrong** under the record's own rule, but for Gate 2, not for interval arithmetic |

---

## 0. Two premises of my brief are false of the file

**"L1 cites L18 and L20."** It cites neither, nor any other numbered result. `sed -n '378,408p'` over both blocks returns zero occurrences of `L18` or `L20`. L1's real inputs are Jäger's Chapter 3 machinery plus one unnumbered argument in [ATTEMPTS.md](../ATTEMPTS.md) (§5 below). **This is good news**: [Lemma L20](../findings/route-a.md)'s audited defects, its one unproved input [L21](../findings/route-a.md), and a final-step witness that does not exist at odd $n$, do not propagate into L1. The dependency runs the other way: [L18](../findings/problem.md) and [L19](../findings/problem.md) lift Jäger's chapters *off* the diagonal locus and consume his results, they do not feed L1.

**"If L1 fails, the programme's starting hypothesis is not established at its own threshold."** The record says otherwise, and it is right: [results.md:84](../results.md) and [findings/INDEX.md:19](../findings/INDEX.md) both carry the diagonal case at every $n\ge4$, both parities, by [Lemma L57](../findings/problem.md), this record's own theorem, independent of Jäger. **L1 is not load-bearing.** Its value is as a correction offered to the setter, exactly as the block says.

## 1. What is claimed, and at which $n$, the two readings do differ, and the record uses the wrong one

The brief asks whether the claim is *Theorem A holds for $n\ge12$* or *Jäger's proof extends to $n\ge12$*. The record makes both claims in different files, and only the second is what the argument delivers unaided.

- [ATTEMPTS.md:801](../ATTEMPTS.md): *"**Consequence.** Theorem A holds for even $n=12$ and $n=14$"*, the strong reading.
- [run_jaeger_e5a_interval.py](../scripts/runs/run_jaeger_e5a_interval.py)'s closing print is scrupulous: *"Lemma 3.5.6 holds at $n=12$; **with the exhaustive Chapter 3 dimension census**, Jäger's Theorem A extends to even $n=12$ and $n=14$."*

What the computations establish is **Jäger's Lemma 3.5.6 at $n=12$ and $n=14$**. Theorem A at those dimensions follows only through the census, and the census does not come out clean (§5). So the honest statement is *Jäger's proof extends to even $n\ge12$, one step of §3.6 excepted, that step being replaced by an argument of this record's own*, which is materially weaker than "Theorem A holds", because it inherits the replacement argument's status. The block states neither; it states the conclusion with no scope at all.

## 2. The $n=14$ half, CONFIRMED, and the interior-maximum worry is Jäger's own and is answered

The brief's concern was that a quantity negative at the endpoints of a case is negative throughout only if an interior maximum is ruled out, and that the block states nothing that rules one out. **The block indeed states nothing. Jäger does.**

Reading his Lemma 3.5.6 directly (extraction lines 4178–4232), the argument is: under Assumption 2 the quantity $\mathrm{RHS}$, viewed as a function of $t=\mathop{\mathrm{scal}}$ on $\bigl[\tfrac{8n+9}{16}\hat\theta_0(n),\,(n-3)\tilde\theta_0(n)\bigr]$, has nonnegative maximum. He then computes

$$\mathrm{RHS}''(t)=-\tfrac{263}{72}\tfrac{n-3}{n^2(n-2)}\Bigl[1-\tfrac{3t}{n\hat\theta_0(n)}\Bigr],$$

observes $\tfrac{3t}{n\hat\theta_0(n)}\ge\tfrac{3(8n+9)}{16n}\ge1$ on the interval, and concludes verbatim: *"Thus, RHS is convex, and hence, it attains its maximum on the boundary."* **Case 1 and Case 2 are those two boundary points.** For a convex function the maximum *is* at an endpoint, so endpoint evaluation is exactly right and no interior maximum can exist.

**And the licence survives the lowered dimensions, which nobody in the record checks.** Convexity needs $\tfrac{3(8n+9)}{16n}\ge1$, which is $1.641$ at $n=12$ and $1.621$ at $n=14$, comfortably true, and free of the $n\ge16$ in Assumption 1. **I checked this by hand and it passes.** It should be one sentence in the block, because it is the only thing standing between "negative at two points" and "negative throughout".

**Reproduced independently.** I rebuilt $\mathrm{RHS}$ from the extracted display and evaluated it at Jäger's own two endpoints with his own rounded inputs ($v=\mathop{\mathrm{tr}}S^4=16/(8n+9)$, $y=(\mathop{\mathrm{tr}}S^3)^2=1/n$, positive-term coefficient $2$):

| $n$ | 12 | 13 | 14 | 15 | 16 |
| --- | --- | --- | --- | --- | --- |
| max over the two cases | $+0.05627$ | $+0.01658$ | $-0.01741$ | $-0.04685$ | $-0.07259$ |

**$n\ge14$, exactly as claimed.** The block's *"Evaluating his own expression exactly, at his own case endpoints … already reaches $n=14$"* is confirmed, with margin $-0.0174$. The script's method, `sympy.simplify(e).is_negative` on an exact expression in rationals and radicals, genuinely is symbolic certification, so *"with the signs certified symbolically rather than numerically"* is accurate.

**One gap that is real, in the other variable.** Convexity licenses pinning $t$ at an endpoint. Nothing licenses pinning $v$ at its ceiling, which is what [certify()](../scripts/lib/run_jaeger_threshold.py) does, it evaluates at $v=E(n)$ alone, and $\mathrm{RHS}$ depends on $v$ non-monotonically a priori (through $x=nv-1$, which pushes it down, and through the positive term, which pushes it up). *Screened*: over $20\,001$ points of $[1/n,E(n)]$ at $n=12,13,14,16$ the maximum sits at $v=E(n)$ in every case, so the practice is right. **It is unargued, and it is the same class of omission as the $t$-endpoint one.** Settling it analytically needs a sign for $\partial_v\mathrm{RHS}$ on the range; that is a derivation, not a computation, and it is owed.

## 3. The $n=12$ half, the mechanism is CONFIRMED, and I can say why

The brief asks which operator $S$ is, what constraints it carries, and whether the $\mathop{\mathrm{tr}}S^3$ floor genuinely forces a flat spectrum. **The block answers none of these.** From the source (extraction lines 1720–1760):

$$|W|:=W_++W_-,\qquad \mathrm{Ric}:=\mathrm{Ric}(|W|),\qquad r:=\lVert\mathrm{Ric}\rVert,\qquad S:=\mathrm{Ric}/r.$$

$|W|$ is the *entrywise absolute value* of the diagonal Weyl operator, so its sectional entries are $\lvert w_{ij}\rvert\ge0$ and $\mathrm{Ric}_{ii}=\sum_{j\ne i}\lvert w_{ij}\rvert\ge0$. Hence:

> **$S$ is diagonal, positive semidefinite, of rank at most $n$, with $\mathop{\mathrm{tr}}S^2=1$, so every eigenvalue lies in $[0,1]$.**

That settles the floor. With $S\succeq0$ and $\mathop{\mathrm{tr}}S^2=1$, Cauchy–Schwarz gives $1=(\mathop{\mathrm{tr}}S^2)^2=\bigl(\sum\lambda_i^{3/2}\lambda_i^{1/2}\bigr)^2\le\mathop{\mathrm{tr}}S^3\cdot\mathop{\mathrm{tr}}S$, and $\mathop{\mathrm{tr}}S\le\sqrt{n\mathop{\mathrm{tr}}S^2}=\sqrt n$, so $(\mathop{\mathrm{tr}}S^3)^2\ge1/n$, **which is exactly Jäger's floor**, recovered from scratch. Both Cauchy–Schwarz equalities bind simultaneously only when every $\lambda_i$ is equal and the rank is $n$, i.e. $\lambda_i=1/\sqrt n$. At that spectrum $\mathop{\mathrm{tr}}S^4=1/n$, its own floor, against a ceiling of $16/(8n+9)\approx2/n$.

**So the block's sentence (*"the floor forces the flat spectrum, which drags the ceiling down with it"*), is exactly true, and it is an equality case, not an approximation.** The corner $\bigl(y=1/n,\;v=E(n)\bigr)$ really is outside the moment body. The direction is right too: with $u=(\mathop{\mathrm{tr}}S^3)^2$, the positive term $\sqrt{(v^2-u^2)/(1-u)}$ has $\partial_u$ numerator $u^2-2u+v^2<0$ on the range, so it is decreasing in $u$, a *lower* bound on $\mathop{\mathrm{tr}}S^3$ is what tightens it, which is what the certificate supplies. Jäger's own $(3.16)$ makes the same monotonicity argument.

**Every load-bearing number reproduces.** Rebuilding the expression independently at $n=12$, $v=E(12)=709/4680$:

| quantity | mine | record |
| --- | --- | --- |
| $\mathrm{RHS}$ at Jäger's corner $y=1/12$ | $+0.022061$ | $+0.02206$ ([ATTEMPTS.md:786](../ATTEMPTS.md)) |
| $y$ at which $\mathrm{RHS}=0$, what the contradiction needs | $0.099330$ | $0.09933$ ([ATTEMPTS.md:797](../ATTEMPTS.md)) |
| $y$ the certificate delivers, $\varphi(E)^2$ | $0.111287$ | $0.11285$ (SLSQP route) |
| $\mathrm{RHS}$ there | $-0.021841$ | $-0.02184071$ ([run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py)) |
| $n=13$ with sharpened constants | $-0.012079$ | $-0.01208$ ([ATTEMPTS.md:786](../ATTEMPTS.md)) |

## 4. The moment problem as the block states it, REFUTED as written

This is the sharpest defect. The block writes, twice ([problem.md:388](../findings/problem.md) and [:406](../findings/problem.md)):

> *"Pushing forward to $\mu=\sum\lambda_i^2\delta_{\lambda_i}$ (a probability measure since $\lVert S\rVert=1$), turns the requirement into $F(v)=\min\{\mathbb E[\lambda]:\mathbb E[\lambda^2]=v,\ \mathbb E[\lambda^{-2}]\le n\}$ … yielding the certified line $\varphi(v)=\tfrac7{10}v+\tfrac{8647}{38000}\le\mathop{\mathrm{tr}}S^3$."*

The pushforward is right: $\mathbb E[\lambda]=\mathop{\mathrm{tr}}S^3$, $\mathbb E[\lambda^2]=\mathop{\mathrm{tr}}S^4$, and $\mathbb E[\lambda^{-2}]$ counts the nonzero eigenvalues, so $\le n$. **But the problem as written has no constraint on the support of $\mu$, and without one its value is not $\varphi$-bounded.**

*Screened*, $n=12$, by linear programming over measures on a grid (the problem is an LP in the masses, so this is exact up to discretisation):

| $v$ | $\varphi(v)$ | $F(v)$, support $\subseteq(0,1]$ | $F(v)$, support $\subseteq(0,10]$ |
| --- | --- | --- | --- |
| $1/12$ | $0.285886$ | $0.288675$ | $0.288675$ |
| $0.120$ | $0.311553$ | $0.314023$ | $0.292189$ |
| $709/4680$ | $0.334219$ | $0.336549$ | $0.295292$ |

The mechanism is transparent: an atom at large $\lambda$ with mass $\varepsilon$ buys $\varepsilon\lambda^2$ of the $\mathbb E[\lambda^2]$ budget at a cost of only $\varepsilon\lambda$ in the objective, and simultaneously *relieves* the $\mathbb E[\lambda^{-2}]\le n$ constraint. As the cap grows, $F(v)\downarrow1/\sqrt{12}=0.288675$ for **every** $v\ge1/12$. So for the problem the block writes down,

> $$\varphi(v)>F(v)\quad\text{for every }v>0.0873,$$

i.e. on all but the leftmost fifth of the range $[10/81,709/4680]$ the argument actually uses. **The certified line is not a lower bound for the stated $F$.**

**It is a lower bound for the right object, and the code knows it.** [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py)'s docstring states the pointwise hypothesis as *"$h(\lambda):=\lambda-\alpha\lambda^2+\beta\lambda^{-2}\ge\gamma$ **on $(0,1]$**"*, and [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py)'s docstring says *"$S\ge0$, $\lVert S\rVert=1$, at most $n$ eigenvalues **in $[0,1]$**"*. With those two facts (both true of the real $S$, both derived in §3 above), the screen confirms $\varphi\le F$ throughout, with slack $2.3$–$2.8\times10^{-3}$, tightest at $v=1/12$ where $F=1/\sqrt{12}$ exactly. **So the defect is in the record, not in the mathematics.**

**And the omission is not cosmetic, positivity alone is load-bearing for the certificate's feasibility.** The dual point is $\alpha=7/10$, $\beta=1/152$, $\gamma=613/2000$, with $\gamma-12\beta=8647/38000$ (I verified this rationally: $(613\cdot19-3\cdot1000)/38000=8647/38000$). If the spectrum were allowed into $[-1,0)$, the pointwise inequality at $\lambda=-1$ would force $\gamma+\beta\cdot(-1)\le-1-\alpha$, which combined with $\gamma-12\beta=0.2276$ demands $\beta\ge0.175$, and $\beta\ge0$ with $\beta$ *small* is what the $\mathbb E[\lambda^{-2}]\le n$ step needs. **The certificate is infeasible without $S\succeq0$.** A reader given only the block cannot know that, and cannot check the quartic, because the interval on which it must be nonnegative is never named.

**Required repair.** Both copies of the sentence must read

> $F(v)=\min\{\mathbb E[\lambda]:\mathop{\mathrm{supp}}\mu\subseteq(0,1],\ \mathbb E[\lambda^2]=v,\ \mathbb E[\lambda^{-2}]\le n\}$, the support bound because $S=\mathrm{Ric}(|W|)/\lVert\mathrm{Ric}(|W|)\rVert$ is positive semidefinite with $\mathop{\mathrm{tr}}S^2=1$,

and the block must say what $S$ is. As written, step 2 asserts a false inequality about a well-defined object.

## 5. The duality step, CONFIRMED, and the block undersells it

The brief asks whether convexity is of the right object, whether strong duality is invoked, and whether a constraint qualification is needed and checked. Working it out:

- **The object is right.** $F$ is the value of a linear programme over measures, linear objective $\int\lambda\,d\mu$, linear constraints $\int d\mu=1$, $\int\lambda^2d\mu=v$, $\int\lambda^{-2}d\mu\le n$, over the convex cone $\mu\ge0$. The value of an LP as a function of its right-hand side is convex, so $F$ is convex **in $v$**, which is the variable the "supporting line valid at every value at once" claim is about. *A convex moment body would not have sufficed*, and the block's phrasing is loose about which; the underlying fact is the sharper one.
- **Only weak duality is used, so no constraint qualification is owed.** Any $(\alpha,\beta,\gamma)$ with $\beta\ge0$ and $\lambda-\alpha\lambda^2+\beta\lambda^{-2}\ge\gamma$ on the support gives, on taking expectations and using $\mathbb E[\lambda^{-2}]\le n$, $\mathop{\mathrm{tr}}S^3\ge\gamma+\alpha v-n\beta$ for every feasible $\mu$. That is valid whatever the duality gap. **The block's step 2 does not need Slater, and it does not need $F$ to be attained.**
- **Strong duality is claimed but only as commentary.** The script notes the dual optimum reproduces the primal floor to $10^{-6}$ and calls it strong duality. Nothing rests on it: it is a cross-check, and correctly so.
- **"Supporting line" is the wrong word, harmlessly.** My screen shows $F$ has slope $\approx0.694$ across the range while $\alpha=0.7$, and the line stays $2.3$–$2.8\times10^{-3}$ strictly below $F$ everywhere on it. So it is a *valid affine minorant*, touching nowhere in the range, which is what the argument needs, and strictly safer than a supporting line would be.

**Verdict on step 3: sound, and its validity is more robust than the block's own account of it.**

## 6. The census, REFUTED as written, and this is the block's most serious concealment

The block says, flatly and with no qualification:

> *"A census of every dimension hypothesis in Jäger's Chapter 3 confirms nothing else binds above $n=12$."*

The census exists and is well done. **It does not say that.** [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py)'s docstring and [ATTEMPTS.md:799](../ATTEMPTS.md) both report it in full:

> *"$n\ge1,\dots,9$ (all satisfied); $k\ge12$ in Lemma 3.5.4, satisfied and exactly the dimension in question; the two $n\ge15$ conclusions replaced here; and $m\ge8$ three times, twice as the statement of Theorem 3.0.2 and Assumption 1, and **once as a genuine use, the ideal-induction step in §3.6**. That step is precisely the one the six-line graph argument … (Result 5b) already replaces."*

So the census **found a fourth hypothesis that genuinely binds**, and it is discharged not by observation but by *replacing a step of Jäger's proof with an argument of this record's own*. The L1 block:

- does not mention that a residual was found;
- does not mention §3.6 or the ideal-induction step;
- does not cite Result 5b, or link to it, or name its status.

**That is an unstated load-bearing input in a block whose only purpose is to say what closes $n=12,14$.** It also changes the claim's character: with the residual, L1 is not "Jäger's own threshold was rounding slack" but "Jäger's threshold was rounding slack in §3.5, *and* his §3.6 endgame is replaced here".

**Result 5b's own status compounds it.** From [ATTEMPTS.md:629](../ATTEMPTS.md): Jäger's Lemma 3.6.10's two vanishing traces say the positive-entry graph $G$ is a disjoint union of cliques with $\bar G$ triangle-free, forcing two equal blocks. *The argument looks right to me*, $G$ a union of $k$ cliques makes $\bar G$ complete $k$-partite, and triangle-freeness forces $k\le2$, with the count $2^{n-1}$ of admissible graphs matching. But its recorded warrant is *"Verified by exhaustive brute force over all graphs at $n=4,5,6$"*, it carries **no result number**, it appears in **no index**, it has **no Gate 2 verdict**, and its own precision note says it *"replaces §3.6 after Lemma 3.6.10 rather than the whole section"*. A numbered `Lemma` should not rest on an unnumbered paragraph in [ATTEMPTS.md](../ATTEMPTS.md) without saying so.

## 7. "Machine-checked rather than swept", the arithmetic is honest, the scope is not

**The number checks out; I withdrew a suspicion here.** The block's *"ten subintervals, each with a proven negative bound"* looked like it might have been carried over from [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py)'s eleven-point grid, which is precisely the sweep that script flags as insufficient (*"REMAINING for a fully machine-checked proof: replace that last one-dimensional monotonicity/Lipschitz step by interval arithmetic"*). It was not. [ATTEMPTS.md:797](../ATTEMPTS.md) records the actual run: *"ten subintervals cover the range, each with a proven negative upper bound, the worst being $-6.27\times10^{-5}$."* The count is the adaptive output. **And it cross-validates**: ten boxes over a range of width $0.028$ gives box width $0.0028$, and with $\lvert d\mathrm{RHS}/dv\rvert\le7.44$ that is $\approx0.021$ of variation per box, so an enclosure ceiling of $-6.3\times10^{-5}$ against a true maximum of $-0.0218$ is the expected interval-dependency blowup. Both numbers are consistent with each other, which is a real check.

The methods are proof-grade. `mpmath.iv` at 40 digits rounds outward, so a negative upper endpoint on every box is a theorem about the whole range, not a sample. `sympy.real_roots` on an exact quartic is exact.

**What is not honest is the scope of the sentence.** *"So both dimensions are machine-checked rather than swept"* reads as a claim about L1. It is a claim about the last one-dimensional step at $n=12$. Not machine-checked, and each a place a reader would want to look:

- the transcription of Jäger's Lemma 3.5.5 display into `rhs_sym`, nobody in the record has re-derived it, and the `pdftotext` extraction is garbled at exactly that display;
- the convexity in $t$ that licenses the endpoint evaluation (§2), inherited from Jäger and never re-checked at the lowered dimensions;
- the monotonicity in $v$ that licenses pinning $v=E(n)$ (§2), never argued;
- the sharpened ceiling $E(n)=\frac{8n^2-41n+49}{4(n+1)(n-2)(n-3)}$ and the sharpened coefficient $\frac{2\sqrt2}{\hat\theta_0(n)}\sqrt{1-v}$, attributed in the script to Jäger's Lemmas 3.3.6 and 3.5.5 before he rounds them, and **not mentioned in the block at all** even though the $n=12$ closure needs them;
- the census and Result 5b (§6);
- and at $n=14$ nothing is interval-checked, because nothing needs to be, [run_jaeger_e5a_interval.py](../scripts/runs/run_jaeger_e5a_interval.py) hardcodes `N = 12`.

**The block also mis-attributes the $n=12$ gain.** It says *"$n=12$ needs one further observation"*, the moment body. The script's own ladder is $(0)\to n\ge14$, $(0)+(1)+(2)\to n\ge13$, $+(3)\to n\ge12$, **three** further sharpenings, two of them simply un-rounding Jäger's own constants. My screen agrees: with $(0)$ alone $n=12$ gives $+0.0563$, with $(1)+(2)$ it improves only to $+0.0221$, and $(3)$ carries it to $-0.0218$. All three are needed.

## 8. The label, `Lemma` is wrong, but not for the reason the brief supposes

The record's rule ([INDEX-results.md](../findings/INDEX-results.md)): *"**Lemma** is proven, Gate 1 and Gate 2 passed. **Observation** is verified numerically at the dimensions stated."*

**Interval arithmetic is not what disqualifies it.** Validated interval arithmetic with outward rounding, and exact real-root isolation over $\mathbb Q$, are *proofs*, computer-assisted, checkable, and stronger than most pen-and-paper case analyses. A result whose final step is ten certified enclosures is proven, and [r277](REVIEW_r277.md) already reached this conclusion. `Observation` would be a demotion the mathematics does not deserve.

**What disqualifies it is the second clause.** L1 has never passed Gate 2, its [INDEX-results.md](../findings/INDEX-results.md) row carries no verdict, and [problem.md:380](../findings/problem.md) says in terms *"NEVER AUDITED"* and *"it is not worth reviewer time"*. So the label asserts something about process that is false, and [ELIM-canon.md's Stale-5](ELIM-canon.md) flagged exactly this. **My recommendation: keep `Lemma`, and carry this review as its Gate 2 with the repairs of §§4 and 6 applied first.** A `Lemma` whose block asserts a false characterisation of its own moment problem should not hold the label until that sentence is fixed.

## 9. What the record says elsewhere, and what is stale

I grepped [findings/](../findings/), [plan.md](../plan.md), [results.md](../results.md) and [ATTEMPTS.md](../ATTEMPTS.md). The dimension threshold is stated consistently everywhere (even $n=12,14$, odd $n$ untouched) and I found no file contradicting it. Four other things are wrong:

1. **The load-bearingness contradiction is still live.** [findings/INDEX.md:45](../findings/INDEX.md) says *"Lemma L1, the diagonal case at $n=12,14$, **never audited and load-bearing**"*; [problem.md:380](../findings/problem.md) and [LEDGER.md:52](../findings/LEDGER.md) say *"nothing in this project depends on Lemma L1 … it is not worth reviewer time"*. [plan-verification.md:140](../plan-verification.md) and [ROUND_L00.md](../verification/ROUND_L00.md) both diagnosed this on 2026-09-01 and **neither fixed it**. The file that owns the result is right and [INDEX.md:45](../findings/INDEX.md) is the stale line.
2. **Three stale pointers to a moved proof.** The canonical block records its own move: *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy."* Still pointing at [results.md](../results.md): [INDEX.md:19](../findings/INDEX.md) (*"that proof lives only in results.md, not in findings/"*), [LEDGER.md:19](../findings/LEDGER.md) (*"whose proof sits in results.md"*), [diagonality.md:77](../findings/diagonality.md) (*"results.md's Lemma L1"*).
3. **[INDEX.md:19](../findings/INDEX.md) says L1 *"has no ledger row, so its Gate 2 status is unrecorded"*.** [LEDGER.md:52](../findings/LEDGER.md) is a ledger row for L1. Half the sentence is false; the Gate 2 half is true.
4. **The citation count in my brief is inflated by a label collision.** [REVIEW_r324.md](REVIEW_r324.md) uses "L1" throughout for a *different* result (a deficiency identity), with no relation to result 1. Anyone auditing L1's blast radius by grepping `L1` will over-count. Worth a line in [INDEX-traps.md](../findings/INDEX-traps.md), alongside the $B$, $M$ and $\mu$ collisions already tabled in [conventions.md](../findings/conventions.md).

## 10. Repairs owed, in order

1. **Fix the moment problem in both copies** ([problem.md:388](../findings/problem.md), [:406](../findings/problem.md)), add $\mathop{\mathrm{supp}}\mu\subseteq(0,1]$, and say that $S=\mathrm{Ric}(|W|)/\lVert\mathrm{Ric}(|W|)\rVert$ is positive semidefinite with $\mathop{\mathrm{tr}}S^2=1$. **As written the step is false.**
2. **Fix the census sentence.** Say the census found a genuine $m\ge8$ use at §3.6's ideal-induction step, and that it is discharged by Result 5b, with a link, and with 5b's status (unnumbered, brute-forced at $n=4,5,6$, no Gate 2) stated.
3. **State the two convexity/monotonicity facts** that license the endpoint evaluations: Jäger's $\mathrm{RHS}''\ge0$ in $t$, which survives at $n=12,14$ since $3(8n+9)/(16n)\ge1.62$ there, and the unargued claim that $v=E(n)$ maximises in $v$.
4. **Credit sharpenings (1) and (2)**, the unrounded $E(n)$ and the unrounded Lemma 3.5.5 coefficient. The $n=12$ closure needs all three, not one.
5. **Rescope the machine-checked sentence** to the one-dimensional remainder at $n=12$, which is what it describes.
6. **Retire [INDEX.md:45](../findings/INDEX.md)'s "load-bearing"** and repoint the three stale [results.md](../results.md) references.
7. **Number Result 5b**, or state in L1 that it is unnumbered.

## 11. Screens run, and what they are not

Both are screens of claims recorded above, on objects constructed for the purpose, run in seconds. **Neither is evidence for a positive claim, and no script of the record was executed.**

- **The moment-problem screen** (§4): an LP over discretised measures at $n=12$, under two support caps. It shows the stated $F$ falls below $\varphi$; the *analytical* reason is given in §4 and does not depend on the screen.
- **The RHS screen** (§§2–3): an independent reimplementation of Jäger's displayed expression, used to reproduce the record's figures and to check where the maximum in $v$ sits. It reproduces $+0.02206$, $-0.01208$, $0.09933$ and $-0.02184$, but a reproduction is a cross-check on transcription, not a verification of Jäger's derivation of the display, which remains unaudited.

**What I could not settle without computation, and did not run.** Whether $\partial_v\mathrm{RHS}>0$ throughout $[1/n,E(n)]$ for all $n\ge12$, the missing licence of §2. This is a derivation rather than a search and should be done by hand. Nothing else in this audit is blocked.
