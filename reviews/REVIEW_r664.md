# Review r664, Lemma L83, the 24-block table and its four closures

**Reviewer B of a pair on identical briefs. Review number 664.** Target: [findings/sym3-blocks.md:15](../findings/sym3-blocks.md#L15) (the heading) with the passage it labels, [The 24 blocks](../findings/sym3-blocks.md#L17), lines 17–30.

**Analysis only. No decomposition, sweep or search was run.** Every dimension, Casimir value and sum below I derived by hand from the Weyl formula before touching a machine; a single Weyl-dimension-and-sum evaluation was then run as a screen on objects I typed in myself, and it agreed in every entry. [b2_characters.py](../scripts/reviewers/r205/b2_characters.py) (the one script on the record that would *derive* the multiplicity column rather than import it), I did **not** run: a plethysm is a decomposition, not a screen. §6 says what running it would decide.

## Verdict

**GAP.** Every number in the table is **correct** and every one of them is re-derivable by hand, I checked all $24$ dimensions, the Casimir formula against $B_2$'s own $\rho$, and all five totals ($24$, $41$, $65$, $7770$, $4125$) cold. **The table is right. The two sentences it is stated with are not.**

| # | claim | verdict |
| --- | --- | --- |
| 1 | the dimension column is the $B_2$ Weyl formula, a product of four linear factors | **confirmed**, derived in §1; every one of the $24$ entries reproduces |
| 2 | $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ | **confirmed**, and it is $\langle\lambda,\lambda+2\rho\rangle$ at $B_2$'s $\rho=(3/2,1/2)$ in the normalisation this file fixes, no doubled convention here (§2) |
| 3 | "The table is arithmetic on the highest weights" | **refuted as stated**. The two computed columns are arithmetic; the *table* (which weights, with what multiplicities), is not, and cannot be (§3) |
| 4 | "No linear algebra on the $7770$ is involved" | **misleading**. True of the cited script, which imports the answer; the table's content was established on the record by four reviewers who each did exactly that linear algebra (§3, §6) |
| 5 | "closes four independent ways" | **refuted**. There is **one** closure against an independently known quantity. The other three are three moments of a single imported column (§4) |
| 6 | scope | **an $n=5$ statement**, and the file's own next line says why it does not lift (§5) |

**How many independent ways are there really? One.** $\sum m_\lambda d_\lambda=7770$ is checked against $\binom{37}3$, a number known without the table. $24$, $41$ and $65$ are $\sum_\lambda 1$, $\sum_\lambda m_\lambda$ and $\sum_\lambda\binom{m_\lambda+1}2$ of the same imported multiset $\{4,4,3,2^{\times9},1^{\times12}\}$; a reader computing them is checking the summary line against the table, never the table against anything.

**The sharpest way to see it.** The table contains two blocks of dimension $35$, $(2,2)$ at multiplicity $4$ and $(2,1)$ at multiplicity $2$. **Exchange those two multiplicities and all four reported numbers are unchanged**: $24$ rows still, $\sum m=41$ still, $\sum m d$ still $7770$, and $\binom52+\binom32=10+3$ is symmetric in the two, so $65$ still. The four closures are jointly blind to it. **And that is precisely the confusion the file warns about eight lines above the table**, "A dimension check cannot separate this from $\omega_1+2\omega_2=[2,1]$, which also has dimension $35$" ([findings/sym3-blocks.md:7](../findings/sym3-blocks.md#L7)). The block names the trap and then adopts four checks none of which can see it.

## 1. The Weyl dimension formula for $B_2$, derived

$B_2=\mathfrak{so}(5)$ in the orthogonal coordinates $e_1,e_2$: positive roots $e_1-e_2$, $e_1+e_2$, $e_1$, $e_2$, half-sum $\rho=(3/2,1/2)$. With $\ell=\lambda+\rho$,

$$\dim V_\lambda=\prod_{\alpha>0}\frac{\langle\ell,\alpha\rangle}{\langle\rho,\alpha\rangle}=\frac{(\ell_1-\ell_2)(\ell_1+\ell_2)\,\ell_1\,\ell_2}{1\cdot2\cdot\tfrac32\cdot\tfrac12}=\tfrac23\,\ell_1\ell_2(\ell_1^2-\ell_2^2),$$

which in $\lambda$ clears to

$$\dim V_{(\lambda_1,\lambda_2)}=\tfrac16(2\lambda_1+3)(2\lambda_2+1)(\lambda_1-\lambda_2+1)(\lambda_1+\lambda_2+2).$$

**Four linear factors, as claimed**, and the claim is exactly right, since the $\rho$-denominator is the constant $6$ and nothing else survives. Anchors: $(0,0)\mapsto1$, $(1,0)\mapsto5$, $(2,2)\mapsto35$, $(1,1)\mapsto10$ (the adjoint). **All $24$ table entries reproduce**, by hand and again under the screen; the two coincidences in the column are real, $(2,2)$ and $(2,1)$ both $35$, $(6,6)$ and $(5,3)$ both $455$.

**The labels are in the $e$-basis, and the block never says so.** Read $(4,2)$ as $4\omega_1+2\omega_2$ instead, which is how the prose eleven lines above writes weights, "$[2,2]=2e_1+2e_2$ solves to $4\omega_2$", and it means $(5,1)$, of dimension $260$, not $220$. The file uses both bases within eight lines, [conventions.md](../findings/conventions.md) fixes no $B_2$ weight-label basis, and **the table is unreadable to a cold reader until one is fixed**. The prose itself is correct: $\omega_1=e_1$, $\omega_2=(e_1+e_2)/2$, so $2e_1+2e_2=4\omega_2$ and $\omega_1+2\omega_2=(2,1)$, of dimension $35$ and Casimir $12$ against $16$, all four of those numbers check.

## 2. The Casimir, and its normalisation

$$c_2(\lambda)=\langle\lambda,\lambda+2\rho\rangle=\lambda_1^2+\lambda_2^2+2\left(\tfrac32\lambda_1+\tfrac12\lambda_2\right)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1).$$

**Confirmed, with $B_2$'s own $\rho=(3/2,1/2)$ and the $e_i$ orthonormal.** This is the $\mathfrak{so}(n)$ specialisation $c_2(\lambda)=\sum_i\lambda_i(\lambda_i+n-2i)$ at $n=5$.

**The normalisation matches the one this file fixes, and I checked it rather than assuming it.** The brief warns that a companion audit found a constant taken from a table in a doubled convention; there is no such defect here. Under [findings/sym3-blocks.md:13](../findings/sym3-blocks.md#L13)'s $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$ the set $\{E_{ij}-E_{ji}\}$ is orthonormal and self-dual, so $C=-\sum_a\rho(A_a)^2$ is computed with no dual-basis factor. On the vector representation $(E_{ij}-E_{ji})^2=-E_{ii}-E_{jj}$, so $C=\sum_{i<j}(E_{ii}+E_{jj})=(n-1)\mathrm{Id}=4\,\mathrm{Id}$ at $n=5$, and $c_2(1,0)=1\cdot4=4$. **The two agree exactly**, so the formula and the file's normalisation are the same convention. The adjoint gives the second anchor: $c_2(1,1)=4+2=6=2(n-2)$, and $B_K=(n-2)\operatorname{tr}=-2(n-2)B=-6B$ turns that into the Killing value $16/6=8/3$ quoted in the same line. **Consistent throughout, and the file's sign discussion is right**: without the minus in $C=-\sum\rho(A_a)^2$ every value here is negative.

**A by-product, since it depends on nothing but §1–§2.** The $24$ Casimir values are $0,4,10,12,16,18,20,24,28,30,30,34,40,40,42,46,48,52,54,60,60,66,74,96$, **$21$ distinct, with exactly the three collisions [L84](../findings/sym3-blocks.md#L32) names**, $(4,1)$ with $(3,3)$ at $30$, $(4,3)$ with $(5,0)$ at $40$, $(5,4)$ with $(6,2)$ at $60$. L84's $21$ is confirmed here as a free consequence, and it doubly confirms that the labels are $e$-basis: under the $\omega$-reading the collisions do not occur.

## 3. Is the table arithmetic? No, and it cannot be

**Arithmetic on the highest weights gives you two columns and not the table.** Given a weight you get its dimension (§1) and its Casimir (§2) by closed-form arithmetic. **What no arithmetic on highest weights gives is which weights occur and how often**, that is the plethysm $\mathrm{Sym}^3(V_{(2,2)})$, a symmetric-function computation on characters, and it is the entire content of the table. The dimension and multiplicity columns are outputs of the decomposition; the highest weights are its output too. There is nothing left for the arithmetic to have produced.

**The cited script says so itself.** [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) opens "Derivation, checked here rather than established here", hardcodes `NAMED` with the comment "**multiplicities as recorded**", and hardcodes `SPECTRUM` (the Casimir multiset of the very blocks in question) then "solves" the twelve multiplicity-$1$ weights by matching $c_2$ against that hardcoded spectrum, under an unjustified search bound $\lambda_1\le6$. **That is a consistency check on imported data, not a derivation**, and the script's docstring is more honest than the findings block that cites it.

**"No linear algebra on the $7770$ is involved" is true of the script and false of the record.** The table's content was established, and independently confirmed four times, by exactly that linear algebra:

- [r174](REVIEW_r174.md#L117), Sage's `symmetric_power`, **and** a second route that "calls no plethysm": forming the $7770$ weight triples of the $35$ weights and peeling highest weights against Freudenthal multiplicities. That is literally a computation on the $7770$;
- [r170](REVIEW_r170.md#L26), the same symmetric power, "every figure matches";
- [r177](REVIEW_r177.md) and [r178](REVIEW_r178.md), both "recomputed $\mathrm{Sym}^3(\mathcal W_5)$ from scratch", per [reviews/INDEX.md:410](INDEX.md#L410);
- and the file's own [The 41 highest-weight vectors](../findings/sym3-blocks.md#L50) describes a run that splits $\mathrm{Sym}^3$ into weight spaces and takes kernels of raising operators, "every block matching the table", at a largest weight space of $234$.

**So the table is well supported and the sentence describing its support is wrong.** The honest statement is: *the multiplicity column is imported from a plethysm and confirmed four times on the record; given it, the dimension and Casimir columns follow by closed-form arithmetic.* That sentence costs the block nothing and is true.

**One genuine consequence of the claim as written.** Because the block presents the table as self-derived, it **cites no reviewer for it**, and [findings/INDEX-results.md:98](../findings/INDEX-results.md#L98) accordingly reads "Gate 2: no verdict on the record". The strongest evidence the record holds for L83 sits in four review files that L83 does not point at.

## 4. "Four independent ways", what each closure consumes

| closure | value | what it consumes | independent? |
| --- | --- | --- | --- |
| block count | $24$ | the row list alone | **no**, it is the length of the printed list, a tautology given the table |
| total dimension | $\sum m_\lambda d_\lambda=7770$ | the row list, the multiplicity column, **and** the Weyl formula (checked against $\binom{37}3=\binom{35+2}3$, known without the table | **yes**), the one real closure |
| multiplicity sum | $41$ | the multiplicity column alone | **no**, first moment of the same column |
| unknown count | $65$ | the multiplicity column alone, via $\sum\binom{m+1}2$ | **no**, second moment of the same column |

**Three of the four are functions of one input.** Knowing the multiset $\{m_\lambda\}$ determines $24$, $41$ and $65$ outright; they are $\sum m^0$, $\sum m^1$ and $\tfrac12\sum(m^2+m)$. They confirm one another the way $\bar x$ and $\sum x_i$ confirm one another.

**Do the four detect a single transcription error?** *Jointly, in the printed table, yes*, and the work is done almost entirely by the $7770$. Mistype one dimension and only $7770$ notices; mistype one multiplicity and $41$, $65$ and $7770$ all move; drop a row and all four move. **But that is error-detection on the transcription, not confirmation of the decomposition**, and it fails against the one perturbation that matters: the $(2,2)\leftrightarrow(2,1)$ multiplicity swap of the verdict section, which is invisible to all four *and* to L84's Casimir multiset (that multiset is unweighted by multiplicity, so it moves not at all). Compare the property the brief describes from a companion audit, a chain that "breaks under any single transcription error" *and* ties each figure to a separately derived quantity. **This block's four have the first half and not the second.**

**Two further closures are available free and are not claimed.**

- **The top weight.** $\mathrm{Sym}^3(V_\lambda)$ contains $V_{3\lambda}$ with multiplicity exactly $1$ and nothing above it. $3\cdot(2,2)=(6,6)$, and the table carries $(6,6)_{455}$ at multiplicity $1$. **This is a genuine arithmetic check on the table's content**, consuming only representation theory, and it is the only entry the block could have verified by the arithmetic it claims for all of them.
- **The trivial multiplicity.** $m_{(0,0)}=1$ is confirmed by [L85](../findings/sym3-blocks.md#L42)'s degree sequence $1,1,4,5,14$, whose degree-$3$ entry is computed by Weyl integration, a method sharing nothing with the plethysm. The file makes this point for the Lovelock collapse and does not notice that it is also an independent check on a table entry.
- **And a third the record already has the machinery for**: $\sum_\lambda m_\lambda\cdot\dim V_\lambda[0]=234$, the weight-$(0,0)$ space of $\mathrm{Sym}^3$ reported at [findings/sym3-blocks.md:54](../findings/sym3-blocks.md#L54). That ties the multiplicity column to a *measured* number through zero-weight multiplicities, and unlike the four it is not invariant under the $35\leftrightarrow35$ swap.

**Recommended repair, and it is one sentence.** Replace "The reconstruction closes four independent ways" with: *the reconstruction closes against one externally known quantity, $\sum m_\lambda d_\lambda=\binom{37}3=7770$, and $24$, $41$ and $65$ are read off the multiplicity column as its count, sum and $\sum\binom{m+1}2$.* Then name the nouns in the heading, which currently gives four numerals and none: **$24$ isotypic blocks, $7770=\dim\mathrm{Sym}^3\mathcal W_5$, $41$ copies (equivalently highest-weight vectors), $65$ free Gram unknowns.**

## 5. Scope, what L83 licenses

**It is an $n=5$ statement throughout.** $B_2=\mathfrak{so}(5)$, $\mathcal W_5$ of dimension $35$, $\mathrm{Sym}^3$ of dimension $7770$. It licenses the block-diagonalisation of the $O(5)$-invariant Gram in the $n=5$ SOS certificate and nothing beyond it. **The programme's claims are for $n\ge12$ and this table does not reach them**, the file says so itself two lines below the table (trivial multiplicity $1$ here against $2$ from $n\ge6$, the Lovelock collapse) and again at [What the certificate would establish](../findings/sym3-blocks.md#L151), "It does not lift."

**One step is unstated and is exactly the step that fails at even $n$.** The table is $SO(5)$ data ($B_2$ highest weights), used as an $O(5)$ block table. That is legitimate at $n=5$ because $-I$ has determinant $-1$ in odd dimension, so $O(5)=SO(5)\times\{\pm I\}$, and $-I$ acts trivially on $\mathcal W_5$ (a $4$-tensor) hence on $\mathrm{Sym}^3$; every constituent is therefore $\sigma\boxtimes\mathbf1$ and each $SO(5)$-isotypic is a single $O(5)$-isotypic, multiplicity unchanged. **Without that, $65$ is not the unknown count**: an $SO$-isotypic of multiplicity $m$ splitting as $m_++m_-$ over $O$ would give $\binom{m_++1}2+\binom{m_-+1}2$, strictly less. The record pays for this at even $n$, [sym3-stability.md:73](../findings/sym3-stability.md#L73) records $65+2\cdot6=77$ $SO(12)$ constituents against $71$ $O(12)$ blocks, the six chirality pairs. **The $n=5$ case is easy and the block should still say it.** ([r174](REVIEW_r174.md#L121) derived the same thing independently, identifying the $5$-dimensional block as $[1]\otimes\det=\Lambda^4\mathbb R^5$ rather than the vector representation; my own route was index parity, twelve tensor indices with one free leaves eleven to contract, so the map to a $5$-dimensional target needs one $\varepsilon$ and is pseudo-tensorial. Same conclusion, different argument.)

**What consumes L83.** No file names L83 by number, the string occurs once in [findings/](../findings/), in its own heading. **Its numbers are consumed everywhere in this file's second half**, and they are load-bearing:

| consumer | what it takes from L83 |
| --- | --- |
| [L84](../findings/sym3-blocks.md#L32) | the $24$ blocks and their weights, the whole Casimir spectrum and the three collisions |
| [L86](../findings/sym3-blocks.md#L56), [L87](../findings/sym3-blocks.md#L74) | the multiplicity column, block by block, under the $\lambda_2$-parity rule |
| [L88](../findings/sym3-blocks.md#L78) | $65=\sum\binom{m+1}2$ and $24=\sum\binom m2$ |
| [L89](../findings/sym3-blocks.md#L92) | $65$, for the nullity $65-14=51$ |
| [L59](../findings/sym3-blocks.md#L157), and [results.md:202](../results.md#L202) and [results.md:586](../results.md#L586) | the split $65=36+29$ |
| [L62](../findings/sym3-blocks.md#L187), [L90](../findings/sym3-blocks.md#L115) | the $36$ within which rank $13$ is attained |

**A caution about $L88$'s $24$.** $\sum\binom{m_\lambda}2=24$ is numerically equal to the block count and is a different count, the gauge dimension $\dim\Lambda^2$, not the number of isotypics. **Two of this file's headline integers are both $24$ for unrelated reasons**, and L83's heading offers "$24$" with no noun. A reader tracing the certificate's dimension bookkeeping will meet both.

## 6. What a run would decide, and why I did not open one

**The one thing I cannot settle by hand is the multiplicity column itself.** Deriving it needs the plethysm $\mathrm{Sym}^3$ of the $B_2$ character of $V_{(2,2)}$, a decomposition, which the standing rule places outside the screening allowance.

**The code to do it is already in the repository and was never run to a filed verdict.** [b2_characters.py](../scripts/reviewers/r205/b2_characters.py) implements the Weyl character formula in exact Laurent polynomials, Newton's identity for $\mathrm{Sym}^k$, and a `MULT_REPO` table it compares against, and per [reviews/INDEX.md:9](INDEX.md#L9), reviewers 205 and 206 "neither wrote another byte"; the script is their total output, with no results. **Its `MULT_REPO` agrees entry for entry with the table under audit**, I checked the two lists against each other by hand, which is reading, not running.

**What running it would decide.** `mine == MULT_REPO` true would give the record its first *derived* (rather than measured) confirmation of the multiplicity column, by a route touching no $7770$-dimensional object, which would make the block's "no linear algebra on the $7770$" sentence true of the record and not only of the citation, and would kill the $35\leftrightarrow35$ blind spot outright. False would refute the table and, through the $65$, the certificate route's entire dimension bookkeeping. **It is also the run that would confirm the $65$ and the $24$ directly as $\dim\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$ and $\dim\Lambda^2(\cdots)^{O(5)}$, independently of the multiplicity column**, which would turn two of the four fake closures into real ones. **I recommend it as the highest-value run in this file, and I did not open it.**

## 7. The checklist

- **Provenance, clean, and this is the exception the brief warns is rare.** The table entered at `b432dfd7` (2026-08-28, "the Sym^3(Weyl_5) block structure gets its own file"), body sentence "closes four independent ways" included. The heading was added at `8d869d2c` (2026-09-02, "place headings for Lemmas 83-92"), whose message promises "headings only: no statement, proof or ordering is altered". **The promise holds for L83**: the heading's "closing four independent ways" paraphrases a sentence already in the body. The block carries no self-historical note, no reviewer attribution and no "Gate 2" boilerplate, so there is no false provenance claim here, **only a missing one** (§3).
- **Every hedging clause.** "Arithmetic on the highest weights", refuted (§3). "No linear algebra on the $7770$", true of the citation, false of the provenance (§3). "Four independent ways", refuted (§4). "The reconstruction closes", **true**: $\sum m_\lambda d_\lambda=7770$ exactly, and the twelve multiplicity-$1$ dimensions do sum to $4125$, which I verified ($7770-1020-315-2310$).
- **Derived, imported or measured.** $24$: **imported** (length of an imported list). $7770$: **derived twice and the two agree**, $\sum m_\lambda d_\lambda$ from the table, and $\binom{37}3$ from $\dim\mathcal W_5=35$. $41$: **imported** (sum of an imported column); separately **measured** by the highest-weight run. $65$: **derived from imported data** ($\sum\binom{m+1}2$); derivable independently, not so derived on the record. **Not one of the four is a measurement checked against a derivation, which is what "independent" would require.**
- **Duplication, none.** The table appears nowhere else under another number; the dimension $220$ occurs in [findings/](../findings/) only here, apart from two unrelated uses of the digits. [plan.md](../plan.md) held an earlier copy that [r174](REVIEW_r174.md#L117) checked, since migrated.
- **Pointers.** The block's single link, [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py), **resolves**; so do the neighbouring [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py) and [negated_generator.py](../scripts/reviewers/r177/negated_generator.py). **No stale anchor inside L83.**
- **The `##` containment reading.** I take **L83 = the heading at line 15 together with [The 24 blocks](../findings/sym3-blocks.md#L17) at lines 17–30**, i.e. the passage the heading commit placed it above, terminated by the next `####` at line 32. Under strict markdown nesting the reading is different and worse: a `####` followed by a `##` closes immediately, so **L83 would have no body at all** and would sit inside [The Weyl module and the group action](../findings/sym3-blocks.md#L5), whose content it does not state. **Both readings should not be available for a numbered result**, and here the choice is the difference between a lemma and an empty heading.

## 8. What I would change

1. **Replace "The reconstruction closes four independent ways"** with the one-closure sentence of §4, and name the nouns in the heading.
2. **Replace "The table is arithmetic on the highest weights"** with: the multiplicity column is imported from a plethysm, confirmed by [r170](REVIEW_r170.md), [r174](REVIEW_r174.md), [r177](REVIEW_r177.md) and [r178](REVIEW_r178.md); the dimension and Casimir columns follow by arithmetic. **Cite those four reviews**, the record's best evidence for L83 is currently unpointed and [findings/INDEX-results.md:98](../findings/INDEX-results.md#L98) says "no verdict on the record" as a result.
3. **State the weight-label basis** ($(\lambda_1,\lambda_2)$ in $e$-coordinates, not $\omega$), in [conventions.md](../findings/conventions.md), since this file writes weights both ways within eight lines.
4. **Add the top-weight check**, $\mathrm{Sym}^3(V_{(2,2)})\supset V_{(6,6)}$ at multiplicity exactly $1$: it is the one closure that is arithmetic on the highest weights, as the block claims all four are.
5. **Add the $O(5)$-versus-$SO(5)$ line of §5**, one sentence, since the same step fails at even $n$ and the record has already paid for it once.
6. **Move L83's heading below its `##`**, or make the whole file `####`-consistent, so the block has an unambiguous body.

**Nothing above touches a number.** The table stands exactly as printed.
