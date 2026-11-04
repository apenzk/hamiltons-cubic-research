# Round L115, lambda_max(M) = theta at maximisers and the by-product

**Id:** L115 · **Date:** 2026-09-14 · **Verifiers:** v355, v356, v357 · **Brief:** [BRIEF_L115.md](BRIEF_L115.md) · **Logs:** `agent_logs/verify-L115-v355.log`, `agent_logs/verify-L115-v356.log`, `agent_logs/verify-L115-v357.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and the lemma | [findings/bounds-relaxations.md](../findings/bounds-relaxations.md) lines 268, 284-290, 292-294 |
| the definition of $M$ | [findings/second-order.md](../findings/second-order.md) lines 532-548 |
| L24, given | [findings/second-order.md](../findings/second-order.md) lines 55, 61, 63 |
| the Lean files | [L115.lean](../lean/HamiltonsCubic/Results/L115.lean), [L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean), declarations only |

**Withheld**: the Gate 2 stack under the L115 heading (lines 270-282), both Lean module docstrings and theorem docstrings, the report copy at [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) lines 1293-1299, and every index row.

## The findings from phase 0

**The numbered heading states the equality at every global maximiser, while its own display restricts it to the coordinate-diagonal locus and $S^m\times S^m$ and calls the unrestricted form not citable.** **The block's statement sits under two later headings.** **The report copy already carries a corrected account**, so the report and the findings file disagree. **No results.md entry exists.** Brief items 1, 3 and 6.

## Phase 2, clustering

**Verdicts: [v355](VERIFY_v355.md), [v356](VERIFY_v356.md), [v357](VERIFY_v357.md) all `GAP`.**

| id | step attacked | mechanism | support | route |
| --- | --- | --- | --- | --- |
| F1 | the heading, $\lambda_{\max}(M)=\theta$ at every global maximiser | no argument on file, the lemma's own text calling the unrestricted form not citable | v355, v356, v357 (`GAP`) | **phase 3**, [ADJ_L115_F1.md](ADJ_L115_F1.md) |
| F2 | the restricted display | no argument in the lemma's text, "global" and "$m\ge4$" used by nothing visible, $S^4\times S^4$ and $S^5\times S^5$ not global maximisers | v355, v356, v357 (`GAP`) | **phase 3** with the annotation's argument quoted, [ADJ_L115_F2.md](ADJ_L115_F2.md) |
| F3 | "strictly stronger than Conjecture A" | the $C_5$ value $0.809017$ is below $\theta_0(n)$ at every $n\ge4$, the sentence carries no range, and the target is false at $n\le11$ | v355, v356, v357 (`GAP`) | **phase 3**, [ADJ_L115_F3.md](ADJ_L115_F3.md) |
| F4 | line 294's equivalence and by-product | both use the unrestricted equality of F1, and the by-product holds strictly by $\lambda_\alpha\le\lVert\lambda\rVert=1<\sqrt{3/2}\le\theta$ instead | v355, v356, v357 | **phase 3**, [ADJ_L115_F4.md](ADJ_L115_F4.md), *the two sentences merged as one mechanism, the unrestricted equality taken as premise* |
| F6 | "what would close it is a cap on $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})$" | sufficient only at level $\theta$ and with $L_e$ preserving $\mathcal W_n$, neither stated | v355 (`GAP`), v356 (`CONFIRMED AS ALGEBRA` with both additions), v357 | **phase 3**, [ADJ_L115_F6.md](ADJ_L115_F6.md) |
| F7 | $\lambda_{\max}(M)$ as a function of $W$ | the eigenbasis is not quantified at repeated eigenvalues or a kernel | v355 (`GAP`), v357 (withdrawn, no two frames found to differ) | **phase 3**, [ADJ_L115_F7.md](ADJ_L115_F7.md) |
| F8 | L115.lean's declarations | dimension arithmetic and two tautologies, none stating a claim of the block | v357, v355 and v356 (`CONFIRMED AS ALGEBRA`, clause 1 untyped) | **phase 3**, [ADJ_L115_F8.md](ADJ_L115_F8.md) |
| C | $\mathop{\mathrm{diag}}M=\lambda$, $M\lambda=\theta\lambda$ and $\theta\le\lambda_{\max}(M)$, L24 not reaching $\mathcal D$, the by-product by the norm route, the Lean statement file's clause 2 | direct | v355, v356, v357 (`CONFIRMED`) | no finding |

**Check 1, the brief against the source.** Every passage was copied off disk with its line asserted.

**Check 1b and 1c, the three forms.** [L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean) types only the by-product, by both routes, with the equality as a hypothesis in `theta_ge_diag`. [L115.lean](../lean/HamiltonsCubic/Results/L115.lean) is F8. [results.md](../results.md) has no L115 entry.

**Check 2, the whole record.** **F2**: the diagonal-locus argument sits in the Gate 2 annotation under the heading, [bounds-relaxations.md](../findings/bounds-relaxations.md) line 274, and in the report copy, [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1297, never in the lemma's own text, so F2's adjudicators check that argument. **F3**: the same annotation and the report copy at line 1299 already refute "strictly stronger" three ways, so the findings file and the report disagree. **F1**: no argument for the unrestricted equality exists anywhere, the annotation and the report both naming the missing cap. **F7**: no statement of the eigenbasis quantifier exists on file.

## Phase 3, adjudication

**Two fresh verifiers per finding, asked the step neutrally:** F1 to v358 and v359, F2 to v360 and v361, F3 to v362 and v363, F4 to v364 and v365, F6 to v366 and v367, F7 to v368 and v369, F8 to v370 and v371.

| id | adjudicators | outcome |
| --- | --- | --- |
| F1 | [v358](VERIFY_v358.md) `FAILS`, [v359](VERIFY_v359.md) `FAILS` | **confirmed**, the equality's truth left open |
| F2 | [v360](VERIFY_v360.md) `VALID`, [v361](VERIFY_v361.md) `VALID`, both in the coordinate frame | **withdrawn**, restated with "$m\ge4$" dropped and the false chain removed |
| F3 | [v362](VERIFY_v362.md) `FAILS`, [v363](VERIFY_v363.md) `FAILS` | **confirmed** |
| F4 | [v364](VERIFY_v364.md) `FAILS`, [v365](VERIFY_v365.md) `FAILS` | **confirmed** |
| F6 | [v366](VERIFY_v366.md) `VALID`, [v367](VERIFY_v367.md) `VALID`, both with the level and conditions written | **withdrawn**, the conditions entering the text |
| F7 | [v368](VERIFY_v368.md) `FAILS`, [v369](VERIFY_v369.md) `FAILS` | **confirmed** |
| F8 | [v370](VERIFY_v370.md) `VALID` read as both files, [v371](VERIFY_v371.md) `FAILS` | **split on scope, settled against the file as named: confirmed** |

**F1.** $\lambda_{\max}(M)=\theta\,\lambda_{\max}$ of the compression of $L_e$ to $\mathcal D$, L24 and Banach's polarisation theorem cap the Weyl part, and the Weyl and Weyl-orthogonal parts do not interact. What is missing is a cap on the Weyl-orthogonal part, where padded $W_{\mathbb{CP}^2}$ at $n\ge5$ already has a non-Weyl direction of positive Rayleigh value $\theta/3$ (v358). The equality holds at $n=4$, whose global maximisers are $W_{\mathbb{CP}^2}$, and at padded $W_{\mathbb{CP}^2}$ in every eigenframe (v359).

**The defence of F2.** In the coordinate frame $q(S)=\tfrac12\sum\Lambda_{ij}S_{ij}^2+\tfrac12\mathop{\mathrm{tr}}(\Lambda S^2)$, the Weyl part $S\mathbf1=0$ and the complement $\{u_i+u_j\}$ carry no cross term, the complement's Rayleigh value is at most $\tfrac12\lambda_{\max}(\Lambda)<1/\sqrt2$, and L24 with $\theta\ge\sqrt{3/2}$ closes the coordinate-diagonal global maximiser. At $S^m\times S^m$ a row-wise Cauchy–Schwarz bound gives the Weyl part for every $m\ge2$ without maximality. Both refute the annotation's chain $\sqrt{3/2}\le\theta$ at $m=4,5$, where $\theta^2=21/16$ and $36/25$, and both find "$m\ge4$" used nowhere.

**F3.** The target implies Conjecture A only at even $n\ge12$, the constant at odd $n$ being $\Theta_n<\theta_0(n)$. It is false at $n\le11$. The $C_5$ value $0.809017$ is below $\theta_0(n)$ at every $n\ge4$, so it witnesses no strictness.

**F4.** The reverse half of the equivalence and the by-product's premise both need the unrestricted equality, which the passage calls not citable two sentences earlier. v364 exhibits an exact $2\times2$ symmetric matrix meeting the passages' premises with $\lambda_{\max}=3\theta$. The by-product holds strictly by $\lambda_\alpha\le1<\sqrt{3/2}\le\theta$.

**The defence of F6.** $L_e$ is self-adjoint, fixes $W$ and preserves $\mathcal W_n$, so it splits into $1$ on $W$, at most $\tfrac12$ on $\mathcal W_n\cap W^\perp$ by L24, and the capped block. A cap at level $\theta$ for $L_W$ on $\mathcal W_n^\perp$, taken inside $\mathrm{Sym}(\Lambda^2)$, gives the equality, and a uniform cap $\sqrt{3/2}$ suffices at global maximisers.

**F7.** $M$ is built from squared structure constants, which change under rotation inside a repeated eigenspace. v369: at $n=4$, $W^+=\mathop{\mathrm{diag}}(0,\tfrac1{\sqrt2},-\tfrac1{\sqrt2})$, $W^-=0$ gives $\sqrt{3/2}$ and $1$ in two eigenbases. v368: $(\mathop{\mathrm{diag}}(2,4,-6)\oplus\mathop{\mathrm{diag}}(2,-1,-1))/\sqrt{62}$ gives $\sqrt{84}/\sqrt{62}$ and $r^*/\sqrt{62}$ with $r^*\in(7,8)$, padded to every $n\ge5$.

**F8, the split settled.** L115.lean holds dimension shares, a toy function capped on a line, and a trivial implication, none mentioning $M$, $\theta$, $\lambda$ or a maximiser. v370's `VALID` reads the step over both files, `theta_ge_diag` and `theta_gt_lambda` in L115Statement.lean, which changes its subject.

## Phase 4, dependents

**No site links to L115's heading, and no result cites it by number.** Its report copy, [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1297, carried "unconditionally at every $S^m\times S^m$ with $m\ge4$" and the false chain, and is corrected in the same change. Line 1299 there already refuted "strictly stronger" and stands. [bounds-relaxations.md](../findings/bounds-relaxations.md)'s header list and [LEDGER.md](../findings/LEDGER.md) name L115 without using it. No route or fence post rests on the unrestricted equality. **Impact `NARROWS`**: the heading's claim is narrowed to what is proved.

## Phase 5, what was changed

**Verdict: `PROVEN, hypotheses corrected`.** The by-product holds unconditionally at global maximisers, and the equality holds with the coordinate frame and coordinate-diagonality added, or at $S^m\times S^m$, $m\ge2$.

- **[bounds-relaxations.md](../findings/bounds-relaxations.md)**: the heading, the Gate 2 stack and the two sections after it are replaced by a two-part statement, its proof from v361's coordinate-frame derivation, an open paragraph naming the missing cap and the eigenbasis dependence, and a paragraph scoping $\sup_W\lambda_{\max}(M)\le\theta_0$.
- **[07-gradedness-split.tex](../report/sections/07-gradedness-split.tex)** line 1297 brought into agreement.
- **[results.md](../results.md)**: a landscape line and a detail entry, the first L115 has had.
- **[INDEX-results.md](../findings/INDEX-results.md)** row 115 and the **[lean/INDEX.md](../lean/INDEX.md)** L115 row.
- **[L115.lean](../lean/HamiltonsCubic/Results/L115.lean)** replaced by the cap arithmetic. **[L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean)** quotes the audited statement.
- **[ATTEMPTS.md](../ATTEMPTS.md)**: the removed passages and the round's account.

**The restated lemma is new text**, so L115 re-enters the queue for a repair audit.

## Phase 6

L115 keeps its box with a repair audit owed, one line goes under *Checked*, and the candidate class is exhausted. The next id is the first repair audit in queue order, L20.
