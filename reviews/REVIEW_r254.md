# REVIEW r254 -- Gate 2, covariant independence test (claims 3, 4, 5)

Commits under review: 01edd64 (primary), 3a50615. Primary file: [scripts/runs/run_covariant_independence.py](../scripts/runs/run_covariant_independence.py). Reviewer 254 holds claims 3, 4, 5; reviewer 253 holds 1 and 2. Scripts: [scripts/reviewers/r254/](../scripts/reviewers/r254/).

## Verdict table

| Claim | Subject | Verdict |
|---|---|---|
| 3 | Scaling to 184 covariants at n=12, degree 3 | **REFUTED as costed** -- the projector saving is spent on the U side at 495 GiB to 71 TiB per test tensor, and the 1e-10 cut buys only ~1e6 of coefficient ratio |
| 4 | Sampling: do N+1 generic samples suffice | **CONFIRMED, and the framing corrected** -- $r\le N$ samples suffice a.s.; the "+1" does nothing, genericity is a hypothesis on the *law*, and the independence direction needs no genericity at all |
| 5 | The recorded bug and completeness of the fix | **CONFIRMED accurate, fix complete -- two further defects found** -- the seed is held fixed where the asserted direction needs it varied, and the contrast Gram is a wrong literal whose printed rank contradicts its own comment |

## What this review asks for, in four lines

1. **Compute the rank exactly.** At most 9 columns per block; an exact rational rank costs 1.3 ms and removes the 1e-10 cut and its failure mode entirely.
2. **Cost the test tensors before adopting the construction.** 60 of the 184 covariants live in blocks where a dense $U$ is 461 GiB or 64.87 TiB.
3. **Assert `samples > len(carriers)`,** and run the rank over several seeds.
4. **Fix the contrast Gram literal** to exponents $[[4,3,2],[3,4,1],[2,1,4]]$; the true rank is 3, which is what the comment beside it already claims.

## Claim 3 -- REFUTED as costed, with a repair

Script: [scripts/reviewers/r254/c3_scale.py](../scripts/reviewers/r254/c3_scale.py). Block table read from the record's own [scripts/runs/n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl).

### 3a. The count of test tensors is not the cost -- CONFIRMED, and it favours the file

The 184 are not one family. They are $m_\lambda$ covariants into $V_\lambda$, one family per block of $\mathrm{Sym}^3(\mathcal W_{12})$, and inequivalent $O(n)$ irreps pair to zero, so independence is 71 separate questions. The record's table gives multiplicities $1^{34}, 2^{17}, 3^{10}, 4^{6}, 5, 6^{4}, 7, 8^{3}, 9$.

- 34 blocks have multiplicity 1: there is nothing to test beyond $F_c \neq 0$.
- The widest value matrix has **9 columns**, not 184.
- Generically $m_\lambda$ pairs $(W,U)$ suffice per block (claim 4), so **~184 evaluations in total**.

The "184 x 184" framing that r247 and r248 attacked does not apply to this test either. This part of the scaling worry is unfounded.

### 3b. The cost is producing ONE exact U, and it is worse than the 3.20 GB the file avoids

$U$ must lie **exactly** in $V_\lambda$, which is realised in traceless tensors of $(\mathbb R^{12})^{\otimes|\lambda|}$. The $|\lambda|$ spread over the table is the whole difficulty:

| $\lvert\lambda\rvert$ | blocks | multiplicities | dense $U$ = $12^{\lvert\lambda\rvert}$ f64 | projector $P_\lambda$ = $12^{2\lvert\lambda\rvert}$ |
|---|---|---|---|---|
| 0 | 1 | 2 | 8 B | 8 B |
| 2 | 1 | 3 | 1.12 KiB | 162 KiB |
| 4 | 5 | 20 | 162 KiB | **3.20 GiB** |
| 6 | 11 | 43 | 22.78 MiB | 64.87 TiB |
| 8 | 19 | 63 | 3.20 GiB | 1.35e6 TiB |
| 10 | 24 | 43 | 461 GiB | 2.79e10 TiB |
| 12 | 16 | 17 | 64.87 TiB | 5.78e14 TiB |

The file's own headline number identifies itself in that table: $12^8 \cdot 8\,\mathrm{B} = 3.20$ GiB is the projector on a **four**-index space, i.e. on $\mathcal W_n$ itself -- the degree-2 setting. The real targets sit at $|\lambda| = 6, \dots, 12$. **40 of the 71 blocks, carrying 60 of the 184 covariants, have $|\lambda| \ge 10$**, where a dense $U$ alone is 461 GiB or 64.87 TiB.

So the advertised saving -- "no projector is ever applied: it is absorbed into the choice of test tensor" -- **relocates the cost rather than removing it**, and relocates it several orders in the wrong direction. This also bounds r253's repair: r253 is right that $P$ never needs its dense form, only its action on $n^4$ tensors at 0.4 ms, but that is true of the degree-2 case only. At degree 3 the tensors $P_\lambda$ must act on are $n^{10}$ and $n^{12}$, and the 0.4 ms becomes unbounded.

**The repair, which is not in the file.** Take $U$ a highest-weight vector of $V_\lambda$ built in an isotropic basis: a sum of $\prod_{\text{cols}} (\text{col height})!$ simple tensors, at most $6!^2 = 518{,}400$ terms for the widest $\lambda$ in the table, each pairing with $D_c(W)$ as a closed diagram in $O(n^4)$. That is feasible and exact. It is a different construction from the one the file validates, and the file validates a **scalar** test that exercises no $U$, no projector and no pairing at all.

### 3c. Rounding is NOT the problem -- this reviewer's first objection, refuted by this reviewer's own measurement

$\langle D_c(W), U\rangle$ at $|\lambda| = 12$ is a signed sum over $n^{12}$ tuples, and the naive bound $\varepsilon \cdot \kappa_{\text{global}}$ with $\kappa_{\text{global}} = \sum|t| / |\sum t| \sim n^6 = 3.0\mathrm{e}6$ predicts a 6.2e-10 floor at $n = 12$, above the cut. That bound does not apply: `einsum` contracts pairwise. Measuring the effective conditioning by rerunning the same contraction in float32 ($\text{err} \approx \kappa_{\text{eff}}\varepsilon_{32}$):

| $\lvert\lambda\rvert$ | n | $\kappa_{\text{global}}$ | $\kappa_{\text{eff}}$ | float64 floor |
|---|---|---|---|---|
| 12 | 5 | 2.75e4 | 24.3 | 5.4e-15 |
| 6 | 10 | 7.79e3 | 4.0 | 8.9e-16 |
| 6 | 12 | 3.77e4 | 5.1 | 1.1e-15 |

$\kappa_{\text{eff}}$ stays O(1)-O(10) while $\kappa_{\text{global}}$ grows like $n^6$. The floor is ~1e-15, four orders under the cut. **The size of the contraction does not threaten the 1e-10 cut.**

### 3d. What does break the cut: it buys only ~1e6 of coefficient ratio

The cut is relative to $\sigma_1$, so it tolerates a true dependence only while that dependence's coefficient ratio stays under $10^{-10}/\varepsilon \approx 1.3\mathrm{e}5$. Witness, built on the record's own relation (the first Bianchi identity forces $A - 2C = 0$ on $\mathcal W_n$, plan.md's own witness with $A = W_{abcd}W_{abcd}$, $C = W_{abcd}W_{acbd}$): add a third carrier $h_M = A + M(A - 2C)$, which **is** $A$ as a function for every $M$.

| $M$ | reported rank | $\sigma_2/\sigma_1$ | true rank |
|---|---|---|---|
| 1e0 | 1 | 1.1e-15 | 1 |
| 1e4 | 1 | 7.8e-12 | 1 |
| 1e5 | 1 | 7.8e-11 | 1 |
| **1e6** | **2** | 7.8e-10 | 1 |
| 1e8 | 2 | 7.8e-8 | 1 |

Diagram bases carry coefficients of size $n^k$: $12^5 = 2.5\mathrm{e}5$ and $12^6 = 3.0\mathrm{e}6$ both clear the break, and r250's own witness $J_1 = I_1 + I_2/n$ is exactly a $1/n$-scaled combination. **This is the unsafe direction** -- a true dependence read as independence, which is the conclusion the programme wants to hear.

### 3e. And the threshold is unnecessary

With at most 9 columns per block, integer $W$ and integer $U$ make the entries exact integers and the rank an exact computation: a 12x9 exact rational rank costs 1.3 ms. The float SVD and its 1e-10 cut buy nothing at this size and cost 3d. **The rank should be computed exactly.**

### 3f. Minor: the sample guard is absolute where it should be relative

`weyl_random` asserts $|\mathrm{Ric}(W)|_{\max} < 10^{-9}$ absolute while $\|W\|$ grows with $n$ (7.1 at $n=5$, 40.2 at $n=12$), so the guard is a 1.4e-10 relative tolerance at $n=5$ and 2.5e-11 at $n=12$. Delivered residual is ~1e-16 relative, so nothing fails today -- but the guard admits a residual within a factor 4 of the rank cut, and nothing ties the two. At degree 2 this cannot be exhibited: every trace-dependent degree-2 $O(n)$ invariant of a Bianchi tensor is **quadratic** in $\mathrm{Ric}$, so the residual enters the validated case at $d^2 \approx 10^{-32}$ rather than $d$.

## Claim 4 -- CONFIRMED with the framing corrected

Script: [scripts/reviewers/r254/c4_sampling.py](../scripts/reviewers/r254/c4_sampling.py).

### 4a. The theorem, re-derived

Let $X$ be a finite-dimensional real vector space, $f_1,\dots,f_N : X \to \mathbb R$ polynomial, $r = \dim\mathrm{span}\{f_c\}$. Draw $W_1,\dots,W_m$ i.i.d. from any law absolutely continuous w.r.t. Lebesgue measure on $X$, and set $M_{ic} = f_c(W_i)$.

- **$\mathrm{rank}\,M \le r$ for every sample set.** Any relation $\sum_c x_c f_c = 0$ holds at every point, so $Mx = 0$. No randomness enters.
- **$\mathrm{rank}\,M = r$ a.s. once $m \ge r$.** Pick a basis $g_1,\dots,g_r$ of the span. The evaluation functionals $\mathrm{ev}_x$ span the dual of that span -- otherwise some nonzero $y$ in the span would vanish at every $x$, i.e. be the zero function -- so points $x_1,\dots,x_r$ exist with $\det[g_j(x_i)] \ne 0$. Hence $D(x_1,\dots,x_r) = \det[g_j(x_i)]$ is a polynomial on $X^r$ that is not identically zero, its zero set is a proper Zariski-closed subset, hence Lebesgue-null, hence null for the sampling law.

**So $r \le N$ samples suffice almost surely. "N+1" is sufficient but slack, and the "+1" does no work.** What does the work is absolute continuity of the sampling law, not the count.

### 4b. The hypothesis the theorem needs is satisfied, and unstated

The law must be absolutely continuous **on $\mathcal W_n$**, not on the ambient $\otimes^4$. `weyl_random` is a linear map of a nondegenerate Gaussian that fixes $\mathcal W_n$ pointwise, hence the orthogonal projection onto it, so the image law is a nondegenerate Gaussian on $\mathcal W_n$. Confirmed by spanning: 200 stacked samples have rank 35, 84, 168 at $n = 5, 6, 7$, matching $\dim\mathcal W_n = n(n{+}1)(n{+}2)(n{-}3)/12$ exactly. Nothing in the file records this as a hypothesis.

### 4c. The test is ONE-SIDED, and the file validates the uncertifiable side

In exact arithmetic:

| Reported | Status |
|---|---|
| $\mathrm{rank}\,M = N$ | a **proof** of independence -- $\mathrm{rank} \le r$ always, so exhibiting $N$ forces $r = N$, from one sample set, lucky or not, with no genericity hypothesis |
| $\mathrm{rank}\,M < N$ | **evidence** of dependence only -- it is also what a measure-zero bad draw looks like |

The $n=12$ item asserts $\mathrm{rank} = 184$, an independence: the certifiable side. The file's validation asserts `r == 1` on the degree-2 carriers, a **dependence**: the uncertifiable side. **The validation exercises the epistemically opposite direction from the intended use.** This compounds r253's vacuity finding from a different angle.

It also means the fixed `seed=0` is harmless for the intended use and useless for the validation.

### 4d. Genericity is a hypothesis on the law, and $N+1$ samples from a plausible finite set fail

Witness for $N = 2$: $f_1(x) = 1$, $f_2(x) = x(x-1)(x-2)$ sampled at $N+1 = 3$ points of $\{0,1,2\}$ gives the value matrix $\begin{pmatrix}1&0\\1&0\\1&0\end{pmatrix}$, reported rank 1 against true rank 2. The quantitative form is Schwartz-Zippel: sampling coordinates from a finite set $S$, $\Pr[\text{bad draw}] \le \deg D/|S| = 3r/|S| \le 27/|S|$ per block. At $|S| = 10^6$ that is $1.9\times10^{-3}$ over all 71 blocks. By 4c this bound only ever matters for reading a **low** rank.

### 4e. The file's `samples=12` is untethered to `len(carriers)`

`independence_rank` hardcodes 12 samples with no relation to the number of carriers and no assert. Measured on well-scaled independent carriers $W \mapsto \langle W, T_j\rangle$ at $n=6$: 12 carriers give rank 12, 15 give rank 12, 20 give rank 12. The largest block has multiplicity 9, so 12 happens to be enough today; nothing in the file says so.

### 4f. And a second sampling-adjacent failure that is really the threshold

Carriers $A, A^2, \dots, A^k$ (with $A = \|W\|^2$) are independent as functions for every $k$, but the value matrix is a Vandermonde in $A(W)$ spanning decades:

| $k$ | true rank | reported | $\sigma_k/\sigma_1$ |
|---|---|---|---|
| 4 | 4 | 4 | 2.7e-9 |
| 5 | 5 | **4** | 2.8e-12 |
| 6 | 6 | **4** | 1.3e-15 |
| 8 | 8 | **4** | 5.9e-20 |

Under-reporting is the conservative direction, but it shows the 1e-10 cut is doing modelling rather than measuring. Column normalisation or exact arithmetic removes it; the file does neither. Note the file's own quadratic-versus-quartic control is exactly the $k = 2$ case of this family, which is where it still works.

## Claim 5 -- record accurate, fix complete, two further defects

Script: [scripts/reviewers/r254/c5_bug.py](../scripts/reviewers/r254/c5_bug.py).

### 5a. The record reproduces in every particular

| Assertion in the record | Checked | Result |
|---|---|---|
| mechanism: `weyl_random` inside the inner comprehension gives each carrier a different $W$ | reimplemented both forms | reproduces |
| "rank 3" | 10 seeds x $n \in \{5,6,7,8,12\}$ | buggy rank is 3 in all 50 runs; fixed rank is 1 in all 50 |
| "the assert below caught it" | rank 3 against `assert r == 1` | fires |
| "without the known answer it would have read as a result" | the quadratic-vs-quartic control under the bug | control returns 2 and **passes** -- only the known answer catches it |

At $n = 12$ the buggy singular values are all of the same order while the fixed ones collapse at $\sigma_2/\sigma_1 \approx 7\mathrm{e}{-}16$, so the failure is a genuine rank-3 spread, not a threshold artefact.

One correction to the record's *reason*, which is r253's finding and I corroborate it: rank 1 is forced by pointwise proportionality ($c_3 = c_1$ by pair symmetry, $c_2 = c_1/2$ by first Bianchi), not by irreducibility. The bug's *number* is right for a reason the comment states wrongly.

### 5b. The fix is complete for the thing it names

One `weyl_random` call per row, its result shared across every carrier, the rng advancing only between rows. The remaining variation -- different sample tensors between iterations of the $n$-loop -- is required, since the space changes with $n$.

### 5c. THE MIRROR DEFECT, not recorded: the file holds fixed what ought to vary

The bug varied what must be held fixed. The file also **holds fixed what ought to vary**: `seed=0` is the default and no caller overrides it, so every reported rank rests on one draw. By claim 4c that is harmless for an *independence* reading and useless for a *dependence* reading -- and `assert r == 1` is a dependence reading. Re-running over 50 seeds is free and gives rank 1 at $n = 5$ and $n = 12$ every time, so the conclusion survives; the file simply never checks the one thing its own assertion needs.

### 5d. A separate defect in the same file: the contrast Gram is a wrong literal

Lines 108-118 hardcode the projector-free Brauer Gram as exponents $\begin{pmatrix}4&3&4\\3&4&3\\4&3&4\end{pmatrix}$ and comment that it "has full rank". Row 0 equals row 2 identically, so the literal is rank **2** at every $n$ -- the comment and the output contradict each other.

Recomputing it from the diagrams: each carrier is $\langle W \otimes W, T_c\rangle$ with $T_c$ a perfect matching on the eight legs, $T_1 = \{ae,bf,cg,dh\}$, $T_2 = \{ae,bg,cf,dh\}$, $T_3 = \{ag,bh,ce,df\}$, and $\langle T_c, T_b\rangle = n^{\#\text{loops}(T_c \cup T_b)}$. The true exponents are

$$\begin{pmatrix}4&3&2\\3&4&1\\2&1&4\end{pmatrix}$$

so four entries of the literal are wrong. Checked by hand as well as by machine: $\langle T_1,T_3\rangle$ substitutes $e{=}a, f{=}b, g{=}c, h{=}d$ and reduces to $\sum \delta_{ac}\delta_{bd} = n^2$, and $\langle T_2,T_3\rangle$ collapses to $a{=}b{=}c{=}d$, giving $n^1$.

The true Gram is rank **3**, determinant $2.34\mathrm{e}8$ at $n=5$ and $8.85\mathrm{e}{12}$ at $n=12$ -- which is the comment's own word, and it makes the file's point **stronger** (ambient 3 against function 1, rather than 2 against 1). The recomputation cross-checks against the record: the $(A,C)$ sub-Gram $\begin{pmatrix}n^4&n^3\\n^3&n^4\end{pmatrix}$ has determinant $n^8 - n^6 = n^6(n^2-1)$, exactly plan.md's stated witness.
