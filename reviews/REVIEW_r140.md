# Gate 2, reviewer 140, the Schur constant, the Peirce invariant, and the 1/2-multiplicity

Cold review of commits `1a1f28c`, `cf820f0`, `ef8843e`, `7953321` against [findings/second-order.md](../findings/second-order.md). Everything below was reproduced from an independent implementation of $\mathrm{Weyl}_n$ and of Hamilton's $\#$ written before [scripts/](../scripts/) was opened; the conventions were pinned by the two literature identities $I\#I=(n-2)I$ and $W\#I=-W$ ([Böhm–Wilking](https://arxiv.org/abs/math/0606187) Lemma 2.1), both of which the implementation reproduces to machine zero.

## Verdicts

| Claim | Verdict |
|---|---|
| **A.** $\mathop{\mathrm{tr}}(L_xL_y)=\kappa_n\langle x,y\rangle$ by Schur, $\kappa_n=(n-1)(2n-1)/4$ | **CONFIRMED as a value; OVERSTATED as a derivation.** Independently reproduced at $n=4,5,6,7,8,9,10$. The Schur step is a published theorem, not a new one, and the *value* is still a fit, but a derivation is now one symbolic line away (below). |
| **B.** $\mathop{\mathrm{tr}}(L_x)=0$ | **CONFIRMED, with a proof the record does not give.** It is one line of representation theory, not four dimensions of numerics. |
| **C.** $\theta^2\sum\lambda^2=\kappa_n$ | **Identity CONFIRMED; the independence claim is FALSE.** The two sides descend from the same eigensolver runs, so the six-point table corroborates nothing it was not built from. |
| **D.** Cauchy–Schwarz bound $\mathop{\mathrm{tr}}(L_e^2)\ge 1+\tfrac M4+\tfrac{(1+M/2)^2}{N-1-M}$ | **Algebra CONFIRMED; the headline instantiation is WRONG.** "Short by $3.4$" is computed at $M=9$ when the record's own multiplicity at $S^3\times S^3$ is $18$; the true shortfall is $1.76$. |
| **E.** A counterexample needs $\mathop{\mathrm{tr}}(L_e^2)<R(n)=n^2(2n-1)/(8(n-2))$ | **CONFIRMED**, and sharper than stated: $R(n)$ *equals* $\mathop{\mathrm{tr}}(L_e^2)$ at the balanced sphere product exactly, verified at $n=6,8,10$. |
| **F.** The retraction of the fence post | **The diagnosis is CORRECT and the conclusion is WRONG.** `ef8843e`'s cap was indeed unjustified, but the moment method is dead anyway, for a reason neither commit reaches, and the "concrete sub-target" the retraction names is pointing the wrong way. |

## A. The Schur premise, the scope, and the constant

**The premise holds, at every $n\ge4$, and the $n=4$ worry in the brief is unfounded.** For $n\ge5$, $\mathrm{Weyl}_n$ is the $O(n)$-irreducible with Young diagram $(2,2)$ (Besse, *Einstein Manifolds* §1.114), and every irreducible representation of $O(n)$ is of real type (the Young-symmetriser construction realises it over $\mathbb Q$) so it is absolutely irreducible and the space of invariant symmetric bilinear forms is one-dimensional. At $n=4$ the algebra does split, and I verified the split directly: $\mathrm{Weyl}_4=W^+\oplus W^-$ with $W^+\circ W^-=0$ to $2\times10^{-16}$, two orthogonal five-dimensional ideals. **That splitting does not break Schur.** An orientation-reversing element of $O(4)$ exchanges $\Lambda^\pm$ and hence $W^\pm$, so the involution $\mathrm{Id}_+\oplus(-\mathrm{Id}_-)$ is not $O(4)$-equivariant and the commutant is $\mathbb R$; $\mathrm{Weyl}_4$ is $O(4)$-irreducible of real type. Measured: $\mathop{\mathrm{tr}}(L_xL_x)/\lvert x\rvert^2=5.25$ for $x$ self-dual, anti-self-dual and generic alike, and $\mathop{\mathrm{tr}}(L_xL_y)=0=\langle x,y\rangle$ across the two ideals. What fails at $n=4$ is *simplicity of the algebra* and Schur *under $SO(4)$*, neither of which claim A uses. The honest scope for A is $n\ge4$; the honest scope for "simple algebra" is $n\ge5$.

**The Schur step is [Fox, Theorem 1.3](https://arxiv.org/abs/1901.04012), and the record already knows this**, [findings/second-order.md](../findings/second-order.md) line 124 says so. Commit `1a1f28c`'s "derived here" is the third independent rediscovery of a constant this record has carried since `718f5c8` on 2026-08-19, where it was already obtained by fitting $L_W$ matrices at $n=6\ldots12$.

**The value is genuinely absent from the literature.** Fox's Remark 1.4 is explicit: *"When $\dim V>4$, Theorem 1.3 does not give the value of the positive constant $\kappa$… To calculate $\kappa$ it would suffice to calculate the eigenvalues on $MC_W(V^*)$ of the operator $\hat E$ associated with a nonzero idempotent."* His one computed case, [Theorem 1.5(2)](https://arxiv.org/abs/1901.04012), gives $\tau_*=\tfrac{21}{16}\langle\cdot,\cdot\rangle$ at $n=4$; his metric is $X_{ijkl}Y_{ijkl}$ against this record's $\mathop{\mathrm{tr}}(RS)$ on $\Lambda^2$, a factor of four, so $4\cdot\tfrac{21}{16}=\tfrac{21}4=5.25$, **exactly the value I measure at $n=4$, and exactly $(n-1)(2n-1)/4$.** That is a real external anchor and the record should cite it as one. *It also means the published constant is normalisation-sensitive: in Fox's metric the same claim reads $\kappa_n=(n-1)(2n-1)/16$.*

**My out-of-sample reproduction.** With three evaluations per dimension ($x$, $y$, cross term), $\mathop{\mathrm{tr}}(L_xL_y)/\langle x,y\rangle$ came out at $5.25$, $9$, $13.75$, $19.5$, $26.25$, $34$, $42.75$ for $n=4,\dots,10$, each to $10^{-10}$ or better, against the formula's $5.25,9,13.75,19.5,26.25,34,42.75$. Every value matches.

### The derivation the record owes is one symbolic line, and it closes at every even $n$

Commit `cf820f0` wrote: *"both sides are rational functions of $m$, so closing this symbolically would upgrade six points of corroboration to an identity."* **I did that closure.** Summing the recorded six families at $S^m\times S^m$, $1$ at multiplicity $1$, $\tfrac12$ at $m^2$, $\tfrac{m-2}{2(m-1)}$ at $(m+2)(m-1)$, $\tfrac1{m-1}$ at $\binom m2^2$, $0$, and $-\tfrac1{m-1}$ at $\big(\tfrac{(m-1)(m+2)}2\big)^2$, gives, identically in $m$,

$$\sum_\lambda \lambda^2\;=\;\frac{m^2(4m-1)}{4(m-1)}\;=\;\frac{\kappa_{2m}}{\theta_0(2m)^2},\qquad \kappa_{2m}=\frac{(2m-1)(4m-1)}4 .$$

The difference simplifies to zero. **So $\kappa_n=(n-1)(2n-1)/4$ at every even $n$ is a theorem, not a fit**, provided the six families are themselves derived, and [findings/fence-posts.md](../findings/fence-posts.md) records that reviewer 84 derived them from the Casimir master formula $\lambda=1-\tfrac{\mathrm{Cas}_p}{4(p-1)}-\tfrac{\mathrm{Cas}_q}{4(q-1)}$, so they are. This is precisely the route Fox's Remark 1.4 points at, and it is finished.

**Odd $n$ is the remaining gap, and it is reachable by the same move.** The record already carries the general $S^p\times S^q$ spectrum with $\mathop{\mathrm{mult}}(\tfrac12)=pq$ ([findings/fence-posts.md](../findings/fence-posts.md)); running the same symbolic sum at $p+q$ odd, against the recorded $\theta(p,q)$, closes every odd $n\ge7$ by exactly the same argument. **Do this before recording $\kappa_n$ as derived.** The alternative offered in the record, evaluating $\lVert T\rVert^2$ as a contraction of $\mathfrak{so}(n)$ structure constants against the Weyl projector, is a much larger computation for the same conclusion.

## B. Trace-free: confirmed, and the record gives no reason

$\mathop{\mathrm{tr}}(L_x)=0$ to $10^{-14}$ at $n=4,\dots,10$ in my implementation. **The record reports this as a measurement at four dimensions when it is a one-line theorem:** $x\mapsto\mathop{\mathrm{tr}}(L_x)$ is an $O(n)$-invariant *linear* functional on $\mathrm{Weyl}_n$; a nontrivial irreducible module has no invariant vectors; hence it vanishes identically. This is [Fox, Theorem 3.2](https://arxiv.org/abs/1901.04012) ("exact"), Tkachev's "harmonic" condition (84) in [The universality of one half](https://arxiv.org/abs/1808.03808) §10.2. Two consequences the record should carry: **the property holds for the same reason as A and at the same scope**, and it **fails on the full curvature algebra** $MC(V^*)$, which is $O(n)$-reducible, so any argument that quietly widens the trace-free property past $\mathrm{Weyl}_n$ is wrong.

## C. The cross-check is circular, the independence claim does not survive the record

The identity $\theta^2\sum\lambda^2=\kappa_n$ is a two-symbol rearrangement of A, and its numbers are right: I reproduce $\mathop{\mathrm{tr}}(L_e^2)=12.375=\tfrac{99}8$, $20$, $29.6875=\tfrac{475}{16}$ at $m=3,4,5$, with $\theta$ hitting $\theta_0(2m)$ to $10^{-12}$ and criticality residual $\le2\times10^{-16}$.

**But `cf820f0`'s stated ground for calling it a cross-check is false.** It claims the two inputs "were derived independently". They were not. Tracing the record: $\kappa_n$ was first obtained in `718f5c8` (2026-08-19) *"by fitting explicit $L_W$ matrices ($n=6\dots12$) to exact rationals"*, and re-obtained in `13c7897` by fitting $26.25,42.75,63.25$, which are $\mathop{\mathrm{tr}}(L_e^2)$ at the balanced sphere products at $n=8,10,12$. The six families were fitted in `7ed81b2` to the eigensolver's Hessian spectrum at $n=6\ldots14$, held out at $16$. [findings/algebra.md](../findings/algebra.md) line 23 states the dependence outright: *"Both identities are arithmetic consequences of spectra already on file… At the balanced sphere product the multiplicities $(1,16,54,148,81)$ give $\tfrac{21}{16}\cdot20=26.25$."* **Both sides of the six-column table descend from the same eigensolver runs on the same matrices.** The table checks that two closed forms fitted to one dataset agree on that dataset. What it *does* test is joint extrapolation at $m=7,8$ ($n=14,16$), outside both fit ranges, worth keeping, worth stating as what it is.

**What is genuinely independent, and should replace the claim:** Fox's published $21/16$ at $n=4$, and the symbolic identity in §A above, which turns the same table into a derivation instead of a coincidence.

## D. The Cauchy–Schwarz bound, algebra right, instantiation wrong

The derivation is correct. With $\lambda_1=1$ simple, $M$ eigenvalues at $\tfrac12$, the rest $\le\tfrac12$, and $\sum\lambda=0$, the remainder sums to $-(1+M/2)$ and Cauchy–Schwarz over the $N-1-M$ remaining slots gives the stated bound. No error.

**The headline number is wrong.** `1a1f28c` evaluates it "at $S^3\times S^3$ ($N=84$, $D=9$)" using the *orbit dimension* $9$, and reports $L=3.6588$, $\theta^2\le3.7581$, "short by a factor of $3.4$". The bound is monotone increasing in the $\tfrac12$-multiplicity, and the record's own datum twenty lines earlier in the same file is $\dim E(\tfrac12)=18$ at that point. I measure the full spectrum there as $\{1^{(1)},\tfrac12^{(18)},\tfrac14^{(10)},0^{(30)},-\tfrac12^{(25)}\}$. With $M=18$: $L=7.0385$ and $\theta^2\le1.9536$ against a truth of $1.1111$, **short by $1.76$, not $3.4$.** The commit that retracted the fence post fixed the cap in the table below and left this paragraph standing. It is still wrong on disk.

**The diagnosis is right, and here is the mechanism.** At $S^4\times S^4$ the true remainder carries $\sum_{\text{rest}}\lambda^2=15$ while the Cauchy–Schwarz extremal configuration (all $283$ remaining eigenvalues equal at $-9/283$), carries $0.29$. Almost the whole loss is one family: the $-\tfrac1{m-1}$ eigenvalue at multiplicity $\big(\tfrac{(m-1)(m+2)}2\big)^2$, which alone supplies $9$ of the total $20$. So the record's "the real spectrum is far more spread" is confirmed, and sharpened: **the bound throws away a single large negative family that carries roughly half of $\mathop{\mathrm{tr}}(L_e^2)$.** It is the "rest at most $\tfrac12$" clause that loses, exactly as the brief suspected, and not the $\tfrac12$ clause.

## F. The retraction is right about `ef8843e` and wrong about what survives

### The retraction's own diagnosis is correct

$\mathop{\mathrm{mult}}(\tfrac12)\ge\dim\mathcal O$ is an inequality, `ef8843e` used it as an equality-with-a-cap, and the $(3,3)$ point refutes the cap. I confirm the datum from my own eigensolve: $M=18$ at $S^3\times S^3$ against an orbit of $9$. I also confirm $M=m^2$ at $m=4,5$ ($16$ and $25$, both equal to $\dim\mathcal O=m^2$), so the $m=3$ value is the collision of the $\tfrac1{m-1}$ family with $\tfrac12$ and nothing more. `ef8843e`'s arithmetic was also sound: the ratio of the requirement to $\dim O(n)$ does tend to $2$ (I get $M^*/\dim O(n)\to2.05$). Only its cap was unjustified. The retraction was the right call on the stated grounds.

### But the moment method is dead, and the argument is one line

**$L(N,M)$ is, by construction, a lower bound for $\mathop{\mathrm{tr}}(L_e^2)$.** A counterexample has $\mathop{\mathrm{tr}}(L_e^2)<R(n)$. Therefore $L(N,M)<R(n)$ at a counterexample, **whatever $M$ turns out to be.** No choice of $M$, and no dimension budget, can make the method fire, because $M$ is not a free parameter: it is bounded above by the very inequality the method runs on, $M\le4\big(\mathop{\mathrm{tr}}(L_e^2)-1-\Sigma_{\text{rest}}\big)$.

The retraction's table, "$M$ needed $\approx4R$" against "$N-1$", concluding *"there is ample room below the dimension cap"*, compares the requirement to the wrong ceiling. The ceiling is not $N-1$. It is $\mathop{\mathrm{tr}}(L_e^2)$ itself.

### What the method would need, and why it is not a sub-target

For the method to close, one needs a lemma of the form

$$\theta>\theta_0(n)\ \Longrightarrow\ M\ \ge\ M^*(n),\qquad L(N,M^*)\ \ge\ R(n).$$

**That lemma is logically equivalent to Conjecture A.** It implies the conjecture, by the argument the record gives. And it is implied by the conjecture, vacuously, because the conjecture empties its hypothesis. So proving it is neither easier nor different; it is the same theorem wearing a multiplicity. **The retraction records it as "the concrete sub-target"; it is not a sub-target at all.**

**And every non-vacuous strengthening of it is false.** The natural unconditional forms, "every maximiser has $M\ge M^*$", "every critical point with $\theta\ge\theta_0$ has $M\ge M^*$", are refuted by the balanced sphere product, which satisfies *every* hypothesis the method uses. I verified all of them at $m=3,4,5$: $\theta=\theta_0$ exactly, $\mathop{\mathrm{tr}}(L_e)=0$, $\lambda_{\max}=1$ simple, all other eigenvalues $\le\tfrac12$. Its multiplicity is $m^2=n^2/4$, against a requirement of order $n^2$.

Here are the exact thresholds, solving $L(N,M^*)=R(n)$ in rationals rather than using the $4R$ approximation:

| $n$ | $6$ | $8$ | $10$ | $12$ | $20$ | $50$ | $100$ |
|---|---|---|---|---|---|---|---|
| $R(n)$ | $12.375$ | $20.000$ | $29.688$ | $41.400$ | $108.33$ | $644.53$ | $2538.27$ |
| $M^*$ exact | $29$ | $60$ | $100$ | $147$ | $416$ | $2562$ | $10137$ |
| $4R$ (the record's row) | $49.5$ | $80.0$ | $118.8$ | $165.6$ | $433.3$ | $2578.1$ | $10153.1$ |
| $M$ at $S^{n/2}\times S^{n/2}$ | $18$ | $16$ | $25$ | $36$ | $100$ | $625$ | $2500$ |
| $M^*/M$ | $1.61$ | $3.75$ | $4.00$ | $4.08$ | $4.16$ | $4.10$ | $4.05$ |

**Two corrections fall out.** The retraction's "$M$ needed $\approx4R$" row overstates the requirement by $71\%$ at $n=6$ and $33\%$ at $n=8$, the third Cauchy–Schwarz term is not negligible at small $N$, and $n=6$ is the first column of its own table. And its measured miss, *"$5.00$, $4.60$, $4.33$ at $n=8,12,20$, a factor of about four, shrinking slowly"*, should read $3.75$, $4.08$, $4.16$: the ratio is **growing** over that range, not shrinking, and it peaks near $n=16$–$20$ before drifting back to $4$. The qualitative headline ("a factor of about four") survives; the trend statement does not.

### Verdict on F

`ef8843e` reached a true conclusion (the moment method cannot close the gap theorem), by an argument that does not support it. `7953321` correctly refuted that argument and then wrongly inferred that the conclusion had lapsed with it. **The fence post should be reinstated, with the one-line proof above replacing the orbit-dimension table**, and the "sub-target" sentence deleted rather than corrected.

## The constructive half: a third moment is available in closed form

The record's own prescription is *"an argument using the eigenvalue **distribution** rather than its first two moments"*. **The third moment is there for the taking.** The space of $O(n)$-invariant cubics on $\mathrm{Weyl}_n$ is two-dimensional for $n\ge6$, spanned by $I_1(x)=\langle x^2,x\rangle$ and $I_2(x)=\langle x\#x,x\rangle$, so $\mathop{\mathrm{tr}}(L_x^3)$ (an invariant cubic), must be a fixed combination of them. Measured, with four independent $x$ per dimension and residuals at $10^{-11}$:

$$\mathop{\mathrm{tr}}(L_x^3)\;=\;-\frac{5n-1}8\,I_1(x)\;+\;\frac{n(n-5)}8\,I_2(x).$$

Coefficients read off at $n=6,7,8,9$ and confirmed out of sample at $n=10$. *(At $n=5$ the two invariants are dependent (I measure $I_2=2I_1$ identically, Lovelock's dimensionally-dependent identity) so the coefficients are not separable there.)* This has the same epistemic status as $\kappa_n$ did an hour ago: a fit with a structural reason to exist and a held-out confirmation, awaiting the same symbolic closure at the sphere products.

**Why it matters.** At a critical point $I_1+I_2=\lvert e\rvert^2=\theta^{-2}$, so

$$\sum_\lambda\lambda^3\;=\;\frac{n(n-5)}{8\theta^2}\;-\;\frac{5n-1+n(n-5)}8\,\mathop{\mathrm{tr}}(e^3),$$

with $\mathop{\mathrm{tr}}(e^3)$ taken on $\Lambda^2$. **That is a third moment of the Peirce spectrum in terms of one scalar the literature already bounds sharply**, [findings/problem.md](../findings/problem.md) item 5 records that Xu's Tachibana/Huisken-type estimates bound $\mathop{\mathrm{tr}}(W^3)$ and that this was set aside as "asymptotically negligible". It is not negligible here; it is the missing input. Checks: at $S^3\times S^3$ the identity returns $\sum\lambda^3=0.28125$ and at $S^4\times S^4$, $2.0$, both matching my eigensolve exactly.

I have not established that a three-moment bound bites. I have established that the third moment is computable, that the record's stated obstacle ("only two moments") is not the real one, and that the real one is a bound on $\mathop{\mathrm{tr}}(e^3)$.

## The single most load-bearing defect

**The record leaves the moment method open and names an upper bound on $\mathop{\mathrm{mult}}(\tfrac12)$ as the concrete sub-target, when the method is closed by a one-line argument and the bound it would actually need is a *lower* bound logically equivalent to Conjecture A.** Two directions are conflated in one sentence of `7953321`: the bound that would *kill* the method is an upper bound on $M$, and the bound the method *needs to work* is a lower bound. Neither is a sub-target, the first is unnecessary (the method is already dead) and the second is the conjecture itself.

**The fix**, in order: reinstate the fence post with the $L(N,M)\le\mathop{\mathrm{tr}}(L_e^2)$ argument; correct the $M=9$ instantiation in the paragraph above it to $M=18$ and the $3.4$ to $1.76$; replace `cf820f0`'s independence claim with the symbolic identity, which upgrades the six-column table from corroboration to a derivation of $\kappa_n$ at even $n$; cite [Fox, Theorem 1.3 and Remark 1.4](https://arxiv.org/abs/1901.04012) for the Schur step, the $n=4$ anchor and the fact that the constant is open in print; and take the third moment as the next lever, with $\mathop{\mathrm{tr}}(e^3)$ as its one unknown.

## Literature, checked

| Question | Answer |
|---|---|
| Is $\mathop{\mathrm{tr}}(L_xL_y)=\kappa\langle x,y\rangle$ published? | Yes, [Fox](https://arxiv.org/abs/1901.04012) Theorem 1.3, for $\dim V\ge4$, with simplicity for $\dim V>4$. |
| Is $\kappa_n$ published? | **No.** Fox Remark 1.4 leaves it open and names the idempotent-spectrum route. Only $n=4$ is computed (Theorem 1.5(2), $21/16$ in his normalisation $=21/4$ in this record's). |
| Is $\mathop{\mathrm{tr}}(L_x)=0$ known? | Yes, Fox Theorem 3.2 ("exact"), Tkachev [1808.03808](https://arxiv.org/abs/1808.03808) §10.2 ("harmonic"), and it follows from irreducibility alone. |
| Any upper bound on $\mathop{\mathrm{mult}}(\tfrac12)$? | **None exists.** [Krasnov–Tkachev](https://arxiv.org/abs/1801.00617) Prop. 6.6 locates the spectrum, Prop. 6.7 gives a fusion rule $A_c(\tfrac12)\cdot A_c(\tfrac12)\subset A_c(\tfrac12)^\perp$; neither bounds a dimension. Tkachev's universality theorem runs the other way. Axial-algebra theory excludes $\eta=\tfrac12$ as the degenerate case. |
| Casimir on $[2,2]$ | $C_2=4(n-1)$, normalised by $C_2(\text{vector})=n-1$; the same value reviewer 84's master formula uses. |
