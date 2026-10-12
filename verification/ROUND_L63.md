# Round L63, the $n=12$ block table

**Id:** L63 · **Date:** 2026-09-14 · **Verifiers:** v262, v263, v264 · **Brief:** [BRIEF_L63.md](BRIEF_L63.md) · **Logs:** `agent_logs/verify-L63-v262.log`, `agent_logs/verify-L63-v263.log`, `agent_logs/verify-L63-v264.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the statement | [findings/sym3-stability.md](../findings/sym3-stability.md) line 58, under the heading at line 44 |
| the landscape statement | [results.md](../results.md) line 222 |
| the canonical entry | [results.md](../results.md) line 759 |
| the section the pointer names | [findings/sym3-stability.md](../findings/sym3-stability.md) lines 3-36 |
| the Lean statement | [L63Statement.lean](../lean/44amiltonsCubic/Results/L63Statement.lean), no `sorry`, the census untypeable |

## The findings from phase 0

**The census is a decomposition run.** $77$, $191$ and the six chiral pairs appear in no argument on file; the section the block points at proves stability of the table for $n\ge12$, and its verification table reports computations. *The canon still labels the whole result a `Lemma`; the block's own Gate 2 note already graded the census an `Observation`.* Brief items 2 and 5.

**The pointer names a section proving a different statement**, and [report/](../report/)'s diagram glosses L63 as that stability statement. Brief item 5.

**The derivable half is $\dim\mathcal W_{12}=1638$ at $(2,2,0,0,0,0)$**, typed in Lean by two closed forms.

## Adjudication

**Verdicts: [v262](VERIFY_v262.md), [v263](VERIFY_v263.md), [v264](VERIFY_v264.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, narrowed and relabelled, impact `NARROWS`.** *Unanimous: the dimension and every piece of arithmetic check by hand; the census that is the statement's substance rests on program runs.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | $\dim\mathcal W_{12}=1638$, $\binom{1640}3$ | both closed forms and the binomial by hand | v262, v263, v264 | **confirmed**, kept as the Lemma |
| C2 | highest weight $(2,2,0,0,0,0)$ | only a dimension match on file, which cannot pin a module; no filed source | v262, v264 (`HYPOTHESIS-DEBT`), v263 (`GAP`) | **debt**, named in the block and routed |
| C3 | the census $77/191$ and the chiral pairs | program runs only; the canon's `Lemma` label overclaims | v262, v263, v264 | **confirmed**, relabelled `Observation` |
| C4 | the fusion $77\to71$, $191\to184$ | exact given the census, and needs no non-chiral constituent to occur as both $[\lambda]$ and $[\lambda]\otimes\det$ | v262, v263, v264 | **confirmed**, the hypothesis written in |
| C5 | the pointer to the stability section | that section proves stability for $n\ge12$ and none of the figures | v262, v263, v264 | **confirmed**, the pointer replaced by that statement |
| C6 | "$\lambda$ and its associate become the same $O(10)$ irreducible" | under the filed labelling distinct admissible labels are distinct $O(10)$ irreducibles, $\Lambda^4$ and $\Lambda^6$ of $\mathbb C^{10}$ separated by a reflection's trace $\pm42$ | v262, v264 (`REFUTED AS STATED`), v263 (withdrawn as wording) | **confirmed as stated**, rewritten as $SO(10)$-level merges |
| C7 | "$\dim\mathcal W_4=10=n$" | garbled | v264; v262, v263 (withdrawn as typo) | **repaired** |
| C8 | the Lean docstring's "pins the label" | a dimension cannot pin a highest weight | v262, v263, v264 | **routed** to the Lean layer's next pass |

**No adjudication pair was spent.** *Every finding is unanimous or a wording split settled by the filed source.*

### Dependents

**The certificate route's sizing sentences** read the table as its size at the threshold dimension; they survive with the census at `Observation`, which is what a size estimate needs.
