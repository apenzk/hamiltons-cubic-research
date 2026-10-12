# Verifier v176, Lemma L47, the dimension lemma for compact irreducible symmetric spaces

I read [BRIEF_L47.md](BRIEF_L47.md) first, then the canonical block at [problem.md:221-231](../findings/problem.md#L221), the landscape and canonical statements at [results.md:170](../results.md#L170) and [results.md:531](../results.md#L531), the working section at [graded-half.md:118-135](../findings/graded-half.md#L118), and [Petersen–Stanfield](https://arxiv.org/abs/2508.11236) §2.3–2.4 at source. **No numerical work was done: every value below is exact rational or exact surd arithmetic carried out by hand from the definitions, and no script was executed.** I read [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py) as a text to learn what the eight certificate constants refer to, and then reproduced all eight by hand rather than taking them from it. Log: [agent_logs/verify-L47-v176.log](../agent_logs/verify-L47-v176.log).

## The claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | Cauchy–Schwarz gives $\lVert R\rVert^2\ge(n/4)^2/\dim\mathfrak h$ | **PROVEN**, and it needs strictly less than the block claims |
| 2 | $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}\Rightarrow\lVert W\rVert^2\ge\tfrac16$ | **PROVEN**, the algebra is exact; the implication is sufficient, never necessary |
| 3 | Petersen–Stanfield Prop 2.2 says what is claimed | **PROVEN**, but the support statement actually consumed is their Prop **2.1** |
| 4 | the eight constants $616,48,7200,114,3696,2192,236,84$ | **PROVEN as values** (all eight reproduced by hand) |
| 5 | "all-nonnegative-coefficient certificate", each family | **HYPOTHESIS-DEBT**, no polynomial is written anywhere on the record; I verified four of eight by hand |
| 6 | "after shifting to its first admissible rank" | **BROKEN for the eighth family**, its shift is to $\dim\mathfrak g=6$, a dimension no compact simple Lie algebra has |
| 7 | the twelve exceptional spaces clear the bound | **PROVEN**, all twelve checked by hand |
| 8 | "mostly by an order of magnitude" | **BROKEN**, 5 of 12, not most |
| 9 | $\mathbb{CP}^m$ minimum $\tfrac16$ at $\mathbb{CP}^2$ | **PROVEN**, closed form re-derived cold from Prop 2.2 |
| 10 | $\mathbb{HP}^m$ minimum $\tfrac{45}{224}$ at $\mathbb{HP}^2$ | **PROVEN**, closed form re-derived cold from Props 2.1–2.2 |
| 11 | the residue is exhaustive | **PROVEN modulo the classification**, whose completeness is nowhere proved on file |
| 12 | $\theta\le\sqrt{3/2}$ "on every compact irreducible symmetric space" | **BROKEN as written**, $S^n$ has $\lVert W\rVert^2=0$ and $\theta$ undefined |
| 13 | equality only at $\mathbb{CP}^2$ | **PROVEN** under the repaired hypothesis $W\ne0$ |
| 14 | the residue pointer "the families of Lemmas 10 and 38" | **BROKEN**, neither carries $\mathbb{HP}^m$, and nothing carries $S^n$/$\mathbb{RP}^n$ |
| 15 | $\mathfrak h$, $c$, $\lambda$ as used here | **BROKEN as documentation**, three collisions, none tabled in the sense L47 uses |

## The one-line summary

**Every number in L47 is right and I re-derived the load-bearing ones cold, but the rank-$\ge2$ branch (which is the whole lemma), has no written argument on the record, only a script the canonical block does not cite; and the concluding universal is false as stated, with $S^n$ as the witness.** Verdict: **GAP**.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md):

> | $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself |
> | $P(W)$ | the cubic form $\langle W,Q(W)\rangle$ |
> | $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$ |
> | $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$ |
> | $R_I$, $R_{\mathrm{ric}_0}$, $R_W$ | the three $O(n)$-irreducible pieces of an algebraic curvature operator, scalar, **trace-free** Ricci, and Weyl. $R_{\mathrm{ric}_0}=0$ makes a slice **Einstein** |

and, on the classification this lemma quantifies over:

> | Cartan's classification | **[L159](../findings/graded-half.md) is the record's own statement of it and is what a consumer cites** … **Say which relation the argument consumes** |

and, on the letter $\mathfrak h$:

> | $\mathfrak m$, $\mathfrak h$, $\mathfrak r$ | at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$ and $\mathfrak r$ everything else, kernel included |

Petersen–Stanfield's own conventions, quoted from [the source](https://arxiv.org/abs/2508.11236):

> "We will be considering a compact symmetric space of the form $M=G/H$, where $G$ is a compact semisimple Lie group and $H$ is the identity component of the fixed point subgroup of an involutive automorphism of $G$. We endow the compact Lie algebra $\mathfrak g$ with the inner product $-B_{\mathfrak g}$ … We endow the space $G/H$ with the symmetric Riemannian metric $g$ induced by the $\mathrm{Ad}(H)$-invariant restriction of $-B_{\mathfrak g}$ to $\mathfrak p\times\mathfrak p$."

> "$\mathrm{Ric}=\tfrac12g=-\tfrac12B_g|_{\mathfrak p\times\mathfrak p}$"

> "$g(R(X\wedge Y),Z\wedge W):=2R(X,Y,Z,W)$"

## 1. The hypothesis inventory

**A pass with no inventory is not a pass, so here is the full list, and what each does.**

| hypothesis | stated where | used where | verdict |
| --- | --- | --- | --- |
| **compact** | canonical statement, landscape statement, block | via Petersen–Stanfield's standing hypothesis ($G$ compact semisimple), and to make the classification finite | **used** |
| **irreducible** | all three sites | only to fix the index set of the census; **no step of the argument needs it**, Props 2.1/2.2 hold verbatim for reducible $G/H$ with $G$ semisimple, which is exactly why [L48](../findings/problem.md) can reuse the same machinery | **used for the quantifier, not for the mathematics** |
| **symmetric** | all three sites | $[\mathfrak p,\mathfrak p]=\mathfrak h$, $\operatorname{im}R\subseteq\mathfrak h$, and the eigenvalue statement, all of Prop 2.1 | **used, essentially** |
| **rank $\ge2$** | canonical and landscape | only to select which families the certificates are shifted to; the inequality $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}$ has no rank in it | **used as an index restriction only** |
| **Einstein** | implicit in "normalised to Einstein constant $\tfrac12$" | load-bearing twice: $R-cI=W$ requires $R_{\mathrm{ric}_0}=0$, and [L46](../findings/problem.md)'s $Q(W)=\lambda W$ requires $\mathrm{Ric}=\lambda g$ | **used**, and automatic here, since an irreducible symmetric space is Einstein |
| **normalisation $\lambda=\tfrac12$** | all three sites | fixes $\operatorname{tr}R=n/4$ and $c=\frac1{2(n-1)}$; the *statement* $\lVert W\rVert^2\ge\tfrac16$ is scale-dependent and meaningless without it. $\theta$ itself is scale-invariant, $P(tW)/\lVert tW\rVert^3=P(W)/\lVert W\rVert^3$, so the $\theta$ conclusion survives any rescaling | **used, and correctly declared** |
| **[L46](../findings/problem.md)**, four hypotheses, locally symmetric, Einstein, $\lambda\ne0$, $\lambda=\tfrac12$ | cited in the canonical statement for the norm identity | **all four hold here** ($\lambda=\tfrac12\ne0$). But see §5: L46 is cited at the wrong step | **used at a different step than the one it is attached to** |
| **$W\ne0$** | **nowhere** | required for $\theta=\lambda/\lVert W\rVert$ to be defined and for the concluding universal to be true | **USED AND NEVER STATED**, see §7 D1 |
| Petersen–Stanfield's own: $G$ compact semisimple, $H$ the identity component of an involution's fixed set, metric $-B_{\mathfrak g}$ | not restated at L47 | every eigenvalue and every trace | **hold for all objects here**, checked in §3 |

## 2. The Cauchy–Schwarz step, derived

Prop 2.1 gives $R=\tfrac12(I-P)$ with $\operatorname{im}R\subseteq\mathfrak h\subset\Lambda^2T_pM$. Let $h=\dim\mathfrak h$ and let $\mu_1,\dots,\mu_h$ be the eigenvalues of $R$ restricted to $\mathfrak h$; $R$ vanishes on $\mathfrak h^\perp$. Then by Cauchy–Schwarz on $(\mu_j)$ against $(1,\dots,1)\in\mathbb R^h$,

$$(\operatorname{tr}R)^2=\Big(\sum_{j=1}^h\mu_j\Big)^2\le h\sum_{j=1}^h\mu_j^2=h\,\lVert R\rVert^2 ,$$

and with $\operatorname{tr}R=n/4$ this is $\lVert R\rVert^2\ge(n/4)^2/h$. **Two things follow that the block does not say.**

**The blocks need not be the isotypic pieces.** The derivation used only (i) $\operatorname{im}R\subseteq\mathfrak h$ and (ii) $\operatorname{tr}R=n/4$. It never used that $\mathfrak h_0\oplus_i\mathfrak h_i$ is the eigenspace decomposition, nor that $R$ is constant on each block, nor the value $\tfrac12$ on the centre. Any subspace containing $\operatorname{im}R$ would serve, with its dimension in place of $h$. So the block's "Cauchy–Schwarz over the isotropy blocks, whose eigenvalues are Petersen–Stanfield Prop 2.2" **over-cites**: Prop 2.2's content (the block decomposition *is* the eigenspace decomposition) is not consumed here at all. What is consumed is Prop 2.1's image statement, which appears inside Prop 2.2's *proof* ("The curvature operator of $\mathfrak g$ is $G$-invariant with image $\mathfrak h\subset\Lambda^2T_pM$"), so the citation is recoverable, but it points at the wrong proposition.

**Equality is attainable, and not where the theorem's equality case sits.** Equality holds exactly when $R|_{\mathfrak h}$ is a multiple of the identity, i.e. when $\mathfrak h$ is simple (one block, no centre). Three checks by hand:

- **Type II, $G$ compact simple:** $\mathfrak h=\Delta\mathfrak g$ is simple, $h=n$, $\mu=(n/4)/n=\tfrac14$, so $\lVert R\rVert^2=n/16$ exactly and Cauchy–Schwarz is an equality. Then $\lVert W\rVert^2=\frac n{16}-\frac n{8(n-1)}=\frac{n(n-1)-2n}{16(n-1)}=\frac{n(n-3)}{16(n-1)}$, which is [graded-half.md](../findings/graded-half.md)'s closed form exactly.
- **$\mathbb{OP}^2=F_4/\mathrm{Spin}(9)$:** $\mathfrak h=\mathfrak{so}(9)$ simple, $h=36$, $n=16$, $\mu=4/36=\tfrac19$, $\lVert R\rVert^2=36/81=\tfrac49$, equality again. $\lVert W\rVert^2=\tfrac49-\tfrac{16}{120}=\tfrac{20-6}{45}=\tfrac{14}{45}$, so $\theta^2=\frac1{4\cdot14/45}=\tfrac{45}{56}$. **This matches the record's independently obtained $\tfrac34\sqrt{10/7}=0.896421$ at $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$** ([results.md:318](../results.md#L318)), since $(\tfrac34)^2\cdot\tfrac{10}7=\tfrac{90}{112}=\tfrac{45}{56}$.
- **$\mathbb{CP}^2$, the theorem's equality case:** eigenvalues $\tfrac12$ (multiplicity $1$) and $\tfrac16$ (multiplicity $3$) are **not** equal, so Cauchy–Schwarz is *strict* there: $\lVert R\rVert^2=\tfrac14+\tfrac1{12}=\tfrac13$ against the bound $1^2/4=\tfrac14$.

**So the lemma's equality case and the theorem's equality case are different objects.** $\mathbb{CP}^2$ moreover *fails* the dimension bound ($h=4$ against $\frac{3\cdot16\cdot3}{2\cdot24}=3$) so the lemma never sees it, and the theorem's "equality only at $\mathbb{CP}^2$" is delivered entirely by the residue's closed form. That is consistent, and the block nowhere says it.

**And the lemma structurally never sees $\mathbb{CP}^m$ at any $m$.** With $n=2m$, $h=m^2$, the bound is $\frac{3\cdot4m^2(2m-1)}{2(14m-4)}=\frac{3m^2(2m-1)}{7m-2}$, and $m^2>\frac{3m^2(2m-1)}{7m-2}\iff 7m-2>6m-3\iff m>-1$, always. The residue is not a convenience; it is forced.

## 3. Petersen–Stanfield Prop 2.2, read at source

Verbatim, [petersen-stanfield-2508.11236.txt:345](https://arxiv.org/abs/2508.11236):

> "**Proposition 2.2.** The decomposition $\mathfrak h=\mathfrak h_0\oplus_i\mathfrak h_i$ is precisely the decomposition into eigenspaces for $R$ and the eigenvalue for $\mathfrak h_0$ is the Einstein constant $\tfrac12$. Consequently, if $\lambda_i$ is the eigenvalue corresponding to $\mathfrak h_i$ we obtain: $\tfrac12\dim_{\mathbb R}M=\mathrm{scal}=2\mathrm{tr}R=\dim\mathfrak h_0+2\sum_i\lambda_i\dim_{\mathbb R}\mathfrak h_i$."

**It says what is claimed.** Three consequences the record uses, all checked:

1. $\operatorname{tr}R=\tfrac12\mathrm{scal}=\tfrac14\dim_{\mathbb R}M=n/4$, **stated in Prop 2.2 itself**, so the record's $\operatorname{tr}R=n/4$ is sourced, not asserted.
2. $c=\operatorname{tr}R/N=\frac{n/4}{n(n-1)/2}=\frac1{2(n-1)}$, and $c^2N=\frac{1}{4(n-1)^2}\cdot\frac{n(n-1)}2=\frac n{8(n-1)}$, the block's constant, exactly.
3. Eigenvalues lie in $[0,\tfrac12]$ (their proof of Theorem A), consistent with every value I compute below.

**Its hypotheses hold for every object L47 quantifies over.** Type I: $G$ compact simple hence semisimple, $H$ the identity component of an involution's fixed set, this is the definition of the Cartan pairs. Type II: $M=(G\times G)/\Delta G$, with $G\times G$ compact semisimple and $\Delta G$ the fixed set of the swap involution. $\mathbb{OP}^2=F_4/\mathrm{Spin}(9)$ is Type I. **Nothing here requires irreducibility**, which is why the same propositions carry [L48](../findings/problem.md).

**One convention check, because it would change every number if wrong.** Petersen–Stanfield normalise $|X\wedge Y|^2=2$ for orthonormal $X,Y$ and $g(R(X\wedge Y),Z\wedge W)=2R(X,Y,Z,W)$; under this pairing a constant-curvature space of sectional curvature $\kappa$ has $R=\kappa I$, so $\mathrm{Ric}=\tfrac12g$ forces $\kappa=\frac1{2(n-1)}$ and $\operatorname{tr}R=\frac{n(n-1)/2}{2(n-1)}=\frac n4$. That is the record's $c$, arrived at from the source's own convention. **The two conventions agree.**

## 4. The implication, checked line by line

$\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}\ \ge\ \frac{n^2}{16h}-\frac n{8(n-1)}$, and demanding the right-hand side be $\ge\tfrac16$:

$$\frac{n^2}{16h}\ \ge\ \frac16+\frac n{8(n-1)}=\frac{4(n-1)+3n}{24(n-1)}=\frac{7n-4}{24(n-1)}\ \Longleftrightarrow\ h\le\frac{24(n-1)n^2}{16(7n-4)}=\frac{3n^2(n-1)}{2(7n-4)} .$$

**The algebra is exact and I reproduce the block's constant with no slack.** Two properties the block does not state:

- **The implication is sufficient and never necessary.** It is an *iff* between the dimension bound and the Cauchy–Schwarz *lower bound* clearing $\tfrac16$; it is a one-way implication about $\lVert W\rVert^2$ itself, because Cauchy–Schwarz is lossy wherever $\mathfrak h$ has more than one block. So a space failing the dimension bound is not thereby a counterexample, $\mathbb{HP}^2$ ($h=13$ against $\frac{6\cdot4\cdot7}{13}=\frac{168}{13}=12.923$) and every $\mathbb{CP}^m$ fail it and satisfy the conclusion.
- **Strictness propagates.** If $h<$ bound strictly then $\frac{n^2}{16h}>\frac{7n-4}{24(n-1)}$ and $\lVert W\rVert^2>\tfrac16$ strictly. This is what the certificates' strictly positive constant terms buy, and it is what earns "equality exactly at $\mathbb{CP}^2$" on the rank-$\ge2$ branch. The step is sound.

## 5. Where [L46](../findings/problem.md) is actually used, and where it is cited

The canonical statement attaches "(Lemma L46)" to the identity $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$. **That identity is not L46.** It is the orthogonal decomposition $R=cI+W$ with $c=\operatorname{tr}R/N$, valid for any Einstein $R$ under any normalisation with $\operatorname{tr}R=n/4$; it needs the Einstein hypothesis (to kill $R_{\mathrm{ric}_0}$, per [conventions.md](../findings/conventions.md)) and nothing else. L46's content, $Q(W)=\lambda W$, is consumed at the *last* step:

$$\theta\Big(\tfrac W{\lVert W\rVert}\Big)=\frac{\langle W,Q(W)\rangle}{\lVert W\rVert^3}=\frac{\lambda\lVert W\rVert^2}{\lVert W\rVert^3}=\frac\lambda{\lVert W\rVert}=\frac1{2\lVert W\rVert},$$

so $\lVert W\rVert^2\ge\tfrac16\Rightarrow\theta\le\frac1{2\sqrt{1/6}}=\frac{\sqrt6}2=\sqrt{3/2}$, using that $Q$ is quadratic-homogeneous. **The step is correct and its warrant exists; the citation is attached to the wrong line of the block.** Harmless to the values, and worth a one-word repair.

## 6. The eight certificate constants, what a reader can and cannot check

**From the canonical block alone: nothing.** [problem.md:221-231](../findings/problem.md#L221) names no family against any constant, writes no polynomial, names no variable, names no shift point, and links no script. Its only citation is Petersen–Stanfield. Since [results.md:535](../results.md#L535) makes that block the designated proof (*"**Proof:** [problem.md](findings/problem.md)"*), **the proof of the lemma's principal clause is not on the record in prose.**

The data exists in exactly one place, [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py), which [graded-half.md](../findings/graded-half.md) links and the canonical block does not. Reading it as a text, the eight rows are $P:=3n^2(n-1)-2(7n-4)\dim\mathfrak h$ evaluated at the shifted parameters. **I reproduced all eight constants by hand and every one is right:**

| # | family | $(n,\dim\mathfrak h)$ | shift | $P$ at the shift | claimed |
| --- | --- | --- | --- | --- | --- |
| 1 | AIII $\mathrm{Gr}_{\mathbb C}(p,q)$ | $(2pq,\ p^2+q^2-1)$ | $p=q=2$ | $3\cdot64\cdot7-2\cdot52\cdot7=1344-728$ | **616** ✓ |
| 2 | BDI $\mathrm{Gr}_{\mathbb R}(p,q)$ | $(pq,\ \binom p2+\binom q2)$ | $p=q=2$ | $144-96$ | **48** ✓ |
| 3 | CII $\mathrm{Gr}_{\mathbb H}(p,q)$ | $(4pq,\ p(2p+1)+q(2q+1))$ | $p=q=2$ | $11520-4320$ | **7200** ✓ |
| 4 | AI $SU(m)/SO(m)$ | $(\tfrac{(m-1)(m+2)}2,\ \binom m2)$ | $m=3$ | $300-186$ | **114** ✓ |
| 5 | AII $SU(2m)/Sp(m)$ | $((m-1)(2m+1),\ m(2m+1))$ | $m=3$ | $7644-3948$ | **3696** ✓ |
| 6 | DIII $SO(2m)/U(m)$ | $(m(m-1),\ m^2)$ | $m=4$ | $4752-2560$ | **2192** ✓ |
| 7 | CI $Sp(m)/U(m)$ | $(m(m+1),\ m^2)$ | $m=2$ | $540-304$ | **236** ✓ |
| 8 | II simple $G$ | $(\dim\mathfrak g,\ \dim\mathfrak g)$ | $\dim=6$ | $540-456$ | **84** ✓ |

Each dimension formula is also correct: $\dim SU(m)-\dim SO(m)=\frac{(m-1)(m+2)}2$, $\dim SU(2m)-\dim Sp(m)=(m-1)(2m+1)$, $\binom{2m}2-m^2=m(m-1)$, $m(2m+1)-m^2=m(m+1)$.

**The all-nonnegative-coefficient claim is a different matter, and it is written nowhere.** Not in the block, not in [graded-half.md](../findings/graded-half.md), not in the script, the script *tests* it with `sympy` at run time and prints a verdict; it does not record the expansions. So a reader cannot check the certificates without executing code. I verified four of the eight by hand:

- **Type II.** $P=n(3n^2-17n+8)$; at $n=6+a$, $3n^2-17n+8=3a^2+19a+14$, all coefficients $\ge0$, constant $14$; times $n=6+a$ gives constant $84$. ✓
- **CI.** $P=m^2\bigl[3m^4+9m^3-8m^2-17m+5\bigr]$. Taylor at $m=2$: value $59$, then $155$, $236$, $198$, $72$, every coefficient positive; $59\cdot4=236$. ✓
- **DIII.** $P=m^2\bigl[3m^4-9m^3-8m^2+17m+5\bigr]$. Taylor at $m=4$: $137,\ 289,\ 344,\ 234,\ 72$, all positive; $137\cdot16=2192$. ✓
- **BDI**, on both boundary slices. At $p=2$: $P=10q^3+6q^2-32q+8$, which at $q=2+b$ is $10b^3+66b^2+112b+48$, all positive. On the diagonal $p=q$: $P=3p^6-17p^4+14p^3+8p^2-8p$, whose Taylor coefficients at $p=2$ are $48,\ 224,\ 808,\ 2148,\ 3912,\ 4320,\ 2160$, all positive. ✓

**The remaining four (AI, AII, AIII, CII) I checked only at the base point and at first order**, e.g. AII at $m=3$ has $dP/dm=(9n^2-6n)n'-2[7n'h+(7n-4)h']=1680\cdot11-2(1617+1222)=12802>0$, which is evidence, not a certificate. **Recorded as `HYPOTHESIS-DEBT`: the record owes eight written expansions, or one written argument that replaces them.**

## 7. Discrepancies, each cleared through all three protocol steps

### D1. "Every compact irreducible symmetric space" is false as written, $S^n$ is the witness

1. **Located.** [problem.md:231](../findings/problem.md#L231), final sentence: *"Hence $\theta\le\sqrt{3/2}$ on every compact irreducible symmetric space, **equality only at $\mathbb{CP}^2$**."* And the Theorem box at [graded-half.md:122](../findings/graded-half.md#L122): *"On every compact irreducible symmetric space, $\lVert W\rVert^2\ge\tfrac16$, with equality exactly at $\mathbb{CP}^2$."*
2. **Exhibited in closed form.** $S^4=SO(5)/SO(4)$ is compact, irreducible and symmetric. $\mathfrak h=\mathfrak{so}(4)$ has $\dim=6=N$, so $R=\mu I$ with $\mu=(n/4)/6=\tfrac16$, which is exactly $c=\frac1{2(n-1)}=\tfrac16$. Hence $W=R-cI=0$, $\lVert W\rVert^2=0<\tfrac16$ (the displayed inequality is **false**) and $\theta=\lambda/\lVert W\rVert=(\tfrac12)/0$ is **undefined**, so the $\theta$ form is not false but ill-posed. The same holds at every $S^n$ and $\mathbb{RP}^n$.
3. **Argued the opposite.** The most charitable reading is available and is two lines above, in the same paragraph: *"$S^n$ and $\mathbb{RP}^n$ have $W=0$, so $\theta$ is undefined and the conjecture's hypothesis excludes them."* So the intended statement carries an unwritten $W\ne0$, and the canonical statement at [results.md:533](../results.md#L533) is guarded, its main clause is hypothesised on "rank $\ge2$, and for $\mathbb{OP}^2$", which excludes $S^n$. **The defect is confined to the two concluding universals, not to the lemma's main clause, and no value changes.**

**Verdict: real, and it is the brief's named trap twice over ("$\ker W\ne0$), here $W=0$" and "a hypothesis used but never stated".** The record already paid for this exact omission one lemma earlier: [problem.md:545](../findings/problem.md#L545) records against L46 that *"the conclusion needs $W\ne0$ and neither the block nor the canon says so"*. L47 reintroduces it. Repair: state $W\ne0$, or equivalently "of non-constant curvature", in both universals.

### D2. The eighth certificate is not shifted to a rank, and its constant is attained by nothing

1. **Located.** [problem.md:231](../findings/problem.md#L231): *"each classical family reduces to a polynomial positivity statement with an all-nonnegative-coefficient certificate **after shifting to its first admissible rank**, each with a strictly positive constant term ($616$, $48$, $7200$, $114$, $3696$, $2192$, $236$, $84$)"*. The eighth constant is Type II, shifted to $\dim\mathfrak g=6$.
2. **Exhibited.** $84=6\cdot(3\cdot36-17\cdot6+8)=6\cdot14$, i.e. $P$ at $n=6$. **No compact simple Lie algebra has dimension $6$** (the dimensions run $3,8,10,14,15,21,21,24,28,\dots$) so $84$ is the value of $P$ at no symmetric space at all. The genuine first Type II member of rank $\ge2$ is $SU(3)$, $\mathfrak g=\mathfrak{su}(3)$, $n=8$, where $P=8(192-136+8)=512$. Nor is the shift a rank shift: $\dim\mathfrak g\ge6$ is a dimension condition, and the rank-$1$ member $\mathfrak{su}(2)$ is excluded by $\dim=3<6$ rather than by rank.
3. **Argued the opposite.** The certificate proves $P>0$ for every integer $n\ge6$, a strict superset of $\{\dim\mathfrak g:\mathfrak g\text{ compact simple},\ \mathrm{rank}\ge2\}$, so the *conclusion* is untouched and the shift is sound as a relaxation. The block's prose is what is wrong, not the mathematics.

**Verdict: real, cosmetic.** The same relaxation appears at BDI, whose base point $\mathrm{Gr}_{\mathbb R}(2,2)=SO(4)/(SO(2)\times SO(2))$ is rank $2$ but **not irreducible** (its isotropy representation $\mathbb R^2\otimes\mathbb R^2$ splits) so the constant $48$ is likewise attained outside the quantifier. Sound as a superset; the words "its first admissible rank" claim more than is true for two of the eight rows.

### D3. "Mostly by an order of magnitude" is false for the twelve exceptional spaces

1. **Located.** [problem.md:231](../findings/problem.md#L231): *"the twelve exceptional spaces check directly, **mostly by an order of magnitude**"*.
2. **Exhibited.** All twelve, by hand, as $\dim\mathfrak h$ against $\frac{3n^2(n-1)}{2(7n-4)}$ with $n=\dim\mathfrak g-\dim\mathfrak h$:

| space | $n$ | $\dim\mathfrak h$ | bound | ratio |
| --- | --- | --- | --- | --- |
| EI $E_6/Sp(4)$ | 42 | 36 | $216972/580=374.09$ | 10.4 |
| EII $E_6/(SU(6)\!\times\!SU(2))$ | 40 | 38 | $187200/552=339.13$ | 8.9 |
| EIII $E_6/(SO(10)\!\times\!SO(2))$ | 32 | 46 | $95232/440=216.44$ | 4.7 |
| EIV $E_6/F_4$ | 26 | 52 | $50700/356=142.42$ | 2.7 |
| EV $E_7/SU(8)$ | 70 | 63 | $1014300/972=1043.52$ | 16.6 |
| EVI $E_7/(SO(12)\!\times\!SU(2))$ | 64 | 69 | $774144/888=871.78$ | 12.6 |
| EVII $E_7/(E_6\!\times\!SO(2))$ | 54 | 79 | $463644/748=619.85$ | 7.8 |
| EVIII $E_8/SO(16)$ | 128 | 120 | $6242304/1784=3499.05$ | 29.2 |
| EIX $E_8/(E_7\!\times\!SU(2))$ | 112 | 136 | $4177152/1560=2677.66$ | 19.7 |
| FI $F_4/(Sp(3)\!\times\!SU(2))$ | 28 | 24 | $63504/384=165.38$ | 6.9 |
| FII $F_4/SO(9)=\mathbb{OP}^2$ | 16 | 36 | $11520/216=53.33$ | **1.48** |
| G $G_2/SO(4)$ | 8 | 6 | $1344/104=12.92$ | 2.15 |

**All twelve clear the bound**, the substantive claim is confirmed, and the record's own $E_8/SO(16)$ figure "$120$ against a bound of $3499$" reproduces exactly. But only $5$ of $12$ clear it by a factor $\ge10$. **$\mathbb{OP}^2$, the one rank-one space the lemma is asked to carry, is the tightest of all at $36$ against $53\tfrac13$**, a $48\%$ margin, not an order of magnitude, and the brief was right to single it out as the edge of the range.
3. **Argued the opposite.** "Mostly" could be read loosely as "with room to spare in most cases", which is true. It cannot be read as "most clear an order of magnitude", which is what the words say and which is false.

**Verdict: real, cosmetic.** Replace with the margin at the tightest case.

### D4. The residue pointer names results that do not carry the residue

1. **Located.** [results.md:535](../results.md#L535): *"The rank-one spaces other than $\mathbb{OP}^2$ are the families of Lemmas 10 and 38."*
2. **Exhibited.** The rank-one residue is $\{S^n,\mathbb{RP}^n,\mathbb{CP}^m,\mathbb{HP}^m\}$. [Lemma L10](../results.md#L128) carries $\mathbb{CP}^m$ with $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$; [Lemma L38](../results.md#L162) carries the same $\mathbb{CP}^m$ family plus the Kähler family of $(\mathfrak{su}(m),\mathfrak{so}(m))\subset\mathfrak{so}(2m)$ at $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$, which is **not** $\mathbb{HP}^m$: at $m=2$ it gives $\tfrac32$, whereas $\theta^2(\mathbb{HP}^2)=\tfrac{56}{45}$. **So neither result carries $\mathbb{HP}^m$, and neither carries $S^n$ or $\mathbb{RP}^n$.** The $\mathbb{HP}^m$ family is on the record under [Observation L5](../results.md#L318), *"quaternionic-Kähler operators on $\mathbb{HP}^m$, with $\sup_m\theta=\sqrt{56/45}$ proved for every $m$"*, a result L47's pointer does not name.
3. **Argued the opposite.** Read as "the $\mathbb{CP}^m$ half of the residue is L10 and L38", the sentence is true. Read as written (*"the rank-one spaces other than $\mathbb{OP}^2$ are"*), it is a claim of exhaustiveness about a two-element pointer that misses half the residue.

**Verdict: real.** Repair: name [L5](../results.md#L318) for $\mathbb{HP}^m$, and say explicitly that $S^n$ and $\mathbb{RP}^n$ are excluded by $W=0$ rather than covered by a family.

### D5. Symbol collisions, answered by name

- **$\mathfrak h$.** [conventions.md](../findings/conventions.md) tables it as $E_{\max}$, the maximal-eigenvalue eigenspace at a critical point. L47 uses it for the isotropy/holonomy algebra throughout, a sense **not in the table**. The two coexist inside [problem.md](../findings/problem.md). **Real, and the table is the thing to fix.**
- **$c$, and the word "centre".** The block says *"makes the centre constant universal at $c=\frac1{2(n-1)}$"*. That $c$ is the coefficient of $I$ in $R=cI+W$, i.e. $\operatorname{tr}R/N$. But "the centre" in Prop 2.2 (cited two lines later, and the source of the eigenvalue data), is $\mathfrak h_0$, the centre of $\mathfrak h$, whose eigenvalue is $\tfrac12$, not $c$. **Two different centres and two different constants under one phrase.** They collide numerically at the equality case: at $\mathbb{CP}^2$, $c=\tfrac16$ and the $\mathfrak{su}(2)$-block eigenvalue is also $\tfrac16$, so the worked example cannot distinguish them. **Real.**
- **$\lambda$.** Three senses in one block: the Einstein constant ($=\tfrac12$), the eigenvalue in $Q(W)=\lambda W$ (identified with the first by L46, that identification is L46's content, not a convention), and $\lambda_i$, the curvature-operator eigenvalues on the blocks. The third is the one Prop 2.2 supplies and is unrelated to the other two. **Real; readable from context, but only just.**
- **$R$.** Used for the curvature operator on $\Lambda^2$ throughout, consistently. The source uses the same letter for the $(0,4)$-tensor and for the operator, distinguished by argument count. **No defect found.**
- **$B$.** [conventions.md](../findings/conventions.md) tables $B=\tfrac\theta2\mathrm{Id}-L_W$ and warns it is *"a third object under the letter $B$"*. Inside [problem.md](../findings/problem.md) it additionally carries L46's trilinear form $B(X,Y,Z)=\langle X\circ Y,Z\rangle$ and L48's partition constant $B=\sum_af(n_a)-\frac n{8(n-1)}$, and Petersen–Stanfield's $B_{\mathfrak g}$, $B_{\mathfrak h}$ are Killing forms. **L47's own block uses none of them**, so no defect reaches this lemma; recorded because the brief named it.

### D6, withdrawn. "The Cauchy–Schwarz step needs the blocks to be pairwise inequivalent"

I pursued this because Prop 2.2's proof asserts *"each of the modules $\mathfrak h_i$, $i\ge1$ are pairwise inequivalent as $\mathrm{Ad}(H)$ representations"* without proof, and the paper itself then notes a case cutting against it, $SO(8)/(SO(4)\times SO(4))$, *"only one nonzero eigenvalue despite the fact that the holonomy algebra has four irreducible factors"*. **Withdrawn at step 2: I could not exhibit a failure, because L47 does not consume that clause.** §2 shows the Cauchy–Schwarz step needs only $\operatorname{im}R\subseteq\mathfrak h$ and $\operatorname{tr}R=n/4$; whether the $\mathfrak h_i$ are inequivalent, and whether the $\lambda_i$ are distinct, is irrelevant to the inequality. Any weakness in Prop 2.2's Schur argument is a weakness in a statement L47 cites but does not use.

### D7, withdrawn. "The certificates are proved for real parameters and consumed at integers"

The shifts substitute $p=2+a$ etc. with $a,b$ declared non-negative integers, and the conclusion $P>0$ then follows from non-negative coefficients for all **real** $a,b\ge0$, a superset of the integers. **Withdrawn at step 2: the direction of the relaxation is favourable**, so no failure can be exhibited. Had the certificate needed integrality it would have been a defect; it does not.

## 8. The residue, checked cold

**I re-derived both closed forms from Props 2.1–2.2 without using the record's, and both match exactly.**

**$\mathbb{CP}^m$.** $n=2m$, $\mathfrak h=\mathfrak u(m)=\mathfrak u(1)\oplus\mathfrak{su}(m)$, so the centre carries $\tfrac12$ with multiplicity $1$ and $\mathfrak{su}(m)$ carries $\lambda$ with multiplicity $m^2-1$. Prop 2.2's trace identity gives $\tfrac12+(m^2-1)\lambda=\tfrac n4=\tfrac m2$, so $\lambda=\frac{m-1}{2(m^2-1)}=\frac1{2(m+1)}$, in $[0,\tfrac12]$ as their Theorem A requires. Then

$$\lVert R\rVert^2=\tfrac14+\frac{m^2-1}{4(m+1)^2}=\frac{(m+1)+(m-1)}{4(m+1)}=\frac m{2(m+1)},\qquad \lVert W\rVert^2=\frac m{2(m+1)}-\frac m{4(2m-1)}=\frac{3m(m-1)}{4(m+1)(2m-1)} .$$

At $m=2$ this is $\frac6{36}=\tfrac16$, **the equality case, confirmed**. It is strictly increasing on $m\ge2$: writing $\lVert W\rVert^2=\tfrac34\cdot\frac{m^2-m}{2m^2+m-1}$, the derivative's numerator is $(2m-1)(2m^2+m-1)-(m^2-m)(4m+1)=3m^2-2m+1>0$. So $\tfrac16$ is the strict minimum over $m\ge2$, attained only at $\mathbb{CP}^2$. **PROVEN.** ($m=1$ returns $0$, consistent with $\mathbb{CP}^1=S^2$.)

**$\mathbb{HP}^m$.** $n=4m$, $\mathfrak h=\mathfrak{sp}(1)\oplus\mathfrak{sp}(m)$, both simple, no centre, so the trace identity alone does not determine the two eigenvalues and Prop 2.1's operator $P$ is needed. With $B_{\mathfrak{sp}(k)}=(2k+2)\,\mathrm{Re}\operatorname{tr}$ and $\mathfrak g=\mathfrak{sp}(m+1)$, so $B_{\mathfrak g}|_{\mathfrak h}=(2m+4)\,\mathrm{Re}\operatorname{tr}$,

$$\lambda_{\mathfrak{sp}(m)}=\tfrac12\Bigl(1-\tfrac{2m+2}{2m+4}\Bigr)=\frac1{2(m+2)},\qquad \lambda_{\mathfrak{sp}(1)}=\tfrac12\Bigl(1-\tfrac4{2m+4}\Bigr)=\frac m{2(m+2)} .$$

**The trace check passes independently:** $3\cdot\frac m{2(m+2)}+m(2m+1)\cdot\frac1{2(m+2)}=\frac{m(2m+4)}{2(m+2)}=m=\tfrac n4$. Then

$$\lVert R\rVert^2=\frac{3m^2+m(2m+1)}{4(m+2)^2}=\frac{m(5m+1)}{4(m+2)^2},\qquad \lVert W\rVert^2=\frac{m(5m+1)}{4(m+2)^2}-\frac m{2(4m-1)} .$$

The bracket is $\frac{(5m+1)(4m-1)-2(m+2)^2}{4(m+2)^2(4m-1)}$ with numerator $20m^2-m-1-2m^2-8m-8=18m^2-9m-9=9(2m+1)(m-1)$, giving

$$\lVert W\rVert^2(\mathbb{HP}^m)=\frac{9m(m-1)(2m+1)}{4(m+2)^2(4m-1)},\qquad\text{so}\qquad \theta^2=\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)} ,$$

**which is the record's closed form character for character.** At $m=2$: $\lVert W\rVert^2=\frac{9\cdot2\cdot1\cdot5}{4\cdot16\cdot7}=\frac{90}{448}=\frac{45}{224}$ (**the record's minimum, confirmed**) and $\theta=\sqrt{56/45}=1.1155467$, matching the record's independently computed $\mathbb{HP}^2$ value at [graded-half.md](../findings/graded-half.md) to every printed digit. Monotonicity: $\lVert W\rVert^2$ takes $\tfrac{45}{224},\ \tfrac{189}{550},\ \tfrac9{20}$ at $m=2,3,4$, increasing toward $\tfrac98$; the record's derivative certificate $N'D-ND'=-9(m+2)(34m^3-12m^2+3m+2)$ is negative for $m\ge1$ since $34m^3-12m^2=m^2(34m-12)>0$ there. And $\tfrac{45}{224}>\tfrac16$ strictly, since $45\cdot6=270>224$. **PROVEN.** ($m=1$ is singular, consistent with $\mathbb{HP}^1=S^4$.)

**Is the residue exhaustive?** The compact rank-one symmetric spaces are $S^n$, $\mathbb{RP}^n$, $\mathbb{CP}^m$, $\mathbb{HP}^m$, $\mathbb{OP}^2$. Removing the rank-$\ge2$ branch and $\mathbb{OP}^2$ leaves exactly the four the block names, **and the accounting closes from the same family list that supplies the certificates**: $S^n,\mathbb{RP}^n$ arise as BDI $p=1$, AI $m=2$, AII $m=2$, CI $m=1$ and Type II $\dim\mathfrak g=3$; $\mathbb{CP}^m$ as AIII $p=1$ and DIII $m=3$; $\mathbb{HP}^m$ as CII $p=1$; $\mathbb{OP}^2$ as FII. No family contributes a rank-one member outside those. **The overlap is benign in the one place it occurs**: $\mathbb{HP}^m$ for $m\ge3$ satisfies the dimension bound too, at $m=3$, $h=24$ against $\frac{6\cdot9\cdot11}{20}=29.7$, so the two routes agree where they meet, and only $\mathbb{HP}^2$ genuinely needs the closed form.

**Two machinery checks that fall out for free, and both agree with the record.** $\mathrm{Gr}_{\mathbb R}(2,2)$: $\mathfrak h=\mathfrak{so}(2)^{\oplus2}$ is all centre, so both eigenvalues are $\tfrac12$, $\operatorname{tr}R=1=n/4$, $\lVert R\rVert^2=\tfrac12$, $\lVert W\rVert^2=\tfrac12-\tfrac16=\tfrac13$ and $\theta=\tfrac{\sqrt3}2$, the record's $n=4$ value for $W_{S^2\times S^2}$. $SU(3)/SO(3)$, the smallest genuinely irreducible rank-$2$ space: $n=5$, $h=3$, $\lambda=\tfrac5{12}$, $\lVert W\rVert^2=\tfrac{25}{48}-\tfrac5{32}=\tfrac{35}{96}>\tfrac16$, with the dimension bound $\tfrac{300}{62}=4.839$ against $h=3$, the tightest classical base case, and it clears.

## 9. The edge of every range

- **Rank exactly $2$.** Every classical shift lands on rank $2$ (AIII/BDI/CII at $p=2$, AI/AII at $m=3$, DIII at $m=4$ (rank $\lfloor m/2\rfloor$), CI at $m=2$), **except Type II** (D2). The DIII shift is right: $m=3$ gives $SO(6)/U(3)=\mathbb{CP}^3$, rank one, correctly routed to the residue.
- **The smallest $n$.** $n=4$ (BDI $p=q=2$, where $\dim\mathcal W_4=10$) and $n=5$ (AI $m=3$), both computed above and both clear. At $n=3$, $\mathcal W_3=0$; the only symmetric spaces there are $S^3$ and $\mathbb{RP}^3$, in the residue.
- **Odd $n$.** $n=5,9,15,\dots$ occur throughout the census. **Nothing in L47 has a parity in it**, $\theta_0(n)$ and $\Theta_n$, the two quantities [conventions.md](../findings/conventions.md) flags as parting at odd $n$, appear nowhere in this lemma. The parity trap bites [L48](../findings/problem.md) and [L44](../findings/problem.md), not this one. **No defect found.**
- **$\mathbb{OP}^2$.** Kept because it is rank one and lies in neither closed-form family; carried by the exceptional list at $36\le53\tfrac13$. It is the tightest of all twelve (D3), and $\lVert W\rVert^2=\tfrac{14}{45}=0.3111$, comfortably above $\tfrac16$.
- **A claim proven on a subfamily and used in general.** I looked for this specifically, the proof being family-by-family. **The direction is favourable everywhere I checked**: each certificate proves $P>0$ on a continuum strictly containing its family's parameter set (D7), the BDI row's base point is a reducible space outside the quantifier (D2), and the Type II row's base point is a dimension no algebra attains (D2). **No instance found of a subfamily result used beyond its subfamily.**

## 10. What a consumer may cite for the completeness of L47's index set

**This is the load-bearing external dependency, and the honest answer is: nothing on file proves it.**

- [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/notes.md) Ch. 8 is the only source on the record that prints both the classical families and all twelve exceptional pairs. Its notes record its own limit verbatim: *"We shall not prove here that every possible Vogan diagram gives a simple real Lie algebra, although this is true."* **So completeness is asserted there, not proved.** The notes also warn that the $\mathfrak{so}(2n)$ pairs are split across §2.1 and §2.3, so a reader stopping at the first half sees an incomplete list, I checked that this does not bite L47, whose BDI row is parametrised by $(p,q)$ with no parity condition.
- [Yokota](../references/yokota-2009-exceptional-lie-groups/notes.md) supplies the twelve exceptional pairs with their global isotropy groups, and its notes are explicit: *"Cite it for 'these twelve are symmetric pairs and here is what the isotropy group is'; cite Cartan's classification, not this book, for 'there are no others.'"*
- **Neither source carries a single dimension.** Both notes say so. So the arithmetic of §7's twelve-row table (every $\dim\mathfrak g$ and $\dim\mathfrak h$ in it), is supplied by the record itself and by nothing cited. I checked all twenty-four integers against the standard values and they are right, but **that check is mine, not a citation.**
- **[conventions.md](../findings/conventions.md)'s designated pointer does not serve this lemma.** It says *"[L159](../findings/graded-half.md) is the record's own statement of [Cartan's classification] and is what a consumer cites"*. [L159](../findings/graded-half.md#L516) is a statement about **the involutions of the compact $\mathfrak{so}(n)$**, the BDI and DIII rows only. L47's index set ranges over every compact simple $\mathfrak g$ and over Type II as well, and L159 says nothing about $\mathfrak{su}$, $\mathfrak{sp}$ or the exceptional algebras. **A consumer following the convention's instruction gets a proper subset of what L47 quantifies over.**

**Recorded as `HYPOTHESIS-DEBT`.** The classification is standard mathematics and I am not disputing it; what the record cannot presently do is point a reader at a proof of it, and its own designated pointer points at the wrong statement.

## 11. An imported theorem whose hypotheses were never checked, answered

The brief names this trap and cites the route that died on a unital-algebra hypothesis. **Here the imports are Petersen–Stanfield Props 2.1/2.2 and [L46](../findings/problem.md), and I checked both against the objects.** Props 2.1/2.2 require $G$ compact semisimple and $H$ the identity component of an involution's fixed set, with the metric $-B_{\mathfrak g}|_{\mathfrak p}$, all three hold for every Type I and Type II member, verified in §3, and irreducibility is not among them. L46 requires locally symmetric, Einstein, $\lambda\ne0$, $\lambda=\tfrac12$, all four hold, with $\lambda=\tfrac12$ by the same normalisation. **No hypothesis mismatch found.** The one citation defect is directional, not substantive: Prop 2.2 is cited where Prop 2.1 is used (§2), and L46 is cited at the norm identity where it belongs at the $\theta$ conversion (§5).

## 12. A universal claim with no witness, answered

Two universals in the block are asserted with no instance written down anywhere in [findings/](../findings/): *"each classical family reduces to a polynomial positivity statement with an all-nonnegative-coefficient certificate"* and *"the twelve exceptional spaces check directly"*. **Both are true**, I supplied witnesses for the second in full (§7 D3) and for four of eight rows of the first (§6), **and neither had a witness on the record.** The exceptional table above and the eight-row table in §6 are the first written instances I could find; the script computes them and prints a verdict without recording them.

## The verdict

**GAP.**

Everything L47 asserts numerically is correct, and I re-derived the load-bearing parts cold: the Cauchy–Schwarz step, the dimension bound's algebra, all eight certificate constants, all twelve exceptional checks, and both residue closed forms with their minima. Petersen–Stanfield Prop 2.2 says what is claimed and its hypotheses hold. The lemma is, as far as I can tell, **true**.

What is missing is the proof of its principal clause. The rank-$\ge2$ branch (the entire content of the lemma), rests on eight polynomial positivity certificates that are written nowhere on the record in any form a reader can check, and the canonical block does not even link the script that computes them. Alongside that sit one false universal ($S^n$ falsifies the concluding statement as written, D1), two inaccurate descriptions of the certificates (D2, D3), a false residue pointer (D4), three untabled symbol collisions (D5), and a classification whose completeness the record can cite no proof of and whose designated pointer covers only $\mathfrak{so}(n)$ (§10).

**What is owed, in order of weight:**

1. **The eight expansions in prose**, or one written argument that replaces them, with each family named against its constant. Four are in §6 above and can be lifted.
2. **$W\ne0$ added to both concluding universals**, at [problem.md:231](../findings/problem.md#L231) and [graded-half.md:122](../findings/graded-half.md#L122). No value changes.
3. **The residue pointer repaired** to name [L5](../results.md#L318) for $\mathbb{HP}^m$ and to say that $S^n$, $\mathbb{RP}^n$ are excluded rather than covered.
4. **$\mathfrak h$ tabled in its isotropy sense** in [conventions.md](../findings/conventions.md), and the two "centres" of §D5 separated.
5. **The Type II and BDI shift descriptions corrected**, and "mostly by an order of magnitude" replaced with the $\mathbb{OP}^2$ margin.
6. **The L46 citation moved** from the norm identity to the $\theta$ conversion, and Prop 2.1 cited alongside Prop 2.2.

## What would break it, and what I did to look for it

**The object that would falsify L47 is a compact irreducible symmetric space of rank $\ge2$, or $\mathbb{OP}^2$, with $0<\lVert W\rVert^2<\tfrac16$**, equivalently, by §4, one whose isotropy algebra is large relative to its dimension, $\dim\mathfrak h>\frac{3n^2(n-1)}{2(7n-4)}$, *and* which then fails the inequality outright rather than merely escaping the sufficient condition. A second falsifier would be a **second equality case**: a space other than $\mathbb{CP}^2$ with $\lVert W\rVert^2=\tfrac16$ exactly.

**What I did, all by hand and with no search:**

- **Computed the ratio $\dim\mathfrak h/\text{bound}$ at every space I could name in closed form.** The only spaces I found exceeding the bound are $\mathbb{CP}^m$ (at every $m$, §2), $\mathbb{HP}^2$ at $13$ against $\tfrac{168}{13}$, and $\mathfrak{so}(n/2)^{\oplus2}$, the isotropy of the balanced sphere product, which is **reducible** and so outside this lemma's quantifier. All three are rank one or reducible; **none is a falsifier, and all three satisfy the conclusion** ($\mathbb{CP}^m\ge\tfrac16$ with equality at $m=2$; $\mathbb{HP}^2$ at $\tfrac{45}{224}$).
- **Checked the tightest members of each branch**: $SU(3)/SO(3)$ at $n=5$ (the smallest irreducible rank-$2$ space, $h=3$ against $4.839$), $G_2/SO(4)$ ($6$ against $12.92$), $\mathbb{OP}^2$ ($36$ against $53.33$, the tightest of the twelve), and Type II at its threshold $3n^2-17n+8\ge0$ with root $\frac{17+\sqrt{193}}6=5.1487$, against the true first rank-$2$ member $\mathfrak{su}(3)$ at $n=8$. **All clear, none marginally.**
- **Searched the residue for a second equality case** by proving strict monotonicity of both closed forms ($3m^2-2m+1>0$ for $\mathbb{CP}^m$, and $m^2(34m-12)>0$ for $\mathbb{HP}^m$) so each family has a unique minimum, at $m=2$ in both, and only the $\mathbb{CP}^m$ one equals $\tfrac16$. **No second equality case exists in the residue.**
- **Looked for a falsifier at the boundary of the certificates**, i.e. a family member below its shift point: BDI $p=q=2$ (reducible, still clears at $\lVert W\rVert^2=\tfrac13$), DIII $m=3$ ($=\mathbb{CP}^3$, rank one, clears at $\tfrac9{40}$), Type II $\dim=3$ ($=S^3$, $W=0$). **The last of these is the one object that falsifies the lemma's concluding universal as written**, which is D1.

**What I did not do**, per the standing rule: I ran no search over the classification, no sweep over $(p,q)$ or $m$, no script, and nothing numerical. **Every value in this report is exact and was obtained by hand.** A falsifier outside the named families would have to be a compact irreducible symmetric space absent from Cartan's list, which is precisely the completeness question §10 records as undischarged on file.
