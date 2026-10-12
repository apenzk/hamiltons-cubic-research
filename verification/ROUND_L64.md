# Round L64, the transfer mechanism

**Id:** L64 · **Date:** 2026-09-14 · **Verifiers:** v265, v266, v267 · **Brief:** [BRIEF_L64.md](BRIEF_L64.md) · **Logs:** `agent_logs/verify-L64-v265.log`, `agent_logs/verify-L64-v266.log`, `agent_logs/verify-L64-v267.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the statement and proof | [findings/fence-posts.md](../findings/fence-posts.md) line 241, under the heading at line 227 |
| the landscape statement | [results.md](../results.md) line 224 |
| the canonical entry | [results.md](../results.md) line 765 |
| posts F30 and F32 | [findings/fence-posts.md](../findings/fence-posts.md) lines 197-203, 215-225 |
| the Lean file | [L64.lean](../lean/HamiltonsCubic/Results/L64.lean), arithmetic only, the statement not typed |

## The findings from phase 0

**The block is an annotation stack whose notes already say the hypothesis has no instance**: $k_B$ belongs to a module and grows with its degree, only a lower bound is known, and post F30 says no module over $\{O_n\}$ has a finite presentation degree. *The canon states the lemma unqualified.* Brief items 1 and 6.

**The proof beyond one paragraph lives in a script docstring**, which this loop does not read as argument. Brief item 2.

**The notes record that the load-bearing half, an $O(n)$-invariant lift, is unconditional, and that the lift carries an element and never an inequality**, while the canon calls it what would carry a certificate. Brief items 3 and 5.

## Adjudication

**Verdicts: [v265](VERIFY_v265.md), [v266](VERIFY_v266.md), [v267](VERIFY_v267.md) all `PROVEN, hypotheses corrected`. Round verdict: `PROVEN, hypotheses corrected`, narrowed, impact `NARROWS`.** *Unanimous: the three steps follow as written once $k_B$ is read as $k_B(d)$, and every claim the record built around them overstated what they give.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | "$k_B$ the presentation degree of the sequence $\{B_n\}$" | Definition 2.7 gives a presentation degree to a module over a base, and the number depends on the degree $d$ of $F$ | v265 (`GAP`), v266 (`REFUTED AS STATED`), v267 (`GAP`) | **confirmed**, restated as $k_B(d)$ for $\{\mathrm{Sym}^d\mathcal W_n^*\}$ |
| C2 | finiteness of $k_B$ | no finite $k_B(d)$ on file for any $d\ge1$, post F32 closing Theorem 2.11's clauses | v265, v266, v267 (`HYPOTHESIS-DEBT`) | **debt**, stated in the block and routed to Support owed |
| C3 | steps (i) and (ii) | the first fundamental theorem and the padding collapse give an $O(n)$-invariant extension at every $n\ge n_0$ with no hypothesis | v265, v266, v267 (`CONFIRMED`) | **confirmed**, existence stated as part 1 |
| C4 | step (iii) | Proposition 2.9 read at source, used only for injectivity, with uniqueness failing at $n_0=3$, where $\mathcal W_3=0$ | v265, v266, v267 (`CONFIRMED AS ALGEBRA`) | **confirmed**, uniqueness stated as part 2 with the $n_0=3$ edge |
| C5 | "It is an $O(n)$ statement and is FALSE for $SO(n)$" | $\mathrm{diag}(-1,1,\dots,1)\in B_{n_0}$, so an $SO(n_0)$-invariant with a $B_n$-invariant extension is $O(n_0)$-invariant | v265 (`REFUTED`), v266, v267 (`REFUTED AS STATED`) | **confirmed**, replaced by the $SO$ sentence |
| C6 | "The mechanism is what would carry a certificate" | the lift carries an element, and on $\{\mathrm{Sym}^2S^n\}$ $F=\operatorname{tr}X^2-\tfrac14(\operatorname{tr}X)^2\ge0$ at $n_0=4$ lifts to $G(I_5)=-\tfrac54$ | v265 (`GAP`, with the exhibit), v266, v267 (`HYPOTHESIS-DEBT`) | **confirmed**, replaced by the element-transfer paragraph with the exhibit, certificate transfer routed |
| C7 | "whether $k_B$ is small enough to reach $n=12$ is a separate, open question" | $g(d)\ge4d$ by the all-distinct multi-index, so $k_B(6)\ge24>12$ | v267 (`REFUTED AS STATED`), v265 and v266 deriving $k_B(d)\ge4d$ under C1 | **confirmed**, replaced by the lower bound |
| C8 | the Lean file | it types arithmetic, facts about increasing functions on $\mathbb N$ and negation on $\mathbb Q$, and names no Weyl tensor, $B_n$ or extension; the docstrings of `support_forces_degree` and `unbounded` misdescribe their objects | v265, v267 (`REFUTED` that it states L64), v266 (`CONFIRMED AS ALGEBRA`, docstring `REFUTED AS STATED`) | **confirmed**, docstrings repaired, the third form filed in [lean/INDEX.md](../lean/INDEX.md)'s out bucket with its binders |
| C9 | the proof's location | the proof beyond one sentence lived in a script docstring | phase 0 | **repaired**, the three steps written in the block |

**No adjudication pair was spent.** *Every finding is unanimous, and each rests on a closed-form object checked here: the reflection's determinant, $G(I_5)=5-\tfrac{25}4$, the Bianchi sum $1-1+0$ of the four-index tensor, and $\mathcal W_3=0$.*

### Withdrawn

- **v266: F30's "no nonzero module over $\{O_n\}$" as a $d=0$ counterexample.** Withdrawn because the source leaves open whether $\mathbb N$ contains $0$.
- **v266: the lift's coefficients depending on $n$, and the module condition unchecked.** Withdrawn, the contractions being dimension-free and padding a morphism.
- **v266: $\sum_{i,j,k,l\text{ distinct}}W_{ijkl}^2$ as a non-$O(4)$ extension at $n_0=3$.** Withdrawn, non-proportionality to $\lvert W\rvert^2$ not settling $O(4)$-invariance.

### A strengthening not adopted

**All three note that step (iii) uses only injectivity of restriction on invariants, which Proposition 2.3 gives from the generation degree $g(d)\le k_B(d)$.** *That would weaken the hypothesis to $n_0\ge g(d)$. It is an argument the block does not carry, so it stays out of the record until the research loop writes it, and it does not reach $n_0=12$, since $g(6)\ge24$.*

### Dependents

- **Post F32**, a copy of the statement with bare $k_B$ and the script as its proof. **Corrected**: it now points at the lemma with $k_B(d)$, and its closing sentence, *"$24$ is removed as a proved lower bound on the base, for either route"*, reads that the invariant dimension is stationary from $12$ and $24$ bounds the presentation degree the uniqueness clause assumes.
- **[sym3-stability.md](../findings/sym3-stability.md) line 54**, a pointer to the block. **SURVIVES**, the address being right.
- **Post F31**, the balanced-product instance of element transfer. **SURVIVES**, and the block now cites it.
- **The report's figures**, *"it moves an element, never an inequality, and $k_B\ge24$ (L64)"*. **SURVIVES**, both clauses being what the corrected block states.

**Impact `NARROWS`**: the canon's certificate clause and its open question are narrowed to what the steps give, and no dependent used either as a premise.

### What changed

- [fence-posts.md](../findings/fence-posts.md): the annotation stack replaced by the setting, the two-part lemma, its proof, its scope and the $\mathrm{Sym}^2S^n$ exhibit. Post F32's copy and closing sentence corrected.
- [results.md](../results.md): the landscape and detail entries restated.
- [L64.lean](../lean/HamiltonsCubic/Results/L64.lean): the docstrings of the header, `counts_disagree`, `support_forces_degree`, `overstatement_factor` and `unbounded` rewritten to the objects they concern. [lean/INDEX.md](../lean/INDEX.md): the row rewritten, and L64's statement filed under *out*.
- [ATTEMPTS.md](../ATTEMPTS.md): the removed block and the two replaced sentences, quoted.
- [plan-verification.md](../plan-verification.md): the verdict, and a Support owed row for $k_B(d)$ and certificate transfer.
