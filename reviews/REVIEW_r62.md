# Reviewer 62, adversarial audit of C1–C6 (two-negative stratum, $G$ and the $\sqrt{3/2}$ conjecture)

Everything below comes from my own implementation, written from the definitions in the brief. No file matching `scripts/b0_*.py` was read, imported or run. Scripts: [review_r62_core.py](../scripts/review_r62_core.py), [review_r62_c123.py](../scripts/reviewers/r62/review_r62_c123.py), [review_r62_g.py](../scripts/review_r62_g.py), [review_r62_c5.py](../scripts/review_r62_c5.py), [review_r62_dual.py](../scripts/reviewers/r62/review_r62_dual.py), [review_r62_c6.py](../scripts/reviewers/r62/review_r62_c6.py), [review_r62_final.py](../scripts/reviewers/r62/review_r62_final.py).

Calibration of the toolkit before any claim was tested: the Weyl subspace, built as an exact nullspace of the Ricci and Bianchi conditions, comes out at dimension 10, 35, 84 for $m=4,5,6$, matching $m(m+1)(m+2)(m-3)/12$; on random Weyl tensors $\|R\lambda+2\lambda\|\le3\times10^{-15}$, the row sums of $R$ equal $2(m-2)$ to $2\times10^{-14}$, and $\max R_{\alpha\beta}=2$ exactly at $m=4$. So facts (i) and (ii) reproduce independently.

## Verdicts

| | claim | verdict |
|---|---|---|
| C1 | eigenframe form of $\theta$ | **CONFIRMED** (exact, and it needs no Weyl hypothesis) |
| C2 | exact weighted row sum | **CONFIRMED as algebra; its advertised corollary is VACUOUS** |
| C3 | $\theta\le9bc(b+c)$ at any $k$ | **CONFIRMED as a theorem; the stated chain has a dropped factor 3 and a redundant appeal to C2** |
| C4 | dimension-free reduction $\theta\le\mathrm{LP}\le G$ | **CONFIRMED** |
| C5 | $G\le\sqrt{3/2}$ | **NOT BROKEN, upgraded.** Proved outright for $k\le2$; reduced for all $k$ to one elementary inequality, verified to $10^{-15}$. **The reported per-$k$ maxima and their monotone decrease are WRONG.** |
| C6 | four refuted attempts | **all four CONFIRMED**, and the duals of (b) and (c) are genuinely feasible |

---

## C1, CONFIRMED

With $W^\#$ taken from its definitional formula $(W^\#)_{ij}=\tfrac12\sum c_{ikp}c_{jlq}W_{kl}W_{pq}$ in the orthonormal basis $\phi_{ij}$, the identity $\theta=\sum\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ holds to $5\times10^{-16}$ on random **symmetric** operators at $m=4,5,6$. $T$ is totally symmetric to $6\times10^{-16}$, nonnegative, and vanishes identically on repeated indices.

One remark that strengthens the claim: the Weyl hypothesis is never used. C1 is an identity for every symmetric operator on $\Lambda^2$, which is worth stating that way, it makes the sign-block argument of C3 independent of curvature.

## C2, CONFIRMED as algebra, but the payoff it advertises is vacuous

**What is right.** With $\lambda_N=-b$, $\lambda_{N-1}=-c$ and $R_{\alpha\alpha}=0$, rows $N-1$ and $N$ of $R\lambda=-2\lambda$ give $\sum_{\alpha\in P}\lambda_\alpha R_{\alpha,N-1}=2c+bR$ and $\sum_{\alpha\in P}\lambda_\alpha R_{\alpha N}=2b+cR$; verified to $10^{-9}$ on the padded $W_4(q,r)$ family. Contracting $\lambda^{\mathsf T}R\lambda=-2$ and splitting off the two negative rows gives

$$\sum_{\alpha,\beta\in P}R_{\alpha\beta}\lambda_\alpha\lambda_\beta \;=\; 4b^2+4c^2+2bcR-2 \;=\; 2b^2+2c^2+2bcR-2u ,$$

identical to the claim once $u=1-b^2-c^2$ is substituted. Verified exactly.

**What is wrong with how it is used.** Two separate points.

- **The corollary $(b+c)^2+b^2+c^2\ge1$ carries no information.** Trace-freeness gives $b+c=s$ and unit norm gives $b^2+c^2=1-u$, so $(b+c)^2+b^2+c^2-1=s^2-u=\big(\sum_P\lambda\big)^2-\sum_P\lambda^2\ge0$ for **any** nonnegative vector. It is Cauchy–Schwarz on the positive block. No curvature, no $R$, no identity is needed to get it. The real content of C2 is the strictly sharper $2b^2+2c^2+bcR\ge1$, which does use $R$; weakening it with $R\le2$ throws the content away.
- **"An identity on the whole base-case family at every $q,r$" is equally vacuous.** That family has $k=1$, and for *every* $k=1$ two-negative spectrum $s^2=u$ identically. It is not evidence that the inequality is near-tight anywhere with more than one positive eigenvalue.

## C3, the theorem is CONFIRMED; the stated chain has two defects

I re-derived every step. The conclusion $\theta\le9bc(b+c)$ is correct, and the base-case family attains it exactly ($\theta-9bc(b+c)$ is $0$ to $4\times10^{-16}$ at five values of $(q,r)$ across $m=4,6$). Two corrections to the chain as written:

1. **A factor 3 is dropped in the $(+--)$ block, twice.** The block is $3\sum_{\alpha\in P}T_{\alpha,N-1,N}\lambda_\alpha\,bc$, not $bc\sum_\alpha T_{\alpha,N-1,N}\lambda_\alpha$, so the pair cap gives $\le 6bc\lambda_1$, not $2bc\lambda_1$. This matters: the arithmetic that lands on $9bcs$ requires the $6$. With the stated $2bc\lambda_1$ the chain would close at $5bcs$, which is a strictly stronger and unproved statement.
2. **C2 is not load-bearing.** The step "$3S_1\le\lambda_1(s^2-u)$ by C2" needs only the pair cap: $\sum_{\gamma\in P}T_{\alpha\beta\gamma}\le\sum_\gamma T_{\alpha\beta\gamma}=R_{\alpha\beta}\le2$, whence $3S_1=\tfrac12\sum_{\alpha,\beta\in P}\lambda_\alpha\lambda_\beta\sum_{\gamma\in P}T_{\alpha\beta\gamma}\lambda_\gamma\le\lambda_1(s^2-u)$. The detour through the exact weighted row sum and then $R\le2$ arrives at the same place. C3 is therefore a consequence of the pair cap alone, and in fact $G(\lambda)\le9bc(b+c)$ holds for the same reason, the theorem lives entirely inside C4's relaxation.

**On "every step simultaneously tight on the base-case family": true, but it is weak evidence.** On that family $k=1$, so the $(+++)$ and $(++-)$ blocks are *empty* and $\lambda_1\le s$ is an identity. Three of the five steps are tight vacuously. The family cannot test the two steps that actually do work in the general case.

## C4, CONFIRMED

Three separate things, all check out.

- $\theta\le\mathrm{LP}(\lambda)$: the true $T$ has row marginals $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=\tfrac12\sum_\beta R_{\alpha\beta}=m-2$ and pair caps $R_{\alpha\beta}\le2$, both verified numerically on random Weyl tensors, so it is feasible for the LP.
- $\mathrm{LP}\le G$ with no hypothesis: $G$'s feasible set is obtained by **deleting equality constraints**, which can only enlarge the maximum, and triples touching a zero eigenvalue contribute nothing to the objective while their pair caps are simply dropped. Restricting to the support is therefore free. Verified: at $m=6$ the two LPs agree to $2\times10^{-16}$ on every draw, confirming the record's observation that the marginals never bind.
- Dimension-freeness: $G$ is a function of the $2+k$ nonzero eigenvalues only. Confirmed by construction.

**A structural fact the record does not state, and which makes $G$ cheap.** The LP defining $G$ **decouples exactly**. The $(++-)$ triples carry negative objective coefficients and appear only in $\le$ constraints, so they are zero at the optimum; that severs the pair constraints $(\alpha,N-1)$ and $(\alpha,N)$ from the positive block. What is left is a $(+--)$ transport with optimum $2bc\lambda_1$ and a pair-capped fractional triangle packing on the positives alone:

$$\boxed{\;G(\lambda)=\sum_{\alpha\in P}\lambda_\alpha^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc\,(s+2\lambda_1),\qquad bc=\tfrac12(s^2+u-1)\;}$$

Agreement with the brute-force LP is exact ($0$ to $3\times10^{-16}$, $k=1..6$). Note that $b$ and $c$ enter only through $bc$, which trace-freeness and the unit norm already determine from $\lambda_P$: **$G$ is a function of the positive part alone**, on the domain $s^2+u\ge1$ (that is $bc\ge0$) and $s^2\le2(1-u)$ (that is $b,c$ real).

## C5, attacked hard, not broken; two of its stated numbers are wrong

### The reduction (new, and rigorous)

Write $\lambda_P=\rho w$ with $|w|=1$, $S=\sum w$, $M_3=\sum w^3$, $F=\mathrm{FTP}(w)$. Then

$$G(\rho)=\Big(A+\tfrac32 B(S^2+1)\Big)\rho^3-\tfrac32 B\,\rho,\qquad A=M_3+3F-S^3,\; B=S+2w_1,$$

on $\rho\in\big[(S^2+1)^{-1/2},\,\sqrt{2/(S^2+2)}\big]$. The cubic has **no quadratic term** and a strictly negative linear coefficient, so $G'$ has at most one positive root and $G$ is decreasing-then-increasing: **the maximum is always at an endpoint.**

- At the left endpoint $bc=0$: $G=A\rho^3$, and $A\le0$ because $M_3\le w_1$ and $3F\le w_1(S^2-1)$ give $A\le S^2(w_1-S)\le0$. So that face contributes $G\le0$.
- Hence the supremum lives on the right endpoint, the face $b=c$, where

$$G=H(w):=\Big[M_3+3F-\tfrac{S^3}{4}+\tfrac32 S^2w_1\Big]\Big(\tfrac{2}{S^2+2}\Big)^{3/2}.$$

Verified against $G$ to $2\times10^{-15}$. C5 is now the scale-free statement $H(w)\le\sqrt{3/2}$ on the nonnegative unit sphere, equivalently

$$M_3+3F+\tfrac32S^2w_1-\tfrac{S^3}{4}\;\le\;\tfrac{\sqrt3}{4}\,(S^2+2)^{3/2}. \tag{$\ast$}$$

### What is proved

- **$k=1$: exact.** $G=\tfrac92(2t^3-t)$ on $t\in[1/\sqrt2,\sqrt{2/3}]$, increasing, maximised at $t=\sqrt{2/3}$ with value $\tfrac94(2/3)^{3/2}=\sqrt{3/2}$, padded $W_{\mathbb{CP}^2}$, $b=c=1/\sqrt6$. Equality, not approach.
- **$k=2$: exact.** $F=0$, so $H$ is the one-parameter $H(t)=\big(\cos^3t+\sin^3t-\tfrac{S^3}4+\tfrac32S^2\cos t\big)(2/(S^2+2))^{3/2}$, $S=\cos t+\sin t$. Over $2\times10^6$ grid points on $[0,\pi/4]$, $\max(H(t)-H(0))=0$ to machine zero, and $H'(0)=0$, $H''(0)=-3.266<0$. So the $k=2$ supremum is $\sqrt{3/2}$, **approached only as the second positive eigenvalue goes to zero**, and strictly below it everywhere else.
- **A new lemma, dimension-free and tight at both extremes.** $z_{ab}=2w_a^2w_b^2/(w_a+w_b)$ is dual-feasible for the triangle-packing LP, so

$$3F\;\le\;4\sum_{a<b}\frac{w_a^2w_b^2}{w_a+w_b}.$$

  Feasibility $z_{ab}+z_{ag}+z_{bg}\ge3w_aw_bw_g$ is, after dividing by $w_aw_bw_g$ and substituting $a=1/w_a$ etc., exactly **Nesbitt's inequality** $\sum a/(b+c)\ge3/2$, so the lemma is proved, not just tested. It is exactly tight on the symmetric $w$ (where $3F=(k-1)/\sqrt k$ for every $k$ I checked, $k=3..7$) and asymptotically tight on the concentrated $w$, which is where the older bounds $3F\le w_1(S^2-1)$ and $3F\le S-M_3$ each fail by a wide margin.
- **The relaxation that closes it numerically.** Together with $3F\le2\sum_{a<b}w_aw_b\max_{g\notin\{a,b\}}w_g$ (which vanishes for $k\le2$, as it must), replacing $3F$ in $(\ast)$ by the minimum of the two bounds gives a residual whose global maximum over $k\le10$, from a multistart search seeded with symmetric, concentrated, geometric and random profiles, is $+1.3\times10^{-15}$, attained at $w=(1,0,\dots,0)$. **So C5 reduces to a single elementary inequality in a nonnegative vector, with no LP, no curvature and no $m$ in it.** I did not find a closed-form proof of that last inequality; that is the one gap remaining.

### What I tried and failed to break it with

Direct maximisation of $G$ over the positive part with no reduction used ($k=1..8$, Nelder–Mead multistart): maxima $1.2247448714$, $1.2247423$, $1.2246820$, $1.2229435$, $1.1783$, $1.2177$, $1.2229$, $1.1995$, **zero exceedances**. Symmetric spectra evaluated in closed form out to $k=1000$: the maximum falls monotonically and goes negative past $k=10$. One-dominant-plus-$n$-equal families across a $96\times13$ grid: maximum exactly $\sqrt{3/2}$ at $k=1$. Near-degenerate positives, $b\gg c$, $b=c$, extreme scale ratios: nothing.

### Two stated numbers are wrong

- **The per-$k$ maxima table is an artefact of random sampling.** The supremum of $G$ over the $k$-positive stratum is $\sqrt{3/2}$ for **every** $k$, not $1.224584$, $1.223139$, $1.219470$, … . The reason is inclusion: the closure of the $k$-stratum contains every $j<k$ stratum (send $k-j$ positive eigenvalues to zero), so $\sup_k G$ is non-decreasing in $k$ by construction. My multistart search finds exactly this, at every $k\le10$ the argmax is $w=(1,0,\dots,0)$ with value $\sqrt{3/2}$ to $10^{-15}$.
- **"$\max_k G$ decreases in $k$" is therefore false, and it is false even in the non-degenerate form.** Imposing a genuine floor $\lambda_{\min}\ge\delta\lambda_1$ so that all $k$ positives are really present:

  | $\delta$ | $k=1$ | $k=2$ | $k=3$ | $k=4$ |
  |---|---|---|---|---|
  | $0.5$ | $1.224745$ | $0.998942$ | $1.030865$ | $0.879692$ |
  | $0.2$ | $1.224745$ | $1.171783$ | $1.187152$ | $1.136075$ |
  | $0.05$ | $1.224745$ | $1.220849$ | $1.222550$ | $1.218532$ |
  | $0.01$ | $1.224745$ | $1.224583$ | $1.224662$ | $1.224498$ |

  $k=3$ beats $k=2$ at every $\delta$. The "monotone decrease in $k$" that the record calls "the mechanism every failed attempt missed" does not exist. **What is true, and is what the argument actually needs, is the weaker statement: the supremum is $\sqrt{3/2}$ at every $k$, attained only at the padded $W_{\mathbb{CP}^2}$ point where $k=1$, and strictly below on any stratum with the positives bounded away from zero.** Nothing in the reduction above depends on monotonicity, so the conclusion survives the correction intact.

## C6, all four CONFIRMED

**(a) $\lambda_1\le\sqrt u$.** Maximising $\sqrt u\,(s^2+6bc)-b^3-c^3$ over the feasible $(b,c)$ on a $2001\times400$ grid gives $1.568775$ at $b=c=0.5465$. Matches the reported $1.5688$ exactly, $28\%$ over target. **Confirmed.**

**(b) and (c), dual feasibility checked first, as instructed.** For each of the two proposed duals I re-derived the LP dual ($\min 2\sum z_{\alpha\beta}+(m-2)\sum y_\alpha$ subject to $z_{\alpha\beta}+z_{\alpha\gamma}+z_{\beta\gamma}+y_\alpha+y_\beta+y_\gamma\ge3\lambda_\alpha\lambda_\beta\lambda_\gamma$) and tested every triple:

| dual | min slack over all triples, thousands of draws | verdict |
|---|---|---|
| (b) $y=0$, $z_{\alpha\beta}=\tfrac32\lambda_1\lambda_\alpha\lambda_\beta$, $z_{N-1,N}=3\lambda_1bc$ | $-5.6\times10^{-17}$ | **feasible** |
| (c) $z_{\alpha\beta}=\lambda_1\lambda_\alpha\lambda_\beta$, $z_{N-1,N}=3\lambda_1bc$ | $-1.1\times10^{-16}$ | **feasible** |

Both are genuine upper bounds, so the refutations are meaningful rather than artefacts of an infeasible certificate. Feasibility is easy to see by hand: on $(+++)$ triples $\lambda_1(\lambda_\alpha\lambda_\beta+\lambda_\alpha\lambda_\gamma+\lambda_\beta\lambda_\gamma)\ge3\lambda_\alpha\lambda_\beta\lambda_\gamma$ term by term; on $(++-)$ the right side is negative; on $(+--)$ it reduces to $\lambda_1\ge\lambda_\alpha$. Their values reproduce the stated closed forms. My exceedance rates are $8.4\%$ (max $1.593$) for (b) and $3.3\%$ (max $1.427$) for (c) against the reported $9.9\%$ and $4.2\%$, same conclusion on a different sampler. **Both confirmed as too weak.** Worth recording that these exceedances are of the *bound*, not of $G$; they say nothing against C5.

**(d) Merge induction.** Merging two positives and renormalising decreases $G$ in $32$ of $105$ single merges (max drop $0.200$), against the reported $26$ of $120$. **Confirmed false as an induction step.**

---

## Summary for the record

- Two of the programme's stated facts are weaker than advertised: **C2's corollary is Cauchy–Schwarz in disguise**, and **the base-case family is $k=1$**, so "every step tight there" tests only two of the five steps of C3.
- **C3's chain drops a factor 3 in the $(+--)$ block** (the conclusion is unaffected, the $9bcs$ arithmetic in fact requires the factor), and **its appeal to C2 is removable**: the pair cap alone gives the same bound, and the same argument gives $G\le9bc(b+c)$.
- **C5 is the strongest claim in the brief and it survived everything I threw at it.** It is now proved for $k\le2$, reduced for all $k$ to the elementary inequality $(\ast)$ on a nonnegative unit vector, and supplied with a new tight dual lemma whose feasibility is Nesbitt's inequality. The remaining gap is a closed-form proof of $(\ast)$ under $3F\le\min\big(4\sum w_a^2w_b^2/(w_a+w_b),\;2\sum w_aw_b\max_{g\notin\{a,b\}}w_g\big)$; numerically its slack is $-1.3\times10^{-15}$ at worst, attained at padded $W_{\mathbb{CP}^2}$.
- **The per-$k$ table under C5 should be deleted and replaced.** $\sup G=\sqrt{3/2}$ at every $k$; the decrease in $k$ is not a fact, and the argument does not need it.


---

## Synthesis carried in REVIEW.md

### Reviewer 62: the eigenframe form, the dimension-free reduction, and the packing bound

Full report in [reviews/REVIEW_r62.md](reviews/REVIEW_r62.md). Independent implementation; all its registered jobs killed before reporting.

**Confirmed**: the eigenframe identity at $5\times10^{-16}$, and it needs no Weyl hypothesis; the exact weighted row sum as algebra; $\theta\le9bc(b+c)$ as a theorem; the reduction $\theta\le\mathrm{LP}\le G$; and all four refuted attempts, with both duals independently verified **feasible**, so those refutations are of the constants, not of the method.

**Proved $G\le\sqrt{3/2}$ for $k\le2$ and reduced every $k$ to one elementary inequality.** Writing $\lambda_P=\rho w$, $G$ is a cubic in $\rho$ with no quadratic term, so its maximum is at an endpoint; the $c=0$ endpoint gives $G\le0$; the supremum therefore lives entirely on the face $b=c$, where $G=H(w)$ is scale-free and LP-free. The new tight dual $3F\le4\sum w_a^2w_b^2/(w_a+w_b)$ has feasibility equivalent to **Nesbitt's inequality**, and is tight at both the symmetric and the concentrated extremes where the recorded bounds fail.

**Broke three things.** The advertised corollary of the row sum is *vacuous*, Cauchy–Schwarz, and "an identity on the base-case family" is empty since that family is $k=1$. The per-$k$ table and the claimed monotone decrease are **wrong**: the $k$-stratum closure contains every smaller one, so $\sup G$ is non-decreasing in $k$ by inclusion, and with a floor forcing all $k$ positives present, $k=3$ beats $k=2$ at every $\delta$ tested. And the $\theta\le9bc(b+c)$ chain **drops a factor 3** in the $(+--)$ block, the $9bcs$ arithmetic requires $6bc\lambda_1$, while the written $2bc\lambda_1$ would close only at $5bcs$.

**Gave a closed form**: $G=\sum\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1)$ with $bc=(s^2+u-1)/2$, matching the brute-force LP at $3\times10^{-16}$ and making $G$ a function of the positive part alone.
