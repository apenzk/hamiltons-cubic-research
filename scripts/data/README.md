# Stored data

**Fifteen `.npy` files in [scripts/data/](data/), 368 KB, tracked deliberately against the `*.npy` ignore rule.**

They are tracked because **no script in this tree writes them**. Each is a witness or a frontier point found by a search whose saving code no longer exists, and several are loaded by scripts that would fail without them, so they are primary data, not cache, and a `git clean` would have destroyed them.

| file | what it holds | read by |
| --- | --- | --- |
| `gap_band_point_n8.npy` | the $n=8$ band point, a $28\times28$ operator | [review_r11a_independent.py](../misc/review_r11a_independent.py) |
| `defect_violation_n8_0.120000.npy` | the $3/25$ defect violator at $n=8$ | [review_r11a_independent.py](../misc/review_r11a_independent.py), [review_r11_ricci_spread.py](../reviewers/r11/review_r11_ricci_spread.py) |
| `defect_theta0_n8_0.125000.npy` | the companion point at $\delta^2=1/8$ | as above |
| `frontier_n{6,8,12}_th…_d2….npy` | frontier points of the $(\theta,\delta^2)$ sweeps, named by the values they carry | reviewer 261's step-iii scripts |
| `review_r40_W_cpm{3..8}.npy` | the $\mathbb{CP}^m$ Weyl tensors, $m=3\ldots8$ | [review_r40_isotypic.py](../reviewers/r40/review_r40_isotypic.py) |
| `review_r61_best_stratum_m{6,8}.npy` | the best two-negative stratum points at $m=6,8$ | reviewer 61's scripts |

**What was deleted on 2026-08-31:** `review_r40_Le_cpm{3,4,5}.npy`, 5.4 MB of $L_e$ operators, which *are* regenerable, [review_r40_cpm.py](../lib/review_r40_cpm.py) and [review_r40_proof.py](../lib/review_r40_proof.py) both write them, and [review_r40_isotypic.py](../reviewers/r40/review_r40_isotypic.py) rebuilds them when absent.

*One loader is already broken independently of this*: [review_r40_proof.py](../lib/review_r40_proof.py)'s `commutant` path loads `review_r40_Bs_n*.npy`, which has never existed in the tree.
