# Review r430, Lemma L140, $\lVert g_1\rVert^2\le\tfrac14$ and the closure of I3

**Reviewer r430, adversarial audit, 2026-09-03. Target: [Lemma L140](../findings/route-a.md) in [route-a.md](../findings/route-a.md), read together with the corrected [Lemma L136](../findings/route-a.md), [Lemma L135](../findings/route-a.md), [Lemma L134](../findings/route-a.md) and [Lemma L17](../findings/route-a.md). Analysis only, no computation beyond a seconds-long arithmetic screen of the multiplier table and the $n$-threshold, reported as a screen.**

## Verdict

> **CONFIRMED** for the boxed inequality $\lVert g_1\rVert^2\le\tfrac14$, which I re-derived from scratch by a second route and cross-checked against [Lemma L17](../findings/route-a.md)'s independently established first-order formula. **The two root causes that refuted [L137](../findings/route-a.md)–[L139](../findings/route-a.md) genuinely do not reach it**: no fixed projector is traced against, and the estimate is symmetric under the convention flip.
>
> **PLAUSIBLE, with three corrections, for the headline "[I3](../plan.md) holds for every $n\ge12$"**, that sentence is stated unconditionally in the bold display and qualified only afterwards, and it inherits three obligations the lemma does not name.

## What I verified, and how

### 1. $\mathrm{Alt}(H)=0$, and $\mathrm{Alt}$ is an orthogonal projection, both CONFIRMED, and the record's own constants pin them

$S^2(\Lambda^2\mathbb R^n)=\mathcal R\oplus\Lambda^4$ with the Bianchi map the projection onto $\Lambda^4$; $\Lambda^4$ occurs once, so the splitting is orthogonal for the invariant inner product and $\lVert\mathrm{Alt}\rVert=1$. **I did not take this on trust, it is forced by two numbers already in the record.** On the distinguished $\mathbb R^4$, $\star=\Pi_{SD}-\Pi_{ASD}$ with $\lVert\star\rVert^2=6$, and orthogonal projection onto $\mathrm{span}(\star)$ would give

$$\mathrm{Alt}(X)=\frac{\langle X,\star\rangle}{6}\,\star .$$

With $u_-=\tfrac1{\sqrt6}(\hat\omega_2\hat\omega_2^{\mathsf T}+\hat\omega_3\hat\omega_3^{\mathsf T})$ this returns $\langle u_-,\star\rangle=\tfrac2{\sqrt6}$ and $a=\tfrac{2/\sqrt6}6=\tfrac1{3\sqrt6}$, **exactly [Lemma L135](../findings/route-a.md)'s $a$**, and $\lVert g_0\rVert^2=6a^2=\tfrac19$, exactly $\delta^2(u)$. The same formula gives $\langle u,\star\rangle=\tfrac1{\sqrt6}(2-1-1)=0$, i.e. $\mathrm{Alt}(u)=0$, which is the Bianchi identity for $u$ read off the SD spectrum. **Two independent constants of the record fall out of the assumption, so the assumption is right**, and $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$ is legitimate. The step $\lVert g_1\rVert\le\inf_\mu\lVert Z+\mu H\rVert$ is therefore sound.

### 2. The multiplier table, CONFIRMED entry by entry

$f(x)=\tfrac12(\lvert x\rvert-x)$, so $f\equiv0$ on $[0,\infty)$ and $f(x)=-x$ on $(-\infty,0)$; $u$'s spectrum is $\tfrac1{\sqrt6}(2,-1,-1)$ on $E$ and $0$ on $K$. Divided differences $f^{[1]}(\lambda,\mu)=\frac{f(\lambda)-f(\mu)}{\lambda-\mu}$:

| pair | value | check |
| --- | --- | --- |
| $(\hat\omega_1,\hat\omega_1)$ | $0$ | $f'(2/\sqrt6)=0$, $f\equiv0$ near a positive eigenvalue |
| $(\hat\omega_1,\hat\omega_{2,3})$ | $-\tfrac13$ | $(0-\tfrac1{\sqrt6})/(\tfrac2{\sqrt6}+\tfrac1{\sqrt6})=-\tfrac13$ |
| among $\hat\omega_2,\hat\omega_3$ | $-1$ | $f'(-1/\sqrt6)=-1$; $f$ is exactly linear there, so the degenerate $2\times2$ block is basis-free |
| $(\hat\omega_1,K)$ | $0$ | $f(\lambda_1)=f(0)=0$, so the difference is $0$, **the entry is genuinely $0$, not $\tfrac{f(\lambda_1)}{\lambda_1}$ of something nonzero** |
| $(\hat\omega_{2,3},K)$ | $-1$ | $(\tfrac1{\sqrt6}-0)/(-\tfrac1{\sqrt6}-0)=-1$ |

All lie in $[-1,0]$. *Screen: I evaluated the $4\times4$ divided-difference table numerically in seconds and it reproduces the five values exactly, with `nan` at $(K,K)$, the degeneracy the lemma flags.* The table is a **row-wise** statement on the $E\times K$ block ($0$, $-1$, $-1$) and a **uniform** one on the $\hat\omega_{2,3}$ block, so it is independent of the basis chosen inside $K$ and inside the degenerate eigenspace. That matters and the lemma does not say it; see correction (C2).

### 3. The form of $Z$, CONFIRMED, and derived here without using L135

This is where the brief expects the previous refutation's root cause (ii) to reappear. It does not, and here is the derivation, from Rellich/Kato and nothing else.

Split $W(t)=u+tH$'s spectrum into the $E$-group (isolated, eigenvalues $\pm$ bounded away from $0$) and the $K$-group (all at $0$).

- **$K$-branch.** Eigenvalues are $\lambda_j(t)=t\,d_j+O(t^2)$ with $d_j\in\operatorname{spec}(D|_K)$ and eigenvectors $v_j(t)=v_j^{(0)}+O(t)$, $v_j^{(0)}\in K$. Then $f(\lambda_j(t))=t\,f(d_j)+O(t^2)$ for $t>0$, so the branch contributes $t\,\Pi_K f(D)\Pi_K+O(t^2)=t\,D_-+O(t^2)$. Because $f(\lambda_j(t))=O(t)$ already, the $O(t)$ motion of $v_j$ enters only at $O(t^2)$, **so the $K$-branch contributes to the $K\times K$ block alone at first order, and nothing to $E\times K$.**
- **$E$-branch.** $\frac{d}{dt}\big[f(\lambda_i(t))v_i(t)v_i(t)^{\mathsf T}\big]_{t=0}=f'(\lambda_i)H_{ii}v_iv_i^{\mathsf T}+f(\lambda_i)(\dot v_iv_i^{\mathsf T}+v_i\dot v_i^{\mathsf T})$ with $\dot v_i=\sum_{j\ne i}\frac{H_{ji}}{\lambda_i-\lambda_j}v_j$. Summing over the branch gives, on $E\times E$, $\frac{f(\lambda_i)-f(\lambda_j)}{\lambda_i-\lambda_j}H_{ij}$; and on $E\times K$, $\frac{f(\lambda_i)-f(0)}{\lambda_i-0}H_{ij}$, **exactly the divided-difference multipliers**, with $\lambda_i-\lambda_j=\lambda_i$ for $j\in K$. Since $v_i\in E$ and $\dot v_iv_i^{\mathsf T}$ is supported on $(E\oplus K)\times E$, the $E$-branch contributes **nothing to $K\times K$** at first order.

So $Z=\mathcal D_u[H]+D_-$ with $\mathcal D_u[H]$ the multiplier matrix on $E\times E$ and $E\times K$ and **zero on $K\times K$**, and $D_-$ living on $K\times K$ alone. **There is no cross term, no double count, and no contribution from the block-diagonalising transformation**, the $I+O(t)$ transformation of [Lemma L135](../findings/route-a.md)(c) is a change of the *object*, not an extra term, and its effect on a first-order coefficient is already inside the eigenvector-tilt terms above.

**And the "$Z_{KK}=D_-$ exactly" claim survives the Schur correction.** [Lemma L135](../findings/route-a.md)(c) writes the reduced $K$-block as $t\big(D-tC^{\mathsf T}\Lambda^{-1}C\big)+O(t^3)$; by degree-one homogeneity its negative part is $t\,(D-tS)_-$, and $N\mapsto N_-$ is $1$-Lipschitz, so $(D-tS)_-\to D_-$ as $t\to0^+$. **Only continuity is used, never differentiability**, which is why [Lemma L136](../findings/route-a.md)'s "$\mathcal E_D$ exists nowhere on $\{F=0\}$" does not obstruct the *first*-order coefficient, though it does obstruct the second. The lemma asserts the exactness without this sentence; see correction (C3).

**Independent cross-check that fixes both the table and the sign convention at once.** Pairing my $Z$ against $g_0=a\star$:
$$2\langle g_0,\mathrm{Alt}(\mathcal D_u[H])\rangle=2a\langle\star,\mathcal D_u[H]\rangle=2a\big(\operatorname{tr}(\Pi_{SD}\mathcal D_u[H])-\operatorname{tr}(\Pi_{ASD}\mathcal D_u[H])\big)=2a\big(0-H_{22}-H_{33}\big)=-2a(H_{22}+H_{33}),$$
which is **[Lemma L135](../findings/route-a.md)(c)'s and [Lemma L17](../findings/route-a.md)'s smooth branch, to the sign and the factor**. The $(\hat\omega_1,\hat\omega_1)$ multiplier $0$ and the $\hat\omega_{2,3}$ multiplier $-1$ are exactly what produce it, and the ASD trace vanishes because $\mathcal D_u[H]$ has no $K\times K$ part. *This is the check the brief asks for: it discriminates the multiplier values, the sign convention and the $K\times K$ exclusion simultaneously, and it passes.*

### 4. The blockwise assembly, CONFIRMED

Entrywise on $E\times E$ and $E\times K$: $\lvert m+\tfrac12\rvert\le\tfrac12$, so $\lvert(Z+\tfrac12H)_{ij}\rvert\le\tfrac12\lvert H_{ij}\rvert$. Explicitly, $Z+\tfrac12H$ has $\tfrac12H_{11}$, $\tfrac16H_{1j}$, $-\tfrac12H_{jk}$ ($j,k\in\{2,3\}$), $\tfrac12c_1$, $-\tfrac12c_2$, $-\tfrac12c_3$, the $(1,2),(1,3)$ entries are a factor $3$ inside the bound, so $E\times E$ carries genuine slack. On $K\times K$ the statement is **blockwise, not entrywise**, and correctly so: $D_-+\tfrac12D=\tfrac12\lvert D\rvert$ and $\lVert\,\lvert D\rvert\,\rVert_F=\lVert D\rVert_F$ because $\lvert D\rvert$'s eigenvalues are $\lvert d_i\rvert$, but $\lvert D\rvert$'s individual *entries* need not be dominated by $D$'s, so the entrywise reading would be false there. The lemma treats it blockwise; only the plan.md and ATTEMPTS.md digests blur the two.

Frobenius bookkeeping: $\lVert X\rVert^2=\lVert X_{EE}\rVert^2+2\lVert X_{EK}\rVert^2+\lVert X_{KK}\rVert^2$ on both sides, so the off-diagonal factor $2$ cancels and the per-block bounds sum. $Z$ is symmetric because $f^{[1]}$ is. Hence $\lVert Z+\tfrac12H\rVert\le\tfrac12\lVert H\rVert$ and $\lVert g_1\rVert^2\le\tfrac14$. **CONFIRMED.**

### 5. A second, shorter proof, which is the strongest evidence the lemma is right

$W_-+\tfrac12W=\tfrac12\lvert W\rvert$ identically. Both $u$ and $H$ are Weyl, so $\mathrm{Alt}(u+tH)=0$ for every $t$, and therefore
$$g(t)=\mathrm{Alt}\big(W(t)_-\big)=\tfrac12\,\mathrm{Alt}\big(\lvert W(t)\rvert\big),\qquad g_1=\tfrac12\,\mathrm{Alt}(Y_1),$$
$Y_1$ being the first-order coefficient of $\lvert u+tH\rvert$. Its multipliers are the divided differences of $\lvert x\rvert$, $1,\ \tfrac13,\ -1,\ 1,\ -1$, **all of modulus $\le1$ because $\lvert\cdot\rvert$ is $1$-Lipschitz**, and its $K\times K$ block is $\lvert D\rvert$, of equal norm to $D$. So $\lVert Y_1\rVert\le\lVert H\rVert=1$ and $\lVert g_1\rVert\le\tfrac12$. **This is $\mu=\tfrac12$ with the recentring done in advance, and it makes plain what the lemma actually is**: the record's own proof of $\delta^2\le\tfrac14$ (via $\delta^2=\tfrac12\langle\mathrm{Alt}(W_-),\lvert W\rvert\rangle$, [ATTEMPTS.md](../ATTEMPTS.md) Result 7's by-products), differentiated. That is a recommendation, not a criticism, but it should be said, because it tells a successor the constant $\tfrac14$ is the same constant, not a coincidence.

### 6. Convention-immunity, CONFIRMED

In $W_-=\tfrac12(W-\lvert W\rvert)$: $f\equiv0$ on $[0,\infty)$, $f(x)=x$ on $(-\infty,0)$; multipliers $0,\ \tfrac13,\ 1,\ 0,\ 1$, all in $[0,1]$; $Z_{KK}=\tfrac12(D-\lvert D\rvert)$ and $Z_{KK}-\tfrac12H_{KK}=-\tfrac12\lvert D\rvert$ of norm $\tfrac12\lVert D\rVert$. $\mu=-\tfrac12$ gives $\lvert m-\tfrac12\rvert\le\tfrac12$ and the identical conclusion. **The claim is exactly right and the reason is exactly the one stated**, the multiplier range has length $1$ in both conventions and the estimate is its half-length. Root cause (i) of the earlier refutation cannot reach this lemma.

**Root cause (ii) cannot reach it either.** The refuted chain traced $W_-(t)$ against the *fixed* projector $\Pi_E$ at *second* order, where the eigenvectors' tilt out of $E$ contributes and was dropped. L140 works with the full first-order matrix $Z$, pairs it against no projector, and the eigenvector tilt is precisely the $E\times K$ block it does carry. The lemma's immunity claim is justified.

### 7. Downstream arithmetic, CONFIRMED

*Screen, seconds:* $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ is increasing (derivative of $\theta_0^2$ is $2(3n-4)/n^3>0$) with limit $\sqrt2$, so $\lvert\kappa_n\rvert=9(\theta_0(n)-\theta^*)$ increases to $9(\sqrt2-\sqrt{3/2})=1.7052182$ and the threshold $\theta^*/(2\lvert\kappa_n\rvert)$ **decreases** to $0.3591168$: $6.028$ at $n=12$, $2.710$ at $n=13$, $0.8205$ at $n=20$, $0.4630$ at $n=50$, $0.3632$ at $n=1000$. So $\theta^*/(2\lvert\kappa_n\rvert)\ge0.3591$ for every $n\ge12$, and $\tfrac5{36}=0.13889<0.3591$ with room. $\tfrac19+\tfrac5{36}=\tfrac9{36}=\tfrac14$, and the binding requirement $\Delta_2\le0.4702$ is cleared by $\tfrac14$ at a factor $1.88$. $\lvert\kappa_{12}\rvert=0.101594$ matches the record's $0.10159$. **All arithmetic checks.**

$c_2=\Delta_2-\tfrac19$ is [Lemma L135](../findings/route-a.md)(a), which I re-derived from $2$-homogeneity alone: $\delta^2(u+tH)=(1+t^2)\delta^2(\cos\tau u+\sin\tau H)$ with $\tan\tau=t$, $\tau=t+O(t^3)$, matching $t^2$ coefficients gives $\Delta_2=c_2+\delta^2(u)$. **Sound, and it uses no perturbation theory at all.**

### 8. Vacuity

**Not vacuous, on three counts.** The set $\{F=0\}\cap T_u\mathcal O^\perp$ is non-empty and large, it contains the zero-padded flat ($300$ dimensions at $n=12$) and the mixed/vector isotype [r426](REVIEW_r426.md) supplied. The bound is a strict improvement: the previously available estimate was $\lVert g_1\rVert^2\le1$ by Moreau nonexpansiveness, and the requirement is $\le0.4702$, so $\tfrac14$ moves the claim from failing to clearing. And the constant is not attained by inflation, on the vector isotype $\lVert Z+\tfrac12H\rVert^2=\tfrac14\lVert H\rVert^2$ exactly, so the only slack left is $\mathrm{Alt}$'s.

## Corrections

**(C1) The headline overstates, and inherits three obligations it does not name.** "**so [I3](../plan.md) holds for every $n\ge12$**" is set in bold display; the qualification "granting the remainder step [Lemma L134](../findings/route-a.md) still owes" follows it in the same sentence, and the paragraph "What it does not do" repeats it, but the plan.md digest and [INDEX-results.md](../findings/INDEX-results.md) row 140 carry the unqualified form forward. What is actually proved is a **per-direction second-order** statement, and it stands on:

| obligation | status | where |
| --- | --- | --- |
| the remainder step, a neighbourhood statement needs uniform-in-$H$ third-order control, and $\delta^2$ has no third derivative at $u$ | **owed**, acknowledged | [Lemma L134](../findings/route-a.md) |
| $\Delta_2\le\lVert g_1\rVert^2$ on $\{F=0\}\cap T_u\mathcal O^\perp$ | **Gate 2 owed**, and it is the replacement for a lemma refuted the same day | [Lemma L136](../findings/route-a.md) |
| $\langle L_eH,H\rangle\le\tfrac13$ off the orbit at every $n$, resting on the four blocks exhausting the nonzero eigenvalues, tabulated at $n=10,12,14$ and asserted stable beyond | **external input**, flagged in L134 but not in L140 | [Lemma L134](../findings/route-a.md)(a) |

**The honest statement is:** *on $\{F=0\}\cap T_u\mathcal O^\perp$ the second-order coefficient satisfies $c_2\le\tfrac5{36}$, so the penalised functional's second-order term is strictly negative at every $n\ge12$, conditional on [Lemma L136](../findings/route-a.md) and on [Lemma L134](../findings/route-a.md)(a)'s spectral-stability input, and the tube of explicit radius still needs the remainder.* **The $\lVert g_1\rVert^2\le\tfrac14$ half needs none of the three and should be stated separately from the conclusion that consumes them.**

**(C2) State that $\mathcal D_u[H]$ is zero on $K\times K$, and that the table is row-wise rather than entry-wise.** As written, a reader who takes $\mathcal D_u[H]$ to be a full Daleckii–Krein matrix double-counts the $K\times K$ block against $D_-$. And the table's five columns are not five scalars attached to five entries but two block-constant rows ($E\times K$) plus a block-constant $2\times2$ ($\hat\omega_{2,3}$), which is what makes the estimate independent of the eigenbasis chosen inside $K$ and inside $u$'s degenerate eigenspace. Both facts are true; neither is said, and both are load-bearing.

**(C3) Say why $Z_{KK}=D_-$ is exact.** The lemma writes "the exact value is $Z_{KK}=D_-$" with no argument, in a file that two paragraphs earlier records that the derivative of $N\mapsto N_-$ at $D$ **exists nowhere on the cone**. The reconciliation is one sentence, *degree-one homogeneity plus $1$-Lipschitz continuity of $N\mapsto N_-$ gives $t(D-tS)_-=tD_-+O(t^2)$, so the Schur correction never touches the $t$-coefficient and no derivative is needed*, and without it the claim reads as exactly the kind of assertion that produced [Lemma L137](../findings/route-a.md).

**(C4) "It uses no perturbation theory" is true of the estimate and false of the object.** The bound $\lVert\mathrm{Alt}(Z)\rVert\le\tfrac12$ given $Z$ is perturbation-free. The *identification* of $Z$ (the multiplier table plus the $D_-$ block), is a perturbation-theoretic input imported from [Lemma L135](../findings/route-a.md)(c). That is how the previous chain died: a correct estimate of a mis-identified object. I verified $Z$ independently and it is right, so this is a presentation defect rather than a mathematical one, but the sentence should read *"no perturbation theory beyond L135(c)'s identification of $Z$, which is restated and re-derived here."*

## Two record defects found in passing, outside the lemma

- **[Lemma L139](../findings/route-a.md)'s withdrawal note is stale.** It still says "What survives is stated in the corrected [Lemma L136](../findings/route-a.md): $\mathrm{Alt}(P_0HP_0)=0$ on the equality cone", but L136 now carries that fact under "**a second is WITHDRAWN**", with the reason (a $4$-set with two indices inside the distinguished $\mathbb R^4$ and two outside does reach $\mathrm{Alt}$). One paragraph asserts what the other retracts. **Nothing downstream turns on it** (L140 uses only $\mathrm{Alt}(H)=0$) but the record contradicts itself in two adjacent blocks.
- **[Lemma L141](../findings/second-order.md)(a)'s hypothesis excludes the case its own commentary claims.** (a) is stated for "$V$ whose spectral parts are differentiable at it", and the following paragraph says it "holds at the competitor, where the spectrum is degenerate, exactly as at the balanced product". At a degenerate base point the multiplier at $(K,K)$ does not exist and the $D_-+\tfrac12D=\tfrac12\lvert D\rvert$ step (which is L140's, and which (a)'s three-line proof omits), is what covers it. **The fix is to import that step into (a)**, after which the hypothesis can be dropped and the commentary becomes true. Since [plan.md](../plan.md) records L141 as the general form of the estimate that closed I3, and I2(iii)'s constant $c_n=2.464\,\theta_0(n)/(n-2)$ stands on $\sigma\le\tfrac14$, this is worth repairing before it spreads further.

## What would break it, for a successor

The lemma is now a two-line argument over a well-identified object, so the only live attack surfaces are upstream:

1. **$\Delta_2\le\lVert g_1\rVert^2$**, [Lemma L136](../findings/route-a.md), unreviewed, replacing a refuted predecessor, and the one place the fixed-projector trace still appears (in $\operatorname{tr}(\Pi_EX_2)$ and $\operatorname{tr}(\Pi_AX_2)$). **That is where the next Gate 2 belongs, not here.**
2. **Whether $\Delta_2$ exists as a one-sided second-order coefficient at all** on the cone, given that $\mathcal E_D$ does not exist there. I believe it does, eigenvalues of the analytic family $D-tS$ are analytic, so $g(t)$ has a one-sided Taylor expansion at $0^+$, but [Lemma L135](../findings/route-a.md)(c) writes $\Delta_2=\lVert g_1\rVert^2+2\langle g_0,g_2\rangle$ as if $g_2$ were a plain second derivative, and that sentence is doing work it has not earned.
3. **The remainder**, which is the whole gap between "the second-order term is negative in every direction" and "I3".
