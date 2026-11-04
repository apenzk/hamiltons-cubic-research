# Round L62, $\dim\mathrm{ANN}=1$, so the restricted rank is $13$

**Opened** 2026-09-05. **Verifiers** v64, v65, v66. **Adjudicators** allocated at phase 3.

**Source.** [findings/sym3-blocks.md:329–346](../findings/sym3-blocks.md) (block `#### Lemma L62`), canonical form [results.md:629–635](../results.md), setting [results.md:619–623](../results.md) (Lemma L59).

**How this round arrived.** Promoted with [L61](ROUND_L61.md) on the reading that the two blocks named the same support differently. **The L61 round settled which of the two was accurate (L62's) so what is checked here is L62's own claim rather than the discrepancy.**

## Phase 0, the statement, in the two forms on file

**Form A**, [results.md:629](../results.md):

> In the setting of Lemma L59, evaluation at $W_0$ is a nonzero functional on the $14$ invariant sextics and every product of two cubics of $K$ vanishes there, so the restricted rank is at most $13$. A rank computed from a sample of $K$ bounds the true rank from below, and reduction modulo a prime can only lower it further, so a sampled rank equal to $13$ forces equality; it equals $13$ at four primes. Hence $\dim\mathrm{ANN}=1$, spanned by $A(W_0^6)$, and $F_5\perp\mathrm{ANN}$, which is the necessary condition of Lemma L59 met. The argument is exact, the sampling being a lower bound rather than a numerical estimate.

**Form B**, [findings/sym3-blocks.md:346](../findings/sym3-blocks.md):

> Order-$1$ vanishing at $W_0$ caps the restricted rank at $13$: a product of two cubics of $K$ vanishes at $W_0$, and evaluation there is a nonzero functional on the $14$. A sampled rank is bounded above by the true one, and reducing modulo $p$ can only lower it further, so a sampled rank *attaining* $13$ forces equality. It attains it, at four primes. Hence $\dim\mathrm{ANN}=1$, spanned by $A(W_0^6)$, and $F_5\perp\mathrm{ANN}$.

**The difference between the forms is in the brief, unlabelled**, as the skill requires: Form A says the sample *bounds the true rank from below*, Form B says it *is bounded above by the true one*. These are the same statement; the round records that they are stated in opposite voices at the two sites, which is a legibility finding at most.

**The setting**, [results.md:619](../results.md), quoted into the brief in full, since every term of L62 is defined there and nowhere else.

## Phase 2, clustering

**Built from [v64](VERIFY_v64.md) and [v65](VERIFY_v65.md) while v66 was still writing**, so the third report slots into a table that already exists rather than starting one. Support is recorded and does not classify: a finding raised once is adjudicated exactly as one raised three times.

| id | step attacked | mechanism | v64 | v65 | v66 |
|---|---|---|---|---|---|
| **D1** | "a sampled rank equal to $13$ forces equality" | **the chain changes space mid-argument**, the measurement runs on the $47$ Hermitian columns, the conclusion's $\mathrm{ANN}$ on the $36$ real symmetric unknowns, and the only available inequality $\mathrm{rank}_{36}\le\mathrm{rank}_{47}$ runs the wrong way | ✓ | | |
| **D2** | $\mathrm{rank}=14-\dim\mathrm{ANN}$ (L59's adjunction) | nondegeneracy of the apolar pairing on the $14$, and the step from "kills every invariant form on $K$" to $\mathrm{Cat}_F(K,K)=0$, are on file nowhere | ✓ | ✓ | |
| **D3** | "$\mathrm{ANN}$ spanned by $A(W_0^6)$" | $A$ is defined in no canonical file, and as typed $A(W_0^6)$ is not an element of the $14$; the reproducing property $\langle F,A(W_0^6)\rangle=F(W_0)$ that carries both this and $F_5\perp\mathrm{ANN}$ is absent | ✓ | ✓ | |
| **D4** | $\dim\mathrm{ANN}=1$ | the value is the measurement entire, and the equivariant-copy identification it rests on appears in neither written form | ✓ | ✓ | |
| **D5** | "reduction modulo a prime can only lower it" | true of a $p$-integral rational matrix; that the sampled matrix *is* such a reduction is stated nowhere | ✓ | ✓ | |
| **D6** | "it attains it, at four primes" | **the standing objection is too strong**, four row dumps near $2^{40}$ each written behind a rank assertion, plus two small primes; the real defect is that no citing site names one, and the plural buys nothing | ✓ | ✓ | |
| **D7** | [results.md:23](../results.md) | one sentence sweeps L87's rank and L62's value into "proofs rather than measurements"; defensible for L62, **false for L87**, whose sample is the reduction of nothing | ✓ | ✓ | |
| **D8** | the word "rank" across L59, L62 and L89 | one symbol $\mu$ for two maps and three names for one number; under the unrestricted reading L89 forces $\dim\mathrm{ANN}=0$ and contradicts L62 | ✓ | ✓ | |
| **D9** | the cap's own scope | confirmed, and **weaker than advertised**, the six lines use only $W_0\ne0$ and $K\subseteq\{q:q(W_0)=0\}$, nothing about $\mathbb{CP}^2$, padding or the stabiliser | ✓ | ✓ | |
| **D10** | L59's $\mathrm{Cat}$-injectivity and the $65=36+29$ split | imported by "in the setting of Lemma L59" and never used | ✓ | ✓ | |

**D7 is this round's own inheritance.** That sentence was written into [results.md](../results.md) by [round L61](ROUND_L61.md)'s repair one day earlier, and two verifiers independently read it as overreaching on L87. **A repair is a claim and enters the queue like any other.**

**D1 has support 1 and is the round's strongest candidate**, which is exactly the configuration the loop's support rule exists for.

### v66's ticks, and one finding it adds

| id | v64 | v65 | v66 |
|---|---|---|---|
| D1 | ✓ | | |
| D2 | ✓ | ✓ | ✓ |
| D3 | ✓ | ✓ | ✓ |
| D4 | ✓ | ✓ | |
| D5 | ✓ | ✓ | ✓ |
| D6 | ✓ | ✓ | ✓ |
| D7 | ✓ | ✓ | ✓ |
| D8 | ✓ | ✓ | |
| D9 | ✓ | ✓ | ✓ |
| D10 | ✓ | ✓ | |
| **D11** | | | ✓ |

**D11**, [v66](VERIFY_v66.md): *"a rank computed from a sample of $K$"* is **`REFUTED AS STATED`**, what is sampled is $40$ evaluation points in $\mathcal W_5$, not a subspace of $K$. The inequality's direction survives either reading.

### The two checks that cost nothing, run before any adjudication

**1. The brief against the source.** Both quoted forms match [results.md:631](../results.md) and [findings/sym3-blocks.md:346](../findings/sym3-blocks.md) character for character. **No finding here is an artefact of the brief.**

**2. The whole record searched before accepting "no argument on file".** Two findings do not survive this, and what replaces them is smaller:

- **D3 dissolves to a pointer defect.** The reproducing property the conclusion needs is on the record at [sym3-blocks.md:253](../findings/sym3-blocks.md), where it is called *"a free identity the block misses"*, and $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$, $F_5\perp\mathcal A(W_0^6)$ *because* $F_5(W_0)=0$ is stated in full at [sym3-blocks.md:227–229](../findings/sym3-blocks.md). **What is true is that $A$ is defined in no canonical file** and the block cites none of this. A missing pointer, not a missing proof.
- **D8 dissolves the same way.** [findings/conventions.md:45](../findings/conventions.md) already fixes the convention *and* names the exact trap: *"ANN is the annihilator of the IMAGE inside L85's $14$-dimensional target, it is the adjoint's kernel, not $\ker\mu$ … a reader taking the other sense derives $\dim\mathrm{ANN}=0$ and contradicts the formula."* The ambiguity is settled on the record; L62 and [results.md](../results.md) do not point at where.

**Neither goes to adjudication.** Both are carried to phase 5 as citation repairs, which is the smaller claim the search bought.

### The merge, and what goes to phase 3

**D1, D4 and D11 are one finding attacking one step by three mechanisms**, and they merge because the repair is a single sentence saying what the ranked matrix is: the dimension mismatch ($47$ Hermitian columns against $36$ real unknowns), the unstated equivariant-copy identification, and the misnaming of the sample are three readings of *"the object the pipeline ranks has not been identified with $\mu_K$ in writing"*. Merging where the repair target is identical is the case the clustering rule's caution does not cover.

**D7 transfers rather than adjudicating.** It is a finding about [L87](../findings/sym3-blocks.md)'s status, carried on a sentence that happens also to mention L62; it is pre-registered as a question in L87's round and carries no verdict from here.

**D9 and D10 are recorded, not adjudicated.** Both are unused-import findings, the cap uses only $W_0\ne0$ and $K\subseteq\{q:q(W_0)=0\}$, and L59's $\mathrm{Cat}$-injectivity and $65=36+29$ are inert in L62, and neither would delete anything.

**To phase 3: D1 (merged), D2, D5, D6.** Adjudicators v67–v74.

## Phase 4, part 1, the dependent set, built while phase 3 runs

Searched three ways, by number (`L62`, `Lemma~62`, `Lemma 62`), by the statement's signature ($\dim\mathrm{ANN}$, $A(W_0^6)$, $\mathrm{rank}=13$), and by reading the blocks around the owning file's index row.

### The copy

**[report/sections/07-gradedness-split.tex:904–906](../report/sections/07-gradedness-split.tex) carries Form B in full**, word for word inside a `\begin{Lem}{62}` environment. **It is a second original, not a citation**, and nothing in either file marks it as a copy. Every correction phase 5 makes lands there in the same commit.

### What the report holds that the canon does not

**The search for "no argument on file" reaches the report, and two more findings shrink there.** Both hypotheses the verifiers reported missing are stated, in the one file none of the three read, because the brief named the findings block and [results.md](../results.md):

- **The equivariance hypothesis is written down**, at [07-gradedness-split.tex:908](../report/sections/07-gradedness-split.tex): *"The cap is conditional on the copies being identified equivariantly, and the multi-probe Schur test is what supplies that; a family identified non-equivariantly can sample above its own rank."* This is the hypothesis D1 carries as unstated, stated exactly, with its failure mode.
- **$A(W_0^6)\in\mathrm{ANN}$ is argued**, at [07-gradedness-split.tex:911](../report/sections/07-gradedness-split.tex): its catalecticant is the orbit average of the rank-one forms $(f,g)\mapsto f(gW_0)g(gW_0)$, and it kills $K\times K$ because every $f\in K$ vanishes **on the whole orbit** rather than at $W_0$ alone. The section goes further and gives the criterion without catalecticants, $A(v^6)\in\mathrm{ANN}\iff v^3\in C$.

**The defect is one direction of drift, and it is the reverse of what a reader would guess.** The report is *ahead* of the canon here: it states hypotheses and arguments that [results.md](../results.md) and [findings/sym3-blocks.md](../findings/sym3-blocks.md) omit. **A record whose derived document carries content its sources lack has no way to keep the two in step**, and the correction runs from the report into the canon rather than outward.

### One stale entry

**[findings/LEDGER.md:1374](../findings/LEDGER.md)** records that [09-status.tex](../report/sections/09-status.tex) *"tables it as Proven"*. That row now reads **"Cap proven; equality an Observation"**, with the mod-$p$ dependency spelled out. The ledger entry describes a defect that was repaired and never closed.

### Dependents by number

| site | kind |
|---|---|
| [results.md:202](../results.md), [results.md:619](../results.md) (L59) | **load-bearing**, L59's closing sentence, *"Lemma L62 shows it is met"*, is the necessary condition's discharge |
| [results.md:206](../results.md) | mention, the one-line digest |
| [findings/sym3-blocks.md:227–229](../findings/sym3-blocks.md) | **load-bearing**, the boxed $F_5\in\mathrm{image}$, and the $36-13=23$ affine family |
| [report/sections/07-gradedness-split.tex:883](../report/sections/07-gradedness-split.tex) | **load-bearing**, *"the target is reachable"*, the certificate's first of three composing facts |
| [report/sections/09-status.tex:13–14](../report/sections/09-status.tex) | mention, the status table, already correctly graded |
| [findings/INDEX.md:38](../findings/INDEX.md), [findings/INDEX-results.md](../findings/INDEX-results.md), [findings/LEDGER.md:1374](../findings/LEDGER.md) | index rows |

## Phase 4, part 2, the transitive closure, and why it stops immediately

**L62 discharges L59's necessary condition, and L59 is consumed by nothing further.** The chain the record draws is $\text{L87}\to\text{L59}\to\text{L62}\to$ *"the certificate is feasible"*.

**That chain terminates in a claim the record establishes a second way, by exhibition.** L59 is a **necessary** condition for the certificate to exist; [L61](ROUND_L61.md) produces the certificate (an explicit positive-definite rational Gram whose sextic is $F_5$) and an exhibited object proves its own existence without the dimension count that predicted it. **So $F_5\in\mathop{\mathrm{image}}$, the boxed conclusion at [sym3-blocks.md:227](../findings/sym3-blocks.md), is reached independently of $\dim\mathrm{ANN}=1$.**

**This bounds the impact before any adjudication returns.** Whatever phase 3 says of the squeeze, the conclusion it supports is on the record by another route, which is the definition of `CONTAINED`. What L62 uniquely carries is narrower and worth stating exactly:

- the **value** $13$, hence the affine solution family's dimension $36-13=23$, which the certificate route reports but does not need;
- the identification of the single obstruction as $A(W_0^6)$, which [07-gradedness-split.tex:911](../report/sections/07-gradedness-split.tex) argues directly from the orbit average and not from the rank at all.

**A dimension count that predicts a solution is superseded the moment the solution is written down.** The record keeps L62 in the load-bearing position it held before the certificate existed, and that placement is itself the finding.

## Phase 3, adjudication outcomes

### D6, **withdrawn, and the record's own objection withdrawn with it**

[v73](VERIFY_v73.md) and [v74](VERIFY_v74.md), independently, `SUPPORTED`.

**Six primes are on file**: $1000033$ from the pipeline, $1000003$ from a reviewer's own points and own code, and the four near $2^{40}$ whose stored $40\times47$ dumps each exist **only because that run's rank-$13$ assertion passed first**, the row lift consumes those same files, which is the whole origin of the belief that the four had migrated from a different computation. **And the rank is $13$ exactly over $\mathbb Q$**, which retires the reduction argument outright.

**What survives as a defect is the reverse of the one recorded**: the plural is redundancy rather than breadth (one prime closes the squeeze, and the four share a seed, a point set and a code path) and every citing site leaves the prime unnamed, at six sites. **Applied**; the standing *"unsupported at five sites"* is gone from [sym3-blocks.md](../findings/sym3-blocks.md) and [INDEX-results.md](../findings/INDEX-results.md).

### D2, **withdrawn, with the defence recorded**

[v69](VERIFY_v69.md) and [v70](VERIFY_v70.md), independently, `VALID AS WRITTEN`.

**The defence, which is the strongest case for the text as it stands.** $\mathop{\mathrm{im}}\mu_K$ is a subspace of the $14$-dimensional $(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ and $\mathrm{ANN}$ is its annihilator there, so $\mathrm{rank}=14-\dim\mathrm{ANN}$ is rank–nullity for the adjoint, and $F_5\in\mathop{\mathrm{image}}\iff F_5\perp\mathrm{ANN}$ is the double-annihilator theorem on a space carrying a definite pairing. **The adjunction is the definition of the adjoint rather than an imported theorem**, so it brings no hypotheses of its own.

**One hypothesis is genuinely absent and is true.** Passing from *"$\mathrm{Cat}_F$ kills the invariant Grams"* to $\mathrm{Cat}_F(K,K)=0$ is a Reynolds average, $K$ is an $O(5)$-submodule, $\mathrm{Cat}_F$ is invariant when $F$ is, and an invariant functional vanishing on the invariants vanishes outright. Three lines, needing no positivity.

**And in the record's actual configuration that step is bypassed**: the inclusion $\mathrm{ANN}\subseteq(\mathop{\mathrm{im}}\mu_K)^{\perp}$ is free, $\mathcal A(W_0^6)$ is a nonzero element of $\mathrm{ANN}$, the order-one cap forces the codimension to be at least $1$, and the rank $13$ closes it to exactly $1$, so the two one-dimensional spaces coincide. **The Reynolds route is unconditional where the configuration inherits the rank**, which is the reason to write it down rather than rely on the coincidence.

**Both adjudicators reached the same repair independently, and it is a word.** L59's sentence writes $\mu$ for the restricted map and, one sentence later, for the unrestricted one; crossing them gives $14=13$. **The fix is the word *restricted* in each half, and it moves no number.**

### A process note the round owes itself

**Two adjudicators running concurrently collided over the index.** One committed while the other's report was written and unstaged, sweeping it into a commit whose message names the other verifier. The content is in the repository byte-identical and history was left unrewritten. **This is the hazard the skill names (an unstaged file is swept into whoever commits next), arriving between two agents of one round rather than between two sessions.**

### D5, **withdrawn**

[v71](VERIFY_v71.md) and [v72](VERIFY_v72.md), independently, `VALID AS WRITTEN`. The condition is $p$-integrality, sharper, that a characteristic-zero matrix exists of which the computed one is the reduction. **It holds**: the sample points are `Fraction` coefficients against a rational basis under a fixed seed, drawn before any prime; the pair arithmetic is a ring homomorphism $\mathbb Z[i]_{(p)}\to\mathbb F_p[x]/(x^2+1)$; the one non-obvious division is guarded by the code's own pivot asserts; and the CRT lift rational-reconstructs every entry, exhibiting the rational matrix outright.

### D1, **withdrawn**

[v67](VERIFY_v67.md) and [v68](VERIFY_v68.md), independently, `VALID AS WRITTEN`. **The pipeline's number is not $\mathop{\mathrm{rank}}(\mu_K)$, and the sentence does not claim it is.** It is $\mathop{\mathrm{rank}}_{\mathbb F_p}(\mathrm{ev}_{40}\circ\mu_K)$, and every link moves the way the squeeze needs:

$$13=\mathop{\mathrm{rank}}_{\mathbb F_p}(\mathrm{ev}_{40}\circ\mu_K)\le\mathop{\mathrm{rank}}_{\mathbb Q}\le\mathop{\mathrm{rank}}(\mathrm{ev}_{40}\circ\mu_K)\le\mathop{\mathrm{rank}}(\mu_K)\le13.$$

**The dimension mismatch is real and costs no rank.** For real $v$ a Hermitian form and its real part agree, so the $11$-dimensional $\Lambda^2(K)^{O(5)}$ lies in the kernel and $47=36+11$ leaves the image unchanged.

**And that step is where the round stops rather than closes.** Both adjudicators derived it; **neither derivation enters the record as established.** A verifier that supplies a missing argument hands the record fresh mathematics under the letterhead of a check, so what is filed is a `HYPOTHESIS-DEBT` naming exactly what is owed, $\mathrm{image}(\tilde\mu_K)=\mathrm{image}(\mu_K)$ in the restricted case, the record holding only the unrestricted $89=65+24$, with both derivations on file for whoever proves it.

## Phase 5, what changed

| site | change |
|---|---|
| [sym3-blocks.md](../findings/sym3-blocks.md), [INDEX-results.md](../findings/INDEX-results.md) | the *"four primes unsupported"* objection replaced by what the record holds, cited to the tracked witness rather than the gitignored dumps |
| [results.md](../results.md), [sym3-blocks.md](../findings/sym3-blocks.md), [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) | L59's two uses of $\mu$ separated; **all three copies, one commit** |
| the same three | the rational-points hypothesis stated where the mod-$p$ step is taken |
| [sym3-blocks.md](../findings/sym3-blocks.md) | the block's Gate 2 notes replaced: the value is an exact rank under a derived cap, and the owed hypothesis is named |
| [LEDGER.md](../findings/LEDGER.md) | two *owed* report defects closed, both applied long ago |
| [plan-verification.md](../../plan-verification.md) | L87 entered by transfer, carrying a question and no verdict |

**Deleted, not annotated.** No site keeps the withdrawn objection beside its replacement; the chronology is in [ATTEMPTS.md](../../ATTEMPTS.md).

## Phase 6, verdict

**`PROVEN, hypotheses corrected`**, impact **`CONTAINED`**, with one **`HYPOTHESIS-DEBT`** recorded.

- the cap $\mathop{\mathrm{rank}}(\mu_K)\le13$ is a theorem in six lines;
- the value $13$ is an exact rank under that cap, which is a proof and not a measurement;
- the hypotheses the chain uses are now written into the statement, except the $47\to36$ step, which is owed.

**Verifiers** v64, v65, v66. **Adjudicators** v67, v68 · v69, v70 · v71, v72 · v73, v74, **four pairs, four agreements, four withdrawals.**

### What this round says about the loop

**Every finding fell, and the round was still worth its cost, but not for the reason it was opened.** What it produced was a correction to the record's account of its own evidence, in the direction nobody was looking: a standing objection that was itself wrong, and three "missing" arguments that were present in the report all along.

**The cheap checks outperformed the expensive ones.** Phase 2's whole-record search dissolved three findings for the price of two greps; phase 3 spent eight adjudicators and withdrew four. *The search is cheap because it asks where the argument is, and adjudication is expensive because it asks whether the argument is right, and the first question is the one an unanswered finding usually poses.*

**A brief that names the findings file withholds the report.** Three cold verifiers correctly reported "no argument on file" for material the record does hold, because the file they were given does not hold it. **The brief's file list is a hypothesis about where the argument lives, and it inherits every error in the record's own filing.**

## The debt, narrowed after filing, by the round's own rule, applied to the round

**The `HYPOTHESIS-DEBT` above was filed without running phase 2's second check on it**, which is the failure this round had just finished diagnosing in three verifiers. Searching now:

**[L88](../findings/sym3-blocks.md) carries the restricted count.** Its block states *"unrestricted that is $65$, $24$, $89$; orbit-restricted it is $36$, $11$, $47$, so $47=36+11$ is the same theorem as $89=65+24$, transported through [L86](../findings/sym3-blocks.md)'s parity rule and [L87](../findings/sym3-blocks.md)'s rank-one step"*, under a heading reading **"the $24$ are gauge"**.

**So what is owed is narrower than filed, and it is a transport rather than a theorem.** The gauge claim (that the antisymmetric directions cost no rank), is stated unrestricted; the restricted dimension identity $47=36+11$ is stated; **what no site states is that the gauge property transports with the count**, which is the step $\mathrm{image}(\tilde\mu_K)=\mathrm{image}(\mu_K)$ needs. L88's block asserts the transport in the same sentence as the count and argues it for neither.

**Two further facts about where this sits.** [L88](../findings/sym3-blocks.md) has **no statement in [results.md](../results.md) at all** (a result L62's chain consumes, carried only in a Gate 2 blockquote inside another result's file) and L88's own audit returned `GAP`. **A debt discharged by an unaudited, uncanonicalised block is not discharged**, so the entry stands, narrowed and pointed at the sentence that would close it.

**The rule this round proposes for itself is the one it broke here**: *phase 2's whole-record search runs on the round's own findings too, including one raised in phase 3 and filed in phase 6.*
