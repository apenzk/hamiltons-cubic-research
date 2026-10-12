# Review r68, the two marginal identities, the three block bounds, and what can be built from them

Adversarial audit of C1–C6. Everything below was recomputed from an independent implementation written for this review ([scripts/review_r68_core.py](../scripts/review_r68_core.py) and siblings); no `b0_*.py` script was read, imported or run. The implementation is calibrated on two facts it was not fitted to: the balanced sphere product returns $\theta_0(n)$ and reproduces the coordinate-diagonal graph formula $\theta=\tfrac12(\sum_{ab}M_{ab}^3+\operatorname{tr}M^3)$ to $10^{-15}$, and the padded $W_{\mathbb{CP}^2}$ returns $\sqrt{3/2}$ at every $n$.

| Claim | Verdict |
| --- | --- |
| C1 two marginal identities with multiplicities 6/4/2 | **CONFIRMED**, derived, and exact to $10^{-13}$ on every operator tested |
| C2 $\gamma=2S_{\mathfrak{mhh}}$ | **CONFIRMED under $S=0$**, with a scope correction: the unconditional law is $\gamma=2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$ |
| C3 the refuted monotonicity | **CONFIRMED as refuted**, every number reproduced |
| C4 validity of bounds (a), (b), (c) | **CONFIRMED VALID**, each block estimate proved, none broken by search; two implementation caveats below |
| C4 exactness and failure ratios | **CONFIRMED**, all eight points, all ratios |
| C5 the band is not closed | **CONFIRMED, and the recorded maxima are under-estimates** (true maxima ≥ 10.12 / 15.78 / 22.57, not 8.16 / 11.13 / 13.78) |
| C5 find a sharper valid bound | **DELIVERED, and it still does not close the band**, an LP bound, exact at both recorded points, ~10× tighter than (c); the band stays open even for the sharpest bound the stated facts can support |
| C6 non-composability | **CONFIRMED** with a wording correction (the swap beats one parent at each end, never the exact one) |

## C1, the two marginal identities

**CONFIRMED, by derivation and not only by measurement.**

The row marginal itself is the Killing form: $\sum_{b,g}T_{abg}=\sum_b\lVert[v_a,v_b]\rVert^2=-\operatorname{tr}(\mathrm{ad}_{v_a}^2)=(n-2)\cdot(-\operatorname{tr}v_a^2)=2(n-2)\lVert v_a\rVert^2=2(n-2)$ for any unit $v_a$, no eigenbasis property is used.

Summing that over $a\in\mathfrak m$ and counting how often an unordered triple appears: a triple with $k$ of its three indices in $\mathfrak m$ contributes $k$ choices of $a$ times $2$ orderings of the remaining pair, i.e. $2k\,T$. Hence

$$\sum_{a\in\mathfrak m}\sum_{b,g}T_{abg}=6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2),$$

and the same count with $k'=3-k$ indices in $\mathfrak h$ gives $6S_{\mathfrak{hhh}}+4S_{\mathfrak{mhh}}+2S_{\mathfrak{mmh}}=2(N-d)(n-2)$. The multiplicities 6/4/2 are exactly this $2k$ count; nothing about $S=0$, Bianchi or Ricci enters, so both identities hold for **any** symmetric operator on $\mathfrak{so}(n)$ and any splitting by sign.

Measured in [scripts/review_r68_c1c2.py](../scripts/reviewers/r68/review_r68_c1c2.py) at $n=5,6,7,8$ on the padded $\mathbb{CP}^2$, the balanced sphere product and four generic random symmetric traceless operators each: both identities hold to $\le 6\times10^{-14}$ in all 24 cases. The one-parameter consequences $S_{\mathfrak{mmh}}=[d(n-2)-S_{\mathfrak{mhh}}]/2$ and $S_{\mathfrak{hhh}}=[(n-2)(2N-3d)-3S_{\mathfrak{mhh}}]/6$ follow by elimination and are correct as recorded. Their general form, worth recording because it is what makes $S=0$ load-bearing for bound (a), is $S_{\mathfrak{mmh}}=[d(n-2)-3S_{\mathfrak{mmm}}-S_{\mathfrak{mhh}}]/2$ and $6S_{\mathfrak{hhh}}=(n-2)(2N-3d)-3S_{\mathfrak{mhh}}+3S_{\mathfrak{mmm}}$.

## C2, $\gamma = 2S_{\mathfrak{mhh}}$

**CONFIRMED under $S=0$; the unconditional identity is $\gamma=2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$.**

Same counting argument. $\mu=\sum_{a,b\in\mathfrak m}\lVert[e_a,e_b]\rVert^2$ counts ordered pairs inside $\mathfrak m$, i.e. $k(k-1)T$ per triple, so $\mu=6S_{\mathfrak{mmm}}+2S_{\mathfrak{mmh}}$, the recorded $\mu=2S_{\mathfrak{mmh}}$ is the $S=0$ case. The cross mass counts $k(3-k)$ ordered pairs, giving $X=2S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}$ as recorded, and $\mu+X=\sum_{a\in\mathfrak m}2(n-2)=2d(n-2)$ is the row marginal again. Therefore

$$\gamma:=2(n-2)d-2\mu=(\mu+X)-2\mu=X-\mu=2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}.$$

All three quantities were computed from actual brackets rather than from $T$ ([scripts/review_r68_c1c2.py](../scripts/reviewers/r68/review_r68_c1c2.py)): $\mu$, $X$, $\mu+X$ and $\gamma$ match to $10^{-13}$ in all 24 cases, and on generic operators $\gamma$ differs from $2S_{\mathfrak{mhh}}$ by exactly $6S_{\mathfrak{mmm}}$ every time.

**The correction matters for the reading, not for the arithmetic.** Off the $S=0$ stratum $\gamma$ can be zero or negative while $\mathfrak h$ is not a subalgebra (measured: $\gamma=-0.4929$ at $n=6$ with $S_{\mathfrak{mhh}}=7.60$), so "$\gamma=0$ iff $[\mathfrak h,\mathfrak h]\subset\mathfrak h$" is true only where $S_{\mathfrak{mmm}}=0$. Since $S_{\mathfrak{mhh}}=0$ is literally the statement that no bracket of two $\mathfrak h$-vectors has an $\mathfrak m$-component, the equivalence with "$\mathfrak m^\perp$ is a subalgebra" is otherwise exact.

## C3, the refuted monotonicity

**CONFIRMED as refuted.** Reproduced from scratch ([scripts/review_r68_bounds.py](../scripts/review_r68_bounds.py)):

| $n$ | padded $\mathbb{CP}^2$: $S_{\mathfrak{mhh}}$, $\theta$, $S_{\mathfrak{mmm}}$ | balanced sphere: $S_{\mathfrak{mhh}}$, $\theta$, $S_{\mathfrak{mmm}}$ |
| --- | --- | --- |
| 6 | 4, 1.2247449, 0 | 0, 1.0540926, 0 |
| 8 | 8, 1.2247449, 0 | 0, 1.1456439, 0 |
| 10 | 12, 1.2247449, 0 | 0, 1.2000000, 0 |
| 12 | 16, 1.2247449, 0 | 0, 1.2360331, 0 |

Both $S_{\mathfrak{mmm}}$ columns are exactly $0$ (to $10^{-16}$; for the padded $\mathbb{CP}^2$ trivially so, $d=2$ admits no triple, and for the sphere product structurally, a mixed–mixed–mixed triangle would need three vertices with all three edges crossing the split). So the two points really are on the $S=0$ stratum, and at $n=6,8,10$ the point with $S_{\mathfrak{mhh}}=2(n-4)>0$ has the strictly larger $\theta$. The monotonicity "raise $S_{\mathfrak{mhh}}$, lower $\theta$" is false, and the recorded counterexample is the right one. At $n=12$ the ordering reverses, which is the crossover $n=6+2\sqrt7\approx11.29$ and not a repair of the monotonicity.

## C4, validity first

**All three bounds are genuine upper bounds. I could not break any of them, and each block estimate has a proof.**

Write $\theta=\sum\lambda^3+3B_{\mathfrak{hhh}}+3B_{\mathfrak{mmh}}+3B_{\mathfrak{mhh}}+3B_{\mathfrak{mmm}}$ with $B_{XYZ}=\sum_{\text{triples of that type}}T\lambda_a\lambda_b\lambda_g$ (note $B_{\mathfrak{mmh}}$ is the $(+\!-\!-)$ block and $B_{\mathfrak{mhh}}$ the $(+\!+\!-)$ block).

- **$(+\!+\!-)\le0$ and $(-\!-\!-)\le0$.** One or three negative factors against nonnegative ones; true for every operator, not only on $S=0$. Under $S=0$ the second is absent outright.
- **$(+\!+\!+)\le\lambda_1^3S_{\mathfrak{hhh}}\le\frac16\lambda_1^3(n-2)(2N-3d)$.** The first step needs only $\lambda\ge0$ on $\mathfrak h$; the second is C1 with $S_{\mathfrak{mmm}}=0$ and $S_{\mathfrak{mhh}}\ge0$. This is where $S=0$ is load-bearing: without it the cap acquires $+\tfrac12S_{\mathfrak{mmm}}$.
- **$(+\!-\!-)\le\lambda_1b^2S_{\mathfrak{mmh}}\le\frac12\lambda_1b^2d(n-2)$.** Same, using $S_{\mathfrak{mmh}}\le d(n-2)/2$.
- **The harmonic-mean dual is valid.** For a triple of positive eigenvalues, $\lambda_a\lambda_b\lambda_g=\tfrac13\mathrm{HM}(\lambda_a,\lambda_b,\lambda_g)\,(\lambda_a\lambda_b+\lambda_a\lambda_g+\lambda_b\lambda_g)$ exactly, and the harmonic mean is monotone in each argument, so $\mathrm{HM}\le h_3$. Summing with $T$ weights and collapsing the third index with the pair cap, $3B_{\mathfrak{hhh}}\le h_3\sum_{a<b}\lambda_a\lambda_b\sum_gT_{abg}\le 2h_3\sum_{a<b}\lambda_a\lambda_b=h_3(s^2-u)$. The estimate is insensitive to $d$: triples with a zero eigenvalue contribute $0$ on both sides, so the $d\ge3$ worry does not bite. What does need stating is the degenerate case: with fewer than three positive eigenvalues $h_3$ is undefined and $B_{\mathfrak{hhh}}=0$, and the convention that makes (b) exact at the padded $\mathbb{CP}^2$ (one positive eigenvalue) is *"the $h_3$ term is $0$"*.
- **$3B_{\mathfrak{mmh}}\le3\lambda_1(s^2-v)$ is valid but rests on tracelessness.** The estimate proper gives $3\lambda_1\big[(\sum_{\mathfrak m}|\lambda|)^2-v\big]$; it is $\operatorname{tr}W=0$ that turns $\sum_{\mathfrak m}|\lambda|$ into $s$. Weyl operators are trace-free so this is safe, but the substitution is a second hypothesis, not a rewriting.
- **The pair cap $\sum_gT_{abg}\le2$ is a theorem, and sharp.** $\sum_gT_{abg}=\lVert[v_a,v_b]\rVert^2=\langle v_b,-\mathrm{ad}_{v_a}^2v_b\rangle\le\lambda_{\max}(-\mathrm{ad}_{v_a}^2)$. Block-diagonalising $v_a=\sum_ka_k\varphi_{2k-1,2k}$ with $\sum a_k^2=1$, the eigenvalues of $\mathrm{ad}_{v_a}$ are $\pm i(a_k\pm a_l)$ and $\pm ia_k$, so $\lambda_{\max}(-\mathrm{ad}_{v_a}^2)=\max_{k\ne l}(|a_k|+|a_l|)^2\le2(a_k^2+a_l^2)\le2$, with equality iff two blocks carry $|a_k|=|a_l|=1/\sqrt2$, the $\mathfrak{so}(4)$ self-dual configuration, which is exactly where the padded $\mathbb{CP}^2$ lives. (This is a factor-2 improvement on what Böttcher–Wenzel gives for general matrices; the skew-symmetry is doing real work.) Verified numerically on 1200 random unit $X$ at $n=4..9$ and by direct maximisation, max $=2.000000000$.

**Search for a violation found none.** [scripts/review_r68_validity.py](../scripts/reviewers/r68/review_r68_validity.py) stress-tests every block estimate and all three bounds on three families at $n=5,6,7,8$: (F1) at most two negative eigenvalues, so $S_{\mathfrak{mmm}}=0$ holds automatically and $\mathfrak m$ may be an arbitrary subspace of a random $O(N)$ frame; (F2) $\mathfrak m$ spanned by coordinate planes forming a random triangle-free graph, $S_{\mathfrak{mmm}}$ depends only on the subspace $\mathfrak m$, so an arbitrary negative-definite operator on it and an arbitrary PSD operator on $\mathfrak h$ stay on the stratum; (F3) generic operators with $S_{\mathfrak{mmm}}>0$, as a scope probe. Worst slack over 1280 operators: $-2.3\times10^{-15}$, i.e. roundoff. [scripts/review_r68_attack.py](../scripts/reviewers/r68/review_r68_attack.py) then runs Powell ascent on $\theta-\text{bound}$ over the full symmetric-operator space with an $S_{\mathfrak{mmm}}$ penalty, from the two named points and from random starts; every run converges to slack $0$ at the padded $\mathbb{CP}^2$ and never below it.

**Two implementation caveats, both found by the attack.** The optimiser reported a $-4.4\times10^{-8}$ violation of (b) at $n=6$; it is an artifact of *my* positivity threshold and it is instructive. The witness has eleven eigenvalues at $+1.0\times10^{-9}$, and with a $10^{-9}$ cut-off they leave the positive set, shrinking $s$ below $\sum_{\mathfrak m}|\lambda|$ and breaking the tracelessness step above. Classified by exact sign the slack is $+7.4\times10^{-13}$. So: (i) $s$ must be the exact sum of positives, or, more robustly, the estimate should be implemented as $3\lambda_1[(\sum_{\mathfrak m}|\lambda|)^2-v]$, which never depends on a threshold; (ii) the $\mathfrak m/\mathfrak h$ split needs a *small* tolerance (numerical zeros must land in $\mathfrak h$, otherwise $d$ inflates, $2N-3d$ can go negative and (a) collapses). The two tolerances pull in opposite directions and must not be the same constant.

**Exactness and failure ratios: every recorded number reproduced** ([scripts/review_r68_bounds.py](../scripts/review_r68_bounds.py)).

| $n$ | point | $\theta$ | (a)/$\theta$ | (b)/$\theta$ | (c)/$\theta$ |
| --- | --- | --- | --- | --- | --- |
| 6 | padded $\mathbb{CP}^2$ | 1.2247449 | 23.000 | 1.0000000 | 1.0000000 |
| 6 | balanced sphere | 1.0540926 | 1.0000000 | 3.880 | 1.0000000 |
| 8 | padded $\mathbb{CP}^2$ | 1.2247449 | 69.000 | 1.0000000 | 1.0000000 |
| 8 | balanced sphere | 1.1456439 | 1.0000000 | 4.918 | 1.0000000 |
| 10 | padded $\mathbb{CP}^2$ | 1.2247449 | 152.333 | 1.0000000 | 1.0000000 |
| 10 | balanced sphere | 1.2000000 | 1.0000000 | 5.938 | 1.0000000 |
| 12 | padded $\mathbb{CP}^2$ | 1.2247449 | 283.667 | 1.0000000 | 1.0000000 |
| 12 | balanced sphere | 1.2360331 | 1.0000000 | 6.950 | 1.0000000 |

Recorded as "23×–284× over" and "3.9×–7.0× over": correct. Exactness is block-by-block, not accidental: at the sphere products both of (a)'s caps are attained ($3B_{\mathfrak{hhh}}=0.294196=\frac12\lambda_1^3(n-2)(2N-3d)$ at $n=12$, and likewise for $(+\!-\!-)$), and at the padded $\mathbb{CP}^2$ the $(+\!+\!+)$ block and its spectral cap are both $0$ while $3B_{\mathfrak{mmh}}=0.816497=3\lambda_1(s^2-v)$ exactly, the pair cap being saturated at $2$ by the self-dual bracket.

## C5, the band, and a sharper bound

**The band is open, and the recorded maxima are under-estimates.** Maximising the bounds over spectra with $\sum\lambda=0$, $\lVert\lambda\rVert=1$ and exactly $d$ negatives, for $3\le d<\lfloor n^2/4\rfloor$, two independent optimisers, unstructured Nelder–Mead over all $N$ entries ([scripts/review_r68_c5.py](../scripts/reviewers/r68/review_r68_c5.py)) and a structured two-level scan ([scripts/review_r68_c5_fast.py](../scripts/review_r68_c5_fast.py)):

| $n$ | recorded max (c) | this review, unstructured | this review, structured | argmax $d$ | target |
| --- | --- | --- | --- | --- | --- |
| 8 | 8.16 at $d\approx15$ | 9.92 at $d=15$ | **10.12** at $d=15$ | 15 | 1.224745 |
| 10 | 11.13 at $d\approx23$ | 15.39 at $d=23$ | **15.78** at $d=24$ | 23–24 | 1.224745 |
| 12 | 13.78 at $d\approx33$ | 21.50 at $d=35$ | **22.57** at $d=35$ | 33–35 | 1.236033 |

The qualitative claim stands and strengthens: the argmax location ($d$ at the top of the band) is as recorded, but the recorded heights are 20–60 % low, so C5's numbers should be replaced. Bound (a) alone is far worse still, 97.1, 231.2 at $n=8,10$, maximised at small $d$.

**A sharper valid bound: solve for the block masses exactly instead of estimating them.** For a *fixed* spectrum, $\theta$ is **linear** in $T$, and every structural fact the recorded bounds use is a linear constraint on $T$: nonnegativity, the row marginals $\sum_{t\ni a}T_t=n-2$, the pair caps $\sum_{t\supseteq\{a,b\}}T_t\le2$, and $T_t=0$ for triples inside $\mathfrak m$. So

$$\theta\;\le\;\Theta_{\mathrm{LP}}(\lambda):=\sum\lambda^3+\max\Big\{3\textstyle\sum_tT_t\lambda_a\lambda_b\lambda_g\;:\;T\ \text{satisfies those constraints}\Big\}$$

is a valid bound ([scripts/review_r68_lp.py](../scripts/review_r68_lp.py)), and it is the **optimal** one in this language: any bound derived from those facts alone is a valid inequality for the same feasible set, hence dominates the LP value. Measured:

| point | (c) | $\Theta_{\mathrm{LP}}$ | $\theta$ |
| --- | --- | --- | --- |
| padded $\mathbb{CP}^2$, $n=6$ | 1.224745 | **1.224745** | 1.224745 |
| balanced sphere, $n=6$ | 1.054093 | **1.054093** | 1.054093 |
| bound-(c) maximiser spectrum, $n=8$ | 10.1175 | **0.964662** |, |

It is exact at both recorded test points (it inherits (c)'s only virtue and loses none) and at the spectra where (c) blows up it is more than ten times tighter. The blow-up in C5 is therefore an artifact of the block estimates, not of the information they are built from.

**But it still does not close the band, and that is now a statement about the information available, not about the technique.** Maximising $\Theta_{\mathrm{LP}}$ over the band ([scripts/review_r68_lp_band.py](../scripts/reviewers/r68/review_r68_lp_band.py)):

| $n$ | max (c) over the band | max $\Theta_{\mathrm{LP}}$ | max $\Theta_{\mathrm{LP}}$ with the vector identity | target |
| --- | --- | --- | --- | --- |
| 6 | 4.5833 | **1.632993** ($d=3$) | **1.335074** ($d=5$) | 1.224745 |
| 8 | 10.1175 | **2.291288** ($d=4$) | **2.291288** ($d=4$) | 1.224745 |

Since every bound built from those four facts dominates $\Theta_{\mathrm{LP}}$ pointwise, **no bound of this kind can stay below $\max(\sqrt{3/2},\theta_0(n))$ across the band.** The recorded C5 verdict is right for a stronger reason than the one recorded. (The $n=6$ maximiser is the spectrum $(1/\sqrt6)^{\times3},0^{\times9},(-1/\sqrt6)^{\times3}$; at $n=8$, $(0.436)^{\times3},0^{\times21},(-0.327)^{\times4}$.)

**Adding the one further linear fact available in this language does not rescue it.** Every Weyl operator satisfies the vector identity $\sum_b\lVert[v_a,v_b]\rVert^2\lambda_b=-2\lambda_a$, verified to $3\times10^{-15}$ on 75 random elements of $\mathrm{Weyl}_n$ at $n=5,6,7$, built as the nullspace of first-Bianchi $+$ Ricci and checked against $\dim\mathrm{Weyl}_n=35,84,168$ ([scripts/review_r68_vecid.py](../scripts/reviewers/r68/review_r68_vecid.py)), and it too is linear in $T$. It buys $18\%$ at $n=6$ and **nothing at all** at $n=8$, where the maximiser satisfies it exactly. So the missing ingredient is not one more marginal identity.

**Independent corroboration.** Reviewer 67 reached the same LP ceiling by its own route, $1.6038$ at $n=6$ and $2.2913$ at $n=8$ ([review_r67_lp.py](../scripts/reviewers/r67/review_r67_lp.py)); my $n=8$ figure agrees to six digits and my $n=6$ figure is slightly higher ($1.6330$ vs $1.6038$), i.e. a better spectrum for the same LP. R67 also hit the same $10^{-8}$ thresholding artifact from the other side. Two implementations that share no code agreeing on both the ceiling and the trap is the strongest evidence in this report.

## C6, non-composability

**CONFIRMED, with one wording correction.** Reproduced exactly ([scripts/review_r68_c6.py](../scripts/reviewers/r68/review_r68_c6.py)):

| $n$ | swap/$\theta$ at padded $\mathbb{CP}^2$ | swap/$\theta$ at balanced sphere |
| --- | --- | --- |
| 6 | 1.667 | 1.720 |
| 8 | 2.333 | 1.980 |
| 10 | 3.000 | 2.235 |
| 12 | 3.667 | 2.488 |

matching the recorded "1.67×–3.67×" and "1.72×–2.49×". The correction: the swap is *not* worse than either parent at both ends, at the padded $\mathbb{CP}^2$ it is $1.667$ against (a)'s $23$, and at the sphere products it is $1.720$ against (b)'s $3.880$. What is true, and is what the claim means, is that **the swap is exact nowhere**: at each end it loses to whichever parent was exact there, because it keeps one half of that parent's pairing and discards the other. The mechanism is right, the exactness of (a) is the joint saturation of *both* mass caps at the sphere products, and of (b) the joint saturation of the pair cap and $\lambda_1$-substitution at the $\mathbb{CP}^2$ point.

**Taking the minimum circumvents this rather than violating it, and there is nothing to violate.** Non-composability is a statement about *adding* one term from each parent, which is an arbitrary pairing. The minimum is not a pairing: each of the two blocks has two valid caps, and $\min$ of two valid upper bounds on the same quantity is a valid upper bound on that quantity, block by block. Exactness at all eight points then follows for free (at each point the block whose cap is tight is selected by the $\min$) and indeed (c)$/\theta=1.0000000$ at all eight. The price is what C5 shows: taking the minimum of two loose things stays loose where both are loose.

## Answer to the coordinator's query on the "$\theta$ above target" operators

**Confirmed: they are relaxation points, not Weyl tensors. The reading in the query is right and the label in my phase log was wrong.**

(a) The search constrained only: symmetric operator on $\mathfrak{so}(n)$, $\operatorname{tr}W=0$, $\lVert W\rVert=1$, $S_{\mathfrak{mmm}}=0$. Neither Ricci-flatness nor first Bianchi was imposed.

(b) Measured on the $n=6$ and $n=8$ witnesses ([scripts/review_r68_c5_obstruction.py](../scripts/review_r68_c5_obstruction.py)):

| operator | $\lVert\sum_a\lambda_av_av_a^{\mathsf T}\rVert$ (Ricci) | $\lVert\sum_a\lambda_a\,v_a\wedge v_a\rVert$ (Bianchi) | $\lVert R\lambda+2\lambda\rVert$ | $\theta$ |
| --- | --- | --- | --- | --- |
| padded $\mathbb{CP}^2$, $n=6$ | $2.1\times10^{-16}$ | $1.2\times10^{-16}$ | $6.3\times10^{-16}$ | 1.224745 |
| balanced sphere, $n=6$ | $2.7\times10^{-16}$ | $0$ | $6.0\times10^{-16}$ | 1.054093 |
| SD-split witness, $n=6$ | $1.279$ | $1.206$ | $4.431$ | 1.326031 |
| SD-split witness, $n=8$ | $1.124$ | $1.298$ | $4.768$ | 1.511013 |

(c) Relabelled accordingly throughout this report. The construction is: positives on the self-dual 3-space of a 4-plane, negatives spread over all planes crossing a $4|n{-}4$ split (so $\mathfrak h=\mathfrak{so}(4)\oplus\mathfrak{so}(n-4)$ is a subalgebra, $S_{\mathfrak{mhh}}=0$, $\mathfrak m$ isotropic). Its $\theta$ is $1.326031,1.511013,1.580072,1.616232,1.638487$ at $n=6,8,10,12,14$, rising to $\sqrt3$ as $n\to\infty$ (the negatives are $O(1/d)$, so in the limit $\theta\to3\ell^3+3\cdot2\ell^3$ with $\ell=1/\sqrt3$). Consistent with fence post F14: $1.326>\sqrt{2(n-1)/n}=1.291$ at $n=6$, exactly as it must be, since dropping first Bianchi as well as Ricci-flatness relaxes strictly further than the fence post's space. **Nothing here bears on Conjecture A**; what it bears on is C5, where it is the reason no bound in this language can close the band, a bound valid on $\mathrm{Weyl}_n\cap\{S=0\}$ must exceed $\theta$ on the relaxation only if its derivation cannot tell the two apart, which is precisely the case for (a), (b), (c) and for $\Theta_{\mathrm{LP}}$.

**One discrepancy to flag.** The query reports the $n=6$ SD-split spectrum as INFEASIBLE for the $R$-level test ($R\ge0$ symmetric, zero diagonal, entries $\le2$, row sums $2(n-2)$, $R\lambda=-2\lambda$). Run here, that LP returns **FEASIBLE**, and I can exhibit the certificate two independent ways: directly, and as $R_{ab}=\sum_gT_{abg}$ from the solution of the $T$-level LP with the vector identity (which returns $0.805690$, hence a fortiori feasible). The reconstructed $R$ has $\min R=0$, zero diagonal, row sums $8.000000$, $\max R=2.0$, $\lVert R\lambda+2\lambda\rVert=8.9\times10^{-15}$. The same test returns FEASIBLE for the padded $\mathbb{CP}^2$ and for the balanced sphere product, as it must. So the query's conclusion is right but that particular test does not support it, the Ricci and Bianchi residuals in the table above do.

## What I attacked and failed to break

- **The three bounds.** 1280 random $S=0$ operators across three structurally different families, plus Powell ascent on $\theta-\text{bound}$ from six starts at $n=5,6$ with an $S_{\mathfrak{mmm}}$ penalty. No violation; worst slack $-2.3\times10^{-15}$. The one apparent violation ($-4.4\times10^{-8}$) was my own eigenvalue threshold and is documented above as an implementation caveat rather than a defect of the bound.
- **The pair cap.** Tried to exceed $2$ by direct maximisation at $n=4..10$ (max $2.000000000$), then proved $\le2$ from the $\mathrm{ad}$-spectrum. It is sharp exactly at the $\mathfrak{so}(4)$ self-dual configuration.
- **The row marginal.** Tried generic operators, degenerate spectra, rotated frames: it is the Killing form and holds for every unit vector, so there is nothing to break.
- **The harmonic-mean dual.** Looked for a failure at $d\ge3$, at fewer than three positive eigenvalues, and with many near-equal positives. It is a consequence of the exact identity $\lambda_a\lambda_b\lambda_g=\tfrac13\mathrm{HM}\cdot(\text{pairwise sum})$ plus monotonicity of the harmonic mean; the only gap is notational (the $h_3$ convention when fewer than three positives exist).
- **$S=0$ as a hypothesis.** Confirmed it is load-bearing for (a), the cap on $S_{\mathfrak{hhh}}$ acquires $+\tfrac12S_{\mathfrak{mmm}}$ without it, and $2N-3d$ can go negative, and confirmed it is *not* needed for (b), which holds for every traceless symmetric operator (verified on 480 generic operators with $S_{\mathfrak{mmm}}$ up to $26$).

## Corrections to record

1. **C2**: state the identity as $\gamma=2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$, with $\gamma=2S_{\mathfrak{mhh}}$ and the subalgebra equivalence as its $S=0$ corollary.
2. **C4**: record the $h_3$ convention (the term is $0$ when fewer than three positive eigenvalues exist, this is what makes (b) exact at the padded $\mathbb{CP}^2$), and record that the $(+\!-\!-)$ spectral estimate is $3\lambda_1[(\sum_{\mathfrak m}|\lambda|)^2-v]$ with $s$ substituted by tracelessness. Implement it in the first form: a positivity threshold applied to $s$ manufactures violations of order $10^{-8}$.
3. **C4**: record that (b) needs no $S=0$ hypothesis at all, while (a) does, the two bounds are not on the same footing.
4. **C5**: replace $8.16/11.13/13.78$ by $\ge10.12/15.78/22.57$; and replace "none of these three closes the band" by the stronger and now-established "nothing built from these facts closes the band", with $\Theta_{\mathrm{LP}}$ as the witness and the LP itself as the sharper bound.
5. **C6**: "worse than either parent at both ends" should read "exact at neither end, losing at each end to whichever parent is exact there".



---

## Synthesis carried in REVIEW.md

### Reviewer 68: the same claims, on an identical brief

Full report in [reviews/REVIEW_r68.md](reviews/REVIEW_r68.md). Agrees with Reviewer 67 on every verdict, from independent code.

**Validity confirmed with proofs.** The pair cap is a theorem, $\lambda_{\max}(-\mathrm{ad}_X^2)=\max_{k\ne l}(|a_k|+|a_l|)^2\le2$ from the block normal form, **a factor-2 improvement on Böttcher–Wenzel**, sharp exactly at the $\mathfrak{so}(4)$ self-dual configuration where $W_{\mathbb{CP}^2}$ lives. The harmonic-mean dual is valid and $d$-insensitive, following from $\lambda_a\lambda_b\lambda_\gamma=\tfrac13\mathrm{HM}\cdot(\text{pairwise sum})$ and monotonicity of the harmonic mean. $1280$ random $S=0$ operators across three families plus Powell ascent from both exactness points: worst slack $-2.3\times10^{-15}$. Two caveats: the $h_3$ term must be $0$ when fewer than three positives exist, which is what makes the spectral bound exact at $\mathbb{CP}^2$; and thresholding $s$ manufactures violations of order $10^{-8}$ that vanish under exact sign classification.

**The LP is the optimal bound in this language**, since for fixed spectrum $\theta$ is *linear* in $T$ and all four structural facts are linear constraints. It is exact at both recorded points and about $10\times$ tighter than the min-bound where that blows up ($0.965$ against $10.12$). Its band maximum is $1.633$ at $n=6$ and $2.291$ at $n=8$ (**matching Reviewer 67's ceiling to six digits from independent code**) and adding the vector identity $R\lambda=-2\lambda$ buys $18\%$ at $n=6$ and nothing at $n=8$.

**On the coordinator's query.** Its phase-6 "key finding" is confirmed to be **relaxation points, not Weyl tensors**: its search constrained only trace-freeness, unit norm and $S_{\mathfrak{mmm}}=0$, with measured Ricci $1.279$, Bianchi $1.206$ and $\|R\lambda+2\lambda\|=4.431$ against $10^{-16}$ at genuine Weyl points. Relabelled accordingly; nothing bears on Conjecture A. **It also corrected the coordinator**: the $R$-level feasibility LP returns *feasible* for that spectrum, with a certificate exhibited two ways, the coordinator's infeasibility came from typing a rounded spectrum into an equality-constrained program.

## Reviewers 69 and 70, Gate 2 on the symmetry defect, fence posts 18–20 and $\Theta_3$

Full reports: [reviews/REVIEW_r69.md](reviews/REVIEW_r69.md), [reviews/REVIEW_r70.md](reviews/REVIEW_r70.md). Two cold reviewers, identical briefs, independent implementations, run 2026-08-23.

**They agree on every disputed number**, which is what makes this round decisive: $\Theta_3=-2\theta$; the $S^3\times S^3$ / $\mathbb{CP}^3$ third-moment ratio exactly $13.5$; $a/b$ exactly $-14$; $\Delta=12$ at the $C_5$ blow-up; padded $\mathbb{CP}^2$ giving $\Delta=8,16,24,32$ under $\{\lambda\ge0\}$; the padded leak equal to $16$ and $24$. Both also independently derived $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$.

| Claim | Verdict |
|---|---|
| Fence post F18 | CONFIRMED as scoped; $n\ge5$ added; only the *unweighted* sum is inert |
| $\Delta$ and its grading consequence | CONFIRMED; $\ker W=0$ is load-bearing and was omitted from the script |
| The $\{\lambda>0\}$ convention | CONFIRMED |
| The $\mathbb{CP}^2$ correction | **REFUTED, the record's claim survives**; swap the witness to the $C_5$ blow-up |
| $\Theta_3=32\theta$ | Proportionality CONFIRMED; **constant REFUTED, it is $-2$** |
| Fence post F19 | **REFUTED on sign and hypothesis**; the route closes for the opposite reason |
| Fence post F20 | Primary CONFIRMED exactly; **secondary REFUTED by construction** |

**What the round produced beyond its brief.** The identity $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ and the bound $\theta\le|\lambda_{\min}|(4(n-1)-\Delta-G_0)/4$, *the first bound of the shape the B-band target asks for*, with equality at every symmetric-space point. The closed forms $\Psi_1=\mathrm{scal}/(n(n-1))$ and $\Psi_2=12/((n-1)n(n+1)(n+2))$. The observation that $A(W)=2W$ is a per-row identity. And Euclidean Schwarzschild as an exact geometric fixture at $\theta=\theta_0(4)$.

**What it cost.** Four recorded claims were wrong rather than merely overstated: the $\Theta_3$ constant, fence post F19's sign, fence post F20's generality, and the $\mathbb{CP}^2$ correction. Three of the four came from the same cycle, and all three of those from reading a source's hedge as an assertion or from not carrying a paper's own normalisation constants.
