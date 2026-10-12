# r974: Gate 2 review of L230, the singular locus of the entrywise square against the split locus

Reviewer **r974**, working from [BRIEF_L230_singular_locus.md](BRIEF_L230_singular_locus.md) alone. Log: [agent_logs/r974-singular-locus.log](../agent_logs/r974-singular-locus.log).

**Headline.** The witness is real and the $k=4$ conclusion stands, but the block's quantifier does not. **The dimension count proves non-injectivity at $k=3$ and $k=4$ ONLY**, and the Statement's "at every $k$" is not merely unproved, it is FALSE: r974 exhibits an exact $Q\in O(5)$ with zero diagonal, every other entry nonzero, at which $d\varphi_r$ is injective. The route conclusion survives at $\lvert J\rvert=4$ and is not established for $\lvert J\rvert\ge5$.

## Verdicts

| # | claim | kind | verdict |
|---|---|---|---|
| 1 | tangent space $\{Q\Omega\}$ and differential $Z\mapsto2\,Q\circ Z$ | mathematics | **CONFIRMED** |
| 2 | zero diagonal of $Q$ kills the diagonal of the image, every $\Omega$, every $k$ | mathematics | **CONFIRMED**, and not vacuous, though its whole content is the inclusion it feeds |
| 3 | image dimension $\le(k-1)^2-k$, hence non-injective at every $k\ge3$ | mathematics | **REFUTED**. The bound is right and tight, the quantifier is wrong: the inequality holds at $k=3,4$ and fails at every $k\ge5$, where the conclusion is false outright |
| 4 | at $k=3$ no zero-diagonal orthogonal matrix has all off-diagonal entries nonzero | mathematics | **CONFIRMED**, and stronger than stated |
| 5 | the $4\times4$ $M$ satisfies $MM^{\mathsf T}=3I$, zero diagonal, all else nonzero | mathematics | **CONFIRMED** by hand |
| 6 | $\Omega=\operatorname{diag}(-1,1,1,1)M$ is skew, nonzero, and kills the differential | mathematics | **CONFIRMED** by hand, kernel exactly one-dimensional, rank exactly $5$ |
| 7 | the witness does not split | mathematics | **CONFIRMED**, by a direct argument. The block's stated route needs the BIPARTITE support graph, which is the reading the block does not name |
| 8 | "singular implies splits" false at $k=4$, and R28's boundary-to-split step fails from $\lvert J\rvert=4$ | about a route | **PLAUSIBLE**. The $k=4$ half is true and is already contained in the block's own given. The route half needs a reading of R28's dichotomy the block does not state, and "from $\lvert J\rvert=4$" is established AT $\lvert J\rvert=4$ and nowhere above it |

## Claim 1, the tangent space and the differential

**CONFIRMED, and the brief's cheapest failure mode does not exist.** Differentiating $Q(t)^{\mathsf T}Q(t)=I$ gives $Q^{\mathsf T}Q'$ skew, so $Q'=Q\Omega$ with $\Omega$ skew. Differentiating $Q(t)Q(t)^{\mathsf T}=I$ gives $Q'Q^{\mathsf T}$ skew, so $Q'=SQ$ with $S$ skew. **These parametrise the SAME subspace**, since $Q\Omega=(Q\Omega Q^{\mathsf T})Q$ and $Q\Omega Q^{\mathsf T}$ is skew whenever $\Omega$ is, the conjugation being a bijection of the skew matrices. So the brief's item 2 worry, that the correct tangent might be $\Omega Q$ rather than $Q\Omega$, is void: either parametrisation sweeps the whole tangent space and the diagonal argument is indifferent to which is used.

The differential is right and carries no second term. $\varphi_r(Q)=Q\circ Q$ is a quadratic form in the entries, and the entrywise product is commutative, so $\tfrac{d}{dt}(Q\circ Q)=Q'\circ Q+Q\circ Q'=2\,Q\circ Q'$ exactly.

## Claim 2, the vanishing diagonal

**CONFIRMED, and genuine rather than a restatement, though its content is thinner than the block's presentation suggests.** $(2\,Q\circ Z)_{ii}=2Q_{ii}Z_{ii}=0$ when $Q_{ii}=0$, for EVERY $Z$, so the statement holds a fortiori for $Z=Q\Omega$ and needs neither orthogonality of $Q$ nor skewness of $\Omega$. That matches the Lean row for `dphi_diag_eq_zero`, which takes `Q i i = 0` as its only hypothesis, and the row is correctly described.

**What a vacuous version would look like**, and why this is not one: a vacuous version would conclude something about $Q$'s diagonal from a hypothesis about $Q$'s diagonal. This one transfers a hypothesis on the SOURCE to a conclusion on the IMAGE of the differential, and the transfer is what claim 3 consumes. Its proof is one line because the entrywise square is diagonal-preserving in the strong sense that the $(i,i)$ entry of the output depends only on the $(i,i)$ entry of the input. The load is entirely in claim 3, which asks whether the resulting subspace is small enough.

The two auxiliary conditions the block invokes are also true, and r974 checked them rather than assuming them. Row sums: $\sum_jQ_{ij}(Q\Omega)_{ij}=(Q\Omega^{\mathsf T}Q^{\mathsf T})_{ii}=-(Q\Omega Q^{\mathsf T})_{ii}=0$, since $Q\Omega Q^{\mathsf T}$ is skew. That uses orthogonality of $Q$. Column sums: $\sum_iQ_{ij}(Q\Omega)_{ij}=(Q^{\mathsf T}Q\Omega)_{jj}=\Omega_{jj}=0$. That uses skewness of $\Omega$.

## Claim 3, the dimension count: REFUTED on the quantifier

This is the load-bearing step, and it splits into a bound that is correct and a conclusion that is not.

### The bound is correct and tight

The brief asks whether the $k$ zero-diagonal conditions are independent of the row-sum and column-sum conditions and of each other. **They are, at every $k\ge3$.** Let $V=\{A:\text{all row sums }0,\text{ all column sums }0\}$, of dimension $(k-1)^2$. A dependency among the restrictions $\ell_i(A)=A_{ii}$ to $V$ is a nonzero $\lambda$ with $\sum_i\lambda_i\ell_i$ in the span of the row and column functionals, that is, a matrix identity $\operatorname{diag}(\lambda)=(a_i+b_j)_{ij}$ under the trace pairing. Off the diagonal this forces $a_i+b_j=0$ for all $i\ne j$. For $k\ge3$, given any $i$ there are two distinct $j,l\ne i$, so $b_j=b_l=-a_i$, and varying $i$ makes every $b_j$ equal to a single $b$ and every $a_i$ equal to $-b$. Then $\lambda_i=a_i+b_i=0$. Hence the $k$ functionals are independent on $V$ and

$$\dim\{A\in V:A_{ii}=0\ \forall i\}=(k-1)^2-k\qquad(k\ge3).$$

Verified independently as a rank computation at $k=2,\dots,7$, which also shows the count breaks at $k=2$ exactly where the argument above needs $k\ge3$: at $k=2$ the two diagonal functionals agree on $V$, so the honest dimension is $0$ rather than $(k-1)^2-k=-1$.

**The bound is tight at the witness.** The rank of $d\varphi_r$ at $3^{-1/2}M$ is exactly $5=(k-1)^2-k$, so the containing subspace is filled and no sharper bound of this kind exists at $k=4$.

### The conclusion is FALSE from $k=5$

$(k-1)^2-k<\binom k2$ is $k^2-3k+1<\tfrac{k^2-k}2$, that is $k^2-5k+2<0$, that is $k<\tfrac{5+\sqrt{17}}2\approx4.561$. So:

| $k$ | $(k-1)^2-k$ | $\binom k2$ | drop? |
|---|---|---|---|
| 3 | 1 | 3 | yes |
| 4 | 5 | 6 | yes |
| 5 | 11 | 10 | **no** |
| 6 | 19 | 15 | **no** |

**"which holds at every $k\ge3$" is wrong.** It holds at $k=3$ and $k=4$ and at no larger $k$. The brief asks separately whether a weaker bound would rescue the conclusion: it would not, because the bound in hand is already tight at $k=4$ and the gap at $k\ge5$ runs the wrong way by a margin that grows like $k^2/2$.

### Worse, the Statement itself is false at $k=5$

The block's Statement asserts that a zero-diagonal $Q$ is singular **at every $k$**. It is not.

**Structure first.** When every off-diagonal entry of $Q$ is nonzero, the kernel is exactly computable. $Q\circ(Q\Omega)=0$ forces $Q\Omega=D$ diagonal, so $\Omega=Q^{\mathsf T}D$, and skewness of $Q^{\mathsf T}D$ is precisely

$$Q_{ij}d_i+Q_{ji}d_j=0\quad\text{for every }i<j,$$

a system of $\binom k2$ equations in $k$ unknowns whose diagonal conditions $2Q_{ii}d_i=0$ are automatic. The kernel of $d\varphi_r$ is isomorphic to the solution space, $Q$ being invertible. At $k=4$ the system is $6\times4$ and the witness is the case where it degenerates. At $k=5$ it is $10\times5$ and there is no reason for it to degenerate.

**An exact counterexample at $k=5$.** Take the circulant $Q$ whose first row is

$$\tfrac1N\,(0,\;1,\;-\tfrac{1+\sqrt3}2,\;1,\;1+\sqrt3),\qquad N^2=7+\tfrac52\sqrt3 .$$

Orthogonality of a circulant is the vanishing of the autocorrelations, which for a first row $(0,p,q,r,s)$ read $pq+qr+rs=0$ and $pr+qs+sp=0$. With $p=r=1$ and $q=-s/2$ the first is identically zero and the second is $1+s-\tfrac{s^2}2=0$, that is $s^2-2s-2=0$, solved by $s=1+\sqrt3$. The diagonal is zero by $c_0=0$ and every other entry is nonzero.

**It is a regular point.** For a circulant, $Q_{i,i+1}=c_1=1$ and $Q_{i+1,i}=c_4=s$, so the pair equation on consecutive indices is $d_i+s\,d_{i+1}=0$, hence $d_{i+1}=-d_i/s$ around the whole $5$-cycle. Five steps return to the start and give $d_i=(-1/s)^5d_i=-d_i/s^5$, and $s>0$ makes $1+s^{-5}\ne0$, so $d=0$. **The kernel is trivial and $d\varphi_r$ is injective at $Q$.** Confirmed symbolically in sympy: $QQ^{\mathsf T}=I$ exactly, zero diagonal, all off-diagonal entries nonzero, pair-system rank $5$ of $5$, and $\operatorname{rank}d\varphi_r=10=\dim O(5)$.

Consistency note, not part of the proof: this $Q$ has all off-diagonal entries nonzero, so it does not split, and Theorem 2.2 is respected rather than contradicted.

**Screen, reported as a screen and not as evidence.** A least-squares search over $400$ random starts hit zero-diagonal orthogonal matrices at $k=5,6,7$ from every start, and the best-separated hit at each size had FULL rank $d\varphi_r$ ($10$ of $10$, $15$ of $15$, $21$ of $21$) with a pair system of trivial kernel. This suggests the failure is generic rather than a single accident, but the claim above rests on the exact $k=5$ matrix, not on the screen.

### What claim 3 should say

Restrict to $k\le4$. The correct statement is: **at $k=3$ and $k=4$, a zero-diagonal $Q\in O(k)$ is a singular point of $\varphi_r$**, because the image of $d\varphi_r$ lies in a subspace of dimension $(k-1)^2-k$, which is $1<3$ and $5<6$ respectively. Nothing about $k\ge5$ follows, and at $k=5$ the opposite holds at an explicit point. The Lean row for claim 3 says the rank statement is not typed and is screened at $k=4$ only, which is the right scope, but the prose statement it accompanies is not.

One further imprecision worth fixing. The block invokes the tangent space to the bistochastic matrices **at an interior point**, while the witness maps to $\tfrac13(J-I)$, which has zero entries and is therefore on the boundary of $B_4$. The repair is free: use the direction space of the affine hull of $B_k$, which has dimension $(k-1)^2$ at every point of $B_k$, interior or not.

## Claim 4, emptiness at $k=3$

**CONFIRMED, and the block understates it.** With rows $(0,a,b)$ and $(c,0,d)$ the inner product is $0\cdot c+a\cdot0+bd=bd$, the pairing is as written, and $bd=0$ forces $b=0$ or $d=0$, both off-diagonal positions ($Q_{13}$ and $Q_{23}$).

The brief asks whether orthogonality of the whole matrix is needed. **It is not.** The argument uses one inner product, so the true hypothesis is that the matrix has zero diagonal and two orthogonal rows. That is what the Lean row describes, `no_second_type_at_three` over four plain reals with the single equation `0 * a + a * 0 + b * d = 0`, so the Lean statement is the strong one and the prose is the weak one.

## Claim 5, the witness

**CONFIRMED by hand.** Every row of $M$ has three entries of modulus $1$ and one zero, so every diagonal entry of $MM^{\mathsf T}$ is $3$. The six off-diagonal inner products are $r_1r_2=-1+1=0$, $r_1r_3=1-1=0$, $r_1r_4=-1+1=0$, $r_2r_3=1-1=0$, $r_2r_4=1-1=0$, $r_3r_4=1-1=0$. So $MM^{\mathsf T}=3I$, $Q=3^{-1/2}M\in O(4)$, the diagonal is zero, and every other entry is $\pm3^{-1/2}$. Hence $Q^{\circ2}=\tfrac13(J-I)$, which is bistochastic with row and column sums $1$. $M$ is a conference matrix of order $4$, which is why the construction exists at $4$ and what makes it a fact about that order rather than a general one.

## Claim 6, the kernel

**CONFIRMED by hand, and the kernel is exactly one-dimensional.**

$\Omega=\operatorname{diag}(-1,1,1,1)M$ has rows $(0,-1,-1,-1)$, $(1,0,-1,1)$, $(1,1,0,-1)$, $(1,-1,1,0)$. Checking the six pairs: $(\Omega_{12},\Omega_{21})=(-1,1)$, $(\Omega_{13},\Omega_{31})=(-1,1)$, $(\Omega_{14},\Omega_{41})=(-1,1)$, $(\Omega_{23},\Omega_{32})=(-1,1)$, $(\Omega_{24},\Omega_{42})=(1,-1)$, $(\Omega_{34},\Omega_{43})=(-1,1)$. Skew, with a zero diagonal, and manifestly nonzero. Computing $M\Omega$ column by column gives $\operatorname{diag}(3,-3,-3,-3)$, so $M\circ(M\Omega)=0$ because $M$ has zero diagonal and $M\Omega$ has nothing off it. The witness is singular.

**Is the derivation valid, or one solution among many?** It is valid and the solution is unique up to scale. Via the pair system of claim 3, the three equations from $i=1$ read $d_1+d_2=0$, $d_1+d_3=0$, $d_1+d_4=0$, which already pin $d=d_1(1,-1,-1,-1)$, and the remaining three, $-d_2+d_3=0$, $d_2-d_4=0$, $-d_3+d_4=0$, are then satisfied. So the kernel is exactly one-dimensional and $\operatorname{rank}d\varphi_r=6-1=5$, which is the block's number and also the claim-3 bound, so the bound is attained.

**One correction of phrasing.** The block says skewness "pins $D=3\operatorname{diag}(1,-1,-1,-1)$". Skewness pins $D$ only up to a scalar, the kernel being a line. The factor $3$ is a normalisation that makes $\Omega$ integral, not a consequence. This is harmless, but "pins" should read "pins up to scale", and stating the kernel dimension is worth more than the particular representative.

## Claim 7, non-splitting

**CONFIRMED, by an argument that does not go through a graph at all.**

$Q$ splits when there are partitions of the rows into $I,I^c$ and of the columns into $J,J^c$, all four parts nonempty with $\lvert I\rvert=\lvert J\rvert$, such that $Q$ vanishes on $I\times J^c$ and on $I^c\times J$. The only zeros of the witness are the four diagonal positions. If $\lvert I\rvert\ge2$ and $\lvert J^c\rvert\ge1$ then $I\times J^c$ contains two positions in one column, and a column holds only one diagonal position, so not all of them can be zero. Hence $\lvert I\rvert=1$, so $\lvert J\rvert=1$ and $\lvert J^c\rvert=3$, and then $\{i\}\times J^c$ is three positions in one row, of which at most one is diagonal. Contradiction either way. **The witness does not split.**

**On the block's own route, which the brief asks about.** "Does not split" via a connected support graph is correct only under the BIPARTITE reading, rows and columns as two vertex classes with an edge at each nonzero entry, because the source's definition permutes rows and columns INDEPENDENTLY. The one-vertex-class reading, an edge $i\sim j$ when $Q_{ij}\ne0$, corresponds to indecomposability under a SIMULTANEOUS permutation, which is a different notion and would not license the conclusion. The block names neither. Under the bipartite reading the implication the block needs, connected implies no split, is the easy direction, since a split exhibits a separation. The converse also holds here for orthogonal $Q$, each component $(I_t,J_t)$ having $\lvert I_t\rvert\le\lvert J_t\rvert$ from orthonormality of its rows and equality by summing, but the block does not need it.

The Lean row is honest about the gap: `image_offdiag_ne` types that every off-diagonal entry of $M\circ M$ is nonzero and the passage to the absence of a permuted direct sum is not typed. The argument above is what would have to be typed, and it is finitary at fixed $k$.

## Claim 8, the route

**PLAUSIBLE. Two separate deficiencies, one of quantifier and one of object.**

### The mathematical half is true and is already given

"Singular implies splits" is false at $k=4$: claims 5, 6 and 7 together exhibit a singular non-splitting point. **But this is already the content of the block's own Theorem 2.6**, quoted in the brief as a given and not under review, which says that at $n=4$ there are TWO types of singular point, the split ones and the ones equivalent to a zero-diagonal matrix with all other entries nonzero. The block's added value is therefore an explicit member of the second type, an explicit kernel element, and the rank number $5$, rather than the refutation itself. That is worth having and should be described as what it is.

### The route half needs a reading the block does not state

R28 needs the maximum to sit on the BOUNDARY OF THE IMAGE and then needs that boundary to be the split locus. The block establishes a fact about the SINGULAR LOCUS OF THE MAP. **These are not the same set, and the valid relation runs in the direction that permits the block's conclusion to fail.**

- The inclusion that is true is $\partial X\subseteq\varphi_r(\Sigma)$, with $X=\varphi_r(O(k))$ and $\Sigma$ the singular set. At an immersion point $\varphi_r$ is a local embedding, so the image locally contains an embedded disk of dimension $\binom k2$ around $\varphi_r(Q)$, and a point all of whose preimages are immersion points is interior to a full-dimensional sheet of $X$.
- The inclusion the block's conclusion would need is the reverse, $\varphi_r(\Sigma)\subseteq\partial X$, and that is false in general. **So $\Sigma$ strictly containing the split locus does NOT by itself make $\partial X$ strictly contain it.** The second stratum could map into the relative interior of $X$, leaving R28's arrow intact. The block does not rule this out, and r974 could not settle it within the standing analysis-only rule, the question being the local type of a corank-one critical point of $\varphi_r$ at $\tfrac13(J-I)$.
- A related warning about the literal reading. $\dim O(3)=3<4$ and $\dim O(4)=6<9$, both against the dimension of the affine hull of $B_k$. **So $X$ has empty interior in $B_k$ already at $\lvert J\rvert=3$, and every point of $X$ is a topological boundary point of $X$ in $B_k$.** Read literally against the polytope, "the maximum is on the boundary of the image" is vacuous at every rung the route uses, so it must mean something else.

**The reading that rescues both.** At a maximiser $Q$ of a linear functional $\ell$ pulled back to $O(k)$, the exhaustive dichotomy is on the RANK: either $d\varphi_r$ is injective at $Q$, in which case the first-order condition is a genuine tangency of the local image sheet to the level hyperplane of $\ell$, or $d\varphi_r$ is singular at $Q$. Under that reading R28's "interior tangency" and "boundary" are exactly the two rank cases, the block's object is the right one, and the block's conclusion lands as stated. **r974's recommendation is that R28 state its dichotomy on the rank of $d\varphi_r$ rather than on the frontier of the image**, at which point claim 8's $k=4$ half is established and needs no further work.

### The quantifier

Even granting the reading, **"fails from $\lvert J\rvert=4$" is established AT $\lvert J\rvert=4$ and at no larger $\lvert J\rvert$.** The block's only ground for $\lvert J\rvert\ge5$ is claim 3's false quantifier, and Theorem 2.6 is an $n=4$ statement. Worse, r974's $k=5$ matrix shows that the specific family the block uses to populate the second stratum, zero-diagonal with all other entries nonzero, is NOT a family of singular points at $k=5$. So the second stratum at $\lvert J\rvert\ge5$ is currently unpopulated, by this block or by its givens. Whether the route's rung is non-uniform is settled, one failing rung being enough, but the shape of the failure above $\lvert J\rvert=4$ is open.

## Summary of required corrections

1. **Claim 3, mandatory.** Replace "which holds at every $k\ge3$" with "which holds at $k=3$ and $k=4$, and fails at every $k\ge5$, the inequality being $k^2-5k+2<0$". Replace the Statement's "at every $k$" with "at $k\le4$", and record that it is FALSE at $k=5$ with the circulant above as the counterexample. Keep the bound $(k-1)^2-k$, which is correct, independent of the row and column sums, and tight at the witness.
2. **Claim 3, minor.** Use the direction space of the affine hull of $B_k$ rather than the tangent space at an interior point, the witness's image having zero entries.
3. **Claim 6, minor.** "Pins $D$" should read "pins $D$ up to scale". Record the kernel dimension, one, which is the content.
4. **Claim 7, minor.** Name the support graph as bipartite, rows against columns, or replace the graph by the two-line counting argument above, which is what the Lean gap would need.
5. **Claim 8, substantive.** Either state R28's dichotomy on the rank of $d\varphi_r$, which makes the block's object the right one, or prove that the second stratum meets the frontier of the image. Restrict "from $\lvert J\rvert=4$" to "at $\lvert J\rvert=4$". Credit Theorem 2.6 for the refutation and the block for the witness.

## Computation declared

All of it on objects constructed for the purpose, seconds each, under the screening allowance.

- An exact rank count of the row-sum, column-sum and diagonal functionals at $k=2,\dots,7$, confirming the independence proved by hand.
- Symbolic verification in sympy of the $k=5$ circulant: orthogonality, zero diagonal, all off-diagonal entries nonzero, pair-system rank $5$, and $\operatorname{rank}d\varphi_r=10$. This is exact, so it is cited as proof rather than as a screen.
- Numerical verification of the $k=4$ witness, its kernel dimension and its rank $5$, all of which were also done by hand above.
- A least-squares screen at $k=5,6,7$, $400$ starts each, reported in claim 3 as a screen only.
