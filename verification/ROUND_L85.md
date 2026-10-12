# Round L85, the degree-six invariant count on W_5

**Id:** L85 · **Date:** 2026-09-14 · **Verifiers:** v293, v294, v295 · **Brief:** [BRIEF_L85.md](BRIEF_L85.md) · **Logs:** `agent_logs/verify-L85-v293.log`, `agent_logs/verify-L85-v294.log`, `agent_logs/verify-L85-v295.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and argument | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 52, 66-71 |
| the canon | [results.md](../results.md) lines 288 and 956 |

**Withheld**: the Gate 2 stack under the heading, [L85.lean](../lean/HamiltonsCubic/Results/L85.lean), whose docstring quotes the audit, and every index row.

## The findings from phase 0

**The count is a single script's output**, and the canon heading carries lowercased LaTeX. Brief items 1 and 3.

## Adjudication

**Verdicts: [v293](VERIFY_v293.md), [v294](VERIFY_v294.md), [v295](VERIFY_v295.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, relabelled `Observation`, impact `NARROWS`.** *Unanimous on every cluster.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ | a script's output, no argument on file | v293, v294, v295 (`HYPOTHESIS-DEBT`) | **confirmed**, relabelled `Observation`, routed to Support owed |
| C2 | connected-group Weyl integration applied to $O(5)$ | the step to $O(5)$ is unwritten; it holds at odd $n$ since $-I$ acts by $(-1)^4$, and fails at $n=4$, where $\lvert W^+\rvert^2-\lvert W^-\rvert^2$ is $SO(4)$- and not $O(4)$-invariant | v293, v294 (`GAP`), v295 (`HYPOTHESIS-DEBT`, dischargeable) | **settled inline**, the one line written in |
| C3 | "three hand-checkable rungs", "three hand checks" | never named or written, only degree $2$ argued | v293, v294, v295 (`HYPOTHESIS-DEBT`) | **removed** from the heading and canon |
| C4 | "every entry is strictly smaller" | equal at degree $2$ | v293, v294, v295 (`REFUTED AS STATED`) | **corrected** |
| C5 | the degree-$3$ to $6$ values, the stable range, "which is the syzygies" | script-only values, unsourced stable range, the fundamental theorems unstated | v293, v294, v295 (`HYPOTHESIS-DEBT`) | **restated** as the script's sequence and unsourced values; the syzygy clause removed |
| C6 | "degree $3$ being $1$ reproduces the Lovelock collapse by a method sharing nothing" | independence asserted, and a count recovers a dimension drop and not the identity | v293, v294 (`HYPOTHESIS-DEBT`), v295 (`CONFIRMED AS ALGEBRA`, conditional) | **narrowed** to agreement with the Lovelock relation |
| C7 | the canon's degree-two clause and "measured rather than derived" | direct | v293, v294, v295 (`CONFIRMED`) | **kept** |

**No adjudication pair was spent.**

### Withdrawn

- **v293, v294: "at every $n$" failing at $n\le3$.** The reason assumes $\mathcal W_n\ne0$; the block now says $n\ge4$.
- **v293: a difference between the $O(5)$ and $SO(5)$ counts.** There is none, which C2 now states.

### Dependents

- **[sym3-blocks.md](../findings/sym3-blocks.md)'s L89**, whose nullity $51=65-14$ reads the $14$, and **L91**, whose space $V$ is fourteen-dimensional. **NARROWED**, both resting on an `Observation`; both are queued in the candidate class.
- **L59 and L62**, closed earlier, were recorded as resting on the $14$. **Mentions here**: their statements carry the count as a parameter.
- **The report's full DAG** marks the node `L85.O`.

**Impact `NARROWS`.**
