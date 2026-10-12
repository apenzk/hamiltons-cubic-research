# Round L67-r2, the repair audit of the second-kind spectrum of the balanced product

**Id:** L67-r2 · **Date:** 2026-09-14 · **Verifiers:** v406, v407, v408 · **Brief:** [BRIEF_L67r2.md](BRIEF_L67r2.md) · **Logs:** `agent_logs/verify-L67-v406.log`, `agent_logs/verify-L67-v407.log`, `agent_logs/verify-L67-v408.log`

**Why this round.** [ROUND_L67](ROUND_L67.md) replaced the block's annotation stack with a statement carrying its hypotheses and conventions and a full proof, added the $\Lambda^2$ derivation of $p_3(\mu)=A$, and restated both canon entries. That text is new and re-enters unchecked, so L67 is audited again whole.

## Sources, verbatim

| passage | source |
| --- | --- |
| the block, statement and proof | [findings/bispectral.md](../findings/bispectral.md) lines 505, 509-522 |
| the canon | [results.md](../results.md) lines 349, 1167, 1169 |
| Lemma L50's statement and its recorded debts, given | [findings/bispectral.md](../findings/bispectral.md) lines 133-139 |
| the bi-spectral evaluation at the balanced product | [findings/bispectral.md](../findings/bispectral.md) lines 174-198 |
| the $iklj$ convention | [findings/conventions.md](../findings/conventions.md) lines 96-108 |
| the Lean files | [L67Statement.lean](../lean/HamiltonsCubic/Results/L67Statement.lean), [L67.lean](../lean/HamiltonsCubic/Results/L67.lean), declarations only |

**Withheld**: the provenance line at line 507, the rest of the bi-spectral file, every prior round file, the Lean docstrings, and every index row.

## The findings from phase 0

**The statement cites Lemma L50's norm relation for $\lVert W\rVert_F=1$, and L50 states it for $\lVert M\rVert_F=1$ with $M$ the operator on $\Lambda^2$.** Whether the two normalisations are one condition is a convention question the brief asks. Brief item 1.

**The canon's detail entry carries a claim the block does not**: that the $\Lambda^2$ spectrum gives $p_3(\mu)=A$ and that with Lemma L50 the two spectra return $\theta=\theta_0(2m)$ identically in $m$. L50 records two underived links of its own, so the claim inherits them. Brief item 8.

**The Lean statement is not typed.** [lean/INDEX.md](../lean/INDEX.md) files the spectrum under *ready* with its binders, and L67Statement.lean proves the arithmetic around it. Brief item 10.

**Index row 67 in [INDEX-results.md](../findings/INDEX-results.md) still carries Gate 2 commentary**, corrected at the fold whatever the verdict.

## Phase 2, clustering

**Verdicts: [v406](VERIFY_v406.md), [v407](VERIFY_v407.md), [v408](VERIFY_v408.md) all `PROVEN, hypotheses corrected`.** *All three confirm the product curvature $R=G^{(1)}+G^{(2)}$ with its Ricci tensor, $c$ and $W=R-cG$, the $iklj$ contractions with signs matching Li at source, the three invariant summands with their eigenvalues, orthogonality and dimension count, the scale $s$ and $A>0$, the $m=1$ case, the $\Lambda^2$ spectrum with $p_3(\mu)=A$ and $p_3(\omega)$ as algebra, "$A$ is not a new constant", and every boundary case, with no zero eigenvalue of $\mathring W$ or $M$ at $m\ge2$.*

| id | step attacked | mechanism | support | route |
| --- | --- | --- | --- | --- |
| L1 | "normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation" | L50 states the relation for $\lVert M\rVert_F=1$, and with the Frobenius norm over all four indices $\sum\omega^2=\tfrac34\lVert W\rVert^2$, so the reading of $\lVert W\rVert_F$ decides the eigenvalues by a factor $2$ | v406, v407, v408 (`HYPOTHESIS-DEBT`) | **check 2**: the convention is on file |
| L2 | the canon's "with Lemma L50 the two spectra return $\theta=\theta_0(2m)$ identically in $m$" | reading $\theta$ as $\langle W,Q(W)\rangle$ uses L50's coefficient pair, which rests on its underived link (a), $\beta=2\langle M^\#,M\rangle$, and the sign of the $\Lambda^2$ action is stated in none of the passages | v406, v407, v408 (`HYPOTHESIS-DEBT`) | **phase 3**, [ADJ_L67r2_L2.md](ADJ_L67r2_L2.md) |
| L3 | L67.lean and L67Statement.lean | they type the arithmetic of the eigenvalue list only, `A_from_omega` carries an unused hypothesis `hm`, and `Aconst 1 = 0` holds by Lean's $1/0=0$ | v406, v407, v408 (`CONFIRMED AS ALGEBRA`) | **check 1c**: the row already reads `statement: not typed`, and the two remarks are recorded |

**Withdrawn by their verifiers:** Li 2022's printed operator $\sum R_{ijkl}\varphi_{kl}$ as a typo for the $iklj$ order its proofs use (v407, v408), the omitted projection onto trace-free tensors, the short step identifying $R-cG$ as the Weyl tensor, and the fill-by-dimension step, which the block structure covers (v408), with others recorded in each report. **v407 notes that Li's Theorem 1.8 gives the spectrum of $\mathring R$**, so it matches the lemma after subtracting $c$ and rescaling, which Passage D writes out and Passages A and B leave implicit. v406 and v408 confirm the same sentence.

**Check 1, the brief against the source.** Every passage was copied off disk with its first words asserted. **L1 is brief-induced**: the brief's definitions said the passages fix no relation between $\lVert W\rVert_F$ and $\lVert M\rVert_F$, and withheld the conventions that do.

**Check 2, the whole record.** **L1 resolves**: [conventions.md](../findings/conventions.md) line 92 states $\lvert W\rvert^2=4\lVert W\rVert_F^2$ as the relation between the two $\Lambda^2$ normalisations, with $\lvert W\rvert^2$ the sum over all four indices, and line 93 fixes $\mu$ at $\lVert M\rVert_F=1$ with $\sum\mu^2=1$ and $\sum\omega^2=3$. So the record's $\lVert W\rVert_F$ is $\lVert M\rVert_F$, and the statement's normalisation is the one the proof meets. The repair is a pointer to that line. **L2 does not resolve**: link (a) is recorded as underived in L50's own block at [bispectral.md](../findings/bispectral.md) line 139 and in [ATTEMPTS.md](../ATTEMPTS.md), and no derivation occurs elsewhere. **Copies of the statement**: the report's Lemma 67 at [06b-bispectral.tex](../report/sections/06b-bispectral.tex) line 72 states the spectrum and also $p_3(\mu)$, $p_3(\omega)$ and $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$ inside the lemma. [bispectral.md](../findings/bispectral.md) line 202 uses the isolated bottom eigenvalue $-2m(m-1)A$.

## Phase 3, adjudication

**Two fresh verifiers on L2, asked the step neutrally:** v409 and v410.

| id | adjudicators | outcome |
| --- | --- | --- |
| L1 | check 2 | **resolved from the record**, repaired by a pointer |
| L2 | [v409](VERIFY_v409.md) `VALID`, [v410](VERIFY_v410.md) `VALID` | **withdrawn** |
| L3 | check 1c | **recorded**, no change |

**The defence of L2.** With Lemma L50 as a given, the single scale $s$ realises $\sum\mu^2=1$ and $\sum\omega^2=3$ at once, $p_3(\mu)=A$ and $p_3(\omega)=-(4m^2-6m-1)A$, and $\tfrac32A+\tfrac12(4m^2-6m-1)A=(m-1)(2m-1)A=\sqrt{(m-1)(2m-1)}/m=\theta_0(2m)$, one line of exact algebra where Passage D cites a run. The step adds no debt to L50's and inherits L50's. It needs the round sphere to act as $+\mathrm{Id}$ on $\Lambda^2$, which Passage D's "acts as the identity" fixes. v409's screen of $\langle M,M^2+M^\#\rangle$ in Hamilton's convention agrees.

**A finding against Lemma L50, transferred.** Both adjudicators independently found L50's remark "with $\beta=c\sigma$ the identity reads $\tfrac{2+c}cp_3(\mu)-\tfrac1cp_3(\omega)$" inconsistent with its own display: $\tfrac1c=\tfrac12$ forces $c=2$, where $\tfrac{2+c}c=2$ against the displayed $\tfrac32$, and $\tfrac{1+c}c$ gives the pair at $c=2$. It is L50's text, so it is queued in [plan-verification.md](../plan-verification.md) as a question for L50's next round, not adjudicated here.

## Phase 4, dependents

**No dependent loses support.** The normalisation is unchanged in value, only named. [bispectral.md](../findings/bispectral.md) line 202 uses the isolated bottom eigenvalue and `SURVIVES`. The report's Lemma 67 states $p_3(\mu)$, $p_3(\omega)$ and the $\theta_0(2m)$ identity as algebra, which both adjudicators confirm, and it `SURVIVES` with its normalisation named. **Impact `CONTAINED`.**

## Phase 5, what was changed

**Verdict: `PROVEN, hypotheses corrected`.**

- [bispectral.md](../findings/bispectral.md), [results.md](../results.md) lines 349 and 1169, and [06b-bispectral.tex](../report/sections/06b-bispectral.tex): $\lVert W\rVert_F=1$ named as the Frobenius norm on $\Lambda^2$, with the block pointing at [conventions.md](../findings/conventions.md). The report was rebuilt.
- [INDEX-results.md](../findings/INDEX-results.md) row 67: the Gate 2 status replaced by the verdict.
- [ATTEMPTS.md](../ATTEMPTS.md): the round's account and the replaced passages.

**No new argument entered**, so L67 leaves *To check*.

## Phase 6

L67's box is deleted from *To check*, one line goes under *Checked*, and the L50 finding is queued. The next id is L84.
