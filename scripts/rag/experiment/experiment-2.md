# Experiment 2: does the tool beat grep for an agent?

**Status: budget version run on 2026-11-03, agent version not run.** The budget version in section 0 runs first: it replaces the agents with a scripted grep, costs no tokens and runs in minutes. The agent version in sections 1 to 8 runs only on the user's approval, since it costs hours of agent time.

## 0. Budget version, run first

The same question, asked of the searches rather than of agents searching with them.

| arm (search method) | what it is |
|---|---|
| G, scripted grep | the query's words of three or more letters, minus common English stopwords, grepped case-insensitive over the text files of the case's snapshot. Matching lines are ranked by how many distinct query words they contain, then by file and line |
| E, the tool | fused keyword and vector search, as in [experiment 1](experiment.md) |

- **Cases:** the 26 incidents of experiment 1, each at its own snapshot. The negatives are left out, since a scripted search always returns something and has no answer to judge.
- **Hits:** the top ten of each arm, scored as in experiment 1: the target line within two lines, the target declaration, or the target's result id.
- **Tokens:** the characters each search returns, divided by four. For G that is every matching line with its file and line number, as an agent's grep prints it. For E it is the twenty hits `rag query` prints.
- **Decision rules, fixed before any run:**
  - Hits: exact two-sided McNemar test, E wins with p < 0.05 and at least 7 more wins than losses.
  - Tokens: sign test over the 26 incidents, E wins when its output is smaller in significantly more cases, p < 0.05.
- **What it answers:** whether the tool ranks the answer higher than grep for the same words, and which search hands an agent less to read. It leaves open how an agent acts on either, since an agent rewords, greps again and reads files. The agent version measures that.
- **Cost:** minutes of compute, no tokens.

### 0.1 Result

**The tool returns about 600 times less text than grep and finds the answer in 4 cases against grep's 1. The output gap is significant, the hit gap is not.**

| measure | G, scripted grep | E, the tool | test |
|---|---|---|---|
| hits in the top ten, of 26 | 1 (I21) | 4 (I13, I14, I15, I21) | McNemar: 3 wins, 0 losses, p = 0.25, no evidence either way |
| median output, tokens | about 1 027 000 | about 1 600 | sign test: E smaller in 26 of 26 cases, p < 0.0001 |

- **Hits:** grep finds only I21. The three cases the tool adds are the Lean proofs done twice, where its declaration chunks carry the exact name. Three wins fall short of the seven the win rule asks.
- **Output:** grep's matching lines run from about 90 000 to 6 million tokens per case, because common words like "every" or "proof" match thousands of lines. The tool returns twenty hits of 1 300 to 2 200 tokens every time.
- **Limit of the token result:** no agent reads a million tokens of grep output. It narrows the words, caps the lines and greps again, so the real gap is smaller than measured here. What the result does show is that a single tool call delivers a ranked, bounded answer, where grep needs that narrowing work first, and the agent version would measure what the narrowing costs.
- Script: [eval_grep.py](eval_grep.py). Runs and summary: `.rag/eval-grep/`.

## 1. The question

[Experiment 1](experiment.md) measured each search method on its own. Experiment 2 measures what a cycle actually does: an AI agent searching the record. It asks whether an agent with the retrieval tool finds more of the results the record already held than an agent with grep, and how many tokens each spends doing it.

## 2. Arms

An arm (search method under test) here is one agent setup. Both arms get the same model, prompt, budget and snapshot, and differ only in the search they may use.

| arm (search method) | what the agent may use |
|---|---|
| A, grep | the findings indexes in its prompt, five grep or glob searches, two file reads, as cycles search today |
| F, tool | the same, with `rag query` (fused search, twenty hits) allowed as any of the five searches |

## 3. Eval set and procedure

- **Cases:** the frozen set of experiment 1, 26 incidents and 8 negatives, each at its own snapshot, so the agent sees the record exactly as the cycle did.
- **Prompt:** the incident's `precatch_text`, the claim as it stood when the miss happened, ending with "report where the repository already holds this, as file:line, or say it does not".
- **Runs:** each case once per arm, 68 agent runs, each a fresh agent with no memory of the others.
- **Scoring:** one cold scorer reads all 68 answers with the arm labels removed and the order shuffled. A hit names the target's line within two lines, its declaration, or its result id. On a negative, a false hit is a named location that does not hold the result.

## 4. Tool used

`rag query` with its default fused search over the sqlite-vec index, twenty hits, as described in [README.md](../README.md).

## 5. What is measured

| measure | what it tells |
|---|---|
| hits, of 26 | which arm finds more of what the record held |
| false hits, of 8 negatives | which arm invents more matches |
| tokens per case, input and output | what each search costs |
| wall time per case | how long each search takes |

## 6. Decision rules, fixed before any run

- **Hits:** exact two-sided McNemar test on the incidents only one arm finds. F wins on hits with p < 0.05 and at least 7 more wins than losses, the rule of experiment 1.
- **False hits:** F may not produce more false hits than A.
- **Tokens:** paired comparison per case, Wilcoxon signed-rank test, two-sided. F wins on tokens with p < 0.05.
- **Verdict:**
  - F wins on hits: the tool becomes the default search of a cycle.
  - F ties on hits (no significant difference) and wins on tokens: the tool becomes the default, as the cheaper search.
  - Otherwise: grep stays the default, and the tool stays an optional lookup.

## 7. Limits

- **Small set:** with 26 incidents, only a large gap in hits can reach significance. A tie on hits means "no large difference", not "no difference".
- **One run per case:** agent answers vary from run to run, and a single run per case folds that variation into the result.
- **Snapshots predate the tool:** the agents search records written before the tool existed, so they measure the tool on the record as it was.

## 8. Cost, an estimate before approval

| item | estimate |
|---|---|
| agent runs | 68, a few minutes each, about 3 to 5 hours in total |
| scorer | one cold agent reading 68 answers |
| tokens | about 30k to 60k per run, so about 2 to 4 million in total |
| compute | snapshots and indexes as in experiment 1, minutes |
