# VERIFY v114, L68: the diagonal-locus density $g_{ab}$, the entry cap $2\theta M_{ab}\le s_a+s_b$, and the traced identity $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$

*Cold brief, verifier v114, round [L68](ROUND_L68.md). Source text: [findings/diagonal-half.md](../findings/diagonal-half.md):86–112, canonical line [results.md](../results.md):777. **No numerical work was done**: no script was run, and every number in this report is an exact hand evaluation of a matrix written down here. Log: [agent_logs/verify-L68-v114.log](../agent_logs/verify-L68-v114.log). Sources read on file: [Petersen–Wink notes](../references/petersen-wink-2019-bochner-technique/notes.md) (Prop 1.7 verbatim), [conventions.md](../findings/conventions.md), [bounds.md](../findings/bounds.md), [bounds-relaxations.md](../findings/bounds-relaxations.md), [LEDGER.md](../findings/LEDGER.md), [lean/INDEX.md](../lean/INDEX.md):110, [reviews/REVIEW_r519.md](../reviews/REVIEW_r519.md), [reviews/REVIEW_r520.md](../reviews/REVIEW_r520.md).*

## Verdict table

| # | claim, as written in the block | verdict |
| --- | --- | --- |
| C1 | **(i)** $g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2=2\lVert M_a-M_b\rVert^2-4M_{ab}^2=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2$ | **PROVEN** |
| C2 | **(i)** the constant $2$, and *"two moved families"* as its source | **PROVEN** |
| C3 | **(i)** *"with no hypothesis at all"* | **PROVEN, hypotheses corrected**: symmetry, hollowness and coordinate-diagonality are all used |
| C4 | $g_{ab}\ge0$ | **PROVEN**, from the first form alone |
| C5 | **(ii)** $\Delta=0$ iff every positive edge joins twins | **PROVEN** |
| C6 | **(ii)** positive linkage is transitive *under $\Delta=0$*; components are twin cliques; constancy inside and across; converse | **PROVEN** |
| C7 | **(ii)** singleton block $\Rightarrow$ zero row; so $\Delta=0$ with $\ker W=0$ forces blocks of size $\ge2$ | **PROVEN**; consumes $M\mathbf1=0$, which the sentence does name in situ |
| C8 | **(iii)** $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ at a critical point | **PROVEN** |
| C9 | **(iii)** the entry cap $2\theta M_{ab}\le s_a+s_b$, all $a\ne b$ | **PROVEN**; no sign condition on $\theta$ is used |
| C10 | **(iii)** *"with equality exactly at twin pairs"* | **PROVEN, hypotheses corrected**: true in both directions only under the *off-pair* reading of "twin"; the full-row reading makes the forward direction false at every positive edge |
| C11 | **(iii)** $\theta\le\min_{M_{ab}>0}(s_a+s_b)/(2M_{ab})$ and the exact $\theta$ formula | **PROVEN**, and non-vacuous: a positive edge always exists |
| C12 | **(iii)** *"The cap needs criticality **and hollowness**"* | **PROVEN, hypotheses corrected**: symmetry is used too, and $M\mathbf1=0$ is used upstream if "criticality" means stationarity rather than the boxed equation |
| C13 | **(iv)** $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$ | **PROVEN, hypotheses corrected**: it needs **criticality** and **Ricci-flatness $M\mathbf1=0$**, neither named at the step nor at [results.md](../results.md):777. Falsified as written at $M=c(J-I)$, where it fails by exactly a factor $2$ |
| C14 | *"On the diagonal locus every eigenvector is a coordinate bivector"* | **overstated**, harmlessly: false at every repeated eigenvalue, and $\Delta$ is a basis-independent trace |
| C15 | $\Delta=\sum_{M_{ab}>0}g_{ab}$ | **PROVEN**, and a citation hazard against [conventions.md](../findings/conventions.md):51's ordered-pairs default |
| C16 | *"Criticality is load-bearing"*, by the numbers $+0.075,\dots$ at $n=5,\dots,12$ | **NOT CHECKED, numerical.** The record's own exact replacement, $2\theta M_{ab}-(s_a+s_b)=2\rho_{ab}-\tfrac12g_{ab}$, is verified here and the block does not carry it |
| C17 | *"the recorded decomposition $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$ of [bounds.md](../findings/bounds.md)"* | **PROVEN** as a specialisation; **mis-pointed**, that form lives in [bounds-relaxations.md](../findings/bounds-relaxations.md) |
| C18 | [results.md](../results.md):777 read alone, as a consumer would | **GAP**: "at a critical point" scopes only the first of three clauses |

**Verdict: PROVEN, hypotheses corrected.** Every mathematical statement in (i)–(iv) is correct and each was re-derived here from the definitions; the defect is entirely in the hypothesis lists, and it is concentrated in (iv), which is false at a named object satisfying every hypothesis the block states.

## 0. Conventions, fixed once

- $M$ is the $n\times n$ **vertex matrix** of a coordinate-diagonal $W$: $W\varphi_{ab}=M_{ab}\varphi_{ab}$ for $\varphi_{ab}=E_{ab}-E_{ba}$. [conventions.md](../findings/conventions.md):37 defines the locus as $\mathcal D_n=\{S\text{ symmetric, hollow, }S\mathbf1=0\}$, and [diagonal-half.md](../findings/diagonal-half.md):30 carries the three standing constraints $M\mathbf1=0$, $\operatorname{tr}M=0$, $\operatorname{tr}M^2=2$.
- The pairing is the **half-trace** $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, in which $\lVert\varphi_{ab}\rVert^2=1$ and $\{\varphi_{ab}\}_{a<b}$ is orthonormal ([conventions.md](../findings/conventions.md):60, pinned by [r519](../reviews/REVIEW_r519.md)/[r520](../reviews/REVIEW_r520.md)). Operator norms are Hilbert–Schmidt in that orthonormal basis.
- $s_a=\lVert M_a\rVert^2=\sum_dM_{ad}^2$; $(M^2)_{ab}=\sum_dM_{ad}M_{db}$; $M^{\circ2}$ is the entrywise square.
- $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ and $\Delta=\sum_{\gamma:\lambda_\gamma>0}g_\gamma$, the trace over the **strictly positive** eigenspace ([bounds.md](../findings/bounds.md):93–97, [conventions.md](../findings/conventions.md):39).
- $\theta$ denotes both the functional $\theta=\tfrac12(\sum_{a,b}M_{ab}^3+\operatorname{tr}M^3)$ and the multiplier in the criticality equation. They agree: contracting $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s)$ against $M$ gives $\sum_{a,b}M_{ab}^3+\operatorname{tr}M^3=\theta\operatorname{tr}M^2+\sum_as_aM_{aa}=2\theta$, using $\operatorname{tr}M^2=2$ and hollowness. Verified by hand; the identification is used silently throughout (i)–(iv).
- **Criticality**, as used in (iii)–(iv), is the off-diagonal reading $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ of the boxed equation at [diagonal-half.md](../findings/diagonal-half.md):78.

## 1. The hypothesis inventory

**(a) Hypotheses the block carries, explicitly.** Coordinate-diagonality (*"On the diagonal locus"*); hollowness (named once, in (iii)); criticality (named in (iii)); $\ker W=0$ (named once, in (ii)'s corollary); $\theta>0$ (named once, for the min form).

**(b) Hypotheses the block carries silently, from its file.** Symmetry of $M$; $M\mathbf1=0$; $\operatorname{tr}M^2=2$. All three are standing at [diagonal-half.md](../findings/diagonal-half.md):30 and in $\mathcal D_n$.

**(c) Imported results, and each checked against the object it is applied to.**

| import | statement, as read on file | applied to | verdict |
| --- | --- | --- | --- |
| [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7 | $\lvert LR\rvert^2=2\sum_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2g(L\Xi_\alpha,\Xi_\beta)^2$ for **every** $L\in\mathfrak{so}(V)$, $\{\Xi_\alpha\}$ an orthonormal basis diagonalising $R$ | $L=\mathrm{ad}(\varphi_{ab})$, $R=W$, $\Xi=\{\varphi_{cd}\}_{c<d}$ | **hypotheses met.** Its only hypothesis is that $\{\Xi_\alpha\}$ is orthonormal and diagonalises $R$; both hold on the diagonal locus in the half-trace pairing. It carries no criticality, no Weyl condition and no dimension restriction |
| the criticality equation, [diagonal-half.md](../findings/diagonal-half.md):78 | $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s)$ iff $W=\operatorname{diag}(w)$ is critical | (iii), off-diagonally | **hypotheses met** for the direction used (critical $\Rightarrow$ equation). Its derivation consumes $M\mathbf1=0$ twice, to kill the multiplier $v$, and via $(M^2)\mathbf1=0$ |
| the decomposition $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$ | cited *"of [bounds.md](../findings/bounds.md)"* | (i), as a consistency remark | **mis-pointed but true.** [bounds.md](../findings/bounds.md):278 carries $g_k=2R_k-4\lambda_k(\theta-\lambda_k)$; the $R_{\gamma\alpha}/Q_\gamma$ form is at [bounds-relaxations.md](../findings/bounds-relaxations.md):77 and :103. Checked in §2.3 |

**(d) Which hypotheses the written proof actually uses, step by step.**

| step | symmetry | hollow | $M\mathbf1=0$ | $\operatorname{tr}M^2=2$ | criticality | $\theta>0$ | $\ker W=0$ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| (i) first form $2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$ | (|), |, | (|), |, |, |
| (i) middle and last forms | **yes** | **yes** | (|), |, | (|), |
| (ii) twin characterisation, transitivity, cliques, converse | **yes** | (|), |, | (|), |, |
| (ii) singleton corollary | **yes** | **yes** | **yes** | (|), |, | **yes** |
| (iii) affine form and cap | **yes** | **yes** | (upstream) | (| **yes** |), |, |
| (iii) min form | **yes** | **yes** | (upstream) | for non-vacuity | **yes** | **yes** |, |
| (iv) traced identity | **yes** | **yes** | **YES (named nowhere** |), | **yes (named nowhere at this step** |), |, |

The two capitalised cells are this report's finding. Everything else in the table the block either names or inherits visibly from its file's opening.

## 2. Part (i), the density, C1, C2, C3, C4, C17

### 2.1 The commutator, computed twice

**Route A, the bracket by hand.** With $\varphi_{ab}=E_{ab}-E_{ba}$ and $E_{ij}E_{kl}=\delta_{jk}E_{il}$,

$$(E_{ab}-E_{ba})(E_{bd}-E_{db})=E_{ad},\qquad (E_{bd}-E_{db})(E_{ab}-E_{ba})=E_{da},$$

so $[\varphi_{ab},\varphi_{bd}]=E_{ad}-E_{da}=\varphi_{ad}$ for $a,b,d$ distinct, with coefficient exactly $1$, the block's monomial, confirmed. Antisymmetry then gives $[\varphi_{ab},\varphi_{ad}]=-\varphi_{bd}$. Hence, on $\varphi_{bd}$ and $\varphi_{ad}$ with $d\ne a,b$,

$$[\mathrm{ad}(\varphi_{ab}),W]\varphi_{bd}=(M_{bd}-M_{ad})\varphi_{ad},\qquad [\mathrm{ad}(\varphi_{ab}),W]\varphi_{ad}=(M_{bd}-M_{ad})\varphi_{bd},$$

and the operator kills $\varphi_{ab}$ and every $\varphi_{cd}$ with $\{c,d\}\cap\{a,b\}=\varnothing$. So it is block-diagonal over the $n-2$ planes $\mathrm{span}(\varphi_{ad},\varphi_{bd})$, each block $\begin{pmatrix}0&\mu_d\\\mu_d&0\end{pmatrix}$ with $\mu_d=M_{bd}-M_{ad}$, contributing $2\mu_d^2$ to the Hilbert–Schmidt norm. **The block's account of the factor $2$ (two moved families, each block carrying two entries), is exactly right**, and

$$g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2 .$$

**Route B, through the source as read.** [Petersen–Wink Prop 1.7](../references/petersen-wink-2019-bochner-technique/notes.md) gives $\lvert LR\rvert^2=2\sum_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2g(L\Xi_\alpha,\Xi_\beta)^2$. Taking $L=\mathrm{ad}(\varphi_{ab})$ and $\Xi=\{\varphi_{cd}\}_{c<d}$, the only unordered pairs $\{\alpha,\beta\}$ with $g(L\Xi_\alpha,\Xi_\beta)\ne0$ are $\{(ad),(bd)\}$ for $d\ne a,b$, each with $g(L\Xi_\alpha,\Xi_\beta)^2=1$, giving $2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$, **the same expression, with the factor $2$ arriving from Prop 1.7's own prefactor.** The two routes agree, which is the check that the record's $\lVert\varphi_{ab}\rVert^2=1$ normalisation is the one that makes the formula true.

### 2.2 The two rewritings

$\lVert M_a-M_b\rVert^2$ runs over all $n$ coordinates; the sum above omits $d=a$ and $d=b$. Those two omitted coordinates are $(M_{aa}-M_{ba})^2=M_{ab}^2$ and $(M_{ab}-M_{bb})^2=M_{ab}^2$, **using hollowness for $M_{aa}=M_{bb}=0$ and symmetry for $M_{ba}=M_{ab}$**. So $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$. Then $\lVert M_a-M_b\rVert^2=s_a+s_b-2\langle M_a,M_b\rangle$ and $\langle M_a,M_b\rangle=\sum_dM_{ad}M_{bd}=\sum_dM_{ad}M_{db}=(M^2)_{ab}$ by symmetry, giving

$$g_{ab}=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2 .$$

**C1, C2: PROVEN.** **C4: PROVEN**, the first form is twice a sum of squares, so $g_{ab}\ge0$ needs nothing at all, and that is the only place non-negativity is used later.

**C3, the label *"with no hypothesis at all"*, corrected.** The first form is hypothesis-free; the middle and last forms use symmetry and hollowness. The block is transparent about hollowness (*"the middle step because $M$ is hollow"*) and silent about symmetry, which it uses twice. Since $M$ is the vertex matrix of a self-adjoint $W$, symmetry is definitional rather than an assumption, the accurate label is *"nothing beyond membership of the diagonal locus"*, which is [r520](../reviews/REVIEW_r520.md):79's reading and is what I record.

### 2.3 The specialisation claim, C17

With $R_{(ab)\alpha}$ the indicator that the pair $\alpha$ shares exactly one index with $\{a,b\}$, the pairs counted are $\{a,d\}$ and $\{b,d\}$ for $d\ne a,b$, so

$$\sum_\alpha\lambda_\alpha^2R_{(ab)\alpha}=\sum_{d\ne a,b}M_{ad}^2+\sum_{d\ne a,b}M_{bd}^2=(s_a-M_{ab}^2)+(s_b-M_{ab}^2),$$

using hollowness to drop $M_{aa}=M_{bb}=0$ from $s_a,s_b$, the block's $s_a+s_b-2M_{ab}^2$. And $Q_{(ab)}=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{(ab)\alpha\beta}$ picks up the ordered pairs $((ad),(bd))$ and $((bd),(ad))$, giving $2\sum_{d\ne a,b}M_{ad}M_{bd}=2(M^2)_{ab}$, again by hollowness. Substituting into $g=2\sum\lambda^2R-2Q$ returns $2(s_a+s_b)-4M_{ab}^2-4(M^2)_{ab}$, **(i) exactly**. The claim that (i) is a specialisation and not a new identity is correct. *The pointer is wrong:* [bounds.md](../findings/bounds.md) carries this as $g_k=2R_k-4\lambda_k(\theta-\lambda_k)$ at line 278; the $R_{\gamma\alpha}$/$Q_\gamma$ form quoted is [bounds-relaxations.md](../findings/bounds-relaxations.md):77 and :103.

### 2.4 Two independent hand cross-checks of (i), against identities the record holds elsewhere

These are the strongest available checks on the constant, and both come out exactly.

**$\sum_\gamma g_\gamma=4(n-1)$** ([bounds.md](../findings/bounds.md):97). Summing (i) over unordered pairs,

$$\sum_{a<b}g_{ab}=\sum_{a\ne b}\sum_{d\ne a,b}(M_{ad}-M_{bd})^2 =2\sum_{a\ne b}\sum_{d\ne a,b}M_{ad}^2-2\sum_{a\ne b}\sum_{d\ne a,b}M_{ad}M_{bd}.$$

The first double sum is $\sum_a\sum_{d\ne a}M_{ad}^2\cdot\#\{b\ne a,d\}=(n-2)\operatorname{tr}M^2=2(n-2)$, so the first term is $4(n-2)$. In the second, $\sum_{d\ne a,b}M_{ad}M_{bd}=(M^2)_{ab}$ (the $d=a,b$ terms vanish by hollowness), and $\sum_{a\ne b}(M^2)_{ab}=\mathbf1^{\mathsf T}M^2\mathbf1-\operatorname{tr}M^2=0-2=-2$ **by $M\mathbf1=0$**, so the second term is $+4$. Total $4n-4=4(n-1)$ ✓.

**$\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$** ([target.md](../findings/target.md):329). $\sum_{a<b}M_{ab}g_{ab}=2\sum_{a<b}M_{ab}(s_a+s_b)-4\sum_{a<b}M_{ab}(M^2)_{ab}-4\sum_{a<b}M_{ab}^3$. The first vanishes: $\sum_{a<b}M_{ab}(s_a+s_b)=\sum_{a\ne b}s_aM_{ab}=\sum_as_a\sum_{b}M_{ab}=0$ **by $M\mathbf1=0$** with hollowness. The second is $\tfrac12\operatorname{tr}M^3$ and the third is $\tfrac12\sum_{a,b}M_{ab}^3$, so the total is $-2(\operatorname{tr}M^3+\sum_{a,b}M_{ab}^3)=-4\theta$ ✓.

Both anchors reproduce, which pins the factor $2$, the half-trace normalisation and the unordered reading of $\Delta$ simultaneously. **Note that both consume $M\mathbf1=0$**, the hypothesis whose absence is this report's finding.

## 3. Part (ii), $\Delta=0$ as a blow-up condition, C5, C6, C7, C15

### 3.1 The twin characterisation, both directions, C5

$\Delta=\sum_{M_{ab}>0}g_{ab}$ is a sum of non-negative terms, so it vanishes iff each vanishes, and $g_{ab}=0\iff\sum_{d\ne a,b}(M_{ad}-M_{bd})^2=0\iff M_{ad}=M_{bd}$ for every $d\notin\{a,b\}$. **Both directions hold, from the first form of (i) alone.** No hollowness, no criticality, no row sums. **PROVEN.**

### 3.2 Transitivity, C6, checked as written and then at a concrete $M$

**As written.** Assume $\Delta=0$, and let $ab$ and $bc$ be positive edges with $a,b,c$ distinct. Twinhood of $a,b$ evaluated at $d=c$ (legitimate: $c\notin\{a,b\}$) gives $M_{ac}=M_{bc}$, and $M_{bc}>0$ by hypothesis, so $M_{ac}>0$. **Correct as written.** The relation is genuinely transitive, and so is twinhood itself: for $d\notin\{a,b,c\}$, $M_{ad}=M_{bd}=M_{cd}$; at $d=b$, twinhood of $b,c$ at index $a$ gives $M_{ab}=M_{ac}$, which equals $M_{bc}=M_{cb}$. So $a,c$ are twins. Components of $G^+$ are therefore cliques of mutually twin vertices.

**Constancy.** Inside a block, for distinct $a,b,c,d$: twinhood of $b,c$ at index $a$ gives $M_{ab}=M_{ac}$, and twinhood of $a,d$ at index $c$ gives $M_{ac}=M_{dc}$, so $M_{ab}=M_{cd}$; the three-vertex case $M_{ab}=M_{ac}=M_{bc}$ is the first step alone. Across two blocks, $a,b\in B$ and $c\in B'$: twinhood of $a,b$ at $c$ gives $M_{ac}=M_{bc}$. Entries between distinct components are $\le0$ by the definition of a component of $G^+$. **Converse:** if every positive edge joins twins then every term of $\Delta$ is $0$; and the block-constant description with non-positive cross entries implies exactly that, since two vertices of one block agree at every outside index. **All of C6 PROVEN.**

**Checked at a concrete $M$, and bare transitivity is false.** The sentence is conditional (*"Linkage is **then** transitive"*), and the condition is doing all the work. In $\mathcal D_4$ the row-sum equations force $M_{12}=M_{34}$, $M_{13}=M_{24}$, $M_{14}=M_{23}$ (add rows $1$ and $4$, subtract rows $2$ and $3$, and $2M_{14}-2M_{23}=0$) so **every triangle sums to zero**: $M_{12}+M_{13}+M_{23}=M_{12}+M_{13}+M_{14}=0$, the first row. Hence in $\mathcal D_4$ a vertex with two positive edges always closes with a negative one. Concretely, at

$$M_{12}=M_{34}=1,\quad M_{13}=M_{24}=1,\quad M_{14}=M_{23}=-2\qquad(M\in\mathcal D_4,\ \text{all rows sum to }0),$$

the edges $12$ and $24$ are positive while $M_{14}=-2<0$. Consistently, $g_{12}=2[(M_{13}-M_{23})^2+(M_{14}-M_{24})^2]=2[9+9]=36>0$, so $\Delta>0$ and the hypothesis of (ii) fails, as it must. **The block's wording is correct; a consumer who lifts "linkage is transitive" out of it is wrong at $n=4$ by this matrix.**

### 3.3 The singleton corollary, C7

A singleton component $\{a\}$ has every off-diagonal entry of row $a$ a cross entry, hence $\le0$; the row sums to $0$ **by $M\mathbf1=0$** (the diagonal entry being $0$ by hollowness), so all are $0$. Then $M_{ab}=0$ for every $b$, so each $\varphi_{ab}$ lies in $\ker W$ and $\ker W\ne0$ whenever $n\ge2$. Contrapositively, $\Delta=0$ with $\ker W=0$ forces every block to have size $\ge2$. **PROVEN.** The sentence *"and they sum to $0$"* is where $M\mathbf1=0$ enters, and it is at least visible there, unlike in (iv).

### 3.4 The $C_5$ counterexample to block-constancy alone

*"Block-constancy alone is not the condition"* is a claim about a named object whose $\Delta=12$ is a recorded figure ([bounds.md](../findings/bounds.md):159), not re-derived here. The **structural** half is checkable and is right: block-constancy without the sign condition permits a positive cross entry between two blocks, whose endpoints are not twins (they differ at indices inside their own blocks), so such an edge contributes a strictly positive $g$. The two hypotheses of the characterisation are therefore not interchangeable, exactly as the block says.

### 3.5 $\Delta$ as an unordered sum, C15

$\Delta=\sum_{M_{ab}>0}g_{ab}$ does not say whether the pairs are ordered. [conventions.md](../findings/conventions.md):51 states *"Sums over pairs are over ORDERED pairs unless the line says otherwise"*, and this line does not say otherwise. **Exhibited:** read as ordered, $\Delta$ doubles, and (iv) becomes $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac14\Delta$, the written identity is off by a factor $2$. **The opposite reading, which wins:** $\Delta$'s primary definition at [bounds.md](../findings/bounds.md):95 is $\sum_{\gamma\in\mathfrak p}\lVert v_\gamma\cdot W\rVert^2$, a sum over an orthonormal **basis** of the positive eigenspace, which on this locus is one vector per unordered pair. That is unambiguous, and it is the reading under which the $\sum_\gamma g_\gamma=4(n-1)$ anchor of §2.4 comes out. **So the mathematics is right and only the line is ambiguous.** Recorded as a citation hazard; [r520](../reviews/REVIEW_r520.md):75 filed the same point as *"a second small convention debt"* and the block still does not say "unordered".

## 4. Part (iii), the affine form and the entry cap, C8, C9, C10, C11, C12, C16

### 4.1 The substitution, C8, C9

Off-diagonally the boxed criticality equation reads $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$. Substituting into the last form of (i),

$$g_{ab}=2(s_a+s_b)-4\big[(M^2)_{ab}+M_{ab}^2\big]=2(s_a+s_b)-4\theta M_{ab}\qquad(a\ne b),$$

and $g_{ab}\ge0$ gives $4\theta M_{ab}\le2(s_a+s_b)$, i.e. $2\theta M_{ab}\le s_a+s_b$. **PROVEN, for every $a\ne b$, with no sign condition on $\theta$ and no sign condition on $M_{ab}$**, the block states the cap unrestricted and is right to.

### 4.2 The equality clause, in both directions, C10, and the answer to pre-registered question 2

Equality in the cap $\iff g_{ab}=0\iff M_{ad}=M_{bd}$ for every $d\notin\{a,b\}$, by §3.1. **Both directions hold, but only under the off-pair reading of "twin".**

**The reading matters, and the block never says which it means.** Under the strong reading *"$M_a=M_b$ as full rows"*, the forward direction is **false**, and provably so at every pair worth applying it to: $M_a=M_b$ forces $M_{ab}=M_{aa}=0$ and $M_{ba}=M_{bb}=0$ by hollowness, so no **positive** edge can join full-row twins, and the equality clause would be empty exactly where (iii) uses it. **Exhibited** at the $n=4$ balanced product of §4.3: vertices $1,2$ satisfy $g_{12}=0$ and the cap with equality, while $M_1=(0,\tfrac1{\sqrt3},-\tfrac1{\sqrt{12}},-\tfrac1{\sqrt{12}})\ne M_2=(\tfrac1{\sqrt3},0,-\tfrac1{\sqrt{12}},-\tfrac1{\sqrt{12}})$. **The opposite reading, which wins:** (ii) defines the term in situ (*"joins **twins**), $M_{ad}=M_{bd}$ for every $d$ outside the pair"*, so the block does fix the meaning, one part earlier and two paragraphs above the clause that needs it. **So C10 is PROVEN with its hypothesis corrected to the off-pair reading, and the correction is legible only to a reader of (ii).**

### 4.3 The whole of (i)–(iv) verified exactly at a named critical point

Let $A$ be the $4\times4$ symmetric hollow matrix with $A_{12}=A_{34}=2$ and $-1$ in the other four entries, and $M=A/\sqrt{12}$. Every row of $A$ sums to $2-1-1=0$, and $\operatorname{tr}A^2=2(4+4+1+1+1+1)=24$, so $\operatorname{tr}M^2=2$: $M\in\mathcal D_4$ with unit norm. Entries: $M_{12}=M_{34}=\tfrac1{\sqrt3}$, the rest $-\tfrac1{\sqrt{12}}$. Then $s_a=\tfrac{4+1+1}{12}=\tfrac12$ for every $a$.

- **Criticality.** $(M^2)_{12}=M_{13}M_{23}+M_{14}M_{24}=\tfrac1{12}+\tfrac1{12}=\tfrac16$ and $M_{12}^2=\tfrac13$, so $M_{12}^2+(M^2)_{12}=\tfrac12=\theta/\sqrt3$ with $\theta=\tfrac{\sqrt3}2$. At $(1,3)$: $(M^2)_{13}=M_{12}M_{32}+M_{14}M_{34}=-\tfrac2{\sqrt{36}}=-\tfrac13$ and $M_{13}^2=\tfrac1{12}$, sum $-\tfrac14=\theta\cdot(-\tfrac1{\sqrt{12}})$ ✓. Diagonally $(M^{\circ2}+M^2)_{aa}=0+s_a$ ✓. **So $M$ is an exact diagonal critical point with $\theta=\tfrac{\sqrt3}2=0.866025\ldots$**, which is [conventions.md](../findings/conventions.md):21's recorded $\Theta_4=0.866$.
- **(i) against (iii).** Closed form: $g_{13}=2(s_1+s_3)-4\theta M_{13}=2-4\cdot\tfrac{\sqrt3}2\cdot(-\tfrac1{\sqrt{12}})=2+1=3$. Directly: $g_{13}=2[(M_{12}-M_{32})^2+(M_{14}-M_{34})^2]=4(\tfrac1{\sqrt3}+\tfrac1{\sqrt{12}})^2=4\cdot\tfrac9{12}=3$ ✓.
- **The cap, at equality.** $2\theta M_{12}=2\cdot\tfrac{\sqrt3}2\cdot\tfrac1{\sqrt3}=1=s_1+s_2$, and $1,2$ are off-pair twins ✓. At the negative edge, $2\theta M_{13}=-\tfrac12<1$, strict ✓.
- **(iv).** Positive edges $\{1,2\},\{3,4\}$, so $d_a^+=1$ for every $a$ and $\sum_ad_a^+s_a=\operatorname{tr}M^2=2$; $\Delta=g_{12}+g_{34}=0$; $\lVert M\rVert_1=2\cdot\tfrac1{\sqrt3}+4\cdot\tfrac1{\sqrt{12}}=\tfrac4{\sqrt3}$; and $\theta\lVert M\rVert_1=\tfrac{\sqrt3}2\cdot\tfrac4{\sqrt3}=2=\sum_ad_a^+s_a-\tfrac12\Delta$ ✓.

**All four parts reproduce exactly at a point built here from the definitions.**

### 4.4 What the cap actually needs, C12, and the answer to pre-registered question 3

The block says *"criticality **and hollowness**"*. Step by step against the object:

| step | what it consumes |
| --- | --- |
| $g_{ab}\ge0$ | nothing |
| $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$ | **hollowness and symmetry** |
| $\lVert M_a-M_b\rVert^2=s_a+s_b-2(M^2)_{ab}$ | **symmetry** |
| $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ | **criticality**; and, if "criticality" means stationarity rather than the boxed equation, **$M\mathbf1=0$**, which is what kills the multiplier $v$ at [diagonal-half.md](../findings/diagonal-half.md):74 |
| reading $\theta$ as the value of the functional rather than as the multiplier | **$\operatorname{tr}M^2=2$** |

**Three further properties are used and not named.** *(1) Symmetry*, definitional for a vertex matrix, so a scope note rather than a defect. *(2) $M\mathbf1=0$*, upstream, in the derivation of the equation the cap substitutes. *(3) The unit normalisation.* This last one is sharp and is a genuine trap: contracting the boxed equation against $M$ gives $\sum_{a,b}M_{ab}^3+\operatorname{tr}M^3=\theta_{\mathrm{mult}}\operatorname{tr}M^2$, i.e. $\theta_{\mathrm{func}}=\theta_{\mathrm{mult}}\cdot\tfrac12\operatorname{tr}M^2$, so **the multiplier equals the functional value only on $\{\operatorname{tr}M^2=2\}$**, and [conventions.md](../findings/conventions.md):37 defines $\mathcal D_n$ as a **cone**, with no norm condition in it. **Exhibited:** at $2M$ for the $M$ of §4.3, $\theta_{\mathrm{func}}=8\cdot\tfrac{\sqrt3}2=4\sqrt3$, $(2M)_{12}=\tfrac2{\sqrt3}$, $s_1+s_2=4$, and $2\theta_{\mathrm{func}}(2M)_{12}=16>4$, **the cap read with $\theta$ as the functional fails by a factor $4$ on the diagonal locus as that locus is defined.** With $\theta$ read as the multiplier it is scale-covariant and holds. **The opposite reading:** the file fixes $\operatorname{tr}M^2=2$ at its opening, and every consumer works on the unit sphere, so nothing on the record is damaged. Recorded as a scope note on the citable line, not as an error in the block.

**On the row sums and the sign pattern, specifically as question 3 asks.** The cap uses **no** property of the sign pattern, it holds at every $a\ne b$. The sign pattern is used only to make the min-form non-vacuous and to select which edges (iv) sums. The row sums are used only upstream, as above. No property of the eigenvalue $\theta$ beyond the identification just discussed.

### 4.5 The min form and the exact formula, C11

For $M_{ab}>0$, dividing the cap by $2M_{ab}>0$ gives $\theta\le(s_a+s_b)/(2M_{ab})$, so $\theta\le\min_{M_{ab}>0}(s_a+s_b)/(2M_{ab})$. **The $\theta>0$ qualifier is not needed for the inequality** and is presumably there to mark when the bound is informative; carrying it costs nothing. **Non-vacuity:** a positive edge always exists, since $\operatorname{tr}M^2=2$ makes $M\ne0$ while hollowness and $M\mathbf1=0$ give $\sum_{a<b}M_{ab}=0$, so the entries cannot all be $\le0$ without all being $0$. Rearranging $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ gives $\theta=\frac{s_a+s_b}{2M_{ab}}-\frac{g_{ab}}{4M_{ab}}$ at every edge with $M_{ab}\ne0$, which is more than the stated "positive edge" and is correct as stated. **PROVEN.**

### 4.6 "Criticality is load-bearing", C16

The block supports this with maximised violations $+0.075,+0.227,+0.334,+0.370,+0.368$ at $n=5,6,8,10,12$. **These are numerical outputs; this verification runs no scripts and does not check them.** Two things are checkable by hand and are recorded instead.

**The exact criterion, verified.** Write $\rho_{ab}=\theta M_{ab}-M_{ab}^2-(M^2)_{ab}$ for the per-entry criticality residual. From (i),

$$2\rho_{ab}-\tfrac12g_{ab}=2\theta M_{ab}-2M_{ab}^2-2(M^2)_{ab}-\big[(s_a+s_b)-2(M^2)_{ab}-2M_{ab}^2\big]=2\theta M_{ab}-(s_a+s_b),$$

an identity needing only hollowness and symmetry. **So the cap holds exactly when $\rho_{ab}\le\tfrac14g_{ab}$, and criticality is precisely $\rho\equiv0$.** This is [r520](../reviews/REVIEW_r520.md)'s identity as recorded at [LEDGER.md](../findings/LEDGER.md):676, where the record states it *"retires the search the block cited for that point"*, **and the block still cites the search and does not carry the identity.** A recorded repair that has not landed.

**And the search's own scope has a floor.** At $n=4$ the violation is $0$, unconditionally. $\mathcal D_4$ is two-dimensional and, up to scale and relabelling, is the pencil $X(t)=A+tB$ with $A$ the pairing matrix of §4.3 and $B$ that of $(13)(24)$: $X_{12}=X_{34}=2-t$, $X_{13}=X_{24}=2t-1$, $X_{14}=X_{23}=-1-t$. Then $\operatorname{tr}X^2=24(t^2-t+1)$, so the unit-norm representative is $X/\kappa$ with $\kappa^2=12(t^2-t+1)$, and $s_a=6(t^2-t+1)/\kappa^2=\tfrac12$ **for every $t$**. Summing the cubes, $\sum_{a,b}X_{ab}^3+\operatorname{tr}X^3=2\big[6-9t-9t^2+6t^3\big]\cdot2+24(2-t)(2t-1)(-1-t)$ collects to $36(2t^3-3t^2-3t+2)=36(t+1)(2t-1)(t-2)$, so $\theta(t)=18(t+1)(2t-1)(t-2)/\kappa^3$ and

$$2\theta M_{12}=\frac{-(t+1)(2t-1)(2-t)^2}{4(t^2-t+1)^2},\qquad 4(t^2-t+1)^2+(t+1)(2t-1)(2-t)^2=3t^2(2t^2-5t+5).$$

Since $2t^2-5t+5$ has discriminant $25-40=-15<0$, the right side is $\ge0$ with equality only at $t=0$: **the cap holds on the whole of $\mathcal D_4$ with no criticality hypothesis, with equality exactly at the balanced product.** The other two edge classes are strict, their analogous differences are $15t^2-15t+6$ (discriminant $-135$) and $2t^4-7t^3+18t^2-7t+2=t^2(2y^2-7y+14)$ with $y=t+t^{-1}$ (discriminant $49-112<0$), both positive throughout. **This is consistent with the block, whose violation list begins at $n=5$**, and it fixes the true scope of the necessity claim: criticality is load-bearing from $n=5$ up, if the recorded numbers hold.

## 5. Part (iv), the traced identity, C13, and the answer to pre-registered question 1

### 5.1 The derivation, in full

Sum $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ over the **unordered positive** edges. Each such edge contributes $s_a$ to vertex $a$'s tally and $s_b$ to vertex $b$'s, so $\sum_{a<b,\,M_{ab}>0}(s_a+s_b)=\sum_ad_a^+s_a$ with $d_a^+=\#\{b:M_{ab}>0\}$, the degree fibering. Writing $P=\sum_{a<b,\,M_{ab}>0}M_{ab}$,

$$\Delta=2\sum_ad_a^+s_a-4\theta P .$$

**The reconciliation the pre-registered question asks about is $P=\tfrac12\lVert M\rVert_1$, and it is exactly $M\mathbf1=0$.** With hollowness, $\sum_{a<b}M_{ab}=\tfrac12\sum_{a\ne b}M_{ab}=\tfrac12\sum_a\big(\sum_bM_{ab}\big)=0$, so the positive mass $P$ and the negative mass $N$ satisfy $P+N=0$, whence $\lVert M\rVert_1=P-N=2P$. Substituting, $\Delta=2\sum_ad_a^+s_a-2\theta\lVert M\rVert_1$, i.e.

$$\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta .$$

**The identity is correct.** The sum over positive edges and the norm over all edges reconcile **by Ricci-flatness alone**, no other property of $M$ does it, and the step is exactly the one that turns a one-sided sum into a two-sided norm.

### 5.2 The finding, the property is stated nowhere in the block

**Locate.** Part (iv) is one sentence and one display: *"**(iv) Traced over $\mathfrak p$**, with $d_a^+=\#\{b:M_{ab}>0\}$ and $\lVert M\rVert_1=\sum_{a<b}\lvert M_{ab}\rvert$: $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$."* It names no hypothesis. It does not name criticality, which it inherits from (iii), and it does not name $M\mathbf1=0$, which is its own. **The canonical line at [results.md](../results.md):777 names neither either.** Searching the block for the word: $M\mathbf1=0$, Ricci-flatness and "row sums" appear **nowhere** in [diagonal-half.md](../findings/diagonal-half.md):86–112.

**Exhibit, at a named object.** Let $n\ge3$ and $M=c(J-I)$ with $c=\sqrt{2/(n(n-1))}$, the hollow symmetric matrix with every off-diagonal entry $c$. It satisfies **every hypothesis the block states**:

- hollow and symmetric ✓; unit norm, $\operatorname{tr}M^2=n(n-1)c^2=2$ ✓;
- the **full** boxed criticality equation, with $\theta=(n-1)c$: off-diagonally $M_{ab}^2+(M^2)_{ab}=c^2+(n-2)c^2=(n-1)c^2=\theta M_{ab}$, and diagonally $0+s_a=\theta\cdot0+s_a$ ✓;
- **(iii) holds at it**: $g_{ab}=0$ and $2(s_a+s_b)-4\theta M_{ab}=4(n-1)c^2-4(n-1)c^2=0$ ✓, and the cap holds with equality at every pair, all pairs being twins.

It fails only $M\mathbf1=0$, the rows summing to $(n-1)c$. And **(iv) is false at it, by exactly a factor $2$**: every entry is positive, so $d_a^+=n-1$ and $\sum_ad_a^+s_a=n(n-1)\cdot(n-1)c^2=2(n-1)$; $\Delta=0$; $\lVert M\rVert_1=c\,n(n-1)/2$, so $\theta\lVert M\rVert_1=(n-1)c\cdot cn(n-1)/2=n(n-1)^2c^2/2=n-1$. **At $n=4$: the left side is $3$ and the right side is $6$.** The step that breaks is precisely $P=\tfrac12\lVert M\rVert_1$, here $P=\lVert M\rVert_1$, since there are no negative edges at all.

**Argue the opposite, the most charitable reading the words support.** Within [diagonal-half.md](../findings/diagonal-half.md), $M\mathbf1=0$ is standing from line 30, where it is displayed with $\operatorname{tr}M=0$ and $\operatorname{tr}M^2=2$ as the constraint set of the whole file, and [conventions.md](../findings/conventions.md):37 puts $S\mathbf1=0$ into the definition of $\mathcal D_n$. So a reader of the file, or a reader of [results.md](../results.md):777 who follows *"on the diagonal locus"* through to [conventions.md](../findings/conventions.md), supplies it. **The mathematics is therefore sound and only the hypothesis list is short**, which is why the verdict is *hypotheses corrected* rather than `BROKEN`. But the exhibit is not a straw object: it satisfies criticality, hollowness, symmetry and unit norm, so it is exactly what a reader who takes the block's own hypothesis sentence at its word would consider admissible.

**C13: PROVEN, hypotheses corrected. (iv) needs criticality and $M\mathbf1=0$; state both at the step.**

### 5.3 What the record already holds on this, and where it sits

**This is not a new finding, and that is itself the finding.** Three places on the record carry it, none of them beside the statement:

| where | what it says | is it beside the claim? |
| --- | --- | --- |
| [reviews/REVIEW_r519.md](../reviews/REVIEW_r519.md):134, finding F3 | *"(iv) omits its hypothesis… it inherits criticality from (iii), which its heading does not say. It also uses $M\mathbf1=0$."* **Repair:** *"(iv) Traced over $\mathfrak p$ at a critical point"* | **no**, the repair was never applied; the heading still reads *"(iv) Traced over $\mathfrak p$"* |
| [reviews/REVIEW_r520.md](../reviews/REVIEW_r520.md):75 | derives (iv) with *"$M\mathbf1=0$ makes $\sum_{a<b,+}M_{ab}=\tfrac12\lVert M\rVert_1$"* | **no**, inside a reviewer's derivation |
| [lean/INDEX.md](../lean/INDEX.md):110 | *"The finding is on (iv)'s hypotheses: the block names hollowness and criticality where it states the cap, and never names **Ricci-flatness**, which is… what (iv) alone reaches for (it is exactly the step `posSum`"* | **no**), a different file, in the Lean index |

The Lean formalisation [L68.lean](../lean/HamiltonsCubic/Results/L68.lean) carries the hypothesis correctly: `trace_conversion` takes `hh` (hollow), `hs` (symmetric), `hr` (row sums zero) and the criticality hypothesis explicitly, and its header comment says the block *"is careful about hypotheses in one place… and silent elsewhere, so this file carries each hypothesis on the statement that uses it."* **So the machine-checked form is right and the prose form it was built from is still short.**

## 6. Quantifiers, scope, and the edge of every range

**Quantifier order.** At a fixed point, (iii)'s cap is $\forall a\ne b$ with $\theta$ **determined by the point**, not quantified; (iv) is a single per-point equation. Nothing in (i)–(iv) quantifies over $n$, and nothing claims a bound on $\theta$ by a function of $n$, the block's own fence says so, and it is right to: the right-hand side $\min_+(s_a+s_b)/(2M_{ab})$ is a functional of the point. The *"exactly at twin pairs"* clause is a biconditional **per pair**, not a statement about the point. All correct as written.

**The smallest admissible $n$.** $\mathcal D_n=\{0\}$ for $n\le3$: at $n=3$, hollowness and zero row sums give $M_{12}+M_{13}=M_{12}+M_{23}=M_{13}+M_{23}=0$, hence $M=0$; at $n\le2$ trivially. So $\operatorname{tr}M^2=2$ is **unsatisfiable below $n=4$** and the lemma has no admissible object there, it is vacuous rather than false. (Independently, (i)'s first form is an empty sum at $n=2$, and the monomial $[\varphi_{ab},\varphi_{bd}]$ needs three distinct indices.) **Content begins at $n=4$**, where §4.3 exhibits a point and §4.6 settles the whole locus. The block states no lower bound on $n$; none is needed, and none is wrong.

**$\theta\le0$.** The cap $2\theta M_{ab}\le s_a+s_b$ is proved with no sign condition and stays true: at $\theta=0$ it reads $0\le s_a+s_b$, and at $\theta<0$ it constrains the **negative** entries instead, $\lvert\theta\rvert\lvert M_{ab}\rvert\le\tfrac12(s_a+s_b)$ for $M_{ab}<0$. Only the min form is restricted to $\theta>0$, correctly. (iv) holds at every sign of $\theta$; at $\theta=0$ it becomes $\sum_ad_a^+s_a=\tfrac12\Delta$, a genuine constraint rather than a triviality.

**$\ker W\ne0$.** Harmless everywhere except where it is named. A zero eigenvalue means $M_{ab}=0$ for that pair, which contributes to neither side of (iv): it is excluded from $\Delta$ by the $\{\lambda>0\}$ convention, from $d_a^+$ by strictness, and contributes $0$ to $\lVert M\rVert_1$. (i) and (iii) never mention the spectrum's support. **$\ker W=0$ is used in exactly one place** ((ii)'s corollary) and it is named there.

**An $M$ with a zero row.** Admissible, and the block's own corollary manufactures it. Row $a$ zero gives $s_a=0$, $d_a^+=0$, and $M_{ab}=0$ for every $b$; the cap at $(a,b)$ reads $0\le s_b$ ✓; vertex $a$ is a singleton component of $G^+$ and contributes nothing to (iv). No statement degenerates. **No finding.**

## 7. The forms compared, C18

| where | what it states | scope carried |
| --- | --- | --- |
| [findings/diagonal-half.md](../findings/diagonal-half.md):86–112 | the full block, (i)–(iv) | diagonal locus; hollowness at (iii); criticality at (iii); $\ker W=0$ at (ii)'s corollary. **$M\mathbf1=0$ nowhere; criticality not restated at (iv)** |
| [findings/INDEX.md](../findings/INDEX.md):53 | $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$; $\Delta=0\iff$ twin cliques with non-positive entries across; *"at a critical point $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$, **capping every entry** by its own row norms"* | **the best-scoped prose form on the record**, criticality governs both the affine form and the cap. It omits (iv) entirely, so it carries no defect from it |
| [findings/INDEX-results.md](../findings/INDEX-results.md):82 | the Gate 2 row: *"The cap needs hollowness alongside criticality, and criticality is now load-bearing by an identity rather than by a search"* | correct on the cap; **silent on (iv)**, and its *"by an identity"* names a repair the block does not carry (§4.6) |
| [results.md](../results.md):777 | *"the symmetry defect on the diagonal locus in closed form, $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ **at a critical point**, the entry cap $2\theta M_{ab}\le s_a+s_b$, and the traced identity $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$; single-audited"* | **GAP.** "at a critical point" sits inside the first clause; the cap and the traced identity are listed unqualified, and both need it. *"Single-audited"* is also stale, [LEDGER.md](../findings/LEDGER.md):676 records [r519](../reviews/REVIEW_r519.md) and [r520](../reviews/REVIEW_r520.md), identical briefs, **both CONFIRMED**, each re-deriving (i)–(iv) |
| [lean/INDEX.md](../lean/INDEX.md):110 and [L68.lean](../lean/HamiltonsCubic/Results/L68.lean) | all four parts, *"with each hypothesis carried on the statement that uses it"*; hollowness, symmetry, criticality and `hr : ∀ a, ∑ b, M a b = 0` are explicit arguments of `trace_conversion` | **the only complete form.** Its "Owed" is honest: that $g_\gamma$ is the Petersen–Wink density, and that the eigenvectors on this locus are the $\varphi_{ab}$, are imported rather than proved, which is exactly §2.1 of this report |

**One correction to the Lean row itself.** It reads *"no sign condition on $\theta$ is needed, where the block states the cap for $\theta>0$"*. The block states the cap **unconditionally** and applies $\theta>0$ only to the min form that follows; the Lean statement and the block agree, and the row records a disagreement that is not there.

## 8. What is proven, what is used, and what a consumer may cite

**The gap is narrow and is entirely in the hypothesis lists.** Every mathematical assertion in (i)–(iv) is derivable, and I derived each one here. The nine or so consumers take (i)'s $g\ge0$, (iii)'s affine form and the cap; **none takes (iv)**, which is what limits the blast radius of §5.

**The dominant consumer form, checked.** [ATTEMPTS.md](../ATTEMPTS.md):3161 and :3239 and [second-order.md](../findings/second-order.md):1005 cite L68 as $\lVert o^{(jk)}\rVert^2=s_j+s_k-2\theta M_{jk}$ for the orbit vector $o^{(jk)}_i=M_{ki}-M_{ji}$. **That is exactly $\tfrac12g_{jk}$ at a critical point, and it is right, under the off-pair index range**, which is the range those blocks use: their own computation $\sum_io_i=(-M_{kj})-(-M_{jk})=0$ at [ATTEMPTS.md](../ATTEMPTS.md):3239 is the sum over $i\notin\{j,k\}$. *Under the full range the same symbol would be $\lVert M_j-M_k\rVert^2=s_j+s_k-2\theta M_{jk}+2M_{jk}^2$, short by $2M_{jk}^2$, so the reading is load-bearing there too, and the consumers have it right.* Likewise their *"orbit-free means twin"* is the off-pair reading, and $s_j=s_k=\theta M_{jk}$ follows because off-pair twins have $s_j-s_k=0$ termwise. **No finding against the consumers.**

**What a consumer may cite, stated so it can be lifted whole:**

> Let $M$ be symmetric, hollow, with $M\mathbf1=0$ and $\operatorname{tr}M^2=2$, and let $\theta$ be its critical value, so that $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s)$. Then for all $a\ne b$: $g_{ab}:=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2=2(s_a+s_b)-4\theta M_{ab}\ge0$, hence $2\theta M_{ab}\le s_a+s_b$, with equality iff $M_{ad}=M_{bd}$ for every $d\notin\{a,b\}$; and $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$ with $\Delta$ the sum of $g_{ab}$ over the **unordered** pairs with $M_{ab}>0$.

**What a consumer may not cite:** the cap or the traced identity without criticality; the traced identity without $M\mathbf1=0$; the cap with $\theta$ read as the functional value off $\{\operatorname{tr}M^2=2\}$; "linkage is transitive" without $\Delta=0$; "twin" in the full-row sense.

## 9. The named trap, each citable claim read alone

### 9.1 *"On the diagonal locus every eigenvector is a coordinate bivector"*, C14

**Locate.** The block's opening sentence, which sets up everything that follows.

**Exhibit.** False whenever an eigenvalue repeats, which is the generic case here. At the $n=4$ critical point of §4.3, $M_{12}=M_{34}=\tfrac1{\sqrt3}$, so $(\varphi_{12}+\varphi_{34})/\sqrt2$ is a unit eigenvector of $W$ and is not a coordinate bivector. Every balanced sphere product has the same feature, on a larger scale.

**Argue the opposite.** The sentence's work is done by the weaker and true statement *"there is an orthonormal eigenbasis of coordinate bivectors"*, and that suffices because $\Delta$ is basis-independent: $v\mapsto\lVert[\mathrm{ad}(v),W]\rVert^2$ is a quadratic form on $\mathfrak{so}(n)$, and $\Delta$ is its trace over the positive eigenspace, so any orthonormal basis of that space returns the same number. Checked at §4.3: on $\mathfrak p=\mathrm{span}(\varphi_{12},\varphi_{34})$ both $g$'s vanish, so every rotation of the basis returns $\Delta=0$.

**Verdict: overstated wording, no mathematical consequence.** Recorded because the sentence is the one a consumer would lift when transporting the setup to another locus, where the distinction is not free.

### 9.2 Reading each citable claim cold

The record's signature failure is a correction landing beside the statement rather than in it. Taking each claim exactly as a consumer would meet it:

| claim, alone | what a cold reader gets | status |
| --- | --- | --- |
| $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$ | true for every symmetric hollow $M$ diagonalising $W$ | **safe** |
| $g_{ab}\ge0$ | true, no hypothesis | **safe** |
| $\Delta=0\iff$ every positive edge joins twins | safe *if* "twin" is the block's off-pair definition, which sits in the same sentence | **safe** |
| *"Linkage is then transitive"* | safe in place; **false if lifted**, §3.2's $\mathcal D_4$ matrix | **hazard**, but the word *"then"* carries the condition |
| $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ | safe: criticality is in the sentence | **safe** |
| $2\theta M_{ab}\le s_a+s_b$ **as it appears at [results.md](../results.md):777** | criticality is attached to the *previous* clause; a reader who takes this clause alone gets a statement the block itself says is false, by up to $+0.370$ | **GAP** |
| $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$, in the block **or** at [results.md](../results.md):777 | no criticality, no Ricci-flatness anywhere near it; false at $M=c(J-I)$ by a factor $2$ | **GAP, the finding of §5** |
| the corrections that exist | [r519](../reviews/REVIEW_r519.md)'s F3 repair, [r520](../reviews/REVIEW_r520.md)'s derivation, [lean/INDEX.md](../lean/INDEX.md):110's Ricci-flatness note, [LEDGER.md](../findings/LEDGER.md):676's $\rho$ identity | **all four land elsewhere.** Not one is in the block or in the canonical line |

**So the trap is present and this is a clean instance of it**: the block has been audited twice, the missing hypothesis has been written down three separate times by three separate instruments, and the sentence a consumer reads is unchanged.

## 10. The falsifier, what would break each claim, and what I did to look for it

| claim | the object that would falsify it | what I did |
| --- | --- | --- |
| (i) | a coordinate-diagonal $W$ and a pair $a\ne b$ with $\lVert[\mathrm{ad}\varphi_{ab},W]\rVert^2\ne2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$, i.e. a further moved direction, or a different bracket coefficient | computed the bracket from the matrix units (§2.1, coefficient exactly $1$), recomputed the norm through [Petersen–Wink Prop 1.7](../references/petersen-wink-2019-bochner-technique/notes.md) as read on file, and checked the result against **both** recorded moment identities $\sum g=4(n-1)$ and $\sum\lambda g=-4\theta$ by hand (§2.4). A wrong constant would break both; neither breaks |
| the cap | a hollow symmetric $M$ satisfying $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s)$ with $2\theta M_{ab}>s_a+s_b$ at some pair | none can exist: the chain is three identities and one sum of squares, each re-derived here. I searched the smallest case exhaustively, §4.6 proves the cap over **all** of $\mathcal D_4$, criticality or not, by a polynomial identity |
| the equality clause | a critical point with $g_{ab}=0$ and $M_{ad}\ne M_{bd}$ for some $d\notin\{a,b\}$, or the converse | impossible: it is a sum of squares vanishing. The available failure is the *reading* of "twin", exhibited at §4.2 |
| **(iv)** | a hollow symmetric $M$ satisfying the criticality equation with $\sum_{a<b}M_{ab}\ne0$ | **found: $M=c(J-I)$, §5.2.** It satisfies every hypothesis the block names and falsifies the written identity by a factor $2$ at every $n\ge3$ |
| $\Delta$'s reading | any point at which the ordered and unordered readings differ, i.e. any point with $\Delta\ne0$, e.g. the $\mathcal D_4$ matrix of §3.2 with $g_{12}=36$ | resolved against the primary definition at [bounds.md](../findings/bounds.md):95 (§3.5) |

**Not looked for, and stated as such.** The block's numerical claims, the $C_5$ blow-up's $\Delta=12$, the violations $+0.075,\dots,+0.368$ at $n=5,\dots,12$, the $\theta_0(n)$ returns at $n=6,\dots,20$, the $0.670820$, and the $n=7$ tolerance discussion, were **not** checked. This verification runs no scripts, by the standing rule; each of those is an open hypothesis carried by the record's own instruments, and none of them is load-bearing for any of (i)–(iv).

## 11. Verdict

**PROVEN, hypotheses corrected.**

The three pre-registered questions, answered:

1. **Which hypotheses does (iv) use?** Criticality, inherited from (iii) and not restated, and **$M\mathbf1=0$**, which is its own and is stated nowhere in the block or in the canonical line. The sum over positive edges and the norm over all edges reconcile because zero row sums force $\sum_{a<b}M_{ab}=0$, so the positive mass is exactly half the $\ell^1$ mass. **The property is not stated anywhere in the block** (§5).
2. **Is "equality exactly at twin pairs" right in both directions?** Yes, and only under the **off-pair** reading $M_{ad}=M_{bd}$ for $d\notin\{a,b\}$, which (ii) supplies. Under the full-row reading the forward direction is false and the clause is empty at every positive edge (§4.2).
3. **What does the cap need?** Criticality and hollowness, as stated, plus **symmetry** (definitional), **$M\mathbf1=0$** upstream if criticality means stationarity rather than the boxed equation, and **$\operatorname{tr}M^2=2$** for $\theta$ to be the functional value rather than the multiplier, the last with a factor-$4$ failure exhibited on the cone $\mathcal D_n$ (§4.4). No property of the sign pattern is used by the cap itself.

**Repairs the record would need, each in the place a consumer reads:**

- **(iv)'s heading** to read *"Traced over $\mathfrak p$ **at a critical point**, and using $M\mathbf1=0$"*, this is [r519](../reviews/REVIEW_r519.md)'s F3 repair, filed and never applied, and [lean/INDEX.md](../lean/INDEX.md):110's finding, recorded in a different file.
- **[results.md](../results.md):777** to scope "at a critical point" across all three clauses, and to drop *"single-audited"*, which [LEDGER.md](../findings/LEDGER.md):676 supersedes.
- **(iii)** to carry $\rho_{ab}\le\tfrac14g_{ab}$, the exact criterion verified at §4.6, in place of or beside the search numbers the record itself says it retires.
- **(i)'s opening** to say *"there is an orthonormal eigenbasis of coordinate bivectors"*.
- **$\Delta$'s definition line** to say **unordered**, against [conventions.md](../findings/conventions.md):51's default.

None of these changes a number, a bound or a citation. Every mathematical statement in L68 stands, and each was re-derived here from the definitions.
