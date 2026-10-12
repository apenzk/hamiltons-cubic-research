# Verifier v61, is evaluation at the certificate's 40 points injective on the 14 invariant sextics?

The brief was cold: one step, one question, no priors, no other verifier's report in hand while the scripts were read. **No numerical work was done**, every file below was read, nothing was executed, and every number quoted is a number already written into a file in this repository. Log at [agent_logs/verify-L61-v61.log](../agent_logs/verify-L61-v61.log).

## Verdict

| step | verdict |
|---|---|
| evaluation at the 40 sample points is injective on $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, so agreement of the Gram's sextic with $F_5$ there is equality | **VALID AS WRITTEN**, an exact rank over $\mathbb F_p$ at those same 40 points, recorded at five primes, meets an exact upper bound of 14, and a lower bound is all injectivity needs |

## Summary

The injectivity holds and is established exactly, but **by [run_n5_assemble.py:913-953](../scripts/runs/run_n5_assemble.py) rather than by the float SVD in [c4_ev_injective.py](../scripts/reviewers/r213/c4_ev_injective.py) that the argument cites**, the cited instrument is an approximation with a threshold, and the sound one was already running in the same pipeline, on the same points, before the reviewer was briefed.

## The derivation

### What the cited computation is: an approximation with a threshold

[c4_ev_injective.py](../scripts/reviewers/r213/c4_ev_injective.py) builds the 40 sample Weyl tensors in exact arithmetic, [line 29](../scripts/reviewers/r213/c4_ev_injective.py) draws integer coefficients into [Fraction](https://docs.python.org/3/library/fractions.html#fractions.Fraction), and [line 33](../scripts/reviewers/r213/c4_ev_injective.py) assembles the rank-4 tensor over $\mathbb Q$, and then **discards that exactness at [line 34](../scripts/reviewers/r213/c4_ev_injective.py)**, where `float(R[a][b][c][d])` casts every entry to float64. From there:

| line | object |
|---|---|
| [c4:38](../scripts/reviewers/r213/c4_ev_injective.py) | each tensor divided by its own max entry, in float |
| [c4:59](../scripts/reviewers/r213/c4_ev_injective.py) | `float(np.einsum(ss, *([t]*6)))`, a 24-index contraction of six float64 copies |
| [c4:61](../scripts/reviewers/r213/c4_ev_injective.py) | each column rescaled by its max modulus, in float |
| [c4:63-64](../scripts/reviewers/r213/c4_ev_injective.py) | `sv = np.linalg.svd(M, compute_uv=False)`; `rk = int((sv > sv[0]*1e-10).sum())` |

So the conclusion printed at [c4:69-72](../scripts/reviewers/r213/c4_ev_injective.py) is a **numerical rank at relative threshold $10^{-10}$**: a count of how many computed singular values of a float64 matrix exceeded a hand-chosen fraction of the largest. No error bound on the einsum is computed, no perturbation bound relates the computed matrix to the exact one, and no interval is carried. The reported gap in [REVIEW_r213.md:147](../reviews/REVIEW_r213.md), $0.328$ then $9.4\times10^{-15}$, is large and morally persuasive, and it is still not a statement over a field. **As an answer to "is evaluation injective", it is evidence, not a proof**, and taken alone it would leave the step short.

### Why the cap of 14 makes that gratuitous

The cap does change what evidence suffices, decisively. Because every column of the evaluation matrix is $\mathrm{ev}(f_i)$ for some $f_i$ in a space of dimension at most 14, the rank of the matrix is at most 14 **a priori**. Injectivity of $\mathrm{ev}$ on that space is then exactly the statement $\mathrm{rank}\ge14$, a **lower** bound. Lower bounds on rank are the cheap direction: one $14\times14$ minor that fails to vanish settles it, and non-vanishing survives reduction, so

$$14=\mathrm{rank}_{\mathbb F_p}(A\bmod p)\;\le\;\mathrm{rank}_{\mathbb Q}(A)\;\le\;\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$$

closes the question in one line for any single $p$ not dividing the denominators. A float SVD is the one instrument that cannot deliver this, because it certifies neither side of the sandwich.

### The exact computation is on file, at the same 40 points

[run_n5_assemble.py:913-953](../scripts/runs/run_n5_assemble.py) does exactly that computation and has done since the certificate was built:

- [line 926](../scripts/runs/run_n5_assemble.py) forms `ROWS = [herm_row(g) for g in GSAMP]`, for each of the 40 points, the 89 real coordinates of the block Gram matrices $B^\lambda_{ij}(W)=\langle c^{\lambda,i}(W),c^{\lambda,j}(W)\rangle_Q$ of $W^{\otimes3}$'s isotypic pieces, in Gaussian arithmetic mod $p$.
- [lines 928-940](../scripts/runs/run_n5_assemble.py) run Gauss–Jordan over $\mathbb F_p$ on the $89\times40$ transpose, giving the rank as an exact integer.
- [line 950](../scripts/runs/run_n5_assemble.py) asserts only the upper bound `r <= 14`; attainment at [line 944](../scripts/runs/run_n5_assemble.py) is a `print`, not an assert, so the script's exit status carries no evidence of the value, and the value has to be read off a transcript.

The transcripts exist. Twenty-four recorded runs write the unrestricted value at line 97 of their logs, across **five distinct primes**, including all four of the $2^{40}$-scale primes whose rows were CRT-lifted into [n5_certificate.json](../scripts/runs/n5_certificate.json):

| log | prime | unrestricted sampled rank at the 40 points |
|---|---|---|
| [n5_final.log:97](../agent_logs/n5_final.log) | 1000033 | 14 |
| [reorder_p1.log:97](../agent_logs/reorder_p1.log) | 1099511627873 | 14 |
| [reorder_p2.log:97](../agent_logs/reorder_p2.log) | 1099511627917 | 14 |
| [reorder_p3.log:97](../agent_logs/reorder_p3.log) | 1099511627933 | 14 |
| [reorder_p4.log:97](../agent_logs/reorder_p4.log) | 1099511627953 | 14 |

Each is followed by the `ATTAINED` line and by `rank_mod_p verified on planted ranks 0, 1, 7, 13, 14`, the eliminator's own self-test at [run_n5_assemble.py:970-975](../scripts/runs/run_n5_assemble.py), which is the check reviewer 210 asked for. $p$-integrality, the one hypothesis the reduction needs, is enforced at [run_n5_assemble.py:233](../scripts/runs/run_n5_assemble.py) and screened for the whole coefficient cache at [lines 139-140](../scripts/runs/run_n5_assemble.py).

**These are the same 40 points.** [c4:26-30](../scripts/reviewers/r213/c4_ev_injective.py) seeds the global Mersenne Twister with 20260829 and discards draw 0; [run_n5_assemble.py:894](../scripts/runs/run_n5_assemble.py) seeds the same global generator with the same value and consumes draw 0 at [line 909](../scripts/runs/run_n5_assemble.py) as the shape probe, taking draws 1 through 40 in the sampling loop at [lines 916-919](../scripts/runs/run_n5_assemble.py). Both then apply the same 35 `randint(-4, 4)` draws through the same `wm.BASIS` / `sym2_to_R` change of basis. The streams agree.

### The cap itself

$\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ is computed **exactly**, by Weyl integration in Laurent polynomials over $\mathbb Z$ with rational scalars, in [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), no sampling, no threshold, and the $O(5)$ versus $SO(5)$ point is disposed of in the script's own note, $-\mathrm{Id}$ acting trivially on $\mathcal W_5$. Two independent routes agree: the diagram-rank count returns $1,1,4,5,14$ for $k=2,\dots,6$ at $n=5$ ([gate2_179.log:4](../agent_logs/gate2_179.log)), and a Racah computation over $W(B_2)$ gives 14 as a fourth route ([gate2_216.log:19](../agent_logs/gate2_216.log)). The upper bound is the load-bearing half here, and Weyl integration supplies it exactly.

### Putting it together

Write $\mathrm{Inv}=(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, $\dim\mathrm{Inv}=14$. Each of the 89 coordinates of `herm_row` is an element of $\mathrm{Inv}$: $c^{\lambda,i}(gW)=\rho_\lambda(g)\,c^{\lambda,i}(W)$ leaves the multiplicity index alone, so the pairing $B^\lambda_{ij}$ against the invariant form on $V_\lambda$ is $O(5)$-fixed, and it is degree 6 in $W$ because $W\mapsto W^{\otimes3}$ is degree 3. Let $A$ be the $40\times89$ rational matrix $A_{si}=f_i(W_s)$. Then

1. $\mathrm{rank}_{\mathbb Q}A=\dim\mathrm{ev}(\mathrm{span}\{f_i\})\le\dim\mathrm{ev}(\mathrm{Inv})\le14$;
2. $\mathrm{rank}_{\mathbb F_p}(A\bmod p)=14$ is recorded at five primes, and reduction only loses rank, so $\mathrm{rank}_{\mathbb Q}A\ge14$;
3. hence $\dim\mathrm{ev}(\mathrm{Inv})=14=\dim\mathrm{Inv}$, so $\mathrm{ev}$ has trivial kernel on $\mathrm{Inv}$.

Two invariant sextics agreeing at those 40 points are therefore equal. The Gram's sextic and $F_5$ both lie in $\mathrm{Inv}$, the certificate's restricted rows are fixed real-linear combinations of the 89 entries, per [REVIEW_r213.md:141](../reviews/REVIEW_r213.md), so their agreement at the 40 points is an identity. **The step is valid as written.**

### The one hypothesis this route carries, and the one the float route would have retired

Route A above uses the pipeline's own Gram entries, and their invariance rests on the copies being identified **equivariantly** across positions. That is a real hypothesis, not bookkeeping: [sym3-blocks.md](../findings/sym3-blocks.md) records reviewer 209's $S_3$ on $\mathbb R^3$ where a non-equivariant identification yields sampled rank 10 against a cap of 7, and records that attainment on a cap is not self-validating. What guards it is the multi-probe Schur test, plus the `r <= 14` assert at [run_n5_assemble.py:950](../scripts/runs/run_n5_assemble.py), which did not fire at any of the five primes.

**This is precisely the hypothesis [c4_ev_injective.py](../scripts/reviewers/r213/c4_ev_injective.py) was built to retire**, complete contractions of six copies of $W$ are manifestly $O(5)$-invariant by the first fundamental theorem, with no equivariance to assume, and it is why the file's docstring says "from OUTSIDE the pipeline". The instrument is right and the arithmetic is wrong: converting [c4:34](../scripts/reviewers/r213/c4_ev_injective.py) to keep the Fractions and [c4:63-64](../scripts/reviewers/r213/c4_ev_injective.py) to a mod-$p$ elimination would make that independent route exact too. The repository already holds two implementations to call, `rank_mod_p` at [run_n5_assemble.py:876](../scripts/runs/run_n5_assemble.py), self-tested on planted ranks, and `rank_modp` at [weyl_invariants.py:72](../scripts/reviewers/r179/weyl_invariants.py), which [run_n5_sextic_basis.py:38](../scripts/runs/run_n5_sextic_basis.py) already uses on exactly this kind of diagram matrix, over $\mathbb F_{10007}$, though at 40 points of its own rather than the certificate's.

**So: no, the instrument used is not the strongest available.** It is the weakest one in the file's neighbourhood, at the one place a proof was wanted, with two exact substitutes sitting in sibling scripts.

## Verdict

**VALID AS WRITTEN.** Evaluation at the certificate's 40 sample points is injective on the 14-dimensional space of $O(5)$-invariant sextics, and this is established on file by an exact rank over $\mathbb F_p$ (14, at five primes including all four used for the certificate's own row lift), against an exact Weyl-integration cap of 14, in which direction a lower bound is all that injectivity requires.

Two things the record should carry that it does not:

- **The support is misattributed.** [REVIEW_r213.md:143-150](../reviews/REVIEW_r213.md) hangs the step on a float64 SVD at relative threshold $10^{-10}$, whose conclusion is a numerical rank rather than a statement over a field. The proof is [run_n5_assemble.py:913-953](../scripts/runs/run_n5_assemble.py) and the transcripts at line 97 of the [reorder_p*](../agent_logs/) logs, which are cited nowhere for this purpose.
- **The value is printed, never asserted.** [run_n5_assemble.py:944](../scripts/runs/run_n5_assemble.py) branches on `r == 14` with a `print` while the only assert is the upper bound at [line 950](../scripts/runs/run_n5_assemble.py), so a future run that dropped to 13 would exit 0 and the step would go quiet. Promoting that branch to an assert costs one line and makes the pipeline refuse to build a certificate whose identity step it cannot close.
