# REVIEW r229 -- Gate 2, the moment bound and its refutation

Reviewer 229. Brief: brief20.md. Commits under review: 700c34c, d617153, 42f09c7, 73a74d2. Primary file: [run_second_kind_moment.py](../scripts/runs/run_second_kind_moment.py). Assigned claims 3, 4, 5 (r228 runs 1, 2). Scripts: [scripts/reviewers/r229/](../scripts/reviewers/r229/).

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 3 | The refutation of the moment bound -- wrong sign at the extremiser, cap on $m$ loose by a factor of twenty | **REFUTED.** Both stated reasons are false. $p_3(\omega)$ at the extremiser is $-0.300581$, not $+0.300581$ -- a sign error. The cap on $m$ is attained with **equality** at the balanced sphere product, identically in $m$; the reported "$m$ ACTUAL $=0.067420$" is $(-\min\omega)/(2(n-2))$ in a second, different normalisation and is not the most negative second-kind eigenvalue at all. Single root cause: the measurement used the opposite index order $W_{ikjl}$, which negates $\mathring W$ -- all eight reported numbers reproduce exactly under it. The conclusion "the bound is too loose to be useful" survives, but on a margin of $1.65$, decreasing in $n$, rather than the reported $5.3$ increasing to $9.1$ |
| 4 | The second-kind operator acts on all of $\mathrm{Sym}^2$, $\dim n(n+1)/2$ | **REFUTED, and the file contradicts itself.** Li's paper -- the repo's declared convention source -- defines the *curvature operator of the second kind* as the restriction to $S^2_0$, eq. (1.2). $N=n(n+1)/2-1$ is right. The shipped code still uses $77$ while the N.B. that "corrects" it says $78$, and the refutation table needs $N=77$ for one column and $N=78$ for another |
| 5 | The route needs a tight upper bound on $m$ and that is "not obviously easier" | **PREMISE REFUTED, conclusion upheld on other grounds.** A sharp bound on $m$ is already on this record -- unconditional, five lines, and attained *with equality* at every balanced sphere product -- so there is nothing left to buy. None of the seven stored second-kind references carries one, and none can: every estimate there is normalised by $\bar\lambda=\mathrm{scal}/(n(n-1))$, which vanishes on a Weyl tensor. The route still does not reopen, because the slack is independent of $m$: with the exact support bound and integrality restored the minimum is $-3.610812$ against a truth of $-2.404646$, and an upper support bound changes nothing because it is inactive at the minimiser |


## Claim 3 -- the refutation is itself wrong, on both of its two reasons

**Method.** [r229_claim3.py](../scripts/reviewers/r229/r229_claim3.py) rebuilds the whole object from definitions with nothing imported from the file under review: the coordinate-diagonal curvature tensor of the balanced $S^m\times S^m$, its Weyl part by Kulkarni--Nomizu subtraction, Ricci/Bianchi/pair-symmetry residuals all $<10^{-10}$, then $\mathring W$ in Li's $iklj$ order on an orthonormal basis of $\mathrm{Sym}^2$ and its restriction to $g^\perp$.

**The rebuild agrees with the record's closed form exactly.** At $n=12$ the $\omega$-spectrum is three values $\{0.134840^{\times40},\,-0.112367^{\times36},\,-1.348400^{\times1}\}$, which is $\{mA^{(m-1)(m+2)},\,(-(m-1)A)^{m^2},\,(-2m(m-1)A)^1\}$ with $A=1/(m\sqrt{(m-1)(2m-1)})$ -- the table already in [bispectral.md](../findings/bispectral.md). So the extremiser's second spectrum was on the record in closed form before this cycle measured it, and the measurement disagrees with it.

### The sign is wrong

| quantity | this review, rebuilt | the file |
|---|---|---|
| $p_3(\omega)$, $\lVert M\rVert_F=1$ | $-2.404646$ | -- |
| $p_3(\omega)$, the file's $\lvert W\rvert^2=1$ | $\mathbf{-0.300581}$ | $\mathbf{+0.300581}$ |

The magnitude matches to all six digits, so this is a dropped sign and not a different computation. The record's closed form $p_3(\omega)=-(4m^2-6m-1)/(m\sqrt{(m-1)(2m-1)})$ is manifestly negative for $m\ge2$ and gives $-2.404646$ at $m=6$; dividing by $8$ for the file's normalisation gives $-0.300581$. **"$p_3(\omega)$ is positive at the extremiser, so the bound has the wrong sign" is false: $p_3(\omega)$ is negative there, and the bound $-3.958516$ lies below it, which is exactly what a lower bound must do.**

### The "factor of twenty" is a comparison of two different quantities, and the cap is in fact exact

The record already proves ([bispectral.md](../findings/bispectral.md), "the $\omega$-spectrum settles a question the second-kind route asks") that $-\min\omega=2m(m-1)A=2\sqrt{m-1}/\sqrt{2m-1}$ equals $\tfrac{n}{n-1}\theta_0(n)$ identically in $m$. This review re-derives that with `radsimp` -- difference exactly $0$ -- and confirms it numerically at $n=12,14,16,24$:

| $n$ | $-\min\omega$ | cap $\tfrac{n}{n-1}\theta_0(n)$ | cap$/(-\min\omega)$ |
|---|---|---|---|
| 12 | 1.348400 | 1.348400 | 1.000000 |
| 14 | 1.358732 | 1.358732 | 1.000000 |
| 16 | 1.366260 | 1.366260 | 1.000000 |
| 24 | 1.383128 | 1.383128 | 1.000000 |

**The projection estimate's cap is attained with equality at the balanced sphere product. Its looseness there is zero.** The claim that it is "loose by a factor of twenty at the point that decides the conjecture" inverts the one fact about $m$ that this record has actually proved.

What the reported $0.067420$ is: $(-\min\omega)/(2(n-2))$. The reported values at $n=12,14,16,24$ stand to the true $-\min\omega$ in the ratios exactly $20,24,28,44=2(n-2)$, so it is a systematic mis-identification and not a numerical accident. Two errors compound in it -- a factor $2$ of normalisation ($\lvert W\rvert^2=1$ against $\lVert M\rVert_F=1$; note $\lvert W\rvert^2=4\lVert M\rVert_F^2$) and a factor $n-2$ of unknown provenance. **The brief's suspicion is upheld: $0.067420$ and $1.3484$ are not the same quantity, and the factor of twenty is meaningless.**

### The file's own numbers refute the file, without any input from this review

A valid lower bound cannot exceed the value it bounds. The file reports $p_3^{\min}$ at the "true $m$" as $+0.056399$. With the sign corrected, $p_3(\omega)=-0.300581$, so $+0.056399>-0.300581$: **if $0.067420$ were the support bound, the bound derived from it would be violated at the very point it is evaluated.** [r229_claim3b.py](../scripts/reviewers/r229/r229_claim3b.py) runs this as planted violation 1 and it fires at both $N=77$ and $N=78$. The internal contradiction is visible without leaving the file.


### ROOT CAUSE -- the measurement used the opposite index order, which negates $\mathring W$

All four "$m$ ACTUAL" values and all four $p_3(\omega)$ values are reproduced **exactly, to six digits, at every $n$** by one substitution: computing $\mathring W$ with $W_{ikjl}$ in place of Li's $W_{iklj}$, and reading the result in the $\lvert W\rvert^2=1$ scale.

| $n$ | $-\min(-\omega)=\max\omega$ | file's "$m$ ACTUAL" | $p_3(-\omega)$ | file's $p_3(\omega)$ |
|---|---|---|---|---|
| 12 | 0.067420 | 0.067420 | 0.300581 | 0.300581 |
| 14 | 0.056614 | 0.056614 | 0.309354 | 0.309354 |
| 16 | 0.048795 | 0.048795 | 0.315643 | 0.315643 |
| 24 | 0.031435 | 0.031435 | 0.329410 | 0.329410 |

The opposite order sends $\mathring W\mapsto-\mathring W$. That flips $p_3(\omega)$ to $+0.300581$ and turns $-\min\omega$ into $\max\omega$, which at the balanced product is $mA=(-\min\omega)/(n-2)$ -- the missing factor of $n-2$. The remaining factor $2$ is the normalisation: the measured spectrum sits at $\lvert W\rvert^2=1$ while the cap $1.3484$ it is compared against sits at $\lVert M\rVert_F=1$, and $\lvert W\rvert^2=4\lVert M\rVert_F^2$.

**Both of the refutation's two reasons are the same single error**, and it is the one the record already maintains a dedicated screen for: [bispectral.md](../findings/bispectral.md) states "the opposite order $W_{ikjl}$ negates $\mathring W$ and turns the $-\tfrac12$ into $+\tfrac12$. The repository standardises on Li's; [run_secondkind_sign.py](../scripts/runs/run_secondkind_sign.py) is the screen." The screen was not run. Reproduced in [r229_claim3.py](../scripts/reviewers/r229/r229_claim3.py) under "ROOT CAUSE TEST".

### The margin, computed correctly

Ratios are scale-invariant, so the normalisation confusion does not affect them. With $N=\dim S^2_0$ and $m$ at the cap (which is the true value):

| $n$ | $p_3(\omega)$ | $p_3^{\min}$ | ratio | $\theta$ overshoot |
|---|---|---|---|---|
| 12 | $-2.404646$ | $-3.958516$ | 1.6462 | 0.776935 |
| 24 | $-2.635278$ | $-4.127622$ | 1.5663 | 0.746172 |
| 100 | $-2.785103$ | $-4.219892$ | 1.5152 | 0.717394 |
| 400 | $-2.817765$ | $-4.237241$ | 1.5038 | 0.709738 |

The last column is what the bound costs on the quantity that matters: substituting $p_3^{\min}$ into $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ with the true $p_3(\mu)$ overshoots $\theta_0(n)$ by $0.777$ at $n=12$, against $\theta_0(12)=1.236033$. That is a real and fatal looseness -- so **the file's verdict is right and every reason it gives for the verdict is wrong**. In particular "the loss GROWS with n, which is the direction that matters" is backwards: the ratio *decreases* monotonically in $n$ towards a constant near $1.50$, and so does the $\theta$ overshoot.

### Checks that can fail

Planted violation 2: the bound with the true support bound at every even $n$ from $6$ to $198$ -- $0$ violations. Planted violation 3: two-atom configurations at support $1.1\times$ and $1.3\times$ the true one break the bound, so the check is not vacuous.

### One further defect: the refutation ships no code

Commit 700c34c adds $39$ lines, all of them docstring. The four-row table, the $0.067420$ column and the $0.056399$ figure are prose; the executable part of the file still prints only the closed form at the cap. Nothing in the repository reproduces the numbers that overturned the cycle's own result.

## Claim 4 -- $S^2_0$, and the "correction" is a regression

**The source settles it.** Li [arXiv:2112.08465](../references/li-2021-nonnegative-second-kind/README.md), the repo's declared convention source, defines $\mathring R:S^2(T_pM)\to S^2(T_pM)$ by $\mathring R(e_i\odot e_j)=\sum R_{iklj}e_k\odot e_l$ and then says, in the sentence introducing eq. (1.2), that one *restricts* to $S^2_0$ and that **this restriction is what is called the curvature operator of the second kind**, after Nishikawa. The action is on $S^2$; the operator of the second kind is on $S^2_0$. The file's N.B. reads the first half and drops the second.

**The rest of the second-kind literature says the same.** Cheng--Wang fix $N=(n+2)(n-1)/2$ as "the dimension of $S^2_0(T_pM)$" and index the eigenvalues of $\mathring R$ over it; Dai--Fu define $\mathring R:S^2_0(V)\to S^2_0(V)$ outright. Note $(n+2)(n-1)/2=n(n+1)/2-1$.

**The record is consistent with itself and with Li.** [bispectral.md](../findings/bispectral.md) states the identity with $\mathring W$ on $S^2_0$; its multiplicity table sums to $2m^2+m-1=\dim S^2_0(\mathbb R^{2m})$; [response.md](../response.md) Lemma L50(B) says $S^2_0$; [target.md](../findings/target.md) says $S^2_0$. No file in the record uses $n(n+1)/2$. **The brief's worry that the record disagrees across files is unfounded -- only the file under review disagrees, and only with itself.**

**For a Weyl tensor the distinction is a single zero.** $(\mathring Wg)_{ij}=\sum_kW_{ikkj}=-\mathrm{Ric}_{ij}=0$, so $g$ spans a kernel direction and $\mathrm{spec}_{S^2}(\mathring W)=\mathrm{spec}_{S^2_0}(\mathring W)\cup\{0\}$. Measured: $p_2$ and $p_3$ agree to $4\times10^{-16}$ across the two domains at $n=12,14,16,24$. So $p_1,p_2,p_3$ are untouched and only $N$ moves, by one.

**Which makes the "correction" strictly harmful.** $p_3^{\min}=S^2/(Nm)-mS$ is *decreasing* in $N$, so enlarging $N$ from $77$ to $78$ weakens the bound. Both are valid; $S^2_0$ is the tighter and the conventional one.

**And it was not applied.** The shipped code still computes `N = n*(n+1)//2 - 1` with the comment `# dim S^2_0`, directly under a docstring asserting the opposite. Worse, the refutation table straddles both: $p_3^{\min}(\mathrm{cap})=-1.005882$ reproduces only with $N=77$, while $0.056399$ reproduces only with $N=78$. Two adjacent numbers offered as a single measurement use two different dimensions.

## Claim 5 -- the route does not need a better bound on $m$, and it still does not work

### The premise is false: the sharp bound on $m$ is already proved, and it is exact where it matters

[bispectral.md](../findings/bispectral.md) carries an unconditional five-line proof (Gate 2, reviewer 131): let $h$ be a unit bottom eigenvector of $\mathring W$ on $S^2_0$; $h$ is diagonal in its own eigenframe $F$, so $\mu=v^{\mathsf T}K^Fv\le\mu_1(K^F)$, and $K^F\mathbf1=0$ with $\lVert K^F\rVert_F^2\le2$ in every frame gives

$$\mu\;=\;-\min\omega\;\le\;\sqrt{\tfrac{2(n-2)}{n-1}}\;=\;\frac{n\,\theta_0(n)}{n-1}.$$

This review confirms, symbolically with `radsimp` and numerically at $n=12,14,16,24$, that **equality holds at every balanced sphere product**. So the sentence "the input it needs is a tight upper bound on $m$, and the only one on the record is loose by twenty at the point that decides the conjecture; bounding $m$ sharply is a different problem and is not obviously easier" is wrong in all three of its parts: the bound is on the record, it is not loose, and there is no further problem to solve.

### The stored literature has no such bound, and there is a structural reason

All seven stored second-kind references were swept: [cone-conditions-2025](../references/cone-conditions-2025-second-kind/), [dai-fu-2023](../references/dai-fu-2023-einstein-second-kind/), [li-2021](../references/li-2021-nonnegative-second-kind/), [li-2022](../references/li-2022-product-manifolds-second-kind/), [li-2024](../references/li-2024-sphere-theorems-second-kind/), [new-rigidity-2025](../references/new-rigidity-2025-second-kind/), [npw-2022](../references/nienhaus-petersen-wink-2022-betti-second-kind/). None contains an inequality of the form $\lambda_{\min}(\mathring W)\ge-c(n)\lvert W\rvert$.

**Why none can.** Every eigenvalue estimate in that corpus is normalised by $\bar\lambda=\mathrm{scal}/(n(n-1))$ -- Li 2024 Prop. 2.8, Fu--Lu Prop. 2.2 and Lemma 3.5, Cheng--Wang Lemma 3.2, Dai--Fu throughout. On a Ricci-flat or purely Weyl tensor $\bar\lambda=0$, so each of these collapses to $\lambda_1\ge0$, which is false for every Weyl tensor with $\mu>0$. The cone conditions $k^{-1}(\lambda_1+\cdots+\lambda_k)\ge-\theta\bar\lambda$ are moreover *hypotheses* on a manifold, not derived algebraic estimates. New-rigidity Lemma 3.5 does derive $\lambda_1\ge-\frac{(N-1)k\theta+N(k-1)}{N-k}\bar\lambda$, but from the cone hypothesis and against $\bar\lambda$, so it is inapplicable here on both counts.

[Bourguignon--Karcher 1978](../references/bourguignon-karcher-1978-pinching/README.md), the paper both sweeps identify as the only plausible external source ("pinching estimates"), is **not stored** -- that folder is a README recording a consultation through the citing literature. So it is not one of the seven, and the brief's premise that a sharp bound might be sitting unread in the reference set does not hold.

### The route still does not reopen -- and the reason is not $m$

The scale-invariant gap at the extremiser, with $m$ at its exact value:

| information used | $p_3^{\min}$ at $n=12$ | $\theta$ bound it yields | vs $\theta_0(12)=1.236033$ |
|---|---|---|---|
| $p_1,p_2$, lower support, $k$ relaxed off the integers | $-3.958516$ | $2.012968$ | $+0.777$ |
| the same with integrality restored (exact minimum) | $-3.610812$ | $1.839116$ | $+0.603$ |
| the same plus an upper support bound $\omega_i\le\max\omega$ | $-3.610812$ | $1.839116$ | $+0.603$ |
| the truth | $-2.404646$ | $1.236033$ | $0$ |

[r229_claim5_exact.py](../scripts/reviewers/r229/r229_claim5_exact.py) computes the exact minimum by KKT enumeration -- an extremal point has atoms at the active support bound plus at most two free values, the roots of one quadratic -- and cross-checks it against $40$ SLSQP starts, which never beat it. Integrality recovers $0.35$ of the $1.55$ gap and no more.

[r229_claim5_twosided.py](../scripts/reviewers/r229/r229_claim5_twosided.py) tests the natural next lever. The extremiser's spectrum $\{-m^{(1)},-(m-1)A^{(36)},+M^{(40)}\}$ has exactly the KKT shape of the *two-sided* problem, so an upper support bound looks like the missing constraint. **It buys nothing**: the two-sided minimiser is $\{1$ at $-1.348400$, $1$ at $-1.051210$, $75$ at $0.031995\}$, whose top entry $0.032$ sits well below $M=0.134840$, so the upper constraint is inactive. Loosening $M$ by factors up to $5$ leaves the minimum bit-identical -- the planted violation confirms the constraint is doing nothing rather than confirming a bound.

**So the slack is intrinsic to the information, not to any input.** Knowing $p_1$, $p_2$ and both support bounds exactly still leaves a factor $1.50$, decreasing slowly in $n$ towards roughly $1.37$. No sharpening of $m$ -- which is already exact -- and no support bound of any kind can close it. What would is strictly non-moment information about $\omega$: the record already holds some, in the Schur--Horn majorization $\omega\succ d$, which is not expressible as moments plus support.

**And an independent obstruction stands regardless.** [bispectral.md](../findings/bispectral.md) records that $\tfrac32\max p_3(\mu)=1.4657$ already exceeds $\theta_0(12)=1.236033$, so no improvement on the $\omega$ side alone can close the conjecture in this formulation however sharp. The moment route was blocked on the $\mu$ side before its $\omega$ side was measured.

### Verdict

The file's conclusion -- record this as a derivation whose margin was measured and found wanting -- is right. Its diagnosis was wrong twice over: first in the two numbers, now corrected, and second in naming a sharp bound on $m$ as the missing input when that bound exists, is proved, and is attained with equality at the very point the route is evaluated at.

## Two screens on the record would have caught this before it was committed

- [run_secondkind_sign.py](../scripts/runs/run_secondkind_sign.py) -- the repository's own screen for the $iklj$ / $ikjl$ order, referenced by name in [bispectral.md](../findings/bispectral.md) in the same paragraph that fixes the convention.
- [run_bk_crosscheck.py](../scripts/runs/run_bk_crosscheck.py) -- reproduces Bourguignon--Karcher's $\mathbb{CP}^m$ eigenvalues $(-2,4)$ **only** in Li's order; the flipped order returns $(-4,2)$ and fails. Per its README this is "the external check on this project's $\mathring W$ implementation and its index convention".

Neither was run. The refutation also shipped no executable code at all: commit 700c34c is $39$ lines of docstring, and the four-row table it turns on is not reproducible from the repository.

## Note on the file's current state

This review audits commit 700c34c, the version under review. The working copy of [run_second_kind_moment.py](../scripts/runs/run_second_kind_moment.py) has since been rewritten and now carries the sign correction, the $\mu/(n-2)$ identification and the corrected trend, crediting reviewer 228; those agree with what this review found independently. Three things in this review are not in it: the **root cause** (the opposite index order, which reproduces all eight reported numbers exactly and explains both errors as one), the **exact integer-constrained minimum** $-3.610812$ and the inactivity of an upper support bound, and the **$N$ question**, on which the current docstring still says nothing while the code still uses $\dim S^2_0$.
