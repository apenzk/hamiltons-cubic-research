# Review r293, pinning $Q_\gamma$ by criticality: the identity is right, the route-status reason is not, and the route survives anyway

Audited at HEAD `3948aab`. Reviewer 293, adversarial, brief `brief2.md`. Scripts: [scripts/reviewers/r293/](../scripts/reviewers/r293/). Log: [agent_logs/r293-qgamma.log](../agent_logs/r293-qgamma.log).

Everything below is computed from my own build of the definitions ([r293_d123.py](../scripts/reviewers/r293/r293_d123.py)): my own $\phi_{ij}$, my own structure constants, my own $\#$, my own $T$, $R$, $Q_\gamma$, $g_\gamma$. Cross-checked once against [review_r30_core.py](../scripts/lib/review_r30_core.py), $\max|\#_{\text{mine}}-\#_{r30}|=4.2\times10^{-17}$, structure constants identical to $0$, and then used independently. [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) is used only for the *points* ($\mathbb{CP}^m$, the padding map), never for the quantities, and every point's criticality is re-verified here as $\lVert Q(W)-\theta W\rVert\le8\times10^{-16}$.

## Verdict table

| claim | verdict | the one line |
|---|---|---|
| **D1** $Q_\gamma=2\langle W^\#v_\gamma,v_\gamma\rangle$ | **CONFIRMED** | one line from total antisymmetry of $c'$; holds off criticality, off $\mathrm{Weyl}_n$, off unit norm, max residual $6\times10^{-16}$ |
| **D2** the $\theta$ identity | **CONFIRMED, and under-scoped** | it needs only $\lambda_\gamma\neq0$, not $\lambda_\gamma>0$; it is choice-independent inside degenerate eigenspaces; and it genuinely needs criticality, it misses by $1.9$ to $32$ at random $\mathrm{Weyl}_n$ |
| **D3** the inequality, its slack, the $\Delta=0$ equality | **CONFIRMED** | strictness at a $\Delta=0$ critical point is impossible: $\Delta=\sum_{\lambda_\gamma>0}g_\gamma$ with every $g_\gamma\ge0$ |
| **D4** the route-status claim | **PLAUSIBLE, conclusion survives, both stated reasons are false** | the criticality rows are $N-2$ equations the class list does not carry, and they cut the LP by $12$–$37\%$ at the class's own ceiling-setting spectra; but the ceiling *relocates* rather than falls, so the route is still shut |

**The one sentence that should not be reused:** *"any bound extracted from D3 needs an upper bound on $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$, which is the two-moment quantity that file already maximises over the same constraint set."* The constraint set is not the same, and the difference is measurable, see [D4](#d4-the-route-status-claim).

## D1, CONFIRMED, and the constant is pinned by the definition rather than by a name

**Derivation, three lines, no criticality.** Let $V$ be the orthogonal matrix of eigenvectors of $W$, $v_\alpha=\sum_g V_{g\alpha}\phi_g$, and $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$. Because the bracket is bilinear, $c'$ is the tensor transform of $c$ by $V$, and $(W^\#)_{\alpha\beta}=-\tfrac12\mathop{\mathrm{tr}}(A_\alpha WA_\beta W)$ is a full contraction of $c$ with $W$, so its transform is $V^{\mathsf T}W^\#V$ with $c\mapsto c'$, $W\mapsto\Lambda$. Hence

$$\langle W^\#v_\gamma,v_\gamma\rangle=-\tfrac12\mathop{\mathrm{tr}}(A'_\gamma\Lambda A'_\gamma\Lambda)=-\tfrac12\sum_{\alpha\beta}c'_{\gamma\alpha\beta}\lambda_\beta\,c'_{\gamma\beta\alpha}\lambda_\alpha=+\tfrac12\sum_{\alpha\beta}c'^2_{\gamma\alpha\beta}\lambda_\alpha\lambda_\beta=\tfrac12\,Q_\gamma,$$

the sign flip being $c'_{\gamma\beta\alpha}=-c'_{\gamma\alpha\beta}$. So $Q_\gamma=2\langle W^\#v_\gamma,v_\gamma\rangle$ **exactly**, using nothing but total antisymmetry of the structure constants and $Wv_\gamma=\lambda_\gamma v_\gamma$.

**The constant is a statement about *this* $\#$.** The factor $2$ is locked to $(W^\#)_{ab}=-\tfrac12\mathop{\mathrm{tr}}(A_aWA_bW)$ as written in [review_r30_core.py](../scripts/lib/review_r30_core.py), together with $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ on $\mathfrak{so}(n)$, which is what makes $\{\phi_{ij}\}_{i<j}$ orthonormal and $c$ totally antisymmetric. Under a $\#$ scaled by $\kappa$ the constant becomes $2\kappa$. Nothing here depends on the name "Hamilton's $\#$"; the derivation reads the formula.

*One notational correction to the brief.* It states $T_{\alpha\beta\gamma}=(c'_{\alpha\beta\gamma}/2)^2$. With $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ and $\langle\cdot,\cdot\rangle=\tfrac12\mathop{\mathrm{tr}}(\cdot^{\mathsf T}\cdot)$, the code's `0.5 * einsum(...)` **is** $\langle[v_\alpha,v_\beta],v_\gamma\rangle$, so $T=c'^2$, not $(c'/2)^2$. The extra $\tfrac12$ in the brief double-counts the inner product's own factor. This does not touch D1–D4; it would change every constant in them if taken literally.

**Numerically**, on my own build, $\max_\gamma|Q_\gamma-2(W^\#)_{\gamma\gamma}|$:

| point | $n$ | $\theta$ | $\lVert Q(W)-\theta W\rVert$ | D1 residual |
|---|---|---|---|---|
| $S^3\times S^3$ | 6 | 1.054093 | $3.6\times10^{-16}$ | $5.6\times10^{-17}$ |
| $S^6\times S^6$ | 12 | 1.236033 | $5.4\times10^{-16}$ | $1.1\times10^{-16}$ |
| $S^5\times S^7$ | 12 | 1.228239 | $5.5\times10^{-16}$ | $1.7\times10^{-16}$ |
| $\mathbb{CP}^4$ | 8 | 0.986013 | $4.8\times10^{-16}$ | $6.1\times10^{-16}$ |
| padded $W_{\mathbb{CP}^2}$ | 8 | 1.224745 | $5.4\times10^{-16}$ | $4.4\times10^{-16}$ |
| $C_5$ blow-up | 10 | 0.670820 | $1.3\times10^{-16}$ | $8.3\times10^{-17}$ |
| random $\mathrm{Weyl}_6$, $\mathrm{Weyl}_8$ (4 points) | (|), | $0.39$–$0.53$ | $\le3.5\times10^{-16}$ |

The last row is the point: D1 holds at $10^{-16}$ where criticality is violated at $O(1)$, so **criticality is not an input to D1**. [run_d123.py](../scripts/reviewers/r293/run_d123.py).

## D2, CONFIRMED as an identity; its stated scope is narrower than the truth in one direction and its dependence on criticality is real

**Derivation.** $T_{\gamma\alpha\beta}$ is symmetric in $(\alpha,\beta)$, so $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$, the recorded decomposition, and it needs no criticality. Criticality enters once: $Q(W)=\theta W$ read on the diagonal of the eigenbasis is $\lambda_\gamma^2+(W^\#)_{\gamma\gamma}=\theta\lambda_\gamma$, so with D1

$$\boxed{\;Q_\gamma=2\theta\lambda_\gamma-2\lambda_\gamma^2\;}\qquad\text{for every }\gamma,$$

and substituting, $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-4\theta\lambda_\gamma+4\lambda_\gamma^2$. Dividing by $4\lambda_\gamma$ gives D2. **So D2 is exactly the recorded decomposition plus one substitution, and the substitution is criticality.**

**Three scope findings, all against the way D2 is written.**

- **$\lambda_\gamma>0$ is not needed; $\lambda_\gamma\neq0$ is.** The division is the only obstruction. Measured at the same ten critical points, the residual restricted to $\lambda_\gamma<0$ is $\le3.6\times10^{-15}$, the same order as the $\lambda_\gamma>0$ residual. Writing the hypothesis as $\lambda_\gamma>0$ hides that the identity already covers $\mathfrak m$, which is where a future argument would want it.
- **At $\lambda_\gamma=0$ the identity has a finite form and it holds.** The boxed equation gives $Q_\gamma=0$, hence $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}=g_\gamma/2$. Measured on the kernels of $W_{\mathbb{CP}^2}$ and its paddings to $n=6,8$: $\max|{\sum\lambda^2R}-g/2|\le2.8\times10^{-16}$ over $12$, $12$ and $25$ kernel directions. The $\theta$-form is undefined there; the content is not lost.
- **Degeneracy is harmless, and provably so.** Each of $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$, $Q_\gamma=2\langle W^\#v_\gamma,v_\gamma\rangle$ and $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}=-\mathop{\mathrm{tr}}(W^2\mathrm{ad}(v_\gamma)^2)$ is a function of the *pair* $(W,v_\gamma)$ alone (no other basis vector appears) so all three are constant on the choice of orthonormal frame inside an eigenspace, and D2 holds for **every** unit $v_\gamma$ in the $\lambda_\gamma$-eigenspace. Checked against the derivation: five random $O(k)$ rotations inside each degenerate eigenspace at each of the ten catalogued points leave the residual at $\le6.3\times10^{-15}$ ([run_degen.py](../scripts/reviewers/r293/run_degen.py)).

**Criticality cannot be dropped, the counterexamples are cheap.** At a random $W\in\mathrm{Weyl}_n$ with $\theta:=\langle W,Q(W)\rangle$, the right-hand side of D2 is not even *constant* in $\gamma$:

| $n$ | seed | $\theta$ | $\lVert Q(W)-\theta W\rVert$ | RHS$_\gamma$ range over $\lambda_\gamma>0$ | $\max_\gamma\lvert$RHS$-\theta\rvert$ |
|---|---|---|---|---|---|
| 6 | 7a | $-0.01027$ | $0.534$ | $[-8.781,\ +0.421]$ | $8.77$ |
| 6 | 7b | $+0.06189$ | $0.492$ | $[-31.905,\ +0.491]$ | $31.97$ |
| 8 | 7a | $-0.00967$ | $0.426$ | $[-1.873,\ +0.291]$ | $1.86$ |
| 8 | 7b | $+0.02288$ | $0.395$ | $[-4.128,\ +0.288]$ | $4.15$ |

These are retypeable: `weyl_basis(n)` from [review_r30_core.py](../scripts/lib/review_r30_core.py), coefficients `np.random.default_rng(7).normal(size=d)`, two draws per $n$.

## D3, CONFIRMED, and strictness at a $\Delta=0$ critical point is impossible

$T\ge0$ entrywise (it is a square), so $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}\ge0$. With $\lambda_\gamma>0$, D2 gives

$$\theta\;=\;\frac{\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}}{2\lambda_\gamma}+\lambda_\gamma\;-\;\underbrace{\frac{g_\gamma}{4\lambda_\gamma}}_{\ \ge\,0},$$

so the inequality holds with slack **exactly** $g_\gamma/(4\lambda_\gamma)$, which is what D3 says.

**The equality claim cannot be broken, and the reason is definitional.** $\Delta=\sum_{\lambda_\gamma>0}g_\gamma$ is a sum of nonnegative terms over exactly the index set D3 quantifies over. $\Delta=0\Rightarrow g_\gamma=0$ for every $\gamma$ with $\lambda_\gamma>0\Rightarrow$ slack $0$ at every such $\gamma$. A $\Delta=0$ critical point with strict D3 would need a negative $g_\gamma$. **No search can produce one and none was attempted.** Measured anyway, the slack $\max_{\lambda_\gamma>0}g_\gamma/(4\lambda_\gamma)$ is $\le1.9\times10^{-30}$ at all four sphere products, at $\mathbb{CP}^{2,3,4}$ and at both paddings (exactly $0$ at the sphere products) and is nonzero only at the $C_5$ blow-up, the one catalogued critical point with $\Delta=12>0$, where it is $2.012$, reproducing the record's figure independently.

**A consequence worth recording, which the record does not draw.** At a $\Delta=0$ critical point the whole family $\{\,\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}/(2\lambda_\gamma)+\lambda_\gamma\,\}_{\lambda_\gamma>0}$ **collapses to the single number $\theta$**, every positive eigendirection returns the same value. So taking $\min_\gamma$ over $\mathfrak p$ buys nothing there, and the $\gamma$-dependence the record wanted from a per-direction cap is exactly zero on the set that matters.

**One phrasing to tighten.** "Summed over $\mathfrak p$ that slack is $\Delta$ divided through" ([bounds.md](../findings/bounds.md)) is loose: $\sum_{\lambda_\gamma>0}g_\gamma/(4\lambda_\gamma)$ is a *per-$\gamma$* reweighting, not $\Delta$ over a common factor. The brief's "a reweighting of $\Delta$" is correct, and the sharp two-sided form is $\Delta/(4\lambda_{\max})\le\sum\text{slack}\le\Delta/(4\lambda^+_{\min})$.

## D4, the route-status claim

**Verdict: PLAUSIBLE. The conclusion survives every attack I could mount; both of the reasons offered for it are false, and one of them is false by a wide, measurable margin.**

### 4.1 What I built

An independent relaxation ([r293_lp.py](../scripts/reviewers/r293/r293_lp.py)), variables $t_{\alpha<\beta<\gamma}\ge0$ (the totally symmetric $T$, with $T_{\alpha\alpha\beta}=0$ because $c'$ is antisymmetric), in three nested constraint sets:

| set | constraints |
|---|---|
| **A**, the list [fence post F15](../findings/second-order.md) names | $T\ge0$; row marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$; pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$; $\mathop{\mathrm{tr}}W^\#=-1$ |
| **B**, A $+$ the vector identity | $\sum_\beta\lambda_\beta R_{\gamma\beta}=-2\lambda_\gamma$ for every $\gamma$ ($N$ rows) |
| **C**, B $+$ **the D2 pin** | $Q_\gamma=2\theta\lambda_\gamma-2\lambda_\gamma^2$ for every $\gamma$ ($N$ rows) |

with $\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma t$ the objective, maximised over $t$ at fixed $\lambda$ and then over $\lambda$ on $\{\sum\lambda=0,\lVert\lambda\rVert=1\}$ by multistart ascent. A fourth set, **B+D3**, adds only D3's *inequalities* $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}\ge2\lambda_\gamma\theta-2\lambda_\gamma^2$ at $\lambda_\gamma>0$, to separate what D3 alone buys from what the D2 equality buys.

**The encoding is validated against reality, not against the record.** For each catalogued critical point I take the *actual* $T$ and check every row of every block ([run_encoding_check.py](../scripts/reviewers/r293/run_encoding_check.py)): marginal $\le7\times10^{-15}$, pair cap $\max=2.000000$ (attained, never exceeded), $\theta$ row $\le7\times10^{-16}$, $Q$ rows $\le4\times10^{-16}$, vector identity $\le7\times10^{-16}$, criticality rows $\le1.1\times10^{-15}$. So every real critical point is feasible in all three sets and each is a genuine relaxation: $\sup_{\mathrm C}\le\sup_{\mathrm B}\le\sup_{\mathrm A}$, all $\ge\theta$ at every critical $W$.

### 4.2 The class is a constraint LIST, and D2 is not on it, $N-2$ new equations, and they are criticality-specific

Contracting the D2 pin against weight $1$ returns $\sum_\gamma Q_\gamma=-2\lVert W\rVert^2$; against weight $\lambda$ it returns $\sum_\gamma\lambda_\gamma Q_\gamma=2\langle W^\#,W\rangle$. Those are the two the record carries. The rank count says what is left over ([run_rank.py](../scripts/reviewers/r293/run_rank.py)), at a random fixed spectrum:

| $n$ | rank(A equalities) | $+$ vector identity | $+$ D2 pin | D2 adds |
|---|---|---|---|---|
| 6 | 16 | 29 | 42 | **13** $=N-2$ |
| 8 | 29 | 55 | 81 | **26** $=N-2$ |

And unlike the two contractions, the $N$ rows are **not** free of criticality. At random $W\in\mathrm{Weyl}_n$ (so Bianchi, Ricci-flat, unit norm, but $Q(W)\neq\theta W$):

| $n$ | $\lvert\sum_\gamma Q_\gamma+2\rvert$ | $\lvert\sum_\gamma\lambda_\gamma Q_\gamma-2\langle W^\#,W\rangle\rvert$ | $\max_\gamma$ violation of the D2 pin |
|---|---|---|---|
| 6 | $3.6\times10^{-15}$ | $6.7\times10^{-16}$ | **$0.506$** |
| 6 | $4.4\times10^{-16}$ | $1.9\times10^{-16}$ | **$0.429$** |
| 8 | $6.7\times10^{-16}$ | $6.9\times10^{-17}$ | **$0.195$** |
| 8 | $1.3\times10^{-15}$ | $6.9\times10^{-18}$ | **$0.215$** |

**So the record's sentence "criticality contributes nothing" is correct about the two contractions and is carried over to the per-row pin, where it is wrong.** D4 inherits that carry-over in the phrase *"the same constraint set"*. It is not the same constraint set: it is $N-2$ equations larger, and the extra equations are exactly the criticality content.

### 4.3 The rows bite hard, and precisely where the ceiling lives

This is the rigorous part: two LPs at one **fixed** $\lambda$, so no search convergence enters. $n=6$ ([run_bite_final.py](../scripts/reviewers/r293/run_bite_final.py)):

| spectrum | A | B | C | cut B$\to$C |
|---|---|---|---|---|
| argmax of class B | $1.431895$ | $1.421219$ | $1.093812$ | **$23.0\%$** |
| argmax of class C | $1.446570$ | $1.407145$ | $1.399334$ | $0.6\%$ |
| argmax of class A | $1.608978$ | $0.968954$ | $0.635205$ | **$34.4\%$** |
| random 0 | $1.383739$ | $0.710996$ | $0.050232$ | $92.9\%$ |
| random 2 | $0.965759$ | $0.722865$ | **infeasible** | $100\%$ |
| random 3 | $1.260399$ | $1.113451$ | **infeasible** | $100\%$ |
| random 5 | $1.245357$ | $1.229106$ | $1.090834$ | $11.2\%$ |
| $S^3\times S^3$ | $1.054093$ | $1.054093$ | $1.054093$ | $0.0\%$ |
| $\mathbb{CP}^3$ | $1.054093$ | $1.054093$ | $1.054093$ | $0.0\%$ |
| padded $W_{\mathbb{CP}^2}$ | $1.224745$ | $1.224745$ | $1.224745$ | $0.0\%$ |

$n=8$ and $n=12$ repeat it: the pin bites at $8/10$ fixed $n=8$ spectra (one becomes infeasible) and cuts $1.627573\to1.212123$ and $1.672706\to1.356617$ at the two $n=12$ spectra tried ([run_bite.py](../scripts/reviewers/r293/run_bite.py), [run_bite12.py](../scripts/reviewers/r293/run_bite12.py)).

**Read the last three rows against the first three.** The pin's gain is exactly $0$ at every real Weyl critical spectrum (which is what D4 says), *and simultaneously* $23$–$34\%$ at the spectra where the class attains its ceiling, and it deletes whole spectra as infeasible. **Those two facts are compatible, and D4's argument assumes they are not.** A relaxation's ceiling is set at its own maximiser, not at the conjectured maximiser of the real problem, so "gain zero at the maximiser" is not evidence about the ceiling. That is the first false reason.

### 4.4 And yet the ceiling barely moves, because it relocates

Equal starts, equal iteration budget, same ascent code for every set ([run_lp_max2.py](../scripts/reviewers/r293/run_lp_max2.py)), plus an independent harder protocol for B and C at $n=6$ ([run_lp_hard.py](../scripts/reviewers/r293/run_lp_hard.py)):

| $n$ | A | B | B$+$D3 rows | C $=$ B $+$ D2 pin | target $\sqrt{3/2}$ |
|---|---|---|---|---|---|
| 6 (17 starts $\times$ 900) | $1.608948$ | $1.420729$ | $1.416498$ | $1.399421$ | $1.224745$ |
| 6 (24 starts $\times$ 600 $+$ polish) |, | $1.421219$ |, | $1.399334$ | |
| 8 (7 starts $\times$ 120, all under-converged) | $1.773859$ | $1.681225$ | $1.565327$ | $1.383855$ | |

All entries are **ascent lower bounds** on the true suprema. Two protocols agree at $n=6$ to $5\times10^{-4}$, and my class-A figure $1.6089$ reproduces the record's older $1.6059$ while my class-B $1.4212$ slightly exceeds the record's $1.413614$, so the machinery is not the weak link at $n=6$. The $n=8$ row is a fair *iteration-count* comparison and nothing more, my class-A value $1.774$ is far under the record's $2.29$, so only the ordering there is worth anything.

**The mechanism, stated plainly.** At $n=6$ the pin cuts $23\%$ at class B's maximiser, and the class-C ascent responds by moving to a different spectrum where the pin is nearly slack ($0.6\%$), recovering almost all of the loss. The supremum falls by $1.5\%$, from $\ge1.4212$ to $\ge1.3993$, against a gap to $\sqrt{3/2}$ of $16\%$. **The pin is a strong constraint on a large set of spectra and a weak one on the spectra that matter for the ceiling.** That, and not "equality at the maximiser", is why the route does not close.

### 4.5 What survives of D4, and what does not

| part of D4 | verdict | why |
|---|---|---|
| *the conclusion*, pinning $Q_\gamma$ by criticality does not deliver a bound near $\sqrt{3/2}$ | **survives** | $\sup_{\mathrm C}\ge1.3993$ at $n=6$, still $14\%$ over $\sqrt{3/2}$; my best attack recovers $1.5\%$ of a $16\%$ gap |
| *reason 1*, "because D3 is an equality at the conjectured maximiser" | **REFUTED as an inference** | behaviour at the real maximiser is not evidence about a relaxation's ceiling; here it is $0\%$ at the maximiser and $23$–$34\%$ at the ceiling-setting spectra |
| *reason 2*, "the same constraint set" | **REFUTED on fact** | the pin is $N-2$ independent equations the list does not carry, violated by $0.19$–$0.51$ at random $\mathrm{Weyl}_n$, and it makes some spectra infeasible outright |
| *"any bound extracted from D3 needs an upper bound on $\sum\lambda^2R$"* | **REFUTED as stated, true in spirit** | using the D3 rows as *constraints* rather than as a substitution needs no such cap (B$+$D3 row of the table); it just does not buy much, $1.4207\to1.4165$ at $n=6$ |
| *the quoted ceiling $1.60/2.29/2.49$* | **stale inside the record itself** | [bounds.md](../findings/bounds.md) cites it two paragraphs after recording that the vector identity moves $n=6$ to $1.413614$ and $n=8$ to $2.2585$; I reproduce both regimes ($1.6089$, $1.4212$). A route is not "ceilinged at $1.60$" by a class whose own ceiling the file has already revised twice |

### 4.6 What would overturn this review's D4 reading

A spectrum $\lambda$ at $n=6$ with class-C value above $1.4212$ would mean my class-B ascent, not the pin, is what is under-converged. A class-C ascent at $n=8$ or $n=12$ run to the record's own standard (my $n=8$ numbers are not), could show the $18\%$ ordering there is real rather than a convergence artefact, which would make the pin worth more than $1.5\%$. And a *closed-form* bound extracted from the pin, rather than an LP value, is untried here: I found none that beats the LP, but absence of one after a few hours is not a fence post.

## Method and reproduction

| script | what it settles |
|---|---|
| [r293_d123.py](../scripts/reviewers/r293/r293_d123.py) | independent $\phi$, $c$, $\#$, $T$, $R$, $Q_\gamma$, $g_\gamma$, $\theta$, criticality residual |
| [run_d123.py](../scripts/reviewers/r293/run_d123.py) | D1 and D2 at ten critical points and four random $\mathrm{Weyl}_n$ |
| [run_degen.py](../scripts/reviewers/r293/run_degen.py) | D2 under random rotations inside degenerate eigenspaces, and the $\lambda_\gamma=0$ form |
| [r293_lp.py](../scripts/reviewers/r293/r293_lp.py) | the four constraint sets |
| [run_encoding_check.py](../scripts/reviewers/r293/run_encoding_check.py) | every LP row verified against the real $T$ of real critical points |
| [run_rank.py](../scripts/reviewers/r293/run_rank.py) | the $N-2$ count, and the two contractions at random $\mathrm{Weyl}_n$ |
| [run_bite.py](../scripts/reviewers/r293/run_bite.py), [run_bite12.py](../scripts/reviewers/r293/run_bite12.py), [run_bite_final.py](../scripts/reviewers/r293/run_bite_final.py) | fixed-$\lambda$ B versus C, $n=6,8,12$ |
| [run_lp_max2.py](../scripts/reviewers/r293/run_lp_max2.py), [run_lp_hard.py](../scripts/reviewers/r293/run_lp_hard.py) | the equal-budget ceilings, two protocols |
