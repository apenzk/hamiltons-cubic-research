# Review r1512: L81's criterion fails at m = 3 (commit 950f4f06)

*Gate 2, one reviewer, Lean layer. Subject: [L81Three.lean](../lean/HamiltonsCubic/Results/L81Three.lean) (`two_le_finrank`, `L81_fails_three`) and the records that commit 950f4f06 rewrote to mark Lemma L81 **proved**. Analysis only: the one build and the axiom audit were run, nothing numerical.*

| item | claim | verdict |
| --- | --- | --- |
| A | `L81_fails_three` is what the record means by "the criterion fails at m = 3" | **CONFIRMED WITH GAP** |
| B | the file builds, carries no `sorry`, and rests on the standard three axioms | **CONFIRMED** |
| C | the L81 main row and INDEX-results row 81 are justified in reading **proved** | **CONFIRMED WITH GAP** |
| D | the edited text and docstrings meet the style rules | **CONFIRMED WITH GAP** |

**Summary: the failure at m = 3 is proved and is what the record means, but the record's value 3 at m = 3 stays untyped, and L81Statement.lean still says the >1 half is absent.**

## A. Statement fidelity

- The record ([isotropy-cap.md:346](../findings/isotropy-cap.md)) says the criterion holds *"failing at $m=3$ and nowhere else"*, and its witness ([isotropy-cap.md:356](../findings/isotropy-cap.md)) says the forward direction of the iff fails at $e_{12}\in\mathfrak{so}(3)$ because the dimension is $3>1$ while $x$ is no multiple of a rank-$4$ complex structure. Failure of the forward direction needs exactly two facts: $\dim>1$ and $\neg$`MultipleOfRankFour`. `L81_fails_three` proves both, at every nonzero skew $x$ on $\mathbb R^3$, which is stronger than the record's single witness.
- So $\ge2$ is enough for the failure claim. The record does claim the value is exactly $3$ there (line 356, and line 346's *"the value being always $1$ or $3$"*), and the Lean gives only $\ge2$.
- **Gap A-1** ([isotropy-cap.md:346](../findings/isotropy-cap.md), [isotropy-cap.md:356](../findings/isotropy-cap.md)): the value $3$ at $m=3$ is untyped. It does not affect whether the criterion fails. It does leave the *"always $1$ or $3$"* clause proved only at $m\ne3$ (L81Proof.lean's `L81`), and the $m=3$ reading of that clause has no Lean counterpart. The step is short: [L160.lean:127](../lean/HamiltonsCubic/Results/L160.lean)'s `cc_three` gives $\mathfrak c=0$, so `zPerp x` is all of $\mathfrak{so}(3)$.
- Object satisfying the hypotheses: $x=e_{12}$, the $3\times3$ matrix with $x_{01}=1$, $x_{10}=-1$ and zeros elsewhere. It is `Skew` and nonzero. Here $\mathfrak c=0$, `zPerp x` is $\mathfrak{so}(3)$ of dimension $3$, and $x$ has rank $2$, so both conjuncts hold.
- The proof is sound as read. `L160_three` supplies $y\in$ `zPerp x` and $z$ with $xz=0$, $yz\ne0$. Applying $g_0x+g_1y=0$ to $z$ gives $g_1=0$, then $g_0=0$ from $x\ne0$, so $\{x,y\}$ is independent in `zPerp x`.

## B. Proof soundness

- `lake build HamiltonsCubic.Results.L81Three` completed successfully (8712 jobs). The only output beyond that is two `longLine` linter warnings (see D-2).
- `grep` finds no `sorry`, `native_decide` or `axiom` in the file.
- `axiom_audit.py --only L81Three`: *"2/2 clean -- resting on the standard three alone"*.
- The file is imported from [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean), so the full build covers it.

## C. Records

- **"Proved" is justified for the criterion.** The old row's owed items were *"the criterion itself"* and *"that it fails at $m=3$"*. The first is L81Proof.lean's `L81` at every $m\ne3$ (both clauses), and the second is `L81_fails_three`. At $m\in\{0,1\}$ `L81` is vacuous, since no nonzero skew matrix exists there, which matches the record.
- The kept "earlier account" at [lean/INDEX.md:413](../lean/INDEX.md) does not contradict the new status. It describes the three refutations carried in L81.lean, it has lost its **Owed** clause, and the new lead-in says the proofs discharge what it owed. Row 81 of [INDEX-results.md:95](../findings/INDEX-results.md) links the statement, the proof and L81Three.lean, and ends with its closing pipe, as does the lean/INDEX.md row.
- **Gap C-1** ([L81Statement.lean:62](../lean/HamiltonsCubic/Results/L81Statement.lean) to 66): the "What is NOT typed here" section still says the $m=3$ witness is absent except the half showing $x$ is no rank-$4$ complex structure. After this commit the $>1$ half is typed in L81Three.lean, and only the exact value $3$ remains absent. The docstring at [L81Statement.lean:182](../lean/HamiltonsCubic/Results/L81Statement.lean) also asserts *"where the dimension is $3$"* with no proof behind it anywhere in the layer.
- **Gap C-2** ([lean/INDEX.md:413](../lean/INDEX.md)): the row reads **proved** and says the proofs discharge the owed clauses, while the value $3$ at $m=3$ (A-1) is still untyped. Either the row names it as the one residue, or the step through `cc_three` is added. The root-theoretic content listed as untyped in L81Statement.lean is a proof method rather than a claim, so it does not count against **proved**.

## D. Style

- No em dash in L81Three.lean or in either rewritten row. No backticks inside markdown link text. The rows are single lines and the docstrings are Lean comments, so hard-wrapping does not apply to them.
- The new text contains no semicolon splice. The two semicolons in L81Three.lean (lines 39 and 48) are Lean tactic separators.
- **Gap D-1** ([lean/INDEX.md:413](../lean/INDEX.md), [INDEX-results.md:95](../findings/INDEX-results.md)): both rewritten rows keep an older semicolon splice, *"silent at every odd dimension; and $B_p\ne D_p$"* and *"Nothing consumes this lemma; the apparent citation count was line anchors"*. The splices predate this commit, but the commit rewrote both rows and left them in.
- **Gap D-2** ([L81Three.lean:34](../lean/HamiltonsCubic/Results/L81Three.lean), [L81Three.lean:44](../lean/HamiltonsCubic/Results/L81Three.lean)): two lines exceed 100 characters and the build emits `linter.style.longLine` warnings. L81Statement.lean turns that linter off and L81Three.lean does not.
