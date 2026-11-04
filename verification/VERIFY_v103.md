# VERIFY v103, Lemma L57, the diagonal theorem at every $n\ge4$: the three steps, the chaining, the equality clause, and the bridge from a critical point to every diagonal $W$

*Verifier v103, round L57, dispatched cold on [ROUND_L57.md](ROUND_L57.md)'s brief. **No numerical work was done and no script was run**; every value below is an exact hand evaluation, and the block's own `verified to $10^{-12}$` phrases are treated as open hypotheses rather than as evidence. Log: [agent_logs/verify-L57-v103.log](../agent_logs/verify-L57-v103.log).*

## Verdicts

| # | claim, as a consumer would read it | verdict |
| --- | --- | --- |
| 1 | Step 1, $\lambda\le\frac{n-1}n\mu$, under [Step 1 is PROVED](../findings/problem.md) | **PROVEN**, parity-free, re-derived line by line here; one unstated hypothesis, $\mu>0$ |
| 2 | Step 2(a), $Z(v)\in\mathcal D_n$ | **PROVEN**, parity-free |
| 3 | Step 2(b), $Z$ is the orthogonal projection of $(v_iv_j)$ onto $\mathcal D_n$, hence $\mu=2\langle S,Z\rangle$ | **PROVEN**, parity-free |
| 4 | Step 2's norm formula $\lvert Z\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4$ | **HYPOTHESIS-DEBT**, no derivation anywhere on the record; the only support on file is `verified to $10^{-12}$`. Every constant in the theorem comes off this line |
| 5 | Step 3, the fourth-moment lemma, Proof I | **PROVEN**, parity-blind, re-derived here including Lemma A and the two-value evaluation |
| 6 | Step 3, Proof II | **GAP**, the sub-lemma's `all $24$ monomials positive` is an assertion about an unexhibited expansion; the route is redundant, Proof I standing alone |
| 7 | The chaining $\lambda^2\le(\frac{n-1}n)^2\cdot4\lvert Z\rvert^2_{\max}=\Theta_n^2$, both parities | **PROVEN**, both constants re-derived exactly; normalisation consistent across the three steps |
| 8 | The normalisation: $\mathop{\mathrm{tr}}S^2=2$ against $\lvert S\rvert=1$ | **PROVEN (hypotheses corrected**), the chain is consistent, but step 2 silently runs in the **unordered** pairing against [conventions.md](../findings/conventions.md)'s stated ordered default, and the block warns only about the opposite error |
| 9 | The bridge from a critical point to **every** diagonal $W$ | **PROVEN (hypotheses corrected**), the reduction exists, at a heading the block's own *whole map* does not name; its load-bearing step is proved in [diagonal-half.md](../findings/diagonal-half.md), not where the bridge says |
| 10 | The translation $\mathop{\mathrm{tr}}W^3=\tfrac12\langle M^{\circ2},M\rangle$, $\langle W,W^\#\rangle=\tfrac12\langle M^2,M\rangle$ | **HYPOTHESIS-DEBT**, `exact at every test point` is the whole of its support. Without it the matrix problem is not the Weyl problem |
| 11 | The domain bijection $\mathcal D_n\leftrightarrow$ the coordinate-diagonal part of $\mathcal W_n$ | **PROVEN (hypotheses corrected**), the block asserts it; the read source [Jäger](../references/jaeger-2016-diagonal-case/notes.md) states it |
| 12 | Attainment: $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, and balance beats every other split | **PROVEN**, the monotonicity step is correct and one line; the closed form is [Nienhaus Proposition 2.25](../references/nienhaus-2023-second-best-einstein/notes.md), read |
| 13 | The equality clause (attainment **and** uniqueness), `equality exactly at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$` | **PROVEN (hypotheses corrected**), both halves hold and I re-derived the odd case's three ratios exactly; but the clause reaches a non-critical maximiser only through §6's unmapped bridge, and the block's own sign correction is unreadable alone because $V$ is defined nowhere on the record |
| 14 | F7, balancedness an input or an output? | **output**, of step 3 alone. F7's observation is **confirmed** and harmless: the $Z$-ratio match holds at every split and selects none |
| 15 | F8, every step at odd $n$? | **confirmed at both parities**: steps 1 and 2 parity-free, step 3 parity-blind by Proof I, chaining parity-split and both branches exact |
| 16 | The three forms agree | **GAP**, [problem.md](../findings/problem.md) heads the argument `CANDIDATE … Gate 2 owed … none audited`; [results.md](../results.md) labels it **Lemma**; [lean/INDEX.md](../lean/INDEX.md) has no row and buckets L57 `out` for a reason belonging to Jäger's proof, not this one |

**Verdict: HYPOTHESIS-DEBT.** *Every step the block writes out is correct, and I re-derived all of it by hand, both constants included. But the constant $\Theta_n$ reaches the page through two identities that the record supports with numerics and nothing else, step 2's $\lvert Z\rvert^2$ and the $W\!\to\!M$ translation, and the equality clause as printed is refuted by the record's own correction two hundred lines away.*

## 0. Conventions, fixed once

Read from [conventions.md](../findings/conventions.md), quoted rather than restated.

- $Q(W)=W^2+W^\#$; $P(W)=\langle W,Q(W)\rangle$; $\theta=P(W)/\lVert W\rVert^3$; a critical point is $Q(W)=\theta W$ on $\{\lVert W\rVert=1\}$.
- $\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf1=0\}$, the vertex matrices of coordinate-diagonal Weyl operators.
- **Sums over pairs are over ORDERED pairs unless the line says otherwise.** This is the file's own default and it matters in §4 below.
- $\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2=2$ at a unit Weyl tensor. So the block's locus $\mathop{\mathrm{tr}}S^2=2$ **is** $\lVert W\rVert=1$, and $\lvert S\rvert=1$ under plain Frobenius over ordered pairs would be $\lVert W\rVert=1/\sqrt2$, giving $\Theta_n/\sqrt2$. The block's warning is correct and I use $\mathop{\mathrm{tr}}S^2=2$ throughout.
- $\Theta_n$ is the **diagonal** maximum; $\theta_0(n)^2=2(n-1)(n-2)/n^2$ **and nothing more**. They agree at even $n$ and differ at odd.
- Throughout, $\mu$ is the largest eigenvalue of $S$ with unit eigenvector $v$, $r_i=\sum_js_{ij}^2$, $D=\mathop{\mathrm{diag}}(r_1,\dots,r_n)$, and $m_4=\sum_iv_i^4$.

## 1. The hypothesis inventory

**A pass without one is not a pass, so here is every hypothesis, where it enters, and whether the written proof carries it.**

### 1.1 Hypotheses the block states

| hypothesis | where it is used | carried? |
| --- | --- | --- |
| $S$ symmetric, hollow, $S\mathbf1=0$ | everywhere; $S\mathbf1=0$ is used twice in step 1 and once in step 2(a) | yes |
| $\mathop{\mathrm{tr}}S^2=2$ | **only** in step 2, at $\mu=2\langle S,Z\rangle\le2\lvert S\rvert\lvert Z\rvert$ | yes, and it is the one place the $\sqrt2$ trap bites |
| $n\ge4$ | step 3's Proof I, at *"since $n\ge4$ some coordinate is untouched"*; and $1/(n-2)$, $1/(n-1)$ in $Z$ | yes |
| $Q(S)=\lambda S$, i.e. $S^{\circ2}+S^2=\lambda S+D$ | step 1 only | yes |
| $v\perp\mathbf1$, $\lvert v\rvert=1$ | step 1's $\sum_{i<j}(v_i-v_j)^2=n$; step 3's constraint set | yes |

### 1.2 Hypotheses the proof uses and does not state

| hypothesis | where | consequence of omitting it |
| --- | --- | --- |
| **$\mu>0$** | step 1 divides $\lambda\mu\le\frac{n-1}n\mu^2$ by $\mu$; step 2's Cauchy–Schwarz is read in the direction $\mu\le2\lvert Z\rvert$ | the division reverses at $\mu<0$. *It is free ($S$ hollow gives $\mathop{\mathrm{tr}}S=0$, and $S\ne0$ then forces $\mu>0$) but it is nowhere on the page* |
| **$S\ne0$** | the same place, and $\theta$ is undefined at $S=0$ | the statement is vacuous rather than false; the same omission [L46](../findings/problem.md)'s audit found and booked |
| **the unordered pairing in step 2** | $\lvert Z\rvert^2$ and $\mu=2\langle S,Z\rangle$ are both sums over $i<j$ | see §4: a reader applying the file's own default gets $\lvert Z\rvert^2$ doubled and $\Theta_n\sqrt2$ |
| **$v$ is the top eigenvector of the $S$ the equality case produces** | the equality clause, at *"Equality forces … $S\parallel Z(v)$"* | consistency of the equality case, unchecked on file |

### 1.3 Hypotheses of every result the block imports

| imported | its hypotheses | checked against the object here |
| --- | --- | --- |
| the criticality equation $S^{\circ2}+S^2=\lambda S+D$, from [diagonal-half.md](../findings/diagonal-half.md):69–78 | $M$ in $\mathcal D_n$, critical for the **restricted** problem on $\mathcal D_n$ | ✓ matches. And its $D$ is $\mathop{\mathrm{diag}}(s_i)$ with $s_i=(M^2)_{ii}=\sum_jM_{ij}^2$, which is exactly the $r_i$ step 1's proof uses. Consistent |
| the translation $\mathop{\mathrm{tr}}W^3=\tfrac12\langle M^{\circ2},M\rangle$, $\langle W,W^\#\rangle=\tfrac12\langle M^2,M\rangle$, [diagonal-half.md](../findings/diagonal-half.md):428 | $W$ coordinate-diagonal | ✓ applies, but see §7, its support on file is *"exact at every test point"* |
| [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 2.25, $\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}k\frac{l-1}l\frac{n-1}{n-2}}$, $P(W_{S_{k,l}})=\theta_{k,l}$ | unconditional, every split $k+l=n$ | ✓ read in [references/](../references/). It is the attainment half, and it fixes the **sign**: $P$ is $+\theta_{k,l}$ at the sphere product itself |
| [Jäger](../references/jaeger-2016-diagonal-case/notes.md) Theorem A | **even $n\ge16$** | ✓ read. It covers neither odd $n$ nor even $n\le14$, so the block's *"the odd case rests on this theorem and on nothing published"* is true and **understates**: even $n\in\{4,6,8,10,12,14\}$ rests on it equally |
| Jäger's setup sentence, *"the condition that $W$ is Weyl reduces to $\sum_iw_{ij}=0$"* | coordinate-diagonal $W$ | ✓ read; it is the domain bijection the block asserts and proves nowhere |

**Which of these the written proof actually uses.** Steps 1–3 use rows 1, 4 and 5 of §1.1 plus the criticality equation. They use $\mathop{\mathrm{tr}}S^2=2$ once. They use **nothing** about compactness, irreducibility, Einstein, or $\ker W$. The two published sources are used only for attainment and for the domain, never inside the chain.

## 2. Step 1, $\lambda\le\frac{n-1}n\mu$: PROVEN, and parity-free

**The written proof, re-derived in full.** Pair $S^{\circ2}+S^2=\lambda S+D$ with $v\otimes v$, $Sv=\mu v$, $\lvert v\rvert=1$:

$$v^{\mathsf T}S^{\circ2}v+\mu^2=\lambda\mu+\sum_ir_iv_i^2 .$$

Now $v^{\mathsf T}S^{\circ2}v=\sum_{i,j}s_{ij}^2v_iv_j$ and, by the symmetry of $s_{ij}^2$, $\sum_ir_iv_i^2=\sum_{i,j}s_{ij}^2v_i^2=\tfrac12\sum_{i,j}s_{ij}^2(v_i^2+v_j^2)$. Subtracting,

$$\sum_ir_iv_i^2-v^{\mathsf T}S^{\circ2}v=\tfrac12\sum_{i,j}s_{ij}^2(v_i^2+v_j^2-2v_iv_j)=\sum_{i<j}s_{ij}^2(v_i-v_j)^2 ,$$

which is $(*)$: $\lambda\mu=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$. The two contractions:

$$\sum_{i<j}s_{ij}(v_i-v_j)^2=\tfrac12\Big[2\sum_iv_i^2\underbrace{\textstyle\sum_js_{ij}}_{=0}-2\sum_{i,j}s_{ij}v_iv_j\Big]=-\mu,\qquad \sum_{i<j}(v_i-v_j)^2=n\sum v^2-\big(\sum v\big)^2=n .$$

Cauchy–Schwarz on the splitting $s_{ij}(v_i-v_j)^2=[s_{ij}(v_i-v_j)]\cdot(v_i-v_j)$ gives $\mu^2\le n\sum_{i<j}s_{ij}^2(v_i-v_j)^2$, so $\lambda\mu\le\mu^2-\mu^2/n=\frac{n-1}n\mu^2$, and dividing by $\mu>0$ closes it. $\square$

**Verdict: PROVEN.** Every line reproduces. **Parity: parity-free**, no argument in it distinguishes $n$ even from $n$ odd, and none of $n$'s parity enters the two contractions.

**One hypothesis is missing and it is free.** The final division needs $\mu>0$. It holds because $S$ is hollow, so $\mathop{\mathrm{tr}}S=0$, so a nonzero $S$ has a strictly positive eigenvalue. The block never writes it. I record it rather than repair it.

## 3. Step 2, the projection: two halves PROVEN, the norm formula NOT

### 3.1 (a) $Z(v)\in\mathcal D_n$, PROVEN

Symmetric and hollow by construction. For the row sums, with $\sum_{j\ne i}v_j=-v_i$ and $\sum_jv_j^2=1$:

$$\sum_{j\ne i}Z_{ij}=-v_i^2+\frac{(n-1)v_i^2+(1-v_i^2)}{n-2}-\frac{n-1}{(n-1)(n-2)}=-v_i^2+\Big(v_i^2+\tfrac1{n-2}\Big)-\tfrac1{n-2}=0 .$$

Reproduces exactly. **Parity-free.**

### 3.2 (b) $Z$ is the orthogonal projection, PROVEN

The residual is $(v_iv_j)-Z_{ij}=a_i+a_j+c$ with $a_i=-v_i^2/(n-2)$ and $c=1/((n-1)(n-2))$. For any $T\in\mathcal D_n$,

$$\sum_{i<j}(a_i+a_j)T_{ij}=\tfrac12\sum_{i\ne j}(a_i+a_j)T_{ij}=\sum_ia_i\sum_{j\ne i}T_{ij}=0,\qquad \sum_{i<j}cT_{ij}=\tfrac c2\sum_{i\ne j}T_{ij}=0 .$$

Reproduces exactly. **Parity-free.** It yields $\mu=v^{\mathsf T}Sv=\sum_{i,j}s_{ij}v_iv_j=2\sum_{i<j}s_{ij}v_iv_j=2\langle S,Z(v)\rangle$ in the $i<j$ pairing, and then $\mu\le2\lvert S\rvert\lvert Z\rvert=2\lvert Z\rvert$ because $\mathop{\mathrm{tr}}S^2=2$ is $\sum_{i<j}s_{ij}^2=1$.

### 3.3 The norm formula, HYPOTHESIS-DEBT

**Locate it.** [problem.md](../findings/problem.md):266 reads

> *"and $\lvert Z(v)\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4$, the projection and the norm formula both verified to $10^{-12}$ at $n=6,7,8,11,12$."*

**Exhibit the failure.** The heading the block's map sends a reader to for step 2 is *Step 2 is now PROVED here, **both halves**, in a few lines each*, and the two halves it proves are (a) membership and (b) orthogonality. **The norm formula is a third claim and no heading in the file proves it.** I searched: `n^2-3n+3` occurs in [problem.md](../findings/problem.md) and in [LEDGER.md](../findings/LEDGER.md), and in no other findings file, and the LEDGER occurrence is the record booking the debt, not discharging it: *"step 2's $\lVert Z(v)\rVert^2$ identity rests on verification at $n=6,7,8,11,12$"*.

**Argue the opposite.** The most charitable reading is that a formula checked at five dimensions to twelve digits, in a polynomial identity of bounded degree, is morally settled. It is not evidence under this record's own rule, and it is not settled either: the identity is one in **two** free quantities ($n$ and the distribution of $v$), so five dimensions and a finite sample of $v$ constrain neither. **Every constant in the theorem comes off this line**, so the debt is at the point of maximum load.

**What would have to be shown.** Exactly this, and it is a short computation the record does not have: expand $\sum_{i\ne j}Z_{ij}^2$, use $\sum_{i\ne j}v_i^2v_j^2=1-m_4$, $\sum_{i\ne j}v_i^3v_j=-m_4$, $\sum_{i\ne j}v_iv_j=-1$, and halve.

**For the record, I carried that expansion out by hand as a screen on my own verdict**, reported as a screen, not as the record's evidence. Writing $t=1/(n-2)$, $c=t/(n-1)$: the $m_4$ terms collect to $-(1+2t)m_4=-\frac n{n-2}m_4$; the constant terms collect to $1+2t^2+\frac{nt^2}{n-1}+\frac{2t}{n-1}-4t^2=1+\frac t{n-1}=\frac{n^2-3n+3}{(n-1)(n-2)}$; halving gives the stated formula. **So the formula is true and the record still does not prove it.** The verdict on the step stands at HYPOTHESIS-DEBT.

**Parity: parity-free.** Nothing in $Z$, in (a), in (b) or in the norm formula distinguishes parities. Parity enters step 2 only through what is substituted for $\sum v_i^4$.

## 4. Step 3, the fourth-moment lemma: PROVEN by Proof I, parity-blind

### 4.1 Proof I reproduces in full

**Lemma A.** $t_1+t_2+t_3=0\Rightarrow p_4=\tfrac12p_2^2$. Newton with $e_1=0$: $p_2=e_1p_1-2e_2=-2e_2$, so $e_2=-p_2/2$; and $p_4=e_1p_3-e_2p_2+e_3p_1=-e_2p_2=\tfrac12p_2^2$. $\square$ Reproduces.

**The theorem.** Minimise $m_4=\sum v^4$ on $\{\sum v=0,\ \sum v^2=1\}$. The constraint gradients $\mathbf1$ and $2v$ are independent throughout the set (they would be dependent only at $v\parallel\mathbf1$, excluded by the two constraints together), so Lagrange applies: $4v_i^3=\alpha+2\beta v_i$, a cubic with no quadratic term. Its roots are at most three, and if three distinct values occur among the $v_i$ they **are** the three roots and sum to $0$.

At a minimiser with exactly three values, pick one coordinate carrying each, let $\sigma$ be their square-sum, and replace the triple by any point of $C=\{\sum t=0,\ \sum t^2=\sigma\}\subset\mathbb R^3$. Both constraints survive; by Lemma A the objective is unchanged; so the new vector is still a global minimiser and must have at most three values. Choose $t\in C$ with distinct entries avoiding the three old values, $C$ is a circle and only finitely many of its points are excluded. Since $n\ge4$ at least one coordinate is untouched, so the new vector carries three new values **and** one old one: at least four. Contradiction. Hence at most two values.

**The two-value evaluation, re-derived exactly.** With value $a$ at multiplicity $p$ and $b$ at $q=n-p$: $pa+qb=0$ gives $b=-pa/q$; $pa^2+qb^2=pa^2\frac nq=1$ gives $a^2=\frac q{pn}$ and $b^2=\frac p{qn}$. Then

$$\sum v^4=pa^4+qb^4=\frac{q^2}{pn^2}+\frac{p^2}{qn^2}=\frac{p^3+q^3}{pqn^2}=\frac{n^3-3pqn}{pqn^2}=\frac n{pq}-\frac3n ,$$

decreasing in $pq$, so minimised at $pq=\lfloor n/2\rfloor\lceil n/2\rceil$. At even $n$, $pq=n^2/4$ gives $\frac4n-\frac3n=\frac1n$. At odd $n$, $pq=\frac{n^2-1}4$ gives $\frac{4n}{n^2-1}-\frac3n=\frac{4n^2-3n^2+3}{n(n^2-1)}=\frac{n^2+3}{n(n^2-1)}$. **Both stated values reproduce exactly.**

**Verdict: PROVEN. Parity: parity-blind**, the argument never splits on parity; the two constants are one formula, $\frac n{pq}-\frac3n$, evaluated at the integer maximiser of $pq$. This is the strongest parity answer of the three steps, and it is the step where the record's *"every step holds at both parities"* is most nearly literal.

**The one-value case is excluded** and the block does not say so: a single value with $\sum v=0$ forces $v=0$, contradicting $\sum v^2=1$. Free, and absent.

### 4.2 Proof II, GAP, and redundant

**Locate it.** *"a positivity sub-lemma ($(n-1)M_4-M_2^2$ expands with all $24$ monomials positive), gives $G\ge\tfrac1{n-1}$"*.

**Exhibit the failure.** The expansion is not exhibited, its $24$ monomials are not listed, and no file holds them. What *is* free is the weaker $nM_4\ge M_2^2$, which is Cauchy–Schwarz on $(\sqrt{m_i},\sqrt{m_i}r_i^2)$ with $\sum m_i=n$; the sub-lemma is the strengthening from $n$ to $n-1$, and the strengthening is the whole content. The final comparison **is** correct: $\frac1{n-1}>\frac{n^2+3}{n(n^2-1)}$ clears to $n(n+1)>n^2+3$, i.e. $n>3$.

**Argue the opposite.** The sub-lemma is plausible and the route is a genuine second proof; it was closed at Gate 2 by a named reviewer whose working may hold the expansion. But the reviewer report is cited as [r124](../reviews/INDEX.md) (an index, not a report) so there is no report to read here, and the round's rule forbids me writing under [reviews/](../reviews/).

**It does not matter.** Proof I stands alone and is complete. The claim damaged is only *"two independent arguments"* in the [results.md](../results.md) statement, which currently rests on one argument plus one sketch.

## 5. The chaining, and the normalisation trap read step by step

### 5.1 Both constants reproduce exactly

**Even $n$**, substituting $\sum v^4=\tfrac1n$:

$$\lvert Z\rvert^2_{\max}=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac1{2(n-2)}=\frac{n^2-3n+3-(n-1)}{2(n-1)(n-2)}=\frac{(n-2)^2}{2(n-1)(n-2)}=\frac{n-2}{2(n-1)} ,$$

so $4\lvert Z\rvert^2_{\max}=\frac{2(n-2)}{n-1}$ and $\lambda^2\le\frac{(n-1)^2}{n^2}\cdot\frac{2(n-2)}{n-1}=\frac{2(n-1)(n-2)}{n^2}=\Theta_n^2$. ✓

**Odd $n$**, substituting $\sum v^4=\frac{n^2+3}{n(n^2-1)}$: over the common denominator $2(n-2)(n-1)(n+1)$ the numerator is $(n^2-3n+3)(n+1)-(n^2+3)=(n^3-2n^2+3)-(n^2+3)=n^3-3n^2=n^2(n-3)$, so

$$\lvert Z\rvert^2_{\max}=\frac{n^2(n-3)}{2(n-2)(n-1)(n+1)},\qquad \lambda^2\le\frac{(n-1)^2}{n^2}\cdot\frac{2n^2(n-3)}{(n-2)(n-1)(n+1)}=\frac{2(n-1)(n-3)}{(n+1)(n-2)}=\Theta_n^2 . ✓$$

**Verdict: PROVEN**, given the norm formula of §3.3. **Parity: parity-split**, and this is the *only* place a parity split occurs, it is one substitution, made twice, into a formula that is itself parity-free. So the record's *"every step holds at both parities"* is accurate, with the refinement that steps 1 and 2 are parity-free, step 3 is parity-blind, and the chaining is where the two constants separate.

### 5.2 Which normalisation each step uses

| step | what it needs | reading |
| --- | --- | --- |
| 1 | $\lvert v\rvert=1$ and $v\perp\mathbf1$; **no** normalisation of $S$ at all, $(*)$ and the Cauchy–Schwarz are homogeneous of matching degree in $S$ | normalisation-free |
| 2 | $\sum_{i<j}s_{ij}^2=1$, at $\mu\le2\lvert S\rvert\lvert Z\rvert$; and $\lvert Z\rvert^2$ as a sum over $i<j$ | **unordered pairs** |
| 3 | $\sum v^2=1$ | normalisation-free in $S$ |
| chaining | the two above, composed | consistent |

**The chaining is consistent, and I checked it by the only test that decides the question**: the constants come out equal to $\Theta_n^2$ on the nose, which they would not under a mismatched pairing, a factor $\sqrt2$ anywhere in the chain would land on $\Theta_n\sqrt2$ or $\Theta_n/\sqrt2$. **No finding: the $\sqrt2$ trap the block warns about is not sprung.**

### 5.3 But the block warns about the wrong half of it

**Locate it.** [problem.md](../findings/problem.md):264 and the same sentence quoted into the brief:

> *"with $\mathop{\mathrm{tr}}S^2=2$, not $\lvert S\rvert=1$, which under [conventions.md](../findings/conventions.md)'s default of plain Frobenius over ordered pairs gives $\Theta_n/\sqrt2$"*

**Exhibit the failure.** The warning names the danger of mis-normalising $S$ and is correct. The **live** ambiguity is a different one and goes unmentioned: step 2's two displays ($\mu=2\langle S,Z(v)\rangle$ and the $\lvert Z\rvert^2$ formula), are sums over **unordered** pairs, and [conventions.md](../findings/conventions.md) says in terms *"sums over pairs are over ORDERED pairs unless the line says otherwise"*. Neither line says otherwise. A reader who applies the file's stated default to $\lvert Z\rvert^2$ doubles it, gets $4\lvert Z\rvert^2_{\max}=\frac{4(n-2)}{n-1}$ at even $n$, and concludes $\Theta_n\sqrt2$, the trap in the direction the warning does not face.

**Argue the opposite.** The factor $2$ in *"$\mu=2\langle S,Z\rangle$"* is itself the signal that the pairing is unordered, since the ordered pairing gives $\mu=\langle S,Z\rangle$ flat; a careful reader can back the convention out of that $2$. That is a real defence, and it is why this is a **hypotheses corrected** rather than a break. It is still a convention inferred from a coefficient rather than stated, in the one block whose own opening sentence is about a normalisation that cost a cycle.

**The repair is four words**: *"both sums over $i<j$"* on step 2.

## 6. Pre-registered question 1, does the proof reach the statement's quantifier?

**The gap is real and the reduction exists.** The statement quantifies over *every diagonal $W$ at every $n\ge4$*; the written chain opens *"at a critical point $Q(S)=\lambda S$"* and bounds a Lagrange multiplier. Nothing in steps 1–3 reaches a non-critical $W$.

**The reduction is on file.** Under the heading *So the all-$n$ diagonal theorem is COMPLETE*, [problem.md](../findings/problem.md):416:

> *"$\mathcal D_n$ is a linear subspace and the cubic is continuous and homogeneous, so its maximum over the unit sphere of $\mathcal D_n$ (compact), is attained, and the maximiser is critical for the restricted problem. **$Q$ preserves $\mathcal D_n$**, so that restricted criticality is the equation the chain solves … Hence the bound at critical points is the bound everywhere on $\mathcal D_n$."*

**It is correct, and its load-bearing step is proved somewhere else.** The step that can fail is *"$Q$ preserves $\mathcal D_n$"*, because the constrained Lagrange condition on $\{\mathop{\mathrm{tr}}S^2=2\}\cap\mathcal D_n$ is not $S^{\circ2}+S^2=\lambda S+D$ but

$$\big(S^{\circ2}+S^2\big)_{ij}=\lambda S_{ij}+\beta_i+\beta_j\qquad(i\ne j),$$

with $\beta$ the multiplier of the $n$ row-sum constraints, the residual shape step 2(b) itself identifies as the orthogonal complement of $\mathcal D_n$. **If $\beta\ne0$, step 1's identity $(*)$ acquires an extra term and the chain does not start.** The vanishing of $\beta$ is proved, but in [diagonal-half.md](../findings/diagonal-half.md):75:

> *"Summing the off-diagonal equation over $j\ne i$ and using $M\mathbf1=0$, $(M^2)\mathbf1=0$ makes the left side $s_i-s_i=0$, leaving $0=(n-2)v_i+\mathbf1^{\mathsf T}v$ for every $i$, so all $v_i$ agree, and then $(2n-2)v=0$ gives $v=0$."*

I checked the mechanism independently: $S^{\circ2}$ has row sums $r_i$, $S^2$ has row sums $0$ with $(S^2)_{ii}=r_i$, so the **hollow part** of $S^{\circ2}+S^2$ has row sums $r_i-r_i=0$ and lands back in $\mathcal D_n$. **So the claim is true and the bridge holds.**

**Answer to question 1: the argument reaches a non-critical diagonal $W$, by a maximiser-plus-compactness reduction, and that reduction is on file**, but not where the block sends a reader. **This is the named trap, and here is the exact shape of it.** The L57 block opens *"The argument is spread over five places, and this is the whole map"* and names five: the three step headings, the odd-equality heading, and [diagonal-half.md](../findings/diagonal-half.md) for the criticality equation. **The bridge paragraph is in none of them.** A consumer who reads the L57 block, follows its map to the letter, and reads all five places, gets a bound at critical points and a statement quantified over all $W$, with the sentence joining them never in view. The block's own text concedes the history: *"Assembled at audit; the record had every ingredient and this sentence nowhere."*

**Argue the opposite.** The bridge sits three hundred lines above the L57 block in the same file, under a heading that says the theorem is complete, so a reader of the file end to end meets it. That is true of a reader of the file, and false of a consumer of the map, and the map is the artefact the block built for exactly this purpose. **The repair is one heading name added to the map's list of five.**

## 7. The debt beneath all of it, the $W\to M$ translation

**Locate it.** [diagonal-half.md](../findings/diagonal-half.md):428:

$$\mathop{\mathrm{tr}}W^3=\tfrac12\langle M^{\circ2},M\rangle,\qquad \langle W,W^\#\rangle=\tfrac12\langle M^2,M\rangle,\qquad 2\theta=\langle M^{\circ2}+M^2,\ M\rangle,$$

> *"exact at every test point."*

**Exhibit the failure.** That sentence is the entire support. These three identities are what make the matrix problem **be** the Weyl problem: the first two turn $\langle Q(W),W\rangle$ into a cubic in $M$, the third is what the chain's $\lambda$ is a bound on, and the criticality equation of [diagonal-half.md](../findings/diagonal-half.md):69 is presented in the same register, *"Fitted jointly for the coefficient and $v$, it holds at residual $10^{-16}$"*. So the passage from the theorem's left-hand side $\langle Q(W),W\rangle$ to the object the three steps bound rests, on file, on measurement.

**Argue the opposite.** The third identity is a formal consequence of the first two, and the first two are a $\#$-computation on the coordinate-diagonal locus that Jäger's thesis performs, the reference notes say the diagonal $\#$-formula is what Poljsak's thesis cites Jäger for. **That defence names a source, and the source's formula is not transcribed into [references/jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md)**, so on the material in [references/](../references/) the claim rests on an unread source.

**Verdict: HYPOTHESIS-DEBT.** What would have to be shown: $\langle W,W^\#\rangle=\tfrac12\langle M^2,M\rangle$ for coordinate-diagonal $W$ with vertex matrix $M$, from the definition of $\#$, one computation, and neither the record nor the read references carry it. Unlike §3.3, **this one is not on [LEDGER.md](../findings/LEDGER.md)**, which books the $\lvert Z\rvert^2$ debt and the $n^2-3n+3$ identity and stops there.

## 8. Pre-registered question 2, F7, balancedness as input or output

**The attainment paragraph's monotonicity step is correct, and it is one line.** With $p+q=n$,

$$\Big(1-\tfrac1p\Big)\Big(1-\tfrac1q\Big)=1-\frac1p-\frac1q+\frac1{pq}=1-\frac{p+q-1}{pq}=1-\frac{n-1}{pq},$$

strictly increasing in $pq$, and $pq$ is maximised over $p+q=n$ at the most balanced integer split. **So *"the balanced split beats every other sphere product"* is proved, not asserted**, and the closed form it acts on is [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 2.25, read in [references/](../references/): $\theta_{k,l}^2=2\frac{(k-1)(l-1)}{kl}\cdot\frac{n-1}{n-2}$, which is the block's $\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ character for character. Both collapses check: at $p=q=n/2$, $(1-\frac2n)^2\cdot\frac{2(n-1)}{n-2}=\frac{2(n-1)(n-2)}{n^2}$; at $p,q=\frac{n\mp1}2$, $\frac{n-3}{n-1}\cdot\frac{n-1}{n+1}\cdot\frac{2(n-1)}{n-2}=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$.

**F7 is confirmed as an observation and is harmless to the theorem.** Step 2(c)'s computation, that at the balanced two-value $v$ the ratio $Z_{\text{same}}/Z_{\text{cross}}=-\frac{n/2}{n/2-1}$ *"is exactly the within/cross ratio of $S^{n/2}\times S^{n/2}$'s vertex matrix"*, singles out no split, and the record proves as much three headings later, in the structural note it files under *Two corrections*: block-constant elements of $\mathcal D_n$ with blocks $(p,q)$ satisfy $(p-1)x+qz=0$ and $(q-1)y+pz=0$, hence form a **one-dimensional** space. **So for every split $k+l=n$, the two-value $v$ with multiplicities $(k,l)$ has $Z(v)$ proportional to the vertex matrix of $S^k\times S^l$**, F7's claim exactly, and the record's own sentence.

**Balancedness is an OUTPUT.** It is produced in exactly one place: step 3's minimisation of $\sum v^4$ over the constraint set, which lands on $pq$ maximal. Step 2(c) and the $(d)$ heading are **identifications** of what the equality case *is*, given the split step 3 has already chosen; they agree with balancedness and do not select it. **No other step in the proof singles out a split.** The record's presentation invites the confusion by putting (c) at the balanced split with the word *"exactly"* and the general statement under a heading called *Two corrections*, but the mathematics is sound and the selection is honestly earned.

## 9. The equality clause is two claims, and both are checked here

*"Equality exactly at"* asserts **attainment** (the value is reached) and **uniqueness**, it is reached nowhere else. They are graded separately.

### 9.1 Attainment, PROVEN, on a read source

$\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ is [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 2.25, quoted in [references/](../references/) with *"Moreover, $P(W_{S_{k,l}})=\theta_{k,l}$"*, and §8 shows both collapses reproduce. **The block's own route to the same formula (*"from criticality with $\lambda_V=1-n$ independent of the split"*), is an assertion with no derivation on file**, but the conclusion does not need it.

### 9.2 Uniqueness, PROVEN, and the odd case reproduces exactly

The chain's equality needs all three steps tight at once. Step 2's Cauchy–Schwarz is tight iff $S=tZ(v)$, $t>0$; $\lvert Z(v)\rvert$ is maximal iff $\sum v^4$ is minimal; step 3 makes that $v$ two-valued with $pq$ maximal, **uniquely**, $\frac n{pq}-\frac3n$ is strictly decreasing in $pq$ and the integer maximiser of $pq$ on $p+q=n$ is unique up to swapping $p$ and $q$. It remains to identify $Z(v)$, and both parities are on file.

**Even $n$**, under step 2's own heading: $Z_{\text{same}}/Z_{\text{cross}}=-\frac{n/2}{n/2-1}$, which is the block-constant relation $x/z=-q/(p-1)$ at $p=q=n/2$. ✓

**Odd $n$**, under the $(d)$ heading, re-derived here from $a^2=\frac{n+1}{n(n-1)}$, $b^2=\frac{n-1}{n(n+1)}$ and $ab=-\frac1n$:

$$Z_{aa}=a^2\tfrac n{n-2}-c=\frac{n+1}{(n-1)(n-2)}-\frac1{(n-1)(n-2)}=\frac n{(n-1)(n-2)} ,$$
$$Z_{bb}=b^2\tfrac n{n-2}-c=\frac{n-1}{(n+1)(n-2)}-\frac1{(n-1)(n-2)}=\frac{n(n-3)}{(n-1)(n-2)(n+1)} ,$$
$$Z_{ab}=-\tfrac1n+\frac{2(n^2+1)}{n(n^2-1)(n-2)}-\frac1{(n-1)(n-2)}=\frac{-n^3+3n^2}{n(n^2-1)(n-2)}=-\frac{n(n-3)}{(n-1)(n-2)(n+1)} .$$

**All three of the block's displayed values reproduce**, including the *"cross value"* it leaves unwritten in the display and supplies two headings away, and including $Z_{ab}=-Z_{bb}$. The ratios are then $Z_{aa}/Z_{ab}=-\frac{n+1}{n-3}$ and $Z_{bb}/Z_{ab}=-1$, against the sphere product's $x/z=-\frac q{p-1}=-\frac{n+1}{n-3}$ and $y/z=-\frac p{q-1}=-1$ at $p=\frac{n-1}2$, $q=\frac{n+1}2$. **Identically in $n$, as claimed.** ✓ *(This needs $n\ge5$, since $p-1=\frac{n-3}2$ must not vanish; the theorem's range gives it.)*

**And the sign correction checks too.** $Z(v)=\lambda_ZV$ with $\lambda_Z=Z_{ab}=-\frac{n(n-3)}{(n-1)(n-2)(n+1)}$, which at $n=5,7,9,11$ is $-\frac{10}{72},-\frac{28}{240},-\frac{54}{560},-\frac{88}{1080}$, the block's $-0.1389,-0.1167,-0.0964,-0.0815$ exactly. So the block's $V$ is the vertex matrix **normalised to cross value $+1$**, and $S\parallel-V$ is the vertex matrix with cross value $-1$, which is the sign a sphere product's *Weyl* vertex matrix carries, since the cross sectional curvatures vanish and $W=R-cI$ subtracts a positive $c$. **So $S=-V/\lVert V\rVert$ and Nienhaus's $P(W_{S_{k,l}})=+\theta_{k,l}$ agree**, and the statement's *"equality at $S^{n/2}\times S^{n/2}$"* names the right object with the right sign.

### 9.3 What is nonetheless wrong with the clause as a consumer reads it

- **$V$ is defined nowhere.** It is absent from [conventions.md](../findings/conventions.md)'s table and from every findings file; I pinned its normalisation only by back-solving the $(d)$ display. **A correction whose subject is undefined cannot be checked by its reader**, and this one is the record's own repair of a sign.
- **The phrase *"Equality is up to $\pm1\times S_n$"* reads two ways and one of them is false.** $Q(-W)=Q(W)$ while $\langle Q(-W),-W\rangle=-\langle Q(W),W\rangle$, so $P$ is an **odd** cubic and $-W$ attains $-\Theta_n$, never $+\Theta_n$: equality is *not* up to sign of $W$. **The charitable reading is the right one**, $\pm1\times S_n$ is the hyperoctahedral group acting on the *frame*, under which the vertex matrix $K_{ab}=W_{abab}$ is invariant, so it names the frame's freedom rather than a symmetry of the maximiser. That reading is correct and the sentence does not say it.
- **Step 1's own equality claim is numerical.** *"Equality at every $S^p\times S^q$, balanced or not, even or odd $n$, checked at ten products to $10^{-16}$."* Nothing on file derives it. It is an aside rather than a load-bearing step, but it is stated in the same register as the proved lines around it.

## 10. Quantifier order, scope, and the edge of every range

**Quantifier order.** The statement is $\forall n\ge4\ \forall W$ diagonal. The proof's order is: fix $n$; take the maximiser of $P$ on the unit sphere of $\mathcal D_n$; it is critical; bound its $\lambda$; conclude for all $W$ by homogeneity. **The order is sound and the reduction is §6's bridge.** The one place order could bite is step 2, where $\lvert Z(v)\rvert^2$ is bounded uniformly in $v$ before $v$ is tied to $S$, and that is the right order, since a uniform bound over the admissible $v$ dominates the bound at the particular $v$.

| edge | answer |
| --- | --- |
| **$n=4$** | Every step holds. Step 3's Proof I needs exactly $n\ge4$ (*"since $n\ge4$ some coordinate is untouched"*) so $n=4$ is the boundary case of the one step that has a boundary, and it clears: three coordinates are moved and the fourth is not. $\Theta_4^2=\frac{2\cdot3\cdot2}{16}=\frac34$, and $S^2\times S^2$ gives $\frac{2\cdot3\cdot1\cdot1}{2\cdot4}=\frac34$. ✓ |
| **$n=5$** | $\Theta_5^2=\frac{2\cdot4\cdot2}{6\cdot3}=\frac89$, and $S^2\times S^3$ gives $\frac{2\cdot4\cdot1\cdot2}{3\cdot6}=\frac89$. ✓ The odd identification needs $n\ge5$ (§9.2) and gets it. **A collision to flag**: [LEDGER.md](../findings/LEDGER.md) records that $\Theta_5$ carries two values inside [results.md](../results.md), $\sqrt{3/2}$ for the global maximum on $\mathcal W_5$ and $2\sqrt2/3$ for the diagonal one. $\sqrt{8/9}=2\sqrt2/3$ is this theorem's, and the other is not $\Theta$ |
| **odd $n$** | See §5.1 and §11. Steps 1 and 2 parity-free, step 3 parity-blind, the chaining parity-split with both branches exact |
| **$\ker W\ne0$** | **No finding.** Nothing in the chain excludes it. Step 1 needs $\mu>0$, which is free from hollowness; step 2 needs $\mathop{\mathrm{tr}}S^2=2$; step 3 is about $v$, not $S$. A degenerate $S$ passes all three untouched, and the equality case is itself highly degenerate, the balanced two-block vertex matrix has a large kernel |
| **$S=0$** | Excluded by $\mathop{\mathrm{tr}}S^2=2$, and the statement is homogeneous, so $W=0$ satisfies it trivially with both sides zero |

## 11. Pre-registered question 3, F8, step by step

| step | parity status | evidence |
| --- | --- | --- |
| **Step 1** | **parity-free** | The identity $(*)$, the two contractions and the Cauchy–Schwarz contain no integer division and no floor. Nothing in them changes at odd $n$ |
| **Step 2** | **parity-free** | $Z$, membership, orthogonality and $\lvert Z\rvert^2$ are rational functions of $n$ and polynomial in $v$. Parity enters step 2 only through what is later substituted for $\sum v_i^4$ |
| **Step 3** | **parity-blind**, a stronger status than parity-free, and the record says so | Proof I derives **one** formula, $\sum v^4=\frac n{pq}-\frac3n$, and minimises $pq$ over integers. The two constants are that formula at $pq=\frac{n^2}4$ and $pq=\frac{n^2-1}4$. The block's own line: *"It is parity-blind, so it re-proves the even case as a corollary and step 3 becomes one theorem rather than two"* |
| **Chaining** | **parity-split**, and correctly | One substitution made twice; §5.1 carries both, exact |
| **Equality identification** | **parity-split**, both branches on file | Even under step 2's heading, odd under the $(d)$ heading; §9.2 re-derives the odd branch |

**Answer: F8 is refuted for this proof.** The computation the finding was raised against covers even $n$ only; **the proof does not**. [results.md](../results.md)'s *"every step holds at both parities"* is accurate, and the sharper true statement is that only two places in the whole argument know what parity is, the substitution into $\lvert Z\rvert^2$, and which sphere product $Z(v)$ turns out to be.

**One correction to the gloss that travels with it.** *"So the odd case rests on this theorem and on nothing published"* is true and understates the exposure. [Jäger](../references/jaeger-2016-diagonal-case/notes.md)'s Theorem A, read, requires **even $n\ge16$**. So even $n\in\{4,6,8,10,12,14\}$ (which includes both threshold dimensions the whole programme turns on), rests on this theorem and on nothing published, exactly as odd $n$ does. A consumer told only about odd $n$ will assume $n=12$ is covered by the literature. It is not.

## 12. The three forms compared

### 12.1 [problem.md](../findings/problem.md):557–579 against [results.md](../results.md):98 and :268

| | problem.md statement | results.md:98, the glance | results.md:268, the detail |
| --- | --- | --- | --- |
| quantifier | *"for every diagonal $W$ at every $n\ge4$"* | *"every $n\ge4$ and every unit $W$ diagonal in some frame"* | *"$W\in\mathcal W_n$, $n\ge4$, diagonal in some orthonormal frame"* |
| the inequality | $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ | $\theta\le\Theta_n$ | $\langle W,Q(W)\rangle\le\Theta_n$ at $\lVert W\rVert=1$ |
| normalisation | stated in the proof as $\mathop{\mathrm{tr}}S^2=2$, **with the warning** | absent | *"$\lVert M\rVert$ normalised to $\lVert W\rVert=1$"*, **which is the right statement and does not say what $\lVert M\rVert$ then is**; the reader is left to find $\mathop{\mathrm{tr}}M^2=2$ |
| equality | split by parity, $S^{n/2}\times S^{n/2}$ / $S^{\lfloor\rfloor}\times S^{\lceil\rceil}$ | one form, $S^{\lfloor\rfloor}\times S^{\lceil\rceil}$ | *"the Weyl tensor of $S^{\lfloor\rfloor}\times S^{\lceil\rceil}$"*, the best of the three, since it names the *Weyl* tensor |
| status | *"CANDIDATE … Gate 2 owed"*, *"none audited"* | **Lemma**, Gate 1 and Gate 2 passed | **Lemma** |

**These are consistent as mathematics**, the three inequalities are one inequality, the normalisations chain, and no constant differs. **They are not consistent as claims about their own standing**, which is the finding:

- The heading over the argument in [problem.md](../findings/problem.md):259 is *"CANDIDATE: an elementary diagonal theorem at every $n\ge4$, odd $n$ included, **Gate 2 owed**"*, and its first line is *"every step below was rebuilt and screened here (Gate 1 (a)–(d)), **none audited**"*.
- The L57 block's map sends a reader to that section: *"The three steps are stated together under *On the diagonal locus* and chained there"*, and *On the diagonal locus* is the first paragraph **under the CANDIDATE heading**.
- Three hundred lines later the same file says *"So the all-$n$ diagonal theorem is COMPLETE"*.
- [results.md](../results.md) labels it **Lemma**, which its own key defines as *"proven with Gate 1 and Gate 2 passed"*.

**So a consumer following the canonical pointer from [results.md](../results.md), which is the bare `**Proof:** [problem.md](findings/problem.md)`, with no heading and no anchor, lands in a 580-line file, and the first heading over the mathematics declares it an unaudited candidate.** The status has been repaired in two places and left standing in the one place the pointer reaches.

**Two phrases in the detail form have no referent in the proof.** *"the projection of $v\otimes v$ onto the Ricci-flat slice … **whose kernel is explicit**"*, no heading in [problem.md](../findings/problem.md) computes a kernel of $Z$, and the two halves proved under step 2's heading are membership and orthogonality. And *"a fourth-moment lemma, **proved by two independent arguments**"*, one of the two has the gap of §4.2, so the sentence is true of one argument and a sketch. **Both phrases are in the sentence a consumer would quote.**

### 12.2 The Lean form, there is none

**No row for L57 exists in [lean/INDEX.md](../lean/INDEX.md).** The id occurs there exactly once, at line 359, in the bucket *"out, needs machinery Mathlib does not have"*:

> *"**L57**, **L46**, **L47**, **L48**, **L8**, the classification of compact symmetric spaces"*

**That reason is imported from the wrong proof.** The classification of compact symmetric spaces is how **[Jäger](../references/jaeger-2016-diagonal-case/notes.md)** closes the diagonal case, the reference notes say so in terms: *"a closing appeal to the classification of compact symmetric spaces"*. **This proof appeals to no classification.** It is an inequality about hollow symmetric zero-row-sum $n\times n$ matrices, three Cauchy–Schwarz applications and a Lagrange argument, and the only geometry in it is the sentence identifying the extremal matrix. So L57 is bucketed out for an obstruction belonging to the argument it replaces.

**And parts of it are already kernel-checked, under other names.** [Theta0.lean](../lean/HamiltonsCubic/Results/Theta0.lean) proves the constants and their exact rational squares; [BalanceMax.lean](../lean/HamiltonsCubic/Results/BalanceMax.lean) proves *"the most balanced split maximises $\theta^2$"* over $4\le n\le24$, which the row itself calls *"the fact $\theta_0$ and $\Theta_n$ rest on, and which the record never states"*; [DiagonalOdd.lean](../lean/HamiltonsCubic/Results/DiagonalOdd.lean) carries the odd constant. **What a genuine L57 row would have to claim, and none of these does:** for every $S\in\mathcal D_n$ with $\mathop{\mathrm{tr}}S^2=2$ and every $n\ge4$, $\tfrac12\langle S^{\circ2}+S^2,S\rangle\le\Theta_n$, with the $\lvert Z\rvert^2$ identity of §3.3 either proved or listed as **owed**, since without it the constant has no source. That is a formalisation of the *matrix* statement; the further step to $\langle Q(W),W\rangle$ needs §7's translation and would be a second **owed** line.

## 13. The named trap, each citable claim read alone, as a consumer would

*This record's signature failure is a correction landing **beside** the statement it corrects. I read each citable sentence with nothing else in view and asked what a consumer inherits.*

| citable claim, read alone | what a consumer inherits | where the correction actually lives |
| --- | --- | --- |
| *"$\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ for every diagonal $W$ at every $n\ge4$"* | a theorem about all diagonal $W$ | the proof reaches all $W$ only through the bridge at *So the all-$n$ diagonal theorem is COMPLETE*, **not among the five places the block's own map names**, §6 |
| *"with equality exactly at $S^{n/2}\times S^{n/2}$ … "* | attainment and uniqueness, unqualified | the sign is fixed under *Two corrections to what this file recorded*, and $V$ is defined nowhere; §9.3 |
| *"The three steps are stated together under *On the diagonal locus* and chained there"* | a pointer to the proof | that section's own heading says **CANDIDATE … Gate 2 owed … none audited**; §12.1 |
| results.md's *"Three steps, each proved"* | all three discharged | step 2's norm formula is not proved anywhere; §3.3, and the record books it on [LEDGER.md](../findings/LEDGER.md) rather than in the block |
| results.md's *"a fourth-moment lemma, proved by two independent arguments"* | two proofs | one proof and one sketch; §4.2 |
| results.md's *"the odd case rests on this theorem and on nothing published"* | even $n$ is covered by the literature | Jäger covers even $n\ge16$; **$n=12$ and $n=14$ are not published either**; §11 |
| results.md's *"$\lVert M\rVert$ normalised to $\lVert W\rVert=1$"* | a normalisation | the number is $\mathop{\mathrm{tr}}M^2=2$, and the whole $\sqrt2$ warning is in [problem.md](../findings/problem.md) only; §5 |
| lean/INDEX.md's *"L57 … the classification of compact symmetric spaces"* | this proof needs a classification | it needs none; the reason belongs to Jäger's argument; §12.2 |

**Eight citable sentences, and six of them mislead a reader who stops there.** None of the six is wrong about a *number*: every constant in every form is the same and every one of them is correct. **The defect is uniformly one of provenance and standing, never of value**, which is the shape this record was warned about, appearing again at the one result the whole programme's foundation section rests on.

## 14. The gap between what is proven and what is used, and what a consumer may cite

### 14.1 Proven here, under the round's rules

1. **Step 1**, $\lambda\le\frac{n-1}n\mu$, at every $n\ge4$, both parities, for every $S\in\mathcal D_n$ critical for the restricted problem, with the free hypothesis $S\ne0$ made explicit.
2. **Step 2(a) and 2(b)**, hence $\mu=2\langle S,Z(v)\rangle$ and $\mu\le2\lvert Z(v)\rvert$ at $\mathop{\mathrm{tr}}S^2=2$.
3. **Step 3**, the fourth-moment lemma with its equality case, at every $n\ge4$, by one argument that never splits on parity.
4. **The chaining arithmetic**, both constants, given (5).
5. **Attainment** of $\Theta_n$ at the balanced sphere product, and that balance beats every other split, on a read source plus one line of algebra.
6. **Uniqueness** of the equality case, both parities.

### 14.2 Used and not proven

1. **$\lvert Z(v)\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4$**, the single line every constant comes off. On file: five dimensions to $10^{-12}$.
2. **$\mathop{\mathrm{tr}}W^3=\tfrac12\langle M^{\circ2},M\rangle$ and $\langle W,W^\#\rangle=\tfrac12\langle M^2,M\rangle$**, the line that makes the matrix problem the Weyl problem. On file: *"exact at every test point"*.
3. **The constrained-criticality form** $(M^{\circ2}+M^2)_{ij}=\theta M_{ij}+v_i+v_j$, on file as *"fitted jointly … residual $10^{-16}$"*, though its consequence $v=0$ is proved and I checked the mechanism independently in §6.
4. **The domain bijection** $\mathcal D_n\leftrightarrow$ the coordinate-diagonal part of $\mathcal W_n$, asserted in the block; the read [Jäger](../references/jaeger-2016-diagonal-case/notes.md) notes state it, so it rests on a source rather than on nothing.
5. **Step 1's equality clause** at every sphere product, ten products to $10^{-16}$.
6. **Proof II's positivity sub-lemma**, an unexhibited expansion.

### 14.3 What a consumer may cite today

> **For every $n\ge4$ and every $W\in\mathcal W_n$ diagonal in some orthonormal frame, $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$, with $\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}$ at even $n$ and $\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ at odd $n$, and equality exactly at the Weyl tensor of $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$, **conditional on two identities the record verifies numerically and derives nowhere**: step 2's $\lvert Z(v)\rvert^2$ and the diagonal translation of $\mathop{\mathrm{tr}}W^3$ and $\langle W,W^\#\rangle$.**

**A consumer may not cite** *"three steps, each proved"*, *"proved by two independent arguments"*, or any reading under which even $n\le14$ is covered by the literature.

## 15. What would break it, and what I did to look

**The object that would falsify the statement.** A matrix $S\in\mathcal D_n$ with $\mathop{\mathrm{tr}}S^2=2$ and $\tfrac12\langle S^{\circ2}+S^2,S\rangle>\Theta_n$ at some $n\ge4$. There are exactly five places it could hide, and I went to each:

| the hiding place | what I did | outcome |
| --- | --- | --- |
| **a $v$ with $\sum v=0$, $\sum v^2=1$ and $\sum v^4<\frac1n$ (even) or $<\frac{n^2+3}{n(n^2-1)}$ (odd)**, it would break step 3 and with it every constant | re-derived Proof I end to end, including Lemma A by Newton, the LICQ check on the two constraints, and the two-value evaluation $\frac n{pq}-\frac3n$ | **none exists.** The argument is complete and the minimum is attained uniquely up to permutation |
| **a restricted critical point with $\beta\ne0$** in $(S^{\circ2}+S^2)_{ij}=\lambda S_{ij}+\beta_i+\beta_j$, it would put an extra term into step 1's $(*)$ and stop the chain before it starts | computed the row sums of the hollow part of $S^{\circ2}+S^2$ directly: $S^{\circ2}$ contributes $r_i$, $S^2$ contributes $-r_i$ because $S\mathbf1=0$ and $(S^2)_{ii}=r_i$ | **none exists**, identically. [diagonal-half.md](../findings/diagonal-half.md):75 reaches the same conclusion by eliminating the multiplier |
| **a coordinate-diagonal Weyl operator whose vertex matrix has nonzero row sums**, it would put the theorem's domain outside $\mathcal D_n$ | read [Jäger](../references/jaeger-2016-diagonal-case/notes.md)'s setup in [references/](../references/): *"the condition that $W$ is Weyl then reduces to $\sum_iw_{ij}=0$ for all $j$"* | **none exists**, on a read source |
| **an unbalanced split beating the balanced one** | evaluated $(1-\frac1p)(1-\frac1q)=1-\frac{n-1}{pq}$ exactly | **none exists**; the quantity is strictly increasing in $pq$ |
| **a diagonal $W$ at which $\langle Q(W),W\rangle\ne\tfrac12\langle M^{\circ2}+M^2,M\rangle$**, §7's debt, and the only place I could not close | searched [findings/](../findings/) for a derivation and found the identity stated once, at [diagonal-half.md](../findings/diagonal-half.md):428, with *"exact at every test point"*; checked [references/](../references/) for Jäger's diagonal $\#$-formula and found it named in the notes but not transcribed | **open.** It is corroborated from outside, the constant it produces, $\Theta_n$ at the balanced split, equals [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 2.25's independently published $\theta_{k,l}$, but corroboration of a value is not a derivation of an identity |

**What I read.** The L57 block and all four headings its map names; the CANDIDATE section that holds the three steps; the *Two corrections* and *COMPLETE* headings it does not name; [conventions.md](../findings/conventions.md) in full; [diagonal-half.md](../findings/diagonal-half.md)'s criticality, translation and Dirichlet passages; [LEDGER.md](../findings/LEDGER.md)'s two open obligations on this result; [results.md](../results.md):98 and :268; [lean/INDEX.md](../lean/INDEX.md); and the notes for [Jäger](../references/jaeger-2016-diagonal-case/notes.md) and [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md). **I ran no script and computed no number numerically**; every value above is an exact hand evaluation, and the one hand expansion I performed (§3.3) is reported as a screen on my own verdict rather than as the record's evidence.

**Reviewer reports I could not read.** The block cites [r123](../reviews/INDEX.md) and [r124](../reviews/INDEX.md) for step 3's Gate 2, both citations point at an index rather than at a report, so there is no report at those addresses to read. Proof I is reproduced in full in the block itself, so nothing is lost there; Proof II's sub-lemma is not, which is why §4.2 stands at GAP.

## 16. Verdict

**HYPOTHESIS-DEBT.**

**Everything the block writes out is correct.** I re-derived step 1, both proved halves of step 2, step 3's Proof I with its equality case, the chaining at both parities, the attainment formula and its monotonicity, and the odd equality case's three $Z$ values and two ratios, all exactly, all reproducing. On the mathematics, this is the strongest block I have read in this record: the argument is short, it is elementary, it is genuinely parity-blind at the one step where parity was in doubt, and F8 is refuted by it.

**Two identities carry the whole result and neither has a derivation anywhere.**

1. **$\lvert Z(v)\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4$.** Every constant in $\Theta_n$ comes off this line. On file: *"verified to $10^{-12}$ at $n=6,7,8,11,12$"*. **What must be shown:** the expansion of $\sum_{i<j}Z_{ij}^2$ under $\sum v=0$, $\sum v^2=1$, the contractions needed are $\sum_{i\ne j}v_i^2v_j^2=1-m_4$, $\sum_{i\ne j}v_i^3v_j=-m_4$ and $\sum_{i\ne j}v_iv_j=-1$.
2. **$\mathop{\mathrm{tr}}W^3=\tfrac12\langle M^{\circ2},M\rangle$ and $\langle W,W^\#\rangle=\tfrac12\langle M^2,M\rangle$** for coordinate-diagonal $W$. Without them the three steps bound a matrix functional that has not been shown to be $\langle Q(W),W\rangle$. On file: *"exact at every test point"*. **What must be shown:** the $\#$-computation on the coordinate-diagonal locus, from the definition of $\#$. Unlike (1), this one is **not** on [LEDGER.md](../findings/LEDGER.md).

**And the block's own map omits the sentence that answers its own quantifier.** The bridge from a critical point to every diagonal $W$ exists, is correct, and is not among the five places the map calls *"the whole map"*. The repair is one heading name.

**The half of Problem P the problem statement grants is, on this record, granted conditionally on two numerically-verified identities.** Both are short computations. Until they are written, the honest citation is §14.3's.
