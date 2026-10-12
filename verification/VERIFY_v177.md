# Verifier v177, Lemma L47, the dimension lemma for symmetric spaces

Read cold from the definitions in [conventions.md](../findings/conventions.md) and the verbatim extracts in [BRIEF_L47.md](BRIEF_L47.md). **No numerical work was done: no script was run, no Sage, no Python, no floating-point evaluation.** Every value below was obtained by hand in closed form from Petersen–Stanfield's Proposition 2.1 and from integer Lie-algebra dimensions, and every one is exact; the decimal figures printed for the isotropy-bound ratios are divisions of exact rationals, shown to three places for reading only. The proof script [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py) was **read, never executed**. Log: [agent_logs/verify-L47-v177.log](../agent_logs/verify-L47-v177.log).

## The claim table

| # | claim, as written | verdict |
|---|---|---|
| 1 | The normalisation: Einstein constant $\tfrac12$ forces $\operatorname{tr}R=n/4$, $c=\frac1{2(n-1)}$, $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$ | **CONFIRMED**, re-derived, and it is PS's own normalisation, not an extra hypothesis |
| 2 | Cauchy–Schwarz over the isotropy blocks gives $\lVert R\rVert^2\ge(n/4)^2/\dim\mathfrak h$ | **CONFIRMED**, but its real input is the *rank* fact, and the block cites the wrong proposition for it |
| 3 | $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}\Rightarrow\lVert W\rVert^2\ge\tfrac16$ | **CONFIRMED, the algebra is exact and reversible**; the loss sits entirely at claim 2 |
| 4 | Equality in claim 2 is attainable | **CONFIRMED, and attained on a large family**, every simple-isotropy space, $\mathbb{OP}^2$ and all type-II groups included |
| 5 | [Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/) Prop 2.2 says what is claimed of it | **CONFIRMED at source**, hypotheses hold; **MISCITED**, the load-bearing statement is Prop 2.1 plus the injectivity paragraph, not 2.2 |
| 6 | The eight certificate constants $616,48,7200,114,3696,2192,236,84$ | **CONFIRMED**, all eight reconstructed independently before the script was opened, then matched to it family by family |
| 7 | "all-nonnegative-coefficient certificate … after shifting to its first admissible rank" | **CONFIRMED in substance, MISDESCRIBED in words**, two of the eight shifts land outside the lemma's own quantifier |
| 8 | The twelve exceptional spaces check directly, mostly by an order of magnitude | **CONFIRMED**, all twelve re-checked by hand; $\mathbb{OP}^2$ at ratio $0.675$ and $G_2/SO(4)$ at $0.464$ are the two that are not an order of magnitude |
| 9 | $\mathbb{CP}^m$, $\mathbb{HP}^m$ minima $\tfrac16$ and $\tfrac{45}{224}$ | **VALUES CONFIRMED; the minimality is a GAP**, the record checks $2\le m\le6$ and proves no monotonicity |
| 10 | The residue is exhaustive | **CONFIRMED relative to the eight families and twelve pairs**; the completeness of *that* index set is not on file |
| 11 | $\theta\le\sqrt{3/2}$, equality only at $\mathbb{CP}^2$ | **CONFIRMED as an implication; the final sentence is false as written** at $S^n$ and $\mathbb{RP}^n$, where $\theta$ is undefined |
| 12 | The canonical block carries the proof | **NO**, the block carries eight bare integers; the only proof is a script it does not cite |

**One line.** Every number in L47 is right, I re-derived all eight certificate constants, both residue minima, all twelve exceptional rows and the $\mathbb{OP}^2$ value independently and each matched exactly, but the argument on file has one real hole (the residue minima are verified on five members of two infinite families and nowhere proved minimal) and the canonical block states no polynomial, names no family, and points at no proof, so **GAP**.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

> $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

> **$\operatorname{scal}=2\operatorname{tr}$ on $\Lambda^2$.**

> **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal

> $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$

> $\mathfrak m$, $\mathfrak h$, $\mathfrak r$ | at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$ and $\mathfrak r$ everything else, kernel included.

> $R_I$, $R_{\mathrm{ric}_0}$, $R_W$ | the three $O(n)$-irreducible pieces of an algebraic curvature operator, scalar, **trace-free** Ricci, and Weyl.

> **The Killing constant of a SUBALGEBRA** $\mathfrak g$ simple: $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$, with $c=2h^\vee(\mathfrak g)/I_\rho$

> **THE LETTER $B$ MEANS TWO THINGS, live.**

The relevant reading of the last four rows is §9 below: **L47 uses $\mathfrak h$, $R$, $c$ and $B$ in senses none of those rows carries.**

## 1. The hypothesis inventory

**A pass with no inventory is not a pass, so this is the inventory before anything else.**

### 1.1 Hypotheses the statement declares

| hypothesis | where it enters the proof | verdict |
|---|---|---|
| **compact** | makes $-B_{\mathfrak g}$ positive definite, so the metric exists and $\lambda=+\tfrac12$ rather than $-\tfrac12$; it is also PS §2.4's standing assumption | **used, load-bearing** |
| **irreducible** | selects the index set the census runs over; and supplies $[\mathfrak p,\mathfrak p]=\mathfrak h$, which is what makes $\mathfrak h\to\Lambda^2T M$ injective (§3.2) | **used, load-bearing, and one of its two uses is unstated** |
| **rank $\ge2$** | it is exactly the parameter restriction that shifts each family past the rank-one members, which are precisely the members where the dimension bound fails (§7.3) | **used, load-bearing, this is not a decorative hypothesis** |
| **and for $\mathbb{OP}^2$** | $\mathbb{OP}^2$ is rank one and passes the bound anyway, at ratio $0.675$, the tightest of the whole C–S branch | **used; and the singling-out is earned** |
| **normalised to Einstein constant $\tfrac12$** | fixes $\operatorname{tr}R=n/4$ and $c$; it is PS's metric $-B_{\mathfrak g}$ and therefore a *choice of representative*, not a restriction | **used; and it costs nothing, since $\theta$ is scale-invariant** |

### 1.2 Hypotheses imported with [L46](../findings/problem.md), and which of them L47 discharges

[L46](../findings/problem.md)'s own audit note records four: *"locally symmetric, Einstein, $\lambda\ne0$, $\lambda=\tfrac12$"*, and adds a fifth in the same breath, **"the conclusion needs $W\ne0$ and neither the block nor the canon says so."**

- **locally symmetric**, discharged: symmetric $\Rightarrow$ locally symmetric.
- **Einstein**, discharged: PS §2.4 derives $\mathrm{Ric}=\tfrac12g$ from the metric $-B_{\mathfrak g}$ for any compact semisimple $G$, so it is a consequence of the normalisation rather than an added assumption.
- **$\lambda\ne0$**, discharged: $\lambda=\tfrac12$ throughout.
- **$\lambda=\tfrac12$**, discharged by the normalisation, and it is PS's own; there is no convention mismatch to convert.
- **$W\ne0$**, **NOT discharged, and it is exactly the residue's first row.** See §8.

### 1.3 Hypotheses the proof uses and never states

1. **$\operatorname{rank}R=\dim\mathfrak h$**, the actual input to Cauchy–Schwarz. The block gestures at it with the words *"over the isotropy blocks"* and cites Prop 2.2 for *"eigenvalues"*. §3.
2. **$[\mathfrak p,\mathfrak p]=\mathfrak h$ (effectiveness)**, without it the map $\mathfrak h\to\Lambda^2TM$ need not be injective and $\dim\mathfrak h$ overcounts the rank. PS prove injectivity from it explicitly.
3. **$p\le q$ in the three Grassmannian families**, the script imposes it by writing $q=2+a+b$; it is legitimate because $\mathrm{Gr}(p,q)\cong\mathrm{Gr}(q,p)$, and that symmetry is nowhere stated.
4. **Locality**, $\lVert W\rVert^2$ and $\theta$ are local invariants, which is the only reason the census over simply-connected pairs settles $\mathbb{RP}^n$ and the other finite quotients. The block names $\mathbb{RP}^n$ and so is quantifying over the non-simply-connected class, while PS's Prop 2.1 is stated with $H$ the *identity* component of a fixed-point subgroup.

### 1.4 A hypothesis stated and never used

**None found.** Every hypothesis in §1.1 is consumed. I looked hardest at "rank $\ge2$", which reads like a convenience and is not: at rank one the bound fails outright for every $\mathbb{CP}^m$ (§7.3).

## 2. The normalisation, re-derived

With $\lambda=\tfrac12$ and $\operatorname{scal}=2\operatorname{tr}$ on $\Lambda^2$: $\operatorname{scal}=n\lambda=n/2$, so $\operatorname{tr}R=n/4$. With $c=\lambda/(n-1)=\frac1{2(n-1)}$ and $W=R-cI$, $\lVert I\rVert^2=N=\binom n2$:

$$\lVert W\rVert^2=\lVert R\rVert^2-2c\operatorname{tr}R+c^2N=\lVert R\rVert^2-\frac n{4(n-1)}+\frac n{8(n-1)}=\lVert R\rVert^2-\frac n{8(n-1)} .$$

Identical to L46's display $\lVert R\rVert^2-(\operatorname{tr}R)^2/N$, since $(n/4)^2\big/\tfrac{n(n-1)}2=\frac n{8(n-1)}$. **Claim 1 confirmed.**

Petersen–Stanfield's own line is the same, at source: *"$\tfrac12\dim_{\mathbb R}M=\operatorname{scal}=2\operatorname{tr}R$"*, so their $\operatorname{scal}=2\operatorname{tr}$ agrees with [conventions.md](../findings/conventions.md) and their Einstein constant is $\tfrac12$ by construction. **No conversion is owed at the import.**

## 3. The Cauchy–Schwarz step, derived, and what it actually needs

### 3.1 The derivation

Let $\mathfrak g=\mathfrak h\oplus\mathfrak p$ with the metric $-B_{\mathfrak g}$, and let $\beta:\Lambda^2\mathfrak p\to\mathfrak h$, $X\wedge Y\mapsto[X,Y]$. Since $R(X,Y)Z=-[[X,Y],Z]$, ad-invariance gives $\langle R(X\wedge Y),Z\wedge W\rangle=\langle[X,Y],[Z,W]\rangle$, i.e. $R=\beta^{*}\beta$. Hence $\operatorname{im}R\subseteq\operatorname{im}\beta^{*}$ and $\operatorname{rank}R\le\dim\mathfrak h$. Writing the nonzero spectrum as $\{\lambda_i\}$ with multiplicities $d_i$, $\sum_id_i\le\dim\mathfrak h$ and $\sum_id_i\lambda_i=\operatorname{tr}R=n/4$, so

$$\Big(\tfrac n4\Big)^2=\Big(\sum_id_i\lambda_i\Big)^2\le\Big(\sum_id_i\Big)\Big(\sum_id_i\lambda_i^2\Big)\le\dim\mathfrak h\cdot\lVert R\rVert^2 .$$

**Claim 2 confirmed.**

### 3.2 What it needs, and it is less than the block says

It needs **only** $\operatorname{rank}R\le\dim\mathfrak h$ and $\operatorname{tr}R=n/4$. It does **not** need the blocks to be the isotypic pieces, it does not need $R\succeq0$, and it does not need any eigenvalue to be known. The isotypic decomposition is what lets one *evaluate* $\lVert R\rVert^2$ exactly (which the residue and the exceptional rows do use) but it is strictly more than Cauchy–Schwarz consumes.

The rank fact **is** on file at source, in PS Prop 2.1 and in the proof of Prop 2.2: *"The curvature operator of $\mathfrak g$ is $G$-invariant with image $\mathfrak h\subset\Lambda^2T_pM$."* The block cites Prop 2.2 *"whose eigenvalues are Petersen–Stanfield Prop 2.2"*, i.e. it cites the proposition that gives the eigenvalues rather than the one that gives the image. **The step is sound; the citation points at the wrong sentence.**

### 3.3 Equality is attainable, and attained on a family

Equality holds iff all nonzero $\lambda_i$ coincide **and** $\sum d_i=\dim\mathfrak h$ (no kernel inside $\mathfrak h$). PS Theorem C, at source: *"If $M=G/H$ where $H$ is simple, then there is only one nonzero eigenvalue $\lambda=\frac14\frac{\dim M}{\dim H}$."* So Cauchy–Schwarz is **exact** on every simple-isotropy space.

Two consequences worth recording:

- **Type II, the compact simple Lie groups.** $\mathfrak h=\Delta\mathfrak g$ so $\dim\mathfrak h=n$, and $B_{\mathfrak g\oplus\mathfrak g}\vert_{\Delta}=2B_{\mathfrak g}$ gives $\lambda=\tfrac12(1-\tfrac12)=\tfrac14$, whence $\operatorname{tr}R=n/4$ exactly and $\lVert R\rVert^2=n/16=(n/4)^2/n$. Equality. Then $\lVert W\rVert^2=\frac n{16}-\frac n{8(n-1)}=\frac{n(n-3)}{16(n-1)}$, **which is exactly the closed form [graded-half.md](../findings/graded-half.md) prints for this class**, reached here from PS Prop 2.1 alone.
- **$\mathbb{OP}^2=F_4/\mathrm{Spin}(9)$.** $\mathfrak h=\mathfrak{so}(9)$ is simple, so $\lambda=\tfrac14\cdot\tfrac{16}{36}=\tfrac19$, $\lVert R\rVert^2=36/81=\tfrac49$, and $\lVert W\rVert^2=\tfrac49-\tfrac{16}{120}=\tfrac{14}{45}$. Equality again, so the C–S branch loses nothing at the one rank-one space it keeps.

**So the answer to "is equality attainable" is yes, on an infinite family, and the step is sharp rather than merely valid.** Claim 4 confirmed.

## 4. The implication, exact or lossy

$\lVert W\rVert^2\ge\frac{n^2}{16h}-\frac n{8(n-1)}\ge\tfrac16$ with $h=\dim\mathfrak h$ rearranges as

$$\frac{n^2}{16h}\ \ge\ \frac16+\frac n{8(n-1)}=\frac{8(n-1)+6n}{48(n-1)}=\frac{7n-4}{24(n-1)}\quad\Longleftrightarrow\quad h\le\frac{24n^2(n-1)}{16(7n-4)}=\frac{3n^2(n-1)}{2(7n-4)} .$$

Every step is an equivalence for $n\ge2$ (both $n-1>0$ and $7n-4>0$). Equivalently, clearing denominators by $48h(n-1)>0$, the condition is

$$P(n,h):=3n^2(n-1)-2(7n-4)h\ \ge\ 0 .$$

**The algebra is exact and reversible; the implication is one-way only because Cauchy–Schwarz is.** All of the loss sits at §3, and §3.3 says where that loss is zero. **Claim 3 confirmed.**

## 5. Petersen–Stanfield Proposition 2.2, read at source

Verbatim from [petersen-stanfield-2508.11236.txt](https://arxiv.org/abs/2508.11236):

> **Proposition 2.2.** The decomposition $\mathfrak h=\mathfrak h_0\oplus_i\mathfrak h_i$ is precisely the decomposition into eigenspaces for $R$ and the eigenvalue for $\mathfrak h_0$ is the Einstein constant $\tfrac12$.

and its engine, Proposition 2.1:

> Under the identification $\mathfrak h\simeq\mathrm{ad}_{\mathfrak h}\vert_{\mathfrak p}\subset\Lambda^2TM$, the curvature operator of $\mathfrak g$ is given by $R=\tfrac12(I-P)$,

with $P$ defined by $B_{\mathfrak g}(P\cdot,\cdot)\vert_{\mathfrak h\times\mathfrak h}=B_{\mathfrak h}$. On a simple ideal $\mathfrak h_j$ with $B_{\mathfrak g}\vert_{\mathfrak h_j}=s_jB_{\mathfrak h_j}$ this gives $R\vert_{\mathfrak h_j}=\tfrac12(1-1/s_j)$, and $P=0$ on the centre so $R\vert_{\mathfrak h_0}=\tfrac12$.

**Hypotheses, checked against the objects here.** PS's setting is *"a compact symmetric space of the form $M=G/H$, where $G$ is a compact semisimple Lie group and $H$ is the identity component of the fixed point subgroup of an involutive automorphism of $G$"*, metric $-B_{\mathfrak g}\vert_{\mathfrak p}$. Each clause holds for L47's objects, including the type-II spaces, since $G\times G$ is semisimple and the flip is involutive. **The one clause that does not transfer verbatim is "identity component"**: $\mathbb{RP}^n$ is not of that form, and the bridge is locality (§1.3, item 4).

**Independent check that I read the same operator the record does.** Building $R=\beta^*\beta$ from scratch and expanding the $\mathfrak p$-Casimir gives $R\vert_{\mathfrak h_j}=\tfrac12(1-1/s_j)$, the same formula, arrived at without opening PS. Testing it: $\mathfrak{su}(m)\subset\mathfrak{su}(m+1)$ has $s=\frac{m+1}m$, giving $\frac1{2(m+1)}$, and the centre gives $\tfrac12$; at $m=2$ that is the spectrum $(\tfrac12;\tfrac16,\tfrac16,\tfrac16;0,0)$ on $\Lambda^2\mathbb R^4$, which is [graded-half.md](../findings/graded-half.md)'s own $\mathbb{CP}^2$ row.

**One caveat on the proposition itself, not load-bearing here.** Its proof asserts that the $\mathfrak h_i$ are *"pairwise inequivalent as $\mathrm{Ad}(H)$ representations"* without argument, and PS immediately note that $\lambda_i=\lambda_j$ can happen ($SO(8)/(SO(4)\times SO(4))$ has four factors and one nonzero eigenvalue), so the decomposition is a *refinement* of the eigenspace decomposition rather than equal to it. **L47 needs neither the inequivalence nor the eigenspace identification** (only rank and trace) so the caveat does not reach it. Claim 5 confirmed, with the miscitation of §3.2 recorded.

## 6. The eight certificate constants

### 6.1 What I did, in order

I reconstructed the constants **before opening the script**, from the cleared inequality $P(n,h)=3n^2(n-1)-2(7n-4)h$ evaluated at each family's smallest rank-$2$ member. Six landed immediately: $616$, $7200$, $114$, $3696$, $2192$, $236$. The remaining two, $48$ and $84$, matched no *irreducible* corner; solving $P=48$ and $P=84$ over integer $(n,h)$ at small $n$ left only $(4,2)$ and $(6,6)$, $S^2\times S^2$ and $S^3\times S^3$, **reducible**. I then read the script and both were confirmed.

### 6.2 The table

| family | parameterisation, shifted | corner | $(n,\dim\mathfrak h)$ | $P$ |
|---|---|---|---|---|
| AIII $\mathrm{Gr}_{\mathbb C}(p,q)$ | $p=2+a$, $q=2+a+b$ | $p=q=2$ | $(8,7)$ | $616$ |
| BDI $\mathrm{Gr}_{\mathbb R}(p,q)$ | $p=2+a$, $q=2+a+b$ | $p=q=2$ | $(4,2)$ | $48$ |
| CII $\mathrm{Gr}_{\mathbb H}(p,q)$ | $p=2+a$, $q=2+a+b$ | $p=q=2$ | $(16,20)$ | $7200$ |
| AI $SU(m)/SO(m)$ | $m=3+a$ | $m=3$ | $(5,3)$ | $114$ |
| AII $SU(2m)/Sp(m)$ | $m=3+a$ | $m=3$ | $(14,21)$ | $3696$ |
| DIII $SO(2m)/U(m)$ | $m=4+a$ | $m=4$ | $(12,16)$ | $2192$ |
| CI $Sp(m)/U(m)$ | $m=2+a$ | $m=2$ | $(6,4)$ | $236$ |
| II, $G$ compact simple | $n=6+a$, $\dim\mathfrak h=n$ | $n=6$ | $(6,6)$ | $84$ |

**All eight, exactly, as a set and family by family.** Claim 6 confirmed.

### 6.3 The certificate mechanism, checked by hand on five of the eight

"All coefficients nonnegative after the shift, constant term strictly positive" gives $P>0$ for all real $a,b\ge0$, hence strictly for every family member. That is a sound certificate style. I verified it in closed form for:

- **AI.** With $m=3+x$ and $u=x^2+7x$: $8P=3u^3+56u^2+364u+56ux+496x+912$, every coefficient nonnegative in $x$, constant $912/8=114$.
- **Type II.** $P(6+x)=(6+x)\big(3(6+x)^2-17(6+x)+8\big)=3x^3+37x^2+128x+84$.
- **CI.** $P=m^2\,f(m)$ with $f=3m^4+9m^3-8m^2-17m+5$; $f(2)=59$ and $f',f'',f''',f''''$ are all positive at $m=2$, so $f(2+a)$ has nonnegative coefficients, and $m^2=(2+a)^2$ does too. Constant $4\cdot59=236$.
- **DIII.** $P=m^2\,g(m)$ with $g=3m^4-9m^3-8m^2+17m+5$; $g(4)=137$ and all four derivatives are positive at $m=4$. Constant $16\cdot137=2192$.
- **BDI**, both one-parameter slices: $P(0,b)=10b^3+66b^2+112b+48$, and the diagonal slice $b=0$ takes the values $48,1236,8928,38160,\dots$

AIII, CII and AII I checked at their corners only. **The mechanism is real and I could not make it fail.**

### 6.4 What a reader can and cannot check from what is on file

**Cannot**, from the canonical block: which family any constant belongs to; what any polynomial is; in what variables the shift is taken; whether the shift is one-parameter or two; whether "nonnegative coefficients" is claimed in the monomial basis or another. The eight integers are the entire content, and the constant term of a polynomial says nothing about the sign of its other coefficients, so the phrase *"all-nonnegative-coefficient certificate"* is **not verifiable from the block at all**, only reconstructible.

**Can**, if pointed at [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py): everything above, by hand, without running it. **The canonical block does not point at it.** [graded-half.md](../findings/graded-half.md) does.

## 7. The twelve exceptional spaces, and the shape of the census

### 7.1 The twelve, checked by hand

$\dim\mathfrak h$ from [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/)'s pairs, $n=\dim\mathfrak g-\dim\mathfrak h$, bound $=\frac{3n^2(n-1)}{2(7n-4)}$:

| Cartan | pair | $n$ | $\dim\mathfrak h$ | bound | ratio |
|---|---|---|---|---|---|
| EI | $\mathfrak e_6/\mathfrak{sp}(4)$ | $42$ | $36$ | $216972/580$ | $0.096$ |
| EII | $\mathfrak e_6/(\mathfrak{su}(6)\oplus\mathfrak{su}(2))$ | $40$ | $38$ | $187200/552$ | $0.112$ |
| EIII | $\mathfrak e_6/(\mathfrak{so}(10)\oplus\mathfrak u(1))$ | $32$ | $46$ | $95232/440$ | $0.213$ |
| EIV | $\mathfrak e_6/\mathfrak f_4$ | $26$ | $52$ | $50700/356$ | $0.365$ |
| EV | $\mathfrak e_7/\mathfrak{su}(8)$ | $70$ | $63$ | $1014300/972$ | $0.060$ |
| EVI | $\mathfrak e_7/(\mathfrak{so}(12)\oplus\mathfrak{su}(2))$ | $64$ | $69$ | $774144/888$ | $0.079$ |
| EVII | $\mathfrak e_7/(\mathfrak e_6\oplus\mathfrak u(1))$ | $54$ | $79$ | $463644/748$ | $0.127$ |
| EVIII | $\mathfrak e_8/\mathfrak{so}(16)$ | $128$ | $120$ | $6242304/1784$ | $0.034$ |
| EIX | $\mathfrak e_8/(\mathfrak e_7\oplus\mathfrak{su}(2))$ | $112$ | $136$ | $4177152/1560$ | $0.051$ |
| FI | $\mathfrak f_4/(\mathfrak{sp}(3)\oplus\mathfrak{su}(2))$ | $28$ | $24$ | $63504/384$ | $0.145$ |
| FII $=\mathbb{OP}^2$ | $\mathfrak f_4/\mathfrak{so}(9)$ | $16$ | $36$ | $11520/216$ | $0.675$ |
| G | $\mathfrak g_2/(\mathfrak{su}(2)\oplus\mathfrak{su}(2))$ | $8$ | $6$ | $1344/104$ | $0.464$ |

All twelve pass **strictly**. The EVIII row reproduces [graded-half.md](../findings/graded-half.md)'s printed *"$\dim\mathfrak h=120$ against a bound of $3499$"* exactly. *"Mostly by an order of magnitude"* is accurate, ten of twelve sit below ratio $0.25$; **$\mathbb{OP}^2$ and $G_2/SO(4)$ are the two that do not**, and the block's word "mostly" already concedes that. **Claim 8 confirmed.**

**No Casimir data is needed for any of these rows**, only $\dim\mathfrak g$ and $\dim\mathfrak h$. The [ROUND](ROUND_L47.md)'s worry that *"exceptional-pair Casimir data is the one fact it could source nowhere"* does not bite the dimension lemma. What it does bite is §10's discussion of what is sourced.

### 7.2 Quantifier order and scope, the argument is not uniform

The lemma has two layers, and only the first is uniform:

1. **Uniform, at every space at once**: $\operatorname{tr}R=n/4$, $\operatorname{rank}R\le\dim\mathfrak h$, Cauchy–Schwarz, and the exact rearrangement of §4. Nothing here refers to a classification.
2. **Case by case, over a list**: the hypothesis $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}$ is verified eight families at a time plus twelve singletons.

**So at a space not on the list a reader may cite nothing.** The conclusion $\lVert W\rVert^2\ge\tfrac16$ is not a theorem about symmetric spaces in general; it is a theorem about the members of a specific enumeration. That is not a defect of the argument, but it means the lemma's strength is exactly the strength of §10's sourcing.

### 7.3 The edge of every range

- **Rank exactly $2$, each family.** The corners are §6.2's table: $(n,h)$ of $(8,7)$, $(4,2)$, $(16,20)$, $(5,3)$, $(14,21)$, $(12,16)$, $(6,4)$, $(6,6)$. Every one passes.
- **The smallest $n$.** $n=4$ is the smallest at which $\mathcal W_n\ne0$ and it is $\mathbb{CP}^2$, the equality case, whose $\dim\mathfrak h=4$ **exceeds** the bound $\frac{3\cdot16\cdot3}{2\cdot24}=3$. The C–S branch does not reach the equality case, and cannot: at $\mathbb{CP}^m$, $h\le\text{bound}$ reads $m^2(7m-2)\le3m^2(2m-1)$, i.e. $m\le-1$, **false at every $m$.**
- **Odd $n$.** $n=5$ (AI, $SU(3)/SO(3)$) is the smallest odd member and passes with $3\le300/62$. Nothing in $P(n,h)$ has parity in it, so there is no odd-$n$ hazard of the kind [conventions.md](../findings/conventions.md) records for $\theta_0$ against $\Theta_n$. **This is not the family of results where that trap lives.**
- **$\mathbb{OP}^2$, kept while the other rank-one spaces are handed away.** Kept because it passes: $36\le11520/216=53.33$, ratio $0.675$, **the largest ratio anywhere in the C–S branch**, so it is the binding case and the singling-out is earned rather than cosmetic.
- **The narrowest miss on the record.** $\mathbb{HP}^2$: $\dim\mathfrak h=\dim\mathfrak{sp}(2)+\dim\mathfrak{sp}(1)=13$ against $\frac{3\cdot64\cdot7}{2\cdot52}=\frac{168}{13}$, so it exceeds the bound **by exactly $\tfrac1{13}$**. It is in the residue for that reason. For $m\ge3$, $\mathbb{HP}^m$ falls inside the bound: the condition is $10m^3-11m^2-20m+3\ge0$, which is $-1$ at $m=2$ and $114$ at $m=3$.

## 8. The residue

### 8.1 $\mathbb{CP}^m$ and $\mathbb{HP}^m$ in closed form, both minima confirmed

From PS Prop 2.1 by hand, at Einstein constant $\tfrac12$.

**$\mathbb{CP}^m$**, $n=2m$, $\mathfrak h=\mathfrak u(m)$: eigenvalue $\tfrac12$ on the centre and $\frac1{2(m+1)}$ on $\mathfrak{su}(m)$ (from $s=\frac{m+1}m$), rest zero. Then $\operatorname{tr}R=\tfrac12+\frac{m^2-1}{2(m+1)}=\frac m2=\frac n4$ ✓, $\lVert R\rVert^2=\frac m{2(m+1)}$, and

$$\lVert W\rVert^2=\frac m{2(m+1)}-\frac{2m}{8(2m-1)}=\frac{3m(m-1)}{4(m+1)(2m-1)} .$$

At $m=2$ this is $\tfrac6{36}=\tfrac16$ **exactly**, and $\theta^2=1/(4\lVert W\rVert^2)=\frac{(m+1)(2m-1)}{3m(m-1)}$, **the record's own $\mathbb{CP}^m$ formula, reproduced independently.** It is strictly increasing: $\frac{d}{dm}\frac{m^2-m}{2m^2+m-1}$ has numerator $3m^2-2m+1>0$.

**$\mathbb{HP}^m$**, $n=4m$, $\mathfrak h=\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$: from $s_1=\frac{m+2}{m+1}$ and $s_2=\frac{m+2}2$ the eigenvalues are $\frac1{2(m+2)}$ on $\mathfrak{sp}(m)$ and $\frac m{2(m+2)}$ on $\mathfrak{sp}(1)$. Then $\operatorname{tr}R=\frac{m(2m+1)+3m}{2(m+2)}=m=\frac n4$ ✓, $\lVert R\rVert^2=\frac{m(5m+1)}{4(m+2)^2}$, and since $(5m+1)(4m-1)-2(m+2)^2=9(2m+1)(m-1)$,

$$\lVert W\rVert^2=\frac{9m(2m+1)(m-1)}{4(m+2)^2(4m-1)} .$$

At $m=2$: $\frac{9\cdot2\cdot5\cdot1}{4\cdot16\cdot7}=\frac{90}{448}=\tfrac{45}{224}$, **exactly the claimed minimum**, and $\theta^2=\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$, which is the record's formula and gives $\tfrac{56}{45}$ at $m=2$. Strictly increasing: the derivative numerator is $34m^4+56m^3-21m^2+8m+4>0$ for $m\ge1$.

Sanity at the degenerate ends: $m=1$ gives $0$ in both, i.e. $\mathbb{CP}^1=S^2$ and $\mathbb{HP}^1=S^4$, $W=0$. **Both values in claim 9 confirmed.**

### 8.2 The gap, the minimality is checked on five members and never proved

**Locate it.** [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py), STEP 6: `vals = [(k, ...) for k in range(lo, 7)]`, then `worst = min(vals, ...)` and `allok &= worst[1] >= 1/6`. So the minimum of $\lVert W\rVert^2$ over each of two **infinite** families is taken over $m\in\{2,3,4,5,6\}$, and nothing in the script, in [problem.md](../findings/problem.md) or in [graded-half.md](../findings/graded-half.md) argues that $m=7,8,\dots$ cannot dip below.

**Exhibit the failure concretely.** The written claim is *"$\mathbb{CP}^m$ and $\mathbb{HP}^m$ have closed forms with minima $\tfrac16$ at $\mathbb{CP}^2$ and $\tfrac{45}{224}$ at $\mathbb{HP}^2$"*, and the conclusion *"equality only at $\mathbb{CP}^2$"* rests on it: a single $m\ge7$ with $\lVert W\rVert^2\le\tfrac16$ would give a second equality case or a counterexample outright. The record's evidence for the whole of $m\ge7$ is **nothing at all**, five evaluations and a `min` over them.

**Argue the opposite.** The most charitable reading is that "closed forms with minima" is meant to assert monotonicity as read off the formulas, which any reader can do in two lines. That reading is fair, and the claim is **true**, I verified both monotonicities above by hand, in closed form. But the block prints no closed form, so the reader it addresses cannot take that reading; and the file that does print them ([graded-half.md](../findings/graded-half.md), STEP 6's source) prints them beside a `min` over five points and calls the theorem proved. **The claim survives; the argument on file does not carry it.** This is the finding that sets the verdict.

### 8.3 Is the residue exhaustive?

Yes, relative to the eight families and the twelve pairs. Working the rank-one members out of each family in turn:

| family | rank-one members | disposition |
|---|---|---|
| AIII | $p=1$: $\mathbb{CP}^q$ | closed form, §8.1 |
| BDI | $p=1$: $S^q$ | $W=0$ |
| CII | $p=1$: $\mathbb{HP}^q$ | closed form, §8.1 |
| AI | $m=2$: $SU(2)/SO(2)=S^2$ | $W=0$ |
| AII | $m=2$: $SU(4)/Sp(2)=S^5$ | $W=0$ |
| DIII | $m=2$: $S^2$; $m=3$: $SO(6)/U(3)=\mathbb{CP}^3$ | $W=0$; closed form |
| CI | $m=1$: $Sp(1)/U(1)=S^2$ | $W=0$ |
| II | $\mathfrak{su}(2)$, $n=3$: $S^3$ | $W=0$ |
| exceptional | FII $=\mathbb{OP}^2$ | passes the bound, §7.1 |

**Nothing escapes both branches.** Claim 10 confirmed, relative to the index set; §10 is about the index set itself.

### 8.4 A wording defect, small and real

**Locate.** [problem.md](../findings/problem.md) line 231: *"The residue is exactly the compact rank-one spaces."*

**Exhibit.** $\mathbb{OP}^2$ is a compact rank-one space and is **not** in the residue, the same sentence's own preamble puts it in the C–S branch. So "exactly" is false as written.

**Argue the opposite.** [results.md](../results.md)'s canonical line says it correctly: *"The rank-one spaces other than $\mathbb{OP}^2$ are the families of Lemmas 10 and 38."* The block's sentence is an abbreviation of that, and no reader is going to be misled about a space named two clauses earlier. **Recorded as a wording defect, not a mathematical one.**

## 9. The traps, each answered by name

- **$\ker W\ne0$.** $W$ has a large kernel at every space here (at $\mathbb{CP}^2$ it is the whole of $\Lambda^2_-$, dimension $3$) and this costs nothing, because the argument runs through $\lVert R\rVert^2$ and $\lVert W\rVert^2$ only: no inverse is taken, no gradedness slack is measured, [W4](../findings/INDEX-traps.md)'s vacuity screen is never invoked. **The trap does not bite except at $W=0$**, where it bites hard: see the next item.
- **A universal claim quantifying over objects where its predicate is undefined.** *Locate*: the block's last sentence, *"Hence $\theta\le\sqrt{3/2}$ on every compact irreducible symmetric space."* *Exhibit*: at $S^n$, $\mathbb{RP}^n$, $S^3$, $\mathbb{CP}^1$, $\mathbb{HP}^1$ one has $W=0$, so $\theta=P(W)/\lVert W\rVert^3$ is $0/0$ and $\lambda/\lVert W\rVert$ is a division by zero; **[L46](../findings/problem.md)'s own audit already books this as an undischarged hypothesis**, *"the conclusion needs $W\ne0$ and neither the block nor the canon says so"*. *Argue the opposite*: [graded-half.md](../findings/graded-half.md), from which this block was moved, writes *"$S^n$ and $\mathbb{RP}^n$ have $W=0$, so $\theta$ is undefined and the conjecture's hypothesis excludes them"*, **the guard existed and was dropped in the move.** The defect is that the canonical block is strictly weaker than its source.
- **The boundary of every stated range, the smallest admissible dimension, odd $n$.** §7.3. Every boundary case passes; the smallest dimension $n=4$ is the equality case and is reached by the residue rather than by the bound; odd $n$ carries no hazard here.
- **A claim proven on a subfamily and used in general.** §8.2, this is where it bites, and it is the round's substantive finding. It bites nowhere else: the eight certificates are genuinely uniform in their parameters, and I verified five of the eight polynomial identities in closed form.
- **A hypothesis stated but never used.** None (§1.4).
- **A step using a hypothesis never stated.** Four (§1.3): the rank identity, effectiveness, the Grassmannian $p\leftrightarrow q$ symmetry, and locality.
- **An imported theorem whose hypotheses were never checked against the object.** Checked (§5). PS's hypotheses hold. The one clause that does not transfer verbatim (*"$H$ is the identity component"*), is bridged by locality, which is unstated. **No repeat of the unital-algebra failure**: PS's setting is the setting.
- **Symbol collisions.** Five, all live, none tabled in [conventions.md](../findings/conventions.md):

  | letter | sense in [conventions.md](../findings/conventions.md) | sense in L47 |
  |---|---|---|
  | $\mathfrak h$ | $E_{\max}$ at a critical point | the isotropy algebra of the symmetric pair |
  | $\lambda$ | $\lambda_\alpha$, the $\Lambda^2$ spectrum | the Einstein constant, while [graded-half.md](../findings/graded-half.md) writes $\lambda_i$ for the isotropy-block eigenvalues **in the same three lines**, so the letter carries two senses inside one derivation |
  | $c$ | the Killing constant of a subalgebra, $c=2h^\vee/I_\rho$ | the centre constant $\frac1{2(n-1)}$, and [graded-half.md](../findings/graded-half.md)'s type-II paragraph uses **both senses in one file**, writing $c_{\rm hol}=2$ and $c=\operatorname{tr}R/N$ |
  | $R$ | $\mathring R$ (two index orders) and the triple $R_I,R_{\mathrm{ric}_0},R_W$ | the first-kind curvature operator on $\Lambda^2$, untabled under the bare letter |
  | $B$ | flagged as carrying two senses already, both on $\mathfrak{so}(n)$ | the Killing form of $\mathfrak g$, a third algebra and a third sense, and the whole imported argument runs on it |
  | $P$ | **$P(W)=\langle W,Q(W)\rangle$, the cubic form, the programme's central object** | PS's auxiliary operator $B_{\mathfrak g}(P\cdot,\cdot)=B_{\mathfrak h}$, *and* the certificate polynomial $P(n,h)$. **Three objects under the record's most loaded letter, inside one lemma.** |

## 10. What a consumer may cite for the completeness of the index set

The lemma is universal over an enumeration (§7.2), so this is not a bibliographic nicety.

**On file, and citable:**

- **The type I / type II dichotomy**, from [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/), §2 "Rough classification of orthogonal symmetric Lie algebras" (p. 30): *"Type I $\mathfrak g_o$ is compact and simple. Type II $(\mathfrak g_o,\mathfrak g_o,s)$ where $s$ is the flip and $\mathfrak g_o$ is compact and simple… Of these, types I and II are compact."*
- **That type II is exactly the compact Lie groups**, Holland–Ion Theorem 19 (ch. 6 §7, p. 68), proved there.
- **The classical type-I families in compact form with their isotropy algebras**, Holland–Ion ch. 8 §2, pp. 96–99 and 103, with the record's own note that the $\mathfrak{so}(2n)$ pairs are **split across §2.1 and §2.3**, so a reader stopping at the first half sees only even $p,q$ and would wrongly think $\mathfrak{so}(3)\oplus\mathfrak{so}(9)\subset\mathfrak{so}(12)$ absent.
- **The twelve exceptional pairs**, Holland–Ion pp. 100–105, corroborated entry for entry by [Yokota](../references/yokota-2009-exceptional-lie-groups/)'s twelve involution sections, which additionally give the global isotropy group.

**Not on file, and therefore not citable:**

- **That the list is complete.** Holland–Ion says so in its own words: *"We shall not prove here that every possible Vogan diagram gives a simple real Lie algebra, although this is true. Rather we content ourselves with the fact that once we have listed all of those that are admissible, we shall have obtained the complete classification."* Yokota asserts exhaustiveness in its preface and proves it in no section. **A consumer of L47 must cite Cartan/Helgason for "there are no others", and that source is not in [references/](../references/).**
- **$\dim\mathfrak g$ and $\dim\mathfrak h$ for the twelve exceptional pairs.** Holland–Ion prints the pairs and the rank and **no dimensions**; Yokota prints no numerical invariants at all. The twelve numbers that STEP 4 of the census runs on are **hard-coded in the script and sourced nowhere on the record.** They are standard and I confirm every one of them by hand, but that is my confirmation, not the record's citation.

## 11. Withdrawn candidates

Each of these looked like a discrepancy and failed the three-part protocol.

- **"The Cauchy–Schwarz step needs the blocks to be the isotypic pieces, and PS 2.2 is doing real work."** *Withdrawn*: it needs only rank and trace (§3.2). PS 2.2 is more than the step consumes, so an error in it could not propagate here.
- **"$48$ and $84$ match no family, so two of the eight certificates describe nothing."** *Withdrawn*: they are BDI at $p=q=2$ and type II at $n=6$. Both corners lie **outside** the lemma's own quantifier ($S^2\times S^2$ is reducible and $6$ is not the dimension of any compact simple Lie algebra) but shifting to a corner *below* the first genuine member makes the positivity claim strictly stronger, so the mathematics is conservative rather than wrong. What survives is the wording defect in §12.
- **"The eight classical families omit the exceptional compact Lie groups, which are type-II symmetric spaces and not among the twelve exceptional pairs."** *Withdrawn*: family 8 is parameterised by $n=\dim G$ alone with $\dim\mathfrak h=n$, so a single certificate covers every compact simple $G$ at once, $G_2$ through $E_8$ included. *Argue the opposite*: nothing written says the family is $n$-parameterised, so the reader who worries about this cannot resolve it from the block, which is §12's point, not a separate defect.
- **"PS's $\Lambda^2$ normalisation collides with the record's."** PS write *"for $X,Y$ orthonormal, $|X\wedge Y|^2=2$"*, plain Frobenius, while [conventions.md](../findings/conventions.md) runs in the half-trace pairing where $\lVert\varphi_{ab}\rVert^2=1$. *Withdrawn*: PS pair it with $g(R(X\wedge Y),Z\wedge W):=2R(X,Y,Z,W)$, so the **operator** and hence its eigenvalues are the same in both; and $\lVert R\rVert^2=\sum_\alpha\lambda_\alpha^2$ is basis-free. Checked against the round sphere, where both give $R=\kappa\,\mathrm{Id}$. **No conversion is owed, and this is the one place I expected one.**
- **"Irreducible symmetric $\Rightarrow$ Einstein is used and never stated."** *Withdrawn*: PS derive $\mathrm{Ric}=\tfrac12g$ from the metric $-B_{\mathfrak g}$ for any compact semisimple $G$, so the Einstein property arrives with the normalisation rather than as a separate hypothesis.
- **"`Poly.coeffs()` drops zero coefficients, so the certificate test is unsound."** *Withdrawn*: a zero coefficient is nonnegative; dropping it cannot turn a failing certificate into a passing one.

## 12. The defects, consolidated

1. **The canonical block carries no proof and points at none.** [problem.md](../findings/problem.md) lines 221–233 give eight integers with no polynomial, no family label, no parameterisation and no pointer to [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py). The pointer exists only in [graded-half.md](../findings/graded-half.md), which the block does not cite.
2. **The residue minima are verified on $2\le m\le6$ and their minimality is proved nowhere** (§8.2). Load-bearing for *"equality only at $\mathbb{CP}^2$"*. **This is the gap.**
3. **The final sentence quantifies $\theta$ over spaces where $\theta$ is undefined**, and the guard that says so was dropped when the block moved out of [graded-half.md](../findings/graded-half.md) (§9).
4. **The Petersen–Stanfield citation names Prop 2.2 for eigenvalues where the step needs Prop 2.1's image statement** (§3.2). Both are on file, so this is a repair of one clause.
5. **"after shifting to its first admissible rank" misdescribes two of the eight shifts** (§11, second item), conservatively, but a reader checking BDI at $p=q=2$ finds a reducible space the lemma does not claim to cover.
6. **"The residue is exactly the compact rank-one spaces" excludes $\mathbb{OP}^2$ from itself** (§8.4).
7. **The twelve exceptional dimensions are sourced nowhere** (§10).
8. **Six symbol collisions, including three senses of $P$** (§9).
9. **The heading is malformed** (*"(the dimension lemma for symmetric spaces) · (B)), canonical statement and proof"*, and [INDEX-results.md](../findings/INDEX-results.md) row 47 has inherited the unbalanced parenthesis.

## 13. What would break it, and what I did to look

**The object.** A compact irreducible symmetric space $M$, of rank $\ge2$ or equal to $\mathbb{OP}^2$, $\mathbb{CP}^m$ or $\mathbb{HP}^m$, with $\lVert W\rVert^2<\tfrac16$, equivalently $\theta>\sqrt{3/2}$ at Einstein constant $\tfrac12$. By §4 such an $M$ must have $\dim\mathfrak h>\frac{3n^2(n-1)}{2(7n-4)}$, since the bound is sufficient; and by §3.3 it must additionally carry real Cauchy–Schwarz slack, since equality in the bound with equality in C–S gives exactly $\tfrac16$.

**Where I looked, all by hand and all in closed form.**

- **Every family corner** (§6.2) and **every one of the twelve exceptional pairs** (§7.1). Largest ratio $\dim\mathfrak h/\text{bound}$ found anywhere in the C–S branch: $\mathbb{OP}^2$ at $\tfrac{36}{53.33}=0.675$. Nothing came within $32\%$ of the bound.
- **Asymptotics.** In every one of the eight families $\dim\mathfrak h$ grows like $O(n)$ or $O(n^{3/2})$ against a bound of order $\tfrac3{14}n^2$, so no large member can approach it; the danger is confined to small $n$, where I checked exhaustively.
- **The residue, exactly.** $\mathbb{CP}^m$ exceeds the bound at every $m$ and $\mathbb{HP}^2$ exceeds it by exactly $\tfrac1{13}$, so the two places where the C–S branch genuinely fails are known, and both are settled by the closed forms of §8.1, which I re-derived and which give $\tfrac16$ and $\tfrac{45}{224}$.
- **The one place the bound is genuinely violated** is $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ at $\dim=\tfrac{n(n-2)}4$, the isotropy of $S^{n/2}\times S^{n/2}$, **reducible, outside the quantifier**, and [graded-half.md](../findings/graded-half.md) already records that this happens exactly when $n^2-12n+8>0$.
- **The only untested region** is $m\ge7$ in the two residue families. I closed it by hand (the derivative numerators are $3m^2-2m+1$ and $34m^4+56m^3-21m^2+8m+4$, both positive), **but the record has not**, and that is defect 2.

**I found no falsifier and I do not believe one exists.** The statement is true; the file does not prove it.

## Verdict

**GAP.**

Nothing is refuted. Every value in L47 that I could reach independently, the normalisation identity, the Cauchy–Schwarz bound and its exact rearrangement, all eight certificate constants and five of the eight certificate polynomials, all twelve exceptional rows, $\lVert W\rVert^2(\mathbb{OP}^2)=\tfrac{14}{45}$, $\lVert W\rVert^2(\mathbb{CP}^m)$ and $\lVert W\rVert^2(\mathbb{HP}^m)$ with their minima $\tfrac16$ and $\tfrac{45}{224}$, and the type-II closed form $\frac{n(n-3)}{16(n-1)}$, came out exactly as written.

The gap is that **the minimality of the two residue minima is asserted over infinite families and established on five members of each**, and *"equality only at $\mathbb{CP}^2$"* rests on it; and that **the canonical block records eight integers where the proof is a script it does not cite**, so the *"all-nonnegative-coefficient certificate"* claim is reconstructible but not checkable from the record a reader is sent to.

**What would have to be proved to close it**: that $m\mapsto\lVert W\rVert^2$ is non-decreasing on $\mathbb{CP}^m$ and on $\mathbb{HP}^m$ for $m\ge2$, or any argument bounding those families below by $\tfrac16$ and $\tfrac{45}{224}$ at all $m$, rather than at five values of it.
