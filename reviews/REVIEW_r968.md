# Review r968: Gate 2 on I106a's norm trade at fixed total norm

Reviewer **r968**, working from [BRIEF_I106a_norm_trade.md](BRIEF_I106a_norm_trade.md) alone, from the definitions and the four passages quoted there as givens. Log: [agent_logs/r968-normtrade.log](../agent_logs/r968-normtrade.log).

**The block's mathematics is correct in every claim I can settle.** Claims 1 to 6 are confirmed, two of them with a correction to the reason rather than the result. What the round changes is the standing of the negative: the block earns its conclusion at three points and by the wrong argument, while a one-line argument earns it everywhere, and the gap the brief names under claim 4 is smaller than the brief says.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $X=\lambda\hat U$, $Y=\kappa V$ with $3\lambda n_U+\kappa n_V=0$ is traceless symmetric and tangent, so batch 21 applies | **CONFIRMED** |
| 2 | stationarity along the trade is $b\,\partial_a\Phi=3a\,\partial_b\Phi$, and it expands to the displayed equality | **CONFIRMED**, the two differ by the positive factor $3\lvert\hat U\rvert\lvert V\rvert$ |
| 3 | both sides are $\mu$, so the first order holds at every critical point and is vacuous | **CONFIRMED**, and stronger than stated |
| 4 | batch 21 at that direction is a POSITIVE multiple of $\alpha p_3n_V^2+\beta qn_U(3n_U-2n_V)-\mu Tn_Un_V$ | **CONFIRMED**, and the named gap needs no cyclicity |
| 5 | the trade contributes exactly $\mu\ge[\alpha p_3n_V^2+\beta qn_U(3n_U-2n_V)]/(Tn_Un_V)$ | **CONFIRMED**, weak at the three points rather than vacuous |
| 6 | at the three survivors the bound needs $-19.64468$, $-7.18323$, $-33.26116$ | **CONFIRMED**, reproduced to all five digits |
| 7 | the bound excludes none of them and is redundant | **CONFIRMED as to the three points, with the general reading resting on an argument the block does not give** |
| 8 | R28's mechanism has no first-order and no second-order lever left at $\lvert J\rvert=3$ | **PLAUSIBLE**, it needs a completeness premise that claims 1 to 7 do not supply |

## Claims 1, 2 and 3: the first order, and why it is vacuous

**Claim 1 is immediate and needs no criticality.** $\lambda\hat U$ and $\kappa V$ are traceless symmetric because $\hat U$ and $V$ are, and $3\mathop{\mathrm{tr}}(\hat UX)+\mathop{\mathrm{tr}}(VY)=3\lambda\mathop{\mathrm{tr}}\hat U^2+\kappa\mathop{\mathrm{tr}}V^2=3\lambda n_U+\kappa n_V=0$ by hypothesis. The one thing it uses beyond substitution is $\lvert M\rvert^2=\mathop{\mathrm{tr}}M^2$, which holds because both matrices are symmetric. Batch 21 quantifies over all such pairs, so it applies with nothing added.

**Claim 2 is correct, and the equality is the stationarity condition times a positive number.** Writing $\hat U\mapsto s\hat U$, $V\mapsto tV$ gives $\Phi=\alpha s^3p_3+\beta st^2q+s\langle\hat U,A\rangle+t\langle V,C\rangle$, and with $a=s\lvert\hat U\rvert$, $b=t\lvert V\rvert$ the condition $b\,\partial_a\Phi=3a\,\partial_b\Phi$ at $s=t=1$ reads

$$\frac{\lvert V\rvert}{\lvert\hat U\rvert}\big(3\alpha p_3+\beta q+\langle\hat U,A\rangle\big)=\frac{3\lvert\hat U\rvert}{\lvert V\rvert}\big(2\beta q+\langle V,C\rangle\big),$$

which is the displayed equality multiplied by $3\lvert\hat U\rvert\lvert V\rvert$. I checked the ratio symbolically over generic symmetric traceless $\hat U,V$ and generic symmetric fields, and it returns exactly $3\lvert\hat U\rvert\lvert V\rvert$. Since that factor is positive whenever both norms are nonzero, the two statements are equivalent and neither direction is lost. **The constraint is what makes $b\,\partial_a=3a\,\partial_b$ the right condition**: $\nabla(3a^2+b^2)=(6a,2b)$, so proportionality of $\nabla\Phi$ to it is $\partial_a\Phi/6a=\partial_b\Phi/2b$.

**Claim 3 is confirmed, and the block understates it in two ways.**

- **The two pairings are identities in the definitions of $A$ and $C$, not consequences of criticality.** With $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$ one has $\langle\hat U,A\rangle=3\mu n_U-3\alpha p_3-\beta q$ directly, the multiple of $I$ dropping because $\hat U$ is traceless, and with $C\equiv\mu V-\beta\{\hat U,V\}$ one has $\langle V,C\rangle=\mu n_V-2\beta q$. I verified both symbolically over generic symmetric traceless $\hat U,V$ with the shifts $c_1I$, $c_2I$ carried. So the first-order trade condition holds wherever the fields take their Lagrange forms, which is the whole of the critical set, with no further hypothesis.
- **The vacuity is structural rather than a coincidence of $\alpha$ and $\beta$.** The trade is a one-parameter subfamily of the admissible variations and its tangent at the base point is exactly $X=\lambda\hat U$, $Y=\kappa V$, the pair of claim 1. Criticality is stationarity along *every* admissible tangent, so it implies stationarity along this one. Read that way, the first order of the trade is batch 20's two pairings contracted against $(\lambda,\kappa)$, and there was never a computation to be done.

**What the claim needs and the block does not say**: both divisions require $n_U\ne0$ and $n_V\ne0$. At $V=0$ the trade has no second direction and the displayed equality is not defined, so the vacuity statement is about critical points with both blocks nonzero.

**The control that the vacuity is the substitution's doing.** With generic symmetric fields in place of the Lagrange forms the displayed equality is *not* an identity, which I checked in the same run. This is the same test the record calls post F69, and the trade passes it in the same direction the orbit did.

## Claim 4: the elimination, and the gap the brief names

**The elimination is exact.** Substituting $\kappa=-3\lambda n_U/n_V$ and $T=(3n_U+n_V)/2$ into $6\alpha\lambda^2p_3+4\beta\lambda\kappa q+2\beta\kappa^2q-\mu(3\lambda^2n_U+\kappa^2n_V)$ gives $(6\lambda^2/n_V^2)\big[\alpha p_3n_V^2+\beta qn_U(3n_U-2n_V)-\mu Tn_Un_V\big]$, confirmed in sympy and by hand. The factor $6\lambda^2/n_V^2$ is strictly positive for $\lambda\ne0$, so the inequality's direction is preserved. **At $\lambda=0$ the factor vanishes and the tangency forces $\kappa=0$ too**, so the excluded case is the zero direction, where batch 21 says nothing. This matches [radial_elimination](../lean/HamiltonsCubic/Results/I106Criticality.lean) exactly, including its hypotheses `hnV`, `htan` and `hT`.

**The brief's named gap is real as an untyped step and misdescribed as an obstacle.** The brief says the step from batch 21's trace expression to `radial_elimination`'s left side "is a substitution of traces needing cyclicity, the same obstacle that leaves `orbit_equals_batch21` standing with a named `sorry`". **It needs no cyclicity.** Every trace in batch 21 becomes the corresponding defining trace with a scalar pulled out, in the same word order:

| batch 21 term | at $X=\lambda\hat U$, $Y=\kappa V$ | what it uses |
|---|---|---|
| $\mathop{\mathrm{tr}}(\hat UX^2)$ | $\lambda^2\mathop{\mathrm{tr}}(\hat U\hat U\hat U)=\lambda^2p_3$ | scalar homogeneity |
| $\mathop{\mathrm{tr}}(XVY)$ | $\lambda\kappa\mathop{\mathrm{tr}}(\hat UVV)=\lambda\kappa q$ | scalar homogeneity |
| $\mathop{\mathrm{tr}}(\hat UY^2)$ | $\kappa^2\mathop{\mathrm{tr}}(\hat UVV)=\kappa^2q$ | scalar homogeneity |
| $\lvert X\rvert^2$, $\lvert Y\rvert^2$ | $\lambda^2n_U$, $\kappa^2n_V$ | symmetry, for $\lvert M\rvert^2=\mathop{\mathrm{tr}}M^2$ |

No factor is ever moved around a trace. I confirmed the whole substitution symbolically as an identity of polynomials in the entries. **The contrast with `orbit_equals_batch21` is the point**: there $X=[W,\hat U]$ and $Y=[W,V]$ are *different* matrices from $\hat U$ and $V$, so collapsing the $\beta$ terms genuinely needs $\mathop{\mathrm{tr}}(XYV)=\mathop{\mathrm{tr}}(XVY)$ and the symmetry behind it. Here they are multiples, and the step is a `simp` over scalar multiplication. **So the recommendation is to type it rather than to record it as a gap**: the missing declaration is a few lines, and pairing it with the orbit's `sorry` overstates what is open by putting a routine step in the same class as a real one. The only hypothesis it carries is symmetry of $\hat U$ and $V$, which the setting states.

## Claims 5 and 6: what the bound says, and the numbers

**Claim 5 follows from claim 4 on dividing by $6\lambda^2/n_V^2$ and by $Tn_Un_V$.** The second divisor is positive because $n_U,n_V>0$ force $T=(3n_U+n_V)/2>0$, so the inequality's sense is kept and the bound is exactly as displayed.

**The trade gives one inequality and not two.** The bracket is homogeneous of degree two in $\lambda$, so $\lambda$ and $-\lambda$ give the same statement, and no equality can be extracted the way a first-order condition would give one. This is what makes it a lower bound on $\mu$ rather than a relation among $p_3$, $q$ and the norms.

**Claim 6 reproduces, to every digit printed.** I rebuilt each point rather than taking the figures: the spectrum $u$ with $u_3=-u_1-u_2$, $V$ in the shape the criticality system leaves it, $\mu$ a root of the eliminated quadratic, and the two remaining entries solved from the entry relations. **The control that each is a critical point of the block problem** is $\lVert[A,C]\rVert$ with $A$ and $C$ built from my own reconstructed matrices by the brief's definitions.

| point | $\mu$ | $n_U$ | $n_V$ | $p_3$ | $q$ | $T$ | threshold | $\lVert[A,C]\rVert$ |
|---|---|---|---|---|---|---|---|---|
| $(1,-3,2)$ | $11.60060$ | $14$ | $314.48113$ | $-18$ | $472.72945$ | $178.24056$ | $-19.64468$ | $2\cdot10^{-12}$ |
| $(-1,-3,4)$ | $24.43870$ | $26$ | $1212.99686$ | $36$ | $2510.72743$ | $645.49843$ | $-7.18323$ | $8\cdot10^{-12}$ |
| $(19,-20,1)$ | $762.38453$ | $762$ | $698076.78997$ | $-1140$ | $1720831.59853$ | $350181.39498$ | $-33.26116$ | $2\cdot10^{-7}$ |

All three thresholds agree with the block. Each point is non-commuting, $\lVert[\hat U,V]\rVert$ being $7.2111$, $12.1655$ and $39.1152$. **Provenance, stated plainly**: the shape of $V$ and the eliminated quadratic I took from [screen_I106_orbit.py](../scripts/misc/screen_I106_orbit.py), batch 33's screen, since the criticality system itself is not in my brief. I did not open the script under review, and every quantity in the table above I computed from the reconstructed matrices by the brief's own definitions, so the residual column is an independent check that the parametrisation produced genuine critical points.

**Two thresholds in the brief's batch 35 given do not match my reconstruction.** The given says "Batch 18 needs $\mu\ge9.3675$ at the first and batch 21 needs $\mu\ge15$". I compute batch 18's $2\beta\lvert\hat U\rvert/\sqrt6$ as $6.8739$, $9.3675$ and $50.7124$ across the three, so $9.3675$ belongs to $(-1,-3,4)$ and not to $(1,-3,2)$, and batch 21's specialisation $\alpha\lvert u_{\min}\rvert$ as $11.25$, $11.25$ and $75$, which produces no $15$ at any of the three. The value $15$ is $\alpha\cdot4$, which would be $\alpha u_{\max}$ at the second point. **Nothing in claims 1 to 8 turns on this**, since every threshold is positive and every $\mu$ clears every reading of it, but the sentence attaches the second point's numbers to the first and should be corrected wherever it is recorded.

## Claim 7: the reach, which is the block's weakest link and its best available one

**At the three points the claim is right**, every threshold being negative against a large positive $\mu$.

**The block's stated ground does not support the general reading.** The threshold is not sign-definite. Screening it on configurations I constructed for the purpose, at $\hat U=\mathop{\mathrm{diag}}(2,-1,-1)$ with $V=\varepsilon\hat U$ it is $+3.00$, $+4.33$, $+4.48$ and $+4.498$ as $\varepsilon$ runs $1,0.3,0.1,0.03$, approaching $2\beta=4.5$, which is batch 18's own value at that configuration, the point where the record records batch 18's constant as sharp. So "its threshold is NEGATIVE, so it excludes nothing" is a fact about the three points and reads as a fact about the bound. *That is a screen on constructed objects and not evidence about critical points.*

**The general statement is nevertheless true, by an argument the block does not give.** The radial pair is one admissible tangent inside batch 21's quantifier, which is claim 1. Batch 21's full condition therefore implies the trade bound at every point where batch 21 holds, so **the trade bound can exclude no configuration that batch 21's full condition does not already exclude**, everywhere and not merely at the three survivors. This is the same upgrade the record applied to batch 33's orbit, and it makes the redundancy a theorem and demotes the three-point table to a confirmation.

**So the wording both overstates and understates.** It claims generality on evidence that is local, and it leaves on the table the one-line containment argument that gives the generality outright. **The fix is to lead with containment** and keep the three thresholds as the screen that the containment is not vacuous in practice. Stated that way the block needs no numbers at all for its conclusion.

**One thing the containment does not settle**, and I did not run it: whether the trade bound is ever *strictly stronger than batch 18*, which the screen above leaves open by approaching $4.5$ from below without reaching it. That is a sweep over a parameter range, so it waits. It bears on nothing in claims 1 to 8, since containment already closes the lever question, and I record it only so the open edge is visible.

## Claim 8: the route

**It does not follow from claims 1 to 7 alone.** Claims 1 to 7 close one direction, the radial one. Reading [routes.md](../routes.md), R28's row rests on three further things: piece 2's first order being emptied by batch 20's $V$ equation and its second order being batch 21 at $X=0$, both fenced in an earlier round I did not audit, piece 3 being empty, and the implicit premise that **the directions R28's mechanism supplies are exhausted by $X=0$, the orbit direction and the radial direction**. That last is a completeness claim about an enumeration, it is not a proposition about the configuration space, and nothing in claims 1 to 7 establishes it. **Verdict PLAUSIBLE**, and what it needs named is that premise.

**Batch 21's full quantifier remains unexploited, and that is the honest boundary.** Every closed lever so far is a *specialisation* of batch 21 at a named direction. Batch 21 itself is not closed, so the defensible sentence is that R28's mechanism has no lever left *among the directions it supplies*, rather than that no second-order lever remains at $\lvert J\rvert=3$.

**A finding for the route, outside the claims.** The record's lesson from batch 33 is that "a direction that leaves the internal part invariant can only see the fields, so a joint direction that closes the node must move the internal part". **The radial direction moves the internal part** and closes anyway: along the trade the internal part varies as $\alpha s^3p_3+\beta st^2q$, whose derivative in the direction $(\lambda,\kappa)$ is $3\alpha\lambda p_3+\beta(\lambda+2\kappa)q$, generically nonzero. So moving the internal part is necessary and **not** sufficient, and the lesson should be re-recorded as a necessary condition. The reason the trade closes is different from the reason the orbit closed: the orbit died because its first order was an identity and its second order was contained in batch 21, while the trade's first order is an identity for the structural reason of claim 3 and its second order is contained in batch 21 for the reason of claim 1. **What both share is containment**, and containment is what a successor direction has to escape, which means a direction not expressible through the pair $(\hat U,V)$ and a skew generator.

## Corrections to apply

1. **Strike the cyclicity analogy under claim 4.** The radial trace substitution needs no cyclicity and is not in the class of `orbit_equals_batch21`'s `sorry`. Type it, or say that it is typeable in a few lines over scalar multiplication, with symmetry the only hypothesis.
2. **Lead the redundancy with containment.** The radial pair is inside batch 21's quantifier, so the bound provably excludes nothing batch 21 does not, everywhere. Keep the three thresholds as a screen and drop any reading of "its threshold is negative" as a general property, which the sign screen above refutes.
3. **Record the divisions' hypotheses in claim 3**, namely $n_U\ne0$ and $n_V\ne0$, and record that the two pairings are identities in the definitions of $A$ and $C$, so the first order is vacuous at every critical point carrying both blocks nonzero and by a structural reason rather than a computation.
4. **Correct the batch 35 thresholds** wherever the sentence is recorded: batch 18 gives $6.8739$ at $(1,-3,2)$ and $9.3675$ at $(-1,-3,4)$, and batch 21's recorded specialisation gives $11.25$ at both, with no $15$ among them.
5. **Soften claim 8 to the directions R28's mechanism supplies**, and record the completeness premise it rests on, batch 21's full quantifier being open.
6. **Re-record batch 33's lesson as necessary and not sufficient**, the radial direction moving the internal part and closing anyway.

## What I did not run

A sweep asking whether the trade threshold is ever strictly above batch 18's, and any census over spectra. Both are open-ended under the analysis-only footing and neither changes a verdict here.
