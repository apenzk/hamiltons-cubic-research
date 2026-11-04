# Review r407, Gate 2 on the $\theta=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$ split and the "$\#$-ceiling" reduction

*Adversarial review of the last two sections of [ATTEMPTS.md](../ATTEMPTS.md), 2026-09-03, run cold. Normalisation re-derived from [conventions.md](../findings/conventions.md) and cross-checked against [r405](REVIEW_r405.md) and [r406](REVIEW_r406.md) before the sections were opened; the diagonal $\#$-formula, the split, and both named critical points were re-derived by hand before any findings file was consulted. **Analysis only, inherited.** Every number below is exact closed form, confirmed by a **screen** (seconds of arithmetic on two spectra constructed for the purpose) and every verdict also has a proof that needs no run.*

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| 1 | $\theta=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$ at every critical point | **CORRECT** as algebra, and **ON RECORD unrestricted at least four times.** The novelty claim is withdrawn |
| 2 | $\mathop{\mathrm{tr}}W^3\le\frac{N-2}{\sqrt{N(N-1)}}$, maximised at one-large-against-$(N-1)$-equal | **CORRECT** as an optimisation. But it improves the record's own $\mathop{\mathrm{tr}}W^3\le1$ by $0.0229$ at $n=12$, and by $\to0$ as $n\to\infty$ |
| 3 | $\langle W,W^\#\rangle\ge0.2476$ at every critical point in the band | **CORRECT and vacuous.** True value $1.2136$ at $S^6\times S^6$ and $0.8165$ at padded $W_{\mathbb{CP}^2}$, the floor is a factor $4.9$ and $3.3$ below the truth, and the record already carried both numbers |
| 4 | $\theta\le\sqrt{3/2}$ follows from $\langle W,W^\#\rangle\le\sqrt{3/2}-c_N$; "the two bounds meet" | **REFUTED.** The sufficient condition is **false at padded $W_{\mathbb{CP}^2}$**, which is the [I1](../plan.md)'s own equality case: $0.8165$ against a demanded $0.2476$. The "meeting" is a tautology, not a coincidence |
| 5 | Nothing in [findings/](../findings/) bounds $\langle W,W^\#\rangle$ above | **REFUTED.** [second-order.md](../findings/second-order.md) carries **four** upper bounds on it, one of them evaluated at padded $W_{\mathbb{CP}^2}$ in the same paragraph |

## The normalisation, fixed first

[conventions.md](../findings/conventions.md) puts the operator at $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$, with $\mathop{\mathrm{tr}}W=0$ and $\mathop{\mathrm{tr}}W^\#=-1$; the letter $M$ (or $K$) is the $n\times n$ **sectional** matrix at $\lVert K\rVert_F^2=2$ over **ordered** pairs. This review works entirely at the $\Lambda^2$ operator. The trace of criticality is the check that the three constants are mutually consistent: $\mathop{\mathrm{tr}}W^2+\mathop{\mathrm{tr}}W^\#=\theta\mathop{\mathrm{tr}}W=0$ gives $\mathop{\mathrm{tr}}W^2=1$, which is the stated normalisation and not an independent choice. Both test points below reproduce $\mathop{\mathrm{tr}}W=0$ to $5\times10^{-16}$ and $\mathop{\mathrm{tr}}W^\#=-1$ to $3\times10^{-15}$, so nothing here is running in the $\sum\lambda^2=2$ convention that produced [post F53](../findings/second-order.md).

**The diagonal $\#$-formula, re-derived rather than quoted.** For $W$ diagonal in coordinate bivectors with sectional matrix $K$ (symmetric, hollow, $K\mathbf1=0$), the structure constants of $\mathfrak{so}(n)$ in the $e_a\wedge e_b$ basis give $(W^\#)_{(ab)(ab)}=\sum_c K_{ac}K_{bc}=(K^2)_{ab}$. Hence

$$\mathop{\mathrm{tr}}W^3=\sum_{a<b}K_{ab}^3=\tfrac12\langle K^{\circ2},K\rangle,\qquad \langle W,W^\#\rangle=\sum_{a<b}K_{ab}(K^2)_{ab}=\tfrac12\mathop{\mathrm{tr}}(K^3),$$

which reproduces [diagonal-half.md](../findings/diagonal-half.md)'s recorded split independently. It also shows $\mathop{\mathrm{tr}}W^\#=\tfrac12(\lVert K\mathbf1\rVert^2-\mathop{\mathrm{tr}}K^2)=-1$ is *exactly* the Weyl trace condition $K\mathbf1=0$ on this locus.

## Claim 1, correct, and on record unrestricted

Pairing $Q(W)=\theta W$ with $W$ at $\lVert W\rVert=1$ gives $\theta=\langle W,W^2\rangle+\langle W,W^\#\rangle$, and $W$ symmetric makes $\langle W,W^2\rangle=\mathop{\mathrm{tr}}W^3$ with no factor. The pairing carries no factor either: $P(W)=\langle W,Q(W)\rangle$ is plain Frobenius on the $\Lambda^2$ operator, and the $\tfrac12$ that [conventions.md](../findings/conventions.md) warns about lives at the $\Lambda^2$ level of a *skew matrix*, not on the operator. **So the identity is right.**

**The novelty claim is not.** ATTEMPTS says the split is recorded "only on the diagonal locus, in $M$-coordinates". It is recorded, unrestricted, in at least four places:

- [graded-half.md](../findings/graded-half.md), line 213: "*The two equations sum to the definition of $\theta$, $\theta\lVert W\rVert^2=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$, identically*", with the further point that this makes the graded pair contain exactly one independent equation.
- [stratum-two-negative.md](../findings/stratum-two-negative.md), line 495, which calls it "**the tautology** $\langle W,W^\#\rangle=\theta-\mathop{\mathrm{tr}}W^3$" and records it as the only use that file has ever made of the uncontracted rows.
- [second-order.md](../findings/second-order.md), post F11, which uses the split at $S^6\times S^6$ **with the same two numbers ATTEMPTS now reports as new**.
- [curvature-invariants.md](../findings/curvature-invariants.md), which tabulates the split at $S^3\times S^3$ and $\mathbb{CP}^3$ as $(0.105,0.949)$ and $(0.545,0.509)$, and builds the Ricci-flat cubic $2$-plane on it.

## Claim 2, the optimisation is right, and it buys $0.0229$

Maximising $\sum\lambda^3$ over $\mathbb R^N$ subject to $\sum\lambda=0$, $\sum\lambda^2=1$: the Lagrange condition $3\lambda_i^2=2a\lambda_i+b$ forces at most two distinct values, so write $k$ copies of $r$ and $m=N-k$ of $s$. The constraints give $r=\sqrt{m/(kN)}$, $s=-\sqrt{k/(mN)}$, and

$$\sum\lambda^3=\frac{m^{3/2}}{k^{1/2}N^{3/2}}-\frac{k^{3/2}}{m^{1/2}N^{3/2}}=\frac{m^2-k^2}{N^{3/2}\sqrt{km}}=\frac{N-2k}{\sqrt{Nk(N-k)}}=:f(k).$$

$f$ is decreasing in $k$, $0.97713,\ 0.67455,\ 0.53722,\ 0.45335$ at $k=1,2,3,4$ for $N=66$, so the maximiser is $k=1$ and the value is $f(1)=\frac{N-2}{\sqrt{N(N-1)}}$. **Verified at $N=66$: $64/\sqrt{4290}=0.9771277064839348$.** So $c_N$ and its arithmetic are correct.

**What it is worth is the point.** [Post F11](../findings/second-order.md) already states "*at unit norm $\mathop{\mathrm{tr}}W^3\le1$*", which follows in one line from $\sum_{\lambda>0}\lambda^3\le\lambda_{\max}\sum_{\lambda>0}\lambda^2\le1$. Claim 2 replaces $1$ by $0.9771$ at $n=12$, and $c_N\to1$, so the improvement decays to nothing as $n$ grows. The maximising spectrum is also unreachable: it is $W\approx vv^\top+bI$ with $b=-1/N$, and $\mathrm{Id}$ on $\Lambda^2$ is the round-sphere operator, which is not Weyl, so the cap is not attained anywhere on $\mathcal W_n$, and the record's own catalogue puts the true $\mathop{\mathrm{tr}}W^3$ between $0.0225$ and $0.545$ at every named critical point.

## Claims 1–3 at the two named points, both pass, both trivially

Both points were built from their definitions and evaluated at $\Lambda^2$ Frobenius. **Screened**, exactly as the analysis-only rule permits, on objects constructed here for the purpose.

**Balanced sphere product $S^6\times S^6$ at $n=12$.** With unit radii, $\mathrm{Ric}=5g$ throughout and $\mathrm{scal}=60$, so $K_{ab}=\sec_{ab}-\tfrac1{10}(\mathrm{Ric}_{aa}+\mathrm{Ric}_{bb})+\tfrac{60}{110}=\sec_{ab}-\tfrac5{11}$: entries $\tfrac6{11}$ within a factor ($30$ pairs) and $-\tfrac5{11}$ across ($36$ pairs). Normalising, $\mathop{\mathrm{spec}}(K)=\{60/11,\ (-6/11)^{\times10},\ 0\}$ up to scale.

**Padded $W_{\mathbb{CP}^2}$.** $\mathop{\mathrm{diag}}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2\mathbb R^4$, zero-padded, per [problem.md](../findings/problem.md) line 213. Ricci-flat in dimension $4$, so the padding lands inside $\mathrm{Weyl}_n$ and $\theta=\sqrt{3/2}$ at every $n$.

| point | $\theta$ | $\mathop{\mathrm{tr}}W^3$ | $\langle W,W^\#\rangle$ | floor $\sqrt{3/2}-c_{66}$ | claim 3 |
| --- | --- | --- | --- | --- | --- |
| $S^6\times S^6$, $n=12$ | $1.2360330812=\theta_0(12)$ | $0.0224733287$ | $1.2135597524$ | $0.2476171649$ | holds, $4.90\times$ slack |
| padded $W_{\mathbb{CP}^2}$, $n=12$ | $1.2247448714=\sqrt{3/2}$ | $1/\sqrt6=0.4082482905$ | $2/\sqrt6=0.8164965809$ | $0.2476171649$ | holds, $3.30\times$ slack |

Both rows reproduce $\sum\lambda^2=1$, $\mathop{\mathrm{tr}}W=0$, $\mathop{\mathrm{tr}}W^\#=-1$ and the split to $10^{-15}$, and the $S^6\times S^6$ row reproduces $\theta_0(12)=\sqrt{220}/12$ to twelve digits, so claim 1 is confirmed at a named non-trivial point in the record's own normalisation. **Claim 3 is not refuted. It is also not informative**: [post F11](../findings/second-order.md) already records $\langle W,W^\#\rangle=1.2136$ against $\mathop{\mathrm{tr}}W^3=0.0225$ at $S^6\times S^6$, verbatim, and [second-order.md](../findings/second-order.md)'s F12 paragraph already records $\mathop{\mathrm{tr}}W^3=0.4082$ at padded $W_{\mathbb{CP}^2}$.

## Claim 4, REFUTED, at the equality case of the statement it claims to reduce

**The implication itself is valid, and it is not circular.** With $x=\mathop{\mathrm{tr}}W^3$, $y=\langle W,W^\#\rangle$, $s=\sqrt{3/2}$: from $\theta=x+y$ and $x\le c_N$, the hypothesis $y\le s-c_N$ gives $\theta\le s$ by addition. No step assumes the conclusion. The defect is elsewhere and it is fatal.

**The [I1](../plan.md) is $\sup\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}\le\sqrt{3/2}$, and [target.md](../findings/target.md) line 444 records that this supremum is $\sqrt{3/2}$, attained at $W_{\mathbb{CP}^2}$.** Padded $W_{\mathbb{CP}^2}$ is a critical point ([problem.md](../findings/problem.md) line 213, residual $4\times10^{-16}$), has $S=0$, and is **non-diagonal**, Plücker-obstructed at $\min\lVert\omega\wedge\omega\rVert=0.50$ with frame-minimal off-diagonal mass $0.707$, per [diagonality.md](../findings/diagonality.md) lines 15 and 17. It sits in the exact scope ATTEMPTS quantifies over: "*every non-diagonal critical point*".

At that point $y=2/\sqrt6=0.8165$, against the demanded $s-c_{66}=0.2476$. **The hypothesis is false by a factor $3.30$ at the very point that supplies the constant $\sqrt{3/2}$ in the conclusion.**

**And the failure is structural, not a near miss.** For any critical point with $\theta=s$ exactly, $y\le s-c_N$ combined with $y=s-x$ forces $x\ge c_N=0.9771$. The equality case therefore demands $\mathop{\mathrm{tr}}W^3\ge0.9771$ at padded $W_{\mathbb{CP}^2}$, where it is $0.4082$. **A sufficient condition that is false at the equality case of the inequality it is meant to prove can never be proved**, so the object ATTEMPTS asks a successor to hunt for in the $\#$-literature does not exist.

**Nor is it a dimensional accident.** $s-c_N$ decreases in $n$ toward $s-1=0.2247$, while $y$ at padded $W_{\mathbb{CP}^2}$ is $2/\sqrt6$ at **every** $n$, padding preserving the spectrum up to zeros. The violation factor therefore grows from $3.30$ to $3.63$. Repairing the target constant to $\theta_0(n)$ does not save it either: $\theta_0(12)-c_{66}=0.2589$, still violated at both test points.

**The size of the loss, against the size of the window.** The condition $y\le s-c_N$ is equivalent to $\theta\le s-(c_N-\mathop{\mathrm{tr}}W^3)$. The discarded slack $c_N-\mathop{\mathrm{tr}}W^3$ is $0.9546$ at $S^6\times S^6$ and $0.5689$ at padded $W_{\mathbb{CP}^2}$, where the whole margin the argument has to resolve is $\theta_0(12)-\sqrt{3/2}=0.0113$, the width [problem.md](../findings/problem.md) line 260 already names. **The reduction throws away $50$ to $85$ times the width of the window it is meant to close**, which is [post F11](../findings/second-order.md)'s conclusion arrived at from the other side.

**"The two bounds meet" is a tautology, and the meeting is an artefact of $c_N$ appearing twice.** Reading $\theta=x+y$ as a lower bound on $y$ under $\theta\ge s$ gives $y\ge s-c_N$; reading it as an upper bound on $\theta$ under $y\le B$ gives $B=s-c_N$ as the threshold. The same identity and the same cap produce the same number by construction, substitute any $s'$ and both sides move to $s'-c_N$. This carries no information at all. **Worse, taking the two "complementary" statements together pins rather than brackets**: they force $y=s-c_N$, $x=c_N$ and $\theta=s$ exactly, i.e. every critical point in the band would have spectrum $\big(\sqrt{65/66},\ (-1/\sqrt{4290})^{\times65}\big)$. $S^6\times S^6$ has spectrum $(0.13483^{\times30},-0.11236^{\times36})$ and padded $W_{\mathbb{CP}^2}$ has $(0.8165,(-0.4082)^{\times2},0^{\times63})$. Neither is close.

**A note on the word "band".** ATTEMPTS uses "band" for $\theta\ge\sqrt{3/2}$. [target.md](../findings/target.md) line 614 uses it for the stratum $3\le\dim\mathfrak m<\lfloor n^2/4\rfloor$, and on that reading padded $W_{\mathbb{CP}^2}$ is **outside** the band ($\dim\mathfrak m=2$) while $S^6\times S^6$ is outside it at the top. Two live meanings, and the sections do not say which. Claim 3's scope changes under the swap; claim 4's refutation does not, since ATTEMPTS states it over non-diagonal critical points rather than over a band.

## Claim 5, REFUTED

[second-order.md](../findings/second-order.md) carries four upper bounds on $\langle W,W^\#\rangle$, three of them in the same two paragraphs ATTEMPTS' numbers came from:

- $\langle W,W^\#\rangle\le(n-2)y$ with $y=\lVert\lambda\rVert_4^2$ (line 334), the flatness bound whose leading term is asymptotically exact.
- $\langle W,W^\#\rangle\le\tfrac12\sum_\alpha\mu_\alpha\langle T_\alpha\mu,\mu\rangle\le\tfrac12\sqrt{\sum_\alpha\langle T_\alpha\mu,\mu\rangle^2}=:B_5$ (line 346), **evaluated at padded $W_{\mathbb{CP}^2}$ in the next sentence, where it "replaces $7.07$ by $1.00$" against the truth $0.8165$.**
- $\langle W,W^\#\rangle\le6\lambda_1ab$ and $\langle W,W^\#\rangle\le(\lambda_1+b)[(\sigma^2-p)+2ab]+b$ on the rank-two-negative stratum ([stratum-two-negative.md](../findings/stratum-two-negative.md) lines 23 and 57).

Beyond those, [fence-posts.md](../findings/fence-posts.md) line 35 records [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Lemma 2.14 bounding $\langle Q(W),W\rangle$ whole. So the record has both halves bounded and the whole bounded; **what it lacks is a bound tight enough to separate $\sqrt{3/2}$, which is a different statement from "no ceiling exists".** The existing $B_5$ reaches $1.00$ at padded $W_{\mathbb{CP}^2}$, already within $22\%$ of the truth there, and already far below anything the split route could use.

## What survives

**One identity, one cap, and a correctly stated consequence.** $\theta=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$ is right (and recorded). $\mathop{\mathrm{tr}}W^3\le c_N$ is right (and marginal over the recorded $\le1$). The consequence that survives is the *point-dependent* one, which is the identity itself:

$$\text{I1}\iff \langle W,W^\#\rangle\le\sqrt{3/2}-\mathop{\mathrm{tr}}W^3\ \text{ at every non-diagonal }S=0\text{ critical point},$$

with equality at padded $W_{\mathbb{CP}^2}$. **Replacing $\mathop{\mathrm{tr}}W^3$ by its unconstrained maximum $c_N$ is what destroys it**, because $\mathop{\mathrm{tr}}W^3$ is small exactly where $\theta$ is large, which is [post F11](../findings/second-order.md)'s content, and F11's conclusion ("*any route to $\sqrt3$ must treat the two terms together*") applies verbatim to this route.

**Recommendation.** Withdraw the last two sections' claims 3, 4 and 5, keep claim 1 with the four citations attached and the novelty claim dropped, keep claim 2 as a refinement of F11's $\mathop{\mathrm{tr}}W^3\le1$ with its $0.0229$ stated, and record the refutation as an extension of post F11 rather than as a new post, the mechanism is identical and F11 predicted the outcome.
