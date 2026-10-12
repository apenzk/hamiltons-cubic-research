# VERIFY v115, L68: the diagonal density $g_{ab}$, the twin characterisation of $\Delta=0$, the entry cap $2\theta M_{ab}\le s_a+s_b$, and the traced identity $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$

**Cold brief.** Verifier v115 on [ROUND_L68.md](ROUND_L68.md), checking the block at [diagonal-half.md](../findings/diagonal-half.md):86–112 and the canonical line at [results.md](../results.md):777. **No numerical work was done: no script was run, and every value below is an exact hand evaluation.** Sources were read on disk, [Petersen–Wink notes](../references/petersen-wink-2019-bochner-technique/notes.md) included; nothing is cited from memory. Log: [agent_logs/verify-L68-v115.log](../agent_logs/verify-L68-v115.log). No other verifier's report was opened.

## Claim table

| # | claim, as written | verdict |
| --- | --- | --- |
| (i) | $g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2=2\lVert M_a-M_b\rVert^2-4M_{ab}^2=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2$, "with no hypothesis at all" | **PROVEN, HYPOTHESES CORRECTED** (needs hollowness and symmetry; the block names hollowness for the middle step only) |
| (i-b) | the factor $2$, from two moved families, under the half-trace pairing | **PROVEN** |
| (i-c) | it is the diagonal specialisation of $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$, with $Q_{(ab)}=2(M^2)_{ab}$ | **PROVEN** |
| (ii) | $\Delta=0$ iff every positive edge joins twins ($M_{ad}=M_{bd}$ for $d$ outside the pair) | **PROVEN** |
| (ii-b) | linkage is transitive under $\Delta=0$ | **PROVEN** |
| (ii-c) | the components of $G^+$ are twin cliques, $M$ block-constant, cross entries $\le0$; and the converse | **PROVEN** |
| (ii-d) | a singleton block forces a zero row, so $\Delta=0$ with $\ker W=0$ forces every block size $\ge2$ | **PROVEN, HYPOTHESES CORRECTED** (uses $M\mathbf1=0$, unnamed here) |
| (ii-e) | "$\Delta=0$ is already the generalised sphere-product shape" | **HYPOTHESIS-DEBT** (the term is defined nowhere on the record; under the two-block reading it is false, witness below) |
| (iii) | $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ at a diagonal critical point | **PROVEN, HYPOTHESES CORRECTED** |
| (iii-b) | the cap $2\theta M_{ab}\le s_a+s_b$, and $\theta\le\min_{M_{ab}>0}(s_a+s_b)/(2M_{ab})$ for $\theta>0$ | **PROVEN, HYPOTHESES CORRECTED** ($\theta>0$ is not needed for the min form; nonemptiness of the min needs $M\mathbf1=0$) |
| (iii-c) | equality exactly at twin pairs | **PROVEN** in the off-pair sense only; **BROKEN** under the identical-rows sense of "twin" |
| (iii-d) | "The cap needs criticality **and hollowness**" | **BROKEN as an enumeration**, Ricci-flatness $M\mathbf1=0$ and the normalisation $\lVert W\rVert=1$ are both used and neither is named |
| (iv) | $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$ | **PROVEN (HYPOTHESES CORRECTED**), true, and false without $\mathbf1^{\mathsf T}M\mathbf1=0$; falsifier exhibited at $n=3$ |
|, | the canonical line, [results.md](../results.md):777 | **HYPOTHESIS-DEBT**, it carries no hypothesis at all for either the cap or the traced identity |

**Summary in one line.** Every mathematical statement in the block is true and I reproduced each derivation independently, but the block's own hypothesis enumeration is incomplete in exactly the place its pre-registered question points at: **Ricci-flatness $M\mathbf1=0$ is what reconciles the positive-edge sum with the full $\ell^1$ norm in (iv), it is used a second time to kill the Lagrange multiplier that makes (iii)'s criticality equation read with coefficient $\theta$, and it is named nowhere in the block or in the canonical line.**

## 0. Conventions, fixed once

Read off [conventions.md](../findings/conventions.md) and [diagonal-half.md](../findings/diagonal-half.md), not assumed.

- $\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf1=0\}$, "the vertex matrices of coordinate-diagonal Weyl operators" ([conventions.md](../findings/conventions.md):37). **So $M\mathbf1=0$ is part of what "the diagonal locus" means**; it is the Ricci-flatness constraint, written $\sum_{b\ne a}w_{ab}=0$ at [diagonal-half.md](../findings/diagonal-half.md):15.
- The normalisation on that locus is $\operatorname{tr}M=0$, $\operatorname{tr}M^2=2$ ([diagonal-half.md](../findings/diagonal-half.md):25), which is $\lVert W\rVert=1$ under the half-trace.
- $\theta=P(W)/\lVert W\rVert^3$, and **at a critical point** $Q(W)=\theta W$ ([conventions.md](../findings/conventions.md):17). $\theta$ is degree-$0$ homogeneous while $Q$ is quadratic, so the equation with coefficient $\theta$ is an equation at $\lVert W\rVert=1$ and at no other scale.
- The inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ **at the $\Lambda^2$ level and plain Frobenius at the operator level** ([conventions.md](../findings/conventions.md):57), so $\lVert\varphi_{ab}\rVert^2=1$, $\{\varphi_{ab}\}_{a<b}$ is orthonormal, and $\lVert A\rVert^2=\sum_{a<b}\lVert A\varphi_{ab}\rVert^2$ for an operator $A$ on $\Lambda^2$.
- $\Delta$ is traced over $\{\lambda>0\}$ only ([conventions.md](../findings/conventions.md):39). $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, manifestly $\ge0$ ([conventions.md](../findings/conventions.md):40), with the two pinned moments $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$.
- On the diagonal locus $\lambda_{(ab)}=M_{ab}$, and $\{\varphi_{ab}:M_{ab}>0\}$ is an orthonormal basis of the strictly positive eigenspace, so $\Delta=\sum_{a<b,\,M_{ab}>0}g_{ab}$. $\Delta$ is a trace of a quadratic form over a subspace, hence independent of which orthonormal eigenbasis is chosen inside a degenerate eigenvalue.

## 1. The hypothesis inventory

**(A) Hypotheses the block carries, explicitly.** $M$ symmetric with real entries; $M$ hollow (named at (i) and again at (iii)); $W$ coordinate-diagonal, so the eigenvectors are the $\varphi_{ab}$ and the structure tensor is the single monomial; $W$ a critical point (named at (iii) and inherited by (iv)); $g_{ab}\ge0$; $\theta>0$ (named for the min form only); $\ker W=0$ (named for the (ii) corollary only).

**(B) Hypotheses the block carries silently, from the ambient file.** $M\in\mathcal D_n$, hence $M\mathbf1=0$, Ricci-flatness. $\operatorname{tr}M^2=2$, i.e. $\lVert W\rVert=1$. $n\ge4$, since $\mathcal W_n$ is trivial below that and since $\mathcal D_n=\{0\}$ at $n\le3$ (§8).

**(C) Imported results, and their hypotheses checked against the object here.**

| import | its hypotheses | met here? |
| --- | --- | --- |
| [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7, read verbatim on file | $R\in\mathrm{Sym}^2(\Lambda^2V)$; $\{\Xi_\alpha\}$ an **orthonormal** basis of $\Lambda^2V$ **diagonalising** $R$; $L\in\mathfrak{so}(V)$ | **Yes.** $W\in\mathcal W_n\subset\mathrm{Sym}^2(\Lambda^2)$; $\{\varphi_{ab}\}_{a<b}$ is orthonormal under the half-trace and diagonalises a coordinate-diagonal $W$; $L=\varphi_{ab}\in\mathfrak{so}(n)$. Prop 1.7 needs **no** curvature hypothesis (no Ricci-flatness, no first Bianchi, no criticality) so nothing is smuggled in through it |
| the record's translation $\lVert[\mathrm{ad}_{v_\gamma},W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$ | that $\lvert LR\rvert$ is the plain Frobenius norm on $\Lambda^2\times\Lambda^2$ | **Yes**, and it is forced: $(LR)(\Xi_\alpha,\Xi_\beta)=(\lambda_\alpha-\lambda_\beta)g(L\Xi_\alpha,\Xi_\beta)$ has zero diagonal, so $\sum_{\alpha,\beta}=2\sum_{\alpha<\beta}$, which is Prop 1.7's own factor $2$ |
| the recorded decomposition $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$ of [bounds.md](../findings/bounds.md) | total symmetry of $T_{\gamma\alpha\beta}$ | **Yes**, $c'_{\gamma\alpha\beta}=\langle[v_\gamma,v_\alpha],v_\beta\rangle$ is totally antisymmetric, so its square is totally symmetric, which is what lets $\sum\lambda_\alpha^2T$ and $\sum\lambda_\beta^2T$ be merged |
| the boxed criticality equation, [diagonal-half.md](../findings/diagonal-half.md):80 | $W=\mathrm{diag}(w)\in\mathrm{Weyl}_n$, **of unit norm**; and $v=0$, proved from $M\mathbf1=0$ and $(M^2)\mathbf1=0$ | **Yes on the locus, and both hypotheses are dropped when (iii) quotes it.** The box says "of unit norm" and the multiplier proof says $M\mathbf1=0$; (iii) says only "the criticality equation above" |
| the "if" direction of that box | symmetric criticality, the diagonal locus is the fixed-point set of the coordinate sign-flip group | not used here; (iii) consumes only the "only if" direction |

**(D) Which of these the written proof actually uses.** (i) uses symmetry and hollowness. (ii) uses (i) alone, plus $M\mathbf1=0$ for its corollary. (iii) uses (i), the off-diagonal criticality equation, and (for that equation to read with coefficient $\theta$ and no multiplier), $M\mathbf1=0$ and $\operatorname{tr}M^2=2$. (iv) uses (iii) plus $\mathbf1^{\mathsf T}M\mathbf1=0$, a use that is internal to (iv) and irreducible.

## 2. (i), the density, rederived twice and cross-checked against two pinned moments

**The commutator, by hand.** $[\mathrm{ad}(\varphi_{ab}),W]\varphi_{cd}=\lambda_{cd}[\varphi_{ab},\varphi_{cd}]-W[\varphi_{ab},\varphi_{cd}]$. With the structure monomial $[\varphi_{ab},\varphi_{bd}]=\varphi_{ad}$:

- on $\varphi_{bd}$, $d\ne a,b$: $M_{bd}\varphi_{ad}-M_{ad}\varphi_{ad}=(M_{bd}-M_{ad})\varphi_{ad}$;
- on $\varphi_{ad}$, $d\ne a,b$: $[\varphi_{ab},\varphi_{ad}]=-[\varphi_{ba},\varphi_{ad}]=-\varphi_{bd}$, so the image is $-M_{ad}\varphi_{bd}+M_{bd}\varphi_{bd}=(M_{bd}-M_{ad})\varphi_{bd}$;
- on $\varphi_{ab}$ and on any $\varphi_{cd}$ disjoint from $\{a,b\}$: zero.

**Both displayed arrows are correct**, and the operator is block-diagonal in the $n-2$ planes $\mathrm{span}(\varphi_{ad},\varphi_{bd})$, each block the symmetric off-diagonal pair $\varphi_{ad}\mapsto c_d\varphi_{bd}$, $\varphi_{bd}\mapsto c_d\varphi_{ad}$ with $c_d=M_{bd}-M_{ad}$. Since $\{a,d\}$ and $\{b,d\}$ are distinct unordered pairs, each is counted once in $\sum_{a<b}$, and the operator-level Frobenius norm gives $\lVert[\mathrm{ad}(\varphi_{ab}),W]\rVert^2=\sum_{d\ne a,b}(c_d^2+c_d^2)=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$. **The factor $2$ is right, and the block's explanation of it (two moved families, each block carrying two nonzero entries), is the correct explanation.** It is exactly the $2(n-2)$ moved directions the block names.

**The same, through Petersen–Wink Prop 1.7.** For $\gamma=(ab)$ the only nonvanishing $T_{\gamma\alpha\beta}$ are $T_{(ab),(bd),(ad)}=T_{(ab),(ad),(bd)}=1$ for each $d\ne a,b$, so $g_{ab}=\sum_{d\ne a,b}\big[(M_{bd}-M_{ad})^2+(M_{ad}-M_{bd})^2\big]=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$. **The two routes agree, and the second uses no hypothesis on $M$ beyond symmetry.**

**The middle and right steps.** $\lVert M_a-M_b\rVert^2=\sum_d(M_{ad}-M_{bd})^2$, and the two dropped coordinates are $d=a$, giving $(M_{aa}-M_{ba})^2=M_{ab}^2$, and $d=b$, giving $(M_{ab}-M_{bb})^2=M_{ab}^2$, **both evaluations consume $M_{aa}=M_{bb}=0$**, which is the hollowness the block names. Hence $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$, and expanding $\lVert M_a-M_b\rVert^2=s_a+s_b-2\langle M_a,M_b\rangle=s_a+s_b-2(M^2)_{ab}$ gives the third form. **All three forms check.**

**The claimed specialisation.** $R_{(ab)\alpha}=\sum_\beta T_{(ab)\alpha\beta}$ is $1$ exactly when $\alpha$ shares one index with $\{a,b\}$, so $\sum_\alpha\lambda_\alpha^2R_{(ab)\alpha}=\sum_{d\ne a,b}(M_{ad}^2+M_{bd}^2)=(s_a-M_{ab}^2)+(s_b-M_{ab}^2)$, **as written**. And $Q_{(ab)}=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T=2\sum_{d\ne a,b}M_{ad}M_{bd}=2(M^2)_{ab}$, **where the last equality is a second use of hollowness**, the $d=a$ and $d=b$ terms of $(M^2)_{ab}$ are $M_{aa}M_{ab}$ and $M_{ab}M_{bb}$. The block attributes hollowness to the middle step only; it is used here too.

**Two independent confirmations, exact.** Summing the closed form over all pairs, $\sum_{a<b}g_{ab}=2\sum_{a<b}\lVert M_a-M_b\rVert^2-4\sum_{a<b}M_{ab}^2$. Now $\sum_{a,b}\lVert M_a-M_b\rVert^2=2n\operatorname{tr}M^2-2\,\mathbf1^{\mathsf T}M^2\mathbf1=4n-0$, using $\operatorname{tr}M^2=2$ and $\mathbf1^{\mathsf T}M^2\mathbf1=\lVert M\mathbf1\rVert^2=0$; halving gives $2n$, and $\sum_{a<b}M_{ab}^2=1$. So $\sum_{a<b}g_{ab}=4n-4=4(n-1)$, **exactly [conventions.md](../findings/conventions.md):40's pinned first moment $4(n-1)\lVert W\rVert^2$.** For the second, $\sum_{a<b}M_{ab}(s_a+s_b)=\tfrac12\sum_{a,b}M_{ab}(s_a+s_b)=0$ by $M\mathbf1=0$, $\sum_{a<b}M_{ab}(M^2)_{ab}=\tfrac12\operatorname{tr}M^3$ and $\sum_{a<b}M_{ab}^3=\tfrac12\sum_{a,b}M_{ab}^3$, so $\sum_{a<b}M_{ab}g_{ab}=-2\big(\operatorname{tr}M^3+\sum_{a,b}M_{ab}^3\big)=-4\theta$, **exactly the pinned second moment $-4P(W)$** through [diagonal-half.md](../findings/diagonal-half.md):25's $\theta=\tfrac12(\sum_{a,b}M_{ab}^3+\operatorname{tr}M^3)$. Both checks pass, and **both consume $M\mathbf1=0$**, the first to kill $\mathbf1^{\mathsf T}M^2\mathbf1$, the second to kill $\sum_bM_{ab}$.

**Verdict on the heading "with no hypothesis at all".** The identity holds for every real symmetric hollow $M$; symmetry and hollowness are hypotheses, and hollowness is used twice. **No finding beyond that**, the heading means "no criticality", which is true, and the block says so plainly two lines later.

## 3. (ii), the twin characterisation, transitivity at a concrete $M$, and the corollary

**$\Delta=0$ iff every positive edge joins twins.** $\Delta=\sum_{a<b,\,M_{ab}>0}g_{ab}$ is a sum of terms each of which is a sum of squares, so it vanishes iff each $g_{ab}$ with $M_{ab}>0$ vanishes, iff $M_{ad}=M_{bd}$ for every $d\ne a,b$. **Correct, both directions, and it needs (i) alone.**

**Transitivity, checked as written.** The sentence is "Linkage is then transitive, because $a\!-\!b$ and $b\!-\!c$ positive force $M_{ac}=M_{bc}>0$". The word **then** scopes it under $\Delta=0$, and that scoping is load-bearing: with $a\!-\!b$ positive and $\Delta=0$, the pair $\{a,b\}$ is twin, so $M_{ad}=M_{bd}$ at $d=c$ provided $c\notin\{a,b\}$; then $M_{ac}=M_{bc}>0$. **Correct.** At $c\in\{a,b\}$ the claim is vacuous.

*At a concrete $M$.* Take $n=6$ with blocks $\{1,2,3\}$, $\{4,5,6\}$, within-block entry $\tfrac16$ and cross entry $-\tfrac19$; row sums are $2\cdot\tfrac16-3\cdot\tfrac19=\tfrac13-\tfrac13=0$, so $M\in\mathcal D_6$. Every positive edge lies inside a block and is twin ($M_{1d}=M_{2d}$ for $d=3$ at $\tfrac16$ and for $d=4,5,6$ at $-\tfrac19$), so $\Delta=0$. The path $1\!-\!2$, $2\!-\!3$ closes: $M_{13}=M_{23}=\tfrac16>0$. **Transitivity confirmed at this point.** Dropping $\Delta=0$ breaks it: a path-weighted $M$ with $M_{12},M_{23}>0$ and $M_{13}<0$ is a positive linkage that is not transitive, which is why the "then" must stay attached in any citation.

**Twin cliques, block-constancy, and the converse.** Inside a component $C$ with $\lvert C\rvert\ge3$ and $a,b,c\in C$ distinct: twinness of $\{a,b\}$ at $d=c$ gives $M_{ac}=M_{bc}$, and of $\{a,c\}$ at $d=b$ gives $M_{ab}=M_{cb}$, so all three agree, $M$ is constant inside. Across components $C\ne C'$ with $a,b\in C$ and $c,c'\in C'$: $M_{ac}=M_{bc}$ from $\{a,b\}$ twin at $d=c$, and $M_{ac}=M_{ac'}$ from $\{c,c'\}$ twin at $d=a$, so $M$ is constant across; when both components are singletons the pair carries one entry and constancy is vacuous. Cross entries are $\le0$ by the definition of $G^+$'s components. **Correct.** Converse: for a positive edge $ab$ inside a block, $M_{ad}=M_{bd}$ holds at $d$ in the same block by within-block constancy and at $d$ outside by cross-block constancy, so $g_{ab}=0$ and $\Delta=0$. **Correct.**

**The singleton corollary.** "a singleton block forces an identically zero row, since all its entries are cross entries, hence $\le0$, and they sum to $0$". The step "they sum to $0$" **is $M\mathbf1=0$**, which the block does not name anywhere in the L68 text. It is true on $\mathcal D_n$, so the corollary is correct; the enumeration is what is short. A zero row makes every $\varphi_{ad}$ a kernel vector, so $\ker W\ne0$; contrapositively $\Delta=0$ with $\ker W=0$ forces every block to have size $\ge2$. **Correct**, and it needs $n\ge2$ so that some $d$ exists.

### 3.1 Discrepancy, "on this locus $\Delta=0$ is already the generalised sphere-product shape"

**Located.** [diagonal-half.md](../findings/diagonal-half.md):96, the clause after the singleton corollary.

**Exhibited.** Take $n=6$ with three blocks $\{1,2\},\{3,4\},\{5,6\}$, within-block entry $\alpha>0$ and every cross entry $-\alpha/4$. Row sums are $\alpha+4\cdot(-\alpha/4)=0$, so $M\in\mathcal D_6$; scale $\alpha$ to meet $\operatorname{tr}M^2=2$. Every positive edge is within a block of size $2$ and is twin, so $\Delta=0$; every entry is nonzero, so $\ker W=0$; every block has size $\ge2$. **Its positive graph has three components, where a sphere product $S^p\times S^q$ has two.** So the sentence is false if "generalised sphere-product shape" is read as a two-factor product.

**Argued the opposite.** The most charitable reading is that "generalised" is doing exactly the work of admitting $k\ge2$ blocks (a multi-factor product shape), under which the sentence is true and my object is an instance rather than a counterexample. **I grep'd [findings/](../findings/) and [results.md](../results.md) for "generalised sphere" and "generalized sphere" and the phrase occurs at this one line and nowhere else**, so the record supplies no definition to settle it.

**Grade: HYPOTHESIS-DEBT, not BROKEN.** What is owed is one sentence defining the term, or replacing it with the description the same line already gives, block-constant with every block of size at least two, positive within blocks and nonpositive across.

## 4. (iii), the affine form, the cap, and what the cap actually needs

**The substitution.** The off-diagonal reading of the boxed criticality equation is $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ for $a\ne b$. Substituting into $g_{ab}=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2=2(s_a+s_b)-4\big[M_{ab}^2+(M^2)_{ab}\big]$ gives $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$. **Correct**, and it is one line, as claimed.

**The cap.** $g_{ab}\ge0$ gives $4\theta M_{ab}\le2(s_a+s_b)$, i.e. $2\theta M_{ab}\le s_a+s_b$, **for every $a\ne b$ and every sign of $\theta$ and of $M_{ab}$**, the statement is one-sided in $M_{ab}$, and at negative entries with $\theta>0$ it is slack. Dividing by $2M_{ab}>0$ gives $\theta\le(s_a+s_b)/(2M_{ab})$ at each positive edge, hence the min form. **Correct.**

*A hypothesis the block states and does not need.* The min form is introduced with "so for $\theta>0$". Division by $2M_{ab}>0$ preserves the inequality whatever the sign of $\theta$, so the guard is redundant. It is harmless (a redundant hypothesis weakens a statement, it does not falsify it) and I record it because [lean/INDEX.md](../lean/INDEX.md):110 reads the same guard as sitting on the cap itself, where it also is not needed.

*A hypothesis the block does not state and does need.* The min is over $\{ab:M_{ab}>0\}$, and **that set is nonempty only because $\mathbf1^{\mathsf T}M\mathbf1=0$ with $M\ne0$** forces a positive entry. On $\mathcal D_n$ with $\operatorname{tr}M^2=2$ that holds; stated without it, the right-hand side is a minimum over a possibly empty set.

**The exact form.** From $4\theta M_{ab}=2(s_a+s_b)-g_{ab}$, dividing by $4M_{ab}$ gives $\theta=(s_a+s_b)/(2M_{ab})-g_{ab}/(4M_{ab})$. **Correct**, and it holds at every $M_{ab}\ne0$, not only at positive edges, the block's "at every positive edge" is a restriction, not an error.

**The equality clause, checked in both directions (pre-registered question 2).** Equality in $2\theta M_{ab}\le s_a+s_b$ holds iff $g_{ab}=0$, and by (i) $g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$ is a sum of squares, so $g_{ab}=0\iff M_{ad}=M_{bd}$ for every $d\notin\{a,b\}$. **Both directions hold, and both are immediate.** But they hold **only for the off-pair sense of "twin"**:

- **$g_{ab}=0\Rightarrow$ twin.** True in the off-pair sense. **False in the identical-rows sense**: identical rows would require $M_{aa}=M_{ba}$, i.e. $M_{ab}=0$, so at a positive edge (the only place the min form and the traced identity ever evaluate the clause), $g_{ab}=0$ never gives identical rows.
- **Twin $\Rightarrow g_{ab}=0$.** True in both senses, the identical-rows sense being strictly stronger.

**So "twin" must mean "$M_{ad}=M_{bd}$ for every $d$ outside the pair", and under the identical-rows reading one direction of the equality clause is false at exactly the edges the lemma is used on.** (ii) spells the off-pair sense out; **(iii) writes only "with equality exactly at twin pairs", 8 lines and one display below it**, and the canonical line at [results.md](../results.md):777 does not carry the clause at all.

### 4.1 Discrepancy, "The cap needs criticality **and hollowness**"

**Located.** [diagonal-half.md](../findings/diagonal-half.md):106, first clause: "The cap needs criticality **and hollowness**, hollowness is what makes the two dropped coordinates equal $M_{ab}^2$ … and criticality converts the left side."

**Exhibited.** The sentence is an enumeration of what the cap needs, and two further hypotheses are consumed inside "criticality":

1. **$M\mathbf1=0$.** The Euler–Lagrange condition on the diagonal locus is $(M^{\circ2}+M^2)_{ij}=\theta M_{ij}+v_i+v_j$ ([diagonal-half.md](../findings/diagonal-half.md):74), and the multiplier-free box at [diagonal-half.md](../findings/diagonal-half.md):80 exists only because $v=0$, proved on the two lines above it by summing over $j\ne i$ and using $M\mathbf1=0$ and $(M^2)\mathbf1=0$. Without it the off-diagonal reading is $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}+v_a+v_b$, the substitution yields $g_{ab}=2(s_a+s_b)-4\theta M_{ab}-4(v_a+v_b)$, and the cap becomes $2\theta M_{ab}\le s_a+s_b-2(v_a+v_b)$, a different inequality.
2. **$\operatorname{tr}M^2=2$.** The coefficient in the box is $\theta$ rather than an unnamed multiplier $c$ because contracting the equation against $M$ gives $2\theta=\langle M^{\circ2}+M^2,M\rangle=c\lVert M\rVert_F^2+\sum_as_aM_{aa}=2c$, using $\operatorname{tr}M^2=2$ and hollowness. Since $\theta=P(W)/\lVert W\rVert^3$ is scale-invariant while $c$ scales linearly (replacing $M$ by $tM$ sends $c\mapsto tc$), **the identification $c=\theta$ is an equation at unit norm and at no other scale.** The box says "of unit norm"; (iii) quotes the box as "the criticality equation above" and drops it.

**Argued the opposite.** The most charitable reading is that both are ambient: L68 sits inside a file whose standing object is $M\in\mathcal D_n$ with $\operatorname{tr}M^2=2$, and [conventions.md](../findings/conventions.md):37 makes $M\mathbf1=0$ part of what "the diagonal locus" denotes, so a reader who has the object has the hypotheses. **That reading defends the mathematics and not the sentence**: hollowness is equally ambient, and the sentence names it. A sentence whose entire function is to enumerate what a statement needs is wrong when its enumeration is a proper subset of what the statement needs, and this one is missing two of four.

**Grade: BROKEN as an enumeration; the cap itself is PROVEN under the corrected list.** The corrected list is: **$M$ symmetric and hollow, $M\mathbf1=0$, $\operatorname{tr}M^2=2$, and $W$ critical.** Equivalently, and more usefully to a consumer: the cap follows from symmetry, hollowness and the bare off-diagonal equation $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ taken as a hypothesis on a number $\theta$, and it is the *derivation of that equation from criticality* which consumes Ricci-flatness and the normalisation.

**The sweep in the same sentence.** "maximising the violation over the diagonal locus without it reaches $+0.075,\dots,+0.368$ at $n=5,\dots,12$" is a numerical claim I did not and may not check; it is reported here as unverified numerics. It is also superseded on the record by an identity, [Lemma L130](../findings/diagonal-half.md):527 gives $2\theta M_{ab}-(s_a+s_b)=2\rho_{ab}-\tfrac12g_{ab}$, so the cap fails exactly when $\rho_{ab}>\tfrac14g_{ab}$, which settles load-bearingness without a sweep.

## 5. (iv), the traced identity, and the property that reconciles the two sums

This is pre-registered question 1, and it has a clean answer.

**The derivation, in full.** Sum $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ over the positive edges:

$$\Delta=\sum_{a<b,\,M_{ab}>0}g_{ab}=2\!\!\sum_{a<b,\,M_{ab}>0}\!\!(s_a+s_b)\;-\;4\theta\!\!\sum_{a<b,\,M_{ab}>0}\!\!M_{ab}.$$

**First sum.** Each vertex $a$ occurs in exactly $d_a^+=\#\{b:M_{ab}>0\}$ positive edges (well defined because hollowness puts $M_{aa}=0\not>0$, so $b\ne a$ automatically), hence $\sum_{a<b,+}(s_a+s_b)=\sum_ad_a^+s_a$. **This step is a counting identity and needs nothing.**

**Second sum.** Write $P_+=\sum_{a<b,\,M_{ab}>0}M_{ab}$ and $N_-=\sum_{a<b,\,M_{ab}<0}\lvert M_{ab}\rvert$. Then $\lVert M\rVert_1=P_++N_-$ and $\sum_{a<b}M_{ab}=P_+-N_-$. **The reconciliation the question asks for is exactly this**: $\sum_{a<b}M_{ab}=\tfrac12\mathbf1^{\mathsf T}M\mathbf1=\tfrac12\mathbf1^{\mathsf T}(M\mathbf1)=0$, so $P_+=N_-$ and therefore

$$\boxed{\;P_+=\tfrac12\lVert M\rVert_1\;}$$

**Substituting** gives $\Delta=2\sum_ad_a^+s_a-2\theta\lVert M\rVert_1$, i.e. $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$. **The identity is true.**

**Answer to question 1, stated plainly.** *The sum over positive edges and the norm over all edges reconcile by $\mathbf1^{\mathsf T}M\mathbf1=0$ (the positive entries carry exactly half the $\ell^1$ mass) which is Ricci-flatness, and it is **stated nowhere in the block**.* Every hypothesis named in the L68 text is hollowness, criticality, $g\ge0$, $\theta>0$ and $\ker W=0$; the word "Ricci" does not occur in it, nor does $M\mathbf1=0$ in any notation.

### 5.1 Discrepancy, (iv) is false without $\mathbf1^{\mathsf T}M\mathbf1=0$, and the block names criticality and hollowness only

**Located.** [diagonal-half.md](../findings/diagonal-half.md):108–110, and verbatim at [results.md](../results.md):777.

**Exhibited, at a named object.** Let $n=3$ and $M=J-I$, that is $M_{12}=M_{13}=M_{23}=1$ with zero diagonal. $M$ is symmetric and hollow. Then $M^2=(J-I)^2=3J-2J+I=J+I$, so $(M^2)_{ab}=1$ off the diagonal, and the off-diagonal criticality equation holds with $\theta=2$: $M_{ab}^2+(M^2)_{ab}=1+1=2=\theta M_{ab}$. Every row has $s_a=2$; every pair is twin off the pair, so $g_{ab}=2(s_a+s_b)-4\theta M_{ab}=8-8=0$ and $\Delta=0$; all three edges are positive, so $d_a^+=2$ for each $a$ and $\lVert M\rVert_1=3$. Now

$$\theta\lVert M\rVert_1=2\cdot3=6,\qquad \sum_ad_a^+s_a-\tfrac12\Delta=3\cdot(2\cdot2)-0=12 .$$

**The identity fails by a factor of two at an object satisfying every hypothesis the block names.** The single broken step is $P_+=\tfrac12\lVert M\rVert_1$: here $P_+=3$ and $\lVert M\rVert_1=3$, because $\mathbf1^{\mathsf T}M\mathbf1=6\ne0$. Note that (i) and (iii) both survive at this object (the cap reads $2\theta M_{ab}=4\le4=s_a+s_b$ with equality, correctly, at a twin pair) so the witness isolates (iv)'s extra hypothesis and nothing else.

**Argued the opposite.** The charitable reading is that $M=J-I$ at $n=3$ is not on the diagonal locus and never could be: $\mathcal D_3=\{0\}$, and $\mathcal D_n$ carries $M\mathbf1=0$ by [conventions.md](../findings/conventions.md):37, so (iv) as scoped by the words "on the diagonal locus only" is never applied to it. **That defends (iv) and it does not defend the record's hypothesis list.** The block writes an explicit enumeration one display earlier ("The cap needs criticality **and hollowness**") and (iv) inherits the reader's impression that this is the list; the canonical line at [results.md](../results.md):777 then prints the identity with no hypothesis of any kind. A consumer who reaches for the identity through the canonical line has, on the page, nothing that rules the witness out.

**Grade: PROVEN, hypotheses corrected.** The corrected list for (iv) is **$M$ symmetric and hollow, $\mathbf1^{\mathsf T}M\mathbf1=0$, and the off-diagonal criticality equation with coefficient $\theta$**, the last, on the locus, itself resting on $M\mathbf1=0$ and $\operatorname{tr}M^2=2$.

**Corroboration on the record.** [lean/INDEX.md](../lean/INDEX.md):110 reaches the same conclusion from a formalisation: "the block names hollowness and criticality where it states the cap, and never names **Ricci-flatness**, which is the standing hypothesis of the file and is what (iv) alone reaches for, it is exactly the step `posSum`, that the positive entries carry half the $\ell^1$ mass". I read that row after completing the derivation above, per the rule that a claim of no-argument-on-file requires reading the reports the record cites. **The Lean row records the debt; the block and the canonical line still carry it.**

### 5.2 The two claims of exactness in (iv)'s closing sentence

"Both (iii) and (iv) are **equalities** at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$, returning $\theta_0(n)$."

**For (iv) the word "equality" is empty**: (iv) is an identity, true at every point of the locus that is critical, so saying it is an equality at one point distinguishes nothing. **What the sentence must mean, and what is checkable, is that solving (iv) for $\theta$ returns $\theta_0(n)$**, and I verified that exactly by hand at $n=6$.

*Exact hand evaluation at $S^3\times S^3$.* Unnormalised $M^0$ has within-block entry $\tfrac16$ and cross entry $-\tfrac19$ on blocks of size $3$; row sums $\tfrac26-\tfrac39=0$. Then $s^0_a=2\cdot\tfrac1{36}+3\cdot\tfrac1{81}=\tfrac1{18}+\tfrac1{27}=\tfrac5{54}$ and $\operatorname{tr}(M^0)^2=6\cdot\tfrac5{54}=\tfrac59$, so the unit-norm point is $M=tM^0$ with $t^2=\tfrac{2}{5/9}=\tfrac{18}5$, $t=3\sqrt{2/5}$. Then $s_a=t^2s^0_a=\tfrac{18}5\cdot\tfrac5{54}=\tfrac13$ (and $\sum_as_a=2$, as required). There are $6$ within-block edges at $t/6$ and $9$ cross edges at $t/9$, so $\lVert M\rVert_1=6\cdot\tfrac t6+9\cdot\tfrac t9=2t$; each vertex has $d_a^+=2$, so $\sum_ad_a^+s_a=6\cdot2\cdot\tfrac13=4$; and $\Delta=0$. Hence

$$\theta=\frac{4}{2t}=\frac{2}{3\sqrt{2/5}}=\frac23\sqrt{\tfrac52}=\frac{\sqrt{10}}3 .$$

Against the file's own closed form $\theta_0(n)=\sqrt2\,c_n+\tfrac{2\sqrt2}{n\sqrt{(n-1)(n-2)}}$ with $c_n=(n-3)/\sqrt{(n-1)(n-2)}$: at $n=6$, $\sqrt{(n-1)(n-2)}=\sqrt{20}=2\sqrt5$, so $\sqrt2c_6=3\sqrt2/(2\sqrt5)=3/\sqrt{10}$ and the second term is $2\sqrt2/(12\sqrt5)=1/(3\sqrt{10})$, summing to $10/(3\sqrt{10})=\sqrt{10}/3$. **The two agree exactly**, and $\sqrt{10}/3=1.05409\ldots$ matches $\Theta_6=1.0541$ at [conventions.md](../findings/conventions.md):21. **(iv) confirmed at $S^3\times S^3$ by exact hand evaluation.**

*And (iii) is an equality there for the stated reason.* A positive edge carries $M_{ab}=t/6=\tfrac12\sqrt{2/5}$, so $(s_a+s_b)/(2M_{ab})=(2/3)/\sqrt{2/5}=\tfrac23\sqrt{5/2}=\sqrt{10}/3=\theta$. **Equality**, and the edge is a twin pair, exactly as the equality clause predicts.

*The one figure I could check inside the fence section.* "at an exact $n=6$ critical point $M=\sqrt{2/21}\,Z$ with every $s_a=\tfrac72c^2$ and every positive edge at $c=\sqrt{2/21}$, it gives $1.080123$": $s_a=\tfrac72\cdot\tfrac2{21}=\tfrac13$, so the cap is $(2/3)/(2\sqrt{2/21})=\tfrac13\sqrt{21/2}$, and $\sqrt{10.5}=3.240370\ldots$, giving $1.080123\ldots$ **Confirmed exactly, and the point is self-consistent: $\sum_as_a=6\cdot\tfrac13=2$.**

*Not checked.* $\Delta=12$ at the $C_5$ blow-up, the value $0.670820$ it is said to return, and the agreement of both statements at $n=6,\dots,20$. These are numerical assertions; **numerical agreement is an open hypothesis and never evidence**, and I ran nothing.

## 6. Quantifier order, scope, and the edges of every range

**Quantifier order.** (i) is $\forall M$ symmetric hollow, $\forall a\ne b$. (ii) is $\forall M$ on the locus: $\Delta(M)=0\iff\forall$ positive edges $ab$, $\forall d\notin\{a,b\}$, $M_{ad}=M_{bd}$. (iii) is $\forall$ diagonal critical $W$, $\forall a\ne b$; **the min form then moves one quantifier**, from "$\forall$ positive edges, $\theta\le\cdot$" to "$\theta\le\min$", which is the same statement because the index set is finite and nonempty. (iv) is $\forall$ diagonal critical $W$. **No order defect found**, and no place where a $\forall$ is read as an $\exists$.

**The smallest admissible $n$.** $\mathcal D_n=\{0\}$ at $n\le3$: at $n=3$ the three row-sum equations $M_{12}+M_{13}=M_{12}+M_{23}=M_{13}+M_{23}=0$ force $M=0$, which fails $\operatorname{tr}M^2=2$; and $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$ vanishes at $n=3$. **So the block's range is $n\ge4$**, and it is stated nowhere in the block. At $n=4$ every sum $\sum_{d\ne a,b}$ has two terms and $\Delta$ is a sum over the positive edges of a $4$-vertex graph; nothing degenerates. The formula $2(n-2)$ moved directions is $0$ at $n=2$ and $2$ at $n=3$, consistent with $g_{ab}=0$ there, so **(i) is true but empty below $n=4$.**

**$\theta\le0$.** The cap $2\theta M_{ab}\le s_a+s_b$ and the affine form both hold verbatim; the min form is guarded by "for $\theta>0$" and the guard is redundant (§4). **(iv) holds for every sign of $\theta$**, since nothing in its derivation divides. At $\theta<0$ the cap is vacuous at positive edges and becomes a lower bound in disguise at negative ones. **No finding.**

**$\ker W\ne0$.** Used only in (ii)'s corollary, and correctly: with a zero row present, $\Delta=0$ permits singleton blocks, so the conclusion "every block has size $\ge2$" genuinely requires $\ker W=0$. **(i), (iii) and (iv) are indifferent to the kernel**, because $\Delta$ traces over $\{\lambda>0\}$ strictly and a zero row contributes $s_a=0$, $d_a^+=0$ and no term to $\lVert M\rVert_1$ from its own entries. **No finding.**

**An $M$ with a zero row.** Take row $a$ zero. Then $s_a=0$ and $M_{ab}=0$ for all $b$, so the cap at $ab$ reads $0\le s_b$, true; the min form never sees $a$; (iv) is unaffected in every term. **The one statement that changes is (ii)'s**, and it changes in the direction the block already records. **No finding.**

**A degenerate positive eigenvalue.** $\Delta$ is the trace of the quadratic form $v\mapsto\lVert[\mathrm{ad}(v),W]\rVert^2$ over the positive eigenspace, so it does not depend on the eigenbasis chosen inside a repeated eigenvalue, which matters here because the balanced product has all its positive entries equal. **The block does not say this; it is true, and nothing in the block is wrong for omitting it.**

**$M_{ab}=0$ exactly.** The edge $ab$ then belongs to neither $G^+$ nor the negative set; $d_a^+$ excludes it, $\lVert M\rVert_1$ gets nothing from it, and $\Delta$ ignores it. **Consistent throughout.** The block's own fence records that $\Delta$ is discontinuous at these crossings, which is a property of $\Delta$ and not a defect in (iv).

## 7. Comparison of the forms

| where | what it says | difference |
| --- | --- | --- |
| [diagonal-half.md](../findings/diagonal-half.md):86–112 | (i)–(iv) with derivations, "The cap needs criticality **and hollowness**", the twin sense spelled out in (ii) | the source of record; the enumeration is short by $M\mathbf1=0$ and $\operatorname{tr}M^2=2$ |
| [results.md](../results.md):777 | "the symmetry defect on the diagonal locus in closed form, $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ at a critical point, the entry cap $2\theta M_{ab}\le s_a+s_b$, and the traced identity $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$; single-audited" | **carries "at a critical point" and nothing else.** Hollowness, Ricci-flatness, the normalisation and the twin equality clause are all absent; the identity is printed bare |
| [findings/INDEX.md](../findings/INDEX.md):53 | "$g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$, $\Delta=0\iff$ the positive graph's components are twin cliques with nonpositive entries across them, and at a critical point $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$, capping every entry by its own row norms" | **omits (iv) entirely.** The clause it does carry is accurate |
| [lean/INDEX.md](../lean/INDEX.md):110 | row exists, status **proved**, "all four parts of L68, with each hypothesis carried on the statement that uses it"; names the missing Ricci-flatness on (iv) as the step `posSum`; records the twin characterisation proved in both directions; records "no sign condition on $\theta$ is needed" | **The row exists and it is the only place on the record where the hypothesis debt is written down.** Two divergences from the block: it locates the redundant $\theta>0$ on the cap where the block puts it on the min form, and it books "the eigenvectors on this locus are the $\varphi_{ab}$" and "$g_\gamma$ is the Petersen–Wink density" as imports rather than as proved |

**On the Lean row's completeness.** It carries the debt against (iv) only. **My reading is that the debt is wider**: $M\mathbf1=0$ and $\operatorname{tr}M^2=2$ are also what make (iii)'s quoted criticality equation multiplier-free and $\theta$-coefficiented, so they sit under the cap as well as under the trace. That is a difference of scope, not a contradiction, and the Lean statement is consistent with it, a Lean signature that takes the off-diagonal equation as a hypothesis has no occasion to name what derives it.

## 8. The gap between what is proven and what is used, what a consumer may cite

**Citable now, unconditionally, with only symmetry and hollowness:**

- $g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2$, and $g_{ab}\ge0$;
- $g_{ab}=0\iff M_{ad}=M_{bd}$ for every $d\notin\{a,b\}$, **the off-pair sense, and the sense must be carried with the citation**;
- $\Delta=0\iff$ every positive edge joins twins in that sense.

**Citable with, in addition, the off-diagonal equation $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ as a hypothesis on the number $\theta$:**

- $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$, the cap $2\theta M_{ab}\le s_a+s_b$ with equality exactly at off-pair twin pairs, and $\theta=(s_a+s_b)/(2M_{ab})-g_{ab}/(4M_{ab})$ at each $M_{ab}\ne0$.

**Citable only with $M\in\mathcal D_n$, that is, with $M\mathbf1=0$ named:**

- the block-constancy of $\Delta=0$ points and the singleton-block corollary;
- $\theta\le\min_{M_{ab}>0}(s_a+s_b)/(2M_{ab})$, whose index set is nonempty for that reason;
- **the traced identity $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$, which is false without it** (§5.1);
- and, once "criticality of $P$ on $\{\lVert W\rVert=1\}$" rather than the bare equation is the hypothesis, **also $\operatorname{tr}M^2=2$**, without which the coefficient is a multiplier and not $\theta$.

**Not citable:** any claim that $\Delta=0$ on this locus gives a two-factor sphere product (§3.1); and every numerical figure in the block, which is unaudited here.

**The gap between proven and used.** The block's own fence is candid that (iii) "restates that gap in sharper coordinates and closes none of it", and I found nothing that contradicts that. What I add is that **the gap between the proven statement and the cited statement is different from the gap the fence describes**: the fence is about strength, and this one is about hypotheses. The canonical line is strictly weaker in hypotheses than the theorem it names, which is the direction that lets a false statement be quoted from a true record.

## 9. The named trap, each citable claim read alone, as a consumer would

The record's signature failure is a correction landing beside the statement it corrects. I read each claim with the surrounding lines covered.

1. **"the entry cap $2\theta M_{ab}\le s_a+s_b$"**, read alone at [results.md](../results.md):777. It has "at a critical point" attached to the preceding clause and nothing of its own. A consumer gets a true statement only because "the diagonal locus" silently supplies hollowness and Ricci-flatness. **The correction that would fix it (the hypothesis list), lives in a different file, at [diagonal-half.md](../findings/diagonal-half.md):106, and is itself short by two.**
2. **"the traced identity $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$"**, read alone at [results.md](../results.md):777. **This is the trap firing.** Nothing on the line, and nothing in the block, tells the reader that the identity's second sum was converted using $\mathbf1^{\mathsf T}M\mathbf1=0$; the one place that says so is [lean/INDEX.md](../lean/INDEX.md):110, a different file with a different purpose. §5.1's $n=3$ witness is what a consumer who takes the printed hypotheses at face value can build.
3. **"with equality exactly at twin pairs"**, read alone at [diagonal-half.md](../findings/diagonal-half.md):104. The word "twin" is defined 8 lines up, in a different lettered part, and the definition is the non-obvious one, off-pair agreement, not equal rows. **Read alone, the clause is false in one direction** (§4). The definition and the use are in the same block, which is why this grades as a fragility rather than a defect, but they are not in the same sentence and the canonical line drops the clause entirely.
4. **"The cap needs criticality and hollowness"**, read alone at [diagonal-half.md](../findings/diagonal-half.md):106. This is the sentence a consumer would quote when asked what the cap needs, and it is the sentence that is wrong (§4.1). **It is worse than silence**, because it reads as a completed audit of the hypothesis list rather than as a remark about two of them.
5. **The downstream citation.** [Lemma L130](../findings/diagonal-half.md):527(ii) restates the cap as "**The entry cap, unconditional.** Hollowness alone gives $\lVert M_a-M_b\rVert^2\ge2M_{ab}^2$, so with criticality $M_{ab}\le(s_a+s_b)/(2\theta)$ at every pure critical point, which is Lemma L68's $g_{ab}\ge0$ **with no hypothesis attached**." **The incomplete enumeration has already propagated**, 421 lines below its source and in the words "unconditional" and "with no hypothesis attached"; and the restated form divides by $2\theta$, which needs $\theta>0$ where L68 was careful to state the cap in cleared form. *I did not audit L130 and record this only as evidence that the defect at [diagonal-half.md](../findings/diagonal-half.md):106 is live rather than latent.*

## 10. What would falsify the statements, and what I did to look for it

**For (i).** An $M$, symmetric and hollow, with $g_{ab}\ne2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2$ at some pair, or an operator norm convention under which the factor is not $2$. **I looked** by rederiving the commutator entrywise, then independently through [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7 read verbatim on file, then by summing the closed form against both pinned $\lambda$-moments of [conventions.md](../findings/conventions.md):40, obtaining $4(n-1)$ and $-4\theta$ exactly. **Four routes, no falsifier.**

**For (ii).** An $M$ on the locus with $\Delta=0$ whose positive graph has a component that is not a clique, or is a clique whose vertices are not mutually twin, or a block-constant $M$ with positive cross entries and $\Delta=0$. **I looked** by checking the $\lvert C\rvert=1,2,\ge3$ cases of the constancy argument separately and by checking the converse edge by edge. **No falsifier**, and the only object I built (the three-block $n=6$ matrix), falsifies a *labelling*, not the mathematics (§3.1).

**For (iii).** A diagonal critical point with $2\theta M_{ab}>s_a+s_b$, or with $g_{ab}=0$ at a positive edge that is not an off-pair twin pair. The first would falsify $g\ge0$, which is a sum of squares; the second would falsify that a sum of squares vanishes only termwise. **Neither can exist**, so the cap's failure mode is entirely in its hypotheses, which is where I looked and where I found the omission of §4.1.

**For (iv).** An $M$ satisfying every hypothesis the block names at which the identity fails. **I found one**, $M=J-I$ at $n=3$, §5.1, and it is off the diagonal locus, which is exactly what pins the missing hypothesis to $\mathbf1^{\mathsf T}M\mathbf1=0$ rather than to anything else. **A falsifier that would break (iv) as corrected** would be an $M\in\mathcal D_n$, critical, with $P_+\ne\tfrac12\lVert M\rVert_1$; that is impossible, since $P_+-N_-=\tfrac12\mathbf1^{\mathsf T}M\mathbf1=0$ identically on $\mathcal D_n$.

**What I did not do.** No script was run and no numerical claim in the block was checked. Every value in this report, $\sqrt{10}/3$, $\Theta_6=1.0541$, $1.080123$, $4(n-1)$, $-4\theta$, and the $n=3$ witness, is an exact hand evaluation from the definitions on file.

## Verdict

**PROVEN, hypotheses corrected.**

All four parts of L68 are true, and I reproduced each derivation independently: (i) by two routes and against both pinned moments, (ii) case by case in both directions, (iii) in one substitution, and (iv) in full, confirmed by an exact hand evaluation at $S^3\times S^3$ returning $\theta_0(6)=\sqrt{10}/3$.

**The corrected hypothesis list.**

| statement | hypotheses actually used |
| --- | --- |
| (i), and $g\ge0$ | $M$ real symmetric and hollow. Hollowness twice: the two dropped coordinates, and $Q_{(ab)}=2(M^2)_{ab}$ |
| (ii), the twin characterisation and block structure | (i) alone |
| (ii)'s singleton corollary | (i), plus $M\mathbf1=0$ and $\ker W=0$ |
| (iii), the affine form and the cap | (i), plus $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ off the diagonal, which, derived from criticality of $P$ on $\{\lVert W\rVert=1\}$, itself needs $M\mathbf1=0$ (to kill the multiplier) and $\operatorname{tr}M^2=2$ (to make the coefficient $\theta$). No sign condition on $\theta$, and none on $M_{ab}$ |
| (iii)'s min form | the above, plus $M_{ab}>0$ at the edges minimised over, whose existence needs $\mathbf1^{\mathsf T}M\mathbf1=0$ |
| (iv) | (iii), plus $\mathbf1^{\mathsf T}M\mathbf1=0$ used a second time and irreducibly, as $P_+=\tfrac12\lVert M\rVert_1$ |

**What is owed, in three edits.** Name Ricci-flatness at [diagonal-half.md](../findings/diagonal-half.md):106 alongside criticality and hollowness, and again at (iv) where it is the conversion step. Restate the off-pair sense of "twin" inside (iii)'s equality clause rather than only in (ii). Give [results.md](../results.md):777 the hypotheses it prints none of, or define the term "generalised sphere-product shape" it inherits from (ii), currently used once on the whole record and defined nowhere.
