# Step 8 position file, 2026-09-03, second pass

*Written on Opus before the switch to Fable, per [SKILL.md](../.claude/skills/research-loop/SKILL.md)'s step 8 table (item 3). The sweep reads this file and nothing else of the record whole.*

## Why the plan is empty

Section 1 has no item with a live method. I22 is delivered ([Lemma L128](../findings/second-order.md)); **I18 is BLOCKED**, not refuted, but without a next step, its three clauses' inputs all closed or priced; I5 is blocked on I18; L16's two halves are fenced and blocked respectively; I1 and I7 are grade 0 with no known route by construction.

## The one structural fact this pass must carry

**The two live routes are not independent.** [R16](../routes.md)'s isolation programme owes *the non-pure critical set above $\sqrt{3/2}$ is compact* (I5), and [R17](../routes.md)'s chain owes the same statement for its Łojasiewicz closure. **One theorem unblocks both.** It in turn needs I18, which is the blocked item, so the whole live frontier bottoms out in one place.

## Open nodes, with what each owes

| node | owes | state |
|---|---|---|
| **L16(a)**, the grant $J_5\ge0$ | a sign for $\operatorname{tr}(X_{\mathrm{inv}}\#W_-)=\tfrac12\sum x_i\mu_j\lVert[u_i,v_j]\rVert^2$, $x_i$ **indefinite** | fenced on four sides; one of three unsigned terms |
| **L16(b)**, global closure | the compactness I5 would prove | blocked |
| **I5** | I18 | blocked (I21 discharged) |
| **I18** | a mechanism that is not a rearrangement of [post F47](../findings/INDEX-traps.md)'s eigen-equation | BLOCKED |
| **I1 / I7** | a route | none known |

## Fence posts bearing on the open nodes

- **[F54](../findings/INDEX-traps.md)**, re-bounding $H$ by trace data cannot close $J_5\ge0$.
- **[F55](../findings/INDEX-traps.md)**, the three-term $\#$-form has zero $\Lambda^4$ content; the $\#$-trace collapses against $W$ and $I$.
- **[F56](../findings/INDEX-traps.md)**, $\mathrm{Ric}$ is rank one on $\operatorname{span}\{W_+,W_-\}$, so the polarised scal identity returns $\tfrac{\alpha+\beta}{4}J_5$ at *every* argument there. **Any rewrite of the grant through $W$'s spectral parts is closed.**
- **[F41](../findings/INDEX-traps.md)**, $\mathrm{ad}(v)$'s marginals buy nothing; only the Jacobi identity separates a torus from a balanced product. *Stands over every aggregate of bracket data.*
- **[F51](../findings/INDEX-traps.md), [F52](../findings/INDEX-traps.md), [F47](../findings/INDEX-traps.md)**, the pair-clause rearrangements, all inert.
- Refuted outright, not merely fenced: $X_{\mathrm{inv}}\succeq0$, $\mathrm{Ric}(X_{\mathrm{inv}})\succeq0$, and both congruence intermediates. **The whole ladder between the scalar target and operator positivity is closed.**

## What previous sweeps already covered, do not repeat

- **[2026-09-02](2026-09-02-LIT-step8-sweep.md)**, chose R16. Its Route 1 became I22…I7.
- **[2026-09-03, first pass](2026-09-03-LIT-step8-sweep.md)**, six batches. Found: multi-bubble stability, quantitative stability/deficit, Łojasiewicz, and Böhm–Wilking's Lemma 2.1 already in [references/](../references/) and unused. Proposed four routes; the user chose **Routes 1 and 2**.
  - **Route 1 is now spent.** It produced [Lemma L131](../findings/isotropy-cap.md) and posts F55/F56, and every rewrite it suggested was already the record.
  - **Route 2 is blocked**, on I5.
  - **Route 3 (partition in place of a two-regime comparison) was never opened** and is the one candidate no post touches.
  - **Route 4 ($\ell_{a,b}$ transformation law) was never opened.**

## The standing hazard for this sweep

**Ten consecutive proposals in this programme turned out to be statements the record already held**, in forms a grep of [findings/](../findings/) could not see. Two lessons, both earned this session: query [ATTEMPTS.md](../ATTEMPTS.md) **by mechanism**, and screen [reviews/](.) and [references/](../references/) too, the eighth instance was a convention stated only in a reviews file, and the tenth was a passing remark inside a derivation in the notebook.

**And a demonstration must consume the objects it names.** One post concluded an identity was useless because substituting it into its own source returned a tautology, true of any identity, and no evidence at all.

## Analysis only

Computation requires the user's approval for the specific task. Screening a claim about to be recorded is permitted, seconds, on objects built for it, reported as a screen and never as evidence for a positive claim.
