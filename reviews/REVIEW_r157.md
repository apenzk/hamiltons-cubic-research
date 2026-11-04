# Gate 2, Reviewer 157

*Cold review of the shift repair of Cheng–Wang Lemma 3.2, as recorded in [nondegeneracy.md](../findings/nondegeneracy.md) and committed at a2b27c1. Derivation only; the one numerical call is a rational-arithmetic check of my own algebra and is named as such.*

| brief item | verdict |
|---|---|
| 1. is Lemma 3.2's proof pointwise algebra? | **CONFIRMED, without qualification**, no Bochner, no second Bianchi, no integration anywhere in L313–L360. The transfer is legitimate |
| 2. is the normalisation of $R_1$ consistent? | **CONFIRMED**, and it follows from irreducibility in one line. *r155's intermediate $\mathring R_1=-\mathrm{Id}$ is the wrong sign for the source's own (2.2); the record silently corrected it* |
| 3. is $\lvert S^jW\rvert$ untouched? | **CONFIRMED**, exactly, and degeneracy is a non-issue |
| 4. does the inequality have content? | **THE CLAIM'S HEADLINE IS FALSE.** $\theta(n)$ **cancels identically**. The boxed inequality is, for every admissible $s$ and every $c\ge0$ alike, exactly $\sum_j\mu_j\lvert S^jW\rvert^2\ge\frac{\mu_1+\mu_2}2\sum_j\lvert S^jW\rvert^2$ |
| 5. does r155's (3.7) defect propagate? | **The defect is REAL as written and costs NOTHING.** $\theta(n)$ is unchanged; the repair is a reordering, given below |

**Net on the 155/156 split: both are right, about different things, and the record picked the wrong half of each.** r155 is right that the shift is legitimate (item 1) and that the vacuity was an artefact of $s=0$. r156 is right that stripping the shift *"leaves nothing of Cheng–Wang beyond the split-off-the-bottom-two trick"*, and item 4 below makes that sentence **literal**: the shift leaves the split-off-the-bottom-two trick and *nothing else whatsoever*. The record adopted r155's conclusion including the clause r156 had already refuted.

---

## Item 1, the transfer is legitimate. Every step of Lemma 3.2 is pointwise algebra

I read the proof at [paper.txt](https://arxiv.org/abs/2508.11226) L313–L360 and enumerate every ingredient it consumes.

| step | ingredient | character |
|---|---|---|
| (3.4) | $\lambda_1\le\cdots\le\lambda_N$, $\lvert S^jW\rvert\le\lvert S^\alpha W\rvert$, regrouping | ordering of reals |
| (3.5) | the hypothesis $\lambda_1+\lambda_2\ge-2\theta\bar\lambda$; $\lvert S^jW\rvert^2\le\frac{8n-16}n\lvert W\rvert^2$ | pointwise quadratic form in $W$ |
| (3.6) | $\sum_j\lvert S^jW\rvert^2=\frac{4N-12}n\lvert W\rvert^2$; $n\ge6$ | pointwise quadratic form in $W$ |
| (3.7) | $\lambda_3\ge(\lambda_1+\lambda_2)/2$ | ordering of reals |
| (3.8) | Lemma 3.1 | contraction of the algebraic decomposition (2.4) |

**The two quoted identities are algebra by Schur, so no citation is even needed.** $S\mapsto\lvert SW\rvert^2$ is a quadratic form on $S^2_0$ at a point, so $\sum_j\lvert S^jW\rvert^2$ is its trace, basis-independent, an $O(n)$-invariant quadratic in $W$, hence a fixed multiple of $\lVert W\rVert^2$ because $\mathrm{Weyl}_n$ is $O(n)$-irreducible. The second is the top eigenvalue of that same form. Neither can be anything but pointwise.

**Lemma 3.1 is the Einstein decomposition contracted, and the record's own shift proves it.** (2.4) $R=W+\frac{\mathrm{Scal}}{2n(n-1)}g\owedge g$ is a pointwise algebraic statement about a curvature tensor with $\mathrm{Ric}=\frac{\mathrm{Scal}}ng$; (3.1) and (3.2) are contractions of it. The self-consistency check is available for free: substituting $\bar\lambda=s$ into (3.1)–(3.2) reproduces $\sum\lambda_j^2=\sum\mu_j^2+Ns^2$ **iff** $\tfrac32n(n-1)-(n-1)^2=N$, which is the identity $(n-1)(n+2)/2=N$. An identity that survives the shift for all $s$ cannot be carrying an analytic input.

**Where the analysis actually lives, and it is downstream.** $\langle\Delta R,R\rangle$, the Bochner term and the second Bianchi identity enter at Lemma 3.3 and Theorem 1.1, *after* 3.2 has been proved. Lemma 3.2 never sees them. **The brief's failure mode is not present**: the transfer to an algebraic curvature tensor is sound, and $R=W+sR_1$ has $\mathrm{Ric}=s(n-1)g$ at the point, which is everything the lemma consumes.

**One hidden hypothesis the lemma's statement does not carry.** (3.5) needs $\theta\bar\lambda\ge0$ to turn $\lvert S^\alpha W\rvert^2\le M_{\max}$ into a lower bound; with $\theta\ge0$ that is $\bar\lambda\ge0$. The shifted setting has $\bar\lambda=s>0$, so the claim is safe, but anyone reusing Lemma 3.2 at negative scalar curvature is outside its proof.

## Item 2, the normalisation is right, and irreducibility gives it in one line

$\mathring R_1$ commutes with the $O(n)$ action and $S^2_0$ is $O(n)$-irreducible, so $\mathring R_1$ is a **scalar**; the scalar is its own $\bar\lambda$, and (2.2) $\mathrm{Scal}=n(n-1)\bar\lambda$ with $\mathrm{Scal}(S^n(1))=n(n-1)$ fixes it at $+1$. So $\mathring R_1=\mathrm{Id}$, and $R_1=\tfrac12g\owedge g$ is the constant-curvature-one tensor. Feeding $\mathrm{Scal}(R)=sn(n-1)$ into (2.4) gives $R=W+\tfrac s2g\owedge g=W+sR_1$, **so the Weyl part of $W+sR_1$ is $W$ by construction, rather than by inspection**, and $\bar\lambda=s$ is forced by the same equation rather than assumed.

**Disagreement with r155, on a point the record fixed without saying so.** [REVIEW_r155.md](REVIEW_r155.md) L122 derives $\mathring R_1h=\delta\mathop{\mathrm{tr}}h-h=-h$ and writes $\mathring R_1=-\mathrm{Id}$, then compensates with $R_s=W-sR_1$. The sign is inconsistent with the source's own (2.2), it would give the round sphere $\bar\lambda=-1$ and negative scalar curvature. The composition lands in the same place, so nothing downstream is affected, but the record's version is the source-consistent one and the correction went unrecorded.

## Item 3, $\lvert S^jW\rvert$ is untouched, exactly, and degeneracy cannot bite

$\mathring R=\mathring W+s\,\mathrm{Id}$, so $E_\mu(\mathring W)$ and $E_{\mu+s}(\mathring R)$ are the **same subspace**, not merely spanned by matching vectors. Any orthonormal eigenbasis of one is an orthonormal eigenbasis of the other, for every multiplicity. The brief's worry is answered by looking at which quantities the proof consumes:

- $T:=\sum_j\lvert S^jW\rvert^2=\mathop{\mathrm{tr}}B$ and $\sum_j\mu_j\lvert S^jW\rvert^2=\mathop{\mathrm{tr}}(\mathring W\!\circ\!B)$, where $B$ is the self-adjoint operator on $S^2_0$ with $\langle BS,S'\rangle=\langle SW,S'W\rangle$, **both are basis-free**, so a degenerate eigenspace has nothing to choose;
- $\lvert S^\alpha W\rvert^2=\max_jB_{jj}$ *does* depend on the basis inside a degenerate eigenspace, but the proof uses it only through $\lvert S^\alpha W\rvert^2\le\frac{8n-16}n\lvert W\rvert^2$, which holds for **every** unit $S\in S^2_0$.

So the claim survives item 3 with room to spare. $\mathop{\mathrm{tr}}(\mathring W\circ B)$ is also the cleanest statement of question (a): see below.

## Item 5, r155's (3.7) defect is real, and it costs exactly nothing

**r155 is right about the step.** With $A=\sum_j\lvert S^jW\rvert^2-2\lvert S^\alpha W\rvert^2$, the paper proves $A\ge A_0:=\frac{2(n^2-7n+8)}n\lvert W\rvert^2\ge0$ and then asserts $A\lambda_3\ge-\theta\bar\lambda A_0$. For $\lambda_3<0$ (permitted, since the hypothesis only gives $\lambda_3\ge-\theta\bar\lambda$), multiplying a *lower* bound by a negative number reverses it. **As an isolated inequality (3.7) is false**, and r155's proposed patch (bound $A$ above by $\sum_j\lvert S^jW\rvert^2$) does cost a larger constant.

**But the patch is not needed, and $\theta(n)$ does not move.** The loss is an artefact of splitting $\lvert S^\alpha W\rvert^2$ across two terms and substituting it twice. Keep it in one place. Write $M=\lvert S^\alpha W\rvert^2$, $T=\sum_j\lvert S^jW\rvert^2$, $M_{\max}=\frac{8n-16}n\lvert W\rvert^2$. The last line of (3.4) is

$$\sum_j\lambda_j\lvert S^jW\rvert^2\ \ge\ g(M),\qquad g(M):=M(\lambda_1+\lambda_2-2\lambda_3)+\lambda_3T .$$

$\lambda_3\ge\lambda_2\ge\frac{\lambda_1+\lambda_2}2$ makes the coefficient $\lambda_1+\lambda_2-2\lambda_3\le0$, so **$g$ is non-increasing in $M$** and $g(M)\ge g(M_{\max})$. Now

$$g(M_{\max})=M_{\max}(\lambda_1+\lambda_2)+\lambda_3\,(T-2M_{\max})\ \ge\ -2\theta\bar\lambda M_{\max}-\theta\bar\lambda(T-2M_{\max})\ =\ -\theta\bar\lambda\,T,$$

where the middle step uses $\lambda_1+\lambda_2\ge-2\theta\bar\lambda$ against $M_{\max}\ge0$ and $\lambda_3\ge-\theta\bar\lambda$ against the **fixed** number $T-2M_{\max}\ge0$, which is (3.6) and is where $n\ge6$ is spent. The sign of $\lambda_3$ never enters. Substituting (3.8) into $-\theta\bar\lambda T=-\theta\bar\lambda\frac{4N-12}n\lvert W\rvert^2$ returns (3.3) **verbatim, with the published constants**.

**So: report the exposition defect, do not propagate it.** The record's plan text, *"repair (3.7) at $\lambda_3<0$"* listed as remaining work worth a point of margin, describes a task that is already done and is free. r155's *"anyone borrowing Lemma 3.2 must re-derive that constant"* is correct as advice and wrong as a prediction of cost.

---

## Item 4, THE FINDING'S HEADLINE IS FALSE: $\theta(n)$ cancels identically

*This is the reason to reject the regrade, and it is three lines of algebra on the record's own boxed inequality.*

The clean form of Lemma 3.2's conclusion, from the repair above, is $\sum_j\lambda_j\lvert S^jW\rvert^2\ge-\theta\bar\lambda\,T$, the $\sum\lambda_j^2$ and $\bar\lambda^3$ terms in (3.3) are (3.8) expanded, nothing more. Push the shift through **that**:

$$\sum_j\mu_j\lvert S^jW\rvert^2\ =\ \sum_j\lambda_j\lvert S^jW\rvert^2-sT\ \ge\ -sT-c\,s\,T\ =\ -(1+c)\,s\,T .$$

The same thing happens inside the record's boxed inequality, which is why it is worth stating as an identity rather than as a rearrangement. **The second term of the record's box is the first term times $c$:**

$$\frac{16(N-3)}{3n}\sum_j\mu_j^2\ =\ \frac{16(N-3)}{3n}\cdot\frac34\lvert W\rvert^2\ =\ \frac{4N-12}n\lvert W\rvert^2\ =\ \sum_j\lvert S^jW\rvert^2 ,$$

using $\sum_j\mu_j^2=\frac34\lvert W\rvert^2$, which is Lemma 3.1 at $\bar\lambda=0$ and is the record's own $\sum\lambda^2=\sum\mu^2+Ns^2$ read backwards. *Checked in exact rational arithmetic at $n=6,7,8,9,10,12$: the two sides agree as fractions, $34/3$, $96/7$, $16$, $164/9$, $102/5$, $74/3$. The check confirms the algebra above; the algebra is what settles it.*

**Hence the record's box reads, for every $s$ and every $c\ge0$, exactly**

$$\sum_j\mu_j\lvert S^jW\rvert^2\ \ge\ -(1+c)\,s\sum_j\lvert S^jW\rvert^2,$$

and at the smallest $s$ the hypothesis allows, $s=-\frac{\mu_1+\mu_2}{2(1+c)}$, the factor $(1+c)$ **cancels against the hypothesis** and the whole one-parameter family collapses to the single statement

$$\boxed{\ \sum_j\mu_j\lvert S^jW\rvert^2\ \ge\ \frac{\mu_1+\mu_2}2\sum_j\lvert S^jW\rvert^2\ }$$

**No $\theta(n)$. No $s$. No Cheng–Wang.** Larger $c$ buys a weaker hypothesis and a proportionally weaker conclusion, at an exchange rate of exactly one; the constant is a free parameter of Lemma 3.2 in the first place, and $c=0$ gives the same box.

**And the box has a two-line proof that never mentions the source.** With $m_j=\lvert S^jW\rvert^2\ge0$, $\sum_jm_j=T$, $\max_jm_j\le M_{\max}$ and $T\ge2M_{\max}$ for $n\ge6$, minimising the linear functional $\sum_j\mu_jm_j$ over that polytope puts mass $M_{\max}$ on each of $\mu_1,\mu_2$ and the rest at $\mu_3$:

$$\sum_j\mu_jm_j\ \ge\ M_{\max}(\mu_1+\mu_2)+\mu_3(T-2M_{\max})\ \ge\ \tfrac{\mu_1+\mu_2}2\big(2M_{\max}+T-2M_{\max}\big),$$

using $\mu_3\ge\frac{\mu_1+\mu_2}2$. That is the whole of the route. **Applying the same bound to $-W$ gives the other side**, $\sum_j\mu_j\lvert S^jW\rvert^2\le\frac{\mu_{N-1}+\mu_N}2T$, so what the route actually delivers is an elementary sandwich of one cubic invariant between the bottom-pair and top-pair averages of the second-kind spectrum.

### Consequences for the record, in order of severity

1. **"with its published constants" must come out of the headline, the plan line and the commit-message summary.** No constant of Cheng–Wang's survives, because none of them is present in the result. What survives is the split-off-the-bottom-two trick, which is what r156 said would survive.
2. **The celebrated $s^3$ cancellation is $\lvert W\rvert^2$ being $s$-independent.** It is the statement that shifting by $sR_1$ does not change the Weyl part, which the record asserts two clauses earlier as a *hypothesis* of the same paragraph. It is a consistency check, not a mechanism.
3. **$c=\theta(n)$ is inadmissible at $n=6$ and $n=7$, which is where the record computes.** Lemma 3.2 requires $\theta\ge0$ and $n\ge6$; $\theta(n)=\frac{2N-9n+6}{N+6n-3}$ is $-8/53$ at $n=6$ and $-1/22$ at $n=7$, turning positive only at $n=8$ ($1/20$). Cheng–Wang's Theorem 1.1 excludes $n=6,7$ for exactly this reason, and $\theta(4)=\frac12,\theta(5)=\frac23$ are unusable because Lemma 3.2's $n\ge6$ is spent in (3.6). **So the boxed inequality as written is not an instance of Lemma 3.2 at any $n$ below $8$**, moot, since the constant cancels, but the record states it unrestrictedly.

### Does it serve branch 1? Not in the direction branch 1 needs

[bispectral.md](../findings/bispectral.md) fixes branch 1 as $\theta\le\frac{n-1}n\mu$ with $\mu=-\mu_1(\mathring W)$, and already proves the companion cap $\mu\le\sqrt{2(n-2)/(n-1)}$. Branch 1 needs $\theta$ bounded **above** by the **bottom** of the second-kind spectrum. The collapsed box bounds a cubic **below** by the bottom pair; its $W\to-W$ image bounds it **above** by the **top** pair, which the record's cap does not control. Either way the constant is the fixed rational $\frac{4N-12}{2n}$ divided by whatever the identification produces, and branch 1 needs exactly $\frac{n-1}n$. **Nothing in the construction points at that number**, and r156's accounting (spectral constraints short by a factor of $59$ at $n=12$), prices bounds of exactly this shape.

---

## Questions

**(a) Yes, it is a cubic invariant, the fence is the right one, and the coefficients are not yet in hand.** $\sum_j\mu_j\lvert S^jW\rvert^2=\mathop{\mathrm{tr}}(\mathring W\circ B)$ with $\langle BS,S'\rangle=\langle SW,S'W\rangle$, manifestly $O(n)$-invariant, degree $1$ in $W$ from $\mathring W$ and degree $2$ from $B$, and **basis-free**, which is the form in which the identification should be attempted. The fence from [bounds.md](../findings/bounds.md) is right and the record states it slightly too strongly: the two span at every $n$, but the span has **rank one at $n=4,5$** (where $\langle W,W^\#\rangle=2\mathop{\mathrm{tr}}W^3$) and rank two only for $n\ge6$, [nondegeneracy.md](../findings/nondegeneracy.md) does carry the rank caveat, [plan.md](../plan.md) L179 drops it. **I do not supply $(\alpha,\beta)$**: it is a genuine contraction computation, not an inference from the material in front of me, and guessing it would be the failure the brief names. What I can say is that the record's inference from it (*"the identification turns the inequality into a bound on $\theta$ itself"*), **overstates**: the right-hand side is $\frac{\mu_1+\mu_2}2T$, and $\mu_1+\mu_2$ is spectral rather than polynomial, so the identification yields a bound of a cubic by a spectral quantity, which is a different object from a bound on $\theta$ and needs the branch-1 constant to fall out exactly.

**(b) One rediscovery, and it is of a claim the record itself had just made.** r156's sentence *"leaves nothing of Cheng–Wang beyond the split-off-the-bottom-two trick, which the record has already exercised with one eigenvalue"* is **exactly** what item 4 derives, and the commit overturned it. The collapsed box is not otherwise in the record verbatim, so this is a rediscovery of a *refutation*, which is the more expensive kind: the ground on which r156 was overturned ("the published constants survive") is the clause that is false.

**(c) The regrade to $3\times3\times1=9$ is NOT defensible; I recommend $2\times3\times1=6$.**

| factor | recorded | mine | reason |
|---|---|---|---|
| closes | $3$ | $2$ | the route now ends in an elementary sandwich by the *top*-pair average, which branch 1 does not control, and closing needs the constant to come out at exactly $\frac{n-1}n$ |
| attackable | $3$ | $3$ | **agree with r155 and with the record**, the $(\alpha,\beta)$ identification is a well-posed derivation with a definite answer, which is a real handle |
| margin | $1$ | $1$ | unchanged |

The stated *reason* for the regrade fails on both of its two legs: the published constants do not survive (they cancel), and the (3.7) repair that was counted as remaining work is free. **Whether 3a still sorts above 3b is now an open question rather than a settled one**, and it should be decided on the strength of the $(\alpha,\beta)$ identification alone.

---

## Recommended edits

1. [nondegeneracy.md](../findings/nondegeneracy.md), retitle the section (strike *"with its published constants"*), and replace the boxed inequality with its collapsed form $\sum_j\mu_j\lvert S^jW\rvert^2\ge\frac{\mu_1+\mu_2}2\sum_j\lvert S^jW\rvert^2$, recording that $\frac{16(N-3)}{3n}\sum\mu_j^2=\sum_j\lvert S^jW\rvert^2$ is why $\theta(n)$ cancels.
2. Record the two-line LP proof of the collapsed box as the actual content of the route, and the $W\to-W$ image as its other side.
3. Record that Lemma 3.2's proof is pointwise algebra **as a verified fact with the ingredient list**, since that part of the claim is right and is worth being able to cite; add its unstated hypothesis $\theta\bar\lambda\ge0$.
4. Record the (3.7) repair as **done and free** ($g(M)$ monotone in $M$, substitute $M_{\max}$ once) and strike the remaining-work note in [plan.md](../plan.md) L179.
5. Record that $\theta(n)<0$ for $n=6,7$, so $c=\theta(n)$ is admissible only at $n\ge8$.
6. Regrade 3a to $2\times3\times1=6$ and reopen its ordering against 3b.
7. Note in [plan.md](../plan.md) L179 that the cubic span has rank one at $n=4,5$.

## What I did NOT settle

The identification of $(\alpha,\beta)$ for $\mathop{\mathrm{tr}}(\mathring W\circ B)$. It is the right next task and the record is right that it is a derivation; I did not attempt it, and the collapse above does not depend on it.
