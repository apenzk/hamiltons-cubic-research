# Review r858 of I74: the Gram-matrix reading of Ricci-flatness, the rank bound $\mathop{\mathrm{rank}}S\ge n$, and the flexibility claim

**Reviewer r858, adversarial, cold brief.** The brief was read in full and nothing else of the record was opened. No computation was run: every value below is exact and obtained by hand, and every witness is exhibited in closed form. The brief's sentence "the one other file you may open is the Lean file named below" names no file, so no Lean file was opened. Log: [agent_logs/review-r858-gram.log](../agent_logs/review-r858-gram.log).

## Claim table

| # | Claim as written | Verdict | Reason |
|---|---|---|---|
| C1 | Ricci-flatness of $W=\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$ is exactly $S\lambda=0$ | **CONFIRMED** | both directions hold, needing only that $M=\sum\lambda_\alpha\Pi_\alpha$ lies in $\mathop{\mathrm{span}}\{\Pi_\beta\}$ and that $\mathop{\mathrm{tr}}(AB)$ is positive definite on $\mathrm{Sym}^2\mathbb R^n$ |
| C2 | The Ricci-flat weightings are precisely $\ker S$, of dimension $\binom n2-\mathop{\mathrm{rank}}S$ | **CONFIRMED** | $S$ symmetric of size $\binom n2$, and at the coordinate configuration $\ker S$ *coincides with* (not merely matches the dimension of) the zero-row-sum weightings of $K_n$ |
| C3 | $S$ is positive semidefinite and $\mathop{\mathrm{rank}}S=\dim\mathop{\mathrm{span}}\{\Pi_\alpha\}$ | **CONFIRMED** | $S$ is a Gram matrix in $(\mathrm{Sym}^2\mathbb R^n,\mathop{\mathrm{tr}}(AB))$, and both facts are scale-invariant, so no normalisation is load-bearing here |
| C4 | $\Xi\ge(\mathop{\mathrm{tr}}S)^2/\mathop{\mathrm{rank}}S$ with $\mathop{\mathrm{tr}}S=n(n-1)$ | **CONFIRMED** | Cauchy–Schwarz on the nonzero eigenvalues, positive semidefiniteness not needed, and $S_{\alpha\alpha}=2$ gives the trace |
| C5 | $\mathop{\mathrm{rank}}S\ge n$ at every orthonormal decomposable basis | **CONFIRMED**, one line missing and the range unstated | the block treats only $\mathop{\mathrm{rank}}S=n-1$, while $\mathop{\mathrm{rank}}S<n-1$ needs the (trivial) monotonicity of $(\mathop{\mathrm{tr}}S)^2/r$. Holds for $n\ge3$ and **fails at $n=2$**, where $\mathop{\mathrm{rank}}S=1$. A shorter proof exists that never invokes L201 (§5.3) |
| C6 | Coordinate configurations attain rank $n$, spectrum $2n-2,\,n-2,\,0$ | **CONFIRMED** for $n\ge3$ | $S=BB^{\mathsf T}$ for the $K_n$ incidence matrix $B$, so the nonzero spectrum is that of $J+(n-2)\mathrm{Id}$: closed form at $n=4$ is $6,2^{(3)},0^{(2)}$ and at $n=5$ is $8,3^{(4)},0^{(5)}$ |
| C7 | The Ricci-flat weight space is at most $\binom n2-n$, attained at the coordinate configuration | **CONFIRMED**, and strengthened | immediate from C5 and C6, and further $\mathop{\mathrm{rank}}S=n$ **forces** integrality, so the coordinate configuration is the *unique* maximiser of flexibility, which the block only asserts |
| C8 | "A generic configuration admits no nonzero Ricci-flat weighting at all", by $\binom n2$ unknowns against $\tfrac{n(n+1)}2$ conditions | **REFUTED AS STATED** | the count is not an argument: the effective number of conditions is $\mathop{\mathrm{rank}}S$, and it is $<\binom n2$ at *both* configurations the record exhibits (kernel dimensions 2 and 1). The conclusion is nonetheless **true at $n=4$**, by the closed-form witness of §7.3, which the block does not supply. Open at $n\ge5$ |
| C9 | $\sum_\gamma T_{\alpha\beta\gamma}$ is $S$ with the diagonal zeroed, $\hat S=S-2\,\mathrm{Id}$, and (B) reads $(S\lambda)_k=0$ | **CONFIRMED** | the marginal is $\lVert[\omega_\alpha,\omega_\beta]\rVert^2$, which is $S_{\alpha\beta}$ off the diagonal by Given 8 and $0$ on it, and (B) at every index is exactly $S\lambda=0$ |
| C10 | Summed (C) matches "once $\mathop{\mathrm{tr}}W=0$"; "two independent arrivals at $S\lambda=0$"; "$\theta$ is absent from both" | **CONFIRMED AS ALGEBRA**, three wordings wrong | the match needs Ricci-flatness (or positive semidefiniteness of $S$) as a second input, not $\mathop{\mathrm{tr}}W=0$ alone; $\theta$ drops only *because* $\mathop{\mathrm{tr}}W=0$; and (B) and the $\Theta$-contraction are two encodings of one equation, not two independent arrivals |
| C11 | Scope, not claimed in the block | **finding** | $W_{\mathbb{CP}^2}$ admits **no** orthonormal decomposable eigenbasis, so none of C1–C8 says anything about the record's own extremal witness at $n=4$ |

## One line someone can act on

Keep the whole chain and fix the genericity paragraph: replace the parameter count with the $n=4$ witness of §7.3 (pencil plus $\Lambda^2U$, exact entries), add "$n\ge3$" to every statement, and record the two by-products, that $\mathop{\mathrm{rank}}S=n$ characterises the coordinate configuration and that the rank bound needs no L201.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. At orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_P$, the orthogonal projection onto $P=\mathrm{span}\{u,v\}$. This holds for exactly this normalisation: the $1/\sqrt2$ convention returns $\tfrac12\Pi_P$.
- $\omega$ is decomposable when $\omega=u\wedge v$, equivalently $\omega\wedge\omega=0$. The record's wedge is TWICE the Pfaffian.
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free. $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.
- The inner product on the $\Pi_\alpha$ is the plain $\mathop{\mathrm{tr}}(AB)$ with no factor $\tfrac12$ (Given 10).

Two conventions were re-derived rather than taken on trust, because the whole block turns on them. With $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$ and $X=u\wedge v$ skew, $XX^{\mathsf T}=-X^2=uu^{\mathsf T}+vv^{\mathsf T}$ at orthonormal $u,v$, so $\Pi_\alpha:=\omega_\alpha\omega_\alpha^{\mathsf T}$ is the plane projection. And $\langle u\wedge v,u'\wedge v'\rangle=(u\cdot u')(v\cdot v')-(u\cdot v')(v\cdot u')$, the determinant of the Gram matrix of the four vectors, which is what §3.2 needs.

One notational hazard worth naming: the block writes $W=\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$ for an operator on $\Lambda^2\mathbb R^n$ and $\Pi_\alpha=\omega_\alpha\omega_\alpha^{\mathsf T}$ for an $n\times n$ matrix. The two outer products live in different spaces. Nothing in the argument confuses them, but a reader can.

## Hypothesis inventory

What the claims actually assume, item by item.

1. $n\ge3$. **Never stated in the block**, and needed: at $n=2$ the coordinate configuration has $\mathop{\mathrm{rank}}S=1<n$, so C5 and C6 are both false there. L201 (Given 9) carries $n\ge3$, so the hypothesis is available, it is simply not written down.
2. $\{\omega_\alpha\}_{\alpha=1}^{\binom n2}$ is an orthonormal basis of $\Lambda^2\mathbb R^n$ and every $\omega_\alpha$ is decomposable. Nothing weaker: the identification of $\omega_\alpha\omega_\alpha^{\mathsf T}$ with a rank-$2$ projection, the range $S_{\alpha\beta}\in[0,1]$ of Given 8, L201 and the cap of Given 10 all consume decomposability.
3. $\lambda\in\mathbb R^{\binom n2}$ arbitrary, zeros allowed. No positivity, no nondegeneracy, no trace condition. Trace-freeness is a *consequence* of $S\lambda=0$ (§9), not a hypothesis.
4. Givens 1, 8, 9, 10 and 11 are consumed as established: $\Theta(\Lambda^2\mathbb R^n)=(n-1)\mathrm{Id}$; $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)\in[0,1]$; integrality forces a common frame; $\Xi\le n^2(n-1)$ with equality exactly at integrality; the Johnson spectrum. Given 10's cap was re-derived from Givens 1 and 8 in §4.2, so it is not an unchecked input to the rank bound.
5. First Bianchi is **not** a hypothesis and does not need to be: by Given 6, $\mathrm{Alt}(W)=\tfrac16\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$ for every weighting of a decomposable basis, since each $\omega_\alpha\wedge\omega_\alpha=0$. So $S\lambda=0$ alone puts $W$ in $\mathcal W_n$. This is what makes the block's programme worth running, and the block does not say it.
6. Criticality is nowhere assumed in C1–C8. It enters only through relation (C) in C10.

## 1. Attack 1. Is Ricci-flatness really equivalent to $S\lambda=0$?

**Verdict: CONFIRMED. Both directions hold, and the block's one-clause justification is the right one, compressed to the point of obscurity.**

### 1.1 What the equation is

By Given 2, Ricci-flatness of a symmetric $W$ is $\sum_\mu\lambda_\mu\Theta(E_\mu)=0$ over any orthonormal eigen-decomposition. Here every eigenline is spanned by a decomposable unit $\omega_\alpha$, and by Given 1 $\Theta$ is basis-independent and additive, so grouping repeated eigenvalues or splitting them changes nothing:
$$\sum_\mu\lambda_\mu\Theta(E_\mu)=\sum_\alpha\lambda_\alpha\,\omega_\alpha\omega_\alpha^{\mathsf T}=\sum_\alpha\lambda_\alpha\Pi_\alpha=:M\in\mathrm{Sym}^2\mathbb R^n.$$
So Ricci-flatness is $M=0$, an equation in the $\tfrac{n(n+1)}2$-dimensional space of symmetric $n\times n$ matrices. This step is clean, and it is worth noting it needs no decomposability: it needs only that the eigenbasis is orthonormal.

### 1.2 Forward

$M=0\Rightarrow\mathop{\mathrm{tr}}(M\Pi_\beta)=0$ for every $\beta$, and $\mathop{\mathrm{tr}}(M\Pi_\beta)=\sum_\alpha\lambda_\alpha\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=(S\lambda)_\beta$. So $S\lambda=0$. Trivial and correct.

### 1.3 Reverse, which is the direction with content

$S\lambda=0$ says $M\perp\Pi_\beta$ for every $\beta$, hence $M\perp\mathop{\mathrm{span}}\{\Pi_\beta\}$ in the trace form. But $M\in\mathop{\mathrm{span}}\{\Pi_\alpha\}$ by construction. So $M$ lies in $V\cap V^\perp$ with $V=\mathop{\mathrm{span}}\{\Pi_\alpha\}$, which is $0$ **provided the form is positive definite**. It is: $\mathop{\mathrm{tr}}(A^2)=\sum_{ij}a_{ij}^2$ for symmetric real $A$.

So exactly two ingredients are needed, and only one of them is what the block names:

- $M$ lies in the span of the $\Pi_\alpha$ (this is what the block's clause "the $\Pi$'s spanning the same space" must mean, and it is immediate from the definition of $M$);
- the trace form is an inner product on real symmetric matrices, so a vector orthogonal to its own span vanishes.

The second is where a reader could go wrong, since over $\mathbb C$ or with an indefinite form the step fails outright. It is true here and the block should say so in four words. Nothing is being assumed beyond these two facts, and in particular no decomposability and no linear independence of the $\Pi_\alpha$.

A sharper form, which matters in §8: orthogonality against $\{\Pi_\beta:\lambda_\beta\ne0\}$ already suffices, because $M$ lies in the span of that subfamily.

## 2. Attack 2. Is $\ker S$ the space of Ricci-flat weightings, of dimension $\binom n2-\mathop{\mathrm{rank}}S$?

**Verdict: CONFIRMED, and at the coordinate configuration the two spaces coincide, they do not merely have equal dimension.**

$S$ is a real symmetric matrix of size $N=\binom n2$, so $\dim\ker S=N-\mathop{\mathrm{rank}}S$ with no further hypothesis. Combined with §1, the Ricci-flat weightings of a fixed configuration are exactly $\ker S$, of that dimension. The block's inference "a NONZERO critical point requires a degenerate Gram matrix" is then correct, reading degenerate as singular, that is $\mathop{\mathrm{rank}}S<\binom n2$.

### 2.1 The coordinate configuration, explicitly

Take $\omega_{ij}=e_i\wedge e_j$, so $\Pi_{ij}=E_{ii}+E_{jj}$ and $S_{(ij),(kl)}=\lvert\{i,j\}\cap\{k,l\}\rvert$. Then
$$\sum_{i<j}\lambda_{ij}\Pi_{ij}=\mathop{\mathrm{diag}}(r_1,\dots,r_n),\qquad r_i=\sum_{j\ne i}\lambda_{ij},$$
and $(S\lambda)_{(kl)}=\mathop{\mathrm{tr}}\big(\mathop{\mathrm{diag}}(r)(E_{kk}+E_{ll})\big)=r_k+r_l$. So $S\lambda=0$ says $r_k+r_l=0$ for every pair $k<l$. At $n\ge3$ that forces $r=0$: from $r_k+r_l=0$ and $r_k+r_m=0$ we get $r_l=r_m$, so all entries are equal and $2r=0$.

Hence $\ker S$ **is** the space of zero-row-sum weightings of $K_n$, as a set and not merely up to dimension. The map $\lambda\mapsto r$ is onto $\mathbb R^n$ for $n\ge3$, since its transpose $x\mapsto(x_i+x_j)_{i<j}$ is injective by the same computation, so the rank is $n$ and $\dim\ker S=\binom n2-n$. The block's count is right.

### 2.2 A consistency check the block does not run

At $n=3$: $\binom32-3=0$, so **no** decomposable orthonormal basis of $\Lambda^2\mathbb R^3$ carries a nonzero Ricci-flat weighting. Since every $2$-form on $\mathbb R^3$ is decomposable, every orthonormal eigenbasis qualifies, so this recovers $\mathcal W_3=0$ from C1 and C6 alone. That the machinery reproduces a known truth at the bottom of the range is evidence for it.

## 3. Attack 3. Is $S$ positive semidefinite, and is $\mathop{\mathrm{rank}}S=\dim\mathop{\mathrm{span}}\{\Pi_\alpha\}$?

**Verdict: CONFIRMED. Both are the Gram-matrix facts, and neither is sensitive to the normalisation.**

### 3.1 Both statements

$S_{\alpha\beta}=\langle\Pi_\alpha,\Pi_\beta\rangle_{\mathop{\mathrm{tr}}}$ is by definition the Gram matrix of the finite family $\{\Pi_\alpha\}$ in the Euclidean space $(\mathrm{Sym}^2\mathbb R^n,\mathop{\mathrm{tr}}(AB))$. Write $\Pi$ for the linear map $\mathbb R^N\to\mathrm{Sym}^2\mathbb R^n$, $c\mapsto\sum_\alpha c_\alpha\Pi_\alpha$. Then $S=\Pi^*\Pi$, whence $c^{\mathsf T}Sc=\lVert\Pi c\rVert^2\ge0$ and $\ker S=\ker\Pi$, so $\mathop{\mathrm{rank}}S=\mathop{\mathrm{rank}}\Pi=\dim\mathop{\mathrm{span}}\{\Pi_\alpha\}$. Note this also re-proves §1 in one line, since $\ker S=\ker\Pi$ *is* the statement "$S\lambda=0$ iff $\sum\lambda_\alpha\Pi_\alpha=0$".

### 3.2 Which normalisation each needs

Neither. Replacing $\mathop{\mathrm{tr}}(AB)$ by $\kappa\mathop{\mathrm{tr}}(AB)$ for $\kappa>0$ replaces $S$ by $\kappa S$: positive semidefiniteness and rank are unchanged. The normalisation is load-bearing elsewhere and only in the constants:

- $S_{\alpha\alpha}=\mathop{\mathrm{tr}}(\Pi_\alpha^2)=\mathop{\mathrm{tr}}\Pi_\alpha=2$ needs the plain trace, and it is what makes $\hat S=S-2\,\mathrm{Id}$ in C9 and $\mathop{\mathrm{tr}}S=n(n-1)$ in C4 come out as written. Under the $\tfrac12$ convention the diagonal would be $1$ and every constant in the block would move.
- $\Pi_\alpha=\omega_\alpha\omega_\alpha^{\mathsf T}$ being the *projection* rather than half of it needs the brief's $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$ with no $1/\sqrt2$, as the conventions section already warns.

### 3.3 A structural fact the block never states, and it is used below

By Given 1, $\sum_\alpha\Pi_\alpha=\Theta(\Lambda^2\mathbb R^n)=(n-1)\mathrm{Id}_n$ at **every** orthonormal decomposable basis. Contracting against $\Pi_\beta$:
$$(S\mathbf 1)_\beta=\mathop{\mathrm{tr}}\big((n-1)\mathrm{Id}\cdot\Pi_\beta\big)=2(n-1),\qquad\text{that is}\qquad S\mathbf 1=2(n-1)\,\mathbf 1 .$$
So $\mathbf 1$ is an eigenvector of $S$ with eigenvalue $2(n-1)$, universally. Three immediate consequences: $\mathrm{Id}\in\mathop{\mathrm{span}}\{\Pi_\alpha\}$ always; the all-ones weighting is never Ricci-flat; and the sharpened rank bound of §5.3.

## 4. Attack 4a. The inequality and the trace

**Verdict: CONFIRMED, and the cap it is set against is itself re-derivable from the givens.**

### 4.1 The two inputs

$\Xi=\sum_{\alpha\beta}S_{\alpha\beta}^2=\lVert S\rVert_F^2=\sum_i\sigma_i^2$ over the eigenvalues of $S$, and $\mathop{\mathrm{tr}}S=\sum_i\sigma_i$ with at most $r=\mathop{\mathrm{rank}}S$ nonzero terms. Cauchy–Schwarz on those $r$ terms gives $(\mathop{\mathrm{tr}}S)^2\le r\,\Xi$, that is $\Xi\ge(\mathop{\mathrm{tr}}S)^2/r$. Correct, and positive semidefiniteness is not needed for it, only for interpreting the equality case. $\mathop{\mathrm{tr}}S=2\binom n2=n(n-1)$ by §3.2. Both as written.

### 4.2 The cap, checked rather than assumed

Given 10 is quoted as established, but since the whole rank bound is a collision between the Cauchy–Schwarz floor and this cap, I re-derived it from Givens 1 and 8. Off the diagonal $S_{\alpha\beta}\in[0,1]$ by Given 8, so $S_{\alpha\beta}^2\le S_{\alpha\beta}$ there. From §3.3, $\mathbf 1^{\mathsf T}S\mathbf 1=2(n-1)\binom n2=n(n-1)^2$, so
$$\sum_{\alpha\ne\beta}S_{\alpha\beta}=n(n-1)^2-n(n-1)=n(n-1)(n-2),$$
which is Given 10's fixed total, and the diagonal contributes $\sum_\alpha 4=2n(n-1)$, which is Given 10's stated diagonal. Hence
$$\Xi\le 2n(n-1)+n(n-1)(n-2)=n(n-1)\big[2+n-2\big]=n^2(n-1),$$
with equality exactly when every off-diagonal entry is $0$ or $1$, which is integrality. Given 10 is internally consistent and independently reproduced, cap, total, diagonal and equality case alike.

## 5. Attack 4b. The rank bound, the item to be most sceptical about

**Verdict: CONFIRMED as a theorem for $n\ge3$. The written argument covers only $\mathop{\mathrm{rank}}S=n-1$ and leaves the cases below it to the reader, which is a gap in the writing rather than in the mathematics. A shorter proof exists that never touches L201, and it yields a converse the block asserts without proof.**

### 5.1 The block's step, and does it need Cauchy–Schwarz equality

At $r=n-1$: $\Xi\ge n^2(n-1)^2/(n-1)=n^2(n-1)$, and $\Xi\le n^2(n-1)$, so $\Xi=n^2(n-1)$. That is equality **in the cap**, which by Given 10 is integrality, which by L201 makes the planes the coordinate $2$-planes of some orthonormal frame, whose $S$ has rank $n$ by §6.1. So $r=n$ and $r=n-1$ at once, a contradiction. The block does not need Cauchy–Schwarz equality and does not use it, although it does follow. Correct as written.

### 5.2 Does it exclude every rank below $n$

**As written, no. As mathematics, yes, by one line the block omits.** For $r\le n-1$,
$$\Xi\ \ge\ \frac{n^2(n-1)^2}{r}\ \ge\ \frac{n^2(n-1)^2}{n-1}\ =\ n^2(n-1),$$
the second step because $r\mapsto(\mathop{\mathrm{tr}}S)^2/r$ decreases. For $r<n-1$ the second inequality is **strict**, so $\Xi>n^2(n-1)$ contradicts the cap outright, with no appeal to L201 or to the equality case. Only the boundary case $r=n-1$ needs the equality-case detour, which is exactly the case the block wrote. So the sceptical reading is answered: the conclusion $r\ge n$ is sound, and the sentence "The contradiction gives $\mathop{\mathrm{rank}}S\ge n$" does not follow from the displayed step alone. Insert the monotonicity remark and it does. Also $r\ge1$ throughout, since $S$ has diagonal $2$.

### 5.3 A proof of the same bound with no L201 and no case split

Using §3.3, the eigenvalue $\sigma_0=2(n-1)$ on $\mathbf 1$ is known exactly, so split it off. The remaining eigenvalues, on $\mathbf 1^\perp$, satisfy
$$\sum_{i\ge1}\sigma_i=n(n-1)-2(n-1)=(n-1)(n-2),\qquad \sum_{i\ge1}\sigma_i^2=\Xi-4(n-1)^2\le n^2(n-1)-4(n-1)^2=(n-1)(n-2)^2 .$$
There are $r-1$ nonzero terms among the $\sigma_i$, $i\ge1$, since $\sigma_0>0$ for $n\ge2$. Cauchy–Schwarz on them:
$$(n-1)^2(n-2)^2=\Big(\sum_{i\ge1}\sigma_i\Big)^2\le(r-1)\sum_{i\ge1}\sigma_i^2\le(r-1)(n-1)(n-2)^2 .$$
For $n\ge3$ the factor $(n-2)^2$ is positive, so dividing gives $n-1\le r-1$, that is
$$\boxed{\mathop{\mathrm{rank}}S\ \ge\ n\quad (n\ge3).}$$
This is strictly cheaper than the block's route: it uses Givens 1 and 8 only, through §3.3 and the cap of §4.2, and it never invokes L201 or the equality case. It is worth recording, because it decouples the rank bound from L201's audit status.

### 5.4 The converse the block asserts and does not prove

Run §5.3 at $r=n$. Both inequalities must then be equalities, so the $n-1$ nonzero eigenvalues on $\mathbf 1^\perp$ are all equal to $(n-1)(n-2)/(n-1)=n-2$, and $\Xi$ sits **exactly** at the cap $n^2(n-1)$. By Given 10 that is integrality, and by L201 the configuration is coordinate. Hence, for $n\ge3$,
$$\mathop{\mathrm{rank}}S=n\iff\text{the configuration is coordinate},$$
and the spectrum at $r=n$ is forced to be $2n-2,\,(n-2)^{(n-1)},\,0^{(\binom n2-n)}$ before one computes it. This upgrades the block's "the coordinate configuration is the most flexible one" from an attained bound to a **uniqueness** statement, which is what the last paragraph's "the diagonal one is its extreme point" wants to be saying.

### 5.5 The range

At $n=2$ the bound is false: $\Lambda^2\mathbb R^2$ is one-dimensional, $S=(2)$, $r=1<2=n$. The failure is traceable, since $\Xi=4=n^2(n-1)$ is at the cap and L201 carries $n\ge3$, so §5.3's division by $(n-2)^2$ is division by zero. No statement in the block carries a range for $n$ and every one of them needs $n\ge3$.

## 6. Attack 5. Coordinate configurations attain rank $n$

**Verdict: CONFIRMED for $n\ge3$, in closed form and by two routes.**

### 6.1 All $n$ at once, without the Johnson spectrum

Let $B$ be the $\binom n2\times n$ incidence matrix of $K_n$, row $(ij)$ carrying $1$ in columns $i$ and $j$. Then $(BB^{\mathsf T})_{(ij),(kl)}=\lvert\{i,j\}\cap\{k,l\}\rvert=S_{(ij),(kl)}$, so
$$S=BB^{\mathsf T},\qquad B^{\mathsf T}B=A(K_n)+(n-1)\mathrm{Id}=J_n+(n-2)\mathrm{Id}_n .$$
$S$ and $B^{\mathsf T}B$ share their nonzero spectrum. $J_n+(n-2)\mathrm{Id}$ has eigenvalue $n+(n-2)=2n-2$ on $\mathbf 1$ and $n-2$ on $\mathbf 1^\perp$, multiplicity $n-1$. So the spectrum of $S$ is
$$2n-2\ (\times1),\qquad n-2\ (\times\,n-1),\qquad 0\ \big(\times\binom n2-n\big),$$
and $\mathop{\mathrm{rank}}S=n$ for $n\ge3$, dropping to $1$ at $n=2$ where $n-2=0$. This matches Given 11 exactly, since $S=A(J(n,2))+2\,\mathrm{Id}$ and the Johnson eigenvalues $2(n-2),\,n-4,\,-2$ shift to $2n-2,\,n-2,\,0$. Both descriptions agree, and $S=BB^{\mathsf T}$ additionally re-proves positive semidefiniteness in this case with no reference to §3. The block's remark that "the projections span the frame's diagonal matrices" is right for $n\ge3$: $\mathop{\mathrm{span}}\{E_{ii}+E_{jj}\}$ is all diagonal matrices, of dimension $n$.

### 6.2 The two cases the brief asks for, in closed form

- $n=4$. $S=J_6+\mathrm{Id}_6-P$ where $P$ is the involution pairing complementary index pairs, since complementary planes are orthogonal and all other distinct pairs meet in a line. On $\mathbf 1$: $6+1-1=6$. On $\mathbf 1^\perp$: $S=\mathrm{Id}-P$, giving $0$ on the $P$-symmetric part (dimension $3-1=2$ after removing $\mathbf 1$) and $2$ on the $P$-antisymmetric part (dimension $3$). Spectrum $6,\,2^{(3)},\,0^{(2)}$, trace $6+6=12=n(n-1)$, $\Xi=36+3\cdot4=48=n^2(n-1)$, rank $4=n$.
- $n=5$. $J(5,2)$ is the complement of the Petersen graph, whose spectrum is $3,\,1^{(5)},\,(-2)^{(4)}$, so $J(5,2)$ has $9-3=6$, then $-1-1=-2$ with multiplicity $5$ and $-1+2=1$ with multiplicity $4$. Adding $2$: spectrum $8,\,3^{(4)},\,0^{(5)}$, trace $8+12=20=n(n-1)$, $\Xi=64+4\cdot9=100=n^2(n-1)$, rank $5=n$. This agrees with §6.1 at $n=5$ term for term.

## 7. Attack 6. The flexibility claim

**Verdict: the bound and its attainment are CONFIRMED and sharpened. The genericity sentence is REFUTED AS STATED: the parameter count is not an argument for it. Its conclusion is nevertheless true at $n=4$, and I exhibit the witness the block owes in closed form. Open at $n\ge5$.**

### 7.1 What survives

"The Ricci-flat weight space of any orthonormal decomposable basis has dimension at most $\binom n2-n$" is C5 and C2 together, so it holds for $n\ge3$. "At a coordinate configuration it is exactly the zero-row-sum weightings of $K_n$, of that dimension" is §2.1. By §5.4 the coordinate configuration is the only place the bound is attained.

### 7.2 Why the count is not an argument

The system $\sum_\alpha\lambda_\alpha\Pi_\alpha=0$ does live in $\mathrm{Sym}^2\mathbb R^n$, so "$\binom n2$ unknowns against $\tfrac{n(n+1)}2$ conditions" counts the ambient dimensions correctly, and $\binom n2\le\tfrac{n(n+1)}2$ always. But the conclusion "no nonzero solution" is equivalent to $\mathop{\mathrm{rank}}S=\binom n2$, that is to the $\Pi_\alpha$ being linearly independent, and *that* is a condition on the configuration that the count cannot deliver. The count is worse than uninformative here, because the record already knows two configurations where independence fails badly:

| configuration | $\mathop{\mathrm{rank}}S$ at $n=4$ | $\dim\ker S$ |
|---|---|---|
| coordinate (Given 11) | $4$ | $2$ |
| the rotated witness (Given 4, one-dimensional solution space) | $5$ | $1$ |
| pencil plus $\Lambda^2U$, §7.3 | $6$ | $0$ |

So at the moment the block was written, every configuration on the record had $\ker S\ne0$, and the sentence "a generic configuration admits no nonzero Ricci-flat weighting at all" was an assertion about a set not yet known to be nonempty. There is also a structural reason for caution the count ignores: by §3.3 the columns of the system always satisfy $\sum_\alpha\Pi_\alpha=(n-1)\mathrm{Id}$, so the family is never in general position in the naive sense.

### 7.3 The witness. A decomposable orthonormal basis of $\Lambda^2\mathbb R^4$ with $\ker S=0$

Given 7 supplies the shape: at $\dim U=3$ both a pencil $f\wedge U$ and $\Lambda^2U$ consist entirely of decomposable forms, and at $n=4$ their dimensions are $3+3=6=\binom42$, so they tile $\Lambda^2\mathbb R^4$. Note $n=4$ is the only dimension where they do, since $(n-1)+3=\binom n2$ forces $n^2-3n-4=0$.

Let $U=\mathop{\mathrm{span}}\{e_2,e_3,e_4\}$ and take the orthonormal basis of $U$
$$v_1=\tfrac13(2e_2+2e_3-e_4),\qquad v_2=\tfrac13(-e_2+2e_3+2e_4),\qquad v_3=\tfrac13(2e_2-e_3+2e_4),$$
each of norm $\tfrac19(4+4+1)=1$ and pairwise orthogonal, since $v_1\!\cdot\!v_2=\tfrac19(-2+4-2)=0$, $v_1\!\cdot\!v_3=\tfrac19(4-2-2)=0$ and $v_2\!\cdot\!v_3=\tfrac19(-2-2+4)=0$. Put $\eta_k=\star_U v_k$, so
$$\eta_1=\tfrac13\big(2\,e_3\wedge e_4+2\,e_4\wedge e_2-e_2\wedge e_3\big),\quad \eta_2=\tfrac13\big(-e_3\wedge e_4+2\,e_4\wedge e_2+2\,e_2\wedge e_3\big),\quad \eta_3=\tfrac13\big(2\,e_3\wedge e_4-e_4\wedge e_2+2\,e_2\wedge e_3\big),$$
and consider
$$\mathcal B=\{\,e_1\wedge e_2,\ e_1\wedge e_3,\ e_1\wedge e_4,\ \eta_1,\ \eta_2,\ \eta_3\,\}.$$

**$\mathcal B$ is an orthonormal basis of $\Lambda^2\mathbb R^4$ by decomposable forms.** The first three are orthonormal by the conventions and lie in $e_1\wedge U$. The $\eta_k$ are orthonormal because $\star_U$ is an isometry $U\to\Lambda^2U$ and the $v_k$ are orthonormal, and they lie in $\Lambda^2U\perp e_1\wedge U$. Every $\eta_k$ is decomposable, since $\eta\wedge\eta\in\Lambda^4U=0$ for $\eta\in\Lambda^2U$ with $\dim U=3$.

**Its projections.** $\Pi_{e_1\wedge e_j}=E_{11}+E_{jj}$ for $j=2,3,4$, and the plane of $\eta_k=\star_Uv_k$ is $v_k^\perp\cap U$, so $\Pi_{\eta_k}=\Pi_U-v_kv_k^{\mathsf T}$ with $\Pi_U=E_{22}+E_{33}+E_{44}$.

**$\ker S=0$.** Suppose $\sum_j c_j(E_{11}+E_{jj})+\sum_k d_k(\Pi_U-v_kv_k^{\mathsf T})=0$. The $(1,1)$ entry gives $\sum_jc_j=0$. Taking the full trace gives $2\sum_jc_j+2\sum_kd_k=0$, hence $\sum_kd_k=0$. What remains, inside $\mathrm{Sym}^2U$, is
$$\mathop{\mathrm{diag}}(c_2,c_3,c_4)=\sum_kd_k\,v_kv_k^{\mathsf T}=Q\mathop{\mathrm{diag}}(d)Q^{\mathsf T},\qquad Q=[\,v_1\ v_2\ v_3\,]\in O(3).$$
So $Q\mathop{\mathrm{diag}}(d)Q^{\mathsf T}$ must be diagonal, that is $\sum_kd_k(v_k)_a(v_k)_b=0$ for $a\ne b$. With the chosen $v_k$ (coordinates in $e_2,e_3,e_4$ indexed $1,2,3$):
$$(a,b)=(1,2):\ \tfrac19\big(4d_1-2d_2-2d_3\big)=0,\qquad (1,3):\ \tfrac19\big(-2d_1-2d_2+4d_3\big)=0,\qquad (2,3):\ \tfrac19\big(-2d_1+4d_2-2d_3\big)=0,$$
that is $2d_1=d_2+d_3$, $2d_3=d_1+d_2$, $2d_2=d_1+d_3$. Subtracting the first two of these gives $3d_1=3d_2$, and then the third gives $d_3=d_1$, so $d\in\mathbb R\mathbf 1$. With $\sum_kd_k=0$ this forces $d=0$, hence $\mathop{\mathrm{diag}}(c)=0$ and $c=0$. So $\ker S=0$ and $\mathop{\mathrm{rank}}S=6=\binom42$.

**Cross-check from $\Xi$, independent of the argument just given.** For this configuration $S$ has diagonal $2$; the pencil block has off-diagonal $1$ (planes meeting in $e_1$); the $\eta$ block has $\mathop{\mathrm{tr}}(\Pi_{\eta_k}\Pi_{\eta_l})=3-1-1+(v_k\!\cdot\!v_l)^2=1$ off the diagonal; and the cross entries are $\mathop{\mathrm{tr}}\big((E_{11}+E_{jj})(\Pi_U-v_kv_k^{\mathsf T})\big)=1-(v_k)_j^2$, so the cross block is $\tfrac19\begin{pmatrix}5&8&5\\5&5&8\\8&5&5\end{pmatrix}$. The off-diagonal total is $6+6+2(9-3)=24=n(n-1)(n-2)$, as §4.2 requires, and
each column of the cross block contributing $\tfrac{25+25+64}{81}=\tfrac{114}{81}$ to the squares, so
$$\Xi=\underbrace{24}_{\text{diagonal}}+\underbrace{6}_{\text{pencil}}+\underbrace{6}_{\eta}+\underbrace{2\cdot\tfrac{3\cdot114}{81}}_{\text{cross}}=36+\tfrac{76}{9}=\tfrac{400}{9}=44.\overline4\ <\ 48,$$
strictly under the cap, as it must be for a non-integral configuration. Feeding this into §5.3: $\sum_{i\ge1}\sigma_i^2=\Xi-4(n-1)^2=\tfrac{400}9-36=\tfrac{76}9$ and $\big(\sum_{i\ge1}\sigma_i\big)^2=36$, so $r-1\ge 36\cdot\tfrac{9}{76}=\tfrac{81}{19}=4.263\ldots$, giving $r\ge6$, hence $r=6$. Two independent routes to $\mathop{\mathrm{rank}}S=6$.

### 7.4 What "generic" would have to mean, and whether it is earned

Honestly stated it needs three things: a parametrisation of the configurations as a real algebraic set, the observation that $\mathop{\mathrm{rank}}S\le\binom n2-1$ is a closed condition (vanishing of all maximal minors), and **one point where the rank is full**. Then full rank holds on a Zariski-open dense subset of every irreducible component containing such a point. Items one and two are free. Item three is what the block skipped and what §7.3 now supplies at $n=4$. Whether *every* component contains a full-rank point, so that "generic" is unqualified, is not settled here.

At $n=4$ the configurations admit a clean parametrisation, worth recording because it makes the count concrete. Writing $\omega=\omega^++\omega^-$ for the chirality split of Given 3, decomposability is $\lVert\omega^+\rVert=\lVert\omega^-\rVert$, since $\omega\wedge\omega$ is $2\mathrm{Pf}(\omega)\mathrm{vol}$ and $\mathrm{Pf}$ is proportional to $\lVert\omega^+\rVert^2-\lVert\omega^-\rVert^2$. So a decomposable orthonormal basis is exactly a matrix $C\in O(6)$, in an orthonormal basis of $\Lambda^+\oplus\Lambda^-$, each of whose columns splits its norm evenly between the two halves. That is $15-6=9$ parameters, and $6$ of them are the $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ of the frame, leaving $3$ moduli. Moreover, with $x_\alpha,y_\alpha$ the halves of column $\alpha$ and $\hat\Pi_\alpha=\Pi_\alpha-\tfrac12\mathrm{Id}$, the quaternionic identities $(\omega^\pm)^2=-\tfrac12\lVert\omega^\pm\rVert^2\mathrm{Id}$ and $\omega^+\omega^-=\omega^-\omega^+$ give
$$\Pi_\omega=-\omega^2=\tfrac12\mathrm{Id}-2\,\omega^+\omega^-,\qquad\text{so}\qquad \hat\Pi_\alpha\ \longleftrightarrow\ -2\,x_\alpha y_\alpha^{\mathsf T}$$
under the isomorphism $\Lambda^+\otimes\Lambda^-\cong\mathrm{Sym}^2_0\mathbb R^4$. Since $\sum_\alpha\hat\Pi_\alpha=0$ by §3.3, the six rank-one tensors $x_\alpha y_\alpha^{\mathsf T}$ satisfy one relation, so $\mathop{\mathrm{rank}}S=1+\dim\mathop{\mathrm{span}}\{x_\alpha y_\alpha^{\mathsf T}\}\in\{4,5,6\}$ at $n=4$, with $6$ attained exactly when that relation is the only one. §7.3 is such a point. The coordinate configuration is the opposite extreme, where the six tensors collapse onto three lines $\pm f^+_i(f^-_i)^{\mathsf T}$, giving $1+3=4$.

### 7.5 $n\ge5$

Untouched. The §7.3 construction is unavailable, as noted, and the obvious blockwise extension fails: $\Lambda^2\mathbb R^5=\Lambda^2\mathbb R^4\oplus(\mathbb R^4\wedge e_5)$ with the §7.3 basis on the first summand and $e_i\wedge e_5$ on the second has $\mathop{\mathrm{span}}\{E_{ii}+E_{55}\}$ meeting the first summand's span in the trace-free diagonals it already contains, so the rank falls short of $10$. Whether $\mathop{\mathrm{rank}}S=\binom n2$ is achievable for some $n\ge5$ is open on the evidence in this brief, and the genericity sentence should be stated at $n=4$ or stated as a conjecture.

## 8. Attack 7. The consistency check

**Verdict: the algebra is CONFIRMED. Three of the surrounding claims are wrong as worded.**

### 8.1 The marginal and $\hat S$

$[\omega_\alpha,\omega_\beta]$ is skew, so it lies in $\Lambda^2\mathbb R^n$, and $\{\omega_\gamma\}$ is an orthonormal basis of that space. Hence by Parseval
$$\sum_\gamma T_{\alpha\beta\gamma}=\sum_\gamma\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle^2=\lVert[\omega_\alpha,\omega_\beta]\rVert^2 .$$
For $\alpha\ne\beta$ the pair is $\Lambda^2$-orthogonal and decomposable, so Given 8 makes this $\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=S_{\alpha\beta}$. For $\alpha=\beta$ the commutator vanishes, so the marginal is $0$ while $S_{\alpha\alpha}=2$. Therefore $\sum_\gamma T_{\alpha\beta\gamma}=\hat S_{\alpha\beta}$ with $\hat S=S-2\,\mathrm{Id}$, exactly as the block says. Small attribution note: what kills the diagonal is $c_{\alpha\alpha\gamma}=0$, which is one instance of hollowness, and what supplies the off-diagonal value is Given 8, which the block does not name at this point.

### 8.2 Relation (B)

$\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=\sum_\beta\lambda_\beta\hat S_{k\beta}=(\hat S\lambda)_k=(S\lambda)_k-2\lambda_k$. So (B), which reads $=-2\lambda_k$, is $(S\lambda)_k=0$, and (B) at every index is exactly $S\lambda=0$. **CONFIRMED**, both directions, with no extra input.

### 8.3 Relation (C) summed over $k$

By total symmetry of $T$, $\sum_kT_{k\beta\gamma}=\hat S_{\beta\gamma}$, so summing (C) over $k$ gives
$$\lambda^{\mathsf T}\hat S\lambda=\lambda^{\mathsf T}S\lambda-2\lVert W\rVert^2\qquad\text{on the left, and}\qquad \sum_k2\lambda_k(\theta-\lambda_k)=2\theta\mathop{\mathrm{tr}}W-2\lVert W\rVert^2\qquad\text{on the right,}$$
using Given 13 for $\lVert W\rVert^2=\sum\lambda_\alpha^2$ and $\mathop{\mathrm{tr}}W=\sum_\alpha\lambda_\alpha$. So the summed relation is precisely
$$\lambda^{\mathsf T}S\lambda=2\theta\mathop{\mathrm{tr}}W .$$
Three corrections to the block's wording follow.

- **"Is $\mathop{\mathrm{tr}}W=0$ the only extra input?" No.** The block writes the chain $\lambda^{\mathsf T}\hat S\lambda=\lambda^{\mathsf T}S\lambda-2\lVert W\rVert^2=-2\lVert W\rVert^2$, and the second equality substitutes $\lambda^{\mathsf T}S\lambda=0$, which is Ricci-flatness. So the inputs are the marginal identity, Given 13, $\mathop{\mathrm{tr}}W=0$, **and** Ricci-flatness. Read as a consistency check that is fine, since Ricci-flatness is a hypothesis in force.
- **Run the other way it is not a check but a small theorem**, worth recording. $\mathop{\mathrm{tr}}W=0$ turns the summed relation into $\lambda^{\mathsf T}S\lambda=0$, and $S$ is positive semidefinite by §3.1, so $\lVert\sum\lambda_\alpha\Pi_\alpha\rVert^2=0$ and $W$ is Ricci-flat. That is: a trace-free symmetric operator whose eigenbasis is decomposable and orthonormal and which satisfies relation (C) at every index is automatically Ricci-flat. This is the one place in the block where positive semidefiniteness does real work, and the block does not use it. The statement is conditional on (C)'s own derivation from $W^\#=\theta W-W^2$ not itself consuming Ricci-flatness, which the brief does not let me check.
- **"$\theta$ is absent from both" is true of (B) and only conditionally true of summed (C)**, where $\theta$ appears as $2\theta\mathop{\mathrm{tr}}W$ and drops because the trace vanishes. Worth one clause, since the whole point of the remark is that the marginals cannot see $\theta$.
- **"Two independent arrivals at $S\lambda=0$" overclaims.** The two are the $\Theta$-contraction of §1 and relation (B) of §8.2. Both are re-encodings of the single equation $\sum_\alpha\lambda_\alpha\Pi_\alpha=0$: (B) is the diagonal of $W\#I=-W$, which by Given 12 is an operator form of Ricci-flatness, so the second arrival travels the same distance in a different notation. "Two encodings of one equation, which is a consistency check on the structure constants" is the accurate phrasing, and the block's own headline ("a consistency check rather than new content") already says so. The body then contradicts the headline.

## 9. Attack 8. The kernel

**Verdict: nothing breaks, the rank bound is untouched, and there is one scope caveat the block should carry.**

- **$S$ does not depend on $\lambda$.** It is an invariant of the configuration, so C3 to C7 are statements about the planes alone and $\ker W\ne0$ cannot reach them. The rank bound survives verbatim.
- **Zeros in $\lambda$ are harmless in §1.** Given 2 already grants the kernel's term as $0\cdot\Theta$, and §1.3 needs only that $M$ lies in the span of $\{\Pi_\alpha:\lambda_\alpha\ne0\}$, which it does. Indeed the restricted matrix $S\vert_{\Sigma\times\Sigma}$ on the support $\Sigma$ of $\lambda$ suffices, so a Ricci-flat weighting supported on $\Sigma$ is exactly a kernel vector of that principal submatrix.
- **Trace-freeness is free.** Taking the trace of $\sum\lambda_\alpha\Pi_\alpha=0$ gives $2\sum_\alpha\lambda_\alpha=0$, so $\mathop{\mathrm{tr}}W=0$ whenever $W$ is Ricci-flat with a decomposable orthonormal eigenbasis. Combined with the hypothesis inventory's item 5, $S\lambda=0$ alone puts $W$ in $\mathcal W_n$.
- **The caveat.** When $\lambda$ has a repeated value, and $0$ is the usual culprit, the eigenbasis of $W$ is not determined by $W$. Different orthonormal eigenbases of the same $W$ can be decomposable or not, and different decomposable choices give different configurations and, in principle, different $\mathop{\mathrm{rank}}S$. So every statement here is properly read as "for the chosen decomposable orthonormal eigenbasis", and a passage from a $W$ to "its" $S$ is not well defined in the degenerate case. The block's phrasing "the Ricci-flat weightings of a fixed configuration" is careful about this. The later phrase "a NONZERO critical point requires a degenerate Gram matrix" is not, and should read "requires a degenerate Gram matrix at every decomposable orthonormal eigenbasis it admits".

## 10. Attack 9. Vacuity and triviality

**Verdict: the hypotheses are satisfied, the claims are non-vacuous, and one of them was an assertion about a possibly empty set until §7.3. Separately, the framework does not reach the record's own extremal witness.**

### 10.1 Objects satisfying the hypotheses

Three, all exact: the coordinate configuration at every $n\ge3$; the rotated witness of Given 4 at $n=4$, which is not coordinate; and §7.3, which is neither. So the class is nonempty, contains non-coordinate members, and contains members at all three possible ranks at $n=4$.

Non-triviality of the *conclusion* too, not just the hypotheses: at $n=4$ coordinate, $\ker S$ has dimension $2$, and $\lambda_{12}=\lambda_{34}=1$, $\lambda_{13}=\lambda_{24}=-1$, $\lambda_{14}=\lambda_{23}=0$ has all four row sums zero, so it is a nonzero Ricci-flat weighting. By hypothesis-inventory item 5 the resulting $W$ satisfies first Bianchi automatically and by §9 it is trace-free, so it is a genuine nonzero element of $\mathcal W_4$. C1, C2 and C7 all have content at it.

### 10.2 What each claim would look like if vacuous, and it is not

- C1 to C4 would be vacuous with no decomposable orthonormal basis in existence. Refuted by the coordinate configuration.
- C5 would be vacuous if the class were empty and trivial if the bound were $\ge1$. It is neither: at $n=4$ the bound $4$ is a real constraint, since ranks $1,2,3$ are a priori available to a $6\times6$ Gram matrix.
- C6 would be trivial if attainment were automatic. It is not: §5.4 shows attainment characterises the coordinate configuration.
- C7's first half inherits C5. Its second half, the genericity sentence, is the one that was **at risk of vacuity**: had every configuration satisfied $\ker S\ne0$, the sentence would have been a statement about the empty set, and every configuration the record had exhibited was of that kind. §7.3 resolves it at $n=4$ and leaves it open at $n\ge5$. This is the honest answer to the brief's question "is it a statement about a nonempty set of configurations": yes at $n=4$, unknown above.

### 10.3 A scope limit the block should carry

$W_{\mathbb{CP}^2}$ **has no orthonormal decomposable eigenbasis.** By Given 5 one chirality block is $c\,\mathop{\mathrm{diag}}(2,-1,-1)$ with $c\ne0$ and the other is zero, so the spectrum on $\Lambda^2\mathbb R^4$ is $2c$ simple, $-c$ double, $0$ triple. Any orthonormal eigenbasis contains a unit eigenvector for the simple eigenvalue $2c$, which is unique up to sign and lies in $\Lambda^+$, so it has $\lVert\omega^-\rVert=0\ne\lVert\omega^+\rVert$ and by §7.4 is not decomposable.

So the entire I74 line, C1 through C8, is silent about the record's local maximum at $\theta=\sqrt{3/2}$. That does not damage any claim above. It bears on what the claims can be used for, and a reader coming to this block from the conjecture will assume otherwise unless told.

## 11. Attack 10. What would break each claim, and what I did to look for it

Analysis only, per the footing. No searches, sweeps or censuses were run, and nothing below is a numerical result.

### 11.1 The rank bound

The falsifier is a decomposable orthonormal basis of $\Lambda^2\mathbb R^n$, $n\ge3$, with $\mathop{\mathrm{rank}}S\le n-1$, equivalently with a Ricci-flat weight space of dimension at least $\binom n2-n+1$. Two independent proofs now stand in the way, §5.1 to §5.2 through L201 and §5.3 through $\mathbf 1$, so such an object would have to break one of Givens 1, 8, 10 or 11, or L201 itself. What I did: re-derived Given 10's cap, total, diagonal contribution and equality case from Givens 1 and 8 (§4.2), so the cap is not an unaudited input; derived $S\mathbf 1=2(n-1)\mathbf 1$ from Given 1 and used it for a second proof that avoids L201 entirely (§5.3); verified the coordinate spectrum twice, from $S=BB^{\mathsf T}$ for all $n$ and from the Petersen and complementation spectra at $n=4,5$ (§6); checked the boundary $n=2$, where the bound genuinely fails and the reason is visible; checked $n=3$, where the bound is tight and reproduces $\mathcal W_3=0$ (§2.2). Every arithmetic identity that could have hidden a factor was checked against a second expression of the same quantity. I found no crack.

### 11.2 The flexibility claim

Two different falsifiers, for the two halves.

- For "at most $\binom n2-n$": the same object as §11.1.
- For "a generic configuration admits no nonzero Ricci-flat weighting": a **proof that every** decomposable orthonormal basis has $\ker S\ne0$, which is what the record's two exhibited configurations suggested. What I did: reduced the question at $n=4$ to a statement about six rank-one tensors in $\Lambda^+\otimes\Lambda^-$ with one forced relation (§7.4), which showed the target rank $6$ is not excluded on dimension grounds, then constructed the configuration in §7.3 from Given 7's two decomposable families and verified $\ker S=0$ by hand, twice. So this falsifier does not exist at $n=4$. At $n\ge5$ I neither found a witness nor an obstruction, and I record the failure of the naive blockwise extension (§7.5) rather than leaving it as an assumption.

## Verdict

**The chain holds link by link, with one defective link and one range condition.**

- C1, C2, C3, C4, C6, C9 are **CONFIRMED** as written, with the two implicit ingredients of C1 named in §1.3 and the normalisation dependence of the constants named in §3.2.
- C5 is **CONFIRMED** as a theorem for $n\ge3$, and its written proof is one line short of covering $\mathop{\mathrm{rank}}S<n-1$. §5.3 gives a shorter proof that does not use L201, and §5.4 gives the converse, that $\mathop{\mathrm{rank}}S=n$ characterises the coordinate configuration, which turns the block's "most flexible" into a uniqueness statement.
- C7's bound and attainment are **CONFIRMED** and sharpened. **C8, the genericity sentence, is REFUTED AS STATED**: the parameter count does not establish it, because the effective number of conditions is $\mathop{\mathrm{rank}}S$ and the record's own configurations show it falling short. Its conclusion is true at $n=4$ by the closed-form witness of §7.3 and is open at $n\ge5$.
- C10 is **CONFIRMED AS ALGEBRA**, with the "only extra input", "$\theta$ absent" and "two independent arrivals" wordings all needing correction, and with a genuine by-product the block passes over: relation (C) plus $\mathop{\mathrm{tr}}W=0$ plus positive semidefiniteness of $S$ implies Ricci-flatness.
- Every statement needs $n\ge3$ and none of them says so. At $n=2$, C5 and C6 are false.
- Scope, unclaimed but material: $W_{\mathbb{CP}^2}$ admits no decomposable orthonormal eigenbasis, so this line of argument does not reach the record's extremal witness at $n=4$.
