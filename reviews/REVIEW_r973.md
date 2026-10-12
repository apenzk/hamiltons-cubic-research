# Review r973: the fourth-shape lever, its classification, and its vacuity at the three survivors

Reviewer **r973**, gate 2, working from [BRIEF_I106a_fourth_shape_classification.md](BRIEF_I106a_fourth_shape_classification.md). The working note the block was drawn from was not read, the scripts under review were not imported, and no other reviewer's report was read. Every number below was produced here, from the brief's definitions, by code written here.

Log: [agent_logs/r973-fourth-shape.log](../agent_logs/r973-fourth-shape.log)

## Verdicts

| # | claim | kind | verdict |
|---|---|---|---|
| 1 | The ladder is exactly $[\theta^2]=Q/2$, $[\theta^3]=\Xi-S$, $[\theta^4]=-\tfrac38\Phi_0-\tfrac5{12}Q$, $[\theta^5]=-(\Xi-S)/2$ | mathematics | **CONFIRMED** |
| 2 | $[\theta^4]$ needs only $Q=0$, and is therefore strictly more informative than a version needing $Q=0$ and $\Xi=S$ together | mathematics | **REFUTED** |
| 3 | The block problem's $-\tfrac38\Phi_0$ on $\{Q=0\}$ and the record's $-\tfrac{3\theta}8$ on the null cone of $B$ are the same constant under the same hypothesis | mathematics | **CONFIRMED**, and its reading REFUTED |
| 4 | Hence the fourth shape IS the record's higher-variation calculus transported, rather than a new apparatus | a classification | **REFUTED** |
| 5 | The record's ORBIT-VACUITY does not transfer, because $A$ and $C$ are fixed and conjugation is not a symmetry of $\Phi$ | mathematics | **CONFIRMED**, its numerical support REFUTED |
| 6 | The record's "third-order content is the EXCESS alone" DOES transfer | mathematics | **REFUTED** |
| 7 | The tangent space to the constraint surface at such a point is $9$-dimensional | mathematics | **CONFIRMED** |
| 8 | At all three survivors the second variation is nondegenerate there, $\dim\ker H=0$, so no direction with $Q(Z)=0$ exists | numerical | **REFUTED**, its first half confirmed |
| 9 | Therefore the lever is vacuous at exactly the points R28 must exclude, and R28 reopens on its existence without advancing on it | about a route | **REFUTED** as stated, outcome superseded |

**The finding that outranks the brief's question.** *At all three survivors the second variation is INDEFINITE on the tangent space*, so batch 21's inequality as the brief quotes it is **violated** there, by margins reproduced through three independent routes. **The three points are not local maxima**, they clear only the $\mu$-threshold surrogate of batch 21 and not batch 21, and the lever they were tested against has no hypothesis at them because *maximality* fails, not because degenerate directions are absent. Degenerate directions are abundant at all three.

## Claim 1, CONFIRMED, and the ladder stops one order early in a way that matters

Re-extracted rather than checked, by series in $\theta$ from the brief's identity with $\Phi_0$, $Q$ and $\Xi-S$ carried as independent symbols. Every coefficient through $[\theta^8]$:

| order | coefficient |
|---|---|
| $0,1$ | $0$ |
| $2$ | $Q/2$ |
| $3$ | $\Xi-S$ |
| $4$ | $-\tfrac38\Phi_0-\tfrac5{12}Q$ |
| $5$ | $-\tfrac12(\Xi-S)$ |
| $6$ | $+\tfrac18\Phi_0+\tfrac{91}{720}Q$ |
| $7$ | $+\tfrac{13}{120}(\Xi-S)$ |
| $8$ | $-\tfrac{13}{640}\Phi_0-\tfrac{41}{2016}Q$ |

**The block's four are right.** Every even order is a combination of $\Phi_0$ and $Q$ and every odd order is a multiple of $\Xi-S$, which is forced by the identity's shape: its first two summands are even in $s$ and the third is the only odd one.

**It did stop one order early, and the next order reverses the sign.** At $Q=0$ the ladder reads $-\tfrac38\Phi_0$ at $[\theta^4]$ and $+\tfrac18\Phi_0$ at $[\theta^6]$. Wherever $\Phi_0>0$ the first is a strict decrease and the second a strict increase, so neither is a constraint on its own and the pair is the first place a competition between them could be posed.

## Claim 2, REFUTED, on three independent grounds

**The coefficient carries no hypothesis at all.** $[\theta^4]=-\tfrac38\Phi_0-\tfrac5{12}Q$ holds for every tangent $Z$ of the right norm, degenerate or not. $Q=0$ is what lets it be *evaluated* as $-\tfrac38\Phi_0$, so "needs only $Q=0$" compares two readings of one unconditional identity rather than two hypotheses.

**Under the lever's own standing hypothesis the two hypothesis sets are the same set.** At a local maximum $\Phi(\gamma(\theta))-\Phi_0\le0$ for small $\theta$ of both signs. With $Q(Z)=0$ the expansion begins $(\Xi-S)\theta^3$, whose sign reverses with $\theta$, so $\Xi(Z)=S(Z)$ follows. **$Q=0$ therefore implies $\Xi=S$ at every local maximum**, and a statement hypothesising both is not weaker than one hypothesising the first. There is nothing strict to be strictly more informative than.

**And at $Q=0$ the $\theta^4$ coefficient constrains nothing.** Once $\Xi=S$ is forced, the leading term is $-\tfrac38\Phi_0\theta^4$, automatically $\le0$ whenever $\Phi_0\ge0$. The informative content at a degenerate direction is $\Xi=S$, delivered at $[\theta^3]$, and $[\theta^4]$ is satisfied strictly and says nothing. That is the verdict the record already reached for its own quartic, which at $\theta>0$ "is negative whatever the algebra" and "carries no information".

## Claim 3, CONFIRMED as arithmetic, REFUTED as a tell

**The two coefficients are the same object, and more exactly than the block says.** For a homogeneous cubic $P$ with $T(W,W,z)=0$ and $\lvert W\rvert=\lvert z\rvert=1$, the great circle gives $P(\gamma)=c^3\theta+3cs^2\langle L_Wz,z\rangle+s^3P(z)$, whose fourth coefficient is $\tfrac78\theta-\tfrac52\langle L_Wz,z\rangle$. That is the record's own great-circle quartic, already on the record beside the chordal one. Substituting the second variation $Q=6\langle L_Wz,z\rangle-3\theta$ into the block's $-\tfrac38\Phi_0-\tfrac5{12}Q$ returns $\tfrac78\theta-\tfrac52\langle L_Wz,z\rangle$ identically. **So the block's $\theta^4$ coefficient IS the record's great-circle quartic rewritten in $Q$**, not merely a constant agreeing with it. The chordal-versus-great-circle difference the block passes over is $2\langle Bz,z\rangle$, which vanishes on the null cone, so the identification survives the reparametrisation it never mentions.

**But the constant is forced by the parametrisation and homogeneity, so it is evidence of nothing.** Derived here in general: for $\Phi=(\text{homogeneous cubic})+(\text{linear})$ critical on a quadratic level set with multiplier $\mu$, the radial relation $\mu T(p)=\Phi_3(p)+\tfrac12\Phi_0$ is Euler's identity plus criticality, and with the tangential condition it collapses the great circle to exactly the brief's identity, $\Phi(\gamma)=\tfrac12\Phi_0(3c-c^3)+\tfrac12cs^2Q+s^3(\Xi-S)$. Since $\tfrac12(3c-c^3)=\tfrac18(9\cos\theta-\cos3\theta)=1-\tfrac38\theta^4+\dots$, the number $-\tfrac38$ is the fourth Taylor coefficient of a fixed trigonometric polynomial and depends on no algebra whatever.

**Screened against generic functionals**, five random fully symmetric cubic forms on $\mathbb R^{10}$, each with a linear part chosen to make a random unit vector critical, evaluated at a direction where the second variation vanishes: $[\theta^4]$ matched $-\tfrac38\Phi_0$ to the fit's precision every time, at values of $\Phi_0$ of both signs. Reported as a screen. **So "same constant, same hypothesis" is true of every cubic-plus-linear functional on every sphere**, and the tell tells only that both functionals are cubic.

## Claim 4, REFUTED

What transfers is the Taylor expansion of a cubic along a great circle, which is not an apparatus and belongs to no functional in particular. The record's higher-variation calculus consists of the orbit identity $Bu=z\circ z$, the automatic membership of the orbit tangent in $A(\tfrac12)$, the fusion rule, the stationary corrector and $\langle b,B^+b\rangle$, and the orbit-excess splitting. **The block withdraws the first of those and, per claim 6, is not entitled to the last either.** After both withdrawals nothing of the calculus has crossed, so "that calculus transported" promotes a coincidence of Taylor coefficients into an inheritance. The sound classification is that the block problem and the record's $P$ are two cubic functionals critical on spheres, and that everything the record's calculus adds beyond that rests on an invariance the block problem does not have.

## Claim 5, CONFIRMED structurally, its numerical support REFUTED

**The structural half is right.** The record's proposition is stated for a compact group acting orthogonally *and leaving $P$ invariant*, and the orbit identity comes from differentiating $Q(e^{tX}W)=\theta e^{tX}W$, which presumes the conjugated point is again critical with the same multiplier. With $A$ and $C$ fixed matrices, conjugating $(\hat U,V)$ moves the pairings $\langle\hat U,A\rangle$ and $\langle V,C\rangle$ while fixing the cubic part, so conjugates of a critical point are not critical and there is nothing to differentiate. The withdrawal is correct.

**The numbers offered for it are not evidence.** Reproduced here independently from the reconstruction of claim 8: $\max_\Omega\lvert Q(\text{orbit})\rvert$ is $5.44667\cdot10^3$, $4.92606\cdot10^4$ and $2.06780\cdot10^9$, matching the block's table to five figures, every value negative. **But those are unnormalised values of a quadratic form on vectors of norm $16.1$ to $1659$ in the constraint metric**, so their size measures the orbit tangent's length. As Rayleigh quotients $Q(Z)/\lVert Z\rVert_T^2$ the largest-magnitude orbit direction gives $-4.44$, $-11.83$ and $-936.8$, against full tangent-space ranges $[-35.43,+10.45]$, $[-73.32,+3.34]$ and $[-1673.3,+91.67]$. **Every orbit direction sits in the interior of the ordinary range**, so "nowhere near zero" holds of almost every direction at these points and the orbit is not distinguished at all. Claim 5 stands on its structural argument alone.

## Claim 6, REFUTED, and the line was drawn in the wrong place

The record's splitting is proved inside the same proposition, under the same hypothesis, by the same move.

- **Its hypothesis is invariance.** The statement quantifies over $X$ in the Lie algebra of a group leaving $P$ invariant. Outside that hypothesis $X\!\cdot\!W$ is not a distinguished direction and the word "orbit" in "orbit and excess parts" has no referent.
- **Its first step is the invariance derivation.** "Applying *the derivation* to $L_Wz_1=\tfrac\theta2z_1$" is the same differentiation of $Q(e^{tX}W)=\theta e^{tX}W$ that produced $Bu=z\circ z$. The identity $(X\!\cdot\!W)\circ z_1=B(Dz_1)$ says $D$ is a derivation of the product $\circ$, which holds because the action preserves $T$. Without invariance there is no such $D$ and no such identity.
- **Its conclusion presupposes the withdrawn fact.** Writing $z=o+e$ with $o$ in the orbit tangent and $e$ transverse inside $A(\tfrac12)$ requires the orbit tangent to lie in $A(\tfrac12)$, which is exactly the hypothesis-free membership claim 5 withdraws. In the block problem it is false at all three survivors, where $\ker H=0$ while the orbit tangent is nonzero, so the orbit direction is not degenerate and cannot be a component of a degenerate one.

**Both halves of the transfer rest on invariance, and the block kept the half it had just disqualified.** $T(z,z,z)=T(e,e,e)$ has no block-problem counterpart, because the block problem has no splitting to state it in.

## Claim 7, CONFIRMED

Real traceless symmetric $3\times3$ matrices form a $5$-dimensional space, so pairs $(X,Y)$ span $10$ dimensions. The tangent space at $p=(\hat U,V)$ is cut by the single condition $3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)=0$, which is $\langle p,\cdot\rangle$ in the inner product $\langle Z,Z'\rangle_T=3\operatorname{tr}(XX')+\operatorname{tr}(YY')$ and so is a nonzero functional exactly when $p\ne0$, true at each of the three points. **$10-1=9$.**

## Claim 8, REFUTED, with its first half confirmed

**The three points were rebuilt here from the criticality system, not taken from the table.** With $\hat U=\operatorname{diag}(\text{spectrum})$ and $V$ carrying one vanishing off-diagonal entry, the system $[A,C]=0$ in $(a_1,a_2,\mu)$ was solved from multistart least squares and polished by Newton at $60$ digits. It returns $\mu=11.6005951538$, $24.4386964721$ and $762.384530179$, the record's three values, at $\lvert[A,C]\rvert$ between $8\cdot10^{-58}$ and $2\cdot10^{-52}$.

**The reconstruction was then validated against the brief's own identity.** At each point, with $Z$ scaled to $\lVert Z\rVert_T=\lVert p\rVert_T$, the closed form $-\tfrac12\Phi_0(c-1)^2(c+2)+\tfrac12cs^2Q+s^3(\Xi-S)$ matched $\Phi(\gamma(\theta))-\Phi(p)$ to a worst relative mismatch of $3.4\cdot10^{-51}$ over six values of $\theta$, with the constraint drift below $10^{-45}$. So the objects measured below are the brief's objects.

| spectrum | $\mu$ | $\Phi_0$ | eigenvalues of $H$ on the $9$-dimensional tangent space |
|---|---|---|---|
| $(1,-3,2)$ | $11.6005952$ | $2143.111$ | $-35.4283,\ -35.2020,\ -29.1679,\ -26.6299,\ -6.4964,\ -0.04076,\ +0.03996,\ +1.3076,\ +10.4462$ |
| $(-1,-3,4)$ | $24.4386965$ | $19982.007$ | $-73.3178,\ -73.2966,\ -42.9056,\ -30.9713,\ -30.2157,\ -0.04185,\ +0.03897,\ +0.53851,\ +3.3409$ |
| $(19,-20,1)$ | $762.3845302$ | $5.2621\cdot10^8$ | $-1673.30,\ -1638.77,\ -1404.77,\ -882.42,\ -738.66,\ -648.35,\ -3.80\cdot10^{-5},\ +2.68\cdot10^{-5},\ +91.670$ |

**$\dim\ker H=0$ is confirmed, and the brief was right to ask how nondegenerate.** The smallest $\lvert$eigenvalue$\rvert$ is $3.996\cdot10^{-2}$, $3.897\cdot10^{-2}$ and $2.68\cdot10^{-5}$, which against the spectral radius is $1.13\cdot10^{-3}$, $5.32\cdot10^{-4}$ and $1.60\cdot10^{-8}$. **The third point is a different finding from the other two**: it carries a near-null pair $\mp$ at $10^{-5}$ whose relative size is $10^{-8}$, and since the point itself is exact to fifty digits this is a genuine near-degeneracy of $H$ rather than an artefact of reconstruction. Calling all three "nondegenerate" flattens a $10^{-3}$ and a $10^{-8}$ into one word.

**The inference is false.** $\dim\ker H=0$ says the null *space* of $Q$ is trivial. The lever's hypothesis is $Q(Z)=0$, whose solution set is the null *cone*, and for an indefinite form the null cone is a nonempty hypersurface. **$H$ is indefinite at all three points**, with signature $6$ negative and $3$ positive at the first two and $7$ negative and $2$ positive at the third, so $\{Q=0\}$ is an $8$-dimensional cone in a $9$-dimensional tangent space at each of them. Only *definiteness* would give the block's conclusion, and it fails. Degenerate directions are not absent at these points, they are generic there.

**Because $H$ is indefinite, batch 21 is violated at all three, and this was confirmed by three independent routes.**

| route | what it does | $(1,-3,2)$ | $(-1,-3,4)$ | $(19,-20,1)$ |
|---|---|---|---|---|
| eigenvalues | top eigenvalue of $H$ in a $T$-orthonormal tangent basis | $+10.4462$ | $+3.3409$ | $+91.670$ |
| sampling | best Rayleigh quotient over $4000$ random tangent directions, no eigendecomposition | $+8.162$ | $+0.449$ | $+4.013$ |
| the functional itself | $\Phi(\gamma(\pm0.01))-\Phi_0$ along the great circle in that direction, constraint drift $<10^{-45}$ | $+0.1443$, $+0.1467$ | $+0.01545$, $+0.04238$ | $+186.35$, $+90.75$ |

The third route touches no second variation at all. It evaluates $\Phi$ on the constraint surface and finds it strictly larger than $\Phi_0$ on both sides of the point. **All three points therefore fail the second-order necessary condition and are not local maxima.**

**This does not contradict the record's table, and the gap between them is the finding.** The column the record tests is a $\mu$ threshold derived from batch 21, $\mu\ge\alpha\lvert u_{\min}\rvert$, which reads $11.25$, $11.25$ and $75$ and which all three clear. The brief quotes batch 21 in its full form, quantified over all tangent $(X,Y)$, and that form excludes all three. **The surrogate is strictly weaker than the condition it stands for, and the three "survivors" survive only the surrogate.**

## Claim 9, REFUTED as stated, and its outcome superseded

**Its stated reason is false twice.** "The points R28 must exclude carry no degenerate direction" fails because each carries an $8$-dimensional cone of them, and "the points R28 must exclude" fails because batch 21's full condition already excludes all three.

**Its outcome survives in a weaker and differently grounded form.** The lever is indeed inert at these three points, because its hypothesis is local maximality and these are not local maxima. That is an outcome about the points, and it is reached without the lever.

**On reach, the block's wording overstates.** "The lever is vacuous exactly where R28 needs it" is a statement about a stratum, drawn from three points found by an optimiser at three integer spectra in one two-off-diagonal-entry family. What three points can support is "inert at these three", never "inert on the stratum", and the direction the evidence actually points is the opposite of the block's: at points where $H$ is indefinite the lever's hypothesis $Q=0$ is satisfied by a cone of directions, so if a non-commuting *local maximum* exists its $H$ is negative semidefinite and the question of whether $\ker H$ is trivial there is untouched by any of this. **R28 reopens on the lever's existence, which claims 1 and 3 establish, and these three points decide nothing about whether it advances**, since they were never local maxima to begin with.

## Vacuity checks, as the brief asks

- **Claim 5 would be vacuous** if $Q$ were far from zero in nearly every direction, so that the orbit's nonvanishing carried no information. Checked and it *is* vacuous in that sense: the orbit's Rayleigh quotients lie strictly inside the range attained over the whole tangent space at all three points. Only claim 5's structural argument has content.
- **Claim 8 would be vacuous** if $\dim\ker H=0$ were compatible with a large set of directions satisfying the lever's hypothesis. Checked and it is: the null cone is $8$-dimensional at each point.
- **Claim 2 would be vacuous** if the two hypotheses it separates coincided. Checked and they do, at every local maximum.
- **Claim 3 would be vacuous** if the constant were forced by the parametrisation. Checked against generic random cubics and it is.

## What this round leaves

1. **The strongest correction is not about the lever.** Three points recorded as clearing batch 21 fail batch 21's full second-variation inequality, confirmed by eigenvalues, by sampling, and by evaluating $\Phi$ itself along a constraint-preserving curve. Every claim resting on them being maxima needs re-reading, including batch 35's value comparison, whose witness argument is unaffected in its arithmetic but whose subjects are not the objects it was framed against.
2. **The $\mu$-threshold surrogate for batch 21 should be labelled as one wherever a table calls it batch 21.** A point clearing $\mu\ge\alpha\lvert u_{\min}\rvert$ has cleared a consequence, not the condition.
3. **The classification should be restated positively**: the block problem's great-circle ladder is the Taylor expansion of a cubic-plus-linear functional at a critical point, which the record already computed for its own functional, and the $-\tfrac38$ is a property of the sphere. What the record's calculus adds beyond that needs invariance and stays behind.
4. **The near-degeneracy at $(19,-20,1)$, a pair of eigenvalues at $10^{-8}$ of the spectral radius at a point exact to fifty digits, is unexplained** and is the one numerical feature here worth a structural look.
