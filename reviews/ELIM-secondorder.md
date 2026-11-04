# ELIM-secondorder, criticality-substitution audit of [nondegeneracy.md](../findings/nondegeneracy.md) and [second-order.md](../findings/second-order.md)

Both files read in full. Every bound, reduction, equivalence, "the conjecture becomes…" and "what a successor needs is…" was tested by substituting $W^\#=\theta W-W^2$, $\mathrm{Ric}(W)=0$, first Bianchi and $\mathop{\mathrm{tr}}W=0$. Pure algebra; nothing was run.

**Headline.** These two files are the *least* affected by the criticality collapse of any part of the record, and the reason is structural: the Hessian operator $L_W$ lives on $\mathrm{Sym}^2(\Lambda^2)$, not on $\Lambda^2$, and criticality pins exactly one of its matrix entries. That is the survivor and it is worth more than the refutations below. But the collapse does reach three things inside these files, the moment hierarchy, the second-kind cubic $C$, and every sentence describing $\langle W^\#,W\rangle$ as "alignment data", and separately there is a **class error in how suprema are certified** that voids at least three headline results.

---

## Survivors, what genuinely escapes $(\mathrm{spec}\,W,\theta)$

### S1. $L_W$ restricted to $W^\perp$. Criticality determines exactly one entry of it, and nothing else.

The brief's collapse is a statement about the *quadratic* map $\#$ evaluated on the diagonal. Criticality gives $\#(W,W)=W^\#=\theta W-W^2$. The second-order theory needs the *polarised* $\#(W,X)$ for $X\in\mathrm{Weyl}_n$, $X\perp W$, and criticality says nothing about those values. Concretely, $L_W W=W\circ W=Q(W)=\theta W$ is the whole content of criticality at the level of $L_W$, one eigenvector, one eigenvalue. So:

$$\lambda_{\max}(L_e|_{W^\perp}),\quad \dim E(\tfrac12),\quad \dim E(1),\quad \text{the excess},\quad T(z,z,z),\quad \Psi_1$$

are all genuinely free of $(\mathrm{spec}\,W,\theta)$. [Lemma L24](../findings/second-order.md#L38), [Lemma L27](../findings/nondegeneracy.md#L147), [Lemma L28](../findings/nondegeneracy.md#L188), [Lemma L51](../findings/second-order.md#L150) and the $\dim E(1)=1$ indecomposability test are therefore not reachable by the substitution at all. This is the answer to "which quantity is not determined by the spectrum and $\theta$": **the off-diagonal of the multiplication operator.**

The direct evidence is already in the record and should be promoted, because it is the cleanest proof that the substitution cannot reach here: at $n=8$, [$\mathbb{CP}^4$ and $S^2\times S^6$ are distinct critical points with identical $L_e$ spectra and the same $\theta^2=35/36$](../findings/second-order.md#L208). Two points, same $\theta$, same $L_e$ spectrum, different tensors.

### S2. $c'$, the structure constants transported to $W$'s $\Lambda^2$ eigenframe. This is the single free variable in both files.

Every quantity in these files that has content routes through $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ in the eigenbasis of $W$:

| quantity | where | collapses? |
|---|---|---|
| $S(W)=\sum_{\alpha\beta\gamma:\lambda<0}c'^2_{\alpha\beta\gamma}$ | [second-order.md:184](../findings/second-order.md#L184) | no, no $\lambda$ weights, sign-restricted |
| $M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\beta\gamma}\lambda_\gamma$ | [second-order.md:261](../findings/second-order.md#L261) | no |
| $B_5$, $R_{\alpha\beta}=\sum_\gamma c'^2_{\alpha\beta\gamma}$ | [second-order.md:73](../findings/second-order.md#L73), [:87](../findings/second-order.md#L87) | partly, see W1 |
| $F(C)=\sum C_{ij}C_{kl}\langle M_{ik},M_{jl}\rangle$ | [nondegeneracy.md:29](../findings/nondegeneracy.md#L29) | no |
| Bianchi as $\sum_\alpha\lambda_\alpha(v_\alpha\wedge v_\alpha)=0$ | [second-order.md:153](../findings/second-order.md#L153) | no |

The record reaches the same conclusion from the other side and states it well: [*"the binding constraint is on the eigenvector planes a Weyl tensor can have, not on its eigenvalues"*](../findings/second-order.md#L417). That sentence is the correct summary of this whole audit.

The **contrast that makes it precise**: the $\lambda$-weighted total structure mass *does* collapse,

$$\tfrac12\sum_{\alpha\beta\gamma}c'^2_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=\langle W,W^\#\rangle=\theta-\mathop{\mathrm{tr}}(W^3),$$

so a bound on the *weighted* mass is a bound on $\theta$ rearranged, while a bound on the *unweighted, sign-restricted* mass ($=S$) is new. Anything built from $c'^2$ with a full $\lambda\lambda\lambda$ weight is already spent.

### S3. An exact constraint on $c'$ that neither file writes down, and it is free.

Criticality is $W^2+W^\#=\theta W$. In $W$'s eigenbasis $W$ and $W^2$ are diagonal, so **$W^\#$ must be diagonal there too**. With $W^\#_{\alpha\beta}=\tfrac12\sum_{\gamma\delta}c'_{\alpha\gamma\delta}c'_{\beta\gamma\delta}\lambda_\gamma\lambda_\delta$, criticality splits into two halves:

$$\underbrace{\tfrac12\sum_{\gamma\delta}c'^2_{\alpha\gamma\delta}\lambda_\gamma\lambda_\delta=\theta\lambda_\alpha-\lambda_\alpha^2}_{\text{diagonal, this is }M\lambda=\theta\lambda},\qquad \underbrace{\sum_{\gamma\delta}c'_{\alpha\gamma\delta}c'_{\beta\gamma\delta}\lambda_\gamma\lambda_\delta=0\ \ (\alpha\ne\beta)}_{\text{off-diagonal, unused}} .$$

The Rayleigh-quotient reformulation at [second-order.md:257](../findings/second-order.md#L257) uses only the diagonal half. The off-diagonal half is $\binom I2$ exact bilinear equations on the eigenframe structure constants (a Gram-orthogonality between the $\lambda$-weighted rows of $c'$) and it appears nowhere in either file. Since S2 identifies $c'$ as the only free variable, constraints on $c'$ are exactly the scarce resource, and this is a large unused block of them. **This is the concrete successor item this audit produces.**

### S4. The second-kind spectrum $\mu_j$ and $|S^jW|^2$.

$\mathring W$ on $S^2_0(\mathbb R^n)$ is a different operator from $W$ on $\Lambda^2$, and its spectrum is not a function of $\mathrm{spec}(W|_{\Lambda^2})$. So the $\mu_j$ are real extra data, which is why [fence post F2g does not obstruct the route](../findings/nondegeneracy.md#L245), correctly. The trouble with that route is elsewhere (see T3).

### S5. The strata separation itself.

$\dim\mathfrak m$ (the count of negative eigenvalues) *is* spectral, but the pairing "$\dim\mathfrak m\le2\Rightarrow S=0$ automatically" at [second-order.md:188](../findings/second-order.md#L188) is a genuine structural theorem ($c'$ is antisymmetric in three indices, hence vanishes on any $\le2$-dimensional subspace). This one is clean and it is doing real work: it identifies exactly where the $S=0$ hypothesis is vacuous. The *value* claim built on top of it is not clean, see W3.

---

## Tautologies found

### T1. "$\langle W^\#,W\rangle$ depends on eigenspace alignment rather than spectrum" is false on the critical set.

> [nondegeneracy.md:274](../findings/nondegeneracy.md#L274): *"the cubic that existing estimates bound sharply carries $2/((n-1)(n-2))$ of $\theta$ and vanishes quadratically, while $\langle W^{\#},W\rangle$ (which depends on eigenspace alignment rather than spectrum), carries the rest."*

Substitute: $\langle W^\#,W\rangle=\langle\theta W-W^2,W\rangle=\theta\|W\|^2-\mathop{\mathrm{tr}}(W^3)=\theta-\mathop{\mathrm{tr}}(W^3)$.

So at a critical point $\langle W^\#,W\rangle$ is $\theta$ minus a purely spectral quantity. "Carries the rest" is not an observation, it is $\theta=\mathop{\mathrm{tr}}(W^3)+\langle W^\#,W\rangle$ read left to right. The alignment content of $\langle W^\#,W\rangle$ is *entirely consumed* by criticality; what remains free is $\mathop{\mathrm{tr}}(W^3)$, which is spectral. The clause should be struck. (The closed form $\mathop{\mathrm{tr}}(W^3)/\theta=2/((n-1)(n-2))$ at the balanced product is a genuine computation and survives; only the "alignment" framing is the tautology.)

### T2. The whole moment hierarchy collapses to $(n,\theta,\mathop{\mathrm{tr}}W^3)$, including the third moment the record calls "the first to see $b$ at all".

> [second-order.md:68](../findings/second-order.md#L68): *"With $a=\langle W^2,W\rangle$, $b=\langle W^{\#}W,W\rangle$ and $\theta=a+b$, it gives $S_3=((n^2-1)b-(5n-1)\theta)/(8\theta^3)$, the first moment to see $b$ at all."*

The stated relation $\theta=a+b$ forces $b=\langle W^\#,W\rangle$ (whatever the notation $\langle x^\#x,x\rangle$ was meant to denote, **the notation is ambiguous and load-bearing, and should be fixed**). Under that reading, T1 gives $b=\theta-a$, so

$$S_3=\frac{(n^2-1)(\theta-a)-(5n-1)\theta}{8\theta^3}=\frac{(n^2-5n)\theta-(n^2-1)a}{8\theta^3},\qquad a=\mathop{\mathrm{tr}}(W^3).$$

The third moment sees $\mathop{\mathrm{tr}}(W^3)$, not alignment. And the record's own combination collapses the same way:

$$\tfrac12S_2-S_3=\frac{(n+1)\big[2n\theta-(n-1)b\big]}{8\theta^3}\ \xrightarrow{\ b=\theta-a\ }\ \frac{(n+1)\big[(n+1)\theta+(n-1)a\big]}{8\theta^3}.$$

Consequence, stronger than the record's own closure: with $S_2=\kappa_n/\theta^2$ pinned and $S_3$ reduced to $(\theta,a)$, **the localizing-matrix inequality at [second-order.md:70](../findings/second-order.md#L70) is an inequality in the two scalars $(\theta,a)$ and the parameter $n$.** It can never separate $\theta\le\theta_0$ from $\theta>\theta_0$ unless $a$ is independently pinned. The record kills the moment method for a weaker reason ("every bound is a *lower* bound"); the real reason is that after substitution there is only one free scalar left in the entire hierarchy, and the record itself proves that scalar is asymptotically negligible ($a/\theta=2/((n-1)(n-2))$ at the conjectured maximiser). **Recommend replacing the recorded reason with this one**, it is the fence, and it is dimension-uniform.

### T3. $\theta=6\mathop{\mathrm{tr}}(W^3)+\tfrac18C$ is the definition of $P$ rearranged, and needs no criticality at all.

> [nondegeneracy.md:241](../findings/nondegeneracy.md#L241): *"$C(W)=-40\mathop{\mathrm{tr}}(W^3)+8\langle W^{\#},W\rangle$, hence $\theta=6\mathop{\mathrm{tr}}(W^3)+\tfrac18C$."*

$P(W)=\mathop{\mathrm{tr}}(W^3)+\langle W^\#,W\rangle$ by definition, so $\langle W^\#,W\rangle=P-\mathop{\mathrm{tr}}W^3$ and

$$C=-40\mathop{\mathrm{tr}}W^3+8(P-\mathop{\mathrm{tr}}W^3)=8P-48\mathop{\mathrm{tr}}W^3\iff P=6\mathop{\mathrm{tr}}W^3+\tfrac18C.$$

The "hence" is a division by 8. The two boxed identities are one identity. Consequently, on the critical set $C=8\theta-48\mathop{\mathrm{tr}}(W^3)$, i.e. $\tfrac18C=\langle W^\#,W\rangle-5\mathop{\mathrm{tr}}(W^3)$: **bounding $C$ above is bounding $\langle W^\#,W\rangle$ above modulo a spectral cubic**, the hard half of the target with a spectral term subtracted from both sides. This is the R14 pattern. The record closes the route for a different and also-valid reason (loose by $1.45\times$ at the extremiser), but the substitution shows it was never a reduction, and the sentence [*"$\theta$ has only to lie in the span of the two cubics, which it does"*](../findings/nondegeneracy.md#L245) is true because that span is *defined* to contain $\theta$. That sentence should not be read as support for the route.

### T4. "The conjecture becomes a minimisation" is a restatement, and the record says so two clauses later.

> [second-order.md:198](../findings/second-order.md#L198): *"The conjecture becomes a minimisation… $\theta^2=\kappa_W/\|L_e\|_F^2$… Maximising $P$ over the critical set is exactly minimising the Frobenius norm of the multiplication operator."*

$\|L_e\|_F^2=\kappa_W/\theta^2$ holds at **every unit element**, critical or not, the record states this itself. So the map $\theta\mapsto\|L_e\|_F$ is a bijection on the relevant range and the "reformulation" transports no information. It is a legitimate change of variable and an illegitimate reduction; the file's own closure ("the exact optimum of its moment problem, so the route is closed") is correct. Flagged only because the heading reads as progress.

### T5. Sharpness of the second-order criterion is forced by equivariance, not by maximality.

[Lemma L24's scope note](../findings/second-order.md#L48) says it outright: *"the orbit directions are exact $\tfrac12$-eigenvectors, so $\tfrac12$ is attained at every critical point and the bound is sharp."* This is honest and correct, and it is precisely the brief's third failure mode, tightness from structure rather than from the bound's mechanism. The consequence should be stated where the criterion is *used*: $\lambda_{\max}(L_e|_{W^\perp})\ge\tfrac12$ automatically at every critical point, so the criterion is a knife-edge test with zero margin by construction, and its entire discriminating power sits in whether anything exceeds $\tfrac12$. That matters for W4 below.

### T6. Already found by the record, and correctly: "The final step is a tautology".

[nondegeneracy.md:430](../findings/nondegeneracy.md#L430) diagnoses that the "exact $\theta$ formula" is the definition of $S$ rearranged, and that converting $S\ge c$ into $\theta\le\theta_0$ silently assumes something strictly stronger than the target. **That is the same failure mode this audit hunts, found independently, and it is the model of how it should be written up.** Credited, not re-litigated.

### I28. $\mathop{\mathrm{tr}}(W^\#)=-1$ is tracelessness plus normalisation, and it is what makes the LP look sharp.

$\mathop{\mathrm{tr}}(X^\#)=-\|X\|^2$ on $\mathrm{Weyl}_n$ is a universal identity ([second-order.md:194](../findings/second-order.md#L194)); at a critical point it also follows from $W^\#=\theta W-W^2$ with $\mathop{\mathrm{tr}}W=0$, $\mathop{\mathrm{tr}}W^2=1$. Either way it carries no information about $W$ beyond its norm. See W1.

---

## Weak evidence

### W1. The LP's "one tight configuration" is normalisation-forced tightness, the brief's flag #3, with the mechanism now named.

> [second-order.md:180](../findings/second-order.md#L180): *"On the two-block slice the same relaxation is exactly tight… the value equals $\theta_0(n)$ to $2.2\times10^{-16}$… the LP recovers the sphere product with no geometry supplied."*

Every constraint the LP carries is an $O(n)$-invariant of $c$ alone: the row marginal $\sum_{bc}T_{abc}=2(n-2)$, the pair cap $\sum_cT_{abc}\le2$, and $\mathop{\mathrm{tr}}(W^\#)=-1$. None of them references $W$'s eigenframe. So the LP is solving a problem in which the only free variable identified in S2 does not appear, which is exactly why "what the constraints omit is frame-realizability" is the whole story. The record's own ablation ([second-order.md:182](../findings/second-order.md#L182)) finds that the row marginals plus $\mathop{\mathrm{tr}}(W^\#)=-1$ return $\theta_0(n)$ on their own with every pair cap inactive; by I28 those two are tracelessness and normalisation. **The tightness is the brief's second recorded precedent recurring**, and the record caught it. Recommend the paragraph lead with the ablation rather than with "no geometry supplied".

### W2. "Huisken's cap is saturated exactly" is likewise forced by tracelessness, verified by hand.

> [nondegeneracy.md:43](../findings/nondegeneracy.md#L43): *"Its relaxation (drop hollowness, keep $\mathop{\mathrm{tr}}\Lambda=0$, $\|\Lambda\|=1$ and $\Lambda\mathbf1=0$), is already sharp: Huisken's cap $(m-2)/\sqrt{m(m-1)}$ on $\sum\mu_i^3$ is saturated exactly by the sphere product's vertex matrix."*

The cap $(m-2)/\sqrt{m(m-1)}$ is exactly the extremum of $\sum\mu^3$ subject to $\sum\mu=0,\sum\mu^2=1$ on $m$ values, attained **only** at spectra of the shape (one extreme value, $m-1$ equal values). So saturation is equivalent to the vertex matrix having that spectral shape, nothing about the relaxation is being tested.

Worked at $n=6$: the balanced hollow zero-row-sum vertex matrix is $w=(a-b)B+bJ-aI$ with $2a+3b=0$, whose spectrum is $\{0,\ -6b,\ (3b/2)^{\times4}\}$, one extreme value and four equal ones, forced by the two equal blocks. Then $\sum\mu^2=45b^2$ and $\sum\mu^3=-202.5\,b^3$, so at unit norm $|\sum\mu^3|=202.5/45^{3/2}=0.670820=3/\sqrt{20}=(5-2)/\sqrt{5\cdot4}$. Saturated, **with $m=5=n-1$, not $m=n$**, because $\Lambda\mathbf1=0$ removes one dimension.

Two consequences. First, the quoted formula's $m$ is the reduced dimension; as printed with $m=n$ it does not match the value it is said to saturate, and there is an unresolved sign (the balanced product gives $-0.6708$, saturating the minimum). Both should be fixed in place. Second, and substantively: **the tightness follows from tracelessness, the row-sum constraint and the two-block shape**, so it is no evidence about the relaxation's quality. The route-closure conclusion drawn from it ("the difficulty sits in the hollowness constraint") is nevertheless right, for the independent reason that hollowness is the only dropped constraint.

### W3. Ascent values are being reported as suprema. This voids three headline results as stated.

Gradient ascent on a supremum returns a **lower bound**. The record knows this, it records the dual error explicitly ([nondegeneracy.md:373](../findings/nondegeneracy.md#L373): *"a power iteration on a Rayleigh quotient produces an upper bound on the minimum and therefore can never certify a spectral gap"*), and then commits it repeatedly in [second-order.md](../findings/second-order.md):

- **[second-order.md:379](../findings/second-order.md#L379): $M(6)\le1.6300<\sqrt3$, "proved on a set strictly containing $\mathrm{Weyl}_6$".** The value $1.630017$ is the $r=15$ entry of an ascent table ([:375](../findings/second-order.md#L375)). $M(6)\le\Phi(15)$ is valid; $\Phi(15)\le1.6300$ is not established, and $\Phi(15)$ could exceed $\sqrt3$. **The section heading "closes $n=6$ outright" is unsupported.** The guard paragraph at [:391](../findings/second-order.md#L391) confirms these are ascent outputs subject to failure, it repairs an $r=28$ run that came in *below* $r=24$.
- **[second-order.md:429](../findings/second-order.md#L429): "The supremum over it is $1.548844$… Bianchi closes $95.3\%$ of the gap".** Percentages computed between two lower bounds. The proof target at [:433](../findings/second-order.md#L433) is stated correctly as a supremum to be bounded; the "$11\%$ of margin" is not evidence about it.
- **[second-order.md:475](../findings/second-order.md#L475): "At $n=12$ no maximiser has fewer than three negative eigenvalues".** This needs an **upper** bound on $\sup\theta$ over $\{\dim\mathfrak m\le2\}$; what was run is penalty-constrained ascent, one start at $n=12$. Worse, **the record refutes this instrument two pages later on its own evidence**: [second-order.md:545](../findings/second-order.md#L545) records that *"padded $W_{\mathbb{CP}^2}$ captures $95$–$100\%$ of unconstrained ascent starts"*. So an ascent returning $1.224745=$ padded $W_{\mathbb{CP}^2}$'s value from one start is the expected output of a basin, not a measurement of a stratum ceiling. The claim that this "excludes precisely route R9's sharp case **without using any enumeration**" does not stand as written.
- **[second-order.md:539](../findings/second-order.md#L539): "Its supremum over $\mathrm{Weyl}_n$ is $\sqrt{3/2}$ at $n=6,8,10$".** Same instrument; and the $n=12$ run in the very next paragraph demonstrably under-converged (returned $1.2247$ against a *known feasible* $1.2360$), which is the record's own proof that the instrument fails on this objective. Everything downstream of "if the supremum is $\max(\sqrt{3/2},\theta_0(n))$" is honestly conditional and stays.

Note this is not a criticality-substitution failure, the $\lambda_{\max}(M(\lambda))$ and $\lambda_{\max}p+B_5$ objects are genuine survivors under S2. The defect is purely in what the numbers certify. **The fix is cheap and does not require new mathematics: state every one of these as a lower bound, and mark the two "proved"/"closes" headings as open.**

### W4. Observation L25 is falsified by its own file, and its population is the one the record proves the solver cannot leave.

> [second-order.md:234](../findings/second-order.md#L234): *"Across 155 converged critical points at $n=6$ (all ungraded), together with every structured ungraded point on record, $\lambda_{\max}(L_e|_{W^\perp})$ ranges over $[1.17,96.3]$, and none satisfies $\lambda_{\max}\le\tfrac12$."*

Two failures.

1. **Counterexample on the same file.** [second-order.md:88](../findings/second-order.md#L88): *"Padded $W_{\mathbb{CP}^2}$ at $n=5$ is critical to $3\times10^{-16}$ with $\theta=\sqrt{3/2}$, is ungraded, and has $\lambda_{\max}(L_e|_{W^\perp})=0.5000000000$."* Padded $W_{\mathbb{CP}^2}$ is on record, is structured, and is the file's own witness for "slack zero does not imply a grading" ([:220](../findings/second-order.md#L220)). Observation L25's statement is false as quantified; it needs "excluding the $\dim\mathfrak m\le2$ stratum" in the hypothesis.
2. **Sampling.** The 155 points are converged root-finder output. [nondegeneracy.md:332–339](../findings/nondegeneracy.md#L332) proves that a residual-cutoff root-finder converges only to *nondegenerate* zeros and that graded points at $n=6$ are all degenerate, so $0$ of $1205$ is *structurally forced*. The 155-point population is therefore, by the record's own theorem, exactly the ungraded nondegenerate set. "Every ungraded critical point on file" is a statement about that reach.

Combined with T5, $\lambda_{\max}\ge\tfrac12$ automatically, and the graded violators' excess $\tfrac1{2(n-3)},\tfrac1{2(m+1)}\to0$, the criterion has zero margin at the sharp case and vanishing margin on the graded families. [*"Why it is nevertheless the live route"*](../findings/second-order.md#L238) needs rewriting around that.

### W5. "The observed margin is uniform" is false on the record.

> [second-order.md:226](../findings/second-order.md#L226): *"Ungraded points violate by a wide margin… so $\lambda_{\max}\ge\tfrac34$ throughout… Any argument here needs only a strict violation, and the observed margin is uniform."*

The margin is measured on the subalgebra family and the multi-block products, all symmetric constructions, the brief's flag #1 exactly. Padded $W_{\mathbb{CP}^2}$ is ungraded with margin **zero** ([:88](../findings/second-order.md#L88)). "Uniform" is a property of the sample.

### W6. Four uncorrected internal contradictions.

| # | claim | contradicted by | note |
|---|---|---|---|
| 1 | [:405](../findings/nondegeneracy.md#L405) *"Every ungraded $S=0$ point found sits low, $\theta/\theta_0\le0.53$ measured and capped at $0.89$"* | [:365](../findings/nondegeneracy.md#L365) *"The claim that ungraded $S=0$ points sit at $\theta/\theta_0\le0.53$, capped at $0.89$, is **false**"* | the refuted claim is restated as fact 40 lines later, in the same file |
| 2 | [:49](../findings/nondegeneracy.md#L49) *"the exact $\theta$ formula converts that into $\theta$ below the graded ceiling. **No estimate at any step**"* | [:430](../findings/nondegeneracy.md#L430) *"The repeated claim that the route needs 'no estimate at any step' is withdrawn"* | the withdrawn claim still opens the section it was the motivation for |
| 3 | [:76](../findings/nondegeneracy.md#L76) *"To close P3b it must hold at every graded critical point… should apply to each"* | [:444](../findings/nondegeneracy.md#L444) *"that every graded critical point is nondegenerate… **is false**"* | the plan survives its own refutation |
| 4 | [:149](../findings/nondegeneracy.md#L149) *"$S$ is lower semicontinuous, not continuous, and not locally constant"* | [:432](../findings/nondegeneracy.md#L432) *"$S$ is locally Lipschitz across eigenvalue crossings"* | reconcilable (sphere vs. $\mathrm{Crit}$), but the two headlines clash as printed and RESULT 2 at [:157](../findings/nondegeneracy.md#L157) adds a third |

Each is a reader trap of the kind that let the sign inversion stand for three commits.

### W7. Catalogue evidence cited where a proof exists in the same record.

[nondegeneracy.md:35](../findings/nondegeneracy.md#L35): *"On the subalgebra family the other two [grading conditions] hold identically ($\le10^{-14}$ across every catalogued point)"*. They hold **by construction**: $\mathfrak h$ a subalgebra gives $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, and $\mathfrak m=\mathfrak h^\perp$ being $\mathrm{ad}(\mathfrak h)$-invariant gives $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, which [second-order.md:218](../findings/second-order.md#L218) states as the structural reason. The measurement is a control; presenting it as the evidence invites the flag it does not deserve.

Also in this bucket, honestly self-labelled and needing no action beyond staying labelled: the value-localised hypothesis at [nondegeneracy.md:534](../findings/nondegeneracy.md#L534) (*"every known degenerate graded point"*), and the excess census at [second-order.md:122](../findings/second-order.md#L122) (which already says *"that evidence is drawn entirely from the symmetric catalogue and… cannot settle the question"*).

### W8. On random screens, a distinction the files get right and should keep.

Random Weyl / random symmetric directions are used in these files to **verify identities** ([nondegeneracy.md:15](../findings/nondegeneracy.md#L15), [:75](../findings/nondegeneracy.md#L75)). That is the correct use: an identity that fails on a generic point is refuted. No claim in either file uses a random screen as evidence of *absence* of structured counterexamples, and the two places that come closest are explicitly recorded as broken instruments ([second-order.md:89](../findings/second-order.md#L89) *"Random $3$-planes reach only $0.5634$, a broken instrument for this constant"*; [:81](../findings/second-order.md#L81) *"A naive random-direction climber… is a broken instrument"*). Clean on this axis.

---

## Clean, passed the substitution, one line each

- **Lemma L24**, Hessian $=6\theta(L_e-\tfrac12)$; correct, prior art correctly attributed, sharpness correctly labelled structural (see T5).
- **Lemma L26**, $e\circ X=\mu X$ with $\mu=(n-2)/(2(p-1)(q-1))$; criticality's entry point is stated explicitly and the three-block form $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ is criticality-free. The "what it does not reach" paragraph is exemplary.
- **Lemma L27**, sphere products nondegenerate; Schur reduces to ten scalars and the scalars separate. Untouched by substitution.
- **Lemma L28** / the $\mathbb{CP}^m$ table, $\lambda_S=1-(c_S+q_S^2)/(4(m+1))$, nondegeneracy as the arithmetic condition $c_S+q_S^2=2(m+1)$. Three independent derivations, honest about the fourth.
- **Lemma L51** and the jet, $Bu=z\circ z$, $[t^3]P=T(z,z,z)$, $[t^4]P=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8$; vacuity on the orbit tangent proved unconditionally.
- **The harmonic-square law** $1/\theta^2=\sum1/\theta_i^2$, the one place criticality substitution does real work and yields content; the two-line derivation from $A\circ B=0$ at [second-order.md:31](../findings/second-order.md#L31) is correct and the Frobenius-orthogonality corollary is a genuine strengthening.
- **$\dim E(1)=1\Rightarrow\circ$-indecomposable**, proves a negative about splittings nobody has constructed; correct and unusually strong.
- **Fence post F14**, the round sphere at $\sqrt{2(n-1)/n}>\theta_0$ shows dropping Ricci-flatness manufactures a false refutation. Valuable and correct.
- **Fence post F12**, one catalogued counterexample suffices to show a bound is too weak; legitimate use of the catalogue.
- **The diagonal census over triangle-free isomorphism classes** at $n=6,7$, exhaustive, generator validated against A006785, residual risk stated.
- **$S$ in the eigenframe** $=\sum_{\lambda<0}c'^2$, and $S_{\rm struct}=3\times(\text{triangles})$ without block-constancy.
- **$\dim\mathfrak m\le2\Rightarrow S=0$**, structural, from three-index antisymmetry of $c'$.
- **Triality at $n=8$** and the $\mathbb{HP}^2$ point; **the second-order form in structure constants** ([nondegeneracy.md:13](../findings/nondegeneracy.md#L13)) as an identity; **the witness-not-determined self-correction** at [:31](../findings/nondegeneracy.md#L31); **the $\Phi$ non-decreasing-in-$r$ guard**; **the gauge-fixing standing rule** ($\min_g\|gW'g^{\mathsf T}-W_0\|$); **the $\Phi$-quadratic-tested-on-a-basis lesson**.

---

## What a successor should take from this

1. **Write down the off-diagonal criticality constraints** (S3). $\binom I2$ exact bilinear relations on $c'$ in $W$'s eigenframe, currently unused, in the one variable that is not already spent.
2. **Replace the moment method's recorded epitaph with T2.** The hierarchy collapses to two scalars $(\theta,\mathop{\mathrm{tr}}W^3)$ and the second is $O(1/n^2)$ at the maximiser. That is dimension-uniform and final, where "only lower bounds" is not.
3. **Downgrade every ascent-derived supremum in [second-order.md](../findings/second-order.md) to a lower bound** and reopen the two headings that claim closure (W3). This is bookkeeping, not mathematics, and it currently makes $n=6$ look settled when it is not.
4. **Repair the four contradictions in W6 and the quantifier in Observation L25** before either file is cited again.
5. **Stop describing $\langle W^\#,W\rangle$ as alignment data on the critical set** (T1). It is $\theta-\mathop{\mathrm{tr}}(W^3)$. The alignment lives in $c'$ and in $L_W|_{W^\perp}$, and nowhere else in these two files.
