# Review r455, Lemma L150, the four-set half of the isolation clause

*Adversarial audit, cold brief, 2026-09-03. Target: [Lemma L150](../findings/second-order.md) in [findings/second-order.md](../findings/second-order.md). Analysis-only footing observed: the only computation is a screen of claims recorded below, on objects built from Ricci-flatness and normalisation alone and validated against three independent record values before any conclusion was drawn from it.*

## Verdict

**REFUTED**, as the named input for [I18](../plan.md).

**The inequality chain is correct in every step and the normalisation is clean. What is refuted is the statement the chain reduces to.** The concentration bound is **false under the full hypothesis set the item allows**, hollowness, zero row sums, purity, criticality, $n\ge12$ and $\theta\ge\sqrt{3/2}$ all hold at an explicit counterexample. So [plan.md](../plan.md)'s "**UNBLOCKED 2026-09-03**, [Lemma L150](../findings/second-order.md) names the input" is wrong: the input named cannot be proved, and I18's four-set clause is still blocked.

| claim | verdict |
| --- | --- |
| $\Sigma=\tfrac12(3S_2-S_1^2)$ | CONFIRMED |
| $\Sigma\le\tfrac32S_2$, equality exactly at $S_1=0$ | CONFIRMED |
| $\tfrac32S_2\le3\sum_{\{a,b\}\subset S}M_{ab}^2$ | CONFIRMED |
| both non-identity steps tight simultaneously; the witness is hollow with zero row sums | CONFIRMED |
| the normalisation, and that $\tfrac12$ is genuinely *half* the Frobenius mass | CONFIRMED, no factor $2$ |
| the $L_M\to L_e$ translation, i.e. the clause is $\Sigma=\theta^2$ | CONFIRMED, no factor $4$ |
| the reduction is non-vacuous at the conjectured maximiser | CONFIRMED |
| "[Lemma L24](../findings/second-order.md) already gives $\Sigma\le\theta^2$ … so the whole content is strictness" | **REFUTED** |
| "This uses only $\lVert M\rVert\le\lVert W\rVert=1$ ([I11](../plan.md))" | **REFUTED as a citation** |
| **"it suffices that no four indices carry half the Frobenius mass", as the input for [I18](../plan.md)** | **REFUTED** |

## F1, the reduction target is false at a pure critical point in the band

**$S^5\times S^{43}$ at $n=48$ is a pure critical point with $\theta^2=1.596764\ge\tfrac32$ whose four-subset $\{1,2,3,4\}\subset S^5$ carries $0.501203$ of the Frobenius mass.** Along the family $S^5\times S^q$ as $q\to\infty$, $\theta^2\to\tfrac85$ and the four-set concentration $\to\tfrac35$. Every counterexample hypothesis of the item is met: the point is diagonal (hence pure), critical, hollow with zero row sums, $n\ge12$, and strictly inside the band.

**The exact objects.** With $\gamma$ the cross-factor sectional entry, Ricci-flatness gives $\alpha=-q\gamma/(p-1)$ within $S^p$ and $\beta=-p\gamma/(q-1)$ within $S^q$; normalising $\sum_{a<b}M_{ab}^2=1$ fixes

$$\gamma^2=\Big(pq\Big[\tfrac q{2(p-1)}+\tfrac p{2(q-1)}+1\Big]\Big)^{-1},\qquad \theta^2=(n-1)^2\gamma^2 .$$

At $p=5$, $q\to\infty$ this gives $\theta^2\to 2(p-1)/p=\tfrac85$, and the six pairs inside a four-subset of the $S^5$ factor carry $6\alpha^2=6q^2\gamma^2/16\to 12/(p(p-1))=\tfrac35$.

**Nothing unspent can rescue it.** L150 says the bound "is false without further input … so the zero row sums and $n\ge12$ must enter where they have not yet". They are already in, at this point, and the bound is still false. There is no further input the item permits.

**And the failure is anti-aligned with the target.** The offending four-subsets are the *within-factor* ones, where $M_{ij}=M_{ik}=\dots=\alpha$, so $A=B=C=2\alpha$ and

$$\Sigma=3(2\alpha)^2-3(2\alpha)^2=0 .$$

**The four-sets that break the concentration hypothesis are exactly the four-sets where $\Sigma$ is smallest.** The $(2,2)$-split four-sets (the only ones with $\Sigma\ne0$ at a two-factor point), hold about $0.098$ of the mass along the same family, an order of magnitude inside the threshold. So the reduction discards precisely the structure that makes the clause true.

**Where the loss enters, and it is step 2, not step 3.** At a within-factor four-set, $S_2=12\alpha^2$ and $S_1=6\alpha$, so $3S_2=36\alpha^2=S_1^2$ and the whole of $\Sigma$ is the cancellation that $\Sigma\le\tfrac32S_2$ throws away. Step 3 is *tight* there ($A^2=2(M_{ij}^2+M_{kl}^2)$ exactly, all six entries being equal). The chain's fatal step is the one L150 calls harmless.

## F2, a repair that survives the family

**Keep $S_1$.** $\Sigma<\theta^2$ is $3S_2-S_1^2<2\theta^2$; with $S_2\le2\sigma_S$ for $\sigma_S=\sum_{\{a,b\}\subset S}M_{ab}^2$ it suffices that

$$6\,\sigma_S-S_1(S)^2\;<\;2\theta^2\qquad\text{at every }4\text{-subset }S,\qquad S_1(S)=\!\!\sum_{\{a,b\}\subset S}\!\!M_{ab}.$$

At the $n=48$ counterexample this reads $3.007<3.194$ and passes; screened over every four-set type of every in-band two-factor sphere product to $n=600$, it has **no violation**, with the tightest margin $-2.17$. It is still a concentration-type statement about $M$ alone, still uses only hollowness, zero row sums and the value hypothesis, and it is the form [I18](../plan.md)(c) should carry in place of the present one. *It is a screen, not a theorem: it says the repaired target is not falsified where the present one is.*

## F3, "the whole content is strictness" is false for I18's hypothesis class

L150 opens under the heading *What is owed at a pure critical point* and then writes that [Lemma L24](../findings/second-order.md) "already gives $\Sigma\le\theta^2$ at every maximiser, so **the whole content is strictness**". **[I18](../plan.md) quantifies over pure *critical* points, not maximisers, and $\Sigma\le\theta^2$ fails there.** At $S^2\times S^4$, which the record carries as pure, critical and Morse–Bott nondegenerate, $\Sigma=\tfrac53$ against $\theta^2=\tfrac{15}{16}$, the value $\mu_{2,4}=\tfrac23>\tfrac12$ that [Lemma L126](../findings/second-order.md) prints by name. The record already says this in the box at [second-order.md](../findings/second-order.md) beginning *"THE INEQUALITIES IN (ii) ARE EXCLUSIONS OF $\tfrac12$, NOT STRICT BOUNDS"*, four hundred lines above L150.

**Why it matters beyond wording.** The sentence tells a reader that half the work is in hand and only strictness is owed, so a weaker concentration statement (one delivering $\ne$ rather than $<$), would look sufficient. It would not be. The lemma's own displayed condition is two-sided and never invokes L24, so **the deduction is unharmed**; what is harmed is the account of the difficulty, and that account is what got I18 marked unblocked.

## F4, the I11 citation is to an open item, and the fact is already closed

L150 says the reduction "uses only $\lVert M\rVert\le\lVert W\rVert=1$ ([I11](../plan.md))". **[I11](../plan.md) is an unchecked plan item** whose frame-search half is itself blocked. It is also unnecessary: at a pure critical point $W$ is diagonal in its own eigenframe, and there [conventions.md](../findings/conventions.md)'s vertex-matrix block gives the *equality*

$$\sum_{a<b}M_{ab}^2=\lVert\mathop{\mathrm{diag}}W\rVert^2=\lVert W\rVert^2=1,$$

Cauchy–Schwarz being saturated exactly at diagonality, the same normalisation [diagonal-half.md](../findings/diagonal-half.md) states as $\mathop{\mathrm{tr}}M^2=2$ over ordered pairs. **Cite the closed identity, not the open item.** *Mathematically harmless; a provenance defect that makes the lemma read as resting on unproved work when it rests on proved work.*

## F5, the norm attack finds nothing, and the "half" is genuinely half

The brief's primary suspicion does not hold up. Three readings were separated and the record is consistent across all of them.

- **The threshold.** The final step needs $\theta^2>\tfrac32$ against $3\sigma_S$, so $\sigma_S<\tfrac12$; the total is $\sum_{a<b}M_{ab}^2=1$ exactly at a unit-norm pure critical point. **Half, not a quarter and not all.**
- **The ordered/unordered trap** flagged in [conventions.md](../findings/conventions.md) does not bite, because both the four-set sum and the total are unordered in L150's display and the ratio is normalisation-free.
- **The $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ pairing** enters at the $\Lambda^2$ level, where the pair basis is orthonormal, so the sectional entries *are* the $\Lambda^2$ eigenvalues on the diagonal locus and no half survives into the display.

**Independent confirmation.** Building $M$ from Ricci-flatness alone and taking $\theta$ from [diagonal-half.md](../findings/diagonal-half.md)'s closed form $\theta=\tfrac12(\sum_{a,b}M_{ab}^3+\mathop{\mathrm{tr}}M^3)$, using nothing from L150 or [Lemma L121](../findings/second-order.md), reproduces $\theta_0(6)^2=\tfrac{10}9$ and $\theta_0(12)^2=\tfrac{2\cdot11\cdot10}{144}$ exactly.

## F6, the eigenvalue translation carries no stray factor

[Lemma L121](../findings/second-order.md)'s block of $L_M$ has spectrum $\pm\tfrac12\sqrt\Sigma$, and $L_e=L_M/\theta$, so the $L_e$ block spectrum is $\pm\sqrt\Sigma/(2\theta)$ and the excluded value $\tfrac12$ is reached exactly at $\Sigma=\theta^2$. **Not $4\theta^2$, and no factor elsewhere.** Confirmed twice against the record from the independently built matrices: $\Sigma=\theta^2=\tfrac{10}9$ at the nine $(2,2)$-split four-sets of $S^3\times S^3$, and $\sqrt{\Sigma/(4\theta^2)}=\tfrac23=\mu_{2,4}$ at $S^2\times S^4$.

## F7, the tightness claims are right, and the two live steps are simultaneously tight

$\Sigma-\tfrac32S_2=-\tfrac12S_1^2$, so step 2 is equality exactly at $S_1=0$; step 3 is equality exactly when $M_{ij}=M_{kl}$, $M_{ik}=M_{jl}$, $M_{il}=M_{jk}$. **Both hold together** on $M_{ij}=M_{kl}=a$, $M_{ik}=M_{jl}=b$, $M_{il}=M_{jk}=c$ with $a+b+c=0$, and that matrix is hollow with every row sum $a+b+c=0$, so L150's counterexample note is exact. At unit norm it has $\Sigma=3$ against the four-supported maximum $\theta^2=\tfrac32$ recorded elsewhere in the file, so it saturates the chain while satisfying $\Sigma\ne\theta^2$: **it breaks the route, not the clause.** That is the same pattern as F1, in miniature.

## F8, the reduction is not vacuous at the conjectured maximiser

The brief's vacuity test passes. At $S^m\times S^m$ a $(2,2)$-split four-set carries $\dfrac{2m^2+4(m-1)^2}{m^2(2m-1)(m-1)}$ of the mass, $0.109$ at $n=12$, $0.035$ at $n=20$, $O(m^{-2})$, far inside the threshold. The record's $\Sigma=\theta^2$ at $S^3\times S^3$ is no obstruction either: $\theta_0(6)^2=\tfrac{10}9<\tfrac32$, so that point is **below the band** and outside I18's scope. **The reduction dies at $S^5\times S^q$, not at the maximiser.**

## What the record should do

- **Revert [plan.md](../plan.md)'s I18 to blocked** and strike "UNBLOCKED 2026-09-03, Lemma L150 names the input", together with the copied gloss "*no four indices carry half the Frobenius mass of $M$*".
- **Keep L150's chain, restate its use.** The identity and both inequalities are correct and worth having; what must go is the sufficient condition built on them and the claim that it is I18's missing input.
- **Record the counterexample as a fence post**: any four-set criterion that drops $S_1$ is falsified at $S^5\times S^q$ for $q\ge43$, and the within-factor four-sets are where it dies.
- **Fix the two prose defects**, the maximiser/critical-point conflation of F3 and the [I11](../plan.md) citation of F4.

## Method note

The screen built $M$ from the Ricci-flatness relations, checked hollowness, symmetry, zero row sums and $\mathop{\mathrm{tr}}M^2=2$ **before** computing anything, took $\theta$ from a closed form in a different file, and **verified criticality independently** from $Q(W)_{ab,ab}=M_{ab}^2+(M^2)_{ab}$, three equations, $\theta=(p-1)(\alpha-\gamma)=(q-1)(\beta-\gamma)=\gamma+(p-1)\alpha+(q-1)\beta$, all equal to $-(n-1)$ at $\gamma=1$, exactly in rationals. It reproduced three record values it was not built from before it was believed, and the counterexample was then confirmed in exact rational arithmetic.
