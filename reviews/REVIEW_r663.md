# Review r663, Lemma L83, the 24-block table at $n=5$

**Reviewer A of an independent pair on identical briefs. Target: [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 15, `#### Lemma L83, the $24$-block table, closing four independent ways ($24$ / $7770$ / $41$ / $65$)`, and the `## The 24 blocks` section beneath it.**

## Verdict: GAP

**Every number in the table is exactly right, all twenty-four dimensions reproduce from Weyl's formula by hand, and all four totals close.** What fails is the pair of hedging clauses in the same paragraph. **"The table is arithmetic on the highest weights" is false of the table's content**: the twenty-four highest weights and their multiplicities are a plethysm result imported from a character-ring run, and the commit that first put this table on the record said so in its own prose. **"Closing four independent ways" is an overstatement by roughly a factor of two**: one of the four is a tautology, two are functions of the multiplicity column alone, and only one touches the dimension column. Under either reading the *result* stands; the *evidence* is weaker than the heading advertises.

## Readings adopted

| symbol | reading I use | why |
| --- | --- | --- |
| $(\lambda_1,\lambda_2)$ in the table | **$e$-coordinates**, $\lambda=\lambda_1e_1+\lambda_2e_2$ | Forced: $(2,2)$ must be $\mathcal W_5$ at dimension $35$, and $4\omega_2=2e_1+2e_2$. The fundamental-weight reading gives $4\omega_1+2\omega_2=(5,1)$ at dimension $260$, so it fails every row. **The block never states which**, and $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ holds only in $e$-coordinates. |
| $\rho$ | $B_2$'s, $(3/2,1/2)$ in $e$-coordinates | positive roots $e_1-e_2,\ e_2,\ e_1,\ e_1+e_2$; half-sum $=(3/2,1/2)$ |
| $\langle\cdot,\cdot\rangle$ on weights | the standard Euclidean form on $e$-coordinates, dual to $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$ | stated in the section above L83 and cross-listed at [conventions.md](../findings/conventions.md) under "THE LETTER $B$ MEANS TWO THINGS, live" |
| block extent | **a `####` Lemma block runs from its heading to the next `####`, absorbing any `##` in between** | line 16 is blank and `## The 24 blocks` sits *below* the `####`, so this is the only reading under which L83 has content at all. Flagged because the brief says two audits have disagreed on it. |

**The three conventions repaired in [conventions.md](../findings/conventions.md) today ($\theta_0(n)$, $\Theta_n$, $S_{XYZ}$), do not appear in L83 and do not bear on it.**

## 1. The Weyl dimension formula, derived

For $B_2$ the positive roots are $e_1-e_2,\ e_2,\ e_1,\ e_1+e_2$, so with $\ell=\lambda+\rho$

$$\dim V_\lambda=\prod_{\alpha>0}\frac{\langle\ell,\alpha\rangle}{\langle\rho,\alpha\rangle}=\frac{(\ell_1-\ell_2)(\ell_1+\ell_2)\,\ell_1\ell_2}{1\cdot2\cdot\tfrac32\cdot\tfrac12},\qquad \ell=(\lambda_1+\tfrac32,\ \lambda_2+\tfrac12),$$

which clears to the product of four linear factors the block claims:

$$\boxed{\ \dim V_{(a,b)}=\tfrac16(a-b+1)(a+b+2)(2a+3)(2b+1).\ }$$

**Confirmed on all twenty-four rows, no exceptions.** Anchors: $(0,0)\mapsto1$, $(1,0)\mapsto5$, $(2,2)\mapsto35$, $(2,1)\mapsto35$, reproducing the file's own warning that a dimension check cannot separate $4\omega_2$ from $\omega_1+2\omega_2$.

## 2. The Casimir, confirmed against three anchors

$c_2(\lambda)=\langle\lambda,\lambda+2\rho\rangle$ with $\rho=(3/2,1/2)$ and the Euclidean form gives $\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ **exactly as stated**. The brief's worry (a constant taken from classical tables in a doubled convention), does not bite here, and three independent anchors pin the normalisation:

- **Long root length.** $e_1\pm e_2$ has $\langle\alpha,\alpha\rangle=2$, the standard normalisation in which Casimir eigenvalues are read.
- **Adjoint.** $\lambda=(1,1)$ gives $c_2=1\cdot4+1\cdot2=6=2h^\vee$ with $h^\vee(B_2)=3$. ✔
- **Vector.** $\lambda=(1,0)$ gives $c_2=4=N-1$ at $N=5$. ✔
- **The file's own $16$ against $12$.** $(2,2)\mapsto16$, $(2,1)\mapsto12$. ✔

The section above L83 already enumerates the neighbouring conventions ($32$, $8$, $8/3$, $4$) and identifies the $8/3$ as Killing, so the doubling trap is handled on the record.

## 3. The four numbers, derived, imported, or measured

| number | what it counts | status |
| --- | --- | --- |
| $7770$ | $\sum m_\lambda d_\lambda$, which must equal $\dim\mathrm{Sym}^3(\mathbb R^{35})=\binom{37}{3}$ | **derived**, and checked against a genuinely external target |
| $41$ | $\sum m_\lambda$, the total multiplicity, equivalently the number of highest-weight vectors | **arithmetic on the table**; externally anchored only by the construction in "The 41 highest-weight vectors" further down the file |
| $65$ | $\sum m_\lambda(m_\lambda+1)/2$, the SOS Gram unknowns | **arithmetic on the table**; externally anchored by [L88](../findings/sym3-blocks.md)'s Weyl-integration $\dim\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}=65$ |
| $24$ | the number of rows | **neither derived nor measured, it is the table's own size.** Nothing outside the table predicts it. |

The heading gives four numerals and no nouns; the nouns are above.

**All exact, by hand:** $\binom{37}{3}=37\cdot36\cdot35/6=7770$; $4\cdot255+3\cdot105+2\cdot1155+4125=1020+315+2310+4125=7770$; $\sum m=8+3+18+12=41$; $\sum m(m+1)/2=20+6+27+12=65$; the twelve multiplicity-$1$ dimensions sum to $4125$. **A screen reproduced every one of these and every dimension** (seconds of arithmetic on a dictionary I typed from the table; reported as a screen, not as evidence).

**The $24$ in L83 and the $24$ in [L88](../findings/sym3-blocks.md) are different objects that happen to agree.** L88's is $\sum m(m-1)/2=\dim\Lambda^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$; there is no reason for $\sum m(m-1)/2$ to equal the row count, and the coincidence should not be read as a confirmation of either.

## 4. Is it arithmetic?, the substantive finding

**No, not the part that carries the content.**

- **The dimension column is arithmetic.** Given the twenty-four weights, the four-factor formula produces the twenty-four dimensions in closed form.
- **The twenty-four weights and their multiplicities are not.** They are the decomposition of $\mathrm{Sym}^3(V_{4\omega_2})$, and no arithmetic on highest weights can produce them, the highest weights are the very unknown. Producing them needs the character of $\mathcal W_5$ and a symmetric-power plethysm.

**The cited script does not derive the table; it checks it.** [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) hard-codes twelve multiplicities in `NAMED`, hard-codes the twenty-four-value list `SPECTRUM`, then *solves* the remaining twelve blocks by matching Casimir values against that hard-coded spectrum. The spectrum is itself a function of the table, so the reconstruction consumes its own answer. **The script's own docstring says exactly this** ("Derivation, checked here rather than established here") and **that qualification does not survive into the finding block**, which cites the script immediately after "No linear algebra on the $7770$ is involved."

**The real source is [scripts/reviewers/r204/sage_blocks.sage](../scripts/reviewers/r204/sage_blocks.sage)**, which decomposes `B2(0,4).symmetric_power(3)` in Sage's `WeylCharacterRing` via Brauer–Klimyk and reads the multiplicities off. That is a decomposition run.

**The record said so at birth.** A `git log -S` on the table's rows puts the table's first appearance at commit `40bdc9ab` (2026-08-28, `feat(plan): the n = 5 block structure in full`), whose surrounding prose in [plan.md](../plan.md) reads:

> The block *labels and multiplicities* came free from the character ring; the **explicit isotypic projections do not**.

**So "arithmetic on the highest weights" is a later rewording of a claim the record originally stated correctly.** The honest form is: *given* the decomposition, the dimension column, the Casimir spectrum, the collisions and the four totals are all closed-form arithmetic, no linear algebra on the $7770$ is needed to check any of them. That much I confirm, and it is a real and useful statement.

**On the literal sentence "no linear algebra on the $7770$ is involved":** narrowly true, a character-ring decomposition is character arithmetic, not a $7770\times7770$ eigenproblem. But the record's own independent verification of the table, [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py), *does* work inside $\mathrm{Sym}^3(\mathcal W_5)$, intersecting raising-operator kernels on weight spaces up to dimension $234$, and it too hard-codes `BLOCKS`. The sentence is a claim about the four closures and reads as a claim about the table.

## 5. "Four independent ways", refuted as stated

**Independence is the load-bearing word, and it does not hold.** What each closure consumes:

| closure | consumes the weights? | the dimension column? | the multiplicity column? | external anchor |
| --- | --- | --- | --- | --- |
| $24$ blocks | no | no | no (row count only) | **none** |
| $\sum m_\lambda d_\lambda=7770$ | only through $d_\lambda$ | **yes** | yes | $\binom{37}{3}$, clean and external |
| $\sum m_\lambda=41$ | no | no | yes | the $41$ highest-weight vectors, in a different section |
| $\sum m(m+1)/2=65$ | no | no | yes | [L88](../findings/sym3-blocks.md)'s Weyl integration, clean and external |

**Only $7770$ sees the dimension column. Three of the four see only the multiplicity multiset**, of which they are the power sums $p_0=24$, $p_1=41$ and (through $2\cdot65-41$) $p_2=89$. Three moments of one column is not four independent confirmations of a table.

**How many are there really? Two clean external checks, one internal identity, one tautology.**

- $7770$ against $\binom{37}{3}$, a real check with an outside target.
- $65$ against L88's constant-term computation, which the block itself says touches "no adapted basis, no cache, no prime, no highest-weight vectors", a real check with an outside target.
- $41$, arithmetic on the multiplicity column, confirmed by a construction that starts from the same column.
- $24$, the table has twenty-four rows because it has twenty-four rows.

**The brief asks whether the four have the "breaks under any single transcription error" property. They do not, and the counterexample is the one this file already warns about.** Swap the labels on the two $35$-dimensional blocks, so the multiplicity-$4$ row reads $(2,1)_{35}$ and the multiplicity-$2$ row reads $(2,2)_{35}$. Then the row count is $24$, $\sum m_\lambda d_\lambda$ is unchanged at $7770$, $\sum m_\lambda=41$ and $\sum m(m+1)/2=65$. **All four closures survive a corruption that swaps $\mathcal W_5$ itself with the block the file's opening paragraph says a dimension check cannot separate from it.** What catches it is [L84](../findings/sym3-blocks.md)'s Casimir spectrum ($16$ against $12$) and [L86](../findings/sym3-blocks.md)'s parity rule, neither of which is among the four.

**Two further blind spots of the same kind.** Permuting dimensions between rows of equal multiplicity (for instance $(4,3)_{165}$, $(4,4)_{231}$), leaves all four closures intact. And a mis-grouping that preserves $\sum m$ while changing the multiset, such as moving one block from multiplicity $3$ to $2$ and another from $2$ to $3$, breaks $65$ only.

**The strongest check available is not among the four.** Recomputing each row's subscript from the four-factor formula is twenty-four independent tests of the weight-to-dimension pairing, and it is precisely what the four closures cannot do. It should be stated as the closure it is.

## 6. What the table *is* consistent with, the real evidence

The block's own four closures are weak, but the table sits in a tight web the block does not cite, and this is the finding that should replace "four independent ways":

- **$\lambda_2$-even blocks: sixteen of them, dimensions summing to $3570$ exactly**, matching [L86](../findings/sym3-blocks.md)'s parity rule and [L87](../findings/sym3-blocks.md)'s orbit-Gram rank of $3570$ over $\mathbb F_{46337}$, a measurement sharing nothing with the table.
- **$41-16=25$ surviving multiplicities, and $\sum m(m+1)/2=36$ after each even block loses one**, shaped as **two $3\times3$, five $2\times2$ and nine scalars**, every one of L86's figures reproduced from L83's table alone.
- **$\sum m(m-1)/2=24$ and $\sum m^2=89$**, matching L88's two Weyl integrations and their sum.
- **Twenty-one distinct Casimir values, colliding in exactly three pairs at $30$, $40$ and $60$**, L84's corrected count, reproduced from the closed form.
- **Trivial multiplicity $1$**, matching [L85](../findings/sym3-blocks.md)'s degree sequence $1,1,4,5,14$ at degree $3$, computed by Weyl integration, and the Lovelock collapse.
- **The absent $(6,5)$ is genuinely absent**, by hand: the only weights of $\mathcal W_5$ with first coordinate $2$ are $(2,k)$, so weight $(6,5)$ in $\mathrm{Sym}^3$ arises only from the multiset $\{(2,2),(2,2),(2,1)\}$ and has multiplicity $1$; and $(6,6)-(6,5)=\alpha_2$ with $\langle(6,6),\alpha_2^\vee\rangle=12>0$, so $V_{(6,6)}$ already absorbs it. Multiplicity $0$ for the irreducible. ✔

**That web is worth far more than the four numerals in the heading, and none of it is claimed there.**

## 7. Scope

- **$B_2=\mathfrak{so}(5)$, so this is an $n=5$ statement throughout**, as the file's own opening line says ("The certificate route at $n=5$").
- **It licenses**: the block-diagonal shape of the $n=5$ SOS Gram, the $65$ unknowns, and everything L84–L91 build on that shape. Nothing beyond $n=5$.
- **It explicitly does not extrapolate, and the block says why.** "The trivial multiplicity is $1$ here and $2$ from $n\ge6$", the $n\le5$ Lovelock collapse. The table is structurally special to the dimension it is computed at, and the programme's target is $n\ge12$, where [results.md](../results.md)'s Lemma L63 carries the analogous $71$-block table with $\sum m_\lambda d_\lambda=\binom{1640}{3}$. **L83 is scaffolding for a certificate at one small $n$**; the $\Theta_5=\sqrt{3/2}$ certificate it supports is a genuine result, but it is a result about $n=5$.

## 8. Consumers, provenance, duplication, pointers

- **Consumers.** `L83` as a token appears nowhere on the record outside its own heading, not in [results.md](../results.md), not in [plan.md](../plan.md), not in [report/](../report/). **Its *table*, however, is consumed by L84, L86, L87 and L88 in the same file**, and every one of those checks above passes against it. The absence of a citation by number is a record-hygiene point, not a mathematical one.
- **Index.** Listed at [findings/INDEX-results.md](../findings/INDEX-results.md) row 83 as "**Gate 2: no verdict on the record.**" That is accurate; this review is the first.
- **Provenance.** **The block carries no self-historical boilerplate note**, so the fifteen-copy pattern the brief flags does not apply here, the one provenance claim to check was the "arithmetic" attribution, and `git log -S` settles it against the block (§4).
- **Duplication.** The table appears once in [findings/](../findings/). An earlier version lived in [plan.md](../plan.md) at commit `40bdc9ab` and has been removed; it used a degenerate notation ($(4)_{55}$, $(3)_{30}$) and carried a claim now known false, "the vector block $(1)_5$ carries no cubic covariant of $\mathrm{Weyl}_5$ by parity", refuted by r173 (`docs(review): r173 -- the vector block was deleted on a parity argument that is wrong`). **The current table has $(1,0)_5$ at multiplicity $1$ and is right.** No surviving duplicate under another number.
- **Pointers.** The block carries one link, [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py); it resolves. Every other file cited in the surrounding sections resolves too.

## 9. What would repair the block

Two sentence-level changes, no mathematics:

1. **Replace "The table is arithmetic on the highest weights" with what is true**: *the twenty-four weights and multiplicities are the character-ring decomposition of $\mathrm{Sym}^3(V_{4\omega_2})$, computed in [sage_blocks.sage](../scripts/reviewers/r204/sage_blocks.sage); given them, the dimension column, the Casimir spectrum and every total below are closed-form arithmetic that a reader can redo by hand.* That keeps the block's real value (a reader can check it without a run) and drops the circularity. Cite the plethysm alongside [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py), and carry that script's own "checked here rather than established here" into the block.
2. **Replace "closes four independent ways" with the count that survives**: *two external closures ($7770$ against $\binom{37}{3}$, $65$ against L88's Weyl integration), plus twenty-four per-row dimension checks from the four-factor formula.* If a chain that breaks under any single transcription error is wanted, the parity slice is the one to state: **sixteen $\lambda_2$-even blocks summing to $3570$, leaving $25$ multiplicities and $36$ unknowns as two $3\times3$, five $2\times2$ and nine scalars**, that consumes the weights, the dimensions *and* the multiplicities, and it is checked against L87's independently measured rank.
3. **State the coordinate convention.** One clause saying the pairs are $e$-coordinates, $\lambda=\lambda_1e_1+\lambda_2e_2$, so that $\mathcal W_5=(2,2)=4\omega_2$.

**Nothing in the table needs to change. The claim on the record should be the one the numbers support.**
