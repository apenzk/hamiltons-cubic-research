# Review r842 on Lemma L199, the orbit-tangent norm in closed form

*Cold Gate 2 brief. Reviewer [r842](INDEX.md). The claim under review is [Lemma L199](../findings/bounds.md) at [findings/bounds.md lines 319-340](../findings/bounds.md#L319-L340), read off disk and attacked from the definitions in [conventions.md](../findings/conventions.md) alone. Every derivation below was rebuilt by hand before any machine arithmetic was run, and the one screen at the end was permitted by the analysis-only footing because it guards a claim recorded here rather than establishing one.*

## Claim table

| # | claim attacked | verdict | reason |
| --- | --- | --- | --- |
| 1 | first display, the identity itself, at every symmetric $W$ | CONFIRMED | rebuilt independently, every coefficient reproduced |
| 2 | $g_k=2S_k-4(W^\#)_{kk}$ from expanding the square | CONFIRMED | the two square terms are equal by symmetry of $T$ in the last two slots |
| 3 | $S_k=2(W^2\#I)_{kk}$, the $\tfrac12$ and the slot | CONFIRMED | diagonal $A,B$ force $e=c$, $f=d$, anchored against $\mathrm{id}^\#=(n-2)\mathrm{id}$ |
| 4 | the symmetrisation is silent and changes a constant | REFUTED | no symmetrisation is performed, the diagonal weight lands as $A_{cc}B_{dd}$ |
| 5 | scope, no Bianchi and no criticality and no dimension in the first display | CONFIRMED | every imported step is stated for an arbitrary symmetric argument |
| 6 | second display, $(W^\#)_{kk}=\lambda_k(\theta-\lambda_k)$ and the collapse | CONFIRMED | it is criticality read on the diagonal, and the $-4\lambda_k^2$ cancels exactly |
| 7 | the boxed bound follows from $g_k\ge0$ | CONFIRMED AS ALGEBRA | correct at every index and carrying content only where $\theta\lambda_k>0$ |
| 8 | both moment sums reproduce $4(n-1)\lVert W\rVert^2$ and $-4P(W)$ | CONFIRMED | rederived, both fall out, and both consume relation (B) and so a Weyl hypothesis |
| 9 | the moments leave "no constant free to adjust" | REFUTED | both moments are identically blind to the coefficient of $\mathrm{Alt}(W^2)_{kk}$ |
| 10 | $\mathrm{Alt}(W^2)=0$ on the coordinate-diagonal locus | CONFIRMED | a coordinate-diagonal operator squares to one, and $\Lambda^4$ lives on four-distinct entries |
| 11 | the deficit of the recorded form is exactly $12\,\mathrm{Alt}(W^2)_{kk}$ | CONFIRMED | it reproduces [diagonal-half.md](../findings/diagonal-half.md)'s own recorded $2.00$ at $W_{\mathbb{CP}^2}$ in closed form |
| 12 | the recorded diagnosis at [diagonal-half.md](../findings/diagonal-half.md) is "wrong" | REFUTED AS STATED | the recorded sentence is correct and incomplete, and L199 is its closed form |
| 13 | the boxed right side is $1$ at the three $\Lambda^+$ indices | CONFIRMED | equality in the pair cap at all three, computed in closed form |
| 14 | the boxed right side is $0$ "at the rest" of padded $W_{\mathbb{CP}^2}$ | REFUTED | true at $n=4$ only, and $\tfrac14$ at each of the $4(n-4)$ mixed indices at every $n>4$ |
| 15 | the index sum reconciles with $(n-1)\lVert W\rVert^2$ | CONFIRMED | $3+4(n-4)\cdot\tfrac14=n-1$ at every $n$, so the count does close |
| 16 | whether the boxed right side is $\le1$ at unit norm is OPEN | REFUTED | it is one line from the pair cap [L31](../findings/stratum-two-negative.md), which the record already holds |
| 17 | "the two bounds are independent rather than nested" | REFUTED | L199's bound is the upper half of [L198](../findings/bounds.md)'s first display, sharpened by retaining $S_k$ |
| 18 | the result is new to the record | CONFIRMED WITH A QUALIFICATION | $\mathrm{Alt}(W^2)$ and $W^2\#I$ appear nowhere else, and on the diagonal locus the bound is a known cap |
| 19 | the $\mathrm{Alt}$ term is doing work | CONFIRMED | $\mathrm{Alt}(W^2)=\tfrac16\star$ at $W_{\mathbb{CP}^2}$, exhibited in closed form |

## One line someone can act on

The identity and the bound are correct and the proof is sound, and four of the surrounding assertions fail: the boxed right side is $\le1$ at unit norm by the pair cap so nothing is open and the bound is nested inside [L198](../findings/bounds.md) rather than independent of it, the evaluation "$0$ at the rest" holds at $n=4$ and at no padded dimension, and the two moment sums cannot pin the coefficient $12$.

## Conventions, quoted from the brief and from the record

- The inner product on $\Lambda^2$ is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, the half-trace, making $\{\varphi_{ab}\}_{a<b}$ orthonormal ([conventions.md](../findings/conventions.md)).
- $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is totally antisymmetric, so $T_{abc}=c_{abc}^2$ is totally symmetric and hollow, vanishing whenever two of its three indices agree.
- The index formula for $\#$ carries a $\tfrac12$: $(A\#B)_{ab}=\tfrac12\sum_{cdef}c_{acd}c_{bef}A_{ce}B_{df}$, normalised so that $\mathrm{id}^\#=(n-2)\,\mathrm{id}$.
- $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, summed over ordered pairs.
- Relation (A) is $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$, relation (B) is $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, relation (C) is $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$ at a critical point of unit norm.
- $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, carrying its $\tfrac13$, self-adjoint and idempotent, annihilating every tensor satisfying the first Bianchi identity ([conventions.md](../findings/conventions.md)).
- $\mathrm{Ric}$ is the adjoint of $\cdot\wedge\mathrm{id}$ and $\mathrm{Ric}^*=2(\cdot\wedge\mathrm{id})$.
- The pair cap is $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$, which is [Lemma L31](../findings/stratum-two-negative.md), quoted at [conventions.md](../findings/conventions.md).
- Throughout, $S_k:=\sum_{\beta\gamma}\lambda_\beta^2T_{k\beta\gamma}$ and $\mathrm{RHS}_k:=(\mathrm{Ric}(W^2)\wedge\mathrm{id})_{kk}+3\,\mathrm{Alt}(W^2)_{kk}$, the boxed bound's right side.

## Hypothesis inventory

| hypothesis | where it is used | object it is applied to | status |
| --- | --- | --- | --- |
| $W$ symmetric on $\Lambda^2\mathbb R^n$ | throughout | the statement's own $W$ | satisfied, and it is what supplies the orthonormal eigenbasis |
| $\{v_k\}$ an orthonormal eigenbasis | the definition of $T$ and of $g_k$ | $W$ | satisfied by the spectral theorem, at any $n$ |
| total antisymmetry of $c_{abc}$ | symmetry and hollowness of $T$ | $\mathfrak{so}(n)$ with an $\mathrm{ad}$-invariant inner product | satisfied, a fact about the algebra rather than about $W$ |
| [L131](../findings/isotropy-cap.md) for every symmetric $R$ | the third line of the proof | $R=W^2$, which is symmetric and in general carries $\Lambda^4$ content | satisfied, and L131's generality is exactly what the step needs |
| the index formula with its $\tfrac12$ | lines one and two of the proof | $(A,B)=(W,W)$ and $(A,B)=(W^2,I)$ | satisfied, both diagonal in the eigenbasis, $W^2v_k=\lambda_k^2v_k$ |
| relation (A) | the first moment sum only | any $W$ | satisfied, it is the Killing marginal [L153](../findings/bounds.md) and carries no Weyl hypothesis |
| relation (B) | both moment sums | $W$ | **Weyl-specific**, consuming first Bianchi and Ricci-flatness, and the block's moment note does not say so |
| criticality $Q(W)=\theta W$ | the second display and the boxed bound only | $W$ | correctly confined to those two, and absent from the first display |
| unit norm | the boxed bound, through $\theta$ being the multiplier | $W$ | stated, and needed, because $\theta=P(W)/\lVert W\rVert^3$ is the multiplier only at $\lVert W\rVert=1$ |
| pair cap [L31](../findings/stratum-two-negative.md) | section 8 below, this reviewer's addition | orthonormal $v_k,v_\beta$ | satisfied, and it is what closes the block's open question |

The one hypothesis the block leaves unsaid is the Weyl condition inside the moment sums. The first display is genuinely free of it, and the paragraph that derives the moments from the display is not, because $\mathop{\mathrm{tr}}(W\#W)=-\lVert W\rVert^2$ and the second moment's use of (B) both rest on $W\#I=-W$. The block's own scope banner covers only the display, so this is a caution to a downstream reader rather than a defect.

## 1. The written chain, link by link

Take $\mathrm{ad}(v_k)v_\alpha=\sum_\gamma c_{k\alpha\gamma}v_\gamma$ and $Wv_\alpha=\lambda_\alpha v_\alpha$. Then $[\mathrm{ad}(v_k),W]v_\alpha=\sum_\gamma(\lambda_\alpha-\lambda_\gamma)c_{k\alpha\gamma}v_\gamma$, whose Hilbert-Schmidt norm squared is $\sum_{\alpha\gamma}(\lambda_\alpha-\lambda_\gamma)^2T_{k\alpha\gamma}$. That reproduces the definition at [conventions.md](../findings/conventions.md) rather than assuming it, so the summation is over ordered pairs and the factor of two that an unordered reading would cost is not in play.

Expand: $(\lambda_\alpha-\lambda_\beta)^2=\lambda_\alpha^2+\lambda_\beta^2-2\lambda_\alpha\lambda_\beta$. The first term contracts to $\sum_{\alpha\beta}\lambda_\alpha^2T_{k\alpha\beta}$ and the second to $\sum_{\alpha\beta}\lambda_\beta^2T_{k\alpha\beta}$, and these are equal because $T$ is symmetric in its last two slots. Both equal $S_k$, so together they give $2S_k$. The cross term gives $-2\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=-4(W^\#)_{kk}$ once the identification of section 2 is in hand. So $g_k=2S_k-4(W^\#)_{kk}$, as written. Hollowness plays no part here, since the diagonal terms $\alpha=\beta$ carry $(\lambda_\alpha-\lambda_\alpha)^2=0$ anyway and the terms with $\alpha=k$ or $\beta=k$ are killed by $T$ without changing any coefficient. The block cites total symmetry and hollowness together, and only the former is load-bearing at this step.

## 2. The index-formula step and the factor the record warns about

Read $(A\#B)_{ab}=\tfrac12\sum_{cdef}c_{acd}c_{bef}A_{ce}B_{df}$ at $a=b=k$ with $A$ and $B$ both diagonal in $\{v_k\}$. Diagonality forces $A_{ce}=A_{cc}\delta_{ce}$ and $B_{df}=B_{dd}\delta_{df}$, which collapses the four free indices to two and turns $c_{acd}c_{bef}$ into $c_{kcd}^2=T_{kcd}$. So $(A\#B)_{kk}=\tfrac12\sum_{cd}A_{cc}B_{dd}T_{kcd}$ for any pair of diagonal $A,B$, which is the block's own "both weights being $A_{cc}B_{dd}$" made explicit.

At $A=B=W$ this gives $(W^\#)_{kk}=\tfrac12\sum_{cd}\lambda_c\lambda_dT_{kcd}$, so $\sum_{cd}\lambda_c\lambda_dT_{kcd}=2(W^\#)_{kk}$ as the block states.

At $A=W^2$ and $B=I$ this gives $(W^2\#I)_{kk}=\tfrac12\sum_{cd}\lambda_c^2T_{kcd}=\tfrac12S_k$, so $S_k=2(W^2\#I)_{kk}$ as the block states. $W^2$ is diagonal in the same eigenbasis for the trivial reason that $W^2v_k=\lambda_k^2v_k$, and $I$ is diagonal in every basis, so the diagonality premise is met on both slots.

The $\tfrac12$ is present and used, and the anchor the record demands confirms it: at $A=B=I$ the same collapse gives $(I\#I)_{kk}=\tfrac12\sum_{cd}T_{kcd}=\tfrac12\cdot2(n-2)=n-2$ by relation (A), which is $\mathrm{id}^\#=(n-2)\,\mathrm{id}$. There is no off-by-two anywhere in the block, on either reading of the two places the record says the factor has entered before.

## 3. The symmetrisation question

There is no symmetrisation, silent or otherwise. The weight $\lambda_\beta^2$ is indeed asymmetric in $(\beta,\gamma)$, and the identity does not need it to be symmetric: the collapse above delivers the weight $A_{cc}B_{dd}=\lambda_c^2\cdot1$ directly, one factor per slot, and the slot carrying $\lambda_c^2$ is the one the $A$-argument occupies. The symmetry that is used is $\#$'s own, $A\#B=B\#A$, which shows up here as the harmless observation that $(I\#W^2)_{kk}=\tfrac12\sum_{cd}T_{kcd}\lambda_d^2$ is the same number as $(W^2\#I)_{kk}$ by symmetry of $T$. Reading the weight into the wrong slot would therefore change nothing at all, which is why no constant is at risk. Verdict on the brief's item 3: the suspected defect is REFUTED.

## 4. The scope claim

The scope claim survives. The chain uses exactly three inputs: the eigen-expansion of section 1, which needs $W$ symmetric and nothing else; the index formula of section 2, which needs $A$ and $B$ diagonal in the chosen basis and holds at any $n$; and [L131](../findings/isotropy-cap.md), which the record states and Gate 2 confirmed for every symmetric $R$ on $\Lambda^2\mathbb R^n$. Nothing anywhere requires $W\#I=-W$, first Bianchi, Ricci-flatness, criticality or a dimension bound.

The brief's warning that $\mathrm{Ric}(W^2)$ and $\mathrm{Alt}(W^2)$ are computed from an object that is generally not a Weyl tensor is exactly right, and it cuts in the lemma's favour rather than against it: L131's generality is what makes the step legal, and $\mathrm{Alt}(W^2)\ne0$ is not an embarrassment but the whole content of the third term. Had L131 been available only on the Bianchi locus, the step would have been illegal precisely where the term is interesting.

Two independent anchors on L131 itself, since the whole lemma rests on it. At $R=I$: $\mathrm{Alt}(I)=0$, because $\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ cyclically summed over the last three indices cancels term by term, and $I\#I=(n-2)I$, so L131 reads $\mathrm{Ric}(I)\wedge\mathrm{id}=(n-1)I$, which is the constant-curvature operator with its Ricci $(n-1)\,\mathrm{id}$. At $R=\star$ inside $\Lambda^2\mathbb R^4$: $\mathrm{Ric}$ annihilates $\Lambda^4$ and $\mathrm{Alt}(\star)=\star$, so L131 demands $\star\#I=2\star$, which is L131's own consequence (i) reading the $\Lambda^4$ eigenvalue of $\#I$ as $2$. Both anchors hold, on objects with and without $\Lambda^4$ content.

## 5. The two moment sums, and the constant they cannot see

**First moment.** From $g_k=4(W^2\#I)_{kk}-4(W^\#)_{kk}$, summing gives $\sum_kg_k=4\mathop{\mathrm{tr}}(W^2\#I)-4\mathop{\mathrm{tr}}(W\#W)$. For the first trace, $\mathop{\mathrm{tr}}(W^2\#I)=\tfrac12\sum_{kcd}\lambda_c^2T_{kcd}=\tfrac12\sum_c\lambda_c^2\sum_{kd}T_{ckd}=\tfrac12\cdot2(n-2)\lVert W\rVert^2=(n-2)\lVert W\rVert^2$ by total symmetry of $T$ and relation (A), which carries no Weyl hypothesis. For the second, $\mathop{\mathrm{tr}}(W\#W)=\tfrac12\sum_{kcd}\lambda_c\lambda_dT_{kcd}=\tfrac12\sum_d\lambda_d\sum_{kc}\lambda_cT_{dkc}=\tfrac12\cdot(-2\lVert W\rVert^2)=-\lVert W\rVert^2$ by relation (B), which is Weyl-specific. Together $\sum_kg_k=4(n-2)\lVert W\rVert^2+4\lVert W\rVert^2=4(n-1)\lVert W\rVert^2$, the record's tabled value. The convention carried by $\mathop{\mathrm{tr}}(W\#W)$ is the halved Böhm-Wilking product with $\mathrm{id}^\#=(n-2)\mathrm{id}$, and under the unhalved product in circulation this trace would read $-2\lVert W\rVert^2$ and the sum would come out $4(2n-3)\lVert W\rVert^2$, so the block is committed to the record's normalisation and is consistent with it.

**Second moment.** $\sum_k\lambda_k(W^2\#I)_{kk}=\tfrac12\sum_{kcd}\lambda_k\lambda_c^2T_{kcd}=\tfrac12\sum_c\lambda_c^2\sum_{kd}\lambda_kT_{ckd}=\tfrac12\sum_c\lambda_c^2(-2\lambda_c)=-\mathop{\mathrm{tr}}W^3$, again by relation (B) at the index $c$. And $\sum_k\lambda_k(W^\#)_{kk}=\mathop{\mathrm{tr}}(WW^\#)=\langle W,W^\#\rangle$. So $\sum_k\lambda_kg_k=-4\mathop{\mathrm{tr}}W^3-4\langle W,W^\#\rangle=-4\langle W,W^2+W^\#\rangle=-4P(W)$. Both moments reproduce.

**The claim they leave "no constant free to adjust" is REFUTED.** Suppose the coefficient of $\mathrm{Alt}(W^2)_{kk}$ in the first display were an unknown $c$ rather than $12$. Summing over $k$ and using L131 at $R=W^2$ to convert $\mathop{\mathrm{tr}}(\mathrm{Ric}(W^2)\wedge\mathrm{id})=(n-1)\lVert W\rVert^2-3\mathop{\mathrm{tr}}\mathrm{Alt}(W^2)$ gives $\sum_kg_k=4(n-1)\lVert W\rVert^2+(c-12)\mathop{\mathrm{tr}}\mathrm{Alt}(W^2)$. Now $\mathop{\mathrm{tr}}$ on $S^2(\Lambda^2)$ is the pairing against the identity operator, $\mathrm{Alt}$ is self-adjoint, and $\mathrm{Alt}(I)=0$, so
$$\mathop{\mathrm{tr}}\mathrm{Alt}(X)=\langle\mathrm{Alt}(X),I\rangle=\langle X,\mathrm{Alt}(I)\rangle=0\qquad\text{for every symmetric }X.$$
The first moment therefore reproduces $4(n-1)\lVert W\rVert^2$ for **every** value of $c$, and pins nothing about it. The second moment is blind for the same structural reason one step further out: $\sum_k\lambda_k\mathrm{Alt}(W^2)_{kk}=\langle W,\mathrm{Alt}(W^2)\rangle=\langle\mathrm{Alt}(W),W^2\rangle=0$, because $W$ satisfies the first Bianchi identity and $\mathrm{Alt}$ annihilates it. So both moments are identically insensitive to the coefficient of the $\Lambda^4$ term, at every $W$ and every $n$.

The $12$ is pinned by the proof, being $4$ times L131's $3$, and it is not pinned by the moments. The sentence "reproduced here with no constant free to adjust" is the one claim in that paragraph that fails, and it fails in the direction that matters, because it invites a reader to treat the moment check as a verification of the new term when the new term is exactly what the check cannot see. Everything else in that paragraph is correct.

## 6. $\mathrm{Alt}(W^2)$ on the coordinate-diagonal locus

Two steps, both clean.

**$W^2$ is coordinate-diagonal when $W$ is.** Coordinate-diagonal means $W\varphi_{ij}=K_{ij}\varphi_{ij}$ in the basis of coordinate $2$-planes, so $W$ is a diagonal matrix in that basis and $W^2\varphi_{ij}=K_{ij}^2\varphi_{ij}$ is diagonal in the same basis. As a four-tensor this says $(W^2)_{ijkl}=0$ unless $\{i,j\}=\{k,l\}$.

**A coordinate-diagonal operator has $\mathrm{Alt}=0$.** Let $R$ be coordinate-diagonal and let $i,j,k,l$ be four distinct indices. Then $\{i,j\}\ne\{k,l\}$, $\{i,k\}\ne\{l,j\}$ and $\{i,l\}\ne\{j,k\}$, so all three terms of $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ vanish. Since $\mathrm{Alt}(R)$ lies in $\Lambda^4$ and a totally antisymmetric four-tensor is determined by its four-distinct entries, every other entry vanishing by antisymmetry, $\mathrm{Alt}(R)=0$ identically.

So the block's claim is CONFIRMED, and its own one-sentence version of the argument is right, with the implicit step "the operator square of a diagonal matrix is diagonal" being the part it leaves to the reader. Note the distinction the brief insists on is real and the block respects it: the locus is diagonality in the coordinate $2$-planes $e_i\wedge e_j$, and every $W$ in this lemma is diagonal as an operator on $\Lambda^2$ by construction, so operator-diagonality carries no information here and coordinate-diagonality carries all of it.

## 7. The boxed bound

$g_k\ge0$ is automatic and needs no hypothesis, being the squared norm of the operator $[\mathrm{ad}(v_k),W]$, with equality exactly when $\mathrm{ad}(v_k)$ commutes with $W$. Feeding it into the second display gives $4\,\mathrm{RHS}_k-4\theta\lambda_k=g_k\ge0$, which is the boxed bound. That much is right.

The bound's direction and its content deserve a sharper statement than the block's "a bound at EVERY index". Rewrite the right side using section 2 and L131, which collapses it to
$$\mathrm{RHS}_k=(\mathrm{Ric}(W^2)\wedge\mathrm{id})_{kk}+3\,\mathrm{Alt}(W^2)_{kk}=\lambda_k^2+(W^2\#I)_{kk}=\lambda_k^2+\tfrac12S_k.$$
Since $T\ge0$ entrywise, $S_k\ge0$, hence $\mathrm{RHS}_k\ge0$ at every index and every $W$. So at any index with $\lambda_k\le0$ and $\theta>0$ the bound asserts a non-positive number is at most a non-negative one, which is true without any input from the lemma. The bound carries content exactly where $\theta\lambda_k>0$, and for $\theta>0$ that is the positive part of the spectrum. It is strongest at the largest eigenvalue, where dividing by $\lambda_k>0$ turns it into $\theta\le\lambda_k+S_k/(2\lambda_k)$. At a negative $\lambda_k$ the same division reverses to $\theta\ge\lambda_k+S_k/(2\lambda_k)$, and at padded $W_{\mathbb{CP}^2}$ that reads $1.2247\ge-2.4495$, which is the shape of the vacuity just described. The block's emphasis on "EVERY index" therefore overstates: the identity holds at every index and the inequality bites at the positive ones.

On the diagonal locus the bound is one the record already has. There the eigenvectors are $\varphi_{ab}$ with $\lambda_{ab}=M_{ab}$, and $S_{ab}=\sum_{c\ne a,b}(M_{ac}^2+M_{bc}^2)=s_a+s_b-2M_{ab}^2$ because $[\varphi_{ab},\varphi_{cd}]$ vanishes unless the pairs share exactly one index. Substituting gives $\mathrm{RHS}_{ab}=\tfrac12(s_a+s_b)$ and the boxed bound becomes $2\theta M_{ab}\le s_a+s_b$, which is [diagonal-half.md](../findings/diagonal-half.md)'s part (iii) verbatim. So the boxed bound is a genuine extension off that locus and a restatement on it.

## 8. Padded $W_{\mathbb{CP}^2}$, and the open question that is not open

Fix $\theta=3/\sqrt6$ and the $\Lambda^+$ spectrum $(2,-1,-1)/\sqrt6$, with everything else zero. Criticality gives $(W^\#)_{kk}=\theta\lambda_k-\lambda_k^2$, which reads $\tfrac13$ at the top index, $-\tfrac23$ at each of the two others and $0$ elsewhere, summing to $-1=\mathop{\mathrm{tr}}W^\#$ as it must. In $\Lambda^+\cong\mathfrak{su}(2)$ the structure constant is $[\omega_1,\omega_2]=-\sqrt2\,\omega_3$, so $T=2$ on the $\Lambda^+$ triple, and $[\Lambda^+,\Lambda^-]=0$.

**The three $\Lambda^+$ indices.** At the top index the only contributions to $S$ are the ordered pairs $(\omega_2,\omega_3)$ and $(\omega_3,\omega_2)$, each weighted $\tfrac16\cdot2$, so $S=\tfrac23$ and $\mathrm{RHS}=\tfrac46+\tfrac13=1$, with $g=2\cdot\tfrac23-4\cdot\tfrac13=0$. At each of the two lower $\Lambda^+$ indices the contributions are $\tfrac46\cdot2$ and $\tfrac16\cdot2$, so $S=\tfrac53$ and $\mathrm{RHS}=\tfrac16+\tfrac56=1$, with $g=\tfrac{10}3+\tfrac83=6$. So the right side is $1$ at all three $\Lambda^+$ indices, in closed form, and $\theta\lambda_{\max}=1$ is met with equality with $g_{\max}=0$. That $\mathrm{ad}(\omega_1)$ commutes with $W$ is visible directly: it kills $\omega_1$, rotates the two-dimensional eigenspace $\langle\omega_2,\omega_3\rangle$ on which $W$ is a multiple of the identity, annihilates $\Lambda^-$, and preserves the mixed and $\mathfrak{so}(n-4)$ blocks on which $W$ vanishes. All of section 8's $\Lambda^+$ arithmetic is independent of the padding dimension, so this part of the block's claim is CONFIRMED at every $n\ge4$.

**"$0$ at the rest" is REFUTED at every $n>4$.** The three $\Lambda^-$ indices do carry $\mathrm{RHS}=0$, since $[\Lambda^-,\Lambda^+]=0$ kills every term of $S$ and $\lambda=0$. The mixed indices do not. Take $v=\varphi_{ap}$ with $a\le4<p$. Each $\omega_i$ acts on $\mathbb R^4$ as $1/\sqrt2$ times an orthogonal complex structure, so $\lVert[\varphi_{ap},\omega_i]\rVert^2=\lVert\omega_ie_a\rVert^2=\tfrac12$, and
$$S_{\varphi_{ap}}=\sum_{\beta}\lambda_\beta^2\lVert[\varphi_{ap},v_\beta]\rVert^2=\tfrac12\sum_{\Lambda^+}\lambda^2=\tfrac12\lVert W\rVert^2=\tfrac12 ,$$
giving $g=1$ and $\mathrm{RHS}=0+\tfrac14=\tfrac14$ at each of the $4(n-4)$ mixed indices. The $\binom{n-4}2$ indices of $\mathfrak{so}(n-4)$ do carry $0$, their brackets with $\Lambda^2\mathbb R^4$ vanishing. So at $n=6$ the boxed right side is $(1,1,1,0,0,0)$ on $\Lambda^2\mathbb R^4$ and $\tfrac14$ on each of eight mixed indices, which is not "$0$ at the rest".

The sentence is true under one reading and false under the other, and the two readings are the two halves of the sentence. "The rest" being three indices forces $n=4$, where the claim is exactly right and the total is $3\cdot1+3\cdot0=3=(n-1)\lVert W\rVert^2$. The word "padded" forces $n>4$, where the claim is false. Since the block invokes [L198](../findings/bounds.md)'s equality case, and L198 states its sharpness "at every $n\ge4$", the padded reading is the intended one and the evaluation should be restated.

**The count closes at every $n$, so this is a defect in the sentence and not in the lemma.** $\sum_k\mathrm{RHS}_k=3\cdot1+4(n-4)\cdot\tfrac14=n-1=(n-1)\lVert W\rVert^2$, which is the identity's own prediction, obtained by summing L131 at $R=W^2$ and using $\mathop{\mathrm{tr}}\mathrm{Alt}(W^2)=0$ from section 5 together with $\mathop{\mathrm{tr}}(W\#W)=-\lVert W\rVert^2$. Two ways of getting $n-1$ agree, and they agree only because the mixed indices carry their $\tfrac14$. A reader who took the block's "$0$ at the rest" at face value would find the count short by $n-4$ at every padded dimension.

**The open question is closed, in one line, by a lemma the record already holds.** Write $\mathrm{RHS}_k=\lambda_k^2+\tfrac12S_k$ and $S_k=\sum_\beta\lambda_\beta^2\lVert[v_k,v_\beta]\rVert^2$. Hollowness kills the $\beta=k$ term, and the pair cap [L31](../findings/stratum-two-negative.md) bounds every remaining bracket norm by $2$, so at unit norm
$$S_k\le2\sum_{\beta\ne k}\lambda_\beta^2=2\big(\lVert W\rVert^2-\lambda_k^2\big)=2\big(1-\lambda_k^2\big),\qquad\text{hence}\qquad \mathrm{RHS}_k\le\lambda_k^2+\big(1-\lambda_k^2\big)=1 .$$
That is exactly the statement the block records as OPEN, and it holds at every index of every symmetric unit-norm $W$, with no criticality anywhere. The equality case is the pair cap saturating on the whole support, which is what the $\Lambda^+$ arithmetic above exhibits: $S=\tfrac23=2(1-\tfrac46)$ at the top index and $S=\tfrac53=2(1-\tfrac16)$ at the two others, both tight.

**So the two bounds are nested, not independent.** Combining, $\theta\lambda_k\le\mathrm{RHS}_k\le1$ at every index, which at the top index is [L198](../findings/bounds.md)'s boxed $\theta\lambda_{\max}\le1$. The ingredients are the same in both: L198 caps $\lambda^{\mathsf T}T^{(k)}\lambda$ by $2(1-\lambda_k^2)$ with the pair cap, and L199 caps $S_k$ by $2(1-\lambda_k^2)$ with the pair cap. L199's bound is L198's upper half with $S_k$ retained rather than capped, so it is at least as strong at every index and strictly stronger wherever the cap has slack, for instance at every mixed index of a padded point, where L199 gives $\theta\lambda_k\le\tfrac14$ against L198's $\le1$. What L199 does **not** reach is the lower half of L198's first display, $\lambda_k(\theta-\lambda_k)\ge-(1-\lambda_k^2)$, which is the source of L198's second display and of the corollary $\theta\le(n-1)/\sqrt{n+1}$: that side comes from bounding the quadratic form below and has no route through $g_k\ge0$. So the honest statement is that L199 refines L198's upper half and leaves its lower half untouched, and the recorded "independent rather than nested" is wrong in both directions.

## 9. Novelty

Grepping [findings/](../findings/) by the objects rather than by the vocabulary: `Alt(W^2)` occurs only in the L199 block itself, `W^2#I` likewise, and the weight $\sum\lambda_\beta^2T_{k\beta\gamma}$ appears nowhere else under any symbol. The nearest neighbours are different objects. [conventions.md](../findings/conventions.md) tables $S_{22}=2\mathop{\mathrm{tr}}(W^2\#W^2)$, which is the $\lambda_\beta^2\lambda_\gamma^2$ weight and a contraction rather than a row. [second-order.md](../findings/second-order.md) and [INDEX-traps.md](../findings/INDEX-traps.md) carry L131 at $R=\lvert W\rvert$ with the observation that the three-term form has zero $\Lambda^4$ content there, which is the same identity read at a different argument. So the objects are new to the record and the derivation is new.

The correction to [diagonal-half.md](../findings/diagonal-half.md) at line 120 is right in substance and overstated in words.

Right in substance, and checkable against the record's own recorded number. At $n=4$, $\Lambda^4$ is spanned by $\star=\Pi_+-\Pi_-$ with $\lVert\star\rVert^2=6$, so $\mathrm{Alt}(W^2)=\tfrac{\langle W^2,\star\rangle}{6}\star$, and $\langle W^2,\star\rangle=\mathop{\mathrm{tr}}(W^2\Pi_+)-\mathop{\mathrm{tr}}(W^2\Pi_-)=1-0=1$, giving
$$\mathrm{Alt}\big(W_{\mathbb{CP}^2}^2\big)=\tfrac16\star,\qquad \mathrm{Alt}(W^2)_{kk}=+\tfrac16 \text{ on }\Lambda^+,\quad -\tfrac16 \text{ on }\Lambda^- .$$
So the predicted deficit is $12\cdot\tfrac16=2$ at each $\Lambda^+$ index, and [diagonal-half.md](../findings/diagonal-half.md) records the failure of its own form at $\mathbb{CP}^2$ as exactly $2.00$. That is an independent confirmation of the correction and of the reading $2\langle\widehat{\mathrm{Ric}(W^2)}v_\gamma,v_\gamma\rangle=4(\mathrm{Ric}(W^2)\wedge\mathrm{id})_{\gamma\gamma}$ that the block asserts from $\mathrm{Ric}^*=2(\cdot\wedge\mathrm{id})$. The record's two further figures, $2.22$ and $2.33$ at $\mathbb{CP}^3$ and $\mathbb{CP}^4$, sit on $\tfrac{4(2m-1)}{3m}$, which returns $2$, $\tfrac{20}9=2.2\overline2$ and $\tfrac73=2.3\overline3$ at $m=2,3,4$. Three recorded values on a two-parameter rational form is one degree of corroboration rather than a proof, and it is reported here as corroboration.

Overstated in words. The recorded sentence says the general carrier of $s_a+s_b$ is $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$, which is $S_\gamma$ and is correct, and that $\mathrm{Ric}(W^2)$ is only its diagonal-locus face, which is also correct: on the diagonal locus $S_\gamma=2(\mathrm{Ric}(W^2)\wedge\mathrm{id})_{\gamma\gamma}-2\lambda_\gamma^2$, and off it the same expression is short by $6\,\mathrm{Alt}(W^2)_{\gamma\gamma}$. L199 supplies the closed form of that shortfall, which the recorded sentence never names. So the recorded diagnosis is correct and incomplete, and calling it "wrong" misdescribes the relation between the two statements. The block's further claim that "the general form buys nothing new" does not survive is fair, since the general form yields a bound at every index off the diagonal locus, and section 7 shows it reduces to a known cap on the locus itself.

## 10. The vacuity test

The $\mathrm{Alt}$ term does real work, and section 9 exhibits the witness in closed form: $\mathrm{Alt}(W_{\mathbb{CP}^2}^2)=\tfrac16\star\ne0$, on the record's own conjectured maximiser and at the very point where the block reads the bound. Replacing $12\,\mathrm{Alt}(W^2)_{kk}$ by anything else changes the first display at that point, and the two candidates one might reach for both fail there: dropping the term entirely reproduces [diagonal-half.md](../findings/diagonal-half.md)'s form, which is off by $2$ at each $\Lambda^+$ index, and folding it into the $\mathrm{Ric}$ term is not available because $\mathrm{Ric}$ annihilates $\Lambda^4$ by construction.

The one place the term is invisible is under the two moment contractions of section 5, which is precisely why those contractions cannot serve as its verification.

## 11. The opposite case, for each defect

- **On "$0$ at the rest".** The strongest defence is that the author meant $n=4$, where the sentence is exactly right and the count closes at $3$. The defence fails on the word "padded", which the block chose, and on its own appeal to [L198](../findings/bounds.md)'s sharpness "at every $n\ge4$". The finding stands, at the level of the sentence rather than the lemma.
- **On "no constant free to adjust".** The strongest defence is that the moments do pin the three coefficients $4$, $-4$ and $-4$, and that the author may have meant those. That defence is good for what it covers, and it does not reach the $12$, which is the only coefficient a reader would want checked. The finding stands as REFUTED AS STATED and is withdrawn as a charge against the mathematics.
- **On "the attribution is wrong".** The strongest defence is that the recorded sentence, read as a claim that no basis-free general carrier exists, would indeed be wrong, and L199 refutes that reading by exhibiting one. That defence is strong enough that this reviewer reports the item as a wording defect rather than a mathematical one, and confirms the substance of the correction.
- **On the open question.** The strongest defence would be a hypothesis under which the pair cap fails, and none exists: [L31](../findings/stratum-two-negative.md) is stated for orthonormal bivectors and the eigenbasis is orthonormal by assumption. No defence survives, so this finding is reported at full strength.
- **On "independent rather than nested".** The strongest defence is that L199 does not subsume L198, since L198's lower half and its corollary are out of reach of $g_k\ge0$. That defence is correct and is incorporated into section 8, which is why the finding is stated as "L199 refines L198's upper half" rather than as "L199 subsumes L198".
- **On the vacuity of the bound at non-positive eigenvalues.** The strongest defence is that an identity holding at every index is worth stating even where the inequality derived from it is slack, and that the slack itself, $\tfrac14g_k$, is the quantity the programme's $\Delta$ is built from. That defence is good, and the item is recorded as a caution about the block's phrasing rather than as a defect.

## 12. What would break it, and what was done to look

The object that would falsify the first display is a symmetric $W$ on $\Lambda^2\mathbb R^n$, in its own eigenbasis, with $g_k\ne4(\mathrm{Ric}(W^2)\wedge\mathrm{id})_{kk}+12\,\mathrm{Alt}(W^2)_{kk}-4\lambda_k^2-4(W^\#)_{kk}$ at some index. Since the display is two substitutions into an eigen-expansion, such an object exists only if the index formula's $\tfrac12$ or [L131](../findings/isotropy-cap.md) is misstated. Both were anchored rather than assumed: the index formula against $\mathrm{id}^\#=(n-2)\,\mathrm{id}$ in section 2, and L131 at $R=I$ and at $R=\star$ in section 4, the second being an argument with pure $\Lambda^4$ content and therefore the one that tests the $-3\,\mathrm{Alt}$ term rather than passing over it. No falsifier is available, and the identity is CONFIRMED.

The object that would falsify the boxed bound is a critical unit-norm $W$ with $\theta\lambda_k>\mathrm{RHS}_k$ at some index, which by section 7 would be a $W$ with $g_k<0$. No such object exists, $g_k$ being a squared norm.

The falsifiers for the three surrounding assertions were found rather than sought at length, each in closed form: padded $W_{\mathbb{CP}^2}$ at $n>4$ against "$0$ at the rest", $\mathop{\mathrm{tr}}\mathrm{Alt}(X)=0$ against "no constant free to adjust", and the pair cap against the open question. Nothing was searched, swept or optimised.

**Screen, and it is a screen.** The closed-form values above were rebuilt in machine arithmetic at $n=4$ and at padded $n=6$, on operators constructed for the purpose: the first display agrees with $g_k$ computed directly from $\lVert[\mathrm{ad}(v_k),W]\rVert^2$ to $3\times10^{-32}$, $\mathrm{Alt}(W^2)_{kk}$ returns $\pm\tfrac16$ on $\Lambda^\pm$ and $0$ on the mixed block, the eight mixed indices at $n=6$ return $\mathrm{RHS}=\tfrac14$ apiece, both index sums return $4(n-1)$ and $n-1$, the pair-cap slack $S_k-2(1-\lambda_k^2)$ is non-positive everywhere and zero on $\Lambda^+$, and $\mathop{\mathrm{tr}}\mathrm{Alt}(W^2)$ and $\langle W,\mathrm{Alt}(W^2)\rangle$ both return zero to $3\times10^{-17}$. This screens the arithmetic, and the derivations above are what establish the findings.

## Verdict

**CONFIRMED AS ALGEBRA**, with four surrounding claims **REFUTED**.

The identity of the first display is correct as stated, at every symmetric operator on $\Lambda^2\mathbb R^n$ and with no hypothesis of any kind, and its three-line proof is sound with every constant reproduced independently. The second display and the boxed bound follow, and the boxed bound is correct at every index. The correction to [diagonal-half.md](../findings/diagonal-half.md) is right in substance and confirmed against that file's own recorded figure.

Four assertions in the surrounding notes require repair, none of them touching the lemma:

1. **The boxed right side is $\le1$ at unit norm**, by hollowness and the pair cap [L31](../findings/stratum-two-negative.md) in one line, so the question the block records as OPEN is closed.
2. **The two bounds are nested rather than independent.** L199's bound is [L198](../findings/bounds.md)'s upper half with $S_k$ retained instead of capped, so it dominates that half at every index and is strictly stronger wherever the cap has slack. L198's lower half and its corollary stay out of reach of $g_k\ge0$, so L199 refines L198 rather than subsuming it.
3. **The evaluation "$0$ at the rest" at padded $W_{\mathbb{CP}^2}$ holds at $n=4$ and fails at every $n>4$**, where each of the $4(n-4)$ mixed indices carries $\tfrac14$. The index sum closes at $n-1$ at every $n$ only because those $\tfrac14$s are there.
4. **The two moment sums cannot pin the coefficient $12$**, being identically blind to it, because $\mathop{\mathrm{tr}}\mathrm{Alt}(X)=0$ for every symmetric $X$ and $\langle W,\mathrm{Alt}(W^2)\rangle=0$ for every Weyl $W$. The moments also consume relation (B) and therefore a Weyl hypothesis, which the block's scope banner covers only for the display.
