# Review r99, five claims on the bi-spectral route

Independent implementation from the brief's definitions only, in [scripts/reviewers/r99/](../scripts/reviewers/r99/). Nothing from the code under review was imported.

## Verdict table

| Claim | Statement audited | Verdict |
|---|---|---|
| 1 | gradient form $Q$, and $W^\#$ as a difference of two squares | identity **CONFIRMED** (with a convention correction); consequence **REFUTED**, true but inert |
| 2 | closed form of the $S^m\times S^m$ $\omega$-spectrum, and $\theta=\theta_0(2m)$ | **CONFIRMED** in full, $m=2\ldots7$ |
| 3 | $\varphi$-diagonal $=K_{ab}$; ratios; "Schur–Horn cannot bound the second cubic" | first two **CONFIRMED** (one relabelling); the conclusion **REFUTED** |
| 4 | rank facts; "no moments-only inequality can close" | rank facts **CONFIRMED** (plus a new $n=5$ relation); the inference **REFUTED** |
| 5 | champion split at $n=6,8,10,12$; the crossover reading | numerics **REPRODUCED** and strengthened; the reading **TRUE BUT TAUTOLOGICAL**, with one framing overreach |

## Implementation and baseline

Built from the brief alone: $\mathrm{pr}$ as $S^2(\Lambda^2)\to$ (kill $\Lambda^4$) $\to$ (kill the Kulkarni–Nomizu image), $M_{(ij),(kl)}=W_{ijkl}$, $(\mathring Wh)_{ij}=\sum W_{iklj}h_{kl}$ in an orthonormal $S^2_0$ basis, and $M^\#$ from the commutators of $\phi_{ij}=E_{ij}-E_{ji}$ read off entrywise. Checks, all at machine precision ([p2_sanity.py](../scripts/reviewers/r99/p2_sanity.py)):

- sampled rank of $\mathrm{pr}$ = $\dim\mathcal W_n$ exactly at $n=5,\ldots,9$: 35, 84, 168, 300, 495;
- Ricci trace $\le 8.6\times10^{-16}$, first Bianchi $\le 4.3\times10^{-16}$, $\dim S^2_0=(n-1)(n+2)/2$, $\mathring W$ symmetric;
- $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ to $10^{-17}$, and $\sum\omega^2=3\sum\mu^2=3$, with **no** fitted factors anywhere.

That the brief's conventions close on the nose with an independent build is itself a result: the $iklj$ order and the unnormalised $\mathfrak{so}(n)$ basis are both load-bearing and both correct as stated.

## Claim 1, the gradient form: identity confirmed, consequence inert

**Confirmed, with a convention correction.** Both equations hold to $6\times10^{-16}$ relative at $n=5,6,7,8$ ([p3_claim1.py](../scripts/reviewers/r99/p3_claim1.py)) **provided** $W^2$ and $W^\#$ mean the adjoint pullbacks $\iota_1^*(M^2)$ and $\iota_1^*(M^\#)$, where $\iota_1:W\mapsto M$. Under the other natural reading (the plain sign-extension $J$ of a pairs matrix to a 4-tensor, which is $4\iota_1^*$), the coefficients become $2$ and $-\tfrac12$, and the claim as printed is false. The brief should say which identification it means. With the adjoint reading, a least-squares fit of $W^\#$ against the two terms returns $(\alpha,\beta)=(+0.500000,-0.500000)$ at every $n\ge6$, and $Q=\tfrac13\nabla\theta$ to $2\times10^{-11}$ by central differences over a full orthonormal basis of $\mathcal W_n$.

**The consequence is refuted on three counts.**

1. *No new content.* The identity is exactly the $\mathcal W_n$-gradient of the θ identity that the brief declares established. From $\langle M^\#,M\rangle=\tfrac12\operatorname{tr}M^3-\tfrac12\operatorname{tr}\mathring W^3$ for all $W\in\mathcal W_n$, differentiating and using the symmetry of the trilinear form $\langle M^\#,N\rangle$ gives $\mathrm{pr}(\iota_1^*(M^\#))=\tfrac12\mathrm{pr}(\iota_1^*(M^2))-\tfrac12\mathrm{pr}(\iota^*(\mathring W^2))$, Claim 1's second equation verbatim. I verified the one step that needs checking, $\nabla\langle M^\#,M\rangle=3\,\mathrm{pr}(\iota_1^*(M^\#))$, to $2\times10^{-11}$ at $n=5,6,7$ ([p3b.py](../scripts/reviewers/r99/p3b.py)). So Claim 1 restates a known identity in gradient form; it cannot be evidence for anything the θ identity is not already evidence for.
2. *The projection destroys the positivity.* $\mathrm{pr}$ is not positivity-preserving. In every sample at $n=5,6,7,8$, $\mathrm{pr}(J(M^2))$ read as a $\Lambda^2$ operator has strictly negative eigenvalues (e.g. $-0.098$ at $n=6$ against a top of $+0.103$), and likewise for $\mathrm{pr}(\iota^*(\mathring W^2))$ on $S^2_0$. $\mathrm{pr}$ also discards 40–69% of the norm of the two squares. "Both PSD before projection" is therefore a property of objects that never enter the conclusion.
3. *Pairing against $W$ is signless anyway.* The one contraction that matters is $\langle M^2,M\rangle=\operatorname{tr}M^3$, which takes both signs on the unit sphere of $\mathcal W_n$. PSD-ness of a square buys nothing when it is paired with the indefinite $W$.

**Is "difference of two squares" vacuous?** As a form, yes, every symmetric operator is such a difference. The non-vacuous part would be that the two squares are the two canonical images of $W$, and that part is the θ identity. A sharper symptom: **at $n=5$ the two squares are proportional**, $\mathrm{pr}(\iota^*(\mathring W^2))=-3\,\mathrm{pr}(\iota_1^*(M^2))$ exactly (residual $10^{-15}$, five random $W$), so the decomposition collapses to a single term and $W^\#=2\,\mathrm{pr}(\iota_1^*(M^2))$. This is new and belongs in the record.

## Claim 2, the maximiser's closed form: fully confirmed

Confirmed at $m=2,\ldots,7$ to $\le 2\times10^{-15}$ ([p4_claim2.py](../scripts/reviewers/r99/p4_claim2.py)), computing $\mathring W$ directly from the tensor and never invoking Thm 1.8:

- the $\omega$-spectrum is exactly $\{mA^{((m-1)(m+2))},\,-(m-1)A^{(m^2)},\,-2m(m-1)A^{(1)}\}$ with $A=1/(m\sqrt{(m-1)(2m-1)})$; multiplicities sum to $(2m-1)(m+1)=\dim S^2_0(2m)$;
- $p_3(\mu)=A$ exactly ($\mu$-spectrum is $\{mA^{(m(m-1))},-(m-1)A^{(m^2)}\}$, note the $\mu$-multiplicities differ from the $\omega$-ones);
- $p_3(\omega)=-(4m^2-6m-1)A$ and $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\sqrt{(m-1)(2m-1)}/m=\theta_0(2m)$, identically in $m$.

**The passage from $\mathring R$ to $\mathring W$ checks out independently.** Balanced $S^m\times S^m$ is Einstein with $\rho=m-1$, so $R=W+c\,(g\owedge g)/2$ with $c=\mathrm{scal}/(n(n-1))=(m-1)/(2m-1)$, and a constant-curvature summand acts on $S^2_0$ as $c\,\mathrm{Id}$; hence $\mathring W=\mathring R-c\,\mathrm{Id}$. Feeding Thm 1.8's $\mathrm{spec}(\mathring R)=\{1^{((m-1)(m+2))},0^{(m^2)},-(m-1)^{(1)}\}$ (each factor is a unit-curvature sphere, for which $\mathring R=\mathrm{Id}$ on $S^2_0$; the last entry is $-(n_1\rho_2+n_2\rho_1)/n=-(m-1)$) through that shift reproduces the claimed triple exactly. My computation verifies Thm 1.8's *conclusion* on this family, which is the load-bearing part; I did not audit its proof in general.

The algebra also checks symbolically: $m^3(m-1)(m+2)-m^2(m-1)^3-8m^3(m-1)^3=m^2(m-1)(-8m^3+16m^2-4m-1)$ and $-8m^3+16m^2-4m-1=-(4m^2-6m-1)(2m-1)$.

## Claim 3, the diagonal: two thirds confirmed, the conclusion refuted

**Confirmed: the $\varphi$-diagonal is the vertex matrix.** $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=W_{abab}$ to $3\times10^{-17}$ at $n=5,6,8$ ([p5_claim3.py](../scripts/reviewers/r99/p5_claim3.py)), and it drops out in two lines: with $\varphi_{ab}=(E_{ab}+E_{ba})/\sqrt2$, only the index choices $(i,k,l,j)=(a,b,a,b)$ and $(b,a,b,a)$ survive, each contributing $\tfrac12W_{abab}$.

**Correction to the ratios.** The quoted $-0.032,-0.008,-0.003,-0.001$ at $m=3,4,5,6$ are the ratios for the **full** diagonal, $\varphi$ *and* $\psi$ blocks: I get $-0.03235,-0.00845,-0.00295,-0.00116$. The $\varphi$-diagonal alone (the object the preceding sentence identifies with $K$), gives $-0.0588,-0.0256,-0.0145,-0.0094$, three to eight times larger. The claim silently switches which diagonal it means between its two sentences. (Also worth recording: the smallness is specific to the sphere product. On random Weyl tensors the ratio scatters over $[-1.2,+5.5]$ at $n=8$, so "the diagonal is blind" is a statement about the extremal point, not a generic one, which is the right place to make it, but it should be said.)

**Refuted: the conclusion does not follow, and is false.** "$\sum d^3$ is 0.1% of $p_3(\omega)$" and "Schur–Horn on the diagonal cannot bound $p_3(\omega)$" are unrelated statements. Schur–Horn does not estimate $\sum\omega^3$ by $\sum d^3$; it says $d\prec\omega$, and the question is how much that majorization constrains $\sum\omega^3$. I computed it ([p7e.py](../scripts/reviewers/r99/p7e.py), [p7f.py](../scripts/reviewers/r99/p7f.py), [p7g.py](../scripts/reviewers/r99/p7g.py)):

| $n$ | Okumura floor on $p_3(\omega)$ | with $\omega\succ d$ imposed | actual at $S^m\times S^m$ |
|---|---|---|---|
| 6 | $-4.798$ | $-2.764$ | $-1.792$ |
| 8 | $-4.971$ | $-2.906$ | $-2.128$ |
| 12 | $-5.094$ | $-2.963$ | $-2.405$ |

The constraint is **provably** non-vacuous: the Okumura minimiser fails the majorization inequalities by a cumulative-sum slack of $-3.93$ at $n=12$, so it is infeasible and the constrained minimum is strictly above the floor. The number $-2.963$ is a best-found value, stable across 150 of 150 SLSQP starts at $D=77$ and $D=20$; the true constrained minimum lies in $(-5.094,-2.963]$. Feeding it back, the moments relaxation at $n=12$ drops from $4.013$ to $2.947$, Schur–Horn on the diagonal recovers about 58% of the gap between the Okumura floor and the truth.

What survives is a weaker and different sentence: *Schur–Horn on the diagonal bounds the second cubic substantially but does not close* ($2.947$ against $\theta_0(12)=1.236$), and in a real argument the diagonal at the maximiser is not known a priori. The fence post should be rewritten to that, and the $\sum d^3$ ratio dropped from the justification, since it is not what drives the answer.

## Claim 4, the consequential one: facts right, inference unsound

**The rank facts are confirmed** ([p6_claim4.py](../scripts/reviewers/r99/p6_claim4.py)), 60 random normalised $W$ per $n$: $\{\operatorname{tr}M^4,\operatorname{tr}\mathring W^4,1\}$ has rank 3 at $n=5,6,7,8$; adding $\langle W^\#,W^\#\rangle,\langle W^\#,W^2\rangle$ gives rank 5 at $n=6,7,8$ and rank 4 at $n=5$. The direction is used correctly: a full-rank evaluation matrix certifies linear independence of the functions, and rank deficiency on 60 samples against 5 unknowns is not a sampling artefact.

**New: the $n=5$ relation, identified.** The null vector is $(-1,0,0,\tfrac12,-\tfrac12)$ with residual $3.9\times10^{-16}$, i.e.

$$\langle W^\#,W^\#\rangle-\langle W^\#,W^2\rangle=2\operatorname{tr}M^4\qquad(n=5).$$

This sits alongside the $n=5$ collapse found under Claim 1 and should be recorded rather than left as "4 of 5".

**Overshoot in the statement.** The test excludes *affine-linear* relations among five hand-picked quartics. It excludes neither higher-degree polynomial relations among them, nor relations involving other invariants of the same degree. "There is **no** algebraic relation coupling the moments at degree 3 or 4" claims more than the rank of a $60\times5$ matrix can deliver.

**The consequence is refuted as an inference, though its number is right.** I reproduce $4.012880$ at $n=12$: $\tfrac32\cdot\frac{64}{\sqrt{66\cdot65}}+\tfrac12\cdot 3^{3/2}\frac{75}{\sqrt{77\cdot76}}=1.46569+2.54719$, against $\theta_0(12)=1.236033$. Three separate problems:

1. **The rank result is inert for this conclusion.** The value $4.013$ is arithmetic on two separate Okumura caps. It needs no input from the rank computation, and the rank computation does not tighten or loosen it by anything. Whatever the rank had turned out to be, the relaxation would still evaluate to $4.013$.
2. **"No identity" does not imply "no sharp inequality".** These are logically independent. What Conjecture A needs is the upper-right boundary of the joint range of $(p_3(\mu),p_3(\omega))$ over normalised Weyl tensors, a compact planar region whose boundary is an inequality, and whose existence is untouched by the absence of a linear relation among quartics. Claim 3's own Schur–Horn computation is a live counterexample to the pattern of the inference: a genuine coupling constraint that moves the relaxation from $4.013$ to $2.947$, with no identity in sight.
3. **"No transfer inequality built from the moments can close" is false as literally written.** $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ *is* a function of the two spectra's third moments, so Conjecture A is itself an inequality in those moments, and it closes by construction. The defensible statement is narrower: *the relaxation over $\{\operatorname{tr}M=0,\ \sum\mu^2=1,\ \operatorname{tr}\mathring W=0,\ \sum\omega^2=3\}$ has value $4.013$, so those four constraints alone cannot close.* That is a statement about a chosen constraint set, not about moments as such, and it should be phrased that way before anything is built on it.

I confirm the trace conditions the relaxation uses: $\operatorname{tr}M$ and $\operatorname{tr}\mathring W$ both vanish to $10^{-16}$ at $n=6,8,12$.

## Claim 5, the champion split: reproduced, reading tautological

**Reproduced independently** with my own projected-gradient ascent, 200 random starts at $n\le10$ and 80 at $n=12$ ([p7_claim5.py](../scripts/reviewers/r99/p7_claim5.py), [p7d.py](../scripts/reviewers/r99/p7d.py)):

| $n$ | best $\theta$ found | attained at | $\theta_0(n)$ |
|---|---|---|---|
| 6 | 1.22474487 | $\mathbb{CP}^2$ (extended), 200/200 basins | 1.054093 |
| 8 | 1.22474487 | $\mathbb{CP}^2$, 194/200 | 1.145644 |
| 10 | 1.22474487 | $\mathbb{CP}^2$, 120/200 | 1.200000 |
| 11 | 1.22474487 | $\mathbb{CP}^2$, 32/80 | 1.219673 |
| 12 | 1.23603308 | $S^6\times S^6$, 37/80 | 1.236033 |

$\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ exactly and is independent of $n$ for $n\ge4$ (the $W_4$ tensor extended by zero stays trace-free in $\mathbb R^n$); ascent on $-p_3(\omega)$ alone lands on the balanced sphere product at $n=6,8,10$, and every unbalanced $S^p\times S^{n-p}$ loses on both objectives.

**Stronger than "lower bound only".** Both candidates are exact critical points ($|\nabla_{\text{tan}}\theta|\sim10^{-16}$, Euler check $\lambda/3\theta=1.000000$), and the Riemannian Hessian $\mathrm{Hess}-3\theta\,\mathrm{Id}$ has top eigenvalue exactly $0$ at $n=6,8$ (the $O(n)$-orbit kernel), with the rest strictly negative ([p7c.py](../scripts/reviewers/r99/p7c.py)). At $n=10,12$ the max Rayleigh quotient over 400 random tangents is $\approx-0.43$, and 18 seeded perturbation-ascents per candidate never escape. So these are certified local maxima modulo symmetry, not merely best-found points. Global maximality remains unproven, as the brief says.

**The reading is true but tautological.** Since $\theta=\tfrac32p_3(\mu)+\tfrac12(-p_3(\omega))$ by definition, *any* difference between two competitors decomposes as (advantage on the second cubic) minus (advantage on the first), and the crossover is where they cancel. At $n=12$: $\tfrac12(2.404646-1.224745)=0.589951$ against $\tfrac32(0.408248-0.022473)=0.578662$, difference $0.011288=\theta_0(12)-\sqrt{3/2}$. Exact, and empty of explanation. The structural fact the reading leaves out is the one worth stating: $\mathbb{CP}^2$ splits $\theta$ exactly evenly between the two cubics at every $n$ ($\tfrac32\cdot0.408248=\tfrac12\cdot1.224745=0.612372$), whereas the sphere product is asymptotically pure second cubic, $p_3(\mu)=A\to0$ and $-p_3(\omega)\to2\sqrt2$, giving $\theta\to\sqrt2$.

**One framing overreach.** $n=6+2\sqrt7\approx11.29$ is the crossover of the *interpolated* formula $\theta_0(n)=\sqrt{3/2}$, but the balanced sphere product exists only at even $n$. At $n=11$ ascent still returns $\sqrt{3/2}>\theta_0(11)=1.219673$, so for the actual family the transition is between $n=11$ and $n=12$ and $11.29$ merely falls in that gap. Calling $6+2\sqrt7$ "the crossover" reads as sharper than it is.

**Context worth flagging.** At $n=6,8,10,11$ the found maximum $\sqrt{3/2}$ **exceeds** $\theta_0(n)$. Any statement of the form $\theta\le\theta_0(n)$ is therefore false below $n=12$; the target must be $\max(\sqrt{3/2},\theta_0(n))$, or restricted to $n\ge6+2\sqrt7$. The brief's comparison at $n=12$ is unaffected.

## Sample adequacy and load-bearing-ness

- Sampled rank of my projector equals $\dim\mathcal W_n$ exactly at $n=5,\ldots,9$ (35, 84, 168, 300, 495), so the ambient space is fully resolved wherever a basis was used (the finite-difference gradients and Hessians of Claims 1 and 5).
- **Claim 1**: spanning is *not* load-bearing. The claim is a pointwise tensor identity, checked at random points and then proved structurally as the gradient of the θ identity.
- **Claim 2**: no sampling at all; single exact points, $m=2\ldots7$.
- **Claim 3**: no sampling for the exact parts; the Schur–Horn optimisation is over spectra, not over $\mathcal W_n$.
- **Claim 4**: spanning is *not* load-bearing. Rank is a property of the five functions; 60 generic points against 5 unknowns settles linear independence. What *is* load-bearing and untested is whether five hand-picked quartics are the right list.
- **Claim 5**: spanning *is* load-bearing for the Hessian certification (a full orthonormal basis was used at $n=6,8$; at $n=10,12$ the operator was applied matrix-free and only sampled), and the global-maximality question is untouched by any amount of sampling.

## True but inert

- **Claim 1** in full: an exact identity that is the gradient of an identity already on the books, with a positivity structure that the projection destroys.
- **Claim 4's rank computation** relative to its own consequence: the $4.013$ gap follows from two Okumura caps and would be unchanged whatever the rank had been.


---

## Synthesis carried in REVIEW.md

### Reviewer 99: the gradient form, the closed form, the champion split, fence posts 23–24

Full report: [reviews/REVIEW_r99.md](reviews/REVIEW_r99.md). Built from the brief alone, reproducing $\dim\mathcal W_n$ at $n=5$–$9$, the bi-spectral identity to $10^{-17}$ and $\sum\omega^2=3$ with no fitted factors.

| Claim | Verdict |
|---|---|
| The gradient form | Identity **CONFIRMED**; consequence **REFUTED**, true but inert |
| The maximiser's closed form | **CONFIRMED** in full, $m=2$–$7$ |
| The diagonal is blind | First two parts **CONFIRMED**; **the conclusion REFUTED** |
| No moment coupling | Rank facts **CONFIRMED**; **the inference REFUTED** |
| The champion split | Numerics reproduced and strengthened; the reading **TAUTOLOGICAL** |

**The correction that reopens a route.** "Schur–Horn on the diagonal cannot bound the second cubic" does not follow from $\sum d^3/p_3(\omega)\approx0.1\%$, **and it is false**. The Okumura minimiser is *infeasible* against $\omega\succ d$, cumulative slack $-3.93$ at $n=12$, so the constrained minimum is provably above the floor; a $150/150$-stable optimisation puts it at $-2.963$ against the floor $-5.094$ and the truth $-2.405$. Schur–Horn recovers about $58\%$ of the gap and cuts the relaxation from $4.013$ to $2.947$. The survivable sentence is that it bounds substantially without closing, and the $\sum d^3$ ratio comes out of the justification entirely.

**And the rank computation was inert for its own conclusion.** The $4.013$ figure is arithmetic on two Okumura caps and would be unchanged whatever the rank had been. Worse, "no transfer inequality built from the moments can close" is false as written: $\theta$ **is** a function of the two third moments, so Conjecture A is itself such an inequality. "No identity $\Rightarrow$ no sharp inequality" is unsound, and this round's own Schur–Horn result is a live counterexample to the pattern.

**Also:** the gradient form needs $W^2$ to mean $\iota_1^*(M^2)$ rather than the sign-extension, or the constants become $2,-\tfrac12$; the quoted blindness ratios are over the *full* $S^2_0$ diagonal, the $\varphi$-block alone giving $-0.059,-0.026,-0.015,-0.009$, three to eight times larger; at $n=5$ the two squares are proportional, $\mathrm{pr}(\iota^*(\mathring W^2))=-3\,\mathrm{pr}(\iota_1^*(M^2))$, and $\langle W^\#,W^\#\rangle-\langle W^\#,W^2\rangle=2\operatorname{tr}M^4$. Both champions are certified local maxima, Riemannian Hessian top eigenvalue $0$ (the orbit kernel). $n=6+2\sqrt7$ is the crossover of an *interpolated* formula, the balanced product exists only at even $n$, and at $n=11$ ascent still returns $\sqrt{3/2}>\theta_0(11)$.
