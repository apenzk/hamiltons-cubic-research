# Review r301, V3's branching reduction: the reduction is wrong, the closed form is wider than claimed, and the separating statistic has a counterexample

Everything below is built from the definitions in the brief, $\phi_{ij}=E_{ij}-E_{ji}$, $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, $\mathrm{ad}_a$ acting on $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$, $(X\#Y)_{ab}=-\tfrac14\big(\operatorname{tr}(\mathrm{ad}_aX\,\mathrm{ad}_bY)+\operatorname{tr}(\mathrm{ad}_bX\,\mathrm{ad}_aY)\big)$, $Q(X)=X^2+X^\#$, $X\circ Y=\tfrac12(XY+YX)+X\#Y$, $\mathcal W_n=\ker(\text{Bianchi})\cap\ker(\text{Ricci})$, $L_e=\theta^{-1}L_W$, in [core301.py](../scripts/reviewers/r301/core301.py). Nothing under review was imported. Every test point except the $n=8$ witness was rebuilt from geometry; the witness is loaded as raw data from [w_n8_nondiagonal_witness.npy](../scripts/data/w_n8_nondiagonal_witness.npy).

## Verdicts

| Claim | Verdict | One line |
|---|---|---|
| **H1**, $L_e$ is scalar on each $\mathfrak k$-isotypic component, so V3 reduces to a branching computation | **REFUTED** | false at both violating points on file. At the $C_5$ blow-up the trivial $\mathfrak k$-isotype has **multiplicity 4** and carries $0.441754$ *and* $0.820541$; at the $n=8$ witness it has **multiplicity 3** and carries $0.181254$, $0.339368$ and $0.588721$, the violating eigenvalue is *inside* a non-scalar piece. And the reduction fails a second way: at $11$ of $25$ $n=8$ critical classes $\dim\mathfrak k\le5$ and the branching determines nothing |
| **H2**, $L_e\vert_{\mathrm{Sym}_0(\mathbb R^p)}=\frac{p-2}{2(p-1)}$, $L_e\vert_{\mathbb R^p\otimes\mathbb R^q}=\tfrac12$ | **PLAUSIBLE**, and **wider than stated** | exact at $20$ sphere-product pairs $2\le p\le5$, $n\le11$, none of which I fitted, and out of sample at $S^3\!\times\!S^3\!\times\!S^3$, at $K_3$ blow-ups with blocks of size $3$ and $4$, and **at the $C_5$ blow-up itself**, where $p=2\Rightarrow0$ is exactly the record's own unexplained $0^{\times10}$. Still a fit: I could not derive it either. The $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ is **forced and empty**, that family *is* the orbit tangent, to all $15$/$24$/$21$/$12$ principal angles |
| **H3**, the balanced case is annihilated | **REFUTED as stated**, true after one word is changed | $H_A=D_AW+WD_A$ is **not** zero on $\mathbb R^k\otimes\mathbb R^k$: $\lVert H_A\rVert=0.2108$, $0.1336$, $0.0943$ at $S^3\!\times\!S^3$, $S^4\!\times\!S^4$, $S^5\!\times\!S^5$. It is $\Pi_{\mathcal W_n}H_A$ that vanishes, to $4\times10^{-17}$. The annihilation is a **projection artefact**, exactly as the brief suspected. The trace split dies by a *different* mechanism again, and dies at **every** $(p,q)$, balanced or not |
| **H4**, $\Delta>0$ shrinks $\mathfrak k$, refines the decomposition, and a piece clears $\tfrac12$ | **REFUTED** in its middle link | "$\Delta>0\Rightarrow\dim\mathfrak k$ small" holds across my census. "Small $\mathfrak k\Rightarrow$ finer decomposition" is **backwards at the extreme**: at $\dim\mathfrak k=0$, eight of the $25$ $n=8$ classes, all with $\Delta\ge4.24$, there is exactly **one** isotypic component, the whole of $V$. The piece count is $3\to11\to1$ as $\dim\mathfrak k$ runs $13\to5\to0$. And the record's "$13$ pieces" at the witness is a count of eigenvalues; the true count is $11$ |
| **H5**, the block-graph edge average separates violators from maximizers | **REFUTED** | explicit counterexample: an unpadded, kernel-free $n=9$ critical point with $\theta=0.641090782$ (residual $7\times10^{-17}$), $\Delta=12.074836$ and $\lambda_{\max}(L_e\vert_{W^\perp})=1.303584$, whose edge average is $\mathbf{0.472395}$ and whose all-pairs average is $\mathbf{0.450411}$, both **below** $\tfrac12$. The statistic misses a violator that misses the bound by a factor of $2.6$ |

**No counterexample to V3 was found.** Across $25$ distinct diagonal critical classes at $n=8$, $23$ at $n=9$, $30$ at $n=10$, $57$ random $\mathcal W_6$ critical points and a partial full-space $\mathcal W_8$ hunt, every $\Delta>0$ point has $\lambda_{\max}(L_e\vert_{\mathrm{Sym}_0})>\tfrac12$, the smallest being $0.962167$. **My searches did not reach the region where the record measures a margin of $2.5\times10^{-4}$**, so this is corroboration of V3 over a coarser sample than the record's own, not an independent confirmation of the tight case.

## Controls, the rebuild reproduces the record exactly before it disagrees with it

| quantity | this build | record |
|---|---|---|
| $\dim\mathcal W_n$, $n=4\ldots7$ | $10,35,84,168$ | matches $\binom{N+1}2-\binom n4-\binom{n+1}2$ |
| $\theta(S^3\!\times\!S^5)$, residual | $1.115546702$, $3.8\times10^{-16}$ | $1.115547$ |
| $\theta(C_5\text{ blow-up})$, residual | $0.670820393$, $1.3\times10^{-16}$ | $0.670820$ |
| $\theta$(witness), residual | $1.088948053$, $2.9\times10^{-15}$ | $1.088948$ |
| $\lambda_{\max}(L_e\vert_{W^\perp})$ at $C_5$ / $\mathbb{CP}^4$ / witness / $S^3\!\times\!S^5$ | $1.206011$ / $0.600000$ / $0.608885$ / $0.500000$ | identical |
| $\Delta$ at $C_5$ / witness / $S^3\!\times\!S^5$; total $\sum g_\gamma$ | $12.000000$ / $1.512231$ / $0$; $4(n-1)$ exactly | identical |
| $\mathrm{Sym}_0$ spectrum at $C_5$ | $0^{\times10}$, $0.412281^{\times20}$, $0.441754^{\times2}$, $\tfrac23^{\times20}$, $0.820541^{\times2}$ | identical |
| $\mathrm{Sym}_0$ spectrum at $S^3\!\times\!S^5$ | $\tfrac14^{\times5},\tfrac38^{\times14},\tfrac12^{\times15}$ | identical |
| $\max L_e\vert_{\mathrm{Sym}_0}$, $\dim\mathfrak k$ at the witness | $0.588721$, $5$ | identical |
| $C_5$ edge average / all-pairs | $\tfrac23$ on $20$ dims / $0.539474=\tfrac{41}{76}$ | identical |
| $K_3,K_4,K_5$ blow-up edge averages | $\tfrac12$ exactly | identical |
| $n=6$ ceiling $\lambda_{\max}$ over random critical points | $96.291798$ | Observation L25 |

Every number in the brief reproduces. The disagreements below are about what they mean.

## H1, the reduction is wrong, and it is wrong at both points that carry the claim

Schur gives less than the record takes from it. $V=\operatorname{span}\{\Pi_{e^\perp}\Pi_{\mathcal W_n}H_A\}$ is $\mathfrak k$-invariant and the compression $M=P_VL_eP_V$ commutes with $\mathfrak k$ (residual $\le1.9\times10^{-15}$ at every point). Schur then says $M$ acts on an isotypic component of type $V_\lambda$ with multiplicity $m$ as an $m\times m$ matrix tensored with $\mathrm{Id}_{V_\lambda}$, **scalar only when that matrix is**, which needs $m=1$ or a coincidence. The record's step from "commutes" to "scalar" drops the multiplicity space.

The test is exact and needs no irreducible decomposition: $M$ is scalar on every isotypic component **iff** $M$ lies in the centre of $\operatorname{End}_{\mathfrak k}(V)$. Building the commutant and its centre, and splitting $V$ by a generic central element, gives the true isotypic decomposition:

| point | $\dim\mathfrak k$ | $\dim V$ | isotypic components | components where $L_e$ is not scalar | $\max\lVert[Y,M]\rVert/\lVert Y\rVert$ over the commutant |
|---|---|---|---|---|---|
| $S^3\!\times\!S^5$ | $13$ | $34$ | $3$ (dims $5,14,15$) | $0$ | $1.2\times10^{-15}$ |
| $\mathbb{CP}^4$ | $16$ | $15$ | $1$ | $0$ | $1.0\times10^{-30}$ |
| $C_5$ blow-up | $5$ | $54$ | $\mathbf{26}$ | $\mathbf 1$ | $\mathbf{0.379}$ |
| $n=8$ witness | $5$ | $35$ | $\mathbf{11}$ | $\mathbf 1$ | $\mathbf{0.270}$ |

The failure is at the **trivial** isotype in both cases, and it is where the violation lives:

- $C_5$ blow-up: $\dim V^{\mathfrak k}=4$, and $L_e$ there is $\{0.441754,\ 0.441754,\ 0.820541,\ 0.820541\}$. $\mathfrak k$ is a maximal torus of $\mathfrak{so}(10)$, so this $4$-space is the zero-weight space of $\mathrm{Sym}_0(\mathbb R^{10})$, and the record's $0.441754^{\times2}$ and $0.820541^{\times2}$ are **one** isotypic component, not two pieces.
- $n=8$ witness: $\dim V^{\mathfrak k}=3$, and $L_e$ there is $\{0.181254,\ 0.339368,\ 0.588721\}$, three distinct values on one isotypic component, and $0.588721$ is the number H4 calls "a piece clearing the bound". It is not a piece; it is one eigenvalue inside a piece whose other two eigenvalues are well under $\tfrac12$.

**One repair exists and it does not save the reduction.** At the $C_5$ blow-up the *full* isotropy group is disconnected, the signed permutations of the blow-up act, $D_5$ permutes the five block traces, and the $4$-space above is the standard $D_5$ representation, which is two **inequivalent** $2$-dimensional irreducibles. So under the full stabiliser that component splits and scalarity is restored there. The Lie algebra $\mathfrak k(W)=\{x:[\mathrm{ad}\,x,W]=0\}$ is what the record and the brief both define and use, and with it the claim is false. I did not determine the witness's component group.

**And the reduction fails a second, independent way, which no group repairs.** Even granting scalarity, the branching gives *dimensions*, never *values*. Two demonstrations from the record's own points:

- At the $C_5$ blow-up all $25$ nonzero-weight components are $2$-dimensional and structurally identical as $\mathfrak k$-modules, yet they carry three different values, $0$ ($\times5$, the weights $\pm2e_a$), $0.412281$ ($\times10$, non-adjacent block pairs) and $\tfrac23$ ($\times10$, adjacent pairs).
- The same module $\mathrm{Sym}_0(\mathbb R^p)$ carries $\tfrac{p-2}{2(p-1)}$, which moves with $p$ but is invisible to the pattern of irreducibles.

So "a branching computation over the possible isotropy algebras **rather than a search over tensors**" names no computation: the isotropy algebra plus its branching leaves every eigenvalue undetermined.

**The point where it is emptiest is exactly the target regime.** Across $25$ distinct diagonal critical classes at $n=8$:

| $\theta$ | $\Delta$ | $\dim\mathfrak k$ | isotypic components | non-scalar components | $\lambda_{\max}(L_e\vert_{W^\perp})$ | $\lambda_{\max}\vert_{\mathrm{Sym}_0}$ |
|---|---|---|---|---|---|---|
| $1.145644$ | $0$ | $12$ | $2$ | $0$ | $0.500000$ | $0.333333$ |
| $1.115547$ | $0$ | $13$ | $3$ | $0$ | $0.500000$ | $0.500000$ |
| $0.986013$ | $0$ | $16$ | $2$ | $0$ | $0.600000$ | $0.500000$ |
| $0.720082$ | $0$ | $7$ | $6$ | $0$ | $1.000000$ | $1.000000$ |
| $0.684081$ | $2.49582$ | $5$ | $11$ | $1$ | $1.041667$ | $1.000000$ |
| $0.655584$ | $4.25789$ | $3$ | $13$ | $3$ | $1.085619$ | $0.962167$ |
| $0.462910$ | $4.24123$ | $\mathbf 0$ | $\mathbf 1$ | $1$ | $1.600713$ | $0.964181$ |
| $0.082270$ | $15.17869$ | $\mathbf 0$ | $\mathbf 1$ | $1$ | $8.041272$ | $5.624319$ |

Eight of the $25$ classes have $\dim\mathfrak k=0$; all eight have $\Delta\ge4.24$; all eight have exactly **one** isotypic component, namely $V$ itself, on which $L_e$ is as far from scalar as it can be. Full table in [h4_mechanism.py](../scripts/reviewers/r301/h4_mechanism.py).

## H2, the closed form is real, is about the *block* rather than about sphere products, and its $\tfrac12$ is empty

Every value is exact to $\le10^{-14}$ across $20$ two-block pairs, $2\le p\le5$, $4\le n\le11$, sixteen more than the three the record fitted on, and the fit was not refreshed:

| $p$ | predicted $\frac{p-2}{2(p-1)}$ | observed, at every $q$ tested |
|---|---|---|
| $2$ | $0$ | the piece is **empty after projection**, the formula is vacuous at $p=2$ on sphere products |
| $3$ | $\tfrac14$ | $0.250000$ at $q=3,4,5,6,7,8$ |
| $4$ | $\tfrac13$ | $0.333333$ at $q=4,5,6,7$ |
| $5$ | $\tfrac38$ | $0.375000$ at $q=5,6$ |
| $6,7,8,9$ | $\tfrac25,\tfrac5{12},\tfrac37,\tfrac7{16}$ | all exact |

**Half a derivation, and it says what shape the other half must have.** For $A=E_{ab}+E_{ba}$ with $a,b$ in the same block, three facts are exact rather than measured (residuals $0$ and $\le4\times10^{-15}$):

1. $H_A$ **already satisfies the first Bianchi identity**, every entry of $H_A$ repeats an index, so no four-index component exists and $\mathrm{Alt}(H_A)=0$ identically. The Weyl projection therefore only has a Ricci part to remove.
2. $\mathrm{Ric}(H_A)=2\big[(p-2)\alpha+q\gamma\big]\,(E_{ab}+E_{ba})$, where $\alpha$ is the vertex value inside the block and $\gamma$ the mixed one. It is trace-free, so there is no scalar part either.
3. $\Pi_{\mathcal W_n}H_A=H_A-\kappa\,\Phi(E_{ab}+E_{ba})$ with $\kappa=\frac{2[(p-2)\alpha+q\gamma]}{n-2}$ and $\Phi(h)_{ijkl}=h_{ik}\delta_{jl}+h_{jl}\delta_{ik}-h_{il}\delta_{jk}-h_{jk}\delta_{il}$.

Writing $S_j$ for the symmetric swap of $e_a\wedge e_j$ with $e_b\wedge e_j$ and $P_{ab}$ for the projection onto $e_a\wedge e_b$, this makes $\Pi_{\mathcal W_n}H_A$ an explicit three-term operator, and the anticommutator half of $L_e$ is immediate: $\tfrac12(WX+XW)=\lambda_{aj}X$ on each $S_j$. **What remains is $W\#\Pi_{\mathcal W_n}H_A$**, and the striking thing the closed form asserts is a cancellation: $\kappa$, $\alpha$ and $\gamma$ all carry $q$, yet the answer $\frac{p-2}{2(p-1)}$ does not. Anyone finishing this should look for that cancellation first.

**Out of sample, and this is the interesting part.** The value depends on the block and on nothing else in the point:

| point | $\Delta$ | block | predicted | observed |
|---|---|---|---|---|
| $S^3\!\times\!S^3\!\times\!S^3$ ($n=9$, critical to $3\times10^{-16}$) | $0$ | $\mathrm{Sym}_0(\mathbb R^3)$ | $\tfrac14$ | $0.250000$ |
| $K_3$ blow-up, blocks of $4$ ($n=12$) | $0$ | $\mathrm{Sym}_0(\mathbb R^4)$ | $\tfrac13$ | $0.333333$ |
| **$C_5$ blow-up** | $\mathbf{12}$ | $\mathrm{Sym}_0(\mathbb R^2)$ | $\mathbf 0$ | $\mathbf{-1\times10^{-16}}$, on $10$ dimensions |

The last row identifies the record's own unexplained $0^{\times10}$ at the $C_5$ blow-up: it is the within-block $\mathrm{Sym}_0(\mathbb R^2)$ family, five blocks $\times$ two dimensions, sitting at the $p=2$ value of the same closed form. So the formula is not a sphere-product fact and it survives at $\Delta>0$. That is much better evidence than three points, but it is still not a derivation, and I did not produce one.

**The $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ carries no information at all.** At $S^3\!\times\!S^5$, $S^4\!\times\!S^6$, $S^3\!\times\!S^7$, $S^2\!\times\!S^6$ the mixed family and the orbit tangent are the **same subspace**, every principal cosine is $1.000$ to $10^{-15}$, and the dimensions agree ($15$, $24$, $21$, $12$). Orbit directions are exact $\tfrac12$-eigenvectors of $L_e$ by equivariance, which this record already proves. So that half of H2 is a theorem about the group orbit wearing a deformation's clothes, and "no sphere product violates through $\mathrm{Sym}_0$" reduces to the $\mathrm{Sym}_0(\mathbb R^p)$ half plus two inert summands.

**One scope error.** The four summands exhaust $\mathrm{Sym}_0(\mathbb R^n)$ only when $p+q=n$. Zero-padded products break the conclusion, not the formula: padded $S^3\!\times\!S^3$ at $n=8$ has $\lambda_{\max}\vert_{\mathrm{Sym}_0}=0.600000$, and padded $S^2\!\times\!S^3$ has $0.625000$.

## H3, the annihilation is a projection artefact, and the trace split dies of something else

Measured directly, before any projection:

| point | family | $\lVert D_AW+WD_A\rVert$ | $\lVert\Pi_{\mathcal W_n}H_A\rVert$ | $\lVert\Pi_{e^\perp}\Pi_{\mathcal W_n}H_A\rVert$ |
|---|---|---|---|---|
| $S^3\!\times\!S^3$ | $\mathbb R^3\otimes\mathbb R^3$ | $0.210819$ |, | $0$ |
| $S^4\!\times\!S^4$ | $\mathbb R^4\otimes\mathbb R^4$ | $0.133631$ |, | $0$ |
| $S^5\!\times\!S^5$ | $\mathbb R^5\otimes\mathbb R^5$ | $0.094281$ | $4.5\times10^{-17}$ | $4.5\times10^{-17}$ |
| $S^5\!\times\!S^5$ | trace split | $0.942809$ | $2.1\times10^{-15}$ | $2.1\times10^{-15}$ |
| $S^3\!\times\!S^5$ | trace split | $1.345185$ | $\mathbf{0.852013}$ | $\mathbf{1.2\times10^{-15}}$ |

**And the true statement is better than the false one.** At $S^k\!\times\!S^k$ the mixed and trace-split deformations satisfy, exactly (residual $0.00\times10^{0}$ and $2.4\times10^{-17}$),

$$H_A=\tfrac1{n-2}\,\Phi\big(\mathrm{Ric}(H_A)\big),\qquad \Phi(h)_{ijkl}=h_{ik}\delta_{jl}+h_{jl}\delta_{ik}-h_{il}\delta_{jk}-h_{jk}\delta_{il},$$

i.e. **the deformation moves the curvature operator purely in the Ricci direction and leaves the Weyl part fixed to first order.** That is a statement about $\mathcal W_n$ rather than about a projection, it explains why the projection kills it, and it is the thing worth recording. At $S^3\!\times\!S^5$ the same identity fails by $0.322$, exactly the surviving Weyl component.

So "$H_A=0$ on all of $\mathbb R^k\otimes\mathbb R^k$" is false, $H_A$ is a nonzero symmetric operator on $\Lambda^2$ that happens to be orthogonal to $\mathcal W_n$. **It is $\Pi_{\mathcal W_n}$ that annihilates, not $D_A\cdot+\cdot D_A$.** The record's next sentence, that the balanced maximiser is therefore *strictly* stable with margin $\tfrac1{2(k-1)}$, is unaffected: the surviving pieces really are $\mathrm{Sym}_0(\mathbb R^k)^{\oplus2}$ at $\tfrac{k-2}{2(k-1)}$, and $25+1$ of $54$ dimensions really do drop out at $S^5\!\times\!S^5$. Only the stated cause is wrong.

The trace split is a third mechanism and the record folds it into the second. It is killed at **every** $(p,q)$, balanced or not, and at unbalanced ones the Weyl projection leaves $0.852013$ standing, it is $\Pi_{e^\perp}$ that finishes it, because $\Pi_{\mathcal W_n}H_A$ is exactly parallel to $W$ there. Grouping it with the balanced-case annihilation ("$25+1$ of $54$") reads as one phenomenon where there are two.

**And the annihilation is not a $p=q$ phenomenon.** At $S^3\!\times\!S^3\!\times\!S^3$ the three equal-size mixed families $\mathbb R^3\otimes\mathbb R^3$ survive projection at full rank ($27$ dimensions) and sit at exactly $\tfrac12$. Equal block sizes do not annihilate; *two* blocks do.

## H4, the mechanism is a correlation, and the middle link runs backwards

The two measurements are right. $\dim\mathfrak k$ does fall $13\to5$ and $\max L_e\vert_{\mathrm{Sym}_0}$ does rise $\tfrac12\to0.588721$; I reproduce both. Three objections.

1. **The piece count is wrong.** "$3\to13$" counts distinct eigenvalues. The isotypic components number $3\to\mathbf{11}$, and at the $C_5$ blow-up $\mathbf{26}$ rather than the five the table implies.
2. **"Small $\mathfrak k\Rightarrow$ finer decomposition" reverses at the extreme.** The count is not monotone in $\dim\mathfrak k$: $13\to3$ pieces, $5\to11$ pieces, $0\to\mathbf1$ piece. At trivial isotropy, which is where $\Delta$ is largest, $4.24$ to $15.18$ across my census, the decomposition is the coarsest possible and the branching says nothing whatever. Since the hypothesis $\Delta>0$ is meant to *supply* small $\mathfrak k$, the mechanism's own hypothesis destroys its conclusion in the limit.
3. **The violation is not carried by a piece.** At the witness, $0.588721$ sits inside a $3$-dimensional non-scalar component alongside $0.181254$ and $0.339368$; at the $C_5$ blow-up, $0.820541$ sits inside a $4$-dimensional non-scalar component alongside $0.441754$. In both cases the sentence "a piece clears the bound" is not about any piece.

$\mathbb{CP}^4$ ($\Delta=0$, one piece, $\tfrac35$), survives as the record already says, and my census adds worse: at $n=8$ there are $\Delta=0$ critical points with $\dim\mathfrak k=7$ and $8$, six isotypic pieces each, and $\lambda_{\max}(L_e\vert_{W^\perp})=1.000000$ exactly. So neither $\Delta$ nor $\dim\mathfrak k$ nor the piece count predicts violation.

**What survives.** "$\Delta>0\Rightarrow\dim\mathfrak k$ small" holds without exception in my census, every $\Delta=0$ class at $n=8$ has $\dim\mathfrak k\ge7$, every $\Delta>0$ class has $\dim\mathfrak k\le5$. That implication is worth keeping; the chain built on top of it is not.

## H5, refuted by an explicit unpadded witness

### The counterexample

Solving $\lambda^2+\lambda\lambda=\theta\lambda$ with vanishing row sums on the coordinate-diagonal slice, seed $21$ at $n=10$, gives a point with one identically-zero vertex row. Deleting it leaves a genuine $n=9$ critical point with **no kernel** (eight distinct nonzero eigenvalues of $W$), saved at [w_n9_h5_counterexample_vertex.npy](../scripts/reviewers/r301/w_n9_h5_counterexample_vertex.npy):

| | |
|---|---|
| $\theta$ | $0.641090782$ |
| criticality residual, row sums | $6.9\times10^{-17}$, $5.6\times10^{-17}$ |
| $\Delta$ (of $4(n-1)=32$) | $\mathbf{12.074836}$ |
| blocks / negative block graph | $5$ blocks, $5$ edges, one isolated block |
| $\lambda_{\max}(L_e\vert_{W^\perp})$ | $\mathbf{1.303584}$, a violator by a factor of $2.6$ |
| $\lambda_{\max}(L_e\vert_{\mathrm{Sym}_0})$ | $0.962465$ |
| **edge average** $\operatorname{tr}(L_e\vert_V)/\dim V$ | $\mathbf{0.472395}$ on $16$ dimensions |
| **all-pairs average** | $\mathbf{0.450411}$ on $32$ dimensions |

Both variants of the statistic are below $\tfrac12$ at a point that misses Lemma L24 by more than any catalogued example except the very low-$\theta$ ones. The statistic does not separate. The zero-padded $n=10$ parent gives the same verdict ($0.466788$ and $0.458970$), so the failure is not an artefact of the padding either way.

The eigenvalue on that family does reach $0.649018$, so an eigenvalue-based certificate still fires. **That is the whole content of the counterexample: an average over a structurally chosen family is not a criterion, because the family mixes directions on both sides of the fence.** The record already established this for the undifferentiated $\mathrm{Sym}_0$ average; refining the family by the block graph does not change the kind of statistic it is.

### The margin was never wide

Even before the counterexample, the separation is knife-edge. Diagonal critical classes with $\Delta>0$:

| $n$ | $\theta$ | $\Delta$ | edge average |
|---|---|---|---|
| $8$ | $0.681429$ | $2.08955$ | $0.500826$ |
| $8$ | $0.684081$ | $2.49582$ | $0.501944$ |
| $9$ | $0.542659$ | $1.57055$ | $0.501854$ |
| $10$ | $0.725694$ | $4.05547$ | $0.509151$ |
| $10$ | $0.672874$ | $8.71378$ | $0.511330$ |
| $10$ | $0.563188$ | $1.69163$ | $0.501744$ |
| $10$ | $0.697149$ | $2.02507$ | $\mathbf{0.500328}$ |
| $\mathbf 9$ | $\mathbf{0.641091}$ | $\mathbf{12.07484}$ | $\mathbf{0.472395}$ |

A criterion whose margin is $3\times10^{-4}$ over a family it was not fitted on was already fragile; the last row ends it.

### The other three questions in the addendum

**"That family IS the orbit tangent" at unbalanced maximizers, verified, and it makes the $\tfrac12$ forced and therefore empty.** At $S^3\!\times\!S^5$, $S^4\!\times\!S^6$, $S^3\!\times\!S^7$, $S^2\!\times\!S^6$ the edge family and the orbit tangent coincide exactly, same dimension, every principal cosine $1.000$ to $10^{-15}$. Orbit directions are exact $\tfrac12$-eigenvectors at every critical point, so the statistic returns $\tfrac12$ there for a reason with no connection to maximality, and separates nothing at those points.

**But the explanation does not extend, which is worse than it not being true.** At the $K_3$, $K_4$, $K_5$ blow-ups the edge family is **exactly orthogonal** to the orbit tangent ($\sum\cos^2=2\times10^{-30}$) and still returns exactly $\tfrac12$, on $12$, $24$, $40$ dimensions. Same at $S^3\!\times\!S^3\!\times\!S^3$: $27$ dimensions, orthogonal to the $27$-dimensional orbit, average exactly $\tfrac12$. So "$\tfrac12$" is a wide phenomenon with at least two unrelated causes, and the threshold sits *on top of* a large family of points rather than between two populations.

**"Undefined at points with no block structure", yes, and that is most of the target.** The block graph needs a coordinate-diagonal $W$. The record's own headline $\Delta>0$ witness, the $n=8$ non-diagonal point at $\theta=1.088948$, has no block structure and no block graph, so the statistic is undefined at the very point H4 was built on. It is also undefined ("empty") at $S^{k}\!\times\!S^{k}$, the conjectured maximiser, where the mixed family is annihilated. **A criterion that is undefined at the conjectured maximiser and undefined at the record's own witness covers a narrow class**, and that class is the coordinate-diagonal one where Jäger's argument already applies.

**"Is $\tfrac23$ forced by symmetry alone?", scalarity yes, the value no.** Holding the $C_5$ blow-up's symmetry and moving off criticality within the block-symmetric family $(4,y,z)$ with vanishing row sums, the edge family stays an exact eigenspace (spread $\le7\times10^{-15}$) while the value moves freely:

| $(x,y,z)$ | criticality residual | edge average |
|---|---|---|
| $(4,-2,1)$ | $2.8\times10^{-17}$ | $\tfrac23$ |
| $(4,-1.5,0.5)$ | $2.4\times10^{-2}$ | $\mathbf{0.469358}$ |
| $(4,-2.4,1.4)$ | $2.9\times10^{-2}$ | $0.792179$ |
| $(4,-2.8,1.8)$ | $5.7\times10^{-2}$ | $0.852875$ |
| $(4,-3,2)$ | $6.9\times10^{-2}$ | $0.865237$ |

Symmetry forces the family to be an eigenspace and nothing more; $\tfrac23$ is a property of the critical point. And the value crosses $\tfrac12$ inside a single symmetry class, so nothing structural holds it above the fence.

## What V3 should take from this

- **The reduction to branching is not available.** $L_e$ preserves the isotypic decomposition (that much is true and is all Schur gives) but it is not scalar on it, and where $\Delta$ is large the decomposition is trivial. A proof cannot read the eigenvalue off the isotropy type.
- **The one closed form worth keeping is $\frac{p-2}{2(p-1)}$ on within-block $\mathrm{Sym}_0$**, which now has evidence at three-block products, at $K_3$ blow-ups and at a $\Delta>0$ point, and which explains a number the record recorded without explaining. Deriving it is a well-posed and probably tractable task; the $\tfrac12$ on the mixed piece needs no derivation because it is the orbit.
- **Averages are finished as criteria.** Two distinct averaging statistics have now failed on this route, both by mixing directions across the fence. The instrument that has never failed is $\lambda_{\max}(L_e\vert_{\mathrm{Sym}_0})$, which is $>\tfrac12$ at every $\Delta>0$ point in every census run here.
- **The recorded thin margin is the place to look for a real counterexample.** V3's $\mathrm{Sym}_0$ certificate is $2.5\times10^{-4}$ from failing at one catalogued $n=8$ point; my searches did not reach that region, and every $\Delta>0$ point I found has $\lambda_{\max}\vert_{\mathrm{Sym}_0}\ge0.962$. The gap between those two facts is unexplained and is where I would spend the next cycle.

## Scripts

[core301.py](../scripts/reviewers/r301/core301.py) (algebra, $\mathcal W_n$, isotropy) · [points301.py](../scripts/reviewers/r301/points301.py) (sphere products, $\mathbb{CP}^m$, blow-ups) · [sym0.py](../scripts/reviewers/r301/sym0.py) (the deformation map and the compression) · [h1_isotypic.py](../scripts/reviewers/r301/h1_isotypic.py) (commutant, centre, isotypic split) · [h2_spheres.py](../scripts/reviewers/r301/h2_spheres.py) · [defect.py](../scripts/reviewers/r301/defect.py) ($\Delta$, orbit tangent, edge families) · [diag_census.py](../scripts/reviewers/r301/diag_census.py) · [run_census.py](../scripts/reviewers/r301/run_census.py) · [hunt.py](../scripts/reviewers/r301/hunt.py) · [hunt_n8.py](../scripts/reviewers/r301/hunt_n8.py) · [h4_mechanism.py](../scripts/reviewers/r301/h4_mechanism.py) · [verify_h5.py](../scripts/reviewers/r301/verify_h5.py)
