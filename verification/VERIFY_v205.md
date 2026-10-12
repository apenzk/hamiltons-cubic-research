# VERIFY_v205, Observation L22, the estimate Nienhaus's localization theorem needs

**Cold read of [BRIEF_L22.md](BRIEF_L22.md), sections A–D, against [route-a.md](../findings/route-a.md), [results.md](../results.md), [conventions.md](../findings/conventions.md) and [L22.lean](../lean/HamiltonsCubic/Results/L22.lean).** **No numerical work was done**: no script, no Sage, no Python, no numeric evaluation. Two stretches of closed-form arithmetic were carried out by hand as a screen on claims this report was about to record, they are labelled as screens at the point of use and are never offered as evidence for a positive claim. Log: [agent_logs/verify-L22-v205.log](../agent_logs/verify-L22-v205.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $f'(\varphi)=3\sin\varphi\,\tilde f(\varphi)$, $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$, so the estimate is $\gamma_{\max}(\alpha)<(3-5\alpha)/\sqrt3$ | CONFIRMED as an equivalence; $\tilde f$ IMPORTED, and $\varphi=\pi/6$ binding is an UNSTATED hypothesis |
| 2 | at $\alpha=\tfrac13$ the right side is $4/(3\sqrt3)$, borderline by construction | CONFIRMED exactly |
| 3 | the constant is forced larger above $n=11$ (crossover $n=6+2\sqrt7$) | CONFIRMED exactly, from [results.md](../results.md) line 705 |
| 4 | $\alpha=\tfrac{1-s^2}3+s^2c_-^2\mu_N$, hence $s^2\le6\varepsilon/(3-c_0^2)$ | CONFIRMED exactly, including the endpoint $\mu_N=-\tfrac16$ |
| 5 | the maximiser has $c_0=1$, $W_2$ **entirely** in $\ker F_u$ | ASSERTED, no argument on file, and the block's own sentence says the two effects "pull against each other" |
| 6 | $s^2=3\varepsilon$ an **equality** | CONFIRMED as an identity **given** $c_0=1$; it is not an optimisation, and all the weight is on row 5 |
| 7 | $M_{W_1}\Pi_{\ker}Q(W_1)=0$ makes the inner problem a hard-case trust-region problem, globally solvable | HYPOTHESES CHECKED and the import is ELIMINABLE, three lines suffice; but $M_{W_1}$ symmetric consumes total symmetry of $T$, cited nowhere here |
| 8 | $V(t)=\sqrt{5/6}$ for $t\le t^*$, $\tfrac5{16t}+\tfrac{2t}3$ for $t>t^*$; $t^*=\tfrac34\sqrt{5/6}=\sqrt{30}/8$ | CONFIRMED by independent derivation, and it reproduces all four of the record's exact values |
| 9 | $\alpha^*=32/141$, with $B=0$ and $A$ pinned at $\sqrt{5/6}$ above it | CONFIRMED exactly |
| 10 | the tangential meeting, $4ab=\tfrac56$ | CONFIRMED exactly |
| 11 | "the frontier is exact, not estimated" | OVERREACH, an upper bound is what is established, and an upper bound is all the estimate needs |
| 12 | $\lambda=\sup T(W_1,K,K)=2/3$ | NO ARGUMENT ON FILE, measured, no closed form, load-bearing in $V$, $t^*$ and $\alpha^*$ alike |
| 13 | the two branches cover complementary intervals at **every** $n\ge12$ | GAP, the frontier half is a closed-form theorem given the constant; the Nienhaus half has three numbers, an asserted monotonicity and no closed form |
| 14 | the worst margin $+0.0074$ at $\alpha\approx0.223$ | the prior audit's inconsistency finding is WITHDRAWN, the two readings are not separable, and the slack reading makes the figures agree |
| 15 | $n=20,24$ "checked by zero-padding, which gives monotonicity in $n$ as a lower bound" | BROKEN as written, padding re-reports the $n=12$ datum, and the caveat attaches to the wrong quantity |
| 16 | both branches take the sphere-product value as their constant | CONFIRMED, and the quantity it stands in for is identified below |
| 17 | the result is a theorem / conditional / an assumption of the conclusion | SPLIT, conditional on the frontier branch, an assumption of the conclusion on the Nienhaus branch |
| 18 | the three copies of the claim | DISCREPANCY, copy A states it unconditionally and universally |
| 19 | "[Lemma L20](../findings/route-a.md) and the tube argument both consume this block" (the brief's own premise) | REFUTED by the record, in four places |

**One line.** The displayed algebra is exact and I re-derived every constant in it from scratch, including two the record never displays; what the block does not have is an argument for its constant, for $\lambda=2/3$, for $c_0=1$, or for Nienhaus's branch reaching $\alpha^*$ at every $n$, and on the Nienhaus branch the constant is Conjecture A's cap itself, so the assembled statement assumes the conclusion this programme exists to prove.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), never restated.

- *"$u=W_{\mathbb{CP}^2}$ padded to unit norm, $\theta^*=P(u)=\sqrt{3/2}$, $F_u(h)=\tfrac12(uh+hu)+u\#h$, and $F_\lambda$ its restriction to the multiplicity space $M_\lambda$"*.
- *"**$\alpha$ in [L21](route-a.md) and [L20](route-a.md) is $\sqrt{2/3}\langle F_uV,V\rangle$**, a Rayleigh quotient transverse to $\mathbb Ru$ and the orbit, not the $\alpha$ parametrising the competitor family $W_{\mathcal S^4(\alpha)}$ in the same file."*
- *"$\theta_0(n)$ | **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** ... **The gloss 'the value at the balanced sphere product' stood here until 2026-09-04 and is what regrew [L0](problem.md)'s refuted constant**; the target of Problem P is $\Theta_n$."*
- *"$M(n)$ | **the global maximum** of $P$ on the unit sphere of $\mathcal W_n$ ... Distinct from $\Theta_n$, which is the *diagonal* maximum: $\Theta_n\le M(n)$"*.
- *"$T$, third sense | **the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$** ... **It was tabled nowhere while the letter already carried the bracket tensor $T_{\alpha\beta\gamma}$**"*.
- *"**$m$ carries two objects inside [route-a.md](route-a.md), forty-seven lines apart**: the complementary dimension $n-4$ in the $SO(m)$-branching, and $\sqrt{2/3}\max P$ (the attained maximum), in the tube proof's own bootstrap."*

$\gamma=\sqrt{2/3}P(W)$ and $\alpha=\sqrt{2/3}\langle F_uW,W\rangle$ are stated in the block itself and are consistent with the conventions row for $\alpha$. Note $\sqrt{2/3}=1/\theta^*$, so $\gamma$ is $P$ measured in units of the competitor's own value.

## 1. Hypothesis inventory

**A pass with no inventory is not a pass. Eleven hypotheses carry this block; four are stated in it, five are used without being stated, one is stated and not used, and one is imported.**

| # | hypothesis | where it enters | status in the block |
| --- | --- | --- | --- |
| H1 | $f'(\varphi)=3\sin\varphi\,\tilde f(\varphi)$ with $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$ | the reduction to $\gamma<(3-5\alpha)/\sqrt3$ | stated, **imported** from Nienhaus's Theorem 4.17, not derived anywhere on the record |
| H2 | $\varphi=\pi/6$ is the binding angle | the same reduction | **never stated**, the block reads $\tilde f$ at one point and calls the result "exactly" the required estimate |
| H3 | $(\mathbb Ru\oplus T_u\mathcal O)^\perp=V_{1/3}\oplus V_{\le0}$, with $\tfrac13$ the top eigenvalue there; $\mathrm{mult}(+1)=1$, $\mathrm{mult}(+\tfrac12)=\dim\mathcal O$ | the subdivision, hence every later step | **never stated in the L22 block**, it is [Lemma L21](../findings/route-a.md) / Nienhaus 4.14(a),(b), which [results.md](../results.md) line 232 records as *"conditional on one input nothing on the record proves"* |
| H4 | $T$ totally symmetric | $M_{W_1}$ symmetric (so the trust-region characterisation applies at all), and the polarisation of $P(\cos\beta W_1+\sin\beta W_2)$ | **never stated here**; [conventions.md](../findings/conventions.md) records that this symmetry *"was tabled nowhere"*, and [L101](../findings/route-a.md)'s audit records it as *"load-bearing twice lower down and cited at neither place"* |
| H5 | $P\equiv0$ on $V_{1/3}$, i.e. $T(W_1,W_1',W_1'')\le8\times10^{-16}$ | kills the $\cos^3\beta$ term of $P(W)$ | **never stated here**; measured at $n=10$ over a basis |
| H6 | $T(W_1,W_1,N)=0$ and $T(W_1,K,N)=0$ for $N$ in the strictly negative part | reduces the couplings to the kernel component, which is what makes $c_0$ the only competition | **never stated here**; measured at $n=10$ |
| H7 | $M_{W_1}\cdot\Pi_{\ker}Q(W_1)=0$ for every $W_1\in V_{1/3}$ | the hard case, hence $V(t)$, hence $t^*$ and $\alpha^*$ | stated; this is [Observation L102](../findings/route-a.md), *"verified numerically at $n=12,14,16$ and not proven"*, on 40 random draws at $n=12$ and fewer above |
| H8 | $a=\sup\lVert\Pi_{\ker}Q(W_1)\rVert=\sqrt{5/6}$ | the value of $V$ and the location of $t^*$ | stated as a constant; [L101](../findings/route-a.md)'s audit gives it a closed form, $\sqrt{1-\theta^{*2}/9}$, **modulo H5 and H6** |
| H9 | $\lambda=\sup_{W_1}\lambda_{\max}(M_{W_1})=2/3$ | the value of $V$, $t^*$ and $\alpha^*$ | stated as a constant, **with no closed form and no derivation anywhere on the record**, and [L101](../findings/route-a.md)'s audit says in terms that *"'exhaustively verified' licenses the vanishings and not the suprema"* |
| H10 | both suprema are attained at the same $W_1^\ast$ | claimed for the closed form | **stated and not used**, see §5.3; it is needed only for sharpness, not for the inequality |
| H11 | $\sup\{P(K):K\in\ker F_u,\ \lVert K\rVert=1\}\le\theta_0(n)$, and Nienhaus's own cap $\max P\le\theta_0(n)$ | the third term of $\gamma_{\text{coupled}}$; and, per the record, Nienhaus's branch entire | this is what "the sphere-product value as their constant" means, §7 |

## 2. The reduction, derived

The block writes $f'(\varphi)=3\sin\varphi\cdot\tilde f(\varphi)$ with $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$. Neither $f$ nor $\tilde f$ is defined anywhere in [findings/](../findings/); both come from Nienhaus's Theorem 4.17, which is not on file. **What can be checked is the passage from that display to the stated estimate, and it is exact.**

At $\varphi=\pi/6$: $\sin(\pi/6)=\tfrac12>0$, so

$$f'(\pi/6)=3\cdot\tfrac12\cdot\frac{5\alpha+\sqrt3\gamma-3}{4}=\frac{3(5\alpha+\sqrt3\gamma-3)}{8},$$

and $f'(\pi/6)<0\iff5\alpha+\sqrt3\gamma-3<0\iff\gamma<\dfrac{3-5\alpha}{\sqrt3}$. Taking the supremum over admissible $W$ at fixed $\alpha$ turns this into $\gamma_{\max}(\alpha)<(3-5\alpha)/\sqrt3$. **The equivalence is exact, the strictness is preserved, and the sign of $\sin(\pi/6)$ is what carries it.**

**Two things the passage does not establish.**

- **H2, and it is a genuine hole.** The requirement on $f$ is presumably a sign condition on an interval of $\varphi$, and the factorisation $f'=3\sin\varphi\,\tilde f$ makes $f'(0)=0$ regardless of $\tilde f$. Reading $\tilde f$ at the single point $\pi/6$ gives the required estimate **only if $\pi/6$ is where $\tilde f$ is largest**, or if the theorem needs $\varphi=\pi/6$ alone. The block says "the estimate required is exactly" without saying which. A reader cannot close this from the record.
- **$\gamma_{\max}(\alpha)$ is a supremum over a set the block never names.** It is presumably $\{W\in(\mathbb Ru\oplus T_u\mathcal O)^\perp:\lVert W\rVert=1,\ \sqrt{2/3}\langle F_uW,W\rangle=\alpha\}$; every later step reads it that way, and the block's own subdivision confirms it. Recorded as a notational debt rather than a defect.

### 2.1 The value at $\alpha=\tfrac13$, and the crossover

$$\frac{3-5\cdot\frac13}{\sqrt3}=\frac{3-\frac53}{\sqrt3}=\frac{4/3}{\sqrt3}=\frac4{3\sqrt3}=0.7698003589\ldots$$

**CONFIRMED**, and it matches the $0.769800$ that [route-a.md](../findings/route-a.md) prints in the earlier copy of the same reduction.

The claim that this is "borderline by construction, so the larger constant forced above $n=11$ breaks it" turns on where the constant first exceeds $\theta^*$. From [results.md](../results.md) line 705, *"$\theta_0(n)>\theta^*$ exactly when $n>6+2\sqrt7$"*. Deriving it: $\theta_0(n)^2>\theta^{*2}\iff2(n-1)(n-2)/n^2>3/2\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.29150\ldots$ **CONFIRMED exactly.** At $n=11$, $n^2-12n+8=-3<0$; at $n=12$, $=+8>0$. So $n=12$ is the first integer past the crossover, which is why the block's range starts there, and the margin at the boundary is $8$ out of $144$, small but strictly positive, so the boundary case is clean.

**The odd-$n$ boundary is not clean in the block's own language.** The block says "the sphere-product value". [conventions.md](../findings/conventions.md) is explicit that this gloss *"is what regrew [L0](../findings/problem.md)'s refuted constant"* and that at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$. So at odd $n\ge13$ (inside the block's claimed range), "the sphere-product value" and $\theta_0(n)$ are two different numbers, and the block's own formula uses $\theta_0(n)$. **Arguing the opposite, as the protocol requires:** the substitution is conservative in both directions, since $\theta_0(n)\ge\Theta_n$ makes the frontier bound larger and Nienhaus's reach smaller. **So the defect is descriptive rather than arithmetical, and it is recorded as a wording defect on a phrase the conventions file has already had to repair once.** [Lemma L20](../findings/route-a.md) carries the correction the block does not: *"Its witness is 'the balanced sphere product with $P=\theta_0(n)$', which does not exist at odd $n$ ... the claim survives ... with $\Theta_n$ in place of $\theta_0(n)$."*

## 3. "The configuration is forced", an equality resting on an assertion

### 3.1 The $\alpha$-identity and the inequality it yields, derived

Write $W=\cos\beta\,W_1+\sin\beta\,W_2$, $s=\sin\beta$, $W_1\in V_{1/3}$, $W_2=c_0K+c_-N$ with $K\in\ker F_u$, $N$ in the strictly negative part, $c_0^2+c_-^2=1$, and $\mu_N=\langle F_uN,N\rangle/\theta^*\in[-1,-\tfrac16]$. The cross term vanishes because $F_uW_1=\tfrac13\theta^*W_1$ and $W_1\perp W_2$, so

$$\alpha=\tfrac{1-s^2}3+s^2c_-^2\mu_N,\qquad\varepsilon:=\tfrac13-\alpha=s^2\Big(\tfrac13-c_-^2\mu_N\Big).$$

Put $D:=\tfrac13-c_-^2\mu_N$. Since $\mu_N\le-\tfrac16$ and $c_-^2\ge0$, $D\ge\tfrac13$, so $s^2=\varepsilon/D\le3\varepsilon$, **with equality precisely when $c_-^2\mu_N=0$, i.e. $c_-=0$, i.e. $c_0=1$.** And $D$ is minimised over $\mu_N\in[-1,-\tfrac16]$ at $\mu_N=-\tfrac16$, giving $D=\tfrac13+\tfrac{c_-^2}6=\tfrac{3-c_0^2}6$ and hence $s^2\le6\varepsilon/(3-c_0^2)$. **The record's displayed bound is CONFIRMED exactly, and it reduces to $s^2\le3\varepsilon$ at $c_0=1$.**

### 3.2 The equality claim, weighed

**The brief asks whether the argument supports an equality or an inequality. The answer is that it supports both, and which one you get is decided entirely by $c_0=1$, which is asserted.**

- Given $c_0=1$, the $\alpha$-identity collapses to $\alpha=(1-s^2)/3$, so $s^2=1-3\alpha=3\varepsilon$ **identically**. It is not an optimisation over $s$ and it is not an endpoint of a range; it is forced. **CONFIRMED, conditionally.**
- Without $c_0=1$, only $s^2\le3\varepsilon$ is available, and every downstream number changes: $t=s/\cos\beta$ shrinks, so the $t\le t^*$ regime enlarges and $\alpha^*$ moves down. The direction is favourable, but the block's closed form is written at the equality and nowhere else.

**Is $c_0=1$ derived? No.** The record's sentence is *"Its maximiser is always $c_0=1$"*, with no argument attached, in both copies. The block immediately before it says the two effects *"pull against each other"* ($c_0$ near $1$ permits the largest $s$ while the leading coupling carries a factor $c_0$) which is a statement that the optimisation is **not** trivially monotone. And the competition is real: $\sup T(W_1,N,N)=\sqrt{2/3}=0.8165$ exceeds $\sup T(W_1,K,K)=2/3$, so the $c_-^2$ route into the middle term carries a **larger** constant than the $c_0^2$ route. **The block therefore asserts the outcome of a genuine two-parameter optimisation, states no first-order condition, exhibits no maximiser, and displays only the $c_0=1$ formula. Verdict: ASSERTED.**

**Discrepancy protocol on this one.** *Located*: [route-a.md](../findings/route-a.md) line 486 and again at line 544, both reading "the maximiser has $W_2$ lying entirely in $\ker F_u$" with no supporting step. *Exhibited*: the objection is exhibited in closed form as the constant comparison $\sqrt{2/3}>2/3$ on the $c_-^2$ channel of $T(W_1,W_2,W_2)$, which is exactly the term a monotonicity argument in $c_0$ would have to dominate. *Argued the opposite*: the missing argument may well be routine, the leading term is $O(s)$ while the $c_-$ channels enter at $O(s^2)$ and $O(s^3)$, and near $\alpha=\tfrac13$ (where the estimate is needed) $s$ is small, so the linear-in-$s$ term should dominate and $c_0=1$ should win there. **That plausibility is why this is recorded as an assertion with an argument owed rather than as a defect: the claim is probably true and is certainly not proved.**

## 4. The trust-region reduction, and its import

### 4.1 What the inner problem is

Collecting the two coupled terms of $P(W)$ under the polarisation of the totally symmetric $T$ (H4), with $c=\cos\beta$ and $t=s/c$:

$$3c^2s\,T(W_1,W_1,K)+3cs^2\,T(W_1,K,K)=3c^2s\big[\langle\Pi_{\ker}Q(W_1),K\rangle+t\,\langle M_{W_1}K,K\rangle\big],$$

so the inner problem is $V(t)=\max\{\langle q,K\rangle+t\langle M_{W_1}K,K\rangle:\lVert K\rVert=1\}$ with $q=\Pi_{\ker}Q(W_1)$ and $M_{W_1}$ the symmetric operator representing $K\mapsto T(W_1,K,K)$ on $\ker F_u$. **This identification is not displayed in the block; it is the only reading under which every one of the block's numbers comes out right, so it is the reading adopted here.**

### 4.2 Checking the import against the object

**The trap named in the brief is an imported theorem whose hypotheses were never checked, and the trust-region result is exactly such an import. Checked, item by item.**

| hypothesis of the standard trust-region characterisation | holds here? |
| --- | --- |
| finite-dimensional real inner-product space | **yes**, $\ker F_u\subseteq\mathcal W_n$, $\dim\mathcal W_n=1638$ at $n=12$ |
| the quadratic's operator is symmetric | **yes, via H4**, $\langle M_{W_1}K,K'\rangle=T(W_1,K,K')$ is symmetric in $K,K'$ because $T$ is totally symmetric. **This is the one hypothesis that could have failed the way the unital-algebra import failed, and it does not.** It is also cited nowhere in the block |
| the feasible set is a ball $\lVert x\rVert\le\Delta$ | **the block's set is the sphere** $\lVert K\rVert=1$. Harmless: the objective has a positive linear part, so its maximum over the ball is attained on the boundary |
| the "hard case": the linear term is orthogonal to the extreme eigenspace | **yes, and strictly more than needed.** The hard case asks $q\perp$ the top eigenspace of $M_{W_1}$; H7 gives $M_{W_1}q=0$, and since $M_{W_1}$ is symmetric with $\lambda_{\max}=2/3>0$, $q\in\ker M_{W_1}$ is automatically orthogonal to the top eigenspace |

**And the import is eliminable.** With $\hat q=q/\lVert q\rVert$ and $M\hat q=0$, decompose $K=x\hat q+w$, $w\perp\hat q$, $x^2+\lVert w\rVert^2=1$. Then $\langle MK,K\rangle=x^2\langle M\hat q,\hat q\rangle+2x\langle M\hat q,w\rangle+\langle Mw,w\rangle=\langle Mw,w\rangle$, both cross terms dying on $M\hat q=0$. Hence, with $a=\lVert q\rVert$ and $\lambda=\lambda_{\max}(M)$,

$$\langle q,K\rangle+t\langle MK,K\rangle=ax+t\langle Mw,w\rangle\le ax+t\lambda(1-x^2),$$

and the bound is attained, since a top eigenvector lies in $(\ker M)^\perp\subseteq\hat q^\perp$. The right side is concave in $x$ with stationary point $x_\ast=a/(2t\lambda)$; the maximum over $x\in[-1,1]$ is at $x_\ast$ when $x_\ast\le1$ and at $x=1$ otherwise. **Three lines, no imported theorem.** So the reduction stands, and the import is decoration rather than a load-bearing citation. **This is a clean negative on the brief's most dangerous trap.**

### 4.3 $V(t)$, $t^*$, and the four values the record prints

From §4.2, $x_\ast\le1\iff t\ge a/(2\lambda)$, so

$$V(t)=\begin{cases}a,&t\le a/(2\lambda)\\[2pt]\dfrac{a^2}{4t\lambda}+t\lambda,&t>a/(2\lambda).\end{cases}$$

With $a=\sqrt{5/6}$ (H8) and $\lambda=2/3$ (H9): $t\lambda=2t/3$ ✓; $a^2/(4t\lambda)=(5/6)/(8t/3)=5/(16t)$ ✓; and $t^*=a/(2\lambda)=\sqrt{5/6}/(4/3)=\tfrac34\sqrt{5/6}=\tfrac34\cdot\tfrac{\sqrt{30}}6=\dfrac{\sqrt{30}}8$ ✓. **$V(t)$ and $t^*$ CONFIRMED by independent derivation.**

**The block's four printed values fall out of the same formula**, and reproducing them is the strongest single confirmation that this reading of the inner problem is the intended one. At $t=3/4$: $x_\ast=\sqrt{5/6}/(2\cdot\tfrac34\cdot\tfrac23)=\sqrt{5/6}$, so $A=ax_\ast=5/6$ ✓ and $B=\lambda(1-x_\ast^2)=\tfrac23\cdot\tfrac16=\tfrac19$ ✓. At $t=9/10$: $x_\ast=\sqrt{5/6}/(6/5)$, $A=ax_\ast=\tfrac56\cdot\tfrac56=\tfrac{25}{36}$ ✓, $B=\tfrac23(1-\tfrac{25}{36}\cdot\tfrac65)$, computing, $x_\ast^2=(5/6)(25/36)=125/216$, $B=\tfrac23\cdot\tfrac{91}{216}=\tfrac{91}{324}=0.2808641\ldots$ ✓ against the printed $0.280864$. **All four exact, by hand, in closed form.**

**A symbol collision inside the block, from this.** $A$ and $B$ are used both as the *suprema* $\sqrt{5/6}$ and $2/3$ and as the *values at the optimum* $5/6$ and $1/9$. Two senses, six lines apart, in a block whose file already carries [conventions.md](../findings/conventions.md)'s warning that the letter $B$ carries four objects on this record and $A$ two. Neither of L22's is tabled.

### 4.4 The tangency, and the "exact, not estimated" overreach

$a/t+bt$ with $a=\tfrac5{16},b=\tfrac23$ minimises at $t^2=a/b=\tfrac{15}{32}$; $(\sqrt{30}/8)^2=30/64=15/32$ ✓; minimum value $2\sqrt{ab}$, squared $4ab=4\cdot\tfrac5{16}\cdot\tfrac23=\tfrac56$ ✓, matching $(\sqrt{5/6})^2$. **CONFIRMED exactly**, and this is the whole of what [L22.lean](../lean/HamiltonsCubic/Results/L22.lean) machine-checks. Continuity at $t^*$ follows: $5/(16t^*)=\sqrt{30}/12$ and $2t^*/3=\sqrt{30}/12$, summing to $\sqrt{30}/6=\sqrt{5/6}$ ✓. The two branches meet at a value with zero slope, so $V$ is $C^1$ at $t^*$, which is why the boundary $t=t^*$, one of the boundaries the brief asks about, is clean rather than a source of a jump.

**Row 11 of the table: "the frontier is exact, not estimated" is an overreach, and the correct statement is stronger for the record's purposes than the one it makes.** $V$ is computed from the *suprema* $a\le\sqrt{5/6}$ and $\lambda\le2/3$, not from the values at a particular $W_1$. So what is established is $\sup_{W_1}V(a(W_1),\lambda(W_1),t)\le V(\sqrt{5/6},2/3,t)$, an **upper bound**. Equality needs H10, that the two suprema are co-attained, for which no $W_1^\ast$ is exhibited, and [route-a.md](../findings/route-a.md) line 201 records that *"no $\tfrac13$-eigenvector is exhibited anywhere on the record"*, so no witness exists to exhibit one. **But H10 is not needed**: monotonicity alone gives the upper bound, and an upper bound on $\gamma_{\max}$ is exactly what the estimate $\gamma_{\max}<(3-5\alpha)/\sqrt3$ requires. So H10 is **a hypothesis stated and never used**, the named trap, hit, with a benign consequence. The wording "exact, not estimated" should read "an upper bound, and that is what is needed".

**Monotonicity, checked, since the upper bound now rests on it alone.** In $a$: both branches increase. In $\lambda$: the first branch is constant, and on the second, $\partial_\lambda(a^2/(4t\lambda)+t\lambda)=t-a^2/(4t\lambda^2)>0\iff t>a/(2\lambda)$, which is exactly that branch's domain. Raising $\lambda$ also lowers $a/(2\lambda)$, moving points from the constant branch onto the second at a value $\ge a$. **So $V$ is nondecreasing in both. CONFIRMED.**

### 4.5 $\alpha^*=32/141$, derived

$B=0$ exactly on the constant branch, where $K^\ast=\hat q$ and $\langle M\hat q,\hat q\rangle=0$. So $B=0\iff t\le t^*\iff s^2/c^2\le15/32\iff32s^2\le15(1-s^2)\iff s^2\le15/47$. With $s^2=3\varepsilon=1-3\alpha$ (§3.1, given $c_0=1$):

$$1-3\alpha\le\tfrac{15}{47}\iff3\alpha\ge\tfrac{32}{47}\iff\alpha\ge\frac{32}{141}=0.2269503546\ldots$$

**$\alpha^*=32/141$ CONFIRMED exactly, and it is a consequence of H9's $\lambda=2/3$ and H8's $a=\sqrt{5/6}$ jointly**, a different $\lambda$ moves $t^*$ and moves $\alpha^*$ with it. That is worth stating because $\lambda=2/3$ is the one constant in the block with no derivation of any kind.

## 5. The constant, and what it stands in for

### 5.1 Exactly which quantity the sphere-product value replaces

**Derived, from the block's own closed form.** With $c_0=1$, $s^2=3\varepsilon$, $c^2=1-3\varepsilon$, and $P\equiv0$ on $V_{1/3}$ (H5), the polarisation of the cubic gives

$$P(W)=3c^2s\,T(W_1,W_1,K)+3cs^2\,T(W_1,K,K)+s^3P(K),$$

and $\gamma=\sqrt{2/3}P(W)$. Term by term against the record's display $\gamma_{\text{coupled}}=\sqrt{\tfrac23}[3(1-3\varepsilon)\sqrt{3\varepsilon}\sqrt{\tfrac56}+2(1-3\varepsilon)^{1/2}(3\varepsilon)+(3\varepsilon)^{3/2}\theta_0(n)]$:

- $3c^2s\cdot\sqrt{5/6}=3(1-3\varepsilon)\sqrt{3\varepsilon}\sqrt{5/6}$ ✓, so slot one is $\sup T(W_1,W_1,K)$;
- $3cs^2\cdot\tfrac23=2(1-3\varepsilon)^{1/2}(3\varepsilon)$ ✓, so slot two is $\sup T(W_1,K,K)$;
- $s^3\cdot\theta_0(n)=(3\varepsilon)^{3/2}\theta_0(n)$ ✓, **so slot three is $\sup\{P(K):K\in\ker F_u,\lVert K\rVert=1\}$, and $\theta_0(n)$ is standing in for it.**

**Answer to the brief's first question: on the frontier branch, the sphere-product value stands in for the maximum of the cubic form $P$ over the unit sphere of $\ker F_u$, a proper subspace of $\mathcal W_n$, at the single competitor $u$.**

### 5.2 What weaker statement would suffice

Three, in increasing weakness.

1. **Conjecture A's upper bound, $M(n)\le\theta_0(n)$.** This is what substituting $\theta_0(n)$ literally assumes if one reasons through the ambient sphere. It is the programme's goal.
2. **The subspace restriction, $\sup\{P(K):K\in\ker F_u,\lVert K\rVert=1\}\le\theta_0(n)$.** Strictly weaker: $\ker F_u$ is a proper subspace, and a bound on it does not return a bound on $\mathcal W_n$. **This is the statement the frontier branch actually needs**, and naming it is the single most useful thing this report can hand the record, because the record nowhere states it, it says only "conditional on Conjecture A".
3. **A slack-tolerant version of (2).** The estimate does not need $\theta_0(n)$; it needs any constant small enough that the branch inequality still closes. **Hand screen, reported as a screen and not as evidence:** rewriting the frontier bound in closed form (§6.1) as $\gamma=\sqrt5\,\sigma-(\sqrt5-\sqrt{2/3}\,c)\sigma^3$ with $\sigma^2=1-3\alpha$ and $c$ the constant, and evaluating at $\sigma^2=45/141$ (that is, $\alpha=\alpha^\ast$, the binding end of the branch) with $c=\sqrt2$ (the $n\to\infty$ value of $\theta_0$), the slack against the requirement is about $0.0086$ while the coefficient multiplying $c$ is about $0.147$. **So the constant could be about $4\%$ larger than $\sqrt2$ before the branch fails.** The hypothesis is therefore load-bearing to within a few per cent, it is not a formality that a crude a priori bound would discharge.

**And the record already owns the non-circular technique it declines to use here.** [Lemma L20](../findings/route-a.md)'s annotation: *"The self-bootstrap $\gamma_V\le m$ is not circular: $m$ is the attained maximum, no value is assumed, and it is exactly what replaces Nienhaus's conclusion-presupposing cap."* [conventions.md](../findings/conventions.md) records that this $m$ is $\sqrt{2/3}\max P$. **L22's slot three is precisely where that substitution would go, and L22 puts $\theta_0(n)$ there instead.** Naming this is not supplying an argument, whether the bootstrap closes with $m$ in place of $\theta_0(n)$ is unknown and this report does not claim it does.

### 5.3 Theorem, conditional statement, or assumption of the conclusion

**The brief is right that these are three different things, and the honest answer is that the block is two different things on its two branches.**

| branch | interval | what the constant does there | classification |
| --- | --- | --- | --- |
| the frontier bound | $\alpha\ge\alpha^\ast=32/141$ | caps $P$ on the unit sphere of $\ker F_u$ | **conditional**, on a hypothesis (5.2 item 2) strictly weaker than Conjecture A, which a reader could in principle discharge independently, and which no argument on the record discharges |
| Nienhaus's own bound | $\alpha\le N(n)$ | per the record, an a priori cap $\max P\le\theta_0(n)$ on the whole sphere | **an assumption of the conclusion.** [route-a.md](../findings/route-a.md) calls this cap *"conclusion-presupposing"* in its own words, at L20, and says L20 exists partly to avoid it |

**So the assembled two-branch statement is an assumption of the conclusion, because a disjunction is only as clean as its worse half.** As a repair of Nienhaus's Theorem 4.17 *for a reader who already has Conjecture A by other means*, it is a genuine conditional theorem modulo H1–H10. As a step toward Conjecture A inside this programme, it is circular.

**One limit on this finding, stated because the protocol requires arguing the opposite.** Nienhaus's Theorem 4.17 is not on file. That his branch uses the cap as an a priori bound on $\max P$ is read from the record's three descriptions of it, *"both branches take the sphere-product value as their constant"*, *"both branches remain conditional on Conjecture A's sharp constant $c_n$"*, and L20's *"Nienhaus's conclusion-presupposing cap"*. **I checked the record's description; I could not check the import.** If his branch instead uses the constant only as a normalisation, the classification of that half would change and the whole would drop to "conditional". The record as it stands does not permit that reading.

## 6. The two branches, and whether they cover

### 6.1 The frontier branch is a closed-form theorem given the constant, and the record presents it as extrapolated numerics

On $\alpha\ge\alpha^\ast$ the inner maximisation sits on the constant branch, so $B=0$ and the middle term of $\gamma_{\text{coupled}}$ **drops**. Writing $\sigma=s=\sqrt{1-3\alpha}$ and $c=\theta_0(n)$,

$$\gamma_{\text{frontier}}(\sigma)=\sqrt{\tfrac23}\Big[3(1-\sigma^2)\sigma\sqrt{\tfrac56}+\sigma^3c\Big]=\sqrt5\,\sigma-\big(\sqrt5-\sqrt{\tfrac23}c\big)\sigma^3,$$

using $\sqrt{2/3}\cdot3\sqrt{5/6}=3\sqrt{5/9}=\sqrt5$. The requirement, in the same variable, is $(3-5\alpha)/\sqrt3=(4+5\sigma^2)/(3\sqrt3)$. **Neither closed form appears anywhere on the record**, and both are two lines from what the record does display.

**Hand screen, reported as a screen.** Multiplying through by $3\sqrt3$ and taking the worst constant $c=\sqrt2$ (so $\sqrt{2/3}c=2/\sqrt3$, the $n\to\infty$ limit, and the coefficient $\sqrt5-\sqrt{2/3}c$ is smallest, making $\gamma$ largest), the branch inequality becomes the cubic sign condition

$$g(\sigma):=(3\sqrt{15}-6)\sigma^3+5\sigma^2-3\sqrt{15}\,\sigma+4>0\qquad\text{on }0<\sigma\le\sqrt{45/141}.$$

$g'(\sigma)=3(3\sqrt{15}-6)\sigma^2+10\sigma-3\sqrt{15}$ has its positive root near $0.585$, above the interval's right end $0.5649\ldots$, so $g$ decreases across the interval and is minimised at the endpoint, where $g\approx0.045$ against coefficients of size $\approx11$. **Positive, so the branch inequality holds on $[\alpha^\ast,\tfrac13)$ uniformly in $n$**, a smaller $c$ only raises the cubic coefficient and raises $g$.

**Two things follow, and the second matters more than the first.**

- The frontier branch's half of the covering is elementary once the constant is granted: a cubic with a sign to check, not an extrapolation. The record instead supports it with *"the ratio ... peaks near $\alpha=0.25$ at $0.825$ ($n=12$) and $0.834$ ($n=14$), scaling with $c_n$ and extrapolating to $\approx0.93$ as $n\to\infty$"*, two data points and a limit. **This is presented as numerics where closed form was available.** Recorded as a presentational defect, not a mathematical one; the report does not claim the check above as a repair, since it is conditional on H5–H9 and on the constant exactly as the record's version is.
- **The slack at the binding end is under one per cent**, which is where §5.2's four-per-cent tolerance on the constant comes from.

### 6.2 Nienhaus's branch, and the gap

**This is where the estimate lives or dies, and the brief is right to press it.**

The covering claim needs $N(n)\ge\alpha^\ast=32/141$ for every $n\ge12$, where $N(n)$ is the reach of Nienhaus's own bound. **What the record supplies:**

| ingredient | on file? |
| --- | --- |
| a closed form for $N(n)$ | **no, nothing, anywhere** |
| values of $N(n)$ | three: $0.322271$ ($n=12$), $0.290168$ ($n=16$), $0.234970$ ($n=100$) |
| $N$ decreasing in $n$ | **asserted**, "falling with $n$". [L22.lean](../lean/HamiltonsCubic/Results/L22.lean)'s theorem `reach_falls` proves $0.2350<0.3223$, which is a two-point comparison presented under a monotonicity name |
| $\lim_{n\to\infty}N(n)$ | **not stated**; it is recoverable only by reading the quoted margin backwards, giving $\approx0.2343$ |
| $\inf_nN(n)>\alpha^\ast$ | **not stated and not proved** |

**Verdict: GAP, and it is the block's principal one.** Without monotonicity, three values and a limit do not bound $\inf_nN(n)$; a dip below $32/141$ at some $n$ between $16$ and $100$, or beyond $100$, is not excluded by anything written down. And even granting monotonicity the argument needs the limit, which the record never prints.

**What would have to be proved, named exactly, since this report supplies no argument.** Two statements, and both look reachable:

1. **$N$ is a nonincreasing function of the constant $c_n=\theta_0(n)/\theta^\ast$ alone**, with no other $n$-dependence.
2. **$N$ evaluated at the limiting constant exceeds $32/141$**, that is $N(2/\sqrt3)>32/141$.

Given (1) and (2) the covering follows, because $\theta_0(n)^2=2(1-3/n+2/n^2)$ is strictly increasing in $n$ with limit $2$, so $c_n$ increases to $2/\sqrt3$ and $N(n)$ decreases to $N(2/\sqrt3)$, **and that monotonicity in $n$, which the record asserts from three points, has a one-line closed-form proof once (1) is granted.** Whether (1) holds is a question about Nienhaus's Theorem 4.17, which is not on file; whether (2) holds needs his bound in closed form, likewise absent. **This is HYPOTHESIS-DEBT naming what would have to be proved, not a repair.**

### 6.3 The $+0.0074$ margin, the prior audit's finding is withdrawn

The record annotates itself: *"this branch is given as covering $\alpha\ge0.2270=\alpha^\ast$, and $0.223<32/141$ by about $0.0040$ ... Either the margin is between quantities other than the two coverage endpoints, or one figure is off"*, and [L22.lean](../lean/HamiltonsCubic/Results/L22.lean) carries the same finding.

**Discrepancy protocol, run on the prior finding rather than on a new one.**

- *Located*: [route-a.md](../findings/route-a.md) line 556 and its annotation.
- *Exhibited*: the annotation's own arithmetic is right, $32/141-0.223=0.00395$, and $0.223$ does lie below $\alpha^\ast$.
- *Argued the opposite, and this is what settles it*: the annotation's first disjunct is correct, and the margin is not between the coverage endpoints. **Hand screen:** evaluating $(4+5\sigma^2)/(3\sqrt3)-\gamma_{\text{frontier}}(\sigma)$ at $c=\sqrt2$ over $\sigma^2\in[0.30,0.36]$ gives a minimum of about $0.0075$ near $\sigma^2\approx0.34$, that is near $\alpha\approx0.22$, with the value at $\alpha=0.223$ about $0.0078$. **So "$+0.0074$ at $\alpha\approx0.223$ in the limit" reads correctly as the worst slack of the frontier branch's own inequality, in $\gamma$-units, at $n=\infty$, a quantity that has a location in $\alpha$, which an interval width does not.** Under that reading nothing is inconsistent: the slack is minimised slightly below $\alpha^\ast$, and a worst-case figure quoted over a slightly wider sweep than the branch is used on is a conservative habit, not an error.

**But the two readings cannot be fully separated, and I say so rather than claiming the resolution.** The overlap-width reading gives $0.234970-0.226950=0.00802$ at $n=100$ and would give $\approx0.0074$ at a limit of $\approx0.2343$, numerically just as plausible. **Both readings land within $0.0006$ of the quoted figure, so the arithmetic does not discriminate; only the "at $\alpha\approx0.223$" locator does, and it favours the slack reading.** Accordingly the prior audit's discrepancy is **withdrawn as unadjudicable from the record**, with the recommendation that the block say which quantity the margin is a margin between. It is not upgraded to a defect and it is not dismissed.

## 7. The measured input, and zero-padding

### 7.1 What zero-padding can establish

Embedding $\mathbb R^{12}\hookrightarrow\mathbb R^m$ and extending a Weyl operator by zero is an isometric algebra embedding $\mathcal W_{12}\hookrightarrow\mathcal W_m$ compatible with $Q$, $\circ$ and $P$, which is exactly why [conventions.md](../findings/conventions.md) can say *"padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$"*. **Two consequences, and they are of very different value.**

- **What it establishes.** $M(m)\ge M(12)$ for $m\ge12$: the padded copy is a competitor in the larger space. This is genuinely *"monotonicity in $n$ ... as a lower bound"*, and it is a statement about $M$, the global maximum.
- **What it cannot establish.** Anything about H7 at $n=20,24$. Padding preserves everything exactly, so the residual computed on a padded $n=12$ pair is **numerically the same number as at $n=12$**, the same computation reported twice. Meanwhile the object H7 quantifies over grows: $V_{1/3}$ and $\ker F_u$ at $n=20$ are strictly larger than the padded images of their $n=12$ counterparts, because $F_u$ at $n=20$ is the linearisation at $W_{\mathbb{CP}^2}$ padded into $\mathbb R^{20}$ and its multiplicity spaces carry the whole $SO(16)$-branching. **A padded pair contains no $W_1$ with support outside the original $\mathbb R^{12}$, and those are the only elements a test at $n=20$ could be about.**
- **Arguing the opposite**, as the protocol requires: padding is a valid *falsification* test, had the residual been nonzero on a padded pair, H7 would be false at $n=20$. So passing it is not worthless. It is merely **logically vacuous as confirmation**, being the $n=12$ measurement re-reported.

**This is the "$\ker W\ne0$ and padded objects" trap, and the brief is right that it lives here.** The competitor $u$ itself is a padded object with a large kernel at every $n\ge12$ ($\mathbb R^{n-4}$ contributes nothing to $u$) and $\ker F_u$, the space slot three's constant is a supremum over, is large for exactly that reason. The padding is harmless for $u$ and for $M(n)$, and it is fatal to the claim that $n=20,24$ were checked.

### 7.2 Does the block's scope paragraph state the limitation correctly?

**No.** The block reads: *"dimensions $20$ and $24$ are checked by zero-padding, which gives monotonicity in $n$ as a lower bound."*

- *Located*: [route-a.md](../findings/route-a.md) line 554.
- *Exhibited*: the sentence's subject is the vanishing $M_{W_1}\Pi_{\ker}Q(W_1)=0$. **An identity asserting that a quantity is zero has no "monotonicity in $n$ as a lower bound"**, the phrase belongs to $M(n)$ or to a supremum, not to a vanishing. As written the caveat attaches to a quantity that cannot carry it, and the word "checked" claims for $n=20,24$ a status padding cannot confer.
- *Argued the opposite*: the longer form at [route-a.md](../findings/route-a.md) line 520 is better, *"zero-padding the $n=12$ pair into $m=14,16,20,24$ preserves everything exactly, which gives monotonicity in $n$ but only as a lower bound"*, and it says "the $n=12$ **pair**", which correctly signals that one pair was padded rather than the eigenspace resampled. **The longer form is nearly right and the block's condensation of it is wrong**; the defect is in the copy the brief puts under review.

**Verdict on row 15: BROKEN as written.** The repair is one sentence: *the vanishing is measured at $n=12,14,16$; padding an $n=12$ pair into $m=14,16,20,24$ preserves it exactly and so re-reports the $n=12$ measurement rather than testing those dimensions.*

### 7.3 The evidence behind H7, and the subfamily trap

L102's own annotations, quoted rather than re-measured: *"$40$ random draws at $n=12$ and fewer at $14,16$, never exhaustive, the block did not say it sampled."* **H7 is a universal claim over the unit sphere of $V_{1/3}$, and $40$ draws do not sample it.** This is the "proven on a subfamily and used in general" trap, hit squarely, and I record it without attempting to improve on it, improving on it would be a measurement, which this loop does not do.

**And H9 is worse off than H7.** [L101](../findings/route-a.md)'s audit says *"'exhaustively verified' licenses the vanishings and not the suprema"*, the vanishings are multilinear, so a basis settles them, while $\sup T(W_1,K,K)=2/3$ is a supremum over a sphere and a basis settles nothing. $a=\sqrt{5/6}$ escapes this, because L101 gives it a closed form. **$\lambda=2/3$ has no closed form anywhere, and $V$, $t^*$ and $\alpha^*$ all move if it is wrong. It is the block's least-supported load-bearing number and the block does not flag it.**

## 8. The three copies, and what a consumer may cite

### 8.1 The copies disagree, and the canonical one is the worst

| copy | scope it states |
| --- | --- |
| **A**, [results.md](../results.md) lines 725–729, the canonical entry | *"For every $n\ge12$ that estimate holds"*, **flat, unconditional, universal**, in a block whose own heading reads "at $n=12,14,16$" |
| **B**, [results.md](../results.md) line 236, the landscape | conditional, circular, relabelled; names the constant, L102, and the $+0.0074$ margin |
| **C**, [results.md](../results.md) line 41, the summary | *"conditional on the eigenvalue bound $\alpha\le\tfrac13$"* and *"the bundle contains the conditional Observation L22"*, names **a different condition** (H3) as the conditionality and does not name the constant |
| **D**, [route-a.md](../findings/route-a.md) lines 534–564, the block | heading says $n=12,14,16$; the body says the repair *"now closes for every $n\ge12$"*; the conditionality appears only in the last-but-two paragraph |

**Copy A is a defect and the others are not.** *Located*: [results.md](../results.md) line 727. *Exhibited*: the sentence "For every $n\ge12$ that estimate holds" contains no hedge of any kind and contradicts its own heading three words earlier, and the sentence that follows it is about L20 rather than about scope. *Argued the opposite*: the paragraph does carry a long italic clause, but that clause is about **L20's independence from L22**, not about L22's own conditionality, so a reader taking the canonical entry at face value takes an unconditional universal theorem. **The defect survives.**

### 8.2 What a consumer may legitimately cite

**First, the brief's own premise is refuted by the record and should not be relied on.** The brief says *"[Lemma L20](../findings/route-a.md) and the tube argument both consume this block."* The record says the opposite in four places: [route-a.md](../findings/route-a.md) line 115 (*"It invokes neither Observation L22 nor Observation L102 nor any a priori cap"*), line 502 (*"nothing cites L22 ... Lemma L20 uses neither"*), [results.md](../results.md) line 48 (*"does not rest on Lemma L22"*), and [results.md](../results.md) line 707 (*"no Lemma L22 directly or through L21"*). The canonical entry adds that this is *"the fourth place to name Observation L22 as an input to L20; the proof invokes it nowhere"*. **The brief has made the misdescription a fifth time. Flagged, because the whole point of L20's annotation is to stop it recurring.**

**Second, the citable content, in three tiers.**

- **Citable as established closed-form algebra, and re-derived here from scratch:** the equivalence of the required estimate with $\gamma_{\max}(\alpha)<(3-5\alpha)/\sqrt3$ given H1; the value $4/(3\sqrt3)$ at $\alpha=\tfrac13$; the $\alpha$-identity and $s^2\le6\varepsilon/(3-c_0^2)$; the solution $V(t)$ of the inner problem **given H7, H8, H9**; $t^*=\sqrt{30}/8$; $\alpha^*=32/141$; the tangency and $4ab=\tfrac56$; and the crossover $n=6+2\sqrt7$.
- **Citable only with the hypothesis attached:** the frontier branch's inequality on $[\alpha^\ast,\tfrac13)$, which needs the constant.
- **Not citable at all:** *"for every $n\ge12$ that estimate holds"*; *"they overlap for every $n\ge12$"*; *"the frontier is exact"*; and any use of the block anywhere upstream of Conjecture A, on pain of circularity through the Nienhaus branch.

## 9. Boundaries, traps, and the items where nothing was found

**Silence is not a verdict, so every item named in the brief gets a line.**

| item | finding |
| --- | --- |
| $\ker W\ne0$ and padded objects | **HIT**, §7.1; padding is sound for $u$ and for $M(n)$ and vacuous for H7 at $n=20,24$ |
| boundary $n=12$ | **clean**, first integer past $6+2\sqrt7$, margin $n^2-12n+8=8>0$ |
| boundary $\alpha=\tfrac13$ | **clean, and better than the block says**, the estimate is stated for $\alpha<\tfrac13$ only, and at $\alpha=\tfrac13$ the frontier bound is $\sigma=0$, hence $\gamma=0<4/(3\sqrt3)$, so the closed endpoint is covered too. The block never says so |
| boundary $\alpha=\alpha^\ast$ | **clean but tight**, $t=t^*$ gives $x_\ast=1$ exactly, so $B=0$ and $A=\sqrt{5/6}$ agree from both sides; and this is where the branch's slack is smallest |
| boundary $t=t^*$ | **clean**, $V$ is $C^1$ there, §4.4 |
| boundary $\varphi=\pi/6$ | **HIT**, H2; the block reads $\tilde f$ at one point and asserts the reduction is "exactly" the estimate |
| crossover $n=6+2\sqrt7$ | **checked exactly**, §2.1; not stated in the block, only in [results.md](../results.md) |
| a claim proven on a subfamily, used in general | **HIT twice**, H7 on 40 draws; H9 on a sampled supremum |
| a hypothesis stated but never used | **HIT**, H10, the co-attainment, §4.4 |
| a step using a hypothesis never stated | **HIT five times**, H2, H3, H4, H5, H6 |
| a universal claim with no witness | **HIT**, H10 and H7 both quantify over $V_{1/3}$, and [route-a.md](../findings/route-a.md) line 201 records that no $\tfrac13$-eigenvector is exhibited anywhere on the record |
| an imported theorem with unchecked hypotheses | **CHECKED AND CLEAN**, §4.2; symmetry of $M_{W_1}$ holds via H4, the ball-versus-sphere mismatch is harmless, and the import is eliminable in three lines. **This is the trap that killed another route and it does not bite here** |
| symbol collisions: $\alpha$ | **live**, [conventions.md](../findings/conventions.md) warns it is *"not the $\alpha$ parametrising the competitor family $W_{\mathcal S^4(\alpha)}$ in the same file"*; the block does not quote the row |
| $\gamma$ | **live**, [conventions.md](../findings/conventions.md) carries $\gamma$ as a cubic coefficient in the two-negative relaxation and as $S^{\mathrm{ord}}_{\mathfrak{mhh}}-S^{\mathrm{ord}}_{\mathfrak{mmm}}$; L22's $\sqrt{2/3}P(W)$ is a third |
| $\theta^*$ | **clean**, one sense, tabled |
| $F_u$ | **clean**, tabled |
| $t$ | **collision, untabled**, [conventions.md](../findings/conventions.md) fixes $t=t_F=\lVert K(F)\rVert_F^2$ per frame and warns the per-frame and extremal readings *"are distinct and have been swapped"*; L22's $t=s/\cos\beta$ is a third sense, tabled nowhere |
| $s$, $\varepsilon$ | **untabled but unambiguous in the block**, $s=\sin\beta$, $\varepsilon=\tfrac13-\alpha$; $\epsilon_{\alpha\beta}$ is a different, indexed object in [conventions.md](../findings/conventions.md) |
| $A$, $B$ | **collision, twice over**, $B$ carries four objects on the record by [conventions.md](../findings/conventions.md)'s own count and $A$ two; L22 adds one each, **and uses each of its own in two senses six lines apart** (§4.3) |
| $M$ | **collision**, [conventions.md](../findings/conventions.md) tables $M$ the sectional matrix and $M(n)$ the global maximum; L102's annotation states outright that *"$M_{W_1}$ IS DEFINED NOWHERE in findings/ or conventions.md"*, and $M_{W_1}$ is the operator the whole trust-region step is about |
| $K$ | **collision, unflagged anywhere**, [conventions.md](../findings/conventions.md) fixes $K$ as *"the symmetric hollow $n\times n$ sectional matrix"*; L22's $K$ is a Weyl operator in $\ker F_u$. Not tabled, not flagged by any prior audit I can find |
| $m$, two senses in this file | **relevant, and diagnostically**, [conventions.md](../findings/conventions.md) records $m=n-4$ and $m=\sqrt{2/3}\max P$; **the second is exactly the object L22's slot three should carry instead of $\theta_0(n)$**, §5.2 |
| $W_1$ | **collision**, L102's annotation records that *"$W_1$ carries three meanings in this file"*, L103 using it for the $S^6\times S^6$ operator |

## 10. What would falsify it, and what was done to look

**The objects, named.**

1. **A unit $K\in\ker F_u\subseteq\mathcal W_n$ with $P(K)>1.04\,\theta_0(n)$**, for $n$ large. This breaks the frontier branch directly, and $4\%$ is the whole tolerance (§5.2). Any such $K$ is also a counterexample to Conjecture A, which is why the branch is conditional rather than merely unproven.
2. **A unit $W_1\in V_{1/3}$ with $M_{W_1}\Pi_{\ker}Q(W_1)\ne0$.** This breaks H7, hence the hard case, hence $V(t)$, hence $t^*$ and $\alpha^*$. L102's annotation shows the failure mode in closed form: *"$M\hat q=\mu\hat q$ with $0<\mu<\lambda_{\max}$, and then $K=\hat q$ gives $a+t\mu>V(t)$."*
3. **A unit $W_1\in V_{1/3}$ with $\lambda_{\max}(M_{W_1})>2/3$ or $\lVert\Pi_{\ker}Q(W_1)\rVert>\sqrt{5/6}$.** This raises $V$, moves $t^*$ down and $\alpha^*$ **up**, widening the interval the two branches must jointly cover, and the covering has $0.008$ of room.
4. **An $n\ge12$ with $N(n)<32/141$.** This breaks the covering outright, and it is the falsifier the record is least equipped to exclude, since $N$ has no closed form on file.

**What was done to look for them, and what was not.**

- **(1): analysis.** I put the frontier branch into closed form as a cubic in $\sigma$ and located its minimum slack at the branch endpoint, which is what produced the $4\%$ tolerance. **No falsifier of this kind exists within $4\%$ of the conjectured constant**, which is a statement about the size of the hole, not evidence that it is empty.
- **(2) and (3): nothing was done, and nothing could be.** These are statements about a sampled supremum and a sampled identity on a sphere of dimension in the hundreds. The record's evidence is $40$ draws; improving on it is a measurement, and **this loop does no numerical work**. The brief is explicit that producing a better measurement would not be an answer to whether the input has an argument on file, and it does not have one.
- **(4): no search was possible even in principle.** $N(n)$ appears on the record as three decimal numbers with no formula behind them, so there is nothing to evaluate, differentiate or bound. **That is the finding: the most likely falsifier is the one the record has made unsearchable.** §6.2 names the two statements that would close it.

## Verdict

**HYPOTHESIS-DEBT**, with a GAP and one broken sentence inside it.

- **The algebra is sound and was re-derived here in full**, including two closed forms the record does not display: the frontier branch as $\gamma=\sqrt5\sigma-(\sqrt5-\sqrt{2/3}\,\theta_0(n))\sigma^3$, and the inner problem's solution from which $V(t)$, $t^*=\sqrt{30}/8$, $\alpha^*=32/141$, the tangency, and all four of the block's printed values follow. Nothing in the displayed algebra is wrong.
- **The debts, named so they can be discharged**: H2 ($\varphi=\pi/6$ binding); the assertion $c_0=1$, on which the equality $s^2=3\varepsilon$ wholly depends; H9, $\lambda=2/3$, which has no derivation anywhere and moves $\alpha^*$; H7, measured on $40$ draws; and above all H11, **$\sup\{P(K):K\in\ker F_u,\lVert K\rVert=1\}\le\theta_0(n)$**, which is what the sphere-product value stands in for, which is strictly weaker than Conjecture A, which no argument on the record discharges, and which has about $4\%$ of room in it.
- **The GAP is the covering at large $n$**: $\inf_{n\ge12}N(n)>32/141$ is asserted from three numbers and an unproved monotonicity, and $N$ has no closed form on the record.
- **The broken sentence is the padding claim**, [route-a.md](../findings/route-a.md) line 554, which attaches a lower-bound-monotonicity caveat to a vanishing and calls $n=20,24$ "checked".
- **On circularity, which is what the brief was for**: the frontier branch is a genuine conditional statement whose hypothesis a reader could in principle discharge independently. **The Nienhaus branch, on the record's own description of it, uses Conjecture A's cap on $\max P$, and [route-a.md](../findings/route-a.md) calls that cap "conclusion-presupposing" in its own words at L20.** A two-branch disjunction inherits the worse half. **So as a repair of Nienhaus's Theorem 4.17 for a reader holding Conjecture A, this is a conditional theorem; as a step toward Conjecture A, it assumes the conclusion, and copy A, the canonical entry, states it as neither.**
