# REVIEW_r986: Gate 2 on I104's $x\to\kappa_i$ link

Reviewer r986, cold read from [BRIEF_I104_x_kappa_link.md](BRIEF_I104_x_kappa_link.md) alone. Log: [agent_logs/r986-x-kappa-link.log](../agent_logs/r986-x-kappa-link.log).

| # | claim | verdict |
|---|---|---|
| 1 | $(q_1)_{ij}=(q_1)_{kl}$, so the sum is $2c$ | CONFIRMED |
| 2 | $D_{ij}=x_1+x_2$, $D_{kl}=x_1+x_3$ | CONFIRMED, and scoped exactly as the brief says |
| 3 | $c=x_1+\tfrac13(x_2+x_3)$ | CONFIRMED as a result, the stated justification is incomplete |
| 4 | $p+p'=\tfrac13(x_2+x_3)$ | CONFIRMED, and it is the shadow of an unconditional identity |
| 5 | $p^2+p'^2\ge\tfrac1{18}(x_2+x_3)^2$ | CONFIRMED, $\tfrac1{18}=\tfrac12\cdot\tfrac19$, and lossy in scope |
| 6 | the bound is attained exactly at $p=p'$ | CONFIRMED |
| 7 | $p,p'$ separately undetermined, only the sum fixed | **REFUTED** |
| 8 | the relation fails off the span of the three planes | CONFIRMED, with a repair better than the two the brief offers |
| 9 | $0.039$ against a $0.0148$ deficit, same configuration | CONFIRMED arithmetically, with a caveat on what it licenses |
| 10 | the link improves the upper bound on $\kappa$ | PLAUSIBLE, and the brief's sign worry does not bite |

## F1. Claim 10: the link is usable, and no sign condition on $x$ is needed

**The brief's worry is correctly aimed at the wrong quantity.** It is true that $\kappa$'s own dependence on the split is $x(p^2+p'^2)$ and that $x$ may be negative. That makes $\kappa$ itself move *down* with $p^2+p'^2$ when $x<0$, so a lower bound on $p^2+p'^2$ gives no upper bound on $\kappa$ read off the expansion directly. The brief stops there.

**The quantity to bound is the slack, and its coefficient is $\max(x,y,z)-x$, which is never negative.** Write $M=\max(x,y,z)$ for the constant in the bound being improved, $\kappa\le M\lVert q\rVert\lVert r\rVert^2$. Then

$$M\lVert r\rVert^2-\langle L_{\hat q}r,r\rangle=(M-x)(p^2+p'^2)+(M-y)(a'^2+b'^2)+(M-z)(c'^2+d'^2)-\Sigma+\sum_m\Big[M\lVert c_m\rVert^2-\tfrac12c_m^{\mathsf T}\hat qc_m\Big].$$

Two structural facts make this decisive.

- **$p$ and $p'$ enter the quoted expansion only through $p^2+p'^2$ and through $p+p'$.** Reading $\Sigma=z(p+p')(a'+b')+y(p+p')(c'+d')+x(a'+b')(c'+d')$, the cross terms are linear in $p+p'$ and carry no other trace of the split. The link pins $p+p'$ exactly, so the whole $\Sigma$ contribution is a fixed number once the link is applied, and the *only* remaining leverage is the quadratic term.
- **$M-x\ge0$ by definition of $M$ as the maximum.** So at fixed $p+p'$ the slack is a nondecreasing function of $p^2+p'^2$, and a *lower* bound on $p^2+p'^2$ is exactly a *lower* bound on the slack, hence an improvement of the upper bound on $\kappa$.

**The improvement, written out.** With $L$ the link's lower bound,

$$\kappa\le\lVert q\rVert\Big[M\lVert r\rVert^2-(M-x)L\Big],\qquad L=\tfrac1{18}(x_2+x_3)^2\ \text{in scope},\ \ \tfrac1{18}S^2\ \text{in general (F3)}.$$

**So the answer to the brief's question is: the link improves the upper bound, for every sign of $x$, and the condition is not a sign condition.** It is a strictness condition: the gain $(M-x)L\lVert q\rVert$ is strictly positive iff $x<\max(x,y,z)$ and $L>0$, and it is exactly zero when $x$ *is* the maximum, which is the case $x\ge0$ and $x\ge y,z$. Negative $x$ is the *favourable* case, not the fatal one, because it makes $M-x$ largest.

**What this does not settle, and it is the live gap.** The gain is $(M-x)\lVert q\rVert L$ and the brief supplies no bound below on any of the three factors at the surviving configuration. So the link is usable in the correct direction, and whether it covers $0.0148$ is untouched by anything in the brief. That is why this row is PLAUSIBLE rather than CONFIRMED: the sign objection is retired, the quantitative one is not. **The item's remaining source survives, and it now needs a lower bound on $S^2$ and on $\max(x,y,z)-x$ at the critical configuration.**

## F2. Claim 7 is false in the very scope where claim 4 holds

**In the scope, $p$ and $p'$ are each determined, and the derivation's own algebra shows it.** With $D=K_1+K_2+K_3$ and $c=x_1+\tfrac13(x_2+x_3)$,

$$p=D_{ij}-c=\frac{2x_2-x_3}{3},\qquad p'=D_{kl}-c=\frac{2x_3-x_2}{3},\qquad p-p'=x_2-x_3.$$

The sum reproduces claim 4, and $K_1$ drops out of both, so $x_1$ is irrelevant to the split as well as to the sum. **The link therefore feeds an identity, not merely a bound**, and the derivation's stated reason for settling for a bound is wrong.

**Where the claim came from, and why it looks true.** Claim 7 is true of a strictly weaker hypothesis set, namely "given only $q_1\in\Pi_{Q_1}$ and its coefficient $c$, the split is free". It is false once $x_2$ and $x_3$ are in hand, which they are in every line of the derivation around it. Out of scope, the honest statement is the reverse of claim 7: *neither* the sum nor the difference is determined by $x_2,x_3$, because both pick up the orthogonal part.

**The consequence for claim 5.** In scope the exact value is available,

$$p^2+p'^2=\frac{5x_2^2-8x_2x_3+5x_3^2}{9}=\frac{(x_2+x_3)^2}{18}+\frac{(x_2-x_3)^2}{2},$$

so claim 5 discards $\tfrac12(x_2-x_3)^2$. The bound is true, the constant $\tfrac1{18}$ is right, and it is lossy at every configuration with $x_2\ne x_3$. Feeding the exact value into F1 in place of $L$ raises the gain by $(M-x)\lVert q\rVert\tfrac12(x_2-x_3)^2$ at no cost.

## F3. Claim 8 is right that the stated relation fails, and the repair is to stop mentioning $x_2,x_3$

**The failure, made explicit.** $w\perp\Pi_{Q_1}$ holds iff $w$'s three pairing sums over $Q_1$ agree, $w_{ij}+w_{kl}=w_{ik}+w_{jl}=w_{il}+w_{jk}=:s_1$, and $s_1$ is unconstrained, being $\tfrac13\sum_{a<b\in Q_1}w_{ab}$. Since $P_1w=0$, adding $w$ leaves $c$ untouched and moves the sum,

$$p+p'=\tfrac13(x_2+x_3)+s_1.$$

So the relation fails exactly as claimed, and $s_1\ne0$ is generic. Confirmed.

**The repair, and it is neither of the two the brief proposes.** The projection onto $\Pi_{Q_1}$ sees $D$ only through the three pairing sums $\sigma_x=D_{ij}+D_{kl}$, $\sigma_y$, $\sigma_z$. Solving $2c=\sigma_x-\lambda$ and its two partners under $c+d+e=0$ forces $\lambda=\tfrac13S$ with $S=\sigma_x+\sigma_y+\sigma_z=\sum_{a<b\in Q_1}D_{ab}$, whence $c=\tfrac12(\sigma_x-\tfrac13S)$ and

$$\boxed{\,p+p'=\sigma_x-2c=\tfrac13\sum_{a<b\in Q_1}D_{ab}\,}$$

**for every $D\in\mathcal D_n$, with no hypothesis at all.** It reduces to claim 4 in scope because $K_1$'s six entries sum to $2(x_1+y_1+z_1)=0$ while $K_2$ and $K_3$ each contribute one entry, giving $S=x_2+x_3$. So the scope is an artefact of the coordinates the derivation chose, and splitting $r_1$ or adding a hypothesis both pay for something already free. Claim 5 becomes $p^2+p'^2\ge\tfrac1{18}S^2$ unconditionally, and F1 runs on that.

**Whether a critical point's $D$ lies in the span: no reason is offered and none is apparent.** The span is $6$-dimensional while $\mathcal D_n$ has dimension $n(n-3)/2$, so the assumption is a codimension condition that a critical point has no evident cause to satisfy. With the repair the question is moot for the identity, and it survives only for anyone wanting the $x_2,x_3$ form specifically.

## F4. Claim 3's justification does not reach its conclusion as stated

**The result is right.** The first-pairing functional $f(K)=x$ on $\Pi_{Q_1}$ has Riesz representative $g=(\tfrac13,-\tfrac16,-\tfrac16)$, since $\langle g,K\rangle=2(\tfrac13x-\tfrac16y-\tfrac16z)=2(\tfrac13x+\tfrac16x)=x$ using $y+z=-x$. Because $\langle K_1,K_2\rangle=x_1x_2$ for all $K_1\in\Pi_{Q_1}$, the projection is $P_1K_2=x_2g$, whose first-pairing coefficient is $\tfrac13x_2$, and the same for $K_3$ through the shared pair $kl$. Summing with $P_1K_1=K_1$ gives $c=x_1+\tfrac13(x_2+x_3)$.

**The gap in the stated reason.** A principal cosine is an angle and is invariant under any rescaling of the two planes' unit vectors, whereas $c$ is a coefficient in a fixed coordinate. Recovering $\tfrac13$ from the angle alone is not possible: what the derivation actually uses is $f(g)=\lVert g\rVert^2=\tfrac13$, and the cosine is $\lVert g_1\rVert\lVert g_2\rVert=\tfrac13$ as well **only because the two planes have equal $\lVert g\rVert$ by symmetry**. The two $\tfrac13$s agree for a reason, and the reason is the symmetry, not the identity of the two quantities. The derivation should cite the representative, and the Lean hypothesis binder `hc` is the right place to carry it.

## F5. Claims 1, 2, 6 and 9

- **Claim 1.** $ij$ and $kl$ are the two entries of $\Pi_{Q_1}$'s first pairing, so membership gives $(q_1)_{ij}=(q_1)_{kl}=c$ and the sum is $2c$. CONFIRMED, and it is a definition-level fact rather than a step.
- **Claim 2.** $Q_1\cap Q_2=\{i,j\}$ contributes the single entry $ij$, which is the first pairing of both, and $Q_3$ misses it. Symmetrically for $kl$. CONFIRMED, and the brief is right that this line is where the span assumption enters, since it presumes $D$ is the sum of the three plane components.
- **Claim 6.** At fixed $p+p'=s$ the function $p^2+p'^2$ is strictly convex with a unique minimiser at $p=p'=s/2$ and value $s^2/2$. Equality is attained and nowhere else. CONFIRMED.
- **Claim 9.** $\tfrac{u}{\sqrt3}(t-u^2)$ at $t=0.346$ runs over $[0.03893,0.03904]$ across the whole confinement interval $u\in[0.437539,0.438432]$, so "about $0.039$" is right and stable, and both numbers are quoted at the same $t=0.346$ configuration. CONFIRMED. **The caveat is what the comparison licenses**: $0.039$ is the entire $\kappa$ envelope, and the chain already spends most of it. The quantity that has to beat $0.0148$ is the *gain* $(M-x)\lVert q\rVert L$ of F1, which is a shaving of that envelope and is not bounded below anywhere in the brief. So the number shows the source is not obviously too small, which is weaker than showing it is live.

## Vacuity

**Claim 5 is vacuous exactly when $S=0$**, that is $x_2+x_3=0$ in scope, where it degenerates to $p^2+p'^2\ge0$. Nothing in the brief excludes it. The quantity is used in one place only, the $x(p^2+p'^2)$ term of the coupling expansion, and therefore in the slack of F1, so the whole value of the link is the product $(M-x)\lVert q\rVert S^2/18$ and each factor can vanish independently. **Claims 4 and 8 are non-vacuous**: $S$ is a genuine function of $D$ and the failure term $s_1$ is realised by an explicit orthogonal $w$.

## Screens

Constructed objects only, seconds of compute, all assertions rather than printed expectations. On $n=8$ with $Q_1=\{0,1,2,3\}$, $Q_2=\{0,1,4,5\}$, $Q_3=\{2,3,4,5\}$: the sectional matrices lie in $\mathcal D_n$ and satisfy $\lVert K\rVert^2=2(x^2+y^2+z^2)$; the cross-Grams equal $x_1x_2$; the unit sectional's largest first-pairing coefficient is $1/\sqrt3$, which is the control on $M\le1/\sqrt3$; $g$ represents the functional and has $\lVert g\rVert^2=\tfrac13$; claims 1 to 6 hold on in-span $D$; $p$ and $p'$ match $(2x_2-x_3)/3$ and $(2x_3-x_2)/3$ and are unchanged when $K_1$ is replaced, which is F2; $p+p'=S/3$ holds on 200 random $D\in\mathcal D_n$ with no span assumption, which is F3; an explicit $w$ orthogonal to all three planes has $s_1\ne0$, leaves $c$ fixed, breaks claim 4 and preserves the $S/3$ form. For F1, the slack difference at fixed $p+p'$ equals $(M-x)$ times the excess of $p^2+p'^2$ over $s^2/2$ on 400 random coefficient sets, while $\kappa$'s own difference equals $x$ times the same excess, which is the two directions the finding separates.
