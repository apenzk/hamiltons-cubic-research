# Review r222 -- Gate 2, adversarial

Brief: `brief17.md`. Commits under review: 1bf0974, 6ca5418, 7479d70. Assigned claims 1 and 2 (reviewer 223 ran 3-5 concurrently).

## Verdicts

| # | Claim | Verdict |
|---|---|---|
| 1 | dim^1.77 from three timings supports the 42-hour extrapolation | **REFUTED** |
| 2 | reported nullities equal the character multiplicities | pending |

Scripts: [scripts/reviewers/r222/](../scripts/reviewers/r222/). Log: [agent_logs/gate2_222.log](../agent_logs/gate2_222.log).

---

## Claim 1 -- REFUTED. The exponent is 2.18, and the trivial block is a week

[7479d70](https://github.com/apenzk/hamiltons-cubic/commit/7479d70) writes an exponent of 1.77 into the docstring of [run_n12_covariants.py](../scripts/runs/run_n12_covariants.py) and extrapolates the 635,220-column trivial block to about 42 hours. Every number below comes from [r222_scaling.py](../scripts/reviewers/r222/r222_scaling.py), which parses the three committed run logs rather than re-typing the commit message; full output in [out_scaling.txt](../scripts/reviewers/r222/out_scaling.txt).

### 1a. The three timings are two dimensions, so the fit has zero degrees of freedom

The measurements are 27,030 -> 578.6 s and 34,731 -> 901.0 s and 894.1 s. The last two are the **same dimension** -- the chirality pair (2,2,1,1,1,-1) and (2,2,1,1,1,1) have identical dim and identical row counts. A repeat at a fixed dimension constrains no exponent. So a one-parameter power law is being fitted to **two** points, and it passes through both exactly. Zero residual here is a property of the arithmetic, not evidence about the model.

The check that cannot fail: three two-parameter models fitted to the identical two points, each with residual exactly zero on both, and their extrapolations to 635,220 columns.

| model fitted to the same two points | residual at both points | trivial block |
|---|---|---|
| t = c n^1.77 | 0 | 42.8 h |
| t = a + b n^2 (a = 83.3) | 0 | 76.0 h = 3.2 d |
| t = a + b n^3 (a = 291.1) | 0 | 1036.6 h = 43.2 d |

The data as used cannot separate 1.8 days from 43 days.

### 1b. The repo already held a held-out point, measured before the commit, and it falsifies the fit

[agent_logs/n12_tier3.log](../agent_logs/n12_tier3.log), written 30 August 00:20, eight hours before 7479d70, times (2,2,1,1,0,0) at **62,101 columns -> 4020.5 s**.

| | |
|---|---|
| predicted by k = 1.77 from the 34,731 point | 2515.4 s |
| measured | 4020.5 s |
| shortfall over only 1.79x in dimension | **1.60x** |

Local exponent between 34,731 and 62,101 **within that one log**, so same machine and same batch: **k = 2.36** against (2,2,1,1,1,-1) and **k = 2.42** against (2,2,1,1,1,1). The exponent is already above 2.4 at the top of the measured range, and rising.

### 1c. The full data set is 19 blocks, not 2, and it gives k = 2.18

[n12_mark.log](../agent_logs/n12_mark.log) (14 blocks, 4,186 to 27,030) and [n12_tier3.log](../agent_logs/n12_tier3.log) (5 blocks, to 62,101) were both committed before 7479d70. Log-log regression over all 19 distinct blocks, taking the *fastest* timing wherever a block was run twice -- the choice most generous to the claim:

| fit | k | trivial block |
|---|---|---|
| commit, 2 points | 1.77 | 42.5 h |
| all 19 blocks | **2.176** | **158.8 h = 6.6 d** |
| upper half of the range only | 2.132 | 140.5 h = 5.9 d |

Residual sd of the global fit is 0.111 in log t, about 12 percent -- so k = 2.18 is a real fit with scatter, where k = 1.77 is an interpolation between two points.

### 1d. The brief's question, answered directly

*What exponent makes the answer a week instead?* From the 62,101 point, **k = 2.156**. *Does the data exclude it?* The data **prefers** it. The global fit is 2.176 and the two local exponents nearest the extrapolation are 2.36 and 2.42. A week is the central estimate; 42 hours needs k = 1.56, which no measured pair above 20,000 columns supports.

### 1e. The choice among duplicate timings moves the answer by 14x

Three of the four blocks in the commit's fit were timed twice, and the same block varies 9-13 percent between runs:

| block | n | timings | spread |
|---|---|---|---|
| (3,2,1,0,0,0) | 27,030 | 632.4 s (mark), 578.6 s (tail) | +9.3% |
| (2,2,1,1,1,-1) | 34,731 | 1021.6 s (tier3), 901.0 s (tail) | +13.4% |
| (2,2,1,1,1,1) | 34,731 | 985.8 s (tier3), 894.1 s (tail) | +10.3% |

The commit took the fastest available reading at the small dimension and a fast reading at the large one. The four admissible pairings give:

| pair | k | trivial block |
|---|---|---|
| 632.4 / 901.0 | 1.412 | 15.2 h |
| 578.6 / 901.0 (**the commit's**) | 1.767 | 42.5 h |
| 632.4 / 1021.6 | 1.913 | 73.8 h |
| 578.6 / 1021.6 | 2.268 | **206.8 h = 8.6 d** |

A 14x spread in the headline number, entirely from which repeat of the same two blocks you read. The commit's claim that the chirality pair "checks the timing for free" is backwards: the pair is a *replicate*, so what it measures is the noise floor, and the cross-log replicates put that floor at 10-13 percent, not the 0.8 percent the in-log pair suggests.

### 1f. Fill-in, not size, is what varies -- the brief's structural question

Cost is not a function of n on this data.

| comparison | difference in n | difference in t |
|---|---|---|
| (4,0,0,0,0,0) 22,280 -> 343.3 s vs (2,2,2,1,1,0) 21,664 -> 400.0 s | 2.8% | **16.5%**, and the *smaller* block is the *slower* one |
| (3,1,1,1,0,0) 42,218 -> 1566.7 s vs (2,2,2,0,0,0) 39,660 -> 1567.2 s | 6.1% | 0.0% |

The systematic driver visible in the logs is the row-to-column ratio, which is not constant across the tail: it climbs from 2.56 at n = 4,186 to 3.22 at n = 62,101. The extrapolation is stated in columns alone, but the matrix passed to `sparse_rank` is rows x cols, and rows grow faster than cols across the measured range. `t/n^2` climbs monotonically over the same range, 0.57 to 1.04 microseconds -- the signature of fill-in growing faster than the matrix does. Extrapolating an exponent measured at 27k-35k columns 18x out to 635k columns assumes that drift stops exactly where the measurements stop.

**Verdict.** The exponent 1.77 is an artefact of using two of the nineteen available points and the faster reading of each. The repo's own committed data gives 2.18, an out-of-sample point that the fit under-predicts by 1.60x, and a trivial-block cost of about a week. The docstring's hedge -- "a measurement from three timings ... stated as an extrapolation and not as a bound" -- correctly labels the *status* of the number but not its *value*: the number is wrong by a factor of roughly four against the best estimate the repo can currently make.

*(claim 2 in progress)*
