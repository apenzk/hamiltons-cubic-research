# Review r969: Gate 2 on I106a's norm trade at fixed total norm

Reviewer **r969**, adversarial Gate 2 on the block "the norm trade at fixed total norm, and what it excludes".

Log: [agent_logs/r969-normtrade.log](../agent_logs/r969-normtrade.log)

**The mathematics of the block holds.** Every algebraic step confirms, the three figures reproduce to all printed digits from a reconstruction I built from $[A,C]=0$ rather than from the script under review, and the two claims about reach come back qualified rather than clean. The block's own argument for redundancy is three points, where a theorem is available on the same grounds the orbit round used, and the Lean gap named against claim 4 is misdiagnosed.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $X=\lambda\hat U$, $Y=\kappa V$ with $3\lambda n_U+\kappa n_V=0$ is traceless symmetric and tangent, so batch 21 applies | **CONFIRMED** |
| 2 | Stationarity along the trade is $b\,\partial_a\Phi=3a\,\partial_b\Phi$, expanding to the displayed equality | **CONFIRMED**, needing $a,b\neq0$ and $A,C$ held fixed |
| 3 | Both sides are $\mu$, so the first order holds at every critical point and is vacuous | **CONFIRMED**, and it is an identity of the Lagrange forms rather than a consequence of criticality alone |
| 4 | Batch 21 at that direction is a POSITIVE multiple of $\alpha p_3n_V^2+\beta qn_U(3n_U-2n_V)-\mu Tn_Un_V$ | **CONFIRMED**, and the Lean gap recorded against it is misdescribed |
| 5 | The trade contributes exactly $\mu\ge[\alpha p_3n_V^2+\beta qn_U(3n_U-2n_V)]/(Tn_Un_V)$ | **CONFIRMED**, and the bound is weak rather than vacuous |
| 6 | At the three survivors the bound needs $-19.64468$, $-7.18323$, $-33.26116$ | **CONFIRMED** to every printed digit, on one stratum |
| 7 | The bound excludes none of them and is redundant against the record | **PLAUSIBLE**, true but argued from three points where a theorem is available |
| 8 | Therefore R28's mechanism has no first- or second-order lever left at $\lvert J\rvert=3$ | **PLAUSIBLE**, it needs pieces 1 and 2 and the completeness of the three-piece enumeration |

## Claim 1, the radial direction is admissible

$\lambda\hat U$ and $\kappa V$ are scalar multiples of traceless symmetric matrices, so they are traceless and symmetric. Batch 21 quantifies over $3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)=0$, and at the radial direction that is $3\lambda\operatorname{tr}\hat U^2+\kappa\operatorname{tr}V^2$, which is $3\lambda n_U+\kappa n_V$ because $\hat U$ and $V$ are symmetric, so the Frobenius norm and the trace of the square agree. The identification uses only the symmetry already stated in the setting.

Two conditions the block leaves silent and neither is a defect: $\lambda\neq0$, without which the direction is zero and batch 21 reads $0\le0$, and $n_V\neq0$, without which $\kappa$ cannot be solved for. The linear condition is first-order tangency and not membership of the constraint surface, which is the right reading: [constraint_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean) shows $T(\hat U+X,V+Y)$ exceeds $T$ by the tangency form plus $\tfrac32\lvert X\rvert^2+\tfrac12\lvert Y\rvert^2$, and that second-order defect is exactly what batch 21's right side $\mu(3\lvert X\rvert^2+\lvert Y\rvert^2)$ pays for.

## Claim 2, the first-order form

Write $\hat U=a\hat u$ and $V=b\hat v$ at fixed directions. Then $\Phi=\alpha a^3\hat p_3+\beta ab^2\hat q+a\langle\hat u,A\rangle+b\langle\hat v,C\rangle$, and the tangent to $3a^2+b^2=2T$ is proportional to $(b,-3a)$, so stationarity along the trade is $b\,\partial_a\Phi-3a\,\partial_b\Phi=0$ as the block says. In sympy the displayed equality, cleared of its denominators, is exactly $ab$ times that expression, so the two are equivalent precisely when $a\neq0$ and $b\neq0$.

**The step the block does not name.** It holds $A$ and $C$ fixed while $a$ and $b$ vary. That is correct here because $A$ and $C$ are external blocks and are data for this problem, but if they were read as the Lagrange forms, which are functions of $\hat U$, $V$ and $\mu$, the derivative would carry further terms and the display would be false. The block goes on to substitute the Lagrange forms into $\langle\hat U,A\rangle$ and $\langle V,C\rangle$ at the point, which is legitimate and is a different operation from differentiating them. Worth one clause in the text.

## Claim 3, both sides are $\mu$

They are, and for a reason slightly stronger than "batch 20's two pairings". Substituting the given $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$ gives $\langle\hat U,A\rangle=3\mu n_U-3\alpha p_3-\beta q$ identically, so $3\alpha p_3+\beta q+\langle\hat U,A\rangle=3\mu n_U$ is an identity of the Lagrange form rather than an extra condition. The same for $C$, where $\operatorname{tr}(V\{\hat U,V\})=2q$ gives $2\beta q+\langle V,C\rangle=\mu n_V$. The undetermined multiple of $I$ in each form drops out because $\hat U$ and $V$ are traceless, which is why the $\equiv$ is harmless, and that is typed as [I_multiple_drops](../lean/HamiltonsCubic/Results/I106Criticality.lean) for the commutator version of the same point but nowhere for the pairing version.

**Nothing beyond the two pairings is needed, with one exception**: dividing by $3n_U$ and by $n_V$ needs $\hat U\neq0$ and $V\neq0$. At a critical point with $V=0$ the right side is $0/0$ and the first-order statement is empty rather than satisfied. So the honest scope is "at every critical point with both blocks non-zero", and the block's "at every critical point" is one word wide.

**Is it vacuous?** Yes, and the structural reason is cleaner than the computation. The radial direction is one tangent inside the full first-order condition, and criticality annihilates every tangent, so any specialisation of it is automatic before the pairings are written down. The pairings exhibit the vacuity rather than cause it. This is [post F69](../findings/fence-posts.md) in the same shape as the frame variation and the conjugation orbit.

## Claim 4, the elimination, and the Lean gap

**The algebra is exact.** Substituting $\kappa=-3\lambda n_U/n_V$ and $T=(3n_U+n_V)/2$ into batch 21's two sides gives, with a zero residue in sympy,

$$\big(6\alpha\lambda^2p_3+4\beta\lambda\kappa q+2\beta\kappa^2q\big)-\mu\big(3\lambda^2n_U+\kappa^2n_V\big)=\frac{6\lambda^2}{n_V^2}\Big(\alpha p_3n_V^2+\beta qn_U(3n_U-2n_V)-\mu Tn_Un_V\Big),$$

which is [radial_elimination](../lean/HamiltonsCubic/Results/I106Criticality.lean) as stated. The prefactor $6\lambda^2/n_V^2$ is positive for $\lambda\neq0$, so the claim's "positive multiple" is right.

**The trace substitution is legitimate and needs no cyclicity.** Every substitution at the radial direction is a scalar pulled out of a trace followed by the definition of $p_3$, $q$, $n_U$ or $n_V$: $\operatorname{tr}(\hat UX^2)=\lambda^2\operatorname{tr}\hat U^3$, $\operatorname{tr}(\hat UY^2)=\kappa^2\operatorname{tr}(\hat UV^2)$, and the only term that could need rearranging, $\operatorname{tr}(XVY)$, is $\lambda\kappa\operatorname{tr}(\hat UVV)$ literally, with no reordering at all. I checked this at the matrix level: over 200 random traceless symmetric pairs the worst residual between batch 21's trace expression built from matrices and the eliminated form was $7.3\cdot10^{-12}$, and $\operatorname{tr}(XVY)-\lambda\kappa\operatorname{tr}(\hat UV^2)$ was exactly zero in floating point.

**So the gap named in the record is misdescribed.** It is not "a substitution of traces needing cyclicity, the same obstacle that leaves `orbit_equals_batch21` with a named `sorry`". The orbit case genuinely needs $\operatorname{tr}(XYV)=\operatorname{tr}(XVY)$ because there $X=[\Omega,\hat U]$ and $Y=[\Omega,V]$ are unrelated to $\hat U$ and $V$ by a scalar. The radial case needs no such identity. What is actually untyped under claim 4 is a **binding** gap: [radial_elimination](../lean/HamiltonsCubic/Results/I106Criticality.lean) quantifies over reals `p₃ q nU nV T`, and nothing in the file says those reals are the traces of the matrices batch 21 quantifies over. That gap is real and it should be recorded as what it is, because it is far easier to close than the one it is currently equated with: it needs the four definitions and `Matrix.trace_mul_comm` nowhere.

One point of care that belongs to the given rather than to this step. Batch 21's left side is twice the quadratic term of [second_variation_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean), and collapsing $\operatorname{tr}(XVY)+\operatorname{tr}(XYV)$ to $2\operatorname{tr}(XVY)$ there does use symmetry of $X$, $Y$ and $V$. That is inside batch 21, which the brief hands over as a given, and it is discharged in Lean on the symmetric parametrisation `Vm`.

## Claim 5, what the bound is, and whether it is empty

Dividing the identity of claim 4 by $6\lambda^2/n_V^2>0$ and then by $Tn_Un_V>0$ gives the stated bound, so the claim follows. The second division is the one the Lean row does not mention, and it needs $T>0$, $n_U>0$ and $n_V>0$, which hold whenever both blocks are non-zero.

"Exactly" is defensible. The trade at fixed $T$ is a one-parameter family, its tangent at each point is one-dimensional, and the radial direction exhausts it, so the trade's whole second-order content is this single scalar inequality.

**Weak, not vacuous.** A vacuous bound would be one whose threshold is negative for every configuration, so that $\mu\ge0$ implies it. Screening the threshold over $20{,}000$ random traceless symmetric pairs, it is positive in $10{,}085$ of them and ranges over $-6.03$ to $+6.09$ at unit scale, and it is homogeneous of degree one in the configuration so it scales up with the blocks. The inequality is therefore a genuine constraint on $(\hat U,V,\mu)$, and what fails is not the bound but its bite at the three points. The record should say weak and say why, since "excludes nothing" invites the reading that the functional is degenerate.

## Claim 6, reproduced independently

I rebuilt each point rather than taking the figures. At a spectrum $u$ and multiplier $\mu$ I formed $A=3\mu\hat U-3\alpha\hat U^2-\beta V^2$ and $C=\mu V-\beta\{\hat U,V\}$ from the definitions and solved $[A,C]=0$ on all three entries, not two, with the record's stratum $w_3=0$, $w_1=w_2$, $a_1=(D_1/D_2)a_2$ imposed on $V$.

| point | $\mu$ | my threshold | recorded | $\lVert[A,C]\rVert$ | $\lVert K\rVert$ | $T$ |
|---|---|---|---|---|---|---|
| $(1,-3,2)$ | $11.60060$ | $-19.64468$ | $-19.64468$ | $2.2\cdot10^{-12}$ | $7.2111$ | $178.2407$ |
| $(-1,-3,4)$ | $24.43870$ | $-7.18323$ | $-7.18323$ | $7.3\cdot10^{-12}$ | $12.1653$ | $645.4986$ |
| $(19,-20,1)$ | $762.38453$ | $-33.26116$ | $-33.26116$ | $3.4\cdot10^{-5}$ | $39.1147$ | $350181.3948$ |

Every digit agrees, the $T$ column matches the record's own value-comparison table, and the commutator control is at the level of round-off given entries of order $10^3$ in the third row. Claim 6 is confirmed.

**What the label does not pin.** The threshold is a property of the configuration and not of the pair $(u,\mu)$ that names it. Releasing all five parameters of $V$ at the same spectrum and the same $\mu$, and keeping only solutions with a relative commutator residual below $10^{-12}$ and $\lVert K\rVert/\lVert V\rVert$ above $10^{-3}$, I find a continuum of genuinely non-commuting solutions at $(1,-3,2)$ with $\mu=11.60060$ whose thresholds run from $-19.97$ to $+2.99$, **including positive ones**. None of them reaches $\mu=11.60$, so the verdict survives, but "at the three survivors the bound needs $-19.64468$" is a statement about three configurations on one stratum and reads as a statement about three labelled points. The record should name the stratum where it names the numbers.

## Claim 7, reach

**At the three points it is right**, and I confirm the comparison: the thresholds are negative while $\mu$ is large and positive, and the existing conditions already give positive thresholds there.

**The general statement is true and the block argues it badly.** Three points are three points, and the block offers nothing else. The theorem is available and it is the one [r961](REVIEW_r961.md) and [r962](REVIEW_r962.md) used to upgrade the orbit round's negative: by claim 1 the radial direction is **one admissible tangent inside batch 21's quantifier**, so batch 21's full condition implies the trade bound pointwise, and no configuration can fail the trade bound while satisfying batch 21. The trade therefore provably excludes nothing batch 21's condition does not already exclude, which is stronger than any number of points and is two lines from claim 1. The block should carry it, and the numerical table should then be described as a screen, exactly as batch 33's table was demoted.

**One qualification on the wording.** That theorem is redundancy against batch 21's *whole quantified condition*. It is not redundancy against the particular scalar column the record prints under the heading "batch 21", which is a different specialisation, and it is not a comparison against batch 18. Those remain numerical at three points.

**A defect in the given, which bears on this claim.** The brief's batch 35 quotation says "Batch 18 needs $\mu\ge9.3675$ at the first and batch 21 needs $\mu\ge15$". At the first point $(1,-3,2)$ I compute $2\beta\lvert\hat U\rvert/\sqrt6=4.5\sqrt{14}/\sqrt6=6.8739$, not $9.3675$. The value $9.3675$ is the second point's, where $\lvert\hat U\rvert^2=26$. Under the formula $-\alpha\min_ku_k$ that reproduces the record's other rows, the second column is $11.25$, $11.25$ and $75$ at the three points, so $15$ matches none of them and belongs to $(3,1,-4)$. Both numbers are attached to the wrong point, and they are the thresholds claim 7's redundancy is measured against.

## Claim 8, the route

It does not follow from claims 1 to 7. Those settle piece 3 of [R28](../routes.md) and nothing else. The route's own row makes the assessment conditional on three things: piece 1 done, piece 2 fenced, and piece 3 empty. Only the third is in this brief, so the conclusion needs the other two verdicts carried in, and piece 2's fencing was itself audited in a separate round.

**And a step is missing even with those.** "No lever left" presumes the enumeration of R28's mechanism into three pieces is complete. Nothing in this block, and nothing in claims 1 to 7, establishes that the mechanism has only those pieces. That is an assessment of a route's content and it should be stated as one, with the enumeration cited rather than assumed.

**One word to fix.** "No first-order and no second-order lever" is right for a route and wrong as mathematics. The first order really is empty, being an identity. The second order is not empty, it is redundant, and claim 5's screen shows the inequality is a real constraint that these points happen to clear widely. The distinction is the same one the record drew for batch 33 and it should be drawn again here.

## Corrections, in order of weight

1. **Carry the theorem into the block.** The radial direction is an admissible tangent for batch 21, so the trade bound is implied by batch 21's condition and cannot exclude anything it does not. Demote the three-point table to a screen.
2. **Repair the Lean gap's description.** Claim 4 needs no cyclicity and is not blocked by `orbit_equals_batch21`'s obstacle. What is untyped is that [radial_elimination](../lean/HamiltonsCubic/Results/I106Criticality.lean)'s reals are the traces of the matrices, which is a binding gap and is cheap to close.
3. **Fix the two thresholds in batch 35's sentence.** At $(1,-3,2)$ they are $6.8739$ and $11.25$, and $9.3675$ and $15$ belong to other points.
4. **Name the stratum with the numbers.** At the same $(u,\mu)$ off the record's stratum the threshold reaches $+2.99$, so the figures label configurations rather than points.
5. **Say weak rather than empty**, with the sign screen as the reason, and add the standing conditions $\hat U\neq0$, $V\neq0$ to the first-order statement and $\lambda\neq0$ to the second.

## Method and reservations

Claims 1 to 5 were settled by hand and in sympy from the definitions in the brief. The matrix-level and reconstruction work is seconds of arithmetic on objects built for the purpose, reported as screens: $200$ random pairs for the substitution, $20{,}000$ for the sign of the threshold, and a least-squares solve of $[A,C]=0$ at each of the three points. I did not read or import [screen_I106a_norm_trade.py](../scripts/misc/screen_I106a_norm_trade.py). I took the stratum ansatz, and nothing else, from [screen_I106_value_survivors.py](../scripts/misc/screen_I106_value_survivors.py), and wrote my own residual from the Lagrange forms.

**One reservation to record.** A grep for the batch 35 figures printed lines $106$ to $110$ of [2026-09-16-I106a-orthostochastic.md](2026-09-16-I106a-orthostochastic.md), which is the note I was barred from reading, and those lines carry the threshold table. I did not open the file, and my three figures were computed before I had any use for them, but the spillage happened and it belongs in the record rather than in my head.
