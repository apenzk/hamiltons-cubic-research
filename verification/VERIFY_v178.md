# Verifier v178, Lemma L47, the dimension lemma for symmetric spaces

Cold from the definitions. **No numerical work was done: no script was run, no Sage, no Python, no floating-point evaluation.** Every value below is exact and was derived by hand from the Killing-form data of a named symmetric space, then compared against what the record prints. Where a decimal appears it is the record's own printed figure, quoted to identify a row, and the comparison behind it is the exact rational. Log: [agent_logs/verify-L47-v178.log](../agent_logs/verify-L47-v178.log).

The block under test is [findings/problem.md:221-234](../findings/problem.md), with the canonical statement at [results.md:531-535](../results.md), the landscape line at [results.md:170](../results.md), and the fuller working copy at [findings/graded-half.md:112-124](../findings/graded-half.md). The brief is [verification/BRIEF_L47.md](BRIEF_L47.md).

## The claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | Cauchy–Schwarz over the isotropy blocks gives $\lVert R\rVert^2\ge(n/4)^2/\dim\mathfrak h$ | **PROVEN**, but the load-bearing import is $\mathop{\mathrm{im}}R\subseteq\mathfrak h$, not the block eigenvalues |
| 2 | $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}\Rightarrow\lVert W\rVert^2\ge\frac16$ | **PROVEN**, and the algebra is **exact**, an equivalence, given the bound of claim 1 |
| 3 | Einstein $\tfrac12$ forces $\mathop{\mathrm{tr}}R=n/4$, $c=\frac1{2(n-1)}$, $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$ | **PROVEN** |
| 4 | [Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/) Prop 2.2 says what is claimed, and its hypotheses hold | **PROVEN**, with one unstated hypothesis: $H$ connected |
| 5 | The eight constants $616,48,7200,114,3696,2192,236,84$ | **PROVEN**, all eight reproduced by hand, in the census script's row order |
| 6 | *"each classical family … with an all-nonnegative-coefficient certificate"* is checkable from what is on file | **GAP**, no polynomial and no family in any prose file; only in [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py), which the canonical block does not cite |
| 7 | *"the twelve exceptional spaces check directly, mostly by an order of magnitude"* | **BROKEN as a qualifier**, the inequality holds; *"mostly by an order of magnitude"* is false at $\mathbb{OP}^2$ and at $G_2/SO(4)$ |
| 8 | $\mathbb{CP}^m$ closed form, minimum $\tfrac16$ at $\mathbb{CP}^2$ | **PROVEN**, re-derived cold; the range $m\ge2$ is unstated and load-bearing |
| 9 | $\mathbb{HP}^m$ closed form, minimum $\tfrac{45}{224}$ at $\mathbb{HP}^2$ | **PROVEN**, re-derived cold; the range $m\ge2$ is unstated and load-bearing |
| 10 | *"The residue is exactly the compact rank-one spaces"* | **PROVEN**, modulo claim 14 |
| 11 | *"Hence $\theta\le\sqrt{3/2}$ on every compact irreducible symmetric space"* | **BROKEN**, at $S^n$ and $\mathbb{RP}^n$, $\lVert W\rVert^2=0<\tfrac16$ and $\theta$ is undefined. The hypothesis $W\ne0$ is missing from the block and from the canon |
| 12 | *"equality only at $\mathbb{CP}^2$"* | **PROVEN** under the $W\ne0$ restriction of claim 11 |
| 13 | *"The rank-one spaces other than $\mathbb{OP}^2$ are the families of Lemmas 10 and 38"* | **BROKEN**, [L10](../findings/graded-half.md) and [L38](../findings/ungraded-slack.md) carry $\mathbb{CP}^m$ and the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family; neither carries $\mathbb{HP}^m$, $S^n$ or $\mathbb{RP}^n$ |
| 14 | Completeness of the index set, from the sources on file | **HYPOTHESIS-DEBT**, the type I/II dichotomy and type II are *proved* in [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/); the type-I list is **asserted, not proved**, in both sources |
| 15 | *"after shifting to its first admissible rank"* | **withdrawn as a defect, recorded as a misdescription**, one of the eight rows shifts to a dimension, not to a rank |
| 16 | Symbol hygiene | **four untabled collisions**: $\mathfrak h$, $\lambda$, $c$, and the word *centre* |

## The one-line summary

**Both derivations are correct and exact, and every closed-form value in the block reproduces cold, but the canonical statement quantifies over spaces where its own conclusion is undefined, its certificate evidence exists only inside a script, and its pointer for the rank-one residue names two lemmas that do not carry it: verdict GAP.**

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md), not restated.

On $\theta$:

> $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

On the norm the block's $\lVert R\rVert^2$, $\lVert W\rVert^2$ and $\lVert I\rVert^2$ are taken in:

> **The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** The inner product is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix. *Applying the $\tfrac12$ at the operator level instead inflates every $\theta$ by $\sqrt2$*, and has cost a cycle.

> $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$

On the scalar curvature, which is what turns Einstein $\tfrac12$ into $\mathop{\mathrm{tr}}R=n/4$:

> **$\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$ on $\Lambda^2$.**

On $\mathfrak h$, and this is a collision, see §9:

> $\mathfrak m$, $\mathfrak h$, $\mathfrak r$ | at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$ and $\mathfrak r$ everything else, kernel included.

On $B$, on the Killing form, and on the letter's ambiguity:

> **THE LETTER $B$ MEANS TWO THINGS, live.** [conventions.md]'s Killing form above is $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ on $\mathfrak{so}(n)$; [sym3-blocks.md](../findings/sym3-blocks.md) writes $B(X,Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$ on $\mathfrak{so}(5)$ … **Say which you mean, every time**

On Cartan's classification, which is what the block's universal quantifier ranges over:

> Cartan's classification | **[L159](../findings/graded-half.md) is the record's own statement of it and is what a consumer cites** … **Say which relation the argument consumes**

The block itself uses none of the three equivalence relations that line distinguishes; it indexes spaces, not involutions, so the $n=8$ and $4\mid n$ divergences that line warns about do not reach it. Recorded because the brief asked.

## 1. The hypothesis inventory

**A pass with no inventory is not a pass, so this comes before any derivation.**

### 1.1 Hypotheses the block states

| hypothesis | where stated | is it used? |
| --- | --- | --- |
| compact | [results.md:531](../results.md), [problem.md:221](../findings/problem.md) | **used**, [Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/)'s whole setting is $G$ compact semisimple with the metric $-B_{\mathfrak g}\vert_{\mathfrak p}$, and positive-definiteness of $-B_{\mathfrak g}$ is what makes that a metric at all |
| irreducible | same | **used twice, in different ways**, it is the index set of the census, and it is what makes a *single* Einstein constant available. It is **not** used in the Cauchy–Schwarz step, which holds for any compact symmetric space |
| rank $\ge2$ | same | **used only as a label.** No step in the block consumes it. It is the name of the set on which the census *asserts* $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}$; there is no argument on file deriving the dimension bound *from* the rank |
| normalised to Einstein constant $\tfrac12$ | same | **used**, it fixes $\mathop{\mathrm{tr}}R=n/4$ and $c=\frac1{2(n-1)}$, and it is what makes $\tfrac16$ the right threshold. It is also **without loss of generality**: $\theta=P(W)/\lVert W\rVert^3$ is homogeneous of degree $0$, so rescaling $g\mapsto sg$ carries $W\mapsto W/s$ and leaves $\theta$ fixed |
| $\mathbb{OP}^2$ adjoined to the rank-$\ge2$ branch | same | **used**, it is the one rank-one space that satisfies the dimension criterion, so adjoining it is not a special case but a widening of the branch |

### 1.2 Hypotheses of every imported result, and whether they were checked

**[Lemma L46](../findings/problem.md), the sole analytic import.** Its own audit note records four:

> **HYPOTHESES THE STATEMENT OWES, ALL FOUND AT THE SAME AUDIT.** *$\lambda\ne0$*: a Ricci-flat locally symmetric space is flat by Cartan, so $W=0$ and $\theta$ is undefined, **the conclusion needs $W\ne0$ and neither the block nor the canon says so**.

- *locally symmetric*, holds, a symmetric space is.
- *Einstein*, holds, with the $-B_{\mathfrak g}$ metric [Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/) give $\mathrm{Ric}=\tfrac12g$ outright.
- *$\lambda\ne0$*, holds, $\lambda=\tfrac12$.
- *$\lambda=\tfrac12$*, holds by the normalisation.
- ***$W\ne0$***, **does not hold on part of L47's own index set**, and L47 states it nowhere. This is §8 below, and it is the block's one genuine defect of statement. Note the trap: $\lambda\ne0$ does **not** imply $W\ne0$. $S^n$ has $\lambda=\tfrac12$ and $W=0$. L46's booked debt therefore does not cover L47's failure; L47 owes a second, distinct hypothesis.

**[Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/) Prop 2.2.** Read at source, [petersen-stanfield-2508.11236.txt:345-357](https://arxiv.org/abs/2508.11236). Its hypotheses, from §2.4 at lines 270-282: $M=G/H$ with $G$ **compact semisimple**; $H$ **the identity component** of the fixed-point subgroup of an involutive automorphism; $\mathfrak g$ carrying $-B_{\mathfrak g}$; $M$ carrying the induced metric. All hold for a compact irreducible symmetric space with its Killing metric, **except that $H$ must be connected**, and the residue lists $\mathbb{RP}^n=SO(n+1)/O(n)$, whose $H$ is not. That is harmless (curvature is local and $S^n$ covers it) but it is a hypothesis the block relies on and never mentions.

### 1.3 A hypothesis stated but never used

**Rank $\ge2$.** It appears in the statement, in the landscape line, and in the index row, and no step of the argument reads it. Its whole function is to name the set on which the certificates are asserted. This is worth saying plainly because it fixes what a reader may cite: *L47 does not prove that rank $\ge2$ implies the dimension bound.* It proves the dimension bound implies $\lVert W\rVert^2\ge\tfrac16$, and separately asserts, family by family, that the dimension bound holds.

### 1.4 A step using a hypothesis never stated

Four:

1. **$W\ne0$**, §8.
2. **$H$ connected**, §1.2.
3. **$\mathop{\mathrm{im}}R\subseteq\mathfrak h$**, the actual content the Cauchy–Schwarz step needs, §2. The block cites Prop 2.2 for *"the isotropy blocks, whose eigenvalues are…"*, and the eigenvalues are not what the inequality consumes.
4. **$\dim\mathfrak h$ is the isotropy algebra of the specific presentation $G/H$ used.** The criterion is a bound on a number attached to a presentation, and the block never says which. For $\mathbb{RP}^n$ against $S^n$ the presentations differ.

## 2. The Cauchy–Schwarz step, derived

The claim: $\lVert R\rVert^2\ge(n/4)^2/\dim\mathfrak h$, from $\mathop{\mathrm{tr}}R=n/4$.

**What Petersen–Stanfield actually give.** Prop 2.1 states $R=\tfrac12(I-P)$ under the identification $\mathfrak h\simeq\mathrm{ad}_{\mathfrak h}\vert_{\mathfrak p}\subset\Lambda^2TM$, and its proof opens

> In our convention, we have $R(X,Y)=\mathrm{ad}_{[X,Y]}\vert_{\mathfrak p}$ for all $X,Y\in\mathfrak p$. It follows that $R(X\wedge Y)=\mathrm{ad}_{[X,Y]}\vert_{\mathfrak p}\in\mathfrak{so}(\mathfrak p,-B_{\mathfrak g})=\Lambda^2\mathfrak p$.

and Prop 2.2's proof opens

> The curvature operator of $g$ is $G$-invariant with image $\mathfrak h\subset\Lambda^2T_pM$.

So $R$ is a symmetric operator on $\Lambda^2\mathbb R^n$ whose image lies in $\mathfrak h$; being symmetric, it also vanishes on $\mathfrak h^\perp$. Hence
$$\mathop{\mathrm{tr}}R=\mathop{\mathrm{tr}}(R\vert_{\mathfrak h}),\qquad \lVert R\rVert^2=\lVert R\vert_{\mathfrak h}\rVert^2 .$$
Cauchy–Schwarz on $\mathfrak h$ against the identity $I_{\mathfrak h}$:
$$(\mathop{\mathrm{tr}}R)^2=\langle R\vert_{\mathfrak h},I_{\mathfrak h}\rangle^2\le\lVert R\vert_{\mathfrak h}\rVert^2\,\lVert I_{\mathfrak h}\rVert^2=\lVert R\rVert^2\dim\mathfrak h,$$
and with $\mathop{\mathrm{tr}}R=n/4$ this is exactly the claim. **Correct.**

**What it does and does not need.** It needs only *symmetry of $R$* and *$\mathop{\mathrm{im}}R\subseteq\mathfrak h$*. It does **not** need the blocks to be the isotypic pieces, does not need Schur's lemma, and does not need any eigenvalue. The block's route, Prop 2.2's eigenvalue decomposition $\mathfrak h=\mathfrak h_0\oplus_i\mathfrak h_i$ with $R\vert_{\mathfrak h_i}=\lambda_iI$, then $(\sum_id_i\lambda_i)^2\le(\sum_id_i\lambda_i^2)(\sum_id_i)$, is the same inequality reached through a stronger hypothesis. It is sound; it is over-cited. [graded-half.md:117](../findings/graded-half.md) writes it in that weighted form, and there the citation of Prop 2.2 is apt.

**Equality is attainable, and this is not a technicality.** Equality holds iff $R\vert_{\mathfrak h}$ is a multiple of $I_{\mathfrak h}$. That happens: at $S^n=SO(n+1)/SO(n)$, $\mathfrak h=\mathfrak{so}(n)$ has $\dim\mathfrak h=\binom n2=N$, so $\mathfrak h$ is all of $\Lambda^2$ and $R=\frac1{2(n-1)}I$, which is $\mathop{\mathrm{tr}}R=\frac{N}{2(n-1)}=\frac n4$, as it must be. Then $\lVert R\rVert^2=(n/4)^2/N$, equality holds, and
$$\lVert W\rVert^2=\frac{(n/4)^2}{N}-\frac n{8(n-1)}=\frac n{8(n-1)}-\frac n{8(n-1)}=0 .$$
**So the one place the Cauchy–Schwarz step is sharp is the one place the conclusion fails.** That is §8, arrived at from the other side.

There is a second constraint the equality case must respect, worth recording because it closes off a family of would-be witnesses. Prop 2.2 says the eigenvalue on the centre $\mathfrak h_0$ is exactly $\tfrac12$. So if $\mathfrak h_0\ne0$, equality forces every $\lambda_i=\tfrac12$, hence $P=0$ on $\mathfrak h$, hence $B_{\mathfrak h}\equiv0$, hence $\mathfrak h$ abelian, hence $\mathfrak h=\mathfrak h_0$ and $\dim\mathfrak h=n/2$ from $\mathop{\mathrm{tr}}R=n/4$. Then $\lVert W\rVert^2=\frac{n(n-2)}{8(n-1)}$, which equals $\tfrac16$ only at the roots of $3n^2-10n+4$, neither an integer. No such space.

## 3. The implication, checked

Claim: $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}\Rightarrow\lVert W\rVert^2\ge\tfrac16$.

Write $h=\dim\mathfrak h$. From §2 and the L46 identity,
$$\lVert W\rVert^2\ \ge\ \frac{n^2}{16h}-\frac n{8(n-1)} .$$
Demand the right side be $\ge\tfrac16$:
$$\frac{n^2}{16h}\ \ge\ \frac16+\frac n{8(n-1)}=\frac{8(n-1)+6n}{48(n-1)}=\frac{14n-8}{48(n-1)}=\frac{7n-4}{24(n-1)},$$
$$h\ \le\ \frac{24n^2(n-1)}{16(7n-4)}=\frac{3n^2(n-1)}{2(7n-4)} .$$
**Exact, with no slack introduced.** The two are *equivalent* as statements about the Cauchy–Schwarz lower bound: $h\le\frac{3n^2(n-1)}{2(7n-4)}$ holds if and only if $\frac{n^2}{16h}-\frac n{8(n-1)}\ge\tfrac16$.

**Where the loss is, and it is only in one place.** The implication is lossy only through §2, a space may have $h$ above the threshold and still have $\lVert W\rVert^2\ge\tfrac16$, because Cauchy–Schwarz is slack there. $\mathbb{HP}^2$ is exactly that case and the record says so ([graded-half.md:167](../findings/graded-half.md)): $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)\subset\mathfrak{so}(8)$ has $\dim=13$ against a threshold of $\frac{3\cdot64\cdot7}{2\cdot52}=\frac{1344}{104}=\frac{168}{13}$, and $\frac{168}{13}<13$ since $168<169$, **by one**. Yet $\lVert W\rVert^2(\mathbb{HP}^2)=\tfrac{45}{224}>\tfrac16$. So the converse of the implication is false, and the record's own file exhibits the witness.

The strict form is what earns the equality clause: if $h<\frac{3n^2(n-1)}{2(7n-4)}$ strictly, then $\lVert W\rVert^2>\tfrac16$ strictly. The certificates are stated in exactly that strict form, and §5 confirms it.

## 4. Petersen–Stanfield Proposition 2.2, read at source

Verbatim, [petersen-stanfield-2508.11236.txt:345-350](https://arxiv.org/abs/2508.11236):

> **Proposition 2.2.** The decomposition $\mathfrak h=\mathfrak h_0\oplus_i\mathfrak h_i$ is precisely the decomposition into eigenspaces for $R$ and the eigenvalue for $\mathfrak h_0$ is the Einstein constant $\tfrac12$. Consequently, if $\lambda_i$ is the eigenvalue corresponding to $\mathfrak h_i$ we obtain: $\tfrac12\dim_{\mathbb R}M=\mathrm{scal}=2\mathop{\mathrm{tr}}R=\dim\mathfrak h_0+2\sum_{i\ge1}\lambda_i\dim_{\mathbb R}\mathfrak h_i$.

**It says what is claimed, and it supplies more.**

- $\mathrm{scal}=\tfrac12\dim M=n/2$, hence $\mathop{\mathrm{tr}}R=n/4$, the block's first constant, from the source, in the source's own convention $\mathrm{scal}=2\mathop{\mathrm{tr}}R$, which is [conventions.md](../findings/conventions.md)'s convention too. **They agree; no conversion is needed and none is hidden.**
- The proof's first line gives $\mathop{\mathrm{im}}R=\mathfrak h$, which is what §2 consumes.
- Theorem A, at [line 373-375](https://arxiv.org/abs/2508.11236), adds *"the eigenvalues for the curvature operator are between 0 and $\tfrac12$"*, **unused by L47**, and it is strictly stronger than what L47 extracts. From $\lambda_i\le\tfrac12$ one gets $\lVert R\rVert^2\le\tfrac12\mathop{\mathrm{tr}}R=n/8$, an upper bound the block never needs.

**Hypotheses checked against the objects here:** §1.2. They hold, with the $H$-connected caveat.

**One caution the source itself raises and the block does not repeat**, [line 360-367](https://arxiv.org/abs/2508.11236): *"It can happen that $\lambda_i=\lambda_j$ for some $i\ne j$"*, with $SO(8)/(SO(4)\times SO(4))$ as the example. Harmless for L47 (Cauchy–Schwarz does not care whether the blocks are distinct) but it does mean *"the isotropy blocks"* is a decomposition into simple ideals plus centre, not into distinct eigenspaces.

## 5. The eight certificate constants

**What the record's prose gives a reader.** Two identical sentences, at [problem.md:231](../findings/problem.md) and [graded-half.md:118](../findings/graded-half.md): *"each classical family reduces to a polynomial positivity statement with an all-nonnegative-coefficient certificate after shifting to its first admissible rank, each with a strictly positive constant term ($616$, $48$, $7200$, $114$, $3696$, $2192$, $236$, $84$)"*. **No polynomial is written. No family is named against any constant. No parameter range is given.** From the prose alone a reader can check nothing, not which eight families are meant, not what the shift is, not what the polynomial is a polynomial in.

**Where the content actually is.** [scripts/route-b/b_symmetric_dimension_lemma.py:57-67](../scripts/route-b/b_symmetric_dimension_lemma.py) carries eight rows, each a triple (dimension $n$, isotropy dimension $D$, substitution), and the certificate function forms
$$P\ :=\ 3n^2(n-1)-2(7n-4)D$$
which is $2(7n-4)$ times the slack $\frac{3n^2(n-1)}{2(7n-4)}-\dim\mathfrak h$, and $7n-4>0$ throughout, so $P>0$ is exactly the strict form of the criterion. Reading that file, the eight families are **AIII, BDI, CII, AI, AII, DIII, CI, and type II**, in that order. [graded-half.md:142](../findings/graded-half.md) cites the script; **the canonical block in [problem.md](../findings/problem.md) cites nothing at all.**

**All eight constants reproduce, by hand, in closed form.** Each is $P$ evaluated at the first admissible parameter values of its row. Exact rational arithmetic, no evaluation tool:

| # | family, from the script's row | $n$, $\dim\mathfrak h$ at the shift point | $P$ there | matches |
| --- | --- | --- | --- | --- |
| 1 | AIII $\mathrm{Gr}_{\mathbb C}(p,q)$, $p=q=2$ | $n=2pq=8$, $h=p^2+q^2-1=7$ | $3\cdot64\cdot7-2\cdot52\cdot7=1344-728$ | $\mathbf{616}$ |
| 2 | BDI $\mathrm{Gr}_{\mathbb R}(p,q)$, $p=q=2$ | $n=pq=4$, $h=1+1=2$ | $3\cdot16\cdot3-2\cdot24\cdot2=144-96$ | $\mathbf{48}$ |
| 3 | CII $\mathrm{Gr}_{\mathbb H}(p,q)$, $p=q=2$ | $n=4pq=16$, $h=10+10=20$ | $3\cdot256\cdot15-2\cdot108\cdot20=11520-4320$ | $\mathbf{7200}$ |
| 4 | AI $SU(m)/SO(m)$, $m=3$ | $n=\frac{(m-1)(m+2)}2=5$, $h=\frac{m(m-1)}2=3$ | $3\cdot25\cdot4-2\cdot31\cdot3=300-186$ | $\mathbf{114}$ |
| 5 | AII $SU(2m)/Sp(m)$, $m=3$ | $n=(m-1)(2m+1)=14$, $h=m(2m+1)=21$ | $3\cdot196\cdot13-2\cdot94\cdot21=7644-3948$ | $\mathbf{3696}$ |
| 6 | DIII $SO(2m)/U(m)$, $m=4$ | $n=m(m-1)=12$, $h=m^2=16$ | $3\cdot144\cdot11-2\cdot80\cdot16=4752-2560$ | $\mathbf{2192}$ |
| 7 | CI $Sp(m)/U(m)$, $m=2$ | $n=m(m+1)=6$, $h=m^2=4$ | $3\cdot36\cdot5-2\cdot38\cdot4=540-304$ | $\mathbf{236}$ |
| 8 | II, simple $G$, $\dim\ge6$ | $n=h=6$ | $3\cdot36\cdot5-2\cdot38\cdot6=540-456$ | $\mathbf{84}$ |

Eight for eight, in order. That is a strong provenance result: the constants are not decorative, they are the slack at the corner of each family, and the record's own ordering is recoverable.

**The nonnegativity of the remaining coefficients is a separate claim, and I checked two rows of it.**

Row 8 in full. $n=h=m$ gives $P=3m^3-17m^2+8m$; at $m=6+a$,
$$3(6+a)^3-17(6+a)^2+8(6+a)=3a^3+37a^2+128a+84 .$$
All four coefficients nonnegative, constant term $84>0$, so $P>0$ for every $a\ge0$. **The row's own claim, confirmed.**

Row 2 on the slice $a=0$ (that is, $p=2$, $q=2+b$). $P=3p^2q^2(pq-1)-(7pq-4)(p^2-p+q^2-q)$; at $p=2$ this is $10q^3+6q^2-32q+8$, and at $q=2+b$,
$$10b^3+66b^2+112b+48 .$$
All nonnegative, constant $48$, matching row 2's tabled constant. **Confirmed on that slice.**

I did **not** expand the remaining six polynomials or the off-slice part of row 2. That is re-deriving the certificates, which the brief reserves.

**What a reader can and cannot check.** Can: the eight constants, from the script's rows, by the arithmetic above. Can: that $P>0$ is the right strict criterion, and that a strictly positive constant term with nonnegative coefficients gives it on the whole shifted orthant. Cannot, from any prose file: which families the constants belong to, what the polynomials are, what the shifts are, or that the eight families exhaust the classical part of the classification. **The claim *"all-nonnegative-coefficient certificate"* is verifiable only by opening a script that the canonical block does not name.**

### 5.1 The parameter ranges, checked row by row

Because §1.3 makes the census the whole content of the rank-$\ge2$ branch, the substitutions have to cover their families exactly. They do:

- AIII, rank $\min(p,q)$; $p=2+a$, $q=2+a+b$ covers $\{2\le p\le q\}$ and the family is symmetric in $p,q$. ✓
- BDI, rank $\min(p,q)$; same substitution. ✓ *It over-covers*: $p=q=2$ is $SO(4)/(SO(2)\times SO(2))=S^2\times S^2$, **reducible**, so the row asserts the criterion on a strict superset of the irreducible family. Harmless (a superset of a true statement) but it means the row is not exactly the irreducible BDI family.
- CII, rank $\min(p,q)$; same. ✓
- AI, rank $m-1\ge2\Leftrightarrow m\ge3$; $m=3+a$. ✓
- AII, rank $m-1\ge2\Leftrightarrow m\ge3$; $m=3+a$. ✓
- DIII, rank $\lfloor m/2\rfloor\ge2\Leftrightarrow m\ge4$; $m=4+a$. ✓
- CI, rank $m\ge2$; $m=2+a$. ✓
- Type II, $m=6+a$. **This shift is to a dimension, not to a rank**, see §10.

## 6. The residue: both closed forms re-derived cold

The brief asks for both minima and for exhaustiveness. I derived both closed forms from the Killing forms, using only Prop 2.1's $R=\tfrac12(I-P)$ with $B_{\mathfrak g}(P\cdot,\cdot)\vert_{\mathfrak h}=B_{\mathfrak h}$.

### 6.1 $\mathbb{CP}^m$

$M=SU(m+1)/S(U(1)U(m))$, $n=2m$, $\mathfrak h=\mathfrak u(1)\oplus\mathfrak{su}(m)$, $\dim\mathfrak h=m^2$. With $B_{\mathfrak{su}(k)}=2k\mathop{\mathrm{tr}}$ on the defining representation, $P\vert_{\mathfrak{su}(m)}=\frac{2m}{2(m+1)}=\frac m{m+1}$, so
$$\lambda_{\mathfrak{su}(m)}=\tfrac12\Big(1-\tfrac m{m+1}\Big)=\frac1{2(m+1)},\qquad \lambda_{\mathfrak h_0}=\tfrac12 .$$
Check against Prop 2.2's trace identity: $\tfrac12\cdot1+\frac{m^2-1}{2(m+1)}=\tfrac12+\tfrac{m-1}2=\tfrac m2=\tfrac n4$. ✓

$$\lVert R\rVert^2=\tfrac14+\frac{m^2-1}{4(m+1)^2}=\frac{(m+1)+(m-1)}{4(m+1)}=\frac m{2(m+1)},$$
$$\boxed{\ \lVert W\rVert^2(\mathbb{CP}^m)=\frac m{2(m+1)}-\frac{2m}{8(2m-1)}=\frac{3m(m-1)}{4(m+1)(2m-1)}\ }$$
which is [graded-half.md:200](../findings/graded-half.md)'s $\lVert W\rVert^2_{\mathbb{CP}^m}=\frac{3m(m-1)}{4(m+1)(2m-1)}$, and its reciprocal quarter is [L10](../findings/graded-half.md)'s and [L38](../findings/ungraded-slack.md)'s $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$. **Agreement, cold.**

At $m=2$: $\frac{3\cdot2\cdot1}{4\cdot3\cdot3}=\frac6{36}=\tfrac16$. **The minimum claim's value is confirmed.**

**Independent anchor on the normalisation.** At $m=2$ the eigenvalues of $W=R-cI$ with $c=\frac1{2(n-1)}=\tfrac16$ are $\tfrac12-\tfrac16=\tfrac13$ once, $\tfrac16-\tfrac16=0$ three times, $0-\tfrac16=-\tfrac16$ twice, that is $\frac1{\sqrt6}(2,0,0,0,-1,-1)$ after unit-normalising, which is [conventions.md](../findings/conventions.md)'s and [problem.md:239](../findings/problem.md)'s $W_{\mathbb{CP}^2}=\mathop{\mathrm{diag}}(0,0,0,-1,-1,2)/\sqrt6$ **exactly**. So the block's norm convention is the record's, and no factor of $2$ or $\sqrt2$ is hiding in it.

### 6.2 $\mathbb{HP}^m$

$M=Sp(m+1)/(Sp(m)\times Sp(1))$, $n=4m$, $\dim\mathfrak h=m(2m+1)+3$. With $B_{\mathfrak{sp}(k)}=(4k+4)\mathop{\mathrm{Re}}\mathop{\mathrm{tr}}_{\mathbb H}$ (fixed by $\mathfrak{sp}(1)\cong\mathfrak{su}(2)$, where $B(X,X)=-8a^2$ at $X=ai$),
$$\lambda_{\mathfrak{sp}(m)}=\tfrac12\Big(1-\tfrac{4m+4}{4m+8}\Big)=\frac1{2(m+2)},\qquad \lambda_{\mathfrak{sp}(1)}=\tfrac12\Big(1-\tfrac8{4m+8}\Big)=\frac m{2(m+2)} .$$
Trace check: $\frac{m(2m+1)}{2(m+2)}+\frac{3m}{2(m+2)}=\frac{m(2m+4)}{2(m+2)}=m=\tfrac n4$. ✓

These are exactly the values [graded-half.md:204](../findings/graded-half.md) attributes to [Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/) §3.5 (*"$\tfrac m{2(m+2)}$ on $\mathfrak{sp}(1)$ and $\tfrac1{2(m+2)}$ on $\mathfrak{sp}(m)$"*), **re-derived here without opening §3.5.**

$$\lVert R\rVert^2=\frac{m(2m+1)+3m^2}{4(m+2)^2}=\frac{m(5m+1)}{4(m+2)^2},$$
$$\lVert W\rVert^2=\frac{m(5m+1)}{4(m+2)^2}-\frac{4m}{8(4m-1)}=\frac{m\big[(5m+1)(8m-2)-4(m+2)^2\big]}{8(m+2)^2(4m-1)}=\frac{18m(2m+1)(m-1)}{8(m+2)^2(4m-1)},$$
$$\boxed{\ \lVert W\rVert^2(\mathbb{HP}^m)=\frac{9m(m-1)(2m+1)}{4(m+2)^2(4m-1)}\ }$$
whose reciprocal quarter is $\theta^2=\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$, [graded-half.md:206](../findings/graded-half.md) **exactly**.

At $m=2$: $\frac{9\cdot2\cdot1\cdot5}{4\cdot16\cdot7}=\frac{90}{448}=\tfrac{45}{224}$. **The second minimum claim's value is confirmed**, and $\theta^2=\tfrac{224}{4\cdot45}=\tfrac{56}{45}$, the record's $\sqrt{56/45}$.

### 6.3 Four further cold checks against the record's tables

Because the whole apparatus turns on one normalisation, I re-derived four more of the record's printed values from the Killing forms alone. Every one matches to every printed digit.

| space | my $\lambda$'s | my $\theta^2$ | record's printed value |
| --- | --- | --- | --- |
| $\mathbb{HP}^2$ | $\tfrac14$ on $\mathfrak{sp}(1)$, $\tfrac18$ on $\mathfrak{sp}(2)$ | $\tfrac{56}{45}$ | $\theta=1.115546702$, unit-$W$ blocks $0.39841,0.11952$ ([graded-half.md:100](../findings/graded-half.md)), my $W$-blocks are $\tfrac{1/4-1/14}{\sqrt{45/224}}$ and $\tfrac{1/8-1/14}{\sqrt{45/224}}$ |
| $\mathbb{HP}^3$ | $\tfrac3{10}$, $\tfrac1{10}$ | $\tfrac{275}{378}$ | $\theta=0.852943860$, blocks $0.43423,0.09305$ |
| $\mathrm{Gr}_{\mathbb C}(2,2)$ | $\tfrac12$ on $\mathfrak u(1)$, $\tfrac14$ on each $\mathfrak{su}(2)$ | $\tfrac{14}{27}$ | $\theta=0.720082300=\sqrt{14/27}$, blocks $0.61721,0.25717,0.25717$ |
| $\mathrm{Gr}_{\mathbb C}(2,3)$ | $\tfrac12$, $\tfrac3{10}$ on $\mathfrak{su}(2)$, $\tfrac15$ on $\mathfrak{su}(3)$ | $\tfrac{1}{4\cdot(0.703\overline{63})}$, i.e. $\theta=0.596068$ | $\theta=0.596068081$, blocks $0.54188,0.30345,0.18424$ |

The general complex-Grassmannian eigenvalues that produce rows 3 and 4 are $\lambda_{\mathfrak{su}(p)}=\frac q{2(p+q)}$, $\lambda_{\mathfrak{su}(q)}=\frac p{2(p+q)}$, $\lambda_{\mathfrak h_0}=\tfrac12$, **not on the record in closed form**, and [graded-half.md:492](../findings/graded-half.md) says so: *"the Wolf values have a closed form on the record and the two Grassmannian values do not, so any clause quantified over the complex-Grassmannian family stands on two computed members, that is where a falsifier to this lemma would live."* Those two values are now corroborated from the Killing form, which narrows that exposure without closing it, since the closed form is still absent from the record.

### 6.4 Is the residue exhaustive?

*"The residue is exactly the compact rank-one spaces."* Checked against the census's own index. Each of the eight families has rank-one members, and each is accounted for at [b_symmetric_dimension_lemma.py:81-87](../scripts/route-b/b_symmetric_dimension_lemma.py): $S^n$ and $\mathbb{RP}^n$ arrive as $\mathrm{Gr}_{\mathbb R}(1,q)$, AI at $m=2$, AII at $m=2$, CI at $m=1$ and type II at $\dim3$; $\mathbb{CP}^m$ as $\mathrm{Gr}_{\mathbb C}(1,m)$ and as DIII at $m=2,3$; $\mathbb{HP}^m$ as $\mathrm{Gr}_{\mathbb H}(1,m)$; $\mathbb{OP}^2$ as FII, which is in the exceptional list and satisfies the criterion. **The accounting is complete and correct**, and it is complete *in a script's print statements*, not in any prose file.

$\mathbb{OP}^2=F_4/\mathrm{Spin}(9)$: $n=52-36=16$, $\mathfrak h=\mathfrak{so}(9)$ simple, $\dim\mathfrak h=36$. Threshold $\frac{3\cdot256\cdot15}{2\cdot108}=\frac{160}3=53.\overline3$, and $36<\tfrac{160}3$, so it is inside the lemma. Since $\mathfrak h$ is simple the single eigenvalue is $\lambda=\frac{n/4}{36}=\tfrac19$, giving $\lVert R\rVert^2=\tfrac{36}{81}=\tfrac49$ and $\lVert W\rVert^2=\tfrac49-\tfrac2{15}=\tfrac{14}{45}$, comfortably above $\tfrac16$, and the Cauchy–Schwarz step is *tight* here, so $\tfrac{14}{45}$ is both the bound and the value. **The one rank-one space kept in the rank-$\ge2$ branch is kept correctly.**

## 7. The conclusion $\theta\le\sqrt{3/2}$

$\theta=\lambda/\lVert W\rVert$ comes from [L46](../findings/problem.md): $Q(W)=\lambda W$, so $P(W)=\langle W,Q(W)\rangle=\lambda\lVert W\rVert^2$, and by [conventions.md](../findings/conventions.md)'s $\theta=P(W)/\lVert W\rVert^3$ this is $\lambda/\lVert W\rVert$. With $\lambda=\tfrac12$,
$$\theta^2=\frac1{4\lVert W\rVert^2},\qquad \theta\le\sqrt{3/2}\iff\theta^2\le\tfrac32\iff\lVert W\rVert^2\ge\tfrac16 .$$
**Exact equivalence.** What it needs: $\lambda\ne0$ (so $\theta$ is a quotient at all), $\lambda>0$ (so the square root direction is the one claimed, at $\lambda<0$, L46's own note says $\theta<0$ and the inequality is vacuous), $\lambda=\tfrac12$ (so $\tfrac16$ is the threshold), and $\lVert W\rVert\ne0$. The first three hold. The fourth is §8.

The step is also *scale-free*, which is worth saying because it is why the normalisation costs nothing: $\theta$ is homogeneous of degree $0$ in $W$ and $W$ is linear in $R$, so a homothety of the metric leaves $\theta$ fixed. The normalisation to $\lambda=\tfrac12$ is a choice of representative, not a hypothesis on the space.

## 8. The defect: $W=0$, and the quantifier that ignores it

**Located.** [problem.md:231](../findings/problem.md), last sentence: *"Hence $\theta\le\sqrt{3/2}$ on every compact irreducible symmetric space, **equality only at $\mathbb{CP}^2$**."* And [results.md:531-535](../results.md), which says *"that dimension bound implies $\lVert W\rVert^2\ge\frac16$, i.e. $\theta\le\sqrt{3/2}$"* and *"Among the irreducible spaces equality holds only at $\mathbb{CP}^2$"*. And the boxed Theorem at [graded-half.md:122](../findings/graded-half.md): *"On every compact irreducible symmetric space, $\lVert W\rVert^2\ge\tfrac16$, with equality exactly at $\mathbb{CP}^2$."*

**Exhibited, in closed form.** Take $S^4=SO(5)/SO(4)$. Compact, irreducible, rank one, $n=4$. Normalised to Einstein constant $\tfrac12$: $\mathfrak h=\mathfrak{so}(4)$, $\dim\mathfrak h=6=\binom42=N$, simple-plus-simple with equal eigenvalues, so $R=\lambda I$ on all of $\Lambda^2$ with $\lambda=\frac{n/4}{6}=\tfrac16$. Then $c=\frac1{2(n-1)}=\tfrac16$ and
$$W=R-cI=0,\qquad \lVert W\rVert^2=0 .$$
So $0\ge\tfrac16$ is **false**, and $\theta=P(W)/\lVert W\rVert^3=0/0$ is **undefined**. The same at every $S^n$ and every $\mathbb{RP}^n$, and at $\mathbb{CP}^1=S^2$ and $\mathbb{HP}^1=S^4$, both closed forms of §6 return $0$ at $m=1$, which is the correct value and is below the threshold.

**The most charitable reading the words support.** [graded-half.md:120](../findings/graded-half.md) writes the residue leg as *"$S^n$ and $\mathbb{RP}^n$ have $W=0$, **so $\theta$ is undefined and the conjecture's hypothesis excludes them**"*. That is the intended scope, and it is correct. But the clause after the comma is **absent from [problem.md](../findings/problem.md)'s canonical block**, which keeps only *"$S^n$ and $\mathbb{RP}^n$ have $W=0$"* and then draws a universal conclusion two clauses later; and it is absent from [results.md](../results.md) entirely. So the charitable reading exists in the record, in the file the canon points *away* from.

**All three protocol tests clear.** The defect is real, and it is a defect of statement rather than of argument: the fix is one clause, and no value changes. The lemma's honest statement is over compact irreducible symmetric spaces **with $W\ne0$**, equivalently all of them other than the real space forms $S^n$ and $\mathbb{RP}^n$.

**Why this is not simply L46's booked debt.** L46's note says *"the conclusion needs $W\ne0$ and neither the block nor the canon says so"*, and books it under $\lambda\ne0$. But $\lambda\ne0$ is **not** the condition here: $S^n$ has $\lambda=\tfrac12\ne0$ and $W=0$ anyway. L47 needs a hypothesis L46's repair does not supply.

**And it sharpens the equality clause.** *"Equality only at $\mathbb{CP}^2$"* is true of the value $\tfrac16$ but false as a statement about the minimum: the infimum of $\lVert W\rVert^2$ over compact irreducible symmetric spaces is $0$, attained on an infinite family, and $\tfrac16$ is a minimum only after those are excluded.

## 9. Symbol collisions, by name

Four, none of them in [conventions.md](../findings/conventions.md).

- **$\mathfrak h$.** [conventions.md](../findings/conventions.md) tables it as *"at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$"* (the top eigenspace of $L_e$) and warns that $\mathfrak m$ *"carries three incompatible senses across the record"*. L47's $\mathfrak h$ is the **isotropy subalgebra of $G/H$**, a fifth object under a letter already flagged. A reader importing the tabled sense reads $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}$ as a bound on the top eigenspace of the second-order operator, which is a different statement about a different object. **Not tabled.**
- **$\lambda$.** Inside the block's own two sentences, $\lambda$ is the Einstein constant $\tfrac12$; inside the proposition the block cites in the same sentence, $\lambda_i$ are the **curvature-operator block eigenvalues**, which equal $\tfrac12$ on the centre and are strictly smaller elsewhere. The collision is inside one citation. **Not tabled.**
- **$c$.** L47's $c=\frac1{2(n-1)}$ is the Einstein shift $\lambda/(n-1)$. Twenty lines above, in the same file, [L44](../findings/problem.md) writes *"the curvature operator $cI+W$ it defines at the pinned $c$ lies on $\partial\Omega_0$"* with [conventions.md](../findings/conventions.md)'s $c=\frac1n\sqrt{2(n-2)/(n-1)}$, a **different** constant in a syntactically identical role, $R=cI+W$. [conventions.md](../findings/conventions.md) also carries $c$ as a subalgebra Killing constant and $c_{abc}$ as structure constants. **Four senses; the two that collide sit in one file.**
- **The word *centre*.** The block writes *"makes the centre constant universal at $c=\frac1{2(n-1)}$"* immediately before citing a proposition whose *"centre"* is $\mathfrak h_0\subset\mathfrak h$, carrying eigenvalue $\tfrac12$. The block's *centre constant* is the mean of $R$ over $\Lambda^2$ and has nothing to do with $\mathfrak h_0$; the two "centres" are one line apart and unrelated. **Not tabled, and this is the collision most likely to mislead**, because both are true statements about the same operator.

$B$ and $R$: no live collision inside L47. $B$ does not appear in the block; it appears in [L48](../findings/problem.md) immediately below as the partition bracket, a third sense beside [conventions.md](../findings/conventions.md)'s two Killing forms, but that is L48's row. $R$ is used consistently for the full curvature operator on $\Lambda^2$, and its norm convention was pinned independently in §6.1 against $W_{\mathbb{CP}^2}$.

## 10. The other findings, each with the protocol run

### 10.1 *"mostly by an order of magnitude"*, BROKEN as a qualifier

**Located.** [problem.md:231](../findings/problem.md) and [graded-half.md:118](../findings/graded-half.md), which adds *"($E_8/SO(16)$: $\dim\mathfrak h=120$ against a bound of $3499$)"*.

**Exhibited.** Two of the twelve, both named in the brief's own scope. $\mathbb{OP}^2=F_4/\mathrm{Spin}(9)$: $\dim\mathfrak h=36$ against $\frac{160}3=53.\overline3$, a factor of $\tfrac{40}{27}$, under $1.5$. $G_2/SO(4)$: $n=8$, $\dim\mathfrak h=6$ against $\frac{3\cdot64\cdot7}{2\cdot52}=\frac{168}{13}$, a factor of $\tfrac{28}{13}$, under $2.2$. $E_6/F_4$: $n=26$, $\dim\mathfrak h=52$ against $\frac{3\cdot676\cdot25}{2\cdot178}=\frac{12675}{89}$, a factor under $2.8$. **I did not tabulate the other nine**; the brief reserves re-running the exceptional check, and three named spaces are enough to settle the qualifier.

**Charitable reading.** *"Mostly"* is a hedge and the example the record chooses, $E_8/SO(16)$, is genuine, its factor is above $29$. But the word does rhetorical work: it is what tells a reader the twelve need no scrutiny. The tightest case is $\mathbb{OP}^2$, which is also the one space the branch adjoins by hand, and it clears by less than half an order of magnitude. The claim survives; the reassurance does not.

**Verdict.** The inequality holds at all three I checked and the record's own table shows it holding at the other nine. The *qualifier* is false and should not be relied on. Marked BROKEN as a qualifier, not as a claim.

### 10.2 The pointer to Lemmas 10 and 38, BROKEN

**Located.** [results.md:535](../results.md): *"The rank-one spaces other than $\mathbb{OP}^2$ are the families of Lemmas 10 and 38."*

**Exhibited.** [L38](../findings/ungraded-slack.md)'s two families are $\mathbb{CP}^m$, at $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, and *"the Kähler family of $(\mathfrak{su}(m),\mathfrak{so}(m))$ inside $\mathfrak{so}(2m)$"*, at $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$, the second is **not** $\mathbb{HP}^m$; [graded-half.md:203](../findings/graded-half.md) says outright that its $W$ *"would be $c\ne0$ on $\mathfrak{hol}^\perp$, impossible for a symmetric space"*, so it is not a symmetric space's Weyl part at all. [L10](../findings/graded-half.md) carries the same $\mathbb{CP}^m$ closed form. Between them: $\mathbb{CP}^m$, twice, and one family that is not a symmetric space. **Neither carries $\mathbb{HP}^m$, and neither carries $S^n$ or $\mathbb{RP}^n$.**

**Where the $\mathbb{HP}^m$ leg actually lives.** [graded-half.md:206](../findings/graded-half.md), under the unnumbered heading *"Wolf spaces and complex Grassmannians"*, inside the region of [Observation L5](../findings/graded-half.md), which [INDEX-results.md:20](../findings/INDEX-results.md) records as *"Gate 2: REFUTED as a Lemma and as a census … Downgraded to `Observation`"*. The closed form and its monotonicity are there and are correct (§6.2 re-derives the closed form cold), but **the residue's quaternionic half has no numbered result behind it**, and L47's pointer sends a reader to two lemmas that do not contain it.

**Charitable reading.** *"The families of Lemmas 10 and 38"* might be read as naming only the $\mathbb{CP}^m$ leg and leaving the rest implicit. But the sentence is a complete disposal of the rank-one residue (*"the rank-one spaces other than $\mathbb{OP}^2$ are…"*) and three of its four legs are outside those lemmas. The reading does not survive the sentence's own quantifier.

**Verdict.** BROKEN as a pointer. No value moves.

### 10.3 *"after shifting to its first admissible rank"*, withdrawn as a defect

**Candidate.** Row 8 of the census shifts to $\dim\ge6$, and $\dim\ge6$ is not a rank condition: type II has rank $\ge2$ exactly from $\mathfrak{su}(3)$ at $\dim8$, while the shift to $6$ is where the inequality $3n^2-17n+8\ge0$ first holds (larger root $\frac{17+\sqrt{193}}6$, between $5$ and $6$). So one of the eight rows shifts to a *dimension*, not to a rank.

**Why withdrawn.** The shift over-covers, it asserts the criterion on $\{n\ge6\}$, of which the simple algebras are a subset, and the assertion is true there. Nothing is lost and no claim is weakened. It is a misdescription of one row in a sentence that describes eight; recorded, not counted as a defect.

**A second thing the same row settles.** Type II is not a *classical* family: its members include $G_2$, $F_4$, $E_6$, $E_7$, $E_8$ as group manifolds. So the prose's *"each classical family"* misnames the row that carries the five exceptional group manifolds. I opened this as a possible exhaustiveness gap, the twelve exceptional spaces are the twelve **type-I** exceptional pairs, exactly as [Holland–Ion's](../references/holland-ion-2012-symmetric-spaces/) own table lists them, and they do not include the five exceptional groups. **Withdrawn**: row 8 covers them, uniformly and correctly. What remains is that the sentence calls a family classical when it is not.

### 10.4 The minima over $m$, GAP, and it is small

**Located.** *"$\mathbb{CP}^m$ and $\mathbb{HP}^m$ have closed forms with minima $\tfrac16$ at $\mathbb{CP}^2$ and $\tfrac{45}{224}$ at $\mathbb{HP}^2$."*

**The gap.** The census's warrant for *"minimum at $m=2$"* is [b_symmetric_dimension_lemma.py:92-98](../scripts/route-b/b_symmetric_dimension_lemma.py), which evaluates $m=2,\dots,6$ and takes the smallest. **A five-point scan is not a statement about a family**, and this is the brief's named trap *"a claim proven on a subfamily and used in general"* in its clearest form. For $\mathbb{HP}^m$ the monotonicity **is** on the record, at [graded-half.md:208](../findings/graded-half.md), with the derivative and the positivity of its cubic given in full. For $\mathbb{CP}^m$ it is on the record too, at [L10](../findings/graded-half.md) and [L38](../findings/ungraded-slack.md), *"strictly decreasing"*, and [INDEX-results.md:53](../findings/INDEX-results.md) records L38's audit as *"Monotonicity proved for both on $m\ge2$, a range the block never states"*.

So the gap is not in the record; it is in **L47's own citation of it**. The block asserts a minimum over a family and points at nothing, while the two monotonicity arguments sit in files the block does not name, and the one it *does* effectively rely on, the script, proves the claim on five points. **Screened: the monotonicity survives on $m\ge2$ for both families.** I do not supply the argument; the record already holds it, and L47 owes the citation.

**The unstated range.** Both closed forms return $0$ at $m=1$, where $\mathbb{CP}^1=S^2$ and $\mathbb{HP}^1=S^4$. The range $m\ge2$ is load-bearing and stated in neither the block nor the canon. It is the same defect as §8 seen at the edge, which is where the brief said to look.

### 10.5 A candidate that failed the protocol, withdrawn

**Candidate.** That $\mathbb{CP}^2$, the equality case, fails the dimension criterion: $\dim\mathfrak u(2)=4$ against $\frac{3\cdot16\cdot3}{2\cdot24}=3$. More generally $\mathbb{CP}^m$ fails it for **every** $m$: $m^2\le\frac{3m^2(2m-1)}{7m-2}\iff7m-2\le6m-3\iff m\le-1$. So the *equality case of the theorem lies outside the branch that proves the theorem*.

**Why withdrawn.** That is not a defect, it is the design: $\mathbb{CP}^m$ is rank one and is in the residue by construction, where its closed form settles it. Recorded because it is the natural place a reader would suspect circularity, and there is none.

## 11. What a consumer of L47 may cite for the completeness of its own index set

The statement is universal over a classification, so this is the load-bearing question and the brief is right to press it.

| what has to be cited | what is on file | status |
| --- | --- | --- |
| Compact irreducible orthogonal symmetric Lie algebras are of type I or type II | [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/) ch. 3 §1 Remark and ch. 3 §2, [holland-ion-1211.4159.txt:1125-1187](https://arxiv.org/abs/1211.4159), the $c<0$ case with the argument that irreducibility forces $\mathfrak g_o=\mathfrak r_o\oplus\mathfrak r_o$ with the flip | **argued at source, and citable** |
| Type II $=$ the compact Lie groups | [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/) ch. 7 Theorem 19, [line 3013](https://arxiv.org/abs/1211.4159) | **proved at source, and citable** |
| The type-I list, the eight classical Cartan types and the twelve exceptional pairs | [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/) ch. 8 §2.1 and §2.3, with the Cartan-type tables | **printed, but completeness is asserted, not proved**, the source's own §2 says *"We shall not prove here that every possible Vogan diagram gives a simple real Lie algebra"* |
| The exceptional isotropy groups | [Yokota](../references/yokota-2009-exceptional-lie-groups/) §§1.10–5.8 | **constructed one by one; exhaustiveness asserted in the preface and proved nowhere** |
| $\dim\mathfrak g$ and $\dim\mathfrak k$ for the twelve | nothing on file | **sourced nowhere**, both reference notes say so explicitly. The census's twelve $\dim\mathfrak h$ values are standard and correct ($\mathfrak{sp}(4)=36$, $\mathfrak{su}(6)\oplus\mathfrak{su}(2)=38$, $\mathfrak{so}(10)\oplus\mathfrak{so}(2)=46$, $\mathfrak f_4=52$, $\mathfrak{su}(8)=63$, $\mathfrak{so}(12)\oplus\mathfrak{su}(2)=69$, $\mathfrak e_6\oplus\mathfrak{so}(2)=79$, $\mathfrak{so}(16)=120$, $\mathfrak e_7\oplus\mathfrak{su}(2)=136$, $\mathfrak{sp}(3)\oplus\mathfrak{su}(2)=24$, $\mathfrak{so}(9)=36$, $\mathfrak{so}(4)=6$) but they rest on the reader's own knowledge, not on a stored source |

**Two corrections to the record's own reference notes, both in L47's favour.** [holland-ion .../notes.md](../references/holland-ion-2012-symmetric-spaces/notes.md) reads chapter 8 only and reports the source as covering *"the classification of $\mathfrak{so}(n)$'s symmetric pairs"* and the twelve exceptional pairs. The source covers considerably more: the type I/II/III/IV division with an argument, all the classical type-I Cartan types (AIII at [line 4472](https://arxiv.org/abs/1211.4159), BI at 4522, CII at 4575, DI at 4647, DIII at 4651), and type II as a proved theorem. **So the census's index set is better sourced than the notes suggest**; what remains unsourced is the completeness of the type-I list and the twelve's numerical data.

**The trap the brief flags is real and the census steps over it.** [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/) splits the $\mathfrak{so}(2n)$ pairs across §2.1 (both $p,q$ even) and §2.3 (both odd), so a reader stopping at §2.1 concludes that $\mathfrak{so}(3)\oplus\mathfrak{so}(9)\subset\mathfrak{so}(12)$ is not on the list. The census's BDI row is $p=2+a$, $q=2+a+b$ over **all** integers $a,b\ge0$, both parities, so it covers what §2.1 alone would omit. **No defect; the census is right where the source is easy to misread.**

**What a consumer may therefore say.** *"L47 quantifies over Cartan's classification of compact irreducible symmetric spaces; the type I/II dichotomy and the identification of type II are proved in [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/), and the type-I list is printed there and in [Yokota](../references/yokota-2009-exceptional-lie-groups/) but is asserted rather than proved in both."* A consumer may **not** say that the completeness of the list is established on this record. That is HYPOTHESIS-DEBT, and it is the debt the whole universal statement rests on.

## 12. What would falsify the statement, and what I did to look for it

**The object.** A compact irreducible symmetric space $M=G/H$, normalised to Einstein constant $\tfrac12$, with $W\ne0$ and $\lVert W\rVert^2<\tfrac16$. Equivalently, by §3, a space that **both** fails the dimension criterion, $\dim\mathfrak h>\frac{3n^2(n-1)}{2(7n-4)}$, **and** has enough spread among its block eigenvalues $\lambda_i$ to leave $\sum_id_i\lambda_i^2$ below $\tfrac16+\frac n{8(n-1)}$. Both conditions are needed: failing the criterion alone is not enough, and $\mathbb{HP}^2$ is the standing proof of that, it fails the criterion by one unit of dimension, $13$ against $\tfrac{168}{13}$, and its $\lVert W\rVert^2=\tfrac{45}{224}$ clears the threshold anyway.

**Where such an object could hide, ranked.** The criterion is failed only by spaces with unusually large isotropy for their dimension, and by §6 the family that does this systematically is the rank-one one: $\mathbb{CP}^m$ fails it at every $m$, $\mathbb{HP}^2$ fails it, $S^n$ fails it maximally. Outside rank one the only large-isotropy case the record names is $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, which is a *product* and so outside the irreducible quantifier. **So a falsifier would be a rank-one-like space missing from the census's rank-one accounting, or a family whose certificate polynomial has a negative coefficient off the shift point.**

**What I did.**

- Re-derived both residue closed forms from the Killing forms alone (§6.1, §6.2), and confirmed that both are minimised at $m=2$ over $m\ge2$ with values $\tfrac16$ and $\tfrac{45}{224}$. **No falsifier in the residue.**
- Checked the residue accounting against the eight families' rank-one members, one family at a time (§6.4). **Every rank-one member is accounted for; nothing falls between the branches.**
- Checked $\mathbb{OP}^2$ by hand: $\dim\mathfrak h=36<\tfrac{160}3$, $\lVert W\rVert^2=\tfrac{14}{45}$ (§6.4). **Inside.**
- Checked the eight parameter substitutions cover their families (§5.1). **They do; one over-covers, none under-covers.**
- Reproduced all eight certificate constants (§5), and fully expanded two of the certificate polynomials. **All-nonnegative in both.**
- Re-derived four further named values, $\mathbb{HP}^2$, $\mathbb{HP}^3$, $\mathrm{Gr}_{\mathbb C}(2,2)$, $\mathrm{Gr}_{\mathbb C}(2,3)$, from the Killing forms, and every one matched the record's printed figure to every digit (§6.3). **The apparatus is not carrying a normalisation error.**
- Derived the two independent constraints on the Cauchy–Schwarz equality case (§2). **The only equality is $W=0$, which is §8's defect and not a falsifier of the corrected statement.**

**What I did not do, and it is the exposure.** I did not expand six of the eight certificate polynomials, and I did not check nine of the twelve exceptional spaces. Both are reserved by the brief. **If a falsifier exists it is in those two places**, and specifically in a certificate polynomial with a negative coefficient at high degree, which would leave the family's tail uncovered while its shift point looked healthy. The record's only defence against that is the script, and the script's `all(c >= 0 for c in coeffs)` is the right test, [sympy](https://docs.sympy.org/latest/modules/polys/reference.html)'s `Poly.coeffs()` returns the nonzero coefficients, and absent monomials are $0$, so the test is sound as written. **What is missing is any prose statement of the eight polynomials, which is the difference between a claim a reader can falsify and one they cannot.**

## Verdict

**GAP.**

The two derivations are correct and exact. The Cauchy–Schwarz step is sound and needs less than it cites; the implication is an exact equivalence with no slack introduced; the imported Petersen–Stanfield proposition says what is claimed and its hypotheses hold; all eight certificate constants reproduce by hand; both residue closed forms and four further named values re-derive cold and match the record to every printed digit; the residue is exhaustive; and the step to $\theta\le\sqrt{3/2}$ is exact.

What is missing:

1. **The hypothesis $W\ne0$** (§8). The canonical statement is false as written at $S^n$ and $\mathbb{RP}^n$ ($\lVert W\rVert^2=0<\tfrac16$ and $\theta$ is undefined) and the clause that fixes it exists only in [graded-half.md](../findings/graded-half.md), not in [problem.md](../findings/problem.md) or [results.md](../results.md). This is distinct from [L46](../findings/problem.md)'s already-booked $\lambda\ne0$, which does not imply it.
2. **The certificates are unstatable from the record** (§5). Eight numbers, no polynomials, no families, no ranges, no citation from the canonical block to the one file that holds them.
3. **The pointer for the rank-one residue is wrong** (§10.2). [L10](../findings/graded-half.md) and [L38](../findings/ungraded-slack.md) carry $\mathbb{CP}^m$ and a family that is not a symmetric space; the $\mathbb{HP}^m$ leg has no numbered result behind it and the sphere leg has none either.
4. **The minima over $m$ are cited to a five-point scan** (§10.4), while the monotonicity that justifies them sits, proved, in two files the block does not name; and the range $m\ge2$ is unstated.
5. ***"Mostly by an order of magnitude"* is false** (§10.1) at the tightest of the twelve, which is $\mathbb{OP}^2$, the one space the branch adjoins by hand.
6. **Four untabled symbol collisions** (§9): $\mathfrak h$, $\lambda$, $c$, and the word *centre*.
7. **The completeness of the index set is HYPOTHESIS-DEBT** (§11): citable for the type I/II dichotomy and for type II, asserted-not-proved for the type-I list in both sources, and unsourced entirely for the twelve exceptional spaces' dimensions.

None of these moves a value. All seven are repairs to what the block *says* and to what it *points at*, and item 1 changes the statement's quantifier.
