# Which embedding model arm D uses

**Arm D runs on [Qwen3-Embedding-0.6B](https://huggingface.co/Qwen/Qwen3-Embedding-0.6B), locally, with [bge-m3](https://huggingface.co/BAAI/bge-m3) as the second model if one is run.** Decided 2026-11-02, after the keyword arms showed that BM25 misses the eval targets on vocabulary and the throughput below made the planned two-model run cost about six hours.

## Constraints

- **Local only.** The record is unpublished until the export's leak check covers it, so every chunk is embedded on this machine and no text goes to an embedding API.
- **Size of the job.** 160717 distinct structured chunks across the eval snapshots, measured by [eval_keyword.py](eval_keyword.py).
- **Hardware.** One local machine, PyTorch 2.15 on its GPU.

## Measured throughput

640 random chunks of the HEAD index, embedded with [sentence-transformers](https://sbert.net) 6.2 and batch size 32.

| model | precision | max tokens | cut (chars) | batches | chunks/s | 160717 chunks |
|---|---|---|---|---|---|---|
| Qwen3-Embedding-0.6B | fp32 | 512 | 2000 | unsorted | 5.7 | 7.8 h |
| Qwen3-Embedding-0.6B | fp16 | 512 | 2000 | sorted by length | 8.2 | 5.4 h |
| Qwen3-Embedding-0.6B | fp16 | 256 | 1000 | sorted by length | 15.1 | 3.0 h |

The median chunk is 343 tokens at the 2000-character cut, so the 256-token setting embeds the heading and the first part of most chunks.

## Published evidence

| | Qwen3-Embedding-0.6B | EmbeddingGemma 300M |
|---|---|---|
| SABER-Math, math retrieval, overall | 0.57, rank 14 of 34 | 0.52, rank 20 of 34 |
| MTEB multilingual v2 | 64.33 | 61.15 |
| MTEB English v2 | 70.70 | 68.36 |
| MTEB code v1 | 75.41 | 68.76 |
| parameters | about 600M | about 308M |
| download, weights (MB) | 1192, `model.safetensors` | 1229, `model.safetensors` plus two dense heads |

Weight sizes from the Hugging Face file listings. Both ship fp32 weights, so EmbeddingGemma's smaller parameter count does not make it a smaller download. The Qwen snapshot on disk here is 1152 MiB. [bge-m3](https://huggingface.co/BAAI/bge-m3) ships 2271 MB as `pytorch_model.bin`, a pickle, which PyTorch 2.15 loads with `weights_only=True` by default.

Sources: SABER-Math scores from the benchmarklist profiles of [Qwen3-Embedding-0.6B](https://benchmarklist.com/models/qwen3-embedding-0.6b-2/) and [EmbeddingGemma](https://benchmarklist.com/models/embeddinggemma/), both marked uncurated and self-reported. MTEB scores from [DataLearner's comparison](https://www.datalearner.com/ai-models/pretrained-models/embeddinggemma-300m). EmbeddingGemma's own account is its [paper](https://arxiv.org/html/2509.20354v3), which ranks it first among models under 500M parameters.

**Mathematics is a weak domain for general embedders.** [MIRB](https://arxiv.org/html/2505.15585v1) evaluates 13 retrievers on 12 mathematical datasets and finds them moderate on statement retrieval and weak on premise retrieval, the task closest to ours. Its leaders are [voyage-3-large](https://blog.voyageai.com/2025/01/07/voyage-3-large/) at 54.54 average nDCG@10 and 7B open models around 52. It tests neither model above. HAKARI-Bench reports that general MTEB rank does not predict mathematical retrieval, so the eval set of this experiment is the test that decides.

## Decision

- **Qwen3-Embedding-0.6B is the primary model.** It leads EmbeddingGemma on the one mathematical benchmark that scores both, and on every MTEB track, and the eval run is the decisive measurement, so quality outranks the roughly 1.5 hours EmbeddingGemma would save.
- **It runs at fp16, 256 tokens, 1000-character cut, length-sorted batches**, about three hours for the eval snapshots.
- **bge-m3 stays the second model, as the plan named it.** EmbeddingGemma is the faster alternative for that slot. A second model runs only if the first reaches about 10 of 26 targets, since below that the agent ladder cannot clear the win rule.
- **Cloud embedders are out of scope** under the local-only constraint, though voyage-3-large leads MIRB.
