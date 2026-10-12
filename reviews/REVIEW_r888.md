# r888 on the interlacing claim about the $L_e$ spectrum at $S^2\times S^{n-2}$, the completeness of its block list, and the zero excess it is meant to support

Reviewer r888, working from a cold brief: no findings file, plan, route or other review was read, and the two spectra families below were derived from the givens alone before being compared with the three tabulated rows. Every number here is exact rational arithmetic. I derived the sectional matrix at $S^2\times S^{n-2}$, fixed the sign and the scale of $L_e$ independently by recomputing $\theta$ from the cubic form, computed all four families of blocks of $L_e$ in closed form (four-set, the $p$-factor pair, the within-$q$-factor pairs, the cross pairs), computed the one block that (G3) and (G4) do not name at all (the coordinate-diagonal block), closed the enumeration by an orthogonal-complement and dimension argument, and reproduced all fifteen tabulated multiplicities at $n=8,10,12$ exactly. Log: [agent_logs/review-r888-interlacing.log](../agent_logs/review-r888-interlacing.log).

| # | Claim, as quoted or as used | Verdict | Reason |
|---|---|---|---|
| C1 | The witness is unconditional at the dimensions that matter, its excess being zero | **CONFIRMED** | and strengthened: $\dim E_{1/2}(L_e)=2n-4=d$ at **every** $n\ge5$, by a closed block enumeration, with $n=4$ checked by hand |
| C2 | Four-set blocks carry $\tfrac12$ exactly when $(p-2)(q-2)=1$, so at $p=q=3$ alone, and at $p=2$ the value exceeds $\tfrac12$ by $\tfrac1{2(n-3)}$ strictly | **CONFIRMED** | $\mu-\tfrac12=\tfrac{(n-2)-(n-3)}{2(n-3)}=\tfrac1{2(n-3)}$, and I rederived $\mu$ from (G3)'s square root independently |
| C3 | The total excess is $0$ at $n=8,10,12$, kernel $12,16,20$ against orbit dimension $12,16,20$ | **CONFIRMED** | the $\tfrac12$-multiplicity is $2(n-2)$ analytically, one per cross pair, giving $12,16,20$ |
| C4 | The general-$n$ reason is an interlacing, which is why no accident is possible: the two competing families straddle $\tfrac12$ and neither can reach it | **REFUTED AS STATED** | a third family, the $2(n-2)$ cross-pair blocks, sits **exactly** at $\tfrac12$, so straddling is not what excludes the accident |
| C5 | In units of $\tfrac1{2(n-3)}$: four-set at $\pm(n-2)$, within-factor pair at $n-4$, orbit's $\tfrac12$ at $n-3$, strictly between at every $n$ | **CONFIRMED AS ALGEBRA** | the three numbers are right and never collide for $n\ge5$, but "within-factor" covers only the $q$-factor pairs, the $p$-factor pair at $p=2$ sitting at $-(n-2)$ |
| C6 | The spectrum is that sparse, exactly $\{-(n-2),0,n-4,n-3,n-2\}$ in those units, with $\binom{n-2}2$ on the positive four-set value and $2n-4$ on $\tfrac12$ | **CONFIRMED** | all five values and all five multiplicities now have closed forms in $n$, verified against the table and screened exactly for $5\le n\le30$ |
| C7 | (G4) gives the $p$-factor pair value $\tfrac{p-2}{2(p-1)}$, which is $0$ at $p=2$ | **REFUTED** | the pair block of $\{1,2\}$ exists, has dimension $n-3$, and is the scalar $-\mu$ on all of it, supplying $n-3$ of the $-\mu$ multiplicity |
| C8 | What the argument still assumes is the completeness of that block list at general $n$ | **HYPOTHESIS-DEBT, discharged here** | completeness holds for a **different** list: four-set blocks, all $\binom n2$ pair blocks (cross pairs included), and the coordinate-diagonal block, whose dimensions sum to $D$ identically in $n$ |
| C9 | $\mu>\tfrac12$ at $p=2$, so $S^2\times S^{n-2}$ is not a local maximum | **CONFIRMED** | $\binom{n-2}2$ strictly positive Hessian directions at every $n\ge4$, which supports the witness role and forbids the maximiser role |
| C10 | Brief item 4's normalisation, cross value $+1$ with $p$-block $-(n-2)$ | **REFUTED AS STATED** | that sign gives $P(W)<0$, hence $\theta<0$ and $L_e=L_M/(N\theta)$ flips every eigenvalue, turning the tabulated asymmetric spectrum inside out |

**One line for the cycle to act on:** the excess-zero conclusion is now a theorem at every $n\ge4$, proved by a closed enumeration of four block families plus the coordinate-diagonal block, and the record's stated reason for it must be replaced, because the omitted cross-pair blocks land exactly on $\tfrac12$ and are exactly the orbit.

## 0. Conventions, fixed once

Quoted from the brief.

- $n=p+q$ with $p,q\ge2$. $\mathcal W_n$ is the space of Weyl tensors in dimension $n$: algebraic curvature tensors that are Ricci-flat and satisfy the first Bianchi identity. $D=\dim\mathcal W_n=\tfrac{n(n+1)(n+2)(n-3)}{12}$.
- The norm is $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$. A **critical point** is $W$ with $\lVert W\rVert=1$ and $Q(W)=\theta W$, and then $\theta=P(W)$.
- $L_x$ is the multiplication operator of the commutative nonassociative algebra on $\mathcal W_n$ whose cubic form is $P$. For $\theta\ne0$ set $e=W/\theta$, an idempotent.
- A Weyl operator is **coordinate-diagonal** when it is diagonal in the basis of coordinate $2$-planes of some orthonormal frame; its **sectional matrix** is $M_{ab}=R_{abab}$, hollow, and Ricci-flatness is that every row sums to zero. Sphere products are coordinate-diagonal.
- The **orbit dimension** of a critical point is $d=\dim(O(n)\cdot W)$, and the **excess** is $\dim E_{1/2}(L_e)-d$.

The givens (G1) to (G7) are carried over verbatim from the brief and are not restated here, beyond the hypothesis inventory below.

## 1. Hypothesis inventory

Every hypothesis of every claim above, and of everything I import, checked against the object it applies to at $p=2$.

| Hypothesis | Source | Object it applies to | Does it hold at $S^2\times S^{n-2}$? | Does the audited argument use it? |
|---|---|---|---|---|
| $p,q\ge2$, $n=p+q$ | setting | $q=n-2\ge2$ | holds for $n\ge4$ | yes, it is the family |
| Row sums of $M$ vanish (Ricci-flatness) | setting | the sectional matrix | holds, and it determines $M$ up to scale and sign | yes, it fixes $\alpha,\beta$ from $\gamma$ |
| $\theta\ne0$, so $e=W/\theta$ exists | setting | $\theta^2=1-\tfrac1{(n-2)^2}$ | holds for $n\ge4$, and $\theta\to1$ from below | yes, every statement is about $L_e$ |
| Coordinate-diagonality | setting | sphere products | holds | yes, (G3) and (G4) need it |
| Sign of $M$ pinned by $\theta=P(W)>0$ | my §2 | within-factor entries positive, cross entries $-1$ | holds, and the opposite sign inverts the spectrum | tacitly, and the brief's item 4 states the opposite sign |
| $P$ homogeneous of degree $3$, sphere shape operator $-\mathrm{Id}$ | (G1) | $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12)$ | holds, rederived in §9 | yes, the whole spectrum is read off a Hessian |
| $L_e$ self-adjoint | metrised commutative algebra | the symmetric trilinear form $\langle L_xy,z\rangle$ | holds | not by the record, and it is what closes my §7 |
| Orbit tangent $\subseteq E_{1/2}$ | (G2) | $[\mathfrak{so}(n),W]$ | holds, and I verify it directly in §5 | yes |
| A $4$-subset has a $2$-dimensional block | (G3) | $\binom n4$ subsets, $n\ge4$ | holds | yes |
| Only $(2,2)$-split $4$-subsets are nonzero | (G3) | $p=2$, so $\{1,2\}\cup\{j,k\}$ | holds, rederived in §3 | yes |
| A pair block has dimension $n-3$ after the trace restriction | (G4) | all $\binom n2$ pairs | holds for $n\ge4$ | only for within-factor pairs, which is the gap |
| The within-$p$ pair block is topped by $\tfrac{p-2}{2(p-1)}$ | (G4) | needs $p\ge3$ for that eigenvector to exist | **fails at $p=2$**, see §4 | yes, and this is C7 |
| $\theta^2=\tfrac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ | (G5) | $S^p\times S^q$ | holds, rederived from the cubic form in §2 | yes, it sets the unit $\tfrac1{2(n-3)}$ |
| $SO(2)\times SO(n-2)$ maximal connected, so $d=2n-4$ | (G6) | $n\ge5$ | the maximality clause fails at $n=4$, where $SO(2)\times SO(2)\subset U(2)$, and the conclusion $d=4$ survives anyway | yes |
| Multiplicity-free nondegeneracy for $p,q\ge3$, $(p,q)\ne(3,3)$ | (G7) | excludes $p=2$ by name | holds and is unusable here | no, and I use it only as the $(3,3)$ cross-check in §7 |
| Index-support grading is $L_e$-invariant | implicit in calling (G3) and (G4) "blocks" | $\mathcal D\oplus\mathcal T\oplus\mathcal F$ | holds, granted by the givens plus self-adjointness | tacitly by the record, explicitly by me |
| Block decomposition non-degenerate | my §6 and §8 | needs $n-5\ge0$ and $n\ne4$ | holds for $n\ge5$, with $n=4$ done separately in §11 | no, the record asserts all $n$ |

## 2. Conventions pinned: the sectional matrix, the norm, the sign and the scale

Ricci-flatness determines the sectional matrix of $S^p\times S^q$ up to one overall factor. Write $\alpha$ for a within-$p$ entry, $\beta$ for a within-$q$ entry and $\gamma$ for a cross entry. The row sum at a $p$-index is $(p-1)\alpha+q\gamma=0$ and at a $q$-index is $(q-1)\beta+p\gamma=0$, so with $\gamma=-1$,

$$\alpha=\frac q{p-1},\qquad \beta=\frac p{q-1},\qquad \gamma=-1,$$

and at $p=2$, $q=n-2$ this is $\alpha=n-2$, $\beta=\tfrac2{n-3}$, $\gamma=-1$. The brief's item 4 states the sign-reversed version of exactly this matrix, and §2.3 shows why the version above is the one that belongs to a positive $\theta$.

### 2.1 The norm

For a coordinate-diagonal tensor each unordered pair $\{a,b\}$ contributes the four quadruples $(a,b,a,b)$, $(a,b,b,a)$, $(b,a,a,b)$, $(b,a,b,a)$, each of square $M_{ab}^2$, so $\lVert R\rVert^2=\sum_{a<b}M_{ab}^2$. Hence

$$N^2:=\lVert M\rVert^2=\binom p2\alpha^2+\binom q2\beta^2+pq=pq\cdot\frac{q(q-1)+p(p-1)+2(p-1)(q-1)}{2(p-1)(q-1)}=\frac{pq(n-1)(n-2)}{2(p-1)(q-1)},$$

using $p^2+q^2+2pq-3p-3q+2=(n-1)(n-2)$.

### 2.2 The cubic form on coordinate-diagonal tensors

For $m$ hollow symmetric, $P(m)=\sum_{a<b}m_{ab}^3+\tfrac12\operatorname{tr}(m^3)$ and $\nabla P=3Q(m)$ with $Q(m)_{ab}=m_{ab}^2+(m^2)_{ab}$, since $\partial_{m_{ab}}\bigl(\tfrac12\operatorname{tr}m^3\bigr)=3(m^2)_{ab}$ on the symmetric off-diagonal variables. This reproduces $P=\langle m,Q(m)\rangle$, so the convention is the brief's.

### 2.3 The value of $\theta$, rederived, which pins the sign

With $S_{ab}=\sum_{c\ne a,b}M_{ac}M_{bc}$ one gets $S=(p-2)\alpha^2+q$ inside the $p$-factor, $S=(q-2)\beta^2+p$ inside the $q$-factor, and $S=-(p-1)\alpha-(q-1)\beta=-n$ across, so

$$P(M)=(p-1)\binom p2\alpha^3+q\binom p2\alpha+(q-1)\binom q2\beta^3+p\binom q2\beta+pq(n-1)=pq\Bigl[\frac{q^2}{2(p-1)}+\frac{p^2}{2(q-1)}+\frac{3n}2-1\Bigr].$$

At $(p,q)=(3,3)$ this is $9\cdot\tfrac{25}2=112.5$ and $(n-1)N^2=\tfrac{9\cdot25\cdot4}{8}=112.5$. At $(p,q)=(2,6)$ it is $12\cdot29.4=352.8$ and $(n-1)N^2=\tfrac{12\cdot49\cdot6}{10}=352.8$. So $P(M)=(n-1)N^2$, hence with $W=M/N$

$$\theta=P(W)=\frac{P(M)}{N^3}=\frac{n-1}N,\qquad \theta^2=\frac{(n-1)^2}{N^2}=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq},$$

which is (G5) exactly, and at $p=2$ gives $\theta^2=\tfrac{(n-1)(n-3)}{(n-2)^2}=1-\tfrac1{(n-2)^2}$, matching the tabulated $\theta$ to all nine printed digits ($\sqrt{35}/6$, $\sqrt{63}/8$, $\sqrt{99}/10$). **Two consequences.** First, $\theta>0$ for the sign convention of §2, so $L_e=L_W/\theta=L_M/(N\theta)=\tfrac1{n-1}L_M$ with a positive scale. Second, the brief's item 4 sign gives $\theta<0$ and therefore $L_e=-\tfrac1{n-1}L_M$, which negates every eigenvalue. Because the true spectrum is asymmetric, $-\mu$ carrying multiplicity $n(n-3)$ against $\binom{n-2}2$ on $+\mu$, that sign choice is detectable and is wrong. This is C10.

## 3. The interlacing arithmetic, and (G3) rederived (brief item 1)

**No finding on the three numbers.** In units of $\tfrac1{2(n-3)}$, at $p=2$:

| quantity | value | in units of $\tfrac1{2(n-3)}$ |
|---|---|---|
| four-set value $\mu=\tfrac{n-2}{2(p-1)(q-1)}$ | $\tfrac{n-2}{2(n-3)}$ | $n-2$ |
| within-$q$-factor pair value $\tfrac{q-2}{2(q-1)}$ | $\tfrac{n-4}{2(n-3)}$ | $n-4$ |
| the orbit's eigenvalue | $\tfrac12=\tfrac{n-3}{2(n-3)}$ | $n-3$ |

So $n-4<n-3<n-2$, strictly, with no collision and no reordering at any $n$, and $\mu-\tfrac12=\tfrac1{2(n-3)}$ exactly, which is C2. The unit is positive for $n\ge4$ and undefined at $n=3$, where $D=0$ and there is no Weyl tensor.

I also rederived $\mu$ from (G3) rather than taking it. Reading the three $2{+}2$ pairings of $\{1,2,j,k\}$ as the sums $A=M_{12}+M_{jk}=\alpha+\beta$, $B=M_{1j}+M_{2k}=-2$, $C=M_{1k}+M_{2j}=-2$, the discriminant collapses:

$$A^2+B^2+C^2-AB-BC-CA=A^2+8+(4A-4)=(A+2)^2,\qquad A+2=\frac{q(q-1)+p(p-1)+2(p-1)(q-1)}{(p-1)(q-1)}=\frac{(n-1)(n-2)}{(p-1)(q-1)},$$

so the $L_M$ eigenvalues are $\pm\tfrac12(A+2)$ and the $L_e$ eigenvalues are $\pm\tfrac{A+2}{2(n-1)}=\pm\tfrac{n-2}{2(p-1)(q-1)}=\pm\mu$. For a $4$-subset with three indices in the $q$-factor all three pairings equal $\beta-1$ and the discriminant vanishes, and for four indices in the $q$-factor all three equal $2\beta$ and it vanishes again, so at $p=2$ only the $(2,2)$-splits are nonzero. (G3) is confirmed, in general $p,q$ and at $p=2$.

**Smallest $n$.** The family $S^2\times S^{n-2}$ exists for $n\ge4$. The interlacing inequality is strict for every $n\ge4$. The uniform block derivation below is valid for $n\ge5$, because the within-$q$ pair block needs $q-2\ge1$ and the coordinate-diagonal block needs $n\ne4$. At $n=4$ the value $n-4$ is absent from the spectrum altogether, so one side of the straddle is vacuous there, and §11 settles $n=4$ by hand.

## 4. The $p$-factor pair block at $p=2$ (brief item 2)

**Finding, C7.** The pair $\{1,2\}$ is a within-$p$ pair, its block exists, it has the full dimension $n-3$, and its eigenvalue is $-\mu$ throughout. It is not $\tfrac{p-2}{2(p-1)}=0$.

Take $j=1$, $k=2$. For $i$ in the $q$-factor, $M_{1i}+M_{2i}=2\gamma=-2$, and $M_{12}=\alpha=n-2$, and $M^{(12)}=\beta(J_q-I_q)$ on the $q$ remaining indices. On the trace-restricted subspace $\sum_ix_i=0$ the all-ones matrix $J_q$ acts as zero, so (G4) gives the scalar

$$\tfrac12\bigl[-2-(n-2)-\beta\bigr]=-\tfrac12\Bigl(n+\frac2{n-3}\Bigr)=-\frac{(n-1)(n-2)}{2(n-3)},\qquad L_e\text{ value }=-\frac{n-2}{2(n-3)}=-\mu,$$

with multiplicity $n-3$. For contrast, the general-$p$ within-$p$ block splits, on the $p-2$ same-factor indices and the $q$ other-factor indices, into $0$ with multiplicity $p-3$, $-\mu$ with multiplicity $q-1$, and $+\tfrac{p-2}{2(p-1)}$ once, the last carried by the direction $x_i=u$ on the $p$-side and $x_i=v$ on the $q$-side with $(p-2)u+qv=0$. At $p=2$ that direction does not exist, the set of same-factor indices being empty, and the formal count $(p-3)+(q-1)+1=n-3$ survives only because the phantom $0$ of multiplicity $-1$ cancels the phantom eigenvalue $\tfrac{p-2}{2(p-1)}=0$. The eigenvalue the record reads off at $p=2$ is therefore an artefact of continuing a formula past the case it was derived in, and the $n-3$ directions it stands for actually sit at $-\mu$.

## 5. The cross-pair block, computed, and it reaches $\tfrac12$ (brief item 4)

**Finding, and it is the one that refutes C4.** Take $j=1$ in the $p$-factor and $k$ in the $q$-factor. Then $M_{jk}=\gamma=-1$, and the remaining indices are the other $p$-index $j'=2$ and the $n-3$ other $q$-indices. Here $M_{1,2}+M_{k,2}=\alpha-1=n-3$ and $M_{1,k'}+M_{k,k'}=\beta-1$, so the bracket of (G4) has diagonal $n-3+1=n-2$ at $j'$ and $\beta-1+1=\beta$ at each $k'$, off-diagonal $-1$ between $j'$ and each $k'$, and $\beta$ among the $k'$, that is $\beta J_{n-3}$ on the $q$-side.

On $\sum_ix_i=0$ this has exactly two eigenvalues.

- Supported on the $q$-side with zero sum: $\beta J x=0$ and the $j'$ row reads $-\sum x=0$, so the eigenvalue is $0$ with multiplicity $n-4$.
- The remaining direction $x_{j'}=u$, $x_{k'}=v$ for all $k'$, with $u+(n-3)v=0$. The $j'$ row gives $(n-2)u-(n-3)v=(n-2)u+u=(n-1)u$, and the $q$-row gives $-u+\beta(n-3)v=-u(1+\beta)=-u\tfrac{n-1}{n-3}=(n-1)v$, consistently. The bracket eigenvalue is $n-1$, the block eigenvalue is $\tfrac{n-1}2$, and

$$L_e\text{ value }=\frac{n-1}{2(n-1)}=\frac12\quad\text{exactly, at every }n.$$

So $\tfrac12$ does occur in the family that the record's two closed forms do not cover, and there are $2(n-2)$ such pairs.

**That eigenvector is the orbit direction.** Under the infinitesimal rotation $X=e_j\wedge e_k$ a coordinate-diagonal $W$ moves only in the $3$-index components sharing the pair $\{j,k\}$, with $f_i$-component proportional to $M_{ki}-M_{ji}$, because a $2$-index component picks up a $3$-index component of $W$ (zero) and a $4$-index component picks up another $4$-index component of $W$ (zero). For $j=1$, $k$ in the $q$-factor this gives $M_{k2}-M_{12}=-1-(n-2)=-(n-1)$ at $i=2$ and $M_{kk'}-M_{1k'}=\beta+1=\tfrac{n-1}{n-3}$ at each other $q$-index, that is the ratio $u:v=1:-\tfrac1{n-3}$, which is the eigenvector above, and its coordinates sum to zero as Ricci-flatness demands. Within-factor generators give $M_{ki}-M_{ji}=0$ identically, so they annihilate $W$. Hence the orbit tangent is spanned by one vector in each of the $2(n-2)$ cross-pair blocks, these are independent because they live in different blocks, and $d=2(n-2)=2n-4$, which reproves (G6)'s conclusion without its maximality argument.

The consequence for C4 is immediate. The reason no accident is possible is not that the competing families straddle $\tfrac12$ and cannot reach it. A third family reaches $\tfrac12$ on the nose, at every $n$, and the reason the excess stays zero is that it reaches it with multiplicity exactly one per block and that the vector attaining it is the orbit direction itself.

## 6. The coordinate-diagonal block, which (G3) and (G4) do not name

The remaining directions are the coordinate-diagonal ones, that is $\mathcal D$, the hollow symmetric $Y$ with all row sums zero, of dimension $\tfrac{n(n-3)}2$. Polarising §2.2, for coordinate-diagonal $Y$

$$L_eY=\frac1{2(n-1)}\bigl[2\,M\odot Y+MY+YM\bigr],$$

entry by entry at the pair $\{a,b\}$ with $a\ne b$, where $\odot$ is the entrywise product. The $\#$ sum runs over $c\notin\{a,b\}$ and the two omitted terms vanish by hollowness, so the matrix-product form is exact, and the output is again hollow because it is defined only on pairs. Parametrise $Y$ by $y=Y_{12}$, by $u_k=Y_{1k}$ and $v_k=Y_{2k}$ for $k$ in the $q$-factor, and by the hollow symmetric $Z$ on the $q$-factor. The row-sum conditions are $y+\sum_ku_k=0$, $y+\sum_kv_k=0$ and $u_j+v_j+\sum_kZ_{jk}=0$.

**Type A, dimension $\tfrac{(n-2)(n-5)}2$, eigenvalue $0$.** Take $y=0$, $u=v=0$ and $Z$ hollow symmetric with zero row sums. Then $M\odot Y=\beta Z$ on the $q$-block, and $(MY)_{1k}=-\sum_cZ_{ck}=0$, $(MY)_{jk}=\beta\sum_{c\ne j}Z_{ck}=-\beta Z_{jk}$, so $MY=YM=-\beta Z$ and $L_eY=\tfrac1{2(n-1)}(2\beta-\beta-\beta)Z=0$.

**Copy (i), dimension $n-3$, eigenvalue $-\mu$.** Take $u_k=w_k$, $v_k=-w_k$ with $\sum_kw_k=0$ and everything else zero, which satisfies all three row-sum conditions. Then $M\odot Y=-Y$, and $(MY)_{1k}=\alpha(-w_k)$, $(MY)_{k1}=\beta(\sum_cw_c-w_k)=-\beta w_k$, so $MY+YM=-(\alpha+\beta)Y$ and

$$L_eY=\frac{-2-\alpha-\beta}{2(n-1)}Y=-\frac{(n-1)(n-2)}{2(n-1)(n-3)}Y=-\mu\,Y.$$

**Copy (ii), dimension $n-3$, eigenvalue $\tfrac{n-4}{2(n-3)}$.** Take $u_k=v_k=w_k$ with $\sum_kw_k=0$, $y=0$, and $Z_{jk}=c(w_j+w_k)$ with $c=-\tfrac2{n-4}$, which makes the $q$-row sums $2w_j+c(n-4)w_j=0$. Computing, $(MY+YM)_{1k}=(\alpha+2)w_k-\beta w_k$ and $(MY+YM)_{jk}=-2(1+\beta)(w_j+w_k)-2\beta Z_{jk}$, while $2M\odot Y$ contributes $-2w_k$ on the cross entries and $2\beta Z_{jk}$ on the $q$-block, so the output is $u'=v'=(\alpha-\beta)w$ and $Z'_{jk}=-2(1+\beta)(w_j+w_k)$. Since $\alpha-\beta=\tfrac{(n-1)(n-4)}{n-3}=(n-4)(1+\beta)$, the output has vanishing row sums and equals $(\alpha-\beta)$ times the input, so

$$L_eY=\frac{\alpha-\beta}{2(n-1)}Y=\frac{n-4}{2(n-3)}Y.$$

**The trivial direction.** The subspace of $\mathcal D$ invariant under $S_2\times S_{n-2}$ is cut out by two row-sum equations on three parameters, so it is $\operatorname{span}(W)$, carrying the eigenvalue $1$ of the idempotent.

These exhaust $\mathcal D$: $1+2(n-3)+\tfrac{(n-2)(n-5)}2=\tfrac{n(n-3)}2$. So the coordinate-diagonal block contributes $-\mu$ and $\tfrac{n-4}{2(n-3)}$ each with multiplicity $n-3$, and nothing at $\tfrac12$.

## 7. Completeness, which is the question that matters (brief item 3)

**Finding, C8.** The record's list is incomplete in two ways, and a closed list exists.

Grade $\mathcal W_n$ by the number of distinct frame indices carried by a component: $\mathcal D$ the $2$-index part, $\mathcal T$ the $3$-index part, $\mathcal F$ the $4$-index part.

| piece | description | dimension | identification |
|---|---|---|---|
| $\mathcal D$ | hollow sectional matrices with zero row sums | $\tfrac{n(n-3)}2$ | named by neither (G3) nor (G4), computed in §6 |
| $\mathcal T$ | $R_{jiki}$, one space per pair $\{j,k\}$, trace-restricted | $\binom n2(n-3)$ | exactly (G4)'s pair blocks, all $\binom n2$ of them |
| $\mathcal F$ | $R_{abcd}$ on one $4$-subset, three pairings modulo one Bianchi relation | $2\binom n4$ | exactly (G3)'s four-set blocks |

The $4$-index pieces are automatically Ricci-flat, since $\sum_aR_{abac}$ involves only three distinct indices, and each carries dimension $2$ after Bianchi. The $3$-index piece for a fixed pair has $n-2$ components cut by one trace, hence $n-3$. And

$$\frac{n(n-3)}2+\frac{n(n-1)(n-3)}2+\frac{n(n-1)(n-2)(n-3)}{12}=\frac{n(n-3)}{12}\bigl[6n+(n-1)(n-2)\bigr]=\frac{n(n-3)(n+1)(n+2)}{12}=D,$$

identically in $n$. So the three pieces are mutually orthogonal, by disjoint component supports, and they span $\mathcal W_n$.

**Why the enumeration is closed.** The givens themselves assert that each four-set subspace and each pair subspace is a block of $L_e$, that is an invariant subspace. Their sum is therefore invariant, and $L_e$ is self-adjoint because the trilinear form $\langle L_xy,z\rangle$ of the algebra is symmetric, so the orthogonal complement of that sum is invariant too. By the dimension identity the complement is exactly $\mathcal D$, whose spectrum §6 computes. There is no fourth family, and no room for one.

**Where $\tfrac12$ can appear.** Collecting every value in the closed list at $p=2$:

| family | values, in units of $\tfrac1{2(n-3)}$ | can equal $n-3$? |
|---|---|---|
| $\mathcal F$, $(2,2)$-split | $+(n-2)$, $-(n-2)$ | no, $n-2\ne n-3$ |
| $\mathcal F$, other splits | $0$ | no |
| pair $\{1,2\}$ | $-(n-2)$ | no |
| within-$q$ pairs | $-(n-2)$, $0$, $n-4$ | no, $n-4\ne n-3$ |
| cross pairs | $n-3$ once, $0$ otherwise | **yes, exactly once per block, and that vector is the orbit direction** |
| $\mathcal D$ | $1$ on $e$, $-(n-2)$, $n-4$, $0$ | no |

Hence $\dim E_{1/2}(L_e)=2(n-2)=d$ and the excess is $0$ for every $n\ge5$. The conclusion C1 is therefore a theorem rather than a screen, and it is proved by counting a coincidence rather than by excluding one.

**Cross-check at $(3,3)$, which the method must get right.** At $p=q=3$ the four-set value is $\mu=\tfrac{n-2}{2\cdot2\cdot2}=\tfrac48=\tfrac12$, and the number of $(2,2)$-split $4$-subsets is $\binom32\binom32=9$, each supplying one $+\tfrac12$ beyond the orbit. That is exactly the excess $9$ that (G7) records at $(3,3)$, which is independent evidence that the block families and their multiplicities are being counted correctly.

## 8. Multiplicity bookkeeping and closed forms (brief item 5)

**No finding on $\binom{n-2}2$ or on $2n-4$.** At $p=2$ a $(2,2)$-split $4$-subset must take both $p$-indices, so the count is the number of pairs in the $q$-factor, $\binom{n-2}2$. The orbit dimension is $2n-4$ by §5, computed directly rather than via (G6).

Assembling §3 to §6, the tangent spectrum at $S^2\times S^{n-2}$ is, for every $n\ge5$:

| $L_e$ value | in units of $\tfrac1{2(n-3)}$ | multiplicity, by source | closed form |
|---|---|---|---|
| $-\tfrac{n-2}{2(n-3)}$ | $-(n-2)$ | $\binom{n-2}2$ ($\mathcal F$) $+\ (n-3)$ (pair $\{1,2\}$) $+\ \binom{n-2}2$ (within-$q$ pairs) $+\ (n-3)$ ($\mathcal D$) | $n(n-3)$ |
| $0$ | $0$ | $2\bigl[\binom n4-\binom{n-2}2\bigr]+\binom{n-2}2(n-5)+2(n-2)(n-4)+\tfrac{(n-2)(n-5)}2$ | $D-1-(2n^2-5n-1)$ |
| $\tfrac{n-4}{2(n-3)}$ | $n-4$ | $\binom{n-2}2$ (within-$q$ pairs) $+\ (n-3)$ ($\mathcal D$) | $\tfrac{n(n-3)}2$ |
| $\tfrac12$ | $n-3$ | $2(n-2)$ (cross pairs, one each) | $2n-4$ |
| $+\tfrac{n-2}{2(n-3)}$ | $n-2$ | $\binom{n-2}2$ ($\mathcal F$) | $\tfrac{(n-2)(n-3)}2$ |

The four nonzero multiplicities sum to $(n-3)(2n-1)+2n-4=2n^2-5n-1$, so the zero multiplicity is $D-1-(2n^2-5n-1)$ and the five sum to $D-1$ by construction. At the tabulated dimensions this gives

| $n$ | $D-1$ | $-\mu$ | $0$ | $\tfrac{n-4}{2(n-3)}$ | $\tfrac12$ | $+\mu$ |
|---|---|---|---|---|---|---|
| $8$ | $299$ | $40$ | $212$ | $20$ | $12$ | $15$ |
| $10$ | $769$ | $70$ | $620$ | $35$ | $16$ | $28$ |
| $12$ | $1637$ | $108$ | $1410$ | $54$ | $20$ | $45$ |

which is the brief's table, row for row and entry for entry, including the two multiplicities the record singles out. So C6 is confirmed and now holds at every $n\ge5$ rather than at three dimensions. I screened the closed forms in exact rational arithmetic for $5\le n\le30$: the five multiplicities are integers, they sum to $D-1$ at every $n$, and they reproduce the table.

**A scale-sensitive identity that the spectrum satisfies.** The trace of $L_e$ on all of $\mathcal W_n$ vanishes:

$$1+\mu\Bigl[\binom{n-2}2-n(n-3)\Bigr]+\frac{n-4}{2(n-3)}\cdot\frac{n(n-3)}2+\frac12(2n-4)=1-\frac{(n-2)(n+2)}4+\frac{n(n-4)}4+n-2=0,$$

identically in $n$, and the same holds numerically at $n=8,10,12$ from the tabulated rows. Two accidents cancelling for all $n$ would be a remarkable coincidence, so this is strong internal evidence for both the multiplicities and the normalisation.

## 9. The conversion in (G1) (brief item 6)

**No finding, and the factor is right.** With $\nabla P=3Q(W)$ from §2.2 and $L_W=\tfrac12DQ_W$, which is the normalisation that makes $L_ee=e$ because $DQ_W(W)=2Q(W)=2\theta W$, the Euclidean Hessian is $\mathrm{Hess}\,P=3DQ_W=6\theta L_e$. The unit sphere has shape operator $-\mathrm{Id}$ with respect to the outward normal $W$, so on the tangent space $\mathrm{Hess}_SP=\mathrm{Hess}\,P-\langle\nabla P,W\rangle\mathrm{Id}=6\theta L_e-3\theta\,\mathrm{Id}=6\theta(L_e-\tfrac12\mathrm{Id})$, which is (G1). What it assumes: the normalisation $L_ee=e$, so that $L_e=\tfrac1{2\theta}DQ_W$ and not some other multiple; $\theta\ne0$; that the ambient space is $\mathcal W_n$ with the projected product, so $P$ means $P$ restricted to $\mathcal W_n\cap S$; and that the trilinear form is symmetric, which is also what makes $L_e$ self-adjoint in §7.

**What would detect a wrong factor.** Three things, and all three pass. First, idempotency fixes the eigenvalue $1$ on $e$ itself, so a wrong overall factor $\lambda$ on the tangent part would break $\operatorname{tr}L_e=1+\lambda\cdot(-1)=0$, and §8 shows the trace vanishes identically in $n$. Second, (G2) forces the orbit tangent to sit at exactly $\tfrac12$, and §5 computes that block's eigenvalue as $\tfrac{n-1}{2(n-1)}$ from the sectional matrix alone, hitting $\tfrac12$ on the nose at every $n$, which no wrong factor survives. Third, the independently rederived $\theta$ of §2.3 matches the tabulated values to nine digits. A wrong factor would therefore not merely shift the interlacing, it would detach the orbit from $\tfrac12$ and be visible immediately.

## 10. Saddle consistency (brief item 7)

**No finding, confirmed.** With $\theta>0$ and $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12)$, a local maximum requires $L_e\le\tfrac12$ on the whole tangent space. At $p=2$ the four-set blocks give $\mu=\tfrac12+\tfrac1{2(n-3)}>\tfrac12$, so the Hessian has $\binom{n-2}2$ strictly positive directions at every $n\ge4$, and $S^2\times S^{n-2}$ is a saddle of $P$ on the unit sphere, never a local maximum. In the unnormalised reading the largest eigenvalue of $L_W$ off $W$ is $\theta\mu$, and the maximum condition $\theta\mu\le\theta/2$ is the same inequality, so the brief's $\mu>\theta/2$ phrasing and the normalised one agree.

Whether this undermines the witness role depends on what the witness is asked to do, and the cold brief does not say. As a critical point that is nondegenerate modulo its orbit, with a computable $\theta$ and excess zero, it is a valid witness, and the saddle character is a prediction of the same interlacing arithmetic rather than a defect in it. As a candidate maximiser it fails, by a strict inequality of size $\tfrac1{2(n-3)}$ at every $n$, so any use that needs maximality is refuted at $p=2$ for all $n$. The parent should check which of the two the record's non-domination argument needs.

## 11. Kernel, odd $n$, and the boundary (brief item 8)

**Odd $n$ changes nothing.** Every quantity above is a rational function of $n$ with no parity dependence, and the multiplicities are integers at both parities, since one of $n$ and $n-3$ is even in $\tfrac{n(n-3)}2$ and one of $n-2$ and $n-5$ is even in $\tfrac{(n-2)(n-5)}2$. My exact screen covers $n=9,11,13,\dots$ with the same closed forms, for instance $n=9$ giving $54,378,27,14,21$ against $D-1=494$. The record's choice of $n=8,10,12$ therefore hides nothing.

**The boundary $n=4$.** The family exists, but three things degenerate. The within-$q$ pair block loses its top direction, since the other-$q$-index set is empty, so the value $\tfrac{n-4}{2(n-3)}$ is absent from the spectrum entirely. The coordinate-diagonal copy (ii) needs $c=-\tfrac2{n-4}$ and does not exist, consistent with the fact that at $|Q|=2$ the prescribed row sums force $w=0$. And (G6)'s maximality clause fails, because $SO(2)\times SO(2)\subset U(2)\subset SO(4)$. Done by hand instead: the sectional matrix is $M_{12}=M_{34}=2$ with all four cross entries $-1$, so $W^\pm=\operatorname{diag}(2,-1,-1)$ on $\Lambda^\pm$, the stabiliser is a $2$-torus and $d=4=2n-4$ as (G6) concludes. The tangent spectrum is then $-\mu=-1$ with multiplicity $4$, $\tfrac12$ with multiplicity $4$ from the four cross pairs, and $+\mu=1$ once, summing to $9=D-1$, so the excess is $0$ at $n=4$ as well. The uniform statement is therefore: excess zero for all $n\ge4$, with $n\ge5$ covered by the closed forms and $n=4$ by this hand count.

**The kernel.** As an operator on $\Lambda^2$, $W$ is diagonal with entries $\alpha=n-2$ once, $\beta=\tfrac2{n-3}$ on $\binom{n-2}2$ planes and $\gamma=-1$ on $2(n-2)$ planes, all nonzero for every $n\ge4$. So $\ker W=0$ and no sectional value vanishes. Any argument that wants a kernel, or that uses a degenerate sectional entry, has no purchase on this family.

## 12. What would falsify it, and what I did to look (brief item 9)

**The falsifier.** A Weyl tensor $y\in\mathcal W_n$ at $S^2\times S^{n-2}$ with $L_ey=\tfrac12y$ and $y$ orthogonal to the orbit tangent. Its existence would make the excess positive and would refute C1 whatever the reason given for C1.

**What I did.** I computed all four block families and the coordinate-diagonal block in closed form, so any such $y$ would have to live in one of them, and §7 tabulates that $\tfrac12$ is unreachable in four of the five and one-dimensional in the fifth, where it is the orbit direction itself. I closed the enumeration by the dimension identity $\tfrac{n(n-3)}2+\binom n2(n-3)+2\binom n4=D$, which holds identically in $n$ rather than at three sampled dimensions, so there is no unaccounted subspace for a falsifier to hide in. I reproduced all fifteen tabulated multiplicities, verified $\operatorname{tr}L_e=0$ symbolically and numerically, rederived $\theta$ and (G3)'s $\mu$ from the cubic form, and screened the closed forms exactly for $5\le n\le30$.

**Where a falsifier could still come from, in order of remaining risk.** First, failure of the index-support grading to be $L_e$-invariant, which would couple $\mathcal D$, $\mathcal T$ and $\mathcal F$ and could place $\tfrac12$ in a coupled block. This is granted by (G3) and (G4) calling their subspaces blocks, and my §7 needs no more than that plus self-adjointness, so the risk sits entirely inside those givens. Second, an error in (G3)'s vanishing for non-$(2,2)$ splits, which I rederived and which came out zero because all three pairings coincide. Third, an arithmetic slip in the $-\mu$ multiplicity $n(n-3)$, which the trace identity and the table both check. I did not open any search over families other than $S^2\times S^{n-2}$, and no run in this review exceeded seconds.

## 13. Verdict

**The conclusion stands and is stronger than claimed. The stated reason for it does not stand.**

- The excess at $S^2\times S^{n-2}$ is zero at every $n\ge4$, and this is now a derivation rather than a screen at three dimensions. The $\tfrac12$-eigenspace is spanned by one vector in each of the $2(n-2)$ cross-pair blocks, and each of those vectors is the orbit direction $[e_j\wedge e_k,W]$.
- The interlacing sentence is refuted as the reason. The two families the record names do straddle $\tfrac12$, at $n-4$ and $n-2$ units against $n-3$, but the family it omits sits exactly on $\tfrac12$. The correct reason is a closed enumeration plus a multiplicity-one coincidence that (G2) already predicts.
- The block list must be corrected in two places before it is used again: all $\binom n2$ pairs carry pair blocks, the cross pairs among them, and the coordinate-diagonal subspace of dimension $\tfrac{n(n-3)}2$ is a block that neither (G3) nor (G4) names. With those two additions the list is provably complete, so the completeness debt is discharged.
- The $p$-factor pair value $\tfrac{p-2}{2(p-1)}$ must not be evaluated at $p=2$. The block of the pair $\{1,2\}$ is the scalar $-\mu$ on all $n-3$ of its dimensions.
- $S^2\times S^{n-2}$ is a saddle at every $n$, with $\binom{n-2}2$ ascending directions, so any use of it that requires a maximiser fails, and any use that requires a critical point nondegenerate modulo its orbit succeeds.
