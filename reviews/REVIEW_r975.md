# r975: Gate 2 on L230, does the singular locus of the entrywise square strictly contain the split locus, and from which $k$?

Reviewer **r975**, working from [BRIEF_L230_singular_locus.md](BRIEF_L230_singular_locus.md) and the mathematics alone. Log: [agent_logs/r975-singular-locus.log](../agent_logs/r975-singular-locus.log).

## Headline

**The $k=4$ half of the block is correct in every part and the "at every $k$" half is false.** The mechanism buys non-injectivity only at $k=3$ and $k=4$, because the inequality $(k-1)^2-k<\binom k2$ fails at every $k\ge5$, and the failure is not an artefact of a lossy bound: at $k=6$ the normalised Paley conference matrix is a zero-diagonal orthogonal matrix with every off-diagonal entry nonzero at which $d\varphi_r$ has **full** rank $15$. That is a regular point of exactly the shape the Statement declares singular.

**The route conclusion is right and the route argument is wrong.** R28 needs a statement about the boundary of the IMAGE and the block supplies one about the singular locus of the MAP, and those are not the same set here: the same $k=6$ matrix maps to a boundary point of the orthostochastic set all of whose preimages are regular. A replacement argument that does reach R28 is given in [section 8](#8-claim-8-the-route) and rests on the linear functional $\mathop{\mathrm{tr}}$ rather than on any rank.

## Verdicts

| # | claim | kind | verdict |
|---|---|---|---|
| 1 | The tangent space to $O(k)$ at $Q$ is $\{Q\Omega:\Omega$ skew$\}$ and $d\varphi_r$ sends it to $2\,Q\circ(Q\Omega)$ | mathematics | **CONFIRMED** |
| 2 | At a zero-diagonal $Q$ every diagonal entry of that image vanishes, for every $\Omega$ and every $k$ | mathematics | **CONFIRMED**, and non-vacuous, though it carries no singularity on its own |
| 3 | Hence the image has dimension at most $(k-1)^2-k$, so $d\varphi_r$ is non-injective at every $k\ge3$ | mathematics | **REFUTED**. The bound is correct and sharp in its independence, the inequality holds only at $k\le4$, and the conclusion is false from $k=6$ by explicit witness |
| 4 | At $k=3$ a zero-diagonal orthogonal matrix cannot have all off-diagonal entries nonzero | mathematics | **CONFIRMED**, and it needs only two orthogonal rows |
| 5 | The stated $4\times4$ $M$ satisfies $MM^{\mathsf T}=3I$, has zero diagonal, and every other entry nonzero | mathematics | **CONFIRMED** |
| 6 | $\Omega=\mathop{\mathrm{diag}}(-1,1,1,1)M$ is skew, nonzero, and satisfies $M\odot(M\Omega)=0$, so the witness is singular | mathematics | **CONFIRMED**, and the kernel is exactly one-dimensional, so $\mathop{\mathrm{rank}}d\varphi_r=5$ |
| 7 | The witness does not split | mathematics | **CONFIRMED**, on the bipartite reading of "support graph", which is the reading the source's definition requires |
| 8 | Hence "singular implies splits" is false at $k=4$, and R28's boundary-to-split-locus step fails from $\lvert J\rvert=4$ | about a route | **CONFIRMED as a conclusion, REFUTED as an inference**. Both halves are true, the "hence" does not deliver the second, and a correct argument for it is supplied below |

## 1. Claim 1, the tangent space and the differential

**CONFIRMED, and the brief's cheapest-failure worry does not arise, because the two parametrisations name the same space.** $T_QO(k)=\{X:X^{\mathsf T}Q+Q^{\mathsf T}X=0\}$, and for skew $\Omega$ both $Q\Omega$ and $\Omega Q$ satisfy it. The two sets coincide: given skew $\Omega$, the matrix $\Omega'=Q\Omega Q^{\mathsf T}$ is skew and $Q\Omega=\Omega'Q$. So the question "if the correct tangent is $\Omega Q$, does the diagonal argument still work" is empty, since $\{Q\Omega\}=\{\Omega Q\}=T_QO(k)$ and the argument of claim 2 applies to an arbitrary tangent vector $Z$ regardless of which name it is given.

The differential is right and has no second term. $\varphi_r(Q)=Q\circ Q$ is a symmetric bilinear expression in $Q$, so $\tfrac{d}{dt}\big|_{0}(Q+tZ)\circ(Q+tZ)=Q\circ Z+Z\circ Q=2\,Q\circ Z$. The Hadamard product is commutative, which is where the factor $2$ comes from and why nothing else survives.

## 2. Claim 2, the diagonal collapse, and whether it is vacuous

**CONFIRMED.** $\big(2\,Q\circ Z\big)_{ii}=2Q_{ii}Z_{ii}$ for any $Z$ whatever, so $Q_{ii}=0$ kills it. The Lean statement `dphi_diag_eq_zero` is correctly typed with `Q i i = 0` as its only hypothesis, and that minimal hypothesis is honest rather than a smell: orthogonality of $Q$ and skewness of $\Omega$ genuinely play no part.

**What vacuity would look like here, and why this is not it.** The claim would be vacuous if the $k$ conditions it imposes were already implied by the zero row-sum and zero column-sum conditions that every tangent to the bistochastic matrices satisfies, in which case the "further $k$ linear conditions" of claim 3 would be zero further conditions and the bound would collapse to $(k-1)^2$. They are not implied, and I check that in section 3. What is fair to say against the block is narrower: claim 2 is a statement about the Hadamard product and not about $\varphi_r$, it holds pointwise for every $Z$ in the whole ambient matrix space, and by itself it produces no singularity at all. Every gram of singularity in the block comes from the counting of claim 3, which is where the block breaks.

## 3. Claim 3, the load-bearing step

**REFUTED**, in the one place that matters, and I separate the three sub-claims because they do not stand or fall together.

**(a) The $k$ diagonal conditions are independent of the row and column sums and of each other, for every $k\ge3$.** Let $V=\{X:\text{all row sums }0,\text{ all column sums }0\}$, of dimension $(k-1)^2$. A functional $X\mapsto\sum_ic_iX_{ii}$ vanishes on $V$ exactly when its coefficient matrix $\mathop{\mathrm{diag}}(c)$ lies in the span of the row-sum and column-sum coefficient matrices, that is when $c_i\delta_{ij}=a_i+b_j$ for some $a,b$. Off the diagonal this reads $a_i+b_j=0$ for all $i\ne j$, which at $k\ge3$ forces all the $b_j$ equal to a common $b$ and all $a_i=-b$, and then the diagonal reads $c_i=a_i+b_i=-b+b=0$. So $c=0$, the $k$ functionals are independent modulo $V$'s defining pair, and $\dim\le(k-1)^2-k$ is correct and not improvable by this route. Screened by direct rank computation at $k=3,\dots,8$, which returns $(k-1)^2-k$ exactly: $1,5,11,19,29,41$. **So the bound itself survives.**

**(b) The inequality holds at $k=3$ and $k=4$ and at no larger $k$.** $(k-1)^2-k-\binom k2=\tfrac12\big(k^2-5k+2\big)$, whose roots are $\tfrac{5\pm\sqrt{17}}2\approx0.44$ and $\approx4.56$. The expression is negative exactly for $1\le k\le4$.

| $k$ | $(k-1)^2-k$ | $\binom k2$ | strict? |
|---|---|---|---|
| 3 | 1 | 3 | yes |
| 4 | 5 | 6 | yes |
| 5 | 11 | 10 | **no** |
| 6 | 19 | 15 | **no** |
| 7 | 29 | 21 | **no** |
| 8 | 41 | 28 | **no** |

**The phrase "which holds at every $k\ge3$" is false, and by a margin that grows.** The brief asks whether the conclusion survives a weaker bound: it does not, because the bound is already the strongest this mechanism can give by (a), and it is the mechanism that runs out, not the estimate.

**(c) The Statement's "at every $k$" is false, and not merely unproved.** The following is the general fact, and it is three lines.

> **Lemma (r975).** Let $k\ge3$ and let $Q\in O(k)$ be **symmetric**, with zero diagonal and every off-diagonal entry nonzero. Then $d\varphi_r$ is injective at $Q$, so $Q$ is a regular point.
>
> *Proof.* Suppose $Q\circ(Q\Omega)=0$ with $\Omega$ skew. Every off-diagonal entry of $Q$ is nonzero, so $(Q\Omega)_{ij}=0$ at every $i\ne j$ and $Q\Omega=D$ is diagonal. Then $\Omega=Q^{\mathsf T}D=QD$, and skewness $\Omega^{\mathsf T}=-\Omega$ reads $DQ=-QD$, entrywise $d_iQ_{ij}=-Q_{ij}d_j$. At $i\ne j$ the factor $Q_{ij}$ is nonzero, so $d_i=-d_j$ for every $i\ne j$. With three distinct indices that gives $d_3=-d_1=d_2=-d_3$, hence $d=0$, hence $\Omega=0$. $\square$

**Such a $Q$ exists at $k=6$.** Take the symmetric Paley conference matrix $C$ of order $6$ built from the quadratic-residue character mod $5$, with $C$ symmetric, $C_{ii}=0$, every off-diagonal entry $\pm1$, and $CC^{\mathsf T}=5I$. Then $Q=C/\sqrt5\in O(6)$ meets the lemma's hypotheses, and the screen returns $\mathop{\mathrm{rank}}d\varphi_r=15=\dim O(6)$, full rank, in agreement with the lemma. **So a zero-diagonal orthogonal matrix can be a regular point, and the Statement's "Then $Q$ is a singular point of $\varphi_r$, at every $k$" is refuted at $k=6$.**

**A consistency check that the lemma does not contradict the given Theorem 2.6.** The lemma would clash with Theorem 2.6 if a symmetric $Q\in O(4)$ with zero diagonal and all entries nonzero existed. None does. Such a $Q$ satisfies $Q^2=I$ with trace $0$, so $Q=I-2P$ with $P$ an orthogonal projection of rank $2$, $P_{ii}=\tfrac12$ and $P_{ij}\ne0$ off the diagonal. Writing $P=VV^{\mathsf T}$ with $V$ a $4\times2$ matrix of orthonormal columns, each row of $V$ is $\tfrac1{\sqrt2}(\cos\theta_i,\sin\theta_i)$ and orthonormality of the columns says $\sum_ie^{2\mathrm i\theta_i}=0$. Four unit vectors in the plane summing to zero always form two antipodal pairs, so some $2\theta_i-2\theta_j=\pi$, giving $P_{ij}=\tfrac12\cos(\theta_i-\theta_j)=0$. The lemma and Theorem 2.6 agree, as they must.

**What survives of claim 3.** The dimension bound and its independence, and the conclusion at $k=3$ and $k=4$ only. The correct reading of the mechanism is that it detects the two small cases and says nothing from $k=5$ up, which is precisely the range where Theorems 2.4 and 2.6 stop as well.

## 4. Claim 4, emptiness at $k=3$

**CONFIRMED.** With first two rows $(0,a,b)$ and $(c,0,d)$, the inner product is $0\cdot c+a\cdot0+bd=bd$, so $bd=0$. The pairing is exactly as stated: the first two terms die because each pairs a diagonal zero against something, and only the third column contributes.

**It needs strictly less than orthogonality of $Q$.** Only the orthogonality of rows $1$ and $2$ is used, and normalisation is never used. The Lean declaration `no_second_type_at_three`, taking four plain reals and the hypothesis written out as `0 * c + a * 0 + b * d = 0`, types the claim at exactly this strength, which is the right choice.

## 5. Claim 5, the witness

**CONFIRMED by hand.** With rows $r_1=(0,1,1,1)$, $r_2=(1,0,-1,1)$, $r_3=(1,1,0,-1)$, $r_4=(1,-1,1,0)$: each $r_i\cdot r_i=3$, and $r_1\cdot r_2=0+0-1+1=0$, $r_1\cdot r_3=0+1+0-1=0$, $r_1\cdot r_4=0-1+1+0=0$, $r_2\cdot r_3=1+0+0-1=0$, $r_2\cdot r_4=1+0-1+0=0$, $r_3\cdot r_4=1-1+0+0=0$. So $MM^{\mathsf T}=3I$, the diagonal is zero, and every other entry is $\pm1$.

## 6. Claim 6, the kernel, checked by hand

**CONFIRMED, and the kernel is exactly one-dimensional.**

**$\Omega$ is skew and nonzero.** $\Omega=\mathop{\mathrm{diag}}(-1,1,1,1)M$ negates the first row of $M$ and leaves the rest. Its diagonal is zero because $M$'s is. The six off-diagonal pairs: $(\Omega_{12},\Omega_{21})=(-1,1)$, $(\Omega_{13},\Omega_{31})=(-1,1)$, $(\Omega_{14},\Omega_{41})=(-1,1)$, $(\Omega_{23},\Omega_{32})=(-1,1)$, $(\Omega_{24},\Omega_{42})=(1,-1)$, $(\Omega_{34},\Omega_{43})=(-1,1)$. Each pair sums to zero, so $\Omega^{\mathsf T}=-\Omega$, and $\Omega\ne0$.

**$M\odot(M\Omega)=0$.** $\Omega=\mathop{\mathrm{diag}}(-1,1,1,1)M=M^{\mathsf T}\mathop{\mathrm{diag}}(1,-1,-1,-1)$, the two expressions agreeing entrywise because $M_{ji}D_j=E_iM_{ij}$ holds on each of the six pairs. Hence $M\Omega=MM^{\mathsf T}\mathop{\mathrm{diag}}(1,-1,-1,-1)=\mathop{\mathrm{diag}}(3,-3,-3,-3)$, which is diagonal, and $M$ has zero diagonal, so the Hadamard product vanishes identically. Screened: the rank of $d\varphi_r$ at $M/\sqrt3$ is $5$ against $\dim O(4)=6$, as the Statement says.

**The derivation that pins $\Omega$ is valid and the solution is unique up to scale.** Since every off-diagonal entry of $M$ is nonzero, a kernel element forces $M\Omega=D$ diagonal, so $\Omega=\tfrac13M^{\mathsf T}D$, and skewness gives $d_iM_{ij}=-M_{ji}d_j$ at every $i\ne j$. The three pairs through index $1$ give $d_2=d_3=d_4=-d_1$, and the remaining three pairs $(2,3),(2,4),(3,4)$ are then satisfied rather than over-determining, which is exactly why a witness exists at all. **So the kernel is one-dimensional, not larger**, and the rank is $6-1=5$ with no slack. Note that this exhibits the singularity directly and does not go through the dimension count of claim 3, so **claim 6 is independent of the defect in claim 3** and the $k=4$ result stands on it alone.

## 7. Claim 7, splitting, and the definition question

**CONFIRMED, once "support graph" is read bipartitely, which is the reading the source's definition forces.**

**The equivalence the block leans on is real, for orthogonal matrices.** $Q$ splits when row and column permutations, chosen INDEPENDENTLY, put it in block-diagonal form, which says exactly that there are partitions $R=R_1\sqcup R_2$ and $C=C_1\sqcup C_2$ with $Q$ vanishing on $R_1\times C_2$ and on $R_2\times C_1$. That is disconnection of the bipartite graph on rows and columns with an edge at each nonzero entry. Two facts make the equivalence clean here and both use orthogonality. Every row and every column of $Q$ is nonzero, so no vertex is isolated and every component carries both rows and columns, which is what keeps both blocks nonempty. And $|R_1|=|C_1|$ comes free, because the rows in $R_1$ live in the coordinate subspace $C_1$ giving $|R_1|\le|C_1|$, and the rows in $R_2$ live in $C_2$ giving $k-|R_1|\le k-|C_1|$. **A digraph reading, with one index set and a single simultaneous permutation, would be a different and stronger notion, and the block does not need it.**

**The block's own argument is sound and can be made even shorter by counting.** A split $Q$ at size $k$ has at least $2a(k-a)\ge2(k-1)$ zero entries. The witness has exactly $4$ zeros and $2\cdot3=6>4$, so it does not split. The block argues via $Q^{\circ2}$ rather than $Q$, which is harmless because squaring entrywise preserves the support exactly.

**The Lean row is honestly labelled.** `image_offdiag_ne` types the nonvanishing of the off-diagonal entries, and the brief correctly records that the passage to the absence of a permuted direct-sum decomposition is not typed. The counting argument above is the missing passage and it is elementary, so this is a gap in the formalisation and not in the mathematics.

## 8. Claim 8, the route

This is the item the brief asks me to settle, and the answer has two parts that point in opposite directions.

**Part one, the mathematical half, is CONFIRMED and is already contained in the given source.** The witness is singular by claim 6 and does not split by claim 7, so "singular implies splits" is false at $k=4$. Note that this is a rederivation of the second type in the given Theorem 2.6 rather than new information: Theorem 2.6 already says the second type at $n=4$ are the matrices equivalent to one with zero diagonal and all other entries nonzero, which is the witness. The block's value at $k=4$ is an explicit kernel element for a fact the source states, which is worth having and is not a new theorem.

**Part two, the route half, does NOT follow from claims 1 to 7 as the block argues it.** The block establishes a statement about the singular locus of the MAP and R28 needs one about the boundary of the IMAGE. Three things separate them here.

- **The ambient reading of "boundary of the image" is vacuous at every $k\ge3$.** $\dim O(k)=\binom k2<(k-1)^2=\dim\mathop{\mathrm{aff}}(B_k)$ for every $k>2$, so the orthostochastic set has empty interior in $B_k$ and its topological frontier in $B_k$ is the whole of it. Under this reading "the maximum sits on the boundary" carries no information at all, and the step R28 wants to make is not the step the block is attacking.
- **A boundary point need not have a singular preimage.** At $k=6$ the point $y_6=\tfrac15(J-I)$ is in the image, and every preimage of it is a matrix with zero diagonal and entries $\pm1/\sqrt5$, that is a conference matrix of order $6$ divided by $\sqrt5$. I enumerated these: normalising signs so that the first row and first column are $(0,1,1,1,1,1)$, orthogonality against the first row forces each later row to carry two $+1$ and two $-1$ among its four free entries, which leaves $6^5=7776$ candidates, of which exactly $12$ are conference matrices, all symmetric, and all with $\mathop{\mathrm{rank}}d\varphi_r=15$, full. Rank is invariant under $Q\mapsto D_1QD_2$ and $Q\mapsto PQR$ because $\varphi_r$ is unchanged by sign flips and equivariant under permutations, so **every** preimage of $y_6$ is a regular point. Yet $y_6$ is a boundary point, by the next bullet. So the inclusion the block's reasoning needs, boundary points being images of singular points, is false here.
- **A singular point need not map to a boundary point**, by the usual fold example, so the reverse inclusion is no better. The two sets are simply different objects and the block moves between them without a bridge.

**The conclusion nevertheless holds, by an argument that uses no rank at all.** Let $X_k=\varphi_r(O(k))$ and consider the linear functional $\mathop{\mathrm{tr}}$.

1. $\mathop{\mathrm{tr}}\varphi_r(Q)=\sum_iQ_{ii}^2\ge0$ on $X_k$, with equality exactly at the images of zero-diagonal $Q$.
2. $\mathop{\mathrm{tr}}$ is nonconstant on $X_k$, since $\varphi_r(I)=I$ has trace $k$.
3. Hence a point $y\in X_k$ with $\mathop{\mathrm{tr}}y=0$ lies in the boundary of $X_k$ relative to $\mathop{\mathrm{aff}}(X_k)$. If it did not, a neighbourhood of $y$ in $\mathop{\mathrm{aff}}(X_k)$ would sit inside $X_k$, so the affine function $\mathop{\mathrm{tr}}$ would attain a local minimum at an interior point of an affine set, forcing it constant on $\mathop{\mathrm{aff}}(X_k)$ and so on $X_k$, against (2). **This reading of "boundary" is the one R28 can actually use, and it is not vacuous.**
4. The image of a splitting $Q$ has at least $2a(k-a)\ge2(k-1)$ zero entries, while the image of a zero-diagonal $Q$ with all other entries nonzero has exactly $k$, and $k<2(k-1)$ for every $k\ge3$. So such an image is never the image of a splitting matrix.
5. At $k=4$ the witness supplies such a $y$, namely $\tfrac13(J-I)$ with $4$ zeros against a minimum of $6$. At $k=6$ the conference matrix supplies $y_6=\tfrac15(J-I)$ with $6$ zeros against a minimum of $10$.

**So R28's last arrow, from boundary of the image to split locus, is refuted at $\lvert J\rvert=4$ and again at $\lvert J\rvert=6$, and the refuting point at $\lvert J\rvert=6$ is a regular point of $\varphi_r$.** The block's verdict on the route is right. Its stated reason is not the reason, and it is worth being exact about this, because the singular-locus framing suggests the repair is to enumerate a second singular stratum, whereas the trace argument shows the obstruction is a whole face of the image and has nothing to do with rank.

**"From $\lvert J\rvert=4$" is established at $4$ and $6$ and left open at $5$.** The face argument needs a zero-diagonal $Q\in O(k)$ with fewer than $2(k-1)$ zeros, which I exhibit at $k=4$ and $k=6$ and have not settled at $k=5$. Deciding $k=5$ would be a search over a family rather than a check on an object in hand, so I record it as open rather than opening it.

## What the record should say

- **Keep** claims 1, 2, 4, 5, 6, 7 as stated, and keep the $k=4$ conclusion, noting that it rederives the given Theorem 2.6's second type rather than extending it.
- **Strike "at every $k$" from the Statement and strike "which holds at every $k\ge3$" from step 1**, replacing both with "at $k=3$ and $k=4$", since $(k-1)^2-k<\binom k2$ fails from $k=5$.
- **Record the $k=6$ regular witness**, the normalised order-$6$ symmetric Paley conference matrix, together with the lemma of section 3(c) that every symmetric zero-diagonal orthogonal matrix with all off-diagonal entries nonzero is regular at every $k\ge3$. It converts "unproved beyond $k=4$" into "false beyond $k=4$".
- **Replace the route paragraph.** The singular locus is the wrong object for R28. The right one is the face $\{\mathop{\mathrm{tr}}=0\}\cap X_k$ of the image, which contains non-split images at $k=4$ and $k=6$ and which is reached without any rank computation.

## Screens

All runs finish in under a second on objects constructed for the purpose, and each confirms a statement proved by hand above rather than standing as evidence on its own: the rank of $\{X:\text{row sums }0,\text{ column sums }0,\text{ diagonal }0\}$ at $k=3,\dots,8$, the rank of $d\varphi_r$ at $M/\sqrt3$, the conference identity $CC^{\mathsf T}=5I$ and the rank of $d\varphi_r$ at $C/\sqrt5$, and the enumeration of the $12$ normalised order-$6$ conference matrices with their ranks.

## The Lean file

[I106bSingularLocus.lean](../lean/HamiltonsCubic/Results/I106bSingularLocus.lean) carries the declarations the brief's table names, with no `sorry` and no added axiom. The table's two "none" rows are correctly reasoned, and one further gap deserves a line in the record: claim 3 has no Lean row because rank is not typed in this layer, and that is also the claim this review refutes. **The formalised content is precisely the part that survives.**
