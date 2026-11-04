# VERIFY v102, Lemma L57, the diagonal theorem at every $n\ge4$: the three steps, the bridge that reaches the statement's quantifier, and the two halves of the equality clause

**Cold brief, [ROUND_L57.md](ROUND_L57.md). No numerical work was done: no script was run, and every value below is an exact hand evaluation.** Sources read: [findings/problem.md](../findings/problem.md), the statement at :557–579, the three steps at :262–269, and the four headings the block's map names (*Step 2 is now PROVED here*, *(d) The ODD equality case*, *Step 3, closed at both parities*, *Step 1 is PROVED*), plus a fifth heading, *So the all-$n$ diagonal theorem is COMPLETE*, which the map does not name and which carries the load-bearing bridge; [findings/diagonal-half.md](../findings/diagonal-half.md) for the criticality equation the chain imports; [findings/conventions.md](../findings/conventions.md); [results.md](../results.md):98 and :268; [lean/INDEX.md](../lean/INDEX.md); the reports the block cites, [REVIEW_r500.md](../reviews/REVIEW_r500.md), [REVIEW_r123.md](../reviews/REVIEW_r123.md), [REVIEW_r124.md](../reviews/REVIEW_r124.md); and [references/](../references/), where [nienhaus-2023-second-best-einstein/notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) and [jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md) were read. Log: [agent_logs/verify-L57-v102.log](../agent_logs/verify-L57-v102.log).

*Every line number below was read off the source at the end of this round, after phase 0 of [ROUND_L57.md](ROUND_L57.md) found the block's own four line numbers had drifted. Each is paired with the quoted text and the heading it sits under, so a locator survives the next edit above it. Three of the findings (claims 7, 12 and 13 in the table), sit on the single long paragraph at :418, which carries the bridge, the boldface statement, and the superseded Step-1 sentence in that order.*

**The block carries "verified to $10^{-12}$", "checked at ten products to $10^{-16}$", "matches the closed form at $n=4,\dots,12$ to $10^{-9}$" and five more such phrases at source. None of them is evidence for anything below.** Every claim graded PROVEN here is graded on an argument I re-derived by hand; where the only support is a measurement, the row says so.

## Claim table

| # | the claim, as a consumer would cite it | verdict |
| --- | --- | --- |
| 1 | Step 1, $\lambda\le\frac{n-1}{n}\mu$ at a critical point of $P$ on $\mathcal D_n$ | **PROVEN** |
| 2 | Step 2(a),(b), $Z(v)\in\mathcal D_n$, and it is the *orthogonal* projection of $v\otimes v$ | **PROVEN** |
| 3 | Step 2, $\mu=2\langle S,Z(v)\rangle$, hence $\mu^2\le4\lvert Z\rvert^2$, with $\lvert Z\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4$ | **PROVEN, hypotheses corrected** |
| 4 | Step 3, the fourth-moment lemma, by Proof I | **PROVEN** |
| 5 | Step 3, Proof II as the block paraphrases it: "$\sum m_ir_i=0$ pins $r$ to the line spanned by $u=\mathbf1\times m$" | **GAP**, false whenever $3\mid n$; the case split is present in [r124](../reviews/REVIEW_r124.md) and was dropped in transcription |
| 6 | The chaining to $\Theta_n^2$, both parities | **PROVEN** |
| 7 | The bridge from a critical point to *every* diagonal $W$ | **PROVEN**, the reduction is on file, under a heading the block's own map omits |
| 8 | Attainment: $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, collapsing to $\Theta_n^2$ at the balanced split | **PROVEN** |
| 9 | "The balanced split beats every other sphere product" | **PROVEN** |
| 10 | Uniqueness half of the equality clause, up to permutation | **PROVEN at every $n\ge4$** |
| 11 | [problem.md](../findings/problem.md):416, "**Equality is up to $\pm1\times S_n$**" | **BROKEN** |
| 12 | [problem.md](../findings/problem.md):418, "equality exactly at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ (up to sign and permutation, **uniquely for $n\ge5$**)" | **BROKEN** |
| 13 | [problem.md](../findings/problem.md):418, "Step 1 … in [diagonal-half.md](../findings/diagonal-half.md), **where it already carries a proof**" | **GAP**, contradicted by :384 in the same block; the owed cross-check is discharged in §2.3 below |
| 14 | [results.md](../results.md):268, "Every step holds at both parities" | **PROVEN** |
| 15 | Normalisation: the chaining is consistent across all three steps | **PROVEN** |
| 16 | A Lean form of L57 | **HYPOTHESIS-DEBT**, no row exists, and L57's bucket in [lean/INDEX.md](../lean/INDEX.md) is wrong |

**Round verdict: PROVEN, hypotheses corrected.** The theorem stated at [problem.md](../findings/problem.md):571–579 and at [results.md](../results.md):98 and :268 is proven, at every $n\ge4$, at both parities, for every diagonal $W$ and not merely at critical points. Two clauses in the block's closing paragraph are BROKEN and must not be cited; both are corrections that landed beside the statement rather than in it.

**In one line.** Every step reproduces exactly by hand and the chain delivers both printed constants with no slack; the defects are all in the block's closing prose, a sign clause the cubic's oddness refutes, a uniqueness range that excludes an $n$ the record proves, and a one-sentence paraphrase of the second proof of step 3 that drops the case its own source splits out.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), never restated from memory:

- $Q(W)=W^2+W^\#$; $P(W)=\langle W,Q(W)\rangle$; $\theta=P(W)/\lVert W\rVert^3$, and at a critical point $Q(W)=\theta W$.
- **"Diagonal" means diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame**, not diagonal as an operator on $\Lambda^2\mathbb R^n$. This is the sense the theorem uses; both $\lVert W\rVert$ and $\langle Q(W),W\rangle$ are $O(n)$-invariant, so "coordinate-diagonal" and "diagonal in some frame" define the same theorem.
- $\mathcal D_n=\{S\ \text{symmetric, hollow},\ S\mathbf1=0\}$, the vertex matrices of coordinate-diagonal Weyl operators.
- **The sectional matrix $K$ (written $M$ or $S$ in the block) satisfies $\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2=2$ at a unit Weyl tensor**, the sum over **ordered** pairs. Equivalently $\sum_{i<j}K_{ij}^2=1$.
- **Sums over pairs are over ORDERED pairs unless the line says otherwise**, and *the $n\times n$ Frobenius pairing is twice the $\Lambda^2$ pairing.*
- $\Theta_n$ is the diagonal maximum; $\theta_0(n)^2=2(n-1)(n-2)/n^2$, equal to $\Theta_n^2$ at even $n$ only.

Two consequences I use throughout, and state once so no later line restates them:

- **(N1)** Writing $\lvert S\rvert^2:=\sum_{i<j}s_{ij}^2$, the working locus $\mathop{\mathrm{tr}}S^2=2$ is exactly $\lvert S\rvert=1$, and it is exactly $\lVert W\rVert=1$.
- **(N2)** $\langle Q(S),S\rangle_{\Lambda^2}=\tfrac12\langle S^{\circ2}+S^2,S\rangle_{F}=\tfrac12\lambda\mathop{\mathrm{tr}}S^2=\lambda$ at $\mathop{\mathrm{tr}}S^2=2$, the diagonal term $D$ dropping out against hollow $S$. **So $\lambda=\theta$**, and a bound on $\lambda$ *is* a bound on $\langle Q(W),W\rangle$ at $\lVert W\rVert=1$. This identification is nowhere in the L57 block; it is on file at [diagonal-half.md](../findings/diagonal-half.md):71 ("Contracting against $M$ recovers $2\theta=\langle M^{\circ2}+M^2,M\rangle$") and :247 ("$\lambda=\theta$ is derived rather than assumed").

## 1. The hypothesis inventory

### 1.1 Hypotheses the block carries, each against the object it applies to

| # | hypothesis | where it is used | status |
| --- | --- | --- | --- |
| H1 | $n\ge4$ | Step 3 only, and there essentially: the circle-replacement needs one coordinate left untouched after three are moved | **stated, used, sharp**, at $n=3$ Lemma A makes $\sum v^4$ constant on the whole constraint set and uniqueness fails |
| H2 | $W$ coordinate-diagonal in some orthonormal frame, i.e. $S\in\mathcal D_n$ | everywhere | **stated, used** |
| H3 | $\mathop{\mathrm{tr}}S^2=2$ | Step 2's Cauchy–Schwarz only | **stated, used**, and discharged for the general statement by homogeneity |
| H4 | $S$ critical: $S^{\circ2}+S^2=\lambda S+D$ | Step 1 only | **stated, used**, and supplied for a general $W$ by the bridge (§6) |
| H5 | $S\ne0$, hence $\mu>0$ | the division by $\mu$ that turns $\lambda\mu\le\frac{n-1}n\mu^2$ into $\lambda\le\frac{n-1}n\mu$ | **UNSTATED, used**, true on the locus $\mathop{\mathrm{tr}}S^2=2$, since $\mathop{\mathrm{tr}}S=0$ and $S\ne0$ force a strictly positive eigenvalue |
| H6 | $v\perp\mathbf1$, i.e. $\sum v_i=0$ | the two contractions in Step 1, all of Step 2, all of Step 3 | **asserted rather than derived**, it follows from H5: $S\mathbf1=0$ makes $\mathbf1$ a $0$-eigenvector, and $\mu>0$ makes $v$ orthogonal to it |
| H7 | $\lvert S\rvert_{\text{unordered}}=1$ | Step 2's $\mu=2\langle S,Z\rangle\le2\lvert S\rvert\lvert Z\rvert$ | **UNSTATED at the step**, it is H3 restated, and the block states H3 two paragraphs earlier. This is the correction in claim 3's verdict |
| H8 | the Lagrange constraint qualification at every point of $\{\sum v=0,\sum v^2=1\}$ | Step 3 | **UNSTATED, used, and true**: the constraint gradients are $\mathbf1$ and $2v$, dependent only if $v\parallel\mathbf1$, which with $\sum v=0$ forces $v=0$ |

### 1.2 Hypotheses of every result the block imports

| imported result | its own hypotheses | met? |
| --- | --- | --- |
| The criticality equation $M^{\circ2}+M^2=\theta M+\mathop{\mathrm{diag}}(s)$, [diagonal-half.md](../findings/diagonal-half.md):69–78 | $M$ hollow symmetric, $M\mathbf1=0$, $M$ critical for $P$ restricted to the locus, and $2n-2\ne0$ | **yes**, I re-derived it in §6.2 |
| $Q$ preserves Ricci-flatness, [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) via [conventions.md](../findings/conventions.md)'s $\Phi$(ii) | $\mathop{\mathrm{Ric}}(W)=0$ | **yes**, and on this locus it needs no import: $\sum_{j\ne i}(S^{\circ2}+S^2)_{ij}=r_i-r_i=0$ |
| First Bianchi automatic on the coordinate-diagonal locus | none | **yes**, four distinct indices make every term of $R_{abcd}+R_{acdb}+R_{adbc}$ vanish, three distinct indices force a repeated pair the distinctness forbids |
| Newton's identities (Lemma A) | $t_1+t_2+t_3=0$ | **yes** |
| Compactness of the unit sphere of $\mathcal D_n$ | $\dim\mathcal D_n<\infty$ | **yes** |
| Attainment: [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 2.25 | $k+l=n$, and the labelling convention $\mathbb R^k\oplus\mathbb R^l\mapsto S^k\times S^l$ that the notes flag as having caused an off-by-one | **yes**, and the source is **in [references/](../references/) and was read** |

### 1.3 Which of these the *written* proof actually uses, and what it does not

The written proof uses H1–H8 and the six imports above. **It uses none of the following**, and no hypothesis of the block asks for them: compactness or irreducibility of any manifold; nondegeneracy of any critical orbit; $\ker W=0$; $n\ge12$; either parity; and (the point of the round), **nothing published**. In particular [Jäger](../references/jaeger-2016-diagonal-case/notes.md)'s Theorem A ($n\ge16$ even) is not consumed anywhere in the chain, so the record's claim that the odd case "rests on this theorem and on nothing published" is a claim about the dependency graph, and on the dependency graph it is **true**.

*One genuine hypothesis debt at the statement level, and it is discharged by the statement's own shape:* the proof's $\mu>0$ fails at $W=0$, where the statement reads $0\le0$ and holds trivially. So no repair is owed to the statement; the repair owed is the word "$S\ne0$" in the proof.

## 2. Step 1, PROVEN

### 2.1 The derivation, in full

Pair $S^{\circ2}+S^2=\lambda S+D$ with $v\otimes v$, where $Sv=\mu v$ and $\lvert v\rvert=1$. The diagonal correction is forced: $S^{\circ2}$ is hollow and $(S^2)_{ii}=\sum_js_{ij}^2=:r_i$, so matching diagonals gives $D=\mathop{\mathrm{diag}}(r_1,\dots,r_n)$. Hence

$$v^{\mathsf T}S^{\circ2}v+\mu^2=\lambda\mu+\sum_ir_iv_i^2 .$$

Now $\sum_ir_iv_i^2=\sum_{i,j}s_{ij}^2v_i^2=\tfrac12\sum_{i,j}s_{ij}^2(v_i^2+v_j^2)$ by the symmetry of $S$, and $v^{\mathsf T}S^{\circ2}v=\sum_{i,j}s_{ij}^2v_iv_j$, so the two combine into

$$\sum_ir_iv_i^2-v^{\mathsf T}S^{\circ2}v=\tfrac12\sum_{i,j}s_{ij}^2(v_i-v_j)^2=\sum_{i<j}s_{ij}^2(v_i-v_j)^2,$$

giving $(*)$: $\ \lambda\mu=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$. **Exact, no inequality yet.**

The two contractions. First,

$$\sum_{i<j}s_{ij}(v_i-v_j)^2=\tfrac12\sum_{i,j}s_{ij}(v_i^2+v_j^2)-\sum_{i,j}s_{ij}v_iv_j=\sum_iv_i^2\!\!\underbrace{\textstyle\sum_js_{ij}}_{=0\ (S\mathbf1=0)}\!\!-\;v^{\mathsf T}Sv=-\mu .$$

Second, $\sum_{i<j}(v_i-v_j)^2=n\sum v^2-(\sum v)^2=n$, using $\sum v^2=1$ and H6.

Cauchy–Schwarz on the pairing $\sum_{i<j}[s_{ij}(v_i-v_j)]\cdot(v_i-v_j)$:

$$\mu^2\ \le\ \Big(\sum_{i<j}s_{ij}^2(v_i-v_j)^2\Big)\cdot n .$$

Substituting into $(*)$: $\lambda\mu\le\mu^2-\mu^2/n=\frac{n-1}n\mu^2$, and dividing by $\mu>0$ (H5) gives $\lambda\le\frac{n-1}n\mu$. $\square$

### 2.2 What Step 1 does and does not need

It needs the criticality equation, $S\mathbf1=0$, $\lvert v\rvert=1$, $\sum v=0$ and $\mu>0$. **It needs no normalisation of $S$**, both sides are homogeneous of degree $1$ in $S$ under $S\mapsto tS$, since $Q$ is quadratic and so $\lambda\mapsto t\lambda$ while $\mu\mapsto t\mu$. It is parity-free: no $n$ appears except as the count $n$ in $\sum_{i<j}(v_i-v_j)^2=n$.

### 2.3 The cross-check the record books as owed, discharged here

[problem.md](../findings/problem.md):418 says "what is owed there is only the cross-check that the two statements coincide", and [r124](../reviews/REVIEW_r124.md):148 repeats it. It is one line. [diagonal-half.md](../findings/diagonal-half.md):221 records $u^{\mathsf T}M^{\circ2}u=\theta\mu_1+\sum_is_iu_i^2-\mu_1^2$; rearranged,

$$\theta\mu_1=\mu_1^2-\Big(\textstyle\sum_is_iu_i^2-u^{\mathsf T}M^{\circ2}u\Big)=\mu_1^2-\sum_{i<j}M_{ij}^2(u_i-u_j)^2,$$

which is $(*)$ verbatim under $(\lambda,\mu,v,S)=(\theta,\mu_1,u,M)$. **The two statements coincide, and the debt is discharged.**

### 2.4 The one place :418 misreads its own file, GAP

**Locate.** [problem.md](../findings/problem.md):418: "*Superseded:* **Step 1 is the record's own Dirichlet-energy step** in [diagonal-half.md](../findings/diagonal-half.md), **where it already carries a proof**."

**Exhibit.** [diagonal-half.md](../findings/diagonal-half.md):235 states $\theta\le\frac{n-1}n\mu_1$ as *equivalent to* a Poincaré bound, on the **vertex-transitive** sub-locus only; :253 calls what follows "an **open conjecture**" and says the $\frac{n-1}n\mu_1$ factor "**is precisely what is owed**"; :239 records equality "at both sphere products" as a measurement. A reduction plus two measurements is not a proof, and diagonal-half.md says so in its own words.

**Argue the opposite.** The most charitable reading the words support is that the italic "*Superseded:*" prefix marks the whole sentence as retracted, in which case the file is consistent and the sentence is dead text. This is plausible, :384 in the same block says the correct thing ("The record had it as a *reduction* … the argument above is the proof it lacked"). But the prefix carries no explanation and the sentence is in bold, so a consumer reading :418 alone takes it as live.

**Verdict: GAP**, confined to :418. Nothing downstream depends on it, because §2.1 is self-contained.

## 3. Step 2, PROVEN, with one unstated hypothesis restored

### 3.1 (a) $Z(v)\in\mathcal D_n$

$Z$ is symmetric and hollow by construction. For the row sums, with $\sum_{j\ne i}v_j=-v_i$ and $\sum_{j\ne i}v_j^2=1-v_i^2$:

$$\sum_{j\ne i}Z_{ij}=-v_i^2+\frac{(n-1)v_i^2+(1-v_i^2)}{n-2}-\frac{n-1}{(n-1)(n-2)}=-v_i^2+v_i^2+\frac1{n-2}-\frac1{n-2}=0 .$$

**Reproduces exactly as printed.** $\square$

### 3.2 (b) $Z$ is the orthogonal projection

The residual of $v\otimes v$ off the diagonal is $-\frac{v_i^2+v_j^2}{n-2}+\frac1{(n-1)(n-2)}=a_i+a_j+c$ with $a_i=-v_i^2/(n-2)$ and $c=\frac1{(n-1)(n-2)}$. For $T\in\mathcal D_n$,

$$\sum_{i<j}(a_i+a_j)T_{ij}=\sum_{i\ne j}a_iT_{ij}=\sum_ia_i\sum_{j\ne i}T_{ij}=0,\qquad c\sum_{i<j}T_{ij}=\tfrac c2\sum_{i\ne j}T_{ij}=0 .$$

The diagonal part of the full residual, $v_i^2$ on the diagonal against $Z_{ii}=0$, is orthogonal to every $T\in\mathcal D_n$ because $T$ is hollow. **So the orthogonality holds in the ordered Frobenius pairing on all of $\mathrm{Sym}(\mathbb R^n)$, not only on the off-diagonal part**, the block checks only the off-diagonal half, and the diagonal half is the one line it omits. $\square$

*The gauge remark [r124](../reviews/REVIEW_r124.md):31 makes is correct and does not bite: the pair $(a,c)$ is non-unique under $a_i\mapsto a_i+t$, $c\mapsto c-2t$, and the argument uses only the *shape* $a_i+a_j+c$, which is gauge-invariant.*

### 3.3 $\mu=2\langle S,Z\rangle$, and the Cauchy–Schwarz that follows

$\mu=v^{\mathsf T}Sv=\sum_{i,j}s_{ij}v_iv_j=\langle S,v\otimes v\rangle_F$. Since $S\in\mathcal D_n$ and $Z$ is the orthogonal projection of $v\otimes v$ onto $\mathcal D_n$, $\langle S,v\otimes v\rangle_F=\langle S,Z\rangle_F=2\sum_{i<j}s_{ij}Z_{ij}$. **So "$\mu=2\langle S,Z\rangle$" is true with $\langle\cdot,\cdot\rangle$ the unordered-pair pairing**, and then

$$\mu=2\langle S,Z\rangle\le2\lvert S\rvert\,\lvert Z\rvert=2\lvert Z\rvert$$

**uses $\lvert S\rvert_{\text{unordered}}=1$, i.e. $\mathop{\mathrm{tr}}S^2=2$, hypothesis H7, which the step does not state.** That is the whole of the "hypotheses corrected" in claim 3's verdict, and it is the normalisation trap arriving at the one step that feels it (§9).

### 3.4 The norm formula, derived in full

Projection gives $\langle Z,Z\rangle_F=\langle Z,v\otimes v\rangle_F$, and $Z$ is hollow, so with $Q_4:=\sum_iv_i^4$:

$$\langle Z,Z\rangle_F=\sum_{i\ne j}\Big[v_iv_j+\tfrac{v_i^2+v_j^2}{n-2}-\tfrac1{(n-1)(n-2)}\Big]v_iv_j .$$

Term by term, using $\sum v=0$ and $\sum v^2=1$:

- $\sum_{i\ne j}v_i^2v_j^2=(\sum v^2)^2-\sum v^4=1-Q_4$;
- $\sum_{i\ne j}(v_i^2+v_j^2)v_iv_j=2\sum_{i\ne j}v_i^3v_j=2\big[(\sum v^3)(\sum v)-\sum v^4\big]=-2Q_4$, so the middle term is $-\tfrac{2Q_4}{n-2}$;
- $\sum_{i\ne j}v_iv_j=(\sum v)^2-\sum v^2=-1$, so the last term is $+\tfrac1{(n-1)(n-2)}$.

Hence $\langle Z,Z\rangle_F=1+\frac1{(n-1)(n-2)}-Q_4\cdot\frac n{n-2}$, and halving to the unordered norm,

$$\lvert Z\rvert^2=\tfrac12\langle Z,Z\rangle_F=\frac{(n-1)(n-2)+1}{2(n-1)(n-2)}-\frac n{2(n-2)}Q_4=\boxed{\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4}$$

**exactly the printed formula, and in the unordered norm, the same norm §3.3 needs.** $\square$

## 4. Step 3, Proof I PROVEN; the block's paraphrase of Proof II has a GAP

### 4.1 Proof I, in full

**Lemma A.** $t_1+t_2+t_3=0\Rightarrow p_4=\tfrac12p_2^2$. Newton with $e_1=0$: $p_2=-2e_2$, and $p_4=e_1p_3-e_2p_2+e_3p_1=-e_2p_2=\tfrac12p_2^2$. $\square$ So on the circle $C=\{\sum t=0,\sum t^2=\sigma\}\subset\mathbb R^3$ the quartic is **constant**, an exact invariance, not a smoothing, and the block says so.

**The theorem.** The constraint set $\{\sum v=0,\sum v^2=1\}$ is compact and the objective continuous, so a global minimiser exists; H8 gives Lagrange, $4v_i^3=\alpha+2\beta v_i$, so every $v_i$ is a root of one cubic with no quadratic term: **at most three distinct values, and if exactly three they are all the roots and sum to $0$.**

Suppose a minimiser has exactly three. Take one coordinate carrying each value; their sum is $r_1+r_2+r_3=0$ and their square-sum $\sigma>0$ (at least two of three distinct values are nonzero). Replace them by any $t\in C$: both constraints are preserved and, by Lemma A, so is the objective, so the new vector is again a global minimiser and must again have at most three distinct values. Choose $t\in C$ with three distinct entries avoiding the three old values, $C$ is a circle, and only finitely many of its points are excluded (six by $t_i=t_j$, at most nine more by $t_i=r_k$). Since $n\ge4$, at least one coordinate is untouched and still carries an old value, so the new vector has **at least four** distinct values. Contradiction. $\square$

Hence at most two values; one value is impossible ($\sum v=0$ would force $v=0$). With multiplicities $p+q=n$, $p,q\ge1$: $a=\sqrt{q/(np)}$, $b=-\sqrt{p/(nq)}$, and

$$\sum v^4=\frac{q^2}{n^2p}+\frac{p^2}{n^2q}=\frac{p^3+q^3}{n^2pq}=\frac{n^3-3pqn}{n^2pq}=\frac n{pq}-\frac3n,$$

strictly decreasing in $pq$, minimised at $pq=\lfloor n/2\rfloor\lceil n/2\rceil$. Even $n$: $\frac4n-\frac3n=\frac1n$. Odd $n$: $\frac{4n}{n^2-1}-\frac3n=\frac{4n^2-3(n^2-1)}{n(n^2-1)}=\frac{n^2+3}{n(n^2-1)}$. **Both printed values reproduce exactly, and $pq$ is strictly unimodal in the integer $p$, so the minimising split is unique up to swapping $p$ and $q$.** $\square$

**Proof I is parity-blind.** The only thing that splits by parity is the arithmetic of $\lfloor n/2\rfloor\lceil n/2\rceil$.

### 4.2 The block's Proof II, GAP, and the three-step record

**Locate.** [problem.md](../findings/problem.md):340: "For three values, the depressed cubic gives $r_1+r_2+r_3=0$, and $\sum m_ir_i=0$ pins $r$ to the line spanned by $u=\mathbf1\times m$. **So the three-value branch is indexed by *multiplicities alone***".

**Exhibit, at a named dimension.** Take $n=6$ and $m=(2,2,2)$. Then $u=\mathbf1\times m=(m_3-m_2,m_1-m_3,m_2-m_1)=(0,0,0)$, so "the line spanned by $u$" is $\{0\}$, which would force $r=0$ and contradict $\sum m_ir_i^2=1$. The branch is not a line: $\sum m_ir_i=2\sum r_i$ is the *same* condition as $r_1+r_2+r_3=0$, so $r$ ranges over a whole circle. A concrete member is $v=(\tfrac12,\tfrac12,-\tfrac12,-\tfrac12,0,0)$, which satisfies $\sum v=0$, $\sum v^2=1$, has exactly three distinct values with multiplicities $(2,2,2)$, and has $\sum v^4=4\cdot\tfrac1{16}=\tfrac14$. The failure recurs at every $n$ divisible by $3$.

**Argue the opposite.** The most charitable reading is that "indexed by multiplicities alone" is a claim about the *value* rather than the point, and that reading survives: Lemma A makes $\sum v^4=\tfrac n3\cdot\tfrac12(3/n)^2=\tfrac3{2n}$ constant on the degenerate branch ($\tfrac3{12}=\tfrac14$ at $n=6$, matching the witness exactly) so $G$ is still a function of $m$. Under that reading only the sentence's stated *mechanism* is wrong, not its conclusion.

**And the source is clean.** [r124](../reviews/REVIEW_r124.md):67–79 splits the case explicitly, "*If $m$ is not constant* … *If $m$ is constant* ($3\mid n$), the two conditions coincide and $r$ is free subject to $e_1(r)=0$. There $p_4(r)=2e_2^2=\tfrac12p_2(r)^2$ identically, so $\sum v^4=\tfrac3{2n}$", and closes it with $\tfrac3{2n}>\tfrac{n^2+3}{n(n^2-1)}\iff n^2>9$. I checked that equivalence: cross-multiplying by $2n(n^2-1)>0$ gives $3n^2-3>2n^2+6$, i.e. $n^2>9$. **So the case split exists on file and was dropped in transcription into the block.**

**Verdict: GAP in the block's paraphrase only.** Proof II is sound at source; the block's one-sentence reproduction of it is not. Step 3 does not depend on this in any case, Proof I closes it alone.

*One further remark on Proof II that I could not check: the positivity sub-lemma "$(n-1)M_4-M_2^2$ expands with all $24$ monomials positive". [r124](../reviews/REVIEW_r124.md):81–88 exhibits the expansion in the substitution $s=a-1,x=b-a,y=c-b$, and I confirmed its shape but did not expand $A(x,y)$ and $B(x,y)$ by hand. It is not load-bearing for step 3.*

## 5. The chaining, PROVEN, both constants reproduced exactly

$\lambda\le\frac{n-1}n\mu\le\frac{n-1}n\cdot2\lvert Z\rvert$, and $\lvert Z\rvert^2$ is maximised by minimising $\sum v^4$.

**Even $n$**, at $\sum v^4=\frac1n$:

$$\lvert Z\rvert^2_{\max}=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac1{2(n-2)}=\frac{n^2-4n+4}{2(n-1)(n-2)}=\frac{(n-2)^2}{2(n-1)(n-2)}=\frac{n-2}{2(n-1)},$$

$$\lambda^2\le\Big(\frac{n-1}n\Big)^2\cdot4\cdot\frac{n-2}{2(n-1)}=\frac{2(n-1)(n-2)}{n^2}=\Theta_n^2 .$$

**Odd $n$**, at $\sum v^4=\frac{n^2+3}{n(n^2-1)}$, where $\frac n{2(n-2)}\sum v^4=\frac{n^2+3}{2(n-2)(n^2-1)}$:

$$\lvert Z\rvert^2_{\max}=\frac{(n^2-3n+3)(n+1)-(n^2+3)}{2(n-1)(n-2)(n+1)}=\frac{(n^3-2n^2+3)-(n^2+3)}{2(n-1)(n-2)(n+1)}=\frac{n^2(n-3)}{2(n-1)(n-2)(n+1)},$$

$$\lambda^2\le\frac{(n-1)^2}{n^2}\cdot\frac{2n^2(n-3)}{(n-1)(n-2)(n+1)}=\frac{2(n-1)(n-3)}{(n+1)(n-2)}=\Theta_n^2 .$$

**Both printed constants, with no slack anywhere.** Edge values, exact: $\Theta_4^2=\frac{2\cdot3\cdot2}{16}=\frac34$, so $\Theta_4=\frac{\sqrt3}2$; $\Theta_5^2=\frac{2\cdot4\cdot2}{6\cdot3}=\frac89$, so $\Theta_5=\frac{2\sqrt2}3$. *Squaring is presentational only: the chain is a chain of upper bounds on $\lambda$ with positive coefficients, so it delivers $\lambda\le\Theta_n$ directly and never needs $\lambda\ge0$.*

## 6. Pre-registered question 1, the quantifier, and the bridge

**The question.** The statement is "for every diagonal $W$ at every $n\ge4$"; the written proof opens at a critical point. Does the argument reach a diagonal $W$ that is not critical?

**Answer: yes, and the reduction is on file, but not where the block's map says to look.**

### 6.1 Where it is

The bridge is at [problem.md](../findings/problem.md):418, under the heading **"So the all-$n$ diagonal theorem is COMPLETE"**. **That heading is not one of the four the block's own map names**, and it is not in the brief as dispatched, whose "The proof as written" stops at the chaining. So a reader following the map (or reading the brief), finds no bridge; a reader who scrolls finds one. *The map was rebuilt from line numbers to heading anchors at phase 0 of this round precisely so it would survive edits, and it still names four of the five places the argument lives.*

### 6.2 Whether it is correct

The text: "$\mathcal D_n$ is a linear subspace and the cubic is continuous and homogeneous, so its maximum over the unit sphere of $\mathcal D_n$ (compact), is attained, and the maximiser is critical for the restricted problem. **$Q$ preserves $\mathcal D_n$**, so that restricted criticality is the equation the chain solves: hollowness and $S\mathbf1=0$ pass through $S^{\circ2}+S^2$ up to the diagonal correction $D$."

Checked line by line:

1. $\mathcal D_n$ is a linear subspace, symmetry, hollowness and $S\mathbf1=0$ are all linear. ✓
2. $P$ is continuous and homogeneous of degree $3$; the unit sphere of a finite-dimensional subspace is compact; the maximum is attained. ✓
3. A maximiser satisfies the constrained Euler–Lagrange equation $P_{\mathcal D_n}Q(S_*)=\lambda S_*$. ✓
4. **$P_{\mathcal D_n}(S^{\circ2}+S^2)=S^{\circ2}+S^2-D$ with $D=\mathop{\mathrm{diag}}(r)$.** This needs both halves: the result is hollow (diagonal of $S^{\circ2}+S^2$ is $0+r_i$, cancelled by $D$) *and* has zero row sums ($\sum_{j}(S^{\circ2})_{ij}=r_i$, $\sum_j(S^2)_{ij}=(S^2\mathbf1)_i=0$, and subtracting $D_{ii}=r_i$ leaves $r_i+0-r_i=0$). And the discarded part is diagonal, hence orthogonal to hollow $\mathcal D_n$, so subtracting it *is* the orthogonal projection. ✓ **So restricted criticality is exactly $S^{\circ2}+S^2=\lambda S+D$, which is what step 1 consumes.**
5. The clause "**$Q$ preserves $\mathcal D_n$**" is, read alone, false, $S^{\circ2}+S^2$ has diagonal $r\ne0$. The same sentence corrects it ("up to the diagonal correction $D$"), and at the *Weyl-operator* level it is true without correction, the sectional matrix being hollow by definition and $D$ pure bookkeeping. **Not a defect; a sentence that would be one if the second half were deleted.**
6. At the maximiser, $\langle Q(S_*),S_*\rangle_{\Lambda^2}=\lambda$ by (N2), so the largest critical value *is* the maximum, and homogeneity extends $\lambda\le\Theta_n$ to $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ on all of $\mathcal D_n$. ✓

**Verdict: PROVEN.** The proof reaches every diagonal $W$, including every non-critical one and $W=0$. The independent cold re-derivation at [r500](../reviews/REVIEW_r500.md):116 reaches the same bridge by the same route.

*The criticality equation the bridge produces is also derived independently at [diagonal-half.md](../findings/diagonal-half.md):75, and I checked that derivation: summing the off-diagonal equation over $j\ne i$ makes the left side $r_i-r_i=0$ and the right side $(n-2)v_i+\mathbf1^{\mathsf T}v$, so all $v_i$ agree at some $w$, and $(n-2)w=-nw$ gives $(2n-2)w=0$, hence $w=0$ for $n\ge2$. ✓*

## 7. Pre-registered question 2, F7, balancedness as input or output

### 7.1 The step the brief names, checked

"$(1-\tfrac1p)(1-\tfrac1q)$ grows as $p$ and $q$ even out." With $p+q=n$,

$$\Big(1-\frac1p\Big)\Big(1-\frac1q\Big)=1-\frac1p-\frac1q+\frac1{pq}=1-\frac{p+q}{pq}+\frac1{pq}=1-\frac{n-1}{pq},$$

**strictly increasing in $pq$ at fixed $n$**, and $pq$ is strictly unimodal in the integer $p$ with a unique maximum at $\{p,q\}=\{\lfloor n/2\rfloor,\lceil n/2\rceil\}$. **The step is correct, and it is a one-line identity rather than a gesture.** Since $\theta(S^p\times S^q)^2=\frac{2(n-1)}{n-2}\cdot\big(1-\frac{n-1}{pq}\big)$, the balanced split strictly beats every other sphere product, at every $n$ and both parities. **Claim 9: PROVEN.**

Collapse to $\Theta_n^2$, checked both parities: at $p=q=n/2$, $\frac{2(n-1)\cdot\frac{(n-2)^2}4}{(n-2)\cdot\frac{n^2}4}=\frac{2(n-1)(n-2)}{n^2}$ ✓; at $p,q=\frac{n\mp1}2$, $\frac{2(n-1)\cdot\frac{(n-3)(n-1)}4}{(n-2)\cdot\frac{n^2-1}4}=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$ ✓.

### 7.2 F7 itself: the two-value ratio singles out no split, CONFIRMED as a fact, REFUTED as an objection

**F7 is right about the object it names.** [problem.md](../findings/problem.md):283 (step 2(c)) checks one ratio, $Z_{\text{same block}}/Z_{\text{cross}}=-\frac{n/2}{n/2-1}$. I evaluated it: at the balanced two-value $v$, $a^2=b^2=\frac1n$ and $ab=-\frac1n$, so

$$Z_{aa}=\tfrac1n\cdot\tfrac n{n-2}-\tfrac1{(n-1)(n-2)}=\tfrac1{n-1},\qquad Z_{ab}=-\tfrac1n+\tfrac{2/n}{n-2}-\tfrac1{(n-1)(n-2)}=-\tfrac{n-2}{n(n-1)},$$

giving $Z_{aa}/Z_{ab}=-\frac n{n-2}=-\frac{n/2}{n/2-1}$ ✓, the block's printed value, and its quoted $-1.5,-\tfrac43,-1.25,-1.2$ at $n=6,8,10,12$ are that expression, correct arithmetic.

**And the match is automatic for every split, so it selects nothing.** The record's own structural note at [problem.md](../findings/problem.md):367 gives the reason: block-constant elements of $\mathcal D_n$ with block sizes $p,q$ satisfy $(p-1)x+qz=0$ and $(q-1)y+pz=0$, a **one-dimensional** solution space. $Z(v)$ for *any* two-value $v$ is block-constant and lies in $\mathcal D_n$, so it is automatically proportional to the vertex matrix of $S^p\times S^q$, balanced or not. **F7's observation is therefore correct.**

**But it does not touch the theorem, because the split is selected elsewhere.** The balanced split is an **output of step 3**, which pins $v$'s multiplicities to $\lfloor n/2\rfloor,\lceil n/2\rceil$ before $Z(v)$ is ever formed. Step 2(c) is a *verification of identification* ("the matrix the chain lands on is the sphere product's"), not a *selection*. Reading 2(c) as the selection is the error F7 names, and the block invites it by heading 2(c) "**The equality case is the balanced product**, computed rather than asserted".

**So: balancedness is an OUTPUT, and it is an output of exactly one step.** Two independent things single it out and they agree, step 3's fourth-moment minimum, and §7.1's monotonicity within the sphere-product family. Nothing else in the proof does.

### 7.3 The odd case checks both ratios, and I reproduced all three values exactly

At $k=\frac{n-1}2$: $a^2=\frac{n+1}{n(n-1)}$, $b^2=\frac{n-1}{n(n+1)}$, so $ab=-\sqrt{a^2b^2}=-\frac1n$ (this is the "$\sqrt{n-1}\sqrt{1/(n-1)}=1$ collapse" the block names). Then

$$Z_{aa}=\frac{n+1}{n(n-1)}\cdot\frac n{n-2}-\frac1{(n-1)(n-2)}=\frac n{(n-1)(n-2)},$$
$$Z_{bb}=\frac{n-1}{(n+1)(n-2)}-\frac1{(n-1)(n-2)}=\frac{(n-1)^2-(n+1)}{(n-1)(n+1)(n-2)}=\frac{n(n-3)}{(n-1)(n-2)(n+1)},$$
$$Z_{ab}=-\frac1n+\frac{2n^2+2}{n(n^2-1)(n-2)}-\frac1{(n-1)(n-2)}=\frac{-n^2(n-3)}{n(n-1)(n+1)(n-2)}=-\,\frac{n(n-3)}{(n-1)(n-2)(n+1)} .$$

**So $Z_{ab}=-Z_{bb}$**, which is the value [problem.md](../findings/problem.md):318 leaves as "(the cross value)" and :367 supplies. The two ratios are $Z_{aa}/Z_{ab}=-\frac{n+1}{n-3}$ and $Z_{bb}/Z_{ab}=-1$, **identically in $n$**, matching the vertex matrix of $S^{(n-1)/2}\times S^{(n+1)/2}$, whose ratios from the same one-dimensionality are $-\frac q{p-1}=-\frac{n+1}{n-3}$ and $-\frac p{q-1}=-1$. ✓ At $n=5$: $Z_{aa}=\frac5{12}$, $Z_{bb}=\frac5{36}$, $Z_{ab}=-\frac5{36}$, ratios $-3$ and $-1$, against $-\frac{5+1}{5-3}=-3$ ✓.

**Two ratios do pin the split, but again only because step 3 already pinned the multiplicities.** The identification is exact at both parities.

## 8. Pre-registered question 3, F8, and the three steps at odd $n$, one at a time

| step | parity status of its **proof** | parity status of its **conclusion** |
| --- | --- | --- |
| **Step 1** | **parity-free.** No case distinction and no floor or ceiling; the only $n$ is the count in $\sum_{i<j}(v_i-v_j)^2=n$ | parity-free: $\lambda\le\frac{n-1}n\mu$ |
| **Step 2** | **parity-free.** Both halves and the norm formula are identities in $n$ | parity-free |
| **Step 3** | **parity-free.** Proof I never distinguishes cases; the block says so ("It is parity-blind, so it re-proves the even case as a corollary and step 3 becomes one theorem rather than two") and I confirmed it in §4.1. Proof II *is* parity-split at [r124](../reviews/REVIEW_r124.md), and the block's paraphrase of it fails at $3\mid n$ (§4.2) | **parity-split**, and only because $\lfloor n/2\rfloor\lceil n/2\rceil$ is $\frac{n^2}4$ or $\frac{n^2-1}4$ |
| **the equality case** | **parity-split by design**: the even identification is at 2(c), the odd at heading (d), derived symbolically in $n$ | parity-split |
| **attainment** | parity-free, one closed form in $(n,p,q)$ | collapses to each $\Theta_n$ |
| **the bridge** | parity-free | parity-free |

**So [results.md](../results.md):268's "Every step holds at both parities" is PROVEN, and F8 is REFUTED against the current text.** F8 ("the computation covers even $n$ only") is accurate about *one* paragraph (step 2(c)'s numerical corroboration lists $n=6,8,10,12$ only) but that paragraph is the even equality case, and the odd equality case has its own heading (d) with $n=5,7,9,11,13$ named there. **Nothing in the proof is written for even $n$ and asserted for odd.**

*The only odd-$n$ exclusion anywhere is at [problem.md](../findings/problem.md):368, "Odd uniqueness needs $n\ge5$", and its content is $n=3$: Lemma A makes $\sum v^4\equiv\tfrac12$ on the entire constraint set there, which coincidentally equals $\frac{n^2+3}{n(n^2-1)}=\frac{12}{24}$ at $n=3$. **$n=3$ is outside the theorem's range**, so the exclusion is vacuous, and §10.3 is about what happened when it was carried into the statement anyway.*

## 9. The normalisation trap, the chaining is consistent

| step | what it normalises | which norm |
| --- | --- | --- |
| Step 1 | $\lvert v\rvert=1$ only; **nothing on $S$**, the statement is homogeneous of degree $1$ in $S$ | none |
| Step 2, $\mu\le2\lvert Z\rvert$ | $\lvert S\rvert=1$ | **unordered pairs**, $\sum_{i<j}s_{ij}^2=1$, i.e. $\mathop{\mathrm{tr}}S^2=2$ |
| Step 2, the $\lvert Z\rvert^2$ formula | $\sum v^2=1$ | **unordered pairs**, §3.4 derives $\langle Z,Z\rangle_F$ and halves it, and the halving is exactly what produces the printed $\frac{n^2-3n+3}{2(n-1)(n-2)}$ |
| Step 3 | $\sum v^2=1$ | none on $S$ |

**One norm is used wherever a norm is used, and it is the unordered one.** By (N1) that is exactly $\lVert W\rVert=1$, which is [conventions.md](../findings/conventions.md)'s own $\lVert K\rVert_F^2=2$ at a unit Weyl tensor. **The chaining is consistent, and the constants it delivers are the constants for $\lVert W\rVert=1$.**

**The block's warning is correct and load-bearing.** Under conventions.md's stated default ("sums over pairs are over ORDERED pairs unless the line says otherwise"), the phrase "$\lvert S\rvert=1$" would read $\mathop{\mathrm{tr}}S^2=1$, the working locus would be $\lVert W\rVert=1/\sqrt2$, and the chain would deliver $\Theta_n/\sqrt2$. The block names the trap and writes $\mathop{\mathrm{tr}}S^2=2$ instead. *[r500](../reviews/REVIEW_r500.md):Finding 4 reports the same trap live in an earlier version of the block; the current text has taken the repair.*

**Where the trap is still live, faintly.** §3.3's Cauchy–Schwarz is the one step that consumes the normalisation, and it does not restate it, that is H7, and it is the "hypotheses corrected" in claim 3. The reader must carry $\mathop{\mathrm{tr}}S^2=2$ from the block's opening line two paragraphs above.

**The statement itself is safe.** Both citable forms are scale-free: $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ ([problem.md](../findings/problem.md):573) and $\theta\le\Theta_n$ ([results.md](../results.md):98) carry no normalisation to get wrong.

## 10. The equality clause, attainment and uniqueness are separate claims, and I checked both

### 10.1 Attainment, PROVEN

The block asserts $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ "from criticality with $\lambda_V=1-n$ independent of the split", with no derivation under the heading. **The derivation is on file** at [r500](../reviews/REVIEW_r500.md):83, which the block cites: with $V$ block-constant at cross value $1$ and within-block values $-q/(p-1)$ and $-p/(q-1)$ forced by the zero row sums, $\lambda_V=1-n$ and $\sum_{i<j}V_{ij}^2=\frac{pq(n-1)(n-2)}{2(p-1)(q-1)}$, and $\theta=\lambda_V/\lvert V\rvert$ squares to the stated form. I checked the two collapses (§7.1) and the two-parameter shape against the one-dimensionality of the block-constant subspace (§7.2).

**And it is independently in a source I read.** [nienhaus-2023-second-best-einstein/notes.md](../references/nienhaus-2023-second-best-einstein/notes.md):19–23 quotes Proposition 2.25: $\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}k\cdot\frac{l-1}l\cdot\frac{n-1}{n-2}}$, whose square is $\frac{2(n-1)(k-1)(l-1)}{(n-2)kl}$, **the same expression**. The notes flag a labelling convention ($\mathbb R^k\oplus\mathbb R^l\mapsto S^k\times S^l$) that once caused an off-by-one; under it $\theta_{1,n-1}=0$, which is right, a circle factor contributing nothing. **This source is in [references/](../references/) and was read, so attainment does not rest on an unread source.**

### 10.2 Uniqueness, PROVEN at every $n\ge4$

Equality in the chain forces equality at each link, since the endpoints agree:

1. $\sum v^4=\min$, so by §4.1 $v$ is two-valued with multiplicities $\lfloor n/2\rfloor,\lceil n/2\rceil$, unique up to permutation and the global sign of $v$, and $Z(-v)=Z(v)$, so the sign is immaterial;
2. equality in $\mu=2\langle S,Z\rangle\le2\lvert S\rvert\lvert Z\rvert$ forces $S=Z/\lvert Z\rvert$ (a **positive** multiple, since $\mu>0$);
3. $Z(v)$ is block-constant and in $\mathcal D_n$, and block-constant elements of $\mathcal D_n$ form a one-dimensional space, so $Z(v)$ *must* be proportional to the vertex matrix of $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$.

So the equality set is a single $O(n)$-orbit. **Nothing in this needs step 1's equality case**, which is a consistency check rather than a link.

**At $n=4$ I checked uniqueness a second way, by hand and independently of steps 1–3.** $\mathcal D_4$ is two-dimensional and, in the matching basis $K_{12}=K_{34}=a$, $K_{13}=K_{24}=b$, $K_{14}=K_{23}=c$, is cut out by $a+b+c=0$ with $\mathop{\mathrm{tr}}K^2=4(a^2+b^2+c^2)=2$. The record's $\theta=18abc$ then has $e_1=0$ and $e_2=-\tfrac12p_2=-\tfrac14$, so $a,b,c$ are the roots of $t^3-\tfrac14t-e_3$, which has three real roots iff $-4(-\tfrac14)^3-27e_3^2\ge0$, i.e. $e_3^2\le\tfrac1{432}$. Hence $\max abc=\tfrac1{12\sqrt3}$ and $\max\theta=\tfrac{18}{12\sqrt3}=\tfrac{\sqrt3}2=\Theta_4$ ✓, **attained only at the double root**, $(a,b,c)=(\tfrac1{\sqrt3},-\tfrac1{2\sqrt3},-\tfrac1{2\sqrt3})$ up to permutation, which is $S^2\times S^2$, since the balanced $V$ has $x=-2z$ and $z=-\tfrac1{2\sqrt3}$. **Uniqueness at $n=4$, exactly.**

### 10.3 [problem.md](../findings/problem.md):418, "uniquely for $n\ge5$", BROKEN

**Locate.** "**$\langle Q(W),W\rangle\le\Theta_n\lvert W\rvert^3$ for every diagonal Weyl tensor at every $n\ge4$, with equality exactly at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ (up to sign and permutation, uniquely for $n\ge5$).**"

**Exhibit.** At $n=4$ uniqueness holds and the record proves it twice, once by §10.2's general argument (step 3 at $n=4$ gives $pq\le4$ with equality only at $p=q=2$, and $\sum v^4=\tfrac44-\tfrac34=\tfrac14=\tfrac1n$), and once by the graph-functional argument the block itself states **in the paragraph immediately above**, at :416: "**uniqueness holds at $n=4$ as well**, the raw graph functional $\theta=18abc$ there has its maximum $\sqrt3/2$ at $S^2\times S^2$ alone." **So the boldface citable statement excludes an $n$ the paragraph above it proves.** The "$n\ge5$" is inherited from :368's "Odd uniqueness needs $n\ge5$", whose content is the exclusion of $n=3$ (a dimension outside the theorem entirely) and from [r124](../reviews/REVIEW_r124.md):142, which says "Yes for $n\ge5$" about **the odd equality case** and names $n=3$ as the one exception. A parity-restricted qualifier was transcribed as a parity-free one.

**Argue the opposite.** The most charitable reading is that "uniquely for $n\ge5$" is meant to modify only the odd half of the equality case, since that is where its source lies. The words do not support it: the clause sits inside a single parenthetical attached to a statement quantified over "every $n\ge4$", with no parity marker anywhere in the sentence.

**Verdict: BROKEN**, and it is this record's signature failure exactly, the correction is at :416 and the statement is at :418, so a consumer who cites the statement inherits the defect. **The correct qualifier is "uniquely at every $n\ge4$".** *[results.md](../results.md):98 and :268 carry no such qualifier and are therefore correct; the findings-file form is the weak one.*

### 10.4 [problem.md](../findings/problem.md):416, "Equality is up to $\pm1\times S_n$", BROKEN

**Locate.** "**Equality is up to $\pm1\times S_n$**, the maximiser being $-V/\lVert V\rVert$".

**Exhibit.** $Q$ is quadratic, so $P(W)=\langle W,Q(W)\rangle$ is an odd cubic: $P(-W)=-P(W)$. The claim is about the equality set of an **upper** bound, and $\Theta_n>0$, so exactly one of $\pm S_*$ attains it and the other attains $-\Theta_n$. Concretely at $n=4$: $S_*=-V/\lVert V\rVert$ gives $P=+\tfrac{\sqrt3}2=\Theta_4$, while $+V/\lVert V\rVert$ gives $P=-\tfrac{\sqrt3}2\ne\Theta_4$. **The equality set is not closed under the sign flip, so it is not "up to $\pm1\times S_n$".** The same sentence names the right sign, and the correction bullet at :365 names it again ("since $P$ is an odd cubic the equality case is stated as $S=-V/\lVert V\rVert$"), as does [r500](../reviews/REVIEW_r500.md):105 independently.

**Argue the opposite.** The most charitable reading is that "$\pm1$" refers to the sign ambiguity of the *frame vectors*, the coordinate-diagonal structure is preserved by signed permutations $\{\pm1\}^n\rtimes S_n$, and the sectional matrix $K_{ab}=W_{abab}$ is invariant under the sign flips and permuted by $S_n$. Under that reading the clause is true but wholly redundant with $S_n$, since the sign flips act trivially on $K$. The reading a consumer takes (the group $\{\pm1\}\times S_n$ acting as $S\mapsto\pm P_\sigma SP_\sigma^{\mathsf T}$), is the one the notation writes, and it is false.

**Verdict: BROKEN**, and confined to :416.

**Scope note, and it matters.** The *statement* at :579 and both [results.md](../results.md) forms say "equality exactly at the **Weyl tensor of** $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$", which names a manifold rather than a signed matrix and is **correct**: the sphere product's own Weyl tensor is positive within blocks and negative across, which is $-V$ in the record's cross-value-$+1$ parametrisation of $V$. **So neither BROKEN clause infects the headline statement.** They infect the closing paragraph a reader reaches after the proof, which is where a reader looking for the theorem's final form will stop.

## 11. The three forms, and the Lean row that does not exist

| form | text | assessment |
| --- | --- | --- |
| [problem.md](../findings/problem.md):571–579 | "$\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ for every diagonal $W$ at every $n\ge4$" + both constants + "equality exactly at $S^{n/2}\times S^{n/2}$ for even $n$ and at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ for odd $n$. At even $n$, $\Theta_n=\theta_0(n)$" | **correct.** Scale-free; the two equality cases are one expression written twice; "$\Theta_n=\theta_0(n)$ at even $n$" is an identity of the two printed formulas. The word "diagonal" is not qualified by "in some frame", which [conventions.md](../findings/conventions.md) fixes and which the $O(n)$-invariance of both sides makes harmless |
| [results.md](../results.md):98 | "for every unit $W$ diagonal in some frame, $\theta\le\Theta_n$ … equality exactly at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$. Three steps, each proved" | **correct, and the cleanest of the three.** $\theta$ is a ratio, so no normalisation can be misread |
| [results.md](../results.md):268 | the full statement, "with $\lVert M\rVert$ normalised to $\lVert W\rVert=1$", the three steps named, "Every step holds at both parities", "It does not reach any $W$ that is diagonal in no frame" | **correct.** The normalisation is stated in the safe direction, by naming $\lVert W\rVert=1$ rather than a number for $\mathop{\mathrm{tr}}M^2$. "whose kernel is explicit" is supported: step 2(b) exhibits the kernel of the projection as $\{a_i+a_j+c\}$ |
| **a Lean form** | **none exists.** [lean/INDEX.md](../lean/INDEX.md):359 lists **L57** under "**out (needs machinery Mathlib does not have**), the classification of compact symmetric spaces" | **HYPOTHESIS-DEBT, and the bucket is wrong** |

**The bucket is wrong, and this is a finding rather than a formatting note.** Nothing in L57's proof touches the classification of compact symmetric spaces. Steps 1–3 are Cauchy–Schwarz twice and a Lagrange-multiplier argument, entirely on $n\times n$ real matrices and vectors in $\mathbb R^n$; the bridge is compactness of a sphere in a finite-dimensional subspace; the equality case is the one-dimensionality of a block-constant linear system. **What the row would have to claim**, if it were written: *for every $n\ge4$ and every $S\in\mathcal D_n$, $\langle S^{\circ2}+S^2,S\rangle_F\le2\Theta_n\big(\tfrac12\mathop{\mathrm{tr}}S^2\big)^{3/2}$, with the equality set the $O(n)$-orbit of the block-constant matrix with blocks of size $\lfloor n/2\rfloor$ and $\lceil n/2\rceil$*, which is formalisable as stated. The part that genuinely needs machinery is not the theorem but the *interpretation* of the equality case as "the Weyl tensor of a sphere product", and that is one definition, not a classification. **L57 belongs in `ready`, or split with the interpretation clause stated and left unformalised.**

## 12. The gap between what is proven and what is used, what a consumer may cite

**May be cited, unconditionally:**

- $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ for **every** $W\in\mathcal W_n$ diagonal in some orthonormal frame, at **every** $n\ge4$, at **both** parities, with $\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}$ (even) and $\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ (odd). Critical points are not a hypothesis of this; the bridge removes them.
- Equality holds, and holds exactly on the $O(n)$-orbit of the Weyl tensor of $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$, **at every $n\ge4$, $n=4$ included**.
- The three steps individually, each with the hypotheses of §1.1 attached, in particular step 2's Cauchy–Schwarz **only at $\mathop{\mathrm{tr}}S^2=2$**.
- $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ for every split, and the balanced split as its strict maximum.

**May NOT be cited:**

- "Equality is up to $\pm1\times S_n$" ([problem.md](../findings/problem.md):416), false.
- "uniquely for $n\ge5$" ([problem.md](../findings/problem.md):418), understates the theorem by one dimension.
- "the three-value branch is indexed by multiplicities alone … pins $r$ to the line spanned by $u=\mathbf1\times m$" ([problem.md](../findings/problem.md):340), false at $3\mid n$; cite [r124](../reviews/REVIEW_r124.md):65–79 instead, which case-splits correctly.
- "Step 1 … in [diagonal-half.md](../findings/diagonal-half.md), where it already carries a proof" ([problem.md](../findings/problem.md):418), diagonal-half.md carries a reduction and calls the step owed; the proof is at [problem.md](../findings/problem.md):370.

**The gap between proven and used.** [results.md](../results.md) uses L57 in four places (:12, :31, :35, :47, :59, :84, :88) and every use is within what is proven: the diagonal half of the dichotomy, the removal of the dependence on Jäger, and the odd-$n$ threshold value. **No consumer on the record cites either broken clause.** The one exposure is :88, which cites the odd threshold and the equality case together, and the equality case it cites is the correct manifold form.

## 13. Edges, checked one at a time

- **$n=4$.** $\dim\mathcal D_4=2$ (six off-diagonal entries, four independent row-sum conditions). Every step holds; step 3's circle argument needs exactly $n\ge4$ and has one coordinate to spare. $\Theta_4=\frac{\sqrt3}2$ by two independent hand computations (§5, §10.2). The balanced split is $p=q=2$, both factors genuine spheres. **No finding.**
- **$n=5$.** $\Theta_5^2=\frac89$; the equality case is $S^2\times S^3$ with $V=(-3,-1,1)$ and $v\propto(3,3,-2,-2,-2)$, whose $\sum v^4=\frac{2\cdot81+3\cdot16}{900}=\frac{210}{900}=\frac7{30}=\frac{n^2+3}{n(n^2-1)}$ **exactly**, so step 3 is tight there. Both odd ratios reproduce (§7.3). **No finding.**
- **Odd $n$ generally.** Covered in §8. **No finding beyond §4.2.**
- **$\ker W\ne0$.** Nothing in the proof asks for a trivial kernel. On this locus $\dim\ker M$ is the number of connected components of the weighted graph ([diagonal-half.md](../findings/diagonal-half.md):171), and a disconnected $S$ passes through every step unchanged: step 1 needs only $\mu>0$, step 2 only $\lvert S\rvert=1$, step 3 nothing about $S$ at all. **No finding.** *(Distinct from [L11](../findings/nondegeneracy.md)'s degeneracy of $S^3\times S^3$ at $\Theta_6$, which is about the second variation and is not consumed here.)*
- **$W=0$.** The statement reads $0\le0$ and holds; the proof's $\mu>0$ excludes it. **Recorded as H5, no repair owed to the statement.**
- **$n=3$.** Outside the range. Lemma A makes $\sum v^4\equiv\tfrac12$ on the whole constraint set, so uniqueness fails there, which is the only content of "$n\ge5$" and the source of the §10.3 defect.

## 14. What would break it, and what I did to look for it

**The falsifier.** A matrix $S\in\mathcal D_n$ at some $n\ge4$ with $\mathop{\mathrm{tr}}S^2=2$ and $\langle S^{\circ2}+S^2,S\rangle_F>2\Theta_n$, equivalently a diagonal Weyl tensor with $\theta>\Theta_n$. A weaker falsifier suffices for the equality clause alone: a unit $S\in\mathcal D_n$ with $\theta=\Theta_n$ that is not in the $O(n)$-orbit of the balanced sphere product.

**Where I looked, and what I found.**

1. **The one place a step could run out of room.** Step 3's circle-replacement needs a coordinate untouched after three are moved. It fails at $n=3$ and only at $n=3$, which is outside the range. It also needs $\sigma>0$, which three distinct values guarantee, and needs the excluded set on the circle to be finite, which it is (at most fifteen points). **No falsifier.**
2. **The degenerate branch of Proof II.** $m_1=m_2=m_3$ makes $u=\mathbf1\times m=0$ and the stated mechanism vacuous. I built the witness $v=(\tfrac12,\tfrac12,-\tfrac12,-\tfrac12,0,0)$ at $n=6$ by hand and evaluated $\sum v^4=\tfrac14$ against Lemma A's $\tfrac3{2n}=\tfrac14$. **A defect in the block's paraphrase; no falsifier of the lemma**, since $\tfrac14>\tfrac16=\tfrac1n$.
3. **A normalisation at which the chain delivers a different constant.** $\mathop{\mathrm{tr}}S^2=1$ delivers $\Theta_n/\sqrt2$, the trap the block names, and the reason §9 exists. **Not a falsifier; a mis-citation risk, and the block has taken the repair.**
4. **A split beating the balanced one.** $\theta(S^p\times S^q)^2=\frac{2(n-1)}{n-2}\big(1-\frac{n-1}{pq}\big)$ is strictly increasing in $pq$, and $pq$ is strictly unimodal in the integer $p$. **No falsifier, and the exclusion is exact rather than measured.**
5. **A choice the proof makes that could be made differently.** When $\mu$ is a repeated eigenvalue, the proof picks one unit eigenvector $v$; every step holds for any choice, and the chain's bound is the same. **No falsifier.**
6. **The sign.** $P$ is odd, so $-S_*$ realises $-\Theta_n$. This is not a falsifier of the bound; it is what refutes the clause at :416.

**What I did not do.** No script was run, no search was performed, and no numerical screen was opened, the round is on the analysis-only footing and the theorem is a hand argument end to end. Every figure above is an exact rational or surd evaluation.

## Verdict

**PROVEN, hypotheses corrected.**

The theorem is proven as stated at [problem.md](../findings/problem.md):571–579, [results.md](../results.md):98 and [results.md](../results.md):268, at every $n\ge4$, at both parities, for every diagonal $W$ and not merely at critical points, with the equality case established in both halves. Every step reproduces exactly by hand and the chain delivers both constants with no slack. The odd case does rest on this theorem and on nothing published; the record's dependency claim is correct.

**Two corrections are owed and neither touches the statement:**

1. **[problem.md](../findings/problem.md):416**, delete "up to $\pm1\times S_n$"; the cubic is odd and the maximiser is the single sign the same sentence already names.
2. **[problem.md](../findings/problem.md):418**, "uniquely for $n\ge5$" becomes "uniquely at every $n\ge4$"; the exclusion belongs to $n=3$, which is outside the theorem.

**Two further repairs, smaller:**

3. **[problem.md](../findings/problem.md):340**, the Proof II paraphrase needs the case split its own source makes: *if $m$ is non-constant* the branch is a line; *if $3\mid n$ and $m$ is constant* the branch is a circle on which Lemma A makes $\sum v^4=\tfrac3{2n}$ constant, still above the two-value minimum for $n\ge4$.
4. **The block's map** names four headings and the argument lives under five; the bridge that reaches the statement's quantifier is under the fifth. **Add it to the map**, a reader following the map today cannot find the step that makes the statement a statement about every $W$.

**And one row outside this file:** [lean/INDEX.md](../lean/INDEX.md):359 buckets **L57** as needing the classification of compact symmetric spaces. It needs no such thing.
