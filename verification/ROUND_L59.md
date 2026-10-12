# Round L59, the certificate's necessary condition is one dimension count

**Id:** L59 · **Date:** 2026-09-14 · **Verifiers:** v259, v260, v261 · **Brief:** [BRIEF_L59.md](BRIEF_L59.md) · **Logs:** `agent_logs/verify-L59-v259.log`, `agent_logs/verify-L59-v260.log`, `agent_logs/verify-L59-v261.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the statement and argument | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 299-303 |
| the landscape statement | [results.md](../results.md) line 216 |
| the canonical entry | [results.md](../results.md) line 741 |
| the module and normalisation | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 5-13 |
| the orbit constraint | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 108-122 |
| the givens' headings | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 15, 68, 94, 124, 138 |
| the Lean statement | [L59Statement.lean](../lean/HamiltonsCubic/Results/L59Statement.lean), no `sorry`, an abstract adjunction |

## The findings from phase 0

**The block is an annotation stack above a statement its notes already call uncheckable**: the pairing is never named, $\mu$ slides between the restricted and unrestricted map, the equivariance step from invariant forms to $\mathrm{Cat}_F(K,K)=0$ is absent, and the pointer names a section holding only the $14$. *None of this reached the statement or the canon.* Brief items 1 to 3.

**$\mu$, $\mathrm{Cat}_F$ and $B$ are defined in no findings passage**, and $B$ collides with the Killing-form normalisation in the same file. Brief scope note.

**The round sits in the certificate route**, whose standing is `GAP` at every numbered link it consumes (L83, L85, L86, L87, L88), with L87's rank step a mod-$p$ measurement. *The brief asks whether L59 follows from them, not whether they stand.*

## Adjudication

**Verdicts: [v259](VERIFY_v259.md), [v260](VERIFY_v260.md), [v261](VERIFY_v261.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, narrowed, impact `NARROWS`.** *Unanimous: the linear algebra from the adjunction to both displays is correct and the block arithmetic exact; the objects the lemma is stated in are defined nowhere, and the step joining them to the displays is unwritten.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the adjunction | the pairing, $\mu$, $B$, $\mathrm{Cat}_F$ and "supported on $K$" defined nowhere; $\mu$ names at least two maps | v259, v260, v261 | **confirmed**, the statement restated in the abstract form proved |
| C2 | $\mathrm{ANN}$ as $\{F:\mathrm{Cat}_F(K,K)=0\}$ | needs $K$ invariant, an invariant pairing and averaging; fails without invariance (a non-invariant form on $\mathbb R^2$ under $O(2)$) | v259, v260, v261 | **debt**, listed as owed |
| C3 | the two displays | follow from $\ker\mathrm{Cat}=\mathrm{image}(\mu_K)^\perp$ | v259, v260, v261 | **confirmed as algebra** |
| C4 | surjectivity of the unrestricted $\mu$ | asserted with no argument | v259, v260 | **debt**, listed as owed |
| C5 | $65=36+29$ | correct, and true block by block for any multiplicities | v259, v260, v261 | **confirmed**, its checking power stated |
| C6 | "the count is the necessary condition" and the title | the condition is $F_5\perp\mathrm{ANN}$, not a function of $\dim\mathrm{ANN}$; a certificate forcing $F_5\in\mathrm{image}$ is unargued, and positive semidefiniteness is untouched | v259 (`REFUTED AS STATED`), v260, v261 | **confirmed**, title and statement corrected, the reduction listed as owed |
| C7 | the Lean file | faithful to the abstract algebra, and says what it leaves out | v259, v260, v261 | **confirmed as algebra** |

**No adjudication pair was spent.** *Every finding is unanimous; the one refutation is a wording level witness.*

### Why narrowed, not repaired

**The debts are the definitions of the certificate apparatus itself**, an equivariance-and-averaging argument, and the reduction from a positive semidefinite certificate. *They sit on the certificate route, which closes nothing on the path to the open statement, so the round states what is proved and routes the rest to* Support owed *in [plan-verification.md](../plan-verification.md) rather than writing new theory under an audit.*

### Dependents

**[L62](../findings/sym3-blocks.md) SURVIVES in the abstract form**, taking $\mathrm{ANN}$ as the adjoint's kernel; its concrete reading inherits debt (ii).
