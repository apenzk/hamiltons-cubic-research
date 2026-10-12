# REVIEW_r573, Lemma L105 (independent adversarial audit)

**Reviewer** r573. **Target**: [Lemma L105, every two-eigenvalue critical point has $\theta\le\theta_0(n)$, from $T\ge0$ alone](../findings/bounds-relaxations.md), block at [bounds-relaxations.md:333–350](../findings/bounds-relaxations.md), under the section preamble at [bounds-relaxations.md:312](../findings/bounds-relaxations.md) which carries the Gate 2 attribution to [r341](REVIEW_r341.md) and [r342](REVIEW_r342.md).

**Footing.** Analysis only. Everything below is hand arithmetic on objects I constructed for the purpose; no sweep, search or census was run, and nothing here rests on numerics. I did not read the co-reviewer's report or log.

**Overall verdict: CONFIRMED as to the mathematics, REFUTED in three of the block's surrounding claims.** The lemma statement is true, the proof reproduces line for line, and the block is *understated* in its hypotheses. Three claims wrapped around it are false, one of them propagated into [ATTEMPTS.md](../ATTEMPTS.md) and one into [INDEX-results.md](../findings/INDEX-results.md).

---

## 0. What the block leans on that is still undefined

Read against [conventions.md](../findings/conventions.md), which now tables $\Pi$ (four objects), $d$ (three senses) and hollow (matrix and $3$-tensor):

| symbol in the block | status |
| --- | --- |
| $t_{ijk}$, "admissible class-multiset", $G$ | defined in [Lemma L104](../findings/bounds-relaxations.md) one heading above, quoted correctly |
| $\Pi(\lambda)$, "the $\Pi$-bound" | **two different objects one paragraph apart.** $\Pi(\lambda)$ is [conventions.md](../findings/conventions.md) sense (iv); "the $\Pi$-bound" $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ is named for sense (ii)/(iii)'s scalar. Both appear inside the block with no marker |
| $E_+$, $E_{\max}$, $E_{\min}$ | **$E_+$ has no row in [conventions.md](../findings/conventions.md)**, which tables $\mathfrak h=E_{\max}$ and $\mathfrak m=E_{\min}$ only. Elsewhere on the record ([nondegeneracy.md](../findings/nondegeneracy.md), [post F40](../findings/fence-posts.md)) $E_+$ is the strictly positive eigenspace, which coincides with $E_{\max}$ here because a two-eigenvalue traceless $W$ has trivial kernel, the block says so itself, and that is why the two letters may be used interchangeably inside it and nowhere else |
| $\psi$, "the polarisation" | used without definition. It is the polar form of $\varphi$: for $\varphi(x)=x^2-bx+c$, $\psi(x,y)=xy-\tfrac b2(x+y)+c$. The factor $\tfrac12$ is what makes $\psi(u,-w)=-\tfrac12(u+w)^2$ come out, and a reader who takes the naive $xy-b(x+y)+c$ gets a different number |
| $\theta_0(n)$, $N$, hollow, unit norm | tabled, and the block's usage matches |

*The $\Pi$ collision is the live one*: the block's own preamble at line 331 says "at $d=2$ it is inert, which is why Lemma L105 does not need it" of the **pair cap**, while three lines later "$\Pi$-bound" means the $\lambda_{\min}$ bound. Nothing in the block says which $\Pi$ is meant where.

---

## 1. The claim, rebuilt cold, CONFIRMED

I re-derived the reduced system from (A), (B), (C) of [bounds.md:235](../findings/bounds.md) without reading L104's derivation, then the two branches.

**Set-up.** Classes $1$ (value $u$, multiplicity $r$) and $2$ (value $-w$, multiplicity $s:=N-r$), $N=\binom n2$. For a row $a$ in class $i$ put $\mu_j=m_j-\delta_{ij}$. Since $T$ is hollow as a $3$-tensor, the ordered pairs $(\beta,\gamma)$ in (A)/(B)/(C) run over distinct indices $\ne a$, of which class $j$ supplies $\mu_j$, a count independent of which $a$ in the class was chosen. Averaging each relation over the rows of a class therefore gives the reduced system for $\bar t_{ijk}$ = the orbit average of $T$, and $\bar t\ge0$. **This route needs no appeal to L104's $G$-averaging of an LP maximiser**; it applies to the critical point's own $T$ directly.

**Class-1 rows** ($\mu_1=r-1$, $\mu_2=s$):

$$(r-1)(r-2)t_{111}+2(r-1)s\,t_{112}+s(s-1)t_{122}=2(n-2)$$
$$(r-1)(r-2)u\,t_{111}+(r-1)s(u-w)t_{112}-s(s-1)w\,t_{122}=-2u$$
$$(r-1)(r-2)u^2t_{111}-2(r-1)s\,uw\,t_{112}+s(s-1)w^2t_{122}=2u(\theta-u)$$

**Class-2 rows** ($\mu_1=r$, $\mu_2=s-1$):

$$r(r-1)t_{112}+2r(s-1)t_{122}+(s-1)(s-2)t_{222}=2(n-2)$$
$$r(r-1)u\,t_{112}+r(s-1)(u-w)t_{122}-(s-1)(s-2)w\,t_{222}=2w$$
$$r(r-1)u^2t_{112}-2r(s-1)uw\,t_{122}+(s-1)(s-2)w^2t_{222}=-2w(\theta+w)$$

**Four multiplier combinations, one per variable.** A quadratic $\varphi(x)=x^2-bx+c$ applied as $(\mathrm C_i)-b(\mathrm B_i)+c(\mathrm A_i)$ gives the coefficient $\mu_j(\mu_j-1)\varphi(\nu_j)$ on $t_{ijj}$ and $2\mu_1\mu_2\psi(u,-w)$ on the mixed type, with $\psi$ the polar form.

| target | rows | $\varphi$ | identity obtained |
| --- | --- | --- | --- |
| $t_{112}$ | class 1 | $(x-u)(x+w)$ | $-(r-1)s\,(u+w)^2t_{112}=2u\theta-2(n-1)uw$ |
| $t_{222}$ | class 2 | $(x-u)^2$ | $(s-1)(s-2)(u+w)^2t_{222}=2(n-2)u^2-4uw-2w^2-2w\theta$ |
| $t_{111}$ | class 1 | $(x+w)^2$ | $(r-1)(r-2)(u+w)^2t_{111}=2u\theta-2u^2-4uw+2(n-2)w^2$ |
| $t_{122}$ | class 1 | $(x-u)^2$ | $s(s-1)(u+w)^2t_{122}=2u\theta+2(n-1)u^2$ |

**The first two reproduce the block's two displays character for character**, including the $-(r-1)(N-r)$ sign and the $(N-r-1)(N-r-2)$ coefficient. With $u,w>0$:

- $t_{112}\ge0\iff\theta\le(n-1)w$, the $\Pi$-bound;
- $t_{222}\ge0\iff\theta\le[(n-2)u^2-2uw-w^2]/w$, the tangent bound;
- $t_{111}\ge0\iff\theta\ge[u^2+2uw-(n-2)w^2]/u$ and $t_{122}\ge0\iff\theta\ge-(n-1)u$, **both lower bounds**, the block's "never bind above" is CONFIRMED, and the reason is visible: the $\theta$-coefficient is $+2u$ in both.

The four identities are linearly independent in $(t_{111},t_{112},t_{122},t_{222},\theta)$, so the feasible set is contained in a line on which $\theta$ is a coordinate. **The upper bound therefore does not depend on L104's rank claim at all**, only on these four combinations.

**Normalisation, CONFIRMED.** $ru=sw$ (centring $\sum_im_i\nu_i=0$) with $ru^2+sw^2=1$ gives $ru\delta=sw\delta=1$ for $\delta=u+w$, hence $\delta^2=N/(r(N-r))$, $w=\sqrt{r/(N(N-r))}$, $u=\rho^{1/2}/\sqrt N$, $w=\rho^{-1/2}/\sqrt N$ with $\rho=u/w=(N-r)/r$. All as printed.

**Two independent numerical anchors, both reproduced exactly by hand.**

- The $t_{111}$ identity at $n=6$, $r=6$, $s=9$ gives the segment's lower endpoint $\theta=w(\rho^2+2\rho-4)/\rho=0.175682\ldots=\sqrt{10}/18$, **which is [r334](REVIEW_r334.md)'s recorded interval endpoint** that the block quotes three paragraphs later.
- The $t_{122}$ identity at [L104](../findings/bounds-relaxations.md)'s $n=8$, multiplicities $(26,2)$ witness: there $s=2$ forces $\theta=[(n-2)u^2-2uw-w^2]/w=-189u/13$, and then $t_{122}=(2u\theta+14u^2)/(2(u+w)^2)=-\tfrac1{26}$, **the exact figure L104 records**, reached here from my own identities.

---

## 2. The crossing and the parity claim, CONFIRMED

In $\sigma:=\rho^{1/2}$, $B_1=\dfrac{n-1}{\sqrt N\,\sigma}$ and $B_2=\dfrac1{\sqrt N}\big[(n-2)\sigma^3-2\sigma-\sigma^{-1}\big]$.

- $B_1$ is strictly decreasing in $\sigma$ (strictly increasing in $r$).
- $\dfrac{d}{d\sigma}\big[(n-2)\sigma^3-2\sigma-\sigma^{-1}\big]=3(n-2)\sigma^2-2+\sigma^{-2}\ge2\sqrt{3(n-2)}-2>0$ for every $n\ge3$, so $B_2$ is strictly increasing in $\sigma$ (strictly decreasing in $r$).

Hence $B_1-B_2$ is strictly decreasing, the crossing is **unique**, and $\min\{B_1,B_2\}$ is maximised there. Crossing: $(n-2)\rho^2-2\rho-1=n-1$, i.e. $(n-2)\rho^2-2\rho-n=0$; at $\rho=\tfrac n{n-2}$ this reads $\tfrac{n^2}{n-2}-\tfrac{2n}{n-2}-n=\tfrac{n(n-2)}{n-2}-n=0$, **the brief's item (2) identity CONFIRMED**. Then $r=N(n-2)/(2n-2)=n(n-2)/4$, $N-r=n^2/4$, $w=\tfrac1n\sqrt{2(n-2)/(n-1)}$ and $\theta=(n-1)w=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$. All as printed.

**Parity, CONFIRMED.** $n$ odd makes $n(n-2)$ a product of two odd numbers, hence odd, so $n(n-2)/4\notin\mathbb Z$ and no integer $r$ attains the crossing; strict monotonicity on each side then gives $\min\{B_1,B_2\}<\theta_0(n)$ strictly. For $n=2k$ even, $n(n-2)/4=k(k-1)\in\mathbb Z$.

**Warning `W5` checked, no conflict.** At odd $n$ the block's strict bound sits below $\theta_0(n)$, and the *attained* diagonal value is $\Theta_n=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$, which is also strictly below: $n^2(n-3)=(n-2)^2(n+1)-4<(n-2)^2(n+1)$. So the block's strictness and $\Theta_n$ are consistent, and neither is being read as the global maximum $M(n)$. *One consistency question I could not settle without computation and therefore leave open rather than assert either way: at $n=5$ the block's bound over integer $r\in[3,N-3]$ peaks at $r=3$ with $\min\{B_1,B_2\}=0.828184$, which is below $\Theta_5=0.942809$; that is a contradiction only if the $n=5$ diagonal maximiser has exactly two eigenvalues with both multiplicities $\ge3$, and the record does not say whether it does. An unbalanced sphere product $S^p\times S^q$, $p\ne q$, carries **three** eigenvalues and is outside the stratum, which is the reading that makes the two agree.*

---

## 3. DEFECT 1, "no hypothesis that $E_+$ is closed under bracket" is REFUTED

**The block says**: *"Branch two **is** [Lemma L23](../results.md)'s dimension cap $r\le n(n-2)/4$, and it comes out of $t_{222}\ge0$ (out of $T\ge0$), with no sum of squares, no Lie theory and no hypothesis that $E_+$ is closed under bracket."*

**Branch two alone does not give the dimension cap.** $t_{222}\ge0$ is an *upper* bound on $\theta$; a cap on $r$ needs a *lower* bound on $\theta$ to bite against. The strongest consequence available with no further input is $\theta>0\Rightarrow B_2>0$, i.e. $(n-2)\rho^2-2\rho-1>0$, i.e.

$$\rho>\frac{1+\sqrt{n-1}}{n-2},\qquad\text{hence}\qquad r<\frac{n(n-2)}4\cdot\frac{2\sqrt{n-1}}{\sqrt{n-1}+1}.$$

The correction factor $2\sqrt{n-1}/(\sqrt{n-1}+1)$ exceeds $1$ at every $n\ge3$ and tends to $2$, so this is **strictly weaker than the cap at every $n\ge5$**. At $n=6$ it gives $r\le8$ against the cap's $r\le6$; at $n=12$, $r\le42$ against $30$.

**What does give the cap is exactly the subalgebra hypothesis.** Impose $t_{112}=0$ (which the block's own closing paragraph reads as "$E_{\max}$ is a subalgebra") so $\theta=(n-1)w$, and feed that into branch two:

$$(n-1)w^2\le(n-2)u^2-2uw-w^2\iff(n-2)\rho^2-2\rho-n\ge0\iff\rho\ge\frac n{n-2}\iff r\le\frac{n(n-2)}4 .$$

So the clause deleted is the one the derivation uses.

**Triple-checked, and the third check is decisive.** Evaluating my $t_{222}$ identity at $\theta=(n-1)w$ on the subalgebra family ($u=cs/N$, $w=cr/N$, $u+w=c$) gives

$$S_{\mathfrak{mmm}}=s(s-1)(s-2)t_{222}=\frac{2s}{N^2}\big[(n-2)s^2-2rs-nr^2\big]=\frac{2s}{N^2}\big[(n-2)N^2-2(n-1)Nr\big]=(N-r)\Big[2(n-2)-\frac{4(n-1)r}N\Big],$$

the $r^2$ terms cancelling identically. **That is [Lemma L23](../results.md)'s closed form for $S_{\mathfrak{mmm}}$, verbatim.** So branch two at $t_{112}=0$ is not merely equivalent to L23's step, it *is* L23's step, the same scalar.

**And that refutes "no sum of squares" too.** $S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2=\sum_{\mathfrak m^3}T_{abc}=(N-r)(N-r-1)(N-r-2)\,t_{222}$. L23's "sum of squares" and the block's "$T\ge0$" are the **same** nonnegativity of the **same** sum of squares, since $T_{abc}=c_{abc}^2$ by [conventions.md](../findings/conventions.md). "No Lie theory" is loose in the same direction ((A) is the Killing marginal and $T$ is built from structure constants) though it is fair if it is read as "no classification of subalgebras or symmetric pairs", which is where L23's *equality* case does spend Lie theory (triality at $n=8$).

**What is genuinely new, and it is worth stating in the positive.** L105 obtains $t_{222}$ *from* (A), (B), (C) rather than from a subalgebra's explicit structure, and therefore proves the **value** bound $\theta\le\theta_0(n)$ on the whole two-eigenvalue stratum, where L23 proved it only on the subalgebra family. It does **not** prove the *dimension* statement $r\le n(n-2)/4$ there, and that statement is not a consequence of the lemma: at $n=6$, $r=7$ the bound reads $\theta\le0.468$, a positive number, so nothing in L105 excludes $r>n(n-2)/4$.

**Proposed repair**, replacing the sentence at [bounds-relaxations.md:343](../findings/bounds-relaxations.md):

> **What this supplies that [Lemma L23](../results.md) needed a subalgebra for.** L23 caps $\theta$ at $\theta_0(n)$ on the subalgebra family, through the dimension cap $r\le n(n-2)/4$; branch two gives the same value bound on the whole two-eigenvalue stratum. The two are the same scalar read under different hypotheses: $S_{\mathfrak{mmm}}=(N-r)(N-r-1)(N-r-2)t_{222}$, and evaluating the $t_{222}$ identity at $\theta=(n-1)w$ returns L23's closed form $(N-r)[2(n-2)-4(n-1)r/N]$ exactly. What branch two adds is that the value of $t_{222}$ follows from (A), (B), (C) at the class-$2$ rows, with no subalgebra structure to read it off. What it does **not** give is the dimension cap: recovering $r\le n(n-2)/4$ needs $\theta=(n-1)w$, i.e. $t_{112}=0$, i.e. $E_{\max}$ closed under bracket. Both the unit norm and the centring $\sum_im_i\nu_i=0$ are load-bearing, the centring turns $\rho\ge n/(n-2)$ into a statement about $r$, and the unit norm fixes the crossing value at $\theta_0(n)$.

**Propagation.** The same false clause stands at [ATTEMPTS.md:2774](../ATTEMPTS.md): *"the second is [Lemma L23](../results.md)'s dimension cap $r\le n(n-2)/4$ obtained from $T\ge0$ alone"*. [LEDGER.md:1405](../findings/LEDGER.md) already carries the clause as "under audit"; this audit closes it as false.

---

## 4. DEFECT 2, the "what it does not need" list omits unit norm and the centring. CONFIRMED, the predicted omission is present

Splitting the block by what each step consumes:

| step | consumes |
| --- | --- |
| the four $t$-identities and $\theta\le\min\{B_1,B_2\}$ in $(u,w)$ | (A), (B), (C) at two rows; $T\ge0$; hollowness. **No norm, no centring** |
| $\rho=(N-r)/r$, hence anything phrased in $r$ | **the centring $\sum_im_i\nu_i=0$** |
| $w=\sqrt{r/(N(N-r))}$ and the crossing value $\theta_0(n)$ | **the centring and the unit norm together** |

So both omissions the brief predicted from [L70](../findings/bounds.md), [L35](../findings/stratum-two-negative.md) and [L104](../findings/bounds-relaxations.md) recur here. **The lemma's own statement is clean**, it says "of unit norm" explicitly, and tracelessness is a property of $\mathcal W_n$ that the proof names, so the omission is confined to the "does not need" list, which is where the record has been reading these claims from.

---

## 5. DEFECT 3, "Same conclusion on the same stratum" as Theorem A is REFUTED in both halves. The *independence* claim is CONFIRMED

**Independence, CONFIRMED.** My rebuild of the block used (A), (B), (C), $T\ge0$, hollowness, the centring, the unit norm and the class averaging. Neither [Lemma L70](../findings/bounds.md) nor [Lemma L71](../findings/bounds.md) enters at any step, and neither is needed to state or prove anything the lemma box asserts.

**"Same conclusion", false, weaker at equality.** [Theorem A](DERIVE-t11.md)'s equality case is *"$W$ is the Weyl tensor of $S^{n/2}\times S^{n/2}$"*, and it gets there through L71. L105 pins the **spectrum** ($\rho=n/(n-2)$, $r=n(n-2)/4$) and stops. The lemma box says so correctly ("the balanced sphere product's spectrum"), but the comparison sentence, and **[INDEX-results.md:120](../findings/INDEX-results.md)'s row (*"equality only at the balanced product"*), do not.** The index row overstates the lemma.

**"Same conclusion", false, stronger as an inequality.** Theorem A's second branch is L70's $\theta\le w[(n-2)\rho-1]$; L105's is $\theta\le w[(n-2)\rho^2-2\rho-1]$. Their difference is

$$w\big[(n-2)\rho^2-2\rho-1\big]-w\big[(n-2)\rho-1\big]=w\rho\big[(n-2)\rho-n\big],$$

**negative exactly below the crossing.** So L105's branch two is strictly sharper than L70 on $\rho<n/(n-2)$ and both bounds are dominated by the $\Pi$-bound above it; at $n=6$, $\rho=1.2$, L105 gives $\theta\le0.5563$ against Theorem A's $0.8957$. The mechanism for the gain is visible: L70's row step uses only (C) against a support bound $\lambda_b\lambda_c\ge\lambda_{\min}\lambda_{\max}$, while $t_{222}\ge0$ couples (A), (B) and (C) at the same row, [r337](REVIEW_r337.md)'s two-dimensional hull rather than one of its projections.

**"Same stratum", false as stated, and the block is the one that loses.** Theorem A hypothesises two values and nothing else; L105 adds both multiplicities $\ge3$. See §6: the extra hypothesis is removable, so the two strata can be made equal, but they are not equal as the two statements now read.

**Proposed repair** for [bounds-relaxations.md:345](../findings/bounds-relaxations.md): *"A sharper bound on the same stratum, reached without [Lemma L70](bounds.md) or [Lemma L71](bounds.md). Branch two is strictly stronger than L70 below the balanced ratio, by $w\rho[n-(n-2)\rho]$, and the two branches coincide with Theorem A's at the crossing. What Theorem A carries and this does not is the equality case as a statement about $W$ rather than about its spectrum: that identification is L71's and is not reproved here."*

---

## 6. STRENGTHENING, "both multiplicities at least $3$" is not needed for the displayed inequality

The block's route needs it, because a multiplicity-$2$ class collapses the feasible set to a point ([L104](../findings/bounds-relaxations.md)) and "the first nonnegativity constraint binds" has nothing to bind on. The four identities do not need it, because the degenerate coefficient sits on the *left*:

- $r=1$: the $t_{112}$ coefficient $(r-1)s$ vanishes and the identity forces $\theta=(n-1)w$, branch one, with equality.
- $r=2$: type $\{1,1,2\}$ is admissible ($m_1\ge2$) and the coefficient $(r-1)s=s\ne0$, so branch one holds as an inequality.
- $s\in\{1,2\}$: the $t_{222}$ coefficient $(s-1)(s-2)$ vanishes and the identity forces $\theta=[(n-2)u^2-2uw-w^2]/w$, branch two, with equality.

In every case $\theta\le\min\{B_1,B_2\}$, so **the lemma is true with the hypothesis "both multiplicities at least $3$" struck**, and the equality analysis is unchanged. This matters because [ATTEMPTS.md:2774](../ATTEMPTS.md) already cites the lemma for *"the whole two-eigenvalue stratum at every $n\ge5$, with no subalgebra, graded or saturation hypothesis"*, a use that steps outside the recorded hypotheses and is nevertheless sound. Recording the lemma without the multiplicity hypothesis brings the statement up to what the record is already using.

**$n\ge5$ is likewise unused by the proof.** Every identity holds at every $n$, and the strict monotonicity of $B_2$ needs only $3(n-2)>1$. The hypothesis is inherited from Conjecture A ($\theta_0(4)<M(4)=\sqrt{3/2}$, so $\theta_0$ is not the target at $n=4$) rather than from this argument. Worth a line, since a reader will look for where $n\ge5$ binds and find nothing.

---

## 7. Brief item (1b), the new $u/w\le n-2$ fact. Re-derived, respected, and it sharpens nothing here

I obtained the fact independently before checking L104's phrasing. Feasibility needs the $t_{111}$ lower bound below the $t_{112}$ upper bound:

$$\frac{u^2+2uw-(n-2)w^2}u\le(n-1)w\iff\rho^2-(n-3)\rho-(n-2)\le0\iff(\rho-(n-2))(\rho+1)\le0\iff\rho\le n-2,$$

the discriminant being the perfect square $(n-1)^2$. Since $\rho=(N-r)/r$, this is $r\ge N/(n-1)=n/2$, **[L104](../findings/bounds-relaxations.md)'s new fact CONFIRMED, and its source named: it is $t_{111}\ge0$ against $t_{112}\ge0$, not a separate input.**

**It neither sharpens a branch nor moves the crossing.** The crossing sits at $\rho=n/(n-2)$, and $n/(n-2)\le n-2\iff(n-1)(n-4)\ge0$, true at every $n\ge4$, so the maximising ratio is admissible and $\theta_0(n)$ stands. What the fact removes is the small-$r$ end of the segment, where branch one is already far below $\theta_0(n)$. It is a feasibility statement, and the block is correct not to use it.

---

## 8. Brief item (4), anchors. Both same-file anchors in the block are broken

| anchor as written | resolves? |
| --- | --- |
| `[Lemma L70](../findings/LEDGER.md#lemma-l70-the-deficiency-identity-and-what-saturates-it)` | **NO.** The slug is correct for the heading at [bounds.md:185](../findings/bounds.md), but the link is same-file and the block is in [bounds-relaxations.md](../findings/bounds-relaxations.md). Fix: `bounds.md#lemma-l70--the-deficiency-identity-and-what-saturates-it` |
| `[Lemma L71](../findings/bounds.md#lemma-l71-saturation-forces-the-balanced-sphere-product-with-no-two-eigenvalue-hypothesis)` | **NO.** Same fault; the heading is at [bounds.md:450](../findings/bounds.md). Fix: prefix `bounds.md` |
| `[Lemma L23](../results.md)`, `[Theorem A](DERIVE-t11.md)`, `[graded-half.md](../findings/graded-half.md)`, `[post F40](../findings/fence-posts.md)`, `[I15](../plan.md)`, `[r334](REVIEW_r334.md)` | all resolve; every target file exists and carries the named content |

*Adjacent, two paragraphs below the block*: [bounds-relaxations.md:364](../findings/bounds-relaxations.md) writes `[Lemma L105](#)`, an empty anchor pointing at the top of the page. It should be `#lemma-l105--every-two-eigenvalue-critical-point-has-thetaletheta_0n-from-tge0-alone`.

---

## 9. Consumers checked

$62$ mentions of the identifier across $26$ files. Grepping the *statement* rather than the identifier, the uses that could step outside the hypotheses:

| site | use | inside hypotheses? |
| --- | --- | --- |
| [ATTEMPTS.md:2774](../ATTEMPTS.md) | "closes Conjecture A on the whole two-eigenvalue stratum at every $n\ge5$" | **drops the multiplicity hypothesis.** True by §6, unsupported by the recorded statement |
| [ATTEMPTS.md:2774](../ATTEMPTS.md) | "the second is L23's dimension cap obtained from $T\ge0$ alone" | **no**, same defect as §3 |
| [INDEX-results.md:120](../findings/INDEX-results.md) | "equality only at the balanced product" | **no**, the lemma pins the spectrum, not the point (§5) |
| [DERIVE-sp3.md](DERIVE-sp3.md), [DERIVE-sp3c.md](DERIVE-sp3c.md), [DERIVE-sp3d.md](DERIVE-sp3d.md) | "$d=2$: feasible dimension $1$, two upper facets $t_{112}=0$ and $t_{222}=0$, the balanced product a degenerate vertex" | **yes.** Two active constraints on a one-dimensional set is degeneracy, and my identities give exactly that at $r=n(n-2)/4$ |
| [bounds-relaxations.md:364](../findings/bounds-relaxations.md) (post F43) | "$t_{112}=0$ says $E_{\max}$ is a subalgebra" as the $d=2$ precursor of the $d=3$ five-zeros reading | **yes** |
| [bounds.md:401](../findings/bounds.md) | cites L104, not L105, for the $d=2$ point case | **yes** |

---

## 10. Verdicts

| # | claim | verdict |
| --- | --- | --- |
| 1 | the lemma box's inequality, both branches, the normalisation | **CONFIRMED**, rebuilt cold, both displays reproduce exactly, two independent record anchors ($\sqrt{10}/18$, $t_{122}=-\tfrac1{26}$) recovered from my own identities |
| 2 | "the remaining two constraints give lower bounds and never bind above" | **CONFIRMED**, with the identities that show it |
| 3 | the crossing $(n-2)\rho^2-2\rho-n=0$ at $\rho=n/(n-2)$, value $\theta_0(n)$ | **CONFIRMED** |
| 4 | equality iff $r=n(n-2)/4$; $n$ even; strict at odd $n$ | **CONFIRMED**, with the uniqueness of the crossing supplied (the block asserts monotonicity without proving it) |
| 5 | "branch two **is** L23's dimension cap … with no hypothesis that $E_+$ is closed under bracket" | **REFUTED**, the cap needs $t_{112}=0$; $T\ge0$ alone gives only $r<\tfrac{n(n-2)}4\cdot\tfrac{2\sqrt{n-1}}{\sqrt{n-1}+1}$ |
| 6 | "… with no sum of squares" | **REFUTED**, $S_{\mathfrak{mmm}}=(N-r)(N-r-1)(N-r-2)t_{222}$, the same square sum, and L23's closed form falls out of my $t_{222}$ identity at $\theta=(n-1)w$ |
| 7 | the "does not need" list | **REPAIRED**, omits the unit norm and the centring, both load-bearing for the chain to $\theta_0(n)$ |
| 8 | "Same conclusion on the same stratum" as Theorem A | **REFUTED**, weaker at equality (no L71, so the spectrum rather than the point), stronger as an inequality below the crossing, and stated on a smaller stratum |
| 9 | "… without L70 or L71" | **CONFIRMED** |
| 10 | anchors in the block | **REFUTED**, both same-file anchors point at headings in [bounds.md](../findings/bounds.md) |
| 11 | hypothesis "both multiplicities $\ge3$" | **REPAIRED (strengthening)**, removable; the inequality holds at every multiplicity, with the degenerate cases forcing equality in one branch |
| 12 | hypothesis $n\ge5$ | **REPAIRED (scoping)**, unused by the proof; inherited from Conjecture A's failure at $n=4$ |
| 13 | [INDEX-results.md:120](../findings/INDEX-results.md) row | **REFUTED**, "equality only at the balanced product" is L71's conclusion, not L105's |

**I have not edited [findings/](../findings/) or [ATTEMPTS.md](../ATTEMPTS.md).** A second reviewer is on this brief independently; the repairs above are given as exact replacement text so the two verdicts can be merged without a write race.
