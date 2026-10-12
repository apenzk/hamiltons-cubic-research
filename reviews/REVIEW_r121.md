# Review r121, the $\lambda\mu=\mu^2-\mathrm{LOSS}$ chain, steps 1–7

Independent build from the brief's definitions only, in [scripts/reviewers/r121/](../scripts/reviewers/r121/). The algebra of every step was worked on paper first; $W^\#$ was re-derived from $\mathfrak{so}(n)$ structure constants before any of this record's code was opened. The build reproduces the record's own catalogue values to machine precision, $\theta(\mathbb{CP}^2)=1.224745$, $\theta(S^3\times S^3)=\theta(\mathbb{CP}^3)=1.054093$, $\theta(S^4\times S^4)=1.145644$, $\mathrm{LOSS}(\text{padded }\mathbb{CP}^2)=-1/3$, so conventions agree and no factor is being absorbed.

## Verdict table

| Step | Statement audited | Verdict |
|---|---|---|
| 1 | linearity of $R\mapsto\mathring R$ gives $\lambda\mu=-\langle(W^2)^{\!\circ}h,h\rangle-\langle(W^\#)^{\!\circ}h,h\rangle$ | **CONFIRMED**, and the silent hypothesis it needs is **true** (see below) |
| 2 | $\langle(W^2)^{\!\circ}h,h\rangle=\tfrac14\sum\lVert[u^{pq},h]\rVert^2-\tfrac12\operatorname{tr}(Nh^2)$ | **CONFIRMED** on paper and to $2\times10^{-16}$ |
| 3 | $N\succeq0$, $\operatorname{tr}N=\lvert W\rvert^2$; the "$N\propto I$" withdrawal | **CONFIRMED**; withdrawal correct; nothing else leans on it. One norm-convention slip |
| 4 | $(W^\#)_{ijkl}=\sum_{pq}(W_{ipkq}W_{jplq}-W_{iplq}W_{jpkq})$ and the $\#$-ring formula | **CONFIRMED exactly** against a structure-constant build, $\lVert\cdot\rVert\le6\times10^{-17}$ |
| 5 | $\langle C^{pq},h\rangle=-(\mathring Wh)_{pq}$, so $\sum\langle C^{pq},h\rangle^2=\mu^2$ | **CONFIRMED**; holds for **any** eigenvector, bottom not required |
| 6 | $\mathrm{LOSS}\ge\mu^2/n\iff\lambda\le\tfrac{n-1}n\mu$ | **CONFIRMED**, needing $\mu>0$, which is automatic and should be said |
| 7 | equality at every sphere product; $\mathrm{LOSS}<0$ at padded $W_{\mathbb{CP}^2}$ | **CONFIRMED**, and the first half is a **theorem, now proved**, with a strictly larger equality family |

Nothing in the chain is wrong. What the chain does not say is where the review's weight falls.

## Steps 1–5: the derivation is correct, and step 4's normalisation is the right one

**Step 4 first, because the brief asks.** With the operator convention $(Wh)_{ij}=\tfrac12W_{ijkl}h_{kl}$ (the one that sends the round sphere to $\mathrm{Id}$), $\langle A,B\rangle=\sum A_{ij}B_{ij}$ on $\mathfrak{so}(n)$, and $\#$ fixed by $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, the definition $\langle R^\#x,y\rangle=\sum_{\gamma\delta}\langle[\phi^\gamma,\phi^\delta],x\rangle\langle[R\phi^\gamma,R\phi^\delta],y\rangle$ contracts through $\sum_\gamma\phi^\gamma_{ab}\phi^\gamma_{mr}=\tfrac12(\delta_{am}\delta_{br}-\delta_{ar}\delta_{bm})$ to $\langle W^\#x,y\rangle=\sum x_{mn}y_{ij}W_{ipmr}W_{pjrn}$; antisymmetrising in $(ij)$ and $(mn)$ gives the brief's formula with no factor and no sign to spare. Checked against a basis-level build of the structure constants at $n=4,5,6,7$: agreement to $6\times10^{-17}$, and $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ exactly ([r121_core.py](../scripts/reviewers/r121/r121_core.py)). **Nothing downstream is invalidated by a normalisation.**

**Step 1 has a hypothesis it does not state, and the hypothesis is true.** $Q(W)=\lambda W$ is the Euler–Lagrange equation of $\theta$ on the unit sphere of $\mathcal W_n$ only if $Q(W)$ lies in $\mathcal W_n$; otherwise the equation carries a projection and applying $\mathring{\ }$ to it is illegitimate. $W^2$ alone is not Bianchi and $\mathrm{Ric}(W^2)=N/2\ne0$, so this is not free. It is nonetheless true: writing $Z_{jl}=\sum_{pr}\big((C^{pr})^2\big)_{jl}$ one has $\mathrm{Ric}(W^\#)=-Z$ and $\mathrm{Ric}(Q(W))=N/2-Z$, and this vanishes for every Weyl $W$, the reaction term of the Ricci evolution $2R_{ipjq}\mathrm{Ric}_{pq}-2\mathrm{Ric}_{ip}\mathrm{Ric}_{pj}$ is zero when $\mathrm{Ric}=0$. Verified: Bianchi residual and $\lvert\mathrm{Ric}(Q(W))\rvert$ both $\le8\times10^{-17}$ at $n=4,5,6,7$ on random Weyl tensors ([r121_steps2345.py](../scripts/reviewers/r121/r121_steps2345.py)). **So $Q$ preserves $\mathcal W_n$ and step 1 is clean, but the record should carry the reason, because a reader checking step 1 will stop at $\mathrm{Ric}(W^2)=N/2\ne0$ and conclude the opposite.**

**Steps 2, 3, 5** reproduce on paper exactly as written. The commutator/anticommutator elimination is right, $\sum_{pq}(u^{pq})^2=-N$ is right, and $W_{pklq}=-C^{pq}_{kl}$ gives step 5 with the stated sign. Residuals $\le2\times10^{-16}$ at $n=4,5,6,7$.

**One convention slip in step 3.** With $\lVert W\rVert_F=1$ *as an operator on $\Lambda^2$* (the brief's own normalisation), $\operatorname{tr}N=\sum_{ijkl}W_{ijkl}^2=4$, not $1$. The statement "$\operatorname{tr}N=\lvert W\rvert^2$" is true only for the tensor norm, and the two norms differ by the factor $\lVert W\rVert_F=\tfrac12\lvert W\rvert$. Harmless here because only $\lambda_{\max}(N)$ is used downstream, but a brief that fixes one normalisation and quotes the other invites a factor-4 error in any reader who reuses it.

**$N$ is not a multiple of the identity, and the withdrawal is right.** Measured deviation $\lVert N-\tfrac{\operatorname{tr}N}nI\rVert_\infty$: $2\times10^{-16}$ at $n=4$ (where it is forced), $0.21$, $0.13$, $0.16$ at $n=5,6,7$ on random Weyl tensors. Nothing else in the chain uses it.

## Two identities the chain omits, and they change what the chain means

**(i) The identity needs neither criticality nor an eigenvector.** For every unit Weyl $W$ and every unit $h\in S^2_0$,

$$\big\langle (Q(W))^{\!\circ}h,h\big\rangle=\mathrm{LOSS}(W,h)-\lVert\mathring Wh\rVert^2 .$$

Verified to $10^{-16}$ at $n=4,5,6,7$ on random $W$ and random $h$ ([r121_general_identity.py](../scripts/reviewers/r121/r121_general_identity.py)). Steps 2–5 are this identity; step 1 contributes only the substitution $\langle(Q(W))^{\!\circ}h,h\rangle=-\lambda\mu$, and the eigenvector property contributes only $\lVert\mathring Wh\rVert^2=\mu^2$. That answers (b) precisely: **criticality enters at exactly one place and the identity survives without it in the displayed form.**

**(ii) At a critical point $\mathrm{LOSS}$ is a function of the eigenvalue and $\lambda$ alone.** For every eigenvector $h$ of $\mathring W$ with $\mathring Wh=\nu h$,

$$\mathrm{LOSS}(W,h)=\nu(\nu+\lambda),\qquad\text{hence}\qquad \sum_{\alpha}\mathrm{LOSS}(W,h^\alpha)=\lVert\mathring W\rVert_F^2$$

over any orthonormal eigenbasis of $S^2_0$ (using $\operatorname{tr}\mathring W|_{S^2_0}=0$, itself a consequence of $\mathrm{Ric}(W)=0$). Verified to $1.6\times10^{-15}$ across the **whole** spectrum at every critical point tested, and $\sum_\alpha\mathrm{LOSS}=\lVert\mathring W\rVert_F^2=3.000000$ at padded $\mathbb{CP}^2$ ([r121_loss_identity.py](../scripts/reviewers/r121/r121_loss_identity.py)).

This is the sharpest thing to say about the chain. **On the critical set, $\mathrm{LOSS}\ge\mu^2/n$ and $\lambda\le\tfrac{n-1}n\mu$ are not related by an inequality, they are the same sentence**, and the whole of steps 1–6 is an exact change of variables for $\mathrm{CD}_n$. [findings/target.md](../findings/target.md) already says as much ("this is the dichotomy written in quantities that can be attacked"), and that framing is honest; the sum rule and the $\nu(\nu+\lambda)$ form make it exact rather than rhetorical. The route's content therefore sits entirely in whether the three terms admit a **criticality-free** lower bound, and (d) below says they do not.

## (a) Any eigenvector works; the top of the spectrum is vacuous

Step 5 uses only $\mathring Wh=\nu h$. Both the identity and $\sum_{pq}\langle C^{pq},h\rangle^2=\nu^2$ hold for every eigenvector, top included, at $10^{-16}$.

What changes at the top is step 6, which divides by $\mu=-\nu$. With $\nu>0$ the division flips the inequality: $\mathrm{LOSS}\ge\nu^2/n$ becomes $\lambda\ge-\tfrac{n-1}n\nu$, a lower bound by a negative number. Worse, it is automatic: $\mathrm{LOSS}=\nu(\nu+\lambda)\ge\nu^2/n\iff\lambda\ge-\tfrac{n-1}n\nu$, which holds at every critical point with $\lambda\ge0$. **The top branch carries no information at all.** Step 6 therefore needs $\mu>0$, i.e. a *negative* eigenvalue of $\mathring W$, which is automatic, since $\mathring W$ preserves $S^2_0$ and is traceless there for Weyl $W$, so its bottom eigenvalue is negative whenever $W\ne0$. The brief should state that one line; without it, step 6's "is equivalent to" is an unjustified division.

## (c) Equality at every sphere product is a theorem, and the family is larger than sphere products

**Proof.** Let $W$ be *diagonal*: $W_{ijij}=s_{ij}$ with $s$ hollow symmetric, and $\mathrm{Ric}(W)=0$ forcing $s\mathbf 1=0$.

1. $\mathring W$ preserves the splitting of $S^2_0$ into diagonal and off-diagonal parts; on $\mathrm{diag}(v)$ it acts as $-s$, and on $e_i\odot e_j$ by $-s_{ij}$.
2. The bottom eigenvector is always the diagonal one. For $e=(e_i+e_j)/\sqrt2$ and $P$ the projection off $\mathbf 1$, $s_{ij}=e^{\mathsf T}se=(Pe)^{\mathsf T}s(Pe)\le\lambda_{\max}(s)\lVert Pe\rVert^2=(1-\tfrac2n)\lambda_{\max}(s)<\lambda_{\max}(s)$. So $\mu=\lambda_{\max}(s)$ and $h=\mathrm{diag}(v)$ with $sv=\mu v$, $\lVert v\rVert=1$, $\sum v_i=0$.
3. $\mathrm{LOSS}(W,h)=\sum_{i<j}s_{ij}^2(v_i-v_j)^2$, checked to $6\times10^{-17}$ at $n=5,6,7$ on random diagonal Weyl tensors ([r121_noncritical_and_projection.py](../scripts/reviewers/r121/r121_noncritical_and_projection.py)).
4. $\mu=v^{\mathsf T}sv=-\sum_{i<j}s_{ij}(v_i-v_j)^2$ and $\sum_{i<j}(v_i-v_j)^2=n\lVert v\rVert^2-(\sum v_i)^2=n$, so Cauchy–Schwarz gives $\mu^2\le n\cdot\mathrm{LOSS}$.

**So $\mathrm{LOSS}\ge\mu^2/n$ holds on the whole diagonal locus, critical or not, with equality exactly when $s_{ij}$ takes one constant value $-\mu/n$ on every pair with $v_i\ne v_j$.** At $S^p\times S^q$ the bottom eigenvector is block-constant with two values and the cross weights are constant, so equality is forced, for every $(p,q)$, every $n$, and every ratio of radii. It is a theorem, not a coincidence, and it is the record's own "diagonal Cauchy–Schwarz step" read backwards.

**The equality family is strictly larger.** The condition constrains only the *cross* weights. At $n=8$ with blocks of four, cross weight $\gamma$ and within-block weights $(a,b,c)$ on the three perfect matchings subject to $a+b+c=-4\gamma$, the bottom eigenvector stays $v=\pm\tfrac1{2\sqrt2}$ block-constant and equality holds to $4\times10^{-16}$ at $(a,b,c)=(0.5,1.5,2)$, $(-1,2,3)$ and $(4,0,0)$, none of them sphere products, none of them critical (residuals $0.05$–$0.27$) ([r121_newton_scan.py](../scripts/reviewers/r121/r121_newton_scan.py)). **Equality is a property of the Cauchy–Schwarz alignment, not of being a sphere product and not of criticality**, which is a more useful thing for the record to know than the tabulated list.

Also verified: the Weyl tensor of $S^p\times S^q$ is independent of the two radii up to scale, so "balanced or not" in [findings/target.md](../findings/target.md) can only mean $p$ vs $q$; varying $k_2/k_1$ over $0.3,1,2.5,7$ moves nothing ([r121_catalogue.py](../scripts/reviewers/r121/r121_catalogue.py)). And equality **fails** for three-factor products whose bottom eigenvector takes three values, $S^2\times S^3\times S^4$ misses by $+8.7\times10^{-3}$, $[2,2,2]$ with $k=(1,2,5)$ by $+6.4\times10^{-3}$, exactly as the equality condition predicts, in the safe direction.

## (d) $\mathrm{LOSS}\ge\mu^2/n$ is not provable as stated, and the reason is sharper than "$\mathbb{CP}^2$"

**No counterexample to $\mathrm{CD}_n$ was found**, and the estimate that turns $\mathrm{CD}_n$ into Conjecture A survives an independent check. Maximising $\mu$ over the unit sphere of $\mathcal W_n$ by alternating ascent returns $1.154701$, $1.178511$, $1.264911$, $1.278019$, $1.309307$ at $n=4,\dots,8$ against $\sqrt{2(n-2)/(n-1)}=1.154701$, $1.224745$, $1.264911$, $1.290994$, $1.309307$, so $\tfrac{n-1}n\mu\le\Theta_n$ holds, is attained at even $n$ (by the balanced product) and is strict at odd $n$. **That part of the architecture is sound.**

The problem is elsewhere, and it is threefold.

**1. The inequality is false off the critical set, so no criticality-free proof exists.** Over $1000$ random unit Weyl tensors per dimension, $\mathrm{LOSS}<\mu^2/n$ at the bottom eigenvector in $57$ cases at $n=4$ (worst $-0.170$), $10$ at $n=5$ (worst $-0.059$), $1$ at $n=6$; and the failure set is not a rare accident, it is an **open neighbourhood of the padded $\mathbb{CP}^2$ orbit at every $n$**. Perturbing padded $\mathbb{CP}^2$ by a random Weyl direction of size $\varepsilon=0.05,0.2,0.5$ gives criticality residuals $0.01$–$0.14$ and $\mathrm{LOSS}-\mu^2/n$ from $-0.44$ down to $-0.21$, at $n=5,6,8$ alike ([r121_noncrit_sweep.py](../scripts/reviewers/r121/r121_noncrit_sweep.py)). Yet **criticality appears nowhere in $\mathrm{LOSS}$**, the three terms are functions of $(W,h)$ only. Any proof of branch 1 must therefore route the critical-point equation back into the estimate, and steps 2–5 have already discarded it. This is the structural obstruction, and it is not recorded.

**2. Branch-1 failure on the critical set is not confined to padded $\mathbb{CP}^2$.** [findings/target.md](../findings/target.md) presents the two branches as "tight on disjoint families", listing sphere products against padded $W_{\mathbb{CP}^2}$. A least-squares solve of $Q(W)=\theta W$ at $n=5$ returns a **two-eigenvalue critical point that is neither**: $\theta^2=24/35$ exactly ($\theta=0.828079$, residual $2\times10^{-16}$), $\Lambda^2$ spectrum $\sqrt{7/30}$ with multiplicity $3$ and $-\sqrt{3/70}$ with multiplicity $7$, $\mathring W$ spectrum $-0.621059$ with multiplicity $5$ and $+0.345033$ with multiplicity $9$. There $\mu^2=27/70$, $\mathrm{LOSS}=-9/70$ and $\mathrm{LOSS}-\mu^2/n=-0.205714$, **branch 1 fails by a wide margin**. The bottom eigenspace is $5$-dimensional and $\mathrm{LOSS}$ is constant on it at $-9/70=\nu(\nu+\lambda)$, so the failure is not an artefact of choosing a representative ([r121_n5_violator.py](../scripts/reviewers/r121/r121_n5_violator.py)). $\mathrm{CD}_n$ still holds, because $0.828<\sqrt{3/2}$.

*Stated honestly, with the frequency I actually measured*: this point appears in $1$ of $3$ distinct critical values found at $n=5$ and in none of the $50$ found at $n=6$, and one seed's first $250$ starts miss it entirely while $300$ and $400$ starts from two seeds find it, so the census counts mean nothing either way, exactly as the record already warns. What the witness establishes is qualitative and enough: **branch 1 is not "a near-theorem with one exception at $\mathbb{CP}^2$"**, and every point where it fails is a point where the whole burden sits on the $\sqrt{3/2}$ branch, which is the target itself.

**3. The relaxation the record proposes next is provably dead at both equality cases.** [findings/target.md](../findings/target.md) drops the commutator mass ("so the whole route now rests on the $\#$ term alone"), giving $\lambda\mu\le\tfrac12\operatorname{tr}(Nh^2)-\langle(W^\#)^{\!\circ}h,h\rangle\le\tfrac12\lambda_{\max}(N)-\langle(W^\#)^{\!\circ}h,h\rangle$. Evaluated at the points where it must be tight ([r121_commutator_drop.py](../scripts/reviewers/r121/r121_commutator_drop.py)):

| point | true $\lambda$ | after dropping $\tfrac14\sum\lVert[u,h]\rVert^2$ | overshoot |
|---|---|---|---|
| padded $\mathbb{CP}^2$, $n=4,6,8,10$ | $1.224745$ | $\sqrt{8/3}=1.632993$ | $+33.3\%$ at every $n$ |
| $S^2\times S^2$ | $0.866025$ | $1.154701$ | $+33.3\%$ |
| $S^3\times S^3$ | $1.054093$ | $1.264911$ | $+20.0\%$ |
| $S^4\times S^4$ | $1.145644$ | $1.309307$ | $+14.3\%$ |
| $S^6\times S^6$ | $1.236033$ | $1.348400$ | $+9.1\%$ |

At every sphere product $\mathrm{LOSS}$ *is* the commutator mass ($\sum\operatorname{tr}((C^{pq}h)^2)=\tfrac12\operatorname{tr}(Nh^2)$ exactly, checked to $10^{-16}$), so dropping it gives precisely $\lambda\le\mu$, overshooting $\theta_0(n)$ by $\tfrac1{n-1}$, never closing at any $n$. At padded $\mathbb{CP}^2$ it gives $\sqrt{8/3}$ against a target of $\sqrt{3/2}$, and both $\tfrac12\operatorname{tr}(Nh^2)=\tfrac12\lambda_{\max}(N)=\tfrac12$, so the second inequality is free and all the loss is the commutator. **The commutator mass is load-bearing at both equality families, and "the route rests on the $\#$ term alone" is the step that kills it.**

A fourth remark for whoever attacks the three terms: at padded $\mathbb{CP}^2$ the split is $\tfrac14\sum\lVert[u,h]\rVert^2=+\tfrac13$, $\sum\operatorname{tr}((C^{pq}h)^2)=-\tfrac16$, $-\tfrac12\operatorname{tr}(Nh^2)=-\tfrac12$. **The middle term is negative**, so no term-by-term positivity argument is available; the two negative terms must be beaten by the commutator mass alone.

## What the chain does not mention

- $Q$ maps $\mathcal W_n$ to $\mathcal W_n$ (Bianchi *and* Ricci-flat), which is what makes step 1's unprojected equation legitimate. The chain asserts linearity, which is the easy half.
- $\mathrm{LOSS}=\nu(\nu+\lambda)$ over the whole spectrum, and $\sum_\alpha\mathrm{LOSS}=\lVert\mathring W\rVert_F^2$, a free consistency check on any future implementation, and the statement that fixes how much the reformulation buys.
- The criticality-free version $\langle(Q(W))^{\!\circ}h,h\rangle=\mathrm{LOSS}-\lVert\mathring Wh\rVert^2$, valid for arbitrary $h\in S^2_0$.
- $\mu>0$, needed for step 6's division, and free from $\operatorname{tr}\mathring W|_{S^2_0}=0$.
- The brief states step 6 as the single inequality $\mathrm{LOSS}\ge\mu^2/n$. The record states the **disjunction** $\mathrm{CD}_n$. Read as the brief writes it, step 6's conclusion $\lambda\le\tfrac{n-1}n\mu$ is **false**, padded $\mathbb{CP}^2$ has $\lambda=1.224745$ against $\tfrac{n-1}n\mu<\mu=0.816497$ at every $n$ ($0.612$ at $n=4$, $0.714$ at $n=8$), i.e. $\lambda=\tfrac32\mu$ there. Any brief handed to a reviewer must carry the $\max$.
- The Newton scan reproduces the record's own warning at [findings/target.md](../findings/target.md): $250$–$300$ random starts reach a maximum of $0.828$ at $n=5$ and $0.572$ at $n=6$, never $\mathbb{CP}^m$ or the products. Random-start solving is evidence of nothing here, in either direction, including of my own failure to find a $\mathrm{CD}_n$ counterexample.

## Bottom line

The derivation is correct in every step, the $\#$ normalisation is right, and the sphere-product equality is a provable theorem with a wider equality family than recorded. What the chain buys is a change of variables, not an inequality: at a critical point $\mathrm{LOSS}$ is $\nu(\nu+\lambda)$, so branch 1 *is* the bound it is supposed to imply. Two facts should stop the next cycle from spending effort on $\mathrm{LOSS}\ge\mu^2/n$ as stated, it is false off the critical set, so no criticality-free estimate can reach it; and it is false at ordinary critical points, not only at $\mathbb{CP}^2$. The one concrete lead the audit adds is negative and cheap to act on: **keep the commutator mass**, because dropping it costs $33\%$ at padded $\mathbb{CP}^2$ and $\tfrac1{n-1}$ at every balanced product, and those are exactly the two points the route has to hit.


---

## Synthesis carried in REVIEW.md

### Reviewer 121, filed late, agreeing with 122 and widening two findings

**Independent build; reproduces the catalogue exactly, so conventions agree.** All seven steps CONFIRMED. Its three additions:

- **It reaches 122's central finding by its own route**: $\mathrm{LOSS}(h)=\nu(\nu+\lambda)$ at *every* eigenvector, and $\sum_\alpha\mathrm{LOSS}=\lVert\mathring W\rVert_F^2$. At $\nu=-\mu$ that is 122's $\mu(\mu-\lambda)$. **Two independent confirmations that the reduction is a restatement.**
- **The failure set of branch 1 is open, not a point.** $\mathrm{LOSS}<\mu^2/n$ on a whole neighbourhood of the padded $\mathbb{CP}^2$ orbit at every $n$, and at an ordinary $n=5$ critical point at $\theta^2=24/35$, i.e. $\theta=0.828079$, **the record's own recurring ceiling for non-diagonal hunts**. Since criticality enters nowhere in $\mathrm{LOSS}$'s three terms, no criticality-free estimate can reach it.
- **The $\mathrm{LOSS}=\mu^2/n$ equality family is strictly larger than the sphere products**, non-sphere-product, non-critical $4+4$ block tensors at $n=8$ achieve it exactly. So equality does not characterise the products.

**And "drop the commutator mass" is dead in closed form**: $\lambda\le\sqrt{8/3}$ at padded $W_{\mathbb{CP}^2}$ at every $n$, exactly $+33.3\%$ over $\sqrt{3/2}$, and $\lambda\le\mu$ at every balanced product, exactly $+\tfrac1{n-1}$ over $\Theta_n$, both verified here. *Second independent kill of the same proposal.*

**Third independent report of the same brief defect:** it stated step 6 without the `max`, and read literally $\lambda\le\tfrac{n-1}n\mu$ is **false**, padded $W_{\mathbb{CP}^2}$ has $\lambda=\tfrac32\mu$. Also: its own failure to find a $\mathrm{CD}_n$ counterexample is **weak evidence**, since random-start Newton reached only $\theta=0.828$ at $n=5$ and $0.572$ at $n=6$, the record's own post F13.
