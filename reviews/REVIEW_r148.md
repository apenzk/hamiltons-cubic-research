# Gate 2, reviewer r148, the padding repair and the fence-post downgrade

Cold read of [plan.md](../plan.md) item 1, [second-order.md](../findings/second-order.md), [nondegeneracy.md](../findings/nondegeneracy.md), and commits 2fc13f6, 5d992c5, dc57609. Everything below is derived from the definitions and from the record; no machinery was rebuilt and no number was computed here.

## Verdict in one line

The padding repair is **sound in its diagnosis and defensive in its operative form**: it correctly identifies padding as the machine that makes the falsifier, and then restricts the theorem by a hypothesis ("unpadded") that the intended application cannot verify on the unknown maximiser. It does **not** empty the target. Two of the plan's supporting statements are refuted by the record's own padding lemma.

## Two derivations the argument turns on

**(D1) Every critical point has $\lambda_{\max}(L_e|_{W^\perp})\ge\tfrac12$, exactly, by equivariance.** $Q$ is $O(n)$-equivariant, so differentiating $Q(g\cdot W)=g\cdot Q(W)$ at the identity along $X\in\mathfrak{so}(n)$ gives $2\,W\circ(X\cdot W)=X\cdot Q(W)=\theta\,(X\cdot W)$, i.e. $L_e(X\cdot W)=\tfrac12(X\cdot W)$ with $e=W/\theta$. **The whole orbit tangent sits at exactly $\tfrac12$ at every critical point**, which is why nondegeneracy is recorded as $E(\tfrac12)=$ orbit tangent. Lemma L24 therefore says a maximiser attains $\tfrac12$ *and no more*. **Consequence: $\lambda_{\max}=0.5000000000$ at the falsifier is not a delicate coincidence, it is what every second-order-optimal point looks like**, and the gap theorem was asking ungradedness to push some direction strictly past a value the orbit already occupies.

**(D2) $\circ$-orthogonal sums are harmless to the gap theorem, so padding really is the only recorded machine.** If $W=a_1u_1+a_2u_2$ with $u_i$ critical, $\langle u_1,u_2\rangle=0$ and $u_1\circ u_2=0$, criticality forces $a_i\theta_i=\theta$, hence $L_eu_i=a_i\theta_iu_i/\theta=u_i$. **So $\lambda_{\max}=1>\tfrac12$ on the whole decomposable population**, block sums, the harmonic-square family, and the "third class" of [nondegeneracy.md](../findings/nondegeneracy.md) whose classifying condition is exactly $W_A\circ W_B=0$. That population is ungraded with $S$ inherited and is *not* a counterexample. Padding adds no second summand, so $1$ stays simple, and it is the one recorded operation that produces an ungraded point sitting at $\lambda_{\max}=\tfrac12$. **The repair's diagnosis is correct, and D2 is the argument the plan should have given for it.**

## Claim 1, the padding repair

### The inference "the leak grows with $n$, so padding is the cause" is sound for this point, and it does not restore the theorem

$S_{\mathfrak{hhm}}=4(n-4)$ is a function of the padding dimension alone and vanishes at $n_0=4$, where the same file records $W_{\mathbb{CP}^2}$ as graded. That establishes the *causal* reading. The brief asks whether the leak growing with $n$ is instead consistent with the point being genuinely ungraded once embedded: **both readings are true simultaneously and the distinction is empty**. At $n=5$ the padded tensor is an element of $\mathrm{Weyl}_5$, is exactly critical, and is ungraded; gradedness is a property of the point in its ambient dimension, so explaining *why* it fails changes nothing about *that* it fails. The theorem is false as stated. What the causal reading buys is only a candidate restriction, nothing more.

### The operative flaw: "unpadded" is not a property of the unknown maximiser

The gap theorem is used **contrapositively on an unknown $W$**. What a maximiser hands you for free is: critical, $\lambda_{\max}\le\tfrac12$ (Lemma L24), and $\theta\ge\theta_0(n)$. It does **not** hand you unpaddedness. So "ungraded $\wedge$ critical $\wedge$ **unpadded** $\Rightarrow\lambda_{\max}>\tfrac12$" yields only *a maximiser is graded or padded*, and the padded branch is left entirely open.

**This is the exact test of principled versus defensive, and it inverts the plan's own reasoning.** The plan rejects the dimension restriction because it "substitutes the global value crossover for a local Hessian condition". But the global value is a property the maximiser *has*; unpaddedness is a property that must be *proved about it*. **The honest repaired hypothesis is the value one:**

> critical $\wedge\ \lambda_{\max}(L_e|_{W^\perp})\le\tfrac12\ \wedge\ \theta\ge\theta_0(n)\ \Rightarrow$ graded.

That is exactly what (G) needs, costs nothing at the point of use, and no witness on record refutes it, the falsifier has $\theta=\sqrt{3/2}<\theta_0(12)$.

### What would make the support restriction sound, three lines the plan does not have

Descent on the support dimension, not on $n$:

1. A padded maximiser at $n$ has a seed that is itself a maximiser at $n_0<n$ with the *same* $\theta$ (otherwise pad a better seed). Recurse; the recursion terminates at an **unpadded** maximiser at some $m\le n$.
2. By the repaired theorem that point is graded, so step H applies **at its own dimension**, in the form $\theta\le\max(\theta_0(m),\sqrt{3/2})$, the $\sqrt{3/2}$ is needed because $W_{\mathbb{CP}^2}$ is graded at $m=4$ with $\theta=\sqrt{3/2}>\theta_0(4)=0.866$.
3. $\theta_0$ increases and passes $\sqrt{3/2}$ at $6+2\sqrt7$, so $\max(\theta_0(m),\sqrt{3/2})\le\theta_0(n)$ for every $m\le n$ once $n\ge12$, with equality only at $m=n$, so no padded point is a maximiser.

**Note what step 3 is: the crossover the plan claims the support restriction replaces.** The support restriction does not eliminate the value argument; it relocates it. And step 2 needs H over *all graded* points at every dimension, whereas the record proves $\sqrt{3/2}$ maximal only over **compact irreducible symmetric spaces** ([findings/INDEX.md](../findings/INDEX.md) line 61), and the plan itself states gradedness is strictly broader than symmetry. **That gap is the real debt the repair incurs, and it is unrecorded.**

### The restriction does not empty the target, and the record said so a day earlier

Three unpadded ungraded $S=0$ critical families are already on file in [nondegeneracy.md](../findings/nondegeneracy.md):

| witness | why it is unpadded and ungraded |
|---|---|
| Clebsch at $n=16$ | $\dim\mathfrak m=40\ne64=n^2/4$, so ungraded by the file's own two-eigenvalue law; $S=0$ exactly, criticality residual $3\times10^{-18}$; native to $n=16$ |
| $24$ points across three $\sigma$-cones at $n=6$ | recorded verbatim as "slack-zero, ungraded, and carry **no kernel and no padding**" |
| the triangle-free strongly regular family | Petersen and the rest, $\dim\mathfrak m$ up to $1100$, all at $\dim\mathfrak m\ne n^2/4$ |

By D2 these are the interesting ones precisely because they are not $\circ$-decomposable, so their $\lambda_{\max}$ is not forced to $1$. **The restricted statement therefore has content.** And the plan's owed item (*"whether any of those $155$ points at $n=6$ is unpadded"*), is answered in the affirmative in the same file, which closes with **"That objection is now answered."** That sentence entered the record in a32a98b on 2026-08-26; 2fc13f6 revived the objection on 2026-08-27 without the answer.

### "$\{S=0\}$ is closed under padding while gradedness is not" is being made to carry the converse

The asymmetry is true and is correctly cited for *padding produces ungraded $S=0$ points*. The repair needs *the ungraded $S=0$ points at $\lambda_{\max}=\tfrac12$ are only the padded ones*, which the asymmetry does not say and which the same file explicitly denies at the level of $S=0$ points: **"'block sum or padding' is not exhaustive."** D2 is what rescues the inference (the non-padded classes on record are $\circ$-decomposable and sit at $\lambda_{\max}=1$) and D2 is absent from the plan.

## Claim 2, the 145/146 split

**Padding-invariance of $\theta$: correct, and it is a lemma rather than an observation.** $Q$ commutes with padding bit for bit and $\lvert\mathrm{pad}\,W\rvert=\lvert W\rvert$, so $Q_n(\mathrm{pad}\,W)=\theta\,\mathrm{pad}\,W$ **exactly**.

**The arithmetic is right.** $\theta_0(n)^2=2(n-1)(n-2)/n^2=\tfrac32$ gives $n^2-12n+8=0$, $n=6+2\sqrt7=11.2915$; $\theta_0(12)=\sqrt{220}/12=1.2360331>1.2247449$.

**The maximiser/critical-point distinction is used honestly, and D1 explains why the split arose.** At $n=5$, $\theta=\sqrt{3/2}$ against $\theta_0(5)=0.9798$: on this record's own conjectured value table the padded point **is** the global maximiser at $n=5$, and then Lemma L24 *forces* $\lambda_{\max}\le\tfrac12$. **So the falsification at $n=5$ is automatic rather than evidential**, it is the statement "(G) is false at $n=5$", and it is false there for the padding reason. At $n\ge12$ that force is absent, which is a positive reason to expect $\lambda_{\max}>\tfrac12$ and the single best argument available for the repair. 146's reading (that the collapse leaves item 1 without an escape), is wrong; 145 carries it, as recorded.

## Claim 3, the fence-post downgrade

**The downgrade is right, and it is not an over-correction.** All three objections hold: $S_2=\kappa_n/\theta^2$ pins the second moment so a fibre-dimension count is measuring free data that is not free; slack evaluated at sphere products cannot measure exclusion at a hypothetical counterexample, since the localizing determinant depends on $(\theta,a,b)$ and not on $\theta$ alone; and $e=W/\theta$ makes $\mathop{\mathrm{spec}}(L_e)$ and $\mathop{\mathrm{spec}}(L_W)$ one set up to scale, so this is [fence post F6](../findings/fence-posts.md) in new clothes. The "every localizing order" extension is correctly withdrawn: PSD is *every* principal minor, the minor omitting index $0$ carries no $m_0\sim n^4$ entry, and $M_k$ for $k\ge2$ needs $m_4,\dots,m_{2k+1}$ against three moments on record.

**But the surviving scale statement misdescribes the spectrum, and in the direction that matters.** By D1, $\mathop{\mathrm{mult}}(\tfrac12)\ge\dim(\text{orbit})$, which at the balanced product is $\dim\mathfrak{so}(n)-2\dim\mathfrak{so}(n/2)\approx n^2/4$. That eigenvalue alone contributes $\approx(n^2/4)\cdot\tfrac14=n^2/16$ to $\mathop{\mathrm{tr}}L_e^2=\kappa_n/\theta^2\approx n^2/4$, **about a quarter of the entire second moment sits exactly ON the fence.** So "$\mathop{\mathrm{tr}}L_e^2=\Theta(n^2)$ over $\Theta(n^4)$ eigenvalues puts $\mathop{\mathrm{spec}}(L_e)$ at scale $1/n$" is true on average and false as a picture: the spectrum is an $\Theta(n^2)$-dimensional atom at $\tfrac12$ plus a diffuse remainder, and the atom is the part a moment method would have to exploit. **The file should carry the atom, not the $1/n$ scale.** *Minor:* retaining the scale statement in the same paragraph is itself a fifth telling of post F6, self-labelled.

## Answers

**(a) Is item 1 in better or worse shape?** *Marginally better, and much worse than the commits claim.* Gained: the crossover arithmetic is real and genuinely saves (G) from this witness. Lost: the falsification is broader than the record now states (below), the dimension escape is closed by the record's own padding lemma, the support escape is unfinished, and a question the record had answered was re-opened. Net, item 1 still has no repaired theorem, it has a candidate restriction and a missing descent argument.

**(b) Recorded as new, already held.** Yes, one, and it is a regression rather than a duplication. *"The falsifier's ungradedness is manufactured by padding"* is on record verbatim in [nondegeneracy.md](../findings/nondegeneracy.md) from 2026-08-26, in two places, once as the reading, once as **an objection the file then declares answered** by the $24$ unpadded ungraded $S=0$ points. 2fc13f6 restates the reading, drops the answer, and books the answered question as owed work.

**(c) Principled or defensive?** *Defensive as written, principled as repairable.* The criterion is whether the intended application can verify the added hypothesis on the unknown object: $\theta\ge\theta_0(n)$ passes, "unpadded" fails. The support restriction becomes principled only with the descent argument above, and that argument re-imports the value crossover it was introduced to avoid.

## Disagreements with the record, stated explicitly

1. **"The witness stands at $n=5$ alone" is FALSE**, and so is the $n=6,7$ non-criticality that supports it. [nondegeneracy.md](../findings/nondegeneracy.md) proves padding is critical-point-preserving *exactly*, $\max\lvert Q_n(\mathrm{pad}\,W)-\mathrm{pad}\,Q_{n_0}(W)\rvert=0.0$, and the same file catalogues padded $W_{\mathbb{CP}^2}$ as an ungraded $S=0$ critical point at $n=8,10,12$ with leaks $16/24/32$ and $\theta/\theta_0(12)=0.9909$. The recorded residuals $2\times10^{-1}$ and $8\times10^{-2}$ come from a "zero-padded-**then-projected**" construction; the projection is a no-op on a tensor already in $\mathrm{Weyl}_n$, so those residuals are a construction artefact, not a fact about the point. *The witness's hypotheses hold at every $n\ge5$.*
2. **Therefore "a version restricted to $n\ge12$ is not refuted" cannot be claimed**, and neither can "the phenomenon it would rely on is absent at small $n$ rather than merely unobserved". The point exists at $n=12$ with $S=0$, ungraded, critical, $\theta=\sqrt{3/2}$; the *only* untested ingredient is whether $\lambda_{\max}$ stays at $\tfrac12$ there, and by the Lemma L24 argument in claim 2 above there is positive reason to think it does not. **That single quantity is the cheapest decisive test the programme has, and it is one eigenvalue at one known point.**
3. **The falsifier's $\lambda_{\max}=\tfrac12$ is described as an accident of ungradedness; it is the generic value.** Per D1 the orbit tangent sits at $\tfrac12$ at *every* critical point, so no ungraded point can have $\lambda_{\max}<\tfrac12$ and the gap theorem was always a strict-excess claim about a value already attained.
4. **The plan's stated reason for preferring the support restriction over the dimension one is backwards**, see the operative-flaw section.
5. **The surviving scale statement in [second-order.md](../findings/second-order.md) is a misdescription**, per claim 3.
