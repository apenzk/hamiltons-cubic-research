# VERIFY v113, Lemma L68: the diagonal density $g_{ab}$, the twin characterisation, the entry cap $2\theta M_{ab}\le s_a+s_b$, and the traced identity $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$

**Verifier v113, cold brief.** Target: the Lemma L68 block at [diagonal-half.md](../findings/diagonal-half.md):86–112, parts (i)–(iv), with the canonical line at [results.md](../results.md):777. **No numerical work was done: no script was run, and every value below is an exact hand evaluation in closed rationals or surds.** Log: [agent_logs/verify-L68-v113.log](../agent_logs/verify-L68-v113.log). Sources read rather than recalled: [conventions.md](../findings/conventions.md), [bounds.md](../findings/bounds.md), [bounds-relaxations.md](../findings/bounds-relaxations.md), the Petersen–Wink notes at [references/petersen-wink-2019-bochner-technique/notes.md](../references/petersen-wink-2019-bochner-technique/notes.md), [lean/INDEX.md](../lean/INDEX.md):110, [L68.lean](../lean/HamiltonsCubic/Results/L68.lean), [REVIEW_r519.md](../reviews/REVIEW_r519.md), [REVIEW_r520.md](../reviews/REVIEW_r520.md), [LEDGER.md](../findings/LEDGER.md):57 and :676.

## Verdicts

| # | claim, as written | verdict |
| --- | --- | --- |
| C1 | (i) $g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2=2\lVert M_a-M_b\rVert^2-4M_{ab}^2=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2$ | **PROVEN** |
| C2 | (i) "with no hypothesis at all", and the factor $2$ | **PROVEN** |
| C3 | (i) is the diagonal specialisation of $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$, with $\sum_\alpha\lambda_\alpha^2R_{(ab)\alpha}=s_a+s_b-2M_{ab}^2$ and $Q_{(ab)}=2(M^2)_{ab}$ | **PROVEN** |
| C4 | (ii) $\Delta=0$ iff every positive edge joins twins; linkage transitive; components are twin cliques, constant inside and across each pair, non-positive between | **PROVEN** |
| C5 | (ii) singleton-block corollary, and $\Delta=0$ with $\ker W=0$ forcing blocks of size $\ge2$ | **PROVEN** |
| C6 | (ii) "on this locus $\Delta=0$ is already the generalised sphere-product shape" | **HYPOTHESIS-DEBT**, the term is undefined on the record and no correspondence is argued |
| C7 | (iii) $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ and the cap $2\theta M_{ab}\le s_a+s_b$, with equality exactly at twin pairs | **PROVEN** |
| C8 | (iii) "The cap needs criticality **and hollowness**" | **PROVEN, hypotheses corrected**: complete only relative to the *multiplier-free* criticality equation the block quotes; the vanishing of the multiplier is $M\mathbf 1=0$, unnamed |
| C9 | (iii) the $\theta>0$ guard on $\theta\le\min_{M_{ab}>0}(s_a+s_b)/(2M_{ab})$ | **PROVEN**, and the guard is **superfluous**, the division needs $M_{ab}>0$ only |
| C10 | (iv) $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$ | **PROVEN, hypotheses corrected**: true, and it needs $M\mathbf 1=0$ *and* criticality, neither named at (iv) |
| C11 | (iv) "Traced over $\mathfrak p$" as the whole proof | **GAP**, the trace lands on $2\sum_{M_{ab}>0}M_{ab}$, not $\lVert M\rVert_1$; the bridge is one line and is not on the page |
| C12 | the canonical line at [results.md](../results.md):777 read alone | **PROVEN, hypotheses corrected**: sound only because "diagonal locus" imports $\mathcal D_n$ from [conventions.md](../findings/conventions.md) |
| C13 | the round's own premise, "single-audited … nothing here has been drawn against twice" | **BROKEN**, [r519](../reviews/REVIEW_r519.md) and [r520](../reviews/REVIEW_r520.md) both ran on identical briefs and both CONFIRMED, each re-deriving (i)–(iv) cold |

**Verdict: PROVEN, hypotheses corrected.** Every one of the four displayed statements is true and every derivation reproduces exactly by hand, including at the $C_5$ blow-up and at the balanced product in closed form. Two hypotheses are load-bearing and unnamed, $M\mathbf 1=0$ for (iv), and the same condition standing behind (iii)'s multiplier-free criticality equation, and both repairs were already recommended by two prior reviewers and by the Lean row, and were never applied to the block.

## 0. Conventions, fixed once

Every item is quoted from [conventions.md](../findings/conventions.md) rather than restated from memory.

- **The locus.** $\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf 1=0\}$, "the vertex matrices of coordinate-diagonal Weyl operators". So the three properties symmetry, hollowness and vanishing row sums are *definitional* to membership, and "on the diagonal locus" carries all three.
- **"Diagonal" means diagonal in coordinate $2$-planes** $e_i\wedge e_j$ of an orthonormal frame, not diagonal as an operator on $\Lambda^2$.
- **The pairing** is the half-trace $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level, under which $\lVert\varphi_{ab}\rVert^2=1$ and $\{\varphi_{ab}\}_{a<b}$ is orthonormal. This is the record's choice, pinned by [r519](../reviews/REVIEW_r519.md) and [r520](../reviews/REVIEW_r520.md).
- **The two objects under $M$.** On this locus $M$ is the $n\times n$ **sectional** matrix, with $\lVert M\rVert_F^2=\operatorname{tr}M^2=2$ at a unit Weyl tensor, and **the $\Lambda^2$ spectrum is the multiset of ENTRIES of $M$**, so $W\varphi_{ab}=M_{ab}\varphi_{ab}$ and $\lambda_{(ab)}=M_{ab}$.
- **$\Delta$** is the symmetry defect, "traced over $\{\lambda>0\}$ only", so on this locus $\Delta=\sum_{a<b,\;M_{ab}>0}g_{ab}$ over **unordered** pairs, against the file's own default that pair sums are ordered. The ordered reading breaks (iv) by a factor $2$; both prior reviewers flagged the label and the block still does not carry it.
- **$g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$** over ordered $(\alpha,\beta)$, with $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ totally symmetric; the first two moments $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$ are pinned and need no criticality.
- **Criticality**, on this locus, is the boxed equation of [diagonal-half.md](../findings/diagonal-half.md) sixty lines above the block: $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s_1,\dots,s_n)$, whose off-diagonal reading is $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$.
- **The functional** is $\theta=\tfrac12\big(\sum_{a,b}M_{ab}^3+\operatorname{tr}M^3\big)$ subject to $M\mathbf 1=0$, $\operatorname{tr}M=0$, $\operatorname{tr}M^2=2$.

## The hypothesis inventory

**Every hypothesis the block carries, every hypothesis it imports, and which of them the written proof uses.** The four rightmost columns are the four parts.

| hypothesis | where it comes from | stated in the block? | (i) | (ii) | (iii) | (iv) |
| --- | --- | --- | --- | --- | --- | --- |
| $M$ symmetric | $\mathcal D_n$, definitional | no | **used** | **used** | **used** | **used** |
| $M$ hollow, $M_{aa}=0$ | $\mathcal D_n$, definitional | **yes**, twice (at (i)'s middle step and at (iii)'s "criticality **and hollowness**" | **used** |), | **used** | **used** |
| $M\mathbf 1=0$ (Ricci-flatness) | $\mathcal D_n$, definitional; stated once at the top of the file | **no** (used silently at (ii)'s corollary ("they sum to $0$") and decisively at (iv) |), | **used** (corollary only) | **used**, indirectly, to kill the criticality multiplier | **used**, decisively |
| $W$ diagonal in the coordinate pair basis, $W\varphi_{ab}=M_{ab}\varphi_{ab}$ | the locus | half, the block says the eigenvectors are the $\varphi_{ab}$ and never says the eigenvalue is $M_{ab}$, which is what makes $\{\lambda>0\}=\{M_{ab}>0\}$ | **used** | **used** | **used** | **used** |
| off-diagonal criticality $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ | the boxed equation above the block | **yes** | (|), | **used** | **used** |
| $\operatorname{tr}M^2=2$ (unit norm) | the locus | no | not used | not used | not used | not used |
| $\theta>0$ | stated at the min-form | **yes** | (|), | **superfluous** | not used |
| $\ker W=0$ | stated at (ii)'s corollary | **yes** | (| **used** (corollary only) |), |, |
| $n\ge3$ for the $2(n-2)$ moved directions; $n\ge4$ for $\mathcal D_n\cap\{\operatorname{tr}M^2=2\}\ne\varnothing$ |, | **no** | scope | scope | scope | scope |

**Imported results, each checked against the object it applies to.**

| import | its hypotheses | met here? |
| --- | --- | --- |
| [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) **Prop 1.7**, read verbatim on file: *"if $\{\Xi_\alpha\}$ is an orthonormal basis for $\Lambda^2V$ that diagonalizes $R\in\mathrm{Sym}^2(\Lambda^2V)$ … then $\lvert LR\rvert^2=2\sum_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2g(L\Xi_\alpha,\Xi_\beta)^2$ for every $L\in\mathfrak{so}(V)$"* | $R$ a **symmetric operator** on $\Lambda^2$, no Bianchi, no Ricci-flatness, no criticality; $\{\Xi_\alpha\}$ an orthonormal eigenbasis; $L\in\mathfrak{so}(V)$ arbitrary | **yes.** $\{\varphi_{ab}\}_{a<b}$ is an orthonormal eigenbasis of a diagonal $W$ under the half-trace pairing, and $L=\varphi_{ab}\in\mathfrak{so}(n)$. The proposition is *weaker* in hypotheses than the block needs, so nothing is over-drawn. **The source is in [references/](../references/) and was read, not recalled.** |
| the recorded decomposition $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$, [bounds-relaxations.md](../findings/bounds-relaxations.md):103 | $R_{\gamma\alpha}=\sum_\beta T_{\gamma\alpha\beta}$, $Q_\gamma=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}$; follows from PW 1.7 by expanding the square and using $T$'s total symmetry | **yes** |
| the structure constant $[\varphi_{ab},\varphi_{bd}]=\varphi_{ad}$ | $a,b,d$ distinct | **yes**, and re-derived in §1 below |
| the boxed criticality equation of the same file | $W$ coordinate-diagonal in $\mathrm{Weyl}_n$, unit norm; the "if" direction additionally uses symmetric criticality for the coordinate sign-flip group | **yes**, but the equation's *multiplier-free* form consumes $M\mathbf 1=0$, which is where (iii)'s unnamed hypothesis enters |

## 1. Part (i), re-derived from the definitions

**The bracket.** With $\varphi_{ab}=E_{ab}-E_{ba}$ and $a,b,d$ distinct, $E_{ab}E_{bd}=E_{ad}$ and $E_{db}E_{ba}=E_{da}$ are the only surviving products among the eight, so $[\varphi_{ab},\varphi_{bd}]=E_{ad}-E_{da}=\varphi_{ad}$. Relabelling through $\varphi_{ab}=-\varphi_{ba}$ gives $[\varphi_{ab},\varphi_{ad}]=-[\varphi_{ba},\varphi_{ad}]=-\varphi_{bd}$.

**The commutator's matrix.** Write $A:=[\mathrm{ad}(\varphi_{ab}),W]$. For eigenvectors, $\langle A\varphi_\beta,\varphi_\alpha\rangle=(\lambda_\beta-\lambda_\alpha)\langle[\varphi_{ab},\varphi_\beta],\varphi_\alpha\rangle$. Hence

$$\langle A\varphi_{bd},\varphi_{ad}\rangle=(M_{bd}-M_{ad})\cdot(+1),\qquad \langle A\varphi_{ad},\varphi_{bd}\rangle=(M_{ad}-M_{bd})\cdot(-1)=M_{bd}-M_{ad}.$$

The two coefficients agree, as they must: $\mathrm{ad}(v)$ is skew and $W$ symmetric, so $[\mathrm{ad}(v),W]^{\mathsf T}=[W,-\mathrm{ad}(v)]=[\mathrm{ad}(v),W]$ and $A$ is symmetric. **The block's display, which gives both moves the same coefficient $(M_{bd}-M_{ad})$ and no sign, is right**, and right for a reason it does not give, the structure-constant sign flipping together with the eigenvalue difference.

$A$ annihilates $\varphi_{ab}$ and every $\varphi_{cd}$ disjoint from $\{a,b\}$, and preserves each plane $\mathrm{span}\{\varphi_{ad},\varphi_{bd}\}$, $d\ne a,b$. Each such $2\times2$ block is off-diagonal with two entries $\pm(M_{bd}-M_{ad})$, so

$$g_{ab}=\lVert A\rVert^2=\sum_{d\ne a,b}2(M_{ad}-M_{bd})^2 .$$

**The factor $2$, located.** It is the *two entries of each $2\times2$ block*, equivalently, PW 1.7's ordered-pair sum, in which the pair $\{(ad),(bd)\}$ is counted twice. The block gives two glosses, "two moved families" and "each $2\times2$ block carrying two nonzero entries"; these are one fact stated twice, not two independent factors, and the formula is right. **No finding: the constant is correct and the prose is redundant rather than wrong.**

**The middle step.** $\lVert M_a-M_b\rVert^2$ runs over all $n$ coordinates, of which $d=a$ gives $(M_{aa}-M_{ba})^2=M_{ab}^2$ and $d=b$ gives $(M_{ab}-M_{bb})^2=M_{ab}^2$, **both because $M$ is hollow**. So $\sum_{d\ne a,b}=\lVert M_a-M_b\rVert^2-2M_{ab}^2$ and $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$. Expanding $\lVert M_a-M_b\rVert^2=s_a+s_b-2\langle M_a,M_b\rangle$ and $\langle M_a,M_b\rangle=(M^2)_{ab}$ gives the third form. **All three forms confirmed.**

**"With no hypothesis at all", checked, and it holds.** $M\mathbf 1=0$ is not used, $\operatorname{tr}M^2=2$ is not used, criticality is not used. Hollowness *is* used at the middle step, and the block says so in the same sentence. The label is right read as "nothing beyond membership of the locus", which is how [conventions.md](../findings/conventions.md)'s $\mathcal D_n$ makes hollowness definitional rather than conditional.

**Two exact cross-checks, by hand, against the record's own pinned moments.** Both are independent of the block.

*First moment.* $\sum_{a<b}g_{ab}=\sum_{a\ne b}\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$. The square terms give $2(n-2)\sum_{a\ne d}M_{ad}^2=4(n-2)$ at $\lVert M\rVert_F^2=2$; the cross term gives $-2\sum_{a\ne b}(M^2)_{ab}=-2\big(\mathbf 1^{\mathsf T}M^2\mathbf 1-\operatorname{tr}M^2\big)=+4$ by $M\mathbf 1=0$. Total $4n-4=4(n-1)$, **exactly [conventions.md](../findings/conventions.md)'s $\sum_kg_k=4(n-1)\lVert W\rVert^2$.**

*Second moment.* $\sum_{a<b}M_{ab}g_{ab}=2\sum_{a<b}M_{ab}(s_a+s_b)-4\sum_{a<b}M_{ab}(M^2)_{ab}-4\sum_{a<b}M_{ab}^3$. The first term is $2\sum_as_a\sum_{b\ne a}M_{ab}=0$ by $M\mathbf 1=0$; the second is $-2\operatorname{tr}M^3$; the third is $-2\sum_{a,b}M_{ab}^3$. Total $-2\big(\operatorname{tr}M^3+\sum_{a,b}M_{ab}^3\big)=-4\theta$, **exactly $\sum_k\lambda_kg_k=-4P(W)$.** *Both checks use $M\mathbf 1=0$, which is the first sign that the standing hypothesis is doing work the block does not mention.*

### 1a. The specialisation claim

$R_{(ab)\alpha}=\sum_\beta T_{(ab)\alpha\beta}$ is nonzero only when $\alpha$ shares exactly one index with $(ab)$: for $\alpha=(ad)$, $d\ne a,b$, the single $\beta$ closing the triangle is $(bd)$ and $R=1$; for $\alpha=(ab)$ or $\alpha$ disjoint, $R=0$. Hence $\sum_\alpha\lambda_\alpha^2R_{(ab)\alpha}=\sum_{d\ne a,b}(M_{ad}^2+M_{bd}^2)=s_a+s_b-2M_{ab}^2$, the two subtractions being the $d=b$ and $d=a$ terms removed from $s_a$ and $s_b$. And $Q_{(ab)}=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{(ab)\alpha\beta}=2\sum_{d\ne a,b}M_{ad}M_{bd}=2\big[(M^2)_{ab}-M_{aa}M_{ba}-M_{ab}M_{bb}\big]=2(M^2)_{ab}$, **using hollowness a second time**. Substituting into $2\sum_\alpha\lambda_\alpha^2R-2Q$ returns (i)'s third form exactly. **The "not a new identity" claim is confirmed**, and the marginal $\sum_\alpha R_{(ab)\alpha}=2(n-2)$ agrees with the recorded row marginal.

## 2. Part (ii)

**$\Delta=0\iff$ every positive edge joins twins.** $\Delta$ is a sum of the non-negative $g_{ab}$ over $\{a<b:M_{ab}>0\}$, so it vanishes iff each term does, and $g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2=0$ iff $M_{ad}=M_{bd}$ for every $d\ne a,b$. **Both directions, no hypothesis.** *One unstated step:* the identification of $\{\lambda>0\}$ with $\{M_{ab}>0\}$ needs $\lambda_{(ab)}=M_{ab}$, which is [conventions.md](../findings/conventions.md)'s and is not in the block, which says only that the eigenvectors are the $\varphi_{ab}$.

**Transitivity, checked as written and at a concrete $M$.** As written: $a\!-\!b$ positive makes them twins, so taking $d=c$ (legitimate for $c\notin\{a,b\}$; for $c\in\{a,b\}$ the claim is vacuous) gives $M_{ac}=M_{bc}$, and $M_{bc}>0$ by hypothesis. **Correct.** At a concrete $M$: the balanced product at $n=6$, blocks $\{1,2,3\}$ and $\{4,5,6\}$, within-block $\tfrac16$, cross $-\tfrac19$, row sum $2\cdot\tfrac16-3\cdot\tfrac19=0$. Vertices $1,2$ agree at $d=3$ ($\tfrac16=\tfrac16$) and at $d=4,5,6$ ($-\tfrac19=-\tfrac19$), so $g_{12}=0$; $1\!-\!2$ and $2\!-\!3$ positive give $M_{13}=M_{23}=\tfrac16>0$. **Transitivity holds there.**

**And the $\Delta=0$ scope is load-bearing, exhibited.** At $n=4$ the locus is $M_{12}=M_{34}=\alpha$, $M_{13}=M_{24}=\beta$, $M_{14}=M_{23}=\gamma$ with $\alpha+\beta+\gamma=0$. Take $\alpha=\gamma=1$, $\beta=-2$: then $M_{12}>0$ and $M_{23}>0$ while $M_{13}=-2<0$, so positive linkage is **not** transitive there. That point has $\Delta>0$ ($1$ and $2$ differ at $d=3$) so it is consistent, and it shows the block's "**then**" is doing real work. **No finding: the sentence is correctly scoped.**

**The clique/constancy clauses.** Transitivity plus reflexivity on the positive edges makes each component of $G^+$ a clique of pairwise twins. Constancy *inside* a component: for $a,b,c$ in one component, $a,b$ twins at $d=c$ give $M_{ac}=M_{bc}$, and $c,d$ twins at $a$ give $M_{ac}=M_{ad}$, so a single intra-block value (trivially so at size $2$). Constancy *across* a pair of components: $a,b$ twins in $B$ and $c\in B'$ give $M_{ac}=M_{bc}$, and $c,d$ twins in $B'$ give $M_{ac}=M_{ad}$, **a per-pair constant, which is exactly what the block claims** and is weaker than a single global cross constant. Non-positivity across components is the definition of a component of $G^+$. **The converse is immediate**: in such an $M$ the positive edges are exactly the intra-block pairs, and for such a pair both $d\in B$ and $d\notin B$ give $M_{ad}=M_{bd}$, so every $g=0$. **All clauses confirmed.**

**The $C_5$ counter-illustration, verified exactly by hand.** From the recorded entries $4:-2:+1$ on blocks $(2,2,2,2,2)$ at $n=10$: the row sum is $4c-4\cdot2c+4c=0$ and $\sum_{a<b}M_{ab}^2=180c^2=1$, so $c=1/(6\sqrt5)$. A non-adjacent block pair carries $+c>0$, so it **is** a positive edge; its two endpoints differ at their own block partners ($4c$ against $c$) and at the two blocks adjacent to exactly one of them, giving $\sum_{d\ne a,b}(M_{ad}-M_{bd})^2=(9+9+0+18+18)c^2=54c^2$ and $g=108c^2=\tfrac35$. There are $5\cdot4=20$ such edges, and the $5$ within-block edges are twins with $g=0$, so $\Delta=20\cdot\tfrac35=12$, **the recorded value, reproduced in exact rationals.** The adjacent-block pairs give $g=216c^2=\tfrac65$ each, $20$ of them, and $20\cdot\tfrac65+12=24+12=36=4(n-1)$, **the first moment closes exactly.** So "block-constancy alone is not the condition", and the reason given for it, are both confirmed.

**The singleton corollary.** If $a$ carries no positive edge then $M_{ad}\le0$ for every $d$ and $\sum_dM_{ad}=0$, so row $a$ vanishes and every $\varphi_{ad}\in\ker W$. **Correct, and stronger than stated**, it needs no $\Delta=0$, only that $a$ is isolated in $G^+$. Contrapositively $\ker W=0$ forces every component to have size $\ge2$. *The step "they sum to $0$" is $M\mathbf 1=0$, used here without being named as a hypothesis anywhere in the block.*

### Discrepancy D1, "the generalised sphere-product shape" (claim C6)

**Located.** [diagonal-half.md](../findings/diagonal-half.md):96 (*"So $\Delta=0$ with $\ker W=0$ forces every block to have size $\ge2$), on this locus $\Delta=0$ is already the generalised sphere-product shape"*.

**Exhibited.** The shape the preceding clauses establish is: $k$ blocks of size $\ge2$, one positive constant inside each, one constant per ordered pair of blocks, all cross constants $\le0$. That admits $k\ge3$ with unequal cross constants. A concrete member at $n=6$: three blocks of size $2$, within-block $u$, all crosses $c$, and $u+4c=0$ makes $u=-4c>0$ for $c<0$, a $\Delta=0$ point with three factors, not two. **The phrase "generalised sphere-product shape" appears exactly once on the record**, here, and is defined nowhere; no correspondence between the combinatorial shape and a metric product of spheres is argued on the page or in [r519](../reviews/REVIEW_r519.md), [r520](../reviews/REVIEW_r520.md) or [REVIEW_r292.md](../reviews/REVIEW_r292.md).

**Argued the opposite.** The most charitable reading is that "generalised sphere-product" is intended to name precisely the $k$-block shape just derived, in which case the sentence is a definition-by-use and carries no content beyond the clauses above it. Under that reading nothing is false. What cannot be supported is the reading a consumer would naturally take (that a $\Delta=0$ diagonal point *is* a product of round spheres) since that is a statement about the geometry and the block derives only the combinatorics.

**Verdict: HYPOTHESIS-DEBT**, narrow. What would have to be shown: that every $M\in\mathcal D_n$ whose $G^+$-components are twin cliques of size $\ge2$ with non-positive per-pair cross constants is the sectional matrix of a product of round spheres, or, failing that, a definition of the term on the record. **Nothing else in (ii) depends on the phrase.**

## 3. Part (iii), the cap, and pre-registered questions 2 and 3

**The substitution.** The off-diagonal criticality equation gives $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$, so $-4(M^2)_{ab}-4M_{ab}^2=-4\theta M_{ab}$ and (i)'s third form becomes $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ for every $a\ne b$. **Confirmed.** With $g_{ab}\ge0$ this is $2\theta M_{ab}\le s_a+s_b$, for every $a\ne b$ and every sign of $\theta$. Dividing at a positive edge by $2M_{ab}>0$ gives $\theta\le(s_a+s_b)/(2M_{ab})$, and the "exactly" form is the same equation rearranged. **Confirmed.**

**Verified exactly at a non-trivial critical point.** At the $C_5$ blow-up, $s_a=36c^2$ for every $a$ ($16+16+4$ in units of $c^2$), and a within-block pair has $(M^2)_{ab}=(8+2+2+8)c^2=20c^2$, so criticality reads $16c^2+20c^2=\theta\cdot4c$ and $\theta=9c=9/(6\sqrt5)=3\sqrt5/10=0.670820\ldots$, **the recorded value, in closed form.** Then (iii) gives $2(72c^2)-4(9c)M_{ab}$, which is $0$, $216c^2$ and $108c^2$ at $M_{ab}=4c$, $-2c$, $+c$, **matching all three densities computed directly in §2.** At the balanced product $n=2m$: $\beta=-(m-1)\alpha/m$ from the row sum, $(m-1)(2m-1)\alpha^2=1$ from the norm, $s_a=1/m=2/n$, $\theta=\sqrt{(m-1)(2m-1)}/m=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$, and $(s_a+s_b)/(2M_{ab})=(2/m)/(2\alpha)=1/(m\alpha)=\theta$, **the cap is an equality there, for every $m$, in closed form.** *(This is the general-$m$ statement, so the block's "returning $\theta_0(n)$ at $n=6,\dots,20$" is a table of a fact that holds at every even $n$.)*

### Pre-registered question 2, "equality exactly at twin pairs", both directions

**Both directions hold, and they hold with no hypothesis beyond (i).** Equality in the cap at $(a,b)$ is $g_{ab}=0$, and $g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$ is a sum of squares, so $g_{ab}=0\iff M_{ad}=M_{bd}$ for every $d\notin\{a,b\}$. Neither direction needs criticality, hollowness, $M\mathbf 1=0$, or a sign on $M_{ab}$.

**What "twin" must mean for this to be true: agreement *off the pair*.** Under the graph-theorist's default (equal rows, $M_a=M_b$), the forward direction is **false**, and false at the record's own maximiser. At the balanced product, an intra-block pair has $g_{ab}=0$ while $M_a$ and $M_b$ differ in exactly two coordinates: $(M_a)_a=0$ against $(M_b)_a=\alpha$, and $(M_a)_b=\alpha$ against $(M_b)_b=0$. So $M_a=M_b$ additionally requires $M_{ab}=0$, and every equality case with a positive edge violates it. **The block defines the right sense**, "$M_{ad}=M_{bd}$ for every $d$ outside the pair", in (ii). **The finding is one of placement, not of truth:** (iii) uses the bare word "twin" and its definition sits in the preceding item, so a consumer who cites (iii)'s cap alone, as [ATTEMPTS.md](../ATTEMPTS.md):3267 does, quoting *"with equality exactly at twin pairs"*, carries a word whose only definition is elsewhere. **No finding on the mathematics; a naming hazard on the citation.** *The record has already paid for this once on the consumer side: [ATTEMPTS.md](../ATTEMPTS.md):3556 records the correction that L68 gives only the sum $s_j+s_k=2\theta M_{jk}$, the individual equality $s_j=s_k$ coming from twinness, which is right, and follows because twins agree on every coordinate off the pair while the two on-pair coordinates contribute $M_{ab}^2$ to each row.*

### Pre-registered question 3, what the cap actually needs

**Step by step, against the object.**

| step | what it consumes |
| --- | --- |
| $g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$ | $W$ diagonal in the coordinate pair basis; $M$ symmetric. PW 1.7's own hypotheses are met and are weaker |
| $=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2$ | **hollowness**, twice, the two dropped coordinates, and $\langle M_a,M_b\rangle=(M^2)_{ab}$ off the diagonal |
| $\Rightarrow g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ | the **multiplier-free** off-diagonal criticality equation |
| $\Rightarrow 2\theta M_{ab}\le s_a+s_b$ | $g_{ab}\ge0$, which is free |
| $\Rightarrow\theta\le\min_{M_{ab}>0}\frac{s_a+s_b}{2M_{ab}}$ | $M_{ab}>0$ at the dividing edge; the min is over a non-empty set because $M\ne0$ hollow with $M\mathbf 1=0$ has a positive entry |

**Row sums: yes, one further property is used and is not named.** The criticality equation of [diagonal-half.md](../findings/diagonal-half.md) is multiplier-free only because the file's own preceding paragraph kills the Ricci-flatness multiplier: summing $\big(M^{\circ2}+M^2\big)_{ij}=\theta M_{ij}+v_i+v_j$ over $j\ne i$ makes the left side $s_i-s_i=0$ **by $M\mathbf 1=0$ and $(M^2)\mathbf 1=0$**, leaving $(n-2)v_i+\mathbf 1^{\mathsf T}v=0$ and hence $v=0$ for $n\ge3$. Without $M\mathbf 1=0$ the off-diagonal equation carries $v_a+v_b$, and (iii) reads $g_{ab}=2(s_a+s_b)-4\theta M_{ab}-4(v_a+v_b)$, **not the stated cap.** So the block's "The cap needs criticality **and hollowness**" is complete relative to the *equation it quotes* and incomplete relative to *"at a critical point"*, which is how (iii)'s heading and [results.md](../results.md):777 both phrase it.

**Sign pattern: nothing unnamed.** The restriction to $M_{ab}>0$ appears only in the min-form and is stated. **Eigenvalue: one superfluous guard and one unstated identification.** The guard is C9 below; the identification $\lambda_{(ab)}=M_{ab}$ is [conventions.md](../findings/conventions.md)'s and is not in the block.

### Discrepancy D2, the $\theta>0$ guard is superfluous (claim C9)

**Located.** [diagonal-half.md](../findings/diagonal-half.md):101, *"so for $\theta>0$"*, guarding $\theta\le\min_{M_{ab}>0}\frac{s_a+s_b}{2M_{ab}}$.

**Exhibited.** The inequality $2\theta M_{ab}\le s_a+s_b$ divided by the strictly positive $2M_{ab}$ yields $\theta\le(s_a+s_b)/(2M_{ab})$ for **every real $\theta$**; the sign of $\theta$ enters nowhere. [r519](../reviews/REVIEW_r519.md):118 records "$\theta>0$ to divide | the record's sign convention", which is over-cautious for the same reason. The Lean form agrees with this reading and not with the block: [lean/INDEX.md](../lean/INDEX.md):110 states "**no sign condition on $\theta$ is needed**, where the block states the cap for $\theta>0$", and [L68.lean](../lean/HamiltonsCubic/Results/L68.lean)'s `entry_cap` takes `{θ : ℝ}` with no order hypothesis.

**Argued the opposite.** The guard may be there because the record normalises $W$ to $\theta>0$ before measuring $S$, a standing instruction in [conventions.md](../findings/conventions.md), in which case it is a scope reminder rather than a needed hypothesis. Under that reading the sentence is true and merely narrower than the mathematics.

**Verdict: the statement is PROVEN and the guard is superfluous.** It costs nothing here; it would cost a consumer who wanted the cap at a saddle with $\theta\le0$, where the cap in fact still holds. **No number changes.**

## 4. Part (iv), pre-registered question 1, the traced identity

**What the trace actually lands on.** Summing $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ over the unordered positive edges $G^+=\{a<b:M_{ab}>0\}$:

$$\Delta=\sum_{G^+}\big[2(s_a+s_b)-4\theta M_{ab}\big]=2\sum_ad_a^+s_a-4\theta P,\qquad P:=\sum_{a<b,\;M_{ab}>0}M_{ab},$$

the degree fibering $\sum_{G^+}(s_a+s_b)=\sum_ad_a^+s_a$ being immediate from $d_a^+=\#\{b:M_{ab}>0\}$. Rearranged, **the trace gives $2\theta P=\sum_ad_a^+s_a-\tfrac12\Delta$**, with $2P$ where the block writes $\lVert M\rVert_1$.

**Do the two reconcile, and by what property?** Yes, and by **$M\mathbf 1=0$ alone**. Write $N:=-\sum_{a<b}\min(M_{ab},0)$, so $\lVert M\rVert_1=P+N$. Hollowness and vanishing row sums give $\sum_{a<b}M_{ab}=\tfrac12\sum_{a}\sum_bM_{ab}=0$, i.e. $P=N$, hence $\lVert M\rVert_1=2P$ and $\theta\lVert M\rVert_1=2\theta P$. **The identity is exactly right as displayed.** *The negative edges are not omitted from the trace; they are accounted for by carrying exactly as much $\ell^1$ mass as the positive ones.*

**Is that property stated anywhere in the block? No.** The words "row sum", "Ricci-flat" and "$M\mathbf 1=0$" do not occur in [diagonal-half.md](../findings/diagonal-half.md):86–112. The nearest thing is (ii)'s corollary, which *uses* the property in the clause "and they sum to $0$" without naming it as a hypothesis, sixteen lines above and about a different claim. It is stated once at the top of the file, sixty lines above the block, as the second constraint on $\theta$, and it is definitional to $\mathcal D_n$ in [conventions.md](../findings/conventions.md).

### Discrepancy D3, (iv)'s decisive hypothesis is unnamed, and the bridge is unargued (claims C10, C11)

**Located.** [diagonal-half.md](../findings/diagonal-half.md):108–110, the whole of the written proof of (iv) is its heading, *"**(iv) Traced over $\mathfrak p$**, with $d_a^+=\#\{b:M_{ab}>0\}$ and $\lVert M\rVert_1=\sum_{a<b}\lvert M_{ab}\rvert$"*, followed by the display.

**Exhibited at a named object.** Take $M=m(J-I)$, the constant hollow matrix, at any $n\ge2$ with $m>0$. It is symmetric and hollow. $M^2=m^2\big((n-2)J+I\big)$, so $(M^2)_{ab}=(n-2)m^2$ off the diagonal and $(M^2)_{aa}=(n-1)m^2=s_a$; the criticality equation $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s)$ therefore holds **exactly**, with $\theta=(n-1)m$ off the diagonal and $0+(n-1)m^2=0+s_a$ on it. So $M$ satisfies **every hypothesis the block names for (iii) and (iv)** (hollowness and the criticality equation) and fails only $M\mathbf 1=0$, which the block never names.

At this $M$: every pair is a twin pair, so $\Delta=0$; $d_a^+=n-1$ and $s_a=(n-1)m^2$, so $\sum_ad_a^+s_a=n(n-1)^2m^2$; and $\lVert M\rVert_1=\binom n2m$, so $\theta\lVert M\rVert_1=\tfrac12n(n-1)^2m^2$. **The right side is exactly twice the left, at every $n$.** *Meanwhile (iii) survives intact there*: $g_{ab}=0$ and $2(s_a+s_b)-4\theta M_{ab}=4(n-1)m^2-4(n-1)m^2=0$, and the cap holds with equality. **So the exhibit separates the two parts precisely: $M\mathbf 1=0$ is inert for (iii) and decisive for (iv), and its absence costs (iv) a factor of two, the exact factor by which $P$ falls short of $\lVert M\rVert_1$.**

**Argued the opposite.** The most charitable reading the words support is that "on the diagonal locus", in the block's own heading, in (iv)'s "on the diagonal locus only", and in [results.md](../results.md):777, imports $\mathcal D_n$ wholesale from [conventions.md](../findings/conventions.md), row sums included. Under that reading **the identity is true as stated and $M=m(J-I)$ is simply not on the locus**, so nothing is refuted. That reading is available and I take it: the verdict on the identity itself is PROVEN. What the exhibit establishes is the narrower and still material point, that the hypothesis is load-bearing, is not derivable from the two the block does name, and that a reader reconstructing (iv) from the block's own hypothesis sentence ("The cap needs criticality **and hollowness**") reconstructs a false statement.

**Verdict: C10 PROVEN, hypotheses corrected** (add $M\mathbf 1=0$, and add criticality, which "Traced over $\mathfrak p$" also does not say). **C11 GAP**: the step from the trace's $2P$ to $\lVert M\rVert_1$ is a further, unstated equality, and no argument for it appears in the block. *It is on file elsewhere*, [r519](../reviews/REVIEW_r519.md):124 gives it in one clause, and [L68.lean](../lean/HamiltonsCubic/Results/L68.lean)'s `posSum` proves it from `hh` and `hr`, so this is a gap in the block, not in the record.

**Verified exactly at two points, by hand.** *$C_5$ blow-up:* $\lVert M\rVert_1=5\cdot4c+20\cdot2c+20\cdot c=80c$, so $\theta\lVert M\rVert_1=9c\cdot80c=720c^2=4$; and $d_a^+=1+4=5$ with $s_a=36c^2=\tfrac15$ gives $\sum_ad_a^+s_a=10$, against $\tfrac12\Delta=6$, so the right side is $10-6=4$. **Equal.** *Balanced product $n=2m$:* $\lVert M\rVert_1=m(m-1)\alpha+m(m-1)\alpha=2m(m-1)\alpha$, so $\theta\lVert M\rVert_1=2(m-1)^2(2m-1)\alpha^2=2(m-1)$; and $d_a^+=m-1$, $s_a=1/m$, $\Delta=0$ give $2m(m-1)/m=2(m-1)$. **Equal, at every $m$**, so "both (iii) and (iv) are equalities at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$" is a closed-form fact, not a table.

## 5. Quantifier order, scope, and the edge of every range

- **Quantifier order.** (i) and (iii) are stated per pair, "$(a\ne b)$", and (iii)'s cap is universally quantified over pairs before $\theta$ is bounded by a min, the right order, since a min over a set of upper bounds is itself an upper bound. **No finding.**
- **Smallest admissible $n$.** (i) needs $n\ge3$ for the moved set to be non-empty, and holds vacuously and correctly at $n=2$ ($g_{ab}=0$, and $2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2=4M_{ab}^2-0-4M_{ab}^2=0$). The multiplier-killing step needs $n\ge3$. **The locus itself is empty below $n=4$**: at $n\le3$, hollow symmetric with zero row sums forces $M=0$, which fails $\operatorname{tr}M^2=2$; at $n=4$ it is non-empty, and $\dim\mathcal W_n$ is $0$ at $n=3$ and $10$ at $n=4$, agreeing. **The block states no lower bound on $n$ and its figures start at $n=5$. Recorded, not a defect.**
- **$\theta\le0$.** The cap $2\theta M_{ab}\le s_a+s_b$ and the min-form both hold; see D2. **No finding beyond the superfluous guard.**
- **$\ker W\ne0$.** $\ker W$ is spanned by the $\varphi_{ab}$ with $M_{ab}=0$; $\Delta$ excludes them by the $\{\lambda>0\}$ convention, and every statement of the block is an identity at a fixed $M$, so the discontinuity of $\Delta$ at a zero crossing (which the file's fence documents), threatens nothing in (i)–(iv). (ii)'s corollary is the one place $\ker W=0$ is a hypothesis, and it is stated. **No finding.**
- **An $M$ with a zero row.** Then $s_a=0$, $d_a^+=0$, and $M_{ab}=0$ for all $b$. (i) gives $g_{ab}=2\sum_{d\ne a,b}M_{bd}^2=2(s_b-M_{ab}^2)=2s_b$, and the third form gives $2(0+s_b)-4(M^2)_{ab}-0$ with $(M^2)_{ab}=\sum_dM_{ad}M_{db}=0$, **agreeing.** The cap reads $0\le s_b$. (iv) is unaffected, $a$ contributing nothing to either side. **No finding.** By (ii)'s corollary this is exactly the isolated-vertex case.
- **The empty positive edge set.** The min in (iii) is over $\{M_{ab}>0\}$, which is non-empty for every $M\in\mathcal D_n\setminus\{0\}$: all entries $\le0$ with zero row sums forces $M=0$. **The block does not say this; [r519](../reviews/REVIEW_r519.md):118 does.** *It is one more silent use of the row sums.*

## 6. Compare the forms, the block, the canonical line, the index, and Lean

| site | what it states | hypotheses it carries |
| --- | --- | --- |
| [diagonal-half.md](../findings/diagonal-half.md):86–112, the block | (i)–(iv) in full, with the fence below it | diagonal locus; hollowness (named twice); criticality; $\ker W=0$ at (ii)'s corollary; $\theta>0$ at the min-form. **$M\mathbf 1=0$ never named** |
| [results.md](../results.md):777, the canonical line | (iii)'s affine form, the cap, and (iv) | "on the diagonal locus", "at a critical point". **No hollowness, no row sums, no quantifier on $(a,b)$, no twin clause** |
| [INDEX.md](../findings/INDEX.md):53 | $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$, the $\Delta=0$ classification, and the affine form "at a critical point" | **none.** The form printed is the one that *needs* hollowness |
| [lean/INDEX.md](../lean/INDEX.md):110 and [L68.lean](../lean/HamiltonsCubic/Results/L68.lean) | all four parts, **proved**, "with each hypothesis carried on the statement that uses it" | `hh` hollowness, `hs` symmetry, `hc` off-diagonal criticality, `hr` vanishing row sums, the last appearing **only** on `offSum_eq_zero`, `posSum`, `trace_conversion` and `trace_conversion'`, i.e. only on (iv) |

**A Lean row exists, it is `proved`, and it already carries this round's principal finding.** Its own words: *"(iv) needs (iii) plus **Ricci-flatness**, the vanishing row sums. The block never names that at this step; it is the standing hypothesis of the file, stated once at the top … and (iv) is the only one of the four that reaches for it."* Its `entry_cap` carries no sign hypothesis on $\theta$, matching D2. **My derivations above were made before reading the Lean row and agree with it on all three points**, the (iv) hypothesis, the superfluous $\theta$ guard, and the two-directional twin characterisation with no hypothesis at all.

**One divergence worth recording.** The Lean file states (iii) and the cap under `hc`, the *off-diagonal criticality equation*, taken as a hypothesis. That is faithful to the block's derivation and it is why `hr` does not appear there. It also means the Lean form does not certify the step the block's phrase "at a critical point" actually requires, that a critical point of $P$ on the diagonal locus satisfies `hc` **with no multiplier**, which is where $M\mathbf 1=0$ enters (iii) indirectly. **That step is on the record**, in the paragraph of [diagonal-half.md](../findings/diagonal-half.md) that derives $v=0$, and it is not in Lean; the row's "**Owed**" list names two other imports and not this one.

### Discrepancy D4, the round's own premise (claim C13)

**Located.** [ROUND_L68.md](ROUND_L68.md):5, *"Tier 1, cited eight or more times, and **single-audited**: one reviewer filed a verdict and no second ever ran, so nothing here has been drawn against twice."* The same status is printed at [results.md](../results.md):777 ("single-audited"), at [LEDGER.md](../findings/LEDGER.md):57 ("**A second reviewer is owed.**") and at [plan.md](../plan.md):244 ("Lemma L68 single-audited (r291 outstanding)").

**Exhibited.** [LEDGER.md](../findings/LEDGER.md):676 carries a second L68 row: *"### L68, verdict, both reviewers … [r519](../reviews/REVIEW_r519.md) and [r520](../reviews/REVIEW_r520.md), identical briefs, **both CONFIRMED**, each re-deriving parts (i)–(iv) from the definitions without using the block."* Both reports are on disk and both target L68 by name ([REVIEW_r519.md](../reviews/REVIEW_r519.md):3). So L68 has been drawn against by **three** reviewers (r292, r519, r520) and the two later ones ran on identical briefs, which is precisely the double-audit the round says never happened. **Their substantive output is visible in the current block**: r519's F1 repair (the false clause *"with $\lVert\varphi\rVert^2=2$ throughout"*) is gone, r520's hollowness repair is in ("criticality **and hollowness**"), and the two-moved-families gloss is in.

**Argued the opposite.** The charitable reading is that the four "single-audited" lines are all stale copies of the r291/r292 status from an earlier round, never updated when r519/r520 landed, and that the round brief inherited one of them. That is almost certainly what happened, and it makes the premise a bookkeeping failure rather than an error of fact about the mathematics.

**Verdict: BROKEN as a status claim**, with no consequence for (i)–(iv). **What it cost:** the round was allocated as a first double-audit of an unchallenged block, when in fact it is a fourth reading, and, more usefully, **two repairs those reviewers recommended were never applied**, which is the finding worth acting on:

- **[r519](../reviews/REVIEW_r519.md) F3**, *"(iv) omits its hypothesis … Repair: '(iv) Traced over $\mathfrak p$ at a critical point'"*. The block still reads "**(iv) Traced over $\mathfrak p$**". **Not applied.** *And the repair as proposed was itself incomplete: it adds criticality and still omits $M\mathbf 1=0$, which the same review's own §4 identifies as "one further use of $M\mathbf 1=0$".*
- **[r519](../reviews/REVIEW_r519.md) F4, seconded independently by [r520](../reviews/REVIEW_r520.md):75**, *"the $\Delta$ sum is unlabelled against the file's own convention … Repair: write $\sum_{a<b,\,M_{ab}>0}$"*. The block still reads $\Delta=\sum_{M_{ab}>0}g_{ab}$, and [conventions.md](../findings/conventions.md)'s default is that pair sums are **ordered**. Under the ordered reading $\Delta$ doubles and (iv) needs $\tfrac14\Delta$. **Not applied.** *This is the one unnamed convention in the block that changes a number.*

## 7. The gap between what is proven and what is used, and what a consumer may cite

**Proven, and citable with these hypotheses attached.**

- **(i), on the diagonal locus, for a symmetric hollow $M$:** all three forms of $g_{ab}$, and $g_{ab}\ge0$ with no hypothesis whatever. The first two moments $\sum g=4(n-1)$ and $\sum\lambda g=-4\theta$ fall out and both consume $M\mathbf 1=0$.
- **(ii), on the diagonal locus:** $\Delta=0$ iff every positive edge joins twins *in the off-the-pair sense*; the twin-clique classification with per-pair cross constants; the singleton corollary, **which consumes $M\mathbf 1=0$**. Not citable as written: "the generalised sphere-product shape" (D1).
- **(iii), for symmetric hollow $M$ satisfying the multiplier-free off-diagonal criticality equation:** $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ and $2\theta M_{ab}\le s_a+s_b$ for **every** $a\ne b$ and **every** sign of $\theta$, with equality iff $a,b$ agree off the pair. Add $M\mathbf 1=0$ if "critical point" rather than the equation is the hypothesis being cited.
- **(iv), additionally requiring $M\mathbf 1=0$:** $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$, with $\Delta$ the **unordered** positive-edge sum.

**Used, across the record, and the gap is small.** Every consumer I traced takes (i) or (iii) and none takes (iv): [ATTEMPTS.md](../ATTEMPTS.md):3161, :3239, :3269, :3546, :3574, :3594, :3677, :3691 all take $\lVert o^{(jk)}\rVert^2=s_j+s_k-2\theta M_{jk}$ or the free hollow cap $M_{ab}\le(s_a+s_b)/(2\theta)$; [diagonal-half.md](../findings/diagonal-half.md):529 and [INDEX.md](../findings/INDEX.md):75 take $g\ge0$ and the cap; [bounds-relaxations.md](../findings/bounds-relaxations.md):90 and :338 take the closed form, the second deriving the $C_5$ figures from it, **which I reproduced exactly in §2, so that consumer is sound.** [bounds.md](../findings/bounds.md)'s [L106](../findings/bounds.md) and [lean/INDEX.md](../lean/INDEX.md):159 take $g_\gamma\ge0$ and the twin characterisation, both of which are the hypothesis-free half. **So (iv), the one part whose hypotheses are wrong as written, has no consumer**, which is what [r519](../reviews/REVIEW_r519.md):134 said, and it still holds.

**One consumer-side correction already on the record, confirmed here.** [ATTEMPTS.md](../ATTEMPTS.md):3556, *"L68 gives only the sum $s_j+s_k=2\theta M_{jk}$; the individual equality comes from twinness"*, is right: the cap's equality case delivers the sum, and $s_j=s_k$ follows separately because twins agree at every $d\ne j,k$ while each row's two on-pair coordinates contribute $M_{jk}^2$ apiece.

## 8. The named trap, each citable claim read alone, as a consumer would

- **[results.md](../results.md):777.** Read alone it says: on the diagonal locus, at a critical point, $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$, the cap, and (iv). **It is sound only because "the diagonal locus" is $\mathcal D_n$**, which [conventions.md](../findings/conventions.md) defines as symmetric, hollow *and* zero-row-sum. A consumer who reads "diagonal locus" as "$W$ diagonal in coordinate $2$-planes", which is the phrase [conventions.md](../findings/conventions.md) itself glosses under "**'Diagonal' means diagonal in coordinate $2$-planes**", gets hollowness (forced by the pair antisymmetry) but **not** the row sums, and inherits a false (iv). *The line also sits inside the "Audit owed" section, whose preamble says none of its entries is cited above as a claim, so the record does fence it.*
- **[INDEX.md](../findings/INDEX.md):53.** Prints $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$ with no hypothesis at all. That form is **false without hollowness**, the two dropped coordinates equal $M_{ab}^2$ only when $M_{aa}=M_{bb}=0$. On the locus it is fine; off it, it is the form a reader would carry away.
- **The block's own hypothesis sentence.** *"The cap needs criticality **and hollowness**"* sits four lines below the cap and is the only place in the block where the hypotheses are enumerated. **A reader who trusts that enumeration reconstructs (iv) and gets it wrong by a factor of two**, the exhibit of D3. This is the trap in its exact form: the correction lives in [reviews/REVIEW_r519.md](../reviews/REVIEW_r519.md):134, in [lean/INDEX.md](../lean/INDEX.md):110 and in [L68.lean](../lean/HamiltonsCubic/Results/L68.lean)'s header comment, **three places beside the statement, none of them in it.**
- **The $\Delta$ sum.** $\Delta=\sum_{M_{ab}>0}g_{ab}$ read under the file's own stated default is the ordered sum, which doubles $\Delta$ and falsifies (iv) as printed. Two reviewers asked for the label; it is still absent. **This is the second correction that landed beside the statement rather than in it.**

## 9. What would break it, and what I did to look for it

**The object that would falsify (i)–(iii).** An $M\in\mathcal D_n$, critical, with a pair $a\ne b$ at which $2\theta M_{ab}>s_a+s_b$. By (iii) that is $g_{ab}<0$, and $g_{ab}$ is twice a sum of squares in the coordinates of $M$ itself, so such an object exists only if the substitution is wrong. **I looked for it by re-deriving the substitution from PW 1.7 read verbatim on file, and by evaluating (iii) in closed form at the two points the block anchors on**, the $C_5$ blow-up, where the three densities $0$, $\tfrac65$, $\tfrac35$ agree between the direct sum-of-squares and the affine form, and the balanced product at general even $n$, where the cap is an equality with $\theta=\theta_0(n)$. **Nothing of that shape exists.**

**The object that would falsify (iv) as scoped.** An $M\in\mathcal D_n$, critical, with $\theta\lVert M\rVert_1\ne\sum_ad_a^+s_a-\tfrac12\Delta$. Every step is an identity in the entries once $P=N$ is available, and $P=N$ is $\sum_{a<b}M_{ab}=0$, which is $M\mathbf 1=0$ with hollowness. **So no such object exists on the locus.** What I found instead, and looked for deliberately, by dropping each named hypothesis in turn and asking which the algebra actually needs, is the object that falsifies (iv) under the block's *own* stated hypothesis list: $M=m(J-I)$, symmetric, hollow, exactly critical in the multiplier-free sense, off the locus, breaking (iv) by a factor of two at every $n$ while leaving (iii) intact. **That is the sharpest available demonstration that the missing hypothesis is load-bearing rather than decorative.**

**The object that would falsify the twin characterisation.** A pair with $g_{ab}=0$ that is not twin, or a twin pair with $g_{ab}>0$. Both are impossible from the sum-of-squares form. **What does exist is a pair that is twin in the block's sense and not twin in the graph-theoretic sense** (every intra-block pair of every balanced product) which is why the sense must be quoted with the claim.

**What I did not do.** No script was run and no numerical value was taken from the record as evidence. The figures the block reports as sweeps, the violation maxima $+0.075,\dots,+0.368$ at $n=5,\dots,12$, the $n=6$ comparison $1.080123$ against $0.661300$, and the $n=7$ tolerance episode, are **not checked here** and are not needed by any of the four statements; the record's own [diagonal-half.md](../findings/diagonal-half.md):529 supplies the analytic replacement for the first of them, $2\theta M_{ab}-(s_a+s_b)=2\rho_{ab}-\tfrac12g_{ab}$ with $\rho_{ab}=\theta M_{ab}-M_{ab}^2-(M^2)_{ab}$, **which I verified expands correctly against (i)'s hypothesis-free form.** The fence's *"among contractions using only $g\ge0$, 'min over positive edges' is LP-optimal"* has no argument on the page or in the three reviews; it lies outside (i)–(iv) and is recorded here as fence-level debt, unadjudicated.

## Verdict

**PROVEN, hypotheses corrected.**

All four displayed statements of L68 are true, and each was re-derived here from the definitions and checked in closed form at the $C_5$ blow-up and at the balanced product. The corrections owed are to the hypothesis list and to two labels, and they change no number that any consumer takes:

1. **(iv) requires $M\mathbf 1=0$ and criticality, and names neither.** Add both to the block, to [results.md](../results.md):777 and to [INDEX.md](../findings/INDEX.md):53. *(Recommended by [r519](../reviews/REVIEW_r519.md) F3 in part, and by [lean/INDEX.md](../lean/INDEX.md):110 in full; never applied.)*
2. **$\Delta$ must be labelled as the unordered positive-edge sum**, against the file's own stated default. *(Recommended by [r519](../reviews/REVIEW_r519.md) F4 and [r520](../reviews/REVIEW_r520.md); never applied. It is the one unnamed convention here that changes a number.)*
3. **(iii)'s "criticality and hollowness" is complete only for the equation it quotes**; under "at a critical point" it needs $M\mathbf 1=0$ as well, to kill the Ricci-flatness multiplier.
4. **The $\theta>0$ guard is superfluous** and the cap holds at every sign of $\theta$, as the Lean form already states.
5. **"The generalised sphere-product shape" is HYPOTHESIS-DEBT**, undefined on the record, with no correspondence argued (D1).
6. **The round's "single-audited" premise is false**, [r519](../reviews/REVIEW_r519.md) and [r520](../reviews/REVIEW_r520.md) both CONFIRMED L68 on identical briefs, and four status lines are stale (D4).

*The one part whose hypotheses are wrong as written, (iv), has no consumer anywhere on the record, so nothing downstream is disturbed.*
