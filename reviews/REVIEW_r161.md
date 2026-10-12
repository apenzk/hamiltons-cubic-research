# Gate 2, Reviewer 161

Cold adversarial review of [plan.md](../plan.md) items 2 and 3b, the commits `52e9752`, `93282be`, `9133538`, `af411c9`, `3b594ff`, and the half-eigenspace count they turn on. Argued from the record's own definitions; the one place a number appears, it is a number the record already carries.

| claim | verdict |
| --- | --- |
| 1. `dim E(1/2) = 18 = 2pq` at $S^3\times S^3$ refutes the record's $pq$, and $\lambda_{\max}=1$ violates Lemma L24 | **REFUTED.** The arithmetic is right and was already on the record in four places; every inference drawn from it is wrong. |
| 2. Lemma L24 $+$ tangency $\Rightarrow\lambda_{\max}=\tfrac12$ at a maximiser, so (G) reduces to excess $0$ | **the equality is sound and not new; the reduction is a non sequitur**, refuted by a point on the record |
| 3. 3b retires because Morse–Bott nondegeneracy at $W_{\mathbb{CP}^2}$ gives the component structure | **conclusion right, stated reason wrong**, the point it names is ungraded |

## CLAIM 1, the operator is right, the number is right, and the record already held both

### $L_e$ as built matches the record's definition exactly

[second-order.md](../findings/second-order.md) defines $X\circ Y:=\tfrac12\big(Q(X+Y)-Q(X)-Q(Y)\big)$ and $L_e=e\circ(\cdot)$, with $Q(W)=W^2+W^{\#}$ from [README.md](../README.md). Since $Q$ is homogeneous quadratic, $X\circ X=Q(X)$, and splitting $Q$ into its two summands gives

$$e\circ H=\tfrac12(eH+He)+\tfrac12\big((e+H)^{\#}-e^{\#}-H^{\#}\big),$$

which is the built operator provided the symbol $e\#H$ carries the $\tfrac12$ of the polarisation. It does: the alternative convention $X\times Y=(X+Y)^{\#}-X^{\#}-Y^{\#}$, under which $X\times X=2X^{\#}$, would break the idempotency $L_e(e)=Q(W)/\theta^2=e$ and could not produce a clean eigenvalue $1$. **The convention mismatch the brief was hunting for is not there**, and the confirmation is independent of any code: the built operator reproduces $18$, which is what the record's closed-form spectrum predicts at $(3,3)$ and nowhere else.

The basis is right too. $\dim\mathrm{Weyl}_n=n(n+1)(n+2)(n-3)/12$ gives $84$ at $n=6$, and $\dim\mathrm{Sym}^2(\Lambda^2\mathbb R^6)=120$, so projecting $120$ elementary symmetric matrices and taking the SVD range at rank $84$ is the correct construction.

### The record does not say $\dim E(\tfrac12)=pq$ at $S^3\times S^3$, it proves the opposite, in closed form

[fence-posts.md](../findings/fence-posts.md) states the claim with its exception attached: *"for $p,q\ge3$, every $S^p\times S^q$ other than $S^3\times S^3$ is Morse–Bott nondegenerate, $\dim E(\tfrac12)=pq$, and the exception is the identity $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ with $(p-2)(q-2)=1$ forcing $p=q=3$."* The same file gives the full rational spectrum: with $s_m=(m+2)(m-1)/2$, $c_m=m(m-1)/2$ and

$$\mu(p,q)=\frac{n-2}{2(p-1)(q-1)},$$

the eigenvalues are $-\mu$ at multiplicity $s_ps_q$, $+\mu$ at $c_pc_q$, $\lambda_m=\frac{m-2}{2(m-1)}$ at $s_m$ for $m=p,q$, then $\tfrac12$ at $pq$ and $1$ simple.

**So $\dim E(\tfrac12)$ is decidable from that list with no computation.** Three ways to reach $\tfrac12$ beyond the orbit block: $-\mu=\tfrac12$ is impossible since $\mu>0$; $\lambda_m=\tfrac12$ needs $m-2=m-1$ and never happens; $+\mu=\tfrac12$ needs $(p-2)(q-2)=1$, i.e. $p=q=3$. Hence

$$\dim E(\tfrac12)=pq+c_pc_q\cdot[\,(p,q)=(3,3)\,],$$

and at $(3,3)$ that is $9+3\cdot3=18$. **The measured $18$ is the record's own prediction.**

### "$2pq$" is a coincidence of the single point it was read at

$c_pc_q=\tfrac14p(p-1)q(q-1)$ equals $pq$ exactly when $(p-1)(q-1)=4$, at $p=q=3$ and nowhere else with $p,q\ge3$. So $18=2\cdot9$ is $pq+c_pc_q$ evaluated where the two summands happen to agree, and reading it as a law $2pq$ is [the record's own named failure mode](../plan.md): a value read off one symmetric point and stated generally. The commit message `52e9752` asserts *"the record's $\dim E(\tfrac12)=pq$ is wrong and the measured value is $2pq$"*; both halves fail.

### $\lambda_{\max}=1.0000000$ is the undeflated maximum, and it carries no information

At **every** critical point with $\theta>0$, $L_e(e)=e\circ e=Q(e)=Q(W)/\theta^2=W/\theta=e$. So $1\in\mathrm{spec}(L_e)$ identically (the record's spectrum table lists $1^1$ at every split) and $e\parallel W$ lies outside $W^{\perp}$. Lemma L24 bounds $\lambda_{\max}(L_e|_{W^{\perp}})$, so a full-space maximum of $1$ is the tautology, present at $S^6\times S^6$ and at any maximiser alike.

**The deflated value at $S^3\times S^3$ is on the record and it is $\tfrac12$.** [target.md](../findings/target.md) tabulates the point under the column $\lambda_{\max}$ off $e$ at $0.50000000$, alongside $\dim E(\tfrac12)=18$, orbit $9$, excess $\mathbf 9$, the same three numbers `52e9752` reports as new. From the spectrum above the value is forced anyway: on $W^{\perp}$ the eigenvalues at $(3,3)$ are $-\tfrac12$, $0$, $\tfrac14$ and $\tfrac12$, so $\lambda_{\max}(L_e|_{W^{\perp}})=\tfrac12$ **exactly**. Lemma L24 is satisfied, with equality.

The consequence is that the plan's *"one reading that is consistent"* is not consistent. It reads $\lambda_{\max}=1$ as a Lemma L24 violation corroborating the record's *"degenerate saddle, not a local maximum"*. The record's reason for that phrase is third order, not second: [nondegeneracy.md](../findings/nondegeneracy.md) says *"zero positive Hessian directions, but $\theta$ takes both signs at cubic order on the $9$ null directions transverse to the orbit"*, which agrees with $\lambda_{\max}=\tfrac12$ and is incompatible with $\lambda_{\max}>\tfrac12$, since $c=6\lambda-3$ would then give a positive Hessian direction. **The corroboration runs backwards: the reported $1$ contradicts the statement it is offered as confirming.**

### What follows at $n=12$, derived rather than measured

At $S^6\times S^6$, $\mu(6,6)=\frac{10}{2\cdot5\cdot5}=\tfrac15<\tfrac12$ and $(p-2)(q-2)=16\ne1$, so no summand outside the orbit block reaches $\tfrac12$:

$$\dim E(\tfrac12)\big(S^6\times S^6,\ n=12\big)=pq=36=\dim\mathcal O,\qquad \textbf{Hessian excess }=0 .$$

The plan says *"nothing on the record gives the Hessian excess of the conjectured maximiser $S^6\times S^6$ at $n=12$, which is the number that decides the route."* [fence-posts.md](../findings/fence-posts.md) gives it: the $n=12$ row reads *"all five two-block splits, all nondegenerate, $20,27,32,35,36$ matching $pq$ exactly"*, and $36$ is the balanced split. **The number that was said to decide the route was already tabulated, and it is excess $0$, the opposite of the extrapolated $36$.**

## CLAIM 2, the equality holds and is not new; the reduction to excess $0$ does not follow

**The tangency identity is correct.** $Q$ is $O(n)$-equivariant and quadratic, so $DQ_W(H)=2W\circ H$ and differentiating $Q(gW)=gQ(W)$ at $g=I$ along $X\in\mathfrak{so}(n)$ gives $2W\circ(X\cdot W)=X\cdot Q(W)=\theta(X\cdot W)$, i.e. $L_e(X\cdot W)=\tfrac12(X\cdot W)$. Orbit directions lie in $W^{\perp}$ because the action is orthogonal, so they are tangent to the sphere. Combined with Lemma L24, $\lambda_{\max}(L_e|_{W^{\perp}})=\tfrac12$ at a maximiser. **The operator is the same one in both halves** (Lemma L24 is stated for $L_e|_{W^\perp}$ and the tangency eigenvector sits in $W^\perp$) so the brief's convention worry does not apply here either.

**It is not new.** [target.md](../findings/target.md) already records it as a theorem, attributed to Reviewer 71: *"differentiating $Q(W_t)=\theta W_t$ along an orbit gives $e\circ\dot W=\tfrac12\dot W$, so every orbit tangent lies in $E(\tfrac12)$."* The only unrecorded step is the one-line conjunction with Lemma L24.

**The reduction is where it breaks.** "(G) reduces to: does a maximiser have excess $0$?" requires excess $0$ to deliver gradedness. It does not, and the record carries the counterexample: padded $W_{\mathbb{CP}^2}$ is **ungraded**, [nondegeneracy.md](../findings/nondegeneracy.md) gives $S_{\mathfrak{hhm}}=4(n-4)$ exactly, nonzero at every $n>4$, while [target.md](../findings/target.md) tabulates it at $\lambda_{\max}$ off $e$ $=0.50000000$, $\dim E(\tfrac12)=18=$ orbit, **excess $0$**. So $\{\text{excess }0\}\cap\{\lambda_{\max}=\tfrac12\}$ already contains ungraded critical points, and proving a maximiser sits in that set proves nothing about (G). Padded $\mathbb{HP}^2$, which the same file records as saturating Lemma L24 at every $n\ge8$, is a second such point.

**And the strengthening was already closed.** [target.md](../findings/target.md) carries the heading *"The $E(\tfrac12)$ multiplicity does NOT refine the discriminator, only $\lambda_{\max}\le\tfrac12$ does"*, with the table showing excess $0$ on both sides of the discriminator and the conclusion *"any attempt to strengthen it through the $\tfrac12$-eigenspace's dimension is closed."* [second-order.md](../findings/second-order.md) independently records that *"what the method would need is a lower bound on $\mathrm{mult}(\tfrac12)$, which is equivalent to Conjecture A itself"*, so the quantity item 2 proposes to determine is recorded as circular, and item 2 quotes that sentence while reading it as encouragement.

**What survives.** $\lambda_{\max}(L_e|_{W^{\perp}})=\tfrac12$ at a maximiser is a genuine equality and it is worth writing into [second-order.md](../findings/second-order.md). Its use is the contrapositive: any critical point with $\lambda_{\max}>\tfrac12$ is excluded as a maximiser, which is Lemma L24 as already used. The excess route on top of it is dead in both directions.

## CLAIM 3, 3b's retirement stands, on a different support than the one written

The attainment argument in [fence-posts.md](../findings/fence-posts.md) needs the ungraded part of the compact set $\{\theta\ge t\}\cap\mathrm{Crit}(P)$ to be compact, which needs the graded part **open** in $\mathrm{Crit}(P)$. A union of isolated orbits is open whether or not the union is closed, so closedness is genuinely off the critical path, and [nondegeneracy.md](../findings/nondegeneracy.md) already says so: *"closedness may not be on the critical path at all: the compactness step needs only $G$ open."* 3b's retirement is right, and the reason predates the commit that gives it.

**The stated support is the wrong point.** `3b594ff` retires 3b on RESULT 1, which is about padded $W_{\mathbb{CP}^2}$, a point the record proves **ungraded** by $S_{\mathfrak{hhm}}=4(n-4)$. Its isolation says nothing about the graded set being open. What actually supports openness is the graded nondegeneracy table at $n=8,10,12$ in [fence-posts.md](../findings/fence-posts.md), which covers the two-block products and $\mathbb{CP}^{n/2}$.

**The live dependency is exhaustiveness, not closedness.** Openness needs *every* graded critical point with $\theta\ge t$ nondegenerate, and [nondegeneracy.md](../findings/nondegeneracy.md) records that [graded-half.md](../findings/graded-half.md) *"already withdrew its exhaustiveness claim"*, with $306$ of $400$ cone starts inside one grading at $n=6$ converging to $61$ distinct critical points. That is the gap the retirement leaves standing, and it is not what 3b was measuring.

## Questions

**(a) Asserted as new, already held.** Four items, all load-bearing.

| asserted in `af411c9`/`93282be`/`52e9752` | already on the record |
| --- | --- |
| $\dim E(\tfrac12)=18$, orbit $9$, excess $9$ at $S^3\times S^3$ | [target.md](../findings/target.md) table; [fence-posts.md](../findings/fence-posts.md); [second-order.md](../findings/second-order.md); [nondegeneracy.md](../findings/nondegeneracy.md) |
| the orbit-tangency identity $L_e(X\cdot W)=\tfrac12(X\cdot W)$ | [target.md](../findings/target.md), as a theorem, Reviewer 71 |
| the Hessian excess of $S^6\times S^6$ at $n=12$ | [fence-posts.md](../findings/fence-posts.md), $36$ matching $pq$, excess $0$ |
| that $\mathrm{mult}(\tfrac12)$ can refine the discriminator | closed in [target.md](../findings/target.md); called equivalent to Conjecture A in [second-order.md](../findings/second-order.md) |

**(b) $\dim E(\tfrac12)$ in general, derived.** For $S^p\times S^q$ with $p,q\ge3$ it is $pq$, exceeding it only when $\mu=\tfrac12$, i.e. $(p-2)(q-2)=1$, i.e. $(p,q)=(3,3)$, where it is $pq+c_pc_q=18$. At $p=2$ the relevant fact is the other sign: $\mu=\frac{n-2}{2(n-3)}>\tfrac12$, so $S^2\times S^q$ fails Lemma L24 and is excluded as a maximiser, the record's known exception. **At $S^6\times S^6$, $n=12$: $\dim E(\tfrac12)=36=\dim\mathcal O$, excess $0$.** So the route does not die at its own extremiser; it dies at the reduction, per Claim 2.

**(c) Item 2's grade.** $\mathrm{closes}=2$ is defensible, (G) alone leaves (H) open, so it does not close the conjecture, which is why item 3 carries $3$. $\mathrm{attackable}=0$ is correct and the prose contradicts it: the same entry calls (G) *"the grey box closest to colour"* with *"new leverage"*, which is an attackable-$>0$ claim sitting inside an attackable-$0$ row. After this review the number is right and the prose is wrong, so **value $0$ stands**, the excess lever does not raise it.

## Repairs owed

1. **Revert the four paragraphs `52e9752` and `93282be` wrote into item 2.** $\dim E(\tfrac12)=pq$ is not refuted; the record's statement already excludes $(3,3)$ and proves the exclusion in closed form.
2. **Strike the $\lambda_{\max}=1$ reading.** It is the eigenvalue at $e$; the deflated value at $S^3\times S^3$ is $\tfrac12$ and is already tabulated in [target.md](../findings/target.md). Any future measurement of $\lambda_{\max}$ must state that $e$ was deflated.
3. **Delete "nothing on the record gives the Hessian excess of $S^6\times S^6$ at $n=12$"** and cite the $n=12$ row of [fence-posts.md](../findings/fence-posts.md): excess $0$.
4. **Record the surviving equality** ($\lambda_{\max}(L_e|_{W^{\perp}})=\tfrac12$ at a maximiser), in [second-order.md](../findings/second-order.md), together with the note that it does not imply gradedness, padded $W_{\mathbb{CP}^2}$ being ungraded with excess $0$ and $\lambda_{\max}=\tfrac12$.
5. **Repoint `3b594ff`'s justification** from RESULT 1's ungraded point to the graded nondegeneracy table, and record exhaustiveness of the graded classification as the openness step's real dependency.
6. **One unresolved internal contradiction, flagged not adjudicated.** [second-order.md](../findings/second-order.md) says a zero-padded-then-projected $W_{\mathbb{CP}^2}$ at $n=6,7$ is *not* critical (residuals $2\times10^{-1}$, $8\times10^{-2}$), while RESULT 1 in [nondegeneracy.md](../findings/nondegeneracy.md) reports padded $W_{\mathbb{CP}^2}$ Morse–Bott nondegenerate at $n=6,8,10$ with $10=10$ at $n=6$. Both cannot describe the same construction. Nothing above depends on the $n=6$ entry, the Claim 2 refutation uses $n=8,10,12$, where the two files agree.

## Method note

Every refutation above is a reading of the record against itself, and the decisive object, the closed-form $L_e$ spectrum at $S^p\times S^q$, proved symbolically in [b_twoblock_symbolic.py](../scripts/b_twoblock_symbolic.py), sits three paragraphs from the sentence the commits set out to refute. **The failure is a search failure, not an arithmetic one**: `18` was measured correctly, and the record's explanation of why it is $18$ was not consulted before it was written up as a refutation. The commits also read a full-space eigenvalue as a restricted one, which is the same class of error as the loop-bound and range-cutoff instances the plan already logs three times.
