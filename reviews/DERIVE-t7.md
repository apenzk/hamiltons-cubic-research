# DERIVE-t7, the off-diagonal block of criticality, read without averaging

**Task [I28](../plan.md).** Setting, normalisations and the per-index system are those of [bounds.md](../findings/bounds.md) and [conventions.md](../findings/conventions.md); the completeness theorem for that system is [Reviewer 331](REVIEW_r331.md). Everything below is derived by hand; the one computation is a screen (seconds, $n=6$, objects built here) of claims already proved, reported as a screen in §7.

## 0. Verdict

**The off-diagonal block adds nothing on $T$, and this is a theorem, not an averaging argument.** Decomposed by eigenvalue pairs, the block condition is a statement about a family of Gram matrices $G^{\mu\nu}$ (positive semidefinite, summing to the Killing form), whose diagonals are exactly the type-aggregated masses of $T$. Given *any* nonnegative $T$ satisfying (A), (B), (C), the diagonal matrices $\operatorname{diag}(\text{type masses})$ satisfy all three block conditions, so positivity plus the three polarised identities can never produce an inequality on $T$ beyond the LP class (§4, Theorem 1). Its content is entirely on the *signed* structure constants: sign-realizability of a given $T$.

What the Gram reading does give, beyond a proved "nothing":

- **Two-eigenvalue rigidity** (§5, Theorem 2). At a critical point with exactly two eigenvalues, the three polarised identities have an invertible $3\times3$ coefficient matrix (determinant $(m-h)^3$), so every $G^{\mu\nu}$ is a polynomial in $W$: block-diagonal and *scalar* on each eigenspace. Each of the three components $\Pi_{\mu\nu}\circ\mathrm{ad}$ is then a scaled isometry on each eigenspace, with the two eigenspaces' images orthogonal. Lemma L70's bound and Lemma L71's symmetric-pair structure fall out of the closed forms in two lines.
- **A per-row lower bound on $g_k$** (§6), the mirror of the record's per-coordinate upper cap: $g_k\ge8\lambda_k\big(\tfrac{n-1}{n-2}\lambda_k-\theta\big)$, tight on every $E_{\min}$ row at the balanced product. It is per-row Cauchy–Schwarz, inside the pinned class; combined with the record's a priori bound it gains nothing at either test point.
- **The block condition is vacuous on the whole coordinate-diagonal locus**, since it is $[W,W^\#]=0$ and diagonal invariance ([diagonal-half.md](../findings/diagonal-half.md)) makes $W^\#$ coordinate-diagonal there. It is a condition with content only off that locus (the non-diagonal target's territory) and, as a condition on $T$, empty even there.

## 1. Normalisation, verified against the record

Orthonormal eigenbasis $\{e_a\}$ of $W$ on $\mathfrak{so}(n)$ for $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, eigenvalues $\lambda_a$, $c_{abc}=\langle[e_a,e_b],e_c\rangle$ totally antisymmetric, $T_{abc}=c_{abc}^2$. Sums over $(c,d)$ are over **ordered** pairs. In this basis $(\mathrm{ad}\,u)_{dc}=\langle e_d,[u,e_c]\rangle=c_{ucd}$.

$$(W^\#)_{ab}=\tfrac12\sum_{c,d}\lambda_c\lambda_d\,c_{acd}\,c_{bcd}.$$

Checks: $I\#I=\tfrac12\sum_{cd}c_{acd}c_{bcd}=\tfrac12\cdot2(n-2)\delta_{ab}=(n-2)\delta_{ab}$, the record's $I\#I=(n-2)I$; the diagonal reproduces (C), $\langle e_k,W^\#e_k\rangle=\tfrac12m_{11}(k)=\lambda_k(\theta-\lambda_k)$ in r331's notation; and the screen in §7 matches the library's basis-free $R^\#$ to $2\times10^{-16}$.

## 2. The off-diagonal block condition, exactly

Criticality is $W^\#=\theta W-W^2$. Its block between distinct eigenspaces $E_\alpha\ne E_\beta$ reads, for $u\in E_\alpha$, $v\in E_\beta$,

$$\boxed{\;\sum_{c,d}\lambda_c\lambda_d\,c_{ucd}\,c_{vcd}=0\;}\qquad(\alpha\ne\beta),\tag{OD}$$

and the block on a single eigenspace reads $\sum_{c,d}\lambda_c\lambda_d c_{ucd}c_{vcd}=2\alpha(\theta-\alpha)\langle u,v\rangle$ for $u,v\in E_\alpha$, (C) on the diagonal, plus the vanishing of the within-block traceless part.

**(OD) is $[W,W^\#]=0$.** $W^\#$ preserves every eigenspace of $W$ iff it commutes with $W$. So (OD) alone is [Reviewer 326](REVIEW_r326.md)'s condition, strictly weaker than criticality, and it holds at every coordinate-diagonal $W$ regardless of criticality: for $W$ diagonal in the pair basis $e_i\wedge e_j$, $W^\#$ is diagonal in the same basis by the pair combinatorics ([diagonal-half.md](../findings/diagonal-half.md), "diagonal invariance has a combinatorial proof"), and two operators diagonal in one basis commute. **So (OD) carries no information on the diagonal locus.** The count of scalar equations it imposes off that locus is $\sum_{\alpha<\beta}d_\alpha d_\beta$, each quadratic in $c$ and bilinear in the row vectors $(c_{u\cdot\cdot},c_{v\cdot\cdot})$.

## 3. Decomposition by eigenvalue pairs, the Gram family

For each ordered pair of eigenvalues $(\mu,\nu)$, $\mu=\nu$ allowed, define the symmetric bilinear form on $\mathfrak{so}(n)$

$$G^{\mu\nu}(u,v):=\sum_{c\in E_\mu,\ d\in E_\nu}c_{ucd}\,c_{vcd}=\big\langle P_\nu\,\mathrm{ad}(u)\,P_\mu,\;P_\nu\,\mathrm{ad}(v)\,P_\mu\big\rangle_{\mathrm{HS}},$$

with $P_\mu$ the orthogonal projector onto $E_\mu$; $G^{\mu\nu}=G^{\nu\mu}$ as matrices by antisymmetry of $c$. Any sum $\sum_{c,d}f(\lambda_c,\lambda_d)c_{ucd}c_{vcd}$ is $\sum_{\mu,\nu}f(\mu,\nu)G^{\mu\nu}(u,v)$, so the three per-index relations, **polarised to full matrices**, are

$$\text{(A}^\ast)\ \sum_{\mu\nu}G^{\mu\nu}=2(n-2)\,I,\qquad\text{(B}^\ast)\ \sum_{\mu\nu}\mu\,G^{\mu\nu}=-2W,\qquad\text{(C}^\ast)\ \sum_{\mu\nu}\mu\nu\,G^{\mu\nu}=2(\theta W-W^2).$$

**(A\*) and (B\*) hold as full matrices on all of $\mathcal W_n$; only (C\*) is criticality.** (A\*) is the Killing form, $-\operatorname{tr}(\mathrm{ad}\,u\,\mathrm{ad}\,v)=2(n-2)\langle u,v\rangle$. (B\*) is $\sum_{cd}\lambda_cc_{ucd}c_{vcd}=-\operatorname{tr}(W\,\mathrm{ad}(v)\,\mathrm{ad}(u))$; polarising r331's master identity $(\star)$ at $S=W$ gives the symmetric part $\tfrac12\operatorname{tr}(W\{\mathrm{ad}\,u,\mathrm{ad}\,v\})=2\langle u,Wv\rangle$, and the antisymmetric part $\tfrac12\operatorname{tr}(W\,\mathrm{ad}[u,v])$ vanishes because $W$ is symmetric and $\mathrm{ad}[u,v]$ is skew. So $\sum_{cd}\lambda_cc_{ucd}c_{vcd}=-2\langle u,Wv\rangle$, which is [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1's $W\#I=-W$ read as a matrix. (C\*) is (OD) together with the diagonal blocks. **Hence the off-diagonal blocks of all three weighted sums of the $G$'s vanish; criticality contributes the third weight $\mu\nu$ and nothing else.**

**What the $G$'s are.** Let $\iota=\mathrm{ad}:\mathfrak{so}(n)\to\operatorname{End}(\mathfrak{so}(n))$, and let $\Pi_{\mu\nu}$ be the orthogonal projector onto $\operatorname{Hom}(E_\mu,E_\nu)\subset\operatorname{End}(\mathfrak{so}(n))$. Then $G^{\mu\nu}=\iota^\ast\Pi_{\mu\nu}\iota$ and $\iota^\ast\iota=2(n-2)I$. Consequently:

| property | statement | source |
| --- | --- | --- |
| positivity | $G^{\mu\nu}\succeq0$, since $G^{\mu\nu}(u,u)=\lVert P_\nu\,\mathrm{ad}(u)P_\mu\rVert^2$ | definition |
| POVM | $\sum_{\mu\nu}G^{\mu\nu}/2(n-2)=I$ | (A\*) |
| rank | $\operatorname{rank}G^{\mu\nu}\le d_\mu d_\nu$ for $\mu\ne\nu$; $\le\binom{d_\mu}2$ for $\mu=\nu$, because $P_\mu\mathrm{ad}(u)P_\mu$ is skew on $E_\mu$ | dimension of the target |
| trace | $\operatorname{tr}G^{\mu\nu}=\sum_{c\in E_\mu,d\in E_\nu}\lVert[e_c,e_d]\rVert^2\le2d_\mu d_\nu$ | the pair cap, already on record |
| diagonal | $G^{\mu\nu}(e_k,e_k)=\sum_{c\in E_\mu,d\in E_\nu}T_{kcd}=:m_k^{\mu\nu}$, the **type mass** of row $k$ | definition |
| off-diagonal entries | $\lvert G^{\mu\nu}(u,v)\rvert^2\le G^{\mu\nu}(u,u)\,G^{\mu\nu}(v,v)$ | Cauchy–Schwarz |
| operator Jensen | for any scalars $x_{\mu\nu}$, $\sum x_{\mu\nu}^2G^{\mu\nu}\succeq\big(\sum x_{\mu\nu}G^{\mu\nu}\big)^2/2(n-2)$ | §6 |

The last line is the general fact $\sum_ix_i^2F_i-X^2=\sum_i(x_i-X)F_i(x_i-X)\succeq0$ for a POVM $\{F_i\}$ with $X=\sum x_jF_j$.

**So the $G$'s unify the two readings.** Their diagonals are the type masses that (A), (B), (C) constrain row by row; their off-diagonal blocks are what (OD) constrains. Question 3 of the brief asks whether the two halves of one $G^{\mu\nu}$ are linked in a way that feeds back into $T$.

## 4. Theorem 1, at the Gram level, the block condition adds nothing on $T$

**Theorem 1.** *Let $(\lambda,\theta)$ be given, $W=\operatorname{diag}(\lambda)$, and let $T\ge0$ be totally symmetric, vanishing on repeated indices, and satisfy (A), (B), (C) in every row. Define $\widehat G^{\mu\nu}:=\operatorname{diag}_k\big(m_k^{\mu\nu}\big)$ with $m_k^{\mu\nu}=\sum_{c\in E_\mu,d\in E_\nu}T_{kcd}$. Then every $\widehat G^{\mu\nu}$ is positive semidefinite and the family satisfies (A\*), (B\*), (C\*) as full matrices.*

*Proof.* Diagonal matrices with nonnegative entries are PSD. The three sums are diagonal, and their $k$-th entries are $\sum_{\mu\nu}m_k^{\mu\nu}=\sum_{cd}T_{kcd}=2(n-2)$, $\sum_{\mu\nu}\mu\,m_k^{\mu\nu}=\sum_{cd}\lambda_cT_{kcd}=-2\lambda_k$ and $\sum_{\mu\nu}\mu\nu\,m_k^{\mu\nu}=\sum_{cd}\lambda_c\lambda_dT_{kcd}=2\lambda_k(\theta-\lambda_k)$, relations (A), (B), (C) of row $k$. $\square$

**Corollary.** *The map from families $\{G^{\mu\nu}\}$ of PSD matrices satisfying (A\*), (B\*), (C\*) to their diagonals is onto the set of nonnegative type-mass vectors satisfying (A), (B), (C). Hence no inequality on the type masses (and a fortiori none on $T$, which (A), (B), (C) see only through the type masses), follows from positivity of the $G$'s together with the three block conditions.*

This is the answer to question 3, and it is stronger than r331's "averaged, empty": r331 showed the block condition has no *invariant linear* shadow in $T$; Theorem 1 shows it has no shadow in $T$ at all, linear or not, at the level of positive-semidefinite Gram families. **Cauchy–Schwarz and operator Jensen bound the off-diagonal blocks by the diagonals, never the reverse**, which is why they cannot feed back. The diagonal realisation is also what the two-eigenvalue rigidity of §5 forces at the balanced product, so the theorem's witness is the extremal point itself, in a suitable basis.

**What the theorem does not cover, stated exactly.** Three pieces of Gram-level structure lie outside "PSD + three identities": the rank caps of §3 (the diagonal realisation has $\operatorname{rank}\widehat G^{\mu\nu}=\#\{k:m_k^{\mu\nu}>0\}$, which can exceed $d_\mu d_\nu$); the fact that $\iota(\mathfrak{so}(n))$ is a Lie subalgebra of $\mathfrak{so}(\mathfrak{so}(n))$ (Jacobi, cubic in $c$, r331 shows it is empty at linear order in $T$); and the specific compression structure $G^{\mu\nu}=\iota^\ast\Pi_{\mu\nu}\iota$ with $\Pi_{\mu\nu}$ a fixed orthogonal resolution of the identity of prescribed dimensions. Any constraint on $T$ from the off-diagonal block must come through one of these. Whether the rank caps ever bind on the type masses is **open**; the only trace-level shadow of a rank cap is the pair cap, already on record.

## 5. Theorem 2, two-eigenvalue rigidity

Let $W$ be critical with exactly two eigenvalues $h>0>m$ (dimensions $d_h,d_m$). There are three Gram matrices: $G^{hh}$, $G^{hm}=G^{mh}$, $G^{mm}$. The polarised identities read, with the ordered pair $(h,m)$ counted twice,

$$\begin{pmatrix}1&2&1\\ h&h+m&m\\ h^2&2hm&m^2\end{pmatrix}\begin{pmatrix}G^{hh}\\ G^{hm}\\ G^{mm}\end{pmatrix}=\begin{pmatrix}2(n-2)I\\ -2W\\ 2(\theta W-W^2)\end{pmatrix}.$$

**Theorem 2.** *The coefficient matrix has determinant $(m-h)^3\ne0$, so each of $G^{hh},G^{hm},G^{mm}$ is a linear combination of $I$, $W$, $W^2$ with scalar coefficients depending on $(h,m,n,\theta)$. Hence each $G^{\mu\nu}$ is block-diagonal with respect to $E_h\oplus E_m$ and scalar on each block.*

*Proof.* Expanding along the first row: $\big((h+m)m^2-2hm^2\big)-2\big(hm^2-h^2m\big)+\big(2h^2m-(h+m)h^2\big)=m^3-3hm^2+3h^2m-h^3=(m-h)^3$. Invert and read off. $\square$

**The closed forms, by a Vandermonde trick rather than by inversion.** Fix a row of eigenvalue $\lambda\in\{h,m\}$ and write $A_{hh},A_{hm},A_{mm}$ for its type masses, $A_{hm}$ the mass of the *unordered* type $\{h,m\}$ (both orderings). Row $\lambda$ has moments $p_0=\sum T=2(n-2)$, $p_1=\sum(\lambda_c+\lambda_d)T=-4\lambda$, $p_2=\sum\lambda_c\lambda_dT=2\lambda(\theta-\lambda)$. The weight $(\lambda_c-h)(\lambda_d-h)$ vanishes on types $\{h,h\}$ and $\{h,m\}$ and equals $(m-h)^2$ on $\{m,m\}$, so $A_{mm}(m-h)^2=p_2-hp_1+h^2p_0$; symmetrically for $A_{hh}$; and $A_{hm}=p_0-A_{hh}-A_{mm}$. Explicitly,

$$A_{mm}(\lambda)=\frac{2\lambda(\theta-\lambda)+4h\lambda+2(n-2)h^2}{(h-m)^2},\qquad A_{hh}(\lambda)=\frac{2\lambda(\theta-\lambda)+4m\lambda+2(n-2)m^2}{(h-m)^2},$$

and at the two rows the brackets factor: $A_{hh}(m)=\dfrac{2m\,[\theta+(n-1)m]}{(h-m)^2}$, $A_{hm}(h)=\dfrac{-4h\,[\theta+(n-1)m]}{(h-m)^2}$, $A_{mm}(h)=\dfrac{2h\,[\theta+(n-1)h]}{(h-m)^2}$, $A_{hm}(m)=\dfrac{-4m\,[\theta+(n-1)h]}{(h-m)^2}$.

Three consequences, each one line:

- **Consistency is automatic.** The six block scalars are traces of four triple masses ($M_{hhh},M_{hhm},M_{hmm},M_{mmm}$), which imposes $d_hA_{hm}(h)/2=d_mA_{hh}(m)$ and $d_hA_{mm}(h)=d_mA_{hm}(m)/2$; both reduce to $(d_hh+d_mm)\,[\cdots]=0$ and hold by trace-freeness. So (A\*)–(C\*) at two eigenvalues impose **no relation** among $(h,m,d_h,d_m,\theta)$ beyond the spectral ones, consistent with r331's two-eigenvalue collapse.
- **Lemma L70 is the positivity of one closed form.** $A_{hh}(m)\ge0$ with $m<0$ is $\theta\le(n-1)\lvert m\rvert$, the record's a priori bound, tight exactly when the $E_{\max}\otimes E_{\max}$ mass of every $E_{\min}$ row vanishes.
- **Saturation gives the symmetric pair with no further input.** At $\theta=(n-1)\lvert m\rvert$, $A_{hh}(m)=0$ and $A_{hm}(h)=0$ read $[E_m,E_h]\subseteq E_m$ and $[E_h,E_h]\subseteq E_h$, the structural half of [Lemma L71](../findings/bounds.md). What Theorem 2 adds is that this holds *as Gram matrices*: $\Pi_{hh}\circ\mathrm{ad}$ and $\Pi_{hm}\circ\mathrm{ad}$ vanish identically on $E_m$ and $E_h$ respectively, rather than merely having zero row masses.

**The signed content of Theorem 2.** Block-scalarity says that for each of the three types the map $u\mapsto\Pi_{\mu\nu}\,\mathrm{ad}(u)$ is a scaled isometry on $E_h$ and on $E_m$ separately, with $\Pi_{\mu\nu}\mathrm{ad}(E_h)\perp\Pi_{\mu\nu}\mathrm{ad}(E_m)$. That is a statement about the signed $c$, e.g. $\sum_{c,d\in E_m}c_{ucd}c_{vcd}=A_{mm}(\lambda)\langle u,v\rangle$ for $u\ne v$ in one eigenspace, which $T$ cannot express and which every two-eigenvalue critical point satisfies. It is the whole of what (OD) says at two eigenvalues.

**At three or more eigenvalues** there are $\binom{k+1}2\ge6$ Gram matrices and three identities, so the identities cannot determine them; cancellation between the off-diagonal blocks of individual $G$'s is possible in principle. Whether it occurs at any critical point is **not decidable by hand and is not decided here**: the run that would decide it constructs critical points with $\ge3$ eigenvalues and measures $\max_{\mu\nu}\lVert\text{off-block}(G^{\mu\nu})\rVert$, a nonzero value would show the individual $G$'s carry information the weighted sums hide, a zero value across the catalogue would suggest (and only suggest) that each $G^{\mu\nu}$ commutes with $W$ at every critical point. That is a census and is blocked under the standing rule; nothing below depends on it. At padded $W_{\mathbb{CP}^2}$ every $G^{\mu\nu}$ is block-diagonal by hand (§7).

## 6. By-product, a per-row lower bound on $g_k$, and its status

Take the POVM inequality of §3 with $x_{\mu\nu}=\mu+\nu$, i.e. operator Jensen for $S=W\otimes1+1\otimes W$ acting on $\operatorname{End}(\mathfrak{so}(n))$ by $X\mapsto WX+XW$:

$$\iota^\ast S^2\iota\ \succeq\ (\iota^\ast S\iota)(\iota^\ast\iota)^{-1}(\iota^\ast S\iota).$$

Here $\iota^\ast S\iota=\sum(\mu+\nu)G^{\mu\nu}=-4W$ by (B\*), $\iota^\ast\iota=2(n-2)I$, and $\iota^\ast S^2\iota=\sum(\mu+\nu)^2G^{\mu\nu}$ has $k$-th diagonal entry $\sum_{ab}(\lambda_a+\lambda_b)^2T_{kab}=g_k+4\sum_{ab}\lambda_a\lambda_bT_{kab}=g_k+8\lambda_k(\theta-\lambda_k)$, with $g_k=\sum_{ab}(\lambda_a-\lambda_b)^2T_{kab}=\lVert[\mathrm{ad}(e_k),W]\rVert^2$ the record's orbit-tangent quantity. The diagonal of the inequality is

$$\boxed{\;g_k\ \ge\ 8\lambda_k\Big(\frac{n-1}{n-2}\lambda_k-\theta\Big)\;}\qquad\text{for every }k,$$

which is per-row Cauchy–Schwarz on the vector $\mathrm{ad}(e_k)$ against the weight $\lambda_a+\lambda_b$, the *variance* of the pair-sum under the row measure $\mu_k$ of [bounds.md](../findings/bounds.md). It complements the record's per-coordinate **upper** cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$ (Reviewers 109, 110). On a negative row it is a positive lower bound, $g_k\ge8\lvert\lambda_k\rvert\big(\theta+\tfrac{n-1}{n-2}\lvert\lambda_k\rvert\big)$; on a positive row it bites only when $\lambda_k>\tfrac{n-2}{n-1}\theta$, which fails at the balanced product ($h/\theta_0=n/((n-1)(n-2))$, and $n<(n-2)^2$ for $n\ge5$).

**What it yields for $\theta$, and why that is not more than the record has.** Summing the negative rows against $\sum_kg_k=4(n-1)$, with $N_-=\sum_{\lambda<0}\lvert\lambda\rvert$ and $P_-=\sum_{\lambda<0}\lambda^2$,

$$\theta\ \le\ \frac{(n-1)\big(1-\tfrac{2P_-}{n-2}\big)}{2N_-},$$

**tight at the balanced product** ($N_-=\tfrac{n^2}4m$, $P_-=\tfrac{n-2}{2(n-1)}$ give exactly $\theta_0(n)$, all $\tfrac{n^2}4$ negative rows saturating the row bound). But it is **weaker than the record's a priori bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ at padded $W_{\mathbb{CP}^2}$**, $\tfrac{(n-1)(3n-8)}{2(n-2)}\varepsilon$ against $(n-1)\varepsilon$, and combining the row bounds with $\sum\lambda_kg_k=-4\theta$, $g\ge0$ and $\sum g=4(n-1)$, drop the positive rows, place the excess mass at $\lambda_{\min}$, gives, with $C_-=\sum_{\lambda<0}\lvert\lambda\rvert^3$,

$$\theta\le\frac{\tfrac{2(n-1)}{n-2}C_-+(n-1)\lvert\lambda_{\min}\rvert\big(1-\tfrac{2P_-}{n-2}\big)}{1-2P_-+2\lvert\lambda_{\min}\rvert N_-},$$

which returns exactly $(n-1)\lvert\lambda_{\min}\rvert$ at both test points (at $\mathbb{CP}^2$: numerator $(n-1)\varepsilon[\tfrac{2/3}{n-2}+1-\tfrac{2/3}{n-2}]$, denominator $\tfrac13+\tfrac23$; at the balanced product: numerator $(n-1)m$, denominator $1$). It lives inside the pinned class, which [T9](../plan.md) has shown cannot close the conjecture. **Its value is as a per-row inequality on $g_k$ (a lower bound the record lacked) and as the diagonal of a matrix inequality whose off-diagonal blocks are the first place a signed constraint appears** (the matrix $\sum\mu^2G^{\mu\nu}$, whose off-diagonal blocks are not in $T$, must make $2\sum\mu^2G^{\mu\nu}+4\theta W-4W^2-\tfrac8{n-2}W^2$ positive semidefinite). No lower bound on $g_k$ was found in [bounds.md](../findings/bounds.md) §§"per-coordinate cap", "Q-term", "sharpened bound", nor in [INDEX-results.md](../findings/INDEX-results.md).

## 7. Tests at the two named points

**Balanced product $S^{n/2}\times S^{n/2}$, by hand.** $E_h=\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(p)$, $E_m=\mathfrak m=\mathbb R^p\otimes\mathbb R^p$, $p=n/2$. Since $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ and $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$: $G^{mm}$ vanishes on $\mathfrak m$ and on $\mathfrak h$ equals $\langle\mathrm{ad}(u)\vert_{\mathfrak m},\mathrm{ad}(v)\vert_{\mathfrak m}\rangle=p\operatorname{tr}(u_1v_1)+p\operatorname{tr}(u_2v_2)$, scalar; $G^{hm}$ vanishes on $\mathfrak h$ and on $\mathfrak m$ is the Casimir of $\mathfrak h$ on the irreducible $\mathbb R^p\otimes\mathbb R^p$, scalar by Schur; $G^{hh}$ vanishes on $\mathfrak m$ and on $\mathfrak h$ is the Killing form of $\mathfrak h$, the same constant on both factors. All six blocks scalar, all off-blocks zero, Theorem 2 as it must be. The closed forms give $A_{hh}(m)=0$ (saturation) and $A_{mm}(h)=2h[\theta_0+(n-1)h]/(h-m)^2$.

**Padded $W_{\mathbb{CP}^2}$, by hand.** Spectrum $(2\varepsilon,-\varepsilon,-\varepsilon,0,\dots)$, $\varepsilon^2=\tfrac16$, $\theta=3\varepsilon$, with $E_{2\varepsilon}=\mathbb R\omega$ and $E_{-\varepsilon}$ spanning the rest of $\mathfrak{su}(2)_+\subset\mathfrak{so}(4)$, kernel $\mathfrak{su}(2)_-\oplus(\mathbb R^4\otimes\mathbb R^{n-4})\oplus\mathfrak{so}(n-4)$. Within $\mathfrak{su}(2)_+$ the pair cap is saturated, $c_{\omega23}^2=2$. Row $\omega$: types $\{-\varepsilon,-\varepsilon\}$ mass $4$ and $\{0,0\}$ mass $2(n-4)$; (B): $-4\varepsilon=-2\cdot2\varepsilon$; (C): $4\varepsilon^2=2\cdot2\varepsilon(3\varepsilon-2\varepsilon)$. Row $\omega_2$: type $\{2\varepsilon,-\varepsilon\}$ mass $4$, $\{0,0\}$ mass $2(n-4)$; (B): $4\varepsilon-2\varepsilon=2\varepsilon$; (C): $-8\varepsilon^2=2(-\varepsilon)(4\varepsilon)$. The $G$'s: $G^{(-\varepsilon,-\varepsilon)}=4$ on $E_{2\varepsilon}$, zero elsewhere; $G^{(2\varepsilon,-\varepsilon)}=2I$ on $E_{-\varepsilon}$; $G^{(\mu,0)}$ for $\mu\ne0$ is supported on the mixed block, where it is $-\mathrm{ad}(e_\mu)^2$ restricted, and $G^{(0,0)}$ is scalar on $\mathfrak{so}(4)$ and zero between $\mathfrak{so}(4)$ and its complement. Every $G^{\mu\nu}$ is block-diagonal for $W$'s eigenspaces; the kernel blocks are not scalar, and need not be. The by-product bound is valid and slack: $15.4\varepsilon$ at $n=12$ against $\theta=3\varepsilon$.

**Screen** ([screen_t7.py](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/screen_t7.py), $n=6$, under a second, objects constructed for the purpose; a screen of the claims above and evidence for nothing):

| point | $\theta$ | criticality residual | (A\*),(B\*),(C\*) residual | max off-block of any $G^{\mu\nu}$ | max non-scalar part of a diagonal block | rows with $g_k=$ bound |
| --- | --- | --- | --- | --- | --- | --- |
| $S^3\times S^3$ | $1.054093$ | $1\times10^{-16}$ | $3\times10^{-16}$ | $0$ | $0$ (all six blocks scalar: $G^{hh}\vert_{\mathfrak h}=2$, $G^{mm}\vert_{\mathfrak h}=6$, $G^{(h,m)}\vert_{\mathfrak m}=4$ per ordering, rest $0$; the closed form gives $A_{hm}(m)=8$) | $9$ of $15$, all of $E_{\min}$ |
| padded $W_{\mathbb{CP}^2}$ | $1.224745$ | $0$ | $3\times10^{-15}$ | $0$ | $2.0$ (kernel block of $G^{00}$) | $4$ of $15$ ($\mathfrak{su}(2)_-$ and $\mathfrak{so}(2)$, where $g_k=0$) |

The sharp-normalisation of §1 agrees with the library's basis-free $R^\#$ to $2\times10^{-16}$ at both points; $\sum g_k=20=4(n-1)$ at both. The by-product bound returns $1.054093=\theta_0(6)$ at $S^3\times S^3$ and $2.55$ at padded $\mathbb{CP}^2$ against the a priori $2.04$.

## 8. What the off-diagonal block adds beyond (A), (B), (C), the honest statement

1. **On $T$: nothing, by Theorem 1.** Positivity of the Gram family and the three block identities are satisfied by the diagonal family built from any LP-feasible $T$. Rank caps, Jacobi and the compression structure are the only remaining sources, and none is shown to bind.
2. **On the signed $c$: a sign-realizability condition,** $\sum_{\alpha<\beta}d_\alpha d_\beta$ quadratic equations, whose Haar average over each eigenspace's orthogonal group is zero (r331) and which is empty on the coordinate-diagonal locus (§2). At two eigenvalues its content is exactly Theorem 2: the three $\Pi_{\mu\nu}\circ\mathrm{ad}$ are scaled isometries on each eigenspace with orthogonal images.
3. **A per-row lower bound on $g_k$** (§6), true on all critical points, tight on $E_{\min}$ at the balanced product, inside the pinned class.

**Record check.** No claim above contradicts an indexed lemma: Theorem 1 is consistent with r331's completeness (it strengthens the averaging argument to a realisation argument); Theorem 2's closed forms reproduce Lemma L70's bound and Lemma L71's symmetric-pair structure at saturation, and r331/r332's two-eigenvalue pinning; the by-product reproduces $\theta_0(n)$ at the balanced product and does not exceed the a priori bound anywhere it was evaluated. Nothing was written into [findings/](../findings/).

**Blocked item, for the record.** The census of §5's last paragraph (do individual $G^{\mu\nu}$ ever fail to commute with $W$ at a critical point with $\ge3$ eigenvalues) needs computation and was not started.
