# Reviewer 677, Observation L98, the diagonal floor $1+\frac1{2(n-3)(n-4)}$

**Review number: r677.** Target: [Observation L98](../findings/diagonal-half.md) at line 187 of [diagonal-half.md](../findings/diagonal-half.md), with the table beneath it (lines 189–205). Reviewer A of an independent pair on identical briefs; the companion takes r678 and was neither read nor contacted. Derived cold from [conventions.md](../findings/conventions.md); the block's own reasoning was read after the operator was rebuilt from the definitions.

**Analysis only.** Nothing here was computed. Every number below is a hand computation (closed forms for the second-order operator on the diagonal locus, evaluated at named points) and each is offered as derivation. Where an item needs a run to decide, it is named as blocked and left undecided.

## Verdict

**GAP.** The floor is **measured, not derived**, and the block presents as an equality something its own source ([r310](REVIEW_r310.md)) wrote with a question mark over it. A census establishes $\min\le$; the block asserts $=$. Three further defects, one of them live:

| # | finding | severity |
| --- | --- | --- |
| 1 | The hedge was lost. [r310](REVIEW_r310.md) writes $\min\lambda_{\max}(L_e)\overset{?}{=}1+\frac1{2(n-3)(n-4)}$; the fold-in dropped the $?$ and the numbering commit promoted the unhedged form to a **heading** | **the central defect** |
| 2 | "**The stronger reading $\Delta>0\Rightarrow\lambda_{\max}(L_e)\ge1$ survives**" is written **unscoped**, in the block whose job is the scope warning, and is **refuted three lines below by the block's own table** ($0.6089$, $0.5628$, $0.5535$) | **REFUTED as written** |
| 3 | "**provisional until polished**" and the headline "**off-locus cushion is $1.107\times$**" are both **stale**: [r314](REVIEW_r314.md) polished the $0.553481$ point to residual $1.9\times10^{-16}$ and certified a **lower** witness at $1.1027\times$, which [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) already carries and this block does not | **stale; report and findings now disagree** |
| 4 | The formula is singular at $n=3,4$ and neither is excluded. Both are in fact **vacuous**, and $n=4$ is provable by hand (§4), but the block says nothing, and $n=5$ is an untested prediction of $1.25$ | GAP |

**Eighth collapse: yes, but not of L98.** §3 gives closed forms that reproduce **nine** measured numbers elsewhere in the same file exactly, the whole diagonal-$\lambda_{\max}$ column of the line-132 table and all three padded rows at line 157. L98's own floor does not collapse, and §3.6 says precisely why.

## 1. Readings adopted

| symbol | reading taken | why |
| --- | --- | --- |
| $\mathcal W_n$, $Q$, $P$, $\theta$ | as [conventions.md](../findings/conventions.md) tables them; $\theta=P(W)$ at $\lVert W\rVert=1$, criticality is $Q(W)=\theta W$ | quoted |
| $\circ$, $e$, $L_e$ | $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $e=W/\theta$, $L_e=e\circ(\cdot)$ | quoted from [conventions.md](../findings/conventions.md), last bullet of "Structure constants, brackets and padding" |
| $\lambda_{\max}(L_e)$, bare | **the maximum on $e^\perp$**, not on all of $\mathcal W_n$ | **forced, and stated nowhere.** $e\circ e=Q(W)/\theta^2=e$, so $L_ee=e$: the unrestricted maximum is $\ge1$ at *every* critical point. The file's own $0.5714$ (padded $S^4\times S^4$, line 157) and "$\lambda_{\max}=\tfrac12$ exactly" (padded $W_{\mathbb{CP}^2}$, line 159) are both below $1$, so the bare symbol cannot be the unrestricted maximum. [L99](../findings/diagonal-half.md) writes the restriction explicitly and L98 does not |
| $\Delta$ | the symmetry defect of [bounds.md](../findings/bounds.md), $\Delta=\sum_{M_{ab}>0}g_{ab}$, traced over $\theta>0$ | quoted; the file's own criterion (ii) at line 96 |
| $M$, $\mathcal D_n$ | the $n\times n$ **sectional** matrix, hollow symmetric with $M\mathbf1=0$, the $\Lambda^2$ spectrum is the multiset of its **entries** | [conventions.md](../findings/conventions.md), "the letter $M$ carries two objects" |
| $S^k$ in a product | block of size $k$ in $M$, so $S^p\times S^q$ sits at $n=p+q$ | fixed by the file's own $S^3\times S^3$ at $n=6$ |
| norms | $\lVert\varphi_{ab}\rVert=1$, sums over $a<b$ | the record's half-trace pairing |

**Consequence of the third row, and it matters.** Had the census measured the unrestricted maximum, "$\Delta>0\Rightarrow\lambda_{\max}(L_e)\ge1$" would be a tautology holding at every critical point whatever $\Delta$ is, and the whole block would be vacuous. It is not, but nothing in L98, and nothing in [conventions.md](../findings/conventions.md), says so. **The domain of $L_e$ belongs in the conventions table.**

## 2. The operator, rebuilt from the definitions

On the diagonal locus the file's own collapse (line 15) gives $P=F(w)$ with

$$F(w)=\sum_{a<b}w_{ab}^3+3\!\!\sum_{a<b<c}\!\!w_{ab}w_{bc}w_{ca}.$$

$F$ is a cubic form, so $\nabla F=3Q$ and $\mathrm{Hess}\,F=6L_M$; reading the second derivatives off $F$, $\partial^2F/\partial w_{ab}^2=6M_{ab}$, $\partial^2F/\partial w_{ab}\partial w_{bc}=3M_{ac}$, $0$ on disjoint edges, gives

$$\mathcal L(N)\;=\;L_MN\;=\;M\circ N+\tfrac12(MN+NM),\qquad L_e=\mathcal L/\theta .$$

That is [diagonal-half.md:126](../findings/diagonal-half.md) verbatim, reached here independently: **the operator identity is CONFIRMED.** Two immediate consequences used below:

- $L_MM=M^{\circ2}+M^2$, so criticality on the locus is the file's $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s)$, also confirmed;
- writing $R_v$ for $(R_v)_{ab}=v_a+v_b$ ($a\ne b$), a two-line computation using $M\mathbf1=0$ gives $$L_MR_v=\tfrac12R_{Mv},$$ so $\mathcal D_n$ and its complement in the hollow symmetric matrices are both $L_M$-invariant and $\operatorname{tr}(L_M\vert_{\mathcal D_n})=-\tfrac12\operatorname{tr}M=0$. **The trace is zero**, so a trace argument cannot deliver the floor: the average eigenvalue on $\mathcal D_n\cap e^\perp$ is $-1/(\dim-1)$.

**Bonus confirmation, inside the L98 block.** The hand-checkable family at line 199 is exact. For $u=e_a-e_b$, $v=e_c-e_d$ and $N=uv^{\mathsf T}+vu^{\mathsf T}$: $\lVert N\rVert^2=4$, $N^2=2(uu^{\mathsf T}+vv^{\mathsf T})$, and

$$\langle N,\mathcal LN\rangle=\underbrace{\textstyle\sum_{i<j}M_{ij}N_{ij}^2}_{M_{ac}+M_{ad}+M_{bc}+M_{bd}}+\underbrace{\tfrac12\operatorname{tr}(MN^2)}_{-2M_{ab}-2M_{cd}},$$

which is the block's numerator exactly. **CONFIRMED.** One hypothesis is missing from it, though: $\langle N,M\rangle=M_{ac}-M_{ad}-M_{bc}+M_{bd}$ is **generically nonzero**, so $N\notin e^\perp$ and the quotient bounds only the *unrestricted* maximum. Since the unrestricted maximum is $\max(1,\lambda_{\max}\vert_{e^\perp})$, the family certifies a violation of the $\tfrac12$ bound **only when its value exceeds $1$, or when $\langle N,M\rangle=0$ has been checked.** The block claims it "certifies failure at $10$ of $13$ $\Delta>0$ points" without saying which of the two applies. **GAP, small and repairable.**

## 3. The eighth collapse, closed forms for the neighbouring tables

The block sits sixty lines below the machinery that settles its neighbours, and never uses it.

### 3.1 The full diagonal spectrum at a sphere product

Take blocks $A$ ($p$ vertices, within-value $\alpha$), $B$ ($q$, value $\gamma$), cross $\beta$; $n=p+q$. Ricci-flatness gives $(p-1)\alpha=-q\beta$, $(q-1)\gamma=-p\beta$, and the cross-edge criticality equation collapses to $\theta=(1-n)\beta$, **so every two-block weight is critical, at every $(p,q)$**, and normalising $\beta=-1$ gives $\theta_{\text{raw}}=n-1$ and $L_e=L_M/(n-1)$.

Decomposing $\mathcal D_n$ under $S_p\times S_q$ and applying $L_M$ to each isotype:

| eigenvector | eigenvalue of $L_e$ | multiplicity |
| --- | --- | --- |
| $M$ itself (invariants) | $1$ | $1$ |
| $X_{ij}=u_i+u_j$ on $AA$, $\tfrac{2-p}{q}u_i$ on $AB$; $u\perp\mathbf1_A$ | $\dfrac{n-2-\frac q{p-1}}{2(n-1)}=\boxed{\dfrac{p-2}{2(p-1)}}$ | $p-1$ (for $p\ge3$) |
| the same with $A,B$ swapped | $\dfrac{q-2}{2(q-1)}$ | $q-1$ (for $q\ge3$) |
| $X=uw^{\mathsf T}+wu^{\mathsf T}$, $u\perp\mathbf1_A$ on $A$, $w\perp\mathbf1_B$ on $B$ | $\dfrac{-1-\frac12\!\left(\frac q{p-1}+\frac p{q-1}\right)}{n-1}<0$ | $(p-1)(q-1)$ |
| $X\in\mathcal D_p$ or $\mathcal D_q$, supported inside one block | $0$ | $\binom p2-p+\binom q2-q$ |

The multiplicities sum to $\binom n2-n=\dim\mathcal D_n$. The identity $(n-2)(p-1)-q=(p-2)(n-1)$ makes the second row **independent of $q$**, a fact the file does not have. Hence

$$\lambda_{\max}\big(L_e\vert_{e^\perp}\cap\mathcal D_n\big)\;=\;\frac{p_{\max}-2}{2(p_{\max}-1)}\;<\;\frac12,\qquad p_{\max}=\max(p,q),$$

**strictly, at every sphere product and every $(p,q)$.**

### 3.2 It reproduces the line-132 table exactly

| point | blocks | derived $\frac{p_{\max}-2}{2(p_{\max}-1)}$ | file's "diagonal $\lambda_{\max}$" |
| --- | --- | --- | --- |
| $S^2\times S^3$ | $2,3$ | $\tfrac14=0.250000$ | $0.250000$ |
| $S^2\times S^4$ | $2,4$ | $\tfrac13=0.333333$ | $0.333333$ |
| $S^2\times S^6$ | $2,6$ | $\tfrac25=0.400000$ | $0.400000$ |
| $S^3\times S^5$ | $3,5$ | $\tfrac38=0.375$ | $0.375$ |
| $S^6\times S^6$ | $6,6$ | $\tfrac25=0.400$ | $0.400$ |

**Five of five.** This also settles the item [plan.md](../plan.md) carries as doubtful, *"diagonal-half.md's attribution of $(p-2)/(2(p-1))$ to the diagonal restriction, found by screen in a non-diagonal pair block"*. The attribution is **correct**: the eigenvector is $X_{ij}=u_i+u_j$ on $AA$ and $\tfrac{2-p}{q}u_i$ on $AB$, a coordinate-diagonal direction, and $p$ is the **larger** block, which line 143 does not say.

### 3.3 The padding lemma, and the three padded rows

*Let $M$ be a diagonal critical point at $n$ with $\theta>0$, and $M^{\mathrm{pad}}$ its padding by an isolated vertex $z$. Then $\operatorname{spec}(L_e)$ gains exactly $\{\mu/(2\theta_{\text{raw}})\}$ over the eigenvalues $\mu$ of the sectional matrix $M$, with eigenvector the star $X_{iz}=u_i$ together with $R_{-u/(n-2)}$ on the old vertices; the old spectrum is unchanged.*

*Proof.* $M_{iz}=0$ makes the two sectors decouple: $(L_MX)_{ij}=L_{M'}Y$ and $(L_MX)_{iz}=\tfrac12(M'u)_i$. Ricci-flatness at $z$ forces $\sum u=0$ and at $i$ forces $Y$ to have row sums $-u$, i.e. $Y=R_v+Y_0$ with $v=-u/(n-2)$, $Y_0\in\mathcal D_n$. With $M'u=\mu u$ and $L_MR_v=\tfrac12R_{Mv}$ from §2, the pair $(R_v,u)$ is an eigenvector at $\mu/2$. $\square$

| padded point | $\mu_{\max}$ | $\theta_{\text{raw}}$ | derived $\mu_{\max}/2\theta$ | file, line 157 |
| --- | --- | --- | --- | --- |
| $S^3\times S^3$, $n=7$ | $6$ | $5$ | $0.600000$ | $0.600$ |
| $S^3\times S^4$, $n=8$ | $7$ | $6$ | $0.583333$ | $0.583$ |
| $S^4\times S^4$, $n=9$ | $8$ | $7$ | $\tfrac47=0.571428571$ | $0.5714$ |

**Three of three, to every digit printed.** Together with §3.2 that is **nine** measured numbers in this file collapsing to two closed forms. A corollary worth keeping: with the file's own contraction bound $\theta\le\mu_1$ (line 209), the lemma gives $\lambda_{\max}(L_e)\ge\mu_1/2\theta\ge\tfrac12$ at **every** padding of a diagonal critical point, which is why the padded rows cluster just above $\tfrac12$ rather than accidentally.

### 3.4 A falsifier of the floor, constructed and killed

Padding preserves $\Delta$ (the isolated vertex adds no positive edge, and $g$ localises to the component), so every $\Delta>0$ point at $n$ yields one at $n+1$ sitting near $\tfrac12$ in the new directions. **That would refute a floor above $1$**, except that $\mathcal D_n\subset\mathcal D_{n+1}$ is $L_e$-invariant with the old spectrum intact, so $\lambda_{\max}^{\mathrm{pad}}=\max(\lambda_{\max}^{\mathrm{old}},\mu_{\max}/2\theta)\ge\lambda_{\max}^{\mathrm{old}}$. The obvious falsifier fails, and the floor survives it.

### 3.5 "Every minimiser connected" is a theorem, not a census output

For a disconnected critical point $M=\bigoplus\lambda_iM_i$, [L99](../findings/diagonal-half.md)'s scaling law $\lambda_i\theta_i=\theta$ gives $L_e\vert_{\text{block }i}=L_{e_i}$ exactly, so $\lambda_{\max}(L_e)\ge\max_i\lambda_{\max}(L_{e_i})$. And $\Delta=\sum_i\lambda_i^2\Delta(M_i)$, so $\Delta>0$ forces some edge-carrying block to have $\Delta_i>0$. Hence

$$\text{floor}(n)\ \text{restricted to disconnected points}\ \ \ge\ \min_{n'<n}\text{floor}(n'),$$

and since the claimed formula is **strictly decreasing in $n$**, every minimiser is connected. The block reports this as an observation from $571$ points; it is two lines from L99, which sits directly above it in the same file. **The record's own machinery already settles it.**

### 3.6 What blocks a derivation of the value

Everything above is a statement about a *named* family. The floor is an infimum over the whole semialgebraic set of diagonal critical points with $\Delta>0$ at each $n$, and:

- **the minimising family is not named in the block.** [r310](REVIEW_r310.md) does name one point (the $n=16$ minimiser has **blocks $1,1,2,4,4,4$**) and that did not survive into [diagonal-half.md](../findings/diagonal-half.md). It is exactly the datum a derivation needs, and it is the one datum the fold-in dropped;
- **no family is named at the other six dimensions**, so there is no evidence the minimisers form a single family across $n$ at all. A block pattern $1,1,2,4,4,4$ has no evident continuation to $n=10$ or $n=13$;
- **the block-constant class does not contain the minimiser.** The block's own independent solve searched block-constant $M$ and reached $1.0089$ at $n=12$ against the formula's $1.006944$. The block calls that "consistent with it". It is consistent, and it is also a **failure to reproduce**: an independent search that lands above a claimed minimum confirms nothing about the minimum, and the natural reading is that the true minimisers are outside the class searched;
- **a census bounds the infimum from above only.** $\min$ over a sample gives $\inf\le$; the equality asserted needs a lower bound, and no lower bound argument appears anywhere. The strongest honest statement available is $$\inf\lambda_{\max}(L_e)\ \le\ 1+\frac1{2(n-3)(n-4)}\quad\text{at }n=10,\dots,16,$$ with the values attained.

**What would decide it, and is blocked.** Recovering the minimiser at each of $n=10\dots16$ from [r310](REVIEW_r310.md)'s saved census, and testing whether one algebraic family carries all seven. If it does, the value is derivable by the method of §3.1, set up the criticality equations for that family, solve the invariant block of $L_e$, and read the eigenvalue off. If it does not, the fit is a coincidence over seven points and the closed form must come off the heading. **That is a run, and this review has no approval for one.**

## 4. $n=3$ and $n=4$ are silently excluded, and both are vacuous

The formula has poles at $n=3$ and $n=4$. Neither is excluded by any hypothesis in the block, the heading, or [INDEX-results.md](../findings/INDEX-results.md). Both are in fact **vacuous**, and the $n=4$ case is provable by hand:

- $n=3$: $\dim\mathcal W_3=\tfrac{3\cdot0\cdot4\cdot5}{12}=0$. Nothing to minimise over.
- $n=4$: $\dim\mathcal D_4=\binom42-4=2$, and every element is $M_{12}=M_{34}=x$, $M_{13}=M_{24}=y$, $M_{14}=M_{23}=z$ with $x+y+z=0$ (a $2$-dimensional family inside a $2$-dimensional space, so it is all of it). All four triangles of $K_4$ contribute $xyz$, so $F=2(x^3+y^3+z^3)+12xyz=18xyz$ using $x+y+z=0$. On the circle $\{x+y+z=0,\ x^2+y^2+z^2=\tfrac12\}$ the critical points of $xyz$ are the six permutations of $\pm(2t,-t,-t)$, $t=1/\sqrt{12}$; the three with $\theta>0$ are $(2t,-t,-t)$ up to relabelling, giving $\theta=36t^3=0.866=\Theta_4$, as [conventions.md](../findings/conventions.md) records. At each of them the two positive edges are $\{1,2\}$ and $\{3,4\}$, the pairs are **twins** ($M_{13}=M_{23}=M_{14}=M_{24}=-t$), and all cross entries are $\le0$, so by the file's own criterion (ii) at line 96, $\Delta=0$. **There is no diagonal critical point at $n=4$ with $\theta>0$ and $\Delta>0$.**

So both poles encode an empty minimand, which is a pleasing accident and **not something the block can claim, because it never states the domain.** A reader who takes the heading at face value reads an infinite floor at $n=4$.

**$n=5$ is a live, untested prediction.** The formula gives $1+\tfrac14=1.25$ there. [r310](REVIEW_r310.md)'s own first census ran $n=5\ldots12$ with $77$ points at $\Delta>0$, and its tabled fit begins at $n=10$, so the data below $n=10$ exists and was never reported against the formula. The most symmetric $n=5$ candidate is excluded for a different reason: for the pentagon weight ($+a$ on a $5$-cycle, $-a$ on the complement, forced by Ricci-flatness) both the cube sum and the triangle sum vanish, five triangles at $-a^3$ against five at $+a^3$, so $\theta=0$ and it falls outside the $\theta>0$ convention. **Whether any $n=5$ point clears $1.25$ is undecided here and needs the census.**

## 5. Diagonal locus or $\mathcal W_n$, the block holds both positions

The brief's second question. The precise position:

| statement | scope it is true in | scope the block gives it |
| --- | --- | --- |
| $\min\lambda_{\max}(L_e)=1+\frac1{2(n-3)(n-4)}$ | diagonal critical points, $\Delta>0$, $\theta>0$, $n=10\dots16$, and as $\le$ | heading says "the diagonal floor", **correctly scoped**, though the population and the dimensions are not in it |
| "**The stronger reading $\Delta>0\Rightarrow\lambda_{\max}(L_e)\ge1$ survives, and is now sharp**" | the diagonal locus only | **no scope at all** |
| "**The margin is not thin**: over $66$ distinct $\Delta>0$ points the minimum of $\lambda_{\max}(L_e)$ is $1.0417$, they clear not merely $\tfrac12$ but $\mathbf1$" (line 199) | the diagonal locus only | scoped four clauses later by "the diagonal half of V3", after the claim has been made |

The second row is **refuted as written by the block's own table three lines below it**: $0.608885$, $0.562755$ and $0.553481$ are $\Delta>0$ critical points with $\lambda_{\max}(L_e)<1$. [r305](REVIEW_r305.md) states the same conclusion outright (*"So $\Delta>0\Rightarrow\lambda_{\max}\ge\theta$ is **false off the diagonal locus**"*) and the block cites r305 in the sentence immediately preceding. The claim needs three words: "on the diagonal locus".

**The block warns about the cushion at the top and re-offers it at the bottom.** Line 189 says the censuses were diagonal-only; line 199 then reports the same cushion, opening with "Two things that make the target look easier than stated" and "The margin is not thin". A reader who stops at line 199 leaves with the artefact the block was written to remove.

**A second collision at line 199.** The count $66$ appears there attached to a diagonal population with minimum $1.0417$; [r305](REVIEW_r305.md) reports $66$ **full-space** critical classes at $n=6,7,8$ whose $\Delta>0$ minimum is $0.553481$, and r305 is cited ten lines above. Two different populations of size $66$ with minima differing by a factor of two, in one block, one of them unlabelled.

**And the normalisation switches inside one sentence.** "a counterexample would need $\theta>2\lambda_{\max}\gtrsim1.1$" reads $\lambda_{\max}$ as $\lambda_{\max}(L_e)$ in the clause before it (value $1.0417$) and as the raw $\lambda_{\max}(L_W)$ in the inequality, under the first reading the condition is $\theta>2.08\,\theta$, absurd; the figure $1.1$ can only come from $\lambda_{\max}(L_W)\approx0.55$, which is [r310](REVIEW_r310.md)'s raw range. **This is the same double-normalisation error whose repair is the headline of line 189**, still standing ten lines below it.

## 6. The table (brief item 4)

**It measures the same quantity as the heading, at different points.** $\lambda_{\max}(L_e\vert_{e^\perp})$ throughout; the heading's comparator is $1$ and the table's is $\tfrac12$. That is legitimate, $\tfrac12$ is what [L24](../findings/second-order.md) bounds and $1$ is the diagonal floor, but the block never says the comparator changed. The arithmetic is right: $0.608885/0.5=1.21777$, $0.562755/0.5=1.12551$, $0.553481/0.5=1.106962$.

**Row 2 is a critical point.** The $1.1\times10^{-11}$ residual is r305's solver stopping point, not a property of the point: [r296](REVIEW_r296.md) reproduces $\theta=1.081549$ exactly on the $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ pair from an independent hunt. Row 3 is likewise genuine, [r314:162](REVIEW_r314.md) re-found it at seed 9033 with **criticality residual $1.9\times10^{-16}$** and the same $\lambda_{\max}=0.553481$, and found a further pair of eigenvalues at $0.500284$ above the bound there.

**So the block's hedge is stale, and so is its headline number.** [r314](REVIEW_r314.md) certified a **new lowest** off-locus witness, $\theta=1.080092196483$, $\Delta=3.494141$, $\lambda_{\max}=0.551340110283$, margin $\mathbf{1.102680\times}$, residual $1.67\times10^{-16}$, $\operatorname{Ric}(W^2)$ of rank $8$ so not a padding, graded on $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$, and wrote *"The record's $1.1070\times$ should move to $1.1027\times$"*. [07-gradedness-split.tex:447](../report/sections/07-gradedness-split.tex) has moved. **This block has not.** The report and the findings file now carry different values for the record's headline off-locus cushion, and the findings file is the one the report is supposed to follow.

**A third disagreement with r314.** The block excludes exactly one point as a padding; r314 reports **four of the six** sub-$0.56$ candidates at $n=8$ are paddings by the $\operatorname{Ric}(W^2)$ rank test, three of them new, all four invisible to a coordinate test. The report carries this too; the block does not.

**What the cushion is actually worth off the locus.** $1.1027\times$ over $\tfrac12$, on one certified point, against the $2.00\times$ the diagonal locus shows asymptotically. The diagonal-only warning **understates the damage in one respect and overstates the remaining margin in another**: the factor-two cushion is not merely diagonal-only, it is *asymptotically exact* on the diagonal locus (the floor $\to1$ means the margin over $\tfrac12$ $\to$ exactly $2$, with the margin over $\theta$ going to zero), while off the locus the best certified margin has fallen from $1.2178\times$ to $1.1027\times$ across three successive hunts and is still falling. **Nothing on the record now leans on the factor-two as slack**, the block itself withdraws it ("no slack left to spend on a proof"), [plan.md](../plan.md) carries r305's cushion as an open numerical item, and [fence-posts.md](../findings/fence-posts.md) uses the cushion points only for the $\mathfrak m$-share question.

## 7. Label and dimensions (brief item 5)

**"Observation" is the right label**, the claim is a census output at named dimensions, which is exactly what the label means. Two defects around it:

- **the block names dimensions for the floor** ($n=10,12,16$, census $n=6\ldots16$), so the brief's premise that no dimension is named is too strong for the floor. It is right for the **table**: the three non-diagonal rows carry no $n$, and the reader must go to [r310:70](REVIEW_r310.md) and [r305](REVIEW_r305.md) to learn they are at $n=8$;
- **"exact across seven consecutive dimensions" is true but misleading in place.** r310's table is $n=10,11,\dots,16$. The block quotes it beside "a census of $571$ diagonal $\Delta>0$ critical points at $n=6\ldots16$", so a reader takes the fit to cover eleven dimensions. It covers seven, and $n=6,7,8,9$ were never fitted.

**An unrecorded corroboration that extends the fit downward.** The formula gives $1.041\overline{6}$ at $n=7$ and $1.025$ at $n=8$, which are, to the digit, the two superseded census floors the block dismisses as "artefacts of small $n$" and "the minimum of a population that stopped at $n=8$". They are not artefacts: they are the same law evaluated at their populations' top dimension. Neither the block nor [r310](REVIEW_r310.md) notices, and it is the strongest evidence on the record that the law is real, since those two numbers come from populations the fit never saw. **It should be in the block, and it moves the fitted range to five dimensions of independent agreement plus seven of fit.**

## 8. Provenance, duplication, pointers

**Provenance, checked with `git log -S`, and it is the "half-false at birth" shape.**

| commit | date | what it did |
| --- | --- | --- |
| 2f5ba533 | 2026-09-01 | folded r310 in, together with r310's own file. **The $\overset{?}{=}$ became $=$ here** |
| 03bab2f9 | 2026-09-02 | *"place headings for results 96–99"* (invented the heading `Observation 98), the diagonal floor $\min\lambda_{\max}(L_e)=1+\frac1{2(n-3)(n-4)}$`. **The number, the label and the flat equality in the title all came from a numbering pass, not from a cycle that examined the claim** |

The same numbering pass has already been found defective today: commit 681cdc17, *"a parity qualifier lost by a numbering commit"*, on this file. **A heading written by a numbering pass carries no verdict, and this one asserts an equality its source hedged.**

**Duplication, two kinds, both live.**

- **findings ↔ report.** [07-gradedness-split.tex:445](../report/sections/07-gradedness-split.tex) restates the closed form, the three quoted values, "$571$ points", "seven consecutive dimensions", "every minimiser connected" and the survival-and-sharpness sentence, and then **diverges** on the off-locus cushion ($1.1027\times$ against the block's $1.1070\times$) and on the padding count (four against one). Two copies of one claim that have already drifted apart is the failure mode this record's conventions file exists to prevent.
- **the index contradicts itself about this very number.** [INDEX-results.md:113](../findings/INDEX-results.md) marks result 98 "**Gate 2: no verdict on the record**", while [INDEX-results.md:177](../findings/INDEX-results.md) lists 98 among the four that **do** carry a Gate 2 verdict, crediting **r310**. Both cannot stand, and the second is wrong on its own terms: **r310 is the author of the claim, not a reviewer of it.** A result cannot be Gate-2'd by the review that produced it. Line 113's "no verdict" is the correct entry, and this review is the first adversarial reading L98 has had.
- No third copy of the closed form exists in [findings/](../findings/), checked.

**Pointers.** All four targets exist. One is misaimed: the block writes **[Reviewer 309](../reviews/INDEX.md)**, pointing at the reviews index, while [REVIEW_r309.md](REVIEW_r309.md) exists and is the obvious target, and r309 is the file that supplies the "$59.4\%$, not less than half" correction the block quotes in the same sentence. [REVIEW_r310.md](REVIEW_r310.md), [REVIEW_r305.md](REVIEW_r305.md) and [run_check_diagonal_floor.py](../scripts/runs/run_check_diagonal_floor.py) resolve.

**The validation entry is circular.** [plan.md:195](../plan.md) records the formula as validated: *"checked against all three reported minima, with an independent $n=12$ point falling above it as a non-minimiser should"*. Checking a formula against the three data points it was fitted to is not an independent route, and a search that lands **above** a claimed minimum is a non-reproduction being recorded as a confirmation. **The validation ledger should show this as owed.**

## 9. What the block should say

1. **Restore the hedge**, in the heading. The supported statement is $\inf\lambda_{\max}(L_e)\le1+\frac1{2(n-3)(n-4)}$, attained at $n=10\dots16$ over diagonal critical points with $\theta>0$ and $\Delta>0$, with equality **conjectured**.
2. **Scope the survival sentence**: "on the diagonal locus, $\Delta>0\Rightarrow\lambda_{\max}(L_e)\ge1$ survives and is sharp". As written it is refuted by the table below it.
3. **Carry r310's minimiser** (blocks $1,1,2,4,4,4$ at $n=16$) and the minimisers at the other six dimensions if they can be recovered. Without a family there is nothing to derive.
4. **State the domain**: $n\ge5$; record that $n=3,4$ are vacuous, $n=4$ by the two-line argument of §4.
5. **Fold r314**: the cushion is $1.1027\times$, the $0.553481$ point is polished at $1.9\times10^{-16}$, four of six sub-$0.56$ candidates are paddings. Then the report and this file agree again.
6. **Add the $n=7,8$ corroboration**, $1.0417$ and $1.025$ are the formula, not artefacts.
7. **Repair line 199**: scope the "margin is not thin" sentence, drop or fix "$\theta>2\lambda_{\max}\gtrsim1.1$", and disambiguate the two $66$s.
8. **Note the missing hypothesis** on the hand-checkable family: it certifies only when its value exceeds $1$ or when $\langle N,M\rangle=0$.
9. **Add to [conventions.md](../findings/conventions.md)**: bare $\lambda_{\max}(L_e)$ means the maximum on $e^\perp$; $L_ee=e$ makes the unrestricted maximum $\ge1$ at every critical point, which would make the whole claim vacuous under the other reading.
10. **Fix [INDEX-results.md](../findings/INDEX-results.md)**: 98 has no Gate 2 verdict; r310 authored it.

## 10. Confirmed on the way

- $\mathcal L(N)=M\circ N+\tfrac12(MN+NM)$, and criticality as $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s)$, both re-derived here from the cubic.
- The hand-checkable family's Rayleigh formula at line 201, exact, modulo the missing orthogonality hypothesis.
- The diagonal $\lambda_{\max}$ column of the line-132 table, all five entries, and the attribution of $\frac{p-2}{2(p-1)}$ to the diagonal restriction with $p$ the **larger** block.
- The three padded values at line 157, $0.600$, $0.583$, $0.5714$, from the padding lemma of §3.3.
- $\Theta_6=1.0541$ and $\Theta_4=0.866$ from [conventions.md](../findings/conventions.md), recovered as by-products.
- "Every minimiser connected", upgraded from census output to a corollary of [L99](../findings/diagonal-half.md).
