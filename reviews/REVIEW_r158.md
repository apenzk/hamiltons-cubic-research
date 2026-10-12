# Review r158, the shift repair of Cheng–Wang Lemma 3.2

Derivation only. No script was run, no eigendecomposition computed, no machinery rebuilt. Two constants appear as arithmetic at $n=12$, both to size a defect I first prove symbolically. Every identity below is derived here from the definitions and then checked against the stored [paper.txt](https://arxiv.org/abs/2508.11226), never taken from it.

## Verdict

| brief item | statement audited | verdict |
|---|---|---|
| 1 | Lemma 3.2's proof is pointwise algebra, so it transfers to an algebraic curvature tensor | **CONFIRMED**, read at L313–L386; no Bochner term, no second Bianchi, no integration |
| 2 | $\mathring R_1=\mathrm{Id}$ on $S^2_0$, and $W+sR_1$ has Weyl part $W$ | **CONFIRMED**, three independent ways |
| 3 | $\lvert S^jW\rvert$ untouched, degenerate eigenspaces included | **CONFIRMED**, and the degeneracy worry is void, every quantity the lemma consumes is basis-independent |
| 4 | the shifted inequality carries content "with $c=\theta(n)$ the published constant" | **the shift is REAL; the constant is REFUTED.** $\theta$ cancels identically from the shifted statement. With r155's source repair applied it does not cancel, it makes the bound strictly **worse**, by $14\%$ at $n=12$ |
| 4 | "identifying the coefficients turns the inequality into a bound on $\theta$" (the named next task) | **UNSUPPORTED**, it silently assumes $\alpha=\beta<0$, and the fence post the plan invokes says the two cubics are independent at every $n\ge6$ |
| 5 | (3.7) multiplies a lower bound on $A$ by $\lambda_3$ | **CONFIRMED, r155 is right**, and it does **not** propagate into the one instance that carries content, because that instance sits at $\theta=0$ where $\lambda_3\ge0$ is forced |
| (c) | the regrade of 3a to $3\times3\times1=9$ | **NOT DEFENSIBLE on the stated reason.** The reason given is "the shift is verified; constants survive". The shift is verified; the constants do not survive as content, they cancel |

**On the 155/156 split.** Both are partly right and the commit's reading of the split is wrong. r155 is right that the shift is legitimate, that it removes the vacuity, and that (3.7) is defective. r155 is wrong that this leaves "the published $\theta(n)$ intact" in any load-bearing sense. r156 is right that what survives is "the split-off-the-bottom-two trick and nothing else", that is *literally* what the shifted inequality reduces to. The commit resolved the split in r155's favour on the one point where r156 was right.

---

## The one line the whole lemma collapses to

This is the finding everything else follows from, and it is visible inside the source itself, twenty lines apart.

**Identity 1.** For every Weyl tensor, $\sum_{j=1}^N\lvert S^jW\rvert^2=\dfrac{2(n^2+n-8)}n\lVert W\rVert^2=:\kappa(n)\lVert W\rVert^2$. I derived this independently before reading it in the paper, by resolving the identity of $S^2_0$ as $\sum_aE^a_{ij}E^a_{kl}=\tfrac12(\delta_{ik}\delta_{jl}+\delta_{il}\delta_{jk})-\tfrac1n\delta_{ij}\delta_{kl}$ and contracting the four-term derivation against itself: the four diagonal terms give $4\big[\tfrac{n+1}2-\tfrac1n\big]$, the four same-slot cross terms give $-4\big[\tfrac12+\tfrac1n\big]$ using $W_{ipkl}=-W_{pikl}$, and the eight cross-slot terms give $8\big[\tfrac14-\tfrac1n\big]$ using the first-Bianchi consequence $\sum W_{abcd}W_{adcb}=\tfrac12\lVert W\rVert^2$ and the vanishing of every Ricci contraction. Total $2n+2-\tfrac{16}n$. The paper quotes the same number from [9] (4.1) as $\tfrac{4N-12}n$; the two agree identically, so this is a check, not a borrowing.

**Identity 2.** $\sum_j\mu_j^2=\tfrac34\lVert W\rVert^2$ for a Weyl tensor, this is (3.8) of the source, and it is also what Lemma 3.1 forces, since $\sum\lambda_j^2-N\bar\lambda^2=\tfrac34\lVert R\rVert^2-(n-1)^2\bar\lambda^2-N\bar\lambda^2$ collapses to $\tfrac34\lVert W\rVert^2$ exactly when $N=(n+2)(n-1)/2$.

**Consequence.** $\dfrac{16(N-3)}{3n}=\dfrac{8(n^2+n-8)}{3n}=\dfrac43\kappa$, so

$$\frac{16(N-3)}{3n}\Big[\sum_j\lambda_j^2-N\bar\lambda^2\Big]=\tfrac43\kappa\cdot\tfrac34\lVert W\rVert^2=\kappa\lVert W\rVert^2=\sum_j\lvert S^jW\rvert^2.$$

**So Lemma 3.2 is, verbatim and with no shift at all,**

$$\boxed{\ \sum_{j=1}^N\lambda_j\lvert S^jW\rvert^2\ \ge\ -\theta\bar\lambda\sum_{j=1}^N\lvert S^jW\rvert^2\ }$$

and the published constants $\tfrac{16(N-3)}{3n}$, $\tfrac{16N(N-3)}{3n}$ are artefacts of expanding $\sum_j\lvert S^jW\rvert^2$ through two identities. The proof confirms it directly: (3.5) contributes $-2\theta\bar\lambda\tfrac{8n-16}n\lVert W\rVert^2$ and (3.7) contributes $-\theta\bar\lambda\tfrac{2(n^2-7n+8)}n\lVert W\rVert^2$, and $\tfrac{16n-32}n+\tfrac{2n^2-14n+16}n=\tfrac{2n^2+2n-16}n=\kappa$ **on the nose**.

*The record transcribed both identities into its own reference folder and then wrote the shifted inequality in the unsimplified form, which is why the cancellation below was not seen.*

---

## Item 1, the transfer is legitimate. CONFIRMED

The proof at L330–L386 consumes exactly five things: the eigenvalue ordering $\lambda_1\le\lambda_2\le\lambda_3$; the cone hypothesis $\lambda_1+\lambda_2\ge-2\theta\bar\lambda$; the elementary $\lambda_3\ge(\lambda_1+\lambda_2)/2$; the two algebraic identities of [9] quoted above; and (3.8), which is Lemma 3.1 rearranged. Lemma 3.1 is itself the pointwise Einstein decomposition $\lVert R\rVert^2=\lVert W\rVert^2+\tfrac2{n(n-1)}\mathrm{Scal}^2$ together with $\mathrm{Scal}=n(n-1)\bar\lambda$ (eq. 2.2). **No Bochner formula, no second Bianchi identity, no integration by parts, no closedness, no completeness.** Every input is a pointwise statement about an algebraic curvature tensor with $\mathrm{Ric}$ a multiple of $g$. $W+sR_1$ is such a tensor. **The transfer is sound and the claim's justification for it is the right one.**

## Item 2, the normalisation. CONFIRMED, three ways

1. **Directly.** Constant curvature $1$ has $\mathring R=+\mathrm{Id}$ on $S^2_0$; the record's own [target.md](../findings/target.md) fixes the $iklj$ index order by exactly this requirement, so it is the same convention.
2. **Through Lemma 3.1.** For constant curvature $1$, $\lVert R\rVert^2=2n(n-1)$ and $W=0$, so (3.2) gives $\sum\lambda_j^2=\tfrac32n(n-1)-(n-1)^2=\tfrac{(n-1)(n+2)}2=N$, while $\bar\lambda=\mathrm{Scal}/(n(n-1))=1$ gives $\sum\lambda_j=N$. Both are consistent with $\mathring R_1=\mathrm{Id}$ **and with nothing else**, since $\sum\lambda_j^2=N=\sum\lambda_j$ with $N$ eigenvalues forces all $\lambda_j=1$.
3. **Cross-convention.** The record's identity $\lVert\mathring W\rVert_F^2=3\lVert W\rVert^2_{\Lambda^2}$ in [target.md](../findings/target.md) and my $\sum\mu_j^2=\tfrac34\lVert W\rVert^2_{\text{tensor}}$ agree, because $\lVert W\rVert^2_{\text{tensor}}=4\lVert W\rVert^2_{\Lambda^2}$. Two conventions, two sources, one number.

$R_1$ has zero Weyl part, so $\mathrm{Weyl}(W+sR_1)=W$. $\mathrm{tr}\,\mathring W=N\bar\lambda(W)=\tfrac{\mathrm{Scal}(W)}{n-1}=0$. Both asserted steps hold. *r155 writes $\mathring R_1=-\mathrm{Id}$ with $R_s=W-sR_1$ and a different index convention for $R_1$; the two versions agree on the only thing that matters, $\mathring R_s=\mathring W+s\,\mathrm{Id}$.*

## Item 3, $\lvert S^jW\rvert$ untouched. CONFIRMED, and the degeneracy question is void

$\mathring R=\mathring W+s\,\mathrm{Id}$ has the **same eigenspaces** as $\mathring W$ for every $s$, so on a degenerate eigenspace the shift changes nothing about which choices of orthonormal eigenbasis are available, the ambiguity is identical before and after, so no choice can be broken by the shift. That the ambiguity is harmless is a separate point, and it holds: every quantity Lemma 3.2 consumes is invariant under it. $\sum_j\lambda_j\lvert S^jW\rvert^2=\mathrm{tr}(\mathring R\circ B)$ with $B(S,T)=\langle D_SW,D_TW\rangle$, a trace and hence basis-free; $\sum_j\lvert S^jW\rvert^2=\mathrm{tr}\,B$, likewise; the sorted $\lambda_j$ are basis-free; and $\lvert S^\alpha W\rvert^2\le\tfrac{8n-16}n\lVert W\rVert^2$ is a bound for **every** unit $S\in S^2_0$, so it survives any choice. **Nothing in the lemma sees the ambiguity.**

---

## Item 4, the shift is real, the published constant is decoration, and with the source repaired it is a liability

### The algebra of the claim, checked

$\lambda_j=\mu_j+s$, $\bar\lambda=s$, $\sum\lambda_j^2=\sum\mu_j^2+Ns^2$ (cross term dies on $\sum\mu_j=0$), and $-\tfrac{16(N-3)}{3n}cs\cdot Ns^2+\tfrac{16N(N-3)}{3n}cs^3=0$. **The $s^3$ cancellation is real, the hypothesis really becomes $\mu_1+\mu_2\ge-2s(1+c)$, and the stated inequality follows.** Every line of the claim's arithmetic is correct.

### What it actually says, once the two identities are used

Substituting Identity 1 and Identity 2 into the claim's own display,

$$\sum_j\mu_j\lvert S^jW\rvert^2\ \ge\ -s\,T-\tfrac{16(N-3)}{3n}\,c\,s\sum_j\mu_j^2\ =\ -s\,T-c\,s\,T\ =\ -(1+c)\,s\,T,\qquad T:=\sum_j\lvert S^jW\rvert^2.$$

The hypothesis is $\mu_1+\mu_2\ge-2(1+c)s$. **Both sides depend on $(c,s)$ only through the single product $u:=(1+c)s$.** So the entire two-parameter family of shifted statements is the one-parameter family

$$\mu_1+\mu_2\ge-2u\ \Longrightarrow\ \sum_j\mu_j\lvert S^jW\rvert^2\ \ge\ -u\,T,$$

whose strongest instance is $u=-\tfrac{\mu_1+\mu_2}2$, i.e. the minimal admissible $s$ the brief asks about:

$$\boxed{\ \sum_{j=1}^N\mu_j\lvert S^jW\rvert^2\ \ge\ \frac{\mu_1+\mu_2}2\sum_{j=1}^N\lvert S^jW\rvert^2\ }\tag{$\star$}$$

**$c$ has cancelled.** $(\star)$ is constant-free. It is exactly what the $c=0$ instance gives (that is, what plain two-nonnegativity of the shifted operator gives) and every $c>0$, $\theta(n)$ included, delivers **the identical statement, not a stronger one**. The claim's headline "with $c=\theta(n)$ **the published constant**" is true and empty: the published constant is carried along and then divides out.

### With r155's repair, $\theta>0$ is strictly worse than $\theta=0$

r155's defect is real (item 5 below). Repairing (3.7) with the correct upper bound $A=\sum_j\lvert S^jW\rvert^2-2\lvert S^\alpha W\rvert^2\le T$ replaces the $\tfrac{2(n^2-7n+8)}n$ in that step by $\kappa$, so the repaired lemma reads $\sum\lambda_j t_j\ge-\theta\bar\lambda(\kappa+\delta)\lVert W\rVert^2$ with $\delta:=\tfrac{16n-32}n$. Shifting and minimising $s$ over the same hypothesis now gives

$$\sum_j\mu_j\lvert S^jW\rvert^2\ \ge\ \frac{\mu_1+\mu_2}2\Big[1+\frac{c}{1+c}\cdot\frac\delta\kappa\Big]T,\qquad \frac\delta\kappa=\frac{8n-16}{n^2+n-8}.$$

The bracket exceeds $1$ for every $c>0$ and $\mu_1+\mu_2<0$, so **the bound degrades monotonically in $c$**. *Two arithmetic evaluations, used only to size the degradation, because a symbolic statement that a factor exceeds one does not say by how much:* at $n=12$, $\theta(12)=52/146=0.3562$ and $\delta/\kappa=80/148=0.5405$, so the bracket is $1.142$, the $\theta(n)$ instance is $14\%$ weaker than the $\theta=0$ instance. **On the corrected source the published constant is not decoration but a penalty, and the optimal choice is to discard it.**

### Is $(\star)$ better than what is already available?

Three comparisons, and the answer is "yes, but modestly, and not in a way that has been shown to reach the target".

- **Against the trivial bound** $\sum\mu_jt_j\ge\mu_1T$: $(\star)$ is stronger by exactly $\tfrac{\mu_2-\mu_1}2T\ge0$, and equal when the bottom eigenvalue is degenerate. **Genuine content, not vacuity**, it is *false* that the weighted mean always exceeds the arithmetic mean of the two smallest eigenvalues, since all the weight could sit on the bottom eigenvector; the lemma rules that out via $\lvert S^jW\rvert^2/T\le\tfrac{8n-16}{2(n^2+n-8)}\sim4/n$, so no single weight carries more than about $4/n$ of the total. That flatness is the whole mechanism and it is a real fact.
- **A free upgrade the claim and both prior reviews missed.** $\mathrm{Weyl}_n$ is closed under $W\mapsto-W$, which negates $\mathring W$ and leaves every $\lvert S^jW\rvert$ fixed; and $\mu_{N-1}+\mu_N>0$ always, by the same argument r155 and r156 used at the bottom. Applying $(\star)$ to $-W$ therefore gives the **upper** bound for free:
  $$\frac{\mu_1+\mu_2}2\,T\ \le\ \sum_j\mu_j\lvert S^jW\rvert^2\ \le\ \frac{\mu_{N-1}+\mu_N}2\,T.$$
  The upper half is the side that could ever bound $\theta$ from above; the record has neither half.
- **Against the record's existing spectral control.** [target.md](../findings/target.md) already carries $\sum_a\nu_a=0$, $\sum_a\nu_a^2=3$ at unit norm and reads branch 1 as a statement about "how much of the second-kind mass sits at the bottom". $(\star)$ is not comparable to that (it constrains a different functional) so it is not weaker than something on record. **It is not a curiosity in the brief's sense.** What it is not is a route to $\theta$, for the reason below.

### The named next task rests on an unstated assumption

The plan says: $\sum_j\mu_j\lvert S^jW\rvert^2$ is a cubic $O(n)$-invariant, the fence says $\operatorname{tr}(W^3)$ and $\langle W^\#,W\rangle$ span, so identifying $(\alpha,\beta)$ "turns the inequality into a bound on $\theta$". **The first two clauses are right and the third does not follow.** At a critical point with $\lVert W\rVert=1$, $\theta=\operatorname{tr}(W^3)+\langle W^\#,W\rangle$, the functional $(1,1)$ on the two-dimensional cubic space. $(\star)$ constrains the functional $(\alpha,\beta)$. A bound on $\theta$ follows **only if $(\alpha,\beta)\propto(1,1)$**, and [fence-posts.md](../findings/fence-posts.md) post F2g says precisely that the two contractions are **independent at every $n\ge6$**, the collapse $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ holds at $n\le5$ **and only there**. So $\alpha=\beta$ is a coincidence that has to be checked, not a consequence, and at $n\ge6$ there is no syzygy to supply it. **Before that computation is worth running, someone should say what happens if $\alpha\ne\beta$, because generically the answer is "nothing".**

And even in the lucky case $\alpha=\beta<0$, what the mirror bound delivers is $\theta\le\tfrac\kappa{2\alpha}(\mu_{N-1}+\mu_N)$, a bound on the cubic in terms of the **top** of the second-kind spectrum, trading one unproved obligation for another of the same shape. The one-line bound $\sum\mu_jt_j\le\mu_NT$ gives the same statement with $\mu_N$ in place of $(\mu_{N-1}+\mu_N)/2$, so the whole Cheng–Wang apparatus buys the factor $(\mu_{N-1}+\mu_N)/(2\mu_N)\in(0,1]$ and nothing else. **That factor is the entire yield of the route.**

*Disagreement stated explicitly:* I do not accept "with $c=\theta(n)$ **the published constant**" in [nondegeneracy.md](../findings/nondegeneracy.md) or "the published $\theta(n)$ survives" in [plan.md](../plan.md). The constant cancels on the uncorrected source and hurts on the corrected one.

---

## Item 5, (3.7). r155 is right, and the defect is harmless where it matters

**The defect is real.** The paper writes $\sum_j\lvert S^jW\rvert^2-2\lvert S^\alpha W\rvert^2=:A$, proves the **lower** bound $A\ge\tfrac{2(n^2-7n+8)}n\lVert W\rVert^2\ge0$ in (3.6), then asserts $A\lambda_3\ge-\theta\bar\lambda\tfrac{2(n^2-7n+8)}n\lVert W\rVert^2$. If $\lambda_3\ge0$ the conclusion is immediate from $A\ge0$ and needs no size bound at all. If $\lambda_3<0$ then $A\lambda_3=-A\lvert\lambda_3\rvert\ge-A_{\max}\lvert\lambda_3\rvert$ requires an **upper** bound on $A$, and (3.6) supplies the opposite one. The chain "thanks to (3.6), $\lambda_3\ge(\lambda_1+\lambda_2)/2$, and the curvature condition" is exactly where the sign is lost. **CONFIRMED.**

**It is reachable under the hypothesis.** $\lambda_3\ge\lambda_2\ge\tfrac{\lambda_1+\lambda_2}2\ge-\theta\bar\lambda$ permits $\lambda_3\in[-\theta\bar\lambda,0)$ whenever $\theta>0$; take $\lambda_1=\lambda_2=\lambda_3=-a$ with $0<a\le\theta\bar\lambda$. So the gap is not empty.

**It does not propagate into the content-carrying instance, and the reason is structural.** $(\star)$ is attained at $c=0$, where the shifted hypothesis is $\lambda_1+\lambda_2\ge0$; with $\lambda_1\le\lambda_2$ that forces $\lambda_2\ge0$ and hence $\lambda_3\ge0$, which is precisely the case (3.7) handles correctly. **The defect bites exactly on the $\theta>0$ instances, and those are exactly the instances that turned out to carry no extra strength.** So the answer to the brief's question (does it change $\theta(n)$ in the shifted form), is: it changes $\theta(n)$ in the source, and the shifted form does not depend on $\theta(n)$, so nothing downstream moves. *Anyone quoting the unshifted Lemma 3.2 or Theorem 1.1 still has to re-derive $\theta(n)$; the repair costs the factor $1+\delta/\kappa$ in the constant.*

---

## Answers

### (a) Is it a cubic invariant, is the fence right, what are the coefficients?

**Yes**, $\mu_j$ is degree one in $W$ and $\lvert S^jW\rvert^2$ degree two, and $\sum_j\mu_j\lvert S^jW\rvert^2=\mathrm{tr}(\mathring W\circ B)$ is manifestly $O(n)$-equivariantly constructed, hence a cubic $O(n)$-invariant on $\mathrm{Weyl}_n$. **The fence is the right one to invoke and it is invoked wrongly.** [fence-posts.md](../findings/fence-posts.md) post F2g fences off *searching for a linear identity among the invariants at $n\ge6$* and says in terms "it fences off nothing about inequalities", but the plan uses it to conclude that pinning $(\alpha,\beta)$ *yields* a bound on $\theta$, which needs $(\alpha,\beta)\propto(1,1)$, i.e. needs exactly the linear relation the same post says does not exist at $n\ge6$. **I did not compute $(\alpha,\beta)$**, it is a full contraction of three Weyl tensors against two copies of the $S^2_0$ projector, sixteen terms, and it is the plan's next task rather than this review's. What I can say is that it is well-posed, that it is a derivation and not a search, and that **it should be preceded by one sentence saying what is claimed if $\alpha\ne\beta$**, because on the fence post's own reading that is the generic case.

### (b) Asserted as new, already held

The failure mode here is the mirror image of the usual one: rather than rediscovering something the record holds, the commit **failed to use two identities it had already transcribed**, sitting twenty lines apart in its own stored source.

| item | where it already was |
|---|---|
| $\sum_j\lvert S^jW\rvert^2=\tfrac{4N-12}n\lVert W\rVert^2$ | [paper.txt](https://arxiv.org/abs/2508.11226) L360, quoted from [9] (4.1); also quoted verbatim in [REVIEW_r155.md](REVIEW_r155.md) |
| $\sum_j\mu_j^2=\tfrac34\lVert W\rVert^2$ | [paper.txt](https://arxiv.org/abs/2508.11226) eq. (3.8) |
| $\lVert\mathring W\rVert_F^2=3\lVert W\rVert^2_{\Lambda^2}$, the same statement in the record's own convention | [target.md](../findings/target.md) |
| $\mathring R=\mathrm{Id}$ on $S^2_0$ for the round sphere, fixing the index order | [target.md](../findings/target.md) |
| $\operatorname{tr}\mathring W=0$ | [paper.txt](https://arxiv.org/abs/2508.11226) eq. (2.2); already flagged as a rediscovery by [REVIEW_r156.md](REVIEW_r156.md) |

Applying the first two collapses the boxed inequality to $(\star)$ in one substitution and makes the cancellation of $c$ visible on inspection. **The commit wrote the result in the one form in which its own emptiness is invisible.** That is a sharper instance of the same hazard the record names elsewhere: a formula quoted in raw form and never simplified is a formula nobody has read.

### (c) Is the regrade of 3a to $3\times3\times1=9$ defensible?

**No, on the reason given.** The attackable factor was raised from $2$ to $3$ on "the shift is verified; constants survive". The shift is verified, that half is earned, and it is a real advance over the vacuous unshifted lemma. The constants do not survive: they cancel, and on the corrected source they are a penalty. So the stated ground for the raise is false.

**What the item is actually worth.** There is now a concrete, constant-free inequality in hand, plus its free mirror, plus a single named derivation ($\alpha,\beta$) that is genuinely attackable. Against that: the derivation's payoff is conditional on $\alpha=\beta$, which the record's own fence post makes generically false, and even granting it the yield is a bound on $\theta$ by the top of the second-kind spectrum, a fresh obligation of the same difficulty. **Attackable $2$, so $3\times2\times1=6$**, which restores the tie with 3b rather than settling it. r156's proposed $3$ is too harsh, it was written before the shift was carried out, and the shift genuinely moved the item off vacuity.

**And the tie-break should not be decided on "constants survive".** On the corrected findings the honest tie-break input is: 3a's remaining obligation is one finite contraction whose payoff is conditional; 3b's is a bound over a set the project cannot describe. Those are different kinds of risk and neither dominates.

---

## What I would change in the record

1. In [nondegeneracy.md](../findings/nondegeneracy.md), replace the boxed shifted inequality with $(\star)$ and state plainly that $c$ cancels, showing the substitution $\tfrac{16(N-3)}{3n}\sum\mu_j^2=\sum_j\lvert S^jW\rvert^2$.
2. Record Lemma 3.2 in its collapsed form $\sum_j\lambda_j\lvert S^jW\rvert^2\ge-\theta\bar\lambda\sum_j\lvert S^jW\rvert^2$, it is the same theorem and it is readable.
3. Add the mirror bound $\sum_j\mu_j\lvert S^jW\rvert^2\le\tfrac{\mu_{N-1}+\mu_N}2\sum_j\lvert S^jW\rvert^2$, from $W\mapsto-W$. It is free and it is the side that points at the target.
4. Delete "with $c=\theta(n)$ **the published constant**" and "the published $\theta(n)$ survives" from [nondegeneracy.md](../findings/nondegeneracy.md) and [plan.md](../plan.md); replace with the statement that the optimal instance sits at $\theta=0$.
5. Record that r155's (3.7) defect is confirmed, that the repaired constant is $\kappa+\tfrac{16n-32}n$ in place of $\kappa$, and that the defect does not reach $(\star)$ because $\theta=0$ forces $\lambda_3\ge0$.
6. Restate the next task as: compute $(\alpha,\beta)$, **and say in advance what is claimed when $\alpha\ne\beta$**, citing post F2g of [fence-posts.md](../findings/fence-posts.md), which makes $\alpha\ne\beta$ the generic case at $n\ge6$.
7. Regrade 3a to $3\times2\times1=6$ and restore the tie with 3b, with the tie-break decided on the shape of the remaining obligations rather than on surviving constants.

*Reviewer r158. Log at [gate2_158.log](../agent_logs/gate2_158.log).*
