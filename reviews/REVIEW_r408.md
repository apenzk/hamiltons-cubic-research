# Review r408, Gate 2 on the $\#$-term split, the $\mathop{\mathrm{tr}}W^3$ cap, and the "single statement about the $\#$-term"

*Cold brief. Derived before opening [ATTEMPTS.md](../ATTEMPTS.md); the derivation is in [agent_logs/gate2-sharp-B.log](../agent_logs/gate2-sharp-B.log), timestamped ahead of the read. Analysis only, no run was opened, and every number below is exact arithmetic on values the record already carries. Target of the review: the section **"A first unconditional statement about the general critical point, in the corrected normalisation"** in [ATTEMPTS.md](../ATTEMPTS.md), and the withdrawn I7 pair above it.*

## Verdicts

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | $\theta=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$ at every critical point | **CONFIRMED** as mathematics; **CORRECTED** as novelty, it is on record unconditionally in four places, and criticality is not used |
| 2 | $\mathop{\mathrm{tr}}W^3\le c_N:=\frac{N-2}{\sqrt{N(N-1)}}$, $=0.9771$ at $n=12$ | **CONFIRMED** exactly; **CORRECTED** as novelty, it is the Tachibana/Huisken cap the record already cites twice |
| 3 | $\langle W,W^\#\rangle\ge\sqrt{3/2}-c_N=0.2476$ in the band | **CONFIRMED**, and slack by $3.30\times$ at padded $W_{\mathbb{CP}^2}$ and $4.90\times$ at $S^6\times S^6$ |
| 4 | $\theta\le\sqrt{3/2}\Longleftarrow\langle W,W^\#\rangle\le\sqrt{3/2}-c_N$, and "the two bounds meet" | **REFUTED**, the hypothesis is false at the target's own equality case; and the implication is a strengthening, not a reduction. The "meeting" is a tautology |
| 5 | "Nothing in [findings/](../findings/) bounds $\langle W,W^\#\rangle$ above" | **REFUTED**, three upper bounds are on record, one of them **sharp**, and it is $4.90\times$ the value the route needs |

**Point 4 is the one that decides the section, and it decides it against.** The route is fenced by [post F1](../findings/fence-posts.md) and by [post F2 item 2e](../findings/fence-posts.md), each of which was written to stop exactly this shape.

## The cold derivation, in full

**The split needs neither criticality nor a locus.** $\theta$ is *defined* as $P(W)/\lVert W\rVert^3$ with $P(W)=\langle W,Q(W)\rangle$ ([conventions.md](../findings/conventions.md)). At $\lVert W\rVert=1$,

$$\theta=\langle W,W^2+W^\#\rangle=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$$

for **every** unit $W$. Pairing $Q(W)=\theta W$ with $W$ reproduces it, but the criticality hypothesis is spent on nothing: it is the definition of $\theta$ unfolded. *That is already the reason it cannot be a reduction, a statement carrying no hypothesis carries no information about the hypothesis.*

**The cap on the spectral term, exactly.** Maximise $\sum_\alpha\lambda_\alpha^3$ over $\mathbb R^N$ subject to $\sum\lambda=0$, $\sum\lambda^2=1$. The Lagrange condition $3\lambda_\alpha^2=2a\lambda_\alpha+b$ makes every $\lambda_\alpha$ a root of one quadratic, so at most two values occur. With $k$ copies of $x$ and $m=N-k$ copies of $y$, the two constraints give $x=t\,m$, $y=-t\,k$, $t=(kmN)^{-1/2}$, hence

$$\sum\lambda^3=\frac{N-2k}{\sqrt{k(N-k)N}},$$

strictly decreasing in $k$ on $1\le k\le N/2$, so the maximum is at $k=1$:

$$\mathop{\mathrm{tr}}W^3\;\le\;c_N=\frac{N-2}{\sqrt{N(N-1)}},\qquad c_{66}=\frac{64}{\sqrt{4290}}=0.9771286 .$$

Claim 2 is exact. **It is also Huisken's cap verbatim**: [problem.md](../findings/problem.md) item 2 quotes Xu's Tachibana-trick inequality $\lvert\mathop{\mathrm{tr}}(T^3)\rvert\le\frac{m-2}{\sqrt{m(m-1)}}\lVert T\rVert^3$ on a trace-free operator, and [nondegeneracy.md](../findings/nondegeneracy.md) calls the same expression "Huisken's cap $(m-2)/\sqrt{m(m-1)}$". Setting $m=N$ is the whole of the derivation.

**Both anchor points, evaluated exactly from the record's own spectral data.**

| | $\mathop{\mathrm{tr}}W^3$ | $\langle W,W^\#\rangle$ | $\theta$ | in band? |
| --- | --- | --- | --- | --- |
| padded $W_{\mathbb{CP}^2}$, $\Lambda^2$ spectrum $(2,-1,-1,0^{N-3})/\sqrt6$ | $\tfrac1{\sqrt6}=0.4082483$ | $\tfrac2{\sqrt6}=0.8164966$ | $\tfrac3{\sqrt6}=\sqrt{3/2}$ | yes, at the boundary |
| $S^6\times S^6$, $n=12$ | $\tfrac1{6\sqrt{55}}=0.0224733$ | $\tfrac9{\sqrt{55}}=1.2135598$ | $\tfrac{\sqrt{55}}6=1.2360331$ | yes, strictly inside |

The $\mathbb{CP}^2$ row is built from [INDEX-values.md](../findings/INDEX-values.md)'s exact $n=5$ construction ($\lVert W_0\rVert^2=1$, $\mathop{\mathrm{tr}}W_0^3=1/\sqrt6$, $\theta=\sqrt{3/2}$); the sphere-product row from the closed forms in [ad-form-attempt.md](../findings/ad-form-attempt.md). **Both satisfy the split identically**, $\tfrac1{\sqrt6}+\tfrac2{\sqrt6}=\tfrac3{\sqrt6}=\sqrt{3/2}$ and $\big(\tfrac16+9\big)/\sqrt{55}=\sqrt{55}/6=\theta_0(12)$, which is the strongest confirmation claim 1 admits, and it is exact rather than numerical.

*The sphere-product pair reproduces [diagonal-half.md](../findings/diagonal-half.md)'s own printed figures, "$1.2136$ against $0.0225$ at $S^6\times S^6$", derived here without reading them.*

## Claim 4, refuted, with the witness the target is built around

**It is a strengthening, not a reduction.** Substituting the identity of claim 1 into the proposed hypothesis:

$$\langle W,W^\#\rangle\le\sqrt{3/2}-c_N \iff \theta-\mathop{\mathrm{tr}}W^3\le\sqrt{3/2}-c_N \iff \theta\le\sqrt{3/2}-\big(c_N-\mathop{\mathrm{tr}}W^3\big).$$

Since $c_N-\mathop{\mathrm{tr}}W^3\ge0$, the hypothesis is the target **minus a nonnegative loss**, and it is strictly stronger wherever $\mathop{\mathrm{tr}}W^3<c_N$. The loss is $0.5689$ at padded $W_{\mathbb{CP}^2}$ and $0.9547$ at $S^6\times S^6$, against a total budget of $\sqrt{3/2}=1.2247$. *So the "reduction" asks for the target with $46\%$ to $78\%$ of its value given away first.*

**And the strengthened statement is false.** The following is one line and settles it.

> **Refutation.** Let $W$ be a unit critical point with $\theta=\sqrt{3/2}$. Then $\langle W,W^\#\rangle\le\sqrt{3/2}-c_N$ forces $\mathop{\mathrm{tr}}W^3\ge c_N$, hence $\mathop{\mathrm{tr}}W^3=c_N$ since $c_N$ is the maximum, hence $\mathop{\mathrm{spec}}(W)=\big(\sqrt{\tfrac{N-1}N},\,-\tfrac1{\sqrt{N(N-1)}}\text{ with multiplicity }N-1\big)$, which at $N=66$ is $(0.992366,\,(-0.012272)^{65})$. Padded $W_{\mathbb{CP}^2}$ is a unit critical point with $\theta=\sqrt{3/2}$, non-diagonal, $S=0$, $\circ$-indecomposable, critical to $10^{-16}$ ([post F35](../findings/fence-posts.md)), and its spectrum is $(0.816497,\,-0.408248,\,-0.408248,\,0^{63})$. $\square$

Numerically the failure is $\langle W,W^\#\rangle=0.8164966$ against a demanded $0.2476163$, a factor $3.2974$; at $S^6\times S^6$ it is $1.2135598$ against the same number, a factor $4.9010$. **The witness is not a stress case, it is the point the target asserts is extremal.** A ceiling that fails at the conjectured equality case is not a route with a hard step in it; it is a false statement.

**Padding removes even the $n$-dependence the claim leans on.** Padding preserves $W^2$, $W^\#$, $\lVert W\rVert$ and $\theta$ ([conventions.md](../findings/conventions.md)), so $\mathop{\mathrm{tr}}W^3$ and $\langle W,W^\#\rangle$ are padding-invariant while $c_N$ increases strictly in $n$. Any critical point can be padded, so the proposed ceiling holding at all $n$ is equivalent to its limit,

$$\langle W,W^\#\rangle\le\sqrt{3/2}-1=0.2247449 ,$$

with no $n$ in it. *The figure "$0.2476$ at $n=12$" therefore cannot be the operative constant; the route's real demand is $0.2247$ uniformly, and $2/\sqrt6$ exceeds it by $3.63\times$.*

**"The two bounds meet" is a tautology.** The floor is derived as $\theta_{\min}-c_N$ over the band and the ceiling is defined as $\theta_{\text{target}}-c_N$; the band's lower endpoint and the target's value are the same number $\sqrt{3/2}$ by construction, so the two expressions are identical before anything is proved. Subtracting one constant from both sides of a threshold does not make two statements complementary, the band $\theta\ge\sqrt{3/2}$ and the target $\theta\le\sqrt{3/2}$ were already complementary, and that is all the observation says. *Its one real consequence runs the other way: the conjunction of floor and ceiling would force $\mathop{\mathrm{tr}}W^3=c_N$ exactly, which is the spectral rigidity the refutation above kills.*

## Claim 5, the record carries a ceiling on $\langle W,W^\#\rangle$, and it is sharp

Three upper bounds, all in [findings/](../findings/):

- **[problem.md](../findings/problem.md) item 9**, the sharp one: $\langle W^\#,W\rangle\le\sqrt2\cdot\frac{n-3}{\sqrt{(n-1)(n-2)}}\lVert W\rVert^3$, **saturated exactly by the balanced sphere product at every even $n$ from $6$ to $20$**. At $n=12$ it is $\sqrt2\cdot9/\sqrt{110}=1.2135598$, the measured value to seven digits, as it must be at a saturation point.
- **[stratum-two-negative.md](../findings/stratum-two-negative.md)**, two more: $\langle W,W^\#\rangle\le6\lambda_1ab$ on the two-negative stratum, and $\langle W,W^\#\rangle\le(\lambda_1+b)\big[(\sigma^2-p)+2ab\big]+b$.

So the object the section calls missing exists, is sharp, and its sharp value is $4.90\times$ the $0.2476$ the route needs. **A ceiling at $0.2476$ is not an unfound object; it is an object the record has already located at $1.2136$ and proved cannot be lowered.**

## The two fence posts this walks into

**[Post F1](../findings/fence-posts.md).** "At the conjectured maximiser essentially all of $P$'s value sits in $\langle W^\#,W\rangle$ … while the Tachibana/Hölder estimates bound only $\mathop{\mathrm{tr}}(W^3)$, asymptotically negligible there, $\mathop{\mathrm{tr}}(W^3)/P=\frac2{(n-1)(n-2)}$ at $S^{n/2}\times S^{n/2}$." At $n=12$: $2/110=0.0181818$, and $0.0224733/1.2360331=0.0181818$. *The section's claim 3 is post F1 read backwards, on a family where post F1 already states the stronger asymptotic fact.*

**[Post F2 item 2e](../findings/fence-posts.md).** "Adding the sharp $\langle W^\#,W\rangle$ bound to the sharp Tachibana/Huisken bound on $\mathop{\mathrm{tr}}(W^3)$ exceeds the true maximum at every $n$ from $6$ to $100$" by $1.7$–$1.8\times$. **The section's proposal *is* that sum.** Filled in at $n=12$: $c_{66}+1.2135598=2.1906884$, against $\theta_0(12)=1.2360331$, a ratio of $\mathbf{1.7724}$, inside 2e's own recorded band. Asymptotically $c_N\to1$ and the sharp $\#$-ceiling $\to\sqrt2$, so the ratio tends to $(1+\sqrt2)/\sqrt2=1.7071$, which is where 2e's range begins. *The fence post is confirmed here by an independent evaluation, and the section is inside it.*

**And [post F34](../findings/fence-posts.md) supplies the criterion this fails.** Its exit condition reads: "a bound on the sharp term that is *not* a rearrangement of $\theta$, that is sharp to $O(n^{-2})$ uniformly, and whose worst case is the extremal family rather than the interior." The proposed ceiling is a rearrangement of $\theta$ (shown above), and it is not merely unsharp at the extremal family, it is violated there by $3.30\times$. **The section is post F34 with the two terms swapped**: F34 relaxed the $\#$-term and kept $\mathop{\mathrm{tr}}M^3$; this relaxes $\mathop{\mathrm{tr}}M^3$ and keeps the $\#$-term. The diagnosis transfers unchanged, and the loss is an order of magnitude larger.

## Where the novelty screen went wrong

The section screens against [diagonal-half.md](../findings/diagonal-half.md) only, and concludes "only the unconditional half below is new". The unconditional half is on record in four places:

| where | what it says |
| --- | --- |
| [ad-form-attempt.md](../findings/ad-form-attempt.md) line 3 | "Route R2 localises $\theta$ in one term: $\theta=\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle$", for the general unit Weyl operator, and the file's own $\mathop{\mathrm{tr}}(M^\#)=-1$ fixes $M$ as the $\Lambda^2$ operator |
| [INDEX.md](../findings/INDEX.md) row 57 | the same formula, in the index, as the headline of that file |
| [bispectral.md](../findings/bispectral.md) lines 27–29, 128 | the split is an *input* to the bi-spectral identity's proof, at every $n\ge4$, residual $\le5\times10^{-16}$ on random Weyl tensors |
| [post F25](../findings/fence-posts.md) | "returns $\theta=p_3(\lambda)+\langle W^\#,W\rangle$, **$\theta$'s own definition** … *already recorded on 2026-08-23* … a third derivation of a fact closed twice" |

**The present entry is at least the fourth derivation, and post F25 exists precisely to record that this rearrangement fences off nothing.** The screen was run by locus ("is it on the diagonal locus?") rather than by expression, which is the failure mode [INDEX-values.md](../findings/INDEX-values.md) warns about in its own opening line: *query by number, not by name*. A grep for `M^\#,M` reaches all four rows.

## Hypotheses used without being stated

- **Criticality is claimed and not used.** "Pairing criticality with $W$ gives, at every critical point, $\theta=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$" holds at every unit $W$, critical or not. Stating it as a criticality consequence makes the split look like a lever on the hypothesis, which is the appearance that carries the section.
- **Every Weyl constraint beyond $\mathop{\mathrm{tr}}W=0$ and $\sum\lambda^2=1$ is dropped in claim 2.** The optimisation runs over free $N$-tuples; $\mathop{\mathrm{tr}}W^\#=-1$, first Bianchi and Ricci-flatness are all discarded. The record's own data price the drop: the largest $\mathop{\mathrm{tr}}W^3$ anywhere catalogued is $1/\sqrt6=0.4083$ at padded $W_{\mathbb{CP}^2}$, against $c_{66}=0.9771$, a factor of $2.39$, and a factor of $43$ at $S^6\times S^6$. **The whole of the proposed reduction is that discarded slack.**
- **Claim 4 assumes its hypothesis is satisfiable.** No point on record with $\theta\ge\sqrt{3/2}$ satisfies it, and the boundary case is the target's own equality point.
- **Claim 3's constant is stated at $n=12$ and used as though $n$-free.** Padding-invariance of $\langle W,W^\#\rangle$ against $n$-dependence of $c_N$ collapses the family to its limit $\sqrt{3/2}-1$, which is a different and weaker number than the one quoted.

## What survives

**Claim 3 stands as written**, and I do not find that exact universal statement in [findings/](../findings/): *at every critical point in the band, diagonal or not, $\langle W,W^\#\rangle\ge\sqrt{3/2}-c_N$.* It is a two-line corollary of two facts already on record, it is $3.30\times$–$4.90\times$ slack at every point catalogued, and the use proposed for it is refuted. **Recording it is correct; calling it a target shape is not.**

**The exact split values in the table above** are worth keeping: padded $W_{\mathbb{CP}^2}$ at $\big(\tfrac1{\sqrt6},\tfrac2{\sqrt6}\big)$ is a clean closed form for the equality case, and it sits alongside [ad-form-attempt.md](../findings/ad-form-attempt.md)'s sphere-product forms as the second exact row of the split.

## Two record defects noticed in passing

- **[diagonal-half.md](../findings/diagonal-half.md) cites "Fence post F11"** for the $1.2136$-against-$0.0225$ observation. No post F11 exists in [fence-posts.md](../findings/fence-posts.md), whose numbering runs F1–F10 then F23–F42; the content is **post F1**. A dangling reference on precisely the post this section needed to find.
- **The withdrawn I7 pair above the section** derives $\theta\mathop{\mathrm{tr}}W=1$ from $\mathop{\mathrm{tr}}W^\#=-1$ and $\sum\lambda_\alpha^2=2$. In the corrected normalisation the same computation is $\theta\mathop{\mathrm{tr}}W-\mathop{\mathrm{tr}}W^2=\mathop{\mathrm{tr}}W^\#$, i.e. $0-1=-1$, an identity with no content, since $\mathop{\mathrm{tr}}W=0$ is standing for a Weyl operator. *So "$\mathop{\mathrm{tr}}W=1/\theta$, a relation the record states nowhere" was an artefact of the $\sum\lambda^2=2$ error, and the withdrawal is correct for a sharper reason than the one recorded.* Likewise the count $p\le2/\theta^2\le4/3$ becomes $p\le1/\theta^2\le2/3$, forcing $p=0$ and contradicting $\mathop{\mathrm{tr}}W=0$, which is the precise sense in which "the hypothesis is impossible".
