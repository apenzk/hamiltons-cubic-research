# REVIEW r1526: L120's dimension count in Lean, `choose_four_cast`, `choose_two_cast`, `L120_dim_sum` (commit 309f1067)

Log [agent_logs/r1526.log](../agent_logs/r1526.log). One reviewer, working cold, Gate 2 on the Lean layer. Analysis-only: `lake build HamiltonsCubic.Results.L120Dim` and `scripts/misc/axiom_audit.py --only L120Dim`, plus hand checks of the identity at small $n$. No numerical run. Record: [findings/second-order.md](../findings/second-order.md) Lemma L120 (lines 1017 to 1031), and the closed form $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ as quoted at [findings/bounds.md](../findings/bounds.md) line 325, [findings/problem.md](../findings/problem.md) line 156 and [findings/sym3-stability.md](../findings/sym3-stability.md) line 48. Lean: [L120Dim.lean](../lean/HamiltonsCubic/Results/L120Dim.lean). Citing line: the L120 row of [lean/INDEX.md](../lean/INDEX.md), line 455.

**Standfirst.** The file builds (8706 jobs), all three declarations rest on the standard three axioms (3/3 clean), and there is no `sorry` and no `native_decide`. **`L120_dim_sum` is the right bookkeeping identity**: one summand of dimension $2$ per four-set, $\binom n4$ of them, one of dimension $n-3$ per pair, $\binom n2$ of them, and $\mathcal D_n$ of dimension $\binom n2-n=n(n-3)/2$, summing to the record's closed form. Both cast lemmas are right at every $n$, including $n<4$, where each side vanishes by a zero factor. **The gaps are in what the prose around the identity reads into it.** The record itself grades this identity as *"transcription insurance and nothing more"* ([second-order.md](../findings/second-order.md):1031), since it tests block totals only. The Lean docstring and the INDEX row present it as the summands *exhausting* $\mathcal W_n$ and leaving *"no room for a fourth summand"*, which follows only from the owed identification. And the row's owed clause dropped *"with the stated dimensions"*, although no single summand's dimension is proved.

| Item | Verdict | Reason |
| --- | --- | --- |
| A-1. `L120_dim_sum` is the right identity | CONFIRMED | $\tfrac{n(n-3)}2+2\binom n4+(n-3)\binom n2=\tfrac{n(n+1)(n+2)(n-3)}{12}$ is the record's display at second-order.md:1031, with $\binom n4$ counting four-sets and $\binom n2$ counting pairs as in the decomposition at line 1020. Hand checks: $n=4$ gives $2+2+6=10$, $n=5$ gives $5+10+20=35$, both the RHS. |
| A-2. `choose_four_cast`, `choose_two_cast` at every $n$ | CONFIRMED | $n<4$ closed by `interval_cases` and `simp`, both sides $0$. $n\ge4$ through `Nat.descFactorial_eq_factorial_mul_choose`, a correct route. `choose_two_cast` is Mathlib's `Nat.cast_choose_two`. The subtractions are in $\mathbb Q$, since the expected type is $\mathbb Q$. |
| A-3. Says only what it claims | CONFIRMED WITH GAP | The theorem is a polynomial identity over $\mathbb Q$ and claims nothing more. The docstring at L120Dim.lean:10 draws *"no room for a fourth summand"* from it, and :36 names the RHS `dim 𝒲ₙ`, which no Lean object carries. |
| B. Soundness | CONFIRMED | Build clean, 3/3 on the standard three axioms, no `sorry`, no `native_decide`. |
| C-1. Row's headline | CONFIRMED WITH GAP | *"The stated dimensions exhaust $\mathcal W_n$"* at lean/INDEX.md:455 reads as a subspace statement. The record calls the identity transcription insurance, and the row does not say so. |
| C-2. Row's owed clause | CONFIRMED WITH GAP | The owed clause now reads *"that each isotypic subspace is the named summand"*, where the previous row read *"with the stated dimensions"*. No summand's dimension is proved, only their sum. |
| C-3. Range of the dimension reading | CONFIRMED WITH GAP | The row says *"at every $n$"*. As a polynomial identity that is right. As a dimension count it holds for $n\ge3$ only: at $n=2$ both sides are $-2$. |
| D. Style | CONFIRMED | No em dashes in the file or the row, no backticks in link text, the row closes with a pipe. The semicolons in the row's new sentence introduce fragments in the row's established pattern, and those in the docstring separate list items. |

**Summary: CONFIRMED WITH GAP. The identity and both cast lemmas are right and axiom-clean, and the docstring and INDEX row read a sum-of-dimensions check as exhaustion of $\mathcal W_n$, which the record itself calls transcription insurance.**

## A. Fidelity

The decomposition at [second-order.md](../findings/second-order.md):1020 is $\mathcal D_n\ (n(n-3)/2)\oplus\bigoplus_{\{i,j,k,l\}}V_{ijkl}\ (2)\oplus\bigoplus_{\{j,k\}}V_{jk}\ (n-3)$. The index sets are unordered four-sets and unordered pairs, so the multiplicities are $\binom n4$ and $\binom n2$, and the proof of the decomposition at line 1025 agrees: $\binom n2$ diagonal entries cut by $n$ row sums, three pairings per four-set cut to two, $n-2$ elements per pair cut to $n-3$. `L120_dim_sum` at [L120Dim.lean](../lean/HamiltonsCubic/Results/L120Dim.lean):37 transcribes that sum against the closed form the record quotes for $\dim\mathcal W_n$ (bounds.md:325, problem.md:156, sym3-stability.md:48). The record's own factorisation, $\tfrac{n(n-3)}2[1+\tfrac{(n-1)(n-2)}6+(n-1)]$, confirms it independently.

`choose_four_cast` (:21) holds at $n=0,1,2,3$ because $n(n-1)(n-2)(n-3)=0$ there, and `interval_cases` closes those four cases. For $n=m+4$ the proof reads $(m+4)^{\underline 4}=4!\binom{m+4}4$ and divides. `choose_two_cast` (:33) is `Nat.cast_choose_two`, which is exactly $\binom n2=n(n-1)/2$ in any division ring of characteristic zero.

**Gap A-3.** [L120Dim.lean](../lean/HamiltonsCubic/Results/L120Dim.lean):10 says the dimensions add up, *"so the three families leave no room for a fourth summand"*. That inference needs the three families to be independent subspaces of $\mathcal W_n$ with the stated dimensions, which lines 15 to 16 of the same docstring correctly declare owed. As written, line 10 draws the conclusion before the caveat. And :36 titles the theorem *"sum to `dim 𝒲ₙ`"* although its RHS is a polynomial, with no `finrank` of a Lean Weyl space on either side. The nearest Lean object, `finrank_weylT_ge` in [L17WeylDim.lean](../lean/HamiltonsCubic/Results/L17WeylDim.lean), is a lower bound on a tangent slice and is not connected.

## B. Soundness

`lake build HamiltonsCubic.Results.L120Dim`: *Build completed successfully (8706 jobs)*. `axiom_audit.py --only L120Dim`: *3/3 clean, resting on the standard three alone*. Grep of the file finds no `sorry`, `native_decide` or `axiom`.

## C. Records

**Gap C-1.** [lean/INDEX.md](../lean/INDEX.md):455 opens the new sentence *"The stated dimensions exhaust $\mathcal W_n$"*, and the commit subject says the same. The record states the identity at [second-order.md](../findings/second-order.md):1031 and grades it *"transcription insurance and nothing more"*, because it *"tests the three block totals only, is blind to which relation cut each block, and holds verbatim at $n=4,6,8$ where the isotypic claim fails"*. The row should say the identity is the record's consistency check, now kernel-checked, and not a statement about subspaces.

**Gap C-2.** The owed clause at [lean/INDEX.md](../lean/INDEX.md):455 changed from *"that the isotypic subspaces are the record's $\mathcal D_n$, $V_{ijkl}$ and $V_{jk}$ with the stated dimensions"* to *"that each isotypic subspace is the named summand, which needs bases of $\mathcal W_n$ by sign character"*. The individual dimensions $n(n-3)/2$, $2$ and $n-3$ are still unproved, since a sum identity fixes none of them. The dropped phrase is still owed.

**Gap C-3.** The row's *"at every $n$"* is right for the identity and wrong for its reading as dimensions below $n=3$, where the RHS is negative ($-2$ at $n=2$, $-1$ at $n=1$). The record's range for L120 is $n\ge4$ in practice. A scope of $n\ge3$ on the dimension reading would make the row exact.

The rest of the row, the block-diagonality text and r1441's gap, is unchanged by this commit and still accurate.

## D. Style

No em dash in [L120Dim.lean](../lean/HamiltonsCubic/Results/L120Dim.lean) or in the row, no backticks inside link text, the row ends `**statement: not typed** |`. No clause splice found.
