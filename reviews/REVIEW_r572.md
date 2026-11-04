# Review r572, Lemma L104, the value-type reduction

Reviewer r572, independent adversarial audit of [Lemma L104](../findings/bounds-relaxations.md), the value-type reduction, at [bounds-relaxations.md:314](../findings/bounds-relaxations.md). Cited 66 times. Worked from [conventions.md](../findings/conventions.md) and the (A), (B), (C) statement at [bounds.md:235](../findings/bounds.md) first, and against the block second.

**Analysis-only footing.** Every derivation below is by hand. Four screens are reported as screens, on systems built for the purpose, in seconds; each guards a claim already derived by hand, and none is offered as evidence for a positive claim. No sweep, census or falsifier hunt was run.

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| **D1** | the Gate 2 the block asserts is attributed and traceable | **CONFIRMED**, the brief's premise is wrong; the preamble names [r341](REVIEW_r341.md) and [r342](REVIEW_r342.md) |
| **D2** | the reduced system (A$_i$), (B$_i$), (C$_i$), every coefficient | **CONFIRMED**, derived cold, then screened against a brute-force unreduced sum |
| **D3** | the $(\nu_j+\nu_k)$ against the $2$ is "the two orders of a mixed pair carrying different weights" | **CONFIRMED**, the explanation is exactly the mechanism |
| **D4** | rank $3d-2$ | **CONFIRMED, and the hypothesis $m_i\ge3$ is stronger than the claim needs**, rank $3d-2$ holds at the generic all-simple spectrum too, proved here |
| **D5** | "with a class of multiplicity $2$ the dimension drops to $0$ and $\theta$ is forced" | **REFUTED as written, REPAIRED**, it is a $d=2$ statement; at $d\ge3$ a counting argument forbids it, and the block's own preceding formula contradicts it |
| **D6** | the $n=8$, $(26,2)$ witness | **REPAIRED**, the forced point has $t_{122}=-1/26<0$, so $\Pi(\lambda)=\varnothing$ and no critical Weyl tensor has that spectrum |
| **D7** | "by LP strong duality every valid bound at a fixed spectrum arises this way" | **REPAIRED**, completeness needs $\Pi(\lambda)\ne\varnothing$, and the block's own witness supplies a spectrum where it fails |
| **D8** | [post F43](../findings/bounds-relaxations.md)'s "no combination of the equations pins $\theta$" | **REFUTED as written**, asserted with no multiplicity hypothesis, forty lines below the block sentence it contradicts |
| **D9** | consumer [bounds.md:401](../findings/bounds.md) | **REFUTED**, both halves of "forces a single $\theta$ only when the feasible set is a point, which happens only through a class of multiplicity $2$" fail |
| **D10** | consumer [plan.md](../plan.md) item I13 | **REPAIRED**, the $d=3$, $m_i\ge3$ row is quoted unqualified inside a scope that admits multiplicities $1$ and $2$ |
| **D11** | hypotheses the block leans on and does not state | **REPAIRED**, $\lVert W\rVert=1$, $\sum_im_i\nu_i=0$, and "hollow" for a $3$-tensor, which the record defines only for matrices |
| **D12** | the dropped pair cap, and whether consumers respect the scoping | **CONFIRMED clean** across the record files |

**Overall: REPAIRED.** The three headline claims, the collapse of the $3N$ equalities to $3d$, the rank $3d-2$, and completeness of the dual certificates, all stand, and one of them is true under weaker hypotheses than the block claims. What fails is the scoping of two sentences sitting beside them, and of two consumers that quote those sentences.

## D2, D3, the reduced system and the three coefficient patterns

Take (A), (B), (C) as [bounds.md:235](../findings/bounds.md) states them, with the sums over **ordered** pairs per [conventions.md](../findings/conventions.md), and $T$ vanishing whenever two indices coincide. Fix $a$ in class $i$ and put $\mu_j=m_j-\delta_{ij}$ for the count of indices of class $j$ available to the other two slots.

- Mixed pair, classes $j\ne k$: the ordered pairs number $\mu_j\mu_k$ in each of the two orders.
- Repeated class $j$: the ordered pairs number $\mu_j(\mu_j-1)$.

The weight in (A) is $1$ and in (C) is $\lambda_\beta\lambda_\gamma$, both **symmetric under swapping the pair's two members**, so the two orders of a mixed pair contribute equally and give $2\mu_j\mu_k$ and $2\mu_j\mu_k\nu_j\nu_k$. The weight in (B) is $\lambda_\beta$, which reads only the **first** slot, so the two orders contribute $\mu_j\mu_k\nu_j$ and $\mu_j\mu_k\nu_k$, summing to $\mu_j\mu_k(\nu_j+\nu_k)$. Every coefficient in the block's display comes out, and the right-hand sides $2(n-2)$, $-2\nu_i$, $2\nu_i(\theta-\nu_i)$ are the single-row values unchanged, which is right because each reduced row **is** one unreduced row.

**So the block's one-line explanation of the $(\nu_j+\nu_k)$ is correct and is the whole of the mechanism.** The same reading fixes the diagonal terms: there the pair is $(\nu_j,\nu_j)$, the two orders are indistinguishable, and (B) carries $\nu_j$ rather than $2\nu_j$ or $\nu_j+\nu_j$ divided by anything.

*Screen S1.* At $d=3$, $m=(3,4,2)$, $\nu=(2,-1,3)$, with a random rational $t$ on the admissible types, the brute-force unreduced sums $\sum_{\beta\gamma}T_{a\beta\gamma}$, $\sum_{\beta\gamma}\lambda_\beta T_{a\beta\gamma}$ and $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{a\beta\gamma}$ match the reduced left-hand sides exactly, in all nine cases, in exact arithmetic.

### The $n=6$ balanced-product anchor, re-derived by hand

$S^3\times S^3$ at $n=6$: $N=15$, $\nu_1=1/\sqrt{10}$ with $m_1=6$, $\nu_2=-\tfrac23/\sqrt{10}$ with $m_2=9$. Tracelessness $6\nu_1+9\nu_2=0$ and $\sum m_i\nu_i^2=\tfrac6{10}+\tfrac4{10}=1$ both hold. Set $t_{112}=t_{222}=0$, the two facets [Lemma L105](../findings/bounds-relaxations.md) identifies. Then (A$_2$) reads $96t_{122}=8$, so $t_{122}=\tfrac1{12}$; (A$_1$) reads $20t_{111}+72t_{122}=8$, so $t_{111}=\tfrac1{10}$. (B$_1$) returns $2\nu_1+6\nu_2=-2\nu_1$ and (B$_2$) returns $4(\nu_1+\nu_2)=-2\nu_2$, both identities at $\nu_2=-\tfrac23\nu_1$. (C$_1$) gives $2\nu_1\theta=\tfrac{20}3\nu_1^2$, so $\theta=\tfrac{10}3\nu_1=\sqrt{10}/3=\theta_0(6)$, and (C$_2$) returns $-\tfrac{16}3\nu_1^2$ on both sides at that $\theta$. **Both rows return $\theta_0(6)$, as the block says.**

## D4, the rank, and a hypothesis stronger than the claim needs

Write the reduced system as $Mt=b+\theta v$. A left-null vector of $M$ assigns to class $i$ a quadratic $\varphi_i(x)=\alpha_i+\beta_ix+\gamma_ix^2$, and the coefficient it accumulates on the type $\{i,j,k\}$ is, up to the positive factor $m_im_jm_k$ or its degenerate analogue,

$$F(\nu_i,\nu_j,\nu_k)=\psi_i(\nu_j,\nu_k)+\psi_j(\nu_k,\nu_i)+\psi_k(\nu_i,\nu_j),\qquad \psi_i(y,z)=\alpha_i+\beta_i\tfrac{y+z}2+\gamma_iyz,$$

$\psi_i$ being the polarisation of $\varphi_i$. **The condition is $F=0$ on the admissible types and on those alone**, which is exactly where the multiplicity hypothesis can bite: fewer admissible types means fewer conditions, hence possibly a larger null space and a smaller rank.

**Under $m_i\ge3$, two dimensions.** Type $\{iii\}$ gives $\varphi_i(\nu_i)=0$, so $\varphi_i(t)=(t-\nu_i)\ell_i(t)$ with $\ell_i$ linear. Type $\{iij\}$ then gives $2\psi_i(\nu_i,\nu_j)+\psi_j(\nu_i,\nu_i)=(\nu_j-\nu_i)\big[\ell_i(\nu_i)-\ell_j(\nu_i)\big]=0$, so $\ell_j(\nu_i)=\ell_i(\nu_i)$ for **every** $j\ne i$, all $d$ of the $\ell$'s agree at $\nu_i$, for each $i$. Two distinct agreement points force $\ell_j=\ell$ common, and the distinct-class types are then satisfied identically. So the null space is $\{\varphi_i(t)=(t-\nu_i)\ell(t)\}$, two-dimensional, and rank $M=3d-2$. This reproduces [r341](REVIEW_r341.md) §6 and [r342](REVIEW_r342.md)'s C6 by a route that goes through the agreement points rather than through their difference relations.

**At the generic spectrum, where every $m_i=1$, the rank is still $3d-2$.** Here only distinct-class triples are admissible, so the two conditions above are unavailable and the argument must be rebuilt. Subtracting the $\{x,y,z\}$ and $\{x,y,w\}$ conditions leaves, for all distinct $x,y$ outside $\{z,w\}$,

$$P+u(x)+u(y)+s\big[y\gamma(x)+x\gamma(y)\big]+Rxy=0,\qquad s=z-w\ne0,$$

with $P,R$ the $\alpha$- and $\gamma$-differences at $z,w$ and $u=\tfrac s2\beta+\tfrac Q2\mathrm{id}$. Differencing that in $y$ shows $\gamma$ is **affine**; substituting back, the coefficient of $xy$ must vanish and the separable remainder must be constant, which makes $\beta$ affine; feeding both into $F=0$ and differencing in $x$ and $y$ kills the $e_2$ and $e_3$ coefficients, forcing $\gamma$ constant, $\beta(x)=b_0-c_0x$ and $\alpha(x)=-b_0x$. That is the same two-parameter family $\varphi_i(t)=(t-\nu_i)(b_0+c_0t)$. It needs enough distinct values to run, comfortably supplied, since the generic spectrum has $d=N=\binom n2\ge10$ at every $n\ge5$.

**So the block's "rank $3d-2$ when every $m_i\ge3$" is true and its hypothesis is sufficient rather than necessary**, and the brief's worry (that the generic spectrum fails the hypothesis), does not damage the rank. It damages only the variable count, which the block's admissibility caveat already states correctly: $\binom{d+2}3$ under $m_i\ge3$, $\binom d3$ at the generic spectrum. This also answers, in the all-simple case, the question [r342](REVIEW_r342.md) left open at its close: whether the rank is $3d-2$ beyond $m_i\ge3$.

*Screen S2.* Ranks of $M$ and $[M\mid v]$ at $m$-traceless $\nu$ (the weighting matters: $\sum_im_i\nu_i=0$, not $\sum_i\nu_i=0$, a first pass here used the unweighted centring and returned wrong ranks at mixed multiplicities). All $m_i=1$ at $d=6,8,10,12$: rank $M=3d-2$ every time. All $m_i=3$ at $d=2,\dots,5$: rank $M=3d-2$, affine dimensions $1,4,11,23$, matching the block's table.

## D5, "with a class of multiplicity 2 the dimension drops to 0" is a $d=2$ statement

The block writes, in one sentence: *"So the feasible affine set has dimension $V+1-(3d-2)$ with $V$ the admissible-type count: $1$ at $d=2$, $4$ at $d=3$, $11$ at $d=4$. **With a class of multiplicity $2$ the dimension drops to $0$ and $\theta$ is forced** ($n=8$ with multiplicities $(26,2)$ is a witness), **and with a class of multiplicity $1$ at $d=2$ the system is infeasible at every $n\ge5$**."* The second clause carries "at $d=2$" and the first does not.

**It must.** At $d=3$ with multiplicities $(m_1,m_2,2)$ and $m_1,m_2\ge3$, the single inadmissible type is $\{333\}$, so $V=9$; the unknowns $(t,\theta)$ number $V+1=10$ and the equations number $3d=9$. **A system of nine equations in ten unknowns has solution set of dimension at least one, so it is never a point**, no rank computation required. The block's own formula agrees and gives $9+1-7=3$, so **the sentence contradicts the display immediately above it.**

Both Gate 2 reviewers stated the claim at $d=2$ and only there: [r341](REVIEW_r341.md) under the heading "$m_1=2$: $\theta$ is forced", inside its $d=2$ section, and [r342](REVIEW_r342.md) as the $(26,2)$ witness, likewise $d=2$. **The scope was lost when the verdict was folded into the block.**

*Screen S3.* $d=3$ with $m=(3,3,2)$ and with $m=(30,20,2)$: rank $M=$ rank $[M\mid v]=7=3d-2$, affine dimension $3$, and $\theta$ is **not** forced. $d=4$ with a multiplicity-$2$ class: dimension $10$. $d=2$ with $m=(26,2)$ and with $m=(3,2)$: rank $M=3$, rank $[M\mid v]=4$, dimension $0$, $\theta$ forced. So the claim holds exactly where the two reviewers put it.

**Repair.** *"At $d=2$, a class of multiplicity $2$ drops the dimension to $0$ and forces $\theta$."*

## D6, the $(26,2)$ witness is stronger than the block says

At $n=8$, $N=28$, $m=(26,2)$: tracelessness gives $\nu_2=-13\nu_1$ and $\sum m_i\nu_i^2=364\nu_1^2=1$. The admissible types are $\{111\},\{112\},\{122\}$. Rows (A$_2$) and (B$_2$) read $650t_{112}+52t_{122}=12$ and $-312t_{122}+650t_{112}=26$; subtracting, $-364t_{122}=14$, so

$$t_{122}=-\tfrac1{26}<0 .$$

The remaining four equations are consistent with it and pin $t_{111}=\tfrac{43}{2600}$, $t_{112}=\tfrac7{325}$ and $\theta=-\tfrac{27\sqrt{91}}{338}=-0.762022\ldots$, so the affine set is indeed a point. **But the point violates $T\ge0$, so $\Pi(\lambda)=\varnothing$ and $\theta^\ast(\lambda)=-\infty$** by the block's own convention. Under $\nu\to-\nu$, $\theta\to-\theta$ the three relations map to themselves with $T$ fixed, so the opposite sign assignment gives the same $t_{122}$ and is excluded too.

**The consequence is the same shape as the clause beside it**: no Weyl tensor has a two-valued spectrum with multiplicities $(26,2)$ at $n=8$, criticality included. Recording the witness as "$\theta$ is forced" states the weaker half of what it shows.

*Screen S4.* The six reduced equations at that spectrum, solved symbolically, return exactly the four values above.

## D7, what strong duality needs, and what "every valid bound" means

The certificate direction is right as stated. Summing the multipliers gives $\sum_\tau c_\tau t_\tau=K+2\theta\sum_i\gamma_i\nu_i$ with $K=\sum_i\big[2(n-2)\alpha_i-2\nu_i\beta_i-2\nu_i^2\gamma_i\big]$; with every $c_\tau\le0$ and $t\ge0$ the left side is $\le0$, and $\sum_i\gamma_i\nu_i>0$ then gives $\theta\le-K/\big(2\sum_i\gamma_i\nu_i\big)$. Both sign conditions are load-bearing and both are stated.

**Completeness carries two hypotheses, of which the block supplies one.** Boundedness is the block's compactness paragraph and is sound: $T\ge0$ with the row sum bounds every entry, and (C) at any row with $\nu_i\ne0$ (one exists, since $\lVert W\rVert=1$), bounds $\theta$ on both sides. **Feasibility is the missing one.** LP strong duality delivers a certificate attaining $\theta^\ast$ only when the primal is feasible; at an empty $\Pi(\lambda)$ the value is $-\infty$, every real number is a valid bound, and no multiplier of the stated form produces one. Infeasibility there is certified by a Farkas ray, which is a different object: it has no sign condition on $\sum_i\gamma_i\nu_i$ and it yields a contradiction rather than a bound. **The block's own $(26,2)$ witness is such a spectrum**, so the gap is not hypothetical.

**On which feasible set.** The block scopes this correctly in the sentence that follows, the rider that every spectral bound on the record is a certificate is refuted there, with [Lemma L73](../findings/bounds.md) and [Lemma L35](../findings/stratum-two-negative.md) named, but the completeness sentence itself still reads unrestricted. **Bounds valid on $\Pi(\lambda)$ and bounds valid on the true feasible set are different classes**, because $\Pi(\lambda)$ drops the pair cap; a bound of the second kind can be strictly stronger than anything the certificates reach. [r341](REVIEW_r341.md) asked for exactly this repair in the sentence rather than beside it.

**Repair.** *"At every spectrum where $\Pi(\lambda)\ne\varnothing$, LP strong duality makes every bound valid on $\Pi(\lambda)$ arise this way."*

## D8, the block contradicts post F43, forty lines apart in one file

[Post F43](../findings/bounds-relaxations.md) closes with: *"Since $\mathop{\mathrm{rank}}[M\mid v]=3d-2$ as well, $v$ lies in the column span of $M$, so **no combination of the equations pins $\theta$**."* It carries no multiplicity hypothesis. **The block sentence forty lines above says a class of multiplicity $2$ pins $\theta$ outright.** One of the two must be scoped, and it is post F43: at $(26,2)$, rank $M=3$ while rank $[M\mid v]=4$, so $v$ sits outside the column span and a single combination of the equalities returns $\theta$, which is how D6's value is obtained.

Post F43's own subject matter is the $d=3$, $(30,20,16)$ spectrum, where every multiplicity is at least $3$ and the sentence is true. **The repair is to say so**, since the sentence is what the vertex-enumeration programme rests on: *"at every spectrum with all $m_i\ge3$, $\mathop{\mathrm{rank}}[M\mid v]=3d-2$, $v$ lies in the column span of $M$, and no combination of the equations pins $\theta$."*

## D9, D10, the two consumers that inherit the scope

**[bounds.md:401](../findings/bounds.md), REFUTED.** *"Feasibility forces a single $\theta$ only when the feasible set is a point, which by Lemma L104 happens only through a class of multiplicity $2$."* Both halves fail.

- The **sufficiency** half fails as D5 does: a class of multiplicity $2$ at $d\ge3$ leaves a positive-dimensional set.
- The **necessity** half fails on its own. *Screen:* at $d=3$ with $m=(N-2,1,1)$ (no multiplicity-$2$ class anywhere), the admissible types are $\{111\},\{112\},\{113\},\{123\}$, so $V=4$, and the affine set is a point with $\theta$ forced, at both $m_1=10$ and $m_1=26$. The mechanism is visible without the screen: $V+1=5$ unknowns against $3d=9$ equations.
- The framing sentence *"forces a single $\theta$ only when the feasible set is a point"* is in any case the wrong criterion. $\theta$ is forced exactly when some left-null vector $y$ of $M$ has $y\cdot v\ne0$, which gives $\theta=-y\cdot b/(y\cdot v)$, a condition on rank $[M\mid v]$ against rank $M$, not on the dimension of the solution set.

The paragraph's conclusion (that infeasibility is conclusive while feasibility above $\theta_0(n)$ is not), is untouched by this and stands.

**[plan.md](../plan.md) item I13, REPAIRED.** *"Lemma L104 reduces the pinned class at a fixed spectrum to ten variables, feasible dimension $4$, and $\theta$ is not forced."* Those are the $d=3$, all-$m_i\ge3$ numbers, correct for the $(30,20,16)$ witness the item is built around, but written unqualified inside a scope the item states as *every* kernel-free three-value spectrum at $n\ge12$. That scope includes multiplicities $1$ and $2$, where $V<10$ and, at $m=(N-2,1,1)$, $\theta$ is forced outright. **The unqualified reading understates the item's own position**: a three-value spectrum with a small class is already decided by the equalities, and only the all-$m_i\ge3$ spectra need the vertex enumeration.

## D11, hypotheses the block leans on and does not state

- **$\lVert W\rVert=1$.** (C) is criticality on the unit sphere, and $\theta^\ast(\lambda)$ and the closing sentence "every $\theta$-critical point with that spectrum satisfies $\theta\le\theta^\ast(\lambda)$" are unit-norm statements. The block fixes the spectrum without fixing the norm. [r342](REVIEW_r342.md) supplies it in its C1 attainment paragraph; the block does not.
- **$\sum_im_i\nu_i=0$.** Both dependencies need it, the first for $2(n-2)\sum_im_i\nu_i=0$ to match $-2\sum_im_i\nu_i=0$, the second for the $\theta$ terms to cancel, which is the very clause the block calls out. It is nowhere stated in the block, and it is the hypothesis whose omission put a first pass of my own screen on non-traceless spectra and returned wrong ranks.
- **"Hollow", of a $3$-tensor, is undefined on the record.** [conventions.md](../findings/conventions.md) uses the word for matrices only ($K$ hollow, $\mathcal D_n$ hollow) and states the property the block needs, that $T_{abc}=c_{abc}^2$ vanishes when two indices coincide, under the structure-constants bullet without naming it. The block's definition of $\Pi(\lambda)$ turns on the word.
- **$\Pi$ collides inside the block's own neighbourhood.** [conventions.md](../findings/conventions.md) lists four senses and warns that two are incompatible; the block uses sense (iv), $\Pi(\lambda)$, and [Lemma L105](../findings/bounds-relaxations.md)'s proof eight lines below calls a different object "the $\Pi$-bound". Naming the sense at each use would cost a clause.
- **$d$ collides**, as [conventions.md](../findings/conventions.md) already records against this file by name: here it is the count of distinct eigenvalues, in [L35](../findings/stratum-two-negative.md) it is $u-\lambda_1^2$. The block's own opening makes its sense unambiguous, so this is a note rather than a defect.

## D12, the dropped pair cap, and the consumers

The block states the omission plainly, gives the cap's reduced form $\sum_k\mu_k^{(ij)}t_{ijk}\le2$, and says $\theta^\ast$ is therefore an upper bound for the relaxation [r324](REVIEW_r324.md) measured. That scoping is right, and it is what makes $\theta^\ast$ a legitimate upper bound: **dropping a valid constraint only raises the optimum**, so the closing inequality survives the omission intact.

Checking the consumers in the record files, [plan.md](../plan.md), [findings/bounds.md](../findings/bounds.md), [findings/bounds-relaxations.md](../findings/bounds-relaxations.md), [findings/fence-posts.md](../findings/fence-posts.md), [ATTEMPTS.md](../ATTEMPTS.md), **I found no use that reads $\theta^\ast$ as the value of the full pinned relaxation.** [Post F43](../findings/bounds-relaxations.md) repeats the caveat and adds that restoring the cap breaks its four-zeros count, so the vertex reading belongs to $\Pi(\lambda)$ as defined. [Plan item I13](../plan.md) treats the cap as a live sub-step, which is the correct reading of a constraint the calculus does not generate. The one place the description has gone wrong is [fence-posts.md](../findings/fence-posts.md)'s account of what [r324](REVIEW_r324.md) measured, which [r331](REVIEW_r331.md) refuted on its own terms and which is not L104's to carry.

## D1, the Gate 2 attribution

**The brief's premise is wrong, and the block is clean.** The section preamble immediately above the Lemma L104 heading reads: *"Gate 2, [r341](REVIEW_r341.md) and [r342](REVIEW_r342.md) on identical briefs; the reduction and Lemma L105 confirmed by both."* Both reports exist. [r341](REVIEW_r341.md)'s C3 records *"every coefficient, including the $(\nu_j+\nu_k)$ against the $2$. Verified independently at a spectrum I built from scratch (the $n=6$ balanced product), all six reduced equations exact"*; [r342](REVIEW_r342.md)'s C3 records the same, *"verified by hand at the balanced $S^3\times S^3$ spectrum at $n=6$, returning $\theta_0(6)=\sqrt{10}/3$ from both rows"*. **So the block's "re-derived independently by both reviewers and the whole system checked at the $n=6$ balanced product" is a true report of two named verdicts**, and the reference to [r324](REVIEW_r324.md) elsewhere in the block is a citation to a measurement, not the missing attribution.

[INDEX-results.md](../findings/INDEX-results.md) row 104 labels the result **Lemma**, which by that file's own legend means Gate 1 and Gate 2 passed; the index marks a missing verdict explicitly where there is one, as row 0 shows. **The index is consistent with the block.** What the index row does drop is the hypothesis: it reads *"a $\binom{d+2}3$-variable LP of rank $3d-2$"* with no multiplicity condition on either number, where the variable count genuinely needs $m_i\ge3$.

## What a repair would change

1. Scope the multiplicity-$2$ clause to $d=2$ (**D5**), and record with it that the $(26,2)$ point is infeasible rather than merely pinned (**D6**).
2. Scope [post F43](../findings/bounds-relaxations.md)'s "no combination of the equations pins $\theta$" to $m_i\ge3$ (**D8**).
3. Add the feasibility hypothesis to the completeness sentence, and say inside it that the bounds are those valid on $\Pi(\lambda)$ (**D7**).
4. Rewrite [bounds.md:401](../findings/bounds.md)'s parenthesis, whose criterion for a forced $\theta$ is the wrong one and whose multiplicity clause fails in both directions (**D9**), and qualify [plan.md](../plan.md) item I13's numbers as the all-$m_i\ge3$ row (**D10**).
5. State $\lVert W\rVert=1$ and $\sum_im_i\nu_i=0$ in the block, and give "hollow" a $3$-tensor entry in [conventions.md](../findings/conventions.md) (**D11**).
6. Record that rank $3d-2$ survives the generic spectrum (**D4**), which answers [r342](REVIEW_r342.md)'s closing open question in the all-simple case and removes the brief's worry that the reduction's rank claim has no content where the multiplicities are all one.
