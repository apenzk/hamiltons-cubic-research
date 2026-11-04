# Verifier v154, Lemma L35's chain, its dual weight, its three-region endgame, and the two forms of its statement

Cold read of [BRIEF_L35.md](BRIEF_L35.md) worked from the definitions in [conventions.md](../findings/conventions.md) alone: I rebuilt the cubic identity, the $(+++)/(+--)$ decoupling, [Lemma L42](../results.md)'s duality, the reduction of $G$ to the one-variable envelope, and both non-envelope region caps before comparing any of it with the record. **No numerical work was done.** Every value below is exact or is a hand evaluation of a closed form at a named point, done as a screen on a claim I was about to record and never offered as evidence for a positive claim; the closed forms themselves are exhibited so a reader can redo them. The two forms of the statement, [results.md](../results.md) without unit norm, [stratum-two-negative.md](../findings/stratum-two-negative.md) with it, were treated as an open question and are resolved in §3. Log: [agent_logs/verify-L35-v154.log](../agent_logs/verify-L35-v154.log).

## The claims attacked

| # | claim | verdict | reason |
| --- | --- | --- | --- |
| 1 | $\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ at $\lVert W\rVert=1$ | **CONFIRMED** | $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}^2\lambda_\gamma\lambda_\delta$, ordered-to-unordered gives the $3$ |
| 2 | $\theta\le\mathrm{LP}\le G$, every relaxation pointing the enlarging way | **CONFIRMED** | true $T$ is feasible; dropping marginals and zero-$\lambda$ indices both enlarge |
| 3 | $G$ decouples exactly; $(+--)$ worth $2bc\lambda_1$ | **CONFIRMED AS ALGEBRA** | the two live sign-blocks consume disjoint pair caps; $(--)$ cap $2$ all onto $\lambda_1$ |
| 4 | $G=\sum_P\lambda^3+3\,\mathrm{FTP}-s^3+3bc(s+2\lambda_1)$, $bc=(s^2+u-1)/2$ | **CONFIRMED** | $b^3+c^3=s^3-3bcs$; $bc$ is trace-freeness and unit norm, and is an identity not a bound |
| 5 | Lemma L42: $3M(\lambda_P)\le h(s^2-u)$, constant attained | **CONFIRMED** | dual $z=\tfrac h3\lambda_\alpha\lambda_\beta$ feasible; $t=2/(k-2)$ attains it at $k\ge3$ |
| 6 | the canonical statement drops unit norm | **CONFIRMED, the two forms agree**, one edge | $\theta$ is $0$-homogeneous, so the norm is WLOG; it excludes only $W=0$ |
| 7 | one negative eigenvalue is "the $c\to0$ boundary" | **CONFIRMED AS ALGEBRA, NO ARGUMENT ON FILE** | $G$'s formula is correct verbatim at $c=0$, but the block writes no line and "forces $b=c$" excludes $c=0$ |
| 8 | "the cases of one and two positive eigenvalues close in closed form" | **NO ARGUMENT ON FILE in [findings/](../findings/)** | $k=1$ is L29; $k=2$ is in [REVIEW_r63.md](../reviews/REVIEW_r63.md) alone |
| 9 | "three regions capped at $1.017217$, $1.067666$, and an envelope" | **CONFIRMED, AND SOURCED TO A REVIEW** | regions defined and derived only in [REVIEW_r63.md](../reviews/REVIEW_r63.md); both caps reproduce |
| 10 | the residual inequality $\max_{0\le t\le\frac{2\sqrt2}3A}$ closes the endgame | **REFUTED AS STATED** | it closes one of three regions; $t>T$ is reachable and the block reads as though it were the whole |
| 11 | $(0,\tfrac13]$ closed in closed form at $\le\tfrac89$ | **CONFIRMED** | $\Phi(A)=-\tfrac{23}3A^3+5A-\tfrac{(1-A^2)^{3/2}}{\sqrt2}+\tfrac23A^2\sqrt{2-2A^2}$, $\Phi'>0$, $\Phi(\tfrac13)=\tfrac89$ exactly |
| 12 | "peaking at $A=\tfrac13$ where $\beta=0$" | **REFUTED AS A REASON** | $\Phi'(\tfrac13)=\tfrac{11}3>0$; $\beta=0$ there is a coincidence of the band edge, not the cause |
| 13 | endpoint constants $g(A_0)=\tfrac{\sqrt6}2$, $g'(A_0)=0$, $-\tfrac12g''(A_0)=\tfrac94\sqrt6$, $\psi^*=\tfrac32\sqrt6\varepsilon^2$ | **CONFIRMED** | all four reproduce exactly; the block's own withdrawal of the expansion is correct |
| 14 | correction (i): $(b+c)^2+b^2+c^2\ge1$ "is Cauchy–Schwarz" | **REFUTED AS ATTRIBUTED** | it is $\lVert\lambda\rVert_1\ge\lVert\lambda\rVert_2$; C–S gives the *opposite* direction, and that one is the unnamed $s^2\le2-2u$ |
| 15 | $(\tfrac13,A_0]$ closed | **UNRESOLVED, validated numerics only** | no hand-checkable argument on file; this loop cannot check it and did not try |
| 16 | $\ker W\ne0$ / padding | **CONFIRMED SAFE** | zero eigenvalues drop from the objective; $G$ is $m$-free, so padding is exactly the equality case |

## One-line summary

**Nothing here refutes $\theta\le\sqrt{3/2}$ (every step I could reach reproduces exactly, including both undocumented region caps) but the endgame that the block summarises exists in full only in [REVIEW_r63.md](../reviews/REVIEW_r63.md), the block presents one of its three regions as the whole closure, and the one-negative case and the $(\tfrac13,A_0]$ band have no argument in [findings/](../findings/) at all.**

## 0. Conventions, fixed once

Quoted, not restated. From [conventions.md](../findings/conventions.md):

> $\theta$, $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

> **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant; so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide.

> **Sums over pairs are over ORDERED pairs** unless the line says otherwise.

> **The pair cap and the Killing marginal, each a numbered result rather than a convention.** The pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ is **[Lemma L31](../findings/stratum-two-negative.md)**, proved with its equality case characterised. The row marginal is **[Lemma L153](../findings/bounds.md)**, in the general form $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ […] **The marginal has two readings and consumers use both**: $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ over ordered pairs, $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=n-2$ over unordered, so convert before comparing constants.

> $A$, $d$, $G$, $A_0$, in the two-negative relaxation: $A=\lambda_1$, $d=u-\lambda_1^2$, $G$ the pair-capped fractional triangle packing that the chain's bound **is**, and $A_0$ the interior maximiser of $g$. **None was defined in [findings/](../findings/)** […] **$d$ collides with the negative-eigenvalue count in [bounds-relaxations.md](../findings/bounds-relaxations.md)**, under which reading [L35](../findings/stratum-two-negative.md)'s bound would read $h\le3/2$ and be vacuous

> **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing […]

The half-trace pairing is the one [Lemma L31](../findings/stratum-two-negative.md) is stated in, so no conversion is owed at the pair cap. Throughout: $\lambda_1\ge\dots\ge\lambda_k>0$ the positives, $-b,-c$ the negatives with $b,c>0$, $s=\sum_P\lambda$, $u=\sum_P\lambda^2$, $A=\lambda_1$, $d=u-A^2$, $t=\sqrt d$, $T=\tfrac{2\sqrt2}3A$, $A_0=\sqrt{2/3}$, $K_0=\tfrac3{2\sqrt2}$.

## 1. The hypothesis inventory

**A pass with no inventory is not a pass, so here is the whole of it.** Column four is the item the brief actually asks for: whether the written proof uses it.

### 1a. Hypotheses the statement carries

| hypothesis | canonical form ([results.md](../results.md)) | block form ([stratum-two-negative.md](../findings/stratum-two-negative.md)) | used by the proof? |
| --- | --- | --- | --- |
| $W\in\mathrm{Weyl}_m$ | yes | yes | **no**, the chain never touches first Bianchi; §7 |
| $\lVert W\rVert=1$ | **absent** | present | **yes**, three times: the identity, $b^2+c^2=1-u$, $bc=(s^2+u-1)/2$ |
| $\mathop{\mathrm{tr}}W=0$ | implicit in $\mathrm{Weyl}_m$ | implicit | **yes**, $s=b+c$, and it is never named as a hypothesis |
| at most two negative eigenvalues | yes | yes | **partly**, the argument is written for exactly two |
| any number of positives | yes | yes | yes, split at $k\le2$ / $k\ge3$ |
| any $m$ | yes | yes | yes; $m$ enters only the marginal, which is discarded |

### 1b. Hypotheses of every imported theorem, checked against the object it is applied to

| import | its hypotheses | the object here | verdict |
| --- | --- | --- | --- |
| [Lemma L31](../findings/stratum-two-negative.md), pair cap | $X,Y\in\mathfrak{so}(n)$ **orthonormal**, half-trace norm | $v_\alpha,v_\beta$ from an orthonormal eigenbasis of $W$ on $\Lambda^2\cong\mathfrak{so}(m)$ | **met**, no conversion owed |
| [Lemma L153](../findings/bounds.md), row marginal | any $v\in\mathfrak{so}(n)$, any $n\ge2$ | the same basis vectors, sum over the full $\binom m2$ index set | **met**; the block's $m-2$ is the unordered halving and is right |
| [Lemma L42](../findings/stratum-two-negative.md), dual weight | **at least three positives**, all $\lambda>0$ (the dual divides by $\lambda_\alpha\lambda_\beta\lambda_\gamma$) | $\lambda_P$ with $k\ge3$ | **met on the branch it is used**; $k\le2$ diverted, §5 |
| LP weak duality | primal feasible, dual feasible; no unitality, no boundedness needed in advance | the triangle-packing LP and $z=\tfrac h3\lambda_\alpha\lambda_\beta$ | **met**; $t=0$ and $z$ exhibit both |
| envelope theorem (Danskin) | max attained, maximiser unique for differentiability | $\psi'=\alpha+2\beta t+3\gamma t^2$ with $\gamma<0$ and $\alpha>0$ on $A<A_0$: one positive root, so a unique argmax on $[0,T]$ | **met, and the record never states the $\alpha>0$ that makes it so** |
| Cauchy–Schwarz |, | applied twice, in opposite directions | **one of the two is misnamed**, §8 |

### 1c. Hypotheses used but never stated

- **$\mathop{\mathrm{tr}}W=0$**, load-bearing at $s=b+c$, appears in neither form of the statement except through $\mathrm{Weyl}_m$, and the block simultaneously claims the result for "any trace-free symmetric operator", where it would have to be a hypothesis in its own right.
- **$s^2\ge u$**, i.e. $\lVert\lambda_P\rVert_1\ge\lVert\lambda_P\rVert_2$. Without it $s^2-u<0$ and the substitution $h\le\min(A,K_0\sqrt d)$ into $3M\le h(s^2-u)$ runs backwards. The record has this inequality (as correction (i)) and never connects it to the step that needs it.
- **$\alpha>0$ on $(0,A_0)$**, which is what makes the envelope's argmax unique and Danskin applicable.
- **$k\ge3$** at the point [Lemma L42](../findings/stratum-two-negative.md) is invoked. The chain section states it ("Hypothesis, previously unstated: at least three positives"); the L35 block does not.

### 1d. Hypotheses stated and never used

- **The row marginal $m-2$.** The block says so itself, twice, and is right: every step after it runs on $G$. No finding, a stated-and-discarded constraint is safe, and the block's own gloss is the correct one.
- **First Bianchi / $W\in\mathrm{Weyl}_m$.** Unused, and the block says so. §7 says what that costs.

## 2. Quantifier order and scope

**No finding on the direction of the chain.** $\theta\le\mathrm{LP}\le G\le\sqrt{3/2}$: the true $T$ is one feasible point of the LP so the first is $\le$; dropping the marginals enlarges the feasible set so the second is $\le$; the third is the endgame. Each points the way claimed.

**No finding on the decoupling.** The one place a sup could have been wrongly distributed across terms sharing a variable is $\max_t[(+++)+(+--)]=\max(+++)+\max(+--)$, and it is legitimate because the two blocks consume disjoint constraints: $(+++)$ uses only $(++)$ pairs, $(+--)$ only the single $(--)$ pair and $(+-)$ pairs, and the $(++-)$ entries that would join them carry a negative product so the maximiser sets them to zero. That makes "$G$ decouples exactly" an identity, as claimed. On the $(+--)$ side the binding constraint is $\sum_\alpha t_{\alpha,N-1,N}\le2$ and the $(+-)$ caps each permit $2$ alone, so all the mass goes on the largest positive: $M_{+--}=2bc\lambda_1$, entering $\theta$ as $6bc\lambda_1$.

**One finding on scope, and it is claim 10.** $\lambda_1$ appears in three different bounds, $\sum_P\lambda^3\le A^3+\min(A,\sqrt d)d$, $h\le\min(A,K_0\sqrt d)$, and the $(+--)$ transport $2bc\lambda_1$, all three simultaneously valid at one spectrum, so there is no double-counted sup. But the branch structure of the two $\min$'s is a **case split on $(A,d)$ that the block never states**, and the residual inequality it writes out is only one of the cases. §6.

## 3. The two forms of the statement, and $W=0$

The canonical form has no unit-norm hypothesis; the block's has one and emphasises it. **They agree, and the block's emphasis is misplaced.** $\theta=P(W)/\lVert W\rVert^3$ is homogeneous of degree $0$, so at $W\ne0$ the conclusion $\theta\le\sqrt{3/2}$ is scale-invariant and normalising is without loss. What needs $\lVert W\rVert=1$ is the *display* (the right side is $P(W)$, degree $3$) and the two constants derived from it, $b^2+c^2=1-u$ and $bc=(s^2+u-1)/2$. So [r569](../reviews/REVIEW_r569.md)'s D1 repair is right about the identity and would be wrong if extended to the statement.

**The one place the norm is not free is $W=0$.** The canonical statement admits it: $W=0$ lies in $\mathrm{Weyl}_m$ and has *zero* negative eigenvalues, hence at most two. There $\theta$ is $0/0$. The block's own gloss (*"zero negative eigenvalues is impossible by trace-freeness"*), is true for $W\ne0$ and false for $W=0$, which is exactly the point trace-freeness cannot reach. The repair is $W\ne0$ or $\lVert W\rVert=1$ in the canonical form; I have not made it.

## 4. The chain, re-derived

**Claim 1.** In an orthonormal eigenbasis, $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}^2\lambda_\gamma\lambda_\delta$ under the halved Böhm–Wilking product of [conventions.md](../findings/conventions.md), so $\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\gamma\delta}T_{\alpha\gamma\delta}\lambda_\alpha\lambda_\gamma\lambda_\delta$ over *ordered* triples. $T$ is totally symmetric and hollow, so the ordered sum is $6\sum_{\alpha<\beta<\gamma}$ and $\langle W,W^\#\rangle=3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$. With $\mathop{\mathrm{tr}}W^3=\sum\lambda^3$ and $P=\langle W,W^2+W^\#\rangle$ the display follows. The coefficient $3$ checks at $(2,-1,-1)/\sqrt6$: $\sum\lambda^3=6/(6\sqrt6)=1/\sqrt6$ and $3\cdot2\cdot2/(6\sqrt6)=2/\sqrt6$, summing to $3/\sqrt6=\sqrt6/2=\sqrt{3/2}$.

**Claim 4.** $b^3+c^3=(b+c)^3-3bc(b+c)=s^3-3bcs$, so $\sum_\alpha\lambda_\alpha^3=\sum_P\lambda^3-s^3+3bcs$, and adding $6bc\lambda_1$ and $3\,\mathrm{FTP}$ gives the block's formula, **provided the bare $\sum\lambda^3$ in it is read over the positives only**, twenty lines after $\sum_\alpha\lambda_\alpha^3$ meant all eigenvalues. [r569](../reviews/REVIEW_r569.md) already booked that collision; it is still there. $bc=(s^2+u-1)/2$ is an identity, not an estimate: $s^2+u-1=(b+c)^2-b^2-c^2=2bc$.

## 5. Lemma L42, and the $k\le2$ edge

**The duality is correct end to end.** Each $t_{\alpha\beta\gamma}$ sits in exactly three pair constraints with coefficient $1$, so the dual is $\min2\sum_{\alpha<\beta}z_{\alpha\beta}$ with $z_{\alpha\beta}+z_{\beta\gamma}+z_{\alpha\gamma}\ge\lambda_\alpha\lambda_\beta\lambda_\gamma$, $z\ge0$. Putting $z=c\lambda_\alpha\lambda_\beta$ and dividing by $\lambda_\alpha\lambda_\beta\lambda_\gamma>0$ gives $c\sum1/\lambda\ge1$, i.e. $c\ge H/3$ with $H$ the harmonic mean; $H$ is increasing in each argument so the binding triple is the three largest and $c=h/3$ is feasible. The dual value is $2\cdot\tfrac h3\cdot\tfrac{s^2-u}2=\tfrac h3(s^2-u)$, giving the boxed $3M\le h(s^2-u)$. Sharpness at $k$ equal positives: $t=2/(k-2)$ on every triple has pair marginal $(k-2)\cdot\tfrac2{k-2}=2$ and $\sum t=\binom k3\tfrac2{k-2}=\tfrac{k(k-1)}3$, matching $h(s^2-u)/3=k(k-1)\lambda^3/3$. Valid for $k\ge3$; at $k=3$ it reads $t=2$ on the single triple.

**The $h\le\min(\lambda_1,K_0\sqrt d)$ bound is right, and it pins which $d$ is meant.** $h\le\max=\lambda_1$; and dropping $1/\lambda_1$ gives $h\le\tfrac32\mathrm{HM}(\lambda_2,\lambda_3)\le\tfrac32\sqrt{(\lambda_2^2+\lambda_3^2)/2}\le\tfrac32\sqrt{d/2}=K_0\sqrt d$ with $d=u-\lambda_1^2$. **This answers the symbol collision the brief names:** under [bounds-relaxations.md](../findings/bounds-relaxations.md)'s $d$, the distinct-eigenvalue count, $K_0\sqrt d$ at $d=2$ is exactly $3/2$ and the bound is vacuous, as [conventions.md](../findings/conventions.md) warns; under $d=u-\lambda_1^2$ every downstream constant reproduces (§6). The block still never says which.

**$k\le2$: the edge is real and the record's answer to it is a sentence.** At $k\le2$ there are no triples, $M=0$ and $h$ is undefined, the chain section states this and says "those cases are closed elsewhere"; the L35 block says "The cases of one and two positive eigenvalues close in closed form." $k=1$ **is** [Lemma L29](../results.md) and is genuinely on the record. **$k=2$ is not, anywhere in [findings/](../findings/) or [results.md](../results.md).** It is in [REVIEW_r63.md](../reviews/REVIEW_r63.md) and nowhere else. Per the loop's rule the finding is that the claim has no argument on file; I record separately that I attacked it and it held (§9), which is not the same thing and must not be entered as the missing proof.

## 6. The endgame, claim 10, the finding that survived all three steps

### Step 1, locate it

The block writes:

> With $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$ and two further elementary bounds, $G$ is dominated by a three-parameter relaxation strictly increasing in $s$ and $u$; forcing both to the constraint $s^2\le2-2u$ **forces $b=c$** and leaves two variables, in three regions capped at $1.017217$, $1.067666$, and an envelope whose maximum is exactly $\sqrt{3/2}$ at $A=\sqrt{2/3}$.

and then, under "The residual inequality is closed, and rigorously", writes out **only** the envelope: $g(A)+\max_{0\le t\le\frac{2\sqrt2}3A}\psi(t)\le\sqrt{3/2}$ on $(0,A_0]$, split into three *$A$-ranges* with margins $+0.336$, $+0.0215$, $\tfrac34\sqrt6$. The two three-way splits are different splits with disjoint constants, $\{1.017217,1.067666,\text{envelope}\}$ against $\{\tfrac89,1.20323,\sqrt{3/2}\}$, and nothing in the block says so. A reader takes the second as the elaboration of the first. **What the two further elementary bounds are, what the three regions are, and where the two decimals come from: none of it is in [findings/](../findings/) or [results.md](../results.md).**

### Step 2, exhibit the failure concretely

The envelope's $t$-range is $[0,T]$ with $T=\tfrac{2\sqrt2}3A$, i.e. $d\le\tfrac89A^2$. **Spectra with $d>\tfrac89A^2$ exist and are ordinary.** Take three equal positives and $b=c$: $\lambda_i=\lambda$, $s=3\lambda=2b$, so $b=\tfrac32\lambda$ and $3\lambda^2+2b^2=\tfrac{15}2\lambda^2=1$, $\lambda^2=\tfrac2{15}$. Then

$$A=\lambda,\qquad d=u-A^2=2\lambda^2,\qquad t=\sqrt2\,\lambda,\qquad T=\tfrac{2\sqrt2}3\lambda,\qquad \frac tT=\frac32 .$$

Exactly $\tfrac32$, in closed form, at every $\lambda$. This point is admissible on every count the relaxation imposes, $A=\sqrt{2/15}=0.3651<A_0$, $u=\tfrac25<\tfrac23$ so $s^2-u>0$, $bc>0$, and it lies outside the $t$-interval the written residual inequality quantifies over. So the residual inequality, as the block presents it, does not reach it. (It is not a counterexample to the lemma: $G$ there is $\tfrac{\sqrt2}{2}\sqrt k(10-k)/(k+2)^{3/2}$ at $k=3$, namely $0.7668$.)

### Step 3, argue the opposite

The charitable reading is that the $t>T$ material is precisely the two regions capped at $1.017217$ and $1.067666$, and **that reading is correct**: [REVIEW_r63.md](../reviews/REVIEW_r63.md) carries the split as $d>A^2$, $\tfrac89A^2<d\le A^2$, $d\le\tfrac89A^2$, the third being exactly $K_0\sqrt d\le A$, i.e. $t\le T$. So the mathematics is whole. **The record is not.** The regions are defined in a review file, the block links to no review at that sentence, and the section that does elaborate elaborates the wrong trichotomy. The finding is therefore not "the endgame is wrong" but "the endgame's case split is invisible from the record, and the one case that is written out is presented as the whole".

### What I checked of the two undocumented regions

Both caps reproduce, as screens on the closed forms [REVIEW_r63.md](../reviews/REVIEW_r63.md) states, at $b=c$ so $s=\sqrt{2-2u}$:

- **$d>A^2$**, where both minima are $A$: $R_2=A^3+Ad+A(2-3u)-\tfrac{(2-2u)^{3/2}}4+3A(1-u)=5A(1-u)-\tfrac{(2-2u)^{3/2}}4$, increasing in $A$, so $A=\sqrt{u/2}$ and $R_2=\tfrac1{\sqrt2}\big[5\sqrt u(1-u)-(1-u)^{3/2}\big]$. At $u=0.43$ this is $1.01720$; the recorded cap is $1.017217$.
- **$\tfrac89A^2<d\le A^2$**, where $\min(A,\sqrt d)=\sqrt d\le A$ is spent as $d^{3/2}\le A^3$: $R_2\le2A^3+A(5-6u)-\tfrac{(2-2u)^{3/2}}4$, increasing in $A$, so $A=3\sqrt{u/17}$. At $u=0.435$ this is $\approx1.06767$; the recorded cap is $1.067666$.

Both sit under $\sqrt{3/2}=1.224745$ with room. **This is a screen on the record's own numbers, not a proof of them**, and the derivation the record owes is its own.

### The envelope, reconstructed, and what that reconstruction is and is not

Working from the definitions alone I get, on $b=c$ with $u=A^2+t^2$ and $s^2=2-2u$, and using $\sum_{i\ge2}\lambda_i^3\le\lambda_2 d\le t^3$ together with the concavity bound $(X-2t^2)^{3/2}\ge X^{3/2}-3t^2\sqrt X$ at $X=2-2A^2$,

$$R_2\le g(A)+\psi(t),\quad g(A)=A^3-\tfrac{(1-A^2)^{3/2}}{\sqrt2}+3A(1-A^2),\quad \psi(t)=\alpha t+\beta t^2+\gamma t^3,$$
$$\alpha=K_0(2-3A^2)=\tfrac{9\sqrt2}4\big(\tfrac23-A^2\big),\qquad \beta=\tfrac34\sqrt{2-2A^2}-3A,\qquad \gamma=1-3K_0=1-\tfrac{9\sqrt2}4<0 .$$

Every recorded constant falls out of this and nothing was fitted: $\alpha'=-\tfrac{9\sqrt2}2A$ and $\beta'=-\tfrac{3\sqrt2A}{4\sqrt{1-A^2}}-3$ as printed; $\gamma$ constant in $A$, which is why the block's $F'$ carries no $\gamma't^3$ term; $\beta=0\iff\sqrt{2-2A^2}=4A\iff A=\tfrac13$; $\beta(A_0)=-\tfrac34\sqrt6$; $\alpha(A_0-\varepsilon)=3\sqrt3\varepsilon$; the branch switch $\alpha+2\beta T+3\gamma T^2=0$ at $A=0.4463$, where I get $8\times10^{-4}$; and $\Phi(\tfrac13)=\tfrac89$ **exactly** (§10). The domain $A\le A_0$ is forced rather than chosen: $A\le s$ and $s^2\le2-2u\le2-2A^2$ give $3A^2\le2$.

**This reconstruction is diagnostic and is not the missing derivation.** It agrees, coefficient for coefficient, with the five lemmas in [REVIEW_r63.md](../reviews/REVIEW_r63.md), which is evidence about *what* the record is missing (one paragraph, five one-line bounds and a three-way case split) and is not itself to be entered as the record's proof. The record owes its own, including the two direction checks the review states and the block does not: $s^2\ge u$ before the $h$-substitution, and $\partial R/\partial u>0$ requiring $h\le A$.

## 7. The gap between what is proven and what is used

**No finding, and the gap runs the generous way.** The block claims the chain never uses first Bianchi, so the bound holds for any trace-free unit-norm symmetric operator on $\Lambda^2$ with the sign pattern. I checked each input: the cubic identity needs only symmetry of $W$ and the ad-invariance of the pairing; the pair cap is a statement about orthonormal pairs in $\mathfrak{so}(m)$ and asks nothing of $W$; the marginal is a Casimir identity and is discarded; $s=b+c$ and $bc=(s^2+u-1)/2$ need trace-freeness and unit norm only. So the proven statement is strictly stronger than the used one. The cost is that **$\mathop{\mathrm{tr}}W=0$ then has to be a hypothesis in its own right** and appears in neither statement, §1c.

## 8. Correction (i): the misattributed Cauchy–Schwarz

**Two inequalities are in play, in opposite directions, and the record names the wrong one.**

- $(b+c)^2+b^2+c^2\ge1$, i.e. $s^2\ge u$, i.e. $\big(\sum_P\lambda\big)^2\ge\sum_P\lambda^2$. True for nonnegative $\lambda$ by expansion, or as $\lVert\lambda\rVert_1\ge\lVert\lambda\rVert_2$. **Cauchy–Schwarz gives the reverse, $(\sum\lambda)^2\le k\sum\lambda^2$**, so the name is wrong. Correction (i) asserts it is Cauchy–Schwarz and both Gate-2 reviewers are recorded as agreeing.
- $s^2\le2-2u$, i.e. $(b+c)^2\le2(b^2+c^2)$. **This one is Cauchy–Schwarz**, against the all-ones vector, with equality iff $b=c$, which is exactly the "forces $b=c$" step. It is named nowhere.

The mathematics is unaffected: both inequalities are true and both are used correctly. The finding is that a *correction*, made and Gate-2'd, installed a wrong attribution on one and left the genuine instance unnamed. Given that the record's own rule is that constants and names come from the definition, this one is worth fixing.

## 9. The one-negative case, and $k=2$, what I attacked and what the record owes

**Claim 7.** The block says the one-negative case "is the $c\to0$ boundary and is owed a line". Taking $c=0$: the $(+--)$ block is empty, $(++-)$ is still killed by sign, so $G_{1\text{neg}}=\sum_P\lambda^3-b^3+3\,\mathrm{FTP}$ with $b=s$, which is the block's formula verbatim at $bc=0$. So the formula extends. **The step that does not extend is the one the block leans on**: "forcing both to the constraint $s^2\le2-2u$ forces $b=c$" reads as universal, and at $c=0$ the constraint $s^2\le2-2u$ becomes $b^2\le2b^2$, slack unless $b=0$. The repair is not continuity but inclusion, the $c=0$ point satisfies the relaxation's constraints and is dominated by a $b=c$ point at the same $(A,u)$, since $R$ increases in $s$. **I am not writing that line into the record.** The finding is `HYPOTHESIS-DEBT`: the one-negative case, which the canonical statement covers, has no argument on file, and the block says as much.

**Claim 8, $k=2$.** I attacked it in closed form. With two positives $A\ge p>0$ and $\mathrm{FTP}=0$, $G=-3Ap(A+p)+3\big(A^2+p^2+Ap-\tfrac12\big)(3A+p)$ on $\{3A^2+2Ap+3p^2\le2,\ A^2+p^2+Ap\ge\tfrac12\}$. Then $\partial G/\partial A=27A^2+18Ap+9p^2-\tfrac92\ge18A^2+9Ap\ge0$ using $bc\ge0$, so the maximum sits on $3A^2+2Ap+3p^2=2$, where $3A+p=\sqrt{6-8p^2}$ and

$$G(p)=\sqrt{6-8p^2}\Big(\tfrac12-\tfrac23p^2\Big)+\tfrac23p^3,\qquad p\in[0,\tfrac12].$$

The first factor is a product of two positive decreasing functions with derivative $\le-\tfrac83p\cdot\tfrac{\sqrt{6-8p^2}}{...}\le-\tfrac83p$ in magnitude bounded below by $\tfrac83p\cdot\tfrac12\cdot2$, against $+2p^2\le p$ from the cubic, so $G'<0$ on $(0,\tfrac12]$ and $\max G=G(0)=\tfrac{\sqrt6}2=\sqrt{3/2}$, attained only in the $p\to0$, i.e. $k\to1$, degeneration. **It held.** That is an attack that failed, not the missing proof, and the debt in claim 8 stands unchanged.

## 10. The three $A$-ranges of the envelope

**$(0,\tfrac13]$, CONFIRMED, and closed by hand.** Dropping $\gamma t^3\le0$ and evaluating at $t=T$: $\alpha T=A(2-3A^2)$ and $\beta T^2=\tfrac23A^2\sqrt{2-2A^2}-\tfrac83A^3$, so

$$\Phi(A)=g(A)+\alpha T+\beta T^2=-\tfrac{23}3A^3+5A-\tfrac{(1-A^2)^{3/2}}{\sqrt2}+\tfrac23A^2\sqrt{2-2A^2},$$
$$\Phi(\tfrac13)=-\tfrac{23}{81}+\tfrac53-\tfrac{(8/9)^{3/2}}{\sqrt2}+\tfrac2{27}=\tfrac89\ \text{exactly},\qquad \Phi'(\tfrac13)=-\tfrac{23}9+5+\tfrac23+\tfrac{16}{27}-\tfrac1{27}=\tfrac{11}3 .$$

$\Phi'(A)=-23A^2+5+\tfrac{3A}{\sqrt2}\sqrt{1-A^2}+\tfrac43A\sqrt{2-2A^2}-\tfrac43\tfrac{A^3}{\sqrt{2-2A^2}}\ge5-\tfrac{23}9-\tfrac4{81}>0$ on $(0,\tfrac13]$, so the maximum is at the right endpoint and equals $\tfrac89$, margin $\sqrt{3/2}-\tfrac89=0.3358$, the recorded $+0.336$.

**Claim 12, the stated reason is not the reason.** The block writes "peaking at $A=\tfrac13$ where $\beta=0$ exactly". $\beta(\tfrac13)=0$ is true and is the *definition of the band edge*; it is not why $\Phi$ peaks there. $\Phi'(\tfrac13)=\tfrac{11}3>0$, $\Phi$ is still climbing at $\tfrac13$, and peaks there only because the band stops. A reader who takes the parenthetical as the argument will look for a stationary point and find none.

**$(\tfrac13,0.7]$, no hand-checkable argument, and the numbers cohere.** Screen at $A=0.7$: $\alpha=0.562150$, $\beta=-1.342537$, $\gamma=-2.181981$, $T=0.659966$, $t_c=0.152579<T$, $g(0.7)=1.156464$, $\psi^*=0.046768$, $F=1.203232$ against the recorded branch-and-bound enclosure $[1.20322955981,\,1.20322956076]$. So the band's maximum is at its right endpoint, and the recorded $+0.0215$ margin is $\sqrt{3/2}-1.20323$. Coherent, and coherence is not the certificate. The certificate is a Lipschitz argument on a $1.83\times10^{-6}$ grid and a $200$-bit branch-and-bound, neither of which this loop may check.

**$(0.7,A_0]$, the block's own withdrawal is correct, and I confirmed it by derivation.** $g$ has $g'(A_0)=0$ and $-\tfrac12g''(A_0)=\tfrac94\sqrt6$; $\alpha(A_0-\varepsilon)=3\sqrt3\varepsilon$, $\beta(A_0)=-\tfrac34\sqrt6$, $t^*=\alpha/(2|\beta|)=\sqrt2\varepsilon$, $\psi^*=\alpha^2/(4|\beta|)=\tfrac32\sqrt6\varepsilon^2$, so $F=\tfrac{\sqrt6}2-\tfrac34\sqrt6\varepsilon^2+O(\varepsilon^3)$. **A second-order expansion with no remainder bound certifies nothing at finite $\varepsilon$, whichever way the $O(\varepsilon^3)$ points**, so the withdrawal is right on its own terms and not only because the recorded ratio approaches $\tfrac34\sqrt6$ from below. The band is closed by bisection.

## 11. Every edge the brief names, answered

| edge | answer |
| --- | --- |
| $k\le2$ positives, where $h$ is undefined | **real, and diverted correctly.** $M=0$ there, so nothing is lost; $k=1$ is L29, $k=2$ has no argument in [findings/](../findings/), claim 8 |
| exactly one negative eigenvalue | **debt confirmed**, and the block's "$c\to0$ boundary" is not the repair the step needs, §9 |
| the smallest admissible $m$ | **no finding.** $m=4$: the pair cap holds at every $m\ge2$, the marginal is discarded, and $G$ is $m$-free. Content begins at $m=4$ because $\mathcal W_3=0$ |
| odd $m$ | **no finding.** No step in the chain reads parity; $m$ enters only the discarded marginal |
| $A=\tfrac13$ | $\beta=0$, $\Phi=\tfrac89$ exactly, $\Phi'=\tfrac{11}3$, claim 12 |
| $A=0.4463$ | **confirmed as the branch switch.** $\alpha+2\beta T+3\gamma T^2=8\times10^{-4}$ at $A=0.4463$ from my reconstruction; and the $C^1$ claim is right, the capped branch's extra term carrying the factor $\psi_t(A_{\rm sw},T)=0$ |
| $A=0.7$ | $F=1.203232$; the middle band's max, and the point where the repair $Q$ fails, consistent |
| $A=0.7096$ | **no independent check possible.** It is the interval-arithmetic box boundary and appears in no closed form |
| $A_0=\sqrt{2/3}$ | **equality point.** $F(A_0)=g(A_0)=\tfrac{\sqrt6}2$ with $\alpha(A_0)=0$ so $\psi^*=0$. The lemma is tight here and nowhere else |
| $\ker W\ne0$ | **no finding, and the padded object is the equality case**, §12 |

## 12. $\ker W\ne0$, and one withdrawn candidate

**The trap the record keeps falling into does not bite here.** Zero eigenvalues contribute nothing to $\sum_\alpha\lambda_\alpha^3$ or to $\sum T\lambda\lambda\lambda$, and in the relaxation a triple touching a zero index has objective coefficient $0$ and only consumes cap, so the maximiser sets it to zero. $G$ is therefore literally the same function of the nonzero spectrum at every padding, which is what "free of $m$ and of $\binom m2$" means. The equality case is padded $W_{\mathbb{CP}^2}$: spectrum $(2,-1,-1)/\sqrt6$ with $\binom m2-3$ zeros, $\theta=\mathrm{LP}=G=\sqrt{3/2}$, no step lossy.

### Withdrawn candidate, "$\mathrm{LP}$ is infeasible at a padded object"

**Located.** "Relaxing $T$ to any nonnegative totally symmetric tensor with row marginals $m-2$ and pair caps […] gives $\theta\le\mathrm{LP}(\lambda)$", one line before "$G$ is […] supported on the nonzero eigenvalues alone".

**Exhibited.** Read the marginal as an equality *on the support*, as the following clause invites: at padded $W_{\mathbb{CP}^2}$ the support has $r=3$ live indices, row mass is at most $\tfrac12(r-1)\cdot2=2$ by the pair caps, and $m-2\ge3$ at every $m\ge5$. The feasible set is then empty, $\mathrm{LP}=-\infty$, and $\theta\le\mathrm{LP}$ is false.

**Argued the opposite, and it survives.** The block's index set for the $\mathrm{LP}$ is the full $\binom m2$, where the true $T$ meets the marginal as an equality by [Lemma L153](../findings/bounds.md) and the LP is feasible; the restriction to the support happens at $G$, after the marginals are gone. That is the reading the sentence order supports. **Withdrawn**, and recorded so the next verifier does not spend an adjudication on it. What remains is a presentational hazard of the kind [r569](../reviews/REVIEW_r569.md)'s D3 names: an ambiguous constraint is safe only because it is discarded one line later.

## 13. What would falsify it, and what I did to look

**A falsifier is a unit-norm $W$ on $\Lambda^2\mathbb R^m$, trace-free, with at most two negative eigenvalues and $\theta>\sqrt{3/2}$.** Since $\theta\le G$ and $G$ is a function of the spectrum alone, it suffices (and by the tightness at $A_0$ very nearly is necessary) that some admissible $(A,s,u,b,c)$ have $G>\sqrt{3/2}$; concretely, that the envelope $F$ overshoot somewhere on $(0.7,A_0]$, since $F(A_0)=\sqrt{3/2}$ exactly and any interior spike there breaks the lemma. That is precisely the interval the record closes by bisection.

What I put against it, all in closed form:

- **$k=1$**, the whole family: $G=\tfrac92A(2A^2-1)$ with $A\in[\tfrac1{\sqrt2},A_0]$, maximal at $A=A_0$ where $b=c=\tfrac1{\sqrt6}$ and the spectrum is $(2,-1,-1)/\sqrt6$, value exactly $\sqrt{3/2}$. **Equality, not violation.**
- **$k=2$**, the whole family: §9, strictly below except in the $k\to1$ limit.
- **$k$ equal positives with $b=c$**: $G=\tfrac{\sqrt2}2\sqrt k(10-k)/(k+2)^{3/2}$, giving $\sqrt{3/2}$ at $k=1$, $1$ at $k=2$, $0.7668$ at $k=3$, $0.4269$ at $k=5$. No approach to the cap.
- **The split-positive family** the record names in correction (ii): splitting $\lambda_1$ into $A-\varepsilon$ and $\varepsilon$-parts leaves $A$, $s$, $u$ and $\mathrm{FTP}$ continuous, so $G\to\sqrt{3/2}$ from below at every $k$. Confirms $\sup G=\sqrt{3/2}$ at every $k$ and refutes nothing.
- **Padded objects**: §12. The equality case, stable under padding.
- **The diagonal / sphere-product family, which is the only place on this record where $\theta$ genuinely exceeds $\sqrt{3/2}$**, $\Theta_{12}=1.2361$, $S^5\times S^7$ at $1.228239$. I checked whether any of them can satisfy the hypothesis and none can: a coordinate-diagonal $W$ has $\Lambda^2$ spectrum the *entries* of the hollow $K$ with every row summing to zero, so each of the $m$ rows carries a negative entry, and for the balanced product the mixed block alone contributes $pq\ge9$ negatives at $m\ge6$. **The family that beats the constant misses the hypothesis by two orders of multiplicity, which is the strongest evidence available for the lemma that is not a proof of it.**
- **$\mathbb{CP}^m$ and the symmetric-pair two-eigenvalue points**: capped by [Lemma L38](../results.md) at $\sqrt{3/2}$ with $m=2$ the only equality, so no falsifier there whatever their negative counts.
- **Tori**: $W=0$, which is the $\theta$-undefined edge of §3 rather than a falsifier.

**No falsifier found, and the one region where one could hide is the region the record closes numerically.**

## Verdict

**HYPOTHESIS-DEBT.** No step is broken, no constant is wrong, and every piece I could reach reproduces exactly, including the two region caps the record states as bare decimals. Four things are owed:

1. **The endgame's case split.** The five elementary bounds, the three regions $d>A^2$, $\tfrac89A^2<d\le A^2$, $d\le\tfrac89A^2$, and the derivation of $1.017217$ and $1.067666$ exist only in [REVIEW_r63.md](../reviews/REVIEW_r63.md). The block cites none of it and its "residual inequality" section elaborates a different trichotomy, so the record reads as though one region were the whole. Claim 10.
2. **The one-negative case**, which the canonical statement covers and no line on file argues. §9.
3. **$k=2$ positives**, asserted to "close in closed form" with the closed form nowhere in [findings/](../findings/). Claim 8.
4. **$W\ne0$**, missing from the canonical statement, where zero negative eigenvalues is admissible and $\theta$ is $0/0$. §3.

And one item is beyond this loop rather than owed by it: **$(\tfrac13,A_0]$ is closed by validated numerics** (Lipschitz plus $200$-bit branch-and-bound plus bisection) which is rigorous and is not an argument a reader can check. The block says so itself, and [results.md](../results.md)'s index line says so too; that honesty is the right state of the record and I confirm it rather than fault it.

Three smaller corrections, each with its derivation above: the "Cauchy–Schwarz" of correction (i) is misattributed and the genuine instance is unnamed (§8); "peaking at $A=\tfrac13$ where $\beta=0$" states a coincidence as a cause (claim 12); and the block's insistence that the *statement* needs unit norm overshoots, the identity needs it, the statement does not (§3).
