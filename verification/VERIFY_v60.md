# Verifier v60, D1: is the 40-point injectivity on $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$ established by what is on file?

*The brief was cold: one step, one question, no verdict from any earlier report was read before the files were. **No numerical work was done. Nothing was executed**, every file below was read as text, and the only arithmetic in this report is closed-form inequality reasoning about floating-point error that needs no machine. Log: [agent_logs/verify-L61-v60.log](../agent_logs/verify-L61-v60.log).*

## Verdict table

| step | verdict | reason |
| --- | --- | --- |
| Evaluation at the 40 sample points is injective on the 14-dimensional $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, so agreement of the Gram's sextic with $F_5$ there is equality | **FAILS** | the only instrument on file is a float64 SVD numerical rank at [c4_ev_injective.py:63-64](../scripts/reviewers/r213/c4_ev_injective.py), and injectivity needs a **lower** bound on the rank, which no floating-point rank supplies without a bound on the perturbation, and no such bound is computed, printed, or derivable from what the script records |

**One-line summary.** The conclusion is almost certainly true and the evidence for it is strong, but it is evidence: the supporting computation converts exact `Fraction` data to float64 at [c4_ev_injective.py:34-35](../scripts/reviewers/r213/c4_ev_injective.py) and then decides rank by a stipulated relative threshold, so what is on file is an approximation with a threshold where the step needs an exact statement over a field, and the exact instrument sits unused in the same directory, at [c3_holdout.py:80](../scripts/reviewers/r213/c3_holdout.py).

## 1. What the step needs, stated exactly

Write $V=(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, and let $\mathrm{ev}:V\to\mathbb R^{40}$, $f\mapsto(f(W_1),\dots,f(W_{40}))$ be evaluation at the pipeline's 40 sample tensors. The step asserts $\ker(\mathrm{ev})=0$.

Two facts are supplied to reduce this:

- $\dim V=14$, computed exactly, [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) does Weyl integration for $B_2$ in Laurent polynomials over $\mathbb Z$ with `Fraction` coefficients, materialising nothing, and [run_n5_verify.py:143-144](../scripts/runs/run_n5_verify.py) records two further routes (Kostant, Sage plethysm). This is an exact statement, and I take it as given.
- The 120 columns of the test matrix are complete metric contractions of $W^{\otimes6}$ over perfect matchings of the 24 slots ([c4_ev_injective.py:41-61](../scripts/reviewers/r213/c4_ev_injective.py)). By the first fundamental theorem for $O(n)$, stated in the repository at [weyl_invariants.py:4-7](../scripts/reviewers/r179/weyl_invariants.py), each such contraction lies in $V$. So each column of the $40\times120$ matrix $M$ is $\mathrm{ev}$ applied to an element of $V$, and $\mathrm{rank}\,M\le\dim V=14$.

Given those two, injectivity is equivalent to the single inequality

$$\mathrm{rank}_{\mathbb Q}\,M\ \ge\ 14 .$$

Every column is a rational number: the sample tensors are built in exact `Fraction` arithmetic from integer coefficients in $[-4,4]$ against the rational basis `wm.BASIS` ([c4_ev_injective.py:28-33](../scripts/reviewers/r213/c4_ev_injective.py)), and a complete contraction of six of them is a rational polynomial in those entries. So $M$ is an exact rational matrix, and $\mathrm{rank}_{\mathbb Q}M$ is a well-posed question over a field.

## 2. What is on file instead

The exactness is discarded three lines after it is built.

| line | what happens | consequence |
| --- | --- | --- |
| [c4_ev_injective.py:34-35](../scripts/reviewers/r213/c4_ev_injective.py) | `float(R[a][b][c][d])`, the `Fraction` tensor becomes a float64 array | the exact matrix is never formed |
| [c4_ev_injective.py:37-39](../scripts/reviewers/r213/c4_ev_injective.py) | each tensor divided by its float max | a diagonal row scaling; rank-neutral, and correctly annotated as such |
| [c4_ev_injective.py:59](../scripts/reviewers/r213/c4_ev_injective.py) | `np.einsum(ss, *([t]*6), optimize=True)` in float64 | the entries of the matrix actually formed are $\hat M=M+E$ for an unrecorded $E$ |
| [c4_ev_injective.py:61](../scripts/reviewers/r213/c4_ev_injective.py) | `col/np.abs(col).max()` | a diagonal column scaling; rank-neutral, but it rescales $E$ by a factor never recorded |
| [c4_ev_injective.py:63-64](../scripts/reviewers/r213/c4_ev_injective.py) | `sv = np.linalg.svd(...)`; `rk = int((sv > sv[0]*1e-10).sum())` | the reported "rank" is $\#\{i:\hat\sigma_i>10^{-10}\hat\sigma_1\}$ |

So the object the file produces is a **numerical rank of a perturbed matrix at a stipulated relative threshold**. The docstring at [c4_ev_injective.py:8-12](../scripts/reviewers/r213/c4_ev_injective.py) nevertheless states the outcome as *"the rank cannot exceed 14; if it reaches 14, evaluation is injective on the whole space and nothing else is needed"*, and the branch at [c4_ev_injective.py:69-72](../scripts/reviewers/r213/c4_ev_injective.py) prints `EVALUATION AT THE 40 POINTS IS INJECTIVE ON EVERY INVARIANT SEXTIC` on `rk == 14`. That conclusion is consumed verbatim at [run_n5_verify.py:144-148](../scripts/runs/run_n5_verify.py), which is the file the record points at for the identity step, and again at [REVIEW_r213.md:147](../reviews/REVIEW_r213.md).

## 3. Why the numerical rank does not close the inequality, and where the sharp defect is, which is not the threshold

The direction matters, and it is the whole of the argument.

Let $E=\hat M-M$ be the total perturbation, including both the einsum rounding and the backward error of the SVD driver. Weyl's inequality for singular values gives $|\sigma_i(M)-\hat\sigma_i|\le\lVert E\rVert_2$ for every $i$. Hence:

- **Upper bounds on the rank come free.** If $\hat\sigma_i$ is tiny, $\sigma_i(M)$ is small, which is a statement about $M$ being *near* low rank. This is the direction floating point gives cheaply, and it is not the direction wanted.
- **The lower bound needs an upper bound on $\lVert E\rVert_2$.** If $\mathrm{rank}_{\mathbb Q}M\le13$ then $\sigma_{14}(M)=0$ exactly, and Weyl gives $\hat\sigma_{14}\le\lVert E\rVert_2$. So the observation $\hat\sigma_{14}>0$ refutes rank $\le13$ **only** when accompanied by a proof that $\lVert E\rVert_2<\hat\sigma_{14}$.

**No such bound exists on file.** The script computes none, prints none, and the quantities an a-posteriori bound would need are not recoverable from its output: `optimize=True` selects a contraction path at run time, so neither the number of accumulated terms nor the magnitude of the intermediates is known, and the pre-normalisation column scales divided out at [c4_ev_injective.py:61](../scripts/reviewers/r213/c4_ev_injective.py) are never reported. A crude a-priori bound is available in closed form, a full 12-pair contraction sums $5^{12}\approx2.4\times10^8$ terms, each at most $1$ after the row scaling, so naive accumulation admits an absolute error up to $\sim10^{-8}$ before the column normalisation divides by an unrecorded factor, but that bound is a bound on the *error*, not on the *rank*, and it cannot be compared with $\hat\sigma_{14}$ without the column scales. **A quantity that is not recorded cannot be bounded by a reader.**

**The threshold is not the defect, and saying so would be the weaker finding.** [REVIEW_r213.md:145](../reviews/REVIEW_r213.md) records the computed values: $\hat\sigma_{10..18}=0.675,\,0.614,\,0.530,\,0.375,\,0.328,\,9.4\times10^{-15},\,5.6\times10^{-15},\,4.5\times10^{-15},\,3.6\times10^{-15}$. Any cut-off between about $10^{-13}$ and $10^{-2}$ relative returns 14, so the particular constant `1e-10` is doing no work and could be moved ten decades in either direction without changing the answer. The defect is one level up: **a threshold of any value is a stipulation about the noise floor, and the step needs a theorem about it.**

## 4. Does the cap of 14 change what kind of evidence would suffice?

It changes the *quantity* of evidence needed and sharpens the evidence on file, and it does not change its *kind*. Both halves are worth stating, because the cap is the strongest thing that can be said for the step.

**What the cap genuinely buys.** Because $\mathrm{rank}_{\mathbb Q}M\le14$ is exact, the exact matrix satisfies $\sigma_{15}(M)=\dots=\sigma_{40}(M)=0$. The 26 computed tail values are therefore a **direct measurement of the perturbation in 26 directions**: $\hat\sigma_{15}\le\lVert E\rVert_2$, so the recorded $9.4\times10^{-15}$ is a certified *lower* bound on $\lVert E\rVert_2$ and a calibration of its scale. And if the true rank were 13, then all of $\hat\sigma_{14},\dots,\hat\sigma_{40}$ would be bounded by the same $\lVert E\rVert_2$, so the recorded configuration, one value at $0.328$ sitting fourteen decades above a tight cluster of 26, would require $E$ to be anisotropic by fourteen decades, concentrated in exactly the one direction that inflates $\hat\sigma_{14}$ while leaving the other 26 at the machine floor. This is strong evidence. It is why I say the conclusion is almost certainly true.

**What the cap does not buy.** $\hat\sigma_{15}\le\lVert E\rVert_2$ is a lower bound on the error; the step needs an upper one. "The error is probably no larger than the largest error I happened to observe" is a heuristic about the distribution of rounding, not a theorem, and it is nowhere written down in any case. So the cap reduces the requirement from "exhibit many independent invariants" to "exhibit **14** columns whose evaluation vectors are independent over $\mathbb Q$" (a $14\times14$ minor with nonzero determinant) but that remains an exact statement over a field, and an approximation with a threshold is not one however favourable its numbers.

## 5. Is the instrument used the strongest one available in this repository?

**No, and the strongest one is in the same directory, applied to the same shape of matrix, over the same diagram family.**

The relevant fact is elementary and is stated in the repository itself, at [weyl_invariants.py:9-10](../scripts/reviewers/r179/weyl_invariants.py): *"dim = rank of the evaluation matrix … computed over $F_p$ with exact integer arithmetic. A mod-p rank is a LOWER bound for the char-0 dimension."* For an integer matrix, $\mathrm{rank}_{\mathbb F_p}(M\bmod p)\le\mathrm{rank}_{\mathbb Q}(M)$, because a nonvanishing $14\times14$ minor mod $p$ is a nonvanishing minor over $\mathbb Q$. **With the cap of 14 in force, a mod-$p$ rank of 14 is therefore a complete proof of injectivity, not evidence for it.** The entries of $M$ are rational and $M$ can be cleared to integers, so any prime missing the denominators serves.

Where that instrument already lives:

| file | what it does | at which points |
| --- | --- | --- |
| [c3_holdout.py:80-93](../scripts/reviewers/r213/c3_holdout.py) | `rank_modp` by exact Gaussian elimination mod $p$ | the pipeline's own points, **the same directory, the same reviewer, the same 40 tensors extended to 80** |
| [weyl_invariants.py:72](../scripts/reviewers/r179/weyl_invariants.py) | `rank_modp(M, p)` for evaluation matrices of contraction diagrams | generic |
| [run_n5_sextic_basis.py:37,43](../scripts/runs/run_n5_sextic_basis.py) | exact mod-$p$ rank of the evaluation matrix of complete contractions of six $W$'s, reaching **14** | 40 Weyl tensors drawn over $\mathbb F_{10007}$ with `default_rng(7)`, **a different point set** |

[run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py) is the near miss, and it is worth being precise about why it does not rescue the step: it proves $\dim V\ge14$ and exhibits an exact basis of 14 diagrams, exactly and over a field, but at its own points, not at the certificate's. Injectivity is *a statement about the certificate's 40 points*, and no exact rank is on file for those. The repository thus contains both the sound instrument and a worked template for using it on precisely this matrix, and neither was pointed at the one place the certificate depends on.

The gap is three lines wide. [c4_ev_injective.py:28-33](../scripts/reviewers/r213/c4_ev_injective.py) already holds the 40 tensors as exact `Fraction` objects; reducing them mod a prime and calling the `rank_modp` that its sibling [c3_holdout.py:80](../scripts/reviewers/r213/c3_holdout.py) defines would replace the SVD with a proof. The cap means only 14 of the 120 columns are needed, so the cost is negligible.

## 6. What is not wrong here, recorded so it is not re-attacked

- **The point set is right.** The `for k in range(41): … if k == 0: continue` at [c4_ev_injective.py:28-30](../scripts/reviewers/r213/c4_ev_injective.py) reproduces [run_n5_assemble.py:894-909](../scripts/runs/run_n5_assemble.py), which seeds `_r5` at the same `20260829` and consumes exactly one draw on `_probe = ev.coords(rand_weyl_tensor())` before its sample loop. The skip is faithful, not a fudge. The claim of sameness is asserted rather than checked against the stored rows, which is presentational.
- **The reduction is sound.** Given $\mathrm{rank}_{\mathbb Q}M=14$ and $\dim V=14$, injectivity does follow: the image of $\mathrm{ev}$ contains a 14-dimensional space, so $\mathrm{ev}$ has rank 14 on a 14-dimensional domain. The logic of the step is correct; only its input is unproved.
- **The cap itself is exact**, by Weyl integration in [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), so the failure is on one side of the sandwich only.
- **Out of scope here**, and untouched: whether the Gram's sextic is an $O(5)$-invariant sextic at all (argued at [REVIEW_r213.md:140](../reviews/REVIEW_r213.md)), and whether the matrix $A$ of the affine system is certified. Injectivity was the question asked.

## Verdict

**FAILS.** The injectivity claim is **not established by what is on file**. What is on file is a float64 numerical rank of a perturbed $40\times120$ matrix at a stipulated relative threshold, [c4_ev_injective.py:63-64](../scripts/reviewers/r213/c4_ev_injective.py), consumed as settled at [run_n5_verify.py:144-148](../scripts/runs/run_n5_verify.py), and the step requires a lower bound on an exact rank, which no floating-point computation yields absent a bound on its own error that this one neither computes nor records the ingredients for.

Two qualifications, in opposite directions, and both belong in the verdict.

- **The claim is not refuted.** I exhibit no object at which injectivity fails, and the recorded singular values make its truth very likely. This is a missing certificate, not a false statement.
- **The certificate is cheap and the repository already has the tool.** An exact rank mod $p$ on the `Fraction` tensors [c4_ev_injective.py:28-33](../scripts/reviewers/r213/c4_ev_injective.py) already constructs, using the `rank_modp` of [c3_holdout.py:80](../scripts/reviewers/r213/c3_holdout.py), would convert the whole step from evidence into proof. Until it is run, the record's phrase *exact rational certificate* at [results.md:40](../results.md) overstates what the file supports, since this link is float64 and the step depends on it.
