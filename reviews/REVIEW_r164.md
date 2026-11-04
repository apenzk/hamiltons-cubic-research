# Gate 2, Reviewer r164: the sign resolution, the 1.8% figure, the folded corrections, and the padded-$W_{\mathbb{CP}^2}$ contradiction

**Verdict.** Commit `82a93ac` is wrong in both halves of its resolution, and the record's own numbers refute it without any new computation. $C$ is **positive** at $S^6\times S^6$, the script is right, and the tight-at-extremum loss is $1.45\times$, reviewers 159 and 160's figure, overruled. Independently: [second-order.md](../findings/second-order.md)'s "padded $W_{\mathbb{CP}^2}$ is not critical at $n=6,7$" is refuted from the definitions, so RESULT 1 stands and the gap theorem's $n\ge12$ escape hatch is closed.

*Note on timing.* Commit `d91c389` landed during this review and folds the same inversion from another reviewer. Everything in Claim 1 below was derived before reading it, and by a different route, I fix the convention from the round sphere and from the record's own $S^3\times S^9$ datum. **Section "What is still owed" lists the four places the section still carries the withdrawn sign.**

| claim | verdict |
| --- | --- |
| 1a. $C=40\mathop{\mathrm{tr}}(W^3)-8\langle W^{\#},W\rangle$, negative at $S^6\times S^6$ | **REFUTED.** $C=-40\mathop{\mathrm{tr}}(W^3)+8\langle W^{\#},W\rangle=+8.8095$, and $\theta=6\mathop{\mathrm{tr}}(W^3)+\tfrac18C$ |
| 1b. "$\theta=6\mathop{\mathrm{tr}}(W^3)-\tfrac18C$ reproduces $\theta$ **with the negative $C$**, so the identity and the coefficients are confirmed" | **VACUOUS.** A rearrangement of the definition of $C$; it holds for either sign and never evaluates $C$ |
| 1c. "the script returns $+\lvert C\rvert$ … the fault is isolated to the eigen-decomposition step" | **REFUTED by the record's own $S^3\times S^9$ row**, where the script returns a **negative** number |
| 1d. "the factor of $5$ follows from $C$'s sign" | **REFUTED**, and the wrong side was adopted. Correct: $1.79781$ at $S^6\times S^6$, $2.66678$ at $S^5\times S^7$ |
| 2. the $1.8\%$ figure | reading correct, support inadequate, [fence-posts.md](../findings/fence-posts.md) already proves it as an identity |
| 3. the four corrections folded from r161/r162 | **all four confirmed independently**, one with a stronger reason than the record's |
| (b) padded $W_{\mathbb{CP}^2}$ at $n=6,7$ | **RESULT 1 is right.** Padding preserves criticality with residual exactly $0$, at every $n$ |

---

## Setup, the definitions everything below is argued from

$Q(W)=W^2+W^{\#}$, $P(W)=\langle Q(W),W\rangle$, criticality is $Q(W)=\theta W$ at $\lVert W\rVert=1$ with $\theta=P(W)$. **$\theta=\mathop{\mathrm{tr}}(W^3)+\langle W^{\#},W\rangle$ with no factor**, and the record's own row closes it: $0.022473+1.213560=1.236033$. *That answers the brief's third bullet.*

For the two-block product, in the record's $\theta>0$ convention, the vertex matrix is $M_{ij}=+q/(p-1)$ inside the first block, $+p/(q-1)$ inside the second, $-1$ across, $M_{ii}=0$; then $\mathop{\mathrm{tr}}(W^3)=\sum_{i<j}M_{ij}^3/s^3$ and $\langle W^{\#},W\rangle=\tfrac12\mathop{\mathrm{tr}}(M^3)/s^3$ with $s=\lVert M\rVert$. At $(6,6)$: $s^2=79.2$, $\sum_{i<j}M^3=15.84$, $\mathop{\mathrm{tr}}(M^3)=1710.72$, giving $0.0224736$ and $1.2135606$, the record's two columns to seven digits. **The $\Lambda^2$ picture and the $(0,4)$ picture the coefficients were derived in carry the same normalisation, so the brief's first bullet finds no discrepancy there.**

## CLAIM 1, the resolution is inverted, and the record refutes it twice over

### 1b. The confirmation is a tautology

$C$ is *defined* in the resolution's own table as $40\mathop{\mathrm{tr}}(W^3)-8\langle W^{\#},W\rangle$. Substituting:

$$6\mathop{\mathrm{tr}}(W^3)-\tfrac18\big(40\mathop{\mathrm{tr}}(W^3)-8\langle W^{\#},W\rangle\big)=6\mathop{\mathrm{tr}}-5\mathop{\mathrm{tr}}+\langle W^{\#},W\rangle=\theta .$$

**An identity in two variables, true before any point is evaluated.** For $C=a\mathop{\mathrm{tr}}(W^3)+b\langle W^{\#},W\rangle$ the pair in $\theta=\alpha\mathop{\mathrm{tr}}(W^3)+\beta C$ is forced to $\big(1-\tfrac ab,\tfrac1b\big)$, which at $(40,-8)$ is exactly $(6,-\tfrac18)$ and at $(-40,+8)$ is exactly $(6,+\tfrac18)$. **Both sign packages reproduce $\theta$ to machine precision**, because neither ever touches $C=\sum_j\mu_j\lvert S^jW\rvert^2$, the one definition under suspicion. The check confirms neither the coefficients, nor the identity, nor the sign.

### 1c. The record's own $S^3\times S^9$ row refutes "the script returns $+\lvert C\rvert$"

Two paragraphs below the resolution the same file records *"[run_second_kind_cubic.py](../scripts/runs/run_second_kind_cubic.py) reproduces $C(S^3\times S^9)=-4.19351$ … a **sign change** across the family."* At $(3,9)$, $n=12$: $s^2=92.8125$, $\sum_{i<j}M^3=248.2734$, $\mathop{\mathrm{tr}}(M^3)=1545.328$, so $\mathop{\mathrm{tr}}(W^3)=0.277663$, $\langle W^{\#},W\rangle=0.864135$, and $\theta=1.141798$, matching $\theta_0(3,9)=\sqrt{352/270}$ to six digits. Then

$$-40\mathop{\mathrm{tr}}(W^3)+8\langle W^{\#},W\rangle=-11.10652+6.91308=\mathbf{-4.19344},$$

against the script's $-4.19351$; and at $S^6\times S^6$ the same expression gives $-0.89892+9.70848=\mathbf{+8.80956}$ against the script's $+8.809545$. **The script matches $C=-40\mathop{\mathrm{tr}}(W^3)+8\langle W^{\#},W\rangle$ in sign and magnitude at both points, including across the sign change.** A uniform "$+\lvert C\rvert$" flip is impossible: it would require the script to return $+4.19$ at $S^3\times S^9$, and the record says it returns $-4.19$. *The refutation needs no convention argument and no new evaluation, only the two rows the same section already carries.*

### 1a. The convention, pinned from the round sphere

The remaining question is which sign of the second-kind operator the coefficients belong to, and that is fixed by the model case. With $\mathring R(\varphi)_{ij}=R_{ikjl}\varphi_{kl}$ and $R_{ikki}=K(e_i,e_k)$, the unit round sphere has $R_{ikjl}=g_{il}g_{kj}-g_{ij}g_{kl}$, so

$$\mathring R(\varphi)_{ij}=\varphi_{ij}-g_{ij}\mathop{\mathrm{tr}}\varphi=\varphi_{ij}\ \text{ on }S^2_0,\qquad \mathring R_{S^n}=+\mathrm{Id}.$$

**That is the convention Cheng–Wang's hypothesis needs**: their cone condition is $\lambda_1+\lambda_2\ge0$, which the model case must satisfy, and the record's own shift construction takes $R_1$ with $\mathring R_1=\mathrm{Id}$.

Under it, for a coordinate-diagonal $W$ the second-kind eigenvectors are the off-diagonal symmetric $E_{pq}$ with eigenvalue $+M_{pq}$, and the traceless diagonals carrying $-M$ restricted to $\mathbf 1^{\perp}$, $\binom n2+(n-1)=N$ in all. *Check: all $M_{ij}=1$ gives $+1$ off-diagonal and $-(J-I)|_{\mathbf1^\perp}=+1$ diagonal, recovering $\mathring R=+\mathrm{Id}$.* At $S^6\times S^6$, $M=A\otimes J_6-\tfrac65I$ with $A=\big(\begin{smallmatrix}6/5&-1\\-1&6/5\end{smallmatrix}\big)$ has spectrum $0,12,(-\tfrac65)^{10}$, so the unnormalised second-kind spectrum is

$$\big(+\tfrac65\big)^{40},\quad(-1)^{36},\quad(-12)^1\qquad(77\ \text{values, summing to }0).$$

With the record's own weights $\lvert E_{pq}W\rvert^2=4\sum_{x\ne p,q}(M_{px}+M_{qx})^2$ and $\lvert DW\rvert^2=16\,d^{\mathsf T}(\mathop{\mathrm{diag}}(r)+A)d$, $47.04$ per within-block plane, $0.4$ per cross plane, $230.4$ and $10\times188.16$ on the two diagonal eigenspaces, the weighted sum is

$$s^3C=4\big[30(1.2)(47.04)+36(-1)(0.4)\big]+\big[(-12)(230.4)+(1.2)(1881.6)\big]=6716.16-506.88=6209.28,$$

which is exactly $-40\sum_{i<j}M^3+8\cdot\tfrac12\mathop{\mathrm{tr}}(M^3)=-633.6+6842.88$. **Hence $C(S^6\times S^6)=+8.8093$ and $\theta=6\mathop{\mathrm{tr}}(W^3)+\tfrac18C$.** *Three routes agree: the closed form, the diagonal form, and the eigenvalue-weighted sum.*

*And [nondegeneracy.md](../findings/nondegeneracy.md) mis-reports reviewer 160.* The recorded fit, "slopes $-48.00000$, intercepts $8.00000$", is the coefficient pair of $C$ in the basis $(\mathop{\mathrm{tr}}(W^3),\theta)$, since $\theta=6\mathop{\mathrm{tr}}+\tfrac18C$ inverts to $C=8\theta-48\mathop{\mathrm{tr}}(W^3)$. It reproduces all three of the record's rows: $8(1.236033)-48(0.022473)=8.8096$, $8(1.228239)-48(0.042802)=7.7714$, $8(1.201561)-48(0.113394)=4.1696$. **So 160 measured the correct $C$ and 159's derived sign is the inverted one**, the two did not independently agree, and presenting them as agreeing is what let the inversion stand.

### 1d. The factor of $5$ is the wrong tail of the spectrum, and the correct bound is $1.798$

$\theta=6\mathop{\mathrm{tr}}(W^3)+\tfrac18C$ has a **positive** coefficient on $C$, so bounding $\theta$ above needs $C$ bounded **above**, reviewer 158's free upgrade $C\le\tfrac{\mu_{N-1}+\mu_N}2T$, which that reviewer already called *"the side that could ever bound $\theta$"*. The two largest second-kind eigenvalues at $S^6\times S^6$ are both $+\tfrac65/s$, so with $T=\sum_j\lvert S^jW\rvert^2=98.667$:

$$\theta\ \le\ 6\mathop{\mathrm{tr}}(W^3)+\tfrac18\cdot\tfrac{1.2}{s}\,T\ =\ 0.134838+\tfrac{13.3038}8\ =\ \mathbf{1.79781},\qquad\text{loss }1.4545\times .$$

At $S^5\times S^7$ the two largest are $+1.75/s$ twice, giving $0.256812+\tfrac{19.2797}8=\mathbf{2.66678}$, loss $2.1712\times$. **The recorded $9.142899$ and $9.208072$ come from the *bottom* pair $\{-12,-1\}$ fed into the negated identity**: $-\tfrac{13}2/s\cdot T=-72.0645$ gives $0.134838+9.00807=9.14291$, and $-\tfrac{13}2/8.9559\cdot T=-71.610$ gives $0.256812+8.95124=9.20805$. Both recorded figures reproduced to five digits under one hypothesis, the wrong tail with the wrong-signed identity. *So the factor of $5.09$ is not $C$'s sign: flipping $C$ turns $1.798$ into $-1.528$, not into $9.143$.*

*The convention on $T$ is worth stating because the bound depends on it.* $T=98.667=4\kappa$ with $\kappa=2(n^2+n-8)/n=24.667$, so the record's $\kappa$ is quoted against $\lvert W\rvert^2_{(0,4)}=4\lVert W\rVert^2_{\Lambda^2}$. This is forced, not chosen: an upper bound must exceed $\theta$, and $T=\kappa$ would give $0.5506<1.236033$. The sentence *"the absence of a factor on $S$"* is the one place the record leaves it unsaid.

**What survives.** *Loose at the conjectured maximiser* survives, $1.798$ against $1.236033$ is still $1.45\times$, so item 3a's margin $0$ and its grade $0$ are untouched. Only the size of the loss changes, by $5.09\times$.

## CLAIM 2, the reading is right, and the record already proves it in closed form

**One $n$ cannot support an asymptotic claim, and none is needed.** At $S^m\times S^m$, $n=2m$: $\sum_{i<j}M^3=m^2(2m-1)/(m-1)^2$ and $\lVert M\rVert^2=m^2(2m-1)/(m-1)$, so

$$\mathop{\mathrm{tr}}(W^3)=\frac1{m\sqrt{(m-1)(2m-1)}},\qquad \theta_0(n)=\frac{\sqrt{(m-1)(2m-1)}}m,\qquad \frac{\mathop{\mathrm{tr}}(W^3)}{\theta_0}=\frac1{(m-1)(2m-1)}=\frac2{(n-1)(n-2)} .$$

At $m=6$ the first is $1/(6\sqrt{55})=0.0224736$, the record's $0.022473$, and the ratio is $2/110=1.8182\%$, decaying like $2/n^2$.

**And it was already on the record, stronger.** [fence-posts.md](../findings/fence-posts.md) post F1 carries *"$\mathop{\mathrm{tr}}(W^3)/P=\frac2{(n-1)(n-2)}$ at $S^{n/2}\times S^{n/2}$, proved as an identity rather than scanned."* The commit presents the same content as a measurement at the one $n$ where the identity was already available. *That is question (a)'s clearest instance.* `d91c389` has since boxed the identity into [nondegeneracy.md](../findings/nondegeneracy.md) without citing the fence post that held it.

## CLAIM 3, the four folded corrections, each verified independently

**(i) $\dim E(\tfrac12)=pq$ except at $(3,3)$, CONFIRMED.** From $\mu=\frac{n-2}{2(p-1)(q-1)}$ and $\lambda_m=\frac{m-2}{2(m-1)}$: $\lambda_m=\tfrac12$ needs $m-2=m-1$, never; $-\mu=\tfrac12$ needs $\mu<0$, never for $n>2$; $+\mu=\tfrac12\iff(p-1)(q-1)=p+q-2\iff pq-2p-2q+3=0\iff(p-2)(q-2)=1$, whose only solution with $p,q\ge3$ is $p=q=3$. **Checked against an independently known spectrum:** at $(3,3)$ the ten summands give $1^1,(\tfrac12)^{9+9},(\tfrac14)^{10},(-\tfrac12)^{25},0^{30}$, summing to $84=\dim\mathrm{Weyl}_6$, character-for-character the Peirce spectrum [second-order.md](../findings/second-order.md) records there. At $(6,6)$: $\mu=\tfrac15$, $\lambda_6=\tfrac25$, both $<\tfrac12$, so $\dim E(\tfrac12)=36=\dim\mathcal O=66-2\cdot15$: **excess $0$**. And $\ker\mathrm{Hess}|_{W^{\perp}}=E(\tfrac12)\cap W^{\perp}$ follows from $\tfrac{d^2}{dt^2}P(W+tv)=6\theta\langle L_ev,v\rangle$ against the multiplier $\tfrac{3\theta}2$, so this is Hessian excess in the plan's sense.

**(ii) $\lambda_{\max}=1$ was the eigenvalue on $e$, CONFIRMED, in one line.** $Q(e)=Q(W)/\theta^2=e$, and $e\circ e=Q(e)$ since $Q$ is homogeneous quadratic, so $L_ee=e$ at **every** critical point with $e\parallel W\notin W^{\perp}$. Lemma L24 bounds $L_e|_{W^{\perp}}$, where the largest value at $(3,3)$ is $+\mu=\tfrac12$: **Lemma L24 holds with equality**, nothing is violated.

**(iii) Excess $0$ does not imply graded, CONFIRMED, and the witness is sound.** Padded $W_{\mathbb{CP}^2}$ is ungraded at every $n>4$ by $S_{\mathfrak{hhm}}=4(n-4)$, and its isotropy $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$ gives $\dim\mathcal O=\binom n2-4-\binom{n-4}2$, i.e. $10$ at $n=6$ and $18$ at $n=8$, **exactly RESULT 1's two numbers, recovered from the isotropy without measurement.** *A transcription defect, not a defect in the correction:* [second-order.md](../findings/second-order.md) states the nondegeneracy at $n=8,10,12$ with the single parenthetical $\dim E(\tfrac12)=\dim(\text{orbit})=18$, while the orbit is $18,26,34$ there.

**(iv) A lower bound on $\mathrm{mult}(\tfrac12)$ is equivalent to Conjecture A, CONFIRMED as quoted, and the true obstruction is stronger.** $\mathop{\mathrm{tr}}(L_e^2)=\kappa_n/\theta^2$ at every critical point, so a counterexample is *exactly* $\mathop{\mathrm{tr}}(L_e^2)<R(n)=\kappa_n/\theta_0(n)^2$, and excluding it needs $\mathop{\mathrm{tr}}(L_e^2)\ge R(n)$. From $\mathrm{mult}(\tfrac12)\ge m$ alone one gets only $\mathop{\mathrm{tr}}(L_e^2)\ge1+\tfrac m4$. At $n=12$ the ten-summand spectrum gives $R(12)=1+9+6.4+9+16=41.4$, so $m\ge162$ would be needed, while the conjectured maximiser has $\mathrm{mult}(\tfrac12)=36$, and even the largest conceivable orbit $\binom{12}2=66$ yields $17.5$. **So an unconditional lower bound of the required strength is not merely circular, it is false at the maximiser**; only the conditional form is as hard as Conjecture A. r161's and r162's conclusion is right with more room under it than they claimed.

## Questions

### (b), the contradiction, adjudicated: RESULT 1 is right

**Padding preserves criticality exactly, at every $n$, from the definitions.**

1. $\mathrm{pad}(W)_{ijkl}=W_{ijkl}$ inside the block and $0$ outside satisfies the first Bianchi identity componentwise, and $\mathrm{Ric}(\mathrm{pad}\,W)_{ij}=\sum_k\mathrm{pad}(W)_{ikjk}$ is $\mathrm{Ric}(W)_{ij}=0$ inside and $0$ outside. **So $\mathrm{pad}(W)\in\mathrm{Weyl}_n$ already**, there is no projection left to perform on it.
2. $W^2$ preserves the block, since $W$ annihilates its orthogonal complement in $\Lambda^2$.
3. $W^{\#}$ is built from the bracket on $\Lambda^2\cong\mathfrak{so}(n)$, and $\mathfrak{so}(n_0)$ is a **subalgebra**, so $[W\!\cdot,W\!\cdot]$ lands back in the block: $Q_n(\mathrm{pad}\,W)=\mathrm{pad}\,Q_{n_0}(W)$. *This is why the record's measured $\max\lvert Q_n(\mathrm{pad}\,W)-\mathrm{pad}\,Q_{n_0}(W)\rvert=0.0$ is exact rather than small.*
4. Padding is an isometry, so $P(\mathrm{pad}\,W)=\theta$ and $Q(W)=\theta W\Rightarrow Q_n(\mathrm{pad}\,W)=\theta\,\mathrm{pad}\,W$, **residual exactly $0$.**

$W_{\mathbb{CP}^2}$ is critical in its native $n_0=4$: $P=9(\det W^++\det W^-)$ with $W^+$ spectrum $(2,-1,-1)/\sqrt6$ gives $9\cdot2/6^{3/2}=\sqrt{3/2}$. **So its padding is critical at every $n\ge4$ with $\theta=\sqrt{3/2}$ frozen, and RESULT 1's $n=6$ entry is correct.**

**The competing claim is self-refuting besides.** The same sentence grants criticality at $n=5$ to $3\times10^{-16}$; padding $4\to6$ factors as $4\to5\to6$ and is the same operation at each step, so "critical at $n=5$, residual $2\times10^{-1}$ at $n=6$" cannot both hold whatever the construction. **The tell is "then-projected"**, the padded operator is already in $\mathrm{Weyl}_n$, so a residual of $0.2$ means the projected object was not $\mathrm{pad}(W_{\mathbb{CP}^2})$, most plausibly a padded *full* curvature tensor whose Weyl part in dimension $n$ differs from its Weyl part in dimension $4$.

**Four other places in the record compute the padded point at exactly $n=6$ or $n=7$ and find it well-behaved**: the closed form $S_{\mathfrak{hhm}}=4(n-4)$ *"verified at $n=4,\dots,9$"*; the grading-test control *"padded $W_{\mathbb{CP}^2}$ must be ungraded at $\theta=\sqrt{3/2}$ with $S_{\mathfrak{hhm}}=8$, $\dim\mathfrak m=2$"*, which is $n=6$; the $\sigma$-cone sweep, which lists it as a **known critical point** inside $\sigma(2,4)$ and $J$ at $n=6$ that no random start reached; and the two-negative-eigenvalue stratum maximisation, which returns it at $n=6$ by spectrum.

**Consequence, and it is not neutral.** The parenthetical's only job was *"so the witness stands at $n=5$ alone"*, which is what makes *"the target survives only if restricted to $n\ge12$"* read as a live repair for the falsified gap theorem. With padding critical at every $n$, the ungraded witness at $\lambda_{\max}=\tfrac12$ exists above $n=5$, [target.md](../findings/target.md) tabulates padded $\mathbb{CP}^2$ at $n=8$ with $\lambda_{\max}$ off $e$ $=0.50000000$ and excess $0$, and RESULT 1 adds $n=6,10$. **So the $n\ge12$ restriction is not a repair the record can take, and the gap theorem is closed harder than plan.md's banner records.** Nothing else folded today depends on the $n=6$ entry: 3b's retirement uses RESULT 1 at $n=6,8,10$, and it stands at all three.

### (a), asserted as new, already held

| asserted in `82a93ac` | already on the record |
| --- | --- |
| $\mathop{\mathrm{tr}}(W^3)$ is $1.8\%$ of $\theta$ at the maximiser, "the bottleneck as a measurement" | [fence-posts.md](../findings/fence-posts.md) post F1, as the proved identity $2/\big((n-1)(n-2)\big)$ |
| $\langle W^{\#},W\rangle$ carries the rest, through alignment rather than spectrum | [problem.md](../findings/problem.md) item 5, and the same fence post |
| that a sign convention differs between the $C$ column and the $\theta$ column | stated in the paragraph directly below the new table, and under *"The sign of $W$ is part of the definition of $S$"* |
| that the upper bound on $C$ is the operative side | reviewer 158's free upgrade, *"this is the side that could ever bound $\theta$"*, which `82a93ac` overturned and `d91c389` restored |

### (c), item 2's grade $0$, and two stale table rows

**Defensible, and after this review more so than its stated ground.** `attackable = 0` reads *"every named route closed"*: the excess/tangency lever (r161, r162, both halves confirmed above), Euler–Jacobi, the moment method (closed harder than recorded, per Claim 3(iv)), and the gap theorem. **The gap theorem is the one closed on a wrong reason**, "falsified at $n=5$" with an $n\ge12$ escape hatch kept open by the $n=6,7$ non-criticality claim. That hatch is now shut, so the route is closed more firmly, not less. *No route in item 2 is closed on a wrong reason in the direction that would change the grade.*

**Two rows are stale rather than wrong.** The `3b` row still gives its `closes = 0` as *"Morse–Bott nondegeneracy gives the component structure at $W_{\mathbb{CP}^2}$ directly"*, which plan.md's own 3b body and both r161 and r162 record as refuted, that point being ungraded; the retirement stands on Łojasiewicz finiteness. And the `3a` row's *"loose at the extremiser"* is right while the loss behind it is $1.45\times$, not $7.40\times$.

## What is still owed after `d91c389`

The inversion is folded, but the same section now carries both signs:

1. **The boxed identity above the fold still reads $\theta=6\mathop{\mathrm{tr}}(W^3)-\tfrac18C$ with $C=40\mathop{\mathrm{tr}}(W^3)-8\langle W^{\#},W\rangle$.** It contradicts the corrected box eight paragraphs below.
2. **"The operative side is the LOWER bound, not the upper" still stands**, with *"The record briefly had this backwards"* attached to the reading that is now correct. Reviewer 158's free upgrade is the operative side.
3. **The tight-at-extremum table still reads $9.142899$ / $7.397\times$ and $9.208072$ / $7.497\times$**, directly above the paragraph withdrawing them. The corrected entries are $\mathbf{1.79781}$ / $1.4545\times$ and $\mathbf{2.66678}$ / $2.1712\times$ (*the second row's corrected value is not yet anywhere on the record*) and the column head should read $6\mathop{\mathrm{tr}}(W^3)+\tfrac18\cdot\tfrac{\mu_{N-1}+\mu_N}2T$.
4. **The attribution "159 and 160, independently" is what allowed the inversion to stand.** 160's $(-48,+8)$ is the corrected $C$; 159's derivation is the inverted one. As written the record says two reviewers agreed where they disagreed.
5. **State the norm convention on $\lvert S^jW\rvert$.** $T=4\kappa$ at $\lVert W\rVert_{\Lambda^2}=1$; *"the absence of a factor on $S$"* reads as denying exactly this, and the bound is wrong by $4\times$ without it.
6. **Delete the $n=6,7$ non-criticality parenthetical from [second-order.md](../findings/second-order.md)**, replacing it with the padding lemma, and drop the $n\ge12$ restriction as a route for the gap theorem.
7. **Credit [fence-posts.md](../findings/fence-posts.md) post F1** at the newly boxed cubic ratio, and fix the "$=18$" orbit figure at $n=8,10,12$.
8. **Repoint the `3b` table row** to Łojasiewicz finiteness, matching plan.md's own body.

## Method note

Every number above is an evaluation of a formula the record already proves, at a point it already names; the only construction was reading $\mathring R$ off its definition for a two-block product, four lines. **The decisive refutation needed even less: the record's own $S^3\times S^9$ row says the script returns a negative number, which no uniform "$+\lvert C\rvert$" flip permits.** That row sits two paragraphs below the commit that claims the flip. As with r161's finding on $\dim E(\tfrac12)$, the failure is a search failure, and the shape recurs: a claim checked against a rearrangement of its own definition reads as confirmed at any precision, so the check must evaluate the disputed object or it is not a check.
