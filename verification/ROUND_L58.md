# Round L58, the graded set is strictly wider than the subalgebra family

**Id:** L58 · **Date:** 2026-09-14 · **Verifiers:** v256, v257, v258 · **Brief:** [BRIEF_L58.md](BRIEF_L58.md) · **Logs:** `agent_logs/verify-L58-v256.log`, `agent_logs/verify-L58-v257.log`, `agent_logs/verify-L58-v258.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the statement and witness table | [findings/ungraded-slack.md](../findings/ungraded-slack.md) lines 330-336 and 343 |
| the argument | [findings/ungraded-slack.md](../findings/ungraded-slack.md) lines 152-165 |
| the landscape statement | [results.md](../results.md) line 192 |
| the canonical entry | [results.md](../results.md) line 669 |
| L23, the given | [results.md](../results.md) lines 507-517 |
| the senses of graded | [conventions.md](../findings/conventions.md) line 150, [INDEX-traps.md](../findings/INDEX-traps.md) line 21 |

## The findings from phase 0

**The canon carries the witness the block withdrew.** Both canonical entries still list $(\mathfrak{su}(3),\mathfrak{so}(3))$, and the detail entry quotes "the family value there, $1.2742878$" at $r=31$, which the block's own annotation says lies above L23's cap $r\le30$ at $n=12$, so no family member exists to have that value. Brief item 4.

**Gradedness of the witnesses is asserted, not argued.** The block's column says $\mathbb{CP}^3$ is graded "in all three of the record's senses" and the argument section's evidence for it is a numerical slack $S=2\times10^{-30}$; the multiplicities and eigenvalues in the table are derived in no quoted passage. Brief items 2 and 7.

**$\thstar$ in the block's last sentence is defined nowhere quoted**; the argument section reads $\sqrt{3/2}$ there. Brief item 5.

**No Lean statement file exists**; [L58.lean](../lean/HamiltonsCubic/Results/L58.lean) checks the Casimir eigenvalue arithmetic and the witnesses' traces. *Phase 1c is assessed after the reports.*

## Adjudication

**Verdicts: [v256](VERIFY_v256.md), [v257](VERIFY_v257.md), [v258](VERIFY_v258.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, repaired and narrowed, impact `CONTAINED`.** *Unanimous: the Casimir exclusion is proved, and no witness had criticality, gradedness and a three-valued spectrum all argued on file.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the Casimir step | exactly two eigenvalues, needing $c\ne0$ and nothing about $\mathfrak h$; both are nonzero, so a Casimir has zero kernel | v256, v257, v258 | **confirmed**, both clauses written in |
| C2 | the $S^5\times S^7$ witness | spectrum printed without derivation, $\theta$ only a decimal on the record, pair-grading via L69 | v256, v257, v258 | **debt, discharged**: spectrum derived from the product's curvature operator, criticality and $\theta^2=\tfrac{264}{175}$ from L46 |
| C3 | the $\mathbb{CP}^3$ witness | spectrum not given, sign-grading unargued, gradedness evidence a numerical slack | v256, v257, v258 | **removed** from the lemma; one witness suffices |
| C4 | the $W_{\mathbb{CP}^2}$ row | named no sense of graded; a nonzero kernel excludes a Casimir, which was not written | v256, v257, v258 | **repaired**: pair-graded, the kernel exclusion stated |
| C5 | the withdrawn $(\mathfrak{su}(3),\mathfrak{so}(3))$ row, still in the canon | graded in no established sense, its $7$-dimensional kernel ruling out the sign sense | v256, v257, v258 | **removed** from both canon entries |
| C6 | "the family value there is $1.2742878$" at $r=31$ | L23 caps $r\le30$ at $n=12$; its formula there gives $S_{\mathfrak{mmm}}=-\tfrac{70}3$ | v256, v257, v258 | **confirmed**, deleted |
| C7 | "above $\thstar$" and "at every threshold" | $\thstar$ undefined; shown only below $\theta(S^5\times S^7)$ | v256, v257, v258 | **confirmed**, restated as thresholds up to $\theta(S^5\times S^7)$ |
| C8 | "the graded case needs L69" | L69 covers pair-graded, kernel-free, $n\ge12$ above $\sqrt{3/2}$ only | v256, v257, v258 | **confirmed**, restated |
| C9 | the Lean docstring | "either survivor proves the lemma alone" while the file checks arithmetic only | v256, v257, v258 | **confirmed**, corrected, the $S^5\times S^7$ arithmetic from the curvatures added |

**No adjudication pair was spent**: *every finding is unanimous, and the refutations carry exact witnesses.*

### The repair

**The $S^5\times S^7$ witness is now proved in the block**, each step resting on [L46](ROUND_L46.md), audited this session, and the product's block curvature operator; its arithmetic (the three eigenvalues from $\lambda/4$, $\lambda/6$, $\lambda/11$, trace zero, $\lVert W\rVert^2=\tfrac{175}{264}\lambda^2$, $\tfrac{264}{175}>\tfrac32$) is kernel-checked. *The round re-read the repair against those constants before closing.*

### Dependents

- **[results.md](../results.md)'s status table and Lemma L69's entry** cite the graded-versus-family distinction, which stands.
- **The later block in [ungraded-slack.md](../findings/ungraded-slack.md) citing L58** uses only the mechanism.
