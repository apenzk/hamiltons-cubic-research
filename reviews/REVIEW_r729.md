# Review r729, Gate 2 adversarial review of seven refutations

*Cold review of the seven refutations entered against the record on 2026-09-06/07. Every number below is exact rational arithmetic on an object constructed for the check, reported as a screen. No search, sweep or census was run; the two enumerations that appear (the $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$ pairs at $n\le13$, the five splits of [L26](../findings/nondegeneracy.md)) are finite evaluations of claims already written on the record, not hunts.*

## Claim table

| Item | Result | The strike | Verdict |
| --- | --- | --- | --- |
| 1 | [L13](../findings/curvature-invariants.md) | "reaching $58.9$ needs $k_0\ge74>66$" is false; $66$ gives $58.92$ and $74$ gives $50.05$ | **CONFIRMED** |
| 2 | [L01](../findings/problem.md) | $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$ is the wrong edge; $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ is the one that excludes the corner | **PLAUSIBLE**, defect real, repair names an edge that admits the corner too |
| 3 | [L38](../findings/ungraded-slack.md) | "capped" is false in the reader's sense; equality at $m=3$ for $\mathbb{CP}^m$ | **CONFIRMED** |
| 4 | [L39](../findings/target.md) | "overshoots every time" false, witness $(\mathfrak{so}(9),\mathfrak{so}(8))$; the admissibility argument is circular | **PLAUSIBLE**, conclusion right, witness degenerate and reading-dependent |
| 5 | [L41](../findings/target.md) | the two identities are scale-wrong; the bound changes sign; the equality clause is one-way | **CONFIRMED** |
| 6 | [L71](../findings/bounds.md) | the determinant route is a non-sequitur; $\mathrm{diag}(-1_2,1_6)$ against $J$ | **CONFIRMED**, but the struck text still stands verbatim ten lines below |
| 7 | [L26](../findings/nondegeneracy.md) | the five splits missed $(3,4)$ by range, not by thinness; two sit on the equality locus | **CONFIRMED**, "false in both halves" overreaches |

**Two of the seven need work.** Item 2's repair names $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ as the edge that excludes the corner, and the corner sits **on** that edge with equality, the record's own [L1.lean](../lean/HamiltonsCubic/Results/L1.lean) says so in the same breath. Item 4's witness is the one member of the family where $\mathfrak k$ is the isotropy of a single sphere rather than of a product, and under the reading that makes "the true $\theta$" the pair's own value it overshoots rather than undershooting; non-degenerate witnesses that work under both readings are already implied by the record's own formula.

**One defect outside the seven, and it is live.** [bounds.md](../findings/bounds.md) line 625 strikes the determinant route and line 635 asserts it verbatim, "by two independent routes". The record currently refutes and endorses the same sentence inside one block.

## Item 1, [L13](../findings/curvature-invariants.md): CONFIRMED

**The chain.** $\theta^2(1+k_0/4)\le\mathop{\mathrm{tr}}(L_W^2)=\kappa_n=\frac{(n-1)(2n-1)}4$, so $\theta\le\sqrt{\kappa_n/(1+k_0/4)}$, **strictly decreasing in $k_0$**. That monotonicity is the whole of the item.

I rebuilt the proof before the numbers. $Q$ is quadratic, so $DQ_W(H)=2W\circ H$; differentiating $Q(gW)=gQ(W)$ at $g=e$ in direction $A$ gives $2W\circ o_A=\theta o_A$, i.e. $L_Wo_A=\tfrac\theta2 o_A$, while $L_WW=Q(W)=\theta W$ and the orbit is tangent to the sphere so $o_A\perp W$. Self-adjointness then gives $\mathop{\mathrm{tr}}(L_W^2)\ge\theta^2+k_0(\theta/2)^2$. The step is sound and consumes no maximality, which is what the block's "the Peirce cap is not used, and could not be" says.

**The arithmetic, exact.** $\kappa_{12}=\tfrac{253}4$, $\theta_0(12)=\tfrac{\sqrt{55}}6=1.2360330812$, $\sqrt{3/2}=1.2247448714$, denominator $0.0112882098$.

| $k_0$ | $\theta$ bound | ratio $(\text{bound}-\theta_0)/(\theta_0-\sqrt{3/2})$ |
| --- | --- | --- |
| $34$ (padded $W_{\mathbb{CP}^2}$) | $\sqrt{253/38}=2.5802897$ | $119.09$ |
| $36$ ($S^6\times S^6$) | $2.5149553$ | $113.30$ |
| $66=\binom{12}2$ | $\sqrt{253/70}=1.9011275$ | $\mathbf{58.92}$ |
| $74$ | $\sqrt{253/78}=1.8009969$ | $\mathbf{50.05}$ |
| $162$ | $1.2345430$ | $-0.13$ |

So $58.9$ is produced by $k_0=66$ (the **largest** admissible orbit, not by any $k_0\ge74$) and $k_0=74$ produces $50.05$. The struck sentence inverted the monotonicity and then declared the resulting impossibility. **The original is false as written, and the replacement is exact.**

**Where the $74$ came from is also right.** The level-3 bound $1.7974$ has ratio $(1.7974-\theta_0(12))/0.0112882098=49.7304$, and inverting it through the display gives $4\big(\tfrac{253}{4\cdot1.7974^2}-1\big)=74.3125$. So $74$ is the effective orbit dimension of the *level-3* bound and was paired with the level-2 ratio. The record's "$49.7$ was never wrong" is confirmed.

**The second strike (reading an upper bound as a determination), is also confirmed, with the witness checked.** Setting the bound equal to $\theta_0(12)$ gives $1+k_0/4=\tfrac{253/4}{55/36}=41.4$, so $k_0=161.6$ and the "determination" reading demands $k_0\ge162$. The stabiliser of $W_{6,6}$ in $O(12)$ contains $SO(6)\times SO(6)$ at dimension $30$, so its orbit is $66-30=36\ll162$, and the reading would refute a point the record holds as the conjectured maximiser. **The fallacy is real and the witness is the right one.**

**Collateral figures I checked and found sound.** $k_0\le\binom n2$ gives $\theta^2\le\frac{2(n-1)(2n-1)}{n^2-n+8}\to4$ ($3.99999$ at $n=10^6$); ratio $17.88$ at $n=14$, $3.5736$ at $n=100$, $\to3.0917$; crossover $\theta_0(n)^2=\tfrac32$ is $n^2-12n+8=0$, i.e. $6+2\sqrt7=11.2915$; the odd crossover $\Theta_n^2=\tfrac32$ is $n^2-13n+18=0$, i.e. $\tfrac{13+\sqrt{97}}2=11.4244$. Every one matches the block.

## Item 2, [L01](../findings/problem.md): PLAUSIBLE, and the repair needs one sentence changed

**The defect is real.** Both edges are genuine consequences of $S\succeq0$, $\mathop{\mathrm{tr}}S^2=1$: Cauchy–Schwarz on $(\lambda,\lambda^2)$ gives $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$, and on $(\lambda^{1/2},\lambda^{3/2})$ gives $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$. The corner is $\mathop{\mathrm{tr}}S^3$ at its floor against $\mathop{\mathrm{tr}}S^4$ at its ceiling $E(12)=\tfrac{8N^2-41N+49}{4(N+1)(N-2)(N-3)}\big|_{N=12}=\tfrac{709}{4680}$. There $(\mathop{\mathrm{tr}}S^3)^2=\tfrac1{12}=\tfrac{390}{4680}\le\tfrac{709}{4680}$, so **the first edge holds at the corner and admits it**. That half of the strike is exact and I confirm it.

**The repair is false as an exclusion claim, and the record's own Lean file says why.** The floor is $\mathop{\mathrm{tr}}S^3\ge1/\sqrt n$, and it is produced *by* the second edge with $\mathop{\mathrm{tr}}S\le\sqrt n$. So the corner's first coordinate is exactly $1/\sqrt{12}$, the corner sits **on** the second edge, with equality, and that edge admits it too. [L1.lean](../lean/HamiltonsCubic/Results/L1.lean) states this outright: *"the flat spectrum below sits **on** that edge, with equality"*, three lines after calling that edge the corner elimination.

**What actually eliminates the corner is the equality case, and the prose already contains it.** $1=(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ with $\mathop{\mathrm{tr}}S=\sqrt{12}$ forces the flat spectrum $\lambda_i=1/\sqrt{12}$, where $\mathop{\mathrm{tr}}S^4=\tfrac1{12}=0.0833$ rather than $E(12)=0.1515$. So the corner is not a spectrum. The block's own clause, *"the corner elimination is an equality case … the Cauchy–Schwarz equality binds only at the flat spectrum"*, is the correct mechanism, and the bolded sentence beside it contradicts it.

**Required correction.** *"The edge that does the work is $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$"* should read that the second edge supplies the **floor** $1/\sqrt n$ and its **equality case** (uniqueness of the flat spectrum), is what removes the corner; neither edge excludes the corner as a point.

**The rest of the item confirms.** With $\varphi(v)=\tfrac7{10}v+\tfrac{8647}{38000}$, $\varphi(E(12))=\tfrac{92699}{277875}=0.3335996$, against the floor $1/\sqrt{12}=0.2886751$ and the requirement $0.3151700$ the script prints. So $0.2887<0.3152<0.3336$: **the edge does not close $n=12$ and the dual certificate does**, exactly as the strike says. The box corner $(\mathop{\mathrm{tr}}S^4,\mathop{\mathrm{tr}}S^3)=(\tfrac12,\tfrac15)$ satisfies $\tfrac1{25}\le\tfrac12$ and fails $\tfrac15\ge0.2887$, the record's ordering of that pair is unwritten and inverts the reading, worth a word.

**One scope debt.** $E(12)$ and the requirement $0.3152$ appear on the record only inside this one sentence; $E(N)$ is defined in [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py) line 36 and nowhere in [findings/](../findings/). A refutation whose two key constants are undefined symbols cannot be audited from the record alone.

## Item 3, [L38](../findings/ungraded-slack.md): CONFIRMED

**The difference is an identity, and it factors as the block says.** With $\theta_0(2m)^2=\frac{(2m-1)(m-1)}{m^2}$,

$$\frac{(m+1)(2m-1)}{3m(m-1)}-\frac{(2m-1)(m-1)}{m^2}=(2m-1)\cdot\frac{m(m+1)-3(m-1)^2}{3m^2(m-1)}=\frac{-(2m-1)^2(m-3)}{3m^2(m-1)},$$

using $m(m+1)-3(m-1)^2=-(2m-1)(m-3)$. **The sign is that of $3-m$**, so the family is above at $m=2$, exactly zero at $m=3$, below from $m\ge4$, confirmed as an identity in $m$, not at sampled members.

| $m$ | $n=2m$ | $\mathbb{CP}^m$ $\theta^2$ | $-\theta_0(2m)^2$ | Kähler $\theta^2$ | $-\theta_0(2m)^2$ |
| --- | --- | --- | --- | --- | --- |
| $2$ | $4$ | $3/2$ | $+3/4$ | $3/2$ | $+3/4$ |
| $3$ | $6$ | $10/9$ | $\mathbf 0$ | $6/5$ | $+4/45$ |
| $4$ | $8$ | $35/36$ | $-49/144$ | $10/9$ | $-29/144$ |
| $5$ | $10$ | $9/10$ | $-27/50$ | $15/14$ | $-129/350$ |
| $6$ | $12$ | $77/90$ | $-121/180$ | $21/20$ | $-43/90$ |

Every figure in the strike reproduces. The $m=3$ coincidence is genuine ($\mathbb{CP}^3$ and $S^3\times S^3$ both read $\theta^2=\tfrac{10}9$ at $n=6$) and the Kähler $\tfrac65$ against $\tfrac{10}9$ matches the collision [conventions.md](../findings/conventions.md) tables for "the Ricci-flat Kähler family".

**The attainment clause is right and is what empties the word "capped".** Padding preserves $P$, so padded $W_{\mathbb{CP}^2}$ carries $\theta^2=\tfrac32$ into every $\mathcal W_n$; the cap $\theta^2\le\tfrac32$ is therefore attained at every $n$ where it is invoked, so it fences the two families and separates nothing. **CONFIRMED.**

**Two scope notes the strike should carry.** The Kähler row values an operator the record does not know to lie in $\mathcal W_{2m}$ (the block's own "WHAT IS OWED") so "above at $m=2$ and $m=3$" is a statement about the [L39](../findings/target.md) formula's output, not about a Weyl tensor. And the whole comparison is against $\theta_0(2m)$, which at even $n$ equals $\Theta_n$; no odd ambient dimension is in scope.

## Item 4, [L39](../findings/target.md): PLAUSIBLE, right conclusion, wrong witness

**The circularity strike is sound.** The recorded figures compare the ansatz value against $\Theta_n$, and $\Theta_n$ bounds only the *diagonal* maximum; $M(n)\ge\Theta_n$, and the ansatz is nowhere asserted diagonal. So "exceeds $\Theta_n$, hence not a Weyl tensor" is licensed only by Conjecture A. **Circular, confirmed.**

**The witness computes correctly.** $(\mathfrak{so}(9),\mathfrak{so}(8))$: $p=\dim\mathfrak{so}(8)=28$, $q=36-28=8$, and $c=2(n-2)=14$ from [L153](../findings/bounds.md)'s marginal. Then $cq(3p-q)-4p(p-q)=112\cdot76-2240=6272$ and $16p^3q(p+q)=101154816$, giving $\theta^2=\tfrac{39337984}{101154816}=\tfrac7{18}$ exactly, against $\Theta_9^2=\tfrac{48}{35}$, a factor $\tfrac{864}{245}=3.53$ on the squares. **The number is right.**

**But the witness is the wrong object.** $\mathfrak{so}(8)=\mathfrak{so}(8)\oplus\mathfrak{so}(1)$ is the $a=1$ endpoint of the family, where $\mathfrak{so}(1)=0$: it is the isotropy of the round $S^8$, not of a sphere *product*. And the pair's own value is $\theta_{1,8}^2=2\tfrac{n-1}{n-2}\big(1-\tfrac{n-1}{1\cdot8}\big)=0$, so under the reading that makes "the true $\theta$" the pair's own value the ansatz **overshoots** there and refutes nothing. The record's two supporting figures do not settle the reading, $\tfrac{48}{35}$ and $\tfrac89$ are simultaneously $\Theta_n^2$ *and* the own values of $S^4\times S^5$ and $S^2\times S^3$, both of which are the balanced splits. **So the original claim's evidence was gathered at the balanced pairs while the claim was made about the unbalanced ones**, which is a defect the strike does not name.

**Screen of the family, exact, both readings.** I evaluated $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$ for $a+b=n\le13$, $a,b\ge2$, a finite evaluation of the struck claim, not a hunt.

| $n$ | pair | L39 $\theta^2$ | own $\theta_{a,b}^2$ | over own? | over $\Theta_n^2$? |
| --- | --- | --- | --- | --- | --- |
| $11$ | $S^2\times S^9$ | $0.930253$ | $0.987654$ | **no** | no |
| $12$ | $S^2\times S^{10}$ | $0.875169$ | $0.990000$ | **no** | no |
| $12$ | $S^3\times S^9$ | $1.291020$ | $1.303704$ | **no** | no |
| $12$ | $S^5\times S^7$ | $1.533847$ | $1.508571$ | yes | yes |
| $12$ | $S^6\times S^6$ | $55/36$ | $55/36$ | equal | equal |
| $13$ | $S^3\times S^{10}$ | $1.244502$ | $1.309091$ | **no** | no |

**So "overshoots every time" is false under either reading, and non-degenerate witnesses exist**: $S^2\times S^9$ at $n=11$ and $S^3\times S^9$ at $n=12$ undershoot the pair's own value, with $a,b\ge2$ and both blocks carrying curvature. Against $\Theta_n$ the failure is wider still, at $n=12$ only $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ exceeds it. **The strike's conclusion stands; its witness should be replaced by one that is a sphere pair.**

**The near-balanced clause verifies exactly.** At odd $n=2k+1$ with $\mathfrak{so}(k)\oplus\mathfrak{so}(k+1)$ the gap against $\Theta_n^2$ equals $\frac{24k^4-6k^3-5k^2+4k-1}{4k^4(2k+1)(k+1)(2k-1)}$ at $k=2,\dots,8$, I checked as exact fractions and every one is an identity, $\tfrac{323}{2880}$, $\tfrac{437}{11340}$, $\tfrac{1139}{64512}$, $\tfrac{1768}{185625}$, $\tfrac{29651}{5189184}$, $\tfrac{13837}{3745560}$, $\tfrac{94943}{37601280}$. Positivity holds at every $k\ge1$: $24k^4-6k^3-5k^2=k^2(24k^2-6k-5)>0$ and $4k-1>0$. **But the clause covers only the odd near-balanced split.** At even $n$ the balanced pair gives gap exactly zero, and the even near-balanced pair $S^{n/2-1}\times S^{n/2+1}$ overshoots without being covered, $1.533847$ against $\tfrac{55}{36}$ at $n=12$. The scope should say so.

## Item 5, [L41](../findings/target.md): CONFIRMED, and every clause rebuilt

**The scaling strike is right on degrees and on the constant.** The $v_\gamma$ are unit eigenvectors, so they are scale-invariant; $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$ is homogeneous of degree $2$ in $W$ and $\lambda_\gamma g_\gamma$ of degree $3$. So "$=4(n-1)$" and "$=-4\theta$" equate degrees $2$ and $3$ with degree $0$, and hold at $\lVert W\rVert=1$ alone.

**I derived the first identity rather than checking it.** Total symmetry of $T$ and [L153](../findings/bounds.md)'s ordered marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ give

$$\sum_\gamma g_\gamma=2\sum_\alpha\lambda_\alpha^2\!\!\sum_{\beta\gamma}\!T_{\alpha\beta\gamma}-2\!\!\sum_{\alpha\beta\gamma}\!\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}=4(n-2)\lVert W\rVert^2-4\mathop{\mathrm{tr}}(W^\#)=4(n-1)\lVert W\rVert^2,$$

using $\mathop{\mathrm{tr}}(W^\#)=-\lVert W\rVert^2$ for a Ricci-flat $W$. **The constant is produced, the criticality-free claim is genuine, and the $\lVert W\rVert^2$ is forced.** The corrected forms are exactly what [conventions.md](../findings/conventions.md) already tables, so the canon did contradict its own conventions file.

**The sign change is real, and I rebuilt the witness from the spectrum.** $W_{\mathbb{CP}^2}$ at unit norm has $\Lambda^2$ spectrum $\big(\tfrac2{\sqrt6},-\tfrac1{\sqrt6},-\tfrac1{\sqrt6},0,\dots\big)$. Its $\lambda_{\max}$ eigenvector is the Kähler form, whose $\mathrm{ad}$ generates the circle preserving $W$, so $\Delta=0$. Then $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ forces the negative-eigenspace mass to be $4\theta/\lvert\lambda_{\min}\rvert=4\sqrt{3/2}\cdot\sqrt6=12$ exactly, whence

$$G_0=4(n-1)-\Delta-12=4(n-4),$$

**independent of the padding**, $0$, $16$, $32$ at $n=4,8,12$, reproducing all three recorded figures from the spectrum rather than from a run. At $2\times$ padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{12}$ the masses scale by $\lVert W\rVert^2=4$, so the bracket reads $44-0-128=-84$ and the bound asserts $\theta\le-21\cdot\tfrac2{\sqrt6}=-17.1465$ against $P(2W)=8\sqrt{3/2}=+9.798$. **Confirmed, to the second decimal the strike prints.**

**The equality clause is one-way, and the slack formula is exact.** From $-4P=\sum_{\lambda>0}\lambda g+\sum_{\lambda<0}\lambda g$ with $\lambda_\gamma\ge\lambda_{\min}$ and $g\ge0$, the bound's slack is $\sum_{\lambda>0}\lambda_\gamma g_\gamma+\sum_{\lambda<0}(\lambda_\gamma-\lambda_{\min})g_\gamma$, the kernel index is absent, $G_0$ having been subtracted from the bracket already. So equality permits arbitrary kernel mass and the class is $\mathop{\mathrm{supp}}(g)\subseteq E_{\lambda_{\min}}\oplus\ker W$. **Padded $W_{\mathbb{CP}^2}$ attains it with $G_0=4(n-4)>0$ at every $n\ge5$**, and both sides read $\tfrac1{\sqrt6}\cdot\tfrac{12}4=\tfrac3{\sqrt6}=\sqrt{3/2}$ exactly. The "only if" half of the recorded clause is refuted by a closed-form point, not by a measurement. **CONFIRMED on all three counts.**

## Item 6, [L71](../findings/bounds.md): CONFIRMED, and the struck text is still on the record

**The counterexample is exact and standard.** Both $g_1=\mathrm{diag}(-1_2,1_6)$ and an orthogonal complex structure $J$ lie in $SO(8)$ ($\det g_1=(-1)^2=+1$, and $J$ has eigenvalues $\pm i$ at multiplicity $4$ each so $\det J=+1$), hence $\mathrm{Ad}(g_1)$ and $\mathrm{Ad}(J)$ are both **inner**, $\mathrm{Inn}(\mathfrak{so}(8))=\mathrm{Ad}(SO(8))$. Their fixed algebras are $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ and $\mathfrak u(4)$, both of dimension $16$, and they are **not** $O(8)$-conjugate: $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ preserves a $2$-plane while $\mathfrak u(4)$ acts irreducibly on $\mathbb R^8=\mathbb C^4$.

**And they are $\mathrm{Aut}$-conjugate, which I verified by weights rather than by citation.** In the torus coordinates $(\theta_1,\dots,\theta_4)$, $g_1$ is $(\pi,0,0,0)$ and $J$ is $(\tfrac\pi2,\tfrac\pi2,\tfrac\pi2,\tfrac\pi2)$. Spinor eigenvalues are $\exp\big(\tfrac i2\sum s_j\theta_j\big)$ over sign patterns of fixed parity, giving

| element | on $V$ | on $S^+$ | on $S^-$ |
| --- | --- | --- | --- |
| $\mathrm{diag}(-1_2,1_6)$ | $(-1)^2,1^6$ | $(\pm i)^4$ | $(\pm i)^4$ |
| $J$ | $(\pm i)^4$ | $(-1)^2,1^6$ | $(\pm i)^4$ |
| $\mathrm{diag}(-1_4,1_4)$ | $1^4,(-1)^4$ | $1^4,(-1)^4$ | $1^4,(-1)^4$ |

**Triality carries the first row to the second**, so the two are $\mathrm{Aut}$-conjugate and not $O(8)$-conjugate while both are inner with $\det=+1$. **The determinant route is a non-sequitur and the strike's witness is the right one.** The same table confirms the weight route: $\mathrm{diag}(-1_4,1_4)$ has one pattern on all three $8$-dimensional representations, so its triality image is $SO(8)$-conjugate to itself, which is exactly the invariance the $\dim\mathfrak h=12$ step needs. This also matches [conventions.md](../findings/conventions.md)'s tabled rule that $\mathrm{Aut}$ against $O(n)$ parts at $n=8$ alone and that $\mathfrak u(n/2)$ is one $O(n)$-class and two $SO(n)$-classes.

**One over-caution.** *"The step from $O(8)$-conjugacy to $SO(8)$-conjugacy is owed"* is weaker than the situation. $\mathrm{Aut}(\mathfrak{so}(8))=\mathrm{Inn}\cdot S_3$, so showing every $S_3$-image of $\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ is inner-conjugate to it delivers $SO(8)$-conjugacy directly, and $\mathrm{Inn}$-conjugacy *is* $SO(8)$-conjugacy of the group elements modulo the centre. The remaining honest debt is that the weight test is stated for the triality element and not for all of $S_3$.

> **A LIVE DEFECT THE STRIKE DID NOT FINISH.** [bounds.md](../findings/bounds.md) line 625 carries the correction, *"What is true, by ONE route"*, with the determinant argument quoted as struck. **Line 635 of the same block still carries the original verbatim**: *"What is true, by two independent routes, is that the balanced involution is fixed. Its determinant: $\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ has $\det=+1$ and is inner, so Cartan's classification up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy."* The record asserts and refutes the same sentence ten lines apart, and a consumer reading the uniqueness paragraph (which is where the argument lives), meets the refuted version. *The clause beside it, that $\mathrm{Ad}(\mathrm{diag}(-1_3,1_5))$ has $\det=-1$ and is outer, is arithmetically true and carries the same non-sequitur: the determinant decides innerness and not conjugacy.*

## Item 7, [L26](../findings/nondegeneracy.md): CONFIRMED, with the strike overreaching by one word

**Every checkable claim is exact.** $\mu=\frac{n-2}{2(p-1)(q-1)}$ and $\lambda_m=\frac{m-2}{2(m-1)}$ at $m=\max(p,q)$.

| split | $n$ | $\mu$ | $\lambda_{\max(p,q)}$ | $(p-2)(q-3)$ |
| --- | --- | --- | --- | --- |
| $(3,4)$ | $7$ | $5/12$ | $1/3$ | $1$ |
| $(3,5)$ | $8$ | $3/8$ | $3/8$ | $2$ |
| $(4,4)$ | $8$ | $1/3$ | $1/3$ | $2$ |
| $(3,7)$ | $10$ | $1/3$ | $5/12$ | $4$ |
| $(5,5)$ | $10$ | $1/4$ | $3/8$ | $6$ |
| $(4,6)$ | $10$ | $4/15$ | $2/5$ | $6$ |

All five have $n\ge8$ and $(3,4)$ has $n=7$, **the range claim is true**. And $(3,5)$, $(4,4)$ sit on $(p-2)(q-3)=2$ with $\mu=\lambda_{\max(p,q)}$ exactly, at $\tfrac38$ and $\tfrac13$, **the equality-locus claim is true**, and it does leave the gap $1/(2\max(p,q)-2)$ unchanged, since $\tfrac12-\lambda_m=\tfrac1{2(m-1)}$ whether or not $\mu$ ties it.

**The criterion is closed, as claimed.** $\lambda_{\max}<\mu$ clears to $3p+2q-4-pq>0$, i.e. $(p-2)(q-3)<2$; over $q\ge p\ge3$ that admits $(3,3)$ and $(3,4)$ and nothing else, since $p\ge4$ forces $(p-2)(q-3)\ge2$ and $p=3$ forces $q\le4$. The order-dependence note is right too: at $(5,3)$ the product reads $0$ while $\lambda_5=\tfrac38=\mu$ is a tie, not a strict overtake.

**Where the strike overreaches.** *"Struck as false in both halves"* is too strong for the first half. Within $\{(p-2)(q-3)<2,\ q\ge p\ge3\}$ the point $(3,4)$ **is** a single lattice point once $(3,3)$ is set aside as the separately handled equality case, so the geometric description is defensible. What is genuinely false is the **causal** claim (that thinness is why the five splits missed it) and the replacement supplies a better reason. *One residual over-claim in the replacement*: "because every one of them has $n\ge8$" states the design of a past scan that the record does not document; what is established is that the miss is **consistent with** a range starting at $n=8$, since $(3,5)$ is adjacent to $(3,4)$ and would have caught it at $n=7$.

## The falsifiers, named

| item confirmed | the object that would falsify it | what I did to look for it |
| --- | --- | --- |
| 1 | a critical point at $n=12$ with $k_0>66$, or a reading under which the bound increases in $k_0$ | $k_0\le\dim\mathfrak{so}(12)=66$ by definition of an orbit in $O(12)$; the bound is $\sqrt{\kappa_n/(1+k_0/4)}$, monotone by inspection. No object can exist |
| 3 | a member of either family, at its own $n=2m$, contradicting the sign of $-(2m-1)^2(m-3)$ | the difference is an identity in $m$, verified as exact fractions at $m=2,\dots,6$ and factored in closed form. Falsifier would have to break the factorisation |
| 5 | a critical $W$ with $\Delta=0$, one negative eigenvalue and $G_0=0$ attaining equality, which would restore the "only if" half | the slack formula is exact and kernel-free; padded $W_{\mathbb{CP}^2}$ at $n\ge5$ has $G_0=4(n-4)>0$ and attains equality, so the half is refuted by a closed form and no search applies |
| 6 | two inner $\det=+1$ involutions of $\mathfrak{so}(8)$ that are $\mathrm{Aut}$-conjugate **and** $O(8)$-conjugate for every such pair | I built the weight table on $V$, $S^+$, $S^-$ from the torus coordinates and read the triality orbit off it; the $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ / $\mathfrak u(4)$ pair is exhibited, so the universal claim is dead |
| 7 | a split with $q\ge p\ge3$, $n\le7$, satisfying $(p-2)(q-3)<2$ and unlisted | over $q\ge p\ge3$ the criterion admits only $(3,3)$ and $(3,4)$, by the two-case argument above; the lattice is finite and closed by the factorisation, not by enumeration |

For the two graded PLAUSIBLE I looked the other way as well. **Item 2**: I tried to save the repair by putting the corner's $\mathop{\mathrm{tr}}S^3$ below $1/\sqrt{12}$, which would let the second edge exclude it, but that contradicts the strike's own $(\mathop{\mathrm{tr}}S^3)^2=\tfrac1{12}$, and the flat spectrum realises both edges with equality, so no placement of the corner rescues the sentence. **Item 4**: I looked for a reading of "unbalanced sphere pair" that admits $a=1$ and found only the formal one; under the pair's-own-$\theta$ reading the witness overshoots ($\theta_{1,8}=0$), so the sentence survives its own witness. The strike's conclusion is nonetheless right, by $S^2\times S^9$ at $n=11$ and $S^3\times S^9$ at $n=12$.
