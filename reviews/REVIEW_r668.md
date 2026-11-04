# Reviewer 668, Lemma L113, moment analysis of the $g$-distribution cannot leave the pinned class

**Review number: r668.** Reviewer B of an independent pair on identical briefs; r667 was not read. Target: [findings/bounds.md](../findings/bounds.md) line 307, [Lemma L113](../findings/bounds.md), and the contraction identity in the block below it. **Analysis only, no computation was run, and none is needed: every step below is algebra over the record's own definitions.** Log: [agent_logs/audit-L113-b.log](../agent_logs/audit-L113-b.log).

## Verdict

**GAP, the impossibility is real in a form the block does not state, its stated argument is a tautology, and its class is undelimited.**

The three defects are separable and should be recorded separately:

1. **The conclusion is true, and provable in four lines**, but by an argument the block does not give, and in a strictly stronger form than the block claims (§3).
2. **The stated argument proves only a tautology.** "Eliminating the free moment returns a conclusion in $(\lambda,\theta)$" is true because $(\lambda,\theta)$ are the only variables left. Under that reading the lemma forbids nothing: [Lemma L107](../findings/bounds.md)'s $\Pi$-bound is itself "a pinned conclusion", is live, and is what this same file calls *the conjecture's target restated spectrally* (§2).
3. **"The pinned class" carries two senses in this one file, and the lemma's title is in one while its argument is in the other** (§2.1). Neither sense is in [conventions.md](../findings/conventions.md), and neither is $g$ nor $G_2$.

Secondary: the block is **stale by three days** (§6), it is the weaker unnumbered ancestor of [plan.md](../plan.md)'s **I16** (§7), and as a numbered result it **carries no derivation under its own heading** (§8).

The contraction identity in the block below is **CONFIRMED**, constant included (§4), and it is **not** the same fact as [Lemma L112](../findings/bounds.md)'s "(A) and (B) contain no $\theta$" (§4.3).

## 1. Readings adopted, stated because [conventions.md](../findings/conventions.md) does not carry them

Every one of these is a reading I had to fix myself; the file tables none of them.

| symbol | reading adopted | why |
| --- | --- | --- |
| indices $a,b,c,k,\alpha,\beta$ | the $\Lambda^2$ eigenbasis of $W$, $N=\binom n2$ of them, $\lambda$ the $\Lambda^2$ spectrum with $\sum_a\lambda_a=0$ and $\sum_a\lambda_a^2=1$ | [conventions.md](../findings/conventions.md), rows $N$ and $M$ |
| $\sum_{\beta\gamma}$ in (A)/(B)/(C) | **ordered** pairs | [conventions.md](../findings/conventions.md), *"Sums over pairs are over ORDERED pairs unless the line says otherwise"* |
| $T_{abc}$ | $c_{abc}^2$, totally symmetric, hollow in the 3-tensor sense | [conventions.md](../findings/conventions.md), structure-constants bullet + the `hollow` row |
| $g_k$ | $\lVert[\mathrm{ad}(v_k),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$ | [bounds.md](../findings/bounds.md) line 349; **untabled** |
| $G_2$ | $\sum_k\lambda_k^2g_k=m_2$ | [bounds.md](../findings/bounds.md); **untabled** |
| $\theta$ | $P(W)/\lVert W\rVert^3$, evaluated at $\lVert W\rVert=1$ throughout | [conventions.md](../findings/conventions.md) |
| "pinned class" | **ambiguous, see §2.1.** I carry both senses explicitly and never let them merge | **untabled in both senses** |

The record's three per-index relations, quoted from [bounds.md](../findings/bounds.md) line 241:

$$\text{(A)}\ \sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2),\qquad\text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k,\qquad\text{(C)}\ \sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k).$$

**Consistency check I ran before trusting them.** Contract (B) with $\lambda_k$: $\sum_{abc}\lambda_a\lambda_bT_{abc}=-2\sum\lambda_k^2=-2$. Contract (C) with $1$: $\sum_{abc}\lambda_b\lambda_cT_{abc}=2\theta\sum\lambda_a-2\sum\lambda_a^2=-2$. Total symmetry makes these the same left side, and they agree. (B) and (C) are mutually consistent.

## 2. The class, and why as written the impossibility is unfalsifiable

The block's argument, in full, is one sentence: *"Positivity of $g$ and the support of its measure are consequences of the spectrum alone, so any pair of moment inequalities built from them, however the free moment enters, can only return a pinned conclusion once the free moment is eliminated."*

The variables in play are $\lambda$, $\theta$, and $m_2=G_2$. Eliminating $m_2$ leaves $\lambda$ and $\theta$ and nothing else. So the premise does no work: **the conclusion of the stated argument follows from counting variables**, whatever the inequalities are, whatever they are built from, and whether or not positivity and support are spectral. Any argument that eliminates its only free variable ends in its remaining variables.

That the reading is the vacuous one is confirmed by the block's own neighbourhood: the elimination two headings above, run on exactly this pair of inequalities, returns $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, **a "pinned conclusion"** in this sense, and simultaneously the record's tightest standing spectral bound, exact at every Einstein $S^p\times S^q$. So a lemma that says *moment analysis can only produce things of that shape* is describing a success, not an obstruction. **As stated, L113 forbids nothing and cannot be falsified by exhibiting a bound**, because every bound in $(\lambda,\theta)$ satisfies it.

### 2.1 The two senses of "pinned class", and the type error between them

The file uses the phrase in two incompatible ways, both live, both within sixty lines of L113:

| sense | what it is | where |
| --- | --- | --- |
| **census sense** | the *quantities* determined by $(\lambda,\theta)$, the contractions with two exponents $\le1$ | [bounds.md](../findings/bounds.md) line 257, *"the law is an identity, so it does not itself escape the pinned class"* |
| **relaxation sense** | the *feasible set* $\{T\ge0:\text{(A),(B),(C)}\}$ | [bounds.md](../findings/bounds.md) line 399, *"the pinned class does not close the conjecture"*; [plan.md](../plan.md) line 15 |

**A conclusion is an inequality, and an inequality is not a quantity.** So "moment analysis cannot leave the pinned class" is type-correct only in the relaxation sense, where it means *no $g$-moment argument is stronger than the (A)+(B)+(C)+$T\ge0$ relaxation*. That is a real and useful claim. But the block's argument ("positivity and support are spectrum-level, so the free moment eliminates"), is entirely in the census sense. **The title is in one sense and the proof is in the other**, and that mismatch is the whole of the defect.

### 2.2 What the class fails to delimit, itemised

- **"any *pair*"**, why two? A moment argument may chain three inequalities, or impose the full Hankel/Markov–Lukács moment cone on $[\lambda_{\min},\lambda_{\max}]$. The stated argument covers neither.
- **"*the* free moment", singular**, $m_3,m_4,\dots$ are free too. The block silently treats the problem as three-variable when it is infinite-dimensional.
- **the support fact used is the weak one.** $\mathop{\mathrm{supp}}\mu\subseteq\{\lambda_k\}$, a finite set with known multiplicities, is far stronger than $\mathop{\mathrm{supp}}\mu\subseteq[\lambda_{\min},\lambda_{\max}]$, which is all the block uses. An argument using the atoms is not covered.
- **"built from them" is undefined.** Does an argument that also uses the proved pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$ ([Lemma L31](../findings/stratum-two-negative.md)) count as *moment analysis of the $g$-distribution*? The cap is not a consequence of positivity or support, so it escapes the stated class, and this is not academic, since the record's own full pinned relaxation includes it.

Each of these is fatal to the block's argument and **harmless to the correct one**, which is the next section.

## 3. The theorem that is actually true, proved

**Proposition.** Fix $n$ and a spectrum $\lambda$. Let $\mathcal R(\lambda)=\{T\ \text{totally symmetric, hollow},\ T\ge0,\ \text{(A)},\ \text{(B)}\}$ and let $\vartheta(T):=\mathop{\mathrm{tr}}W^3+\tfrac12\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}$. Then every conclusion of every argument whose hypotheses are *positivity of $g$, the support of $\mu$, and the values of $m_0$ and $m_1$* is a true statement about all of $\mathcal R(\lambda)$. Hence no such argument can prove $\theta\le c$ for any $c<\sup\{\vartheta(T):T\in\mathcal R(\lambda)\}$.

*Proof.* Three steps, each an identity or a containment.

**(i) Every moment is linear in $T$.** $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, so for every $j\ge0$

$$m_j=\sum_k\lambda_k^jg_k=\sum_{k\alpha\beta}\lambda_k^j(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta},$$

a linear functional of $T$ at fixed $\lambda$. So is $G_2$, and so is every higher moment the method could reach for.

**(ii) The hypotheses are implied by $T\ge0$ with (A) and (B).** Positivity: $g_k\ge0$ is immediate from $T\ge0$. Support: $\mu$ is carried by the atoms $\lambda_k$, a fact about $\lambda$ alone. The two pinned moments are (A) and (B) contracted, computed cold:

$m_0$: expand $(\lambda_\alpha-\lambda_\beta)^2=\lambda_\alpha^2-2\lambda_\alpha\lambda_\beta+\lambda_\beta^2$ and use symmetry in $\alpha\beta$, so $m_0=2\sum_{k\alpha\beta}\lambda_\alpha^2T-2\sum_{k\alpha\beta}\lambda_\alpha\lambda_\beta T$. Relabelling under total symmetry, the first sum is (A) weighted by $\lambda^2$ on the free index, $\sum_a\lambda_a^2\cdot2(n-2)=2(n-2)$; the second is (B) weighted by $\lambda$, $\sum_a\lambda_a(-2\lambda_a)=-2$. Hence $m_0=4(n-2)+4=\boxed{4(n-1)}$, **with no criticality anywhere.**

$m_1$: likewise $m_1=2\sum_{k\alpha\beta}\lambda_k\lambda_\alpha^2T-2\sum_{k\alpha\beta}\lambda_k\lambda_\alpha\lambda_\beta T$. The first is (B) weighted by $\lambda^2$: $\sum_a\lambda_a^2(-2\lambda_a)=-2\mathop{\mathrm{tr}}W^3$. The second is $X:=\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}$, and by the definition of $P$ (§4) $X=2\theta-2\mathop{\mathrm{tr}}W^3$. Hence $m_1=-4\mathop{\mathrm{tr}}W^3-2(2\theta-2\mathop{\mathrm{tr}}W^3)=\boxed{-4\theta}$.

**(iii) Containment.** Every inequality the method invokes (Cauchy–Schwarz, the support quadratic, any Hankel condition), is true for *every* nonnegative measure with those atoms, hence true at every $T\in\mathcal R(\lambda)$. Note the inequalities need not be linear; only the *hypotheses* need be implied, and they are. So the method's feasible region contains $\mathcal R(\lambda)$'s image, and its optimum over $\theta$ is at least $\mathcal R(\lambda)$'s. $\square$

**Three things this proof gives that the block's does not.**

- It covers **all** moments, **any** number of inequalities, and the finite-support reading, everything §2.2 lists as escaping the stated class.
- It is quantitative: the obstruction is exactly $\sup_{\mathcal R(\lambda)}\vartheta$, a nameable number, so the lemma becomes falsifiable, exhibit a $g$-moment bound below that supremum and it is refuted.
- **It shows the method is weaker than the block claims.** Step (ii) uses **(A) and (B) only**; (C) never appears, because $m_1=-4\theta$ is the definition of $P$ unpacked, not criticality. So the $g$-moment method lives inside $\mathcal R(\lambda)$, which strictly **contains** the pinned feasible set. The honest headline is *moment analysis of $g$ cannot even reach the pinned class*, which is a sharper statement than the one on the record.

**Where the obstruction actually bites, and where it does not.** At a *fixed* spectrum the pinned class is strong, [r331](REVIEW_r331.md) Q3 screens its max-$\theta$ as exact at all catalogued spectra, so the Proposition does not say a $g$-moment bound must be slack at a given point. The obstruction is a statement about the **spectrum-free** question, and it bites only through [T9](../plan.md)'s measurement that the pinned class over free spectra reaches $\ge1.3405$ at $n=6$ against a true maximum $\sqrt{3/2}$. **So the useful content of L113 rests on a numerical floor the file itself labels "a floor, not the maximum" and which a later blockquote in the same file restricts to $n=6$.** The block presents the lemma as analytic and unconditional; it is neither.

## 4. The contraction identity, CONFIRMED, constant and all

### 4.1 The derivation

Multiply (C) by $\lambda_a$ and sum over $a$:

$$\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}=\sum_a\lambda_a\cdot2\lambda_a(\theta-\lambda_a)=2\theta\sum_a\lambda_a^2-2\sum_a\lambda_a^3=2\theta\lVert W\rVert^2-2\mathop{\mathrm{tr}}W^3.$$

At $\lVert W\rVert=1$ this is $2\theta-2\mathop{\mathrm{tr}}W^3$, exactly as the block states. **CONFIRMED.** One rider: the display **silently sets $\lVert W\rVert=1$**, which is the record's standing normalisation but is a step, not an identity.

### 4.2 Which convention makes the $2$ right

The $2$ in (C) is not a free choice; it is forced twice over and the two forcings agree.

- **From the ordered convention.** $W^\#$ has $(W^\#)_{aa}=\tfrac12\sum_{\beta\gamma}T_{a\beta\gamma}\lambda_\beta\lambda_\gamma$, the $\tfrac12$ belonging to the definition of $\#$. Criticality's diagonal, $\lambda_a^2+(W^\#)_{aa}=\theta\lambda_a$, gives $\tfrac12\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{a\beta\gamma}=\lambda_a(\theta-\lambda_a)$, i.e. (C). **The $2$ is exactly the reciprocal of $\#$'s $\tfrac12$, and it survives only because $\sum_{\beta\gamma}$ is over ORDERED pairs.** Under a $\beta<\gamma$ reading the constant would be $1$, not $2$, and every downstream display would move by a factor $2$.
- **From the trace check of §1**, which pins (B) and (C) against each other with no reference to $\#$ at all.

This is the same collision class the brief flags: the constant is right, and it is right *because of* a convention that the block never names. The record's own $\tfrac12$-in-$\#$ appears at [bounds.md](../findings/bounds.md) line 213 and nowhere in [conventions.md](../findings/conventions.md).

**Corollary worth recording: (C) *is* the diagonal of $Q(W)=\theta W$.** The block says so at line 391 in a different context; it does not say so where (C) is introduced, and it is the cleanest statement of why (C) needs criticality and (A), (B) do not.

### 4.3 "The objective disappears", what disappears, and what it costs

The record's cubic identity $\theta=\mathop{\mathrm{tr}}W^3+\tfrac12X$ is the definition of $P(W)=\langle W,W^2+W^\#\rangle$ unpacked: $\langle W,W^2\rangle=\mathop{\mathrm{tr}}W^3$ and $\langle W,W^\#\rangle=\sum_a\lambda_a(W^\#)_{aa}=\tfrac12X$. So §4.1's identity and the cubic identity are the same equation. **CONFIRMED**, with one direction of it only: the cubic identity is the $\lambda$-contraction of (C), so it adds nothing to (C); (C) is $N$ equations and is not recoverable from the one. And the cubic identity holds on all of $\mathcal W_n$ with $\theta:=P(W)$, while (C) needs criticality, so *"these are the same equation"* is true at critical points and the honest form is the block's own second clause, *"the cubic identity adds nothing to (C)"*.

**What disappears, precisely.** At fixed $\lambda$, the constraint set is (A), (B), (C)$_\theta$, $T\ge0$, with $\theta$ a *parameter* of (C). The functional $\vartheta(T)=\mathop{\mathrm{tr}}W^3+\tfrac12X$ is affine in $T$, and the $\lambda$-contraction of (C)$_\theta$ says $\vartheta(T)=\theta$ **identically on the feasible set**. So the objective is constant there: "maximise $\theta$" is not an optimisation but a **feasibility question in the parameter $\theta$**. That is the correct content of the heading, it is what the block means by *"a consistency condition, not a maximisation"*, and it is what line 411 later draws out correctly.

**What it costs a relaxation.** Since the objective is constant on the feasible set, **a relaxation in this class can never be tightened by improving its objective, only by adding constraints.** That is the load-bearing consequence and the block does not state it.

**Is L113 the same fact as "(A) and (B) contain no $\theta$"? No.** I checked this directly, since the brief flags it. [Lemma L112](../findings/bounds.md)'s refutation concerns $S_{ab}=\sum_cT_{abc}$, built from (A) and (B) alone, in which $\theta$ genuinely never appears. L113's measure carries $m_1=-4\theta$, so $\theta$ is present from the first moment onward. **Three distinct statements, correctly held apart on the record:** (i) $\theta$ is affine in $T$ and constant on the pinned feasible set (§4.3); (ii) $(A)$ and $(B)$ carry no $\theta$ (L112's blockquote); (iii) the $g$-moment method cannot beat the pinned relaxation (L113). **No duplication here.**

## 5. Label, it is a fence post, not a theorem

*"Theorem-shaped extension of [post F42](../findings/fence-posts.md)"* is a hedge and should be replaced by a literal label. Three readings, three labels:

| reading | label it deserves |
| --- | --- |
| as written (§2) | **not a result**, a tautology in the census sense of "pinned", forbidding nothing |
| the Proposition of §3 | **a theorem**, and a stronger one, but it is not what is on the record |
| the useful consequence, *"no $g$-moment argument closes Conjecture A"* | **a fence post**, conditional on [T9](../plan.md)'s $n=6$ floor |

**"Extension of post F42" is also too generous.** F42's surviving rule reads: *"If two exponents are $\le1$ **and** the proof uses only (A)/(B)/(C), positivity and support, the route is closed with no computation."* L113 is that rule applied to one method, an **instance**, not an extension. The one thing L113 adds is that the second clause alone suffices even when the lever is free, which is worth saying in one sentence and is not what the block says.

## 6. Provenance, clean at birth, stale within the hour, never repaired

`git log -S` gives two touches and no more.

| commit | date | what it did |
| --- | --- | --- |
| 71d6d76a | 2026-09-01 22:14 | created the whole moment-problem block including the moral, verbatim as it stands |
| c14052fc | later | placed the `#### Lemma L113` heading; text untouched |

The prose has **never been edited** since 22:14 on 2026-09-01, apart from the `post 42` → `post F42` rename. No boilerplate verification note is attached, and none is claimed, the commit says *"Derived inline on Fable, by hand"*, and the derivation checks (§4). **On provenance narrowly: clean.**

**But the closing sentence is stale, and the timing is exact.** L113 nominates *"the Jacobi identity and first Bianchi acting on the $c$-tensor itself"* as *"the single open door"*, and calls [r331](REVIEW_r331.md)/[r332](REVIEW_r332.md)'s Q1 *"the question the whole route stands on"*. r331 was filed at **23:00 the same evening**, forty-six minutes later, and its Q1 verdict is **CONFIRMED, all four hunting grounds provably empty**, with §1.2 stating in terms: *"Where Jacobi genuinely acts is on realizability of $c$ given $T$, which is the original problem, not a relation."* [r331 line 145](REVIEW_r331.md) addresses L113's moral by name and says the door *"is not narrow, it is shut"* at the tested spectra.

So the block was legitimate when written and **has been stale for three days**, pointing a successor at a door the record's own next filing reported closed. This is the pattern the audit brief warns of, in its milder form: not false at birth, but never folded in. [INDEX-results.md](../findings/INDEX-results.md) row 113 records *"Gate 2: no verdict on the record"*, which is accurate for Gate 2 and hides the fact that a non-Gate-2 reviewer commented on this exact sentence three days ago.

## 7. Duplication, one, and it is upward

**No verbatim twin, numbered or unnumbered.** The phrase appears at exactly three sites: the heading, [INDEX-results.md](../findings/INDEX-results.md) row 113, and [r331 line 145](REVIEW_r331.md) quoting it. [LIT-invariants.md](LIT-invariants.md) line 112 cites it as *"the record's moment-problem closure"* to argue that $\lVert W^\#\rVert^2$ lies outside its reach, a use of the closure's **scope**, not its strength, so it survives every defect above.

**But the statement is subsumed by [plan.md](../plan.md)'s I16**, which reads: *"Theorem: at $n=12$ the spectrum $(-a)^4,b^3,0^{59}$ ... admits a totally symmetric hollow $T\ge0$ satisfying (A),(B),(C) and the pair cap with $\theta=2.2913>\theta_0(12)$; hence **no bound proved from (A),(B),(C), positivity and support alone can close Conjecture A over all unit Weyl operators**."* That is L113's useful reading, **stronger on every axis**: it covers the whole pinned class rather than the $g$-moments, it carries a hand witness rather than a numerical floor, and it names $n=12$ rather than $n=6$. The record therefore holds the same impossibility twice, once as a numbered lemma with a tautological proof and once as an ungraded plan item with a witness. **The lemma should be restated as the corollary of I16 that it is**, or withdrawn in its favour.

## 8. Pointers, and one structural note

- **Every pointer in and around the block resolves.** `[post F42](fence-posts.md)` reaches the heading at [fence-posts.md](../findings/fence-posts.md) line 410; the in-file anchors for L142, L70, L107, L108, L112 all have matching headings. **No dead anchors found.**
- **Bare mention.** *"r331/r332's Q1"* appears unlinked inside L113 while the same file links both reviewers elsewhere. Minor and worth fixing while the sentence is being repaired anyway.
- **The lemma heading owns no derivation.** The Cauchy–Schwarz bound, the support inequality and the elimination all sit **above** the `#### Lemma L113` heading, under the unnumbered *"The moment problem for $g$, run to its end"* and under [L107](../findings/bounds.md)'s second derivation. What sits under L113 is the moral paragraph alone. So the numbered result, read from its own heading down as the record's structure check reads it, **contains no argument at all**, which is part of why the tautology survived.

## 9. What survives, and what would consume it

**If moment analysis cannot leave the pinned class, what can?** The block names one escape (Jacobi and first Bianchi on $c$ before squaring) and §6 shows that escape was closed at the per-index level within the hour. What the record actually leaves standing, in positive terms:

- **Realizability of $c$ given $T$.** [r331](REVIEW_r331.md) §1.2 locates it exactly: Jacobi's content is not a relation on $T$ but a constraint on which $T$ arise from an actual $c$. That is outside every relaxation on the record, and it is the honest escape.
- **The off-diagonal criticality block**, in its unaveraged form. [r331](REVIEW_r331.md) shows only that its $O(E)$-average is empty; [Lemma L111](../findings/bounds.md)'s Gate 2 counts $\sum_i\binom{m_i+1}2$ conditions the diagonal form drops.
- **The joint hull reading** of [r337](REVIEW_r337.md), quoted in this same file, which is strictly stronger than every 1-D projection and is what [I24](../plan.md) has become.

**What consumes L113, and how much of it is needed.** One site: [LIT-invariants.md](LIT-invariants.md) line 112, which needs only that the closure is *about the $g$-distribution* in order to conclude it does not reach $\lVert W^\#\rVert^2$. **That consumption needs neither the impossibility's strength nor its class**, so nothing on the record falls with the defects above.

## 10. Recommendation

1. **Retitle in the relaxation sense and prove it there.** Replace the moral with §3's Proposition, four lines, stronger, and falsifiable. Record explicitly that the method uses (A) and (B) only, so it cannot even reach the pinned class.
2. **Table "pinned class" in [conventions.md](../findings/conventions.md) in both senses**, with the note that a conclusion can only be "in" the second. Table $g_k$ and $G_2$ while there.
3. **Relabel.** Fence post, conditional on [T9](../plan.md)'s $n=6$ floor, with the rider that the floor is a lower bound from a nonconvex outer search, which the block currently omits at this site.
4. **Repair the closing sentence**, which has pointed at a closed door since 2026-09-01 23:00, and redirect it to realizability of $c$ given $T$, [r331](REVIEW_r331.md) §1.2's own formulation.
5. **Cross-reference [I16](../plan.md)**, or withdraw L113 in its favour and keep it as I16's $g$-moment corollary.
6. **Move the derivation under the heading**, or make L113's heading cover the moment-problem section it is the moral of.

**No computation was performed for this review, and none was needed.** The one place where a computation is load-bearing is §3's last paragraph: the fence-post reading of L113 stands or falls with $\sup_{\mathcal R(\lambda)}\vartheta$ over free spectra, which is [T9](../plan.md). **What a run would decide:** if that supremum is below $\Theta_n$ at some $n$, the pinned class closes Conjecture A there and L113 becomes vacuous rather than obstructive; if above, L113's fence-post reading is confirmed at that $n$ and the block should say so at that $n$ only. **The record currently holds the second outcome at $n=6$ alone, as a floor.** That run is not authorised by this brief and was not started.
