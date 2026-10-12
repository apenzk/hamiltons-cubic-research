# VERIFY v148, Lemma L69: the enumeration behind "every equivariant graded critical point", the threshold $p,q\ge5$, and the nondegeneracy citation

**Verifier v148, round L69, 2026-09-07.** Cold brief: the statement and proof as quoted in [ROUND_L69.md](ROUND_L69.md), against the source at [graded-half.md](../findings/graded-half.md):363– and the canonical form at [results.md](../results.md):553. **No numerical work was done.** No script was run, no solver invoked; every number below is an exact hand evaluation of a rational expression, and where a decimal appears it is the record's own, checked against the exact value it is supposed to be. Log: [agent_logs/verify-L69-v148.log](../agent_logs/verify-L69-v148.log).

## Claim table

| # | claim, as a consumer would cite it | verdict |
|---|---|---|
| C1 | For $n\ge12$, every equivariant graded critical point with $\theta\ge\sqrt{3/2}$ is the Weyl operator of a two-factor sphere product $S^p\times S^q$ | **HYPOTHESIS-DEBT**, the argument is complete given the enumeration of $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$; that enumeration is Cartan's and has no proof and no readable source on this record |
| C2 | Those factors satisfy $p,q\ge5$ | **PROVEN**, hand-verified exactly, in both directions and at both parities |
| C3 | $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$ is the split condition, and at $p=5$ it is $n\ge12$ | **PROVEN** |
| C4 | Every factor is a sphere and $k=2$ | **PROVEN**, with one naming defect: the record's own criterion is *constant curvature*, which $\mathbb{RP}^m$ also satisfies |
| C5 | Three or more factors are excluded by the budget | **PROVEN**, and, under the invariant-count route, vacuously so |
| C6 | Every surviving split is Morse–Bott nondegenerate, $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ on the orbit tangent alone | **PROVEN**, [Lemma L27](../findings/nondegeneracy.md) covers $p,q\ge3$ with $(p,q)\ne(3,3)$; $p,q\ge5$ is strictly inside it, and the citation reaches what is proved |
| C7 | The gap to the second eigenvalue is $\frac1{2(M-1)}$, $M=\max(p,q)$ | **PROVEN**, $1/12$ at $S^5\times S^7$, exact |
| C8 | The invariant count "$3-0-2$, uniform over the gradings" | **GAP in the block**, the count is right and is derived in [r502](../reviews/REVIEW_r502.md) §1b, which the block cites; the block's own one-sentence version is false as literally written and omits three cases |
| C9 | The canonical form at [results.md](../results.md):553, read alone by a consumer | **GAP**, three load-bearing facts are absent from it: the normalisation converting $\theta$ to $\lVert W\rVert$, the discharge of the equality case $\theta=\sqrt{3/2}$, and the fact that $\mathbb{CP}^2$ sits at $n=4$ |

**One line.** The mathematics of L69 is right at every step I could check by hand, and the arithmetic is exact and tight in both directions, but the quantifier "every equivariant graded critical point" is carried entirely by Cartan's classification of the involutions of $\mathfrak{so}(n)$, which this record invokes bare, by its own admission in [conventions.md](../findings/conventions.md):34; and the canonical form a consumer would cite drops the normalisation that gives $\tfrac16$ its meaning and never discharges its own non-strict hypothesis.

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl operators on $\Lambda^2\mathbb R^n$: symmetric, first-Bianchi-free, Ricci-flat. $\theta(W)=P(W)$ at $\lVert W\rVert=1$, the cubic whose critical points are the objects at issue.
- Throughout the symmetric-space half of the record the Einstein normalisation is $\mathrm{Ric}=\tfrac12g$, so $\mathrm{scal}=n/2$ and $\operatorname{tr}R=n/4$, [Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/)'s, adopted at [graded-half.md](../findings/graded-half.md):108.
- **The bridge, and it is load-bearing everywhere below.** [Lemma L46](../findings/problem.md) gives $Q(W)=\lambda W$ for a locally symmetric Einstein space with $\lambda\ne0$, hence $\theta(W/\lVert W\rVert)=\lambda/\lVert W\rVert$; with $\lambda=\tfrac12$ this is $\theta=\dfrac1{2\lVert W\rVert}$ ([graded-half.md](../findings/graded-half.md):186). So

  $$\theta\ \ge\ \sqrt{3/2}\quad\Longleftrightarrow\quad \lVert W\rVert\ \le\ \frac1{2}\sqrt{\frac23}=\frac1{\sqrt6}\quad\Longleftrightarrow\quad \lVert W\rVert^2\le\tfrac16 .$$

  It is an **equivalence**, not an implication, and that is why the split condition characterises the points above the threshold rather than merely containing them.
- $f(m)=\dfrac m{8(m-1)}=\dfrac18\Bigl(1+\dfrac1{m-1}\Bigr)$; for a product $M_1\times\dots\times M_k$ of Einstein factors of the same constant, $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$, $B=\sum_af(n_a)-\dfrac n{8(n-1)}$ ([Lemma L48](../findings/problem.md)).
- "Graded" has three incomparable senses on this record ([conventions.md](../findings/conventions.md):126). **L69 is stated and proved in sense (C), pair-graded**: $W$ is $\mathrm{ad}(\mathfrak p)$-invariant for a $\mathbb Z_2$-grading $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$. The labelling table at [graded-half.md](../findings/graded-half.md):387 assigns it that sense and says the assignment is forced by the proof. I agree: every step quantifies over gradings.

## 1. The hypothesis inventory

**Hypotheses the block itself carries.**

| # | hypothesis | where stated | used? |
|---|---|---|---|
| H1 | $n\ge12$ | statement | **not consumed**, the block says so explicitly, and it is right: $n\ge12$ is where an admissible split first exists (§3). It *is* consumed in two other places the block does not flag: discharging the $\theta=\sqrt{3/2}$ equality case (§5) and discharging the $n=8$ triality exception to the grading enumeration (§2) |
| H2 | $W$ is a critical point of $P$ | statement | yes, and load-bearing, see the $\theta=1.236031$ non-critical point in §6 |
| H3 | $W$ is **graded**, sense (C) | statement | yes, the whole enumeration is over gradings |
| H4 | $W$ is **equivariant** | statement | yes, and load-bearing, see the second point on $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ in §6 |
| H5 | $\theta\ge\sqrt{3/2}$, **non-strict** | statement | yes; the non-strictness is where the fencepost lives (§5) |

**Hypotheses of every imported result, checked against the object L69 applies it to.**

| import | its hypotheses | does L69's object satisfy them? |
|---|---|---|
| [L46](../findings/problem.md), $Q(W)=\lambda W$, $\theta=\lambda/\lVert W\rVert$ | locally symmetric, **Einstein with $\lambda\ne0$** | Yes for the objects reached, sphere products and $\mathbb{CP}^m$ with $\lambda=\tfrac12$. **The block never states this import at all**; §7 |
| [L47](../findings/problem.md), $\lVert W\rVert^2\ge\tfrac16$ on every compact irreducible symmetric space, equality only at $\mathbb{CP}^2$ | compact, irreducible, symmetric, Einstein constant $\tfrac12$ | Yes for each irreducible factor of a product, by L48's "every factor is Einstein with the same constant $\tfrac12$". Note the residue: $S^m$ and $\mathbb{RP}^m$ have $W=0$ and are excluded from the theorem's $\ge\tfrac16$ by having no $\theta$ at all |
| [L48](../findings/problem.md), the partition decomposition | compact symmetric, product of Einstein factors of equal constant; **no flat factors**, which the normalisation forces | Yes. The no-flat-factors clause is what actually kills $p=1$ (§2) |
| [L27](../findings/nondegeneracy.md), Morse–Bott nondegeneracy | $p,q\ge3$, $(p,q)\ne(3,3)$, **and $n=p+q$ exactly** | Yes: $p,q\ge5$ is strictly inside, and the surviving splits are not padded. §4 |
| the $\mathbb Z_2$-grading enumeration | $n\ne8$ | Yes at $n\ge12$. **But the enumeration itself is Cartan's and is unsourced.** §2 |
| the invariant count $3-0-2$ etc. | a $\mathbb Z_2$-grading of $\mathfrak{so}(n)$; blocks $\ge5$ for the generic count | derived in [r502](../reviews/REVIEW_r502.md) §1b over all gradings; the block's compression drops cases. §2 |

**Which of these the written proof actually uses.** H2–H5 and L47, L48, L27, the enumeration and the count. H1 is used only where the block says it is not. **L46 is used and never named**, the block writes "$\lVert W\rVert^2\le\tfrac16$" for "$\theta\ge\sqrt{3/2}$" with no bridging sentence.

## 2. Pre-registered question 1, what enumerates "every equivariant graded critical point"?

**It is a classification, in two stages, and it is not a sweep.**

*Stage one, the enumeration.* The $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ are $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=n$, and $\mathfrak u(n/2)$ at even $n$, the table at [graded-half.md](../findings/graded-half.md):399, with $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ added at $n=8$ only.

*Stage two, the count.* At each grading, the space of $\mathrm{ad}(\mathfrak p)$-invariant elements of $\mathcal W_n$ is one-dimensional, so a $\mathfrak p$-equivariant critical point is the symmetric space's own Weyl operator up to scale. Above the threshold the scale is $+$, since $\theta(-W)=-\theta(W)<0$.

**What it inherits, and this is the finding.**

- **Stage one is Cartan's classification of the involutions of $\mathfrak{so}(n)$, invoked bare.** [references/](../references/) holds no Cartan, Helgason, Berger or Besse entry, I checked the folder listing. The record knows this and says so: [conventions.md](../findings/conventions.md):34 carries a row reading *"invoked in four findings files and **cited to no source anywhere on the record**"*, and [LEDGER.md](../findings/LEDGER.md):1284 records acquiring a source as blocked on the user. [nondegeneracy.md](../findings/nondegeneracy.md):611 states it in the bare form, *"gradedness forces $\mathfrak h$ symmetric and Cartan leaves only $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$"*. **So the quantifier in L69's statement rests on an unread source.** This is the debt the verdict names.
- The known trap around that classification does **not** bite L69. [ATTEMPTS.md](../ATTEMPTS.md)'s rule, restated at [LEDGER.md](../findings/LEDGER.md):1306, is that Cartan classifies up to $\mathrm{Aut}(\mathfrak g)$ while an argument reading $W$ off $\mathfrak h$ as an operator on $\Lambda^2\mathbb R^n$ consumes $SO(n)$-conjugacy, and the two part company at $n=8$. At $n\ge12$ they coincide, and the block discharges this explicitly at [graded-half.md](../findings/graded-half.md):409. Correct, and correctly flagged.
- **Stage two does have a derivation on file, and the block's own copy of it is defective.** The derivation is [REVIEW_r502.md](../reviews/REVIEW_r502.md) §1b, which the block cites by name. It runs: $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^p\oplus\Lambda^2\mathbb R^q\oplus(\mathbb R^p\otimes\mathbb R^q)$, three pairwise inequivalent $K$-irreducibles of real type, giving $\operatorname{End}^{\mathrm{sym}}_K=\mathbb R^3$; $(\Lambda^4\mathbb R^n)^K=0$ for $p,q\ge5$ since an $SO(m)$-invariant in $\Lambda^i\mathbb R^m$ needs $i\in\{0,m\}$, so Bianchi costs nothing; and Ricci is the rank-$2$ system $\begin{pmatrix}p-1&0&q\\0&q-1&p\end{pmatrix}$, so $3-0-2=1$, spanned by $(a,b,c)=\bigl(\tfrac q{p-1},\tfrac p{q-1},-1\bigr)$. That vector is exactly the vertex triple [Observation L56](../results.md):541 records for $S^p\times S^q$, an independent corroboration inside the record.

  **The block compresses this into one sentence, and the sentence is false as literally written.** [graded-half.md](../findings/graded-half.md):367 reads *"at every $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ the space of $K$-invariant symmetric endomorphisms of $\Lambda^2$ has dimension $3$"*. It is $4$ when a block is $4$ (the block says so in its next clause), **$5$ at $(4,4)$**, $2$ at $p=1$ and $1$ at $p=0$. r502 carries the $(4,4)$ refinement as $5-2-2=1$; the block carries neither it nor the $p=0,1,2,3$ cases, and its *"$p=1$ carries no equivariant point at all"* is an assertion here and a derivation only in r502 (Ricci forces both coefficients to zero; independently, a $1$-dimensional factor cannot carry Einstein constant $\tfrac12$).

**Does it need a pinning formula for the value, and what happens where that formula has no value?** **No, and this is the repair's whole point.** The value is not pinned by [Conjecture L8](../findings/graded-half.md)'s $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$, which is refuted off the balanced splits, fails at $S^5\times S^7$ by that block's own list, and has an infinite pole family at $2q=p$ reaching $\theta^2=912/575>\tfrac32$ at $(\mathfrak{so}(25),\mathfrak{so}(20)\oplus\mathfrak{so}(5))$, odd $n=25$ with both blocks $\ge5$, i.e. **inside L69's own range**. L69 routes the value instead through L46 and L48: $\theta=1/(2\lVert W\rVert)$ with $\lVert W\rVert^2=f(p)+f(q)-\frac n{8(n-1)}$, which is defined at every split with $p,q\ge2$ and has no poles. **So the pair at which L8's formula has no value is a pair at which L69 still has one**, and I checked the worst case: at $(20,5)$, $n=25$, the split condition reads $\frac1{19}+\frac14-\frac1{24}$, exactly, over the common denominator $456$: $\frac{24}{456}+\frac{114}{456}-\frac{19}{456}=\frac{119}{456}$ against $\frac13=\frac{152}{456}$, so it passes, and $\lVert W\rVert^2=\tfrac18\bigl(1+\tfrac{119}{456}\bigr)=\tfrac{575}{3648}$, giving $\theta^2=\frac1{4\lVert W\rVert^2}=\frac{3648}{2300}=\frac{912}{575}$, **the same value L8's pole reports, recovered by a route with no pole in it.** That is a genuine cross-check of the repair at the exact pair where the superseded formula dies.

## 3. Pre-registered question 2, is $p,q\ge5$ right in both directions?

**Yes, exactly, and the characterisation is tight rather than a containment**, because the bridge in §0 is an equivalence. Every value below is exact.

**The reduction.** $\lVert W\rVert^2=f(p)+f(q)-\frac n{8(n-1)}$ with $f(m)=\frac18\bigl(1+\frac1{m-1}\bigr)$ and $\frac n{8(n-1)}=\frac18\bigl(1+\frac1{n-1}\bigr)$, so

$$\lVert W\rVert^2=\tfrac18\Bigl(1+\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}\Bigr),\qquad \lVert W\rVert^2\le\tfrac16\iff \tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}\le\tfrac13 .$$

The block's cancellation is correct: $\lVert W\rVert^2\le\tfrac16$ is $1+X\le\tfrac86=\tfrac43$, i.e. $X\le\tfrac13$.

**Corroborated against a value the record derived independently.** At $(5,7)$, $f(5)+f(7)-\frac{12}{88}=\frac5{32}+\frac7{48}-\frac3{22}=\frac{319-144}{1056}=\frac{175}{1056}$, which is exactly the figure [Reviewer 88](../findings/graded-half.md):192 records for $S^5\times S^7$, short of $\tfrac16=\frac{176}{1056}$ by $\frac1{1056}$. Eight times that is $\frac1{132}$, the block's margin. At $(6,6)$, $\frac3{20}+\frac3{20}-\frac3{22}=\frac9{55}$ (again the recorded figure), short of $\tfrac16$ by $\frac1{330}$, eight times which is $\frac4{165}$. **Both of the block's two margins are confirmed exactly, against numbers derived elsewhere in the record for a different purpose.**

**Direction one: every split with $p,q\ge5$ clears $\sqrt{3/2}$ at $n\ge12$.** Fix $n$ and write $g(p)=\frac1{p-1}+\frac1{n-p-1}$. Each term is convex in $p$ on $(1,n-1)$, so $g$ is convex and symmetric about $p=n/2$; on the integer range $5\le p\le n-5$ its maximum is at the ends, $p=5$. At $p=5$, $q-1=n-6$ and

$$\frac14+\frac1{n-6}-\frac1{n-1}\le\frac13\iff \frac{(n-1)-(n-6)}{(n-6)(n-1)}\le\frac1{12}\iff \frac5{(n-6)(n-1)}\le\frac1{12}\iff n^2-7n-54\ge0,$$

whose larger root is $\frac{7+\sqrt{265}}2$. $16^2=256<265<289=17^2$, so the root lies strictly between $\frac{7+16}2=11.5$ and $\frac{7+17}2=12$; the least integer clearing it is $12$. Check the two integers straddling it: at $n=12$, $144-84-54=6\ge0$; at $n=11$, $121-77-54=-10<0$. **So at every $n\ge12$ and every $p,q\ge5$ the condition holds, hence every such product has $\theta\ge\sqrt{3/2}$.**

**Direction two: no split with a factor $\le4$ ever clears it, at any $n$.**

| $p$ | the condition | verdict |
|---|---|---|
| $p=4$ | $\tfrac13+\tfrac1{q-1}-\tfrac1{n-1}\le\tfrac13\iff\tfrac1{q-1}\le\tfrac1{n-1}\iff q\ge n$ | impossible, since $n=p+q>q$. **Fails at every $n$ and every $q$** |
| $p=3$ | $\tfrac12+\bigl(\tfrac1{q-1}-\tfrac1{n-1}\bigr)$, second bracket $>0$ since $q<n$ | $>\tfrac12>\tfrac13$ |
| $p=2$ | $1+\bigl(\tfrac1{q-1}-\tfrac1{n-1}\bigr)>1$ | fails |
| $p=1$ | $f(1)$ undefined; a $1$-dimensional factor is flat and cannot carry Einstein constant $\tfrac12$ | excluded before the arithmetic |

The $p=4$ argument is structural, as the block says: $\tfrac1{p-1}=\tfrac13$ exhausts the budget exactly and the remaining bracket is strictly positive. **It is not vacuous, and the nearest witness confirms it.** At $(4,8)$, $n=12$: $\frac13+\frac17-\frac1{11}=\frac{77+33-21}{231}=\frac{89}{231}$ against $\frac13=\frac{77}{231}$, over by $\frac{12}{231}=\frac4{77}$; and $\lVert W\rVert^2=\frac18\bigl(1+\frac{89}{231}\bigr)=\frac{320}{1848}=\frac{40}{231}$, so $\theta^2=\frac{231}{160}=1.44375<\tfrac32$ and $\theta=1.201561\ldots$ **$S^4\times S^8$ is a genuine $\mathbb Z_2$-graded, equivariant critical point at $n=12$ that sits below the threshold, the pre-registered $(4,8)$ edge, and it behaves.**

**At the boundary, $n=12$ exactly.** The admissible splits are $(5,7)$, margin $\frac1{132}$, and $(6,6)$, margin $\frac4{165}$; the inadmissible ones are $(4,8)$ over by $\frac4{77}$, $(3,9)$ and $(2,10)$ a fortiori. $\theta^2(S^5\times S^7)=\frac{1056}{700}=\frac{264}{175}=1.5085714\ldots$, i.e. $\theta=1.228239\ldots$, **which is the value [Lemma L58](../results.md):547 records for $S^5\times S^7$, to all six printed digits.** $\theta^2(S^6\times S^6)=\frac{55}{36}=\theta_0(12)^2$, i.e. $\theta=1.236033\ldots$, the record's $\theta_0(12)$.

**Below the boundary.** $(5,5)$ at $n=10$: $\frac14+\frac14-\frac19=\frac7{18}$ against $\frac6{18}$, over by $\frac1{18}$. $(5,6)$ at $n=11$: $\frac14+\frac15-\frac1{10}=\frac7{20}$ against $\frac{20}{60}$, over by $\frac1{60}$. Both as the block states. **So $p,q\ge5$ alone genuinely permits $n=10$, and the block is right that the two constraints are independent**, the [lean/INDEX.md](../lean/INDEX.md):226 row makes the same point and is consistent with it.

**Odd $n$, which the brief asked for separately.** The lemma has content at odd $n$ and the arithmetic holds there. At $n=13$ the splits with $p,q\ge5$ are $(5,8)$ and $(6,7)$:

- $(5,8)$: $\lVert W\rVert^2=\frac5{32}+\frac17-\frac{13}{96}=\frac{105+96-91}{672}=\frac{110}{672}=\frac{55}{336}$, so $\theta^2=\frac{336}{220}=\frac{84}{55}=1.5272\overline{72}>\tfrac32$.
- $(6,7)$: $\lVert W\rVert^2=\frac3{20}+\frac7{48}-\frac{13}{96}=\frac{72+70-65}{480}=\frac{77}{480}$, so $\theta^2=\frac{480}{308}=\frac{120}{77}=1.5584\ldots>\tfrac32$, **and $\frac{120}{77}$ is exactly the figure [graded-half.md](../findings/graded-half.md):129 records as the best odd split at $n=13$.**

And $(4,9)$ at $n=13$ fails: $\frac13+\frac18-\frac1{12}=\frac{8+3-2}{24}=\frac9{24}=\frac38>\frac13$. **Both directions hold at odd parity.**

**No finding.** $p,q\ge5$ is right in both directions, at both parities, and at the boundary, and the block's four stated margins are exact.

## 4. Pre-registered question 3, is "each is nondegenerate" the same statement the record proves?

**Yes. The citation reaches what is proved, not what is claimed, and the range is comfortable rather than tight.**

**Where it is established.** [Lemma L27](../findings/nondegeneracy.md):457, canonical block. Statement: for $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$, $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ at $W_{p,q}$, attained exactly on the orbit tangent, so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$.

**Range against $p,q\ge5$.** $p,q\ge5\Rightarrow p,q\ge3$ and $(p,q)\ne(3,3)$, so every split L69 admits is strictly interior to L27's hypothesis, not on its boundary and not near either excluded case. **The two exclusions are also of the right kind for this to be safe**: L27 records that at $(3,3)$ the decomposition holds and two scalars collide, while at $q\le2$ *the decomposition itself is false* (the ten dimensions over-count by $2$ at $q=2$ and by $1+p$ at $q=1$). Neither failure mode is approached at $p,q\ge5$.

**Proved, not claimed.** L27's argument is the multiplicity-free $O(p)\times O(q)$ decomposition of $\mathrm{Weyl}_n$ into ten summands with pairwise distinct Young labels, so $L_e$ is a scalar on each and each value *is* an eigenvalue rather than a lower bound. **Its one imported input is in [references/](../references/)**: irreducibility of the summands is [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 4.6 and Remark 4.7(ii), and the folder [nienhaus-2023-second-best-einstein](../references/nienhaus-2023-second-best-einstein/) exists. The block itself notes that the source proves multiplicity-freeness at $p,q\ge5$ and that only the $p,q\le4$ cases needed supplying, **so at exactly L69's range the citation is to the source's own theorem.** The trace check $\operatorname{tr}_{\mathcal W_n}L_e=0$ is an independent verification of the ten values that forces the disputed $-\mu$ uniquely; I regard that as the strongest single piece of evidence in the block, since it is a consistency condition the assignment could have failed and does not.

**Hand-check of the gap, at the boundary split.** The eigenvalues below $\tfrac12$ on $W^\perp$ are $\lambda_m=\frac{m-2}{2(m-1)}$ for $m\in\{p,q\}$, $\pm\mu$, and $0$. At $(5,7)$: $\lambda_7=\frac5{12}$, $\lambda_5=\frac38$, and $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}=\frac{3\cdot5-1}{2\cdot4\cdot6}=\frac{14}{48}=\frac7{24}$, so $\mu=\frac5{24}$. The second-largest is $\lambda_7=\frac5{12}$ and the gap is $\tfrac12-\tfrac5{12}=\tfrac1{12}$, **exactly the block's $1/12$ at $S^5\times S^7$, and exactly $\frac1{2(M-1)}$ with $M=7$.** The block's warning that the gap decays like $1/n$ rather than sitting at $0.292$ is correct and is the kind of correction that ought to travel with the claim; here it does, in the same sentence.

**One citation asymmetry, minor.** [graded-half.md](../findings/graded-half.md):381 calls it *"the unconditional nondegeneracy theorem of [nondegeneracy.md](../findings/nondegeneracy.md)"* without a number, while [results.md](../results.md):553 names L27. A consumer reading the findings copy has to find the theorem by hand in a $777$-line file. The word *"unconditional"* is also doing more work than it should: L27 is unconditional in $n$ but **not** in $(p,q)$, carrying two exclusions. At $p,q\ge5$ this costs nothing, but the adjective is the kind that survives a quotation into a context where it does.

**No finding of substance.** C6 and C7 hold as stated.

## 5. The named trap, each citable claim read alone, as a consumer would

*This record's signature failure is a correction landing beside the statement it corrects. I read [results.md](../results.md):553 and the [graded-half.md](../findings/graded-half.md):365 statement each on its own, with nothing else in view.*

### D1. The non-strict hypothesis is discharged three paragraphs below the $\square$, and not at all in the canonical form

**Locate.** [graded-half.md](../findings/graded-half.md):369, inside the proof: *"**Irreducible:** $\theta\le\sqrt{3/2}$ with equality only at $\mathbb{CP}^2$ (the $\lVert W\rVert^2\ge\tfrac16$ theorem above), so no irreducible space **exceeds** the threshold."* And [results.md](../results.md):555: *"Irreducible spaces have $\theta\le\sqrt{3/2}$ with equality only at $\mathbb{CP}^2$ (Lemma L47)."*

**Exhibit the failure concretely.** The lemma's hypothesis is $\theta\ge\sqrt{3/2}$, **non-strict**. "No irreducible space exceeds the threshold" eliminates $\theta>\sqrt{3/2}$ and leaves $\theta=\sqrt{3/2}$ standing, which is inside the hypothesis. The object that would live there is $\mathbb{CP}^2$, at $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}\big\vert_{m=2}=\frac{3\cdot3}{3\cdot2\cdot1}=\frac32$ exactly. **The fact that closes the hole is that $\mathbb{CP}^2$ has $n=4$, outside $n\ge12$.** In [graded-half.md](../findings/graded-half.md) that fact appears at line 405, *"The one $\mathfrak u(m)$ point at the threshold is $\mathbb{CP}^2$ at $n=4$, outside the lemma's range"*, which is **past the $\square$**, in the paragraph about the assembly's weakest joint, and reached by a reader following a different thread. In [results.md](../results.md):553 **it does not appear at all**: the canonical form names $\mathbb{CP}^2$, states it as the equality case, and never says what dimension it has.

**Argue the opposite.** The most charitable reading is that "exceeds the threshold" is loose for "reaches or exceeds", and that $\mathbb{CP}^2$'s dimension is common knowledge a reader supplies. That reading is available, and under it the sentence is true. It is also the reading the record's own trap warning exists to forbid: a consumer citing the canonical form for "the equality case is excluded" is citing a sentence that does not exclude it.

**Verdict: real, and it is the trap.** [r501](../reviews/REVIEW_r501.md) recorded the same thing as its F4, *"the proof discharges a non-strict hypothesis with a strict inequality, saved only by $\mathbb{CP}^2$ having $n=4$"*, and the repair landed in the later paragraph rather than in the sentence, and never reached [results.md](../results.md):553 at all.

### D2. The apposition in the canonical form admits an object the lemma's conclusion excludes

**Locate.** [results.md](../results.md):555: *"let $W$ be an equivariant graded critical point, **the Weyl operator of a compact symmetric space**, the correspondence proved by the invariant count in [graded-half.md](../findings/graded-half.md) rather than by Lemma L8, with $\theta\ge\sqrt{3/2}$."*

**Exhibit the failure concretely.** Read the em-dash clause as it is punctuated, as a gloss on the hypothesis, and take $n=12$ with $W$ the zero-padding of $W_{\mathbb{CP}^2}$ into $\mathcal W_{12}$. Then: it is a critical point, since [nondegeneracy.md](../findings/nondegeneracy.md):409 records that padding is exactly critical-point-preserving and $Q$ commutes with it; $\theta$ is unchanged by padding, so $\theta=\sqrt{3/2}$ and the non-strict hypothesis holds; and it is the Weyl operator of a compact symmetric space, namely $\mathbb{CP}^2$. **It is not a two-factor sphere product, so the conclusion fails at it.** [nondegeneracy.md](../findings/nondegeneracy.md):633 sharpens the point: [Reviewer 316](../reviews/REVIEW_r316.md) finds padded $W_{\mathbb{CP}^2}$ to be a Morse–Bott nondegenerate **local maximum** at $\theta=\sqrt{3/2}$ exactly at $n=8,10,12$, so *"$\{\theta\ge\sqrt{3/2}\}\cap\mathrm{Crit}$ carries a non-sphere-product member at its boundary."* The same object is [INDEX-results](../findings/INDEX-results.md):20's *"Fox's $r=4$ subalgebra at exactly $\sqrt{3/2}$"*.

**Argue the opposite.** The operative hypothesis is "equivariant graded critical point" in sense (C); the apposition is a *consequence* the invariant count supplies, not a definition. Padded $W_{\mathbb{CP}^2}$ fails sense (C): [graded-half.md](../findings/graded-half.md):392 records that it is equivariant for **no** symmetric subalgebra, $\dim\mathfrak k(W)=32$ at $n=12$ with neither $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ nor $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ embedding in it ([r317](../reviews/REVIEW_r317.md)). **I checked that this two-case check is exhaustive** and it is, by dimension: the symmetric subalgebras of $\mathfrak{so}(12)$ have dimensions $\binom p2+\binom q2$, namely $55,46,39,34,31,30$ at $p=1,\dots,6$, plus $\dim\mathfrak u(6)=36$; only $31$ and $30$ fit inside $32$, and those are exactly the two r317 tests. So under the correct reading the statement holds, and the check behind it is complete even though the block does not say why only two cases were run.

**Verdict: real as a citation hazard, withdrawn as a refutation.** The lemma is true; the canonical form's punctuation invites a reading under which it is false at $n=12$, at the exact value the hypothesis admits and at an object the record already holds. D1 and D2 are the same fencepost seen from two sides, and they reinforce each other: a consumer who takes the apposition literally is *also* the consumer who was never told $\mathbb{CP}^2$ has $n=4$.

### D3. A citation to a file that does not contain the lemma

**Locate.** [graded-half.md](../findings/graded-half.md):379: *"every factor is a sphere by [Lemma L47](fence-posts.md)'s quantitative $\lVert W_a\rVert^2\ge\tfrac16$"*.

**Exhibit.** [fence-posts.md](../findings/fence-posts.md) contains **zero** occurrences of the string "L47". L47's canonical block is [problem.md](../findings/problem.md):221, and its statement is [results.md](../results.md):525; [graded-half.md](../findings/graded-half.md):118 says so itself, $261$ lines above the bad link.

**Argue the opposite.** The lemma number is given, so a determined reader finds it. That is true and is why this is a defect in the write-up rather than in the mathematics.

**Verdict: real.** It is the surviving instance of a class [r501](../reviews/REVIEW_r501.md) already recorded, *"three of them pointing at [fence-posts.md](../findings/fence-posts.md) for a theorem that lives in [nondegeneracy.md](../findings/nondegeneracy.md)"*. The nondegeneracy sentence was repaired; this one, in the paragraph the same review rewrote, was not.

### D4. The identity that gives $\tfrac16$ its meaning is used and never stated

**Locate.** The whole arithmetic core, [graded-half.md](../findings/graded-half.md):373–377 and [results.md](../results.md):555, which move from $\theta\ge\sqrt{3/2}$ to *"the condition $\lVert W\rVert^2\le\tfrac16$"* with no intervening sentence.

**Exhibit.** $\theta$ and $\lVert W\rVert$ are different functionals; the step is $\theta=\lambda/\lVert W\rVert$ with $\lambda=\tfrac12$, i.e. [Lemma L46](../findings/problem.md) plus the Petersen–Stanfield normalisation $\mathrm{Ric}=\tfrac12g$. **Neither is named in the L69 block, and neither is named in the canonical form.** They live at [graded-half.md](../findings/graded-half.md):108 and :186, some $180$ and $260$ lines above. Without them a reader cannot check that the two inequalities in the statement are about the same object, and cannot see that L46 carries the hypothesis $\lambda\ne0$, which is what excludes Ricci-flat algebraic curvature operators like the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family, whose $W$ is expressly *not* the Weyl part of a symmetric metric ([graded-half.md](../findings/graded-half.md):190).

**Argue the opposite.** Within [graded-half.md](../findings/graded-half.md) the normalisation is file-wide and a reader of the file has met it. That defence does not reach [results.md](../results.md):553, which is the form consumers cite and which stands alone in a different file.

**Verdict: real, and unrepaired.** [r501](../reviews/REVIEW_r501.md) filed it as F2, *"the Einstein normalisation $\mathrm{Ric}=\tfrac12g$ and the identity $\theta=\lambda/\lVert W\rVert$ are both unstated, and without them the constant $\tfrac16$ has no meaning"*, and the current text still does not state either.

### D5. "Is a sphere" names one object where the criterion names a class

**Locate.** [graded-half.md](../findings/graded-half.md):130, the L48 derivation L69 imports: *"Each $\lVert W_a\rVert^2\ge0$ vanishes exactly when that factor has constant curvature, i.e. **is a sphere**."*

**Exhibit.** $\mathbb{RP}^m$ is a compact symmetric space of constant curvature that is not a sphere; the record states its $W=0$ at [graded-half.md](../findings/graded-half.md):114, in the same file. So $\mathbb{RP}^p\times\mathbb{RP}^q$ is a compact symmetric space with the same curvature operator, the same $\lVert W\rVert^2$ and the same $\theta$ as $S^p\times S^q$, and the sentence *"$W$ is the Weyl tensor of a two-factor sphere product"* is false of it as a statement about the space.

**Argue the opposite.** L69 classifies $W$, an element of $\mathcal W_n$, not a manifold; $W_{\mathbb{RP}^p\times\mathbb{RP}^q}=W_{S^p\times S^q}$, so the conclusion is correct about the object it is about, and "sphere product" is the record's standing name for that curvature operator.

**Verdict: real but cosmetic.** The correct phrasing is "the Weyl operator of a two-factor sphere product", which [results.md](../results.md):555 in fact uses in its conclusion while [graded-half.md](../findings/graded-half.md):365 says "is a two-factor sphere product". No downstream consumer is misled about a value.

## 6. The universal claim with no witness, one object from each structured family the record names

*"The only equivariant graded points above $\sqrt{3/2}$ are two-factor sphere products with $p,q\ge5$." A universal claim of this shape is refuted by one object, so I tried one from every family the record names, preferring objects inside $n\ge12$.*

| candidate | in scope? | its value | how the lemma disposes of it |
|---|---|---|---|
| $\mathbb{CP}^6$ at $n=12$, the $\mathfrak u(6)$ grading | **yes**, a genuine equivariant graded critical point at the lemma's own dimension, and not a sphere product | $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}\big\vert_{m=6}=\frac{7\cdot11}{3\cdot6\cdot5}=\frac{77}{90}$, $\theta=0.9249626\ldots$ | by the **threshold**, with room to spare. This is the family that would break the lemma if the threshold were the assumption rather than the filter |
| $\mathbb{CP}^m$, $m=3,4,5$ | at $n=6,8,10$, below range | $\frac{10}9,\frac{35}{36},\frac{9}{10}$, i.e. $1.0540926,\ 0.9860133,\ 0.9486833$ | **all four of the block's decimals are exact**, and the family is strictly decreasing, so $\sup_{m\ge3}\theta=1.0540926<\sqrt{3/2}$, the exclusion is uniform in $m$, not a sweep |
| $\mathbb{CP}^2$, $n=4$ | **no**, $n=4$ | $\theta^2=\frac{3\cdot3}{3\cdot2\cdot1}=\frac32$ exactly | by $n\ge12$ **only**, this is D1 |
| padded $W_{\mathbb{CP}^2}$ at $n=12$ | **no**, not pair-graded | $\theta=\sqrt{3/2}$ exactly, a nondegenerate local maximum | by failing hypothesis H3/H4, this is D2, and it is the closest object to a counterexample on the whole record |
| $\mathbb{HP}^2$ at the exceptional pair $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ | **no**, $n=8$ | $\theta^2=\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}\big\vert_{m=2}=\frac{16\cdot7}{9\cdot2\cdot1\cdot5}=\frac{56}{45}$, $\theta=1.1155467\ldots$ | twice: below the threshold, **and** the exceptional gradings exist at $n=8$ alone |
| the second graded point on $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ | **no**, graded but **not equivariant**, $\Delta=1.512231$ | $\theta=1.088948$ against $S^3\times S^5$'s $1.115547$ on the identical pair | by failing H4. **This is the object that makes "equivariant" load-bearing rather than decorative**: same pair, same $\dim\mathfrak k=13$, same $\dim\mathfrak m=15$, identical isotropy Killing spectrum, different point |
| the $(\mathfrak{su}(m),\mathfrak{so}(m))$ Ricci-flat Kähler family at $m=6$, $n=12$ | **no**, $\mathfrak{su}(6)$ is not a symmetric subalgebra of $\mathfrak{so}(12)$ ($\mathfrak u(6)$ is, at one dimension more) | $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}\big\vert_{m=6}=\frac{42}{40}=\frac{21}{20}$, $\theta=1.0246951\ldots$ | twice over, by scope and by value. Its $m=3$ member gives $\theta^2=\frac{12}{10}=\frac65$, the record's $\sqrt{6/5}$, so the family's ceiling above $m=2$ is $1.0954451<\sqrt{3/2}$ |
| a three-factor product, e.g. $S^4\times S^4\times S^4$ at $n=12$ | **no** |, | twice over: $\mathfrak{so}(4)^{\oplus3}$ is not the fixed algebra of an involution of $\mathfrak{so}(12)$, so it is not pair-graded at all; and independently the budget gives $\lVert W\rVert^2>\tfrac18\bigl(2-\tfrac1{11}\bigr)=\frac{21}{88}>\tfrac16$ |
| the non-diagonal $S=0$ point at $\theta=1.236031$, even $n\ge12$ | **no**, **not critical** | $1.236031>\sqrt{3/2}$ | by failing H2. [INDEX.md](../findings/INDEX.md):23 records it as the witness that criticality is part of the statement; it is the one object I found above the threshold that a careless statement of L69 would have to answer for |
| [Reviewer 307](../reviews/INDEX.md)'s census: $18$ graded critical points at $n=8$, $15$ of them non-equivariant | **no**, $n=8$ | tops out at $\theta=1.0987530$ | evidence rather than a theorem, and the block says so. It is the only systematic look at the non-equivariant graded set, and it is at a dimension the lemma excludes |

**Does the scope admit an exceptional pair?** **No.** The two exceptional $\mathbb Z_2$-gradings, $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$, exist at $n=8$ only, being triality images of $\mathfrak{so}(1)\oplus\mathfrak{so}(7)$ and $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$; at $n\ge12$ the enumeration has two families and no exceptions. The block's *"unaffected, twice over"* is right, and the second reason (that both exceptional points sit below $\theta\ge\sqrt{3/2}$ anyway), is the one that would survive if the first ever failed.

**No witness found.** Every object I could reach either sits below the threshold by an exact value I computed by hand, or fails a hypothesis that the record identifies by name and that I could check independently. The two objects that come closest are padded $W_{\mathbb{CP}^2}$, which sits **at** the threshold and is excluded only by gradedness, and the $\theta=1.236031$ point, which sits **above** it and is excluded only by criticality. **Both hypotheses are therefore load-bearing at the boundary and neither can be dropped for convenience.**

## 7. Comparing the forms

| form | what it says | what it drops |
|---|---|---|
| [graded-half.md](../findings/graded-half.md):365, statement + proof | *"is a two-factor sphere product $S^p\times S^q$"* | the $\theta\leftrightarrow\lVert W\rVert$ bridge (D4); the equality case's discharge, which sits after the $\square$ (D1); it says "sphere product" where the object is the Weyl operator (D5); and it cites L47 to the wrong file (D3) |
| [results.md](../results.md):553, canonical | *"is the Weyl tensor of a two-factor sphere product"* (the better phrasing) and it **is** the most complete form, carrying all three caveats in its last sentence: the pair-graded sense, the $n\ne8$ enumeration caveat, and *"$\Delta=0$ certifies equivariance only where $\ker W=0$"* | the bridge (D4); $\mathbb{CP}^2$'s dimension (D1); and its em-dash apposition invites D2 |
| [results.md](../results.md):180, landscape line | the statement, the split condition, and *"which at $p=5$ reads $n\ge12$"* | **every caveat.** No sense-label, no $n\ne8$, no $\ker W$ clause, no equality discharge. A consumer who reads only the landscape index gets a statement with none of its guards |
| [lean/INDEX.md](../lean/INDEX.md):226, `proved` | the split condition's arithmetic: the two-constraints point, $(5,5)$ at $\frac7{18}$, $(5,6)$ at $\frac7{20}$, $(5,7)$ by $\frac1{132}$, $(6,6)$ by $\frac4{165}$, and the $p=4$ structural exclusion. Kernel-checked, no `native_decide`. Owns its debt: *"the invariant count and the reducible-case norm decomposition, both imported"* |, |
| [lean/INDEX.md](../lean/INDEX.md):261, `partial` | the same file, reducing the split condition at $p=5$ to `q² + 3q - 64 ≥ 0` and thence to $q\ge7$ | says *"the rest of L69 is representation theory and is `out`"* |

**The Lean rows are correct and I verified their arithmetic.** Substituting $n=q+5$ into $n^2-7n-54$ gives $q^2+10q+25-7q-35-54=q^2+3q-64$; its positive root is $\frac{-3+\sqrt{265}}2$, between $6$ and $7$ since $265$ lies between $256$ and $289$, so over the integers the condition is $q\ge7$. At $q=6$, $36+18-64=-10<0$; at $q=7$, $49+21-64=6\ge0$. **Both directions, as the row claims.**

**One index defect.** [lean/INDEX.md](../lean/INDEX.md) carries **two rows for L69 pointing at the same file** with two different status words, `proved` and `partial`. They do not contradict each other (the first is scoped to the theorem the file states, the second to L69 as a whole) but a consumer scanning the status column sees a result that is simultaneously proved and partial, and nothing in either row says which reading each word takes. **What the row would have to claim** if it were one row: *proved, the split condition $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$, its $p=5$ reduction to $n\ge12$ in both directions, and the $p\le4$ exclusion; everything else in L69, the grading enumeration, the invariant count, the norm decomposition and the nondegeneracy, is `out`.*

## 8. The gap between what is proven and what is used

**Proven, and a consumer may cite it as such.**

1. The split condition and every consequence drawn from it: $p,q\ge5$ is exactly the admissible range at $n\ge12$, in both directions, at both parities, and at the boundary; $p\le4$ fails at every $n$; $p=5$ is $n\ge12$ and $n\ge12$ is where an admissible split first exists. §3, all exact.
2. Given the identification of the point, nondegeneracy with $\lambda_{\max}=\tfrac12$ on the orbit tangent alone, and the gap $\frac1{2(M-1)}$. §4, from [L27](../findings/nondegeneracy.md) whose own imported input is a source in [references/](../references/).
3. The exclusion of $k\ge3$ by the budget, $\lVert W\rVert^2>\tfrac18\bigl(k-1-\tfrac1{n-1}\bigr)$, which at $k=3$ exceeds $\tfrac16$ whenever $n>\tfrac52$, I checked the inequality clears to $\tfrac1{n-1}<\tfrac23$. Correct, and the block is right that the superseded argument ("$B$ is minimised at $k=2$") proved nothing.
4. The $\mathfrak u(m)$ family's exclusion by value, uniformly in $m$ rather than by cases.

**Used but not proven here, and a consumer must inherit it.**

1. **Cartan's classification of the involutions of $\mathfrak{so}(n)$**, the enumeration the universal quantifier ranges over. No proof, no source, and the record says so in its own [conventions.md](../findings/conventions.md):34. **This is the debt.**
2. The invariant count. Derived, but in [REVIEW_r502.md](../reviews/REVIEW_r502.md) §1b rather than in either citable form; the block's compression of it is false as literally written and omits $(4,4)$, $p=0$, $p=1$, $p=2$, $p=3$ (§2).
3. The normalisation and [L46](../findings/problem.md), unstated in both citable forms (D4).
4. [L47](../findings/problem.md) and [L48](../findings/problem.md), correctly applied, one of them mis-linked (D3).

**What a consumer may cite, stated positively.** *For $n\ge12$, let $W\in\mathcal W_n$ be a critical point of $P$ that is $\mathrm{ad}(\mathfrak p)$-invariant for a $\mathbb Z_2$-grading $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$, and suppose $\theta(W)\ge\sqrt{3/2}$. Granting the classification of the involutions of $\mathfrak{so}(n)$ and the Einstein normalisation $\mathrm{Ric}=\tfrac12g$ under which $\theta=1/(2\lVert W\rVert)$, $W$ is the Weyl operator of $S^p\times S^q$ with $p+q=n$ and $p,q\ge5$; conversely every such split satisfies $\theta\ge\sqrt{3/2}$; and each is Morse–Bott nondegenerate with $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ on the orbit tangent alone, second eigenvalue at distance $\frac1{2(\max(p,q)-1)}$.* **The two clauses that must travel with it**: the hypothesis is pair-gradedness, and a $\Delta=0$ screen does not supply it where $\ker W\ne0$; and the sense is (C), so the lemma reaches no non-equivariant graded point, which is where the graded half is actually open.

## 9. What would break it, and what I did to look

**The object that would falsify the statement**: a critical point $W\in\mathcal W_n$, $n\ge12$, invariant under $\mathrm{ad}(\mathfrak p)$ for some $\mathbb Z_2$-grading of $\mathfrak{so}(n)$, with $\theta(W)\ge\sqrt{3/2}$, that is not the Weyl operator of a two-factor sphere product. Two routes to one: **(i)** a second independent direction in $(\mathcal W_n)^{\mathfrak p}$ at some grading, which would let one pair carry a second equivariant point, [r502](../reviews/REVIEW_r502.md) names exactly this as what a run at $n=12,13$ would decide, and its own derivation says the dimension is $1$; **(ii)** a $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ outside $\{\mathfrak{so}(p)\oplus\mathfrak{so}(q),\ \mathfrak u(n/2)\}$ at some $n\ge12$, which is precisely the unsourced classification.

**What I did.** I worked the enumeration by hand at $n=12$ and $n=13$ and found nothing outside the two families that the record itself does not already exclude; I evaluated every structured family the record names at its own parameters, exactly, and found the four $\mathbb{CP}^m$ decimals, $\mathbb{HP}^2$, the two Kähler families and both boundary margins all correct; I tested the two objects that sit at or above $\sqrt{3/2}$, padded $W_{\mathbb{CP}^2}$ and the $\theta=1.236031$ non-critical point, against every hypothesis, and each fails exactly one, checkably; and I verified that the dimension check excluding padded $W_{\mathbb{CP}^2}$ from every symmetric subalgebra of $\mathfrak{so}(12)$ is exhaustive, since only $\dim30$ and $\dim31$ fit inside $\dim\mathfrak k(W)=32$. **I found no falsifier. I also did not find, anywhere on this record, an argument or a source for the list route (ii) would have to escape.**

## Verdict

**HYPOTHESIS-DEBT.**

*What would have to be shown, exactly.* **That the $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ at $n\ge12$ are exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=n$ and, at even $n$, $\mathfrak u(n/2)$**, up to $O(n)$-conjugacy, which is the relation the argument consumes and which coincides with $\mathrm{Aut}(\mathfrak{so}(n))$-conjugacy exactly because $n\ne8$. On this record that statement has no proof and no readable source: [references/](../references/) holds no Cartan, Helgason, Berger or Besse entry, [conventions.md](../findings/conventions.md):34 records the appeal as bare, and [LEDGER.md](../findings/LEDGER.md):1284 records acquiring a source as blocked on the user rather than on a cycle. Everything L69 says downstream of that list is correct, and I checked all of it by hand.

*Three defects in the write-up, none of which changes a value.* **D1**, the non-strict hypothesis $\theta\ge\sqrt{3/2}$ is discharged only by $\mathbb{CP}^2$ having $n=4$, and that fact appears after the $\square$ in one form and nowhere in the other, the record's named trap, and [r501](../reviews/REVIEW_r501.md) filed the same thing as F4. **D4**, the identity $\theta=1/(2\lVert W\rVert)$ that gives $\tfrac16$ its meaning is used in both citable forms and stated in neither, [r501](../reviews/REVIEW_r501.md)'s F2, still unrepaired. **D3**, [Lemma L47](../findings/problem.md) is cited to [fence-posts.md](../findings/fence-posts.md), which contains no occurrence of it.

*And one thing the block gets right that is worth saying positively.* The repair replaced a value pinned by [Conjecture L8](../findings/graded-half.md)'s formula, which has an infinite pole family reaching $\theta^2=\frac{912}{575}$ at $(\mathfrak{so}(25),\mathfrak{so}(20)\oplus\mathfrak{so}(5))$, **inside L69's own range**, with a route through [L46](../findings/problem.md) and [L48](../findings/problem.md) that has no poles. I evaluated that pair by the new route and got $\frac{912}{575}$ exactly, so the two agree at the point where the old formula dies. That is the strongest evidence I found that the repair is the right one rather than merely a different one.
