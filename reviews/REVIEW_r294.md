# Reviewer 294, pinning $Q_\gamma$ by criticality, and whether it escapes a fenced class

**Verdicts: D1 CONFIRMED (with the brief's own restatement of $T$ off by a factor of $4$), D2 CONFIRMED, D3 CONFIRMED and tautological, D4 REFUTED.** D1–D3 are correct algebra, and the audit's finding is that they are correct in a way that makes them empty: D2 is *literally* the $\gamma\gamma$ entry of $Q(W)=\theta W$ divided by $\lambda_\gamma$, and D3 is *literally* $g_\gamma\ge0$. D4 is the claim to attack and it does not survive. Its conclusion (the route does not close), is right, and I can support it far more strongly than the record does; but every load-bearing step of the argument it gives is wrong, and its central quantitative assertion fails at the very spectrum that certifies the ceiling it invokes.

Scripts, all my own implementation from the definitions: [core294.py](../scripts/reviewers/r294/core294.py), [d1_d2.py](../scripts/reviewers/r294/d1_d2.py), [d2_press.py](../scripts/reviewers/r294/d2_press.py), [crit_hunt.py](../scripts/reviewers/r294/crit_hunt.py), [d3_bound.py](../scripts/reviewers/r294/d3_bound.py), [d3_joint.py](../scripts/reviewers/r294/d3_joint.py), [d4_lp.py](../scripts/reviewers/r294/d4_lp.py), [d4_verify.py](../scripts/reviewers/r294/d4_verify.py), [d4_witness.py](../scripts/reviewers/r294/d4_witness.py), [d4_search.py](../scripts/reviewers/r294/d4_search.py), [d4_cross8.py](../scripts/reviewers/r294/d4_cross8.py).

| claim | verdict | one line |
|---|---|---|
| D1 $Q_\gamma=2\langle W^\#v_\gamma,v_\gamma\rangle$ | **CONFIRMED** | exact for the record's $T=(c')^2$, at every symmetric operator; the brief's restatement $T=(c'/2)^2$ makes it false by $4$ |
| D2 the $\theta$ formula | **CONFIRMED** | it is $\langle(Q(W)-\theta W)v_\gamma,v_\gamma\rangle/\lambda_\gamma=0$, so $g_\gamma$ and $X_\gamma$ cancel; valid at $\lambda_\gamma<0$ too, empty at $\lambda_\gamma=0$ |
| D3 the inequality and its $\Delta=0$ equality | **CONFIRMED** | it is $g_\gamma\ge0$; the equality cannot be strict, because $\Delta=0$ kills the psd form on all of $\mathfrak p$ |
| D4 the route status | **REFUTED** | four independent breaks; the conclusion survives on evidence D4 does not use |

## Anchoring

$\mathfrak{so}(n)\cong\Lambda^2$ through $\phi_{ij}=E_{ij}-E_{ji}$, $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$; $c_{\alpha\beta\gamma}=\langle[\phi_\alpha,\phi_\beta],\phi_\gamma\rangle$, $(W^\#)_{\alpha\beta}=-\tfrac12\mathop{\mathrm{tr}}(A_\alpha WA_\beta W)$, $Q(W)=W^2+W^\#$, $\theta=\langle W,Q(W)\rangle$. Written independently and then checked against the record: $\lVert\#_{294}-\#_{r30}\rVert_\infty=0$ exactly at $n=5,6,7$, $\theta$ agreeing to $1.4\times10^{-17}$, $\dim\mathrm{Weyl}_n=35,84,168$ matching the formula, and $\theta(S^3\times S^3)=1.054092553$, $\theta(\mathbb{CP}^2)=1.224744871$, $\theta(S^6\times S^6)=1.236033$. All test points are screened for Ricci-flatness and Bianchi before any $\theta$ is quoted.

## D1, CONFIRMED, and the brief's stated $T$ is off by a factor of $4$

**Pin the constant from the code, not from the prose.** [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) computes `T = (0.5 * einsum('abij,cij->abc', br, v)) ** 2`, and that `einsum` is the *full matrix contraction* $\sum_{ij}$, which is $2\langle\cdot,\cdot\rangle$ under $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$. So the $0.5$ converts the contraction into the inner product and the record's tensor is

$$T_{\gamma\alpha\beta}=(c'_{\gamma\alpha\beta})^2,\qquad c'_{\gamma\alpha\beta}=\langle[v_\gamma,v_\alpha],v_\beta\rangle ,$$

**not** $(c'/2)^2$ as the brief restates it. With the code's $T$, D1 is exact. With the brief's, it is false by a factor of $4$: measured $Q_\gamma/\langle W^\#v_\gamma,v_\gamma\rangle=0.5$ rather than $2$ at $S^3\times S^3$.

**Proof, one line.** In the eigenframe $A'_\gamma$ has entries $c'_{\gamma\alpha\beta}$ and $W=\mathrm{diag}(\lambda)$, so $\langle W^\#v_\gamma,v_\gamma\rangle=-\tfrac12\mathop{\mathrm{tr}}(A'_\gamma\Lambda A'_\gamma\Lambda)=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta(c'_{\gamma\alpha\beta})^2=\tfrac12Q_\gamma$. The rotation is legitimate because $\#$ is equivariant under any orthogonal change of frame of $\Lambda^2$ once $c$ is rotated with it.

**It holds at every symmetric operator on $\Lambda^2$, critical or not, Weyl or not.** The derivation uses only the definition of $\#$ and an orthonormal eigenframe, so nothing beyond the eigendecomposition is in play: residual $\le3.9\times10^{-16}$ at random symmetric $W$ with Ricci residual $0.28$–$0.39$, and $\le4.4\times10^{-16}$ at random $\mathrm{Weyl}_6$. Consistency: $\sum_\gamma\lambda_\gamma Q_\gamma=2\langle W^\#,W\rangle$ follows immediately, which is the record's own contraction.

## D2, CONFIRMED, and it is the criticality equation itself

Exact at every catalogued critical point, residual $\le2.7\times10^{-15}$: $S^3\times S^3$, $S^5\times S^7$, $S^6\times S^6$, $\mathbb{CP}^2$, $\mathbb{CP}^3$, $\mathbb{CP}^4$, and at $30$ ungraded critical points at $n=6$ that I found myself by Levenberg–Marquardt on $Q(W)-\theta W$ (residual $\le10^{-11}$, $\theta\in[0.007,0.387]$, $\Delta\in[5.1,8.4]$).

**But it is a re-labelling and nothing more.** Substituting $g_\gamma=2X_\gamma-2Q_\gamma$ (with $X_\gamma:=\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$) into D2's right-hand side cancels the $X_\gamma$ terms outright:

$$\frac{X_\gamma}{2\lambda_\gamma}+\lambda_\gamma-\frac{g_\gamma}{4\lambda_\gamma}-\theta=\lambda_\gamma+\frac{Q_\gamma}{2\lambda_\gamma}-\theta=\frac{\langle(Q(W)-\theta W)v_\gamma,v_\gamma\rangle}{\lambda_\gamma}.$$

Verified as an identity, residual $\le2.3\times10^{-14}$ on random $\mathrm{Weyl}_6$ where the D2 residual itself ranges over $[-16.6,+10.2]$. **So D2 is exactly the $\gamma\gamma$ entry of $Q(W)=\theta W$, divided by $\lambda_\gamma$**, neither $g_\gamma$ nor $X_\gamma$ survives the substitution, and the symmetry defect enters the statement only to be cancelled again.

Four consequences the brief asks about.

- **$\lambda_\gamma<0$ works identically.** The derivation divides by $\lambda_\gamma$ and needs only $\lambda_\gamma\ne0$. Measured residual $\le2.7\times10^{-15}$ on the negative rows of all six catalogued points. The restriction to $\lambda_\gamma>0$ belongs to D3's inequality, not to D2.
- **$\lambda_\gamma=0$ carries no $\theta$ at all.** The identity degenerates to $g_\gamma=2X_\gamma$. At padded $W_{\mathbb{CP}^2}$ in $n=8$ ($25$ zero eigenvalues) this holds to $2.2\times10^{-16}$ with $X_\gamma$ ranging over $[0,0.5]$, so the rows are non-trivial but say nothing about $\theta$.
- **Degeneracy is harmless.** Each of $X_\gamma$, $g_\gamma$, $Q_\gamma$ is a well-defined function of the single unit vector $v_\gamma$ ($R_{\gamma\alpha}=\lVert[v_\gamma,v_\alpha]\rVert^2$ is basis-free in $\alpha$), and at a critical point $Q(W)=\theta W$ holds as an operator equation, so the identity holds for **every** unit vector in an eigenspace. Rotating inside the $6$-dimensional positive eigenspace of $S^3\times S^3$ by a random $O(6)$ leaves the residual at $4.4\times10^{-16}$.
- **Criticality is needed, but only its diagonal.** D2 fails off the critical set, residuals up to $16.6$ at random $\mathrm{Weyl}_6$ with criticality residual $0.10$–$0.14$, and $\pm0.002$ at $S^3\times S^3$ perturbed by $10^{-3}$. What it needs is precisely $\langle Q(W)v_\gamma,v_\gamma\rangle=\theta\lambda_\gamma$ in that one row, which is strictly weaker than $Q(W)=\theta W$.

## D3, CONFIRMED, and it is the statement $g_\gamma\ge0$

Given D2, "$\theta\le X_\gamma/(2\lambda_\gamma)+\lambda_\gamma$ with slack $g_\gamma/(4\lambda_\gamma)$" is equivalent to $g_\gamma\ge0$, i.e. to $\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2\ge0$. Nothing else enters.

- **A $\Delta=0$ critical point with strict inequality cannot exist.** $x\mapsto\lVert[\mathrm{ad}(x),W]\rVert^2$ is a positive semidefinite quadratic form and $\Delta$ is its trace over $\mathfrak p$; trace zero on a psd form forces the form to vanish on $\mathfrak p$, hence $g_v=0$ for **every** $v\in\mathfrak p$, for every choice of eigenbasis inside a degenerate eigenspace. So the equality claim is not merely observed at the catalogue, it is unfalsifiable.
- **"A reweighting of $\Delta$" needs a caveat.** The slack sum is $\sum_{\gamma\in\mathfrak p}g_\gamma/(4\lambda_\gamma)$, which is $\Delta/(4\lambda_+)$ only when the positive spectrum is single-valued. The weights blow up as $\lambda_\gamma\to0^+$, and that is not academic: at my $n=6$ critical points the per-row slack spreads over $[0.518,1.644]$, $[0.979,2.209]$, $[0.948,2.953]$ with $\Delta=5.13$, $8.23$, $8.35$, the small positive eigenvalues, not the defect, dominate the slack.

## D4, REFUTED

The claim: *because D3 is an equality at the conjectured maximiser, pinning $Q_\gamma$ by criticality does not escape the class Reviewers 67/68 ceilinged; any bound extracted from D3 needs an upper bound on $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$, which is the two-moment quantity that file already maximises over the same constraint set with gain zero at the maximiser.*

One clause is right: **a bound extracted from D3 does need an upper bound on $X_\gamma$**, since $X_\gamma=2\lambda_\gamma(\theta-\lambda_\gamma)+g_\gamma/2$ pins $X_\gamma$ once $\theta$ and $g_\gamma$ are known. Everything else fails.

### Break 1, "the same constraint set" names three different lists

The class Reviewers 67/68 ceilinged is defined in [review_r67_lp.py](../scripts/reviewers/r67/review_r67_lp.py) by exactly four facts: $T\ge0$ totally symmetric vanishing on repeats; row marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$; pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$; and $T=0$ on triples inside $\mathfrak m$. **The per-row identity $R\lambda=-2\lambda$ is not on that list**, [target.md](../findings/target.md) says so in as many words, "not carried by the LP class whose ceiling Reviewers 67/68 closed", and per-row criticality is not on it either. The record's two-moment problem *does* use the per-row identity. So the three sets quoted as "the same" are: the 67/68 list; the 67/68 list plus $R\lambda=-2\lambda$; and that plus $N$ criticality equations. They have different ceilings, as measured below.

### Break 2, the ceiling is quoted in the wrong direction, and the route is much worse than $1.60/2.29/2.49$

Reviewer 67's argument runs $B(\lambda,d,n)\ge\mathrm{LP}(\lambda,d,n)$: a bound built from the list is **above** the ceiling, so the ceiling is what makes such bounds useless. Attaching $1.60/2.29/2.49$ to the D3 route reads as though the route's bound *equals* those numbers. It does not. Computing the D3 bound exactly, $\theta\le\min_{\gamma\in\mathfrak p}[X^{\max}_\gamma/(2\lambda_\gamma)+\lambda_\gamma]$ with $X^{\max}_\gamma$ the record's own two-moment LP ($R\ge0$, $R\le2$, $\sum_\alpha R_{\gamma\alpha}=2(n-2)$, $\sum_\alpha\lambda_\alpha R_{\gamma\alpha}=-2\lambda_\gamma$), its band maximum is

| | $n=6$ | $n=8$ | $n=12$ |
|---|---|---|---|
| D3 bound, per-row $X^{\max}$ | $\ge4.7365$ | $\ge6.8509$ | $\ge10.9093$ |
| D3 bound, one **shared symmetric** $R$ and criticality rows of **both** signs | $\ge4.1203$ | $\ge6.0287$ | $\ge10.2270$ (positive rows; the both-signs sweep at $n=12$ was still running and the two variants agree exactly at $n=6$ and $n=8$) |
| 67/68 class ceiling | $1.6038$ | $2.2913$ | $2.4942$ |
| target | $1.2247$ | $1.2247$ | $1.2360$ |

So the route sits three to four times *above* the ceiling it is said to be trapped at. Strengthening it in the obvious way, one symmetric $R$ shared by all rows instead of an independent optimum per row, and the criticality row-inequality imposed at negative and zero rows too, which is strictly more than the record's version uses, buys $13\%$ and changes nothing.

**And the failure needs no relaxation at all.** At the $30$ genuine critical $\mathrm{Weyl}_6$ points I constructed, with true $\theta$ between $0.13$ and $0.39$, the D3 bound already returns $1.3074$, $1.3152$, $1.4067$, $1.4067$, $1.3129$, $1.4062$, $1.4062$, $1.4016$ at the eight highest, above $\sqrt{3/2}$ at real critical points, not at a corner of a relaxation. *That* is the honest reason the route is dead, and it is available without invoking any class argument.

### Break 3, criticality does escape the ceiling, at the class's own witness spectrum

Take the spectrum that certifies the ceiling at $n=6$, $d=4$, three positives at $0.41169$, three tiny positives, five zeros, three negatives at $-0.40411$, with the last entry fixed to make the trace exactly zero, then normalised ([d4_witness.py](../scripts/reviewers/r294/d4_witness.py)). Solve, to optimality with HiGHS, the LP maximising $\theta(\lambda,T)=\sum\lambda^3+3\sum_{\alpha<\beta<\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma t_{\alpha\beta\gamma}$ over that spectrum, adding the constraints one at a time:

| constraints | LP value at that spectrum |
|---|---|
| the 67/68 list alone | $1.640089$ |
| $+$ per-row identity $R\lambda=-2\lambda$ | $0.859509$ |
| $+$ per-row criticality $Q_\gamma=2\theta\lambda_\gamma-2\lambda_\gamma^2$ | $1.206479$ |
| $+$ both | $0.450157$ |

Each addition is a valid relaxation of critical Weyl tensors, verified by checking every constraint on the **actual** $T$ of five real critical points ($S^3\times S^3$, $S^3\times S^5$, $S^6\times S^6$, $\mathbb{CP}^3$, $\mathbb{CP}^4$: row marginal to $10^{-14}$, pair cap $\le2$, criticality to $5.6\times10^{-16}$, identity to $1.1\times10^{-15}$, $S_{\mathfrak{mmm}}\le10^{-29}$, and $\theta(\lambda,T)$ reproducing $\theta$ to $2.7\times10^{-15}$). At the spectrum where the fenced class is worth $1.64$, criticality alone is worth $1.206$ and the identity alone $0.860$, **both below the target $\sqrt{3/2}=1.224745$**. "Pinning $Q_\gamma$ by criticality does not escape the class" is false there, and the witness is one line of typed decimals, needing no search.

Over the whole band the same comparison, at equal search budget:

| constraint set, identical search budget | ceiling at $n=6$ |
|---|---|
| the 67/68 list alone | $\ge1.640087$ (Reviewer 67 reports $1.6038$; my sweep finds a better spectrum) |
| $+$ per-row identity | $\ge1.420369$ |
| $+$ per-row criticality | $\ge1.606792$ |
| $+$ both | $\ge1.400498$ |

Every entry is a maximum over spectra found by the same Nelder-Mead sweep over the same structured family ([d4_search.py](../scripts/reviewers/r294/d4_search.py)); the base row overshooting the recorded $1.6038$ shows the sweep is not the weak link. **Read these with the right modality.** Adding constraints lowers the LP at every fixed spectrum, so *ceiling(+both) $\le$ ceiling(base)* is automatic and the sweep is measuring the size of the drop, $15\%$; and since each entry is only a lower bound on its own ceiling, the sweep by itself cannot certify that the augmented ceiling is strictly below $1.6038$. **The witness above does not need it to.** Escaping the class, in Reviewer 67's own sense, means producing a bound below the value the class forces, and at $\lambda^\star$ the class forces $\ge1.640089$ while criticality permits $1.206479$. That is an escape, exhibited, at a spectrum of the record's own choosing. Whether the escape is uniform over the band is open, and it is a different question from the one D4 answers.

**At $n=8$ the same experiment says the escape is real but modest, and I report that against my own case.** My base sweep returns $2.290717$ against Reviewer 67's $2.291288$, an independent reproduction of the class ceiling; the four ceilings and the cross-evaluation of each constraint set at each optimum spectrum ([d4_cross8.py](../scripts/reviewers/r294/d4_cross8.py)) are

| ceiling at $n=8$ | value | | LP value at the optimum spectrum of | base | $+$ident | $+$crit | $+$both |
|---|---|---|---|---|---|---|---|
| the 67/68 list alone | $2.290717$ | | base | $2.290717$ | $2.290717$ | $2.219372$ | $2.179448$ |
| $+$ per-row identity | $2.290717$ | | $+$identity | $2.290717$ | $2.290717$ | $2.219372$ | $2.179448$ |
| $+$ per-row criticality | $2.142445$ | | $+$criticality | $2.263799$ | $2.074033$ | $2.142445$ | $1.857755$ |
| $+$ both | $1.931094$ | | $+$both | $2.129883$ | $2.014922$ | $1.988170$ | $1.931094$ |

So the per-row identity costs nothing at all at the $n=8$ optimum (the $n=6$ collapse under it is spectrum-specific) and the two together cost $16\%$ of the ceiling rather than the $73\%$ they cost at $\lambda^\star$. The escape is genuine at both dimensions and small at $n=8$, and it is nowhere near the target.


### Break 4, "equality at the maximiser" is not evidence of deadness

$\theta_0(n)$ is attained at the balanced sphere product, so **any** proof of Conjecture A must be an equality there. A route is killed by slack at the maximiser, never by tightness at it. The record's supporting sentence, "a bound tight at the extremiser is the original problem rather than a relaxation of it", proves nothing about this route: I measured the D3 bound at eight catalogued points and it is exact at **all** of them, $1.054093$, $1.145644$, $1.200000$, $1.236033$ at the balanced products, $1.115547$ and $1.228239$ at the unbalanced ones, $1.054093$ and $0.986013$ at $\mathbb{CP}^3$ and $\mathbb{CP}^4$, slack $\le2.2\times10^{-16}$ throughout. Exactness on two whole families and everywhere else the catalogue reaches is a *recommendation* for a bound; what condemns this one is the $4.74$ in the band, which is a different fact and needs the computation above.

### What survives

The route does not close: not at $n=6$, $8$ or $12$ in relaxation, and not even pointwise at real critical points. **That conclusion stands, and it is now supported by evidence that does not depend on the class argument at all.** What must be withdrawn is the mechanism, the identification of three distinct constraint lists, the citation of $1.60/2.29/2.49$ as this route's ceiling when the route's own value is $4.74$, and the assertion that criticality is inert against that class when it removes $26\%$ at the class's certifying spectrum and takes the value below target.

### The obligation this leaves

The criticality-augmented class is **not** exhausted by anything on record. Criticality is $N$ equations; the record carries two contractions of them and the LP class carries none. The measured ceiling of the list plus per-row criticality plus per-row identity is $\ge1.400498$ at $n=6$ and $\ge1.931094$ at $n=8$, against $1.6038$ and $2.2913$ for the list alone and targets of $1.2247$, a real gain of $15$–$16\%$, still far short. Whether those are the true ceilings or artifacts of the spectrum search, what $n=12$ gives, and whether the **off-diagonal** half of criticality ($(W^\#)_{\gamma\delta}=0$ for $\gamma\ne\delta$, which no $T$-level relaxation can carry because $T$ sees only squares of $c'$) can be brought in at all, are the three things worth measuring next.
