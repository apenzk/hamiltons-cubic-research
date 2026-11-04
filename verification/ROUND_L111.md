# Round L111, criticality in bracket coordinates and the bracket form

**Id:** L111 · **Date:** 2026-09-14 · **Verifiers:** v329, v330, v331 · **Brief:** [BRIEF_L111.md](BRIEF_L111.md) · **Logs:** `agent_logs/verify-L111-v329.log`, `agent_logs/verify-L111-v330.log`, `agent_logs/verify-L111-v331.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and the lemma | [findings/bounds.md](../findings/bounds.md) lines 636, 652-662 |
| the relations and conventions | [findings/bounds.md](../findings/bounds.md) lines 258-264, [findings/conventions.md](../findings/conventions.md) lines 61, 77, 151 |
| the Lean files | [L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean), [L111.lean](../lean/HamiltonsCubic/Results/L111.lean), declarations only |

**Withheld**: the Gate 2 stack under the L111 heading (lines 638-650), the LP paragraphs after the lemma, both Lean module docstrings and theorem docstrings, and every index row.

## The findings from phase 0

**The block's statement sits under a second heading sixteen lines below its own**, with only annotations under the numbered heading. **The two Lean files disagree on the $\Lambda^2$ multiplicities at the $n=6$ balanced product**, $(3,3,9)$ against $(6,9)$. **The strictness claim is supported in the block by a measurement.** **No results.md entry exists.** Brief items 5, 6 and 8.

## Phase 2, clustering

**Verdicts: [v329](VERIFY_v329.md), [v330](VERIFY_v330.md), [v331](VERIFY_v331.md) all `HYPOTHESIS-DEBT`.**

| id | step attacked | mechanism | support | route |
| --- | --- | --- | --- | --- |
| D1 | the display's "i.e." | the sum condition over $\lambda_k\ne\lambda_l$ is the bracket form, not the matrix form, and the block's own correction retracts it beside a display that still carries it | v329, v330, v331 (`REFUTED`) | **phase 3**, [ADJ_L111_D1.md](ADJ_L111_D1.md) |
| D2 | "strictly weaker" | the prose supports it by a measurement, and `bracket_form_strictly_weaker` uses an array that is not a Weyl tensor | v329, v330, v331 (`HYPOTHESIS-DEBT`) | **phase 3**, [ADJ_L111_D2.md](ADJ_L111_D2.md) |
| D3 | "every diagonal Weyl tensor ... nowhere near critical" | $S^2\times S^2$ and $S^3\times S^3$ are coordinate-diagonal and critical | v329, v330, v331 (`REFUTED AS STATED`) | **phase 3** with the object, [ADJ_L111_D3.md](ADJ_L111_D3.md) |
| D4 | "every diagonal Weyl tensor satisfies it" | no argument on file | v330, v331 (`HYPOTHESIS-DEBT`), v329 (`CONFIRMED`) | **resolved by check 2**: the argument is on file, see below |
| D5 | "an $n(n-3)/2$-dimensional family" | no argument on file | v331 (`GAP`), v330 (`CONFIRMED AS ALGEBRA`, no argument), v329 (`CONFIRMED`) | **resolved by check 2**: the argument is on file, see below |
| D6 | "$N$ constraints where the record used one" | the diagonal equations sum to an identity on unit Weyl tensors, and no independence argument exists | v330 (`GAP`), v331 (`GAP`), v329 (`CONFIRMED AS ALGEBRA`, no independence argument) | **phase 3**, [ADJ_L111_D6.md](ADJ_L111_D6.md) |
| D7 | "the only place the Jacobi identity can enter a bound on $D$" | no argument, and $D$ undefined in the block | v329, v330, v331 (`GAP`) | **phase 3** with $D$ quoted from L70, [ADJ_L111_D7.md](ADJ_L111_D7.md) |
| D8 | L111.lean's multiplicities $(3,3,9)$ and $(1,1,4)$ | the $\Lambda^2$ spectra of the balanced products' Weyl tensors are $(6,9)$ and $(2,4)$, so the counts are $66$ of $120$ and $13$ of $21$ | v329, v330, v331 (`REFUTED`) | **phase 3** with the object, [ADJ_L111_D8.md](ADJ_L111_D8.md) |
| D9 | `dropped_fractions` compares $1130/2210$ beside the proved $1131$ of $2211$ | an unexplained off-by-one | v331 (finding), v330 (`CONFIRMED AS ALGEBRA`) | **resolved by check 2**: the reason is on file, see below |
| C | the polarised identity $M=-2W^\#$ on any symmetric $W$, criticality equivalent to the matrix form, the bracket form as $[W,Q(W)]=0$, $M_{kk}$ as relation (C), "a change of language" | direct | v329, v330, v331 (`CONFIRMED`) | no finding |

**Check 1, the brief against the source.** Every passage was copied off disk with its line asserted.

**Check 1b and 1c, the three forms.** [L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean) types the equivalence over a free symmetric array, so the polarised identity and a Weyl witness sit outside it; [L111.lean](../lean/HamiltonsCubic/Results/L111.lean) carries D8. [results.md](../results.md) has no L111 entry. The third form exists, so no row is filed.

**Check 2, the whole record.** **D4**: [problem.md](../findings/problem.md) line 118 argues that for $W$ diagonal on coordinate 2-planes $Q$ preserves diagonality, so $Q(W)$ is diagonal in the same basis and commutes with $W$. The finding shrinks to a missing pointer. **D5**: [second-order.md](../findings/second-order.md) line 429 argues that a diagonal $W$ is a hollow symmetric matrix with zero row sums, and line 627 records $\dim\mathcal D_n=n(n-3)/2$. The finding shrinks to a missing pointer. **D9**: the module docstring of L111Statement.lean, withheld from the verifiers, states that $1130/2210$ nets the normalisation condition off both sides and $1131/2211$ does not. The finding shrinks to that reason being absent from the theorem's own docstring. **D7**: $D$ is defined in [Lemma L70](../findings/bounds.md) line 216, uncited by L111, and no argument for "the only place" exists anywhere on file.

## Phase 3, adjudication

**Two fresh verifiers per finding, asked the step neutrally:** D1 to v332 and v333, D2 to v334 and v335, D3 to v336 and v337, D6 to v338 and v339, D7 to v340 and v341, D8 to v342 and v343.

| id | adjudicators | outcome |
| --- | --- | --- |
| D1 | [v332](VERIFY_v332.md) `FAILS`, [v333](VERIFY_v333.md) `FAILS` | **confirmed** |
| D2 | [v334](VERIFY_v334.md) `VALID`, [v335](VERIFY_v335.md) `VALID`, both refuting the support on file | **withdrawn**, the exact witness replacing the support |
| D3 | [v336](VERIFY_v336.md) `FAILS`, [v337](VERIFY_v337.md) `FAILS` | **confirmed** |
| D6 | [v338](VERIFY_v338.md) `FAILS`, [v339](VERIFY_v339.md) `FAILS` | **confirmed** |
| D7 | [v340](VERIFY_v340.md) `VALID` under a restricted reading, [v341](VERIFY_v341.md) `FAILS` | **split, settled by derivation: confirmed as stated** |
| D8 | [v342](VERIFY_v342.md) `FAILS`, [v343](VERIFY_v343.md) `FAILS` | **confirmed** |

**D1.** The right side of the display is $[W,Q(W)]=0$ and leaves the diagonal entries free. The coordinate-diagonal $W\in\mathcal W_4$ with $w_{12}=w_{34}=1$, $w_{13}=w_{24}=-1$, $w_{14}=w_{23}=0$ satisfies it in every eigenbasis while its diagonal demands $\theta=1$ and $\theta=-1$.

**The defence of D2.** Every coordinate-diagonal Weyl tensor has $W^\#$ diagonal, so it satisfies the bracket form, and the same $W$, padded to every $n\ge4$, has $Q(W)=(1,1,1,1,-2,-2)$ against $W=(1,1,-1,-1,0,0)$, critical for no $\theta$. Both adjudicators refute the support on file: the measurement names no samples, and `bracket_form_strictly_weaker` uses eigendata of no Weyl tensor.

**D3.** The unit Weyl tensors of $S^2\times S^2$ and $S^3\times S^3$ are coordinate-diagonal with $Q(\hat W)=\tfrac{\sqrt3}2\hat W$ and $Q(\hat W)=\tfrac{\sqrt{10}}3\hat W$. On the diagonal circle of $\mathcal W_4$ the criticality residual is $\tfrac{\sqrt3}2\lvert\sin3\varphi\rvert$, zero at six points, so neither "every" nor "nowhere near" holds.

**D6.** The defects $d_k=-2(Q(W)-\theta W)_{kk}$ satisfy $\sum_kd_k=0$, since $\mathop{\mathrm{tr}}Q(W)=0=\mathop{\mathrm{tr}}W$, and $\sum_k\lambda_kd_k=2(\theta-P(W))$, on every unit Weyl tensor, so at most $N-2$ are independent.

**D7, the split settled.** v340 reads "enter" as the sign-dependent part of the Jacobi identity and finds the off-diagonal entries the only entries of $M$ that see it, while refuting the literal sentence with an $n=5$ pattern of $T$ that satisfies the Killing normalisation and fails Jacobi for every choice of signs. v341 shows Jacobi has closed-form consequences in $T=c^2$ alone, the currency of $D$ and of the diagonal entries, and that under the linear degree-two reading neither kind of entry meets a Jacobi term. **Both refute the sentence as written**, and v340's reading changes what it asserts, so the finding is confirmed as stated and the sentence is removed. What survives is the fact all three original verifiers confirmed: the off-diagonal entries are not functions of $T$.

**D8.** Ricci-flatness at an index of either factor forces the two factor blocks onto one eigenvalue, so the multiplicities are $(6,9)$ and $(2,4)$ and the dropped counts $66$ of $120$ and $13$ of $21$. L111.lean's `share_six` and `cross_dominates` are corrected with them.

## Phase 4, dependents

**No site links to either heading, and no report section copies the refuted sentences.** [conventions.md](../findings/conventions.md) line 151 carried "satisfied by every diagonal Weyl tensor", true of coordinate-diagonal tensors and now scoped and cited. The LP paragraphs after the lemma use only its diagonal half, relation (C), which stands: `SURVIVES`. L111.lean's counts feed nothing on the record. **Impact `CONTAINED`.**

## Phase 5, what was changed

**Verdict: `PROVEN, hypotheses corrected`.** The added hypothesis is $n\ge4$, and "diagonal" is read as coordinate-diagonal.

- **[bounds.md](../findings/bounds.md)**: the Gate 2 stack and the second heading's paragraphs are replaced under the numbered heading by a two-part statement, a proof with the exact strictness witness, and a scope paragraph carrying the pointers to [problem.md](../findings/problem.md) and [second-order.md](../findings/second-order.md) and the corrected constraint count. The second heading stays above the LP paragraphs.
- **[results.md](../results.md)**: a landscape line and a detail entry, the first L111 has had.
- **[conventions.md](../findings/conventions.md)** line 151, **[INDEX-results.md](../findings/INDEX-results.md)** row 111, both **[lean/INDEX.md](../lean/INDEX.md)** rows.
- **[L111.lean](../lean/HamiltonsCubic/Results/L111.lean)** recounted on $(6,9)$ and $(2,4)$. **[L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean)** quotes the audited statement, names its witness as an array, and states D9's netting in `dropped_fractions`.
- **[ATTEMPTS.md](../ATTEMPTS.md)**: the removed passages and the round's account.

**The restated lemma is new text**, so L111 re-enters the queue for a repair audit.

## Phase 6

L111 keeps its box with a repair audit owed, one line goes under *Checked*, and the next id is L113.
