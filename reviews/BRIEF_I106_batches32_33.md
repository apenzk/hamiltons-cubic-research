# Gate 2 brief: batches 32 and 33 of the I106 derivation, and post F69

You are auditing two blocks of a research record, and one fence post drawn from the first. **Work from the definitions below and from your own derivations. Do not import the code under review.** Your job is to break the claims.

## The standing rule you inherit

**This programme is on an analysis-only footing.** A long or open-ended run (a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts, a falsifier hunt with no bound on where it looks) is not yours to open. What is permitted: **screening a claim you are about to record**, and any run that finishes in a few minutes on objects already in hand. Where a number is needed to refute a claim, compute the smallest one that does the job and say why an argument could not replace it.

## The setting, in full

Real symmetric traceless $3\times3$ matrices $\hat U$ and $V$. Write $\{X,Y\}=XY+YX$, $[X,Y]=XY-YX$, $K=[\hat U,V]$, and $\langle X,Y\rangle=\operatorname{tr}(X^{\mathsf T}Y)$, $\lvert X\rvert^2=\langle X,X\rangle$.

$$\Phi=\alpha\operatorname{tr}\hat U^3+\beta\operatorname{tr}(\hat UV^2)+\langle\hat U,A\rangle+\langle V,C\rangle,\qquad \alpha=\tfrac{15}4,\quad\beta=\tfrac94,$$

maximised subject to $T=\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2$ fixed, with $A$ and $C$ fixed real symmetric matrices, both diagonal in one frame $F$.

**Given (batch 10).** At a critical point with multiplier $\mu$, $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$ and $C\equiv\mu V-\beta\{\hat U,V\}$, each **up to an added multiple of the identity**.

**Given (batch 7), quoted verbatim.** *"For fixed $V$, $\sup_{\hat U}\Phi=\psi(\beta V^2+A)+\operatorname{tr}(VC)$, and the supremum is attained at $\hat U$ commuting with $\beta V^2+A$, diagonal in any eigenframe of it."* Here $\psi(M)=\sup\{\alpha\operatorname{tr}U^3+\operatorname{tr}(UM):U\text{ traceless symmetric},\lvert U\rvert=p\}$, convex and $O(3)$-invariant.

**Given (batch 18).** At every global maximum, $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6$.

**Given (batch 21), quoted verbatim.** *"At a critical point the first differential of $\Phi-\mu T$ vanishes, so along any curve on the constraint surface the second derivative is $D^2(\Phi-\mu T)$ applied to the tangent vector alone, with no contribution from the curve's acceleration. Hence at every local maximum, for all traceless symmetric $X,Y$ with $3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)=0$,*
$$6\alpha\operatorname{tr}(\hat UX^2)+4\beta\operatorname{tr}(XVY)+2\beta\operatorname{tr}(\hat UY^2)\ \le\ \mu\big(3\lvert X\rvert^2+\lvert Y\rvert^2\big).$$
*Setting $Y=0$ and $X=E_{ij}+E_{ji}$ ... gives $\mu\ge-\alpha u_k$ at every $k$, so $\mu\ge\alpha\lvert u_{\min}\rvert$."* Batch 21 also records that this bound and batch 18's are **incomparable**, neither dominating: at $u=(1,1,-2)$ they are $7.5$ and $4.5$, at $u=(2,-1,-1)$ they are $3.75$ and $4.5$.

**Given (batch 29).** Eliminating $a_1,a_2$ from the criticality system at $w_3=0$, $w_1=w_2$ leaves a quadratic in $\mu$ with, writing $u_3=-u_1-u_2$, $D_1=u_2-u_3$, $D_2=u_1-u_3$:
$$c_2=-16u_3D_1D_2,\qquad c_1=32D_1D_2(4u_1^2+7u_1u_2+4u_2^2),\qquad c_0=-9u_3(u_1^2+u_1u_2+u_2^2)(40u_1^2+100u_1u_2+40u_2^2+9).$$
Batch 28 records that at $w_3=0$, $w_1=w_2$ the $(1,2)$ equation reduces to $a_1D_2=a_2D_1$.

**Given (batch 16).** In $\hat U$'s eigenframe, $V$ has diagonal $(a_1,a_2,a_3)$ and off-diagonal entries $w_k$ opposite index $k$.

## Block one, batch 32, quoted verbatim from the record

> ## Batch 32, the obvious maximality input is vacuous, screened before a cycle was spent on it
>
> **What the new target needs.** Batch 30's equivalence is first-order plus batch 18's bound, so closing $[\hat U,C]=0$ at every global maximum needs an input that sees maximality rather than criticality. **Batch 7 appears to supply one**: for fixed $V$, $\sup_{\hat U}\Phi=\psi(\beta V^2+A)+\operatorname{tr}(VC)$, the supremum attained at $\hat U$ commuting with $\beta V^2+A$, so a maximiser satisfies $[\hat U,\beta V^2+A]=0$.
>
> **It carries no information, because criticality already forces it.** The $A$ Lagrange form is $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$, and $\hat U$ commutes with $3\mu\hat U-3\alpha\hat U^2$, so
> $$[\hat U,\beta V^2+A]=\beta[\hat U,V^2]+[\hat U,A]=\beta\{V,K\}-\beta\{V,K\}=0$$
> at **every** critical point, using $[\hat U,V^2]=\{V,K\}$. **So the condition is an identity rather than a constraint**, and a cycle reading it as the maximality input would have derived nothing.
>
> **The same test applies to any maximality condition phrased in $A$ or $C$**: substitute the Lagrange form before counting it as an input, since the fields are defined by the criticality equations and a condition on them can be criticality wearing a different coat.

**Post F69** states that test as a fence post, with *"a genuine maximality input must see the second variation or the value"* as what a successor must clear.

## Block two, batch 33, quoted verbatim from the record

> **The direction batch 21 asked for.** The simultaneous conjugation $(\hat U,V)\mapsto(g\hat Ug^{\mathsf T},gVg^{\mathsf T})$ supplies a joint direction for free: it preserves $\lvert\hat U\rvert$, $\lvert V\rvert$ and the internal part $\alpha\operatorname{tr}\hat U^3+\beta\operatorname{tr}(\hat UV^2)$, so the whole curve lies in the constraint set and $\Phi$ varies along it only through $\langle\hat U,A\rangle+\langle V,C\rangle$. The tangent is $X=[\Omega,\hat U]$, $Y=[\Omega,V]$ for skew $\Omega$, which is traceless symmetric and satisfies batch 21's tangency form $3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)=0$ identically.
>
> **First order is criticality restated.** Stationarity along the orbit is $[\hat U,A]+[V,C]=0$. With GENERIC symmetric fields that is a real condition, and under the Lagrange forms it is an identity, since $[V,C]=\beta\{V,K\}$ and $[\hat U,A]=-\beta\{V,K\}$.
>
> **Second order survives that test.** For every skew $\Omega$, at a local maximum,
> $$Q(\Omega)=\operatorname{tr}\big([\Omega,\hat U][\Omega,A]\big)+\operatorname{tr}\big([\Omega,V][\Omega,C]\big)\ \ge\ 0,$$
> and substituting the Lagrange forms leaves
> $$Q(\Omega)=\mu\big(3\lvert[\Omega,\hat U]\rvert^2+\lvert[\Omega,V]\rvert^2\big)-3\alpha\operatorname{tr}\big([\Omega,\hat U][\Omega,\hat U^2]\big)-\beta\Big(\operatorname{tr}\big([\Omega,\hat U][\Omega,V^2]\big)+\operatorname{tr}\big([\Omega,V][\Omega,\{\hat U,V\}]\big)\Big),$$
> which is **not** identically zero. The multiples of $I$ drop out, and $[\Omega,X]$ is symmetric for skew $\Omega$ and symmetric $X$, so the $\mu$ term is a positive multiple of $\mu$.
>
> **It is batch 21's own condition, not a new one.** Evaluating batch 21's inequality at $X=[\Omega,\hat U]$, $Y=[\Omega,V]$ gives $Q(\Omega)\ge0$ **exactly**.
>
> **What it therefore is: a third lower bound on $\mu$.** Since the $\mu$ term is positive, $Q\ge0$ says $\mu\ge\lambda_{\max}$ of the remaining form against it, a generalised eigenvalue in $\hat U$ and $V$.
>
> **And it excludes nothing the record did not already exclude.** At $w_3=0$, $w_1=w_2=1$:
>
> | spectrum | $\mu$ | batch 18 needs | batch 21 needs | orbit needs | verdict |
> |---|---|---|---|---|---|
> | $(3,1,-4)$ | $-6.06130$ | $9.3675$ | $15$ | $11.274$ | excluded by all three |
> | $(3,1,-4)$ | $-24.43870$ | $9.3675$ | $15$ | $-12.529$ | orbit CLEARS it, and is weaker than both |
> | $(19,-20,1)$ | $5.61547$ | $50.7124$ | $75$ | $97.950$ | excluded by all three |
> | $(19,-20,1)$ | $762.38453$ | $50.7124$ | $75$ | $105.693$ | clears all three, and survives |
>
> **So the orbit bound excludes no point that batches 18 and 21 do not already exclude, and at one point it is strictly weaker.** The joint direction batch 21 hoped for exists, is computable and is typed, and it does not close the node.

## The claims, and your verdict on each

| # | claim | verdict |
|---|---|---|
| 1 | $[\hat U,V^2]=\{V,K\}$, and $[\hat U,A]=-\beta\{V,K\}$ for the $A$ Lagrange form | |
| 2 | $[\hat U,\beta V^2+A]=0$ at every critical point, so batch 7's condition is an identity | |
| 3 | Post F69's test is correct as stated, and its scope ("any condition on $A$ or $C$") is not overreach | |
| 4 | The orbit preserves both norms and the internal part, so the curve lies in the constraint set | |
| 5 | $X=[\Omega,\hat U]$, $Y=[\Omega,V]$ is traceless symmetric and satisfies the tangency form identically | |
| 6 | First order along the orbit is $[\hat U,A]+[V,C]=0$, an identity under the Lagrange forms, a real condition with generic fields | |
| 7 | $Q(\Omega)$ has the displayed form, is not identically zero, and the multiples of $I$ drop out | |
| 8 | $Q(\Omega)\ge0$ equals batch 21's inequality at the orbit direction, exactly | |
| 9 | $Q\ge0$ is equivalent to a lower bound on $\mu$, a generalised eigenvalue | |
| 10 | The table's four rows, and the conclusion that the orbit bound excludes nothing new and is weaker at one point | |

## What to attack hardest

1. **Claim 8 decides whether batch 33 is new mathematics or a specialisation.** If $Q$ and batch 21 at that direction differ, one of the two derivations is wrong. Derive both yourself.
2. **Claim 4 is doing a lot of work.** The orbit preserving the constraint EXACTLY is what removes the multiplier from the second-order condition. Check that, and check whether the second derivative along the group curve really has no acceleration contribution, given that batch 21's own justification for dropping it assumes a critical point.
3. **Claim 10's table.** Recompute at least the last row independently. Batch 29's quadratic is given above; its roots and the recovered $(a_1,a_2,w)$ are what the row rests on. **Two of these numbers were previously recorded at twice their size** from a factor-of-$\tfrac12$ error, so treat every one as suspect and say which you reproduced.
4. **Is claim 2 vacuous in the damaging sense?** Ask what batch 7's condition would look like if it were non-vacuous, and whether the block has proved the right thing or merely rearranged a definition.
5. **Post F69's reach.** It is stated for "any condition on $A$ or $C$". Find a condition on $A$ or $C$ that is NOT criticality restated, or say why none exists.
6. **Whether the negative conclusion overreaches.** The block tests four points at two spectra with $w_3=0$, $w_1=w_2$. Does "excludes nothing the record did not already exclude" follow from four points, and should it be stated for that sub-stratum only?

## The Lean declarations

In `lean/HamiltonsCubic/Results/I106Criticality.lean`: `orbit_first_order_vacuous` (claim 6's identity), `orbit_second_order_form` (claim 7's decomposition), and from the earlier batches `commutator_from_C`, `commutator_from_A`, `jordan_gap`, `jordan_gap_le`. **Claims 2, 4, 5, 8, 9 and 10 are typed nowhere**; say for each whether a Lean statement could carry it. Do not treat a successful build as evidence a declaration says what the block claims: compare the statement against the block's words.

## Deliverables

Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per row, with corrections, and what you would change in the record.

**Commit a skeleton report in your first phase and update it**, rather than writing one at the end: the first commit is the title, the claim table with every verdict `NOT REACHED`, and your log path. **Do not write to `reviews/INDEX.md`**, which the parent writes after every report of the round has landed.

**Log** to `agent_logs/<your task name>.log`: first line with your PID and phase plan, a line at every phase transition, a heartbeat at least every three minutes carrying live state, and a closing `DONE <summary>` or `FAILED <reason>` as the last line written, with that word opening the line.
