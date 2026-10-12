# Review r100, five claims on the bi-spectral route

Reviewer 100, independent implementation. Machinery written from the brief's definitions only; no code from the programme was read or imported. Sources: [core.py](../scripts/reviewers/r100/core.py) and the phase scripts in [scripts/reviewers/r100/](../scripts/reviewers/r100/). Log: [reviewer100.log](../agent_logs/reviewer100.log).

## Verdicts at a glance

| # | Claim | Verdict |
|---|---|---|
| 1 | Gradient form of $Q$ and $W^\#$ | **REFUTED as written**, CONFIRMED with `pr` on the left; consequence **inert** |
| 2 | $S^m\times S^m$ closed form | **CONFIRMED** in full, $m=2\ldots6$, incl. Li Thm 1.8 |
| 3 | Fence post F23, the diagonal is blind | **CONFIRMED**, with a scope correction: it is the *vertex matrix* that is blind, not Schur–Horn |
| 4 | Fence post F24, no moment coupling | Rank facts **CONFIRMED**; the inference to the consequence is a **non-sequitur**, and $4.013$ is **not** the moments-only relaxation |
| 5 | The champion split | Numerics **CONFIRMED**; the reading is **true but tautological**, and "maximiser" is overread |

## Baseline: the machinery agrees

My basis of $\mathcal W_n$ has dimension $n(n+1)(n+2)(n-3)/12$ at $n=4,\dots,12$; the tensors satisfy the pair symmetries, first Bianchi and Ricci-trace-freeness to $2\times10^{-16}$. On random Weyl tensors with $\|M\|_F=1$ I get $\sum\omega^2=3$ and

$$\theta=\operatorname{tr}(M^3)+\langle M^\#,M\rangle=\tfrac32 p_3(\mu)-\tfrac12 p_3(\omega)$$

to $10^{-15}$ at every $n$ tested. The record's identity is reproduced independently.

Two conventions that had to be right for this to work, and are worth pinning in the record: Li's index order $W_{iklj}$ (with $ikjl$ the spectrum is negated), and the *unnormalised* $\phi_{ij}=E_{ij}-E_{ji}$ in the sharp. Both as the brief states.

## Claim 1, the gradient form

**The literal identity is false.** $W^\#$ does not lie in $\mathcal W_n$:

| $n$ | rel. err. of $W^\#=\tfrac12\mathrm{pr}(W^2)-\tfrac12\mathrm{pr}(\iota^*(\mathring W^2))$ | rel. err. with `pr` on the left | $\|M^\#-\mathrm{pr}(M^\#)\|/\|M^\#\|$ |
|---|---|---|---|
| 4 | 5.77e-01 | 5.8e-16 | 0.577 |
| 5 | 6.15e-01 | 5.8e-16 | 0.615 |
| 6 | 6.10e-01 | 6.4e-16 | 0.610 |
| 7 | 5.67e-01 | 7.8e-16 | 0.567 |
| 8 | 5.68e-01 | 8.7e-16 | 0.568 |

About 60% of $\|M^\#\|$ lives outside $\mathcal W_n$. This is expected: Hamilton's flow $\dot R=R^2+R^\#$ preserves the algebraic curvature tensors but moves the Ricci part, so the sharp of a Weyl tensor has a Ricci component. **Correction to the record: the identity holds as $\mathrm{pr}(W^\#)=\tfrac12\mathrm{pr}(W^2)-\tfrac12\mathrm{pr}(\iota^*(\mathring W^2))$, and only in that form.**

**Second correction: $Q$ is $\nabla\theta/3$, not $\nabla\theta$.** Componentwise I get $\nabla\theta/Q=3.000000$ exactly at every $n$ and every component tested. Calling $Q$ "the gradient form" without the factor invites the same mistake downstream.

**The claim carries no information beyond the identity already on the record.** The trilinear form $\langle M^\#(A,B),C\rangle$ is fully symmetric (verified to $10^{-10}$ at $n=4\ldots8$), so $\nabla\langle M^\#,M\rangle=3M^\#$ and the corrected Claim 1 is *exactly* the gradient on $\mathcal W_n$ of $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$. Conversely, contracting Claim 1 with $W$ returns that identity. The two are equivalent. Claim 1 is a restatement, correctly derived, and should be recorded as such rather than as a new structural fact.

**The consequence is inert.** Two separate reasons.

- *The PSD-ness does not survive.* $\mathrm{pr}(W^2)$ and $\mathrm{pr}(\iota^*(\mathring W^2))$ are indefinite in **30 out of 30** random samples at $n=5,6,8$ (worst minimum eigenvalues $-0.193$ and $-0.535$ at $n=5$). "Both PSD before projection" describes objects that the projection destroys, and it is the projected objects the identity is about.
- *The decomposition is not canonical.* Set $J(W)=M\oplus\mathring W$, a single linear image of $W$ into $\mathrm{Sym}(\Lambda^2\oplus S^2_0)$. Then $J(W)^2=M^2\oplus\mathring W^2$ is one PSD square, and Claim 1 reads $\mathrm{pr}(W^\#)=\tfrac12\,\mathrm{pr}\!\circ\!(\pi_1-\pi_2)(J(W)^2)$. The sign lives entirely in the signed read-out map, not in the squares. Any number of such splittings exists; "difference of two squares" is doing no work.

To be fair to the claim: it is *not* vacuous in the trivial sense the brief floats. "Every symmetric operator is $A_+-A_-$" is a pointwise statement with $A_\pm$ depending non-linearly on $W$; here the two maps are fixed and linear. That much is genuine. It simply yields no sign, because $\theta$ pairs the two squares with opposite signs by construction.

## Claim 2, the maximiser's closed form

**CONFIRMED entirely.** I built the Riemann tensor of $S^m(1)\times S^m(1)$ directly and took its Weyl part by orthogonal projection onto my $\mathcal W_n$, no use of Thm 1.8, so this is an independent route to the same answer.

| $m$ | $n$ | $\omega$-clusters found | matches claim | $p_3(\mu)-A$ | $p_3(\omega)+(4m^2\!-\!6m\!-\!1)A$ | $\theta-\theta_0(2m)$ |
|---|---|---|---|---|---|---|
| 2 | 4 | $(0.5774,4),(-0.2887,4),(-1.1547,1)$ | yes | -2.8e-16 | 3.3e-16 | -3.3e-16 |
| 3 | 6 | $(0.3162,10),(-0.2108,9),(-1.2649,1)$ | yes | 2.8e-17 | 3.1e-15 | -2.2e-16 |
| 4 | 8 | $(0.2182,18),(-0.1637,16),(-1.3093,1)$ | yes | -1.8e-16 | -1.3e-15 | -2.2e-16 |
| 5 | 10 | $(0.1667,28),(-0.1333,25),(-1.3333,1)$ | yes | -3.1e-16 | -3.6e-15 | 2.2e-16 |
| 6 | 12 | $(0.1348,40),(-0.1124,36),(-1.3484,1)$ | yes | -7.3e-16 | 8.9e-16 | -6.7e-16 |

Multiplicities $(m-1)(m+2)$, $m^2$, $1$ match exactly. The algebra also closes symbolically: $\tfrac32A+\tfrac12(4m^2-6m-1)A=(2m-1)(m-1)A=\sqrt{(m-1)(2m-1)}/m=\theta_0(2m)$.

**Li 2022 Thm 1.8 verified independently**, and on harder cases than the balanced one, asymmetric dimensions and unequal Einstein constants, where a wrong $-\frac{n_1\rho_2+n_2\rho_1}{n_1+n_2}$ would show:

| product | $n$ | dim | max diff |
|---|---|---|---|
| $S^3(1)\times S^3(1)$ | 6 | 20 | 1.1e-15 |
| $S^2(1)\times S^4(1)$ | 6 | 20 | 4.4e-16 |
| $S^3(1)\times S^5(1)$ | 8 | 35 | 4.4e-16 |
| $S^3(2)\times S^4(0.5)$ | 7 | 27 | 1.3e-15 |
| $S^2(3)\times S^3(1)$ | 5 | 14 | 8.9e-16 |
| $S^4(1)\times S^4(2)$ | 8 | 35 | 4.4e-16 |

The passage from $\mathring R$ to $\mathring W$ is validated by outcome: my direct projection reproduces the claimed $\mathring W$ spectrum without ever invoking the theorem.

Spanning is not load-bearing here, the claim is evaluated at one point.

## Claim 3, the diagonal is blind

**Part A confirmed, and it is a two-line theorem, not a numerical fact.** With $\varphi_{ij}=(e_ie_j^\top+e_je_i^\top)/\sqrt2$,

$$\langle\varphi_{ij},\mathring W\varphi_{ij}\rangle=\tfrac12\big[W_{iijj}+W_{ijij}+W_{jiji}+W_{jjii}\big]=W_{ijij},$$

the first and last vanishing by antisymmetry. Numerically $\max|\mathring W_{\varphi\varphi}-W_{ijij}|<6\times10^{-17}$ at $n=5,6,7,8$.

**Part B confirmed, with a reading correction.** The brief's ratios $-0.032,-0.008,-0.003,-0.001$ are the sum over the **full** $S^2_0$ diagonal ($\varphi$ *and* $\psi$ blocks), not the $\varphi$-diagonal alone:

| $m$ | $n$ | $p_3(\omega)$ | $\sum_\varphi d^3$ ratio | $\sum_{\text{all}}d^3$ ratio | brief |
|---|---|---|---|---|---|
| 3 | 6 | -1.791957 | -0.0588 | **-0.0324** | -0.032 |
| 4 | 8 | -2.127624 | -0.0256 | **-0.0084** | -0.008 |
| 5 | 10 | -2.300000 | -0.0145 | **-0.0030** | -0.003 |
| 6 | 12 | -2.404646 | -0.0093 | **-0.0012** | -0.001 |

Worth stating explicitly, because the $\psi$-block contribution is basis-dependent within the trace-free diagonals while the $\varphi$-block is not.

**Scope correction, and it matters for what the fence post rules out.** I tested 200 random $O(n)$ frames at $m=3,4$: the ratio stays inside $[-0.034,+0.006]$ and $[-0.009,+0.003]$. So the blindness is robust across the entire orbit of NPW bases, which strengthens the claim. **But in the eigenbasis of $\mathring W$ the diagonal *is* $\omega$ and $\sum d^3=p_3(\omega)$ exactly, ratio $1$.** Schur–Horn quantifies over all orthonormal bases; the sup of $\sum d^3$ over the permutohedron is therefore at least $p_3(\omega)$, attained at a vertex.

The defensible statement is: **the vertex matrix $K_{ab}=W_{abab}$ (equivalently the $O(n)$-frame-induced diagonal), cannot bound the second cubic.** The statement "Schur–Horn on the diagonal cannot bound the second cubic" is false as phrased, since Schur–Horn is basis-free and its extreme case recovers $p_3(\omega)$ in full. A second, independent obstruction is worth recording alongside: majorization $d\prec\omega$ gives $\sum f(d)\le\sum f(\omega)$ only for convex $f$, and $x^3$ is not convex on $\mathbb R$, so the inequality has no sign in the needed direction regardless of basis.

Claim 3 is true and, in its corrected scope, correctly kills that route.

## Claim 4, no moment coupling

### The rank facts reproduce exactly

Samples span $\mathcal W_n$ in every case (coefficient-matrix rank $=\dim\mathcal W_n$: 35/35, 84/84, 168/168, 300/300), so a rank shortfall could not be a sampling artifact. Spanning **is** load-bearing here, and it holds.

| $n$ | $\dim\mathcal W_n$ | rank$\{\operatorname{tr}M^4,\operatorname{tr}\mathring W^4,1\}$ | rank of the 5-set | smallest s.v. ratio (5-set) |
|---|---|---|---|---|
| 5 | 35 | 3/3 | **4/5** | 0 |
| 6 | 84 | 3/3 | 5/5 | 0.0041 |
| 7 | 168 | 3/3 | 5/5 | 0.0028 |
| 8 | 300 | 3/3 | 5/5 | 0.0020 |

**The direction of the rank argument is used correctly.** A full-rank value matrix exhibits a witness set on which no linear relation holds, which refutes an identity. The converse move (inferring a relation from a rank shortfall), is the one that needs care, and the brief does not make it.

### But the scope of "no algebraic relation" is too wide

Rank 3 and rank 5 refute *linear* relations among *those listed* invariants with constant coefficients. Three results show the wider phrasing "no algebraic relation coupling the moments of $\mu$ and $\omega$ at degree 3 or 4" is false as stated.

1. **At degree 3 a relation exists the moment you admit $\langle W^\#,W\rangle$.** rank$\{p_3(\mu),p_3(\omega),\langle W^\#,W\rangle,1\}=3/4$ at $n=6,7,8$, with null vector $(-\tfrac12,+\tfrac12,1,0)$, that *is* the record's own $\theta$ identity. The moments of $\mu$ and $\omega$ are coupled at degree 3; the coupling is $\theta$ itself.
2. **At $n=4,5$ the two spectra are rigidly locked.** On unnormalised samples, $\;p_3(\omega)=-3\,p_3(\mu)\;$ to $2\times10^{-13}$, failing from $n=6$ (residual $3\times10^{2}$). So $\theta=3p_3(\mu)$ there and the problem collapses to a single spectrum. This is a genuine algebraic relation coupling the two spectra at degree 3.
3. **The $n=5$ shortfall in the 5-set has a name.** The null vector is $(-1,0,\tfrac12,-\tfrac12,0)$, i.e. $\;\operatorname{tr}M^4=\tfrac12\langle W^\#,W^\#\rangle-\tfrac12\langle W^\#,W^2\rangle$, exact to $3\times10^{-13}$ at $n=4$ and $n=5$, failing from $n=6$. The brief records the rank as "4 of 5" without identifying it.

None of this rescues the route, since the interesting range is large $n$. It does correct the record: the honest statement is *"among $\{\operatorname{tr}M^4,\operatorname{tr}\mathring W^4,\langle W^\#,W^\#\rangle,\langle W^\#,W^2\rangle,1\}$ there is no linear relation for $n\ge6$."*

### The consequence does not follow, and the number is wrong

**The inference is a non-sequitur, exactly as the brief suspects.** "No polynomial identity among low-degree moments" says the joint moment map has full-dimensional image. "No moments-only inequality can be sharp" is a statement about the *shape* of that image, specifically about whether $\sup\{\tfrac32x-\tfrac12y\}$ over the closed convex hull of the realisable body $\mathcal S_n=\{(p_3(\mu),p_3(\omega)):W\in\mathcal W_n,\|M\|_F=1\}$ equals $\theta_0(n)$. A full-dimensional convex body has supporting hyperplanes in every direction; full-dimensionality is no obstruction to sharpness at all. The two statements are independent.

In fact the correct reading inverts the claim: **the moments-only relaxation in $(p_3(\mu),p_3(\omega))$ is sharp by construction**, since $\sup_{\mathcal S_n}(\tfrac32x-\tfrac12y)=\max\theta$ identically. Everything hinges on knowing $\mathcal S_n$, which is realisability. The brief's destination ("the bi-spectral route must use realisability or it is a restatement"), is right; the route it takes there is not.

**And $4.013$ is not the moments-only relaxation.** It is the relaxation to the *product of the two Okumura caps*, and those caps are themselves far from attained on $\mathcal W_n$. Ascent lower bounds on the true marginals:

| $n$ | $\max p_3(\mu)$ | Okumura cap | attained | $\max(-p_3(\omega))$ | Okumura cap | attained | product-of-*true*-marginals | Okumura product | $\theta_0(n)$ |
|---|---|---|---|---|---|---|---|---|---|
| 6 | 0.5446 | 0.8971 | 61% | 1.7920 | 4.7980 | 37% | **1.713** | 3.745 | 1.054 |
| 8 | 0.5728 | 0.9456 | 61% | 2.1276 | 4.9708 | 43% | **1.923** | 3.904 | 1.146 |
| 12 | 0.7256 | 0.9771 | 74% | 2.4046 | 5.0944 | 47% | **2.291** | 4.013 | 1.236 |

I reproduce the brief's $4.013$ at $n=12$ exactly, so we are computing the same thing. But the honest moments-only figure is $2.291$, not $4.013$, the Okumura bound on $-p_3(\omega)$ is loose by better than a factor of two on $\mathcal W_n$, because Okumura is sharp only for spectra of the form $(\text{one},\,\text{rest equal})$ and $\mathring W$ never realises that shape here. Roughly half the quoted $3.25\times$ gap is Okumura slack, not bi-spectral slack.

The claim's conclusion survives, $2.291>1.236$, so the product of marginals still fails to close, but it survives for the reason the brief names in passing rather than the one it argues, and the quoted margin overstates the case by 75%. **The load-bearing fact is that the two marginal maxima are not simultaneously attainable** (the joint max is 54% of the marginal sum at $n=12$), which is a statement about the joint body, i.e. about realisability. That is the fence post; the rank computation is not.

## Claim 5, the champion split

**The numerics reproduce exactly**, 40 multistarts at $n\le10$, 18 at $n=12$:

| $n$ | $\theta_0(n)$ | $\max\theta$ found | $\max(-p_3\omega)$ found | $\theta$ at that argmax |
|---|---|---|---|---|
| 6 | 1.054093 | 1.224745 | 1.791957 | 1.054093 |
| 8 | 1.145644 | 1.224745 | 2.127624 | 1.145644 |
| 10 | 1.200000 | 1.224745 | 2.300000 | 1.200000 |
| 12 | 1.236033 | **1.236033** | 2.404646 | 1.236033 |

Both champions are identified beyond doubt by spectrum, not by coefficient overlap:

- The $\theta$-champion at $n=6,8$ has $\operatorname{rank}M=3$ with $\mu=(2,-1,-1)/\sqrt6$ and $\omega=\{-0.8165^{(3)},0.4082^{(6)}\}$, the self-dual Weyl tensor of $\mathbb{CP}^2$ padded into $\mathbb R^n$, $\theta=\sqrt{3/2}$.
- The $-p_3(\omega)$-champion at $n=8$ has $\omega$-clusters $(-1.309307,1),(-0.163663,16),(0.218218,18)$, which is Claim 2's $m=4$ prediction to six figures.
- At $n=12$ the $\theta$-champion has the $m=6$ sphere-product spectrum exactly.

Both are strict local maxima, not merely ascent endpoints: projected gradient $2.6\times10^{-8}$, and the tangent Hessian on a random 40-dimensional slice has all eigenvalues $\le-2.4$ ($\mathbb{CP}^2$, $n=8$) and $\le-3.4$ (sphere product, $n=12$).

**"Maximiser" is overread, the brief flags this and the flag is correct.** Ascent bounds from below. What is established is: these are strict local maxima, and 40 independent starts found nothing better. The upper bound (the direction Conjecture A actually needs), is untouched. The word should be "champion" or "best point found" throughout.

**The claimed reading is true but tautological.** Decomposing $\theta$ into its two cubic contributions:

| $n$ | SP first cubic $\tfrac32p_3\mu$ | SP second $-\tfrac12p_3\omega$ | $\mathbb{CP}^2$ first | $\mathbb{CP}^2$ second | $\theta_{SP}-\theta_{\mathbb{CP}^2}$ |
|---|---|---|---|---|---|
| 6 | 0.158114 | 0.895979 | 0.612372 | 0.612372 | -0.170652 |
| 8 | 0.081832 | 1.063812 | 0.612372 | 0.612372 | -0.079101 |
| 10 | 0.050000 | 1.150000 | 0.612372 | 0.612372 | -0.024745 |
| 12 | 0.033710 | 1.202323 | 0.612372 | 0.612372 | **+0.011288** |
| 14 | 0.024263 | 1.237417 | 0.612372 | 0.612372 | +0.036935 |

$\mathbb{CP}^2$ splits its $\theta$ exactly 50/50 between the two cubics; the sphere product draws 97.3% of its $\theta$ from the second cubic at $n=12$, a share rising with $n$. So the reading is literally accurate. But since $\theta$ is *by definition* the sum of the two contributions, "SP's advantage on the second overtakes $\mathbb{CP}^2$'s advantage on the first" is identically "$\theta_{SP}>\theta_{\mathbb{CP}^2}$", i.e. $\theta_0(n)>\sqrt{3/2}$, i.e. $n>6+2\sqrt7$. I verify $\theta_0(6+2\sqrt7)=1.224744871=\sqrt{3/2}$. The crossover is arithmetic on two closed forms and needs no ascent.

What the ascent genuinely adds is only the negative: **no third competitor beating either champion was found**, at $n=6,8,10,11,12$. I added $n=11$ as a check (an odd dimension just below the crossover, where no balanced sphere product exists) and ascent caps at $\sqrt{3/2}=1.224745>\theta_0(11)=1.219673$, consistent.

## Sample adequacy, per claim

| Claim | Spanning load-bearing? | Status |
|---|---|---|
| 1 | Yes, identity asserted for all $W$ | Rank $=\dim\mathcal W_n$ at $n=4\ldots8$; verified |
| 2 | No, evaluated at one point | n/a |
| 3A | Yes | Verified on spanning random samples |
| 3B | No, evaluated at the sphere product | n/a; frame-orbit sweep added instead |
| 4 | **Yes, critically** | Rank $=\dim\mathcal W_n$ at $n=5,6,7,8$ (35, 84, 168, 300); verified |
| 5 | No, ascent, not sampling | Multistart count reported instead |

## True but inert

- **Claim 1** in full: equivalent to the identity already on the record, and its consequence yields no sign.
- **Claim 5's reading**: a restatement of $\theta_0(n)\gtrless\sqrt{3/2}$.
- **Claim 4's rank computation**: correct, but it is not what establishes the fence post. What establishes it is the non-simultaneity of the two marginal maxima, a realisability fact.

## Corrections the record needs

1. $W^\#=\ldots$ must read $\mathrm{pr}(W^\#)=\ldots$; $W^\#$ has ~60% of its norm outside $\mathcal W_n$.
2. $Q=\nabla\theta/3$, not $\nabla\theta$.
3. Claim 1 is a differentiated restatement of $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$, and equivalent to it.
4. Claim 3's ratios are over the full $S^2_0$ diagonal; and the scope is "the vertex matrix is blind", not "Schur–Horn is blind", in the $\mathring W$ eigenbasis the diagonal recovers $p_3(\omega)$ exactly.
5. Claim 4's "no algebraic relation at degree 3 or 4" must be narrowed to "no linear relation among the five listed invariants, $n\ge6$". At degree 3 the $\theta$ identity is itself a coupling; at $n=4,5$, $p_3(\omega)=-3p_3(\mu)$ and $\operatorname{tr}M^4=\tfrac12\langle W^\#,W^\#\rangle-\tfrac12\langle W^\#,W^2\rangle$ hold exactly.
6. Claim 4's inference "no identity $\Rightarrow$ no sharp moments-only inequality" is unsound and should be replaced by the joint-body argument.
7. $4.013$ is the Okumura-product bound, not the moments-only relaxation; the true-marginal product is $2.291$ at $n=12$.
8. "Maximiser" $\to$ "best point found / strict local maximum" throughout Claim 5.


---

## Synthesis carried in REVIEW.md

### Reviewer 100: the same five claims, on an identical brief

Full report: [reviews/REVIEW_r100.md](reviews/REVIEW_r100.md). Own implementation, independently reproducing the identity to $10^{-15}$ at $n=4$–$12$. **Agrees with 99 on four of five verdicts.**

**Where they differed, and how it resolved.** On the diagonal claim 100 returned CONFIRMED-with-scope-correction and 99 returned REFUTED. They were answering different questions and both were right: 100 asked whether $\sum d^3$ *predicts* $p_3(\omega)$ (it does not, robustly across $200$ random $O(n)$ frames) while 99 asked whether the majorization *constraint* $\omega\succ d$ cuts the feasible region, which it does, by more than half the gap. The reconciled statement is in [bispectral.md](findings/bispectral.md): the vertex matrix's cube-sum is blind, Schur–Horn is not. 100 adds the reason a one-line argument will not work, $x^3$ is not convex, so majorization supplies no sign in the needed direction, and the figures come from solving the constrained problem.

**100's independent corrections.** $W^\#\notin\mathrm{Weyl}_n$, about $60\%$ of $\lVert M^\#\rVert$ lying outside, so the gradient identity needs $\mathrm{pr}$ on the left, $5.8\times10^{-16}$ projected against $0.58$ relative error unprojected. $Q=\nabla\theta/3$, ratio exactly $3.000000$ in every component. The honest moments-only figure is **$2.291$**, not $4.013$: the marginals reach only $0.726/0.977$ and $2.405/5.094$ of their caps, and the joint maximum is $54\%$ of the marginal sum, so **the two marginal maxima are not simultaneously attainable**, a realisability fact rather than a rank fact. New exact couplings at low $n$: $p_3(\omega)=-3p_3(\mu)$ at $n=4,5$, and $\operatorname{tr}M^4=\tfrac12\langle W^\#,W^\#\rangle-\tfrac12\langle W^\#,W^2\rangle$ at $n=5$; degree 3 does couple once $\langle W^\#,W\rangle$ is admitted, the null vector being the $\theta$ identity itself.

**Claim 2 confirmed twice over**, 100 verifying it by direct projection of the product Riemann tensor without invoking Li Thm 1.8 at all, and separately checking Thm 1.8 on asymmetric dimensions and unequal Einstein constants.

**What this round cost.** Two fence posts recorded the previous day were wrong in their conclusions, and one of them (the Schur–Horn post), would have closed off the only coupling that demonstrably works. Both were single-cycle posts written after a negative result and committed before audit.
