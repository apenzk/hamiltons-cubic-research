# Verifier v164, Lemma L33, one eigenvalue of one sign forces the tensor to vanish

Cold from the definitions in [conventions.md](../findings/conventions.md) and the passages in [BRIEF_L33.md](BRIEF_L33.md). **No numerical work of any kind was done**: no script, no Sage, no Python, no floating-point evaluation. Every object below is exhibited in closed form and every value is exact rational or exact radical arithmetic done by hand. The operator identity the proof runs on was derived from scratch rather than taken on the block's citation, and the two witnesses named in the block were rebuilt independently. Log: [agent_logs/verify-L33-v164.log](../agent_logs/verify-L33-v164.log).

## The claim table

| # | Claim as written | Verdict |
| --- | --- | --- |
| 1 | $\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W$ on $\mathrm{Weyl}_m$ | **CONFIRMED**, derived in full, §3 |
| 2 | First Bianchi is load-bearing; Ricci-flatness only deletes a correction | **CONFIRMED**, each hypothesis used exactly once, and at an identified step, §3.3 |
| 3 | The $\mathop{\mathrm{tr}}(u^2v_\alpha^2)$ term is what Ricci-flatness annihilates | **CONFIRMED**, it is the term literally present, §3.2 |
| 4 | $\Lambda^4$ is Ricci-flat and carries $-4$ rather than $+2$ | **CONFIRMED**, and at every $m\ge4$, not only $m=4$, §3.4 |
| 5 | $\langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2$ | **CONFIRMED**, §4 |
| 6 | $N_v\succeq0$ with $\ker N_v=v^\perp\cap\mathfrak z(v)$ | **CONFIRMED**, §4 |
| 7 | $\ker N_x\subseteq\bigcap_i\ker N_{y_i}$ from positive semidefiniteness | **CONFIRMED**, and it does need every term on one side, §5 |
| 8 | $\mathfrak c=0$ would force $m\le3$, so L32's hypothesis is discharged | **CONFIRMED**, $\mathfrak c=0\iff m\in\{2,3\}$, §6.1 |
| 9 | $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$ holds for the $x$ this proof feeds it, degenerate $x$ included | **CONFIRMED**, I ran the degenerate reduction myself, §6.2 |
| 10 | L32's degenerate branch as written | **HYPOTHESIS-DEBT against L32**, one sentence carries the case L33 needs, §6.3 |
| 11 | $y_i=0$, $W=\pm x\otimes x$, Ricci-flatness forces $x=0$ | **CONFIRMED**, elliptical but sound, §7 |
| 12 | The exception is realised | **CONFIRMED**, the padded $W_{\mathbb{CP}^2}$ family, at every $m\ge4$ including odd $m$, §8.1 |
| 13 | The exception is complete | **CONFIRMED**, rank $4$ with equal singular values is the only root-proportional pattern, §8.2 |
| 14 | *"In particular no rank-$3$ $\mathrm{Weyl}_m$ tensor at even $m\ge6$ has a nondegenerate minority-side eigenvector"* | **CONFIRMED**, and both the evenness and the $m\ge6$ are necessary, §9 |
| 15 | The result covers odd $m$ | **CONFIRMED**, §10.2 |
| 16 | The result covers degenerate minority eigenvectors | **CONFIRMED**, §6.2 |
| 17 | The $\mathrm{Weyl}_4$ witness $W^+=W^-=\mathop{\mathrm{diag}}(2,-1,-1)$ | **CONFIRMED**, rebuilt cold, §11.1 |
| 18 | [Lemma L34](../findings/stratum-two-negative.md) supplies a second witness at $m=8$ | **CONFIRMED**, §11.2 |
| 19 | *"with multiplicity"* reaches [results.md](../results.md) and [report/](../report/) | **CONFIRMED at all three statement sites**; the *heading* still carries the false reading at five, §11.3 |
| 20 | The identity *"is classical and is cited, not claimed"*, Besse §1.143 | **UNHELD CITATION**, no Besse in [references/](../references/), and §1.143 is the Lichnerowicz Laplacian on **symmetric** $2$-tensors, §12.1 |
| 21 | [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/) gives *"the eigenbasis rewriting and not the evaluation"* | **CONFIRMED against the source text**, §12.2 |
| 22 | The $\mathring R$ of the quoted Weitzenböck display | **DISCREPANCY, notational**, it is the $ikjl$ order, which [conventions.md](../findings/conventions.md) settles against, §13.1 |
| 23 | $N_v$ against [conventions.md](../findings/conventions.md)'s tabled $N=\binom n2$ | **COLLISION, untabled**, both senses live in this one file, §13.2 |
| 24 | $\ker W\ne0$ | **CLEARED**, the sum is supported on the nonzero spectrum, §10.1 |
| 25 | The gap between what is proven and what is used | **L33 has no load-bearing consumer left**, §14 |

## One-line summary

**PROVEN.** The operator identity, the semidefinite splitting, the kernel inclusion, the [L32](../findings/isotropy-cap.md) step and the closing step all hold as written and I rebuilt each from the definitions; the ambiguity repair reaches every site that states the lemma; what is owed is a citation the record does not hold, a one-sentence branch in the imported lemma, and two notational collisions.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

> **The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** The inner product is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix.

> **A skew matrix's norm**, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$. Equivalent to $\mathop{\mathrm{tr}}(v^2)=-2$ above.

> **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal.

> **The Killing form of $\mathfrak{so}(n)$** is $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$, with $\mathop{\mathrm{tr}}(v^2)=-2$ for a unit bivector, so $\kappa=2(n-2)$ in an orthonormal basis. **Killing constants come from the definition, never from an index convention.**

> $\dim\mathcal W_n$ | $\frac{n(n-3)(n+1)(n+2)}{12}$, $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$

> $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$

> **The record's convention is Li's** … With $u\odot v=u\otimes v+v\otimes u$ … this is in matrix form $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$

> $\mathring W$ acts on $S^2_0$, and **the index order is load-bearing**: $W_{ikjl}$ in place of $W_{iklj}$ negates $\mathring W$ and flips the sign of the bi-spectral identity's $-\tfrac12$ term.

Two identifications I fix here because the block uses them silently, both forced by the quoted conventions. With $\{\varphi_{ab}\}_{a<b}$ orthonormal and $(R\omega)_{ij}=\tfrac12\sum_{kl}R_{ijkl}\omega_{kl}$, the spectral form $R=\sum_\alpha\lambda_\alpha v_\alpha\otimes v_\alpha$ has components $R_{ijkl}=\sum_\alpha\lambda_\alpha(v_\alpha)_{ij}(v_\alpha)_{kl}$, and the Ricci contraction $\mathrm{Ric}_{kl}=\sum_iR_{ikil}$ reads $\mathrm{Ric}=-\sum_\alpha\lambda_\alpha v_\alpha^2$. Both check at $R=\mathrm{Id}$: $R_{ikil}=\delta_{ii}\delta_{kl}-\delta_{il}\delta_{ki}$ sums to $(n-1)\delta_{kl}$, and $\sum_{a<b}\varphi_{ab}^2=-(n-1)I$.

## 1. The hypothesis inventory

**A pass with no inventory is not a pass, so here is the whole of it.**

### 1.1 What the statement grants

| hypothesis | what it gives | used where |
| --- | --- | --- |
| $W\in\mathrm{Weyl}_m$, **symmetric operator on $\Lambda^2\mathbb R^m$** | an orthonormal eigenbasis $\{v_\alpha\}$ of $\Lambda^2$ with real $\lambda_\alpha$; $W=\sum_\alpha\lambda_\alpha v_\alpha\otimes v_\alpha$ | the whole proof; the rescaling in particular needs the $y_i$ mutually orthogonal and orthogonal to $x$ |
| $W\in\mathrm{Weyl}_m$, **first Bianchi** | $W_{abcd}+W_{acdb}+W_{adbc}=0$ | §3.3, exactly once, to evaluate $X=\sum W_{abcd}u_{ac}u_{bd}$ |
| $W\in\mathrm{Weyl}_m$, **Ricci-flat** | $\sum_\alpha\lambda_\alpha v_\alpha^2=0$ | twice: §3.2 to delete $\mathop{\mathrm{tr}}(\mathrm{Ric}\,u^2)$, and §7 to close |
| $W\in\mathrm{Weyl}_m$, trace-free | $\sum_\alpha\lambda_\alpha=0$ | implied by Ricci-flatness; used only to say a nonzero $W$ has both signs |
| **one-dimensional eigenspace on one side** | the whole minority spectrum is a single $\lambda_x$ with a single eigenvector $x$ | §5, the rescaling to $N_x=\sum_iN_{y_i}$ |
| $x$ **not a multiple of a complex structure on a $4$-dimensional subspace** | L32's exception is off | §6, the L32 step |

**Every stated hypothesis is used.** There is no decorative hypothesis here.

### 1.2 *"One-dimensional eigenspace on one side"* against *"one distinct eigenvalue"*

These part exactly at multiplicity. The written statement pins the first by the appositive *"exactly one eigenvalue counted **with multiplicity**"*, and that appositive is load-bearing twice over:

- it is what makes the rescaling of §5 produce **one** $N_x$ on the left. Under the distinct-value reading a two-dimensional minority eigenspace puts two terms on the left, and $N_{x_1}+N_{x_2}=\sum_iN_{y_i}$ gives $\ker N_{x_1}\cap\ker N_{x_2}\subseteq\bigcap_i\ker N_{y_i}$, a strictly weaker containment on a strictly smaller space. **So the false reading breaks the proof at its first step, not only at its conclusion.**
- it is what the counterexamples of §11 attack.

### 1.3 What the imported results require

| import | its hypotheses | checked against this object |
| --- | --- | --- |
| [Lemma L32](../findings/isotropy-cap.md) | $x\in\mathfrak{so}(m)$ nonzero; **$\mathfrak c\ne0$** (the repair, `REFUTED AS STATED` without it); $x$ not a $4$-plane complex-structure multiple | $x\ne0$ ✔ (it is an eigenvector for a nonzero eigenvalue); $\mathfrak c\ne0$ ✔ by §6.1; the exception ✔ is L33's own hypothesis |
| [Petersen–Wink Prop. 1.6](../references/petersen-wink-2019-bochner-technique/) | $R:\Lambda^2V\to\Lambda^2V$ an algebraic curvature operator, $\{\Xi_\alpha\}$ an eigenbasis | ✔, PW's `algebraic curvature tensor` is $\mathrm{Sym}^2_B(\Lambda^2V)$, their line 186, and $\mathrm{Weyl}_m\subset\mathrm{Sym}^2_B$ |
| Besse, *Einstein Manifolds* §1.143 | unknown, **the source is not on the record** | §12.1 |

## 2. Quantifier order and scope

The statement is: *for every* $W\in\mathrm{Weyl}_m$ *and every* $m$, if the minority side is a single eigenvalue with multiplicity one and its eigenvector avoids the exception, then $W=0$. The conclusion is about $W$; the hypothesis names an $x$ that is determined by $W$ up to scale, so no quantifier is dangling. The *"in particular"* is a separate universal over rank-$3$ tensors at even $m\ge6$ and is checked in §9.

## 3. The operator identity, derived

### 3.1 The bracket norm

For $u,v\in\mathfrak{so}(m)$, with $P=vu$, $Q=uv$ and $\lVert X\rVert^2=\tfrac12\sum_{ij}X_{ij}^2$:

$$\sum_{ij}P_{ij}^2=\mathop{\mathrm{tr}}(u^{\mathsf T}v^{\mathsf T}vu)=\mathop{\mathrm{tr}}(v^2u^2),\quad\sum_{ij}Q_{ij}^2=\mathop{\mathrm{tr}}(u^2v^2),\quad\sum_{ij}P_{ij}Q_{ij}=\mathop{\mathrm{tr}}(uvuv),$$

so

$$\lVert[v,u]\rVert^2=\mathop{\mathrm{tr}}(u^2v^2)-\mathop{\mathrm{tr}}(uvuv).$$

**The term the block names is the term that is literally there.**

### 3.2 The first term is the Ricci term

$$\sum_\alpha\lambda_\alpha\mathop{\mathrm{tr}}(u^2v_\alpha^2)=\mathop{\mathrm{tr}}\Big(u^2\sum_\alpha\lambda_\alpha v_\alpha^2\Big)=-\mathop{\mathrm{tr}}(\mathrm{Ric}\,u^2),$$

by the identification fixed in §0. Ricci-flatness kills it and nothing else. ✔ claim 3.

### 3.3 The second term is where first Bianchi enters

$$\sum_\alpha\lambda_\alpha\mathop{\mathrm{tr}}(uv_\alpha uv_\alpha)=\sum_{ijkl}W_{jkli}u_{ij}u_{kl}=-\sum_{abcd}W_{abcd}u_{ad}u_{bc}=\sum_{abcd}W_{abcd}u_{ac}u_{bd}=:X,$$

the last step by antisymmetry of $W$ in its final pair. Now contract first Bianchi $W_{abcd}+W_{acdb}+W_{adbc}=0$ against $u_{ac}u_{bd}$, writing $X+Y+Z=0$:

- $Y=\sum W_{acdb}u_{ac}u_{bd}=-\sum W_{acbd}u_{ac}u_{bd}=-4\langle u,Wu\rangle$, since $\langle u,Wu\rangle=\tfrac14\sum W_{ijkl}u_{ij}u_{kl}$;
- $Z=\sum W_{adbc}u_{ac}u_{bd}=-\sum W_{pqrs}u_{ps}u_{qr}=X$, by the same final-pair antisymmetry.

Hence $2X-4\langle u,Wu\rangle=0$, that is $X=2\langle u,Wu\rangle$. **Neither $Y$ nor $Z$ used Bianchi; only the closure $X+Y+Z=0$ did.** Collecting,

$$\sum_\alpha\lambda_\alpha\lVert[v_\alpha,u]\rVert^2=-\mathop{\mathrm{tr}}(\mathrm{Ric}\,u^2)-2\langle u,Wu\rangle,$$

and since $\mathrm{ad}(v)$ is skew-adjoint, $\langle u,\mathcal A(W)u\rangle=-\sum_\alpha\lambda_\alpha\lVert[v_\alpha,u]\rVert^2$ with $\mathcal A(W)=\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2$. So in general

$$\mathcal A(R)=2R-(\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}),$$

using $\langle u,\mathrm{Ric}\,u+u\,\mathrm{Ric}\rangle=-\mathop{\mathrm{tr}}(\mathrm{Ric}\,u^2)$, and on $\mathrm{Weyl}_m$ the correction vanishes and $\mathcal A(W)=2W$. Both sides are quadratic forms of symmetric operators, so equality of the forms is equality of the operators. ✔ claims 1 and 2. The block's display $\mathcal A(R)=2R-(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric})$ is exactly this.

Two independent checks of the general formula, both exact and by hand:

- **$R=\mathrm{Id}$.** $\sum_A\mathrm{ad}(\varphi_A)^2$ is Casimir, and its trace is $\binom n2\cdot(-2(n-2))$ by the quoted Killing normalisation, so $\mathcal A(\mathrm{Id})=-2(n-2)\mathrm{Id}$. The formula gives $2-2(n-1)=-2(n-2)$. ✔
- **$m=4$, $W^+=\mathop{\mathrm{diag}}(2,-1,-1)$, $W^-=0$.** In an orthonormal basis $a_1,a_2,a_3$ of $\Lambda^+$, $[a_1,a_2]=-\sqrt2\,a_3$ from $\varphi$-brackets, so $\mathrm{ad}(a_1)^2=\mathop{\mathrm{diag}}(0,-2,-2)$ on $\Lambda^+$ and $0$ on $\Lambda^-$. Then $\mathcal A(W)=2\mathop{\mathrm{diag}}(0,-2,-2)-\mathop{\mathrm{diag}}(-2,0,-2)-\mathop{\mathrm{diag}}(-2,-2,0)=\mathop{\mathrm{diag}}(4,-2,-2)=2W$ on $\Lambda^+$, and $0=2W$ on $\Lambda^-$. ✔

### 3.4 The $\Lambda^4$ witness, checked and generalised

For $R$ in the $\Lambda^4$ summand of $\mathrm{Sym}^2(\Lambda^2)$, $R_{ijkl}$ is totally antisymmetric.

- **Ricci-flat**: $\mathrm{Ric}_{kl}=\sum_iR_{ikil}=0$, every term having a repeated index. ✔
- **Eigenvalue $-4$**: $R_{acdb}$ and $R_{adbc}$ are $3$-cycles of $R_{abcd}$ on the last three slots, hence even permutations, so the Bianchi sum is $3R_{abcd}$ rather than $0$ and $X+Y+Z=3X$. With $Y=-4\langle u,Ru\rangle$ and $Z=X$ unchanged (neither used Bianchi), $3X=2X-4\langle u,Ru\rangle$, so $X=-4\langle u,Ru\rangle$ and $\mathcal A(R)=-4R$.

**So the witness holds at every $m\ge4$, not only where the block's language suggests $m=4$.** Cross-checked at $m=4$ by an independent route: $R=*$, the Hodge star, is $+1$ on $\Lambda^+$ and $-1$ on $\Lambda^-$; $\sum_i\mathrm{ad}(a_i)^2$ annihilates $\Lambda^-$ and is $-4$ on $\Lambda^+$, so $\mathcal A(*)=-4\Pi_++4\Pi_-=-4\,*$. ✔ claim 4. Ricci-flatness alone therefore does **not** give $\mathcal A(R)=2R$, and the block's account of which hypothesis does which work is exact.

## 4. $N_v$, by hand

$N_v=2\,v\otimes v-\mathrm{ad}(v)^2$ is symmetric, $v\otimes v$ is, and $\mathrm{ad}(v)^2$ is, $\mathrm{ad}(v)$ being skew. Skew-adjointness itself: for skew $u,v,w$, $\langle[v,u],w\rangle=-\tfrac12\mathop{\mathrm{tr}}([v,u]w)=\tfrac12\mathop{\mathrm{tr}}(u[v,w])=-\langle u,[v,w]\rangle$. Hence

$$\langle u,N_vu\rangle=2\langle v,u\rangle^2-\langle u,[v,[v,u]]\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2\ \ge0,$$

and the form vanishes exactly when $\langle v,u\rangle=0$ and $[v,u]=0$. A positive semidefinite symmetric operator kills $u$ whenever its form does, so $\ker N_v=v^\perp\cap\mathfrak z(v)$. ✔ claims 5 and 6. Rewriting $\mathcal A(W)=2W$ as $\sum_\alpha\lambda_\alpha N_{v_\alpha}=2W-2W=0$ is then immediate, and the two displays in the block are equivalent given $W=\sum\lambda_\alpha v_\alpha\otimes v_\alpha$.

## 5. The rescaling and the kernel inclusion

Let the minority side be the positive one, $\lambda_x>0$ its single eigenvalue with eigenvector $x$, and $\lambda_i<0$ the majority eigenvalues with eigenvectors $w_i$. Zero eigenvalues contribute nothing to $\sum_\alpha\lambda_\alpha N_{v_\alpha}$, so

$$\lambda_xN_x=\sum_i\lvert\lambda_i\rvert N_{w_i},\qquad\text{and }N_{cv}=c^2N_v\text{ gives }N_x=\sum_iN_{y_i},\quad y_i=\sqrt{\lvert\lambda_i\rvert/\lambda_x}\,w_i.$$

The $y_i$ remain orthogonal to $x$, eigenvectors of a symmetric operator for eigenvalues of opposite sign. For $u\in\ker N_x$, $0=\langle u,N_xu\rangle=\sum_i\langle u,N_{y_i}u\rangle$ with every summand $\ge0$, so every summand vanishes and $u\in\ker N_{y_i}$. ✔ claim 7.

**And it does need all terms on one side.** Positive semidefiniteness is what turns a vanishing sum into vanishing summands; had the majority terms stayed on the left with mixed signs, the vanishing of the total form would say nothing about any one of them. The rescaling is precisely the step that buys this, and it is available only because the minority side is a *single* term, §1.2 again.

So $\mathfrak c=\ker N_x=\mathfrak z(x)\cap x^\perp$ satisfies $\mathfrak c\subseteq\mathfrak z(y_i)\cap y_i^\perp$ for each $i$, which says $y_i\in\mathfrak z(\mathfrak c)$ and $y_i\in\mathfrak c^\perp$.

## 6. The L32 step

### 6.1 $\mathfrak c\ne0$, and the $m\le3$ claim

For nonzero $x\in\mathfrak{so}(m)$ with distinct singular values of multiplicities $m_1,\dots,m_s$, $\sum_jm_j=p$, and kernel of dimension $k=m-2p$,

$$\mathfrak z(x)\cong\bigoplus_j\mathfrak u(m_j)\oplus\mathfrak{so}(k),\qquad\dim\mathfrak z(x)=\sum_jm_j^2+\binom k2\ \ge\ p+\binom k2 .$$

Since $x\in\mathfrak z(x)$, $\dim\mathfrak c=\dim\mathfrak z(x)-1$, so $\mathfrak c=0$ forces $\sum_jm_j^2=1$ and $\binom k2=0$, that is $p=1$ and $k\le1$, that is $m=2+k\in\{2,3\}$. **So $\mathfrak c=0\iff m\le3$, exactly as the block says**, and $\dim\mathcal W_3=3\cdot0\cdot4\cdot5/12=0$ makes the statement vacuous there. ✔ claim 8. The discharge is unconditional and correct; **[L32](../findings/isotropy-cap.md)'s repaired hypothesis genuinely never reaches here.**

*Aside, consistent rather than discrepant.* [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) states L32's repair as $m\ne3$ where [isotropy-cap.md](../findings/isotropy-cap.md) states it as $\mathfrak c\ne0$. Both are correct: at $m=2$, $\mathfrak c=0$ but $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathfrak{so}(2)=\mathbb Rx$ anyway, so $m\ne3$ is exactly the set where L32's conclusion holds. The two repairs are never identified with each other on the record.

### 6.2 Degenerate $x$, run out

L33 feeds L32 an eigenvector that may be degenerate, and L32's proof is written *"for nondegenerate $x$"*. I ran the reduction. Write $\mathbb R^m=V\oplus K$ with $V=\mathop{\mathrm{im}}x$, $K=\ker x$ of dimension $k$. No mixed block commutes with $x$, since the $V$–$K$ block of $[x,Z]$ is $x|_VZ_{VK}$ and $x|_V$ is invertible; so $\mathfrak z(x)=\mathfrak z_V(x|_V)\oplus\mathfrak{so}(K)$ and $\mathfrak c=(\mathfrak z_V\cap x^\perp)\oplus\mathfrak{so}(K)$, the second summand being automatically orthogonal to $x$.

- **$k\ge3$.** Centralising $\mathfrak{so}(K)$ forces $Z_{KK}$ central in $\mathfrak{so}(K)$, hence $0$, and $Z_{VK}A=0$ for all $A\in\mathfrak{so}(K)$, hence $Z_{VK}=0$. So $\mathfrak z(\mathfrak c)\subseteq\mathfrak{so}(V)$ and the problem is the nondegenerate one on $V$.
- **$k=2$.** $\mathfrak{so}(2)$ is abelian so $Z_{KK}$ survives, but $\mathfrak c\supseteq\mathfrak{so}(K)$ puts that summand outside $\mathfrak c^\perp$; the intersection again reduces to $V$.
- **$k=1$.** $\mathfrak{so}(K)=0$, so the constraint on $Z_{VK}$ must come from $\mathfrak c_V$ itself: $[A,Z]_{VK}=AZ_{VK}$ for $A\in\mathfrak c_V$, so $Z_{VK}$ lies in the common kernel of $\mathfrak c_V$ in $V$. That kernel is $0$ whenever $p\ge2$: $\mathfrak c_V\supseteq\mathfrak t\cap x^\perp$ contains $a_j\varphi_{(i)}-a_i\varphi_{(j)}$ for every pair $i\ne j$, whose kernel in $V$ is the sum of the blocks other than $i$ and $j$, and those intersect to $0$ over all pairs. And $p=1$ with $k=1$ is $m=3$, already excluded by §6.1.
- **$k=0$** is L32's own case.

**So the degenerate case reduces to the nondegenerate one on $\mathop{\mathrm{im}}x$ at every $m\ge4$**, and the exception is inherited unchanged. ✔ claims 9 and 16. In particular the block's dropped clause *"the result covers … degenerate minority eigenvectors"* is true.

### 6.3 What is owed against L32, not against L33

The whole of the previous subsection sits in L32 as one sentence: *"For degenerate $x$ the same argument runs inside the support, with $\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$."* That sentence names the mechanism and asserts the conclusion; it does not run the three cases, and the $k=1$ case is the one where the mechanism it names (centralising $\mathfrak{so}(\ker x)$), supplies **no constraint at all**, because $\mathfrak{so}(K)=0$ there. **`HYPOTHESIS-DEBT` against [L32](../findings/isotropy-cap.md): the degenerate branch owes the $k=1$ case, where the stated mechanism is vacuous and the argument must instead run off $\mathfrak c_V$ having trivial common kernel.** L33's own conclusion is unaffected, because that case does hold; but a reader who checks only what L32 writes cannot get there.

### 6.4 Closing the L32 step

With $\mathfrak c\ne0$ and $x$ outside the exception, $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$, so each $y_i\in\mathbb Rx$. But $y_i\perp x$, so $y_i=0$.

## 7. The closing step

Every majority eigenvalue is now zero, so $W=\lambda_x\,x\otimes x$; the block's $\pm$ absorbs the sign of $\lambda_x$ after normalisation. Ricci-flatness reads $\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=0$, here $\lambda_x\,xx^{\mathsf T}=0$, so $x=0$. ✔ claim 11.

**The step is elliptical and sound.** $x=0$ contradicts $x$ being an eigenvector for a nonzero eigenvalue, so what has been shown is that no minority side exists; a nonzero trace-free $W$ has eigenvalues of both signs, so $W=0$. The written proof stops one sentence early, at the contradiction rather than at the conclusion it licenses. I record this as a compression, not a gap: the missing sentence is trace-freeness, already a hypothesis.

## 8. The exception

### 8.1 Realised

At $m=4$, take $W^+=\mathop{\mathrm{diag}}(q+r,-q,-r)$ with $q,r>0$ and $W^-=0$, the family [stratum-two-negative.md](../findings/stratum-two-negative.md) already carries. Its positive side is the single eigenvalue $q+r$ on the single eigenvector $a_1\in\Lambda^+$, and every nonzero element of $\Lambda^+$ is a complex-structure multiple: with $a_i^2=-\tfrac12I$ and $a_ia_j=-a_ja_i$ for $i\ne j$, $(\sum c_ia_i)^2=-\tfrac12\lvert c\rvert^2I$. Padding into any $m\ge4$, odd $m$ included, keeps membership in $\mathrm{Weyl}_m$ and makes $x$ a complex structure on a $4$-plane. **So the exception is realised at every $m\ge4$, and dropping it makes L33 false at a point already on the record.** ✔ claim 12.

### 8.2 Complete

L32's criterion is the singular-value vector $a$ being proportional to a root of $D_p$. Roots are $\pm e_i\pm e_j$, so they have $p-2$ zero coordinates while a nondegenerate $a$ has none: for $p\ge3$ no root is proportional to $a$, and for $p=2$ the roots $(1,\pm1)$ give exactly equal singular values, that is a complex structure on the $4$-plane, the sign being a reorientation of one block. With §6.2 reducing every degenerate $x$ to its support, **rank $4$ with equal singular values is the only pattern in the exception, at every $m$**, so the block's *"realised and complete"* holds. ✔ claim 13.

## 9. The *"in particular"*

Rank $3$ and trace-free forces signature $(1,2)$ or $(2,1)$, so the minority side is a single eigenvalue with a one-dimensional eigenspace. A nondegenerate skew matrix on $\mathbb R^m$ has rank $m$; at even $m\ge6$ that is rank $\ge6>4$, so $x$ is outside the exception and L33 gives $W=0$, contradicting rank $3$. ✔ claim 14.

**Both restrictions in the range are necessary, not cautious.**

- **Even.** A skew matrix in odd dimension is singular, so *"nondegenerate"* is unsatisfiable at odd $m$ and the clause would be vacuous rather than false.
- **$m\ge6$.** At $m=4$ the clause is **false**: $W^+=\mathop{\mathrm{diag}}(q+r,-q,-r)$, $W^-=0$ is a rank-$3$ element of $\mathrm{Weyl}_4$ whose minority eigenvector $a_1$ has rank $4=m$, hence is nondegenerate. It is the exception, which is why the general statement survives and the *"in particular"* must start at $6$. This matches [ROUND_L34](ROUND_L34.md)'s G7 independently.

## 10. The traps, each answered

### 10.1 $\ker W\ne0$, **cleared**

The identity $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ is supported on the nonzero spectrum, zero eigenvalues contributing $0\cdot N_{v_\alpha}$. The rescaling of §5 partitions only the nonzero eigenvalues. So a padded object (where $\ker W$ carries most of $\Lambda^2$), is handled identically to a full-support one, and *"one side"* refers to the strictly-signed part throughout. This is the trap that makes [S(W)](../findings/ungraded-slack.md) vacuous elsewhere on the record; **it does not bite here**, and the padded family of §8.1 is the proof that padded objects are inside the statement rather than outside it.

### 10.2 The boundary of every stated range

| edge | what the statement says there |
| --- | --- |
| $m\le3$ | $\dim\mathcal W_m=0$; **vacuous**, and it is exactly where $\mathfrak c=0$ |
| $m=4$ | **Vacuous.** A single positive eigenvalue in $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ forces one of $W^\pm=0$ (each nonzero trace-free factor contributes a positive eigenvalue of its own), so the eigenvector lies in a single $\Lambda^\pm$ and is a complex structure by §8.1. **Every instance at $m=4$ is the exception**, so the hypothesis set is empty. Worth saying out loud: the lemma has no content at its smallest non-trivial dimension |
| $m=5$ | Live and non-vacuous: a rank-$2$ or rank-$4$-unequal minority eigenvector is inside the hypothesis |
| **odd $m$** | Fully covered. Parity enters the proof nowhere, the identity, the splitting, the kernel inclusion and §6.1 are all parity-blind, and §6.2 handles the odd kernel dimension. The exception stays live at odd $m\ge5$ by padding. ✔ claim 15 |
| degenerate $x$ | Covered, §6.2 |
| $m\ge6$ | The generic case; nothing degenerates |

### 10.3 A claim proven on a subfamily and used in general

**Found, and it is L32's, not L33's.** L32 proves the nondegenerate case and asserts the degenerate one; L33 consumes both. §6.2 checks the consumed part holds; §6.3 books the debt where it belongs.

### 10.4 A hypothesis stated but never used

**None.** §1.1 walks each one to a step.

### 10.5 A step using a hypothesis never stated

**None in the canonical statement.** The nearest miss is that the proof needs the minority side to be *the whole* signed part rather than merely to have one one-dimensional eigenspace among several, and that is exactly what the appositive *"exactly one eigenvalue counted with multiplicity"* supplies. Where the appositive is absent, §11.3, the reading is not merely unstated but false.

### 10.6 A universal claim with no witness

The conclusion is $W=0$, so its falsifier is a nonzero object meeting every hypothesis; see §15.

### 10.7 An imported theorem whose hypotheses were never checked

The table in §1.3 checks all three. Two hold. The third is §12.1: there is nothing to check the hypotheses of, because the source is not on the record.

### 10.8 Symbol collisions

§13.

## 11. The ambiguity, and whether the repair travels

### 11.1 The $\mathrm{Weyl}_4$ witness, rebuilt cold

Take $\Lambda^\pm$ with orthonormal bases $a_1=(\varphi_{12}+\varphi_{34})/\sqrt2$, $a_2=(\varphi_{13}+\varphi_{42})/\sqrt2$, $a_3=(\varphi_{14}+\varphi_{23})/\sqrt2$ and $b_i$ the corresponding anti-self-dual triple, $b_1=(\varphi_{12}-\varphi_{34})/\sqrt2$. Put $W^+=W^-=\mathop{\mathrm{diag}}(2,-1,-1)$.

- **$W\in\mathrm{Weyl}_4$**: each factor is trace-free on its $\Lambda^\pm$, and $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$.
- **Ricci-flat, checked directly**: $a_1^2=\tfrac12(\varphi_{12}^2+\varphi_{34}^2)=-\tfrac12I_4$, the cross terms vanishing on disjoint supports, and likewise $a_2^2=a_3^2=-\tfrac12I_4$. So $\sum_i\lambda_ia_i^2=(2-1-1)(-\tfrac12I)=0$, and the same on $\Lambda^-$.
- **$W\ne0$**, spectrum $(2,2,-1,-1,-1,-1)$.
- **The positive side has one distinct value $+2$, at multiplicity two**, on $\mathop{\mathrm{span}}(a_1,b_1)$.
- **That eigenspace contains a rank-$2$ element that is no complex structure**: $a_1+b_1=\sqrt2\,\varphi_{12}$, of rank $2$, a complex structure on a $2$-plane and on no $4$-plane.

**So the lemma read as *one distinct value at any multiplicity* is false, and the block's witness is exact.** ✔ claim 17. Note also that under that reading the proof cannot even start, §1.2.

### 11.2 The second witness at $m=8$

[L34](../findings/stratum-two-negative.md)'s $m=8$ construction is two padded signature-$(2,1)$ $\mathrm{Weyl}_4$ tensors on orthogonal complementary $4$-planes, spectrum $\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$. The negative side is one distinct value at multiplicity two, spanned by the two summands' complex structures $J_1$ on $\langle e_1,\dots,e_4\rangle$ and $J_2$ on $\langle e_5,\dots,e_8\rangle$. A generic member $c_1J_1+c_2J_2$ has rank $8$ and is a complex structure on $\mathbb R^8$ rather than on a $4$-plane, its singular-value vector $(c_1,c_1,c_2,c_2)$ has no zero coordinate and so is proportional to no root of $D_4$, meaning L32 would return $\mathbb Rx$ and L33 would force $W=0$. It does not. ✔ claim 18, and it agrees with [INDEX-results.md](../findings/INDEX-results.md)'s row 34: *"outside its hypothesis with multiplicity, inside it under the distinct-value reading, where the exception applies to one eigenvector and not the generic one."*

### 11.3 Does *"with multiplicity"* reach every site?

| site | text | verdict |
| --- | --- | --- |
| [results.md](../results.md) line 152, landscape | *"exactly one eigenvalue counted with multiplicity"* | ✔ |
| [results.md](../results.md) line 473, canonical | *"exactly one eigenvalue counted with multiplicity"* | ✔ |
| [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1027, Lemma 33 body | *"exactly one eigenvalue counted with multiplicity"* | ✔ |
| [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1030, the use | quotes only the *"in particular"*, which needs no disambiguation | ✔ |
| [findings/INDEX-results.md](../findings/INDEX-results.md) row 33 | records the repair explicitly | ✔ |
| [lean/INDEX.md](../lean/INDEX.md) row L33 | records the witness and the reading | ✔ |

**The repair reaches every site that states the lemma.** ✔ claim 19.

**What still carries the false reading is the heading**, at [results.md](../results.md) line 152 and line 471, [stratum-two-negative.md](../findings/stratum-two-negative.md) line 119, the report's Lemma 33 title, and [INDEX-results.md](../findings/INDEX-results.md) row 33's trailing name: *"One eigenvalue of one sign forces the tensor to vanish"*. Read alone that is the refuted statement, with the $\mathrm{Weyl}_4$ witness of §11.1 against it.

**Reported as an observation, not as a discrepancy.** Step 3 of the protocol defeats it: every one of the five is immediately followed by the disambiguated statement, in the same paragraph or the next line, and a heading is a name rather than an assertion. It is recorded because a name that is false when quoted alone is exactly how this ambiguity travelled the first time.

## 12. The sources

### 12.1 Besse, **UNHELD**

The block says the identity *"is classical and is cited, not claimed"*, crediting [Besse, *Einstein Manifolds*, §1.143](https://link.springer.com/book/10.1007/978-3-540-74311-8). **[references/](../references/) holds no Besse**, seventy-two directories, none of them his, and the string appears only inside other authors' bibliographies. So the record's own citation standard is unmet: there is no text on file and no `notes.md`, and no hypotheses of the cited result can be checked against this object.

Two things sharpen it rather than soften it:

- Besse §1.143 is the **Lichnerowicz Laplacian on symmetric $2$-tensors**, where $\mathring Rh_{ij}=R_{ikjl}h_{kl}$ acts on $h\in S^2$. The block applies the formula to $\omega\in\Lambda^2$. The two statements are siblings and both true, but they are not the same numbered result, and the record cannot tell which §1.143 actually says.
- **The mathematics is not in doubt.** §3 derives the identity from first Bianchi and Ricci-flatness with no appeal to any source, and [references/petersen-wink-2019-bochner-technique/notes.md](../references/petersen-wink-2019-bochner-technique/notes.md) already carries the same derivation, including the rearrangement $R_{ikjl}-R_{iljk}=R_{ijkl}$. **So what is owed is a citation, not an argument**, and the block undersells itself by saying *"cited, not claimed"* when the record in fact holds a derivation, in the reference notes rather than in the lemma block.

I did not fetch Besse. Fetching would have required putting a text and a `notes.md` into [references/](../references/), which is a change to the record rather than a check of it.

### 12.2 Petersen–Wink, **held, and the credit is accurate**

[petersen-wink-1908.09958.txt](https://arxiv.org/abs/1908.09958) line 319 carries Proposition 1.6 verbatim, and [notes.md](../references/petersen-wink-2019-bochner-technique/notes.md) quotes it correctly. What it gives, with $E=\Lambda^2$ so that $\Xi_\alpha T=[\Xi_\alpha,T]$:

$$g(\mathrm{Ric}(u),u)=\sum_\alpha\lambda_\alpha\lVert[v_\alpha,u]\rVert^2 .$$

That is the **eigenbasis rewriting** of the Weitzenböck curvature term and nothing more: it says the term equals a $\lambda$-weighted sum of bracket norms, and says nothing about what that sum evaluates to. The **evaluation**, that the term is $\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\mathring R\omega$, hence $-2R$ when Ricci-flat, is a separate input, and PW's text does not contain it. **The block's sentence *"[Petersen–Wink] gives the eigenbasis rewriting and not the evaluation"* is exactly right.** ✔ claim 21.

## 13. Symbol collisions

### 13.1 $\mathring R$ in the quoted Weitzenböck display, **DISCREPANCY, notational**

1. **Located.** The display in [stratum-two-negative.md](../findings/stratum-two-negative.md), $q(R)\omega=\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\mathring R\omega$, and the same display in [references/petersen-wink-2019-bochner-technique/notes.md](../references/petersen-wink-2019-bochner-technique/notes.md).
2. **The failure, in closed form.** [conventions.md](../findings/conventions.md) settles the ring operator on Li's $iklj$ order, $(\mathring Wh)_{ij}=\sum_{kl}W_{iklj}h_{kl}$, and warns that *"$W_{ikjl}$ in place of $W_{iklj}$ negates $\mathring W$"*. Under that convention, for skew $\omega$, $\mathring R\omega=-R\omega$, so the display reads $q(R)\omega=\mathrm{Ric}\,\omega+\omega\,\mathrm{Ric}+2R\omega$ and $\mathcal A(R)=-q(R)$ becomes $-2R-(\dots)$. At $R=\mathrm{Id}$ that gives $\mathcal A=-2-2(n-1)=-2n$, against the true $-2(n-2)=-2n+4$; the error is $2\cdot 2R$ and it flips the sign of the very quantity the proof uses. **The display is only true in the $ikjl$ order**, which is the one the record settled against.
3. **The charitable reading.** $\mathring R$ inside a display attributed to Besse carries Besse's index order rather than the record's, and the block's very next sentence states the intended content in an order-free form, $\mathcal A(R)=2R-(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric})$, which §3 confirms is correct. **So the mathematics downstream is untouched.**

Reported, because [conventions.md](../findings/conventions.md) calls this index order *"load-bearing"* and *"SETTLED"*, and the block imports a symbol that silently reverses it without saying so.

### 13.2 $N_v$ against the tabled $N$, **collision, untabled**

[conventions.md](../findings/conventions.md) tables $N=\binom n2=\dim\Lambda^2\mathbb R^n$. L33's block uses $N_v:=2\,v\otimes v-\mathrm{ad}(v)^2$, an operator on $\mathfrak{so}(m)$, and **both senses live in [stratum-two-negative.md](../findings/stratum-two-negative.md)**: the dimension sense at $3\,T_{1,N-1,N}\lambda_1ab$ and at $\sum_\beta\epsilon_{\alpha\beta}=2(N-n+1)$, the operator sense throughout L33. The subscript separates them in every occurrence, and the two senses never appear in one expression, so nothing here is wrong, but the table does not carry the second sense, and the file is one where $q$ and $r$ have already each been found carrying two.

### 13.3 The letters the brief names, $\mathfrak c$, $q$, $r$, $x$

- **$q$.** Present in L33's block as the Weitzenböck operator $q(R)$. [conventions.md](../findings/conventions.md) already books this against the scalar $q$ of $W_4(q,r)$ twenty-four lines below, so the collision is **known and tabled**. The block neither defines $q$ locally nor cites the table; a citation is owed under the file's own rule that *"a findings file that needs one of these cites this file"*.
- **$r$.** Absent from L33's block. **Cleared.**
- **$\mathfrak c$.** Used identically in L32 and L33 for $\mathfrak z(x)\cap x^\perp$, and [isotropy-cap.md](../findings/isotropy-cap.md) records that it is also $\ker N_v$. Consistent everywhere I read it; **untabled in [conventions.md](../findings/conventions.md)**, which is a small debt given that it is the object the two lemmas meet on.
- **$x$.** Used only for the minority eigenvector in both blocks. **Cleared.**

## 14. The gap between what is proven and what is used

**L33 is proven, and it currently has no load-bearing consumer.**

- The report's own paragraph says L33 *"answers the question item B0 had been reduced to"*, and the next paragraph is headed *"And the reduction those lemmas were serving is refuted"*, with [L34](../findings/stratum-two-negative.md) as the refutation. So the route L33 was built for is dead.
- The live use is [stratum-two-negative.md](../findings/stratum-two-negative.md) line 84, L29's equality clause, where the same line says [L31](../findings/stratum-two-negative.md) *"closes it in three lines … at every $n$ and with no numerics"* and L33 *"closes it by a second route"*. That use is legitimate, full support plus Ricci-flatness at one positive eigenvalue makes $v_1$ nondegenerate, and $U=\mathop{\mathrm{im}}v_1$ is even-dimensional, so the *"in particular"* applies at even $r\ge6$, but it is a **second** route to a clause already closed.

This is a statement about the record's shape, not a defect in the lemma. It is worth writing down because a result whose consumers are dead or redundant is one whose hypotheses stop being exercised.

## 15. What would break it

**The falsifier is a nonzero $W\in\mathrm{Weyl}_m$ whose entire positive (or entire negative) spectrum is a single eigenvalue of multiplicity one, whose eigenvector $x$ has rank other than $4$, or rank $4$ with unequal singular values.**

What I did to look for one, all in closed form and with no computation:

- **Attacked the identity first**, since a false identity is the cheapest falsifier. Derived it from the definitions in §3 and checked it at two independent objects, $R=\mathrm{Id}$ and the $m=4$ tensor $W^+=\mathop{\mathrm{diag}}(2,-1,-1)$, and checked its failure mode at $\Lambda^4$. It holds.
- **Attacked the exception's completeness**, since an incomplete exception is a falsifier factory: an $x$ with $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ bigger than $\mathbb Rx$ and outside the excluded case would leave room for nonzero $y_i$. §8.2 shows the root-proportionality criterion admits only rank $4$ with equal singular values, and §6.2 shows padding does not create new ones. Checked by hand at every shape that could plausibly escape: rank $2$ at $m=4$ and at $m\ge5$; rank $4$ with $a_1\ne a_2$; rank $4$ equal, which is the exception; rank $2p\ge6$ nondegenerate; and each kernel dimension $k=0,1,2,\ge3$.
- **Attacked the boundary**, $m=4$ and $m=5$, where a small $\mathrm{Weyl}$ space is the usual place a universal statement dies. At $m=4$ the hypothesis set is empty, §10.2. At $m=5$ it is not, and the argument runs unchanged.
- **Attacked the minority side's structure**, since the whole proof turns on there being one term on the left. The two objects that would be falsifiers under the weaker reading, §11.1's $\mathrm{Weyl}_4$ tensor and §11.2's $m=8$ tensor, are both **outside** the stated hypothesis, and I confirmed that by rebuilding both rather than by reading the block.

**No falsifier.** The proof closes, and each of the four places it could have leaked is shut by an argument I ran myself rather than by the block's assertion.

## 16. Verdict

# PROVEN

with, recorded against their proper owners:

- **`HYPOTHESIS-DEBT` against [Lemma L32](../findings/isotropy-cap.md)**, the degenerate branch is one sentence, and in its $k=1$ case the mechanism that sentence names is vacuous; §6.3. L33's conclusion stands because the case does hold, checked here.
- **An unheld citation**, Besse §1.143, with no text and no `notes.md` in [references/](../references/), and pointing at the symmetric-tensor Laplacian rather than the $2$-form one; §12.1. The identity itself needs no repair: §3 derives it, and so does [the Petersen–Wink notes file](../references/petersen-wink-2019-bochner-technique/notes.md).
- **One notational discrepancy**, the $\mathring R$ of the quoted Weitzenböck display runs in the $ikjl$ order that [conventions.md](../findings/conventions.md) settles against, and is off by $4R$ read in the record's own convention; §13.1. Downstream mathematics untouched.
- **Two small collisions and one missing citation of the conventions file**, $N_v$ against the tabled $N$, $\mathfrak c$ untabled, and $q(R)$ used without pointing at the table that already books it; §13.

### Withdrawn candidates

- **The clause $W=\pm x\otimes x$, and Ricci-flatness forces $x=0$, as a non-sequitur.** *Located*: the final clause of the proof. *Failure*: $x=0$ contradicts the standing assumption that $x$ is an eigenvector, so the displayed conclusion is a contradiction rather than the stated $W=0$. *The opposite*: trace-freeness is already a hypothesis and makes the passage from a missing minority side to $W=0$ a single line, and proofs by contradiction routinely stop at the contradiction. **Withdrawn**, a compression, §7.
- **The heading stating the refuted reading, as a discrepancy.** *Located*: five sites, §11.3. *Failure*: read alone the heading is false, with §11.1's witness against it. *The opposite*: every occurrence is immediately followed by the disambiguated statement, and a heading names rather than asserts. **Withdrawn to an observation.**
- **L33 using L32 outside its proven subfamily, as a defect in L33.** *Located*: the L32 step with degenerate $x$. *Failure*: L32's proof covers nondegenerate $x$ and asserts the rest. *The opposite*: the assertion is true, as §6.2 establishes independently. **Withdrawn from L33 and rebooked against L32**, §6.3.
