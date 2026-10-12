# REVIEW r1940: I124 batch 8, support of W in the R=0 branch

Log: [agent_logs/r1940-i124-support.log](../agent_logs/r1940-i124-support.log). Section under review: batch 8 of [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md). Analysis only, no screens were needed.

**Verdict: REFUTED AS STATED, repairable by one index.** The formula for $\hat A$, the support reduction and the padding step are correct. The $\lvert U\rvert=6$ case rests on $M(6)=\sqrt{3/2}$, which the record does not prove: only $M(6)\ge\sqrt{3/2}$ is on file. So the unconditional statement is $\lvert U\rvert\le5$, the bullet's "seven" becomes "six", and I104's $R=0$ branch is conditional on $M(6)$.

| # | claim | verdict |
|---|---|---|
| 1 | formula for $\hat A$, $\theta-ap>0$ | CONFIRMED |
| 2 | support of $\pi_D(\nu\circ\nu)$ in $U$ | CONFIRMED |
| 3 | padding, Ricci-flatness, $\theta$ invariance | CONFIRMED (it is [L164](../findings/stratum-two-negative.md)) |
| 4 | $M(m)=\sqrt{3/2}$ at $m=4,5,6$, $\mathcal W_m=0$ at $m\le3$ | REFUTED at $m=6$, CONFIRMED at $m=4,5$ and $m\le3$ |
| 5 | I104's configuration, six indices, $R=0$ | PLAUSIBLE as a conditional, REFUTED as an unconditional exclusion |
| 6 | bullets | REFUTED ("seven" is "six", and the range not reached is $6\le m\le11$) |
| 7 | Lean | CONFIRMED |
| 8 | record search | classified: agreement with L164 and L220/L221 methods, and the support reduction on general $\nu$ is new |

## 1. The formula for $\hat A$

The $D$ component of $W\circ W=\theta W$ is $a^2Q(\hat A)+b^2\pi_D(\nu\circ\nu)=\theta a\hat A$ (given). With $Q(\hat A)=p\hat A$ it reads $b^2\pi_D(\nu\circ\nu)=a(\theta-ap)\hat A$. Here $p=\langle Q(\hat A),\hat A\rangle=P(\hat A)\le\Theta_n\le\theta$ by L57, and $0<a<1$ since $b>0$. If $p\le0$ then $\theta-ap\ge\theta>0$, and if $p>0$ then $ap<p\le\theta$. So the coefficient is positive and the formula holds. A side remark: $\hat A\ne0$ then forces $\pi_D(\nu\circ\nu)\ne0$, which is consistent. **CONFIRMED.**

## 2. The support claim

First, $\nu$ has zero diagonal entries in the $\varphi$ basis: the diagonal part of any Weyl tensor has row sums $\sum_jW_{ijij}=\mathrm{Ric}_{ii}=0$ and satisfies Bianchi trivially, so it lies in $D$. Hence $\pi_DW=\operatorname{diag}(W)$ and $\nu=\sum_{\alpha\ne\beta}c_{\alpha\beta}\varphi_\alpha\odot\varphi_\beta$, and $U=\bigcup\{\alpha\cup\beta:c_{\alpha\beta}\ne0\}$ is well defined.

- **The square part.** $(\nu^2)_{\gamma\delta}=\sum_\beta\nu_{\gamma\beta}\nu_{\beta\delta}$ is nonzero only if $\nu$ has a nonzero entry in row $\gamma$ and in row $\delta$, so $\gamma,\delta\subseteq U$. In particular the diagonal entries of $\nu^2$ sit on pairs inside $U$.
- **The sharp part.** $(\nu^\#)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}\nu_{\gamma\varepsilon}\nu_{\delta\zeta}$ needs $\gamma,\delta,\varepsilon,\zeta$ to be pairs carrying entries of $\nu$, so all lie in $U$. The structure constant $c_{\alpha\gamma\delta}\ne0$ needs $\gamma,\delta$ to share exactly one index and $\alpha=\gamma\triangle\delta$ ($[\varphi_{ij},\varphi_{jk}]=\pm\varphi_{ik}$), so $\alpha\subseteq\gamma\cup\delta\subseteq U$. **A bracket cannot produce an index outside $U$.**

So $\pi_D(\nu\circ\nu)$, hence $\hat A$, is supported on diagonal pairs inside $U$, and $W=a\hat A+b\nu$ on $\Lambda^2\operatorname{span}\{f_i:i\in U\}$. The proof's phrase "built from $\varphi_\alpha\varphi_\beta^{\mathsf T}\varphi_\gamma\cdots$" is loose (the square's entries are indexed by the four pairs through inner products $\langle\varphi_\beta,\varphi_\gamma\rangle$), but the index bookkeeping it gestures at is right. This is exactly [L164](../findings/stratum-two-negative.md)'s step (iii) read for $\nu$ in place of $W$. **CONFIRMED.**

## 3. Padding

A Weyl tensor of $\mathbb R^n$ supported on $\Lambda^2U$ (in the geometric sense L164 requires: annihilating $(\Lambda^2U)^\perp$ and preserving $\Lambda^2U$, which coordinate support in the frame gives) restricts to $W'\in\mathcal W_{\lvert U\rvert}$: $\mathrm{Ric}'_{ik}=\sum_{j\in U}W_{ijkj}=\sum_{j}W_{ijkj}=0$ and Bianchi restricts. $\lVert W'\rVert=\lVert W\rVert$ and $P(W')=P(W)$ since $\Lambda^2U=\mathfrak{so}(U)$ is a subalgebra with the restricted structure constants. This is [L164](../findings/stratum-two-negative.md), Gate 2 PROVEN (r739, r740), and it should be cited in place of the bare assertion. Batch 8 needs only $\theta=P(W')\le M(\lvert U\rvert)$, which follows. **CONFIRMED.**

One simplification: $M(m)$ is non-decreasing in $m$ by padding, so $\lvert U\rvert\le m_0$ needs only $M(m_0)$, and the three separate values are one value.

## 4. The $M(m)$ values: $M(6)$ is open

What the record holds, read in the cited files and their sources:

| $m$ | status | kind of proof |
|---|---|---|
| $\le3$ | $\mathcal W_m=0$ | $\dim\mathcal W_m=m(m+1)(m+2)(m-3)/12=0$, and also L164's $\dim U\le3$ branch |
| 4 | $M(4)=\sqrt{3/2}$ proved | hand proof, $P=9(\det W^++\det W^-)$ on $\mathcal W_4$ (post F2c, [stratum-two-negative.md:293](../findings/stratum-two-negative.md#L293)) |
| 5 | $M(5)=\sqrt{3/2}$ proved | [L61](../findings/sym3-blocks.md), an exact rational SOS certificate, $F_5=\tfrac32\lVert W\rVert^6-P^2\ge0$ on $\mathcal W_5$ |
| 6 | **only $M(6)\ge\sqrt{3/2}$** (padded $W_{\mathbb{CP}^2}$) | no upper bound on file |

- **[bispectral.md:465](../findings/bispectral.md#L465)'s "the record certifies only at $n=4,6$" is unsupported**, as is the $M(6)=\sqrt{3/2}$ in [conventions.md](../findings/conventions.md)'s $M(n)$ row and [INDEX-traps.md](../findings/INDEX-traps.md)'s W5. None cites a proof, and I found none in findings/, results.md or lean/.
- **Two earlier reviews already say so.** [REVIEW_r282.md](REVIEW_r282.md), line 52: "$M(4)=M(5)=\sqrt{3/2}$ are proved … $M(6)$ through $M(11)$ are open, the record contains no proof for any of them". [REVIEW_r649.md](REVIEW_r649.md) §4.3: "What is proved is $M(6)\ge\sqrt{3/2}$ … [conventions.md] and [W5] both assert $M(6)=\sqrt{3/2}$ flatly; that is a separate defect … I flag it rather than chase it." That defect was never repaired, and batch 8 inherited it.
- **The only attempted ceiling was withdrawn.** [second-order.md:1118](../findings/second-order.md#L1118)'s $M(6)\le\Phi(15)$ is sound as containment but $\Phi(15)$ has no upper bound (ELIM-secondorder).
- **What supports $M(6)=\sqrt{3/2}$ is numerical**: ascent from random starts in $\mathcal W_6$ reaches $\sqrt{3/2}$ (r282, [nondegeneracy.md:342](../findings/nondegeneracy.md#L342), 100 of 100 starts). Under the analysis-only rule this is a screen, not a proof.

**Verdict: CONFIRMED at $m\le5$, REFUTED at $m=6$.** Batch 8's "If $\lvert U\rvert\le6$" is proved for $\lvert U\rvert\le5$ only (by $M(5)$, with $M(4)\le M(5)$), and is conditional on $M(6)=\sqrt{3/2}$ at $\lvert U\rvert=6$. The comparison $\tfrac32<\theta_0(n)^2$ at $n\ge12$ is right: $\theta_0^2-\tfrac32=(n^2-12n+8)/(2n^2)$ is `theta0Sq_sub_three_halves` and positivity is `threshold_pos`.

## 5. I104's configuration

- **Index count.** $Q_1=\{i,j,k,l\}$, $Q_2=\{i,j,m,p\}$, $Q_3=Q_1\triangle Q_2=\{k,l,m,p\}$, union six indices. $U$ is the set $\nu$ actually touches, so $\lvert U\rvert=6$ when at least two $\nu_a$ are nonzero (L221(b)'s hypothesis, and any two of the three four-sets cover all six) and $\lvert U\rvert=4$ with one (L220's case). "Has $\lvert U\rvert=6$" should read $\lvert U\rvert\le6$, with equality on the I104 stratum proper.
- **$R=0$ is a branch.** In the configuration's frame, $\pi_D(\nu\circ\nu)=\sum_a\nu_a\circ\nu_a\in\Pi_1+\Pi_2+\Pi_3=\Sigma$ ($\nu_a\circ\nu_b$, $a\ne b$, has character $\chi_{Q_c}$ and falls in $D^\perp$). $R=0$ holds iff $D\propto\sum_a\nu_a\circ\nu_a$, which puts $D$ in $\Sigma$. Nothing forces it, and the generic point of the stratum has $D$ with a component $\rho\perp\Sigma$.
- **Consequence of §4.** The conclusion "its $R=0$ branch lies outside I124's range" is exactly the statement $M(6)\le\theta_0(12)$, i.e. it is conditional on an open value. **PLAUSIBLE as a conditional, REFUTED as unconditional.**
- **A route to repair without $M(6)$** (a pointer, not derived here): on the $R=0$ branch $D=s\in\Sigma$, so the [I104 derivation](2026-09-15-I104-derivation.md)'s joint chain loses its $\rho$ term and becomes $\theta(1-N)=P(s)+\tfrac\theta2N-3\tau$ with $\lVert s\rVert^2+N=1$, where $P(s)\le\Theta_6\lVert s\rVert^3$ by L57 at $n=6$ and $\Sigma$ is six-dimensional with explicit coordinates. That chain alone does not bound $\theta$ (it leaves $\tau$ free), but it is a finite-dimensional problem on explicit coordinates and a smaller target than $M(6)$.

## 6. The bullets

- **"At least seven frame indices"**: provable form is **at least six** ($\lvert U\rvert\le5$ excluded). Seven is conditional on $M(6)=\sqrt{3/2}$.
- **"A pair-character component on $\{j,k\}$ touches $j$, $k$ and every $i$ carrying weight"**: correct, $\nu=\sum_ax_a\,e_{ja}\odot e_{ka}$ ([L222](../findings/second-order.md)), and $\sum x=0$ makes at least two $a$ carry weight, so at least four indices. **"A four-set component its four indices"**: correct, since $a+b+c=0$ with $(a,b,c)\ne0$ leaves at least two nonzero coordinates, which between them touch all four. Pair and four-set characters are all the characters $\nu$ can carry ([L120](../findings/second-order.md)), so the list is complete.
- **"What it does not reach"**: should read padded points from $\mathbb R^m$ with **$6\le m\le11$**, and the branch $R\ne0$. Also worth stating: the conclusion is frame-by-frame, so a point escapes only if $R\ne0$ or $\lvert U\rvert\ge6$ in every frame with $a,b>0$.

## 7. Lean

`HamiltonsCubic.I124Circle.diag_coeff_pos (a p θ : ℝ) (ha0 : 0 < a) (ha1 : a < 1) (hθ : 0 < θ) (hp : p ≤ θ) : 0 < a * (θ - a * p)` and `HamiltonsCubic.L2.threshold_pos {n : ℤ} (h : 12 ≤ n) : 0 < n ^ 2 - 12 * n + 8` state what the table says. The link from `threshold_pos` to $\tfrac32<\theta_0(n)^2$ is `theta0Sq_sub_three_halves` in the same file, which the note could cite. Both hypothesis sets are satisfiable (e.g. $a=\tfrac12,p=1,\theta=2$, and =12$). Axioms, by `#print axioms` (exit 0, non-vacuity example at $a=\tfrac12,p=1,\theta=2$ elaborated): both depend on `propext`, `Classical.choice`, `Quot.sound` only. **CONFIRMED.** The Lean covers none of the load-bearing steps (support, padding, $M(m)$), as the note says.

## 8. On the record already?

- **Padding and the restriction lemma**: [L164](../findings/stratum-two-negative.md), proved. Batch 8 should cite it.
- **Support arguments of this kind in the closed branch**: batch 6 (2) did the same for a single four-set character, and [L220](../findings/second-order.md) caps that case at $\sqrt{3/2}$ on the operators. [L221](../findings/second-order.md) caps disjoint four-sets and two four-sets sharing two indices with $\tau\le0$, and the [I121 note](2026-09-28-I121-MG-audit.md) (lines 64–65) places the closed branch on these subalgebras. [L284](../findings/second-order.md) supplies the $C=0$ equivalence.
- **New**: the general statement that at $R=0$ the whole of $W$ lives on the indices $\nu$ touches, for $\nu$ over any mix of characters, and the resulting exclusion of $\lvert U\rvert\le5$. I found no prior occurrence. The [I104 tau-positive note](2026-09-14-I104-tau-positive.md) and the [I104 derivation](2026-09-15-I104-derivation.md) work on the six indices directly, and the derivation's $\Sigma=\operatorname{Fix}_\varphi(\mathcal D_6)$ is the natural home of the $R=0$ branch at I104, but neither makes the padding reduction.

## Corrections owed

1. Statement: "If $\lvert U\rvert\le5$, then $\theta\le\sqrt{3/2}$" (by L61 and padding monotonicity), and at $\lvert U\rvert=6$, "conditional on $M(6)=\sqrt{3/2}$, open (r282, r649)".
2. Drop "certified at $m=4,6$ per bispectral.md" and cite post F2c for $m=4$ and L61 for $m=5$, and L164 for padding.
3. I104 sentence: "has $\lvert U\rvert\le6$ (six on the stratum), so its $R=0$ branch lies outside I124's range **if $M(6)=\sqrt{3/2}$**".
4. Bullets: "at least six frame indices", and not reached: $6\le m\le11$.
5. Record-level, outside this batch: [conventions.md](../findings/conventions.md)'s $M(n)$ row, [INDEX-traps.md](../findings/INDEX-traps.md) W5 and [bispectral.md:465](../findings/bispectral.md#L465) assert $M(6)=\sqrt{3/2}$ as known. r649 flagged it and it stands unrepaired.
