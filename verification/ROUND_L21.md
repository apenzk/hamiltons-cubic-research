# Round L21, the eigenvalue bound $\alpha\le\tfrac13$, structural in every dimension

**Id:** L21 · **Date:** 2026-09-07 · **Verifiers:** v200, v201, v202 · **Brief:** [BRIEF_L21.md](BRIEF_L21.md)

## Sources, verbatim

| passage | source |
|---|---|
| the canonical entry | [results.md](../results.md) lines 713-715 |
| the landscape statement | [results.md](../results.md) line 234 |
| the section carrying the argument | [findings/route-a.md](../findings/route-a.md) lines 150-180 |
| the block | [findings/route-a.md](../findings/route-a.md) lines 182-215 |
| what the tube proof consumes | [findings/route-a.md](../findings/route-a.md) lines 137-140 |

## The findings from phase 0

**The canonical entry states no result.** [results.md](../results.md) line 713 is a heading and a proof pointer with nothing between them, no statement, no hypotheses, no $\alpha$, no range. *The block's own text records this as "the same defect as the L20 entry directly above it"*, so the record has known it and left it.

**The block is an annotation stack rather than a repaired statement.** Six blockquotes stand before the mathematics, four of them correcting the text that follows and none of them written into it. **The loop's rule is that a fix replaces the defective text**, and the accumulated notes are exactly what that rule forbids: a reader must decide which of two passages to believe, several times over, before reaching the argument.

**The two tables disagree and the block says so about itself.** The section at lines 150-180 carries five rows, the fifth reading *"two higher types, $0$ throughout"*; the block's table carries four and asserts *"Only four types carry a nonzero eigenvalue"* with the fifth row absent.

**And the section's closing paragraph contradicts an annotation above it.** The section ends *"The remaining formal obligation is a proof that the stable range begins at $n-4\ge8$ rather than a check at two dimensions"*; an annotation on the block states the range question settled by row length, at every $n\ge9$. **Both are in the file, unlabelled, and the round is asked to decide which the mathematics supports.**

## What the verifiers are asked beyond the standing list

Whether Schur really applies with no multiplicity-free hypothesis once multiplicities are absorbed into $M_\lambda$; whether the four $F_\lambda$ spectra and the multiplicity-space dimensions $20,20,6,10$ are $n$-independent for the reason claimed rather than as a coincidence of three sampled dimensions; whether the fifth row's *"$0$ throughout"* is a theorem (the degree argument on the $A$-indices) or an assertion; whether the orbit tangent really is $2\cdot(\text{trivial})\oplus4\cdot(\text{vector})$ and coincides with the $\tfrac12\theta^*$-eigenspace block by block; and **whether deleting $\mathbb Ru$ and the orbit leaves top eigenvalue exactly $\tfrac13\theta^*$, or only at most that**, the direction the consuming lemma needs.

**And the standing question**: [L20](../findings/route-a.md) consumes $\alpha\le\tfrac13$ and [L134](../results.md) consumes the value $\tfrac13$ as attained. Say what each may cite.

## Adjudication

**Verdicts: [v200](VERIFY_v200.md), [v201](VERIFY_v201.md), [v202](VERIFY_v202.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, impact `NARROWS`.** Unanimous, and the three arrived at the same split of the lemma independently.

**The lemma is in two halves and only one of them was ever proved.** Each verifier derived, by hand and identically in $m=n-4$: the six $SO(m)$-types with multiplicities $20,20,6,10,4,1$, **none of which contains $m$**, so their $n$-independence is a theorem rather than three data points; the dimension identity as a polynomial in $m$, both sides $\tfrac1{12}(m^4+16m^3+89m^2+194m+120)$; the containment $\mathop{\mathrm{im}}F_u\subseteq AA\oplus AB\oplus AC\oplus BB$ and the annihilation of $940$ of $1638$ dimensions; and the orbit at $2\cdot(\text{trivial})\oplus4\cdot(\text{vector})$, dimension $4n-14$. **The record had all of this as measurement.**

**What is owed is the other half, and it is thinner than "three data points".** The four matrices $F_{\mathbf1},F_V,F_{\Lambda^2},F_{S^2_0}$ are asserted to have $m$-free entries. $M_\lambda(n)$ is a different space at each $n$, and equal dimensions license nothing about spectra without an identification intertwining the operators, none is proposed. **Cross the evidence against the validity range and two of the three exact checks fall outside it**: they were run at $n=6,8,10$, and $m\ge5$ excludes $n=6$, where $\dim V_{(2,2)}$ evaluates to $-2$, and $n=8$, where the types are reducible. **The exact in-range evidence is one dimension.**

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | the census and the dimension identity | independent branching, three times over | 3/3 | `CONFIRMED`, and promoted from measurement to theorem |
| **C2** | the four $F_\lambda$ spectra | asserted $m$-free from sampled dimensions, no intertwiner proposed | 3/3 | **`HYPOTHESIS-DEBT`**, and only $n=10$ is admissible evidence |
| **C3** | the canonical entry | a heading and a proof pointer with no statement | 3/3 | `BROKEN`, statement written |
| **C4** | the landscape line | drops the range, states the unproved input flatly | 3/3 | `CONFIRMED`, repaired |
| **C5** | Schur "with no multiplicity-free hypothesis" | needs **absolute** irreducibility, never stated; holds at $m\ge5$ | 3/3 | `PROVEN, hypotheses corrected` |
| **C6** | the stable range | $n-4\ge8$ against $n\ge9$ | 3/3 | `CONFIRMED`, $n\ge9$, on row length; the obligation struck |
| **C7** | four rows against five | | 3/3 | **`WITHDRAWN` as a contradiction**, see below |
| **C8** | the fifth row's stated reason | the degree sentence read as a claim about the image | 1/3 | **`WITHDRAWN`**, see below |
| **C9** | orbit **equality** with $E(\tfrac12\theta^*)$ | the inclusion is L24's; equality is the risky direction | 1/3 | `CONFIRMED`, and **not independent of C2** |
| **C10** | $\mathfrak{stab}(u)\cap(\mathbb R^4\otimes\mathbb R^m)=0$ | asserted, never argued | 1/3 | `CONFIRMED`, recorded as owed |
| **C11** | "reduction to one $20\times20$ block" | the projection acts in three blocks, not the trivial one alone | 1/3 | **`REFUTED`**, the claim is struck with the annotation carrying it |
| **C12** | what L134 consumes | attained value against upper bound | split | **settled below** |

### C7 and C8, both withdrawn, and the second is the brief's own fault

**The two tables are compatible rather than contradictory.** The four-row reading omits the fifth row; it does not deny it. Two verifiers said so directly, and the sentence *"only four types carry a nonzero eigenvalue"* is true. **The real defect is arithmetic**: the four rows carry $698$ while the same paragraph claims the multiplicities sum to $\dim\mathcal W_n=1638$. **One table now stands, with all six rows and the last two named.**

**C8 is a misreading the round induced.** One verifier read *"$F_u$ preserves the $A$-index degree and vanishes on degree $\le1$"* as a claim about the image, under which it is false, since $AC$ and $BB$ both have low $A$-degree and both appear in the image list the same sentence gives. **Read as a claim about the input $h$ it is correct and is the image claim restated**, $F_u$ annihilates exactly $BC\oplus CC$. *The block presented one argument as two, which is what made the misreading available*; the repaired text says so and drops the second-proof claim.

### C12, settled by reading the consumer

**L134 consumes the upper bound at its numerical value, not the attained value.** Its margin is $3\theta^*(\alpha-\tfrac12)$ read at $\alpha=\tfrac13$, giving $-\theta^*/2$; the display is an inequality throughout, so a smaller true maximum would only strengthen it. **What the numerical value does buy is that a hedge weakening $\tfrac13$ to any $a<\tfrac12$ rescues L20 and not L134**, which is what the old annotation was reaching for and stated ambiguously. *Attainment governs the sharpness of the radius $0.5748$ alone, and no $\tfrac13$-eigenvector is exhibited anywhere on the record.* **The brief's framing (that L134 consumes $\tfrac13$ as attained), came from that annotation and was wrong.**

### The phase 0 findings, repaired

The canonical entry now carries a statement with its range, the identity of $u$, the subspace, and a note separating the proved half from the owed one. **The block's six annotations are gone**, their surviving mathematics written into the prose and their refuted or superseded claims removed. One table stands where two stood. The section's over-strong obligation is struck and replaced by the row-length range.

### What is not repaired here, and why

**C2 needs new mathematics and is the research loop's.** It is filed in [plan.md](../plan.md) with the shape of the discharge named: an $m$-independent basis of each $M_\lambda$, entries as rational functions of $m$ with a degree bound, and rank certificates over $\mathbb Q$. **A cheaper first test is named with it**, the table forces $\mathop{\mathrm{tr}}(F_u^2)/\theta^{*2}=4+2m+\tfrac{m(m-1)}{12}+\tfrac{(m-1)(m+2)}4$, and a closed form for $\lVert T\rVert^2$ turns $m$-independence into one scalar identity. **C10 is filed with it.**

**One verifier supplied the argument C10 asks for.** It stays in that verifier's report and out of the record: a check may not write the proof it is checking.

