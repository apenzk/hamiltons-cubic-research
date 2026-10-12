# Round L64-r2, the repair audit of the transfer mechanism

**Id:** L64-r2 · **Date:** 2026-09-14 · **Verifiers:** v385, v386, v387 · **Brief:** [BRIEF_L64r2.md](BRIEF_L64r2.md) · **Logs:** `agent_logs/verify-L64-v385.log`, `agent_logs/verify-L64-v386.log`, `agent_logs/verify-L64-v387.log`

**Why this round.** [ROUND_L64](ROUND_L64.md) replaced the block's annotation stack with a setting, a two-part lemma, a three-step proof, a scope section and an exhibit on $\{\mathrm{Sym}^2S^n\}$. That text is new and re-enters unchecked, so L64 is audited again whole.

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading, setting, lemma, proof and scope | [findings/fence-posts.md](../findings/fence-posts.md) lines 227, 231-248 |
| the canon | [results.md](../results.md) lines 227, 794, 796 |
| post F32, the copy and the Theorem 2.11 paragraph | [findings/fence-posts.md](../findings/fence-posts.md) lines 217, 221 |
| the imported definitions | [txt.txt](https://arxiv.org/abs/2307.04230) lines 248-292, 843-952, 1033-1052, with the PDF |
| the Lean file | [L64.lean](../lean/HamiltonsCubic/Results/L64.lean), declarations only |

**Withheld**: the provenance line at line 229, every prior round file, the reference folder's notes.md, the Lean docstrings, and every index row.

## The findings from phase 0

**The Lean statement is not typed.** [lean/INDEX.md](../lean/INDEX.md) files the lemma under *out* with its binders named, since its proof runs on the first fundamental theorem for $O(n)$ and Proposition 2.9, neither in Mathlib. L64.lean holds arithmetic around $k_B(6)\ge24$. Brief item 11.

**Post F32 carries a copy of the statement.** Brief item 10.

## Phase 2, clustering

**Verdicts: [v385](VERIFY_v385.md), [v386](VERIFY_v386.md), [v387](VERIFY_v387.md) all `PROVEN, hypotheses corrected`.** *All three confirm the setting as a module with restriction as the projection, step (i) at every $n_0$ with non-unique $a_\pi$ unused, step (ii), step (iii) by Proposition 2.9 composed level by level, $k_B(d)\ge g(d)\ge4d$, the $n_0=3$ edge, and the $\mathrm{Sym}^2S^n$ exhibit with $G(I_5)=-\tfrac54$.*

| id | step attacked | mechanism | support | route |
| --- | --- | --- | --- | --- |
| H1 | "The same holds with $SO$ in place of $O$", over part 1 | at $n_0=4$, $d=2$, $n=5$ the $SO(4)$-invariant $F(W)=\sum\varepsilon_{ijkl}W_{abij}W_{abkl}$ is odd under a reflection, and $\mathrm{diag}(-1,1,1,1,-1)\in SO(5)$ acts on the padded copy as that reflection | v385, v386, v387 (`REFUTED AS STATED`), each with a witness on which $F\ne0$ | **phase 3** with the object, [ADJ_L64r2_H1.md](ADJ_L64r2_H1.md) |
| H2 | the same sentence over part 2 | the reflection sentence proves only that an $SO(n_0)$-invariant with a $B_n$-invariant extension is $O(n_0)$-invariant, so "exactly one" has no existence half for the others | v386 (`REFUTED AS STATED`), v387 (`HYPOTHESIS-DEBT`) | **phase 3**, [ADJ_L64r2_H2.md](ADJ_L64r2_H2.md) |
| H3 | post F32's "Theorem 2.11's calculus yields no $k_B$ here at all" | only the kernel and sums clauses are argued, and the tensor and Sym clauses are not addressed | v385, v386 (`HYPOTHESIS-DEBT`) | **phase 3**, [ADJ_L64r2_H3.md](ADJ_L64r2_H3.md) |
| H4 | "$k_B(d)$ is that module's presentation degree", and part 2's hypothesis $n_0\ge k_B(d)$ | Definition 2.7 takes a smallest $k$, which need not exist, and no convention is stated | v385, v386 | **phase 3**, [ADJ_L64r2_H4.md](ADJ_L64r2_H4.md) |
| H5 | L64.lean | it types arithmetic and names no object of the lemma, and four declarations about a support cap $2d$ match no line of Passage A | v385, v386, v387 | **check 1 and check 1c**, no adjudication |
| H6 | step (iii)'s hypothesis $n_0\ge k_B(d)$ | injectivity alone is used, which Proposition 2.3 gives from the generation degree | v387 | **not a defect**: the step is valid as written, and the sharpening is recorded in [ROUND_L64](ROUND_L64.md) as a strengthening not adopted |

**Withdrawn by their verifiers:** "below the range, uniqueness fails" read universally (all three, since the passage gives one instance and reads as "can fail"), "carries a sign only on the padded copy" (v386, v387), and post F32 naming one obstruction where Passage A records two (v386).

**Check 1, the brief against the source.** Every passage was copied off disk by line, with its first words asserted. **H5's "no counterpart" is brief-induced**: the four declarations formalise post F32's support paragraph at [fence-posts.md](../findings/fence-posts.md) line 223, which the brief did not quote. The declarations are true arithmetic about that paragraph.

**Check 1c, the third form.** [lean/INDEX.md](../lean/INDEX.md) already marks L64 `statement: not typed` and files its binders under *out*, because the proof rests on the first fundamental theorem for $O(n)$ and Proposition 2.9, neither in Mathlib. The row stands, and no Lean pass is dispatched.

**Check 2, the whole record.** **Copies of the statement**: the report's Lemma 64 at [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 943, which still carries the pre-repair form with bare $k_B$ and no existence part, post F32 at line 217, and [results.md](../results.md) lines 227 and 796. **H3**: no argument for the tensor or Sym clauses occurs in [findings/](../findings/), [results.md](../results.md), [report/](../report/) or [ATTEMPTS.md](../ATTEMPTS.md).

## Phase 3, adjudication

**Two fresh verifiers per finding, asked the step neutrally:** H1 to v388 and v389, H2 to v390 and v391, H3 to v392 and v393, H4 to v394 and v395.

| id | adjudicators | outcome |
| --- | --- | --- |
| H1 | [v388](VERIFY_v388.md) `FAILS`, [v389](VERIFY_v389.md) `FAILS` | **confirmed** |
| H2 | [v390](VERIFY_v390.md) `VALID`, [v391](VERIFY_v391.md) `FAILS` | **split, settled by derivation: confirmed as wording, the conclusion true in range** |
| H3 | [v392](VERIFY_v392.md) `FAILS`, [v393](VERIFY_v393.md) `VALID` with a lemma of its own | **split, settled by derivation: confirmed** |
| H4 | [v394](VERIFY_v394.md) `VALID`, [v395](VERIFY_v395.md) `VALID` | **withdrawn**, with a defence that changes the scope text |

**H1.** $F(W)=\sum\varepsilon_{ijkl}W_{abij}W_{abkl}$ on $\mathcal W_4$ satisfies $F(g\cdot W)=\det(g)F(W)$ for $g\in O(4)$, and it is nonzero: v388 gives $F=64$ at $W=\omega^1\otimes\omega^1-\omega^2\otimes\omega^2$ with $\omega^1=e_{12}+e_{34}$, $\omega^2=e_{13}-e_{24}$, and v389 gives $F=192$ on a second explicit tensor. $\mathrm{diag}(-1,1,\dots,1,-1)\in SO(n)$ acts on the padded copy as $r=\mathrm{diag}(-1,1,1,1)$, so no $SO(n)$-invariant extension exists at any $n>4$. Both locate the failure in step (ii): the first fundamental theorem for $SO(n_0)$ also produces $\varepsilon$-contractions, which nothing on $\mathcal W_n$ restricts to. Both name the readings that hold: $F$ also $O(n_0)$-invariant, $n_0$ odd, or $n=n_0$.

**H2, the split settled.** Both adjudicators find the reflection sentence proves only that a $B_n$-invariant extension, where one exists, forces $O(n_0)$-invariance, so "exactly one" needs an existence half the sentence does not give. v391 grades the sentence as written and returns `FAILS`. v390 grades the conclusion and returns `VALID`, supplying the existence half. **Both supply the same repair independently**: for $m\ge4d$ every $SO(m)$-invariant form of degree $d$ on $\mathcal W_m$ is $O(m)$-invariant, because the first fundamental theorem for $SO(m)$ adds a term with one $\varepsilon$ on $m$ of the $4d$ slots only when $m\le4d$ with $4d-m$ even, and at $m=4d$ that term antisymmetrises each Weyl factor over its four slots and vanishes by $W_{[ijkl]}=0$. The loop checked the derivation: it is the standard spanning set for $SO(m)$-invariants, and the parity condition also covers odd $m$. Part 2's range lies inside $n_0\ge4d$ by $k_B(d)\ge4d$. The words are what is audited, so the sentence is confirmed defective and restated with its conditions and the counterexample.

**H3, the split settled.** Both adjudicators confirm each mechanical reason in post F32: the kernel clause needs the adjoint of $\mathrm{Ric}$ to be a morphism, which fails because $\mathrm{Ric}$ does not commute with truncation, and the Ricci part is padding-closed for one step only at $h\propto I$. Both also find that the condition assigned to the sums clause belongs to the images clause applied to the projection onto the Weyl part, since the sums clause bounds a sum from its parts and never a part. v392 returns `FAILS`: the calculus acts on isomorphism classes and can reach $\{\mathrm{Sym}^d\mathcal W_n^*\}$ without presenting $\{\mathcal W_n\}$ inside the curvature tensors, which the two reasons never consider. It exhibits the traceless diagonal matrices $\{D^0_n\}$ over $B_n$, which satisfy both reasons word for word while $\mathrm{Sym}^2D^0$ is presented by the calculus, and it proves the universal claim at $d=1,2$ only. v393 returns `VALID` only after supplying an invariant of its own, that every module the calculus builds satisfies $Q_SQ_{S'}=Q_{S\cap S'}$, which $\{\mathcal W_n\}$ breaks at $n=5$, and it leaves identifications that are not isometric open at $d\ge2$. **Both agree the written reasons exclude only two routes**, so the sentence claims more than it argues. It is restated to what the reasons give, the images clause named, and the universal claim left open. Neither supplied lemma enters the record.

**The defence of H4.** $\{\mathrm{Sym}^d\mathcal W_n^*\}$ sits inside $\{(\mathbb R^n)^{\otimes4d}\}$, which Example 2.12 generates in degree $4d$. Definition A.2 and Example A.3(b) make a module over $\{\mathbb R^n\}$ with $\{B_n\}$ a module over $\mathrm{FI}_{BC}$, and Theorem A.5 makes every submodule of a finitely generated module finitely generated, so the module and the kernel of a finitely generated free cover are both finitely generated and $k_B(d)$ is a natural number. The loop read Definition A.2, Example A.3 and Theorem A.5 at source, [txt.txt](https://arxiv.org/abs/2307.04230) lines 3228-3269. **So the record's "no finite $k_B(d)$ is on file" and "no established instance" were wrong in substance**: the value is unknown and the hypothesis holds for every large enough $n_0$.

**Removed and replaced text** is quoted verbatim in [ATTEMPTS.md](../ATTEMPTS.md)'s entry for this round.

## Phase 4, dependents

**Search by number, by the anchor, and by the signatures "in place of $O$", "no finite $k_B$", "no established instance" and "no satisfiable instance".** No other result uses the $SO$ clause. The copies and consumers found:

| site | use | disposition |
| --- | --- | --- |
| [results.md](../results.md) lines 227 and 796 | the statement, the $SO$ clause, "no finite value" | corrected in this change |
| [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 943 | the report's Lemma 64, still the pre-repair form with bare $k_B$ and no existence part | restated to the block, with the $SO$ conditions |
| [01-introduction.tex](../report/sections/01-introduction.tex) line 40, [diagram.tex](../report/sections/diagram.tex) and [diagram-closed.tex](../report/sections/diagram-closed.tex) | "no satisfiable instance" | corrected to "no known value" and "no known $k_B$", both figures alike |
| [INDEX-results.md](../findings/INDEX-results.md) row 64 | the stale Gate 2 status | replaced by the verdict |
| [lean/INDEX.md](../lean/INDEX.md) row L64, the *Support owed* row in [plan-verification.md](../plan-verification.md) | "a finite $k_B(d)$" owed | narrowed to a value of $k_B(d)$ |
| post F32 line 217 | a copy of parts 1 and 2 over $O$ | `SURVIVES`, it carries no $SO$ clause |
| [sym3-stability.md](../findings/sym3-stability.md) line 54, post F31 | pointers | `SURVIVES` |

No route or fence post rests on the $SO$ clause or on the infinitude of $k_B(d)$. **Impact `NARROWS`**: existence over $SO$ is narrowed to odd $n_0$ or $n_0\ge4d$.

## Phase 5, what was changed

**Verdict: `PROVEN, hypotheses corrected`.**

- **[fence-posts.md](../findings/fence-posts.md)**: the $SO$ sentence restated with its conditions, the argument for them and the counterexample. The scope heading and the finiteness bullet restated from Theorem A.5, and post F32's Theorem 2.11 paragraph narrowed to its two reasons.
- **[results.md](../results.md)**, the report's Lemma 64, introduction and both figures, index row 64, the lean/INDEX row and the support-owed row, as tabled above. The report was rebuilt.
- **[ATTEMPTS.md](../ATTEMPTS.md)**: the replaced passages and the round's account.

**The $SO$ argument and the finiteness paragraph are new text**, so L64 keeps its box with a repair audit owed.

## Phase 6

L64 keeps its box in *To check* with a repair audit owed, and one line goes under *Checked*. The next id is L65.
