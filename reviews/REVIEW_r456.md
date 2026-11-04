# Review r456, adversarial audit of [Lemma L151](../findings/second-order.md): the list of four constants is the constant list of a superseded bookkeeping, and the one it calls forced is the one that is free

*Reviewer r456, 2026-09-03, cold adversarial brief. Target: [Lemma L151](../findings/second-order.md), "three of the four Cauchy constants are pinned, and the fourth is named". Read in full: [Lemma L151](../findings/second-order.md), [Lemma L149](../findings/second-order.md), [Lemma L148](../findings/second-order.md), [Lemma L147](../findings/second-order.md), [Lemma L146](../findings/second-order.md), [Lemma L145](../findings/second-order.md), [conventions.md](../findings/conventions.md), [REVIEW_r450.md](REVIEW_r450.md), [REVIEW_r451.md](REVIEW_r451.md), [REVIEW_r452.md](REVIEW_r452.md), [REVIEW_r453.md](REVIEW_r453.md); and, found by the novelty screen and decisive, [REVIEW_r441.md](REVIEW_r441.md) and [REVIEW_r447.md](REVIEW_r447.md). **Analysis only** ([analysis-only.md](../.claude/rules/analysis-only.md)): every derivation below is by hand. One screen is reported, on a closed form I derive here, and it is evidence for nothing. Working: [agent_logs/r456-L151.log](../agent_logs/r456-L151.log).*

## The one-line verdict

**REFUTED.** The lemma's whole substance is the completeness of a list of four, and the list is neither complete nor a list of the chain it names: it prices [Lemma L145](../findings/second-order.md)'s retired $C_\delta$ bookkeeping, while [Lemma L149](../findings/second-order.md)'s branches turn on at least five other absolute constants. The one row that is argued rather than asserted (the $\tfrac12$ in $\rho$), is **the one genuinely free parameter in the chain**, it is frozen at a value where the fourth constant is provably **infinite**, and [r441](REVIEW_r441.md) said so on the record before this lemma was written. That same review also **performed the contour estimate L151 defers**, reaching $M\le\tfrac32g_n=6\rho$ at $\rho=g_n/4$: the constant the lemma calls owed has a computed value five reviews upstream.

## Verdicts, per claim

| # | claim | verdict |
|---|---|---|
| 1 | exactly four absolute constants enter the $\beta=0$ radius | **REFUTED.** At least five more enter [Lemma L149](../findings/second-order.md)'s chain, three of them recorded by this lemma's own Gate-2 pair: the margin constant $\min(1,C_{\min}/2)$ ([r452](REVIEW_r452.md) B2), the penalty coefficient $\lvert\kappa_n\rvert$ and the net-margin gap $0.416$ ([r453](REVIEW_r453.md) E5), the Taylor/polarisation constants of $C_P$ ([r441](REVIEW_r441.md)), the constant of $u\le w$, and the fraction in the validity branch (F1) |
| 2 | the radius "turns on $C$ alone, and on nothing else" | **REFUTED**, by claim 1, and independently because $C$ and the $\tfrac12$ are one quantity, not two (F2, F7) |
| 3 | the $\tfrac12$ in $\rho=g_n/(2\lVert H\rVert_{op})$ is "pinned by the geometry, not chosen" | **REFUTED.** The geometry forces only $\alpha\in(0,1{+}\tfrac m{m-1})$ for the contour and $\gamma<\alpha$ for the radius; $\tfrac12$ is one point of a two-parameter family, it is not the optimum, and freeing it improves $\lVert A''\rVert$ by a factor $\approx4.8$ (F2). [r441](REVIEW_r441.md) recommendation 5 already says to take $g_n/4$, and names the better contour |
| 4 | $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert\le C\rho$ at that $\rho$ | **REFUTED as posed.** At $\rho\lVert H\rVert_{op}=g_n/2$ against a contour at distance $g_n/2$ the Neumann ratio is $1$: the perturbed resolvent bound diverges and $C=+\infty$. The lemma's own parenthetical applies the **unperturbed** resolvent bound $2/g_n$ to the perturbed operator (F3) |
| 5 | the $2$ of Cauchy is pinned, "it is $k!$ at $k=2$" | **REFUTED as used.** $k!M/\rho^k$ is the estimate at the **centre**; the chain needs $\lVert A''\rVert$ on the segment, where the constant is $2/(1-\sigma)^2$ at $\lvert t\rvert\le\sigma\rho$, $8$, not $2$, at the record's own $\sigma=\tfrac12$ (F4) |
| 6 | the $2$ and $6$ of Leibniz are pinned and the first term vanishes | **CONFIRMED as an identity, REFUTED as an evaluation.** $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$ is right; $A=0$ holds at $t=0$ and the remainder is evaluated elsewhere, where the first term is **comparable to the second**, not zero. This is [r441](REVIEW_r441.md) FINDING 1, on the record, unresolved (F5) |
| 7 | $C=1$ on the real segment | **CONFIRMED**, all three inputs, including $\lVert\mathrm{Alt}\rVert_{op}\le1$ against [conventions.md](../findings/conventions.md)'s $\tfrac13$, the $\tfrac13$ is the projector's own normalisation and costs nothing (F6) |
| 8 | $C$ is "THE ONE THAT IS OWED" | **REFUTED on novelty.** [r441](REVIEW_r441.md)'s Cauchy step is the estimate the lemma describes as what would pin it, carried out, with $M\le\tfrac32g_n$ and every input named (N1) |
| 9 | the reduction is a reduction | **REFUTED.** Pinning $C$ requires choosing the contour and the radius, which is the "pinned" third row; the two entries are one optimisation and the table's independence is false (F7) |

---

## N1, novelty screen, by quantity and source rather than by name

**The pair.** Quantity: $M=\sup_{\lvert z\rvert=\rho}\lVert\mathrm{Alt}(W(z)_-)\rVert$, and through it the absolute constants of the tube radius at $\beta=0$. Information: a separating contour at a fraction of $g_n$, the resolvent bound it carries, $\lVert\mathrm{Alt}\rVert\le1$, and Cauchy on the resulting disc. I looked for **that pair** (a contour estimate producing a bound on the defect on the complex disc) rather than for the strings "L151", "constant" or "Cauchy".

**It is on the record twice, in [reviews/](.), neither cited by L151.**

- **[r441](REVIEW_r441.md), "The Cauchy step, $M=O(g_n)$ is right, and it does survive complexification".** $\Gamma$ the circle of radius $g_n/2$ about $\lambda_-$, $\rho=g_n/4$, $\lvert\Gamma\rvert/2\pi=g_n/2$, $\max_{w\in\Gamma}\lvert w\rvert\le\tfrac32g_n$, $\lVert R_w\rVert_{op}\le2/g_n$, Neumann term $k$ at most $\tfrac32g_n2^{-k}$, **summing to $M\le\tfrac32g_n$**, which at that $\rho$ is $M\le6\rho$. The zeroth term is separated out and killed by $\mathrm{Alt}$, exactly as L151's "what would pin it" describes. **This is a computed value for the fourth constant.**
- **[r447](REVIEW_r447.md) F3**, and [Lemma L145](../findings/second-order.md)'s own step-2 row: *"the complex radius must be $\rho<g_n/2$, not $\rho=g_n/2$"*, CONFIRMED by both of L145's reviewers, **150 lines above L151 in the same file**. L151 writes $\rho=g_n/(2\lVert H\rVert_{op})$ with equality and takes a supremum on that circle.

**So the screen's outcome is not "no prior art" but "the lemma's open entry is closed and its pinned entry is refuted, both in material it does not cite".** *This is the failure the brief describes: the content sat under a heading naming the route in plain words ("The Riesz step", "The Cauchy step"), in a review of the very item L151 continues.*

---

## F1, the list is not complete, and it is not the list of [Lemma L149](../findings/second-order.md)'s chain

This is the claim's whole substance, so it gets the full enumeration. [Lemma L149](../findings/second-order.md)'s chain is

$$r(H)\;\gtrsim\;\min\Big(\frac{c(H)}S,\ \frac{\sqrt{c(H)}}{\lVert A''\rVert},\ \frac{\rho(H)}2\Big),$$

with the third branch owed and absent ([r450](REVIEW_r450.md) item 6, [r451](REVIEW_r451.md) item 6, [r452](REVIEW_r452.md) B8, [r453](REVIEW_r453.md) E6). Every absolute constant in it:

| constant | where it enters | in L151's four? |
|---|---|---|
| $\tfrac12$ on the Hessian and $\tfrac16$ on the cubic in Taylor's expansion of $P$ along the segment | both defect branches and the $P$-side branch; they turn $c/S$ into $3c/C_P$ | **no** |
| $27$ and the polarisation $3^3/3!$ in $C_P\le27(\theta_0+O(1)+O(\sup\lvert P\rvert))$ ([r441](REVIEW_r441.md)) | the $P$-side branch; the branch is $c/C_P$, not $c/\sup\lvert P\rvert$ | **no** |
| the implied constant in $S=\sup\lvert P\rvert=\Theta(n^\beta)$ | the $P$-side branch. **At $\beta=0$ this is the value of $\sup\lvert P\rvert$ itself, which the record brackets rather than knows** ([Lemma L147](../findings/second-order.md): $\theta_0\le S$, [Lemma L143](../findings/bounds.md) above) | **no**, and it is as unpinned as $C$ |
| $\min(1,C_{\min}/2)$ in $c(H)\gtrsim c_p+w^2$, with $C_{\min}=3\theta_0\frac{m-3}{2(m-1)}$ | the margin lower bound. **Zero at $m=3$, equal to $c_p$ at $m=4$, $\ge0.9$ only from $m=5$** ([r452](REVIEW_r452.md) B2) | **no** |
| $\lvert\kappa_n\rvert\to9(\sqrt2-\sqrt{3/2})=1.7053$ | the $\lvert\kappa_n\rvert u^2t^2$ penalty subtracted from the margin, and the $\lvert\kappa_n\rvert$ multiplying the quartic tail inside the second branch | **no** |
| the net-margin gap $\tfrac32\theta_0-\lvert\kappa_n\rvert\to0.416$ | whether the net margin is positive at all. **Positive by twenty per cent, on an inequality that was on nobody's record a day before** ([r453](REVIEW_r453.md) E5) | **no** |
| the constant $1$ in $u\le w$ | the same subtraction. It is $\lVert\mathrm{Alt}\rVert\le1$ times the Daleckii–Krein multiplier bound at a Hermitian point ([conventions.md](../findings/conventions.md): entries in $[-1,0]$); by the other route it is [Lemma L133](../findings/second-order.md)'s $\tfrac{\sqrt2}3$ times a link $v\lesssim w$ that [r452](REVIEW_r452.md) B4 says **is asserted nowhere on the record** | **no** |
| $\lVert A'\rVert\le\tfrac12$ ([Lemma L141](../findings/second-order.md)(a)) | multiplies the $6\langle A'',A'\rangle$ term, so the step's constant is $3$, not $6$ | **no** |
| the fraction $\sigma$ in the validity branch $\sigma\rho$ | it is simultaneously the third branch and the Cauchy shrinkage of F4 | **no**, and it is a second frozen free parameter |

**Nine, against four, and the overlap is empty.** The four L151 lists, Cauchy's $k!$, Leibniz's $2$ and $6$, the $\tfrac12$ in $\rho$, and $C$, are the constants of the $C_\delta=(\delta^2)'''$ bookkeeping of [Lemma L145](../findings/second-order.md). **[Lemma L149](../findings/second-order.md)'s second branch does not contain $(\delta^2)'''$ at all**: it comes from balancing the net margin against the quartic tail of $\delta^2\le(ut+\tfrac12\sup\lVert A''\rVert t^2)^2$ ([r447](REVIEW_r447.md) F2, quoted at [r453](REVIEW_r453.md) E5), in which the numbers $2$ and $6$ never appear. So the lemma answers "which constants decide the $\beta=0$ radius" with the constant list of a chain the record replaced two lemmas ago.

**Would this be true vacuously?** No. The failure is not that some constant is hard to name; it is that the named ones are inherited from a retired derivation while the live ones, $\lvert\kappa_n\rvert$, the net gap $0.416$, the margin constant with its $m\ge5$ restriction, were each surfaced by this lemma's own Gate-2 reviewers **on the entry immediately above it**, and none of them is here. At $\beta=0$ every branch is $\Theta(n^{-1})$ ([r452](REVIEW_r452.md) B8), so a claim that only four constants decide is a claim about all three branches, and it is false on each.

---

## F2, the $\tfrac12$ is the one free parameter in the chain, and $\tfrac12$ is not its optimum

**The geometry forces far less than the lemma says.** $\mathop{\mathrm{spec}}(W^*)=\{\lambda_-,\lambda_+\}$ with $\lambda_-=-g_n$ and, since $\mathop{\mathrm{tr}}W^*=0$ and $W^*_-=g_n(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$ has negative eigenspace $V_1\otimes V_2$ of dimension $m^2$ against $m(m-1)$,
$$\lambda_+=\frac m{m-1}\,g_n\;>\;g_n .$$
*Consistent with [r447](REVIEW_r447.md) F1's $\lVert W^*\rVert_{op}=\lambda_+=\Theta(g_n)$.* **$0$ is not in the spectrum**, so "the contour must separate the negative spectrum from $0$" imposes nothing on the contour: what a Riesz contour must do is enclose $\lambda_-$ and exclude $\lambda_+$, and what the perturbation must not do is cross it.

**Two free parameters, and the resulting closed form.** Take $\Gamma$ the circle of radius $\alpha g_n$ about $\lambda_-$ and write $\rho\lVert H\rVert_{op}=\gamma g_n$. Admissibility is $\gamma<\alpha$ (nothing crosses $\Gamma$ from inside) and $\alpha+\gamma<1+\tfrac m{m-1}$ (nothing crosses from the $\lambda_+$ side); for the analytic continuation to *be* $W(t)_-$ on the real segment one also needs $\gamma<1$, which no eigenvalue-sign argument makes stronger. Running [r441](REVIEW_r441.md)'s own Neumann bookkeeping, Frobenius spent once on $H$, operator norm on the resolvents, the zeroth term killed by $\mathrm{Alt}(W^*_-)=0$, with $\lvert\Gamma\rvert/2\pi=\alpha g_n$, $\max_\Gamma\lvert w\rvert\le(1+\alpha)g_n$ and $\lVert R_0\rVert\le1/(\alpha g_n)$, term $k\ge1$ is at most $\frac{(1+\alpha)\rho}\alpha(\gamma/\alpha)^{k-1}$ and

$$M\;\le\;C(\alpha,\gamma)\,\rho,\qquad C(\alpha,\gamma)=\frac{1+\alpha}{\alpha-\gamma}.$$

*Check: $\alpha=\tfrac12,\gamma=\tfrac14$ gives $C=6$ and $M\le6\rho=\tfrac32g_n$, [r441](REVIEW_r441.md)'s figure exactly.*

**What the chain actually wants is $\lVert A''\rVert\le2M/\rho^2\le2C/\rho$**, i.e. minimising $\frac{2(1+\alpha)}{(\alpha-\gamma)\gamma}$ in units of $\lVert H\rVert_{op}/g_n$. For fixed $\alpha$ the optimum is $\gamma=\alpha/2$ (*the lemma's $\tfrac12$ is the right ratio of $\gamma$ to $\alpha$ and the wrong $\alpha$*) and the objective $4(1+\alpha)/\alpha^2$ then **decreases in $\alpha$**, so the contour should be pushed out to the $\lambda_+$ constraint, near $\alpha=\tfrac43$, $\gamma=\tfrac23$.

| choice | admissible? | $2C/\rho$ in units of $\lVert H\rVert_{op}/g_n$ |
|---|---|---|
| the lemma's $\alpha=\tfrac12$, $\gamma=\tfrac12$ | **no**, $\gamma<\alpha$ fails | $+\infty$ |
| $\alpha=\tfrac12$, $\gamma=\tfrac14$ ([r441](REVIEW_r441.md) rec. 5) | yes | $48$ |
| $\alpha=\tfrac43$, $\gamma=\tfrac23$ | yes for every $m\ge2$ | $10.5$ |

> **Screen** (self-constructed, seconds; evidence for nothing, and it can fail, the grid evaluates $\frac{2(1+\alpha)}{(\alpha-\gamma)\gamma}$, which is derived above, so a wrong closed form shows as a mismatch against the two hand values). Minimising over $\alpha\in(0,2)$, $\gamma<\min(\alpha,2-\alpha)$ on a $200\times200$ grid returns $9.97$ at $(\alpha,\gamma)=(1.44,0.55)$, and reproduces $48$ at $(\tfrac12,\tfrac14)$ and $10.5$ at $(\tfrac43,\tfrac23)$.

**So the third row is wrong in the direction that matters.** Freezing $\alpha=\tfrac12$ costs a factor $\approx4.8$ in $\lVert A''\rVert$, hence the same factor in the second branch of the radius, at the exponent where the lemma says the constants decide whether the tube exists. And [r441](REVIEW_r441.md) named this: *"needs either a smaller $\rho$ or a contour at radius $\approx(\lambda_+-\lambda_-)/2$"*, which is $\alpha=\tfrac12(1+\tfrac m{m-1})\approx1.12$, within four per cent of the optimum I get independently.

*I claim optimality only within the circles-about-$\lambda_-$ family and only for this Neumann bookkeeping; a different contour shape or a sharper estimate moves the number. That is the point: it is an estimate to be optimised, not a constant read off the geometry.*

---

## F3, at the lemma's own $\rho$, the constant it says is owed is infinite

$\rho=g_n/(2\lVert H\rVert_{op})$ is $\gamma=\tfrac12$ against a contour the lemma places at distance $g_n/2$, i.e. $\alpha=\gamma$. Then the Neumann ratio $\rho\lVert H\rVert_{op}\lVert R_0\rVert$ is exactly $1$, the perturbed resolvent bound $\frac{\lVert R_0\rVert}{1-\rho\lVert H\rVert_{op}\lVert R_0\rVert}$ diverges, and $C(\alpha,\gamma)=\frac{1+\alpha}{\alpha-\gamma}=+\infty$.

**The lemma's parenthetical is where it happens.** *"where $\lvert z\rvert\lVert H\rVert_{op}\le g_n/2$ gives resolvent norm at most $2/g_n$"*, $2/g_n$ is the resolvent of $W^*$ at distance $g_n/2$ from $\mathop{\mathrm{spec}}(W^*)$. The integrand is the resolvent of $W(z)$, and at $\lvert z\rvert\lVert H\rVert_{op}=g_n/2$ the perturbed spectrum can reach $\Gamma$. **An unperturbed bound is being used for the perturbed operator at the exact point where the difference is unbounded.**

**It is not a new observation.** [Lemma L145](../findings/second-order.md)'s step-2 row (CONFIRMED by both its reviewers), reads *"the complex radius must be $\rho<g_n/2$, not $\rho=g_n/2$"*; [r447](REVIEW_r447.md) F3 derives it and repairs it with $\rho=g_n/4$; [r441](REVIEW_r441.md) calls $\rho=g_n/2$ *"borderline, it makes the Neumann ratio exactly $1$"*. **L151 restores the value all three corrected, in the same file, and then defines the owed constant as a supremum on that circle.** The repair is one symbol and it is already written down twice.

---

## F4, Cauchy's $k!$ is the constant at the centre, and the chain needs the segment

$\lVert A^{(k)}(0)\rVert\le k!M/\rho^k$ is exact for the derivative **at the centre of the disc**. [Lemma L149](../findings/second-order.md)'s second branch uses $\lVert A''\rVert$ as a uniform bound along the segment, inside a Taylor remainder: [r450](REVIEW_r450.md) D7 states the estimate at an intermediate base point $s$ as $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$, which is precisely why the validity branch is $\rho/2$.

$$\lVert A''\rVert_{\sup,\ \lvert t\rvert\le\sigma\rho}\;\le\;\frac{2M}{(1-\sigma)^2\rho^2},$$

so the operative constant is $2/(1-\sigma)^2$: **$8$ at the record's own $\sigma=\tfrac12$, four times the row's $2$**. And $\sigma$ is a second frozen free parameter, trading against the validity branch it defines, larger $\sigma$ buys a longer admissible segment and a worse second derivative. **So the first row is pinned only for a quantity the chain does not use**, and what it should say is that the constant is $2/(1-\sigma)^2$ with $\sigma$ to be optimised jointly with $\alpha$ and $\gamma$.

---

## F5, the Leibniz identity is right; the vanishing is a statement at $t=0$ used on the whole segment

**The identity checks.** $\delta^2=\langle A,A\rangle$, so $(\delta^2)'=2\langle A',A\rangle$, $(\delta^2)''=2\langle A'',A\rangle+2\langle A',A'\rangle$, and $(\delta^2)'''=2\langle A''',A\rangle+2\langle A'',A'\rangle+4\langle A'',A'\rangle=2\langle A''',A\rangle+6\langle A'',A'\rangle$. **CONFIRMED.** And $A(0)=\mathrm{Alt}(W^*_-)=0$ is genuine: $W^*_-=g_n(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$ is a combination of three constant-curvature tensors, each satisfying the first Bianchi identity, which $\mathrm{Alt}$ annihilates ([conventions.md](../findings/conventions.md), [r446](REVIEW_r446.md)).

**But a third-derivative bound inside a Taylor remainder is needed at an interior point, where $A\ne0$.** With $M\le C\rho$, $\sigma=\tfrac12$ and the shrinkage of F4: $\lVert A'''\rVert\le6M/(\rho/2)^3=48M/\rho^3$, $\lVert A''\rVert\le8M/\rho^2$, $\lVert A(t)\rVert\le\tfrac12\lvert t\rvert$ and $\lVert A'\rVert\le\tfrac12$ ([Lemma L141](../findings/second-order.md)(a)). At $\lvert t\rvert\le\rho/2$,

$$2\langle A''',A\rangle\;\le\;\frac{48M}{\rho^3}\cdot\frac\rho2\;=\;\frac{24M}{\rho^2},\qquad 6\langle A'',A'\rangle\;\le\;6\cdot\frac{8M}{\rho^2}\cdot\frac12\;=\;\frac{24M}{\rho^2}.$$

**The term the lemma says vanishes is exactly as large as the term it keeps**, and the pair is $48M/\rho^2$ against the row's implied $6M/\rho^2$, **a factor eight**, half of it from the vanishing and half from F4. *The two "pinned" rows are jointly wrong by $8$ on the quantity the chain uses.*

**This is [r441](REVIEW_r441.md) FINDING 1 verbatim in content**: *"The item proves $(\delta^2)'''$ at the base point. The remainder needs $\sup_{\lvert t\rvert\le r}$ … The conclusion survives; the step is nowhere written."* r441 closes it by a bootstrap that assumes $r\le1/n$, **and at $\beta=0$ the claimed $r$ is $\Theta(1/n)$, which is the bootstrap's own boundary.** So at the exponent this lemma is about, the unwritten step is not a formality: its constant feeds back into the constant it is trying to establish. *Whether the fixed point exists is a question about absolute constants, and it is not on the list of four.*

---

## F6, $C=1$ on the real segment is CONFIRMED, and the $\tfrac13$ in $\mathrm{Alt}$ is not a problem

All three inputs hold, and the brief's suspicion about the normalisation does not land.

- **$A(0)=0$**: above.
- **$\lVert\mathrm{Alt}\rVert_{op}\le1$**: [conventions.md](../findings/conventions.md) states $\mathrm{Alt}$ **is** the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, self-adjoint and idempotent, with $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$. The $\tfrac13$ is what makes it idempotent rather than a scaling on top of one: on a totally antisymmetric $R$, the three cyclic terms are equal (a $3$-cycle on the last three indices is even), so $\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})=R_{ijkl}$. **The operator norm is $1$ and the $\tfrac13$ costs nothing.** *The file's $\lVert\star\rVert^2=6$ is the norm of the Hodge element in $\Lambda^2\mathbb R^4$, not an operator norm of $\mathrm{Alt}$; reading it as one would be the trap, and the lemma does not.*
- **$x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm on Hermitian arguments**: the Daleckii–Krein derivative is Schur multiplication by the divided differences of $f(x)=\tfrac12(\lvert x\rvert-x)$, whose entries lie in $[-1,0]$ ([conventions.md](../findings/conventions.md)); a Schur multiplier with entries bounded by $1$ has Hilbert–Schmidt norm at most $1$, and integrating along the Hermitian segment gives the Lipschitz bound. *This is a Frobenius statement and would be false in operator norm, the record's norm is the right one, which is luck the lemma does not remark on.*

Hence $\lVert A(t)\rVert\le\lVert W(t)-W^*\rVert_F=\lvert t\rvert\lVert H\rVert_F=\lvert t\rvert$ and $C=1$. **CONFIRMED**, and the lemma is right that this is a Hermitian statement: $W^*+zH$ is complex symmetric off the real axis, where Daleckii–Krein gives nothing. *That observation is also not new, [r441](REVIEW_r441.md) recommendation 2, [r452](REVIEW_r452.md) B4 and [r453](REVIEW_r453.md) E3 each record it, the last two in the Gate 2 of the entry L151 continues.*

**What the lemma overstates is the consequence.** $C=1$ is unavailable on the circle; $C=O(1)$ is not. F2 gives $C\le\frac{1+\alpha}{\alpha-\gamma}$, an absolute number for any admissible pair, $6$ at [r441](REVIEW_r441.md)'s choice, $3.5$ at $(\tfrac43,\tfrac23)$. **The gap between the real-segment $1$ and the complex-circle bound is a factor of a few, not an open question.**

---

## F7, the reduction relabels the work rather than reducing it

The lemma's value proposition is that three constants are settled so that one contour estimate finishes the job. Both halves fail together.

- **The third row is not settled**, and settling it *is* the contour estimate: $\alpha$ and $\gamma$ are the contour and the radius, and $C=\frac{1+\alpha}{\alpha-\gamma}$ is a function of them. **One cannot pin $C$ without choosing what the third row asserts is already forced**, and the choice the third row freezes is inadmissible (F3) and, once repaired, suboptimal by a factor $\approx4.8$ (F2). *The two rows are one variable presented as two.*
- **The estimate that pins $C$ is the estimate that pins the branch.** Once $\alpha,\gamma,\sigma$ are fixed, $\lVert A''\rVert\le2C/((1-\sigma)^2\rho)$ is the second branch outright; nothing further is bought by having named $C$ separately. So the reduction does not decompose the problem, it renames one step of it.
- **And it leaves the branches that actually bind at $\beta=0$ untouched.** [r452](REVIEW_r452.md) B8: at $\beta=0$ all three branches are $\Theta(n^{-1})$ and the constants of all three decide. L151 addresses the constants of one.

**The honest form of what remains true**: *the second branch's constant reduces to a contour optimisation over $(\alpha,\gamma,\sigma)$, with $C\le\frac{1+\alpha}{\alpha-\gamma}$ from [r441](REVIEW_r441.md)'s Neumann bookkeeping*, a sentence that is a reduction, is checkable, and does not need a list of four.

---

## Vacuity

**The lemma is not vacuous, and its failure is not vacuous either.** A true completeness statement about the constants at $\beta=0$ would be worth having: [r450](REVIEW_r450.md) D7 records that the validity branch *"binds up to a constant"* there and that nobody has checked whether the constants work out, and that is a real open question about whether anything is proved at $\beta=0$ at all. The list is an attempt at exactly the right thing. **It fails by being the wrong list**, and the wrongness is load-bearing: a reader who takes the table at face value optimises the one constant that is already computed while leaving inadmissible the parameter that costs a factor five, and never learns that $\lvert\kappa_n\rvert$, the $0.416$ net margin and the $m\ge5$ margin constant sit in the same chain.

*One secondary note.* The penalty coefficient written $\kappa_n$ here, negative for $n\ge12$ with $\lvert\kappa_n\rvert\to1.7053$, collides with [conventions.md](../findings/conventions.md)'s *"the algebra's Killing constant is $\kappa_n=(2n-1)(n-1)/4$"*, positive and growing. **The same symbol, two objects, and the file that fixes conventions warns about exactly this pattern.**

---

## What I could not break

- **The Leibniz identity** $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$, recomputed from scratch.
- **$\mathrm{Alt}(W^*_-)=0$**, from the three-Bianchi-tensor decomposition of $W^*_-$, and $\lVert\mathrm{Alt}\rVert_{op}=1$ against the $\tfrac13$.
- **$C=1$ on the real segment**, all three inputs, including the Frobenius-only Lipschitz property.
- **That $C=1$ does not transfer to the complex circle**, correct, and it is the record's own repeated finding.
- **That the $\beta=0$ radius turns on absolute constants**, correct, and the right question to have asked.

## What this audit did not check

[Lemma L27](../findings/nondegeneracy.md)'s ten eigenvalues, [Lemma L141](../findings/second-order.md)'s $c_p$ and its $\lVert A'\rVert\le\tfrac12$, [Lemma L133](../findings/second-order.md)'s $u\le\tfrac{\sqrt2}3v$, [Lemma L143](../findings/bounds.md), [Lemma L146](../findings/second-order.md)'s embedding, and [Lemma L148](../findings/second-order.md)'s diagonality are taken as given. [r441](REVIEW_r441.md)'s Neumann bookkeeping is inherited rather than re-derived term by term; I re-derived only its $(\alpha,\gamma)$-generalisation and checked that it reproduces r441's $M\le\tfrac32g_n$ at $(\tfrac12,\tfrac14)$. Whether $\lVert A''\rVert$ is **saturated** at $O(M/\rho^2)$, [r443](REVIEW_r443.md)'s open item (iii), is untouched, so everything above concerns what the chain can prove. **Whether the whole constant chain closes with a positive radius at $\beta=0$ is not settled here and is not settled anywhere**: that needs the joint $(\alpha,\gamma,\sigma)$ optimisation, the bootstrap of F5 written out, and the value of $\sup\lvert P\rvert$.

## What to change

1. **Withdraw "four enter" and the sentence "turns on $C$ alone, and on nothing else".** Replace the table with the nine-row enumeration of F1, marked by which branch each constant sits in, and say that at $\beta=0$ all three branches bind so all three constant sets decide ([r452](REVIEW_r452.md) B8).
2. **Delete the third row's "pinned by the geometry, not chosen".** The contour radius $\alpha g_n$ and the disc fraction $\gamma$ are free, $C=\frac{1+\alpha}{\alpha-\gamma}$, and the optimum is near $(\tfrac43,\tfrac23)$, not $(\tfrac12,\tfrac12)$. Record that $0\notin\mathop{\mathrm{spec}}(W^*)$ and $\lambda_+=\tfrac m{m-1}g_n$, so separation from $0$ constrains nothing.
3. **Repair $\rho$ to a strict inequality**, as [Lemma L145](../findings/second-order.md) step 2, [r447](REVIEW_r447.md) F3 and [r441](REVIEW_r441.md) all instruct. At $\rho\lVert H\rVert_{op}=g_n/2$ against a contour at $g_n/2$ the fourth constant is infinite, so the lemma currently takes a supremum on a circle where its own bound fails.
4. **Cite [r441](REVIEW_r441.md)'s Cauchy step and record $M\le\tfrac32g_n=6\rho$ at $\rho=g_n/4$.** The constant the lemma calls owed has a computed value; what is owed is its transposition to the direction-dependent $\rho$ and the joint optimisation, which is a smaller and differently-shaped debt.
5. **Restate the first two rows for the segment, not the centre.** $\lVert A''\rVert\le2M/((1-\sigma)^2\rho^2)$, and $2\langle A''',A\rangle$ does **not** vanish off $t=0$: at $\sigma=\tfrac12$ the two terms are equal and the pair is $48M/\rho^2$. Carry [r441](REVIEW_r441.md) FINDING 1's bootstrap explicitly, and note that at $\beta=0$ its hypothesis $r\le1/n$ is the value being derived.
6. **Say that $C=O(1)$ is available and only $C=1$ is not.** As written the entry reads as though the complex circle leaves the constant unbounded.
