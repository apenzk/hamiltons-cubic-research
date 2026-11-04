# Review r872, I77 and the dual bound: a sound derivation, exact at the balanced product for every $p$, and a refuted reduction

**Reviewer r872, independent and adversarial. The brief was cold**: the only files opened were the brief itself and the Lean file it names, [L203DualBound.lean](../lean/HamiltonsCubic/Results/L203DualBound.lean). **No numerical work beyond screening was done**: every value below is exact and in closed form, the derivations are by hand, and the one machine step is an exact-rational screen of the closed forms I was about to record, reported as a screen and never as evidence for a positive claim. The Lean build and the axiom check were run because attack item 11 asks for them. Log: [agent_logs/review-r872-dual.log](../agent_logs/review-r872-dual.log).

## Claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 1 | The dual pairing: multiply by $T\ge0$, sum, get $m_3\le2(n-2)Ny$, and the $z$ term vanishes | **CORRECT** |
| 2 | Imposing the constraint only at triples of distinct indices suffices | **CORRECT** |
| 3 | $\theta=\sum\lambda^3+\tfrac12m_3$, and the bound's factor $(n-2)N$ | **CORRECT** |
| 4 | **Killer test: does the bound ever fall below the true $\theta$?** | **NO VIOLATION. THE BOUND IS VALID** |
| 5 | The $n=4$ witness, $z=1/4$, $y=1/(12\sqrt3)$, bound $=\sqrt3/2$ | **CORRECT ARITHMETIC, CORRECTED READING** |
| 5b | "All three of the all-within, mixed and all-cross functions are simultaneously active" | **MISLEADING: the all-within triple does not exist at $n=4$** |
| 5c | Whether $y$ can be lowered, and whether $z=1/4$ is forced | **$y$ IS OPTIMAL. $z$ IS NOT UNIQUE** |
| 6 | The $n=12$ agreement with $\theta_0(12)$ | **EXACT, NOT APPROXIMATE** |
| 7 | The balanced product's spectrum, and whether the minimax returns $\theta_0(2p)$ for all $p$ | **CORRECT, AND EXACT IDENTICALLY IN $p$** |
| 8 | Whether the tightness is genuine or a coincidence of the dual choice | **GENUINE: COMPLEMENTARY SLACKNESS HOLDS EXACTLY** |
| 9 | The bound returns $5/\sqrt6$ at $W_{\mathbb{CP}^2}$'s spectrum, consistently | **CORRECT AND CONSISTENT** |
| 10 | **"The conjecture follows if the maximum over spectra is $\theta_0(n)$ for $n\ge12$"** | **REFUTED. THE MAXIMUM AT $n=12$ EXCEEDS $3.85$** |
| 10b | Whether the bound holds for all Ricci-flat unit-norm Weyl tensors, not only critical ones | **CORRECT, AND IT NEEDS EVEN LESS THAN RICCI-FLATNESS** |
| 11 | The Lean file: does each statement say what the prose says | **TRUE AS TYPED, FEASIBILITY STILL NOT TYPED** (file corrected mid-review) |
| 12 | What would break it | **NAMED: NOTHING BREAKS THE BOUND, THE REDUCTION IS BROKEN** |

## Summary in one line

The bound is a correct unconditional theorem and it is exactly $\theta_0(2p)$ at the balanced product for every $p$, which is stronger than the record claims, but the reduction built on it is false: at $n=12$ the coordinate-diagonal Ricci-flat Weyl tensor of the six-block partition has dual bound $3\sqrt{165}/10=3.853570$, above $\theta_0(12)=1.236033$ and above the record's own standing bound $3.0509$, and a matching primal $T$ shows the LP relaxation itself is optimal there, so no better dual can rescue it.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. At orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=\Pi_P$.
- $\mathcal W_n$ is the space of algebraic Weyl tensors. $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$.
- $\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, so $\theta_0(4)=\sqrt3/2$ and $\theta_0(12)=\sqrt{55}/6=1.236033$.
- $N=\binom n2$, $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ at $c_{\alpha\beta\gamma}=\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle$, totally symmetric and hollow, and $m_3=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}$.

## Hypothesis inventory

What the derivation of the bound actually consumes, item by item:

| Input | Where it is used | Status |
|---|---|---|
| Given 14, $\theta=\sum\lambda^3+\tfrac12m_3$ in an orthonormal eigenbasis | the objective | load-bearing |
| Given 15, [Lemma L153](../findings/bounds.md), $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ at **every** index | both the $y$ total and the $z$ cancellation | load-bearing, and its **constancy in $\alpha$** is what the $z$ term needs |
| $T\ge0$, from $T=c^2$ | the direction of the inequality after multiplying | load-bearing |
| Hollowness and total symmetry of $T$ | the support of the sum, and folding three slots into one marginal | load-bearing |
| $\mathop{\mathrm{tr}}W=\sum_\alpha\lambda_\alpha=0$ | the $z$ cancellation | load-bearing |
| $\lVert W\rVert=1$ | normalisation of $\theta$ | load-bearing |
| Ricci-flatness beyond its trace | nowhere | **unused** |
| Relations (B) and (C) of Given 12 | nowhere | **unused, and this is the source of the looseness** |
| Decomposability, criticality, the caps, Given 7, Given 9, Given 10 | nowhere | unused |

Ricci-flatness is a system of $\binom{n+1}2$ scalar equations by Given 2. The bound retains exactly one of them, the trace. Relations (B) and (C) are the only inputs that tie $T$ to $\lambda$, and dropping them is what lets the relaxed $T$ concentrate on whichever triple type the spectrum likes best. Section 10 turns that observation into a counterexample to the reduction.

## 1. The dual pairing, and the vanishing of the $z$ term

Assume real $y,z$ with $\lambda_\alpha\lambda_\beta\lambda_\gamma\le y+\tfrac z3(\lambda_\alpha+\lambda_\beta+\lambda_\gamma)$ at every triple of pairwise distinct indices. Multiply by $T_{\alpha\beta\gamma}\ge0$ and sum over all ordered triples. Terms with a repeated index carry $T=0$ by hollowness, so they contribute nothing on either side and the unproved constraint there is harmless. Hence

$$m_3\ \le\ y\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\ +\ \frac z3\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}(\lambda_\alpha+\lambda_\beta+\lambda_\gamma).$$

The first total is $\sum_\alpha\big(\sum_{\beta\gamma}T_{\alpha\beta\gamma}\big)=2(n-2)N$ by Given 15. For the second, total symmetry makes the three slot sums equal, so it is $3\sum_\alpha\lambda_\alpha\sum_{\beta\gamma}T_{\alpha\beta\gamma}=3\cdot2(n-2)\mathop{\mathrm{tr}}W=0$, and the $\tfrac13$ in the ansatz is exactly what absorbs the resulting $3$. So $m_3\le2(n-2)Ny$. **CORRECT.**

On the precise question the item asks: the cancellation needs symmetry of $T$ *and* the constancy of the marginal in $\alpha$. Symmetry alone gives $3\sum_\alpha\lambda_\alpha M_\alpha$ with $M_\alpha=\sum_{\beta\gamma}T_{\alpha\beta\gamma}$, and that is $0$ for every trace-free $\lambda$ only when $M_\alpha$ is independent of $\alpha$. L153's uniformity is therefore load-bearing, not decorative. Were the marginal merely bounded above by $2(n-2)$, the $y$ term would still go the right way but the $z$ term would not cancel, and the whole two-parameter family would collapse to $z=0$.

## 2. The index set and the support of $T$

$c_{\alpha\beta\gamma}=\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle$ is antisymmetric in $\alpha,\beta$ by the bracket, and antisymmetric in $\beta,\gamma$ because $\langle\cdot,\cdot\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$ on skew matrices is ad-invariant, giving $\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle=-\langle\omega_\beta,[\omega_\alpha,\omega_\gamma]\rangle$. So $c$ is totally antisymmetric, $T=c^2$ is totally symmetric, and $T_{\alpha\beta\gamma}=0$ whenever any two indices coincide. **The support of $T$ lies in the set of triples of pairwise distinct indices, which is exactly the set where the constraint is imposed.** Imposing it nowhere else is not merely sufficient, it is the largest set the derivation can use for free.

Two refinements worth recording, both in the reviewer's favour and both used below.

- The maximisation may be restricted further, to triples of distinct indices that are *realisable* given the eigenvalue multiplicities. A constraint at a value-triple that no index-triple attains is not needed, and dropping it can only lower $y$. This matters at $n=4$, section 5.
- It may in principle be restricted to the support of the particular $T$, but that is spectrum-plus-geometry information the bound deliberately refuses, so it stays out.

**CORRECT.**

## 3. The objective and the factor

Given 14 reads $\theta=\sum_\alpha\lambda_\alpha^3+\tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=\sum_\alpha\lambda_\alpha^3+\tfrac12m_3$ at unit norm. Substituting $m_3\le2(n-2)Ny$ gives $\theta\le\sum_\alpha\lambda_\alpha^3+\tfrac12\cdot2(n-2)Ny=\sum_\alpha\lambda_\alpha^3+(n-2)Ny$. The halving of $2(n-2)N$ to $(n-2)N$ is the $\tfrac12$ of the objective, correctly applied. Taking the least admissible $y$ at fixed $z$, namely $y(z)=\max_{\alpha\ne\beta\ne\gamma}\big[\lambda_\alpha\lambda_\beta\lambda_\gamma-\tfrac z3(\lambda_\alpha+\lambda_\beta+\lambda_\gamma)\big]$, and then the best $z$, gives the displayed minimax. **CORRECT.**

An independent check of the whole normalisation chain, conventions included, comes free in section 7: computed from Given 14 with the triangle $T$ of a coordinate configuration, the balanced product returns $\theta=\theta_0(2p)$ for every $p$, and at $p=2$ that is $\sqrt3/2$. A wrong factor anywhere would break that identity.

## 4. The killer test. No spectrum found where the bound falls below $\theta$, and none exists

**Result: no violation, and the reason is that the chain in sections 1 to 3 is a proof.** Each step is an inequality in the safe direction on an object of fixed sign, so a violation would have to come from a false input, not from a bad spectrum. The three candidates for a false input are $T\ge0$ (immediate from $T=c^2$), hollowness (section 2), and L153's uniform marginal (Given 15, and independently confirmed below for coordinate configurations). I nonetheless computed both sides in closed form on the largest family where both are available.

**The test family.** By Given 9 and Given 11 a coordinate configuration is the generic exactly-computable case. Partition $\mathbb R^n=\bigoplus_{i=1}^k\mathbb R^p$, $n=kp$, and let $W$ be diagonal in the coordinate 2-planes with $\lambda=a$ on the $k\binom p2$ within-block planes and $\lambda=-\beta a$ on the $\binom k2p^2$ cross-block planes. Given 2 makes Ricci-flatness the vanishing of every row sum, $(p-1)a=(n-p)\beta a$, so

$$\beta=\frac{p-1}{(k-1)p}.$$

First Bianchi holds automatically, since every $\omega_\alpha$ is decomposable and Given 6 then gives $\mathrm{Alt}(W)=\tfrac16\sum\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$. Trace-freeness follows from the row sums. So every member is a genuine Ricci-flat algebraic Weyl tensor, and at $k=2$ it is the record's balanced product.

**The true $\theta$ on the family.** With $\omega_{ij}=e_i\wedge e_j=\varphi_{ij}$ a unit bivector, $[\varphi_{12},\varphi_{23}]=E_{13}-E_{31}=-\varphi_{13}$, so $c=\pm1$ on triangles $\{ij\},\{jk\},\{ik\}$ and $0$ otherwise, whence $T$ is the triangle indicator. Its marginal at $\{ij\}$ counts the $n-2$ choices of a third index twice, giving $2(n-2)$, an independent confirmation of L153 in this basis. Then

$$\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{i<j<k}\lambda_{ij}\lambda_{jk}\lambda_{ik},$$

the $3$ being $\tfrac12\cdot3!$ per unordered triangle.

**The bound on the family.** Only two eigenvalues occur, so $y(z)$ is the maximum of four affine functions of $z$, indexed by the number of within-block indices in the triple. In units $a=1$,

$$f_3=1-z,\qquad f_2=-\beta-\frac z3(2-\beta),\qquad f_1=\beta^2-\frac z3(1-2\beta),\qquad f_0=-\beta^3+z\beta.$$

$f_0$ increases always, $f_1$ increases exactly when $\beta>\tfrac12$, and $f_3,f_2$ decrease. For $k\ge3$ one has $\beta\le\frac{p-1}{2p}<\tfrac12$, so $f_0$ is the only increasing function and the minimax sits at $f_3=f_0$, that is at $z^\star=\frac{1+\beta^3}{1+\beta}=1-\beta+\beta^2$ with

$$y=\beta(1-\beta)\quad\text{in units }a^3,$$

and $f_3\ge f_1$ there because $z^\star\le\tfrac32(1-\beta)$ reduces to $(2\beta-1)(\beta+1)\le0$. For $k=2$ one has $\beta=(p-1)/p\ge\tfrac12$ and the binding pair is $f_3=f_1$ instead, which is section 7.

**The comparison.** Every value below is exact. The last column is the record's standing bound $(n-1)/\sqrt{n+1}$ of Given 18.

| $k\times p$ | $n$ | true $\theta$ | **dual bound** | $\theta_0(n)$ | standing bound |
|---|---|---|---|---|---|
| $2\times2$ | 4 | $\sqrt3/2=0.866025$ | $\sqrt3/2=0.866025$ | $0.866025$ | $1.3416$ |
| $2\times6$ | 12 | $\sqrt{55}/6=1.236033$ | $\sqrt{55}/6=1.236033$ | $1.236033$ | $3.0509$ |
| $2\times10$ | 20 | $1.307670$ | $1.307670$ | $1.307670$ | $4.3461$ |
| $3\times2$ | 6 | $\sqrt{165}/20=0.645497$ | $1.936492$ | $1.054093$ | $1.8898$ |
| $3\times4$ | **12** | $\sqrt{11}/4=0.829156$ | $5\sqrt{11}/12=1.381927$ | $1.236033$ | $3.0509$ |
| $4\times3$ | **12** | $\sqrt{33}/9=0.638285$ | $7\sqrt{33}/18=2.233997$ | $1.236033$ | $3.0509$ |
| $6\times2$ | **12** | $\sqrt{165}/30=0.428174$ | $3\sqrt{165}/10=3.853570$ | $1.236033$ | $3.0509$ |
| $4\times4$ | 16 | $0.684653$ | $2.053960$ | $1.280869$ | $3.6380$ |
| padded $W_{\mathbb{CP}^2}$ | 4 | $\sqrt{3/2}=1.224745$ | $5/\sqrt6=2.041241$ | $0.866025$ | $1.3416$ |
| padded $W_{\mathbb{CP}^2}$ | 12 | $\sqrt{3/2}=1.224745$ | $221/\sqrt6=90.2229$ | $1.236033$ | $3.0509$ |

**The bound is above the true value at every entry, with equality exactly on the $k=2$ row.** The three products of more than two spheres that the item asks for are the $k=3,4,6$ rows, and the bound is loose there by the exact factors $5/3$ at $3\times4$, $7/2$ at $4\times3$ and $9$ at $6\times2$. **No refutation.**

Screening note. Everything in the table was derived by hand as above. I then re-derived the same numbers with exact rational arithmetic, comparing squares of rationals so that no root is ever approximated, purely to screen the closed forms I was about to record. The screen agreed at every entry and at the further points $2\times p$ for $p\le10$ and $k\times2$ for $k\le50$. It is reported as a screen and none of the positive claims rest on it.

## 5. The $n=4$ witness, and what is wrong with the reading of it

The spectrum is $\lambda_+=1/\sqrt3$ twice and $\lambda_-=-1/(2\sqrt3)$ four times. Trace: $2/\sqrt3-4/(2\sqrt3)=0$. Norm: $2/3+4/12=1$. $\sum\lambda^3=2\cdot3^{-3/2}-4\cdot\frac1{8\cdot3\sqrt3}=\frac{2}{3\sqrt3}-\frac1{6\sqrt3}=\frac{4-1}{6\sqrt3}=\frac1{2\sqrt3}$. All **CORRECT**.

Write $a=\lambda_+$ so $\lambda_-=-a/2$ and $a^2=\tfrac13$. The four type functions at true $z$ are

$$f_3=a^3-za,\qquad f_2=-\frac{a^3}2-\frac{za}2,\qquad f_1=\frac{a^3}4,\qquad f_0=-\frac{a^3}8+\frac{za}2.$$

**$f_1$ is constant in $z$**, because the triple $(\lambda_+,\lambda_-,\lambda_-)$ has zero sum at $\beta=\tfrac12$. At $z=\tfrac14$: $f_3=\frac1{3\sqrt3}-\frac1{4\sqrt3}=\frac1{12\sqrt3}$, $f_1=\frac14\cdot\frac1{3\sqrt3}=\frac1{12\sqrt3}$, $f_0=-\frac1{24\sqrt3}+\frac1{8\sqrt3}=\frac1{12\sqrt3}$, and $f_2=-\frac1{6\sqrt3}-\frac1{8\sqrt3}=-\frac{7}{24\sqrt3}$. So $y=\frac1{12\sqrt3}=0.0481125$ and the bound is

$$\frac1{2\sqrt3}+2\cdot6\cdot\frac1{12\sqrt3}=\frac1{2\sqrt3}+\frac1{\sqrt3}=\frac3{2\sqrt3}=\frac{\sqrt3}2,$$

**exactly $\theta_0(4)$, not $0.8659$.** The record's four-figure value is right but understates its own result: the agreement is an identity.

**5b, the "three active functions" is misleading.** Three of the four functions do coincide at $z=\tfrac14$, namely $f_3$, $f_1$ and $f_0$, which are the record's all-within, mixed and all-cross. But **$f_3$ is not realisable at $n=4$**: it needs three distinct indices carrying $\lambda_+$ and only two exist, since the multiplicity of $\lambda_+$ is $p(p-1)=2$. So the all-within constraint is not part of the programme at $n=4$, and among the constraints that are, two are active and the two-within-one-cross function $f_2$ is inactive by a wide margin. The sentence "at $n=4$ all three of the all-within, mixed and all-cross functions are simultaneously active, which is what tightness looks like" should read: the mixed and all-cross constraints are active, the all-within function coincides with them but indexes no triple at this dimension. **The record's own Lean file, in the version this review first read, typed the unrealisable one and omitted the realisable mixed one**, and was corrected on disk mid-review. Section 11 carries the delta.

**5c, $y$ is optimal and $z$ is not.** Since $f_1$ is constant and equals $y$, no $z$ can push the maximum below $\frac1{12\sqrt3}$, so **$y$ cannot be lowered** and the witness is optimal. It is optimal on an interval: over the realisable types, $f_0\le f_1$ needs $z\le\tfrac14$ and $f_2\le f_1$ needs $z\ge-\tfrac12$, so **every $z\in[-\tfrac12,\tfrac14]$ is a minimiser** and the record's $z=\tfrac14$ is the right-hand endpoint. Including the unrealisable $f_3$ would force $z=\tfrac14$ uniquely, which is presumably why the record reports it as the witness. The value of the bound is unaffected either way.

## 6. The $n=12$ witness in exact arithmetic

Put $s=\sqrt{(p-1)(2p-1)}$ and $\kappa=(p-1)/p$, so at $p=6$, $s=\sqrt{55}$, $\kappa=\tfrac56$, $\lambda_+=1/\sqrt{55}$ with multiplicity $30$ and $\lambda_-=-5/(6\sqrt{55})$ with multiplicity $36$. Here $\kappa>\tfrac12$, so $f_1$ increases and the binding pair is $f_3=f_1$:

$$f_3-f_1=\frac{1-\kappa^2}{s^3}-\frac zs\cdot\frac{2+2\kappa}3=0\ \Longrightarrow\ z=\frac{3(1-\kappa)}{2s^2}=\frac{3}{2\cdot6\cdot55}=\frac1{220},$$

$$y=f_3=\frac1s\Big(\frac1{s^2}-z\Big)=\frac1{\sqrt{55}}\Big(\frac1{55}-\frac1{220}\Big)=\frac{3}{220\sqrt{55}}.$$

Feasibility at that $z$: $f_2<0<y$ outright, and $f_0=\frac\kappa s\big(z-\frac{\kappa^2}{s^2}\big)=\frac{5}{6\sqrt{55}}\big(\frac1{220}-\frac{25}{1980}\big)<0$. So $y=\frac3{220\sqrt{55}}=0.00183875$ and

$$\theta\ \le\ \frac1{6\sqrt{55}}+10\cdot66\cdot\frac3{220\sqrt{55}}=\frac1{6\sqrt{55}}+\frac9{\sqrt{55}}=\frac{55}{6\sqrt{55}}=\frac{\sqrt{55}}6=\theta_0(12).$$

**The agreement is EXACT, not approximate.** The record's "$1.2362$ against $1.236033$" is an artefact of rounding $y$ to four figures, and the true statement is an identity. **CORRECT, and understated.**

## 7. The general spectrum, and exactness identically in $p$

**The spectrum.** $\lambda_+=1/s$ with multiplicity $p(p-1)$ and $\lambda_-=-(p-1)/(ps)$ with multiplicity $p^2$, and $p(p-1)+p^2=p(2p-1)=\binom{2p}2=N$. Trace: $p(p-1)/s-p(p-1)/s=0$. Norm: $\frac{p(p-1)}{s^2}+\frac{(p-1)^2}{s^2}=\frac{(p-1)(2p-1)}{s^2}=1$. And $\sum_\alpha\lambda_\alpha^3=\frac{p(p-1)}{s^3}\big(1-\frac{(p-1)^2}{p^2}\big)=\frac{(p-1)(2p-1)}{ps^3}=\frac1{ps}$. All **CORRECT**, and this is the $k=2$ member of section 4's family.

**The minimax, for every $p\ge2$.** The section 6 computation is generic in $\kappa=(p-1)/p$:

$$z^\star=\frac{3(1-\kappa)}{2s^2}=\frac3{2ps^2},\qquad y=\frac1{s^3}\Big(1-\frac3{2p}\Big)=\frac{2p-3}{2ps^3}.$$

Feasibility: $f_2<0<y$ always, and $f_1>f_0$ at $z^\star$ whenever $(2p-1)(p-2)>0$, with equality exactly at $p=2$, which is why $f_0$ joins the active set at $n=4$. The minimum is genuine because $f_3$ decreases through $z^\star$ and $f_1$ increases out of it for $p>2$, and is constant and equal to $y$ at $p=2$.

**The bound collapses.** Using $(n-2)N=(2p-2)p(2p-1)=2ps^2$,

$$\sum_\alpha\lambda_\alpha^3+(n-2)Ny=\frac1{ps}+2ps^2\cdot\frac{2p-3}{2ps^3}=\frac{1+p(2p-3)}{ps}=\frac{(2p-1)(p-1)}{ps}=\frac sp,$$

and $\theta_0(2p)=\frac{\sqrt{2(2p-1)(2p-2)}}{2p}=\frac{2\sqrt{(p-1)(2p-1)}}{2p}=\frac sp$. **Identical for every $p$.**

**And the true $\theta$ is the same number.** From section 4's triangle formula with $k=2$, the triangle types are all-within, counted $2\binom p3$ at value $\lambda_+^3$, and one-within-two-cross, counted $2\binom p2p$ at value $\lambda_+\lambda_-^2$. Hence

$$\theta=\frac1{ps}+\frac{p(p-1)(p-2)+3(p-1)^3}{s^3}=\frac1{ps}+\frac{(p-1)(2p-1)(2p-3)}{s^3}=\frac1{ps}+\frac{2p-3}{s}=\frac sp.$$

So **the bound is exact at the balanced product for every $p\ge2$**, both sides equal to $\theta_0(2p)$, and the record's "checked at two dimensions" is weaker than what its own argument gives. This is the review's one upward correction. The Lean file already contains the algebraic half of it, section 11.

## 8. Tightness versus validity: the agreement is a certificate, not a coincidence

The item is right to separate the two, and here the stronger reading survives. At the balanced product the primal object $T$, the triangle indicator, is feasible for the relaxed programme

$$\max\ m_3\quad\text{over}\quad T\ge0,\ \text{totally symmetric},\ \text{hollow},\ \sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)\ \forall\alpha,$$

with value $m_3=2(2p-3)/s$ by section 7, and the dual pair $(y,z^\star)$ is feasible with value $2(n-2)Ny=2(2p-3)/s$. **Equal objectives on a feasible primal and a feasible dual certify both optimal.** So the balanced product's own $T$ really does maximise $m_3$ over all such arrays at its spectrum, and the record's dual choice really is optimal within the full dual, not merely within its two-parameter family.

Complementary slackness confirms it structurally. The active types at $z^\star$ are all-within and one-within-two-cross for $p\ge3$, plus all-cross at $p=2$. The triangle indicator is supported on index triples $\{ij\},\{jk\},\{ik\}$, whose three indices split across the two blocks either $3+0$, giving three within-planes, or $2+1$, giving one within-plane and two cross-planes. **Those are exactly the two active types, and no other type carries mass.** All-cross is tight at $p=2$ and unused, which slackness permits.

One caveat that section 10 then exploits. The record's ansatz $y+\tfrac z3\sum\lambda$ is the restriction of the full dual $u_\alpha+u_\beta+u_\gamma$ to $u_\alpha=\tfrac13(y+z\lambda_\alpha)$, affine in $\lambda_\alpha$. It happens to be optimal at the balanced product. It is not optimal in general, and where the reduction fails it fails for the full dual too.

## 9. $W_{\mathbb{CP}^2}$, and why $5/\sqrt6$ is not a defect

Spectrum $2c,-c,-c$ and zero elsewhere at $c=1/\sqrt6$. $\sum\lambda^3=8c^3-2c^3=6c^3=6/6^{3/2}=1/\sqrt6$. The type functions over triples of distinct indices are, with $g$ the constrained expression,

| triple | product | sum | $g(z)$ |
|---|---|---|---|
| $(2c,-c,-c)$ | $2c^3$ | $0$ | $2c^3$ |
| $(2c,-c,0)$ | $0$ | $c$ | $-zc/3$ |
| $(-c,-c,0)$ | $0$ | $-2c$ | $2zc/3$ |
| $(2c,0,0)$ | $0$ | $2c$ | $-2zc/3$ |
| $(-c,0,0)$ | $0$ | $-c$ | $zc/3$ |
| $(0,0,0)$ | $0$ | $0$ | $0$ |

The first row has **zero sum**, so no $z$ touches it, and $y\ge2c^3$ unconditionally. At $z=0$ every other row is $0\le2c^3$, so $y=2c^3=\frac1{3\sqrt6}$ exactly, on the interval $z\in[-\tfrac16,\tfrac16]$. Then at $n=4$

$$\theta\le\frac1{\sqrt6}+2\cdot6\cdot\frac1{3\sqrt6}=\frac1{\sqrt6}+\frac4{\sqrt6}=\frac5{\sqrt6}=2.041241,$$

**exactly the record's $5/\sqrt6$. CORRECT.** It is consistent: the true value is $\sqrt{3/2}=1.224745$, and a bound is not obliged to be tight away from the configuration it was tuned to. Note in passing that $5/\sqrt6=\tfrac53\sqrt{3/2}$, the same factor $\tfrac53$ that reappears at the $3\times4$ configuration in section 4.

What the record does not notice is what happens to this row at larger $n$, which is section 10.

## 10. The reduction claim is REFUTED

**First, the uncontroversial half.** The bound is a function of the spectrum alone, and its inputs, listed in the hypothesis inventory, are the objective identity, L153's marginal, $T\ge0$, hollowness, symmetry and $\mathop{\mathrm{tr}}W=0$. **Criticality is nowhere used, and neither is decomposability, so the bound does hold for every Ricci-flat unit-norm algebraic Weyl tensor**, not only the critical ones. It holds for still more: Ricci-flatness enters only through its trace, so any trace-free unit-norm symmetric $W$ for which Givens 14 and 15 hold is covered. The record's parenthetical that "a bound over all such tensors rather than the critical ones would settle the conjecture outright, uniqueness included through the equality analysis" is therefore the right shape of claim, and the equality analysis would owe two things: equality in the dual pairing, which by complementary slackness pins the support of $T$ to the active types, and then the step from that support to a geometric classification, which is where Given 9 and Given 10 would have to be brought back in. None of that is done, and it is not the reason the reduction fails.

**The reduction fails on the maximisation itself.** The record asks: "over spectra of a Ricci-flat unit-norm Weyl tensor at fixed $n$, is the dual bound at most $\theta_0(n)$ once $n\ge12$?" **The answer is no, decisively, at $n=12$.**

Take $k=6$, $p=2$, that is the coordinate-diagonal Ricci-flat Weyl tensor of the six-block partition $\mathbb R^{12}=\bigoplus_{i=1}^6\mathbb R^2$ of section 4. Then $\beta=\tfrac1{10}$, $\lVert W\rVert^2/a^2=6+\tfrac{60}{100}=\tfrac{33}5$ so $a^2=\tfrac5{33}$, $\sum\lambda^3=\tfrac{297}{50}a^3$, and $y=\beta(1-\beta)a^3=\tfrac9{100}a^3$ at $z=\tfrac{91}{100}a^2$. The bound is

$$\Big(\frac{297}{50}+10\cdot66\cdot\frac9{100}\Big)a^3=\frac{3267}{50}\Big(\frac5{33}\Big)^{3/2}=\frac{3\sqrt{165}}{10}=3.853570,$$

against $\theta_0(12)=\sqrt{55}/6=1.236033$. The tensor's own $\theta$ is $\sqrt{165}/30=0.428174$, exactly one ninth of its bound. **So the maximum over spectra at $n=12$ is at least $3.853570$, more than three times the target.** Two further points make it worse.

- **The bound is not a strengthening of the record's standing bound.** $3.853570>3.0509=(n-1)/\sqrt{n+1}$ at $n=12$, so at this spectrum the new bound is weaker than the one already on the record. The same holds at $n=8$ ($2.700>2.333$), $n=10$ ($3.320>2.714$), $n=16$ ($4.758>3.638$) and beyond. The two bounds are incomparable, and the "factor of $2.47$ away from target" framing does not survive: the dual bound beats $3.0509$ only on spectra near the balanced product.
- **No better dual can rescue it, because the relaxation itself is optimal there.** Exhibit a feasible primal at the same spectrum. Put $T=1$ on every triangle among the six within-block indices, which gives each of them marginal $5\cdot4=20=2(n-2)$, and $T=\tfrac{10}{1711}$ on every triple of distinct cross-block indices, which gives each of those marginal $59\cdot58\cdot\tfrac{10}{1711}=20$. This $T$ is nonnegative, symmetric, hollow and has the L153 marginal at every index, and its value is $m_3=\big(6\cdot5\cdot4\big)a^3+\big(60\cdot59\cdot58\big)\tfrac{10}{1711}\big(-\tfrac{a^3}{1000}\big)=\big(120-1.2\big)a^3=\tfrac{594}5a^3$, so $\sum\lambda^3+\tfrac12m_3=\big(\tfrac{297}{50}+\tfrac{297}5\big)a^3=\tfrac{3267}{50}a^3$, **equal to the dual value.** The pair certifies that the relaxed programme's optimum at this spectrum is exactly $3.853570$. The failure is therefore structural: it is the relaxation that is too generous, not the dual ansatz.

**And it gets unboundedly worse with $n$.** On the $p=2$ family, $\lVert W\rVert^2/a^2=M=\frac{k(2k-1)}{2(k-1)}$, $(n-2)Ny=M(2k-3)$ and $\sum\lambda^3=\big(k-\frac{k}{4(k-1)^2}\big)a^3$, so the bound is $\frac{\sum\lambda^3/a^3}{M^{3/2}}+\frac{2k-3}{M^{1/2}}\sim2\sqrt k=\sqrt{2n}$. Exactly: $0.866$ at $n=4$, $1.936$ at $n=6$, $3.854$ at $n=12$, $6.198$ at $n=24$, $13.788$ at $n=100$. Since $\theta_0(n)\uparrow\sqrt2$, **the maximum of the dual bound over spectra diverges while the target is bounded**, so the maximisation the record proposes to carry out has answer no at every $n\ge6$, not just at $n=12$.

Even the padded $W_{\mathbb{CP}^2}$ row of section 4 makes the point on its own without any new family: its $y=2c^3$ is forced by a zero-sum triple and cannot depend on $z$, so its bound is $\frac{1+(n-2)N/3\cdot 2}{\sqrt6}$, that is $\frac{221}{\sqrt6}=90.22$ at $n=12$. The record's crossover narrative reads that row at $n=4$ only, and concludes that "the maximisation must cross over from the competitor's value to $\theta_0(n)$ somewhere". **It does not cross over. It diverges.** The competitor's spectrum is punished harder, not less, as $n$ grows, because $(n-2)N$ grows like $n^3$ while its $y$ stays fixed.

**Diagnosis.** The relaxation keeps one scalar consequence of Ricci-flatness, the trace, and discards relations (B) and (C) of Given 12, which are the only inputs that tie $T$ to $\lambda$. Freed of them, $T$ may put its entire marginal budget on whichever triple type the spectrum likes best, and the primal above does exactly that. The balanced product is the one place where the geometry's own $T$ already does what the relaxation would do, which is why the bound is exact there and nowhere else. **Any repair has to reintroduce (B) or (C), or a cap tying the mass of $T$ on a triple to the eigenvalues, and that is a different programme from the one this item describes.** **VERDICT: the derivation stands, the reduction is REFUTED.**

## 11. The Lean file

**The file changed on disk during this review**, between my first read and the writing of this section, gaining a header paragraph that declares the all-within class empty at $p=2$ and a new theorem `dual_n4_mixed_active`. I audited both versions and report the current one, with the delta recorded at the end of this section.

[L203DualBound.lean](../lean/HamiltonsCubic/Results/L203DualBound.lean) builds clean, "Build completed successfully (3006 jobs)", against Mathlib v4.33.1 and Lean 4.33.1 as pinned in [lean-toolchain](../lean/lean-toolchain). Every one of the eight theorems depends on exactly `propext`, `Classical.choice`, `Quot.sound`, with **no gap axiom and no `sorry`**. Statement by statement:

| Theorem | Says | Assessment |
|---|---|---|
| `dual_n4_unit_norm` | $2\lambda_+^2+4\lambda_-^2=1$ | true, and matches the prose |
| `dual_n4_trace_free` | $2\lambda_++4\lambda_-=0$ | true, and matches |
| `dual_n4_bound_eq_theta0` | $2\lambda_+^3+4\lambda_-^3+12y=\sqrt3/2$ | true, and matches. The $12$ is $(n-2)N$ hard-coded |
| `dual_n4_within_active` | $\lambda_+^3-\tfrac z3(3\lambda_+)=y$ at $z=\tfrac14$ | true as arithmetic, at a class that indexes no triple at $n=4$, and the current docstring says so |
| `dual_n4_cross_active` | $\lambda_-^3-\tfrac z3(3\lambda_-)=y$ at $z=\tfrac14$ | true, and this class is realisable and binding |
| `dual_n4_mixed_active` | $\lambda_+\lambda_-^2=y$ | true, and it is section 5's $f_1$. Its $z$-freedom is right, since $\lambda_++2\lambda_-=0$ |
| `dual_balanced_collapses` | $\frac1{pD}+\frac{2p-3}D=\frac Dp$ given $D^2=(p-1)(2p-1)$ | true, and it is section 7's collapse |
| `theta0_eq_D_div_p` | $\frac{\sqrt{2(2p-1)(2p-2)}}{2p}=\frac Dp$ | true, and the instantiation of $\theta_0$ at $n=2p$ is right |

**What it does NOT type, in order of importance.**

1. **Dual feasibility, still.** The bound is worth nothing unless the constraint holds at *every* triple, and the file now types three of the four classes at $n=4$, all three as equalities. **The fourth, the two-within-one-cross function $f_2=-\tfrac7{24\sqrt3}$, appears nowhere**, so the file never types a single constraint as an inequality and therefore never certifies that the witness is dual-feasible. Feasibility at $n=4$ needs $f_2\le y$, which is section 5's computation and is prose here.
2. **The bound itself.** Nothing in the file says $\theta\le\ldots$ . `dual_n4_bound_eq_theta0` evaluates an expression, and the identification of that expression with $\sum\lambda^3+(n-2)Ny$ is prose, as is the $12$.
3. **The general-$p$ statements are identities in free symbols, not statements about the bound.** `dual_balanced_collapses` takes $p$ and $D$ as unrelated reals with $D\ne0$, $p\ne0$ and $D^2=(p-1)(2p-1)$, and proves an algebraic identity. That $\sum\lambda^3=\frac1{pD}$ and $(n-2)Ny=\frac{2p-3}D$ at the balanced product, which is the mathematical content of section 7, is nowhere typed. Nor is the general-$p$ spectrum's unit norm or trace-freeness, nor the minimax that produces $y$, nor the $p\ge3$ case where the binding pair is $f_3=f_1$ rather than $f_1=f_0$.
4. **The whole of sections 1 to 3.** L153's marginal, $T\ge0$, hollowness, the pairing, the $z$ cancellation and the objective identity are all prose. The header attributes the $z$ cancellation to trace-freeness alone, where section 1 shows it needs L153's marginal to be **constant in the index** as well.

**The delta.** The version I first read carried, on `dual_n4_within_active`, the docstring "the constraint is met with equality and the bound cannot be improved by lowering $y$ alone", and asserted in its header that the all-within and all-cross classes being active "is what makes the bound tight rather than merely valid". That was the defect this review's section 5b found: the all-within class is empty at $p=2$, so the conclusion was drawn from a vacuous constraint, and the one realisable class that carries it, $f_1$, was absent from the file. **The current version fixes exactly that**: the header declares the class empty and names the one-within-two-cross class as the binder, `dual_n4_mixed_active` types it, and the flat minimax interval $[-\tfrac12,\tfrac14]$ is recorded. I confirm the new theorem is true, that it is the right constraint, that the interval is right, and that the corrected file still builds on the three standard axioms. Point 1 above is what remains.

## 12. What would break it, and what I did to look

**Object sought first, per the brief: a spectrum of a Ricci-flat unit-norm Weyl tensor at which the claimed bound falls below the true $\theta$.** None exists, and the reason is structural rather than empirical: sections 1 to 3 are a proof, so a violation requires a false input. I therefore attacked the inputs and then verified both sides in closed form on the widest exactly-computable family.

- **The inputs.** $T\ge0$ is immediate from $T=c^2$. Hollowness and total symmetry follow from total antisymmetry of $c$, which I derived from ad-invariance of $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$ rather than assumed. **L153's uniform marginal is the single load-bearing external input**, and its uniformity, not merely its size, is what makes the $z$ term vanish. I re-derived it independently for coordinate configurations, where $T$ is the triangle indicator and the marginal counts $2(n-2)$ by hand. If L153 were ever weakened to an inequality, the two-parameter dual would collapse to $z=0$ and the $n=12$ exactness would be lost, so anyone touching L153 must be told this item depends on its equality form.
- **Both sides in closed form.** I built the $k$-block family of section 4, verified each member is Ricci-flat, first-Bianchi and trace-free from Givens 2 and 6, computed the true $\theta$ from Given 14 with the triangle $T$, and computed the bound from the four-function minimax. Comparison at $k=2$ with $p\le10$, at $k\le50$ with $p=2$, at $(3,3),(3,4),(3,5),(4,3),(4,4)$, and at padded $W_{\mathbb{CP}^2}$ for $n\in\{4,6,8,12,20\}$. **The bound is above the true value everywhere, with equality exactly on the balanced product, and the true $\theta$ of the balanced product came out at $\theta_0(2p)$ for every $p$, which independently validates the conventions, the factor $\tfrac12$ in Given 14 and the unit normalisation of $\varphi_{ab}$.**
- **The object that did break something.** Having failed to break the bound, I asked what the bound's own maximisation returns, and the answer refutes the reduction. The witnesses are the $6\times2$ and $3\times4$ configurations at $n=12$, and the asymptotic $\sqrt{2n}$ growth on the $p=2$ family. I then closed the escape route by exhibiting a matching feasible primal $T$ at the $6\times2$ spectrum, which shows the relaxation and not the ansatz is at fault.
- **What I did not do**, and would need approval for: any search over spectra, any vertex enumeration, any attempt to find the actual maximum of the dual bound at $n=12$. Every value above is a closed form derived by hand and re-derived once in exact rational arithmetic as a screen.

## Verdict

**The derivation is CORRECT and its exactness is stronger than claimed. The reduction it is offered for is REFUTED.**

- **Keep**, as an unconditional theorem: for every trace-free unit-norm $W$ satisfying Givens 14 and 15, and hence for every Ricci-flat unit-norm algebraic Weyl tensor, critical or not, $\theta\le\sum_\alpha\lambda_\alpha^3+(n-2)N\min_z\max\big[\lambda_\alpha\lambda_\beta\lambda_\gamma-\tfrac z3(\lambda_\alpha+\lambda_\beta+\lambda_\gamma)\big]$ over triples of distinct indices.
- **Strengthen**: the bound equals $\theta_0(2p)$ at the balanced product **identically in $p$**, not at two checked dimensions, with $z^\star=\frac3{2ps^2}$ and $y=\frac{2p-3}{2ps^3}$ at $s^2=(p-1)(2p-1)$, and the true $\theta$ there is the same $s/p$. Complementary slackness holds exactly, so the balanced product's own $T$ is optimal for the relaxed programme and the record's two-parameter dual is optimal within the full dual there.
- **Correct**: the $n=4$ and $n=12$ agreements are identities, not four-figure coincidences. At $n=4$ the all-within triple does not exist, the active realisable constraints are the mixed and the all-cross, the two-within-one-cross function is inactive at $-\frac7{24\sqrt3}$, and the minimising $z$ fills the interval $[-\tfrac12,\tfrac14]$.
- **Withdraw**: the claim that the conjecture reduces to maximising this bound over spectra, and the crossover narrative attached to it. At $n=12$ the maximum is at least $3\sqrt{165}/10=3.853570$, above $\theta_0(12)=1.236033$ and above the record's standing $3.0509$, witnessed by the six-block coordinate-diagonal Ricci-flat Weyl tensor, whose own $\theta$ is $\sqrt{165}/30$. The maximum grows like $\sqrt{2n}$, so it does not cross over to $\theta_0(n)$ at any $n$. A matching primal certificate shows the relaxation, rather than the choice of dual, is what fails, so relations (B) or (C) of Given 12 must come back before any maximisation over spectra can be worth attempting.
- **Lean**: builds clean on three standard axioms with no gap axiom, and every typed statement is true, in both the version first read and the corrected version now on disk. The correction landed mid-review and fixes what section 5b found, the empty all-within class standing in for the realisable one-within-two-cross class. What remains: the file types three constraints at $n=4$ and all three as equalities, so **dual feasibility is still not typed**, the missing fourth class being $f_2=-\tfrac7{24\sqrt3}$. Nor is the bound itself, nor the general-$p$ spectrum, the minimax, or the $p\ge3$ binding pair, `dual_balanced_collapses` being an algebraic identity in two free symbols.
