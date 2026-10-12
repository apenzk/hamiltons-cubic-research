# Review r887: the interlacing claim about the $L_e$ spectrum at $S^2\times S^{n-2}$, and the completeness of its block list

Reviewer r887, adversarial, working from a cold brief and from the givens (G1)–(G7) alone. I derived the **entire** $L_e$ spectrum at $S^2\times S^{n-2}$ in closed form in $n$, by decomposing $\mathcal W_n$ into the isotypic components of the diagonal sign group $(\mathbb Z_2)^n\subset O(n)$, and computing every block. The idempotent normalisation is $e = -M/(n-1)$ with $M$ the sectional matrix normalised to cross value $1$, pinned three independent ways. The resulting five closed-form multiplicities reproduce all fifteen tabulated integers at $n=8,10,12$ exactly, the same machinery reproduces (G7)'s independently known excess $9$ at $(3,3)$, and the block decomposition is closed by the exact dimension identity $\tfrac{n(n-3)}2+\binom n2(n-3)+2\binom n4 = D$. Every value below is exact rational arithmetic. Log: [agent_logs/review-r887-interlacing.log](../agent_logs/review-r887-interlacing.log).

## Claim table

| # | Claim, as quoted or imported | Verdict | Reason |
|---|---|---|---|
| C1 | The four-set blocks carry $\tfrac12$ exactly when $\mu=\tfrac12$, that is when $(p-2)(q-2)=1$, so at $p=q=3$ alone | **CONFIRMED** | $\tfrac{n-2}{2(p-1)(q-1)}=\tfrac12 \iff pq-2p-2q+3=0 \iff (p-2)(q-2)=1$, whose only solution with $p,q\ge2$ is $p=q=3$ |
| C2 | At $p=2$ the four-set value exceeds $\tfrac12$ by $\tfrac1{2(n-3)}$ strictly | **CONFIRMED** | $\mu=\tfrac{n-2}{2(n-3)}=\tfrac12+\tfrac1{2(n-3)}$ identically, and $n-3>0$ on the whole family |
| C3 | The total excess is $0$ at $n=8,10,12$, kernel $12,16,20$ against orbit $12,16,20$ | **CONFIRMED**, and upgraded | I derive $\dim E_{1/2}(L_e)=2n-4$ in closed form at every $n\ge4$, so the three screened dimensions are three instances of a theorem |
| C4 | In units of $\tfrac1{2(n-3)}$ the four-set blocks sit at $\pm(n-2)$, the within-factor pair blocks at $n-4$, and $\tfrac12$ is $n-3$, strictly between | **REFUTED AS STATED** | Correct for the four-set blocks, for $\tfrac12$, and for the within-$q$-factor pair blocks. The within-$p$-factor pair block at $p=2$ sits at $-(n-2)$, not $n-4$ |
| C5 | "The two competing families straddle $\tfrac12$ and neither can reach it", offered as the general-$n$ reason | **CONFIRMED AS ALGEBRA** | The straddling is exact at every $n$, and it decides nothing on its own: two further $L_e$-invariant sectors exist, one of which is where the $\tfrac12$ actually lives |
| C6 | The spectrum is exactly $\{-(n-2),0,n-4,n-3,n-2\}$ in those units at $n=8,10,12$ | **CONFIRMED**, and extended | The set of tangent eigenvalues is exactly that at every $n\ge5$, by closed-form derivation rather than by pattern |
| C7 | Multiplicities $\binom{n-2}2$ on the positive four-set value and $2n-4$ on $\tfrac12$, summing to the tangent dimension | **CONFIRMED** for those two, **HYPOTHESIS-DEBT** for the sum | Both named multiplicities are exact. The five multiplicities sum to $D-1$ only once the cross-pair and coordinate-diagonal sectors are counted, and the record names neither |
| C8 | "What the argument still assumes is the COMPLETENESS of that block list at general $n$" | **HYPOTHESIS-DEBT DISCHARGED**, with a correction | The list of *blocks* is complete and $L_e$-invariant, by $(\mathbb Z_2)^n$ isotypy. The record's list of *values* was incomplete, omitting two whole sectors |
| C9 | Imported (G4): each within-factor pair block is topped by $\tfrac{p-2}{2(p-1)}$ inside the $p$-factor | **REFUTED AS STATED** at $p=2$ | At $p=2$ the block is the scalar $-\mu\,\mathrm{Id}$ on dimension $n-3$, so its top is $-\tfrac{n-2}{2(n-3)}$ and the value $0$ is absent from it. (G4) holds as stated for $p\ge3$ |
| C10 | "The witness is now unconditional at the dimensions that matter, its excess being zero" | **CONFIRMED**, and stronger | The excess is $0$ at every $n\ge4$, with no restriction to the screened dimensions and no completeness debt remaining |
| C11 | Item 7: $S^2\times S^{n-2}$ is therefore not a local maximum | **CONFIRMED** | $\mathrm{Hess}_SP$ has eigenvalue $6\theta(\mu-\tfrac12)=\tfrac{3\theta}{n-3}>0$ with multiplicity $\binom{n-2}2\ge1$, so the point is a strict saddle, which is what a nondegenerate critical orbit is expected to be |

## One-line summary for the cycle

The conclusion is right and is now a theorem at every $n\ge4$ rather than a pattern screened at three dimensions, and the stated argument for it is wrong in one imported value and incomplete by two whole sectors: record the full closed-form spectrum below, correct (G4) at $p=2$, and retire the completeness caveat.

## 0. Conventions, fixed once

Quoted from the brief.

- $n=p+q$ with $p,q\ge2$. $\mathcal W_n$ is the space of Weyl tensors in dimension $n$: algebraic curvature tensors that are Ricci-flat and satisfy the first Bianchi identity. $D=\dim\mathcal W_n=\tfrac{n(n+1)(n+2)(n-3)}{12}$.
- The norm is $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$. A **critical point** is $W$ with $\lVert W\rVert=1$ and $Q(W)=\theta W$, and then $\theta=P(W)$.
- $L_x$ is the multiplication operator of the commutative nonassociative algebra on $\mathcal W_n$ whose cubic form is $P$. For $\theta\ne0$ set $e=W/\theta$, an idempotent.
- A Weyl operator is **coordinate-diagonal** when it is diagonal in the basis of coordinate $2$-planes of some orthonormal frame; its **sectional matrix** is $M_{ab}=R_{abab}$, hollow, and Ricci-flatness is that every row sums to zero. Sphere products are coordinate-diagonal.
- The **orbit dimension** of a critical point is $d=\dim(O(n)\cdot W)$, and the **excess** is $\dim E_{1/2}(L_e)-d$.

## Hypothesis inventory

| Hypothesis | Source | Checked against $S^2\times S^{n-2}$ | Used by the record's argument |
|---|---|---|---|
| $p,q\ge2$ | definition of the family | $p=2$ is the boundary value, admissible, and the case (G7) excludes by name | yes |
| $n-3>0$, so the unit $\tfrac1{2(n-3)}$ is positive and finite | the record's unit choice | holds for every $n\ge4$, the whole range of the family | yes, silently |
| $\theta\ne0$, so $e=W/\theta$ exists | definition of $e$ | $\theta^2=1-\tfrac1{(n-2)^2}>0$ for $n\ge4$, and I re-derive $\theta^2=\tfrac{(n-1)(n-3)}{(n-2)^2}$ from the norm independently in §4 | yes |
| $L_e$ is self-adjoint, so eigenspace dimensions add and no Jordan block hides multiplicity | the algebra's cubic form $P$ makes $\langle x\cdot y,z\rangle$ fully symmetric | holds, and it is what licenses reading multiplicities off a block decomposition | yes, silently |
| $L_e$ preserves $W^\perp$, so the eigenvalue $1$ on $e$ stays out of the tangent spectrum | $L_ee=e$ plus self-adjointness | holds, and the tabulated tangent dimensions $D-1$ confirm the record worked on $W^\perp$ | yes, silently |
| The four-set block is $2$-dimensional with trace $0$ | (G3), and the first Bianchi identity cutting the three pairings of a $4$-set to two | holds, $3-1=2$ | yes |
| The three quantities $A,B,C$ of (G3) are the pairing sums $M_{ij}+M_{kl}$, $M_{ik}+M_{jl}$, $M_{il}+M_{jk}$ | forced by (G3), see §3 | this reading reproduces (G3)'s $\mu$ at every $(p,q)$ and its vanishing off the $(2,2)$-splits, so it is the intended one | yes |
| (G4)'s restriction to $\sum_ix_i=0$ | (G4) | this is exactly Ricci-flatness $\sum_{i\notin\{j,k\}}R_{jiki}=0$, cutting each pair family from $n-2$ to $n-3$ | yes |
| (G4)'s "topped by $\tfrac{p-2}{2(p-1)}$" inside the $p$-factor | (G4) | **fails at $p=2$**, see §2 | yes, and the failure is harmless |
| The orbit tangent lies in $E_{1/2}$ | (G2) | holds, and it is what fixes the sign of the normalisation in §4 | yes |
| Orbit dimension is $2n-4$, the stabiliser being $SO(2)\times SO(n-2)$ | (G6) | $\binom n2-1-\binom{n-2}2=2n-4$, and this equals the number $2(n-2)$ of cross pairs, which §5 identifies as the $\tfrac12$-eigenspace | yes |
| Coordinate-diagonality of the critical point | given for sphere products | holds, and it is the hypothesis that makes $L_e$ commute with $(\mathbb Z_2)^n$ and so makes the block list closed | assumed, never stated |
| $n\ge5$, so every isotypic sector has nonnegative dimension | my derivation | at $n=4$ the sector dimensions degenerate and the case needs the separate treatment of §8 | not addressed by the record |
| (G7)'s multiplicity-free argument | (G7) | imports nothing here, since it excludes $p=2$ by name. I use it only as an external cross-check at $(3,3)$ in §3 | correctly not used |

## 1. The sectional matrix at $p=2$, and the completeness of the block list

Write the frame indices as $P=\{1,2\}$ and $Q=\{3,\dots,n\}$, and let $M$ be the sectional matrix with the cross value normalised to $1$. Hollowness plus the row-sum form of Ricci-flatness gives, in general and then at $p=2$,
$$M^{PP} = a = -\frac q{p-1},\qquad M^{QQ} = b = -\frac p{q-1},\qquad M^{PQ}=g=1,$$
so at $p=2$, $q=n-2$ we get $a=-(n-2)$ and $b=-\tfrac2{n-3}$, which is the brief's item 4 hint recovered independently.

**The block list is closed, and here is the proof the record was missing.** The group $\Gamma=(\mathbb Z_2)^n\subset O(n)$ of diagonal sign changes acts on $\mathcal W_n$, and a basis element $e_{ij}\odot e_{kl}$ of $\mathrm{Sym}^2(\Lambda^2)$ carries the character $\chi_{\{i,j\}\triangle\{k,l\}}$. A coordinate-diagonal tensor has $\{i,j\}=\{k,l\}$ in every term, so $e$ is $\Gamma$-fixed, and since $Q$ is $O(n)$-equivariant, $L_{\gamma\cdot e}=\gamma L_e\gamma^{-1}$ gives $[L_e,\gamma]=0$ for every $\gamma\in\Gamma$. Therefore **$L_e$ preserves every $\Gamma$-isotypic component of $\mathcal W_n$**, and those components are exactly:

| Symmetric difference $S$ | Component | Count | Dimension each |
|---|---|---|---|
| $\lvert S\rvert=0$ | the coordinate-diagonal sector, that is the sectional matrices | $1$ | $\binom n2-n=\tfrac{n(n-3)}2$ |
| $\lvert S\rvert=2$, $S=\{j,k\}$ | the pair block of (G4), spanned by $e_{ji}\odot e_{ki}$ | $\binom n2$ | $n-3$ |
| $\lvert S\rvert=4$, $S$ a $4$-set | the four-set block of (G3), the three pairings modulo Bianchi | $\binom n4$ | $2$ |

The three dimensions close exactly:
$$\frac{n(n-3)}2+\binom n2(n-3)+2\binom n4=\frac{n(n-3)}2\cdot\frac{6n+(n-1)(n-2)}6=\frac{n(n-3)(n+1)(n+2)}{12}=D,$$
verified for $n=4,\dots,59$. **So the enumeration of blocks is complete, and the answer to the record's standing caveat is yes.** What is incomplete is the record's list of *values*: it names the four-set blocks and the within-factor pair blocks, and it names neither the cross pairs nor the coordinate-diagonal sector. §5 and §6 compute both.

**The interlacing arithmetic itself (item 1).** In units of $\tfrac1{2(n-3)}$ at $p=2$:

| Quantity | Value | In units |
|---|---|---|
| four-set value $\mu=\tfrac{n-2}{2(p-1)(q-1)}$ | $\tfrac{n-2}{2(n-3)}$ | $n-2$ |
| within-$q$-factor pair top $\tfrac{q-2}{2(q-1)}$ | $\tfrac{n-4}{2(n-3)}$ | $n-4$ |
| the kernel value $\tfrac12$ | $\tfrac{n-3}{2(n-3)}$ | $n-3$ |

So $n-4<n-3<n-2$ holds strictly at every $n$, with both gaps equal to one unit. **The three never collide and never reorder**, because a collision would need $n-2=n-3$ or $n-4=n-3$. The family exists for $n\ge4$. The strict ordering already holds at $n=4$, where the triple reads $0<1<2$, and the argument in the form given is valid from $n=5$, because at $n=4$ the within-$q$ value $\tfrac{n-4}{2(n-3)}$ degenerates onto $0$ and the coordinate-diagonal sector collapses onto the eigenvalue $1$. §8 does $n=4$ separately and the conclusion survives there by its own computation.

## 2. The within-$p$-factor pair block at $p=2$ (item 2)

**It exists**, and it is a single block, for the single pair $\{1,2\}$. Taking (G4) with $\{j,k\}=\{1,2\}$, the index $i$ runs over all of $Q$, and since $M_{1i}+M_{2i}=2g=2$ for every $i\in Q$ and $M^{(12)}=b(J_{n-2}-I_{n-2})$, the bracket is
$$2I-aI+b(J-I)=(2-a-b)I+bJ,$$
and on $\sum_ix_i=0$ the all-ones matrix $J$ acts as zero. So the block of $L_M$ is the scalar $\tfrac{2-a-b}2$ on dimension $n-3$. With $2-a-b=\tfrac{(n-1)(n-2)}{(p-1)(q-1)}$ from §3 and the normalisation $c=-\tfrac1{n-1}$ of §4, the $L_e$ block is
$$-\mu\cdot\mathrm{Id}_{n-3},\qquad \mu=\frac{n-2}{2(n-3)}.$$

**Its contribution is $n-3$ to the multiplicity of $-\mu$, and nothing at $0$.** This refutes (G4)'s "topped by $\tfrac{p-2}{2(p-1)}$" at $p=2$, where that formula reads $0$ and the value $0$ is not in the block at all. The general within-factor pair block, derived in §6, has eigenvalues $-\mu$ with multiplicity $q-1$, then $0$ with multiplicity $p-3$, then $+\tfrac{p-2}{2(p-1)}$ once. At $p=2$ the last two merge to total multiplicity $p-3+1=0$ and the first takes over the whole block, which is the consistent limit and the reason (G4) holds verbatim for $p\ge3$ and fails at $p=2$. The failure is harmless for the conclusion, because $-\mu<0<\tfrac12$ and because $-\mu$ is already in the spectrum from the four-set blocks.

## 3. The four-set blocks, and the reading of (G3)

The three pairing quantities of (G3) are $A=M_{ij}+M_{kl}$, $B=M_{ik}+M_{jl}$, $C=M_{il}+M_{jk}$. That this is the intended reading is forced, since with it the quantity $A^2+B^2+C^2-AB-BC-CA=\tfrac12[(A-B)^2+(B-C)^2+(C-A)^2]$ reproduces both halves of (G3) at every $(p,q)$:

- A $4$-set with three or four indices in one factor has all three pairing sums equal, hence value $0$, which is (G3)'s "only the $(2,2)$-splits are nonzero".
- A $(2,2)$-split has $B=C=2g=2$ and $A=a+b$, so the value is $\lvert A-2\rvert=\lvert a+b-2\rvert$, and $q(q-1)+p(p-1)+2(p-1)(q-1)=(p+q)^2-3(p+q)+2$ gives
$$2-a-b=\frac{(n-1)(n-2)}{(p-1)(q-1)},\qquad \text{so the }L_M\text{ block is } \pm\frac{(n-1)(n-2)}{2(p-1)(q-1)}.$$

Matching to (G3)'s $\mu=\tfrac{n-2}{2(p-1)(q-1)}$ forces the normalisation factor $\lvert c\rvert=\tfrac1{n-1}$, **independently of $p$ and $q$**, which is the first of the three pins on §4.

**External cross-check at $(3,3)$.** The machinery of this review, applied at $p=q=3$, gives $\mu=\tfrac12$ with four-set multiplicity $\binom32\binom32=9$, and a cross-pair sector of size $pq=9$ also at $\tfrac12$, so $\dim E_{1/2}\ge18$ against orbit dimension $pq=9$, an excess of exactly $9$. That is (G7)'s independently known value at $(3,3)$, reproduced to the integer, which validates both the reading of (G3) above and the cross-pair identification of §5.

## 4. The normalisation, pinned three ways (item 6)

Let $e=cM$. Three independent determinations agree.

1. **From (G3)**, as in §3: $\lvert c\rvert=\tfrac1{n-1}$.
2. **From (G5) and the norm.** For a coordinate-diagonal tensor, $\lVert R\rVert^2=\sum_{a<b}M_{ab}^2$. At $p=2$, $\sum_{a<b}M_{ab}^2=(n-2)^2+\tfrac{2(n-2)}{n-3}+2(n-2)=\tfrac{(n-1)(n-2)^2}{n-3}$, so with $\lvert c\rvert=\tfrac1{n-1}$ and $\lVert e\rVert^2=\theta^{-2}$,
$$\theta^2=\frac{(n-1)(n-3)}{(n-2)^2}=1-\frac1{(n-2)^2},$$
which is (G5) exactly. Numerically $\theta=0.986013297,\,0.992156742,\,0.994987437$ at $n=8,10,12$, matching the tabulated $\theta$ to all nine digits.
3. **From (G2)**, which fixes the sign. §5 shows the cross-pair blocks carry the single eigenvalue $\tfrac{n-1}2\lvert c\rvert$ with the sign of $-c$, and (G2) demands $\tfrac12$ there, so $c<0$:
$$\boxed{\,e=-\frac M{n-1}\,},\qquad e^{PP}=\frac{n-2}{n-1},\quad e^{PQ}=-\frac1{n-1},\quad e^{QQ}=\frac2{(n-1)(n-3)}.$$

The sign is independently the geometric one. The Weyl sectional curvatures of the product metric are $W_{1u1u}=-\tfrac{2(n-3)}{(n-1)(n-2)}<0$ across the factors and $W_{1212}=\tfrac{2(n-3)}{n-1}>0$ inside the $S^2$, whose ratio is $-(n-2)$ as required.

**The conversion in (G1) is correct, and here is the independent confirmation.** (G1) gives $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ on $T_WS^{D-1}=W^\perp$, so $L_e=\mathrm{Hess}_SP/(6\theta)+\tfrac12$ there. It assumes $\theta\ne0$, it assumes the restriction to $W^\perp$ (which the tabulated tangent dimensions $D-1$ confirm), and it assumes $L_e$ preserves $W^\perp$ (which holds, $L_e$ being self-adjoint with $L_ee=e$). **A wrong scalar factor would be detected at three places at once**, and it is detected at none: the extracted spectrum puts $\tfrac12$ at multiplicity exactly $2n-4$, which (G2) plus (G6) predict and which no rescaling preserves; it puts the four-set value at exactly (G3)'s $\mu$; and it puts the within-$q$ pair top at exactly (G4)'s $\tfrac{q-2}{2(q-1)}$. An affine map $\lambda\mapsto\alpha\lambda+\beta$ cannot fix three independently pinned values unless $\alpha=1,\beta=0$. Beyond that, the closed-form derivation of §§2–6 reproduces every tabulated eigenvalue and every tabulated multiplicity from the algebra alone, with no Hessian in the chain.

**Confirmation of the idempotent, which also confirms the diagonal action used in §6.** On the coordinate-diagonal sector, $Q(M)_{ab}=M_{ab}^2+\sum_{c\ne a,b}M_{ac}M_{bc}$. With $e$ as boxed above, all three cases hold identically in $n$:
$$\Big(\tfrac{n-2}{n-1}\Big)^2+\tfrac{n-2}{(n-1)^2}=\tfrac{n-2}{n-1},\qquad \tfrac1{(n-1)^2}-\tfrac{n-2}{(n-1)^2}-\tfrac2{(n-1)^2}=-\tfrac1{n-1},\qquad \tfrac2{(n-1)(n-3)}\text{ likewise}.$$

## 5. The cross-pair block, computed (item 4)

This is the family the record's two closed forms do not cover, and it is the decisive one. Take the pair $\{j,k\}$ with $j\in P$ and $k\in Q$, so the remaining indices split into $P'$ of size $p-1$ and $Q'$ of size $q-1$. With $M_{jk}=1$, the diagonal entries $M_{ji}+M_{ki}$ are $a+1$ on $P'$ and $1+b$ on $Q'$, and subtracting $M_{jk}\mathrm{Id}$ and adding $M^{(jk)}$ gives the bracket in block form
$$\begin{pmatrix}aJ_{p-1}&\mathbf1\mathbf1^{\!\top}\\ \mathbf1\mathbf1^{\!\top}&bJ_{q-1}\end{pmatrix},$$
restricted to $\sum_ix_i=0$. Vectors supported on $P'$ with zero sum, and those supported on $Q'$ with zero sum, are annihilated, giving eigenvalue $0$ with multiplicity $(p-2)+(q-2)=n-4$. The remaining line has $x_{P'}=-(q-1)$ and $x_{Q'}=p-1$, and using $a(p-1)=-q$ both rows return the same eigenvalue $-(n-1)$, so the $L_M$ block value is $-\tfrac{n-1}2$ and the $L_e$ value is
$$-c\cdot\frac{n-1}2=\frac1{n-1}\cdot\frac{n-1}2=\frac12 .$$

**So $\tfrac12$ occurs there, once per cross pair, and nowhere else in the spectrum.** The number of cross pairs is $pq$, which at every $(p,q)$ equals $\binom n2-\binom p2-\binom q2=\dim SO(n)-\dim(SO(p)\times SO(q))$, the orbit dimension. At $p=2$ that is $2(n-2)=2n-4$. The cross-pair sector therefore **is** the orbit tangent, which is why (G2) predicted its eigenvalue and why the record's phrase "the orbit tangent's $\tfrac12$" is really a statement about a block it never wrote down.

## 6. The remaining blocks, and the full spectrum

**Within-$q$-factor pair blocks** ($\binom{n-2}2$ of them at $p=2$, dimension $n-3$ each). The same method with $\{j,k\}\subset Q$ gives the bracket with a $P$-block of diagonal $2-b$ and off-diagonal $a$, a $Q'$-block equal to $bJ_{q-2}$, and cross entries $1$. The eigenvalues of $L_e$ are
$$-\mu\ \ (\text{multiplicity }p-1),\qquad 0\ \ (\text{multiplicity }q-3),\qquad +\frac{q-2}{2(q-1)}\ \ (\text{once}),$$
the last from the line $x_P=-(q-2)$, $x_{Q'}=p$, where both rows return the $L_M$ value $\tfrac{2-b-n}2=-\tfrac{(q-2)(n-1)}{2(q-1)}$, which the factor $c=-\tfrac1{n-1}$ turns into $+\tfrac{q-2}{2(q-1)}$. Since $q\ge3$ makes this positive, **(G4)'s "topped by" is correct for the $q$-factor**, and at $p=2$ the top is $\tfrac{n-4}{2(n-3)}$ with multiplicity one per block.

**The coordinate-diagonal sector**, which the record never names, of dimension $\tfrac{n(n-3)}2$. Polarising $Q$ gives $(L_eX)_{ab}=e_{ab}X_{ab}+\tfrac12\sum_{c\ne a,b}(e_{ac}X_{bc}+e_{bc}X_{ac})$ on hollow $X$ with zero row sums. Decomposing under $S_2\times S_{n-2}$ with $A=e_{12}$, $G=e_{1u}$, $B=e_{uv}$:

| Piece | Dimension | $L_e$ eigenvalue |
|---|---|---|
| $x_{uv}$ hollow on $Q$ with zero row sums, the $(n-4,2)$ irrep | $\tfrac{(n-2)(n-5)}2$ | $0$, since the row sums kill every term |
| standard irrep, $S_2$-antisymmetric: $x_{1u}=-x_{2u}=\xi_u$, $\sum_u\xi_u=0$ | $n-3$ | $G-\tfrac{A+B}2=-\tfrac{n-2}{2(n-3)}=-\mu$ |
| standard irrep, $S_2$-symmetric: $x_{1u}=x_{2u}=-(n-4)\xi_u$, $x_{uv}=2(\xi_u+\xi_v)$ | $n-3$ | $\tfrac{A-B}2=\tfrac{n-4}{2(n-3)}$ |
| trivial irrep, which the row sums force to be $e$ itself | $1$ | $1$ |

The two standard-irrep eigenvalues were each confirmed on both of the block's two coordinate families, which is a nontrivial consistency check, and the dimensions close: $\tfrac{(n-2)(n-5)}2+2(n-3)+1=\tfrac{n(n-3)}2$.

**The complete spectrum of $L_e$ at $S^2\times S^{n-2}$, for every $n\ge5$**, with $\mu=\tfrac{n-2}{2(n-3)}$ and eigenvalues in units of $\tfrac1{2(n-3)}$ in the first column:

| Units | Eigenvalue | Multiplicity | Sources |
|---|---|---|---|
| $2(n-3)$ | $1$ | $1$ | $e$ itself, outside the tangent space |
| $n-2$ | $\mu$ | $\tfrac{(n-2)(n-3)}2=\binom{n-2}2$ | four-set $(2,2)$ blocks, positive branch |
| $n-3$ | $\tfrac12$ | $2n-4$ | cross-pair blocks, one each |
| $n-4$ | $\tfrac{n-4}{2(n-3)}$ | $\tfrac{n(n-3)}2$ | within-$q$ pair blocks ($\binom{n-2}2$) and the diagonal symmetric standard piece ($n-3$) |
| $0$ | $0$ | $D-2n^2+5n$ | four-set non-$(2,2)$ ($2\binom n4-(n-2)(n-3)$), within-$q$ pair blocks ($(n-5)\binom{n-2}2$), cross-pair blocks ($2(n-2)(n-4)$), diagonal $(n-4,2)$ piece ($\tfrac{(n-2)(n-5)}2$) |
| $-(n-2)$ | $-\mu$ | $n(n-3)$ | four-set negative branch ($\binom{n-2}2$), within-$p$ pair block ($n-3$), within-$q$ pair blocks ($\binom{n-2}2$), diagonal antisymmetric standard piece ($n-3$) |

## 7. The multiplicity bookkeeping (item 5), and the interlacing verdict (items 1, 3, 5)

The count $\binom{n-2}2$ of $(2,2)$-split $4$-subsets at $p=2$ is right, since both $P$-indices are forced and the two $Q$-indices are free. The orbit dimension $2n-4$ is right, since $\binom n2-1-\binom{n-2}2=\tfrac{4n-6}2-1=2n-4$. The large zero multiplicity has the four-source decomposition tabulated above. **The five tangent multiplicities sum to $D-1$ at each tabulated $n$, and each has the closed form in $n$ given above**, and the closed forms reproduce all fifteen tabulated integers exactly:

| $n$ | $\mu$ | $\tfrac12$ | $\tfrac{n-4}{2(n-3)}$ | $0$ | $-\mu$ | Sum | $D-1$ |
|---|---|---|---|---|---|---|---|
| $8$ | $15$ | $12$ | $20$ | $212$ | $40$ | $299$ | $299$ |
| $10$ | $28$ | $16$ | $35$ | $620$ | $70$ | $769$ | $769$ |
| $12$ | $45$ | $20$ | $54$ | $1410$ | $108$ | $1637$ | $1637$ |

The closed forms and the block sums were also checked to agree at $n=5,6,7,9,11,20,41$.

**The interlacing verdict.** The only eigenvalue equal to $\tfrac12$ is the cross-pair one, since $\mu=\tfrac12+\tfrac1{2(n-3)}>\tfrac12$ strictly, $\tfrac{n-4}{2(n-3)}=\tfrac12-\tfrac1{2(n-3)}<\tfrac12$ strictly, and $-\mu<0$ and $0$ and $1$ are plainly different. Hence
$$\dim E_{1/2}(L_e)=2n-4=d\qquad\text{and}\qquad \text{excess}=0\quad\text{at every }n\ge5,$$
with the $n=4$ boundary in §8. This is a theorem, not a pattern, and it discharges the record's completeness debt. What the record got right is the picture: two families straddle $\tfrac12$ at one unit on either side. What the record left out is that the picture decides nothing until the other two sectors are computed, and that one of them is where the $\tfrac12$ lives. The straddling of $\mu$ and $\tfrac{n-4}{2(n-3)}$ is a corollary of the full spectrum rather than an argument for it.

## 8. Odd $n$, the boundary, and the kernel (item 8)

**Odd $n$ changes nothing.** Every step above is uniform in $n$: the sectional matrix, the normalisation $-\tfrac1{n-1}$, the $(\mathbb Z_2)^n$ isotypic decomposition, and all five multiplicities are rational functions of $n$ with no parity condition. Nothing in the derivation uses even dimension, self-duality, or a complex structure. The closed forms were checked at $n=5,7,9,11,41$ and close on $D$ at each.

**The boundary $n=4$, which is $S^2\times S^2$, is degenerate and the conclusion survives.** There $q=2$, so $\tfrac{n-4}{2(n-3)}=0$, the $(n-4,2)$ diagonal piece has formal dimension $-1$, and the general formulas stop applying. Computing directly: $e$ has $e_{12}=e_{34}=\tfrac23$ and all four cross entries $-\tfrac13$, which is idempotent by the §4 identity; the diagonal sector is the two-dimensional space $x_{12}=x_{34}$, $x_{13}=x_{24}$, $x_{14}=x_{23}$ with the three values summing to zero, on which $L_e=\mathrm{Id}$; the single four-set block gives $\pm\mu=\pm1$; the two within-factor pair blocks and the four cross-pair blocks are one-dimensional each, contributing $-\mu$ twice and $\tfrac12$ four times. The spectrum is $1$ with multiplicity $3$, $\tfrac12$ with multiplicity $4$, and $-1$ with multiplicity $3$, summing to $D=10$. So $\dim E_{1/2}=4=2n-4=d$ and **the excess is $0$ at $n=4$ too**, by its own computation rather than by the interlacing.

**The family has no kernel.** As an operator on $\Lambda^2$, $e$ is diagonal with eigenvalues $\tfrac{n-2}{n-1}$, $-\tfrac1{n-1}$ and $\tfrac2{(n-1)(n-3)}$, all nonzero for every $n\ge4$. So $\ker W=0$ throughout, at even and odd $n$ alike, and no boundary case introduces one.

## 9. The saddle, and what would break the claim (items 7, 9)

**The saddle (item 7) is confirmed.** From (G1), $\mathrm{Hess}_SP$ has the eigenvalue $6\theta(\mu-\tfrac12)=\tfrac{3\theta}{n-3}>0$ with multiplicity $\binom{n-2}2\ge1$ on the four-set directions, so $S^2\times S^{n-2}$ is a strict saddle of $P$ on the unit sphere and is never a local maximum. The brief's route through $\mu>\theta/2$ reaches the same conclusion, the comparison in the $L_e$ normalisation being $\mu$ against $\tfrac12$ directly and in the $L_W=\theta L_e$ normalisation being $\theta\mu$ against $\tfrac\theta2$. **This supports the witness rather than undermining it.** The witness role is non-domination, which needs the critical orbit to be nondegenerate transverse to itself, that is $\dim\ker\mathrm{Hess}_SP=d$, and a nondegenerate critical orbit of a cubic form on a sphere is generically a saddle. Maximality is a different property and the record never claimed it.

**What would falsify the interlacing claim, and what I did to look for it.** Four objects would do it.

1. **A fifth $L_e$-invariant sector, outside the $\Gamma$-isotypic list.** Ruled out: the list is the complete isotypic decomposition of $\mathcal W_n$ under a group that fixes $e$, and the three dimensions sum to $D$ identically.
2. **An eigenvalue exactly $\tfrac12$ in a sector other than the cross pairs.** Searched by computing every sector in closed form. The candidate values are $1$, $\pm\mu$, $\tfrac{n-4}{2(n-3)}$ and $0$, and each differs from $\tfrac12$ by an explicit nonzero rational at every $n\ge4$.
3. **A coincidence $\mu=\tfrac12$ or $\tfrac{n-4}{2(n-3)}=\tfrac12$ at some $n$.** Ruled out, these require $n-2=n-3$ and $n-4=n-3$. The same computation locates the genuine coincidence elsewhere, at $p=q=3$, where $\mu=\tfrac12$ and the excess is $9$, reproducing (G7).
4. **A failure of the identification of the cross-pair sector with the orbit tangent.** This one is not needed. Even if the $2n-4$ dimensional $E_{1/2}$ were spanned differently, (G2) puts the $2n-4$ dimensional orbit tangent inside it, and equality of dimensions forces the two to coincide and the excess to vanish.

I also checked in the other direction, by confirming that my machinery reproduces an externally known number it was not fitted to, namely (G7)'s excess $9$ at $(3,3)$, and by confirming that the block sums equal $D$ at nine separate values of $n$.

## Verdict for the whole

**The record's conclusion is CONFIRMED and strengthened. The record's stated argument is REFUTED AS STATED in one imported value and incomplete in its enumeration.**

- The excess at $S^2\times S^{n-2}$ is $0$ at every $n\ge4$, unconditionally, with $\dim E_{1/2}(L_e)=2n-4$ derived in closed form. The screened dimensions $n=8,10,12$ are three instances of a theorem, and the witness is unconditional at all $n$ rather than at the dimensions that matter.
- The completeness caveat is discharged. The block list is closed by $(\mathbb Z_2)^n$ isotypy, with the exact dimension identity $\tfrac{n(n-3)}2+\binom n2(n-3)+2\binom n4=D$.
- Two sectors the record never names carry real weight. The **cross-pair blocks** are the entire $\tfrac12$-eigenspace, one dimension per pair, $pq$ in all, which is the orbit dimension at every $(p,q)$. The **coordinate-diagonal sector** contributes $n-3$ at $-\mu$, $n-3$ at $\tfrac{n-4}{2(n-3)}$, and $\tfrac{(n-2)(n-5)}2$ at $0$. Neither introduces a new eigenvalue, which is why the record's five-value spectrum is right, and neither can be omitted from the argument, which is why the record's reasoning is not.
- (G4) needs correcting at $p=2$. The within-$p$-factor pair block there is the scalar $-\mu\,\mathrm{Id}_{n-3}$, so its top is $-\tfrac{n-2}{2(n-3)}$ and the stated value $\tfrac{p-2}{2(p-1)}=0$ is absent from it. (G4) stands as written for $p\ge3$.
- The interlacing is exact and is the right picture, with $\mu$ and $\tfrac{n-4}{2(n-3)}$ one unit of $\tfrac1{2(n-3)}$ above and below $\tfrac12$ at every $n$. It is a corollary of the full spectrum rather than a proof of it.
