# VERIFY v151, L29's $\sqrt{3/2}$ cap on the one-positive two-negative stratum, its dimension-freedom, its attaining object, and the three vanishing sign-blocks

**Verifier v151, round L29, cold brief.** The text checked is the block quoted under "The brief as dispatched" in [ROUND_L29.md](ROUND_L29.md), which is [stratum-two-negative.md](../findings/stratum-two-negative.md):69– verbatim, together with the canonical form at [results.md](../results.md):441, the landscape line at [results.md](../results.md):144, and the Lean row at [lean/INDEX.md](../lean/INDEX.md):104. **No numerical work was done: no script was run, and every value below is an exact hand evaluation.** Log: [agent_logs/verify-L29-v151.log](../agent_logs/verify-L29-v151.log).

## Claim table

| # | claim, and where it is citable | verdict |
| --- | --- | --- |
| 1 | The cap $\theta(W)\le\sqrt{3/2}$ on unit $W\in\mathcal W_n$ with exactly one positive and two negative eigenvalues | **PROVEN** |
| 2 | The cap carries no dimension restriction | **PROVEN**, $n$ enters at exactly one step, [L31](../findings/stratum-two-negative.md)'s pair cap, and is absent there |
| 3 | The reduction to $f(t)=9\sqrt2\,t(t+1)/(4(t^2+t+1)^{3/2})$, and $\max_{t\ge0}f=\sqrt{3/2}$ at $t=1$ alone | **PROVEN**, and the calculus is replaceable by an exact factorisation ([lean/INDEX.md](../lean/INDEX.md):104) |
| 4 | The cap is **attained** at spectrum $(2,-1,-1)/\sqrt6$, padded $W_{\mathbb{CP}^2}$ | **PROVEN**, $\theta=3/\sqrt6=\sqrt{3/2}$ exactly, at every $n\ge4$ of either parity |
| 5 | The three vanishing sign-blocks $(+++)$, $(++-)$, $(---)$ | **PROVEN**, all three vanish *under the lemma's own hypothesis*, none identically in $W$ |
| 6 | The load-bearing import: the pair cap $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ | **PROVEN, hypotheses corrected.** The inequality is **absent from L31's canonical statement** at [results.md](../results.md):453 and from its landscape line at :156; it lives only in L31's proof and in a [conventions.md](../findings/conventions.md) bullet |
| 7 | The counting convention on "exactly one positive and two negative eigenvalues" | **PROVEN, hypotheses corrected.** With multiplicity. Unstated at [results.md](../results.md):441 and :144, where the file convention that supplies it does not travel |
| 8 | "The converse (that equality forces that spectrum), is **Lemma L72**" ([results.md](../results.md):441, repeated at :784) | **BROKEN.** That credit is withdrawn on the record by Gate 2 ([r541](../reviews/REVIEW_r541.md)/[r542](../reviews/REVIEW_r542.md)); [LEDGER.md](../findings/LEDGER.md):915 records the repair as complete across "five sites" while these two still carry it |
| 9 | The converse as the findings block now states it, closed in three lines by [L31](../findings/stratum-two-negative.md), second route [L33](../findings/stratum-two-negative.md) | **PROVEN**, both routes check |
| 10 | The development-form block's "equality clause, **closed**" paragraph, [stratum-two-negative.md](../findings/stratum-two-negative.md):35 | **GAP**, heading says closed, its own body says "$r\ge12$ untested", and the statement twelve lines above says "reduced but not closed". Three states of one clause in one file |
| 11 | "The single inequality is an identity on this stratum" | **PROVEN, hypotheses corrected.** One step is asserted rather than derived: that at $r=4$ the eigenvectors lie in a single $\Lambda^\pm$ |
| 12 | "Since $\sqrt{3/2}<\theta_0(n)$ from $n=12$, no maximiser in that dimension range has this spectrum" | **PROVEN, hypotheses corrected.** The conclusion holds at both parities; the constant named is the record's even-$n$ one, and at odd $n$ the comparison must be against $\Theta_n$ |
| 13 | "It reaches $k=2$ as well" | **HYPOTHESIS-DEBT**, the block asserts a two-parameter maximisation it does not perform; the correction to the *reason* is right |
| 14 | A universal claim with no witness: does any structured family on the record with this sign pattern exceed the cap? | **No finding.** One family on the record has the pattern and it is $f(t)$ exactly |

**Round verdict: PROVEN, hypotheses corrected**, with claim 8 recorded as **BROKEN** in the canonical citable form.

## One-line summary

L29's cap, its dimension-freedom, its closed form and its attaining object all check by hand and at both parities; what does not check is the converse clause as printed in [results.md](../results.md), which still credits a lemma the record itself withdrew, and the pair-cap inequality the whole proof runs on, which is not in the statement of the lemma cited for it.

## 0. Conventions, fixed once

Every convention below is quoted from [conventions.md](../findings/conventions.md), which the record makes the single source; none is restated from another findings file.

- $\mathcal W_n$ is the space of algebraic Weyl curvature operators on $\mathbb R^n$, $N=\binom n2=\dim\Lambda^2\mathbb R^n$, and $\mathrm{Weyl}_n$ is the same object under the stratum file's spelling.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $\theta=P(W)/\lVert W\rVert^3$. At $\lVert W\rVert=1$, $\theta=P(W)=\operatorname{tr}(W^3)+\langle W,W^\#\rangle$.
- The $\tfrac12$ in the pairing sits at the $\Lambda^2$ level: $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ for bivectors, **plain Frobenius on the pair matrix**. So $\lVert W\rVert^2=\operatorname{tr}(W^2)=\sum_\alpha\lambda_\alpha^2$ and $\langle W,W^2\rangle=\operatorname{tr}(W^3)=\sum_\alpha\lambda_\alpha^3$.
- A unit bivector has $\operatorname{tr}(v^2)=-2$ and singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_is_i^2=1$.
- $\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$.
- Structure constants $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, so $T_{abc}=c_{abc}^2$ is totally symmetric, nonnegative, and **hollow**, it vanishes whenever any two indices coincide. The brief's $c'$ is this $c$; the prime carries nothing the record defines.
- **Sums over pairs and triples are over ORDERED tuples** unless a line says otherwise.
- The pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ is [Lemma L31](../findings/stratum-two-negative.md); the row marginal $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ is [Lemma L153](../findings/bounds.md). **L29 uses the first and not the second**, and that is the whole of why the cap is dimension-free.
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$ **and nothing more**; $\Theta_n$ is the diagonal maximum, equal to $\theta_0(n)$ at even $n$ and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$; $M(n)$ is the global maximum, with $\Theta_n\le M(n)$.
- Padding commutes with $Q$ and preserves both $\lVert W\rVert$ and $\theta$.
- $S(W)$ is the gradedness slack, and [trap W4](../findings/INDEX-traps.md) says the screen is **vacuous when $\ker W\ne0$**.

**Sources.** Every claim below is checked against a file in this repository. No external source is used, and none is cited from memory. The record holds no Cartan, Helgason, Berger or Besse entry, and nothing in L29's proof needs one, the one Lie-theoretic input, the root system of $\mathfrak{so}(n)$ giving $\mathrm{ad}_X$ the eigenvalues $i(\pm s_i\pm s_j)$ and $i(\pm s_i)$, sits inside [Lemma L31](../findings/stratum-two-negative.md)'s proof in [stratum-two-negative.md](../findings/stratum-two-negative.md):411 and is asserted there against no citation. That is an unread-source dependency **of L31**, and it is where L29's single inequality ultimately rests.

## 1. The hypothesis inventory

A pass without one is not a pass, so here is every hypothesis the block carries, every hypothesis of every result it imports, and then which of them the written proof actually uses.

### 1a. Hypotheses the block states

| # | hypothesis | where |
| --- | --- | --- |
| H1 | $W\in\mathrm{Weyl}_n$ | statement, both forms |
| H2 | $\lVert W\rVert=1$ | statement, both forms |
| H3 | exactly one positive eigenvalue, $\lambda_1>0$ | statement, both forms |
| H4 | exactly two negative eigenvalues, $0>-a\ge-b$ | statement, both forms |
| H5 | *(implied by H3+H4)* every other eigenvalue is $0$ | nowhere stated; forced by "exactly" |

### 1b. Hypotheses the block does **not** state and does not need

- No criticality. $Q(W)=\theta W$ appears nowhere in the chain. This matters, because [L72](../findings/stratum-two-negative.md), the lemma [results.md](../results.md):441 credits with L29's converse, *does* assume criticality, and that is precisely the containment failure recorded at [INDEX-results.md](../findings/INDEX-results.md):86.
- No parity of $n$, no lower bound on $n$ beyond $\mathcal W_n\ne0$, and no bound on $\dim\ker W$.
- No first Bianchi identity, and no Ricci-flatness. Checked term by term in §3: the chain consumes only trace-freeness, unit norm, the $\#$ expansion and the pair cap. [LEDGER.md](../findings/LEDGER.md):1403 makes the same observation about the sibling [L35](../findings/stratum-two-negative.md) and calls it "a stronger theorem than the one claimed"; it holds verbatim here and L29's block says nothing about it either.

### 1c. Hypotheses of the imported results, each checked against the object it applies to

| import | its hypotheses | the object it is applied to | check |
| --- | --- | --- | --- |
| [L31](../findings/stratum-two-negative.md), pair cap $\le2$ | $X,Y\in\mathfrak{so}(n)$ **orthonormal** | $v_{N-1},v_N$, the two negative unit eigenvectors | orthonormal as members of an eigenbasis of a symmetric operator, with distinct eigenvalues when $a\ne b$ and choosable orthonormal when $a=b$, **holds** |
| $T=c^2$ totally symmetric, $\ge0$, hollow | the inner product is ad-invariant | $\mathfrak{so}(n)$ with the record's half-trace pairing | **holds**, [conventions.md](../findings/conventions.md) |
| $\{v_\gamma\}$ an orthonormal **basis** of $\mathfrak{so}(n)$ | needed for $\lVert[v_\alpha,v_\beta]\rVert^2=\sum_\gamma T_{\alpha\beta\gamma}$ | the full eigenbasis, kernel directions included | **holds**, and the kernel directions are what make the sum a sum over all of $\Lambda^2$ rather than over the support |
| trace-freeness $\operatorname{tr}W=0$ | membership in $\mathcal W_n$ | $W$ | **holds**, Weyl has zero scalar part, and $\operatorname{scal}=2\operatorname{tr}$ on $\Lambda^2$ |
| [L30](../findings/stratum-two-negative.md) / Ricci-flatness PSD identity | $W\in\mathcal W_n$ | $W$, in the "identity on this stratum" paragraph only | **holds**, and is **not** used by the bound |
| [L33](../findings/stratum-two-negative.md), second converse route | a **one-dimensional** eigenspace on one side, counted **with multiplicity**; eigenvector not a complex-structure multiple on a $4$-plane | the positive eigenspace, $\dim=1$ by H3 | **holds under the multiplicity reading**, which is the counting convention this same file declares for L33 and never declares for L29 |

### 1d. Which hypotheses the written proof uses

H1 is used **only** through trace-freeness. H2 fixes the normalisation $(a+b)^2+a^2+b^2=1$. H3 kills $(+++)$ and $(++-)$; H4 kills $(---)$; H5 is what makes $\operatorname{tr}W^3=\lambda_1^3-(a^3+b^3)$ exact and $\lambda_1=a+b$ follow from trace-freeness. Nothing else in H1 is consumed.

**The correction this forces on the statement.** The lemma as written is weaker than what its proof gives. What is proved is: *for every trace-free symmetric operator on $\Lambda^2\mathbb R^n$ of unit norm whose spectrum has exactly one positive and two negative entries counted with multiplicity, $\theta\le\sqrt{3/2}$.* Membership in $\mathcal W_n$ is used for trace-freeness and nothing else.

## 2. Pre-registered question 1, is the cap right, and is it dimension-free?

### 2a. The derivation, in full, by hand

Fix the eigenbasis $\{v_\gamma\}_{\gamma=1}^N$ of $W$ on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, orthonormal under the record's half-trace pairing, with $Wv_\gamma=\lambda_\gamma v_\gamma$. By H3–H5 the spectrum is $\lambda_1>0$, $\lambda_{N-1}=-a$, $\lambda_N=-b$ with $0<a\le b$, and $\lambda_\gamma=0$ otherwise.

**Step 1, the cubic in the eigenbasis.** $W=\sum_\gamma\lambda_\gamma v_\gamma v_\gamma^{\mathsf T}$, and the $\#$ of the conventions file gives
$$W^\#=\sum_{\alpha,\beta}\lambda_\alpha\lambda_\beta\,(v_\alpha v_\alpha^{\mathsf T}\#v_\beta v_\beta^{\mathsf T})=\tfrac12\sum_{\alpha,\beta}\lambda_\alpha\lambda_\beta\,[v_\alpha,v_\beta][v_\alpha,v_\beta]^{\mathsf T}.$$
Writing $[v_\alpha,v_\beta]=\sum_\gamma c_{\alpha\beta\gamma}v_\gamma$ and pairing against $W$ in plain Frobenius on the pair matrix, $\langle W,v_\gamma v_\delta^{\mathsf T}\rangle=\lambda_\gamma\delta_{\gamma\delta}$, so
$$\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma,\qquad T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2,$$
the sum over ordered triples. This is the block's opening display, and it checks.

**Step 2, only $(+--)$ survives.** Any triple containing a zero index contributes nothing. Among the three live indices $\{1,N-1,N\}$, hollowness of $T$ kills every triple with a repeat, so the survivors are the $3!=6$ orderings of $(1,N-1,N)$, each carrying the same $T_{1,N-1,N}$ by total symmetry and the same product $\lambda_1(-a)(-b)=\lambda_1ab$. Hence exactly
$$\langle W,W^\#\rangle=\tfrac12\cdot6\,T_{1,N-1,N}\lambda_1ab=3\,T_{1,N-1,N}\,\lambda_1ab,$$
which is the block's value. **The factor $3$ is the ordered convention halved, and it is right.**

**Step 3, the one inequality.** $T\ge0$ gives $T_{1,N-1,N}\le\sum_\gamma T_{N-1,N,\gamma}=\lVert[v_{N-1},v_N]\rVert^2$, and the pair cap bounds that by $2$. So $\langle W,W^\#\rangle\le6\lambda_1ab$, with $\operatorname{tr}W^3=\lambda_1^3-(a^3+b^3)$ exact.

**Step 4, trace-freeness and the collapse.** $\operatorname{tr}W=0$ with H5 gives $\lambda_1=a+b$. Then
$$\lambda_1^3-a^3-b^3=(a+b)^3-a^3-b^3=3a^2b+3ab^2=3ab(a+b),$$
so $\theta=P(W)\le3ab(a+b)+6ab(a+b)=9ab(a+b)$. **This is the whole of the estimate**, and it is scale-free of degree $3$.

**Step 5, one variable.** Unit norm reads $(a+b)^2+a^2+b^2=1$. With $t=b/a$ ($a>0$ by H4), $(1+t)^2+1+t^2=2(t^2+t+1)$, so $a^2\cdot2(t^2+t+1)=1$ and $a=\big(2(t^2+t+1)\big)^{-1/2}$. Then
$$9ab(a+b)=9t(1+t)a^3=\frac{9t(t+1)}{\big(2(t^2+t+1)\big)^{3/2}}=\frac{9t(t+1)}{2\sqrt2\,(t^2+t+1)^{3/2}}=\frac{9\sqrt2\,t(t+1)}{4\,(t^2+t+1)^{3/2}}=f(t).$$
**The block's $f$ is exactly reproduced, radical and all.**

**Step 6, the maximum, two ways.**

*The block's way.* $\log f=\log t+\log(t+1)-\tfrac32\log(t^2+t+1)+\text{const}$, so
$$\frac{f'}{f}=\frac1t+\frac1{t+1}-\frac{3(2t+1)}{2(t^2+t+1)}=\frac{(2t+1)\big[(t^2+t+1)-\tfrac32(t^2+t)\big]}{t(t+1)(t^2+t+1)}=\frac{-(2t+1)(t+2)(t-1)}{2\,t(t+1)(t^2+t+1)}.$$
On $t>0$ the only zero is $t=1$, the sign is $+$ below it and $-$ above, and $f(0)=0$, $f(t)\sim9\sqrt2/(4t)\to0$. So the maximum is $f(1)$, attained only at $t=1$. And
$$f(1)=\frac{9\sqrt2\cdot1\cdot2}{4\cdot3^{3/2}}=\frac{18\sqrt2}{12\sqrt3}=\frac32\sqrt{\tfrac23}=\frac{\sqrt6}2=\sqrt{\tfrac32}.$$

*The way that needs no calculus, from the Lean row at [lean/INDEX.md](../lean/INDEX.md):104.* $f(t)^2\le\tfrac32$ is, after clearing, $27t^2(t+1)^2\le4(t^2+t+1)^3$. Put $s=t^2+t$, so $t^2(t+1)^2=s^2$ and the difference is $4(s+1)^3-27s^2=4s^3-15s^2+12s+4$. It vanishes at $s=2$, and dividing, $4s^3-15s^2+12s+4=(s-2)(4s^2-7s-2)=(s-2)^2(4s+1)$. Restoring $s$: $s-2=(t+2)(t-1)$ and $4s+1=(2t+1)^2$, so
$$4(t^2+t+1)^3-27t^2(t+1)^2=\big((t-1)(t+2)(2t+1)\big)^2\ \ge0 .$$
**A perfect square.** The cap therefore holds at every real $t$, the stratum's $t\ge0$ is unused, and equality is exactly $t\in\{1,-2,-\tfrac12\}$, i.e. $t=1$ on $t\ge0$. I verified the factorisation by expansion above; the Lean row's statement of it is correct.

*A remark on the hypothesis's own ordering.* H4 reads $-a\ge-b$, i.e. $a\le b$, i.e. $t\ge1$, a half-line on which $f$ is strictly decreasing, so the maximum is the endpoint $t=1$ and the block's sweep over all of $t\ge0$ is a harmless enlargement. Nothing turns on it.

### 2b. Where the dimension could have entered, and why it does not

Six steps, and $n$ is available at three of them:

1. **The index range.** $\alpha,\beta,\gamma$ run to $N=\binom n2$. Every index outside $\{1,N-1,N\}$ carries $\lambda=0$ and drops out of a cubic. **$n$ leaves at step 2.**
2. **The bracket expansion.** $\lVert[v_{N-1},v_N]\rVert^2=\sum_\gamma T_{N-1,N,\gamma}$ needs the eigenbasis to span $\mathfrak{so}(n)$, so this sum has $N$ terms. But the step used is $T_{1,N-1,N}\le\sum_\gamma T_{N-1,N,\gamma}$, which is $T\ge0$ termwise and **improves, never worsens, as $N$ grows**.
3. **The pair cap itself.** This is the only place a dimension-dependent constant could have appeared, and it is where a neighbouring result *does* carry one: the row marginal [L153](../findings/bounds.md) is $2(n-2)$, and had the chain used it the bound would be dimension-dependent. It uses [L31](../findings/stratum-two-negative.md) instead, whose constant comes from $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$ together with $\sum_is_i^2=1$, giving $(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2$ by Cauchy–Schwarz. **Both inputs are statements about $X$ alone, and neither counts dimensions.** At $n=4$ and $n=5$ there are only two angles and the bound is unchanged; at $n=3$ there is one angle and the cap would be $1$, but $\mathcal W_3=0$.
4. **Trace-freeness.** $\sum_\gamma\lambda_\gamma=0$ over $N$ terms, of which $N-3$ are zero. **$n$-free.**
5. **Unit norm.** Same. **$n$-free.**
6. **The one-variable maximisation.** Pure algebra in $t$.

**So the cap is dimension-free, and the single reason is that the chain buys its bracket bound from the pair cap rather than from the row marginal.** This is what the [conventions.md](../findings/conventions.md) bullet pairing L31 with L153 makes visible, and the L29 block does not say it.

### 2c. The claim at the smallest admissible $n$ and at a large one

**Smallest admissible $n$ is $4$**: $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$ is $0$ at $n=3$ and $10$ at $n=4$. At $n=4$, $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, and $W^+=\mathrm{diag}(q+r,-q,-r)$, $W^-=0$ realises the stratum for every $q,r>0$. Take $q=r=1/\sqrt6$: spectrum $(2,-1,-1,0,0,0)/\sqrt6$, $\lVert W\rVert^2=(4+1+1)/6=1$, and by §4 below $\theta=\sqrt{3/2}$ exactly. So at the smallest admissible $n$ the cap is **attained**, not merely respected, the bound is sharp at its own boundary dimension.

**A large one, $n=100$:** $N=4950$, the same object padded, $\theta=\sqrt{3/2}$ unchanged because padding commutes with $Q$ and preserves the norm. The bound is the same number. The *consequence* drawn from it changes: $\theta_0(100)^2=2\cdot99\cdot98/10^4=1.9404$, so $\theta_0(100)=1.3930\ldots>\sqrt{3/2}=1.224744\ldots$, and no maximiser at $n=100$ has this spectrum.

**Also checked, an odd $n$:** at $n=5$, $N=10$ and the padded object has $\Lambda^2$ spectrum $(2,-1,-1,0^7)/\sqrt6$. [INDEX-values.md](../findings/INDEX-values.md):21 records it built exactly over $\mathbb Q$ with $\lVert W_0\rVert^2=1$, $\operatorname{tr}(W_0^3)=1/\sqrt6$, and first Bianchi with $\mathrm{Ric}=0$ satisfied exactly, which agrees term for term with my hand evaluation in §4. Nothing in the proof is parity-sensitive.

## 3. Pre-registered question 3, what do the vanishing sign-blocks need?

The block says three blocks vanish "each structurally rather than numerically". Taken one at a time, with the question asked exactly as posed: **identically, or under a hypothesis the statement carries, or under one it does not?**

| block | the block's stated reason | what it actually needs | verdict |
| --- | --- | --- | --- |
| $(+++)$ | "needs three distinct positive indices while only one exists and $T$ vanishes on repeated indices" | H3 (exactly one positive, **with multiplicity**) plus hollowness of $T$ | **Under a hypothesis the statement carries**, H3 |
| $(++-)$ | same sentence, "two or three distinct positive indices" | H3 plus hollowness | **Under a hypothesis the statement carries**, H3 |
| $(---)$ | "needs three indices in a $2$-dimensional space, where a form antisymmetric in three indices is identically zero" | H4 (exactly two negative, with multiplicity); then either the antisymmetry argument or, equally, hollowness | **Under a hypothesis the statement carries**, H4 |

**None of the three is identical in $W$**, and the block's word "structurally" is doing double duty: it means *forced by the sign pattern together with a symmetry of $T$*, which is a different thing from *identically zero*. All three are correct as reasoning.

**Two remarks the block does not make.**

*The $(---)$ reason is not the same kind of reason as the other two.* $(+++)$ and $(++-)$ are killed by hollowness, a property of $T$ as a square of a totally antisymmetric object. $(---)$ is given a different argument, that an alternating $3$-form on a $2$-dimensional space vanishes. Both are right: the restriction of $c$ to $\mathrm{span}\{v_{N-1},v_N\}$ is an alternating $3$-form on a $2$-space, hence zero; and independently, any ordered triple from a $2$-element index set repeats an index, and $T$ is hollow. **The block could have used one reason for all three and used two.** That is stylistic, and I record it only because the antisymmetry reason is the one the block's *preamble* reuses for $S(W)$, where it does not do what the preamble says, see below.

*The preamble's motivation is a screen the record has already declared vacuous here.* The brief opens with "the slack is the structure mass carried by the negative eigenspace, $S(W)=\sum_{\lambda<0}c'^2_{\alpha\beta\gamma}$, and $c'$ is antisymmetric in three indices, so $S$ vanishes identically once $\dim\mathfrak m\le2$", then points at padded $W_{\mathbb{CP}^2}$. [Trap W4](../findings/INDEX-traps.md) says of exactly that object: *"the gradedness screen is vacuous when $\ker W\ne0$ … padded $W_{\mathbb{CP}^2}$ has kernel $63$ of $66$ at $n=12$. Trust it only at $\ker W=0$."* So the sentence motivating the lemma reports $S=0$ at the one object where the record says $S=0$ means nothing. **The lemma is untouched** ($S(W)$ appears nowhere in the proof) but the block carries the motivation without the warning, and a consumer reading the preamble as evidence would be reading a vacuous screen.

## 4. Pre-registered question 2, does the attaining object satisfy the hypothesis?

The object is $(2,-1,-1)/\sqrt6$, identified with padded $W_{\mathbb{CP}^2}$: at $n=4$, $W^+=\mathrm{diag}(2,-1,-1)/\sqrt6$ on $\Lambda^+$ and $W^-=0$, padded to any $n\ge4$.

**(i) Exactly one positive and two negative eigenvalues.** Counted **with multiplicity**: one positive ($2/\sqrt6$, simple) and two negative ($-1/\sqrt6$, multiplicity $2$). **Holds.** Counted as **distinct values**, this object has one positive and **one** negative eigenvalue and **fails H4**. §6 below records what that costs.

**(ii) It lies in $\mathcal W_n$.** At $n=4$, $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ and $\mathrm{diag}(2,-1,-1)/\sqrt6$ is trace-free on $\Lambda^+$, so $W\in S^2_0(\Lambda^+)\subset\mathcal W_4$. **Holds.** For $n\ge5$ by padding, which the conventions file records as commuting with $Q$ and preserving norm and $\theta$; [INDEX-values.md](../findings/INDEX-values.md):21 independently records the $n=5$ member built exactly over $\mathbb Q$ with first Bianchi and $\mathrm{Ric}=0$ satisfied exactly.

**(iii) Its $\theta$ is $\sqrt{3/2}$, evaluated exactly, by hand.** Write $\lambda_1=2/\sqrt6$, $a=b=1/\sqrt6$.
- $\lVert W\rVert^2=(4+1+1)/6=1$. ✓
- $\operatorname{tr}W^3=(8-1-1)/6^{3/2}=6/(6\sqrt6)=1/\sqrt6$.
- $T_{1,N-1,N}=2$: the three nonzero eigenvectors are an orthonormal basis of $\Lambda^+\cong\mathfrak{su}(2)$, in which $[v_2,v_3]$ is a multiple of $v_1$ alone, so $T_{1,N-1,N}=\lVert[v_2,v_3]\rVert^2$. Each unit element of $\Lambda^+$ has $s_1=s_2=1/\sqrt2$ and rank $4$ with image $\mathbb R^4$, and orthogonal self-dual forms anticommute, so [L31](../findings/stratum-two-negative.md)'s converse applies verbatim: $X^2=Y^2=-P_V/2$, $[X,Y]=2XY$, and $\lVert[X,Y]\rVert^2=\tfrac12\operatorname{tr}\big((2XY)^{\mathsf T}2XY\big)=2\operatorname{tr}(Y^{\mathsf T}X^{\mathsf T}XY)=\operatorname{tr}(Y^{\mathsf T}Y)=2\lVert Y\rVert^2=2$. ✓
- $\langle W,W^\#\rangle=3T\lambda_1ab=3\cdot2\cdot\dfrac{2}{\sqrt6}\cdot\dfrac1{\sqrt6}\cdot\dfrac1{\sqrt6}=\dfrac{12}{6\sqrt6}=\dfrac2{\sqrt6}$.
- $\theta=\operatorname{tr}W^3+\langle W,W^\#\rangle=\dfrac{1}{\sqrt6}+\dfrac2{\sqrt6}=\dfrac3{\sqrt6}=\sqrt{\dfrac96}=\sqrt{\dfrac32}$. ✓

**The two halves are $1/\sqrt6$ and $2/\sqrt6$**, which is exactly the split the Lean row for [L35](../lean/INDEX.md) records independently ("unnormalised, L35's `Σλ³ = 1/√6` and `3Tλ₁λ₂λ₃ = 2/√6`"), and the $\operatorname{tr}(W_0^3)=1/\sqrt6$ that [INDEX-values.md](../findings/INDEX-values.md):21 records for the exact $n=5$ build. Three independent sites, one number.

**(iv) What its kernel does to the hypothesis.** $\dim\ker W=\binom n2-3$, $3$ at $n=4$, $7$ at $n=5$, $63$ at $n=12$, $4947$ at $n=100$. Three consequences, and only the first is in the block:

1. **The hypothesis admits it.** H3 and H4 constrain the nonzero spectrum only; the kernel is unconstrained, and that is exactly what lets one object attain the cap at every $n$ at once. **The kernel is the mechanism of the dimension-freedom, not an exception to it.**
2. **It makes the pair-cap step nontrivial rather than trivial.** $\lVert[v_{N-1},v_N]\rVert^2=\sum_\gamma T_{N-1,N,\gamma}$ runs over all $N$ directions, kernel included, while the cubic sees only $T_{1,N-1,N}$. Equality in the chain therefore demands that $[v_{N-1},v_N]$ have **no component in the kernel**, a condition on $W$ that grows harder to state as $n$ grows and which is precisely the structural content [L31](../findings/stratum-two-negative.md) supplies. At the attaining object it holds because $\Lambda^+$ is a subalgebra.
3. **It voids the gradedness screen** the block's own preamble invokes ([trap W4](../findings/INDEX-traps.md)), as recorded in §3.

**No finding on question 2**: the attaining object satisfies the hypothesis under the record's own counting convention, lies in $\mathcal W_n$ at every $n\ge4$, and has $\theta=\sqrt{3/2}$ exactly.

## 5. Quantifier order, scope, and every edge of every range

**The quantifier order as written.** "Let $W\in\mathrm{Weyl}_n$ have $\lVert W\rVert=1$ and exactly one positive and two negative eigenvalues … Then $\theta(W)\le\sqrt{3/2}$. The bound carries no dimension restriction." Read strictly, the order is $\forall n\;\forall W$, with the last sentence saying the bound does not depend on $n$, **not** that a single $W$ works for all $n$. That is the correct order and it is the one the proof establishes. The attainment clause is $\exists W$ per $n$, supplied by padding. **No finding on quantifier order.**

**The edges, one at a time.**

| edge | check | finding |
| --- | --- | --- |
| smallest admissible $n$ | $n=4$; $\mathcal W_3=0$ so $n\le3$ is vacuous. The stratum is non-empty at $n=4$ and the cap is attained there | none |
| **odd $n$** | the proof is parity-free; the $n=5$ member is on record as an exact rational build. **But** the block's exclusion sentence names $\theta_0(n)$, which [conventions.md](../findings/conventions.md) says is the balanced-sphere-product value **at even $n$ only** | see §9, candidate C3 |
| **$\ker W\ne0$** | the attaining object has kernel of dimension $\binom n2-3$; H3–H5 admit it, and §4(iv) shows the kernel is load-bearing *for the dimension-freedom* rather than an exception | none for the bound; a real defect for the preamble |
| $\ker W=0$ | impossible in this stratum for $n\ge4$: $\binom n2\ge6>3$. **So the stratum consists entirely of objects on which the record's gradedness screen is vacuous** | recorded, not a defect of the bound |
| **eigenvalue multiplicity $>1$** | at $a=b$ the negative eigenspace is $2$-dimensional and $v_{N-1},v_N$ are defined only up to $O(2)$. Under $(v_{N-1},v_N)\mapsto(v_{N-1},v_N)R$ with $R\in O(2)$, $[v_{N-1}',v_N']=\det(R)\,[v_{N-1},v_N]$, so $T_{1,N-1,N}=\langle[v_{N-1},v_N],v_1\rangle^2$ is **invariant**. Every quantity the proof uses is frame-independent | none |
| multiplicity $>1$ on the positive side | **excluded by H3 under the multiplicity reading, and admitted under the distinct-value reading, where the proof fails**, $(+++)$ and $(++-)$ then have distinct positive indices available | see §9, candidate C2 |
| $a\to0$ or $b\to0$ | outside H4; $t=b/a$ is then undefined or $f\to0$. The limit is the boundary of the stratum, not a member | none |
| $a=b$ | interior to the analysis; it is the maximiser | none |
| $n\to\infty$ | the cap is the same number; the padded object attains it at every $n$ | none |

## 6. A universal claim with no witness, one object from each structured family

The claim is universal over a spectral stratum, so it is falsified by a single object with the sign pattern and $\theta>\sqrt{3/2}$. **Analysis only: every object below is taken from the record's own catalogue and evaluated by hand; no search was run and none is proposed.**

I enumerated the structured families the record names and asked of each whether any member has **exactly one positive and two negative eigenvalues, counted with multiplicity**.

| family | where | its spectrum | has the sign pattern? |
| --- | --- | --- | --- |
| the self-dual one-parameter family $W^+=\mathrm{diag}(q+r,-q,-r)$, $W^-=0$, padded | [stratum-two-negative.md](../findings/stratum-two-negative.md):31 | $(q{+}r,-q,-r,0^{N-3})$ | **yes, the only one** |
| padded $W_{\mathbb{CP}^2}$ | [INDEX-values.md](../findings/INDEX-values.md):21 | $(2,-1,-1,0^{N-3})/\sqrt6$ | yes; it is the $q=r$ member of the row above |
| sphere products $S^p\times S^q$ | [target.md](../findings/target.md):343 | the two-eigenvalue symmetric-pair point $a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$, multiplicities $\dim\mathfrak k$ and $\dim\mathfrak m$, both $\gg2$ | no |
| $\mathbb{CP}^m$, $m\ge3$ | [target.md](../findings/target.md):470 | **three** distinct eigenvalues, all with large multiplicity | no |
| $\mathbb{HP}^2$ | [results.md](../results.md), Lemma L9 | three eigenvalues, large multiplicities | no |
| the subalgebra family $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ |  [results.md](../results.md):134 | two eigenvalues, multiplicities $r$ and $N-r$; the pattern would need $N-1=2$, i.e. $n=3$ | no |
| strongly regular graphs / diagonal critical points | [diagonal-half.md](../findings/diagonal-half.md):477 | two eigenvalues, multiplicities = edge and non-edge counts | no |
| [L34](../findings/stratum-two-negative.md)'s full-support witnesses, $m=6$ | [stratum-two-negative.md](../findings/stratum-two-negative.md):383 | $(-3,-1,1,1,1,1)/\sqrt{14}$, **four** positive, two negative | no |
| [L34](../findings/stratum-two-negative.md)'s witnesses, $m=8$ | same | $\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$, four positive, two negative | no |

**So exactly one structured family on the record has the pattern, and on it the bound is an equality in $t$, not an inequality.** I evaluated a second member of it by hand, away from the maximiser, to check the closed form against the record's independent figure:

Take $q=2,r=1$ unnormalised, i.e. $\lambda_1=3$, $-a=-1$, $-b=-2$, so $t=b/a=2$. Then $\lVert W\rVert^2=9+1+4=14$ and $\theta=9qr(q+r)/\lVert W\rVert^3=9\cdot2\cdot1\cdot3/14^{3/2}=54/(14\sqrt{14})$. Independently, $f(2)=9\sqrt2\cdot2\cdot3/(4\cdot7^{3/2})=54\sqrt2/(4\cdot7\sqrt7)=54\sqrt2/(28\sqrt7)=54/(14\sqrt{14})$, **the same closed form, exactly**, and both are $<\sqrt{3/2}$ since $t=2\ne1$. The record's figure $1.030865$ for the sign-reversed object at [stratum-two-negative.md](../findings/stratum-two-negative.md):383 is $-f(2)$, consistent with $\theta(-W)=-\theta(W)$ for a cubic.

**A structural reason no other family can have the pattern.** [Lemma L30](../results.md):445 turns Ricci-flatness into $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ with every term positive semidefinite; with a single positive eigenvalue this reads $\lambda_1v_1^{\mathsf T}v_1=a\,v_2^{\mathsf T}v_2+b\,v_3^{\mathsf T}v_3$, so $\mathrm{im}\,v_2+\mathrm{im}\,v_3=\mathrm{im}\,v_1$ and the whole stratum consists of paddings of $\mathrm{Weyl}_r$ elements with $r=\dim\mathrm{im}\,v_1$ even. [Lemma L33](../results.md):463 then forces $r=4$ outright, since $v_1$ spans a one-dimensional eigenspace and must therefore be a complex-structure multiple on a $4$-plane. **The stratum is the $r=4$ family and nothing else**, which is why the search returns one family, and why no witness exists to look for elsewhere.

**No finding: no object from any structured family the record names exceeds the cap, and only one family has the sign pattern at all.**

## 7. Comparing the forms

Six sites carry a form of L29. They agree on the cap and disagree on the converse.

| site | what it says about the cap | what it says about the converse |
| --- | --- | --- |
| [results.md](../results.md):144, landscape | cap, dimension-free, attained at $(2,-1,-1)/\sqrt6$, three blocks vanish structurally, pair cap, one closed form, single maximum | **nothing**, the cleanest of the six |
| [results.md](../results.md):441, canonical | identical statement, plus "The bound carries no dimension restriction" | *"is **Lemma L72**, listed in the closing section"* |
| [results.md](../results.md):784, closing section |, | L72 "closing the converse clause of Lemma L29 by the criticality rows alone" |
| [stratum-two-negative.md](../findings/stratum-two-negative.md):13, development form | cap, plus the exclusion sentence "since $\sqrt{3/2}<\theta_0(n)$ from $n=12$" | *"reduced but not closed"* |
| [stratum-two-negative.md](../findings/stratum-two-negative.md):35, the equality-clause paragraph |, | heading *"The equality clause, **closed**"*; body reduces it to "no full-support rank-$3$ signature-$(1,2)$ element for even $r\ge6$", "excluded numerically at $r=6,8,10$", **"$r\ge12$ untested"** |
| [stratum-two-negative.md](../findings/stratum-two-negative.md):69, canonical | identical to results.md:441 | *"closed in three lines by [L31](../findings/stratum-two-negative.md), at every $n$ and with no numerics"*, plus [L33](../findings/stratum-two-negative.md) as a second route, plus a blockquote **withdrawing the credit to L72** |

**Four mutually incompatible statuses for one clause, across two files.** The findings canonical block is the correct one; §9 records why, and records which of the others a consumer would inherit.

**The Lean form.** [lean/INDEX.md](../lean/INDEX.md):104 carries a row for L29 pointing at [HamiltonsCubic/Results/L29.lean](../lean/HamiltonsCubic/Results/L29.lean), status **partial**. It claims exactly the one-variable half, with the calculus replaced by the perfect-square identity I re-derived in §2a step 6, and lists as **owed** the reduction *to* one variable, the three vanishing blocks, the pair cap, trace-freeness and the normalisation. **The row is accurate on both counts**, and its "the cap holds at every real $t$, the stratum's $t\ge0$ is unused" is correct: the identity is an identity of polynomials.

One clause of that row overstates. It says the tensor-level converse "is [L31](../findings/stratum-two-negative.md)/[L33](../lean/HamiltonsCubic/Results/L33.lean)'s, **strictly stronger than $t=1$**". Two things are being run together. *Equality forces the spectrum* is $t=1$ plus trace-freeness plus unit norm, and is already in the block's own proof, which ends "attained only at $a=b$": $a=b$ gives $\lambda_1=2a$ and $6a^2=1$, so the spectrum is $(2,-1,-1)/\sqrt6$. What is strictly stronger, and what genuinely needs L31 or L33, is *equality forces the configuration*, that the support has dimension $4$, so the object is padded $W_{\mathbb{CP}^2}$ itself and not merely something with its spectrum. The findings development block says exactly this when it writes "the converse needs that no other **configuration** attains $\sqrt{3/2}$". **The label used at four of the six sites ("equality forces that spectrum"), names the weaker of the two statements while every machinery cited against it is aimed at the stronger.**

## 8. The named trap, each citable claim read alone, as a consumer would

This record's signature failure is a correction landing **beside** the statement it corrects. I read each citable form of L29 in isolation, without the neighbouring paragraphs, and asked what a consumer inherits.

### Candidate C1, [results.md](../results.md):441 credits L29's converse to a lemma the record has withdrawn. **CONFIRMED.**

**Locate.** [results.md](../results.md):441, the canonical statement, closing sentence:

> The converse (that equality forces that spectrum), is Lemma L72, listed in the closing section.

and again at [results.md](../results.md):784:

> **Lemma L72**, … closing the converse clause of Lemma L29 by the criticality rows alone

**Exhibit the failure concretely.** The record has adjudicated this and reached the opposite conclusion. [stratum-two-negative.md](../findings/stratum-two-negative.md):86, inside L29's own canonical block, in capitals:

> **THE CREDIT ONCE GIVEN HERE TO LEMMA L72 IS WITHDRAWN, AND THE CONTAINMENT RUNS THE OTHER WAY.** L72 quantifies over **critical** points; this clause quantifies over **equality** points … *Gate 2, [r541](../reviews/REVIEW_r541.md) and [r542](../reviews/REVIEW_r542.md) on identical briefs, agreeing.*

[INDEX-results.md](../findings/INDEX-results.md):86 records the same verdict against L72's own row, and [INDEX-results.md](../findings/INDEX-results.md):46 records L31 as having *acquired* the converse. The mathematics is not in doubt and I checked it independently: L72 assumes $Q(W)=\theta W$, L29's converse clause assumes only $\theta=\sqrt{3/2}$, and by L29 itself every critical point of the stratum is an equality point, so the critical points are a subset and a property forced on the subset is not forced on the superset. **A consumer citing results.md:441 alone inherits a withdrawn attribution, and would be entitled to think the clause holds only at critical points, or that criticality is available where it is not.**

**Compounding it**: [LEDGER.md](../findings/LEDGER.md):915 records the repair as *finished* ("Five sites carried the misattribution … **All corrected to L31**") while these two sites in [results.md](../results.md) still carry it. The ledger's own count is short by the two that matter most, because they are the canonical and the closing-section forms.

**Argue the opposite.** The most charitable reading the words support: "is Lemma L72" might be read as a pointer (*the closing section's row L72 is where the converse is discussed*) rather than as an attribution of proof. That reading survives at :441 taken as a bare cross-reference, but it does not survive :784, whose words are "closing the converse clause of Lemma L29 by the criticality rows alone". "Closing … by the criticality rows alone" is an attribution of proof and is the claim the record withdrew. **The charitable reading fails at the second site, so the candidate stands.**

### Candidate C2, the counting convention is stated nowhere a consumer of results.md can see it. **CONFIRMED.**

**Locate.** [results.md](../results.md):441 and :144: "exactly one positive and two negative eigenvalues, $\lambda_1>0>-a\ge-b$", with no statement of whether eigenvalues are counted with multiplicity or as distinct values.

**Exhibit the failure concretely.** The record has already paid for this ambiguity once, on the neighbouring lemma in the same file. [stratum-two-negative.md](../findings/stratum-two-negative.md):130, L33's blockquote:

> **"Exactly one eigenvalue of one sign" was ambiguous, and the lemma is FALSE under the other reading.** … **This file's own convention counts with multiplicity, so the statement was correct in place**, and it is quoted in [results.md](../results.md) and in the report, **where that convention does not travel.**

The same sentence applies verbatim to L29, and no site says so. Under the distinct-value reading the proof breaks at its first step: with $\lambda_1$ of multiplicity $\ge2$ there are two or more *distinct indices* carrying positive eigenvalues, so the $(+++)$ and $(++-)$ blocks have non-repeating triples available and hollowness no longer kills them. And the attaining object fails the hypothesis under that reading: $(2,-1,-1)/\sqrt6$ has **one** distinct negative value, not two, so the very object the statement names as its equality case would be outside the statement.

**Argue the opposite.** The display $\lambda_1>0>-a\ge-b$ lists two negative entries with a **non-strict** inequality between them, which signals the multiplicity reading on the negative side unambiguously, $a=b$ is admitted, and the statement is then about a two-dimensional eigenspace. That is a real mitigation and it is why this candidate is a hypothesis correction rather than a break: the negative side is unambiguous from the notation. **The positive side is not.** "Exactly one positive eigenvalue" carries no such display, and it is the side on which the distinct-value reading destroys the proof. So the candidate stands, narrowed: **the load-bearing missing word is on the positive side.**

### Candidate C3, the exclusion sentence names the record's even-$n$ constant. **CONFIRMED, conclusion unaffected.**

**Locate.** [stratum-two-negative.md](../findings/stratum-two-negative.md):13 and :114: "since $\sqrt{3/2}<\theta_0(n)$ from $n=12$, it **excludes this whole stratum at $n\ge12$**" and "no maximiser in that dimension range has this spectrum".

**Exhibit the failure concretely.** [conventions.md](../findings/conventions.md) is emphatic that $\theta_0(n)^2=2(n-1)(n-2)/n^2$ is "the value at the balanced sphere product **at even $n$ only**", that at odd $n$ the diagonal maximum is $\Theta_n$ with $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))>0$, and that the gloss which conflates them "is what regrew [L0](../findings/problem.md)'s refuted constant". The step being made is *a maximiser has $\theta\ge$ the diagonal maximum $>\sqrt{3/2}$*, and at odd $n$ the diagonal maximum is $\Theta_n$, not $\theta_0(n)$. Exact values, by hand: at $n=13$, $\Theta_{13}^2=2\cdot12\cdot10/(14\cdot11)=240/154=120/77$, and $120/77>3/2\iff240>231$ ✓; at $n=11$, $\Theta_{11}^2=2\cdot10\cdot8/(12\cdot9)=160/108=40/27<3/2$ since $80<81$. At even $n=12$, $\theta_0(12)^2=2\cdot11\cdot10/144=55/36>3/2$ since $110>108$; at $n=10$, $2\cdot9\cdot8/100=36/25<3/2$.

**So the conclusion "from $n=12$" is correct at both parities**, $\theta_0^2$ and $\Theta_n^2$ are both increasing in $n$, and the first crossing is $n=12$ on the even side and $n=13$ on the odd, **but the constant named is the wrong one at odd $n$**, and it is exactly the substitution the conventions file names as a recurring defect.

**Argue the opposite.** A reader could take "no maximiser has this spectrum" as an even-$n$ statement, since the headline conjecture is an even-$n$ one and the record's scope note says so. That reading is available and makes the sentence true as written. It is also not what the sentence says, "at $n\ge12$", "no dimension restriction", and the surrounding claim of dimension-freedom all read across both parities. **The candidate stands as a scope correction, not as an error in the conclusion.**

### Candidate C4, the inequality L29 runs on is not in the statement of the lemma cited for it. **CONFIRMED.**

**Locate.** [results.md](../results.md):453, the canonical statement of L31 in full:

> For orthonormal $X,Y\in\mathfrak{so}(n)$, $\|[X,Y]\|^2=2$ if and only if $XY=-YX$, both $X$ and $Y$ have rank $4$ with all singular values $1/\sqrt2$, and $\mathrm{im}\,X=\mathrm{im}\,Y$.

There is no inequality in it. The landscape line at [results.md](../results.md):156 adds "The root system gives $\max_Y\|[X,Y]\|^2=(s_1+s_2)^2$, and Cauchy–Schwarz forces the rest", from which the bound is two lines away but is still not stated.

**Exhibit the failure concretely.** L29's proof says "the pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\|[v_\alpha,v_\beta]\|^2\le2$ bounds it", and [conventions.md](../findings/conventions.md) asserts flatly that this inequality **is** L31: "The pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ is **[Lemma L31](../findings/stratum-two-negative.md)**, proved with its equality case characterised." A consumer who follows L29 to L31 in [results.md](../results.md) finds a characterisation of the *equality* case and no bound. **The single inequality on which the entire cap rests is citable only from a conventions bullet and from inside another lemma's proof.** This is the named trap in its purest form: the content sits beside the statement.

**Argue the opposite.** The title "the bracket cap, characterised" implies a cap exists and is being characterised, and an iff for $\lVert[X,Y]\rVert^2=2$ is uninteresting unless $2$ is the maximum. That is a fair inference and it is why I grade this a hypothesis correction and not a break. But an inference is not a statement, and the derivation of $\le2$ from the landscape line's max identity needs the further input $\sum_is_i^2=1$, which is a normalisation from [conventions.md](../findings/conventions.md) and is not in either L31 form. **The candidate stands.**

### Candidate C5, the development block holds three statuses of one clause, one of them self-contradicting. **CONFIRMED.**

**Locate.** In one file: [stratum-two-negative.md](../findings/stratum-two-negative.md):13 says *"reduced but not closed"*; :35 is headed *"The equality clause, **closed**"* and its own body ends *"with **$r\ge12$ untested**"*; :69's canonical block says *"closed in three lines by Lemma L31, at every $n$ and with no numerics"*.

**Exhibit the failure concretely.** The heading and body of :35 contradict each other in nine lines. And the canonical block's route is correct and needs none of the numerics :35 hedges on, I checked it: equality forces $T_{1,N-1,N}=2$ (strictly, since $\lambda_1ab>0$), hence $\lVert[v_{N-1},v_N]\rVert^2=2$ by the cap being squeezed from both sides, hence by L31 $\mathrm{im}\,v_{N-1}=\mathrm{im}\,v_N$ of dimension $4$, hence by the Ricci-flat PSD identity $\mathrm{im}\,v_1$ has dimension $4$, hence $r=4$. **So :13 and :35 are stale against :69 in the same file**, and a consumer opening the file at its development block reads a hedge on untested dimensions that its own canonical block has retired.

**Argue the opposite.** The development block is labelled "in development form" and headed by "*The statement and its proof are Lemma L29 below; this is the working it came from*", so a reader is told which of the two is canonical. That is a genuine mitigation and it is why this is graded GAP rather than BROKEN. It does not extend to the "closed"/"untested" contradiction inside :35, which no labelling repairs.

### Candidates considered and **withdrawn**

- **The factor $3$ in $3T_{1,N-1,N}\lambda_1ab$.** I suspected a factor-2 slip against the ordered-tuple convention. **Withdrawn**: there are exactly $3!=6$ ordered non-repeating triples on $\{1,N-1,N\}$, each with the same $T$ by total symmetry, and the $\tfrac12$ in front gives $3$. The block is right.
- **"Unique stationary point on $t\ge0$" ignoring the endpoint.** **Withdrawn**: $f(t)=\tfrac{9\sqrt2}{4}t(t+1)(t^2+t+1)^{-3/2}$ has $f(0)=0$ and $f'(0)=9\sqrt2/4>0$, so $t=0$ is not stationary and is not a maximum; the statement is exact.
- **The $(---)$ antisymmetry reason.** I suspected it needed $c$ restricted to a subspace to remain alternating. **Withdrawn**: $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is a totally antisymmetric trilinear form on all of $\mathfrak{so}(n)$, so its restriction to any subspace is alternating, and an alternating $3$-form on a $2$-dimensional space is zero. The reason is sound, and hollowness gives the same conclusion independently.
- **Frame-dependence of $T_{1,N-1,N}$ at $a=b$.** **Withdrawn**: under $(v_{N-1},v_N)\mapsto(v_{N-1},v_N)R$, $R\in O(2)$, the bracket picks up $\det R=\pm1$ and $T$ is a square. Invariant.

## 9. The gap between what is proven and what is used

### 9a. Two further claims in the block that the block does not prove

**Candidate C6, "It reaches $k=2$ as well". HYPOTHESIS-DEBT.**

*Locate.* [stratum-two-negative.md](../findings/stratum-two-negative.md):114: "**It reaches $k=2$ as well, and the reason first given for stopping at $k=1$ is wrong on both counts.** $(+++)$ does not reappear at $k=2$, needing three distinct positive indices; and $(++-)$ reappearing costs nothing, since it enters with $\lambda_+\lambda_+\lambda_-<0$ against $T\ge0$ and is free to drop from an upper bound. What the extension actually turns on is the **joint** cap $T_{1,N-1,N}+T_{2,N-1,N}\le2$ rather than the per-index one, which alone would give $3a$ with maximum $1.5$."

*Exhibit.* Every clause of the **reason** checks. $(+++)$ needs three distinct positive indices and only two exist, so hollowness kills it. $(++-)$ enters with a negative product against $T\ge0$, so dropping it can only raise an upper bound. And the arithmetic of the last clause checks by hand: at $\lambda_1=\lambda_2=a=b=\tfrac12$ (trace-free, $\sum\lambda^2=1$), $\operatorname{tr}W^3=0$ and the $(+--)$ block is $3ab(T_1\lambda_1+T_2\lambda_2)$; the per-index cap $T_i\le2$ gives $6ab(\lambda_1+\lambda_2)=6\cdot\tfrac14\cdot1=\tfrac32$, exactly the "maximum $1.5$" the block names, while the joint cap gives $3ab\cdot2\max_i\lambda_i=6a^3=\tfrac34<\sqrt{3/2}$. **The correction is right and I confirm it.** What is **not** on file anywhere I could find, including [LEDGER.md](../findings/LEDGER.md):621, which records the same correction from [r514](../reviews/REVIEW_r514.md), and [ATTEMPTS.md](../ATTEMPTS.md):2698–2723, whose four entries re-filed out of [stratum-two-negative.md](../findings/stratum-two-negative.md) I read in full and which are archaeology of that file's wording, an understated attainment clause, a withdrawn rank reading at $n=8$, a superseded $n\le4$ covering claim and a fake-padding attempt (none carrying a $k=2$ derivation), is the maximisation itself. The development block at :23 asserts "maximising the resulting bound over the whole two-parameter family returns $\sqrt{3/2}$ again, attained only in the limit $\lambda_2\to0$, $a=b$", and no derivation of that two-parameter maximisation appears in any of the six sites.

*Argue the opposite.* The claim is not needed: [L35](../results.md):483 covers **any** number of positive eigenvalues unconditionally, so the $k=2$ extension is subsumed and nothing downstream depends on L29 supplying it. That is a genuine mitigation of *impact* and not of *status*, and it cuts the other way too, because [LEDGER.md](../findings/LEDGER.md):1403 records that **L35's proof consumes L29 for $k\le2$**, so the two results are not independent and L35 cannot discharge L29's own $k=2$ claim without circularity. **The debt stands: what would have to be shown is the two-parameter maximisation under the joint cap.**

**Candidate C7, the identity paragraph asserts the $\Lambda^\pm$ split it needs. PROVEN, hypotheses corrected.**

*Locate.* [stratum-two-negative.md](../findings/stratum-two-negative.md):104: "at dimension four $v_2,v_3$ are an orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$, where every orthonormal pair brackets to norm-squared $2$."

*Exhibit.* That $v_2,v_3$ lie in one chirality block is asserted, not derived, and it is what the identity claim turns on. The derivation the record has the pieces for but does not write: $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, so $W$ preserves each block and is trace-free on each; a nonzero trace-free operator on a $3$-dimensional space carries both signs, so if both blocks were nonzero there would be at least two positive eigenvalues, against H3. Hence one block is zero and the other carries the whole spectrum $(a{+}b,-a,-b)$, and $v_1,v_2,v_3$ are an orthonormal basis of it. **The conclusion is right**; the step is one sentence and it is missing from all six sites. The development block at :31 comes closest, naming $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ in a different sentence, for a different purpose.

*Argue the opposite.* The paragraph is a remark on sharpness, not part of the bound's proof, and is labelled as such. True, and it is why this is a hypothesis correction. But the paragraph is also the record's warrant for "$\theta=f(t)$ **exactly**, not merely at the maximiser", which is a stronger and separately citable claim than the cap.

### 9b. What a consumer may cite, stated exactly

**May cite, unconditionally:**

- For every $n\ge4$ and every $W\in\mathcal W_n$ with $\lVert W\rVert=1$ whose spectrum has **exactly one positive and exactly two negative entries, counted with multiplicity**, $\theta(W)\le\sqrt{3/2}$, with no dependence on $n$ and no parity restriction.
- The bound is **sharp** and attained, at every $n\ge4$, by padded $W_{\mathbb{CP}^2}$, spectrum $(2,-1,-1)/\sqrt6$, whose $\theta$ is exactly $3/\sqrt6$.
- The equality case on the spectrum: $\theta=\sqrt{3/2}$ forces $a=b$, hence the spectrum $(2,-1,-1)/\sqrt6$. **This follows from the block's own chain and needs neither L31 nor L33 nor any numerics.**
- The bound holds for any trace-free symmetric operator on $\Lambda^2\mathbb R^n$ with that sign pattern, whether or not it satisfies first Bianchi or is Ricci-flat. **Stronger than the statement, and the block does not say it.**

**May cite, with the dependency named:**

- The equality case at the level of the *configuration*, that equality forces $r=\dim\mathrm{im}\,v_1=4$, so the object is padded $W_{\mathbb{CP}^2}$ itself, rests on **[L31](../findings/stratum-two-negative.md)** (three lines, at every $n$), or independently on **[L33](../results.md):463** with its own multiplicity convention and its complex-structure exception. **Cite L31 or L33, never L72.**
- "$\theta=f(t)$ exactly on the stratum" rests on the Ricci-flat PSD identity ([L30](../results.md):445) plus the $\Lambda^\pm$ step of C7 plus L31's converse.

**May not cite:**

- **L72 as closing L29's converse.** Withdrawn on the record; the containment runs the other way.
- **L29 for $k\ge2$ positive eigenvalues.** The block's $k=2$ claim carries no maximisation. For general $k$ the record's result is [L35](../results.md):483, whose own closing inequality is proved by interval arithmetic and whose Lean row marks that interval as owed.
- **"$\sqrt{3/2}<\theta_0(n)$ from $n=12$" at odd $n$** without substituting $\Theta_n$; the conclusion survives the substitution, the sentence as written does not.
- **The preamble's $S(W)=0$ observation as evidence.** [Trap W4](../findings/INDEX-traps.md) makes it vacuous on every member of this stratum, all of which have $\ker W\ne0$.

## 10. What would break it, and what I did to look for it

**The falsifier.** A single $W\in\mathcal W_n$, unit norm, with exactly one positive and exactly two negative eigenvalues counted with multiplicity, and $\theta(W)>\sqrt{3/2}$.

**Where such an object would have to live.** The chain has exactly one inequality, so the falsifier must break it: it needs $T_{1,N-1,N}>2$, i.e. two orthonormal $X,Y\in\mathfrak{so}(n)$ with $\lVert[X,Y]\rVert^2>2$. Everything else in the chain is an identity in the eigenvalues.

**What I did to look for it, analytically.**

- Checked the pair cap against the two extreme structured cases the record names. **Simple bivectors**: $[\varphi_{12},\varphi_{13}]=\pm\varphi_{23}$ has norm-squared $1$, and indeed $\varphi_{12}$ has $s_1=1,s_2=0$ so its own root bound is $(s_1+s_2)^2=1$. **Self-dual pairs**: orthonormal $X,Y\in\Lambda^+$ give exactly $2$, on the cap. Nothing between them can exceed, since $(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2\sum_is_i^2=2$ with equality only at $s_1=s_2=1/\sqrt2$, the rest zero.
- Swept the record's structured families for the sign pattern (§6): sphere products, $\mathbb{CP}^m$, $\mathbb{HP}^2$, the subalgebra family, strongly regular graphs, [L34](../findings/stratum-two-negative.md)'s full-support witnesses. **Only the self-dual $\mathrm{Weyl}_4$ family has it**, and on it $\theta=f(t)$ exactly, so no member exceeds.
- Checked whether the stratum could be larger than that family. It cannot: [L30](../results.md):445 makes every member a padding of a $\mathrm{Weyl}_r$ element with $r=\dim\mathrm{im}\,v_1$, and [L33](../results.md):463 forces $r=4$.
- Checked the one reading under which the proof genuinely fails (distinct-value counting, candidate C2) for a witness. The record's nearest object, $W^+=W^-=\mathrm{diag}(2,-1,-1)$ at $n=4$ with spectrum $(2,2,-1,-1,-1,-1)$, has one distinct value of each sign and so does not meet even the loosened hypothesis. **Constructing a witness under that reading would need a search, and this programme is on an analysis-only footing, so I did not open one.** What would decide it is named in §11.

**No falsifier found, and none is suggested by the structure of the chain.**

## 11. Verdict

**PROVEN, hypotheses corrected**, with one clause of the canonical form **BROKEN** and one sub-claim carrying **HYPOTHESIS-DEBT**.

**Proven.** L29's cap $\theta\le\sqrt{3/2}$ on the one-positive two-negative stratum is correct, and its proof is correct as written. I re-derived every step by hand: the cubic in the eigenbasis, the block split, the surviving $3T_{1,N-1,N}\lambda_1ab$, the pair-cap estimate, the collapse to $9ab(a+b)$, the substitution to $f(t)$, and the maximum $\sqrt{3/2}$ at $t=1$ alone, the last both by the block's calculus and by the exact factorisation $4(t^2+t+1)^3-27t^2(t+1)^2=\big((t-1)(t+2)(2t+1)\big)^2$, which I verified by expansion. The bound is genuinely dimension-free, and the single reason is that the chain buys its bracket bound from the pair cap rather than from the row marginal. The attaining object is real, lies in $\mathcal W_n$ at every $n\ge4$ of either parity, and has $\theta=3/\sqrt6=\sqrt{3/2}$ exactly, by a hand evaluation whose two halves $1/\sqrt6$ and $2/\sqrt6$ match three independent sites on the record. All three vanishing sign-blocks vanish, each under a hypothesis the statement carries.

**The hypotheses corrected**, in the order a consumer meets them:

1. Eigenvalues are counted **with multiplicity**, and the load-bearing instance is the positive side (C2).
2. The pair-cap **inequality** $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ is the whole of the estimate and is **not in L31's canonical statement**; it must be cited from L31's proof or from [conventions.md](../findings/conventions.md) (C4).
3. Membership in $\mathcal W_n$ is used only for trace-freeness; the result is a theorem about trace-free symmetric operators on $\Lambda^2$, and the record does not say so.
4. The exclusion sentence must read against $\Theta_n$ at odd $n$; its conclusion "from $n=12$" survives (C3).
5. The identity claim's $\Lambda^\pm$ step is one missing sentence, supplied by $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ and trace-freeness on each block (C7).

**Broken.** [results.md](../results.md):441 and :784 credit L29's converse clause to [L72](../findings/stratum-two-negative.md). That credit is withdrawn on the record by Gate 2, and the findings file's own canonical block says so in capitals; [LEDGER.md](../findings/LEDGER.md):915 declares the repair complete across "five sites" while the canonical and closing-section forms still carry it. **This is the named trap exactly: the correction landed beside the statement, in the findings file, and the citable form inherited the defect.** The repair is to replace "is Lemma L72" with "is closed in three lines by Lemma L31, at every $n$ and with no numerics" at :441, and to strike the closing clause of :784.

**Hypothesis-debt.** The block's "It reaches $k=2$ as well" carries the corrected *reason* (which I confirmed, arithmetic included) and not the two-parameter maximisation the claim needs. **What would have to be shown**: that maximising $\operatorname{tr}W^3+3ab\,(T_1\lambda_1+T_2\lambda_2)$ subject to $T_1+T_2\le2$, $\lambda_1+\lambda_2=a+b$ and $\lambda_1^2+\lambda_2^2+a^2+b^2=1$ returns $\sqrt{3/2}$, attained only in the limit $\lambda_2\to0$, $a=b$. It cannot be discharged by citing [L35](../results.md):483, whose proof [LEDGER.md](../findings/LEDGER.md):1403 records as consuming L29 at $k\le2$.

**Gap.** The development-form block at [stratum-two-negative.md](../findings/stratum-two-negative.md):13 and :35 carries two stale statuses of the converse clause, one of them contradicting its own heading, both retired by the canonical block sixty lines below.

**What computation would decide, and was not run.** Whether a witness exists for the distinct-value reading of C2, an element of $\mathcal W_n$ with one distinct positive value of multiplicity $\ge2$, two distinct negative values, and $\theta>\sqrt{3/2}$, is a search question. Its outcome would decide whether C2's ambiguity is a citation defect only, as I have graded it, or a false statement in the canonical form. **This programme is on an analysis-only footing and I opened no search; the item is recorded, not worked around.**

---

*Verifier v151. No script was run and no numerical result is relied on anywhere above; every value is an exact hand evaluation. Log: [agent_logs/verify-L29-v151.log](../agent_logs/verify-L29-v151.log).*
