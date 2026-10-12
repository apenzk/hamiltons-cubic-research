# Round L20-r2, the repair audit of the tube exclusion

**Id:** L20-r2 · **Date:** 2026-09-14 · **Verifiers:** v372, v373, v374 · **Brief:** [BRIEF_L20r2.md](BRIEF_L20r2.md) · **Logs:** `agent_logs/verify-L20-v372.log`, `agent_logs/verify-L20-v373.log`, `agent_logs/verify-L20-v374.log`

**Why this round.** [ROUND_L100](ROUND_L100.md) replaced L20's radius comparison, whose printed bracket ordered nothing, by an exact reduction and a Taylor bound. That text is new and re-enters unchecked, so L20 is audited again whole, the first round on it being [ROUND_L20](ROUND_L20.md).

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading, setting and proof | [findings/route-a.md](../findings/route-a.md) lines 103, 121-135 |
| L21, given | [findings/route-a.md](../findings/route-a.md) line 174 |
| the canon | [results.md](../results.md) lines 321, 1063, 1065 |
| the Lean files | [L20Statement.lean](../lean/HamiltonsCubic/Results/L20Statement.lean), [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean), [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean), declarations only |

**Withheld**: the Gate 2 stack under the heading (lines 105-119), the "Why the bootstrap is needed" paragraph, every prior round file, the Lean module and theorem docstrings, and every index row.

## The findings from phase 0

**L20Statement.lean carries one `sorry`, `sin_radius_le : Real.sin 0.5748 ≤ 0.54368`**, the step the repaired prose now argues by a degree-five Taylor bound. **The Gate 2 stack under the heading still reads as it did before ROUND_L20 and ROUND_L100**, with its own claims about the metric, the odd-$n$ witness and the radius. Brief items 4 and 9.

## Phase 2, clustering

**Verdicts: [v372](VERIFY_v372.md), [v373](VERIFY_v373.md), [v374](VERIFY_v374.md) all `PROVEN, hypotheses corrected`.** *All three confirm the expansion, the use of L21, the repaired radius step checked in exact decimals, both parities from $n\ge12$ and the degenerate branch.*

| id | step attacked | mechanism | support | route |
| --- | --- | --- | --- | --- |
| G1 | the detail entry's witness, "the balanced sphere product with $P=\theta_0(n)$" | no such product exists at odd $n$, where the best split gives $\Theta_n<\theta_0(n)$, $120/77<264/169$ at $n=13$ | v372, v373, v374 (`REFUTED AS STATED`) | **phase 3** with the object, [ADJ_L20r2_G1.md](ADJ_L20r2_G1.md) |
| G2 | the heading and the detail entry stating L20 without its condition | the proof and the landscape line say it rests on L21's $\alpha\le\tfrac13$, which carries a debt | v372, v373, v374 | **phase 3**, [ADJ_L20r2_G2.md](ADJ_L20r2_G2.md) |
| G3 | the printed decimals and the chord remark | no argument on file, none used by the proof | v372, v373, v374 (`HYPOTHESIS-DEBT`, unused) | **phase 3**, [ADJ_L20r2_G3.md](ADJ_L20r2_G3.md) |
| G4 | "three further hypotheses are used and are stated here rather than assumed" | all three hold automatically in the setting | v373, v374 | **phase 3**, [ADJ_L20r2_G4.md](ADJ_L20r2_G4.md) |
| G5 | `sin_radius_le` proved by `sorry` in L20Statement.lean | the step the prose now argues by a Taylor bound, with every geometric input untyped | v372, v373, v374 | **check 1c**: routed to a Lean pass in the same turn, the kernel deciding it |
| G6 | "that it too lies outside the tube follows afterwards" | unused and unargued, and it follows only if the sphere product is a maximiser | v374 | **phase 3**, [ADJ_L20r2_G6.md](ADJ_L20r2_G6.md) |

**Check 1, the brief against the source.** Every passage was copied off disk with its line asserted, after round L100's edit to line 133 landed.

**Check 1c, the third form.** L20Statement.lean is `partial` with one `sorry`, and it is the radius step the block rests on. Mathlib's `Real.sin_bound` gives $\lvert\sin x-(x-x^3/6)\rvert\le\lvert x\rvert^5/100$, which at $x=0.5748$ reaches only $0.54378$. Applied at $x/4$ and doubled twice it reaches $0.54367<0.54368$, and a Lean pass is dispatched to write that proof.

**Check 2, the whole record.** **G3**: the decimals occur only in [route-a.md](../findings/route-a.md), and the chord remark also in [conventions.md](../findings/conventions.md) line 81, with no derivation anywhere. **G6**: the remark is copied at [problem.md](../findings/problem.md) line 552 and [90-appendix.tex](../report/sections/90-appendix.tex) line 313, and argued at none of them.

## Phase 3, adjudication

**Two fresh verifiers per finding, asked the step neutrally:** G1 to v375 and v376, G2 to v377 and v378, G3 to v379 and v380, G4 to v381 and v382, G6 to v383 and v384.

| id | adjudicators | outcome |
| --- | --- | --- |
| G1 | [v375](VERIFY_v375.md) `FAILS`, [v376](VERIFY_v376.md) `FAILS` | **confirmed** |
| G2 | [v377](VERIFY_v377.md) `VALID`, [v378](VERIFY_v378.md) `VALID`, both with L21 read from the proof sentence | **withdrawn** |
| G3 | [v379](VERIFY_v379.md) `FAILS`, [v380](VERIFY_v380.md) `FAILS` | **confirmed** |
| G4 | [v381](VERIFY_v381.md) `VALID` as facts, [v382](VERIFY_v382.md) `FAILS` as written | **split on reading, settled against the words: confirmed as wording** |
| G5 | the kernel | **discharged**, `sin_radius_le` proved in 3bdf1acc |
| G6 | [v383](VERIFY_v383.md) `FAILS`, [v384](VERIFY_v384.md) `FAILS` | **confirmed** |

**G1.** At odd $n$ no two-factor sphere product attains $\theta_0(n)$. The best split attains $\Theta_n$, with $\Theta_n^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$, $120/77<264/169$ at $n=13$. The contradiction survives with $\Theta_n$, which the proof in route-a already uses, so only the two canon sentences were wrong.

**The defence of G2.** The detail entry's proof sentence names "the eigenvalue bound $\alpha\le\tfrac13$ of Lemma L21" and the landscape line calls the chain conditional on it, so a reader of either entry meets the condition before the conclusion. Both adjudicators read the statement as holding given L21, with "maximizer" meaning global maximizer.

**G3.** $\varphi_{\min}=\arcsin\frac{\sqrt3-1}2=0.3747344\ldots$ and $\psi_{\min}=\sqrt{(12+8\sqrt3)/27}=0.9785932\ldots$, each by exact bounds in both reports. The other four decimals, $0.5748263$, $0.9999937$, $0.5830224$ and $1.0020125$, are correct. None is used by the proof.

**G4, the split settled.** v381 finds the three items true in the setting: $SO(n)$ acts on $\mathrm{Weyl}_n$ by isometries, an orbit of a compact group acting smoothly is a compact embedded submanifold, and $\varphi=0$ is a case the proof closes. v382 finds the same and holds that "hypotheses ... stated here rather than assumed" says the lemma carries them, and that $\varphi>0$ is what defines $V$ rather than what makes first variation non-vacuous. The words are what is audited, so the sentence is confirmed defective as wording and restated as three standard facts with their reasons.

**G6.** The bootstrap $\gamma_V\le m$ turns $m\le\cos\varphi+m\sin^3\varphi$ into a bound only where the expanded point's value is $m$ itself. At the sphere product the left side is $\sqrt{2/3}\,\Theta_n<m$ in general, and v384 exhibits $\varphi=\pi/6$, $\alpha=\tfrac13$, $\gamma_V=m$ meeting every relation the proof uses. The location is true by a separate closed form, $\cos^2d=\frac{2(2k-1)}{3k^2(k-1)}$ at $n=2k$ and $\frac{2(2k-1)}{3k(k+1)(k-1)}$ at $n=2k+1$, both below $\tfrac14<\cos^2(0.5748)$ from $k\ge3$. That derivation is not entered into the record, since the proof never uses the clause, and the clause is deleted.

**Removed text, verbatim.**

- route-a.md, the proof: "**Three further hypotheses are used and are stated here rather than assumed**: that $d$ is $SO(n)$-invariant, that the orbit is a compact embedded submanifold so a nearest point exists and its first-variation condition holds, and that $\varphi>0$ for that condition to be non-vacuous, the degenerate branch is treated separately below."
- route-a.md, the proof: "The minimum is $0.9785933$, at $\sin\varphi=\tfrac{\sqrt3-1}2$, i.e. $\varphi=0.3747372$."
- route-a.md, after the proof: "Note that the contradiction is with the *value*, not the location, nothing is assumed about where the sphere product sits, and that it too lies outside the tube follows afterwards."
- route-a.md line 34: "it dips near $\varphi\approx0.33$ and returns".
- results.md landscape: "contradicting the sphere product's larger value."
- results.md detail: "contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains."
- problem.md: "it follows afterwards that it too lies outside the tube. The only inputs are $\alpha\le1/3$ (Theorem 4.14(c), $n\ge9$, reverified here from scratch) and $\theta_0(n)>\sqrt{3/2}$, i.e. $n>6+2\sqrt7$."
- 90-appendix.tex: "That it too lies outside the tube follows afterwards."
- route-a.md, the Gate 2 stack under the heading, seven blockquotes: quoted in full in [ATTEMPTS.md](../ATTEMPTS.md)'s entry for this round.

## Phase 4, dependents

**Search by number, by the anchor and by the signatures "follows afterwards", "sphere product's larger value", $0.3747$ and $0.9785$.** Copies of the G6 clause stood at [problem.md](../findings/problem.md) and [90-appendix.tex](../report/sections/90-appendix.tex), and the problem.md copy also carried the $\theta_0(n)$ witness and "reverified here from scratch" for $\alpha\le\tfrac13$, against L21's recorded debt. All three are corrected in this change.

| dependent | use | disposition |
| --- | --- | --- |
| [L100](../findings/route-a.md) | L20's proof up to "Hence $m\le1$" | `SURVIVES`, no change before that sentence |
| [L134](../findings/route-a.md) | the $\tfrac13\theta^*$ gap read as a Hessian bound | `SURVIVES`, the gap is L21's and untouched |
| [results.md](../results.md) lines 41, 48 | L20 and L21 closing the tube | `SURVIVES`, mentions |
| [route-a.md](../findings/route-a.md) line 35 | the odd-$n$ witness $\Theta_n$ | `SURVIVES`, already at $\Theta_n$ |
| [LEDGER.md](../findings/LEDGER.md) | dated audit entries | mention |

No route or fence post rests on a changed sentence. **Impact `CONTAINED`.**

## Phase 5, what was changed

**Verdict: `PROVEN, hypotheses corrected`**, conditional on L21 as the canon states.

- **[route-a.md](../findings/route-a.md)**: the Gate 2 stack replaced by one provenance line, the three facts restated with their reasons, two decimals corrected, the G6 clause deleted, and line 34's dip located at $0.3747344$.
- **[results.md](../results.md)**: both entries cite $\Theta_n$.
- **[problem.md](../findings/problem.md)** and **[90-appendix.tex](../report/sections/90-appendix.tex)**: the copies brought into agreement, and the report rebuilt.
- **[INDEX-results.md](../findings/INDEX-results.md)** row 20: the stale Gate 2 status replaced by the verdict, and Lean marked proved.
- **[L20Statement.lean](../lean/HamiltonsCubic/Results/L20Statement.lean)**: `sin_radius_le` proved, axioms `propext`, `Classical.choice`, `Quot.sound`.
- **[ATTEMPTS.md](../ATTEMPTS.md)**: the removed stack and the round's account.

**Nothing new re-enters the queue.** Every change is a deletion, a witness the audited proof already uses, a decimal two adjudicators derived independently, or a kernel-checked step.

## Phase 6

L20's box is deleted from *To check* and one line goes under *Checked*. The next id is the first repair audit in queue order, L64.
