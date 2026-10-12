# Round L94, $\kappa^2\le2\lVert M\rVert_F^2$, with equality exactly when $W$ is coordinate-diagonal in some frame

**Id:** L94 · **Date:** 2026-09-14 · **Verifiers:** v250, v251, v252 · **Brief:** [BRIEF_L94.md](BRIEF_L94.md) · **Logs:** `agent_logs/verify-L94-v250.log`, `agent_logs/verify-L94-v251.log`, `agent_logs/verify-L94-v252.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the statement | [findings/bispectral.md](../findings/bispectral.md) line 217 |
| the per-frame form and proof | [findings/bispectral.md](../findings/bispectral.md) lines 480, 484, 493, inside L54's block |
| the Lean statement and proof | [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean), no `sorry` |

## The findings from phase 0

**L94 has no canonical entry in [results.md](../results.md)**, and its block writes no proof: the one-line proof is in [REVIEW_r101](../reviews/REVIEW_r101.md) and [REVIEW_r102](../reviews/REVIEW_r102.md) alone, the orthogonal conjugation $M(F)=\Lambda^2(F)M\Lambda^2(F)^{\mathsf T}$ bounding its squared diagonal by $\lVert M\rVert_F^2$.

**The per-frame form is now proved twice on file**: in prose as [L54](ROUND_L54.md)'s audited step (3), and in Lean, [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) discharged this session, using only the pair antisymmetries.

**Attainment of $\max_F$ is what the consumers need and what no findings passage argues.** [L174](../findings/second-order.md) uses $\kappa^2=2$ to produce a diagonalising frame, which needs the maximum attained; the Lean file states the equality clause over frames and so does not type it. Brief item 2.

**Consumers**: [L174](../findings/second-order.md), [Corollary L176.3](../findings/diagonal-half.md), [conventions.md](../findings/conventions.md)'s $t,\kappa$ row, and [L54](../findings/bispectral.md).

## Adjudication

**Verdicts: [v250](VERIFY_v250.md), [v251](VERIFY_v251.md), [v252](VERIFY_v252.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED`.** *Unanimous: the per-frame bound, its equality case, the $\kappa$ bound and the direction from coordinate-diagonal to equality are proved on file and in Lean, using only the pair antisymmetries; the converse needs the maximum over frames attained, and nothing on file argued it.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | $\kappa^2=2\lVert M\rVert_F^2\Rightarrow$ coordinate-diagonal in some frame | needs $\max_Ft_F$ attained; argued in no quoted passage | v250, v251, v252 | **debt, discharged** |
| C2 | the Lean equality clause against the $\kappa$ form | states existence of an attaining frame, never `kappaSq W = 2 * normM2 W` | v251, v252 (`GAP`); v250 (`CONFIRMED AS ALGEBRA`) | **confirmed, discharged**: `kappaSq_eq_iff` |
| C3 | "$\kappa$ is $O(n)$-invariant" | asserted in the block's review paragraph, used by nothing | v251, v252 | **dropped** with that paragraph |
| C4 | L94 has no canonical entry and its block writes no proof | the proof lived in two reviewer reports | phase 0; all three | **repaired**: statement and proof in the block, landscape and detail entries in [results.md](../results.md) |
| C5 | [lean/axioms.json](../lean/axioms.json) still lists `sorryAx` for the lemma | the audit file predates the discharge | v252 | **confirmed**, left for the next axiom audit run, which regenerates it |

**No adjudication pair was spent.** *C1 and C2 are one debt, discharged by a kernel-checked argument; C3 to C5 are text and bookkeeping.*

### The discharge

**Attainment is proved in [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean)**: the frame set is closed and bounded, hence compact (`frames_compact`), $F\mapsto t_F$ is continuous (`frobK_continuous`), so the supremum is attained (`kappaSq_attained`), and `kappaSq_eq_iff` states the record's $\kappa$ form, axioms `propext`, `Classical.choice`, `Quot.sound`. **The prose proof in [bispectral.md](../findings/bispectral.md) is that argument in words, resting its per-frame half on [L54](ROUND_L54.md)'s audited step (3).** *The new Lean statement uses the same `frobK`, `normM2`, `kappaSq` and `CoordinateDiagonal` all three verifiers matched against the record, so the comparison a single reviewer would make is the one they already made.*

### Dependents

- **[L174](../findings/second-order.md) SURVIVES**, and its use of attainment is now proved rather than attributed to reviewer reports.
- **[Corollary L176.3](../findings/diagonal-half.md)** and [conventions.md](../findings/conventions.md)'s $t,\kappa$ row survive; both use the bound and equality case as now stated.
- **[L54](../findings/bispectral.md)** survives; its step (3) is the per-frame half of this proof.
