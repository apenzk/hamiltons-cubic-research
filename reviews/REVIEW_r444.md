# REVIEW r444, adversarial audit of Lemma L143, $\sup\lvert P\rvert\le1+\sqrt{n-2}$

*Target: [Lemma L143](../findings/bounds.md) in [bounds.md](../findings/bounds.md). Cold brief, analysis only, the one computation below is a screen on objects built for the purpose, reported as a screen. Read alongside [Lemma L107](../findings/bounds.md), [conventions.md](../findings/conventions.md), and the $\theta\le\lambda_{\max}p+B_5$ material with [posts F11 and F12](../findings/second-order.md) in [second-order.md](../findings/second-order.md).*

| step | claim | verdict |
| --- | --- | --- |
| 0 | novelty, the record holds no bound of this kind | **PLAUSIBLE, and the lemma's own framing of it is wrong** (N1, N2) |
| 1 | $\sup\lvert P\rvert=\sup P$, attained at a critical point with $\theta=P(W)$ | **CONFIRMED**, and unnecessary (D1) |
| 2 | $\theta\le\lambda_{\max}p+B_5$ applies there | **CONFIRMED**, the borrowed bound is pointwise at unit norm, so there is no domain violation (D2) |
| 3 | $\lambda_{\max}p\le1$ | **CONFIRMED** (D3) |
| 4 | $0\le\langle T_\alpha\mu,\mu\rangle\le2$ from the pair cap and AM–GM | **CONFIRMED**, index bookkeeping and both normalisations check (D4) |
| 5 | $\sum_\alpha\langle T_\alpha\mu,\mu\rangle^2\le4(n-2)$, so $B_5\le\sqrt{n-2}$ | **CONFIRMED** (D5) |
|, | **the inequality itself** | **CONFIRMED** |
|, | "it does not reach the $O(1)$ regime in which [r443](REVIEW_r443.md)'s estimate returns $\Theta(n^{-3/2})$" | **REFUTED, the lemma understates itself** (D6) |

**The headline.** The mathematics survives every attack in the brief: the five steps are individually correct, the two marginals are simultaneously consistent in the record's own inner product, the index bookkeeping in step 4 is right, and the factor of $2$ the brief warns about is not there. What fails is the framing, and it fails in the one way this file could least afford: **the sentence "against a measured supremum of $\approx1.5449$" is the identical error for which [Lemma L142](../findings/bounds.md) was withdrawn eighteen lines above it, in the same file, under the heading that records it.** Separately, the lemma undersells its own consequence, $O(\sqrt n)$ already saturates [r443](REVIEW_r443.md)'s chain at $n^{-3/2}$, so the $O(1)$ that [I31](../plan.md) demands buys the constant and not the exponent.

---

## N1, novelty screen: no recorded THEOREM reaches $1+\sqrt{n-2}$, and the lemma is new

I swept [findings/](../findings/) by value rather than by vocabulary for every uniform upper bound on $\sup_{\lVert W\rVert=1}\lvert P\rvert$ or on $M(n)$. What is there:

| recorded bound | home | worst case at $\lVert W\rVert=1$ |
| --- | --- | --- |
| $\theta\le\sqrt y+(n-2)y$, $y=\lVert\lambda\rVert_4^2$ | [second-order.md](../findings/second-order.md), and cited at [L142's withdrawal](../findings/bounds.md) | $n-1$ |
| $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, [Lemma L107](../findings/bounds.md), derived twice | [bounds.md](../findings/bounds.md) | $n-1$ |
| $\theta\le\tfrac12\sqrt{(n-1)G_2}$, [Lemma L108](../findings/bounds.md) | [bounds.md](../findings/bounds.md) | not uniform in $n$ without a $G_2$ cap |
| $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$, [Lemma L70](../findings/bounds.md) / L73 | [bounds.md](../findings/bounds.md) | $n-2$, since $\operatorname{tr}_{\Lambda^2}W=0$ forces $\lambda_{\min}\le0$ |
| $\theta\le\lambda_{\max}(M(\lambda))$ | [second-order.md](../findings/second-order.md) | no proved a-priori cap; the $\theta_0(n)$ reading there is explicitly conditional |
| $\theta\le1.5444$ at rank $\le3$ | [second-order.md](../findings/second-order.md) | proved, but only on rank $\le3$ |

**Every proved uniform bound on the record is $\Theta(n)$.** So L143's conclusion, and nothing stronger of its kind, is already there as a theorem, the screen the brief asked for comes back clean, and this is not a second L142.

*One correction to the lemma's own comparison, minor:* the record's standing constant is $n-2$, not $n-1$. [Lemma L70](../findings/bounds.md)'s $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$ gives $n-2$ at unit norm, because total trace-freeness on $\Lambda^2$ puts $\lambda_{\min}\le0$ and $\lambda_{\max}\le1$. The improvement is $n-2\to1+\sqrt{n-2}$, which does not change the lemma's point.

## N2, the order $\sqrt{n-2}$ was already on the record, as a measurement, from these same two marginals

[Post F10](../findings/fence-posts.md) records an LP over exactly L143's raw material, $T\ge0$, totally symmetric, row marginals $2(n-2)$, pair caps $2$, plus $\operatorname{tr}(W^\#)=-1$, and its optimum is **near $0.80\sqrt{n-2}$**: $1.6059$ at $n=6$, $2.53$ at $n=12$, with the same figures in [bounds-relaxations.md](../findings/bounds-relaxations.md).

Two consequences the lemma should carry:

- **The order is not new to the record.** "Improving the record's $n-1$ to $O(\sqrt n)$" reads as though $\sqrt n$ were discovered here. It was measured at [post F10](../findings/fence-posts.md), from this constraint set, with the constant $0.80$ rather than $1$, and the value $1+\sqrt{n-2}$ sits **above** the LP at every $n$ where the LP was run ($3$ against $1.6059$ at $n=6$; $4.162$ against $2.53$ at $n=12$).
- **What is new is the theorem**, at every $n$ and by hand, where post F10 has numbers at three values of $n$. That is a real contribution and it is the one to claim. The honest sentence is *"post F10 measured this order from these marginals; L143 proves it, at a constant $1.25\times$ worse asymptotically."*

*This does not withdraw anything.* An LP solved at $n=6,9,12$ is not a theorem for all $n$, and the fitted $0.80\sqrt{n-2}$ is a fit. The claim being corrected is the framing, not the result.

## D1, step 1 is correct, and is a detour the proof does not need

Each link holds. $Q$ is quadratic, so $Q(-W)=Q(W)$ and $P(-W)=\langle-W,Q(W)\rangle=-P(W)$: $P$ is odd. $\mathcal W_n$ is a linear space, hence closed under $W\mapsto-W$, so the unit sphere is too and $\sup\lvert P\rvert=\sup P$. The sphere is compact and $P$ continuous, so the supremum is attained. $Q$ maps $\mathcal W_n$ to itself, proved on the record at [problem.md](../findings/problem.md) and load-bearing here, since otherwise $\nabla P=3Q$ would need a projection, so Lagrange gives $Q(W)=cW$, which is [conventions.md](../findings/conventions.md)'s definition of a critical point, and pairing against $W$ gives $c=\langle W,Q(W)\rangle=P(W)=\theta$ at $\lVert W\rVert=1$.

**But none of it is used.** See D2: the borrowed bound holds at every unit-norm $W$. The lemma would be shorter and strictly more robust stated as "$\lvert P(W)\rvert\le\lambda_{\max}p+B_5\le1+\sqrt{n-2}$ pointwise at $\lVert W\rVert=1$, and $\sup\lvert P\rvert$ follows". As written, step 1 imports compactness, oddness and the Lagrange condition to reach a set the argument never needs to be on.

## D2, the domain question, which is where I expected this to die, comes back clean

The brief's sharpest line of attack is that $\theta\le\lambda_{\max}p+B_5$ might hold only on a subclass. It does not. Its derivation in [second-order.md](../findings/second-order.md) is, in an eigenbasis of $W$ with $T=c'^2$ transported there and $\mu=\lvert\lambda\rvert$:

- $\operatorname{tr}W^3=\sum_\alpha\lambda_\alpha^3\le\lambda_{\max}\sum_{\lambda>0}\lambda^2=\lambda_{\max}p$, because the negative eigenvalues contribute $\le0$ and may be dropped;
- $\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma\le\tfrac12\sum_\alpha\mu_\alpha\langle T_\alpha\mu,\mu\rangle\le\tfrac12\lVert\mu\rVert\big(\sum_\alpha\langle T_\alpha\mu,\mu\rangle^2\big)^{1/2}=B_5$, by $T\ge0$ and one Cauchy–Schwarz with $\lVert\mu\rVert=1$.

**Criticality appears nowhere in either half.** Three independent confirmations that the record reads it this way: [second-order.md](../findings/second-order.md) takes the supremum over $r$-planes with every Weyl constraint dropped except trace-freeness, which is a statement about all of $\mathrm{Weyl}_n$; the same file poses the open question as $\sup\{\lambda_{\max}p+B_5:W$ an algebraic curvature operator, $\lVert W\rVert=1\}\le\sqrt3$; and [I31](../plan.md) states the target as a supremum over $\lVert W\rVert=1$. So the borrowed quantity is used **inside** its domain, with room to spare. No finding.

## D3, step 3 holds, and the "$1$" is inert exactly where the lemma is used

$p=\sum_{\lambda>0}\lambda_\alpha^2\le\sum_\alpha\lambda_\alpha^2=1$ and $\lambda_{\max}^2\le\sum\lambda^2=1$, both under [conventions.md](../findings/conventions.md)'s $\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$ at $\lVert W\rVert=1$. Correct.

*Worth recording where the looseness sits, since the lemma's own note does not say it.* $\lambda_{\max}p=1$ needs $\lambda_{\max}=1$ and $p=1$, i.e. $W$ of rank one, impossible for a trace-free operator, and $B_5=0$ identically at rank $\le2$ (recorded in [second-order.md](../findings/second-order.md)). So the two summands of $1+\sqrt{n-2}$ are never near their maxima together. More sharply, [post F11](../findings/second-order.md) is the statement that this first term is the inert one: where $P$ is large, $\operatorname{tr}W^3$ is $0.0225$ against a $\#$-term of $1.2136$. **The "$1$" in the headline is post F11's dead term**, and $\sqrt{n-2}$ is the whole of the content.

## D4, step 4: the index bookkeeping is right, and so is the normalisation

Written out, with $T$ totally symmetric and nonnegative:

$$\langle T_\alpha\mu,\mu\rangle=\sum_{\beta\gamma}T_{\alpha\beta\gamma}\mu_\beta\mu_\gamma\;\le\;\tfrac12\sum_{\beta\gamma}T_{\alpha\beta\gamma}(\mu_\beta^2+\mu_\gamma^2)\;=\;\sum_{\beta\gamma}T_{\alpha\beta\gamma}\mu_\beta^2\;=\;\sum_\beta\mu_\beta^2\Big(\sum_\gamma T_{\alpha\beta\gamma}\Big)\;\le\;2\sum_\beta\mu_\beta^2\;=\;2 .$$

The middle equality is the $\beta\leftrightarrow\gamma$ symmetry of $T$, which [conventions.md](../findings/conventions.md) supplies from total antisymmetry of $c_{abc}$; $\sum_\gamma T_{\alpha\beta\gamma}$ is indeed the pair cap for the pair $(\alpha,\beta)$, that being $\lVert[v_\alpha,v_\beta]\rVert^2$; and $\sum_\beta\mu_\beta^2=\lVert\lambda\rVert^2=1$ is [conventions.md](../findings/conventions.md)'s unit normalisation. **The AM–GM does collapse as claimed.**

**The factor-of-two question the brief flags is the one place this could have died, and it does not.** The pair cap $\le2$ and the row mass $=2(n-2)$ have to hold in *one* inner product, and the record states both in a single line of [conventions.md](../findings/conventions.md) without saying which. They are simultaneously true in $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, which is the record's $\Lambda^2$ inner product:

- $\varphi_{ab}=E_{ab}-E_{ba}$ is then already a unit vector, and $[\varphi_{12},\varphi_{23}]=\varphi_{13}$ gives $\lVert[v_\alpha,v_\beta]\rVert^2=1$ on a coordinate pair, comfortably inside the cap;
- the cap $2$ is attained, not merely asserted: a unit $X$ has $\lVert\mathrm{ad}_X\rVert_{\rm op}=\max\lvert\theta_j\pm\theta_k\rvert$ with $\sum\theta_j^2=1$, which is $\sqrt2$ at $X=(\varphi_{12}+\varphi_{34})/\sqrt2$;
- $v_\alpha=\varphi_{12}$ brackets nontrivially with exactly the $2(n-2)$ basis elements sharing one index, each contributing $1$, so the row mass is $2(n-2)$ **exactly**.

*Screen, reported as a screen*, seconds of compute on bases I constructed for the purpose, no bearing on any positive claim: in the coordinate basis and in a randomly rotated one (the eigenframe's shape) at $n=4,5,6,7$, $T$ is totally symmetric to $3\times10^{-16}$, $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ to machine precision in **every** row and **both** frames, and a random search over unit $Y$ in $\mathfrak{so}(4)$ reaches $\lVert[X,Y]\rVert^2=1.9757$ against the cap $2$. Basis-independence of the row mass is in any case a theorem (it is $-\operatorname{tr}(\mathrm{ad}_{v_\alpha}^2)$) which is what licenses using it in $W$'s eigenframe.

**And the two levels of the $\tfrac12$ are used in the right places**, which is the trap [conventions.md](../findings/conventions.md) exists to prevent: the $\tfrac12$ belongs to the inner product on elements of $\Lambda^2$ (where the eigenvectors $v_\alpha$ live, and where the cap and the row mass are stated), while $W$ is an operator on $\Lambda^2$ normalised by $\operatorname{tr}(W^2)=1$ with no $\tfrac12$. L143 takes $\lVert\mu\rVert=1$ from the second and the marginals from the first. Correct.

## D5, step 5: both uses are legitimate, and the estimate is optimal for its input

With $x_\alpha:=\langle T_\alpha\mu,\mu\rangle$:

- $x_\alpha\ge0$ since $T\ge0$ and $\mu\ge0$; $x_\alpha\le2$ is D4. So $x_\alpha^2\le2x_\alpha$ termwise and $\sum_\alpha x_\alpha^2\le2\sum_\alpha x_\alpha$. Correct.
- $\sum_\alpha x_\alpha=\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\mu_\beta\mu_\gamma\le\sum_\beta\mu_\beta^2\sum_{\alpha\gamma}T_{\alpha\beta\gamma}=2(n-2)$. **The free index is the one being summed against $\mu_\beta^2$, and that is the check the brief asks for**: after the AM–GM the free index is $\beta$, and $\sum_{\alpha\gamma}T_{\beta\alpha\gamma}=2(n-2)$ is the row mass with free index $\beta$, available because $T$ is totally symmetric. Correct.

Hence $\sum_\alpha x_\alpha^2\le4(n-2)$ and $B_5\le\tfrac12\cdot2\sqrt{n-2}=\sqrt{n-2}$.

*And this is the best the two marginals give through this route.* Maximising $\sum x_\alpha^2$ subject to $0\le x_\alpha\le2$ and $\sum x_\alpha\le2(n-2)$ is an LP whose optimum puts $(n-2)$ coordinates at $2$ and the rest at $0$, giving exactly $4(n-2)$. So the lemma's remark that "the two marginals are the whole of its input" is right about this chain, though [post F10](../findings/fence-posts.md)'s LP shows the same marginals plus positivity, symmetry and $\operatorname{tr}(W^\#)=-1$ do better by $1.25\times$, so the marginals are not the whole of what the marginals can give.

*One tension with the lemma's closing citation.* It cites [post F12](../findings/second-order.md) ("a single flatness inequality cannot cap $M(n)$") as explaining why this stops at $O(\sqrt n)$, saying the lemma "uses one inequality for both" regimes. That is close to right but not what F12 fences: F12 is about $\sqrt y+(n-2)y$, and [reduction 1](../findings/second-order.md) in the same file records that $B_5$ is a strictly sharper object ($B_5\le(n-2)\lVert\lambda\rVert_4^2$, worst observed ratio $0.9748$). The two are also incomparable pointwise (L143's estimate wins for $y>1/\sqrt{n-2}$ and the flatness bound wins for flat spectra) so a successor should carry the minimum of the two, not this one alone.

## D6, the defect: "a measured supremum of $\approx1.5449$" is L142's withdrawn error, repeated in the same file

L143 writes: *"At $n=12$ it gives $4.162$ against the record's $n-1=11$ and against a measured supremum of $\approx1.5449$, so it is a factor $2.6$ better than what [I2](../plan.md) currently uses and a factor $2.7$ short of the truth."*

$4.162/1.5449=2.694$, so the sentence is dividing by $1.5449$ and calling the quotient the distance to **the truth**. But $1.5449$ is not a measurement of $\sup\lvert P\rvert$. [second-order.md](../findings/second-order.md) is explicit that it is what seeded ascent **on the bound** $\lambda_{\max}p+B_5$ reaches, and that "what is owed is the supremum as a theorem, not these values". The measured/conjectured supremum of $P$ itself at $n=12$ is $\theta_0(12)=1.236033$, and $1.5449$ sits above it, above $\sqrt{3/2}$, and pointing a successor above the target $\sqrt2$.

**This is verbatim the second of the three framing errors recorded against [Lemma L142](../findings/bounds.md), eighteen lines above L143 in the same file**: *"the record's numerics put the true supremum near $1.545$", that figure is the supremum of a **relaxation bound**, not of $P$, and points a successor above the true target $\sqrt2$.* The lemma reproduced the error under the notice that records it.

The repair is one clause, and it makes the lemma read better rather than worse:

> At $n=12$ it gives $4.162$, against the record's standing $n-2=10$ and against a conjectured true supremum $\theta_0(12)=1.236033$, a factor $3.4$ short of the truth, and a factor $2.7$ short of the ceiling of its own method, since $\sup(\lambda_{\max}p+B_5)$ is measured at $\approx1.5449$ and no argument through that bound can go below it.

That last clause is the useful one and it is not currently anywhere in the lemma: **$1.5449$ is the floor of this route**, so L143's own chain can be improved by at most a further factor of $2.7$ at $n=12$, and never past $\sqrt{3/2}$ at any $n$.

## D7, the lemma understates its own consequence for [I2](../plan.md): $O(\sqrt n)$ already buys the exponent

L143 closes: *"it does not reach the $O(1)$ regime in which [r443](REVIEW_r443.md)'s estimate returns $\Theta(n^{-3/2})$."* Take [r443](REVIEW_r443.md)'s own displayed chain, with $c_p=\Theta(1/n)$:

$$r_n\;\gtrsim\;\min_{0\le u\le1/2}\ \min\left(\frac{c_p+u^2}{\lvert P\rvert_\infty+nu},\ \frac{\sqrt{c_p+u^2}}{n}\right).$$

Substitute $u=s/\sqrt n$. The first branch becomes $(a+s^2)\big/\big(n^{3/2}(C+s)\big)$ when $\lvert P\rvert_\infty=C\sqrt n$, minimised at $s=-C+\sqrt{C^2+a}$ with value $\Theta(n^{-3/2})$; for $u=\Theta(1)$ it is $\Theta(1/n)$, larger. The second branch is increasing in $u$ and equals $\sqrt a\,n^{-3/2}$ at $u=0$. **So $\lvert P\rvert_\infty=O(\sqrt n)$ already gives $r_n=\Omega(n^{-3/2})$**, the same exponent $O(1)$ gives, because the defect-tail branch caps the chain at $n^{-3/2}$ regardless. Running the same substitution with $\lvert P\rvert_\infty=n-1$ returns $\Theta(n^{-2})$, reproducing r443's other branch, which is the control that the reading is right.

The threshold is exactly $\sqrt n$: any $\lvert P\rvert_\infty=O(\sqrt n)$ saturates the chain, anything $\omega(\sqrt n)$ degrades it. **L143 sits on the threshold and therefore unblocks I2's exponent as it stands.** What [I31](../plan.md)'s absolute constant $K$ would buy is the constant in $r_n$, not the exponent, which is worth knowing before another cycle is spent on $K$.

*Held at the strength of its source.* This rests on r443's D5 chain, which is a reviewer's construction rather than an audited lemma, and on $c_p=\Theta(1/n)$. If D5 is wrong the conclusion goes with it; the point stands that the lemma's closing sentence asserts the opposite of what the record's own estimate gives.

---

## Vacuity check

**The inequality is not vacuous.** It is unconditional, it is strictly below every proved uniform bound on the record from $n=5$ up ($1+\sqrt{n-2}<n-2$ at $n=5$, $2.732$ against $3$, and the gap widens, $4.162$ against $10$ at $n=12$; only at $n=4$ is it weaker, $2.414$ against $2$), and by D7 it is enough to move an exponent the record currently believes is stuck.

**Two things about it are close to vacuous and should be said in the lemma.** The "$+1$" is [post F11](../findings/second-order.md)'s inert term, contributing nothing where $P$ is large. And Conjecture A trivially implies $\sup\lvert P\rvert\le\theta_0(n)<\sqrt2$, so the lemma says nothing the conjecture does not, its value is entirely that it is unconditional, which is the right claim and is the one the lemma makes.

**Where it would have been vacuous and is not:** if the borrowed $\theta\le\lambda_{\max}p+B_5$ had been a critical-point statement, step 1 would have been load-bearing and the lemma would have been bounding $P$ only on the critical set while claiming a supremum over the sphere. It is not; see D2.

## Verdict

**CONFIRMED as an inequality.** Steps 1–5 are each correct, the borrowed bound is used inside its domain, the index bookkeeping in step 4 survives being written out, and the pair cap and the Killing row mass are simultaneously consistent in the record's own $\Lambda^2$ inner product with no factor of $2$ astray.

**Three corrections owed to the surrounding prose**, none touching the proof:

1. **The $1.5449$ sentence is L142's withdrawn framing error, repeated eighteen lines below its own withdrawal notice.** $1.5449$ is the supremum of the relaxation bound, not of $P$; the comparand at $n=12$ is $\theta_0(12)=1.236033$ and the factor short is $3.4$. Repair in D6, which also converts the number into the useful statement, it is the floor of this route.
2. **The novelty claim needs the qualifier [post F10](../findings/fence-posts.md) supplies** (N2): the order $\sqrt{n-2}$ from these two marginals was already measured, with a better constant, and $1+\sqrt{n-2}$ is above the LP at every $n$ the LP was run at. What is new is the theorem.
3. **The closing sentence is backwards** (D7): $O(\sqrt n)$ already saturates [r443](REVIEW_r443.md)'s chain at $n^{-3/2}$, so the lemma unblocks [I2](../plan.md)'s exponent and [I31](../plan.md)'s $K$ is a claim about the constant.

*Minor, for the same pass:* the record's standing bound is $n-2$ from [Lemma L70](../findings/bounds.md), not $n-1$ (N1); step 1 can be dropped, the bound being pointwise (D1); and a successor should carry $\min\big(1+\sqrt{n-2},\ \sqrt y+(n-2)y\big)$, the two being incomparable pointwise (D5).

---

*Reviewer r444, 2026-09-03. Analysis only under [analysis-only.md](../.claude/rules/analysis-only.md); the one computation is the screen in D4, on bases constructed for it, cited for nothing positive. Log: [r444-L143.log](../agent_logs/r444-L143.log).*
