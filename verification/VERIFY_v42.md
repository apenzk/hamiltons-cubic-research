# VERIFY v42, Lemma L158, candidates E9 and E10

*Adjudicator v42, 2026-09-05. Two candidate findings against [Lemma L158](../findings/second-order.md), both about the numerals in the "$4.9\%$" sentence. **No numerical work was done: no script was run, and every value below is an exact hand evaluation of a closed form.** Log: [agent_logs/verify-L158-E9E10-v42.log](../agent_logs/verify-L158-E9E10-v42.log).*

| CANDIDATE | VERDICT |
| --- | --- |
| **E9**, the $4.9\%$ comparison omits $\phi(0.5528)=0.9255$, so its direction reverses | **WITHDRAWN** |
| **E10**, the $27.8\%$ / $19.4\%$ ordering has the wrong sign; the figures are $13.2\%$ / $21.2\%$ | **WITHDRAWN** |

Both candidates are refuted by the same discovery, which is the substantive result of this adjudication: **every numeral in the disputed sentence reproduces exactly from the record's own constants**, once the constant $C$ is read off [Lemma L156](../findings/second-order.md) rather than left implicit. The entry never prints $C$, which is why three successive readers (the earlier review that called the figures unreproducible, and both of today's candidates), have each reconstructed a different function and found a different defect in it.

## The constants, all exact, and the model they pin

At $n=12$, $m=6$, write $c:=a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt5$ and $D:=\tfrac{2m-1}{m-1}=\tfrac{11}5$.

- $\kappa=3\sqrt{2(n-1)/(n-2)}=3\sqrt{2.2}=4.4497191$, so $c_p=\kappa/n=0.37080993$.
- $\lambda(12)=2/\sqrt{\lvert\kappa_{12}\rvert}=2/\sqrt{0.10159}=6.2748727$; the asymptotic $\lambda_\infty=2/\sqrt{1.7053}=1.5315464$.
- The two envelopes. The **triangle** envelope is $\psi(w)=\min(c+w,\,1)$, whose kink is at $w=1-c$. The **homogeneous** envelope, which is the record's current one, is $\phi(w)=\min\big(c\sqrt{1-w^2}+w,\,1\big)$; setting $c\sqrt{1-w^2}=1-w$ and dividing by $1-w$ gives $c^2(1+w)=1-w$, so its kink is at $w_0=\tfrac{1-c^2}{1+c^2}=\tfrac{n-4}n$, which is $\tfrac23$ at $n=12$. Since $\sqrt{1-w^2}\le1$, $\phi\le\psi$ pointwise, with equality only at $w\in\{0,1\}$.
- **The constant $C$, which the entry leaves unprinted.** [Lemma L156](../findings/second-order.md) gives $J=C/\gamma=\tfrac{4\alpha(1+\alpha)}{d^3}$ at the optimal $\gamma=d/2$, with the minimum over $\alpha$ at $\alpha=D/2$, where $d=\min(\alpha,D-\alpha)=\alpha$. Hence $C=J\gamma=\tfrac{2\alpha(1+\alpha)}{d^2}=\tfrac{2(1+\alpha)}\alpha=\tfrac{4+2D}D$. At $D=\tfrac{11}5$ this is $C=\tfrac{42}{11}=3.8181818$, and the same substitution returns $J^*=\tfrac{16(1+D/2)}{D^2}=\tfrac{8.4}{1.21}=6.9421487$, the $6.9421$ the entry prints, which is the cross-check that the reading of $C$ is the right one.

So [Lemma L157](../findings/second-order.md)'s $t=\lambda\sqrt{c_p+\rho w^2}/(2C)$ is $t=\beta s$ with

$$s(w)=\sqrt{c_p+\rho w^2},\qquad \beta=\frac\lambda{2C}=\frac{11\lambda}{84},\qquad \beta(12)=0.8217096,\qquad \beta_\infty=0.2005597 .$$

Writing $1-\eta^*=2/(\sqrt{4t+1}+1)$ and $F_\rho(w):=(1-\eta^*)^2\,s(w)$ (the entry's own statement that "both numerals are $(1-\eta^*)^2\sqrt{c_p+\rho w^2}$"), branch 2 is $\tfrac\lambda{\sqrt2Jn}\cdot F_\rho/\phi$, so the minimised $w$-profile is $F_\rho/\phi$ up to a $w$-free factor. Three of the entry's numerals now come out on the nose:

| point | $s$ | $t=\beta s$ | $(1-\eta^*)^2$ | $F$ | entry |
| --- | --- | --- | --- | --- | --- |
| $\rho=1$, $w_0=\tfrac23$ | $0.9029144$ | $0.7419310$ | $0.4468503$ | $\mathbf{0.403465}$ | $0.40347$ |
| $\rho=1$, $w=1-c$ | $0.8224249$ | $0.6757924$ | $0.4677313$ | $\mathbf{0.384677}$ | $0.38468$ |
| $\rho^{\text{eff}}=0.7190434$, $w_0=\tfrac23$ | $0.8308939$ | $0.6827569$ | $0.4654405$ | $\mathbf{0.386740}$ | $0.38673$ |

and a fourth, off the same $\beta$: at the [Lemma L157](../findings/second-order.md) minimiser $w=0.829$ with $\lambda=1.53$, $\lambda(1-\eta^*)^2=1.1076$ against the entry's $1.1075$. Four independent hits to five digits fix the model beyond doubt. The remaining value needed below is $F_1(1)=0.456814$ at $s(1)=1.1708159$, $t=0.9620724$, $(1-\eta^*)^2=0.3901429$.

## 1. E9, which envelope $0.5528$ belongs to, what $\phi$ is there, and the sign of the $4.9\%$

**Located.** [findings/second-order.md](../findings/second-order.md), in the paragraph beginning "**And this entry's own kink understated the minimum by $4.9\%$**":

> *At $n=12$ with $\lambda(12)=6.275$ the minimum was recorded as $0.40347$ at $w_0=\tfrac23$, against $0.38468$ at the entry's $0.5528$ and $r714$'s endpoint value*

**Which envelope owns $0.5528$.** It is the **triangle** envelope's kink, exactly: $1-c=1-1/\sqrt5=0.5527864$. It is not a kink of anything else in the block, the homogeneous envelope's kink is $w_0=\tfrac{n-4}n=\tfrac23$, derived above. The previous reader's identification is correct.

**What $\phi(0.5528)$ equals under the record's current envelope.** Exactly, with $c=5^{-1/2}$ and $w=1-c$, so $1-w^2=2c-c^2=c(2-c)$:

$$\phi(1-c)=c\sqrt{c(2-c)}+1-c=5^{-3/4}\sqrt{2-5^{-1/2}}+1-5^{-1/2}=0.2990698\times1.2461085+1-0.4472136=0.9254594 .$$

So the candidate's $0.9255$ is right as a fact. What follows from it is not.

**Why the comparison is nevertheless like-for-like.** The two numerals are not two evaluations of one function; they are **two minima of two functions**, each attained at its own envelope's kink. Under $\psi$, the profile $F_1/\psi$ falls on $[0,1-c)$, at the kink $\tfrac{d\log\psi}{dw}=\tfrac1{c+w}=1$ against $\tfrac{d\log F_1}{dw}=\tfrac1{\sqrt{4t+1}}\tfrac w{s^2}=\tfrac{0.8172702}{1.9243440}=0.4247$, and rises on $(1-c,1]$ where $\psi\equiv1$; so $\min F_1/\psi=F_1(1-c)/1=0.384677$. Under $\phi$, the same computation at $w_0$ gives $\phi'(w_0)/\phi(w_0)=1-\tfrac{cw_0}{\sqrt{1-w_0^2}}=1-\tfrac{0.2981424}{0.7453560}=\tfrac35$ exactly, against $\tfrac{0.8177437}{1.9919147}=0.4105$; so $\min F_1/\phi=F_1(w_0)/1=0.403465$. **Each envelope equals $1$ at its own minimiser**, which is why neither number carries a visible divisor. Nothing is omitted from $0.38468$.

**Sign and size.** $\psi\ge\phi$ pointwise forces $F_1/\psi\le F_1/\phi$ pointwise and therefore $\min F_1/\psi\le\min F_1/\phi$, the triangle envelope must understate the minimum, as a matter of the inequality rather than of arithmetic. The size is

$$\frac{0.403465}{0.384677}=1.048840,\qquad\text{i.e. }\mathbf{4.88\%},$$

which is the entry's $4.9\%$, in the entry's direction. **The direction cannot reverse**, because it is an ordering between two minima of two ordered functions.

**The strongest defence of E9, and where it stops.** The one true reading E9 has is that $w=1-c$ is *not* a minimiser under $\phi$, and evaluating the corrected profile there costs something: $F_1(1-c)/\phi(1-c)=0.384677/0.9254594=0.415662$, which is $1.030231$ times $0.403465$, i.e. **$3.02\%$ worse** than $w_0$. That is a true and useful statement, and it *supports* the entry, it says the old kink is the wrong minimiser as well as the wrong envelope. It is a different comparison from the one the entry makes, and it does not touch the $4.9\%$.

**WITHDRAWN.** The failure could not be exhibited, and the defence of the entry as written succeeds.

## 2. E10, the closed-form monotonicity, derived, and the two figures

**Located.** The same sentence, continuing:

> *the improvement over the endpoint is $27.8\%$ at $\lambda(12)$ and $19.4\%$ at the asymptotic $\lambda$, never the $26\%$ claimed*

**The elasticity, derived rather than quoted.** With $h(t):=4/(\sqrt{4t+1}+1)^2$ and $u:=\sqrt{4t+1}$, so $t=\tfrac{u^2-1}4$,

$$\frac{\mathrm d\log h}{\mathrm d\log t}=t\cdot\frac{-4}{u(u+1)}=\frac{-(u-1)(u+1)}{u(u+1)}=\frac1u-1,\qquad\text{hence}\qquad \frac{\partial\log F}{\partial\log s}\bigg|_\beta=1+\Big(\frac1u-1\Big)=\frac1{\sqrt{4t+1}} .$$

That is the entry's own display, recovered independently.

**Monotonicity in $\lambda$.** Fix two abscissae $w_b<w_a$ and hence $s_b<s_a$, both $\lambda$-free. Integrating the elasticity along $s$ at fixed $\beta$,

$$\log\frac{F_\lambda(w_a)}{F_\lambda(w_b)}=\int_{s_b}^{s_a}\frac{\mathrm d\sigma}{\sigma\sqrt{4\beta\sigma+1}},\qquad \beta=\frac\lambda{2C}\propto\lambda .$$

The integrand is strictly decreasing in $\beta$ at every $\sigma>0$, so $R(\lambda):=F_\lambda(1)/F_\lambda(w_0)$ is **strictly decreasing in $\lambda$**. E10's derivation is sound to exactly this point.

**Where E10 then goes wrong.** The entry's figure is not $R-1$. "The endpoint" in that clause is **r714's endpoint value**, named two clauses earlier in the same sentence, the $w=1$ reading of the bound under the triangle envelope, whose value there is $\psi(1)=1+c=1.4472136$, the very $1.4472$ this block refutes as "pricing an $H_s$ that $\lVert H\rVert_F=1$ has already emptied". So r714's endpoint value is $F_\lambda(1)/\psi(1)$, and the entry's improvement is

$$\Delta(\lambda):=\frac{F_\lambda(w_0)}{F_\lambda(1)/\psi(1)}-1=\frac{\psi(1)}{R(\lambda)}-1 .$$

$\psi(1)$ carries no $\lambda$; $R$ strictly decreases in $\lambda$; therefore **$\Delta$ strictly increases in $\lambda$**. Since $\lambda(12)=6.2749>\lambda_\infty=1.5315$, the entry's ordering $27.8>19.4$ has the **right** sign, and it is the same elasticity that forces it.

**The figures, exactly.**

| $\lambda$ | $\beta=\tfrac{11\lambda}{84}$ | $F_\lambda(w_0)$ | $F_\lambda(1)$ | $F_\lambda(1)/\psi(1)$ | $\Delta$ | $R-1$ |
| --- | --- | --- | --- | --- | --- | --- |
| $6.2749$ | $0.8217096$ | $0.403465$ | $0.456814$ | $0.315650$ | $\mathbf{27.82\%}$ | $13.22\%$ |
| $1.5315$ | $0.2005597$ | $0.674985$ | $0.818119$ | $0.565307$ | $\mathbf{19.40\%}$ | $21.21\%$ |

The entry's $27.8\%$ and $19.4\%$ are $\Delta$, reproduced to three figures. E10's $13.2\%$ and $21.2\%$ are $R-1$, also correct, for the different question "how far above the minimum is the $w=1$ endpoint under the *current* envelope, where $\phi(1)=1$". Both columns obey the derived monotonicity, in opposite directions, because $\Delta=\psi(1)/R-1$.

**The strongest defence of E10, and where it stops.** E10 is right that a reader who takes "the endpoint" to mean $w=1$ under the record's current envelope gets $13.2\%$ and $19.4\%$'s partner $21.2\%$, and right that that pair is ordered the other way. That is a defect of **wording**, not of arithmetic: the clause names r714's endpoint value without repeating it, and the two candidate readings of one phrase differ by the factor $\psi(1)=1.4472$. The earlier review that reported the figures as unreproducible failed for the same reason, one step earlier, without $C$ it could not build $F$ at all.

**WITHDRAWN.** The figures are not refuted; they are exact for the quantity the sentence names.

## 3. Whether the entry's conclusion survives

It is untouched, and would have been untouched even had both candidates stood.

- The numerals live in one parenthetical comparison of the corrected minimum against two superseded readings. Nothing downstream reads them.
- The block's conclusions, that the minimiser is the homogeneity kink $w_0=\tfrac{n-4}n$; that $\min F_{\rho^{\text{eff}}}/\phi=0.38673$ at $n=12$; that **branch 2 binds and [I31](../plan.md)'s constant is not load-bearing**, rest on the envelope inequality $\phi\le\psi$ and on the slope comparison $\phi'(w_0)=\tfrac35>0.4105$, both re-derived above from scratch, neither using $4.9\%$, $27.8\%$ or $19.4\%$.
- The entry's own hedge, "branch 2 binds at $n=12$ under every envelope considered", is confirmed: the minimum moves from $0.384677$ under $\psi$ to $0.403465$ under $\phi$, a $4.9\%$ change in a quantity whose branch-2 comparison has an order of magnitude of room.

So this is the case of right numerals supporting a right conclusion, and no repair to the mathematics is owed.

## 4. What the numerals should read

- $0.40347$, **stands**. Exact value $0.403465$; the printed five digits are correct.
- $0.38468$, **stands**. Exact value $0.384677$. It is $\min_wF_1/\psi$, attained at the triangle kink $w=1-1/\sqrt5=0.5527864$, where $\psi=1$ and nothing is omitted.
- $0.38673$, **stands**. Exact value $0.386740$.
- $4.9\%$, **stands**, and should read $4.88\%$ if a second digit is wanted. Its direction is forced by $\phi\le\psi$ and cannot reverse.
- $27.8\%$ and $19.4\%$, **stand**. Exact values $27.82\%$ and $19.40\%$. Their ordering is forced by $\Delta=\psi(1)/R(\lambda)-1$ with $R$ decreasing, so it is right.
- $\phi(0.5528)=0.9254594$, correct as a fact about the current envelope, and irrelevant to the $4.9\%$, since $0.38468$ was never divided by an envelope taken at that point.
- **Two additions the entry owes, both wording rather than arithmetic.** "The endpoint" must be written as *r714's endpoint value $0.3157$, computed with $\psi(1)=1+1/\sqrt5=1.4472$*, otherwise the phrase reads as the current envelope's $w=1$ value $0.456814$ and yields $13.2\%$ and $21.2\%$, which is exactly the reading E10 took. And $C=\tfrac{4+2D}D=\tfrac{42}{11}$, hence $\beta=\lambda/(2C)=\tfrac{11\lambda}{84}$ at $n=12$, should be printed: it is the single missing line that makes every numeral in the block reproducible, and its absence has now produced three separate erroneous findings against figures that were correct all along.
