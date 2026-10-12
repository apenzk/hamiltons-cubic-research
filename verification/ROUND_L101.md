# Round L101, the SO(n)-invariance identity and P = 0 on V_1/2

**Id:** L101 · **Date:** 2026-09-14 · **Verifiers:** v318, v319, v320 · **Brief:** [BRIEF_L101.md](BRIEF_L101.md) · **Logs:** `agent_logs/verify-L101-v318.log`, `agent_logs/verify-L101-v319.log`, `agent_logs/verify-L101-v320.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and the lemma | [findings/route-a.md](../findings/route-a.md) lines 423, 441-449 |
| the definitions | [findings/conventions.md](../findings/conventions.md) lines 24, 64, 136 |
| the eigenspaces of $F_u$ | [findings/route-a.md](../findings/route-a.md) lines 404, 406, 408 |
| L21, given | [findings/route-a.md](../findings/route-a.md) line 174 |
| the Lean statements | [L101Statement.lean](../lean/HamiltonsCubic/Results/L101Statement.lean) lines 92-153 |

**Withheld**: the Gate 2 stack under the heading (lines 425-439), the paragraphs after the lemma on the four vanishings and the coupled bound, [L101.lean](../lean/HamiltonsCubic/Results/L101.lean), the module docstring of L101Statement.lean, which quotes the Gate 2 verdict, and every index row.

## The findings from phase 0

**Passage A reads $F_ux=\lambda x$ and then carries $(\lambda-\mu)\theta^*$, while the section's own subdivision reads $F_uW_1=\tfrac13\theta^*W_1$**, two normalisations of $\lambda$. **No results.md entry exists.** Brief items 5 and 8.

## Phase 2, clustering

**Verdicts: [v318](VERIFY_v318.md), [v319](VERIFY_v319.md), [v320](VERIFY_v320.md) all `GAP`.**

| id | step attacked | mechanism | support | route |
| --- | --- | --- | --- | --- |
| B1 | "It also gives $P\equiv0$ on $V_{1/2}$" | no argument on file; it needs criticality of $u$ and $V_{1/2}\subseteq T_u\mathcal O$, from Nienhaus Theorem 4.14 and Remark 4.16 at $n\ge9$, which the paragraph's "no hypothesis, every dimension" excludes | v318, v319, v320 (`GAP`) | **phase 3**, [ADJ_L101_B1.md](ADJ_L101_B1.md) |
| B2 | "reaching $0.91$ off it" | no argument and no normalisation, and the quantity scales linearly in $A$ | v318, v319, v320 (`HYPOTHESIS-DEBT`) | **phase 3**, [ADJ_L101_B2.md](ADJ_L101_B2.md) |
| B3 | the general form's $(\lambda-\mu)\theta^*$ | $\lambda$ is a raw eigenvalue in "$F_ux=\lambda x$" and a $\theta^*$-scaled label in the general form | v318, v320 (finding), v319 (withdrawn as an editing request) | **phase 3**, [ADJ_L101_B3.md](ADJ_L101_B3.md) |
| B4 | "$A\cdot u=[A,u]$" | $[A,u]$ is not defined for $A\in\mathfrak{so}(n)$, $u\in\mathcal W_n$, where $[\rho(A),u]$ is | v318, v320 (finding), v319 (withdrawn as an editing request) | **phase 3**, [ADJ_L101_B4.md](ADJ_L101_B4.md) |
| C | the three-term identity, the diagonal chain, $Q(x)\perp T_u(SO(n).u)$ at any base point and every $n$, the Lean statements as algebra | direct; v319 adds that the orthogonality fails for sums of eigenvectors, $x=u+[\rho(A),u]$, consistent with "for every eigenvector" | v318, v319, v320 (`CONFIRMED`) | no finding |

**Check 1, the brief against the source.** Every passage was copied off disk with its line asserted, after the last edit to route-a.md landed.

**Check 1b and 1c, the three forms.** [L101Statement.lean](../lean/HamiltonsCubic/Results/L101Statement.lean) types the identity and the orthogonality over an abstract skew `D` with `hder` and `hsym` as hypotheses, and types neither $P\equiv0$ on $V_{1/2}$ nor $0.91$. It reads $\lambda$ raw in `invariance_identity_general` and $\theta^*$-scaled in `invariance_identity_record_normalisation`, the same two readings as the prose. [results.md](../results.md) has no L101 entry. The third form exists, so no row is filed, and its owed items are the round's B1 and the construction of `D` from $SO(n)$.

**Check 2, the whole record.** For B1: [route-a.md](../findings/route-a.md) line 404, quoted in the brief as Passage C, gives $\mathrm{mult}(+\tfrac12)=\dim\mathcal O$ at $n=10,12,14,16$ "from Theorem 4.14(a),(b) with Remark 4.16", and [Lemma L51](../findings/second-order.md) and [Lemma L170](../results.md) treat the orbit tangent at a critical point. None is cited by L101, and none argues $P\equiv0$ on $V_{1/2}$. For B2: no source for $0.91$ anywhere in [findings/](../findings/), [results.md](../results.md) or [ATTEMPTS.md](../ATTEMPTS.md).

## Phase 3, adjudication

**Two fresh verifiers per finding, asked the step neutrally:** B1 to v321 and v322, B2 to v323 and v324, B3 to v325 and v326, B4 to v327 and v328.

| id | adjudicators | outcome |
| --- | --- | --- |
| B1 | [v321](VERIFY_v321.md) `VALID`, [v322](VERIFY_v322.md) `VALID`, both only with criticality of $u$ and L21 added, at $n\ge9$ | **withdrawn as a refutation, and the two hypotheses enter the statement** |
| B2 | [v323](VERIFY_v323.md) `VALID`, [v324](VERIFY_v324.md) `VALID`, both because the quantity is unnormalised | **withdrawn**, and the value removed as naming nothing |
| B3 | [v325](VERIFY_v325.md) `FAILS`, [v326](VERIFY_v326.md) `FAILS` | **confirmed** |
| B4 | [v327](VERIFY_v327.md) `VALID`, [v328](VERIFY_v328.md) `VALID`, reading $[A,u]$ as $[\rho(A),u]$ | **withdrawn**, and the notation corrected |

**The defence of B1.** $Q(u)=\theta^*u$ (Nienhaus Theorem 4.14(a)) and equivariance of $Q$ give $T_u(SO(n).u)\subseteq V_{1/2}$ by differentiating along the orbit, which is Remark 4.16. A vector of $V_{1/2}$ transverse to the orbit would have $\alpha=\tfrac12>\tfrac13$, against L21, so $V_{1/2}=T_u(SO(n).u)$ at $n\ge9$, and part 1 at $x=y=A\cdot u$ gives $P\equiv0$. Both adjudicators refute "no hypothesis, every dimension" for this step, and v321 adds $n=4$ by hand with $5\le n\le8$ open. *v321 reports that route-a.md lines 424-440, the uncited Gate 2 stack, crossed its screen after its derivation was complete, and that nothing in its argument uses them.*

**The defence of B2.** The form is linear in $x$, $y$ and $A$ and nonzero off the diagonal, so it attains $0.91$ and every other real value. Under any normalisation the value is unresolved, since the passages fix no norm on $\mathfrak{so}(n)$. *The brief's framing, "attains the value $0.91$ for some $x,y,A$", admitted the trivial reading, which the round's brief should have excluded by asking for the quantity the words name.*

**The confirmation of B3.** Under "$F_ux=\lambda x$" the identity reads $(\lambda-\mu)\langle A\cdot x,y\rangle$ with no $\theta^*$, and at $x=u$, $y=A\cdot u$ the left side is $\tfrac12\theta^*\lVert A\cdot u\rVert^2$ while the display gives $\tfrac34\lVert A\cdot u\rVert^2$. The display is exact under the section's labels $F_ux=\lambda\theta^*x$, and every conclusion drawn at $\lambda=\mu$ holds under both readings.

**The defence of B4.** The block writes $[\rho(A),u]$ in its heading, its general form and its derivation, and under that reading $[\rho(A),u]\in\mathcal W_n$ equals $A\cdot u$ for the left conjugation action.

## Phase 4, dependents

**B3 is the only confirmed defect.** L101 is cited by number once, at [route-a.md](../findings/route-a.md) line 666, "$a=\sqrt{5/6}$ is Lemma L101's", a **mention** that uses the $V_{1/2}$ vanishing inside $Q(W_1)$'s decomposition, which holds under both readings: `SURVIVES`. By statement, "$T(x,y,[\rho(A),u])$" and "$(\lambda-\mu)\theta^*$" occur only in the block, [L101Statement.lean](../lean/HamiltonsCubic/Results/L101Statement.lean), which types both normalisations separately, and [L101.lean](../lean/HamiltonsCubic/Results/L101.lean)'s row. The report carries no copy. No fence post or route rests on the general form. **Impact `CONTAINED`.**

## Phase 5, what was changed

**Verdict: `PROVEN, hypotheses corrected`.** The added hypotheses are criticality of $u$ and $n\ge9$ through L21, both for part 3 only.

- **[route-a.md](../findings/route-a.md)**: the heading states part 3 at $n\ge9$, and the Gate 2 stack and the "fifth statement" paragraph are replaced by a three-part statement with the labels defined, $[\rho(A),u]$ throughout, $0.91$ removed, and a proof writing both inclusions for part 3. The anchor at line 666 follows the new heading.
- **[results.md](../results.md)**: a landscape line and a detail entry, the first L101 has had.
- **[INDEX-results.md](../findings/INDEX-results.md)** row 101 and both **[lean/INDEX.md](../lean/INDEX.md)** rows.
- **[L101Statement.lean](../lean/HamiltonsCubic/Results/L101Statement.lean)**: the docstring quotes the audited statement in place of the old block and its Gate 2 verdict, and `P_zero_of_orbit_tangent_eigenvector` types part 3 with $x=Du$ as hypothesis.
- **[ATTEMPTS.md](../ATTEMPTS.md)**: the removed passages and the round's account.

**The restated lemma is new text**, so L101 re-enters the queue for a repair audit.

## Phase 6

L101 stays in *To check* with its repair audit owed, and the next id is L111.
