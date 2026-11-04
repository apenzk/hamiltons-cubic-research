# VERIFY v150, L29: the $(1,2)$-signature cap $\theta\le\sqrt{3/2}$, its dimension-freeness, its attaining object $(2,-1,-1)/\sqrt6$, and the three vanishing sign-blocks

**Cold brief, no numerical work.** Every value below is an exact hand evaluation; nothing was run, and the one place a script is named ([b_two_negative_stratum.py](../scripts/route-b/b_two_negative_stratum.py)) is reported as the record's, never as this report's evidence. Sources read: [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), [results.md](../results.md):144/:439/:784, [findings/conventions.md](../findings/conventions.md), [findings/INDEX-results.md](../findings/INDEX-results.md), [findings/INDEX-traps.md](../findings/INDEX-traps.md), [findings/LEDGER.md](../findings/LEDGER.md), [lean/INDEX.md](../lean/INDEX.md), [reviews/REVIEW_r513.md](../reviews/REVIEW_r513.md), [reviews/REVIEW_r514.md](../reviews/REVIEW_r514.md). No verifier report was read. Log: [agent_logs/verify-L29-v150.log](../agent_logs/verify-L29-v150.log).

## Claim table

| # | Claim, as a consumer would read it | Verdict |
| --- | --- | --- |
| 1 | $\theta(W)\le\sqrt{3/2}$ for unit $W\in\mathrm{Weyl}_n$ with exactly one positive and two negative eigenvalues (with multiplicity) | **PROVEN**, re-derived in full below |
| 2 | The bound carries no dimension restriction | **PROVEN**, the only step where $n$ could enter is the pair cap, and it does not |
| 3 | The cap is attained at the spectrum $(2,-1,-1)/\sqrt6$, at every $n\ge4$ | **PROVEN**, three independent exact anchors below |
| 4 | That object is padded $W_{\mathbb{CP}^2}$, lies in $\mathcal W_n$, has signature $(1,2)$, and $\theta=\sqrt{3/2}$ | **PROVEN** |
| 5 | Its kernel ($63$ of $66$ at $n=12$) is compatible with the hypothesis | **PROVEN**, the kernel is required by the proof, not merely tolerated |
| 6 | $(+++)$, $(++-)$, $(---)$ vanish "structurally" | **PROVEN, but "structurally" is two different things**: identically for $(---)$, under the statement's own $k=1$ hypothesis for the other two |
| 7 | Equality forces the spectrum $(2,-1,-1)/\sqrt6$ | **PROVEN**, and it needs neither L31 nor L72, following from uniqueness of $t=1$ in the lemma's own proof |
| 8 | *[results.md](../results.md):441 and :784*: "The converse … is Lemma L72" | **BROKEN AS PRINTED**, withdrawn in [stratum-two-negative.md](../findings/stratum-two-negative.md) and in [INDEX-results.md](../findings/INDEX-results.md):86; the correction never reached results.md |
| 9 | *[results.md](../results.md):144*: "One positive and two negative eigenvalues cap $\theta$ at $\sqrt{3/2}$" | **HYPOTHESIS-DEBT**, the paraphrase drops the display that fixes the multiplicity reading; under the other reading the claim is open ([r513](../reviews/REVIEW_r513.md) says so in terms) |
| 10 | "Since $\sqrt{3/2}<\theta_0(n)$ from $n=12$, no maximiser in that dimension range has this spectrum" | **GAP at odd $n$**, the inference needs $\Theta_n$, not $\theta_0(n)$; the conclusion survives, the stated reason does not |
| 11 | "The pair cap is saturated identically and $\theta=f(t)$ exactly, not merely at the maximiser" | **GAP**, proved at support $r=4$ only; [r514](../reviews/REVIEW_r514.md)'s finding (c) said so and was not folded in |
| 12 | *[INDEX-results.md](../findings/INDEX-results.md):44*: "The scope is $k\le2$, not $k=1$" | **GAP**, no statement anywhere on the record says $k\le2$; the $k=2$ argument is block prose and belongs to [L35](../findings/stratum-two-negative.md) |

**One line.** The mathematics of L29 is sound and I re-derived every step of it by hand, including the attainment; what is defective is the paperwork around it, a withdrawn attribution still standing at two lines of [results.md](../results.md), a landscape paraphrase that states something open, and an exclusion claim resting on the wrong constant at odd $n$.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated from memory.

- $N=\binom n2=\dim\Lambda^2\mathbb R^n$, and $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ under $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, the half-trace pairing, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\mathop{\mathrm{tr}}(v^2)=-2$ for a unit bivector.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $\theta=P(W)/\lVert W\rVert^3$. At $\lVert W\rVert=1$, $\theta=P(W)=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$.
- $\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$.
- Structure constants $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ are **totally antisymmetric**, so $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ is totally symmetric and **hollow**, it vanishes whenever two indices coincide.
- **Sums over pairs and triples are over ORDERED tuples** unless the line says otherwise. L29's display carries an explicit $\tfrac12$ and is in the ordered reading; [L35](../findings/stratum-two-negative.md)'s display carries a $3$ and is over $\alpha<\beta<\gamma$. Both are the same number.
- The pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ is **[Lemma L31](../findings/stratum-two-negative.md)**, a numbered result. The row marginal $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)$ is **[Lemma L153](../findings/bounds.md)**, *the one $n$-dependent fact in the neighbourhood, and L29 does not use it.*
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$ and **nothing more**; $\Theta_n$ is the diagonal maximum, equal to $\theta_0(n)$ at **even** $n$ only, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$. $M(n)$ is the global maximum, with $\Theta_n\le M(n)$.
- $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, and $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$, which is $10$ at $n=4$, matching $5+5$.
- One notational hazard I record because the record's table does not: **$vv^{\mathsf T}$ carries two senses inside [stratum-two-negative.md](../findings/stratum-two-negative.md)**, the rank-one operator on $\Lambda^2$ in the $\#$ calculus, and the $n\times n$ matrix product $-v^2\succeq0$ in the Ricci-flatness identity. For skew $v$ the second equals $v^{\mathsf T}v$, so the L29 block's $\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$ and [L30](../findings/stratum-two-negative.md)'s $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ are the same identity. No finding, but the letter is doing two jobs eleven lines apart.

## 1. The hypothesis inventory

**What the block's statement carries.**

| # | hypothesis | used where |
| --- | --- | --- |
| H1 | $W\in\mathrm{Weyl}_n$ | *the bound uses only H2–H4*; H1 is used only by the two addenda (Ricci-flatness for the support argument, and for the equality-forces-$r=4$ clause) |
| H2 | $\lVert W\rVert=1$ | the norm equation $\lambda_1^2+a^2+b^2=1$, and the definition of $\theta$ as $P/\lVert W\rVert^3$ |
| H3 | $\mathop{\mathrm{tr}}W=0$ | $\lambda_1=a+b$ |
| H4 | exactly one positive and two negative eigenvalues, **counted with multiplicity**, all others zero | the vanishing of $(+++)$, $(++-)$, $(---)$; and H3, H2 as three-term equations |

**H3 is not stated and is imported silently.** The block says "$W\in\mathrm{Weyl}_n$" and then "Trace-freeness gives $\lambda_1=a+b$". Trace-freeness is a consequence of $W$ being a Weyl operator, so this is sound, but it is the *only* Weyl property the inequality uses, and saying so is what makes the strengthening in §8 visible. [L35](../findings/stratum-two-negative.md)'s block states exactly this for its own chain ("never uses the first Bianchi identity, so it holds for any trace-free symmetric operator on $\Lambda^2$"); L29's block does not.

**Imported results, each checked against the object it applies to.**

| import | its own hypotheses | satisfied here? |
| --- | --- | --- |
| [Lemma L31](../findings/stratum-two-negative.md) pair cap, $\lVert[X,Y]\rVert^2\le2$ | $X,Y\in\mathfrak{so}(n)$ **orthonormal** | yes, $v_{N-1},v_N$ are two members of an orthonormal eigenbasis, hence orthonormal, at every $n$ |
| total antisymmetry of $c$ | ad-invariance of the inner product on $\mathfrak{so}(n)$ | yes, unconditionally |
| $\langle W,W^\#\rangle=\tfrac12\sum T\lambda\lambda\lambda$ | an orthonormal eigenbasis of $W$ on $\Lambda^2$ | yes; and see §3 for the three anchors pinning this normalisation |
| padding preserves $\lVert\cdot\rVert$ and $\theta$ ([L30](../findings/stratum-two-negative.md)) | used only to move the attaining object from $n=4$ to general $n$ | yes; the clause was asserted-and-unproved until [r589](../reviews/REVIEW_r589.md)/[r590](../reviews/REVIEW_r590.md), and is now repaired |
| [Lemma L153](../findings/bounds.md) row marginal $2(n-2)$ | any $n\ge2$ | **not used**, and this is the whole of the dimension-freeness |

**Not on file as a hypothesis anywhere, and it should be**: that "one positive and two negative eigenvalues" is counted *with multiplicity*. See §5.

## 2. Question 1, the cap, derived in full, and where the dimension could have entered

### 2.1 The derivation

Fix an orthonormal eigenbasis $v_1,\dots,v_N$ of $W$ on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, with $\lambda_1>0$, $\lambda_{N-1}=-a$, $\lambda_N=-b$, $b\ge a>0$ (the statement writes $-a\ge-b$), and every other $\lambda_\gamma=0$.

**Step 1, the cubic.** $\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ over ordered triples, with $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2\ge0$ totally symmetric and hollow. Every term carrying a zero eigenvalue drops, so the sum runs over $\{1,N-1,N\}$ alone. This is what makes the four-block split exhaustive: the split is over $\{+,-\}$, and the kernel indices are discarded first, by the $\lambda$'s and not by the split.

**Step 2, the three vanishing blocks.** Checked one at a time in §4.

**Step 3, the surviving block.** The index multiset $\{1,N-1,N\}$ has $3!=6$ ordered arrangements, each contributing $T_{1,N-1,N}\lambda_1(-a)(-b)=T_{1,N-1,N}\lambda_1ab$. With the $\tfrac12$:
$$\langle W,W^\#\rangle=3\,T_{1,N-1,N}\,\lambda_1ab .$$
This reproduces the block's coefficient exactly.

**Step 4, the pair cap.** $T_{1,N-1,N}$ is one nonnegative term of $\sum_\gamma T_{N-1,N,\gamma}=\lVert[v_{N-1},v_N]\rVert^2\le2$, so $T_{1,N-1,N}\le2$ and $\langle W,W^\#\rangle\le6\lambda_1ab$.

**Step 5, the exact part.** $\mathop{\mathrm{tr}}W^3=\lambda_1^3-(a^3+b^3)$, exactly.

**Step 6, the two constraints.** $\mathop{\mathrm{tr}}W=0$ gives $\lambda_1=a+b$; $\lVert W\rVert=1$ gives $(a+b)^2+a^2+b^2=1$, i.e.
$$a^2+ab+b^2=\tfrac12 .$$

**Step 7, the collapse.** With $\lambda_1=a+b$, $(a+b)^3-a^3-b^3=3ab(a+b)$, so
$$\theta\le 3ab(a+b)+6ab(a+b)=9ab(a+b).$$
Put $t=b/a>0$. Then $a^2(t^2+t+1)=\tfrac12$, so $a=1/\sqrt{2(t^2+t+1)}$ and $9ab(a+b)=9a^3t(1+t)$, giving
$$\theta\le f(t)=\frac{9\,t(t+1)}{\big(2(t^2+t+1)\big)^{3/2}}=\frac{9\sqrt2\,t(t+1)}{4\,(t^2+t+1)^{3/2}} ,$$
the block's closed form, reached with no step of the block's omitted.

**Step 8, the maximisation, two ways.**

*The block's way.* $\log f=\log t+\log(t+1)-\tfrac32\log(t^2+t+1)+\mathrm{const}$, so
$$\frac{f'}{f}=\frac{2t+1}{t(t+1)}-\frac{3(2t+1)}{2(t^2+t+1)}=(2t+1)\left[\frac1{t^2+t}-\frac3{2(t^2+t+1)}\right].$$
On $t>0$ the factor $2t+1$ never vanishes, so the bracket must, giving $2(t^2+t+1)=3(t^2+t)$, i.e. $t^2+t-2=(t+2)(t-1)=0$, whose only positive root is $t=1$. With $f(0)=0$ and $f(t)\to0$ as $t\to\infty$ (degree $2$ over degree $3$), the maximum is at $t=1$:
$$f(1)=\frac{9\sqrt2\cdot2}{4\cdot3\sqrt3}=\frac{18\sqrt2}{12\sqrt3}=\frac{3\sqrt2}{2\sqrt3}=\frac{\sqrt6}2=\sqrt{3/2} .$$

*The way [L29.lean](../lean/HamiltonsCubic/Results/L29.lean)'s row states, which removes the calculus and which I verified term by term.* $(t^2+t+1)^3=t^6+3t^5+6t^4+7t^3+6t^2+3t+1$, so
$$4(t^2+t+1)^3-27t^2(t+1)^2=4t^6+12t^5-3t^4-26t^3-3t^2+12t+4,$$
and $(t-1)(t+2)(2t+1)=2t^3+3t^2-3t-2$, whose square expands coefficient by coefficient to the same septic-free sextic $4t^6+12t^5-3t^4-26t^3-3t^2+12t+4$. Hence
$$\tfrac32-f(t)^2=\frac{3\big((t-1)(t+2)(2t+1)\big)^2}{8\,(t^2+t+1)^3}\ \ge\ 0\quad\text{for every real }t,$$
since $t^2+t+1=(t+\tfrac12)^2+\tfrac34>0$ always. Equality exactly at $t\in\{1,-2,-\tfrac12\}$, hence at $t=1$ alone on $t>0$. **This is stronger than the block's argument and needs no calculus, no endpoint limits and no positivity of $t$**, I confirm the Lean row's claim.

$\square$, the bound is proved, and the record's proof is the proof.

### 2.2 Where the dimension could have entered, and why it does not

Six places, taken in order.

1. **The eigenbasis and the cubic identity.** $N=\binom n2$ appears only as an index range, and every term with a zero $\lambda$ drops. **No $n$.**
2. **The block vanishing.** Turns on the *counts* $1$ and $2$ of positive and negative indices, and on hollowness of $T$. Both are $n$-free. **No $n$.**
3. **The pair cap. This is the one place $n$ could have entered, and the only one.** [L31](../findings/stratum-two-negative.md) derives $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$ from the root system of $\mathfrak{so}(n)$, $\mathrm{ad}_X$ has eigenvalues $i(\pm s_i\pm s_j)$ and $i(\pm s_i)$, and is skew-adjoint, so its operator norm is the largest modulus. The number of angles $s_i$ is $\lfloor n/2\rfloor$ and **grows with $n$**, that is exactly where a dimensional constant would come from. It does not, because the angles enter the constraint only through $\sum_is_i^2=\lVert X\rVert^2=1$, and $(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2\sum_is_i^2=2$ by Cauchy–Schwarz on **two** terms. The count $\lfloor n/2\rfloor$ never appears. The neighbouring fact that *does* carry $n$, the row marginal $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)$, [Lemma L153](../findings/bounds.md), is not used by L29, and [L35](../findings/stratum-two-negative.md)'s block records that it "states the row marginal and then discards it" for the same reason.
4. **Trace-freeness.** Three-term equation because H4 says the rest vanish. **No $n$.**
5. **Unit norm.** Same. **No $n$.**
6. **The one-variable maximisation.** A rational identity in $t$. **No $n$.**

So the bound is dimension-free, and it is dimension-free *for a reason*: the cap $2$ is a two-root fact about $\mathfrak{so}(n)$, and the argument spends only the top two angles of a unit-norm skew matrix.

### 2.3 The smallest admissible $n$, and a large one

**Smallest is $n=4$.** $\mathcal W_3=0$ by $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$, so $n\le3$ is vacuous. At $n=4$, $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ and each summand is a trace-free symmetric $3\times3$; a nonzero one has at least one positive and one negative eigenvalue. So H4 forces $W^-=0$ (or, on the other component, $W^+=0$), and the whole stratum at $n=4$ is $W^+=\mathrm{diag}(a+b,-a,-b)$ with $a,b>0$. The bound holds there and is attained at $a=b$, see §3.

**Large $n$.** Nothing in steps 1–6 changes. At $n=100$, $N=4950$ and padded $W_{\mathbb{CP}^2}$ carries $4947$ zero eigenvalues; the surviving block is still $3T_{1,N-1,N}\lambda_1ab$ with $T_{1,N-1,N}=2$, so $\theta=\sqrt{3/2}$ exactly. **The cap is attained at every $n\ge4$, so it is not merely dimension-free but dimension-uniformly sharp.**

## 3. Question 2, the attaining object

The object: $W^+=\mathrm{diag}(2,-1,-1)/\sqrt6$ on $\Lambda^+\mathbb R^4$, $W^-=0$, padded into $\mathbb R^n$.

**It lies in $\mathcal W_n$.** $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ and $\mathrm{diag}(2,-1,-1)$ is trace-free, so $W\in\mathrm{Weyl}_4$ with no appeal to Fubini–Study; padding into every $n\ge4$ is [L30](../findings/stratum-two-negative.md)'s clause, now proved.

**Signature and norm.** Eigenvalues $2/\sqrt6>0>-1/\sqrt6=-1/\sqrt6$: exactly one positive, exactly two negative, the rest zero. $\lVert W\rVert^2=(4+1+1)/6=1$. Trace $(2-1-1)/\sqrt6=0$. **H2, H3, H4 all hold.**

**$T_{1,N-1,N}=2$, by hand.** Take $\omega_1=(\varphi_{12}+\varphi_{34})/\sqrt2$, $\omega_2=(\varphi_{13}-\varphi_{24})/\sqrt2$, $\omega_3=(\varphi_{14}+\varphi_{23})/\sqrt2$, orthonormal in the half-trace pairing. With $[e_{ab},e_{cd}]=\delta_{bc}e_{ad}-\delta_{ac}e_{bd}-\delta_{bd}e_{ac}+\delta_{ad}e_{bc}$:
$$[e_{12},e_{13}]=-e_{23},\quad [e_{12},e_{24}]=e_{14},\quad [e_{34},e_{13}]=-e_{14},\quad [e_{34},e_{24}]=e_{23},$$
so $[\omega_1,\omega_2]=\tfrac12(-e_{23}-e_{14}-e_{14}-e_{23})=-(e_{14}+e_{23})=-\sqrt2\,\omega_3$, of norm-squared $2$. By cyclic symmetry $[\omega_2,\omega_3]=-\sqrt2\,\omega_1$. Taking $v_1=\omega_1$ (eigenvalue $2/\sqrt6$) and $v_2=\omega_2$, $v_3=\omega_3$ (eigenvalue $-1/\sqrt6$ each), the bracket of the two negative eigenvectors lies **entirely along $v_1$**, so
$$T_{1,N-1,N}=\lVert[v_2,v_3]\rVert^2=2,\qquad \sum_\gamma T_{2,3,\gamma}=2 .$$
The single inequality of the proof is an equality at this point.

**$\theta=\sqrt{3/2}$, three exact routes that agree.**

| route | evaluation |
| --- | --- |
| the block's own split | $\mathop{\mathrm{tr}}W^3=(8-1-1)/6^{3/2}=6/6^{3/2}=1/\sqrt6$; $\langle W,W^\#\rangle=3\cdot2\cdot\tfrac2{\sqrt6}\cdot\tfrac1{\sqrt6}\cdot\tfrac1{\sqrt6}=\tfrac2{\sqrt6}$; sum $3/\sqrt6=\sqrt{3/2}$ |
| the closed form $9ab(a+b)$ | $a=b=1/\sqrt6$: $9\cdot\tfrac16\cdot\tfrac2{\sqrt6}=\tfrac3{\sqrt6}=\sqrt{3/2}$ |
| the record's $\mathrm{Weyl}_4$ identity $P=9(\det W^++\det W^-)$ | $\det W^+=2/6^{3/2}$, so $P=18/6^{3/2}=3/\sqrt6=\sqrt{3/2}$ |

A fourth, from a different file: [L28](../findings/nondegeneracy.md)'s closed form $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ read at $m=2$ gives $\tfrac{3\cdot3}{3\cdot2\cdot1}=\tfrac32$. **Four routes, four times $\sqrt{3/2}$**, this is what pins the $\tfrac12$-over-ordered-triples normalisation of the cubic, which no single one of them would.

**A sign note a consumer needs.** [stratum-two-negative.md](../findings/stratum-two-negative.md)'s L33 block records that the Fubini–Study Weyl part at real dimension $4$ has signature $(2,1)$ and that "its negative is the base-case family at $\theta=+\sqrt{3/2}$". $P$ is a cubic, so $\theta(-W)=-\theta(W)$: the object in L29's stratum is the one with $\theta=+\sqrt{3/2}$ and $\Lambda^+$-spectrum $(2,-1,-1)/\sqrt6$, and the record's symbol $W_{\mathbb{CP}^2}$ denotes *that* one throughout. Internally consistent; worth stating because the opposite sign has signature $(2,1)$ and is not in this stratum at all.

**What the kernel does to the hypothesis.** At $n=12$ the kernel is $63$ of $66$ ([post W4](../findings/INDEX-traps.md)).

1. **It is required, not tolerated.** H4 says "exactly one positive and two negative eigenvalues"; every other eigenvalue must therefore be zero, and that is precisely what makes $\mathop{\mathrm{tr}}W=0$ read $\lambda_1=a+b$ and $\lVert W\rVert=1$ read $\lambda_1^2+a^2+b^2=1$. A stratum member with a large kernel is the generic case above $n=4$, not an edge case.
2. **It does not make the eigenbasis ill-posed.** The kernel eigenvectors are arbitrary, and the negative eigenspace at the attaining object is $2$-dimensional with a repeated eigenvalue, so $v_2,v_3$ are determined only up to $O(2)$. Neither matters: the cubic sum touches no kernel index, and under a rotation of the negative $2$-plane the bracket $[v_2,v_3]$ is multiplied by the determinant, so $T_{1,N-1,N}$ is invariant. **The proof is well posed at the attaining object despite both degeneracies.**
3. **It empties the block's own motivating sentence, correctly.** The block opens by saying the sharpest competitor "sits where the hypothesis defining that residual is vacuous", the slack being $S(W)=\sum_{\lambda<0}c'^2$. That is [post W4](../findings/INDEX-traps.md) verbatim, the gradedness screen is vacuous when $\ker W\ne0$. The block uses this as the *reason for* the lemma rather than reporting $S=0$ as evidence, which is the correct use. **No finding.**

## 4. Question 3, what the three vanishing sign-blocks actually need

The word "structurally" is doing two different jobs, and the block does not separate them.

| block | what it needs | is it identical, or hypothesis-dependent? |
| --- | --- | --- |
| $(+++)$ | three indices from the positive set, which H4 makes a singleton; $T$ hollow | **hypothesis-dependent**, it vanishes because H4 says $k=1$, not because of any structure of $T$ alone |
| $(++-)$ | two *distinct* positive indices | **hypothesis-dependent**, same reason |
| $(---)$ | three indices from a $2$-element set | **identically zero**, and for a reason independent of every hypothesis: a totally antisymmetric $c$ restricted to a $2$-dimensional index space is zero, i.e. $\Lambda^3(\mathbb R^2)=0$. Equivalently $T$ is hollow and three indices among two must repeat |

**So "each structurally rather than numerically" is true of all three but means different things.** For $(---)$ it means *identically*, and the threshold is exact: $\Lambda^3(\mathbb R^d)=0$ **iff** $d\le2$, and at $d=3$ the form is live, $\Lambda^+\cong\mathfrak{su}(2)$ has $c_{123}=\pm\sqrt2\ne0$ by the bracket I computed in §3. For $(+++)$ and $(++-)$ it means *under H4*, the hypothesis the statement carries. Both readings are hypotheses the statement carries, so **no defect**, but a consumer widening $k$ must know that two of the three blocks come back and only $(---)$ survives the widening. The block's own $k=2$ paragraph confirms this is understood: at $k=2$, $(+++)$ still vanishes (three *distinct* positive indices, only two available) while $(++-)$ genuinely reappears and is dropped for a different reason, namely $\lambda_+\lambda_+\lambda_-<0$ against $T\ge0$.

**One presentational check.** The four-block split is exhaustive only after the zero-eigenvalue indices are discarded, and the block never says so. It is sound (such terms carry a factor $\lambda_\gamma=0$) but at padded $W_{\mathbb{CP}^2}$ the discarded indices are $63$ of $66$, so the unstated step is doing most of the arithmetic. Recorded, not charged.

**And the $k=2$ arithmetic in the block checks.** With positives $\lambda_1\ge\lambda_2>0$ the surviving block is $3(T_{1,N-1,N}\lambda_1+T_{2,N-1,N}\lambda_2)ab$, and $T_{1,N-1,N}+T_{2,N-1,N}$ are two nonnegative terms of the single sum $\sum_\gamma T_{N-1,N,\gamma}\le2$, so the **joint** cap is immediate and gives $\le6\lambda_1ab$. Applying the per-index cap twice instead gives $6(\lambda_1+\lambda_2)ab=6(a+b)ab$, which at $\lambda_1=\lambda_2=a=b$ and $\lVert W\rVert=1$ has $4a^2=1$, so $a=\tfrac12$ and the bound reads $12a^3=3a=\tfrac32$, exactly the block's "$3a$ with maximum $1.5$". **The block's correction is right and its numbers reproduce by hand.**

## 5. Quantifier order, scope, and every edge of the range

**Quantifier order.** "Let $W$ … have $\lVert W\rVert=1$ and exactly one positive and two negative eigenvalues. Then $\theta(W)\le\sqrt{3/2}$, attained at the spectrum $(2,-1,-1)/\sqrt6$." The first sentence is $\forall W$; the second is $\exists W$ (a $W$ with that spectrum attains), not $\forall W$ with that spectrum. The two are not equivalent above $n=4$: by the L31 closure (§7) equality forces support $r=4$, so a hypothetical full-support signature-$(1,2)$ element of $\mathrm{Weyl}_r$ at $r\ge6$ would carry the spectrum $(2,-1,-1)/\sqrt6$ and **not** attain. Whether such an element exists is open on the record. The $\exists$ reading is the true one and is what the record means; the sentence supports both. *Recorded as a reading hazard, not a defect.*

**Odd $n$.** Every step of §2.1 is parity-blind. L31's root system at odd $n$ is $B_\ell$, whose extra short roots give $\mathrm{ad}_X$ the further eigenvalues $i(\pm s_i)$; since $s_1\le s_1+s_2$ the maximum is unchanged, so the cap is still $(s_1+s_2)^2\le2$. Padded $W_{\mathbb{CP}^2}$ exists at every odd $n\ge5$. **The lemma holds at odd $n$ with no repair.** (The *consequence* drawn at odd $n$ does need one, §9, candidate C.)

**$\ker W\ne0$.** Handled in §3; required, not tolerated.

**Eigenvalue multiplicities greater than one.** The negative eigenvalue is repeated exactly at the attaining object ($a=b$), giving a $2$-dimensional negative eigenspace and a non-unique $v_2,v_3$. Shown invariant in §3. The positive eigenvalue has multiplicity $1$ by H4. **No breakage.**

**The multiplicity reading of H4, the one thing not on file.** The record has already paid for this once: [L33](../findings/stratum-two-negative.md)'s block carries a blockquote reading *"'Exactly one eigenvalue of one sign' was ambiguous, and the lemma is FALSE under the other reading"*, with a $\mathrm{Weyl}_4$ witness, and adds that the with-multiplicity convention "is quoted in [results.md](../results.md) and in the report, where that convention does not travel". L29 has the identical exposure and **no such note anywhere**.

- Under the with-multiplicity reading the statement is exactly what §2.1 proves.
- Under the distinct-values reading, one distinct positive value at any multiplicity, two distinct negative values at any multiplicities, the proof of §2.1 fails at step 2: $(+++)$ and $(++-)$ become live, and steps 6–7 are no longer three-term equations.
- **And the claim is then not covered by [L35](../findings/stratum-two-negative.md) either**, because L35 needs at most two negative eigenvalues *counted with multiplicity*, while the distinct-values reading admits, say, $-a$ at multiplicity $5$ and $-b$ at multiplicity $3$.
- [r513](../reviews/REVIEW_r513.md) reached the same place and says so in terms: its screen at $W^+=W^-=\mathrm{diag}(p,-a,a-p)$ gives $\theta=\theta(W^+)/\sqrt2\le\sqrt3/2$, I confirm the factor, since $\lVert W\rVert^2=2\lVert W^+\rVert^2$ and $P$ splits over the two commuting blocks, and it concludes *"whether L29 also happens to be true under that reading is left open"*.

[INDEX-results.md](../findings/INDEX-results.md):44 says L29 is "Free of [L33]'s multiplicity ambiguity, **self-disambiguating wherever quoted**". That is true of the *statement*, whose display $\lambda_1>0>-a\ge-b$ names the eigenvalues as a complete list. **It is false of the landscape paraphrase at [results.md](../results.md):144, which carries no display**, see §9, candidate B.

## 6. A universal claim with no witness, one object from each structured family the record names

The claim under test: *no unit $W$ with exactly one positive and two negative eigenvalues has $\theta>\sqrt{3/2}$.* I looked for a falsifier among the families the record names, and evaluated by hand.

| family, as the record names it | is it in the stratum? | $\theta$, exactly | exceeds $\sqrt{3/2}$? |
| --- | --- | --- | --- |
| self-dual family $W^+=\mathrm{diag}(q+r,-q,-r)$, $W^-=0$, at $(q,r)=(1,1)$ | yes | $\lVert W\rVert^2=6q^2$, $\theta=9q^2\cdot2q/(6q^2)^{3/2}=18/(6\sqrt6)=\sqrt{3/2}$ | **no, equality** |
| the same at $(q,r)=(2,1)$ | yes | $\lVert W\rVert^2=9+4+1=14$, $\theta=54/14^{3/2}$, so $\theta^2=\tfrac{2916}{2744}=\tfrac{729}{686}$ against $\tfrac32=\tfrac{1029}{686}$ | no |
| the same at $(q,r)=(3,1)$ | yes | $\lVert W\rVert^2=26$, $\theta^2=\tfrac{11664}{17576}$; $2\cdot11664=23328<52728=3\cdot17576$ | no |
| padded $W_{\mathbb{CP}^2}$ | yes (it is the $q=r$ member | $\sqrt{3/2}$ | **no), equality** |
| $W_{\mathbb{CP}^m}$, $m\ge3$ ([L28](../findings/nondegeneracy.md)) | the record gives no signature; irrelevant either way | $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, which is $\tfrac{10}9$ at $m=3$ and $\tfrac{35}{36}$ at $m=4$ | no |
| [L34](../findings/stratum-two-negative.md), two padded signature-$(2,1)$ $\mathrm{Weyl}_4$ tensors on $4$-planes, $m=6,8$ | **no**, signature $(4,2)$, so it is [L35](../findings/stratum-two-negative.md)'s stratum, not L29's | the record's $+0.485$ | no |
| sphere products $S^p\times S^q$, padded $S^3\times S^3$ | **no** (padded $S^3\times S^3$ carries nine negative eigenvalues |), |, |
| strongly regular graph points ([L74](../results.md)) | **no** (two distinct sectional values, many eigenvalues of each sign |), |, |

**Only one structured family the record names has signature $(1,2)$**, and it is the self-dual one; the record's own support argument explains why, since at $r=4$ that family exhausts the stratum. Every member evaluates at or below the cap, with equality exactly at $q=r$, matching $f(t)$'s equality set $t=1$.

**And the search extends past $\mathrm{Weyl}_n$.** §2.1 uses only $\lVert W\rVert=1$, $\mathop{\mathrm{tr}}W=0$ and the sign pattern, so a falsifier need not be a Weyl operator: any trace-free symmetric operator on $\Lambda^2\mathbb R^n$ of the form $\lambda_1u_1u_1^{\mathsf T}-au_2u_2^{\mathsf T}-bu_3u_3^{\mathsf T}$, for an orthonormal triple $u_i\in\mathfrak{so}(n)$, is admissible for the argument. **The bound holds on that wider class too**, and no falsifier exists there either, for the reason in §10.

## 7. Comparing the forms on file

| site | what it says | agrees with the canonical block? |
| --- | --- | --- |
| [stratum-two-negative.md](../findings/stratum-two-negative.md):12, development form | statement + proof; converse *"reduced but not closed"*, hedged on numerics at $r=6,8,10$ with *"$r\ge12$ untested"* | **statement and proof: yes. Converse: superseded**, the L31 closure removes this hedge, since equality forces $r=4$ and no $r\ge6$ element can be an equality point |
| [stratum-two-negative.md](../findings/stratum-two-negative.md):69, canonical | statement + proof; converse *"closed in three lines by [Lemma L31] … [Lemma L33] closes it by a second route"*; blockquote withdrawing the L72 credit | the mathematics is the same as :12 line for line; this is the current form |
| [results.md](../results.md):439–441, canonical statement | identical statement, but *"The converse … is Lemma L72, listed in the closing section"* | **NO**, carries the withdrawn attribution. §9, candidate A |
| [results.md](../results.md):144, landscape | *"One positive and two negative eigenvalues cap $\theta$ at $\sqrt{3/2}$. Dimension-free, attained at $(2,-1,-1)/\sqrt6$…"* | **partially**, no display, so no multiplicity reading. §9, candidate B |
| [results.md](../results.md):784, closing section | *"**Lemma L72** (… closing the converse clause of Lemma L29 by the criticality rows alone"* | **NO**), same withdrawn attribution, second site. §9, candidate A |
| [INDEX-results.md](../findings/INDEX-results.md):44 | *"The scope is $k\le2$, not $k=1$"*; equality clause closed by L31; free of the multiplicity ambiguity | **the L31 half agrees; the $k\le2$ half has no statement behind it.** §9, candidate E |
| [lean/INDEX.md](../lean/INDEX.md):104, [L29.lean](../lean/HamiltonsCubic/Results/L29.lean), **partial** | formalises the one-variable half via the perfect-square factorisation; explicitly **owes** the three vanishing blocks, the pair cap, trace-freeness and the normalisation; and records that the tensor-level converse is L31/L33's, *"strictly stronger than $t=1$"* | **yes, and it is the most accurate description of L29 on the record.** I verified its factorisation by hand in §2.1; I confirm both the identity and the row's account of what it does and does not cover |

**A Lean row exists**, so the brief's fallback question does not arise. What it claims is exactly the half a machine can carry, and it declines the half it cannot, including, correctly, that the equality case it reads off the factorisation is $t=1$, a statement about the ratio $b/a$, and not the tensor-level statement about the spectrum and the support.

## 8. The gap between what is proven and what is used

**Proven, and citable by anyone.**

1. For every $n\ge4$ of either parity and every unit $W\in\mathrm{Weyl}_n$ whose spectrum has exactly one positive and exactly two negative entries **counted with multiplicity**, $\theta(W)\le\sqrt{3/2}$. Dimension-free.
2. The same, for **any** trace-free symmetric operator on $\Lambda^2\mathbb R^n$ with that sign pattern, no first Bianchi, no Ricci-flatness. *The block does not claim this; [L35](../findings/stratum-two-negative.md)'s block claims it for its own chain, and the identical remark applies here.*
3. The cap is attained: at $(2,-1,-1)/\sqrt6$, i.e. padded $W_{\mathbb{CP}^2}$, at every $n\ge4$. Exact, by four routes.
4. Equality $\Rightarrow$ $b/a=1$ $\Rightarrow$ spectrum $(2,-1,-1)/\sqrt6$. **This is a consequence of the lemma's own proof**, from the uniqueness of $t=1$, and needs neither L31 nor L72. §9, candidate A.
5. Equality $\Rightarrow$ $T_{1,N-1,N}=2$ $\Rightarrow$ $\lVert[v_{N-1},v_N]\rVert^2=2$ $\Rightarrow$ (L31) $\mathop{\mathrm{im}}v_{N-1}=\mathop{\mathrm{im}}v_N$ of dimension $4$ $\Rightarrow$ (Ricci-flatness) support $r=4$. **This is strictly stronger than (4) and is where H1 is genuinely spent**, a consumer working in the wider class of (2) may cite (4) but not (5).

**Not proven, and not citable.**

6. **$k\le2$**, i.e. two positive eigenvalues. No statement on the record says it. The argument is prose inside L29's block; the statement that covers it is [L35](../findings/stratum-two-negative.md), whose close runs on $200$-bit interval arithmetic. A consumer wanting $k\le2$ should cite L35 and inherit that caveat.
7. **The distinct-values reading of H4.** Open, §5.
8. **"$\theta=f(t)$ exactly, not merely at the maximiser"**, for stratum members of support $r\ge6$. Proved at $r=4$; §9, candidate D.
9. **"No maximiser in that dimension range has this spectrum"** at odd $n$, as written. §9, candidate C.

## 9. The named trap, each citable claim read alone, as a consumer would

### Candidate A, the withdrawn L72 credit is still standing in [results.md](../results.md), at two lines

**Locate.** [results.md](../results.md):441, the canonical statement of L29:

> The converse (that equality forces that spectrum), is Lemma L72, listed in the closing section.

and [results.md](../results.md):784:

> **Lemma L72**, every critical point with exactly one positive and two negative eigenvalues has spectrum $(2,-1,-1)/\sqrt6$ on its support and $\theta=\sqrt{3/2}$, closing the converse clause of Lemma L29 by the criticality rows alone

**Exhibit the failure concretely.** The correction is on file in three other places and reached neither line. [stratum-two-negative.md](../findings/stratum-two-negative.md):69 carries, immediately under the statement, a blockquote in capitals: *"THE CREDIT ONCE GIVEN HERE TO LEMMA L72 IS WITHDRAWN, AND THE CONTAINMENT RUNS THE OTHER WAY."* [INDEX-results.md](../findings/INDEX-results.md):86 records [r542](../reviews/REVIEW_r542.md) as REFUTED on exactly that clause. [LEDGER.md](../findings/LEDGER.md):911 states the containment. And the mathematics is plain: L72 quantifies over **critical** points, the clause over **equality** points, and L29 together with L72 puts the critical points *inside* the equality points, a property forced on a subset is not forced on the superset. A consumer who opens [results.md](../results.md) alone, which is the file the record designates as its numbered canon, reads a converse discharged by a lemma that cannot discharge it, and is given no pointer to L31.

**Argue the opposite, the most charitable reading the words support.** One could read ":441 is stale but harmless, because the converse is true anyway and is proved elsewhere." That is right about the truth and wrong about the citation: a consumer needing the converse cites what :441 names, and what it names proves a strictly weaker statement. Second charitable reading: "L72 does establish the converse *at critical points*, which is all any consumer wants." Even granting that, the sentence as printed makes no such restriction, and the record's own reviewers split on precisely this ([r541](../reviews/REVIEW_r541.md) CONFIRMED, [r542](../reviews/REVIEW_r542.md) REFUTED on the clause), so the ambiguity is demonstrated, not hypothetical. **The candidate stands.**

**And a second observation that makes the whole dispute smaller than the record treats it.** The converse *as :441 and the canonical block state it* ("equality forces that spectrum"), follows in two lines from the lemma's own proof: equality forces $f(t)=\sqrt{3/2}$, which by §2.1's uniqueness forces $t=1$, hence $a=b$, hence with $\lambda_1=2a$ and $6a^2=1$ the spectrum $(2,-1,-1)/\sqrt6$. Neither L31 nor L72 is needed for it. **What L31's three lines actually deliver is the stronger statement** (that equality forces support $r=4$, hence that the equality set is one $SO(n)$-orbit) and the block states the weak converse while proving the strong one. The correct repair at :441 is therefore not "L72 $\to$ L31" but a distinction between the two clauses.

### Candidate B, the landscape paraphrase at [results.md](../results.md):144 states something the record leaves open

**Locate.**

> - **Lemma L29 (landscape). One positive and two negative eigenvalues cap $\theta$ at $\sqrt{3/2}$.** Dimension-free, attained at $(2,-1,-1)/\sqrt6$, padded $W_{\mathbb{CP}^2}$.

**Exhibit the failure concretely.** The canonical statement fixes the multiplicity reading through its display $\lambda_1>0>-a\ge-b$, read as a complete list of the nonzero eigenvalues. The landscape line has no display. Read alone (which is how a landscape line is read), "one positive and two negative eigenvalues" admits the distinct-values reading, under which: (i) $(+++)$ and $(++-)$ no longer vanish, so the proof on file does not apply; (ii) [L35](../findings/stratum-two-negative.md) does not cover it either, since a distinct negative value may carry multiplicity above $2$; and (iii) [r513](../reviews/REVIEW_r513.md) states the position outright, *"whether L29 also happens to be true under that reading is left open"*. This is the exact failure the record documented for [L33](../findings/stratum-two-negative.md), whose blockquote says the with-multiplicity convention "is quoted in results.md and in the report, where that convention does not travel". L29 has the same exposure with no such note.

**Argue the opposite.** The charitable reading: a landscape line is a pointer, and the reader who needs the hypothesis opens the canonical statement thirty lines of file below, which disambiguates. That is fair for a careful reader, and it is why this is `HYPOTHESIS-DEBT` on the line rather than a defect in the lemma. But [INDEX-results.md](../findings/INDEX-results.md):44 makes the stronger claim that L29 is "self-disambiguating **wherever quoted**", and :144 is a quotation where it is not. **The candidate stands, at the narrower scope: the index row overclaims, and :144 is the site that refutes it.**

### Candidate C, the exclusion at odd $n$ rests on the wrong constant

**Locate.** [stratum-two-negative.md](../findings/stratum-two-negative.md):69, the canonical block's closing paragraph:

> Since $\sqrt{3/2}<\theta_0(n)$ from $n=12$, no maximiser in that dimension range has this spectrum

**Exhibit the failure concretely.** The inference needs $M(n)>\sqrt{3/2}$, and it gets there through $\theta_0(n)$. But [conventions.md](../findings/conventions.md) states, in capitals about this very symbol, that $\theta_0(n)$ is *"the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more"*, that it is the value at the balanced sphere product **at even $n$ only**, and that the gloss identifying the two "is what regrew [L0](../findings/problem.md)'s refuted constant". At odd $n$, $\Theta_n<\theta_0(n)$ with $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))$, and nothing on the record realises $\theta_0(n)$ at odd $n$, so $M(n)\ge\theta_0(n)$ is not available and the stated inference does not run at $n=13,15,\dots$

**The repair, and it is one symbol.** Use $\Theta_n\le M(n)$, which holds at both parities. $\Theta_n^2>\tfrac32$ reads $4(n-1)(n-3)>3(n+1)(n-2)$, i.e. $4n^2-16n+12>3n^2-3n-6$, i.e. $n^2-13n+18>0$, whose larger root is $(13+\sqrt{97})/2$, between $11$ and $12$ since $\sqrt{97}$ lies between $9$ and $10$. So $\Theta_n>\sqrt{3/2}$ **exactly for $n\ge12$, at both parities**, the same threshold. At even $n$ the check is direct: $\theta_0(12)^2=\tfrac{220}{144}=\tfrac{55}{36}>\tfrac{54}{36}=\tfrac32$, and $\theta_0(11)^2=\tfrac{180}{121}<\tfrac32$ since $360<363$.

**Argue the opposite.** Charitably: "$\theta_0(n)$ is the target of the Böhm–Wilking criterion, and the sentence means the criterion's threshold rather than an attained value." Under that reading the sentence says something true about the criterion but nothing about maximisers, which is what it asserts. Second charitable reading: "the record works at even $n$ throughout this file, so the odd case is out of scope." The block does not say so, and it advertises the bound as dimension-free two lines above. **The candidate stands, as a defect in the stated reason, with the conclusion surviving intact under the one-symbol repair.**

### Candidate D, "saturated identically" is proved at support $r=4$ only

**Locate.** [stratum-two-negative.md](../findings/stratum-two-negative.md):69:

> The pair cap is therefore saturated identically and $\theta=f(t)$ exactly, not merely at the maximiser.

**Exhibit the failure concretely.** The "therefore" runs through *"and at dimension four $v_2,v_3$ are an orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$"*. The preceding sentence establishes only that the support has **even** dimension, not that it is four. For a stratum member of support $r\ge6$ the derivation gives nothing, and whether such members exist is the very question the development form at :12 hedges, *"Excluded numerically at $r=6,8,10$ … with $r\ge12$ untested"*. [r514](../reviews/REVIEW_r514.md)'s finding (c) records exactly this: *"The support is shown even-dimensional, not four-dimensional, so for stratum elements of support $r\ge6$ the identity rests on the same unclosed non-existence the converse clause names. The **bound** is untouched; the **identity** is conditional."* That finding is not in the block. Separately, the $r=4$ step itself (that $v_2,v_3$ then lie in a single $\Lambda^\pm$), is asserted with no argument in the block; [r514](../reviews/REVIEW_r514.md) supplies the missing line in a parenthesis (with each of $W^\pm$ trace-free and only one positive eigenvalue in total, a nonzero $W^-$ forces $W^+=0$), and the block was written without it.

**Argue the opposite.** The charitable reading: "identically" modifies "on this stratum", and the sentence immediately before restricts to dimension four, so the scope is clear from context. That is the most the words support, and even under it the phrase "not merely at the maximiser" invites the wider reading, which is the one a consumer takes, since the sentence's whole point is that the estimate is not lossy. **The candidate stands as a scope defect in an addendum. It does not touch the bound**, and I say so explicitly because that is what a consumer needs to know.

### Candidate E, [INDEX-results.md](../findings/INDEX-results.md):44's "the scope is $k\le2$" has no statement behind it

**Locate.**

> **The scope is $k\le2$, not $k=1$**, the reason first given for stopping was wrong on both counts, and the extension turns on the joint cap.

**Exhibit the failure concretely.** The canonical statement at [results.md](../results.md):441 and at [stratum-two-negative.md](../findings/stratum-two-negative.md):69 both read "**exactly one** positive and two negative eigenvalues". No numbered statement anywhere says $k\le2$. The $k=2$ argument exists only as prose in L29's block, and [LEDGER.md](../findings/LEDGER.md):617 records the history: three sites billed L29 at $k\le2$, *"which the block's own closing sentence refuses"*, and the resolution was to let the citations stand rather than to widen the statement. So the index row and the statement now disagree, and a consumer citing "Lemma L29" for $k=2$ is citing prose. **The argument itself is correct**, I checked it in §4, including the joint cap and the $3a$/$1.5$ arithmetic, so this is a bookkeeping defect, not a mathematical one; the covering statement is [L35](../findings/stratum-two-negative.md).

**Argue the opposite.** Charitably: an index row is allowed to record what a Gate 2 established beyond the statement, and this one names the mechanism. Fair, but the row says "**the scope is**", present tense, of a lemma whose statement says otherwise in two files, and it does not name L35 as the covering result. **The candidate stands, at the level of an index row.**

### No finding, recorded as such

- **No finding: the pair cap's provenance.** L31 is a numbered result with its equality case, Gate 2 by [r543](../reviews/REVIEW_r543.md)/[r544](../reviews/REVIEW_r544.md), and its root-system step is the one L29 consumes. It is cited, not assumed.
- **No finding: the $\dim\mathfrak m\le2$ threshold.** Exact in both directions, $\Lambda^3(\mathbb R^d)=0$ iff $d\le2$, and at $d=3$ the form is live with $c_{123}=\pm\sqrt2$ on $\Lambda^+$.
- **No finding: the block's Gate 2 line.** [r513](../reviews/REVIEW_r513.md) and [r514](../reviews/REVIEW_r514.md) exist, are on identical briefs, and their content matches what the block credits them with. I read both.
- **No finding: an unread source.** L29's proof cites no external source. The neighbouring [L33](../findings/stratum-two-negative.md) block cites Besse §1.143 and Petersen–Wink Proposition 1.6, and **[references/](../references/) holds no Besse entry**, but L33 is not an input to L29's bound, so this does not reach the claims under audit. Recorded because the brief asks.

## 10. What would break it, and what I did to look for it

**The object that would falsify the bound.** A pair of **orthonormal** $X,Y\in\mathfrak{so}(n)$ with $\lVert[X,Y]\rVert^2>2$, equivalently, a unit skew $X$ whose two largest angles satisfy $s_1+s_2>\sqrt2$. Everything else in the chain is an identity or a hypothesis: steps 1, 3, 5, 6, 7 of §2.1 are equalities, step 2 is forced by hollowness of $T$ and the sign counts, and step 8 is the polynomial identity $4(t^2+t+1)^3-27t^2(t+1)^2=\big((t-1)(t+2)(2t+1)\big)^2$. **The cap rests on one inequality and one inequality only.**

**What I did to look for it.** Three things, all by hand.

1. **Re-derived L31's bound from the root system.** $\mathrm{ad}_X$ is skew-adjoint on $\mathfrak{so}(n)$ with eigenvalues $i(\pm s_i\pm s_j)$ and $i(\pm s_i)$, so $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$, and $(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2$ under $\sum_is_i^2=1$. **No such $X$ exists, at any $n$, of either parity.** The equality case is $s_1=s_2=1/\sqrt2$ and the rest zero (rank exactly $4$) which is also why the falsifier's absence and the cap's attainment are one computation.
2. **Checked the discarded route.** The block's own record says an earlier derivation argued rank $4$ from $\lVert[X,Y]\rVert^2\le4s_1^2$, and that this is a non-sequitur with the witness $s^2=(0.5,0.3,0.2)$ at rank $6$. I confirm the witness kills that route: $\sum s_i^2=1$ and $s_1^2=\tfrac12$ at rank $6$. **The bound survives because it does not run on that route**; the root-system identity replaced it, and the replacement is what L29 consumes.
3. **Exhibited the extremal pair rather than assuming it.** $[\omega_1,\omega_2]=-\sqrt2\,\omega_3$ in $\Lambda^+\mathbb R^4$, computed entry by entry in §3, gives $\lVert[X,Y]\rVert^2=2$ exactly, so the cap is tight and cannot be lowered. A sharper cap would falsify **attainment**, which is the other half of the statement.

**A second falsifier, for the equality clause.** A unit $W\in\mathrm{Weyl}_r$ at even $r\ge6$ with full support, exactly one positive and two negative eigenvalues. If it existed with spectrum $(2,-1,-1)/\sqrt6$ it would have that spectrum without attaining the cap, refuting the $\forall$-reading of "attained at the spectrum" flagged in §5. It cannot be an equality point (L31 forbids that) so **the bound and the converse are both safe from it**; only the reading is at risk. The record's own status on its existence is: excluded numerically at $r=6,8,10$, untested at $r\ge12$. I opened no computation, per the standing footing.

## Verdict

**PROVEN, hypotheses corrected.**

The inequality, its dimension-freeness and its attainment are correct, and I re-derived every step by hand: the four-block split, the surviving $3T_{1,N-1,N}\lambda_1ab$, the pair cap, the collapse to $f(t)$, the unique stationary point at $t=1$, the value $\sqrt6/2$, the perfect-square factorisation that replaces the calculus, and $T_{1,N-1,N}=2$ at the attaining object from the $\mathfrak{su}(2)$ bracket. The cap is dimension-free because the only step where $n$ could enter (the pair cap), spends just the top two angles of a unit skew matrix against $\sum_is_i^2=1$, and the $n$-dependent companion fact, the row marginal $2(n-2)$, is never used.

**The corrections the record owes, in the order a consumer would meet them.**

1. **[results.md](../results.md):441 and :784** must stop crediting the converse to [L72](../findings/stratum-two-negative.md). The withdrawal has stood in [stratum-two-negative.md](../findings/stratum-two-negative.md), [INDEX-results.md](../findings/INDEX-results.md) and [LEDGER.md](../findings/LEDGER.md) and reached neither line, the record's signature failure, at its canonical file. And the repair is not a swap of names: the *weak* converse (equality $\Rightarrow$ spectrum) is a two-line consequence of L29's own proof, while what [L31](../findings/stratum-two-negative.md)'s three lines deliver is the *strong* converse (equality $\Rightarrow$ support $r=4$). The two clauses need separating.
2. **H4 must say "counted with multiplicity"**, at the statement and at the landscape line [results.md](../results.md):144. Under the other reading the proof does not apply, [L35](../findings/stratum-two-negative.md) does not cover it, and [r513](../reviews/REVIEW_r513.md) leaves it open, while [INDEX-results.md](../findings/INDEX-results.md):44 calls the lemma "self-disambiguating wherever quoted", which :144 refutes.
3. **The exclusion sentence must read $\Theta_n$, not $\theta_0(n)$.** The threshold is $n\ge12$ either way, by $n^2-13n+18>0$, so the conclusion survives untouched; the stated reason does not run at odd $n$, and [conventions.md](../findings/conventions.md) warns about this exact substitution in capitals.
4. **"Saturated identically … not merely at the maximiser" is an $r=4$ statement**, as [r514](../reviews/REVIEW_r514.md)'s finding (c) said and the block never absorbed. The bound is untouched; the identity is conditional.
5. **[INDEX-results.md](../findings/INDEX-results.md):44's "the scope is $k\le2$" has no statement behind it.** The $k=2$ argument is sound and I checked its arithmetic, but it lives in prose; the covering numbered result is [L35](../findings/stratum-two-negative.md), whose own close is certified interval arithmetic rather than a hand-checkable argument.

**What a consumer may cite today, in one sentence.** *For every $n\ge4$ of either parity, every unit $W\in\mathrm{Weyl}_n$ whose spectrum has exactly one positive and exactly two negative entries counted with multiplicity satisfies $\theta(W)\le\sqrt{3/2}$, with equality forcing the spectrum $(2,-1,-1)/\sqrt6$ and attained there by padded $W_{\mathbb{CP}^2}$*, and, if the further clause is wanted, *equality forces the support to be a $4$-plane, which is where the Weyl hypothesis is genuinely spent.*
