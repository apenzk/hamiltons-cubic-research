# Review r650, Lemma L112, the doubly stochastic row calculus

**Reviewer B of an independent pair on identical briefs. Target: [Lemma L112](../findings/bounds.md), [findings/bounds.md](../findings/bounds.md) line 381. Analysis only throughout, no run of the linear programme the block reports, and no computation beyond hand arithmetic on objects constructed in this report.**

## Verdict

**REFUTED**, the lemma's own statement is true and I rebuilt it cold, but the two hedging clauses the brief singles out both fail: *"the complete pair-level content of the row calculus"* drops relation (C) entirely and collapses the pair structure, and *"neither was ever an independent result"* is contradicted by this record's own criticality-free derivation of the $\Pi$-bound two blocks above.

| claim | verdict |
| --- | --- |
| $\lambda$ is a $-\tfrac1{n-2}$-eigenvector of a symmetric hollow doubly stochastic matrix built from $S_{ab}=\sum_cT_{abc}$ | **CONFIRMED**, re-derived cold, with an independent closed-form check at $n=4$ |
| $S\lambda=-2\lambda$ is *"the complete pair-level content of the row calculus"* | **REFUTED**, (C) is absent from $S$ (the statement contains no $\theta$), and $T\mapsto S$ provably loses $S_{ab}\le n-2$ and [L31](../findings/stratum-two-negative.md)'s proved $S_{ab}\le2$ |
| [Lemma L73](../findings/bounds.md) is the one-index shadow | **CONFIRMED**, and strictly so, hand witness below |
| [L70](../findings/bounds.md) is the $\lambda_{\min}$ row of the system | **CONFIRMED** as an identity; the recorded L70 also consumes [L31](../findings/stratum-two-negative.md) and [L23](../findings/bounds-relaxations.md), which the system does not carry |
| the $\Pi$-bound is the $\lambda_{\max}$ row | **CONFIRMED** as a derivation; **REFUTED** as a claim about origin and about quantifier |
| *"neither was ever an independent result"* | **REFUTED** |
| $\max\theta\ge1.340542$ at $n=6$ is a floor, not the maximum | **CONFIRMED**, correctly labelled and correctly used |
| the $1.09\times$ overshoot and *"relation (B) closes two-thirds of the gap"* | **GAP**, both are computed from a figure the same sentence supersedes, and the second compares two floors |
| *"the pinned class does not close the conjecture"* | **CONFIRMED at $n=6$**, robust to either figure; the headline omits that the conjecture's regime is $n\ge12$ |

## 1. The unification claim, which is what the audit is for

### 1.1 The antecedent points at the wrong system

The sentence sits as the blockquote immediately after the $S$-matrix statement, and its *"one system"* therefore reads as the doubly stochastic system just constructed. **That system cannot yield either bound: $S\lambda=-2\lambda$ contains no $\theta$.** $\theta$ enters the row calculus only through (C), and (C) is exactly what the contraction $T\mapsto S$ discards. So on the reading the placement forces, the claim is false for a trivial reason.

Read instead as *"the full row system (A)+(B)+(C) at two rows"*, both derivations do go through, and I ran them cold.

### 1.2 [L70](../findings/bounds.md) at the $\lambda_{\min}$ row, it is the row, exactly

With $\mu_a$ the row measure $T_{a\bullet\bullet}/2(n-2)$ on ordered pairs, row $a$ of (C) is $\mathbb E_{\mu_a}[\lambda_b\lambda_c]=\lambda_a(\theta-\lambda_a)/(n-2)$. At $a=\arg\min$, $D(v)=\tfrac12\sum_{b,c}(\lambda_b\lambda_c-\lambda_{\min}\lambda_{\max})c_{vbc}^2=(n-2)\big(\mathbb E_{\mu_{\min}}[Y]-\lambda_{\min}\lambda_{\max}\big)$, so

$$\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D(v)}{\lvert\lambda_{\min}\rvert}=\lambda_{\min}+(n-2)\lambda_{\max}+\big(\theta-\lambda_{\min}\big)-(n-2)\lambda_{\max}=\theta .$$

**L70's boxed identity is row $\arg\min$ of (C) rewritten, with the substitution slack named.** The inequality is the pointwise step $Y\ge\lambda_{\min}\lambda_{\max}$, and it spends **(A) and (C) only**, (B) is never used on this side. That much of the unification is right, and sharper than the block states.

**What the system does not carry is the rest of L70.** The recorded L70 is an identity *plus* an equality classification: saturation forces $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$ via the pair cap [L31](../findings/stratum-two-negative.md) and the Killing marginal, and on [L23](../findings/bounds-relaxations.md)'s family reduces to *"$(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair"*. **None of that is a row of the pinned system**, it is Lie theory plus a lemma the system does not contain. So *"not a separate discovery"* holds of the bound and fails of the result the record files under L70.

### 1.3 The $\Pi$-bound at the $\lambda_{\max}$ row, the derivation is right and the credit claim is false

Verified line by line. $Y\le X^2$ is AM–GM; $(X-\lambda_{\min})(\lambda_{\max}-X)\ge0$ gives the chord $\mathbb E[X^2]\le(\lambda_{\min}+\lambda_{\max})\mathbb E[X]-\lambda_{\min}\lambda_{\max}$; feeding (B)'s $\mathbb E[X]=-\lambda_a/(n-2)$ and (C)'s $\mathbb E[Y]$ and putting $\lambda_{\max}=h$, $\lambda_{\min}=-m$ at $a=\arg\max$:

$$h\theta-h^2\ \le\ mh-h^2+(n-2)mh\ \Longrightarrow\ \theta\le(n-1)m .$$

The $h^2$ terms cancel as claimed and the division is by $h>0$. **CONFIRMED.**

**But the same file, two blocks above, derives this bound without (C) at all.** [Lemma L107](../findings/bounds.md)'s own quantifier paragraph gives the $g$-route: $g_k\ge0$ manifestly, $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$ from (A) and (B), so $-4\theta=\sum\lambda_kg_k\ge4(n-1)\lambda_{\min}$ at unit norm, which is $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ on all of $\mathcal W_n$. Three consequences:

- **The claim of no independent origin is false on the record's own page.** The $g$-route is a second derivation, recorded, and it is the one that fixes the bound's quantifier.
- **Reading the $\Pi$-bound as a row of the pinned system strictly weakens it**, from every $W\in\mathcal W_n$ to critical points, because (C) is a criticality statement. A unification that costs a standing result its quantifier is not an identification.
- **The two bounds are not parallel.** L70's bound has no route off criticality ($\theta$ enters it only through criticality at $v$) while the $\Pi$-bound does. *"One system read twice"* suggests a symmetry between them that does not exist.

### 1.4 Strictness, and the direction the record already knows

Both bounds are **strict consequences** of the system, not equivalents, and the block says so in the next sentence (*"the full system is strictly stronger, since it reads every row and both moments at once"*). I verified the supporting figure by reconstruction: at $\mathbb{CP}^3$, [r331](REVIEW_r331.md)'s scaled row $(-4,1,16)$ with multiplicities $(6,8,1)$ has full-system $\max\theta=20.0$ against true $20$, while L70 gives $-4+4\cdot16=60$; dividing by $\sqrt{360}$ these are $1.054093$ and $3.162$, so the slack is $2.108$. **The figure "slack by $2.1$" is correct but appears nowhere in [r331](REVIEW_r331.md)**, it is the record's own arithmetic on r331's table, and is attributed as if quoted.

### 1.5 Two reviewers already qualified this sentence and the block folded in neither

[r338](REVIEW_r338.md) line 30: the sentence *"is correct about which rows are read and wrong if it is taken to mean the family reproduces them"*. [r337](REVIEW_r337.md) quotes the sentence verbatim under the heading *"The positive half is NOT the $\Pi$-bound, the identification is refuted in both directions"*, with the balanced product and padded $W_{\mathbb{CP}^2}$ as the two-sided witnesses. **The L112 block carries the unqualified sentence while the [L107](../findings/bounds.md) block above it carries r337's hull blockquote and r338's step-2 retraction**, the file already holds the qualification and this block does not read it.

## 2. The doubly stochastic structure, derived cold

**Reading adopted.** $T_{abc}=c_{abc}^2$ with $c_{abc}=\langle[v_a,v_b],v_c\rangle$ for an orthonormal basis of $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$ normalised by $\mathop{\mathrm{tr}}(v^2)=-2$; sums over **ordered** tuples throughout, per [conventions.md](../findings/conventions.md); $\lambda\in\mathbb R^N$, $N=\binom n2$, the $\Lambda^2$ spectrum listed in that basis order.

- **Symmetric.** $c_{abc}$ is totally antisymmetric, so $T$ is totally symmetric, so $S_{ab}=\sum_cT_{abc}=S_{ba}$.
- **Non-negative.** $T=c^2\ge0$ entrywise.
- **Hollow.** $T$ vanishes whenever two indices coincide, so $S_{aa}=\sum_cT_{aac}=0$. This is the **matrix** sense of hollow for $S$ inherited from the **3-tensor** sense for $T$, both senses are tabled in [conventions.md](../findings/conventions.md) and the block uses each once without saying which.
- **The row sum, which is what makes it doubly stochastic.** $\sum_bS_{ab}=\sum_{b,c}c_{abc}^2=-\mathop{\mathrm{tr}}(\mathrm{ad}\,v_a)^2=-B(v_a,v_a)=-(n-2)\mathop{\mathrm{tr}}(v_a^2)=2(n-2)$. **This is the Killing row marginal, and the brief is right that it carries no result number**: [conventions.md](../findings/conventions.md) files it as a standing fact beside the pair cap, which is [L31](../findings/stratum-two-negative.md); [INDEX-results.md](../findings/INDEX-results.md) has no row for it. It is load-bearing here and in [L70](../findings/bounds.md), [L73](../findings/bounds.md) and [L107](../findings/bounds.md), and it should be numbered.

Symmetry makes column sums equal row sums, so $P:=S/2(n-2)$ is doubly stochastic.

**The eigenvalue.** Relation (B) is Böhm–Wilking Lemma 2.1's $W\# I=-W$, quoted at [bounds.md](../findings/bounds.md) line 239. In an orthonormal **eigenframe** of $W$ its diagonal reads $\tfrac12\sum_{b,c}T_{abc}\tfrac{\lambda_b+\lambda_c}2\cdot2=\tfrac12(S\lambda)_a=-\lambda_a$, using total symmetry of $T$ in $b,c$ to fold $\tfrac{\lambda_b+\lambda_c}2$ onto $\lambda_b$. Hence

$$S\lambda=-2\lambda,\qquad P\lambda=-\frac{\lambda}{n-2}.$$

**CONFIRMED.**

**Which of the pair cap and the marginal supplies $-\tfrac1{n-2}$, the brief's question.** The **marginal**, and only the marginal. $S\lambda=-2\lambda$ has no $n$ in it; the whole of the $n$-dependence is the normalisation $2(n-2)$. **[L31](../findings/stratum-two-negative.md)'s pair cap $S_{ab}\le2$ is never used**, it is an additional, proved, entrywise constraint $P_{ab}\le\tfrac1{n-2}$ that the lemma states nothing about, which matters in §4.

**The sign is not merely expected, it is forced.** $P$ is non-negative doubly stochastic, so its Perron value is $1$ on $\mathbf1$ and its spectrum lies in $[-1,1]$; $-\tfrac1{n-2}\in(-1,1)$ for $n\ge4$. Since $P$ is symmetric and $-\tfrac1{n-2}\ne1$, **$\lambda\perp\mathbf1$ automatically: trace-freeness is a consequence of the lemma, not a hypothesis of it.** Directly: $\mathbf1^{\mathsf T}S\lambda=2(n-2)\sum\lambda=-2\sum\lambda$ forces $\sum\lambda=0$.

**Hypotheses, stated.** (i) $W\in\mathcal W_n$, Ricci-flat with first Bianchi, which is all (B) needs; (ii) $T$ computed in an **orthonormal eigenframe of $W$ on $\Lambda^2$**, this is unstated in the block and is genuinely needed, since $(W\#I)_{aa}$ picks up off-diagonal entries of $W$ otherwise; (iii) the Killing normalisation $\mathop{\mathrm{tr}}(v^2)=-2$. **Not needed: criticality, unit norm** (both sides of $S\lambda=-2\lambda$ are homogeneous of degree one in $\lambda$), **trace-freeness** (implied), **$\theta>0$, $n\ge5$.** The brief's warning about a neighbouring identity holding more generally than its heading claimed applies in the opposite direction here: the heading is correctly silent on criticality, and the block's own §(A)/(B)/(C) split at [L73](../findings/bounds.md) states the reason.

**An independent closed-form check at $n=4$, no computation.** $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ with $\Lambda^2=\Lambda^+\oplus\Lambda^-$; brackets vanish across factors, and inside a factor $[e_i,e_j]=c\,\epsilon_{ijk}e_k$, so $S_{ij}=c^2$ for $i\ne j$ within a factor. The row sum $2c^2=2(n-2)=4$ forces $c^2=2$, which saturates [L31](../findings/stratum-two-negative.md)'s cap, as it must in $\mathfrak{so}(4)$. Then $S\rvert_{\Lambda^\pm}=2(J_3-I_3)$, with eigenvalues $4$ on $\mathbf1$ and $-2$ on $\mathbf1^\perp$. A Weyl tensor in dimension $4$ is trace-free on **each** of $\Lambda^\pm$ separately, so $\lambda\rvert_{\Lambda^\pm}\perp\mathbf1$ and $S\lambda=-2\lambda$ exactly, i.e. eigenvalue $-\tfrac1{n-2}=-\tfrac12$ for $P$. **The lemma reproduces itself in closed form at the one dimension where everything is computable.**

## 3. *"Lemma L73 is the one-index shadow"*, true, and strictly

*"Shadow"* is undefined on the record. The precise statement that holds: **row $a$ of $P\lambda=-\tfrac{\lambda}{n-2}$ says $-\tfrac{\lambda_a}{n-2}$ is a convex combination of $\{\lambda_b\}$**, since $P_{ab}\ge0$ and $\sum_bP_{ab}=1$. Hence $\lambda_{\min}\le-\tfrac{\lambda_a}{n-2}\le\lambda_{\max}$, which is $-(n-2)\lambda_{\max}\le\lambda_a\le(n-2)\lvert\lambda_{\min}\rvert$, **[L73](../findings/bounds.md)'s boxed statement, character for character.** So the shadow relation is: replace the pinned convex combination by its range, one row at a time. The subset-sum family the block calls *"immediate"* is indeed immediate, for $A$ an index set, $w_b=\sum_{a\in A}P_{ab}$ has $w_b\in[0,1]$ and $\sum_bw_b=\lvert A\rvert$, so $-\tfrac1{n-2}\sum_{a\in A}\lambda_a$ lies between the sums of the $\lvert A\rvert$ smallest and the $\lvert A\rvert$ largest eigenvalues. [L73](../findings/bounds.md) is $\lvert A\rvert=1$, which is also why the [L73](../findings/bounds.md) block's alternative phrase *"the $k=1$ majorization shadow"* names the same relation.

**Strictness, with a hand witness, the record asserts it and never exhibits one.** At $n=6$, $N=15$, $\epsilon=\tfrac14$, take

$$\lambda=\Big(1,\ 1,\ -\tfrac14,\ \underbrace{-\tfrac{1.75}{12},\dots,-\tfrac{1.75}{12}}_{12}\Big),\qquad \textstyle\sum\lambda=2-\tfrac14-1.75=0 .$$

It satisfies [L73](../findings/bounds.md), $\lambda_{\max}=1=(n-2)\lvert\lambda_{\min}\rvert$, at equality, and $\lvert\lambda_{\min}\rvert=\tfrac14\le4$. It **violates** L112: the $\lvert A\rvert=2$ subset sum over the two maximal indices requires $-\tfrac14\cdot2=-0.5\ge\lambda_{(1)}+\lambda_{(2)}=-0.25-0.145833=-0.395833$, which is false by $0.104$. **So no symmetric hollow doubly stochastic $P$ has this $\lambda$ as a $-\tfrac14$-eigenvector, and L112 is strictly stronger than the boxed L73 on trace-free spectra.** The general condition behind the witness is $\epsilon(N-2)>2$, i.e. $\binom n2>2n-2$, true at every $n\ge6$. *(This witness is also caught by the strengthened one-index form recorded in the [L73](../findings/bounds.md) block, so it separates L112 from the boxed L73, not from the record's strongest single-row statement, which is exactly the point of §4.)*

## 4. *"The complete pair-level content of the row calculus"*, refuted twice over

**First, the quotation drifts.** [r338](REVIEW_r338.md) wrote *"the complete content of **(A)+(B)** at the pair level"*. The block records it as *"the complete pair-level content of **the row calculus**"*. The row calculus is (A)+(B)+(C); (C) is not in $S$ at all. **The rewrite converts a defensible claim about two relations into a false claim about three**, and it is the same rewrite that lets the next blockquote name L70 and the $\Pi$-bound as readings of this object.

**Second, and independent of the wording, $T\mapsto S$ is not injective on content.** Contracting $c$ out of $T_{abc}$ discards the constraint that the row-$a$ mass sits on **pairs of distinct** indices. Two things are provably lost:

- **$S_{ab}\le n-2$, i.e. $P_{ab}\le\tfrac12$.** The ordered pairs $(b,c)_{c}$ and $(c,b)_c$ are disjoint families inside row $a$ (they meet only at $(b,b)$, where $T=0$), and each carries total mass $S_{ab}$ by symmetry, so $2S_{ab}\le2(n-2)$. Nothing in *"symmetric, hollow, doubly stochastic"* forbids $P_{ab}=1$.
- **[L31](../findings/stratum-two-negative.md)'s proved cap $S_{ab}=\lVert[v_a,v_b]\rVert^2\le2$, i.e. $P_{ab}\le\tfrac1{n-2}$**, far stronger again for $n\ge5$, and a numbered lemma this record already owns.

**The cost is visible in the record's own strengthening of L73.** The $T$-level row bound reads $-2\lambda_a=\sum_{b,c}T_{abc}\lambda_b=\tfrac12\sum_{b,c}T_{abc}(\lambda_b+\lambda_c)$ with $b\ne c$, giving $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$ over the two smallest eigenvalues excluding $\arg\max$, the strengthening stated in the [L73](../findings/bounds.md) block and confirmed by [r338](REVIEW_r338.md)'s Objection 1. **The $S$-level statement yields only $\lambda_{\max}\le-(n-2)\lambda_{(1)}$**, since its extremal row concentrates on a single column. So the stated lemma does not reach the strongest one-index consequence the same file already carries. *"Complete"* is true only in the trivial sense that (A) and (B) are literally the two displayed $S$-equations; it is false in the sense a reader will take, namely that nothing else about $T$ constrains $\lambda$.

**What is owed, and it is reachable.** Replace *"the complete pair-level content of the row calculus"* by *"(A) and (B) are exactly the two $S$-statements"*, and record the two dropped constraints as part of the class: $P$ symmetric, hollow, doubly stochastic, **with $P_{ab}\le\tfrac1{n-2}$ by [L31](../findings/stratum-two-negative.md)**, and $P\lambda=-\tfrac{\lambda}{n-2}$. **Whether the dropped constraints shrink the admissible set of spectra is an LP question I am not authorised to open**, the run would maximise or minimise a violated one-index functional over $\{P\ \text{sym.\ hollow d.s.},\ P\lambda=-\epsilon\lambda\}$ with and without $P_{ab}\le\tfrac1{n-2}$ at $n=6$. **A gap means the record's own L73 strengthening is not a consequence of L112 and the two must be recorded side by side; no gap means the cap is spectrally inert and L112 may be quoted as the complete spectral consequence of (A)+(B)+(L31).** Either way the class statement as written is wrong, and that part needs no run.

## 5. The linear-programme figures

**Floor versus maximum, the block gets the hard part right.** The program is (A)+(B)+(C) with $T\ge0$ and the spectrum **free**, so it is bilinear in $(T,\lambda)$ rather than an LP; a numerical maximiser returns a feasible point, hence a **lower** bound on the relaxation's optimum. The block labels $1.340542$ *"a floor, not the maximum"* and writes $\max\theta\ge$, which is correct, and it is exactly the direction the conclusion needs: $1.340542\le\max_{\text{class}}\theta$ together with $\max_{\mathcal W_6}\theta=\sqrt{3/2}=1.224745$ gives $\max_{\text{class}}>\max_{\mathcal W_6}$, so the class is strictly larger than the realizable set. **CONFIRMED, and the labelling is literal.**

**The derived ratios are not.** The same sentence reports [r335](REVIEW_r335.md)'s $1.392879$ *"in eight restarts and still climbing"*, verified verbatim in [r335](REVIEW_r335.md), and then states the overshoot as $1.09\times$, which is $1.340542/1.224745$, the ratio of the **superseded** figure. With r335's floor it is $1.14\times$. Worse:

- *"Relation (B) closes two-thirds of the gap"* compares $1.09\times$ against (A)+(C)'s $1.30\times$: excess $0.368\to0.116$, i.e. $68\%$. With $1.392879$ the same arithmetic gives $54\%$. **And both endpoints are floors**, so the comparison bounds nothing: the true (A)+(B)+(C) optimum is only known to be $\ge1.392879$, and the (A)+(C) figure is a floor for a *larger* feasible set. The honest statement is that adding (B) lowered the *reported* floor, which is a statement about two searches.
- The conclusion *"the pinned class does not close the conjecture"* is untouched by all of this: it needs only some feasible $\theta$ above the realizable maximum, and survives any figure exceeding $\sqrt{3/2}=1.224745$, a fortiori any figure exceeding $\Theta_6=\theta_0(6)=1.054093$. **Robust to both numbers and to the next restart.**
- **The headline drops a rider the block itself supplies further down**: the conjecture is stated for $n\ge12$, and at $n=6$ even the truth exceeds $\theta_0(6)$. The demonstration is *"the pinned class does not close the conjecture at $n=6$"*.
- One dependency worth flagging: every ratio divides by $\sqrt{3/2}$ as *"the true maximum"* at $n=6$. [conventions.md](../findings/conventions.md) records $M(n)\ge\sqrt{3/2}$ as proved from padded $W_{\mathbb{CP}^2}$ and $M=\sqrt{3/2}$ at $n=4,6$ as a fact; the block inherits whatever standing that equality has, and the overshoot conclusion needs only the $\ge$ direction on the realizable side, which is the safe half.

**Which parts are Lemma and which are Observation.** By the record's own labels: the $S$-construction, the eigenvalue, the shadow relation and the subset-sum family are **Lemma**-grade and proved. The T9 figures ($1.340542$, $1.392879$, $1.30\times$, $1.31\times$), the generic-critical-point gaps ($0.054718$ against $0.284314$; $0.091388$ against $0.320131$), [r332](REVIEW_r332.md)'s interval widths and [r336](REVIEW_r336.md)'s $3.1\times10^{-29}$ realization fit are **Observations at $n=6$**. **The block files all of them under a `Lemma` heading**, and [INDEX-results.md](../findings/INDEX-results.md) row 112 carries only the lemma sentence, so the measurements are indexed nowhere. They belong in a separate Observation, or at minimum behind a stated dimension.

## 6. Conventions, symbols, provenance, pointers

**$S_{ab}$ against $S_{XYZ}$, a collision, and the sharpest instance is inside this block.** [conventions.md](../findings/conventions.md) fixes $S_{XYZ}$ as the block-restricted ordered-slot contraction of the same tensor $T$; L112's $S_{ab}$ is $\sum_cT_{abc}$ with $a,b$ single indices. They are distinguishable by arity, and both are ordered-slot readings, so **no numerical conflict arises**, but the record now carries at least four subscripted senses of $S$ over the same $T$: $S_{XYZ}$ (block labels), $S_{ab}$ (index pair), $S_{22}$ (exponent pattern, [r331](REVIEW_r331.md)/[r332](REVIEW_r332.md)), and $S(W)$ the gradedness slack. **$S_{ab}$ and $S_{22}$ appear fourteen lines apart inside the L112 block itself**, where $S_{22}$ under the block's own new definition would read $\sum_cT_{22c}$. That is the same class of defect as the tabled $B$, $M$, $\mu$ and $\Pi$ collisions, and $S_{ab}$ is not in [conventions.md](../findings/conventions.md) at all. The block also uses *hollow* in both tabled senses (3-tensor for $T$, matrix for $S$), without naming either.

**Provenance, checked against the reviews and against `git`.**

| attribution in the block | verdict |
| --- | --- |
| [r338](REVIEW_r338.md) U2 constructs $S_{ab}$ and refutes *"the whole of"* | **accurate**, and U2 is where it is; the wording drift is in §4 above |
| [r335](REVIEW_r335.md) reaching $1.392879$ in eight restarts, still climbing | **accurate**, verbatim in r335's S3 and its closing recommendation |
| [r334](REVIEW_r334.md) screening $S^3\times S^3$, interval $[0.17568,1.054093]$, width $0.878$, record's own $0.176$ its lower end | **accurate**, r334 R4 and §1.3 |
| [r334](REVIEW_r334.md) supplying the missing fourth outcome | **accurate** |
| [r336](REVIEW_r336.md) S3, the optimal spectrum realizable at fit $3.1\times10^{-29}$ and not critical | **accurate**, r336 §S3 |
| [r336](REVIEW_r336.md)'s twenty generic points containing $0.230284$ and $0.231181$ | **accurate** |
| the Nelder–Mead trap, $2.77$ at $n=6$ against $\mathbb{CP}^3$'s exactly $4$ | **accurate**, r336 reports $2.43,2.77,3.12,3.17$ at $n=5\ldots8$, and $n-2=4$ at $n=6$ |
| [r332](REVIEW_r332.md)'s $S_{22}$ intervals of width $0.08$–$0.12$, true value interior | **substantially accurate**, r332's three Newton rows are $0.125$, $0.080$, $0.096$, so the upper end is $0.125$ |
| [r331](REVIEW_r331.md)'s screen returns the true $\theta$ *"where Lemma L70 alone is slack by $2.1$"* | **the screen is r331's; the figure is not.** $2.1$ appears nowhere in r331. It is reconstructible from r331's $\mathbb{CP}^3$ row plus this file's own $3.162$ against $1.054$, as §1.4 shows, but it is presented as quoted |
| [LIT-spectra](LIT-spectra.md), Payne §6.4 and Thm 13, Nikolayevsky Thm 3, Hashimoto Thm 1.2 | **the files exist and the citations are in the reviews as described**; I did not re-audit the source papers, which is outside this brief |

No attribution here credits a reviewer who audited something else, the failure mode the brief warns about does not appear in this block. **[INDEX-results.md](../findings/INDEX-results.md) row 112 reads *"Gate 2: no verdict on the record"*, so this pair is L112's first audit**, which matches the brief.

**Pointers.** The anchors the L112 block itself uses to [L70](../findings/bounds.md) resolve, `#lemma-l70--the-deficiency-identity-and-what-saturates-it` matches the live heading under GitHub's slug rule, as does `#lemma-l112--...`, the anchor by which the [L73](../findings/bounds.md) block points back at it. **Three same-file anchors in [bounds.md](../findings/bounds.md) are dead, and one of them is inside the L112 block:**

- **`#lemma-l104--the-value-type-reduction`, used in the L112 block's own T9 paragraph, [Lemma L104](../findings/bounds-relaxations.md) lives in [bounds-relaxations.md](../findings/bounds-relaxations.md), not here.** The *next sentence* links the same lemma correctly as a cross-file link, so the paragraph gets it both ways.
- `#lemma-l107--the-pi-bound-thetale-n-1lvertlambda_minrvert-derived-twice` and `#lemma-l107--the-pi-bound-thetalen-1lvertlambda_minrvert-derived-twice`, both stale against the current heading, which no longer ends *"derived twice"*. The live anchor is `#lemma-l107--the-pi-bound-thetalen-1lvertlambda_minrvert`, which the L70 block does use correctly, so the file carries three spellings of one anchor, two of them broken.
- One empty `](#)` target elsewhere in the file.

## 7. What is owed

1. **Rewrite the completeness sentence.** *"(A) and (B) are exactly the two $S$-statements"*, with $P_{ab}\le\tfrac1{n-2}$ from [L31](../findings/stratum-two-negative.md) carried in the class, and (C) named as absent.
2. **Qualify the unification blockquote** with what §1 establishes: the derivations are readings of (A)+(B)+(C) at two rows, **not** of the doubly stochastic system the blockquote follows; L70's bound spends (A)+(C) and the $\Pi$-bound spends (A)+(B)+(C); the $\Pi$-bound has an independent, stronger-quantifier $g$-route on the record, so *"neither was ever an independent result"* must go; and L70's equality classification consumes [L31](../findings/stratum-two-negative.md) and [L23](../findings/bounds-relaxations.md), which the system does not carry. [r337](REVIEW_r337.md) and [r338](REVIEW_r338.md) both flagged this sentence already.
3. **Number the Killing row marginal $2(n-2)$.** It is the hypothesis that makes L112 doubly stochastic and it carries [L70](../findings/bounds.md), [L73](../findings/bounds.md) and [L107](../findings/bounds.md) besides.
4. **State the eigenframe hypothesis** in the lemma line, and add $S_{ab}$ to [conventions.md](../findings/conventions.md)'s table of overloaded letters.
5. **Split the T9 measurements out of the Lemma**, drop or recompute the $1.09\times$ and *"two-thirds"* figures, and put the $n=6$ rider on the headline.
6. **Fix the three dead anchors**, starting with the L104 one inside this block.
7. **Blocked on approval:** the LP deciding whether $P_{ab}\le\tfrac1{n-2}$ cuts the admissible spectra, per §4.

*Screening allowance used: none. Every number above is hand arithmetic on objects constructed in this report, or a value read from the record and re-derived.*
