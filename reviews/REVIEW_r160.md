# Review r160, the closure of route 3a

Derivation, with one arithmetic step used to refute the claim. I did not rebuild the record's machinery: no $S^2_0$ basis, no $(0,4)$ reconstruction, no derivation action, no eigendecomposition. What I did instead was derive $\mathop{\mathrm{tr}}(W^3)$ and $\langle W^\#,W\rangle$ in closed form at the three sphere products from the vertex matrix, and then read the record's own three $C$ values against them. *Numerics could not be avoided here for one reason and I state it: the coefficients $(\alpha,\beta)$ of $C$ are the one thing no derivation in this review can produce, and the record's three reported numbers are the only evidence about them in existence.*

## Verdict

| brief item | statement audited | verdict |
|---|---|---|
| 1 | the implementation behind the three $C$ values | **VALIDATED** by an overdetermined fit it never had to pass, 3 points, 2 unknowns, agreement to $6$ digits, integer coefficients. One free control was still skipped |
| 1 | "the three-ratio conclusion survives every normalisation error" | **CONFIRMED, and for a stronger reason than the claim gives**, $C$ and $\theta$ are both cubic and odd, so every per-point rescaling *and* every sign flip cancels in the ratio |
| **2** | **"$C$ is not proportional to $\theta$, therefore the route is closed"** | **NON SEQUITUR, REFUTED.** The route survives the non-proportionality intact. What kills it is a budget, and the budget can only be computed from the coefficients the closure declared unnecessary |
| 3 | $\lvert S^jW\rvert$ matches Cheng–Wang Definition 2.1 | **CONFIRMED**, no factor discrepancy |
| 4 | the $W\mapsto-W$ upper bound | **CONFIRMED** |
| 4 | "the only side that can bound a supremum" | **TRUE BUT UNARGUED at the time it was written**, it needs $\beta>0$, which was unknown. It is $8$ |
| (b) | retirement of 3a to grade $0$ | **NOT DEFENSIBLE at $0$.** The route's best possible output is a *better* handle on $\theta$ than the record's own two-cubic split. Grade $2$ |

---

## The headline: the coefficients are $(-40,\,8)$, and they were computable from the record all along

The closure's own next task ("identify $(\alpha,\beta)$ in $C=\alpha\mathop{\mathrm{tr}}(W^3)+\beta\langle W^\#,W\rangle$"), was declared unnecessary *because* the route was closed. It is not unnecessary, and it needed nothing beyond what the closure commit already had in front of it.

**Step 1, the two cubics at $S^p\times S^q$, in closed form.** These points are coordinate-diagonal, so the record's vertex matrix applies ([problem.md](../findings/problem.md), item 9): $W(e_i\wedge e_j)=w_{ij}e_i\wedge e_j$ with $\Lambda$ hollow symmetric and $\Lambda\mathbf1=0$. Setting the cross-block entry to $-1$, row-sum-zero forces $A=\tfrac q{p-1}$ inside the $p$-block and $B=\tfrac p{q-1}$ inside the $q$-block. Then $\lVert W\rVert^2=\sum_{i<j}w_{ij}^2$, $\mathop{\mathrm{tr}}(W^3)=\sum_{i<j}w_{ij}^3$, and $\langle W^\#,W\rangle=\tfrac12\mathop{\mathrm{tr}}(\Lambda^3)$, where $\Lambda$'s spectrum is $-A$ with multiplicity $p-1$, $-B$ with multiplicity $q-1$, and the two eigenvalues of $\begin{psmallmatrix}(p-1)A&-q\\-p&(q-1)B\end{psmallmatrix}$.

**This reproduces all three of the record's $\theta$ values to every digit**, $1.2360331$, $1.2282392$, $1.2015615$, and it reproduces [fence post F1](../findings/fence-posts.md)'s identity $\mathop{\mathrm{tr}}(W^3)/\theta=\tfrac2{(n-1)(n-2)}$ at the balanced point exactly, as $r=1/55$ at $n=12$. So the conventions are the record's and the derivation is anchored.

**Step 2, the fit is affine and overdetermined.** Write $r:=\mathop{\mathrm{tr}}(W^3)/\theta$. Since $\theta=\mathop{\mathrm{tr}}(W^3)+\langle W^\#,W\rangle$ and $C=\alpha\mathop{\mathrm{tr}}(W^3)+\beta\langle W^\#,W\rangle$,

$$\frac C\theta=\beta+(\alpha-\beta)\,r .$$

The three points give exact rationals $r=\tfrac1{55},\ \tfrac{23}{660},\ \tfrac{109}{1155}$. **All three pairwise slopes come out at $-48.0000$** ($-47.999\,999\,9$, $-47.999\,96$, $-47.999\,95$, the spread is the rounding of the reported $C$ at six digits), and all three intercepts at $8.000\,00$.

$$\boxed{\ \alpha=-40,\qquad \beta=8\qquad\text{at }n=12\ }$$

Three data points, two unknowns, one degree of overdetermination, and the answer is a pair of integers.

**Step 3, the consequence, which is the whole review.** Eliminating $\langle W^\#,W\rangle$ rather than $\mathop{\mathrm{tr}}(W^3)$:

$$\boxed{\ \theta\ =\ \tfrac18\,C\ +\ 6\mathop{\mathrm{tr}}(W^3)\ }$$

Checked against the record's own numbers at all three points, relative agreement $5\times10^{-7}$ throughout. **So an upper bound on $C$ does bound $\theta$, as soon as $\mathop{\mathrm{tr}}(W^3)$ is bounded, which the record has done sharply since [problem.md](../findings/problem.md) item 5.**

---

## Item 2, the closure is a non sequitur. This is the finding

**What the evidence establishes.** Three distinct values of $C/\theta$ at one $n$ prove that $C$ is not a multiple of $\theta$, hence $(\alpha,\beta)\not\propto(1,1)$. That inference is sound and I do not dispute it.

**What the record then concluded.** "The bound controls the wrong invariant. The Cheng–Wang route to $\theta$ is closed." *That does not follow, and the gap is not subtle.*

**Why it does not follow.** $C$ is a cubic $O(n)$-invariant on $\mathrm{Weyl}_n$, a space that [fence post F2g](../findings/fence-posts.md) makes **two**-dimensional, spanned by $\mathop{\mathrm{tr}}(W^3)$ and $\langle W^\#,W\rangle$. Non-proportionality to $\theta$ therefore says only that $C$ has a component along the *second* basis direction. A route to $\theta$ dies from that only if the second direction is uncontrolled. **It is the most controlled object in this record.** $\mathop{\mathrm{tr}}(W^3)$ is a function of the $\Lambda^2$-spectrum alone; it obeys the Tachibana/Huisken cap $\lvert\mathop{\mathrm{tr}}(W^3)\rvert\le\tfrac{m-2}{\sqrt{m(m-1)}}\lVert W\rVert^3$ quoted in [problem.md](../findings/problem.md) item 2, and $\langle W^\#,W\rangle$ obeys the record's own sharp $\sqrt2\,\tfrac{n-3}{\sqrt{(n-1)(n-2)}}\lVert W\rVert^3$ from item 9. *Both leftover directions were already bounded, sharply, before the closure was written.*

So the general shape of the surviving route is: for any $(\alpha,\beta)$ with $\beta\ne0$, $\theta=\tfrac1\beta C+\tfrac{\beta-\alpha}\beta\mathop{\mathrm{tr}}(W^3)$, and an upper bound on $C$ plus a record-held bound on the leftover cubic bounds $\theta$. **The route survives the non-proportionality in exactly the modified form the brief anticipated.** The closure argument would be valid only in a cubic invariant space whose second direction nobody can bound, and this is not that space.

**And the fence post is invoked against its own text, for the second time.** [Post F2g](../findings/fence-posts.md) closes with "*It fences off nothing about inequalities*". The closure cites it to conclude that an inequality is dead. [Reviewer 158](REVIEW_r158.md) caught precisely this misuse one commit earlier ("the fence is the right one to invoke and it is invoked wrongly") and the closure commit repeats it in a stronger form. **This is a documented repeat, not a first offence.**

### What actually kills the route, and it needs the coefficients

With $\theta=\tfrac18C+6\mathop{\mathrm{tr}}(W^3)$, any bound the route can produce has the shape

$$\theta\ \le\ \tfrac18\overline C(W)\ +\ 6\,\bar a\,\lVert W\rVert^3,\qquad \overline C\ge C,\quad \bar a\ \ge\ \sup_{\mathrm{Weyl}_{12}}\mathop{\mathrm{tr}}(W^3)/\lVert W\rVert^3 .$$

Evaluate the two terms where the target must be sharp, at $S^6\times S^6$:

- $\tfrac18\overline C\ \ge\ \tfrac18C=1.101\,19$, already $89.1\%$ of $\theta_0(12)=1.236\,033$, and that is a floor over *every* $C$-bound, however sharp;
- $\bar a$ must dominate $\mathop{\mathrm{tr}}(W^3)/\lVert W\rVert^3$ over all of $\mathrm{Weyl}_{12}$, and $S^4\times S^8$ alone forces $\bar a\ge0.113\,394$, so $6\bar a\ge0.680\,36$.

Sum: **$\ge1.781\,55$ against a target of $1.236\,033$, an overshoot of at least $1.44\times$, unbeatable by any improvement to either bound.** *The route is dead. It is dead on a norm budget, at a factor that can be named, and not because it controls a different invariant.*

**And the margin is the interesting part.** [Fence post F2e](../findings/fence-posts.md) records that bounding $\mathop{\mathrm{tr}}(W^3)$ and $\langle W^\#,W\rangle$ separately and adding overshoots by $1.7$–$1.8\times$. The Cheng–Wang route in its modified form overshoots by $\ge1.44\times$. **It is a strictly better handle on $\theta$ than the best two-cubic split the record holds**, it gets $89\%$ of the way at the maximiser through a single joint bound, where the split leaks on both terms. That is what the closure threw away.

---

## Item 1, the implementation. Validated, by a test nobody ran

**The fit is the validation.** Three reported numbers, a two-dimensional target space: the fit had one degree of freedom to fail with and did not, at six digits, landing on $-40$ and $8$. **A pipeline that produced a non-Weyl input, an incomplete or non-orthonormal $S^2_0$ basis, or a non-symmetric operator whose "eigenvalues" are not a spectrum would not land in $\mathrm{span}\{\mathop{\mathrm{tr}}(W^3),\langle W^\#,W\rangle\}$ at all**, and the collinearity would break at the fourth digit or sooner. It does not.

**State the caveat plainly.** The fit tests that $C$ is *some* cubic $O(n)$-invariant of the correct Weyl tensor. It does not test *which*. An error that stays $O(n)$-equivariant (dropping one of the four slots in $(SW)_{ijkl}$, or a wrong weight on one of them), still yields a cubic invariant, still fits, and moves $(\alpha,\beta)$. So the fit clears the reconstruction and the basis; it does not clear the derivation action.

**The control that would clear it is free and was skipped.** [Reviewer 158](REVIEW_r158.md) derived, term by term from the four-slot action, that $\sum_j\lvert S^jW\rvert^2=\kappa(n)\lVert W\rVert^2_{\text{tensor}}$ with $\kappa=2(n^2+n-8)/n$, $24.667$ at $n=12$. **The implementation already computes every $\lvert S^jW\rvert^2$; summing them costs one line and pins the four-slot structure exactly.** It was not reported. This record's own text says "*Both controls failed on the first build and that is how both bugs were found*", and "*A grading test with no control passes silently in either convention*", that lesson was available in the same file, forty lines above the new paragraph.

**On the brief's normalisation question, the conclusion survives every normalisation error, and the reason is stronger than the brief's.** $C$ and $\theta$ are both homogeneous cubics in $W$, so any per-point rescaling $W\mapsto t_PW$ multiplies both by $t_P^3$ and **cancels exactly** in $C/\theta$, not "scales them equally", cancels. The same applies to the sign: both are odd, so $W\mapsto-W$ leaves $C/\theta$ fixed, which matters because *this very file* documents a sign-convention trap that destroyed a previous result ("the sign of $W$ is part of the definition of $S$"). What does **not** cancel is an error that changes the tensor rather than its scale, and the fit is what rules those out.

**One process failure, and it is a rule violation.** Commit `36ac4c6` touches two markdown files and **ships no script**. Every other numerical claim in this record is anchored to a named file in [scripts/](../scripts/). Three numbers that close a route are on record with no way for the next reviewer to reproduce them. *That the numbers turn out to be right does not repair the process; nothing in the record made them checkable, and it took an outside derivation of $\mathop{\mathrm{tr}}(W^3)$ to check them.*

**A falsifiable out-of-sample prediction, for whoever restores the script.** The identity $C=8\theta-48\mathop{\mathrm{tr}}(W^3)$ regenerates all three reported values to every printed digit. At the fourth $n=12$ sphere product, $S^3\times S^9$ with $\theta=1.141798$ and $r=107/440$, it predicts

$$C(S^3\times S^9)=-4.193\,51 .$$

**$C$ changes sign across the family.** Any implementation that reports a positive $C$ there is wrong, and (separately), a sign change would have been a far more forceful refutation of proportionality than three ratios.

---

## Item 3, Definition 2.1. CONFIRMED

The stored source at [paper.txt](https://arxiv.org/abs/2508.11226) L218–L225 defines, for $S\in S^2(V)$ and $T\in T^{(0,k)}(V)$,

$$(ST)(X_1,\dots,X_k)=\sum_{i=1}^kT(X_1,\dots,SX_i,\dots,X_k),$$

with no prefactor and no weighting across slots. At $k=4$ that is $(SW)_{ijkl}=S_i^aW_{ajkl}+S_j^aW_{iakl}+S_k^aW_{ijal}+S_l^aW_{ijka}$, the implementation's action, term for term. **No factor discrepancy.** L322 confirms that $S^jW$ in Lemma 3.2 is this operator applied with $S=S^j$ the $j$-th second-kind eigenvector.

## Item 4, the upper bound. CONFIRMED, and one claim about it was luck

**The bound is correct.** $\mathrm{Weyl}_n$ is closed under $W\mapsto-W$; $\mathring W\mapsto-\mathring W$ has the **same eigenvectors** with $\mu_j\mapsto-\mu_j$, so the sorted spectrum reverses and the two smallest eigenvalues of $-W$ are $-\mu_N\le-\mu_{N-1}$; and $\lvert S^j(-W)\rvert=\lvert S^jW\rvert$, so $T$ is fixed. Applying $(\star)$ to $-W$ gives $-C\ge-\tfrac{\mu_{N-1}+\mu_N}2T$, i.e. the stated bound. Its (3.7) status is inherited cleanly: the $c=0$ hypothesis $\lambda_1+\lambda_2\ge0$ forces $\lambda_3\ge0$ for $-W$ exactly as it does for $W$, which is the case the source handles correctly.

**"The only side that can bound a supremum" is true, and was not known to be.** It requires the coefficient of $C$ in $\theta$ to be positive. That coefficient is $1/\beta$, and **$\beta$'s sign was unknown when the sentence was written**, the whole point of the paragraph is that $(\alpha,\beta)$ had not been computed. Had $\beta$ come out negative, the *lower* bound would have been the useful side and the record's dismissal of it ("the lower bound controls a cubic from below, which is useless against a supremum") would have been backwards. $\beta=8>0$, so the sentence is right. *It is a correct claim reached without an argument, and the record should say which.*

---

## Answers

### (a) Asserted as new that the record already holds

| item | where it already was |
|---|---|
| $\mathop{\mathrm{tr}}(W^3)/\theta=\tfrac2{(n-1)(n-2)}$ at the balanced product, "proved as an identity rather than scanned" | [fence post F1](../findings/fence-posts.md), this is one of the three data points the closure needed, and it was on record |
| the vertex-matrix closed form for $\langle W^\#,W\rangle=\tfrac12\mathop{\mathrm{tr}}(\Lambda^3)$ at diagonal $W$ | [problem.md](../findings/problem.md) item 9, this supplies the other two |
| sharp caps on both leftover cubics | [problem.md](../findings/problem.md) items 2 and 9, [fence post F2e](../findings/fence-posts.md) |
| $\theta$ at all four $n=12$ sphere products, to $4\times10^{-16}$ | [ATTEMPTS.md](../ATTEMPTS.md) Result 3 |

**Nothing is claimed as new that the record holds, the failure is the mirror of r158's.** The closure had every ingredient of the $(\alpha,\beta)$ identification in its own files, computed three numbers, and then used them for the weakest inference they support. *Six rediscoveries would have been better than this: a rediscovery wastes a cycle, and this closed a route.*

### (b) Grade $0$, or lower-but-alive?

**Alive, at $2$. Grade $0$ is not defensible and neither is the reason attached to it.**

- **`closes` stays $2$.** Unchanged, and I agree with it.
- **`attackable` should be $1$, not $0$.** The stated ground for $0$ ("the bound controls a cubic that is not $\theta$"), is the non sequitur above and must come out of the table whatever the grade. What is genuinely left to attack is one thing and it is nameable: **$(\alpha,\beta)$ at general $n$.** The kill I give is at $n=12$ and rests on the leftover coefficient $1-\alpha/\beta=6$ against $\bar a\ge0.113$. Both are $n$-dependent, and $\mathop{\mathrm{tr}}(W^3)/\theta\to0$ like $2/n^2$ at the maximiser. If $1-\alpha(n)/\beta(n)$ decays, the budget reopens at large $n$, which is where the conjecture lives. *One number at one dimension is not a closure across all $n\ge12$, and nothing in the commit addresses $n>12$ at all.*
- **`margin` stays $1$.**

**Value $2$.** And the item should be reworded from "closed" to "dead at $n=12$ on a $1.44\times$ budget, with the $n$-dependence of $(\alpha,\beta)$ the one thing that could revive it".

*Stated as disagreement:* I do not accept the sentence "**The Cheng–Wang route to $\theta$ is closed**" in [nondegeneracy.md](../findings/nondegeneracy.md), nor "$0$ **closed**, the bound controls a cubic that is not $\theta$" in [plan.md](../plan.md). The premise is true, the inference is invalid, and the true reason is a different one that the closure did not compute.

### (c) Is 3b's grade defensible?

**I did not audit 3b and I say so rather than grade it.** What I can say bears on the comparison. With 3a at $2$ the two are no longer tied and 3b leads $6$ to $2$, so the ordering the plan acts on is unchanged and the tie-break [r158](REVIEW_r158.md) worried about does not need to be made. What has changed is the *content* of 3a's residue: the modified route delivers a $1.44\times$ overshoot where the record's best split gives $1.7$–$1.8\times$, so **the sharpest known upper bound on $\theta$ at $n=12$ now comes from the route just retired.** That belongs in the record whatever grade 3a carries, and it is a fact about the target that 3b's own estimate will be measured against.

---

## What I would change in the record

1. **Delete "The Cheng–Wang route to $\theta$ is closed"** from [nondegeneracy.md](../findings/nondegeneracy.md) and the `attackable` $=0$ reason from [plan.md](../plan.md). The inference is invalid.
2. **Record the coefficients**: $C=-40\mathop{\mathrm{tr}}(W^3)+8\langle W^\#,W\rangle$ at $n=12$, from the commit's own three numbers plus the vertex-matrix closed forms. The plan's named next task is done.
3. **Record the identity** $\theta=\tfrac18C+6\mathop{\mathrm{tr}}(W^3)$, which is what the route actually delivers.
4. **Replace the closure with the budget**: at $S^6\times S^6$ the $C$-term is already $89.1\%$ of $\theta_0(12)$, and $S^4\times S^8$ forces $6\bar a\ge0.680$, so the route's best output is $\ge1.7816$ against $1.2360$, dead at $n=12$ by $1.44\times$.
5. **Record that this beats the record's own two-cubic split** ($1.44\times$ against $1.7$–$1.8\times$, [fence post F2e](../findings/fence-posts.md)), because it is the sharpest handle on $\theta$ at $n=12$ the project holds.
6. **Restore a script**, and have it report $\sum_j\lvert S^jW\rvert^2$ against $\kappa(12)\lVert W\rVert^2_{\text{tensor}}=24.667\lVert W\rVert^2$ as a control. Add $C(S^3\times S^9)=-4.19351$ as an out-of-sample check; $C$ changes sign there.
7. **Regrade 3a to $2\times1\times1=2$** and name the surviving obligation: $(\alpha,\beta)$ at general $n$, since the kill is one dimension deep.
8. **Amend [fence post F2g](../findings/fence-posts.md)** with a standing note that it has now been misused twice in consecutive commits to close inequality routes, against its own closing sentence.

*Reviewer r160. Log at [gate2_160.log](../agent_logs/gate2_160.log).*
