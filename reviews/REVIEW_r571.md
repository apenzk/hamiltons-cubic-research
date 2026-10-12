# REVIEW_r571, Lemma L104, the value-type reduction

Reviewer r571, independent audit of [Lemma L104](../findings/bounds-relaxations.md) in [bounds-relaxations.md](../findings/bounds-relaxations.md). Analysis only: every derivation below is by hand, and the one arithmetic check (the $n=6$ balanced product through all six reduced rows), is a screen on an object I built for the purpose, reported as a screen. I did not read the other reviewer's report on this brief.

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| **V1** | the reduction: $\Pi(\lambda)$ a compact polyhedron, $\theta^\ast$ attained on the $G$-invariant slice, variables the admissible class-multisets | **CONFIRMED**, every step rebuilt from the definitions. Two gaps in the *statement*: unit norm is never hypothesised, and the transitivity sentence names only $S_{m_i}$ where $S_{m_i}\times S_{m_j}$ is used |
| **V2** | the reduced system (A$_i$), (B$_i$), (C$_i$), all three coefficient patterns | **CONFIRMED**, all three re-derived from (A), (B), (C) and the ordered-pair convention. The block's reading of $(\nu_j+\nu_k)$ is exactly right |
| **V3** | the $n=6$ balanced-product anchor | **CONFIRMED** by hand, all six rows exact at $t=(\tfrac1{10},0,\tfrac1{12},0)$ and $\theta=5w=\sqrt{10}/3$ |
| **V4** | the two dependencies | **CONFIRMED**, both re-derived from total symmetry and tracelessness alone; both survive at **every** spectrum, multiplicities irrelevant |
| **V5** | rank $=3d-2$ when every $m_i\ge3$ | **CONFIRMED and PROVED**, the block asserts *"and only two"* with no argument. My proof is below; it reproduces the family [r343](REVIEW_r343.md)/[r344](REVIEW_r344.md) found, which sits **further down in the same file** and is not cited from it |
| **V6** | *"with a class of multiplicity $2$ the dimension drops to $0$ and $\theta$ is forced"* | **REPAIRED**, true at $d=2$ (verified: rank stays $4$, $V$ drops to $3$), **false as a general sentence**: at $d=3$ with one class of multiplicity $2$ the dimension is $3$ |
| **V7** | *"with a class of multiplicity $1$ at $d=2$ the system is infeasible at every $n\ge5$"* | **CONFIRMED**, by a two-line route using only (A$_2$), (B$_2$) and tracelessness, so it holds at every $n\ge3$ and needs no criticality |
| **V8** | dual certificates complete | **CONFIRMED with the scope stated.** *"Every valid bound"* means every bound valid **on $\Pi(\lambda)$**; strong duality needs primal feasibility, which the block's own multiplicity-$1$ case fails, and boundedness, which the compactness paragraph supplies |
| **V9** | the Gate 2 attribution | **TRACED, and the brief's premise is wrong**, [r341](REVIEW_r341.md) and [r342](REVIEW_r342.md) are named in the section preamble immediately above the lemma heading, and both reports carry the claim verbatim. The gap is [INDEX-results.md](../findings/INDEX-results.md) row 104 |
| **V10** | consumers | **THREE DEFECTS**, one of them a straight contradiction inside this same file |

**Overall: CONFIRMED, with repairs.** Every mathematical claim in the block holds, and I reproduced each by a route sharing nothing with the block's. What fails is around the mathematics: an absent proof that the same file supplies elsewhere, three relations used with no definition and no citation, a missing normalisation hypothesis, and three consumers that spend the count or the *"$\theta$ is not forced"* clause outside the $m_i\ge3$ regime.

## 0. What the block leans on and does not define

**(A), (B), (C) appear in the lemma statement, in the proof and in the reduced system, and are defined nowhere in this file and nowhere in [conventions.md](../findings/conventions.md).** They live in [bounds.md](../findings/bounds.md), as

$$\text{(A)}\ \sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2),\qquad\text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k,\qquad\text{(C)}\ \sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k),$$

and [bounds-relaxations.md](../findings/bounds-relaxations.md) never links them. Under [conventions.md](../findings/conventions.md)'s own rule (*a findings file that needs a convention cites the file that holds it*), the three relations carrying the whole lemma are an uncited import. **Repair: one citation to [bounds.md](../findings/bounds.md) in the lemma statement.**

Four smaller omissions, each real:

- **$\lambda$ is never introduced.** The spectrum is fixed as $\nu_1,\dots,\nu_d$; the objects are then written $\Pi(\lambda)$, $\theta^\ast(\lambda)$, $\lambda_{ga}=\lambda_a$, *"a row with $\lambda_a\ne0$"*. Two letters, one spectrum, no bridge.
- **$d$ carries two senses inside this one file.** L104 and L105 use it for the count of distinct eigenvalues; [Lemma L114](../findings/bounds-relaxations.md)'s block-mass identity $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$ uses it for $\dim\mathfrak m$. [conventions.md](../findings/conventions.md) tables the second sense and the [L35](../findings/stratum-two-negative.md) sense, and **not this one**, so a reader who obeys the conventions file reads L104's $d$ as a negative-eigenvalue count.
- **Unit norm is never hypothesised.** The lemma opens *"Fix the spectrum of $W\in\mathcal W_n$"*. (C) is criticality on the unit sphere, the compactness step needs some $\lambda_a\ne0$, and [Lemma L105](../findings/bounds-relaxations.md) (the lemma's only in-file consumer), restores *"of unit norm"* and $\lVert\lambda\rVert=1$ in its own statement and proof. The hypothesis belongs in L104.
- **$\mu_k^{(ij)}$ is undefined** where the pair cap is written in reduced variables. It is $m_k-\delta_{ik}-\delta_{jk}$, and with that reading $\sum_k\mu_k^{(ij)}t_{ijk}\le2$ is correct.

## 1. V1, the reduction

**Rebuilt before reading the block's proof.** (A) and (B) are linear in $T$ with $\lambda$-built coefficients and $\theta$-free right-hand sides; (C) rearranges to $\sum_{bc}\lambda_b\lambda_cT_{abc}-2\lambda_a\theta+2\lambda_a^2=0$, jointly linear in $(T,\theta)$. Nonnegativity, total symmetry and hollowness are linear. So $\Pi(\lambda)$ is a polyhedron and $\theta$ a linear objective on it.

**$G$-stability and averaging hold.** $G$ fixes $\theta$ and preserves $\lambda$ classwise, so it acts linearly on the pair with the constraint set invariant; the average of a maximiser is a $G$-invariant point of $\Pi(\lambda)$ at the same $\theta$, and nonnegativity, total symmetry and hollowness all survive averaging.

**Compactness holds and the block's bound is loose in a harmless direction.** Each entry appears twice in its own row sum, so $T\ge0$ with $\sum_{bc}T_{abc}=2(n-2)$ gives $T_{abc}\le n-2$, not merely $\le2(n-2)$; either way the box is compact, and (C) at a row with $\lambda_a\ne0$ bounds $\theta$ on both sides. Some $\lambda_a\ne0$ because $W\ne0$, which is where the missing unit-norm hypothesis is silently spent.

**Transitivity: the conclusion is right, the reason given is incomplete.** For a type $\{i,i,j\}$, carrying $(a,a',b)$ to $(c,c',e)$ needs $S_{m_i}$ transitive on ordered pairs of distinct elements **and** $S_{m_j}$ moving $b$ to $e$. The block names only $S_{m_i}$. For $\{i,i,i\}$, $S_{m_i}$ on ordered triples of distinct elements is enough, as written.

**The bounding clause is sound.** A critical point's own $T_{abc}=c_{abc}^2$ is nonnegative, totally symmetric and hollow by total antisymmetry of $c$, and satisfies (A), (B), (C); so $(T,\theta)\in\Pi(\lambda)$ and $\theta\le\theta^\ast(\lambda)$.

## 2. V2, the reduced system, coefficient by coefficient

Fix $a$ in class $i$ and let $\mu_j=m_j-\delta_{ij}$ be the indices of class $j$ available as $b$ or $c$. Sums over pairs are **ordered** ([conventions.md](../findings/conventions.md)), and $T$ vanishes when two indices coincide.

- **Mixed types $j\ne k$.** The ordered pairs split into $(b\in j,\,c\in k)$ and $(b\in k,\,c\in j)$, $\mu_j\mu_k$ each.
- **Repeated types $j=k$.** Ordered distinct pairs inside class $j$: $\mu_j(\mu_j-1)$.

Weighting each ordered pair by $1$, by $\lambda_b$ and by $\lambda_b\lambda_c$:

| relation | weight | mixed $j<k$ | repeated $j$ |
| --- | --- | --- | --- |
| (A$_i$) | $1$ | $2\mu_j\mu_k$ | $\mu_j(\mu_j-1)$ |
| (B$_i$) | $\lambda_b$ | $\mu_j\mu_k(\nu_j+\nu_k)$ | $\mu_j(\mu_j-1)\nu_j$ |
| (C$_i$) | $\lambda_b\lambda_c$ | $2\mu_j\mu_k\nu_j\nu_k$ | $\mu_j(\mu_j-1)\nu_j^2$ |

**Every entry matches the block.** And the block's account of the odd one out is exactly right: $1$ and $\lambda_b\lambda_c$ are symmetric under $b\leftrightarrow c$, so the two orders of a mixed pair contribute the same thing twice and produce the factor $2$; $\lambda_b$ is not, so the two orders contribute $\nu_j$ and $\nu_k$ and produce $(\nu_j+\nu_k)$. The right-hand sides $2(n-2)$, $-2\nu_i$, $2\nu_i(\theta-\nu_i)$ carry over from (A), (B), (C) unchanged, the row being any single index of class $i$.

The $j=i$ terms are where admissibility enters: the mixed sum contributes $2\mu_i\mu_kt_{iik}$ with $\mu_i=m_i-1$, and the repeated sum $(m_i-1)(m_i-2)t_{iii}$. So $\{i,i,j\}$ needs $m_i\ge2$ and $\{i,i,i\}$ needs $m_i\ge3$, and the block's caveat is the right one.

## 3. V3, the $n=6$ balanced product, by hand

$n=6$, $N=15$, $r=6$ at $u$ and $9$ at $-w$, with $w=\sqrt{2/45}$ and $u=\tfrac32w$; $6u^2+9w^2=1$, so the spectrum is unit-norm. Taking $t_{112}=t_{222}=0$:

- (A$_2$) reads $96\,t_{122}=8$, so $t_{122}=\tfrac1{12}$; (A$_1$) reads $20\,t_{111}+6=8$, so $t_{111}=\tfrac1{10}$.
- (B$_1$): $2u-6w=-2u\iff u=\tfrac32w$. ✓
- (B$_2$): $4(u-w)=2w\iff u=\tfrac32w$. ✓
- (C$_1$): $2u^2+6w^2=2u(\theta-u)$, so $\theta=(2u^2+3w^2)/u=5w$. ✓
- (C$_2$): $-8uw=-2w(\theta+w)$ with $\theta=5w$ gives $u=\tfrac32w$. ✓

$\theta=5w=(n-1)w=\sqrt{10}/3=\theta_0(6)$, from both rows. **The anchor stands.** The pair caps are slack here, $0.4$, $0.667$, $0$ against $2$, so at this spectrum the omitted cap indeed changes nothing.

## 4. V4 and V5, the dependencies, and the proof the block does not give

**The two dependencies, re-derived.** In unreduced form, total symmetry of $T$ gives $\sum_{abc}\lambda_aT_{abc}=\sum_{abc}\lambda_bT_{abc}$ and $\sum_{abc}\lambda_a\lambda_bT_{abc}=\sum_{abc}\lambda_b\lambda_cT_{abc}$; tracelessness kills both right-hand sides of $\sum_a\lambda_a(\mathrm A_a)$ and $\sum_a(\mathrm B_a)$, and turns $\sum_a(\mathrm C_a)$ and $\sum_a\lambda_a(\mathrm B_a)$ into the same $-2\lVert\lambda\rVert^2$ with the $\theta$ terms cancelling. Reduced, these are $\sum_im_i\nu_i(\mathrm A_i)=\sum_im_i(\mathrm B_i)$ and $\sum_im_i(\mathrm C_i)=\sum_im_i\nu_i(\mathrm B_i)$, as written. **Neither uses a multiplicity**, so both hold at every spectrum.

**"And only two" is asserted with no argument. Here is one.** Give index $a$ of class $p$ the weights $(\alpha_p,\beta_p,\gamma_p)$ and write $f_p(x)=\alpha_p+\beta_px+\gamma_px^2$. Grouping the combined functional by type, the coefficient of $t_\tau$ is a positive multiplicity factor times

$$H(i,j,k)=\sum_{\sigma}\big[\alpha_{\sigma_1}+\beta_{\sigma_1}\nu_{\sigma_2}+\gamma_{\sigma_1}\nu_{\sigma_2}\nu_{\sigma_3}\big]=2\big[\tilde f_i(\nu_j,\nu_k)+\tilde f_j(\nu_i,\nu_k)+\tilde f_k(\nu_i,\nu_j)\big],$$

the sum over the six arrangements, with $\tilde f$ the bi-affine polarisation $\tilde f(x,y)=\alpha+\beta\tfrac{x+y}2+\gamma xy$. The identity $2\tilde f(x,y)=f(x)+f(y)-\gamma(x-y)^2$ then does everything:

- **Type $\{i,i,i\}$** gives $f_i(\nu_i)=0$, so $f_i(x)=(x-\nu_i)g_i(x)$ with $g_i$ affine.
- **Type $\{i,i,k\}$** gives $2\tilde f_i(\nu_i,\nu_k)+f_k(\nu_i)=0$, which with the factorisation is $(\nu_k-\nu_i)\big[g_i(\nu_i)-g_k(\nu_i)\big]=0$, hence $g_i(\nu_i)=g_k(\nu_i)$ for every $k\ne i$.

Two affine functions agreeing at the two distinct points $\nu_1,\nu_2$ are equal, so $g_1=\cdots=g_d=:g$ and $f_p(x)=(x-\nu_p)g(x)$, a **two-parameter** family, and it satisfies the remaining type conditions and the $\theta$-column condition $\sum_im_i\gamma_i\nu_i=0$ automatically, $\gamma_p$ being the constant leading coefficient of $g$ and $\sum m_i\nu_i=0$. **So the left null space is exactly two-dimensional and the rank is $3d-2$, for every $d\ge2$ with every $m_i\ge3$.** $\square$

The two known dependencies are the two members $g\equiv1$ and $g(x)=x$ of that family.

> **AND THE RECORD ALREADY HELD THIS PROOF, FURTHER DOWN IN THE SAME FILE, UNCITED FROM THE LEMMA.** [bounds-relaxations.md](../findings/bounds-relaxations.md)'s double-root section records that [r343](REVIEW_r343.md) and [r344](REVIEW_r344.md) *"both prove that a multiplier vector annihilating every type coefficient is exactly $\varphi_i(x)=m_i(x-\nu_i)(\beta-\kappa x)$, a two-parameter family"*, the same family, in reduced weights, where mine is in per-index weights and $\tilde\alpha_i=m_i\alpha_i$. **The repair is a cross-reference, not a derivation.**

**Where the hypothesis actually bites.** The argument consumes types $\{i,i,i\}$ and $\{i,i,k\}$, so it needs $m_i\ge3$ for every $i$, exactly the block's hypothesis, and this is why it is there.

## 5. V6 and V7, the two corollaries at $d=2$

**Multiplicity $2$, at $d=2$: confirmed.** With $m_2=2$ the type $\{2,2,2\}$ goes, so $V=3$. Reparametrising the weights by $\big(f_1(\nu_1),f_1(\nu_2),\gamma_1\big)$ and $\big(f_2(\nu_1),f_2(\nu_2),\gamma_2\big)$ (a bijection, $\nu_1\ne\nu_2$), the three surviving type conditions and the $\theta$ condition read $f_1(\nu_1)=0$, $f_1(\nu_2)+f_2(\nu_1)=\gamma_1\delta^2$, $f_1(\nu_2)+f_2(\nu_1)+f_2(\nu_2)=\gamma_2\delta^2$ and $m_1\gamma_1\nu_1+m_2\gamma_2\nu_2=0$, which are independent. So the null space is $2$, the rank stays $4=3d-2$, and the affine set has dimension $V+1-4=0$: **$\theta$ is forced.** The $n=8$, $(26,2)$ witness is a witness.

**But the sentence is false read generally.** At $d=3$ with a single class of multiplicity $2$ only $\{3,3,3\}$ is lost, so $V=9$ and the dimension is $9+1-7=3$, not $0$. **Repair: scope the sentence to $d=2$, which is the only place the block uses it and the only place its witness lives.**

**Multiplicity $1$ at $d=2$: confirmed, and by a shorter route than the block's.** Let class $2$ be the simple eigenvalue. Its row has $\mu_2=0$, so (A$_2$) and (B$_2$) reduce to $m_1(m_1-1)t_{112}=2(n-2)$ and $m_1(m_1-1)\nu_1t_{112}=-2\nu_2$, whence $\nu_2=-(n-2)\nu_1$. Tracelessness gives $\nu_2=-(N-1)\nu_1$. So $n-2=N-1=\binom n2-1$, i.e. $(n-1)(n-2)=0$: **impossible at every $n\ge3$, not merely $n\ge5$.** The route uses only (A) and (B), which every Weyl tensor satisfies, so the block's corollary (no Weyl tensor has a two-valued spectrum with a simple eigenvalue), holds with no criticality hypothesis at all.

**A third fact the same two rows give, and the block does not record.** Combining (A$_1$) and (B$_1$) at a general $d=2$ spectrum ($u$ with multiplicity $r$, $-w$ with $N-r$) collapses to

$$(r-1)(u+w)\big[(r-2)t_{111}+(N-r)t_{112}\big]=2\big[(n-2)w-u\big],$$

so $T\ge0$ forces $u/w\le n-2$, i.e. $r\ge n/2$. Below that the $d=2$ segment is **empty**, which is a cleaner reading than a binding constraint, and it confirms [Lemma L105](../findings/bounds-relaxations.md)'s clause that $t_{111}\ge0$ *"never binds above"*: $t_{111}$ is largest exactly where $t_{112}$ is smallest, which is where $\theta$ is largest.

## 6. V8, the dual certificate, and what "every valid bound" means

**The direction and both sign conditions are right.** Summing the rows against $(\alpha_i,\beta_i,\gamma_i)$ gives $\sum_\tau c_\tau t_\tau=K+2\theta\sum_i\gamma_i\nu_i$ with $K=\sum_i\big[2(n-2)\alpha_i-2\nu_i\beta_i-2\nu_i^2\gamma_i\big]$; with $c_\tau\le0$ and $t\ge0$ the left side is $\le0$, and $\sum_i\gamma_i\nu_i>0$ turns that into $\theta\le-K/\big(2\sum_i\gamma_i\nu_i\big)$.

**The hypotheses strong duality needs, and how they stand.**

- **Boundedness above: supplied**, by the compactness paragraph, and it is the step that needs $\lambda\ne0$.
- **Primal feasibility: not universal.** The block's own multiplicity-$1$ corollary exhibits spectra with $\Pi(\lambda)=\varnothing$. Where $\Pi(\lambda)\ne\varnothing$ the primal optimum is finite and attained, so LP duality delivers an optimal dual solution at the same value and the family is complete. Where $\Pi(\lambda)=\varnothing$ the assertion is a statement about $-\infty$ and carries no content beyond *no critical point has this spectrum*, which is how the block uses it.

**"Every valid bound" means every bound valid on $\Pi(\lambda)$, not on the true feasible set**, and the two differ precisely because of the dropped pair cap. The block says so in its own rider, naming [Lemma L35](../findings/stratum-two-negative.md) as a valid bound that consumes the cap and therefore is *not* of this form. **The two sentences sit one paragraph apart and the first does not carry the qualifier; adding "valid on $\Pi(\lambda)$" to it removes the only way to read them as contradicting each other.**

## 7. V9, the Gate 2 attribution, traced

**The brief's premise is wrong.** The section preamble immediately above the L104 heading reads *"Gate 2, [r341](REVIEW_r341.md) and [r342](REVIEW_r342.md) on identical briefs; the reduction and Lemma L105 confirmed by both"*. Both reports exist and both carry the claim the block makes:

- [r341](REVIEW_r341.md) C3: *"CONFIRMED, every coefficient, including the $(\nu_j+\nu_k)$ against the $2$. Verified independently at a spectrum I built from scratch (the $n=6$ balanced product), all six reduced equations exact."*
- [r342](REVIEW_r342.md) C3: *"Every coefficient re-derived independently, and the whole system verified by hand at the balanced $S^3\times S^3$ spectrum at $n=6$, returning $\theta_0(6)=\sqrt{10}/3$ from both rows."*

**So the block's unattributed sentence is accurate and its attribution is one line away.** [r324](REVIEW_r324.md) is named for a different thing, the relaxation whose measurement $\theta^\ast$ over-bounds.

**The gap is the index.** [INDEX-results.md](../findings/INDEX-results.md) row 104 records no verdict, and its short name reads *"max $\theta$ at a fixed spectrum is a $\binom{d+2}3$-variable LP of rank $3d-2$"*, the count and the rank stated flat, with neither the admissibility caveat nor the $m_i\ge3$ hypothesis the block is careful to attach. **Repair: the row gains the Gate 2 verdict with both reviewer numbers, and the hypothesis.**

## 8. V10, the consumers, and one contradiction inside this file

**D1, [bounds-relaxations.md](../findings/bounds-relaxations.md) contradicts L104 further down the same file.** The double-root section closes *"no combination of the equations pins $\theta$: the feasible set has dimension $V+1-(3d-2)$ with $\theta$ non-constant on it"*, unscoped. L104 says the opposite at a class of multiplicity $2$, with a witness. Both are right in their own regime and the sentences as printed cannot both stand: the later argument reads $\operatorname{rank}M=3d-2$ off $\dim\ker M^{\mathsf T}=2$ for the $\theta$-free block $M$, which needs $V\ge3d-2$, and $V$ falls below $3d-2$ as soon as a class has multiplicity $\le2$, at $d=2$ with $m_2=2$, $V=3<4$. **Repair: the clause takes the $m_i\ge3$ hypothesis, and points at L104's multiplicity-$2$ sentence for the exception.**

**D2, [bounds.md](../findings/bounds.md) turns a sufficient condition into an only-if.** It reads *"Feasibility forces a single $\theta$ only when the feasible set is a point, which by [Lemma L104] happens only through a class of multiplicity $2$"*. L104 proves multiplicity $2$ **sufficient at $d=2$** and never claims necessity. The converse is false in both directions: a class of multiplicity $2$ at $d=3$ leaves dimension $3$, and a class of multiplicity $1$ collapses the type count on its own, at $d=3$ with every $m_i=1$ there is a single variable and $\theta$ is pinned or the system is empty. **Repair: *"which by Lemma L104 happens at $d=2$ through a class of multiplicity $2$"*, dropping the "only".**

**D3, the count is quoted without its hypothesis in four places.** [plan.md](../plan.md) line 13 (*"at a $d$-value spectrum the pinned class is a $\binom{d+2}3$-variable linear programme, ten variables at three values"*), the section preamble at line 312, [INDEX-results.md](../findings/INDEX-results.md) row 104, and [post F45](../findings/bounds-relaxations.md)'s $210$ four-subsets with its $132$ and $129$ survivor counts, all of which presuppose ten types at $d=3$ and so every $m_i\ge3$.

**Direction of each, since a missing hypothesis is not automatically an error:**

- [post F43](../findings/bounds-relaxations.md)'s closure witness has multiplicities $(30,20,16)$, so the substantive $d=3$ non-closure is inside the hypothesis and survives.
- [post F45](../findings/bounds-relaxations.md)'s union bound is a **non-closure** claim; at multiplicities below $3$ the type count shrinks and types become isolable again, so the headline *"cannot close $d=3$"* is narrower than printed rather than stronger.
- [plan.md](../plan.md) line 13's *"excludes at $0.9243$"* is safe in the other direction: $\Pi(\lambda)$ drops the pair cap, so $\theta^\ast$ over-bounds the tighter relaxation, and an exclusion at $0.9243$ against $1.29$ only sharpens when the cap is restored.
- [plan.md](../plan.md) line 155's *"$\theta$ is not forced"* is the one that does **not** transfer: freedom in the larger polytope is no freedom in the pair-capped one. It is used to argue a route is insufficient, so it under-claims rather than over-claims, but the sentence is about $\Pi(\lambda)$ and should say so.

**No consumer was found treating $\theta^\ast$ as a bound for the true feasible set.** The two places in this file that could (the vertex caveat and the duality rider), both state the gap explicitly.

## 9. What I would change in the block

1. Cite [bounds.md](../findings/bounds.md) for (A), (B), (C) at the lemma statement, and introduce $\lambda$ as the spectrum $(\nu,m)$ presents.
2. Add *of unit norm* to the hypothesis.
3. Replace *"and only two"* with a pointer to the double-root section's $\varphi_i(x)=m_i(x-\nu_i)(\beta-\kappa x)$, which is the proof.
4. Scope the multiplicity-$2$ sentence to $d=2$.
5. Qualify *"every valid bound"* as valid **on $\Pi(\lambda)$**.
6. Name $S_{m_i}\times S_{m_j}$ in the $\{i,i,j\}$ transitivity clause, and define $\mu_k^{(ij)}=m_k-\delta_{ik}-\delta_{jk}$.
7. Add L104's sense of $d$ (the count of distinct eigenvalues), to [conventions.md](../findings/conventions.md)'s $d$ row, which currently tables only the competing senses.
8. Give [INDEX-results.md](../findings/INDEX-results.md) row 104 its Gate 2 verdict ([r341](REVIEW_r341.md), [r342](REVIEW_r342.md)) and the $m_i\ge3$ hypothesis.
