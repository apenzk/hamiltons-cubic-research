# REVIEW r473, Conjecture L16 (defect-penalty inequality)

**Verdict: PLAUSIBLE.** The inequality stands and its stated consequence (Conjecture A at $n\ge12$) follows. Eleven defects found in how it is stated, bounded and evidenced; one of them (F3), changes what the conjecture asserts.

Reviewer: r473. Brief: break Conjecture L16. Analysis only.

## Findings

### F1, the symbol $\kappa_n$ collides with [conventions.md](../findings/conventions.md)'s own fixed meaning, and L16's is not in the file

[conventions.md](../findings/conventions.md) fixes, under "Structure constants, brackets and padding":

> **The algebra's Killing constant** is $\kappa_n=(2n-1)(n-1)/4$. It has appeared under two symbols inside one file.

[Conjecture L16](../findings/problem.md) uses the same symbol for $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$. At $n=12$ these are $63.25$ and $-0.10158$. The conventions file carries explicit collision warnings for the letters $B$ and $M$; this one is unrecorded, and the file is where L16's $\kappa_n$ should be defined but is not. Every downstream file, [route-a.md](../findings/route-a.md), [second-order.md](../findings/second-order.md), [plan.md](../plan.md), [routes.md](../routes.md), restates $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ locally, which is the practice conventions.md exists to forbid.

**Severity: low on the mathematics, high on the record's own rule.** No derivation is wrong; the fix is one line in conventions.md.

### F2, the constraint set is written $\{|W|=1\}$, where $|\cdot|$ already carries two other meanings

L16 reads "$P(W)\le\theta_0(n)+\kappa_n\delta^2$ on $\{|W|=1\}$". In the same record:

- [conventions.md](../findings/conventions.md): "$\lvert W\rvert^2=4\lVert W\rVert_F^2$ relates the two $\Lambda^2$ normalisations in use". On that reading $\{|W|=1\}$ is $\{\lVert W\rVert_F=\tfrac12\}$, where $P$ is $\theta/8$ and the statement is false by a factor $8$.
- $\lvert W\rvert$ is also the **operator absolute value** $\sqrt{W^2}$, the meaning it carries in $W_-=\tfrac12(\lvert W\rvert-W)$, which is the very definition $\delta^2$ is built from, three clauses later in the same sentence of L16.

$\theta_0(n)$ and $\theta=P/\lVert W\rVert^3$ are both defined against $\lVert\cdot\rVert$, and [Jäger's Theorem A](../findings/problem.md) is quoted at $\lVert W\rVert=1$, so the intended set is $\{\lVert W\rVert=1\}$. The slip is inherited from problem.md's "Critical-point structure" section, so it is record-wide rather than L16's alone.

**Severity: low mathematically, real for well-posedness.** Write $\lVert W\rVert=1$.

### F3, THE HEADLINE. L16 is not padding-stable above $\delta^2=\tfrac19$, so the whole $n\ge12$ family collapses to a dimension-free inequality the record has never tested

**The algebra, one line.** Substituting $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ into the bound and collecting on $\theta_0$,

$$\theta_0(n)+\kappa_n\delta^2=\theta_0(n)\big(1-9\delta^2\big)+9\sqrt{\tfrac32}\,\delta^2 .$$

$\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ is strictly increasing in $n$ with limit $\sqrt2$. So the right-hand side is

- **increasing in $n$** when $\delta^2<\tfrac19$,
- **constant in $n$, at the value $\sqrt{3/2}$,** when $\delta^2=\tfrac19$,
- **strictly decreasing in $n$** when $\delta^2>\tfrac19$.

**Why that is a falsifier and not a curiosity.** Padding preserves $P$ and $\delta^2$ **exactly**, [conventions.md](../findings/conventions.md) ("Padding commutes with $Q$, and preserves both the norm and $\theta$") and the L16 block's own "whose defect is exactly $1/9$ in every ambient dimension". So every unit Weyl tensor in dimension $m$ is simultaneously a test case for L16 at every $n\ge m$, with the *same* $(P,\delta^2)$ and a *moving* right-hand side. Taking $n\to\infty$ on the padded copies, **L16 for all $n\ge12$ implies the dimension-free inequality**

$$P(W)\ \le\ \sqrt2-9\big(\sqrt2-\sqrt{\tfrac32}\big)\,\delta^2(W)\ =\ \sqrt2-1.705218\,\delta^2(W)\qquad\text{on }\{\delta^2\ge\tfrac19\},$$

valid for every unit Weyl tensor in every dimension. The coefficient $1.705218$ is not new to the record, [route-a.md](../findings/route-a.md) proof of L134(b) writes "$\lvert\kappa_n\rvert\uparrow9(\sqrt2-\sqrt{3/2})=1.705218$, **the limit being the binding case**", but the record uses it only inside a *local* second-order expansion at the competitor. **The global consequence is nowhere on the record.**

**The region is non-empty, by the record's own witness.** [Post F59](../findings/route-a.md) exhibits a unit Weyl tensor with $\delta^2=\tfrac3{25}=0.12>\tfrac19$, hand-checked for unit norm and zero trace by [r433](REVIEW_r433.md), and cites a census maximum $\max\delta^2=0.125$ on $\mathbb R^8$. Padding those into large $n$ is free.

**What this does to the block's evidence.** The L16 block's stated defence is "a full adversarial battery at $n=12$ and $n=14$". Those are precisely the two dimensions where $\lvert\kappa_n\rvert$ is smallest, $0.1016$ and $0.3324$, against the binding $1.7052$. Screened arithmetic (seconds, on the closed forms only):

| $\delta^2$ | bound at $n=12$ | $n=14$ | $n=20$ | $n\to\infty$ |
| --- | --- | --- | --- | --- |
| $0$ | $1.236033$ | $1.261680$ | $1.307670$ | $1.414214$ |
| $\tfrac19$ | $1.224745$ | $1.224745$ | $1.224745$ | $1.224745$ |
| $\tfrac3{25}$ | $1.223842$ | $1.221790$ | $1.218111$ | $1.209588$ |
| $\tfrac14$ | $1.210635$ | $1.178576$ | $1.121089$ | $0.987912$ |

So on the half of the domain that matters, **the battery tested the conjecture at $6\%$ and $20\%$ of its binding strength.** On the other half ($\delta^2<\tfrac19$) the battery is on target, since there $n=12$ *is* the binding dimension.

**The falsifier, stated for a successor.** *Any* unit Weyl tensor, in *any* dimension $m\ge4$, with

$$\delta^2>\tfrac19\quad\text{and}\quad P>\sqrt2-1.705218\,\delta^2$$

refutes Conjecture L16 at all sufficiently large $n$, and no computation at $n=12$ or $n=14$ can see it. Concretely: $\delta^2=0.12$ needs $P>1.2096$; $\delta^2=0.15$ needs $P>1.1584$; $\delta^2=0.20$ needs $P>1.0731$; $\delta^2=0.25$ needs $P>0.9879$. For scale, $\mathbb{HP}^2$ sits at $P=1.115547$ with $\delta^2=0.031746$ ([graded-half.md](../findings/graded-half.md)). **The ceiling $\delta^2\le\tfrac14$ is unconditional**, $\mathrm{Alt}(W)=0$ for a Weyl tensor gives $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, and $\mathrm{Alt}$ is an orthogonal projection with $\lVert\lvert W\rvert\rVert=1$, so $\delta\le\tfrac12$, so the falsifier lives in a bounded window and is a finite search.

**Severity: this is the finding.** It does not refute L16. It shows the statement is strictly stronger than the record believes, that its stated evidence covers the easy half of its own domain, and that the binding instance is a dimension-free inequality nobody has written down.

### F4, the $\delta^2=\tfrac19$ level set is a padding fixed point, which is why the shape is forced, and the block gives the wrong reason

The block says $\kappa_n$ "is pinned by requiring equality at the $\mathbb{CP}^2$-type competitor" and that "the shape is forced, not fitted". The sharper statement F3 makes available: the coefficient $9=1/\delta^2_{\mathbb{CP}^2}$ is the **unique** slope for which the bound is *padding-consistent* at the competitor. Any other linear penalty would make the padded competitor an equality point at one $n$ and a violator or a strict interior point at the others. That is a real structural reason, stronger than "fitted to one point", and it belongs in the block.

### F5, the equality set is stated as two orbits and is correct only at even $n$

The block: "equality holds at both named maximizers by construction." At **odd** $n\ge13$ that is false, and problem.md knows it two hundred lines earlier:

> **Sharpness at even $n$ only.** ... $\theta_0$ is attained by $S^{n/2}\times S^{n/2}$ only when $n$ is even. At odd $n$ the best sphere product gives $\frac{2(n-1)(n-3)}{(n-2)(n+1)}<\theta_0(n)^2$.

[Lemma L57](../results.md) gives the diagonal maximum as $\Theta_n<\theta_0(n)$ strictly at odd $n$, and the non-diagonal side is conjecturally capped at $\sqrt{3/2}<\theta_0(n)$ for $n\ge12$. **So at odd $n\ge13$ the $\delta^2=0$ equality point does not exist**, and the equality set is (conjecturally) the $\mathbb{CP}^2$-type orbit alone. L16 the *inequality* survives; L16's *equality claim* does not, and neither the block, [results.md](../results.md)'s entry, nor [routes.md](../routes.md)'s R17 row ("sharp at both maximisers") carries the caveat.

Follow-on: at odd $n\ge13$ L16 has slack of at least $\theta_0(n)-\Theta_n$ on the whole diagonal locus, which is a fact any tightness argument must not assume away.

### F3a, the block's escape clause for the $n=8$ refutation gives the wrong reason, and is correct on a margin of $0.0098$

The block dismisses the known $n\le11$ refutation with: "the refutation needs the penalty's other sign, so it leaves the $n\ge12$ claim untouched." **That reason is not the operative one.** By F3, an $n=8$ violator $W_0$ transfers to every $n\ge12$ under padding exactly when $\delta^2(W_0)>\tfrac19$:

$$\big[\theta_0(n)+\kappa_n\delta_0^2\big]-\big[\theta_0(8)+\kappa_8\delta_0^2\big]=\big(\theta_0(n)-\theta_0(8)\big)\big(1-9\delta_0^2\big),$$

which is **negative** when $\delta_0^2>\tfrac19$, so a high-defect $n=8$ violator would refute L16 at every $n\ge12$ at once, sign of $\kappa_8$ notwithstanding.

The actual violator ([ATTEMPTS.md](../ATTEMPTS.md) Result 3) is a non-critical kink point with $P=1.221305$ and $\delta^2=0.101301$. Since $0.101301<\tfrac19=0.111111$, the transfer does not fire, screened: the padded bound is $1.225745$ at $n=12$ and $1.241473$ in the limit, against $P=1.221305$. **The claim survives, on $0.0098$ of defect.** And the record's own census puts $\max\delta^2=0.125$ at $n=8$ and $0.145$ at $n=12$ ([ATTEMPTS.md](../ATTEMPTS.md) Result 7), so objects on the wrong side of $\tfrac19$ are exactly where this violator was found.

**Rewrite the clause.** The correct statement is: *the $n=8$ violator has $\delta^2<\tfrac19$, so its padded copies fall under an $n$-increasing bound.* The sign of $\kappa_8$ is not what protects the claim.

### F3b, the record already names the object this falsifier lives on, and has not connected it

[ATTEMPTS.md](../ATTEMPTS.md) Result 7 closes: *"defect above $1/9$ occurs at critical points, but only at low $\theta$ so far (all known $\theta\ge1$ points still have $\delta^2\le1/9$, Fox extremal), so the object that matters is the **joint $(\theta,\delta^2)$ Pareto frontier** for critical points."* F3 says exactly what that frontier must clear, dimension-free: $\theta\le\sqrt2-1.705218\,\delta^2$ on $\{\delta^2\ge\tfrac19\}$. The two statements have never been put side by side, and the frontier's evidence ("so far", "all known") is a census, not a bound.

Result 7's own witness clears comfortably: the $\delta^2=3/25$ subalgebra critical point has $P=0.387298$ against a limiting bound of $1.209588$. The record quotes its margin as "$+0.83$ at $n=12$–$16$" without noting that the margin **decreases monotonically in $n$** and bottoms out at $0.822$.

### F6, [conventions.md](../findings/conventions.md) states $\Theta_n$'s odd value squared, and as written it exceeds $\theta_0(n)$

The object table's row:

> $\Theta_n$, the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $2(n-1)(n-3)/((n+1)(n-2))$ at odd $n$

The even entry is unsquared; the odd entry is the **square**. Every other file writes it that way:

| file | form |
| --- | --- |
| [results.md](../results.md) L57 | "$\Theta_n^2=2(n-1)(n-2)/n^2$ at even $n$ and $2(n-1)(n-3)/((n+1)(n-2))$ at odd $n$" |
| [problem.md](../findings/problem.md) | "$\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ $(n$ odd$)$" |
| [bispectral.md](../findings/bispectral.md) | "$\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$ **as [conventions.md](../findings/conventions.md) fixes it**" |

That last line is the damage: a file quotes conventions.md for a form conventions.md does not state. Read literally, conventions.md gives $\Theta_{11}=1.481481$ against $\theta_0(11)=1.219673$, the odd *diagonal* maximum above the *global* target, contradicting bispectral.md's "$\Theta_n<\theta_0(n)$ strictly" and [problem.md](../findings/problem.md)'s "sharpness at even $n$ only". The true value is $\Theta_{11}=\sqrt{40/27}=1.217161$.

**This is a hard error in the file the record designates as the single source for its constants.** It bears on L16 through F5: $\Theta_n$ is what the diagonal grant delivers, and whether L16 is tight at odd $n$ is decided by $\Theta_n$ against $\theta_0(n)$.

### F7, the two owed halves produce a statement about critical points; L16 as stated is pointwise, and the gap is not bookkeeping

[routes.md](../routes.md) R17 says L16 "owes two steps: the grant $J_5\ge0$ **at critical points** ... and the global closure comparing the scalar-large and defect-large regimes." [Lemma L18](../findings/problem.md)'s output is likewise a dichotomy over **critical points**: "every critical point clearing the threshold has either scalar curvature at least $(n+1)\tilde\theta_0(n)$, or defect bounded below."

Conjecture L16 is stated with **no criticality hypothesis**, [plan.md](../plan.md) I4 states it "on the unit sphere", and the block advertises the difference as the payoff ("zero-defect points fall under it with no criticality hypothesis").

**The two do not compose.** L16 is equivalent to $\max_{\lVert W\rVert=1}\Phi\le\theta_0(n)$ for $\Phi=P-\kappa_n\delta^2=P+\lvert\kappa_n\rvert\delta^2$ at $n\ge12$. A maximiser of $\Phi$ is **not** a critical point of $P$ (the two functionals differ by a nonnegative term with a nonzero gradient) and $\Phi$ is not differentiable at all where $W$ has a kernel, which is exactly where both equality points sit ([Lemma L17](../findings/route-a.md), and route-a.md's atom discussion). So there is no free reduction from the pointwise statement to critical points.

**What this does and does not cost.** It costs nothing for [Problem P](../README.md): Conjecture A is itself a critical-point statement, and R17's two halves reach it. It does mean **the two-half split is not exhaustive for L16 as written**, a third item is owed, either the reduction or an explicit downgrade of I4's theorem statement to critical points. The record's other split (I2/I3/I6, the α/β/γ scenario decomposition) *is* exhaustive for the pointwise statement, but is not a proof strategy: [plan.md](../plan.md) says outright that "I6 **is** the conjecture."

### F8, the claimed consequence, checked: L16 gives $P\le\theta_0(n)$, **not** $\theta\le\sqrt{3/2}$, and [plan.md](../plan.md) I7 says otherwise

**The implication that does hold.** For $n\ge12$, $\kappa_n<0$ and $\delta^2\ge0$, so L16 gives $P(W)\le\theta_0(n)$ for **every** unit Weyl operator, hence at every critical point, which is Conjecture A. That step is sound and needs no extra hypothesis. Sign check: $\theta_0(n)>\sqrt{3/2}\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.2915$, so $\kappa_n<0$ exactly on $n\ge12$, correct as stated, and it is the same polynomial the record derives four other ways.

**The implication that does not.** L16 does **not** yield $\theta\le\sqrt{3/2}$ on the non-diagonal critical set, and cannot: at a zero-defect point its right-hand side is $\theta_0(n)$, and $\theta_0(n)>\sqrt{3/2}$ on precisely the range $n\ge12$ where L16 is claimed. Zero-defect non-diagonal critical points exist, [problem.md](../findings/problem.md)'s subalgebra family "refute[s] the proposed zero-defect dichotomy", so the shortfall is not vacuous.

**The mis-citation.** [plan.md](../plan.md) I7 reads:

> **I7, the destination: $\theta\le\sqrt{3/2}$ on the compact non-pure set. No route known.** ... **What the record offers toward it, none of it a route:** ... [Conjecture L16](../findings/problem.md) **would give it outright** and is R17 ...

"it" is I7's destination, the $\sqrt{3/2}$ bound on the non-pure set. L16 does not give that. It gives the conjecture by the other road, bounding $P$ by $\theta_0(n)$ everywhere and never needing the non-pure/pure split. **Fix the line to say which statement L16 supplies.**

### F9, the citation audit: what leans on L16 without hedging

I grepped [findings/](../findings/), [plan.md](../plan.md), [routes.md](../routes.md), [results.md](../results.md), [ATTEMPTS.md](../ATTEMPTS.md) and [plan-verification.md](../plan-verification.md).

**Clean.** Every load-bearing citation names it "Conjecture L16" and every derived item states its dependence. [Lemma L133](../results.md) concludes only that "L16 is **not refuted** at its own conjectured maximiser", a negative, correctly stated. [Lemma L134](../findings/route-a.md) and the L135–L139 chain are marked "Gate 2 owed, so the range may be cited nowhere yet". [Lemma L19](../results.md) says "what is left is strictly weaker than Conjecture L16", which is a comparison, not a dependence. [plan-verification.md](../plan-verification.md) lists L16 under "no box: nothing to verify yet". **No Lemma rests on L16.**

**Two entries that overstate, neither of them a Lemma-on-Conjecture:**

1. [results.md](../results.md)'s summary table: *"The diagonal proof lifted off the diagonal locus | **Proven**, defect priced to one term (Lemmas 15, 17–19)"*. Two problems, both already known to the same file two hundred lines below: L15 is now an **Observation**, not a Lemma; and its "one term" claim is what was refuted, *"TWO OBSTRUCTIONS, NOT ONE ... The second is $X_{\mathrm{inv}}\succeq0$ ... refuted off [the diagonal locus]"* ([results.md](../results.md), [LEDGER.md](../findings/LEDGER.md)). The table row was not updated with the audit.

2. [results.md](../results.md)'s L16 entry: *"equality **exactly** at the sphere product and at the $\mathbb{CP}^2$-type competitor"*. "Exactly" is a claim about the whole equality set, stronger than problem.md's "equality holds at both named maximizers", unproven, and false at odd $n\ge13$ (F5). [routes.md](../routes.md) R17 repeats it as "sharp at both maximisers".

### F10, the two named convention traps, checked: L16's *statement* is immune, its *supporting lemmas* are not

The brief flags that the $W_-$ sign and $\mathrm{Alt}$'s $\tfrac13$ have each refuted results here. Both check out, and the outcome is worth stating because it is asymmetric.

**The $W_-$ sign does not reach L16.** Under the opposite convention $W_-'=\tfrac12(W-\lvert W\rvert)=-W_-$, so $\mathrm{Alt}(W_-')=-\mathrm{Alt}(W_-)$ and $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ is **unchanged**. L16 is a statement in $\delta^2$ alone and is therefore convention-free. What the convention does control is [Lemma L17](../findings/route-a.md)'s $d^+\delta^2=-2aF$, $F\ge0$, a one-sided inequality, exactly the case [conventions.md](../findings/conventions.md) says the collision bites. Since $\kappa_n<0$ at $n\ge12$, $\kappa_n\cdot d^+\delta^2\ge0$: the right-hand side of L16 rises to first order at the competitor while $P$ is stationary, which is what makes $u$ safe. **Under the flipped sign the same computation drops the right-hand side to first order and refutes L16 at $n\ge12$ on the spot.** So L16's truth is convention-free but the record's only proof of local safety at $u$ is not, and the block does not say so.

**$\mathrm{Alt}$'s $\tfrac13$ is load-bearing in the constant $9$, and silently.** With the projection convention, $\mathrm{Alt}(u_-)=a\star$, $a=\tfrac1{3\sqrt6}$, $\lVert\star\rVert^2=6$ give $\delta^2_{\mathbb{CP}^2}=6a^2=\tfrac19$, internally consistent, and the factor $9$ in $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ is exactly $1/\delta^2_{\mathbb{CP}^2}$. A file using the **unprojected** sum $R_{ijkl}+R_{iklj}+R_{iljk}$ would report $\delta^2=1$ at the competitor and would need $\kappa_n=(\sqrt{3/2}-\theta_0(n))$: a silent factor-$9$ divergence with no visible symptom, since the bound still passes at the competitor. Also load-bearing for the unconditional ceiling: $\mathrm{Alt}(W)=0$ for a Weyl tensor gives $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, and $\mathrm{Alt}$ being an orthogonal projection gives $\delta\le\tfrac12$, i.e. $\delta^2\le\tfrac14$, the record's own figure ([ATTEMPTS.md](../ATTEMPTS.md) Result 7). **Neither $\delta^2$ nor $\kappa_n$ is defined in [conventions.md](../findings/conventions.md)** (F1), which is where this pairing should be pinned.

### F11, minor

- **$\tilde\theta_0(n)$ is used undefined in canon.** [Lemma L18](../findings/problem.md)'s displayed conclusion reads "scalar curvature at least $(n+1)\tilde\theta_0(n)$". The symbol is Jäger's weaker odd-$n$ threshold, defined only in [ATTEMPTS.md](../ATTEMPTS.md) Results 2 and 6, and appears in neither [conventions.md](../findings/conventions.md) nor [problem.md](../findings/problem.md).
- **Nothing here is vacuous.** The right-hand side stays positive over the whole admissible range: $\theta_0(n)/\lvert\kappa_n\rvert\downarrow\sqrt2/1.705218=0.8294$, well above the ceiling $\delta^2\le\tfrac14$, so L16 never degenerates into "$P\le$ something negative" on any attainable defect.
- **The crossover is right.** $\theta_0(n)=\sqrt{3/2}\iff4(n-1)(n-2)=3n^2\iff n^2-12n+8=0\iff n=6\pm2\sqrt7$, so $\kappa_n<0$ exactly for $n\ge12$, matching the four other places the record derives the same polynomial.

## Verdict, PLAUSIBLE

**The statement is sound, the constant is right, and the claimed consequence follows, but the statement is sharper than the record thinks, its equality claim is wrong at odd $n$, and its evidence covers the easy half of its own domain.**

| question the brief asked | answer |
| --- | --- |
| Is anything citing L16 as proved? | **No.** No Lemma rests on it; every citation names it a Conjecture (F9). Two entries overstate around it, [results.md](../results.md)'s "Proven ... one term" row, superseded by its own audit, and its "equality **exactly**" claim. |
| Well posed and sharp? | Constants check ($\theta_0$, the crossover, $\delta^2_{\mathbb{CP}^2}=\tfrac19$, $\kappa_n$'s factor $9=1/\delta^2_{\mathbb{CP}^2}$). Two well-posedness defects: $\kappa_n$ collides with [conventions.md](../findings/conventions.md)'s Killing constant and is undefined there (F1); the constraint set is written $\{\lvert W\rvert=1\}$ where $\lvert\cdot\rvert$ carries two other meanings (F2). |
| Where is it an equality, is that recorded? | **Recorded wrongly.** Two orbits at even $n$; at odd $n\ge13$ the $\delta^2=0$ equality point does not exist, since $\Theta_n<\theta_0(n)$ (F5). The level set $\{\delta^2=\tfrac19\}$ is a padding fixed point, which is the real reason the shape is forced (F4). |
| Does it yield $\theta\le\sqrt{3/2}$ on the non-diagonal critical set? | **No, and it cannot**, at a zero-defect point its bound is $\theta_0(n)>\sqrt{3/2}$ for exactly $n\ge12$. It yields Conjecture A directly instead. [plan.md](../plan.md) I7 claims otherwise (F8). |
| Is the two-half split exhaustive? | **No.** Both halves are critical-point statements; L16 is pointwise, and $\Phi=P+\lvert\kappa_n\rvert\delta^2$ has neither the same maximisers as $P$ nor a derivative at the equality points (F7). |
| Does the record hold a counterexample or fence post? | **It holds the raw material and has not assembled it.** [Post F59](../findings/route-a.md)'s $\delta^2=\tfrac3{25}$ witness, the census maxima $0.125$ at $n=8$ and $0.145$ at $n=12$, and [ATTEMPTS.md](../ATTEMPTS.md) Result 7's "joint $(\theta,\delta^2)$ Pareto frontier" are the ingredients of F3's falsifier. None clears the bar; all are far below it. |

**Why PLAUSIBLE and not CONFIRMED.** F3 is not a refutation, every object the record holds clears the dimension-free bound, most of them by a wide margin. But the conjecture the record has been testing at $n=12$ and $n=14$ is, on $\{\delta^2>\tfrac19\}$, strictly weaker than the conjecture it has been asserting, by a factor of up to $17$ in the penalty coefficient. Until $\;P\le\sqrt2-1.705218\,\delta^2$ has been attacked on $\{\delta^2\ge\tfrac19\}$, "survived a full adversarial battery" overstates what is known.

**Why not REFUTED.** Nothing here contradicts the inequality. The equality-set error (F5), the wrong reason in the $n=8$ escape clause (F3a), the $\Theta_n$ error (F6) and the I7 mis-citation (F8) are all repairs to the record around a statement that stands.

## What to change, in order

1. **[conventions.md](../findings/conventions.md), $\Theta_n$ row**, the odd value is $\Theta_n^2$, not $\Theta_n$. As written it puts the odd diagonal maximum above $\theta_0(n)$, and [bispectral.md](../findings/bispectral.md) cites the file for a form it does not state (F6).
2. **The L16 block**, record the padding identity $\theta_0(n)+\kappa_n\delta^2=\theta_0(n)(1-9\delta^2)+9\sqrt{3/2}\,\delta^2$, the resulting binding case at $n\to\infty$ on $\{\delta^2>\tfrac19\}$, and the falsifier it names (F3). Fix the $n=8$ escape clause to give the operative reason, $\delta^2_{n=8}=0.101301<\tfrac19$ (F3a).
3. **The equality claim**, in the block, [results.md](../results.md) and [routes.md](../routes.md) R17, even $n$ only (F5).
4. **[conventions.md](../findings/conventions.md)**, add $\delta^2$ and L16's $\kappa_n$, and flag the collision with the Killing constant (F1, F10).
5. **[plan.md](../plan.md) I7**, say which statement L16 supplies (F8). **[routes.md](../routes.md) R17 / [plan.md](../plan.md) I4**, reconcile the pointwise theorem statement with two critical-point halves (F7).
6. **[results.md](../results.md)**, the "Proven ... defect priced to one term (Lemmas 15, 17–19)" row contradicts the same file's L15 audit entry (F9).
