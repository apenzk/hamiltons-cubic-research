# Round L54, the two diagonals, and rigidity at $t=2$

**Id:** L54 · **Date:** 2026-09-14 · **Verifiers:** v245, v246, v247 · **Brief:** [BRIEF_L54.md](BRIEF_L54.md) · **Logs:** `agent_logs/verify-L54-v245.log`, `agent_logs/verify-L54-v246.log`, `agent_logs/verify-L54-v247.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the findings statement | [findings/bispectral.md](../findings/bispectral.md) lines 478 and 480, under the heading at line 476 |
| the landscape statement | [results.md](../results.md) line 330 |
| the canonical entry | [results.md](../results.md) line 1082 |
| the identification paragraph | [findings/bispectral.md](../findings/bispectral.md) line 259 |
| L94's statement, as a given | [findings/bispectral.md](../findings/bispectral.md) line 217 |
| definitions | [findings/bispectral.md](../findings/bispectral.md) lines 15 and 75 |
| the Lean statement | [L54Statement.lean](../lean/HamiltonsCubic/Results/L54Statement.lean), one `sorry` |

## The findings from phase 0

**The identification of the two diagonals rests on a numerical check.** The paragraph the block points at establishes that the $\varphi$-diagonal of $\mathring W$ is $K$ and its $\psi$-block is $-K\vert_{\mathbf1^\perp}$ by evaluation at random tensors, to $2\times10^{-16}$, and calls that identification the only justification $\omega\succ d$ has. Brief item 1.

**The given L54 needs is not the given on file.** [L94](../findings/bispectral.md)'s block is a heading plus a Gate 2 sentence saying both reviewers proved the equality case in one line, with no proof written; it is about $\kappa=\max_F$ with equality in some frame, while L54 uses $t_F\le2$ per frame with equality in that frame. **L94 has had no verification round, and [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) is one `sorry` for the whole lemma**, while L54's Lean docstring says L94 is "proved there". Brief item 4.

**The canonical landscape says "coordinate-diagonal in some frame"** where the findings form says "in that frame". Brief item 7.

**The rigidity `sorry` in the third form is the strict Schur step**, majorization plus equal $2$-norms giving equal sorted vectors, which the session judged a multi-hour Lean build for want of sorting machinery and left.

## Adjudication

**Verdicts: [v245](VERIFY_v245.md) `HYPOTHESIS-DEBT`, [v246](VERIFY_v246.md) and [v247](VERIFY_v247.md) `GAP`.** *Unanimous on every claim: nothing in the findings form is false, and six steps had no argument on file.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the $\varphi$-diagonals of $\mathring W$ and $M$ are $K$ | Nienhaus–Petersen–Wink Prop. 3.10 read at source; Li's definition | v245, v246, v247 | **confirmed** |
| C2 | the $\psi$-block of $\mathring W$ is $-K$ on $\mathbf1^\perp$ | only a floating-point check on file | v245, v246, v247 | **debt**, discharged by polarising the file's own diagonal quadratic form |
| C3 | $\sum d^2=\tfrac32t$ | needs $K\mathbf1=0$, from $W$ Weyl, stated nowhere | v245, v246, v247 | **debt**, discharged as step (0) |
| C4 | $t_F\le2$ per frame with equality "in that frame", cited to L94 | L94's statement is over all frames with equality in some frame; rotated-frame witness at $n=4$; L94 has no proof on file and its Lean statement is a `sorry` | v245 (`HYPOTHESIS-DEBT`), v246, v247 (`GAP`) | **confirmed**, discharged as the per-frame Frobenius bound, step (3) |
| C5 | rigidity at $t_F=2$ | the rigidity lemma cited nowhere; $\sum\omega^2=3\lVert M\rVert_F^2$ derived nowhere in the brief | v245, v246, v247 | **debt**, discharged by an Abel-summation proof and L50's normalisation |
| C6 | the vectors agree, "by Cauchy–Schwarz" | no Cauchy–Schwarz written; block-diagonality asserted | v245, v246, v247 | **debt**, discharged by the entries of $\mathring W$ at a coordinate-diagonal $W$ |
| C7 | the landscape canon | "the NPW basis" gives $\sum d^2=\tfrac32$ at $t_F=2$; "coordinate-diagonal in some frame" fails in a rotated frame | v245, v246, v247 | **confirmed**, rewritten |
| C8 | the canon's closing sentence on L52's coupling | not argued here | v245 | **confirmed**, dropped |
| C9 | the staircase remark's stated reason | "fixed by the frame" does not give "never diagonal" | v245 (`GAP`) | **confirmed**, replaced by the witness |
| C10 | Lean docstrings | "L94 proved there" false; no `t_F\le2` binder exists; the $n=2$ witness is no Weyl tensor | v245, v246, v247 | **confirmed**, corrected |

### Phase 5, a repair, and it is new text

**Every debt is discharged by a written proof** now in [bispectral.md](../findings/bispectral.md), each step resting on a statement already audited (L52, L50, the diagonal quadratic form) or proved in the block. *A repair is new mathematics, so it goes to two fresh verifiers before the round closes*: [v248](VERIFY_v248.md) and [v249](VERIFY_v249.md) on [BRIEF_L54_repair.md](BRIEF_L54_repair.md).

### The repair audit

**[v248](VERIFY_v248.md) and [v249](VERIFY_v249.md), both `PROVEN`**, every numbered claim and every proof step `CONFIRMED`, all candidates withdrawn under the three-step protocol. *Both read Li's bilinear-form definition at source for the self-adjointness the polarisation and Schur's theorem use, both rebuilt the $n=4$ witness ($K$ Weyl, $\lVert M\rVert_F=1$, $t_F=2$, staircase $d_\psi=(0,-\tfrac12,\tfrac12)$), and both found Nienhaus–Petersen–Wink Proposition 3.10 printing the staircase coefficient as $-k$ where $-(n-k)$ is meant, which does not reach L54.*

**Round verdict: `GAP`, repaired, impact `CONTAINED`.** *The mathematics was right and six of its steps were argued nowhere; each is now written and audited. No dependents.*

**Still owed, and small**: Schur's majorization theorem (1923) is cited and not filed under [references/](../references/). *v249's three canon wording notes are applied*: the majorizations follow from Schur and not from the block form, the $\Lambda^2$ basis is the pair basis, and the convention is Li's.
