# REVIEW r972: the fourth-shape lever, its classification and its vacuity at the three survivors

Reviewer r972, adversarial, Gate 2, brief [BRIEF_I106a_fourth_shape_classification.md](BRIEF_I106a_fourth_shape_classification.md). Log: [agent_logs/r972-fourth-shape.log](../agent_logs/r972-fourth-shape.log).

Worked from the brief's mathematics alone. The working note the block was drawn from was not read, the scripts under review were not imported, and no other reviewer's in-flight report was read. One narrow exception, declared: claim 2 is defined as a comparison with a sentence in [REVIEW_r971.md](REVIEW_r971.md), a landed report, so its one table row was grepped and nothing else of it was read.

## Verdicts

| # | claim | kind | verdict |
|---|---|---|---|
| 1 | The ladder is exactly $[\theta^2]=Q/2$, $[\theta^3]=\Xi-S$, $[\theta^4]=-\tfrac38\Phi_0-\tfrac5{12}Q$, $[\theta^5]=-(\Xi-S)/2$ | mathematics | **CONFIRMED** |
| 2 | $[\theta^4]$ needs only $Q=0$, and is strictly more informative than a version needing $Q=0$ and $\Xi=S$ together | mathematics | **REFUTED as stated**, confirmed for the coefficient |
| 3 | The block's $-\tfrac38\Phi_0$ on $\{Q=0\}$ and the record's $-\tfrac{3\theta}8$ on the null cone of $B$ are the same constant under the same hypothesis | mathematics | **CONFIRMED and empty** |
| 4 | Hence the fourth shape IS the record's higher-variation calculus transported | a classification | **REFUTED** |
| 5 | The ORBIT-VACUITY does not transfer, because $A$ and $C$ are fixed | mathematics | **CONFIRMED**, with an exact formula and a structural warning |
| 6 | The record's "third-order content is the EXCESS alone" DOES transfer | mathematics | **REFUTED** |
| 7 | The tangent space at such a point is $9$-dimensional | mathematics | **CONFIRMED** |
| 8 | At all three survivors $\dim\ker H=0$, so no direction with $Q(Z)=0$ exists | numerical | **NOT REPRODUCIBLE** from the brief, and the stated inference is incomplete |
| 9 | The lever is vacuous exactly where R28 needs it, and R28 reopens without advancing | about a route | **REFUTED as worded**, true in a weaker form that needs no computation |

## The one sentence that matters

Claim 6 does not survive claim 5. The record's excess-splitting is proved by differentiating the equivariance of $L_W$, which is invariance, the same premise claim 5 correctly says is absent here. The block withdrew one half of the transfer and kept the other half of the same proof, so the line is drawn in the wrong place and claim 4 carries nothing across.

## Claim 1, CONFIRMED, and the ladder does not stop early

Re-extracted by series from the given identity rather than checked against the block. Coefficients through $[\theta^8]$:

| $k$ | $[\theta^k]$ |
|---|---|
| $2$ | $Q/2$ |
| $3$ | $\Xi-S$ |
| $4$ | $-\tfrac38\Phi_0-\tfrac5{12}Q$ |
| $5$ | $-(\Xi-S)/2$ |
| $6$ | $\tfrac18\Phi_0+\tfrac{91}{720}Q$ |
| $7$ | $\tfrac{13}{120}(\Xi-S)$ |
| $8$ | $-\tfrac{13}{640}\Phi_0-\tfrac{41}{2016}Q$ |

All four of the block's coefficients are right. **The block has not stopped one order too early, and no order can add anything.** The identity has exactly three terms built from the three scalars $\Phi_0$, $Q$ and $\Xi-S$, so every coefficient at every order is a fixed rational combination of those same three. The ladder is complete in content at $[\theta^5]$, and $[\theta^6]$ onward carries no functional the first four do not.

**The identity is criticality rewritten, not a new structure.** Reducing both sides to the spanning set $\{c,\,s,\,cs^2,\,sc^2\}$ on the circle, the $c$ and $s$ rows are automatic, and the identity is equivalent to exactly two facts: the $sc^2$ row is $3B_3(p,p,Z)=-\Phi_1(Z)$, which is $d\Phi_p[Z]=0$ for tangent $Z$, and the $cs^2$ row is $\Phi_3(p)+\tfrac12\Phi_0=\mu T_0$, which is Euler's relation under the Lagrange condition. So the validation "at $2.3\cdot10^{-13}$ over $4000$ critical points" is a validation of criticality. Two free consistency checks that the block does not record and that both pass: at $\theta=\pi/2$ the identity reads $\Phi(Z)=\Xi(Z)-S(Z)$, and at $\theta=\pi$ it reads $\Phi(-p)=-\Phi_0$.

Screen: symbolic series of the given right-hand side, and an independent check in the $3\times3$ setting with random traceless symmetric $\hat U,V$ and random $\mu$, fields $A,C$ built from them, maximum identity residual $5.3\cdot10^{-15}$ over twelve angles and the four coefficients recovered to twelve digits.

## Claim 2, REFUTED as stated

The coefficient half is right. $s^3(\Xi-S)$ contributes only odd powers of $\theta$, so $\Xi-S$ cannot appear at $[\theta^4]$ at any critical point, and $-\tfrac38\Phi_0-\tfrac5{12}Q$ holds with no hypothesis at all. That is correct and worth having.

The inference is wrong. [r971](REVIEW_r971.md)'s row states the hypothesis as "$Q(Z)=0$ and $\Xi(Z)=S(Z)$", and **at a local maximum with $Q(Z)=0$ the condition $\Xi=S$ is forced, not assumed**: $[\theta^3]$ is odd, so a nonzero $\Xi-S$ makes $\Phi$ rise on one side of $\theta=0$. The second hypothesis is free. To run the lever and reach $\Phi_0\ge0$ one still needs both coefficients to die, so the two statements have identical content as levers and the block gains nothing it can use. The honest correction: the identity is unconditional, the lever is not, and "strictly more informative" is true of the first and false of the second.

## Claims 3 and 4: the constant is forced by the parametrisation, so the tell tells nothing

The brief asked whether $-\tfrac38$ is a correspondence or a coincidence. It is neither. **It is a theorem about cubic-plus-linear functionals that uses no algebra of either functional.**

> **Proposition (r972).** Let $F=F_3+F_1$ on a real vector space, $F_3$ homogeneous cubic with symmetric polarisation $B_3$, $F_1$ linear, $T$ a quadratic form, and $p$ a critical point of $F$ on $\{T=T_0\}$ with multiplier $\mu$. Let $Z$ be tangent with $T(Z)=T_0$ and $\gamma(\theta)=\cos\theta\,p+\sin\theta\,Z$. Writing $q:=[\theta^2](F\circ\gamma)$,
> $$[\theta^4](F\circ\gamma)=-\tfrac38 F(p)-\tfrac56\,q .$$

Proof. The part of $F(\gamma)$ even in $\sin\theta$ is $a\,c^3+b\,c+d\,c s^2$ with $a=F_3(p)$, $b=F_1(p)$, $d=3B_3(p,Z,Z)$, and only that part reaches even orders. Expanding, $q=-\tfrac32a-\tfrac12b+d$ and $[\theta^4]=\tfrac78a+\tfrac1{24}b-\tfrac56d$. Euler's relation with $dF_p=\mu\,dT_p$ gives $3a+b=2\mu T_0$, hence $q=d-\mu T_0$ and $[\theta^4]=\tfrac34(a-\mu T_0)-\tfrac56q$. Finally $F(p)=a+b=2\mu T_0-2a$, so $a-\mu T_0=-\tfrac12F(p)$.

Three consequences.

- **The block problem is the case $F=\Phi$, $q=Q/2$**, giving $[\theta^4]=-\tfrac38\Phi_0-\tfrac5{12}Q$. Nothing about $\alpha=\tfrac{15}4$, $\beta=\tfrac94$, traceless symmetric matrices or the shape of $T$ enters.
- **The record's $P$ is the case $F_1=0$, $F(p)=\theta$, $q=-3\langle Bz,z\rangle$**, giving $[\theta^4]=-\tfrac38\theta+\tfrac52\langle Bz,z\rangle$, which is $-\tfrac{3\theta}8$ on the null cone of $B$. Same proposition, one term switched off.
- Screened on random data: a random symmetric cubic on $\mathbb R^4$ with a random quadratic constraint and a linear part chosen to make a random $p$ critical reproduces the relation with residual $0.0$, and the record's own pure-cubic sphere problem reproduces it too.

So claim 3 is arithmetically true and evidentially empty. Any cubic-plus-linear functional at any constrained critical point produces $-\tfrac38$ of its own value once the second-order coefficient is killed, whatever the algebra. **A quantity that two problems share because every problem has it is not a tell**, and since claim 4's stated evidence is exactly that shared constant, claim 4 is decoration. That the two calculations are instances of one proposition is a fact about homogeneity, not a transport of apparatus.

**A second defect in claim 3, smaller and sharper.** The record's $-\tfrac{3\theta}8$ is the CHORDAL quartic, the coefficient in $x=W+tz$ renormalised, while the block's $-\tfrac38\Phi_0$ is an ARC-LENGTH quartic. These are different coefficients. The chordal one is $-\tfrac38\theta-\tfrac32[t^2]$ and the great-circle one is $-\tfrac38\theta-\tfrac56[\theta^2]$, so off the null cone they disagree, checked numerically as $5.3066$ against $2.5149$ at a generic direction. They agree only where the second-order coefficient vanishes. The block's "same constant, same hypothesis" survives only because the hypothesis is what erases the difference, and the block's own unconditional extension $-\tfrac5{12}Q$ is NOT the record's unconditional extension $-\tfrac92\langle L_Wz,z\rangle+\tfrac{15}8\theta$ rewritten. Two different curves through the same point.

## Claim 5, CONFIRMED, with an exact formula and one warning

The reason given is correct. $\mathop{\mathrm{tr}}\hat U^3$ and $\mathop{\mathrm{tr}}(\hat UV^2)$ are invariant under simultaneous conjugation and so is $T$, while $\langle\hat U,A\rangle+\langle V,C\rangle$ is not when $A$ and $C$ are held fixed, so $\Phi$ is not conjugation-invariant and $Q(e^{t\Omega}\!\cdot\!p)=\theta\,e^{t\Omega}\!\cdot\!p$ has no analogue to differentiate.

**The obstruction has a closed form, which the block reports only as three magnitudes.** Let $\xi=([\Omega,\hat U],[\Omega,V])$ be the orbit tangent. Differentiating the invariance of the cubic part twice along the orbit and using $d\Phi_p=\mu\,dT_p$,

$$Q(\xi)=\langle A,[\Omega,[\Omega,\hat U]]\rangle+\langle C,[\Omega,[\Omega,V]]\rangle .$$

Verified in the $3\times3$ setting to $3.6\cdot10^{-15}$ against a direct evaluation of batch 21's expression. This is the record's own [orbit_second_order_form](../lean/HamiltonsCubic/Results/I106Criticality.lean) read as a scalar, and it makes the mechanism visible: **the orbit leaves the null cone exactly to the extent that the fields fail to be multiples of $I$**, and by no other route.

Three corrections.

- **The numerical evidence offered is redundant.** If $\dim\ker H=0$ and $Q\le0$, as claim 8 and batch 21 together assert, then $Q$ is negative definite and $Q(Z)\ne0$ for EVERY nonzero tangent $Z$. The orbit is then not distinguished at all, and $\max\lvert H(\text{orbit})\rvert\ne0$ follows from claim 8 with no computation. The block's two numerical findings are one finding.
- **The magnitudes $5.4\cdot10^3$, $4.9\cdot10^4$, $2.1\cdot10^9$ are unnormalised** and carry no information without the scale of $\Omega$ and of $T_0$. "Nowhere near zero" is not a statement until $Q(\xi)$ is divided by $\lVert\xi\rVert^2$ or by $\mu T(\xi)$.
- **The warning.** The formula above forces $Q(\xi)=0$ whenever $A$ and $C$ are multiples of $I$, which is precisely criticality for the conjugation-invariant problem $\max\Phi_3$ on $\{T=T_0\}$. So the reported magnitudes are equivalent to the assertion that the three survivors are NOT critical points of that invariant problem. That may well be right, since the programme's criticality system evidently carries more than $T$, but the block never says it, and if it were false then the orbit tangent would sit in $\ker H$ with multiplicity up to $3$ and claim 8 would fall with it. The parent should reconcile this against batch 35's definition of "critical point", because the two numerical claims stand or fall on it together.

## Claim 6, REFUTED, and this is the finding

The block kept the excess-splitting after withdrawing the orbit-vacuity. Read the record's own proof, quoted in the brief:

> Applying the derivation to $L_Wz_1=\tfrac\theta2z_1$ gives $(X\!\cdot\!W)\circ z_1=B(Dz_1)$, so $T(X\!\cdot\!W,z_1,z_2)=\langle Dz_1,Bz_2\rangle=0$.

**"The derivation" is the invariance derivation, and there is nothing else it can be.** The operator $D$ exists only because the group action carries eigenvectors of $L_W$ to eigenvectors of $L_{g\cdot W}$ at the same eigenvalue, which is equivariance $L_{g\cdot W}=gL_Wg^{-1}$, which is invariance of $P$. Differentiating $L_{e^{tX}W}\,z_1(t)=\tfrac\theta2z_1(t)$ at $t=0$ gives $(X\!\cdot\!W)\circ z_1+L_W(X\!\cdot\!z_1)=\tfrac\theta2(X\!\cdot\!z_1)$, so $Dz_1=X\!\cdot\!z_1$ and the whole identity is the infinitesimal action. Remove invariance and $D$ does not exist, $Bu=z\circ z$ does not hold, and $T(o,z_1,z_2)=0$ has no analogue. **Claim 6 falls for exactly the reason claim 5 stands.**

**And it fails a second time, independently, on its object.** The splitting $z=o+e$ presumes the orbit part $o$ of a degenerate direction. In the record the orbit tangent lies in $\ker B$ with no hypothesis, which is what gives $o$ something to be. Here, by the block's own claim 5, the orbit tangent is NOT in $\{Q=0\}$, so for any degenerate $Z$ the orbit component is zero and "$T(z,z,z)=T(e,e,e)$" degenerates to $e=z$. This is what claim 6 looks like when it is vacuous, and that is what it looks like: at the three survivors it is the tautology that the excess is everything, because there is no orbit part and, by claim 8, no degenerate direction either.

So claim 6 is unproved where it would be substantive and trivial where it is true. The block's paragraph should withdraw both halves of the transfer, not one.

## Claim 7, CONFIRMED

Real traceless symmetric $3\times3$ matrices form a $5$-dimensional space, so pairs $(X,Y)$ give $10$. The tangency condition $3\mathop{\mathrm{tr}}(\hat UX)+\mathop{\mathrm{tr}}(VY)=0$ is a single linear functional, nonzero whenever $(\hat U,V)\ne(0,0)$, which holds at any point with $T_0>0$. Hence $10-1=9$. Correct, and the brief's Lean row is accurate: [constraint_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean) types the tangency form and the rank statement that turns it into a dimension is not typed.

## Claim 8, NOT REPRODUCIBLE from the brief, and the inference as written is incomplete

**I could not rebuild the three points, and the obstruction is in the givens rather than in the effort.** The brief supplies spectra $(1,-3,2)$, $(-1,-3,4)$, $(19,-20,1)$ and the three $\mu$ values, and it supplies $A$ and $C$ as expressions in $(\hat U,V,\mu)$. Those expressions make $p$ a critical point of $\Phi$ for ANY $p$ and ANY $\mu$, as is directly checked: $\nabla_{\hat U}\Phi=3\alpha\hat U^2+\beta V^2+A=3\mu\hat U=\mu\nabla_{\hat U}T$ and $\nabla_V\Phi=\beta\{\hat U,V\}+C=\mu V=\mu\nabla_VT$. So "critical point" in batch 35 cannot mean critical for $\Phi$, and the system that actually selects the three points, which is what batches 18, 21, 30 and 33 are about, is not in the brief. A reviewer given the brief alone has spectra and multipliers and no equations, and cannot reconstruct $(\hat U,V)$. **If this claim is to be auditable, the brief must carry the selecting equations or the six entries of each $\hat U$ and $V$.** I report this rather than checking the figures against themselves.

**The inference as written does not hold.** "$\dim\ker H=0$, so no direction with $Q(Z)=0$ exists" is false for a general nondegenerate form: an indefinite nondegenerate form of signature $(p,q)$ with $p,q\ge1$ has a null cone of dimension $8$ inside a $9$-dimensional space, and an empty kernel. The step needs negative SEMIDEFINITENESS, and only then does $\{Q=0\}$ collapse onto $\ker H$. The block does have that premise, since the survivors "clear batch 21", so the conclusion is very likely right, but the argument as stated omits its load-bearing hypothesis and should read: batch 21 gives $Q\le0$, $\dim\ker H=0$ upgrades it to $Q<0$, and only a definite form has a trivial null cone.

**The brief's own question is unanswered by the block.** $\dim\ker H=0$ is reported with no margin. A rank computed by counting singular values below a threshold is a choice of threshold, and the block names neither the threshold nor $\sigma_{\min}$. "Nondegenerate at $10^{-9}$" and "nondegenerate at $10^{-1}$" are different findings, and at the third point, where $\mu=762$ and the reported orbit magnitude is $2.1\cdot10^9$, the conditioning is precisely what one would want to see before believing a kernel count.

## Claim 9, REFUTED as worded

Three points are three points. What the evidence supports is "vacuous at these three points". What the block writes, "vacuous exactly where R28 needs it", claims the stratum, and R28 must exclude a continuum of non-commuting critical points, not a survivor list from a finite search. The gap is the whole difference between a screen and a theorem.

**The weaker true statement needs no computation at all, which is the more useful correction.** The lever's hypothesis is a degenerate direction. Degeneracy is a closed condition of positive codimension on the critical set, so **the lever is vacuous at every nondegenerate critical point by construction**, and finding it vacuous at three points already known to be nondegenerate is a restatement of nondegeneracy, not a discovery. What would make the lever bite is a critical point where $Q$ is semidefinite with nontrivial kernel, and in the record's setting that is supplied automatically by the orbit. Here, by claim 5, it is not supplied at all. **That is the real reason the lever cannot reach R28, and it is structural rather than numerical**: the mechanism that manufactures degenerate directions in the record is exactly the invariance that the block correctly says is absent.

The block's closing sentence, "R28 reopens on the lever's existence and does not advance on it at these points", is sound in its second half. The first half is right only if the lever's existence was in doubt, and claim 1 shows the lever is a corollary of an identity that is itself criticality rewritten.

## The Lean table

Accurate as given, with one addition. Row 5 cites [orbit_second_order_form](../lean/HamiltonsCubic/Results/I106Criticality.lean) and should also cite `orbit_equals_batch21`, which is the declaration that actually identifies the orbit form with batch 21's expression at the orbit direction and therefore types the claim being made. It carries a named `sorry` covering three trace rearrangements, so the row should say so. Rows 1, 7 and 8 match the file: `great_circle_expansion` at line 568 is a ring identity in $c$ and $s$, `constraint_expansion` types the tangency form without the rank, and `second_variation_expansion` types the form whose kernel is being measured.

## What should change in the block

1. Withdraw the excess-splitting transfer alongside the orbit-vacuity. Both rest on invariance.
2. Replace the "same constant, same tell" paragraph with the proposition above, stated once, as a fact about cubic-plus-linear functionals at constrained critical points. It is a better result than the classification it replaces, and it retires claim 4.
3. Record $Q(\xi)=\langle A,[\Omega,[\Omega,\hat U]]\rangle+\langle C,[\Omega,[\Omega,V]]\rangle$ in place of the three magnitudes, and note that the magnitudes add nothing once $\dim\ker H=0$ is in hand.
4. Add batch 21's semidefiniteness to the sentence deriving an empty null cone from an empty kernel.
5. Report $\sigma_{\min}$ and the rank threshold for each of the three points.
6. Narrow claim 9 to the three points, and state the structural reason separately: the lever is vacuous at every nondegenerate critical point, and the record's supply of degenerate directions is the invariance this problem lacks.
