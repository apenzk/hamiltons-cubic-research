# Reranker: does rescoring the fused top 200 lift the target?

**Run 2026-11-03 on experiment 1's 26 incidents. With the reranker the tool finds 7 targets in its top ten against 4 without, with 3 wins and no loss. The direction is consistent, the sample too small for significance (McNemar p = 0.25).**

## 1. Method

- **Arms (search methods):** E, the fused keyword and vector search of [experiment 1](experiment.md); R, the same search with [Qwen3-Reranker-0.6B](https://huggingface.co/Qwen/Qwen3-Reranker-0.6B) rescoring the fused top 200 before the live-first sort.
- **Reranker:** run locally at fp16, reading the query and each chunk's first 1000 characters together and returning the probability that the chunk answers the query, under the instruction "Given a mathematical claim, retrieve passages of a research record that state, prove or bound it".
- **Cases:** each incident at its own snapshot, scored on the top ten by experiment 1's rule. The target's rank in each arm's top 200 is recorded as well.
- Script: [eval_rerank.py](eval_rerank.py). Runs: `.rag/eval-rerank/` in the private checkout.

## 2. Result

| measure | E, fused | R, fused and reranked |
|---|---|---|
| targets in the top ten, of 26 | 4 (I13, I14, I15, I21) | 7 (adds I20, I27, I32) |
| comparison | | 3 wins, 0 losses, McNemar p = 0.25 |

Per incident:

| incident | rank without reranker | rank with reranker |
|---|---|---|
| I27 | 69 | **6** |
| I32 | 58 | **6** |
| I20 | 29 | **9** |
| I16 | 121 | 93 |
| I04 | 93 | 69 |
| I17 | 83 | 70 |
| I23 | 172 | 152 |
| I21 | 1 | 4 |
| I13, I14, I15 | 1, 3, 2 | unchanged |

- **Of the 11 targets the search reaches in its top 200, the reranker lifts 7 and lowers 1**, which stays a hit. The other 15 targets lie below rank 200, where the reranker never sees them.
- **The live I124 query of 2026-11-03 is not lifted:** its target chunk holds mostly the section heading, and the bound it needed sits in the next chunk. That is the chunking defect, a heading stored twice, which a separate fix addresses.
- **Cost:** about 50 seconds per live query, most of it loading both models, against about 6 without the reranker, and no tokens. The model is 1.1 GB.
