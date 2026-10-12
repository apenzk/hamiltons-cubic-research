# VERIFY v124, Observation L15: the identity $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$, its constant $6$, its missing quantifier, and the "two obstructions" label

**Verifier v124, round L15, cold brief.** Sources read: [problem.md](../findings/problem.md):190–204, [results.md](../results.md):218 and :643–650, [conventions.md](../findings/conventions.md), [isotropy-cap.md](../findings/isotropy-cap.md) (L79, L131), [bounds.md](../findings/bounds.md) (L7, L154, L155), [ATTEMPTS.md](../ATTEMPTS.md) Result 4, [LEDGER.md](../findings/LEDGER.md), [lean/INDEX.md](../lean/INDEX.md), [REVIEW_r469.md](../reviews/REVIEW_r469.md), [REVIEW_r470.md](../reviews/REVIEW_r470.md), and the reference notes for [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md). **No numerical work was done. Every value below is an exact hand evaluation**, including the structure-constant computation of $\star^\#$ at $n=4$ and the four exact quantities at Fox's $\mathcal S^4(\alpha)$. Log: [agent_logs/verify-L15-v124.log](../agent_logs/verify-L15-v124.log).

## Claim table

| # | claim, as a consumer would read it | verdict |
| --- | --- | --- |
| C1 | $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ | **CORRECT** |
| C2 | the constant is exactly $6$ in every dimension | **CORRECT**, at every $n\ge1$ |
| C3 | there is no cross-term | **CORRECT**, and it is a consequence rather than a separate fact |
| C4 | the class of $R$ the identity is asserted for | **MISSING FROM BOTH CANONICAL COPIES**, neither [problem.md](../findings/problem.md):203 nor [results.md](../results.md):647 quantifies $R$, and [Lemma L7](../findings/bounds.md)'s proof needs the quantifier that is absent |
| C5 | the normalisations the constant depends on | **FOUR, TWO UNTABLED**, $\#$ and $\mathrm{Ric}$ (with its norm) are absent from [conventions.md](../findings/conventions.md) |
| C6 | the master inequality carries an extra $+24\lVert\mathrm{Alt}(W_-)\rVert^2$ | **CORRECT** |
| C7 | at Fox's $\mathcal S^4(\alpha)$ the inequality fails by a factor of three, the corrected version saturated | **CORRECT, AND STRONGER THAN RECORDED**, exact by hand at every $n\ge4$, where the record has it screened at $n=6,8$ |
| C8 | every sphere product, in any frame, has defect zero | **CORRECT**; "in any frame" is vacuous, the quantity being $O(n)$-invariant |
| C9 | "$\lvert W\rvert$ and $W_\pm$ **do not** satisfy the first Bianchi identity" ([results.md](../results.md):645) | **OVER-STATED, AND THE CORRECTION LANDED ONLY NEXT DOOR**, [problem.md](../findings/problem.md):202 reads "need not"; the canonical copy was not repaired |
| C10 | "every step … survives … with one exception" ([results.md](../results.md):645) | **REFUTED ON THE RECORD AND STILL STANDING IN THE CANONICAL COPY** |
| C11 | the heading's second obstruction, $X_{\mathrm{inv}}\succeq0$ | **ESTABLISHED ELSEWHERE, NOT HERE**, and its off-locus refutation rests on one numerical instance |
| C12 | the displayed content is this result's own | **NO**, it is [Lemma L131](../findings/isotropy-cap.md) polarised, and the two are *equivalent*, not merely related |

**Verdict: `PROVEN, hypotheses corrected`.** The identity, its constant, the absence of a cross-term, the $+24\delta^2$, the factor of three and the sphere-product clause all check by hand at every dimension. What must be corrected is the statement's *hypothesis line*: both canonical copies display the identity with no quantifier over $R$ and no naming of the four normalisations that fix the constant, and the [results.md](../results.md) copy additionally omits the definition of $\mathrm{Alt}$, without which "$6$" is not a number.

## 0. Conventions, fixed once

Every constant below is read in these, and each is quoted from where the record fixes it.

| object | the reading used here | where the record fixes it |
| --- | --- | --- |
| $\Lambda^2$ pairing | $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}\}_{a<b}$ with $\varphi_{ab}=E_{ab}-E_{ba}$ is orthonormal | [conventions.md](../findings/conventions.md), "Norms and pairings" |
| $S^2(\Lambda^2)$ pairing | plain Frobenius on the pair matrix, $\langle X,Y\rangle=\sum_{i<j,k<l}X_{ijkl}Y_{ijkl}=\tfrac14\sum_{ijkl}X_{ijkl}Y_{ijkl}$ | same bullet, "plain Frobenius on the pair matrix" |
| $\operatorname{scal}$ | $\operatorname{scal}=2\operatorname{tr}$ on $\Lambda^2$ | [conventions.md](../findings/conventions.md), tabled after [Lemma L7](../findings/bounds.md)'s round |
| $\mathrm{Alt}$ | the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, carrying its $\tfrac13$: $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$; at $n=4$ it is the projection onto $\mathbb R\star$ with $\lVert\star\rVert^2=6$ | [conventions.md](../findings/conventions.md), "Structure constants, brackets and padding" |
| $\#$ | Böhm–Wilking's, normalised by $I\,\#\,I=(n-2)I$; in structure constants $(R\#S)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}R_{\gamma\epsilon}S_{\delta\zeta}$ with $c_{\alpha\beta\gamma}=\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$ | **absent from [conventions.md](../findings/conventions.md)**; pinned by [the Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) and by [Lemma L153](../findings/bounds.md)'s marginal |
| $\mathrm{Ric}$ | $\mathrm{Ric}(R)_{ik}=\sum_jR_{ijkj}$, with $\lVert\mathrm{Ric}\rVert^2=\sum_{ik}\mathrm{Ric}_{ik}^2$ the full $n\times n$ Frobenius norm | **absent from [conventions.md](../findings/conventions.md)**; used in this reading by [r469](../reviews/REVIEW_r469.md) and by [Lemma L131](../findings/isotropy-cap.md)'s $\mathrm{Ric}^*=2(\,\cdot\,\wedge\mathrm{id})$ |
| $A\wedge\mathrm{id}$ | $(A\wedge\mathrm{id})_{ijkl}=\tfrac12(A_{ik}\delta_{jl}-A_{il}\delta_{jk}-A_{jk}\delta_{il}+A_{jl}\delta_{ik})$, the normalisation with $\mathrm{id}\wedge\mathrm{id}=I$ | forced by [Böhm–Wilking Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md) at $R=I$ |
| $W_-$ | $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$, so $\lvert W\rvert=W+2W_-$ | [conventions.md](../findings/conventions.md) |
| $\delta^2$ | $\lVert\mathrm{Alt}(W_-)\rVert^2$ | [Conjecture L16](../results.md), [Lemma L7](../findings/bounds.md) |

**The last two rows of the "where" column are the finding of C5.** [conventions.md](../findings/conventions.md) opens with the standing rule that a block needing a convention adds it there and quotes it; the constant $6$ depends on $\#$'s normalisation and on $\mathrm{Ric}$'s norm, and both are readable only from a reference note and from a lemma in another findings file. Section 2 shows how far the constant moves under each alternative.

## Hypothesis inventory

**What the claim carries.**

| hypothesis | is it needed | is it stated |
| --- | --- | --- |
| $R$ symmetric on $\Lambda^2\mathbb R^n$, i.e. $R\in S^2(\Lambda^2\mathbb R^n)$ | **yes**, $\operatorname{tr}(R^2)=\lVert R\rVert^2$ uses it, and $\mathrm{Alt}$, $\mathrm{Ric}$ are defined on $S^2(\Lambda^2)$ | **no**, in either canonical copy; [ATTEMPTS.md](../ATTEMPTS.md) Result 4 states it in full as "for every symmetric $R$ on $\Lambda^2\mathbb R^n$" |
| $R\in\mathcal W_n$ | **no**, and assuming it makes the identity vacuous: $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$ send both sides to $0$ | not stated, and the surrounding prose is about $\lvert W\rvert$ and $W_\pm$, which are outside $\mathcal W_n$, so the intended class is the wide one |
| $R$ satisfies the first Bianchi identity | **no**, this is exactly what the second term prices | not stated |
| $R$ a curvature operator, positivity, unit norm, criticality | **no**, none | not claimed |
| $n\ge4$ | **no**, the identity holds at $n=1,2,3$ too, where $\Lambda^4=0$ and $\mathrm{Alt}\equiv0$ | the claim says "in every dimension", which is literally right |

**What the imports carry, checked against the object each applies to.**

| import | its hypothesis | met here |
| --- | --- | --- |
| [Böhm–Wilking Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md), $R+R\#I=\mathrm{Ric}\wedge\mathrm{id}$ | $R\in S^2_B(\mathfrak{so}(n))$, the Bianchi subspace | met by $R_B=R-\mathrm{Alt}(R)$, which lies in $\ker\mathrm{Alt}=S^2_B$ |
| $\#I=+2$ on $\Lambda^4$ ($c_4=2$) | $O(n)$-equivariance of $\,\cdot\,\#I$ and irreducibility of $\Lambda^4$ | met; §3 gives an independent hand proof at every $n\ge4$ from the $n=4$ case by padding |
| $\mathrm{Ric}$ annihilates $\Lambda^4$ | total antisymmetry | met: $\sum_jA_{ijkj}=0$ for $A$ totally antisymmetric |
| full symmetry of $\langle R\#S,T\rangle$ | total antisymmetry of $c_{\alpha\beta\gamma}$, which is [conventions.md](../findings/conventions.md)'s tabled fact | met; §1 derives the symmetry |
| $\mathrm{Ric}^*=2(\,\cdot\,\wedge\mathrm{id})$ is $\mathrm{Ric}$'s adjoint | the two pairings of §0 | met; §1 derives it in four lines |
| $\mathrm{Alt}$ self-adjoint and idempotent | it is an orthogonal projection | met, [conventions.md](../findings/conventions.md) |

**What the written argument uses.** [problem.md](../findings/problem.md)'s block writes no derivation at all. Its blockquote points at [Lemma L131](../findings/isotropy-cap.md) for "*this identity polarised*", and L131's block carries the corrected Böhm–Wilking identity with a two-clause sketch of its proof. So the argument on file is the chain L131 $\to$ pair with $R$ $\to$ double, and it is written out only in [r470](../reviews/REVIEW_r470.md) Finding 1. §1 checks that chain step by step and finds it sound.

## 1. The derivation in full, pre-registered question 1, first half

**Step 1: the $\#$-trilinear form is fully symmetric.** With $c_{\alpha\beta\gamma}=\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$ totally antisymmetric,
$$\langle R\#S,T\rangle=\tfrac12\sum_{a_1a_2a_3,\,b_1b_2b_3}c_{a_1a_2a_3}c_{b_1b_2b_3}\,T_{a_1b_1}R_{a_2b_2}S_{a_3b_3}.$$
The three arguments sit in the three slots of the two $c$'s, one slot each. Permuting the slots of both $c$'s at once multiplies the expression by $\operatorname{sgn}^2=+1$, so the form is invariant under every permutation of $(T,R,S)$. Hence $\operatorname{tr}(R^\#)=\langle R\#R,I\rangle=\langle R\#I,R\rangle$, which is the step the whole derivation turns on.

**Step 2: the $\#$ normalisation is the one that makes $I\#I=(n-2)I$.** With the unhalved sum, $(I^\#)_{\alpha\alpha}=\sum_{\gamma\delta}c_{\alpha\gamma\delta}^2=2(n-2)$ by [Lemma L153](../findings/bounds.md)'s row marginal over ordered pairs. The factor $\tfrac12$ in §0 returns $I\#I=(n-2)I$, which is [the Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md)' value. §2 shows this normalisation is load-bearing for the *shape* of the identity, not only for its constant.

**Step 3: $\mathrm{Ric}^*=2(\,\cdot\,\wedge\mathrm{id})$, hence $\langle\mathrm{Ric}(R)\wedge\mathrm{id},R\rangle=\tfrac12\lVert\mathrm{Ric}(R)\rVert^2$.** For symmetric $A$,
$$\langle A\wedge\mathrm{id},R\rangle=\tfrac14\sum_{ijkl}\tfrac12\big(A_{ik}\delta_{jl}-A_{il}\delta_{jk}-A_{jk}\delta_{il}+A_{jl}\delta_{ik}\big)R_{ijkl},$$
and each of the four terms equals $\langle A,\mathrm{Ric}(R)\rangle$, the first is $\sum_{ijk}A_{ik}R_{ijkj}$ outright, the second is $-\sum_{ijl}A_{il}R_{ijjl}=+\sum_{il}A_{il}\mathrm{Ric}_{il}$ by $R_{ijjl}=-R_{ijlj}$, and the remaining two by the pair symmetry. So $\langle A\wedge\mathrm{id},R\rangle=\tfrac18\cdot4\langle A,\mathrm{Ric}(R)\rangle=\tfrac12\langle A,\mathrm{Ric}(R)\rangle$, and setting $A=\mathrm{Ric}(R)$ gives the display.

**Step 4: the corrected Böhm–Wilking identity off the Bianchi locus**, this is [Lemma L131](../findings/isotropy-cap.md)'s, and its sketch checks. Write $R=R_B+A$ with $A=\mathrm{Alt}(R)\in\Lambda^4$ and $R_B\in S^2_B$. Then $\mathrm{Ric}(R)=\mathrm{Ric}(R_B)$, Böhm–Wilking gives $\mathrm{Ric}(R_B)\wedge\mathrm{id}=R_B+R_B\#I$, and $R_B\#I=R\#I-A\#I=R\#I-2A$ by $c_4=2$. Substituting $R_B=R-A$,
$$\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\,\#\,I-3\,\mathrm{Alt}(R)\qquad\text{for every symmetric }R.$$

**Step 5: pair with $R$ and double.** $\langle\mathrm{Alt}(R),R\rangle=\lVert\mathrm{Alt}(R)\rVert^2$ by idempotent self-adjointness, so Steps 1 and 3 turn Step 4 into
$$\tfrac12\lVert\mathrm{Ric}(R)\rVert^2=\lVert R\rVert^2+\operatorname{tr}(R^\#)-3\lVert\mathrm{Alt}(R)\rVert^2 .$$
With $\operatorname{tr}(R^2)=\lVert R\rVert^2$ this is $\operatorname{tr}(R^2+R^\#)=\tfrac12\lVert\mathrm{Ric}(R)\rVert^2+3\lVert\mathrm{Alt}(R)\rVert^2$, and $\operatorname{scal}=2\operatorname{tr}$ gives the display. **The $\lVert R\rVert^2$ cancels exactly**, which is the whole reason the identity has two terms rather than three.

**The constant is $6=2(1+c_4)$ and $c_4=2$ carries no $n$**, so "exactly $6$ in every dimension" holds. §3 checks it at three named objects and §4 proves $c_4=2$ at every $n$ by hand.

**No cross-term, pre-registered question 1, second half.** The claim is that the quadratic form $F(R)=\operatorname{scal}(R^2+R^\#)$ is additive across $S^2(\Lambda^2)=S^2_B\oplus\Lambda^4$. It is, and directly:
$$\tfrac12\big(F(R_B+A)-F(R_B)-F(A)\big)=2\operatorname{tr}(R_BA)+2\operatorname{tr}(R_B\#A)=2\langle R_B,A\rangle+2\langle R_B\#I,A\rangle .$$
The first is $0$ by orthogonality of the two summands. For the second, Step 4 gives $R_B\#I=\tfrac12\mathrm{Ric}^*(\mathrm{Ric}\,R_B)-R_B$, and $\langle\mathrm{Ric}^*(h),A\rangle=2\langle h,\mathrm{Ric}(A)\rangle=0$ since $\mathrm{Ric}$ annihilates $\Lambda^4$; the remaining $-\langle R_B,A\rangle$ vanishes too. So the cross term is $0$. [r469](../reviews/REVIEW_r469.md) and [ATTEMPTS.md](../ATTEMPTS.md) reach the same conclusion by Schur, $\Lambda^4$ occurs once in $S^2(\Lambda^2)$ and not at all in $S^2_B$, so an $O(n)$-invariant quadratic form cannot couple them. **Both arguments are correct and the second is the shorter**; the identity's own two-term shape is what the absence of a cross-term *is*, so this is a consequence rather than an independent claim.

## 2. Which normalisations the constant depends on, and what it becomes under the alternatives

Four conventions enter, and they enter differently.

| convention | the record's reading | the alternative the record also uses | what the display becomes |
| --- | --- | --- | --- |
| $\operatorname{scal}$ | $2\operatorname{tr}$ on $\Lambda^2$ | plain $\operatorname{tr}$ | $\operatorname{tr}(R^2+R^\#)=\tfrac12\lVert\mathrm{Ric}\rVert^2+3\lVert\mathrm{Alt}\rVert^2$, **both coefficients halve, their ratio $6{:}1$ is untouched** |
| $S^2(\Lambda^2)$ pairing | plain Frobenius on the pair matrix | the tensor sum $\sum_{ijkl}$, four times larger | $6\mapsto\tfrac32$: $\lVert\mathrm{Alt}(R)\rVert^2$ scales while $\operatorname{tr}$, $R^\#$ and $\lVert\mathrm{Ric}\rVert^2$ do not |
| $\mathrm{Alt}$ | the projection, carrying $\tfrac13$ | the unnormalised Bianchi map $b=3\,\mathrm{Alt}$ | $6\mapsto\tfrac23$, since $\lVert b(R)\rVert^2=9\lVert\mathrm{Alt}(R)\rVert^2$, the trap [r411](../reviews/REVIEW_r411.md) books one file over, there costing a factor of three in [Lemma L131](../findings/isotropy-cap.md)'s $3$ |
| $\#$ | $I\#I=(n-2)I$ | the unhalved structure-constant sum, $I\#I=2(n-2)I$ | **the two-term shape is lost**: $\operatorname{scal}(R^2+R^\#_{\rm unf})=2\lVert\mathrm{Ric}\rVert^2+12\lVert\mathrm{Alt}\rVert^2-2\lVert R\rVert^2$, since the cancellation of Step 5 no longer happens |

**The last row is the sharpest reading of the question.** The $\#$ normalisation is not a scale on the constant; it is what makes the identity have the form it has. Under the unhalved $\#$ the display is false as written at every $R$ with $\lVert R\rVert\ne0$, at $R=I$, for instance, the left side reads $2\binom n2(1+2(n-2))=n(n-1)(2n-3)$ against a right side of $n(n-1)^2$, and the two agree only at $n=2$. So a consumer who reads $\#$ from the structure constants without the $\tfrac12$ gets a false statement rather than a rescaled one.

**The $\lVert\mathrm{Ric}\rVert$ normalisation matters too, and is the one nothing on the record pins.** The coefficient $1$ on $\lVert\mathrm{Ric}(R)\rVert^2$ is the full $n\times n$ Frobenius norm $\sum_{ik}\mathrm{Ric}_{ik}^2$. Reading it as a half-trace, in symmetry with the $\Lambda^2$ pairing the same file fixes, would put $\tfrac12$ there and leave $6$ where it is, so the *ratio* the display asserts would change. **Nothing in [conventions.md](../findings/conventions.md) forecloses that reading**; the anchor $R=I$ in §3 does, and that is the only thing on the record that does.

## 3. The identity at three named objects, by hand

### 3.1 The Kulkarni–Nomizu identity operator $R=I$, this fixes the Ricci coefficient

$I_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$, the round-sphere operator. $\mathrm{Ric}(I)_{ik}=\sum_j(\delta_{ik}\delta_{jj}-\delta_{ij}\delta_{jk})=(n-1)\delta_{ik}$, so $\lVert\mathrm{Ric}(I)\rVert^2=n(n-1)^2$. $I$ satisfies the first Bianchi identity, so $\mathrm{Alt}(I)=0$. On the left, $I^2=I$ and $I^\#=(n-2)I$, so $\operatorname{scal}(Q(I))=2(n-1)\binom n2=n(n-1)^2$. **Equal at every $n$, and the Ricci coefficient is pinned at $1$**, under any other normalisation of $\lVert\mathrm{Ric}\rVert$ this anchor fails.

### 3.2 $R=\star$ at $n=4$, this fixes the $\mathrm{Alt}$ coefficient at exactly $6$

$\star_{ijkl}=\epsilon_{ijkl}$, so $\mathrm{Ric}(\star)_{ik}=\sum_j\epsilon_{ijkj}=0$ and $\mathrm{Alt}(\star)=\star$ with $\lVert\star\rVert^2=\operatorname{tr}(\star^{\mathsf T}\star)=6$. The right side is $0+6\cdot6=36$.

The left side needs $\operatorname{tr}(\star^\#)$, and I computed it from the structure constants rather than from any recorded value. In the basis $\varphi_{12},\varphi_{13},\varphi_{14},\varphi_{23},\varphi_{24},\varphi_{34}$ the star acts by $\varphi_{12}\leftrightarrow\varphi_{34}$, $\varphi_{13}\leftrightarrow-\varphi_{24}$, $\varphi_{14}\leftrightarrow\varphi_{23}$. The pairs with $c_{(12)\gamma\delta}\ne0$ are $(13,23)$, $(23,13)$, $(14,24)$, $(24,14)$ with signs $-,+,-,+$, and $\star$ maps each of $13,23,14,24$ to the one the second factor needs, so all four contributions to $(\star^\#)_{(12)(12)}$ come out $+1$ and the halved $\#$ gives $(\star^\#)_{(12)(12)}=2$. The six coordinate bivectors lie in one $SO(4)$ orbit and $\star^\#$ is $O(4)$-invariant (it is quadratic in $\star$, so the orientation sign cancels), so every diagonal entry is $2$ and $\operatorname{tr}(\star^\#)=12$. Hence
$$\operatorname{scal}(\star^2+\star^\#)=2\big(\operatorname{tr}(I_6)+12\big)=2(6+12)=36 .$$
**Equal, and $6$ is the only constant that closes it.** This computation also confirms [r469](../reviews/REVIEW_r469.md)'s $\star^\#=2\,\mathrm{Id}$ independently, an entrywise $2$ on the diagonal, matching $\Pi_\pm^\#=2\Pi_\pm$ with $\Pi_+\#\Pi_-=0$, and consistent with $I^\#=2I$ at $n=4$ under $I=\Pi_++\Pi_-$.

### 3.3 Sphere products $S^p\times S^q$, and the whole coordinate-diagonal family at once

The sphere-product operator is coordinate-diagonal, so I checked the identity on that entire family in one derivation rather than at one point. Let $R$ be diagonal in the pair basis with entries $r_{ab}$. Then:

- $\mathrm{Alt}(R)=0$, since $\mathrm{Alt}(R)_{ijkl}$ is supported on four distinct indices and a coordinate-diagonal $R$ has $R_{ijkl}=0$ unless $\{i,j\}=\{k,l\}$.
- $\operatorname{tr}(R^2)=\sum_{a<b}r_{ab}^2$, and $\operatorname{tr}(R^\#)=\sum_{a<b<c}(r_{ab}r_{bc}+r_{bc}r_{ca}+r_{ca}r_{ab})$, because $T_{\alpha\gamma\delta}=c_{\alpha\gamma\delta}^2$ is supported on index triangles with value $1$ and each unordered triple contributes its six orderings.
- $\mathrm{Ric}(R)_{aa}=\sum_{b\ne a}r_{ab}$ with the off-diagonal entries vanishing, so $\lVert\mathrm{Ric}(R)\rVert^2=\sum_a\sum_{b,c\ne a}r_{ab}r_{ac}=2\sum_{a<b}r_{ab}^2+2\sum_{a<b<c}(r_{ab}r_{bc}+r_{bc}r_{ca}+r_{ca}r_{ab})$.

The last line is exactly $2\operatorname{tr}(R^2)+2\operatorname{tr}(R^\#)=\operatorname{scal}(R^2+R^\#)$. **So the identity holds on the entire coordinate-diagonal locus at every $n$, with $\mathrm{Alt}=0$ throughout.** Specialising to $S^p\times S^q$ ($r_{ab}=1$ inside each block, $0$ across), gives $\operatorname{tr}(R^2+R^\#)=\binom p2(p-1)+\binom q2(q-1)$ against $\lVert\mathrm{Ric}\rVert^2=p(p-1)^2+q(q-1)^2$, equal after doubling, at every split including the balanced one. The same computation at $n=3$ covers **every** symmetric $R$, since $\Lambda^2\mathbb R^3\cong\mathbb R^3$ carries the $O(3)$ action and every symmetric operator there is coordinate-diagonal in some frame.

## 4. Quantifier order, scope, and the edges of the range

**The quantifier order the statement needs is $\forall n\,\forall R$**, with $R$ ranging over all of $S^2(\Lambda^2\mathbb R^n)$ and the constant $6$ chosen before $n$. That is what makes "exactly $6$ in every dimension" a claim rather than a definition, and it is what §1 establishes.

**Neither canonical copy writes the inner quantifier.** [problem.md](../findings/problem.md):203 and [results.md](../results.md):647 display the identity with a bare $R$, in a paragraph whose subject is $\lvert W\rvert$ and $W_\pm$. [ATTEMPTS.md](../ATTEMPTS.md) Result 4 carries the full form, "for every symmetric $R$ on $\Lambda^2\mathbb R^n$", and [r470](../reviews/REVIEW_r470.md) records the hypothesis as "none beyond $R$ symmetric". §6 shows this omission is load-bearing rather than cosmetic.

**$n=4$, where $\Lambda^4$ is one-dimensional.** §3.2 checks the identity there at the one object that carries the second term. Two collisions live at this dimension and neither bites: $\mathbb R\cdot\mathrm{Id}$ and $\Lambda^4$ are isomorphic as $SO(4)$ representations, so $SO(4)$-Schur alone would license mixing, but $\,\cdot\,\#I$ is $O(4)$-equivariant and $\Lambda^4\mathbb R^4$ is the determinant representation, which $\mathbb R\cdot\mathrm{Id}$ is not. That is [Lemma L79](../findings/isotropy-cap.md)'s own $O(m)$-versus-$SO(m)$ correction, and it is exactly what the $n=4$ anchor needs.

**$n<4$.** $\Lambda^4\mathbb R^n=0$, so $\mathrm{Alt}\equiv0$ and the display reduces to $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2$ for every symmetric $R$. At $n=3$ this is §3.3's diagonal computation, which is exhaustive there. At $n=2$ the bracket vanishes so $\#=0$, and with $R_{1212}=r$ both sides read $2r^2$. At $n=1$ both sides are $0$. **So "every dimension" is true down to $n=1$**, and the claim overstates nothing at the bottom edge.

**$c_4=2$ at every $n\ge4$, by hand.** The record takes this from [Lemma L79](../findings/isotropy-cap.md)'s table, whose proof is stated as a Casimir evaluation and is not displayed. I checked it independently and it holds. Let $A=e_1\wedge e_2\wedge e_3\wedge e_4\in\Lambda^4\mathbb R^n$, so $A$ is §3.2's $\star$ padded. Then $(A\#I)_{\alpha\beta}=\tfrac12\sum_{\gamma\epsilon\delta}c_{\alpha\gamma\delta}c_{\beta\epsilon\delta}A_{\gamma\epsilon}$, and $A_{\gamma\epsilon}\ne0$ forces $\gamma,\epsilon$ to be complementary bivectors inside $\{1,2,3,4\}$.

- If $\alpha$ has both indices outside the block, no triangle $(\alpha,\gamma,\delta)$ has $\gamma$ inside it, and the entry is $0$.
- If $\alpha=(ap)$ with $p$ outside, the triangle forces $\gamma=(ab)$ and $\delta=(bp)$; then $c_{\beta\epsilon\delta}\ne0$ with $\epsilon$ inside forces $\beta=(cp)$ and $\epsilon=(cb)$, and $A_{(ab)(cb)}=0$ because the two bivectors share the index $b$. So the entry is $0$.
- If both $\alpha$ and $\beta$ lie inside the block, the same two bullets show no index outside the block can appear in $\gamma,\epsilon,\delta$ at all, so the sum is literally the $n=4$ sum.

Hence $A\#I$ is the $n=4$ answer on the block and zero elsewhere. At $n=4$, §3.2 gives $\langle\star\#I,\star\rangle=\langle\star\#\star,I\rangle=\operatorname{tr}(\star^\#)=12=2\lVert\star\rVert^2$, and $\Lambda^4\mathbb R^4$ is one-dimensional, so $\star\#I=2\star$. Therefore $A\#I=2A$ on every decomposable $A$, and decomposables span $\Lambda^4\mathbb R^n$. **So $c_4=2$ at every $n\ge4$, with no $n$-dependence and no Casimir table needed**, which is where "$6$ in every dimension" comes from.

## 5. Comparing the forms across the record, pre-registered question 2

| where | what it displays | what it adds |
| --- | --- | --- |
| [problem.md](../findings/problem.md):203–204 | the identity, plus "$\mathrm{Alt}$ being the projection onto $\Lambda^4$", "exactly $6$ in every dimension", "no cross-term", the $+24\delta^2$, the Fox clause, the sphere-product clause | the fullest copy; the quantifier over $R$ is still absent |
| [results.md](../results.md):218 | the label, the second obstruction, "$\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$", and "the identity below is confirmed and is [Lemma L131](../findings/isotropy-cap.md) polarised" | the corrections, and the pointer to L131 |
| [results.md](../results.md):645–647 | the prose and the bare display, then "Proof: [problem.md](../findings/problem.md)" | **less than any other copy**: no definition of $\mathrm{Alt}$, no constant clause, no quantifier, and the refuted "do not satisfy" and "one exception" wording |
| [isotropy-cap.md](../findings/isotropy-cap.md) [Lemma L131](../findings/isotropy-cap.md) | $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$, and the equivalent $\mathcal A(R)=2R-\mathrm{Ric}^*(\mathrm{Ric}\,R)-6\,\mathrm{Alt}(R)$ | the operator form, its two-clause proof, and the statement that this is L15 polarised |
| [ATTEMPTS.md](../ATTEMPTS.md) Result 4 | the identity **with its quantifier**, the Schur reason for no cross-term, the corrected master inequality, and the $\mathcal S^4(\alpha)$ arithmetic | the only copy that states the class of $R$ |
| [lean/INDEX.md](../lean/INDEX.md), row [L15](../lean/HamiltonsCubic/Results/L15.lean) | **partial**, that polarisation carries no content, and that "exactly one exception" is wrong twice over | it explicitly records "**Owed**: the identity itself and its identification with [L131](../lean/HamiltonsCubic/Results/L131.lean)" |

**The three forms are one statement, and the equivalence runs both ways.** Forward: §1 Step 5 derives the display from L131. Backward: the map $\Psi(R)=R+R\#I-3\,\mathrm{Alt}(R)-\tfrac12\mathrm{Ric}^*(\mathrm{Ric}\,R)$ is linear and **self-adjoint**, $\,\cdot\,\#I$ by the full symmetry of §1 Step 1, $\mathrm{Alt}$ as an orthogonal projection, and $\mathrm{Ric}^*\mathrm{Ric}$ as a composition with its own adjoint, so $\langle\Psi(R),R\rangle=0$ for every $R$ forces $\Psi=0$. **L15's display and L131's identity determine each other**, which is what the Lean row's remark that "polarisation carries no content" says in the general form.

**So what does a consumer get from L15 that L131 does not give?** Only a change of level: the scalar contraction, ready to be traced, together with the two clauses that fix its reading ($\mathrm{Alt}$ carries the $\tfrac13$; the constant carries no $n$). What L131 gives that L15 does not is the operator statement, from which the scalar one follows in two lines but which does not follow from the scalar one without the self-adjointness argument just given, an argument written down in neither block. **The honest description is one result stated twice**, which is what [results.md](../results.md):218 and [LEDGER.md](../findings/LEDGER.md) already say.

**No Lean form of the identity exists.** The [L15 row](../lean/INDEX.md) formalises the polarisation triviality and records the identity as owed. **What that row would have to claim, were it filled**: for every $n$ and every symmetric $R$ on $\Lambda^2\mathbb R^n$, with $\#$ normalised by $I\#I=(n-2)I$, $\mathrm{Alt}$ the orthogonal projection carrying $\tfrac13$, $\operatorname{scal}=2\operatorname{tr}$ and $\lVert\mathrm{Ric}\rVert$ the full $n\times n$ Frobenius norm, the displayed equality holds, with [Böhm–Wilking Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md) and $c_4=2$ the two imports it would have to state or discharge.

## 6. The three downstream clauses in the same paragraph, checked by hand

### 6.1 The $+24\lVert\mathrm{Alt}(W_-)\rVert^2$

$W$ is Weyl, so $\mathrm{Alt}(W)=0$; with $\lvert W\rvert=W+2W_-$ this gives $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, hence $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=4\delta^2$ and the identity's second term at $R=\lvert W\rvert$ is $6\cdot4\delta^2=24\delta^2$. **Correct.** It also follows that $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, so the defect is a property of the splitting rather than of the negative part alone, the narrowing [results.md](../results.md):218 corrects.

### 6.2 Fox's $\mathcal S^4(\alpha)$: the factor of three, and the saturation

At the $\mathbb{CP}^2$-type competitor the spectrum on $\Lambda^2\mathbb R^4$ is $(0,0,0)$ on $\Lambda^2_-$ and $\tfrac1{\sqrt6}(-1,-1,2)$ on $\Lambda^2_+$, so $\lVert W\rVert=1$ and $\theta=\sqrt{3/2}$. I evaluated all four quantities of the corrected master inequality exactly.

- $\lvert W\rvert=\tfrac1{\sqrt6}\operatorname{diag}(0,0,0,1,1,2)$, so $\operatorname{scal}(\lvert W\rvert)=2\operatorname{tr}\lvert W\rvert=\tfrac8{\sqrt6}$ and $\theta\operatorname{scal}(\lvert W\rvert)=\sqrt{\tfrac32}\cdot\tfrac8{\sqrt6}=\tfrac{8\sqrt3}{\sqrt{12}}=4$.
- $W_-=\tfrac1{\sqrt6}\Pi$ with $\Pi$ the rank-$2$ projection inside $\Lambda^2_+$, so $\lVert W_-\rVert^2=\tfrac13$ and $4\lVert W_-\rVert^2=\tfrac43$.
- $\Pi=\Pi_+-\pi$ with $\pi$ the rank-one projection on the $+2$ direction. $\mathrm{Ric}(\Pi_+)=\tfrac12\mathrm{Ric}(I)=\tfrac32\mathrm{id}$ since $\mathrm{Ric}(\star)=0$, and $\mathrm{Ric}(\pi)=\tfrac12\mathrm{id}$ by direct evaluation at $u=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$, where $\pi_{1212}=\pi_{3434}=\pi_{1234}=\tfrac12$ and the off-diagonal Ricci entries vanish. So $\mathrm{Ric}(W_-)=\tfrac1{\sqrt6}\mathrm{id}$, $\mathrm{Ric}(\lvert W\rvert)=\tfrac2{\sqrt6}\mathrm{id}$ and $\lVert\mathrm{Ric}(\lvert W\rvert)\rVert^2=4\cdot\tfrac46=\tfrac83$.
- $\mathrm{Alt}(W_-)=\tfrac{\langle W_-,\star\rangle}{\lVert\star\rVert^2}\star=\tfrac{2/\sqrt6}{6}\star=\tfrac1{3\sqrt6}\star$, so $\delta^2=\tfrac1{54}\cdot6=\tfrac19$ and $24\delta^2=\tfrac83$.

Jäger's right-hand side is $\tfrac83-\tfrac43=\tfrac43$ against a left-hand side of $4$: **a violation by exactly a factor of three.** The corrected right-hand side is $\tfrac83-\tfrac43+\tfrac83=4$: **saturated exactly.** Every one of the four quantities is unchanged by zero-padding, $\operatorname{tr}\lvert W\rvert$, $\lVert W_-\rVert$, $\mathrm{Alt}(W_-)$ and $\mathrm{Ric}(\lvert W\rvert)$ all live on the $4$-block, so **the factor of three and the saturation hold at every $n\ge4$**, where [ATTEMPTS.md](../ATTEMPTS.md) records them screened at $n=6$ and $n=8$. This also reproduces [conventions.md](../findings/conventions.md)'s $a=\tfrac1{3\sqrt6}$ and [Conjecture L16](../results.md)'s "defect exactly $1/9$ in every ambient dimension" from the identity rather than alongside it.

### 6.3 "Every sphere product, in any frame, has defect zero"

A sphere product is coordinate-diagonal in its product frame; the spectral parts of a coordinate-diagonal operator are coordinate-diagonal, and §3.3 shows $\mathrm{Alt}$ annihilates every such operator. So $\delta^2=0$. **Correct.** The clause "in any frame" is true and carries nothing: $\mathrm{Alt}$ is $O(n)$-equivariant and $W_-$ is frame-covariant, so $\delta^2$ is an invariant of $W$ and cannot be frame-dependent. A reader could take the phrase to mean the defect is a per-frame quantity that happens to be constant here; it is a per-tensor quantity.

## 7. The gap between what is proven and what is used, and [Lemma L7](../findings/bounds.md)'s import

**What L7 takes.** Its proof reads: "*Polarising [L15](../findings/problem.md)'s identity at $(W_+,W_-)$, with $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$, turns that into $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$ exactly.*" I carried out that polarisation.

Writing $F(R)=\operatorname{scal}(R^2+R^\#)$, expanding $F(X+Y)-F(X)-F(Y)=4\operatorname{tr}(XY)+4\operatorname{tr}(X\#Y)$ on the left and $2\langle\mathrm{Ric}X,\mathrm{Ric}Y\rangle+12\langle\mathrm{Alt}X,\mathrm{Alt}Y\rangle$ on the right gives
$$\operatorname{tr}(X\#Y)=\tfrac12\langle\mathrm{Ric}X,\mathrm{Ric}Y\rangle+3\langle\mathrm{Alt}X,\mathrm{Alt}Y\rangle-\operatorname{tr}(XY).$$
At $(X,Y)=(W_+,W_-)$: $\operatorname{tr}(W_+W_-)=0$ since the spectral parts have orthogonal ranges; $\mathrm{Ric}(W)=0$ gives $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$; $\mathrm{Alt}(W)=0$ gives $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$. Hence $2\operatorname{tr}(W_+\#W_-)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$, **which is exactly L7's right-hand side, constant included**. The factor $2$ L7 needs comes from its own $\le2\operatorname{tr}(W_+\#W_-)$ step and not from the identity.

**So what L7 uses is what this block establishes, with one hypothesis L7 supplies and L15 does not state.** The polarisation is legitimate only because the identity holds *for every symmetric $R$*: it is applied at $W_+$, $W_-$ and $W_++W_-=\lvert W\rvert$, none of which is a Weyl tensor and none of which need satisfy the first Bianchi identity. **The quantifier missing from both canonical copies is precisely the hypothesis L7's central step consumes.** L7's own block names its hypotheses as "criticality, Ricci-flatness and first Bianchi", those are hypotheses on $W$; the hypothesis on L15's $R$ is that there is none.

**What a consumer may cite from this block.**

- **The identity, in full, at every $n\ge1$, for every symmetric operator $R$ on $\Lambda^2\mathbb R^n$**, in the conventions of §0, with the class of $R$ read from [ATTEMPTS.md](../ATTEMPTS.md) Result 4 rather than from either canonical copy.
- Its polarised form at any pair of symmetric operators, which is the same statement.
- The definition $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, and $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$ with the resulting $24\delta^2$, a constant stated at $\lvert W\rvert$ and one stated at $W_-$ differ by $4$, as [Lemma L131](../findings/isotropy-cap.md)'s block warns.
- $\delta^2=0$ on the whole coordinate-diagonal locus and its $O(n)$-orbit, and $\delta^2=\tfrac19$ at the $\mathbb{CP}^2$-type competitor at every $n\ge4$.
- The failure of Jäger's Lemma 3.2.2 by a factor of three at $\mathcal S^4(\alpha)$ and the saturation of the corrected form there, now exact rather than screened (§6.2).

**What a consumer may not cite from it**: "every step of that transfer survives … with one exception", and any reading in which the Bianchi defect is the sole obstruction to lifting. Both are refuted on the record and §9 shows the refutation did not reach the canonical copy.

## 8. What the identity establishes about the lifting obstruction, pre-registered question 3

**Two obstructions, and the display bears on one.**

| obstruction | what it is | what the display does |
| --- | --- | --- |
| Jäger's eq. (1.6), the Bianchi-dependent trace identity | free on the diagonal locus because $\mathrm{Alt}(\lvert W\rvert)=0$ there | **prices it exactly**: the step survives off the locus at a cost of $+24\delta^2$, and §6.2 shows the price is attained |
| $X_{\mathrm{inv}}\succeq0$, Jäger's "$X(W)\ge0$ is obvious by the definitions of $W_+$ and $W_-$" | free on the diagonal locus by the entrywise triangle inequality, a coordinate mechanism | **nothing at all**: $\mathrm{Alt}$ does not see it, and no defect condition does |

**The second is established elsewhere, in pieces, and one piece is numerical.** The diagonal-locus half is a two-line display in [r470](../reviews/REVIEW_r470.md) Finding 2, resting on the entrywise reading of $\lvert M\rvert$. The off-locus refutation is [ATTEMPTS.md](../ATTEMPTS.md)'s single instance, $\lambda_{\min}\approx-2.4\times10^{-2}$ at an $n=6$ critical point with $\theta=0.6611$, **a computed value, and ATTEMPTS.md carries its own caveat that genericity beyond that one instance is only moderately supported**. The surviving repair, $\operatorname{scal}(X_{\mathrm{inv}})\ge0$, holds because $\#$ preserves the positive-semidefinite cone; its structure is now [Lemma L154](../findings/bounds.md) and [Lemma L155](../findings/bounds.md), and the open grant is $J_5\ge0$ at §3.3.

**And zero defect does not restore the proof.** [ATTEMPTS.md](../ATTEMPTS.md) Result 4 records non-diagonal critical points with $\delta=0$, and [LEDGER.md](../findings/LEDGER.md) records the §3.2 dichotomy with $\mathrm{Alt}(W_-)=0$ imposed as unproven. So $\{\delta=0\}$ is strictly larger than the $O(n)$-orbit of the diagonal locus, and the identity prices one entry point rather than closing the lift. **The heading's "TWO OBSTRUCTIONS, NOT ONE" is accurate, and only the first of the two is this block's own.**

## 9. Each citable claim read alone, as a consumer would, the named trap

The record's signature failure is a correction landing beside the statement it corrects. It happened here, and the direction is the one that matters: **the fullest corrections sit in [problem.md](../findings/problem.md)'s blockquotes and in [results.md](../results.md):218's landscape bullet, while [results.md](../results.md):643's block (the one the record's own structure calls the canonical statement), carries the uncorrected text.**

### D1, the canonical copy still says "do not satisfy" and "with one exception"

**Located.** [results.md](../results.md):645, verbatim: "*Every step of that transfer survives off the diagonal locus, using spectral rather than coordinate projections, with one exception: $\lvert W\rvert$ and the spectral parts $W_\pm$ do not satisfy the first Bianchi identity …*"

**Exhibited.** Take $W$ the balanced sphere product at any even $n$. It is coordinate-diagonal, so $W_\pm$ and $\lvert W\rvert$ are coordinate-diagonal, so §3.3 gives $\mathrm{Alt}(\lvert W\rvert)=0$, and $\ker\mathrm{Alt}$ *is* the Bianchi subspace. **At a named object of the record's own catalogue, $\lvert W\rvert$ and $W_\pm$ satisfy the first Bianchi identity.** [problem.md](../findings/problem.md):202 reads "need not satisfy"; the two copies of one result do not say the same thing. Separately, "with one exception" is refuted twice on the record, by the second obstruction $X_{\mathrm{inv}}\succeq0$ ([r469](../reviews/REVIEW_r469.md), [r470](../reviews/REVIEW_r470.md), and [ATTEMPTS.md](../ATTEMPTS.md) naming both in one sentence) and by the non-diagonal $\delta=0$ critical points at which the named exception is inactive and the lift still fails.

**The opposite, argued.** The most charitable reading takes "do not satisfy" generically, as shorthand for "in general do not", which is [problem.md](../findings/problem.md)'s "need not" and is true. That reading survives for the clause taken alone. It does not save the sentence, because the clause is the *content of the exception* in a completeness claim, and the completeness claim fails on its own terms.

**Confirmed.** The finding is not that the refutation is new; it is that the repair reached three sites and skipped the fourth, and the fourth is the canonical one.

### D2, the canonical copy displays the constant with no definition of $\mathrm{Alt}$

**Located.** [results.md](../results.md):645–649 runs prose, display, then "**Proof:** [problem.md](../findings/problem.md)". The clause "$\mathrm{Alt}$ being the projection onto $\Lambda^4$" appears in [problem.md](../findings/problem.md):204 and in [ATTEMPTS.md](../ATTEMPTS.md), and in neither of the [results.md](../results.md) copies.

**Exhibited.** Read the display with $\mathrm{Alt}$ taken as the unnormalised Bianchi cyclic sum $b=3\,\mathrm{Alt}$, the reading [r411](../reviews/REVIEW_r411.md) records as live one file over. At $R=\star$, $n=4$: $\lVert b(\star)\rVert^2=9\cdot6=54$, so the right-hand side reads $0+6\cdot54=324$ against a left-hand side of $36$. **The constant $6$ is not a number until $\mathrm{Alt}$ is named**, and the canonical block does not name it.

**The opposite, argued.** [conventions.md](../findings/conventions.md) tables $\mathrm{Alt}$ with its $\tfrac13$, and the block's "Proof:" pointer leads to the file that states it inline. So a consumer who follows the record's own reading discipline recovers the right constant, and the defect is one hop of indirection rather than an error.

**Confirmed as a citation hazard**, at the site the record designates as the statement to cite.

### D3, neither canonical copy quantifies $R$

**Located.** [problem.md](../findings/problem.md):203 and [results.md](../results.md):647 display the identity with a bare $R$; [ATTEMPTS.md](../ATTEMPTS.md) Result 4 alone writes "for every symmetric $R$ on $\Lambda^2\mathbb R^n$".

**Exhibited.** Read $R$ as ranging over $\mathcal W_n$, the default object of both files. Then $\mathrm{Ric}(R)=0$ and $\mathrm{Alt}(R)=0$, both sides are $0$, and the statement is vacuous, while [Lemma L7](../findings/bounds.md)'s central step applies it at $W_+$, $W_-$ and $\lvert W\rvert$, none of which lies in $\mathcal W_n$. **The omitted quantifier is the entire content, and it is the hypothesis L7's proof consumes.**

**The opposite, argued.** The display is introduced by "the identity his opening step rests on is Bianchi-dependent", and is followed by "the constant exactly $6$ in every dimension", which is only a claim if the second term can be nonzero. Both cues point to the wide class, so an attentive reader recovers it. The wide reading is therefore *recoverable* from the paragraph, which is why this is a hypothesis correction and not a break.

**Confirmed**, and it is the correction the verdict line carries.

### D4, two of the four normalisations the constant depends on are absent from the file that exists to hold them

**Located.** [conventions.md](../findings/conventions.md) tables the $\Lambda^2$ pairing, the $S^2(\Lambda^2)$ pairing, $\operatorname{scal}=2\operatorname{tr}$ and $\mathrm{Alt}$. It has no row for $\#$ beyond "$Q(W)=W^2+W^\#$", and no row for $\mathrm{Ric}$ or for the norm on $\mathrm{Ric}$.

**Exhibited.** §2's last row: with $\#$ read straight off the structure constants, $I\#I=2(n-2)I$ and the display fails at $R=I$ for every $n\ne2$, $n(n-1)(2n-3)$ on the left against $n(n-1)^2$ on the right. This is the same shape as the trap the file itself books at $\lVert\varphi_{ab}\rVert^2$, where both numbers are true of different pairings.

**The opposite, argued.** The normalisation is determinate on the record: [the Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) state $I\#I=(n-2)I$ and check it, and [Lemma L153](../findings/bounds.md)'s marginal fixes it independently. Likewise $\mathrm{Ric}^*=2(\,\cdot\,\wedge\mathrm{id})$ appears at [Lemma L131](../findings/isotropy-cap.md). So no build that reads those two places can go wrong.

**Confirmed as an indexing gap rather than a mathematical one**, and the file's own opening rule is that a convention a block needs is added there and quoted.

## 10. What would falsify the identity, and what I did to look

$F(R)=\operatorname{scal}(R^2+R^\#)$ is an $O(n)$-invariant quadratic form on $S^2(\Lambda^2)=\mathrm{Weyl}_n\oplus S^2_0\oplus\mathbb R\cdot\mathrm{Id}\oplus\Lambda^4$, so it is four scalars. The display asserts three things about them at once: the $\Lambda^4$ scalar is $6$, the two Ricci-carrying scalars are exactly what $\lVert\mathrm{Ric}\rVert^2$ reproduces, and **the Weyl scalar is zero**.

**The object that would falsify it is an algebraic Weyl tensor with $\operatorname{tr}(W^\#)\ne-\lVert W\rVert^2$**, equivalently one with $W\#I\ne-W$. Everything else the display says is pinned by the two anchors: $R=I$ fixes the trivial summand and, with the $S^2_0$ summand, the Ricci coefficient; $R=\star$ fixes $6$. **Where I looked**: [Böhm–Wilking Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md) gives $-1$ on the Weyl summand as one of three Schur scalars, with its own $n=6$ check recorded there; §3.3's coordinate-diagonal computation gives $\operatorname{tr}(W^\#)=-\lVert W\rVert^2$ directly for every coordinate-diagonal Weyl tensor, since $\mathrm{Ric}=0$ reads as $K\mathbf 1=0$; and [Lemma L131](../findings/isotropy-cap.md)(ii) records the same statement with the sign it had to correct. No candidate survives.

**A second falsifier would be a decomposable $4$-form $A$ with $A\#I\ne2A$ at some $n>4$**, which would make the constant $n$-dependent. §4's padding argument rules that out for every decomposable, and decomposables span $\Lambda^4$.

**A third would be a symmetric $R$ at which the two summands couple**, a nonzero cross-term. §1's direct computation shows the cross term is $2\langle R_B,A\rangle+2\langle R_B\#I,A\rangle$ and that both pieces vanish for structural reasons rather than by cancellation, so no choice of $R_B$ and $A$ produces one.

## Verdict

**`PROVEN, hypotheses corrected`.**

The identity holds, with the constant exactly $6$, at every $n\ge1$ and for every symmetric operator on $\Lambda^2\mathbb R^n$, in the conventions of §0; there is no cross-term; the $+24\delta^2$, the factor of three at $\mathcal S^4(\alpha)$ with saturation of the corrected form, and the vanishing defect at every sphere product are all correct, and the middle one is exact at every $n\ge4$ rather than screened at two. What [Lemma L7](../findings/bounds.md) imports is exactly what this block establishes.

**The corrections the statement needs, all to its hypothesis line:**

1. **State the class of $R$.** "For every symmetric $R$ on $\Lambda^2\mathbb R^n$", the wording [ATTEMPTS.md](../ATTEMPTS.md) already carries, in both canonical copies. It is the hypothesis L7's proof consumes, and without it the natural in-file reading makes the statement vacuous.
2. **Carry the definition of $\mathrm{Alt}$ into [results.md](../results.md)'s copy**, or quote [conventions.md](../findings/conventions.md) there; the constant $6$ is not determinate without the $\tfrac13$.
3. **Table $\#$ and $\mathrm{Ric}$ in [conventions.md](../findings/conventions.md)**, with $I\#I=(n-2)I$ and $\lVert\mathrm{Ric}\rVert$ the full $n\times n$ Frobenius norm. Under the unhalved $\#$ the display is false rather than rescaled.
4. **Repair [results.md](../results.md):645 to match [problem.md](../findings/problem.md):202**, "need not satisfy", and the completeness clause dropped, as [results.md](../results.md):218 and [LEDGER.md](../findings/LEDGER.md) already record.

**And the label is right.** The displayed content is [Lemma L131](../findings/isotropy-cap.md) polarised, the two determine each other, and only the first of the heading's two obstructions is priced by it, the second is established in pieces elsewhere, its off-locus half resting on one computed instance that [ATTEMPTS.md](../ATTEMPTS.md) itself caveats.
