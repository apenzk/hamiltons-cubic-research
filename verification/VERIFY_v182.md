# VERIFY_v182, L28, the $\mathbb{CP}^m$ family is nondegenerate at every $m\ge3$

Cold read of [BRIEF_L28.md](BRIEF_L28.md) by verifier v182. **No numerical work was done**: no script, no Sage, no Python, no numeric evaluation of any kind. Every number below is closed-form arithmetic carried out by hand on objects the record itself supplies. Log: [agent_logs/verify-L28-v182.log](../agent_logs/verify-L28-v182.log).

## Claim table

| # | claim | verdict |
|---|---|---|
| 1 | Ten complex summands, seven real classes, three conjugate pairs | **PROVEN** (count independently reconstructed) |
| 2 | The decomposition is $U(m)$-multiplicity-free | **HYPOTHESIS-DEBT at $m=3$**, the cited rule's own hypothesis is $m\ge4$ |
| 3 | The seven real dimensions sum to $\dim\mathcal W_{2m}=\frac{m(m+1)(2m+1)(2m-3)}3$ identically in $m$ | **PROVEN** |
| 3b | Each of the seven real dimensions is the right one | **PROVEN** (each rederived from the $GL(m)$ Weyl/hook formulas) |
| 4 | The seven charges $c_S+q_S^2$ are $0,\,2m,\,2(m+1),\,4(m-1),\,4(m+1),\,4(m+1),\,4(m+4)$ | **PROVEN**, every row recomputed from $c_S=\sum_i\nu_i(\nu_i+m+1-2i)$, $q_S=\sum_i\nu_i$ |
| 5 | $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ reproduces the $L_e$ column, and $\lambda_S=\tfrac12\iff c_S+q_S^2=2(m+1)$ | **PROVEN** |
| 6 | Among the non-orbit rows only $4(m-1)$ meets $2(m+1)$, at $m=3$ alone | **PROVEN** |
| 7 | $V_{(1,1);(1,1)}$ is absent at $m=3$, and the vanishing of $\frac{m^2(m+1)(m-3)}4$ is the continuation agreeing rather than the reason | **PROVEN**, and the epistemic caveat is right |
| 7b | The block attributes that absence to "the branching rule" | **GAP (attribution)**, at $m=3$ the cited rule has no content; the absence is nonetheless sound on weight grounds |
| 8 | $\lambda_{\max}(L_e\vert_{W^\perp})=\frac{m+2}{2(m+1)}>\tfrac12$ | **PROVEN** |
| 9 | $\mathop{\mathrm{tr}}L_e=0$ | **PROVEN**, and Fox's Theorem 1.3 does apply, checked at source |
| 10 | $\mathop{\mathrm{tr}}(L_e^2)=\frac{3m(m-1)(4m-1)}{4(m+1)}$ | **PROVEN** |
| 11 | $\ldots=\kappa_F(2m)\lVert e\rVert^2$ with $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ | **PROVEN as arithmetic; HYPOTHESIS-DEBT as a check**, $\kappa_F$'s closed form is this record's numerical fit, not Fox's theorem |
| 12 | "Two identities check the whole list" (independence of the check | **OVERSTATED**), one is theorem-backed, the other is $\kappa=\theta^2\mathop{\mathrm{tr}}(L_e^2)$ read backwards |
| 13 | The $\mathop{\mathrm{tr}}L_e=0$ solve returns $\frac{m+2}{2(m+1)}$ on the $\mathfrak{su}(m)$ row | **PROVEN**, the block's displayed line is arithmetically exact |
| 14 | "each remaining class is recovered uniquely the same way" | **PROVEN for $m\ge4$; vacuously false at $m=3$ on row 4** (zero coefficient) |
| 15 | $e$'s closed form is exactly traceless | **PROVEN** |
| 16 | $\lVert e\rVert^2=1/\theta^2$ with $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ | **PROVEN**, under $\lVert X\rVert^2=\mathop{\mathrm{tr}}(X^2)$, and only under it |
| 17 | Slack against [L70](../findings/bounds.md) is exactly $2(m-2)\theta$, vanishing only at $m=2$ | **PROVEN** |
| 18 | The landscape line at [results.md](../results.md) line 142 against the table's orbit row | **INCONSISTENT AS WRITTEN**, the qualifier "among the rest" is dropped |
| 19 | "the same table stands at [second-order.md](../findings/second-order.md)" | **AGREE**, row for row, dimension for dimension, value for value |
| 20 | second-order.md line 279: "the trace identity forces it" for the two zero rows | **OVERSTATED** (defect in second-order.md, not in L28) |

**Verdict: PROVEN, hypotheses corrected.** Every number in the block is exactly right; I found no arithmetic error anywhere, including in the repaired charge column, which I recomputed row by row from the definitions rather than from the repair's account of itself. What the block does not have is analytic support for its multiplicity-freeness hypothesis at $m=3$ (the one value of $m$ the lemma's headline claim ("with **no exception**") turns on) because the branching rule it cites carries the hypothesis $m\ge4$ in the record's own reference notes.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), never restated.

- $\mathcal W_n$, "the space of algebraic Weyl curvature operators on $\mathbb R^n$".
- $\dim\mathcal W_n$ ("$\frac{n(n-3)(n+1)(n+2)}{12}$), $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$".
- $Q(W)$, "Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself".
- $P(W)$, "the cubic form $\langle W,Q(W)\rangle$".
- $\theta$, "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- The $\circ$ product, "$X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it."
- $T$, third sense, "the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$, whose symmetry is what makes $L_e$ self-adjoint and hence [L24](../findings/second-order.md)'s $\lambda_{\max}$ well defined at all".
- Morse–Bott nondegeneracy, "A critical orbit is Morse–Bott nondegenerate when $\ker\mathrm{Hess}_SP$ equals the orbit tangent exactly. Via [L24](../findings/second-order.md)'s $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ that kernel is the eigenspace **at** $\tfrac12$, *so an eigenvalue **above** $\tfrac12$ off the orbit costs maximality and contributes nothing to the kernel, and the two failures must never be collapsed.*"
- $\lVert\cdot\rVert$ against $\lVert\cdot\rVert_F$, "This record's norm is $\lVert Z\rVert^2=\tfrac12\mathop{\mathrm{tr}}(Z^{\mathsf T}Z)$, so $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$". *This is stated for $\mathfrak{so}(n)$, i.e. for bivectors, and §8 below shows the L28 block runs on the un-halved $\mathop{\mathrm{tr}}(X^2)$ for curvature operators. Both are on the record and the block names neither.*

Two derived facts I use and state once. **First**, $\dim\mathcal W_{2m}=\frac{2m(2m-3)(2m+1)(2m+2)}{12}=\frac{m(m+1)(2m+1)(2m-3)}3$, so the block's target polynomial is the tabled dimension and not a second convention. **Second**, $X\circ X=\tfrac12\big(Q(2X)-2Q(X)\big)=\tfrac12\big(4Q(X)-2Q(X)\big)=Q(X)$, so $L_ee=Q(e)$.

## Hypothesis inventory

| # | hypothesis | stated in the block? | used? | supported? |
|---|---|---|---|---|
| H1 | $m\ge3$ | yes, in the statement | yes, §9 shows the $\mathfrak{su}(m)$ row is $\tfrac12$ and not $\tfrac23$ at $m=2$, and row 4's dimension polynomial goes **negative** at $m=2$ | yes; and [second-order.md](../findings/second-order.md) line 260 records the $m=2$ failure independently |
| H2 | $\lVert W\rVert=1$ | **no** | yes, $\lVert e\rVert^2=1/\theta^2$ (§8), the Fox check (§6), and [L70](../findings/bounds.md), which says "**And it needs $\lVert W\rVert=1$**" | true of the object, unstated in the block |
| H3 | $W$ critical, $Q(W)=\theta W$ | yes ("a critical $W_{\mathbb{CP}^m}$") | yes, the $\lambda=1$ row, and L70 | yes |
| H4 | $e$ is $U(m)$-invariant | yes | yes, the whole Schur step | yes ($e$ is a multiple of $W_{\mathbb{CP}^m}$, whose isotropy contains $U(m)$) |
| H5 | $\mathrm{Weyl}_{2m}\otimes\mathbb C$ is $U(m)$-multiplicity-free | yes, **unqualified in $m$** | yes, twice: "Schur makes it a scalar on each summand", and "multiplicity-freeness makes $E(\tfrac12)$ a sum of whole summands" | **only for $m\ge4$.** See §2 |
| H6 | $L_e$ is self-adjoint and real | no | yes, "each value is an eigenvalue and not merely a Rayleigh lower bound", and the passage from complex summands to real classes | yes, from conventions.md's symmetric $T$ |
| H7 | Fox Thm 1.3: nontrivial, finite-dimensional, Euclidean-metrized, commutative, a real Lie group acting **irreducibly** by isometric automorphisms | no, cited by name only | yes | yes, all five verified at source in §6. **No unitality hypothesis exists in the theorem**, so the trap that killed an earlier route does not bite here |
| H8 | $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ | yes, presented as part of "Fox's Theorem 1.3" | yes | **no**, Fox's Remark 1.4 leaves $\kappa$ uncomputed for $\dim V>4$. See §6 |
| H9 | $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ | yes | yes, §6 and §8 | yes; and at $m=3$ it gives $\theta^2=\tfrac{10}9=\theta_0(6)^2$, which the record corroborates elsewhere |

**H2, H6 and H7 are unstated and true. H8 is stated and unsupported. H5 is stated and supported only above the smallest admissible $m$.** That last one is the finding.

## 1. The decomposition: ten complex, seven real, three conjugate pairs, PROVEN

The dual of a rational $GL(m)$ highest weight $(\nu_1,\dots,\nu_m)$ is $(-\nu_m,\dots,-\nu_1)$. Applying that to the seven labels in the block's table:

| row | weight $\nu$ | dual | self-dual? |
|---|---|---|---|
| 1 | $(0^m)$ | $(0^m)$ | yes |
| 2 | $(1,0^{m-2},-1)$ | $(1,0^{m-2},-1)$ | yes |
| 3 | $(1,1,0^{m-2})$ | $(0^{m-2},-1,-1)$ | **no** |
| 4 | $(1,1,0^{m-4},-1,-1)$ | $(1,1,0^{m-4},-1,-1)$ | yes |
| 5 | $(2,1,0^{m-3},-1)$ | $(1,0^{m-3},-1,-2)$ | **no** |
| 6 | $(2,0^{m-2},-2)$ | $(2,0^{m-2},-2)$ | yes |
| 7 | $(2,2,0^{m-2})$ | $(0^{m-2},-2,-2)$ | **no** |

Four self-dual and three dual pairs, so $4+3\cdot2=\mathbf{10}$ complex summands and $4+3=\mathbf7$ real classes, of which exactly **three** are conjugate pairs. The block's counts are right, and the three rows it marks "$\oplus$ dual" are exactly the three that are not self-dual.

The real-dimension bookkeeping is then forced and consistent: for a self-dual summand the real form has $\dim_{\mathbb R}=\dim_{\mathbb C}$, and for a pair $V\oplus\bar V$ it is $2\dim_{\mathbb C}V$. That is why the block's real dimensions sum to $\dim\mathcal W_{2m}$ rather than to twice it (§3).

**One scoping nit.** The block's opening sentence gives "ten"/"seven" with no restriction on $m$, while the counts are nine and six at $m=3$, as [second-order.md](../findings/second-order.md) line 267 says in its own words, "ten summands, **nine at $m=3$**". The block's table does mark row 4 "**absent at $m=3$**", so this is a missing qualifier in one sentence rather than a contradiction.

## 2. Multiplicity-freeness, HYPOTHESIS-DEBT at $m=3$, and $m=3$ is where the lemma is decided

**Where it is.** The block asserts, unqualified in $m$: "$\mathrm{Weyl}_{2m}\otimes\mathbb C$ is $U(m)$-multiplicity-free with **ten** summands, the $GL_m\subset O_{2m}$ branching rule at $\lambda=(2,2)$". The record's own reference notes, [references/howe-tan-willenbring-2005-stable-branching/notes.md](../references/howe-tan-willenbring-2005-stable-branching/notes.md) line 20, state the rule's hypothesis and its consequence:

> "$\mathrm{Weyl}_{2m}\otimes\mathbb C$ is the $O(2m)$-irreducible $E^{(2,2)}$, so $\lambda=(2,2)$ and $n=m$; **the rule applies once $\lfloor m/2\rfloor\ge2$, i.e. $m\ge4$**. … so **the decomposition is multiplicity-free for every $m\ge4$**."

and the only $m=3$ support it offers is that the computation "agrees summand for summand with the **numerically measured** decomposition at $m=3,4,5,6$". [second-order.md](../findings/second-order.md) line 267 carries the same scope, "all multiplicity one for $m\ge4$", inside a sentence whose leading clause nonetheless asserts "nine at $m=3$".

**What fails concretely.** The branching rule quoted at line 12 of those notes requires $\lambda$ to have at most $\lfloor n/2\rfloor$ parts. Here $\lambda=(2,2)$ has two parts and $n=m$, so the hypothesis is $\lfloor m/2\rfloor\ge2$. At $m=3$, $\lfloor 3/2\rfloor=1<2$: **the cited rule says nothing at all about $\mathrm{Weyl}_6\otimes\mathbb C$.** The step it is used for is load-bearing and its failure mode is exact: if some $U(3)$-irrep occurred in $\mathrm{Weyl}_6\otimes\mathbb C$ with multiplicity $2$, Schur would give $L_e$ a $2\times2$ symmetric block there instead of a scalar, its two eigenvalues would be unconstrained by the charge formula, and one of them could be $\tfrac12$, which is precisely the possibility "$E(\tfrac12)$ is the orbit tangent, with **no exception**" must exclude, at precisely the $m$ where the block's own near-miss row lives.

**Arguing the opposite.** Three things push back, and none closes it analytically. *(i)* The record has a numerical measurement at $m=3$ agreeing summand for summand, but this loop takes no numerical result as evidence for a positive claim, and the programme's standing rule is that the deliverable is a derivation. *(ii)* [Tricerri–Vanhecke](https://www.ams.org/journals/tran/1981-267-02/S0002-9947-1981-0626479-0/) is cited as corroborating "$6+2+1=9$ at $m=3$", but the same notes record that "the AMS PDF is behind a JavaScript gate and was not retrieved", so the corroboration is quoted rather than read. *(iii)* The dimension identity *does* close at $m=3$: the six surviving rows have real dimensions $1,8,6,30,27,12$, summing to $84=\dim\mathcal W_6$ exactly (§3), and they are six pairwise-distinct $GL(3)$-irreps. **So the debt is narrow and nameable**: what must be proved is that each of those six irreps *occurs* in $\mathrm{Weyl}_6\otimes\mathbb C$; given occurrence, the dimension count forces multiplicity one for each and forbids anything else. Occurrence is on the record for row 1 (the line $\langle W\rangle$), row 2 (the $\lambda_{\max}$ carrier) and row 3 (the orbit tangent), and is **not** on the record at $m=3$ for rows 5, 6 and 7.

**Verdict: HYPOTHESIS-DEBT.** The claim at $m\ge4$ stands on the cited rule. At $m=3$ the block has no argument on file, and the correct finding is that it has none, not that it is false. I supply no substitute.

## 3. The dimension sum, as a polynomial identity, PROVEN

Over the common denominator $12$ the seven real dimensions are

$$12,\quad 12(m^2-1),\quad 12m(m-1),\quad 3m^2(m+1)(m-3),\quad 8m^2(m^2-4),\quad 3m^2(m-1)(m+3),\quad 2m^2(m^2-1).$$

Expanding: $12$; $12m^2-12$; $12m^2-12m$; $3m^4-6m^3-9m^2$; $8m^4-32m^2$; $3m^4+6m^3-9m^2$; $2m^4-2m^2$. Collecting,

- $m^4$: $3+8+3+2=16$;
- $m^3$: $-6+6=0$;
- $m^2$: $12+12-9-32-9-2=-28$;
- $m^1$: $-12$;
- $m^0$: $12-12=0$.

So the sum is $\frac{16m^4-28m^2-12m}{12}=\frac{m(4m^3-7m-3)}3$. On the other side, $(m+1)(2m+1)=2m^2+3m+1$ and $(2m^2+3m+1)(2m-3)=4m^3+6m^2+2m-6m^2-9m-3=4m^3-7m-3$. **The two agree identically in $m$**, and the target is $\dim\mathcal W_{2m}$ by §0. At $m=3$ the row-4 term is $0$ and the remaining six give $1+8+6+30+27+12=84$, the tabled $\dim\mathcal W_6$.

### 3b. Each individual dimension, PROVEN

The sum identity alone would tolerate compensating errors, so I rederived every row from the standard $GL(m)$ formulas. Write $E=\mathbb C^m$.

| row | complex module | $\dim_{\mathbb C}$ | real dim |
|---|---|---|---|
| 1 | trivial | $1$ | $1$ |
| 2 | $\mathfrak{sl}(m,\mathbb C)$ | $m^2-1$ | $m^2-1$ |
| 3 | $\Lambda^2E$, paired with $\Lambda^2\bar E$ | $\binom m2=\frac{m(m-1)}2$ | $2\cdot\frac{m(m-1)}2=m(m-1)$ |
| 4 | $V_{(1,1);(1,1)}\subset\Lambda^2E\otimes\Lambda^2\bar E$ | $\big(\tfrac{m(m-1)}2\big)^2-m^2=\frac{m^2(m+1)(m-3)}4$ | same |
| 5 | $V_{(2,1);(1)}$, paired | $\frac{m(m+1)(m-1)}3\cdot m-m^2=\frac{m^2(m^2-4)}3$ | $\frac{2m^2(m^2-4)}3$ |
| 6 | $V_{(2);(2)}\subset\mathrm{Sym}^2E\otimes\mathrm{Sym}^2\bar E$ | $\big(\tfrac{m(m+1)}2\big)^2-m^2=\frac{m^2(m-1)(m+3)}4$ | same |
| 7 | $\mathbb S_{(2,2)}E$, paired | $\frac{m(m+1)(m-1)m}{3\cdot2\cdot2\cdot1}=\frac{m^2(m^2-1)}{12}$ | $\frac{m^2(m^2-1)}6$ |

The subtractions are the trace terms. In rows 4 and 6 the tensor product decomposes as $V_{(\mu);(\mu)}\oplus V_{(1);(1)}\oplus V_{(0);(0)}$, removing $(m^2-1)+1=m^2$. In row 5 the contraction $\mathbb S_{(2,1)}E\otimes\bar E\to\Lambda^2E\oplus\mathrm{Sym}^2E$ removes $\frac{m(m-1)}2+\frac{m(m+1)}2=m^2$, and $\dim\mathbb S_{(2,1)}E=\frac{m(m+1)(m-1)}3$ by the hook-content formula on cells $(1,1),(1,2),(2,1)$ with contents $m,m+1,m-1$ and hooks $3,1,1$. Row 7 is the same formula on $(2,2)$: contents $m,m+1,m-1,m$ over hooks $3,2,2,1$.

**Every entry in the dimension column is independently correct**, and row 4's $\frac{m^2(m+1)(m-3)}4=\big(\tfrac{m(m-1)}2\big)^2-m^2$ makes the $m=3$ vanishing transparent: $3^2-3^2=0$.

## 4. The charge column, recomputed row by row, PROVEN

**This is the column the block's one repaired arithmetic error stood in, so I recomputed it from the definitions rather than reading the repair's account of itself.** The definitions are [second-order.md](../findings/second-order.md) line 291's, quoted verbatim: "$c_S=\sum_i\nu_i(\nu_i+m+1-2i),\quad q_S=\sum_i\nu_i$, with $\nu$ the summand's highest weight as a $GL(m)$ weight."

| row | $\nu$ | nonzero terms of $c_S$ | $c_S$ | $q_S$ | $c_S+q_S^2$ | table |
|---|---|---|---|---|---|---|
| 1 | $(0^m)$ |, | $0$ | $0$ | $0$ | $0$ ✓ |
| 2 | $(1,0^{m-2},-1)$ | $i{=}1$: $1(1+m-1)=m$; $i{=}m$: $(-1)(-1+m+1-2m)=m$ | $2m$ | $0$ | $2m$ | $2m$ ✓ |
| 3 | $(1,1,0^{m-2})$ | $i{=}1$: $m$; $i{=}2$: $1(1+m+1-4)=m-2$ | $2m-2$ | $2$ | $2m-2+4=2(m+1)$ | $2(m+1)$ ✓ |
| 4 | $(1,1,0^{m-4},-1,-1)$ | $i{=}1$: $m$; $i{=}2$: $m-2$; $i{=}m{-}1$: $(-1)(-1+m+1-2m+2)=m-2$; $i{=}m$: $m$ | $4m-4$ | $0$ | $4(m-1)$ | $4(m-1)$ ✓ |
| 5 | $(2,1,0^{m-3},-1)$ | $i{=}1$: $2(2+m-1)=2m+2$; $i{=}2$: $m-2$; $i{=}m$: $m$ | $4m$ | $2$ | $4m+4=4(m+1)$ | $4(m+1)$ ✓ |
| 6 | $(2,0^{m-2},-2)$ | $i{=}1$: $2m+2$; $i{=}m$: $(-2)(-2+m+1-2m)=2m+2$ | $4m+4$ | $0$ | $4(m+1)$ | $4(m+1)$ ✓ |
| 7 | $(2,2,0^{m-2})$ | $i{=}1$: $2m+2$; $i{=}2$: $2(2+m+1-4)=2m-2$ | $4m$ | $4$ | $4m+16=4(m+4)$ | $4(m+4)$ ✓ |

**All seven charges are right.** The two rows where a slip is easiest, row 4, whose two negative entries sit at $i=m-1$ and $i=m$ and whose $-2i$ term is therefore large, and row 7, whose $q_S^2=16$ dominates $c_S$, both come out as tabled.

### 4b. The eigenvalue formula and the $\tfrac12$ criterion, PROVEN

$\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ on the seven charges gives, in order,

$$1,\quad 1-\tfrac{m}{2(m+1)}=\tfrac{m+2}{2(m+1)},\quad 1-\tfrac12=\tfrac12,\quad 1-\tfrac{m-1}{m+1}=\tfrac2{m+1},\quad 0,\quad 0,\quad 1-\tfrac{m+4}{m+1}=-\tfrac3{m+1},$$

**reproducing the $L_e$ column exactly.** The criterion is immediate: $1-\frac{X}{4(m+1)}=\tfrac12\iff X=2(m+1)$.

Testing $c_S+q_S^2=2(m+1)$ row by row over $m\ge3$: $0$ never; $2m=2m+2$ never; row 3 identically; $4m-4=2m+2\iff m=3$; $4(m+1)=2(m+1)$ never; $4m+16=2m+2\iff m=-7$, never. **So among the non-orbit rows only $4(m-1)$ can meet it, at $m=3$ alone**, the block's claim, confirmed.

$\lambda_{\max}$ off the line $\langle W\rangle$ is then $\max\{\frac{m+2}{2(m+1)},\tfrac12,\frac2{m+1},0,0,-\frac3{m+1}\}$. Since $\frac{m+2}{2(m+1)}=\tfrac12+\frac1{2(m+1)}>\tfrac12$, and $\frac2{m+1}\le\frac{m+2}{2(m+1)}\iff4\le m+2\iff m\ge2$, **the maximum is $\frac{m+2}{2(m+1)}$ at every $m\ge3$, carried by the $\mathfrak{su}(m)$ adjoint, and it exceeds $\tfrac12$.** By conventions.md's Morse–Bott entry that costs maximality without touching the kernel, the block keeps those two apart correctly.

## 5. The $m=3$ absence, on its own terms, PROVEN, with the attribution flagged

The block says row 4 "needs four rows of a Young diagram against the $m=3$ available, so the branching rule does not produce it, and $\frac{m^2(m+1)(m-3)}4$ vanishing there is the analytic continuation agreeing with the absence rather than the reason for it."

**The absence is sound, and it does not need the branching rule.** The label is the rational $GL(m)$-irrep $V_{(1,1);(1,1)}$, of highest weight $(1,1,0^{m-4},-1,-1)$. For that weight to exist as a dominant rational weight the two $+1$'s and the two $-1$'s must occupy four distinct slots, i.e. $\ell(\mu^+)+\ell(\mu^-)=2+2\le m$. At $m=3$ the string $(1,1,-1,-1)$ has four entries against three slots, so **no such $GL(3)$-irrep exists**. Equivalently and more concretely, the module is the traceless part of $\Lambda^2E\otimes\Lambda^2\bar E$, and at $m=3$ that product is $3\times3=9$-dimensional while the trace part $V_{(1);(1)}\oplus V_{(0);(0)}$ is already $8+1=9$: the complement is $\{0\}$. **This is a proof of absence, in closed form, needing nothing numerical.**

**The epistemic caveat is right, and unusually so.** $\frac{m^2(m+1)(m-3)}4$ vanishing at $m=3$ is indeed the continuation agreeing with the absence rather than causing it, the same polynomial goes **negative** at $m=2$, where it manifestly cannot be a dimension, which is exactly why the vanishing carries no evidential weight on its own. The block's refusal to lean on it is correct.

**What is flagged.** The clause "so **the branching rule** does not produce it" invokes, at $m=3$, the one rule the record's own notes scope to $m\ge4$ (§2). The conclusion is unaffected (the weight-length argument above is independent and stronger) but the sentence's warrant is not the one it names.

## 6. Both Fox identities, and the import checked at source, PROVEN as arithmetic; the second is not the independent check it is billed as

### 6a. $\mathop{\mathrm{tr}}L_e=0$, PROVEN

Summing $d_S\lambda_S$: $1+(m^2-1)\frac{m+2}{2(m+1)}+m(m-1)\cdot\tfrac12+\frac{m^2(m+1)(m-3)}4\cdot\frac2{m+1}+0+0+\frac{m^2(m^2-1)}6\cdot(-\frac3{m+1})$, i.e.

$$1+\frac{(m-1)(m+2)}2+\frac{m(m-1)}2+\frac{m^2(m-3)}2-\frac{m^2(m-1)}2 .$$

The bracketed numerators are $m^2+m-2$, $m^2-m$, $m^3-3m^2$ and $-(m^3-m^2)$. The $m^3$ terms cancel; the $m^2$ terms are $1+1-3+1=0$; the $m$ terms are $+1-1=0$; the constant is $-2$. So the sum is $1+\tfrac12(-2)=\mathbf0$. **Identically in $m$.** This is also, term for term, the block's own displayed line, so its display is exact.

### 6b. $\mathop{\mathrm{tr}}(L_e^2)$, PROVEN

Summing $d_S\lambda_S^2$ over the common denominator $4(m+1)$:

$$\frac{4(m+1)+(m-1)(m+2)^2+m(m-1)(m+1)+4m^2(m-3)+6m^2(m-1)}{4(m+1)} .$$

Numerator: $4m+4$; $m^3+3m^2-4$; $m^3-m$; $4m^3-12m^2$; $6m^3-6m^2$. Collecting, $m^3$: $1+1+4+6=12$; $m^2$: $3-12-6=-15$; $m$: $4-1=3$; constant: $4-4=0$. So the numerator is $12m^3-15m^2+3m=3m(4m^2-5m+1)=3m(m-1)(4m-1)$ and

$$\mathop{\mathrm{tr}}(L_e^2)=\frac{3m(m-1)(4m-1)}{4(m+1)},$$

**exactly as the block states.** And $\kappa_F(2m)\lVert e\rVert^2=\frac{(4m-1)(2m-1)}4\cdot\frac{3m(m-1)}{(m+1)(2m-1)}=\frac{3m(m-1)(4m-1)}{4(m+1)}$: the $(2m-1)$ cancels and **the two sides agree identically in $m$.**

### 6c. Fox's hypotheses, checked at source, no unitality, so the import is clean

The trap named in the brief is an imported theorem whose hypotheses were never checked, "one route here died because a cited theorem assumes a *unital* algebra and $\mathcal W_n$ has no unit". I went to [references/fox-2019-nonassociative-curvature-algebra/notes.md](../references/fox-2019-nonassociative-curvature-algebra/notes.md), which transcribes the theorem verbatim:

> "A nontrivial finite-dimensional Euclidean metrized commutative algebra $(A,\circ,h)$ on which a real Lie group $G$ acts irreducibly by isometric automorphisms is exact and Killing metrized with Killing form $\tau_\circ(x,y)=\mathop{\mathrm{tr}}L_\circ(x)L_\circ(y)$ equal to a nonzero multiple of the metric $h$."

**There is no unitality hypothesis.** The five that are there, against $\mathcal W_{2m}$ at $m\ge3$:

| hypothesis | status |
|---|---|
| nontrivial, finite-dimensional | yes, $\dim\mathcal W_{2m}=\frac{m(m+1)(2m+1)(2m-3)}3>0$ |
| commutative | yes, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ is manifestly symmetric |
| metrized | yes, conventions.md's third sense of $T$: "$T(X,Y,Z)=\langle X\circ Y,Z\rangle$" is fully symmetric, which is exactly $h(x\circ y,z)$ totally symmetric |
| Euclidean $h$ | yes, the Frobenius form is positive definite |
| a real Lie group acting **irreducibly** by isometric automorphisms | yes, $G=O(n)$, and the notes are explicit that it must be $O(n)$ rather than $SO(n)$, "at $n=4$ the space of $SO(4)$-invariant symmetric forms on $\mathrm{MC}_W$ is two-dimensional, against one at $n=5,6$". Here $n=2m\ge6$ |

**So $\mathop{\mathrm{tr}}L_e=0$ is theorem-backed and its hypotheses hold.** That is the one Fox import in this block that carries its own weight, and §6a shows the table satisfies it.

### 6d. The second identity is not an independent check, HYPOTHESIS-DEBT on $\kappa_F$

The block writes "**Fox's Theorem 1.3** … gives $\mathop{\mathrm{tr}}L(x)=0$ and $\mathop{\mathrm{tr}}(L(x)L(y))=\kappa_F\langle x,y\rangle$ with $\kappa_F(n)=\frac{(2n-1)(n-1)}4$", which reads as attributing the closed form to Fox. The record says the opposite in two places. [algebra.md](../findings/algebra.md) line 19: "**This is a number Fox does not have: his Remark 1.4 explicitly leaves $\kappa$ uncomputed for $\dim V>4$.**" The reference notes agree: "**Remark 1.4 leaves $\kappa$ uncomputed for $\dim V>4$**, and **Theorem 1.5(2)** supplies the single value $\kappa=21/16$ at $\dim V=4$". Line 21 of algebra.md describes how the closed form was obtained, "**Verified far beyond the fit**", "roughly 90 points", "maximum deviation $4\times10^{-13}$". **It is a numerical fit with one analytic anchor, at $n=4$.**

Two consequences for this block.

- **The identity is circular as a check.** algebra.md line 23 records "the general relation is $\kappa=\theta^2\mathop{\mathrm{tr}}(L_e^2)$, which is [Observation L25](../findings/second-order.md)'s $\mathop{\mathrm{tr}}L_e^2=\kappa_W/\theta^2$ read the other way". So §6b's identity is the *definition* of $\kappa$ evaluated on this very table, compared against a formula fitted elsewhere. It is a genuine consistency check of the seven $(d_S,\lambda_S)$ pairs against numerics taken at other points, and a single wrong value would indeed break it, but it is not a theorem constraining the table.
- **The $n=4$ anchor is unavailable here.** $\kappa_{\rm Frob}(4)=\frac{7\cdot3}4=\frac{21}4$ and $\theta^2=\tfrac32$ at $W_{\mathbb{CP}^2}$ give $\mathop{\mathrm{tr}}(L_e^2)=\tfrac72$, which is what $\frac{3m(m-1)(4m-1)}{4(m+1)}$ returns at $m=2$. **That agreement is not evidence**: at $m=2$ row 4's dimension polynomial is $\frac{4\cdot3\cdot(-1)}4=-3$, so the $m=2$ evaluation is analytic continuation through a negative dimension and not an evaluation of any decomposition. [second-order.md](../findings/second-order.md) line 260 independently confirms that the table's own $\mathfrak{su}(m)$ formula is **false** at $m=2$: "*the formula gives $\tfrac23$ at $m=2$ where the true value is $\tfrac12$*".

**Verdict.** The block's sentence "Two identities check the whole list, and each fails if any single value is wrong by a rational function of $m$" is true of both identities as arithmetic. Its billing of them as Fox's, "Fox's Theorem 1.3 … gives … with $\kappa_F(n)=\dots$", overstates the second: at every $n=2m$ with $m\ge3$ there is no theorem behind $\kappa_F$'s value on the record. The correct statement of what the second identity delivers is *consistency with a fitted constant*, and the block should say so.

## 7. The second route to $\lambda_{\max}$, tested at more than the displayed row

### 7a. The displayed row, PROVEN

The block's line is $1+(m^2-1)y+\frac{m(m-1)}2+\frac{m^2(m-3)}2-\frac{m^2(m-1)}2=0$. Its four known terms are exactly §6a's, so $(m^2-1)y=-1-\frac{m^2-m}2-\frac{m^3-3m^2}2+\frac{m^3-m^2}2=-1+\frac{m^2+m}2=\frac{(m+2)(m-1)}2$, giving $y=\frac{(m+2)(m-1)}{2(m-1)(m+1)}=\frac{m+2}{2(m+1)}$. **The displayed algebra is exact.**

### 7b. One more row, as instructed: row 7, PROVEN

Hold rows 1, 2, 3, 4, 5, 6 fixed and solve for $y_7$ on $(2,2,0^{m-2})\oplus$ dual, of dimension $\frac{m^2(m^2-1)}6$. The other six contribute $1+\frac{(m-1)(m+2)}2+\frac{m(m-1)}2+\frac{m^2(m-3)}2=1+\frac{m^3-m^2-2}2=\frac{m^2(m-1)}2$. Hence

$$\frac{m^2(m^2-1)}6\,y_7=-\frac{m^2(m-1)}2,\qquad y_7=-\frac{6(m-1)}{2(m^2-1)}=-\frac3{m+1},$$

**uniquely, at every $m\ge2$** since $\frac{m^2(m^2-1)}6\ne0$. The block's value is recovered.

### 7c. The remaining rows, and where the uniqueness claim fails

- **Row 5**, dimension $\frac{2m^2(m^2-4)}3$: the other six sum to $0$, so $y_5=0$, unique for $m\ge3$ (the coefficient vanishes only at $m=0,\pm2$).
- **Row 6**, dimension $\frac{m^2(m-1)(m+3)}4$: likewise $y_6=0$, unique for $m\ge2$.
- **Row 4**, dimension $\frac{m^2(m+1)(m-3)}4$: the other six sum to $-\frac{m^2(m-3)}2$, so $\frac{m^2(m+1)(m-3)}4y_4=\frac{m^2(m-3)}2$ and $y_4=\frac2{m+1}$, **unique only for $m\ge4$.** At $m=3$ the equation is $0\cdot y_4=0$ and determines nothing.

**Verdict: the universal claim "each remaining class is recovered uniquely the same way" holds for $m\ge4$ and is vacuous at $m=3$ on row 4**, where the summand is absent, so nothing is owed and nothing is lost. It is a scoping correction, not a break.

**But the claim it supports is weaker than it sounds.** The block concludes "So $\lambda_{\max}$ rests on more than the charge formula". Each solve consumes six other values, five of which come from the charge formula, so the route recovers $\lambda_{\max}$ *given* the rest rather than independently of them. What $\mathop{\mathrm{tr}}L_e=0$ genuinely delivers is one scalar constraint that the whole $7$-vector satisfies, under which any single wrong entry is detected, real, and correctly described by the block's own "each fails if any single value is wrong". The stronger reading, that the $\mathfrak{su}(m)$ row has a second independent derivation, is **not** what the algebra shows.

## 8. The closed form for $e$, its tracelessness and norm, and the L70 slack, all PROVEN

[second-order.md](../findings/second-order.md) gives

$$e=\frac W\theta=-\frac1{2m-1}P_{\mathfrak m}+\frac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\frac{2(m-1)}{2m-1}P_\omega,\qquad\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)} .$$

The three projectors are complementary on $\Lambda^2\mathbb R^{2m}$: $\mathop{\mathrm{rank}}P_{\mathfrak m}=\dim\mathfrak{so}(2m)-\dim\mathfrak u(m)=m(2m-1)-m^2=m(m-1)$, $\mathop{\mathrm{rank}}P_{\mathfrak{su}(m)}=m^2-1$, $\mathop{\mathrm{rank}}P_\omega=1$, and $m(m-1)+(m^2-1)+1=m(2m-1)=\binom{2m}2$. ✓

### 8a. Exact tracelessness, PROVEN

$$(2m-1)\mathop{\mathrm{tr}}e=-m(m-1)+\frac{(m-2)(m^2-1)}{m+1}+2(m-1)=(m-1)\big[-m+(m-2)+2\big]=0 .$$

**Exactly zero, identically in $m$**, with no cancellation of surds needed, the coefficients are rational in $m$ because, as the source says, "the surd in $\theta$ cancels".

### 8b. $\lVert e\rVert^2=1/\theta^2$, PROVEN, and it pins the norm convention

$$(2m-1)^2(m+1)\mathop{\mathrm{tr}}(e^2)=(m-1)\Big[m(m+1)+(m-2)^2+4(m-1)(m+1)\Big]=(m-1)\big[m^2+m+m^2-4m+4+4m^2-4\big]$$
$$=(m-1)(6m^2-3m)=3m(m-1)(2m-1),$$

so $\mathop{\mathrm{tr}}(e^2)=\frac{3m(m-1)}{(2m-1)(m+1)}=1/\theta^2$. **Exact.**

**A symbol collision worth naming.** conventions.md's norm entry reads "This record's norm is $\lVert Z\rVert^2=\tfrac12\mathop{\mathrm{tr}}(Z^{\mathsf T}Z)$", stated for $\mathfrak{so}(n)$, i.e. for bivectors. The identity above holds under the **un-halved** $\lVert X\rVert^2=\mathop{\mathrm{tr}}(X^2)$ for curvature operators, and under the halved reading it would fail by a factor $2$, taking §6b's Fox check down with it. The L28 block names neither reading. Both are on the record and the arithmetic selects the un-halved one unambiguously, so nothing here is wrong, but the block relies on a convention it does not cite, in a file whose own conventions table flags this exact letter as a live collision.

### 8c. The slack against [L70](../findings/bounds.md) is exactly $2(m-2)\theta$, PROVEN

$W=\theta e$ has spectrum $\theta\cdot\{-\frac1{2m-1},\,\frac{m-2}{(m+1)(2m-1)},\,\frac{2(m-1)}{2m-1}\}$. For $m\ge3$ the middle value is strictly positive, so $\lambda_{\min}=-\frac\theta{2m-1}$ and $\lambda_{\max}=\frac{2(m-1)\theta}{2m-1}$, the middle is smaller than the top, since $2(m-1)>\frac{m-2}{m+1}$. With $n-2=2(m-1)$,

$$\lambda_{\min}+(n-2)\lambda_{\max}=\frac\theta{2m-1}\Big[-1+4(m-1)^2\Big]=\frac{\theta\,(2m-3)(2m-1)}{2m-1}=(2m-3)\theta,$$

using $4(m-1)^2-1=(2m-3)(2m-1)$. L70's identity gives $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$, so the slack is

$$\boxed{(2m-3)\theta-\theta=2(m-2)\theta},$$

**vanishing exactly at $m=2$ and strictly positive at every $m\ge3$.** The claim is confirmed in closed form.

**Two cross-checks that fall out.** L70's own text says "$W_{\mathbb{CP}^m}$ cannot saturate at $m\ge3$, since $\dim E_{\max}=1$ there against a required $m-1$", consistent, and here quantified. And its "both are attained exactly at $W_{\mathbb{CP}^2}$ at $n=4$, where they read $2$ and $1$" matches: at $m=2$, $\dim E_{\min}=m(m-1)=2\ge n/2=2$ and $\dim E_{\max}=1\ge(n-2)/2=1$, and the slack is $0$. **L70's hypotheses are met**: $W$ critical ✓, $\lVert W\rVert=1$ ✓ (L70 says "**And it needs $\lVert W\rVert=1$**"), $\lambda_{\min}\le0\le\lambda_{\max}$ ✓.

## 9. The landscape statement, INCONSISTENT AS WRITTEN with the table

[results.md](../results.md) line 142 says: "each is $1-\frac{c_S+q_S^2}{4(m+1)}$. **Only $\tfrac2{m+1}$ reaches $\tfrac12$, at $m=3$, where that summand is empty.**"

The table gives the orbit tangent $\tfrac12$ at **every** $m$. So read literally the landscape line is false: $\tfrac12$ reaches $\tfrac12$, at every $m$, on a summand that is never empty. The canonical block states the same fact correctly, with the qualifier the one-liner drops: "That holds **identically on the orbit**, and **among the rest** only $4(m-1)$ can meet it, at $m=3$ alone."

**Verdict.** The two are inconsistent as written, and the defect is in the landscape line, not in the block or the table. It is a dropped qualifier, and it matters because the landscape line is the one-sentence version a consumer reads: without "among the rest" it says the orbit tangent does not sit at $\tfrac12$, which would deny the very statement ($\dim E(\tfrac12)=\dim(\text{orbit})=m(m-1)$) that the lemma exists to make. **Repair**: insert "among the summands off the orbit" before "only".

## 10. The duplicate table, the two files AGREE

The block says "the same table stands at [second-order.md](../findings/second-order.md)". Opened both. Row for row:

| | nondegeneracy.md (L28) | second-order.md | agree? |
|---|---|---|---|
| 1 | $(0^m)$, $1$, $1$ | trivial $=W$, $1$, $1$ | ✓ |
| 2 | $(1,0^{m-2},-1)$, $m^2-1$, $\frac{m+2}{2(m+1)}$ | $\mathfrak{su}(m)$ adjoint, $m^2-1$, $\frac{m+2}{2(m+1)}$ | ✓ |
| 3 | $(1,1,0^{m-2})\oplus$ dual, $m(m-1)$, $\tfrac12$ | $\Lambda^2E\oplus\Lambda^2\bar E$, $m(m-1)$, $\tfrac12$ | ✓ |
| 4 | $(1,1,0^{m-4},-1,-1)$, $\frac{m^2(m+1)(m-3)}4$, $\frac2{m+1}$ | $V_{(1,1);(1,1)}$, same, same | ✓ |
| 5 | $(2,1,0^{m-3},-1)\oplus$ dual, $\frac{2m^2(m^2-4)}3$, $0$ | $V_{(2,1);(1)}\oplus$ conj, same, same | ✓ |
| 6 | $(2,0^{m-2},-2)$, $\frac{m^2(m-1)(m+3)}4$, $0$ | $V_{(2);(2)}$, $\frac{m^2(m+3)(m-1)}4$, $0$ | ✓ (factors reordered only) |
| 7 | $(2,2,0^{m-2})\oplus$ dual, $\frac{m^2(m^2-1)}6$, $-\frac3{m+1}$ | $V_{(2,2);\varnothing}\oplus$ conj, same, same | ✓ |

**Every dimension and every eigenvalue agrees, and the labellings are the same modules under two naming schemes** (the $GL(m)$ highest weight against the $V_{(\mu^+);(\mu^-)}$ bipartition) which match: $(1,1,0^{m-4},-1,-1)\leftrightarrow V_{(1,1);(1,1)}$, $(2,0^{m-2},-2)\leftrightarrow V_{(2);(2)}$, and so on. The L28 block adds the $c_S+q_S^2$ column; second-order.md adds the $\sharp$ closed forms and the definitions of $c_S,q_S$.

**One defect found in second-order.md, not in L28.** Line 279 reads "**Both $V_{(2,1);(1)}\oplus\text{conj}$ and $V_{(2);(2)}$ carry $c_S+q_S^2=4(m+1)$, hence $L_e=0$; the trace identity forces it, since the other five values already sum to zero against their dimensions.**" The first clause is right (§4). The second is an overstatement: the other five *do* sum to zero (§6a's cancellation), but the trace identity then gives only $d_5y_5+d_6y_6=0$, which does **not** force $y_5=y_6=0$. The charge formula forces it; the trace identity merely permits it. The L28 block does not repeat this error, its version, "each uniquely from the other four", solves one unknown at a time and is correct (§7c).

**A second, in the corroboration line.** second-order.md line 295's "hand assembly" $\frac{-(m+4)+3(m+1)+5(2m-1)}{3(m+1)(2m-1)}=\frac2{m+1}$ checks out: the numerator is $12m-6=6(2m-1)$, and $\frac{6(2m-1)}{3(m+1)(2m-1)}=\frac2{m+1}$. ✓ No defect there.

## 11. The traps, each answered by name

- **$\ker W\ne0$ and padded objects.** For $m\ge3$ the three eigenvalues of $e$ in §8 are $-\frac1{2m-1}<0$, $\frac{m-2}{(m+1)(2m-1)}>0$ and $\frac{2(m-1)}{2m-1}>0$, all nonzero, so $\ker W=0$ and conventions.md's $S(W)$ trap ("the screen is vacuous when $\ker W\ne0$") does not reach this block. The kernel appears exactly at $m=2$, outside the range. **On padding**: L28 makes no claim about padded copies and needs none, it is a statement about $\mathrm{Weyl}_{2m}$ natively. *A scope note for consumers*: the block's own motivation paragraph says route R2 needs "**every** graded critical point" nondegenerate, and L28 does not settle a padded $W_{\mathbb{CP}^m}$ inside $\mathcal W_{n_0}$ with $n_0>2m$, where both $E(\tfrac12)$ and the orbit change. That is a gap in the *consumer's* coverage argument, not in L28.
- **The boundary of every stated range, and the smallest admissible dimension.** $m=3$ is checked throughout and is where every delicacy sits: the charge $4(m-1)$ meets $2(m+1)$ there (§4b), the summand carrying it is absent there (§5), the branching rule the block cites does not apply there (§2), and the uniqueness of the trace solve fails there on that row (§7c). $m=2$ is checked as the boundary just outside: row 4's dimension goes negative, $\ker W\ne0$, the $\mathfrak{su}(m)$ formula returns $\tfrac23$ against a true $\tfrac12$, and the L70 slack vanishes. **The restriction to $m\ge3$ is necessary and the record knows why.**
- **A claim proven on a subfamily and used in general.** This one bites, inverted: multiplicity-freeness is proven for $m\ge4$ and used at $m=3$ (§2).
- **A hypothesis stated but never used.** None. $\theta^2$ looks decorative in the statement but is consumed by §6b and §8; $m\ge3$ is consumed at every step above.
- **A step using a hypothesis never stated.** Three: $\lVert W\rVert=1$ (H2), the self-adjointness of $L_e$ (H6), and Fox's five hypotheses (H7). All three are true and none is cited in the block. The first is the one that could bite a reader, since L70's slack and the Fox check are both scale-dependent and L70 says so explicitly.
- **A universal claim with no witness.** "each remaining class is recovered uniquely the same way", I supplied the witnesses (rows 4, 5, 6, 7 in §7c) rather than accepting the claim, and found the one exception at $m=3$.
- **An imported theorem whose hypotheses were never checked.** Fox's Theorem 1.3 is the import, and I went to the source transcription. **It carries no unitality hypothesis**, so the failure mode that killed the earlier route does not recur; all five of its actual hypotheses hold for $\mathcal W_{2m}$ at $m\ge3$ (§6c). What the import *does* carry is an overstated scope: the closed form of $\kappa_F$ is presented as part of the theorem and is not (§6d).
- **Symbol collisions, $c$, $q$, $P$, $e$, $\lambda$.** All live in this block and all resolve. $c$ here is $c_S$, the $GL(m)$ Casimir-type charge, against conventions.md's $c$ in [L47](../findings/problem.md)'s working symbols and [L44](../findings/problem.md)'s, no contact. $q$ here is $q_S=\sum_i\nu_i$, the $U(1)$ charge, against the two senses conventions.md tables inside [stratum-two-negative.md](../findings/stratum-two-negative.md) (a Weitzenböck operator and a scalar parameter of $W_4(q,r)$), no contact. $P$ carries three objects at once in this block: the cubic form $P(W)$, the projectors $P_{\mathfrak m},P_{\mathfrak{su}(m)},P_\omega$ of §8, and $\Pi$'s cousin as an orthogonal projection, **the projectors are the collision that matters**, since $P_\omega$ and $P(W)$ appear within a few lines of one another in second-order.md and neither is tabled in conventions.md. $e$ is $W/\theta$ throughout, per conventions.md line 119, and never Euler's constant or an idempotent in Fox's separate normalisation ($e$ is an idempotent of $\circ$, and $\lvert e\rvert=1/\theta\ne1$, which the Fox notes flag as the normalisation trap: "Idempotents here are not unit vectors"). $\lambda$ carries the $L_e$ eigenvalues $\lambda_S$, the $W$-eigenvalues $\lambda_{\min},\lambda_{\max}$ in §8c, and the $O(2m)$ label $\lambda=(2,2)$ of the branching rule, **three senses in one block**, and the third appears in the very sentence introducing the first.

## 12. Verdict

**PROVEN, hypotheses corrected.**

**What is right.** Every number in the block. The ten/seven/three counts, all seven dimensions, all seven charges, including the repaired column, recomputed here from the definitions and not from the repair's own account, the eigenvalue formula and its $\tfrac12$ criterion, the $m=3$ meeting of $4(m-1)$ with $2(m+1)$, $\lambda_{\max}=\frac{m+2}{2(m+1)}>\tfrac12$, both trace identities, the trace solve on the $\mathfrak{su}(m)$ row and on three more rows, the closed form's exact tracelessness and norm, and the L70 slack $2(m-2)\theta$. I found **no arithmetic error anywhere in the block**, and the $m=3$ absence is sound on grounds stronger than the ones the block gives for it.

**What is corrected.**

1. **HYPOTHESIS-DEBT, $m=3$, multiplicity-freeness.** The branching rule the block cites carries the hypothesis $m\ge4$ in the record's own reference notes, and $m=3$ is the case the headline "with **no exception**" turns on. What would have to be proved: that each of the six surviving $GL(3)$-irreps occurs in $\mathrm{Weyl}_6\otimes\mathbb C$, given occurrence, the dimension identity $1+8+6+30+27+12=84$ closes multiplicity-freeness at $m=3$ by itself. I supply no substitute argument.
2. **HYPOTHESIS-DEBT, $\kappa_F$.** Its closed form is this record's numerical fit with a single analytic anchor at $n=4$, which the table cannot reach; the block presents it as Fox's Theorem 1.3. The first identity is theorem-backed; the second is a consistency check against a fitted constant, and is $\kappa=\theta^2\mathop{\mathrm{tr}}(L_e^2)$ read backwards.
3. **Scope, three places.** "ten"/"seven" is nine/six at $m=3$; "each remaining class is recovered uniquely" fails on row 4 at $m=3$, vacuously; the absence at $m=3$ is attributed to a rule that has no content there.
4. **Overstatement, one place.** "So $\lambda_{\max}$ rests on more than the charge formula", the trace solve consumes six other values, five of them from the charge formula, so it recovers $\lambda_{\max}$ given the rest rather than independently of it.
5. **Inconsistency in [results.md](../results.md) line 142.** "Only $\tfrac2{m+1}$ reaches $\tfrac12$" needs "among the summands off the orbit"; without it the landscape line denies the table's own orbit row.
6. **Defect in [second-order.md](../findings/second-order.md) line 279**, not in L28. "the trace identity forces it" for the two zero rows is false as stated: the identity gives $d_5y_5+d_6y_6=0$ and no more. The charge formula is what forces them.

**What survives untouched.** The lemma's conclusion at every $m\ge4$ is proven outright by the material on file. At $m=3$ the conclusion is very likely true and rests, on the record, on a numerical measurement plus a citation outside its stated range. **The nondegeneracy claim and the non-maximality claim are both sound; the $m=3$ instance of the first is the one thing this block asserts and does not prove.**
