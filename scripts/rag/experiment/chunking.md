# Chunking fix: the heading stored once, and short paragraphs merged forward

**Run 2026-11-04 on experiment 1's 26 incidents. On the benchmark the fix is neutral: 6 targets in the reranked top ten against 7 before, a one-case difference inside the noise. On the live I124 query it lifts the section holding the needed bound from rank 117 to rank 19, inside the twenty hits a cycle reads.**

## 1. The change

- **Before:** a markdown chunk's body began with its heading trail, and every reader prepended the trail again, so the embedding model and the reranker, which read the first 1000 characters, saw the heading twice and little of the text. A trail such as "Second-order optimality, and what it detects > Post F12, … > The bound's supremum depends on rank alone, …" filled more than half of that window.
- **After:** [rag.py](../rag.py) stores the heading once, in the chunk's heading field, and a paragraph shorter than 300 characters always merges with the one after it.
- Every chunk's text changed, so the whole record and every eval snapshot were embedded again: about 74000 chunks for the current record and the rest across the snapshots, overnight, no tokens.

## 2. Result

| measure | before the fix | after the fix |
|---|---|---|
| fused search, targets in the top ten | 4 | 4 |
| fused and reranked, targets in the top ten | 7 (I20, I27, I32 added) | 6 (I20, I27 added) |
| live I124 query, rank of findings/second-order.md:1110 | 117 | **19** |

Per incident:

| incident | fused rank before | after | reranked rank before | after |
|---|---|---|---|---|
| I27 | 69 | 42 | 6 | **4** |
| I20 | 29 | 39 | 9 | **5** |
| I32 | 58 | 32 | 6 | 12 |
| I16 | 121 | 51 | 93 | 83 |
| I17 | 83 | 114 | 70 | 114 |
| I04 | 93 | 94 | 69 | 71 |
| I23 | 172 | 173 | 152 | 151 |

- **The benchmark moves both ways.** Fused ranks rise for I16, I27 and I32 and fall for I17 and I20. After reranking, I20 and I27 climb and I32 drops out of the top ten at rank 12. The 15 targets below rank 200 stay there.
- **The live query is the case the fix was aimed at,** and there the section with the M(6) bound enters the twenty hits. The bound itself, two lines further down in the next chunk, is still outside them.
- **The fix is kept:** it removes a real defect, costs nothing per query, and its benchmark effect is within one case.
- Runs: `.rag/eval-rerank/` after the fix and `.rag/eval-rerank-before-chunkfix/` before it, in the private checkout.
