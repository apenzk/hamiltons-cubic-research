# Verifier v76, L87's cap of $3570$, its mod-$p$ lower bound, and the three conclusions the squeeze is said to yield

**The brief was cold and worked from the definitions.** I did no numerical work: no script was run, no Sage session opened, nothing sampled. Every value below is an exact integer computed by hand from the block table in [sym3-blocks.md](../findings/sym3-blocks.md) and from the closed-form definition of $W_0$ that [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) carries in its own source, which I read as text. Log: [agent_logs/verify-L87-v76.log](../agent_logs/verify-L87-v76.log).

**One disclosure about the round's held-out question.** [ROUND_L87](ROUND_L87.md) records that a pre-registered question was withheld from the verifiers. It could not be withheld: the same objection is printed in the Gate 2 block four lines above the statement my brief quotes, in [sym3-blocks.md](../findings/sym3-blocks.md), which the brief names as the source. I met it there and in the script before I opened the round file, and I say so rather than claim independence I do not have.

## The claim table

| # | Claim, as the record states it | Verdict | Reason |
|---|---|---|---|
| C1 | the rank of $\langle g_aW_0,g_bW_0\rangle^3$ over $3700$ orbit points is $3570$ over $\mathbb F_{46337}$ | `CONFIRMED AS ALGEBRA` | the matrix is the right matrix and the arithmetic is exact with no tolerance anywhere; the value itself is a machine reading I neither recomputed nor may |
| C2 | $3570=\sum_\lambda d_\lambda$ over the $\lambda_2$-even blocks | `CONFIRMED` | sixteen blocks, summed by hand off [L83](../findings/sym3-blocks.md)'s table, exactly $3570$ |
| C3 | the cap follows *"using $\dim V_\lambda^H\le1$"* | `REFUTED AS STATED` | that clause alone caps at $5640$ over all $24$ blocks; the even-only restriction is [L86](../findings/sym3-blocks.md)'s $\dim V_\lambda^H=0$ at odd $\lambda_2$, uncited here |
| C4 | *"a mod-$p$ rank is a lower bound for the characteristic-zero span"* | `HYPOTHESIS-DEBT` | true of a matrix that reduces from a $p$-integral characteristic-zero matrix; the run's $g_a$ are drawn inside $\mathrm{GF}(46337)$ and no lift is anywhere on the record |
| C5 | *"the span is exactly $3570$"* | `HYPOTHESIS-DEBT` | inherits C4, as the record stands the two ends of the squeeze are ranks of two different objects |
| C6 | *"every one of the sixteen evaluation maps is nonzero"* | `CONFIRMED AS ALGEBRA` | forced by C5 together with C3's missing half; one of the sixteen has an independent closed-form witness, $\mathop{\mathrm{tr}}(W_0^3)=48\ne0$ |
| C7 | *"every even block loses exactly one multiplicity"* | `CONFIRMED AS ALGEBRA` | follows from C6 by an apolarity identification the block never states |
| C8 | *"174's 'measured' $3570$ is independently reproduced"* | `REFUTED AS STATED` | 174 **derived** the cap and cited a measurement already on the record; the first measurement is **170**'s, in floating point |
| C9 | [results.md:23](../results.md)'s *"a sampled mod-$p$ rank is a rigorous lower bound … so L87's rank and L62's value are proofs rather than measurements"* | `REFUTED AS STATED` | the sentence is true of [L62](../findings/sym3-blocks.md), whose points are rational and reduced, and is exactly the unwarranted step at L87 |
| C10 | the objects $W_0$ and $H$ that the statement quantifies over | `HYPOTHESIS-DEBT` | neither has a closed-form definition anywhere in [findings/](../findings/); the only definition of the $W_0$ actually measured sits in an unlinked reviewer script |

**One line.** Every number in L87 is exact and every stated inequality points the right way, but the paragraph joins a characteristic-$p$ measurement to a characteristic-zero cap across a step it does not take (a $p$-integral lift of the sampled group elements) and states the cap's ground as half of what the cap needs; the conclusion is very likely true and is not proved by the text on file.

## 0. Conventions, fixed once

Quoted from the brief rather than restated:

- $\mathcal W_5$: algebraic Weyl curvature operators at $n=5$, the $O(5)$-irreducible $[2,2]$, dimension $35$.
- $W_0$: the zero-padding into $\mathcal W_5$ of the $\mathbb{CP}^2$ Weyl operator; $g_aW_0$ are points of its $O(5)$-orbit.
- The blocks are the $O(5)$-constituents of $\mathrm{Sym}^3\mathcal W_5$; $\lambda_2$ is the second part of the highest weight; $d_\lambda$ is a constituent's dimension; $V_\lambda^H$ is the subspace fixed by the stabiliser $H$ of $W_0$.

Two readings the record admits, and the one I adopt in each case:

- **The weight-label basis.** [L83](../findings/sym3-blocks.md)'s table is in the $e$-basis and the prose above it is in the $\omega$-basis; its own Gate 2 note says so. I read every label in the $e$-basis, which is the basis in which the tabulated dimensions are correct, and in which $\lambda_2$ is the second part of a partition so that "even" is basis-independent for the parity rule.
- **The group.** The cap is stated over $O(5)$ and the run samples $SO(5)$ only. I read both as the same statement, on the ground the record itself gives: $-I$ acts trivially on $\mathcal W_5$ and $O(5)=SO(5)\times\{\pm I\}$ at odd $n$, so the two orbits of $W_0$ coincide. §5.4 checks this does not silently change $V_\lambda^H$.

## 1. The hypothesis inventory

**Carried by the statement, or by a result it imports, whether or not it is written down.** The last column says whether L87's own paragraph uses it and whether the paragraph states it.

| | Hypothesis | Checked against the object | Stated? Used? |
|---|---|---|---|
| H1 | $n=5$; $\mathcal W_5$ is the $O(5)$-irreducible $[2,2]$, $\dim 35$ | holds; fixed by [L83](../findings/sym3-blocks.md)'s Casimir separation of $[2,2]$ from $[2,1]$ | stated, used |
| H2 | $W_0\in\mathcal W_5$, nonzero, the padded $\mathbb{CP}^2$ operator | holds, verified in §5.2 that the script's $W_0$ satisfies first Bianchi and is Ricci-traceless, which the script never checks | **unstated as a definition**, used |
| H3 | $H=\mathrm{Stab}_{O(5)}(W_0)$: identity component $U(2)\subset SO(4)$, two components, times the padding-axis reflection | holds as [L86](../findings/sym3-blocks.md) derives it; the padding is what makes $H$ this large | **unstated in L87**, used |
| H4 | [L83](../findings/sym3-blocks.md)'s $24$-block table of $\mathrm{Sym}^3\mathcal W_5$ with its dimensions | holds; all sixteen even dimensions re-summed by hand in §2 | **uncited in L87**, used |
| H5 | $\dim V_\lambda^H\le1$ for every $\lambda$ | holds, by Frobenius reciprocity on the compact pair $(O(5),H)$ | stated, used |
| H6 | $\dim V_\lambda^H=0$ whenever $\lambda_2$ is odd, [L86](../findings/sym3-blocks.md)'s parity rule | holds; spot-checked in §5.5 against the two witnesses the record names | **unstated**, used, this is C3 |
| H7 | $O(5,\mathbb R)$ compact, so Peter–Weyl gives $\mathbb C[G/H]=\bigoplus V_\lambda\otimes(V_\lambda^*)^H$, and $H$ fixes $W_0^{\otimes3}$ | holds; every $O(5)$ representation here is self-dual, so $(V_\lambda^*)^H$ and $V_\lambda^H$ have the same dimension | **unstated**, used |
| H8 | characteristic zero, so $\mathrm{Sym}^3\mathcal W_5$ is semisimple and the isotypic decomposition the cap ranges over exists | holds of the char-zero object, and **fails at the object measured**: $p$ divides $\lvert SO(5,\mathbb F_p)\rvert=p^4(p^4-1)(p^2-1)$, so Maschke fails and no isotypic decomposition exists over $\mathbb F_p$ | **unstated**, used |
| H9 | each sampled $g_a\in O(5,\mathbb F_p)$ is the reduction of a $p$-integral $\tilde g_a\in O(5,\mathbb Q)$ | **not checked anywhere**, and false of the objects as constructed, they are built by `F.random_element()` inside $\mathrm{GF}(p)$ and no lift is ever formed | **unstated**, used, this is C4 |
| H10 | the invariant form on $\mathcal W_5$ is nondegenerate, so $\mathrm{Sym}^3\mathcal W_5\cong(\mathrm{Sym}^3\mathcal W_5)^*$ and "dimension of the Veronese span" converts to "codimension of the cubics vanishing on the orbit" | holds over $\mathbb R$, the Frobenius form being positive definite | **unstated**, used, it is the whole of C7 |
| H11 | $\langle x^{\otimes3},y^{\otimes3}\rangle=\langle x,y\rangle^3$ | holds; a polynomial identity over $\mathbb Z$, so valid in every characteristic | stated only in the script's comment, used |
| H12 | $46337$ is prime, so $\mathrm{GF}(46337)$ is a field and "rank" is defined | holds, verified by hand in §5.3 by trial division through $211$, past $\sqrt{46337}<216$ | **unstated**, used |
| H13 | the sample size exceeds the cap, $3700>3570$ | holds, with margin $130$ | stated, used |

**A hypothesis stated and never used: none.** Within L87's own paragraph every clause is load-bearing, the point count, the prime, the cap, the parity restriction and the two directions of the squeeze all carry weight. The defect is entirely on the other side of the ledger.

**Steps using a hypothesis nobody stated: six**, H2, H3, H6, H7, H9, H10. Two of them are ordinary compression of a standard argument (H7, H10). One is a definitional debt the record has already admitted in writing: [conventions.md:44](../findings/conventions.md) says of $W_0$ and $H$, "**Both were defined nowhere in [findings/](.)**", and adding a conventions row naming them has not supplied a definition of either. Two are imports of results that exist and are uncited (H4, H6). **One, H9, is not on the record at all in any form that could be cited**, and it is the hypothesis on which the whole warrant turns.

## 2. The cap, what it caps, and whether the stated ground reaches it

### 2.1 The number is exact

The $\lambda_2$-even blocks of [L83](../findings/sym3-blocks.md)'s table, with their dimensions, are

$$(4,2)_{220},\ (2,2)_{35},\ (3,2)_{105},\ (5,2)_{390},\ (4,4)_{165},\ (4,0)_{55},\ (3,0)_{30},\ (2,0)_{14},\ (6,6)_{455},\ (6,4)_{810},\ (6,2)_{625},\ (6,0)_{140},\ (5,4)_{429},\ (5,0)_{91},\ (1,0)_{5},\ (0,0)_{1},$$

sixteen of them, and the running sum is $220,255,360,750,915,970,1000,1014,1469,2279,2904,3044,3473,3564,3569,3570$. **The cap is $3570$ exactly, and the block count is $16$ exactly.** `CONFIRMED`.

The eight $\lambda_2$-odd blocks are $(4,3)_{231}$, $(4,1)_{154}$, $(3,1)_{81}$, $(2,1)_{35}$, $(6,3)_{770}$, $(5,3)_{455}$, $(5,1)_{260}$, $(3,3)_{84}$, summing to $2070$; $3570+2070=5640$, and $7770-3570=4200$, which is the figure [r170](../reviews/REVIEW_r170.md) and [r172](../reviews/REVIEW_r172.md) use for $\mathop{\mathrm{rank}}G\le4200$. Both totals reproduce.

### 2.2 What it is a cap on

**It caps $\dim_{\mathbb R}\mathop{\mathrm{span}}\{(gW_0)^{\otimes3}:g\in O(5,\mathbb R)\}$**, equivalently the dimension of the $O(5)$-submodule of $\mathrm{Sym}^3\mathcal W_5$ generated by $W_0^{\otimes3}$. Writing $S$ for that submodule and $r_\lambda$ for the multiplicity of $V_\lambda$ in $S$: because $H$ fixes $W_0$, it fixes $W_0^{\otimes3}$, so $S$ is a quotient of $\mathbb C[G/H]$ and $r_\lambda\le\dim V_\lambda^H$ by Frobenius reciprocity, the argument [r178](../reviews/REVIEW_r178.md) writes out in one sentence and the block compresses to a participial clause. Hence $\dim S=\sum_\lambda r_\lambda d_\lambda\le\sum_{\lambda:V_\lambda^H\ne0}d_\lambda$.

**It is a cap on nothing in characteristic $p$.** The derivation consumes the isotypic decomposition, which needs semisimplicity, which fails over $\mathbb F_p$ because $p\mid\lvert SO(5,\mathbb F_p)\rvert$. So the cap does not apply to the $\mathbb F_p$-span of the $O(5,\mathbb F_p)$-orbit, and the record says so itself, four lines above the statement.

### 2.3 The stated ground reaches half of it

*"Using $\dim V_\lambda^H\le1$"* gives $\dim S\le\sum_{\text{all }24}d_\lambda=5640$, at which the measured $3570$ is no squeeze at all. To land at $3570$ the argument needs $\dim V_\lambda^H=0$ for $\lambda_2$ odd, the other half of [L86](../findings/sym3-blocks.md)'s parity rule, which L87 does not cite. `REFUTED AS STATED`.

**Arguing the opposite.** The strongest reading of the sentence is that *"over the $\lambda_2$-even blocks"* already carries the parity rule's vanishing half, and the participle only names why each even block contributes its $d_\lambda$ once rather than $m_\lambda$ times. That reading is available and makes the sentence true but under-cited rather than wrong, and it is why this row is `REFUTED AS STATED` and not `REFUTED`: the number $3570$ is not in doubt, only the warrant printed beside it. Under either reading, **[L86](../findings/sym3-blocks.md) is a load-bearing, uncited hypothesis of L87**, which matters because L86's own index row carries a `GAP`, and a reader following L87's citations reaches nothing.

## 3. The squeeze, four inequalities, three of them present

| | Inequality | Relates | Direction | Consumed the right way round? |
|---|---|---|---|---|
| (i) | $\mathop{\mathrm{rank}}(\text{Gram of a set of vectors})\le\dim\mathop{\mathrm{span}}$ | a matrix rank to a span | the measurement **under**-reads, strictly so when the form is degenerate on the span | yes, used as a lower bound for the span |
| (ii) | $\dim\mathop{\mathrm{span}}\{3700\text{ sampled points}\}\le\dim\mathop{\mathrm{span}}\{\text{whole orbit}\}$ | a sample to the orbit | sampling **under**-reads | yes |
| (iii) | $\sum_\lambda r_\lambda d_\lambda\le\sum_{\lambda_2\text{ even}}d_\lambda$ | the span to the block table | the cap **over**-reads | yes, used as an upper bound |
| (iv) | $\mathop{\mathrm{rank}}_{\mathbb F_p}(\bar N)\le\mathop{\mathrm{rank}}_{\mathbb Q}(N)$ for $N$ $p$-integral reducing to $\bar N$ | characteristic $p$ to characteristic zero | reduction **under**-reads | **absent**, no $N$ is formed, so nothing is consumed |

**All three stated inequalities point the right way**, and I confirm the Gate 2 note that says so. The failure is (iv), which is the only one that could join (i)–(ii) to (iii).

**What object is each rank the rank of?** The lower end is $\mathop{\mathrm{rank}}_{\mathbb F_{46337}}$ of the Gram of $3700$ vectors $W_a^{\otimes3}$ in $\mathrm{Sym}^3(\mathcal W_5\otimes\mathbb F_p)$, built from elements of $SO(5,\mathbb F_p)$. The upper end is a dimension of a real $O(5,\mathbb R)$-submodule of $\mathrm{Sym}^3\mathcal W_5$. **These are ranks of two different objects, and the sentence that is supposed to identify them ("a mod-$p$ rank is a lower bound for the characteristic-zero span"), is the assertion in question, not an argument for it.** As a universal statement it is false: a rank over $\mathbb F_p$ bounds a characteristic-zero rank only through a $p$-integral matrix reducing to it, and here the matrix over $\mathbb Q$ is never named, let alone formed.

### The discrepancy, cleared three ways

1. **Located.** [findings/sym3-blocks.md:140](../findings/sym3-blocks.md), the sentence *"A mod-$p$ rank is a lower bound for the characteristic-zero span."* The hypothesis it needs and lacks is H9 of §1.
2. **The failure exhibited concretely.** In [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage) the sampled group elements are $g=(I-A)(I+A)^{-1}$ with $A_{ij}=$ `F.random_element()`, $F=\mathrm{GF}(46337)$, the entries are residues, chosen in $\mathbb F_p$, and the only characteristic-zero object in the file is $W_0$ itself. There is therefore no matrix over $\mathbb Q$ of which the computed Gram is a reduction, and the inequality quoted has no left- and right-hand side belonging to one object. The concrete parameter at which the step breaks is not a special one: it breaks at **every** $a$, because no $\tilde g_a$ exists on the record.
3. **Arguing the opposite.** The strongest reading is that the author had the lift in mind: $\det(I+\tilde A)\ge1$ for real skew $\tilde A$, so an integer lift $\tilde A$ of $A$ gives $\tilde g=(I-\tilde A)(I+\tilde A)^{-1}\in O(5,\mathbb Q)$ that is $p$-integral and reduces to $g$, and the squeeze then closes on one object. **The record names exactly this repair, in half a sentence, in the Gate 2 note above the statement, and supplies it nowhere.** Per this round's rule I do not supply it either: writing that argument out would hand the record fresh mathematics under the letterhead of a check. **The finding is that the claim has no argument on file.** `HYPOTHESIS-DEBT`, and what would have to be proved is precisely: *for each of the $3700$ sampled $g_a\in SO(5,\mathbb F_{46337})$ there is a $p$-integral $\tilde g_a\in O(5,\mathbb Q)$ with $\tilde g_a\bmod p=g_a$, and $W_0$ is $p$-integral, so that the computed matrix is the reduction of the Gram of $\{(\tilde g_aW_0)^{\otimes3}\}$.*

**An observation in the statement's favour, which the record does not claim.** The coincidence is self-protecting against a mis-stated $H$. An overstated $H$ shrinks the cap below the true span, and the measured rank would then have **exceeded** the cap, a visible failure, not a silent pass. An understated $H$ inflates the cap (to $5640$ at the limit) and the squeeze visibly fails to close. That the reading lands on $3570$ on the nose is therefore genuine evidence about $H$ and about the sixteen even dimensions. It is **not** evidence about the multiplicity column: $3570$ is multiplicity-independent, as [L86](../findings/sym3-blocks.md)'s own Gate 2 note establishes by the dimension-$35$ swap.

## 4. The three conclusions

**(a) "The span is exactly $3570$."** Follows from (i)+(ii)+(iii)+(iv). Inherits the whole of §3: `HYPOTHESIS-DEBT`.

**(b) "Every one of the sixteen evaluation maps is nonzero."** Given (a), this is forced and the forcing is correct: $\sum_\lambda r_\lambda d_\lambda=3570=\sum_{\lambda_2\text{ even}}d_\lambda$ with $0\le r_\lambda\le1$ on the even blocks and $r_\lambda=0$ on the odd ones leaves no slack, so $r_\lambda=1$ sixteen times. **Note that the forcing consumes the odd-block vanishing a second time**, with $r_\lambda$ merely $\le1$ on all $24$ blocks the equation $\sum r_\lambda d_\lambda=3570$ has many solutions, and [r174](../reviews/REVIEW_r174.md) counted $3\,392\,286$ of them under the weaker constraint $0\le r_\lambda\le m_\lambda$. So H6 is load-bearing twice over. `CONFIRMED AS ALGEBRA`.

**One of the sixteen has a witness independent of any measurement.** On the trivial block $(0,0)$, $m=1$, the degree-three covariant is $\mathop{\mathrm{tr}}(W^3)$ up to scale, and at the script's $W_0$, eigenvalues $4,-2,-2$ on the self-dual forms and $0$ on the other seven directions of $\Lambda^2\mathbb R^5$, $\mathop{\mathrm{tr}}(W_0^3)=64-8-8=48\ne0$. So $r_{(0,0)}=1$ in closed form, and the trivial block dies unconditionally. This is the same fact [r170](../reviews/REVIEW_r170.md) and [r172](../reviews/REVIEW_r172.md) use, stated there as $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6$ under their normalisation. **The other fifteen have no closed-form witness anywhere on the record.**

**(c) "Every even block loses exactly one multiplicity."** This is a statement about the *cubics*, not about the span: the multiplicity of $V_\lambda$ in $K=\{f\in\mathrm{Sym}^3\mathcal W_5^*:f\vert_{O(5)\cdot W_0}=0\}$ is $m_\lambda-r_\lambda$. Getting from (b) to (c) needs the apolarity identification $f(W)=\langle f,W^{\otimes3}\rangle$ up to a nonzero constant, so that $K$ is the annihilator of $S$ and $\mathop{\mathrm{codim}}K=\dim S$, H10, nondegeneracy of the invariant form, never stated in the block. The identification is standard and true over $\mathbb R$, and the step is correct once it is written down. `CONFIRMED AS ALGEBRA`, on (b) plus an unstated hypothesis.

**Scope worth naming, since the block does not.** (c) is exact for the constraint "vanish on the orbit of $W_0$". The certificate's true zero set may be larger, so the derived $25$ surviving multiplicities and $36$ unknowns are an **upper** bound on what a certificate actually has free. [r170](../reviews/REVIEW_r170.md) flags this ("the true zero set may be larger … $4200$ is an upper bound … that can only fall"); L87 states $25$ and $36$ flatly as "proved". The direction is safe for the record's use of them and the label is not.

## 5. What the measurement is a measurement of

Read as text from [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage), which is the only file computing this quantity exactly and which the L87 block does not link.

### 5.1 The matrix, its rows, its columns, its ring

- **Ring.** $F=\mathrm{GF}(46337)$ throughout. There is no floating point and no tolerance in the file; `K.rank()` is exact row reduction over a finite field. **The exactness is the run's real contribution, and neither the script nor the block claims it.**
- **The intermediate matrix $M$** is $3700\times100$: row $a$ is the flattened $10\times10$ symmetric matrix $W_a=\Lambda^2(g_a)\,W_0\,\Lambda^2(g_a)^{\mathsf T}$, an operator on $\Lambda^2\mathbb F_p^5$. Both $(i,j)$ and $(j,i)$ entries appear, so the flattening double-counts off-diagonals, which is exactly what makes the next step the Frobenius form.
- **The Gram.** $K=MM^{\mathsf T}$ has $K_{ab}=\sum_{i,j}(W_a)_{ij}(W_b)_{ij}=\mathop{\mathrm{tr}}(W_aW_b)$, the Frobenius pairing on curvature operators. The script then replaces every entry by its cube, so the final matrix is $3700\times3700$ with entries $\langle W_a,W_b\rangle^3\in\mathbb F_p$, **rows and columns both indexed by the $3700$ sampled orbit points**. By H11 this is the Gram of the $W_a^{\otimes3}$ under the induced form, so its rank is a lower bound for $\dim\mathop{\mathrm{span}}_{\mathbb F_p}\{W_a^{\otimes3}\}$. That is the whole of what was measured.
- **Normalisation is irrelevant here.** Rescaling $W_0$ scales $K^{\circ3}$ by a nonzero constant and leaves the rank alone, so the record's several normalisations of $W_0$ ($\lVert W_0\rVert=1$ at [r203](../scripts/reviewers/r203/orbit_cubic_span.py), unnormalised here) do not collide on this claim.

### 5.2 How the objects were constructed, and the one check the script omits

$W_0=2w_1w_1^{\mathsf T}-w_2w_2^{\mathsf T}-w_3w_3^{\mathsf T}$ on $\Lambda^2\mathbb F_p^5$ with $w_1=e_{01}+e_{23}$, $w_2=e_{02}-e_{13}$, $w_3=e_{03}+e_{12}$, the three self-dual two-forms of the $\mathbb R^4$ spanned by coordinates $0,1,2,3$, with coordinate $4$ the padding axis. Since $\lVert w_k\rVert^2=2$, the eigenvalues are $4,-2,-2$ on $\mathop{\mathrm{span}}\{w_1,w_2,w_3\}$ and $0$ on the remaining seven dimensions: the anti-self-dual three-space and the four bivectors touching the padding axis. The script checks symmetry, trace and the two eigen-relations. **It checks neither the first Bianchi identity nor Ricci-tracelessness, so it never verifies that the object it orbits lies in $\mathcal W_5$.** I checked both by hand from the same formula:

- **First Bianchi.** The $\Lambda^4$ component of an operator on $\Lambda^2\mathbb R^4$ is its pairing with the Hodge star, which is $+1$ on the self-dual three-space and $-1$ on the anti-self-dual one. $W_0$ vanishes on the anti-self-dual part, so the pairing is the trace on the self-dual part, $4-2-2=0$. Holds.
- **Ricci.** $\mathrm{Ric}_{ij}=\sum_kW_0\big[(i,k),(j,k)\big]$. Diagonal: $\mathrm{Ric}_{00}=W_0[(01),(01)]+W_0[(02),(02)]+W_0[(03),(03)]+W_0[(04),(04)]=2-1-1+0=0$. Off-diagonal: $\mathrm{Ric}_{01}=W_0[(02),(12)]+W_0[(03),(13)]+W_0[(04),(14)]=0-1\cdot0-0\cdot1\;+\;0-1\cdot0-1\cdot0\;+\;0=0$. Every $\mathrm{Ric}_{i4}$ and $\mathrm{Ric}_{44}$ vanish because every row of $W_0$ indexed by a pair containing $4$ is zero. Holds.

So the object is a genuine padded Weyl operator of $\mathbb{CP}^2$ type, spectrum $(2,-1,-1)$ up to scale on the self-dual part. **The check is absent from the run and the conclusion is unaffected.**

### 5.3 The prime, and two arithmetic facts nobody records

$46337$ is prime: it is odd, has digit sum $23$, does not end in $0$ or $5$, and leaves a nonzero remainder under every prime through $211$, I ran the division by hand, and $216^2=46656>46337$ closes the range. Two consequences the record does not state and that a reader should want:

- $\langle W_0,W_0\rangle=\mathop{\mathrm{tr}}(W_0^2)=16+4+4=24$, so every diagonal entry of the final matrix is $24^3=13824\ne0$ in $\mathbb F_{46337}$. **The form is not identically isotropic on the sample**, which it could have been at a badly chosen $p$.
- $46336=2^8\cdot181$, so $3\nmid p-1$ and $x\mapsto x^3$ is a **bijection** on $\mathbb F_p$. No entry of the Gram is collapsed by the cubing step.

### 5.4 Which group was sampled

$g=(I-A)(I+A)^{-1}$ for skew $A$ has $\det(I-A)=\det((I-A)^{\mathsf T})=\det(I+A)$, so $\det g=1$ and **the sample lies in $SO(5,\mathbb F_p)$**, never in the other component; the Cayley parametrisation also misses every $g$ with eigenvalue $-1$. The script's own header says $SO(5)$; the L87 statement says "orbit points" without saying which orbit. Neither matters: $-I$ acts trivially on $\mathcal W_5$ and $O(5)=SO(5)\times\{\pm I\}$ at $n=5$, so the two orbits coincide, and a lower bound needs no surjectivity of the sample in any case. Symmetrically for the cap: $\varepsilon=\mathrm{diag}(1,1,1,1,-1)$ equals $(-I)\cdot\mathrm{diag}(-1,-1,-1,-1,1)$ with the second factor in $H\cap SO(5)$, so $V_\lambda^{H\cap SO(5)}=V_\lambda^H$ and the cap is the same for either group.

### 5.5 The parity rule, spot-checked on the record's own witnesses

L87 imports H6 without citing it; I checked its mechanism rather than re-proving it. Under $\mathfrak{so}(4)=\mathfrak{su}(2)_L\oplus\mathfrak{su}(2)_R$ the subgroup $U(2)$ is $SU(2)_L$ times the maximal torus of the right factor, so $U(2)$-invariants of a constituent $(j_L,j_R)$ are the $j_L=0$, $m_R=0$ line; the extra component is the right Weyl element, acting on that line by $(-1)^{j_R}$. Both witnesses the record names behave: $V_{(1,0)}=\mathbb R^5=\mathbb R^4\oplus\mathbb R$ has the invariant $e_5$ and $\lambda_2=0$; $V_{(1,1)}=\Lambda^2\mathbb R^5$ has the Kähler form as its only $U(2)$-invariant, the Weyl element reverses the complex structure, and $\lambda_2=1$ gives $0$. Consistent.

## 6. Attribution and provenance

**The record's account does not match the files.**

| what the block says | what `git` and [reviews/](../reviews/) show |
|---|---|
| *"174's 'measured' $3570$ is independently reproduced"* | [REVIEW_r174.md:14](../reviews/REVIEW_r174.md) says its own contribution "**derives** the record's measured span rather than reproducing it", and §2.3 there writes the sixteen dimensions out and sums them. **174 derived the cap; 174 measured nothing.** |
| the measurement is 174's | the first measurement is **170**'s, entering the record at commit `55818bae`, Fri 28 Aug 09:51: [REVIEW_r170.md:72](../reviews/REVIEW_r170.md), $5200$ random orbit points, floating point, rank stable at $10^{-8}$, $10^{-10}$, $10^{-12}$. 174 then cites "the record's measured span of $3570$", 170's. |
| *"independently reproduced"* | [REVIEW_r178.md:103](../reviews/REVIEW_r178.md) says its run "**also reproduces 174's measured $3570$**", i.e. 178 knew the target number before starting. The independence claimed is of the *construction of $W_0$*, which is genuine, and not of the value. |
| the rank is *"proved rather than measured"* (commit `a1028174`, "the rank-one step is proved") | it is one exact rank over one prime, with the char-zero corroborations, [r173](../scripts/reviewers/r173/r173_orbit_span.py) at $4800$ points and [r203](../scripts/reviewers/r203/orbit_cubic_span.py), both in floating point, and r203's own docstring calling itself a **screen**. |
|, | the two commits `9999706c` (12:42:39) and `a1028174` (12:44:20) are **101 seconds apart**, confirming the Gate 2 note: the objection and its answer were written in the same sitting, and the superseded account under [L86](../findings/sym3-blocks.md) was left standing. |
|, | **the block carries no links at all**, so for a claim whose lower bound *is* a machine run, the run is unreachable from the record. I found it by grepping the prime. |

## 7. The gap between what is proven and what is used

**Cited stronger than its proof reaches: once, and it is the record's summary line.** [results.md:23](../results.md) reads *"A sampled mod-$p$ rank is a rigorous lower bound, and under an exact cap a lower bound is all that is needed, so [L87](../findings/sym3-blocks.md)'s rank and [L62](../findings/sym3-blocks.md)'s value are proofs rather than measurements."* The sentence is sound for [L62](../findings/sym3-blocks.md), whose points are rational and reduced, the record's own account of the two is that L62 "is drawn over $\mathbb Q$ and reduced". Applied to L87 it asserts precisely H9, the step nobody has taken, and it asserts it as a general principle so that the difference between the two lemmas disappears. **This is the only statement of L87 outside [sym3-blocks.md](../findings/sym3-blocks.md), and it states the lemma at more than the lemma's strength.** That [results.md](../results.md) carries no statement of L87 at all is what allows this: there is no canonical form for the summary to be checked against.

**Cited at the right strength elsewhere.** [L88](../findings/sym3-blocks.md) transports $47=36+11$ "through [L86](../findings/sym3-blocks.md)'s parity rule and L87's rank-one step", naming the dependency. [L84](../findings/sym3-blocks.md)'s Gate 2 note says L87 "kills two of the three collisions", which is L87's own conclusion (c). [findings/INDEX-results.md:102](../findings/INDEX-results.md) carries the `GAP` verdict and both reviewer findings faithfully, including the $5640$ and the $\mathrm{GF}(46337)$ point, **the index is more honest than the lemma it indexes**, and the lemma text has not been repaired.

**One downstream use inherits the debt silently.** [report/sections/07-gradedness-split.tex:910](../report/sections/07-gradedness-split.tex) states that the catalecticant of $A(W_0^6)$ is "of rank $3570$", flatly. That rank equals $\mathop{\mathrm{codim}}K$ because the catalecticant is a real average of positive semidefinite rank-one forms, whose kernel is therefore exactly $K$, so the assertion is correct given L87 and is stated in the report with no hedge and no citation.

## 8. Withdrawn candidates

Each of these looked like a discrepancy and fails one of the three tests.

- **"The cap should be taken over $H\cap SO(5)$, since only $SO(5)$ was sampled."** Withdrawn at step 2: $\varepsilon=(-I)\cdot\mathrm{diag}(-1,-1,-1,-1,1)$ with $-I$ acting trivially and the second factor inside $SO(5)$, so the two invariant subspaces have the same dimension and no block moves. The record states this and it is right.
- **"The script never verifies $W_0\in\mathcal W_5$, so it may be orbiting the wrong object."** Withdrawn at step 2: I verified first Bianchi and Ricci-tracelessness by hand in §5.2. The check is genuinely missing from the run and the object is genuinely correct, so there is nothing to report but the omission.
- **"The Gram may be degenerate over $\mathbb F_p$, so the rank under-reads and the coincidence is luck."** Withdrawn at step 3: degeneracy can only *lower* the reading, which is the safe direction, and the reading landed at the cap. §5.3 also shows the diagonal is $13824\ne0$, so the form is not identically isotropic on the sample.
- **"Only $3700$ points were taken, so the rank is capped by the sample."** Withdrawn at step 2: $3700>3570$ with margin $130$, and a sample cap works in the safe direction regardless.
- **"The Cayley map misses the elements of $SO(5,\mathbb F_p)$ with eigenvalue $-1$, so the orbit is under-sampled."** Withdrawn at step 3: a lower bound requires no surjectivity of the sample. The omission would matter only for an upper bound, which the run does not claim.
- **"The trap $\ker W\ne0$ bites, since $W_0$ has a seven-dimensional kernel on $\Lambda^2\mathbb R^5$."** Withdrawn at step 2: no step of L87 or of the cap derivation refers to $\ker W_0$. Both use only that $H$ fixes $W_0$, and the padding acts here in the *helpful* direction, it is what makes $H$ large and the cap small. The named instance of this trap, [W4](../findings/INDEX-traps.md), is about the gradedness screen and does not reach this argument.
- **"The boundary case: an even block of the smallest dimension, $(0,0)_1$, might fail."** Withdrawn at step 2: it is the one block with a closed-form witness, $\mathop{\mathrm{tr}}(W_0^3)=48\ne0$, and it passes.

## 9. Verdict on the result as a whole

**`HYPOTHESIS-DEBT`, with two separable defects, neither of them arithmetic.**

- **Every number is exact.** The cap $3570$, the sixteen even blocks, the residual $2070$ and $5640$, the $4200$, the sample margin, all re-derived here by hand off [L83](../findings/sym3-blocks.md)'s table. All three stated inequalities point the right way. The three conclusions follow from one another correctly.
- **The warrant does not join its two ends.** The measured rank is taken in $\mathbb F_{46337}$ of a matrix built from elements of $SO(5,\mathbb F_p)$; the cap is a dimension of a real $O(5,\mathbb R)$-module. The step between them (a $p$-integral lift of the sampled group elements), is named in half a sentence in the block's own Gate 2 note and written nowhere. **Until it is written, "the span is exactly $3570$" has no argument on file.**
- **The cap's stated ground is half of the cap's ground.** The even-block restriction is [L86](../findings/sym3-blocks.md)'s and is uncited; on the participle alone the bound is $5640$ and nothing closes.
- **The attribution is wrong in a way that hides the evidence's real shape.** The exact link is one prime, one run, one code path; the two characteristic-zero corroborations are floating point and one of them calls itself a screen; and the number the block credits to 174 as a measurement is 174's *derivation* of a measurement made earlier by 170.
- **What I would ask for before this row moves.** A canonical statement of L87 in [results.md](../results.md); the lift written out, or the claim restated as what the run establishes; a citation to [L86](../findings/sym3-blocks.md) beside the word "even"; a link to [orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage); and definitions of $W_0$ and $H$ in [findings/](../findings/), which [conventions.md:44](../findings/conventions.md) already records as missing.

## 10. The falsifier

**The object that would falsify the statement is a highest-weight vector of some $\lambda_2$-even block $V_\lambda\subset\mathrm{Sym}^3\mathcal W_5^*$ which, read as a cubic polynomial, vanishes identically on the $O(5)$-orbit of $W_0$.** One such block would make $r_\lambda=0$, drop the characteristic-zero span to at most $3570-d_\lambda$, break the equality, and leave that block's multiplicity intact, with it, the eight block deaths and the two Casimir collisions that the record says vanish with them.

What I did to look for one, working only in closed form:

- **Tested the one block where the covariant is known explicitly.** On $(0,0)$ the covariant is $\mathop{\mathrm{tr}}(W^3)$ and $\mathop{\mathrm{tr}}(W_0^3)=4^3+(-2)^3+(-2)^3=48\ne0$. Not the falsifier, and the only one of the sixteen settled without a machine.
- **Tested the two structured witnesses the record names for the parity rule** ($(1,0)$ with invariant $e_5$, $(1,1)$ with the Kähler form reversed by the Weyl element) since a block wrongly classed even would inflate the cap and make the coincidence spurious. Both behave as §5.5 requires.
- **Re-derived the classification of all $24$ blocks by the parity of $\lambda_2$ and re-summed both halves**, $3570$ and $2070$ against the table's $7770$. No block is misclassified and no dimension is mistranscribed, so a falsifier cannot be hiding in the arithmetic.
- **Checked the direction in which a mis-stated $H$ would show.** Too large an $H$ makes the measured rank exceed the cap; too small an $H$ leaves the squeeze open. Neither happened, so $H$ is not the place a falsifier lives either.

**Where a falsifier could still be, and what it would take.** The remaining fifteen evaluation maps rest entirely on the one $\mathbb F_p$ rank plus two floating-point screens. Exhibiting a vanishing one (or ruling it out block by block), needs the $41$ highest-weight vectors, which the record has built, evaluated at a handful of points $g\cdot W_0$. **That is exactly the check [L86](../findings/sym3-blocks.md) names as the one that would remove the dependency, and it has never been run**; the block instead substituted a second measurement, which is the one this round is auditing. I did not run it and did not ask to: it is computation, and my brief carries no approval for any.
