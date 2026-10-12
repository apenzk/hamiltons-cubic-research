# REVIEW r536, Lemma L127

**Target:** Lemma L127, "the block-level refinement of [Lemma L27](../findings/nondegeneracy.md): which block each $\tfrac12$ comes from", in [findings/second-order.md](../findings/second-order.md) at the `#### Lemma L127` heading (line 732) down to the next heading (line 755).

**Reviewer:** r536, independent adversarial auditor, cold. **Analysis-only footing**: no searches, sweeps, censuses, optimisations or falsifier hunts were run. Two screens are reported below, seconds of compute, on objects I constructed for the purpose, on claims I was about to record. They are reported as screens and are never the evidence for a positive claim; every positive claim here is carried by the hand derivation that precedes it.

**VERDICT: CONFIRMED** at the scope L127 inherits from its own title ($p,q\ge3$, $n=p+q$), with four repairs owed, one of them a row that is false as literally written at $p=2$, where the table declares no scope.

## What I did

Fixed conventions independently before reading anything downstream, then derived every row of the table from the definitions, then cross-checked the whole against [Lemma L27](../findings/nondegeneracy.md)'s ten values with multiplicity.

**Conventions pinned, from the anchors and not from the record's prose.** Sectional matrix $\alpha$ within $F_1$, $\beta$ within $F_2$, $\gamma$ across; Ricci-flatness $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$; unit norm in the ordered sense $\lVert K\rVert_F^2=2$ of [conventions.md](../findings/conventions.md) gives $\gamma^2=\dfrac{2(p-1)(q-1)}{pq(n-1)(n-2)}$ and hence $\theta=(n-1)\lvert\gamma\rvert=\sqrt{\dfrac{2(n-1)(p-1)(q-1)}{pq(n-2)}}$. **That reproduces $\theta_0(6)=\sqrt{10}/3$ at $(3,3)$ and $\theta_0(n)^2=2(n-1)(n-2)/n^2$ at $p=q=n/2$.** Separately, $\operatorname{tr}W^\#=\sum_{a<b}\sum_c M_{ac}M_{bc}=\tfrac12\sum_c\big[(\sum_aM_{ac})^2-\sum_aM_{ac}^2\big]=-\tfrac12\lVert K\rVert_F^2=-1$, the record's anchor. I am in the record's normalisation.

The polarised operator I worked in: for diagonal $M,X$, $(L_MX)_{ab}=M_{ab}X_{ab}+\tfrac12\sum_{c\ne a,b}(M_{ac}X_{bc}+M_{bc}X_{ac})$, whose fixed vector at $X=M$ is exactly criticality $M_{ab}^2+\sum_cM_{ac}M_{bc}=\theta M_{ab}$, i.e. $L_ee=e$.

## Findings, in the order of the brief's questions

### Q1, the $\mathcal D_n$ row and the cut by $\langle M\rangle$: the row reports the **uncut** block, and the "no" is correct anyway, because the column asks $=\tfrac12$

The row reads

> `| $\mathcal D_n$ | $1$ | $\sigma(L_e|_{\mathcal D_n})=\{1,\ \lambda_p^{\,p-1},\ \lambda_q^{\,q-1},\ (-\mu)^{(p-1)(q-1)},\ 0^{\text{rest}}\}$, from [Lemma L27](nondegeneracy.md)'s summands | no |`

**It reports the block *before* the cut**, the printed spectrum contains the $1$, which is $L_ee=e$ and nothing else. **The fourth column's "no" is nonetheless correct without the cut**, because none of $1,\lambda_p,\lambda_q,-\mu,0$ *equals* $\tfrac12$ for $p,q\ge3$ with $(p,q)\ne(3,3)$. So L127 neither inherits [L120](../findings/second-order.md)'s omitted clause nor handles it: it sidesteps it by asking a different question.

**But the row is internally inconsistent about which object it describes**, and the column header is where it shows: the header says "top $L_e$-eigenvalue", the cell's top is $1$, and the next cell says "reaches $\tfrac12$? no". A reader who parses "reaches" as $\ge$, the reading [Lemma L24](../findings/second-order.md) would want, gets a contradiction from the row's own two cells. **Repair owed**: one clause, either `$\mathcal D_n\cap W^\perp$` in column 1 or "no, once $\langle e\rangle$ is cut" in column 4.

*Every consumer already supplies the cut itself and none is misled*: [Corollary L128.1](../findings/second-order.md) writes "$\mathcal D_n\cap W^\perp$ carries $\{\lambda_p,\lambda_q,-\mu,0\}$"; the Step 3 list at line 900 writes "$\mathcal D_n\cap(W^*)^\perp$"; [ATTEMPTS.md](../ATTEMPTS.md) line 3978 reads the row as saying "only that $\tfrac12$ is *not attained* there". So the defect is confined to L127's own presentation.

### Q2, the block tops and multiplicities reproduce L27's ten values **exactly**, and the check is strong

This is the substance of the audit and it passes. I derived each block from the definitions and then subtracted from L27's list.

**Four-set row, derived.** On a $(2,2)$-split $\{i,j\}\subset F_1$, $\{k,l\}\subset F_2$: $A=\alpha+\beta$, $B=C=2\gamma$, so [L121](../findings/second-order.md)'s $\Sigma=(A-B)^2$ and the block value is $\tfrac12\lvert\alpha+\beta-2\gamma\rvert$. Ricci-flatness gives $\alpha+\beta-2\gamma=-\gamma\dfrac{(n-1)(n-2)}{(p-1)(q-1)}$ (the bracket $\tfrac q{p-1}+\tfrac p{q-1}+2$ collapsing to $\dfrac{(n-1)(n-2)}{(p-1)(q-1)}$) so dividing by $\theta=(n-1)\lvert\gamma\rvert$ gives **exactly $\mu_{p,q}=\dfrac{n-2}{2(p-1)(q-1)}$**. And "$0$ otherwise" holds at $n=p+q$: the $(4,0)$, $(0,4)$, $(3,1)$ and $(1,3)$ four-sets all have $A=B=C$, hence $\Sigma=0$. Confirmed.

**Cross-factor row, derived line by line, and L127's own proof is right in every step.** With $j\in F_1$, $k\in F_2$: the $\Delta^{(jk)}$ eigenvalue on vectors sum-zero within $F_1\setminus j$ is $(p-1)\alpha+(q-1)\gamma=-\gamma$ by Ricci, so the block value is $-\tfrac12(-\gamma)-\tfrac12\gamma=0$, multiplicity $p-2$; symmetrically $q-2$; and on the two-part-constant sum-zero vector $\Delta^{(jk)}$ has eigenvalue $(n-2)\gamma$, so the block value is $-\tfrac12(n-1)\gamma=\theta/2$. Multiplicities $(p-2)+(q-2)+1=n-3$. Confirmed, including the identification of the third type with the orbit direction: $x_i=M_{ki}-M_{ji}$ is $\gamma-\alpha$ on $F_1\setminus j$ and $\beta-\gamma$ on $F_2\setminus k$, and $(p-1)(\gamma-\alpha)+(q-1)(\beta-\gamma)=0$ identically by the two Ricci relations, so it is exactly that vector.

**Within-factor row, derived, and I had to compute the block's whole spectrum, which the table does not give.** For $\{j,k\}\subset F_1$ the block splits into three types: sum-zero on $F_1\setminus\{j,k\}$ gives $0$ with multiplicity $p-3$; sum-zero on $F_2$ gives $\tfrac12(2\gamma-\alpha-\beta)=-\mu\theta$ with multiplicity $q-1$; and the two-part-constant sum-zero vector gives $\tfrac12(p-2)(\alpha-\gamma)=\lambda_p\theta$, checked to agree on both index sets. So

$$\sigma\big(L_e|_{V_{jk}}\big)=\{\lambda_p\ \text{simple},\ (-\mu)^{q-1},\ 0^{p-3}\},\qquad \lambda_p=\tfrac{p-2}{2(p-1)},$$

whose top is $\lambda_p$ for $p\ge3$. The table's stated value is right; the $-\mu$'s it does not print are what makes the cross-check close.

**The cross-check.** Take L27's ten values with multiplicity and subtract everything outside $\mathcal D_n$:

| value | L27 total | four-set | cross-factor pair | within-factor pair | **residue = $\mathcal D_n$** | L127's row |
|---|---|---|---|---|---|---|
| $1$ | $1$ | (|), |, | $1$ | $1$ ✓ |
| $\tfrac12$ | $pq$ | (| $pq$ |), | $0$ | absent ✓ |
| $\lambda_p$ | $\tfrac{(p-1)(p+2)}2$ | (|), | $\binom p2$ | $p-1$ | $\lambda_p^{\,p-1}$ ✓ |
| $\lambda_q$ | $\tfrac{(q-1)(q+2)}2$ | (|), | $\binom q2$ | $q-1$ | $\lambda_q^{\,q-1}$ ✓ |
| $+\mu$ | $\binom p2\binom q2$ | $\binom p2\binom q2$ | (|), | $0$ | absent ✓ |
| $-\mu$ | $\tfrac{(p-1)(p+2)(q-1)(q+2)}4$ | $\binom p2\binom q2$ |, | $\binom p2(q-1)+\binom q2(p-1)=\tfrac{n(p-1)(q-1)}2$ | $(p-1)(q-1)$ | $(-\mu)^{(p-1)(q-1)}$ ✓ |
| $0$ | rest | rest | $pq(n-4)$ | $\binom p2(p-3)+\binom q2(q-3)$ | rest | $0^{\text{rest}}$ ✓ |

The $-\mu$ line is the one that could have failed and does not: $(p-1)(q-1)\big[\tfrac{pq}4+1+\tfrac n2\big]=(p-1)(q-1)\tfrac{(p+2)(q+2)}4$ identically. **So L127's $\mathcal D_n$ row is not merely consistent with L27, it is *forced* by L27 together with the other three rows**, which is a stronger statement than "from L27's summands" suggests and is worth saying in the block.

**A second, independent check on the same table.** $\operatorname{tr}_{\mathcal W_n}L_e=0$ unconditionally ([L27](../findings/nondegeneracy.md)). Summing L127's table: $1+\tfrac{pq}2+\tfrac{p^2-4}4+\tfrac{q^2-4}4-\tfrac{n^2-4}4=0$ identically in $p,q$. ✓

**And the $(3,3)$ arithmetic in the block's closing "Agreement" line checks.** Nine cross-factor blocks each carrying one $\tfrac12$, plus nine $(2,2)$-split four-set blocks each carrying $+\mu=\tfrac12$, is $18=\dim E(\tfrac12)$; nothing else reaches it, since the within-factor blocks are $\{\tfrac14,-\tfrac12,-\tfrac12\}$ and $\mathcal D_6$ is $\{1,\tfrac14^4,(-\tfrac12)^4\}$. Six within-factor blocks among $\binom62=15$. ✓ Block dimensions total $15\cdot2+15\cdot3+9=84=\dim\mathcal W_6$. ✓

**Screen** (reported as a screen): building $L_M$ on $\mathcal D_n$ from the polarised formula above and diagonalising in the Gram metric returns, at $(3,3),(3,4),(3,5),(4,4)$, exactly $\{1,\lambda_p^{p-1},\lambda_q^{q-1},(-\mu)^{(p-1)(q-1)},0^{\text{rest}}\}$ and $\theta(3,3)=1.054093=\sqrt{10}/3$; building the pair blocks from [L122](../findings/second-order.md)'s bracketed form returns $\{\lambda_p,(-\mu)^{q-1},0^{p-3}\}$ and $\{\tfrac12,0^{n-4}\}$ at $(2,4),(2,6),(3,3),(3,5),(4,4),(5,3)$. Corroboration of the derivation above, not its evidence.

### Q3, the premise is false: L127's pair rows state facts about the blocks and use none of L122's inequality

Both pair rows are **facts about the block itself**, not bounds on it. The cross-factor row states an exact spectrum; the within-factor row states a top eigenvalue. **Neither uses [L122](../findings/second-order.md)'s $\lambda_{\min}(\Delta^{(jk)}|_{\mathbf1^\perp})\ge-(\theta+M_{jk})$**, which is the clause that needs a maximiser, L127 uses only L122's bracketed/Laplacian *form* (diagonality plus Ricci-flatness) and its orbit-eigenvector consequence (criticality). **So no maximiser hypothesis is owed here, and nothing of L122's repaired scope leaks in.** L127's own proof text confirms it: it invokes "L122's Laplacian", the two Ricci relations, and nothing else.

*Which is the right answer for the lemma's purpose.* L127 is used at $S^p\times S^q$, which is critical and generally **not** a maximiser, [L126](../findings/second-order.md)'s own box says "no $S^2\times S^q$ is a local maximum", so a maximiser hypothesis here would have made the lemma inapplicable to half its consumers.

### Q4, the column asks $=\tfrac12$, every row is answered under that reading, and the reading is nowhere stated

**The reading is forced by the four-set row.** "only at $(3,3)$ ([Lemma L126](../findings/second-order.md))" is L126's $\mu_{p,q}=\tfrac12\iff(p,q)=(3,3)$, an *equality*. Under $\ge\tfrac12$ the cell would be false at every $p=2$, where $\mu_{2,q}=\tfrac q{2(q-1)}>\tfrac12$, the very fact L126 prints two paragraphs above.

Checked row by row under $=\tfrac12$: four-set "only at $(3,3)$" ✓; cross-factor "yes, along the orbit" ✓; within-factor "no" ✓ ($\lambda_m<\tfrac12$, $-\mu<0$); $\mathcal D_n$ "no" ✓. **Uniform, and correct.**

**The record already distinguishes the two readings and says so elsewhere, which makes the silence here the defect rather than the reading.** [L128](../findings/second-order.md)(ii) is stated as "$\tfrac12$ is NOT an $L_e$-eigenvalue", with its box,

> **THE INEQUALITIES IN (ii) ARE EXCLUSIONS OF $\tfrac12$, NOT STRICT BOUNDS, AND THE DIFFERENCE HAS A WITNESS ON THE RECORD.**

and the Step 3 passage at line 900 says a citation "delivers '$\tfrac12$ is not an eigenvalue' rather than 'spectrum $\le\tfrac12$' … with $\mu_{2,4}=\tfrac23$ as its witness". **Repair owed**: the column head should read "$=\tfrac12$?" or carry the one-clause gloss, since the English word "reaches" reads as $\ge$ and the record's own $\mu_{2,4}=\tfrac23$ is the witness that the two differ.

### Q5, no residual priority claim, in the block or in any citation

The block's provenance line is a **withdrawal**, correctly worded:

> ***The first version claimed to prove sphere-product nondegeneracy for all $p,q$ and all $n$ as new. [Lemma L27](nondegeneracy.md) already does, and this refinement leans on L27's summand list for its own $\mathcal D_n$ row, so it is a refinement and not a replacement.***

and the closing box repeats it: "*Does not*: establish nondegeneracy independently, since the $\mathcal D_n$ row is L27's." Every citation is clean: [LEDGER.md](../findings/LEDGER.md) line 170 records "L127's novelty claim … withdrawn"; [INDEX-results.md](../findings/INDEX-results.md) line 145 states only the cross-factor content; [second-order.md](../findings/second-order.md) line 787 *limits* L127 ("has the block table only at sphere products") in order to credit L128; [plan.md](../plan.md) line 51 cites it only to say I3 does not borrow it. **Nothing claims priority.**

*One wording snag, minor.* "[Lemma L27] already does" attaches to a sentence whose subject is nondegeneracy "for all $p,q$ and all $n$", and L27 is scoped $p,q\ge3$ with $(p,q)\ne(3,3)$, it is L126 that covers the rest. Read strictly the sentence over-credits L27; read as "already proves sphere-product nondegeneracy" it is fine. Worth one clause.

### Q6, what the eight citations take

| citation | takes |
|---|---|
| [ATTEMPTS.md](../ATTEMPTS.md) line 3972 | the whole table, "L127 for the full block table" |
| [ATTEMPTS.md](../ATTEMPTS.md) line 3978 | the $\mathcal D_n$ **row**, read correctly as "$\tfrac12$ is *not attained*" rather than "$\le\tfrac12$" |
| [findings/LEDGER.md](../findings/LEDGER.md) line 170 | provenance only, the Gate 2 status and the withdrawal |
| [findings/second-order.md](../findings/second-order.md) line 787 | **scope**, L127's table is only at sphere products, which is what leaves L128(ii) something new |
| [findings/second-order.md](../findings/second-order.md) line 789 | a **strengthening that reverses L127**, see the defect below |
| [findings/second-order.md](../findings/second-order.md) line 793 ([Cor L128.1](../findings/second-order.md)) | the two **pair rows**, and supplies the $\mathcal D_n$ cut itself |
| [findings/second-order.md](../findings/second-order.md) line 895 (Step 3) | all four **rows** at $S^m\times S^m$, with the cut supplied itself |
| [findings/second-order.md](../findings/second-order.md) line 914 | the block's closing $(3,3)$ **agreement** clause |
| [plan.md](../plan.md) line 51 | names it only to say I3 does **not** borrow it |

No citation over-reads the table, and none imports the priority claim.

## The defects, stated for repair

**D1, the within-factor row is FALSE at $p=2$, and the table declares no scope.** It reads

> `| pair, **within-factor** | $\binom p2$ and $\binom q2$, **two families** | $\dfrac{p-2}{2(p-1)}$ and $\dfrac{q-2}{2(q-1)}$ respectively, both $<\tfrac12$ | no |`

At $p=2$ the $\lambda_p$-eigenvector does not exist: it is the vector constant on $F_1\setminus\{j,k\}$ and on $F_2$ with total sum zero, and $F_1\setminus\{j,k\}$ is empty, forcing the $F_2$ part to zero too. The single within-factor block is then **entirely $-\mu$**, of dimension $q-1=n-3$, so its top is $-\mu<0$ and the stated $\tfrac{p-2}{2(p-1)}=0$ is **not in the block's spectrum at all**. *Witness*: $S^2\times S^4$, where the block is $(-\tfrac23)^3$ against a stated top of $0$; screened at $(2,4)$ and $(2,6)$. The conclusion "both $<\tfrac12$" and the "no" survive, so nothing downstream breaks. **Repair**: a scope line "$p,q\ge3$, $n=p+q$" on the table, or the general form $\{\lambda_p,(-\mu)^{q-1},0^{p-3}\}$ in the cell.

**D2, the $\mathcal D_n$ row's stated justification fails at $p=2$, where the row's own source over-counts.** The cell says "from [Lemma L27](../findings/nondegeneracy.md)'s summands", and L27 is scoped $p,q\ge3$ with $(p,q)\ne(3,3)$; [L126](../findings/second-order.md)'s box and [Cor L128.1](../findings/second-order.md) both record that the summand list over-counts at $p=2$, "$86$ against $\dim\mathrm{Weyl}_6=84$ at $S^2\times S^4$", the $\mathrm{Weyl}_2$ summand having formula-dimension $-2$ and true dimension $0$. **The row happens to hold at $p=2$ anyway** (screened at $(2,4)$: $\{1,\lambda_4^3,(-\mu)^1,0^{\text{rest}}\}$ with $\lambda_2=0$ absorbed into the zeros), but it is unjustified there as written. Same repair as D1.

**D3, L127's withdrawn branching clause is reinstated by [L128](../findings/second-order.md) thirty-five lines below, in this same file, and L127 carries no forward pointer.** L127's box reads

> **AND THE CLAUSE "NO NON-DIAGONAL CRITICAL POINT BRANCHES OFF IT" IS WITHDRAWN.** $\ker DF=T_M\mathcal O$ gives tangency to the orbit and no more; a branch statement needs an equivariant slice and a Lyapunov–Schmidt reduction, and a branch tangent to a $\mathcal D_n$ direction can leave the diagonal at second order.

Line 789 of the same file reverses precisely that reasoning:

> **AND IT DOES REINSTATE [Lemma L127]'S WITHDRAWN CLAUSE, IN STRONGER FORM.** … The clause was withdrawn for want of an equivariant slice and a Lyapunov–Schmidt reduction; (iii) supplies what was missing and needs neither.

**A reader who stops at L127 takes a withdrawal the file has since overturned.** *What stays withdrawn is only the unconditional reading*, L128(iii) is conditional on L128(ii), which fails at $S^3\times S^3$. **Repair**: one clause in L127's box, "reinstated in stronger and conditional form by [L128](../findings/second-order.md)(iii); what stays withdrawn is the unconditional reading."

**D4, the column head "reaches $\tfrac12$?" does not say which of $=\tfrac12$ and $\ge\tfrac12$ it asks, and the $\mathcal D_n$ row's two cells contradict each other under the second.** Detailed at Q1 and Q4. **Repair**: "$=\tfrac12$?" as the head, plus "$\mathcal D_n\cap W^\perp$" or "once $\langle e\rangle$ is cut" in the $\mathcal D_n$ row.

## What stands

The table is **correct at $p,q\ge3$, $n=p+q$**, and the agreement with [Lemma L27](../findings/nondegeneracy.md) is exact with multiplicity across all ten values, strong enough that the $\mathcal D_n$ row is forced by the other three rows together with L27, rather than merely consistent with them. The cross-factor proof is right in every step, including the two $\Delta^{(jk)}$ eigenvalues and the identification of the third eigenvector with the orbit direction. The attribution the lemma exists to make (**each $\tfrac12$ is one cross-factor pair block, $pq$ of them, matching $\dim\mathcal O$**), holds and is the honest content. The $(3,3)$ arithmetic in the closing "Agreement" line checks. Nothing in [findings/](../findings/) restates the block tops differently, and no later passage in [second-order.md](../findings/second-order.md) contradicts the table, the one later passage that bears on the block, at line 789, contradicts the block's **prose box**, which is D3.

**VERDICT: CONFIRMED**
