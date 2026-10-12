# REVIEW r273, Gate 2, the ad-form / Cauchy–Schwarz route

Reviewer 273. Commits under review: `99d4e9a` / `de90c1b` (primary), `57961da`, `cc62ff2`.
Primary file: [findings/ad-form-attempt.md](../findings/ad-form-attempt.md), all sections. Supporting: [scripts/rsharp_basis_free.py](../scripts/rsharp_basis_free.py), [scripts/runs/run_frontier_bound_proof.py](../scripts/runs/run_frontier_bound_proof.py), [scripts/weyl.py](../scripts/weyl.py), [findings/bispectral.md](../findings/bispectral.md), [findings/INDEX.md](../findings/INDEX.md) fence posts.
Scripts: [scripts/reviewers/r273/](../scripts/reviewers/r273/). Reviewer 274 runs the identical brief concurrently and independently.

Nothing below imports [scripts/rsharp_basis_free.py](../scripts/rsharp_basis_free.py) or [scripts/weyl.py](../scripts/weyl.py). [r273_core.py](../scripts/reviewers/r273/r273_core.py) rebuilds $\mathfrak{so}(n)$'s structure constants by taking literal matrix commutators of $\phi_{ij}=E_{ij}-E_{ji}$ and projecting, implements $\#$ from Hamilton's structure-constant formula, and cross-checks it against Wilking's $\mathrm{ad}$-form and against full trilinear symmetry. The balanced sphere product is built from the **Riemann tensor of $S^m\times S^m$** and the Weyl decomposition $R=W+\frac{\mathrm{scal}}{2n(n-1)}g\owedge g$, then verified to satisfy first Bianchi ($0$ exactly) and $\mathrm{Ric}=0$ ($\le2\times10^{-16}$), no stored $\lambda$ vector is used.

| # | Claim | Verdict |
|---|---|---|
| 1 | The half-percent table | **EVERY NUMBER CONFIRMED, AND UPGRADED TO CLOSED FORM.** All four rows reproduce to $10^{-16}$ by an independent route, and each entry has an exact closed form in $m=n/2$, derived here by hand: $\operatorname{tr}(M^3)=\frac1{m\sqrt{(m-1)(2m-1)}}$, $\langle M^\#,M\rangle=\frac{2m-3}{\sqrt{(m-1)(2m-1)}}$, $\lVert M^\#\rVert_F=\frac{\sqrt{mE}}{\sqrt{m(m-1)}\,(2m-1)}$ with $E=(2m-1)\big[m(2m-3)^2+m-1\big]$. $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ is the right comparison and $\theta$ at that point **equals** it identically in $m$. One labelling slip: the $\cos\varphi$ sequence runs over $n=6\ldots16$, not $n=6\ldots20$ |
| 2 | The concentration claim | *pending* |
| 3 | Is the proposed inequality the right target | **CONFIRMED, IT IS THE CONJECTURE VERBATIM, WITH ZERO REDUCTION.** And the record's own escape hatch is closed by a theorem, not a table: the strengthened form $\operatorname{tr}(M^3)+\lVert M^\#\rVert_F\le\theta_0(n)$ fails at the balanced sphere product at **every even $n\ge4$**, with exact excess $\dfrac{m}{(2m-1)\big(u+\sqrt{u^2+m^2-m}\big)}>0$, $u=m(2m-3)$ |
| 4 | The frontier package's reach | *pending* |
| 5 | The fence posts | *pending* |
| 6 | The validation ledger | *pending* |

---

## Claim 1, the half-percent table

Evidence: [r273_core.py](../scripts/reviewers/r273/r273_core.py), [r273_claim1.py](../scripts/reviewers/r273/r273_claim1.py), [out_claim1.txt](../scripts/reviewers/r273/out_claim1.txt).

### The object, built from geometry rather than from a stored vector

$S^m\times S^m$ with unit round factors is Einstein with $\mathrm{scal}=2m(m-1)$ at $n=2m$, so $W=R-\frac{\mathrm{scal}}{2n(n-1)}g\owedge g$ and the $\Lambda^2$ operator is diagonal in $\{\phi_{ij}\}$ with two values,

$$a=\frac{m}{2m-1}\ \ \text{(both indices in one factor, multiplicity }m(m-1)),\qquad b=-\frac{m-1}{2m-1}\ \ \text{(mixed, multiplicity }m^2).$$

$\lVert M\rVert_F^2=m^2(m-1)/(2m-1)$. The ratio $a/b=-m/(m-1)$ is exactly the ratio of [weyl.py](../scripts/weyl.py)'s stored $x,z$ at $p=q=m$, so **the record's $\lambda$ vector is the right object and is correctly normalised**. First Bianchi holds to $0$ exactly and $\mathrm{Ric}(M)=0$ to $2\times10^{-16}$, so it is a genuine Weyl tensor.

### $M^\#$ in closed form

With $M$ diagonal, $\#$ is diagonal too and $(M^\#)_{ik}=\sum_{j\ne i,k}\lambda_{ij}\lambda_{jk}$, giving

$$(M^\#)_{\text{same}}=\frac{m(2m^2-4m+1)}{(2m-1)^2},\qquad (M^\#)_{\text{mixed}}=\frac{-2m(m-1)^2}{(2m-1)^2}.$$

Normalising ($\#$ is quadratic, so $M^\#$ scales by $\lVert M\rVert^{-2}$):

$$\operatorname{tr}(M^3)=\frac1{m\sqrt{(m-1)(2m-1)}},\qquad \langle M^\#,M\rangle=\frac{2m-3}{\sqrt{(m-1)(2m-1)}},\qquad \lVert M^\#\rVert_F=\frac{\sqrt{E}}{\sqrt{m(m-1)}\,(2m-1)},$$

$$E=8m^4-28m^3+32m^2-12m+1=(2m-1)\big[m(2m-3)^2+m-1\big].$$

### $\theta=\theta_0$ there, identically in $m$

$$\theta=\operatorname{tr}(M^3)+\langle M^\#,M\rangle=\frac{1+m(2m-3)}{m\sqrt{(m-1)(2m-1)}}=\frac{(m-1)(2m-1)}{m\sqrt{(m-1)(2m-1)}}=\frac{\sqrt{(m-1)(2m-1)}}{m},$$

and $\theta_0(2m)=\frac{\sqrt{2(2m-1)(2m-2)}}{2m}=\frac{\sqrt{(m-1)(2m-1)}}{m}$. **Equal identically**, so the comparison in the table is the right one and the answer to *"does $\theta$ at that point actually equal $\theta_0$"* is yes, as an identity in $m$ rather than as four decimal agreements.

### The table, rebuilt

| $n$ | $\operatorname{tr}(M^3)$ | $\lVert M^\#\rVert_F$ | sum | $\theta$ | $\theta_0(n)$ | excess | $\lVert M^\#\rVert/\lvert\langle M^\#,M\rangle\rvert$ |
|---|---|---|---|---|---|---|---|
| $6$ | $0.10541$ | $0.98319$ | $1.08860$ | $1.054093$ | $1.054093$ | $+3.2738\%$ | $1.036375$ |
| $8$ | $0.05455$ | $1.10733$ | $1.16189$ | $1.145644$ | $1.145644$ | $+1.4180\%$ | $1.014889$ |
| $10$ | $0.03333$ | $1.17615$ | $1.20949$ | $1.200000$ | $1.200000$ | $+0.7904\%$ | $1.008130$ |
| $12$ | $0.02247$ | $1.21979$ | $1.24226$ | $1.236033$ | $1.236033$ | $+0.5038\%$ | $1.005131$ |
| $14$ | $0.01618$ | $1.24991$ | $1.26608$ | $1.261680$ | $1.261680$ | $+0.3490\%$ | $1.003536$ |
| $16$ | $0.01220$ | $1.27195$ | $1.28415$ | $1.280869$ | $1.280869$ | $+0.2561\%$ | $1.002585$ |
| $18$ | $0.00953$ | $1.28878$ | $1.29831$ | $1.295767$ | $1.295767$ | $+0.1959\%$ | $1.001973$ |
| $20$ | $0.00765$ | $1.30205$ | $1.30969$ | $1.307670$ | $1.307670$ | $+0.1547\%$ | $1.001556$ |
| $24$ | $0.00524$ | $1.32163$ | $1.32687$ | $1.325498$ | $1.325498$ | $+0.1035\%$ | $1.001039$ |

Every reviewed row matches: $+3.27\%$, $+0.50\%$, $+0.15\%$, $+0.10\%$ at $n=6,12,20,24$.

### The one thing to correct

The record reads *"$\lVert M^\#\rVert_F/\lvert\langle M^\#,M\rangle\rvert$ runs $1.036,\,1.015,\,1.008,\,1.005,\,1.003,\,1.002$ at $n=6\dots20$"* and concludes *"$\to1.002$ by $n=20$"*. Those six values are $n=6,8,10,12,14,16$ (the sixth is $1.002585$, truncated rather than rounded). At $n=20$ the ratio is $1.0016$ and at $n=24$ it is $1.0010$. The direction of the claim is right (and stronger than stated) but the axis label is wrong by two steps.

**The tightness is a theorem, not an observation.** Both quantities tend to $\sqrt2$:

$$\lVert M^\#\rVert_F\to\sqrt2,\qquad \langle M^\#,M\rangle=\frac{2m-3}{\sqrt{(m-1)(2m-1)}}\to\sqrt2,\qquad \cos\varphi=1-O(n^{-2}),$$

so Cauchy–Schwarz is asymptotically an equality at the maximiser, as claimed.

## Claim 3, is the proposed inequality even the right target

Evidence: definitional, plus the closed form of Claim 1.

### It is the conjecture, written twice

The record's *"exact statement to prove"* is

$$\operatorname{tr}(M^3)+\lVert M^\#\rVert_F\cos\varphi\le\theta_0(n),\qquad \cos\varphi:=\frac{\langle M^\#,M\rangle}{\lVert M^\#\rVert_F\lVert M\rVert_F}.$$

With $\lVert M\rVert_F=1$ the second term is $\lVert M^\#\rVert_F\cdot\frac{\langle M^\#,M\rangle}{\lVert M^\#\rVert_F}=\langle M^\#,M\rangle$ **identically**, so the left side is $\operatorname{tr}(M^3)+\langle M^\#,M\rangle=\theta$ and the display reads $\theta\le\theta_0(n)$. That is Conjecture A with no symbol changed. **Nothing has been reduced**; $\theta$ has been renamed. The brief's suspicion is correct.

### The escape hatch is closed by a theorem

The record concedes this in effect and pivots: *"the next step is an upper bound on $\lVert M^\#\rVert_F$ over unit Weyl tensors … with $\cos\varphi\le1$ it would give a closed statement"*, i.e. the genuinely stronger

$$(\star)\qquad \operatorname{tr}(M^3)+\lVert M^\#\rVert_F\le\theta_0(n).$$

$(\star)$ is not merely *"false as stated"* at four tabulated dimensions. From Claim 1's closed forms, at the balanced sphere product

$$\frac{\operatorname{tr}(M^3)+\lVert M^\#\rVert_F}{\theta_0(n)}-1 \;=\; \frac{1+\sqrt{m\big(m(2m-3)^2+m-1\big)}-(m-1)(2m-1)}{(m-1)(2m-1)} \;=\; \frac{m}{(2m-1)\Big(u+\sqrt{u^2+m^2-m}\Big)},\qquad u:=m(2m-3),$$

which is **strictly positive for every $m\ge1$**, hence $(\star)$ is false at every even $n\ge4$. It is not a gap that shrinks to zero and closes at some $n$: it shrinks like $\tfrac1{2n^2}$ and never changes sign.

### What that costs the route

The relaxation's loss is exactly $\lVert M^\#\rVert_F(1-\cos\varphi)$, and at the maximiser that loss **exceeds** the conjecture's own margin, which is zero there. So any proof of Conjecture A that passes through $\lVert M^\#\rVert_F$ must reinstate $\cos\varphi$ (the alignment between $M^\#$ and $M$), at the maximiser, which is precisely the information Cauchy–Schwarz was invoked to discard. The record's framing, *"the gap to close is half a percent … a single sharpened step could carry it"*, mistakes a **structural** loss for a **quantitative** one. There is no constant to sharpen: the term that has to come back is the angle.

*What survives.* The measurement that $\cos\varphi\to1$ is real and is now a theorem. It says the Cauchy–Schwarz relaxation is asymptotically free, which would matter for a bound with slack $\gg n^{-2}$ at the maximiser. Conjecture A has slack exactly $0$ there, so it is the one target for which this observation cannot be used.
