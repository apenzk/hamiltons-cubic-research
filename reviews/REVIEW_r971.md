# Review r971: is every directional lever contained in batch 21, and does that exhaust R28?

Gate 2, reviewer r971. Log: [agent_logs/r971-completeness.log](../agent_logs/r971-completeness.log).

Worked from the brief's definitions alone. The working note the block was drawn from was not read, and no other reviewer's report was read. [I106Criticality.lean](../lean/HamiltonsCubic/Results/I106Criticality.lean) was read after the mathematics below was derived, to check the brief's declaration table.

## Verdicts

| # | claim | kind | verdict |
|---|---|---|---|
| 1 | Batch 21's condition holds for ALL traceless symmetric tangent $(X,Y)$, along any curve, with no acceleration term | mathematics | **CONFIRMED**, on a hypothesis the block does not name |
| 2 | A lever that picks a tangent direction and computes the second variation along it is batch 21 evaluated at that direction | mathematics | **CONFIRMED**, and it is a tautology that does not support the block's headline |
| 3 | Hence such a lever is implied by batch 21 and excludes nothing batch 21 does not | mathematics | **CONFIRMED** for second-variation levers, **REFUTED** for directional levers |
| 4 | The orbit, the frame variation and the radial trade are each such a direction | mathematics | **CONFIRMED** |
| 5 | The first-order side is empty: each stationarity condition collapses to an identity under the Lagrange forms | mathematics | **CONFIRMED**, forced in advance, and the count of six is one identity read six ways |
| 6 | R28 excludes an interior tangency by first and second order, and both are directional | about a method | **PLAUSIBLE** as a description, and it undercounts the local orders exactly at a tangency |
| 7 | Therefore R28's mechanism is spent among directional levers | about a method | **REFUTED**. The block is right that this is a judgement and wrong in the judgement |
| 8 | The value comparison is non-directional and untouched by claims 1 to 5 | mixed | **CONFIRMED** in its weak half, **REFUTED** in "nothing above touches it" |

**The headline of the block, "every DIRECTIONAL lever is contained in batch 21", is false.** The sentence it is refined into (claim 2) is true and is a tautology. The two are not the same statement, and the headline is the one that will be cited.

## A lever of a fourth shape: the great circle at finite amplitude

Write $p=(\hat U,V)$, $\Psi=\alpha\operatorname{tr}\hat U^3+\beta\operatorname{tr}(\hat UV^2)$ for the cubic part, and use the metric $\langle(X,Y),(X',Y')\rangle=3\operatorname{tr}(XX')+\operatorname{tr}(YY')$, in which $T=\tfrac12\lVert p\rVert^2$ and the constraint surface is the sphere of radius $r=\sqrt{2T}$. Fix a tangent $Z=(X,Y)$ normalised to $\lVert Z\rVert=r$, that is $3\lvert X\rvert^2+\lvert Y\rvert^2=2T$, and let $\gamma(\theta)=\cos\theta\,p+\sin\theta\,Z$, the great circle through $p$ in that direction. Put

- $Q(Z)=6\alpha\operatorname{tr}(\hat UX^2)+4\beta\operatorname{tr}(XVY)+2\beta\operatorname{tr}(\hat UY^2)-\mu(3\lvert X\rvert^2+\lvert Y\rvert^2)$, batch 21's expression,
- $S(Z)=3\alpha\operatorname{tr}(\hat U^2X)+\beta\operatorname{tr}(V^2X)+2\beta\operatorname{tr}(\hat UVY)$, which is $D\Psi(p)[Z]$ and equals $-(\langle A,X\rangle+\langle C,Y\rangle)$,
- $\Xi(Z)=\alpha\operatorname{tr}X^3+\beta\operatorname{tr}(XY^2)$, the cubic part evaluated at the direction itself.

Then, at any critical point with the given Lagrange fields, with $c=\cos\theta$ and $s=\sin\theta$:

$$\Phi(\gamma(\theta))-\Phi(p)\;=\;-\tfrac12\Phi(p)\,(c-1)^2(c+2)\;+\;\tfrac12\,c\,s^2\,Q(Z)\;+\;s^3\big(\Xi(Z)-S(Z)\big).$$

This is exact, not a truncation. It is three terms because $\Phi$ is a cubic polynomial plus a linear one and the circle is a trigonometric curve of degree three, and the coefficients collapse to these three because $D\Phi(p)[Z]=0$ on tangents and $\Phi(p)=2\mu T-2\Psi(p)$, which is [value_at_critical](../lean/HamiltonsCubic/Results/I106Criticality.lean). Derived by hand, then screened against four independently constructed critical points at 41 angles each: residual $2\times10^{-14}$.

**What the identity says about the block's two shapes.** They are two coefficients of it.

| where you look | what the condition is |
|---|---|
| $\theta^2$ | $Q(Z)\le0$, which is batch 21 |
| $\theta^3$, where $Q(Z)=0$ | $\Xi(Z)-S(Z)=0$, a lever nothing on the record has used |
| $\theta^4$, where $Q(Z)=0$ and $\Xi(Z)=S(Z)$ | $-\tfrac38\Phi(p)\le0$, that is $\Phi(p)\ge0$ |
| $c=-1$ | $\Phi(-p)\le\Phi(p)$, the antipodal value comparison, which is again $\Phi(p)\ge0$ |
| a general $c$ | $\Phi(q)\le\Phi(p)$ for the $q$ at that angle, and every $q$ on the sphere lies on a great circle through $p$, so batch 29's comparison is a member of this family |

So the directional side and the value comparison are not two mechanisms. They are the low-order and the finite-amplitude readings of one identity, and the order-four condition at a degenerate direction is literally a value condition.

**The order-three lever is the one to take.** It is an equality rather than a bound, and it contains no $\mu$ at all, so it escapes the sign obstruction that [batch21_gives_lower_bound](../lean/HamiltonsCubic/Results/I106Criticality.lean) records. Stated as a necessary condition at a local maximum:

> for every tangent $Z$ at which batch 21 holds with equality, $\alpha\operatorname{tr}X^3+\beta\operatorname{tr}(XY^2)=3\alpha\operatorname{tr}(\hat U^2X)+\beta\operatorname{tr}(V^2X)+2\beta\operatorname{tr}(\hat UVY)$, under the normalisation $3\lvert X\rvert^2+\lvert Y\rvert^2=2T$.

$\mu$ enters only in choosing the direction, through $\mu=\lambda_{\max}$ of $D^2\Psi$ on the tangent space, and leaves the condition itself.

**It is logically independent of batch 21, by construction.** Any $\mu$ makes a given $(\hat U,V)$ critical, since the fields are defined from $\mu$. Take $\mu=\lambda_{\max}(D^2\Psi\vert_{\text{tangent}})$. Then $Q\le0$ at every tangent direction, with equality at the top eigenvector $Z^\ast$, so criticality and batch 21 are satisfied in full and exclude nothing. At four such points the order-three coefficient came out at $-20.03$, $-0.82$, $+5.73$ and $-1.03$, and $\Phi$ rises along $\gamma$ on one side of $\theta=0$ in every one of them, matching $R_3\theta^3-\tfrac38\Phi(p)\theta^4$ to four digits. **These points pass every condition the block says exhausts the directional family and are not local maxima.** That is claim 3 refuted for directional levers, and claim 7 with it.

**What I am not claiming.** Whether the degenerate case $\mu=\lambda_{\max}$ is populated at the programme's own candidate points is unresolved here. Deciding it is a search over a family with no bound I can state in advance, so under the analysis-only footing I name it and stop rather than open it. The finding is the independence, which is a logical statement and is established, plus the observation that the degenerate case is exactly the case the phrase "interior tangency" picks out.

## Claim by claim

**Claim 1, CONFIRMED, and the block states the right reason without naming what it needs.** The acceleration drops because $D(\Phi-\mu T)$ vanishes on the whole ambient space of traceless symmetric pairs, not merely on the tangent space. That is what the given Lagrange fields supply, and it is the load-bearing hypothesis: from $D(\Phi\vert_S)=0$ alone the term $Df[\gamma'']$ survives through the normal component. The quantifier is genuine, since the constraint surface is a sphere in the metric above, its tangent space at $p\ne0$ is exactly $\{3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)=0\}$, and every tangent vector is some great circle's velocity. The expansion itself is right: I recomputed all four coefficients, and $\operatorname{tr}(X\{V,Y\})=2\operatorname{tr}(XVY)$ needs $X$, $V$, $Y$ symmetric, which is the same hypothesis [second_variation_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean) uses. **The one condition worth writing down: the ambient must be the full traceless symmetric pair space.** If the real domain is a proper submanifold, a realizability locus for the orthostochastic data say, the quantifier shrinks to that submanifold's tangent space and the block's "for all traceless symmetric $X,Y$" is false. Nothing in the given suggests it is, so the claim stands as given, and the hypothesis matters for claims 6 and 7 where the result is carried over to R28.

**Claim 2, CONFIRMED and empty.** "A lever that computes the second variation along a direction computes the second variation along that direction" is true by inspection. The brief asks whether a directional lever could compute something else, and it can: the third-order coefficient, the fourth, or the value at finite amplitude, all of them attached to a chosen direction and none of them inside batch 21. So the refined sentence is safe and the headline it is offered as a proof of is not.

**Claim 3, split.** For a lever that computes the second variation, the implication is immediate and the claim holds. For directional levers in general it is false, by the construction above. One further remark on the true half: "excludes nothing batch 21 does not" is an implication in the logical order and not a saving of work, because batch 21's content is a supremum over all directions and a particular direction is how anyone ever evaluates it. A redundant instance still tells you what the supremum is at one place.

**Claim 4, CONFIRMED, all three.** The orbit: $3\operatorname{tr}(\hat U[\Omega,\hat U])+\operatorname{tr}(V[\Omega,V])=0$ term by term by cyclicity, and $[\Omega,\hat U]$ is symmetric and traceless when $\Omega$ is skew and $\hat U$ symmetric. The radial trade: tangency is $3\lambda\lvert\hat U\rvert^2+\kappa\lvert V\rvert^2=0$, which is the stated hypothesis exactly. The frame variation: with $X=0$ the tangency form reads $\operatorname{tr}(V[\Omega,V])$, which vanishes by cyclicity. **The brief's warning that $\operatorname{tr}(\hat U[\Omega,V])$ is not obviously zero is a trap, and it is a fair one: that trace never enters the tangency condition**, which pairs $\hat U$ with $X$ and $V$ with $Y$, and $X=0$ here. It does appear elsewhere, in the first-order variation of $\beta\operatorname{tr}(\hat UV^2)$, and it is not zero there.

**Claim 5, CONFIRMED, and the record should say why rather than count instances.** Every first-order condition on the list is the ambient stationarity equation contracted against some direction, and that equation is an identity in $(\hat U,V,\mu)$ once $A$ and $C$ are replaced by their own forms, for every direction at once and not only for the tangent ones. So the outcome of post F69's test is fixed before the test is run for any member of that family, and six instances are one identity read six ways. Confirming a claim is right and reporting six independent confirmations of it is not. **One correction to the wording**: "the first-order side is empty" is too strong if it is read as no further first-order work being possible. The record's own batch 30 and 31 extract non-vacuous content from the same two equations by commuting rather than contracting, and [K_zero_of_field_commutes](../lean/HamiltonsCubic/Results/I106Criticality.lean) is an exclusion that comes from first order once an independent hypothesis is in hand. What is empty is first order as a source of conditions on $(\hat U,V)$ alone.

**Claim 6, PLAUSIBLE as a description of R28, with a real gap.** That first and second order are both directional is fine. That they are what a tangency argument has available is not. **A tangency is the case where the second order is inconclusive**, so an argument reaching one has arrived precisely where the next lever is order three, then order four. Calling the pair "first and second order" is accurate about what R28 used and inaccurate as a census of the local orders, and the inaccuracy falls exactly on the case named.

**Claim 7, REFUTED, and the block's own framing is what let it through.** The block is right that "the mechanism has no other lever" is a claim about a method rather than a theorem, and right to mark it. But unprovable is not unfalsifiable: exhibiting one unused lever settles it, and the order-three condition is one. It is directional, it is not implied by batch 21, it is not a value comparison, and it bites at the tangency R28 is trying to exclude. So the mechanism is not spent. **The line between theorem and judgement is drawn in the right place and the judgement on the far side of it is wrong**, which is the more useful way for a block to be wrong, since the marking is what made the claim checkable in one round.

**Claim 8, split.** The weak half is right, and the record already has a better reason for it than the block gives. Batch 21 rearranges to $\mu\ge\cdot$ at every direction because the coefficient $3\lvert X\rvert^2+\lvert Y\rvert^2$ is positive at every nonzero direction, so no specialisation of it yields the upper bound on $\mu$ that an exclusion by value needs. That is [batch21_gives_lower_bound](../lean/HamiltonsCubic/Results/I106Criticality.lean) with [value_at_critical](../lean/HamiltonsCubic/Results/I106Criticality.lean), and it is sharper than "it is not a local condition at all". I can extend it: the $\mu$-coefficient of $\Phi(\gamma(\theta))-\Phi(p)$ in the identity above is $2T(\cos\theta-1)\le0$ at every direction and every amplitude, so the whole great-circle family to all orders reads $\mu\ge\cdot$, screened at $10^{-15}$. **The strong half, "nothing above touches it", is false.** The comparison is the $c=-1$ and general-$c$ reading of the same identity whose $c\to1$ expansion is batch 21, and at a degenerate direction the order-four directional condition is $\Phi(p)\ge0$, a value statement obtained from derivatives alone. The two escapes are one object at two amplitudes.

## Corrections to the Lean table

- **Row 8 understates what is typed.** "A statement about a method, not an identity" is wrong about the substantive half: the reason the comparison is out of reach is the sign of $3\lvert X\rvert^2+\lvert Y\rvert^2$, and that is already [batch21_gives_lower_bound](../lean/HamiltonsCubic/Results/I106Criticality.lean) plus [value_at_critical](../lean/HamiltonsCubic/Results/I106Criticality.lean).
- **Row 1's reason is right and its hypothesis is misidentified.** The base layer cannot carry the quantifier over curves, true. What the quoted step needs is ambient stationarity, which is typeable at fixed $(X,Y)$ and is not tangency.
- **The great-circle identity is typeable now, at the same level as its neighbours.** State it at fixed entries with $c$, $s$ and $c^2+s^2=1$ as reals, every trace written out. It is a polynomial identity and should close by `simp [Vm, Matrix.trace_fin_three]` then `ring`, needing no symmetry beyond the $\operatorname{tr}(\hat UYV)=\operatorname{tr}(\hat UVY)$ that [second_variation_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean) already carries. Suggested name, `great_circle_expansion`, with the order-three condition as a corollary at $Q=0$.

## Standing rules

Analysis only, observed. Everything numerical here is seconds of compute on objects constructed in the scratchpad from the brief's definitions, with nothing imported from the repository. The great-circle identity and the $\mu$-coefficient are analytic results derived by hand, with the runs confirming them at $10^{-14}$. The independence of the order-three lever is a construction with its verification, not a search. The one item that would need an open-ended run, whether the degenerate case is populated at the programme's candidate points, is named and left unopened.
