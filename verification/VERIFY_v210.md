# VERIFY_v210, Lemma L30, a cold reading

*The brief was read cold: [BRIEF_L30.md](BRIEF_L30.md) first, then [conventions.md](../findings/conventions.md) in full, then the block in place at [stratum-two-negative.md](../findings/stratum-two-negative.md), the development form thirty-four lines above it, the two entries in [results.md](../results.md), row 30 of [INDEX-results.md](../findings/INDEX-results.md), and [REVIEW_r59.md](../reviews/REVIEW_r59.md). **No numerical work of any kind was done**, no script, no Sage, no evaluation; every object below is exhibited in closed form, under the programme's standing analysis-only rule. Log: [verify-L30-v210.log](../agent_logs/verify-L30-v210.log).*

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $\mathrm{Ric}(W)(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$, hence Ricci-flatness is $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ | **PROVEN**, coefficient normalisation-dependent, conclusion not |
| 2a | the positive and negative sides are the same matrix | **PROVEN** |
| 2b | that matrix's image sits in $U$, so every $\operatorname{im}v_\alpha$ with $\lambda_\alpha\ne0$ sits in $U$ | **PROVEN**, on one unstated step |
| 3 | $v_\alpha u=0$ for $u\perp U$ and $\lambda_\alpha\ne0$, hence $W(u\wedge w)=0$ | **PROVEN** |
| 4 | the $\lambda_\alpha\ne0$ qualifier is necessary, witnessed by $e_9\wedge e_{10}$ at padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$ | **PROVEN**, witness checked and correct |
| 5 | "at most two" is used only in defining $U$ | **PROVEN**, and there it is load-bearing; the blockquote's $\mathbb R^8$ witness checked and correct |
| 6 | the restriction to $\Lambda^2U$ is Ricci-flat | **PROVEN** |
| 7 | the restriction lies in $\mathrm{Weyl}_{\dim U}$ | **GAP**, Bianchi and pair symmetry never mentioned |
| 8 | **"with the same norm and the same $\theta$"** | **HYPOTHESIS-DEBT**, no argument anywhere in the block; the record's only carriers are an unsourced conventions bullet and a review sketch |
| 9 | scope $6,7,8$ (block) against "below $n=9$" (development form) against $5,6,7,8$ (blockquote) | **the blockquote is right**; $n=4$ carries no content, $n=5$ does |
| 10 | [INDEX-results.md](../findings/INDEX-results.md) row 30's "Scope is $n=5\ldots8$" read as the lemma's range | **misleading**, L30 has content at every $n\ge5$ and is consumed at $n=12$ |

**One line: the statement is true in every clause, and the proof on file establishes every clause but the one the lemma exists for.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

- $N$: "$\binom n2=\dim\Lambda^2\mathbb R^n$". So $v_{N-1},v_N$ are the last two of a full eigenbasis of $W$ on $\Lambda^2$.
- The norm on $\mathfrak{so}(n)$: "**This record's norm is $\lVert Z\rVert^2=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z)$, so $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$**".
- The bivector normalisation: "$\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal".
- $\mathrm{Ric}$: "$\mathrm{Ric}$ is the adjoint of $\cdot\wedge\mathrm{id}$, with $\lVert\mathrm{Ric}\rVert$ the Frobenius norm of the resulting symmetric matrix."
- $\#$: "$\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$".
- $Q$, $P$, $\theta$: "$Q(W)$ | Hamilton's quadratic map $W^2+W^\#$"; "$P(W)$ | the cubic form $\langle W,Q(W)\rangle$"; "$\theta$ | $P(W)/\lVert W\rVert^3$".
- Structure constants: "$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**".
- Padding: "**Padding commutes with $Q$**, and preserves both the norm and $\theta$. The stratum reduction turns on this.", *this bullet is the whole of the record's support for claim 8 and it carries no source column; see §5.*
- $\dim\mathcal W_m=\frac{m(m-3)(m+1)(m+2)}{12}$, so $\mathcal W_m=0$ for $m\le3$. Used at §7.

## Hypothesis inventory

| # | hypothesis | stated? | used? | where used |
| --- | --- | --- | --- | --- |
| H1 | $W$ Ricci-flat | yes, via $W\in\mathrm{Weyl}_n$ | yes | step 1, and again at the restriction |
| H2 | $W$ satisfies the first Bianchi identity and the pair symmetry | yes, via $W\in\mathrm{Weyl}_n$ | **needed and never mentioned**, it is half of "$W'\in\mathrm{Weyl}_{\dim U}$" | conclusion |
| H3 | at most two negative eigenvalues | yes | **only** to identify $\operatorname{im}P_-$ with $U$ | step 2b |
| H4 | $v_{N-1},v_N$ read as skew matrices | yes | throughout | |
| H5 | $\dim U<n$ | yes | only to make $U^\perp\ne0$, i.e. to make the conclusion non-empty | conclusion |
| H6 | $\{v_\alpha\}$ is a **full** orthonormal eigenbasis of $\Lambda^2$, kernel included, orthonormal in the **half-trace** norm | **unstated** | fixes the coefficient in step 1 and makes $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ the object it is | step 1 |
| H7 | $\mathrm{Ric}$ in the normalisation $\mathrm{Ric}_{ij}=\sum_kR_{ikjk}$ | **unstated** | fixes the coefficient; inert for the flatness conclusion | step 1 |
| H8 | $\lambda_\alpha\ne0$ | yes, this is the repair that reached the prose | essential | step 3 |
| H9 | $\operatorname{im}(A+B)=\operatorname{im}A+\operatorname{im}B$ for $A,B\succeq0$, and $\operatorname{im}(v^{\mathsf T}v)=\operatorname{im}v$ for skew $v$ | **unstated** | carries the whole of step 2b | step 2b |
| H10 | $\mathfrak{so}(U)$ is a subalgebra of $\mathfrak{so}(n)$ and $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ is isometric | **unstated and unused** | would carry claim 8, which is never argued | conclusion |
| H11 | $W\ne0$ | unstated | not needed by the proof; needed to say anything about $\dim U$ at $n=4$ | §7 |

**H3 and H5 are the only two hypotheses of the statement that do any work, and each does exactly one thing.** H6, H7, H9 are steps used and never stated. H2 is stated only through the membership $W\in\mathrm{Weyl}_n$ and is never cashed. H10 is the debt.

## 1. The identity, PROVEN

Take $\{e_i\}$ orthonormal in $\mathbb R^n$ and identify $x\wedge y$ with the skew matrix $xy^{\mathsf T}-yx^{\mathsf T}$; this is the identification under which $\varphi_{ab}=E_{ab}-E_{ba}$ and, by the quoted bivector bullet, $\{\varphi_{ab}\}_{a<b}$ is orthonormal in the half-trace pairing.

First the pairing of a skew $v$ against a decomposable. Writing $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$ and using $v^{\mathsf T}=-v$,

$$\langle v,\ xy^{\mathsf T}-yx^{\mathsf T}\rangle=\tfrac12\big(\operatorname{tr}(v^{\mathsf T}xy^{\mathsf T})-\operatorname{tr}(v^{\mathsf T}yx^{\mathsf T})\big)=\tfrac12\big(-y^{\mathsf T}vx+x^{\mathsf T}vy\big)=-y^{\mathsf T}vx,$$

the last step because $x^{\mathsf T}vy$ is a scalar, equal to its own transpose $y^{\mathsf T}v^{\mathsf T}x=-y^{\mathsf T}vx$. So

$$\langle v,\ x\wedge e_i\rangle=-(vx)_i.$$

Now the adjoint definition. $\mathrm{Ric}$ is the adjoint of $h\mapsto h\wedge\mathrm{id}$, and with $(h\owedge g)_{ijkl}=h_{ik}g_{jl}+h_{jl}g_{ik}-h_{il}g_{jk}-h_{jk}g_{il}$ the pairing $\langle R,h\owedge g\rangle$ contracts to a positive multiple of $\sum_{ij}h_{ij}\sum_kR_{ikjk}$. So $\mathrm{Ric}(W)_{ij}=c\sum_kW_{ikjk}$ for one fixed $c>0$, and

$$\mathrm{Ric}(W)(x,x)=c\sum_i\langle W(x\wedge e_i),\ x\wedge e_i\rangle .$$

Insert the spectral decomposition $W=\sum_\alpha\lambda_\alpha v_\alpha\langle v_\alpha,\cdot\rangle$ over the full orthonormal eigenbasis (H6):

$$\mathrm{Ric}(W)(x,x)=c\sum_\alpha\lambda_\alpha\sum_i\langle v_\alpha,x\wedge e_i\rangle^2=c\sum_\alpha\lambda_\alpha\sum_i(v_\alpha x)_i^2=c\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2 .$$

Since $\lVert v_\alpha x\rVert^2=x^{\mathsf T}v_\alpha^{\mathsf T}v_\alpha x$ and each $v_\alpha^{\mathsf T}v_\alpha$ is symmetric, vanishing of the quadratic form for every $x$ is exactly $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$. **The block's identity and its consequence both hold.**

**The one convention question, and it is inert.** The block writes the identity with $c=1$. That is the normalisation $\mathrm{Ric}_{ij}=\sum_kW_{ikjk}$, under which the identity curvature operator on $\Lambda^2$ gives $\mathrm{Ric}=(n-1)\,\mathrm{id}$; [REVIEW_r59.md](../reviews/REVIEW_r59.md) step 3 works in the same one. [conventions.md](../findings/conventions.md) tables "$\mathrm{ric}(I)=\tfrac{n-1}2\mathrm{id}$", which is $c=\tfrac12$, so the identity read against that cell carries a factor $\tfrac12$ on the right. **Nothing in L30 turns on it** (Ricci-flatness is $\mathrm{Ric}=0$, and $c>0$ divides out) but a consumer who lifts the displayed identity into a quantitative estimate will be out by two, and neither site says which $c$ it is in.

**A second normalisation the identity silently needs.** The right-hand side is stated in two different norms under one symbol, $\lVert v_\alpha x\rVert$ is Euclidean on $\mathbb R^n$ while the eigenbasis $\{v_\alpha\}$ is orthonormal in the half-trace norm of $\mathfrak{so}(n)$. Under the plain-Frobenius normalisation that [conventions.md](../findings/conventions.md) flags as the live alternative, the right-hand side doubles. This is H6, and it is unstated.

**A free consistency check the block does not take.** Tracing $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ gives $2\sum_\alpha\lambda_\alpha=0$, i.e. $\operatorname{tr}W=0$, which is where a Weyl tensor already sits. Consistent.

## 2. The image step, both halves, separately

**2a. "the positive and negative sides are the same matrix", PROVEN.** Set

$$P_+:=\sum_{\lambda_\alpha>0}\lambda_\alpha\,v_\alpha^{\mathsf T}v_\alpha,\qquad P_-:=\sum_{\lambda_\alpha<0}(-\lambda_\alpha)\,v_\alpha^{\mathsf T}v_\alpha .$$

Kernel eigenvectors contribute nothing to $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$, so that sum is $P_+-P_-$, and Ricci-flatness is $P_+=P_-$. Each $v^{\mathsf T}v\succeq0$ and each coefficient is positive, so both are positive semidefinite. Correct as written.

**2b. "whose image is contained in $U$, and every eigenvector with nonzero eigenvalue has its image inside $U$", PROVEN, on one step the block never states.** For skew $v$, $\operatorname{im}(v^{\mathsf T}v)=\operatorname{im}v^{\mathsf T}=\operatorname{im}v$; and for $A,B\succeq0$, $\ker(A+B)=\ker A\cap\ker B$, hence $\operatorname{im}(A+B)=\operatorname{im}A+\operatorname{im}B$. Iterating,

$$\operatorname{im}P_-=\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha .$$

Under H3 that sum has at most the two terms $\operatorname{im}v_{N-1}+\operatorname{im}v_N=U$, so $\operatorname{im}P_-\subseteq U$, with equality when both eigenvalues are genuinely negative. Then $P_+=P_-$ gives

$$\sum_{\lambda_\alpha>0}\operatorname{im}v_\alpha=\operatorname{im}P_+=\operatorname{im}P_-\subseteq U,$$

so $\operatorname{im}v_\alpha\subseteq U$ for every $\lambda_\alpha>0$; for $\lambda_\alpha<0$ it holds by the definition of $U$. Both halves stand.

**The unstated step is H9**, the two image identities above. They are elementary, but "an identity among positive semidefinite matrices" is doing no work by itself: the block's word "hence" jumps from $P_+=P_-$ to a statement about images, and the bridge is the PSD image lemma, which appears nowhere.

**One infelicity in the statement, not in the proof.** $U$ is well defined even when the two negative eigenvalues coincide, because $\sum_a v_a^{\mathsf T}v_a$ over an orthonormal basis of a subspace of $\mathfrak{so}(n)$ does not depend on the basis; so the repeated-eigenvalue basis-dependence that [REVIEW_r59.md](../reviews/REVIEW_r59.md) flags for the *ranks* does not touch $U$. But the statement says "with negative eigenvectors $v_{N-1},v_N$", which presupposes exactly two. A Weyl tensor has at least one negative eigenvalue ($\operatorname{tr}W=0$, $W\ne0$), and the case of exactly one leaves $v_{N-1}$ undefined. The argument survives verbatim with $U=\operatorname{im}v_N$; the wording does not.

## 3. $v_\alpha u=0$, and the kernel witness, PROVEN, witness checked

For $u\in U^\perp$ and $\lambda_\alpha\ne0$: $\operatorname{im}v_\alpha\subseteq U$ and $v_\alpha$ skew give $\ker v_\alpha=(\operatorname{im}v_\alpha)^\perp\supseteq U^\perp$, so $v_\alpha u=0$. Then for any $w$, by the pairing formula of §1, $\langle v_\alpha,u\wedge w\rangle=-w^{\mathsf T}v_\alpha u=0$; the terms with $\lambda_\alpha=0$ contribute nothing to $W(u\wedge w)=\sum_\alpha\lambda_\alpha\langle v_\alpha,u\wedge w\rangle v_\alpha$ regardless. So $W(u\wedge w)=0$ for **every** $w\in\mathbb R^n$, which is more than the statement's $w\perp u$ and costs nothing.

**The witness $e_9\wedge e_{10}$ at padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$, checked and correct.** Let $W=\mathrm{pad}(W_{\mathbb{CP}^2})$ with support $\Lambda^2V$, $V=\operatorname{span}(e_1,\dots,e_4)$. The Weyl tensor of $\mathbb{CP}^2$ is self-dual with $\Lambda^2$-spectrum proportional to $(2,-1,-1)$ on $\Lambda^+$ and $0$ on $\Lambda^-$, so its two negative eigenvectors are self-dual two-forms, each of rank $4$, and $U=V$ with $\dim U=4<10$. Now $\varphi_{9,10}=e_9\wedge e_{10}$ lies in $(\Lambda^2V)^\perp$, hence is an eigenvector at $\lambda=0$; and $\varphi_{9,10}\,e_9=-e_{10}\ne0$ while $e_9\perp U$. **So the unqualified "$v_\alpha u=0$ for all $\alpha$" is false at this object, and the repaired qualifier is necessary.** The witness names no $u$; the reader must supply $u\in\{e_9,e_{10}\}$.

**A note on the blockquote, since the brief warns the repair is partial.** The fourth blockquote's closing sentence (*"$v_\alpha u=0$ for all $\alpha$" holds only for $\lambda_\alpha\ne0$*), is now **stale**: the prose already carries the qualifier in bold and the witness beside it. It should be struck as done, not left standing as an outstanding correction.

**The trap in the other direction, checked.** The argument nowhere assumes $\ker W=0$. The sums run over the full eigenbasis and every kernel term contributes zero to $P_\pm$ and to $W(u\wedge w)$. Since L30's own conclusion is that $W$ is a padding (an object with $\ker W\supseteq(\Lambda^2U)^\perp$, of dimension $\binom n2-\binom{\dim U}2$), an argument that needed a trivial kernel would refute its own conclusion. It does not.

## 4. "At most two", used once, and there it is load-bearing

**Where the hypothesis enters.** Exactly one place: identifying $\operatorname{im}P_-=\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$ with the block's $U=\operatorname{im}v_{N-1}+\operatorname{im}v_N$. Steps 1, 3 and the restriction argument never see it. So the brief's suspicion is right: **the hypothesis is used nowhere but in the definition of $U$.**

**The generalisation.** Redefine $U:=\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$. Then §2b's chain reads $\operatorname{im}P_-=U$ by construction and $\sum_{\lambda_\alpha>0}\operatorname{im}v_\alpha=\operatorname{im}P_+=U$, §3 is untouched, and §6 is untouched. The correct statement is therefore:

> Let $W\in\mathrm{Weyl}_n$ and set $U=\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$ over **all** negative eigenvectors. If $\dim U<n$ then $W(u\wedge w)=0$ for every $u\perp U$ and every $w$, and $W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor.

with no count hypothesis at all. The blockquote's *"the block's own three steps give the conclusion verbatim for any number of negative eigenvalues"* is correct.

**But the count cannot simply be deleted, and the blockquote's witness is right about that.** I checked it. Take $V_1=\operatorname{span}(e_1,\dots,e_4)$, $V_2=\operatorname{span}(e_5,\dots,e_8)$ and $W=\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$ on $\mathbb R^8$.

- $W\in\mathrm{Weyl}_8$: pair symmetry and Bianchi are blockwise; $\mathrm{Ric}$ vanishes on $V_1$ and on $V_2$ blockwise, and for $x\in V_1$, $y\in V_2$ the mixed entry $\sum_k\langle W(x\wedge e_k),y\wedge e_k\rangle$ is zero because $W(x\wedge e_k)$ is nonzero only for $e_k\in V_1$, when it lies in $\Lambda^2V_1\perp V_2\wedge V_1$.
- $W$ has **four** negative eigenvalues, two per block.
- Choose $v_{N-1},v_N$ to be the two from the $V_1$ block. Each is a self-dual two-form on $V_1$, hence of rank $4$, so $U=V_1$ and $\dim U=4<8$.
- $e_5\perp U$, and $W(e_5\wedge e_6)$ is the $V_2$ block applied to $e_5\wedge e_6$. Its self-dual half is nonzero and the $V_2$ block's self-dual spectrum is $(2,-1,-1)$ scaled, containing no zero, so $W(e_5\wedge e_6)\ne0$.

So with more than two negative eigenvalues and $U$ built from a chosen pair, the conclusion is **false**. The hypothesis is inert to the *steps* and necessary to the *statement as written*; the repair is the redefinition, and it has **not** been applied, the statement in [stratum-two-negative.md](../findings/stratum-two-negative.md) and both copies in [results.md](../results.md) still carry "at most two" and the two-term $U$.

**Verdict on this item: the lemma as written is true; the blockquote's correction is a strengthening, not a defect.** One caveat on the blockquote's own phrasing: it calls the hypothesis "inert", which reads as removable. It is removable only together with the redefinition, and the blockquote says so in its next clause, but the headline and the [INDEX-results.md](../findings/INDEX-results.md) row both lead with "inert", which is the half a hurried reader will take.

## 5. "With the same norm and the same $\theta$", HYPOTHESIS-DEBT

**It is not proved in the block.** The proof runs identity → images → $W(u\wedge w)=0$ → Ricci-flatness of the restriction, and stops. The words "norm" and "$\theta$" do not appear in it. The development form thirty-four lines above asserts the padding conclusion and never mentions either quantity. **This is the clause the lemma exists for**, the block's own opening line says so: *"Needed because the sharp stratum's members turn out to be paddings, and that is what lets a bound proved in low dimension govern every $n$."* A padding reduction that does not carry $\theta$ carries nothing.

**What would have to be shown.** Write $m=\dim U$, $\iota:\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$, and let $W'$ be the operator on $\Lambda^2U$ that the block produces, so $W=\iota W'\iota^{\mathsf T}$.

1. **The norm.** $\lVert\iota W'\iota^{\mathsf T}\rVert_{\mathcal W_n}=\lVert W'\rVert_{\mathcal W_m}$. What this needs, and what nothing in the block supplies: that $\iota$ is an isometry for the record's half-trace pairing, i.e. that an orthonormal basis of $\Lambda^2U$ inside $\Lambda^2\mathbb R^n$ is an orthonormal basis of $\Lambda^2$ of the abstract $m$-space; and the two-sided support statement $W|_{(\Lambda^2U)^\perp}=0$ **and** $\operatorname{im}W\subseteq\Lambda^2U$. The block proves the first half of the support statement and gets the second only through self-adjointness, which it does not invoke.
2. **The cubic.** $P(\iota W'\iota^{\mathsf T})=P(W')$, i.e. $\langle W,W^2\rangle$ and $\langle W,W^\#\rangle$ each agree with their $\mathcal W_m$ counterparts. The $W^2$ term needs only the support statement. The $\#$ term needs that the structure constants $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ computed in $\mathfrak{so}(n)$ agree with those computed in $\mathfrak{so}(U)$ for the eigenvectors carrying nonzero eigenvalue.
3. Then $\theta=P/\lVert\cdot\rVert^3$ follows from 1 and 2.

**Is $\Lambda^2U=\mathfrak{so}(U)$ being a Lie subalgebra enough?** It is enough for item 2's $\#$ half and for nothing else. Given the block's own §2b (every $v_\alpha$ with $\lambda_\alpha\ne0$ lies in $\mathfrak{so}(U)$), closure of the bracket keeps $[v_\alpha,v_\beta]$ inside $\mathfrak{so}(U)$, so by bilinearity of $\#$ the whole of $W^\#$ is supported there and no $\gamma$ outside $\mathfrak{so}(U)$ can enter $\langle W,W^\#\rangle$. It says nothing about item 1, which is an isometry claim about the inner product rather than the bracket, and nothing about the $W^2$ half of item 2. **So the blockquote's "two lines: the norm from orthonormality, and $\theta$ because $\Lambda^2U=\mathfrak{so}(U)$ is a Lie subalgebra" names the right two ingredients, and it is a sketch of a proof, not a proof, and it is in a blockquote rather than in the block.**

**Does $Q$ restricted to the padded tensor agree with $Q$ computed in $\mathcal W_m$?** For $\theta$ the pairing $\langle W,Q(W)\rangle$ is all that is needed, and that is item 2, strictly weaker than the operator identity $Q(\iota W'\iota^{\mathsf T})=\iota Q(W')\iota^{\mathsf T}$ that [conventions.md](../findings/conventions.md) asserts as "Padding commutes with $Q$". The stronger form is not needed here and is not proved here either.

**Where the record's support for this actually sits, having looked.** Three places, none of them a proof in the block:

- [conventions.md](../findings/conventions.md) line 124, "**Padding commutes with $Q$**, and preserves both the norm and $\theta$", a bullet in the conventions file with **no source column and no citation**, in a file whose own standfirst says a convention is quoted rather than proved.
- [REVIEW_r59.md](../reviews/REVIEW_r59.md) Claim 2 step 6, which the blockquote names. It is one structural sentence, "for a 'new' pair $a=(i,n)$, $[\varphi_a,\varphi_m]$ lands in the span of new pairs whenever $m$ is old, so $c_{a,m,p}=0$ for old $m,p$ and the sharp has no off-block rows at all", followed by measurements ("theta identical to 12 digits"). That is the subalgebra observation in coordinates plus numerics, in a review, for one pad step at a time.
- Downstream consumers that already spend it: [target.md](../findings/target.md) ("padding preserves $\theta$"), [graded-half.md](../findings/graded-half.md) ("The bound itself survives padding, since padding preserves $\theta$"), [LEDGER.md](../findings/LEDGER.md), [second-order.md](../findings/second-order.md).

**No numbered result on this record states that padding preserves the norm and $\theta$.** I searched [INDEX-results.md](../findings/INDEX-results.md) and [conventions.md](../findings/conventions.md) for one and found none. **The correct finding is that this clause has no argument on file**, and the debt is: a numbered result stating items 1–3 above, proved, that L30 and its four downstream consumers can cite. I do not supply it here.

**And one live warning against assuming the general form.** [plan-verification.md](../plan-verification.md)'s L04 row and [ATTEMPTS.md](../ATTEMPTS.md) record that *"Zero-padding preserves everything" is false in the part that matters: $\theta$ survives, membership does not*. So the record already knows the padding-invariance slogan is over-broad in at least one direction, which is a reason to want the exact statement written down rather than a reason to doubt this one.

## 6. Ricci-flatness of the restriction, PROVEN; membership is a GAP

**The reason given is correct.** Choose an orthonormal basis of $\mathbb R^n$ adapted to $U\oplus U^\perp$. For $x\in U$,

$$\mathrm{Ric}(W)(x,x)=c\sum_{e_i\in U}\langle W(x\wedge e_i),x\wedge e_i\rangle+c\sum_{e_i\in U^\perp}\langle W(x\wedge e_i),x\wedge e_i\rangle .$$

Every term of the second sum has $x\wedge e_i\in U\wedge U^\perp$, and §3 gives $W(x\wedge e_i)=0$ there. So the first sum, which is exactly $\mathrm{Ric}(W')(x,x)$ computed inside $U$, equals $\mathrm{Ric}(W)(x,x)=0$. Polarising gives the full bilinear form. **"the terms of $\mathrm{Ric}$ involving directions outside $U$ vanish with $W$" is right, and it is the whole of the reason.**

**The gap.** "$W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor" needs three things of $W'$: the pair symmetry, the first Bianchi identity on $\Lambda^4U$, and Ricci-flatness. The block argues only the third. The first two are inherited ($W'$ is a restriction of $W$ to components with all four indices in $U$) but the block never says so, and [REVIEW_r59.md](../reviews/REVIEW_r59.md) step 5, which the block was written from, does: *"Bianchi is inherited, and $\mathrm{Ric}'_{ij}=\mathrm{Ric}_{ij}-R_{iuju}=0$."* **A sentence that was in the source review is missing from the block.**

## 7. Scope, endpoint by endpoint

First, what the disputed sentences are *about*. Neither is the range of validity of L30. The block's paragraph reads: *"the rank-sum form fails to apply at padded $W_{\mathbb{CP}^2}$ for $n=6,7,8$, where the ranks are $4+4=8\ge n$ while $\dim U=4$ and the conclusion holds"*, and the development form's is *"the rank-sum form misses padded $W_{\mathbb{CP}^2}$ below $n=9$"*. **Both are describing the window in which the invariant hypothesis $\dim U<n$ bites while the rank-sum criterion $r_1+r_2<n$ does not.** At padded $W_{\mathbb{CP}^2}$ the two negative eigenvectors are self-dual two-forms of rank $4$, so $r_1+r_2=8$ and $\dim U=4$; the window is therefore $\{n:\dim U<n\le r_1+r_2\}=\{n:4<n\le8\}=\{5,6,7,8\}$.

**$n=4$, the development form's endpoint is wrong.** Here padded $W_{\mathbb{CP}^2}$ is $W_{\mathbb{CP}^2}$ itself and $\dim U=4=n$, so $U^\perp=0$ and L30's hypothesis $\dim U<n$ **fails**; equivalently the common kernel of the negative eigenspace is zero, so the development form's own invariant hypothesis fails too. The sentence's implicit claim (that the invariant form still reaches the object where the rank-sum form does not), is **false at $n=4$**.

*The blockquote is right on substance and one word too strong.* Its literal words are *"'below $n=9$', which wrongly includes $n=4$ where $\dim U=n$"*. Read as bare arithmetic the development sentence is not false at $n=4$: its stated conclusion is "$W$ vanishes identically on an $(n-1)$-dimensional subspace of $\Lambda^2$", and $W_{\mathbb{CP}^2}$ does kill its three-dimensional anti-self-dual space, which is $n-1=3$. So the conclusion "holds anyway" at $n=4$ by accident, for a reason the lemma is not supplying. The defect is that the hypothesis is absent, not that the sentence's last clause is untrue.

**And $\dim U=n$ at $n=4$ is a theorem, not a coincidence.** For any $0\ne W\in\mathrm{Weyl}_4$ with at most two negative eigenvalues: $W$ commutes with the Hodge star, so it is block diagonal on $\Lambda^+\oplus\Lambda^-$ with $W^\pm$ traceless symmetric on three dimensions; a nonzero traceless symmetric $3\times3$ matrix has a negative eigenvalue. If both blocks are nonzero there is one negative eigenvector in each, and self-dual and anti-self-dual two-forms are nondegenerate, so each has image $\mathbb R^4$. If one block vanishes, both negative eigenvectors are (anti-)self-dual and the same applies. The only remaining case is a negative eigenvalue shared between the blocks, giving decomposable eigenvectors $\omega^+\pm\omega^-$ whose images are a complementary pair of $2$-planes, again spanning $\mathbb R^4$. **So $\dim U=4=n$ at $n=4$ whenever $W\ne0$: L30 is true at $n=4$ and carries no content there.**

**$n=5$, the block's endpoint is wrong.** Padded $W_{\mathbb{CP}^2}$ lies in $\mathcal W_5$ ($\dim\mathcal W_5=35$), with $\dim U=4<5$, $r_1+r_2=8\ge5$, and L30's conclusion holding. So $n=5$ belongs to the window and the block's list $6,7,8$ omits it. [REVIEW_r59.md](../reviews/REVIEW_r59.md) says the same in its own words, *"the criterion applies only from $n=9$, even though the tensor is padded at every $n\ge5$"*.

**$n=8$ and $n=9$, both versions agree and both are right.** At $n=9$, $r_1+r_2=8<9$, so the rank-sum criterion applies and the window closes at $8$.

**Verdict: the blockquote's $5,6,7,8$ is the correct window, and each of the two versions in the file has exactly one endpoint wrong.** Neither has been repaired.

**A finding the blockquote does not carry.** [INDEX-results.md](../findings/INDEX-results.md) row 30 compresses this to *"Scope is $n=5\ldots8$, each existing version having one endpoint wrong."* Read as the lemma's scope (which is how a row in the results index reads) that is wrong and it guts the lemma. **L30 holds at every $n\ge4$ and has content at every $n\ge5$ with no upper bound**, and the development form thirty-four lines above the block consumes it at $n=12$ ("the number of positive eigenvalues is at most $N-n-1$, at $n=12$, at most $53$ of $66$"), and the block's own reason for existing is to govern *every* $n$. Applying the discrepancy protocol: the row is defensible as shorthand, since its next clause ties "scope" to the two endpoint-wrong sentences; so I record it as a **wording defect that misleads on the lemma's range**, not as a false statement. It should read "the scope of the rank-sum remark is $n=5\ldots8$".

**$n=6+2\sqrt7\approx11.2915$.** Checked for dependence: L30 has no threshold in $n$ at all, no term whose sign turns over, and no constant compared against a function of $n$. The crossover is not consumed here and cannot be.

## 8. The remaining traps, by name

- **An imported theorem whose hypotheses were never checked.** There is none. The block imports nothing: the only external input is the definition of $\mathrm{Ric}$ as the adjoint of $\cdot\wedge\mathrm{id}$, which is a convention rather than a theorem. The failure mode the brief names (a cited theorem assuming a unital algebra where $\mathcal W_n$ has no unit), cannot arise in this block. The one place an import would be needed is the $\theta$ clause, and there the record has no theorem to import (§5).
- **A claim proven on a subfamily and used in general.** The block itself has none. Its neighbourhood does: the development form's $\epsilon_{\min}$ material is explicitly sampled ("Across $600$ orthonormal pairs at $n=12$"), and it says so in bold. L30 does not consume it.
- **A universal claim with no witness.** "for every $u\perp U$" and "for every $w$" are both witnessed at padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$, which is the object the block itself names.
- **Symbol collisions from [conventions.md](../findings/conventions.md).** $N$ is $\binom n2$ throughout and never $N_v$; $v_\alpha$ is an eigenvector of $W$ on $\Lambda^2$ read as a skew matrix, matching the $v_k$ of the $g_k$ cell; $\lambda$ is the $\Lambda^2$ spectrum and never the Einstein constant or any of the three $\lambda_{\max}$ senses; $\mathring R$ does not occur in the block; **$q$ and $r$ do not occur in the block at all**, so the two-senses-each warning for this file is not triggered by L30, the block writes $\dim U$ where line 33 of the same file writes $r$ for the support dimension, which is the safe choice. $U$ is defined locally and is tabled nowhere. $x$ is a vector of $\mathbb R^n$, matching the file's non-L33 usage.
- **One collision that is live.** The development form writes "with negative eigenspace $\mathfrak m$", and [conventions.md](../findings/conventions.md) records that "$\mathfrak m$ carries three incompatible senses across the record", the $E_{\min}$ sense, [L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and [target.md](../findings/target.md)'s symmetric-pair odd part. The development form means the second and says nothing. It is unambiguous from the sentence, and it is exactly the class of omission the conventions file exists to stop.
- **A hypothesis stated but never used.** H3 ("at most two"), §4: used once, in the definition of $U$, and load-bearing there. H5 ($\dim U<n$), used once, to make $U^\perp$ nonempty. Nothing else in the statement is idle.
- **A step using a hypothesis never stated.** Three: H6 (full orthonormal eigenbasis in the half-trace norm), H7 (the $\mathrm{Ric}$ normalisation), H9 (the PSD image lemma). All three are true and none is written down.
- **The block's closing "Gate 2 passed, both reviewers independently".** The first blockquote records that this was contradicted by [INDEX-results.md](../findings/INDEX-results.md)'s own row, "which recorded no verdict until now". Row 30 now carries the CONFIRMED verdict with [r589](../reviews/REVIEW_r589.md) and [r590](../reviews/REVIEW_r590.md), so the clause is supported today. That blockquote can be struck.

## 9. What would break it, and what I did to look

**The object that would falsify the statement.** A $W\in\mathrm{Weyl}_n$ with at most two negative eigenvalues and $\dim U<n$ such that either

1. some $u\perp U$ and some $w$ have $W(u\wedge w)\ne0$; or
2. $W$ is supported on $\Lambda^2U$ but its core $W'\in\mathcal W_{\dim U}$ has $\lVert W'\rVert\ne\lVert W\rVert$ or $\theta(W')\ne\theta(W)$.

**Horn 1 is closed by the derivation above, in contrapositive.** $W(u\wedge w)\ne0$ requires some $\alpha$ with $\lambda_\alpha\ne0$ and $\langle v_\alpha,u\wedge w\rangle=-w^{\mathsf T}v_\alpha u\ne0$, hence $v_\alpha u\ne0$, hence $u\notin\ker v_\alpha=(\operatorname{im}v_\alpha)^\perp$, hence $\operatorname{im}v_\alpha\not\subseteq U$, contradicting $\operatorname{im}P_+=\operatorname{im}P_-\subseteq U$. There is no room for such an object.

**Horn 2 is where the debt lives, and it is the one I could not close from the record.** Such an object would need the inclusion $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ to fail to be an isometry for the record's half-trace pairing, or the structure constants of $\mathfrak{so}(U)$ to differ from those it inherits from $\mathfrak{so}(n)$. **No proof that neither happens is on this record**, and until one is, the falsifier for horn 2 is not excluded by anything in [stratum-two-negative.md](../findings/stratum-two-negative.md).

**A near-falsifier that is real, for the statement one word weaker.** Drop "at most two" without redefining $U$ and $\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$ on $\mathbb R^8$ breaks the conclusion, as §4 exhibits in closed form. This is why the count cannot be deleted on its own.

**What I did to look.** Read the block, the development form thirty-four lines above it, the two entries in [results.md](../results.md), row 30 of [INDEX-results.md](../findings/INDEX-results.md), and [conventions.md](../findings/conventions.md) end to end. Searched [conventions.md](../findings/conventions.md) and [INDEX-results.md](../findings/INDEX-results.md) for a numbered result on padding and found none; traced every occurrence of "padding preserves" across [findings/](../findings/), [ATTEMPTS.md](../ATTEMPTS.md) and [plan-verification.md](../plan-verification.md) and found four consumers and no proof. Read [REVIEW_r59.md](../reviews/REVIEW_r59.md) Claim 2 in full, the named carrier of the $\theta$ step. Checked $n=4$ and $n=5$ by hand from the $\Lambda^\pm$ splitting and from $\dim\mathcal W_m$. Constructed the $\mathbb R^8$ and $\mathcal W_{10}$ witnesses in closed form and verified their Weyl membership by hand. **No script, no Sage, no evaluation of any kind was run.**

## Verdict

**HYPOTHESIS-DEBT.**

The statement of L30 is true in every clause, including the one the block does not argue, and the six steps that are argued are all correct, the identity, both halves of the image step, the $\lambda_\alpha\ne0$ conclusion with its witness, and the Ricci-flatness of the restriction. What the block does not have is an argument for **"with the same norm and the same $\theta$"**. That clause is the reason the lemma is in the record, it has no proof in [stratum-two-negative.md](../findings/stratum-two-negative.md), no numbered result behind it anywhere on the record, and its only carriers are an unsourced bullet in [conventions.md](../findings/conventions.md) and a one-sentence structural sketch plus numerics in [REVIEW_r59.md](../reviews/REVIEW_r59.md). Naming what would have to be proved is §5, items 1–3.

Standing beside it: a **GAP** at "the restriction lies in $\mathrm{Weyl}_{\dim U}$", where pair symmetry and the first Bianchi identity are needed and never mentioned though the source review had them; three unstated steps (H6, H7, H9); the unapplied redefinition of $U$ that would let "at most two" go; two scope sentences with one wrong endpoint each; and a stale blockquote that should be struck.
