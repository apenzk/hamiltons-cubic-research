# Reviewer 1001: do the Lean layer's diagonal-locus definitions mean what the record means?

*Cold brief: [BRIEF-g2-diaglocus-defs.md](BRIEF-g2-diaglocus-defs.md), no prior report read, no author's conclusion supplied. **No numerical work was done.** Every value below is exact, rational or in closed form, derived by hand from the definitions. The one machine step is `lake build` plus `#print axioms`, which reports what the kernel already holds rather than computing a new value. Log: [agent_logs/r1001.log](../agent_logs/r1001.log).*

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | [Pcubic](../lean/HamiltonsCubic/Base/WeylReal.lean#L170) is the record's $P$, normalisation included | **CONFIRMED** |
| 2 | [diagOp](../lean/HamiltonsCubic/Base/Families.lean#L147) and [IsWeight](../lean/HamiltonsCubic/Base/Families.lean#L153) are the record's operator and $\mathcal D_n$ | **CONFIRMED**, with one scope note |
| 3 | [diagP](../lean/HamiltonsCubic/Base/Families.lean#L641) is the record's weighted-graph functional | **CONFIRMED** term for term |
| 4 | [DiagCubicFormula](../lean/HamiltonsCubic/Base/Families.lean#L649) and [SphereProductValue](../lean/HamiltonsCubic/Base/Families.lean#L622) say what they are named for, and exclude something | **CONFIRMED**, exclusion witnesses exhibited for both |
| 5 | the new theorems' hypothesis sets are sufficient and each binder earns its place | **CONFIRMED with one correction**: symmetry is unnecessary in [trCube_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L331) |
| 6 | [sphereWeight](../lean/HamiltonsCubic/Base/Families.lean#L291) is the record's weight at the stated scale, [thetaSplit](../lean/HamiltonsCubic/Base/Families.lean#L479) is $\theta_{p,q}$ | **CONFIRMED**, the scale is exactly $pq$ |
| 7 | DiagCubicFormula and L57's $\operatorname{tr}W^3$ bridge are "the same statement under another name" | **REFUTED as stated**, true in one direction only, and the consequence survives |

**Actionable summary.** Two documentation repairs and one hypothesis to drop: [SharpDiag.lean:400](../lean/HamiltonsCubic/Base/SharpDiag.lean#L400) still says *seven results take it as a Lean hypothesis* eleven lines above the body's corrected *ONE Lean binder, not seven*; the phrase *the same statement under another name* overstates a one-way implication in three places; and [trCube_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L331) binds a symmetry hypothesis its conclusion does not need.

## 0. Conventions, fixed once

- $n = $ `Fintype.card ι`, $p = $ `S.card`, $q = $ `Sᶜ.card`, $p + q = n$.
- $\varphi_{ij} = e_{ji} - e_{ij}$, so $(\varphi_{ij})_{ji} = +1$ and $(\varphi_{ij})_{ij} = -1$. This is [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45).
- $\langle X, Y\rangle_2 = \tfrac12\operatorname{tr}(X^{\mathsf T}Y) = \tfrac12\sum_{a,b}X_{ab}Y_{ab}$, which is [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39). Under it $\lVert\varphi_{ij}\rVert = 1$ at $i\ne j$.
- $\langle R, S\rangle = \tfrac12\sum_{i,j}\langle R\varphi_{ij}, S\varphi_{ij}\rangle_2$, which is [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135).
- $w$ ranges over $\mathbb R^{\iota\times\iota}$. $M$ and $K$ are the record's names for the same object, its sectional or vertex matrix.
- All sums written $\sum_{a,b}$ are over ordered pairs, all sums written $\sum_{a<b}$ over unordered ones.

## Hypothesis inventory, as the theorems bind it

| theorem | binders | conclusion |
| --- | --- | --- |
| [sharpQF_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L181) | $w$ symmetric, $a \ne b$ | $\operatorname{sharpQF}(\operatorname{diagOp}w)(\varphi_{ab}) = \sum_{d\notin\{a,b\}}w_{ad}w_{bd}$ |
| [trCube_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L331) | $w$ symmetric, $w$ hollow | $\operatorname{trCube}(\operatorname{diagOp}w) = \tfrac12\sum_{a,b}w_{ab}^3$ |
| [sharpPair_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L372) | $w$ symmetric, $w$ hollow | $\operatorname{sharpPair}(\operatorname{diagOp}w) = \tfrac12\operatorname{tr}w^3$ |
| [sphereWeight_diagP](../lean/HamiltonsCubic/Base/SphereValue.lean#L309) | $2\le p$, $2\le q$ | $\operatorname{diagP}(\operatorname{sphereWeight}S) = (n-1)\lVert\operatorname{diagOp}(\operatorname{sphereWeight}S)\rVert^2$ |

**Kernel status, read rather than assumed.** `lake build HamiltonsCubic.Base.SphereValue` completes over 8712 jobs, and `#print axioms` returns `[propext, Classical.choice, Quot.sound]` on all seven of `diagCubicFormula`, `sharpQF_diagOp`, `trCube_diagOp`, `sharpPair_diagOp`, `sphereProductValue`, `sphereWeight_diagP` and `theta_sphereProduct_value`. No `sorryAx`, no `native_decide` taint on this chain. So the round is about the objects and not about the manipulations, as the brief directs.

## 1. Pcubic, and the three constants it carries

**Verdict: CONFIRMED.** The record's $P(W) = \langle W, Q(W)\rangle$ with $Q(W) = W^2 + W^\#$, read on $\Lambda^2$ with $\lVert W\rVert^2 = \operatorname{tr}_{\Lambda^2}(W^2)$, is what [Pcubic](../lean/HamiltonsCubic/Base/WeylReal.lean#L170) computes.

**The $\tfrac12$ in inner2** makes $\varphi_{ab}$ a unit bivector. The record's basis on the diagonal locus is $f_a\wedge f_b$, also unit, with $W(f_a\wedge f_b) = K_{ab}f_a\wedge f_b$ ([diagonal-half.md](../findings/diagonal-half.md), Lemma L176's proof). Since [diagOp_phi](../lean/HamiltonsCubic/Base/Families.lean#L160) gives $\operatorname{diagOp}w\,(\varphi_{ij}) = w_{ij}\varphi_{ij}$, the eigenvalue carries no factor and $w_{ab} = K_{ab}$ exactly. Under plain Frobenius $\lVert\varphi_{ab}\rVert^2$ would be $2$ and the eigenvalue identification would still hold, but $\lVert W\rVert$ would inflate by $\sqrt2$ and $\theta$ deflate by the same, which is the failure the file's own comment names.

**The $\tfrac12$ in innerOp** pays for the ordered-pair sum. $\tfrac12\sum_{i,j} = \sum_{i<j}$, so $\langle R,S\rangle$ is the Frobenius pairing of two operators over the orthonormal family $\{\varphi_{ij}\}_{i<j}$, which is the record's. The check is [diagOp_normSq](../lean/HamiltonsCubic/Base/Families.lean#L257): $\lVert\operatorname{diagOp}w\rVert^2 = \tfrac12\sum_{a,b}w_{ab}^2 = \sum_{a<b}w_{ab}^2$, so the record's normalisation $\operatorname{tr}M^2 = 2$ is exactly $\lVert W\rVert^2 = 1$. [conventions.md](../findings/conventions.md) states the same as $\sum_\alpha\lambda_\alpha^2 = \operatorname{tr}(W^2) = 1$.

**The $-\tfrac14$ in sharpQF** is $-\tfrac12$ (the definition $\langle R^\#\eta,\eta\rangle = -\tfrac12\operatorname{tr}(\mathrm{ad}_\eta R\,\mathrm{ad}_\eta R)$, read over the unordered basis) times $\tfrac12$ (the ordered-pair double count). It is the one constant the record cannot independently anchor, since [problem.md](../findings/problem.md) records $\langle W,W^\#\rangle = \tfrac12\langle M^2,M\rangle$ as *supported by agreement at test points, which is a hypothesis rather than evidence*. **So it is anchored here against the literature instead, which is an anchor the record does not itself supply for this constant.**

**The external anchor, derived here in closed form.** [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 2.25 gives $\theta_{k,l}^2 = 2(n-1)(k-1)(l-1)/((n-2)kl)$, transcribed at [problem.md:168](../findings/problem.md). Take $p = q = m$, $n = 2m$, and the Lean weight $\alpha = q/(p-1) = m/(m-1)$ in both blocks, $-1$ across. Its spectrum is $0$ on $\mathbf 1$, $2m$ on $(\mathbf 1_m, -\mathbf 1_m)$, and $-m/(m-1)$ with multiplicity $2(m-1)$ on the within-block mean-zero vectors. Then

$$\textstyle\sum_{a,b}w_{ab}^2 = \frac{2m^3}{m-1} + 2m^2,\qquad \sum_{a,b}w_{ab}^3 = \frac{2m^4}{(m-1)^2} - 2m^2,\qquad \operatorname{tr}w^3 = 8m^3 - \frac{2m^3}{(m-1)^2},$$

so $\lVert W\rVert^2 = \tfrac12\sum w^2 = m^2(2m-1)/(m-1)$ and

$$\operatorname{diagP}(w) = \tfrac12\Big(\tfrac{2m^4}{(m-1)^2} - 2m^2 + 8m^3 - \tfrac{2m^3}{(m-1)^2}\Big) = \frac{4m^4 - 4m^3 + m^2}{m-1} = \frac{m^2(2m-1)^2}{m-1} = (n-1)\lVert W\rVert^2 .$$

At unit norm, $t^2\lVert W\rVert^2 = 1$ and $P = t^3(n-1)\lVert W\rVert^2 = t(n-1)$, so $P^2 = (n-1)^2/\lVert W\rVert^2 = 2(n-1)(n-2)/n^2 = \theta_0(n)^2$. **That is Nienhaus's value at the balanced split and the record's $\theta_0$, reached through every one of the three constants at once.** A factor error anywhere in the stack would move it: the sharp term contributes $1.213562$ of $\theta_0(12) = 1.236033$ and the entrywise term $0.022471$, so the two are not interchangeable and no scaling of $w$ can absorb a constant on one of them.

**What is not confirmed, and it is the layer's own open item rather than a defect found here.** That [sharpOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L153) is $R^\#$ *off* the diagonal locus needs $\operatorname{sharpBil}R\,X$ linear in its second slot, hence $R$ linear, which [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) names as owed and no file discharges. On the locus the question does not arise: [isLinOp_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L278) supplies the linearity, and the Nienhaus match closes the normalisation. **So item 1's confirmation is scoped to the diagonal locus, which is where items 2 to 7 live.**

## 2. diagOp and IsWeight against the record's $\mathcal D_n$

**Verdict: CONFIRMED, with one scope note.**

[conventions.md:47](../findings/conventions.md) defines $\mathcal D_n = \{S \text{ symmetric, hollow}, S\mathbf1 = 0\}$ and sources it to [diagonal-half.md](../findings/diagonal-half.md), which writes the same three as *the symmetric matrix of edge weights (zero diagonal)* with $M\mathbf1 = 0$. [IsWeight](../lean/HamiltonsCubic/Base/Families.lean#L153) binds `symm`, `hollow`, `rowSum`. **The match is exact in both directions: no clause of the record is missing and no clause is added.**

Three checks on the boundary of that match.

- **$\operatorname{tr}M = 0$ is in the record's display and absent from IsWeight, correctly.** Hollowness implies it, so it is a consequence rather than a fourth clause. The file's own docstring says exactly this.
- **$\operatorname{tr}M^2 = 2$ is in the record's display and absent from IsWeight, also correctly.** It is a normalisation, and $\mathcal D_n$ is a cone in the record ($\theta$ is scale-invariant along it) as it is in Lean ([IsWeight.smul](../lean/HamiltonsCubic/Base/Families.lean#L181)). Folding it into the locus would break [diagP_smul](../lean/HamiltonsCubic/Base/SphereValue.lean#L293) and the whole $t$-quantification of SphereProductValue.
- **The $\Lambda^2$ reading is faithful.** The record's operator is defined on $\Lambda^2$ and diagOp is defined on all matrices, so the extension to symmetric arguments is a choice the record does not make. It is inert: $\operatorname{br}$ of two skew matrices is skew, so [sharpQF](../lean/HamiltonsCubic/Base/WeylReal.lean#L102) applies $R$ only to skew arguments, and [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135), [Ric](../lean/HamiltonsCubic/Base/WeylReal.lean#L106) and [bianchi](../lean/HamiltonsCubic/Base/WeylReal.lean#L110) all read $R$ on $\varphi$'s alone. **Nothing in Pcubic or normSq ever sees the extension.**

**The scope note, and it is a real difference of quantifier.** The Lean pair (diagOp, IsWeight) is the **coordinate**-diagonal locus, in the fixed frame indexed by $\iota$. [Lemma L57](../findings/problem.md) quantifies over *every unit $W$ diagonal in some frame*, an existential over $O(n)$. The two agree in value because $\theta$ is $O(n)$-invariant, **and that invariance is not typed anywhere in this layer**. The record already keeps the distinction ([L176](../findings/diagonal-half.md) says *coordinate-diagonal locus* and problem.md says *a coordinate-diagonal Weyl operator is determined by its vertex matrix*), so this is a note about what a consumer may infer, not a mismatch. It bites only if some file reads a diagOp result as a statement about all diagonal $W$.

## 3. diagP, term for term

**Verdict: CONFIRMED.**

[diagonal-half.md](../findings/diagonal-half.md) states the locus functional twice. First in graph form,

$$\theta(w) = \sum_{a<b}w_{ab}^3 + 3\!\!\sum_{a<b<c}\!\!w_{ab}w_{bc}w_{ca},$$

then, after $\sum_{a<b<c}w_{ab}w_{bc}w_{ca} = \tfrac16\operatorname{tr}M^3$, in matrix form $\theta = \tfrac12(\sum_{a,b}M_{ab}^3 + \operatorname{tr}M^3)$ at $\operatorname{tr}M^2 = 2$. [diagP](../lean/HamiltonsCubic/Base/Families.lean#L641) is $\tfrac12(\sum_a\sum_b w_{ab}^3 + (w\cdot w\cdot w).\mathrm{trace})$, character for character the second form.

**Both halves of the brief's question check.** The $\tfrac12$ on the entrywise term converts the ordered sum to the unordered one, $\tfrac12\sum_{a,b}w^3 = \sum_{a<b}w^3$, which is the graph form's first term. The $\tfrac12$ on the trace converts to the triangle sum, $\tfrac12\operatorname{tr}M^3 = 3\sum_{a<b<c}w_{ab}w_{bc}w_{ca}$, which is the graph form's second term with its coefficient $3$ intact. **So one constant serves both terms and the record's two forms are the same object.**

**One naming hazard, and the file avoids it.** The record calls the displayed quantity $\theta$, because it writes it at $\operatorname{tr}M^2 = 2$. diagP is the unnormalised cubic and is degree-$3$ homogeneous ([diagP_smul](../lean/HamiltonsCubic/Base/SphereValue.lean#L293)), so diagP is $P$ and equals $\theta$ only on the unit sphere. The docstring says so, naming the normalisation under which the two agree and citing [diagOp_normSq](../lean/HamiltonsCubic/Base/Families.lean#L257) for the translation. **Correct as written.**

## 4. The two Props, and the trap from plan-lean

[plan-lean.md](../plan-lean.md)'s trap: *before closing a `sorry`, exhibit an object its hypotheses rule out*, since a hypothesis satisfied by everything in range makes a discharge empty.

**Verdict: CONFIRMED for both. Each hypothesis set is a proper restriction, and each Prop is non-vacuous.**

### DiagCubicFormula

The statement is $\forall w,\ \mathrm{IsWeight}\,w \to \mathrm{Pcubic}(\mathrm{diagOp}\,w) = \mathrm{diagP}\,w$. It names the obligation *that Pcubic at a diagonal operator is the record's weighted-graph functional*, and that is what it says, over exactly $\mathcal D_n$ by item 2.

- **Object ruled out, with the conclusion in genuine doubt there.** At $\iota = \mathrm{Fin}\,2$ with $w_{01} = 1$ and $w_{10} = 0$, hollow and not symmetric, $(\operatorname{diagOp}w)(\varphi_{01})$ has entry $0$ at $(1,0)$ and $-1$ at $(0,1)$, so it is **not skew**. The operator leaves $\Lambda^2$ and the record's object is gone before any value is computed. The `symm` clause is what excludes it.
- **Object ruled out by `hollow`, where the conclusion is false.** At $w = e_{00}$, symmetric, not hollow, with zero row sums off index $0$: every $\varphi_{ij}$ at $i\ne j$ has $w_{ij} = 0$, so $\operatorname{diagOp}w$ annihilates every basis bivector and $\mathrm{Pcubic} = 0$, while $\mathrm{diagP}\,w = \tfrac12(1 + 1) = 1$. **A concrete failure, so `hollow` earns its binder.**
- **Object ruled out by `rowSum`, where the conclusion nevertheless holds.** Any symmetric hollow $w$ with $w\mathbf1\ne0$, for instance $\iota = \mathrm{Fin}\,3$ with $w_{01} = w_{10} = 1$ and the rest zero. [diagCubicFormula](../lean/HamiltonsCubic/Base/SharpDiag.lean#L403) reads only `hwt.symm` and `hwt.hollow`, and the file says so in its own closing section. **So the Prop as stated is strictly weaker than what is proved.** That is the right call for this Prop, not a defect: IsWeight is the record's $\mathcal D_n$, a consumer quantifying over the locus wants exactly that hypothesis, and a wider statement would invite a reader to use it at non-Weyl weights where `diagOp_isWeyl` fails.
- **Non-vacuity.** [exists_unit_sphereProduct](../lean/HamiltonsCubic/Base/Families.lean#L425) builds an IsWeight witness at every $\iota$ carrying a $2+2$ split, so the quantifier is inhabited.

### SphereProductValue

The statement is $\forall S,\ 2\le p \to 2\le q \to \forall t,\ 0 < t \to \lVert\operatorname{diagOp}(t\cdot\operatorname{sphereWeight}S)\rVert^2 = 1 \to \mathrm{Pcubic}(\ldots) = \theta_{p,q}$. It names *that a unit-norm member of the family carries $P = \theta_{p,q}$*, and that is what it says.

- **Object ruled out by $2\le p$, where the conclusion is false.** Item 5 exhibits it: at $\iota = \mathrm{Fin}\,3$, $S = \{0\}$, the identity $\operatorname{diagP} = (n-1)\lVert\cdot\rVert^2$ fails $2$ against $6$, and with it the whole value.
- **Object ruled out by $0 < t$, where the conclusion is false.** At $t < 0$ with $t^2\lVert W\rVert^2 = 1$ the Pcubic value is $t(n-1) < 0$, while the right-hand side is `Real.sqrt` of a positive quantity, hence $\ge 0$. **So the sign clause is load-bearing, exactly as the IsSphereProduct docstring records after the same defect was found in `IsSphereProduct` itself.**
- **The norm clause is a restriction and not a decoration.** For each $S$ it pins $t = 1/\lVert\operatorname{diagOp}(\operatorname{sphereWeight}S)\rVert$ uniquely among positives, so the inner $\forall t$ ranges over a single point. It is inhabited: [sphereWeight_normSq_pos](../lean/HamiltonsCubic/Base/Families.lean#L404) gives $\lVert\cdot\rVert^2 > 0$ and exists_unit_sphereProduct produces the member.

**So neither Prop is empty and neither is a hypothesis that imports its own conclusion.**

## 5. The hypotheses of the new theorems

**Verdict: CONFIRMED with one correction.** Sufficiency is kernel-checked and is not in question. On necessity, four binders are shown necessary here by exhibited witnesses, one is shown **unnecessary**, and two are left explicitly undecided.

### (a) sharpQF_diagOp: $a\ne b$ is necessary

At $a = b$, $\varphi_{aa} = 0$ by [phi_self](../lean/HamiltonsCubic/Base/WeylReal.lean#L53), and $\operatorname{br}X\,0 = 0$, so the left side is $0$. The right side is $\sum_{d\ne a}w_{ad}^2$, which is positive at any $w$ with a nonzero off-diagonal entry in row $a$. **So the statement is false at $a = b$ and `hab` cannot be dropped.**

### (b) trCube_diagOp: hollowness necessary, symmetry UNNECESSARY

**This is the correction, and it is a claim about the statement.** Compute trCube at an arbitrary $w$, symmetric or not. From the definition, $(\operatorname{diagOp}w\,\varphi_{ij})_{ji} = w_{ji}$ and $(\operatorname{diagOp}w\,\varphi_{ij})_{ij} = -w_{ij}$, all other entries zero, so applying the operator again gives $w_{ji}^2$ and $-w_{ij}^2$ at the same two places. Hence at $i\ne j$

$$\langle (\operatorname{diagOp}w)^2\varphi_{ij},\ \operatorname{diagOp}w\,\varphi_{ij}\rangle_2 = \tfrac12\big(w_{ji}^3 + w_{ij}^3\big),$$

and at $i = j$ the term is $0$ because $\varphi_{ii} = 0$. Summing with innerOp's $\tfrac12$,

$$\operatorname{trCube}(\operatorname{diagOp}w) = \tfrac12\sum_{i\ne j}\tfrac12\big(w_{ji}^3 + w_{ij}^3\big) = \tfrac12\sum_{i\ne j}w_{ij}^3 \qquad\textbf{at every } w .$$

**Symmetry is nowhere in that derivation.** The stated right-hand side is $\tfrac12\sum_{a,b}w_{ab}^3$, which differs from the derived value by $\tfrac12\sum_a w_{aa}^3$, and hollowness kills exactly that. **So the theorem is true with `hh` alone, and `hw` is a superfluous binder.** Argued the opposite way: the proof does use `hw`, through [diagOp_phi](../lean/HamiltonsCubic/Base/Families.lean#L160), because it routes the computation through $\varphi_{ij}$ being an eigenvector, which needs symmetry. **That is a fact about the route and not about the claim**, and the display above reaches the same value without it. This is a mild overstatement rather than a defect: the record's locus is symmetric, so nothing downstream changes, and the file's own closing sentence (*symmetry in three [places]*) counts proof sites rather than statement content.

**Hollowness is necessary.** At $w = e_{00}$, symmetric and not hollow, the left side is $0$ (as in item 4) and the right side is $\tfrac12$.

### (c) sharpPair_diagOp: hollowness necessary, symmetry undecided here

**Hollowness is necessary**, on the same witness. At $w = e_{00}$, $\operatorname{diagOp}w$ annihilates every $\varphi_{ij}$ at $i\ne j$, so every summand of sharpPair is $\langle 0, \cdot\rangle_2 = 0$, while $\tfrac12\operatorname{tr}w^3 = \tfrac12$. It enters the derivation twice, which the file states correctly: it makes the index exclusion $d\notin\{i,j\}$ free, since the two dropped terms carry $w_{ii}$ and $w_{jj}$, and it disposes of the $i = j$ terms that $\operatorname{tr}w^3$ carries and $\varphi_{ii} = 0$ does not.

**Symmetry: I do not claim either way.** The structural reason given in the file is sound as far as it goes (at asymmetric $w$ the operator leaves $\Lambda^2$ and $\varphi_{ij}$ stops being an eigenvector), but that is a statement about the mechanism. I constructed two candidate separating witnesses by hand and **both failed to separate**: at $\iota = \mathrm{Fin}\,3$ with $w = e_{01}$ alone, sharpQF vanishes identically because the composite $\operatorname{br}\eta(W(\operatorname{br}\eta(W\varphi)))$ dies at the second application, matching a right-hand side that is also zero; and at $\iota = \mathrm{Fin}\,2$ with $w_{01} = 2$, $w_{10} = 1$, both sides of sharpPair_diagOp are $0$, and both sides of trCube_diagOp are $9/2$. The record cites [screen_I66_sharpQF_symmetry.py](../scripts/misc/screen_I66_sharpQF_symmetry.py) for disagreement at 72 of 72 asymmetric weights. **Under this programme's standing rule a screen is not evidence for a positive claim, so the necessity of `hw` in sharpQF_diagOp and in sharpPair_diagOp stands as unresolved here rather than confirmed.** It is the safe direction for the binder to err in, and dropping it would need a derivation rather than a screen.

### (d) sphereWeight_diagP: both $2\le p$ and $2\le q$ are necessary, and one witness does both

Take $\iota = \mathrm{Fin}\,3$ and $S = \{0\}$, so $p = 1$ and $q = 2$: only $2\le p$ fails. The weight is $w_{01} = w_{02} = -1$ across and $w_{12} = p/(q-1) = 1$ inside $S^{\mathsf c}$, hollow and symmetric. Then

$$\lVert\operatorname{diagOp}w\rVert^2 = \tfrac12\cdot 6 = 3,\qquad \sum_{a,b}w_{ab}^3 = 4(-1) + 2(1) = -2,\qquad \operatorname{tr}w^3 = 6,$$

the last from $w^2 = \begin{pmatrix}2&-1&-1\\-1&2&1\\-1&1&2\end{pmatrix}$ and $\operatorname{tr}w^3 = \sum_{a,b}(w^2)_{ab}w_{ba} = 6$. So $\operatorname{diagP}w = \tfrac12(-2 + 6) = 2$, against $(n-1)\lVert\operatorname{diagOp}w\rVert^2 = 2\cdot3 = 6$. **The identity fails, by a factor of three.**

The same matrix is $\operatorname{sphereWeight}\{1,2\}$ in $\mathrm{Fin}\,3$, where $p = 2$ and $q = 1$, so **the identical witness shows $2\le q$ necessary too.** The cause is visible: the file says the identity holds because the row sums give $(p-1)\alpha = q$ and $(q-1)\beta = p$, and at $p = 1$ the first equation has no solution, so [sphereWeight_rowSum](../lean/HamiltonsCubic/Base/Families.lean#L329) fails and the weight is not Ricci-flat. **Lean's division by zero returns $0$ rather than erroring, so without these binders the theorem would be a false statement about a well-typed object, which is the worst shape a `sorry` can sit under.**

## 6. sphereWeight and thetaSplit, at the record's scale

**Verdict: CONFIRMED, and the file's own comment about the scale is exact rather than approximate.**

[diagonal-half.md](../findings/diagonal-half.md) writes the balanced sphere product weight as $1/(p(p-1))$ inside the blocks and $-1/(pq)$ across. [sphereWeight](../lean/HamiltonsCubic/Base/Families.lean#L291) is $q/(p-1)$ inside $S$, $p/(q-1)$ inside $S^{\mathsf c}$, $-1$ across.

$$pq\cdot\frac{-1}{pq} = -1,\qquad pq\cdot\frac{1}{p(p-1)} = \frac{q}{p-1},\qquad pq\cdot\frac{1}{q(q-1)} = \frac{p}{q-1} .$$

**So the factor is exactly $pq$ on all three entry classes**, including the second in-block class the record prints only at $p = q$ (where $q/(p-1)$ and $p/(q-1)$ coincide at $p/(p-1)$, and the record's two forms coincide likewise). The file's claim that the unbalanced entries are *forced* by zero row sums once the cross entry is $-1$ is verified in item 1's block computation: a row inside $S$ sums to $(p-1)\alpha - q$, so $\alpha = q/(p-1)$ is the unique choice.

**thetaSplit is the record's $\theta_{p,q}$.** [thetaSplitSq](../lean/HamiltonsCubic/Base/Families.lean#L460) is $2(p+q-1)(p-1)(q-1)/((p+q-2)pq)$, and [problem.md:168](../findings/problem.md) carries $\theta(S^p\times S^q)^2 = 2(n-1)(p-1)(q-1)/((n-2)pq)$ from Nienhaus Proposition 2.25. **Identical.** Three further anchors agree: $\theta_{m,m}^2 = \theta_0(2m)^2$, which the layer proves as `thetaSplitSq_balanced`; $\Theta_{11}^2 = 40/27$, which is the square of Nienhaus's printed $P(W^{\mathrm{crit}}_{\mathrm{sym},11}) = 2\sqrt{30}/9$ and the layer's `ThetaSqOdd_eleven`; and $\theta_{5,7}^2 = 264/175$, the record's $9625 > 9504$ pair of facts, which the layer proves as two inequalities.

**The scale is inert for $\theta$ and it is not inert for $P$.** SphereProductValue quantifies over $t$ with the unit-norm clause, so the scale never reaches the conclusion. The one place the scale would matter is a statement of the form `IsSphereProduct R → Pcubic R = Θ`, which no file writes, and which would be false: [IsSphereProduct](../lean/HamiltonsCubic/Base/Families.lean#L394) is closed under positive scaling and $P$ is degree-$3$ homogeneous.

## 7. The L57 claim: is DiagCubicFormula the same statement as the $\operatorname{tr}W^3$ bridge?

**Verdict: REFUTED as stated. The implication runs one way, and what the record concludes from it survives anyway because the file proves both conjuncts separately.**

**Locate the bridge.** [problem.md](../findings/problem.md), under L57, *Two identities carry this result and neither is derived on file*, second bullet:

> $\operatorname{tr}W^3 = \tfrac12\langle M^{\circ2},M\rangle$ **and** $\langle W,W^\#\rangle = \tfrac12\langle M^2,M\rangle$, without these the three steps bound a matrix functional not shown to be $\langle Q(W),W\rangle$.

**That is a conjunction of two identities.** Written out, $\langle M^{\circ2},M\rangle = \sum_{a,b}M_{ab}^3$ and $\langle M^2,M\rangle = \operatorname{tr}M^3$, so the bridge is the pair

$$\text{(i)}\ \ \operatorname{trCube} = \tfrac12\textstyle\sum_{a,b}w_{ab}^3, \qquad \text{(ii)}\ \ \operatorname{sharpPair} = \tfrac12\operatorname{tr}w^3 .$$

**DiagCubicFormula is their SUM and nothing more**: $\mathrm{Pcubic} = \mathrm{trCube} + \mathrm{sharpPair} = \mathrm{diagP} = \tfrac12(\sum w^3 + \operatorname{tr}w^3)$.

**So (i) $\wedge$ (ii) $\Rightarrow$ DiagCubicFormula, and the converse fails.** A layer in which trCube exceeded $\tfrac12\sum w^3$ by any quantity $c(w)$ and sharpPair fell short of $\tfrac12\operatorname{tr}w^3$ by the same $c(w)$ would satisfy DiagCubicFormula at every weight and satisfy neither conjunct. **This is not an idle possibility in this file**: the two terms are exactly the pair the record's [fence post F11](../findings/second-order.md) says must be treated together, and the sharp term is where the layer's one known factor defect lived. A cancelling pair of errors is the shape a sum cannot see.

Three places carry the overstated wording, all in the same file: [SharpDiag.lean:11-13](../lean/HamiltonsCubic/Base/SharpDiag.lean#L11), [SharpDiag.lean:401-402](../lean/HamiltonsCubic/Base/SharpDiag.lean#L401), and [SharpDiag.lean:411-413](../lean/HamiltonsCubic/Base/SharpDiag.lean#L411).

**And the conclusion the record draws is nevertheless sound**, which is why this is a wording repair rather than a withdrawal. [SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean) proves (i) as [trCube_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L331) and (ii) as [sharpPair_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L372), each as a named theorem with its own statement, and derives DiagCubicFormula from the two by `ring`. **So L57's bridge is discharged by this file, in both conjuncts, at every weight in $\mathcal D_n$.** The accurate sentence is *proving DiagCubicFormula the way this file proves it discharges L57's bridge*, and the file's own closing section already says the right thing when it lists the two as separate facts *worth reading separately*.

**One scope check on the bridge, and it passes.** L57's $M$ is the sectional matrix at $\operatorname{tr}M^2 = 2$ and its $W$ is the operator on $\Lambda^2$. Both Lean identities are stated at unrestricted $w$ and are degree-$3$ homogeneous, so they hold at the record's normalisation as the special case $\lVert\operatorname{diagOp}w\rVert^2 = 1$. **No normalisation clause of L57 is left behind.**

### A stale sentence in the same file

[SharpDiag.lean:400-401](../lean/HamiltonsCubic/Base/SharpDiag.lean#L400) reads *seven results take it as a Lean hypothesis*. Eleven lines below, the file's own closing section reads *The tree's consumer count was ONE Lean binder, not seven*, and names it. I read the tree: `DiagCubicFormula` appears in six files under [lean/HamiltonsCubic/Results/](../lean/HamiltonsCubic/Results/) and **every occurrence is inside a docstring**, with no binder anywhere, [L96Statement.lean:503](../lean/HamiltonsCubic/Results/L96Statement.lean#L503) recording its own binder as discharged. **The body is right and the docstring above the theorem is stale**, which is the same prose-versus-binder confusion [plan-lean.md](../plan-lean.md) records against six of seven rows on 2026-09-18.

## Overall verdict

**PROVEN (hypotheses corrected).**

The definitions mean what the record means. Pcubic is the record's $P$ with all three constants tracked and anchored externally at Nienhaus Proposition 2.25, IsWeight is $\mathcal D_n$ clause for clause, diagP is the weighted-graph functional term for term, sphereWeight is the record's weight at exactly $pq$ times its scale, thetaSplit is $\theta_{p,q}$, and both Props are non-vacuous with exhibited exclusions. **No theorem on this chain is about the wrong object.**

Three items to carry:

1. **Drop the symmetry binder from [trCube_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L331)**, or leave it and record that it is superfluous. The closed form $\tfrac12\sum_{i\ne j}w_{ij}^3$ holds at every $w$.
2. **Replace *the same statement under another name*** at the three sites in [SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean) with the one-way form. L57's bridge implies DiagCubicFormula, the converse does not hold, and the file's two named theorems are what actually discharge the bridge.
3. **Repair [SharpDiag.lean:400](../lean/HamiltonsCubic/Base/SharpDiag.lean#L400)'s *seven results***, contradicted by the same file's body.

**And one debt named rather than found**: the necessity of symmetry in [sharpQF_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L181) and [sharpPair_diagOp](../lean/HamiltonsCubic/Base/SharpDiag.lean#L372) rests on a screen. What would settle it is a closed-form asymmetric witness, which two hand attempts here did not produce. The binder is in the safe direction, so nothing rests on it.
