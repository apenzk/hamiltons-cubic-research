# Verification of Lemma L30, verifier v209

**Cold read of [BRIEF_L30.md](BRIEF_L30.md), sections A–C, against [conventions.md](../findings/conventions.md).** No numerical work of any kind was done: no script, no Sage, no Python, no numeric evaluation. Every witness below is exhibited in closed form and checked by hand. The programme's analysis-only rule was in force and the screening allowance was not used. Log: [agent_logs/verify-L30-v209.log](../agent_logs/verify-L30-v209.log).

## Claim table

| # | claim, as written in the block | verdict |
| --- | --- | --- |
| 1 | $\mathrm{Ric}(W)(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$, so Ricci-flatness is $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ | **PROVEN**, derived in full at §2, exact in the record's normalisation |
| 2a | "the positive and negative sides are the same matrix" | **PROVEN**, immediate from claim 1 |
| 2b | "whose image is contained in $U$, and every eigenvector with nonzero eigenvalue has its image inside $U$" | **PROVEN**, on two steps the block never states (§3) |
| 3 | "$v_\alpha u=0$ for every $\alpha$ with $\lambda_\alpha\ne0$", with the $e_9\wedge e_{10}$ qualifier | **PROVEN**, and the witness **CONFIRMED** (§4) |
| 4 | "$W(u\wedge w)=0$ for every $w$", hence $W$ vanishes on $u\wedge u^\perp$ | **PROVEN** (§4) |
| 5 | the restriction to $\Lambda^2U$ is Ricci-flat | **PROVEN**, the block's own one-line reason is correct (§6) |
| 6 | "at most two negative eigenvalues" as a hypothesis | **INERT** outside the definition of $U$; correct general statement given at §5 |
| 7 | $W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor **with the same norm and the same $\theta$** | **HYPOTHESIS-DEBT**, no argument on file, in the block or anywhere on the record (§7) |
| 8 | scope: the block's $6,7,8$ | **BROKEN**, omits $n=5$ (§8) |
| 9 | scope: the development form's "below $n=9$" | **BROKEN**, admits $n=4$, where the hypothesis fails (§8) |
| 10 | the blockquote's "Scope: $n=5,6,7,8$" | **CONFIRMED** (§8) |
| 11 | the blockquote's four-negative $\mathbb R^8$ witness | **CONFIRMED** (§5) |
| 12 | "at most two negative eigenvalues" read as *at most two distinct* | **BROKEN under that reading**, the same $\mathbb R^8$ object is a counterexample and $U$ is not even well defined (§5.3) |

**Overall verdict: HYPOTHESIS-DEBT.** Every step the block writes down is correct, and two of the block's own hedges are exactly right. But the clause the lemma exists for (*"with the same norm and the same $\theta$"*), has no argument on file, and the record's only statement of that fact is a bullet in [conventions.md](../findings/conventions.md) with an empty source cell, so it cannot be discharged by citation either.

## 0. Conventions, fixed once

Quoted, not restated, from [conventions.md](../findings/conventions.md).

- The pairing on $\Lambda^2$: *"**This record's norm is $\lVert Z\rVert^2=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z)$**, so $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$"*, and *"A skew matrix's norm, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}X)$"*.
- The bivector normalisation: *"**A bivector's norm, and the record runs in the first of these**: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal"*.
- $\mathrm{Ric}$: *"$\mathrm{Ric}$ is the adjoint of $\cdot\wedge\mathrm{id}$, with $\lVert\mathrm{Ric}\rVert$ the Frobenius norm of the resulting symmetric matrix"*.
- The sharp: *"$\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$"*.
- $\theta$: *"$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$"*, so $\theta$ is the ratio, and criticality is **not** part of L30's setting.
- $N$: *"$\binom n2=\dim\Lambda^2\mathbb R^n$"*.
- $Q$: *"Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself"*; $P(W)=\langle W,Q(W)\rangle$.
- Padding, the one line the record has: *"**Padding commutes with $Q$**, and preserves both the norm and $\theta$. The stratum reduction turns on this."*, **a bullet with no source cell and no proof anywhere.** This matters at §7.

Throughout, $\{v_\alpha\}_{\alpha=1}^N$ is an orthonormal eigenbasis of $W$ on $\Lambda^2\mathbb R^n$ with $Wv_\alpha=\lambda_\alpha v_\alpha$, and the identification of bivectors with skew matrices is $x\wedge y=xy^{\mathsf T}-yx^{\mathsf T}$, which is the one under which $\varphi_{ab}=E_{ab}-E_{ba}$ has $\lVert\varphi_{ab}\rVert^2=1$, as the quoted bullet requires.

## 1. Hypothesis inventory

**Stated, and where each is used.**

| # | hypothesis | where the proof uses it |
| --- | --- | --- |
| H1 | $W\in\mathrm{Weyl}_n$, symmetric on $\Lambda^2$, first Bianchi, Ricci-flat | Ricci-flatness at the identity step. **Bianchi is used silently** (to know $W'\in\mathrm{Weyl}_{\dim U}$) and **symmetry is used silently** (to get $\operatorname{im}W\subseteq\Lambda^2U$) |
| H2 | at most two negative eigenvalues | **only** to make $U$ equal the image of the negative side. Nowhere else, see §5 |
| H3 | $v_{N-1},v_N$ the negative eigenvectors, read as skew matrices | fixes $U$; the spectral expansion needs the whole orthonormal eigenbasis, not just these two |
| H4 | $U=\operatorname{im}v_{N-1}+\operatorname{im}v_N$ | throughout |
| H5 | $\dim U<n$ | **only** to make $U^\perp\ne0$, so the conclusion is not empty. It enters no inference |

**Used but never stated.** Each is true; the block writes none of them.

- U1, the additivity of images over a PSD sum, $\operatorname{im}(\sum_iA_i)=\sum_i\operatorname{im}A_i$ for $A_i\succeq0$. This is the whole of step 2b.
- U2, $\ker v=(\operatorname{im}v)^\perp$ for skew $v$, which is what turns "$\operatorname{im}v_\alpha\subseteq U$" into "$v_\alpha u=0$ for $u\perp U$".
- U3, $\operatorname{im}(v^{\mathsf T}v)=\operatorname{im}v$.
- U4, $\lVert W\rVert$ is computed on a full orthonormal eigenbasis of $\Lambda^2$; the record's half-trace pairing, not plain Frobenius, is what makes claim 1 exact rather than off by a factor.
- U5, for the padding half only: that $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ is an isometry, that $\operatorname{im}W\subseteq\Lambda^2U$, that $\mathfrak{so}(U)$ is a Lie subalgebra of $\mathfrak{so}(n)$, and that $\#$ carries no dimension-dependent constant. **These four are the debt of §7.**

**Stated but inert:** H2, except in the definition of $U$ (§5). **H5 is inert to the derivation** and only makes the conclusion non-empty.

## 2. Claim 1, the identity, derived

Write $W=\sum_\alpha\lambda_\alpha\,v_\alpha\otimes v_\alpha$, so $\langle W(Z),Z\rangle=\sum_\alpha\lambda_\alpha\langle v_\alpha,Z\rangle^2$.

Fix a unit $x$ and an orthonormal basis $\{f_j\}_{j=1}^{n-1}$ of $x^\perp$. Under the identification of §0, and with $v_\alpha^{\mathsf T}=-v_\alpha$,

$$\langle v_\alpha,\,x\wedge f_j\rangle=\tfrac12\operatorname{tr}\!\big(v_\alpha^{\mathsf T}(xf_j^{\mathsf T}-f_jx^{\mathsf T})\big)=\tfrac12\big(\langle v_\alpha^{\mathsf T}x,f_j\rangle-\langle v_\alpha^{\mathsf T}f_j,x\rangle\big)=-\langle v_\alpha x,\,f_j\rangle .$$

The record's $\mathrm{Ric}$, as the adjoint of $\cdot\wedge\mathrm{id}$, is $\mathrm{Ric}(W)(x,x)=\sum_j\langle W(x\wedge f_j),x\wedge f_j\rangle$, the form the development form of L30 also writes. Hence

$$\mathrm{Ric}(W)(x,x)=\sum_j\sum_\alpha\lambda_\alpha\langle v_\alpha,x\wedge f_j\rangle^2=\sum_\alpha\lambda_\alpha\sum_j\langle v_\alpha x,f_j\rangle^2 .$$

Skewness gives $\langle v_\alpha x,x\rangle=0$, so $v_\alpha x\in x^\perp$ and the inner sum is Parseval on $x^\perp$: $\sum_j\langle v_\alpha x,f_j\rangle^2=\lVert v_\alpha x\rVert^2$. Therefore

$$\mathrm{Ric}(W)(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2=x^{\mathsf T}\Big(\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha\Big)x ,$$

and since $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ is symmetric, the quadratic form determines it: **Ricci-flatness is exactly $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$.** **PROVEN.**

**The index convention this needs, and it is the record's.** The derivation is exact (no stray factor), precisely because the record runs in the half-trace pairing with $\lVert\varphi_{ab}\rVert^2=1$. In plain Frobenius, $\langle v_\alpha,x\wedge f_j\rangle=-2\langle v_\alpha x,f_j\rangle$ and the eigenvectors have $\lVert v_\alpha\rVert^2=2$, so both sides rescale; the *vanishing* statement survives any positive rescaling, so Ricci-flatness $\iff\sum\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ is normalisation-robust even though the displayed identity is not. The $\mathring R$ index-order dispute recorded in [conventions.md](../findings/conventions.md), *"[stratum-two-negative.md](../findings/stratum-two-negative.md) is written throughout in BK's $ikjl$"*, does **not** reach this step: $\mathring R$ never appears in L30, and $\mathrm{Ric}$ is a contraction whose definition is order-independent.

**One thing the block leaves unsaid and should.** Ricci-flatness is not a hypothesis of L30; it is part of membership in $\mathrm{Weyl}_n$. The block's "so Ricci-flatness is exactly …" reads as though a condition were being imposed. It is being *unpacked*, which is stronger and is what the proof needs.

## 3. Claim 2, the image step, both halves separately

Put $P:=\sum_{\lambda_\alpha>0}\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ and $M:=\sum_{\lambda_\alpha<0}(-\lambda_\alpha)v_\alpha^{\mathsf T}v_\alpha$. Both are sums of positive multiples of $v^{\mathsf T}v\succeq0$, so $P\succeq0$ and $M\succeq0$.

**Half one, "the positive and negative sides are the same matrix."** Splitting $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ by the sign of $\lambda_\alpha$ gives $P-M=0$, the kernel eigenvectors contributing nothing since their coefficient is zero. **HOLDS**, immediately.

**Half two, "whose image is contained in $U$, and every eigenvector with nonzero eigenvalue has its image inside $U$."** This needs U1, U2, U3, none of which the block writes.

- U3: for skew $v$, $\ker(v^{\mathsf T}v)=\ker v$, and $v^{\mathsf T}v$ is symmetric, so $\operatorname{im}(v^{\mathsf T}v)=(\ker v)^\perp=\operatorname{im}(v^{\mathsf T})=\operatorname{im}v$.
- U1: for $A_i\succeq0$, $x^{\mathsf T}(\sum_iA_i)x=0$ forces every $x^{\mathsf T}A_ix=0$ hence every $A_ix=0$, so $\ker(\sum_iA_i)=\bigcap_i\ker A_i$ and, on complements, $\operatorname{im}(\sum_iA_i)=\sum_i\operatorname{im}A_i$.

Therefore $\operatorname{im}M=\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$ and $\operatorname{im}P=\sum_{\lambda_\alpha>0}\operatorname{im}v_\alpha$. Under H2, the first is exactly $U$. So $P=M$ gives

$$\sum_{\lambda_\alpha>0}\operatorname{im}v_\alpha=\operatorname{im}P=\operatorname{im}M=U ,$$

whence $\operatorname{im}v_\alpha\subseteq U$ for every $\lambda_\alpha>0$, and trivially for every $\lambda_\alpha<0$. **HOLDS.**

Two notes. First, the block says the common image is *"contained in $U$"*; under H2 it is *equal* to $U$, and the containment is all the argument needs. Second, U1 is not a triviality, it is false for general (non-PSD) summands, and it is the single step on which the whole lemma turns. Recording it as an unwritten step, not as a gap.

## 4. The kernel trap, and the $e_9\wedge e_{10}$ witness, CONFIRMED

For $u\perp U$ and $\lambda_\alpha\ne0$: $\operatorname{im}v_\alpha\subseteq U$ gives $\ker v_\alpha=(\operatorname{im}v_\alpha)^\perp\supseteq U^\perp\ni u$, so $v_\alpha u=0$. Then for any $w$,

$$W(u\wedge w)=\sum_\alpha\lambda_\alpha\langle v_\alpha,u\wedge w\rangle v_\alpha=-\sum_{\lambda_\alpha\ne0}\lambda_\alpha\langle v_\alpha u,w\rangle v_\alpha=0 ,$$

the $\lambda_\alpha=0$ terms dropping because they carry the factor $\lambda_\alpha$. So the block's *"and those are the only $\alpha$ the sum reaches"* is exactly right, and the conclusion is stronger than stated: $W(u\wedge w)=0$ for **every** $w\in\mathbb R^n$, not only $w\perp u$. **HOLDS.**

**The witness, checked in closed form.** Padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$, supported on $V=\operatorname{span}(e_1,\dots,e_4)$, has $U=V$ and $\lVert W\rVert=1$ with $W\vert_{\Lambda^+V}=\operatorname{diag}(2,-1,-1)/\sqrt6$ and $W=0$ on the orthogonal complement of $\Lambda^+V$ in $\Lambda^2\mathbb R^{10}$. Take $u=e_9\perp U$ and the eigenvector $v=e_9\wedge e_{10}$, which lies in $\ker W$, so $\lambda_v=0$ and it is a legitimate member of some orthonormal eigenbasis. Then

$$v\,u=(e_9e_{10}^{\mathsf T}-e_{10}e_9^{\mathsf T})e_9=-e_{10}\ne0 .$$

So *"$v_\alpha u=0$ for all $\alpha$"* is **false as an unqualified statement**, and the block's inserted qualifier $\lambda_\alpha\ne0$ is necessary. The blockquote's closing sentence and the block's own italic hedge are both **CONFIRMED**. Since the failing eigenvector carries $\lambda=0$, it does not reach the sum, and the conclusion is untouched, the trap is live in the *statement* and dead in the *inference*.

**The trap in the other direction.** L30 is a lemma *about* paddings, so $\ker W\ne0$ is not an edge case here but the generic situation: $\dim U<n$ forces $\dim\ker W\ge\binom n2-\binom{\dim U}2>0$. Every step above was checked with that in mind; none of them quantifies over the kernel.

## 5. "At most two", inert, and the correct statement

### 5.1 It is used nowhere but in defining $U$

Reading the proof line by line: claim 1 quantifies over all $\alpha$; claim 2's split is by sign, not by count; claim 3 and claim 4 need only $\operatorname{im}v_\alpha\subseteq U$; claim 5 needs only that $W$ kills $U^\perp\wedge\mathbb R^n$. **H2 enters at exactly one place**, the identification $\operatorname{im}M=U$ in §3. **CONFIRMED: the hypothesis is inert to the argument.**

### 5.2 The correct general statement

> Let $W\in\mathrm{Weyl}_n$ and set $U:=\operatorname{im}\big(\sum_{\lambda_\alpha<0}(-\lambda_\alpha)v_\alpha^{\mathsf T}v_\alpha\big)=\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$. If $\dim U<n$ then $W$ vanishes on $u\wedge\mathbb R^n$ for every $u\perp U$, and $W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor.

With that $U$, §3 gives $\operatorname{im}P=\operatorname{im}M=U$ for **any** number of negative eigenvalues, and §4 and §6 are unchanged. **No step degrades**, and $\dim U=n-1$ is admitted, the conclusion then says $W$ kills the $(n-1)$-dimensional space $u\wedge\mathbb R^n$ for the unique line $\mathbb Ru=U^\perp$. So the blockquote's redefinition claim is **CONFIRMED**, and it is one line.

A point in the redefinition's favour that the blockquote does not make: $U$ so defined is manifestly **basis-independent**, because $\sum_{\lambda_\alpha<0}(-\lambda_\alpha)v_\alpha^{\mathsf T}v_\alpha$ is the image of a spectral projector under a linear map and so does not depend on the choice of orthonormal basis inside a repeated eigenspace. The block's $U$ is basis-independent too, but only *because* there are exactly two, a fact the block never remarks on, and one the development form flags as *"stated invariantly for a reason"*.

### 5.3 The blockquote's $\mathbb R^8$ witness, CONFIRMED, and it does more than the blockquote says

Let $V_1=\operatorname{span}(e_1,\dots,e_4)$, $V_2=\operatorname{span}(e_5,\dots,e_8)$ and $A=\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$ on $\mathbb R^8$.

- $A\in\mathrm{Weyl}_8$: each summand is supported on $\Lambda^2V_i$ where Bianchi is inherited; and $\mathrm{Ric}(\mathrm{pad}_{V}W)(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$ vanishes for $x\in V$ by $\mathrm{Ric}_4(W)=0$ and for $x\perp V$ because every $v_\alpha x=0$. $\mathrm{Weyl}_8$ is a linear space, so the sum is in it.
- Spectrum: $2/\sqrt6$ twice and $-1/\sqrt6$ four times, on $\Lambda^+V_1\oplus\Lambda^+V_2$, zero elsewhere. **Four negative eigenvalues**, so H2 fails.
- Take $v_{N-1},v_N$ to be the two $-1/\sqrt6$ eigenvectors inside $\Lambda^+V_1$. Then $U=V_1$ (each self-dual $2$-form on $\mathbb R^4$ is nondegenerate, so has image all of $V_1$) and $\dim U=4<8$.
- $e_5\perp U$, and $e_5\wedge e_6=\tfrac12(w^++w^-)$ with $w^\pm$ its (anti-)self-dual parts in $\Lambda^2V_2$, so $A(e_5\wedge e_6)=\tfrac12W_{\mathbb{CP}^2}(w^+)\ne0$ because $\operatorname{diag}(2,-1,-1)/\sqrt6$ is invertible on $\Lambda^+V_2$.

So **left as written, H2 is necessary. CONFIRMED.**

**And it settles a reading the record leaves open.** *"At most two negative eigenvalues"* admits two readings, with multiplicity and distinct. $A$ has **one** distinct negative eigenvalue, $-1/\sqrt6$ of multiplicity four. So under the *distinct* reading, $A$ **satisfies** the hypothesis and **refutes** the lemma; worse, $U$ is then not even well defined, since $v_{N-1},v_N$ range over a four-dimensional eigenspace and different choices give different $U$. Running the discrepancy protocol: the failure is located at the statement's first clause; it is exhibited by $A$ above in closed form; the opposite is argued by the index notation $v_{N-1},v_N$, which names two *indices* in an eigenbasis of $\Lambda^2$ and so pins the with-multiplicity reading, corroborated by the neighbouring L29 (*"exactly one positive and two negative eigenvalues, $\lambda_1>0>-a\ge-b$"*) and by the development form's *"at most $53$ of $66$"*, both counted with multiplicity. **Verdict: the intended reading is with multiplicity and under it the lemma stands; the statement should say so, because under the other reading it is false with a witness the record already holds.** Recorded as a defect in the statement's precision, not in its mathematics.

## 6. Ricci-flatness of the restriction, the block's own reason is correct

*"The restriction to $\Lambda^2(U)$ is Ricci-flat because the terms of $\mathrm{Ric}$ involving directions outside $U$ vanish with $W$."* **HOLDS**, and here is the content.

For $x\in U$ unit, choose the orthonormal basis of $x^\perp$ adapted to $U\oplus U^\perp$: $\{f_j\}=\{f_j'\}\cup\{f_k''\}$ with $f_j'\in U\cap x^\perp$ and $f_k''\in U^\perp$. Then

$$\mathrm{Ric}_{\mathbb R^n}(W)(x,x)=\underbrace{\sum_j\langle W(x\wedge f_j'),x\wedge f_j'\rangle}_{=\ \mathrm{Ric}_U(W')(x,x)}+\sum_k\langle W(x\wedge f_k''),x\wedge f_k''\rangle .$$

Each term of the second sum has $f_k''\perp U$, so by §4 (with $u=f_k''$, $w=x$) $W(x\wedge f_k'')=-W(f_k''\wedge x)=0$. The left side is $0$ by H1. Hence $\mathrm{Ric}_U(W')=0$. **The "terms involving directions outside $U$" are exactly the second sum, and they vanish for the stated reason.**

This is one of three things needed for $W'\in\mathrm{Weyl}_{\dim U}$; the block supplies this one and states neither of the other two (symmetry of $W'$, which is inherited, and the first Bianchi identity for $W'$, which is inherited because Bianchi is an identity among components with all four indices in $U$).

## 7. "With the same norm and the same $\theta$", HYPOTHESIS-DEBT

**It is not proved in the block.** The proof text ends at the Ricci-flatness of the restriction. Neither the norm nor $\theta$ is mentioned once between "**Proof.**" and "$\square$". The blockquote says so, and I confirm it by reading: **this clause has no argument on file.**

**Nor is it discharged by citation.** The record's only statement of the fact is the [conventions.md](../findings/conventions.md) bullet *"**Padding commutes with $Q$**, and preserves both the norm and $\theta$. The stratum reduction turns on this."*, a bullet in a list, with **no source cell, no numbered result behind it, and no proof anywhere in [findings/](../findings/)**. It is the single occurrence of that sentence on the record. Citing it would move the debt, not pay it. The blockquote's own pointer, [r59](../reviews/REVIEW_r59.md)'s Claim 2 step 6, is a review row whose stated support is *"Measured over the pad pairs 4→5, 4→6, 5→6, 5→7, 6→7"* (numerics plus a one-clause structural reason) and a review is not the record's proof text.

**What would have to be proved.** Four statements, in the order a proof would need them. I name them; I do not prove them.

1. **The support statement.** From §4, $W$ annihilates $U^\perp\wedge\mathbb R^n=(U\wedge U^\perp)\oplus\Lambda^2U^\perp$; **it would have to be shown** that $W$ therefore restricts to an operator $W'$ on $\Lambda^2U$ with $W=\iota W'\iota^{\mathsf T}$, which needs the symmetry of $W$ to place $\operatorname{im}W$ inside $\Lambda^2U$, a use of H1 the block never makes.
2. **The norm.** **It would have to be shown** that the inclusion $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ is an isometry for the record's half-trace pairing, i.e. that an orthonormal basis $\{u_a\wedge u_b\}_{a<b}$ of $\Lambda^2U$ built from an orthonormal basis of $U$ stays orthonormal in $\Lambda^2\mathbb R^n$, so that $\operatorname{tr}(W^2)=\operatorname{tr}(W'^2)$. This is the blockquote's *"the norm from orthonormality"* and it is genuinely one line, but it is a line nobody has written.
3. **The $\operatorname{tr}W^3$ half of $P$.** Immediate from 1, and **it would have to be said**.
4. **The $\langle W,W^\#\rangle$ half of $P$.** This is the only substantial obligation. **It would have to be shown** that $\langle W,W^\#\rangle$ computed in $\mathcal W_n$ equals $\langle W',W'^\#\rangle$ computed in $\mathcal W_{\dim U}$.

**Is "$\Lambda^2U=\mathfrak{so}(U)$ is a Lie subalgebra" enough for obligation 4?** *Enough, but not alone, and the block does not hold the other ingredients in the right place.* Spelling out what the sufficiency claim rests on:

- Obligation 4 is a statement about the structure constants $\langle[v_\alpha,v_\beta],v_\gamma\rangle$ over the eigenvectors that carry nonzero eigenvalues, since [conventions.md](../findings/conventions.md)'s $\#$ is defined purely from the bracket (*"$vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$"*) and carries **no dimension-dependent constant**, so nothing about $n$ enters the sharp itself. That last point is an ingredient and is not stated anywhere in the block.
- The subalgebra property gives $[\mathfrak{so}(U),\mathfrak{so}(U)]\subseteq\mathfrak{so}(U)$, so brackets of the surviving eigenvectors never leave $\mathfrak{so}(U)$ and the two computations range over the same triples.
- **But it is enough only in the presence of two further facts**: that every $v_\alpha$ with $\lambda_\alpha\ne0$ lies in $\mathfrak{so}(U)$, which is the block's own image step of §3, and would have to be *invoked here*, where the block invokes it only for the vanishing conclusion, and that the eigenvectors with $\lambda_\alpha=0$ contribute nothing, which holds because every term of $\langle W,W^\#\rangle$ carries the factor $\lambda_\alpha\lambda_\beta\lambda_\gamma$. Neither appears in the clause's vicinity.
- **Does $Q$ restricted to the padded tensor agree with $Q$ computed in $\mathcal W_{\dim U}$?** The stronger statement $Q(\iota W'\iota^{\mathsf T})=\iota\,Q(W')\,\iota^{\mathsf T}$, [r59](../reviews/REVIEW_r59.md)'s *"sharp off-block **exactly 0.0**"*, is what the conventions bullet asserts, and it is **strictly more than $\theta$ needs**: $\theta$ needs only the scalar $\langle W,Q(W)\rangle$ to agree. **Whichever is taken, it would have to be proved**, and the record proves neither. Recording the distinction because it is the sort of thing that gets conflated: an argument that establishes the scalar does not establish the operator identity, and the conventions bullet claims the operator identity.

**Why this is the finding that matters.** The block's own opening line is *"Needed because the sharp stratum's members turn out to be paddings, and that is what lets a bound proved in low dimension govern every $n$."* The transfer of a bound from $\dim U$ to $n$ runs entirely through *"the same norm and the same $\theta$"*. Everything the block proves (the vanishing on $u\wedge u^\perp$, the Ricci-flatness of the restriction), establishes that $W$ *is* a padding; none of it establishes that padding is $\theta$-preserving, which is the property consumers use. **The lemma proves the structural half and asserts the transferable half.**

## 8. Scope, endpoint by endpoint

The three versions on file, and what each is about: for which $n$ does padded $W_{\mathbb{CP}^2}$ satisfy L30's hypothesis $\dim U<n$ while the rank-sum criterion $r_{N-1}+r_N<n$ fails?

At padded $W_{\mathbb{CP}^2}$ in $\mathbb R^n$ the two negative eigenvectors are self-dual $2$-forms on $V=\operatorname{span}(e_1,\dots,e_4)$, each nondegenerate on $V$, so $r_{N-1}=r_N=4$, $U=V$ and $\dim U=4$.

| $n$ | $\dim U<n$? | $r_{N-1}+r_N=8<n$? | inside the intended range? |
| --- | --- | --- | --- |
| $4$ | $4<4$ (**no** | $8<4$), no | **no**: the hypothesis itself fails |
| $5$ | $4<5$ (yes | $8<5$), no | **yes** |
| $6,7,8$ | yes | no | yes |
| $\ge9$ | yes | yes, criterion applies | no: the rank-sum form already covers it |

- **$n=4$.** $U=V=\mathbb R^4$, so $\dim U=n$ and L30's hypothesis is **not satisfied**; the lemma says nothing about $W_{\mathbb{CP}^2}$ at $n=4$, and nothing needs it to, since $W_{\mathbb{CP}^2}$ is not a padding of anything smaller ($\mathrm{Weyl}_3=0$ by $\dim\mathcal W_m=m(m-3)(m+1)(m+2)/12$). The development form's *"below $n=9$"* therefore **admits an $n$ at which the hypothesis fails**. The same conclusion is reached through the development form's own invariant hypothesis: $\bigcap_{v\in\mathfrak m}\ker v=U^\perp=0$ at $n=4$, so *"the conclusion holds anyway"* is describing a tensor that satisfies neither of the two hypotheses on offer. **Version 9: BROKEN at the lower endpoint.**
- **$n=5$.** $\dim U=4<5$ and the rank sum is $8\ge5$, so this is exactly the configuration the scope paragraph exists to name, and the block's list omits it. Padded $W_{\mathbb{CP}^2}\in\mathrm{Weyl}_5$ by the argument of §5.3 with $V_2$ dropped, and it has exactly two negative eigenvalues, so it satisfies every hypothesis. **Version 8: BROKEN at the lower endpoint.**
- **$n=8$ and $n=9$.** $8<9$ but not $8<8$, so $n=8$ is in and $n=9$ is out. Both existing versions get the upper endpoint right except the block's, which stops at $8$, correctly.
- **Verdict on the blockquote's $n=5,6,7,8$: CONFIRMED**, and its *"Each version has one endpoint wrong"* is exact.

**The crossover $n=6+2\sqrt7$ is not live here.** It is the root of $3n^2=4(n-1)(n-2)$, i.e. where $\sqrt{3/2}=\theta_0(n)$, giving $n=6+2\sqrt7\approx11.2915$ and hence L29's *"$\sqrt{3/2}<\theta_0(n)$ from $n=12$"*. L30 contains no $\theta$ threshold and no comparison against $\theta_0$; its endpoints are set by ranks alone. Checked and found inapplicable.

## 9. The remaining traps, answered by name

- **A claim proven on a subfamily and used in general.** None in the block. The identity of §2 is derived for all $W$; the development form's *"verified at $3\times10^{-15}$"* is a screen sitting beside a general derivation, not in place of one. Clear.
- **A hypothesis stated but never used.** H2 outside the definition of $U$ (§5), and H5 outside making the conclusion non-empty (§1). Both recorded.
- **A step using a hypothesis never stated.** U1–U5 of §1. U1 is the load-bearing one and U5 is the debt.
- **A universal claim with no witness.** The statement is non-vacuous: padded $W_{\mathbb{CP}^2}$ instantiates it at $n=5,6,7,8$ and padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$ at $n=10$. Clear.
- **An imported theorem whose hypotheses were never checked.** The block imports nothing. The unital-algebra failure mode named in the brief is absent, no algebra theorem is cited, and the only algebraic fact in play, that $\mathfrak{so}(U)$ is a subalgebra, needs no unit. Clear.
- **Symbol collisions.** Checked each against [conventions.md](../findings/conventions.md). $N$: the block's $v_{N-1},v_N$ read against the tabled $N=\binom n2$, consistent; the table's flagged collision with L33's $N_v$ sits elsewhere in the same file and does not reach this block. $\lambda$: the $\Lambda^2$ spectrum throughout, unambiguous here. $v_\alpha$ and the indices $\alpha,\beta,\gamma$: the table warns these collide with L35's cubic coefficients *"by which half of the block is speaking"*; L35 is a different block and no cubic coefficient appears in L30. $U$: not tabled and carries one sense here. $q$, $r$ and $\mathring R$, each flagged as carrying two senses inside [stratum-two-negative.md](../findings/stratum-two-negative.md): **none of the three appears anywhere in the L30 block**, so no collision is live in it. **One collision is live and untabled**, below.
- **The untabled collision.** The development form of L30 writes *"with negative eigenspace $\mathfrak m$"* and hypothesises *"$\mathfrak m$ has a nonzero common kernel"*. [conventions.md](../findings/conventions.md) tables $\mathfrak m$ as *"at a critical point, $\mathfrak m=E_{\min}$"* and flags *"three incompatible senses across the record"*, this one, L36's whole negative eigenspace, and target.md's symmetric-pair odd part, **and the development form takes the second, which the table does not attribute to this file.** The readings differ: at $W$ with two distinct negative eigenvalues $-a>-b$, $E_{\min}$ is the $-b$ eigenline alone, whose common kernel is $(\operatorname{im}v_N)^\perp$, strictly larger than $U^\perp$, so the $E_{\min}$ reading gives a strictly weaker hypothesis and a false lemma. The canonical L30 statement avoids the letter entirely, so the defect is confined to the development form. **Recording it; the table's $\mathfrak m$ row should name [stratum-two-negative.md](../findings/stratum-two-negative.md).**

## 10. What would falsify the statement, and what I did to look for it

**The object.** A $W\in\mathrm{Weyl}_n$ with at most two negative eigenvalues counted with multiplicity, with $\dim U<n$ for $U=\operatorname{im}v_{N-1}+\operatorname{im}v_N$, and with **either**

1. some $u\perp U$ and some $w$ with $W(u\wedge w)\ne0$, falsifying the first conclusion; **or**
2. $W$ a padding of $W'\in\mathrm{Weyl}_{\dim U}$ with $\lVert W'\rVert\ne\lVert W\rVert$ or $\theta(W')\ne\theta(W)$, falsifying the clause the lemma exists for.

**What I did.** For (1): traced the chain §2→§3→§4 for the step that could admit such a $W$. The only candidate is the failure of $\operatorname{im}v_\alpha\subseteq U$, which needs either the PSD image additivity U1 or the identification $\operatorname{im}M=U$ to fail. U1 is unconditional. $\operatorname{im}M=U$ fails exactly when more than two eigenvectors carry negative eigenvalues, and there the falsifier **exists** and the record already holds it: the $\mathbb R^8$ object of §5.3, which I checked in closed form. Under H2 read with multiplicity, no such $W$ can exist. Under H2 read as *at most two distinct*, that same object is the falsifier. For (2): the two places a leak could enter are the isometry of $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ and off-block contributions to $W^\#$; I identified both as obligations at §7 rather than closing them, since closing them is supplying the missing argument. I found no candidate falsifier for (2) and I do not claim there is none, **there is no argument on file either way**, which is the finding.

**How I looked.** By reading: the block, the development form thirty-four lines above, the four blockquotes, [results.md](../results.md) lines 146 and 461–465, row 30 of [INDEX-results.md](../findings/INDEX-results.md), [r59](../reviews/REVIEW_r59.md)'s Claim 2, and the whole of [conventions.md](../findings/conventions.md). Every witness above was checked by hand in closed form. **No script was run, no numerical evaluation of any kind was performed, and the screening allowance was not used.**

## Verdict

**HYPOTHESIS-DEBT.**

Everything the block writes down is correct, and both of its inserted hedges (the $\lambda_\alpha\ne0$ qualifier and the $e_9\wedge e_{10}$ witness), are exactly right. The identity is exact in the record's normalisation, the image step holds on two unwritten but unconditional facts, and the Ricci-flatness of the restriction holds for the reason the block gives.

What is owed:

- **The clause "with the same norm and the same $\theta$" has no argument on file**, not in the block, not in [findings/](../findings/), and not behind the [conventions.md](../findings/conventions.md) bullet that asserts it, which carries an empty source cell. §7 names the four statements that would have to be proved, and the one non-obvious sufficiency question they turn on.
- **The scope is $n=5,6,7,8$**; the block's $6,7,8$ omits $5$ and the development form's "below $n=9$" admits $4$, where the hypothesis fails under either reading of it.
- **"At most two" must be read with multiplicity, and the statement must say so**, under the *distinct* reading the record's own $\mathbb R^8$ object refutes the lemma and $U$ is not well defined. The hypothesis is otherwise inert, and §5.2 gives the correct general statement.
- **The development form's $\mathfrak m$** takes a sense the conventions table does not attribute to this file, and the table's primary sense $E_{\min}$ makes that hypothesis false.
