# Verifier v78, L87's orbit-Gram squeeze: the cap $3570$, the mod-$p$ lower bound, and the three conclusions drawn from their meeting

**The brief was cold** and named the step without naming a property to look for; I worked from the definitions at source in [findings/sym3-blocks.md](../findings/sym3-blocks.md), [findings/conventions.md](../findings/conventions.md) and [findings/INDEX-results.md](../findings/INDEX-results.md), and read [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage), [r173_orbit_span.py](../scripts/reviewers/r173/r173_orbit_span.py), [r173_pseudovector_covariant.py](../scripts/reviewers/r173/r173_pseudovector_covariant.py) and [orbit_cubic_span.py](../scripts/reviewers/r203/orbit_cubic_span.py) as text. **I did no numerical work of any kind, no script was run, no Sage, no numerics, and I wrote none. Every value below is exact and was obtained by hand.** Log: [agent_logs/verify-L87-v78.log](../agent_logs/verify-L87-v78.log).

## The claim table

| # | claim, as the record states it | verdict | reason |
|---|---|---|---|
| C1 | the computed object is the Gram $\langle g_aW_0,g_bW_0\rangle^3$ over $3700$ orbit points over $\mathbb F_{46337}$ | **CONFIRMED** | [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) forms exactly that matrix; $46337$ is prime, so "rank" is defined |
| C2 | its rank is exactly $3570$ | **CONFIRMED AS ALGEBRA** | exact row reduction over a finite field, no tolerance anywhere; the value is a machine reading I neither reproduced nor may, and **no stored output of the run exists on the record** |
| C3 | $3570=\sum_\lambda d_\lambda$ over the $\lambda_2$-even blocks, and there are sixteen of them | **CONFIRMED** | all sixteen dimensions re-derived from Weyl's $B_2$ formula and summed by hand |
| C4 | *"using $\dim V_\lambda^H\le1$"* establishes that cap | **REFUTED AS STATED** | that hypothesis alone caps at $5640$; §4 exhibits a closed-form profile hitting $3570$ with twelve even blocks at rank $0$ |
| C5 | *"a mod-$p$ rank is a lower bound for the characteristic-zero span"*, as applied here | **HYPOTHESIS-DEBT** | the $g_a$ are drawn inside $\mathbb F_{46337}$; the characteristic-zero matrix the inequality needs is never formed, and no $p$-integral lift is on file |
| C6 | *"the span is exactly $3570$"* | **HYPOTHESIS-DEBT** | unproved under **both** readings of "the span", §6.1 |
| C7 | *"every one of the sixteen evaluation maps is nonzero"* | **HYPOTHESIS-DEBT** overall; **CONFIRMED** for $(0,0)$ and $(1,0)$ | the inference from C6 is valid; C6 is owed. Two of the sixteen have hand witnesses, §6.2 |
| C8 | *"every even block loses exactly one multiplicity"* | **CONFIRMED AS ALGEBRA** | rank–nullity on C7, correct; inherits C7's debt in full |
| C9 | the headline *"SETTLED, AND THE RANK IS NOW PROVED RATHER THAN MEASURED"* | **REFUTED AS STATED** | the rank is one unreplicated machine reading; what is proved is the cap |
| C10 | *"$174$'s 'measured' $3570$ is independently reproduced"* | **REFUTED** | [r174](../reviews/REVIEW_r174.md) **derived** the cap and measured nothing; [r170](../reviews/REVIEW_r170.md) measured; and [r178](../reviews/REVIEW_r178.md) knew the target number before running |
| C11 | [results.md:23](../results.md)'s promotion of L87's rank to *"proofs rather than measurements"* | **REFUTED AS STATED** | the sentence's premise is exactly C5, which for L87 has no argument on file |

## The one-line summary

**The cap $3570$ is a theorem and I re-derived every digit of it; the number that meets it is one exact finite-field rank whose connection to characteristic zero is asserted in a single clause and argued nowhere, so all three conclusions stand on a hypothesis the record has never written down, while the block's stated ground for the cap is separately too weak, giving $5640$, at which the squeeze does not close.**

## 0. Conventions, fixed once

Quoted from the brief rather than restated:

- $\mathcal W_5$: algebraic Weyl curvature operators at $n=5$, the $O(5)$-irreducible $[2,2]$, dimension $35$.
- $W_0$: the zero-padding into $\mathcal W_5$ of the $\mathbb{CP}^2$ Weyl operator; $g_aW_0$ are points of its $O(5)$-orbit.
- The blocks are the $O(5)$-constituents of $\mathrm{Sym}^3\mathcal W_5$; $\lambda_2$ is the second part of the highest weight; $d_\lambda$ is a constituent's dimension; $V_\lambda^H$ is the subspace fixed by the stabiliser $H$ of $W_0$.

**Two readings the record admits, and the one I adopt.** The weight labels are $e$-basis, not $\omega$-basis: [sym3-blocks.md:19](../findings/sym3-blocks.md) records both reviewers deriving $\dim V_{(a,b)}=\tfrac16(2a{+}3)(2b{+}1)(a{-}b{+}1)(a{+}b{+}2)$, which reproduces the table's subscripts only in the $e$-basis. I use the $e$-basis throughout, and $\lambda_2$ is that basis's second entry. The prose eight lines above the table is $\omega$-basis, and the file does not mark the switch. Second, "the span" in the conclusion is unqualified; §6.1 takes both readings.

## 1. Hypothesis inventory

**What the statement carries, what it needs, and where each is stated.** The statement's whole visible hypothesis set is *"using $\dim V_\lambda^H\le1$"*; everything else in this table is used and unstated in L87.

| # | hypothesis | checked against the object | stated where | used by the written proof? |
|---|---|---|---|---|
| H1 | $n=5$; $\mathcal W_5$ is the $O(5)$-irreducible $[2,2]$, $\dim 35$ | holds; the file's own §*The Weyl module* pins the highest weight at $4\omega_2$ by Casimir $16$ against $12$ | [sym3-blocks.md:5](../findings/sym3-blocks.md), not in L87 | yes, silently, the cap is a sum over $\mathrm{Sym}^3\mathcal W_5$'s constituents |
| H2 | $W_0\in\mathcal W_5$: symmetric on $\Lambda^2$, first Bianchi, Ricci-traceless | holds, §5.2 checks Bianchi and Ricci-flatness by hand at the script's $W_0$. **The run never checks it**: [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) prints symmetry, trace and two eigenvector relations only | nowhere; [conventions.md:44](../findings/conventions.md) records $W_0$ as *"defined nowhere in findings/"* | yes, if $W_0\notin\mathcal W_5$ the cap is a cap on the wrong module |
| H3 | $H=\mathrm{Stab}_{O(5)}(W_0)$ fixes $W_0$, hence fixes $W_0^{\otimes3}$ | holds trivially once $H$ is defined as the stabiliser | [conventions.md:44](../findings/conventions.md), which calls it *"the load-bearing step"* and records it as unstated in [findings/](../findings/) | yes, it is what puts the $\lambda$-component of $W_0^{\otimes3}$ in $M_\lambda\otimes V_\lambda^H$ |
| H4 | [L83](../findings/sym3-blocks.md)'s list of the $24$ constituents and their dimensions is complete and correct | the sixteen even dimensions re-derived in §3; completeness of the list is L83's, graded `GAP` with the multiplicity column untested | [sym3-blocks.md:33](../findings/sym3-blocks.md); **uncited by L87** | yes, an extra even constituent would raise the cap |
| H5 | [L86](../findings/sym3-blocks.md)'s **full** parity rule: $\dim V_\lambda^H=1$ iff $\lambda_2$ even, so $=0$ at odd $\lambda_2$ | holds as L86 proves it; L87 offers only the $\le1$ half | [sym3-blocks.md:112](../findings/sym3-blocks.md); **uncited by L87** | **needed and not supplied**, this is C4 |
| H6 | complete reducibility of $\mathrm{Sym}^3\mathcal W_5$ and Frobenius reciprocity for the compact pair $(O(5),H)$ | hypotheses hold: $O(5)$ compact, $H$ closed, characteristic zero, finite-dimensional | [sym3-blocks.md:120](../findings/sym3-blocks.md) under L86; not in L87 | yes, it is what converts $\dim V_\lambda^H\le1$ into $r_\lambda\le1$ |
| H7 | $\dim\langle O(5)\cdot W_0^{\otimes3}\rangle=\sum_\lambda r_\lambda d_\lambda$, $r_\lambda=\operatorname{rank}(\mathrm{ev}_\lambda)$ | correct; §2 gives the argument the record asserts without one | asserted at [sym3-blocks.md:120](../findings/sym3-blocks.md); not in L87 | yes, as the bridge between "span" and "evaluation maps" |
| H8 | $\langle x^{\otimes3},y^{\otimes3}\rangle=\langle x,y\rangle^3$ | holds for the tensor-power form; it is what makes the computed matrix a Gram of cubes | the script's header and [r173_orbit_span.py](../scripts/reviewers/r173/r173_orbit_span.py)'s docstring; **nowhere in [findings/](../findings/)** | yes, without it the object measured is not the object capped |
| H9 | $\operatorname{rank}(\text{Gram})\le\dim\operatorname{span}$ over any field, with equality over $\mathbb R$ for a definite form | holds; over $\mathbb F_p$ the inequality can be strict, which is the safe direction here | nowhere | yes |
| H10 | $46337$ is prime | **holds**, §5.3, by hand | nowhere | yes, "rank over $\mathbb F_{46337}$" presupposes a field |
| H11 | each sampled $g_a\in SO(5,\mathbb F_p)$ is the reduction of a $p$-integral $\tilde g_a\in O(5,\mathbb Q)$ | **not checked, because it is not on the record** | **nowhere** | **yes, this is the whole of C5** |

**A hypothesis stated and not used.** The count $3700$ is stated in the headline and does no work in the argument: nothing about the sample size enters the inference, which needs only that the observed rank equals the cap. It is a reported parameter, not a hypothesis, and §5.1 records that it sits only $130$ above the cap.

**Steps using a hypothesis never stated.** H2, H3, H6, H7, H8, H9, H10 and H11 are all consumed by the four sentences of L87 and none is stated in them. H5 is consumed in a form strictly stronger than the form stated. **The block contains no markdown links at all**, [r681](../reviews/REVIEW_r681.md) records the same, so a reader cannot reach L83, L86, or the script from it.

## 2. What the cap is a cap **on**, derived

The record never says. It is a cap on

$$\dim_{\mathbb R} U,\qquad U:=\text{the }O(5)\text{-submodule of }\mathrm{Sym}^3\mathcal W_5\text{ generated by }W_0^{\otimes3},$$

equivalently the linear span of the cubic Veronese image of the whole orbit, since the span of a $G$-orbit of a vector is the module it generates.

Write $\mathrm{Sym}^3\mathcal W_5=\bigoplus_\lambda M_\lambda\otimes V_\lambda$ with $G=O(5)$ acting on the $V_\lambda$ alone (H1, H6). Decompose $W_0^{\otimes3}=\sum_\lambda v_\lambda$, $v_\lambda\in M_\lambda\otimes V_\lambda$, and let $r_\lambda$ be the tensor rank of $v_\lambda$, i.e. $\dim$ of the minimal $N_\lambda\subseteq M_\lambda$ with $v_\lambda\in N_\lambda\otimes V_\lambda$. Because every $G$-submodule of $N_\lambda\otimes V_\lambda$ has the form $N'\otimes V_\lambda$, the module generated by $v_\lambda$ is $N_\lambda\otimes V_\lambda$, of dimension $r_\lambda d_\lambda$. Hence H7:

$$\dim U=\sum_\lambda r_\lambda d_\lambda .$$

$H$ fixes $W_0$ (H3), so $v_\lambda\in(M_\lambda\otimes V_\lambda)^H=M_\lambda\otimes V_\lambda^H$. With $\dim V_\lambda^H\le1$ that forces $r_\lambda\le1$, and with $\dim V_\lambda^H=0$ at odd $\lambda_2$ it forces $r_\lambda=0$ there. So

$$\dim U\ \le\ \sum_{\lambda_2\ \text{even}}d_\lambda .$$

Dually $r_\lambda=\operatorname{rank}(\mathrm{ev}_\lambda)$ for $\mathrm{ev}_\lambda\colon M_\lambda\to V_\lambda^H$ sending a covariant to its value at $W_0$, which is the "evaluation map" of conclusion (b). **None of this paragraph is in L87**; the middle of it is in L86 four lines above, as an assertion.

## 3. The cap re-derived, by the only route the record supports

The route is Weyl's $B_2$ dimension formula on [L83](../findings/sym3-blocks.md)'s constituent list, which is what [r681](../reviews/REVIEW_r681.md) and [r174](../reviews/REVIEW_r174.md) also used. I recomputed every dimension from $\dim V_{(a,b)}=\tfrac16(2a{+}3)(2b{+}1)(a{-}b{+}1)(a{+}b{+}2)$ rather than reading the table.

| $\lambda$ | formula | $d_\lambda$ | | $\lambda$ | formula | $d_\lambda$ |
|---|---|---|---|---|---|---|
| $(6,6)$ | $15\cdot13\cdot1\cdot14/6$ | $455$ | | $(4,2)$ | $11\cdot5\cdot3\cdot8/6$ | $220$ |
| $(6,4)$ | $15\cdot9\cdot3\cdot12/6$ | $810$ | | $(4,4)$ | $11\cdot9\cdot1\cdot10/6$ | $165$ |
| $(6,2)$ | $15\cdot5\cdot5\cdot10/6$ | $625$ | | $(4,0)$ | $11\cdot1\cdot5\cdot6/6$ | $55$ |
| $(6,0)$ | $15\cdot1\cdot7\cdot8/6$ | $140$ | | $(3,2)$ | $9\cdot5\cdot2\cdot7/6$ | $105$ |
| $(5,4)$ | $13\cdot9\cdot2\cdot11/6$ | $429$ | | $(3,0)$ | $9\cdot1\cdot4\cdot5/6$ | $30$ |
| $(5,2)$ | $13\cdot5\cdot4\cdot9/6$ | $390$ | | $(2,2)$ | $7\cdot5\cdot1\cdot6/6$ | $35$ |
| $(5,0)$ | $13\cdot1\cdot6\cdot7/6$ | $91$ | | $(2,0)$ | $7\cdot1\cdot3\cdot4/6$ | $14$ |
| $(1,0)$ | $5\cdot1\cdot2\cdot3/6$ | $5$ | | $(0,0)$ | $3\cdot1\cdot1\cdot2/6$ | $1$ |

Sixteen blocks, and running the sum: $220,255,360,750,915,970,1000,1014,1824,2449,2904,3333,3473,3564,3569,\mathbf{3570}$. **C3 CONFIRMED.**

The eight odd-$\lambda_2$ constituents give $(6,3)_{770}$, $(5,3)_{455}$, $(5,1)_{260}$, $(4,3)_{231}$, $(4,1)_{154}$, $(3,3)_{84}$, $(3,1)_{81}$, $(2,1)_{35}$, summing to $2070$, so all $24$ sum to $5640$. **The $5640$ [r681](../reviews/REVIEW_r681.md) and [r682](../reviews/REVIEW_r682.md) report is right.**

Two corollaries of the same table, checked because the conclusion's downstream numbers use them. Total multiplicity $4\cdot2+3\cdot1+2\cdot9+1\cdot12=41$, so sixteen deletions leave $25$. Unknowns after deletion: two blocks at $m'=3$, five at $m'=2$ (one even, four odd), nine at $m'=1$, eight at $0$, giving $2\binom42+5\binom32+9\binom22=12+15+9=36$, shaped as **two $3\times3$, five $2\times2$ and nine scalars**, which reproduces the record's shape exactly. And $\sum_{\lambda_2\text{ even}}m_\lambda=4+4+3+2\cdot5+1\cdot8=29=65-36$, which is [L86](../findings/sym3-blocks.md)'s Gate 2 tautology and confirms nothing.

## 4. C4, the cap's stated ground, and why $5640$ matters

*"$3570$ is the theoretical cap, $\sum_\lambda d_\lambda$ over the $\lambda_2$-even blocks, using $\dim V_\lambda^H\le1$."*

**1. Located exactly.** [sym3-blocks.md:140](../findings/sym3-blocks.md), second sentence. The hypothesis named is $\dim V_\lambda^H\le1$. The hypothesis that restricts the sum to even blocks ($\dim V_\lambda^H=0$ at odd $\lambda_2$), is [L86](../findings/sym3-blocks.md)'s and is neither stated nor cited.

**2. The failure exhibited concretely.** Under $\dim V_\lambda^H\le1$ alone, $r_\lambda\le1$ for **all** $24$ blocks and the cap is $5640$. A measured $\dim U=3570$ then forces nothing, and here is a closed-form profile witnessing that: take

$$r_\lambda=1\ \text{on all eight odd blocks}\ (2070),\qquad r_\lambda=1\ \text{on}\ (6,4)_{810},\ (6,2)_{625},\ (2,2)_{35},\ (3,0)_{30}\ (1500),$$

and $r_\lambda=0$ on the remaining **twelve** even blocks. Then $\sum r_\lambda d_\lambda=2070+1500=3570$ exactly, every $r_\lambda\le1$, and conclusion (b) (*"every one of the sixteen evaluation maps is nonzero"*), is false at this profile. **So under the stated ground the measured number is consistent with twelve of the sixteen evaluation maps vanishing.**

**3. Arguing the opposite.** The strongest reading available is that *"over the $\lambda_2$-even blocks"* silently carries the parity rule and *"using $\dim V_\lambda^H\le1$"* is offered only as the per-block rank bound. Under that reading the **number** $3570$ is correctly stated and only the citation is missing. I accept that the value is right (C3 is `CONFIRMED`) and grade the sentence on what it claims to establish: the clause as written names the weaker half of a two-part rule and hands a reader a cap of $5640$. **C4 REFUTED AS STATED**, with the repair being one citation, not a number.

## 5. What the measurement is a measurement of

### 5.1 The matrix, read out of [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage)

| item | what the file does |
|---|---|
| ring | `p = 46337`, `F = GF(p)`, and **every object in the file after $W_0$'s three defining vectors lives in $F$**. No floating point, no tolerance, anywhere |
| the point | `W0 = 2*w1'*w1 - w2'*w2 - w3'*w3` on $\Lambda^2\mathbb F_p^5$, with $w_1=e_{01}+e_{23}$, $w_2=e_{02}-e_{13}$, $w_3=e_{03}+e_{12}$, the self-dual $2$-forms of the $\mathbb R^4$ block, so the padding axis is index $4$ |
| the group elements | `A` skew with `F.random_element()` entries, $g=(I-A)(I+A)^{-1}$ **formed inside $F$**, kept only if $\det(I+A)\ne0$ and $gg^{\mathsf T}=I$, so $g\in SO(5,\mathbb F_p)$, the Cayley image being determinant $1$ since $I-A=(I+A)^{\mathsf T}$ |
| the rows | $\Lambda^2g$ in the $10$ wedge coordinates, then $W_a=\Lambda^2g\cdot W_0\cdot(\Lambda^2g)^{\mathsf T}$, flattened to $100$ entries. $M$ is $3700\times100$ |
| the columns of the measured matrix | $K=MM^{\mathsf T}$, whose $(a,b)$ entry is $\sum_{ij}(W_a)_{ij}(W_b)_{ij}=\operatorname{tr}(W_aW_b)=\langle W_a,W_b\rangle$; then **entrywise cubed** |
| the reading | `K.rank()`, exact row reduction over a finite field |

So the object is exactly what the statement says: the $3700\times3700$ Gram $[\langle g_aW_0,g_bW_0\rangle^3]$ over $\mathbb F_{46337}$. **C1 CONFIRMED.** By H8 it is the Gram of the tensor cubes $W_a^{\otimes3}$, and by H9 its rank is a **lower** bound for $\dim_{\mathbb F_p}\operatorname{span}\{W_a^{\otimes3}\}$.

**Three things the file does not do, worth having on the record.** It stores no output, so the value $3570$ is unreachable from the repository, there is no log, no `.txt`, nothing under [scripts/reviewers/r178/](../scripts/reviewers/r178/) but seven source files. It asserts nothing: the last line **prints** the rank beside the string `theoretical cap = 3570` rather than asserting equality, so a run returning $3569$ would not fail. And $N=3700$ is a hardcoded parameter sitting only $130$ above the cap, against a cap of $3570$ and an ambient $\binom{37}3=7770$.

**The exactness is the run's real contribution and neither the script nor the block claims it.** Against [r170](../reviews/REVIEW_r170.md)'s float measurement at three tolerances, this is a categorical improvement in the *arithmetic*, and a categorical loss in the *characteristic*.

### 5.2 The trap named in the brief: $\ker W_0\ne0$

$W_0$ is padded, so as an operator on $\Lambda^2$ it kills the four mixed planes $e_i\wedge e_4$ and the three anti-self-dual forms, a $7$-dimensional kernel out of $10$.

**No step of L87 assumes a trivial kernel, and I checked each.** H7 and H6 are statements about $G$-modules and never invert $W_0$; H8 is an identity of forms; H9 is linear algebra. The one place the kernel does real work is **in L87's favour**: it is what makes $H$ large enough for $\dim V_\lambda^H\le1$ to bite at all. **No finding.**

What the padding *does* threaten is isotropy in characteristic $p$: if $\langle W_0,W_0\rangle$ were $0$ in $\mathbb F_p$ the entire Gram could collapse. With spectrum $(4,-2,-2,0^7)$ on $\Lambda^2$, $\langle W_0,W_0\rangle=\operatorname{tr}(W_0^2)=16+4+4=24$, so every diagonal entry of $K$ is $24^3=13824\ne0$ in $\mathbb F_{46337}$. **Safe, and unremarked anywhere.**

**H2 checked by hand, since the script does not.** With $\{w_1,w_2,w_3\}/\sqrt2$ an orthonormal basis of the self-dual $2$-forms of $\mathbb R^4$ and $|w_i|^2=2$, the script's $W_0$ is $4P_1-2P_2-2P_3$ on the self-dual part and zero elsewhere. Its $\Lambda^4\mathbb R^5$ Bianchi component has only the $\{0,1,2,3\}$ entry, which is $\langle W_0,\star\rangle=4-2-2=0$; and the Ricci part is the self-dual/anti-self-dual off-diagonal block, which is zero, with the $\Lambda^2$-trace $4-2-2=0$. So $W_0=W^+$ purely, hence $W_0\in\mathcal W_5$. The distinguished eigenvector $w_1=e_{01}+e_{23}$ is the Kähler form, and the spectrum $(4,-2,-2)$ is a positive multiple of $\mathbb{CP}^2$'s $(2,-1,-1)$. **H2 holds; the scaling is irrelevant since $2$ is invertible in $\mathbb F_{46337}$ and rescaling moves no dimension.**

### 5.3 $46337$ is prime

Trial division by every prime through $211$ leaves a nonzero remainder (I did it by hand) and $216^2=46656>46337$ closes the range. A convenient check inside the list: $181\cdot256=46336$, so $46337\equiv1\pmod{181}$. **H10 holds, and it is stated nowhere.**

## 6. The squeeze, and the three conclusions

### 6.1 Every inequality, its direction, and what each rank is the rank of

| link | inequality | direction | consumed correctly? |
|---|---|---|---|
| (i) | $\operatorname{rank}_{\mathbb F_p}K\le\dim_{\mathbb F_p}\operatorname{span}\{W_a^{\otimes3}\}$ | Gram under-counts, since the form can be degenerate over $\mathbb F_p$ | yes, used as a **lower** bound on a span |
| (ii) | $\dim\operatorname{span}\{\text{finitely many orbit cubes}\}\le\dim U$ | sampling under-counts | yes |
| (iii) | $\dim U\le\sum_{\lambda_2\ \text{even}}d_\lambda=3570$ | $\dim V_\lambda^H\le1$ plus the parity rule over-counts | yes |
| (iv) | $\operatorname{rank}_{\mathbb F_p}\le\operatorname{rank}_{\mathbb Q}$ of a $p$-integral reduction | reduction under-counts | **the inequality is true; it has no left- and right-hand side here** |

**All four point the right way. The chain does not join, and the break is at (iv).** Ask the brief's question, what object is each rank the rank of. The left end is $\operatorname{rank}_{\mathbb F_{46337}}$ of a matrix built from $g_a\in SO(5,\mathbb F_p)$, whose entries were **chosen** in $\mathbb F_p$ (§5.1). The right end, $3570$, is a dimension of a real $O(5,\mathbb R)$-submodule of $\mathrm{Sym}^3\mathcal W_5$. **These are ranks of two different objects**, and the sentence meant to identify them (*"a mod-$p$ rank is a lower bound for the characteristic-zero span"*), is the assertion at issue, not an argument for it. As a universal claim it is false: a rank over $\mathbb F_p$ bounds a characteristic-zero rank only through a $p$-integral matrix reducing to it.

Nor can the argument be read wholly in characteristic $p$: (iii) rests on complete reducibility and an isotypic decomposition (H6), and $|SO(5,\mathbb F_p)|=p^4(p^2-1)(p^4-1)$ is divisible by $p$ for every $p$, so $\mathbb F_p[SO(5,\mathbb F_p)]$ is not semisimple and nothing licenses that machinery there.

**C5, the three-step record.**

1. **Located exactly.** [sym3-blocks.md:140](../findings/sym3-blocks.md), second sentence: *"A mod-$p$ rank is a lower bound for the characteristic-zero span."* The hypothesis it needs and lacks is H11.
2. **The failure exhibited concretely.** In [orbit_span.sage:32–38](../scripts/reviewers/r178/orbit_span.sage) each $A_{ij}$ is `F.random_element()` and $g$ is formed inside $F$. The only characteristic-zero object in the file is the pattern of $W_0$. There is therefore **no** matrix over $\mathbb Q$ of which the computed Gram is a reduction. The parameter at which it breaks is not special: it breaks at **every** $a\in\{1,\dots,3700\}$, because no $\tilde g_a$ exists on the record.
3. **Arguing the opposite.** The strongest reading is that the author held the lift in mind, and the record itself names one in half a sentence at [sym3-blocks.md:130](../findings/sym3-blocks.md), with [r681](../reviews/REVIEW_r681.md) and [r682](../reviews/REVIEW_r682.md) each supplying a full version, r681 by an integral Cayley lift, r682 by smoothness of $SO_5$ over $\mathbb Z[\tfrac12]$ and reducedness of $SO_{5,k}$. **Neither has reached the lemma.** Per this round's rule I do not supply the argument here either; writing it out would hand the record fresh mathematics under the letterhead of a check.

**`HYPOTHESIS-DEBT`. What would have to be proved, precisely:** *for each of the $3700$ sampled $g_a\in SO(5,\mathbb F_{46337})$ there is a $p$-integral $\tilde g_a\in O(5,\mathbb Q)$ with $\tilde g_a\bmod p=g_a$; $W_0$ and $\Lambda^2$ are $p$-integral; and hence the computed matrix is the reduction of $[\langle\tilde g_aW_0,\tilde g_bW_0\rangle^3]$ over $\mathbb Z_{(p)}$.* Equivalently, r682's statement that $\operatorname{rank}(L_{\mathbb F_p})\le\operatorname{rank}(L_{\mathbb Q})$ for the orbit-evaluation matrix $L$ over $\mathbb Z[\tfrac12]$.

**Conclusion (a), *"the span is exactly $3570$"*, fails under both readings of "the span".**

- **Reading A, the characteristic-zero $U$.** Needs C5. `HYPOTHESIS-DEBT`.
- **Reading B, the $\mathbb F_p$-span of the sample.** Link (i) gives $\ge3570$; the matching **upper** bound is (iii), which is a characteristic-zero theorem and is unavailable over $\mathbb F_p$ by the non-semisimplicity above. So "exactly" is unproved here too.

The block never says which span it means. **C6 `HYPOTHESIS-DEBT`.**

### 6.2 Conclusion (b), "every one of the sixteen evaluation maps is nonzero"

**The inference is valid.** Given $\dim U=3570$, $r_\lambda\in\{0,1\}$ for all $\lambda$ and $r_\lambda=0$ at odd $\lambda_2$ (H5, H6), $\sum_{\lambda_2\text{ even}}r_\lambda d_\lambda=\sum_{\lambda_2\text{ even}}d_\lambda$ with $0\le r_\lambda\le1$ forces $r_\lambda=1$ on all sixteen, an attained upper bound with non-negative slack terms. Nothing is consumed backwards. **It rests entirely on C6, which is owed.**

**Two of the sixteen have witnesses that need no run, and I tested them.** The brief asks for one object from each structured family the record names; the record names two, the trivial block and the multiplicity-one blocks that "die outright".

- **$\lambda=(0,0)$, $d_\lambda=1$.** [L83](../findings/sym3-blocks.md) records $m_{(0,0)}=1$ at $n\le5$ by the Lovelock collapse, the cubic invariant space being spanned by $\operatorname{tr}(W^3)$. At the script's $W_0$, with $\Lambda^2$-spectrum $(4,-2,-2,0^7)$, $\operatorname{tr}(W_0^3)=64-8-8=48\ne0$; at the record's unit normalisation, $(8-1-1)/6^{3/2}=1/\sqrt6\ne0$. **$\mathrm{ev}_{(0,0)}\ne0$, by hand.**
- **$\lambda=(1,0)$, $d_\lambda=5$.** [r173_pseudovector_covariant.py](../scripts/reviewers/r173/r173_pseudovector_covariant.py) exhibits the block's covariant explicitly as $T^e=\varepsilon^{abcde}W_{ab}{}^{fg}W_{cd}{}^{hi}W_{fghi}$, valued in $\Lambda^4\mathbb R^5$ rather than the vector representation, correctly, since $-\mathrm{Id}$ acts trivially on $\mathcal W_5$ and hence on $\mathrm{Sym}^3$, which excludes the untwisted $[1]$ at odd $n$. Because $W_0$ is padded, every $W$ index lies in $\{0,1,2,3\}$, so $\varepsilon$ forces $e=4$ and only $T^4$ can survive, which is exactly the record's *"realised by $e_5$"*. Contracting the $\varepsilon$ against two $\Lambda^2$ slots is the Hodge star of $\mathbb R^4$, and the remaining contraction is $W^3$, so $T^4\propto\operatorname{tr}(\star W_0^3)$ on $\Lambda^2\mathbb R^4$. With $W_0$ purely self-dual, $\star=+1$ there, and $\operatorname{tr}(\star W_0^3)=64-8-8=48\ne0$. **$\mathrm{ev}_{(1,0)}\ne0$, by hand.**

So two of the eight block deaths ($(0,0)$ and $(1,0)$), stand independently of the run. **The other fourteen do not**, and the record's own proposed removal check at [sym3-blocks.md:122](../findings/sym3-blocks.md) (evaluate the $41$ highest-weight vectors at a handful of orbit points) was never run.

### 6.3 Conclusion (c), "every even block loses exactly one multiplicity"

Given $r_\lambda=\operatorname{rank}(\mathrm{ev}_\lambda)=1$ for an even $\lambda$, rank–nullity on $\mathrm{ev}_\lambda\colon M_\lambda\to V_\lambda^H$ gives $\dim\ker=m_\lambda-1$: the covariants of type $\lambda$ vanishing at $W_0$, hence on the whole orbit by equivariance. **Valid, and it inherits (b)'s debt in full.** `CONFIRMED AS ALGEBRA`.

The trailing figures follow arithmetically and were re-derived in §3: $25$ multiplicities, $36$ unknowns, the shape, and the eight deaths. **What they do not do is test anything.** The multiplicity column enters (c) but not the cap: $3570$ is a sum of dimensions and is invariant under [L83](../findings/sym3-blocks.md)'s own killer witness, the swap of the two dimension-$35$ blocks $(2,2)$ and $(2,1)$, which moves $36\to38$ and $29\to27$ while leaving $3570$, $7770$, $41$, $65$ and $24$ fixed. So the Gram rank corroborates the constituent **list** and never the multiplicities the conclusion is stated in. That is [L86](../findings/sym3-blocks.md)'s Gate 2 finding and I reproduce it independently.

### 6.4 The collisions, checked because the file makes them depend on this

$c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ gives $c_2(4,1)=c_2(3,3)=30$, $c_2(4,3)=c_2(5,0)=40$, $c_2(5,4)=c_2(6,2)=60$. Under conclusion (c): $(5,0)$, $(5,4)$ and $(6,2)$ are even and multiplicity $1$, so they die, killing the $40$ and $60$ collisions; $(4,1)$ and $(3,3)$ are both odd and both survive, so $30$ remains. **Exactly two of three, as [L84](../findings/sym3-blocks.md)'s Gate 2 note says, and conditional on the same debt.**

## 7. Attribution and provenance

| the record says | the files show |
|---|---|
| *"reviewer 174 **measured** [the span] at $3570$"* ([sym3-blocks.md:120](../findings/sym3-blocks.md)) | [REVIEW_r174.md:14](../reviews/REVIEW_r174.md) says the isotropy rule *"summing the dimensions ... gives $3570$ **on the nose**, which **derives** the record's measured span rather than reproducing it"*, and [§2.3](../reviews/REVIEW_r174.md) prints the sixteen-term sum. **r174 derived the cap and measured nothing.** There is no `scripts/reviewers/r174/`, the directory listing runs `r173`, `r175` |
| the measurement's origin | [REVIEW_r170.md:72–74](../reviews/REVIEW_r170.md): $5200$ random orbit points, Gram rank *"cleanly and identically at tolerances $10^{-8}$, $10^{-10}$, $10^{-12}$"*, giving $3570$, **over $\mathbb R$**, in floating point |
| *"$174$'s 'measured' $3570$ is **independently** reproduced"* ([sym3-blocks.md:140](../findings/sym3-blocks.md)) | doubly wrong. The measurement is r170's, corroborated by [r173_orbit_span.py](../scripts/reviewers/r173/r173_orbit_span.py) at $N=4800$ Haar points and by [orbit_cubic_span.py](../scripts/reviewers/r203/orbit_cubic_span.py) at $3700$. And [REVIEW_r178.md:101](../reviews/REVIEW_r178.md) says in its own words that it read the cited $3570$ *before* running: the construction is independent, the target value was not |
| the run itself | reachable from no finding. L87 carries **no links at all**, stores **no output**, and its script's final line prints rather than asserts |

**C10 REFUTED.** The three-step record: (1) located at [sym3-blocks.md:140](../findings/sym3-blocks.md) and :120; (2) exhibited concretely by the two review files quoted above, which are on the record and say the opposite in their own words; (3) the strongest opposite reading is that "174" is being used as the *label under which the number circulated*, since [r178](../reviews/REVIEW_r178.md) says it met the number as *"174's measured span"* cited from [plan.md](../plan.md), but the current [plan.md](../plan.md) contains neither the string `174` nor `3570`, so the sourcing chain cannot be reconstructed from the record even under that reading. **A misattribution that propagated, not one invented at L87**, but it is L87 that now carries it.

**One provenance clause that survives.** *"Reviewer 178, independently and while 177's objection was being folded in"*, [r681](../reviews/REVIEW_r681.md) verified the two `git` timestamps at $101$ seconds apart. I did not re-check the timestamps and take that as read.

**C9 REFUTED AS STATED.** *"THE RANK IS NOW PROVED RATHER THAN MEASURED"* describes a cap that is a theorem and a value that is one unreplicated machine reading with no stored output. What changed between L86 and L87 is the *arithmetic* of the measurement (float to exact), not its status. Located at [sym3-blocks.md:140](../findings/sym3-blocks.md); exhibited by the script, which computes rather than proves; the opposite reading, that "proved" means "proved modulo an exact finite computation", is the standard sense of a computer-assisted proof and would be defensible **once C5 is discharged**, which is why the headline is graded `REFUTED AS STATED` rather than `REFUTED`.

## 8. Cited stronger than proved

- **[results.md:23](../results.md), L87's only appearance in the canon.** *"A sampled mod-$p$ rank is a rigorous lower bound, and under an exact cap a lower bound is all that is needed, so [L87]'s rank and [L62]'s value are proofs rather than measurements."* The premise is exactly C5. For [L62](../findings/sym3-blocks.md) it is defensible (that run reduces exact rationals into $\mathbb F_p$) and **for L87 it is not**, the points being constructed inside $\mathbb F_{46337}$. Sweeping the two into one sentence launders L87's gap through L62's soundness. **`REFUTED AS STATED at [results.md:23](../results.md)`.** *In passing: that row also repeats the clause "L90's stated proof was withdrawn as circular, its repair sitting twelve lines below it" verbatim twice, which is an editing defect in the row carrying L87's only canonical mention.*
- **[report/sections/07-gradedness-split.tex:910](../report/sections/07-gradedness-split.tex).** *"$A(W_0^6)$'s catalecticant is the orbit average of the rank-one forms ..., of rank $3570$."* This is conclusion (a) in characteristic zero (the part carrying the debt), asserted flat, with no attribution and no source. **Same strength as the lemma's conclusion, less support than the lemma's block.**
- **Cited at the right strength.** [L88](../findings/sym3-blocks.md)'s $47=36+11$ says it is transported *"through [L86](../findings/sym3-blocks.md)'s parity rule and L87's rank-one step"*, naming the dependency. [L84](../findings/sym3-blocks.md)'s note that L87 *"kills two of the three collisions"* is conclusion (c) applied, §6.4. [findings/INDEX-results.md:102](../findings/INDEX-results.md) carries the `GAP` verdict, the $5640$ and the $\mathrm{GF}(46337)$ point faithfully, **the index is more honest about L87 than the lemma is**, and the lemma text has not been repaired.

## 9. Candidates withdrawn, with reasons

- **"$p\mid\lvert O(5,\mathbb F_p)\rvert$, so the isotypic decomposition the cap needs does not exist over $\mathbb F_p$" ([sym3-blocks.md:130](../findings/sym3-blocks.md)) is stated more strongly than it is argued.** Non-semisimplicity of the group algebra does not by itself prove that this particular module fails to decompose, trivial and projective modules decompose regardless. *Withdrawn on step 2*: I cannot exhibit the failure at $\mathrm{Sym}^3\mathcal W_5$ specifically without a computation I may not run, and the note's operative conclusion (that **nothing licenses** the char-$p$ reading), survives untouched.
- **"$N=3700$ is too small."** *Withdrawn on step 2.* The sample enters only as a lower bound; too few points would have shown up as a rank below the cap and the squeeze would simply not have closed. The run is one-sided in the safe direction. The $130$-point headroom is worth recording as a design note, not as a defect.
- **"The script's $W_0$ has spectrum $(4,-2,-2)$ where the record's is $(2,-1,-1)/\sqrt6$, so it is a different point."** *Withdrawn on step 2.* A scalar rescaling multiplies every spanning vector of $U$ by the same nonzero factor and moves no dimension, and $2\ne0$ in $\mathbb F_{46337}$. §5.2 shows the two are the same ray.
- **"The Cayley transform does not surject onto $SO(5,\mathbb F_p)$, so the sample misses part of the orbit."** *Withdrawn on step 3.* True (the image omits elements with eigenvalue $-1$) but the sample is used only for a **lower** bound, so a missed subfamily can only lose rank. The strongest reading is the author's own, and it is right.
- **"$O(5)$ versus $SO(5)$, the run samples only $SO(5)$."** *Withdrawn on step 2.* At $n=5$, $\det(-I)=-1$ and $-\mathrm{Id}$ acts trivially on $\mathcal W_5$, so $O(5)\cdot W_0=SO(5)\cdot W_0$; [REVIEW_r170.md:72](../reviews/REVIEW_r170.md) makes the same point. This is a boundary the brief asks about, **odd $n$ is exactly what makes the $SO(5)$ block table legal as an $O(5)$ table**, and the same step fails at even $n$, which L83's Gate 2 note records and L87 does not.
- **"$W_0\notin\mathcal W_5$, since the script never checks Bianchi or the Ricci trace."** *Withdrawn on step 2.* §5.2 verifies both by hand and they hold. It remains a gap in the run's self-validation, recorded as H2, not a defect in the mathematics.
- **"An imported theorem whose hypotheses were never checked."** Frobenius reciprocity is the only import, and its hypotheses (compact $G$, closed $H$, characteristic zero, finite-dimensional), all hold. *Withdrawn.* The brief's warning about a **unital** algebra does not fire here: no algebra structure on $\mathcal W_n$ is used anywhere in L87, only the module structure.

## 10. Verdict on the result as a whole

**The mathematics is right and the lemma does not contain it.** The cap is a four-line theorem and every digit of $3570$ re-derives by hand; the inference from an attained cap to sixteen nonzero evaluation maps to sixteen lost multiplicities is valid; two of the sixteen have hand witnesses that need no run at all. What is missing is the single sentence joining an exact finite-field rank to a real $O(5,\mathbb R)$-module, and the record names that sentence in half a clause and writes it in two reviews that never reached the text.

**Recommended form**, which is [L62](../findings/sym3-blocks.md)'s own prescription applied here: a `Lemma` for $\dim U\le3570$, proved from [L83](../findings/sym3-blocks.md)'s constituent list and [L86](../findings/sym3-blocks.md)'s **full** parity rule; and an `Observation` for the attainment, an exact finite computation resting on a lift the block must state. Both halves would then be as strong as they say.

**The object that would falsify the statement**, and what I did to look for it: an even-$\lambda_2$ block $\lambda$ whose whole multiplicity space $M_\lambda$ evaluates to zero at $W_0$, equivalently, a degree-$3$ $O(5)$-covariant of type $\lambda$, $\lambda_2$ even, vanishing identically on $O(5)\cdot W_0$. I tested the two structured families the record names, both drawn from the eight blocks it says die outright: the trivial block $(0,0)$, where the unique cubic invariant $\operatorname{tr}(W^3)$ takes the value $48\ne0$, and the pseudovector block $(1,0)$, where [r173](../scripts/reviewers/r173/r173_pseudovector_covariant.py)'s explicit covariant reduces at the padded point to $\operatorname{tr}(\star W_0^3)=48\ne0$ along $e_5$. **Neither is a falsifier, and no falsifier can be exhibited or excluded for the remaining fourteen blocks without either running the record's own proposed check, evaluating the $41$ highest-weight vectors at a handful of orbit points, which this round's footing forbids me, or writing down the lift, which this round's rules forbid me.** What I could do instead was test the block's *stated ground*, and there a falsifier does exist in closed form: the profile of §4, with $r_\lambda=1$ on the eight odd blocks and on $(6,4)$, $(6,2)$, $(2,2)$, $(3,0)$, sums to exactly $3570$ under $\dim V_\lambda^H\le1$ while twelve of the sixteen evaluation maps vanish.
