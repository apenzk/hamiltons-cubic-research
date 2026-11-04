# Lookup test: the tool on six open plan items

**Run 2026-11-03 on -internal main at 1791c6aa. Three of six queries surface material a cycle working the item should read first, two return little beyond the item itself, and one is mixed.** The test asks what the tool returns today for live work, with no agent and no scoring rule, so each verdict below is a judgement on the top eight hits.

## 1. Method

- **Index:** `rag.py index` over the main checkout, 106619 chunks, 133 newly embedded.
- **Queries:** the theorem sentence of six open items in plan.md, SECTION 1, run with the default fused search, top eight read.
- **Cost:** about 5000 tokens of output for all six, and about 40 seconds of compute.

## 2. Results

| item | useful hits | verdict |
|---|---|---|
| I68, a rank bound at every non-diagonal critical point | post F63 in findings/fence-posts.md (high $\Lambda^2$-rank does not suppress $\theta$), its row in INDEX-traps.md, Lemma L105 on the rank-$\le3$ family in results.md | **useful:** the fence post that limits the item is hit 1 |
| I71, the $N-1$ uncontracted criticality rows | Lemma L198 (one uncontracted row bounds $\theta$) and L199 in findings/bounds.md, RowBound.lean, the r293 row-count script, Lemma L72 on the overdetermined rank-3 stratum | **useful:** the lemmas the item builds on, in the top eight |
| I124, ascent above $\theta_0$ | I124Statement.lean, where the item is already typed in Lean, and the sign-flip decomposition in findings/second-order.md | **useful:** points to the existing Lean statement |
| I115, the Frobenius norm of $\#$ | screen_I73_sharp_cubic_norm.py (the Hölder bound for $\#$ on $\mathrm{Sym}^2\mathfrak{so}(n)$), the Bloch–Iserles notes on skew commutators | **mixed:** two relevant hits among Frobenius-norm helpers from unrelated scripts |
| I117, the $\#$ half of P by statement H | none that names H or U$_{\mathrm s}'$. Lemma L270 in findings/second-order.md, which the item reduces to, is absent | **weak** |
| I123, coupling P's two halves | the item's own rows in plan.md and routes.md, then sphere-product helpers from reviewer scripts | **weak** |

## 3. What it shows

- **The tool finds prior results named in the query's own terms.** Rank bounds, criticality rows and an existing Lean statement all came back near the top.
- **It misses a result the item reduces to when the query does not name it.** I117's query says "statement H" and the record states L270 as U$_{\mathrm s}'$, the same gap experiment 1 found.
- **Noise has two sources:** the plan's and route register's own rows for the item, and helper functions in scripts/reviewers/. Both rank high on shared vocabulary and carry no new information.
- **Next step:** shadow mode in real cycles, logging per query whether a hit changed what the cycle did.
