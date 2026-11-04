# Review r388, Gate 2 on "The separation attack, opened" (post F48, way (i))

*Adversarial review, derived cold from the definitions before the author's text was opened. Analysis only; the two numerical passes reported here are **screens** of hand results on objects built for the purpose, and no positive claim below rests on them. Brief: attack the separation clause $T\notin\mathop{\mathrm{spec}}(\widetilde N|_{\mathbf1^\perp})$ at twin pairs, settle the padded-pair question first.*

## Verdict in one line

**The decisive question is settled, positively and in full generality: $\theta$ is NEVER an eigenvalue of a pure critical $M$**, so the separation holds at *every* padded pair of *every* pure critical point, not merely at [post F48](../findings/second-order.md)'s witness. **Against that, the section's own method is refuted: Constraints 1 and 3 (and $x\perp\mathbf1$ with them), are all instances of $\ker A\perp\mathop{\mathrm{ran}}A$ for $A=\widetilde N-T$, hence satisfied by every member of the $T$-eigenspace, so no number of them can ever be inconsistent.** Only Constraint 2 carries content, and its recorded form throws away the term that closes the padded case.

## 0. Notation and the cold relations

$I=[n]\setminus\{j,k\}$, $N=M^{(jk)}$, $u_i=M_{ij}$, $v_i=M_{ik}$, $\widetilde N=N+\mathop{\mathrm{diag}}(u+v)$, $T=\theta+M_{jk}$. Criticality is $M_{il}^2+(M^2)_{il}=\theta M_{il}$ for $i\ne l$; $M$ is hollow and symmetric with $M\mathbf1=0$, $\lVert M\rVert_F^2=2$, $\theta>0$.

Splitting $(M^2)_{ij}$ over $I\cup\{j,k\}$ for $i\in I$ gives $Nu=\theta u-u\circ u-M_{jk}v$ and $Nv=\theta v-v\circ v-M_{jk}u$, hence

$$\widetilde Nu=\theta u+u\circ v-M_{jk}v,\qquad \widetilde Nv=\theta v+u\circ v-M_{jk}u,\qquad \widetilde N\mathbf 1=0 .$$

The last one is $N\mathbf1=-(u+v)$ from $M\mathbf1=0$, cancelling the added diagonal exactly. Subtracting the first two reproduces [post F47](../findings/second-order.md) cold: $\widetilde N(u-v)=T(u-v)$ with $\langle u-v,\mathbf1\rangle=0$. Criticality at $(j,k)$ gives $\langle u,v\rangle=M_{jk}(\theta-M_{jk})$, and row $j$ of $M\mathbf1=0$ gives $\langle u,\mathbf1\rangle=\langle v,\mathbf1\rangle=-M_{jk}$.

## 1. THE DECISIVE QUESTION, settled, and it is a theorem, not a check

### 1a. The recorded gap is stated on the wrong interval

[Lemma L97](../findings/diagonal-half.md) boxes $K^2-\lambda K\succeq0$, "equivalently **$K$ has no eigenvalue in $(0,\lambda)$**", the **open** interval. The endpoint is addressed nowhere in [findings/](../findings/) or [ATTEMPTS.md](../ATTEMPTS.md). The endpoint is exactly what the padded pair asks about, since there $\widetilde N=M'$ and $T=\theta$.

### 1b. Result r388.1, the gap is half-open: $\mathop{\mathrm{spec}}(M)\cap(0,\theta]=\varnothing$

*Hypotheses: $M$ hollow, symmetric, $M\mathbf1=0$, off-diagonal criticality, $\theta>0$. Nothing else, no maximality, no band, no connectivity, no $\lVert M\rVert_F^2=2$.*

**Proof.** Off the diagonal, criticality reads $(M^2-\theta M)_{il}=-M_{il}^2$; on the diagonal, hollowness gives $(M^2-\theta M)_{ii}=\sum_l M_{il}^2$. So

$$M^2-\theta M=L(w),\qquad w_{il}=M_{il}^2\ge0,$$

the weighted graph Laplacian, [Lemma L97](../findings/diagonal-half.md)'s identity. Its kernel is spanned by the indicators $\mathbf 1_{C_t}$ of the connected components of $\{w_{il}>0\}$. **Each of those indicators is killed by $M$:** for $i\in C_t$, $(M\mathbf 1_{C_t})_i=\sum_{l\in C_t}M_{il}=\sum_l M_{il}=0$ because $M_{il}=0$ off the component; for $i\notin C_t$ every term is $0$ already. Now suppose $Mx=\theta x$. Then $L(w)x=(\theta^2-\theta\cdot\theta)x=0$, so $x\in\ker L(w)=\mathop{\mathrm{span}}\{\mathbf1_{C_t}\}$, so $Mx=0$, so $\theta x=0$, so $x=0$ since $\theta>0$. $\square$

**Two corollaries.**

- **$\lambda_{\max}(M)>\theta$ strictly, at every pure critical point.** $\mathop{\mathrm{tr}}M=0$ with $M\ne0$ forces $\lambda_{\max}>0$, and the half-open gap then forces $\lambda_{\max}>\theta$. This upgrades [post F48](../findings/second-order.md)'s "**strictly** whenever $\lambda_1>\theta$, which holds at every sphere product" to an unconditional statement.
- **The separation clause holds at every padded pair of every pure critical point.** There $\widetilde N=M'$, $M'$ is itself a pure critical point at the same $\theta$, $T=\theta$, and $\theta\notin\mathop{\mathrm{spec}}(M')$ at all, so a fortiori not on $\mathbf1^\perp$.

### 1c. Verdicts on post F48

| Claim | Verdict |
| --- | --- |
| $\lambda_{\max}(\widetilde N)\le T$ is FALSE at padded pairs | **CONFIRMED**, and strengthened: false at the padded pair of *every* pure critical point, by r388.1's first corollary |
| The separation survives at the padded pair | **CONFIRMED**, and generalised from one witness to a theorem (r388.1) |
| $\mathop{\mathrm{spec}}(M)\cap(0,\theta)=\varnothing$ (the quoted gap) | **CORRECTED**, the true gap is $(0,\theta]$ |
| [ATTEMPTS.md](../ATTEMPTS.md) tail: "post F48's counterexample has $T$ genuinely in the spectrum of $\widetilde N$ but not with an eigenvector violating the clause" | **REFUTED, with the record's own witness.** At the padded $S^6\times S^6$, $\widetilde N=M'$ has $\mathop{\mathrm{spec}}=\{-1/\sqrt{55}\ (\times10),\ 0,\ 10/\sqrt{55}\}$ while $T=\theta=\sqrt{55}/6$. The nearest eigenvalue is $10/\sqrt{55}=1.348400$ against $\theta=1.236033$, a distance of $\alpha(p-1)/p=0.112367$. **$T$ is not in the spectrum at all**, so the sentence's reason for the clause surviving is not the reason it survives. What is true there is only $\lambda_{\max}>T$, which is what [post F48](../findings/second-order.md) itself says |

### 1d. The exact spectra, derived by hand

$S^m\times S^m$ as the two-block matrix: entries $a$ within a factor, $b$ across, $(m-1)a+mb=0$, $\theta=(m-1)(2m-1)a/m$, $a^2=1/((m-1)(2m-1))$. These reproduce the section's $\gamma^2=\frac{m-1}{m^2(2m-1)}$, $\alpha=\frac m{m-1}|\gamma|$, $\theta=(2m-1)|\gamma|$, $\theta\alpha=1/m$ exactly, so the model is the record's.

- **$\mathop{\mathrm{spec}}(M')=\{-a^{(2m-2)},\ 0,\ 2a(m-1)\}$.** With $2a(m-1)-\theta=a(m-1)/m>0$ and $-a<0$, $\theta$ misses the spectrum by $a(m-1)/m$, the padded pair, done directly.
- **Within-factor pair** ($u=v$, so a twin pair; $M_{jk}=a$, $T=\theta+a=a(2m^2-2m+1)/m$):
$$\mathop{\mathrm{spec}}(\widetilde N)=\Big\{a^{(m-3)},\ \tfrac{-a(3m-2)}m^{(m-1)},\ 0,\ \tfrac{2a(m-1)^2}m\Big\}.$$
$T$ equals none of these at any $m\ge3$: the three equalities force $2p^2-3p+1=0$, $2p^2+p-1=0$ and $p=\tfrac12$ respectively. **Separation CONFIRMED**, and in fact $\lambda_{\max}(\widetilde N)=2a(m-1)^2/m<T$ there, so the trace bound has room.

*Screen (seconds, hand-built matrices, reported as a screen): criticality residual $\le3\times10^{-17}$ at $m=4,5,6,8$; all multiplicities and values above reproduced to $10^{-9}$; $\lVert u\rVert^2=M_{jk}(\theta-M_{jk})$ to $10^{-16}$; at the padded $n=14$ point $\dim\ker L(w)=3=$ the component count, and $\min|\theta-\mathop{\mathrm{spec}}|=0.112367$.*

## 2. Constraint 1, the algebra is right and the content is empty

**The identity is CONFIRMED.** At a twin pair $\widetilde Nu=(\theta-M_{jk})u+u\circ u$ (specialise §0), and pairing against $x$ gives $\langle u\circ u,x\rangle=2M_{jk}\langle u,x\rangle$. Every step checks.

**Its content is REFUTED.** Substituting the identity back, $u\circ u-2M_{jk}u=(\widetilde N-T)u$. So Constraint 1 is
$$\langle(\widetilde N-T)u,\ x\rangle=0,$$
which holds for *every* $x\in\ker(\widetilde N-T)$ by symmetry of $\widetilde N$, it is $\ker A\perp\mathop{\mathrm{ran}}A$. **The same is true of $x\perp\mathbf1$:** $(\widetilde N-T)\mathbf1=-T\mathbf1$ and $T>0$, so even the ambient hypothesis of the clause is in this family. A hypothetical $T$-eigenvector satisfies all of them by construction, so **no collection of such conditions can ever be contradictory**, and the section's stated next step, "close the pair of constraints against $\lVert x\rVert=1$ and $\langle\mathbf1,x\rangle=0$, which is four scalar conditions on $x$", cannot reach a contradiction from Constraints 1 and 3.

*What survives is a multiplicity bound, not an exclusion.* Each explicit $(\widetilde N-T)y$ that is independent of the others cuts $\dim\ker(\widetilde N-T)$ by one, so $k$ of them give $\mathop{\mathrm{mult}}(T)\le|I|-k$. Driving that to $0$ needs $|I|$ independent vectors with known $\widetilde N$-image, i.e. knowing $\widetilde N$ outright. **The "codimension two" reading is arithmetically CONFIRMED and does no work.**

**The parenthetical is REFUTED, twice.** The record says: *"if $u\circ u-2M_{jk}u$ happened to be a multiple of $\mathbf1$ the constraint would be empty, which is exactly the constant-$u$ case where $u$ itself is an eigenvector."*

1. $u\circ u-2M_{jk}u=c\mathbf1$ says each $u_i$ solves $t^2-2M_{jk}t-c=0$, so **$u$ takes at most two values, with the two values summing to $2M_{jk}$** (Vieta). Constant $u$ is the coincident-root sub-case, not the case.
2. Constant $u$ means $u\in\mathop{\mathrm{span}}\{\mathbf1\}$, and $\widetilde N\mathbf1=0$, so $u$ is an eigenvector at $\mathbf 0$, not at $T=\theta+M_{jk}>0$. The clause is untouched by it.

## 3. Constraint 2, every coefficient CONFIRMED, and the recorded form is weaker than the truth

**Recomputation.** With $X$ the zero-extension of $x$, $\widetilde Nx=Tx$ gives $Nx=Tx-2u\circ x$, so $(MX)_i=(T-2u_i)x_i$ on $I$ and $(MX)_j=(MX)_k=c:=\langle u,x\rangle$. With $S_1=\sum u_ix_i^2$, $S_2=\sum u_i^2x_i^2$, $\lVert x\rVert=1$:
$$\lVert MX\rVert^2=T^2-4TS_1+4S_2+2c^2,\qquad X^{\mathsf T}MX=T-2S_1 .$$
Their difference against $\theta$, using $T-\theta=M_{jk}$ and $4T-2\theta=2\theta+4M_{jk}$, is exactly the boxed
$$T\,M_{jk}-(2\theta+4M_{jk})S_1+4S_2+2c^2\ \ge\ 0 .$$
**CONFIRMED, coefficient by coefficient.**

**Result r388.2, it is an identity, and the record discards the term that matters.** The left side is $X^{\mathsf T}L(w)X$, and evaluating the Laplacian form directly,
$$X^{\mathsf T}L(w)X=\underbrace{\tfrac12\sum_{i,l\in I}N_{il}^2(x_i-x_l)^2}_{=:R\ \ge0}\ +\ 2S_2 ,$$
the $2S_2$ being the two edge families $\{j,i\}$ and $\{k,i\}$, where $X$ drops from $x_i$ to $0$. Hence

$$\boxed{\ T\,M_{jk}-(2\theta+4M_{jk})\,S_1+2S_2+2c^2\ =\ R\ \ge\ 0\ }$$

with equality iff $x$ is constant on each connected component of $\{N_{il}\ne0\}$. **This is strictly stronger than the recorded inequality by $2S_2$, and the difference is decisive:**

- At a **padded pair** ($u=0$, $M_{jk}=0$) the recorded form reads $0\ge0$ and says nothing, the same degeneracy the section correctly notes for Constraint 1. The identity reads $R=0$, so $x$ is constant on components of $M'$, so $M'x=0$ by §1b's kernel computation, so $\theta x=0$ and $x=0$. **The padded case falls out of Constraint 2 alone once it is written as an identity**, an independent second proof of §1b's corollary, and confirmation that Constraint 2 is the load-bearing one.

**Result r388.3, a fourth constraint, from the same source and outside the tautological family.** $L(w)\succeq0$ gives Cauchy–Schwarz in its semi-inner product. With $e=e_j+e_k$: $e^{\mathsf T}L(w)e=2\lVert u\rVert^2$ and $X^{\mathsf T}L(w)e=-2\langle u\circ u,x\rangle=-4M_{jk}c$ (the last step by Constraint 1). So
$$8\,M_{jk}^2c^2\ \le\ \lVert u\rVert^2\big[T M_{jk}-(2\theta+4M_{jk})S_1+4S_2+2c^2\big].$$
Vacuous at padded pairs, live at every other twin pair.

## 4. Constraint 3, CONFIRMED, and simplicity of $\lambda_1$ is NOT needed

**The derivation is CONFIRMED.** $(Mw)_i=\lambda_1w_i$ on $I$ gives $N\Pi w=\lambda_1\Pi w-w_0(u+v)=\lambda_1\Pi w-2w_0u$ at a twin pair, and pairing $(\widetilde N-T)\Pi w$ against $x$ gives the displayed relation.

**Silently used hypothesis: $w_j=w_k$.** It is used to write $w_0$ and is not stated. **It is dischargeable, and simplicity of $\lambda_1$ is not the way to do it.** At a twin pair the transposition $\sigma=(jk)$ is an automorphism of $M$ ($u=v$, $M_{jj}=M_{kk}=0$), so $M$ commutes with $P_\sigma$ and every eigenspace splits into $P_\sigma$-parity parts. The odd part of $\mathbb R^n$ is the single line $\mathbb R(e_j-e_k)$, and $M(e_j-e_k)=-M_{jk}(e_j-e_k)$, so the odd spectrum of $M$ is exactly $\{-M_{jk}\}$. Since $\lambda_1>0$ (as $\mathop{\mathrm{tr}}M=0$, $M\ne0$) and $M_{jk}\ge0$ at a twin pair (§5), $\lambda_1\ne-M_{jk}$, so **the whole $\lambda_1$-eigenspace is even and every top eigenvector has $w_j=w_k$**, whatever the multiplicity. *Record this: it removes an unprovable side condition from the constraint.*

**Its content is REFUTED for the same reason as Constraint 1**, the section itself writes it as $\langle(\widetilde N-T)y,x\rangle=0$, which is the tautological family.

## 5. Result r388.4, the twin dichotomy, and what is actually left open

At a twin pair, $\langle u,v\rangle=M_{jk}(\theta-M_{jk})$ becomes $\lVert u\rVert^2=M_{jk}(\theta-M_{jk})\ge0$, so $0\le M_{jk}\le\theta$. And $M_{jk}=\theta$ forces $u=0$, hence row $j$ has sum $\theta\ne0$, contradicting $M\mathbf1=0$. So

$$\textbf{at every twin pair}\quad 0\le M_{jk}<\theta,\qquad M_{jk}=0\iff u=0\iff \text{rows }j,k\text{ vanish}.$$

**"Padded pair" and "twin pair with $M_{jk}=0$" are therefore the same set**, and r388.1 closes all of it. *The open case is exactly: twin pairs with $0<M_{jk}<\theta$*, where $\lVert u\rVert^2$ is pinned, $\langle u,\mathbf1\rangle=-M_{jk}$, and Constraint 2's identity plus r388.3 are the instruments that are not tautologies. Screened at $S^m\times S^m$: $\lVert u\rVert^2=M_{jk}(\theta-M_{jk})$ to $10^{-16}$ at $m=4,5,6,8$.

## 6. Priority 6, $\widetilde N(u\circ u)$: the chain cannot be terminated, and terminating it would not help

**REFUTED as a route.** The twin identity rearranges to $u\circ u=\widetilde Nu-(\theta-M_{jk})u$, so **$u\circ u$ lies in the Krylov space $\mathcal K(\widetilde N,u)$**, and $\widetilde N(u\circ u)=\widetilde N^2u-(\theta-M_{jk})\widetilde Nu$ is a restatement of $\widetilde N^2u$. Two independent obstructions:

1. **Criticality cannot supply it.** $N(u\circ u)_i=\sum_l N_{il}u_l^2$ is cubic in the entries of $M$, while criticality is quadratic. (Contrast $(N\circ N)u$, which *is* reachable: $N_{il}^2=\theta N_{il}-(M^2)_{il}$ off the diagonal. The chain in $\circ$-powers and the chain in $\widetilde N$-powers are different chains, and only the second is what Constraint 1 lives in.)
2. **Even given it, the resulting condition is $\langle(\widetilde N-T)(u\circ u),x\rangle=0$**, the tautological family again. It cuts the multiplicity by at most one and can never exclude the eigenvector.

*So "the constraints are a chain in the $\circ$-powers of $u$, and closing it needs one relation that terminates the chain" names a goal that is both unreachable from criticality and inert if reached.* **What the section needs instead is more inequalities of Constraint 2's kind** (evaluations of $L(w)\succeq0$, or of its kernel structure, on test vectors built from $x$) because those are the only statements in play that a hypothetical eigenvector does not satisfy automatically.

## 7. Summary table

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | At a twin pair the clause is unconditional separation ($o=0$) | **CONFIRMED** |
| 2 | $\widetilde Nu=(\theta-M_{jk})u+u\circ u$ at a twin pair | **CONFIRMED** (cold; general form $\widetilde Nu=\theta u+u\circ v-M_{jk}v$) |
| 3 | Constraint 1, $\langle u\circ u,x\rangle=2M_{jk}\langle u,x\rangle$ | **CONFIRMED as an identity; REFUTED as content**, it is $\ker A\perp\mathop{\mathrm{ran}}A$, $A=\widetilde N-T$ |
| 4 | The $T$-eigenspace lies in a codimension-two subspace | **CONFIRMED, inert**, a multiplicity bound, never an exclusion; $x\perp\mathbf1$ is in the same family |
| 5 | The degenerate case is "constant $u$, where $u$ is an eigenvector" | **REFUTED**, it is $u$ two-valued with values summing to $2M_{jk}$; and constant $u$ is a $0$-eigenvector, not a $T$-one |
| 6 | Constraint 2's coefficients | **CONFIRMED exactly**; **CORRECTED** to the identity $\cdots+2S_2+2c^2=R\ge0$ (r388.2), which closes the padded case that the recorded inequality cannot see |
| 7 | Constraint 3 from the top eigenvector | **CONFIRMED**; silent hypothesis $w_j=w_k$ **discharged without simplicity of $\lambda_1$** |
| 8 | The three constraints are independent | **CORRECTED**, 1, 3 and $x\perp\mathbf1$ collapse into one tautology; only 2 is independent content |
| 9 | The obstruction is that $\widetilde N(u\circ u)$ is unknown | **REFUTED**, $u\circ u\in\mathcal K(\widetilde N,u)$; unreachable from quadratic criticality and inert if reached |
| 10 | [post F48](../findings/second-order.md): $\lambda_{\max}(\widetilde N)\le T$ false at padded pairs | **CONFIRMED and strengthened**, $\lambda_{\max}(M)>\theta$ strictly at every pure critical point |
| 11 | [post F48](../findings/second-order.md): the separation survives padding | **CONFIRMED and promoted to a theorem** (r388.1) |
| 12 | [ATTEMPTS.md](../ATTEMPTS.md): "$T$ genuinely in the spectrum" at F48's counterexample | **REFUTED**, witness $=$ the record's own padded $S^6\times S^6$; distance $0.112367$ |
| 13 | [Lemma L97](../findings/diagonal-half.md): no eigenvalue in $(0,\lambda)$ | **CORRECTED** to $(0,\lambda]$ (r388.1) |

## 8. What to record

- **r388.1** $\mathop{\mathrm{spec}}(M)\cap(0,\theta]=\varnothing$ at every pure critical point; corollaries $\lambda_{\max}(M)>\theta$ strictly, and the separation clause proved at every padded pair. *Belongs in [diagonal-half.md](../findings/diagonal-half.md) beside [Lemma L97](../findings/diagonal-half.md), with a pointer from [post F48](../findings/second-order.md).*
- **r388.2** Constraint 2 as an identity with $R$ the Dirichlet energy on the $N$-graph.
- **r388.3** the Cauchy–Schwarz constraint from $e_j+e_k$.
- **r388.4** the twin dichotomy $0\le M_{jk}<\theta$ with $M_{jk}=0\iff$ padded, so the open set is $0<M_{jk}<\theta$.
- **A fence post**: no condition of the form $\langle(\widetilde N-T)y,x\rangle=0$ can contribute to the separation, whatever $y$ is. This retires the whole "chain of known images" programme and covers Constraints 1 and 3, $x\perp\mathbf1$, and any successor of the same shape.
